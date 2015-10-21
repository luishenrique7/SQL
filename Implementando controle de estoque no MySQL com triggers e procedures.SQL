
--Script de criação da tabela Produtos
CREATE TABLE produto
(
	 id INT(11) NOT NULL AUTO_INCREMENT,
	 status CHAR(1) NOT NULL DEFAULT 'A',
	 descricao VARCHAR(50) NULL DEFAULT NULL,
	 estoque_minimo INT(11) NULL DEFAULT NULL,
	 estoque_maximo INT(11) NULL DEFAULT NULL,
	 PRIMARY KEY (id)
 );
 
 --Script de criação da tabela ENTRADA_PRODUTO
 CREATE TABLE entrada_produto 
 (
	 id INT(11) NOT NULL AUTO_INCREMENT,
	 id_produto INT(11) NULL DEFAULT NULL,
	 qtde INT(11) NULL DEFAULT NULL,
	 valor_unitario DECIMAL(9,2) NULL DEFAULT '0.00',
	 data_entrada DATE NULL DEFAULT NULL,
 PRIMARY KEY (id)
 );
 
 --Script de criação da tabela ESTOQUE
 CREATE TABLE estoque
 (
	 id INT(11) NOT NULL AUTO_INCREMENT,
	 id_produto INT(11) NULL DEFAULT NULL,
	 qtde INT(11) NULL DEFAULT NULL,
	 valor_unitario DECIMAL(9,2) NULL DEFAULT '0.00',
	 PRIMARY KEY (id)
 );
 
 --Script de criação da tabela SAIDA_PRODUTO
 CREATE TABLE saida_produto
 (
	 id INT(11) NOT NULL AUTO_INCREMENT,
	 id_produto INT(11) NULL DEFAULT NULL,
	 qtde INT(11) NULL DEFAULT NULL,
	 data_saida DATE NULL DEFAULT NULL,
	 valor_unitario DECIMAL(9,2) NULL DEFAULT '0.00',
	 PRIMARY KEY (id)
 );
 
 --Script de criação do procedure proc_atualiza_estoque
DELIMITER $$
CREATE PROCEDURE proc_atualiza_estoque(p_id_prod INT,
										p_qtde INT,
										p_valor_unitario DECIMAL(16,2))
BEGIN
	DECLARE contador INT(11);
	
	SELECT COUNT(*)
	INTO contador
	FROM estoque
	WHERE id_produto = p_id_prod;
	
	IF contador > 0 THEN
		UPDATE estoque
		SET qtde = qtde + p_qtde --, valor_unitario = valor_unitario + p_valor_unitario -- / 2
		WHERE id_produto = p_id_prod;
	ELSE
		INSERT INTO estoque(id_produto, qtde, valor_unitario)
		VALUES(p_id_prod, p_qtde, p_valor_unitario);
	END IF;
END $$
DELIMITER ;
 
 --Script de criação do trigger TRG_EntradaProduto_AI
DELIMITER $$
CREATE TRIGGER trg_entrada_produto_ai
	AFTER INSERT ON entrada_produto
	FOR EACH ROW
BEGIN
	CALL PROC_ATUALIZA_ESTOQUE(NEW.id_produto, NEW.qtde, NEW.valor_unitario);
END $$
DELIMITER ;
 
 --Script de criação do trigger TRG_EntradaProduto_AU
DELIMITER $$
CREATE TRIGGER trg_entrada_produto_au
	AFTER INSERT ON entrada_produto
	FOR EACH ROW
BEGIN
	CALL proc_atualiza_estoque(NEW.p_id_prod, NEW.p_qtde - OLD.p_qtde, NEW.p_valor_unitario);
END $$
DELIMITER ;
 
 --Script de criação do trigger TRG_EntradaProduto_AD
DELIMITER $$
CREATE TRIGGER trg_entrada_produto_ad
	AFTER INSERT ON entrada_produto
	FOR EACH ROW
BEGIN
	CALL proc_atualiza_estoque(OLD.p_id_prod, OLD.p_qtde * -1, OLD.p_valor_unitario);
END $$
DELIMITER ;

-- Script de criação do trigger TRG_SaidaProduto_AI
DELIMITER $$
CREATE TRIGGER trg_saida_produto_ai
	AFTER INSERT ON entrada_produto
	FOR EACH ROW
BEGIN
	CALL proc_atualiza_estoque(NEW.p_id_prod, NEW.p_qtde * -1, NEW.p_valor_unitario);
END $$
DELIMITER ;

-- Script de criação do trigger TRG_SaidaProduto_AU
DELIMITER $$
CREATE TRIGGER trg_saida_produto_au
	AFTER INSERT ON entrada_produto
	FOR EACH ROW
BEGIN
	CALL proc_atualiza_estoque(NEW.p_id_prod, OLD.p_qtde - NEW.p_qtde, NEW.p_valor_unitario);
END $$
DELIMITER ;
 
-- Script de criação do trigger TRG_SaidaProduto_AD
DELIMITER $$
CREATE TRIGGER trg_saida_produto_ad
	AFTER INSERT ON entrada_produto
	FOR EACH ROW
BEGIN
	CALL proc_atualiza_estoque(OLD.p_id_prod, OLD.p_qtde, OLD.p_valor_unitario);
END $$
DELIMITER ;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 