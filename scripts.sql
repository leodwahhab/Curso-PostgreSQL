create table cliente (
	id integer not null,
	nome varchar(50) not null,
	cpf char(11),
	rg varchar(15),
	data_nascimento date, 
	genero char(1),
	profissao varchar(30),
	nacionalidade varchar(30),
	logradouro varchar(30),
	numero varchar(10),
	complemento varchar(30),
	bairro varchar(30),
	municipio varchar(30),
	uf varchar(30),
	observacoes text,
	
	constraint pk_cliente_id primary key (id) 
);

alter table cliente
alter column id type bigint;

alter table cliente
alter column id
add generated always as identity; -- Clausula 'generated always as' adiciona regra para geração de valor para uma coluna. no caso do identity, ele gerará um valor inteiro sequencial

insert into cliente (nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf) 
values (
	'Manoel', '88828383821', '32323', '2001-01-30', 'M', 'Estudante', 'Brasileira', 'Rua Joao Nabuco', '23', 'Casa','Cidade Nova','Porto','SC'
);

insert into cliente (nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf)
values (
	'Geraldo','12343299929', '56565', '1987-10-01', 'M', 'Engenheiro', 'Brasileira','Rua das Limas','200','AP','Centro','Poro Uniao','SC'
);

select * from cliente;

--exercicios - comando insert

INSERT INTO cliente (
    nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, 
    logradouro, numero, complemento, bairro, municipio, uf
) VALUES
('Manoel', '88828383821', '32323', '2001-10-10', 'M', 'Estudante', 'Brasileira', 'Rua Joaquim Nabuco', '23', 'Casa', 'Cidade Nova', 'Porto União', 'SC'),
('Geraldo', '12343292921', '56565', '1987-04-01', 'M', 'Engenheiro', 'Brasileira', 'Rua das Limas', '200', 'Ap.', 'Centro', 'P. União', 'SC'),
('Carlos', '87732323227', '55463', '1967-01-10', 'M', 'Pedreiro', 'Brasileira', 'Rua das Laranjeiras', '300', 'Apart.', 'Cto.', 'Canoinhas', 'SC'),
('Adriana', '12321222122', '98777', '1989-10-09', 'F', 'Jornalista', 'Brasileira', 'Rua das Limas', '240', NULL, 'São Pedro', 'Porto Vitória', 'PR'),
('Amanda', '99982838822', '28382', '1991-04-03', 'F', 'Jorn.', 'Brasileira', 'Av. Central', '100', NULL, 'São Pedro', 'General Carneiro', 'PR'),
('Ângelo', '99982828181', '12323', '2000-01-01', 'M', 'Professor', 'Brasileiro', 'Av. Beira Mar', '300', NULL, 'Ctr.', 'São Paulo', 'SP'),
('Anderson', NULL, NULL, NULL, 'M', 'Prof.', 'Italiano', 'Av. Brasil', '100', 'Apartamento', 'Santa Rosa', 'Rio de Janeiro', 'RJ'),
('Camila', '9998282828', NULL, '2001-10-10', 'F', 'Professora', 'Norte americana', 'Rua Central', '4333', NULL, NULL, 'Uberlândia', 'MG'),
('Cristiano', NULL, NULL, NULL, 'M', 'Estudante', 'Alemã', 'Rua do Centro', '877', 'Casa', 'Centro', 'Porto Alegre', 'RS'),
('Fabrício', '8828282828', '32323', NULL, 'M', 'Estudante', 'Brasileiro', 'Rua das Laranjeiras', NULL, NULL, NULL, 'PU', 'SC'),
('Fernanda', NULL, NULL, NULL, 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('Gilmar', '88818181818', '888', '2000-02-10', 'M', 'Estud.', 'Brasileiro', 'Rua das Laranjeiras', '200', 'C. Nova', NULL, 'Canoinhas', 'SC'),
('Diego', '1010191919', '111939', NULL, 'M', 'Professor', 'Alemão', 'Av. Central', '455', 'Casa', 'Cidade N.', 'São Paulo', 'SP'),
('Jeferson', NULL, NULL, '1983-07-01', 'M', NULL, 'Brasileiro', NULL, NULL, NULL, 'União da Vitória', 'União da Vitória', 'PR'),
('Jessica', NULL, NULL, NULL, 'F', 'Estudante', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

select 'CPF: ' || cpf || ' RG: ' ||  rg as cpf_rg from cliente where cpf is not null and rg is not null;

select nome, data_nascimento from cliente where data_nascimento > '2000-01-01';

select nome from cliente where nome like 'C%';

update cliente set nome = 'teste' where id = 1;

select id, nome from cliente where id = 1;

insert into cliente (nome) values ('João');

select * from cliente order by id desc;

delete from cliente 
where id = (
		select id 
		from cliente 
		order by id desc 
		limit 1
	);

	
-- exercicios: comandos update e delete
INSERT INTO cliente (
    nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, 
    logradouro, numero, complemento, bairro, municipio, uf
) VALUES
('Maicon', '12349596421', '1234', '1965-10-10', 'F', 'Empresário', NULL, NULL, NULL, NULL, null, 	'Florianópolis', 'PR'),
('Getúlio', NULL, '4631', NULL, 'F', 'Estudante', 'Brasileira', 'Rua Central', '343', 'Apartamento', 'Centro', 'Curitiba', 'SC'),
('Sandra', NULL, NULL, NULL, 'M', 'Professor', 'Italiana', NULL, '12', 'Bloco A', NULL, NULL, NULL);

select * from cliente order by id desc;

update cliente
set cpf = '45390569432', genero = 'M', nacionalidade = 'Brasileira', uf = 'SC'
where nome like '%Maicon%';

update cliente
set data_nascimento = '1978-04-01', genero = 'M'
where nome like 'Get%lio';

update cliente
set genero = 'F', profissao = 'Professora', numero = '123'
where nome like '%Sandra%';

delete from cliente 
where nome like '%Sandra%';

delete from cliente 
where nome like '%Maicon%';

-- criacao de novas tabelas
create table profissao (
	id bigint not null,
	nome varchar(30) not null,
	constraint pk_profissao_id primary key(id)
);

--esqueci de definir a coluna nome como unique na criação da tabela
alter table profissao add constraint unique_profissao_nome unique (nome);
alter table profissao alter column id add generated always as identity;

insert into profissao (nome) values ('Estudante'), ('Engenheiro'), ('Pedreiro'), ('Jornalista'), ('Professor');

select * from profissao;

create table nacionalidade (
	id bigint not null generated always as identity,
	nome varchar(30) not null,
	constraint pk_ncn_id primary key (id),
	constraint un_ncn_nome unique (nome)
);

insert into nacionalidade (nome) values ('Brasileira'), ('Italiana'), ('Norte-Americana'), ('Alemã');

select * from nacionalidade;

create table complemento (
	id bigint not null generated always as identity,
	nome varchar(30) not null,
	constraint pk_cpl_id primary key (id),
	constraint un_cpl_nome unique (nome)
);

insert into complemento (nome) values ('Casa'), ('Apartamento');

create table bairro (
	id bigint not null generated always as identity,
	nome varchar(30) not null,
	constraint pk_brr_id primary key (id),
	constraint un_brr_nome unique (nome)
);

insert into bairro (nome) values ('Cidade Nova'), ('Centro'), ('São Pedro'),('Santa Rosa');

select * from bairro;

-- chaves estrangeiras

--profissao
alter table cliente
add column idprofissao bigint;

alter table cliente
add constraint fk_cli_idprofissao foreign key (idprofissao) references profissao (id);

update cliente
set idprofissao = 1
where profissao like 'Estu%';

update cliente
set idprofissao = 2
where profissao like 'Eng%';

update cliente
set idprofissao = 3
where profissao like 'Pedreiro%';

update cliente
set idprofissao = 4
where profissao like 'Jorn%';

update cliente
set idprofissao = 5
where profissao like 'Prof%';

alter table cliente
drop column profissao;

select* from cliente;

--nacionalidade
alter table cliente
add column idnacionalidade bigint;

alter table cliente
add constraint fk_cli_idnacionalidade foreign key (idnacionalidade) references nacionalidade (id);

update cliente
set idnacionalidade = 1
where nacionalidade like 'Bra%';

update cliente
set idnacionalidade = 2
where nacionalidade like 'Ita%';

update cliente
set idnacionalidade = 3
where nacionalidade like 'Nort%';

update cliente
set idnacionalidade = 4
where nacionalidade like 'Ale%';

alter table cliente
drop column nacionalidade;

select* from cliente;

--complemento
alter table cliente
add column idcomplemento bigint;

alter table cliente
add constraint fk_cli_idcomplemento foreign key (idcomplemento) references complemento (id);

update cliente
set idcomplemento = 1
where complemento like 'C%';

update cliente
set idcomplemento = 2
where complemento like 'A%';

alter table cliente
drop column complemento;

select cli.nome, cli.idcomplemento, cpl.nome from cliente cli left join complemento cpl on cli.idcomplemento = cpl.id ;

--bairro
alter table cliente
add column idbairro bigint;

alter table cliente
add constraint fk_cli_idbairro foreign key (idbairro) references bairro (id);

update cliente
set idbairro = 1
where bairro like 'Cidade%';

update cliente
set idbairro = 2
where bairro like 'Cen%';

update cliente
set idbairro = 3
where bairro like 'São%';

update cliente
set idbairro = 4
where bairro like 'Santa%';

alter table cliente
drop column bairro;

select cli.id, cli.nome, cli.idbairro, cpl.nome from cliente cli left join bairro cpl on cli.idbairro = cpl.id order by cli.id;

select * from cliente;

drop table uf;

create table uf (
	id bigint not null generated always as identity,
	nome varchar(30) not null,
	sigla varchar(2) not null,
	constraint pk_uf_id primary key (id)
);

alter table uf
add constraint un_uf_sigla unique (sigla);

insert into uf (nome, sigla) values
('Santa Catarina', 'SC'),
('Paraná', 'PR'),
('São Paulo', 'SP'),
('Minas Gerais', 'MG'),
('Rio Grande do Sul', 'RS'),
('Rio de Janeiro', 'RJ');
	
select * from uf;

create table municipio (
	id bigint not null generated always as identity,
	nome varchar(30) not null,
	iduf bigint,
	constraint pk_mcp_id primary key (id),
	constraint un_mcp_nome unique (nome),
	constraint fk_mcp_iduf foreign key (iduf) references uf (id)
);

insert into municipio (nome, iduf) values ('Uberlândia', 4), ('Rio de Janeiro', 6), ('União da Vitória', 2),('Porto União', 1), ('São Paulo', 3), ('Canoinhas', 1),('Porto Alegre', 5), ('Curitiba', 2), ('Porto Vitória', 2), ('General Carneiro', 2);

select * from cliente where municipio is not null;

alter table cliente
add column idmunicipio bigint;

alter table cliente
add constraint fk_cli_idmunicipio foreign key (idmunicipio) references municipio (id);

update cliente 
set idmunicipio = 4
where municipio like 'Uber%';

update cliente 
set idmunicipio = 6
where municipio like 'Rio%';

update cliente 
set idmunicipio = 2
where municipio like '%Vitória%' or municipio like 'Curiti%' or municipio like '%Carneiro%';

update cliente 
set idmunicipio = 3
where municipio like '%Paulo%';

update cliente 
set idmunicipio = 1
where municipio like 'Canoinhas%' or municipio like '%Uniao' or municipio like 'PU%';

update cliente 
set idmunicipio = 5
where municipio like '%Alegre%';

select cli.id, cli.nome as cliente, mcp.nome as municipio, uf.nome as uf from cliente cli left join municipio mcp on cli.idmunicipio = mcp.id left join uf on mcp.iduf = uf.id;


alter table cliente
drop column uf;

alter table cliente
drop column municipio;

-- criacao de novas tabelas

drop table fornecedor;

create table fornecedor (
	id bigint not null generated always as identity constraint pk_fnc_id primary key,
	nome varchar(50) not null unique
);

create table vendedor ( 
	id bigint not null generated always as identity constraint pk_vnd_id primary key,
	nome varchar(50) not null unique
);

create table transportadora ( 
	id bigint not null generated always as identity primary key,
	nome varchar(50) not null unique ,
	logradouro varchar(50),
	numero varchar(10),
	idmunicipio bigint,
	constraint fk_trp_idmunicipio foreign key (idmunicipio) references municipio(id)
);

create table produto (
	id bigint not null generated always as identity,
	nome varchar(50) not null,
	valor numeric(10,2) not null,
	idfornecedor bigint not null,
	constraint pk_prd_id primary key (id),
	constraint un_prd_nome unique (nome),
	constraint fk_prd_idfornecedor foreign key (idfornecedor) references fornecedor(id)
);

-- inserir dados nessas tabelas

INSERT INTO Vendedor (Nome) VALUES
('André'),
('Alisson'),
('José'),
('Aliton'),
('Maria'),
('Suelen'),
('Aline'),
('Silvana');

INSERT INTO Fornecedor (Nome) VALUES
	('Cap. Computadores'),
	('AA. Computadores'),
	('BB. Máquinas');

select id from municipio m where nome = 'São Paulo';

INSERT INTO Transportadora (IdMunicipio, Nome, Logradouro, Numero) VALUES
	(3, 'BS. Transportes', 'Rua das Limas', '01'),
	(5, 'União Transportes','São Paulo',  NULL);

delete from transportadora;

INSERT INTO produto (idfornecedor, Nome, Valor) VALUES
	(1, 'Microcomputador', 800),
	(1, 'Monitor', 500),
	(2, 'Placa mãe', 200),
	(2, 'HD', 150),
	(2, 'Placa de vídeo', 200),
	(3, 'Memória RAM', 100),
	(1, 'Gabinete', 35);

-- criacao tabela pedido

create table pedido (
	id bigint generated always as identity not null primary key,
	idcliente bigint not null,
	idtransportadora bigint,
	idvendedor bigint not null,
	data_pedido date not null,
	valor float not null,
	constraint fk_ped_idcliente foreign key (idcliente) references cliente (id),
	constraint fk_ped_idctransportadora foreign key (idtransportadora) references transportadora (id),
	constraint fk_ped_idvendedor foreign key (idvendedor) references vendedor (id)
);

drop table pedido_produto;

create table pedido_produto (
	idpedido bigint not null,
	idproduto bigint not null,
	quantidade int not null,
	valor_unitario float not null,
	constraint pk_ppr_pedidoproduto primary key (idpedido, idproduto), --chave primaria composta
	constraint fk_ppr_idpedido foreign key (idpedido) references pedido (id),
	constraint fk_ppr_idproduto foreign key (idproduto) references produto (id)
);

-- inserir valores nas tabelas pedido e pedido_produto
select id from cliente where nome = 'Geraldo';
select id from Transportadora where nome = 'União Transportes';
select id from Vendedor where nome = 'Aline';

INSERT INTO Pedido (Data_Pedido, Valor, IdCliente, IdTransportadora, IdVendedor) 
VALUES
	('2008-04-01', 1300, 3, 5, 1),
	('2008-04-01', 500, 3, 5, 1),
	('2008-04-02', 300, 13, 6, 5),
	('2008-04-05', 1000, 10, 5, 7),
	('2008-04-06', 200, 11, 6, 6),
	('2008-04-06', 1985, 12, 5, 6),
	('2008-04-06', 800, 5, 5, 7),
	('2008-04-06', 175, 5, 5, 7),
	('2008-04-07', 1300, 14, 5, 8),
	('2008-04-10', 200, 8, 5, 8),
	('2008-04-15', 400, 22, 6, 1),
	('2008-04-20', 500, 22, 6, 5),
	('2008-04-20', 350, 11, 5, 5),
	('2008-04-23', 300, 4, 5, 5),
	('2008-04-25', 200, 13, 5, 5);
 
select * from pedido;

INSERT INTO pedido_produto (IdPedido, IdProduto, Quantidade, Valor_Unitario)
VALUES
  (1, 1, 1, 800),
  (1, 2, 1, 500),
  (2, 2, 1, 500),
  (3, 4, 2, 150),
  (4, 1, 1, 800),
  (4, 3, 1, 200),
  (5, 3, 1, 200),
  (6, 1, 2, 800),
  (6, 7, 1, 35),
  (6, 5, 1, 200),
  (6, 4, 1, 150),
  (7, 1, 1, 800),
  (8, 7, 5, 35),
  (9, 1, 1, 800),
  (9, 2, 1, 500),
  (10, 5, 1, 200),
  (11, 5, 1, 200),
  (11, 6, 1, 100),
  (12, 2, 1, 500),
  (13, 3, 1, 200),
  (13, 4, 1, 150),
  (14, 6, 3, 100),
  (15, 3, 1, 200);
  
-- exercicios consultas
  
--  1. Somente o nome de todos os vendedores em ordem alfabética.
select nome from vendedor order by nome;
--2. Os produtos que o preço seja maior que R$200,00, em ordem crescente pelo preço.
select * from produto where valor > 200 order by valor;
--3. O nome do produto, o preço e o preço reajustado em 10%, ordenado pelo nome do produto.
select nome, valor, valor * 1.1 as "valor reajustado" from produto order by nome;
--4. Os municípios do Rio Grande do Sul.
select * from municipio where iduf = (select id from uf where nome = 'Rio Grande do Sul');
--5. Os pedidos feitos entre 10/04/2008 e 25/04/2008 ordenado pelo valor.
select * from pedido where data_pedido between '2008-04-10' and '2008-04-25';
--6. Os pedidos que o valor esteja entre R$1.000,00 e R$1.500,00.
select * from pedido where valor between 1000 and 1500;
--7. Os pedidos que o valor não esteja entre R$100,00 e R$500,00.
select * from pedido where valor not between 100 and 500 ;
--8. Os pedidos do vendedor André ordenado pelo valor em ordem decrescente.
select * from pedido where idvendedor = (select id from vendedor where nome = 'André') order by valor ;
--9. Os pedidos do cliente Manoel ordenado pelo valor em ordem crescente.
select * from pedido where idcliente = (select id from cliente where nome = 'Manoel') order by valor;
--10. Os pedidos da cliente Jéssica que foram feitos pelo vendedor André.
select * from pedido where idcliente = (select id from cliente where nome like 'J%ssica') and idvendedor = (select id from vendedor where nome = 'André');
--11. Os pedidos que foram transportados pela transportadora União Transportes.
select * from pedido where idtransportadora = (select id from transportadora where nome = 'União Transportes');
--12. Os pedidos feitos pela vendedora Maria ou pela vendedora Aline.
select * from pedido where idvendedor in (select id from vendedor where nome in ('Maria', 'Aline'));
--13. Os clientes que moram em União da Vitória ou Porto União.
select * from cliente where idmunicipio in (select id from municipio where nome in ('União da Vitória', 'Porto União'));
--14. Os clientes que não moram em União da Vitória e nem em Porto União.
select * from cliente where idmunicipio in (select id from municipio where nome not in ('União da Vitória', 'Porto União'));
--15. Os clientes que não informaram o logradouro.
select * from cliente where logradouro is null;
--16. Os clientes que moram em avenidas.
select * from cliente where logradouro like 'Av%';
--17. Os vendedores que o nome começa com a letra S.
select * from vendedor where nome like 'S%';
--18. Os vendedores que o nome termina com a letra A.
select * from vendedor where nome like '%a';
--19. Os vendedores que o nome não começa com a letra A.
select * from vendedor where nome not like 'A%';
--20. Os municípios que começam com a letra P e são de Santa Catarina.
select * from municipio where nome like 'P%' and iduf = (select id from uf where nome ='Santa Catarina');
--21. As transportadoras que informaram o endereço.
select * from transportadora where logradouro is not null;
--22. Os itens do pedido 01.
select idpedido, nome, valor_unitario, quantidade, valor_unitario * quantidade as valor_final
from pedido_produto pp
	inner join produto p on pp.idproduto= p.id 
where idpedido = 1;
--23. Os itens do pedido 06 ou do pedido 10.
select 
	idpedido, 
	nome, 
	'R$ ' || valor_unitario as valor_unitario, 
	quantidade, 
	'R$ ' || valor_unitario * quantidade as valor_final
from 
	pedido_produto pp
		inner join produto p on pp.idproduto = p.id 
where 
	idpedido in (6, 10);
	
--execrcicios funções agregadas
--	1. A média dos valores de vendas dos vendedores que venderam mais que R$ 200,00.
select idvendedor, avg(valor) from pedido group by idvendedor having sum(valor) > 200 ;
--2. Os vendedores que venderam mais que R$ 1500,00.
	select 
		p.idvendedor as id, 
		v.nome, 
		sum(valor) as valortotalvendido 
	from 
		pedido p 
		inner join vendedor v 
			on p.idvendedor = v.id 
	group by 
		p.idvendedor, 
		v.nome 
	having 
		sum(valor) > 1500 ;
--3. O somatório das vendas de cada vendedor
	select idvendedor, sum(valor) from pedido group by idvendedor;
--4. A quantidade de municípios.
	select count(*) from municipio;
--5. A quantidade de municípios que são do Paraná ou de Santa Catarina.
	select count(*) from municipio where iduf in (select id from uf where nome in ('Paraná','Santa Catarina'));
--6. A quantidade de municípios por estado.
	select count(m.id), uf.nome from municipio m inner join uf on m.iduf = uf.id group by m.iduf, uf.nome;
--7. A quantidade de clientes que informaram o logradouro.
	select count(*) from cliente where logradouro is not null;
--8. A quantidade de clientes por município.
	select count(*), m.nome from cliente c inner join municipio m on c.idmunicipio = m.id group by idmunicipio, m.nome;
--9. A quantidade de fornecedores.
	select count(*) from fornecedor;
--10. A quantidade de produtos por fornecedor.
	select count(*) from produto group by idfornecedor;
--11. A média de preços dos produtos do fornecedor Cap. Computadores.
	select avg(valor) from produto where idfornecedor = (select id from fornecedor where nome = 'Cap. Computadores');
--12. O somatório dos preços de todos os produtos.
	select sum(valor) from produto;
--13. O nome do produto e o preço somente do produto mais caro.
	select max(valor), nome from produto group by nome, valor order by valor desc limit 1;
--14. O nome do produto e o preço somente do produto mais barato.
	select min(valor), nome from produto group by nome limit 1;
--15. A média de preço de todos os produtos.
select avg(valor) from produto;
--16. A quantidade de transportadoras.
select count(*) from transportadora;
--17. A média do valor de todos os pedidos.
select avg(valor) from pedido;
--18. O somatório do valor do pedido agrupado por cliente.
select idcliente, sum(valor) from pedido group by idcliente;
--19. O somatório do valor do pedido agrupado por vendedor.
select idvendedor, sum(valor) from pedido group by idvendedor;
--20. O somatório do valor do pedido agrupado por transportadora.
select idtransportadora, sum(valor) from pedido group by idtransportadora;
--21. O somatório do valor do pedido agrupado pela data.
select data_pedido, sum(valor) from pedido group by data_pedido;
--22. O somatório do valor do pedido agrupado por cliente, vendedor e transportadora.
select idcliente, idvendedor, idtransportadora, sum(valor) from pedido group by idcliente, idvendedor, idtransportadora ;
--23. O somatório do valor do pedido que esteja entre 01/04/2008 e 10/12/2009 e que seja maior que R$ 200,00.
select sum(valor) from pedido where valor > 200 and data_pedido between '2008-04-1' and '2009-12-10';
--24. A média do valor do pedido do vendedor André.
select avg(valor) from pedido p inner join vendedor v on p.idvendedor = v.id where p.idvendedor = (select id from vendedor where nome = 'André') ;
--25. A média do valor do pedido da cliente Jéssica.
select avg(valor) from pedido p inner join cliente c on p.idcliente = c.id where p.idcliente = (select id from cliente where nome = 'Jéssica');
--26. A quantidade de pedidos transportados pela transportadora BS. Transportes.
select count(*) from pedido where idtransportadora = (select id from transportadora where nome = 'BS. Transportes');
--27. A quantidade de pedidos agrupados por vendedor.
select count(*), idvendedor from pedido group by idvendedor;
--28. A quantidade de pedidos agrupados por cliente.
select count(*) from pedido group by idcliente;
--29. A quantidade de pedidos entre 15/04/2008 e 25/04/2008.
select count(*) from pedido where data_pedido between '2008-04-15' and '2008-04-25';
--30. A quantidade de pedidos que o valor seja maior que R$ 1.000,00.
select count(*) from pedido where valor > 1000;
--31. A quantidade de microcomputadores vendida.
select sum(quantidade) as quantidade_vendida from pedido_produto pp where idproduto = (select id from produto where nome = 'Microcomputador');
--32. A quantidade de produtos vendida agrupado por produto.
select count(quantidade) from pedido_produto group by idproduto;
--33. O somatório do valor dos produtos dos pedidos, agrupado por pedido.
select sum(valor_unitario) from pedido_produto group by idpedido;
--34. A quantidade de produtos agrupados por pedido.
select count(quantidade) from pedido_produto group by idpedido;
--35. O somatório dos valores unitários de todos os produtos.
select sum(valor) from produto;
--36. A média dos produtos do pedido 6.
select avg(valor_unitario) from pedido_produto where idpedido = 6;
--37. O valor do maior produto do pedido.
select max(valor_unitario) from pedido_produto;
--38. O valor do menor produto do pedido.
select min(valor_unitario) from pedido_produto;
--39. O somatório da quantidade de produtos por pedido.
select sum(quantidade) from pedido_produto group by idpedido;
--40. O somatório da quantidade de todos os produtos do pedido.
select sum(quantidade) from pedido_produto;

-- joins
select c.id, c.nome, p.id, p.nome
from cliente c right join profissao p on c.idprofissao = p.id;

--exercicios join
--1. O nome do cliente, a profissão, a nacionalidade, o logradouro, o número, o complemento, o bairro, o município e a unidade de federação.
select c.nome, p.nome, n.nome, c.logradouro, c.numero, co.nome, b.nome, m.nome, uf.nome
from cliente c
	left join profissao p on c.idprofissao = p.id
	left join nacionalidade n on c.idnacionalidade = n.id
 	left join complemento co on c.idcomplemento = co.id
	left join bairro b on c.idbairro = b.id
	left join municipio m on c.idmunicipio = m.id
	left join uf on m.iduf = uf.id;
--2. O nome do produto, o valor e o nome do fornecedor.
select p.nome, p.valor, f.nome
from produto p
	left join fornecedor f on p.idfornecedor = f.id;
--3. O nome da transportadora e o município.
select t.nome, m.nome
from transportadora t
	left join municipio m on t.idmunicipio = m.id ;
--4. A data do pedido, o valor, o nome do cliente, o nome da transportadora e o nome do vendedor.
select p.data_pedido, p.valor, c.nome, t.nome, v.nome
from pedido p
	left join cliente c on p.idcliente = c.id
	left join transportadora t on p.idtransportadora = t.id
	left join vendedor v on p.idvendedor = v.id;
--5. O nome do produto, a quantidade e o valor unitário dos produtos do pedido.
select prd.nome, pp.quantidade, pp.valor_unitario
from pedido_produto pp
	left join produto prd on pp.idproduto = prd.id;
--6. O nome dos clientes e a data do pedido dos clientes que fizeram algum pedido (ordenado pelo nome do cliente).
select c.nome, p.data_pedido
from cliente c
	inner join pedido p on p.idcliente = c.id
order by c.nome;
--7. O nome dos clientes e a data do pedido de todos os clientes, independente se tenham feito pedido (ordenado pelo nome do cliente).
select c.nome, p.data_pedido
from cliente c
	left join pedido p on c.id = p.idcliente
order by c.nome;
--8. O nome da cidade e a quantidade de clientes que moram naquela cidade.
select m.nome, count(c.id)
from municipio m
	left join cliente c on c.idmunicipio = m.id
group by m.id;
--9. O nome do fornecedor e a quantidade de produtos de cada fornecedor.
select f.nome, count(p.id)
from fornecedor f
	left join produto p on p.idfornecedor = f.id
group by f.id;
--10.O nome do cliente e o somatório do valor do pedido (agrupado por cliente).
select c.nome, sum(p.valor)
from cliente c
	left join pedido p on c.id = p.idcliente
group by c.id;
--11.O nome do vendedor e o somatório do valor do pedido (agrupado por vendedor).
select v.nome, sum(p.valor)
from vendedor v
	left join pedido p on p.idvendedor = v.id
group by v.id;
--12.O nome da transportadora e o somatório do valor do pedido (agrupado por transportadora).
select t.nome, sum(p.valor)
from transportadora t
	left join pedido p on t.id = p.idtransportadora
group by t.id;
--13.O nome do cliente e a quantidade de pedidos de cada um (agrupado por cliente).
select c.nome, count(p.id)
from cliente c
	left join pedido p on c.id = p.idcliente
group by c.id;
--14.O nome do produto e a quantidade vendida (agrupado por produto).
select p.nome, count(pp.idpedido)
from produto p
	left join pedido_produto pp on p.id = pp.idproduto
group by p.id;
--15.A data do pedido e o somatório do valor dos produtos do pedido (agrupado pela data do pedido).
select p.data_pedido, sum(pp.valor_unitario)
from pedido p
	inner join pedido_produto pp on p.id = pp.idpedido
group by p.id;
--16.A data do pedido e a quantidade de produtos do pedido (agrupado pela data do pedido).
select p.data_pedido, count(pp.quantidade)
from pedido p
	inner join pedido_produto pp on p.id = pp.idpedido
group by p.data_Pedido;

-- comandos adicionais
select * from pedido;
select data_pedido, extract(day from data_pedido) from pedido;
select data_pedido, extract(day from data_pedido), extract(month from data_pedido), extract(year from data_pedido) from pedido;

-- exrcicios comandos adicionais

--1. O nome do cliente e somente o mês de nascimento. Caso a data de nascimento não esteja preenchida mostrar a mensagem “Não informado”.
select 
	nome, 
	coalesce(cast(extract(month from data_nascimento) as varchar(2)), 'Não informado') as data_nascimento
from cliente;
--2. O nome do cliente e somente o nome do mês de nascimento (Janeiro, Fevereiro etc). Caso a data de nascimento não esteja preenchida mostrar a mensagem “Não informado”.
select 
	nome,
	case extract(month from data_nascimento)
		when 1 then 'Janeiro'
		when 2 then 'Fevereiro'
		when 3 then 'Março'
		when 4 then 'Abril'
		when 5 then 'Maio'
		when 6 then 'Junho'
		when 7 then 'Julho'
		when 8 then 'Agosto'
		when 9 then 'Setembro'
		when 10 then 'Outubro'
		when 11 then 'Novembro'
		when 12 then 'Dezembro'
		else 'Não informado'
	end as mes_nascimento
from cliente;
--3. O nome do cliente e somente o ano de nascimento. Caso a data de nascimento não esteja preenchida mostrar a mensagem “Não informado”.
select 
	nome, 
	coalesce(cast(extract(year from data_nascimento) as varchar(4)), 'Não informado') as data_nascimento
from cliente;
--4. O caractere 5 até o caractere 10 de todos os municípios.
select substring(nome, 5, 10) from municipio;
--5. O nome de todos os municípios em letras maiúsculas.
select upper(nome) from municipio;
--6. O nome do cliente e o gênero. Caso seja M mostrar “Masculino”, senão mostrar “Feminino”.
select 
	nome, 
	case genero
		when 'M' then 'Masculino'
		else 'Feminino'
	end as genero
from cliente;
--7. O nome do produto e o valor. Caso o valor seja maior do que R$ 500,00 mostrar a mensagem “Acima de 500”, caso contrário, mostrar a mensagem “Abaixo de 500”.
select 
	nome,
	case
		when valor > 500 then 'Acima de 500'
		else 'Abaixo de 500'
	end as valor
from produto;

--exercicios subconsultas
--1. O nome dos clientes que moram na mesma cidade do Manoel. Não deve ser mostrado o Manoel.
select nome 
from cliente 
where id != (
		select id 
		from cliente 
		where nome = 'Manoel'
	);
--2. A data e o valor dos pedidos que o valor do pedido seja menor que a média de todos os pedidos.
select data_pedido, valor 
from pedido 
where valor < (
		select avg(valor) 
		from pedido
	);
--3. A data,o valor, o cliente e o vendedor dos pedidos que possuem 2 ou mais produtos.
select 
	p.data_pedido, 
	p.valor, 
	c.nome, 
	v.nome 
from
	pedido p 
		inner join cliente c on p.idcliente = c.id
		inner join vendedor v on p.idvendedor = v.id
where 
	(
		select count(idpedido) * sum(quantidade)
		from pedido_produto 
	) >= 2;
--4. O nome dos clientes que moram na mesma cidade da transportadora BSTransportes.
select nome
from cliente 
where idmunicipio = (
	select idmunicipio 
	from transportadora 
	where nome = 'BSTransportes'
);
--5. O nome do cliente e o município dos clientes que estão localizados no mesmo município de qualquer uma das transportadoras.
select c.nome, m.nome 
from cliente c 
	inner join municipio m on c.idmunicipio = m.id
where c.idmunicipio in (
		select idmunicipio from transportadora
	);
--6. Atualizar o valor do pedido em 5% para os pedidos que o somatório do valor total dos produtos daquele pedido seja maior que a média do valor total de todos os produtos de todos os pedidos.
update pedido
set valor = valor * 1.05
where valor > (select avg(valor) from pedido);

select * 
from pedido
where valor > (select avg(valor) from pedido);
--7. O nome do cliente e a quantidade de pedidos feitos pelo cliente.
select c.nome, (select count(*) from pedido where idcliente = c.id)
from cliente c;
--8. Para revisar, refaça o exercício anterior (número 07) utilizando group by e mostrando somente os clientes que fizeram pelo menos um pedido.
select c.nome, count(p.idcliente)
from cliente c 
	inner join pedido p on c.id = p.idcliente
group by c.nome;

--VIEWS

create view cliente_profissao as
select 
	c.nome as cliente,
	p.nome as profissao
from 
	cliente c
		inner join profissao p on c.idprofissao = p.id;

select * from cliente_profissao where profissao = 'Professor';

--exercicios views

--1. O nome, a profissão, a nacionalidade, o complemento, o município, a unidade de federação, o bairro, o CPF,o RG, a data de nascimento, o gênero (mostrar “Masculino” ou “Feminino”), o logradouro, o número e as observações dos clientes.
create view cliente_dados as
select 
	c.nome as cliente, 
	p.nome as profissao,
	n.nome as nacionalidade,
	co.nome as complemento,
	m.nome as municipio,
	uf.nome as uf,
	b.nome as bairro,
	c.cpf,
	c.rg,
	c.data_nascimento,
	case c.genero
		when 'M' then 'Masculino'
		else 'Feminino'
	end as genero,
	c.logradouro,
	c.numero,
	c.observacoes
from 
	cliente c 
		left join profissao p on c.idprofissao = p.id
		left join nacionalidade n on c.idnacionalidade = n.id
		left join complemento co on co.id = c.idcomplemento 
		left join municipio m on m.id = c.idmunicipio 
		left join uf on uf.id = m.iduf
		left join bairro b on b.id = c.idbairro;
		
select * from cliente_dados;
--2. O nome do município e o nome e a sigla da unidade da federação.
create view municipio_dados as
select 
	m.nome as municipio,
	uf.nome as uf,
	uf.sigla 
from 
	municipio m
		left join uf on uf.id = m.iduf;
		
select * from municipio_dados;
--3. O nome do produto, o valor e o nome do fornecedor dos produtos.
create view produto_dados as 
select
	p.nome as produto,
	p.valor,
	f.nome as fornecedor
from produto p
	left join fornecedor f on f.id = p.idfornecedor;

select * from produto_dados;
--4. O nome da transportadora, o logradouro, o número, o nome da unidade de federação e a sigla da unidade de federação das transportadoras.
create view transportadora_dados as
select 
	t.nome as transportadora,
	t.logradouro,
	t.numero,
	uf.nome as uf,
	uf.sigla
from 
	transportadora t
		left join municipio m on m.id = t.idmunicipio
		left join uf on uf.id = m.iduf;

select * from transportadora_dados;
--5. A data do pedido, o valor, o nome da transportadora, o nome do cliente e o nome do vendedor dos pedidos.
create view pedido_dados as
select
	p.data_pedido,
	p.valor,
	t.nome as transportadora,
	c.nome as cliente,
	v.nome as vendedor
from 
	pedido p
		left join transportadora t on t.id = p.idtransportadora
		left join cliente c on c.id = p.idcliente
		left join vendedor v on v.id = p.idvendedor;

select * from pedido_dados;
--6. O nome do produto, a quantidade, o valor unitário e o valor total dos produtos do pedido.
create view pedido_produto_dados as
select
	prd.nome as produto,
	pp.quantidade,
	pp.valor_unitario,
	pdd.valor
from 
	pedido_produto pp
		left join produto prd on prd.id = pp.idproduto
		left join pedido pdd on pdd.id = pp.idpedido;
		
select * from pedido_produto_dados;

-- autoincremento

create table exemplo (
	id serial primary key,
	nome varchar(50) not null
);

SELECT * FROM exemplo
