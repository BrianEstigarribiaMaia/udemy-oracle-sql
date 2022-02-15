--
-- Oracle SQL Avançado 
--
-- Seção 24 - Índices
--
-- Aula 6 - Criando Índice para Primary Key na criação da Tabela

-- Criando Índice para Primary Key na criação da Tabela com nome default

DROP TABLE projects;

CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL 
   CONSTRAINT project_id_pk PRIMARY KEY,
 project_code  VARCHAR2(10) NOT NULL,
 project_name  VARCHAR2(100) NOT NULL,
 CREATION_DATE DATE DEFAULT sysdate NOT NULL,
 START_DATE    DATE,
 END_DATE      DATE,
 STATUS        VARCHAR2(20) NOT NULL,
 PRIORITY      VARCHAR2(10) NOT NULL,
 BUDGET        NUMBER(11,2) NOT NULL,
 DESCRIPTION   VARCHAR2(400) NOT NULL);
 
 -- Consultando o Indice

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
WHERE ix.table_name = 'PROJECTS'
ORDER BY ix.index_name, ic.column_position; 

-- Criando Índice para Primary Key na criação da Tabela com um nome específico

DROP TABLE projects;

CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL 
   CONSTRAINT project_id_pk PRIMARY KEY 
   USING INDEX (CREATE INDEX project_id_idx ON projects (project_id)),
 project_code  VARCHAR2(10) NOT NULL,
 project_name  VARCHAR2(100) NOT NULL,
 CREATION_DATE DATE DEFAULT sysdate NOT NULL,
 START_DATE    DATE,
 END_DATE      DATE,
 STATUS        VARCHAR2(20) NOT NULL,
 PRIORITY      VARCHAR2(10) NOT NULL,
 BUDGET        NUMBER(11,2) NOT NULL,
 DESCRIPTION   VARCHAR2(400) NOT NULL);
 
 -- Consultando o Indice

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
WHERE ix.table_name = 'PROJECTS'
ORDER BY ix.index_name, ic.column_position; 

-- Criando Índice para Primary Key na criação da Tabela com propriedades específicas

DROP TABLE projects;

CREATE TABLE projects
(project_id    NUMBER(6)    NOT NULL 
   CONSTRAINT project_id_pk PRIMARY KEY 
   USING INDEX (CREATE INDEX project_id_idx ON projects (project_id)
                TABLESPACE USERS),
 project_code  VARCHAR2(10) NOT NULL,
 project_name  VARCHAR2(100) NOT NULL,
 CREATION_DATE DATE DEFAULT sysdate NOT NULL,
 START_DATE    DATE,
 END_DATE      DATE,
 STATUS        VARCHAR2(20) NOT NULL,
 PRIORITY      VARCHAR2(10) NOT NULL,
 BUDGET        NUMBER(11,2) NOT NULL,
 DESCRIPTION   VARCHAR2(400) NOT NULL);
 
-- Consultando o Indice

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
WHERE ix.table_name = 'PROJECTS'
ORDER BY ix.index_name, ic.column_position; 

-- Seção 24 - Índices
--
-- Aula 7 - Criando Índice para Primary Key após a criação da Tabela

-- Criando Índice para Primary Key após a criação da Tabela com o mesmo nome da constraint

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

ALTER TABLE projects  
ADD CONSTRAINT project_id_pk PRIMARY KEY (project_id);

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
WHERE ix.table_name = 'PROJECTS'
ORDER BY ix.index_name, ic.column_position; 

-- Criando Índice para Primary Key após a criação da Tabela com um nome específico e propriedades específicas

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

CREATE UNIQUE INDEX project_id_idx ON projects (project_id)
TABLESPACE users;

ALTER TABLE projects  
ADD CONSTRAINT project_id_pk PRIMARY KEY (project_id) 
  USING INDEX project_id_idx;
  
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
WHERE ix.table_name = 'PROJECTS'
ORDER BY ix.index_name, ic.column_position; 

-- Seção 24 - Índices
--
-- Aula 8 - Criando Índices baseados em Funções 

-- Criando um Índice para a coluna first_name

DROP INDEX employees_first_name_idx;

CREATE INDEX employees_first_name_idx ON employees (first_name);

SELECT *
FROM   employees
WHERE  UPPER(first_name) = 'DANIEL';

-- Analize o custo do comando no plano de execução

-- Criando um Índice baseado em Função para a coluna first_name

CREATE INDEX employees_upper_first_name_idx ON employees (UPPER(first_name));

-- Criando Índices baseados em Funções 

SELECT *
FROM   employees
WHERE  UPPER(first_name) = 'DANIEL';

-- Analize o custo do comando no plano de execução

-- Seção 24 - Índices
--
-- Aula 9 - Múltiplos Índices para as mesmas colunas

-- Múltiplos Índices para as mesmas colunas

-- Criando um Indice B-tree para coluna job_id

DROP INDEX employees_job_id_idx;

CREATE INDEX employees_job_id_idx
ON employees(job_id);

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

-- Analize o custo do comando no plano de execução

-- Criando um Indice B-tree para coluna job_id

DROP INDEX employees_job_id_idx2;

CREATE BITMAP INDEX employees_job_id_idx2
ON employees(job_id);  -- Observe a mensagem de erro

-- Resolvendo o problema

ALTER INDEX employees_job_id_idx INVISIBLE;

CREATE BITMAP INDEX employees_job_id_idx2
ON employees(job_id);  

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

-- Analize o custo do comando no plano de execução

-- Consultando os índices para a Tabela employees

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

ALTER INDEX employees_job_id_idx2 INVISIBLE;

ALTER INDEX employees_job_id_idx VISIBLE;

-- Consultando os índices para a Tabela employees

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

SELECT *
FROM   employees
WHERE  job_id = 'IT_PROG';

-- Analize o custo do comando no plano de execução

-- Consultando os índices para a Tabela employees

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