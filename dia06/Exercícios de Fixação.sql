-- Databricks notebook source
-- DBTITLE 1,1. Quais são os Top 5 vendedores campeões de vendas de cada UF?
WITH tb_venda AS (

  SELECT 
    t1.idVendedor,
    t2.descUF,
    sum(t1.vlPreco) AS receitaVendedor,
    count(*) AS qntVendaItens,
    count(DISTINCT t1.idPedido) AS qntVendaPedido
    

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.vendedor AS t2
  ON t1.idVendedor = t2.idVendedor

  GROUP BY t1.idVendedor, t2.descUF

)

SELECT *,
  row_number() OVER (PARTITION BY descUF ORDER BY qntVendaPedido DESC) AS rnPedidos, -- Campeão de vendas pela quantidade de pedidos

  row_number() OVER (PARTITION BY descUF ORDER BY receitaVendedor DESC) AS rnReceita -- Campeão de vendas pela maior receita

FROM tb_venda

QUALIFY rnPedidos <= 5 -- Se quiser ranquiear pela maior receira, é só trocar o rnPedidos pelo rnReceita

-- COMMAND ----------

-- DBTITLE 1,2. Quais são os TOP 5 vendedores campeões de venda em cada categoria?
WITH tb_pedidos AS (

  SELECT 
    t1.idVendedor,
    t2.descCategoria,
    count(DISTINCT t1.idPedido) AS qntPedido,
    count(*) AS qntItens

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  WHERE t2.descCategoria IS NOT NULL

  GROUP BY t1.idVendedor, t2.descCategoria

)

SELECT *,
  row_number() OVER (PARTITION BY descCategoria ORDER BY qntItens DESC) AS rnItens

FROM tb_pedidos

QUALIFY rnItens <= 5 

-- COMMAND ----------

-- DBTITLE 1,3. Qual é a TOP 1 categoria de cada vendedor?
WITH tb_itens AS (

  SELECT 
    t1.idVendedor,
    t2.descCategoria,
    count(*) AS qntItem

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  WHERE t2.descCategoria IS NOT NULL

  GROUP BY t1.idVendedor, t2.descCategoria

)

SELECT *,
  row_number() OVER (PARTITION BY idVendedor ORDER BY qntItem DESC) AS rnItem

FROM tb_itens

QUALIFY rnItem = 1

-- COMMAND ----------

-- DBTITLE 1,4. Quais são as TOP 2 categorias que mais vendem para clientes de cada estado?
WITH tb_completa AS (

  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  LEFT JOIN silver.olist.cliente AS t4
  ON t3.idCliente = t4.idCliente

  WHERE t2.descCategoria IS NOT NULL

),

tb_agrupada AS (

  SELECT
    descUF,
    descCategoria,
    count(*) AS qntItens

  FROM tb_completa

  GROUP BY descUF, descCategoria

  ORDER BY descUF, descCategoria

)

SELECT *,
  row_number() OVER (PARTITION BY descUF ORDER BY qntItens DESC, descCategoria ASC) AS rnItens

FROM tb_agrupada

QUALIFY rnItens <= 2

-- COMMAND ----------

-- DBTITLE 1,5. Quantidade acumulada de itens vendidos por categoria ao longo do tempo.
WITH tb_vendas AS (

  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  WHERE descCategoria IS NOT NULL 

),

tb_agrupada AS (

  SELECT 
    descCategoria,
    date(dtPedido) AS dataPedido,
    count(*) AS qntItens

  FROM tb_vendas

  GROUP BY descCategoria, dataPedido

  ORDER BY descCategoria, dataPedido

)

SELECT *,
  sum(qntItens) OVER (PARTITION BY descCategoria ORDER BY dataPedido ASC) AS qntAcumuladaItens

FROM tb_agrupada


-- COMMAND ----------

-- DBTITLE 1,6. Receita acumulada por categoria ao longo do tempo.
WITH tb_vendas AS (

  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  WHERE descCategoria IS NOT NULL 

),

tb_agrupada AS (

  SELECT 
    descCategoria,
    date(dtPedido) AS dataPedido,
    sum(vlPreco) AS valorReceita

  FROM tb_vendas

  GROUP BY descCategoria, dataPedido

  ORDER BY descCategoria, dataPedido

)

SELECT *,
  sum(valorReceita) OVER (PARTITION BY descCategoria ORDER BY dataPedido ASC) AS receitaAcumulada
  
FROM tb_agrupada

-- COMMAND ----------

-- DBTITLE 1,7. Selecione um dia de venda aleatório de cada vendedor.
WITH tb_dia_vendedor AS (

  SELECT 
    DISTINCT t1.idVendedor,
    date(t2.dtPedido) AS dtPedido

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

)

SELECT *,
  row_number() OVER (PARTITION BY idVendedor ORDER BY rand()) AS rnVendedor

FROM tb_dia_vendedor

QUALIFY rnVendedor = 1


-- COMMAND ----------


