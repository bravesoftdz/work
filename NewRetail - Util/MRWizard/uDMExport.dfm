inherited DMExport: TDMExport
  OldCreateOrder = True
  Left = 172
  Top = 202
  object cdsCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    OnNewRecord = cdsCategoryNewRecord
    Left = 40
    Top = 232
    object cdsCategoryID: TIntegerField
      FieldName = 'ID'
    end
    object cdsCategoryCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object cdsCategoryMarkup: TFloatField
      FieldName = 'Markup'
    end
    object cdsCategorySizeAndColor: TBooleanField
      FieldName = 'SizeAndColor'
    end
    object cdsCategorySizeList: TWideStringField
      FieldName = 'SizeList'
      Size = 1000
    end
    object cdsCategoryColorList: TWideStringField
      FieldName = 'ColorList'
      Size = 1000
    end
    object cdsCategorySystem: TBooleanField
      FieldName = 'System'
    end
  end
  object dsCategory: TDataSource
    DataSet = cdsCategory
    Left = 40
    Top = 288
  end
  object dsModel: TDataSource
    DataSet = cdsModel
    Left = 112
    Top = 288
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsModelBeforePost
    Left = 112
    Top = 232
    object cdsModelCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object cdsModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsModelCostPrice: TCurrencyField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelSalePrice: TCurrencyField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsModelBarcode: TStringField
      FieldName = 'Barcode'
    end
    object cdsModelSizeAndColor: TBooleanField
      FieldName = 'SizeAndColor'
    end
    object cdsModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object cmdFree: TADOCommand
    Connection = ADODBConnect
    Parameters = <>
    Left = 296
    Top = 16
  end
  object cdsUser: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 188
    Top = 232
    object cdsUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsUserUserName: TStringField
      FieldName = 'UserName'
      Size = 50
    end
    object cdsUserPassword: TStringField
      FieldName = 'Password'
      Size = 10
    end
    object cdsUserIDUserType: TIntegerField
      FieldName = 'IDUserType'
      Required = True
    end
  end
  object dsUser: TDataSource
    DataSet = cdsUser
    Left = 188
    Top = 292
  end
  object cdsVendor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 232
    object cdsVendorIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsVendorVendor: TStringField
      FieldName = 'Vendor'
      Required = True
      Size = 30
    end
    object cdsVendorPhone: TStringField
      FieldName = 'Phone'
    end
  end
  object dsVendor: TDataSource
    DataSet = cdsVendor
    Left = 258
    Top = 292
  end
  object cdsSize: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 324
    Top = 236
    object cdsSizeIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object cdsSizeMSize: TStringField
      FieldName = 'MSize'
      Required = True
    end
  end
  object cdsColor: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 388
    Top = 236
    object cdsColorIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object cdsColorMColor: TStringField
      FieldName = 'MColor'
      Required = True
    end
  end
  object cdsGrid: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 452
    Top = 236
    object cdsGridModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsGridMSize: TStringField
      FieldName = 'MSize'
    end
    object cdsGridMColor: TStringField
      FieldName = 'MColor'
    end
    object cdsGridQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsGridSalePrice: TCurrencyField
      FieldName = 'SalePrice'
    end
  end
  object dsSize: TDataSource
    DataSet = cdsSize
    Left = 328
    Top = 296
  end
  object dsColor: TDataSource
    DataSet = cdsColor
    Left = 388
    Top = 296
  end
  object dsGrid: TDataSource
    DataSet = cdsGrid
    Left = 452
    Top = 296
  end
  object spAddSize: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_Inventory_AddSize;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDSize'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@BarcodeCreate'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 44
    Top = 84
  end
  object spAddColor: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_Inventory_AddColor;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDColor'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@BarcodeCreate'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 120
    Top = 84
  end
  object cdsPetCustomer: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 532
    Top = 236
    object cdsPetCustomerID: TStringField
      FieldName = 'ID'
      Size = 255
    end
    object cdsPetCustomerStore: TStringField
      FieldName = 'Store'
      Size = 50
    end
    object cdsPetCustomerAddress: TStringField
      FieldName = 'Address'
      Size = 100
    end
    object cdsPetCustomerAddress2: TStringField
      FieldName = 'Address2'
      Size = 100
    end
    object cdsPetCustomerCity: TStringField
      FieldName = 'City'
      Size = 50
    end
    object cdsPetCustomerState: TStringField
      FieldName = 'State'
      Size = 2
    end
    object cdsPetCustomerZip: TStringField
      FieldName = 'Zip'
    end
    object cdsPetCustomerCountry: TStringField
      FieldName = 'Country'
      Size = 50
    end
    object cdsPetCustomerPhone: TStringField
      FieldName = 'Phone'
    end
    object cdsPetCustomerFax: TStringField
      FieldName = 'Fax'
    end
    object cdsPetCustomerEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object cdsPetCustomerWeb: TStringField
      FieldName = 'Web'
      Size = 100
    end
    object cdsPetCustomerContact1: TStringField
      FieldName = 'Contact1'
      Size = 50
    end
    object cdsPetCustomerPhone1: TStringField
      FieldName = 'Phone1'
    end
    object cdsPetCustomerEmail1: TStringField
      FieldName = 'Email1'
      Size = 100
    end
  end
end
