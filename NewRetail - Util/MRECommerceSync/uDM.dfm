object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 46
  Top = 37
  Height = 446
  Width = 882
  object ADOCon: TADOConnection
    CommandTimeout = 15000
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mruser2000;Persist Security Info=Tr' +
      'ue;User ID=mruser;Initial Catalog=DiversaDB;Data Source=(local);' +
      'Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096' +
      ';Workstation ID=DESENV004;Use Encryption for Data=False;Tag with' +
      ' column collation when possible=False'
    ConnectionTimeout = 180
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 12
  end
  object qryInventoryItem: TADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'CAST(0 as Bit) as Mark,'
      #9'M.IDModel,'
      #9'M.Model,'
      #9'M.Description,'
      #9'C.Color,'
      #9'S.SizeName,'
      #9'C.CodColor,'
      #9'S.CodSize,'
      #9'M.LastMovDate,'
      #9'M.DateLastCost,'
      #9'M.VendorCost,'
      #9'M.OtherCost,'
      #9'M.FreightCost,'
      #9'M.FinalCost,'
      #9'M.SellingPrice,'
      #9'M.ModelType,'
      #9'M.ReplacementCost,'
      #9'M.PromotionPrice,'
      #9'M.DiscountPerc,'
      #9'M.ClasseABC as Classification,'
      #9'M.CaseQty,'
      #9'M.Verify,'#9#9
      
        #9'CASE WHEN M.AvgCost IS Null THEN M.VendorCost + M.OtherCost + M' +
        '.FreightCost ELSE M.AvgCost END as AvgCost,'
      
        #9'CASE WHEN M.SellingPrice > 0 THEN M.SellingPrice - M.FinalCost ' +
        'END as RealMarkUpValue,'
      
        #9'CASE WHEN M.SellingPrice > 0 AND M.FinalCost<>0 THEN (M.Selling' +
        'Price - M.FinalCost)/M.FinalCost*100 END as RealMarkUpPercent,'
      
        #9'CASE WHEN M.SellingPrice > 0 THEN (1 - (M.FinalCost/M.SellingPr' +
        'ice)) * 100 END as MarginPercent,'
      
        #9'CASE WHEN M.SellingPrice > 0 THEN ((1 - (M.FinalCost/M.SellingP' +
        'rice)) * M.SellingPrice) END as MarginValue,'
      #9'M.DateLastSellingPrice,'
      #9'M.SuggRetail,'
      #9'M.TotQtyOnHand,'
      #9'M.TotQtyOnRepair,'
      #9'M.TotQtyOnPreSale,'
      #9'M.TotQtyOnPrePurchase,'
      #9'M.TotQtyOnOrder,'
      #9'M.IDFabricante IDManufacturer,'
      #9'F.Pessoa as Manufacturer,'
      #9'MG.ModelGroup as SubCategory,'
      #9'MGS.ModelSubGroup as MGroup,'
      #9'TG.Name,'
      #9'TG.IDGroup,'
      #9'M.IDModelGroup,'
      #9'M.IDModelSubGroup,'
      #9'M.IDUserLastSellingPrice,'
      #9'SU.SystemUser as UserLastSellingPrice,'
      #9'M.Markup,'
      #9'M.FloatPercent,'
      #9'B.IDBarcode,'
      #9'M.Peso'
      'FROM'
      #9'Model M (NOLOCK)'
      #9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'
      
        #9'LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPess' +
        'oa)'
      
        #9'LEFT JOIN SystemUser SU (NOLOCK) ON (M.IDUserLastSellingPrice =' +
        ' SU.IDUser)'
      #9'LEFT OUTER JOIN InvColor C (NOLOCK) ON (M.IDColor = C.IDColor)'
      #9'LEFT OUTER JOIN InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)'
      
        #9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.' +
        'IDModelGroup)'
      
        #9'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGrou' +
        'p = MGS.IDModelSubGroup)'
      
        #9'LEFT JOIN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel AND B.Ba' +
        'rcodeOrder = 1)')
    Left = 624
    Top = 200
    object qryInventoryItemMark: TBooleanField
      FieldName = 'Mark'
    end
    object qryInventoryItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryInventoryItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object qryInventoryItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object qryInventoryItemColor: TStringField
      FieldName = 'Color'
    end
    object qryInventoryItemSizeName: TStringField
      FieldName = 'SizeName'
    end
    object qryInventoryItemCodColor: TStringField
      FieldName = 'CodColor'
      Size = 10
    end
    object qryInventoryItemCodSize: TStringField
      FieldName = 'CodSize'
      Size = 10
    end
    object qryInventoryItemLastMovDate: TDateTimeField
      FieldName = 'LastMovDate'
    end
    object qryInventoryItemDateLastCost: TDateTimeField
      FieldName = 'DateLastCost'
    end
    object qryInventoryItemVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object qryInventoryItemOtherCost: TBCDField
      FieldName = 'OtherCost'
      Precision = 19
    end
    object qryInventoryItemFreightCost: TBCDField
      FieldName = 'FreightCost'
      Precision = 19
    end
    object qryInventoryItemFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      Precision = 19
    end
    object qryInventoryItemSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object qryInventoryItemModelType: TStringField
      FieldName = 'ModelType'
      FixedChar = True
      Size = 1
    end
    object qryInventoryItemReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object qryInventoryItemPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object qryInventoryItemDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
    object qryInventoryItemClassification: TStringField
      FieldName = 'Classification'
      FixedChar = True
      Size = 1
    end
    object qryInventoryItemCaseQty: TBCDField
      FieldName = 'CaseQty'
      Precision = 32
    end
    object qryInventoryItemVerify: TBooleanField
      FieldName = 'Verify'
    end
    object qryInventoryItemAvgCost: TBCDField
      FieldName = 'AvgCost'
      ReadOnly = True
      Precision = 19
    end
    object qryInventoryItemRealMarkUpValue: TBCDField
      FieldName = 'RealMarkUpValue'
      ReadOnly = True
      Precision = 19
    end
    object qryInventoryItemRealMarkUpPercent: TBCDField
      FieldName = 'RealMarkUpPercent'
      ReadOnly = True
      Precision = 19
    end
    object qryInventoryItemMarginPercent: TBCDField
      FieldName = 'MarginPercent'
      ReadOnly = True
      Precision = 19
    end
    object qryInventoryItemMarginValue: TBCDField
      FieldName = 'MarginValue'
      ReadOnly = True
      Precision = 19
    end
    object qryInventoryItemDateLastSellingPrice: TDateTimeField
      FieldName = 'DateLastSellingPrice'
    end
    object qryInventoryItemSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object qryInventoryItemTotQtyOnHand: TBCDField
      FieldName = 'TotQtyOnHand'
      Precision = 32
    end
    object qryInventoryItemTotQtyOnRepair: TBCDField
      FieldName = 'TotQtyOnRepair'
      Precision = 32
    end
    object qryInventoryItemTotQtyOnPreSale: TBCDField
      FieldName = 'TotQtyOnPreSale'
      Precision = 32
    end
    object qryInventoryItemTotQtyOnPrePurchase: TBCDField
      FieldName = 'TotQtyOnPrePurchase'
      Precision = 32
    end
    object qryInventoryItemTotQtyOnOrder: TBCDField
      FieldName = 'TotQtyOnOrder'
      Precision = 32
    end
    object qryInventoryItemIDManufacturer: TIntegerField
      FieldName = 'IDManufacturer'
    end
    object qryInventoryItemManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object qryInventoryItemSubCategory: TStringField
      FieldName = 'SubCategory'
      Size = 30
    end
    object qryInventoryItemMGroup: TStringField
      FieldName = 'MGroup'
      Size = 30
    end
    object qryInventoryItemName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object qryInventoryItemIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object qryInventoryItemIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object qryInventoryItemIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object qryInventoryItemIDUserLastSellingPrice: TIntegerField
      FieldName = 'IDUserLastSellingPrice'
    end
    object qryInventoryItemUserLastSellingPrice: TStringField
      FieldName = 'UserLastSellingPrice'
      Size = 50
    end
    object qryInventoryItemMarkup: TBCDField
      FieldName = 'Markup'
      Precision = 19
    end
    object qryInventoryItemFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object qryInventoryItemIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object qryInventoryItemPeso: TBCDField
      FieldName = 'Peso'
      Precision = 19
    end
  end
  object dsLookUpStore: TDataSource
    DataSet = quLookUpStore
    Left = 40
    Top = 132
  end
  object quLookUpStore: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDStore,'#13#10'        Name'#13#10'FROM'#13#10'        Store (Fas' +
      'tFirstRow NOLOCK)'#13#10'ORDER BY'#13#10'        Name'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDStore'
    LookUpField = 'IDStore'
    Left = 40
    Top = 80
    object quLookUpStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quLookUpStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object LookUpCashReg: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDCashRegister , Name'#13#10'FROM dbo.CashRegister (FastFirstRo' +
      'w NOLOCK) ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDCashRegister'
    LookUpField = 'IDCashRegister'
    Left = 136
    Top = 80
    object LookUpCashRegIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object LookUpCashRegName: TStringField
      FieldName = 'Name'
      Size = 15
    end
  end
  object dsLookUpCashReg: TDataSource
    DataSet = LookUpCashReg
    Left = 136
    Top = 132
  end
  object spCheckOpenCash: TADOStoredProc
    Connection = ADOCon
    ProcedureName = 'sp_CashReg_CheckOpen;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@CashRegID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IsOpen'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@IDOpenUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDCashRegMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 40
    Top = 268
  end
  object LookUpUser: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT IDUser , SystemUser, ComissionID'#13#10'FROM dbo.SystemUser (Fa' +
      'stFirstRow NOLOCK) ORDER BY SystemUser'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'SystemUser'
    CodeField = 'IDUser'
    LookUpField = 'IDUser'
    Left = 236
    Top = 80
    object LookUpUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object LookUpUserSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object LookUpUserComissionID: TIntegerField
      FieldName = 'ComissionID'
    end
  end
  object dsLookUpUser: TDataSource
    DataSet = LookUpUser
    Left = 236
    Top = 132
  end
  object quLookUpGroup: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDGroup , Name, PathName, UserCode'#13#10'FROM dbo.TabGroup Tab' +
      'Group (FastFirstRow NOLOCK) ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'PathName'
    CodeFieldSearch = False
    LookUpField = 'IDGroup'
    Left = 332
    Top = 80
    object quLookUpGroupIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quLookUpGroupName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quLookUpGroupPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object quLookUpGroupUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
  end
  object dsLookUpGroup: TDataSource
    DataSet = quLookUpGroup
    Left = 332
    Top = 132
  end
  object dsLookUpSalesPerson: TDataSource
    DataSet = LookUpSalesPerson
    Left = 432
    Top = 132
  end
  object LookUpSalesPerson: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10'        P.IDPessoa IDComissionado,'#13#10'      ' +
      '  P.Pessoa,'#13#10'        P.Code'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10'WHERE '#9 +
      #13#10#9'P.IDTipoPessoaRoot = 4'#13#10#13#10'ORDER BY P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    Left = 432
    Top = 80
    object LookUpSalesPersonIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpSalesPersonIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpSalesPersonCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpSalesPersonPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object quPayments: TADODataSet
    Connection = ADOCon
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDMeioPag,'#13#10#9'MeioPag'#13#10'FROM'#13#10#9'MeioPag'#13#10'WHERE'#13#10#9'Desativad' +
      'o = 0'#13#10#9'AND'#13#10#9'Hidden = 0'#13#10#9'AND'#13#10#9'ParentType = '#39'Sale'#39#13#10
    Parameters = <>
    Left = 40
    Top = 200
    object quPaymentsIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quPaymentsMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
  end
  object FTP: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 136
    Top = 12
  end
  object HTTPReqRespCatalog: THTTPReqResp
    Agent = 'Borland SOAP 1.2'
    UseUTF8InHeader = False
    InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Left = 432
    Top = 12
  end
  object quCategory: TADODataSet
    Connection = ADOCon
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'TG.IDGroup,'#13#10#9'TG.[Name],'#13#10#9'CAST(TG.Desativado AS BIT) C' +
      'atDesativado,'#13#10#9'D.IDDepartment,'#13#10#9'D.Department,'#13#10#9'CAST(D.Desativ' +
      'ado AS BIT) DepDesativado'#13#10'FROM'#13#10#9'TabGroup TG (NOLOCK)'#13#10#9'JOIN In' +
      'v_Department D (NOLOCK) ON (TG.IDDepartment = D.IDDepartment)'#13#10'W' +
      'HERE'#13#10#9'TG.Service = 0'#13#10#9'AND TG.[System] = 0'#13#10#9'AND TG.Hidden = 0'#13 +
      #10#9'AND D.[System] = 0'#13#10#9'AND D.Hidden = 0'#13#10
    Parameters = <>
    Left = 136
    Top = 200
    object quCategoryIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quCategoryName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quCategoryIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quCategoryDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
    object quCategoryCatDesativado: TBooleanField
      FieldName = 'CatDesativado'
      ReadOnly = True
    end
    object quCategoryDepDesativado: TBooleanField
      FieldName = 'DepDesativado'
      ReadOnly = True
    end
  end
  object quManufacturer: TADODataSet
    Connection = ADOCon
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.Pessoa,'#13#10#9'CAST(P.Desativado AS BIT) Des' +
      'ativado'#13#10'FROM'#13#10#9'Pessoa P'#13#10#9'JOIN TipoPessoa TP ON (P.IDTipoPessoa' +
      'Root = TP.IDTipoPessoa)'#13#10'WHERE'#13#10#9'P.System = 0'#13#10#9'AND TP.Path like' +
      ' '#39'.004%'#39#13#10
    Parameters = <>
    Left = 236
    Top = 200
    object quManufacturerIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quManufacturerPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quManufacturerDesativado: TBooleanField
      FieldName = 'Desativado'
      ReadOnly = True
    end
  end
  object quProduct: TADODataSet
    Connection = ADOCon
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'CASE'#13#10#9#9'WHEN ISNULL(M.WebDescri' +
      'ption, '#39#39') = '#39#39' THEN M.[Description]'#13#10#9#9'ELSE ISNULL(M.WebDescrip' +
      'tion, '#39#39')'#13#10#9'END [Description],'#13#10#9'CASE'#13#10#9#9'WHEN IsNull(I.StoreCost' +
      'Price, 0) > 0 THEN I.StoreCostPrice'#13#10#9#9'ELSE M.VendorCost'#13#10#9'END V' +
      'endorCost,'#13#10#9'CASE'#13#10#9#9'WHEN IsNull(I.SellingPrice, 0) > 0 THEN I.S' +
      'ellingPrice'#13#10#9#9'ELSE M.SellingPrice'#13#10#9'END SellingPrice,'#13#10#9'CAST(M.' +
      'Desativado AS BIT) Desativado,'#13#10#9'TG.IDGroup IDCategoria,'#13#10#9'TG.[N' +
      'ame] Categoria,'#13#10#9'D.IDDepartment,'#13#10#9'D.Department,'#13#10#9'P.IDPessoa I' +
      'DFabricante,'#13#10#9'P.Pessoa Fabricante,'#13#10#9'IsNull(RTRIM(LTRIM(B.IDBar' +
      'code)), '#39#39') Barcode'#13#10'FROM'#13#10#9'Model M'#13#10#9'JOIN TabGroup TG (NOLOCK) ' +
      'ON (M.GroupID = TG.IDGroup)'#13#10#9'JOIN Inv_Department D (NOLOCK) ON ' +
      '(TG.IDDepartment = D.IDDepartment)'#13#10#9'LEFT JOIN Inventory I (NOLO' +
      'CK) ON (M.IDModel = I.ModelID AND I.StoreID = :IDStore)'#13#10#9'LEFT J' +
      'OIN Pessoa P (NOLOCK) ON (M.IDFabricante = P.IDPessoa)'#13#10#9'LEFT JO' +
      'IN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel AND B.BarcodeOrd' +
      'er = 1)'#13#10'WHERE'#13#10#9'M.System = 0'#13#10#9'AND M.Hidden = 0'#13#10#9'AND M.IDModel' +
      'Parent IS NULL'#13#10#9'AND TG.Service = 0'
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    Left = 332
    Top = 200
    object quProductIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quProductModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quProductVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quProductSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quProductIDCategoria: TIntegerField
      FieldName = 'IDCategoria'
    end
    object quProductCategoria: TStringField
      FieldName = 'Categoria'
      Size = 30
    end
    object quProductIDFabricante: TIntegerField
      FieldName = 'IDFabricante'
    end
    object quProductFabricante: TStringField
      FieldName = 'Fabricante'
      Size = 50
    end
    object quProductBarcode: TStringField
      FieldName = 'Barcode'
      ReadOnly = True
      FixedChar = True
    end
    object quProductDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 255
    end
    object quProductIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quProductDesativado: TBooleanField
      FieldName = 'Desativado'
      ReadOnly = True
    end
    object quProductDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object tmrImport: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrImportTimer
    Left = 528
    Top = 12
  end
  object tmrExport: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrExportTimer
    Left = 624
    Top = 12
  end
  object quInventory: TADODataSet
    Connection = ADOCon
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'I.ModelID,'#13#10#9'I.QtyOnHand,'#13#10#9'I.QtyOnPreSale'#13#10'FROM'#13#10#9'Inve' +
      'ntory I'#13#10'WHERE'#13#10#9'I.StoreID = :IDStore'
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 528
    Top = 200
    object quInventoryModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quInventoryQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      Precision = 32
    end
    object quInventoryQtyOnPreSale: TBCDField
      FieldName = 'QtyOnPreSale'
      Precision = 32
    end
  end
  object quSKU: TADODataSet
    Connection = ADOCon
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.IDModelParent,'#13#10#9'M.Model,'#13#10#9'CASE'#13#10#9#9'WHEN' +
      ' ISNULL(M.WebDescription, '#39#39') = '#39#39' THEN M.[Description]'#13#10#9#9'ELSE ' +
      'ISNULL(M.WebDescription, '#39#39')'#13#10#9'END [Description],'#13#10#9'S.SizeName,'#13 +
      #10#9'C.Color,'#13#10#9'CASE'#13#10#9#9'WHEN IsNull(I.StoreCostPrice, 0) > 0 THEN I' +
      '.StoreCostPrice'#13#10#9#9'ELSE M.VendorCost'#13#10#9'END VendorCost,'#13#10#9'CASE'#13#10#9 +
      #9'WHEN IsNull(I.SellingPrice, 0) > 0 THEN I.SellingPrice'#13#10#9#9'ELSE ' +
      'M.SellingPrice'#13#10#9'END SellingPrice,'#13#10#9'CAST(M.Desativado AS BIT) D' +
      'esativado,'#13#10#9'TG.IDGroup IDCategoria,'#13#10#9'TG.[Name] Categoria,'#13#10#9'D.' +
      'IDDepartment,'#13#10#9'D.Department,'#13#10#9'P.IDPessoa IDFabricante,'#13#10#9'P.Pes' +
      'soa Fabricante,'#13#10#9'IsNull(RTRIM(LTRIM(B.IDBarcode)), '#39#39') Barcode'#13 +
      #10'FROM'#13#10#9'Model M'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.I' +
      'DGroup)'#13#10#9'JOIN Inv_Department D (NOLOCK) ON (TG.IDDepartment = D' +
      '.IDDepartment)'#13#10#9'LEFT JOIN Inventory I (NOLOCK) ON (M.IDModel = ' +
      'I.ModelID AND I.StoreID = :IDStore)'#13#10#9'LEFT JOIN Pessoa P (NOLOCK' +
      ') ON (M.IDFabricante = P.IDPessoa)'#13#10#9'LEFT JOIN Barcode B (NOLOCK' +
      ') ON (M.IDModel = B.IDModel AND B.BarcodeOrder = 1)'#13#10#9'LEFT JOIN ' +
      'InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)'#13#10#9'LEFT JOIN InvColor' +
      ' C (NOLOCK) ON (M.IDColor = C.IDColor)'#13#10'WHERE'#13#10#9'M.System = 0'#13#10#9'A' +
      'ND M.Hidden = 0'#13#10#9'AND M.ModelType <> '#39'M'#39#13#10#9'AND TG.Service = 0'#13#10#9 +
      #13#10
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    Left = 432
    Top = 200
    object IntegerField1: TIntegerField
      FieldName = 'IDModel'
    end
    object StringField1: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object BCDField1: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object BCDField2: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object IntegerField2: TIntegerField
      FieldName = 'IDCategoria'
    end
    object StringField3: TStringField
      FieldName = 'Categoria'
      Size = 30
    end
    object IntegerField3: TIntegerField
      FieldName = 'IDFabricante'
    end
    object StringField4: TStringField
      FieldName = 'Fabricante'
      Size = 50
    end
    object quSKUBarcode: TStringField
      FieldName = 'Barcode'
      ReadOnly = True
      FixedChar = True
    end
    object quSKUDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 255
    end
    object quSKUDesativado: TBooleanField
      FieldName = 'Desativado'
      ReadOnly = True
    end
    object quSKUIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quSKUDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
    object quSKUIDModelParent: TIntegerField
      FieldName = 'IDModelParent'
    end
    object quSKUSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quSKUColor: TStringField
      FieldName = 'Color'
    end
  end
  object cdsLog: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 268
    object cdsLogID: TIntegerField
      FieldName = 'ID'
    end
    object cdsLogMsgError: TStringField
      FieldName = 'MsgError'
      Size = 255
    end
    object cdsLogDateTime: TDateTimeField
      FieldName = 'DateTime'
    end
  end
  object IdSMTP: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Host = 'mail.mainretail.com'
    Port = 25
    AuthenticationType = atNone
    Password = 'eliandro123'
    Username = 'posdev@pinogy.com'
    Left = 236
    Top = 12
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    From.Address = 'eliandrosouza@mainretail.com'
    From.Name = 'Desenvolvimento SoftVar'
    From.Text = 'Desenvolvimento SoftVar <eliandrosouza@mainretail.com>'
    Recipients = <>
    ReplyTo = <>
    Left = 332
    Top = 12
  end
  object dsLookUpMedia: TDataSource
    DataSet = quLookUpMedia
    Left = 528
    Top = 132
  end
  object quLookUpMedia: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'M.IDMedia,'#13#10#9'M.Media'#13#10'FROM'#13#10#9'Media M (NOLOCK)'#13#10'WHERE'#13#10#9 +
      'M.Desativado = 0'#13#10#9'AND M.Hidden = 0'#13#10'ORDER BY'#13#10#9'M.Media'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Media'
    CodeField = 'IDMedia'
    LookUpField = 'IDMedia'
    Left = 528
    Top = 80
    object quLookUpMediaIDMedia: TIntegerField
      FieldName = 'IDMedia'
    end
    object quLookUpMediaMedia: TStringField
      FieldName = 'Media'
      Size = 255
    end
  end
  object dsLookUpOtherCosts: TDataSource
    DataSet = quLookUpOtherCosts
    Left = 624
    Top = 132
  end
  object quLookUpOtherCosts: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'CT.IDCostType,'#13#10#9'CT.CostType'#13#10'FROM '#9#13#10#9'CostType CT (NOL' +
      'OCK)'#13#10'WHERE '#9#13#10#9'CT.Desativado = 0'#13#10#9'AND CT.Hidden = 0'#13#10'ORDER BY'#13 +
      #10#9'CT.CostType'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'CostType'
    CodeField = 'IDCostType'
    LookUpField = 'IDCostType'
    Left = 624
    Top = 80
    object quLookUpOtherCostsIDCostType: TIntegerField
      FieldName = 'IDCostType'
    end
    object quLookUpOtherCostsCostType: TStringField
      FieldName = 'CostType'
      Size = 50
    end
  end
  object dsLookUpPersonType: TDataSource
    DataSet = quLookUpPersonType
    Left = 736
    Top = 132
  end
  object quLookUpPersonType: TLookUpADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'TP.IDTipoPessoa,'#13#10#9'TP.PathName'#13#10'FROM'#13#10#9'TipoPessoa TP (N' +
      'OLOCK)'#13#10'WHERE'#13#10#9'TP.Path LIKE '#39'.001%'#39#13#10#9'AND TP.Desativado = 0'#13#10#9'A' +
      'ND TP.Hidden = 0'#13#10'ORDER BY'#13#10#9'TP.PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoPessoa'
    LookUpField = 'IDTipoPessoa'
    Left = 736
    Top = 80
    object quLookUpPersonTypeIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object quLookUpPersonTypePathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  object quHasCustomer: TADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Juridico'
        Size = -1
        Value = Null
      end
      item
        Name = 'CNPJ'
        Size = -1
        Value = Null
      end
      item
        Name = 'CPF'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDPessoa'
      'FROM'
      #9'Pessoa P (NOLOCK)'
      
        #9'JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPesso' +
        'a)'
      'WHERE'
      #9'TP.Path LIKE '#39'.001%'#39
      
        #9'AND (CASE WHEN :Juridico = 0 THEN P.InscEstadual = :CNPJ ELSE P' +
        '.CPF = :CPF END)')
    Left = 236
    Top = 268
  end
  object quHasSale: TADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale'
      'FROM'
      #9'Invoice I (NOLOCK)'
      'WHERE'
      #9'I.SaleCode = :SaleCode')
    Left = 432
    Top = 268
  end
  object quInsertCustomer: TADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDEstado'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 3
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ShortName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PessoaFirstName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'PessoaLastName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'NomeJuridico'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Endereco'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 80
        Value = Null
      end
      item
        Name = 'Cidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CEP'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end
      item
        Name = 'Pais'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 21
        Value = Null
      end
      item
        Name = 'Telefone'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Cellular'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 18
        Value = Null
      end
      item
        Name = 'Fax'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Email'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end
      item
        Name = 'Juridico'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'Nascimento'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'CPF'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'CGC'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Identidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'InscEstadual'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'HomePage'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 200
        Value = Null
      end
      item
        Name = 'Bairro'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Code'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Complemento'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'ComplementoNum'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'INSERT INTO Pessoa (IDPessoa, IDTipoPessoa, IDStore, IDEstado, I' +
        'DUser, ShortName, Pessoa, PessoaFirstName, PessoaLastName, NomeJ' +
        'uridico, Endereco, Cidade, CEP, Pais, Telefone, Cellular, Fax, E' +
        'mail, OBS, Juridico, Nascimento, CPF, CGC, Identidade, InscEstad' +
        'ual, HomePage, Bairro, Code, Complemento, ComplementoNum)'
      
        'VALUES (:IDPessoa, :IDTipoPessoa, :IDStore, :IDEstado, :IDUser, ' +
        ':ShortName, :Pessoa, :PessoaFirstName, :PessoaLastName, :NomeJur' +
        'idico, :Endereco, :Cidade, :CEP, :Pais, :Telefone, :Cellular, :F' +
        'ax, :Email, :OBS, :Juridico, :Nascimento, :CPF, :CGC, :Identidad' +
        'e, :InscEstadual, :HomePage, :Bairro, :Code, :Complemento, :Comp' +
        'lementoNum)')
    Left = 332
    Top = 268
  end
  object quCommission: TADOQuery
    Connection = ADOCon
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDUser'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'SU.ComissionID'
      'FROM'
      #9'SystemUser SU (NOLOCK)'
      'WHERE'
      #9'SU.IDUser = :IDUser')
    Left = 528
    Top = 268
  end
end
