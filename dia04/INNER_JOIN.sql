-- Databricks notebook source
-- DBTITLE 1,Observe que aqui existem campos nulos na t2, o que impossibilita de trazer todos os dados de maneira correta
SELECT *

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE t2.idPedido IS null 

-- COMMAND ----------

-- DBTITLE 1,Essa é uma maneira de contornar esse problema, utilizando o is not null
SELECT *

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE t2.idPedido IS NOT NULL 

-- COMMAND ----------

-- DBTITLE 1,Utilizando o INNER JOIN a gente garante que só vamos pegar itens que existem em ambas as tabelas
SELECT *

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

 

-- COMMAND ----------

-- Como saber qual utilizar? LEFT JOIN ou INNER JOIN? Vai depender do problema que você está tentando resolver. Por isso é importante conhece a base de dados que você está utilizando, 
-- entender o comportamento do seu dado. Isso só a pratica vai dizer.

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

-- COMMAND ----------

SELECT *

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

LEFT JOIN silver.olist.cliente AS t4
ON t1.idCliente = t4.idCliente

-- COMMAND ----------

-- DBTITLE 1,Neste caso a tabela de item_pedido(t2) só foi utilizada como intermediária entre as tabelas de pedido(t1) e de vendedor(t3)
SELECT t1.idPedido,
  t1.idCliente,
  t4.descUF AS descUFcliente,
  t3.idVendedor,
  t3.descUF AS descUFvendedor

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

LEFT JOIN silver.olist.cliente AS t4
ON t1.idCliente = t4.idCliente

-- COMMAND ----------


