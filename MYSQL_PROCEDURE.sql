/* RETORNA OS PRODUTOS */
DELIMITER $$ 
CREATE PROCEDURE PROC_SELECIONAR_PRODUTOS(IN quantidade INT) 
BEGIN 
	SELECT * 
	FROM PRODUTO
	LIMIT quantidade; 
END $$ 
DELIMITER ;
/* CHAMAR PROCEDURE */
CALL PROC_SELECIONAR_PRODUTOS(2);

/* */
DELIMITER $$
CREATE PROCEDURE PROC_VERIFICA_PRODUTOS(OUT P_QUANT INT)
BEGIN
	SELECT COUNT(*)
	INTO P_QUANT
	FROM PRODUTO;
END $$
DELIMITER ;

CALL PROC_VERIFICA_PRODUTOS(@TOTAL);
SELECT @TOTAL;


/* ADICIONA UM X NO SOBRENOME ESPECIFICADO */
DELIMITER $$
CREATE PROCEDURE PROC_CONCATENA_X(P_ID INT)
BEGIN
	UPDATE FUNCIONARIOS
    SET SOBRENOME = CONCAT(SOBRENOME, ' ', 'X')
    WHERE ID = P_ID;
    COMMIT;
END $$
DELIMITER ;

CALL PROC_CONCATENA_X(1);

/* */
DELIMITER $$
CREATE PROCEDURE PROC_ATUALIZA_EMP(IN P_SITUACAO VARCHAR(1))
BEGIN
	IF (P_SITUACAO = 'D') THEN
		UPDATE LIVROS SET SITUACAO = 'E' 
        WHERE SITUACAO = P_SITUACAO;
	ELSEIF (P_SITUACAO = 'E') THEN
		UPDATE LIVROS SET SITUACAO = 'D' 
        WHERE SITUACAO = P_SITUACAO;
	END IF;
END $$
DELIMITER ;

CALL PROC_ATUALIZA_EMP('E');

/* */
DELIMITER $$
CREATE PROCEDURE PROC_ATUALIZA_EMP_ID(IN P_SITUACAO VARCHAR(1), P_ID INT)
BEGIN
	IF (P_SITUACAO = 'D') THEN
		UPDATE LIVROS SET SITUACAO = 'E' 
        WHERE SITUACAO = P_SITUACAO
        AND ID_LIVRO = P_ID;
	ELSEIF (P_SITUACAO = 'E') THEN
		UPDATE LIVROS SET SITUACAO = 'D' 
        WHERE SITUACAO = P_SITUACAO
        AND ID_LIVRO = P_ID;
	END IF;
END $$
DELIMITER ;

CALL PROC_ATUALIZA_EMP('D', 1);

/* */


/* */


/* */


/* */


/* */


/* */





