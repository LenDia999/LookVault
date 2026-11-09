-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Out-2026 às 16:08
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

CREATE DATABASE IF NOT EXISTS `lookvault` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lookvault`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `lookvault`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `logs_atividades`
--

CREATE TABLE `logs_atividades` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `acao` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `looks`
--

CREATE TABLE `looks` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `ocasiao` varchar(50) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `looks`
--

INSERT INTO `looks` (`id`, `usuario_id`, `nome`, `ocasiao`, `data_criacao`) VALUES
(5, 3, 'Vestido de praia', 'Praia', '2026-07-07 18:43:42');

-- --------------------------------------------------------

--
-- Estrutura da tabela `look_pecas`
--

CREATE TABLE `look_pecas` (
  `id` int(11) NOT NULL,
  `look_id` int(11) NOT NULL,
  `peca_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `look_pecas`
--

INSERT INTO `look_pecas` (`id`, `look_id`, `peca_id`) VALUES
(10, 5, 14);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pecas`
--

CREATE TABLE `pecas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `cor` varchar(30) DEFAULT NULL,
  `tamanho` varchar(10) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pecas`
--

INSERT INTO `pecas` (`id`, `usuario_id`, `nome`, `marca`, `categoria`, `cor`, `tamanho`, `valor`, `tags`, `foto`, `data_cadastro`) VALUES
(12, 1, 'Camisa Branca ', 'DIOR', 'Camisas', 'Branca', NULL, 245.00, 'Verão, Casual, Simples', 'uploads/pecas/1783365816_6a4c00b8c73e2.jpg', '2026-07-06 19:23:36'),
(13, 3, 'Camisa Branca ', 'DIOR', 'Camisas', 'Branca', NULL, 687.00, 'Verão, Casual, Simples', 'uploads/pecas/1783448745_6a4d44a9d5e72.jpg', '2026-07-07 18:25:45'),
(14, 3, 'Vestido Azul ', 'CHANEL', 'Vestidos', 'Azul ', NULL, 987.00, 'Primavera, elegante, bonito', 'uploads/pecas/1783449792_6a4d48c0c3c0a.jpg', '2026-07-07 18:43:12'),
(15, 1, 'Bolsa Neverfull', 'LOUIS VUITTON', 'Acessórios', 'Marrom', NULL, 1800.00, 'luxo, social', NULL, '2026-07-08 19:48:07'),
(16, 1, 'Tênis Triple S', 'BALENCIAGA', 'Sapatos', 'Branco', NULL, 1200.00, 'esporte, streetwear', NULL, '2026-07-08 19:48:07'),
(17, 1, 'Vestido Barroco', 'VERSACE', 'Vestidos', 'Dourado', NULL, 1500.00, 'festa, luxo', NULL, '2026-07-08 19:48:07'),
(18, 1, 'Terno Azul Marinho', 'ARMANI', 'Blazers', 'Azul', NULL, 2200.00, 'social, trabalho', NULL, '2026-07-08 19:48:07'),
(19, 1, 'Camisa Social', 'RALPH LAUREN', 'Camisas', 'Branco', NULL, 450.00, 'social, trabalho', NULL, '2026-07-08 19:48:07'),
(20, 1, 'Jaqueta De Couro', 'BURBERRY', 'Blazers', 'Preto', NULL, 1800.00, 'casual, inverno', NULL, '2026-07-08 19:48:07'),
(21, 1, 'Scarf Estampado', 'DOLCE & GABBANA', 'Acessórios', 'Vermelho', NULL, 350.00, 'inverno, casual', NULL, '2026-07-08 19:48:07');

-- --------------------------------------------------------

--
-- Estrutura da tabela `recuperar_senha`
--

CREATE TABLE `recuperar_senha` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiracao` datetime NOT NULL,
  `usado` tinyint(1) DEFAULT 0,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `uso_pecas`
--

CREATE TABLE `uso_pecas` (
  `id` int(11) NOT NULL,
  `peca_id` int(11) NOT NULL,
  `data_uso` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `senha` varchar(255) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `foto_perfil`, `senha`, `data_cadastro`) VALUES
(1, 'Usuário Teste', 'teste@lookvault.com', NULL, 'e10adc3949ba59abbe56e057f20f883e', '2026-07-01 19:20:56'),
(3, 'Hadassa Souza', 'hadassa.sza@gmail.com', 'uploads/perfil/perfil_3_1790181069.png', '$2y$10$.Su2JwiOjiA/oj8Fx.4RuOpEBrUed6fDZe2bIYPKggDNm8DD9zNSO', '2026-07-07 18:23:18'),
(4, 'Claudia', 'claudinha1234@gmail.com', NULL, '$2y$10$/E55se0CJa7/hCS/Gy/dSeSEbLXsNh/TS5G.BI2dG0JC9lEnhvOm2', '2026-07-07 19:16:42');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `logs_atividades`
--
ALTER TABLE `logs_atividades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices para tabela `looks`
--
ALTER TABLE `looks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices para tabela `look_pecas`
--
ALTER TABLE `look_pecas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `look_id` (`look_id`),
  ADD KEY `peca_id` (`peca_id`);

--
-- Índices para tabela `pecas`
--
ALTER TABLE `pecas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices para tabela `recuperar_senha`
--
ALTER TABLE `recuperar_senha`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices para tabela `uso_pecas`
--
ALTER TABLE `uso_pecas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `peca_id` (`peca_id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `logs_atividades`
--
ALTER TABLE `logs_atividades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `looks`
--
ALTER TABLE `looks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `look_pecas`
--
ALTER TABLE `look_pecas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `pecas`
--
ALTER TABLE `pecas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de tabela `recuperar_senha`
--
ALTER TABLE `recuperar_senha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `uso_pecas`
--
ALTER TABLE `uso_pecas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `logs_atividades`
--
ALTER TABLE `logs_atividades`
  ADD CONSTRAINT `logs_atividades_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `looks`
--
ALTER TABLE `looks`
  ADD CONSTRAINT `looks_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `look_pecas`
--
ALTER TABLE `look_pecas`
  ADD CONSTRAINT `look_pecas_ibfk_1` FOREIGN KEY (`look_id`) REFERENCES `looks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `look_pecas_ibfk_2` FOREIGN KEY (`peca_id`) REFERENCES `pecas` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `pecas`
--
ALTER TABLE `pecas`
  ADD CONSTRAINT `pecas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `recuperar_senha`
--
ALTER TABLE `recuperar_senha`
  ADD CONSTRAINT `recuperar_senha_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `uso_pecas`
--
ALTER TABLE `uso_pecas`
  ADD CONSTRAINT `uso_pecas_ibfk_1` FOREIGN KEY (`peca_id`) REFERENCES `pecas` (`id`) ON DELETE CASCADE;


-- Módulos complementares do LOOKVAULT
CREATE TABLE IF NOT EXISTS `favoritos_pecas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `peca_id` int NOT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_favorito_usuario_peca` (`usuario_id`,`peca_id`),
  CONSTRAINT `fk_favoritos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_favoritos_peca` FOREIGN KEY (`peca_id`) REFERENCES `pecas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `calendario_looks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `look_id` int NOT NULL,
  `data_evento` date NOT NULL,
  `observacao` varchar(255) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_calendario_usuario_data` (`usuario_id`,`data_evento`),
  CONSTRAINT `fk_calendario_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_calendario_look` FOREIGN KEY (`look_id`) REFERENCES `looks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `marketplace_anuncios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `peca_id` int NOT NULL,
  `tipo` enum('troca','doacao') NOT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `status` enum('ativo','pausado','concluido') NOT NULL DEFAULT 'ativo',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_marketplace_status` (`status`,`data_criacao`),
  CONSTRAINT `fk_marketplace_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_marketplace_peca` FOREIGN KEY (`peca_id`) REFERENCES `pecas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `viagens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `destino` varchar(120) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `observacoes` varchar(500) DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_viagens_usuario` (`usuario_id`),
  CONSTRAINT `fk_viagens_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `viagem_pecas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `viagem_id` int NOT NULL,
  `peca_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_viagem_peca` (`viagem_id`,`peca_id`),
  CONSTRAINT `fk_viagem_pecas_viagem` FOREIGN KEY (`viagem_id`) REFERENCES `viagens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_viagem_pecas_peca` FOREIGN KEY (`peca_id`) REFERENCES `pecas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `php_sessions` (
  `session_id` varchar(128) NOT NULL,
  `session_data` mediumblob NOT NULL,
  `last_activity` int unsigned NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `idx_php_sessions_last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
