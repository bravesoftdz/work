IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[tr_LancQuit_All]') AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
DROP TRIGGER [dbo].[tr_LancQuit_All]
GO

CREATE TRIGGER tr_LancQuit_All ON dbo.Fin_LancQuit
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as Tabelas de Lancamento e Quitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN

SET NOCOUNT ON

/* -----------------------------------------------------------------
	Delecao
   -----------------------------------------------------------------
*/
/*
	Total Quitado e Total Jurus
*/
UPDATE
	Fin_Lancamento
SET
	TotalQuitado = TotalQuitado - SumQuitado,
	TotalJuros = TotalJuros - SumJuros
FROM	(
	SELECT
		IDLancamento,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Deleted D
	GROUP BY
		IDLancamento
	) D
WHERE
	D.IDLancamento = Fin_Lancamento.IDLancamento

/*
  	Total da Quitacao
*/
UPDATE
	Fin_Quitacao
SET
	ValorQuitacao = ValorQuitacao - SumQuitado,
	ValorJuros = ValorJuros - SumJuros
FROM	(
	SELECT
		IDQuitacao,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Deleted D
	GROUP BY
		IDQuitacao
	) D
WHERE
	D.IDQuitacao = Fin_Quitacao.IDQuitacao

/*
	Situacao Parte Quitado
*/
UPDATE
	Fin_Lancamento
SET
	Situacao = C.Valor,
	Fin_Lancamento.DataFimQuitacao = Null
FROM
	Deleted D,
	Sis_Constante C
WHERE
	D.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado <> Fin_Lancamento.ValorNominal
	AND
	Fin_Lancamento.TotalQuitado > 0
	AND
	C.Constante = 'LancamentoSituacao_ParteQuitado'

/*
	Situacao Aberto
*/
UPDATE
	Fin_Lancamento
SET
	Fin_Lancamento.Situacao = C.Valor,
 	Fin_Lancamento.DataInicioQuitacao = Null,
	Fin_Lancamento.DataFimQuitacao = Null
FROM
	Deleted D,
	Sis_Constante C
WHERE
	D.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado = 0
	AND
	C.Constante = 'LancamentoSituacao_Aberto'

/* -----------------------------------------------------------------
	Inclusao
   ----------------------------------------------------------------- */
/*
	Total Quitado e Total Jurus
*/
UPDATE
	Fin_Lancamento
SET
	TotalQuitado = TotalQuitado + SumQuitado,
	TotalJuros = TotalJuros + SumJuros
FROM	(
	SELECT
		IDLancamento,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Inserted I
	GROUP BY
		IDLancamento
	) I
WHERE
	I.IDLancamento = Fin_Lancamento.IDLancamento

/*
  	Total da Quitacao
*/
UPDATE
	Fin_Quitacao
SET
	ValorQuitacao = ValorQuitacao + SumQuitado,
	ValorJuros = ValorJuros + SumJuros
FROM	(
	SELECT
		IDQuitacao,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Inserted I
	GROUP BY
		IDQuitacao
	) I
WHERE
	I.IDQuitacao = Fin_Quitacao.IDQuitacao

/*
	DataInicioQuitacao
	e
	Situacao
*/
UPDATE
	Fin_Lancamento
SET
	DataInicioQuitacao = I.DataQuitacao,
	Situacao = C.Valor
FROM
	Inserted I,
	Sis_Constante C
WHERE
	I.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado <> Fin_Lancamento.ValorNominal
	AND
	Fin_Lancamento.DataInicioQuitacao is NULL
	AND
	C.Constante = 'LancamentoSituacao_ParteQuitado'

/*
	DataFimQuitacao
	e
	Situacao
*/
UPDATE
	Fin_Lancamento
SET
	DataFimQuitacao = I.DataQuitacao,
	Situacao = C.Valor
FROM
	Inserted I,
	Sis_Constante C
WHERE
	I.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado >= Fin_Lancamento.ValorNominal
	AND
	C.Constante = 'LancamentoSituacao_Quitado'
GO
