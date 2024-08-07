-- Databricks notebook source
WITH tb_dia_receita AS (

  SELECT 
    date(t2.dtPedido) AS dtPedido,
    sum(t1.vlPreco) AS receitaDia

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE t2.descSituacao = 'delivered'

  GROUP BY 1
  ORDER BY 1

), tb_lag AS (

  SELECT *,
    LAG(receitaDia) OVER (PARTITION BY 1 ORDER BY dtPedido) AS lag1Receita,
    LAG(receitaDia, 2) OVER (PARTITION BY 1 ORDER BY dtPedido) AS lag2Receita,

    LEAD(receitaDia) OVER (PARTITION BY 1 ORDER BY dtPedido) AS leadReceita,
    LAG(receitaDia, -1) OVER (PARTITION BY 1 ORDER BY dtPedido) AS lag_1Receita

  FROM tb_dia_receita

)

SELECT *,
  receitaDia - lag1Receita AS diffLag1

FROM tb_lag

-- COMMAND ----------

-- DBTITLE 1,De quanto em quanto tempo um vendedor faz uma venda? Qual o intervalo entre as vendas?
WITH tb_vendedor AS (

  SELECT 
    DISTINCT t1.idVendedor,
    date(t2.dtPedido) AS dtPedido

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

  ORDER BY t1.idVendedor, dtPedido

), 

tb_lag AS (

SELECT *,
  LAG(dtPedido) OVER (PARTITION BY idVendedor ORDER BY dtPedido) AS lag1Data

FROM tb_vendedor

), 

tb_diff AS (

SELECT *,
  datediff(dtPedido, lag1Data) AS diffData

FROM tb_lag

)

SELECT 
  idVendedor,
  avg(diffData) AS mediaIntervaloVendas,  -- média
  percentile(diffData, 0.5) AS medianaIntervaloVendas -- mediana

FROM tb_diff

GROUP BY idVendedor

HAVING count(*) >= 2

-- COMMAND ----------


