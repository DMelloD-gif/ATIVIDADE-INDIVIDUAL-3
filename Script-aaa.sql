CREATE DATABASE db_revenda_pichau_kabum_davidemello;

--tabelas
CREATE TABLE produtos (
    id SERIAL primary key,
    nome VARCHAR(100) not null unique,
    descricao TEXT not null,
    preco DECIMAL(10,2) not null check (preco > 0),
    categoria VARCHAR(50) NOT NULL
);


CREATE TABLE clientes (
    id SERIAL primary key,
    nome VARCHAR(100) not null,
    sobrenome VARCHAR(200) not null,
    telefone CHAR(11) not null unique,
    endereco VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE
);


CREATE TABLE fornecedores (
    id SERIAL PRIMARY KEY,
    nome_empresa VARCHAR(100) NOT NULL,
    contato VARCHAR(100) NOT NULL,
    telefone CHAR(11) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cnpj CHAR(14) not null unique
);


CREATE TABLE estoque (
    id SERIAL PRIMARY KEY,
    quantidade INT DEFAULT 0 CHECK (quantidade >= 0),
    data_entrada DATE NOT NULL,
    produto_id INT NOT NULL REFERENCES produtos(id),
    fornecedor_id INT NOT NULL REFERENCES fornecedores(id)
);


CREATE TABLE pagamentos (
    id SERIAL PRIMARY KEY,
    tipo_pagamento VARCHAR(20) NOT NULL CHECK (tipo_pagamento IN ('pix', 'boleto', 'cartao')),
    status_pagamento VARCHAR(20) DEFAULT 'pendente',
    data_pagamento DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    observacao TEXT
);

CREATE TABLE vendas (
    cliente_id INT NOT NULL REFERENCES clientes(id),
    produto_id INT NOT NULL REFERENCES produtos(id),
    data_venda DATE not null,
    pagamento_id INT not null references pagamentos(id),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (cliente_id, produto_id, data_venda)
);


--inserts
INSERT INTO produtos (nome, descricao, preco, categoria) VALUES
('Notebook Dell', 'Notebook i7 16GB RAM', 4500.00, 'Informática'),
('Mouse Gamer', 'Mouse óptico RGB 7200DPI', 120.00, 'Acessórios'),
('Teclado Mecânico', 'Teclado mecânico switch azul', 350.00, 'Acessórios'),
('Monitor LG', 'Monitor 24 polegadas Full HD', 899.99, 'Informática'),
('Impressora HP', 'Impressora multifuncional a jato de tinta', 650.00, 'Escritório'),
('Cadeira Gamer', 'Cadeira ergonômica preta e vermelha', 1200.00, 'Móveis'),
('Headset HyperX', 'Headset gamer som 7.1', 499.90, 'Acessórios'),
('Smartphone Samsung', 'Galaxy S22 128GB', 3500.00, 'Telefonia'),
('HD Externo', 'HD portátil 1TB USB 3.0', 299.00, 'Armazenamento'),
('Pen Drive', 'Pen drive 64GB Sandisk', 80.00, 'Armazenamento');


INSERT INTO clientes (nome, sobrenome, telefone, endereco, cpf) VALUES
('Carlos', 'Silva', '11999999999', 'Rua A, 123', '12345678901'),
('Ana', 'Oliveira', '11988888888', 'Av. Central, 45', '23456789012'),
('Bruno', 'Costa', '21977777777', 'Rua B, 222', '34567890123'),
('Mariana', 'Souza', '31966666666', 'Rua C, 89', '45678901234'),
('Pedro', 'Lima', '11955555555', 'Av. Paulista, 1000', '56789012345'),
('Fernanda', 'Pereira', '21944444444', 'Rua D, 300', '67890123456'),
('João', 'Santos', '11933333333', 'Rua E, 400', '78901234567'),
('Julia', 'Martins', '11922222222', 'Rua F, 500', '89012345678'),
('Ricardo', 'Alves', '31911111111', 'Rua G, 600', '90123456789'),
('Beatriz', 'Ribeiro', '11900000000', 'Rua H, 700', '01234567890');


INSERT INTO fornecedores (nome_empresa, contato, telefone, endereco, cnpj) VALUES
('Dell Brasil', 'João Almeida', '11333333333', 'Av. Tech, 100', '12345678000101'),
('HP do Brasil', 'Maria Santos', '11444444444', 'Av. Impress, 200', '23456789000102'),
('Samsung Eletrônicos', 'Carlos Costa', '11555555555', 'Rua Phone, 300', '34567890000103'),
('LG Eletrônicos', 'Ana Oliveira', '11666666666', 'Rua Display, 400', '45678901000104'),
('Kingston', 'Ricardo Lima', '11777777777', 'Av. Memória, 500', '56789012000105'),
('HyperX Brasil', 'Paulo Souza', '11888888888', 'Rua Gamer, 600', '67890123000106'),
('Sandisk', 'Fernanda Silva', '11999999998', 'Rua Storage, 700', '78901234000107'),
('Multilaser', 'Juliana Pereira', '11222222222', 'Av. Brasil, 800', '89012345000108'),
('Positivo Informática', 'Bruno Ribeiro', '11313131313', 'Rua PC, 900', '90123456000109'),
('CadeiraX', 'Mariana Martins', '11414141414', 'Av. Conforto, 1000', '01234567000110');

INSERT INTO estoque (quantidade, data_entrada, produto_id, fornecedor_id) VALUES
(50, '2025-08-01', 1, 1),
(100, '2025-08-02', 2, 8),
(80, '2025-08-02', 3, 5),
(40, '2025-08-03', 4, 4),
(30, '2025-08-04', 5, 2),
(20, '2025-08-05', 6, 10),
(60, '2025-08-06', 7, 6),
(25, '2025-08-07', 8, 3),
(70, '2025-08-08', 9, 7),
(150, '2025-08-09', 10, 7);


INSERT INTO pagamentos (tipo_pagamento, status_pagamento, data_pagamento, valor, observacao) VALUES
('pix', 'concluido', '2025-08-10', 4500.00, 'Pagamento à vista'),
('cartao', 'pendente', '2025-08-11', 3500.00, 'Cartão de crédito 12x'),
('boleto', 'concluido', '2025-08-12', 1200.00, 'Pago antes do vencimento'),
('pix', 'concluido', '2025-08-13', 650.00, 'Cliente fiel'),
('cartao', 'concluido', '2025-08-14', 500.00, 'Parcelado 2x'),
('pix', 'pendente', '2025-08-15', 899.99, 'Aguardando'),
('boleto', 'concluido', '2025-08-16', 299.00, 'Quitado'),
('cartao', 'concluido', '2025-08-17', 499.90, 'Crédito aprovado'),
('pix', 'concluido', '2025-08-18', 80.00, 'Pago no mesmo dia'),
('boleto', 'pendente', '2025-08-19', 350.00, 'Aguardando compensação');


INSERT INTO vendas (cliente_id, produto_id, data_venda, pagamento_id, quantidade) VALUES
(1, 1, '2025-08-10', 1, 1),
(2, 8, '2025-08-11', 2, 1),
(3, 6, '2025-08-12', 3, 1),
(4, 5, '2025-08-13', 4, 1),
(5, 7, '2025-08-14', 5, 1),
(6, 4, '2025-08-15', 6, 1),
(7, 9, '2025-08-16', 7, 1),
(8, 3, '2025-08-17', 8, 1),
(9, 10, '2025-08-18', 9, 2),
(10, 2, '2025-08-19', 10, 3);



-- consultas
SELECT * FROM produtos;
SELECT * FROM clientes;
SELECT * FROM fornecedores;
SELECT * FROM estoque;
SELECT * FROM pagamentos;
SELECT * FROM vendas;

-- views
CREATE VIEW vw_vendas_detalhadas AS
select v.data_venda, c.nome, c.sobrenome AS cliente, p.nome AS produto, p.categoria, v.quantidade, pg.tipo_pagamento, pg.status_pagamento, pg.valor, pg.data_pagamento
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
JOIN produtos p ON v.produto_id = p.id
JOIN pagamentos pg ON v.pagamento_id = pg.id;

select * from vw_vendas_detalhadas;

---
CREATE VIEW vw_estoque_produtos AS
select e.id as id_estoque, p.nome AS produto, p.categoria, f.nome_empresa AS fornecedor, e.quantidade, e.data_entrada
FROM estoque e
JOIN produtos p ON e.produto_id = p.id
JOIN fornecedores f ON e.fornecedor_id = f.id;

select * from vw_estoque_produtos;


--- aula - 28/08

--Faça uma consulta filtrando um campo de texto utilizando like;
select * from clientes where nome like '%Beatriz%';

--Execute um comando explain;
explain select * from clientes where nome like '%Pedro%';

--Crie um index para a coluna que utilizou no filtro acima;
create index index_clientes on clientes (nome);

--Refaça a consulta e execute o explain novamente. 
explain select * from produtos where nome like '%Notebook Dell%';

-- Altere uma coluna de varchar para int, avalie o retorno, inclusive se for erro
alter table clientes alter column endereco type int; 


-- Altere uma coluna de int para varchar avalie o retorno, inclusive se for erro;
alter table estoque alter column quantidade type varchar(100);

--Crie um usuário com seu nome e dê todas as permissões de acesso
--para todas as tabelas
CREATE USER davidemello WITH PASSWORD 'senha_forte_aqui';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO davidemello;

--Crie um usuário para seu colega apenas com
--permissão de select em uma das tabelas;
CREATE USER PEDRAO WITH PASSWORD 'senha_forte_aqui';
GRANT SELECT ON produtos TO PEDRAO;

--Refaça todos os items no usuário que criou para seu colega, 
--registre tudo que ocorreu (erros e acertos).

--De volta no seu usuário, crie 12 consultas, sendo 3 
--consultas semelhantes 
--(somente com alteração do tipo de join: inner, left e right). 
--Ou seja, são 4 consultas 
--diferentes, sendo que cada consulta terá 3 versões,
--uma com cada tipo de join;

--consulta 1
SELECT c.nome, c.sobrenome, v.data_venda, v.quantidade
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id;

SELECT c.nome, c.sobrenome, v.data_venda, v.quantidade
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id;

SELECT c.nome, c.sobrenome, v.data_venda, v.quantidade
FROM clientes c
RIGHT JOIN vendas v ON c.id = v.cliente_id;

--consula 2
SELECT p.nome AS produto, f.nome_empresa AS fornecedor, e.quantidade
FROM produtos p
INNER JOIN estoque e ON p.id = e.produto_id
INNER JOIN fornecedores f ON e.fornecedor_id = f.id;

SELECT p.nome AS produto, f.nome_empresa AS fornecedor, e.quantidade
FROM produtos p
LEFT JOIN estoque e ON p.id = e.produto_id
LEFT JOIN fornecedores f ON e.fornecedor_id = f.id;

SELECT p.nome AS produto, f.nome_empresa AS fornecedor, e.quantidade
FROM produtos p
RIGHT JOIN estoque e ON p.id = e.produto_id
RIGHT JOIN fornecedores f ON e.fornecedor_id = f.id;

--consulta3
SELECT v.data_venda, p.tipo_pagamento, p.status_pagamento, v.quantidade
FROM vendas v
INNER JOIN pagamentos p ON v.pagamento_id = p.id;

SELECT v.data_venda, p.tipo_pagamento, p.status_pagamento, v.quantidade
FROM vendas v
LEFT JOIN pagamentos p ON v.pagamento_id = p.id;

SELECT v.data_venda, p.tipo_pagamento, p.status_pagamento, v.quantidade
FROM vendas v
RIGHT JOIN pagamentos p ON v.pagamento_id = p.id;

--consulta 4
SELECT p.nome AS produto, e.quantidade, f.nome_empresa AS fornecedor
FROM produtos p
INNER JOIN estoque e ON p.id = e.produto_id
INNER JOIN fornecedores f ON e.fornecedor_id = f.id;

SELECT p.nome AS produto, e.quantidade, f.nome_empresa AS fornecedor
FROM produtos p
LEFT JOIN estoque e ON p.id = e.produto_id
LEFT JOIN fornecedores f ON e.fornecedor_id = f.id;

SELECT p.nome AS produto, e.quantidade, f.nome_empresa AS fornecedor
FROM produtos p
RIGHT JOIN estoque e ON p.id = e.produto_id
RIGHT JOIN fornecedores f ON e.fornecedor_id = f.id;


--Atualize registros com colunas NULL;
alter table estoque alter column produto_id drop not null;
update estoque set produto_id = null where produto_id = 2;




