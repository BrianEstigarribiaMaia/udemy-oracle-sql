--FUN??ES SINGLE ROW
--CHAR
SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE UPPER(LAST_NAME) = 'KING';

SELECT CONCAT('Curso: ','Oracle SQL'), LENGTH('Oracle SQL'),
       SUBSTR('Oracle SQL',1, 6), INSTR('Oracle SQL', 'SQL')
FROM DUAL;

SELECT JOB_TITLE, REPLACE(JOB_TITLE, 'President', 'Presidente') CARGO
FROM JOBS
WHERE JOB_TITLE = 'President';

--NUMBER
SELECT ROUND(45.932,2), ROUND(45.932,0)
FROM DUAL;

SELECT TRUNC(45.932,2), TRUNC(45.932,0)
FROM DUAL;

SELECT ABS(-9), SQRT(9), MOD(13,6)
FROM DUAL;

--DATE
SELECT SYSDATE
FROM DUAL;

SELECT SYSDATE MES_ATUAL, SYSDATE + 30 PROXIMO_MES, SYSDATE - 31 MES_PASSADO 
FROM DUAL;

SELECT LAST_NAME, ROUND((SYSDATE - HIRE_DATE)/7,2) "SEMANAS DE TRABALHO"
FROM EMPLOYEES;

SELECT FIRST_NAME, LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),0)
"MESES DE TRABALHO"
FROM EMPLOYEES;

SELECT SYSDATE HOJE, ADD_MONTHS(SYSDATE, 3) TRES_MESES,
       NEXT_DAY(SYSDATE, 'QUARTA-FEIRA') PROXIMA_SEMANA, 
       LAST_DAY(SYSDATE) ULTIMO_DIA_MES
FROM DUAL;

SELECT SYSDATE, TO_CHAR(TRUNC(SYSDATE), 'DD/MM/YYYY') 
FROM DUAL;

--CONVERSOES 

--TO_CHAR 
SELECT LAST_NAME, TO_CHAR(HIRE_DATE, 'DD/MM/YYYY HH24:MI:SS') DT_ADMISS?O
FROM EMPLOYEES;

--TO_NUMBER
SELECT TO_NUMBER('123,40') 
FROM DUAL;

--TO_DATE
SELECT FIRST_NAME, LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE),0)
       NUMERO_MESES
FROM EMPLOYEES
WHERE HIRE_DATE = TO_DATE('17/06/2003','DD/MM/YYYY');

--NVL
SELECT LAST_NAME, SALARY, NVL(COMMISSION_PCT,0), SALARY * 12 SALARIO_ANUAL
FROM EMPLOYEES;

--CONDICIONAIS
--CASE
SELECT LAST_NAME, JOB_ID, SALARY,
       CASE JOB_ID WHEN 'IT_PROG' THEN 1.10 * SALARY
        WHEN 'ST_CLREK' THEN 1.15 * SALARY
        WHEN 'SA_REP' THEN 1.20 * SALARY
        ELSE SALARY
       END "NOVO SALARIO"
FROM EMPLOYEES
WHERE JOB_ID IN ('IT_PROG', 'ST_CLREK', 'SA_REP');

--DECODE 
SELECT LAST_NAME, JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG' , 1.10 * SALARY,
                      'ST_CLREK', 1.15 * SALARY,
                      'SA_REP'  , 1.20 * SALARY,
                      SALARY) "NOVO SALARIO"
FROM EMPLOYEES
WHERE JOB_ID IN ('IT_PROG', 'ST_CLREK', 'SA_REP');

--MULTIPLE ROWS SINTAXE ORACLE
--EQUIJOIN
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.LOCATION_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
ORDER BY 1;

--JOIN
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

--NONEQUIJOIN
SELECT E.FIRST_NAME, E.SALARY, J.GRADE_LEVEL, J.LOWEST_SAL, J.HIGHEST_SAL
FROM EMPLOYEES E, JOB_GRADES J
WHERE NVL(E.SALARY,0) BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL
ORDER BY 2;

--OUTHERJOIN
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
ORDER BY 3;

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID
ORDER BY 3;

--SELFJOIN
SELECT E.EMPLOYEE_ID "ID EMPREGADO", E.LAST_NAME "EMPREGADO SOBRENOME",
       G.EMPLOYEE_ID "ID GERENTE", G.LAST_NAME "GERENTE SOBRENOME"
FROM EMPLOYEES E, EMPLOYEES G
WHERE (E.MANAGER_ID = G.EMPLOYEE_ID)
ORDER BY 1;