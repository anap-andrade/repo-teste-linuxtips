-- Databricks notebook source
-- DBTITLE 1,1. Qual pedido com maior valor de frete? E o menor?
-- Maior frete

SELECT 
  idPedido,
  sum(vlFrete) AS totalFrete

FROM silver.olist.item_pedido

GROUP BY idPedido

ORDER BY totalFrete DESC

-- COMMAND ----------

-- DBTITLE 1,1. Qual pedido com maior valor de frete? E o menor?
-- Menor frete

SELECT 
  idPedido,
  sum(vlFrete) AS freteTotal

FROM silver.olist.item_pedido

GROUP BY idPedido

ORDER BY freteTotal ASC

-- COMMAND ----------

-- DBTITLE 1,2. Qual vendedor tem mais pedidos?
SELECT 
  idVendedor,
  count(DISTINCT idPedido) AS numPedidos

FROM silver.olist.item_pedido

GROUP BY idVendedor

ORDER BY numPedidos DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,3. Qual vendedor tem mais itens vendidos? E o com menos?
-- Vendedor com mais itens vendidos

SELECT 
  idVendedor,
  count(idProduto) AS qntProdutosVendidos

FROM silver.olist.item_pedido

GROUP BY idVendedor

ORDER BY qntProdutosVendidos DESC

-- COMMAND ----------

-- DBTITLE 1,3. Qual vendedor tem mais itens vendidos? E o com menos?
-- Vendedor com menos itens vendidos

SELECT 
  idVendedor,
  count(idProduto) AS qntProdutosVendidos

FROM silver.olist.item_pedido

GROUP BY idVendedor

ORDER BY qntProdutosVendidos ASC

-- COMMAND ----------

-- DBTITLE 1,4. Qual dia tivemos mais pedidos?
SELECT 
  date(dtPedido) AS dataPedido,
  count(DISTINCT idPedido) AS qntPedidos

FROM silver.olist.pedido

GROUP BY dataPedido

ORDER BY qntPedidos DESC

-- COMMAND ----------

-- DBTITLE 1,5. Quantos vendedores são do estado de São Paulo?
SELECT
  count(DISTINCT idVendedor) AS qntVendedor

FROM silver.olist.vendedor

WHERE descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,6. Quantos vendedores são de Presidente Prudente?
SELECT 
  count(DISTINCT idVendedor) qntVendedor

FROM silver.olist.vendedor

WHERE descCidade = "presidente prudente"

-- COMMAND ----------

-- DBTITLE 1,7. Quantos clientes são do estado do Rio de Janeiro?
SELECT 
  count(DISTINCT idCliente) AS qntClientes

FROM silver.olist.cliente

WHERE descUF = 'RJ'

-- COMMAND ----------

-- DBTITLE 1,8. Quantos produtos são de construção?
SELECT
  count(DISTINCT idProduto) AS qtProduto

FROM silver.olist.produto

WHERE descCategoria LIKE '%construcao%'

-- COMMAND ----------

-- DBTITLE 1,9. Qual o valor médio de um pedido? E do Frete?
SELECT 
  sum(vlPreco) / count(DISTINCT idPedido) AS valorMedioPedido,
  sum(vlFrete) / count(DISTINCT idPedido) AS valorMedioFrete,

  avg(vlPreco) AS valorMedianoPedido,
  avg(vlFrete) AS valorMedianoFrete

FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,10. Em média os pedidos são de quantas parcelas de cartão? E o valor médio por parcela?
SELECT 
  avg(nrParcelas) AS mediaNumParcelas,
  avg(vlPagamento / nrParcelas) AS mediaValorParcela

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'

-- COMMAND ----------

-- DBTITLE 1,11. Quanto tempo em média demora para um pedido chegar depois de aprovado?
SELECT 
  avg(date_diff(dtEntregue, dtAprovado)) AS mediaChegadaPedido

FROM silver.olist.pedido

WHERE descSituacao = 'delivered'

-- COMMAND ----------

-- DBTITLE 1,12. Qual estado tem mais vendedores?
SELECT descUF,
  count(DISTINCT idVendedor) AS numVendedorEstado

FROM silver.olist.vendedor

GROUP BY descUF

ORDER BY numVendedorEstado DESC

-- COMMAND ----------

-- DBTITLE 1,13. Qual cidade tem mais clientes?
SELECT descCidade,
  count(DISTINCT idCliente) AS qntDeClientes, -- clientes que podem não ser únicos
  count(DISTINCT idClienteUnico) AS qtClienteDistinto -- clientes únicos

FROM silver.olist.cliente

GROUP BY descCidade

ORDER BY qntDeClientes DESC

-- COMMAND ----------

-- DBTITLE 1,14. Qual categoria tem mais itens?
SELECT descCategoria,
  count(idProduto) AS itensPorCategoria

FROM silver.olist.produto

GROUP BY descCategoria

ORDER BY itensPorCategoria DESC

-- COMMAND ----------

-- DBTITLE 1,15. Qual categoria tem maior peso médio de produto?
SELECT descCategoria,
  avg(vlPesoGramas) AS mediaPesoProduto,
  count(DISTINCT idProduto) AS qtProduto

FROM silver.olist.produto

GROUP BY descCategoria

ORDER BY mediaPesoProduto DESC

-- COMMAND ----------

-- DBTITLE 1,16. Qual a série histórica de pedidos por dia? E receita?
SELECT 
  date(dtPedido) AS diaPedido,
  count(DISTINCT idPedido) AS qtPedido

FROM silver.olist.pedido

GROUP BY diaPedido

ORDER BY diaPedido 


-- COMMAND ----------

-- DBTITLE 1,17. Qual produto é o campeão de vendas? Em receita? Em quantidade?
-- Campeão de vendas

SELECT idProduto,
  count(idProduto) AS qntPrpdutosVendidos,
  sum(vlPreco) AS vlReceita

FROM silver.olist.item_pedido

GROUP BY idProduto

ORDER BY qntPrpdutosVendidos DESC

-- COMMAND ----------

-- DBTITLE 1,17. Qual produto é o campeão de vendas? Em receita? Em quantidade?
-- Campeão em receita

SELECT idProduto,
  count(idProduto) AS qntPropVendidos,
  sum(vlPreco) AS vlReceita

FROM silver.olist.item_pedido

GROUP BY idProduto

ORDER BY vlReceita DESC

-- COMMAND ----------


