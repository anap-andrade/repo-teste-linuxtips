-- Databricks notebook source
-- DBTITLE 1,1. Qual categoria tem mais produtos vendidos?
SELECT 
  t2.descCategoria,
  count(*) AS qntdCategoria

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY qntdCategoria DESC

-- COMMAND ----------

-- DBTITLE 1,2. Qual categoria tem produtos mais caros, em média? E Mediana?
SELECT 
  t2.descCategoria,
  avg(t1.vlPreco) AS mediaValor,
  percentile(t1.vlPreco, 0.5) AS medianaValor

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY avg(t1.vlPreco) DESC

-- COMMAND ----------

-- DBTITLE 1,3. Qual categoria tem maiores fretes, em média?
SELECT 
  t2.descCategoria,
  avg(t1.vlFrete) AS mediaFrete

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria

ORDER BY mediaFrete DESC

-- COMMAND ----------

-- DBTITLE 1,4. Os clientes de qual estado pagam mais frete, em média?
SELECT 
  t3.descUF AS estadoCliente,
  sum(t1.vlFrete) / count(DISTINCT t1.idPedido) AS avgFretePorPedido,
  avg(t1.vlFrete) AS avgFreteItem,
  sum(t1.vlFrete) / count(DISTINCT t2.idCliente) AS avgFretePorCliente

FROM silver.olist.item_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
  ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY avgFretePorPedido DESC

-- COMMAND ----------

-- DBTITLE 1,5. Clientes de quais estados avaliam melhor, em média? Proporção de 5?
SELECT 
  t1.descUF,
  avg(t3.vlNota) AS mediaNota

FROM silver.olist.cliente AS t1

LEFT JOIN silver.olist.pedido AS t2
  ON t1.idCliente = t2.idCliente

LEFT JOIN silver.olist.avaliacao_pedido AS t3
  ON t2.idPedido = t3.idPedido

GROUP BY t1.descUF

ORDER BY mediaNota DESC

--LIMIT 5

-- COMMAND ----------

-- DBTITLE 1,5. Clientes de quais estados avaliam melhor, em média? Proporção de 5 (qual estado tem mais avaliaões=5 proporcionalmente)?
SELECT 
  t3.descUF,
  avg(t1.vlNota) AS avgNota,
  avg(CASE WHEN t1.vlNota = 5 THEN 1 ELSE 0 END) AS prop5

FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF

ORDER BY prop5 DESC

-- COMMAND ----------

-- DBTITLE 1,6. Vendedores de quais estados tem as piores reputações?
SELECT 
  t3.descUF,
  avg(t1.vlNota) AS avgNota

FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

GROUP BY t3.descUF

ORDER BY avgNota

-- COMMAND ----------

-- DBTITLE 1,7. Quais estados de clientes levam mais tempo para a mercadoria chegar?
SELECT 
  t2.descUF,
  avg(datediff(t1.dtEntregue, t1.dtPedido)) AS qntDias
  
FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente

WHERE t1.dtEntregue IS NOT NULL

GROUP BY t2.descUF

ORDER BY qntDias DESC

-- COMMAND ----------

-- DBTITLE 1,8. Qual meio de pagamento é mais utilizado por clientes do RJ?
SELECT 
  t1.descTipoPagamento,
  count(DISTINCT t1.idPedido) AS qntPedidos

FROM silver.olist.pagamento_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

WHERE t3.descUF = 'RJ'

GROUP BY t1.descTipoPagamento

ORDER BY qntPedidos DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,9. Qual estado sai mais ferramentas?
SELECT 
  t3.descUF,
  count(*) AS qntProdutoVendido

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

LEFT JOIN silver.olist.vendedor AS t3
ON t1.idVendedor = t3.idVendedor

WHERE t2.descCategoria LIKE '%ferramentas%'

GROUP BY t3.descUF

ORDER BY qntProdutoVendido DESC

-- COMMAND ----------

-- DBTITLE 1,10. Qual estado tem mais compras por cliente?
SELECT 
  t2.descUF,
  count(DISTINCT t1.idPedido) AS qntPedido,
  count(DISTINCT t2.idClienteUnico) AS qntClienteUnico,
  count(DISTINCT t1.idPedido) / count(DISTINCT t2.idClienteUnico) AS avgPedidoCliente

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t2.descUF

ORDER BY avgPedidoCliente DESC

-- COMMAND ----------


