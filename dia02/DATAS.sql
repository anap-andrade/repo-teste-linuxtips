-- Databricks notebook source
-- DBTITLE 1,Selecinando data
SELECT '2023-01-01' -- ano-mes-dia

-- COMMAND ----------

-- DBTITLE 1,Somando dias a uma data
SELECT date_add('2023-01-01', 30) -- ano-mes-dia

-- COMMAND ----------

-- DBTITLE 1,Somando dias a uma data 2
SELECT date_add('2023-01-01', 61) -- ano-mes-dia

-- COMMAND ----------

-- DBTITLE 1,Forma 1 para subtrair dias
SELECT date_add('2023-01-01', -15) 

-- COMMAND ----------

-- DBTITLE 1,Forma 2 para subtrair dias
SELECT date_sub('2023-01-01', 15)

-- COMMAND ----------

-- DBTITLE 1,Adicionando meses a uma data
SELECT add_months('2023-01-01', 12)

-- COMMAND ----------

-- DBTITLE 1,Subtraindo meses a uma data
SELECT add_months('2023-01-01', -12)

-- COMMAND ----------

-- DBTITLE 1,Extraindo o ano de uma data
SELECT year('2023-01-01')

-- COMMAND ----------

-- DBTITLE 1,Extraindo o mês de uma data
SELECT month('2023-01-01')

-- COMMAND ----------

-- DBTITLE 1,Extraindo o dia de uma data
SELECT day('2023-01-01')

-- COMMAND ----------

-- DBTITLE 1,Extraindo o dia da semana (ver dias da semana no sql spark functions) - (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
SELECT dayofweek('2023-01-01')

-- COMMAND ----------

-- DBTITLE 1,Diferença de dias entre uma data e outra
SELECT date_diff('2023-06-01', '2023-01-01')

-- COMMAND ----------

-- DBTITLE 1,Diferença de meses entre uma data e outra
SELECT months_between('2023-06-01', '2023-01-01')

-- COMMAND ----------

-- DBTITLE 1,Extraindo dados de um banco de dados
SELECT *
FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,Calculando dias entre o pedido e a entrega, criando uma nova coluna que possua essas informações
SELECT *,
  date_diff(dtEntregue, dtPedido)

FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,Extraindo apenas as colunas necessárias para a visualização dos dados necessários
SELECT idPedido,
  idCliente,
  dtPedido,
  dtEntregue,
  date_diff(dtEntregue, dtPedido)

FROM silver.olist.pedido

-- COMMAND ----------

-- DBTITLE 1,Renomeando a coluna criada para extrair as datas entre pedido e entrega (essas consultas não alteram nada no banco de dados)
SELECT idPedido,
  idCliente,
  dtPedido,
  dtEntregue,
  date_diff(dtEntregue, dtPedido) AS diasEntreEntregaPedido

FROM silver.olist.pedido

-- COMMAND ----------


