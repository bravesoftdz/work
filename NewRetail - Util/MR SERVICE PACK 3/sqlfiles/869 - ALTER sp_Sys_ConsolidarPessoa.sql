if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sys_ConsolidarPessoa]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sys_ConsolidarPessoa]
GO

CREATE PROCEDURE sp_Sys_ConsolidarPessoa
        (
        @IDPessoaEleita    int ,
        @IDPessoaDelete    int
        )
AS
SET NOCOUNT ON

UPDATE CotacaoResult
SET
    IDFornecedor = @IDPessoaEleita
WHERE
    IDFornecedor = @IDPessoaDelete


UPDATE CotacaoToFornec
SET
    IDFornecedor = @IDPessoaEleita
WHERE
    IDFornecedor = @IDPessoaDelete


UPDATE CustomerCredit
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE Estimated
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE Fin_Lancamento
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE Fin_LancamentoTipo
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete

UPDATE InventoryMov
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE Invoice
SET
    IDCustomer = @IDPessoaEleita
WHERE
    IDCustomer = @IDPessoaDelete


UPDATE InvoiceCommission
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE MeioPag
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE PessoaTerm
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE Pet_PessoaToPet
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete

UPDATE PO
SET
    IDFornecedor = @IDPessoaEleita
WHERE
    IDFornecedor = @IDPessoaDelete


UPDATE PreInventoryMov
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


UPDATE Pur_Purchase
SET
    IDFornecedor = @IDPessoaEleita
WHERE
    IDFornecedor = @IDPessoaDelete


UPDATE Pur_PurchaseItem
SET
    IDFornecedor = @IDPessoaEleita
WHERE
    IDFornecedor = @IDPessoaDelete


UPDATE Repair
SET
    IDCliente = @IDPessoaEleita
WHERE
    IDCliente = @IDPessoaDelete


UPDATE Repair
SET
    IDFornecedor = @IDPessoaEleita
WHERE
    IDFornecedor = @IDPessoaDelete

UPDATE TMC_TimeControl
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete

UPDATE TouristGroup
SET
    IDAgency = @IDPessoaEleita
WHERE
    IDAgency = @IDPessoaDelete

UPDATE TouristGroup
SET
    IDGuide = @IDPessoaEleita
WHERE
    IDGuide = @IDPessoaDelete


UPDATE VendorTax
SET
    IDPessoa = @IDPessoaEleita
WHERE
    IDPessoa = @IDPessoaDelete


DELETE FROM Pessoa 
WHERE
    IDPessoa = @IDPessoaDelete



SET NOCOUNT OFF
GO
