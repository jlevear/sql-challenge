--employee number, last name, first name, sex, and salary
SELECT employees.emp_no, last_name, first_name, sex, salary FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no ORDER BY salary DESC

--first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986

--manager of each department with the following information: department number, department name, the manager's employee number, last name, first name
--used partial code from url (user Mithrandir): https://stackoverflow.com/questions/10538539/join-two-select-statement-results
SELECT dept_no, dept_name, emp_no, last_name, first_name FROM	
	(SELECT dept_manager.emp_no AS emp_key, dept_manager.dept_no, departments.dept_name
	FROM departments
	RIGHT JOIN dept_manager ON departments.dept_no=dept_manager.dept_no) t1
LEFT JOIN
	(SELECT dept_manager.emp_no, employees.last_name, employees.first_name
	FROM employees
	RIGHT JOIN dept_manager ON employees.emp_no=dept_manager.emp_no) t2
ON t1.emp_key=t2.emp_no

--department of each employee with the following information: employee number, last name, first name, and department name
--used similar method as above
SELECT emp_no, last_name, first_name, dept_name FROM
	(SELECT * FROM
		(SELECT employees.emp_no AS emp_key, last_name, first_name FROM employees) t1
	INNER JOIN
		(SELECT dept_emp.emp_no, dept_emp.dept_no AS dept_key FROM dept_emp) t2
	ON t1.emp_key=t2.emp_no) t3
INNER JOIN
	(SELECT departments.dept_no, dept_name FROM departments) t4
ON t3.dept_key=t4.dept_no
ORDER BY emp_no

--first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B"
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT emp_no, last_name, first_name, dept_name FROM
	(SELECT emp_no, departments.dept_no AS dept_key, dept_name FROM departments
	INNER JOIN dept_emp ON departments.dept_no=dept_emp.dept_no
	WHERE dept_name = 'Sales') t1
INNER JOIN
	(SELECT employees.emp_no AS emp_key, last_name, first_name, dept_no FROM employees
	INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no) t2
ON t1.emp_no=t2.emp_key
ORDER BY emp_no

--all all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT emp_no, last_name, first_name, dept_name FROM
	(SELECT emp_no, departments.dept_no AS dept_key, dept_name FROM departments
	INNER JOIN dept_emp ON departments.dept_no=dept_emp.dept_no
	WHERE dept_name = 'Sales' OR dept_name = 'Development') t1
INNER JOIN
	(SELECT employees.emp_no AS emp_key, last_name, first_name, dept_no FROM employees
	INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no) t2
ON t1.emp_no=t2.emp_key
ORDER BY emp_no

--frequency count of employee last names in descending order
SELECT last_name, COUNT(last_name) AS freq_count FROM employees
GROUP BY last_name
ORDER BY freq_count DESC

