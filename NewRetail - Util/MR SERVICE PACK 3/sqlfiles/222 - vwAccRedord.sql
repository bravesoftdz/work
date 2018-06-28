if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Records]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Records]
GO

CREATE VIEW vw_Rep_Acc_Records AS
SELECT 
	L.IDLancamento 			as IDRecord, 
	L.IDQuitacaoMeioPrevisto 	as IDPaymentTypePrediction, 
	L.Previsao 			as Prediction, 
	L.IDPreSale 			as IDPreSale, 
	L.IDPessoaTipo 			as IDPersonType, 
	L.IDBancoAgenciaQuitPrev 	as IDPaymentBankAccountPrediction, 
	L.IDEmpresa 			as IDCompany, 
	L.IDPessoa 			as IDPerson, 
	L.IDBancoQuitPrev 		as IDPaymentBankPrediction, 
	L.IDDesdobramentoTipo 		as IDDisbursementType, 
	L.IDMoedaCotacao 		as IDCurrencyQuoted, 
	L.IDMoeda 			as IDCurrency, 
	L.IDUsuarioLancamento 		as IDUserRecord, 
	L.DataAprovacao 		as ApprovalDate, 
	L.IDCentroCusto 		as IDCostCenter, 
	L.Situacao 			as Situation, 
	L.DataLancamento 		as RecordDate, 
	L.IDLancamentoTipo 		as IDRecordType, 
	L.DataVencimento 		as DueDate, 
	L.DataVencimentoOriginal 	as OriginalDueDate, 
	L.DataInicioQuitacao 		as FirstPaymentDate, 
	L.DataFimQuitacao 		as LastPaymentDate, 
	L.ValorNominal 			as Amount, 
	L.TotalQuitado 			as Paid, 
	L.IDDocumentoTipo 		as IDDocumentType, 
	L.NumDocumento 			as DocumentNumber, 
	L.NumDesdobramento 		as DesbursementNumber, 
	L.NumMeioQuitPrevisto 		as PaymentTypeNumberPrediction, 
	L.IDContaCorrentePrevista 	as IDBankAccountPrediction, 
	L.IDUsuarioAprovacao 		as IDUserApproved, 
	L.IDUsuarioProtesto 		as IDUserCancelled, 
	L.NumeroDuplicata 		as DuplicateNumber, 
	L.MoedaSigla 			as CurrentSymbol, 
	L.IDLancamentoOriginal 		as IDOriginalRecord, 
	L.DataEmissao 			as IssueDate, 
	L.Historico 			as History, 
	L.IDCashRegMov 			as IDCashRegMov, 
	L.Hidden, 
	L.System, 
	L.Desativado 			as Deleted, 
	L.Pagando 			as Paying, 
	L.NumeroRepeticoes 		as Frequency,
	L.IDPurchase,
	L.LancamentoType 		as RecordType,
	L.IDLancamentoParent 		as IDRecordParent,
	L.CheckNumber,
	L.CustomerDocument,
	L.CustomerName,
	L.CustomerPhone,
	L.IDBankCheck,
	L.PaymentPlace,
	L.IDCashRegMovClosed,
	L.IsPreDatado
FROM 
	Fin_Lancamento L

GO