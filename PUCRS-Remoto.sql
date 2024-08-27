CREATE TABLE clientes AS SELECT * FROM DSILVA.clientes;
CREATE TABLE pessoas_juridicas AS SELECT * FROM DSILVA.pessoas_juridicas;
CREATE TABLE pessoas_fisicas AS SELECT * FROM DSILVA.pessoas_fisicas;
CREATE TABLE estados AS SELECT * FROM DSILVA.estados;
CREATE TABLE cidades AS SELECT * FROM DSILVA.cidades;
CREATE TABLE enderecos AS SELECT * FROM DSILVA.enderecos;
CREATE TABLE telefones AS SELECT * FROM DSILVA.telefones;
CREATE TABLE categorias AS SELECT * FROM DSILVA.categorias;
CREATE TABLE produtos AS SELECT * FROM DSILVA.produtos;
CREATE TABLE pedidos AS SELECT * FROM DSILVA.pedidos;
CREATE TABLE entregas AS SELECT * FROM DSILVA.entregas;
CREATE TABLE itens_pedidos AS SELECT * FROM DSILVA.itens_pedidos;

SELECT * FROM CLIENTES;
SELECT * FROM PESSOAS_JURIDICAS;
SELECT * FROM PESSOAS_FISICAS;
SELECT * FROM ESTADOS;
SELECT * FROM CIDADES;
SELECT * FROM ENDERECOS;
SELECT * FROM TELEFONES;
SELECT * FROM PEDIDOS;
SELECT * FROM CATEGORIAS;
SELECT * FROM PRODUTOS;
SELECT * FROM ENTREGAS;
SELECT * FROM ITENS_PEDIDOS;

EXPLAIN PLAN FOR 
SELECT *
FROM clientes
WHERE cod_cliente > 224;   

SELECT PLAN_TABLE_OUTPUT 
FROM TABLE(DBMS_XPLAN.DISPLAY());

EXPLAIN PLAN FOR 
SELECT *
FROM clientes
WHERE cod_cliente < 224;   

SELECT PLAN_TABLE_OUTPUT 
FROM TABLE(DBMS_XPLAN.DISPLAY());


EXPLAIN PLAN FOR 
SELECT *
FROM clientes
WHERE cod_cliente > 224;   


SELECT PLAN_TABLE_OUTPUT 
FROM TABLE(DBMS_XPLAN.DISPLAY());

-- 1. Listar os dados dos clientes cujo primeiro nome é 'Fernando'.
SELECT * FROM clientes WHERE nome LIKE 'Fernando%';

-- 2. Listar o nome e a data de cadastro dos clientes pessoa física.
SELECT nome, data_cadastro FROM clientes WHERE tipo = 'F';

-- 3. Listar o nome e a data de cadastro dos clientes pessoa física cadastrados há menos de 2 anos.
SELECT nome, data_cadastro FROM clientes WHERE data_cadastro >= ADD_MONTHS(SYSDATE, -24) AND tipo = 'F';

 
-- 4. Listar o nome dos produtos e de suas categorias, bem como os nomes dos
-- clientes que pediram esses produtos em 2019 e s�o do g�nero feminino.
-- DICA: fun��es para tratar data - TO_DATE('01/01/2019','dd/mm/yyyy') TO_DATE('31/12/2019','dd/mm/yyyy')

SELECT * FROM PRODUTOS;
SELECT * FROM CATEGORIAS;
SELECT * FROM ITENS_PEDIDOS;

DESC pedidos;
DESC clientes;
DESC produtos;
DESC categorias;
DESC itens_pedidos;
DESC pessoas_fisicas;

SELECT p.NOME AS nome_produto,
       c.NOME AS nome_categoria,
       cli.NOME AS nome_cliente,
       ped.DATA_EMISSAO AS data_emissao
FROM produtos p
JOIN categorias c ON p.COD_CATEGORIA = c.COD_CATEGORIA
JOIN itens_pedidos ip ON p.COD_PRODUTO = ip.COD_PRODUTO
JOIN pedidos ped ON ip.NUM_PEDIDO = ped.NUM_PEDIDO
JOIN clientes cli ON ped.COD_CLIENTE = cli.COD_CLIENTE
JOIN pessoas_fisicas pf ON cli.COD_CLIENTE = pf.COD_CLIENTE
WHERE pf.GENERO = 'F'
  AND ped.DATA_EMISSAO BETWEEN TO_DATE('01/01/2019', 'dd/mm/yyyy')
                            AND TO_DATE('31/12/2019', 'dd/mm/yyyy');