/* TRIGGER INSERE VALOR NULL SE O QUE ESTA INSERINDO FOR NULL OU <=3 */
DELIMITER $$
CREATE TRIGGER TG_BASIC
	BEFORE INSERT ON FUNCIONARIOS
	FOR EACH ROW
BEGIN
	SET @NOME = NEW.NOME;
	IF(CHAR_LENGTH(@NOME <= 3) OR (@NOME = '')) THEN
		SET NEW.NOME = 'X';
	END IF;
END $$
DELIMITER ;

DROP TRIGGER TG_BASIC;


/* O TRIGGER É DISPARADO PARA CONFERIR SE O PRODUTO E CLIENTE EXISTEM NAS SUAS TABELAS */
DELIMITER $$
CREATE TRIGGER TG_VERIFICA 
	BEFORE INSERT ON COMPRA
	FOR EACH ROW
BEGIN
	/* VERIFICANDO SE HÁ O CLIENTE */
	SELECT COUNT(ID_CLIENTE)
	INTO @ID_CLIENTE
	FROM CLIENTE
	WHERE ID_CLIENTE = @ID_CLIENTE;
	/*--VERIFICANDO SE HÁ O PRODUTO */
	SELECT COUNT(ID_PRODUTO)
	INTO @ID_PRODUTO
	FROM PRODUTO
	WHERE ID_PRODUTO = @ID_PRODUTO;
	/* --VALIDAR */
	IF((@ID_CLIENTE = 0) OR (@ID_PRODUTO = 0)) THEN	
		/* --FORÇA O ERRO NO INSERT */
		SET NEW.ID_CLIENTE = NULL;
		SET NEW.ID_PRODUTO = NULL;
	END IF;
END $$
DELIMITER ;

DROP TRIGGER TG_VERIFICA;

/* CADASTRA AUTOMATICAMENTE O VALOR DO CAMPO EMAIL EM OUTRA TABELA */
DELIMITER $$
CREATE TRIGGER TG_INSERT_NEWS
	AFTER INSERT ON CLIENTE
    FOR EACH ROW
BEGIN
	IF(NEW.EMAIL IS NOT NULL) THEN
		INSERT INTO NEWSLETTER
		SET NEWS_EMAIL = NEW.EMAIL;
	END IF;
END $$
DELIMITER ;


/* TRIGGER ALTERA STATUS PARA EMPRESTADO */
DELIMITER $$
CREATE TRIGGER ALTERA_STATUS
	AFTER INSERT ON EMPRESTIMO
	FOR EACH ROW
BEGIN
	IF(NEW.ID_EMPRESTIMO IS NOT NULL) THEN
		UPDATE LIVROS 
		SET STATUS = 'E'
		WHERE ID_LIVRO = NEW.ID_LIVRO;
	END IF;
END $$
DELIMITER ;



/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

/* */

