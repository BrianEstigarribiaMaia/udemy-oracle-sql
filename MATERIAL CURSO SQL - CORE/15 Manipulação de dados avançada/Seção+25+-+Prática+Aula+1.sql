--
-- Oracle SQL Avançado 
--
-- Seção 25 - Manipulação de Dados Avançada
--
-- Aula 1 - Utilizando a opção DEFAULT nos comandos INSERT ou UPDATE

-- Utilizando a opção DEFAULT nos comandos INSERT ou UPDATE

-- Conectar como usuário HR

-- Criando uma Tabela com a opção DEFAULT para uma coluna

DROP TABLE projects;

CREATE TABLE projects
(project_id    NUMBER(6)  NOT NULL,
 project_code  VARCHAR2(10) NOT NULL,
 project_name  VARCHAR2(100) NOT NULL,
 CREATION_DATE DATE DEFAULT sysdate NOT NULL,
 START_DATE    DATE,
 END_DATE      DATE,
 STATUS        VARCHAR2(20) NOT NULL,
 PRIORITY      VARCHAR2(10)  NOT NULL,
 BUDGET        NUMBER(11,2) NOT NULL,
 DESCRIPTION   VARCHAR2(400) NOT NULL);
 
 -- Utilizando a palavra chave (keyword) DEFAULT para o valor de uma coluna
 
 INSERT INTO projects (project_id, project_code, project_name, creation_date, status, priority, budget, description)
 VALUES (1, 'PROJERP001', 'Oracle ERP', default, 'PLANNING', 'HIGH', 1000000, 'Implantação do Oracle ERP');
 
 COMMIT;
 
 -- Consultando a Tabela 
 
 SELECT *
 FROM projects;
 
 -- Seção 25 - Manipulação de Dados Avançada
--
-- Aula 3 - Comando INSERT ALL Incondicional

-- Comando INSERT ALL Incondicional

-- Conectar como usuário HR

-- Limpando a Tabela employees

DELETE FROM employees
WHERE employee_id >= 207;

COMMIT;

-- Criando a Tabela salary_history

DROP TABLE salary_history;

CREATE TABLE salary_history
AS
SELECT employee_id, extract(year from hire_date) year, extract(month from hire_date) month, salary, commission_pct
FROM employees
WHERE hire_date <= sysdate - 365;

SELECT *
FROM salary_history;

-- Criando a Tabela employees_history

DROP TABLE employees_history;

CREATE TABLE employees_history
AS
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  hire_date <= sysdate - 365;

SELECT *
FROM   employees_history;

-- Comando INSERT ALL Incondicional

INSERT ALL
  INTO employees_history VALUES (employee_id, first_name, last_name, hire_date)
  INTO salary_history    VALUES (employee_id, extract(year from hire_date), extract(month from hire_date), salary, commission_pct)
  SELECT *
  FROM   employees
  WHERE  hire_date > sysdate-365;

-- Consultando as Tabelas destino

SELECT *
FROM   employees_history
WHERE  hire_date > sysdate-365;

SELECT *
FROM   salary_history
WHERE  year = 2020;

-- Inserindo um novo Empregado

INSERT INTO EMPLOYEES
VALUES (207, 'Carl', 'Palmer', 'CPALMER', '515.123.8182', sysdate, 'IT_PROG', 15000,null,103,60);

COMMIT;

-- Comando INSERT ALL Incondicional

INSERT ALL
INTO employees_history VALUES (employee_id, first_name, last_name, hire_date)
INTO salary_history VALUES (employee_id, extract(year from hire_date), extract(month from hire_date), salary, commission_pct)
SELECT *
FROM employees
WHERE hire_date > sysdate-365;

COMMIT;

-- Consultando as Tabelas destino

SELECT *
FROM   employees_history
WHERE  hire_date > sysdate-365;

SELECT *
FROM   salary_history
WHERE  year = 2020;

-- Seção 25 - Manipulação de Dados Avançada
--
-- Aula 4 - Comando INSERT ALL Condicional

-- Comando INSERT ALL Condicional

-- Conectar como usuário HR

-- Limpando a Tabela employees

DELETE FROM employees
WHERE employee_id >= 207;

COMMIT;

-- Criando a Tabela salary_history

DROP TABLE salary_history;

CREATE TABLE salary_history
AS
SELECT employee_id, extract(year from hire_date) year, extract(month from hire_date) month, salary, commission_pct
FROM   employees
WHERE  hire_date <= sysdate - 365;

SELECT *
FROM   salary_history;

-- Criando a Tabela employees_history

DROP TABLE employees_history;

CREATE TABLE employees_history
AS
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  hire_date <= sysdate - 365;

SELECT *
FROM   employees_history;

-- Criando a Tabela it_programmers

DROP TABLE it_programmers;

CREATE TABLE it_programmers
AS
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  job_id = 'IT_PROG' AND 
       hire_date <= sysdate - 365;

SELECT *
FROM   it_programmers;

-- Criando a Tabela living_in_us

DROP TABLE living_in_us;

CREATE TABLE living_in_us
AS
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  (hire_date <= sysdate - 365) AND
        department_id IN  (SELECT department_id  
                           FROM   departments 
                           WHERE  location_id IN (SELECT location_id 
                                                  FROM locations
                                                  WHERE country_id = 'US'));

SELECT *
FROM living_in_us;

-- Inserindo um Empregados

-- Inserindo uns novos Empregados

INSERT INTO EMPLOYEES
VALUES (207, 'Carl', 'Palmer', 'CPALMER', '515.123.8182', sysdate, 'IT_PROG', 15000,null,103,60);
INSERT INTO EMPLOYEES
VALUES (208, 'Keith', 'Richards', 'KRICHARDS', '515.123.8183', sysdate, 'IT_PROG', 20000,null,103,60);

COMMIT;

-- Comando INSERT ALL Condicional

INSERT ALL
  WHEN hire_date > sysdate - 365 
  THEN
       INTO employees_history VALUES (employee_id, first_name, last_name, hire_date)
       INTO salary_history    VALUES (employee_id, extract(year from hire_date), extract(month from hire_date), salary, commission_pct)
  WHEN  (hire_date > sysdate - 365) AND 
        (job_id = 'IT_PROG')
  THEN 
       INTO it_programmers    VALUES (employee_id, first_name, last_name, hire_date)
  WHEN (hire_date > sysdate - 365) AND
        department_id IN 
                           (SELECT department_id  
                            FROM departments 
                            WHERE location_id IN (SELECT location_id 
                                                  FROM   locations
                                                  WHERE   country_id = 'US'))
  THEN
       INTO living_in_us      VALUES (employee_id, first_name, last_name, hire_date)        
  SELECT *
  FROM employees
  WHERE hire_date > sysdate-365;

-- Consultando as Tabelas destino

SELECT *
FROM   employees_history
WHERE  hire_date > sysdate-365;

SELECT *
FROM   salary_history
WHERE  year = 2020;

SELECT *
FROM it_programmers
WHERE  hire_date > sysdate-365;

SELECT *
FROM living_in_us
WHERE  hire_date > sysdate-365;
