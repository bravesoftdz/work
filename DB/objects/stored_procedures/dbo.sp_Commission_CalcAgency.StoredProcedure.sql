SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_CalcAgency]
		(
		@IDAgency 		int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Date			Datetime,
		@Commission		money	output,
		@Divida 		money	output
		)
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	SUMARIO

        	- Calculo a comissao da agencia em cima da do guia
	- Calcula a divida da Agencia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	19 June 2001   		Eduardo Costa		Criação;
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if not (@IDAgency > 0)
   return

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a comissao da Agencia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Calculo a comissao da agencia em cima da do guia.
-- Utilizando um percentual defino no TouristGroup

SELECT
	@Commission = IsNull(SUM( IsNull( C.MovCommission* (TG.ComissaoSobreGuia/100),0) ),0)
FROM
	TouristGroup TG (NOLOCK)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN Pessoa P (NOLOCK)
		ON (TG.IDGuide = P.IDPessoa)
	JOIN vwCommission C (NOLOCK)
		ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1 AND C.IDTipoPessoa = P.IDTipoPessoa)
WHERE
	TG.IDLancPagAgencia IS NULL
	AND
	TG.IDAgency = @IDAgency
	AND
	I.InvoiceDate >= @DataInicio
	AND
	I.InvoiceDate < @DataFim


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a divida da Agencia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_Commission_CalcDivida @IDAgency, @Date, @Divida
GO
