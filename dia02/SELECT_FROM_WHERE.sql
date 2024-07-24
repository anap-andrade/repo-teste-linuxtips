-- Databricks notebook source
-- DBTITLE 1,Filtros para produtos mais caros ou iguais a R$500,00
SELECT *

FROM silver.olist.item_pedido

WHERE vlPreco >= 500

-- COMMAND ----------

-- DBTITLE 1,Comparando produto aonde o valor de frete é maior do que o valor do produto
SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,Fazendo dois filtros na mesma consulta (preço maior que 100 e frete maior que preço)
SELECT *

FROM silver.olist.item_pedido

WHERE vlPreco >= 100 AND vlFrete > vlPreco

-- COMMAND ----------

SELECT *

FROM silver.olist.produto

-- COMMAND ----------

SELECT *

FROM silver.olist.produto

WHERE descCategoria = 'pet_shop'

-- COMMAND ----------

SELECT *

FROM silver.olist.produto

WHERE descCategoria = 'pet_shop'

OR descCategoria = 'telefonia'

-- COMMAND ----------

-- DBTITLE 1,Filtrando produtos de pet shop, telefonia e bebes usando OR
SELECT *

FROM silver.olist.produto

WHERE descCategoria = 'pet_shop'

OR descCategoria = 'telefonia'

OR descCategoria = 'bebes'

-- COMMAND ----------

-- DBTITLE 1,Filtrando produtos de pet shop, telefonia e bebes usando IN
SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('pet_shop', 'telefonia', 'bebes')

-- COMMAND ----------

-- DBTITLE 1,Selecionando pedido por intervalo de dias. Não vai aparecer o dia 31 desta maneira
SELECT *

FROM silver.olist.pedido

WHERE dtPedido >= '2017-01-01'

AND dtPedido <= '2017-01-31'

-- COMMAND ----------

-- DBTITLE 1,Transformando o campo dtPedido (data e hora) em apenas data para que traga o dia 31 inteiro, sem restrição de horário
-- Intervalo de datas (Mês de Janeiro)

SELECT idPedido,
  idCliente,
  descSituacao,
  dtPedido,
  date(dtPedido)

FROM silver.olist.pedido

WHERE date(dtPedido) >= '2017-01-01'

AND date(dtPedido) <= '2017-01-31'

-- COMMAND ----------

-- DBTITLE 1,Mesma consulta de cima feita de maneira diferente
-- Interval de datas (Mês de Janeiro)

SELECT *

FROM silver.olist.pedido

WHERE date(dtPedido) >= '2017-01-01'

AND date(dtPedido) <= '2017-01-31'

-- COMMAND ----------

-- Mês de Janeiro de 2017

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) = 1

-- COMMAND ----------

-- DBTITLE 1,Trazendo dados dos meses 1 e 6 de 2017. Desta maneira não vai filtrar da maneira correta
-- o AND está se referindo ao ano de 2017, mas o OR não está se referindo ao ano indicado no WHERE (2017). Sendo assim, a condição OR vai trazer todos os pedidos do mês 6 de todos os anos que constam na coluna dtPedido 

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017

AND month(dtPedido) = 1

OR month(dtPedido) = 6

-- COMMAND ----------

-- DBTITLE 1,Trazendo dados dos meses 1 e 6 de 2017. agora sim trazendo os dados corretos
-- Para que as duas condições sejam válidas (AND e OR) e tragam o resultado esperado pelo WHERE, é necessário que as duas condições estejam entre parenteses. Assim ambas vão ser executadas junto com o WHERE.

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017

AND (month(dtPedido) = 1

OR month(dtPedido) = 6)

-- COMMAND ----------

-- DBTITLE 1,Operações matemáticas e suas ordens
SELECT 10 * 2 + 100

-- COMMAND ----------

-- DBTITLE 1,Operações matemáticas e suas ordens 2
SELECT 10 * (2 + 100)

-- COMMAND ----------

-- DBTITLE 1,Trazendo dados dos meses 1 e 6 de 2017 utilizando IN
-- O IN vai trazer o que estiver dentro de um conjunto, ou seja, tudo o que estiver nos meses 1 e 6. Essa é uma forma mais simples de fazer a mesma consulta anterior que utilizamos AND e OR.

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017

AND month(dtPedido) IN (1, 6)

-- COMMAND ----------


