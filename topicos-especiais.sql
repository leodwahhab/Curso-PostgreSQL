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