--
-- Seção 11 
-- Exibindo dados a partir de Múltiplas Tabelas
--
-- Aula 1 - Exibindo dados a partir de Múltiplas Tabelas
--

-- Utilizando Prefixos Coluna com Nomes de Tabela 

SELECT employees.employee_id, employees.last_name, 
       employees.department_id, departments.department_name
FROM   employees JOIN departments 
       ON (employees.department_id = departments.department_id);

-- Utilizando Alias de Tabela

SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e JOIN departments d
ON     (e.department_id = d.department_id);

-- Utilizando Natural Joins

SELECT  department_id, department_name, location_id, city
FROM    departments
NATURAL JOIN locations;

-- JOIN com a Cláusula USING

SELECT e.employee_id, e.last_name, d.location_id, department_id, d.department_name
FROM employees e
  JOIN departments d USING (department_id);

-- Join com a Cláusula ON

SELECT e.employee_id, e.last_name, e.department_id, d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

-- Joins utilizando várias tabelas com a Cláusula ON

SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM employees e
  JOIN jobs        j ON (e.job_id = j.job_id)
  JOIN departments d ON (e.department_id = d.department_id)
  JOIN locations   l ON (d.location_id = l.location_id)
ORDER BY e.employee_id;
  
-- Incluindo condições adicionais a condição de Join na cláusula WHERE

SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON  (e.department_id = d.department_id)
WHERE (e.salary BETWEEN 10000 AND 15000);

-- Incluindo condições adicionais a condição de Join utilizando AND

SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id) AND
   (e.salary BETWEEN 10000 AND 15000);
   
-- Self Join Utilizando a Cláusula ON

SELECT empregado.employee_id "Id empregado", empregado.last_name "Sobrenome empregado",
       gerente.employee_id "Id gerente", gerente.last_name "Sobrenome gerente"
FROM employees empregado JOIN employees gerente
ON (empregado.manager_id = gerente.employee_id)
ORDER BY empregado.employee_id;

--
-- Seção 11 
-- Exibindo dados a partir de Múltiplas Tabelas
--
-- Aula 2 - Nonequijoins
--

-- Nonequijoins

-- Removendo a Tabela JOB_GRADES

DROP TABLE job_grades;

-- Criando a tabela JOB_GRADES

CREATE TABLE job_grades (
 grade_level  VARCHAR2 (2) NOT NULL,
 lowest_sal    NUMBER (11,2),
 highest_sal   NUMBER (11,2),
 CONSTRAINT job_grades_pk PRIMARY KEY (grade_level));
 
-- Inserindo linhas na tabela JOB_GRADES

INSERT INTO job_grades VALUES ('A',1000,2999); 
INSERT INTO job_grades VALUES ('B',3000,5999);
INSERT INTO job_grades VALUES ('C',6000,9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);

-- Efetivando a Transação

COMMIT;

-- Nonequijoins

SELECT   e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
FROM     employees e 
  JOIN   job_grades j
     ON  NVL(e.salary,0) BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY e.salary;

--
-- Seção 11 - Aula 2
-- Exibindo dados a partir de Múltiplas Tabelas
--

-- Nonequijoins

-- Removendo a Tabela JOB_GRADES

DROP TABLE job_grades;

-- Criando a tabela JOB_GRADES

CREATE TABLE job_grades (
 grade_level  VARCHAR2 (2) NOT NULL,
 lowest_sal    NUMBER (11,2),
 highest_sal   NUMBER (11,2),
 CONSTRAINT job_grades_pk PRIMARY KEY (grade_level));
 
-- Inserindo linhas na tabela JOB_GRADES

INSERT INTO job_grades VALUES ('A',1000,2999); 
INSERT INTO job_grades VALUES ('B',3000,5999);
INSERT INTO job_grades VALUES ('C',6000,9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);

-- Efetivando a Transação

COMMIT;

SELECT *
FROM   job_grades;

-- Nonequijoins

SELECT   e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
FROM     employees e 
  JOIN   job_grades j
     ON  NVL(e.salary,0) BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY e.salary;

SELECT   e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
FROM     employees e 
  JOIN   job_grades j
     ON  NVL(e.salary,0) >= j.lowest_sal AND 
         NVL(e.salary,0) <= j.highest_sal
ORDER BY e.salary;

--
-- Seção 11 
-- Exibindo dados a partir de Múltiplas Tabelas
--
-- Aula 3 -INNER Joins 
-- 

-- Join com a Cláusula ON

SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM   employees e
  INNER JOIN jobs        j ON e.job_id = j.job_id
  INNER JOIN departments d ON d.department_id = e.department_id
  INNER JOIN locations   l ON d.location_id = l.location_id
ORDER BY e.employee_id;

SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM   employees e
  JOIN jobs        j ON e.job_id = j.job_id
  JOIN departments d ON d.department_id = e.department_id
  JOIN locations   l ON d.location_id = l.location_id
ORDER BY e.employee_id;

-- Utilizando Natural Joins

SELECT  department_id, department_name, location_id, city
FROM    departments
NATURAL INNER JOIN locations;

SELECT  department_id, department_name, location_id, city
FROM    departments
NATURAL JOIN locations;

-- JOIN com a Cláusula USING

SELECT e.employee_id, e.last_name, d.location_id, department_id, d.department_name
FROM employees e
  INNER JOIN departments d USING (department_id);
  
SELECT e.employee_id, e.last_name, d.location_id, department_id, d.department_name
FROM employees e
  JOIN departments d USING (department_id);
  
--
-- Seção 11 
-- Exibindo dados a partir de Múltiplas Tabelas
--
-- Aula 4 - OUTER JOINS

-- LEFT OUTER JOIN

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
     ON (e.department_id = d.department_id) 
ORDER BY d.department_id;

-- RIGHT OUTER JOIN

SELECT d.department_id, d.department_name, e.first_name, e.last_name
FROM employees e RIGHT OUTER JOIN departments d
     ON (e.department_id = d.department_id) 
ORDER BY d.department_id;

-- FULL OUTER JOIN

SELECT d.department_id, d.department_name, e.first_name, e.last_name
FROM   employees e FULL OUTER JOIN departments d
     ON (e.department_id = d.department_id) 
ORDER BY d.department_id;

--
-- Seção 11 
-- Exibindo dados a partir de Múltiplas Tabelas
--
-- Aula 6 - Joins utilizando sintaxe Oracle
-- 

-- EquiJoin utilizando Sintaxe Oracle

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
FROM   employees e,
       departments d
WHERE  (e.department_id = d.department_id)
ORDER BY e.department_id;

-- Joins entre várias tabelas utilizando Sintaxe Oracle

SELECT e.employee_id, j.job_title, d.department_name, l.city, l.state_province, l.country_id
FROM   employees e,
       jobs j,
       departments d, 
       locations l
WHERE (e.job_id = j.job_id)               AND
      (d.department_id = e.department_id) AND
      (d.location_id = l.location_id)
ORDER BY e.employee_id;

-- Incluindo condições adicionais a condição de Join utilizando AND

SELECT e.employee_id, e.salary, j.job_title, 
       d.department_name, l.city, l.state_province, l.country_id
FROM   employees e,
       jobs j,
       departments d, 
       locations l
WHERE (e.job_id = j.job_id)  AND
      (d.department_id = e.department_id) AND
      (d.location_id = l.location_id)     AND
      (e.salary >= 1000)
ORDER BY e.employee_id;


-- NonequiJoin Utilizando Sintaxe Oracle

SELECT e.employee_id, e.salary, j.grade_level, j.lowest_sal, j.highest_sal
FROM   employees e,
       job_grades j
WHERE  NVL(e.salary,0) BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY e.salary;

-- Outer Join Utilizando Sintaxe Oracle

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM   employees e,
       departments d
WHERE  e.department_id = d.department_id(+) 
ORDER BY e.department_id;

SELECT e.first_name, e.last_name, d.department_id, d.department_name
FROM   employees e,
       departments d
WHERE  e.department_id(+) = d.department_id 
ORDER BY e.first_name;

-- Self-join Utilizando Sintaxe Oracle

SELECT empregado.employee_id "Id empregado", empregado.last_name "Sobrenome empregado",
       gerente.employee_id "Id gerente", gerente.last_name "Sobrenome gerente"
FROM   employees empregado,
       employees gerente
WHERE (empregado.manager_id = gerente.employee_id)
ORDER BY empregado.employee_id;

DESC employees

-- Outer Join e Self Join Utilizando Sintaxe Oracle

SELECT empregado.employee_id "Id empregado", empregado.last_name "Sobrenome empregado",
       gerente.employee_id "Id gerente", gerente.last_name "Sobrenome gerente"
FROM   employees empregado,
       employees gerente
WHERE (empregado.manager_id = gerente.employee_id(+))
ORDER BY empregado.employee_id;

-- Produto Cartesiano

SELECT e.employee_id, e.first_name, e.last_name, j.job_id, j.job_title
FROM   employees e, jobs j;

-- Corrigindo Produto Cartesiano

SELECT e.employee_id, e.first_name, e.last_name, j.job_id, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id;