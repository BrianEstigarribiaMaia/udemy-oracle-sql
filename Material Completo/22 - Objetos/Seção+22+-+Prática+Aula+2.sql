--
-- Oracle SQL Avançado 
--
-- Seção 22 - Objetos do Banco de Dados
--
-- Aula 2 - Referenciando Objetos de outro Schema (Usuário)

-- Referenciando Objetos de outro Schema (Usuário)

-- Conectar como usuário hr

-- Consultando a Tabela employees do schema do usuário HR

SELECT *
FROM   employees;

SELECT *
FROM   hr.employees;

-- Conectar como usuário sys (DBA)

-- Criar o usuário ALUNO

-- Criar o usuário ALUNO

create user aluno
identified by aluno
default tablespace users
temporary tablespace temp
quota unlimited on users;

grant create session to aluno;


-- Criar uma conexão no SQL Developer para o usuário ALUNO para o banco XEPDB1


-- Conectar como usuário aluno

-- Consultando a Tabela employees do schema do usuário HR

SELECT *
FROM   hr.employees;

-- Erro ORA-00942: a tabela ou view não existe

-- Conectar como usuário hr ou como usuário sys (DBA)

-- Passar o privilégo SELECT no objeto hr.employees para o usuário aluno

GRANT SELECT on hr.employees to aluno;

-- Conectar como usuário aluno

SELECT *
FROM   hr.employees;

-- Conectar como usuário sys (DBA)

-- criar um sinonimo público employees para hr.employees

drop public synonym employees;

create public synonym employees for hr.employees;

-- Conectar como usuário aluno

SELECT *
FROM   employees;
