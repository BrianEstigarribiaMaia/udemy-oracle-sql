--SESSÃO 13 e 14 DO CURSO DE ORACLE SQL UDEMY

--seção 13 operadores SET

-- utilizando o operador UNION
SELECT employee_id,
       job_id,
       hire_date,
       salary
  FROM employees
 WHERE department_id IN ( 60, 90, 100 )
UNION
SELECT employee_id,
       job_id,
       hire_date,
       salary
  FROM employees
 WHERE job_id = 'IT_PROG'
 ORDER BY employee_id;

--utiliazando o operador UNION ALL
SELECT employee_id,
       job_id,
       hire_date,
       salary
  FROM employees
 WHERE job_id = 'IT_PROG'
UNION ALL
SELECT employee_id,
       job_id,
       hire_date,
       salary
  FROM employees
 WHERE department_id = 60
 ORDER BY employee_id;
 
 --utilizando o operador INTERSECT
SELECT employee_id,
       job_id
  FROM employees
 WHERE job_id = 'IT_PROG'
INTERSECT
SELECT employee_id,
       job_id
  FROM employees
 WHERE department_id IN ( 60, 90, 100 )
 ORDER BY employee_id;
 
--utilizando o operador MINUS
SELECT employee_id,
       job_id
  FROM employees
 WHERE department_id IN ( 60, 90, 100 )
MINUS
SELECT employee_id,
       job_id
  FROM employees
 WHERE job_id = 'IT_PROG'
 ORDER BY employee_id;
 
 --utilizando varios operadores set
SELECT employee_id,
       job_id,
       hire_date,
       salary
  FROM employees
 WHERE department_id IN ( 60, 90, 100 )
UNION
( SELECT employee_id,
         job_id,
         hire_date,
         salary
  FROM employees
 WHERE job_id = 'IT_PROG'
INTERSECT
SELECT employee_id,
       job_id,
       hire_date,
       salary
  FROM employees
 WHERE salary > 10000
)
 ORDER BY employee_id;
 
 
 -------------------------------------------------------------------------------
 --seção 14 DML MANIPULAÇÃO DE DADOS 
 
 --Comando Insert 
--Comando Insert 

INSERT INTO departments (
department_id,
department_name,
manager_id,
location_id
) VALUES (
280,
'Project Management',
103,
1400
);

-- inserindo linhas com valores nulos (explicito)

INSERT INTO departments VALUES (
290,
'Data Science',
NULL,
NULL
);

-- insert de valores nulos implicito
INSERT INTO departments (
department_id,
department_name
) VALUES (
300,
'Business Intelligence'
);

DESC departments

COMMIT;

-- inserindo valores especiais retornados de funções

INSERT INTO employees (
employee_id,
first_name,
last_name,
email,
phone_number,
hire_date,
job_id,
salary,
commission_pct,
manager_id,
department_id
) VALUES (
207,
'Rock',
'Balboa',
'DROCK',
'525.342.234',
sysdate,
'IT_PROG',
7000,
NULL,
103,
60
);
            
 -- UTILIZANDO data e hora especificas

INSERT INTO employees (
employee_id,
first_name,
last_name,
email,
phone_number,
hire_date,
job_id,
salary,
commission_pct,
manager_id,
department_id
) VALUES (
208,
'Vito',
'Corleone',
'VCORL',
'525.342.237',
TO_DATE('11/02/2020', 'DD/MM/YYYY'),
'IT_PROG',
20000,
NULL,
103,
60
);

SELECT *
  FROM employees
 ORDER BY employee_id DESC;

COMMIT;


----- utilizando variaveis de substituição
SELECT *
  FROM departments
 ORDER BY department_id DESC;

INSERT INTO departments (
department_id,
department_name,
location_id
) VALUES (
&department_id,
'&department_name',
&location_id
);

COMMIT;

--- inserindo linhas apartir de uma subconsulta 
CREATE TABLE sales_reps (
id NUMBER(6, 0),
name VARCHAR2(20),
salary NUMBER(8, 2),
comission_pct NUMBER(2, 2)
);

INSERT INTO sales_reps (
id,
name,
salary,
comission_pct
)
SELECT employee_id,
       last_name,
       salary,
       commission_pct
  FROM employees
 WHERE job_id = 'SA_REP';

COMMIT;

--- utilizando comando update 

UPDATE employees
   SET
salary = salary * 1.2;

ROLLBACK;

UPDATE employees
   SET
salary = salary * 1.2
 WHERE last_name = 'King';

SELECT last_name,
       salary
  FROM employees
 WHERE last_name = 'King';

UPDATE employees
   SET job_id = ( SELECT job_id
                 FROM employees
                WHERE employee_id = 141
                ),
       salary = ( SELECT salary
                    FROM employees
                   WHERE employee_id = 141
                )
 WHERE employee_id = 140;

COMMIT;

-- Utilizando o comando DELETE

DELETE FROM countries
 WHERE country_name = 'Nigeria';

ROLLBACK;

-- Utilizando o comando ROLLBACK

DELETE FROM employees
 WHERE employee_id = 208;

COMMIT;

-- Cláusula FOR UPDATE no comando SELECT 

SELECT employee_id,
       salary,
       commission_pct,
       job_id
  FROM employees
 WHERE job_id = 'SA_REP'
FOR UPDATE
 ORDER BY employee_id;

COMMIT;

SELECT e.employee_id,
       e.salary,
       e.commission_pct
  FROM employees e
  JOIN departments d USING ( department_id )
 WHERE job_id = 'ST_CLERK'
   AND location_id = 1500
FOR UPDATE OF e.salary
 ORDER BY e.employee_id;

COMMIT;