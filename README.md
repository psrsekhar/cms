# cms
College Management System

# CMS Database Schema and Functionality

This document provides an overview of the database schema and functionality for a Content Management System (CMS) designed for a university environment. The CMS manages information related to departments, employees, students, books, and book transactions. The database schema includes table structures, relationships, and stored procedures for managing book transactions.

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
