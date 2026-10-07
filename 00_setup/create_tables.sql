-- ============================================================
-- 00_setup/create_tables.sql
-- Creates and fills the DEPARTMENTS and EMPLOYEES tables
-- Safe to re-run: drops old tables first.
-- ============================================================
SET SERVEROUTPUT ON;

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE departments PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE departments (
  dept_id    NUMBER(4)     PRIMARY KEY,
  dept_name  VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  emp_id      NUMBER(6)     PRIMARY KEY,
  first_name  VARCHAR2(30)  NOT NULL,
  last_name   VARCHAR2(30)  NOT NULL,
  salary      NUMBER(10,2)  NOT NULL,   -- MONTHLY salary
  hire_date   DATE          NOT NULL,
  dept_id     NUMBER(4)     REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'IT');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');

INSERT INTO employees VALUES (101, 'Alice',  'Uwase',    450000, DATE '2015-03-01', 10);
INSERT INTO employees VALUES (102, 'Brian',  'Mugisha',  320000, DATE '2019-07-15', 20);
INSERT INTO employees VALUES (103, 'Chantal','Ineza',    180000, DATE '2022-01-10', 30);
INSERT INTO employees VALUES (104, 'David',  'Habimana',  90000, DATE '2024-05-20', 20);
INSERT INTO employees VALUES (105, 'Esther', 'Kamanzi',  650000, DATE '2010-09-01', 10);
INSERT INTO employees VALUES (106, 'Franck', 'Niyonzima',      0, DATE '2025-02-03', NULL);
INSERT INTO employees VALUES (107, 'Grace',  'Mukamana', 275000, DATE '2030-01-01', 40);

COMMIT;

SELECT * FROM departments;
SELECT * FROM employees;
