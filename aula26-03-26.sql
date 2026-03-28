CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Clientes(
	id_client INT PRIMARY KEY,
    client_name VARCHAR(100),
	client_city VARCHAR(50),
    client_uf CHAR(2),
    date_birth DATE
);

INSERT INTO Clientes VALUES (10, 'Ana Silva', 'São Paulo', 'SP', '2023-01-15');
INSERT INTO Clientes VALUES (11, 'Bruno Souza', 'Curitiba', 'PR', '2023-05-20');
INSERT INTO Clientes VALUES (12, 'Carla Dias', 'São Paulo', 'SP', '2024-02-10');
INSERT INTO Clientes VALUES (13, 'Diego Lemos', 'Belo Horizonte', 'MG', '2024-03-01');

CREATE TABLE Categorias(
	id_category INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO Categorias VALUES (1, 'Eletrônicos');
INSERT INTO Categorias VALUES (2, 'Móveis');
INSERT INTO Categorias VALUES (3, 'Informática');

CREATE TABLE Produtos(
	id_product INT PRIMARY KEY,
    description VARCHAR(100),
    unit_price DECIMAL(9,2),
    stock INT,
    id_category INT,
    CONSTRAINT fk_category FOREIGN KEY(id_category) REFERENCES Categorias (id_category)
);

INSERT INTO Produtos VALUES (101, 'Smartphone X', 2500.00, 50, 1);
INSERT INTO Produtos VALUES (102, 'Cadeira Gamer', 1200.00, 15, 2);
INSERT INTO Produtos VALUES (103, 'Mouse Sem Fio', 150.00, 100, 3);
INSERT INTO Produtos VALUES (104, 'Monitor 4K', 3200.00, 10, 3);
INSERT INTO Produtos VALUES (105, 'Mesa de Escritório', 850.00, 8, 2);

CREATE TABLE Vendas(
	id_sales INT PRIMARY KEY,
    id_client INT,
    CONSTRAINT fk_client FOREIGN KEY(id_client) REFERENCES Clientes(id_client),
    id_product INT,
    CONSTRAINT fk_product FOREIGN KEY(id_product) REFERENCES Produtos(id_product),
    quantidade INT,
    date_sale DATE
);

INSERT INTO Vendas VALUES (1001, 10, 101, 1, '2024-03-10');
INSERT INTO Vendas VALUES (1002, 11, 102, 2, '2024-03-12');
INSERT INTO Vendas VALUES (1003, 10, 103, 5, '2024-03-15');
INSERT INTO Vendas VALUES (1004, 12, 101, 1, '2024-03-20');
INSERT INTO Vendas VALUES (1005, 13, 105, 1, '2024-03-22');
INSERT INTO Vendas VALUES (1006, 10, 104, 1, '2024-03-25');

SELECT MAX(unit_price) FROM Produtos WHERE id_category = 3;

SELECT MIN(unit_price) FROM Produtos WHERE id_category = 2;

SELECT id_category, COUNT(id_product) AS total_Produtos 
FROM Produtos
GROUP BY id_category;
/* 
COUNT(id_product) vai contar a quantidade que existe dentro de cada agrupamento 
AS da uma apelido para à coluna
FROM Produtos - indica a tabela onde os nossos dados estão armazenados
GROUP BY id_category - Separa cada contagem que tiver o mesmo id em uma "pilha".
*/

SELECT MAX(p.unit_price) AS maior_venda
FROM Vendas v
JOIN CLientes c ON v.id_client = c.id_client
JOIN Produtos p ON v.id_product = p.id_product
WHERE c.client_city = 'São Paulo';

/*
FROM Vendas indica a tabela que iremos trabalhar, o 'a' é um apelido, ao invés de chamar Vendas.id_product, chamamos v.id_product
JOIN - ele vai conectar tabelas diferentes que tem informações em comum
JOIN Cliente c (novamente dando apelido para Cliente) - 
ON a regra que deve encaixar as peças
v.id_client = c.id_client - se os id forem exatamente o mesmo, ele junta à linha
WHERE c.client_city = 'São Paulo' - Joga fora todo as linhas onde a cidade do cliente não seja 'São Paulo'
*/

SELECT SUM(quantidade) AS soma_EstoqueVendas
FROM Vendas
WHERE id_product = 101;

SELECT SUM(unit_price) AS soma_Vendas
FROM Vendas v
JOIN Produtos p ON v.id_product = p.id_product
WHERE v.id_product = 101;

SELECT MAX(unit_price) AS maiorValor
FROM Vendas v
JOIN Produtos p ON v.id_product = p.id_product
WHERE v.date_sale BETWEEN '2024-03-15' AND '2024-03-25';

/*
O BETWEEN serve para determinar um intervalo
*/
INSERT INTO Vendas VALUES (2000, 99, 101, 1, '2024-04-01');