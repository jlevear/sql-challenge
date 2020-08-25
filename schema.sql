-- Create tables
CREATE TABLE IF NOT EXISTS departments
(
    dept_no VARCHAR(50) NOT NULL UNIQUE,
    dept_name VARCHAR(100),
    PRIMARY KEY(dept_no)
);

CREATE TABLE IF NOT EXISTS dept_emp
(
    primary_key SERIAL NOT NULL UNIQUE,
    emp_no INTEGER,
    dept_no VARCHAR(50),
    PRIMARY KEY(primary_key)
);

CREATE TABLE IF NOT EXISTS dept_manager
(
    primary_key SERIAL NOT NULL UNIQUE,
    dept_no VARCHAR(50),
    emp_no INTEGER UNIQUE,
    PRIMARY KEY(primary_key)
);

CREATE TABLE IF NOT EXISTS employees
(
    emp_no INTEGER NOT NULL UNIQUE,
    emp_title VARCHAR(50),
    birth_date DATE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    sex VARCHAR(1),
    hire_date DATE,
    PRIMARY KEY(emp_no)
);

CREATE TABLE IF NOT EXISTS salaries
(
    emp_no INTEGER NOT NULL UNIQUE,
    salary INTEGER,
    PRIMARY KEY(emp_no)
);

CREATE TABLE IF NOT EXISTS titles
(
    title_id VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(100),
    PRIMARY KEY(title_id)
);

-- Create FKs
ALTER TABLE dept_manager
    ADD FOREIGN KEY (emp_no)
    REFERENCES employees(emp_no)
    MATCH SIMPLE
;
    
ALTER TABLE dept_manager
    ADD FOREIGN KEY (dept_no)
    REFERENCES departments(dept_no)
    MATCH SIMPLE
;
    
ALTER TABLE employees
    ADD FOREIGN KEY (emp_no)
    REFERENCES salaries(emp_no)
    MATCH SIMPLE
;

ALTER TABLE dept_emp
    ADD FOREIGN KEY (emp_no)
    REFERENCES employees(emp_no)
    MATCH SIMPLE
;
    
ALTER TABLE dept_emp
    ADD FOREIGN KEY (dept_no)
    REFERENCES departments(dept_no)
    MATCH SIMPLE
;

ALTER TABLE employees
    ADD FOREIGN KEY (emp_title)
    REFERENCES titles(title_id)
    MATCH SIMPLE
;
