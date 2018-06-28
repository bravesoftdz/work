if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankAccountTransaction]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankAccountTransaction]
GO

CREATE VIEW vw_Rep_Acc_BankAccountTransaction (Amount, TransDate, DocumentNumber, Payee, IDPayment, IDTransfer, IDPaymentType,
IDBranch, IDBank, IDBankAccount, IDUser, PaymentDate, ReconciliationDate, Reconciliated, IDMeioPag, PaymentType, DocumentIdentifier, BankAccountType, BankAccountNumber, BankAccountCode, BankCode, Bank, BankBalance, AccBalance)  AS
SELECT 
	(P.Amount + P.Interest) * (1-2*P.Paying) as Amount,
	P.PaymentDate as TransDate,
	P.DocumentNumber,
	P.Payee,
        P.IDPayment,
        P.IDTransfer,
        P.IDPaymentType,
        P.IDBranch,
        P.IDBank,
        P.IDBankAccount,
        P.IDUser,
        P.PaymentDate,
        P.ReconciliationDate,
	CASE P.IsReconciliated 
		WHEN 0 THEN 'C'
		WHEN 1 THEN 'R'
	END as Reconciliated,
        PT.IDMeioPag as IDPaymentType,
	PT.MeioPag,
	PT.DocumentIdentifier,
	BA.Type as BankAccountType,
	BA.Number as BankAccountNumber,
        BA.BankAccountCode,
        B.BankCode,
	B.Bank,
	BankBal.BankBalance,
	AccBalance.AccBalance
FROM
	vw_Rep_Acc_Payment P
	JOIN vw_Rep_PaymentType PT ON (PT.IDMeioPag = P.IDPaymentType)
	JOIN vw_Rep_Acc_BankAccount BA ON (BA.IDBankAccount = P.IDBankAccount AND BA.Deleted = 0)
	JOIN vw_Rep_Acc_Bank B ON (B.IDBank = BA.IDBank)
	--Account Balance
	JOIN (
	SELECT
		SUM((P.Amount + P.Interest) * (1-2*P.Paying)) as AccBalance,
		BA.IDBankAccount
	FROM
		vw_Rep_Acc_Payment P 
		JOIN vw_Rep_Acc_BankAccount BA ON (BA.IDBankAccount = P.IDBankAccount AND BA.Deleted = 0)
	WHERE
		P.Deleted = 0
	GROUP BY
		BA.IDBankAccount
	) AccBalance ON (AccBalance.IDBankAccount = BA.IDBankAccount)
	--Bank Balane
	JOIN (
	SELECT
		SUM((P.Amount + P.Interest) * (1-2*P.Paying)) as BankBalance,
		BA.IDBank
	FROM
		vw_Rep_Acc_Payment P 
		JOIN vw_Rep_Acc_BankAccount BA ON (BA.IDBankAccount = P.IDBankAccount AND BA.Deleted = 0)
	WHERE
		P.Deleted = 0
	GROUP BY
		BA.IDBank
	) BankBal ON (BankBal.IDBank = B.IDBank)

WHERE
	P.Deleted = 0


GO

DELETE FROM Rep_FIELD WHERE TABLENAME = 'vw_Rep_Acc_BankAccountTransaction'
GO

DELETE FROM Rep_TABLE WHERE TABLENAME = 'vw_Rep_Acc_BankAccountTransaction'
GO

INSERT INTO Rep_table VALUES ('vw_Rep_Acc_BankAccountTransaction', 'Acc_BankAccountTransaction')
GO

INSERT INTO Rep_FIELD (
        tablename,
        fieldname,
        fieldalias,
        datatype,
        selectable,
        searchable,
        sortable,
        autosearch,
        mandatory)
SELECT
        TABLE_NAME,
        COLUMN_NAME AS field_name,
        COLUMN_NAME AS field_alias,
        CASE data_type
                WHEN 'INT' THEN 'dtInteger'
                WHEN 'DateTime' THEN 'dtDateTime'
                WHEN 'TBit' THEN 'dtBoolean'
                WHEN 'TControlField' THEN 'dtBoolean'
                WHEN 'Bit' THEN 'dtBoolean'
                WHEN 'Money' THEN 'dtCurrency'
                WHEN 'TValor' THEN 'dtCurrency'
                WHEN 'TValorNull' THEN 'dtCurrency'
                ELSE  'dtString' END AS data_type,
        'T' AS selectable,
        'T' AS searchable,
        'T' AS sortable,
        'T' AS autosearch,
        'T' AS mandatory
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_Rep_Acc_BankAccountTransaction'
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'IDBank'
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'Bank' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'IDBankAccount' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'BankAccountNumber' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoaTipo', ListField = 'TipoPessoa'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'BankAccountNumber' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpMeioPag', ListField = 'MeioPag'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'IDPaymentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpMeioPag', ListField = 'MeioPag'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'PaymentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpUser', ListField = 'SystemUser'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction' AND FieldName = 'IDUser' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_Bank' AND FieldName = 'Bank' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_Bank' AND FieldName = 'Idbank' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_BankAccount' AND FieldName = 'Idbank' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_BankAccount' AND FieldName = 'IDBankAccount' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_BankAccount' AND FieldName = 'Number' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCompany', ListField = 'Empresa'
Where TableName = 'vw_Rep_Acc_BankAccount' AND FieldName = 'IDCompany' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCostCenter', ListField = 'CentroCusto'
Where TableName = 'vw_Rep_Acc_BankAccount' AND FieldName = 'IDCostCenter' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_BankAccountBalance' AND FieldName = 'IDBankAccount' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_BankBranch' AND FieldName = 'IDBank' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCompany', ListField = 'Empresa'
Where TableName = 'vw_Rep_Acc_Company' AND FieldName = 'Idconpany' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCompany', ListField = 'Empresa'
Where TableName = 'vw_Rep_Acc_Company' AND FieldName = 'Company' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCostCenter', ListField = 'CentroCusto'
Where TableName = 'vw_Rep_Acc_CostCenter' AND FieldName = 'IDCostCenter' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCostCenter', ListField = 'CentroCusto'
Where TableName = 'vw_Rep_Acc_CostCenter' AND FieldName = 'CostCenter' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpDesdobramentoTipo', ListField = 'DesdobramentoTipo'
Where TableName = 'vw_Rep_Acc_DisbursementType' AND FieldName = 'IDDisbursementsType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpDesdobramentoTipo', ListField = 'DesdobramentoTipo'
Where TableName = 'vw_Rep_Acc_DisbursementType' AND FieldName = 'DisbursementType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpDocumentoTipo', ListField = 'DocumentoTipo'
Where TableName = 'vw_Rep_Acc_DocumentType' AND FieldName = 'IDDocumentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpDocumentoTipo', ListField = 'DocumentoTipo'
Where TableName = 'vw_Rep_Acc_DocumentType' AND FieldName = 'DocumentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBank', ListField = 'Banco'
Where TableName = 'vw_Rep_Acc_Payment' AND FieldName = 'IDBank' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_Payment' AND FieldName = 'IDBankAccount' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpMeioPag', ListField = 'MeioPag'
Where TableName = 'vw_Rep_Acc_Payment' AND FieldName = 'IDPaymentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpUser', ListField = 'SystemUser'
Where TableName = 'vw_Rep_Acc_Payment' AND FieldName = 'IDUser' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCashReg', ListField = 'Name'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDCashRegMov' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCompany', ListField = 'Empresa'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDCompany' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpCostCenter', ListField = 'CentroCusto'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDCostCenter' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpDocumentoTipo', ListField = 'DocumentoTipo'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDDocumentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpDocumentoTipo', ListField = 'DocumentoTipo'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDDocumentType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoa', ListField = 'Pessoa'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDPerson' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoaTipo', ListField = 'TipoPessoa'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDPersonType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpRecordType', ListField = 'LancamentoTipo'
Where TableName = 'vw_Rep_Acc_Records' AND FieldName = 'IDRecordType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_RecordType' AND FieldName = 'IDBankAccount' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoa', ListField = 'Pessoa'
Where TableName = 'vw_Rep_Acc_RecordType' AND FieldName = 'IDPerson' 
GO


Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoaTipo', ListField = 'TipoPessoa'
Where TableName = 'vw_Rep_Acc_RecordType' AND FieldName = 'IDPersonType' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpRecordType', ListField = 'LancamentoTipo'
Where TableName = 'vw_Rep_Acc_RecordType' AND FieldName = 'Idrecordtype' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpRecordType', ListField = 'LancamentoTipo'
Where TableName = 'vw_Rep_Acc_RecordType' AND FieldName = 'Recordtype' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_Transfer' AND FieldName = 'IDBankAccountCredit' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpBankAccount', ListField = 'Numero'
Where TableName = 'vw_Rep_Acc_Transfer' AND FieldName = 'Idbankaccountdebit' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpUser', ListField = 'SystemUser'
Where TableName = 'vw_Rep_Acc_Transfer' AND FieldName = 'IDUser' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpUser', ListField = 'SystemUser'
Where TableName = 'vw_Rep_Acc_User' AND FieldName = 'IDUser' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpUser', ListField = 'SystemUser' 
Where TableName = 'vw_Rep_Acc_User' AND FieldName = 'Users' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoa', ListField = 'Pessoa' 
Where FieldName = 'IDPerson' 
GO

Update Rep_Field Set DataModule = 'DM', DataSet = 'quLookUpPessoaTipo', ListField = 'TipoPessoa' 
Where FieldName = 'IDPersonType' 
GO

Update Rep_Field Set DataType = 'dtDateTime'
Where TableName = 'vw_Rep_Acc_BankAccountTransaction'
AND FieldName = 'PaymentDate' OR FieldName = 'TransDate'
GO

