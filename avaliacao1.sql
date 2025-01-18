-- ---------- AVALIAÇÃO PRÁTICA ---------------------

CREATE DATABASE biblioteca;

CREATE TABLE IF NOT EXISTS editora (
    id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nome VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO editora (nome)
VALUES ('Bookman'), ('Edgard Blusher'), ('Nova Terra'), ('Brasport');

CREATE TABLE IF NOT EXISTS categoria (
    id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nome VARCHAR(255)
);

ALTER TABLE categoria
ALTER COLUMN nome
SET NOT NULL;

ALTER TABLE categoria
ADD CONSTRAINT cat_nome_unique UNIQUE (nome);

INSERT INTO categoria (nome)
VALUES ('Banco de Dados'), ('HTML'), ('Java'), ('PHP');

CREATE TABLE IF NOT EXISTS autor (
    id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nome VARCHAR(255) NOT NULL UNIQUE
);

INSERT INTO autor (nome)
VALUES ('Waldemar Setzer'), ('Flávio Soares'), ('John Watson'), ('Rui Rossi dos Santos'), ('Antonio Pereira de Resende'), ('Claudiney Calixto Lima'), ('Evandro Carlos Teruel'), ('Ian Graham'), ('Fabrício Xavier'), ('Pablo Dalloglio');

CREATE TABLE IF NOT EXISTS livro (
    id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_editora INT NOT NULL,
    id_categoria INT NOT NULL,
    nome VARCHAR(255) NOT NULL UNIQUE,
    CONSTRAINT fk_lvr_ideditora FOREIGN KEY (id_editora) REFERENCES editora (id),
    CONSTRAINT fk_lvr_idcategoria FOREIGN KEY (id_categoria) REFERENCES categoria (id)
);

INSERT INTO livro (id_editora, id_categoria, nome)
VALUES
    (
     (SELECT id FROM editora WHERE nome = 'Edgard Blusher'), (SELECT id FROM categoria WHERE nome = 'Banco de Dados'), 'Banco de Dados – 1 Edição'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Bookman'), (SELECT id FROM categoria WHERE nome = 'Banco de Dados'), 'Oracle DataBase 11G Administração'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Nova Terra'), (SELECT id FROM categoria WHERE nome = 'Java'), 'Programação de Computadores em Java'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Brasport'), (SELECT id FROM categoria WHERE nome = 'Java'), 'Programação Orientada a Aspectos em Java'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Nova Terra'), (SELECT id FROM categoria WHERE nome = 'HTML'), 'HTML5 – Guia Prático'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Nova Terra'), (SELECT id FROM categoria WHERE nome = 'HTML'), 'XHTML: Guia de Referência para Desenvolvimento na Web'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Bookman'), (SELECT id FROM categoria WHERE nome = 'PHP'), 'PHP para Desenvolvimento Profissional'
    ),
    (
     (SELECT id FROM editora WHERE nome = 'Edgard Blusher'), (SELECT id FROM categoria WHERE nome = 'PHP'), 'PHP com Programação Orientada a Objetos'
    );

SELECT * FROM livro;

CREATE TABLE IF NOT EXISTS livro_autor (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    CONSTRAINT pk_lat_idlivroidautor PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT fk_lat_idlivro FOREIGN KEY (id_livro) REFERENCES livro (id),
    CONSTRAINT fk_lat_idautor FOREIGN KEY (id_autor) REFERENCES autor (id)
);

INSERT INTO livro_autor
VALUES
    (
        (SELECT id FROM livro WHERE nome = 'Banco de Dados – 1 Edição'), (SELECT id FROM autor WHERE nome = 'Waldemar Setzer')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'Banco de Dados – 1 Edição'), (SELECT id FROM autor WHERE nome = 'Flávio Soares')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'Oracle DataBase 11G Administração'), (SELECT id FROM autor WHERE nome = 'John Watson')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'Programação de Computadores em Java'), (SELECT id FROM autor WHERE nome = 'Rui Rossi dos Santos')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'Programação Orientada a Aspectos em Java'), (SELECT id FROM autor WHERE nome = 'Antonio Pereira de Resende')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'Programação Orientada a Aspectos em Java'), (SELECT id FROM autor WHERE nome = 'Claudiney Calixto Lima')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'HTML5 – Guia Prático'), (SELECT id FROM autor WHERE nome = 'Evandro Carlos Teruel')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'XHTML: Guia de Referência para Desenvolvimento na Web'), (SELECT id FROM autor WHERE nome = 'Ian Graham')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'PHP para Desenvolvimento Profissional'), (SELECT id FROM autor WHERE nome = 'Fabrício Xavier')
       ),
    (
        (SELECT id FROM livro WHERE nome = 'PHP com Programação Orientada a Objetos'), (SELECT id FROM autor WHERE nome = 'Pablo Dalloglio')
       );

CREATE TABLE IF NOT EXISTS aluno (
    id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nome VARCHAR(255) NOT NULL
);

INSERT INTO aluno (nome)
VALUES
    ('Mario'), ('João'), ('Paulo'), ('Pedro'), ('Maria');

CREATE TABLE IF NOT EXISTS emprestimo (
    id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_aluno INT NOT NULL,
    data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    data_devolucao DATE NOT NULL,
    valor FLOAT NOT NULL,
    devolvido VARCHAR(1),
    CONSTRAINT fk_emp_idaluno FOREIGN KEY (id_aluno) REFERENCES aluno (id)
);

INSERT INTO emprestimo (id_aluno, data_emprestimo, data_devolucao, valor, devolvido)
VALUES ((SELECT id FROM aluno WHERE nome = 'Mario'), '2012-05-02', '2012-05-12', 10,'S'),
       ((SELECT id FROM aluno WHERE nome = 'Mario'), '2012-04-23', '2012-05-03', 5,'N'),
       ((SELECT id FROM aluno WHERE nome = 'João'), '2012-05-10', '2012-05-20', 12,'N'),
       ((SELECT id FROM aluno WHERE nome = 'Paulo'), '2012-05-10', '2012-05-20', 8,'S'),
       ((SELECT id FROM aluno WHERE nome = 'Pedro'), '2012-05-05', '2012-05-15', 15,'N'),
       ((SELECT id FROM aluno WHERE nome = 'Pedro'), '2012-05-07', '2012-05-17', 20,'S'),
       ((SELECT id FROM aluno WHERE nome = 'Pedro'), '2012-05-08', '2012-05-18', 5,'S');

CREATE TABLE IF NOT EXISTS emprestimo_livro (
    id_emprestimo INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT pk_elv_idemprestimoidlivro PRIMARY KEY (id_emprestimo, id_livro),
    CONSTRAINT fk_elv_idemprestimo FOREIGN KEY (id_emprestimo) REFERENCES emprestimo (id),
    CONSTRAINT fk_elv_idlivro FOREIGN KEY (id_livro) REFERENCES livro (id)
);

INSERT INTO emprestimo_livro (id_emprestimo, id_livro)
VALUES (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                -- row_number() retorna o numero da linha numa partição contando a partir de 1
                -- OVER() determina como as linhas da consulta serão separadas para o processamento da window function (nesse caso, row_number())
                -- PARTITION BY dentro do OVER() divide as linhas em grupos (ou partições) que compartilham os mesmos valores das expressões do PARTITION BY
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Mario')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 1
        ), (SELECT id FROM livro WHERE nome = 'Banco de Dados – 1 Edição')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Mario')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 2
        ), (SELECT id FROM livro WHERE nome = 'Programação Orientada a Aspectos em Java')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Mario')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 2
        ), (SELECT id FROM livro WHERE nome = 'Programação de Computadores em Java')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'João')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 1
        ), (SELECT id FROM livro WHERE nome = 'Oracle DataBase 11G Administração')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'João')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 1
        ), (SELECT id FROM livro WHERE nome = 'PHP para Desenvolvimento Profissional')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Paulo')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 1
        ), (SELECT id FROM livro WHERE nome = 'HTML5 – Guia Prático')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Pedro')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 1
        ), (SELECT id FROM livro WHERE nome = 'Programação Orientada a Aspectos em Java')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Pedro')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 2
        ), (SELECT id FROM livro WHERE nome = 'XHTML: Guia de Referência para Desenvolvimento na Web')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Pedro')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 2
        ), (SELECT id FROM livro WHERE nome = 'Banco de Dados – 1 Edição')
       ),
    (
        (
            SELECT ordemEmprestimoAluno.id
            FROM (
                SELECT id, row_number() OVER (PARTITION BY id_aluno) as ordemEmprestimo
                FROM emprestimo
                WHERE id_aluno = (SELECT id FROM aluno WHERE nome = 'Pedro')
            ) ordemEmprestimoAluno
            WHERE ordemEmprestimoAluno.ordemEmprestimo = 3
        ), (SELECT id FROM livro WHERE nome = 'PHP com Programação Orientada a Objetos')
       );

CREATE INDEX idx_emp_dataemprestimo ON emprestimo (data_emprestimo);
CREATE INDEX idx_emp_datadevolucao ON emprestimo (data_devolucao);

-- CONSULTAS SIMPLES
SELECT nome
FROM autor
ORDER BY nome;

SELECT nome
FROM aluno
WHERE nome LIKE 'P%';

select nome
FROM livro
WHERE id_categoria in
      (SELECT id FROM categoria WHERE nome IN ('Banco de Dados', 'Java'));

SELECT nome
FROM livro
WHERE id_editora = (SELECT id FROM editora WHERE nome = 'Bookman');

SELECT *
FROM emprestimo
WHERE data_emprestimo BETWEEN '2012-05-05' AND '2012-05-10';

SELECT *
FROM emprestimo
WHERE data_emprestimo NOT BETWEEN '2012-05-05' AND '2012-05-10';

SELECT *
FROM emprestimo
WHERE devolvido = 'S';

-- CONSULTAS COM AGRUPAMENTO SIMPLES
SELECT COUNT(*)
FROM livro;

SELECT SUM(valor)
FROM emprestimo;

SELECT AVG(valor)
FROM emprestimo;

SELECT MIN(valor)
FROM emprestimo;

SELECT MAX(valor)
FROM emprestimo;

SELECT SUM(valor)
FROM emprestimo
WHERE data_emprestimo BETWEEN '2012-05-05' AND '2012-05-10';

SELECT count(*)
FROM emprestimo
WHERE data_emprestimo BETWEEN '2012-05-01' AND '2012-05-05';

-- CONSULTAS COM JOIN
CREATE VIEW livro_view AS
SELECT
    l.nome AS livro,
    c.nome AS categoria,
    e.nome AS editora
FROM
    livro l
        LEFT JOIN categoria c ON c.id = l.id_categoria
        LEFT JOIN editora e ON e.id = l.id_editora;

SELECT * FROM livro_view;

CREATE VIEW lvr_atr AS
SELECT
    l.nome AS livro,
    a.nome AS autor
FROM
    livro_autor la
        LEFT JOIN livro l ON l.id = la.id_livro
        LEFT OUTER JOIN autor a ON a.id = la.id_autor;

SELECT * FROM lvr_atr;

SELECT
    l.nome
FROM
    livro_autor la
        LEFT JOIN livro l ON l.id = la.id_livro
WHERE
    la.id_autor = (SELECT id FROM autor WHERE nome = 'Ian Graham');

SELECT
    a.nome,
    e.data_emprestimo,
    e.data_devolucao
FROM
    emprestimo e
        LEFT JOIN aluno a ON a.id = e.id_aluno;

SELECT
    l.nome
FROM
    livro l
        INNER JOIN emprestimo_livro el ON l.id = el.id_livro;

-- CONSULTAS COM AGRUPAMENTO + JOIN
SELECT
    e.nome,
    COUNT(l.id) AS qtdLivros
FROM
    livro l
        LEFT JOIN editora e ON e.id = l.id_editora
GROUP BY e.nome;

SELECT
    c.nome,
    COUNT(l.id) AS qtdLivros
FROM
    livro l
        LEFT JOIN categoria c ON c.id = l.id_categoria
GROUP BY c.nome;

SELECT
    a.nome,
    COUNT(la.id_livro) AS qtdLivros
FROM autor a
LEFT JOIN livro_autor la ON a.id = la.id_autor
GROUP BY a.nome;

SELECT
    a.nome,
    COUNT(el.id_livro) AS qtdEmprestimos
FROM
    aluno a
LEFT JOIN
    emprestimo e ON a.id = e.id_aluno
LEFT JOIN
    emprestimo_livro el ON e.id = el.id_emprestimo
GROUP BY a.nome;

SELECT
    a.nome,
    SUM(e.valor) AS valorTotalEmprestimos
FROM
    aluno a
LEFT JOIN
    emprestimo e ON a.id = e.id_aluno
GROUP BY a.nome;

SELECT
    a.nome,
    SUM(e.valor) AS valorTotalEmprestimos
FROM
    aluno a
LEFT JOIN
    emprestimo e ON a.id = e.id_aluno
GROUP BY
    a.nome
HAVING
    SUM(e.valor) > 7;

SELECT UPPER(nome)
FROM aluno
ORDER BY nome;

SELECT *
FROM emprestimo
WHERE EXTRACT(month FROM data_emprestimo) = '04' AND EXTRACT(year FROM data_emprestimo) = '2012';

SELECT
    id,
    id_aluno,
    data_emprestimo,
    data_devolucao,
    valor,
    CASE devolvido
        WHEN 'S' THEN 'Devolução Completa'
        ELSE 'Em atraso'
    END AS situacao
FROM emprestimo;

SELECT SUBSTRING(nome, 5, 10)
FROM autor;

SELECT
    valor,
    CASE EXTRACT(month FROM data_emprestimo)
        WHEN '01' THEN 'Janeiro'
        WHEN '02' THEN 'Fevereiro'
        WHEN '03' THEN 'Março'
        WHEN '04' THEN 'Abril'
        WHEN '05' THEN 'Maio'
        WHEN '06' THEN 'Junho'
        WHEN '07' THEN 'Julho'
        WHEN '08' THEN 'Agosto'
        WHEN '09' THEN 'Setembro'
        WHEN '10' THEN 'Outubro'
    END AS mes_emprestimo
FROM emprestimo;

SELECT
    data_emprestimo,
    valor
FROM emprestimo
WHERE
    valor > (
        SELECT AVG(valor)
        FROM emprestimo
    );

SELECT
    data_emprestimo,
    valor
FROM
    emprestimo
WHERE id in (
      SELECT
          id_emprestimo
      FROM
          emprestimo_livro
      GROUP BY
          id_emprestimo
      HAVING
          COUNT(id_emprestimo) > 1
    );

SELECT
    data_emprestimo,
    valor
FROM
    emprestimo
WHERE
    valor < (
        SELECT AVG(valor) FROM emprestimo
    );

DROP TABLE IF EXISTS editora CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS autor CASCADE;
DROP TABLE IF EXISTS livro CASCADE;
DROP TABLE IF EXISTS livro_autor CASCADE;
DROP TABLE IF EXISTS aluno CASCADE;
DROP TABLE IF EXISTS emprestimo CASCADE;
DROP TABLE IF EXISTS emprestimo_livro CASCADE;