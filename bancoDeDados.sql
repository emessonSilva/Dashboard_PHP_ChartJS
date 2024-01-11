-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS studio_yoga;
USE studio_yoga;

-- Criação da tabela de Alunos
CREATE TABLE Alunos (
    idAluno INT AUTO_INCREMENT PRIMARY KEY,
    CPF VARCHAR(14) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    dataCadastro DATE
);

-- Criação da tabela de Pagamentos
CREATE TABLE Pagamentos (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT,
    valor DECIMAL(10,2) NOT NULL,
    dataPagamento DATE,
    FOREIGN KEY (idAluno) REFERENCES Alunos(idAluno)
);

-- Criação da tabela de Presenças
CREATE TABLE Presencas (
    idPresenca INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT,
    dataPresenca DATE,
    presente BOOLEAN,
    FOREIGN KEY (idAluno) REFERENCES Alunos(idAluno)
);

-- Criação da tabela de Produtos
CREATE TABLE Produtos (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2) NOT NULL
);

-- Criação da tabela de Vendas
CREATE TABLE Vendas (
    idVenda INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT,
    idProduto INT,
    quantidade INT,
    valorTotal DECIMAL(10,2),
    dataVenda DATE,
    FOREIGN KEY (idAluno) REFERENCES Alunos(idAluno),
    FOREIGN KEY (idProduto) REFERENCES Produtos(idProduto)
);

-- Criação da tabela de feedback das aulas
CREATE TABLE FeedbackAlunos (
    idFeedback INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT,
    idPresenca INT,
    avaliacao INT CHECK(avaliacao >= 1 AND avaliacao <= 10), -- Limita a avaliação entre 1 e 10
    tipoAvaliacao ENUM('ruim', 'bom', 'ótimo') NOT NULL, -- Limita esses 3 conceitos
    dataFeedback DATE,
    FOREIGN KEY (idAluno) REFERENCES Alunos(idAluno),
    FOREIGN KEY (idPresenca) REFERENCES Presencas(idPresenca)
);



-- Inserção de dados para Alunos
INSERT INTO Alunos (CPF, nome, email, dataCadastro)
VALUES
    ('111.111.111-11', 'Maria Silva', 'maria@email.com', '2023-01-02'),
    ('222.222.222-22', 'João Santos', 'joao@email.com', '2023-01-05'),
    ('333.333.333-33', 'Ana Oliveira', 'ana@email.com', '2023-01-10'),
    ('444.444.444-44', 'Pedro Souza', 'pedro@email.com', '2023-01-15'),
    ('555.555.555-55', 'Camila Lima', 'camila@email.com', '2023-01-20'),
    ('666.666.666-66', 'Lucas Pereira', 'lucas@email.com', '2023-01-25'),
    ('777.777.777-77', 'Mariana Costa', 'mariana@email.com', '2023-01-28'),
    ('888.888.888-88', 'Gabriel Oliveira', 'gabriel@email.com', '2023-01-30'),
    ('999.999.999-99', 'Isabela Santos', 'isabela@email.com', '2023-01-21'),
    ('123.456.789-00', 'Rafael Lima', 'rafael@email.com', '2023-01-22');

 -- Inserção de dados para Pagamentos (por mês) 
INSERT INTO Pagamentos (idAluno, valor, dataPagamento)
VALUES
  -- Pagamentos de Fevereiro
    (1, 50.00, '2023-02-05'),
    (2, 50.00, '2023-02-10'),
    (3, 50.00, '2023-02-15'),
    (4, 50.00, '2023-02-20'),
    (5, 50.00, '2023-02-25'),
    (6, 50.00, '2023-02-28'),
    (7, 50.00, '2023-02-28'),
    (8, 50.00, '2023-02-22'),
    (9, 50.00, '2023-02-20'),
    (10, 50.00, '2023-02-28'),

    -- Pagamentos de Março
    (1, 50.00, '2023-03-05'),
    (2, 50.00, '2023-03-10'),
    (3, 50.00, '2023-03-15'),
    (4, 50.00, '2023-03-20'),
    (5, 50.00, '2023-03-25'),
    (6, 50.00, '2023-03-30'),
    (7, 50.00, '2023-03-31'),
    (10, 50.00, '2023-03-28'),

    -- Pagamentos de Abril
    (1, 50.00, '2023-04-05'),
    (2, 50.00, '2023-04-10'),
    (3, 50.00, '2023-04-15'),
    (4, 50.00, '2023-04-20'),
    (5, 50.00, '2023-04-25'),
    (9, 50.00, '2023-04-28'),

    -- Pagamentos de Maio
    (1, 50.00, '2023-05-05'),
    (2, 50.00, '2023-05-10'),
    (3, 50.00, '2023-05-15'),
    (4, 50.00, '2023-05-20'),
    (5, 50.00, '2023-05-25'),
    (6, 50.00, '2023-05-30'),
    (7, 50.00, '2023-05-31'),
    (8, 50.00, '2023-05-22'),
    (9, 50.00, '2023-05-28');


INSERT INTO Presencas (idAluno, dataPresenca, presente)
VALUES
    -- Presença em Fevereiro
    (1, '2023-02-05', true),
    (2, '2023-02-05', true),
    (3, '2023-02-05', true),
    (4, '2023-02-05', true),
    (5, '2023-02-05', true),
    (6, '2023-02-05', true),
    (7, '2023-02-05', true),
    (8, '2023-02-05', true),
    (9, '2023-02-05', true),
    (10, '2023-02-05', true),
    
	-- Presença em Março
    (1, '2023-03-05', true),
    (2, '2023-03-05', false),
    (3, '2023-03-05', true),
    (4, '2023-03-05', false),
    (5, '2023-03-05', true),
    (6, '2023-03-05', false),
    (7, '2023-03-05', true),
    (8, '2023-03-05', true),
    (9, '2023-03-05', true),
    (10, '2023-03-05', true),
    
	-- Presença em Abril
    (1, '2023-04-05', true),
    (2, '2023-04-05', true),
    (3, '2023-04-05', true),
    (4, '2023-04-05', false),
    (5, '2023-04-05', false),
    (6, '2023-04-05', false),
    (7, '2023-04-05', true),
    (8, '2023-04-05', false),
    (9, '2023-04-05', true),
    (10, '2023-04-05', false),
    
    -- Presença em Maio
    (1, '2023-05-05', true),
    (2, '2023-05-05', true),
    (3, '2023-05-05', true),
    (4, '2023-05-05', true),
    (5, '2023-05-05', false),
    (6, '2023-05-05', true),
    (7, '2023-05-05', true),
    (8, '2023-05-05', false),
    (9, '2023-05-05', true),
    (10, '2023-05-05', false);

-- Inserção de dados para Produtos
INSERT INTO Produtos (nome, valor) VALUES
    ('Cinto de alongamento', 20.00),
    ('Oleo corporal', 15.50),
    ('Tapete de yoga', 30.00);

-- Inserção de dados para Vendas
INSERT INTO Vendas (idAluno, idProduto, quantidade, valorTotal, dataVenda) VALUES
    (1, 1, 2, 40.00, '2023-02-10'),
    (2, 2, 1, 15.50, '2023-02-15'),
    (3, 3, 3, 90.00, '2023-03-20'),
    (4, 1, 1, 20.00, '2023-04-25'),
    (5, 2, 2, 31.00, '2023-05-30');

    INSERT INTO Vendas (idAluno, idProduto, quantidade, valorTotal, dataVenda) VALUES
    (2, 1, 2, 40.00, '2023-04-02'),
    (3, 3, 4, 15.50, '2023-04-10');


-- Inserção de dados para FeedbackAlunos
    
INSERT INTO FeedbackAlunos (idAluno, idPresenca, avaliacao, tipoAvaliacao, dataFeedback)
VALUES
    -- Feedbacks para aulas de Fevereiro
    (1, 1, 8, 'ótimo', '2023-02-10'),
    (2, 2, 5, 'bom', '2023-02-10'),
    (3, 3, 7, 'bom', '2023-02-10'),
    (4, 4, 6, 'bom', '2023-02-10'),
    (5, 5, 9, 'ótimo', '2023-02-10'),
    (6, 6, 4, 'ruim', '2023-02-10'),
    (7, 7, 8, 'ótimo', '2023-02-10'),
    (8, 8, 7, 'bom', '2023-02-10'),
    (9, 9, 9, 'ótimo', '2023-02-10'),
    (10, 10, 5, 'bom', '2023-02-10'),

    -- Feedbacks para aulas de Março
    (1, 11, 8, 'ótimo', '2023-03-10'),
    (3, 13, 7, 'bom', '2023-03-10'),
    (5, 15, 9, 'ótimo', '2023-03-10'),
    (7, 17, 8, 'ótimo', '2023-03-10'),
    (8, 18, 7, 'bom', '2023-03-10'),
    (9, 19, 9, 'ótimo', '2023-03-10'),
    (10, 20, 5, 'bom', '2023-03-10'),

    -- Feedbacks para aulas de Abril
    (1, 21, 8, 'ótimo', '2023-04-15'),
    (2, 22, 6, 'bom', '2023-04-15'),
    (3, 23, 7, 'bom', '2023-04-15'),
    (7, 27, 8, 'ótimo', '2023-04-15'),
    (9, 29, 9, 'ótimo', '2023-04-15'),

    -- Feedbacks para aulas de Maio
    (1, 31, 8, 'ótimo', '2023-05-20'),
    (2, 32, 6, 'bom', '2023-05-20'),
    (3, 33, 7, 'bom', '2023-05-20'),
    (4, 34, 5, 'bom', '2023-05-20'),
    (6, 36, 9, 'ótimo', '2023-05-20'),
    (7, 37, 8, 'ótimo', '2023-05-20'),
    (9, 39, 2, 'ruim', '2023-05-20');

