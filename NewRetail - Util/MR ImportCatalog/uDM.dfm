object DM: TDM
  OldCreateOrder = False
  Left = 287
  Top = 172
  Height = 509
  Width = 639
  object DBConnection: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=RodrigoTestDB;Data Source=desenv001;Use' +
      ' Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Wo' +
      'rkstation ID=DESENV001;Use Encryption for Data=False;Tag with co' +
      'lumn collation when possible=False'
    ConnectionTimeout = 20
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 542
    Top = 12
  end
  object quCkeckModel: TADODataSet
    CommandText = 
      'SELECT'#9'I1.Model'#13#10'FROM'#9'InvTemp I1'#13#10#9'JOIN InvTemp I2 ON (I1.Model ' +
      '= I2.Model)'#13#10'GROUP BY I1.Model'#13#10'HAVING  Count(I1.Model) > 1'
    CommandTimeout = 180
    Parameters = <>
    Left = 351
    Top = 16
    object quCkeckModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
  end
  object quLookUpTax: TLookUpADOQuery
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'TaxCategory'
    CodeField = 'IDTaxCategory'
    LookUpField = 'IDTaxCategory'
    Left = 275
    Top = 8
    object quLookUpTaxIDTaxCategory: TAutoIncField
      FieldName = 'IDTaxCategory'
      ReadOnly = True
    end
    object quLookUpTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
  end
  object dsLookUpStore: TDataSource
    Left = 430
    Top = 66
  end
  object dsLookUpTax: TDataSource
    DataSet = quLookUpTax
    Left = 275
    Top = 61
  end
  object quSize: TADODataSet
    CommandText = 
      'SELECT DISTINCT '#13#10#9'InvSize'#13#10'FROM'#13#10#9'MODEL_IMPORT'#13#10'WHERE'#13#10#9'InvSize' +
      ' IS NOT NULL'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 36
    Top = 36
    object quSizeInvSize: TStringField
      FieldName = 'InvSize'
    end
  end
  object quColor: TADODataSet
    CommandText = 
      'SELECT DISTINCT '#13#10#9'InvColor'#13#10'FROM'#13#10#9'MODEL_IMPORT'#13#10'WHERE'#13#10#9'InvCol' +
      'or IS NOT NULL'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 36
    Top = 86
    object quColorInvColor: TStringField
      FieldName = 'InvColor'
    end
  end
  object quFabricante: TADODataSet
    CommandText = 
      'SELECT DISTINCT '#13#10#9'Manufacture'#13#10'FROM'#13#10#9'MODEL_IMPORT'#13#10'WHERE'#13#10#9'Man' +
      'ufacture IS NOT NULL'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 36
    Top = 141
    object quFabricanteManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
  end
  object quSubGroup: TADODataSet
    CommandText = 
      'SELECT DISTINCT '#13#10#9'SubGroup'#13#10'FROM'#13#10#9'MODEL_IMPORT'#13#10'WHERE'#13#10#9'SubGro' +
      'up IS NOT NULL'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 86
    Top = 171
    object quSubGroupSubGroup: TStringField
      FieldName = 'SubGroup'
      Size = 50
    end
  end
  object quTabGroup: TADODataSet
    CommandText = 
      'SELECT DISTINCT '#13#10#9'TabGroup'#13#10'FROM'#13#10#9'MODEL_IMPORT'#13#10'WHERE'#13#10#9'TabGro' +
      'up IS NOT NULL'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 36
    Top = 201
    object quTabGroupTabGroup: TStringField
      FieldName = 'TabGroup'
      Size = 30
    end
  end
  object quModel: TADODataSet
    CommandText = 
      'SELECT'#13#10#9'Model,'#13#10#9'Description,'#13#10#9'CustoPrice,'#13#10#9'SalePrice,'#13#10#9'IDSi' +
      'ze,'#13#10#9'IDColor,'#13#10#9'IDManufect,'#13#10#9'IDTabGroup,'#13#10#9'IDBarcode,'#13#10#9'IDSubG' +
      'roup'#13#10'FROM'#13#10#9'MODEL_IMPORT'#13#10'WHERE'#13#10#9'Model IS NOT NULL'
    CommandTimeout = 180
    Parameters = <>
    Left = 36
    Top = 246
    object quModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelCustoPrice: TBCDField
      FieldName = 'CustoPrice'
      Precision = 19
    end
    object quModelSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quModelIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object quModelIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object quModelIDManufect: TIntegerField
      FieldName = 'IDManufect'
    end
    object quModelIDTabGroup: TIntegerField
      FieldName = 'IDTabGroup'
    end
    object quModelIDBarcode: TStringField
      FieldName = 'IDBarcode'
    end
    object quModelIDSubGroup: TIntegerField
      FieldName = 'IDSubGroup'
    end
  end
  object quVendorCode: TADODataSet
    CommandText = 
      'SELECT DISTINCT'#13#10#9'IDModel,'#13#10#9'IDManufect,'#13#10#9'VendorCode'#13#10'FROM'#13#10#9'MO' +
      'DEL_IMPORT'#13#10'WHERE'#13#10#9'VendorCode IS NOT NULL'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 36
    Top = 296
    object quVendorCodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quVendorCodeIDManufect: TIntegerField
      FieldName = 'IDManufect'
    end
    object quVendorCodeVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 10
    end
  end
  object quInventory: TADODataSet
    CommandText = 
      'Select '#13#10#9'MT.Qty, '#13#10#9'M.IDModel,'#13#10#9'M.VendorCost,'#13#10#9'M.SellingPrice' +
      #13#10'From '#13#10#9'Model M'#13#10#9'JOIN MODEL_TEMP MT ON (MT.Model = M.Model)'#13#10 +
      'Where '#13#10#9'MT.Qty is not null '#13#10#9'OR '#13#10#9'MT.Qty > 0'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 503
    Top = 232
    object quInventoryQty: TIntegerField
      FieldName = 'Qty'
    end
    object quInventoryIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quInventoryVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quInventorySellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
  end
  object spGetNextID: TADOStoredProc
    Connection = DBConnection
    ProcedureName = 'sp_Sis_GetNextCode;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Tabela'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@NovoCodigo'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 504
    Top = 175
  end
  object quLookUpStore: TLookUpADOQuery
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDStore'
    LookUpField = 'IDStore'
    Left = 430
    Top = 13
    object quLookUpStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quLookUpStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object quVendorList: TADODataSet
    Connection = DBConnection
    CommandText = 'SELECT'#13#10#9'IDVendor,'#9#13#10#9'Vendor'#13#10'FROM'#13#10#9'MRCatalogDB..Vendor'#13#10
    Parameters = <>
    Left = 108
    Top = 397
    object quVendorListIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quVendorListVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object quVendorFiltered: TADODataSet
    Connection = DBConnection
    CommandText = 
      'SELECT'#13#10#9'IDVendor,'#9#13#10#9'Vendor'#13#10'FROM'#13#10#9'MRCatalogDB..Vendor'#13#10'WHERE ' +
      #13#10#9'Vendor = :Vendor'
    Parameters = <
      item
        Name = 'Vendor'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end>
    Left = 196
    Top = 397
    object quVendorFilteredIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quVendorFilteredVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object quModelCatalogList: TADODataSet
    Connection = DBConnection
    CommandText = 
      'SELECT'#13#10#9'IDModelCatalog,'#13#10#9'IDModel,'#13#10#9'IDVendor,'#13#10#9'IDSize,'#13#10#9'IDCo' +
      'lor,'#13#10#9'IDManufect,'#13#10#9'IDTabGroup,'#13#10#9'IDSubGroup,'#13#10#9'IDBarcode,'#13#10#9'Mo' +
      'del,'#13#10#9'InvSize,'#13#10#9'InvColor,'#13#10#9'Description,'#13#10#9'Manufacture,'#13#10#9'TabG' +
      'roup,'#13#10#9'CustoPrice,'#13#10#9'SalePrice,'#13#10#9'VendorCode,'#13#10#9'Qty,'#13#10#9'SubGroup' +
      ','#13#10#9'QtyMin,'#13#10#9'QtyMax'#13#10'FROM'#13#10#9'MRCatalogDB..Model_Catalog'
    Parameters = <>
    Left = 131
    Top = 327
    object quModelCatalogListIDModelCatalog: TIntegerField
      FieldName = 'IDModelCatalog'
    end
    object quModelCatalogListIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelCatalogListIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quModelCatalogListIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object quModelCatalogListIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object quModelCatalogListIDManufect: TIntegerField
      FieldName = 'IDManufect'
    end
    object quModelCatalogListIDTabGroup: TIntegerField
      FieldName = 'IDTabGroup'
    end
    object quModelCatalogListIDSubGroup: TIntegerField
      FieldName = 'IDSubGroup'
    end
    object quModelCatalogListIDBarcode: TStringField
      FieldName = 'IDBarcode'
    end
    object quModelCatalogListModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelCatalogListInvSize: TStringField
      FieldName = 'InvSize'
    end
    object quModelCatalogListInvColor: TStringField
      FieldName = 'InvColor'
    end
    object quModelCatalogListDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelCatalogListManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
    object quModelCatalogListTabGroup: TStringField
      FieldName = 'TabGroup'
      Size = 30
    end
    object quModelCatalogListCustoPrice: TBCDField
      FieldName = 'CustoPrice'
      Precision = 19
    end
    object quModelCatalogListSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quModelCatalogListVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 10
    end
    object quModelCatalogListQty: TIntegerField
      FieldName = 'Qty'
    end
    object quModelCatalogListSubGroup: TStringField
      FieldName = 'SubGroup'
      Size = 50
    end
    object quModelCatalogListQtyMin: TIntegerField
      FieldName = 'QtyMin'
    end
    object quModelCatalogListQtyMax: TIntegerField
      FieldName = 'QtyMax'
    end
  end
  object DsModelCatalogList: TDataSource
    DataSet = quModelCatalogList
    Left = 181
    Top = 327
  end
  object quSelectModelCatalog: TADODataSet
    Connection = DBConnection
    CommandText = 
      'SELECT  '#13#10#9'IDModelCatalog'#13#10'FROM'#13#10#9'MRCatalogDB..Model_Catalog'#13#10'WH' +
      'ERE'#13#10#9'IDVendor = :IDVendor'#13#10#9'AND'#13#10#9'IDModel = :IDModel'
    Parameters = <
      item
        Name = 'IDVendor'
        Attributes = [paSigned]
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
    Left = 271
    Top = 327
    object quSelectModelCatalogIDModelCatalog: TIntegerField
      FieldName = 'IDModelCatalog'
    end
  end
  object quModelFiltered: TADODataSet
    Connection = DBConnection
    CommandText = 
      'SELECT  '#13#10#9'IDModel,'#13#10#9'Description'#13#10'FROM'#13#10#9'Model'#13#10'WHERE'#13#10#9'Descrip' +
      'tion = :ModelDescription'
    Parameters = <
      item
        Name = 'ModelDescription'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end>
    Left = 271
    Top = 402
    object quModelFilteredIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelFilteredDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object quCmdFree: TADOCommand
    CommandTimeout = 360
    Connection = DBConnection
    Parameters = <>
    ParamCheck = False
    Left = 544
    Top = 72
  end
  object DCOMConn: TDCOMConnection
    ServerGUID = '{D74FD8ED-A48F-4459-9817-7B282DD37A6D}'
    ServerName = 'MRAppServer.RDMImportExport'
    Left = 236
    Top = 168
  end
end
