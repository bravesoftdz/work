inherited SubCalcPurchaseTax: TSubCalcPurchaseTax
  Width = 325
  Height = 182
  Caption = 'SubCalcPurchaseTax'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object quTaxCat: TADOQuery [0]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
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
      '      TC.IDTaxCategory,'
      '      TC.TaxCategory,'
      '      TC.Tax,'
      '      TC.Debit,'
      '      TC.Formula'
      'FROM'
      '      TaxCategory TC (NOLOCK)'
      'WHERE'
      '      TC.IDTaxCategoryParent = :IDTaxCategory')
    Left = 166
    Top = 62
    object quTaxCatIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quTaxCatTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quTaxCatTax: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '#,0.00 %'
      Precision = 19
    end
    object quTaxCatDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quTaxCatFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
  object dsTaxCat: TDataSource [1]
    DataSet = quTaxCat
    Left = 170
    Top = 10
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubCalcPurchaseTax.sil'
  end
end
