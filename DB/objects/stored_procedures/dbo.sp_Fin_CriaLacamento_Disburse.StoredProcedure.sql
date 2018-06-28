SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Fin_CriaLacamento_Disburse]
	(
	@IDLancamentoParent 	int,
	@Total			money,
	@NumDuplicata		varchar(20),
	@IDLancamentoTipo	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as informacoes dos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro em incluo o lancamento Disbursement

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-------------------------------------------------------------------------------------------------------------------------------------
	13 May	2002		Rodrigo Costa		Criacao
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração de Fin_Lancamento_Cursor
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Dez	2004		Rodrigo Costa		Novo parametro @IDLancamentoTipo
	22 Feb	2006		Maximiliano Muniz	Removido o cursor Fin_Lancamento_Cursor
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamento		int

SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
	(
	IDLancamento,
	Pagando,
	IDLancamentoTipo,
	DataLancamento,
	IDUsuarioLancamento,
	Previsao,
	Situacao,
	IDPessoaTipo,
	IDPessoa,
	IDEmpresa,
	DataVencimento,
	DataEmissao,
	IDDocumentoTipo,
	ValorNominal,
	NumDocumento,
	IDPurchase,
	IDMoeda,
	IDMoedaCotacao,
	LancamentoType,
	IDLancamentoParent,
	NumeroDuplicata
	)
	(
	SELECT
		@IDLancamento,
		LP.Pagando,
		@IDLancamentoTipo,
		LP.DataLancamento,
		LP.IDUsuarioLancamento,
		LP.Previsao,
		LP.Situacao,
		LP.IDPessoaTipo,
		LP.IDPessoa,
		LP.IDEmpresa,
		LP.DataVencimento,
		LP.DataEmissao,
		LP.IDDocumentoTipo,
		@Total,
		LP.NumDocumento,
		LP.IDPurchase,
		LP.IDMoeda,
		LP.IDMoedaCotacao,
		2, -- Lancamento Tipo Desdrobramento
		LP.IDLancamento,
		@NumDuplicata
	FROM
		Fin_Lancamento LP (NOLOCK)
	WHERE
		LP.IDLancamento = @IDLancamentoParent
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_CriaLacamento_Disburse', @ErrorLevelStr

	RETURN @ErrorLevel
GO
