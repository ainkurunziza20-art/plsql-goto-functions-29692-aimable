-- ============================================================
-- A4 - Rewrite Without GOTO
-- Same logic as A1 (Number Classifier) and A2 (Salary Review),
-- using structured IF / ELSIF / ELSE only. No GOTO, no labels.
-- ============================================================
SET SERVEROUTPUT ON;

-- A1 rewritten
DECLARE
  v_number NUMBER := 15;     -- try 15, -7 and 0
BEGIN
  DBMS_OUTPUT.PUT_LINE('Number tested: ' || v_number);

  IF v_number > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Result: POSITIVE');
  ELSIF v_number < 0 THEN
    DBMS_OUTPUT.PUT_LINE('Result: NEGATIVE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Result: ZERO');
  END IF;

  DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/

-- A2 rewritten
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
    DBMS_OUTPUT.PUT_LINE('Review: LOW band - eligible for a raise review.');
  ELSIF v_salary <= 400000 THEN
    DBMS_OUTPUT.PUT_LINE('Review: MEDIUM band - standard annual increment.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Review: HIGH band - no increment this cycle.');
  END IF;

  DBMS_OUTPUT.PUT_LINE('Salary review complete.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' not found.');
END;
/
