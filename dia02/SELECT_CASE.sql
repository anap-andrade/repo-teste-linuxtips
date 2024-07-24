-- Databricks notebook source
-- DBTITLE 1,Faixas de preço 1
SELECT *,
  CASE 
    WHEN vlPreco <= 100 THEN '000 -| 100'
    WHEN vlPreco <= 200 THEN '100 -| 200'
  END
FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Criando faixas de preço 2
SELECT *,
  CASE 
    WHEN vlPreco <= 100 THEN '000 -| 100'
    WHEN vlPreco <= 200 THEN '100 -| 200'
    ELSE '>200'
  END
  
FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Criando faixas de preço 3
SELECT *,
  CASE 
    WHEN vlPreco <= 100 THEN '000 -| 100'
    WHEN vlPreco <= 200 THEN '100 -| 200'
    WHEN vlPreco <= 300 THEN '200 -| 300'
    WHEN vlPreco <= 400 THEN '300 -| 400'
    WHEN vlPreco <= 500 THEN '400 -| 500'
    WHEN vlPreco <= 600 THEN '500 -| 600'
    WHEN vlPreco <= 700 THEN '600 -| 700'
    WHEN vlPreco <= 800 THEN '700 -| 800'
    WHEN vlPreco <= 900 THEN '800 -| 900'
    WHEN vlPreco <= 1000 THEN '900 -| 1000'
    ELSE '>1000'
  END
  
FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Criando faixas de preço 4
SELECT *,
  CASE 
    WHEN vlPreco <= 100 THEN '000 -| 100'
    WHEN vlPreco <= 200 THEN '100 -| 200'
    WHEN vlPreco <= 300 THEN '200 -| 300'
    WHEN vlPreco <= 400 THEN '300 -| 400'
    WHEN vlPreco <= 500 THEN '400 -| 500'
    WHEN vlPreco <= 600 THEN '500 -| 600'
    WHEN vlPreco <= 700 THEN '600 -| 700'
    WHEN vlPreco <= 800 THEN '700 -| 800'
    WHEN vlPreco <= 900 THEN '800 -| 900'
    WHEN vlPreco <= 1000 THEN '900 -| 1000'
    ELSE '>1000'
  END AS faixaDePreco
  
FROM silver.olist.item_pedido

-- COMMAND ----------

-- DBTITLE 1,Níveis de Frete
SELECT *,
  CASE
    WHEN vlFrete / (vlFrete + vlPreco) = 0 THEN 'Frete Gratuito'
    WHEN vlFrete / (vlFrete + vlPreco) <= 0.2 THEN 'Frete Baixo'
    WHEN vlFrete / (vlFrete + vlPreco) <= 0.4 THEN 'Frete Médio'
    ELSE 'Frete Alto'
  END AS descFrete

FROM silver.olist.item_pedido
 

-- COMMAND ----------

-- DBTITLE 1,Região dos clientes do Brasil 
SELECT *,
 CASE
    WHEN descUF IN ('RS', 'PR', 'SC') THEN 'Sul'
    WHEN descUF IN ('SP', 'MG', 'RJ', 'ES') THEN 'Sudeste'
    WHEN descUF IN ('MS', 'MT', 'GO', 'DF') THEN 'Centro-Oeste'
    WHEN descUF IN ('AC', 'RO', 'AM', 'RR', 'PA', 'AP', 'TO') THEN 'Norte'
    ELSE 'Nordeste'
  END AS descRegiao

FROM silver.olist.cliente


-- COMMAND ----------

-- DBTITLE 1,Nacionalidade dos vendedores
SELECT *,
  CASE
    WHEN descUF = 'SP' THEN 'Paulista'
    WHEN descUF = 'RJ' THEN 'Fluminense'
    WHEN descUF = 'MG' THEN 'Mineiro'
    WHEN descUF = 'AC' THEN 'Acreano'
    WHEN descUF = 'BA' THEN 'Baiano'
    WHEN descUF = 'RS' THEN 'Gaúcho'
    WHEN descUF = 'SC' THEN 'Catarinense'
    ELSE 'Não Identificado'

  END AS descNacionalidade

FROM silver.olist.vendedor

-- COMMAND ----------


