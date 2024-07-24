-- Databricks notebook source
DROP TABLE sandbox.linuxtips.top5_pedido_ana

-- COMMAND ----------

SELECT *

FROM sandbox.linuxtips.top5_pedido_ana

-- COMMAND ----------

CREATE TABLE sandbox.linuxtips.top5_pedido_ana AS 

SELECT *

FROM silver.olist.pedido

LIMIT 5

-- COMMAND ----------

SELECT *

FROM sandbox.linuxtips.top5_pedido_ana

-- COMMAND ----------

DROP TABLE sandbox.linuxtips.top5_pedido_ana;

-- COMMAND ----------

DROP TABLE sandbox.linuxtips.top5_pedido_ana;

CREATE TABLE sandbox.linuxtips.top5_pedido_ana AS 

SELECT *

FROM silver.olist.pedido

LIMIT 5;

-- COMMAND ----------

DROP TABLE IF EXISTS sandbox.linuxtips.top5_pedido_ana;

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top5_pedido_ana AS 

SELECT *

FROM silver.olist.pedido

LIMIT 5;

-- COMMAND ----------

SELECT *

FROM sandbox.linuxtips.top5_pedido_ana

-- COMMAND ----------

DROP TABLE IF EXISTS sandbox.linuxtips.top5_pedido_ana;

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.top5_pedido_ana AS 

SELECT *

FROM silver.olist.pedido

ORDER BY rand()

LIMIT 5;

-- COMMAND ----------

SELECT *

FROM sandbox.linuxtips.top5_pedido_ana

-- COMMAND ----------


