SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE    PROCEDURE [dbo].[sp_PreSale_SubCalcTax]
   (
   @PreSaleID  int,
   @Date  DateTime
   )
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 SUMARIO

  - Calculo Tax

 TABELA DE ERROS PARA RETURN_VALUE

   000  Ok
  -201  Erro em UPDATE Invoice
  -202  Erro em UPDATE I SET TaxIsemptValue

 LOG DE MODIFICAÇÕES

 Data   Programador  Modificação
 --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 14 agosto 2000    Eduardo Costa  Suporte ao tax categories, agora é taxa é definda na tabela de
       TaxCategory. Cada conjunto de Store e TabGroup define uma
       TaxCategory;
 26 June 2001  Davi Gouveia  Log de Return Values
 18 Aug 2004  Rodrigo Costa  Gravar error log
 26 Oct  2004  Carlos Lima  Calcular Tax, incluindo os Invoices filhos
 07 Dez 2004  Rodrigo Costa  Novo calculo das taxas
 20 Jan 2005  Rodrigo Costa  Calculo das taxas do InventoryMov para somar com o total do invoice
 26 Fev 2007  Rodrigo Costa  Calcular imposto estabelecido no PreInvMov
 02 July 2013    Antonio Marcos      added InvoiceDiscount to fix tax when there is discount to all invoice ( sale                                              discount )
    02 Jul 2013     Daniel Browning and Nicholas Cook - Added ability to calculate tax including invoice discount.
 
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @LocalTax   money
DECLARE @ErrorLevel  int
DECLARE @SysError  int
DECLARE @TaxTotal  money
DECLARE @TaxTotalExp money

SET @ErrorLevel = 0

-- Caso o invoice esteja marcado como TaxIsempt, não calculo nada
IF (SELECT IV.TaxIsent FROM dbo.Invoice IV WHERE IV.IDPreSale = @PreSaleID ) = 1
BEGIN
 UPDATE
  Invoice
 SET
  Invoice.Tax = 0
 WHERE
  Invoice.IDPreSale = @PreSaleID
  OR
  Invoice.IDPreSaleParent = @PreSaleID

 SET @SysError = @@ERROR
 IF @SysError <> 0
 BEGIN
  SET @ErrorLevel = -201
  GOTO ERRO
 END
 ELSE
  GOTO OK
END

-- É necessário a atualização de dois campos: TaxIsemptValue, e Tax
--Calculo do tax exempt
SET @TaxTotalExp = 
 IsNull((SELECT 
  SUM(IsNull(IMX.TaxValue,0))
 FROM 
  Invoice INV (NOLOCK) 
  JOIN
  InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
  JOIN
  InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
 WHERE 
  (
  INV.IDPreSale = @PreSaleID
  OR
  INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
  )
                AND
  IM.InventMovTypeID = 1
  AND
  INV.TaxIsent = 1
 ),0)

--Calculo da taxa
SET @TaxTotal = 
 IsNull((SELECT 
  SUM(IsNull(IMX.TaxValue,0))
 FROM 
  Invoice INV (NOLOCK) 
  JOIN
  InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
  JOIN
  InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
 WHERE 
  (
  INV.IDPreSale = @PreSaleID
  OR
  INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
  )
                AND
  IM.InventMovTypeID = 1
  AND
  INV.TaxIsent = 0
 ),0)

UPDATE
 I
SET
 TaxIsemptValue =
 ROUND(
 (
 SELECT ISNULL(
   SUM (
    (Round(PIM.Qty * ISNULL(PIM.SalePrice, 0),4,1) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
       -
        (
                        ( 
                            ((PIM.Qty * PIM.SalePrice) - PIM.Discount)  / nullif((INV.SubTotal - INV.ItemDiscount), 0)
                        )
                        * INV.InvoiceDiscount
                    )

               
     * (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
    ),0)
 FROM 
  Invoice INV   
  JOIN
  PreInventoryMov PIM   ON (INV.IDPreSale = PIM.DocumentID)
  JOIN
  Model M   ON (M.IDModel = PIM.ModelID)
  JOIN
  StoreToTabGroup STG   ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
  JOIN
  TaxCategory TC   ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
  LEFT OUTER JOIN 
  TaxCategory TCI   ON ( TCI.IDTaxCategory = STG.IDSaleTax )

 WHERE 
  (
  INV.IDPreSale = @PreSaleID
  OR
  INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
  )
                AND
  PIM.InventMovTypeID = 1
  AND
  TC.TaxExempt = 1
 ) + @TaxTotalExp, 2),
          Tax =
 ROUND(
 (
 SELECT ISNULL(
   SUM (
           (
               (
                Round(
                    PIM.Qty * ISNULL(PIM.SalePrice, 0),
                    5,
                    1
                )
                - 
                ISNULL(PIM.Discount, 0)
            )  -- Subtotal da linha do inventario
            
             -
            round(
                (
                                ( 
                                    ((PIM.Qty * PIM.SalePrice) - PIM.Discount)  / nullif((INV.SubTotal - INV.ItemDiscount), 0)
                                    -- ((( 1 * 3.99+1.49) - 0.00) / (5.48 - 0.00)) * 5.48
                                )
                                * INV.InvoiceDiscount
                            ),
                            5, 0
                        )
                    )
                    
     * (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
      THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
    ),
   0
   )
 FROM Invoice INV (NOLOCK) 
  JOIN PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
  JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)
  JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
  JOIN TaxCategory TC (NOLOCK) ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
  LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STG.IDSaleTax )
 WHERE
  (
  INV.IDPreSale = @PreSaleID
  OR
  INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
  )
  AND
  PIM.InventMovTypeID = 1
  AND
  TC.TaxExempt = 0
 ) + @TaxTotal, 4)
FROM
 Invoice I
WHERE
 I.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
 SET @ErrorLevel = -202
 GOTO ERRO
END


OK:
 RETURN 0
ERRO:
 PRINT CAST(@ErrorLevel AS VARCHAR)

 DECLARE @ErrorLevelStr varchar(10)
 SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
 EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcTax', @ErrorLevelStr

 RETURN @ErrorLevel
GO
