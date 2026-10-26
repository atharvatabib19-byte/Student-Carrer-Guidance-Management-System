
CREATE DATABASE IF NOT EXISTS student_career_guidance;

USE student_career_guidance;

-- Table 1: Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50)
);

-- Table 2: Education
CREATE TABLE Education (
    education_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    qualification VARCHAR(100),
    college_name VARCHAR(150),
    passing_year YEAR,
    percentage DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Table 3: Career Options
CREATE TABLE Career_Options (
    career_id INT PRIMARY KEY AUTO_INCREMENT,
    career_name VARCHAR(100) NOT NULL,
    career_description VARCHAR(255),
    required_qualification VARCHAR(100),
    average_salary DECIMAL(10,2)
);

-- Table 4: Skills
CREATE TABLE Skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL,
    skill_category VARCHAR(50)
);

-- Table 5: Student Skills
CREATE TABLE Student_Skills (
    student_id INT,
    skill_id INT,
    proficiency_level VARCHAR(30),
    PRIMARY KEY (student_id, skill_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

-- Table 6: Counseling Sessions
CREATE TABLE Counseling_Sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    career_id INT NOT NULL,
    counselor_name VARCHAR(100),
    session_date DATE,
    session_mode VARCHAR(30),
    feedback VARCHAR(255),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (career_id) REFERENCES Career_Options(career_id)
);

-- Table 7: Course Recommendations
CREATE TABLE Course_Recommendations (
    recommendation_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    career_id INT NOT NULL,
    course_name VARCHAR(150),
    provider VARCHAR(100),
    course_duration VARCHAR(50),
    course_status VARCHAR(30),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (career_id) REFERENCES Career_Options(career_id)
);


USE student_career_guidance;

-- Students
INSERT INTO Students
(student_name, gender, date_of_birth, email, phone, city)
VALUES
('Atharva Tabib', 'Male', '2005-06-15', 'atharva@example.com', '9876500001', 'Dombivli'),
('Rahul Patil', 'Male', '2004-08-20', 'rahul@example.com', '9876500002', 'Thane'),
('Priya Sharma', 'Female', '2005-02-10', 'priya@example.com', '9876500003', 'Mumbai'),
('Sneha More', 'Female', '2004-11-05', 'sneha@example.com', '9876500004', 'Kalyan'),
('Amit Shah', 'Male', '2005-01-25', 'amit@example.com', '9876500005', 'Dombivli');

-- Education
INSERT INTO Education
(student_id, qualification, college_name, passing_year, percentage)
VALUES
(1, 'TYBSc IT', 'Guardian Degree College', 2027, 78.50),
(2, 'BSc Computer Science', 'ABC College', 2026, 72.00),
(3, 'BCom', 'XYZ College', 2026, 85.00),
(4, 'BSc IT', 'PQR College', 2027, 81.50),
(5, 'BCA', 'LMN College', 2026, 68.00);

-- Career Options
INSERT INTO Career_Options
(career_name, career_description, required_qualification, average_salary)
VALUES
('Data Analyst', 'Analyze data and prepare reports', 'Graduate', 450000),
('Software Developer', 'Develop software applications', 'BSc IT / BE / BCA', 600000),
('Cyber Security Analyst', 'Protect systems and networks', 'IT Graduate', 550000),
('Digital Marketing', 'Promote products using digital media', 'Any Graduate', 350000),
('Database Administrator', 'Manage and maintain databases', 'IT Graduate', 500000);

-- Skills
INSERT INTO Skills (skill_name, skill_category)
VALUES
('SQL', 'Technical'),
('Python', 'Programming'),
('Excel', 'Data Analysis'),
('Communication', 'Soft Skill'),
('Power BI', 'Data Visualization'),
('Java', 'Programming');

-- Student Skills
INSERT INTO Student_Skills
(student_id, skill_id, proficiency_level)
VALUES
(1, 1, 'Intermediate'),
(1, 3, 'Intermediate'),
(1, 5, 'Beginner'),
(2, 6, 'Intermediate'),
(2, 1, 'Beginner'),
(3, 4, 'Advanced'),
(3, 3, 'Intermediate'),
(4, 1, 'Beginner'),
(4, 2, 'Intermediate'),
(5, 6, 'Beginner');

-- Counseling Sessions
INSERT INTO Counseling_Sessions
(student_id, career_id, counselor_name, session_date,
 session_mode, feedback)
VALUES
(1, 1, 'Mr. Deshmukh', '2026-10-10', 'Online', 'Interested in data analytics'),
(2, 2, 'Ms. Joshi', '2026-10-11', 'Offline', 'Interested in software development'),
(3, 4, 'Mr. Patil', '2026-10-12', 'Online', 'Interested in digital marketing'),
(4, 1, 'Ms. Shah', '2026-10-13', 'Offline', 'Needs SQL practice'),
(5, 3, 'Mr. Deshmukh', '2026-10-14', 'Online', 'Interested in cybersecurity');

-- Course Recommendations
INSERT INTO Course_Recommendations
(student_id, career_id, course_name, provider,
 course_duration, course_status)
VALUES
(1, 1, 'SQL for Data Analysis', 'Coursera', '8 Weeks', 'Recommended'),
(1, 1, 'Power BI Fundamentals', 'Microsoft Learn', '6 Weeks', 'In Progress'),
(2, 2, 'Java Programming', 'Udemy', '12 Weeks', 'Recommended'),
(3, 4, 'Digital Marketing Fundamentals', 'Google', '4 Weeks', 'Completed'),
(4, 1, 'Python for Data Analysis', 'Coursera', '10 Weeks', 'Recommended'),
(5, 3, 'Cyber Security Basics', 'Cisco', '8 Weeks', 'Recommended');


SELECT * FROM Students;

desc students;

desc education;

SELECT * FROM education;

desc Career_Options;

SELECT * FROM Career_Options; 

desc Skills;

SELECT * FROM Skills;

desc Student_Skills;

SELECT * FROM Student_Skills;

desc Counseling_Sessions;

SELECT * FROM Counseling_Sessions;

desc Course_Recommendations;

SELECT * FROM Course_Recommendations;



SELECT
    s.student_name,
    e.qualification,
    e.college_name,
    e.passing_year,
    e.percentage
FROM Students s
INNER JOIN Education e
ON s.student_id = e.student_id;


SELECT s.student_name, e.percentage
FROM Students s
JOIN Education e
ON s.student_id = e.student_id
WHERE e.percentage > 75;


SELECT COUNT(*) AS Total_Students
FROM Students;


SELECT ROUND(AVG(percentage), 2) AS Average_Percentage
FROM Education;


SELECT
    s.student_name,
    sk.skill_name,
    ss.proficiency_level
FROM Students s
JOIN Student_Skills ss
ON s.student_id = ss.student_id
JOIN Skills sk
ON ss.skill_id = sk.skill_id;


SELECT
    s.student_name,
    c.career_name,
    cs.counselor_name,
    cs.session_date,
    cs.session_mode,
    cs.feedback
FROM Counseling_Sessions cs
JOIN Students s
ON cs.student_id = s.student_id
JOIN Career_Options c
ON cs.career_id = c.career_id;


SELECT
    s.student_name,
    c.career_name,
    cr.course_name,
    cr.provider,
    cr.course_status
FROM Course_Recommendations cr
JOIN Students s
ON cr.student_id = s.student_id
JOIN Career_Options c
ON cr.career_id = c.career_id;


SELECT
    c.career_name,
    COUNT(cs.student_id) AS Total_Students
FROM Career_Options c
LEFT JOIN Counseling_Sessions cs
ON c.career_id = cs.career_id
GROUP BY c.career_id, c.career_name
ORDER BY Total_Students DESC;


SELECT *
FROM Students
WHERE student_name LIKE '%Atharva%';


SELECT career_name, required_qualification, average_salary
FROM Career_Options
WHERE average_salary > 400000
ORDER BY average_salary DESC;


USE student_career_guidance;

SHOW TABLES;

SELECT * FROM Students;
SELECT * FROM Education;
SELECT * FROM Career_Options;
SELECT * FROM Skills;
SELECT * FROM Student_Skills;
SELECT * FROM Counseling_Sessions;
SELECT * FROM Course_Recommendations;











