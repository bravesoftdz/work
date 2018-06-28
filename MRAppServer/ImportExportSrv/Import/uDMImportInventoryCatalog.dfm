object DMImportInventoryCatalog: TDMImportInventoryCatalog
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 316
  Top = 210
  Height = 328
  Width = 432
  object cmdUpdateModelPrice: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Model'#13#10'SET'#13#10#9'VendorCost = :NewCost,'#13#10#9'SellingPrice = :N' +
      'ewSalePrice,'#13#10#9'SuggRetail = :NewMSRP,'#13#10#9'DateLastSellingPrice = :' +
      'ChangeDate,'#13#10#9'IDUserLastSellingPrice = :IDUserLastSellingPrice'#13#10 +
      'WHERE'#13#10#9'IDModel = :IDModel'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'NewCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewSalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewMSRP'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'ChangeDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDUserLastSellingPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 136
    Top = 20
  end
  object qryProducts: TADODataSet
    OnCalcFields = qryProductsCalcFields
    CommandText = 
      'SELECT'#13#10#9'Convert(bit , 0) as Mark, '#13#10#9'CP.sku, '#13#10#9'CP.upc,'#13#10#9'CP.Ti' +
      'tle,'#13#10#9'PV.vCost as VendorCost,'#13#10#9'CP.wholesale,'#13#10#9'CP.Department a' +
      's Category,'#13#10#9'CP.Category as SubCategory,'#13#10#9'CP.SubCategory as CG' +
      'roup,'#13#10#9'CP.Tax_Category,'#13#10#9'CP.Mfg,'#13#10#9'V.Vendor,'#13#10#9'M.IDModel,'#13#10#9'M.' +
      'Model,'#13#10#9'M.Description,'#13#10#9'M.FinalCost,'#13#10#9'M.SellingPrice,'#13#10#9'M.Sug' +
      'gRetail,'#13#10#9'F.Pessoa as Manufacture,'#13#10#9'TG.IDGroup as IDCategory,'#13 +
      #10#9'SC.IDModelGroup IDSubCategory,'#13#10#9'SCG.IDModelSubGroup as IDGrou' +
      'p,'#13#10#9'TG.Name as ModelCategory,'#13#10#9'SC.ModelGroup as ModelSubCatego' +
      'ry,'#13#10#9'SCG.ModelSubGroup as ModelGroup,'#13#10#9'0.0 as NewSalePrice,'#13#10#9 +
      '0.0 as NewMSRPPrice'#13#10'FROM'#13#10#9'MRCatalogDB..Products CP'#13#10#9'JOIN MRCa' +
      'talogDB..Products_Vendors PV ON (CP.Sku = PV.Sku)'#13#10#9'JOIN MRCatal' +
      'ogDB..Vendors V ON (V.IDVendor = PV.IDVendor)'#13#10#9'LEFT JOIN Barcod' +
      'e B ON (B.IDBarcode = CP.upc)'#13#10#9'LEFT JOIN Model M ON (B.IDModel ' +
      '= M.IDModel)'#13#10#9'LEFT JOIN Pessoa F ON (F.IDPessoa = M.IDFabricant' +
      'e)'#13#10#9'LEFT JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)'#13#10#9'LEFT JO' +
      'IN ModelGroup SC ON (SC.IDModelGroup = M.IDModelGroup)'#13#10#9'LEFT JO' +
      'IN ModelSubGroup SCG ON (SCG.IDModelSubGroup = M.IDModelSubGroup' +
      ')'#13#10'WHERE'#13#10#9'Inactive = 0'#13#10#13#10
    CommandTimeout = 300
    Parameters = <>
    Left = 40
    Top = 16
    object qryProductsMark: TBooleanField
      FieldName = 'Mark'
    end
    object qryProductssku: TStringField
      FieldName = 'sku'
      ReadOnly = True
      Size = 64
    end
    object qryProductsupc: TStringField
      FieldName = 'upc'
      ReadOnly = True
    end
    object qryProductsTitle: TStringField
      FieldName = 'Title'
      ReadOnly = True
      Size = 50
    end
    object qryProductsPriceInfo: TStringField
      FieldKind = fkCalculated
      FieldName = 'PriceInfo'
      ReadOnly = True
      Size = 15
      Calculated = True
    end
    object qryProductsVendorCost: TCurrencyField
      FieldName = 'VendorCost'
      ReadOnly = True
    end
    object qryProductswholesale: TBCDField
      FieldName = 'wholesale'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryProductsVendor: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 32
    end
    object qryProductsCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object qryProductsSubCategory: TStringField
      DisplayLabel = 'Sub-Category'
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object qryProductsCGroup: TStringField
      DisplayLabel = 'Group'
      FieldName = 'CGroup'
      ReadOnly = True
      Size = 30
    end
    object qryProductsTax_Category: TStringField
      FieldName = 'Tax_Category'
      ReadOnly = True
      Size = 50
    end
    object qryProductsMfg: TStringField
      FieldName = 'Mfg'
      ReadOnly = True
      Size = 255
    end
    object qryProductsIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
      Visible = False
    end
    object qryProductsModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object qryProductsDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object qryProductsFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryProductsSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryProductsSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryProductsManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object qryProductsIDCategory: TIntegerField
      FieldName = 'IDCategory'
      ReadOnly = True
      Visible = False
    end
    object qryProductsIDSubCategory: TIntegerField
      FieldName = 'IDSubCategory'
      ReadOnly = True
      Visible = False
    end
    object qryProductsIDGroup: TIntegerField
      FieldName = 'IDGroup'
      ReadOnly = True
      Visible = False
    end
    object qryProductsModelCategory: TStringField
      FieldName = 'ModelCategory'
      ReadOnly = True
      Size = 30
    end
    object qryProductsModelSubCategory: TStringField
      FieldName = 'ModelSubCategory'
      ReadOnly = True
      Size = 30
    end
    object qryProductsModelGroup: TStringField
      FieldName = 'ModelGroup'
      ReadOnly = True
      Size = 30
    end
    object qryProductsNewSalePrice: TBCDField
      FieldName = 'NewSalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryProductsNewMSRPPrice: TBCDField
      FieldName = 'NewMSRPPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dspProducts: TDataSetProvider
    DataSet = qryProducts
    Left = 40
    Top = 72
  end
  object cdsProducts: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProducts'
    Left = 40
    Top = 136
  end
  object cmdUpdateInventory: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Model'#13#10'SET'#13#10#9'Description = :Description'#13#10'WHERE'#13#10#9'IDMode' +
      'l = :IDModel'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'Description'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 136
    Top = 68
  end
end
