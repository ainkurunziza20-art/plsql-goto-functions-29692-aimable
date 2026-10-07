-- ============================================================
-- B3 - fn_calculate_tax
-- Progressive tax on an ANNUAL salary (assignment-defined brackets):
--   0       - 600,000   : 0%
--   600,001 - 1,200,000 : 10% of the part above 600,000
--   1,200,001 - 2,400,000 : 60,000 + 20% of the part above 1,200,000
--   above 2,400,000     : 300,000 + 30% of the part above 2,400,000
-- Raises -20002 for NULL or negative input.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_calculate_tax (
  p_annual_salary IN NUMBER
) RETURN NUMBER
IS
  v_tax NUMBER;
BEGIN
  IF p_annual_salary IS NULL OR p_annual_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Annual salary must be a non-negative number');
  END IF;

  IF p_annual_salary <= 600000 THEN
    v_tax := 0;
  ELSIF p_annual_salary <= 1200000 THEN
    v_tax := (p_annual_salary - 600000) * 0.10;
  ELSIF p_annual_salary <= 2400000 THEN
    v_tax := 60000 + (p_annual_salary - 1200000) * 0.20;
  ELSE
    v_tax := 300000 + (p_annual_salary - 2400000) * 0.30;
  END IF;

  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/
SHOW ERRORS FUNCTION fn_calculate_tax;
