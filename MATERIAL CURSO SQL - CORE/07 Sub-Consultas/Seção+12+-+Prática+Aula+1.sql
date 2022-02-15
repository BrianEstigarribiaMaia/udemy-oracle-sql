--
-- Seção 12 
-- Utilizando Sub-Consultas
--
-- Aula 1 - Sub-Consultas Single-Row

-- Sub-Consultas Single-Row

SELECT first_name, last_name, job_id, salary
FROM   employees
WHERE  salary >
                (SELECT AVG(NVL(salary,0))
                 FROM employees);              

-- Utilizando Sub-consultas na Cláusula HAVING

SELECT e1.department_id, MAX(e1.salary)
FROM   employees e1
GROUP BY e1.department_id
HAVING MAX(salary) <  (SELECT AVG(e2.salary)
                       FROM   employees e2);
                                                  
-- Erros utilizando Sub-consultas Single-Row

SELECT employee_id, first_name, last_name
FROM   employees
WHERE  salary =
                (SELECT    AVG(NVL(salary,0))
                 FROM      employees
                 GROUP BY  department_id);

-- O que ocorre quando a Sub-Consulta retorna nenhuma linha?

SELECT employee_id, first_name, last_name
FROM   employees
WHERE  last_name =  (SELECT last_name
                     FROM   employees
                     WHERE  last_name = 'Suzuki');
					 
--
-- Seção 12 
-- Utilizando Sub-Consultas
--
-- Aula 2 - Sub-Consultas Multiple-row
-- 
                  
-- Sub-Consultas Multiple-row

SELECT employee_id, first_name, last_name
FROM   employees
WHERE  salary IN 
                (SELECT    AVG(NVL(salary,0))
                 FROM      employees
                 GROUP BY  department_id);

-- Utilizando operador NOT IN em Sub-consultas Multiple-Row

SELECT employee_id, first_name, last_name
FROM   employees
WHERE  salary NOT IN
                (SELECT    AVG(NVL(salary,0))
                 FROM      employees
                 GROUP BY  department_id);
                 
-- Utilizando operador ANY em Sub-consultas Multiple-Row

SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ANY
                   (SELECT salary
                    FROM   employees
                    WHERE  job_id = 'IT_PROG');

-- Utilizando operador ALL em Sub-consultas Multiple-Row

SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ALL
                   (SELECT salary
                    FROM   employees
                    WHERE  job_id = 'IT_PROG');
                    
-- Cuidados com Valores Nulos em uma Sub-consulta com Operador IN

SELECT emp.employee_id, emp.last_name
FROM   employees emp
WHERE  emp.employee_id IN (SELECT mgr.manager_id
                           FROM employees mgr);

-- Cuidados com Valores Nulos em uma Sub-consulta com Operador NOT IN

SELECT emp.employee_id, emp.last_name
FROM   employees emp
WHERE  emp.employee_id NOT IN (SELECT mgr.manager_id
                               FROM employees mgr);

--
-- Seção 12 
-- Utilizando Sub-Consultas
--
-- Aula 3 - Utilizando operador EXISTS e NOT EXISTS 
--

-- Utilizando operador EXISTS

SELECT d.department_id, d.department_name
FROM   departments d
WHERE  EXISTS
             (SELECT e.department_id
               FROM   employees e
               WHERE d.department_id = 
                             e.department_id);
							 
-- Utilizando operador EXISTS

SELECT d.department_id, d.department_name
FROM   departments d
WHERE  EXISTS (SELECT e.department_id
               FROM employees e
               WHERE d.department_id = e.department_id);

-- Utilizando operador NOT EXISTS

SELECT d.department_id, d.department_name
FROM   departments d
WHERE  NOT EXISTS (SELECT e.department_id
                   FROM employees e
                   WHERE d.department_id = e.department_id);

-- Seção 12 
-- Utilizando Sub-Consultas
--
-- Aula 4 - Utilizando Sub-Consulta Correlacionada
--
  
-- Utilizando Sub-Consultas Correlacionadas
               
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.department_id, e1.salary
FROM   employees e1
WHERE  e1.salary >= (SELECT    TRUNC(AVG(NVL(salary,0)),0)
                     FROM      employees e2
                     WHERE     e1.department_id = e2.department_id);
                   
SELECT    TRUNC(AVG(NVL(salary,0)),0)
FROM      employees e2
WHERE     e2.department_id = 60;

-- Seção 12 
-- Utilizando Sub-Consultas
--
-- Aula 5 - Utilizando Sub-consultas Multiple-Column 
-- 
  
-- Utilizando Sub-consultas Multiple-Column 

SELECT e1.employee_id, e1.first_name, e1.job_id, e1.salary
FROM   employees e1
WHERE (e1.job_id, e1.salary) IN (SELECT   e2.job_id, MAX(e2.salary)
                                 FROM     employees e2
                                 GROUP by e2.job_id);

-- Seção 12 
-- Utilizando Sub-Consultas
--
-- Aula 6 - Utilizando Sub-Consultas na Cláusula FROM
--
		
-- Utilizando Sub-Consultas na Cláusula FROM

SELECT empregados.employee_id, empregados.first_name, empregados.last_name, empregados.job_id, 
       empregados.salary, ROUND(max_salary_job.max_salary,2) MAX_SALARY, 
	   empregados.salary - ROUND(max_salary_job.max_salary,2) DIFERENÇA
FROM   employees empregados
  LEFT JOIN (SELECT  e2.job_id, MAX(e2.salary) max_salary
             FROM     employees e2
             GROUP by e2.job_id) max_salary_job
       ON empregados.job_id = max_salary_job.job_id;								 
