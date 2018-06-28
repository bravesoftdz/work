SET QUOTED_IDENTIFIER ON
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

SET ARITHABORT ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

SET CONCAT_NULL_YIELDS_NULL ON
GO

SET ANSI_NULLS ON
GO

SET ANSI_PADDING ON
GO

SET ANSI_WARNINGS ON
GO

CREATE TABLE dbo.Tmp_SystemUser
	(
	IDUser int NOT NULL,
	UserTypeID int NOT NULL,
	ComissionID int NULL,
	SystemUser varchar(50) NOT NULL,
	PW varchar(10) NOT NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	CodSystemUser varchar(20) NULL,
	StoresAccess varchar(255) NULL,
	ContadorClasse int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.SystemUser)
	 EXEC('INSERT INTO dbo.Tmp_SystemUser (IDUser, UserTypeID, ComissionID, SystemUser, PW, System, Desativado, Hidden, CodSystemUser, StoresAccess, ContadorClasse)
		SELECT IDUser, UserTypeID, ComissionID, SystemUser, PW, System, Desativado, Hidden, CodSystemUser, StoresAccess, ContadorClasse FROM dbo.SystemUser TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'SystemUser'
EXEC(@temp)
GO

DROP TABLE dbo.SystemUser
GO

ALTER TABLE dbo.Tmp_SystemUser ADD CONSTRAINT
	DF_Zero15 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_SystemUser ADD CONSTRAINT
	DF_Zero16 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_SystemUser ADD CONSTRAINT
	DF_Zero17 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_SystemUser', N'SystemUser', 'OBJECT'
GO

ALTER TABLE dbo.SystemUser ADD CONSTRAINT
	XPKSystemUser PRIMARY KEY CLUSTERED 
	(
	IDUser
	) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX XAK1SystemUser ON dbo.SystemUser
	(
	CodSystemUser
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_SystemUser_PW ON dbo.SystemUser
	(
	PW
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF150SystemUser ON dbo.SystemUser
	(
	ComissionID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF151SystemUser ON dbo.SystemUser
	(
	UserTypeID
	) ON [PRIMARY]
GO

ALTER TABLE dbo.SystemUser WITH NOCHECK ADD CONSTRAINT
	FK_UserType_SystemUser_UserTypeID FOREIGN KEY
	(
	UserTypeID
	) REFERENCES dbo.UserType
	(
	IDUserType
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_SystemUser_InsUpt on dbo.SystemUser
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Proibo a repeticao de UserNames e Passwords


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT	INSERTED.IDUser
		FROM	INSERTED, SystemUser
		WHERE 	INSERTED.SystemUser = SystemUser.SystemUser  AND
			SystemUser.IDUser <> INSERTED.IDUser	     AND
			INSERTED.Desativado = 0 		     AND
			SystemUser.Desativado = 0
		)
	
	BEGIN
		RAISERROR ('DUP_SystemUser_SystemUser can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

if	EXISTS 	(
		SELECT	INSERTED.IDUser
		FROM	INSERTED, SystemUser
		WHERE 	INSERTED.PW = SystemUser.PW		     AND
			SystemUser.IDUser <> INSERTED.IDUser	     AND
			INSERTED.Desativado = 0 		     AND
			SystemUser.Desativado = 0
		)
	
	BEGIN
		RAISERROR ('DUP_SystemUser_PW can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO

ALTER TABLE dbo.Fin_Transferencia WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Transferencia_IDUsuario FOREIGN KEY
	(
	IDUsuario
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Transferencia
	NOCHECK CONSTRAINT FK_SystemUser_Transferencia_IDUsuario
GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Purchase_IDUserFinalReceiving FOREIGN KEY
	(
	IDUserFinalReceiving
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Purchase_IDUserPreReceiving FOREIGN KEY
	(
	IDUserPreReceiving
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CashRegLog WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_CashRegLog_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_TouristGroup_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Quitacao_IDUsuarioReconciliacao FOREIGN KEY
	(
	IDUsuarioReconciliacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Quitacao_IDUsuarioQuitacao FOREIGN KEY
	(
	IDUsuarioQuitacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_PreInvnetoryMov_UserID FOREIGN KEY
	(
	UserID
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Sis_UsuarioGrupo WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Sis_UsuarioGrupo_IDUsuario FOREIGN KEY
	(
	IDUsuario
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Fin_LancQuit WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_LancQuit_IDUsuarioQuitacao FOREIGN KEY
	(
	IDUsuarioQuitacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Lancamento_IDUsuarioAprovacao FOREIGN KEY
	(
	IDUsuarioAprovacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Lancamento_IDUsuarioLancamento FOREIGN KEY
	(
	IDUsuarioLancamento
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Lancamento_IDUsuarioProtesto FOREIGN KEY
	(
	IDUsuarioProtesto
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.SystemUser WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_SystemUser_ComissionID FOREIGN KEY
	(
	ComissionID
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Pessoa_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Sis_AppHistory WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Sis_AppHistory_IDUsuario FOREIGN KEY
	(
	IDUsuario
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Request_UserID FOREIGN KEY
	(
	UserID
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_InventoryMov_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.ModelTransf WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_ModelTransf_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.GroupCostGift WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_GroupCostGift_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TMC_TimeControl WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_TMCTimeControl_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CashRegMov WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_CashRegMov_IDOpenUser FOREIGN KEY
	(
	IDOpenUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserBack FOREIGN KEY
	(
	IDUserBack
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserReceive FOREIGN KEY
	(
	IDUserReceive
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserReturn FOREIGN KEY
	(
	IDUserReturn
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserSent FOREIGN KEY
	(
	IDUserSent
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

