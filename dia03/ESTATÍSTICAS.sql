-- Databricks notebook source
-- DBTITLE 1,Algumas medidas estatísticas que podem ser utilizadas
SELECT 
  sum(vlPreco) / count(vlPreco), -- média na mão
  avg(vlPreco), -- média aritumética dos valores dos produtos
  min(vlPreco), -- valor mais barato nos valores, mínimo de um campo
  percentile(vlPreco, 0.25), -- mediana

  max(vlFrete), -- máximo de frete pago
  std(vlFrete), -- desvio padrão dos valores
  percentile(vlFrete, 0.5), -- mediana 
  avg(vlFrete) -- média do valor do frete

FROM silver.olist.item_pedido
