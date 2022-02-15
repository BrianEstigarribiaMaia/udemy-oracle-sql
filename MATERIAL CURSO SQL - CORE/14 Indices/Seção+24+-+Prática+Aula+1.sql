-- Seção 19 
-- Criando e Gerenciando Índices
--
-- Aula 1 - Criando e Gerenciando Índices
--

-- Analize o custo do comando no plano de execução

DROP INDEX emp_name_ix;
DROP INDEX employees_last_name_idx;
DROP INDEX employees_name_idx;

SELECT *
FROM  employees
WHERE last_name = 'Himuro';

-- Criando um Indice Simples

CREATE INDEX employees_last_name_idx
ON employees(last_name);

-- Analize o custo do comando no plano de execução

SELECT *
FROM  employees
WHERE last_name = 'Himuro';

-- Criando um Indice Composto

CREATE INDEX employees_last_name_first_name_idx
ON employees(last_name, first_name);

-- Analize o custo do comando no plano de execução

SELECT *
FROM  employees
WHERE last_name = 'Himuro' AND 
      first_name = 'Guy';

-- Reconstruindo e reorganizando um Índice

ALTER INDEX employees_last_name_first_name_idx REBUILD;

-- Removendo um Índice

DROP INDEX employees_last_name_idx;

-- Consultando Indices

SELECT ix.index_name,
       ic.column_position,
       ic.column_name,
       ix.index_type,
       ix.uniqueness,
       ix.status
FROM    user_indexes ix
  JOIN user_ind_columns ic ON (ix.index_name = ic.index_name) AND 
                              (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position; 

-- Removendo um Índice

DROP INDEX employees_last_name_idx;

DROP INDEX employees_last_name_first_name_idx;


--
-- Oracle SQL Avançado 
--
-- Seção 24 - Índices
--
-- Aula 1 - Índices

-- Índices

-- Conectar como usuário HR

DROP INDEX emp_name_ix;
DROP INDEX employees_last_name_idx;
DROP INDEX employees_name_idx;
DROP INDEX employees_last_name_first_name_idx;
DROP INDEX employees_job_id_idx;
DROP INDEX employees_phone_number_idx;

-- FULL TABLE SCAN

SELECT *
FROM   employees;

-- Analize o custo do comando no plano de execução

SELECT *
FROM   employees
WHERE  phone_number = '515.127.4565';

-- Analize o custo do comando sem usar índice pelo plano de execução

-- Criando um Indice Único B-tree Simples

CREATE UNIQUE INDEX employees_phone_number_idx
ON employees(phone_number);

SELECT *
FROM   employees
WHERE  phone_number = '515.127.4565';

-- Analize o custo do comando pelo plano de execução - Note que agora ele deve estar utilizando o índice criado

-- Criando um Índice Unico automaticamente na criação da Constraint de Unique

DROP INDEX employees_phone_number_idx;

ALTER TABLE employees
ADD CONSTRAINT employees_phone_number_uk UNIQUE (phone_number);

--
-- Oracle SQL Avançado 
--
-- Seção 24 - Índices
--
-- Aula 2 - Tipos de Índices 

-- Tipos de Índices 

-- Conectar como usuário HR

DROP INDEX emp_name_ix;
DROP INDEX employees_last_name_idx;
DROP INDEX employees_name_idx;
DROP INDEX employees_last_name_first_name_idx;
DROP INDEX employees_job_id_idx;
DROP INDEX employees_phone_number_idx;
ALTER TABLE employees 
DROP CONSTRAINT employees_phone_number_uk;

-- Criando um Indice B-tree Simples

DROP INDEX employees_job_id_idx;

CREATE INDEX employees_job_id_idx
ON employees(job_id);	

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

-- Analize o custo do comando no plano de execução	  

DROP INDEX employees_last_name_idx;

SELECT *
FROM   employees
WHERE  last_name = 'Himuro';

-- Analize o custo do comando no plano de execução

-- Criando um Indice Não Único B-tree Simples

CREATE INDEX employees_last_name_idx
ON employees(last_name);

SELECT *
FROM  employees
WHERE last_name = 'Himuro';

-- Analize o custo do comando no plano de execução

-- Criando um Indice Não Único B-tree Composto

CREATE INDEX employees_last_name_first_name_idx
ON employees(last_name, first_name);

SELECT *
FROM   employees
WHERE  last_name = 'Himuro' AND 
       first_name = 'Guy';

-- Analize o custo do comando no plano de execução	  

-- Criando um Indice Bitmap Simples

DROP INDEX employees_job_id_idx;

CREATE BITMAP INDEX employees_job_id_idx
ON employees(job_id);

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

-- Analize o custo do comando no plano de execução	 

SELECT COUNT(DISTINCT job_id)
FROM employees;

--
-- Seção 24 - Índices
--
-- Aula 3 - Reconstruindo e  Reorganizando Índices

-- Reconstruindo e reorganizando um Índice

ALTER INDEX employees_last_name_first_name_idx REBUILD;

-- Reconstruindo e reorganizando um Índice com opção ONLINE

ALTER INDEX employees_last_name_first_name_idx REBUILD ONLINE;

-- Seção 24 - Índices
--
-- Aula 4 - Consultando Índices 

-- Consultando Indices

SELECT ix.index_name,
       ic.column_name,
       ic.column_position,
       ix.index_type,
       ix.uniqueness,
       ix.status,
       ix.tablespace_name
FROM    user_indexes ix
  JOIN user_ind_columns ic ON (ix.index_name = ic.index_name) AND 
                              (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position; 

-- Seção 24 - Índices
--
-- Aula 5 - Removendo Índices

-- Removendo Índices

DROP INDEX employees_job_id_idx;

-- Consultando índices 

SELECT ix.index_name,
       ic.column_name,
       ic.column_position,
       ix.index_type,
       ix.uniqueness,
       ix.status,
       ix.tablespace_name,
       visibility
FROM    user_indexes ix
  JOIN user_ind_columns ic ON (ix.index_name = ic.index_name) AND 
                              (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position; 

-- Criando Índice employees_job_id_idx

CREATE INDEX employees_job_id_idx
ON employees(job_id);

-- Consultando índices 

DESC all_indexes

SELECT ix.owner,
       ix.index_name,
       ic.column_name,
       ic.column_position,
       ix.index_type,
       ix.uniqueness,
       ix.status,
       ix.tablespace_name,
       visibility
FROM    all_indexes ix
  JOIN  all_ind_columns ic ON (ix.index_name = ic.index_name) AND 
                              (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position; 

-- Removendo Índices ONLINE

DROP INDEX employees_job_id_idx ONLINE;

-- Consultando índices 

SELECT ix.index_name,
       ic.column_name,
       ic.column_position,
       ix.index_type,
       ix.uniqueness,
       ix.status,
       ix.tablespace_name,
       visibility
FROM    user_indexes ix
  JOIN user_ind_columns ic ON (ix.index_name = ic.index_name) AND 
                              (ix.table_name = ic.table_name)
WHERE ix.table_name = 'EMPLOYEES'
ORDER BY ix.index_name, ic.column_position; 