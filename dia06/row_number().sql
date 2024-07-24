-- Databricks notebook source
-- DBTITLE 1,Ordenando o protudo com maior valor de peso em gramas de cada categoria com row number
WITH tb_rn AS (

  SELECT 
    idProduto,
    descCategoria,
    vlPesoGramas,
    row_number() OVER (PARTITION BY descCategoria ORDER BY vlPesoGramas DESC) AS rnProduto

  FROM silver.olist.produto

  WHERE descCategoria IS NOT NULL

)

SELECT *
FROM tb_rn
WHERE rnProduto = 1

-- COMMAND ----------

-- DBTITLE 1,Ordenando os 5 protudos com maior valor de peso em gramas de cada categoria
WITH tb_rn AS (

  SELECT 
    idProduto,
    descCategoria,
    vlPesoGramas,
    row_number() OVER (PARTITION BY descCategoria ORDER BY vlPesoGramas DESC) AS rnProduto

  FROM silver.olist.produto

  WHERE descCategoria IS NOT NULL

)

SELECT *
FROM tb_rn
WHERE rnProduto <= 5

-- COMMAND ----------

WITH tb_rn AS (

  SELECT 
    idProduto,
    descCategoria,
    row_number() OVER (PARTITION BY descCategoria ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC) AS rnProduto,
    vlComprimentoCm * vlAlturaCm * vlLarguraCm AS volumeProduto

  FROM silver.olist.produto

  WHERE descCategoria IS NOT NULL

)

SELECT *
FROM tb_rn
WHERE rnProduto = 1

-- COMMAND ----------


