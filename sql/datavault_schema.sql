CREATE DATABASE IF NOT EXISTS driver_license_dv;
USE driver_license_dv;

CREATE TABLE hub_driving_school (
    driving_school_hashkey CHAR(32) PRIMARY KEY,
    driving_school_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    INDEX idx_driving_school_id (driving_school_id)
);

CREATE TABLE hub_candidate (
    candidate_hashkey CHAR(32) PRIMARY KEY,
    candidate_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    INDEX idx_candidate_id (candidate_id)
);

CREATE TABLE hub_course (
    course_hashkey CHAR(32) PRIMARY KEY,
    course_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    INDEX idx_course_id (course_id)
);

CREATE TABLE hub_license (
    license_hashkey CHAR(32) PRIMARY KEY,
    license_number VARCHAR(20) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    INDEX idx_license_number (license_number)
);

CREATE TABLE hub_medical_certificate (
    medical_certificate_hashkey CHAR(32) PRIMARY KEY,
    medical_certificate_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    INDEX idx_medical_certificate_id (medical_certificate_id)
);


CREATE TABLE link_candidate_enrollment (
    candidate_enrollment_hashkey CHAR(32) PRIMARY KEY,
    candidate_hashkey CHAR(32) NOT NULL,
    course_hashkey CHAR(32) NOT NULL,
    enrollment_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    FOREIGN KEY (candidate_hashkey) REFERENCES hub_candidate(candidate_hashkey),
    FOREIGN KEY (course_hashkey) REFERENCES hub_course(course_hashkey),
    INDEX idx_candidate_course (candidate_hashkey, course_hashkey)
);

CREATE TABLE link_course_offering (
    course_offering_hashkey CHAR(32) PRIMARY KEY,
    driving_school_hashkey CHAR(32) NOT NULL,
    course_hashkey CHAR(32) NOT NULL,
    offering_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    FOREIGN KEY (driving_school_hashkey) REFERENCES hub_driving_school(driving_school_hashkey),
    FOREIGN KEY (course_hashkey) REFERENCES hub_course(course_hashkey),
    INDEX idx_school_course (driving_school_hashkey, course_hashkey)
);

CREATE TABLE link_candidate_medical (
    candidate_medical_hashkey CHAR(32) PRIMARY KEY,
    candidate_hashkey CHAR(32) NOT NULL,
    medical_certificate_hashkey CHAR(32) NOT NULL,
    relation_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    FOREIGN KEY (candidate_hashkey) REFERENCES hub_candidate(candidate_hashkey),
    FOREIGN KEY (medical_certificate_hashkey) REFERENCES hub_medical_certificate(medical_certificate_hashkey),
    INDEX idx_candidate_medical (candidate_hashkey, medical_certificate_hashkey)
);

CREATE TABLE link_candidate_exam (
    candidate_exam_hashkey CHAR(32) PRIMARY KEY,
    candidate_hashkey CHAR(32) NOT NULL,
    exam_session_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    FOREIGN KEY (candidate_hashkey) REFERENCES hub_candidate(candidate_hashkey),
    INDEX idx_candidate_exam (candidate_hashkey)
);

CREATE TABLE link_candidate_license (
    candidate_license_hashkey CHAR(32) PRIMARY KEY,
    candidate_hashkey CHAR(32) NOT NULL,
    license_hashkey CHAR(32) NOT NULL,
    relation_id VARCHAR(50) NOT NULL UNIQUE,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    record_source VARCHAR(50) NOT NULL,
    FOREIGN KEY (candidate_hashkey) REFERENCES hub_candidate(candidate_hashkey),
    FOREIGN KEY (license_hashkey) REFERENCES hub_license(license_hashkey),
    INDEX idx_candidate_license (candidate_hashkey, license_hashkey)
);

CREATE TABLE sat_driving_school_info (
    driving_school_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    license_number VARCHAR(50),
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (driving_school_hashkey, load_dts),
    FOREIGN KEY (driving_school_hashkey) REFERENCES hub_driving_school(driving_school_hashkey),
    INDEX idx_hashkey_load_dts (driving_school_hashkey, load_dts)
);

CREATE TABLE sat_candidate_personal (
    candidate_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    date_of_birth DATE NOT NULL,
    address TEXT,
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (candidate_hashkey, load_dts),
    FOREIGN KEY (candidate_hashkey) REFERENCES hub_candidate(candidate_hashkey),
    INDEX idx_hashkey_load_dts (candidate_hashkey, load_dts)
);

CREATE TABLE sat_candidate_contact (
    candidate_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (candidate_hashkey, load_dts),
    FOREIGN KEY (candidate_hashkey) REFERENCES hub_candidate(candidate_hashkey),
    INDEX idx_hashkey_load_dts (candidate_hashkey, load_dts)
);

CREATE TABLE sat_course_details (
    course_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    category VARCHAR(5) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    duration_hours INT,
    description TEXT,
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (course_hashkey, load_dts),
    FOREIGN KEY (course_hashkey) REFERENCES hub_course(course_hashkey),
    INDEX idx_hashkey_load_dts (course_hashkey, load_dts)
);

CREATE TABLE sat_license_details (
    license_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    category VARCHAR(5) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    status VARCHAR(20),
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (license_hashkey, load_dts),
    FOREIGN KEY (license_hashkey) REFERENCES hub_license(license_hashkey),
    INDEX idx_hashkey_load_dts (license_hashkey, load_dts)
);

CREATE TABLE sat_medical_certificate_details (
    medical_certificate_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    is_fit BOOLEAN NOT NULL,
    medical_organization VARCHAR(100),
    doctor_name VARCHAR(100),
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (medical_certificate_hashkey, load_dts),
    FOREIGN KEY (medical_certificate_hashkey) REFERENCES hub_medical_certificate(medical_certificate_hashkey),
    INDEX idx_hashkey_load_dts (medical_certificate_hashkey, load_dts)
);

CREATE TABLE sat_exam_results (
    candidate_exam_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    exam_type ENUM('Theory', 'Auto-drome', 'City') NOT NULL,
    exam_date DATE NOT NULL,
    result BOOLEAN NOT NULL,
    inspector_name VARCHAR(200),
    score INT,
    comments TEXT,
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (candidate_exam_hashkey, load_dts),
    FOREIGN KEY (candidate_exam_hashkey) REFERENCES link_candidate_exam(candidate_exam_hashkey),
    INDEX idx_hashkey_load_dts (candidate_exam_hashkey, load_dts)
);

CREATE TABLE sat_enrollment_status (
    candidate_enrollment_hashkey CHAR(32) NOT NULL,
    load_dts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hash_diff CHAR(32) NOT NULL,
    enrollment_date DATE NOT NULL,
    status ENUM('Enrolled', 'In Progress', 'Completed', 'Expelled') NOT NULL,
    completion_date DATE,
    load_end_dts TIMESTAMP NULL,
    record_source VARCHAR(50) NOT NULL,
    PRIMARY KEY (candidate_enrollment_hashkey, load_dts),
    FOREIGN KEY (candidate_enrollment_hashkey) REFERENCES link_candidate_enrollment(candidate_enrollment_hashkey),
    INDEX idx_hashkey_load_dts (candidate_enrollment_hashkey, load_dts)
);