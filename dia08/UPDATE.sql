-- Databricks notebook source
DROP TABLE IF EXISTS sandbox.linuxtips.usuarios_ana;

CREATE TABLE sandbox.linuxtips.usuarios_ana (
  id INT,
  nome STRING,
  idade INT,
  profissao STRING
);

INSERT INTO sandbox.linuxtips.usuarios_ana
VALUES (1, 'Téo', 31, 'Streamer'),
 (2, 'Nah', 32, 'Artesã'),
 (3, 'Mah', 17, 'Estudante'),
 (4, 'Ana', 27, 'Dev'),
 (5, 'João', 45, 'Dev'),
 (6, 'Marcelo', 37, 'Eng. Mecânico'),
 (7, 'Zé', 15, 'Streamer'),
 (8, 'Diná', 33, 'Cabeleireira'),
 (9, 'Carla', 51, 'Analista Financeiro'),
 (10, 'Tamá', 25, 'Estilista'),
 (11, 'Mariana', 39, 'Cineasta')
 ;

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

-- DBTITLE 1,UPDATE SEM WHERE
UPDATE sandbox.linuxtips.usuarios_ana SET idade = 31; -- Muito cuidado pq sem utilizar o WHERE a coluna inteira será atualizada com o valor setado

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

DROP TABLE IF EXISTS sandbox.linuxtips.usuarios_ana;

CREATE TABLE sandbox.linuxtips.usuarios_ana (
  id INT,
  nome STRING,
  idade INT,
  profissao STRING
);

INSERT INTO sandbox.linuxtips.usuarios_ana
VALUES (1, 'Téo', 31, 'Streamer'),
 (2, 'Nah', 32, 'Artesã'),
 (3, 'Mah', 17, 'Estudante'),
 (4, 'Ana', 27, 'Dev'),
 (5, 'João', 45, 'Dev'),
 (6, 'Marcelo', 37, 'Eng. Mecânico'),
 (7, 'Zé', 15, 'Streamer'),
 (8, 'Diná', 33, 'Cabeleireira'),
 (9, 'Carla', 51, 'Analista Financeiro'),
 (10, 'Tamá', 25, 'Estilista'),
 (11, 'Mariana', 39, 'Cineasta')
 ;

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

-- DBTITLE 1,UPDATE COM WHERE
UPDATE sandbox.linuxtips.usuarios_ana SET idade = 31 WHERE id = 6;

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------


