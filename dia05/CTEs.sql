-- Databricks notebook source
WITH tb_pedidos_em_atraso AS (

  SELECT *

  FROM silver.olist.pedido

  WHERE descSituacao = 'delivered'

  AND dtEntregue <= dtEstimativaEntrega

),

tb_produtos_bebes AS (

  SELECT *

  FROM silver.olist.produto

  WHERE descCategoria = 'bebes'
)

SELECT *

FROM tb_produtos_bebes

-- COMMAND ----------

-- Quais são os TOP 10 vendedores que mais venderam (em quantidade) no mês com maior número de vendas no Olist.

WITH tb_mes AS (

  -- IDENTIFICA O MES COM MAIS VENDAS
  SELECT 
    date(date_trunc('month', dtPedido)) AS dtMonth
  FROM silver.olist.pedido
  GROUP BY dtMonth
  ORDER BY count(DISTINCT idPedido) DESC
  LIMIT 1

)

SELECT 
  t2.idVendedor,
  count(*) AS qntItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = (SELECT * FROM tb_mes)

GROUP BY t2.idVendedor

ORDER BY qntItens DESC

LIMIT 10


-- COMMAND ----------

WITH tb_vendedores AS (

  -- VENDEDORES QUE VENDERAM NA CATEGORIA BEBES NA BLACK FRIDAY 2017
  SELECT DISTINCT 
    t2.idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

SELECT 
  idVendedor,
  count(DISTINCT idPedido) AS qntPedido

FROM silver.olist.item_pedido

WHERE idVendedor IN (SELECT * FROM tb_vendedores)

GROUP BY idVendedor

-- COMMAND ----------

-- O filtro vendedores que mais venderam na BF e os que mais venderam na categoria bebes estão no WITH

WITH tb_vendedores_bf_bebes AS (

  SELECT DISTINCT t2.idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'
  AND t3.descCategoria = 'bebes'

)

SELECT 
  t1.idVendedor,
  count(DISTINCT idPedido) AS qntPedido

FROM silver.olist.item_pedido AS t1

INNER JOIN tb_vendedores_bf_bebes AS t2
ON t1.idVendedor = t2.idVendedor

GROUP BY t1.idVendedor

ORDER BY qntPedido DESC


-- COMMAND ----------


