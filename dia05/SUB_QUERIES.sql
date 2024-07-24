-- Databricks notebook source
-- DBTITLE 1,Identificando o mês (separei por etapas pra ficar mais fácil de saber como cheguei ao resultado) etapa 1
-- 1. Quais são os TOP 10 vendedores que mais venderam (em quantidade) no mês com maior número de vendas no Olist?

SELECT 
  idPedido,
  dtPedido,
  date_trunc('month', dtPedido) AS dtMonth

FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,Identificando o mês (separei por etapas pra ficar mais fácil de saber como cheguei ao resultado) etapa 2
SELECT 
  date(date_trunc('month', dtPedido)) AS dtMonth,
  count(DISTINCT idPedido) AS qntPedido

FROM silver.olist.pedido

GROUP BY dtMonth

ORDER BY qntPedido DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Identificando o mês (separei por etapas pra ficar mais fácil de saber como cheguei ao resultado) etapa 3
SELECT 
  date(date_trunc('month', dtPedido)) AS dtMonth

FROM silver.olist.pedido

GROUP BY dtMonth

ORDER BY count(DISTINCT idPedido) DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Identificando os vendedores (hard coded)
SELECT 
  t2.idVendedor,
  count(*) AS qntItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'

GROUP BY t2.idVendedor 

ORDER BY qntItens DESC

LIMIT 10

-- COMMAND ----------

-- DBTITLE 1,Identificando os vendedores (subquery)
SELECT 
  t2.idVendedor,
  count(*) AS qntItens

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = (
    -- Identifica mês com mais vendas
  SELECT 
  date(date_trunc('month', dtPedido)) AS dtMonth

  FROM silver.olist.pedido

  GROUP BY dtMonth

  ORDER BY count(DISTINCT idPedido) DESC

  LIMIT 1
)

GROUP BY t2.idVendedor 

ORDER BY qntItens DESC

LIMIT 10

-- COMMAND ----------

-- DBTITLE 1,Exemplo SubQuery FROM
SELECT *

FROM (

  SELECT 
    date(date_trunc('month', dtPedido)) AS dtMonth,
    count(DISTINCT idPedido) AS qntPedido
  FROM silver.olist.pedido
  GROUP BY dtMonth
  ORDER BY qntPedido DESC

)

WHERE dtMonth >= '2018-01-01'

-- COMMAND ----------

-- Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria bebes na blackfriday de 2017-11-01.

-- primeira parte da consulta (vou desmembrar toda a consulta pra saber como fazer depois. Qualquer dúvida, rever o video de Sub Querys/ Day-5)

SELECT *

FROM silver.olist.pedido

WHERE date(date_trunc('month', dtPedido)) = '2017-11-01'



-- COMMAND ----------

-- Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria bebes na blackfriday de 2017-11-01.

-- segunda parte da consulta - Trazendo informações de duas tabelas com o INNER JOIN (tabela PEDIDO + tabela ITEM_PEDIDO). Utilizamos o INNER JOIN pra ter certeza que as informações constam nas duas tabelas.

SELECT *

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01'


-- COMMAND ----------

-- Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria bebes na blackfriday de 2017-11-01.

-- terceira parte da consulta - Trazendo informações de mais uma tabelas com o LEFT JOIN (tabela ITEM_PEDIDO + tabela PRODUTO) e da categoria bebes utilizando o AND.

SELECT *

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' -- só vai trazer informações do mês 11 de 2017 (blackfriday)

AND t3.descCategoria = 'bebes' -- só vai trazer informações da categoria 'bebes'


-- COMMAND ----------

-- Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria bebes na blackfriday de 2017-11-01.

-- quarta parte da consulta - Trazendo informação fazendo distinção por vendedor

SELECT DISTINCT t2.idVendedor -- distinguindo por vendedor, só vai contar um vendedor por linha, sem repetir. Vendedores distintos

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.produto AS t3
ON t2.idProduto = t3.idProduto

WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' -- só vai trazer informações do mês 11 de 2017 (blackfriday)

AND t3.descCategoria = 'bebes' -- só vai trazer informações da categoria 'bebes'

-- COMMAND ----------

-- DBTITLE 1,Identifica vendedores BlackFriday e categoria bebes.
SELECT *

FROM silver.olist.item_pedido

WHERE idVendedor IN (

  SELECT DISTINCT t2.idVendedor 

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' 

  AND t3.descCategoria = 'bebes' 
)

-- COMMAND ----------

-- DBTITLE 1,Histórico de vendas completo dos vendedores.
-- Total de vendas históricas (independente da categoria) dos vendedores que venderam ao menos um produto da categoria bebes na blackfriday de 2017-11-01. SubQuery

SELECT 
  idVendedor,
  count(DISTINCT idPedido) AS qntPedido

FROM silver.olist.item_pedido

WHERE idVendedor IN (

  SELECT DISTINCT t2.idVendedor 

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' 

  AND t3.descCategoria = 'bebes' 
)

GROUP BY idVendedor

ORDER BY qntPedido DESC

-- COMMAND ----------

SELECT 
  t1.idVendedor,
  count(DISTINCT t1.idPedido) AS qntPedido

FROM silver.olist.item_pedido AS t1

RIGHT JOIN (

SELECT DISTINCT t2.idVendedor AS idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' 

  AND t3.descCategoria = 'bebes' 

) AS t2
ON t1.idVendedor = t2.idVendedor

GROUP BY t1.idVendedor

ORDER BY qntPedido DESC

-- COMMAND ----------

SELECT 
  t1.idVendedor,
  count(DISTINCT t2.idPedido) AS qntPedido

FROM (
  SELECT DISTINCT t2.idVendedor AS idVendedor

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  LEFT JOIN silver.olist.produto AS t3
  ON t2.idProduto = t3.idProduto

  WHERE date(date_trunc('month', t1.dtPedido)) = '2017-11-01' 

  AND t3.descCategoria = 'bebes' 

) AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idVendedor = t2.idVendedor

GROUP BY t1.idVendedor

ORDER BY qntPedido DESC
