object DMCalcTax: TDMCalcTax
  OldCreateOrder = False
  Left = 205
  Top = 147
  Height = 169
  Width = 453
  object CalcTaxFormula: TCalcExpress
    Formula = '0'
    Left = 371
    Top = 17
  end
  object quItemTax: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIT.IDPurchaseItemTax,'
      #9'PIT.TaxValue,'
      #9'PIT.TaxPercentage,'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.Formula'
      'FROM'
      #9'Pur_PurchaseItemTax PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchaseItem = :IDPurchaseItem'
      'ORDER BY'
      #9'LEN(TG.Formula)')
    Left = 43
    Top = 17
    object quItemTaxIDPurchaseItemTax: TIntegerField
      FieldName = 'IDPurchaseItemTax'
    end
    object quItemTaxTaxValue: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'TaxValue'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quItemTaxTaxPercentage: TBCDField
      DisplayLabel = '%'
      FieldName = 'TaxPercentage'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quItemTaxTaxCategory: TStringField
      DisplayLabel = 'Tax'
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quItemTaxDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quItemTaxFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
  object spPurchaseItemTax: TADOStoredProc
    ProcedureName = 'sp_Purchase_AddPurchaseItemTax;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDVendor'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchaseItem'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchase'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 151
    Top = 14
  end
  object quGetTaxValue: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTaxCategory'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIT.IDPurchaseItemTax,'
      #9'PIT.TaxValue'
      'FROM'
      #9'Pur_PurchaseItemTax PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchaseItem = :IDPurchaseItem'
      #9'AND'
      #9'TG.IDTaxCategory = :IDTaxCategory ')
    Left = 271
    Top = 15
    object quGetTaxValueIDPurchaseItemTax: TIntegerField
      FieldName = 'IDPurchaseItemTax'
    end
    object quGetTaxValueTaxValue: TBCDField
      FieldName = 'TaxValue'
      Precision = 19
    end
  end
  object quGetTaxValueRet: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTaxCategory'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIT.IDPurchaseItemTaxRet,'
      #9'PIT.TaxValue'
      'FROM'
      #9'Pur_PurchaseItemTaxRet PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchaseItem = :IDPurchaseItem'
      #9'AND'
      #9'TG.IDTaxCategory = :IDTaxCategory ')
    Left = 273
    Top = 69
    object quGetTaxValueRetIDPurchaseItemTaxRet: TIntegerField
      FieldName = 'IDPurchaseItemTaxRet'
    end
    object quGetTaxValueRetTaxValue: TBCDField
      FieldName = 'TaxValue'
      Precision = 19
    end
  end
  object spPurchaseItemTaxRet: TADOStoredProc
    ProcedureName = 'sp_Purchase_AddPurchaseItemTaxRet;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchaseItem'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 151
    Top = 70
  end
  object quItemTaxRet: TADOQuery
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIT.IDPurchaseItemTaxRet,'
      #9'PIT.TaxValue,'
      #9'PIT.TaxPercentage,'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.Formula'
      'FROM'
      #9'Pur_PurchaseItemTaxRet PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchaseItem = :IDPurchaseItem'
      'ORDER BY'
      #9'LEN(TG.Formula)')
    Left = 42
    Top = 70
    object quItemTaxRetIDPurchaseItemTaxRet: TIntegerField
      FieldName = 'IDPurchaseItemTaxRet'
    end
    object quItemTaxRetTaxValue: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'TaxValue'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quItemTaxRetTaxPercentage: TBCDField
      DisplayLabel = '%'
      FieldName = 'TaxPercentage'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quItemTaxRetTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quItemTaxRetDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quItemTaxRetFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
end
