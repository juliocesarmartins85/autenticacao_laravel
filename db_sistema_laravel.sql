SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';



-- -----------------------------------------------------
-- Table `ci_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ci_sessions` (
        `id` varchar(128) NOT NULL,
        `ip_address` varchar(45) NOT NULL,
        `timestamp` int(10) unsigned DEFAULT 0 NOT NULL,
        `data` blob NOT NULL,
        KEY `ci_sessions_timestamp` (`timestamp`)
);


-- -----------------------------------------------------
-- Table `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
  `idClientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(255) NOT NULL,
  `sexo` VARCHAR(20) NULL,
  `pessoa_fisica` BOOLEAN NOT NULL DEFAULT 1,
  `documento` VARCHAR(20) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `celular` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `dataCadastro` DATE NULL DEFAULT NULL,
  `rua` VARCHAR(70) NULL DEFAULT NULL,
  `numero` VARCHAR(15) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(20) NULL DEFAULT NULL,
  `cep` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;



-- -----------------------------------------------------
-- Table `categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(80) NULL,
  `cadastro` DATE NULL,
  `status` TINYINT(1) NULL,
  `tipo` VARCHAR(15) NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contas` (
  `idContas` INT NOT NULL AUTO_INCREMENT,
  `conta` VARCHAR(45) NULL,
  `banco` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `saldo` DECIMAL(10,2) NULL,
  `cadastro` DATE NULL,
  `status` TINYINT(1) NULL,
  `tipo` VARCHAR(80) NULL,
  PRIMARY KEY (`idContas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lancamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lancamentos` (
  `idLancamentos` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `valor` VARCHAR(15) NOT NULL,
  `data_vencimento` DATE NOT NULL,
  `data_pagamento` DATE NULL DEFAULT NULL,
  `baixado` TINYINT(1) NULL DEFAULT 0,
  `cliente_fornecedor` VARCHAR(255) NULL DEFAULT NULL,
  `forma_pgto` VARCHAR(100) NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `anexo` VARCHAR(250) NULL,
  `clientes_id` INT(11) NULL DEFAULT NULL,
  `categorias_id` INT NULL,
  `contas_id` INT NULL,
  `vendas_id` INT NULL,
  PRIMARY KEY (`idLancamentos`),
  INDEX `fk_lancamentos_clientes1` (`clientes_id` ASC),
  INDEX `fk_lancamentos_categorias1_idx` (`categorias_id` ASC),
  INDEX `fk_lancamentos_contas1_idx` (`contas_id` ASC),
  CONSTRAINT `fk_lancamentos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamentos_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamentos_contas1`
    FOREIGN KEY (`contas_id`)
    REFERENCES `contas` (`idContas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `permissoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permissoes` (
  `idPermissao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `permissoes` TEXT NULL,
  `situacao` TINYINT(1) NULL,
  `data` DATE NULL,
  PRIMARY KEY (`idPermissao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuarios` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `rg` VARCHAR(20) NULL DEFAULT NULL,
  `cpf` VARCHAR(20) NOT NULL,
  `rua` VARCHAR(70) NULL DEFAULT NULL,
  `numero` VARCHAR(15) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(80) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `celular` VARCHAR(20) NULL DEFAULT NULL,
  `situacao` TINYINT(1) NOT NULL,
  `dataCadastro` DATE NOT NULL,
  `permissoes_id` INT NOT NULL,
  `dataExpiracao` date DEFAULT NULL,
  PRIMARY KEY (`idUsuarios`),
  INDEX `fk_usuarios_permissoes1_idx` (`permissoes_id` ASC),
  CONSTRAINT `fk_usuarios_permissoes1`
    FOREIGN KEY (`permissoes_id`)
    REFERENCES `permissoes` (`idPermissao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `Garantia`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `garantias` (
  `idGarantias` INT NOT NULL AUTO_INCREMENT,
  `dataGarantia` DATE NULL,
  `refGarantia` VARCHAR(15) NULL,
  `textoGarantia` TEXT NULL,
  `usuarios_id` INT(11) NULL,
  PRIMARY KEY (`idGarantias`),
  INDEX `fk_garantias_usuarios1` (`usuarios_id` ASC),
  CONSTRAINT `fk_garantias_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `os` (
  `idOs` INT(11) NOT NULL AUTO_INCREMENT,
  `dataInicial` DATE NULL DEFAULT NULL,
  `dataFinal` DATE NULL DEFAULT NULL,
  `garantia` VARCHAR(45) NULL DEFAULT NULL,
  `descricaoProduto` TEXT NULL DEFAULT NULL,
  `defeito` TEXT NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `observacoes` TEXT NULL DEFAULT NULL,
  `laudoTecnico` TEXT NULL DEFAULT NULL,
  `valorTotal` VARCHAR(15) NULL DEFAULT NULL,
  `clientes_id` INT(11) NOT NULL,
  `usuarios_id` INT(11) NOT NULL,
  `lancamento` INT(11) NULL DEFAULT NULL,
  `faturado` TINYINT(1) NOT NULL,
  `garantias_id` int(11) NULL,
  PRIMARY KEY (`idOs`),
  INDEX `fk_os_clientes1` (`clientes_id` ASC),
  INDEX `fk_os_usuarios1` (`usuarios_id` ASC),
  INDEX `fk_os_lancamentos1` (`lancamento` ASC),
  INDEX `fk_os_garantias1` (`garantias_id` ASC),
  CONSTRAINT `fk_os_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_lancamentos1`
    FOREIGN KEY (`lancamento`)
    REFERENCES `lancamentos` (`idLancamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_os_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produtos` (
  `idProdutos` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(80) NOT NULL,
  `unidade` VARCHAR(10) NULL DEFAULT NULL,
  `precoCompra` DECIMAL(10,2) NULL DEFAULT NULL,
  `precoVenda` DECIMAL(10,2) NOT NULL,
  `estoque` INT(11) NOT NULL,
  `estoqueMinimo` INT(11) NULL DEFAULT NULL,
  `saida`	TINYINT(1) NULL DEFAULT NULL,
  `entrada`	TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idProdutos`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `produtos_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produtos_os` (
  `idProdutos_os` INT(11) NOT NULL AUTO_INCREMENT,
  `quantidade` INT(11) NOT NULL,
  `os_id` INT(11) NOT NULL,
  `produtos_id` INT(11) NOT NULL,
  `subTotal` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`idProdutos_os`),
  INDEX `fk_produtos_os_os1` (`os_id` ASC),
  INDEX `fk_produtos_os_produtos1` (`produtos_id` ASC),
  CONSTRAINT `fk_produtos_os_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_os_produtos1`
    FOREIGN KEY (`produtos_id`)
    REFERENCES `produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servicos` (
  `idServicos` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idServicos`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servicos_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servicos_os` (
  `idServicos_os` INT(11) NOT NULL AUTO_INCREMENT,
  `os_id` INT(11) NOT NULL,
  `servicos_id` INT(11) NOT NULL,
  `subTotal` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`idServicos_os`),
  INDEX `fk_servicos_os_os1` (`os_id` ASC),
  INDEX `fk_servicos_os_servicos1` (`servicos_id` ASC),
  CONSTRAINT `fk_servicos_os_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servicos_os_servicos1`
    FOREIGN KEY (`servicos_id`)
    REFERENCES `servicos` (`idServicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATE NULL,
  `valorTotal` VARCHAR(45) NULL,
  `desconto` VARCHAR(45) NULL,
  `faturado` TINYINT(1) NULL,
  `clientes_id` INT(11) NOT NULL,
  `usuarios_id` INT(11) NULL,
  `lancamentos_id` INT(11) NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_vendas_clientes1` (`clientes_id` ASC),
  INDEX `fk_vendas_usuarios1` (`usuarios_id` ASC),
  INDEX `fk_vendas_lancamentos1` (`lancamentos_id` ASC),
  CONSTRAINT `fk_vendas_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendas_lancamentos1`
    FOREIGN KEY (`lancamentos_id`)
    REFERENCES `lancamentos` (`idLancamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `itens_de_vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itens_de_vendas` (
  `idItens` INT NOT NULL AUTO_INCREMENT,
  `subTotal` VARCHAR(45) NULL,
  `quantidade` INT(11) NULL,
  `vendas_id` INT NOT NULL,
  `produtos_id` INT(11) NOT NULL,
  PRIMARY KEY (`idItens`),
  INDEX `fk_itens_de_vendas_vendas1` (`vendas_id` ASC),
  INDEX `fk_itens_de_vendas_produtos1` (`produtos_id` ASC),
  CONSTRAINT `fk_itens_de_vendas_vendas1`
    FOREIGN KEY (`vendas_id`)
    REFERENCES `vendas` (`idVendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_de_vendas_produtos1`
    FOREIGN KEY (`produtos_id`)
    REFERENCES `produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `anexos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `anexos` (
  `idAnexos` INT NOT NULL AUTO_INCREMENT,
  `anexo` VARCHAR(45) NULL,
  `thumb` VARCHAR(45) NULL,
  `url` VARCHAR(300) NULL,
  `path` VARCHAR(300) NULL,
  `os_id` INT(11) NOT NULL,
  PRIMARY KEY (`idAnexos`),
  INDEX `fk_anexos_os1` (`os_id` ASC),
  CONSTRAINT `fk_anexos_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `documentos` (
  `idDocumentos` INT NOT NULL AUTO_INCREMENT,
  `documento` VARCHAR(70) NULL,
  `descricao` TEXT NULL,
  `file` VARCHAR(100) NULL,
  `path` VARCHAR(300) NULL,
  `url` VARCHAR(300) NULL,
  `cadastro` DATE NULL,
  `categoria` VARCHAR(80) NULL,
  `tipo` VARCHAR(15) NULL,
  `tamanho` VARCHAR(45) NULL,
  PRIMARY KEY (`idDocumentos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marcas` (
  `idMarcas` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(100) NULL,
  `cadastro` DATE NULL,
  `situacao` TINYINT(1) NULL,
  PRIMARY KEY (`idMarcas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `equipamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipamentos` (
  `idEquipamentos` INT NOT NULL AUTO_INCREMENT,
  `equipamento` VARCHAR(150) NOT NULL,
  `num_serie` VARCHAR(80) NULL,
  `modelo` VARCHAR(80) NULL,
  `cor` VARCHAR(45) NULL,
  `descricao` VARCHAR(150) NULL,
  `tensao` VARCHAR(45) NULL,
  `potencia` VARCHAR(45) NULL,
  `voltagem` VARCHAR(45) NULL,
  `data_fabricacao` DATE NULL,
  `marcas_id` INT NULL,
  `clientes_id` INT(11) NULL,
  PRIMARY KEY (`idEquipamentos`),
  INDEX `fk_equipanentos_marcas1_idx` (`marcas_id` ASC),
  INDEX `fk_equipanentos_clientes1_idx` (`clientes_id` ASC),
  CONSTRAINT `fk_equipanentos_marcas1`
    FOREIGN KEY (`marcas_id`)
    REFERENCES `marcas` (`idMarcas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipanentos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `equipamentos_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipamentos_os` (
  `idEquipamentos_os` INT NOT NULL AUTO_INCREMENT,
  `defeito_declarado` VARCHAR(200) NULL,
  `defeito_encontrado` VARCHAR(200) NULL,
  `solucao` VARCHAR(45) NULL,
  `equipamentos_id` INT NULL,
  `os_id` INT(11) NULL,
  PRIMARY KEY (`idEquipamentos_os`),
  INDEX `fk_equipamentos_os_equipanentos1_idx` (`equipamentos_id` ASC),
  INDEX `fk_equipamentos_os_os1_idx` (`os_id` ASC),
  CONSTRAINT `fk_equipamentos_os_equipanentos1`
    FOREIGN KEY (`equipamentos_id`)
    REFERENCES `equipamentos` (`idEquipamentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipamentos_os_os1`
    FOREIGN KEY (`os_id`)
    REFERENCES `os` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logs` (
  `idLogs` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(80) NULL,
  `tarefa` VARCHAR(100) NULL,
  `data` DATE NULL,
  `hora` TIME NULL,
  `ip` VARCHAR(45) NULL,
  PRIMARY KEY (`idLogs`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `emitente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `emitente` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(255) NULL ,
  `cnpj` VARCHAR(45) NULL ,
  `ie` VARCHAR(50) NULL ,
  `rua` VARCHAR(70) NULL ,
  `numero` VARCHAR(15) NULL ,db_sistema_laravel
  `bairro` VARCHAR(45) NULL ,
  `cidade` VARCHAR(45) NULL ,
  `uf` VARCHAR(20) NULL ,
  `telefone` VARCHAR(20) NULL ,
  `email` VARCHAR(255) NULL ,
  `url_logo` VARCHAR(225) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;