# College Management System

## Overview

The **College Management System** is a web application built using Spring Boot, ReactJS, and MySQL to manage various administrative and academic tasks within a college. It provides features such as student management, course management, attendance tracking, and more.

## Features

- **Student Management**: Add, update, and manage student information.
- **Course Management**: Manage courses and assignments.
- **Faculty Management**: Manage faculty and course assignments.
- **Attendance Tracking**: Record and monitor student attendance.
- **Exam Management**: Schedule and manage exams, and track results.

## Technologies Used

- **Database**:
  - **MySQL**: Relational database management system for storing data.
- **Backend**:
  - **Spring Boot**: Java framework for creating RESTful APIs.
- **Frontend**:
  - **ReactJS**: JavaScript library for building dynamic user interfaces.
  - **Bootstrap**: CSS framework for responsive and styled UI components.

## Prerequisites

- **Java 11** or higher
- **Maven**: Build tool for dependency management
- **MySQL**: Database system
- **Node.js** and **npm**: For frontend setup

## Creating the Spring Boot Project

### Step 1: Visit Spring Initializr

Go to the [Spring Initializr](https://start.spring.io/) to create your Spring Boot project.

### Step 2: Project Configuration

1. **Project**: Choose **Maven Project**.
2. **Language**: Choose **Java**.
3. **Spring Boot Version**: Select the latest stable version (e.g., `3.x.x`).
4. **Project Metadata**:
   - **Group**: Enter your package name (e.g., `edu.college`).
   - **Artifact**: Enter your project name (e.g., `cms`).
   - **Name**: Enter a name for your project (e.g., `College Management System`).
   - **Description**: Provide a brief description (e.g., `A web application for managing college management`).
   - **Package name**: Leave as is or customize based on your need.
   - **Packaging**: Select **Jar**.
   - **Java Version**: Choose **11** or higher.

### Step 3: Add Dependencies

Under **Dependencies**, add the following:

1. **Spring Web**: To create REST APIs.
2. **Spring Data JPA**: For database access using Java Persistence API (JPA).
3. **MySQL Driver**: For MySQL database connectivity.
4. **Spring Boot DevTools**: For automatic application restart during development (optional but recommended).

### Step 4: Generate the Project

Once all the configurations are set, click the **Generate** button. This will download a ZIP file containing your Spring Boot project.

### Step 5: Import the Project into Your IDE

1. Extract the downloaded ZIP file.
2. Open your favorite IDE (e.g., IntelliJ IDEA, Eclipse, or VSCode).
3. Import the project as a **Maven** project:
   - In IntelliJ IDEA: `File` -> `New` -> `Project from Existing Sources...` and select the project directory.
   - In Eclipse: `File` -> `Import` -> `Existing Maven Projects`.
   - In VSCode: Open the folder containing the project.

### Step 6: Configure Application Properties

1. Navigate to `src/main/resources/application.properties` or `application.yml` and add the following database configuration for MySQL:
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/cms
   spring.datasource.username=root
   spring.datasource.password=your_password
   spring.jpa.hibernate.ddl-auto=update
   spring.jpa.show-sql=true
   ```

### Step 7: Run the Application

To run the Spring Boot application:

1. **Using an IDE:**

   - Navigate to the main application file, typically named `CmsApplication.java` (located in `src/main/java/com/example/cms` package).
   - Right-click the file and select **Run**.
   - Alternatively, use the **Run** button in your IDE.

2. **Using the Command Line:**

   - Open a terminal and navigate to the project directory.
   - Run the following Maven command to start the application:
     ```bash
     ./mvnw spring-boot:run
     ```

3. **Verify the Application is Running:**
   - Open a browser and navigate to `http://localhost:8080`.
   - If everything is configured correctly, the Spring Boot application will be running and ready to serve API requests.

### Step 8: Testing the API Endpoints

Once your Spring Boot application is running, you can test the API endpoints using tools like **Postman**, **Insomnia**, or **cURL**. Below are the common API endpoints available in the College Management System.

#### 1. **Get All Students**

- **Method**: `GET`
- **URL**: `http://localhost:8080/api/students`

#### 2. **Add a New Student**

- **Method**: `POST`
- **URL**: `http://localhost:8080/api/students`

#### 3. **Get a Specific Student by ID**

- **Method**: `GET`
- **URL**: `http://localhost:8080/api/students/{id}`

#### 4. **Update a Student**

- **Method**: `PUT`
- **URL**: `http://localhost:8080/api/students/{id}`

#### 5. **Delete a Student**

- **Method**: `DELETE`
- **URL**: `http://localhost:8080/api/students/{id}`

#### 6. **Get All Courses**

- **Method**: `GET`
- **URL**: `http://localhost:8080/api/courses`

#### 7. **Add a New Course**

- **Method**: `POST`
- **URL**: `http://localhost:8080/api/courses`

#### 8. **Get a Specific Course by ID**

- **Method**: `GET`
- **URL**: `http://localhost:8080/api/courses/{id}`

#### 9. **Update a Course**

- **Method**: `PUT`
- **URL**: `http://localhost:8080/api/courses/{id}`

#### 10. **Delete a Course**

- **Method**: `DELETE`
- **URL**: `http://localhost:8080/api/courses/{id}`

Use these endpoints to interact with the College Management System backend and verify that the functionality is working as expected.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

- Fork the repository.
- Create a new branch (git checkout -b feature/YourFeature).
- Make and commit your changes (git commit -m 'Add some feature').
- Push to the branch (git push origin feature/YourFeature).
- Open a pull request.

## Acknowledgments

We would like to thank the following resources and communities for their support in the development of the College Management System:

- [Spring Boot Official Documentation](https://spring.io/guides) – For providing comprehensive guides and best practices for building RESTful APIs using Spring Boot.
- [Stack Overflow](https://stackoverflow.com/) – For its invaluable community-driven problem-solving that assisted throughout the development process.

Special thanks to the open-source community and all contributors who have helped build the tools and libraries that made this project possible.
