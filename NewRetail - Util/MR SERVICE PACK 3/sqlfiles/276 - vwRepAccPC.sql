if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_LancamentoPC]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_LancamentoPC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordPC]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordPC]
GO

DELETE Rep_Field
WHERE TableName = 'vw_Rep_LancamentoPC'
GO

DELETE Rep_table
WHERE TableName = 'vw_Rep_LancamentoPC'
GO

DELETE Rep_Field
WHERE TableName = 'vw_Rep_Acc_RecordPC'
GO

DELETE Rep_table
WHERE TableName = 'vw_Rep_Acc_RecordPC'
GO

CREATE VIEW vw_Rep_Acc_RecordPC AS
	SELECT
		Fin_LancamentoTipo.CodigoContabil AS AccountCode,
		REPLICATE(' ', LEN(Fin_LancamentoTipo.CodigoContabil) - 1) + Fin_LancamentoTipo.CodigoContabil AS TreeCode,
		Fin_LancamentoTipo.LancamentoTipo as RecordType,
		REPLICATE(' ', LEN(Fin_LancamentoTipo.CodigoContabil) - 1) + Fin_LancamentoTipo.LancamentoTipo AS TreePath,
		LancPC.DataVencimento as DueDate,
		LancPC.DataLancamento as RecordDate,
		SUM(ISNULL(LancPC.ValorNominal, 0)) AS Amount
	FROM
		Fin_LancamentoTipo INNER JOIN
		(
		SELECT				
			F.DataVencimento,
			F.DataLancamento,
			FT.CodigoContabil,
			F.ValorNominal
		FROM
			Fin_Lancamento F INNER JOIN 
			Fin_LancamentoTipo FT ON
				(F.IDLancamentoTipo = FT.IDLancamentoTipo)
	
		) AS LancPC on (LancPC.CodigoContabil LIKE Fin_LancamentoTipo.CodigoContabil + '%')
	GROUP BY
		Fin_LancamentoTipo.CodigoContabil,
		Fin_LancamentoTipo.LancamentoTipo,
		LancPC.DataVencimento,
		LancPC.DataLancamento
GO

EXEC sp_Rep_AddTableField 'vw_Rep_Acc_RecordPC'
GO
