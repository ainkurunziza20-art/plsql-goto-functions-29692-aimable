-- ============================================================
-- test_validate_payroll.sql - tests C1 fn_validate_payroll
-- Expected: 101-105 VALID; 106 salary/department problem;
--           107 future hire date; 999 not found.
-- ============================================================
SET SERVEROUTPUT ON;

BEGIN
  FOR r IN (SELECT emp_id FROM employees ORDER BY emp_id) LOOP
    DBMS_OUTPUT.PUT_LINE('Employee ' || r.emp_id || ': ' || fn_validate_payroll(r.emp_id));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Employee 999: ' || fn_validate_payroll(999));
END;
/

-- Same check in plain SQL (use this one for the C1 screenshot)
SELECT emp_id, first_name, fn_validate_payroll(emp_id) AS payroll_status
  FROM employees
 ORDER BY emp_id;
