-- Databricks notebook source
CREATE TABLE sandbox.linuxtips.usuarios_ana (
  id INT,
  nome STRING,
  idade INT
);

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_ana (id, nome, idade) 
VALUES (1, 'Ana', 33)

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_ana (id, nome, idade) 
VALUES (2, 'Maria', 40), (3, 'Bento', 5), (4, 'Carlos', 25)

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_ana (id, nome) 
VALUES (5, 'José')

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_ana 
VALUES (6, 'Tarsila')

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.usuarios_ana
VALUES (6, 'Tarsila', 57)

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.usuarios_ana

-- COMMAND ----------

SELECT *
FROM silver.olist.cliente
LIMIT 10

-- COMMAND ----------

CREATE TABLE sandbox.linuxtips.cliente_olist_ana (
  id STRING,
  estado STRING
)

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.cliente_olist_ana

SELECT *    -- é preciso sinalizar quais colunas serão inseridas se não não irá funcionar. Exemplo na consulta abaixo
FROM silver.olist.cliente
LIMIT 10

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.cliente_olist_ana

SELECT idCliente AS id,
  descUF AS estado
FROM silver.olist.cliente
LIMIT 10

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.cliente_olist_ana

-- COMMAND ----------

WITH tb_rj AS (
  SELECT *
  FROM silver.olist.cliente
  WHERE descUF = 'RJ'
)

INSERT INTO sandbox.linuxtips.cliente_olist_ana

SELECT idCliente AS id,
  descUF AS estado
FROM tb_rj

LIMIT 10

-- COMMAND ----------

SELECT *
FROM sandbox.linuxtips.cliente_olist_ana

-- COMMAND ----------


