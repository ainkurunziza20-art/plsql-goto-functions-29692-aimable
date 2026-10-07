-- ============================================================
-- B5 - Using the functions inside SQL SELECT statements
-- Requires 02_functions/B1-B4 and C1 to be compiled first.
-- Employee 107 has a future hire date, so it is excluded from the
-- years-of-service column by filtering on hire_date <= SYSDATE.
-- ============================================================
SET LINESIZE 200
SET PAGESIZE 50
COLUMN employee      FORMAT A22
COLUMN department    FORMAT A18
COLUMN annual_salary FORMAT 999,999,999
COLUMN annual_tax    FORMAT 999,999,999

SELECT e.emp_id,
       e.first_name || ' ' || e.last_name AS employee,
       fn_dept_name(e.dept_id)            AS department,
       fn_annual_salary(e.emp_id)         AS annual_salary,
       fn_calculate_tax(fn_annual_salary(e.emp_id)) AS annual_tax,
       fn_years_of_service(e.emp_id)      AS years_service
  FROM employees e
 WHERE e.hire_date <= SYSDATE
 ORDER BY e.emp_id;

-- Functions in a WHERE clause: employees with more than 5 years of service
-- The CASE makes sure the function is never called for a future hire date
-- (employee 107), because Oracle does not guarantee the order of AND conditions.
SELECT emp_id, first_name,
       CASE WHEN hire_date <= SYSDATE THEN fn_years_of_service(emp_id) END AS years_service
  FROM employees
 WHERE hire_date <= SYSDATE
   AND CASE WHEN hire_date <= SYSDATE THEN fn_years_of_service(emp_id) END > 5;