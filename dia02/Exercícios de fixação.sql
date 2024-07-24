-- Databricks notebook source
-- DBTITLE 1,1. Selecione todos os clientes paulistanos (quem nasce na cidade de São Paulo)
SELECT * 

FROM silver.olist.cliente

WHERE descCidade = 'sao paulo'

-- COMMAND ----------

-- DBTITLE 1,1. Selecione todos os clientes paulistanos (quem nasce na cidade de São Paulo) criando uma coluna 'cidade de SP'
SELECT *,

  CASE
    WHEN descCidade = 'sao paulo' THEN 'Paulistano'
  END AS cidadeSP

FROM silver.olist.cliente


-- COMMAND ----------

-- DBTITLE 1,2. Selecione todos os clientes paulistas (quem nasce no estado de São Paulo)
SELECT * 

FROM silver.olist.cliente

WHERE descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,2. Selecione todos os clientes paulistas (quem nasce no estado de São Paulo) criando uma coluna 'Estado de SP'.
SELECT *,

  CASE
    WHEN descUF = 'SP' THEN 'Paulista'
  END AS estadoSP

FROM silver.olist.cliente


-- COMMAND ----------

-- DBTITLE 1,3. Selecione todos os vendedores cariocas e paulistas.
SELECT *

FROM silver.olist.vendedor

WHERE descUF = 'SP'

OR descCidade = 'rio de janeiro'


-- COMMAND ----------

-- DBTITLE 1,4. Selecione produtos de perfumaria e bebes com altura maior que 5cm.
SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('perfumaria', 'bebes')

AND vlAlturaCm > 5

-- COMMAND ----------

-- DBTITLE 1,5. Selecione os pedidos com mais de um item.
SELECT *

FROM silver.olist.item_pedido

WHERE idPedidoItem >=2

-- COMMAND ----------

-- DBTITLE 1,6. Selecione os pedidos que o frete é mais caro que o item.
SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,7. Lista de pedidos que ainda não foram enviados.
SELECT *

FROM silver.olist.pedido

WHERE dtEnvio IS NULL

-- COMMAND ----------

-- DBTITLE 1,8. Lista de pedidos que foram entregues com atraso.
SELECT *,
  date_diff(dtEntregue, dtEstimativaEntrega)

FROM silver.olist.pedido

WHERE date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,9. Lista de pedidos que foram entregues com 2 dias de antecedência.
SELECT *,

 date_diff(date(dtEstimativaEntrega), date(dtEntregue)) AS dtDiff

FROM silver.olist.pedido

WHERE date_diff(date(dtEstimativaEntrega), date(dtEntregue)) = 2


-- COMMAND ----------

-- DBTITLE 1,10. Selecione os pedidos feitos em dezembro de 2017 e entregues com atraso.
SELECT *,
  month(dtPedido) AS mesPedido,
  year(dtPedido) AS anoPedido,
  date_diff(date(dtEntregue), date(dtEstimativaEntrega)) AS diffEntrega

FROM silver.olist.pedido

WHERE date(dtEntregue) > date(dtEstimativaEntrega)

AND month(dtPedido) = 12

AND year(dtPedido) = 2017


-- COMMAND ----------

-- DBTITLE 1,11. Selecione os pedidos com avaliação maior ou igual que 4.
SELECT *

FROM silver.olist.avaliacao_pedido

WHERE vlNota >= 4

-- COMMAND ----------

-- DBTITLE 1,12. Selecione pedidos pagos com cartão de crédito com duas ou mais parcelas menores que R$40,00.
SELECT *

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'

AND nrParcelas >= 2

AND vlPagamento / nrParcelas < 40

-- COMMAND ----------


