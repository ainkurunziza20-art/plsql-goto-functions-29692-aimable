# PL/SQL GOTO Statements and Functions

**Course:** Database Development with PL/SQL (INSY 8311)
**Instructor:** Eric Maniraguha
**Student:** Aimable | **Student ID:** 29692
**Assignment:** Individual Assignment III (due Thursday, 8 October 2026, 11:59 PM)

## Overview
This repository contains my solutions for PL/SQL GOTO statements, stored functions,
functions used in SQL, and a combined payroll-validation task.

## Database
Two tables, created by `00_setup/create_tables.sql`:
- `departments(dept_id, dept_name)`
- `employees(emp_id, first_name, last_name, salary, hire_date, dept_id)` - `salary` is monthly.

Employees 106 and 107 are deliberately invalid (zero salary / no department, future hire date)
so the payroll validator has failures to detect.

## Task Index
| Task | File | Description |
|------|------|-------------|
| A1 | `01_goto/A1_number_classifier.sql` | Classify a number as positive/negative/zero with GOTO |
| A2 | `01_goto/A2_salary_review.sql` | Salary band review using GOTO |
| A3 | `01_goto/A3_illegal_goto.sql` | Illegal GOTO into an IF block (PLS-00375) and its fix |
| A4 | `01_goto/A4_rewrite_no_goto.sql` | A1 and A2 rewritten without GOTO |
| B1 | `02_functions/B1_fn_annual_salary.sql` | Annual salary = monthly x 12 |
| B2 | `02_functions/B2_fn_years_of_service.sql` | Completed years of service |
| B3 | `02_functions/B3_fn_calculate_tax.sql` | Progressive tax calculator |
| B4 | `02_functions/B4_fn_dept_name.sql` | Department name lookup |
| B5 | `03_tests/B5_functions_in_select.sql` | Functions used in SELECT / WHERE |
| C1 | `02_functions/C1_fn_validate_payroll.sql` | Payroll validator (GOTO + functions) |
| C2 | `docs/REFLECTION.md` | Reflection |

## How to Run
1. Run `00_setup/create_tables.sql`.
2. Run the functions in `02_functions/` in order: B1, B2, B3, B4, then C1.
3. Run the programs in `01_goto/` (A1 to A4).
4. Run the test files in `03_tests/` (B5, test_functions, test_validate_payroll).
5. Check results against the screenshots in `screenshots/`.

Run files with SQL*Plus (`@path/to/file.sql`), SQL Developer, or Oracle Live SQL.
Enable output first with `SET SERVEROUTPUT ON`.

## Screenshots
| File | Shows |
|------|-------|
| `screenshots/A1_output.png` | Number classifier output |
| `screenshots/A2_output.png` | Salary review output |
| `screenshots/A3_error_and_fix.png` | PLS-00375 error and the fixed block |
| `screenshots/A4_output.png` | Rewritten programs without GOTO |
| `screenshots/B5_select_output.png` | Functions inside SELECT |
| `screenshots/C1_output.png` | Payroll validator results |

## Key Concepts
- **GOTO** jumps to a label `<<label>>`; it cannot jump into an IF, LOOP or inner block, or out of an exception handler into its block. Structured IF/ELSIF/LOOP is clearer.
- **Functions** always return a value, can be called in SQL, and handle errors with exceptions.

## Author
Aimable - 29692
