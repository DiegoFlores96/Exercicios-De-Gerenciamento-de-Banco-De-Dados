/*1. Recuperar os dados dos detalhes de pedidos que sejam referentes a qualquer pedido do cliente 'VINET'. Usar
subquery para localizar os pedidos do cliente 'VINET'.*/
USE [Northwind-pr]
   Select  *,NumeroDoPedido from DetalhesDoPedido
   where  NumeroDoPedido in
   (Select NumeroDoPedido
   from Pedidos
   where CodigoDoCliente ='VINET');

   /*USE [Northwind-pr]
   Select  *  /* oq eu quero*/ from Pedidos /*tabela*/
   where  CodigoDoCliente in /*coluna in subsititui*/ 
   (Select CodigoDoCliente /*coluna*/
   from DetalhesDoPedido /*tabela*/
   where CodigoDoCliente ='VINET');--filtro*/


/*2. Modifique a consulta do exerc�cio 1 e apure o total de cada pedido apresentado. Observe que o total deve ser
apurado, pois n�o existe uma coluna definida.*/ 
 Select NumeroDoPedido,
 SUM(Quantidade*PrecoUnitario)as Valor_Total 
 from DetalhesDoPedido
 group by NumeroDoPedido 
 Having NumeroDoPedido in 
 (Select NumeroDoPedido from Pedidos where CodigoDoCliente='VINET');
/*3. Selecione o c�digo do cliente, n�mero do pedido da tabela �pedidos� somente dos clientes cujo c�digo iniciem
com �TR� e apure, por subquery, a m�dia do pre�o unit�rio de todos os pedidos da tabela �detalhesDoPedido�,
exibindo como �Media Pre�o Unit�rio�.*/  
select cli.CodigoDoCliente,ped.NumeroDoPedido,
(select  AVG(PrecoUnitario)from DetalhesDoPedido det)
as  Medida from Clientes cli 
inner join pedidos ped  on ped.CodigoDoCliente=cli.CodigoDoCliente
where cli.CodigoDoCliente like 'TR%'
/*4. Usando a cl�usula Exists, liste o c�digo do cliente, o nome da empresa e o pa�s de todos os clientes que n�o
tenham nenhum pedido registrado;*/
 SELECT CodigoDoCliente,NomeDaEmpresa,Pais FROM Clientes.cli
 WHERE NOT EXISTS	(SELECT*FROM  Pedidos.ped WHERE ped.CodigoDoCliente=cli.CodigoDoCliente)
 
 /*5.Recuperar o c�digo do produto, o nome e o pre�o unit�rio de todos os produtos cujo pre�o unit�rio seja maior
que o pre�o de qualquer outro produto vendido e que tenha desconto de 25% ou mais. Observe que os dados das
vendas est�o na tabela �DetalhesDoPedido�. Usar o predicado ANY.*/
 SELECT CodigoDoCliente,NomeDoProduto,PrecoUnitario FROM Produtos
 WHERE PrecoUnitario >= ANY(SELECT PrecoUnitario FROM DetalhesDoPedido Where Desconto>= 0.25)
 
/*6.Modifique a consulta do exerc�cio anterior alterando o predicado para ALL.*/

 SELECT CodigoDoProduto,NomeDoProduto,PrecoUnitario FROM Produtos
 WHERE PrecoUnitario >= ALL( SELECT PrecoUnitario FROM DetalhesDoPedido WHERE Desconto>=0.25)
 
 /*7.Usando o predicado IN, liste o c�digo do produto e o nome de todos os produtos que foram vendidos com
desconto igual a 10%.*/
SELECT CodigoDoProduto,NomeDoProduto FROM Produtos
 WHERE CodigoDoProduto IN (SELECT CodigoDoProduto FROM DetalhesDoPedido� WHENEVER Desconto - 0.10)
 
/*8. Crie uma consulta usando UNION, com as tabelas de clientes e fornecedores cujo resultado seja igual ao
apresentado abaixo.*/
SELECT NomeDaEmpresa,NomeDoContato FROM Fornecedores
UNION ALL
SELECT NomeDaEmpresa,NomeDoContato,FROM Clientes

 /*9.Modifique a consulta obtida acima para que o resultado seja igual ao apresentado abaixo.
Total de 122 linhas � mostrando 9*/

SELECT CONVERT(VARCHAR(20),CodigoDoFornecedor) AS Codigo,NomeDaEmpresa,NomeDoContato,'F' AS Tipo FROM Fornecedores
UNION ALL 
SELECT CodigoDoCliente,NomeDaEmpresa,NomeDoContato'C' AS Tipo FROM Clientes


/*10. Construa uma consulta com Inner Join cujo resultado seja semelhante ao apresentado abaixo.
Total de 830 linhas � mostrando 10.*/
 SELECT Cli.CodigoDoCliente,Cli.CodigoDoFornecedor,Ped.NumeroDoPedido,Ped.DataDoPedido,Func.Nome
 SUM (Det.Quantidade*Det.PrecoUnitario)AS ValorTotal
 From Pedidos.Ped
 INNER Join DetalhesDoPedido Det ON Det.NumeroDoPedido = Ped.NumeroDoPedido
 INNER Join Funcionarios Fun ON Fun.CodigoDoFuncionario = Ped.CodigoDoFuncionario
 INNER Join Clientes Cli ON Cli CodigoDoCliente = Ped.CodigoDoCliente
 GROUP BY Ped.NumeroDoPedido,Cli.CodigoDoCliente,Cli.NomeDaEmpresa,Ped.DataDoPedido,Func.Nome 
 GROUP BY CodigoDoCliente ASC