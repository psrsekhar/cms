# CMS

College Management System

# CMS Database Schema and Functionality

This document provides an overview of the database schema and functionality for a College Management System (CMS) designed for a university environment. The CMS manages information related to departments, employees, students, books, and book transactions. The database schema includes table structures, relationships, and stored procedures for managing book transactions.

# CMS Database Setup

This `README.md` provides instructions for setting up the CMS (Content Management System) database, including the creation of the database, tables, indexes, stored procedures, and sample data insertion.

## Table of Contents

1. [Database Creation](#database-creation)
2. [Table Definitions](#table-definitions)
   - [Department Table](#department-table)
   - [Employee Table](#employee-table)
   - [Users Table](#users-table)
   - [Student Table](#student-table)
   - [Book Table](#book-table)
   - [Book Transactions Table](#book-transactions-table)
   - [Student Semesters Table](#student-semesters-table)
   - [Student Marks Table](#student-marks-table)
3. [Indexes](#indexes)
4. [Stored Procedures](#stored-procedures)
   - [Insert Book Transaction if Eligible](#insert-book-transaction-if-eligible)
   - [Update Book Transaction](#update-book-transaction)
5. [Sample Data Insertion](#sample-data-insertion)

## Prerequisites

1. **MySQL Installation**

   - Download and install MySQL: [MySQL Downloads](https://dev.mysql.com/downloads/).
   - Ensure that MySQL server is running.

2. **MySQL Client or Workbench**
   - You should have access to either the MySQL command line interface (CLI) or MySQL Workbench.

## SQL Schema Overview

The `cms.sql` file creates a database schema for managing:

- Departments, Employees, and Students.
- Books and Book Transactions.
- User authentication and roles.

### Main Tables:

- `department`: Stores department information.
- `employee`: Stores employee data, including salary and experience.
- `users`: Manages users with credentials.
- `student`: Stores student data.
- `book`: Manages books in the library.
- `book_transactions`: Tracks the borrowing and returning of books.

### Additional Tables:

- `student_semisters`: Handles student semester data.
- `student_marks`: Stores marks for each student across different subjects.

### Stored Procedures:

- `insert_book_transaction_if_eligible`: Manages book borrowing eligibility for students.
- `update_book_transaction`: Updates the book return details and calculates fines for late returns or damaged/lost books.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

- Fork the repository.
- Create a new branch (git checkout -b feature/YourFeature).
- Make and commit your changes (git commit -m 'Add some feature').
- Push to the branch (git push origin feature/YourFeature).
- Open a pull request.

## Acknowledgments

We would like to thank the following resources and communities for their support in the development of the College Management System:

- [MySQL Official Documentation](https://dev.mysql.com/doc/) – For thorough tutorials and documentation on managing databases and integrating with Spring Data JPA.

Special thanks to the open-source community and all contributors who have helped build the tools and libraries that made this project possible.
