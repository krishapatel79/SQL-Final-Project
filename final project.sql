CREATE DATABASE final_project;
use final_project;

#--------- table 1 : department ----------#
CREATE TABLE Departments ( DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(100));
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics');
SELECT * FROM Departments;

#--------- table 1 : students ----------#
CREATE TABLE Students (StudentID INT PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), Email VARCHAR(100), BirthDate DATE,
    EnrollmentDate DATE );
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '1999-05-25', '2021-08-01');
SELECT * FROM Students;

#--------- table 2 : courses ----------#
CREATE TABLE Courses (CourseID INT PRIMARY KEY, CourseName VARCHAR(100) NOT NULL, DepartmentID INT, Credits INT CHECK (Credits > 0),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));
INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4);
SELECT * FROM Courses;

#--------- table 3 : instructors ----------#
CREATE TABLE Instructors (InstructorID INT PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), Email VARCHAR(100),DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));
INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2);
SELECT * FROM Instructors;

#--------- table 4 : enrollment ----------#
CREATE TABLE Enrollments (EnrollmentID INT PRIMARY KEY, StudentID INT, CourseID INT, EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID));
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01');
SELECT * FROM Enrollments;

#----- CRUD Operations --------#
## 1. Perform CRUD Operations on all tables. ##
INSERT INTO Students (StudentID, FirstName, LastName, Email, BirthDate, EnrollmentDate) VALUES (3, 'Charlie', 'Brown', 'charlie.b@email.com', '2001-10-10', '2023-01-15');
SELECT StudentID, FirstName, LastName, EnrollmentDate FROM Students;
UPDATE Students SET Email = 'charlie.brown@email.com' WHERE StudentID = 3;
DELETE FROM Students WHERE StudentID = 3; 

## 2. Retrieve students who enrolled after 2022. ##
SELECT StudentID, FirstName, LastName, EnrollmentDate
FROM Students
WHERE EnrollmentDate > '2022-12-31';

## 3. Retrieve courses offered by the Mathematics department with a limit of 5 courses. ##
SELECT T1.CourseName, T2.DepartmentName
FROM Courses AS T1
JOIN Departments AS T2 ON T1.DepartmentID = T2.DepartmentID
WHERE T2.DepartmentName = 'Mathematics'
LIMIT 5;

## 4. Get the number of students enrolled in each course, filtering for courses with more than 5 students. ##
SELECT T2.CourseName, COUNT(T1.StudentID) AS TotalEnrollments
FROM Enrollments AS T1
JOIN Courses AS T2 ON T1.CourseID = T2.CourseID
GROUP BY T2.CourseName
HAVING COUNT(T1.StudentID) > 5;  

## 7. Calculate the average number of credits for all courses.##
SELECT AVG(Credits) AS AverageCourseCredits FROM Courses;

## 8. Find the maximum salary of instructors in the Computer Science department.##
ALTER TABLE Instructors ADD Salary DECIMAL(10,2);
UPDATE Instructors SET Salary = 80000 WHERE InstructorID = 1;
UPDATE Instructors SET Salary = 70000 WHERE InstructorID = 2;
SELECT MAX(T1.Salary) AS MaxCSInstructorSalary 
FROM Instructors AS T1 JOIN Departments AS T2 ON T1.DepartmentID = T2.DepartmentID 
WHERE T2.DepartmentName = 'Computer Science';
 
##  9. Count the number of students enrolled in each department.##
SELECT T3.DepartmentName, COUNT(DISTINCT T1.StudentID) AS StudentsInDepartment 
FROM Enrollments AS T1 JOIN Courses AS T2 ON T1.CourseID = T2.CourseID JOIN Departments AS T3 ON T2.DepartmentID = T3.DepartmentID 
GROUP BY T3.DepartmentName; 

## 5. Find students who are enrolled in both Introduction to SQL and Data Structures.##
SELECT T1.StudentID, T1.FirstName, T1.LastName FROM Students AS T1
INNER JOIN Enrollments AS E1 ON T1.StudentID = E1.StudentID
INNER JOIN Courses AS C1 ON E1.CourseID = C1.CourseID AND C1.CourseName = 'Introduction to SQL'   
INNER JOIN Enrollments AS E2 ON T1.StudentID = E2.StudentID
INNER JOIN Courses AS C2 ON E2.CourseID = C2.CourseID AND C2.CourseName = 'Data Structures';

## 6. Find students who are either enrolled in Introduction to SQL or Data Structures. (UNION Logic)##
SELECT T1.StudentID, T1.FirstName, T1.LastName 
FROM Students AS T1 JOIN Enrollments AS T2 ON T1.StudentID = T2.StudentID JOIN Courses AS T3 ON T2.CourseID = T3.CourseID 
WHERE T3.CourseName = 'Introduction to SQL' 
UNION 
SELECT T1.StudentID, T1.FirstName, T1.LastName 
FROM Students AS T1 JOIN Enrollments AS T2 ON T1.StudentID = T2.StudentID JOIN Courses AS T3 ON T2.CourseID = T3.CourseID 
WHERE T3.CourseName = 'Data Structures'; 

## 10. INNER JOIN: Retrieve students and their corresponding courses.##
SELECT T1.FirstName, T1.LastName AS StudentName, T2.CourseName 
FROM Students AS T1 INNER JOIN Enrollments AS T3 ON T1.StudentID = T3.StudentID 
INNER JOIN Courses AS T2 ON T3.CourseID = T2.CourseID;

## 11. LEFT JOIN: Retrieve all students and their corresponding courses, if any.##
SELECT T1.FirstName, T1.LastName AS StudentName, T2.CourseName 
FROM Students AS T1 LEFT JOIN Enrollments AS T3 ON T1.StudentID = T3.StudentID 
LEFT JOIN Courses AS T2 ON T3.CourseID = T2.CourseID; 

## 12. Subquery: Find students enrolled in courses that have more than 10 students.##
SELECT T1.StudentID, T1.FirstName, T1.LastName FROM Students AS T1 
WHERE T1.StudentID IN ( SELECT StudentID FROM Enrollments 
WHERE CourseID IN ( SELECT CourseID FROM Enrollments GROUP BY CourseID HAVING COUNT(StudentID) > 10 ));

## 13. Extract the year from the EnrollmentDate of students.##
SELECT FirstName, LastName, EnrollmentDate, YEAR(EnrollmentDate) AS EnrollmentYear FROM Students; 

## 14. Concatenate the instructor first and last name.##
SELECT InstructorID, CONCAT(FirstName, ' ', LastName) AS FullName FROM Instructors;

## 15. Calculate the running total of students enrolled in courses. (Window Function)##
SELECT T1.EnrollmentID, T1.StudentID, T1.EnrollmentDate, COUNT(T1.StudentID) 
OVER (ORDER BY T1.EnrollmentDate, T1.EnrollmentID) AS RunningTotalEnrollments FROM Enrollments AS T1;

## 16. Label students as 'Senior' or 'Junior' based on their year of enrollment. (CASE Expression)##
SELECT StudentID, FirstName, LastName, EnrollmentDate, 
CASE 
    WHEN (YEAR(CURDATE()) - YEAR(EnrollmentDate)) >= 4 THEN 'Senior' 
    ELSE 'Junior' 
  END AS StudentStatus 
  FROM Students; 














