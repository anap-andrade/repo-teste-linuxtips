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

-- DBTITLE 1,DELETE SEM WHERE
DELETE FROM sandbox.linuxtips.usuarios_ana  -- Deleta TODOS os dados

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

-- DBTITLE 1,DELETE COM WHERE
DELETE FROM sandbox.linuxtips.usuarios_ana
WHERE idade < 18

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

-- DBTITLE 1,DELETE COM WHERE E AND (mais de uma condição)
DELETE FROM sandbox.linuxtips.usuarios_ana
WHERE idade > 30 AND profissao = 'Streamer'

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

DELETE FROM sandbox.linuxtips.usuarios_ana WHERE idade > (SELECT avg(idade) FROM sandbox.linuxtips.usuarios_ana)

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------


