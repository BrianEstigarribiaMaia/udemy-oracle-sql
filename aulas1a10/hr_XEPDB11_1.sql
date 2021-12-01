--- SESSÕES 1 A 10 DO CURSO DE ORACLE SQL UDEMY

DESCRIBE employees;

DESC jobs;

--SELECT

SELECT
first_name,
last_name,
round(months_between(sysdate, hire_date), 0) numero_meses
FROM
employees
WHERE
hire_date = TO_DATE('17/06/2003', 'dd/mm/yyyy');

SELECT
*
FROM
jobs;

SELECT
department_id,
location_id
FROM
departments;

SELECT
employee_id,
first_name,
last_name,
salary
FROM
employees;
    
--EXPRESSÕES
SELECT
first_name,
last_name,
salary,
salary + ( 100 * 1.15 )
FROM
employees;

    
--ALIAS
SELECT
first_name "Nome",
last_name "Sobrenome",
salary AS "Salário",
commission_pct "Percentual de comissão"
FROM
employees;

--CONCATENAR STRINGS
SELECT
first_name || ' ' || last_name || ', data de admissão' || hire_date "Funcionário"
FROM
employees;

SELECT
first_name || ' ' || last_name || ', salario: ' || salary "Funcionário"
FROM
employees;
    
    
--OPERADOR PARA USAR ASPAS
SELECT
department_name || q'[ Department's Manager Id: ]' || manager_id "Departamento e Gerente"
FROM
departments;
   
    
--TIRAR RESULTADOS DUPLICADOS 
SELECT DISTINCT
last_name,
first_name
FROM
employees;

--WHERE
SELECT
employee_id,
last_name,
job_id,
department_id
FROM
employees
WHERE
department_id = 100;

SELECT
employee_id,
last_name,
job_id,
department_id
FROM
employees
WHERE
job_id = 'IT_PROG';

SELECT
last_name,
salary
FROM
employees
WHERE
salary >= 1000;

-- BETWEEEN
SELECT
last_name,
salary
FROM
employees
WHERE
salary BETWEEN 10000 AND 15000;

--IN
SELECT
employee_id,
last_name,
salary,
manager_id,
job_id
FROM
employees
WHERE
job_id IN ( 'IT_PROG', 'FI_ACCOUNT', 'SA_REP' );

-- LIKE
SELECT
first_name,
last_name,
job_id
FROM
employees
WHERE
first_name LIKE 'Sa%';

--NULL
SELECT
manager_id,
last_name
FROM
employees
WHERE
manager_id IS NULL;

--OPERADORES LOGICOS
--AND 
SELECT
employee_id,
last_name,
salary
FROM
employees
WHERE
salary >= 5000
AND job_id = 'IT_PROG';

--OR
SELECT
employee_id,
last_name,
salary
FROM
employees
WHERE
salary >= 5000
OR job_id = 'IT_PROG';

--NOT
SELECT
employee_id,
last_name,
salary,
manager_id,
job_id
FROM
employees
WHERE
job_id NOT IN ( 'IT_PROG', 'FI_ACCOUNT', 'SA_REP' );

--PRECEDENCIA 
SELECT
last_name,
job_id,
salary
FROM
employees
WHERE
job_id = 'SA_REP'
OR job_id = 'IT_PROG'
AND salary > 10000;

SELECT
last_name,
job_id,
salary
FROM
employees
WHERE
( job_id = 'SA_REP'
  OR job_id = 'IT_PROG' )
AND salary > 10000;

--ORDER BY 
--ASCENDENTE
SELECT
last_name,
job_id,
department_id,
hire_date
FROM
employees
ORDER BY
hire_date ASC; -- ou só hire_date

--DECRESCENTE 
SELECT
last_name,
job_id,
department_id,
hire_date
FROM
employees
ORDER BY
hire_date DESC;

--REFERENCIANDO ALIAS
SELECT
last_name,
employee_id,
salary * 12 salario_anual
FROM
employees
ORDER BY
salario_anual;

--REFERENCIANDO POSIÇÃO
SELECT
last_name,
employee_id,
salary * 12 salario_anual
FROM
employees
ORDER BY
3;

--MULTIPLAS COLUNAS 
SELECT
last_name,
employee_id,
salary
FROM
employees
ORDER BY
employee_id,
salary DESC;

--VARIAVEIS DE SUBSTITUIÇÃO
SELECT
employee_id,
last_name,
salary,
department_id
FROM
employees
WHERE
employee_id = &employee_id;  --&& numerico

SELECT
last_name,
salary * 12,
department_id,
job_id
FROM
employees
WHERE
job_id = '&job_id'; -- '' char e date 

--COMANDO DEFINE 
SELECT
last_name,
salary * 12,
department_id,
job_id,
employee_id
FROM
employees
WHERE
employee_id = &employee_id;

DEFINE employee_id

UNDEFINE employee_id

-- Funções de conversão Maiúsculo & Minúsculo

SELECT
employee_id,
last_name,
department_id
FROM
employees
WHERE
last_name = 'KING';

SELECT
employee_id,
last_name,
department_id
FROM
employees
WHERE
upper(last_name) = 'KING';

-- Funções de Manipulação de Caracteres

SELECT
concat(' Curso: ', 'Introdução ORACLE 19c'),
substr('Introdução ORACLE 19c', 1, 11),
length('Introdução ORACLE 19c'),
instr('Introdução ORACLE 19c', 'ORACLE')
FROM
dual;

--Funções do tipo number
SELECT
round(45.927, 2),
round(45.923, 0)
FROM
dual;

SELECT
trunc(45.927, 2),
trunc(45.923, 0)
FROM
dual;

SELECT
mod(13, 6) resto
FROM
dual;

SELECT
abs(- 9),
sqrt(9)
FROM
dual;

--FUNÇÕES DO TIPO DATE
SELECT
sysdate
FROM
dual;

DESC dual;

SELECT
*
FROM
dual;

SELECT
300 * 1.25
FROM
dual;

--CALCULOS COM DATE 
SELECT
sysdate + 30,
sysdate - 30
FROM
dual;

SELECT
last_name,
round((sysdate - hire_date) / 7, 2) "SEMANAS DE TRABALHO"
FROM
employees;

--OUTRAS FUNÇÕES DATE 
SELECT
first_name,
last_name,
round(months_between(sysdate, hire_date), 2) "MESES DE TRABALHO"
FROM
employees;

SELECT
sysdate,
to_char(trunc(sysdate), 'dd/mm/yy HH24:MI:SS')
FROM
dual;

--TO_CHAR datas
SELECT
last_name,
to_char(hire_date, 'DD, "de" Month "de" YYYY') dt_admissão
FROM
employees;

SELECT
sysdate,
to_char(sysdate, 'dd/mm/yyyy HH24:MI:SS') data
FROM
dual;

--TO_NUMBER
SELECT
to_number('1200,50')
FROM
dual;

--TO DATE 
SELECT
TO_DATE('06/02/2020', 'dd/mm/yyyy') data
FROM
dual;

-- FUNÇÕES NVL, COALESCE, NVL2
SELECT
last_name,
salary,
nvl(commission_pct, 0),
salary * 12 salario_anual,
( salary * 12 ) + ( salary * 12 * nvl(commission_pct, 0) ) remuneração_anual
FROM
employees;

SELECT
last_name,
employee_id,
commission_pct,
manager_id,
coalesce(to_char(commission_pct), to_char(manager_id), 'Sem percentual de comisão e sem gerente')
FROM
employees;

SELECT
last_name,
salary,
commission_pct,
nvl2(commission_pct, 10, 0) percentual_alterado
FROM
employees;

--CASE e DECODE
SELECT
last_name,
job_id,
salary,
CASE job_id
WHEN 'IT_PROG'  THEN
1.10 * salary
WHEN 'ST_CLERK' THEN
1.15 * salary
WHEN 'SA_REP'   THEN
1.20 * salary
ELSE
salary
END "NOVO SALARIO"
FROM
employees;

SELECT
last_name,
job_id,
salary,
decode(job_id, 'IT_PROG', 1.10 * salary, 'ST_CLERK', 1.15 * salary,
       'SA_REP', 1.20 * salary, salary) "NOVO SALARIO"
FROM
employees;

--FUNÇÕES DE GRUPO 
-- AVG E SUM
SELECT
AVG(salary),
SUM(salary)
FROM
employees;

-- MIN E MAX
SELECT
MIN(hire_date),
MAX(hire_date)
FROM
employees;

SELECT
MIN(salary),
MAX(salary)
FROM
employees;

-- COUNT
SELECT
COUNT(*)
FROM
employees;

SELECT
COUNT(DISTINCT department_id) -- contagem de departamentos sem repetição
FROM
employees;

SELECT
COUNT(department_id)
FROM
employees;

-- TRATAMENTO DE NULOS 
--onde tem valores nulos trocar por 0 com a função nvl
SELECT
AVG(nvl(commission_pct, 0))  --media de percentual de comissão
FROM
employees;

--GROUP BY e ORDER BY
select department_id, trunc(avg(salary),2) as MEDIA_SALARIAL_DPT
from employees
group by department_id
order by department_id;

select department_id, job_id, sum(salary) as SOMA_SALARIOS_DPT
from employees
group by department_id, job_id
order by department_id, job_id;

--INCORRETA 
select department_id, sum(salary)
from employees;

--CORRETA 
select department_id, sum(salary)
from employees
group by department_id;

--INCORRETA
SELECT department_id, max(salary)
FROM employees
WHERE max(salary) > 10000
GROUP BY department_id;

--CORRETA
SELECT department_id, max(salary)
FROM employees
GROUP BY department_id
having max(salary) > 10000;

--HAVING
select job_id, sum(salary) as SOMA_SALARIO_SETOR
from employees
where job_id <> 'SA_REP'
group by job_id
having sum(salary) > 10000
order by sum(salary);

--ANINHANDO FUNÇÕES DE GRUPO
SELECT max(avg(salary))
from employees
group by department_id;
