if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

CREATE PROCEDURE sp_PreSale_AddParcela
                        (
                        @IDStore                int,
                        @IDUser                 int,
                        @IDCliente              int,
                        @PreSaleID              int,
                        @PreSaleDate            smalldatetime,
                        @ExpirationDate         smalldatetime,
                        @IDMeioPag              int,
                        @Value                                   money,
                        @Authorization             varchar(50),
                        @IDCashRegMov                     int,
                        @Parcela                     varchar(20),
                        @IDBankCheck                        int,
                        @CheckNumber                       varchar(20),
                        @CustomerDocument   varchar(20),
                        @CustomerName                     varchar(80),
                        @CustomerPhone                    varchar(20),
                        @OBS                         varchar(255),
                        @PaymentPlace                      int
                        )
AS
 

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO
                        - Pega as constantes
                        - Insere o lancamento

            TABELA DE ERROS PARA RETURN_VALUE
                         000  Ok
                        -201  Erro em Pega as constantes
                        -202  Erro em Insere o lancamento
                        -203  Erro em Update CashReg TotalSales
 

            LOG DE MODIFICAÇÕES

            Data                             Programador                 Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            26 May  2000                Eduardo Costa             suporte ao novo financeiro
            27 June 2001                Davi Gouveia              Log de Return Values
            28 July 2001                 Rodrigo Costa            Atualizar o CashReg TotalSales
            21 Oct  2003                 Rodrigo Costa            Chamada a sp_Sis_GetNextCode para @IDLancamento; 
                                                                                     Criado @IDLancamento;
            15 Oct 2004                  Carlos Lima              Incluídos novos campos no Fin_Lancamento
            27 Sep 2004                 Carlos Lima               Incluídos novo campo no no Fin_Lancamento (PaymentPlace)
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDCentroCusto      int
DECLARE @IDContaCorrente    int
DECLARE @IDEmpresa          int
DECLARE @ErrorLevel         int
DECLARE @IDLancamento       int

SET @ErrorLevel = 0

-- Pega as constantes
SELECT
                        @IDCentroCusto = S.IDCentroCusto,
                        @IDContaCorrente = MPS.IDContaCorrente,
                        @IDEmpresa = S.IDEmpresa
FROM
                        Store S
                        JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)
WHERE
                        S.IDStore = @IDStore
                        AND
                        MPS.IDMeioPag = @IDMeioPag
IF @@ERROR <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END
 

-- Insere o lancamento
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT            Fin_Lancamento
                        (
                        IDLancamento,
                        IDLancamentoTipo,
                        Pagando,
                        Situacao,
                        IDCentroCusto,
                        IDContaCorrentePrevista,
                        IDDocumentoTipo,
                        NumDocumento,
                        IDEmpresa,
                        IDPreSale,
                        IDPessoaTipo,
                        IDPessoa,
                        IDMoeda,
                        IDMoedaCotacao,
                        DataLancamento,
                        DataVencimento,
                        ValorNominal,
                        IDQuitacaoMeioPrevisto,
                        IDUsuarioLancamento,
                        NumMeioQuitPrevisto,
                        IDCashRegMov,
                        NumDesdobramento,
                        IDDesdobramentoTipo,
                        IDBankCheck,
                        CheckNumber,
                        CustomerDocument,
                        CustomerName,
                        CustomerPhone,
                        Historico,
                        PaymentPlace
                        )
                        VALUES
                        (
                        @IDLancamento,
                        2, -- \\Receitas\Vendas
                        0,
                        1,
                        @IDCentroCusto,
                        @IDContaCorrente,
                        1001, -- Sales Invoice
                        Convert(varchar(50), @PreSaleID),
                        @IDEmpresa,
                        @PreSaleID,
                        1, -- Sales Customer
                        @IDCliente,
                        4, -- Dollares
                        6, -- CotacaoPadrao do Dollar
                        @PreSaleDate,
                        @ExpirationDate,
                        @Value,
                        @IDMeioPag,
                        @IDUser, --Usuario do financeiro
                        @Authorization,
                        @IDCashRegMov,
                        @Parcela,
                        1001,
                        @IDBankCheck,
                        @CheckNumber,
                        @CustomerDocument,
                        @CustomerName,
                        @CustomerPhone,
                        @OBS,
                        @PaymentPlace
                        )
IF @@ERROR <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*                     Update Cash RegisterMovent                             */
/*--------------------------------------------------------------------------------------------------------*/

UPDATE
            CashRegMov
SET
            CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) + ROUND(IsNull(@Value,0),2)
WHERE
            CashRegMov.IDCashRegMov = @IDCashRegMov 

IF @@ERROR <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END
 
OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)
            RETURN @ErrorLevel
GO
