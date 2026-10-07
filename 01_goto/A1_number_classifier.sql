-- ============================================================
-- A1 - Number Classifier (GOTO)
-- Classifies a number as POSITIVE, NEGATIVE or ZERO using GOTO.
-- Change v_number to test the three paths.
-- ============================================================
SET SERVEROUTPUT ON;

DECLARE
  v_number NUMBER := 15;     -- try 15, -7 and 0
BEGIN
  DBMS_OUTPUT.PUT_LINE('Number tested: ' || v_number);

  IF v_number > 0 THEN
    GOTO positive_number;
  ELSIF v_number < 0 THEN
    GOTO negative_number;
  ELSE
    GOTO zero_number;
  END IF;

  <<positive_number>>
  DBMS_OUTPUT.PUT_LINE('Result: POSITIVE');
  GOTO end_program;

  <<negative_number>>
  DBMS_OUTPUT.PUT_LINE('Result: NEGATIVE');
  GOTO end_program;

  <<zero_number>>
  DBMS_OUTPUT.PUT_LINE('Result: ZERO');

  <<end_program>>
  DBMS_OUTPUT.PUT_LINE('Classification finished.');
END;
/
