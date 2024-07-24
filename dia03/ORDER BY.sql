-- Databricks notebook source
-- DBTITLE 1,ORDER BY DESC - do mais caro para o mais barato. do maior valor para o menor
SELECT *

FROM silver.olist.item_pedido

ORDER BY vlPreco DESC, vlFrete DESC

LIMIT 3

-- COMMAND ----------

-- DBTITLE 1,ORDER BY ASC - do mais barato para o mais caro. do valor menor para o menor
SELECT *

FROM silver.olist.item_pedido

ORDER BY vlPreco ASC, vlFrete ASC


-- COMMAND ----------

SELECT *

FROM silver.olist.produto

WHERE descCategoria = 'perfumaria'

ORDER BY nrTamanhoDescricao DESC

LIMIT 5

-- COMMAND ----------

SELECT *,
  vlComprimentoCm * vlAlturaCm * vlLarguraCm AS vlCentimetros

FROM silver.olist.produto

WHERE descCategoria = 'perfumaria'

ORDER BY vlComprimentoCm * vlAlturaCm * vlLarguraCm DESC

LIMIT 5



-- COMMAND ----------


