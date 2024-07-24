-- Databricks notebook source
-- DBTITLE 1,1. Crie a tabela com as instruções do exercício
DROP TABLE IF EXISTS sandbox.linuxtips.exercicio_ana;

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.exercicio_ana (
  id INT,
  nome STRING,
  dt_nascimento DATE,
  profissao STRING,
  renda FLOAT,
  uf STRING,
  nacionalidade STRING
);

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------

-- DBTITLE 1,2. Popular a tabela com os dados do exercício
INSERT INTO sandbox.linuxtips.exercicio_ana 
VALUES (1, 'Maria', '1989-01-18', 'Artesã', 1450.90, 'MG', 'Brasileira'),
(2, 'José', '1987-06-25', 'Mecânico', 2756.87, 'SP', 'Brasileira'),
(3, 'Manoel', '1995-09-13', 'Operador de máquinas pesadas', 3245.53, 'SP', 'Brasileira'),
(4, 'Antônia', '1991-02-28', 'Tratorista', 3135.47, 'SC', 'Brasileira'),
(5, 'Maria Eduarda', '1985-12-29', 'Serviço gerais', 1649.21, 'BA', 'Brasileira'),
(6, 'João de Deus', '1999-03-14', 'Manobrista', 2375.78, 'PE', 'Brasileira'),
(7, 'Eduardo', '2003-05-04', 'Atendente', 3157.06, 'AM', 'Haiti'),
(8, 'Mônica', '2006-10-09', 'Estudante', 550.00, 'SP', 'Brasileira'),
(9, 'Bruno', '1998-02-26', 'Encanador', 1459.98, 'MG', 'Brasileira'),
(10, 'Letícia', '1982-04-01', 'Marceneira', 1698.74, 'SP', 'Angolana'),
(11, 'Tomé', '1971-07-31', 'Porteiro', 2670.32, 'SP', 'Brasileira')

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------

-- DBTITLE 1,3. O atendente Eduardo, id=7, ganhou um aumento de 15% em seu salário. Precisamos atualizar seus dados. Pode fazer isso?
UPDATE sandbox.linuxtips.exercicio_ana SET renda = round(3157.06 *1.15, 2) -- round 2 serve para deixar o resultado com 2 casas decimais 
WHERE id = 7 

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------

-- DBTITLE 1,4. Maria Eduarda, id=5 foi promovida à copeira e seu novo salário será de R$2150,00. Vamos atualizar seus dados?
UPDATE sandbox.linuxtips.exercicio_ana SET renda = 2150, profissao = 'Copeira' -- pra fazer UPDADE em mais de um campo, basta separar por virgula
WHERE id = 5;

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------

-- DBTITLE 1,5. Manoel, id=3, saiu da empresa e solicitou a exclusão de seus dados. Como podemos fazer essa operação?
DELETE FROM sandbox.linuxtips.exercicio_ana
WHERE id = 3

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------

-- DBTITLE 1,6. O salário mínimo nacional aumentou 5%, como podemos atualizar todos os salários da tabela?
UPDATE sandbox.linuxtips.exercicio_ana SET renda = round(renda * 1.05, 2)

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------

-- DBTITLE 1,7. O governo brasileiro está dando incentivo para empresas que valorizam a mão de obra imigrante. Portanto, todas as pessoas não brasileiras receberam um aumento de 2,5% em seus respectivos salários.
UPDATE sandbox.linuxtips.exercicio_ana SET renda = round(renda * 1.025)
WHERE nacionalidade != 'Brasileira'

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.exercicio_ana

-- COMMAND ----------


