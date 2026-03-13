CREATE DATABASE escola;
USE escola;

CREATE TABLE alunos(
	id_aluno INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    email VARCHAR(100)
);

CREATE TABLE cursos(
	id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE matriculas(
	id_matricula INT PRIMARY KEY,
    id_aluno INT,
    id_curso INT,
    data_matricula DATE,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_aluno) REFERENCES cursos(id_curso)
);

ALTER TABLE alunos ADD telefone VARCHAR(20);
ALTER TABLE cursos MODIFY COLUMN carga_horaria SMALLINT;

DROP TABLE matriculas;

INSERT INTO alunos (id_aluno, nome, data_nascimento, email,telefone)
VALUES
(1, 'Ana Souza', '2000-05-10', 'ana@email.com', '11999990000'),
(2, 'Carlos Lima', '1999-11-22', 'carlos@email.com', '11988887777');

INSERT INTO cursos (id_curso, nome_curso, carga_horaria)
VALUES
(101, 'Lógica de Progração', 60),
(102, 'Banco de Dados', 80);

CREATE TABLE matriculas(
	id_matricula INT PRIMARY KEY,
    id_aluno INT,
    id_curso INT,
    data_matricula DATE,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

INSERT INTO matriculas (id_matricula, id_aluno, id_curso, data_matricula)
VALUES
(1001, 1, 101, '2024-03-10'),
(1002, 2, 102, '2024-03-12');

UPDATE alunos SET telefone = '11911112222' WHERE id_aluno = 1;

DELETE FROM cursos WHERE nome_curso = 'Lógica de Programação';