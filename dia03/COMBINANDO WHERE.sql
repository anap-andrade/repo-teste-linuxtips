-- Databricks notebook source
SELECT count(idVendedor),
  count(DISTINCT idVendedor)

FROM silver.olist.vendedor

WHERE descUF = 'RJ'

-- COMMAND ----------

SELECT 
  count(DISTINCT idCliente), -- clientes não únicos
  count(DISTINCT idClienteUnico), -- clientes únicos
  count(DISTINCT descCidade) -- cidades distintas


FROM silver.olist.cliente

WHERE descUF = 'AC'

-- COMMAND ----------

SELECT count(*), -- total de produtos na categoria bebes
  avg(vlPesoGramas), -- média de peso em gramas
  percentile(vlPesoGramas, 0.5), -- mediana de peso em gramas
  std(vlPesoGramas) -- desvio padrão 

FROM silver.olist.produto

WHERE descCategoria = 'bebes'

-- COMMAND ----------

SELECT count(*), -- total de produtos na categoria bebes
  avg(vlPesoGramas), -- média de peso em gramas
  percentile(vlPesoGramas, 0.5), -- mediana de peso em gramas
  std(vlPesoGramas), -- desvio padrão 
  min(vlPesoGramas),
  max(vlPesoGramas),
  max(vlPesoGramas) - min(vlPesoGramas)

FROM silver.olist.produto

WHERE descCategoria = 'perfumaria'

-- COMMAND ----------


