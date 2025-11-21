# University Course Management System - SQL Final Project

## 📌 Introduction
This project focuses on the design and implementation of a **University Course Management System** database. The objective is to synthesize broad SQL concepts into a functional database that manages data related to students, courses, instructors, enrollments, and departments.

This repository contains the SQL scripts required to create the database schema, populate it with sample data, and execute complex queries ranging from basic CRUD operations to advanced window functions.

------------------------------------------------------------------------

## 📑 Database Schema
The system consists of the following five relational tables:
* **Students:** Stores personal and enrollment details of students.
* **Courses:** Stores course names, credits, and department associations.
* **Instructors:** Manages instructor details and their departments.
* **Enrollments:** A junction table linking Students and Courses with enrollment dates.
* **Departments:** Stores academic department information.

------------------------------------------------------------------------

## 📖 SQL Functions & Concepts Used
This project demonstrates a wide variety of SQL capabilities as required by the project assessment.
### Core Operations
* **DDL (Data Definition Language):** `CREATE TABLE`, `CREATE DATABASE`.
* **DML (Data Manipulation Language):** `INSERT`, `UPDATE`, `DELETE`.
* **Constraints:** `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `NOT NULL`.

------------------------------------------------------------------------

## ⁉️ Advanced Querying Techniques
* **Joins:**
    * `INNER JOIN`: To combine students, courses, and departments.
    * `LEFT JOIN`: To list all students regardless of enrollment status.
* **Set Operations:**
    * `UNION`: To combine results for students in specific courses.
* **Aggregations & Grouping:**
    * `COUNT`, `AVG`, `MAX`.
    * `GROUP BY` and `HAVING` clauses to filter aggregated data.
* **Subqueries:** Nested queries to find students in popular courses.

------------------------------------------------------------------------

## 🏗️ Built-in Functions
* **Date Functions:** `YEAR()`, `CURDATE()`.
* **String Functions:** `CONCAT()` to combine names.
* **Window Functions:** `OVER (ORDER BY ...)` for running totals.
* **Control Flow:** `CASE` expression for conditional logic (Senior vs. Junior labeling).

------------------------------------------------------------------------

## 🚀 How to Run This Project

### Prerequisites
* A MySQL-compatible database server (e.g., MySQL Workbench, MariaDB, or DBeaver).

### Installation Steps
1.  **Clone the Repository:**
    Download this repository to your local machine.
2.  **Open your SQL Editor:**
    Open your preferred SQL client.
3.  **Execute Table Creation:**
    Copy and paste the script to create the database and tables.
    > **Note:** Ensure `Departments` is created before `Courses` or `Instructors` to satisfy Foreign Key constraints.
4.  **Insert Data:**
    Run the `INSERT INTO` statements provided in the script to populate the tables.
5.  **Run Analysis Queries:**
    Execute the numbered queries (1-16) individually to see the results of the analysis tasks.

------------------------------------------------------------------------

## 📂 Files Included

-   `README.md` (you are reading it)
-   SQL script
-   output

------------------------------------------------------------------------