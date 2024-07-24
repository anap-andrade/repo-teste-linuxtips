-- Databricks notebook source
-- DBTITLE 1,Utilizando o LEFT JOIN, a tabela da esquerda é a referencia pra buscar os dados da tabela da direita
SELECT * 

FROM silver.olist.item_pedido

LEFT JOIN silver.olist.produto
ON silver.olist.item_pedido.idProduto = silver.olist.produto.idProduto

-- COMMAND ----------

-- DBTITLE 1,Pra leitura ficar mais fluida, podemos dar "apelidos" para as tabelas. Fica mais fácil de visualizar o código. O resultado é o mesmo
SELECT * 

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

-- COMMAND ----------

-- DBTITLE 1,Podemos filtrar somente as colunas que desejamos consultar sem precisar trazer as tabelas completas.
SELECT t1.idPedido,
  t1.idPedidoItem,
  t1.idProduto,
  t1.vlPreco,
  t1.vlFrete,
  t2.descCategoria

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

-- COMMAND ----------

-- DBTITLE 1,Podemos também trazer todas as colunas de uma tabela e apenas algumas colunas específicas de outra tabela.
SELECT t1.*,
  t2.descCategoria

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

-- COMMAND ----------

SELECT *

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

-- COMMAND ----------

SELECT t1.*,
  t2.descUF

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

-- COMMAND ----------

SELECT *

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

LEFT JOIN silver.olist.produto AS t3
ON t1.idProduto = t3.idProduto

-- COMMAND ----------

SELECT t1.*,
  t2.descUF AS descUFvendedor,
  t3.descCategoria,
  t3.vlPesoGramas

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

LEFT JOIN silver.olist.produto AS t3
ON t1.idProduto = t3.idProduto

-- COMMAND ----------

SELECT t1.*,
  t2.descUF AS descUFvendedor,
  t3.descCategoria,
  t3.vlPesoGramas

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.vendedor AS t2
ON t1.idVendedor = t2.idVendedor

LEFT JOIN silver.olist.produto AS t3
ON t1.idProduto = t3.idProduto

WHERE t2.descUF = 'SP'

-- COMMAND ----------


