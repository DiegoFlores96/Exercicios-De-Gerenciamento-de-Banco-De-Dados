--1. Crie uma tabela tempor�ria, com a estrutura igual � da tabela production.product, por�m VAZIA, usando o into.

USE  AdventureWorks2008R2;
SELECT TOP 0*
INTO  #temp
FROM Production.product

 /*2- Atrav�s da fun��o DatePart, construa a consulta para descobrir o dia da semana em que voc� nasceu,
atrav�s do n�mero onde 1=Domingo, 2-segunda... 7-S�bado.*/
SELECT DATEPART (WEEKDAY,'1996-1-17')AS dia_da_semana

/*3-Construa uma consulta que apure o dia da semana, por extenso, em que cada um dos funcion�rios tabela
employee nasceu. A coluna que contem a data de nascimento � a �BirthDate�. Deve mostrado
�Domingo�, Segunda-feira�, .... �S�bado�.*/SELECT BirthDate, 'Dia da  Semana'=CASEWHEN DATEPART(WEEKDAY,BirthDate)=1 THEN 'Domingo'WHEN DATEPART(WEEKDAY,BirthDate)=2 THEN 'Seguda-Feira'WHEN DATEPART(WEEKDAY,BirthDate)=3 THEN 'Ter�a_Feira'WHEN DATEPART(WEEKDAY,BirthDate)=4 THEN 'Quarta-Feira'WHEN DATEPART(WEEKDAY,BirthDate)=5 THEN 'Quinta-Feira'WHEN DATEPART(WEEKDAY,BirthDate)=6 THEN 'Sexta-Feira'WHEN DATEPART(WEEKDAY,BirthDate)=7 THEN 'Sababo'ENDFROM HumanResources.Employee--4. Modificando a consulta do exerc�cio anterior, liste apenas os funcion�rios que nasceram no domingo. SELECT BirthDate, 'Dia da  Semana'=
CASE
WHEN DATEPART(WEEKDAY,BirthDate)=1 THEN 'Domingo'
WHEN DATEPART(WEEKDAY,BirthDate)=2 THEN 'Seguda-Feira'
WHEN DATEPART(WEEKDAY,BirthDate)=3 THEN 'Ter�a_Feira'
WHEN DATEPART(WEEKDAY,BirthDate)=4 THEN 'Quarta-Feira'
WHEN DATEPART(WEEKDAY,BirthDate)=5 THEN 'Quinta-Feira'
WHEN DATEPART(WEEKDAY,BirthDate)=6 THEN 'Sexta-Feira'
WHEN DATEPART(WEEKDAY,BirthDate)=7 THEN 'Sababo'
END
FROM HumanResources.Employee
WHERE DATEPART(WEEKDAY,BirthDate)=1/*5. Construa uma consulta que calcule o valor de cada item do pedido, que consta na tabela
�DetalhesdoPedido� da base �Northwind�. A f�rmula deve considerar a quantidade de itens multiplicada
pelo pre�o unit�rio e desse total, deve ser calculado o desconto, em %. Considere que pode haver
registros onde a colunas �desconto� pode ser NULL e isso deve ser tratado.*/

USE [Northwind-pr]
SELECT NumeroDoPedido,CodigoDoProduto,PrecoUnitario,Quantidade,Coalesce(Desconto,0)As Desconto,
ROUND(SUM((PrecoUnitario*Quantidade)-((PrecoUnitario* Quantidade) *Desconto)),2)AS 'Valor com Desconto'
FROM DetalhesDoPedido
Group By NumeroDoPedido,CodigoDoProduto,Desconto,PrecoUnitario,Quantidade

/*6. Por que a convers�o abaixo n�o � executada com sucesso?
select convert(int, FromCurrencyCode) from sales.CurrencyRate*/
 A  conevers�o n�o foi realizada pois n�o � permitido Converter um VARCHAR Para um Tipo INT, O Varchar permite diversos tipos de caracteres  como caracteres especiais ,letras e numero  e o INT  Permite Apenas Numeros inteiros
--7. Usando tabela tempor�ria, construa os scripts para:
--a. Crie uma local com 3 campos, CPF, Nome e e-mail.
CREATE TABLE #TEMP(Codigo INT ,Nome VARCHAR(20),CPF VARCHAR(15),E_MAIL VARCHAR(30))
 --b. Insira 4 registros
INSERT INTO #TEMP(Codigo,Nome,CPF,E_MAIL) Values(1,'DiegoFlores',31287655519,'DiegoFlores96_96@hotmail.com')
INSERT INTO #TEMP(Codigo,Nome,CPF,E_MAIL) Values(2,'Andre Luiz',31387655518,'Andre_Luiz@hotmail.com')
INSERT INTO #TEMP(Codigo,Nome,CPF,E_MAIL) Values(3,'Fabio dos Reis',11287655519,'FabioDosReis@hotmail.com')
INSERT INTO #TEMP(Codigo,Nome,CPF,E_MAIL) Values(4,'Marcos Campos',31287655519,'MarcosCampos@hotmail.com')
--c. Consulte
SELECT * FROM #TEMP
--d. Exclua 2 registros
DELETE FROM #TEMP
  WHERE Codigo=4 OR Codigo=3
--e. Consulte
SELECT*FROM #TEMP
--f. Drop a tabela ao final.
DROP TABLE #TEMP

--Pesquisa formas de verificar se a tabela tempor�ria j� existe e adicione aos scripts a e f, como forma

--De evitar erro na execu��o. Ou seja, s� criar a tabela se ainda n�o existir e s� exclu�-la, caso exista.
-- FORMA DE TESTAR A EXISTECIA DA TABELA
IF object_id('tempdb..#tmpPessoa') IS NOT NULL 
BEGIN
     DROP TABLE #tmpPessoa
END

CREATE TABLE #tmpPessoa
(
    id INT,
    nome VARCHAR(100)
)
GO
 
 

 

  
 
