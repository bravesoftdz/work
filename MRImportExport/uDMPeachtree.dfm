object DMPeachtree: TDMPeachtree
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 268
  Top = 106
  Height = 475
  Width = 606
  object cdsUser: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 24
    object cdsUserUserName: TStringField
      FieldName = 'UserName'
    end
    object cdsUserPassword: TStringField
      FieldName = 'Password'
      Size = 16
    end
  end
  object cdsChatAccount: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 24
    object cdsChatAccountDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object cdsChatAccountAccountID: TStringField
      FieldName = 'AccountID'
      Size = 15
    end
    object cdsChatAccountAccountTypeDescription: TStringField
      FieldName = 'AccountTypeDescription'
      Size = 30
    end
  end
  object cdsSaleTax: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 24
    object cdsSaleTaxSalesTaxCode: TStringField
      FieldName = 'SalesTaxCode'
      Size = 8
    end
    object cdsSaleTaxDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
  end
  object dsUser: TDataSource
    DataSet = cdsUser
    Left = 56
    Top = 80
  end
  object dsChartAccount: TDataSource
    DataSet = cdsChatAccount
    Left = 136
    Top = 80
  end
  object dsSaleTax: TDataSource
    DataSet = cdsSaleTax
    Left = 224
    Top = 80
  end
end
