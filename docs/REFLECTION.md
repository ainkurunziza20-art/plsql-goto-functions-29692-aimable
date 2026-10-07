# Reflection (C2)

**Name:** Aimable | **Student ID:** 29692

## 1. What did I learn about GOTO?
I learned that GOTO sends the program to a label written between `<<` and `>>`, and the code continues from that line. The label must be in the same block or in an outer block. I can jump out of an IF or a loop, but I cannot jump into one. In A3, my first block jumped into the middle of an IF block and Oracle refused it with PLS-00375: illegal GOTO statement. I fixed it by moving the label to the same level as the GOTO, and then it ran and printed "Jumped to a label in the same block - legal!".

## 2. Why is GOTO usually discouraged?
In A4 I rewrote A1 and A2 with IF / ELSIF / ELSE, and that version was much easier to read. The logic goes from top to bottom, so I do not have to search for labels to follow what happens. With GOTO the program jumps around, which makes it harder to read, test and change. This is why GOTO is called spaghetti code. Structured code gave the same output with less confusion.

## 3. What did I learn about functions?
A function must return a value, and a procedure does not have to. Because a stored function returns a value, I can use it inside a SQL statement. In B5 I used fn_dept_name, fn_annual_salary, fn_calculate_tax and fn_years_of_service in one SELECT and also in a WHERE clause. I wrote the logic once and reused it for every employee, for example Alice Uwase showed an annual salary of 5,400,000 and a tax of 1,200,000.

## 4. How did exception handling help?
Exception handling stopped my functions from crashing on bad data. In B1, B2 and B4, NO_DATA_FOUND is caught, so an unknown employee returns NULL and an unknown department returns "Unknown" instead of an error. In B2 and B3 I used RAISE_APPLICATION_ERROR (-20001 for a future hire date and -20002 for a negative salary) to give clear messages. My test file showed all of these cases passing.

## 5. Challenges and how I solved them
In B5, the query failed with ORA-20001 for employee 107, who has a hire date in the future. Oracle ran fn_years_of_service on that row before applying my date filter, so the function raised my error. I fixed it by wrapping the call in a CASE so the function only runs when the hire date is not in the future. I also got ORA-00904 for fn_calculate_tax because the function had not been created yet, and running the B3 file and checking that it was VALID solved it.

## 6. C1 Payroll Validator
fn_validate_payroll checks an employee in order: the employee exists, the salary is above zero, the department is valid, and the hire date is not in the future. It uses the functions I wrote before, such as fn_annual_salary and fn_dept_name. When a check fails, it sets an error message and uses GOTO to jump to one exit point that returns the message. Employees 101 to 105 returned VALID. Employee 106 returned that the salary must be greater than zero, and employee 107 returned that the hire date is in the future.
