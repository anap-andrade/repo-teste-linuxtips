-- Databricks notebook source
-- DBTITLE 1,Utilizando o DISTINCT depois do SELECT, ele vai trazer a informação da tabela penas 1 vez, sem repetir as informações
SELECT DISTINCT descUF 

FROM silver.olist.vendedor


-- COMMAND ----------

-- DBTITLE 1,ORDER BY ordena os estados por ordem alfabetica (A,B,C...)
SELECT DISTINCT descUF 

FROM silver.olist.vendedor

ORDER BY descUF

-- COMMAND ----------

SELECT DISTINCT descCidade, descUF

FROM silver.olist.vendedor

ORDER BY descUF, descCidade

-- COMMAND ----------

-- DBTITLE 1,Por conta de estarmos trabalhando com a tabela idVendedor, o DISTINCT não vai alterar em nada essa consulta, pois cada vendedor tem um ID diferente
SELECT DISTINCT *

FROM silver.olist.vendedor

-- COMMAND ----------

-- DBTITLE 1,Selecionando todas as categorias na coluna descCategoria sem repetir os valores
SELECT DISTINCT descCategoria

FROM silver.olist.produto

WHERE descCategoria IS NOT NULL

ORDER BY descCategoria

-- COMMAND ----------


