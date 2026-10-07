-- ============================================================
-- A3 - Illegal GOTO and Fix
-- PL/SQL does NOT allow a GOTO to jump INTO an IF / LOOP / inner block.
-- PART 1 below is ILLEGAL and fails to compile (PLS-00375).
-- PART 2 is the corrected version.
-- Run each part separately and screenshot the error + the fix.
-- ============================================================
SET SERVEROUTPUT ON;

-- ------------------------------------------------------------
-- PART 1: ILLEGAL - jumps into the middle of an IF block
-- Expected error: PLS-00375: illegal GOTO statement; this GOTO
-- cannot branch to label 'inside_if'
-- ------------------------------------------------------------
DECLARE
  v_number NUMBER := 5;
BEGIN
  GOTO inside_if;                       -- illegal: target is inside the IF

  IF v_number > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF block');
  END IF;
END;
/

-- ------------------------------------------------------------
-- PART 2: FIX - put the label at the same block level (outside
-- the IF), so the jump is legal.
-- ------------------------------------------------------------
DECLARE
  v_number NUMBER := 5;
BEGIN
  GOTO show_message;                    -- legal: label is in the same block

  IF v_number > 0 THEN
    DBMS_OUTPUT.PUT_LINE('This line is skipped by the GOTO');
  END IF;

  <<show_message>>
  DBMS_OUTPUT.PUT_LINE('Jumped to a label in the same block - legal!');
END;
/
