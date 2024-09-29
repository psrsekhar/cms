DROP DATABASE IF EXISTS cms;

CREATE DATABASE IF NOT EXISTS cms;
USE cms;

-- Create department table
CREATE TABLE IF NOT EXISTS department (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(100) NOT NULL
);

-- Create employee table
CREATE TABLE IF NOT EXISTS employee (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(250), 
    address TEXT, 
    doj DATE NOT NULL, 
    salary INT NOT NULL, 
    qualification TEXT NOT NULL, 
    departmentId INT NOT NULL, 
    experience INT NOT NULL, 
    FOREIGN KEY (departmentId) REFERENCES department(id) ON DELETE CASCADE
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    employeeId INT NOT NULL PRIMARY KEY, 
    userName VARCHAR(50) NOT NULL, 
    password TEXT NOT NULL, 
    addedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (employeeId) REFERENCES employee(id) ON DELETE CASCADE
);

-- Create student table
CREATE TABLE IF NOT EXISTS student (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(250), 
    address TEXT, 
    departmentId INT NOT NULL,
    FOREIGN KEY (departmentId) REFERENCES department(id) ON DELETE CASCADE
);

-- Create book table
CREATE TABLE IF NOT EXISTS book (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(100) NOT NULL, 
    author VARCHAR(250), 
    price INT NOT NULL, 
    available TINYINT NOT NULL DEFAULT 1, 
    edition TEXT NOT NULL, 
    addedBy INT NOT NULL, 
    logTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (addedBy) REFERENCES employee(id) ON DELETE CASCADE
);

-- Create book_transactions table
CREATE TABLE IF NOT EXISTS book_transactions (
    studentId INT NOT NULL, 
    bookId INT NOT NULL, 
    issuedDate DATE NOT NULL, 
    returnDate DATE DEFAULT NULL, 
    fine INT NOT NULL DEFAULT 0,
	isLostOrDamaged BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (studentId) REFERENCES student(id) ON DELETE CASCADE, 
    FOREIGN KEY (bookId) REFERENCES book(id) ON DELETE CASCADE
);

-- Create student_semister table
CREATE TABLE IF NOT EXISTS student_semisters (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    studentId INT NOT NULL,
    year INT NOT NULL CHECK (year BETWEEN 1 AND 4),
    semester INT NOT NULL CHECK (semester BETWEEN 1 AND 2),
    FOREIGN KEY (studentId) REFERENCES student(id) ON DELETE CASCADE
);


-- Create index for student_semister table on id column
CREATE INDEX semister_id_idx ON student_semisters(id);

-- Create student_marks table
CREATE TABLE IF NOT EXISTS student_marks (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    studentId INT NOT NULL,
    semisterId INT NOT NULL,
    firstSubject INT NOT NULL CHECK (firstSubject BETWEEN 0 AND 100),
    secondSubject INT NOT NULL CHECK (secondSubject BETWEEN 0 AND 100),
    thirdSubject INT NOT NULL CHECK (thirdSubject BETWEEN 0 AND 100),
    fourthSubject INT NOT NULL CHECK (fourthSubject BETWEEN 0 AND 100),
    fifthSubject INT NOT NULL CHECK (fifthSubject BETWEEN 0 AND 100),
    sixthSubject INT NOT NULL CHECK (sixthSubject BETWEEN 0 AND 100),
    firstLab INT NOT NULL CHECK (firstLab BETWEEN 0 AND 75),
    secondLab INT NOT NULL CHECK (secondLab BETWEEN 0 AND 75),
    FOREIGN KEY (studentId) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (semisterId) REFERENCES student_semisters(id) ON DELETE CASCADE
);

-- Create index for student_marks table on id, studentId, semisterId columns
CREATE INDEX student_semister_id_idx ON student_marks(id, studentId, semisterId);

-- Drop procedure if it exists
DROP PROCEDURE IF EXISTS insert_book_transaction_if_eligible;

DELIMITER //

CREATE PROCEDURE insert_book_transaction_if_eligible (
    IN studentId INT,
    IN bookId INT,
    IN issuedDate DATE
)
BEGIN
    DECLARE can_borrow BOOLEAN;

    -- Check eligibility to borrow (make sure there are no books currently borrowed by the student)
    SELECT COUNT(*) = 0 INTO can_borrow
    FROM book_transactions
    WHERE studentId = studentId 
      AND returnDate IS NULL;  -- Check if there are any unreturned books

    -- If eligible, insert into book_transactions table
    IF can_borrow THEN
        -- Insert into book_transactions
        INSERT INTO book_transactions (studentId, bookId, issuedDate)
        VALUES (studentId, bookId, issuedDate);

        -- Return true indicating successful insertion
        SELECT TRUE AS eligibility_status;
    ELSE
        -- Return false indicating not eligible
        SELECT FALSE AS eligibility_status;
    END IF;

END //

DELIMITER ;


-- Drop and recreate the procedure if it exists
DROP PROCEDURE IF EXISTS update_book_transaction;

DELIMITER //

CREATE PROCEDURE update_book_transaction (
    IN studentId INT,
    IN bookId INT,
    IN issuedDate DATE,
    IN returnDate DATE,
    IN isLostOrDamaged BOOLEAN
)
BEGIN
    DECLARE fine INT DEFAULT 0;
    DECLARE days_diff INT;
    DECLARE bookPrice INT;

    -- Calculate the difference in days between issuedDate and returnDate
    SET days_diff = DATEDIFF(returnDate, issuedDate);

    -- If book is lost or damaged, calculate fine accordingly
    IF isLostOrDamaged THEN
        -- Fetch the price of the book
        SELECT price INTO bookPrice FROM book WHERE id = bookId;

        -- Calculate fine for lost or damaged book
        SET fine = bookPrice + ((days_diff - 3) * 100);
    ELSE
        -- Calculate fine if days_diff is greater than 3
        IF days_diff > 3 THEN
            SET fine = (days_diff - 3) * 100; -- Fine for extra days
        END IF;
    END IF;

    -- Update the book transaction
    UPDATE book_transactions 
    SET returnDate = returnDate, fine = fine
    WHERE studentId = studentId AND bookId = bookId AND issuedDate = issuedDate;
    
END //

DELIMITER ;

INSERT INTO department (name) VALUES ('Computer Science and Engineering'),
('Electrical and Electronics Engineering'),
('Mechanical Engineering'),
('Civil Engineering'), 
('Electronics and Communication Engineering'),
('Information Technology'),
('Chemical Engineering'),
('Biomedical Engineering'),
('Aerospace Engineering'),
('Environmental Engineering');

INSERT INTO employee (name, email, address, doj, salary, qualification, departmentId, experience) VALUES
('John Doe', 'john.doe@cms.com', '123 Elm St, Springfield, IL', '2020-01-15', 60000, 'B.Tech', 1, 5),
('Jane Smith', 'jane.smith@cms.com', '456 Oak St, Springfield, IL', '2019-02-20', 65000, 'M.Tech', 2, 6),
('Robert Johnson', 'robert.johnson@cms.com', '789 Pine St, Springfield, IL', '2021-03-25', 62000, 'B.Tech', 3, 4),
('Emily Davis', 'emily.davis@cms.com', '101 Maple St, Springfield, IL', '2018-04-30', 63000, 'B.Tech', 4, 7),
('Michael Brown', 'michael.brown@cms.com', '202 Cedar St, Springfield, IL', '2020-05-10', 64000, 'M.Tech', 5, 5),
('Sarah Wilson', 'sarah.wilson@cms.com', '303 Birch St, Springfield, IL', '2017-06-15', 60000, 'B.Tech', 6, 8),
('David Moore', 'david.moore@cms.com', '404 Walnut St, Springfield, IL', '2021-07-20', 65000, 'M.Tech', 7, 3),
('Laura Taylor', 'laura.taylor@cms.com', '505 Ash St, Springfield, IL', '2019-08-25', 67000, 'B.Tech', 8, 6),
('James Anderson', 'james.anderson@cms.com', '606 Cherry St, Springfield, IL', '2018-09-30', 68000, 'Ph.D', 9, 9),
('Linda Thomas', 'linda.thomas@cms.com', '707 Dogwood St, Springfield, IL', '2020-10-05', 69000, 'M.Tech', 10, 7),
('Mark Jackson', 'mark.jackson@cms.com', '808 Elm St, Springfield, IL', '2021-11-10', 70000, 'B.Tech', 1, 5),
('Patricia White', 'patricia.white@cms.com', '909 Oak St, Springfield, IL', '2019-12-15', 72000, 'M.Tech', 2, 6),
('Charles Harris', 'charles.harris@cms.com', '1010 Pine St, Springfield, IL', '2018-01-20', 73000, 'B.Tech', 3, 4),
('Jennifer Martin', 'jennifer.martin@cms.com', '1111 Maple St, Springfield, IL', '2020-02-25', 74000, 'B.Tech', 4, 7),
('Paul Thompson', 'paul.thompson@cms.com', '1212 Cedar St, Springfield, IL', '2021-03-30', 75000, 'M.Tech', 5, 5),
('Barbara Garcia', 'barbara.garcia@cms.com', '1313 Birch St, Springfield, IL', '2019-04-05', 76000, 'B.Tech', 6, 8),
('Thomas Martinez', 'thomas.martinez@cms.com', '1414 Walnut St, Springfield, IL', '2018-05-10', 77000, 'M.Tech', 7, 3),
('Elizabeth Robinson', 'elizabeth.robinson@cms.com', '1515 Ash St, Springfield, IL', '2020-06-15', 78000, 'B.Tech', 8, 6),
('Christopher Clark', 'christopher.clark@cms.com', '1616 Cherry St, Springfield, IL', '2021-07-20', 79000, 'Ph.D', 9, 9),
('Susan Rodriguez', 'susan.rodriguez@cms.com', '1717 Dogwood St, Springfield, IL', '2019-08-25', 80000, 'M.Tech', 10, 7),
('Daniel Lewis', 'daniel.lewis@cms.com', '1818 Elm St, Springfield, IL', '2018-09-30', 81000, 'B.Tech', 1, 5),
('Margaret Lee', 'margaret.lee@cms.com', '1919 Oak St, Springfield, IL', '2020-10-05', 82000, 'M.Tech', 2, 6),
('Matthew Walker', 'matthew.walker@cms.com', '2020 Pine St, Springfield, IL', '2021-11-10', 83000, 'B.Tech', 3, 4),
('Dorothy Hall', 'dorothy.hall@cms.com', '2121 Maple St, Springfield, IL', '2019-12-15', 84000, 'B.Tech', 4, 7),
('Donald Allen', 'donald.allen@cms.com', '2222 Cedar St, Springfield, IL', '2018-01-20', 85000, 'M.Tech', 5, 5),
('Lisa Young', 'lisa.young@cms.com', '2323 Birch St, Springfield, IL', '2020-02-25', 86000, 'B.Tech', 6, 8),
('Joseph Hernandez', 'joseph.hernandez@cms.com', '2424 Walnut St, Springfield, IL', '2021-03-30', 87000, 'M.Tech', 7, 3),
('Karen King', 'karen.king@cms.com', '2525 Ash St, Springfield, IL', '2019-04-05', 88000, 'B.Tech', 8, 6),
('Steven Wright', 'steven.wright@cms.com', '2626 Cherry St, Springfield, IL', '2018-05-10', 89000, 'Ph.D', 9, 9),
('Betty Lopez', 'betty.lopez@cms.com', '2727 Dogwood St, Springfield, IL', '2020-06-15', 90000, 'M.Tech', 10, 7),
('George Hill', 'george.hill@cms.com', '2828 Elm St, Springfield, IL', '2021-07-20', 91000, 'B.Tech', 1, 5),
('Helen Scott', 'helen.scott@cms.com', '2929 Oak St, Springfield, IL', '2019-08-25', 92000, 'M.Tech', 2, 6),
('Edward Green', 'edward.green@cms.com', '3030 Pine St, Springfield, IL', '2018-09-30', 93000, 'B.Tech', 3, 4),
('Donna Adams', 'donna.adams@cms.com', '3131 Maple St, Springfield, IL', '2020-10-05', 94000, 'B.Tech', 4, 7);

INSERT INTO users (employeeId, userName, password) VALUES
(1, 'john.doe', MD5('password1')),
(2, 'jane.smith', MD5('password2')),
(3, 'robert.johnson', MD5('password3')),
(4, 'emily.davis', MD5('password4')),
(5, 'michael.brown', MD5('password5')),
(6, 'sarah.wilson', MD5('password6')),
(7, 'david.moore', MD5('password7')),
(8, 'laura.taylor', MD5('password8')),
(9, 'james.anderson', MD5('password9')),
(10, 'linda.thomas', MD5('password10')),
(11, 'mark.jackson', MD5('password11')),
(12, 'patricia.white', MD5('password12')),
(13, 'charles.harris', MD5('password13')),
(14, 'jennifer.martin', MD5('password14')),
(15, 'paul.thompson', MD5('password15')),
(16, 'barbara.garcia', MD5('password16')),
(17, 'thomas.martinez', MD5('password17')),
(18, 'elizabeth.robinson', MD5('password18')),
(19, 'christopher.clark', MD5('password19')),
(20, 'susan.rodriguez', MD5('password20')),
(21, 'daniel.lewis', MD5('password21')),
(22, 'margaret.lee', MD5('password22')),
(23, 'matthew.walker', MD5('password23')),
(24, 'dorothy.hall', MD5('password24')),
(25, 'donald.allen', MD5('password25')),
(26, 'lisa.young', MD5('password26')),
(27, 'joseph.hernandez', MD5('password27')),
(28, 'karen.king', MD5('password28')),
(29, 'steven.wright', MD5('password29')),
(30, 'betty.lopez', MD5('password30')),
(31, 'george.hill', MD5('password31')),
(32, 'helen.scott', MD5('password32')),
(33, 'edward.green', MD5('password33')),
(34, 'donna.adams', MD5('password34'));

INSERT INTO student (name, email, address, departmentId) VALUES
('Alice Johnson', 'alice.johnson@cms.com', '123 Main St, Springfield, IL', 1),
('Bob Smith', 'bob.smith@cms.com', '456 Oak St, Springfield, IL', 2),
('Charlie Brown', 'charlie.brown@cms.com', '789 Pine St, Springfield, IL', 3),
('David Wilson', 'david.wilson@cms.com', '101 Maple St, Springfield, IL', 4),
('Ella Davis', 'ella.davis@cms.com', '202 Cedar St, Springfield, IL', 5),
('Frank Miller', 'frank.miller@cms.com', '303 Birch St, Springfield, IL', 6),
('Grace Lee', 'grace.lee@cms.com', '404 Walnut St, Springfield, IL', 7),
('Henry Martin', 'henry.martin@cms.com', '505 Ash St, Springfield, IL', 8),
('Ivy Clark', 'ivy.clark@cms.com', '606 Cherry St, Springfield, IL', 9),
('Jack White', 'jack.white@cms.com', '707 Dogwood St, Springfield, IL', 10),
('Katie Harris', 'katie.harris@cms.com', '808 Elm St, Springfield, IL', 1),
('Liam Young', 'liam.young@cms.com', '909 Oak St, Springfield, IL', 2),
('Mia Allen', 'mia.allen@cms.com', '1010 Pine St, Springfield, IL', 3),
('Nathan King', 'nathan.king@cms.com', '1111 Maple St, Springfield, IL', 4),
('Olivia Scott', 'olivia.scott@cms.com', '1212 Cedar St, Springfield, IL', 5),
('Paul Adams', 'paul.adams@cms.com', '1313 Birch St, Springfield, IL', 6),
('Quinn Baker', 'quinn.baker@cms.com', '1414 Walnut St, Springfield, IL', 7),
('Rachel Green', 'rachel.green@cms.com', '1515 Ash St, Springfield, IL', 8),
('Sam Hill', 'sam.hill@cms.com', '1616 Cherry St, Springfield, IL', 9),
('Tina Wright', 'tina.wright@cms.com', '1717 Dogwood St, Springfield, IL', 10),
('Uma Walker', 'uma.walker@cms.com', '1818 Elm St, Springfield, IL', 1),
('Victor Hall', 'victor.hall@cms.com', '1919 Oak St, Springfield, IL', 2),
('Wendy Young', 'wendy.young@cms.com', '2020 Pine St, Springfield, IL', 3),
('Xavier Lee', 'xavier.lee@cms.com', '2121 Maple St, Springfield, IL', 4),
('Yara Lopez', 'yara.lopez@cms.com', '2222 Cedar St, Springfield, IL', 5),
('Zane Clark', 'zane.clark@cms.com', '2323 Birch St, Springfield, IL', 6),
('Aaron Green', 'aaron.green@cms.com', '2424 Walnut St, Springfield, IL', 7),
('Bella Adams', 'bella.adams@cms.com', '2525 Ash St, Springfield, IL', 8),
('Caleb Baker', 'caleb.baker@cms.com', '2626 Cherry St, Springfield, IL', 9),
('Diana Hall', 'diana.hall@cms.com', '2727 Dogwood St, Springfield, IL', 10),
('Ethan Wright', 'ethan.wright@cms.com', '2828 Elm St, Springfield, IL', 1),
('Fiona Young', 'fiona.young@cms.com', '2929 Oak St, Springfield, IL', 2),
('George King', 'george.king@cms.com', '3030 Pine St, Springfield, IL', 3),
('Hannah Scott', 'hannah.scott@cms.com', '3131 Maple St, Springfield, IL', 4),
('Ian Allen', 'ian.allen@cms.com', '3232 Cedar St, Springfield, IL', 5),
('Judy Baker', 'judy.baker@cms.com', '3333 Birch St, Springfield, IL', 6),
('Kyle Green', 'kyle.green@cms.com', '3434 Walnut St, Springfield, IL', 7),
('Lara Adams', 'lara.adams@cms.com', '3535 Ash St, Springfield, IL', 8),
('Mark Baker', 'mark.baker@cms.com', '3636 Cherry St, Springfield, IL', 9),
('Nina Hall', 'nina.hall@cms.com', '3737 Dogwood St, Springfield, IL', 10),
('Oscar Wright', 'oscar.wright@cms.com', '3838 Elm St, Springfield, IL', 1),
('Penny Young', 'penny.young@cms.com', '3939 Oak St, Springfield, IL', 2),
('Quincy King', 'quincy.king@cms.com', '4040 Pine St, Springfield, IL', 3),
('Ruby Scott', 'ruby.scott@cms.com', '4141 Maple St, Springfield, IL', 4),
('Steve Allen', 'steve.allen@cms.com', '4242 Cedar St, Springfield, IL', 5),
('Tara Baker', 'tara.baker@cms.com', '4343 Birch St, Springfield, IL', 6),
('Ulysses Green', 'ulysses.green@cms.com', '4444 Walnut St, Springfield, IL', 7),
('Vera Adams', 'vera.adams@cms.com', '4545 Ash St, Springfield, IL', 8),
('Will Baker', 'will.baker@cms.com', '4646 Cherry St, Springfield, IL', 9),
('Xena Hall', 'xena.hall@cms.com', '4747 Dogwood St, Springfield, IL', 10);

INSERT INTO book (title, author, price, available, edition, addedBy) VALUES
('Introduction to Computer Science', 'John Smith', 500, 1, '1st Edition', 1),
('Advanced Algorithms', 'Jane Doe', 600, 1, '2nd Edition', 2),
('Data Structures in C', 'Robert Johnson', 550, 1, '3rd Edition', 3),
('Database Management Systems', 'Emily Davis', 700, 1, '4th Edition', 4),
('Operating Systems Concepts', 'Michael Brown', 650, 1, '5th Edition', 5),
('Computer Networks', 'Sarah Wilson', 800, 1, '6th Edition', 6),
('Artificial Intelligence', 'David Moore', 750, 1, '1st Edition', 7),
('Machine Learning', 'Laura Taylor', 900, 1, '2nd Edition', 8),
('Software Engineering', 'James Anderson', 850, 1, '3rd Edition', 9),
('Theory of Computation', 'Linda Thomas', 950, 1, '4th Edition', 10),
('Introduction to Computer Science', 'John Smith', 500, 1, '1st Edition', 1),
('Advanced Algorithms', 'Jane Doe', 600, 1, '2nd Edition', 2),
('Data Structures in C', 'Robert Johnson', 550, 1, '3rd Edition', 3),
('Database Management Systems', 'Emily Davis', 700, 1, '4th Edition', 4),
('Operating Systems Concepts', 'Michael Brown', 650, 1, '5th Edition', 5),
('Computer Networks', 'Sarah Wilson', 800, 1, '6th Edition', 6),
('Artificial Intelligence', 'David Moore', 750, 1, '1st Edition', 7),
('Machine Learning', 'Laura Taylor', 900, 1, '2nd Edition', 8),
('Software Engineering', 'James Anderson', 850, 1, '3rd Edition', 9),
('Theory of Computation', 'Linda Thomas', 950, 1, '4th Edition', 10),
('Introduction to Computer Science', 'John Smith', 500, 1, '1st Edition', 1),
('Advanced Algorithms', 'Jane Doe', 600, 1, '2nd Edition', 2),
('Data Structures in C', 'Robert Johnson', 550, 1, '3rd Edition', 3),
('Database Management Systems', 'Emily Davis', 700, 1, '4th Edition', 4),
('Operating Systems Concepts', 'Michael Brown', 650, 1, '5th Edition', 5),
('Computer Networks', 'Sarah Wilson', 800, 1, '6th Edition', 6),
('Artificial Intelligence', 'David Moore', 750, 1, '1st Edition', 7),
('Machine Learning', 'Laura Taylor', 900, 1, '2nd Edition', 8),
('Software Engineering', 'James Anderson', 850, 1, '3rd Edition', 9),
('Theory of Computation', 'Linda Thomas', 950, 1, '4th Edition', 10),
('Introduction to Computer Science', 'John Smith', 500, 1, '1st Edition', 1),
('Advanced Algorithms', 'Jane Doe', 600, 1, '2nd Edition', 2),
('Data Structures in C', 'Robert Johnson', 550, 1, '3rd Edition', 3),
('Database Management Systems', 'Emily Davis', 700, 1, '4th Edition', 4),
('Operating Systems Concepts', 'Michael Brown', 650, 1, '5th Edition', 5),
('Computer Networks', 'Sarah Wilson', 800, 1, '6th Edition', 6),
('Artificial Intelligence', 'David Moore', 750, 1, '1st Edition', 7),
('Machine Learning', 'Laura Taylor', 900, 1, '2nd Edition', 8),
('Software Engineering', 'James Anderson', 850, 1, '3rd Edition', 9),
('Theory of Computation', 'Linda Thomas', 950, 1, '4th Edition', 10),
('Introduction to Computer Science', 'John Smith', 500, 1, '1st Edition', 1),
('Advanced Algorithms', 'Jane Doe', 600, 1, '2nd Edition', 2),
('Data Structures in C', 'Robert Johnson', 550, 1, '3rd Edition', 3),
('Database Management Systems', 'Emily Davis', 700, 1, '4th Edition', 4),
('Operating Systems Concepts', 'Michael Brown', 650, 1, '5th Edition', 5),
('Computer Networks', 'Sarah Wilson', 800, 1, '6th Edition', 6),
('Artificial Intelligence', 'David Moore', 750, 1, '1st Edition', 7),
('Machine Learning', 'Laura Taylor', 900, 1, '2nd Edition', 8),
('Software Engineering', 'James Anderson', 850, 1, '3rd Edition', 9),
('Theory of Computation', 'Linda Thomas', 950, 1, '4th Edition', 10);

-- Variables for the procedure
SET @studentId = 1;
SET @bookId = 1;
SET @issuedDate = '2024-07-01';

-- Call the procedure
CALL insert_book_transaction_if_eligible(@studentId, @bookId, @issuedDate);


-- Temporarily disable safe update mode
SET SQL_SAFE_UPDATES = 0;
SET @isLostOrDamaged = TRUE;
SET @returnDate = '2024-07-18';

-- Call the procedure
CALL update_book_transaction(@studentId, @bookId, @issuedDate, @returnDate, @isLostOrDamaged);

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM book_transactions;
