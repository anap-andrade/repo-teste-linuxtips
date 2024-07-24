-- Databricks notebook source
-- DBTITLE 1,Consultando Rabelas
SELECT *
FROM silver.olist.pedido
LIMIT 10

-- COMMAND ----------

-- DBTITLE 1,Selecionando todas colunas + criando coluna nova
SELECT *,
  vlPreco + vlFrete AS vlTotal

FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Selecionando colunas específicas
SELECT idPedido,
  idProduto,
  vlPreco,
  vlFrete,
  vlPreco + vlFrete AS vlTotal

FROM silver.olist.item_pedido

-- COMMAND ----------


