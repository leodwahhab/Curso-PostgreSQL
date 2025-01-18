--funções: tem retorno
CREATE FUNCTION formatarMoeda(valor FLOAT)
    RETURNS varchar(20)
    LANGUAGE plpgsql AS
$$
    BEGIN
        RETURN CONCAT('R$', ROUND(CAST(valor AS NUMERIC), 2));
    END;
$$;

SELECT
    valor,
    formatarMoeda(valor)
FROM
    pedido;

SELECT
    valor,
    formatarMoeda(valor)
FROM
    produto;


CREATE FUNCTION getCliente(idc BIGINT)
    RETURNS varchar(50)
    LANGUAGE plpgsql AS
$$
    DECLARE r VARCHAR(50);
    BEGIN
        SELECT
            nome INTO r
        FROM
            cliente
        WHERE
            id = idc;
        RETURN r;
    END;
$$;

SELECT
    data_pedido,
    valor,
    id,
    getCliente(id)
FROM
    pedido;

-- Exercícios funções
-- 1. Crie uma função que receba como parâmetro o ID do pedido e retorne o valor total deste pedido
CREATE FUNCTION valorTotalPedido(idp BIGINT)
    RETURNS NUMERIC
    LANGUAGE plpgsql AS
$$
    DECLARE valorP NUMERIC;
    BEGIN
        SELECT
            valor INTO valorP
        FROM
            pedido
        WHERE
            idp = id;
        RETURN valorP;
    END;
$$;
-- 2. Crie uma função chamada “maior”, que quando executada retorne o pedido com o maior valor
CREATE FUNCTION maior()
    RETURNS BIGINT
    LANGUAGE plpgsql AS
$$
    DECLARE idMaiorPedido BIGINT;
    BEGIN
        SELECT
            id INTO idmaiorpedido
        FROM
            pedido
        ORDER BY
            valor DESC
        LIMIT 1;
        RETURN idmaiorpedido;
    END;
$$;

--procedures: não tem retorno
CREATE PROCEDURE inserirBairro(nomeBairro VARCHAR(30))
    LANGUAGE sql AS
$$
    INSERT INTO bairro(nome)
    VALUES(nomebairro);
$$;

CALL inserirBairro('Lapa');
SELECT * FROM bairro ORDER BY id DESC;

-- Exercícios procedures
-- 1. Crie uma stored procedure que receba como parâmetro o ID do produto e o percentual de aumento, e reajuste o preço somente deste produto de acordo com o valor passado como parâmetro
CREATE PROCEDURE aumentarValorProduto(idp BIGINT, percentualAumento INTEGER)
    LANGUAGE sql AS
$$
    UPDATE produto
    SET valor = valor + (valor * percentualaumento / 100)
    WHERE id = idp;
$$;

CALL aumentarValorProduto(1, 10);
SELECT * from produto WHERE id =  1;

-- 2. Crie uma stored procedure que receba como parâmetro o ID do produto e exclua da base de dados somente o produto com o ID correspondente
CREATE PROCEDURE excluirProduto(idp BIGINT)
    LANGUAGE sql AS
$$
   DELETE FROM produto WHERE id = idp;
$$;

CALL excluirProduto(10);
SELECT * FROM produto ORDER BY id ASC;

--triggers: são executadas automaticamente

CREATE TABLE bairro_auditoria (
    idbairro BIGINT NOT NULL,
    data_criacao TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION bairroLog()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
--         old 4 -> new 6
        INSERT INTO bairro_auditoria(idbairro, data_criacao)
        VALUES (new.id, CURRENT_TIMESTAMP);
        RETURN new;
    END;
$$;

CREATE OR REPLACE TRIGGER log_bairro_trigger
    AFTER INSERT ON bairro FOR EACH ROW
    EXECUTE PROCEDURE bairroLog();

CALL inserirBairro('Perdizes');
CALL inserirBairro('Leblon');
CALL inserirBairro('Jardins');
SELECT idbairro, bairro_auditoria.data_criacao, nome FROM bairro_auditoria INNER JOIN bairro ON bairro.id = bairro_auditoria.idbairro;

-- Exercícios triggers
-- 1. Crie uma tabela chamada PEDIDOS_APAGADOS
select * from pedido;
CREATE TABLE IF NOT EXISTS pedidos_apagados (
    id BIGINT NOT NULL,
    idcliente BIGINT NOT NULL,
    idtransportadora BIGINT,
    idvendedor BIGINT,
    data_pedido TIMESTAMP,
    valor NUMERIC
);
-- 2. Faça uma trigger que quando um pedido for apagado, todos os seus dados devem ser copiados para a tabela PEDIDOS_APAGADOS
CREATE OR REPLACE FUNCTION moverDadosPedidoApagado()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
$$
    BEGIN
        INSERT INTO pedidos_apagados
        VALUES (old.id, old.idcliente, old.idtransportadora, old.idvendedor, old.data_pedido, old.valor);
        RETURN old;
    END;
$$;

CREATE OR REPLACE TRIGGER log_pedido_trigger
    BEFORE DELETE ON pedido FOR EACH ROW
    EXECUTE PROCEDURE moverDadosPedidoApagado();

DELETE FROM pedido WHERE id = 16;

SELECT * FROM pedidos_apagados;

-- domínios
-- ids
CREATE DOMAIN idcurto AS SMALLINT;
CREATE DOMAIN idmedio AS INTEGER;
CREATE DOMAIN idlongo AS BIGINT;

--caracteres
CREATE DOMAIN sigla AS varchar(3);
CREATE DOMAIN codigo AS VARCHAR(10);
CREATE DOMAIN nome_curto AS VARCHAR(15);
CREATE DOMAIN nome_medio AS VARCHAR(30);
CREATE DOMAIN nome_longo AS VARCHAR(50);

--data
CREATE DOMAIN data AS DATE;
CREATE DOMAIN hora AS TIME;
CREATE DOMAIN data_hora AS TIMESTAMP;

--numericos
CREATE DOMAIN moeda AS NUMERIC(10, 2);
CREATE DOMAIN float_curto AS NUMERIC(6,2);
CREATE DOMAIN float_medio AS NUMERIC(10,2);
CREATE DOMAIN float_longo AS NUMERIC(15,2);

-- O objetivo deste exercício é alterar os tipos de dados dos atributos de todas as tabelas,
-- considerando os domínios criados anteriormente. Caso julgue necessário, faça a criação de novos domínios
DROP VIEW IF EXISTS cliente_dados;
DROP VIEW IF EXISTS cliente_profissao;
DROP VIEW IF EXISTS municipio_dados;
DROP VIEW IF EXISTS pedido_dados;
DROP VIEW IF EXISTS pedido_produto_dados;
DROP VIEW IF EXISTS produto_dados;
DROP VIEW IF EXISTS transportadora_dados;

ALTER TABLE cliente
ALTER COLUMN nome
TYPE nome_longo;

ALTER TABLE fornecedor
ALTER COLUMN nome
TYPE nome_longo;

ALTER TABLE municipio
ALTER COLUMN nome
TYPE nome_longo;

ALTER TABLE nacionalidade
ALTER COLUMN nome
TYPE nome_longo;

ALTER TABLE produto
ALTER COLUMN nome
TYPE nome_longo;

ALTER TABLE profissao
ALTER COLUMN nome
TYPE nome_longo;

ALTER TABLE vendedor
ALTER COLUMN nome
TYPE nome_longo;

--roles
CREATE ROLE gerente;
CREATE ROLE estagiario;

GRANT SELECT, INSERT, UPDATE,  DELETE --GRANT concede permissoes a uma role
    ON bairro, cliente, complemento, fornecedor, vendedor, municipio, transportadora, nacionalidade, profissao
    TO gerente;
GRANT ALL
    ON ALL SEQUENCES IN
    SCHEMA public
    TO gerente;
REVOKE SELECT ON bairro FROM gerente; --REMOVE PERMISSOES

GRANT SELECT
    ON cliente_dados, pedido_produto_dados
    TO estagiario;

CREATE ROLE leo LOGIN PASSWORD 'postgres' IN ROLE gerente;
CREATE ROLE gabriel LOGIN PASSWORD 'postgres' IN ROLE estagiario;

-- Exercícios usuários e permissões
-- 1. Crie um novo papel chamado “atendente”
CREATE ROLE atendente;
-- 2. Defina somente permissões para o novo papel poder selecionar e incluir novos pedidos (tabelas pedido e pedido_produto). O restante do acesso deve estar bloqueado
GRANT SELECT, INSERT
    ON pedido, pedido_produto
    TO atendente;
-- 3. Crie um novo usuário associado ao novo papel
CREATE ROLE leoA LOGIN PASSWORD 'postgres' IN ROLE atendente;
-- 4. Realize testes para verificar se as permissões foram aplicadas corretamente
SELECT * FROM pedido;
SELECT * FROM bairro;

-- transacoes
CREATE TABLE IF NOT EXISTS conta (
    id BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente nome_medio NOT NULL,
    saldo moeda NOT NULL DEFAULT 0
);

INSERT INTO  conta (cliente, saldo)
VALUES ('Cliente 1', 1000), ('Cliente 2', 500);

SELECT * FROM conta;

UPDATE conta
SET saldo = saldo - 100
WHERE id = 1;

UPDATE conta
SET saldo = saldo + 100
WHERE id = 2;

SELECT * FROM conta;
BEGIN;
    UPDATE conta
    SET saldo = saldo - 100
    WHERE id = 1;

    UPDATE conta
    SET saldo = saldo + 100
    WHERE id = 2;
ROLLBACK;

SELECT * FROM conta;
BEGIN;
    UPDATE conta
    SET saldo = saldo - 100
    WHERE id = 1;

    UPDATE conta
    SET saldo = saldo + 100
    WHERE id = 2;
COMMIT;