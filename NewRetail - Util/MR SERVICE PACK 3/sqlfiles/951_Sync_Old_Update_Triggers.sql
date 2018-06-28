use MainRetailDB

/****** Object:  Trigger [tr_CashRegister_Repl_Del]    Script Date: 08/18/2016 02:30:47 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CashRegister_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CashRegister_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_CashRegister_Repl_Del]    Script Date: 08/18/2016 02:30:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CashRegister_Repl_Del] ON [dbo].[CashRegister] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CashRegister', 'DELETE FROM CashRegister WHERE ' + 'Convert(varchar, IDCashRegister)  = ' + QuoteName(Convert(varchar, DELETED.IDCashRegister), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CashRegLog_Repl_Del]    Script Date: 08/18/2016 02:37:03 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CashRegLog_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CashRegLog_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_CashRegLog_Repl_Del]    Script Date: 08/18/2016 02:37:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CashRegLog_Repl_Del] ON [dbo].[CashRegLog] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CashRegLog', 'DELETE FROM CashRegLog WHERE ' + 'Convert(varchar, IDCashRegLog)  = ' + QuoteName(Convert(varchar, DELETED.IDCashRegLog), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CashRegLogComplement_Repl_Del]    Script Date: 08/18/2016 02:41:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CashRegLogComplement_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CashRegLogComplement_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_CashRegLogComplement_Repl_Del]    Script Date: 08/18/2016 02:41:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CashRegLogComplement_Repl_Del] ON [dbo].[CashRegLogComplement] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CashRegLogComplement', 'DELETE FROM CashRegLogComplement WHERE ' + 'Convert(varchar, IDCashRegLog)  = ' + QuoteName(Convert(varchar, DELETED.IDCashRegLog), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_cashreglogreason_Repl_Del]    Script Date: 08/18/2016 02:43:24 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_cashreglogreason_Repl_Del]'))
DROP TRIGGER [dbo].[tr_cashreglogreason_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_cashreglogreason_Repl_Del]    Script Date: 08/18/2016 02:43:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_cashreglogreason_Repl_Del] ON [dbo].[CashRegLogReason] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'cashreglogreason', 'DELETE FROM cashreglogreason WHERE ' + 'Convert(varchar, IDCashRegLogReason)  = ' + QuoteName(Convert(varchar, DELETED.IDCashRegLogReason), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_cashregmov_Repl_Del]    Script Date: 08/18/2016 02:46:40 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_cashregmov_Repl_Del]'))
DROP TRIGGER [dbo].[tr_cashregmov_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_cashregmov_Repl_Del]    Script Date: 08/18/2016 02:46:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_cashregmov_Repl_Del] ON [dbo].[CashRegMov] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'cashregmov', 'DELETE FROM cashregmov WHERE ' + 'Convert(varchar, IDCashRegMov)  = ' + QuoteName(Convert(varchar, DELETED.IDCashRegMov), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CashRegMovPaymentLog_Repl_Del]    Script Date: 08/18/2016 02:54:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CashRegMovPaymentLog_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CashRegMovPaymentLog_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_CashRegMovPaymentLog_Repl_Del]    Script Date: 08/18/2016 02:54:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CashRegMovPaymentLog_Repl_Del] ON [dbo].[CashRegMovPaymentLog] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CashRegMovPaymentLog', 'DELETE FROM CashRegMovPaymentLog WHERE ' + 'Convert(varchar, IDPaymentLog)  = ' + QuoteName(Convert(varchar, DELETED.IDPaymentLog), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CashRegMovPaymentLog_Repl_InsUpt]    Script Date: 08/18/2016 03:06:52 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CashRegMovPaymentLog_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_CashRegMovPaymentLog_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_CashRegMovPaymentLog_Repl_InsUpt]    Script Date: 08/18/2016 03:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CashRegMovPaymentLog_Repl_InsUpt] ON [dbo].[CashRegMovPaymentLog] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE CashRegMovPaymentLog SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPaymentLog = CashRegMovPaymentLog.IDPaymentLog

       UPDATE CashRegMovPaymentLog SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPaymentLog = CashRegMovPaymentLog.IDPaymentLog

END
GO

/****** Object:  Trigger [tr_ComisPaga_Repl_Del]    Script Date: 05/27/2016 14:11:18 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_ComisPaga_Repl_Del]'))
DROP TRIGGER [dbo].[tr_ComisPaga_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_ComisPaga_Repl_Del]    Script Date: 05/27/2016 14:11:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_ComisPaga_Repl_Del] ON [dbo].[ComisPaga] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'ComisPaga', 'DELETE FROM ComisPaga WHERE ' + 'Convert(varchar, IDDocumento)  = ' + QuoteName(Convert(varchar, DELETED.IDDocumento), CHAR(39)) + ' AND ' + 'Convert(varchar, IDPessoa)  = ' + QuoteName(Convert(varchar, DELETED.IDPessoa), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_ComisPaga_Repl_InsUpt]    Script Date: 05/27/2016 14:13:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_ComisPaga_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_ComisPaga_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_ComisPaga_Repl_InsUpt]    Script Date: 05/27/2016 14:13:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_ComisPaga_Repl_InsUpt] ON [dbo].[ComisPaga] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE ComisPaga SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDDocumento = ComisPaga.IDDocumento
AND
INSERTED.IDPessoa = ComisPaga.IDPessoa

       UPDATE ComisPaga SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDDocumento = ComisPaga.IDDocumento
AND
DELETED.IDPessoa = ComisPaga.IDPessoa

END
GO

/****** Object:  Trigger [tr_Cotacao_Repl_Del]    Script Date: 08/18/2016 04:09:24 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Cotacao_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Cotacao_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Cotacao_Repl_Del]    Script Date: 08/18/2016 04:09:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Cotacao_Repl_Del] ON [dbo].[Cotacao] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Cotacao', 'DELETE FROM Cotacao WHERE ' + 'Convert(varchar, IDCotacao)  = ' + QuoteName(Convert(varchar, DELETED.IDCotacao), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Cotacao_Repl_InsUpt]    Script Date: 08/18/2016 04:10:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Cotacao_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Cotacao_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Cotacao_Repl_InsUpt]    Script Date: 08/18/2016 04:10:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Cotacao_Repl_InsUpt] ON [dbo].[Cotacao] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Cotacao SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCotacao = Cotacao.IDCotacao

       UPDATE Cotacao SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCotacao = Cotacao.IDCotacao

END
GO

/****** Object:  Trigger [tr_CotacaoResult_Repl_Del]    Script Date: 08/18/2016 16:54:18 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoResult_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CotacaoResult_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_CotacaoResult_Repl_Del]    Script Date: 08/18/2016 16:54:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoResult_Repl_Del] ON [dbo].[CotacaoResult] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CotacaoResult', 'DELETE FROM CotacaoResult WHERE ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, IDFornecedor)  = ' + QuoteName(Convert(varchar, DELETED.IDFornecedor), CHAR(39)) + ' AND ' + 'Convert(varchar, IDCotacao)  = ' + QuoteName(Convert(varchar, DELETED.IDCotacao), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CotacaoResult_Repl_InsUpt]    Script Date: 08/18/2016 16:56:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoResult_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_CotacaoResult_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoResult_Repl_InsUpt]    Script Date: 08/18/2016 16:56:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoResult_Repl_InsUpt] ON [dbo].[CotacaoResult] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE CotacaoResult SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModel = CotacaoResult.IDModel
AND
INSERTED.IDFornecedor = CotacaoResult.IDFornecedor
AND
INSERTED.IDCotacao = CotacaoResult.IDCotacao

       UPDATE CotacaoResult SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModel = CotacaoResult.IDModel
AND
DELETED.IDFornecedor = CotacaoResult.IDFornecedor
AND
DELETED.IDCotacao = CotacaoResult.IDCotacao

END
GO

/****** Object:  Trigger [tr_CotacaoToFornec_All]    Script Date: 08/18/2016 16:58:47 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoToFornec_All]'))
DROP TRIGGER [dbo].[tr_CotacaoToFornec_All]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoToFornec_All]    Script Date: 08/18/2016 16:58:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoToFornec_All] ON [dbo].[CotacaoToFornec]
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de CotacaoResult qdo deletado
		- Incluo em CotacaoResult qdo inserido


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN


SET NOCOUNT ON

/*
------------------------------------------------------------------------------------------
	DELECAO
------------------------------------------------------------------------------------------
*/

DELETE
	CotacaoResult
FROM
	Deleted D
WHERE
	CotacaoResult.IDCotacao = D.IDCotacao
	AND
	CotacaoResult.IDFornecedor = D.IDFornecedor

/*
------------------------------------------------------------------------------------------
	INSERCAO
------------------------------------------------------------------------------------------
*/

INSERT  CotacaoResult (
		IDCotacao,
		IDFornecedor,
		IDModel,
		Cost,
                Qty)
	SELECT
		I.IDCotacao,
		I.IDFornecedor,
		CTM.IDModel,
		Null,
		QtyCotada
	FROM
		Inserted I
		JOIN
		CotacaoToModel CTM ON (I.IDCotacao = CTM.IDCotacao)
GO

/****** Object:  Trigger [tr_CotacaoToFornec_Repl_Del]    Script Date: 08/18/2016 17:02:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoToFornec_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CotacaoToFornec_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoToFornec_Repl_Del]    Script Date: 08/18/2016 17:02:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoToFornec_Repl_Del] ON [dbo].[CotacaoToFornec] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CotacaoToFornec', 'DELETE FROM CotacaoToFornec WHERE ' + 'Convert(varchar, IDCotacao)  = ' + QuoteName(Convert(varchar, DELETED.IDCotacao), CHAR(39)) + ' AND ' + 'Convert(varchar, IDFornecedor)  = ' + QuoteName(Convert(varchar, DELETED.IDFornecedor), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CotacaoToFornec_Repl_InsUpt]    Script Date: 08/18/2016 17:03:30 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoToFornec_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_CotacaoToFornec_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoToFornec_Repl_InsUpt]    Script Date: 08/18/2016 17:03:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoToFornec_Repl_InsUpt] ON [dbo].[CotacaoToFornec] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE CotacaoToFornec SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCotacao = CotacaoToFornec.IDCotacao
AND
INSERTED.IDFornecedor = CotacaoToFornec.IDFornecedor

       UPDATE CotacaoToFornec SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCotacao = CotacaoToFornec.IDCotacao
AND
DELETED.IDFornecedor = CotacaoToFornec.IDFornecedor

END
GO

/****** Object:  Trigger [tr_CotacaoToModel_All]    Script Date: 08/18/2016 17:06:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoToModel_All]'))
DROP TRIGGER [dbo].[tr_CotacaoToModel_All]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoToModel_All]    Script Date: 08/18/2016 17:06:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoToModel_All] ON [dbo].[CotacaoToModel]
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de CotacaoResult qdo deletado
		- Incluo em CotacaoResult qdo inserido


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN

SET NOCOUNT ON

/*
------------------------------------------------------------------------------------------
	DELECAO
------------------------------------------------------------------------------------------
*/

DELETE
	CotacaoResult
FROM
	Deleted D
        LEFT OUTER JOIN Inserted I
		ON (D.IDCotacao = I.IDCotacao AND D.IDModel = I.IDModel)
WHERE
	I.IDModel IS NULL
	AND
	CotacaoResult.IDCotacao = D.IDCotacao
	AND
	CotacaoResult.IDModel = D.IDModel

/*
------------------------------------------------------------------------------------------
	INSERCAO
------------------------------------------------------------------------------------------
*/

INSERT 	CotacaoResult (
		IDCotacao,
		IDFornecedor,
		IDModel,
		Cost,
		Qty)
SELECT
	I.IDCotacao,
        CTF.IDFornecedor,
        I.IDModel,
        Null,
	I.QtyCotada
FROM
	Inserted I
        JOIN
	CotacaoToFornec CTF
		ON (I.IDCotacao = CTF.IDCotacao)
        LEFT OUTER JOIN
	Deleted D
		ON (D.IDCotacao = I.IDCotacao AND D.IDModel = I.IDModel)
WHERE
	D.IDModel IS NULL
GO

/****** Object:  Trigger [tr_CotacaoToModel_Repl_Del]    Script Date: 08/18/2016 17:07:46 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoToModel_Repl_Del]'))
DROP TRIGGER [dbo].[tr_CotacaoToModel_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoToModel_Repl_Del]    Script Date: 08/18/2016 17:07:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoToModel_Repl_Del] ON [dbo].[CotacaoToModel] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'CotacaoToModel', 'DELETE FROM CotacaoToModel WHERE ' + 'Convert(varchar, IDCotacao)  = ' + QuoteName(Convert(varchar, DELETED.IDCotacao), CHAR(39)) + ' AND ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_CotacaoToModel_Repl_InsUpt]    Script Date: 08/18/2016 17:08:47 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_CotacaoToModel_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_CotacaoToModel_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_CotacaoToModel_Repl_InsUpt]    Script Date: 08/18/2016 17:08:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_CotacaoToModel_Repl_InsUpt] ON [dbo].[CotacaoToModel] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE CotacaoToModel SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCotacao = CotacaoToModel.IDCotacao
AND
INSERTED.IDModel = CotacaoToModel.IDModel

       UPDATE CotacaoToModel SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCotacao = CotacaoToModel.IDCotacao
AND
DELETED.IDModel = CotacaoToModel.IDModel

END
GO

/****** Object:  Trigger [tr_DailyMaintenanceReport_Repl_Del]    Script Date: 05/13/2016 19:34:29 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_DailyMaintenanceReport_Repl_Del]'))
DROP TRIGGER [dbo].[tr_DailyMaintenanceReport_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_DailyMaintenanceReport_Repl_Del]    Script Date: 05/13/2016 19:34:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_DailyMaintenanceReport_Repl_Del] ON [dbo].[DailyMaintenanceReport] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'DailyMaintenanceReport', 'DELETE FROM DailyMaintenanceReport WHERE ' + 'Convert(varchar, IDDailyMaintenanceReport)  = ' + QuoteName(Convert(varchar, DELETED.IDDailyMaintenanceReport), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_DailyMaintenanceReport_Repl_InsUpt]    Script Date: 05/13/2016 19:35:32 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_DailyMaintenanceReport_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_DailyMaintenanceReport_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_DailyMaintenanceReport_Repl_InsUpt]    Script Date: 05/13/2016 19:35:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_DailyMaintenanceReport_Repl_InsUpt] ON [dbo].[DailyMaintenanceReport] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE DailyMaintenanceReport SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDDailyMaintenanceReport = DailyMaintenanceReport.IDDailyMaintenanceReport

       UPDATE DailyMaintenanceReport SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDDailyMaintenanceReport = DailyMaintenanceReport.IDDailyMaintenanceReport

END
GO

/****** Object:  Trigger [tr_Estimated_Repl_Del]    Script Date: 08/18/2016 17:14:11 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Estimated_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Estimated_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Estimated_Repl_Del]    Script Date: 08/18/2016 17:14:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Estimated_Repl_Del] ON [dbo].[Estimated] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Estimated', 'DELETE FROM Estimated WHERE ' + 'Convert(varchar, IDEstimated)  = ' + QuoteName(Convert(varchar, DELETED.IDEstimated), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Estimated_Repl_InsUpt]    Script Date: 08/18/2016 17:15:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Estimated_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Estimated_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Estimated_Repl_InsUpt]    Script Date: 08/18/2016 17:15:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Estimated_Repl_InsUpt] ON [dbo].[Estimated] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Estimated SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDEstimated = Estimated.IDEstimated

       UPDATE Estimated SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDEstimated = Estimated.IDEstimated

END
GO

/****** Object:  Trigger [tr_EstimatedItem_Repl_Del]    Script Date: 08/18/2016 17:17:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_EstimatedItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_EstimatedItem_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_EstimatedItem_Repl_Del]    Script Date: 08/18/2016 17:17:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_EstimatedItem_Repl_Del] ON [dbo].[EstimatedItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'EstimatedItem', 'DELETE FROM EstimatedItem WHERE ' + 'Convert(varchar, IDEstimatedItem)  = ' + QuoteName(Convert(varchar, DELETED.IDEstimatedItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_EstimatedItem_Repl_InsUpt]    Script Date: 08/18/2016 17:18:56 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_EstimatedItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_EstimatedItem_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_EstimatedItem_Repl_InsUpt]    Script Date: 08/18/2016 17:18:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_EstimatedItem_Repl_InsUpt] ON [dbo].[EstimatedItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE EstimatedItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDEstimatedItem = EstimatedItem.IDEstimatedItem

       UPDATE EstimatedItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDEstimatedItem = EstimatedItem.IDEstimatedItem

END
GO

/****** Object:  Trigger [tr_Fin_ContaCorrenteSaldo_Repl_Del]    Script Date: 08/18/2016 17:22:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_ContaCorrenteSaldo_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_ContaCorrenteSaldo_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Fin_ContaCorrenteSaldo_Repl_Del]    Script Date: 08/18/2016 17:22:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_ContaCorrenteSaldo_Repl_Del] ON [dbo].[Fin_ContaCorrenteSaldo] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_ContaCorrenteSaldo', 'DELETE FROM Fin_ContaCorrenteSaldo WHERE ' + 'Convert(varchar, IDContaCorrente)  = ' + QuoteName(Convert(varchar, DELETED.IDContaCorrente), CHAR(39)) + ' AND ' + 'Convert(varchar, Data)  = ' + QuoteName(Convert(varchar, DELETED.Data), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_ContaCorrenteSaldo_Repl_InsUpt]    Script Date: 08/18/2016 17:23:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_ContaCorrenteSaldo_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fin_ContaCorrenteSaldo_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Fin_ContaCorrenteSaldo_Repl_InsUpt]    Script Date: 08/18/2016 17:23:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_ContaCorrenteSaldo_Repl_InsUpt] ON [dbo].[Fin_ContaCorrenteSaldo] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fin_ContaCorrenteSaldo SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDContaCorrente = Fin_ContaCorrenteSaldo.IDContaCorrente
AND
INSERTED.Data = Fin_ContaCorrenteSaldo.Data

       UPDATE Fin_ContaCorrenteSaldo SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDContaCorrente = Fin_ContaCorrenteSaldo.IDContaCorrente
AND
DELETED.Data = Fin_ContaCorrenteSaldo.Data

END
GO

/****** Object:  Trigger [tr_Fin_LancamentoComplement_Repl_Del]    Script Date: 05/13/2016 19:38:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancamentoComplement_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_LancamentoComplement_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Fin_LancamentoComplement_Repl_Del]    Script Date: 05/13/2016 19:38:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancamentoComplement_Repl_Del] ON [dbo].[Fin_LancamentoComplement] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_LancamentoComplement', 'DELETE FROM Fin_LancamentoComplement WHERE ' + 'Convert(varchar, IDLancamento)  = ' + QuoteName(Convert(varchar, DELETED.IDLancamento), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_LancamentoComplement_Repl_InsUpt]    Script Date: 05/13/2016 19:40:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancamentoComplement_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fin_LancamentoComplement_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Fin_LancamentoComplement_Repl_InsUpt]    Script Date: 05/13/2016 19:40:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancamentoComplement_Repl_InsUpt] ON [dbo].[Fin_LancamentoComplement] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fin_LancamentoComplement SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDLancamento = Fin_LancamentoComplement.IDLancamento

       UPDATE Fin_LancamentoComplement SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDLancamento = Fin_LancamentoComplement.IDLancamento

END
GO

/****** Object:  Trigger [tr_Fin_LancamentoComplement_Repl_Del]    Script Date: 05/13/2016 19:41:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancamentoComplement_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_LancamentoComplement_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Fin_LancamentoComplement_Repl_Del]    Script Date: 05/13/2016 19:41:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancamentoComplement_Repl_Del] ON [dbo].[Fin_LancamentoComplement] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_LancamentoComplement', 'DELETE FROM Fin_LancamentoComplement WHERE ' + 'Convert(varchar, IDLancamento)  = ' + QuoteName(Convert(varchar, DELETED.IDLancamento), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_LancamentoTerm_Repl_Del]    Script Date: 08/18/2016 17:31:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancamentoTerm_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_LancamentoTerm_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Fin_LancamentoTerm_Repl_Del]    Script Date: 08/18/2016 17:31:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancamentoTerm_Repl_Del] ON [dbo].[Fin_LancamentoTerm] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_LancamentoTerm', 'DELETE FROM Fin_LancamentoTerm WHERE ' + 'Convert(varchar, IDLancamento)  = ' + QuoteName(Convert(varchar, DELETED.IDLancamento), CHAR(39)) + ' AND ' + 'Convert(varchar, DueDateShift)  = ' + QuoteName(Convert(varchar, DELETED.DueDateShift), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_LancamentoTerm_Repl_InsUpt]    Script Date: 08/18/2016 17:32:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancamentoTerm_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fin_LancamentoTerm_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Fin_LancamentoTerm_Repl_InsUpt]    Script Date: 08/18/2016 17:32:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancamentoTerm_Repl_InsUpt] ON [dbo].[Fin_LancamentoTerm] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fin_LancamentoTerm SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDLancamento = Fin_LancamentoTerm.IDLancamento
AND
INSERTED.DueDateShift = Fin_LancamentoTerm.DueDateShift

       UPDATE Fin_LancamentoTerm SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDLancamento = Fin_LancamentoTerm.IDLancamento
AND
DELETED.DueDateShift = Fin_LancamentoTerm.DueDateShift

END
GO

/****** Object:  Trigger [tr_Fin_LancQuit_Repl_Del]    Script Date: 08/18/2016 17:34:53 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancQuit_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_LancQuit_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Fin_LancQuit_Repl_Del]    Script Date: 08/18/2016 17:34:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancQuit_Repl_Del] ON [dbo].[Fin_LancQuit] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_LancQuit', 'DELETE FROM Fin_LancQuit WHERE ' + 'Convert(varchar, IDQuitacao)  = ' + QuoteName(Convert(varchar, DELETED.IDQuitacao), CHAR(39)) + ' AND ' + 'Convert(varchar, IDLancamento)  = ' + QuoteName(Convert(varchar, DELETED.IDLancamento), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_LancQuit_Repl_InsUpt]    Script Date: 08/18/2016 17:36:29 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_LancQuit_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fin_LancQuit_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Fin_LancQuit_Repl_InsUpt]    Script Date: 08/18/2016 17:36:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_LancQuit_Repl_InsUpt] ON [dbo].[Fin_LancQuit] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fin_LancQuit SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDQuitacao = Fin_LancQuit.IDQuitacao
AND
INSERTED.IDLancamento = Fin_LancQuit.IDLancamento

       UPDATE Fin_LancQuit SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDQuitacao = Fin_LancQuit.IDQuitacao
AND
DELETED.IDLancamento = Fin_LancQuit.IDLancamento

END
GO

/****** Object:  Trigger [tr_LancQuit_All]    Script Date: 08/18/2016 17:37:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_LancQuit_All]'))
DROP TRIGGER [dbo].[tr_LancQuit_All]
GO

/****** Object:  Trigger [dbo].[tr_LancQuit_All]    Script Date: 08/18/2016 17:37:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_LancQuit_All] ON [dbo].[Fin_LancQuit]
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

/****** Object:  Trigger [tr_Fin_Quitacao_All]    Script Date: 08/18/2016 17:41:44 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_Quitacao_All]'))
DROP TRIGGER [dbo].[tr_Fin_Quitacao_All]
GO

/****** Object:  Trigger [dbo].[tr_Fin_Quitacao_All]    Script Date: 08/18/2016 17:41:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_Quitacao_All] ON [dbo].[Fin_Quitacao]
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o saldo de ContaCorrente


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN

SET NOCOUNT ON

/* -----------------------------------------------------------------
	Comum 
  ----------------------------------------------------------------- */

UPDATE 	
	Fin_ContaCorrente
SET	
	SaldoAtual = IsNull(SaldoAtual,0) - ((D.ValorQuitacao + D.ValorJuros) * (1 - D.Pagando * 2))
FROM	
	Deleted D 
WHERE	
	D.IDContaCorrente <> 0
	AND
	Fin_ContaCorrente.IDContaCorrente = D.IDContaCorrente

/* 
   -----------------------------------------------------------------
	Inclusao 
   ----------------------------------------------------------------- 
*/


UPDATE 	
	Fin_ContaCorrente
SET	
	SaldoAtual = IsNull(SaldoAtual, 0) + ((I.ValorQuitacao + I.ValorJuros) * (1 - I.Pagando * 2))
FROM	
	Inserted I 
WHERE	
	I.IDContaCorrente <> 0
	AND
	Fin_ContaCorrente.IDContaCorrente = I.IDContaCorrente
GO

/****** Object:  Trigger [tr_Fin_Quitacao_Repl_Del]    Script Date: 08/18/2016 18:30:10 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_Quitacao_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_Quitacao_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Fin_Quitacao_Repl_Del]    Script Date: 08/18/2016 18:30:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_Quitacao_Repl_Del] ON [dbo].[Fin_Quitacao] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_Quitacao', 'DELETE FROM Fin_Quitacao WHERE ' + 'Convert(varchar, IDQuitacao)  = ' + QuoteName(Convert(varchar, DELETED.IDQuitacao), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_Quitacao_Repl_InsUpt]    Script Date: 08/18/2016 18:31:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_Quitacao_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fin_Quitacao_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Fin_Quitacao_Repl_InsUpt]    Script Date: 08/18/2016 18:31:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_Quitacao_Repl_InsUpt] ON [dbo].[Fin_Quitacao] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fin_Quitacao SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDQuitacao = Fin_Quitacao.IDQuitacao

       UPDATE Fin_Quitacao SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDQuitacao = Fin_Quitacao.IDQuitacao

END
GO

/****** Object:  Trigger [tr_Fin_Transferencia_Repl_Del]    Script Date: 08/18/2016 18:36:44 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_Transferencia_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fin_Transferencia_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Fin_Transferencia_Repl_Del]    Script Date: 08/18/2016 18:36:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_Transferencia_Repl_Del] ON [dbo].[Fin_Transferencia] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fin_Transferencia', 'DELETE FROM Fin_Transferencia WHERE ' + 'Convert(varchar, IDTransferencia)  = ' + QuoteName(Convert(varchar, DELETED.IDTransferencia), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fin_Transferencia_Repl_InsUpt]    Script Date: 08/18/2016 18:38:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fin_Transferencia_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fin_Transferencia_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Fin_Transferencia_Repl_InsUpt]    Script Date: 08/18/2016 18:38:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fin_Transferencia_Repl_InsUpt] ON [dbo].[Fin_Transferencia] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fin_Transferencia SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDTransferencia = Fin_Transferencia.IDTransferencia

       UPDATE Fin_Transferencia SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDTransferencia = Fin_Transferencia.IDTransferencia

END
GO

/****** Object:  Trigger [tr_Fis_Registro60Analitico_Repl_InsUpt]    Script Date: 05/13/2016 19:48:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60Analitico_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60Analitico_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60Analitico_Repl_InsUpt]    Script Date: 05/13/2016 19:48:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60Analitico_Repl_InsUpt] ON [dbo].[Fis_Registro60Analitico] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fis_Registro60Analitico SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Fis_Registro60Analitico SET ReplLastChange = GETDATE() FROM DELETED  
END
GO

/****** Object:  Trigger [tr_Fis_Registro60Item_Repl_Del]    Script Date: 05/13/2016 19:50:51 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60Item_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60Item_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60Item_Repl_Del]    Script Date: 05/13/2016 19:50:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60Item_Repl_Del] ON [dbo].[Fis_Registro60Item] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fis_Registro60Item', 'DELETE FROM Fis_Registro60Item WHERE ' + 'Convert(varchar, DataEmissao)  = ' + QuoteName(Convert(varchar, DELETED.DataEmissao), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroSerie)  = ' + QuoteName(Convert(varchar, DELETED.NumeroSerie), CHAR(39)) + ' AND ' + 'Convert(varchar, ModeloDocumentoFiscal)  = ' + QuoteName(Convert(varchar, DELETED.ModeloDocumentoFiscal), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroOrdem)  = ' + QuoteName(Convert(varchar, DELETED.NumeroOrdem), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroItem)  = ' + QuoteName(Convert(varchar, DELETED.NumeroItem), CHAR(39)) + ' AND ' + 'Convert(varchar, CodigoProdutoServico)  = ' + QuoteName(Convert(varchar, DELETED.CodigoProdutoServico), CHAR(39)) + ' AND ' + 'Convert(varchar, ValorUnitario)  = ' + QuoteName(Convert(varchar, DELETED.ValorUnitario), CHAR(39)) + ' AND ' + 'Convert(varchar, BaseCalculoICMS)  = ' + QuoteName(Convert(varchar, DELETED.BaseCalculoICMS), CHAR(39)) + ' AND ' + 'Convert(varchar, SituacaoTributaria)  = ' + QuoteName(Convert(varchar, DELETED.SituacaoTributaria), CHAR(39)) + ' AND ' + 'Convert(varchar, ValorICMS)  = ' + QuoteName(Convert(varchar, DELETED.ValorICMS), CHAR(39)) + ' AND ' + 'Convert(varchar, Qtde)  = ' + QuoteName(Convert(varchar, DELETED.Qtde), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fis_Registro60Item_Repl_InsUpt]    Script Date: 05/13/2016 19:52:16 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60Item_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60Item_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60Item_Repl_InsUpt]    Script Date: 05/13/2016 19:52:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60Item_Repl_InsUpt] ON [dbo].[Fis_Registro60Item] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fis_Registro60Item SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Fis_Registro60Item SET ReplLastChange = GETDATE() FROM DELETED  
END
GO

/****** Object:  Trigger [tr_Fis_Registro60Mestre_Repl_Del]    Script Date: 05/13/2016 19:55:30 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60Mestre_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60Mestre_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60Mestre_Repl_Del]    Script Date: 05/13/2016 19:55:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60Mestre_Repl_Del] ON [dbo].[Fis_Registro60Mestre] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fis_Registro60Mestre', 'DELETE FROM Fis_Registro60Mestre WHERE ' + 'Convert(varchar, DataEmissao)  = ' + QuoteName(Convert(varchar, DELETED.DataEmissao), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroSerie)  = ' + QuoteName(Convert(varchar, DELETED.NumeroSerie), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroOrdem)  = ' + QuoteName(Convert(varchar, DELETED.NumeroOrdem), CHAR(39)) + ' AND ' + 'Convert(varchar, ModeloDocumentoFiscal)  = ' + QuoteName(Convert(varchar, DELETED.ModeloDocumentoFiscal), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroInicialDia)  = ' + QuoteName(Convert(varchar, DELETED.NumeroInicialDia), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroFinalDia)  = ' + QuoteName(Convert(varchar, DELETED.NumeroFinalDia), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroReducao)  = ' + QuoteName(Convert(varchar, DELETED.NumeroReducao), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroReinicioOperacao)  = ' + QuoteName(Convert(varchar, DELETED.NumeroReinicioOperacao), CHAR(39)) + ' AND ' + 'Convert(varchar, ValorVendaBruta)  = ' + QuoteName(Convert(varchar, DELETED.ValorVendaBruta), CHAR(39)) + ' AND ' + 'Convert(varchar, ValorTotalGeral)  = ' + QuoteName(Convert(varchar, DELETED.ValorTotalGeral), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fis_Registro60Mestre_Repl_InsUpt]    Script Date: 05/13/2016 19:56:48 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60Mestre_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60Mestre_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60Mestre_Repl_InsUpt]    Script Date: 05/13/2016 19:56:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60Mestre_Repl_InsUpt] ON [dbo].[Fis_Registro60Mestre] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fis_Registro60Mestre SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Fis_Registro60Mestre SET ReplLastChange = GETDATE() FROM DELETED  
END
GO

/****** Object:  Trigger [tr_Fis_Registro60ResumoDiario_Repl_Del]    Script Date: 05/13/2016 19:59:31 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60ResumoDiario_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60ResumoDiario_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60ResumoDiario_Repl_Del]    Script Date: 05/13/2016 19:59:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60ResumoDiario_Repl_Del] ON [dbo].[Fis_Registro60ResumoDiario] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Fis_Registro60ResumoDiario', 'DELETE FROM Fis_Registro60ResumoDiario WHERE ' + 'Convert(varchar, DataEmissao)  = ' + QuoteName(Convert(varchar, DELETED.DataEmissao), CHAR(39)) + ' AND ' + 'Convert(varchar, NumeroSerie)  = ' + QuoteName(Convert(varchar, DELETED.NumeroSerie), CHAR(39)) + ' AND ' + 'Convert(varchar, CodigoProdutoServico)  = ' + QuoteName(Convert(varchar, DELETED.CodigoProdutoServico), CHAR(39)) + ' AND ' + 'Convert(varchar, ValorProdutoServico)  = ' + QuoteName(Convert(varchar, DELETED.ValorProdutoServico), CHAR(39)) + ' AND ' + 'Convert(varchar, BaseCalculoICMS)  = ' + QuoteName(Convert(varchar, DELETED.BaseCalculoICMS), CHAR(39)) + ' AND ' + 'Convert(varchar, ValorICMS)  = ' + QuoteName(Convert(varchar, DELETED.ValorICMS), CHAR(39)) + ' AND ' + 'Convert(varchar, SituacaoTributaria)  = ' + QuoteName(Convert(varchar, DELETED.SituacaoTributaria), CHAR(39)) + ' AND ' + 'Convert(varchar, Qtde)  = ' + QuoteName(Convert(varchar, DELETED.Qtde), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Fis_Registro60ResumoDiario_Repl_InsUpt]    Script Date: 05/13/2016 20:00:49 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Fis_Registro60ResumoDiario_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Fis_Registro60ResumoDiario_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Fis_Registro60ResumoDiario_Repl_InsUpt]    Script Date: 05/13/2016 20:00:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Fis_Registro60ResumoDiario_Repl_InsUpt] ON [dbo].[Fis_Registro60ResumoDiario] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Fis_Registro60ResumoDiario SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Fis_Registro60ResumoDiario SET ReplLastChange = GETDATE() FROM DELETED  
END
GO


/****** Object:  Trigger [tr_GroupCost_Repl_Del]    Script Date: 08/18/2016 18:43:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_GroupCost_Repl_Del]'))
DROP TRIGGER [dbo].[tr_GroupCost_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_GroupCost_Repl_Del]    Script Date: 08/18/2016 18:43:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_GroupCost_Repl_Del] ON [dbo].[GroupCost] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'GroupCost', 'DELETE FROM GroupCost WHERE ' + 'Convert(varchar, IDCost)  = ' + QuoteName(Convert(varchar, DELETED.IDCost), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_GroupCost_Repl_InsUpt]    Script Date: 08/18/2016 18:44:54 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_GroupCost_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_GroupCost_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_GroupCost_Repl_InsUpt]    Script Date: 08/18/2016 18:44:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_GroupCost_Repl_InsUpt] ON [dbo].[GroupCost] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE GroupCost SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCost = GroupCost.IDCost

       UPDATE GroupCost SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCost = GroupCost.IDCost

END
GO

/****** Object:  Trigger [tr_GroupCostGift_Repl_Del]    Script Date: 08/18/2016 18:47:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_GroupCostGift_Repl_Del]'))
DROP TRIGGER [dbo].[tr_GroupCostGift_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_GroupCostGift_Repl_Del]    Script Date: 08/18/2016 18:47:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_GroupCostGift_Repl_Del] ON [dbo].[GroupCostGift] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'GroupCostGift', 'DELETE FROM GroupCostGift WHERE ' + 'Convert(varchar, IDGroupCostGift)  = ' + QuoteName(Convert(varchar, DELETED.IDGroupCostGift), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_GroupCostGift_Repl_InsUpt]    Script Date: 08/18/2016 18:48:11 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_GroupCostGift_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_GroupCostGift_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_GroupCostGift_Repl_InsUpt]    Script Date: 08/18/2016 18:48:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_GroupCostGift_Repl_InsUpt] ON [dbo].[GroupCostGift] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE GroupCostGift SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDGroupCostGift = GroupCostGift.IDGroupCostGift

       UPDATE GroupCostGift SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDGroupCostGift = GroupCostGift.IDGroupCostGift

END
GO

/****** Object:  Trigger [tr_Inv_BarcodePrint_Repl_Del]    Script Date: 05/13/2016 20:02:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_BarcodePrint_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_BarcodePrint_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_BarcodePrint_Repl_Del]    Script Date: 05/13/2016 20:02:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_BarcodePrint_Repl_Del] ON [dbo].[Inv_BarcodePrint] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_BarcodePrint', 'DELETE FROM Inv_BarcodePrint WHERE ' + 'Convert(varchar, IDBarcode)  = ' + QuoteName(Convert(varchar, DELETED.IDBarcode), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_BarcodePrint_Repl_InsUpt]    Script Date: 05/13/2016 20:06:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_BarcodePrint_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_BarcodePrint_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_BarcodePrint_Repl_InsUpt]    Script Date: 05/13/2016 20:06:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_BarcodePrint_Repl_InsUpt] ON [dbo].[Inv_BarcodePrint] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_BarcodePrint SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDBarcode = Inv_BarcodePrint.IDBarcode

       UPDATE Inv_BarcodePrint SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDBarcode = Inv_BarcodePrint.IDBarcode

END
GO

/****** Object:  Trigger [tr_Inv_BarcodePrintSearch_Repl_Del]    Script Date: 05/13/2016 20:15:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_BarcodePrintSearch_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_BarcodePrintSearch_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_BarcodePrintSearch_Repl_Del]    Script Date: 05/13/2016 20:15:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_BarcodePrintSearch_Repl_Del] ON [dbo].[Inv_BarcodePrintSearch] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_BarcodePrintSearch', 'DELETE FROM Inv_BarcodePrintSearch WHERE ' + 'Convert(varchar, sequence)  = ' + QuoteName(Convert(varchar, DELETED.sequence), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_BarcodePrintSearch_Repl_InsUpt]    Script Date: 05/13/2016 20:16:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_BarcodePrintSearch_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_BarcodePrintSearch_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_BarcodePrintSearch_Repl_InsUpt]    Script Date: 05/13/2016 20:16:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_BarcodePrintSearch_Repl_InsUpt] ON [dbo].[Inv_BarcodePrintSearch] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_BarcodePrintSearch SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.sequence = Inv_BarcodePrintSearch.sequence

       UPDATE Inv_BarcodePrintSearch SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.sequence = Inv_BarcodePrintSearch.sequence

END
GO

/****** Object:  Trigger [tr_Inv_Count_Repl_Del]    Script Date: 05/13/2016 20:17:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_Count_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_Count_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_Count_Repl_Del]    Script Date: 05/13/2016 20:17:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_Count_Repl_Del] ON [dbo].[Inv_Count] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_Count', 'DELETE FROM Inv_Count WHERE ' + 'Convert(varchar, IDCount)  = ' + QuoteName(Convert(varchar, DELETED.IDCount), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_Count_Repl_InsUpt]    Script Date: 05/13/2016 20:18:54 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_Count_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_Count_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_Count_Repl_InsUpt]    Script Date: 05/13/2016 20:18:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_Count_Repl_InsUpt] ON [dbo].[Inv_Count] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_Count SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCount = Inv_Count.IDCount

       UPDATE Inv_Count SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCount = Inv_Count.IDCount

END
GO

/****** Object:  Trigger [tr_Inv_CountItem_Repl_Del]    Script Date: 05/13/2016 20:20:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_CountItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_CountItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_CountItem_Repl_Del]    Script Date: 05/13/2016 20:20:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_CountItem_Repl_Del] ON [dbo].[Inv_CountItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_CountItem', 'DELETE FROM Inv_CountItem WHERE ' + 'Convert(varchar, IDCountItem)  = ' + QuoteName(Convert(varchar, DELETED.IDCountItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_CountItem_Repl_InsUpt]    Script Date: 05/13/2016 20:21:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_CountItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_CountItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_CountItem_Repl_InsUpt]    Script Date: 05/13/2016 20:21:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_CountItem_Repl_InsUpt] ON [dbo].[Inv_CountItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_CountItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCountItem = Inv_CountItem.IDCountItem

       UPDATE Inv_CountItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCountItem = Inv_CountItem.IDCountItem

END
GO

/****** Object:  Trigger [tr_Inv_DescriptionPrice_Repl_Del]    Script Date: 05/13/2016 20:22:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_DescriptionPrice_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_DescriptionPrice_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_DescriptionPrice_Repl_Del]    Script Date: 05/13/2016 20:22:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_DescriptionPrice_Repl_Del] ON [dbo].[Inv_DescriptionPrice] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_DescriptionPrice', 'DELETE FROM Inv_DescriptionPrice WHERE ' + 'Convert(varchar, IDDescriptionPrice)  = ' + QuoteName(Convert(varchar, DELETED.IDDescriptionPrice), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_DescriptionPrice_Repl_InsUpt]    Script Date: 05/13/2016 20:23:38 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_DescriptionPrice_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_DescriptionPrice_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_DescriptionPrice_Repl_InsUpt]    Script Date: 05/13/2016 20:23:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_DescriptionPrice_Repl_InsUpt] ON [dbo].[Inv_DescriptionPrice] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_DescriptionPrice SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDDescriptionPrice = Inv_DescriptionPrice.IDDescriptionPrice

       UPDATE Inv_DescriptionPrice SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDDescriptionPrice = Inv_DescriptionPrice.IDDescriptionPrice

END
GO

/****** Object:  Trigger [tr_Inv_FrozeCount_Repl_Del]    Script Date: 08/18/2016 19:00:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_FrozeCount_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_FrozeCount_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Inv_FrozeCount_Repl_Del]    Script Date: 08/18/2016 19:00:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_FrozeCount_Repl_Del] ON [dbo].[Inv_FrozeCount] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_FrozeCount', 'DELETE FROM Inv_FrozeCount WHERE ' + 'Convert(varchar, IDCount)  = ' + QuoteName(Convert(varchar, DELETED.IDCount), CHAR(39)) + ' AND ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_FrozeCount_Repl_InsUpt]    Script Date: 05/13/2016 20:26:43 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_FrozeCount_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_FrozeCount_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_FrozeCount_Repl_InsUpt]    Script Date: 05/13/2016 20:26:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_FrozeCount_Repl_InsUpt] ON [dbo].[Inv_FrozeCount] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_FrozeCount SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCount = Inv_FrozeCount.IDCount
AND
INSERTED.IDModel = Inv_FrozeCount.IDModel

       UPDATE Inv_FrozeCount SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCount = Inv_FrozeCount.IDCount
AND
DELETED.IDModel = Inv_FrozeCount.IDModel

END
GO

/****** Object:  Trigger [tr_Inv_Lot_Repl_Del]    Script Date: 05/16/2016 12:41:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_Lot_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_Lot_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_Lot_Repl_Del]    Script Date: 05/16/2016 12:41:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_Lot_Repl_Del] ON [dbo].[Inv_Lot] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_Lot', 'DELETE FROM Inv_Lot WHERE ' + 'Convert(varchar, IDLote)  = ' + QuoteName(Convert(varchar, DELETED.IDLote), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_Lot_Repl_InsUpt]    Script Date: 05/16/2016 15:17:53 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_Lot_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_Lot_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_Lot_Repl_InsUpt]    Script Date: 05/16/2016 15:17:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_Lot_Repl_InsUpt] ON [dbo].[Inv_Lot] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_Lot SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDLote = Inv_Lot.IDLote

       UPDATE Inv_Lot SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDLote = Inv_Lot.IDLote

END
GO

/****** Object:  Trigger [tr_Inv_ModelBalance_Repl_Del]    Script Date: 05/16/2016 15:18:56 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelBalance_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_ModelBalance_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelBalance_Repl_Del]    Script Date: 05/16/2016 15:18:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelBalance_Repl_Del] ON [dbo].[Inv_ModelBalance] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_ModelBalance', 'DELETE FROM Inv_ModelBalance WHERE ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, BalanceDate)  = ' + QuoteName(Convert(varchar, DELETED.BalanceDate), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_ModelBalance_Repl_InsUpt]    Script Date: 05/16/2016 15:19:40 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelBalance_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_ModelBalance_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelBalance_Repl_InsUpt]    Script Date: 05/16/2016 15:19:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelBalance_Repl_InsUpt] ON [dbo].[Inv_ModelBalance] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_ModelBalance SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModel = Inv_ModelBalance.IDModel
AND
INSERTED.BalanceDate = Inv_ModelBalance.BalanceDate

       UPDATE Inv_ModelBalance SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModel = Inv_ModelBalance.IDModel
AND
DELETED.BalanceDate = Inv_ModelBalance.BalanceDate

END
GO

/****** Object:  Trigger [tr_Inv_ModelNutrition_Repl_Del]    Script Date: 05/16/2016 15:20:47 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelNutrition_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_ModelNutrition_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelNutrition_Repl_Del]    Script Date: 05/16/2016 15:20:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelNutrition_Repl_Del] ON [dbo].[Inv_ModelNutrition] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_ModelNutrition', 'DELETE FROM Inv_ModelNutrition WHERE ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, IDNutritionItem)  = ' + QuoteName(Convert(varchar, DELETED.IDNutritionItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_ModelNutrition_Repl_InsUpt]    Script Date: 05/16/2016 15:21:45 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelNutrition_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_ModelNutrition_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelNutrition_Repl_InsUpt]    Script Date: 05/16/2016 15:21:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelNutrition_Repl_InsUpt] ON [dbo].[Inv_ModelNutrition] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_ModelNutrition SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModel = Inv_ModelNutrition.IDModel
AND
INSERTED.IDNutritionItem = Inv_ModelNutrition.IDNutritionItem

       UPDATE Inv_ModelNutrition SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModel = Inv_ModelNutrition.IDModel
AND
DELETED.IDNutritionItem = Inv_ModelNutrition.IDNutritionItem

END
GO

/****** Object:  Trigger [tr_Inv_ModelPrice_Repl_Del]    Script Date: 05/16/2016 15:22:57 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelPrice_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_ModelPrice_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelPrice_Repl_Del]    Script Date: 05/16/2016 15:22:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelPrice_Repl_Del] ON [dbo].[Inv_ModelPrice] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_ModelPrice', 'DELETE FROM Inv_ModelPrice WHERE ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, IDDescriptionPrice)  = ' + QuoteName(Convert(varchar, DELETED.IDDescriptionPrice), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_ModelPrice_Repl_InsUpt]    Script Date: 05/16/2016 15:23:52 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelPrice_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_ModelPrice_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelPrice_Repl_InsUpt]    Script Date: 05/16/2016 15:23:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelPrice_Repl_InsUpt] ON [dbo].[Inv_ModelPrice] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_ModelPrice SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModel = Inv_ModelPrice.IDModel
AND
INSERTED.IDDescriptionPrice = Inv_ModelPrice.IDDescriptionPrice

       UPDATE Inv_ModelPrice SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModel = Inv_ModelPrice.IDModel
AND
DELETED.IDDescriptionPrice = Inv_ModelPrice.IDDescriptionPrice

END
GO

/****** Object:  Trigger [tr_Inv_ModelStateTax_Repl_Del]    Script Date: 05/16/2016 15:25:11 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelStateTax_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_ModelStateTax_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelStateTax_Repl_Del]    Script Date: 05/16/2016 15:25:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelStateTax_Repl_Del] ON [dbo].[Inv_ModelStateTax] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_ModelStateTax', 'DELETE FROM Inv_ModelStateTax WHERE ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, IDEstado)  = ' + QuoteName(Convert(varchar, DELETED.IDEstado), CHAR(39)) + ' AND ' + 'Convert(varchar, IDTaxCategory)  = ' + QuoteName(Convert(varchar, DELETED.IDTaxCategory), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_ModelStateTax_Repl_InsUpt]    Script Date: 05/16/2016 15:26:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelStateTax_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_ModelStateTax_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelStateTax_Repl_InsUpt]    Script Date: 05/16/2016 15:26:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelStateTax_Repl_InsUpt] ON [dbo].[Inv_ModelStateTax] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_ModelStateTax SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModel = Inv_ModelStateTax.IDModel
AND
INSERTED.IDEstado = Inv_ModelStateTax.IDEstado
AND
INSERTED.IDTaxCategory = Inv_ModelStateTax.IDTaxCategory

       UPDATE Inv_ModelStateTax SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModel = Inv_ModelStateTax.IDModel
AND
DELETED.IDEstado = Inv_ModelStateTax.IDEstado
AND
DELETED.IDTaxCategory = Inv_ModelStateTax.IDTaxCategory

END
GO

/****** Object:  Trigger [tr_Inv_ModelStoreBalance_Repl_Del]    Script Date: 08/19/2016 14:59:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelStoreBalance_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_ModelStoreBalance_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Inv_ModelStoreBalance_Repl_Del]    Script Date: 08/19/2016 14:59:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelStoreBalance_Repl_Del] ON [dbo].[Inv_ModelStoreBalance] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_ModelStoreBalance', 'DELETE FROM Inv_ModelStoreBalance WHERE ' + 'Convert(varchar, IDStore)  = ' + QuoteName(Convert(varchar, DELETED.IDStore), CHAR(39)) + ' AND ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, BalanceDate)  = ' + QuoteName(Convert(varchar, DELETED.BalanceDate), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_ModelStoreBalance_Repl_InsUpt]    Script Date: 05/16/2016 16:53:38 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_ModelStoreBalance_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_ModelStoreBalance_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_ModelStoreBalance_Repl_InsUpt]    Script Date: 05/16/2016 16:53:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_ModelStoreBalance_Repl_InsUpt] ON [dbo].[Inv_ModelStoreBalance] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_ModelStoreBalance SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDStore = Inv_ModelStoreBalance.IDStore
AND
INSERTED.IDModel = Inv_ModelStoreBalance.IDModel
AND
INSERTED.BalanceDate = Inv_ModelStoreBalance.BalanceDate

       UPDATE Inv_ModelStoreBalance SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDStore = Inv_ModelStoreBalance.IDStore
AND
DELETED.IDModel = Inv_ModelStoreBalance.IDModel
AND
DELETED.BalanceDate = Inv_ModelStoreBalance.BalanceDate

END
GO

/****** Object:  Trigger [tr_Inv_MovComplement_Repl_Del]    Script Date: 08/18/2016 19:05:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_MovComplement_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_MovComplement_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Inv_MovComplement_Repl_Del]    Script Date: 08/18/2016 19:05:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_MovComplement_Repl_Del] ON [dbo].[Inv_MovComplement] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_MovComplement', 'DELETE FROM Inv_MovComplement WHERE ' + 'Convert(varchar, IDInventoryMov)  = ' + QuoteName(Convert(varchar, DELETED.IDInventoryMov), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_MovComplement_Repl_InsUpt]    Script Date: 08/18/2016 19:10:00 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_MovComplement_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_MovComplement_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Inv_MovComplement_Repl_InsUpt]    Script Date: 08/18/2016 19:10:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_MovComplement_Repl_InsUpt] ON [dbo].[Inv_MovComplement] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_MovComplement SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDInventoryMov = Inv_MovComplement.IDInventoryMov

       UPDATE Inv_MovComplement SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDInventoryMov = Inv_MovComplement.IDInventoryMov

END
GO

/****** Object:  Trigger [tr_Inv_MovDocument_Repl_Del]    Script Date: 08/18/2016 19:12:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_MovDocument_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_MovDocument_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Inv_MovDocument_Repl_Del]    Script Date: 08/18/2016 19:12:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_MovDocument_Repl_Del] ON [dbo].[Inv_MovDocument] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_MovDocument', 'DELETE FROM Inv_MovDocument WHERE ' + 'Convert(varchar, IDMovDocument)  = ' + QuoteName(Convert(varchar, DELETED.IDMovDocument), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_MovDocument_Repl_InsUpt]    Script Date: 08/18/2016 19:13:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_MovDocument_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_MovDocument_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Inv_MovDocument_Repl_InsUpt]    Script Date: 08/18/2016 19:13:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_MovDocument_Repl_InsUpt] ON [dbo].[Inv_MovDocument] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_MovDocument SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMovDocument = Inv_MovDocument.IDMovDocument

       UPDATE Inv_MovDocument SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMovDocument = Inv_MovDocument.IDMovDocument

END
GO

/****** Object:  Trigger [tr_Inv_MovPrice_Repl_Del]    Script Date: 08/18/2016 19:14:57 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_MovPrice_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_MovPrice_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Inv_MovPrice_Repl_Del]    Script Date: 08/18/2016 19:14:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_MovPrice_Repl_Del] ON [dbo].[Inv_MovPrice] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_MovPrice', 'DELETE FROM Inv_MovPrice WHERE ' + 'Convert(varchar, IDMovPrice)  = ' + QuoteName(Convert(varchar, DELETED.IDMovPrice), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_MovPrice_Repl_InsUpt]    Script Date: 08/18/2016 19:15:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_MovPrice_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_MovPrice_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Inv_MovPrice_Repl_InsUpt]    Script Date: 08/18/2016 19:15:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_MovPrice_Repl_InsUpt] ON [dbo].[Inv_MovPrice] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_MovPrice SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMovPrice = Inv_MovPrice.IDMovPrice

       UPDATE Inv_MovPrice SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMovPrice = Inv_MovPrice.IDMovPrice

END
GO

/****** Object:  Trigger [tr_Inv_NCM_Repl_Del]    Script Date: 05/16/2016 16:54:49 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_NCM_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_NCM_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_NCM_Repl_Del]    Script Date: 05/16/2016 16:54:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_NCM_Repl_Del] ON [dbo].[Inv_NCM] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_NCM', 'DELETE FROM Inv_NCM WHERE ' + 'Convert(varchar, IDNCM)  = ' + QuoteName(Convert(varchar, DELETED.IDNCM), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_NCM_Repl_InsUpt]    Script Date: 05/16/2016 16:55:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_NCM_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_NCM_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_NCM_Repl_InsUpt]    Script Date: 05/16/2016 16:55:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_NCM_Repl_InsUpt] ON [dbo].[Inv_NCM] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_NCM SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDNCM = Inv_NCM.IDNCM

       UPDATE Inv_NCM SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDNCM = Inv_NCM.IDNCM

END
GO

/****** Object:  Trigger [tr_Inv_Nutrition_Repl_Del]    Script Date: 05/16/2016 16:56:57 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_Nutrition_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_Nutrition_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_Nutrition_Repl_Del]    Script Date: 05/16/2016 16:56:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_Nutrition_Repl_Del] ON [dbo].[Inv_Nutrition] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_Nutrition', 'DELETE FROM Inv_Nutrition WHERE ' + 'Convert(varchar, IDNutrition)  = ' + QuoteName(Convert(varchar, DELETED.IDNutrition), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_Nutrition_Repl_InsUpt]    Script Date: 05/16/2016 16:57:50 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_Nutrition_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_Nutrition_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_Nutrition_Repl_InsUpt]    Script Date: 05/16/2016 16:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_Nutrition_Repl_InsUpt] ON [dbo].[Inv_Nutrition] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_Nutrition SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDNutrition = Inv_Nutrition.IDNutrition

       UPDATE Inv_Nutrition SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDNutrition = Inv_Nutrition.IDNutrition

END
GO

/****** Object:  Trigger [tr_Inv_NutritionItem_Repl_Del]    Script Date: 05/16/2016 17:23:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_NutritionItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_NutritionItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_NutritionItem_Repl_Del]    Script Date: 05/16/2016 17:23:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_NutritionItem_Repl_Del] ON [dbo].[Inv_NutritionItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_NutritionItem', 'DELETE FROM Inv_NutritionItem WHERE ' + 'Convert(varchar, IDNutritionItem)  = ' + QuoteName(Convert(varchar, DELETED.IDNutritionItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_NutritionItem_Repl_InsUpt]    Script Date: 05/16/2016 17:24:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_NutritionItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_NutritionItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_NutritionItem_Repl_InsUpt]    Script Date: 05/16/2016 17:24:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_NutritionItem_Repl_InsUpt] ON [dbo].[Inv_NutritionItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_NutritionItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDNutritionItem = Inv_NutritionItem.IDNutritionItem

       UPDATE Inv_NutritionItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDNutritionItem = Inv_NutritionItem.IDNutritionItem

END
GO

/****** Object:  Trigger [tr_Inv_StoreModelLot_Repl_Del]    Script Date: 05/16/2016 17:24:49 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_StoreModelLot_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_StoreModelLot_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_StoreModelLot_Repl_Del]    Script Date: 05/16/2016 17:24:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_StoreModelLot_Repl_Del] ON [dbo].[Inv_StoreModelLot] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_StoreModelLot', 'DELETE FROM Inv_StoreModelLot WHERE ' + 'Convert(varchar, IDLote)  = ' + QuoteName(Convert(varchar, DELETED.IDLote), CHAR(39)) + ' AND ' + 'Convert(varchar, IDStore)  = ' + QuoteName(Convert(varchar, DELETED.IDStore), CHAR(39)) + ' AND ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Inv_StoreModelLot_Repl_InsUpt]    Script Date: 05/16/2016 17:25:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_StoreModelLot_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_StoreModelLot_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_StoreModelLot_Repl_InsUpt]    Script Date: 05/16/2016 17:25:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_StoreModelLot_Repl_InsUpt] ON [dbo].[Inv_StoreModelLot] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_StoreModelLot SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDLote = Inv_StoreModelLot.IDLote
AND
INSERTED.IDStore = Inv_StoreModelLot.IDStore
AND
INSERTED.IDModel = Inv_StoreModelLot.IDModel

       UPDATE Inv_StoreModelLot SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDLote = Inv_StoreModelLot.IDLote
AND
DELETED.IDStore = Inv_StoreModelLot.IDStore
AND
DELETED.IDModel = Inv_StoreModelLot.IDModel

END
GO

/****** Object:  Trigger [tr_Inv_StorePrice_Repl_Del]    Script Date: 05/16/2016 17:26:40 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_StorePrice_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Inv_StorePrice_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Inv_StorePrice_Repl_Del]    Script Date: 05/16/2016 17:26:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_StorePrice_Repl_Del] ON [dbo].[Inv_StorePrice] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Inv_StorePrice', 'DELETE FROM Inv_StorePrice WHERE ' + 'Convert(varchar, IDStore)  = ' + QuoteName(Convert(varchar, DELETED.IDStore), CHAR(39)) + ' AND ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)) + ' AND ' + 'Convert(varchar, IDDescriptionPrice)  = ' + QuoteName(Convert(varchar, DELETED.IDDescriptionPrice), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Inv_StorePrice_Repl_InsUpt]    Script Date: 05/16/2016 17:27:18 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Inv_StorePrice_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Inv_StorePrice_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Inv_StorePrice_Repl_InsUpt]    Script Date: 05/16/2016 17:27:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Inv_StorePrice_Repl_InsUpt] ON [dbo].[Inv_StorePrice] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Inv_StorePrice SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDStore = Inv_StorePrice.IDStore
AND
INSERTED.IDModel = Inv_StorePrice.IDModel
AND
INSERTED.IDDescriptionPrice = Inv_StorePrice.IDDescriptionPrice

       UPDATE Inv_StorePrice SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDStore = Inv_StorePrice.IDStore
AND
DELETED.IDModel = Inv_StorePrice.IDModel
AND
DELETED.IDDescriptionPrice = Inv_StorePrice.IDDescriptionPrice

END
GO

/****** Object:  Trigger [tr_InventoryMovTax_Repl_Del]    Script Date: 08/18/2016 19:21:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InventoryMovTax_Repl_Del]'))
DROP TRIGGER [dbo].[tr_InventoryMovTax_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_InventoryMovTax_Repl_Del]    Script Date: 08/18/2016 19:21:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InventoryMovTax_Repl_Del] ON [dbo].[InventoryMovTax] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'InventoryMovTax', 'DELETE FROM InventoryMovTax WHERE ' + 'Convert(varchar, IDInventoryMov)  = ' + QuoteName(Convert(varchar, DELETED.IDInventoryMov), CHAR(39)) + ' AND ' + 'Convert(varchar, IDTaxCategory)  = ' + QuoteName(Convert(varchar, DELETED.IDTaxCategory), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_InventoryMovTax_Repl_InsUpt]    Script Date: 08/18/2016 19:24:43 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InventoryMovTax_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_InventoryMovTax_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_InventoryMovTax_Repl_InsUpt]    Script Date: 08/18/2016 19:24:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InventoryMovTax_Repl_InsUpt] ON [dbo].[InventoryMovTax] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE InventoryMovTax SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDInventoryMov = InventoryMovTax.IDInventoryMov
AND
INSERTED.IDTaxCategory = InventoryMovTax.IDTaxCategory

       UPDATE InventoryMovTax SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDInventoryMov = InventoryMovTax.IDInventoryMov
AND
DELETED.IDTaxCategory = InventoryMovTax.IDTaxCategory

END
GO

/****** Object:  Trigger [tr_InventorySerial_Repl_Del]    Script Date: 08/18/2016 19:29:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InventorySerial_Repl_Del]'))
DROP TRIGGER [dbo].[tr_InventorySerial_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_InventorySerial_Repl_Del]    Script Date: 08/18/2016 19:29:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InventorySerial_Repl_Del] ON [dbo].[InventorySerial] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'InventorySerial', 'DELETE FROM InventorySerial WHERE ' + 'Convert(varchar, StoreID)  = ' + QuoteName(Convert(varchar, DELETED.StoreID), CHAR(39)) + ' AND ' + 'Convert(varchar, ModelID)  = ' + QuoteName(Convert(varchar, DELETED.ModelID), CHAR(39)) + ' AND ' + 'Convert(varchar, Serial)  = ' + QuoteName(Convert(varchar, DELETED.Serial), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_InventorySerial_Repl_InsUpt]    Script Date: 08/18/2016 19:32:46 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InventorySerial_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_InventorySerial_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_InventorySerial_Repl_InsUpt]    Script Date: 08/18/2016 19:32:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InventorySerial_Repl_InsUpt] ON [dbo].[InventorySerial] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE InventorySerial SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.StoreID = InventorySerial.StoreID
AND
INSERTED.ModelID = InventorySerial.ModelID
AND
INSERTED.Serial = InventorySerial.Serial

       UPDATE InventorySerial SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.StoreID = InventorySerial.StoreID
AND
DELETED.ModelID = InventorySerial.ModelID
AND
DELETED.Serial = InventorySerial.Serial

END
GO

/****** Object:  Trigger [tr_InvoiceToCostType_Repl_Del]    Script Date: 05/16/2016 17:46:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InvoiceToCostType_Repl_Del]'))
DROP TRIGGER [dbo].[tr_InvoiceToCostType_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_InvoiceToCostType_Repl_Del]    Script Date: 05/16/2016 17:46:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InvoiceToCostType_Repl_Del] ON [dbo].[InvoiceToCostType] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'InvoiceToCostType', 'DELETE FROM InvoiceToCostType WHERE ' + 'Convert(varchar, IDInvoiceCost)  = ' + QuoteName(Convert(varchar, DELETED.IDInvoiceCost), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_InvoiceToCostType_Repl_InsUpt]    Script Date: 05/16/2016 17:47:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InvoiceToCostType_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_InvoiceToCostType_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_InvoiceToCostType_Repl_InsUpt]    Script Date: 05/16/2016 17:47:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InvoiceToCostType_Repl_InsUpt] ON [dbo].[InvoiceToCostType] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE InvoiceToCostType SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDInvoiceCost = InvoiceToCostType.IDInvoiceCost

       UPDATE InvoiceToCostType SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDInvoiceCost = InvoiceToCostType.IDInvoiceCost

END
GO

/****** Object:  Trigger [tr_InvoiceGen_Repl_Del]    Script Date: 05/16/2016 17:48:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InvoiceGen_Repl_Del]'))
DROP TRIGGER [dbo].[tr_InvoiceGen_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_InvoiceGen_Repl_Del]    Script Date: 05/16/2016 17:48:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InvoiceGen_Repl_Del] ON [dbo].[InvoiceGen] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'InvoiceGen', 'DELETE FROM InvoiceGen WHERE ' + 'Convert(varchar, IDInvoice)  = ' + QuoteName(Convert(varchar, DELETED.IDInvoice), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_InvoiceGen_Repl_InsUpt]    Script Date: 05/16/2016 17:49:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InvoiceGen_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_InvoiceGen_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_InvoiceGen_Repl_InsUpt]    Script Date: 05/16/2016 17:49:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InvoiceGen_Repl_InsUpt] ON [dbo].[InvoiceGen] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE InvoiceGen SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDInvoice = InvoiceGen.IDInvoice

       UPDATE InvoiceGen SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDInvoice = InvoiceGen.IDInvoice

END
GO

/****** Object:  Trigger [tr_InvResetHistory_Repl_Del]    Script Date: 08/19/2016 11:01:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InvResetHistory_Repl_Del]'))
DROP TRIGGER [dbo].[tr_InvResetHistory_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_InvResetHistory_Repl_Del]    Script Date: 08/19/2016 11:01:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InvResetHistory_Repl_Del] ON [dbo].[InvResetHistory] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'InvResetHistory', 'DELETE FROM InvResetHistory WHERE ' + 'Convert(varchar, ResetDate)  = ' + QuoteName(Convert(varchar, DELETED.ResetDate), CHAR(39)) + ' AND ' + 'Convert(varchar, IDStore)  = ' + QuoteName(Convert(varchar, DELETED.IDStore), CHAR(39)) + ' AND ' + 'Convert(varchar, IDModel)  = ' + QuoteName(Convert(varchar, DELETED.IDModel), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_InvResetHistory_Repl_InsUpt]    Script Date: 08/19/2016 11:07:52 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_InvResetHistory_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_InvResetHistory_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_InvResetHistory_Repl_InsUpt]    Script Date: 08/19/2016 11:07:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_InvResetHistory_Repl_InsUpt] ON [dbo].[InvResetHistory] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE InvResetHistory SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.ResetDate = InvResetHistory.ResetDate
AND
INSERTED.IDStore = InvResetHistory.IDStore
AND
INSERTED.IDModel = InvResetHistory.IDModel

       UPDATE InvResetHistory SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.ResetDate = InvResetHistory.ResetDate
AND
DELETED.IDStore = InvResetHistory.IDStore
AND
DELETED.IDModel = InvResetHistory.IDModel

END
GO


/****** Object:  Trigger [tr_Key_IDInventoryMov_Repl_Del]    Script Date: 05/16/2016 18:07:05 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDInventoryMov_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDInventoryMov_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDInventoryMov_Repl_Del]    Script Date: 05/16/2016 18:07:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDInventoryMov_Repl_Del] ON [dbo].[Key_IDInventoryMov] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDInventoryMov', 'DELETE FROM Key_IDInventoryMov WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Key_IDInventoryMov_Repl_InsUpt]    Script Date: 05/16/2016 18:12:22 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDInventoryMov_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Key_IDInventoryMov_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDInventoryMov_Repl_InsUpt]    Script Date: 05/16/2016 18:12:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDInventoryMov_Repl_InsUpt] ON [dbo].[Key_IDInventoryMov] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Key_IDInventoryMov SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SeqID = Key_IDInventoryMov.SeqID

       UPDATE Key_IDInventoryMov SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SeqID = Key_IDInventoryMov.SeqID

END
GO
/****** Object:  Trigger [tr_Key_IDInvoice_Repl_Del]    Script Date: 05/16/2016 18:13:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDInvoice_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDInvoice_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDInvoice_Repl_Del]    Script Date: 05/16/2016 18:13:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDInvoice_Repl_Del] ON [dbo].[Key_IDInvoice] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDInvoice', 'DELETE FROM Key_IDInvoice WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Key_IDInvoice_Repl_InsUpt]    Script Date: 08/19/2016 11:42:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDInvoice_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Key_IDInvoice_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Key_IDInvoice_Repl_InsUpt]    Script Date: 08/19/2016 11:42:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDInvoice_Repl_InsUpt] ON [dbo].[Key_IDInvoice] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Key_IDInvoice SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SeqID = Key_IDInvoice.SeqID

       UPDATE Key_IDInvoice SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SeqID = Key_IDInvoice.SeqID

END
GO


/****** Object:  Trigger [tr_Key_IDLancamento_Repl_Del]    Script Date: 08/19/2016 15:22:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDLancamento_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDLancamento_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Key_IDLancamento_Repl_Del]    Script Date: 08/19/2016 15:22:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDLancamento_Repl_Del] ON [dbo].[Key_IDLancamento] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDLancamento', 'DELETE FROM Key_IDLancamento WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Key_IDLancamento_Repl_InsUpt]    Script Date: 05/16/2016 18:15:23 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDLancamento_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Key_IDLancamento_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDLancamento_Repl_InsUpt]    Script Date: 05/16/2016 18:15:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDLancamento_Repl_InsUpt] ON [dbo].[Key_IDLancamento] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Key_IDLancamento SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SeqID = Key_IDLancamento.SeqID

       UPDATE Key_IDLancamento SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SeqID = Key_IDLancamento.SeqID

END
GO


/****** Object:  Trigger [tr_Key_IDInvoice_Repl_Del]    Script Date: 08/19/2016 11:48:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDInvoice_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDInvoice_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Key_IDInvoice_Repl_Del]    Script Date: 08/19/2016 11:48:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDInvoice_Repl_Del] ON [dbo].[Key_IDInvoice] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDInvoice', 'DELETE FROM Key_IDInvoice WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Key_IDPreInventoryMov_Repl_Del]    Script Date: 05/16/2016 18:16:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDPreInventoryMov_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDPreInventoryMov_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDPreInventoryMov_Repl_Del]    Script Date: 05/16/2016 18:16:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDPreInventoryMov_Repl_Del] ON [dbo].[Key_IDPreInventoryMov] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDPreInventoryMov', 'DELETE FROM Key_IDPreInventoryMov WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Key_IDPreInventoryMov_Repl_InsUpt]    Script Date: 05/16/2016 18:18:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDPreInventoryMov_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Key_IDPreInventoryMov_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDPreInventoryMov_Repl_InsUpt]    Script Date: 05/16/2016 18:18:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDPreInventoryMov_Repl_InsUpt] ON [dbo].[Key_IDPreInventoryMov] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Key_IDPreInventoryMov SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SeqID = Key_IDPreInventoryMov.SeqID

       UPDATE Key_IDPreInventoryMov SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SeqID = Key_IDPreInventoryMov.SeqID

END
GO

/****** Object:  Trigger [tr_Key_IDPreSale_Repl_Del]    Script Date: 05/16/2016 18:19:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDPreSale_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDPreSale_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDPreSale_Repl_Del]    Script Date: 05/16/2016 18:19:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDPreSale_Repl_Del] ON [dbo].[Key_IDPreSale] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDPreSale', 'DELETE FROM Key_IDPreSale WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Key_IDPreSale_Repl_InsUpt]    Script Date: 05/16/2016 18:20:44 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDPreSale_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Key_IDPreSale_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDPreSale_Repl_InsUpt]    Script Date: 05/16/2016 18:20:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDPreSale_Repl_InsUpt] ON [dbo].[Key_IDPreSale] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Key_IDPreSale SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SeqID = Key_IDPreSale.SeqID

       UPDATE Key_IDPreSale SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SeqID = Key_IDPreSale.SeqID

END
GO

/****** Object:  Trigger [tr_Key_IDSaleItemCommission_Repl_Del]    Script Date: 05/16/2016 18:21:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDSaleItemCommission_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Key_IDSaleItemCommission_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDSaleItemCommission_Repl_Del]    Script Date: 05/16/2016 18:21:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDSaleItemCommission_Repl_Del] ON [dbo].[Key_IDSaleItemCommission] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Key_IDSaleItemCommission', 'DELETE FROM Key_IDSaleItemCommission WHERE ' + 'Convert(varchar, SeqID)  = ' + QuoteName(Convert(varchar, DELETED.SeqID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Key_IDSaleItemCommission_Repl_InsUpt]    Script Date: 05/16/2016 18:22:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Key_IDSaleItemCommission_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Key_IDSaleItemCommission_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Key_IDSaleItemCommission_Repl_InsUpt]    Script Date: 05/16/2016 18:22:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Key_IDSaleItemCommission_Repl_InsUpt] ON [dbo].[Key_IDSaleItemCommission] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Key_IDSaleItemCommission SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SeqID = Key_IDSaleItemCommission.SeqID

       UPDATE Key_IDSaleItemCommission SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SeqID = Key_IDSaleItemCommission.SeqID

END
GO

/****** Object:  Trigger [tr_MargemTable_Repl_Del]    Script Date: 05/16/2016 18:23:45 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MargemTable_Repl_Del]'))
DROP TRIGGER [dbo].[tr_MargemTable_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_MargemTable_Repl_Del]    Script Date: 05/16/2016 18:23:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MargemTable_Repl_Del] ON [dbo].[MargemTable] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'MargemTable', 'DELETE FROM MargemTable WHERE ' + 'Convert(varchar, IDMargemTable)  = ' + QuoteName(Convert(varchar, DELETED.IDMargemTable), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_MargemTable_Repl_InsUpt]    Script Date: 05/16/2016 18:24:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MargemTable_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_MargemTable_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_MargemTable_Repl_InsUpt]    Script Date: 05/16/2016 18:24:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MargemTable_Repl_InsUpt] ON [dbo].[MargemTable] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE MargemTable SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMargemTable = MargemTable.IDMargemTable

       UPDATE MargemTable SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMargemTable = MargemTable.IDMargemTable

END

GO

/****** Object:  Trigger [tr_MargemTableRange_Repl_Del]    Script Date: 05/16/2016 18:26:10 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MargemTableRange_Repl_Del]'))
DROP TRIGGER [dbo].[tr_MargemTableRange_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_MargemTableRange_Repl_Del]    Script Date: 05/16/2016 18:26:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MargemTableRange_Repl_Del] ON [dbo].[MargemTableRange] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'MargemTableRange', 'DELETE FROM MargemTableRange WHERE ' + 'Convert(varchar, IDMargemTableRange)  = ' + QuoteName(Convert(varchar, DELETED.IDMargemTableRange), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_MargemTableRange_Repl_InsUpt]    Script Date: 05/16/2016 18:31:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MargemTableRange_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_MargemTableRange_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_MargemTableRange_Repl_InsUpt]    Script Date: 05/16/2016 18:31:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MargemTableRange_Repl_InsUpt] ON [dbo].[MargemTableRange] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE MargemTableRange SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMargemTableRange = MargemTableRange.IDMargemTableRange

       UPDATE MargemTableRange SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMargemTableRange = MargemTableRange.IDMargemTableRange

END

GO

/****** Object:  Trigger [tr_MenuItem_Repl_Del]    Script Date: 05/16/2016 18:32:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_MenuItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_MenuItem_Repl_Del]    Script Date: 05/16/2016 18:32:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuItem_Repl_Del] ON [dbo].[MenuItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'MenuItem', 'DELETE FROM MenuItem WHERE ' + 'Convert(varchar, IDMenu)  = ' + QuoteName(Convert(varchar, DELETED.IDMenu), CHAR(39)) + ' AND ' + 'Convert(varchar, IDSubMenu)  = ' + QuoteName(Convert(varchar, DELETED.IDSubMenu), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_MenuItem_Repl_InsUpt]    Script Date: 05/16/2016 18:32:52 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_MenuItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_MenuItem_Repl_InsUpt]    Script Date: 05/16/2016 18:32:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuItem_Repl_InsUpt] ON [dbo].[MenuItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE MenuItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMenu = MenuItem.IDMenu
AND
INSERTED.IDSubMenu = MenuItem.IDSubMenu

       UPDATE MenuItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMenu = MenuItem.IDMenu
AND
DELETED.IDSubMenu = MenuItem.IDSubMenu

END
GO

/****** Object:  Trigger [tr_MenuItemLanguage_Repl_Del]    Script Date: 05/16/2016 18:33:51 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuItemLanguage_Repl_Del]'))
DROP TRIGGER [dbo].[tr_MenuItemLanguage_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_MenuItemLanguage_Repl_Del]    Script Date: 05/16/2016 18:33:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuItemLanguage_Repl_Del] ON [dbo].[MenuItemLanguage] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'MenuItemLanguage', 'DELETE FROM MenuItemLanguage WHERE ' + 'Convert(varchar, IDMenu)  = ' + QuoteName(Convert(varchar, DELETED.IDMenu), CHAR(39)) + ' AND ' + 'Convert(varchar, IDSubMenu)  = ' + QuoteName(Convert(varchar, DELETED.IDSubMenu), CHAR(39)) + ' AND ' + 'Convert(varchar, IDLanguage)  = ' + QuoteName(Convert(varchar, DELETED.IDLanguage), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_MenuItemLanguage_Repl_InsUpt]    Script Date: 05/16/2016 18:34:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuItemLanguage_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_MenuItemLanguage_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_MenuItemLanguage_Repl_InsUpt]    Script Date: 05/16/2016 18:34:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuItemLanguage_Repl_InsUpt] ON [dbo].[MenuItemLanguage] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE MenuItemLanguage SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMenu = MenuItemLanguage.IDMenu
AND
INSERTED.IDSubMenu = MenuItemLanguage.IDSubMenu
AND
INSERTED.IDLanguage = MenuItemLanguage.IDLanguage

       UPDATE MenuItemLanguage SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMenu = MenuItemLanguage.IDMenu
AND
DELETED.IDSubMenu = MenuItemLanguage.IDSubMenu
AND
DELETED.IDLanguage = MenuItemLanguage.IDLanguage

END
GO

/****** Object:  Trigger [tr_MenuMain_Repl_Del]    Script Date: 05/16/2016 18:35:48 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuMain_Repl_Del]'))
DROP TRIGGER [dbo].[tr_MenuMain_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_MenuMain_Repl_Del]    Script Date: 05/16/2016 18:35:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuMain_Repl_Del] ON [dbo].[MenuMain] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'MenuMain', 'DELETE FROM MenuMain WHERE ' + 'Convert(varchar, IDMenu)  = ' + QuoteName(Convert(varchar, DELETED.IDMenu), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_MenuMain_Repl_InsUpt]    Script Date: 05/16/2016 18:37:03 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuMain_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_MenuMain_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_MenuMain_Repl_InsUpt]    Script Date: 05/16/2016 18:37:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuMain_Repl_InsUpt] ON [dbo].[MenuMain] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE MenuMain SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMenu = MenuMain.IDMenu

       UPDATE MenuMain SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMenu = MenuMain.IDMenu

END
GO

/****** Object:  Trigger [tr_MenuMainLanguage_Repl_Del]    Script Date: 05/16/2016 18:37:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuMainLanguage_Repl_Del]'))
DROP TRIGGER [dbo].[tr_MenuMainLanguage_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_MenuMainLanguage_Repl_Del]    Script Date: 05/16/2016 18:37:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuMainLanguage_Repl_Del] ON [dbo].[MenuMainLanguage] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'MenuMainLanguage', 'DELETE FROM MenuMainLanguage WHERE ' + 'Convert(varchar, IDMenu)  = ' + QuoteName(Convert(varchar, DELETED.IDMenu), CHAR(39)) + ' AND ' + 'Convert(varchar, IDLanguage)  = ' + QuoteName(Convert(varchar, DELETED.IDLanguage), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_MenuMainLanguage_Repl_InsUpt]    Script Date: 05/16/2016 18:38:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_MenuMainLanguage_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_MenuMainLanguage_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_MenuMainLanguage_Repl_InsUpt]    Script Date: 05/16/2016 18:38:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_MenuMainLanguage_Repl_InsUpt] ON [dbo].[MenuMainLanguage] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE MenuMainLanguage SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMenu = MenuMainLanguage.IDMenu
AND
INSERTED.IDLanguage = MenuMainLanguage.IDLanguage

       UPDATE MenuMainLanguage SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMenu = MenuMainLanguage.IDMenu
AND
DELETED.IDLanguage = MenuMainLanguage.IDLanguage

END
GO

/****** Object:  Trigger [tr_Mnt_CFOP_Repl_Del]    Script Date: 05/16/2016 18:39:10 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_CFOP_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Mnt_CFOP_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_CFOP_Repl_Del]    Script Date: 05/16/2016 18:39:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_CFOP_Repl_Del] ON [dbo].[Mnt_CFOP] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Mnt_CFOP', 'DELETE FROM Mnt_CFOP WHERE ' + 'Convert(varchar, IDCFOP)  = ' + QuoteName(Convert(varchar, DELETED.IDCFOP), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Mnt_CFOP_Repl_InsUpt]    Script Date: 05/16/2016 18:39:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_CFOP_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Mnt_CFOP_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_CFOP_Repl_InsUpt]    Script Date: 05/16/2016 18:39:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_CFOP_Repl_InsUpt] ON [dbo].[Mnt_CFOP] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Mnt_CFOP SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDCFOP = Mnt_CFOP.IDCFOP

       UPDATE Mnt_CFOP SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDCFOP = Mnt_CFOP.IDCFOP

END
GO

/****** Object:  Trigger [tr_Mnt_Controler_Repl_Del]    Script Date: 05/16/2016 18:40:57 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_Controler_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Mnt_Controler_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_Controler_Repl_Del]    Script Date: 05/16/2016 18:40:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_Controler_Repl_Del] ON [dbo].[Mnt_Controler] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Mnt_Controler', 'DELETE FROM Mnt_Controler WHERE ' + 'Convert(varchar, Software)  = ' + QuoteName(Convert(varchar, DELETED.Software), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Mnt_Controler_Repl_InsUpt]    Script Date: 05/16/2016 18:41:32 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_Controler_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Mnt_Controler_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_Controler_Repl_InsUpt]    Script Date: 05/16/2016 18:41:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_Controler_Repl_InsUpt] ON [dbo].[Mnt_Controler] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Mnt_Controler SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Software = Mnt_Controler.Software

       UPDATE Mnt_Controler SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Software = Mnt_Controler.Software

END
GO

/****** Object:  Trigger [tr_Mnt_DefaultInvoiceOBS_Repl_Del]    Script Date: 05/16/2016 18:42:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_Del]    Script Date: 05/16/2016 18:42:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_Del] ON [dbo].[Mnt_DefaultInvoiceOBS] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Mnt_DefaultInvoiceOBS', 'DELETE FROM Mnt_DefaultInvoiceOBS WHERE ' + 'Convert(varchar, IDDefaultInvoiceOBS)  = ' + QuoteName(Convert(varchar, DELETED.IDDefaultInvoiceOBS), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Mnt_DefaultInvoiceOBS_Repl_InsUpt]    Script Date: 05/16/2016 18:43:07 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_InsUpt]    Script Date: 05/16/2016 18:43:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_DefaultInvoiceOBS_Repl_InsUpt] ON [dbo].[Mnt_DefaultInvoiceOBS] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Mnt_DefaultInvoiceOBS SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDDefaultInvoiceOBS = Mnt_DefaultInvoiceOBS.IDDefaultInvoiceOBS

       UPDATE Mnt_DefaultInvoiceOBS SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDDefaultInvoiceOBS = Mnt_DefaultInvoiceOBS.IDDefaultInvoiceOBS

END
GO

/****** Object:  Trigger [tr_Mnt_DocumentType_Repl_Del]    Script Date: 05/16/2016 18:44:11 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_DocumentType_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Mnt_DocumentType_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_DocumentType_Repl_Del]    Script Date: 05/16/2016 18:44:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_DocumentType_Repl_Del] ON [dbo].[Mnt_DocumentType] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Mnt_DocumentType', 'DELETE FROM Mnt_DocumentType WHERE ' + 'Convert(varchar, IDDocumentType)  = ' + QuoteName(Convert(varchar, DELETED.IDDocumentType), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Mnt_DocumentType_Repl_InsUpt]    Script Date: 05/16/2016 18:44:51 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_DocumentType_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Mnt_DocumentType_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_DocumentType_Repl_InsUpt]    Script Date: 05/16/2016 18:44:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_DocumentType_Repl_InsUpt] ON [dbo].[Mnt_DocumentType] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Mnt_DocumentType SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDDocumentType = Mnt_DocumentType.IDDocumentType

       UPDATE Mnt_DocumentType SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDDocumentType = Mnt_DocumentType.IDDocumentType

END
GO

/****** Object:  Trigger [tr_Mnt_Store_Repl_Del]    Script Date: 05/16/2016 18:46:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_Store_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Mnt_Store_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_Store_Repl_Del]    Script Date: 05/16/2016 18:46:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_Store_Repl_Del] ON [dbo].[Mnt_Store] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Mnt_Store', 'DELETE FROM Mnt_Store WHERE ' + 'Convert(varchar, MRKey)  = ' + QuoteName(Convert(varchar, DELETED.MRKey), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Mnt_Store_Repl_InsUpt]    Script Date: 05/16/2016 18:50:47 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_Store_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Mnt_Store_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_Store_Repl_InsUpt]    Script Date: 05/16/2016 18:50:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_Store_Repl_InsUpt] ON [dbo].[Mnt_Store] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Mnt_Store SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Mnt_Store SET ReplLastChange = GETDATE() FROM DELETED  
END
GO

/****** Object:  Trigger [tr_Mnt_StoreVendorAccount_Repl_Del]    Script Date: 05/16/2016 18:51:29 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Mnt_StoreVendorAccount_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Mnt_StoreVendorAccount_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Mnt_StoreVendorAccount_Repl_Del]    Script Date: 05/16/2016 18:51:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Mnt_StoreVendorAccount_Repl_Del] ON [dbo].[Mnt_StoreVendorAccount] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Mnt_StoreVendorAccount', 'DELETE FROM Mnt_StoreVendorAccount WHERE ' + 'Convert(varchar, IDStoreVendorAccount)  = ' + QuoteName(Convert(varchar, DELETED.IDStoreVendorAccount), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_ModelPriceLog_Repl_Del]    Script Date: 05/16/2016 18:57:05 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_ModelPriceLog_Repl_Del]'))
DROP TRIGGER [dbo].[tr_ModelPriceLog_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_ModelPriceLog_Repl_Del]    Script Date: 05/16/2016 18:57:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_ModelPriceLog_Repl_Del] ON [dbo].[ModelPriceLog] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'ModelPriceLog', 'DELETE FROM ModelPriceLog WHERE ' + 'Convert(varchar, IDModelPriceLog)  = ' + QuoteName(Convert(varchar, DELETED.IDModelPriceLog), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_ModelPriceLog_Repl_InsUpt]    Script Date: 05/16/2016 18:57:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_ModelPriceLog_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_ModelPriceLog_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_ModelPriceLog_Repl_InsUpt]    Script Date: 05/16/2016 18:57:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_ModelPriceLog_Repl_InsUpt] ON [dbo].[ModelPriceLog] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE ModelPriceLog SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModelPriceLog = ModelPriceLog.IDModelPriceLog

       UPDATE ModelPriceLog SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModelPriceLog = ModelPriceLog.IDModelPriceLog

END
GO

/****** Object:  Trigger [tr_modeltransfserial_Repl_Del]    Script Date: 05/16/2016 19:01:55 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_modeltransfserial_Repl_Del]'))
DROP TRIGGER [dbo].[tr_modeltransfserial_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_modeltransfserial_Repl_Del]    Script Date: 05/16/2016 19:01:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_modeltransfserial_Repl_Del] ON [dbo].[ModelTransfSerial] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'modeltransfserial', 'DELETE FROM modeltransfserial WHERE ' + 'Convert(varchar, IDModelTransfSerial)  = ' + QuoteName(Convert(varchar, DELETED.IDModelTransfSerial), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_modeltransfserial_Repl_InsUpt]    Script Date: 05/16/2016 19:02:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_modeltransfserial_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_modeltransfserial_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_modeltransfserial_Repl_InsUpt]    Script Date: 05/16/2016 19:02:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_modeltransfserial_Repl_InsUpt] ON [dbo].[ModelTransfSerial] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE modeltransfserial SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModelTransfSerial = modeltransfserial.IDModelTransfSerial

       UPDATE modeltransfserial SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModelTransfSerial = modeltransfserial.IDModelTransfSerial

END
GO

/****** Object:  Trigger [tr_Nfe_NotaFiscal_Repl_Del]    Script Date: 05/16/2016 19:03:32 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Nfe_NotaFiscal_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Nfe_NotaFiscal_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Nfe_NotaFiscal_Repl_Del]    Script Date: 05/16/2016 19:03:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Nfe_NotaFiscal_Repl_Del] ON [dbo].[Nfe_NotaFiscal] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Nfe_NotaFiscal', 'DELETE FROM Nfe_NotaFiscal WHERE ' + 'Convert(varchar, IDNotaFiscal)  = ' + QuoteName(Convert(varchar, DELETED.IDNotaFiscal), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Nfe_NotaFiscal_Repl_InsUpt]    Script Date: 08/19/2016 11:51:51 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Nfe_NotaFiscal_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Nfe_NotaFiscal_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Nfe_NotaFiscal_Repl_InsUpt]    Script Date: 08/19/2016 11:51:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Nfe_NotaFiscal_Repl_InsUpt] ON [dbo].[Nfe_NotaFiscal] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Nfe_NotaFiscal SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDNotaFiscal = Nfe_NotaFiscal.IDNotaFiscal

       UPDATE Nfe_NotaFiscal SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDNotaFiscal = Nfe_NotaFiscal.IDNotaFiscal

END
GO

/****** Object:  Trigger [tr_modeltransfserial_Repl_InsUpt]    Script Date: 05/16/2016 19:04:19 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_modeltransfserial_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_modeltransfserial_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_modeltransfserial_Repl_InsUpt]    Script Date: 05/16/2016 19:04:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_modeltransfserial_Repl_InsUpt] ON [dbo].[ModelTransfSerial] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE modeltransfserial SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDModelTransfSerial = modeltransfserial.IDModelTransfSerial

       UPDATE modeltransfserial SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDModelTransfSerial = modeltransfserial.IDModelTransfSerial

END
GO

/****** Object:  Trigger [tr_Param_Repl_Del]    Script Date: 05/16/2016 19:05:24 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Param_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Param_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Param_Repl_Del]    Script Date: 05/16/2016 19:05:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Param_Repl_Del] ON [dbo].[Param] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Param', 'DELETE FROM Param WHERE ' + 'Convert(varchar, IDParam)  = ' + QuoteName(Convert(varchar, DELETED.IDParam), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Param_Repl_InsUpt]    Script Date: 05/16/2016 19:06:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Param_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Param_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Param_Repl_InsUpt]    Script Date: 05/16/2016 19:06:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Param_Repl_InsUpt] ON [dbo].[Param] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Param SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDParam = Param.IDParam

       UPDATE Param SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDParam = Param.IDParam

END
GO

/****** Object:  Trigger [tr_ParamLanguage_Repl_Del]    Script Date: 05/16/2016 19:07:09 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_ParamLanguage_Repl_Del]'))
DROP TRIGGER [dbo].[tr_ParamLanguage_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_ParamLanguage_Repl_Del]    Script Date: 05/16/2016 19:07:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_ParamLanguage_Repl_Del] ON [dbo].[ParamLanguage] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'ParamLanguage', 'DELETE FROM ParamLanguage WHERE ' + 'Convert(varchar, IDParam)  = ' + QuoteName(Convert(varchar, DELETED.IDParam), CHAR(39)) + ' AND ' + 'Convert(varchar, IDLanguage)  = ' + QuoteName(Convert(varchar, DELETED.IDLanguage), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_ParamLanguage_Repl_InsUpt]    Script Date: 05/16/2016 19:08:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_ParamLanguage_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_ParamLanguage_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_ParamLanguage_Repl_InsUpt]    Script Date: 05/16/2016 19:08:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_ParamLanguage_Repl_InsUpt] ON [dbo].[ParamLanguage] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE ParamLanguage SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDParam = ParamLanguage.IDParam
AND
INSERTED.IDLanguage = ParamLanguage.IDLanguage

       UPDATE ParamLanguage SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDParam = ParamLanguage.IDParam
AND
DELETED.IDLanguage = ParamLanguage.IDLanguage

END
GO

/****** Object:  Trigger [tr_pcm_animals_Repl_Del]    Script Date: 05/16/2016 19:09:23 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_animals_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_animals_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_animals_Repl_Del]    Script Date: 05/16/2016 19:09:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_animals_Repl_Del] ON [dbo].[pcm_animals] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_animals', 'DELETE FROM pcm_animals WHERE ' + 'Convert(varchar, id)  = ' + QuoteName(Convert(varchar, DELETED.id), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_animals_Repl_InsUpt]    Script Date: 05/16/2016 19:10:09 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_animals_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_animals_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_animals_Repl_InsUpt]    Script Date: 05/16/2016 19:10:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_animals_Repl_InsUpt] ON [dbo].[pcm_animals] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_animals SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.id = pcm_animals.id

       UPDATE pcm_animals SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.id = pcm_animals.id

END
GO

/****** Object:  Trigger [tr_pcm_breeders_Repl_Del]    Script Date: 05/16/2016 19:11:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_breeders_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_breeders_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_breeders_Repl_Del]    Script Date: 05/16/2016 19:11:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_breeders_Repl_Del] ON [dbo].[pcm_breeders] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_breeders', 'DELETE FROM pcm_breeders WHERE ' + 'Convert(varchar, breeder)  = ' + QuoteName(Convert(varchar, DELETED.breeder), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_breeders_Repl_InsUpt]    Script Date: 05/16/2016 19:11:59 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_breeders_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_breeders_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_breeders_Repl_InsUpt]    Script Date: 05/16/2016 19:11:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_breeders_Repl_InsUpt] ON [dbo].[pcm_breeders] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_breeders SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.breeder = pcm_breeders.breeder

       UPDATE pcm_breeders SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.breeder = pcm_breeders.breeder

END
GO

/****** Object:  Trigger [tr_pcm_breeds_Repl_Del]    Script Date: 05/16/2016 19:13:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_breeds_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_breeds_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_breeds_Repl_Del]    Script Date: 05/16/2016 19:13:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_breeds_Repl_Del] ON [dbo].[pcm_breeds] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_breeds', 'DELETE FROM pcm_breeds WHERE ' + 'Convert(varchar, breed)  = ' + QuoteName(Convert(varchar, DELETED.breed), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_breeds_Repl_InsUpt]    Script Date: 05/16/2016 19:13:56 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_breeds_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_breeds_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_breeds_Repl_InsUpt]    Script Date: 05/16/2016 19:13:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_breeds_Repl_InsUpt] ON [dbo].[pcm_breeds] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_breeds SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.breed = pcm_breeds.breed

       UPDATE pcm_breeds SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.breed = pcm_breeds.breed

END
GO

/****** Object:  Trigger [tr_pcm_config_Repl_Del]    Script Date: 05/16/2016 19:15:08 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_config_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_config_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_config_Repl_Del]    Script Date: 05/16/2016 19:15:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_config_Repl_Del] ON [dbo].[pcm_config] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_config', 'DELETE FROM pcm_config WHERE ' + 'Convert(varchar, name)  = ' + QuoteName(Convert(varchar, DELETED.name), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_config_Repl_InsUpt]    Script Date: 05/16/2016 19:17:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_config_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_config_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_config_Repl_InsUpt]    Script Date: 05/16/2016 19:17:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_config_Repl_InsUpt] ON [dbo].[pcm_config] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_config SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.name = pcm_config.name

       UPDATE pcm_config SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.name = pcm_config.name

END
GO

/****** Object:  Trigger [tr_pcm_medical_Repl_Del]    Script Date: 05/16/2016 19:27:55 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_medical_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_medical_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_medical_Repl_Del]    Script Date: 05/16/2016 19:27:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_medical_Repl_Del] ON [dbo].[pcm_medical] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_medical', 'DELETE FROM pcm_medical WHERE ' + 'Convert(varchar, condition)  = ' + QuoteName(Convert(varchar, DELETED.condition), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_medical_Repl_InsUpt]    Script Date: 05/16/2016 19:28:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_medical_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_medical_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_medical_Repl_InsUpt]    Script Date: 05/16/2016 19:28:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_medical_Repl_InsUpt] ON [dbo].[pcm_medical] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_medical SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.condition = pcm_medical.condition

       UPDATE pcm_medical SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.condition = pcm_medical.condition

END
GO

/****** Object:  Trigger [tr_pcm_medical_rec_Repl_Del]    Script Date: 05/16/2016 19:29:23 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_medical_rec_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_medical_rec_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_medical_rec_Repl_Del]    Script Date: 05/16/2016 19:29:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_medical_rec_Repl_Del] ON [dbo].[pcm_medical_rec] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_medical_rec', 'DELETE FROM pcm_medical_rec WHERE ' + 'Convert(varchar, code)  = ' + QuoteName(Convert(varchar, DELETED.code), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_medical_rec_Repl_InsUpt]    Script Date: 05/16/2016 19:30:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_medical_rec_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_medical_rec_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_medical_rec_Repl_InsUpt]    Script Date: 05/16/2016 19:30:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_medical_rec_Repl_InsUpt] ON [dbo].[pcm_medical_rec] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_medical_rec SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.code = pcm_medical_rec.code

       UPDATE pcm_medical_rec SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.code = pcm_medical_rec.code

END
GO

/****** Object:  Trigger [tr_pcm_others_Repl_Del]    Script Date: 05/16/2016 19:36:44 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_others_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_others_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_others_Repl_Del]    Script Date: 05/16/2016 19:36:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_others_Repl_Del] ON [dbo].[pcm_others] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_others', 'DELETE FROM pcm_others WHERE ' + 'Convert(varchar, id)  = ' + QuoteName(Convert(varchar, DELETED.id), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_others_Repl_InsUpt]    Script Date: 05/16/2016 19:37:55 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_others_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_others_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_others_Repl_InsUpt]    Script Date: 05/16/2016 19:37:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_others_Repl_InsUpt] ON [dbo].[pcm_others] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_others SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.id = pcm_others.id

       UPDATE pcm_others SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.id = pcm_others.id

END
GO

/****** Object:  Trigger [tr_pcm_vaccine_lots_Repl_Del]    Script Date: 05/16/2016 19:39:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccine_lots_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_vaccine_lots_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccine_lots_Repl_Del]    Script Date: 05/16/2016 19:39:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccine_lots_Repl_Del] ON [dbo].[pcm_vaccine_lots] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_vaccine_lots', 'DELETE FROM pcm_vaccine_lots WHERE ' + 'Convert(varchar, code)  = ' + QuoteName(Convert(varchar, DELETED.code), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_vaccine_lots_Repl_InsUpt]    Script Date: 05/16/2016 19:40:09 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccine_lots_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_vaccine_lots_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccine_lots_Repl_InsUpt]    Script Date: 05/16/2016 19:40:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccine_lots_Repl_InsUpt] ON [dbo].[pcm_vaccine_lots] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_vaccine_lots SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.code = pcm_vaccine_lots.code

       UPDATE pcm_vaccine_lots SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.code = pcm_vaccine_lots.code

END
GO

/****** Object:  Trigger [tr_pcm_vaccine_manu_Repl_Del]    Script Date: 05/16/2016 19:42:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccine_manu_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_vaccine_manu_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccine_manu_Repl_Del]    Script Date: 05/16/2016 19:42:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccine_manu_Repl_Del] ON [dbo].[pcm_vaccine_manu] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_vaccine_manu', 'DELETE FROM pcm_vaccine_manu WHERE ' + 'Convert(varchar, manu)  = ' + QuoteName(Convert(varchar, DELETED.manu), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_vaccine_manu_Repl_InsUpt]    Script Date: 05/16/2016 19:43:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccine_manu_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_vaccine_manu_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccine_manu_Repl_InsUpt]    Script Date: 05/16/2016 19:43:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccine_manu_Repl_InsUpt] ON [dbo].[pcm_vaccine_manu] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_vaccine_manu SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.manu = pcm_vaccine_manu.manu

       UPDATE pcm_vaccine_manu SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.manu = pcm_vaccine_manu.manu

END
GO

/****** Object:  Trigger [tr_pcm_vaccine_shots_Repl_Del]    Script Date: 05/16/2016 19:43:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccine_shots_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_vaccine_shots_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccine_shots_Repl_Del]    Script Date: 05/16/2016 19:43:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccine_shots_Repl_Del] ON [dbo].[pcm_vaccine_shots] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_vaccine_shots', 'DELETE FROM pcm_vaccine_shots WHERE ' + 'Convert(varchar, code)  = ' + QuoteName(Convert(varchar, DELETED.code), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_vaccine_shots_Repl_InsUpt]    Script Date: 05/16/2016 19:45:56 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccine_shots_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_vaccine_shots_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccine_shots_Repl_InsUpt]    Script Date: 05/16/2016 19:45:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccine_shots_Repl_InsUpt] ON [dbo].[pcm_vaccine_shots] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_vaccine_shots SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.code = pcm_vaccine_shots.code

       UPDATE pcm_vaccine_shots SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.code = pcm_vaccine_shots.code

END
GO

/****** Object:  Trigger [tr_pcm_vaccines_Repl_Del]    Script Date: 05/16/2016 20:30:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccines_Repl_Del]'))
DROP TRIGGER [dbo].[tr_pcm_vaccines_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccines_Repl_Del]    Script Date: 05/16/2016 20:30:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccines_Repl_Del] ON [dbo].[pcm_vaccines] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'pcm_vaccines', 'DELETE FROM pcm_vaccines WHERE ' + 'Convert(varchar, vaccine)  = ' + QuoteName(Convert(varchar, DELETED.vaccine), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_pcm_vaccines_Repl_InsUpt]    Script Date: 05/16/2016 20:31:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_pcm_vaccines_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_pcm_vaccines_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_pcm_vaccines_Repl_InsUpt]    Script Date: 05/16/2016 20:31:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_pcm_vaccines_Repl_InsUpt] ON [dbo].[pcm_vaccines] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE pcm_vaccines SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.vaccine = pcm_vaccines.vaccine

       UPDATE pcm_vaccines SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.vaccine = pcm_vaccines.vaccine

END
GO

/****** Object:  Trigger [tr_PessoaValidation_Repl_Del]    Script Date: 05/16/2016 20:32:05 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PessoaValidation_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PessoaValidation_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_PessoaValidation_Repl_Del]    Script Date: 05/16/2016 20:32:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PessoaValidation_Repl_Del] ON [dbo].[PessoaValidation] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PessoaValidation', 'DELETE FROM PessoaValidation WHERE ' + 'Convert(varchar, IDPessoaValidation)  = ' + QuoteName(Convert(varchar, DELETED.IDPessoaValidation), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_PessoaValidation_Repl_InsUpt]    Script Date: 05/16/2016 20:33:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PessoaValidation_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_PessoaValidation_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_PessoaValidation_Repl_InsUpt]    Script Date: 05/16/2016 20:33:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PessoaValidation_Repl_InsUpt] ON [dbo].[PessoaValidation] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE PessoaValidation SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPessoaValidation = PessoaValidation.IDPessoaValidation

       UPDATE PessoaValidation SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPessoaValidation = PessoaValidation.IDPessoaValidation

END
GO

/****** Object:  Trigger [tr_Pet_MicrochipSale_Repl_Del]    Script Date: 08/19/2016 12:33:22 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_MicrochipSale_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pet_MicrochipSale_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pet_MicrochipSale_Repl_Del]    Script Date: 08/19/2016 12:33:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_MicrochipSale_Repl_Del] ON [dbo].[Pet_MicrochipSale] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pet_MicrochipSale', 'DELETE FROM Pet_MicrochipSale WHERE ' + 'Convert(varchar, IDPreInventoryMov)  = ' + QuoteName(Convert(varchar, DELETED.IDPreInventoryMov), CHAR(39)) + ' AND ' + 'Convert(varchar, IDMicrochip)  = ' + QuoteName(Convert(varchar, DELETED.IDMicrochip), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pet_MicrochipSale_Repl_InsUpt]    Script Date: 08/19/2016 12:34:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_MicrochipSale_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pet_MicrochipSale_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pet_MicrochipSale_Repl_InsUpt]    Script Date: 08/19/2016 12:34:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_MicrochipSale_Repl_InsUpt] ON [dbo].[Pet_MicrochipSale] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pet_MicrochipSale SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPreInventoryMov = Pet_MicrochipSale.IDPreInventoryMov
AND
INSERTED.IDMicrochip = Pet_MicrochipSale.IDMicrochip

       UPDATE Pet_MicrochipSale SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPreInventoryMov = Pet_MicrochipSale.IDPreInventoryMov
AND
DELETED.IDMicrochip = Pet_MicrochipSale.IDMicrochip

END
GO

/****** Object:  Trigger [tr_Pet_PetSale_Repl_Del]    Script Date: 08/19/2016 12:40:37 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_PetSale_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pet_PetSale_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pet_PetSale_Repl_Del]    Script Date: 08/19/2016 12:40:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_PetSale_Repl_Del] ON [dbo].[Pet_PetSale] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pet_PetSale', 'DELETE FROM Pet_PetSale WHERE ' + 'Convert(varchar, IDPetSale)  = ' + QuoteName(Convert(varchar, DELETED.IDPetSale), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pet_PetSale_Repl_InsUpt]    Script Date: 08/19/2016 12:47:08 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_PetSale_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pet_PetSale_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pet_PetSale_Repl_InsUpt]    Script Date: 08/19/2016 12:47:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_PetSale_Repl_InsUpt] ON [dbo].[Pet_PetSale] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pet_PetSale SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPetSale = Pet_PetSale.IDPetSale

       UPDATE Pet_PetSale SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPetSale = Pet_PetSale.IDPetSale

END
GO

/****** Object:  Trigger [tr_Pet_RegistrySale_Repl_Del]    Script Date: 08/19/2016 12:49:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_RegistrySale_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pet_RegistrySale_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pet_RegistrySale_Repl_Del]    Script Date: 08/19/2016 12:49:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_RegistrySale_Repl_Del] ON [dbo].[Pet_RegistrySale] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pet_RegistrySale', 'DELETE FROM Pet_RegistrySale WHERE ' + 'Convert(varchar, IDPreInventoryMov)  = ' + QuoteName(Convert(varchar, DELETED.IDPreInventoryMov), CHAR(39)) + ' AND ' + 'Convert(varchar, IDRegistry)  = ' + QuoteName(Convert(varchar, DELETED.IDRegistry), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pet_RegistrySale_Repl_InsUpt]    Script Date: 08/19/2016 12:50:32 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_RegistrySale_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pet_RegistrySale_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pet_RegistrySale_Repl_InsUpt]    Script Date: 08/19/2016 12:50:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_RegistrySale_Repl_InsUpt] ON [dbo].[Pet_RegistrySale] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pet_RegistrySale SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPreInventoryMov = Pet_RegistrySale.IDPreInventoryMov
AND
INSERTED.IDRegistry = Pet_RegistrySale.IDRegistry

       UPDATE Pet_RegistrySale SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPreInventoryMov = Pet_RegistrySale.IDPreInventoryMov
AND
DELETED.IDRegistry = Pet_RegistrySale.IDRegistry

END
GO


/****** Object:  Trigger [tr_Pet_WarrantyReport_Repl_Del]    Script Date: 05/16/2016 20:34:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_WarrantyReport_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pet_WarrantyReport_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Pet_WarrantyReport_Repl_Del]    Script Date: 05/16/2016 20:34:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_WarrantyReport_Repl_Del] ON [dbo].[Pet_WarrantyReport] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pet_WarrantyReport', 'DELETE FROM Pet_WarrantyReport WHERE ' + 'Convert(varchar, IDWarrantyReport)  = ' + QuoteName(Convert(varchar, DELETED.IDWarrantyReport), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pet_WarrantyReport_Repl_InsUpt]    Script Date: 05/16/2016 20:35:07 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pet_WarrantyReport_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pet_WarrantyReport_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Pet_WarrantyReport_Repl_InsUpt]    Script Date: 05/16/2016 20:35:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pet_WarrantyReport_Repl_InsUpt] ON [dbo].[Pet_WarrantyReport] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pet_WarrantyReport SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDWarrantyReport = Pet_WarrantyReport.IDWarrantyReport

       UPDATE Pet_WarrantyReport SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDWarrantyReport = Pet_WarrantyReport.IDWarrantyReport

END
GO


/****** Object:  Trigger [tr_PO_Repl_Del]    Script Date: 08/19/2016 12:54:16 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PO_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PO_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_PO_Repl_Del]    Script Date: 08/19/2016 12:54:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PO_Repl_Del] ON [dbo].[PO] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PO', 'DELETE FROM PO WHERE ' + 'Convert(varchar, IDPO)  = ' + QuoteName(Convert(varchar, DELETED.IDPO), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_PreInventoryMov_Repl_Del]    Script Date: 08/19/2016 12:57:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PreInventoryMov_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PreInventoryMov_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_PreInventoryMov_Repl_Del]    Script Date: 08/19/2016 12:57:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PreInventoryMov_Repl_Del] ON [dbo].[PreInventoryMov] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PreInventoryMov', 'DELETE FROM PreInventoryMov WHERE ' + 'Convert(varchar, IDPreInventoryMov)  = ' + QuoteName(Convert(varchar, DELETED.IDPreInventoryMov), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_PrePurchaseSerial_Repl_Del]    Script Date: 08/19/2016 13:01:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PrePurchaseSerial_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PrePurchaseSerial_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_PrePurchaseSerial_Repl_Del]    Script Date: 08/19/2016 13:01:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PrePurchaseSerial_Repl_Del] ON [dbo].[PrePurchaseSerial] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PrePurchaseSerial', 'DELETE FROM PrePurchaseSerial WHERE ' + 'Convert(varchar, IDPrePurchaseMov)  = ' + QuoteName(Convert(varchar, DELETED.IDPrePurchaseMov), CHAR(39)) + ' AND ' + 'Convert(varchar, SerialNumber)  = ' + QuoteName(Convert(varchar, DELETED.SerialNumber), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_PrePurchaseSerial_Repl_InsUpt]    Script Date: 08/19/2016 13:02:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PrePurchaseSerial_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_PrePurchaseSerial_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_PrePurchaseSerial_Repl_InsUpt]    Script Date: 08/19/2016 13:02:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PrePurchaseSerial_Repl_InsUpt] ON [dbo].[PrePurchaseSerial] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE PrePurchaseSerial SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPrePurchaseMov = PrePurchaseSerial.IDPrePurchaseMov
AND
INSERTED.SerialNumber = PrePurchaseSerial.SerialNumber

       UPDATE PrePurchaseSerial SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPrePurchaseMov = PrePurchaseSerial.IDPrePurchaseMov
AND
DELETED.SerialNumber = PrePurchaseSerial.SerialNumber

END
GO

/****** Object:  Trigger [tr_Pur_Purchase_Repl_Del]    Script Date: 08/19/2016 13:05:16 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_Purchase_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_Purchase_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_Purchase_Repl_Del]    Script Date: 08/19/2016 13:05:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_Purchase_Repl_Del] ON [dbo].[Pur_Purchase] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_Purchase', 'DELETE FROM Pur_Purchase WHERE ' + 'Convert(varchar, IDPurchase)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchase), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Pur_PurchaseDueDate_Repl_Del]    Script Date: 08/19/2016 13:07:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseDueDate_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseDueDate_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseDueDate_Repl_Del]    Script Date: 08/19/2016 13:07:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseDueDate_Repl_Del] ON [dbo].[Pur_PurchaseDueDate] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseDueDate', 'DELETE FROM Pur_PurchaseDueDate WHERE ' + 'Convert(varchar, IDPurchaseDueDate)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseDueDate), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItem_Repl_Del]    Script Date: 08/19/2016 13:09:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItem_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItem_Repl_Del]    Script Date: 08/19/2016 13:09:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItem_Repl_Del] ON [dbo].[Pur_PurchaseItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseItem', 'DELETE FROM Pur_PurchaseItem WHERE ' + 'Convert(varchar, IDPurchaseItem)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItemSerial_Repl_Del]    Script Date: 08/19/2016 13:11:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItemSerial_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItemSerial_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItemSerial_Repl_Del]    Script Date: 08/19/2016 13:11:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItemSerial_Repl_Del] ON [dbo].[Pur_PurchaseItemSerial] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseItemSerial', 'DELETE FROM Pur_PurchaseItemSerial WHERE ' + 'Convert(varchar, IDPurchaseItemSerial)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseItemSerial), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItemSerial_Repl_InsUpt]    Script Date: 08/19/2016 13:12:16 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItemSerial_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItemSerial_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItemSerial_Repl_InsUpt]    Script Date: 08/19/2016 13:12:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItemSerial_Repl_InsUpt] ON [dbo].[Pur_PurchaseItemSerial] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pur_PurchaseItemSerial SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPurchaseItemSerial = Pur_PurchaseItemSerial.IDPurchaseItemSerial

       UPDATE Pur_PurchaseItemSerial SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPurchaseItemSerial = Pur_PurchaseItemSerial.IDPurchaseItemSerial

END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItemTax_Repl_Del]    Script Date: 08/19/2016 13:16:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItemTax_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItemTax_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItemTax_Repl_Del]    Script Date: 08/19/2016 13:16:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItemTax_Repl_Del] ON [dbo].[Pur_PurchaseItemTax] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseItemTax', 'DELETE FROM Pur_PurchaseItemTax WHERE ' + 'Convert(varchar, IDPurchaseItemTax)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseItemTax), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItemTax_Repl_InsUpt]    Script Date: 08/19/2016 13:17:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItemTax_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItemTax_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItemTax_Repl_InsUpt]    Script Date: 08/19/2016 13:17:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItemTax_Repl_InsUpt] ON [dbo].[Pur_PurchaseItemTax] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pur_PurchaseItemTax SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPurchaseItemTax = Pur_PurchaseItemTax.IDPurchaseItemTax

       UPDATE Pur_PurchaseItemTax SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPurchaseItemTax = Pur_PurchaseItemTax.IDPurchaseItemTax

END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItemTaxRet_Repl_Del]    Script Date: 08/19/2016 13:19:07 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItemTaxRet_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItemTaxRet_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItemTaxRet_Repl_Del]    Script Date: 08/19/2016 13:19:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItemTaxRet_Repl_Del] ON [dbo].[Pur_PurchaseItemTaxRet] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseItemTaxRet', 'DELETE FROM Pur_PurchaseItemTaxRet WHERE ' + 'Convert(varchar, IDPurchaseItemTaxRet)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseItemTaxRet), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseItemTaxRet_Repl_InsUpt]    Script Date: 08/19/2016 13:19:53 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseItemTaxRet_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseItemTaxRet_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseItemTaxRet_Repl_InsUpt]    Script Date: 08/19/2016 13:19:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseItemTaxRet_Repl_InsUpt] ON [dbo].[Pur_PurchaseItemTaxRet] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pur_PurchaseItemTaxRet SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPurchaseItemTaxRet = Pur_PurchaseItemTaxRet.IDPurchaseItemTaxRet

       UPDATE Pur_PurchaseItemTaxRet SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPurchaseItemTaxRet = Pur_PurchaseItemTaxRet.IDPurchaseItemTaxRet

END
GO

/****** Object:  Trigger [tr_Pur_PurchaseQtyOrder_Repl_Del]    Script Date: 08/19/2016 13:22:55 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseQtyOrder_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseQtyOrder_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseQtyOrder_Repl_Del]    Script Date: 08/19/2016 13:22:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseQtyOrder_Repl_Del] ON [dbo].[Pur_PurchaseQtyOrder] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseQtyOrder', 'DELETE FROM Pur_PurchaseQtyOrder WHERE ' + 'Convert(varchar, IDPurchaseQtyOrder)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseQtyOrder), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseQtyPrePurchase_Repl_Del]    Script Date: 08/19/2016 13:25:40 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseQtyPrePurchase_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseQtyPrePurchase_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseQtyPrePurchase_Repl_Del]    Script Date: 08/19/2016 13:25:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseQtyPrePurchase_Repl_Del] ON [dbo].[Pur_PurchaseQtyPrePurchase] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseQtyPrePurchase', 'DELETE FROM Pur_PurchaseQtyPrePurchase WHERE ' + 'Convert(varchar, IDPurchaseQtyPreSale)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseQtyPreSale), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseTerm_Repl_Del]    Script Date: 08/19/2016 16:28:19 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseTerm_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseTerm_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseTerm_Repl_Del]    Script Date: 08/19/2016 16:28:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseTerm_Repl_Del] ON [dbo].[Pur_PurchaseTerm] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseTerm', 'DELETE FROM Pur_PurchaseTerm WHERE ' + 'Convert(varchar, IDPurchase)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchase), CHAR(39)) + ' AND ' + 'Convert(varchar, DueDateShift)  = ' + QuoteName(Convert(varchar, DELETED.DueDateShift), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Pur_PurchaseTerm_Repl_InsUpt]    Script Date: 08/19/2016 13:40:59 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseTerm_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseTerm_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseTerm_Repl_InsUpt]    Script Date: 08/19/2016 13:40:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseTerm_Repl_InsUpt] ON [dbo].[Pur_PurchaseTerm] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pur_PurchaseTerm SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPurchase = Pur_PurchaseTerm.IDPurchase
AND
INSERTED.DueDateShift = Pur_PurchaseTerm.DueDateShift

       UPDATE Pur_PurchaseTerm SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPurchase = Pur_PurchaseTerm.IDPurchase
AND
DELETED.DueDateShift = Pur_PurchaseTerm.DueDateShift

END
GO

/****** Object:  Trigger [tr_Pur_PurchaseTotal_Repl_Del]    Script Date: 08/19/2016 13:42:39 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseTotal_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseTotal_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Pur_PurchaseTotal_Repl_Del]    Script Date: 08/19/2016 13:42:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseTotal_Repl_Del] ON [dbo].[Pur_PurchaseTotal] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseTotal', 'DELETE FROM Pur_PurchaseTotal WHERE ' + 'Convert(varchar, IDPurchase)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchase), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_RemoveZeroQtyPIMs]    Script Date: 05/16/2016 20:37:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_RemoveZeroQtyPIMs]'))
DROP TRIGGER [dbo].[tr_RemoveZeroQtyPIMs]
GO


/****** Object:  Trigger [dbo].[tr_RemoveZeroQtyPIMs]    Script Date: 05/16/2016 20:37:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[tr_RemoveZeroQtyPIMs] on [dbo].[PreInventoryMov] for insert, update as
    set nocount on;

    -- Delete extra commissions.
    delete from SaleItemCommission where IDPreInventoryMov in (
            select IDPreInventoryMov from PreInventoryMov where
                Qty = 0
                and InventMovTypeID = 1
                and IDPreInventoryMov in (
                    select IDPreInventoryMov from inserted
                )
    );

    delete from PreInventoryMov
    where
        Qty = 0
        and InventMovTypeID = 1
        and IDPreInventoryMov in (
            select IDPreInventoryMov from inserted
        );

GO

/****** Object:  Trigger [tr_PT_GlobalSetting_Repl_Del]    Script Date: 05/16/2016 20:38:48 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PT_GlobalSetting_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PT_GlobalSetting_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_PT_GlobalSetting_Repl_Del]    Script Date: 05/16/2016 20:38:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PT_GlobalSetting_Repl_Del] ON [dbo].[PT_GlobalSetting] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PT_GlobalSetting', 'DELETE FROM PT_GlobalSetting WHERE ' + 'Convert(varchar, Id)  = ' + QuoteName(Convert(varchar, DELETED.Id), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_PT_GlobalSetting_Repl_InsUpt]    Script Date: 05/16/2016 20:39:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PT_GlobalSetting_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_PT_GlobalSetting_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_PT_GlobalSetting_Repl_InsUpt]    Script Date: 05/16/2016 20:39:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PT_GlobalSetting_Repl_InsUpt] ON [dbo].[PT_GlobalSetting] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE PT_GlobalSetting SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Id = PT_GlobalSetting.Id

       UPDATE PT_GlobalSetting SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Id = PT_GlobalSetting.Id

END
GO

/****** Object:  Trigger [tr_PT_GlobalSettingDetail_Repl_Del]    Script Date: 05/16/2016 20:40:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PT_GlobalSettingDetail_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PT_GlobalSettingDetail_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_PT_GlobalSettingDetail_Repl_Del]    Script Date: 05/16/2016 20:40:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PT_GlobalSettingDetail_Repl_Del] ON [dbo].[PT_GlobalSettingDetail] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PT_GlobalSettingDetail', 'DELETE FROM PT_GlobalSettingDetail WHERE ' + 'Convert(varchar, Id)  = ' + QuoteName(Convert(varchar, DELETED.Id), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_PT_GlobalSettingDetail_Repl_InsUpt]    Script Date: 05/16/2016 20:41:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PT_GlobalSettingDetail_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_PT_GlobalSettingDetail_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_PT_GlobalSettingDetail_Repl_InsUpt]    Script Date: 05/16/2016 20:41:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PT_GlobalSettingDetail_Repl_InsUpt] ON [dbo].[PT_GlobalSettingDetail] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE PT_GlobalSettingDetail SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Id = PT_GlobalSettingDetail.Id

       UPDATE PT_GlobalSettingDetail SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Id = PT_GlobalSettingDetail.Id

END
GO

/****** Object:  Trigger [tr_PT_LocalSetting_Repl_Del]    Script Date: 05/16/2016 20:42:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PT_LocalSetting_Repl_Del]'))
DROP TRIGGER [dbo].[tr_PT_LocalSetting_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_PT_LocalSetting_Repl_Del]    Script Date: 05/16/2016 20:42:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PT_LocalSetting_Repl_Del] ON [dbo].[PT_LocalSetting] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'PT_LocalSetting', 'DELETE FROM PT_LocalSetting WHERE ' + 'Convert(varchar, Id)  = ' + QuoteName(Convert(varchar, DELETED.Id), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_PT_LocalSetting_Repl_InsUpt]    Script Date: 05/16/2016 20:42:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_PT_LocalSetting_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_PT_LocalSetting_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_PT_LocalSetting_Repl_InsUpt]    Script Date: 05/16/2016 20:42:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_PT_LocalSetting_Repl_InsUpt] ON [dbo].[PT_LocalSetting] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE PT_LocalSetting SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Id = PT_LocalSetting.Id

       UPDATE PT_LocalSetting SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Id = PT_LocalSetting.Id

END
GO

/****** Object:  Trigger [tr_Pur_PurchaseVerify_Repl_Del]    Script Date: 05/16/2016 20:44:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseVerify_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseVerify_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Pur_PurchaseVerify_Repl_Del]    Script Date: 05/16/2016 20:44:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseVerify_Repl_Del] ON [dbo].[Pur_PurchaseVerify] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Pur_PurchaseVerify', 'DELETE FROM Pur_PurchaseVerify WHERE ' + 'Convert(varchar, IDPurchaseVerify)  = ' + QuoteName(Convert(varchar, DELETED.IDPurchaseVerify), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Pur_PurchaseVerify_Repl_InsUpt]    Script Date: 05/16/2016 20:45:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Pur_PurchaseVerify_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Pur_PurchaseVerify_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Pur_PurchaseVerify_Repl_InsUpt]    Script Date: 05/16/2016 20:45:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Pur_PurchaseVerify_Repl_InsUpt] ON [dbo].[Pur_PurchaseVerify] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Pur_PurchaseVerify SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPurchaseVerify = Pur_PurchaseVerify.IDPurchaseVerify

       UPDATE Pur_PurchaseVerify SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPurchaseVerify = Pur_PurchaseVerify.IDPurchaseVerify

END
GO

/****** Object:  Trigger [tr_RemoveTagModelDuplicates]    Script Date: 05/27/2016 14:18:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_RemoveTagModelDuplicates]'))
DROP TRIGGER [dbo].[tr_RemoveTagModelDuplicates]
GO


/****** Object:  Trigger [dbo].[tr_RemoveTagModelDuplicates]    Script Date: 05/27/2016 14:18:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[tr_RemoveTagModelDuplicates] on [dbo].[TagModel] for insert, update as
    set nocount on;

    with TagModelRowsToKeep as (
        select IDTag, IDModel, min(PKTagModel) as PKTagModelToKeep
        from TagModel
        group by IDTag, IDModel
    )
    delete from TagModel where PKTagModel not in (
        select PKTagModelToKeep from TagModelRowsToKeep
    );

GO

/****** Object:  Trigger [tr_Repair_Repl_Del]    Script Date: 08/19/2016 13:44:55 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Repair_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Repair_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Repair_Repl_Del]    Script Date: 08/19/2016 13:44:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Repair_Repl_Del] ON [dbo].[Repair] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Repair', 'DELETE FROM Repair WHERE ' + 'Convert(varchar, IDRepair)  = ' + QuoteName(Convert(varchar, DELETED.IDRepair), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Request_Repl_Del]    Script Date: 08/19/2016 13:50:50 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Request_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Request_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Request_Repl_Del]    Script Date: 08/19/2016 13:50:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Request_Repl_Del] ON [dbo].[Request] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Request', 'DELETE FROM Request WHERE ' + 'Convert(varchar, IDRequest)  = ' + QuoteName(Convert(varchar, DELETED.IDRequest), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Results_Repl_InsUpt]    Script Date: 05/16/2016 20:46:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Results_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Results_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Results_Repl_InsUpt]    Script Date: 05/16/2016 20:46:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Results_Repl_InsUpt] ON [dbo].[Results] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Results SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Results SET ReplLastChange = GETDATE() FROM DELETED  
END
GO

/****** Object:  Trigger [tr_RoundingTable_Repl_Del]    Script Date: 05/16/2016 20:47:30 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_RoundingTable_Repl_Del]'))
DROP TRIGGER [dbo].[tr_RoundingTable_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_RoundingTable_Repl_Del]    Script Date: 05/16/2016 20:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_RoundingTable_Repl_Del] ON [dbo].[RoundingTable] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'RoundingTable', 'DELETE FROM RoundingTable WHERE ' + 'Convert(varchar, IDRoundingTable)  = ' + QuoteName(Convert(varchar, DELETED.IDRoundingTable), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_RoundingTable_Repl_InsUpt]    Script Date: 05/16/2016 20:48:09 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_RoundingTable_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_RoundingTable_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_RoundingTable_Repl_InsUpt]    Script Date: 05/16/2016 20:48:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_RoundingTable_Repl_InsUpt] ON [dbo].[RoundingTable] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE RoundingTable SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRoundingTable = RoundingTable.IDRoundingTable

       UPDATE RoundingTable SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRoundingTable = RoundingTable.IDRoundingTable

END

GO

/****** Object:  Trigger [tr_RoundingTableRange_Repl_Del]    Script Date: 05/16/2016 20:49:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_RoundingTableRange_Repl_Del]'))
DROP TRIGGER [dbo].[tr_RoundingTableRange_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_RoundingTableRange_Repl_Del]    Script Date: 05/16/2016 20:49:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_RoundingTableRange_Repl_Del] ON [dbo].[RoundingTableRange] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'RoundingTableRange', 'DELETE FROM RoundingTableRange WHERE ' + 'Convert(varchar, IDRoundingTableRange)  = ' + QuoteName(Convert(varchar, DELETED.IDRoundingTableRange), CHAR(39)), GetDate() FROM DELETED
END

GO
GO

/****** Object:  Trigger [tr_RoundingTableRange_Repl_InsUpt]    Script Date: 05/16/2016 20:49:54 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_RoundingTableRange_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_RoundingTableRange_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_RoundingTableRange_Repl_InsUpt]    Script Date: 05/16/2016 20:49:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_RoundingTableRange_Repl_InsUpt] ON [dbo].[RoundingTableRange] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE RoundingTableRange SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRoundingTableRange = RoundingTableRange.IDRoundingTableRange

       UPDATE RoundingTableRange SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRoundingTableRange = RoundingTableRange.IDRoundingTableRange

END

GO

/****** Object:  Trigger [tr_Sal_Discount_Repl_Del]    Script Date: 08/19/2016 13:53:53 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_Discount_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_Discount_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Sal_Discount_Repl_Del]    Script Date: 08/19/2016 13:53:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_Discount_Repl_Del] ON [dbo].[Sal_Discount] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_Discount', 'DELETE FROM Sal_Discount WHERE ' + 'Convert(varchar, IDDiscount)  = ' + QuoteName(Convert(varchar, DELETED.IDDiscount), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_Discount_Repl_InsUpt]    Script Date: 08/19/2016 13:56:31 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_Discount_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_Discount_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Sal_Discount_Repl_InsUpt]    Script Date: 08/19/2016 13:56:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_Discount_Repl_InsUpt] ON [dbo].[Sal_Discount] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_Discount SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDDiscount = Sal_Discount.IDDiscount

       UPDATE Sal_Discount SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDDiscount = Sal_Discount.IDDiscount

END
GO

/****** Object:  Trigger [tr_Sal_DrawerKickLog_Repl_Del]    Script Date: 08/19/2016 13:58:32 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_DrawerKickLog_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_DrawerKickLog_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Sal_DrawerKickLog_Repl_Del]    Script Date: 08/19/2016 13:58:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_DrawerKickLog_Repl_Del] ON [dbo].[Sal_DrawerKickLog] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_DrawerKickLog', 'DELETE FROM Sal_DrawerKickLog WHERE ' + 'Convert(varchar, IDDrawerKickLog)  = ' + QuoteName(Convert(varchar, DELETED.IDDrawerKickLog), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_FrequentPromo_Repl_Del]    Script Date: 05/16/2016 20:53:52 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_FrequentPromo_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_FrequentPromo_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_FrequentPromo_Repl_Del]    Script Date: 05/16/2016 20:53:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_FrequentPromo_Repl_Del] ON [dbo].[Sal_FrequentPromo] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_FrequentPromo', 'DELETE FROM Sal_FrequentPromo WHERE ' + 'Convert(varchar, IDFrequentPromo)  = ' + QuoteName(Convert(varchar, DELETED.IDFrequentPromo), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_FrequentPromo_Repl_InsUpt]    Script Date: 05/16/2016 20:54:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_FrequentPromo_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_FrequentPromo_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_FrequentPromo_Repl_InsUpt]    Script Date: 05/16/2016 20:54:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_FrequentPromo_Repl_InsUpt] ON [dbo].[Sal_FrequentPromo] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_FrequentPromo SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDFrequentPromo = Sal_FrequentPromo.IDFrequentPromo

       UPDATE Sal_FrequentPromo SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDFrequentPromo = Sal_FrequentPromo.IDFrequentPromo

END
GO

/****** Object:  Trigger [tr_Sal_InvoiceShipping_Repl_Del]    Script Date: 08/19/2016 14:02:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_InvoiceShipping_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_InvoiceShipping_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Sal_InvoiceShipping_Repl_Del]    Script Date: 08/19/2016 14:02:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_InvoiceShipping_Repl_Del] ON [dbo].[Sal_InvoiceShipping] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_InvoiceShipping', 'DELETE FROM Sal_InvoiceShipping WHERE ' + 'Convert(varchar, IDInvoiceShipping)  = ' + QuoteName(Convert(varchar, DELETED.IDInvoiceShipping), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_InvoiceShipping_Repl_InsUpt]    Script Date: 08/19/2016 14:03:31 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_InvoiceShipping_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_InvoiceShipping_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Sal_InvoiceShipping_Repl_InsUpt]    Script Date: 08/19/2016 14:03:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_InvoiceShipping_Repl_InsUpt] ON [dbo].[Sal_InvoiceShipping] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_InvoiceShipping SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDInvoiceShipping = Sal_InvoiceShipping.IDInvoiceShipping

       UPDATE Sal_InvoiceShipping SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDInvoiceShipping = Sal_InvoiceShipping.IDInvoiceShipping

END
GO

/****** Object:  Trigger [tr_Sal_ItemRepair_Repl_Del]    Script Date: 08/19/2016 14:05:16 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_ItemRepair_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_ItemRepair_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Sal_ItemRepair_Repl_Del]    Script Date: 08/19/2016 14:05:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_ItemRepair_Repl_Del] ON [dbo].[Sal_ItemRepair] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_ItemRepair', 'DELETE FROM Sal_ItemRepair WHERE ' + 'Convert(varchar, IDItemRepair)  = ' + QuoteName(Convert(varchar, DELETED.IDItemRepair), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Sal_NotasCanceladas_Repl_Del]    Script Date: 05/16/2016 20:56:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_NotasCanceladas_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_NotasCanceladas_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_NotasCanceladas_Repl_Del]    Script Date: 05/16/2016 20:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_NotasCanceladas_Repl_Del] ON [dbo].[Sal_NotasCanceladas] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_NotasCanceladas', 'DELETE FROM Sal_NotasCanceladas WHERE ' + 'Convert(varchar, IDNotasCanceladas)  = ' + QuoteName(Convert(varchar, DELETED.IDNotasCanceladas), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_NotasCanceladas_Repl_InsUpt]    Script Date: 05/16/2016 20:57:08 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_NotasCanceladas_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_NotasCanceladas_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_NotasCanceladas_Repl_InsUpt]    Script Date: 05/16/2016 20:57:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_NotasCanceladas_Repl_InsUpt] ON [dbo].[Sal_NotasCanceladas] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_NotasCanceladas SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDNotasCanceladas = Sal_NotasCanceladas.IDNotasCanceladas

       UPDATE Sal_NotasCanceladas SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDNotasCanceladas = Sal_NotasCanceladas.IDNotasCanceladas

END
GO

/****** Object:  Trigger [tr_Sal_NotasCanceladas_Repl_Del]    Script Date: 05/16/2016 20:58:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_NotasCanceladas_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_NotasCanceladas_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_NotasCanceladas_Repl_Del]    Script Date: 05/16/2016 20:58:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_NotasCanceladas_Repl_Del] ON [dbo].[Sal_NotasCanceladas] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_NotasCanceladas', 'DELETE FROM Sal_NotasCanceladas WHERE ' + 'Convert(varchar, IDNotasCanceladas)  = ' + QuoteName(Convert(varchar, DELETED.IDNotasCanceladas), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_PaymentCondition_Repl_InsUpt]    Script Date: 05/16/2016 20:59:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PaymentCondition_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_PaymentCondition_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PaymentCondition_Repl_InsUpt]    Script Date: 05/16/2016 20:59:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PaymentCondition_Repl_InsUpt] ON [dbo].[Sal_PaymentCondition] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_PaymentCondition SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPaymentCondition = Sal_PaymentCondition.IDPaymentCondition

       UPDATE Sal_PaymentCondition SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPaymentCondition = Sal_PaymentCondition.IDPaymentCondition

END
GO

/****** Object:  Trigger [tr_Sal_PaymentCondition_Repl_Del]    Script Date: 05/16/2016 21:00:47 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PaymentCondition_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_PaymentCondition_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PaymentCondition_Repl_Del]    Script Date: 05/16/2016 21:00:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PaymentCondition_Repl_Del] ON [dbo].[Sal_PaymentCondition] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_PaymentCondition', 'DELETE FROM Sal_PaymentCondition WHERE ' + 'Convert(varchar, IDPaymentCondition)  = ' + QuoteName(Convert(varchar, DELETED.IDPaymentCondition), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_PaymentDiscount_Repl_Del]    Script Date: 05/16/2016 21:04:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PaymentDiscount_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_PaymentDiscount_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PaymentDiscount_Repl_Del]    Script Date: 05/16/2016 21:04:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PaymentDiscount_Repl_Del] ON [dbo].[Sal_PaymentDiscount] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_PaymentDiscount', 'DELETE FROM Sal_PaymentDiscount WHERE ' + 'Convert(varchar, IDPaymentDiscount)  = ' + QuoteName(Convert(varchar, DELETED.IDPaymentDiscount), CHAR(39)), GetDate() FROM DELETED
END
GO


/****** Object:  Trigger [tr_Sal_PaymentDiscount_Repl_InsUpt]    Script Date: 05/16/2016 21:05:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PaymentDiscount_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_PaymentDiscount_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PaymentDiscount_Repl_InsUpt]    Script Date: 05/16/2016 21:05:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PaymentDiscount_Repl_InsUpt] ON [dbo].[Sal_PaymentDiscount] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_PaymentDiscount SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPaymentDiscount = Sal_PaymentDiscount.IDPaymentDiscount

       UPDATE Sal_PaymentDiscount SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPaymentDiscount = Sal_PaymentDiscount.IDPaymentDiscount

END
GO


/****** Object:  Trigger [tr_Sal_Promo_Repl_Del]    Script Date: 05/16/2016 21:06:30 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_Promo_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_Promo_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_Promo_Repl_Del]    Script Date: 05/16/2016 21:06:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_Promo_Repl_Del] ON [dbo].[Sal_Promo] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_Promo', 'DELETE FROM Sal_Promo WHERE ' + 'Convert(varchar, IDPromo)  = ' + QuoteName(Convert(varchar, DELETED.IDPromo), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_Sal_Promo_Repl_InsUpt]    Script Date: 05/16/2016 21:07:53 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_Promo_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_Promo_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_Promo_Repl_InsUpt]    Script Date: 05/16/2016 21:07:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_Promo_Repl_InsUpt] ON [dbo].[Sal_Promo] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_Promo SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPromo = Sal_Promo.IDPromo

       UPDATE Sal_Promo SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPromo = Sal_Promo.IDPromo

END

GO

/****** Object:  Trigger [tr_Sal_PromoItem_Repl_Del]    Script Date: 05/16/2016 21:09:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PromoItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_PromoItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PromoItem_Repl_Del]    Script Date: 05/16/2016 21:09:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PromoItem_Repl_Del] ON [dbo].[Sal_PromoItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_PromoItem', 'DELETE FROM Sal_PromoItem WHERE ' + 'Convert(varchar, IDPromoItem)  = ' + QuoteName(Convert(varchar, DELETED.IDPromoItem), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_Sal_PromoItem_Repl_InsUpt]    Script Date: 05/16/2016 21:10:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PromoItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_PromoItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PromoItem_Repl_InsUpt]    Script Date: 05/16/2016 21:10:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PromoItem_Repl_InsUpt] ON [dbo].[Sal_PromoItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_PromoItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPromoItem = Sal_PromoItem.IDPromoItem

       UPDATE Sal_PromoItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPromoItem = Sal_PromoItem.IDPromoItem

END

GO

/****** Object:  Trigger [tr_Sal_PromoLoyaltyCustomer_Repl_Del]    Script Date: 05/16/2016 21:11:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_Del]    Script Date: 05/16/2016 21:11:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_Del] ON [dbo].[Sal_PromoLoyaltyCustomer] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_PromoLoyaltyCustomer', 'DELETE FROM Sal_PromoLoyaltyCustomer WHERE ' + 'Convert(varchar, IDPromo)  = ' + QuoteName(Convert(varchar, DELETED.IDPromo), CHAR(39)) + ' AND ' + 'Convert(varchar, IDTipoPessoa)  = ' + QuoteName(Convert(varchar, DELETED.IDTipoPessoa), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_Sal_PromoLoyaltyCustomer_Repl_InsUpt]    Script Date: 05/16/2016 21:12:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_InsUpt]    Script Date: 05/16/2016 21:12:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PromoLoyaltyCustomer_Repl_InsUpt] ON [dbo].[Sal_PromoLoyaltyCustomer] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_PromoLoyaltyCustomer SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPromo = Sal_PromoLoyaltyCustomer.IDPromo
AND
INSERTED.IDTipoPessoa = Sal_PromoLoyaltyCustomer.IDTipoPessoa

       UPDATE Sal_PromoLoyaltyCustomer SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPromo = Sal_PromoLoyaltyCustomer.IDPromo
AND
DELETED.IDTipoPessoa = Sal_PromoLoyaltyCustomer.IDTipoPessoa

END

GO

/****** Object:  Trigger [tr_Sal_PromoPrizeItem_Repl_Del]    Script Date: 05/16/2016 21:13:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PromoPrizeItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_PromoPrizeItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PromoPrizeItem_Repl_Del]    Script Date: 05/16/2016 21:13:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PromoPrizeItem_Repl_Del] ON [dbo].[Sal_PromoPrizeItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_PromoPrizeItem', 'DELETE FROM Sal_PromoPrizeItem WHERE ' + 'Convert(varchar, IDPromoPrizeItem)  = ' + QuoteName(Convert(varchar, DELETED.IDPromoPrizeItem), CHAR(39)), GetDate() FROM DELETED
END

GO

/****** Object:  Trigger [tr_Sal_PromoPrizeItem_Repl_InsUpt]    Script Date: 05/16/2016 21:14:49 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_PromoPrizeItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_PromoPrizeItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_PromoPrizeItem_Repl_InsUpt]    Script Date: 05/16/2016 21:14:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_PromoPrizeItem_Repl_InsUpt] ON [dbo].[Sal_PromoPrizeItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_PromoPrizeItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDPromoPrizeItem = Sal_PromoPrizeItem.IDPromoPrizeItem

       UPDATE Sal_PromoPrizeItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDPromoPrizeItem = Sal_PromoPrizeItem.IDPromoPrizeItem

END

GO

/****** Object:  Trigger [tr_Sal_RebateCalendar_Repl_Del]    Script Date: 05/16/2016 21:16:03 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RebateCalendar_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_RebateCalendar_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RebateCalendar_Repl_Del]    Script Date: 05/16/2016 21:16:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RebateCalendar_Repl_Del] ON [dbo].[Sal_RebateCalendar] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_RebateCalendar', 'DELETE FROM Sal_RebateCalendar WHERE ' + 'Convert(varchar, IDRebateCalendar)  = ' + QuoteName(Convert(varchar, DELETED.IDRebateCalendar), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_RebateCalendar_Repl_InsUpt]    Script Date: 05/16/2016 21:17:40 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RebateCalendar_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_RebateCalendar_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RebateCalendar_Repl_InsUpt]    Script Date: 05/16/2016 21:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RebateCalendar_Repl_InsUpt] ON [dbo].[Sal_RebateCalendar] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_RebateCalendar SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRebateCalendar = Sal_RebateCalendar.IDRebateCalendar

       UPDATE Sal_RebateCalendar SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRebateCalendar = Sal_RebateCalendar.IDRebateCalendar

END
GO

/****** Object:  Trigger [tr_Sal_RebateItem_Repl_Del]    Script Date: 05/16/2016 21:18:40 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RebateItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_RebateItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RebateItem_Repl_Del]    Script Date: 05/16/2016 21:18:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RebateItem_Repl_Del] ON [dbo].[Sal_RebateItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_RebateItem', 'DELETE FROM Sal_RebateItem WHERE ' + 'Convert(varchar, IDRebateItem)  = ' + QuoteName(Convert(varchar, DELETED.IDRebateItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_RebateItem_Repl_InsUpt]    Script Date: 05/16/2016 21:19:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RebateItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_RebateItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RebateItem_Repl_InsUpt]    Script Date: 05/16/2016 21:19:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RebateItem_Repl_InsUpt] ON [dbo].[Sal_RebateItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_RebateItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRebateItem = Sal_RebateItem.IDRebateItem

       UPDATE Sal_RebateItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRebateItem = Sal_RebateItem.IDRebateItem

END
GO

/****** Object:  Trigger [tr_Sal_RebateItemCalendar_Repl_Del]    Script Date: 05/16/2016 21:20:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RebateItemCalendar_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_RebateItemCalendar_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RebateItemCalendar_Repl_Del]    Script Date: 05/16/2016 21:20:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RebateItemCalendar_Repl_Del] ON [dbo].[Sal_RebateItemCalendar] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_RebateItemCalendar', 'DELETE FROM Sal_RebateItemCalendar WHERE ' + 'Convert(varchar, IDRebateItem)  = ' + QuoteName(Convert(varchar, DELETED.IDRebateItem), CHAR(39)) + ' AND ' + 'Convert(varchar, IDRebateCalendar)  = ' + QuoteName(Convert(varchar, DELETED.IDRebateCalendar), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_RebateItemCalendar_Repl_InsUpt]    Script Date: 05/16/2016 21:21:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RebateItemCalendar_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_RebateItemCalendar_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RebateItemCalendar_Repl_InsUpt]    Script Date: 05/16/2016 21:21:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RebateItemCalendar_Repl_InsUpt] ON [dbo].[Sal_RebateItemCalendar] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_RebateItemCalendar SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRebateItem = Sal_RebateItemCalendar.IDRebateItem
AND
INSERTED.IDRebateCalendar = Sal_RebateItemCalendar.IDRebateCalendar

       UPDATE Sal_RebateItemCalendar SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRebateItem = Sal_RebateItemCalendar.IDRebateItem
AND
DELETED.IDRebateCalendar = Sal_RebateItemCalendar.IDRebateCalendar

END
GO

/****** Object:  Trigger [tr_Sal_ReducaoZ_Repl_Del]    Script Date: 05/16/2016 21:22:37 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_ReducaoZ_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_ReducaoZ_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_ReducaoZ_Repl_Del]    Script Date: 05/16/2016 21:22:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_ReducaoZ_Repl_Del] ON [dbo].[Sal_ReducaoZ] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_ReducaoZ', 'DELETE FROM Sal_ReducaoZ WHERE ' + 'Convert(varchar, IDReducaoZ)  = ' + QuoteName(Convert(varchar, DELETED.IDReducaoZ), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_ReducaoZ_Repl_InsUpt]    Script Date: 05/16/2016 21:23:28 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_ReducaoZ_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_ReducaoZ_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_ReducaoZ_Repl_InsUpt]    Script Date: 05/16/2016 21:23:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_ReducaoZ_Repl_InsUpt] ON [dbo].[Sal_ReducaoZ] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_ReducaoZ SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDReducaoZ = Sal_ReducaoZ.IDReducaoZ

       UPDATE Sal_ReducaoZ SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDReducaoZ = Sal_ReducaoZ.IDReducaoZ

END
GO

/****** Object:  Trigger [tr_Sal_RemovedItem_Repl_Del]    Script Date: 05/16/2016 21:24:22 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RemovedItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_RemovedItem_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RemovedItem_Repl_Del]    Script Date: 05/16/2016 21:24:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RemovedItem_Repl_Del] ON [dbo].[Sal_RemovedItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_RemovedItem', 'DELETE FROM Sal_RemovedItem WHERE ' + 'Convert(varchar, IDRemovedItem)  = ' + QuoteName(Convert(varchar, DELETED.IDRemovedItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_RemovedItem_Repl_InsUpt]    Script Date: 05/16/2016 21:25:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_RemovedItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_RemovedItem_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_RemovedItem_Repl_InsUpt]    Script Date: 05/16/2016 21:25:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_RemovedItem_Repl_InsUpt] ON [dbo].[Sal_RemovedItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_RemovedItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRemovedItem = Sal_RemovedItem.IDRemovedItem

       UPDATE Sal_RemovedItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRemovedItem = Sal_RemovedItem.IDRemovedItem

END
GO

/****** Object:  Trigger [tr_Sal_StoreAccountLimetLog_Repl_Del]    Script Date: 05/16/2016 21:27:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_StoreAccountLimetLog_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_StoreAccountLimetLog_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_StoreAccountLimetLog_Repl_Del]    Script Date: 05/16/2016 21:27:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_StoreAccountLimetLog_Repl_Del] ON [dbo].[Sal_StoreAccountLimetLog] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_StoreAccountLimetLog', 'DELETE FROM Sal_StoreAccountLimetLog WHERE ' + 'Convert(varchar, IDStoreAccountLimtLog)  = ' + QuoteName(Convert(varchar, DELETED.IDStoreAccountLimtLog), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_StoreAccountLimetLog_Repl_InsUpt]    Script Date: 05/16/2016 21:29:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_StoreAccountLimetLog_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_StoreAccountLimetLog_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_StoreAccountLimetLog_Repl_InsUpt]    Script Date: 05/16/2016 21:29:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_StoreAccountLimetLog_Repl_InsUpt] ON [dbo].[Sal_StoreAccountLimetLog] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_StoreAccountLimetLog SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDStoreAccountLimtLog = Sal_StoreAccountLimetLog.IDStoreAccountLimtLog

       UPDATE Sal_StoreAccountLimetLog SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDStoreAccountLimtLog = Sal_StoreAccountLimetLog.IDStoreAccountLimtLog

END
GO

/****** Object:  Trigger [tr_Sal_TotalizadorParcial_Repl_Del]    Script Date: 05/16/2016 21:29:52 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TotalizadorParcial_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_TotalizadorParcial_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_TotalizadorParcial_Repl_Del]    Script Date: 05/16/2016 21:29:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TotalizadorParcial_Repl_Del] ON [dbo].[Sal_TotalizadorParcial] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_TotalizadorParcial', 'DELETE FROM Sal_TotalizadorParcial WHERE ' + 'Convert(varchar, IDTotalizadorParcial)  = ' + QuoteName(Convert(varchar, DELETED.IDTotalizadorParcial), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_TotalizadorParcial_Repl_InsUpt]    Script Date: 05/16/2016 21:30:37 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TotalizadorParcial_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_TotalizadorParcial_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_TotalizadorParcial_Repl_InsUpt]    Script Date: 05/16/2016 21:30:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TotalizadorParcial_Repl_InsUpt] ON [dbo].[Sal_TotalizadorParcial] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_TotalizadorParcial SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDTotalizadorParcial = Sal_TotalizadorParcial.IDTotalizadorParcial

       UPDATE Sal_TotalizadorParcial SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDTotalizadorParcial = Sal_TotalizadorParcial.IDTotalizadorParcial

END
GO

/****** Object:  Trigger [tr_Sal_TrafficBox_Repl_Del]    Script Date: 08/19/2016 14:07:41 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TrafficBox_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_TrafficBox_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Sal_TrafficBox_Repl_Del]    Script Date: 08/19/2016 14:07:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TrafficBox_Repl_Del] ON [dbo].[Sal_TrafficBox] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_TrafficBox', 'DELETE FROM Sal_TrafficBox WHERE ' + 'Convert(varchar, IDTrafficBox)  = ' + QuoteName(Convert(varchar, DELETED.IDTrafficBox), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_TrafficBox_Repl_InsUpt]    Script Date: 08/19/2016 14:10:29 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TrafficBox_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_TrafficBox_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Sal_TrafficBox_Repl_InsUpt]    Script Date: 08/19/2016 14:10:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TrafficBox_Repl_InsUpt] ON [dbo].[Sal_TrafficBox] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_TrafficBox SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDTrafficBox = Sal_TrafficBox.IDTrafficBox

       UPDATE Sal_TrafficBox SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDTrafficBox = Sal_TrafficBox.IDTrafficBox

END
GO

/****** Object:  Trigger [tr_Sal_TrafficMov_Repl_Del]    Script Date: 08/19/2016 14:12:55 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TrafficMov_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_TrafficMov_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Sal_TrafficMov_Repl_Del]    Script Date: 08/19/2016 14:12:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TrafficMov_Repl_Del] ON [dbo].[Sal_TrafficMov] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_TrafficMov', 'DELETE FROM Sal_TrafficMov WHERE ' + 'Convert(varchar, IDTrafficMov)  = ' + QuoteName(Convert(varchar, DELETED.IDTrafficMov), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_TrafficMov_Repl_InsUpt]    Script Date: 08/19/2016 14:13:36 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TrafficMov_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_TrafficMov_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Sal_TrafficMov_Repl_InsUpt]    Script Date: 08/19/2016 14:13:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TrafficMov_Repl_InsUpt] ON [dbo].[Sal_TrafficMov] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_TrafficMov SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDTrafficMov = Sal_TrafficMov.IDTrafficMov

       UPDATE Sal_TrafficMov SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDTrafficMov = Sal_TrafficMov.IDTrafficMov

END
GO

/****** Object:  Trigger [tr_Sal_TributacaoECF_Repl_Del]    Script Date: 05/16/2016 21:31:48 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TributacaoECF_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sal_TributacaoECF_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sal_TributacaoECF_Repl_Del]    Script Date: 05/16/2016 21:31:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TributacaoECF_Repl_Del] ON [dbo].[Sal_TributacaoECF] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sal_TributacaoECF', 'DELETE FROM Sal_TributacaoECF WHERE ' + 'Convert(varchar, IDTributacaoECF)  = ' + QuoteName(Convert(varchar, DELETED.IDTributacaoECF), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sal_TributacaoECF_Repl_InsUpt]    Script Date: 05/16/2016 21:32:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sal_TributacaoECF_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sal_TributacaoECF_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sal_TributacaoECF_Repl_InsUpt]    Script Date: 05/16/2016 21:32:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sal_TributacaoECF_Repl_InsUpt] ON [dbo].[Sal_TributacaoECF] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sal_TributacaoECF SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDTributacaoECF = Sal_TributacaoECF.IDTributacaoECF

       UPDATE Sal_TributacaoECF SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDTributacaoECF = Sal_TributacaoECF.IDTributacaoECF

END
GO

/****** Object:  Trigger [tr_SaleItemCommission_Repl_Del]    Script Date: 08/19/2016 14:15:43 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SaleItemCommission_Repl_Del]'))
DROP TRIGGER [dbo].[tr_SaleItemCommission_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_SaleItemCommission_Repl_Del]    Script Date: 08/19/2016 14:15:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SaleItemCommission_Repl_Del] ON [dbo].[SaleItemCommission] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'SaleItemCommission', 'DELETE FROM SaleItemCommission WHERE ' + 'Convert(varchar, IDSaleItemCommission)  = ' + QuoteName(Convert(varchar, DELETED.IDSaleItemCommission), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_ServiceOrder_Repl_Del]    Script Date: 08/19/2016 14:19:49 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_ServiceOrder_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Ser_ServiceOrder_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Ser_ServiceOrder_Repl_Del]    Script Date: 08/19/2016 14:19:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_ServiceOrder_Repl_Del] ON [dbo].[Ser_ServiceOrder] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Ser_ServiceOrder', 'DELETE FROM Ser_ServiceOrder WHERE ' + 'Convert(varchar, IDServiceOrder)  = ' + QuoteName(Convert(varchar, DELETED.IDServiceOrder), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_ServiceOrder_Repl_InsUpt]    Script Date: 08/19/2016 14:22:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_ServiceOrder_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Ser_ServiceOrder_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Ser_ServiceOrder_Repl_InsUpt]    Script Date: 08/19/2016 14:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_ServiceOrder_Repl_InsUpt] ON [dbo].[Ser_ServiceOrder] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Ser_ServiceOrder SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDServiceOrder = Ser_ServiceOrder.IDServiceOrder

       UPDATE Ser_ServiceOrder SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDServiceOrder = Ser_ServiceOrder.IDServiceOrder

END
GO

/****** Object:  Trigger [tr_Ser_SOCustomerProduct_Repl_Del]    Script Date: 05/16/2016 21:36:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOCustomerProduct_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Ser_SOCustomerProduct_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Ser_SOCustomerProduct_Repl_Del]    Script Date: 05/16/2016 21:36:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOCustomerProduct_Repl_Del] ON [dbo].[Ser_SOCustomerProduct] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Ser_SOCustomerProduct', 'DELETE FROM Ser_SOCustomerProduct WHERE ' + 'Convert(varchar, IDSOCustomerProduct)  = ' + QuoteName(Convert(varchar, DELETED.IDSOCustomerProduct), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_SOCustomerProduct_Repl_InsUpt]    Script Date: 05/16/2016 21:37:24 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOCustomerProduct_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Ser_SOCustomerProduct_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Ser_SOCustomerProduct_Repl_InsUpt]    Script Date: 05/16/2016 21:37:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOCustomerProduct_Repl_InsUpt] ON [dbo].[Ser_SOCustomerProduct] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Ser_SOCustomerProduct SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSOCustomerProduct = Ser_SOCustomerProduct.IDSOCustomerProduct

       UPDATE Ser_SOCustomerProduct SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSOCustomerProduct = Ser_SOCustomerProduct.IDSOCustomerProduct

END
GO


/****** Object:  Trigger [tr_Ser_SOItem_Repl_Del]    Script Date: 08/19/2016 14:24:24 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOItem_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Ser_SOItem_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Ser_SOItem_Repl_Del]    Script Date: 08/19/2016 14:24:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOItem_Repl_Del] ON [dbo].[Ser_SOItem] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Ser_SOItem', 'DELETE FROM Ser_SOItem WHERE ' + 'Convert(varchar, IDSOItem)  = ' + QuoteName(Convert(varchar, DELETED.IDSOItem), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_SOItem_Repl_InsUpt]    Script Date: 08/19/2016 14:26:00 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOItem_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Ser_SOItem_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Ser_SOItem_Repl_InsUpt]    Script Date: 08/19/2016 14:26:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOItem_Repl_InsUpt] ON [dbo].[Ser_SOItem] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Ser_SOItem SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSOItem = Ser_SOItem.IDSOItem

       UPDATE Ser_SOItem SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSOItem = Ser_SOItem.IDSOItem

END
GO

/****** Object:  Trigger [tr_Ser_SOItemDefect_Repl_Del]    Script Date: 08/19/2016 14:27:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOItemDefect_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Ser_SOItemDefect_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Ser_SOItemDefect_Repl_Del]    Script Date: 08/19/2016 14:27:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOItemDefect_Repl_Del] ON [dbo].[Ser_SOItemDefect] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Ser_SOItemDefect', 'DELETE FROM Ser_SOItemDefect WHERE ' + 'Convert(varchar, IDSOItemDefect)  = ' + QuoteName(Convert(varchar, DELETED.IDSOItemDefect), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_SOItemDefect_Repl_InsUpt]    Script Date: 08/19/2016 14:28:51 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOItemDefect_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Ser_SOItemDefect_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Ser_SOItemDefect_Repl_InsUpt]    Script Date: 08/19/2016 14:28:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOItemDefect_Repl_InsUpt] ON [dbo].[Ser_SOItemDefect] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Ser_SOItemDefect SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSOItemDefect = Ser_SOItemDefect.IDSOItemDefect

       UPDATE Ser_SOItemDefect SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSOItemDefect = Ser_SOItemDefect.IDSOItemDefect

END
GO

/****** Object:  Trigger [tr_Ser_SOItemProduct_Repl_Del]    Script Date: 08/19/2016 14:30:50 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOItemProduct_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Ser_SOItemProduct_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_Ser_SOItemProduct_Repl_Del]    Script Date: 08/19/2016 14:30:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOItemProduct_Repl_Del] ON [dbo].[Ser_SOItemProduct] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Ser_SOItemProduct', 'DELETE FROM Ser_SOItemProduct WHERE ' + 'Convert(varchar, IDSOItemProduct)  = ' + QuoteName(Convert(varchar, DELETED.IDSOItemProduct), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_SOItemProduct_Repl_InsUpt]    Script Date: 08/19/2016 14:31:31 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOItemProduct_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Ser_SOItemProduct_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_Ser_SOItemProduct_Repl_InsUpt]    Script Date: 08/19/2016 14:31:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOItemProduct_Repl_InsUpt] ON [dbo].[Ser_SOItemProduct] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Ser_SOItemProduct SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSOItemProduct = Ser_SOItemProduct.IDSOItemProduct

       UPDATE Ser_SOItemProduct SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSOItemProduct = Ser_SOItemProduct.IDSOItemProduct

END
GO

/****** Object:  Trigger [tr_Ser_SOStatus_Repl_Del]    Script Date: 05/16/2016 21:38:50 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOStatus_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Ser_SOStatus_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Ser_SOStatus_Repl_Del]    Script Date: 05/16/2016 21:38:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOStatus_Repl_Del] ON [dbo].[Ser_SOStatus] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Ser_SOStatus', 'DELETE FROM Ser_SOStatus WHERE ' + 'Convert(varchar, IDSOStatus)  = ' + QuoteName(Convert(varchar, DELETED.IDSOStatus), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Ser_SOStatus_Repl_InsUpt]    Script Date: 05/16/2016 21:39:56 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Ser_SOStatus_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Ser_SOStatus_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Ser_SOStatus_Repl_InsUpt]    Script Date: 05/16/2016 21:39:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Ser_SOStatus_Repl_InsUpt] ON [dbo].[Ser_SOStatus] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Ser_SOStatus SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSOStatus = Ser_SOStatus.IDSOStatus

       UPDATE Ser_SOStatus SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSOStatus = Ser_SOStatus.IDSOStatus

END
GO

/****** Object:  Trigger [tr_Sis_AppHistory_Repl_Del]    Script Date: 05/16/2016 21:41:25 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_AppHistory_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_AppHistory_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_AppHistory_Repl_Del]    Script Date: 05/16/2016 21:41:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_AppHistory_Repl_Del] ON [dbo].[Sis_AppHistory] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_AppHistory', 'DELETE FROM Sis_AppHistory WHERE ' + 'Convert(varchar, IDHistory)  = ' + QuoteName(Convert(varchar, DELETED.IDHistory), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_AppHistory_Repl_InsUpt]    Script Date: 05/16/2016 21:42:04 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_AppHistory_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_AppHistory_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_AppHistory_Repl_InsUpt]    Script Date: 05/16/2016 21:42:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_AppHistory_Repl_InsUpt] ON [dbo].[Sis_AppHistory] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_AppHistory SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDHistory = Sis_AppHistory.IDHistory

       UPDATE Sis_AppHistory SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDHistory = Sis_AppHistory.IDHistory

END
GO

/****** Object:  Trigger [tr_Sis_CodigoIncremental_Repl_Del]    Script Date: 05/16/2016 21:43:11 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_CodigoIncremental_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_CodigoIncremental_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_CodigoIncremental_Repl_Del]    Script Date: 05/16/2016 21:43:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_CodigoIncremental_Repl_Del] ON [dbo].[Sis_CodigoIncremental] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_CodigoIncremental', 'DELETE FROM Sis_CodigoIncremental WHERE ' + 'Convert(varchar, Tabela)  = ' + QuoteName(Convert(varchar, DELETED.Tabela), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_CodigoIncremental_Repl_InsUpt]    Script Date: 05/16/2016 21:44:08 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_CodigoIncremental_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_CodigoIncremental_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_CodigoIncremental_Repl_InsUpt]    Script Date: 05/16/2016 21:44:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_CodigoIncremental_Repl_InsUpt] ON [dbo].[Sis_CodigoIncremental] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_CodigoIncremental SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Tabela = Sis_CodigoIncremental.Tabela

       UPDATE Sis_CodigoIncremental SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Tabela = Sis_CodigoIncremental.Tabela

END
GO

/****** Object:  Trigger [tr_Sis_ConfigExport_Repl_Del]    Script Date: 05/16/2016 21:45:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_ConfigExport_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_ConfigExport_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_ConfigExport_Repl_Del]    Script Date: 05/16/2016 21:45:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_ConfigExport_Repl_Del] ON [dbo].[Sis_ConfigExport] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_ConfigExport', 'DELETE FROM Sis_ConfigExport WHERE ' + 'Convert(varchar, IDConfigExport)  = ' + QuoteName(Convert(varchar, DELETED.IDConfigExport), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_ConfigExport_Repl_InsUpt]    Script Date: 05/16/2016 21:46:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_ConfigExport_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_ConfigExport_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_ConfigExport_Repl_InsUpt]    Script Date: 05/16/2016 21:46:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_ConfigExport_Repl_InsUpt] ON [dbo].[Sis_ConfigExport] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_ConfigExport SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDConfigExport = Sis_ConfigExport.IDConfigExport

       UPDATE Sis_ConfigExport SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDConfigExport = Sis_ConfigExport.IDConfigExport

END
GO

/****** Object:  Trigger [tr_Sis_ConfigImport_Repl_Del]    Script Date: 05/16/2016 21:48:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_ConfigImport_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_ConfigImport_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_ConfigImport_Repl_Del]    Script Date: 05/16/2016 21:48:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_ConfigImport_Repl_Del] ON [dbo].[Sis_ConfigImport] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_ConfigImport', 'DELETE FROM Sis_ConfigImport WHERE ' + 'Convert(varchar, IDConfigImport)  = ' + QuoteName(Convert(varchar, DELETED.IDConfigImport), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_ConfigImport_Repl_InsUpt]    Script Date: 05/16/2016 21:49:10 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_ConfigImport_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_ConfigImport_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_ConfigImport_Repl_InsUpt]    Script Date: 05/16/2016 21:49:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_ConfigImport_Repl_InsUpt] ON [dbo].[Sis_ConfigImport] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_ConfigImport SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDConfigImport = Sis_ConfigImport.IDConfigImport

       UPDATE Sis_ConfigImport SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDConfigImport = Sis_ConfigImport.IDConfigImport

END
GO

/****** Object:  Trigger [tr_Sis_Constante_Repl_Del]    Script Date: 05/16/2016 21:50:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Constante_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_Constante_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Constante_Repl_Del]    Script Date: 05/16/2016 21:50:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Constante_Repl_Del] ON [dbo].[Sis_Constante] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_Constante', 'DELETE FROM Sis_Constante WHERE ' + 'Convert(varchar, Constante)  = ' + QuoteName(Convert(varchar, DELETED.Constante), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_Constante_Repl_InsUpt]    Script Date: 05/16/2016 21:51:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Constante_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_Constante_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Constante_Repl_InsUpt]    Script Date: 05/16/2016 21:51:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Constante_Repl_InsUpt] ON [dbo].[Sis_Constante] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_Constante SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Constante = Sis_Constante.Constante

       UPDATE Sis_Constante SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Constante = Sis_Constante.Constante

END
GO

/****** Object:  Trigger [tr_Sis_GrupoMainMenuPagina_Repl_Del]    Script Date: 05/16/2016 21:52:11 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_GrupoMainMenuPagina_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_GrupoMainMenuPagina_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_GrupoMainMenuPagina_Repl_Del]    Script Date: 05/16/2016 21:52:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_GrupoMainMenuPagina_Repl_Del] ON [dbo].[Sis_GrupoMainMenuPagina] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_GrupoMainMenuPagina', 'DELETE FROM Sis_GrupoMainMenuPagina WHERE ' + 'Convert(varchar, IDMenuItem)  = ' + QuoteName(Convert(varchar, DELETED.IDMenuItem), CHAR(39)) + ' AND ' + 'Convert(varchar, PaginaNome)  = ' + QuoteName(Convert(varchar, DELETED.PaginaNome), CHAR(39)) + ' AND ' + 'Convert(varchar, IDGrupo)  = ' + QuoteName(Convert(varchar, DELETED.IDGrupo), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_GrupoMainMenuPagina_Repl_InsUpt]    Script Date: 05/16/2016 21:53:00 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_GrupoMainMenuPagina_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_GrupoMainMenuPagina_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_GrupoMainMenuPagina_Repl_InsUpt]    Script Date: 05/16/2016 21:53:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_GrupoMainMenuPagina_Repl_InsUpt] ON [dbo].[Sis_GrupoMainMenuPagina] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_GrupoMainMenuPagina SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMenuItem = Sis_GrupoMainMenuPagina.IDMenuItem
AND
INSERTED.PaginaNome = Sis_GrupoMainMenuPagina.PaginaNome
AND
INSERTED.IDGrupo = Sis_GrupoMainMenuPagina.IDGrupo

       UPDATE Sis_GrupoMainMenuPagina SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMenuItem = Sis_GrupoMainMenuPagina.IDMenuItem
AND
DELETED.PaginaNome = Sis_GrupoMainMenuPagina.PaginaNome
AND
DELETED.IDGrupo = Sis_GrupoMainMenuPagina.IDGrupo

END
GO

/****** Object:  Trigger [tr_Sis_Language_Repl_Del]    Script Date: 05/16/2016 21:54:43 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Language_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_Language_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Language_Repl_Del]    Script Date: 05/16/2016 21:54:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Language_Repl_Del] ON [dbo].[Sis_Language] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_Language', 'DELETE FROM Sis_Language WHERE ' + 'Convert(varchar, IDLanguage)  = ' + QuoteName(Convert(varchar, DELETED.IDLanguage), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_Language_Repl_InsUpt]    Script Date: 05/16/2016 21:55:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Language_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_Language_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Language_Repl_InsUpt]    Script Date: 05/16/2016 21:55:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Language_Repl_InsUpt] ON [dbo].[Sis_Language] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_Language SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDLanguage = Sis_Language.IDLanguage

       UPDATE Sis_Language SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDLanguage = Sis_Language.IDLanguage

END
GO

/****** Object:  Trigger [tr_Sis_MainMenuOperacao_Repl_Del]    Script Date: 05/16/2016 21:56:54 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_MainMenuOperacao_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_MainMenuOperacao_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_MainMenuOperacao_Repl_Del]    Script Date: 05/16/2016 21:56:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_MainMenuOperacao_Repl_Del] ON [dbo].[Sis_MainMenuOperacao] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_MainMenuOperacao', 'DELETE FROM Sis_MainMenuOperacao WHERE ' + 'Convert(varchar, IDMenuItem)  = ' + QuoteName(Convert(varchar, DELETED.IDMenuItem), CHAR(39)) + ' AND ' + 'Convert(varchar, IDOperacao)  = ' + QuoteName(Convert(varchar, DELETED.IDOperacao), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_MainMenuOperacao_Repl_InsUpt]    Script Date: 05/16/2016 21:59:42 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_MainMenuOperacao_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_MainMenuOperacao_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_MainMenuOperacao_Repl_InsUpt]    Script Date: 05/16/2016 21:59:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_MainMenuOperacao_Repl_InsUpt] ON [dbo].[Sis_MainMenuOperacao] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_MainMenuOperacao SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMenuItem = Sis_MainMenuOperacao.IDMenuItem
AND
INSERTED.IDOperacao = Sis_MainMenuOperacao.IDOperacao

       UPDATE Sis_MainMenuOperacao SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMenuItem = Sis_MainMenuOperacao.IDMenuItem
AND
DELETED.IDOperacao = Sis_MainMenuOperacao.IDOperacao

END
GO

/****** Object:  Trigger [tr_Sys_Module_Repl_InsUpt]    Script Date: 05/27/2016 14:16:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sys_Module_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sys_Module_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sys_Module_Repl_InsUpt]    Script Date: 05/27/2016 14:16:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sys_Module_Repl_InsUpt] ON [dbo].[Sys_Module] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sys_Module SET ReplLastChange = GETDATE() FROM INSERTED 
       UPDATE Sys_Module SET ReplLastChange = GETDATE() FROM DELETED  
END
GO


/****** Object:  Trigger [tr_Sis_Municipio_Repl_Del]    Script Date: 05/16/2016 22:02:00 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Municipio_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_Municipio_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Municipio_Repl_Del]    Script Date: 05/16/2016 22:02:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Municipio_Repl_Del] ON [dbo].[Sis_Municipio] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_Municipio', 'DELETE FROM Sis_Municipio WHERE ' + 'Convert(varchar, IDMunicipio)  = ' + QuoteName(Convert(varchar, DELETED.IDMunicipio), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_Municipio_Repl_InsUpt]    Script Date: 05/16/2016 22:02:45 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Municipio_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_Municipio_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Municipio_Repl_InsUpt]    Script Date: 05/16/2016 22:02:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Municipio_Repl_InsUpt] ON [dbo].[Sis_Municipio] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_Municipio SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDMunicipio = Sis_Municipio.IDMunicipio

       UPDATE Sis_Municipio SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDMunicipio = Sis_Municipio.IDMunicipio

END
GO

/****** Object:  Trigger [tr_Sis_PropertyDomain_Repl_Del]    Script Date: 05/16/2016 22:03:39 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_PropertyDomain_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_PropertyDomain_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_PropertyDomain_Repl_Del]    Script Date: 05/16/2016 22:03:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_PropertyDomain_Repl_Del] ON [dbo].[Sis_PropertyDomain] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_PropertyDomain', 'DELETE FROM Sis_PropertyDomain WHERE ' + 'Convert(varchar, Property)  = ' + QuoteName(Convert(varchar, DELETED.Property), CHAR(39)) + ' AND ' + 'Convert(varchar, PropertyValue)  = ' + QuoteName(Convert(varchar, DELETED.PropertyValue), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_PropertyDomain_Repl_InsUpt]    Script Date: 05/16/2016 22:04:30 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_PropertyDomain_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_PropertyDomain_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_PropertyDomain_Repl_InsUpt]    Script Date: 05/16/2016 22:04:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_PropertyDomain_Repl_InsUpt] ON [dbo].[Sis_PropertyDomain] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_PropertyDomain SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Property = Sis_PropertyDomain.Property
AND
INSERTED.PropertyValue = Sis_PropertyDomain.PropertyValue

       UPDATE Sis_PropertyDomain SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Property = Sis_PropertyDomain.Property
AND
DELETED.PropertyValue = Sis_PropertyDomain.PropertyValue

END
GO

/****** Object:  Trigger [tr_Sis_Registro_Repl_Del]    Script Date: 05/16/2016 22:05:34 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Registro_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_Registro_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Registro_Repl_Del]    Script Date: 05/16/2016 22:05:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Registro_Repl_Del] ON [dbo].[Sis_Registro] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_Registro', 'DELETE FROM Sis_Registro WHERE ' + 'Convert(varchar, Nome)  = ' + QuoteName(Convert(varchar, DELETED.Nome), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_Registro_Repl_InsUpt]    Script Date: 05/16/2016 22:06:33 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Registro_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_Registro_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Registro_Repl_InsUpt]    Script Date: 05/16/2016 22:06:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Registro_Repl_InsUpt] ON [dbo].[Sis_Registro] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_Registro SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Nome = Sis_Registro.Nome

       UPDATE Sis_Registro SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Nome = Sis_Registro.Nome

END
GO

/****** Object:  Trigger [tr_Sis_Registry_Repl_Del]    Script Date: 05/16/2016 22:08:06 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Registry_Repl_Del]'))
DROP TRIGGER [dbo].[tr_Sis_Registry_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Registry_Repl_Del]    Script Date: 05/16/2016 22:08:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Registry_Repl_Del] ON [dbo].[Sis_Registry] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'Sis_Registry', 'DELETE FROM Sis_Registry WHERE ' + 'Convert(varchar, ID)  = ' + QuoteName(Convert(varchar, DELETED.ID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_Sis_Registry_Repl_InsUpt]    Script Date: 05/16/2016 22:08:57 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_Sis_Registry_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_Sis_Registry_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_Sis_Registry_Repl_InsUpt]    Script Date: 05/16/2016 22:08:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_Sis_Registry_Repl_InsUpt] ON [dbo].[Sis_Registry] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE Sis_Registry SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.ID = Sis_Registry.ID

       UPDATE Sis_Registry SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.ID = Sis_Registry.ID

END
GO

/****** Object:  Trigger [tr_SpecialPriceByGroup_Repl_Del]    Script Date: 05/16/2016 22:10:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SpecialPriceByGroup_Repl_Del]'))
DROP TRIGGER [dbo].[tr_SpecialPriceByGroup_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_SpecialPriceByGroup_Repl_Del]    Script Date: 05/16/2016 22:10:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SpecialPriceByGroup_Repl_Del] ON [dbo].[SpecialPriceByGroup] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'SpecialPriceByGroup', 'DELETE FROM SpecialPriceByGroup WHERE ' + 'Convert(varchar, SpecialPriceID)  = ' + QuoteName(Convert(varchar, DELETED.SpecialPriceID), CHAR(39)) + ' AND ' + 'Convert(varchar, GroupID)  = ' + QuoteName(Convert(varchar, DELETED.GroupID), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_SpecialPriceByGroup_Repl_InsUpt]    Script Date: 05/16/2016 22:11:39 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SpecialPriceByGroup_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_SpecialPriceByGroup_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_SpecialPriceByGroup_Repl_InsUpt]    Script Date: 05/16/2016 22:11:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SpecialPriceByGroup_Repl_InsUpt] ON [dbo].[SpecialPriceByGroup] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE SpecialPriceByGroup SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SpecialPriceID = SpecialPriceByGroup.SpecialPriceID
AND
INSERTED.GroupID = SpecialPriceByGroup.GroupID

       UPDATE SpecialPriceByGroup SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SpecialPriceID = SpecialPriceByGroup.SpecialPriceID
AND
DELETED.GroupID = SpecialPriceByGroup.GroupID

END
GO

/****** Object:  Trigger [tr_SpecialPriceByGroup_Repl_InsUpt]    Script Date: 05/16/2016 22:11:39 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SpecialPriceByGroup_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_SpecialPriceByGroup_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_SpecialPriceByGroup_Repl_InsUpt]    Script Date: 05/16/2016 22:11:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SpecialPriceByGroup_Repl_InsUpt] ON [dbo].[SpecialPriceByGroup] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE SpecialPriceByGroup SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.SpecialPriceID = SpecialPriceByGroup.SpecialPriceID
AND
INSERTED.GroupID = SpecialPriceByGroup.GroupID

       UPDATE SpecialPriceByGroup SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.SpecialPriceID = SpecialPriceByGroup.SpecialPriceID
AND
DELETED.GroupID = SpecialPriceByGroup.GroupID

END
GO

/****** Object:  Trigger [tr_SYS_Relatorio_Repl_Del]    Script Date: 05/16/2016 22:14:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SYS_Relatorio_Repl_Del]'))
DROP TRIGGER [dbo].[tr_SYS_Relatorio_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_SYS_Relatorio_Repl_Del]    Script Date: 05/16/2016 22:14:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SYS_Relatorio_Repl_Del] ON [dbo].[SYS_Relatorio] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'SYS_Relatorio', 'DELETE FROM SYS_Relatorio WHERE ' + 'Convert(varchar, IDRelatorio)  = ' + QuoteName(Convert(varchar, DELETED.IDRelatorio), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_SYS_Relatorio_Repl_InsUpt]    Script Date: 05/16/2016 22:14:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SYS_Relatorio_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_SYS_Relatorio_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_SYS_Relatorio_Repl_InsUpt]    Script Date: 05/16/2016 22:14:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SYS_Relatorio_Repl_InsUpt] ON [dbo].[SYS_Relatorio] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE SYS_Relatorio SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRelatorio = SYS_Relatorio.IDRelatorio

       UPDATE SYS_Relatorio SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRelatorio = SYS_Relatorio.IDRelatorio

END
GO

/****** Object:  Trigger [tr_SYS_RelParametro_Repl_Del]    Script Date: 05/16/2016 22:17:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SYS_RelParametro_Repl_Del]'))
DROP TRIGGER [dbo].[tr_SYS_RelParametro_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_SYS_RelParametro_Repl_Del]    Script Date: 05/16/2016 22:17:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SYS_RelParametro_Repl_Del] ON [dbo].[SYS_RelParametro] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'SYS_RelParametro', 'DELETE FROM SYS_RelParametro WHERE ' + 'Convert(varchar, IDRelParametro)  = ' + QuoteName(Convert(varchar, DELETED.IDRelParametro), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_SYS_RelParametro_Repl_InsUpt]    Script Date: 05/16/2016 22:18:14 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SYS_RelParametro_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_SYS_RelParametro_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_SYS_RelParametro_Repl_InsUpt]    Script Date: 05/16/2016 22:18:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SYS_RelParametro_Repl_InsUpt] ON [dbo].[SYS_RelParametro] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE SYS_RelParametro SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDRelParametro = SYS_RelParametro.IDRelParametro

       UPDATE SYS_RelParametro SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDRelParametro = SYS_RelParametro.IDRelParametro

END
GO

/****** Object:  Trigger [tr_SysFunction_Repl_Del]    Script Date: 05/16/2016 22:19:21 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SysFunction_Repl_Del]'))
DROP TRIGGER [dbo].[tr_SysFunction_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_SysFunction_Repl_Del]    Script Date: 05/16/2016 22:19:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SysFunction_Repl_Del] ON [dbo].[SysFunction] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'SysFunction', 'DELETE FROM SysFunction WHERE ' + 'Convert(varchar, IDSysFunction)  = ' + QuoteName(Convert(varchar, DELETED.IDSysFunction), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_SysFunction_Repl_InsUpt]    Script Date: 05/16/2016 22:20:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SysFunction_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_SysFunction_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_SysFunction_Repl_InsUpt]    Script Date: 05/16/2016 22:20:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SysFunction_Repl_InsUpt] ON [dbo].[SysFunction] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE SysFunction SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSysFunction = SysFunction.IDSysFunction

       UPDATE SysFunction SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSysFunction = SysFunction.IDSysFunction

END
GO

/****** Object:  Trigger [tr_SysFunctionLanguage_Repl_Del]    Script Date: 05/16/2016 22:20:50 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SysFunctionLanguage_Repl_Del]'))
DROP TRIGGER [dbo].[tr_SysFunctionLanguage_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_SysFunctionLanguage_Repl_Del]    Script Date: 05/16/2016 22:20:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SysFunctionLanguage_Repl_Del] ON [dbo].[SysFunctionLanguage] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'SysFunctionLanguage', 'DELETE FROM SysFunctionLanguage WHERE ' + 'Convert(varchar, IDSysFunction)  = ' + QuoteName(Convert(varchar, DELETED.IDSysFunction), CHAR(39)) + ' AND ' + 'Convert(varchar, IDLanguage)  = ' + QuoteName(Convert(varchar, DELETED.IDLanguage), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_SysFunctionLanguage_Repl_InsUpt]    Script Date: 05/16/2016 22:21:17 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_SysFunctionLanguage_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_SysFunctionLanguage_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_SysFunctionLanguage_Repl_InsUpt]    Script Date: 05/16/2016 22:21:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_SysFunctionLanguage_Repl_InsUpt] ON [dbo].[SysFunctionLanguage] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE SysFunctionLanguage SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDSysFunction = SysFunctionLanguage.IDSysFunction
AND
INSERTED.IDLanguage = SysFunctionLanguage.IDLanguage

       UPDATE SysFunctionLanguage SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDSysFunction = SysFunctionLanguage.IDSysFunction
AND
DELETED.IDLanguage = SysFunctionLanguage.IDLanguage

END
GO

/****** Object:  Trigger [tr_TMC_TimeControl_Repl_Del]    Script Date: 08/19/2016 14:33:32 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_TMC_TimeControl_Repl_Del]'))
DROP TRIGGER [dbo].[tr_TMC_TimeControl_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_TMC_TimeControl_Repl_Del]    Script Date: 08/19/2016 14:33:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_TMC_TimeControl_Repl_Del] ON [dbo].[TMC_TimeControl] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'TMC_TimeControl', 'DELETE FROM TMC_TimeControl WHERE ' + 'Convert(varchar, IDTime)  = ' + QuoteName(Convert(varchar, DELETED.IDTime), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_UpInvent_Repl_Del]    Script Date: 05/16/2016 22:22:12 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_UpInvent_Repl_Del]'))
DROP TRIGGER [dbo].[tr_UpInvent_Repl_Del]
GO


/****** Object:  Trigger [dbo].[tr_UpInvent_Repl_Del]    Script Date: 05/16/2016 22:22:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_UpInvent_Repl_Del] ON [dbo].[UpInvent] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'UpInvent', 'DELETE FROM UpInvent WHERE ' + 'Convert(varchar, Model)  = ' + QuoteName(Convert(varchar, DELETED.Model), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_UpInvent_Repl_InsUpt]    Script Date: 05/16/2016 22:22:53 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_UpInvent_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_UpInvent_Repl_InsUpt]
GO


/****** Object:  Trigger [dbo].[tr_UpInvent_Repl_InsUpt]    Script Date: 05/16/2016 22:22:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_UpInvent_Repl_InsUpt] ON [dbo].[UpInvent] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE UpInvent SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.Model = UpInvent.Model

       UPDATE UpInvent SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.Model = UpInvent.Model

END
GO

/****** Object:  Trigger [tr_VendorTax_Repl_Del]    Script Date: 08/19/2016 14:38:26 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_VendorTax_Repl_Del]'))
DROP TRIGGER [dbo].[tr_VendorTax_Repl_Del]
GO

/****** Object:  Trigger [dbo].[tr_VendorTax_Repl_Del]    Script Date: 08/19/2016 14:38:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_VendorTax_Repl_Del] ON [dbo].[VendorTax] FOR DELETE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       INSERT INTO Rpl_RowDeleted (TableName, Script, ReplLastChange) 
SELECT 'VendorTax', 'DELETE FROM VendorTax WHERE ' + 'Convert(varchar, IDVendorTax)  = ' + QuoteName(Convert(varchar, DELETED.IDVendorTax), CHAR(39)), GetDate() FROM DELETED
END
GO

/****** Object:  Trigger [tr_VendorTax_Repl_InsUpt]    Script Date: 08/19/2016 14:39:29 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tr_VendorTax_Repl_InsUpt]'))
DROP TRIGGER [dbo].[tr_VendorTax_Repl_InsUpt]
GO

/****** Object:  Trigger [dbo].[tr_VendorTax_Repl_InsUpt]    Script Date: 08/19/2016 14:39:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_VendorTax_Repl_InsUpt] ON [dbo].[VendorTax] FOR INSERT,UPDATE NOT FOR REPLICATION AS 
SET NOCOUNT ON 
IF ISNULL(APP_NAME(), '') = 'MRREPLICATION'
   RETURN
IF NOT UPDATE(ReplLastChange)
BEGIN
       UPDATE VendorTax SET ReplLastChange = GETDATE() FROM INSERTED  WHERE INSERTED.IDVendorTax = VendorTax.IDVendorTax

       UPDATE VendorTax SET ReplLastChange = GETDATE() FROM DELETED   WHERE DELETED.IDVendorTax = VendorTax.IDVendorTax

END
GO