-- Databricks notebook source
-- DBTITLE 1,Exercício 1
-- 1.  Qual a nota (média, mínima e máxima) de cada vendedor que tiveram vendas no ano de 2017? E o percentual de pedidos avaliados com nota 5?

WITH tb_pedidos AS (

  SELECT DISTINCT
    t2.idPedido,
    t1.idVendedor

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE year(t2.dtPedido) = 2017

),

tb_avaliacoes AS (

SELECT *,
  CASE WHEN vlNota = 5 THEN 1 ELSE 0 END AS flNota5 -- é preferível deixar o case when aqui, mas ambas as maneiras são igualmente performáticas.
FROM tb_pedidos AS t1

INNER JOIN silver.olist.avaliacao_pedido AS t2
ON t1.idPedido = t2.idPedido

)

SELECT 
  idVendedor,
  avg(vlNota) AS avgNota,
  max(vlNota) AS maxNota,
  min(vlNota) AS minNota,
  avg(flNota5) AS pctNota5,
  avg(CASE WHEN vlNota = 5 THEN 1 ELSE 0 END) AS pctNota5_v2 --o resultado é o mesmo utilizando o case when aqui e lá em cima, por isso o professor deixou os dois exemplos.

FROM tb_avaliacoes

GROUP BY idVendedor

-- COMMAND ----------

-- DBTITLE 1,Exercício 2
-- 2. Calcule o valor do pedido médio, o valor do pedido mais caro e mais barato de cada vendedor que realizaram vendas entre 2017-01-01 e 2017-06-30.

WITH tb_item_pedido AS (  -- primeira consulta seleciona apenas os pedidos e valores dentre 2017-01-01 e 2017-06-30

  SELECT 
    t2.idPedido,
    t2.idVendedor,
    t2.vlPreco  -- preço de cada item

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido <= '2017-06-30'

),

tb_pedido_receita AS (  -- segunda consulta faz o agrupamento ente vendedor e idPedido e descobre qual o preço total por pedido

  SELECT 
    idVendedor,
    idPedido,
    sum(vlPreco) AS vlTotal, -- soma o valor total de cada item vendido por pedido
    count(*)  -- o count foi utilizado só pra mostrar que tem pedidos com mais de um item

  FROM tb_item_pedido

  GROUP BY idVendedor, idPedido

),

tb_final AS ( -- terceira consulta faz um agrupamento, mostrando quando cada vendedor vendeu em media por pedido, o pedido mais barato e o mais caro.

  SELECT 
    idVendedor,
    avg(vlTotal) AS avgValorPedido,
    min(vlTotal) AS minValorPedido,
    max(vlTotal) AS maxValorPedido

  FROM tb_pedido_receita

  GROUP BY idVendedor

)

SELECT *
FROM tb_final

-- COMMAND ----------

-- DBTITLE 1,Exercício 2 - versão alternativa
WITH tb_pedido_receita AS (

  SELECT 
    t2.idPedido,
    t2.idVendedor,
    sum(t2.vlPreco) AS vlTotal
  
  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido <= '2017-06-30'

  GROUP BY t2.idPedido, t2.idVendedor

),

tb_final AS ( -- terceira consulta faz um agrupamento, mostrando quando cada vendedor vendeu em media por pedido, o pedido mais barato e o mais caro.

  SELECT 
    idVendedor,
    avg(vlTotal) AS avgValorPedido,
    min(vlTotal) AS minValorPedido,
    max(vlTotal) AS maxValorPedido

  FROM tb_pedido_receita

  GROUP BY idVendedor

)

SELECT *
FROM tb_final

-- COMMAND ----------

-- DBTITLE 1,Exercício 3
-- 3. Calcule a quantidade de pedidos por meio de pagamento que cada vendedor teve em seus pedidos entre 2017-01-01 e 2017-06-30.

WITH tb_pedido_vendedor AS (

SELECT DISTINCT -- utilizamos o distinct neste caso pra não retornar vendas duplicadas, já que pode haver vendas separadas por item
  t2.idPedido,
  t2.idVendedor

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

WHERE dtPedido >= '2017-01-01'
AND dtPedido < '2017-07-01'

),

tb_pedido_pagamento AS (

  SELECT 
    t1.idVendedor,
    t1.idPedido,
    t2.descTipoPagamento

  FROM tb_pedido_vendedor AS t1

  LEFT JOIN silver.olist.pagamento_pedido AS t2
  ON t1.idPedido = t2.idPedido

)

SELECT 
  idVendedor,
  descTipoPagamento,
  count(DISTINCT idPedido) AS qntPedido

FROM tb_pedido_pagamento

WHERE idVendedor = '9de4643a8dbde634fe55621059d92273'

GROUP BY idVendedor, descTipoPagamento
ORDER BY idVendedor, descTipoPagamento

-- COMMAND ----------

-- DBTITLE 1,Exercício 4
-- 4. Combine a query do exercício 2 e 3 de tal forma, que cada linha seja um vendedor, e que haja colunas para cada meio de pagamento (com a quantidade de pedidos) e as colunas das estatísticas do pedido do exercício 2 (média, maior valor e menor valor).

WITH tb_pedido_receita AS (

  SELECT 
    t2.idPedido,
    t2.idVendedor,
    sum(vlPreco) AS vlReceita

  FROM silver.olist.pedido AS t1

  INNER JOIN silver.olist.item_pedido AS t2
  ON t1.idPedido = t2.idPedido

  WHERE dtPedido >= '2017-01-01'
  AND dtPedido < '2017-07-01'

  GROUP BY t2.idPedido, t2.idVendedor

),

tb_sumario_pedidos AS (  -- trabela temporária do exercício 2

  SELECT 
      idVendedor,
      avg(vlReceita) AS avgValorPedido,
      min(vlReceita) AS minValorPedido,
      max(vlReceita) AS maxValorPedido

    FROM tb_pedido_receita

    GROUP BY idVendedor

),

tb_pedido_pagamento AS (  -- tabela temporária exercício 03

  SELECT 
    t1.idVendedor,
    t2.descTipoPagamento,
    count(DISTINCT t1.idPedido) AS qntPedido

  FROM tb_pedido_receita AS t1

  LEFT JOIN silver.olist.pagamento_pedido AS t2
  ON t1.idPedido = t2.idPedido

  GROUP BY t1.idVendedor, t2.descTipoPagamento
  ORDER BY t1.idVendedor, t2.descTipoPagamento

),

tb_pagamento_coluna AS (

  SELECT 
    idVendedor,
    SUM(CASE WHEN descTipoPagamento = 'boleto' THEN qntPedido END) AS qntBoleto,
    SUM(CASE WHEN descTipoPagamento = 'credit_card' THEN qntPedido END) AS qntCredit_card,
    SUM(CASE WHEN descTipoPagamento = 'voucher' THEN qntPedido END) AS qntVoucher,
    SUM(CASE WHEN descTipoPagamento = 'debit_card' THEN qntPedido END) AS qntDebit_card

  FROM tb_pedido_pagamento

  GROUP BY idVendedor

)

SELECT 
  t1.*,
  qntBoleto,
  qntCredit_card,
  qntVoucher,
  qntDebit_card

FROM tb_sumario_pedidos AS t1

LEFT JOIN tb_pagamento_coluna AS t2
ON t1.idVendedor = t2.idVendedor


-- COMMAND ----------


