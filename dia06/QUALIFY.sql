-- Databricks notebook source
SELECT 
  idProduto,
  descCategoria,
  vlPesoGramas,
  row_number() OVER (PARTITION BY descCategoria ORDER BY vlPesoGramas DESC) AS rnProduto

FROM silver.olist.produto

WHERE descCategoria IS NOT NULL

QUALIFY rnProduto = 1

-- COMMAND ----------

SELECT 
  *,
  vlComprimentoCm * vlAlturaCm * vlLarguraCm AS volumeCm3

FROM silver.olist.produto

WHERE descCategoria IS NOT NULL

QUALIFY row_number () OVER (PARTITION BY descCategoria ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC) <= 3

-- COMMAND ----------

SELECT 
  idProduto,
  descCategoria,
  row_number() OVER (PARTITION BY descCategoria ORDER BY vlPesoGramas DESC) AS rnPeso,
  row_number() OVER (PARTITION BY descCategoria ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC) AS rnVolume

FROM silver.olist.produto

WHERE descCategoria IS NOT NULL

QUALIFY rnPeso <= 5 AND rnVolume <= 5

-- COMMAND ----------

-- Essa consulta faz a mesma coisa que a de cima, mas sem criar as colunas de ordenação de peso e volume. As informações de produto e categoria são exatamente as mesmas, mas caso a gente não precise das informações das colunas peso e volume, apenas precise da informação de ordenamento dos produtos, pode ser feito desta maneira.

SELECT 
  idProduto,
  descCategoria

FROM silver.olist.produto

WHERE descCategoria IS NOT NULL

QUALIFY row_number() OVER (PARTITION BY descCategoria ORDER BY vlPesoGramas DESC) <= 5 AND row_number() OVER (PARTITION BY descCategoria ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC) <= 5

-- COMMAND ----------


