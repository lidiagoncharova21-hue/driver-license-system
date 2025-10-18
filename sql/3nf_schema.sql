CREATE DATABASE IF NOT EXISTS driver_license_system;
USE driver_license_system;

CREATE TABLE Driving_Schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(200) NOT NULL,
    date_of_birth DATE NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Medical_Certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    is_fit BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE,
    INDEX idx_candidate_id (candidate_id)
);

CREATE TABLE Courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    driving_school_id INT NOT NULL,
    category VARCHAR(5) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (driving_school_id) REFERENCES Driving_Schools(id) ON DELETE CASCADE,
    INDEX idx_driving_school_id (driving_school_id)
);

CREATE TABLE Enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    status ENUM('Enrolled', 'In Progress', 'Completed', 'Expelled') NOT NULL DEFAULT 'Enrolled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (candidate_id, course_id),
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_course_id (course_id)
);

CREATE TABLE Exams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    exam_type ENUM('Theory', 'Auto-drome', 'City') NOT NULL,
    exam_date DATE NOT NULL,
    result BOOLEAN NOT NULL,
    inspector_name VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE,
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_exam_date (exam_date)
);

CREATE TABLE Licenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL UNIQUE,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    category VARCHAR(5) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (candidate_id) REFERENCES Candidates(id) ON DELETE CASCADE,
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_license_number (license_number)
);