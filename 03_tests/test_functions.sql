-- ============================================================
-- test_functions.sql - tests B1-B4 (normal, edge and error cases)
-- ============================================================
SET SERVEROUTPUT ON;

DECLARE
  PROCEDURE check_eq(p_label VARCHAR2, p_actual VARCHAR2, p_expected VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD(p_label, 45) || ' -> ' || NVL(p_actual, 'NULL') ||
      CASE WHEN NVL(p_actual,'~') = NVL(p_expected,'~') THEN '  PASS'
           ELSE '  FAIL (expected ' || NVL(p_expected,'NULL') || ')' END);
  END;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- B1 fn_annual_salary ---');
  check_eq('Emp 101 (450000 x 12)',        fn_annual_salary(101), '5400000');
  check_eq('Emp 104 (90000 x 12)',         fn_annual_salary(104), '1080000');
  check_eq('Emp 999 (not found)',          fn_annual_salary(999), NULL);

  DBMS_OUTPUT.PUT_LINE('--- B2 fn_years_of_service ---');
  check_eq('Emp 999 (not found)',          fn_years_of_service(999), NULL);
  DBMS_OUTPUT.PUT_LINE('Emp 101 years of service: ' || fn_years_of_service(101));
  DBMS_OUTPUT.PUT_LINE('Emp 105 years of service: ' || fn_years_of_service(105));
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_years_of_service(107));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Emp 107 (future hire date)'||RPAD(' ',20)||' -> ' || SQLERRM || '  PASS');
  END;

  DBMS_OUTPUT.PUT_LINE('--- B3 fn_calculate_tax ---');
  check_eq('Salary 0',                     fn_calculate_tax(0),        '0');
  check_eq('Salary 600000 (boundary)',     fn_calculate_tax(600000),   '0');
  check_eq('Salary 1000000',               fn_calculate_tax(1000000),  '40000');
  check_eq('Salary 1200000 (boundary)',    fn_calculate_tax(1200000),  '60000');
  check_eq('Salary 2000000',               fn_calculate_tax(2000000),  '220000');
  check_eq('Salary 3000000',               fn_calculate_tax(3000000),  '480000');
  BEGIN
    DBMS_OUTPUT.PUT_LINE(fn_calculate_tax(-5));
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Negative salary'||RPAD(' ',30)||' -> ' || SQLERRM || '  PASS');
  END;

  DBMS_OUTPUT.PUT_LINE('--- B4 fn_dept_name ---');
  check_eq('Dept 10',                      fn_dept_name(10),   'Finance');
  check_eq('Dept 20',                      fn_dept_name(20),   'IT');
  check_eq('Dept 999 (not found)',         fn_dept_name(999),  'Unknown');
  check_eq('Dept NULL',                    fn_dept_name(NULL), 'Unknown');
END;
/
