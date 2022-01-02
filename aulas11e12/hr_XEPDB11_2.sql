--SESSÃO 11 e 12 DO CURSO DE ORACLE SQL UDEMY

-- UTILIZANDO PREFIXOS SELECT employees.employee_id,
SELECT employees.last_name,
       employees.department_id,
       departments.department_name
  FROM employees
  JOIN departments ON ( employees.department_id = departments.department_id );

--natural join 

SELECT department_id,
       department_name,
       location_id,
       city
  FROM departments
NATURAL JOIN locations;

--using
SELECT e.employee_id,
       e.last_name,
       d.location_id,
       department_id,
       d.department_name
  FROM employees e
  JOIN departments d USING ( department_id );

-- varios joins com a clausula on 
SELECT e.employee_id,
       j.job_title,
       d.department_name,
       l.city,
       l.state_province,
       l.country_id
  FROM employees e
  JOIN jobs j ON ( e.job_id = j.job_id )
  JOIN departments d ON ( e.department_id = d.department_id )
  JOIN locations l ON ( d.location_id = l.location_id )
 ORDER BY e.employee_id;

--join com where
SELECT e.employee_id,
       e.last_name,
       e.salary,
       e.department_id,
       d.department_name
  FROM employees e
  JOIN departments d ON ( e.department_id = d.department_id )
 WHERE ( e.salary BETWEEN 10000 AND 15000 );

--and
SELECT e.employee_id,
       e.last_name,
       e.salary,
       e.department_id,
       d.department_name
  FROM employees e
  JOIN departments d ON ( e.department_id = d.department_id )
   AND ( e.salary BETWEEN 10000 AND 15000 );

--self join com on
SELECT empregado.employee_id AS "ID_EMPREGADO",
       empregado.last_name AS "SOBRENOME_EMPREGADO",
       gerente.employee_id AS "ID_GERENTE",
       gerente.last_name AS "SOBRENOME_GERENTE"
  FROM employees empregado
  JOIN employees gerente ON ( empregado.manager_id = gerente.employee_id )
 ORDER BY empregado.employee_id;
 
 
 -- nonequijoins
 
 --remove job_grades
DROP TABLE job_grades;
 
 --cria tabela job_grades
CREATE TABLE job_grades (
grade_level VARCHAR2(2) NOT NULL,
lowest_sal NUMBER(11, 2),
highest_sal NUMBER(11, 2),
CONSTRAINT job_grades_pk PRIMARY KEY ( grade_level )
);
 
 -- inserindo linhas na tabela job_grade
INSERT INTO job_grades VALUES (
'A',
1000,
2999
);

INSERT INTO job_grades VALUES (
'B',
3000,
5999
);

INSERT INTO job_grades VALUES (
'C',
6000,
9999
);

INSERT INTO job_grades VALUES (
'D',
10000,
14999
);

INSERT INTO job_grades VALUES (
'E',
15000,
24999
);

INSERT INTO job_grades VALUES (
'F',
25000,
40000
);
 
 --efetivando a transação
COMMIT;

SELECT *
  FROM job_grades;
 
 --nonequijoins
SELECT e.employee_id,
       e.salary,
       j.grade_level,
       j.lowest_sal,
       j.highest_sal
  FROM employees e
  JOIN job_grades j ON nvl(e.salary, 0) BETWEEN j.lowest_sal AND j.highest_sal
 ORDER BY e.salary;

SELECT e.employee_id,
       e.salary,
       j.grade_level,
       j.lowest_sal,
       j.highest_sal
  FROM employees e
  JOIN job_grades j ON nvl(e.salary, 0) >= j.lowest_sal
   AND nvl(e.salary, 0) <= j.highest_sal
 ORDER BY e.salary;
 
 --outer joins 
 
 --left outer join
SELECT e.first_name,
       d.department_id,
       d.department_name
  FROM employees e
  LEFT OUTER JOIN departments d ON ( e.department_id = d.department_id )
 ORDER BY d.department_id;
 
 --right outer join 
SELECT d.department_id,
       d.department_name,
       e.first_name,
       e.last_name
  FROM employees e
  LEFT OUTER JOIN departments d ON ( e.department_id = d.department_id )
 ORDER BY d.department_id;
 
 --full outer join
SELECT d.department_id,
       d.department_name,
       e.first_name,
       e.last_name
  FROM employees e
  FULL OUTER JOIN departments d ON ( e.department_id = d.department_id )
 ORDER BY d.department_id;
 
 --produto cartesiano 

SELECT last_name,
       department_name
  FROM employees
 CROSS JOIN departments;
 
 -- SINTAXE ORACLE
 
 --equijoin
SELECT e.employee_id,
       e.last_name,
       e.department_id,
       d.department_id,
       d.location_id
  FROM employees e,
       departments d
 WHERE ( e.department_id = d.department_id )
 ORDER BY e.department_id;
 
 --joins de varias tabelas 
SELECT e.employee_id,
       e.last_name,
       e.department_id,
       d.department_id,
       d.location_id
  FROM employees e,
       jobs j,
       departments d,
       locations l
 WHERE ( e.job_id = j.job_id )
   AND ( d.department_id = e.department_id )
   AND ( d.location_id = l.location_id )
 ORDER BY e.employee_id;
 
 -- condições
SELECT e.employee_id,
       e.salary,
       j.job_title,
       d.department_name,
       l.city,
       l.state_province,
       l.country_id
  FROM employees e,
       jobs j,
       departments d,
       locations l
 WHERE ( e.job_id = j.job_id )
   AND ( d.department_id = e.department_id )
   AND ( d.location_id = l.location_id )
   AND ( e.salary >= 1000 )
 ORDER BY e.employee_id;
 
 --nonequijoin 
SELECT e.employee_id,
       e.salary,
       j.grade_level,
       j.lowest_sal,
       j.highest_sal
  FROM employees e,
       job_grades j
 WHERE nvl(e.salary, 0) BETWEEN j.lowest_sal AND j.highest_sal
 ORDER BY e.salary;
 
 --outer join
SELECT e.first_name,
       e.last_name,
       d.department_id,
       d.department_name
  FROM employees e,
       departments d
 WHERE ( e.department_id = d.department_id (+) )
 ORDER BY e.first_name;
 
 --self join com outer join-self join com outer join

SELECT empregado.employee_id "ID_EMPREGADO",
       empregado.last_name "SOBRENOME_EMPREGADO",
       gerente.employee_id "ID_GERENTE",
       gerente.last_name "SOBRENOME_GERENTE"
  FROM employees empregado,
       employees gerente
 WHERE ( empregado.manager_id = gerente.employee_id (+) )
 ORDER BY empregado.employee_id;
 
 
 --produto cartesiano
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       j.job_id,
       j.job_title
  FROM employees e,
       jobs j
 WHERE e.job_id = j.job_id;
 
  ------------------------------------------------------------------------------
 --SUBCONSULTAS SINGLE ROW 

SELECT first_name,
       last_name,
       job_id,
       salary
  FROM employees
 WHERE salary > ( SELECT AVG(nvl(salary, 0))
                   FROM employees
                );              

-- Utilizando Sub-consultas na Cláusula HAVING

SELECT e1.department_id,
       MAX(e1.salary)
  FROM employees e1
 GROUP BY e1.department_id
HAVING MAX(salary) < ( SELECT AVG(e2.salary)
                         FROM employees e2
                     );
                                                  
-- Erros utilizando Sub-consultas Single-Row

SELECT employee_id,
       first_name,
       last_name
  FROM employees
 WHERE salary = ( SELECT AVG(nvl(salary, 0))
                   FROM employees
                  GROUP BY department_id
                );

-- O que ocorre quando a Sub-Consulta retorna nenhuma linha?

SELECT employee_id,
       first_name,
       last_name
  FROM employees
 WHERE last_name = ( SELECT last_name
                      FROM employees
                     WHERE last_name = 'Suzuki'
                   );
                     
 ------------------------------------------------------------------------------                    
 --SUBCONSULTAS MULTIPLE ROW
 
--usando o IN 
SELECT employee_id,
       first_name,
       last_name
  FROM employees
 WHERE salary IN ( SELECT AVG(nvl(salary, 0))
                    FROM employees
                   GROUP BY department_id
                 );
 
 --usando o NOT IN 
SELECT employee_id,
       first_name,
       last_name
  FROM employees
 WHERE salary NOT IN ( SELECT AVG(nvl(salary, 0))
                        FROM employees
                       GROUP BY department_id
                     );
      
--usando o ANY
SELECT employee_id,
       last_name,
       job_id,
       salary
  FROM employees
 WHERE salary < ANY ( SELECT salary
                       FROM employees
                      WHERE job_id = 'IT_PROG'
                    );

--usando o ALL
SELECT employee_id,
       last_name,
       job_id,
       salary
  FROM employees
 WHERE salary < ALL ( SELECT salary
                       FROM employees
                      WHERE job_id = 'IT_PROG'
                    );

--VALORES NULOS IN
SELECT emp.employee_id,
       emp.last_name
  FROM employees emp
 WHERE emp.employee_id IN ( SELECT mgr.manager_id
                             FROM employees mgr
                          );

--valores nulos NOT IN 
SELECT emp.employee_id,
       emp.last_name
  FROM employees emp
 WHERE emp.employee_id NOT IN ( SELECT mgr.manager_id
                                 FROM employees mgr
                              );
                              
                              
--operador exists 
SELECT d.department_id,
       d.department_name
  FROM departments d
 WHERE EXISTS ( SELECT e.department_id
                 FROM employees e
                WHERE d.department_id = e.department_id
              );

SELECT d.department_id,
       d.department_name
  FROM departments d
 WHERE NOT EXISTS ( SELECT e.department_id
                     FROM employees e
                    WHERE d.department_id = e.department_id
                  );
              
--subconsultas correlacionadas
SELECT e1.employee_id,
       e1.first_name,
       e1.last_name,
       e1.department_id,
       e1.salary
  FROM employees e1
 WHERE e1.salary >= ( SELECT trunc(AVG(nvl(salary, 0)), 0)
                       FROM employees e2
                      WHERE e1.department_id = e2.department_id
                    );

SELECT trunc(AVG(nvl(salary, 0)), 0)
  FROM employees e2
 WHERE e2.department_id = 60;
 
--subconsultas multiple column

SELECT e1.employee_id,
       e1.first_name,
       e1.job_id,
       e1.salary
  FROM employees e1
 WHERE ( e1.job_id, e1.salary ) IN ( SELECT e2.job_id, MAX(e2.salary)
                                      FROM employees e2
                                     GROUP BY e2.job_id
                                   );


--subconsulta no from 

select empregados.employee_id, empregados.first_name, empregados.last_name, 
empregados.job_id, empregados.salary, round(max_salary_job.max_salary,2) MAX_SALARY, 
empregados.salary - round(max_salary_job.max_salary,2) DIFERENÇA
FROM employees empregados
left join (select e2.job_id, max(e2.salary) max_salary
from employees e2
group by e2.job_id) max_salary_job
on empregados.job_id = max_salary_job.job_id;