-- Databricks notebook source
SELECT descCategoria,
  count(DISTINCT idProduto) AS qtdeProduto,
  avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto
WHERE descCategoria IN ('bebes', 'perfumaria', 'moveis_decoracao')
GROUP BY descCategoria

-- COMMAND ----------

SELECT descCategoria,
  count(DISTINCT idProduto) AS qtdeProduto,
  avg(vlPesoGramas) AS avgPeso
FROM silver.olist.produto
WHERE descCategoria IN ('bebes', 'perfumaria')
OR descCategoria LIKE '%moveis%'
GROUP BY descCategoria

-- COMMAND ----------

SELECT descCategoria,
  count(DISTINCT idProduto) AS qtdeProduto,
  avg(vlPesoGramas) AS avgPeso

FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')

OR descCategoria LIKE '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100

-- COMMAND ----------

SELECT descCategoria,
  count(DISTINCT idProduto) AS qtdeProduto,
  avg(vlPesoGramas) AS avgPeso

FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')

OR descCategoria LIKE '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100

AND avgPeso > 1000

-- COMMAND ----------

SELECT descCategoria,
  avg(vlPesoGramas) AS avgPeso

FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')

OR descCategoria LIKE '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100

AND avgPeso > 1000

-- COMMAND ----------

SELECT descCategoria,
  avg(vlPesoGramas) AS avgPeso

FROM silver.olist.produto

WHERE descCategoria IN ('bebes', 'perfumaria')

OR descCategoria LIKE '%moveis%'

GROUP BY descCategoria

HAVING count(DISTINCT idProduto) > 100

AND avgPeso > 1000

ORDER BY avgPeso DESC

-- COMMAND ----------


