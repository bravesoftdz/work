object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 319
  Top = 158
  Height = 460
  Width = 543
  object ADOPetConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Work\PUPPYTRACKE' +
      'R\PuppytrackerStores.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 40
    Top = 8
  end
  object quPuppy: TADODataSet
    Connection = ADOPetConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'Breed.Breed_Code, '#13#10#9'Breed.Breed_Name, '#13#10#9'Pups.Referenc' +
      'e_No, '#13#10#9'Pups.Weight, '#13#10#9'Pups.Color, '#13#10#9'Pups.Pur_Price, '#13#10#9'Pups.' +
      'Regular_Price, '#13#10#9'Pups.Sale_Price,'#13#10#9'Pups.Sales_Price,'#13#10#9'Pups.Se' +
      'x,'#13#10#9'Pups.Chip_No'#13#10'FROM '#13#10#9'Pups '#13#10#9'INNER JOIN Breed ON Pups.Bree' +
      'd = Breed.Breed_Code'#13#10'WHERE '#13#10#9'((Pups.Date_Sold) Is Null)'#13#10#9'AND'#13 +
      #10#9'((Pups.Died_Date) Is Null)'#13#10#9'AND'#13#10#9'(Pups.Returned_To_Supplier ' +
      '<> '#39'Y'#39');'#13#10
    Parameters = <>
    Left = 40
    Top = 56
    object quPuppyBreed_Code: TWideStringField
      FieldName = 'Breed_Code'
      Size = 3
    end
    object quPuppyBreed_Name: TWideStringField
      FieldName = 'Breed_Name'
      Size = 25
    end
    object quPuppyReference_No: TIntegerField
      FieldName = 'Reference_No'
    end
    object quPuppyWeight: TFloatField
      FieldName = 'Weight'
    end
    object quPuppyColor: TWideStringField
      FieldName = 'Color'
      Size = 50
    end
    object quPuppyPur_Price: TBCDField
      FieldName = 'Pur_Price'
      Precision = 19
    end
    object quPuppyRegular_Price: TBCDField
      FieldName = 'Regular_Price'
      Precision = 19
    end
    object quPuppySales_Price: TBCDField
      FieldName = 'Sales_Price'
      Precision = 19
    end
    object quPuppySex: TWideStringField
      FieldName = 'Sex'
      Size = 1
    end
    object quPuppyChip_No: TWideStringField
      FieldName = 'Chip_No'
      Size = 50
    end
    object quPuppySale_Price: TBCDField
      FieldName = 'Sale_Price'
      Precision = 19
    end
  end
  object MRDBInventoryConnection: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=sa;Initial Catalog=JustPetsDB;Data Source=(loca' +
      'l)'
    ConnectionTimeout = 20
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 276
    Top = 8
  end
  object quCmdFree: TADOCommand
    CommandTimeout = 360
    Connection = MRDBInventoryConnection
    Parameters = <>
    ParamCheck = False
    Left = 256
    Top = 56
  end
  object spGetNextID: TADOStoredProc
    Connection = MRDBInventoryConnection
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
    Left = 256
    Top = 152
  end
  object quModel: TADODataSet
    Connection = MRDBInventoryConnection
    CommandText = 'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model'#13#10'FROM'#13#10#9'Model M (NOLOCK) '
    Parameters = <>
    Left = 256
    Top = 104
    object quModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object quInvoice: TADODataSet
    Connection = MRDBSalesConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10'        P.PessoaFirstName,'#13#10'        P.PessoaLastName,'#13#10' ' +
      '       P.Endereco,'#13#10'        P.Cidade,'#13#10'        E.IDEstado,'#13#10'    ' +
      '    P.CEP,'#13#10'        ISNULL(P.PhoneAreaCode+'#39' '#39', '#39#39')+P.Telefone a' +
      's Telefone,'#13#10'        P.Fax,'#13#10'        P.OBS,'#13#10'        P.Email,'#13#10' ' +
      '       P.Pais'#13#10'                '#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'JOI' +
      'N Pessoa P (NOLOCK) ON (I.IDCustomer = P.IDPessoa)'#13#10'            ' +
      '    LEFT OUTER JOIN Estado E (NOLOCK) ON (E.IDEstado = P.IDEstad' +
      'o)'#13#10'WHERE'#13#10#9'I.IDInvoice = :IDInvoice'
    Parameters = <
      item
        Name = 'IDInvoice'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 436
    Top = 64
    object quInvoicePessoaFirstName: TStringField
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quInvoicePessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quInvoiceEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object quInvoiceCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object quInvoiceIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quInvoiceCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quInvoiceFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quInvoiceOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
    object quInvoiceEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quInvoicePais: TStringField
      FieldName = 'Pais'
      Size = 21
    end
    object quInvoiceTelefone: TStringField
      FieldName = 'Telefone'
      ReadOnly = True
      Size = 46
    end
  end
  object quIDCustomers: TADODataSet
    Connection = ADOPetConnection
    CommandText = 
      'SELECT '#13#10'          Customers.Customer_Id, '#13#10'          Customers.' +
      'Name, '#13#10'          Customers.FirstName'#13#10'FROM'#13#10'          Customers' +
      #13#10'WHERE '#13#10'          Customers.Customer_Id = :Customer;'
    Parameters = <
      item
        Name = 'Customer'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 40
    Top = 104
    object quIDCustomersCustomer_Id: TWideStringField
      FieldName = 'Customer_Id'
      Size = 10
    end
    object quIDCustomersName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object quIDCustomersFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 100
    end
  end
  object quCmdFreePet: TADOCommand
    Connection = ADOPetConnection
    Parameters = <>
    Left = 40
    Top = 152
  end
  object quInvoiceItem: TADODataSet
    Connection = MRDBSalesConnection
    CommandText = 
      'SELECT'#13#10#13#10#9'((IMV.QTY * IMV.SalePrice) - IMV.Discount) as SalePri' +
      'ce,'#13#10#9'IMV.CostPrice,'#13#10#9'M.Model,'#13#10#9'I.InvoiceDate,'#13#10#9'IMV.Qty,'#13#10' '#9'I' +
      'MV.ModelID '#13#10#13#10'FROM'#13#10#9'Invoice I (NOLOCK) '#13#10#9'JOIN InventoryMov IM' +
      'V (NOLOCK) ON (I.IDInvoice = IMV.DocumentID and IMV.InventMovTyp' +
      'eID = 1)'#13#10#9'JOIN Model M (NOLOCK) ON (IMV.ModelID = M.IDModel)'#13#10#9 +
      'JOIN TabGroup TB (NOLOCK) ON (M.GroupID = TB.IDGroup)'#13#10'        '#13 +
      #10'WHERE'#9#13#10#9'I.IDInvoice = :IDInvoice'#13#10#9'AND '#13#10#9'TB.PuppyTracker = 1'
    Parameters = <
      item
        Name = 'IDInvoice'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 436
    Top = 112
    object quInvoiceItemSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      Precision = 19
    end
    object quInvoiceItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quInvoiceItemInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object quInvoiceItemCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quInvoiceItemQty: TFloatField
      FieldName = 'Qty'
    end
    object quInvoiceItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
  end
  object ADOPuppyHistory: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\work\NewRetail -' +
      ' Util\PuppyTracker\PuppyHistory.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 152
    Top = 8
  end
  object quCmdFreeHistory: TADOCommand
    Connection = ADOPuppyHistory
    Parameters = <>
    Left = 152
    Top = 56
  end
  object quMaxPuppyExport: TADODataSet
    Connection = ADOPuppyHistory
    CommandText = 'SELECT'#13#10#9'MAX(IdPuppyExport) '#13#10'FROM'#13#10#9'PuppyExport;'
    Parameters = <>
    Left = 152
    Top = 104
    object quMaxPuppyExportExpr1000: TIntegerField
      FieldName = 'Expr1000'
    end
  end
  object quListPuppyExport: TADODataSet
    Connection = ADOPuppyHistory
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDPuppyExport,'#13#10#9'DateExport'#13#10'FROM'#13#10#9'PuppyExport;'#13#10#13#10#13#10' ' +
      '                '
    Parameters = <>
    Left = 152
    Top = 200
    object quListPuppyExportIDPuppyExport: TAutoIncField
      FieldName = 'IDPuppyExport'
      ReadOnly = True
    end
    object quListPuppyExportDateExport: TDateTimeField
      FieldName = 'DateExport'
    end
  end
  object quListPuppyModel: TADODataSet
    Connection = ADOPuppyHistory
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'IDPuppyModel,'#13#10'        IDPuppyExport,'#13#10#9'PuppyModel,'#13#10#9 +
      'PuppyDescription,'#13#10#9'CostPrice,'#13#10#9'SalePrice,'#13#10#9'Status'#13#10'FROM'#13#10#9'Pup' +
      'pyModel'#13#10'WHERE'#13#10#9'IdPuppyExport = :IdPuppyExport;'#13#10
    DataSource = DsquListPuppyExport
    MasterFields = 'IdPuppyExport'
    Parameters = <
      item
        Name = 'IdPuppyExport'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 152
    Top = 248
    object quListPuppyModelIDPuppyModel: TAutoIncField
      FieldName = 'IDPuppyModel'
      ReadOnly = True
    end
    object quListPuppyModelIDPuppyExport: TIntegerField
      FieldName = 'IDPuppyExport'
    end
    object quListPuppyModelPuppyModel: TWideStringField
      FieldName = 'PuppyModel'
      Size = 50
    end
    object quListPuppyModelPuppyDescription: TWideStringField
      FieldName = 'PuppyDescription'
      Size = 50
    end
    object quListPuppyModelCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quListPuppyModelSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quListPuppyModelStatus: TIntegerField
      FieldName = 'Status'
    end
  end
  object DsquListPuppyExport: TDataSource
    DataSet = quListPuppyExport
    Left = 152
    Top = 296
  end
  object DsquListPuppyModel: TDataSource
    DataSet = quListPuppyModel
    Left = 152
    Top = 344
  end
  object cmdInsertQty: TADOCommand
    CommandText = 
      'INSERT '#13#10#9'InventoryMov ('#13#10#9#9'IDInventoryMov,'#13#10#9#9'InventMovTypeID,'#13 +
      #10#9#9'DocumentID,'#13#10#9#9'StoreID,'#13#10#9#9'ModelID,'#13#10#9#9'MovDate,'#13#10#9#9'Qty,'#13#10#9#9'ID' +
      'User'#13#10#9#9')'#13#10#9#9'VALUES'#13#10#9#9'('#13#10#9#9':IDInventoryMov,'#13#10#9#9'5,'#13#10#9#9'0,'#13#10#9#9':IDS' +
      'tore,'#13#10#9#9':IDModel,'#13#10#9#9'GetDate(),'#13#10#9#9'1,'#13#10#9#9'0'#13#10#9#9')'
    Connection = MRDBInventoryConnection
    Parameters = <
      item
        Name = 'IDInventoryMov'
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
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 256
    Top = 200
  end
  object quLookUpStore: TLookUpADOQuery
    Connection = MRDBInventoryConnection
    CommandText = 'SELECT'#13#10#9'IDStore,'#13#10#9'Name'#13#10'FROM'#13#10#9'Store (NOLOCK) '
    Parameters = <>
    KeyFields = 'IDStore'
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDStore'
    LookUpField = 'IDStore'
    Left = 340
    Top = 56
    object quLookUpStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quLookUpStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpStore: TDataSource
    DataSet = quLookUpStore
    Left = 340
    Top = 104
  end
  object quLookUpCategory: TLookUpADOQuery
    Connection = MRDBInventoryConnection
    CommandText = 'SELECT'#13#10#9'IDGroup,'#13#10#9'Name'#13#10'FROM'#13#10#9'TabGroup (NOLOCK) '
    Parameters = <>
    KeyFields = 'IDGroup'
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDGroup'
    LookUpField = 'IDGroup'
    Left = 340
    Top = 152
    object quLookUpCategoryIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quLookUpCategoryName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpCategory: TDataSource
    DataSet = quLookUpCategory
    Left = 340
    Top = 200
  end
  object quFindCategory: TADODataSet
    Connection = MRDBInventoryConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDGroup,'#13#10#9'Name'#13#10'FROM'#13#10#9'TabGroup (NOLOCK) '#13#10'WHERE'#13#10#9'IDG' +
      'roup = :IDGroup'
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 340
    Top = 248
    object quFindCategoryIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quFindCategoryName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object quCustomers: TADODataSet
    Connection = ADOPetConnection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'Customers.Customer_Id, '#13#10'        Customers.Name, '#13#10'    ' +
      '    Customers.FirstName,'#13#10#9'Customers.Zip'#13#10#9#13#10'FROM'#13#10#9'Customers'#13#10'W' +
      'HERE'#13#10#9'Customers.Name = :Name'#13#10#9'AND Customers.FirstName = :First' +
      'Name'#13#10#9'AND Customers.ZIP = :Zip                '#13#10#13#10
    Parameters = <
      item
        Name = 'Name'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'FirstName'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Zip'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 40
    Top = 200
    object quCustomersCustomer_Id: TWideStringField
      FieldName = 'Customer_Id'
      Size = 10
    end
    object quCustomersName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object quCustomersFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 100
    end
    object quCustomersZip: TWideStringField
      FieldName = 'Zip'
      Size = 10
    end
  end
  object quDelHistoryDate: TADODataSet
    Connection = ADOPuppyHistory
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDPuppyExport,'#13#10#9'DateExport'#13#10'FROM'#13#10#9'PuppyExport'#13#10'WHERE'#13 +
      #10#9'DateExport <= Date() - :Data'#13#10
    Parameters = <
      item
        Name = 'Data'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    Left = 152
    Top = 152
  end
  object MRDBSalesConnection: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=JustPetsDB;Data Source=(local)'
    ConnectionTimeout = 20
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 436
    Top = 9
  end
end
