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

CREATE TABLE dbo.Tmp_Pessoa
	(
	IDPessoa int NOT NULL,
	IDTipoPessoa int NOT NULL,
	IDStore int NULL,
	IDEstado char(3) NULL,
	IDRamoAtividade int NULL,
	IDPais int NULL,
	IDPessoaBoss int NULL,
	IDTipoPessoaFilho int NULL,
	IDTipoPessoaRoot int NULL,
	IDUser int NULL,
	ShortName varchar(15) NULL,
	Pessoa varchar(50) NULL,
	PessoaFirstName varchar(30) NULL,
	PessoaLastName varchar(30) NULL,
	NomeJuridico varchar(50) NULL,
	Endereco TAddress NULL,
	Cidade TCity NULL,
	CEP char(12) NULL,
	Pais varchar(21) NULL,
	Telefone TTelephone NULL,
	Cellular char(18) NULL,
	Fax TTelephone NULL,
	Beeper char(25) NULL,
	Contato varchar(50) NULL,
	Email varchar(50) NULL,
	OBS varchar(100) NULL,
	Juridico bit NULL,
	TotalMovimentado money NOT NULL,
	Limite money NOT NULL,
	Nascimento smalldatetime NULL,
	DiaQuitacao int NULL,
	CPF varchar(30) NULL,
	CGC varchar(30) NULL,
	Identidade varchar(30) NULL,
	CartTrabalho varchar(30) NULL,
	InscEstadual varchar(30) NULL,
	InscMunicipal varchar(30) NULL,
	Contatos varchar(255) NULL,
	NumAtrasos int NULL,
	DiasAtraso int NULL,
	NumTransacoes int NULL,
	HomePage varchar(200) NULL,
	OrgaoEmissor varchar(50) NULL,
	Bairro varchar(50) NULL,
	NumMovimentacoes int NULL,
	ComissaoSobreGuia money NULL,
	DescontaCoordenacao bit NULL,
	AjusteComiss money NULL,
	Short_Name varchar(30) NULL,
	Code int NULL,
	CustomerCard varchar(20) NULL,
	HorasSemana int NULL,
	ValorHora TValor NULL,
	ValorHoraExtra TValor NULL,
	ValorHoraExtraExtra TValor NULL,
	DefaultPaymentDelay int NULL,
	System bit NULL,
	Desativado int NOT NULL,
	Hidden int NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pessoa)
	 EXEC('INSERT INTO dbo.Tmp_Pessoa (IDPessoa, IDTipoPessoa, IDStore, IDEstado, IDRamoAtividade, IDPais, IDPessoaBoss, IDTipoPessoaFilho, IDTipoPessoaRoot, IDUser, ShortName, Pessoa, PessoaFirstName, PessoaLastName, NomeJuridico, Endereco, Cidade, CEP, Pais, Telefone, Cellular, Fax, Beeper, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, DiaQuitacao, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, DiasAtraso, NumTransacoes, HomePage, OrgaoEmissor, Bairro, NumMovimentacoes, ComissaoSobreGuia, DescontaCoordenacao, AjusteComiss, Short_Name, Code, CustomerCard, HorasSemana, ValorHora, ValorHoraExtra, ValorHoraExtraExtra, DefaultPaymentDelay, System, Desativado, Hidden)
		SELECT IDPessoa, IDTipoPessoa, IDStore, IDEstado, IDRamoAtividade, IDPais, IDPessoaBoss, IDTipoPessoaFilho, IDTipoPessoaRoot, IDUser, ShortName, Pessoa, PessoaFirstName, PessoaLastName, NomeJuridico, Endereco, Cidade, CEP, Pais, Telefone, Cellular, Fax, Beeper, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, DiaQuitacao, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, DiasAtraso, NumTransacoes, HomePage, OrgaoEmissor, Bairro, NumMovimentacoes, ComissaoSobreGuia, DescontaCoordenacao, AjusteComiss, Short_Name, Code, CustomerCard, HorasSemana, ValorHora, ValorHoraExtra, ValorHoraExtraExtra, DefaultPaymentDelay, System, Desativado, Hidden FROM dbo.Pessoa TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Pessoa'
EXEC(@temp)
GO

DROP TABLE dbo.Pessoa
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero33 DEFAULT (0) FOR Juridico
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero34 DEFAULT (0) FOR TotalMovimentado
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero35 DEFAULT (0) FOR Limite
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero36 DEFAULT (0) FOR DiaQuitacao
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero37 DEFAULT (0) FOR NumAtrasos
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero38 DEFAULT (0) FOR DiasAtraso
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero39 DEFAULT (0) FOR NumTransacoes
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero40 DEFAULT (0) FOR ComissaoSobreGuia
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero41 DEFAULT (0) FOR DescontaCoordenacao
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero42 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero43 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Pessoa ADD CONSTRAINT
	DF_Zero44 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_Pessoa', N'Pessoa', 'OBJECT'
GO

CREATE CLUSTERED INDEX XIE_Pessoa_Combo ON dbo.Pessoa
	(
	Pessoa,
	PessoaLastName
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE_Pessoa_Pessoa ON dbo.Pessoa
	(
	Pessoa
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pessoa ADD CONSTRAINT
	PK__Pessoa__571DF1D5 PRIMARY KEY NONCLUSTERED 
	(
	IDPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF168Pessoa ON dbo.Pessoa
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF169Pessoa ON dbo.Pessoa
	(
	IDTipoPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF170Pessoa ON dbo.Pessoa
	(
	IDRamoAtividade
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF171Pessoa ON dbo.Pessoa
	(
	IDPais
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF172Pessoa ON dbo.Pessoa
	(
	IDEstado
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF419Pessoa ON dbo.Pessoa
	(
	IDPessoaBoss
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF420Pessoa ON dbo.Pessoa
	(
	IDTipoPessoaFilho
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF421Pessoa ON dbo.Pessoa
	(
	IDTipoPessoaRoot
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF422Pessoa ON dbo.Pessoa
	(
	IDUser
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Pessoa_IDTipoPessoaRoot FOREIGN KEY
	(
	IDTipoPessoaRoot
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Pessoa_IDTipoPessoaFilho FOREIGN KEY
	(
	IDTipoPessoaFilho
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Pessoa_IDPessoaBoss FOREIGN KEY
	(
	IDPessoaBoss
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_Estado_Pessoa_IDEstado FOREIGN KEY
	(
	IDEstado
	) REFERENCES dbo.Estado
	(
	IDEstado
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_Pais_Pessoa_IDPais FOREIGN KEY
	(
	IDPais
	) REFERENCES dbo.Pais
	(
	IDPais
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_RamoAtividade_Pessoa_IDRamoAtividade FOREIGN KEY
	(
	IDRamoAtividade
	) REFERENCES dbo.RamoAtividade
	(
	IDRamoAtividade
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Pessoa_IDTipoPessoa FOREIGN KEY
	(
	IDTipoPessoa
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_Store_Pessoa_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_Pessoa_All on dbo.Pessoa
FOR DELETE,INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Esta trigger deve incluir um novo codigo para a pesso seguinto o ultimo incluido
	para o tipo de pessoa


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

UPDATE
	Pessoa
SET
	Code = IsNull(TP.LastCode, 0) + 1,
	IDTipoPessoaRoot = Tp.IDTipoPessoa
FROM
	((TipoPessoa TP1
	JOIN
	Inserted I ON ( TP1.IDTipoPessoa = I.IDTipoPessoa AND I.IDTipoPessoa <> 0 ))
	JOIN
	TipoPessoa TP ON ( CASE SUBSTRING(TP1.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP1.Path, 1, 8)
		ELSE SUBSTRING(TP1.Path, 1, 4)
		END = TP.Path ))
WHERE
	Pessoa.IDPessoa = I.IDPessoa
	AND
	Pessoa.Code is Null

UPDATE
	TipoPessoa
SET
	LastCode = IsNull(LastCode, 0) + 1
FROM	(
	SELECT	CASE SUBSTRING(TP.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP.Path, 1, 8)
		ELSE SUBSTRING(TP.Path, 1, 4)
		END Path
	FROM
		Inserted I JOIN TipoPessoa TP ON ( I.IDTipoPessoa = TP.IDTipoPessoa)
	WHERE
		I.Code Is Null
		AND
		I.IDTipoPessoa <> 0
	) A
WHERE
	A.Path = TipoPessoa.Path

GO

ALTER TABLE dbo.CotacaoResult WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_CotacaoResult_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.PessoaTerm WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PessoaTerm_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.PO WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PO_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.InvoiceCommission WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_InvoiceCommission_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.CotacaoToFornec WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_CotacaoToFornec_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_InventoryMov_ComissionID FOREIGN KEY
	(
	ComissionID
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_IventoryMov_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PreInventoryMov_ComissionID FOREIGN KEY
	(
	ComissionID
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PreInventoryMov_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Purchase_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Fin_LancamentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_LancamentoTipo_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.MeioPag WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_MeioPag_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Lancamento_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TMC_TimeControl WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_TMCTimeControl_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_TouristGroup_IDAgency FOREIGN KEY
	(
	IDAgency
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_TouristGroup_IDGuide FOREIGN KEY
	(
	IDGuide
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PurchaseItem_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Invoice_IDCustomer FOREIGN KEY
	(
	IDCustomer
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Model_IDFabricante FOREIGN KEY
	(
	IDFabricante
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Repair_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Repair_IDCliente FOREIGN KEY
	(
	IDCliente
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

