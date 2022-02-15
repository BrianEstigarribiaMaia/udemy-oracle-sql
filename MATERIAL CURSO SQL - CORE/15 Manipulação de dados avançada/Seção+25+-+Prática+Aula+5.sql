--
-- Oracle SQL Avançado 
--
-- Seção 25 - Manipulação de Dados Avançada
--
-- Aula 5 - Comando INSERT FIRST Condicional

-- Comando Comando INSERT FIRST Condicional

-- Conectar como usuário HR

-- Criando a Tabela low_salaries vazia

DROP TABLE low_salaries;

CREATE TABLE low_salaries
AS
SELECT employee_id, department_id, salary
FROM   employees
WHERE  1 = 2;

SELECT *
FROM   low_salaries;

-- Criando a Tabela high_salaries vazia

DROP TABLE high_salaries;

CREATE TABLE high_salaries
AS
SELECT employee_id, department_id, salary
FROM   employees
WHERE  1 = 2;

SELECT *
FROM   high_salaries;

-- Criando a Tabela average_salaries vazia

DROP TABLE average_salaries;

CREATE TABLE average_salaries
AS
SELECT employee_id, department_id, salary
FROM   employees
WHERE  1 = 2;

SELECT *
FROM   average_salaries;

-- Comando INSERT FIRST Condicional

INSERT FIRST
  WHEN salary < 5000 
  THEN
       INTO low_salaries     VALUES (employee_id, department_id, salary)
  WHEN  salary BETWEEN 5000 AND 10000
  THEN 
       INTO average_salaries VALUES (employee_id, department_id, salary)
  ELSE
       INTO high_salaries    VALUES (employee_id, department_id, salary) 
  SELECT *
  FROM   employees;


COMMIT;

-- Consultando as Tabelas destino

SELECT *
FROM low_salaries;

SELECT *
FROM average_salaries;

SELECT *
FROM high_salaries;

-- Seção 25 - Manipulação de Dados Avançada
--
-- Aula 6 - Comando INSERT Pivoting

-- Comando INSERT Pivoting

-- Conectar como usuário HR

-- Criando a Tabela job_salaries

DROP TABLE job_salaries;
CREATE TABLE job_salaries
(year  NUMBER (4) NOT NULL,
 month NUMBER (2) NOT NULL,
 it_prog NUMBER (8,2) NOT NULL, 
 sa_man NUMBER (8,2) NOT NULL, 
 st_man NUMBER (8,2) NOT NULL);
 
-- Inserindo linhas  na Tabela job_salaries

INSERT INTO job_salaries (year, month, it_prog, sa_man, st_man)
VALUES (2015, 9, 31300, 61000, 36400);

INSERT INTO job_salaries (year, month, it_prog, sa_man, st_man)
VALUES (2015, 8, 35000, 79500, 37000);

COMMIT;

-- Consultando a Tabela job_salaries

SELECT *
FROM   job_salaries;

-- Criando a Tabela job_sal

DROP TABLE job_sal;

CREATE TABLE job_sal
(year  NUMBER (4) NOT NULL,
 month NUMBER (2) NOT NULL,
 job_id VARCHAR2(10) NOT NULL, 
 total_salary NUMBER (8,2) NOT NULL);

-- Consultando a Tabela job_sal
 
SELECT *
FROM   job_sal;

-- Comando INSERT Pivoting

INSERT ALL
  INTO job_sal VALUES (year, month, 'IT_PROG', it_prog)
  INTO job_sal VALUES (year, month, 'SA_MAN', sa_man)
  INTO job_sal VALUES (year, month, 'ST_MAN', st_man)
  SELECT *
  FROM   job_salaries;
  
COMMIT;
  
-- Consultando a Tabelas origem

SELECT *
FROM   job_salaries;

-- Consultando a Tabelas destino

SELECT *
FROM   job_sal;

-- Seção 25 - Manipulação de Dados Avançada
--
-- Aula 7 - Comando MERGE

-- Comando MERGE

-- Conectar como usuário HR

-- Criando a Tabela employees_copy

DROP TABLE employees_copy;

CREATE TABLE employees_copy
AS
SELECT *
FROM   employees
WHERE  1 = 2;
  
SELECT *
FROM   employees_copy;

-- Comando MERGE

MERGE INTO employees_copy c
USING employees e
ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN
   UPDATE SET 
   c.first_name = e.first_name,
   c.last_name = e.last_name,
   c.email = e.email,
   c.phone_number = e.phone_number,
   c.hire_date = e.hire_date,
   c.job_id = e.job_id,
   c.salary = e.salary,
   c.commission_pct = e.commission_pct,
   c.manager_id = e.manager_id,
   c.department_id = e.department_id
   DELETE WHERE department_id IS NULL
WHEN NOT MATCHED THEN
  INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id,
                 e.salary, e.commission_pct, e.manager_id, e.department_id);
  
COMMIT;
  
-- Consultando as Tabelas origem employees

SELECT count(*)
FROM employees;

-- Consultando as Tabelas destino employees_copy

SELECT count(*)
FROM employees_copy;

-- Atualizando a Tabela origem employees

UPDATE employees
SET   salary = 90000
WHERE employee_id = 109;

COMMIT;

-- Comando MERGE

MERGE INTO employees_copy c
USING employees e
ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN
   UPDATE SET 
   c.first_name = e.first_name,
   c.last_name = e.last_name,
   c.email = e.email,
   c.phone_number = e.phone_number,
   c.hire_date = e.hire_date,
   c.job_id = e.job_id,
   c.salary = e.salary,
   c.commission_pct = e.commission_pct,
   c.manager_id = e.manager_id,
   c.department_id = e.department_id
   DELETE WHERE department_id IS NULL
WHEN NOT MATCHED THEN
  INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id,
                 e.salary, e.commission_pct, e.manager_id, e.department_id);
  
COMMIT;
  
-- Consultando as Tabelas origem employees

SELECT count(*)
FROM employees;

-- Consultando as Tabelas destino employees_copy

SELECT count(*)
FROM employees_copy;

SELECT *
FROM employees_copy
WHERE employee_id = 109;
