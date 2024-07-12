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

## Database Creation

This section provides instructions for creating the `cms` database and setting up its initial structure.

### Step 1: Create the Database

To create the `cms` database if it does not already exist, run the following SQL command:

```sql
CREATE DATABASE IF NOT EXISTS cms;

USE cms;

## Department Table

The `department` table stores information about the different departments within the CMS (Content Management System). This section explains the table's structure and how to create it.

### Table Structure

The `department` table has the following structure:

| Column Name | Data Type        | Constraints                | Description                           |
|-------------|------------------|----------------------------|---------------------------------------|
| `id`         | `INT`             | `AUTO_INCREMENT, PRIMARY KEY` | Unique identifier for each department. |
| `name`       | `VARCHAR(100)`    | `NOT NULL, UNIQUE`         | Name of the department.                |

### Create the Department Table

To create the `department` table, use the following SQL command:

```sql
CREATE TABLE IF NOT EXISTS department (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

