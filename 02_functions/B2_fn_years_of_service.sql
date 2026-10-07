-- ============================================================
-- B2 - fn_years_of_service
-- Returns the number of COMPLETED years since the hire date.
-- Returns NULL if the employee does not exist.
-- Raises an error if the hire date is in the future.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_years_of_service (
  p_emp_id IN employees.emp_id%TYPE
) RETURN NUMBER
IS
  v_hire_date employees.hire_date%TYPE;
BEGIN
  SELECT hire_date INTO v_hire_date
    FROM employees
   WHERE emp_id = p_emp_id;

  IF v_hire_date > SYSDATE THEN
    RAISE_APPLICATION_ERROR(-20001, 'Hire date is in the future for employee ' || p_emp_id);
  END IF;

  RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END fn_years_of_service;
/
SHOW ERRORS FUNCTION fn_years_of_service;
