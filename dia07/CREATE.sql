-- Databricks notebook source
CREATE TABLE sandbox.linuxtips.top5_pedido_ana AS (

  SELECT *

  FROM silver.olist.pedido

  LIMIT 5

)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top5_pedido_ana AS (

  SELECT *

  FROM silver.olist.pedido

  ORDER BY RAND()

  LIMIT 5

)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top50_pedido_ana AS (

  SELECT idPedido

  FROM silver.olist.pedido

  LIMIT 50

)

-- COMMAND ----------

SELECT *

FROM sandbox.linuxtips.top50_pedido_ana

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.nova_tabela_vazia_ana (
  descNome STRING,
  vlIdade INT,
  vlSalario FLOAT
)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.ex07_ana

WITH tb_dia_vendedor AS (

  SELECT 
    DISTINCT t1.idVendedor,
    date(t2.dtPedido) AS dtPedido

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

)

SELECT *,
  row_number() OVER (PARTITION BY idVendedor ORDER BY rand()) AS rnVendedor

FROM tb_dia_vendedor

QUALIFY rnVendedor = 1


-- COMMAND ----------

SELECT *

FROM sandbox.linuxtips.ex07_ana

-- COMMAND ----------


