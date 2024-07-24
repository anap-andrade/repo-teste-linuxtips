-- Databricks notebook source
SELECT descUF,
  count(DISTINCT idVendedor)

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY descUF -- ordena por ordem alfabética

-- COMMAND ----------

SELECT descUF,
  count(DISTINCT idVendedor) AS qtVendedor

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY qtVendedor -- ordena pelo idVendedor, em ordem crescente

-- COMMAND ----------

SELECT *

FROM silver.
