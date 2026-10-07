-- ============================================================
-- C1 - fn_validate_payroll (combined task: GOTO + functions)
-- Validates an employee before payroll. Returns 'VALID' or a
-- message describing the FIRST problem found.
-- Uses GOTO to jump to a single exit point (validation_failed).
-- Depends on: fn_annual_salary, fn_years_of_service, fn_dept_name
-- Checks: 1) employee exists  2) salary > 0
--         3) belongs to a real department  4) hire date not in future
-- ============================================================
CREATE OR REPLACE FUNCTION fn_validate_payroll (
  p_emp_id IN employees.emp_id%TYPE
) RETURN VARCHAR2
IS
  v_salary    employees.salary%TYPE;
  v_dept_id   employees.dept_id%TYPE;
  v_hire_date employees.hire_date%TYPE;
  v_message   VARCHAR2(200) := 'VALID';
BEGIN
  -- Check 1: employee exists
  IF fn_annual_salary(p_emp_id) IS NULL THEN
    v_message := 'INVALID: employee ' || p_emp_id || ' not found';
    GOTO validation_failed;
  END IF;

  SELECT salary, dept_id, hire_date
    INTO v_salary, v_dept_id, v_hire_date
    FROM employees
   WHERE emp_id = p_emp_id;

  -- Check 2: salary must be positive
  IF v_salary <= 0 THEN
    v_message := 'INVALID: salary must be greater than zero';
    GOTO validation_failed;
  END IF;

  -- Check 3: department must exist
  IF fn_dept_name(v_dept_id) = 'Unknown' THEN
    v_message := 'INVALID: employee has no valid department';
    GOTO validation_failed;
  END IF;

  -- Check 4: hire date must not be in the future
  IF v_hire_date > SYSDATE THEN
    v_message := 'INVALID: hire date is in the future';
    GOTO validation_failed;
  END IF;

  -- All checks passed
  RETURN 'VALID';

  <<validation_failed>>
  RETURN v_message;
END fn_validate_payroll;
/
SHOW ERRORS FUNCTION fn_validate_payroll;
