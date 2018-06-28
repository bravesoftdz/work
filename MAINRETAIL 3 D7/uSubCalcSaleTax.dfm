inherited SubCalcSaleTax: TSubCalcSaleTax
  Left = 290
  Top = 216
  Width = 221
  Height = 101
  Caption = 'SubCalcSaleTax'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object TreeImpostos: TTreeView [0]
    Left = 0
    Top = 0
    Width = 213
    Height = 74
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = 14607076
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Courier New'
    Font.Style = []
    Indent = 19
    ParentFont = False
    TabOrder = 0
  end
  inherited siLang: TsiLangRT
    Left = 9
    Top = 6
  end
  object quGetSaleCharge: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      TC.TaxCategory,'
      '      TC.Tax,'
      '      TCP.TaxCategory as ParentTaxCategory,'
      '      TCP.Tax as ParentTax,'
      '      TC.Debit'
      'FROM'
      '      StoreToTabGroup STTG (NOLOCK)'
      
        '      LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON (STTG.IDTaxCate' +
        'gory = TC.IDTaxCategoryParent)'
      
        '      LEFT OUTER JOIN TaxCategory TCP (NOLOCK) ON (TCP.IDTaxCate' +
        'gory = TC.IDTaxCategoryParent)'
      'WHERE'
      '      STTG.IDGroup = :IDGroup'
      '      AND'
      '      STTG.IDStore = :IDStore')
    Left = 21
    Top = 22
    object quGetSaleChargeTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object quGetSaleChargeTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quGetSaleChargeDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quGetSaleChargeParentTaxCategory: TStringField
      FieldName = 'ParentTaxCategory'
      Size = 50
    end
    object quGetSaleChargeParentTax: TBCDField
      FieldName = 'ParentTax'
      Precision = 19
    end
  end
  object quSaleTax: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      TC.TaxCategory,'
      '      TC.Tax,'
      '      TC.Debit'
      'FROM'
      '      StoreToTabGroup STTG (NOLOCK)'
      
        '      LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON (STTG.IDSaleTax' +
        ' = TC.IDTaxCategory)'
      'WHERE'
      '      STTG.IDGroup = :IDGroup'
      '      AND'
      '      STTG.IDStore = :IDStore')
    Left = 81
    Top = 12
    object quSaleTaxTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object quSaleTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quSaleTaxDebit: TBooleanField
      FieldName = 'Debit'
    end
  end
end
