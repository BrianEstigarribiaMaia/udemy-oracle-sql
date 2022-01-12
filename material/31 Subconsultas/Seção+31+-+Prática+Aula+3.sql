--
-- Oracle SQL Avançado 
--
-- Seção 31 - Subconsultas 
--
-- Aula 3 - Delete utilizando Subconsultas Correlacionadas

-- Delete utilizando Subconsultas Correlacionadas

-- Conectar como usuário hr

-- Consultando a Tabela departments_average_temp

SELECT *
FROM departments_average_temp;

SELECT d.department_id, d.department_name
FROM   departments d
          JOIN locations l ON (d.location_id = l.location_id)
       WHERE country_id = 'US';

-- Delete utilizando Subconsultas Correlacionadas

DELETE departments_average_temp d
WHERE  d.department_id IN (SELECT d.department_id
                           FROM departments d
                                JOIN locations l ON (d.location_id = l.location_id)
                           WHERE country_id = 'US');
                            
COMMIT;

-- Consultando a Tabela departments_average_temp

SELECT *
FROM departments_average_temp;


