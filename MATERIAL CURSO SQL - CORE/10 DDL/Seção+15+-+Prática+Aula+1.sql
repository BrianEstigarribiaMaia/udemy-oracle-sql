--
-- Seção 15 
-- Comandos DDL 
--
-- Aula 1 - Criando e Gerenciando Tabelas
--

-- Consultando os objetos do schema do usuario HR

SELECT *
FROM   user_objects
ORDER BY Object_type;

-- Criando Tabelas

DROP TABLE projects;
CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL,
 project_code  VARCHAR2(10) NOT NULL,
 project_name  VARCHAR2(100) NOT NULL,
 CREATION_DATE DATE DEFAULT sysdate NOT NULL,
 START_DATE    DATE,
 END_DATE      DATE,
 STATUS        VARCHAR2(20) NOT NULL,
 PRIORITY      VARCHAR2(10) NOT NULL,
 BUDGET        NUMBER(11,2) NOT NULL,
 DESCRIPTION   VARCHAR2(400) NOT NULL);
 
 DESC projects
 
 SELECT *
 FROM projects;
 
DROP TABLE TEAMS;

CREATE TABLE TEAMS
(project_id    NUMBER(6)  NOT NULL,
 employee_id   NUMBER(6)  NOT NULL);

-- Consultando a Estrutura da Tabela

DESC projects

DESC teams;

-- Tipo ROWID

DESC employees

SELECT employee_id, first_name, rowid, LENGTH(rowid)
from   employees
WHERE rowid = 'AAAR6YAAEAAALBbAAE';

-- Consultando as Tabelas existentes pelo Dicionário de Dados

DESC user_tables

SELECT table_name
FROM   user_tables;

-- Consultando os Objetos do tipo TABLE do usuário

DESC user_objects

SELECT object_name, object_type
FROM   user_objects
WHERE  object_type = 'TABLE';

-- Criando uma Tabela utilizando uma Sub-consulta

DROP TABLE employees_department60;

CREATE TABLE employees_department60
AS
SELECT employee_id, last_name,salary*12 ANNSAL, hire_date
FROM employees
WHERE department_id = 60;

DESC employees_department60

SELECT *
FROM   employees_department60;

-- TRUNCATE TABLE

TRUNCATE TABLE employees_department60;

SELECT *
FROM   employees_department60;

-- DROP TABLE

DROP TABLE employees_department60;

SELECT *
FROM   employees_department60;

-- Consultando a Lixeira

SELECT *
FROM user_recyclebin;

--
-- Seção 15 
-- Comandos DDL 
--
-- Aula 2 - Alterando a Estrutura da Tabela
--

-- ALTER TABLE – Adicionando uma coluna

ALTER TABLE projects
ADD (department_id NUMBER(3)); 

DESC projects

-- ALTER TABLE – Removendo uma coluna

ALTER TABLE projects
DROP COLUMN department_id; 

DESC projects

-- ALTER TABLE – Adicionando uma coluna

ALTER TABLE projects
ADD (department_id NUMBER(4) NOT NULL); 

DESC projects

-- ALTER TABLE – Adicionando uma coluna

ALTER TABLE projects
MODIFY (project_code VARCHAR2(6));
                             
DESC PROJECTS
               
-- ALTER TABLE – Renomeando uma coluna

ALTER TABLE projects
RENAME COLUMN project_name TO name;

DESC projects

-- ALTER TABLE – READ ONLY

ALTER TABLE employees READ ONLY;

-- ALTER TABLE – READ WRITE

ALTER TABLE employees READ WRITE;