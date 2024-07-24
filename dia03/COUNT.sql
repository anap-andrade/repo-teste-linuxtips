-- Databricks notebook source
-- DBTITLE 1,Neste caso COUNT vai contar quantas linhas NÃO NULAS existem nessa tabela
SELECT 
  count(*),
  count(1)

FROM silver.olist.pedido

-- COMMAND ----------

SELECT count(descSituacao),  -- linhas não nulas deste campo (descSituacao)
  count(DISTINCT descSituacao)  -- linhas distintas do campo descSituacao
FROM silver.olist.pedido

-- COMMAND ----------

SELECT count(idPedido),  -- linhas não nulas do campo idPedido
  count(DISTINCT idPedido),  -- linhas distintas para idPedido
  count(*),  -- linhas totais da tabela
  count(1)  -- linhas totais da tabela
FROM silver.olist.pedido

-- COMMAND ----------


