-- ============================================================
-- A2 - Salary Review (GOTO)
-- Reviews an employee's monthly salary and jumps to the matching
-- label: LOW (< 150000), MEDIUM (150000-400000), HIGH (> 400000).
-- Change v_emp_id (101-105) to test other employees.
-- ============================================================
SET SERVEROUTPUT ON;

DECLARE
  v_emp_id   employees.emp_id%TYPE := 101;
  v_name     VARCHAR2(70);
  v_salary   employees.salary%TYPE;
BEGIN
  SELECT first_name || ' ' || last_name, salary
    INTO v_name, v_salary
    FROM employees
   WHERE emp_id = v_emp_id;

  DBMS_OUTPUT.PUT_LINE('Employee: ' || v_name || ' | Monthly salary: ' || v_salary);

  IF v_salary < 150000 THEN
    GOTO low_salary;
  ELSIF v_salary <= 400000 THEN
    GOTO medium_salary;
  ELSE
    GOTO high_salary;
  END IF;

  <<low_salary>>
  DBMS_OUTPUT.PUT_LINE('Review: LOW band - eligible for a raise review.');
  GOTO review_done;

  <<medium_salary>>
  DBMS_OUTPUT.PUT_LINE('Review: MEDIUM band - standard annual increment.');
  GOTO review_done;

  <<high_salary>>
  DBMS_OUTPUT.PUT_LINE('Review: HIGH band - no increment this cycle.');

  <<review_done>>
  DBMS_OUTPUT.PUT_LINE('Salary review complete.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' not found.');
END;
/
