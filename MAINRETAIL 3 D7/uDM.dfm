inherited DM: TDM
  OldCreateOrder = True
  Left = 2
  Top = 2
  Height = 514
  Width = 669
  inherited spGetNextID: TADOStoredProc
    Left = 104
    Top = 19
  end
  inherited ADODBConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=MR_DB_User;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=MainRetailDB;Data Source=(LOCAL)\P' +
      'inogy;Use Procedure for Prepare=1;Auto Translate=True;Packet Siz' +
      'e=4096;Workstation ID=IGM001;Use Encryption for Data=False;Tag w' +
      'ith column collation when possible=False'
    Left = 24
    Top = 16
  end
  inherited quFreeSQL: TADOQuery
    Left = 193
    Top = 19
  end
  object quLookUpGroup: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDGroup , Name, PathName, UserCode'#13#10'FROM dbo.TabGroup Tab' +
      'Group'#13#10' ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'PathName'
    CodeFieldSearch = False
    LookUpField = 'IDGroup'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookUpGroupClickButton
    Left = 30
    Top = 75
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
    Left = 96
    Top = 90
  end
  object quLookUpStore: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDStore,'#13#10'        Name'#13#10'FROM'#13#10'        Store'#13#10'WHE' +
      'RE'#13#10'        IDStore <> 0'#13#10'ORDER BY'#13#10'        Name'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDStore'
    LookUpField = 'IDStore'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookUpStoreClickButton
    OnBeforeOpenGrid = quLookUpStoreBeforeOpenGrid
    Left = 26
    Top = 122
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
    Left = 96
    Top = 135
  end
  object LookUpComissionado: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDComissionado , Comissionado, Code'#13#10'FROM dbo.vwComission' +
      'ado'#13#10'ORDER BY'#13#10' Comissionado'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Comissionado'
    CodeField = 'Code'
    LookUpField = 'IDComissionado'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpComissionadoClickButton
    Left = 26
    Top = 165
    object LookUpComissionadoIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpComissionadoComissionado: TStringField
      FieldName = 'Comissionado'
      Size = 50
    end
    object LookUpComissionadoCode: TIntegerField
      FieldName = 'Code'
    end
  end
  object dsLookUpComissionado: TDataSource
    DataSet = LookUpComissionado
    Left = 96
    Top = 180
  end
  object LookUpUserType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDUserType , Name'#13#10'FROM dbo.UserType UserType'#13#10'ORDER BY'#13#10 +
      ' Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDUserType'
    LookUpField = 'IDUserType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpUserTypeClickButton
    Left = 29
    Top = 210
    object LookUpUserTypeIDUserType: TIntegerField
      FieldName = 'IDUserType'
    end
    object LookUpUserTypeName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpUserType: TDataSource
    DataSet = LookUpUserType
    Left = 96
    Top = 225
  end
  object LookUpCashReg: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDCashRegister , Name'#13#10'FROM dbo.CashRegister ORDER BY Nam' +
      'e'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDCashRegister'
    LookUpField = 'IDCashRegister'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpCashRegClickButton
    Left = 26
    Top = 255
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
    Left = 96
    Top = 270
  end
  object LookUpUser: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDUser , SystemUser, ComissionID'#13#10'FROM dbo.SystemUser ORD' +
      'ER BY SystemUser'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'SystemUser'
    CodeField = 'IDUser'
    LookUpField = 'IDUser'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpUserClickButton
    Left = 26
    Top = 300
    object LookUpUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object LookUpUserSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
  end
  object dsLookUpUser: TDataSource
    DataSet = LookUpUser
    Left = 96
    Top = 315
  end
  object LookUpTipoComissionado: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDTipoComissionado,'#13#10'        PathName'#13#10'FROM'#13#10'   ' +
      '     vwTipoComissionado'#13#10'ORDER BY'#13#10'        PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoComissionado'
    LookUpField = 'IDTipoComissionado'
    quFreeSQL = quFreeSQL
    Left = 378
    Top = 401
    object LookUpTipoComissionadoIDTipoComissionado: TIntegerField
      FieldName = 'IDTipoComissionado'
    end
    object LookUpTipoComissionadoPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  object dsLookUpTipoComissionado: TDataSource
    DataSet = LookUpTipoComissionado
    Left = 460
    Top = 416
  end
  object quLookUpIMT: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDInventMovType , Name'#13#10'FROM dbo.InventoryMovType Invento' +
      'ryMovType'#13#10'ORDER BY'#13#10' Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDInventMovType'
    LookUpField = 'IDInventMovType'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookUpIMTClickButton
    Left = 25
    Top = 410
    object quLookUpIMTIDInventMovType: TIntegerField
      FieldName = 'IDInventMovType'
    end
    object quLookUpIMTName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpIMT: TDataSource
    DataSet = quLookUpIMT
    Left = 97
    Top = 421
  end
  object LookUpModel: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description,'#13#10 +
      '        IsNull(CaseQty,0) as CaseQty'#13#10'FROM'#13#10'        Model'#13#10'WHERE' +
      #13#10#9'ModelType IN ('#39'R'#39','#39'S'#39')'#13#10'ORDER BY'#13#10'        Model'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelClickButton
    Left = 190
    Top = 312
    object LookUpModelModel: TStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Size = 30
    end
    object LookUpModelIDModel: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDModel'
      Visible = False
    end
    object LookUpModelDescription: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
    object LookUpModelCaseQty: TBCDField
      FieldName = 'CaseQty'
      ReadOnly = True
      Precision = 32
    end
  end
  object dsLookUpModel: TDataSource
    DataSet = LookUpModel
    Left = 273
    Top = 319
  end
  object LookUpDeliverType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDDeliverType , Name, MaxDeliverDelay, CanExchangeItem'#13#10'F' +
      'ROM dbo.DeliverType ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDDeliverType'
    LookUpField = 'IDDeliverType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpDeliverTypeClickButton
    Left = 190
    Top = 169
    object LookUpDeliverTypeIDDeliverType: TIntegerField
      FieldName = 'IDDeliverType'
    end
    object LookUpDeliverTypeName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object LookUpDeliverTypeMaxDeliverDelay: TIntegerField
      FieldName = 'MaxDeliverDelay'
    end
    object LookUpDeliverTypeCanExchangeItem: TBooleanField
      FieldName = 'CanExchangeItem'
    end
  end
  object dsLookUpDeliverType: TDataSource
    DataSet = LookUpDeliverType
    Left = 273
    Top = 184
  end
  object LookUpSpcPrice: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDSpecialPrice , SpecialPrice'#13#10'FROM dbo.SpecialPrice ORDE' +
      'R BY SpecialPric'#39'e'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'SpecialPrice'
    CodeField = 'IDSpecialPrice'
    LookUpField = 'IDSpecialPrice'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpSpcPriceClickButton
    Left = 190
    Top = 218
    object LookUpSpcPriceIDSpecialPrice: TIntegerField
      FieldName = 'IDSpecialPrice'
    end
    object LookUpSpcPriceSpecialPrice: TStringField
      FieldName = 'SpecialPrice'
      Size = 30
    end
  end
  object dsLookUpSpcPrice: TDataSource
    DataSet = LookUpSpcPrice
    Left = 273
    Top = 229
  end
  object LookUpFornecedor: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 5000
    CommandText = 
      'SELECT'#13#10#9'IDFornecedor,'#13#10#9'IDFornecedor as IDPessoa,'#13#10#9'Fornecedor,' +
      #13#10#9'Code'#13#10'FROM '#9#13#10#9'vwFornecedor'#13#10'ORDER BY'#13#10#9'Fornecedor'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Fornecedor'
    CodeField = 'Code'
    LookUpField = 'IDFornecedor'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpFornecedorClickButton
    Left = 190
    Top = 75
    object LookUpFornecedorIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpFornecedorIDFornecedor: TIntegerField
      FieldName = 'IDFornecedor'
    end
    object LookUpFornecedorFornecedor: TStringField
      FieldName = 'Fornecedor'
      Size = 50
    end
    object LookUpFornecedorCode: TIntegerField
      FieldName = 'Code'
    end
  end
  object dsLookUpFornecedor: TDataSource
    DataSet = LookUpFornecedor
    Left = 273
    Top = 86
  end
  object dsLookUpPreSale: TDataSource
    Left = 759
    Top = 370
  end
  object dsLookUpEstado: TDataSource
    DataSet = LookUpEstado
    Left = 97
    Top = 479
  end
  object LookUpEstado: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT IDEstado , Estado'#13#10'FROM dbo.Estado Estado '#13#10'ORDER BY Esta' +
      'do'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Estado'
    CodeField = 'IDEstado'
    LookUpField = 'IDEstado'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpEstadoClickButton
    Left = 26
    Top = 469
    object LookUpEstadoIDEstado: TStringField
      FieldName = 'IDEstado'
      Size = 3
    end
    object LookUpEstadoEstado: TStringField
      FieldName = 'Estado'
      Size = 50
    end
  end
  object LookUpAgency: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'Pessoa.IDPessoa,'#13#10'        Pessoa.IDPessoa IDComissionad' +
      'o,'#13#10'        Pessoa.Pessoa,'#13#10'        Pessoa.Code'#13#10'FROM '#9#13#10#9'Pessoa' +
      ' Pessoa (NOLOCK)'#13#10'WHERE '#9#13#10#9'Pessoa.IDTipoPessoaRoot = 6'#13#10#13#10'ORDER' +
      ' BY Pessoa.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpAgencyClickButton
    Left = 190
    Top = 357
    object LookUpAgencyIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpAgencyPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object LookUpAgencyCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpAgencyIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
  end
  object dsLookUpAgency: TDataSource
    DataSet = LookUpAgency
    Left = 273
    Top = 365
  end
  object LookUpGuide: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        P.IDPessoa,'#13#10'        P.IDPessoa IDComissionado,'#13 +
      #10'        P.Pessoa,'#13#10'        P.Code'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10 +
      'WHERE '#9#13#10#9'P.IDTipoPessoaRoot = 5'#13#10#13#10'ORDER BY P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpGuideClickButton
    Left = 190
    Top = 402
    object LookUpGuideIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpGuideIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpGuideCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpGuidePessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object dsLookUpGuide: TDataSource
    DataSet = LookUpGuide
    Left = 273
    Top = 415
  end
  object LookUpCustomer: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'C.IDCliente,'#13#10#9'C.IDCliente IDComissionado,'#13#10#9'C.Cliente,' +
      #13#10#9'C.Code,'#13#10#9'C.IDCliente as IDPessoa'#13#10'FROM '#9#13#10#9'vwCliente C'#13#10'ORDE' +
      'R BY'#13#10#9'C.Cliente'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Cliente'
    CodeField = 'Code'
    LookUpField = 'IDCliente'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpCustomerClickButton
    Left = 190
    Top = 447
    object LookUpCustomerIDCliente: TIntegerField
      FieldName = 'IDCliente'
    end
    object LookUpCustomerIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpCustomerCliente: TStringField
      FieldName = 'Cliente'
      Size = 50
    end
    object LookUpCustomerCode: TIntegerField
      FieldName = 'Code'
    end
  end
  object dsLookUpCustomer: TDataSource
    DataSet = LookUpCustomer
    Left = 273
    Top = 460
  end
  object LookUpTipoFornecedor: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoFornecedor , PathName'#13#10'FROM dbo.vwTipoFornecedor'#13#10'O' +
      'RDER BY  PathName '#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoFornecedor'
    LookUpField = 'IDTipoFornecedor'
    quFreeSQL = quFreeSQL
    Left = 190
    Top = 497
    object LookUpTipoFornecedorIDTipoFornecedor: TIntegerField
      FieldName = 'IDTipoFornecedor'
    end
    object LookUpTipoFornecedorPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  object dsLookUpTipoFornecedor: TDataSource
    DataSet = LookUpTipoFornecedor
    Left = 273
    Top = 509
  end
  object LookUpTipoCliente: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoCliente , PathName '#13#10'FROM dbo.vwTipoCliente'#13#10'ORDER ' +
      'BY'#13#10' PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoCliente'
    LookUpField = 'IDTipoCliente'
    quFreeSQL = quFreeSQL
    Left = 190
    Top = 546
    object LookUpTipoClienteIDTipoCliente: TIntegerField
      FieldName = 'IDTipoCliente'
    end
    object LookUpTipoClientePathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  object dsLookUpTipoCliente: TDataSource
    DataSet = LookUpTipoCliente
    Left = 273
    Top = 558
  end
  object LookUpTipoPessoa: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoPessoa , PathName, Path'#13#10'FROM dbo.TipoPessoa'#13#10'ORDER' +
      ' BY'#13#10' PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'Path'
    LookUpField = 'IDTipoPessoa'
    quFreeSQL = quFreeSQL
    Left = 378
    Top = 71
    object LookUpTipoPessoaIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object LookUpTipoPessoaPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object LookUpTipoPessoaPath: TStringField
      FieldName = 'Path'
      Size = 150
    end
  end
  object dsLookUpTipoPessoa: TDataSource
    DataSet = LookUpTipoPessoa
    Left = 456
    Top = 96
  end
  object LookUpPessoa: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.Pessoa,'#13#10#9'P.Code'#13#10'FROM'#13#10#9'Pessoa P (NOLO' +
      'CK)'#13#10'ORDER BY'#13#10#9'P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    quFreeSQL = quFreeSQL
    Left = 377
    Top = 120
    object LookUpPessoaIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpPessoaPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object LookUpPessoaCode: TIntegerField
      FieldName = 'Code'
    end
  end
  object dsLookUpPessoa: TDataSource
    DataSet = LookUpPessoa
    Left = 456
    Top = 141
  end
  object LookUpContaCorrente: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDContaCorrente,'#13#10'        Numero'#13#10'FROM'#13#10'        ' +
      'Fin_ContaCorrente'#13#10'ORDER BY'#13#10'        Numero'#13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Numero'
    CodeField = 'IDContaCorrente'
    LookUpField = 'IDContaCorrente'
    quFreeSQL = quFreeSQL
    Left = 377
    Top = 165
    object LookUpContaCorrenteIDContaCorrente: TAutoIncField
      FieldName = 'IDContaCorrente'
      ReadOnly = True
    end
    object LookUpContaCorrenteNumero: TStringField
      FieldName = 'Numero'
      Size = 35
    end
  end
  object dsLookUpContaCorrente: TDataSource
    DataSet = LookUpContaCorrente
    Left = 456
    Top = 186
  end
  object LookUpTipoConta: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoConta , PathName, Path'#13#10'FROM dbo.TipoConta'#13#10'ORDER B' +
      'Y'#13#10' PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoConta'
    LookUpField = 'IDTipoConta'
    quFreeSQL = quFreeSQL
    Left = 377
    Top = 210
    object LookUpTipoContaIDTipoConta: TIntegerField
      FieldName = 'IDTipoConta'
    end
    object LookUpTipoContaPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object LookUpTipoContaPath: TStringField
      FieldName = 'Path'
      Size = 150
    end
  end
  object dsLookUpTipoConta: TDataSource
    DataSet = LookUpTipoConta
    Left = 456
    Top = 231
  end
  object LookUpLancamentoTipo: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDLancamentoTipo , LancamentoTipo, CodigoContabil, Pagand' +
      'o'#13#10'FROM Fin_LancamentoTipo'#13#10'ORDER BY'#13#10' LancamentoTipo'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'LancamentoTipo'
    CodeField = 'CodigoContabil'
    LookUpField = 'IDLancamentoTipo'
    quFreeSQL = quFreeSQL
    Left = 377
    Top = 255
    object LookUpLancamentoTipoIDLancamentoTipo: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDLancamentoTipo'
      Origin = 'RETAILCOMBO.Fin_LancamentoTipo.IDLancamentoTipo'
    end
    object LookUpLancamentoTipoLancamentoTipo: TStringField
      DisplayWidth = 65
      FieldName = 'LancamentoTipo'
      Origin = 'RETAILCOMBO.Fin_LancamentoTipo.LancamentoTipo'
      Size = 65
    end
    object LookUpLancamentoTipoCodigoContabil: TStringField
      DisplayWidth = 35
      FieldName = 'CodigoContabil'
      Origin = 'RETAILCOMBO.Fin_LancamentoTipo.CodigoContabil'
      Size = 35
    end
    object LookUpLancamentoTipoPagando: TBooleanField
      FieldName = 'Pagando'
    end
  end
  object dsLookUpLancamentoTipo: TDataSource
    DataSet = LookUpLancamentoTipo
    Left = 456
    Top = 276
  end
  object LookUpDocumentoTipo: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDDocumentoTipo,'#13#10#9'DocumentoTipo'#13#10'FROM'#13#10#9'Fin_DocumentoT' +
      'ipo'#13#10'ORDER BY'#13#10#9'DocumentoTipo'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'DocumentoTipo'
    CodeField = 'IDDocumentoTipo'
    LookUpField = 'IDDocumentoTipo'
    quFreeSQL = quFreeSQL
    Left = 377
    Top = 300
    object LookUpDocumentoTipoIDDocumentoTipo: TIntegerField
      FieldName = 'IDDocumentoTipo'
    end
    object LookUpDocumentoTipoDocumentoTipo: TStringField
      FieldName = 'DocumentoTipo'
      Size = 35
    end
  end
  object dsLookUpDocumentoTipo: TDataSource
    DataSet = LookUpDocumentoTipo
    Left = 456
    Top = 321
  end
  object dsLookUpDocumento: TDataSource
    DataSet = LookUpDocumento
    Left = 456
    Top = 366
  end
  object LookUpDocumento: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 'SELECT Documento '#13#10'FROM dbo.Lancamento'#13#10'ORDER BY'#13#10' Documento'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Documento'
    CodeField = 'IDLancamento'
    LookUpField = 'Documento'
    quFreeSQL = quFreeSQL
    Left = 377
    Top = 345
    object LookUpDocumentoDocumento: TStringField
      FieldName = 'Documento'
      Size = 50
    end
  end
  object LookUpTipoFabricante: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoFabricante , PathName'#13#10'FROM dbo.vwTipoFabricante'#13#10'O' +
      'RDER BY'#13#10' PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoFabricante'
    LookUpField = 'IDTipoFabricante'
    quFreeSQL = quFreeSQL
    Left = 378
    Top = 453
    object LookUpTipoFabricanteIDTipoFabricante: TIntegerField
      FieldName = 'IDTipoFabricante'
    end
    object StringField1: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  object dsLookUpTipoFabricante: TDataSource
    DataSet = LookUpTipoFabricante
    Left = 391
    Top = 473
  end
  object LookUpFabricante: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDFabricante,'#13#10#9'IDPessoa,'#13#10#9'Pessoa,'#13#10#9'Code,'#13#10#9'UserCode'#13 +
      #10'FROM '#9#13#10#9'vwFabricante'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpFabricanteClickButton
    Left = 374
    Top = 501
    object LookUpFabricanteIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpFabricanteUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object LookUpFabricanteCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpFabricanteIDFabricante: TIntegerField
      FieldName = 'IDFabricante'
    end
    object LookUpFabricantePessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object dsLookUpFabricante: TDataSource
    DataSet = LookUpFabricante
    Left = 457
    Top = 521
  end
  object LookUpCotacao: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDCotacao , Cotacao'#13#10'FROM dbo.Cotacao Cotacao'#13#10'ORDER BY C' +
      'otacao'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Cotacao'
    CodeField = 'IDCotacao'
    LookUpField = 'IDCotacao'
    quFreeSQL = quFreeSQL
    Left = 374
    Top = 553
    object LookUpCotacaoIDCotacao: TIntegerField
      FieldName = 'IDCotacao'
    end
    object LookUpCotacaoCotacao: TStringField
      FieldName = 'Cotacao'
      Size = 50
    end
  end
  object dsLookUpCotacao: TDataSource
    DataSet = LookUpCotacao
    Left = 457
    Top = 569
  end
  object LookUpCentroCusto: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDCentroCusto , PathName'#13#10'FROM dbo.CentroCusto ORDER BY P' +
      'athName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDCentroCusto'
    LookUpField = 'IDCentroCusto'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpCentroCustoClickButton
    Left = 532
    Top = 76
    object StringField2: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object LookUpCentroCustoIDCentroCusto: TIntegerField
      FieldName = 'IDCentroCusto'
    end
  end
  object dsLookUpCentroCusto: TDataSource
    DataSet = LookUpCentroCusto
    Left = 602
    Top = 91
  end
  object LookUpMeioPag: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDMeioPag,'#13#10#9'MeioPag,'#13#10#9'Tipo,'#13#10#9'RequireCustomer,'#13#10#9'Prin' +
      'tBankBillet,'#13#10#9'ValidateNonpayer'#13#10'FROM'#13#10#9'MeioPag'#13#10'WHERE'#13#10#9'ParentT' +
      'ype <> '#39'Batch'#39#13#10'ORDER BY'#13#10#9'MeioPag'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'MeioPag'
    CodeField = 'IDMeioPag'
    LookUpField = 'IDMeioPag'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpMeioPagClickButton
    Left = 186
    Top = 267
    object LookUpMeioPagIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object LookUpMeioPagMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object LookUpMeioPagTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object LookUpMeioPagRequireCustomer: TBooleanField
      FieldName = 'RequireCustomer'
    end
    object LookUpMeioPagPrintBankBillet: TBooleanField
      FieldName = 'PrintBankBillet'
    end
    object LookUpMeioPagValidateNonpayer: TBooleanField
      FieldName = 'ValidateNonpayer'
    end
  end
  object dsLookUpMeioPag: TDataSource
    DataSet = LookUpMeioPag
    Left = 273
    Top = 274
  end
  object LookUpRamoAtividade: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDRamoAtividade , RamoAtividade'#13#10'FROM dbo.RamoAtividade'#13#10 +
      'ORDER BY'#13#10' RamoAtividade'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'RamoAtividade'
    CodeField = 'IDRamoAtividade'
    LookUpField = 'IDRamoAtividade'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpRamoAtividadeClickButton
    Left = 190
    Top = 599
    object LookUpRamoAtividadeIDRamoAtividade: TIntegerField
      FieldName = 'IDRamoAtividade'
    end
    object LookUpRamoAtividadeRamoAtividade: TStringField
      FieldName = 'RamoAtividade'
      Size = 50
    end
  end
  object dsLookUpRamoAtividade: TDataSource
    DataSet = LookUpRamoAtividade
    Left = 277
    Top = 611
  end
  object LookUpCostType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDCostType , CostType'#13#10'FROM dbo.CostType  ORDER BY CostTy' +
      'pe'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'CostType'
    CodeField = 'IDCostType'
    LookUpField = 'IDCostType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpCostTypeClickButton
    Left = 528
    Top = 128
    object LookUpCostTypeIDCostType: TIntegerField
      FieldName = 'IDCostType'
    end
    object LookUpCostTypeCostType: TStringField
      FieldName = 'CostType'
      Size = 50
    end
  end
  object dsLookUpCostType: TDataSource
    DataSet = LookUpCostType
    Left = 602
    Top = 143
  end
  object LookUpUnidade: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDUnidade , Unidade, Sigla'#13#10'FROM dbo.Unidade ORDER BY Uni' +
      'dade'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Unidade'
    CodeField = 'Sigla'
    LookUpField = 'IDUnidade'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpUnidadeClickButton
    Left = 533
    Top = 174
    object LookUpUnidadeIDUnidade: TIntegerField
      FieldName = 'IDUnidade'
    end
    object LookUpUnidadeUnidade: TStringField
      FieldName = 'Unidade'
      Size = 100
    end
    object LookUpUnidadeSigla: TStringField
      FieldName = 'Sigla'
      Size = 4
    end
  end
  object dsLookUpUnidade: TDataSource
    DataSet = LookUpUnidade
    Left = 604
    Top = 191
  end
  object LookUpSalesPerson: TLookUpADOQuery
    Connection = ADODBConnect
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
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpSalesPersonClickButton
    Left = 26
    Top = 349
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
  object dsLookUpSalesPerson: TDataSource
    DataSet = LookUpSalesPerson
    Left = 96
    Top = 370
  end
  object LookUpNewModel: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDModel , Model,  Description'#13#10'FROM dbo.Model ORDER BY Mo' +
      'del'#13#10
    Parameters = <>
    SecondFieldType = ftString
    SecondSQL = 
      'SELECT Model.IDModel , Description, Model  FROM dbo.Model Model,' +
      ' dbo.BarCode BarCode WHERE Model.IDModel = BarCode.IDModel AND B' +
      'arCode.IDBarCode like %s'
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    SecondWildCard = '_'
    OnClickButton = LookUpNewModelClickButton
    Left = 662
    Top = 476
    object IntegerField1: TIntegerField
      FieldName = 'IDModel'
    end
    object StringField3: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object StringField4: TStringField
      FieldName = 'Model'
      Size = 30
    end
  end
  object dsLookUpNewModel: TDataSource
    DataSet = LookUpNewModel
    Left = 665
    Top = 531
  end
  object LookUpMedia: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 'SELECT IDMedia , Media '#13#10'FROM dbo.Media '#13#10'ORDER BY'#13#10' Media'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Media'
    CodeField = 'IDMedia'
    LookUpField = 'IDMedia'
    quFreeSQL = quFreeSQL
    Left = 535
    Top = 247
    object LookUpMediaIDMedia: TIntegerField
      FieldName = 'IDMedia'
    end
    object LookUpMediaMedia: TStringField
      FieldName = 'Media'
      Size = 255
    end
  end
  object dsLookUpMedia: TDataSource
    DataSet = LookUpMedia
    Left = 598
    Top = 260
  end
  object LookUpCashRegStatus: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDCashRegStatus , CashRegStatus'#13#10'FROM dbo.CashRegStatus'#13#10 +
      'ORDER BY'#13#10'CashRegStatus'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'CashRegStatus'
    CodeField = 'IDCashRegStatus'
    LookUpField = 'IDCashRegStatus'
    quFreeSQL = quFreeSQL
    Left = 539
    Top = 303
    object LookUpCashRegStatusIDCashRegStatus: TIntegerField
      FieldName = 'IDCashRegStatus'
    end
    object LookUpCashRegStatusCashRegStatus: TStringField
      FieldName = 'CashRegStatus'
      Size = 30
    end
  end
  object dsLookUpCashRegStatus: TDataSource
    DataSet = LookUpCashRegStatus
    Left = 548
    Top = 355
  end
  object LookUpOther: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10'        P.IDPessoa IDComissionado,'#13#10'      ' +
      '  P.Pessoa,'#13#10'        P.Code'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10'WHERE '#9 +
      #13#10#9'P.IDTipoPessoaRoot = 9'#13#10'ORDER BY P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpOtherClickButton
    Left = 374
    Top = 605
    object LookUpOtherIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpOtherIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpOtherCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpOtherPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object dsLookUpOther: TDataSource
    DataSet = LookUpOther
    Left = 450
    Top = 621
  end
  object LookUpHotel: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 'SELECT IDHotel , Hotel '#13#10'FROM dbo.Hotel'#13#10'ORDER BY'#13#10' Hotel'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Hotel'
    CodeField = 'IDHotel'
    LookUpField = 'IDHotel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpHotelClickButton
    Left = 31
    Top = 579
    object LookUpHotelIDHotel: TIntegerField
      FieldName = 'IDHotel'
    end
    object LookUpHotelHotel: TStringField
      FieldName = 'Hotel'
      Size = 50
    end
  end
  object dsLookUpHotel: TDataSource
    DataSet = LookUpHotel
    Left = 99
    Top = 587
  end
  object LookUpBarCode: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    OnCalcFields = LookUpBarCodeCalcFields
    CommandText = 
      'SELECT '#13#10'  IDBarCode , '#13#10'  Model.IDModel, '#13#10'  Model,  '#13#10'  Descri' +
      'ption'#13#10'FROM BarCode, Model '#13#10'WHERE BarCode.IDModel = Model.IDMod' +
      'el'#13#10'ORDER BY IDBarCode'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'IDBarCode'
    CodeField = 'Model'
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    Left = 30
    Top = 528
    object LookUpBarCodeDescBarCode: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescBarCode'
      Calculated = True
    end
    object LookUpBarCodeIDBarCode: TStringField
      FieldName = 'IDBarCode'
    end
    object LookUpBarCodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object LookUpBarCodeModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object LookUpBarCodeDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object dsLookUpBarCode: TDataSource
    DataSet = LookUpBarCode
    Left = 98
    Top = 534
  end
  object LookUpModelInv: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDModel , Model,  Description'#13#10'FROM dbo.Model, Inventory'#13 +
      #10'WHERE Model.IDModel = Inventory.ModelID'#13#10'AND Model.Desativado=0' +
      ' and Model.Hidden=0'#13#10'ORDER BY Model'#13#10
    Parameters = <>
    SecondFieldType = ftString
    SecondSQL = 
      'SELECT Model.IDModel , Description, Model  FROM dbo.Model Model,' +
      ' dbo.BarCode BarCode, Inventory WHERE Model.IDModel = BarCode.ID' +
      'Model  AND Model.IDModel = Inventory.ModelID AND BarCode.IDBarCo' +
      'de like %s AND Model.Desativado=0 and Model.Hidden=0'
    ListField = 'Model'
    CodeField = 'Description'
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    SecondWildCard = '_'
    OnClickButton = LookUpModelInvClickButton
    Left = 190
    Top = 121
    object IntegerField2: TIntegerField
      FieldName = 'IDModel'
    end
    object StringField5: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'Model'
      Size = 30
    end
  end
  object dsLookUpModelInv: TDataSource
    DataSet = LookUpModelInv
    Left = 273
    Top = 136
  end
  object LookUpPais: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDPais , CodPais , Pais'#13#10'FROM dbo.Pais Pais'#13#10'ORDER BY'#13#10' P' +
      'ais'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pais'
    CodeField = 'CodPais'
    LookUpField = 'IDPais'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpPaisClickButton
    Left = 537
    Top = 425
    object LookUpPaisIDPais: TIntegerField
      FieldName = 'IDPais'
      Origin = 'Pais.IDPais'
    end
    object LookUpPaisCodPais: TStringField
      FieldName = 'CodPais'
      Origin = 'Pais.CodPais'
      Size = 3
    end
    object LookUpPaisPais: TStringField
      FieldName = 'Pais'
      Origin = 'Pais.Pais'
      Size = 50
    end
  end
  object dsLookUpPais: TDataSource
    DataSet = LookUpPais
    Left = 590
    Top = 476
  end
  object dsLookUpEmpresa: TDataSource
    DataSet = quLookUPEmpresa
    Left = 691
    Top = 177
  end
  object quLookUPEmpresa: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'select E.IDEmpresa, E.Empresa'#13#10'from sis_Empresa E'#13#10'Order by E.Em' +
      'presa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Empresa'
    CodeField = 'IDEmpresa'
    LookUpField = 'IDEmpresa'
    quFreeSQL = quFreeSQL
    Left = 691
    Top = 124
    object quLookUPEmpresaIDEmpresa: TIntegerField
      FieldName = 'IDEmpresa'
      Origin = 'RETAILCOMBO.sis_Empresa.IDEmpresa'
    end
    object quLookUPEmpresaEmpresa: TStringField
      FieldName = 'Empresa'
      Origin = 'RETAILCOMBO.sis_Empresa.Empresa'
      Size = 35
    end
  end
  object LookUpGroupPath: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDGroup , Name, PathName, Path'#13#10'FROM dbo.TabGroup TabGrou' +
      'p ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'PathName'
    CodeFieldSearch = False
    LookUpField = 'Path'
    quFreeSQL = quFreeSQL
    Left = 20
    Top = 635
    object IntegerField3: TIntegerField
      FieldName = 'IDGroup'
    end
    object StringField7: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object StringField8: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object LookUpGroupPathPath: TStringField
      FieldName = 'Path'
      Size = 150
    end
  end
  object dsLookUpGroupPath: TDataSource
    DataSet = LookUpGroupPath
    Left = 91
    Top = 650
  end
  object LookUpColor: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDColor,'#13#10'        Color,'#13#10'        CodColor'#13#10'FROM' +
      #13#10'        InvColor'#13#10'ORDER BY'#13#10'        Color'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Color'
    CodeField = 'CodColor'
    LookUpField = 'IDColor'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpColorClickButton
    Left = 374
    Top = 655
    object LookUpColorIDColor: TIntegerField
      FieldName = 'IDColor'
      Origin = 'RETAILCOMBO.InvColor.IDColor'
    end
    object LookUpColorColor: TStringField
      FieldName = 'Color'
      Origin = 'RETAILCOMBO.InvColor.Color'
    end
    object LookUpColorCodColor: TStringField
      FieldName = 'CodColor'
      Origin = 'RETAILCOMBO.InvColor.CodColor'
      Size = 10
    end
  end
  object dsLookUpColor: TDataSource
    DataSet = LookUpColor
    Left = 450
    Top = 671
  end
  object LookUpSize: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDSize,'#13#10'        SizeName,'#13#10'        CodSize'#13#10'FRO' +
      'M'#13#10'        InvSize'#13#10'ORDER BY'#13#10'        SizeName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'SizeName'
    CodeField = 'CodSize'
    LookUpField = 'IDSize'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpSizeClickButton
    Left = 199
    Top = 650
    object LookUpSizeIDSize: TIntegerField
      FieldName = 'IDSize'
      Origin = 'RETAILCOMBO.InvSize.IDSize'
    end
    object LookUpSizeSizeName: TStringField
      FieldName = 'SizeName'
      Origin = 'RETAILCOMBO.InvSize.SizeName'
    end
    object LookUpSizeCodSize: TStringField
      FieldName = 'CodSize'
      Origin = 'RETAILCOMBO.InvSize.CodSize'
      Size = 10
    end
  end
  object dsLookUpSize: TDataSource
    DataSet = LookUpSize
    Left = 275
    Top = 666
  end
  object LookUpModelMaster: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description'#13#10'F' +
      'ROM'#13#10'        Model'#13#10'WHERE'#13#10#9'ModelType IN ('#39'R'#39','#39'M'#39')'#13#10'ORDER BY'#13#10'  ' +
      '      Model'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelMasterClickButton
    Left = 840
    Top = 582
    object StringField9: TStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Size = 30
    end
    object IntegerField4: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDModel'
      Visible = False
    end
    object StringField10: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
  end
  object dsLookUpModelMaster: TDataSource
    DataSet = LookUpModelMaster
    Left = 805
    Top = 491
  end
  object quLookUpTaxCategory: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        T.IDTaxCategory,'#13#10'        T.TaxCategory,'#13#10'      ' +
      '  IsNull(T.Tax,0) as Tax'#13#10'FROM'#13#10'        TaxCategory T'#13#10'WHERE'#13#10'  ' +
      '      T.IDTaxCategoryParent = 0'#13#10'Order by'#13#10'        T.TaxCategory' +
      #13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'TaxCategory'
    CodeField = 'Tax'
    LookUpField = 'IDTaxCategory'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookUpTaxCategoryClickButton
    Left = 686
    Top = 229
    object quLookUpTaxCategoryIDTaxCategory: TAutoIncField
      FieldName = 'IDTaxCategory'
      ReadOnly = True
    end
    object quLookUpTaxCategoryTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quLookUpTaxCategoryTax: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '0.00 %'
      Precision = 19
    end
  end
  object dsLookUpTaxCategory: TDataSource
    DataSet = quLookUpTaxCategory
    Left = 686
    Top = 287
  end
  object LookUpMeioPagBatch: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDMeioPag,'#13#10'        MeioPag'#13#10'FROM'#13#10'        MeioP' +
      'ag'#13#10'WHERE'#13#10'        ParentType = '#39'Batch'#39#13#10'ORDER BY'#13#10'        MeioP' +
      'ag'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'MeioPag'
    CodeField = 'IDMeioPag'
    LookUpField = 'IDMeioPag'
    quFreeSQL = quFreeSQL
    Left = 841
    Top = 471
    object IntegerField5: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object StringField11: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
  end
  object dsLookUpMeioPagBatch: TDataSource
    DataSet = LookUpMeioPagBatch
    Left = 843
    Top = 520
  end
  object LookUpStoreAll: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDStore,'#13#10'        Name'#13#10'FROM'#13#10'        Store '#13#10'OR' +
      'DER BY'#13#10'        Name'#13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDStore'
    LookUpField = 'IDStore'
    quFreeSQL = quFreeSQL
    Left = 655
    Top = 339
    object IntegerField6: TIntegerField
      FieldName = 'IDStore'
    end
    object StringField12: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpStoreAll: TDataSource
    DataSet = LookUpStoreAll
    Left = 660
    Top = 393
  end
  object quSrvParam: TADOQuery
    Connection = ADODBConnect
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT SrvParameter , SrvValue , SrvType , '
      ' Description , DefaultValue , IDParam'
      'FROM dbo.Param Param'
      'ORDER BY'
      ' IDParam')
    Left = 635
    Top = 15
    object quSrvParamSrvParameter: TStringField
      FieldName = 'SrvParameter'
      Size = 30
    end
    object quSrvParamSrvValue: TStringField
      FieldName = 'SrvValue'
      Size = 30
    end
    object quSrvParamSrvType: TStringField
      FieldName = 'SrvType'
      Size = 10
    end
    object quSrvParamDescription: TStringField
      FieldName = 'Description'
      Size = 200
    end
    object quSrvParamDefaultValue: TStringField
      FieldName = 'DefaultValue'
      Size = 30
    end
    object quSrvParamIDParam: TIntegerField
      FieldName = 'IDParam'
    end
  end
  object quRebuildIdent: TADOQuery
    Connection = ADODBConnect
    Parameters = <>
    SQL.Strings = (
      'EXEC sp_System_dbTables Null, Null, Null, "'#39'TABLE'#39'"')
    Left = 568
    Top = 21
    object quRebuildIdentTABLE_QUALIFIER: TStringField
      FieldName = 'TABLE_QUALIFIER'
      Size = 255
    end
    object quRebuildIdentTABLE_OWNER: TStringField
      FieldName = 'TABLE_OWNER'
      Size = 255
    end
    object quRebuildIdentTABLE_NAME: TStringField
      FieldName = 'TABLE_NAME'
      Size = 255
    end
    object quRebuildIdentTABLE_TYPE: TStringField
      FieldName = 'TABLE_TYPE'
      Size = 32
    end
    object quRebuildIdentREMARKS: TStringField
      FieldName = 'REMARKS'
      Size = 254
    end
  end
  object spGetIDUser: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_SystemUser_GetIDUser;1'
    Parameters = <>
    Left = 391
    Top = 11
  end
  object spCheckOpenCash: TADOStoredProc
    Connection = ADODBConnect
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
    Left = 486
    Top = 11
  end
  object imgSubMenu: TImageList
    BkColor = clFuchsia
    Height = 26
    Width = 26
    Left = 695
    Top = 14
    Bitmap = {
      494C010145004A0004001A001A00FF00FF00FF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000068000000EE0100000100200000000000C022
      0300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A5
      A50094A5A50094A5A50094A5A500BDC6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A5A50094A5A50094A5
      A5006BA5A5006BA5A5006BA5A50094A5A50094A5A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094A5A50094A5A50094A5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A50094A5A500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A50094A5A500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A500FF00
      FF0094A5A50094A5A50094A5A50094A5A500FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF0094A5A50094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A500A5B5
      B50094A5A5006BA5A5006BA5A50094A5A500FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A500BDCE
      CE006BA5A5006BA5A5006BA5A5006BA5A50094A5A500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A500FF00FF00ADB5
      B5006BA5A5006BA5A5006BA5A5006BA5A50094A5A500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A5006BA5A50094A5A50094A5A500FF00FF009CAD
      AD0094A5A5006BA5A5006BA5A5006BA5A50094A5A500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A50094A5A50094A5A500FF00FF00FF00FF00FF00
      FF0094A5A50094A5A5006BA5A5006BA5A50094A5A500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A5006BA5A5006BA5A50094A5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0094A5A50094A5A50094A5A50094A5A500FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0094A5A50094A5
      A50094A5A500FF00FF0094A5A50094A5A50094A5A50094A5A5006BA5A50094A5
      A50094A5A50094A5A500D6D6D600D6D6D6006BA5A5006BA5A5006BA5A50094A5
      A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0094A5A5006BA5
      A50094A5A50094A5A500FF00FF00FF00FF00FF00FF00E7EFEF00DEDEDE00F7F7
      F700FF00FF00FF00FF00FF00FF0094A5A5006BA5A5006BA5A5006BA5A50094A5
      A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00E7E7E7006BA5A5006BA5
      A5006BA5A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5
      A50094A5A500EFEFEF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF0094A5A5006BA5A5006BA5
      A5006BA5A5006BA5A500E7E7E700FF00FF00FF00FF00EFEFEF0094A5A50094A5
      A50094A5A500E7E7E700FF00FF0094A5A5006BA5A5006BA5A5006BA5A5006BA5
      A5006BA5A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF0094A5A5006BA5A5006BA5
      A5006BA5A5006BA5A50094A5A500FF00FF00FF00FF0094A5A5006BA5A5006BA5
      A5006BA5A50094A5A500FF00FF0094A5AD0094A5A5006BA5A5006BA5A5006BA5
      A5006BA5A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF006BA5A5006BA5
      A5006BA5A5006BA5A50094A5A500FF00FF0094A5A50094A5A5006BA5A5006BA5
      A5006BA5A5006BA5A50094A5A500FF00FF00FF00FF0094A5A50094A5A5006BA5
      A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF0094A5A5006BA5
      A5006BA5A5006BA5A500FF00FF00FF00FF00FF00FF0094A5A5006BA5A5006BA5
      A5006BA5A5006BA5A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF0094A5
      A500E7E7E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00EFEFEF0094A5
      A50094A5A50094A5A500FF00FF00FF00FF00FF00FF0094A5A50094A5A5006BA5
      A5006BA5A5006BA5A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A5A5006BA5
      A5006BA5A50094A5A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A5
      A50094A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052525A00395A4A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00425A4A0042525200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF002121210039393900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF005A316300315A420018A552005ACE8C004A8C63003152
      39006B317300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00214229001842210031734A002963420021312100314A
      29004A5A52006B736B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF002121210000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000002929290039393900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7F7FF00EFE7EF00EFE7EF00E7E7
      EF00EFE7EF00EFE7EF00EFE7EF00EFE7EF00EFE7EF00EFE7EF00EFE7EF00EFE7
      EF00F7EFF700EFE7EF00F7E7F700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0018632900087B290010A5420010A53900189C42004AA563005ABD84006BCE
      9C005AB5840039735200395A4200FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00525A
      520018422100104A21000894310008B54A0063FFA5008CFFC6006BC69C00528C
      6B001842210018392100294231005A5A5A00FF00FF00FF00FF00FF00FF00FF00
      FF00BD9494004A18100063212100632121009C737300BD8C8C00BD8C8C00BD8C
      8C00BD8C8C00ADADAD000000000008101000DEDEDE008C8C8C00FF00FF00FF00
      FF0000000000181818005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FFF7FF00B5A5AD009C8C9C008C8C8C00948C
      94008C848C008C8C8C008C848C00948C8C008C8C8C00948C9C008C8C8C00948C
      9400948C94008C8C940094949C00C6BDC600FF00FF005A39630052425A001094
      3100189431001894310010A5390008AD3900189C390042AD630063C68C004AB5
      7B004AA56B005ABD840063C6940039524200FF00FF00FF00FF00636B84004A5A
      84007B7B8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005A5A5A00394A390018421800105A
      210008B5420008C64A00189C4200219439002973310039844A0063C68C0073E7
      B5008CFFCE0063CEA50052A57B001042180021392100424A42005A635A00FF00
      FF00A5634200B54A3100B54A3100AD422900B54A3100B54A3100B54A3100B54A
      31008C29210000000000000000002929290039393900A5A5A500FF00FF00FF00
      FF0000000000636363005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF000808
      080063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFFFFF00DEEFF700C6C6CE00FFFFFF00FFFFFF00FFF7
      F700FFF7FF00FFFFFF00FFFFFF00FFF7FF00FFF7FF00FFF7FF00FFFFFF00FFF7
      F700FFF7FF00FFF7F700FFFFFF00B5B5BD001852290010943100109C3100109C
      3900109C390008A53900109C3900109C390010CE5A0039E78C004AB573005ABD
      7B005AB5840052B57B004AAD6B003152390039528C00184A9C002173E7002984
      EF00215AB50029397300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00394A420018421800105221000084290008C6520000BD
      4A0021843900297B39001894390000A5310063EFA5007BE7AD0042A56300397B
      42004A9C5A0063BD840073D6A50084FFCE006BD6A500396B4A00183921004A52
      4A00A56342007B08000073080000730800006B0800006B080000630800006B08
      0000630800000000000000000000212121008C8C8C009CA5A500080808000808
      0800100808007B7B7B0084848400ADADAD00FF00FF00FF00FF00393939002121
      210039393900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFF7FF00EFE7FF00BDC6C600FFEFF700FFDEEF00EFDE
      E700FFDEEF00FFEFF700FFE7F700FFEFF700FFDEE700FFDEEF00FFE7F700F7DE
      E700FFDEEF00FFE7EF00FFF7FF00CEBDC600105A210008A5390008AD42001094
      390010A5390008B5420000DE5A0000EF6B0000F77B0008F7730018F7840029EF
      8C0042E78C004ABD7B0039AD6B0029523900216BD6002163CE00215AC600216B
      D6003194FF002984EF0029529400FF00FF00FF00FF00FF00FF00FF00FF004252
      3900294A3100185229000873290010BD4A0000B53900219C3900297B2900297B
      290010AD420000BD420008BD390018A5390021733100399C5A0063D69C008CF7
      C60052CE9C0042AD6B0039844A00398C5A004AAD73007BF7C60094FFCE00394A
      39009C737300BD8C8C00BD8C8C00BD949400BD949400C69C9400C69C9400BD8C
      8C00BD8C8C00181818000000000018181800DEDEDE007B7B7B00000000000000
      0000081010007B7B7B008C8C8C009C737300CEB5AD00BD8C8C00080808008484
      8400ADADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFEF
      EF00FFEFFF00E7DEE700F7FFFF00D6E7EF00C6BDC600FFFFFF00FFFFFF00EFE7
      EF00FFEFFF00FFFFFF00FFFFFF00FFFFFF00EFEFEF00F7EFEF00FFFFFF00EFE7
      E700FFF7F700FFF7FF00FFFFFF00BDB5BD00105A2900109C390010A5390000D6
      520000F7730000FF7B0000FF7B0000FF7B00108C5200217B4A00397B5A00187B
      520010B55A0008E77B0029CE7B0073427B001852C6001042AD001039A500184A
      AD00398CF7005AB5FF005AADFF00395284006B637300FF00FF00314A3900187B
      29000894310008B53900189C310021733100217B3900108C390000BD4A0000BD
      4200189C390021843100217B3900219C420039CE7B006BCE940042945A002973
      31004AAD6B0063C68C007BD6AD0073DEA50052B57B002173310031844200394A
      3100FF00FF00A5FFFF00C6846300B54A3100B54A3100A5392100FFFFFF00A5FF
      FF00EFEFEF00FFFFFF0000000000000000003939390008101000081010000808
      0800000000002929290039393900FFEFD600FFF7DE00E7DED600080808008484
      8400B5CEB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7F7F700EFEF
      EF00E7DEF700D6CEEF00CEEFFF00B5D6EF00B5BDC600FFFFFF00FFF7FF00EFDE
      EF00F7EFEF00FFFFFF00FFF7FF00FFFFFF00EFE7E700F7EFF700FFF7FF00EFE7
      E700F7EFF700FFF7FF00FFFFFF00BDBDBD00106B290000D6630000EF6B0000BD
      63002963420039635200296B5200297352006363630084848400BDB5BD008C8C
      8C00425A4A0052636B007B7384003994FF00317BDE00297BDE00297BD600639C
      D6004A7BCE0073BDDE008CD6FF0084BDF700526BA500FF00FF00084218001094
      390021843900217B3100189C390000C6420000C6420008AD4200298431002173
      290010A5390008B5420000D6520008E75A0008F7840029FF940052FFAD007BFF
      BD006BC68C004AAD6B00318442004A8C52005AAD7B0084EFB5007BDEA5003942
      3100FF00FF00FFE7CE00C6846300B54A3100B54A3100A5392100FFFFF700FFF7
      DE00FFE7C600FFF7DE0039181000080808001008080063212100212121002121
      2100000000001008080063212100FFF7DE00FFFFE700FFFFE700292929003939
      390063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DED6DE00F7EF
      F700E7DEE700E7E7EF00EFEFFF00CEDEE700B5B5BD00FFE7EF00FFE7E700E7D6
      D600F7DEE700FFE7E700FFE7EF00FFE7E700EFD6DE00EFDEDE00FFE7EF00E7D6
      D600FFDEE700FFDEE700FFF7F700BDB5B500FF00FF006B5A840039945A003142
      390094948C00B5ADB500B5B5B500848484004A4A5200636363008C8C8C007363
      6B004A4242008CCEFF008CCEFF007BCEFF0084CEFF007BCEFF007BD6F7009CD6
      F70063739C00BDBDCE007B9CC60094DEF70094CEFF007B73840010421800189C
      390008AD420008C64A0008AD3900217B3900296B31002184390008B5420000CE
      4A0000E7630000EF6B0000FF7B0000F77B0000FF730010FF730000FF840000FF
      730018FF8C0031FF9C004AFFAD0063D694005AB57B00217B3900318C4A002942
      3100FF00FF00C69C9400C6846300A5392900A53921008C211800FFFFEF00EFC6
      A500C69C8C00C69C8C00E7A56300A5634200C6846300E7A563000800A5000008
      B50021218400212163004A1810009C737300BD8C8C00EFC6A500846363001010
      180063424200FF00FF00FF00FF00FF00FF00FF00FF00EFE7F700D6D6D600D6D6
      FF00A5A5CE00EFF7FF00C6EFFF00D6DEEF00B5ADB500FFF7FF00FFF7FF00E7DE
      E700EFEFEF00FFFFFF00FFF7FF00FFF7FF00E7DEE700F7E7EF00FFF7FF00E7DE
      E700F7EFF700FFF7FF00FFFFFF00C6BDC600FF00FF00FF00FF00FF00FF004242
      4A00636363008C8C8C007B7B7B00525252005A5A5A006B6B6B007B8484007B7B
      7B0063636300A5E7FF009CDEFF00A5E7FF00C6F7FF00C6F7FF00ADCEDE009CBD
      D600FF00FF00FF00FF00FF00FF0094ADCE0084C6DE00FF00FF000842180018A5
      420018943900187B3100218C390000B5420000D6520000DE520000F77B0000F7
      7B0000FF7B0000FF7B0000FF6B0010FF7B0008C66B0021A55A00219C6300319C
      6B0018BD6B0008DE7B0008FF840000FF7B0010FF8C0042FFAD004ADE9C004A52
      4200FF00FF00C69C9400A56342007B1810007B1008007B100800FFF7DE00FFF7
      DE00E7C6C600EFC6A500FFE7A5009C423900C69C8C00EFC6A5000800A5000008
      A5000042E7000042E7001831BD002139C6002163E7002163E7002163E7002121
      84002163E7002139C600FF00FF00FF00FF00F7F7F700C6BDC600F7F7FF00CECE
      EF009C94C600CEEFFF008CDEFF0094C6E700ADADBD00FFF7F700FFEFF700DED6
      D600F7E7EF00FFF7F700FFF7FF00FFEFF700E7DEE700EFDEE700FFF7FF00DED6
      DE00FFE7EF00FFEFF700FFFFFF00BDB5BD00FF00FF00FF00FF00FF00FF004A4A
      4A0063636B0073737B007B7B7B0073737300635A5A007B737B00ADADAD008484
      84004A4A4A00C6DEEF00DEF7FF00EFF7FF00C6CEDE00ADBDCE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00213921001894
      310010A5390008D6520000E7630000F7730000FF7B0000FF7B0000FF7B0008FF
      7B0000FF7B0000FF7B0010CE73001052310029313100424A4200525252005252
      52003931390021182100214A290008FF7B0000D663001884420010632100FF00
      FF00FF00FF00C69C8C009C4239006B0800006308000063080000FFEFD600FFFF
      EF00FFE7CE00FFE7CE00FFE7C6009C423900EFC6A500EFC6A50008009C000008
      A5000018AD000018AD000021BD000021BD000018AD000018AD000821AD000021
      BD000021BD001018B500FF00FF00FF00FF00D6CED600DED6DE00E7DEFF00E7DE
      E700BDB5C600FFFFFF00E7F7FF00BDC6D600B5B5B500FFE7EF00FFDEDE00E7C6
      D600F7D6DE00FFDEE700FFDEEF00FFDEEF00E7CED600F7D6DE00FFDEE700E7CE
      D600F7D6DE00FFDEE700FFEFF700CEBDBD00FF00FF00FF00FF00FF00FF004A42
      4A008C848C00ADA5AD00A5A5A5007B737B00635A630084848400A5A5A5007373
      7300524A5200CEC6DE00A5A5C600A59CC600DED6DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00084A100000E7
      630008EF730000FF7B0000FF730000BD6B000873420021423100211821002918
      210018212100183931003139390042424200A5A5A500BDBDBD00F7F7F700FFFF
      FF00D6D6D600A5ADA50052635A002931210042524200948C8400FF00FF00FF00
      FF00FF00FF00C69C9400CEB5AD008C29210084212100C6846300FFF7DE00FFFF
      EF00FFFFE700FFEFD600FFEFD6009C423900EFC6A500FFE7A50008009C000008
      A5000821BD002931B5001010AD002129B5001021AD002121AD000808A5001021
      AD0008008C001010AD00FF00FF00EFEFEF00BDBDBD00D6CEF700A59CFF00948C
      C600CECEDE009CDEFF00BDEFFF00ADADB500BDB5BD00F7F7FF00FFF7FF00DED6
      D600EFE7E700FFF7FF00FFF7FF00FFF7F700E7D6E700E7DEE700FFF7FF00D6CE
      D600F7E7EF00FFEFF700FFF7FF00BDB5BD00FF00FF00FF00FF00FF00FF004242
      4A006B636B008484840084848400636363009C949C00D6CECE00E7E7E700BDBD
      BD00635A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00428CE7003973DE00FF00FF00FF00FF00FF00FF00FF00FF00525A4200184A
      2100086B310000AD4A0008CE6B00183118005A525A007B847B00D6D6D600EFE7
      EF00E7EFEF00B5B5B5002931310042424A003939390021212100211821001818
      2100524A4A0063525A00635A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00CEB5AD00CEB5AD00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00BD949400FFFFF700FFFFF70008009C000010
      AD000821BD002131BD001018B5002939BD001829B5002131BD001018B5001829
      BD001018B5002931B500FF00FF00CEC6CE00CECECE00DED6DE00CEC6EF00847B
      AD00D6DEDE0084D6FF007BCEFF0094ADC60094B5C600FFEFF700FFEFF700DECE
      D600EFDEDE00FFEFF700FFEFF700FFEFF700DED6DE00EFDEE700FFEFF700DECE
      D600EFDEE700FFEFF700FFF7FF00BDBDC600FF00FF00FF00FF00FF00FF004242
      420073737B00848484008C949400848484005A42520084317B005A5252009C4A
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00528C
      E700007BFF001063EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0063846B004A6B4A004A424A00847B8C007B7373007B7B7B008484
      84009C949400948C8C00393939002929290084848400B5ADB500EFF7F700FFFF
      FF00A59CA500736B730031293100FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009C737300FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFEFD600FFFFFF00E7DED600C6846300FFFFF70008008C000800
      A5000021BD002939BD001018B5003142BD001821B5002939BD001021AD002939
      BD001018B5002121AD00E7E7E700BDB5BD00E7DEE700BDB5BD00B5ADB500948C
      9400EFE7EF00EFF7F700CEDEE700B5B5BD00ADBDC600FFDEE700FFDEDE00DEBD
      C600F7CED600FFD6DE00FFDEE700FFD6DE00E7C6CE00E7CECE00FFDEE700D6BD
      C600F7D6DE00FFD6DE00FFEFEF00BDB5BD00FF00FF00FF00FF00FF00FF004A4A
      4A00BDB5BD00CEC6CE00C6BDBD00A59C9C00FF00FF008CBDFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00006BF700007B
      FF000084FF00007BFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF002929310021182100393939006B6B6B008484
      8400636363004A4A4A002118210063636300636363005A5A5A004A4A52005252
      5A007B7B7B008C949400848C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C292100C6634200AD4A
      3100A53929009C29210084181000CEDECE0073080000CEB5AD0008008C000800
      A5000021BD002939BD001018B5003142BD002129B5003142BD001018B5002139
      C6000818AD002121AD00C6BDC600E7DEE700CECECE00CECED600A59CA500AD9C
      AD00ADDEF70094DEFF00ADC6D600BDBDD600BDBDBD00FFF7F700FFEFF700D6CE
      D600E7DEE700FFF7FF00FFEFF700FFEFF700D6D6D600E7DEE700F7EFF700D6CE
      D600EFDEE700FFEFF700FFEFFF00BDBDC600FF00FF00FF00FF00FF00FF00FF00
      FF009C9494009C9C9C00A59CA5008C848400FF00FF00528CF700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00528CE7001073F7000084FF000084
      FF000084FF000084FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0039393900847B8400949C9C00CED6D600EFEF
      EF00EFEFEF00D6D6D60039393900212121005A525A00847B7B00C6C6C600C6C6
      C600736B6B003131310021212100FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C292100C6634200C663
      4200B54A3100AD4A31008C100800CEB5AD007B080000E7C6C600000084000800
      A5000821BD002931BD001018B5003142BD001829B5002939BD001018B5002939
      BD000821AD002121AD00D6CED600E7DEE700C6C6CE00BDB5BD009C949C00BDB5
      B500B5E7FF0084D6FF0094B5CE006BB5E7008CADC600FFEFEF00FFE7F700D6C6
      C600EFD6DE00FFE7EF00FFE7EF00FFE7EF00DECED600E7CEDE00FFE7EF00CEC6
      C600EFD6DE00FFE7EF00FFEFF700BDB5BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00216BF700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052ADFF00299CFF00007BFF00007B
      FF00007BFF00007BFF003963DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00393131004239420039313900211821002121
      21002118210031293100312931004A4A4A008C848400847B8400948C94009C9C
      9C00A5A5A500BDBDBD0063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C100800B54A31009C29
      21008C211800841810005A000000CEB5AD005A000000E7C6C600000084000800
      A5000021BD002939BD001018B5003142BD001821B5003139BD001018B5002931
      BD000818AD002121AD00DED6DE00D6CED600E7DEE700C6BDC6009C9C9C00B5B5
      C600C6C6CE00CECED600B5B5BD00BDD6E700A5B5C600FFDEE700FFD6DE00DEBD
      BD00EFC6CE00FFD6DE00FFD6DE00FFD6E700DEBDBD00EFC6CE00FFD6DE00D6BD
      BD00EFCECE00FFD6DE00F7E7E700BDB5BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00217BF700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000073FF000073
      FF000073FF000073FF000052EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0031292900525A5200847B7B00D6D6D600EFEF
      EF00F7EFEF00BDB5BD00312931004A424A004A4A4A007B7373008C8C8C008C8C
      8C0052525A00393939004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C211800A5634200C684
      6300C6846300C6846300AD4A3100E7E7E7009C423900F7EFEF0008008C000008
      A5000821BD002939BD001018B5003139BD002129AD002939BD001021AD002131
      BD001018B5002129AD00FF00FF00EFE7EF00CEC6CE00DED6D600BDB5B500D6C6
      CE00D6CECE00B5B5B500A5A5A500AD9CAD00AD9CAD00E7DEE700EFDEEF00C6BD
      C600D6CED600EFDEDE00EFDEE700E7DEDE00CEC6CE00D6CECE00EFDEE700C6BD
      C600DED6DE00E7DEDE00F7E7F700BDB5BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003994FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000073FF000073
      FF000073FF00007BFF003194FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00394242006B636300635A5A004A4A4A004A4A
      52004A5252006363630042424A0052525200E7E7E700E7E7E700E7E7E700E7E7
      E700EFDEE700D6CED60073636B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C684
      6300E7A56300E7A56300E7A56300C6846300C69C8C00BD8C8C000808A5000800
      A5000821BD002931BD001021AD002939BD001829B5002939BD001021AD002131
      BD001018B5002129AD00FF00FF00FF00FF00FFFFFF00DED6DE009C9C9C00E7DE
      E700CECECE00C6C6C600B5B5B500C6BDC600ADA5AD00D6C6D600B5B5B500ADA5
      AD00ADADAD00BDB5BD00BDB5BD00B5B5B500ADA5AD00B5ADB500BDB5BD00ADA5
      AD00ADADAD00BDB5BD00DED6DE00BDB5BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063BDFF002952DE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298CFF00006BFF00006B
      FF00006BFF002173FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF002121290031292900635A5A00A5A5A500B5B5
      B500BDBDBD0084848400292929004A4A4A00C6B5BD00CEBDBD00E7E7E700E7E7
      E700B5B5B5009C9C9C00524A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A5AE7003131CE002100C6001018B5001010AD000808A5001010AD000800
      9C000821BD002931BD001018B5002939BD001829B5002131BD001018B5001831
      BD001018B5002931B500FF00FF00FF00FF00FF00FF00FFF7FF00B5ADB500E7DE
      E700C6BDC600ADADAD00BDB5BD00BDB5BD00ADA5AD00DED6DE00D6CED600B5B5
      B500C6C6C600CECECE00D6CED600CECECE00C6BDC600C6BDC600D6CED600B5B5
      B500C6BDC600D6CED600EFE7EF00B5B5B500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000052F700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0084ADF7000063FF000063FF000063
      FF00006BFF006BA5EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00393939008C8484007B7B84007B8484006B6B
      6B008C949400949C9C00848C8C00212129004A3942004A393900393131003931
      3100635A5A007B6B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084A5E7005A5AE7005A5AE7005A5AE7002929C6002121BD001010AD000808
      A5000821BD002131BD001018B5002939BD001829B5002131BD001018B5001829
      BD001018B5002931B500FF00FF00FF00FF00FF00FF00F7EFF700BDBDBD00EFE7
      EF00EFE7EF00E7D6E700CEC6CE00C6BDC600ADA5AD00D6CED600CEC6CE00B5AD
      B500BDB5BD00CEC6CE00C6C6C600CEC6CE00B5B5B500BDB5BD00CEC6CE00B5AD
      B500C6BDC600CEC6CE00E7D6E700C6B5C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001073FF001031
      DE006B7BDE00FF00FF00FF00FF00FF00FF001063FF000063FF000063FF000063
      FF003184F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF003939390039313900524A4A008C8C8C00B5AD
      B5008C848C00736B6B005252520031212100FF00FF00FF00FF00846B6B009C7B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084A5E7005A5AE7003939D6003939D6002929C6002121BD001010AD000808
      A5000821BD002931BD001821B5002939BD001829B5002131BD001018B5001831
      BD001018B5002931B500FF00FF00FF00FF00FF00FF00FF00FF00F7EFF700E7DE
      E700D6CED600CECECE00D6CED600C6C6C600B5ADB500E7DEE700DED6DE00CECE
      CE00DED6DE00DED6DE00DED6DE00DED6DE00DECEDE00D6CED600DED6DE00CECE
      CE00DED6DE00DED6DE00EFE7EF00C6BDC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063B5FF000052
      FF000039EF00526BE7006B84EF00295AE700005AFF00005AFF00005AFF00005A
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0052525200B5B5B500EFE7E700EFE7E700EFDE
      E700EFE7E700EFE7E7008C8C8C0039313100FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084A5E7005A5AE7003939D6003939D6002929C6002121BD001010AD000808
      A5000821BD002131BD001821B5002939BD001829BD002129B5001021AD000818
      AD000008A5003142BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FFFFFF00F7F7F700DED6DE009C9C9C00A59CA5009C949C008C8C
      8C00A5A5A500C6BDC600CEC6CE00CEC6CE00B5B5B500BDB5BD00CECECE00D6CE
      D600D6CED600D6CED600CECECE00D6C6D600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00217B
      FF000052FF000042F7000042F700004AFF000052FF000052FF00005AFF001873
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00423131007B7373009C949C00B5B5B500DEDE
      DE00BDB5BD00B5B5BD005A5252004A393900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084A5E7005A5AE7003939D6003939D6002929C6002121BD001010AD000808
      A5000821BD002131BD001821B5002931B5001021AD000821AD000010AD003142
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7EFF700CEC6CE00D6CE
      D600EFEFEF00DED6DE00C6BDC600BDBDBD00CEC6CE00E7DEE700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005AADFF00085AFF000052FF000052FF000052FF00005AFF005294FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00948C8C0063525A004A4242003931
      3100635A6300635A5A006B525200B5A5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF003939D6003939D6002121FF002929C6002121BD001818B5001010AD000800
      A5000018AD000821BD003142BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FFFFFF00F7EFF700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00429CFF00217BFF003184FF00529CFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000800A5000800A5000800A5000800A5000800A5000800A5000800A5000800
      A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C737300E7948C007342
      420052393900FF00FF004A4A73005A5AB5001010B50018187300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00636B6300425A4A00635A6300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF004273630018634A00186B4A00218C6300186B
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF004A4ABD004242B5003131AD002929A5002921A5002921
      AD002921B5004A399C00524AA500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008C6B6B00FF9C9C00FF9C9C006B39
      39006329290031214A006363CE006363CE000808B5000000A50010106B00FF00
      FF00FF00FF004A5A4A002142290018422100104A210031734A00213929002131
      2100314A2900425242004A5A5200FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF004A736300186B4A00187B5200188C6300188C6300219C730021B5
      8400186B4A0042736300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003931BD002921
      BD003129CE00394ACE00525AEF005252EF005252F7005252FF00524AFF004A42
      F7004239EF003131DE002929DE001818D6001008BD001010AD002929A500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00946B6B00FF9C9C00FF9C9C006B39
      390052212100180831004A42B5006363CE000808B5000000A500000073003142
      310018422100216331000894310008B54A0008C65A0063FFA50084F7C6006BC6
      9C00528C6B00315A42001842210029423100424A42005A5A5A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0031846B002173
      5A0018634A0021735200218C6300188C6300218C630018846300219C730021B5
      840021AD7B00187B520018634A0042948400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005A4AB5003931B500525AB5007B84E7009C9C
      FF008C94FF008494FF008484F7008484FF007B84FF007373FF006363F7005A5A
      F7004A4AE7004A4AEF004242E7004239EF003131E7001810BD0008089C001008
      8C0010087B00FF00FF00FF00FF00FF00FF00946B6B00FF9C9C00BD7373008452
      52004A10100018081800084A7B00313173002121B5000000A50000007300088C
      310008B5420000BD4200189C420021943900217B31002973310052A56B0063C6
      8C0073E7B5008CFFCE008CFFCE0052A57B00396B420010421800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B500949494007B73
      7B00635A6300525252004A4A4A00635A630084848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00296B5200186B4A0031947B004AD6BD004AD6B5001863
      4A0018845A00188C6300188C6300188C6300188C6300188C630021A57B0021B5
      7B0021AD7B0018A5730018634A005AFFE70039AD9C00216B520039735A00FF00
      FF00FF00FF00FF00FF004231BD00949CF700ADB5FF00BDC6FF00C6CEF700D6CE
      FF00CEC6FF00D6D6FF00CEC6FF00B5B5F700ADA5FF00A59CFF00948CFF006B6B
      FF005A5AF7005A4AFF004A4AFF003939EF002929DE001821C6001018B5000810
      AD000808A50000009400FF00FF00FF00FF0063525200946B6B00D6ADAD00A594
      9400184A630000B5DE0000B5FF00006BB5008484EF002121BD0000007B0008A5
      390021843900297331001894390000A5310008BD4A0063EFA50063C68C0042A5
      6300397B4200397B39004A9C5A0073D6A5008CFFCE0084FFCE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00635A6300636363006B6B6B007373
      73007B737B007B737B006B6B6B005A5A5A0052525200424242004A4A4A005A5A
      5A0084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0021634A001884630018634A0031A58C004AD6BD004AD6BD001863
      4A0018845A00188C6300188C6300188C6300188C63001884630021AD840021B5
      840021AD7B0021A5730018634A005AFFEF005AFFEF00319C7B0018735200FF00
      FF00FF00FF00FF00FF007363CE008484CE00C6CEFF00DEDEFF00EFF7EF00FFF7
      F700FFEFFF00F7EFFF00DEDEF700D6DEFF00C6CEFF00B5B5FF009C9CFF007B84
      FF006B73F7005A52FF004A4AF7003139DE002129CE001821C6001021B5000810
      AD000810A50008089C00FF00FF00FF00FF00B5ADAD00DEB5B500FFCECE0000A5
      C60000CEFF0000CEFF0000BDFF00009CFF004A52AD005A5AC60010186B002194
      310010AD420000C64A0008BD390018A53900218431002173310052B5840063D6
      9C008CF7C6007BEFC60052CE9C0039844A0031733900398C5A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B636B0094949400B5ADB500BDBDBD00CECE
      CE00E7E7E700E7E7E700BDBDBD009494940052525200525252005A5A5A005A5A
      5A00524A52004A4A4A004A4A4A00636363008C8C8C00FF00FF00FF00FF00FF00
      FF00FF00FF0018634A0021946B0018634A0042AD8C004AD6B5004ACEBD001863
      4A0018845A00188C6300188C6300188C6300188C63001884630021AD840021B5
      840021AD7B0021A5730018634A005AFFE7005AFFE70039A5840018A57300186B
      4A004A7B6B00FF00FF00FF00FF004A39A500D6CEFF00F7FFFF00FFFFEF00FFFF
      FF00FFFFFF00FFFFFF00EFF7FF00CECEFF009C9CEF008484E7006B6BDE004A4A
      DE00424ADE004A4ADE004242DE003942DE002931CE001821BD001818BD001018
      B5000808AD0010108400FF00FF00FF00FF0021421800948C9400DEB5B50000BD
      EF0000CEFF0000CEFF0000BDFF00009CFF0018295A0039527B0000BD420008B5
      4200189C390021732900217B3900219C420010AD420039CE7B005AAD7B004294
      5A0029733100298439004AAD6B007BD6AD008CEFC60073DEA500FF00FF00FF00
      FF00FF00FF00FF00FF00ADADAD00E7E7E700FFFFFF00F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700CECECE00BDBDBD00948C94006B6B6B005A525A004A4A
      4A004A4A4A005A525A005A5A5A00525252004A4A4A004A4A4A00FF00FF00FF00
      FF00FF00FF0018634A0021946B0018634A0042AD94004ACEBD004AD6BD001863
      4A0018845A00188C6300188C6300188C6300188C6300188C630021B58C0021AD
      7B0021B5840018A56B0018634A005AFFEF005AFFE700399C840018A5730021B5
      840018634A00FF00FF00FF00FF005A52AD00948CDE00E7EFFF00FFFFFF00FFFF
      FF00EFF7FF00DEE7FF007373D6004A42AD0021189C002118A5002118B5000808
      BD000000B5000000A5001010B5002121CE003131D6002929D6002118BD001010
      AD0008089C00FF00FF00FF00FF00FF00FF0008A55200109439002184390000BD
      EF0000CEFF0000ADD600089CCE00009CFF00316384002984310021732900188C
      310010A5390008C64A0000D6520008E75A0000EF6B0008F7840039FFA50052FF
      AD007BFFBD0084E7AD006BC68C0031844200216B29004A8C5200FF00FF00FF00
      FF00FF00FF00FF00FF00B5B5B500E7E7E700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700CECECE00CEC6C600CEC6CE00CEC6CE00BDBDBD00ADAD
      AD008C8C940073737300525252004A424A005A5A5A00525252008C8C8C00FF00
      FF00FF00FF0018634A00188C630018634A0042B59C0042D6BD0042D6BD001863
      4A0018845A00188C6300188C6300188C6300188C630021946B0029B58C0021AD
      7B0021B5840018A5730018634A005AFFEF005AFFEF00399C7B0021AD7B0021B5
      840018634A00FF00FF00FF00FF00FF00FF004231AD00A59CFF00EFF7F700EFFF
      F7009494DE002118A5004A4ABD007373EF008C8CFF007B73FF005A52F7003939
      EF002929DE001810CE001008C6000000B5000800BD002121CE002118B5001818
      A5003931B500FF00FF00FF00FF00FF00FF0029842900189C390008AD42000094
      B500109CA50000C6C60000FFFF0000C6FF003963840008B5420000CE4A0008DE
      5A0000E7630008FF7B0000FF7B0000F77B0000FF840000FF730000F77B0000FF
      840000FF730008FF840018FF8C004AFFAD006BF7B50063D69400FF00FF00FF00
      FF00FF00FF00FF00FF0084848C00DEDEDE00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00E7E7E700C6C6C60073B58C00C6C6CE00CECECE00CECECE00CECE
      CE00CEC6CE00CEC6CE00CEC6CE00B5B5B500B5B5B500ADA5AD006B6B6B00FF00
      FF00FF00FF0018634A00188C630018634A004ABD9C004AD6B5004AD6BD001863
      4A0010845A00188C6300188C6300188C6300188C630021946B0021B5840021AD
      7B0021AD7B0018A5730018634A005AFFEF0063FFEF003194730021AD730021B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B73CE000000
      7B008484F700D6DEFF007BB5D6006B94B500395A7B002942630029425A007B8C
      AD00737B9C006B638C0042399C000808B5000000B5000810A500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0008B5520018A5420018943900009C
      9C0000FFFF0000FFFF0000FFFF0000FFFF003963840000F77B0000F77B0000FF
      7B0000FF7B0000FF7B0000FF6B0010FF7B0000DE7B0008C66B00299C5A00219C
      6300319C6B0021A55A0018BD6B0008FF840000FF7B0000FF7B00FF00FF000000
      0000000000000000000094737300C6C6C600EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00DEDEDE00D6D6D600C6CEC600D6D6D600C6A5A500C6949400C69C
      9C00C6ADA500CEB5BD00D6CECE00CECECE00CECECE00A5A5A50084848400FF00
      FF00FF00FF0018634A00188C630018634A0042BDA5004AD6BD004AD6BD001863
      4A0010845A00188C630018946B00188C6300188C5A0021946B0029B58C0021AD
      7B0021AD7B0021A56B0018634A005AFFEF0063FFEF0031947B0018AD730021B5
      7B0021634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B7B
      CE004A63AD007B9CC6007BADCE004A6B8400737384009C948C00847B6B006352
      4200C6AD9C00FFBD9400D69C6B00BD9473008452630084528400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00217B29001894310010A53900396B
      940000CECE0000FFFF0000F7F70000B5B50000FF7B0000FF7B0008FF7B0000FF
      7B0000FF7B0000FF7B0010CE7300105231002118210029313100524A4A005252
      5200525252004A524A0039313900214A290021BD630008FF7B00FF00FF000000
      00000000000000000000FFFFFF00ADA5A500E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700DEDEDE00DEDEDE00D6ADAD00D69C9C00D6949400CE8C
      9400CE8C8C00C6848400CEA5A500D6D6D600D6D6D6008C848C0000000000FF00
      FF00FF00FF0018634A00188C630018634A004ABDA50042D6BD004AD6BD001863
      4A0018845A00188C6300188C6300188C63001884630021A5730029B5840021AD
      7B0021AD7B0021A5730018634A005AFFE7005AF7DE002994730018AD730021B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5C6
      DE005284B500A5CEFF00ADCEEF005A6B7B009C8C9C00BDADA5007B6B6B006B6B
      7B009C9CB5008CADB500A5A59C00C6A57300E7AD5A00DE8C3100D6844200D69C
      7B00FF00FF00FF00FF00FF00FF00FF00FF0008CE630000E7630008EF730000FF
      7B00427B9C00089CA50031738C00087342001021180021182100291821002118
      2100182121002152420031393900424242007B848400A5A5A500D6D6D600F7F7
      F700FFFFFF00E7E7E700D6D6D60052635A002131290029312100FF00FF000000
      00000000000000000000FFFFFF00948C8C00DEDEDE00E7E7E700E7E7E700EFE7
      EF00EFEFEF00EFEFEF00E7DEDE00DEADB500E7ADAD00E7ADAD00DEA5A500DEA5
      A500D69C9C00D6949400D6B5BD00DEDEDE00C6C6C6008484840000000000FF00
      FF00FF00FF0018634A00188C630018634A004ABDA5004AD6BD004AD6BD001863
      4A0018845A00188C6300188C6300188C6300188C630021A57B0021B5840021AD
      7B0021AD7B0021A5730018634A005AFFE7005AEFD6003194730018AD7B0021B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084A5
      D600A5D6FF009CD6FF009CDEFF009CC6DE00738CA500637B8C005A849C0084CE
      FF007BC6FF004ABDFF0063B5FF007BADEF005A7B84006B632900B56310009C31
      00009C2900009C391000FF00FF00FF00FF00084A1000184A2100086B310000AD
      4A0008CE6B00189C5200183118005A525A00B5ADAD00D6D6D600EFE7EF00FFFF
      FF00E7EFEF007B847B002931310042424A004A4A4A0039393900211821002118
      21001818210031292900524A4A00635A5A004A423900FF00FF00FF00FF000000
      00000000000000000000FFFFFF00B5848C009C9C9C00CECECE00E7DEDE00EFEF
      E700DECECE00DEADAD00EFB5B500FFC6C600F7BDC600F7BDBD00EFB5B500EFB5
      B500E7ADAD00D6A5A500E7DEE700CECECE007B7B7B000000000000000000FF00
      FF00FF00FF0018634A00188C630018634A004ABDA50042D6BD004AD6BD001863
      4A0018845A00188C6300188C6300188C6300188C630021AD7B0021B57B0021AD
      7B0021AD7B0021A5730018634A005AFFE7005AEFCE002994730018AD7B0021B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5BDE70094B5
      F700B5E7FF00A5DEF700A5E7FF00B5EFFF00B5DEFF00ADDEFF0094D6F70084D6
      FF0063BDFF0073B5FF007BC6FF0052BDF700399CF70031528C006B391800B54A
      0000C6420800BD4A0000AD521800FF00FF00FF00FF00FF00FF00FF00FF006384
      6B004A6B4A00212921004A424A00847B8C00847B7B007B7B7B00848484008C8C
      8C009C949400A59C9C0039393900292929005A5A5A0084848400D6D6D600EFF7
      F700FFFFFF00CECED600A59CA5003129310052424A00FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000948C8C00C6C6C600FFFF
      FF00F7EFEF00F7E7E700EFD6D600EFC6CE00EFC6C600E7B5B500EFB5B500E7AD
      AD00DEB5B500E7DEDE00ADADAD00948C8C00FFFFFF000000000000000000FF00
      FF00FF00FF0018634A00188C630018634A004ABDA50042CEB5004AD6BD001863
      4A0018845A00188C6300188C6300188C6300188C630021AD7B0021B57B0021AD
      7B0021AD7B0021A5730018634A0052FFEF005AE7C60029946B0021AD7B0021B5
      7B0018634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084ADE700ADDE
      FF00BDEFF700CEEFFF00D6EFFF00CEE7FF00C6DEFF00B5E7FF008CD6FF0084D6
      FF0084C6FF0063C6FF006BB5FF0063B5FF0063BDFF0042637B0084521000DE8C
      1000D6941000DEBD3100EFAD3900AD5A1800FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C8C8C00292931002118210042424A006B6B6B0084848400948C
      940063636300292929002118210063636300736B6B00636363004A4A4A004A4A
      520052525A0063636B007B7B7B00848C8C004A424200FF00FF00FF00FF000000
      00000000000000000000FFFFFF0000000000000000009C9C9C00CED6CE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6BDC6008473
      7B00949494009C949C00FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF0018634A00188C630018634A004ABDA50042CEB5004AD6BD001863
      4A0018845A00188C6300188C6300188C6300218C630021AD7B0021AD7B0021AD
      7B0021AD7B0021A5730018634A0052FFE70052DEBD0021946B0021AD7B0021B5
      7B0018634A00FF00FF00FF00FF00FF00FF00FF00FF008CB5D6008CC6F700BDE7
      FF00B5E7FF00C6EFFF00CEF7FF00C6EFFF00BDE7FF00ADDEFF009CD6FF008CCE
      FF0084C6FF0084BDFF005ABDFF005AC6EF0073B5FF00426B7B00BD631000EFB5
      5200DEB55A00DECE8C00EFBD4200BD730000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007B847B0039393900847B8400B5BDBD00CED6D600EFEFEF00FFFF
      FF00EFEFEF00BDC6C6003939390021212100312931005A525A00A5A5A500C6C6
      C600C6C6C6009C9C9C00736B6B0021212100635A5A00FF00FF00FF00FF000000
      00000000000000000000FFFFFF00000000000000000084737300C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700B5B5B5007373
      73000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF0018634A00188C630018634A004AB59C004AD6BD004ACEBD001863
      4A0018845A00218C6300188C6300188C6300188C630018A5730018AD730021AD
      7B0021AD7B0021A57B0018634A005AFFE70052CEB50021946B0021AD7B0021B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF0094B5D60084BDE700BDE7
      FF00B5E7FF00BDE7FF00BDE7FF00BDE7FF00B5DEFF00ADDEFF009CD6FF0084C6
      FF007BC6FF0073BDFF005ABDFF005ABDF70073BDFF00215A7300B5733900FFCE
      8400E7D68C00EFDEAD00FFC66300DE841000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00847B7B0039313100423942001818210021182100212121002118
      21002118210042424200312931004A4A4A00948C8C008C8484008C848C00948C
      94009C9C9C00949C9400A5A5A500636363004A393900FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000BDB5B500ADADAD00C6CE
      CE00DEDEDE00E7E7E700EFEFEF00F7F7F700FFFFFF00CECECE007B737B00FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF0018634A00218C630021634A0042B59C0052EFD6004AF7D60039BD
      9C00218C730029B58C00299C840031948C003194840029A5940039DEBD0039CE
      AD0018AD730029947B00216B52005AFFEF0042B59C0018946B0021AD7B0029B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF0094BDD60084C6EF00B5DE
      FF00A5DEEF00BDE7FF00B5E7FF00B5E7FF00ADDEFF00A5D6FF009CD6FF0084C6
      FF007BC6FF006BBDFF006BBDFF0063BDFF0042A5F700085A7B009C735200FFE7
      B500F7F7BD00EFF7D600EFCE7B00CE8C2900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007B7B840031292900525A5200BDB5BD00D6D6D600EFEFEF00FFFF
      FF00F7EFEF00948C9400312931004A424A00393139004A4A4A008C848C008C8C
      8C008C8C8C007373730052525A004A4A4A0042393900FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00CECEDE00D6D6
      D600C6C6C600BDBDBD00B5B5B500ADA5A500948C8C00948C940000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF0018634A0018845A002994730052C6AD0073FFEF0073FFF70063E7
      D60029948400218C840042A59400DEF7F700DEEFF7003994840021947B0039D6
      B5002184730031A5940052FFE7005AFFE70042AD8400189C6B0021B5840021B5
      7B0018634A00FF00FF00FF00FF00FF00FF00FF00FF0073A5C60063B5E700A5DE
      FF0094D6F700B5D6FF00A5D6FF00A5D6FF009CD6FF0094CEFF008CCEFF007BC6
      FF007BC6FF0063BDFF0063ADF7007BC6FF002994D60000638C006B635A00FFF7
      CE00FFFFCE00FFF7CE00FFDE9400CE8C4200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0084848C00394242006B636300424242004A4A4A004A4A52005A52
      5A004A5252008484840042424A0052525200B5B5BD00E7E7E700EFE7E700E7E7
      E700E7E7E700EFDEE700EFDEE70073636B0052424A00FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF0029B5840039B58C0029A58C00298C7B0073D6C600ADFFF70084FF
      F70073FFE700298C7B00EFF7FF00CEEFEF00CEF7F700DEEFF7005AA59C00319C
      84005AD6BD006BEFDE0084FFEF007BF7E700299C7300189C6B0018AD7B0021B5
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF00527B9C00106BA50063B5
      EF008CD6FF009CC6FF008CCEFF008CCEFF0084C6FF0084C6FF007BC6FF0073C6
      FF006BBDFF0063BDF7006BB5E7003173B5000873AD00319CC60039738C009452
      3100DE9C5A00DEA54200C68C3900AD7B4200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007B84840021212900312929008C848C00A5A5A500B5B5B500C6C6
      C600BDBDBD005A525200292929004A4A4A008C848C00C6B5BD00EFE7E700E7E7
      E700E7E7E700CECECE00B5B5B500524A4A00635A6300FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF0042AD8C0042CEAD0031D6AD0039BDA500218C7B00319C8C0084DE
      D6009CFFF70042AD9C0063A59C00EFF7F700F7FFFF00FFFFFF00E7F7F7004A9C
      940052C6AD0042BDA5006BCEBD00298C7B0029A58C0042D6B5005AC6A50021BD
      840018634A00FF00FF00FF00FF00FF00FF00FF00FF00314A5A00005A84002984
      BD005AB5E70094CEFF0084C6FF0084C6FF007BC6FF007BC6FF007BC6FF006BBD
      FF0063BDF700429CD6002184B5002173C60031A5E7002994CE00318CB5008C52
      3100AD4A0000AD4A0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00635A6300393939008C84840073737B007B8484006B6B6B007B7B
      84008C949400ADADAD00848C8C0021212900524A4A004A394200312929003931
      31003931310042393900635A5A00FF00FF00FF00FF00FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF00FF00FF005AA5940031BD9C004ADEBD0039CEAD0021A58C002184
      730031948400319484002184730029847B007BADA5008CB5B50031948400298C
      7B00298C8400298C7B002994840042C6A50031D6AD0042DEC60042DEC60031CE
      94004A8C7300FF00FF00FF00FF00FF00FF00FF00FF004A525200186B8C000863
      8C00006B9400428CC60073B5F70073BDFF0073BDFF0073BDFF0063ADEF00297B
      BD00186BAD00217BBD00319CD60042A5FF0029A5EF00299CE700188CBD007B4A
      2900BD42000094420000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00393139003939390039313900847B84008C8C8C00B5ADB5009C94
      9C008C848C004239420052525200312121007B5A6300FF00FF00735A5A00846B
      6B009C7B7B0084636B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF0052A58C004AA58C0052D6BD006BF7DE0052CE
      BD002994840063D6C60042CEB50018948400528C8400318C7B0039B59C005AD6
      BD006BDEC6002194840031D6AD0052DEC6005ADEC60039DEBD0031D6B500429C
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0018637B00007B
      BD00005AA50029639C00006B9C00086BA5001073B5001873BD00106BB500319C
      D6004AB5EF006BBDFF0052B5FF0039ADFF0029ADFF0039A5D600527373008C52
      1800C64A0000AD522100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF004A39420052525200B5B5B500E7DEDE00EFE7E700EFDEE700EFE7
      E700EFE7E700DED6DE008C8C8C0039313100AD949400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AA5940052A5940063D6
      C60063D6C600298C7B0039DEBD0029B5940031AD940042C6AD0052DECE0052E7
      CE00218C7B0042B5A50042C6AD0052DEBD0031B59400399C8400429C8400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00424A52001073
      9400007BB500007BB5002184A500006B9400006B9C00218CBD0039ADDE0063CE
      F70073DEFF006BEFF70039BDF70029ADFF004AA5FF006B849C008C5A3100B552
      0800CE4A0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00423131007B737300BDB5B500B5B5B500DEDEDE00CECE
      CE00BDB5BD008C8C8C005A5252004A393900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00739C
      940073A59C00BDC6C6007BB5A5004AA58C00429C8C00429C84005AA58C00319C
      8C00739C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00635A5200297384003184AD00187BA500006B9C00007BAD00089CD60042C6
      EF0052C6EF0063B5F7007394BD008C735A00BD731800E77B0800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00948C8C00635252004A42420039313100524A
      4A00635A6300847B84006B525200B5A5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006BADA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF004A948400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00A58C7B008C8C8400637373003963630042737300738C
      8400848C840094846300C6945A00EFA54A00DE8C2900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00ADB5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00EFBD8C00FFE7B500FFF7C600F7EFC600EFCE
      9C00F7CE9400FFCE6B00DE943900C66B2100C66B2900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00848484006B6B6B0073737300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B7B94006B7B940084A5BD008CADD6005A738C006B6B
      730094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00948C
      8C00949494009C9494009C9C9C008C8C840073736B005A525200525252006363
      5A007B7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0084848400636363007B7B7B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006363630031526B00639CCE00639CCE007BB5E7006394CE0031639C002139
      5A004242420073737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00CE9C9C00CE9C9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADA5A500CECE
      CE00BDB5B500B5ADB500BDB5B500B5B5AD00B5B5AD00B5ADAD00ADA5A5009494
      94007B7B7B006B6B6B005A525200424A420052525200736B7300FF00FF00FF00
      FF007B7B7B00A5ADA500DEDEDE00DEDEDE005A5A5A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A5A5A005284A5007BADDE007BADDE00427BAD005A94C60031639C00295A
      9C0021395A004242420073737300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00CE9C9C00D6AD9400D6AD9400D6AD
      9400CE9C9C00CE9C9C00CEA5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CECECE00DEDEDE00CEC6
      C600B5B5B500B5ADB500B5B5B500B5B5B500B5ADAD00B5ADAD00ADADA500ADAD
      A500ADA5A500ADA5A5005A5A5A0031394A004242520031292900182118009C9C
      9C00F7F7F700FFFFFF00FFFFFF00FFFFFF0073737300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00636B730039424200736B7300737373007373
      7300292929005284A50021528C0021528C007BB5E7005A94C60031639C003163
      9C0031639C0018395A0042424A00736B7300736B7300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00CE9C9C00CE9C9C00FFCE9C00FFCE
      9C00FFCE9C00EFBD9400E7B58C00D6AD9400CE9C9C00CE9C9C00CE9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DED6D600DEDEDE00CEC6
      C600B5B5B500B5B5B500BDBDBD00BDB5B500A5A5A500737373007B7B7B00948C
      9400A59C9C00B5ADA500424252000000A5000000AD0000009400000084004A42
      4200E7DED600F7EFEF00FFF7F700FFFFFF0073737300FF00FF00FF00FF00FF00
      FF00FF00FF00213952002139520010315A000018390039424200737373007373
      7300292929005284A5005A9CCE005A9CCE005A94C6004A7BB50031639C003163
      9C0031639C0031639C0018395A00424242004242420073737300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00EFBD9400D6AD9400D6AD9400FFD6
      AD00FFD6AD00F7D6A500FFCE9C00FFCE9C00FFCE9C00EFBD9400EFBD9400D6AD
      9400CE9C9C00CE9C9C00CE9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094635A008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DED6D600DEDEDE00CECE
      CE00BDB5B500BDB5B500BDBDBD00BDBDBD008C8C8C0010101000080808001818
      1800313131007373730029294A000000AD000000BD000000C6000000BD00844A
      1000AD6B2900BD733900D6A57B00FFF7F7007B7B7300FF00FF00FF00FF004263
      730042638400639CCE00639CCE0031639C000031630000213900393939007373
      73002929290039638C00427BB500427BB5005A94C6004A7BB50031639C003163
      9C0031639C0031639C0031639C0021396300213963003939390073737300FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00EFCEA500F7D6A500CE9C9C00DEB5
      A500FFEFB500FFEFB500FFD6AD00FFD6AD00FFD6AD00F7D6A500FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00EFBD9400D6AD9400D6AD9400CE9C9C00CE9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF0094635A00EFE7DE00F7EFDE00F7EFDE00F7E7
      D600F7E7D600EFE7CE00EFE7C600EFDEC600EFDEBD00EFDEBD00EFDEB500EFD6
      B500E7D6AD00E7D6AD00E7D6AD00E7CEA5008C2900008C422900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE00E7DEDE00CECE
      CE00BDB5B500BDBDBD00CEC6C600C6C6C6008C8C8C0008080800000000000000
      31000000AD000010D6000818CE001021BD001031CE0010106B00522908008442
      2100BD734A00C6845A00C68C6300F7EFE700737B7B00FF00FF00FF00FF004A73
      9C007BB5E700296394002963940031639C000031630000296300002142003939
      3900292929004A739C005A94C6005A94C6007BB5E7005A94C60031639C003163
      9C0031639C0031639C0031639C00315A9C00315A9C002139630042394200FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00F7D6A500FFEFB500EFCEA500CE9C
      9C00EFDEB500FFF7C600FFF7C600FFEFB500FFEFB500FFEFB500FFEFB500FFD6
      AD00FFD6AD00FFCE9C00F7D6A500FFCE9C00FFCE9C00D6AD9400CE9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF009C6B5A00E7E7DE00F7EFE700F7EFDE00F7EF
      DE00F7E7D600F7E7D600EFE7CE00EFE7CE00EFE7C600EFDEC600944221009439
      10009C4218009C4218009C4218009C4218008C290000B54200008C290800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE00E7DEDE00CECE
      CE00BDB5B500BDBDBD00CEC6C600CEC6C6008C8C8C0008080800000008000810
      7B001839D60018319C0010184A0018399C0018317B006B635200BD6B29007352
      4A00A5735A00C68C6300E7CEB500FFFFFF00737B7300FF00FF00FF00FF004A73
      9C0021528C00639CCE00639CCE0031639C000031630000316300003163000829
      4A00001018005284AD00639CCE00639CCE004273A5005A94C60031639C003163
      9C0031639C0031639C0031639C0031639C0031639C0031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00EFDEB500FFF7C600FFEFB500EFCE
      A500CE9C9C00FFE7CE00FFFFD600FFF7C600FFF7C600FFF7C600FFEFB500FFEF
      B500FFEFB500FFEFB500FFD6AD00FFD6AD00DEB5A500CE9C9C00CE9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00A56B6300EFEFE700F7F7EF00F7F7E700F7EF
      E700F7EFDE00F7EFDE00F7E7D600F7E7D600EFE7CE00EFE7C60094422100CE52
      0000D65A0000C64A0000BD4A0000BD4A0000BD4A0000BD4A0000B54200008C29
      08009463520073424200FF00FF00FF00FF00FF00FF00DED6DE00E7DEE700CECE
      CE00BDBDBD00C6BDBD00CECEC600CECEC6008C8C8C0008080800000000001018
      4200314263007B8484007373730018214A0084848400EFEFEF007394B5000873
      DE001031520039312100CECECE00FFFFFF0084848400FF00FF00FF00FF004A73
      9C00639CCE004A84BD004A84BD00215A8C000031630000316300215A8C00427B
      AD00215A8C004273AD0010427B0010427B0031639C00396B9C00295A94003163
      9C0031639C0031639C0031639C0031639C0031639C0031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00FFEFB500FFFFD600FFFFD600FFF7
      C600CEADAD00DEB5A500FFFFE700FFFFD600FFFFD600FFFFD600FFFFD600FFF7
      C600FFF7C600FFF7C600FFF7C600EFCEA500CE9C9C00DEB5A500CEA5A500FF00
      FF00FF00FF00FF00FF00FF00FF00A5736300F7EFEF00FFF7F700FFF7EF00F7F7
      E700F7EFDE00F7EFDE00F7E7D600F7E7D600EFE7CE00EFE7C60094422100DE6B
      0000F7730000DE6B0000CE520000BD4A0000BD4A0000BD4A0000B54200008C21
      0000C68C630073424200FF00FF00FF00FF00FF00FF00DED6D600E7DEDE00D6CE
      CE00BDBDBD00C6C6C600D6CECE00CECECE008C8C8C0008080800000000005A63
      5A00D6D6CE00F7F7F700ADB5B50073736B00DEDEDE00F7F7F700318CDE00008C
      E7000084D6000029390031313100EFEFEF00847B7B00FF00FF00FF00FF00315A
      8400427BB5004A84BD004A84BD00215A8C00295A8C003973A500215A8C00316B
      9C00184A7B0008397300184A8400184A84003973A500295A940010427B00295A
      9C0031639C0031639C0031639C0031639C0031639C0031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00F7E7C600FFFFD600FFFFD600FFFF
      D600FFEFB500CEA5A500DEC6B500FFFFE700FFFFE700FFFFE700FFFFD600FFFF
      D600FFFFD600FFFFD600EFDEB500CE9C9C00EFCEA500FFCE9C00D6AD9400FF00
      FF00FF00FF00FF00FF00FF00FF00AD7B6300F7F7F700FFFFFF00FFFFF700FFF7
      F700848484008484840084848400848484008484840084848400944221009442
      21009C4221009C4221009C4221009C42180084290000B54200008C290000D6AD
      8400E7D6AD0073424200FF00FF00FF00FF00FF00FF00D6D6D600E7E7E700D6CE
      CE00C6BDBD00C6C6C600D6CECE00D6CECE0094948C000808080008080800A5A5
      A500FFFFFF00EFEFEF00CECECE00A5A5A50094949400E7E7EF00218CDE00008C
      D600009CEF0000426B0000000000BDBDBD00847B8400FF00FF00FF00FF00426B
      94005A94C600639CCE00639CCE0031639C00427BAD001852840021529400184A
      8400003163004273AD00528CBD00528CBD0094BDDE007B9CC600295A94001042
      730031639C0031639C0031639C0031639C0031639C0031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00F7E7C600FFFFD600FFFFD600FFFF
      D600FFFFD600E7CEBD00CE9C9C00F7E7D600FFFFEF00FFFFE700FFFFE700FFFF
      E700FFFFE700EFDEB500CE9C9C00DEB5A500FFEFB500FFEFB500D6AD9400FF00
      FF00FF00FF00FF00FF00FF00FF00B5846B00F7F7F700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00F7EFDE00F7EFDE00F7EF
      DE00F7E7D600EFE7CE00EFE7C600EFDEC6009431080094310800D6AD8C00EFD6
      B500EFD6B50073424200FF00FF00FF00FF00FF00FF00DED6D600EFE7E700CED6
      CE00BDBDBD00CEC6C600DED6CE00CED6D60094948C000808080008080800A5A5
      A500C6C6C6007B7B7B00848C8400B5B5B500D6CECE00EFF7F700315A7B001839
      4200085273000018290000000000B5B5B50084848400FF00FF00FF00FF004A73
      9C006BA5D600295A8C00295A8C0029639400184A840021528C0010427B00316B
      9C00639CCE006BA5D60073ADDE0073ADDE009CCEFF00CEE7FF007B9CC600295A
      940010427B00295A940031639C0031639C0031639C0031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00F7E7D600FFFFE700FFFFE700FFFF
      E700F7E7C600CEA5A500CE9C9C00CE9C9C00EFDED600FFFFEF00FFFFFF00FFFF
      F700F7EFDE00CEA5A500E7BDB500FFF7C600FFF7C600FFF7C600DEB5A500FF00
      FF00FF00FF00FF00FF00FF00FF00BD846B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084848400848484008484840084848400848484008484840084848400DEDE
      D600F7E7D600F7E7D600EFE7CE00EFE7CE0094310800E7CEB500EFDEBD00EFDE
      BD00EFD6B50073424200FF00FF00FF00FF00FF00FF00DED6DE00EFE7E700D6CE
      D600C6BDBD00CEC6C600D6CED600DED6D60094948C000808080008080800A5A5
      A500D6D6D600BDBDBD00BDBDBD008C8C8C00948C9400EFEFEF0073736B003931
      3100292121000000000018181800EFEFEF008C8C8C00FF00FF00FF00FF00315A
      840010427B0018528400185284003973A5005294C600639CCE0084BDEF008CC6
      F7009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF00BDDE
      FF0084A5C6002152940010427B0000316B0000316B0031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00EFE7DE00FFFFE700FFEFD600D6B5
      AD00CE9C9C00BDBDBD00C6EFF700C6C6C600CE9C9C00CE9C9C00CEA5A500D6B5
      AD00CEA5A500CE9C9C00F7E7C600FFFFD600FFFFD600FFFFD600DEB5A500FF00
      FF00FF00FF00FF00FF00FF00FF00C68C6B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00F7F7EF00F7F7E700F7EF
      E700F7EFDE00F7EFDE00F7EFDE00EFE7CE007B4A4A00EFE7C600EFE7C600EFDE
      BD00EFDEBD007B424200FF00FF00FF00FF00FF00FF00DED6D600EFE7EF00D6D6
      D600C6C6BD00C6C6C6002142C6006384CE009494940008080800080808008484
      8400BDBDBD00848C8400B5B5B500CECECE00C6C6C600F7F7F700DEE7E7002129
      21001821180029313100BDBDBD00F7F7F7008C8C8C00FF00FF00FF00FF000029
      52004A84B500528CBD00528CBD00639CCE0084BDEF0094C6F70094C6F7006BA5
      D6008CC6F7009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF009CD6
      FF00BDDEFF0084A5C60008397300003163000031630031639C0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00EFDED600E7BDB500CE9C9C00C6BD
      AD00E7E7E700F7FFFF00FFFFFF00E7FFFF00C6FFFF00C6DEE700BDC6DE00C6C6
      C600ADCEDE00CEADAD00CE9C9C00FFEFD600FFFFD600FFFFD600DEB5A500FF00
      FF00FF00FF00FF00FF00FF00FF00CE946B00FFFFFF00FFFFFF00FFFFFF00D6AD
      9C00EFDED600FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7EF00F7F7
      E700F7EFE7005A6B8400214A9C00DED6D6007B4A4A00F7E7D600EFE7CE00EFE7
      C600EFDEC6007B4A4A00FF00FF00FF00FF00FF00FF00DEDED600EFE7E700D6D6
      D600C6C6BD00B5BDCE001063D600105AD6008C84940008080800080808008C8C
      8C00D6D6D600D6D6D6009C949C0084848400ADADAD00F7F7F700FFFFFF00CECE
      CE00CECECE00D6D6D600E7DEE700B5B5B500FF00FF00FF00FF00FF00FF004A73
      9C006BA5D6007BB5E7007BB5E70094CEFF0094C6F70084B5DE00A5C6E700FFFF
      FF00B5CEE7008CC6EF009CCEFF009CCEFF009CCEFF009CCEFF0094C6F7005284
      AD004A7BA5005A8CBD002963940000316300003163001042730018315200FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00CE9C9C00CEA5A500BDC6DE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00E7FFFF00E7FFFF00E7FF
      FF00E7FFFF00D6EFFF00CEADAD00CE9C9C00F7E7C600FFFFE700DEB5A500FF00
      FF00FF00FF00FF00FF00FF00FF00D6947300FFFFFF00FFFFFF00CE9C8C008C21
      0000DEBDAD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7
      EF00F7F7EF005A73AD003184F700DED6D6007B4A4A00F7E7D600F7E7D600EFE7
      CE00EFE7CE007B4A4A00FF00FF00FF00FF00FF00FF00DEDEDE00EFE7E700D6D6
      D600C6BDBD00CEC6CE006394E7006B94DE009494940008080800080808006B6B
      6B009C9C9C00ADADAD00C6C6C600E7E7E700F7FFF700FFFFFF00FFFFFF00DED6
      DE00BDBDBD00BDBDBD00CEC6CE00FF00FF00FF00FF00FF00FF00FF00FF004263
      730094C6F700ADD6FF00ADD6FF00B5D6F700A5C6E700F7F7FF00FFFFFF00FFFF
      FF00F7F7F7007BADD60084BDEF0084BDEF008CC6F7009CCEFF00527B9C004242
      42004242420039525A00528CB5002963940029639400295A940008294200FF00
      FF00FF00FF00FF00FF00FF00FF00CE9C9C00CE9C9C00CE9C9C00BDC6DE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00E7FFFF00F7FF
      FF00E7FFFF00E7FFFF00D6EFFF00BDADA500CEA5A500FFEFD600D6B5AD00FF00
      FF00FF00FF00FF00FF00FF00FF00D69C7300FFFFFF00B57352009C310000B542
      0000942900009429000094290000942900009429000094290000F7F7F700F7F7
      EF00F7F7EF00F7F7EF00DED6D600DED6D6007B4A4A00E7DECE00EFE7CE00EFE7
      CE00EFE7CE0084524A00FF00FF00FF00FF00FF00FF00DEDEDE00E7EFE700DED6
      D600C6C6C600D6D6CE00C6C6DE00E7E7DE009C9C8C0008080800080808009494
      9400F7F7F700FFF7FF00FFFFFF00FFFFFF00EFEFEF00D6D6D600ADA5AD00C6C6
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF004A637B00ADD6FF00ADD6FF00E7F7FF00FFFFFF00FFFFFF00FFFFFF00DEDE
      DE0084848400314252002139520021395200426B8C008CC6F70021313900BDBD
      BD00525252006B6B6B00394A52007BADD6007BADD6008CADCE0018395A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C9C00CEADAD0094D6F700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FF
      FF00E7FFFF00BDE7F700ADDEF7007BCEE700AD8CA500CEA5A500CEA5A500FF00
      FF00FF00FF00FF00FF00FF00FF00DE9C73009C390800C64A0000E76B0000D65A
      0000C64A0000BD4A0000BD4A0000BD4A0000BD4A000094290000DEBDA500D694
      6B00D6946B00D6946B00D6946B00D6946B007B4A4A00E7DED600314A63001852
      DE00EFE7CE0084525200FF00FF00FF00FF00FF00FF00DEDEDE00EFE7EF00DED6
      DE00C6C6BD00CECECE0018187B00636BB5009C9C94000808080008080800B5AD
      B500FFFFFF00EFEFEF00CECECE00B5B5B500ADADAD008C8C8C0073737300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00425A7300425A7300A5D6FF00E7F7FF00FFFFFF00FFFFFF00F7F7
      F700DEDEDE00CECECE00CECECE00CECECE00D6D6DE00BDDEFF00213139007B73
      7B009494940018181800637B940094BDEF0094BDEF00292929005A636B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C9C00ADADD600FFFF
      FF00FFFFFF00FFFFFF00D6E7EF00ADDEF70094D6F70094D6F7009CADEF0084AD
      CE00AD8CA500AD8CA500CE9C9C00B5A5B500B5A5B500CE9C9C00CE9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C390800F77B0000E76B
      0000C64A0000B5420000AD420000AD420000AD42000094290000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00E7E7DE005A7BC6006BAD
      EF00EFE7CE0084525200FF00FF00FF00FF00FF00FF00DEDEDE00EFEFEF00D6D6
      D600CEC6CE00BDB5CE001021B5001821B500948C940008080800080808006363
      6300525252008C8C8C00C6BDC600C6BDBD00C6C6C6009C9494007B7B7300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00526B7B0094C6EF00E7F7FF00FFFFFF00FFFF
      FF00FFFFFF00EFF7FF00DEEFFF00DEEFFF009CCEFF009CCEFF009CCEFF005A63
      63006B6B6B004A5A73004A6B63001029100010291000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADD6009CAD
      EF0073D6FF0073D6FF0073D6FF009CE7FF0094D6F70094D6F70094D6F70094D6
      F70094D6F7009CADEF009CADEF00ADADD600B5A5B500CE9C9C00CE9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094391800C65A
      0800C6947300DEBDAD00DEBDAD00DEBDAD00DEBDAD00E7C6BD00FFFFFF00F7F7
      F700F7F7F700F7F7F700F7F7F700EFEFEF00EFEFEF00E7E7E700E7E7E700E7E7
      E700E7E7E7008C5A5200FF00FF00FF00FF00FF00FF00DEDEDE00F7EFEF00DEDE
      DE00CEC6C600DEDEDE00DEDEE700E7E7EF00D6D6D6009C949400847B7B006B6B
      6B0063636300B5B5B500D6CECE00CEC6CE00CECECE009C9C9C007B7B7B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0063738C009CC6F700E7F7FF00EFF7
      FF00D6EFFF00A5D6FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF005252
      5200425A42002184210008840800008400000084000039393900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEA5
      A500BDBDBD008CF7FF009CE7FF009CE7FF009CE7FF009CE7FF0094D6F70094D6
      F70094D6F70094D6F70094D6F7009CADEF00B5A5B500CE9C9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C42
      2900D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D694
      6B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D694
      6B00D6946B008C5A5A00FF00FF00FF00FF00FF00FF00DEDEDE00F7EFEF00DED6
      DE00CEC6C600DEDEDE00F7EFEF00EFEFEF00E7E7E700E7E7E700DEDEDE00DEDE
      DE00D6D6D600D6D6D600D6CECE00CECECE00CECECE009C9C9C00737B7300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A637300A5D6FF00B5DE
      FF009CCEFF009CCEFF009CCEFF009CCEFF009CCEFF007B9CBD00637B8C00189C
      210010B5100000C6000000C60000004200000042000039393900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00CEA5A500BDBDBD008CF7FF008CF7FF009CE7FF009CE7FF009CE7FF0094D6
      F70094D6F70094D6F7009CC6DE00CE9C9C00D6B5AD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE00F7EFF700DEDE
      DE00C6C6C600D6D6D600F7F7F700F7EFEF00EFEFEF00E7E7E700E7E7E700DEDE
      DE00DEDEDE00DED6D600D6D6CE00D6CECE00D6CECE009CA59C0084848400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00395263009CCE
      FF009CCEFF009CCEFF0084ADDE0084ADDE0018293100107B180008D6080000BD
      000000CE0000006B000000210000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00CEA5A500BDBDBD009CFFFF008CF7FF009CE7FF009CE7FF009CE7
      FF0094D6F700B5A5B500CE9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE00D6D6D600DED6
      D600E7DEE700E7DEDE00DEDEDE00DEDEDE00DED6DE00DED6DE00DED6D600D6D6
      D600D6D6D600D6CECE00CECECE00CECECE00CECECE00A5A5A500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005263
      73007BA5CE00424A4A005A5A5A005A5A5A00FF00FF008C8C8C00087308000094
      000031313100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00CEA5A500B5B5B5009CDEEF008CF7FF009CE7FF009CC6
      DE00CE9C9C00D6B5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6
      D600CECECE00D6D6D600DED6DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DED6
      D600DEDED600D6D6D600CECECE00C6C6C600C6C6C600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C8C8C007B7B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6BDBD00CE9C9C00CE9C9C00CE9C9C00CE9C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005ABD6B0039BD4A0031B5
      4A0031B54A004AB55200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009C313100840808008C101000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0039C65A0000C6290000D6290000D6290000D6
      290000D6290000D6290000C6210000AD18004AB55A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C1010008C1818006B394200843939008400
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0039DE630000D6310000D6310000D6310000DE310008DE
      3900FF00FF00FF00FF00FF00FF00FF00FF0018D64A0021B53900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052735A00317342001884390042AD
      73005AA57B004A7B5A00426352005A6B630084847B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094212100FF00
      FF00FF00FF00426B840094636B0084000000944A4A004A94AD007BA5B5008400
      00008C1818006B636B0052637300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00E7C6BD00EFCEBD00F7DECE00F7DED600EFDE
      CE00EFCEBD00E7C6BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000D6420000DE420000DE420000DE420000DE4A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0010BD3900FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C94
      8C0052736300316B3900107B3100088C3100109C3900109C3900109C390039AD
      630052B57B005ABD840063C68C005AB584004AA573004A7B5A0042634A008484
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C1818009C52
      5200426373005294B5007321310084000000633139003184A5003184A5008400
      000084000000525A7300297B9C00295A7300425A6300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7D6CE00F7E7DE00FFF7F700F7EFEF00EFE7E700DED6D600E7DE
      DE00EFEFEF00F7F7F700F7E7DE00EFD6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0010DE5A0000DE4A0000DE4A0000DE4A0000DE4A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0010BD
      4200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001084
      310010943100109C3900109C3900109C310010A53900109C390010AD420029B5
      630052BD840052BD7B0052BD7B0052AD7B0052B57B0052B57B004A9C6B006373
      6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C393900840000009C313100FF00FF00FF00FF008408
      0800848CA500529CB5007B39420084000000633139003184A5003184A5008400
      0000840000004A5263002984A5003184A50029739400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7DED600FFF7F700EFEFEF00D6BDB500CE947B00C6846300C67B5A00C67B
      5A00BD8C6B00C6ADA500E7DEDE00FFF7EF00F7DED600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063CE840094CE
      9C0052E78C0000E75A0000E75A0000E75A0000DE5A0000DE5A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0031C65A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00109C
      390010A53900109C390010AD420008BD4A0000D65A0000EF6B0000F7730008F7
      730018EF840029EF8C0031E7840031D6840042C67B0042BD7B00429C63005A63
      5A00FF00FF004A4A630073738400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008410100094212100AD5252009429290084080800737B84009429
      29009C39390073A5BD00A5848C00840000009C424A005294AD0094ADB5008400
      0000942121006B8C9C003184A5003184A50029739400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      DE00FFF7F700E7D6CE00CE947B00D6735200D66B4200D66B4200D66B3900D663
      3900CE633100C6633900B5735200CEBDB500F7EFEF00F7DED600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0008CE
      520000DE5A0000E7630000E7630000E7630000E7630039E77B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0031DE7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0008C6
      520008DE5A0000D6630000C65A0008C6630000CE630008CE6B00188C52004273
      5A00638473006B8C7B004A7B6300218C520010C6630031B56B005A9C6B00FFC6
      94006B425A004A2952003121520018104A00FF00FF00FF00FF00FF00FF00FF00
      FF00AD52520084000000FF00FF00FF00FF00FF00FF0084000000639CB500947B
      840084000000A58C9400849CB500942929008408080073212900842129008400
      00008C4A5200428CAD003184A5003184A50029739400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFD6CE00FFF7
      F700E7D6CE00D68C7300DE7B5200DE7B4A00D6734A00E7945A00EFB56B00DE7B
      4A00D6633900CE633100CE633100BD6B4A00CEB5AD00F7F7F700EFD6C600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0021EF
      940000E7730000E7730000E7730000E7730000E7730010CE52005ACE7B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0021B5
      6300189C5200426352007B7B73009C9C9C009CA5A5006B736B00394242006363
      63007B7B84008C8C8C00847B7B00524A4A00BDBDBD00FFC69400FFD6B500FFD6
      BD00F7CEBD00E7B5AD00CE9C9C006B5A7B00FF00FF00FF00FF00FF00FF00FF00
      FF008400000084000000FF00FF00FF00FF00FF00FF00840000004A84A500528C
      AD00A54242009C39390084ADBD00B5ADB500AD5252008408080094212100B56B
      6B007B94AD003184A5003184A5003184A50029739400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFE7DE00FFEFEF00EFEF
      E700DEA58C00DE845A00DE845200DE7B5200DE734A00EFB57B00FFEF9C00DE8C
      5200D66B3900D6633900CE633100CE633100BD735200DECECE00F7EFE700EFD6
      CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000EF840000E77B0000E77B0000E77B0000E77B0008E78400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00949C94004A424A00737373009C9CA5009C9C9C0063636300423942006B63
      63008484840094949C007B7B7B0052525200FFC69400FFC69C00FFCEAD00FFDE
      C600F7E7D600C6ADA500B5ADB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008C10100084000000FF00FF00FF00FF00FF00FF008400000042739C002973
      9C007B84940084080800A5737B003184A500297394002163840029638C00296B
      940029739400297B9C00297BA5003184A50029739400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DED600FFF7F700E7C6
      B500E7946B00E78C6300E7846300DE845A00DE7B5200E78C6300E7A56B00DE7B
      5200D66B4200D66B4200D66B3900CE633900CE633100B58C7B00F7EFEF00E7C6
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0021EFA50000EF840000EF840010EF8C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00ADADAD004A4242006B636B008C848C008C848C006B636B00424242006B6B
      6B008C8C8C00949494007B7B7B00524A4A00FFC69400FFC69400FFD6AD00FFDE
      BD00FFD6B500847B730052525A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00AD52520084000000FF00FF00FF00FF00FF00FF0084000000396B8C00317B
      A5003984A500A55252008C2121008C9CB500639CBD00639CBD005A9CBD005294
      BD003984A50031739C00296B940029739C00216B8C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7DE00F7EFE700FFF7EF00E7AD
      9400EF947300E7946B00E78C6300E7846300DE845A00E7A57300F7CE9C00E78C
      5A00D6734A00D6734200D66B4200D66B3900CE633900BD734A00E7E7DE00F7DE
      CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0018EF9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00ADADB500424242006B6B6B008C8C8C008C8C8C006B636B005A525A00BDB5
      BD00DED6D600D6D6D600BDB5BD00635A6300FFC69400FFAD7300FFAD7B00FFB5
      8400FFC69C00A59C94006B63630073737300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008408080094292900B56B6B009C313100840000005A94BD004294
      B5003184A5008C8C9C008C181800AD6B6B00B5BDBD009CADBD008CADBD0073AD
      C6006BADCE006BA5C600639CBD0031739C0018527300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFD6CE00F7EFE700F7E7DE00EFAD
      8C00EF9C7300EF947300EF946B00E78C6300E7845A00EFA57B00FFF7C600EFAD
      8400DE7B5200DE734A00D6734200D66B4200D66B3900CE6B4200D6CEC600FFEF
      EF00E7C6BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0094949400524A4A0073737B008C8C8C008C8C940073737B004A424200948C
      8C00736363006B5A5A00A59C9C0018296B005A425A0084525200A5635A00CE7B
      5A00E78C63005A4252008C8C8C004A4A4A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C3131008400000094292900AD5A6300398CAD003184
      A500398CAD00B5C6D600B563630084000000D6BDBD00CEC6C600C6C6C600C6C6
      C600BDBDC600ADBDCE00426B8C005AA5C6006BADCE004A73840052637300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFDECE00FFEFE700F7E7DE00F7AD
      8C00F79C7B00EF9C7300EF947300EF946B00E78C6300E78C6300FFDEBD00FFEF
      BD00EFAD8400DE7B5200DE7B4A00D6734A00D6734200D66B4200CEBDB500FFF7
      F700E7C6B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDB5BD007B737300CEC6C600DED6D600D6CED600ADA5AD00736363001829
      6B0018296B0021316B0021316B00213173002139730021397B0029397B002139
      7B00314273001818520063636B00737373006B6B6B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C3131008400000094292900AD5A6300398CAD003184
      A500398CAD00B5C6D600B563630084000000D6BDBD00CEC6C600C6C6C600C6C6
      C600BDBDC600ADBDCE00426B8C005AA5C6006BADCE004A73840052637300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFD6CE00F7EFE700F7E7DE00F7B5
      9400F7A58400EF9C7B00EF9C7B00EF947300EF946B00E78C6300EF946B00F7D6
      AD00FFEFC600EFA57300DE7B5200DE7B4A00D6734A00D6734200D6BDB500FFF7
      F700E7C6B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003184EF00007B
      FF00296BDE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00BDBDBD00ADA5AD00A59C9C00ADADAD00BDB5B500D6CECE002131
      6B0021317300213973002139730021427B0029427B00294A8400294A8400294A
      8C0031528C0029427B00393152008C8C8C004A4A5200FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006394A5003184A500297B
      9C0042637300DED6DE00CEBDC600B59C9C00CEBDC600CECECE00C6C6C600C6C6
      C600C6C6C600CECECE0021314200185A84005A9CBD005284A50042637300526B
      7B004A525A00FF00FF00FF00FF00FF00FF00F7DECE00FFEFE700F7EFE700F7BD
      A500F7AD8C00F7A58400F7A57B00F7AD8C00F7B59C00EF9C7B00EF8C6B00EF94
      7300FFEFCE00F7CEAD00E78C5A00DE7B5200DE7B5200D67B5200DED6CE00FFEF
      EF00E7CEC600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00297BEF00007BFF000084FF000084
      FF000073F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00ADADAD006BB5DE006BB5DE00424A7B0029427B0029427B002139
      7B0021427B0021427B0029427B00294A8400314A840031528C0031528C003152
      9400395A9400395A9400182152007373730084848400635A6300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004A7B9400398CAD00297B9C001052
      7300394A5200DEDEDE00CECECE00CEC6CE00CECECE00CECECE00C6C6C600C6C6
      C600CEC6CE00D6D6D600213142004284AD008CCEEF008CC6E70052636B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7EFE700F7EFE700FFFFF700F7CE
      C600FFAD9400F7AD8C00F7A58400FFC6B500FFEFE700F7AD9400EF947300EF94
      7300FFE7D600F7D6BD00E78C6B00E7845A00DE7B5200D68C6B00EFEFEF00F7DE
      D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006B9CF700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00428CEF000873F700007BFF000084FF000084FF000084
      FF00007BFF002163E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00B5B5B5006BB5DE001894DE00106BB50018317B0021427B00314A
      840031528C00395A940042639C0042639C0039639C0042639C0039639C003963
      9C0039639C00426B9C0029397B005A5A6B00949494005A525A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF004A7B9C00398CAD003184A50010527B000042
      6300394A5200DEDEDE00D6D6D600CECECE00CECECE00CEC6CE00CEC6CE00CECE
      CE00CECECE00D6D6D60029394A0094CEF7009CDEFF00A5DEFF0094CEEF005A6B
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DECE00FFFFFF00F7E7
      DE00FFBDA500FFAD9400FFAD8C00F7B59400FFF7EF00FFDECE00F7B59400F7C6
      AD00FFF7EF00F7C6AD00E78C6B00E78C6300DE845A00D6B5A500FFFFF700F7DE
      D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00427BF700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00007BFF00007BFF00007BFF00007B
      FF00007BFF000063F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00B5B5B50073B5DE001894DE001094DE001094DE00108CD600107B
      C6000873BD000863AD0008529C00426394005A5A8400394A7B0039428400314A
      8400395A940042639C00426BA50039395A009C9C9C00737373005A525A00FF00
      FF00FF00FF00FF00FF004A63730039739400316B840031738C00105A7B00084A
      6B00424A5A00E7DEE700D6D6D600CECECE00CEC6CE00CEC6CE00CECECE00D6CE
      D600D6CED600DEDEDE00425263009CDEFF009CDEFF00A5DEFF00A5DEFF0094CE
      EF00636B7300FF00FF00FF00FF00FF00FF00FF00FF00F7DECE00FFEFE700FFFF
      FF00F7DED600FFB59C00FFAD9400F7AD8C00F7BDA500FFE7DE00FFEFEF00FFEF
      E700F7CEBD00EF947300EF946B00E7946B00DEAD8C00EFEFE700F7E7E700EFDE
      D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF001873F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000073FF000073FF000073FF000073
      FF00087BFF00188CFF002963E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00B5B5B500DEE7E700C6DEE700B5D6E7009CCEE7008CC6E70073BD
      E7005AB5E70042ADE70031A5DE009CCEEF00D6D6D600A57B5200DEA56B00D69C
      7300CECECE006B637B006B6B8C00FF00FF00FF00FF007B7B7B006B636B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00526B7B004A94B5003984
      A5004A5A6300E7E7E700DEDEDE00D6CED600CEC6CE00CECECE00D6CED600D6CE
      D600CECECE00DEDEDE0052637300A5DEFF009CDEFF009CDEFF009CDEFF007BA5
      C6008C8C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DED600FFF7
      F700FFF7F700F7D6C600FFBDA500FFAD9400F7AD8C00F7AD8C00F7B59400F7A5
      8C00EF9C7B00EF9C7300EF9C7B00E7AD9400EFDED600FFFFFF00F7DECE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF003994FF00185AEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00006BFF00006BFF00006BFF00006B
      FF00398CF700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00B5B5B500E7E7E700E7E7E700EFE7EF00EFE7EF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EFF7F700D6D6D6009C5A2100CE630000CE63
      0000FFF7E700948C9400FF00FF00FF00FF00FF00FF00FF00FF008C8C8C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A849C0063A5BD005A9C
      B50042525A00D6D6D600F7EFF700F7F7F700EFEFEF00E7E7E700D6D6D600CECE
      CE00D6CED600E7DEE700526B7300A5DEFF009CDEFF00A5DEFF007BA5BD007B84
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7DE00F7D6
      CE00FFFFF700FFF7F700F7E7D600FFC6B500FFB59C00FFB59400F7AD8C00F7A5
      8C00F7AD8C00EFB59400EFC6B500F7E7E700FFFFF700F7D6CE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00086BFF001042E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00006BFF000063FF000063FF000063FF00006B
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00B5B5B500DEAD8400D6844200DE945200DE9C6300DEAD7B00E7B5
      8C00E7C6A500E7D6BD00F7E7CE00F7F7EF00DEDEDE00AD845A00DE945200DE94
      4A00FFF7EF00948C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A94AD0063A5BD005A9C
      BD0042738400314A5A004A525A007B7B8400B5ADAD00D6CED600EFEFEF00EFEF
      EF00EFEFEF00E7E7E700526B7300A5DEFF009CDEFF00739CB500848C9400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DE
      D600F7DED600FFF7EF00FFFFF700FFF7EF00F7E7E700F7DECE00F7D6C600F7D6
      C600F7DECE00F7EFE700FFFFFF00FFF7EF00F7D6CE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000063FF000039E700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00085AFF000063FF000063FF000063FF000063FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDBD00B5B5B500DE9C6300CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000E7BD8C00D6DEDE008C8C8C00BDB5BD00BDC6
      BD00BDC6C6007B7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00636B7B006BADCE0063A5BD0063A5
      BD0063A5BD0063A5C6005A94AD004A7B9400426B7B00425A6B00525A5A008484
      8400BDB5BD00CED6CE00526373009CDEFF007BA5BD008C8C9400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7D6CE00F7E7D600FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFFF00FFFFF700F7DED600F7DED600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000863FF00004AF7000842E7002952E700315A
      EF001852EF000052FF000052FF00005AFF00005AFF00005AFF00297BFF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00C6BDC600B5B5AD00DEBD9C00D68C4A00D68C4200D6843100D67B2900CE73
      2100D6731000CE6B0800CE630000EFBD9400DEDEDE0073737300D6D6D600D6D6
      D600CECECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00737B7B00526B7B006BA5BD006BAD
      CE0063A5BD0063A5BD0063A5BD005AA5BD0063A5C6005AA5C6005A9CBD004252
      5A008C8C8C00424242004A63730073A5C6007B848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00EFD6C600EFD6C600F7DECE00F7DED600F7DE
      CE00EFCEBD00F7D6CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF001873FF000052FF000052FF00004A
      FF000052FF000052FF000052FF000052FF00005AFF003184FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0084848400ADADAD00BDBDBD00BDBDBD00CECEC600CECECE00DED6
      D600DED6D600EFE7DE00EFE7DE00F7F7EF00BDBDBD0094949400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C8C8C006B73
      7B006B8494005A849C005A94AD006BA5C60063A5C60063A5C600528CAD008C8C
      8C00FF00FF00FF00FF00526B6B00848C8C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00398CFF002173
      FF00106BFF00106BFF002173FF00428CFF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CECECE00CECECE00BDBDBD00BDB5BD00B5AD
      B500ADADAD00ADADAD00ADADAD009C9C9C00A5A5A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00636B7B005A7B8C006394A50042637300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C8C94008484AD00B5AD
      BD00BDB5CE002939B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF007B7B7B005A5A5A00636363005A5A5A006363
      6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00A59C9C00A59C9C00ADA5A5009C94940084848400A5A5
      A500ADA5BD00528CDE004A6BC600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006B6B6B0084848400A5A5A500A5A5A5009C9C9C008C8C8C00847B
      84004A4A4A005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADAD
      AD009C949400B5A5A500ADA59C00AD9C94009C8C8C007B7B7B0094949400B5B5
      B5007B7BBD006BB5EF007BD6FF004A63C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006B6B6B00D6CED600BDBDBD00A5A5A500949C9400949494008C8C8C008484
      84007B7B7B006B6B6B00524A5200FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007B737B009C949C00A5A5A500847B840084848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CECECE00ADAD
      AD00BDB5BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008484CE007B7B8400BDB5
      B500AD9C9400948C84009C9494009C949400ADA5A500B5ADBD008C8CCE008494
      D6004294EF008CD6FF0094DEFF006BBDEF00A5A5DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B
      7B00BDBDBD00BDBDBD00ADA5AD00A5A5A500A59CA50094949400949494008C8C
      8C00847B84007B737B00736B73004A4A4A00FF00FF00FF00FF00FF00FF00948C
      8C00E7DEDE00EFEFEF00DEDEDE00D6D6D600C6C6C6007B737B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7EFEF00EFEF
      EF00D6CED600A5A5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00424A9C0039398C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE6B0000CE630000FF00FF00FF00FF00A5A5D600BDBDCE006B6B6B008C8C
      8C00BDBDBD00C6C6CE00BDBDC6009494C6005273CE001863DE001884EF0039A5
      F70084CEFF004AB5FF007BCEFF008CCEF700A5A5DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007373
      7300EFEFEF00ADADAD009C9C9C009C9C9C008C8C8C00848484008C8C8C008484
      84008C848C007B7B7B00737373006B6B6B00736B7300FF00FF00948C8C00DEDE
      DE00FFFFFF00EFEFEF00E7E7E700D6DECE00A5BD9C009C9C9C00A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00E7E7
      EF00FFFFFF00EFEFEF00ADADAD0094949400ADA5AD00A59CA5009C949400A5A5
      A500FF00FF001018BD000010E7000018E70008089C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFF700FFF7
      EF00FFF7EF00FFF7E700FFF7E700CE630000FFEFDE00FFEFD600FFEFD600FFE7
      CE00FFE7CE00FFE7BD00FFE7BD00FFDEB500FFDEB500FFD6AD00FFD6AD00FFD6
      AD00FFD6AD00CE630000FF00FF00FF00FF008C8CD600D6CED600BDB5B500CECE
      CE00B5ADCE00637BC600214ACE000039DE001063E7004A84EF006BA5EF0052AD
      F70031A5FF0052B5FF006BC6FF006B7BCE008C8CAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B63
      6B00DEDEDE00ADADAD00ADADAD00CEC6CE00C6C6CE00B5B5B500949494008C8C
      8C00ADADAD00A5A5A5009C9C9C008C848C004A4A4A00736B7300CECECE00F7F7
      F700FFFFFF00EFEFEF00E7E7E700C6D6C6006BAD6B009C9C9C00A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDB5BD00DEDE
      DE00FFFFF700DED6DE00D6CED600948C8C004A31210084422900844A3100734A
      310031216B000018EF001031FF001031FF000010E7004A4A8C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFF7EF00FFF7EF00FFF7EF00CE630000FFEFDE00FFEFDE00FFEFD600FFE7
      CE00FFE7CE00FFE7CE00FFE7BD00FFDEB500FFDEB500FFDEB500FFD6AD00FFD6
      AD00FFD6AD00CE630000FF00FF00FF00FF00FF00FF008484CE00104AC600005A
      E7000042DE003184EF00217BEF003963D6004A73DE003973EF00216BE7002973
      E700188CFF006BB5FF006B6BB5009C9C9C00ADADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00736B
      6B00CECECE00ADADAD00BDBDBD00D6D6D600DED6D600E7E7E700DEDEDE00DED6
      DE00D6D6D600CECECE00C6C6C600BDBDBD00B5B5B5009C9C9C007B7B7B00F7F7
      F700FFF7FF00EFE7EF00E7E7E700E7E7E700C6CECE009C9C9C009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CECECE00ADAD
      B500AD9CA50084523900B5733900E7C6AD00C6A58C008C4A1800C66B2100C673
      21005A316B001839F700739CFF006B8CFF000821DE005A639C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF009C9C9C009C9C
      9C009C9C9C00FFF7EF00FFF7EF00CE630000FFEFDE009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00FFD6
      AD00FFD6AD00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A63
      C6000052CE000052DE00005AE700086BEF00087BEF00298CE70021A5F7001094
      FF0052A5F7006373C600AD9C9C00DECEBD00BDB5B500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008C8C8C00BDBDBD00C6C6C600D6D6D600BDAD9400CEAD9400E7CEB500E7D6
      CE00EFEFE700EFEFEF00E7E7E700DEDEE700DEDEDE00D6D6D6005A5A5A009494
      9400B5B5B500CECECE00E7E7E700E7E7E700D6D6D6009C9C9C009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDC6006352
      5A0073422900C6732900DE842900DE944200F7CEAD00BD9C8400945A3100C69C
      8400B59CAD002129B5006B84EF005273E7001810A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFF700FFFFF700FFFFF700CE630000FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7CE00FFE7BD00FFDE
      B500FFDEB500CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AD9C
      9400736B84007373C6004A52AD00314AB5001052CE00106BDE003984DE006B73
      BD00634A8C00846B7300A5846300BD9C7300CEB59C00CECEC600FF00FF00FF00
      FF00FF00FF00E7CECE00D6BDC600E7DEDE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B5B5B500C6C6C600D6D6CE00BDA58C00C69C7300C69C7B00C6A5
      7300DEB59400E7C6AD00EFDECE00EFE7E700EFE7E700E7E7E700CECECE00B5B5
      B5009C9C9C006B636B00DED6DE00DEDEDE00D6D6CE009C9C9C00A59C9C00FF00
      FF00FF00FF00FF00FF00E7E7E700DEDEDE00DEDEDE008C8CB500312994001008
      7300392931009C5A2100D6844200E7944200DE9C5200EFD6BD00DED6CE00CEBD
      AD00C6845200AD6B5200734A6B006B4263005A314200FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7CE00FFDE
      B500FFDEB500CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C8C
      84009C8C8400E7E7E700DEDEDE00C6C6C600CEC6CE00CEC6CE00EFE7E700DECE
      CE00BDA5A500AD848400A57B7B009473730094736300B5949400C6A5A500B594
      9400B5949400CEB5B500DECECE00CEADB500E7DEDE00FF00FF00FF00FF00FF00
      FF00FF00FF0063636300C6C6C600D6D6D600BDA58C00C69C7300C69C7B00C69C
      7300CE9C7300CE9C7300CE9C7300CEA57300DEB58C00E7C6AD00E7DED600EFE7
      E700E7E7E7007B737B00E7E7EF00D6D6D600CEC6C6009C9C9C00A59C9C00FF00
      FF00FF00FF00CECECE00BDBDBD00C6C6BD007B7BAD000008BD000018FF000018
      F7000008B50039213100945A3100AD734200BD8C6300E7D6CE00DEDED600B594
      7B009C6B3100DE944A00E7944A00DE8C3900C6733100A58C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF009C9C9C009C9C
      9C009C9C9C00FFFFFF00FFFFFF00CE630000FFEFDE009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00FFE7
      BD00FFE7BD00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C8C
      8400A58C8400EFEFE700F7DEBD00EFEFDE00EFEFE700DEDEE700CEC6C600D6CE
      CE00DEDEDE00DECECE00D6BDBD00C6ADAD00C6A5A500C6A5A500AD8C8C00BDAD
      A500F7F7F700FFFFFF00FFFFFF00E7D6D600E7DEDE00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00C6C6C600D6D6D600BDA58C00C69C7300C6A57B00C69C
      7B00CE9C7300CEA57B00CEA57300CE9C7300CE9C6B00CE9C6B00D69C6B00DEB5
      8C00EFE7E70073737300BDB5B500A5A5A500ADA5AD009C9C9C00A59C9C00FF00
      FF00FF00FF00FF00FF00C6C6C600BDBDBD006363B5000018E700214AFF001842
      FF000021EF0039317300C6B5A500D6C6B500E7E7DE00C6B5A500B5948400E7DE
      D60094736300A5733900C6844A00D68C4200DE844200945239007B737300FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFE7CE00FFE7
      BD00FFE7BD00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C8C
      7B00A5948C00EFE7DE00EFBD7B00EFC68C00EFC69400F7D6AD00F7E7CE00EFEF
      EF00D6D6D600CEC6C600CEC6C600DED6D600E7E7DE00EFEFEF00DEDEDE00C6BD
      B500ADA59C00EFEFEF00FFFFFF00D6C6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00C6C6C600D6CED600BDA58C00C69C7300C6A57B00C69C
      7B00CE9C7300CEA57B00CEA57B00CE9C7300CE9C7300CE9C6B00CE946300D6AD
      7B00E7E7EF0073737300C6C6C600BDBDBD00B5B5B50094949400A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF006B73BD001029E7007BA5FF007394
      FF001029E7004A426B00D6B59C00EFE7DE00EFC6A500FFDEC600EFDECE00FFEF
      E700E7DEDE00B5A594009C7B63009C6B4200A56B390094523100634A4A00FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFE7
      CE00FFE7CE00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C84
      7B00A5948C00EFE7CE00DE841000D6943900DEAD6B00E7BD8C00E7C68C00EFC6
      8C00F7D6A500F7DEBD00EFE7DE00E7E7E700D6D6D600D6CEC600D6CECE00DEDE
      DE00E7DEDE00BDB5AD00EFE7E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00C6C6C600D6CED600BDA58C00C69C7300C6A57B00C69C
      7B00CE9C7300CEA57B00CEA57B00CE9C7300CE9C7300CE9C6B00CE946300D6AD
      7B00E7E7EF0073737300C6C6C600BDBDBD00B5B5B50094949400A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0021219C004A63DE00425A
      D60031299400AD8C7B00EFDED600DEB59400EFBD9400F7C69C00F7C69400F7C6
      9400FFDEBD00EFEFE700D6C6B500EFDECE00DECEC600BDA59400736B6B007B7B
      7B00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF009C9C9C009C9C
      9C009C9C9C00FFFFFF00FFFFFF00CE630000FFF7EF009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00FFE7
      CE00FFE7CE00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C84
      7B00A59C9400EFDEC600E77B0800E78C2100E77B0000DE840800DE8C2900DEA5
      5A00E7C69C00EFCEAD00EFC69400EFC69400EFD6AD00F7E7CE00EFEFE700E7E7
      E700E7E7E700BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00C6C6C600D6CED600BDA58C00C69C7B00C6A58400C6A5
      7B00C69C7300CEA58400CEA57B00CEA57B00CEA57300CE9C7300CE946B00D6AD
      8400EFE7EF0073737300CECECE00ADADAD00A59CA5009C949C00A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A56B5200A56B6B009C73
      7300C69C8C00E7DED600D6B59400E7C69C00EFCEAD00EFD6AD00EFD6AD00EFCE
      AD00EFCEA500FFE7D600B59C8C00AD845200EFAD7300EFB58C00CEB5B500DEDE
      DE00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFDE00FFEFDE00FFEF
      D600FFEFD600CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C84
      7B00AD9C9400EFD6BD00D6731800EFB57300D6730800DE730000DE730000DE7B
      0000E7841800E7A55A00EFC68C00E7C69C00E7C69C00E7C69400E7C68C00F7CE
      8C00EFE7DE00BDB5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00CEC6CE00D6CED600BDA58C00C69C7B00C6A58400C6A5
      8400C69C7B00CEA57B00CEA58400D6A57B00CEA57B00CE9C7300CE9C6B00D6AD
      8400EFE7EF007B737B00F7F7FF00EFEFEF00D6D6D6009C949C00A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AD735200EFA55A00DEAD
      7B00E7DECE00D6B59C00E7C6A500EFD6B500EFD6BD00EFDEBD00F7DEBD00F7D6
      B500EFD6AD00F7D6B500E7DECE00A57B6300D6945A00DE945200845A4A00A5A5
      A500FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE6B0000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFDE00FFEFDE00FFEF
      D600FFEFD600CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009484
      7B00AD9C9400E7CEB500C6630000CE731800CE630000D6731000D6731000D66B
      0000D66B0000DE7B1800EFA55A00EFBD7B00E7A55200DE944200E7AD7300E7AD
      6B00EFE7DE00BDB5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00CECECE00D6CED600BDA58C00C69C7B00CEA58400C6A5
      8400C69C7B00CE9C7300CEA58400D6A58400CEA57B00CEA57300CE9C6B00D6AD
      8400EFE7EF007B737B00EFEFEF00F7EFF700F7EFF700B5B5B500A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5735A00DEA56B00E7D6
      C600D6B59C00E7C69400EFD6B500F7DEBD00F7DEC600F7E7D600F7E7D600F7DE
      CE00F7D6C600EFD6AD00EFE7C600CEBDB5009C733900B57B4A0094737300FF00
      FF00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF009C9C9C009C9C
      9C009C9C9C00FFFFFF00FFFFFF00CE630000FFFFFF009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C00FFEF
      DE00FFEFDE00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009484
      7B00ADA59C00E7BDA500C6631800D69C6300C65A0000C6631000D6843900D684
      3900CE6B1000CE630000D6731000DE9C4A00E7AD6B00E79C4200DE841800E79C
      4200EFE7DE00BDB5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C848C00CECECE00D6CED600BDA58C00C69C8400C6A58400CEA5
      8400CEA57B00C69C7300CEA57B00CEA58400CEA57B00CEA57300CE9C6B00D6AD
      8400EFE7EF007B737B00EFEFEF00EFEFEF00EFEFEF00A59CA500B5B5B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A57B7B00E7CEBD00D6BD
      A500DEB58400EFCEAD00F7D6BD00F7DECE00F7EFDE00FFF7E700FFEFE700F7E7
      DE00F7DEC600EFD6B500F7CEAD00D6BDBD0031296B0021186300291852008C8C
      8C00FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFEFDE00CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009484
      7B00B5A5A500DEB59C00B5521000CE844A00B54A0000B54A0000C6632100D694
      5A00DE9C6300CE732900C65A0000C6630000D67B2900DE944A00DE8C4200DE94
      4A00E7E7DE00C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C8C8C00D6D6D600D6CED600BDA58C00BD946B00C6A58400C6A5
      8400C6A57B00C69C7B00CE9C7300CEA57B00CEA57B00CEA57B00CE9C6B00D6AD
      8C00EFE7EF007B737B00EFEFEF00EFEFEF00E7E7E700948C9400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEC6C600D6C6BD00DEA5
      7300F7C69400EFCEAD00F7D6BD00F7DECE00F7EFE700FFFFF700FFF7EF00F7EF
      DE00F7DECE00F7D6B500DEBDA5005242A5000010DE000010EF000008C6003931
      7300FF00FF00FF00FF00FF00FF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFF7E700CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009484
      7B00B5ADA500D6AD9400A5420800AD420800AD390000AD420000AD420000BD63
      2100D6946B00DEA57B00CE733900BD520000BD520000BD5A0800CE732100D694
      4A00EFDEDE00C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C8C8C00D6D6D600CECECE00C6C6BD00BDADA500B59C7B00B594
      7B00BD946B00C69C7300C69C7B00C69C7300CEA57B00CEA57B00CE9C6B00D6AD
      8C00EFE7EF007B737B00EFEFEF00E7E7E700ADADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C736300E7A5
      7300F7C68C00EFCEAD00EFD6BD00F7DECE00F7EFDE00FFF7EF00FFF7EF00F7EF
      DE00F7E7CE00EFD6B500BDA5A5000810CE000831FF001039FF000021F7000810
      9C00FF00FF00FF00FF00FF00FF00CE6B0000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CE630000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFF7E700CE6B0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009484
      7300BDB5B500DEBDB500C67B5A00C6846300AD5A3100AD4A2900A5421800A539
      08009C3900009C390800AD5A2100BD6B3900AD522100AD420000AD420000C673
      4200E7E7DE00C6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C8C8C00C6C6C600EFEFEF00DEDEDE00CECED600CEC6CE00CEC6
      C600C6B5A500BDA58C00B58C6B00B58C6B00BD946B00C69C7300CE9C7300D6AD
      8C00EFE7EF0073737300E7E7E700ADADAD009C9C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CECECE00C6B5B500A57B
      5A00EFBD8C00EFCEA500EFD6B500F7DEC600F7E7CE00F7EFDE00F7E7DE00F7E7
      D600F7DEC600EFD6AD00BDA5A5001018C6004A73FF0084ADFF00294AF7002118
      A500FF00FF00FF00FF00FF00FF00CE6B0000DE7B0000E77B0000DE7B0000DE7B
      0000DE7B0000DE7B0000DE7B0000DE7B0000DE7B0000E77B0000DE7B0000DE7B
      0000DE7B0000DE7B0000E77B0000E77B0000DE7B0000E77B0000DE7B0000DE7B
      0000DE7B0000CE630000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00947B
      7300C6BDB500EFEFE700E7D6CE00DEC6B500D6A59400C68C7300BD7B6300BD73
      4A00B5633900AD523100A54A2100A5421800A54218009C3900009C310000B56B
      4200E7E7E700C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF007B7B7B007B7B7B00ADADAD00E7DEE700EFEFEF00E7DE
      E700D6D6D600C6C6C600C6C6C600CEC6BD00BDB5A500BDA58C00B5845200C69C
      7300EFE7EF0073737300ADADAD00A5A5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B500EFEFEF00BDA5
      AD00946B5A00C69C7B00EFCEAD00EFD6B500EFDEC600F7DEC600F7DEC600F7DE
      BD00EFD6B500E7CEA500C69C7B0042318C003952DE006384E7002139CE007B7B
      B500FF00FF00FF00FF00FF00FF00CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000DEA56300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C73
      630094847300A5948C00BDB5AD00DED6D600E7E7E700EFEFEF00EFDEDE00E7CE
      C600DEB5A500D69C8400C6846B00BD735A00B56B4200B55A3900AD522900BD73
      5200E7E7E700C6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00847B8400736B73008C8C
      8C00B5B5B500D6D6D600DEDEE700DED6DE00CECED600D6CED600CEC6C600C6BD
      AD00DED6D60063636300A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A59CA500B5B5B500C6C6
      C600C6C6C6008C6B6B00BD9C8400DEBDA500EFCEAD00EFD6B500EFCEB500E7CE
      AD00DEB59C00AD847300845A5A008C8494008484C6007373BD007B7BAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00D6731000D6731000D6731000D673
      1000D6731000D6731000D6731000D6731000D6731000D6731000D6731000D673
      1000D6731000D6731000D6731000D6731000D6731000D6731000D6731000CE73
      0800D67B2100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00AD9C94009C847B0094847300948473009C8C8400AD9C9400C6B5B500D6D6
      CE00E7E7EF00EFEFEF00EFE7E700EFDED600E7C6BD00D6AD9C00CE947B00D69C
      8C00E7E7E700C6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00737373006B6B6B009C949C00C6C6C600CECECE00DEDEDE00D6CE
      D600C6C6CE006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00AD8C8400A5847300A57B7300A5847300A584
      7300A5848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A59C94009C847B00947B7300947B
      730094847B00A5948C00B5A5A500C6BDB500D6CECE00E7DEDE00EFEFEF00EFEF
      EF00E7DEE700C6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008C8C8C007B7B7B0084848400A5A5
      A500949494007B737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00A58C8C00947B73008473630084736B008C7B73009C8C
      7B00A5948C00C6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052AD520063B56300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004AA54A0063B56300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0052AD52000084000000840000188C180052AD520094CE
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B946B0039733900316B3100316B310039734200527B
      5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DED6C600F7D6C600EFC6C600DEBD
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000884080000840000008400000084000000840000008400000884
      08003194310052847300395A6300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0073A57300088C1000189C1800108C100018941800219C2100219C
      2100188C180008730800106B100021632900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00E7D6C600FFDEBD00F7CEC600F7C6C600F7C6
      C600F7C6C600F7CECE00CE9C9C0094636300A57B7B00B59C9C00BDADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052AD52007BA58400527363000084
      0000008400000884080029849C003184A5003184A5002984A50029739400296B
      8C00295A7300314A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00398C420021AD210021AD2100108C100029AD290039B5390039B5
      390042B542001894180031AD390029A531001884180010631000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094ADB500ADBDD60073A5
      C6005A84A5004A6B7B0052636B00FF00FF00FF00FF00FF00FF00429C42001894
      1800299C2900319C3100218C2100398C3900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7D6C600FFE7C600FFDEC600F7CEC600EFBDC600F7BD
      C600EFBDC600F7C6C600CE9494008C5A52008C5A5A008C5A5200945A5A00D6A5
      A500DEBDBD00E7C6C600DEC6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052AD52005A9C63004A9C52000084
      0000008400002194210031849C003184A5003184A5003184A5003184A5002984
      A5003184A5003184A50029739400184A6300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00318C310029AD290031B53100188C180042B539004ABD4A004ABD
      4A004AC64A00188C21004ABD4A0042BD4A0039AD3900188C1800107B1000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007394AD00849CB5008CBD
      DE0073ADD60073A5CE006B9CC6006394B5005A84A5004A738400319C310029A5
      290042B542004ABD520031A5310042B54200218C2100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFDEC600FFE7CE00FFE7C600FFE7C600F7CEBD00EFBDBD00EFBD
      BD00EFBDBD00EFBDBD00C69494008C5A5A008C5A5A008C5A5A008C5A5A00D6A5
      A500EFBDBD00EFBDBD00F7BDC600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00188C18000084000008840800008400000084
      00000884080063AD7300398CA5003184A5003184AD003184A5003184A5002984
      A5003184A5003184A5003184AD00216B8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00318C390039B5310042B54200218C21004ABD520052C652005AC6
      5A005ACE5A00218C21005AC65A0052C6520039AD3900299C2900299C29004A52
      1800734231007B524200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084A5BD007394A50094C6
      E7007BB5D6007BADD60073ADD60073ADCE0073A5CE006BA5C60042A542004ABD
      4A0063CE630063CE630042A542005ABD5A0039A5390073733100C6734A00BD73
      5200AD6B52009C7B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFDECE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00F7C6BD00EFB5B500EFB5
      B500EFB5B500EFB5B500C69494008C5A52008C5A5A008C5252008C5A5A00D6A5
      A500EFB5B500EFB5B500EFBDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000840000008400000084000000840000008400002194
      210073B58400428CA5003184A5003184A5003184A5003184A5003184A5003184
      A5003184A5003184A5003184A500216B8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00398C390042BD42004ABD4A0042AD420063C6630063CE63006BCE
      6B006BCE6B00218C21006BCE6B0063CE630042A5420039A5390031A531007B6B
      2900AD5A3900DE7B5200DE7B5200C66B420094523100945239006B4A3900FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094B5CE0063849C009CC6
      E70084B5DE0084B5DE007BB5DE007BB5D6007BADD60073ADCE005AAD5A006BCE
      6B0084D67B0073BD6B008CB5730073CE730052B55200947B4200E7946B00CE84
      5A00DE8C6300BD6B4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      CE00FFEFD600FFE7D600FFE7D600FFE7D600FFEFD600EFC6BD00E7B5B500E7B5
      B500E7B5B500E7B5B500C69494008C5A5A008C5A5A008C5A5A008C5A5A00D69C
      9C00E7B5B500E7B5B500EFB5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0042A5420000840000399C3900319C3100319442009CC6BD0084B5
      C6005A9CBD003184A5003184A5003184A5003184A5003184A5003184AD003184
      A5003184AD003184A5003184A500216B8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF004A944A004ABD4A005AC65A0063CE630073CE730073D6730084D6
      7B004AAD4A00317B21006BC66B0073D6730042A542004AB54A00319C3100846B
      2900C6734A00E78C6300E78C6300CE7B5200C6734A00E78C5A00AD5A39008C4A
      3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009CBDCE006384A500ADCE
      EF0084BDDE0084BDDE0084B5DE0084B5DE0084B5DE007BB5D60063A5840073CE
      73007BCE7B009CC6AD0094BDAD0084CE840063AD5200CE946B00EFA57B00BD84
      7300DE947300CE846300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEF
      D600FFE7D600FFEFD600FFE7D600FFEFD600FFEFD600EFC6BD00E7ADAD00E7AD
      AD00E7ADAD00E7ADAD00C68C8C008C5A52008C5A5A008C525200945A5A00CE9C
      9C00E7ADAD00E7ADAD00E7B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0008840800008400006BADB50084BD9C00108442003984AD004A94
      B500529CBD003184A5003184A500297BA5003184A5003184A5003184A5003184
      A5003184A5003184A5003184A500216B8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007BAD7B0042AD420063CE630073D66B007BD67B0084DE84007BCE
      7B0052944200CECEA500429C420084DE84006BCE73006BCE6B00298C29009C6B
      3900CE7B5A00EF946B00E79C7300BD735200D6846300EF946B00B5634200DE84
      5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5C6D6005A84A500ADCE
      E7008CBDE7008CBDDE0084BDDE0084BDDE0084BDDE0084B5DE00A5C6D6005AAD
      6B0052946B0084ADC6009CB5AD006BAD6B007B946B00DE9C7B00D69C8C00ADB5
      B500D6A58C00C68C7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00EFC6BD00E7ADAD00E7AD
      AD00DEADAD00E7ADAD00C68C8C00945A5A008C5A5A00945A5A008C5A5A00CE9C
      9C00DEADAD00E7ADAD00E7ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00399C39000084000073BD73006BB56B00087B21002184630084C6
      840063AD6300298C6B002973940021638C00216B8C00216B940029739C00297B
      9C003184A5003184A5003184A500216B8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00319C31006BD66B007BD67B008CDE8C008CDE8C004294
      3900DEDEC600FFEFDE004A9442008CDE8C0084DE840073D67300397B1800D68C
      6300E7947300EFA57B00F7A58400A5634A00DE8C6B00EF9C7B00AD634200E78C
      6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADC6DE005284A500ADCE
      E7008CBDE7008CBDDE008CBDDE008CBDDE008CBDDE0084BDDE0084BDDE0073AD
      C6002184CE00218CE7002184CE006B94940094B5CE00AD9C94006B849400739C
      B5009C847B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFF7
      E700FFEFE700FFEFE700FFEFE700FFEFDE00EFE7DE00E7BDB500DEA5A500DEA5
      A500DEA5A500DEA5A500C68C8C008C5A5A008C5A5A008C5252008C5A5A00CE94
      9400DEA5A500DEA5A500DEA5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000840000008400000084000000840000008400000084
      00000084000039946B005A9CBD005A9CBD00529CBD004284AD00296B9400216B
      9400216B940029739400297B9C00216B8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00318431006BCE6B0084DE840094E794005AAD5A00A5C6
      9C00FFFFF700FFFFF70073AD6B0084D684008CDE8C0052AD52007B7B3900EF9C
      7B00F7A58400F7AD8400D69473009C736B00AD735200F7AD8400CE845A00D684
      6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5C6DE004A84A500B5D6
      E7008CC6E7008CBDE7008CBDE7008CBDDE008CBDE7008CBDE7008CBDDE0063A5
      DE0039A5FF0042A5FF0039A5FF004A8CBD008CB5D6007BADCE006BA5D6006BA5
      D6005A8CAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFF7
      E700FFF7E700FFF7E700F7EFE700ADBDCE00527BAD007B7BAD00D69CA500DEA5
      A500DE9CA500DEA5A500C6848C00945A5A008C5A5A008C5A5A008C5A5A00CE8C
      8C00DE9CA500DEA5A500DEA5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF005AAD5A00319C310008840800008400002194210042A5
      42005AAD5A009CBD9C00B5BDBD0084ADBD0073A5BD006BADCE006BADCE00639C
      C600528CB500397BA500296B940018527300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0042A542008CDE8C0073C673006BA55A00F7F7
      E700FFF7EF00FFF7F7008CB5840084CE840084D6840021731800C6845A00F7A5
      8400F7AD8C00F7B59400A5735A00D6CECE00A57B6B00F7AD8C00F7AD8400AD6B
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5C6DE004A84AD00BDD6
      E70094CEEF008CC6EF008CC6E7008CC6E7008CBDE7008CBDE7008CBDDE004AA5
      DE004AB5FF0052B5FF004AB5FF00529CCE00A5C6DE007BB5DE0084BDEF0084BD
      EF00639CC600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFF7
      EF00F7EFEF00B5C6D6006384B5003963AD00426BAD00426BAD007B7BAD00D69C
      9C00D69C9C00D69C9C00D6949400BD848400B57B7B00AD7373009C6B6B00CE8C
      8C00D69C9C00D69C9C00DE9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF004A8CAD00318CAD0008843100107B31006B8C9400DEDE
      DE00CEC6CE00CEC6C600CEC6CE00C6C6C600C6C6C600C6C6C600D6CED6008484
      840010395A00185A840031739C005A9CBD00527B9400395A6B0029313900FF00
      FF00FF00FF00FF00FF00FF00FF005A9C5A00429C42003184310094ADA500639C
      AD0073A5AD00BDBDBD0094AD73006BB56300318C3100FF00FF00AD6B5200F7AD
      8400FFB59400BD7B6300DED6CE00F7F7F700BDA59C00EFA58C00EFA584009463
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5CEE7004A8CAD00ADCE
      DE00A5D6F70094CEEF0094CEEF0094CEEF008CC6EF008CC6E7008CC6E70063AD
      DE005AC6FF006BCEFF005AC6FF006BA5C600A5CEE7007BB5DE0094CEFF0094CE
      FF006B9CC600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDCE
      DE006384BD00426BAD00426BAD004A6BB5004A6BB5004A73B5005273BD007B84
      AD00CE949400D6949400D6949400D6949400D6949400D6949400D6949400D694
      9400D6949400D6949400DE949400ADA5BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00636B7300318CAD003184A50029849400104A5A00636B7300E7DE
      E700D6D6D600CECECE00CEC6CE00C6C6C600CECECE00CEC6CE00D6D6D6008484
      840008395A00085273004284A50084C6E7004A525A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008CB59400106B7B00107BC600187B
      D600187BCE001073BD0018736300397B3900FF00FF00FF00FF00FF00FF00D68C
      6B00C68C6B00A5948C00CED6DE00DEDEE700C6ADA500DEA58400B57B6300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5CEE70063A5C6007BA5
      BD00CEE7FF009CD6F70094D6F70094CEF70094CEEF0094CEEF0094C6EF009CCE
      E7005ABDE7007BE7F7005AB5D6008CBDD6008CBDDE0094C6DE008CBDDE008CBD
      DE00A5C6DE00526B7B00FF00FF00FF00FF00FF00FF00FF00FF006384B500426B
      AD00426BAD004A73B5004A73B5005273B5005273BD00527BBD005A7BBD005A84
      C600848CB500CE949400D6949400D6949400D6949400D6949400D6949400D694
      9400D6949400D69494009C84AD00B5CEEF00FF00FF00FF00FF00FF00FF00FF00
      FF00636B73004A84A5003184A5002984A500185A840000315200636B7300E7E7
      E700D6D6D600CECECE00C6C6C600CEC6CE00CECECE00CEC6CE00D6D6D6008C84
      8C0010426300397BA50084C6E7009CDEFF006B94AD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005294BD001884DE002994EF002994
      F7002994F7002994F700107BC6004A6B8400FF00FF00FF00FF00FF00FF00C6AD
      9C005A525A003173A5002973A500317BAD0063737B0094635200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5CEEF007BB5D6005294
      B50073A5BD00ADC6DE00C6DEEF00CEE7FF00B5DEFF009CD6F70094CEF70094CE
      EF00ADD6EF008CBDDE009CCEE7008CC6E7008CBDE7008CBDE7008CBDE7008CBD
      DE008CBDDE005A7B9400FF00FF00FF00FF00FF00FF00FF00FF004A73B5004A73
      B5005273B500527BBD00527BBD005A7BBD005A84C6006384C600638CC600638C
      CE006B8CCE008C94BD00CE8C8C00D68C8C00CE8C8C00D68C8C00CE8C8C00D68C
      8C00CE8C8C007B7BAD009CB5E700FF00FF00FF00FF00FF00FF00FF00FF00636B
      6B00528CAD00318CAD002984A5001863840008426B00003152006B6B7300E7E7
      E700CEC6CE00CECECE00CECED600CEC6CE00C6C6C600C6C6C600DED6DE008C84
      8C00426B840084C6E700A5DEFF009CDEFF009CDEFF006B94AD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00187BC600319CFF00319CFF0039A5
      FF0039A5FF0039A5FF00319CFF0018639C00FF00FF00FF00FF00FF00FF00FF00
      FF00397BAD006394CE006B9CCE00639CCE003984B5005A737B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009CC6EF008CBDE7007BB5
      D6006BADCE00639CBD005294B5005A94B50084ADCE00ADC6DE00C6DEEF00C6E7
      F700ADDEF7009CCEF70094CEEF0094CEEF008CC6EF008CC6E7008CC6E7008CBD
      E7008CBDE700739CBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A7B
      BD005A7BBD005A7BBD006384C6006384C600638CCE006B8CCE006B94CE007394
      D600739CD6007B9CDE00949CC600CE8C8C00CE848400CE8C8C00CE8C8400CE84
      8C006373B5009CB5E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00424A
      5200425A6B003152630042849C0029739400186B8C00084263006B737B00E7E7
      E700CECECE00D6CECE00D6D6D600C6C6C600C6C6C600CECECE00DEDEDE008C8C
      8C006B94B5009CDEFF009CDEFF009CDEFF00A5DEFF009CDEFF00526B7300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF003194EF0039A5FF0042ADFF0042AD
      FF0042ADFF0042ADFF0042A5FF00187BC600FF00FF00FF00FF00FF00FF005A9C
      BD0073A5DE007BADDE0073ADDE0073ADE70073ADDE00296B9400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094CEEF008CC6EF008CC6
      EF008CC6E7008CBDE70084BDDE007BB5D60063A5CE005A9CBD005294B500639C
      BD008CB5CE00ADCEDE00BDDEEF00BDDEF700ADD6F7009CCEEF008CC6EF008CC6
      EF008CC6E70084B5D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00638CCE00638CC6006B8CCE006B94D6007394D6007394D6007B9CD6007B9C
      DE0084A5DE0084A5E70084ADE7009CA5D600C68C8C00CE848400BD848C00526B
      BD009CBDE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00639CB5005AA5C6005A9CBD0039739400737B8400F7EF
      F700E7E7EF00DED6DE00CEC6CE00D6CED600D6D6D600CECECE00DEDEDE008C8C
      8C0073A5BD009CDEFF00A5DEFF009CDEFF009CD6FF0063849C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005294BD0042ADFF0042ADFF004AB5FF004AB5
      FF004AB5FF004AB5FF004AADFF002184CE00FF00FF00FF00FF00FF00FF004A94
      C6007BB5E7007BB5EF0084B5EF007BB5EF0084B5E700317BAD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BDCED6009CCEF70094CEEF0094CE
      EF0094C6EF0094C6EF0094C6EF0094C6E7008CC6E70084BDE70084BDDE0073B5
      D60063A5C6005A9CBD005A94B5006394B5008CADC600ADC6DE00BDD6EF00BDDE
      F700A5D6F70094C6E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00739CD6007394D600739CDE007B9CDE007BA5DE0084A5DE0084AD
      E7008CADE7008CADEF0094B5EF0094B5F700A5ADDE00AD8494003963CE00ADBD
      E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006BADC6005AA5BD0063A5BD004A849C00525A6300D6D6
      D600EFE7EF00EFEFEF00F7F7EF00E7DEE700DED6DE00CECECE00DEDEDE008C8C
      8C0073A5BD009CDEFF00A5DEFF009CDEFF006B8CA500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF004A94BD004AADFF004AB5FF0052BDFF0052BD
      FF0052BDFF0052BDFF0052B5FF002184CE00FF00FF00FF00FF00FF00FF00529C
      CE0084BDEF008CBDF7008CBDF7008CBDF70084BDEF003984B500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CEDEEF009CD6F70094CEF70094CE
      F70094CEF70094CEEF0094CEEF0094CEEF0094C6EF0094C6EF0094C6EF008CC6
      EF008CC6E7008CBDE70084BDDE0073B5D600639CC6005294B5005A8CAD006373
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0084A5E70084A5E70084A5E7008CADEF008CADEF008CB5
      EF0094B5F70094B5F7009CBDF7009CBDFF00A5C6FF0094B5EF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0063A5C60063A5C60063A5BD005A9CBD00396B84002142
      4A00394A52006B6B73009C9C9C00E7E7E700EFEFEF00EFEFEF00EFEFEF00948C
      94007BA5BD009CDEFF00A5DEFF00A5DEFF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005A9CBD004AB5FF0052BDFF005AC6FF0063C6
      FF0063CEFF005AC6FF0052BDFF00217BAD00FF00FF00FF00FF00FF00FF005A9C
      CE008CBDF70094C6FF0094CEFF0094CEFF008CC6F700397BA500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C6DEEF009CD6FF009CD6F7009CD6
      F70094D6F70094D6F70094CEF70094CEF70094CEF70094CEEF0094CEEF0094C6
      EF0094C6EF0094C6EF0094C6EF008CC6E7008CC6E70084BDE7007BBDDE005A6B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094B5EF008CADEF0094B5F70094B5F7009CBD
      F7009CBDF700A5C6FF00A5C6F700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0063A5C60063A5C60063A5BD0063A5BD0063A5BD00639C
      C6005A94AD004A849C00426B8400424A52006B6B6B00ADA5AD00D6D6D6008484
      84007BA5BD009CDEFF009CDEFF006B94A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0039A5E70063C6FF006BCEFF006BD6
      FF0073D6FF006BD6FF0052BDEF00427BA500FF00FF00FF00FF00FF00FF00529C
      C6008CC6FF009CCEFF00A5D6FF009CD6FF007BB5EF006394AD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BDDEF7009CDEFF009CDEFF009CDE
      FF009CD6FF009CD6FF009CD6F70094CEF7007BA5BD007394AD007BADCE008CBD
      E70094CEEF0094CEEF0094CEEF0094CEEF0094C6EF0094C6EF0084B5D600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009CBDF7009CBDF7009CBDFF00A5C6
      FF00ADC6EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005A6373005A7384006B94AD00639C
      BD00639CBD0063A5C60063A5C6005A9CBD004A5A6300FF00FF00FF00FF006B6B
      6B006B9CAD00638CA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00318CBD005AC6F70073DEFF0084EF
      FF0084EFFF007BDEFF00318CBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00529CCE009CCEF700B5DEF7009CCEEF004A94B500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF006B7B84007394AD0084BDD60094CE
      EF009CD6F7009CDEFF009CDEFF00739CBD00FF00FF00FF00FF00FF00FF00FF00
      FF006B7B8C006B94A50084B5CE008CC6E70094CEEF0094CEEF0073A5BD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADCEFF00ADC6EF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006B7B8400526B7B004A7B9400528CA500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00318CBD005AC6E7007BE7
      F70073DEEF003994BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0073ADCE006BA5C6007BADC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00637384006B94AD00739CB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00637B8C006B8CA500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005A5A5A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF004A6B520029633900187331001084310010A5
      420039BD6B006BCE9C0063B58C005294730039634A004A5A4A005A635A007B7B
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007B847B004A6B5200296339001873
      31001084310010A5420039BD6B006BCE9C0063B58C0052947300397352003963
      4A004A5A4A005A635A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0063947300638C7300738C7B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00527B5A00317B4A00398452004A7B6300637B
      6B00738C7B00949C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A6B5A00395A3900186B3100089C3900109C3900189439001894390008A5
      390039B563005ABD840052B5730052AD6B0063C6940063C6940052A57B004273
      5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00848C84005A6B5A00395A3900186B3100108C3100089C3900109C39001894
      39001894390008A5390039B563005ABD840052B5730052AD6B0063BD840063C6
      940063C6940052A57B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A8C
      5A0031844A00218C4200219C4A004AAD73005AA57B0052946B00528C6B00638C
      7300738C7B0084948C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00317B4A00217B390018843900108C390010A5420042BD730063C68C004A9C
      6B004A946B00528C6B0052846B00637B6B00737B7300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0039633900106B2900107B
      2900088C3100109C3900109C39001094310010A5390008A5390010A53900189C
      3900219C4A0052B5730052BD84005AC68C0052AD730052AD73004AB573005ABD
      8400FF00FF00FF00FF00AD848400A57B7B009C7B7B007B8C7B0039633900106B
      2900107B2900088C3100109C3900109C3900189431001094310010A5390008A5
      390010A53900189C3900219C4A0052B5730052BD84005AC68C0052BD840052AD
      730052AD73004AB57300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF004A845A0031844A0021843900188C39001094
      3900109C3900109C390021A5420042B56B0052B57B0052B57B0052B57B005AAD
      7B0052A5730052946B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF007B947B00528C630039845200297B420018843900108C
      310010943100109C3900109C3900109C3900189C390039AD5A0052B57B005ABD
      84005ABD84005AB5840052AD7B004A9C6B004A8C6300FF00FF00FF00FF00FF00
      FF00AD848400A57B7B009C847B00FF00FF00105A2900108C3900108C39001094
      310010A5390008A5390008A539001094310010AD390008B5420008C6520008DE
      5A0008EF7B0031F7940042EF94005ADE940042B573004AA563005AAD7B005ABD
      8400FF00FF00FF00FF00E7B5A500E7B5A500DEAD9C00105A2900108C3900108C
      39001094310010A5390008A5390008A53900109C39001094310010AD390008B5
      420008C6520008DE5A0008EF7B0031F7940042EF94005ADE940052CE840042B5
      73004AA563005AAD7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00217B39001084310010943100109C3900109C3900109C390010A5
      390008B5420008C64A0010CE5A0029D6730042D684004ACE84004AC67B004AB5
      73004AB5730052BD7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00187B31001084310010943100109C390010A53900109C
      39001094310010A5390008AD420008BD420010C6520021CE6B0042D68C0052CE
      8C004ABD7B004AAD6B0052AD73005ABD84005AB57B00FF00FF00FF00FF00FF00
      FF00E7B5A500E7B5A500CEA59400A57B7B000863210010A53900089C3900109C
      3900109C3900109C390008B5420000E7630000F76B0000FF730000FF730000F7
      7B0000E7730018CE630010C66B0018CE6B0021F7940029F7940031E7840031CE
      7B00FF00FF00D6B5B500F7C6AD00FFD6AD00FFD6AD000863210010A53900089C
      3900109C3900109C3900109C390008B5420000CE5A0000E7630000F76B0000FF
      730000FF730000F77B0000E7730018CE630010C66B0018CE6B0018DE7B0021F7
      940029F7940031E78400FF00FF00FF00FF00FF00FF00849494006B7B7B006B7B
      7B0031734A001094390008A5390008AD420008AD420008B54A0008C6520000CE
      5A0000DE630000DE6B0010CE6B0021C66B0031BD730039BD7B0031C67B0029CE
      7B0031CE730039B57300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B
      7B007B7B7B007B7B7B00109C3900109C3900109C3900109C390008A5420008BD
      4A0000CE520000DE5A0000E7630000EF6B0000EF730008E7730021D6730029D6
      7B0029DE840031DE840039D6840039C67B0042B57300FF00FF00FF00FF00D6B5
      B500F7C6AD00FFD6AD00F7CEA500B58C8400105A210010AD420008C6520000DE
      5A0000EF6B0000DE6B0000C6630008B55A0008BD5A0008C6630010B563002152
      42004A5A52006B736B00848484007B8C8400395A420018A5520010B55A00319C
      5A00FF00FF00D6ADAD00F7C6AD00FFD6AD00FFD6AD00105A210010AD420008C6
      520000DE5A0000EF6B0000DE6B0000C6630000BD5A0008B55A0008BD5A0008C6
      630010B56300215242004A5A52006B736B00848484007B8C8400636B6300395A
      420018A5520010B55A00FF00FF00FF00FF007B94940042848400428484004284
      840029734A001094390008B5520008CE5A0010B55A0021A55A0039AD6B0042B5
      7B0031B57300218C5A003963520052736300637B73006B84730052736300428C
      630052B57B0073BD9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B
      7B007B7B7B007B7B7B00109C3900109C3900109C3900109C390008A5420008BD
      4A0000CE520000DE5A0000E7630000EF6B0000EF730008E7730021D6730029D6
      7B0029DE840031DE840039D6840039C67B0042B57300FF00FF00FF00FF00D6AD
      AD00F7C6AD00FFD6AD00F7D6AD00C69C8C00316B39001884420010A5520008C6
      5A0010C6630021634200526B5A00A59CA500ADADAD007B8C8400424A4A00424A
      4A005A5A5A005A5A5A006B6B6B00736B7300636363006B6B6300FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6B500FFD6B500FFDEB500316B39001884420010A5
      520008C65A0010C6630021634200526B5A008C848400A59CA500ADADAD007B8C
      8400424A4A00424A4A005A5A5A005A5A5A006B6B6B00736B73007B737B006363
      63006B6B6300FF00FF00FF00FF00639C9C004284840042848400428484004284
      8400397B6B004ABD9C006BC6940052AD730042735A0052635A00737B7B008C94
      94007B84840042524A00525252007373730084848C008C8C8C00737373007373
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00397B39002994
      2900319C310042A5420010AD420008C64A0000D65A0000D6630000C65A0000BD
      5A0008BD5A0000C6630000CE630008BD630021734A00427B5A005A8C73005A8C
      7300427B5A00219C5A0018BD630029A563004A9C6B00FF00FF00FF00FF00D6AD
      AD00F7C6B500FFD6B500FFDEB500EFCEAD00C6A58C00EFF7E700CED6CE00A5BD
      AD00737B730042424A005A525A00848484008C848400736B6B004A4242004A4A
      4A00736B7300948C9400A5A5AD00A5A5AD0063636B008C848400FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6B500FFDEB500E7D6AD00DECE9C00EFF7E700CED6
      CE00A5BDAD00737B730042424A005A525A006B6B6B00848484008C848400736B
      6B004A4242004A4A4A00736B7300948C9400A5A5AD00A5A5AD008C8C94006363
      6B008C848400FF00FF00FF00FF00FF00FF004284840042848400428484004284
      84004284840073E7E7008CEFEF005A8484006B6B6B00636363008C8C8C00A59C
      A5009494940052525200524A4A007B73730094949400949494006B6B6B007B7B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00219C210021A5210031B5
      310042BD42004AC64A00188C420008B5520008C6630010A55200317352006B84
      73008C9C940094ADA50073948400395A4A00424A4A005A5A5A00636363007373
      73006B6B6B00636B6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6AD
      AD00F7C6B500FFDEB500DECE9C00CEC69C00D6C69C00DECEAD00F7DEBD00FFE7
      CE00B5BDB5004A424A006B6B7300ADADAD00B5B5B5009C9C9C0052525A003939
      3900635A5A00847B8400A5A5A5009C9C9C004A4A4A00948C8C00FF00FF00FF00
      FF00FF00FF00DEB5AD00F7CEB500844200008400000084000000840000008400
      000084000000B5BDB5004A424A006B6B73008C8C9400ADADAD00B5B5B5009C9C
      9C0052525A0039393900635A5A00847B8400A5A5A5009C9C9C007B7373004A4A
      4A00948C8C00FF00FF00FF00FF00FF00FF004A84840042848400428484004284
      840063C6C6007BFFFF007BFFFF004A7B7B00736B73005A5A5A007B7B84009494
      94008C848400524A5200635A5A008C8484009C9C9C00949494007B737B00847B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0021A5210031B5310042BD
      42005ACE5A0063CE6300DEEFDE00BDCEBD008CA594005A636300524A52006363
      63007B7B7B008C8C8C007B7373004A424A00524A4A0073737300949494009C94
      9C00737373007B737B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      AD00F7CEB5000084840000848400008484000084840000848400008484000084
      8400B5B5B500423939005A525A0094949400A59C9C00847B84004A424A004A4A
      4A00635A6300847B84008C8C8C008C8C8C005A5A5A00847B7B00FF00FF00FF00
      FF00FF00FF00DEB5B500EFCEB500840000008400000084420000844200008442
      0000FF840000B5B5B500423939005A525A007B7B840094949400A59C9C00847B
      84004A424A004A4A4A00635A6300847B84008C8C8C008C8C8C00737373005A5A
      5A00847B7B00FF00FF00FF00FF00FF00FF00FF00FF005A948C004A848400397B
      84006B9CAD0084ADC60084ADAD004A7B840073737300635A5A00737373008484
      84008484840063636300736B7300B5A59C00C6B5AD00C6B5B500ADA5AD00ADAD
      AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0039B5390052CE
      520073D6730073CE7300FFFFFF00CEE7C60073A56B00848484005A5A5A007B7B
      8400A5A5A500B5ADB5009C9C9C0052525200424242006B6363008C8C8C008C8C
      8C005A5A5A007B737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500EFCEB5000084840000FFFF0000FFFF0000FFFF0084FFFF0000FFFF000084
      8400B5BDBD00424242005A52520073737B007B7B840073737300525252006B63
      6B00C6C6C600E7DEDE00E7E7E700E7DEDE008C7B8400948C8C00FF00FF00FF00
      FF00FF00FF00DEB5B500F7CEBD0084420000840000008442000084420000FF84
      0000FF840000B5BDBD00424242005A5252006363630073737B007B7B84007373
      7300525252006B636B00C6C6C600E7DEDE00E7E7E700E7DEDE00D6C6CE008C7B
      8400948C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002984
      B5001884D6001884DE001884C6005A8494007B737B007B7B7B009C9C9C00ADA5
      AD00A59C9C00737373007B524200A54A2100C67B4A00D69C7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0039AD39005AC6
      5A006BCE6B005AAD5200F7F7F700DEE7CE0094B58C007B7B7B004A4A4A006B6B
      6B008C848C0094949400847B84004A4A4A005A525A00847B7B009C949C009494
      9400737373007B737B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7CEBD000084840000FFFF0000FFFF0084FFFF0084FFFF0000FFFF0000FF
      FF00A5A5A500424242006B6B6B008C8C8C0094949C008C949400737373004239
      4200736B6B007B6B6B00736B6B00736B6B00B5B5B500FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5B500F7D6C600E7DEBD00840000008400000084420000FF84
      0000C6D6C600A5A5A500424242006B6B6B00848484008C8C8C0094949C008C94
      94007373730042394200736B6B007B6B6B00736B6B00736B6B008C848400B5B5
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AADE7002994
      F700299CFF00319CFF002994F7005A9CD6009C9CA500A59C9C00B5ADAD00BDB5
      B500B5ADAD00948484009C522900732100008431080094391000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063BD
      5A0039A54A0073A584009CB5C6009CB5A5007BA584007B7B8400525252006B63
      6B0073737B00848484007B7B7B005A5A5A0063636300B5ADAD00BDB5B500BDB5
      B500A59CA500A59CA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7D6C600E7DEBD000084840000FFFF0084FFFF0084FFFF0000FFFF000084
      8400948C940052525200948C8C00CEC6C600C6BDBD00ADA5A5007B737B005242
      4200DED6D600E7DEDE00BDB5B500C6B5B500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5B500F7D6C600FFEFD600CED6B50084000000217B9C00318C
      C600428CB500948C940052525200948C8C00B5ADB500CEC6C600C6BDBD00ADA5
      A5007B737B0052424200DED6D600E7DEDE00BDB5B500C6B5B500FFFFFF00DEC6
      C600BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00319CEF00319C
      FF0039A5FF0039A5FF0039A5FF0042A5EF007BA5C600C6C6C600D6D6D600D6D6
      D600D6D6D600D6CECE00BD8C7B006B1800006B1800008C391800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00217B7B00107BC6001884D600187BB5004A8484007B737300636363008C8C
      8C009C9C9C00A5A5A5009C9C9C0073737300524A4A00A5949C009C949400A59C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBD
      B500F7D6C600FFEFDE004294D6002994F700319CFF002994F7004A9CD600D6DE
      E700FFF7EF00F7F7F700CEC6C600B5B5B500C6BDBD00C6C6C600CEC6C600EFE7
      E700FFFFF700FFFFFF00FFFFFF00DEC6BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00DEBDB500F7D6C600FFEFDE00CED6D6004294D6002994F700319C
      FF002994F700F7EFF700847B7B00948C8C00ADA5A500B5ADAD00B5ADAD00A5A5
      A5007B7373008C848400FFFFFF00FFFFFF00FFFFF700FFFFFF00FFFFFF00DEC6
      BD00BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00429CDE0039A5FF0042AD
      FF0042ADFF0042B5FF0042ADFF0039A5F7005294BD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00B57B5A00AD734A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00298CE700299CF7002994F7002994EF005A9CCE009C9494007B7B7B00A59C
      9C00BDB5B500BDB5B500ADA5A5007B73730084737B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      B500F7D6CE00FFEFDE003194EF0039A5FF0042A5FF0039A5FF00429CEF00ADCE
      DE00FFFFF700FFFFFF00FFE7E700FFDEC600FFDECE00FFE7D600FFE7DE00FFEF
      DE00FFEFE700FFFFF700FFFFFF00DEC6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500F7D6CE00FFEFDE0094BDD6003194EF0039A5FF0042A5
      FF0039A5FF00429CEF00F7F7F700CEC6C600C6BDBD00B5B5B500C6BDBD00C6C6
      C600CEC6C600EFE7E700FFE7DE00FFEFDE00FFEFE700FFFFF700FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF003194E70042ADFF004AB5
      FF004ABDFF004ABDFF004ABDFF004AB5F70052A5D600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003994
      DE00299CFF00319CFF0031A5FF0031A5FF004AA5F700FF00FF00FF00FF00B5AD
      AD00B5B5B500BDB5B500BDB5B500ADA5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      B500FFD6D600FFEFE70042ADFF004AB5FF0052B5FF004AB5FF004AADF7009CC6
      DE00FFFFFF00FFFFFF00FFF7F700FFEFE700FFE7DE00FFE7D600FFDECE00FFDE
      CE00FFDECE00FFF7EF00FFFFFF00DEC6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500FFD6D600FFEFE7005A9CCE0042ADFF004AB5FF0052B5
      FF004AB5FF004AADF7009CC6DE00FFFFFF00FFFFFF00FFF7F700FFEFEF00FFEF
      E700FFE7DE00FFE7D600FFDECE00FFDECE00FFDECE00FFF7EF00FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00298CD60042ADF7004AB5
      F7004AB5F7004AB5F7004AB5F7004AADEF0063A5CE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6A57B00C67B5A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063A5CE00319C
      EF0039A5FF0039A5FF0039ADFF0039A5FF0031A5FF00428CBD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      BD00FFDED600FFF7E7004AADFF0052B5FF004AB5F7004AADF70052ADEF009CCE
      E700FFFFFF00FFFFFF00FFF7F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFF
      F700FFF7F700FFFFFF00FFFFFF00DEC6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDBD00FFDED600FFF7E7004A9CCE004AADFF0052B5FF004AB5
      F7004AADF70052ADEF009CCEE700FFFFFF00FFFFFF00FFF7F700FFEFEF00FFF7
      F700FFFFF700FFFFFF00FFFFFF00FFFFF700FFF7F700FFFFFF00FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF002973B5002184C6003994
      D600429CD6003994CE002984C6002984BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6A58400A5522100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003994D60039A5
      F70042ADFF004AB5FF004AB5FF004AB5FF0042ADFF002984C600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      BD00FFDED600FFF7EF00398CCE004A9CD60052A5DE004AA5DE004A94CE00BDD6
      E700FFFFFF00FFFFFF00FFEFE700FFD6BD00FFD6BD00FFD6BD00FFD6C600FFDE
      CE00FFE7D600FFF7F700FFFFFF00DECEC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDBD00FFDED600FFF7EF006B9CC600398CCE004A9CD60052A5
      DE004AA5DE004A94CE00BDD6E700FFFFFF00FFFFFF00FFEFE700FFD6C600FFD6
      BD00FFD6BD00FFD6BD00FFD6C600FFDECE00FFE7D600FFF7F700FFFFFF00DECE
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004294C6006BB5
      DE008CC6EF0073BDEF004AA5D6004A8CB500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009C4A2900BD6B4200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002994DE0042AD
      FF004AB5FF0052BDFF0052BDFF0052BDFF004ABDFF00399CD600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD
      BD00FFDEDE00FFFFF7005A9CCE0084BDDE008CBDE70063ADDE007BB5CE00EFF7
      F700FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00FFEFE700FFEFDE00FFE7
      D600FFDED600FFF7EF00FFFFFF00DECEC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBDBD00FFDEDE00FFFFF700B5CEDE005A9CCE0084BDDE008CBD
      E70063ADDE007BB5CE00EFF7F700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700FFF7EF00FFEFE700FFEFDE00FFE7D600FFDED600FFF7EF00FFFFFF00DECE
      C600C6B5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063AD
      CE0073BDDE007BBDDE006BADCE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00B57B63009C310800CE7B4A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002994DE0042AD
      FF004AB5FF0052BDFF0052BDFF0052BDFF004ABDFF00399CD600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD
      BD00FFDEDE00FFFFFF00B5D6E70094C6DE009CCEDE009CC6DE00DEEFF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DECEC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBDBD00FFDEDE00FFFFFF00EFF7FF00B5D6E70094C6DE009CCE
      DE009CC6DE00DEEFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECE
      C600C6B5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C3118009C390800A54A
      1800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298CD60042AD
      FF004ABDFF0052BDFF0052BDFF0052BDFF0052BDFF0042A5D600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFDEDE00FFFFFF00F7FFFF00EFF7F700EFF7F700F7F7FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DECEC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFDEDE00FFFFFF00FFFFFF00F7FFFF00EFF7F700EFF7
      F700F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECE
      C600C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C4A2900842900008421
      0800BD735200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00186BAD001073
      BD00218CD600218CD600298CBD00217BBD00217BC600397B9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700F7DED600F7E7DE00FFEFEF00FFF7F700FFF7F700FFF7F700FFFF
      F700FFFFFF00FFFFFF00FFFFF700E7CEC600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7DED600F7E7DE00FFEFE700FFEF
      EF00FFF7F700FFF7F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFF700E7CE
      C600C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00844229008C2900008C390800FF00FF00FF00FF008C4A3100842900007321
      0000B5735200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003184
      BD006BA5D60094C6E7006BADEF004AA5DE002984BD0084ADCE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFDEE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7EF00BD9C9400E7D6CE00FFDED600F7DED600F7DECE00F7DECE00FFDE
      CE00FFDED600FFDED600FFE7D600EFD6CE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFDEE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00BD9C9400E7D6CE00FFE7DE00FFDE
      D600F7DED600F7DECE00F7DECE00FFDECE00FFDED600FFDED600FFE7D600EFD6
      CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00A5634200842900008C422100FF00FF00FF00FF00844221007B2100007321
      0000BD846300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003994
      BD00429CCE0073BDE7007BBDE700529CCE004A84A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00F7D6D600FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7EF00B59C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00F7D6D600FFF7F700FFF7F700FFFFF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00B59C9400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00844229009C422100D6A58C00B57352007B2108006B1800008C52
      3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF005AADCE007BB5D60084B5CE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7D6D600F7DED600F7DED600F7DED600FFDED600FFDED600F7DED600FFE7
      DE00FFDED600D6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFD6CE00F7DED600F7DED600F7DED600F7DED600F7DE
      D600F7DED600F7DED600FFE7D600FFDECE00CEBDB500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C6846B00B57B5A00AD6B4A00A56B5200B58C7300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0063636B00847B8C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B6B6B00735A5A006B39390042424200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A4A5A00212184002121
      4200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7E7FF00E7E7FF00EFEFFF00E7E7FF00E7EFFF00F7F7
      FF00E7E7FF00E7E7FF00FF00FF00E7E7FF00E7E7FF00EFF7FF00EFEFFF00E7E7
      FF00E7EFFF00E7E7FF00E7E7FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00636B7B00313152000808420000005A0052526300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF004A292900DE848400FF9C9C009C5A5200522929004239
      3900FF00FF00FF00FF00FF00FF00181839004A429400635ACE003131BD000000
      AD0021214200FF00FF00295A2100105A1000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFEFFF00DEE7FF00FF00FF00CEDEF700F7F7FF00EFEF
      FF00DEE7FF00D6DEFF00F7FFFF00EFF7FF00D6DEFF00FF00FF00DEE7FF00EFEF
      FF00CEDEFF00E7E7FF00E7E7FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004252
      7300183994001021A5000808AD000810B50008084A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00182121000008080000080800FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00845A5A00AD6B6300FF9C9C00FF9C9C00FF9C9C009C5A5200633131004A21
      21004239390039395A00393973006363CE006363CE006363CE003131BD000818
      7300084A4A0010731800108C21000073080018520800FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00BDCEFF00D6E7F700D6D6FF00BDD6EF00FF00FF00E7E7
      FF00DEDEFF00CED6FF00FF00FF00BDDEF700D6D6FF00FF00FF00D6D6FF00EFEF
      FF00C6CEFF00BDD6F700E7E7FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084848400105A
      8C00105AAD000821A5000810AD001021A50008004A006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00421010000010100000A5A500005A5A0018000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A39
      3900F7949400FF9C9C00FF9C9C00FF9C9C00FF9C9C009C5A5200633131006331
      3100522929005A5ABD006363CE006363CE005A63C6005263A50018634200107B
      2900108C210018AD420018A53900085A0800FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00D6DEFF00D6DEFF00DEE7FF00D6DEFF00DEE7FF00EFF7
      FF00D6DEFF00D6DEFF00FF00FF00D6DEFF00D6DEFF00E7EFFF00E7EFFF00D6DE
      FF00D6E7FF00D6DEFF00D6DEFF00F7F7FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00847B7B001052
      7300185A8C001039840008216B0000296300084A5A0029737B00316B73003163
      730042637300637B840063848C005A7384006B848C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003118
      18000021210000A5A50018FFFF0000CECE000039390000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C009C5A5200633131006331
      3100522121005A5AC6006363CE004A6394002973520018943100109429001094
      290029B54A0018A5390000630000425A4200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0094ADEF00ADBDF700D6E7FF008CA5EF00D6DEFF00EFEF
      FF00A5B5F700B5C6F700FF00FF00BDCEF70094ADEF00E7EFFF00ADBDF700BDCE
      F70094A5EF009CB5F7009CB5F700DEE7FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00636363002939
      4A00526B7B00425A730018294200217B840021A5BD0018BDDE0031C6BD004AC6
      AD0052C6A5005ACEBD0042C6D60021A5CE000884AD00106B8C004A637300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00291818000000
      00000073730010FFFF004AFFFF0039FFFF0000D6D6000039390008000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C009C5A5200633131006331
      3100522121005A5AC6006363CE004A6394002973520018943100109429001094
      290029B54A0018A5390000630000425A4200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0094ADEF00C6CEF700B5C6F7007B94EF00FF00FF00DEE7
      FF00849CEF00D6DEF700FF00FF0094ADEF009CB5EF00FF00FF00A5B5EF00DEE7
      FF008C9CEF00ADBDF700ADBDF700DEE7FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00949C9C00737B7B00424A4A005A52
      5A00A59C9C005A5A6300525A63008CADB5006BA5A50029AD730031A5630039A5
      520052B55A0039B5730008ADC60000A5F70000ADF70000B5EF000084AD00214A
      5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004210100000212100008C
      8C0000313100085A5A004AFFFF005AFFFF0029F7F70000BDBD00003939000800
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C009C5A5200633131006331
      310039080800314A7B0039846B00219C420018A539001094290018A5390031C6
      5A0018942900004A4200001863005A5A5A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B7BDE00737BDE00D6DEF7007384DE00FF00FF00E7EF
      FF00949CE700CED6F700FF00FF00B5BDF70094A5E700FF00FF009CADE7007384
      DE007384DE006B7BDE006B7BDE00D6DEF700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0084848400848484009CADB5004A5A6B008C84
      8C00B5B5B5004239420084848400A59C9C005AAD5A0063BD52004AA542004294
      3900428C5A002963AD001852DE001052E7001852EF000863F70000A5F700008C
      B5005A525200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF002121210000181800009C9C0010FF
      FF001084840018212100217B7B004ADEDE004AFFFF0029FFFF0000C6C6000042
      4200394A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FFA59C00FFB5B5009C636300633131004A18
      18004218080029AD4A0021B54A0018A53900109C290029B54A0031C65A00108C
      2100084A52000000A500000094005A5A5A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00DEE7F700DEE7F700E7EFF700DEE7F700E7EFF700F7F7
      FF00DEE7F700DEE7F700FF00FF00DEE7F700DEE7F700EFEFFF00EFEFFF00DEE7
      F700E7E7F700DEE7F700DEE7F700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0073737B005A7384008CBDD600428CAD00425A6B00948C
      94009C949C0039394200948C8C008C9CA50042B54A0073C65A0039943100318C
      3900296B8C003152EF002139DE001018BD002139DE00315AF7000863FF0000B5
      EF0018314200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0039101000000808000094940010FFFF0042FF
      FF0052FFFF0031A5A50000080800185A5A004AFFFF004AFFFF0021FFFF0000E7
      E7000039390029101000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FFBDB500FFD6D600FFE7E700CEA5A5006B3139004A42
      290029944A0021AD4200189C390018A5390039CE630039BD5200398C5200104A
      63000000A5000000AD00000094005A5A5A00FF00FF00FF00FF00FF00FF00F7F7
      F700F7EFEF00D6DEE7004A6BC600395AC6005273C600526BC6004A6BC6009CAD
      D6003963C6003152BD00C6CEDE00526BC6003152BD009CADD6008C9CD6002952
      BD00637BCE00395AC600395AC600ADBDDE00E7E7E700F7EFEF00F7F7F700FF00
      FF00FF00FF00FF00FF002152630052ADD600319CCE00105A8C005A6B73009494
      94007B737B00215A6B0018ADD60010BDEF0010C6D60021BDB50018AD8C001094
      A5002163DE00315AEF001021BD000000AD000810C6001839F700086BFF0000BD
      F70010394A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00391818000021210000636300004A4A00189C9C0052FF
      FF005AFFFF0042F7F700217373001094940042FFFF00A5FFFF006BEFEF00006B
      6B0000393900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00734A
      4A00FFA5A500FFE7E700FFDEDE00FFD6D600FFCECE00F7CEC600B5AD9C0031AD
      520029BD520018A5390029B5520052D6730029AD4200186B3100737BCE008484
      F7000808AD000000A50000009C005A5A5A00FF00FF00FF00FF00FF00FF00EFEF
      EF00D6D6D600B5B5B50052639C004A5A9C00314A94009494A50029429400737B
      9C00636B9C00395294009494A5005A6B9C0039529400ADADA500848CA5001839
      9400A5A5A5004A5A9C004A5A9C00848CA500B5B5B500D6D6D600EFEFEF00FF00
      FF00FF00FF00737B840008739C00189CD6001084C60008527300737B7B00A5A5
      A5005A5A5A0018637B00009CC60000C6F70000C6F70008C6F70008B5EF0010A5
      EF002163E7003929C6003910B5005218AD0063318C00527BA50008BDEF0000C6
      FF0010394A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00212121000008080000A5A50008E7E70000292900214A4A0042FF
      FF004AFFFF004AFFFF004AFFFF004AFFFF0063FFFF00A5FFFF007B7B7B002108
      0800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00736B
      6B00FFEFEF00FFCECE00FFCECE00CEA59C00CEAD9C006B73630029BD520021BD
      520021AD42005AD6730052CE6B00108C4200087B6300424A8C006363CE007B7B
      E7006B6BDE001008AD0000009C005A5A5A00FF00FF00FF00FF00FF00FF00DEDE
      DE00C6C6BD00A5A5AD006B7394007B7B94006B738C008C8C94006B738C008484
      94007B7B8C0073738C008C8C9400636B8C0073738C009C949400737B8C00636B
      8C00949494007B7B8C007B7B8C008C8C94008C8C8C00A5A5A500DEDEDE00FF00
      FF00FF00FF0042525A000084B500088CC600107BB50021526B0084848400A5A5
      A50042424200182121000018180042CEDE0000C6F70008BDF70008B5EF0031A5
      D6009C736B00EF5A4A00E7523100DE4A2900EF5A4A00EF52420042A5B50000B5
      DE0039313900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00420808000018180000ADAD0010FFFF0039FFFF0031C6C60039CECE0042FF
      FF004AFFFF0039FFFF0029FFFF0084FFFF00B5FFFF002952520021181800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00847B
      7B00946B6300AD735200BD947B00B59C8400CEAD9C007384630031BD5A0073D6
      8C0073D68C0039A54A00187B29000094C600009CFF00005A9C00423984006363
      CE006363CE004A4AC60008089C005A5A5A00FF00FF00FF00FF00FF00FF00D6D6
      D600C6C6C600C6CEC600BDC6BD00BDC6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600BDBDBD0094949400D6D6D600FF00
      FF00FF00FF0073848C00006B9400088CCE00106B9C00395A6B00948C94009494
      9C00293139000042520000A5B50018CEF70008C6F70010BDF70010B5EF0029A5
      CE009C737300E7523900D6421000D6420000D64A2100AD634A0018ADD6000852
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002918
      180000181800004A4A00007B7B0029E7E70063FFFF005AFFFF004AFFFF0042FF
      FF0031FFFF004AFFFF007BFFFF0084DEDE006373730029212100FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B
      9C0063392100E7BD9C00F7E7D600FFDEBD00F7C69C00C6AD8C0063945A00B5D6
      B5006BAD6B0008A5A50000A5EF00009CFF00009CFF00009CFF00005284004A4A
      9C004A4AA50042426B0042425200FF00FF00FF00FF00FF00FF00FF00FF00EFEF
      E700DEDEDE00C6C6BD00D6B58C00DEBD9400D6D6BD00CECECE00BDADA5009C8C
      7B00B5A58C00BDA58C00BDA58C00BDA58C00BDA58C00BDA58C00BDA58C00BDA5
      8C00BDA58C00AD9C8C00AD9C9400C6C6BD00CECECE00B5B5B500E7E7E700FF00
      FF00FF00FF00FF00FF00214252000884B50008638C0052636B009C949C007B73
      73003163730008ADC60000A5C600009CC60000A5CE0008A5D60010ADE70010B5
      EF004A94B500A5635200B55A3900AD5A39007B737300219CBD0008738C00525A
      5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00311818000008
      080000ADAD0000A5A50000000000217373004AFFFF004AFFFF0042FFFF0042FF
      FF0031FFFF006BFFFF00BDFFFF00526B6B0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00214273000029
      7B0052393900D6A57300F7D6AD00FFDEAD00F7B57300EFA56300BD9C73005A63
      390018846B0000CEFF0000A5FF00009CFF00009CFF00009CFF0000528C002121
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7F7
      F700EFEFE700E7E7E700C6C6BD00C6C6C600C6C6C600BDBDB500B59C8C00C6A5
      8C00D6B58C00DEBD8C00D6BD9400DEBD8C00DEBD8C00DEBD8C00DEBD8C00DEBD
      8C00DEBD8C00D6BDAD00BDAD9C00BDB5AD00CECEC600CECECE00F7F7F700FF00
      FF00FF00FF00FF00FF00FF00FF0021526B00104A6B0063636B009CA5A500635A
      630018739400008CB50010293100424A520042637300316B8400217394001084
      AD00088CBD00188CB5002984A5002184AD001084AD00216B7B00636B6B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00421010000021210000AD
      AD0010FFFF0031F7F700299C9C00103131001052520039CECE0039FFFF0031FF
      FF008CFFFF0094F7F700315A5A0031292900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00316B94001873AD00086B
      A500084A840031395A0094634A00DEB57B00FFDEAD00EFB56B00B5946300397B
      7B0000C6F70008D6FF0000A5FF00009CFF00009CFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00BDADA500C6C6BD00CEB59C00CEB58C00DEBD9C00E7C6
      9C00EFC69C00EFC69C00E7C6A500F7C69C00EFC6A500EFC69C00F7CE9C00EFC6
      9400EFC69C00E7CEB500CEA59400AD8C8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C940031393900736B73009C9C9C004242
      4A0008638400007394004A525A00FF00FF00FF00FF00FF00FF00948C8C006B6B
      7300526B73004A738C004A7B94005273840063737B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF001818180000101000005A5A0000CE
      CE0039F7F70063FFFF0052FFFF00217373000018180029BDBD005AFFFF006BFF
      FF0094F7F700737B7B0010101000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0039A5D6005ABDEF0042AD
      DE00319CCE001073AD00084A8400393952009C735200BD9463004A84840000CE
      FF0039DEFF00ADFFFF0018C6FF00009CFF00009CFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7D6C600EFE7E700F7DEC600EFDECE00F7DEC600FFE7
      C600FFE7C600FFE7BD00FFE7BD00FFDEBD00FFDEC600FFDEBD00FFDEBD00FFDE
      BD00FFDEBD00FFDEC600E7AD9C00A5847B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C6C6CE006B6B6B007B7B7B008C848C004242
      4200314A5A004A6B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B4A4A000000000000A5A500006363000010
      100031ADAD0052FFFF004AFFFF0042E7E70039D6D60029EFEF0084FFFF00BDFF
      FF00315A5A0010101000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0042ADE70063CEFF006BCE
      FF0063CEF7004AB5E7002994C600086BA500214A7300397B840021CEF7009CEF
      FF0073FFFF0000FFFF0000FFFF0000C6FF00009CFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFDED600FFF7F700FFDEAD00FFD69400FFD69400FFD6
      9400FFD69400FFD69400FFD69400FFD69400FFD69400FFD69400FFD69400FFD6
      9400FFD69C00FFE7CE00E7B59C00A5847B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BDBDBD00636363008C8C8C006B636B00736B
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B6B6B006B63630042ADAD0018FFFF0008B5B500215A
      5A0039C6C6004AFFFF004AFFFF0039FFFF004AFFFF0073FFFF0073DEDE00526B
      6B0039292900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003194C600319CD6004AB5
      EF0063C6F7006BD6FF005AC6F700399CCE00295A730073A5A5009CFFFF0018FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000CEFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00F7DED600FFF7F700FFF7F700FFF7EF00FFF7F700FFF7
      E700FFF7EF00FFF7E700FFF7E700FFF7DE00FFF7DE00FFEFDE00FFF7DE00FFF7
      DE00FFE7D600FFE7CE00E7B59C00A5847B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00B5B5B5004A4A52008C8C8C005A5252009C9C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00000000007B9C9C00BDFFFF006BFFFF0042FFFF004AFF
      FF004AFFFF0042FFFF0042FFFF0042FFFF005AFFFF008CFFFF00427373000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003194C600319CD6004AB5
      EF0063C6F7006BD6FF005AC6F700399CCE00295A730073A5A5009CFFFF0018FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000CEFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00F7DED600FFF7F700FFF7F700FFF7F700FFF7F700FFF7
      EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFF7DE00FFF7DE00FFEFDE00FFF7
      DE00FFDECE00FFCEBD00E7AD9C00A58C8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00ADADAD00424242007B7B7B0063636300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF003939390031636300ADFFFF0094FFFF0031FF
      FF0039FFFF0039FFFF0031FFFF008CFFFF00A5FFFF002152520021212100FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073B5CE00218C
      BD00319CD6004AB5EF005AC6F700FF00FF00FF00FF002984840000F7F70000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000C6FF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00F7E7D600FFFFFF00FFF7F700FFF7F700FFF7F700FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFF7E700FFF7E700F7DE
      C600FFAD8400EF946B00D68C7300B59C9400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C949C004A4A4A00636363007B7B7B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0021181800737B7B008CE7E70073FF
      FF004AFFFF004AFFFF0073FFFF008CE7E700737B7B0029181800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006B94B500428CB500429CD600FF00FF00FF00FF00FF00FF001073730000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000F7F70000525A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFEFDE00FFFFFF00FFFFFF00FFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7EF00FFF7E700FFF7E700FFF7E700EFC6
      A500FFB55200E7943900BD946B00C6B5AD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C848C00424242005A525A009C949C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000808080042636300BDFF
      FF0063FFFF0063FFFF00BDFFFF004263630008080800FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00297B
      7B0000EFEF0000FFFF0000BDBD00188C8C004A4A4A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFEFDE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7EF00FFF7EF00F7DE
      BD00F7C69400BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0084848C0031313100736B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00393131004263
      63008CFFFF008CFFFF004263630039313100FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0029737300006B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFE7D600FFF7EF00FFF7EF00F7EFE700F7EFE700F7EF
      E700F7EFE700F7E7DE00EFE7DE00EFE7DE00E7DED600E7DED600E7DED600F7D6
      B500D6BDAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C8C002929290084848400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000808
      08007BA5A5007BA5A50008080800FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFE7CE00FFEFD600FFE7D600FFE7D600FFE7D600F7E7
      CE00F7E7D600F7DECE00F7DEC600F7DEC600F7DEC600F7DEC600F7DEC600F7DE
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A5A5A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00424A4A00424A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6
      D600ADADB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00CEC6CE009C94
      9C009C9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00946B
      6B0084636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00DED6CE00EFCEBD00EFC6C600DEC6C600D6CECE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094E7A50029CE4A0010CE390029CE4A005ACE
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFEF
      EF00EFEFEF00A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C84
      84007B4242006B3939007B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CECECE008C8C8C00B5B5B500BDBDBD00EFEF
      EF008C8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084A5C6000863C6007B84
      AD00AD5A5A00A58C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00E7DECE00F7DEBD00FFD6BD00EFC6C600F7CECE00F7C6C600E7BDBD00D6B5
      B500A58C8C00FF00FF00ADF7BD0010DE4A0000DE39007BEFA500A5F7C6008CEF
      AD0042CE6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7EF
      F700EFE7EF00EFE7EF00B5B5B500FF00FF00FF00FF00FF00FF001063CE005A6B
      A500BD636300B56363007B4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CECECE00ADADAD0094949400CECECE00FFFF
      FF009C949C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008CA5C600085AC600399CFF00ADDE
      FF00D6ADB500E7D6D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7DEBD00FFDEBD00FFD6C600F7C6C600EFC6C600EFC6C600F7C6C600EFBD
      BD00945A5A008494730029DE6B0000DE520000DE5200D6D6D600ADEFD600ADEF
      D600ADEFD60052DE8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00DEDEDE00EFEFEF00D6D6D600FF00FF00FF00FF001063CE00107BEF00429C
      FF00A594AD00BD636300A5636300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00CECED6009C9CAD009494A500CEC6CE00DEDEDE00DED6
      DE00CECECE00BDBDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008CA5C600085ABD003994F700ADD6FF00F7FF
      FF00DEEFF700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DECEC600FFE7
      CE00FFE7C600FFE7C600F7CEC600EFBDBD00EFBDC600EFBDC600EFBDBD00EFB5
      BD009463630063D6A50000E77B0000E77B0010E77B00D6CEC600F7BDC600F7C6
      C600EFBDBD00ADEFD600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00DEDEDE00E7E7E700CECECE00FF00FF000863CE00187BEF0042A5FF0084C6
      FF00C6E7FF00D6A5AD00C69C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B6B6B006B393900424242009C9C9C009CA5
      B5005A5AAD00424AAD003139B5002129BD003131BD006363AD008C8CA500BDBD
      BD00D6D6D6008C8C8C00BDBDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF008CA5C600085ABD00399CFF00ADD6FF00F7FFFF00D6EF
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DECEC600FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00F7CEC600EFBDBD00EFBDBD00EFBDBD00EFBDBD00E7B5
      B500945A5A0094948C0029EFA50042DE9C008CBDA500EFBDBD00EFBDBD00EFBD
      BD00E7B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BDBDBD00848484009C9C9C00FF00FF00B5B5
      B500CECECE00D6D6D600A5A5A5008C94B500187BEF00429CFF0084C6FF00C6E7
      FF00EFF7FF00F7F7F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009C9494004A292900DE8484009C5A520052292900423939007373
      AD002131DE002129E7001829E7001821E7001018DE000808CE000808B5005252
      A500BDBDC600CECED6006B63840031317B0052528C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0084A5C600085ABD00429CFF00ADD6FF00F7F7FF00D6E7FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DED6C600FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00F7CEC600E7B5B500EFB5B500EFB5B500E7B5B500E7B5
      B500945A5A00946B6B0094A59C008C6B6300AD7B7B00EFB5B500E7B5B500EFB5
      B500C6B5C60094B5E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DEDEDE00B5B5B500848484009C9C9C00B5B5
      B500CECECE00DED6DE00CECECE00737B9400297BFF008CC6FF00C6E7FF00EFF7
      FF00F7F7FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A39
      3900F7949400FF9C9C00FF9C9C00FF9C9C009C5A520063313100633131007363
      9C003142EF002939EF002939EF002131EF001829E7000810CE000000BD000000
      BD001010B500C6BDC600D6D6D600CECED6007B7BA5006B6B84009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00947373008C6B630094737300FF00FF00FF00FF00FF00FF00FF00
      FF007B9CC600085AC6003994F700ADD6FF00EFF7FF00DEEFF700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEFD600FFEFD600FFE7D600FFEF
      D600FFE7D600FFEFD600F7CEC600E7B5B500E7B5B500E7B5B500E7B5B500E7AD
      AD00945A5A0094849C008C6363008C5A5200AD737300E7B5B500D6B5BD0094A5
      D600298CF700107BF700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE00B5B5B500BDBDBD00C6C6
      C600C6C6C600CECECE00D6D6D600CECECE004A94EF00A5D6FF00EFF7FF00F7F7
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FF9C9C009C5A520063313100633131007363
      9C002942E7002939E7002939E7002131DE002129DE000810CE000000B5000000
      BD000808B5009C94A500BDBDC600DEDEDE00FFFFFF00EFEFEF009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDB5B5008C6B6B00B58C
      8C00D6BDBD00EFE7DE00EFE7E700EFDEDE00DED6D600A5847B00946B6B0084A5
      BD00105AB5003994F700A5D6FF00E7F7FF00DEEFFF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEFD600FFE7D600FFEFD600FFE7
      D600FFE7D600FFEFD600F7CEC600E7ADAD00E7ADAD00E7ADAD00E7ADAD00E7AD
      AD00945A5A00637BB5008C6B73008C5A5A00AD737300D6BDC60063A5EF000884
      FF00007BFF00007BFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600D6D6D600D6D6
      D600C6CECE00C6C6C600CECECE00D6D6D6008C9CA500CEDEEF00F7F7F700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FF9C9C009C5A520063313100633131007363
      9C00314AEF00394AF700314AF7003142F7002939EF000810DE000000CE000000
      C6000000C6003931AD008484AD00DEDEDE00C6BDCE00948CA500C6C6C600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BD9CA500AD7B7B00EFDEDE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700EFDEDE00A573
      7B00946B8400ADC6E700EFF7FF00DEEFFF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00F7CEC600E7ADAD00DEADAD00E7ADAD00E7ADAD00E7AD
      AD0094635A006B8CC6005A6BB5008C5A5A00AD737300DEB5B500BDB5CE00218C
      FF000073FF00007BFF00A5BDE700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5BD
      D6004A84C600CECECE00C6C6C600CECECE00CECECE00A5A5AD00BDC6C600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FF9C9C00FFA59C009C636300633131004A181800846B
      7B004A52D6004252F7003952FF00394AF7002129EF000008DE000000D6000000
      D6000008D6000808D6006363AD00C6C6C6007B7B9C005A5A9400ADADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00C6A5A500B57B7B00EFDEDE00CEC6C600AD94
      8400A5948C00ADA5A500BDBDBD00CECED600D6D6D600BDC6C600A5ADB500B5AD
      B500C6848400C68C8400D6DEEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEFE700FFEFDE00FFEFE700FFEF
      DE00FFEFDE00FFF7E700EFCEC600DEA5A500DEA5A500DEA5A500E7A5A500DEA5
      A500945A5A008C849400216BEF006B5A9400AD7B8400DEADAD008C9CDE00006B
      FF00006BFF003184FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094B5D6001063
      CE00107BEF0073B5EF00C6C6CE00C6C6C600D6D6D600CECECE009C9C9C00D6D6
      D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007342
      4200FF9C9C00FF9C9C00FFBDB500FFD6D600CEA5A5006B3139004A1818004A00
      000063638C00636BDE004252DE003942DE003942DE004A52E7002129DE001021
      DE001021DE000810DE002929C6008C8CAD00A5A5AD008C849400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00B56B6B00CEB5AD00AD7B6B009C4A1000C65A
      0000BD5A0000A54A0800944218007B4A31005A423900085A84002184AD00216B
      94004A6B8C008C6363009C9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFF7E700FFEFE700FFF7E700FFEF
      E700FFF7E700BDC6CE00C6ADB500DEA5A500DEA5A500DEA5A500DEA5A500DEA5
      A500945A5A00946363005A8CD600185AEF004A63D6006B84DE001063F700005A
      FF000063FF009CC6FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00106BCE00107B
      EF00429CFF0084C6FF00C6DEEF00CECECE00CECECE00D6D6D600CECECE009C9C
      9C00CECECE00D6D6D600C6CEC600FF00FF00FF00FF00FF00FF00FF00FF00734A
      4A00FFA5A500FFE7E700FFDEDE00FFD6D600FFCECE00B5848400390808001810
      100008ADD60018C6F7000894F700429CF700A5ADD6009C9CBD006B6BAD004A52
      AD00737BCE003942C6002931B5006B6BB500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00B57B7B00CE9C9400B55A2900C65A0000DE6B0000E77B
      0000E77B0000DE730000D66B0000D66300009442080008738C0039C6DE0031BD
      DE0029B5D600849CA5009C7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFF7E700FFF7E700FFF7E700FFF7
      E7006B84B5003963A5004A6BAD00AD8CA500DE9CA500DE9CA500DE9CA500D69C
      9C00945A5A008C5A5200946B73007B9CD6002973F7000052FF00005AFF00216B
      FF00849CDE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADAD
      AD00C6C6C600FF00FF00FF00FF00FF00FF00FF00FF00ADC6DE00107BEF00429C
      FF007BBDFF00C6E7FF00E7F7FF00EFEFEF00C6C6C600CECECE00D6D6D600CECE
      CE009C9C9C00B5B5B500C6C6C600DEDEDE00FF00FF00FF00FF00FF00FF00736B
      6B00FFEFEF00FFCECE00FFCECE00FFCECE00A5848400084A5A000084A50000CE
      FF0000CEFF0000CEFF0000A5FF00009CFF00005A94009CA5A500A5A5A5009494
      9400ADADAD009494C6005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00B57B7B00E7CEC600C6631000E77B0000E7840000EF84
      0000E77B0000E77B0000DE730000D66B00009C4A0800217B94004ACEEF0042C6
      E70039BDE70052BDD600846B6300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00E7E7E7008C9CC6004A6BAD004263
      AD00426BB500426BB5004A6BB5004A73BD005A73B500D6949400D6949400D694
      9400D6949400D6949400D69C9C00D6949400D6949400D6949400D6949400D694
      9400D6949400738CB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C84
      7B009C9C9400BDBDBD00FF00FF00FF00FF00A5BDDE000863C60042A5FF0084C6
      FF00C6E7FF00F7F7FF00F7F7FF00DEE7E700CECECE00C6C6C600CECECE00DED6
      DE00E7DEE700EFEFEF00FFF7FF00A5A5A500DEDEDE00FF00FF00FF00FF00847B
      7B00D6ADAD00FFCECE00FFCECE00FFCECE0000526B0000CEF70000CEFF0000CE
      FF0000CEFF0000CEFF0000A5FF00009CFF00009CFF003994CE0084848400D6D6
      D600CECECE0018189C005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00BD8C8C00EFDED600CE6B1000FF8C0000FF8C0000FF8C
      0000EF8C0000EF840000E77B0000DE730000A54A080031849C0052D6EF0052CE
      E70042C6E70039BDDE00947B8400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CECED600426BAD003963AD00426BB500426B
      B5004A73B5004A73BD00527BBD00527BBD00527BC600B58CA500D6949400D694
      9400D6949400D6949400D6949400D6949400D6949400D6949400D6949400D694
      94007B7BB500A5C6EF00FF00FF00FF00FF00FF00FF00FF00FF00C6C6C6008C8C
      840084847B009C9C9400C6C6BD00C6D6E700106BC600107BEF0084C6FF00C6E7
      FF00EFF7FF00F7F7FF00EFEFEF00FF00FF00DEDEDE00CECECE00C6C6C600CECE
      CE00DEDEDE00E7E7E700DEDEDE00EFE7EF00CECECE00FF00FF00FF00FF00FF00
      FF0073737300DEADAD00FFCECE00FFCECE000084A50000CEFF0000CEFF0000CE
      FF0000CEFF0000CEFF0000A5FF00009CFF00009CFF00009CFF0000528C005252
      9C005252A50042425200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00BD949400BD9C9C00EFDED600D6731000FF9C0800FF9C1800FF9C
      1000FF8C0000EF8C0000E7840000E77B0000A54A08004294A5005ADEEF005AD6
      EF004ACEE70042C6DE00A5949C00BD9C9400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005273B500426BAD004A73B5004A73B5004A73
      B500527BBD00527BC600527BBD005A84C6005A84C600738CC600B58CA500D68C
      8C00D68C8C00D68C8C00D6949400D68C8C00D6948C00D6948C00CE8C9400737B
      B500A5BDE700FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600EFEFEF00ADAD
      A5008C8C840084847B009C9C9400948C8C005A6BA500429CF700C6E7FF00EFF7
      FF00F7FFFF00EFEFF700FF00FF00FF00FF00FF00FF00C6C6C600BDBDBD00B5B5
      B500FF00FF00FF00FF00FF00FF00EFEFEF00EFEFEF00FF00FF00FF00FF00FF00
      FF00FF00FF007B737300C6A5A500FFCECE000084A50000CEFF0000CEFF0000CE
      FF0000CEFF0000CEFF0000A5FF00009CFF00009CFF00009CFF0000528C002121
      4A007B7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD8C8C00BDA59C00EFDED600D67B3100FFB54A00FFB55200EF9C
      3100EF8C0800EF840800EF840000EF840000AD52080052A5AD006BE7EF0063DE
      EF005AD6EF004ACEE700AD9C9C00B58C8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B84BD004A73B5005273B500527BBD00527B
      BD005A7BC6005A84C6006384C600638CCE00638CCE006B94D6007394CE00BD8C
      9C00CE8C8C00CE8C8C00D68C8C00CE8C8C00D68C8C00C68C8C005A73BD0094B5
      E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600EFE7E700D6D6
      D600ADADA5008C84840084847B009C948C00AD737300A58CA500EFF7FF00F7FF
      FF00EFEFEF00FF00FF00FF00FF00FF00FF00FF00FF00BDB5BD00B5ADB500A5AD
      AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00847B7B00C69C9C000084A50000CEFF0000CEFF0000CE
      FF0000CEFF0008D6FF0000A5FF00009CFF00009CFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00BD949400B59C9400E7DED600BD734200E79C5200D6843900C673
      2900C66B1800C6631800BD5A1000BD5A08009C5A290084D6DE007BEFF70073E7
      F70063DEF7005AD6EF00AD949400B5948C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00527BBD005A7BBD005A7BBD005A84
      C6006384C600638CCE006B8CCE006B94CE006B94D600739CD6007B9CDE007B9C
      DE00BD8C9C00CE848C00CE848400CE848400CE8C8400426BC6009CBDE700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600F7EF
      F700D6D6D600ADADAD008484840084847B0094949400AD737300F7F7F700E7EF
      EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B5009C9C9C009494
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00848484000084A50000CEFF0000CEFF0039DE
      FF006BE7FF00ADFFFF0018C6FF00009CFF00009CFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00A5848400FFFFFF00DEC6BD00D6A58C00DEAD9400CE94
      6B00AD5A31009C5A3100948C6B0094BDAD0094EFEF0094FFFF0084F7F70073EF
      F7006BE7F70063DEEF009C7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007B94CE006384C6006384C600638C
      CE006B8CCE006B94D6007394D6007394D6007B9CD6007B9CDE0084A5E70084A5
      E7008CA5DE00CE848400CE848400CE848400A57B9400A5BDE700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7E7
      E700F7EFF700D6D6D600ADADA5008C84840084847B0094949400DEDEE700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600B5B5B5008484
      8400A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000084A50018D6FF009CEFFF0073FF
      FF0042FFFF0000FFFF0000FFFF0000C6FF00009CFF00009CFF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C736B00E7DEDE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ADCED60073DEE7009CFFFF009CFFFF009CFFFF009CFFFF008CF7FF0084EF
      F7007BEFF70094CED600AD6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B9CCE006B8CCE006B8C
      CE007394D600739CD6007B9CDE007B9CDE0084A5DE0084A5E7008CA5E7008CAD
      EF008CADEF00BD949C00CE84840094739C003163CE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEBD
      BD00E7DEDE00F7EFF700D6D6CE00ADADA5008C84840084847B00C6C6C600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600B5B5
      B5009C9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF002984840000F7F70000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000C6FF0000528C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69CA500B5A5A500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ADC6DE007BDEE7009CFFFF0094FFFF008CFFFF0063F7FF0052EFFF0063EF
      FF0084EFF7009C9CA500B5737300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CA5D600739C
      DE007BA5DE007BA5E70084A5E7008CA5E7008CADE7008CADEF008CB5EF008CB5
      F70094B5F7009CB5EF008C84B5002163D600A5BDDE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00CEBDBD00E7E7E700F7F7F700D6D6CE00ADADA500848484009C9C9400C6C6
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6
      D600D6DEDE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001073730000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000F7F70000525A005A737B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A57B7B00C6BDBD00FFFFFF00FFFFFF00FFFF
      FF00ADC6D60073D6E70084FFFF0052F7FF0018EFFF0000DEFF0000D6FF0000D6
      FF006BA5B500B5737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094AD
      DE0084A5E70084A5E7008CADEF008CADEF008CB5EF0094B5F70094B5F70094BD
      F7009CBDFF00A5C6FF00A5C6EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00CEB5B500E7E7E700F7EFF700D6D6D600ADADA50084847B009C9C
      9400BDBDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00297B7B0000EF
      EF0000FFFF0000FFFF0000BDBD00188C8C004A4A4A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0094737300CEC6BD00FFFFFF00FFFF
      FF00B5CEE70039A5CE0018C6DE0000CEE70000CEEF0000CEEF0000D6F7004AA5
      B500B5737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00A5C6EF0094B5F70094BDF7009CBDF7009CBDF700ADC6FF00ADC6F700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00D6C6C600E7E7E700F7EFF700D6D6D6008C8C84008C84
      7B009C9C9400C6C6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002973
      730000D6D600006B6B007B8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C737B00A5949400EFEF
      EF00FFFFFF00CEDEEF00BDD6E700B5D6DE00B5D6E7009CC6CE00637B8400B573
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00ADC6EF00A5BDFF00A5C6FF00A5C6FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6D6D600E7E7E700EFEFEF00A5A5A5008C8C
      84008C8C8400A5A59C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A584
      84009C8C8C00A5949400AD9C9C00A5949400A5848400A5737300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00B5CEF700BDCEEF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE00DEE7DE00DEDEDE00DEDE
      DE00E7E7E700EFEFEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFCEBD00EFC6C600DEC6C600CEBD
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C5252006B5A
      5A00FF00FF007B7B9C005A5AAD0073738400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6D6D600FF00FF00C6D6
      EF006384BD009C5A6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00E7DECE00FFD6BD00EFC6C600F7CECE00F7CE
      C600F7C6C600D6B5B500A58C8C00B5A5A5008C737300EF948C00A55A5A005A29
      290039396B005A5AC6005A5ACE001010840084849400FF00FF00FF00FF00FF00
      FF00FF00FF009C737300E7948C00FFA5A5007342420052393900FF00FF004A4A
      73005A5AB5006B63D6001010B50018187300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00AD848400A57B7B009C7B7B009C847B00AD9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6D6D600FF00FF00D6D6D600BDC6DE003184
      DE006BB5FF00CEB5BD0073636300847373009C8C9400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00D6C6BD00F7DEBD00FFD6C600F7C6C600EFC6C600F7C6
      C600EFC6C600EFBDBD00945A5A00945A5A0084524A00FF9C9C009C5A5A005218
      180021215A005252BD006363CE0000009C007B7BA500FF00FF00FF00FF00FF00
      FF008C6B6B00FF9C9C00FF9C9C00FF9C9C006B3939006329290031214A006363
      CE006363CE006363CE000808B5000000A50010106B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7B5A500E7B5A500DEAD9C00CEA59400A57B7B00FF00
      FF00FF00FF00BD9C9C00AD949400A58C9400A5949400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C6C6C600BDBDBD00CECECE007384B5005A9C
      F700DEEFFF00EFE7EF00BDA5A500B5949400AD8C8C009C737B008C636B008473
      730094848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00DECEC600FFE7CE00FFE7C600FFE7C600F7CEC600EFBDBD00EFBDC600EFBD
      BD00EFBDC600EFB5BD00946363008C5A5A0073524A00DEADAD006B8C9400089C
      BD0000CEFF00009CF7002163B5002929AD008484A500FF00FF00FF00FF00FF00
      FF00946B6B00FF9C9C00FF9C9C00FF9C9C006B39390052212100180831004A42
      B5006363CE006363CE000808B5000000A50000007300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00D6B5B500F7C6AD00FFD6AD00FFD6AD00F7CEA500B58C8400FF00
      FF00FF00FF00D6A59C00E7B5A500D6A59C00C69C9400B58C8400AD8484009C7B
      7B0094848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00E7E7E700BDC6D600BDC6CE00CECECE00ADBD
      C600DEDEE700E7CECE00E7CECE00EFD6D600EFD6D600E7CECE00E7CECE00D6B5
      B500C69C9C009C6B73008C7B7B00FF00FF00FF00FF00FF00FF00FF00FF00DECE
      C600FFE7CE00FFE7CE00FFE7C600FFE7CE00F7CEC600EFBDBD00EFBDBD00EFBD
      BD00EFBDBD00E7B5B500945A5A00945A52008C5252009C737300299CBD0000CE
      FF0000CEFF0000A5FF000094EF008484A500FF00FF00FF00FF00FF00FF00FF00
      FF00946B6B00FF9C9C00BD737300946B6B00845252004A10100018081800084A
      7B003131730039397B002121B5000000A500000073004A6B8C005A84A500425A
      7B0039426B00525A7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6AD00FFD6AD00FFD6AD00F7D6AD00C69C8C009484
      7B00B5949400F7CEB500FFDEBD00FFDEBD00FFDEC600F7D6BD00EFCEBD00DEB5
      AD00A5848400FF00FF00FF00FF00B58C8C00A58484009C8484009C8C8400A59C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF003184DE008CBDEF00C6C6CE00CECE
      CE00BDB5BD00DECED600DEC6C600D6B5BD00EFCED600EFD6DE00EFDEDE00F7DE
      DE00F7DEE700EFD6D600D69C9C00FF00FF00FF00FF00FF00FF00FF00FF00FFE7
      CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00F7CEC600E7B5B500EFB5B500E7B5
      B500EFB5B500E7B5B500945A5A008C5A5A008C5A5A00845252001084A50010CE
      FF0031CEEF0008ADFF000094F700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0063525200946B6B00D6ADAD00F7C6C600A5949400184A630000B5DE0000B5
      FF00006BB5004A52AD008484EF002121BD0000007B006B94BD0084B5DE008CBD
      EF008CC6F7007BB5E700638CC6004A6B9C00314A6B00FF00FF00FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6B500FFD6B500FFDEB500FFDEB500EFCEAD00C6A5
      8C00DEB5A500FFDEBD00FFE7C600FFE7C600FFE7CE00FFE7CE00FFE7CE00EFD6
      C600A5847B00FF00FF00D6BDB500EFC6BD00EFCEBD00E7BDB500D6ADAD00B58C
      8C00B5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00C6C6BD00FF00FF00FF00FF006BB5FF00D6E7F700DEDEDE00CECE
      CE00CECECE00CEC6CE00AD9CA50084636300947373009C7B7B00B5949400C6AD
      B500EFDEDE00EFD6D600C6949400FF00FF00FF00FF00FF00FF00E7DECE00FFEF
      D600FFE7D600FFEFD600FFE7D600FFE7D600F7CEC600E7B5B500E7B5B500E7B5
      B500E7B5B500E7ADAD00945A5A00945A5A00945A5A008C5A5A00397B8C0039E7
      EF0010F7F70000E7FF0000A5F700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00B5ADAD00DEB5B500FFCECE00A584840000A5C60000CEFF0000CEFF0000BD
      FF00009CFF00086BB5004A52AD005A5AC60010186B006B9CCE0084B5E7008CBD
      F70094C6FF0094CEFF009CCEFF009CCEFF00526BA500FF00FF00FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6B500FFDEB500E7D6AD00DECE9C00CEC69C00D6C6
      9C00DECEAD00F7DEBD00FFE7CE00FFE7CE00FFE7CE00FFEFD600FFEFD600F7E7
      CE00B59C8C009C848400D6B5AD00FFEFDE00FFEFE700FFEFE700F7E7DE00CEB5
      AD00BDADA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009C9494009C9C9C006B84B500C6CEE700DED6D600E7E7E700D6CE
      CE00BDBDBD00E7DEDE00D6CECE009C7B7B00A57B7B00AD848400A57B84008463
      6300E7DED600DEA5AD00FF00FF00FF00FF00FF00FF00FF00FF00F7E7D600FFE7
      D600FFEFD600FFE7D600FFEFD600FFE7D600F7CEC600E7ADAD00E7ADAD00E7AD
      AD00E7ADAD00E7ADAD00945A5A008C5252008C5A5A008C5252005273730000E7
      E70000FFFF0000F7F70018A5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00948C9400DEB5B500A584840000BDEF0000CEFF0000CEFF0000BD
      FF00009CFF00009CFF0018295A0039527B006394C6007BB5E70084B5E7008CBD
      F70094C6FF0094CEFF0094CEFF0094CEFF005273A500FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5AD00F7CEB5000084FF000084FF000084FF000084FF000084
      FF004284FF004284FF000084FF000084FF00FFEFD600FFEFDE00FFEFDE00FFEF
      DE00EFDECE00DEC6BD00F7E7D600FFF7E700FFF7EF00FFF7EF00FFF7EF00D6BD
      B500B5ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5
      B500A5A5A500D6D6D6009C94940094848400BDADB500A58C8C00AD949400C6BD
      BD00A5A5A500EFDEDE00F7E7E700F7E7E700EFDEDE00DECECE00C6ADB500B594
      9C00FFEFF700C69C9C00FF00FF00FF00FF00FF00FF00FF00FF00F7E7DE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00F7CEC600E7ADAD00DEADAD00E7AD
      AD00E7ADAD00E7ADAD0094635A008C5A5A008C5A5A008C5A5A00A57373007B9C
      9C0021B5B5006B8C8C00C69C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00949CB500394A6B003131390000BDEF0000CEFF0000ADD600089C
      CE00009CFF00009CFF00316384006B9CCE006B9CD6007BADE70084B5E7008CBD
      F70094C6FF0094CEFF009CCEFF0094CEFF005273A500FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5B500EFCEB5000084FF000084FF004284FF004284FF004284
      FF004284FF004284FF000084FF000084FF000084FF00FFEFDE00FFEFDE00FFF7
      E700FFF7E700FFF7E700FFF7EF00FFF7EF00FFF7F700FFF7F700FFF7EF00D6BD
      BD00B5ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADA5A5007363
      6300948C8C00DED6D600D6D6D6009C9C9400D6CECE00F7DEDE00B59C9C00DECE
      CE00C6BDC600CEC6C600C6ADB500D6BDC600E7D6D600F7EFEF00C6B5BD00E7DE
      DE00FFF7F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7DE00FFEF
      DE00FFEFE700FFEFDE00FFEFDE00FFEFDE00EFCEC600DEA5A500DEA5A500E7A5
      A500DEA5A500DEA5A500945A5A008C5A52008C5A5A008C5A5200AD737300DEA5
      A500BD949400DEA5A500DEA5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00949CB50039639400314A63000094B500109CA50000C6C60000FF
      FF0000C6FF00009CFF00396384006B9CCE0073ADE7007BADE7007BB5EF008CBD
      F70094C6FF0094CEFF009CCEFF009CCEFF005273A500FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5B500F7CEBD000084FF000084FF004284FF004284FF009CBD
      FF009CBDFF004284FF004284FF000084FF000084FF00FFEFE700FFEFDE00FFF7
      E700FFF7EF00FFF7EF00FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700D6C6
      BD00BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C737B00DEC6
      C600CEADAD00C6ADAD00DED6D600D6D6D600A59C9C00CEBDBD00BDADAD00F7E7
      E700F7E7E700F7EFEF00EFDEDE00DED6D600CEBDBD00BDADAD00AD8C9400FFF7
      F700F7E7E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7EFDE00FFEF
      E700FFF7E700FFEFE700FFF7E700FFF7E700C6ADB500DEA5A500DEA5A500DEA5
      A500DEA5A500DEA5A500945A5A008C5A5A008C5A5A008C5A5A00A5737300DEA5
      A500DEA5A500DEA5A500DEA5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009C9CB5004263940039637B00009C9C0000FFFF0000FFFF0000FF
      FF0000FFFF0000C6FF00396384006B9CD60073A5DE007BADE70084B5E7008CBD
      F70094C6FF0094CEFF009CCEFF009CCEFF005273AD00FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5B500F7D6C600E7DEBD000084FF000084FF004284FF009CBD
      FF009CBDFF004284FF000084FF000084FF00E7E7CE00FFE7D600FFD6BD00FFD6
      BD00FFDEC600FFDECE00FFEFDE00FFEFE700FFF7EF00FFFFFF00FFFFFF00D6C6
      BD00BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00BDB5B500AD949400EFCE
      CE00D6ADAD008C6B6B00EFDEDE00E7DEDE00B5B5AD00CECEC600EFE7E700F7EF
      EF00F7EFEF00F7EFEF00FFF7F700FFF7F700FFF7F700E7DEDE00CEBDC600FFFF
      FF00E7BDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7EFE700FFF7
      E700FFF7E700FFF7E700C6CED6006B84B5004A6BAD00AD8CA500DE9CA500DE9C
      A500DE9CA500D69C9C00945A5A00945A52008C5A52008C5A5200A56B6B00DE9C
      A500DE9CA500DE9CA500DE9CA500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00949CB500396B94004A7BAD00396B940000CECE0000FFFF0000F7
      F70000B5B500397B8C007BADDE006B9CD60073A5D6007BADE70084B5E7008CBD
      F70094C6FF0094CEFF009CCEFF009CCEFF005273AD00FF00FF00FF00FF00FF00
      FF00FF00FF00DEB5B500F7D6C600FFEFD600CED6B5000084FF00217B9C00318C
      C600428CB5000084FF000084FF00C6DEBD00FFF7EF00FFF7E700FFEFDE00FFE7
      D600FFE7D600FFDEC600FFD6BD00FFCEB500FFCEB500FFF7E700FFFFFF00DEC6
      C600BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00947B8400DEC6C600EFC6
      C600BD949400AD8C8C00F7E7E700BDADA500F7E7E700BDADAD00F7EFEF00F7EF
      EF00F7EFF700F7F7F700FFF7FF00FFFFFF00FFFFFF00C6B5B500F7EFF700FFFF
      F700CE949C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7F7E7008C9C
      C6004A6BAD004263AD00426BAD00426BB5004A6BB5004A73BD005A73B500BD94
      9C00D6949400D6949400D6949400D69C9C00D6949400D69C9C00D6949400D694
      9400D6949400D6949400D6949400738CB500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009C9CB50039639C004A84B500528CBD00427B9C00089CA5003173
      8C006B9CCE008CBDF7008CBDF7006B9CD60073A5D6007BADDE0084B5EF008CBD
      F70094C6FF0094CEFF009CCEFF0094CEFF00527BAD00FF00FF00FF00FF00FF00
      FF00FF00FF00DEBDB500F7D6C600FFEFDE00CED6D6004294D6002994F700319C
      FF002994F7004A9CD600D6DEE700FFF7EF00FFF7F700FFF7EF00FFF7EF00FFF7
      F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFFF00FFFFFF00DEC6
      BD00BDADAD00FF00FF00FF00FF00FF00FF00FF00FF009C848400EFDEDE00E7B5
      BD009C7B7B00DEC6C600EFDEDE00AD949C00CEBDC600D6CECE00FFF7F700FFF7
      F700FFF7F700FFF7F700FFFFFF00FFFFFF00FFFFFF00BDADAD00FFFFFF00F7DE
      DE00BD949C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00849CC6003963
      AD00426BB500426BB5004A73B5004A73B500527BBD00527BBD00527BC6005A7B
      BD00B58CA500D6949400D6949400D6949400D6949400D6949400D6949400D694
      9400D6949400D6949400D6949400A5C6EF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009C9CB500396B9C004A7BB5005284BD005284BD004A7BA500528C
      BD0073ADD6008CC6F7008CBDF7006B9CCE006B9CD6005A8CBD006394C60073A5
      D6007BB5E7008CC6F70094CEFF0094CEFF00527BA500FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500F7D6CE00FFEFDE0094BDD6003194EF0039A5FF0042A5
      FF0039A5FF00429CEF00ADCEDE00FFFFF700FFFFFF00FFE7E700FFD6C600FFDE
      C600FFDECE00FFE7D600FFE7DE00FFEFDE00FFEFE700FFFFF700FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00C6ADAD00EFD6D600DEB5
      B500946B7300F7EFEF00DECECE00C6B5B500AD8C9400EFE7E700EFE7E700F7E7
      E700FFF7F700FFFFFF00FFFFFF00FFFFFF00E7DEE700D6C6C600FFFFFF00EFBD
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005273B500426BAD004A73
      B5004A73B5004A73B5005273B500527BBD00527BBD005A84C6005A84C600638C
      CE00738CC600D68C8C00D68C8C00D6948C00D68C8C00D6949400D6948C00D68C
      8C00D6948C00CE8C9400737BB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00848C9C00396B9C004A7BAD004273A500396B9C00396B94003163
      94005284B5008CBDEF008CBDF7006B9CD6005A8CBD0039639400396394003963
      9C00426B9C004A73A500527BAD005284BD0042638C00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500FFD6D600FFEFE7005A9CCE0042ADFF004AB5FF0052B5
      FF004AB5FF004AADF7009CC6DE00FFFFFF00FFFFFF00FFF7F700FFEFEF00FFEF
      E700FFE7DE00FFE7D600FFDECE00FFDECE00FFDECE00FFF7EF00FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00E7D6D600EFCECE00CEA5
      A500B5949400F7EFEF00C6ADB500EFEFEF00C6B5B500FFFFFF00DECECE00CEBD
      BD00C6B5B500C6B5BD00FFFFFF00FFFFFF00CEC6C600EFEFEF00FFFFFF00CE94
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B84BD004A73B5005273
      B500527BBD00527BBD005A7BBD005A7BC6006384C600638CCE00638CCE006B8C
      CE006B94D600BD8C9C00CE8C8C00D68C8C00CE8C8C00D68C8C00D68C8C00D68C
      8C00C68C8C005A73BD0094B5E700FF00FF00FF00FF00FF00FF00FF00FF006B7B
      94004A638400425A8C00426B9C004A7BAD005A84BD006394C6006B9CD60073A5
      D600396B9C006B9CCE008CBDF7006394CE00426B9C00427BAD00528CCE004A84
      C6004A7BBD004273AD00396BA50039639C00315A940039527B004A637B00FF00
      FF00FF00FF00E7BDBD00FFDED600FFF7E7004A9CCE004AADFF0052B5FF004AB5
      F7004AADF70052ADEF009CCEE700FFFFFF00FFFFFF00FFF7F700FFEFEF00FFF7
      F700FFFFF700FFFFFF00FFFFFF00FFFFF700FFF7F700FFFFFF00FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00F7EFEF00E7C6C600BD8C
      8C00CEBDBD00F7EFEF00AD949C00BDB5B500DECECE00E7DEDE00C6BDBD00D6C6
      C600D6D6D600EFE7E700FFFFFF00FFFFFF00C6ADB500FFF7F700FFF7EF00C694
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00738CBD005A7B
      BD005A7BBD005A84C6006384C6006384C6006B8CCE006B94CE006B94D6007394
      D600739CD6007B9CDE00BD8C9C00CE848400CE848C00CE848400CE8C8400BD84
      8C00426BC6009CBDE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B94
      AD005A8CBD0073A5DE0073ADDE007BADDE007BADDE007BADE70084B5E70084B5
      EF0073A5D600426B9C0084B5E7005284B5004A7BAD006BA5E7006BA5E7006BA5
      DE006B9CDE00639CDE00639CD6006394D6005A94CE00528CCE004273A500FF00
      FF00FF00FF00E7BDBD00FFDED600FFF7EF006B9CC600398CCE004A9CD60052A5
      DE004AA5DE004A94CE00BDD6E700FFFFFF00FFFFFF00FFEFE700FFD6C600FFD6
      BD00FFD6BD00FFD6BD00FFD6C600FFDECE00FFE7D600FFF7F700FFFFFF00DECE
      C600BDB5AD00FF00FF00FF00FF00FF00FF00C6B5BD00F7EFE700EFC6C600AD73
      7B00EFE7E700EFEFEF00C6B5BD00FFFFFF00E7E7E700DED6D600DED6D600EFE7
      E700E7DEDE00EFE7E700FFFFFF00FFF7F700C6B5B500FFFFFF00FFD6D600B59C
      A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006384
      C6006384C600638CCE006B8CCE006B8CCE007394D6007394D6007B9CD6007B9C
      DE007B9CDE0084A5E7008CA5DE00BD94A500CE848400CE848400A57B94003963
      C600A5BDE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006B8CA5006B9CCE007BB5E70084B5EF0084B5EF0084BDEF008CBDEF008CBD
      F7008CBDEF006B94C6004A73A50042739C0084B5EF0084BDEF0084BDEF007BB5
      EF007BB5EF007BB5EF0073B5E70073ADE70073A5E700527BAD00FF00FF00FF00
      FF00FF00FF00EFBDBD00FFDEDE00FFFFF700B5CEDE005A9CCE0084BDDE008CBD
      E70063ADDE007BB5CE00EFF7F700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700FFF7EF00FFEFE700FFEFDE00FFE7D600FFDED600FFF7EF00FFFFFF00DECE
      C600C6B5AD00FF00FF00FF00FF00FF00FF00AD949C00F7E7E700E7BDBD00AD7B
      8400FFF7F700DECECE00E7D6DE00FFFFFF00F7FFFF00E7E7E700D6CECE00C6B5
      B500C6B5B500FFFFFF00DEBDA500C69C7B00BD9C7B00EFD6C600F7B5B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B9C
      CE006B8CCE006B8CCE006B94D6007394D6007B9CDE007B9CDE0084A5DE0084A5
      E70084A5E7008CADEF008CADEF0094ADE700BD949C00CE8484003163CE009CB5
      DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0063849C006394C6006394C6006394CE006394CE006394CE005A94
      C600528CBD005A84BD004A7BAD00294A7300294A7B0031528400395A94004263
      9C004A73A5005A7BB500638CC6006B9CD600527BAD00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBDBD00FFDEDE00FFFFFF00EFF7FF00B5D6E70094C6DE009CCE
      DE009CC6DE00DEEFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECE
      C600C6B5AD00FF00FF00FF00FF00FF00FF00AD848C00FFF7F700E7CECE00B594
      9C00F7FFFF00DED6D600BDADB500BDA5AD00C6B5B500D6C6CE00E7D6DE00F7EF
      EF00F7F7F700FFFFFF00CE9C4200F7CE7B00EFD69400DEAD8C00DE949400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008CA5D600739CDE00739CDE007BA5DE0084A5E7008CA5E7008CADE7008CAD
      EF008CADEF008CB5F70094B5F7009CBDF7009CB5EF008C84B500A5BDDE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00637B9C00739CCE007BADDE0073A5D600639CCE006394CE005A94
      CE005A8CC6006394CE005284B500294A7B0021426B0018396B0029397300314A
      7B0039528C004A6BA5005A84B5006394C60042638C00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFDEDE00FFFFFF00FFFFFF00F7FFFF00EFF7F700EFF7
      F700F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECE
      C600C6B5B500FF00FF00FF00FF00FF00FF00AD8C8C00FFFFFF00DECECE00C6A5
      A500F7F7F700FFF7F700FFFFFF00FFFFFF00FFFFFF00EFEFEF00DED6DE00CEC6
      C600C6B5BD00BDB5B500EFCE7B00FFDEB500F7C6B500EFC6C600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0094ADDE0084A5E70084A5E7008CADEF008CADEF008CB5EF0094B5
      EF0094B5F70094BDF7009CBDFF00A5C6FF00A5C6FF00A5C6EF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007384A5006B9CD60084B5EF0084B5EF008CBDEF008CBDF7008CBDF7008CBD
      EF0084B5EF0073A5DE00426B9C0039638C0073A5D60084B5E7008CBDEF008CBD
      F7008CC6F7008CC6F7008CBDF7008CBDF7007BADDE00425A7300FF00FF00FF00
      FF00FF00FF00EFC6BD00FFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7DED600F7E7DE00FFEFE700FFEF
      EF00FFF7F700FFF7F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFF700E7CE
      C600C6B5B500FF00FF00FF00FF00FF00FF00C6ADAD00FFFFFF00E7DEDE00C6A5
      AD00CEA5A500CEA5A500D6ADAD00DEADB500E7C6C600EFCECE00F7DEDE00F7E7
      E700FFEFEF00F7EFE700F7C6AD00EFBDB500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A5C6EF0094BDF7009CBDF7009CBDF700A5BD
      FF00ADC6FF00C6D6EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008494
      AD005A84BD0073A5DE007BADDE007BADE7007BB5E70084B5E70084B5EF0084BD
      EF008CBDEF0073A5DE006B7B9C00FF00FF00638CBD0084B5EF0084B5EF0084B5
      EF0084B5EF0084B5E7007BB5E7007BADE7007BADE7006394C6004A5A7300FF00
      FF00FF00FF00EFC6BD00FFDEE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00BD9C9400E7D6CE00FFE7DE00FFDE
      D600F7DED600F7DECE00F7DECE00FFDECE00FFDED600FFDED600FFE7D600EFD6
      CE00FF00FF00FF00FF00FF00FF00CEB5B500C6ADAD00F7EFEF00F7F7F700FFFF
      FF00FFFFFF00FFFFFF00FFF7F700F7EFEF00EFDEDE00EFD6D600D6946B00EFB5
      9C00EF9C9C00EFADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A5BDFF00A5C6FF00A5C6FF00ADC6
      EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A73
      9C00527BA5005284B5005A8CC6006B9CCE0073A5DE007BADDE007BADE7007BAD
      E70073ADE70052739C00FF00FF00FF00FF00FF00FF00638CBD007BADDE007BAD
      DE0073ADDE0073A5DE006BA5DE00639CCE006394BD005284B50039638C00FF00
      FF00FF00FF00EFC6BD00F7D6D600FFF7F700FFF7F700FFFFF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00B59C9400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CEBDBD00D6ADAD00D6ADAD00D6A5
      AD00DEA5AD00DEADB500E7BDBD00F7C6CE00FFDEDE00F7D6CE00DE9C7300F7B5
      AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00B5CEF700BDCEEF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00738CAD005A7BA500527BA5005A84
      B500527BA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005284B500527B
      AD004A739C005A7BA5007384A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFD6CE00F7DED600F7DED600F7DED600F7DED600F7DE
      D600F7DED600F7DED600FFE7D600FFDECE00CEBDB500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00F7DEDE00EFCECE00F7C6BD00F7C6C600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C8C8C00C67373004A29
      2900FF00FF00FF00FF005252840008089C004A526300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A56B6B00EF949400D6847B006331
      31004A2929005252B5006363CE000808AD0000009400FF00FF00FF00FF00FF00
      FF00AD848400A57B7B009C7B7B009C847B00AD9C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009CA5
      9C006B8473003984520021844200399C5A00529C7300528C6B005A7B6B00737B
      73009C9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006B6B6B00735A5A006B39390042424200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF004A4A5A002121840021214200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00E78C8C00FF9C9C00D68484006331
      31004A0808004239A500635ACE000808AD000000A500FF00FF00FF00FF00FF00
      FF00E7B5A500E7B5A500DEAD9C00CEA59400A57B7B00FF00FF00FF00FF00BD9C
      9C00AD949400A58C9400A5949400ADA5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00427B520021733900108C
      3100109C390010943900109C390031B5630052B57B0052B573005ABD84005AB5
      84004A946B004A735200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A29
      2900DE848400FF9C9C009C5A52005229290042393900FF00FF00FF00FF00FF00
      FF00FF00FF00181839004A429400635ACE003131BD000000AD0021213900FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00E78C8C00FFB5AD00EFCECE007B4A
      4A0042000000006394005A5AB500424ACE000000A500FF00FF00FF00FF00D6B5
      B500F7C6AD00FFD6AD00FFD6AD00F7CEA500B58C8400FF00FF00FF00FF00D6A5
      9C00E7B5A500D6A59C00C69C9400B58C8400AD8484009C7B7B0094848400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0039845200108431001094310008A53900109C
      390010A5390008B5420008C6520018D66B0039DE8C0052D68C004ABD73004AAD
      730052BD84004A8C6300A5A59C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0073737300845A5A00AD6B6300FF9C
      9C00FF9C9C00FF9C9C009C5A5200633131004A212100423939004A4A4A003939
      5A00393973006363CE006363CE006363CE003131BD000000AD0000008C002121
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00E7C6C600FFDEDE00D6ADAD004A63
      6B000884A50000ADFF00086BB5007B7BE7003131C600FF00FF00FF00FF00D6AD
      AD00F7C6AD00FFD6AD00FFD6AD00F7D6AD00C69C8C0094847B00B5949400F7CE
      B500FFDEBD00FFDEBD00FFDEC600F7D6BD00EFCEBD00DEB5AD00A5848400FF00
      FF00FF00FF00B58C8C00A58484009C8484009C8C8400A59C9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00298C420008AD420008B54A0008BD520000CE
      5A0000DE630000E76B0008CE6B0021A5630039A56B0039AD6B0029B56B0021D6
      730029BD6B005A946B00D6D6D600EFEFEF00DEDEDE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005A393900F7949400FF9C9C00FF9C
      9C00FF9C9C00FF9C9C009C5A5200633131006331310052292900101029005A5A
      BD006363CE006363CE006363CE006363CE003131BD000000AD000000A5000000
      940021214200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A58C8C00FFCECE0042636B0000C6
      F70000CEFF0000ADFF00009CFF004A52AD005A5AC600FF00FF00FF00FF00D6AD
      AD00F7C6B500FFD6B500FFDEB500FFDEB500EFCEAD00C6A58C00DEB5A500FFDE
      BD00FFE7C600FFE7C600FFE7CE00FFE7CE00FFE7CE00EFD6C600A5847B00FF00
      FF00D6BDB500EFC6BD00EFCEBD00E7BDB500D6ADAD00B58C8C00B5A5A500FF00
      FF00FF00FF00FF00FF00FF00FF00529C630029B5630018C6630021845200527B
      6B007B9C8C00638C7B00395A4A005A6363007B7B7B0084848400636B63005A73
      63008CA59400BDC6C6009494A500424284008C8C9400C6CEC6009C949400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0073424200FF9C9C00FF9C9C00FF9C
      9C00FF9C9C00FF9C9C009C5A5200633131006331310052212100101031005A5A
      C6006363CE006363CE006363CE006363CE003131BD000000AD000000A5000000
      AD0000009400FF00FF00FF00FF00FF00FF00FF00FF00847B7B00736B6B008484
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C84840042737B0000CE
      FF0000CEFF0000ADFF00009CFF00182952007B7B8C00FF00FF00FF00FF00D6AD
      AD00F7C6B500FFDEB500E7D6AD00DECE9C00CEC69C00D6C69C00DECEAD00F7DE
      BD00FFE7CE00FFE7CE00FFE7CE00FFEFD600FFEFD600F7E7CE00B59C8C009C84
      8400D6B5AD00FFEFDE00FFEFE700FFEFE700F7E7DE00CEB5AD00BDADA500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00525252007B7B
      7B00ADADAD00948C8C004A4A4A0063636300948C9400948C94005A5A5A005A5A
      5A0063637300525294005A52BD002121B50021217B0084848C00D6DED600B584
      8C00FF00FF00FF00FF00FF00FF00FF00FF0073424200FF9C9C00FF9C9C00FF9C
      9C00FF9C9C00FF9C9C009C5A5200633131006331310039080800080829003939
      A5005A5AC6006363CE006363CE006363CE003131BD000000AD000000A5000000
      AD0000009400FF00FF00FF00FF00FF00FF00FF00FF004A313100522931004239
      42006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00215A6B0000CE
      FF0000CEFF0029B5FF00009CFF006B7B8400FF00FF00FF00FF00FF00FF00DEB5
      AD00F7CEB5000000840000008400000084000000840000008400000084000000
      840000008400D6D6AD00FFEFD600FFEFDE00FFEFDE00FFEFDE00EFDECE00DEC6
      BD00F7E7D600FFF7E700FFF7EF00FFF7EF00FFF7EF00D6BDB500B5ADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00524A52005A5A
      630073737B006B6B6B004A4A4A00847B7B009C9C9C009C9C9C00737373004229
      3100424294006363CE00635ACE002121B5000000A50018187300C6C6C600CE9C
      9C00FF00FF00FF00FF00FF00FF00FF00FF0073424200FF9C9C00FF9C9C00FF9C
      9C00FFA59C00FFB5B5009C636300633131004A1818004A000000080829002929
      8C00292984005A5AC6006363CE008484DE004A4AC6000000AD000000A5000000
      AD0000009400FF00FF00FF00FF00FF00FF00FF00FF0052313100523131007373
      730094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A7B8C0031DE
      FF0073F7FF0000F7FF0000ADFF0073848C00FF00FF00FF00FF00FF00FF00DEB5
      B500EFCEB50000008400000084000000FF000000FF000000FF008484FF000000
      FF000000840000008400DEDEBD00FFEFDE00FFEFDE00FFF7E700FFF7E700FFF7
      E700FFF7EF00FFF7EF00FFF7F700FFF7F700FFF7EF00D6BDBD00B5ADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00524A52007373
      73009C9C9C008C8C8C0052525200948C8C00B5ADAD00ADA5A5007B6B73003918
      2100312984005A5AC6006363CE002121BD000000A50000007300DEDEDE00CEB5
      BD00FF00FF00FF00FF00FF00FF00FF00FF0073424200FF9C9C00FF9C9C00FFBD
      B500FFD6D600FFE7E700CEA5A5006B3139004A1818004A000000000010000842
      6B0000527B00393984008484E700B5ADEF009494EF001010B5000000A5000000
      AD0000009400FF00FF00FF00FF00FF00FF00FF00FF0031313100313131009494
      9400CECECE004A4A63005A5A7B004A4A7B003163AD002163C6002163CE00185A
      C600216BD6002984EF002984EF00296BCE004A4A6B00FF00FF00FF00FF0039A5
      A50000FFFF0000FFFF0000D6D600FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7CEBD0000008400000084000000FF000000FF008484FF008484FF000000
      FF000000FF0000008400CEDEB500FFEFE700FFEFDE00FFF7E700FFF7EF00FFF7
      EF00FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700D6C6BD00BDADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00635A5A009C94
      9C00B5ADB500A59C9C00635A6300BD848400B5949400AD8C8C006B3942003108
      100008427300294A9C00847BD6005A5AD6000000AD0000007300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00734A4A00FFA5A500FFE7E700FFDE
      DE00FFD6D600FFCECE00FFCECE00B5848400390808001810100000A5CE0000BD
      E70000A5FF0008639C004A529C006363CE008484E7008484F7000808AD000000
      A50000009C00FF00FF00FF00FF00FF00FF00FF00FF003939390039393900A5A5
      A500E7E7E7004A84CE004A8CDE00529CEF003194F7002173E7001042AD001031
      9C00184AAD00216BD6005AB5FF005AADFF004A84D60039528400FF00FF00FF00
      FF0031A5A50031949400A5B5B500FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7D6C600E7DEBD0000008400000084000000FF008484FF008484FF000000
      FF000000FF0000008400E7E7CE00FFE7D600FFD6BD00FFD6BD00FFDEC600FFDE
      CE00FFEFDE00FFEFE700FFF7EF00FFFFFF00FFFFFF00D6C6BD00BDADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C7B7B00BDB5B500A59C
      9C00A5A5A500A5A5A5008C7B7B00F7CECE00FFD6D600DEB5B5004A6B73000884
      A50000BDEF00008CDE00315AAD00736BDE003939C60000007300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00736B6B00FFEFEF00FFCECE00FFCE
      CE00FFCECE00DEB5B500A5848400084A5A000084A50000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00005A940042428C006363CE007B7BE7006B6BDE001008
      AD0000009C00FF00FF00FF00FF00FF00FF00FF00FF004A4A4A00524A5200A5AD
      AD00EFE7EF007BBDEF007BBDFF006BB5FF003994FF003184E700297BDE00186B
      BD00639CD6006394DE0073BDDE007BBDEF008CD6FF0084BDF700636B7B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7D6C600FFEFD600CED6B50000008400217B9C00318CC600428CB5000000
      840000008400C6DEBD00FFF7EF00FFF7E700FFEFDE00FFE7D600FFE7D600FFDE
      C600FFD6BD00FFCEB500FFCEB500FFF7E700FFFFFF00DEC6C600BDADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00B5ADAD00C6ADB500DEBDBD009C73
      7B00E7D6D600BDA5A500C6BDBD00D6B5AD00FFCECE005A737B0000C6F70000CE
      FF0000CEFF0000A5FF00008CDE003952A5005252B50031317300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00847B7B00D6ADAD00FFCECE00FFCE
      CE00FFCECE00A584840000526B0000CEF70000CEFF0000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00009CFF00005A9C00423984006363CE006363CE004A4A
      C60008089C00FF00FF00FF00FF00FF00FF00FF00FF00635A6300635A6300ADAD
      AD00F7EFF70084C6EF008CCEFF008CCEFF007BCEFF007BCEFF007BCEFF004AA5
      CE009CD6F7008CBDE700BDBDCE00ADB5D6007BB5DE0094DEF7005A7BB5007B7B
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBD
      B500F7D6C600FFEFDE00CED6D6004294D6002994F700319CFF002994F7004A9C
      D600D6DEE700FFF7EF00FFF7F700FFF7EF00FFF7EF00FFF7F700FFFFF700FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFFF00FFFFFF00DEC6BD00BDADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009C848400EFD6D600D6A5AD00AD8C
      8C00F7E7DE00C6ADAD00F7E7E700C6BDBD00D6ADAD0052737B0000CEFF0000CE
      FF0000CEFF0000A5FF00009CFF00215A8C009494A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073737300DEADAD00FFCE
      CE00FFCECE00A58484000084A50000CEFF0000CEFF0000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00009CFF00009CFF00005284004A4A9C004A4AA5004242
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B6B6B0073737300BDB5
      BD00FFFFFF00A5E7EF00A5E7FF009CDEFF00A5E7FF00B5EFFF00C6F7FF00ADDE
      E7009CBDD6008C9CC600FF00FF00FF00FF00FF00FF0094ADCE006B94CE00B5AD
      BD00FF00FF00FF00FF00FF00FF0010EF9400FF00FF00FF00FF00FF00FF00E7BD
      B500F7D6CE00FFEFDE0094BDD6003194EF0039A5FF0042A5FF0039A5FF00429C
      EF00ADCEDE00FFFFF700FFFFFF00FFE7E700FFD6C600FFDEC600FFDECE00FFE7
      D600FFE7DE00FFEFDE00FFEFE700FFFFF700FFFFFF00DEC6C600BDB5AD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00B59C9C00EFCECE00BD8C9400CEBD
      BD00DEC6CE00BDA5AD00CEBDBD00CEC6C600C6BDBD0042737B0000CEFF0031DE
      FF004AE7FF0000ADFF00009CFF004A84A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B737300C6A5
      A500FFCECE00A58484000084A50000CEFF0000CEFF0000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00009CFF00009CFF0000528C0021214A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B7B7B0084848400C6C6
      C600FFFFFF00A5B5CE00C6DEEF00DEF7FF00EFF7FF00E7EFFF00ADBDCE00CECE
      DE00FF00FF00FF00FF00FF00FF006BEFAD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0031EF9C0008EF840000E77B0018EF9400FF00FF00FF00FF00E7BD
      B500FFD6D600FFEFE7005A9CCE0042ADFF004AB5FF0052B5FF004AB5FF004AAD
      F7009CC6DE00FFFFFF00FFFFFF00FFF7F700FFEFEF00FFEFE700FFE7DE00FFE7
      D600FFDECE00FFDECE00FFDECE00FFF7EF00FFFFFF00DEC6C600BDB5AD00FF00
      FF00FF00FF00FF00FF00FF00FF00ADA5A500DECECE00E7C6C600AD848C00EFDE
      DE00C6B5B500F7E7E700C6B5B500EFEFEF00D6C6CE00739C9C0052EFFF0031FF
      FF0000FFFF0000EFFF0000ADFF004A84AD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00847B
      7B00C69C9C00292121000084A50000CEFF0000CEFF0000CEFF0000CEFF0008D6
      FF0000A5FF00009CFF00009CFF00009CFF0000528C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008CDE9C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0039E77B0000E75A0000E7630021D66B00FF00FF00FF00FF00E7BD
      BD00FFDED600FFF7E7004A9CCE004AADFF0052B5FF004AB5F7004AADF70052AD
      EF009CCEE700FFFFFF00FFFFFF00FFF7F700FFEFEF00FFF7F700FFFFF700FFFF
      FF00FFFFFF00FFFFF700FFF7F700FFFFFF00FFFFFF00DEC6C600BDB5AD00FF00
      FF00FF00FF00FF00FF00FF00FF00A58C8C00F7E7E700E7B5BD00AD8C8C00F7EF
      EF00AD9C9C00D6CECE00C6B5B500EFEFEF00DED6D600BDCECE0021D6D60000FF
      FF0000FFFF0000FFFF0008CEDE006B94AD00C69C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084848400FF00FF000084A50000CEFF0000CEFF0039DEFF006BE7FF00ADFF
      FF0018C6FF00009CFF00009CFF00009CFF0000528C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF006BEFAD00FF00FF00FF00FF00FF00
      FF00FF00FF0000DE520000DE4A0008DE5200FF00FF00FF00FF00FF00FF00E7BD
      BD00FFDED600FFF7EF006B9CC600398CCE004A9CD60052A5DE004AA5DE004A94
      CE00BDD6E700FFFFFF00FFFFFF00FFEFE700FFD6C600FFD6BD00FFD6BD00FFD6
      BD00FFD6C600FFDECE00FFE7D600FFF7F700FFFFFF00DECEC600BDB5AD00FF00
      FF00FF00FF00FF00FF00FF00FF00B59CA500F7E7E700D6ADAD00C6ADAD00EFEF
      EF00D6C6C600E7DEDE00CEC6C600EFE7E700DED6D600CEC6C6009CC6C60010D6
      D60000DEDE0031ADAD009CBDBD00EFEFEF00C6B5B500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000084A50018D6FF009CEFFF0073FFFF0042FFFF0000FF
      FF0000FFFF0000C6FF00009CFF00009CFF0000528C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0031B54A0042DE7B00FF00FF00FF00
      FF00FF00FF0000DE420000DE4200FF00FF00FF00FF00FF00FF00FF00FF00EFBD
      BD00FFDEDE00FFFFF700B5CEDE005A9CCE0084BDDE008CBDE70063ADDE007BB5
      CE00EFF7F700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7EF00FFEF
      E700FFEFDE00FFE7D600FFDED600FFF7EF00FFFFFF00DECEC600C6B5AD00FF00
      FF00FF00FF00FF00FF00CEBDBD00DECECE00F7DEDE00CE9C9C00DED6D600DED6
      D600E7DEDE00DED6D600E7E7E700E7E7E700D6CECE00CEBDBD00EFE7E700ADCE
      CE0094ADA500DEDED600DEC6AD00EFB5B500CECECE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00739CA5009CFFFF0018FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000CEFF00009CFF0000528C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073C67B0010D6420010DE
      420000DE310000D6290000CE2900FF00FF00FF00FF00FF00FF00FF00FF00EFBD
      BD00FFDEDE00FFFFFF00EFF7FF00B5D6E70094C6DE009CCEDE009CC6DE00DEEF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600C6B5AD00FF00
      FF00FF00FF00FF00FF00B59C9C00F7EFF700FFF7F700BD9C9C00F7EFEF00EFE7
      E700D6C6CE00C6B5BD00C6BDBD00CEC6C600CEC6C600D6C6C600DEDEDE00E7CE
      BD00DEAD5A00FFDE9C00EFBD9C00E7ADAD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF002984840000F7F70000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000C6FF0000528C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CCE940052BD
      630039BD52005AC66B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFDEDE00FFFFFF00FFFFFF00F7FFFF00EFF7F700EFF7F700F7F7FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600C6B5B500FF00
      FF00FF00FF00FF00FF00B5949400FFFFFF00FFFFFF00C69C9C00D6BDBD00DEC6
      CE00EFD6DE00F7E7E700F7EFEF00FFF7F700F7F7F700F7F7F700E7E7E700C69C
      7300F7D6A500F7BDB500F7DED600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF001073730000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000F7F70000525A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7DED600F7E7DE00FFEFE700FFEFEF00FFF7F700FFF7
      F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFF700E7CEC600C6B5B500FF00
      FF00FF00FF00FF00FF00BD9C9C00FFFFFF00FFFFFF00F7F7F700F7EFEF00EFE7
      E700EFD6D600E7CECE00E7C6C600E7BDC600DEA58C00EFB5AD00EFB5BD00E79C
      8C00EFC6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00297B7B0000EFEF0000FFFF0000FF
      FF0000BDBD00188C8C004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFDEE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00BD9C9400E7D6CE00FFE7DE00FFDED600F7DED600F7DE
      CE00F7DECE00FFDECE00FFDED600FFDED600FFE7D600EFD6CE00E7DED600FF00
      FF00FF00FF00FF00FF00CEB5B500CEADAD00D6ADB500DEB5B500DEB5BD00E7BD
      BD00EFC6C600F7D6D600F7E7DE00F7DED600DEA57B00F7BDB500F7DEDE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002973730000D6D600006B
      6B007B8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00F7D6D600FFF7F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00B59C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7DEDE00F7D6D600F7CECE00F7D6D600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A737300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFD6CE00F7DED600F7DED600F7DED600F7DED600F7DED600F7DED600F7DE
      D600FFE7D600FFDECE00CEBDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBDA500E7B59400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00D6B5AD00DEB59C00E7B59400FFC6
      9C00FFCE9C00FFCE9C00FFCEA500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00396342002963390039735200425A42005A6B5A007B84
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00847B7B00736B6B00736B
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AD848400A57B
      7B009C7B7B009C847B00AD9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00D6CECE00DEC6BD00E7BDAD00FFCEA500FFD6AD00FFD6AD00FFD6AD00FFD6
      A500FFD6A500FFCEA500FFD6A500E7B5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00425A
      4A0021633100108C3100109C390021AD52005AC6840063BD8C00529C7300397B
      5A0039634A00525A5A007B7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008C8484004A313100522931004A29
      31006B6B6B0084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7B5A500E7B5
      A500DEAD9C00CEA59400A57B7B00FF00FF00FF00FF00BD9C9C00AD949400A58C
      9400A5949400ADA5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEA5
      9C00F7CEB500FFDEBD00FFDEB500FFD6B500FFD6B500FFD6B500FFD6AD00FFD6
      AD00FFD6A500FFD6A500FFD6A500E7B59400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004A6352003163390010843100089C
      3900089C390018943900089C310018AD4A005AC684004AA56B0052AD73005ABD
      84006BC69400529C73004273520031523900FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00847B840052313100523131005231
      3100949494006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00636B84004A5A84005A5A73007B7B8400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6B5B500F7C6AD00FFD6
      AD00FFD6AD00F7CEA500B58C8400FF00FF00FF00FF00D6A59C00E7B5A500D6A5
      9C00C69C9400B58C8400AD8484009C7B7B0094848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00EFC6B500F7D6B500EFCEAD00EFBDAD00CE9C
      8C00EFBDA500F7C6AD00F7D6B500FFDEB500FFDEB500FFD6B500F7D6AD00F7D6
      AD00F7CEAD00F7CEA500F7CEA500FFC6A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0042735200108C3900108C310010A5310008AD3900109C39001894
      3100109C390008C64A0008D6520000E76B0021F78C0052E794005AD68C004ABD
      7B0042A563005AB5840063C684004A946300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008484840031313100313131003931
      3100CECECE006B6B73004A4A63005A5A7B004A4A7B003163AD002163C600216B
      D6002163CE00215AC600216BD6002984EF003194FF00296BCE00295294004A4A
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6ADAD00F7C6AD00FFD6
      AD00FFD6AD00F7D6AD00C69C8C0094847B00B5949400F7CEB500FFDEBD00FFDE
      BD00FFDEC600F7D6BD00EFCEBD00DEB5AD00A5848400FF00FF00FF00FF00B58C
      8C00A58484009C8484009C8C8400A59C9C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00F7D6BD00FFDEBD00FFDEBD00FFDEB500FFD6
      AD00F7CEA500F7BD9C00E7AD9400C6948400C6948400CE9C8400CE9C8C00D6A5
      8C00D69C8400CE9C8400CE9C8400FFD6AD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00427B520010A53900089C3900109C3900109C390008C64A0000DE
      630000EF6B0000FF7B0000FF730000EF7B0010D66B0010CE730010D6730018EF
      8C0029FF940031D67B0031BD730031945A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008484840039393900393939003939
      3900E7E7E700738CB5004A84CE004A8CDE00529CEF003194F7002173E7001852
      C6001042AD001039A500184AAD00216BD600398CF7005AADFF005AADFF004A84
      D600395284006B637300FF00FF00FF00FF00FF00FF00D6ADAD00F7C6B500FFD6
      B500FFDEB500FFDEB500EFCEAD00C6A58C00DEB5A500FFDEBD00FFE7C600FFE7
      C600FFE7CE00FFE7CE00FFE7CE00EFD6C600A5847B00FF00FF00D6BDB500EFC6
      BD00EFCEBD00E7BDB500D6ADAD00B58C8C00B5A5A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7C6BD00FFDEC600FFDEBD00EFC6A500BDA58C00DEBD
      9C00F7D6A500FFD6AD00FFD6AD00F7BD9C00E7A58C00D69C7B00CE947B00DEAD
      8C00FFC69C00F7C69400CE947B00F7D6AD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF004A73520008B5420008CE520000DE630000E76B0000D6630008CE
      6B0008CE6B0008D66B00108C5200315242004A6B5A006B7B7B005A736300395A
      4A0021844A0018B56300399C5A004A845200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00848484004A4A4A00524A52005252
      5200EFE7EF0094ADC6007BBDEF007BBDFF006BB5FF003994FF003184E700317B
      DE00297BDE00297BD600639CD6006394DE004A7BCE007BBDEF008CD6FF008CD6
      FF0084BDF700526BA500FF00FF00FF00FF00FF00FF00D6ADAD00F7C6B500FFDE
      B500E7D6AD00DECE9C00CEC69C00D6C69C00DECEAD00F7DEBD00FFE7CE00FFE7
      CE00FFE7CE00FFEFD600FFEFD600F7E7CE00B59C8C009C848400D6B5AD00FFEF
      DE00FFEFE700FFEFE700F7E7DE00CEB5AD00BDADA500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7BDAD00FFE7CE00F7CEB500F7CEAD007B736B003942
      4A0052739C0073849C00B59C9400FFCEA500FFCEA500FFCEA500DE9C8400E7B5
      8C00FFCEA500FFC69C00C6948400F7D6AD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF005A7B5A0008AD4A0000CE630008DE6B0008944A00636B63008C84
      8C009C949C0052635A00393939005A63630063636300847B840084848400847B
      7B004A4A42007B847B00FF00FF00FF00FF007373730021216B00393952009C9C
      9C00FF00FF00FF00FF00FF00FF00FF00FF008C8C8C00635A6300635A63006363
      6300F7EFF7009CB5C60084C6EF008CCEFF008CCEFF007BCEFF007BCEFF0084CE
      FF007BCEFF007BD6F7009CD6F7008CBDE70063739C00ADB5D6007B9CC6007BB5
      DE0094DEF70094CEFF007B738400FF00FF00FF00FF00DEB5AD00F7CEB5008442
      000084000000840000008400000084000000840000008400000084420000D6D6
      AD00FFEFD600FFEFDE00FFEFDE00FFEFDE00EFDECE00DEC6BD00F7E7D600FFF7
      E700FFF7EF00FFF7EF00FFF7EF00D6BDB500B5ADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00F7D6C600FFE7C600EFCEB500F7D6B500C6B5A50094B5
      D6006B9CD6003173D6000852C600F7CE9C00FFCEA500FFCE9C00CE947B00EFC6
      9C00FFCEA500FFCE9C00CE9C8400F7D6B500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0063846B0039423900736B73008484
      840094949400736B6B0031313100635A5A0084848400BD9494009C9CA5007B73
      7B004A424A009C9C9C0084848400525263005A52BD003939C600000094003939
      5200FF00FF00FF00FF00FF00FF00FF00FF008C8C8C006B6B6B00737373007373
      7300FFF7FF00ADC6CE00A5E7EF00A5E7FF009CDEFF00A5E7FF00B5EFFF00C6F7
      FF00C6F7FF00ADCEDE009CBDD6008C9CC600FF00FF00FF00FF00FF00FF00CECE
      DE0094ADCE0084C6DE00FF00FF00FF00FF00FF00FF00DEB5B500EFCEB5008400
      000084000000844200008442000084420000FF84000084420000840000008400
      0000DEDEBD00FFEFDE00FFEFDE00FFF7E700FFF7E700FFF7E700FFF7EF00FFF7
      EF00FFF7F700FFF7F700FFF7EF00D6BDBD00B5ADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFEFD600FFDEC600EFC6B500EFC6AD00DEBDA500BDD6
      E70084B5EF004A94F700186BE7008C8C8C00F7C69C00F7C69C00C6947B00F7CE
      A500FFD6AD00FFCEA500C69C8400EFD6B500D6ADA500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005252520084848400B5B5
      B500CECECE00737B7B00313131004A4A4A006B63630094949C007B7B7B005A5A
      5A00524A4A0039423900393973005252AD006363CE003939C6000000AD000000
      84009C9C9C00FF00FF00FF00FF00FF00FF00948C94007B7B7B00848484008C84
      8C00FFFFFF00ADB5BD00A5B5CE00C6DEEF00DEF7FF00EFF7FF00E7EFFF00C6CE
      DE00ADBDCE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5B500F7CEBD008442
      0000840000008442000084420000FF840000FF84000084420000844200008400
      000084420000FFEFE700FFEFDE00FFF7E700FFF7EF00FFF7EF00FFF7EF00FFFF
      F700FFFFF700FFFFF700FFFFF700D6C6BD00BDADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFEFDE00EFD6BD00EFC6B500EFCEB500E7C6A500C6CE
      D6008CBDFF00529CFF004A94FF000852BD008C848C00DEA58400CEAD8C00FFD6
      AD00FFD6AD00FFCEA500CE9C8C00EFD6BD00E7BDAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00524A4A00524A5200635A
      63006B636B005A525A0039393900736B6B007B737B00949494008C8C8C008C84
      8C00524A4A00312963006363CE006363CE006363CE003939C6000000AD000000
      A50039395200FF00FF00FF00FF00FF00FF009C949C00848484008C8C8C008C84
      8400BDB5BD00ADA5AD00C6C6CE00CEC6DE00A5A5C600A59CC600B5B5C600DED6
      DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5B500F7D6C600E7DE
      BD00840000008400000084420000FF840000C6D6C60084000000844200008400
      0000E7E7CE00FFE7D600FFD6BD00FFD6BD00FFDEC600FFDECE00FFEFDE00FFEF
      E700FFF7EF00FFFFFF00FFFFFF00D6C6BD00BDADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFEFDE00EFCEBD00EFCEBD00EFC6AD00EFBDA500CEB5
      A500ADCEE70084BDFF004A9CFF00186BDE000852C6006B637300D6B59400FFDE
      B500FFD6B500FFCEAD00CE9C8C00EFD6BD00F7D6BD00DECECE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00525252006B6B6B008484
      8400948C94007B737B0042424A008C8C8C00BDB5B500C6C6C600BDB5BD009C94
      9C005A4A520021215A005A5ACE006363CE006363CE003939C6000000AD000000
      A50000004A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB5B500F7D6C600FFEF
      D600CED6B50084000000217B9C00318CC600428CB50084000000840000008442
      0000FFF7EF00FFF7E700FFEFDE00FFE7D600FFE7D600FFDEC600FFD6BD00FFCE
      B500FFCEB500FFF7E700FFFFFF00DEC6C600BDADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FFE7D600EFCEBD00EFCEB500EFCEBD00EFC6AD00EFC6
      AD00CEB5A500ADC6DE008CBDFF004A94FF00186BDE000052C600847B8C00EFC6
      A500FFD6B500FFCEAD00CE9C9400DEC6B500E7BDB500EFD6CE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0042424A007B737B00949C
      9C00A5A5AD00736B6B00424242007B737B00A5949400ADADAD009C9C9C008C8C
      8C0052394200181852003939A5005A5AC6006363CE003939C6000000AD000000
      A50000004A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBDB500F7D6C600FFEF
      DE00CED6D6004294D6002994F700319CFF002994F7004A9CD600D6DEE700FFF7
      EF00FFF7F700FFF7EF00FFF7EF00FFF7F700FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFFF00FFFFFF00DEC6BD00BDADAD00FF00FF00FF00FF00FF00
      FF00FF00FF00DEBDBD00FFEFDE00F7D6C600EFD6C600EFCEBD00EFCEB500EFC6
      AD00EFC6AD00CEB5A500A5C6DE00529CFF004A94FF00186BE7000852C6008484
      9400DEBDA500F7CEAD00BD848400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00635A5A00D6CECE00DEDE
      DE00E7DEDE00B5B5B5005A525200CE9C9400FFC6C600FFDED600FFCECE00AD7B
      7B0042101000004A5A0000B5EF0000639C006B6BDE008C8CF7004A52D6000000
      A50000004A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00528CE700007BFF001063EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BDB500F7D6CE00FFEF
      DE0094BDD6003194EF0039A5FF0042A5FF0039A5FF00429CEF00ADCEDE00FFFF
      F700FFFFFF00FFE7E700FFD6C600FFDEC600FFDECE00FFE7D600FFE7DE00FFEF
      DE00FFEFE700FFFFF700FFFFFF00DEC6C600BDB5AD00FF00FF00FF00FF00FF00
      FF00FF00FF00DEBDBD00F7DECE00EFD6C600EFD6C600EFCEBD00EFCEB500EFCE
      BD00EFCEB500EFC6AD00D6CEBD0084BDFF00529CFF004A94FF00186BE7000852
      C60084849400DEB59C00B5847B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084737300736B
      6B007B7B7B00847B7B007B6B6B00F7D6D600FFDEDE00FFCECE00EFC6C6006B63
      6300104A5A0000CEFF0000C6FF00009CFF00424A9C006B63D6008C8CF7003939
      CE0000005200FF00FF00FF00FF008CBDFF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A8CE700006B
      F700007BFF000084FF00007BFF00396BD600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BDB500FFD6D600FFEF
      E7005A9CCE0042ADFF004AB5FF0052B5FF004AB5FF004AADF7009CC6DE00FFFF
      FF00FFFFFF00FFF7F700FFEFEF00FFEFE700FFE7DE00FFE7D600FFDECE00FFDE
      CE00FFDECE00FFF7EF00FFFFFF00DEC6C600BDB5AD00FF00FF00FF00FF00FF00
      FF00FF00FF00E7CECE00EFD6CE00EFCEC600EFD6CE00FFEFDE00F7E7CE00F7D6
      C600F7CEBD00EFC6B500FFDEC600ADC6E70084BDFF00529CFF004A94FF00186B
      DE00085AC600848494009C736B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7E7E70084737300F7C6C600FFCECE00F7CEC6000021290000AD
      DE0000CEFF0000CEFF0000C6FF00009CFF0000639C004A4A9C006363CE006363
      CE0000005200FF00FF00FF00FF00528CF700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001073F7000073FF000084
      FF000084FF000084FF000084FF001063EF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BDBD00FFDED600FFF7
      E7004A9CCE004AADFF0052B5FF004AB5F7004AADF70052ADEF009CCEE700FFFF
      FF00FFFFFF00FFF7F700FFEFEF00FFF7F700FFFFF700FFFFFF00FFFFFF00FFFF
      F700FFF7F700FFFFFF00FFFFFF00DEC6C600BDB5AD00FF00FF00FF00FF00FF00
      FF00E7D6D600F7E7E700EFDED600E7CEC600E7CEC600EFCEC600EFCEC600FFE7
      D600FFEFD600FFE7CE00FFE7CE00D6C6B500A5BDDE0084BDFF00529CFF004A9C
      FF00186BE7000052C600636B8400A5847B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00DEDEDE0084737300F7C6C600F7CEC6000052630000CE
      FF0000CEFF0000CEFF0000C6FF00009CFF00009CFF0008528C004A4AA5005A52
      BD00FF00FF00FF00FF00FF00FF00216BF700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF006BB5F700299CFF000884FF00007B
      FF00007BFF00007BFF00007BFF00006BFF003963DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BDBD00FFDED600FFF7
      EF006B9CC600398CCE004A9CD60052A5DE004AA5DE004A94CE00BDD6E700FFFF
      FF00FFFFFF00FFEFE700FFD6C600FFD6BD00FFD6BD00FFD6BD00FFD6C600FFDE
      CE00FFE7D600FFF7F700FFFFFF00DECEC600BDB5AD00FF00FF00FF00FF00FF00
      FF00D6B5BD00FFFFFF00EFD6D600EFDED600EFD6CE00F7DED600FFEFDE00FFEF
      DE00FFEFD600FFEFD600FFEFD600EFC6B500B59C9C00A5C6DE0084BDFF00529C
      FF004A94F700186BDE000052CE008C9CBD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DEDEDE0084737300F7CEC6000052630000CE
      FF0000CEFF0000CEFF0000C6FF00009CFF00009CFF0000639C0029295200FF00
      FF00FF00FF00FF00FF00FF00FF00217BF700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00188CFF000073
      FF000073FF000073FF000073FF000073FF000052EF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBDBD00FFDEDE00FFFF
      F700B5CEDE005A9CCE0084BDDE008CBDE70063ADDE007BB5CE00EFF7F700FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7EF00FFEFE700FFEFDE00FFE7
      D600FFDED600FFF7EF00FFFFFF00DECEC600C6B5AD00FF00FF00FF00FF00FF00
      FF00EFCED600FFFFFF00EFD6D600EFD6CE00EFDED600EFD6CE00F7EFDE00FFEF
      E700EFC6BD00EFCEBD00EFCEBD00DEB5A500CEBDAD00DECECE00A5C6DE0084BD
      FF00529CFF004A94FF00186BE7001063CE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEDEDE007B6B6B000052630000CE
      FF0000CEFF0010D6FF0018CEFF00009CFF00009CFF0000639C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF003994FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00087BFF000073
      FF000073FF000073FF00007BFF0042ADFF003194FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBDBD00FFDEDE00FFFF
      FF00EFF7FF00B5D6E70094C6DE009CCEDE009CC6DE00DEEFF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DECEC600C6B5AD00FF00FF00FF00FF00FF00
      FF00E7BDC600F7E7EF00FFF7F700F7EFEF00FFEFE700FFF7EF00FFF7E700FFEF
      DE00EFD6C600FFF7EF00F7E7E700C69C9400DECEC600FFEFDE00CEB5B500ADCE
      E70084BDFF00529CFF004A94FF00186BDE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CECECE000052630000CE
      FF0000CEFF007BF7FF0063F7FF0000B5FF00009CFF0000639C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0063BDFF002952DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298CFF00006BFF00006B
      FF00006BFF00006BFF002173FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6BD00FFDEDE00FFFF
      FF00FFFFFF00F7FFFF00EFF7F700EFF7F700F7F7FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DECEC600C6B5B500FF00FF00FF00FF00FF00
      FF00D6CECE00CEB5B500E7C6C600EFD6D600FFEFEF00FFFFF700FFFFEF00F7DE
      D600F7E7DE00EFDEDE00D6ADAD00DED6CE00FFEFE700FFEFDE00F7D6CE00D6D6
      D600A5C6DE0084BDFF00529CFF004A94FF009C9CA500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001052630039DE
      FF00A5F7FF0010FFFF0000FFFF0000F7FF00009CFF0000639C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000052F7004252DE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000063FF000063FF000063
      FF000063FF00006BFF006BA5EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6BD00FFE7DE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
      F700F7DED600F7E7DE00FFEFE700FFEFEF00FFF7F700FFF7F700FFF7F700FFFF
      F700FFFFFF00FFFFFF00FFFFF700E7CEC600C6B5B500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CEB5B500CEB5B500DEB5B500E7BD
      B500D6B5AD00C6B5AD00D6D6CE00FFFFF700FFFFF700FFF7EF00EFCEC600DEB5
      B500D6D6DE00B5D6EF008CBDFF0094BDE700E7E7EF004A6BA500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00296363006BFF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000ADFF0000639C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF001073FF000052F7001031DE006B7B
      DE00FF00FF00FF00FF00FF00FF00FF00FF007394E7000063FF000063FF000063
      FF000063FF003184F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6BD00FFDEE700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
      EF00BD9C9400E7D6CE00FFE7DE00FFDED600F7DED600F7DECE00F7DECE00FFDE
      CE00FFDED600FFDED600FFE7D600EFD6CE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEADAD00CEAD
      AD00C6A5A500CEB5B500E7C6C600E7C6C600E7C6C600DEC6BD00D6ADAD00FF00
      FF00FF00FF00FF00FF00ADBDC600ADADAD006394DE000052C6005A7BB500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009CAD
      AD0000ADAD0000FFFF0000FFFF0000FFFF0063848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BBDFF00217BFF000052
      FF000042F7000042F700004AF700004AFF000052FF000052FF000052FF00005A
      FF001873FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6BD00F7D6D600FFF7
      F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
      EF00B59C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00949C9C00106BDE004A7BBD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF009CA5A50000DEDE0010A5A500425A5A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AAD
      FF00085AFF000052FF000052FF000052FF000052FF00005AFF00106BFF005294
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFD6CE00F7DE
      D600F7DED600F7DED600F7DED600F7DED600F7DED600F7DED600FFE7D600FFDE
      CE00CEBDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00528CCE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0052848400B5B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00429CFF002984FF00217BFF00297BFF00529CFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00946B
      6B008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A009C7B7B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BD66B007BD67B008CDE
      8C008CDE8C0042943900DEDEC600FFEFDE004A9442008CDE8C0084DE840073D6
      7300397B1800D68C6300E7947300EFA57B00F7A58400A5634A00DE8C6B00EF9C
      7B00AD634200E78C63007B635A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00AD848400A57B7B009C7B7B009C847B00AD9C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00637B6300211810005A00
      000063000000630000006300000063000000630000005A0000005A0808006329
      2900FF00FF00FF00FF00FF00FF00FF00FF00318431006BCE6B0084DE840094E7
      94005AAD5A00A5C69C00FFFFFF00E7E7EF0073AD6B0084D684008CDE8C0052AD
      52007B7B3900EF9C7B00F7A58400F7AD8400D69473009C736B00AD735200F7AD
      8400CE845A00D684630094847B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00E7B5A500E7B5A500DEAD9C00CEA59400A57B7B00FF00FF00FF00FF00BD9C
      9C00AD949400A58C9400A5949400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00636B7B0010315A0021396300525A7300737B8400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00396B3900006B0000081000007B31
      00008C3900008C3900008C3900008C3900008C3900006B210000420000005A00
      0000735A5A00FF00FF00FF00FF00FF00FF008CBD8C0042A542008CDE8C0073C6
      73006BA55A00F7F7E700FFF7EF00FFF7F7008CB5840084CE840084D684002173
      1800C6845A00F7A58400F7AD8C00F7B59400A5735A00D6CECE00A57B6B00F7AD
      8C00F7AD8400AD6B4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6B5
      B500F7C6AD00FFD6AD00FFD6AD00F7CEA500B58C8400FF00FF00FF00FF00D6A5
      9C00E7B5A500D6A59C00C69C9400B58C8400AD8484009C7B7B0094848400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B73
      7300295A9C002163C6001052AD00104A9C00084A9400294A8400737384006B63
      6B00847B8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0018521800007B0000007B000000180000E773
      0000FF7B0000FF7B0000FF7B0000FF7B0000FF7B0000EF730000D66B00008C39
      00002100000063637300FF00FF00FF00FF00FF00FF005A9C5A00429C42003184
      310094ADA500639CAD0073A5AD00BDBDBD0094AD73006BB56300318C310094B5
      9400AD6B5200F7AD8400FFB59400BD7B6300DED6CE008C948C00BDA59C00EFA5
      8C00EFA5840094634A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6AD
      AD00F7C6AD00FFD6AD00FFD6AD00F7D6AD00C69C8C0094847B00B5949400F7CE
      B500FFDEBD00FFDEBD00FFDEC600F7D6BD00EFCEBD00DEB5AD00A5848400FF00
      FF00FF00FF00B58C8C00A58484009C8484009C8C8400A59C9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063637300315A
      9C00427BDE002163C600105AB500105AB500105AB5003163B500D6D6E700F7EF
      EF00CECECE008C8C940010294A00314263006B738400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF005A5A5A0000840000007B0000006B0000004200007B52
      0000E7730000FF840000FF840000FF840000F77B0000DE6B0000CE6B0000A552
      10000800290010106300A5A5A500FF00FF00FF00FF00FF00FF008CB59400106B
      7B00107BC600187BD600187BCE001073BD0018736300397B3900C6D6C60010D6
      7300C6AD9C00D68C6B00C68C6B00A5948C00CED6DE00DEDEE700C6ADA500DEA5
      8400B57B6300BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6AD
      AD00F7C6B500FFD6B500FFDEB500FFDEB500EFCEAD00C6A58C00DEB5A500FFDE
      BD00FFE7C600FFE7C600FFE7CE00FFE7CE00FFE7CE00EFD6C600A5847B00FF00
      FF00D6BDB500EFC6BD00EFCEBD00E7BDB500D6ADAD00B58C8C00B5A5A500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B6B7B00315AA5004284
      DE00427BE7002963CE00105AB500105AB500105AB5003163AD00949CAD00CEC6
      CE00EFEFEF00C6CEE7001052AD001052A5000842940010316300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A5BDA50084A584008CA58C009CAD
      9C00B5BDB500FF00FF0052525200007B0000006B00000073000000AD00001052
      00007B520000EF7B0000EF7B0000AD5200008442100042215200391863001808
      94000000520010106300A5A5A500FF00FF00FF00FF00FF00FF005294BD001884
      DE002994EF002994F7002994F7002994F700107BC6004A6B8400EFEFEF006B6B
      6B0084848400C6AD9C005A525A003173A5002973A500317BAD0063737B009463
      5200C6B5AD0094737B009C949400FF00FF00FF00FF00FF00FF00FF00FF00D6AD
      AD00F7C6B500FFDEB500E7D6AD00DECE9C00CEC69C00D6C69C00DECEAD00F7DE
      BD00FFE7CE00FFE7CE00FFE7CE00FFEFD600FFEFD600F7E7CE00B59C8C009C84
      8400D6B5AD00FFEFDE00FFEFE700FFEFE700F7E7DE00CEB5AD00BDADA500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005A637300315AA5004284E7004284
      E700427BE7002163C600105AB500105AB500105AB500295AAD00525263008484
      8C00E7E7E700C6C6DE001852AD00105AB500105AB50008397B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00218C2100188C180029942900298C
      290029842900317B310031423100006B00000094000000E7000000F700000063
      0000105A00004A3100004A212100180894000800BD000000E7000000EF000000
      F70000005A0010106300A5A5A500FF00FF00FF00FF00FF00FF00187BC600319C
      FF00319CFF0039A5FF0039A5FF0039A5FF00319CFF0018639C00C6C6C6007B7B
      7B00949C9C00BDD6DE00397BAD006394CE006B9CCE00639CCE003984B5005A73
      7B00F7F7F700E7CECE00D6B5B500B5848C00FF00FF00FF00FF00FF00FF00DEB5
      AD00F7CEB5000084840000848400008484000084840000848400008484000084
      84000084840000848400FFEFD600FFEFDE00FFEFDE00FFEFDE00EFDECE00DEC6
      BD00F7E7D600FFF7E700FFF7EF00FFF7EF00FFF7EF00D6BDB500B5ADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00636B7300315AA500427BE7004284E7004284
      E700397BDE00185AB5001052B500105AB500105AB500315AAD00ADADBD00CECE
      D600DEDEE700BDC6D6001052AD00105AB500105AB50008397B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0063A56B0021AD2100219C210039B5390039B5
      390031A53100299C2900314A3100009C000000FF000000FF000000FF000000C6
      0000006B0000004A00000000A5000000FF000000FF000000FF000000FF000000
      FF0000005A0010106300A5A5A500FF00FF00FF00FF0084B5CE003194EF0039A5
      FF0042ADFF0042ADFF0042ADFF0042ADFF0042A5FF00187BC600A5A5AD007B73
      7B009C9C9C005A9CBD0073A5DE007BADDE0073ADDE0073ADE70073ADDE00296B
      9400D6D6D600F7E7E700F7E7E700CE9C9C00FF00FF00FF00FF00FF00FF00DEB5
      B500EFCEB500008484000084840000FFFF0000FFFF0000FFFF0084FFFF0000FF
      FF00008484000084840000848400FFEFDE00FFEFDE00FFF7E700FFF7E700FFF7
      E700FFF7EF00FFF7EF00FFF7F700FFF7F700FFF7EF00D6BDBD00B5ADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00395A9C004284E7004284E7004284E700427B
      DE002163BD0018427B00103984001052B500105AB500295AB500ADB5CE00CED6
      DE00D6DEDE00B5BDD6001852AD00105AB500105AB50008397B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005AA55A0031B5310029A529004ABD4A0052C6
      520039AD390039AD3900394A390000FF000000FF000000FF000000FF000000FF
      000000C60000004A00000000AD000000FF000000FF000000FF000000FF000000
      FF0000005A0010106300A5A5A500FF00FF00FF00FF005294BD0042ADFF0042AD
      FF004AB5FF004AB5FF004AB5FF004AB5FF004AADFF002184CE0094A5AD00BDB5
      B500EFF7F7004A94C6007BB5E7007BB5EF0084B5EF007BB5EF0084B5E700317B
      AD00C6C6C600EFEFE700E7C6C600CEB5BD00FF00FF00FF00FF00FF00FF00DEB5
      B500F7CEBD00008484000084840000FFFF0000FFFF0084FFFF0084FFFF0000FF
      FF0000FFFF000084840000848400FFEFE700FFEFDE00FFF7E700FFF7EF00FFF7
      EF00FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700D6C6BD00BDADAD00FF00
      FF00FF00FF00FF00FF007B8484003163AD004284E7004A84E700397BDE002163
      BD00396394005A636B002931390008317B001052B5001052AD00396BAD006384
      BD008C9CC6008C9CC6001052AD00105AB500105AB50008397B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005AA55A0042BD390039AD42005AC65A0063CE
      63004AAD4A004AAD4A003952390000FF000000FF000000FF000000FF000000FF
      000000FF0000009C00000000AD000000FF000000FF000000FF000000FF000000
      FF0000005A0010106300A5A5A500FF00FF00FF00FF004A94BD004AADFF004AB5
      FF0052BDFF0052BDFF0052BDFF0052BDFF0052B5FF002184CE00A5ADB500B59C
      9C00DEE7EF00529CCE0084BDEF008CBDF7008CBDF7008CBDF70084BDEF003984
      B500C6C6C600FFEFEF00CE9C9C00FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7D6C600E7DEBD00008484000084840000FFFF0084FFFF0084FFFF0000FF
      FF000084840000848400E7E7CE00FFE7D600FFD6BD00FFD6BD00FFDEC600FFDE
      CE00FFEFDE00FFEFE700FFF7EF00FFFFFF00FFFFFF00D6C6BD00BDADAD00FF00
      FF00FF00FF00FF00FF0084949C003163AD004284E700427BE7002963BD004263
      8C00636B6B006B6B6B00635A63002129390008397B001052B5001052B5001052
      B5001852AD002152AD001052AD00105AB500105AB50010397B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006BA56B004ABD4A005AC65A0073D6730073CE
      7300429C390052AD4A006373630000DE000000FF000000FF000000FF000000FF
      000000FF000000AD00000000AD000000FF000000FF000000FF000000FF000000
      FF0000005A0010106300A5A5A500FF00FF00FF00FF005A9CBD004AB5FF0052BD
      FF005AC6FF0063C6FF0063CEFF005AC6FF0052BDFF00217BAD00CECED600EFDE
      DE00E7EFF7005A9CCE008CBDF70094C6FF0094CEFF0094CEFF008CC6F700397B
      A500E7E7E700EFCED600C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00DEB5
      B500F7D6C600FFEFD600CED6B50000848400217B9C00318CC600428CB50000FF
      FF0000FFFF0000848400FFF7EF00FFF7E700FFEFDE00FFE7D600FFE7D600FFDE
      C600FFD6BD00FFCEB500FFCEB500FFF7E700FFFFFF00DEC6C600BDADAD00FF00
      FF00FF00FF00FF00FF008C94A5003963AD00397BDE002163BD004A6384006B6B
      6B006B6B6B006B6B6B006B6B6B00636363002931390008397B001052B500105A
      B500105AB500105AB5001052B5001052B500084AA50008296B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094BD94004AB54A006BCE6B0084DE840073C6
      6B008CB573007BB56B007BC673005A9C5A0000CE000000FF000000FF000000FF
      000000FF000000AD00000000AD000000FF000000FF000000FF000000FF000000
      F7000000520010106300A5A5A500FF00FF00FF00FF00FF00FF0039A5E70063C6
      FF006BCEFF006BD6FF0073D6FF006BD6FF0052BDEF00427BA500F7F7F700B594
      9C00E7D6D600529CC6008CC6FF009CCEFF00A5D6FF009CD6FF007BB5EF006394
      AD00FFFFFF00D6A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBD
      B500F7D6C600FFEFDE00CED6D6004294D6002994F700319CFF002994F7004A9C
      D600D6DEE700FFF7EF00FFF7F700FFF7EF00FFF7EF00FFF7F700FFFFF700FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFFF00FFFFFF00DEC6BD00BDADAD00FF00
      FF00FF00FF00FF00FF008C9CA500295AA5002963BD0042638C006B6B6B006B6B
      6B00736B6B006B6B6B006B6B6B006B6B6B006B6363002129390008317B001052
      B500105AB5001052B500084AAD0008399C0008296B000008290052525200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00399C390073D6730084D684007BB5
      7300EFEFDE0094BD8C007BCE7B00BDDEBD004A9C4A0010B5100000EF000000FF
      000000FF000000AD00000000AD000000F7000000E7000000C6000000B5000000
      84000000310010105200A5A5A500FF00FF00FF00FF00FF00FF00318CBD005AC6
      F70073DEFF0084EFFF0084EFFF007BDEFF00318CBD00B5C6CE00F7E7E700C6AD
      AD00F7EFEF00BDD6E700529CCE009CCEF700B5DEF7009CCEEF004A94B500D6DE
      E700F7EFEF00C6A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      B500F7D6CE00FFEFDE0094BDD6003194EF0039A5FF0042A5FF0039A5FF00429C
      EF00ADCEDE00FFFFF700FFFFFF00FFE7E700FFD6C600FFDEC600FFDECE00FFE7
      D600FFE7DE00FFEFDE00FFEFE700FFFFF700FFFFFF00DEC6C600BDB5AD00FF00
      FF00FF00FF00FF00FF008C94A500184A8C004A638C006B6B73006B6B6B006B6B
      73006B6B6B006B6B6B00736B7300736B73006B6B73006B636B00313142000839
      8400084AA5000839940008297300081831001010180031313100FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005AA55A006BC66B006BAD6300D6E7
      CE00FFFFF700B5CEAD0084CE84007BCE7300638C4A0094735A00398C310008C6
      080000D60000008C00000000840000008C000000730000005200000052000000
      630000007B0010104200A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00318C
      BD005AC6E7007BE7F70073DEEF003994BD0094B5C600BDA5AD00CEBDBD00CEC6
      C600FFF7F700FFF7F700C6DEE70073ADCE006BA5C6007BADC600DEE7EF00FFF7
      F700EFC6C600CEC6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      B500FFD6D600FFEFE7005A9CCE0042ADFF004AB5FF0052B5FF004AB5FF004AAD
      F7009CC6DE00FFFFFF00FFFFFF00FFF7F700FFEFEF00FFEFE700FFE7DE00FFE7
      D600FFDECE00FFDECE00FFDECE00FFF7EF00FFFFFF00DEC6C600BDB5AD00FF00
      FF00FF00FF00FF00FF007B848C004A526B00736B7300736B7300736B7300736B
      7300736B73007373730073737300737373007373730073737300636363002129
      390000215A0008184200181821002121210031313100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0052A552007BA57B0094B5
      BD00B5C6C600ADBD940073BD730052A552008C8C6300D6947300CE9C84007BA5
      7B00639463006384630018184A000000630000006B0000007B00000084000000
      84000000840010106300A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF009CC6D6007BADCE008CB5CE00CEE7EF00C6B5B500F7E7E700C6B5B500EFEF
      EF00D6C6CE00DED6D600EFE7E700FFFFFF00FFFFFF00FFFFFF00CEBDBD00FFFF
      FF00D6A5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      BD00FFDED600FFF7E7004A9CCE004AADFF0052B5FF004AB5F7004AADF70052AD
      EF009CCEE700FFFFFF00FFFFFF00FFF7F700FFEFEF00FFF7F700FFFFF700FFFF
      FF00FFFFFF00FFFFF700FFF7F700FFFFFF00FFFFFF00DEC6C600BDB5AD00FF00
      FF00FF00FF00FF00FF004A4A4A006B6B6B00736B7300736B7300737373007373
      7300737373007373730073737300737373007373730073737300737373006363
      630021212900292929002929290031293100FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDD6C600217BB5002184
      CE002184CE00297B8C00397B4A00FF00FF00FF00FF00CE9C8400C68C7300BDCE
      D600BDB5B500C69C8400ADADAD002121630000007B0000007B00000084000000
      840000007B0052526B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A58C
      8C00F7E7E700E7B5BD00AD8C8C00F7EFEF00AD9C9C00D6CECE00C6B5B500EFEF
      EF00DED6D600E7DEDE00DED6D600F7EFEF00FFFFFF00EFEFE700DECECE00FFF7
      F700C69C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7BD
      BD00FFDED600FFF7EF006B9CC600398CCE004A9CD60052A5DE004AA5DE004A94
      CE00BDD6E700FFFFFF00FFFFFF00FFEFE700FFD6C600FFD6BD00FFD6BD00FFD6
      BD00FFD6C600FFDECE00FFE7D600FFF7F700FFFFFF00DECEC600BDB5AD00FF00
      FF00FF00FF00FF00FF00525252006B636B007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373005252
      5200313131002929290031313900FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADCEDE002994EF003194
      F7002994F700218CE700396B9400FF00FF00FF00FF00FF00FF0063737B00397B
      B5004A7B9C007B6B6300FF00FF00FF00FF0029296B000000730000007B000000
      7B004A4A6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B59C
      A500F7E7E700D6ADAD00C6ADAD00EFEFEF00D6C6C600E7DEDE00CEC6C600EFE7
      E700DED6D600CEC6C600D6C6CE00FFFFFF00FFFFFF00D6CECE00F7EFEF00FFDE
      DE00C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD
      BD00FFDEDE00FFFFF700B5CEDE005A9CCE0084BDDE008CBDE70063ADDE007BB5
      CE00EFF7F700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7EF00FFEF
      E700FFEFDE00FFE7D600FFDED600FFF7EF00FFFFFF00DECEC600C6B5AD00FF00
      FF00FF00FF00FF00FF00FF00FF004242420063636B0073737300737373007373
      73007B7373007373730073737300737373007373730073737300525252003131
      31002929290021212900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073ADDE0039A5FF0039A5
      FF0039A5FF0039A5FF00217BBD00FF00FF00FF00FF00FF00FF005A9CC6006BA5
      D6005A9CCE0042739400FF00FF00FF00FF00FF00FF0031317300080863002929
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DECE
      CE00F7DEDE00CE9C9C00DED6D600DED6D600E7DEDE00DED6D600E7E7E700E7E7
      E700D6CECE00CEBDBD00EFE7E700FFFFF700DEB59400BD947300DEC6AD00EFB5
      B500CECECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD
      BD00FFDEDE00FFFFFF00EFF7FF00B5D6E70094C6DE009CCEDE009CC6DE00DEEF
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600C6B5AD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005252520063636300737373007373
      7B0073737B007B737B0073737B007B737B007B7373004A4A4A00313131002929
      290031393900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0052A5D60042ADFF004AAD
      FF004AADFF0042ADFF00218CD600FF00FF00FF00FF0094BDD60073ADDE007BB5
      E7007BB5E7004284AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B59C9C00F7EF
      F700FFF7F700BD9C9C00F7EFEF00EFE7E700D6C6CE00C6B5BD00C6BDBD00CEC6
      C600CEC6C600D6C6C600DEDEDE00E7CEBD00DEAD5A00FFDE9C00EFBD9C00E7AD
      AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFDEDE00FFFFFF00FFFFFF00F7FFFF00EFF7F700EFF7F700F7F7FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600C6B5B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0052525200737373007373
      7B007B7B7B007B7B7B007B7B7B007B737300525252003129310021182100FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A9CDE0052B5FF0052BD
      FF0052BDFF0052B5FF00298CD600FF00FF00FF00FF008CBDD6007BB5E7008CBD
      F70084BDEF004A8CBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5949400FFFF
      FF00FFFFFF00C69C9C00D6BDBD00DEC6CE00EFD6DE00F7E7E700F7EFEF00FFF7
      F700F7F7F700F7F7F700E7E7E700C69C7300F7D6A500F7BDB500F7DED600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7DED600F7E7DE00FFEFE700FFEFEF00FFF7F700FFF7
      F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFF700E7CEC600C6B5B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00525252006B6B
      6B007B737B007B7B7B00737373004A4A4A002921290042424A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AADD6005AC6FF0063CE
      FF0063CEFF005AC6FF00318CBD00FF00FF00FF00FF0094BDDE0084BDEF0094CE
      FF008CC6F700528CB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD9C9C00FFFF
      FF00FFFFFF00F7F7F700F7EFEF00EFE7E700EFD6D600E7CECE00E7C6C600E7BD
      C600DEA58C00EFB5AD00EFB5BD00E79C8C00EFC6C600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00FFDEE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00BD9C9400E7D6CE00FFE7DE00FFDED600F7DED600F7DE
      CE00F7DECE00FFDECE00FFDED600FFDED600FFE7D600EFD6CE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00635A
      630073737300737373004242420042424200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CC6DE006BD6FF0073DE
      FF0073DEFF0052BDE7006B9CBD00FF00FF00FF00FF00FF00FF0073B5E700A5D6
      F7007BB5DE008CB5C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEB5B500CEAD
      AD00D6ADB500DEB5B500DEB5BD00E7BDBD00EFC6C600F7D6D600F7E7DE00F7DE
      D600DEA57B00F7BDB500F7DEDE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6
      BD00F7D6D600FFF7F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00B59C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00525252004A4A5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AC6E7007BE7
      F7006BCEE70063ADCE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084B5
      D6009CC6D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DEDE00F7D6D600F7CE
      CE00F7D6D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7D6D600F7DED600F7DED600F7DED600F7DED600FFDED600FFDED600F7DE
      D600FFE7DE00FFDED600D6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009CCEDE0084BD
      D6009CC6DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00100000004A0000006B0000006B0000006B00
      00006B0000006B0000005A0000003900000063313100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D68C4200DE84
      1000FFB55200FFB54A00FFAD3900F7B54A00F7BD6300FFCE7B00FFCE8C00FFD6
      A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00D68C4200DE841000FFB55200FFB54A00FFAD3900F7B54A00F7BD6300FFCE
      7B00FF00FF004A7B4A0000630000210000005A080000732900007B2900007B29
      00007B2900007B2900006B180000520000005200000063101000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00635A63006B636B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7CE00D66B0000DE7B
      1000FFE7CE00FFFFFF00FFFFFF00FFFFF700FFEFDE00FFE7C600FFDEAD00FFCE
      8C00FFC66B00FFBD5200FFB54A00FFB55200FFBD6B00FFC66B00FFCE9400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      CE00D66B0000DE7B1000FFE7CE00FFFFFF00FFFFFF00FFFFF700FFEFDE00EFEF
      EF003163310000730000007B00001008000084420000E7730000EF730000EF73
      0000EF730000EF730000DE6B0000C65A00008C3900004A08000029080800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0021212100423942005A525A004A4A4A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00637B6B00427B5200527B5A005A6B5A00848C8C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DEC600D66B0000DE7B
      1000FFE7BD00E7C6AD00CE9C7B00DEB59C00EFCEBD00FFF7EF00FFF7F700FFFF
      F700FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFEFD600FFE7C600FFB54200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DE
      C600D66B0000DE7B1000FFE7BD00E7C6AD00CE9C7B00DEB59C00EFCEBD006363
      630000840000007B0000006B00000039000021520000A55A0000FF840000FF84
      0000FF840000FF7B0000E7730000D66B0000B55A080052294200080029001818
      6300FF00FF00FF00FF00FF00FF006363630029212900312931004A424A004242
      4200424242002929290084848400BDBDBD00524A5200FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073847300397B
      4A00187B3900088C310010A5390021AD520063C68C0063C68C0052AD7B005294
      6B004A735A005A6B5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DEBD00D66B0000E784
      1000FFDEA500E7B59400C67B5200CE8C6B00DEA58400FFE7C600FFE7C600FFE7
      C600FFEFD600FFEFD600FFF7E700FFF7E700FFF7EF00FFF7E700FFB54A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DE
      BD00D66B0000E7841000FFDEA500E7B59400C67B5200CE8C6B00DEA584006363
      6300007B0000006B0000007B000000A500000063000021520000C6630000FF84
      0000C66300008C420800522942003118630021108C000000DE00000063001818
      6300FF00FF00FF00FF00FF00FF006363630029212900312931004A424A004242
      4200424242002929290084848400BDBDBD00524A5200FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B94730021733900108C31001094390008A5
      390010A53900109C390010A5390021B5520052BD84005AB57B005ABD7B005ABD
      84005ABD840052AD7B006B736B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DEB500CE6B0000E78C
      1800FFD69400E7AD7B00D68C5200B5846B0094738C009C84AD00947BA500846B
      9400846B9C008C7394009C7B9400A58C9400BDA59C00CEB5B500DE9C5200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DE
      B500CE6B0000E78C1800FFD69400E7AD7B00D68C5200B5846B0094738C006363
      6300006B000000AD000000EF000000F7000000AD0000006B0000184A00003921
      0800180884000800C6000000E7000000F7000000F7000000FF00000063001818
      6300FF00FF00ADADAD005252520039393900424242004A4A4A00635A63004A4A
      4A005A5A5A00737373007B7B7B00B5B5B5006B6B6B006B636B00FF00FF00FF00
      FF00FF00FF00FF00FF0073737300292129003931390039393900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0029844200109C3900109C390010A5390010B5
      420008BD4A0000C6420000D64A0000E75A0008F77B0029E7840031D6840039CE
      840042CE7B004AB57B0039524A008C8C9400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DEB500CE6B0000E78C
      1800FFCE7B00F7BD7B00E7AD730052398C003131AD004239B5004242B5004A42
      B500524ABD004A4AB500524ABD00524ABD004A4AB5004239AD0039319C004239
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DE
      B500CE6B0000E78C1800FFCE7B00F7BD7B00E7AD730052398C003131AD006363
      630000BD000000FF000000FF000000FF000000FF000000BD0000005A00000018
      4A000000E7000000FF000000FF000000FF000000FF000000FF00000063001818
      6300FF00FF006B636B005A5A5A006B636B00737373008C8C8C008C8C8C00A5A5
      A500ADADAD008C8C8C0052525200A59CA5006B6B6B004242420042394200524A
      52006B636B00736B73002921290029212900A5A5A5009C9C9C004A4A4A00FF00
      FF00FF00FF00FF00FF00FF00FF002984420008BD4A0000E7630000F76B0008D6
      6B00189C4A002973290021732100186318004A5A52007B848400949494006373
      7300297B5A0042947B00638CB5005A84B5004A63940042527B0052637300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFDEAD00CE630000EF94
      2100FFCE8400FFD69400DEB58C003129A5002929AD000000A50000009C000800
      9C000808A5000808A50010109C001818A5002121A5003129AD004239B5004A4A
      BD00524ABD003939AD003129AD00FF00FF00FF00FF00FF00FF00FF00FF00FFDE
      AD00CE630000EF942100FFCE8400FFD69400DEB58C003129A5002929AD006363
      630000FF000000FF000000FF000000FF000000FF000000FF000000A500000029
      4A000000E7000000FF000000FF000000FF000000FF000000FF00000063001818
      6300FF00FF007B7B7B00847B840084848400CECECE00D6CED600CECECE00B5B5
      B500C6C6C600B5B5B500524A520031313100948C940084848400313131003131
      3100313131003131310021182100393939008C8C8C00C6C6C60042424200FF00
      FF00FF00FF00FF00FF00FF00FF00C6CEBD008CBD9C0063AD7B0010845200314A
      42006B636B009C9C9C008C848C004A4A4A0063636300848484009C9494008484
      840052637B0084B5E7008CBDF70094C6FF0094CEFF0094C6FF0073A5D6006B73
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFD6A500CE630800EF94
      2100FFD69400F7C69400A5849C002939B5001010AD000000A5000000A5000000
      A5000000A5000000A5000000A5000000A5000000A5000000A50000009C000000
      9C0000009C001810A5003131B5002929B500FF00FF00FF00FF00FF00FF00FFD6
      A500CE630800EF942100FFD69400F7C69400A5849C002939B5001010AD006B6B
      6B0000F7000000FF000000FF000000FF000000FF000000FF000000E70000004A
      4A000000E7000000FF000000FF000000FF000000FF000000FF00000063001818
      6300FF00FF00A5A5A500ADADAD00ADA5AD00D6CED600D6CED600B5B5B500B5B5
      B500C6BDC600BDB5BD00B5B5B500ADADAD00B5B5B500ADADAD00949494008C8C
      8C007373730052525200292929002118210084848400B5B5B50042424200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00395284003942
      420073737300A5A5A500A5A5A500524A520052525200848484009C949C006B6B
      730052637B0084B5E7008CBDF70094C6FF0094CEFF0094CEFF0084B5EF006B73
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7D6A500C6630000EF94
      2100FFCE8400D68C52004A297B003942BD000010B5000008B5000008AD000008
      AD000008AD000008AD000008AD000000AD000008AD000000A5000000A5000000
      A5000000A5000000A5001821AD002121A500FF00FF00FF00FF00FF00FF00F7D6
      A500C6630000EF942100FFCE8400D68C52004A297B003942BD000010B500C6C6
      C60021B5210000EF000000FF000000FF000000FF000000FF000000E70000004A
      4A000000E7000000FF000000FF000000FF000000FF000000FF00000063001818
      6300FF00FF00ADADAD00A5A5A500A5A5A5008C8C8C0063636300292129002921
      2900949494006B636B00A5A5A500B5ADB500847B8400B5B5B500B5ADB500BDBD
      BD00BDB5BD00BDB5BD00B5ADB5007B7B7B007B737B00636363004A4A4A007B7B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00395284003939
      4200636363008C8C8C00847B8400524A52009C949400C6BDBD00C6BDBD00A5A5
      A5005A6B7B0084B5E7008CBDF70094C6FF0094CEFF0094CEFF0084B5EF006B73
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7D69C00C6630800EF9C
      2900FFC67B00BD845A003931A5002939C6000008BD000010B5000008BD000008
      B5000008B5000008B5000008B5000008B5000008B5000008B5000008B5000008
      AD000008AD000008AD003139BD004242B500FF00FF00FF00FF00FF00FF00F7D6
      9C00C6630800EF9C2900FFC67B00BD845A003931A5002939C6000008BD000010
      B500A5BDA50021B5210000F7000000FF000000FF000000FF000000E70000004A
      4A000000E7000000FF000000FF000000FF000000CE0000008400000031001818
      6300FF00FF00B5B5B500736B7300211821002118210021182100211821002118
      21006B636B0029212900312931008C8C8C009C9C9C00BDB5BD00B5B5B500BDB5
      BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDBDBD00ADADAD009C9C
      9C0073737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0039528C003942
      4A00847B8400A59CA500A59C9C006363630063738C007B94AD0073849C00637B
      9400739CC6007BB5EF008CBDF70094C6FF0094CEFF009CCEFF0084B5EF006B73
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFD69400C6630800F79C
      2900FFC66B00946373004252C6000829C6000018C6000010C6000010BD000010
      C6000010C6000010C6000010BD000010BD000010BD000010BD000010BD000010
      BD000008B5001021BD002929B500FF00FF00FF00FF00FF00FF00FF00FF00FFD6
      9400C6630800F79C2900FFC66B00946373004252C6000829C6000018C6000010
      C6000010BD00BDC6BD005A735A0010C6100008D6080000EF000000D600000042
      42000000BD000000AD0000006300000042000000520000007300000073001818
      3900FF00FF00FF00FF0063636300393939003131310029292900181818002118
      21004A4A4A00524A52002121210039313900948C9400BDB5BD00B5B5B500BDBD
      BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDBDBD00BDBD
      BD00736B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0039528C00525A
      6B00ADADAD00CECECE00BDBDBD00737B7B007BA5D6008CC6F70073A5D6006BA5
      D6007BADDE0084B5E7008CBDF70094C6FF0094CEFF009CCEFF0084B5EF006B73
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE9400C6630800F79C
      2900FFC67300634A94004A5AD6000018C6000018C6000018D6000018CE000018
      CE000018CE000018C6000018C6000018CE000018C6000010C6000010CE000018
      C6000010BD002939CE003129AD00FF00FF00FF00FF00FF00FF00FF00FF00FFCE
      9400C6630800F79C2900FFC67300634A94004A5AD6000018C6000018C6000018
      D6000018CE000018CE000018CE00A5A5A50084A584004A9C4A00399439002942
      4200000052000000520000007300000084000000840000008400000084001818
      6300FF00FF00FF00FF007B737B004A4A4A004A4A4A0042424200181818002118
      2100313131007B7B7B002121210042394200847B8400B5B5B500BDBDBD00BDB5
      BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDBDBD00BDBD
      BD00736B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00315A84004A7B
      AD00527BA500527BA500638CB50073A5D60084BDEF0094C6F70073A5DE0073A5
      D6007BADDE0084B5E7008CBDF70094C6FF0094CEFF009CCEFF0084B5EF006B73
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE8C00C65A0800FF9C
      2900DEAD7B004A4AB500425ADE005A73D600394ACE000021CE000021D6000021
      D6000021D6000829CE004A5AC6004A52CE004A52C6004242BD003942C6003942
      BD002931BD002931BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE
      8C00C65A0800FF9C2900DEAD7B004A4AB500425ADE005A73D600394ACE000021
      CE000021D6000021D6000021D6000829CE004A5AC600E7E7E700DEDEDE00C6C6
      C600393963000000840000008400000084000000840000008400000084004242
      6300FF00FF00FF00FF007B737B004A4A4A004A4A4A0042424200181818002118
      2100313131007B7B7B002121210042394200847B8400B5B5B500BDBDBD00BDB5
      BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDB5BD00BDBDBD00BDBD
      BD00736B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00395A8C004A7B
      B500528CBD006394C6006BA5D60073ADDE0084BDEF0094C6F70073A5DE0073A5
      D60073ADDE007BB5E7008CBDEF0094C6FF0094CEFF009CCEFF0084BDEF007373
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE8400BD5A0800F7A5
      29009C7B84005263D600294AEF00A5ADF700C6C6EF00848CE7003952D6001831
      D6000829D6002139D600A5ADE700D6D6F700D6D6F700D6D6EF00DED6F700B5BD
      EF005A6BDE002929BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE
      8400BD5A0800F7A529009C7B84005263D600294AEF00A5ADF700C6C6EF00848C
      E7003952D6001831D6000829D6002139D600A5ADE700D6D6F700D6D6F700D6D6
      EF00DED6F700393963000000730000007B0000007B000000730039396300FF00
      FF00FF00FF00FF00FF009C9C9C005A5A5A00525252005A525200292929003931
      390042424A009C9CA5004A4A4A004A424200847B8400B5B5B500C6C6C600BDB5
      BD00BDBDBD00BDB5BD00BDB5BD00BDB5BD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00736B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00395A8C004A7B
      B5004A84B5004A84B5004A7BAD004A7BAD007BB5E70094C6F70073A5DE006B9C
      D6004A7BB5005284B5005A8CC600639CCE0073A5DE007BB5E70073ADDE006B7B
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE8400BD5A0000F79C
      31006B529C005273EF000831EF00315AEF009CADF700D6E7FF00E7E7F700D6DE
      F700D6D6F700DEDEF700DEE7FF00F7EFFF00EFEFFF00EFEFFF009CADEF002142
      E7003952DE004A4ABD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFCE
      8400BD5A0000F79C31006B529C005273EF000831EF00315AEF009CADF700D6E7
      FF00E7E7F700D6DEF700D6D6F700DEDEF700DEE7FF00F7EFFF00EFEFFF00EFEF
      FF009CADEF00D6D6DE0052527B0000005A001818630063638400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0073737300636363006B6B6B006B6B6B008484
      84009C9C9C00C6C6C60094949C006B63630094949400BDB5B500ADC6B50063AD
      6B0084B584009CB59C00ADB5AD00BDB5BD00B5BDB500BDBDBD00BDBDBD00BDBD
      BD00736B7300FF00FF00FF00FF00FF00FF00A5A5AD007384940031528400426B
      9C00426B9C004273A5004A7BAD00426B9C005A8CBD008CC6F70073A5DE005A8C
      BD0031639400426BA500396B9C00396B9C0039639400396B9C00396B94004A52
      6B0094949C00A5ADAD00FF00FF00FF00FF00FF00FF00F7C67B00BD520000DE8C
      3100525ABD003163F7000039F7000039F7001042F7004263F700738CF7009CB5
      FF00A5B5FF00A5B5FF009CADF700EFEFFF00E7EFFF006384EF000831EF001039
      EF002939CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7C6
      7B00BD520000DE8C3100525ABD003163F7000039F7000039F7001042F7004263
      F700738CF7009CB5FF00A5B5FF00A5B5FF009CADF700EFEFFF00E7EFFF006384
      EF000831EF001039EF00D6D6DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C9C9C00B5B5B500C6C6C600ADBDDE007B9C
      DE0084A5DE00739CE700CECECE00CECECE00CECECE00CECECE00BDCEB50042A5
      4200299C2900189C1800189C18006BAD6B00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00736B7300FF00FF00FF00FF00A5B5C600426B94005A8CBD00639CCE006BA5
      D60073A5DE007BADDE007BADE7007BADE7004273A5007BADDE006BA5D600396B
      9C005A94CE00639CDE006394D6005A94D6005A94CE00528CCE004A84BD00427B
      B500426BA500395A7B00FF00FF00FF00FF00FF00FF00F7C67300B55208009C63
      5A007B84E7004273FF002963FF00295AFF002152FF001852FF00104AFF00104A
      FF00104AFF000842F700184AF700A5BDF700295AF7000039F7000031F700295A
      EF003131BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7C6
      7300B55208009C635A007B84E7004273FF002963FF00295AFF002152FF001852
      FF00104AFF00104AFF00104AFF000842F700184AF700A5BDF700295AF7000039
      F7000031F700295AEF003131BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADB500848C9C00B5C6
      DE00DED6C600DED6BD00E7CEA500E7C68C00E7BD7300E7AD5200DE9C3100C67B
      2900C6844200BD946300AD9C630084A56300B5B5B500BDBDBD00BDBDBD00BDB5
      BD00736B7300FF00FF00FF00FF00FF00FF0094A5BD006394C6007BADE70084B5
      E70084B5E70084B5EF008CBDEF008CBDF70084B5E7004273A5005284AD006B9C
      CE0084B5EF007BB5EF007BB5EF0073ADE70073ADE70073ADE7006BA5DE00639C
      D60052739C00FF00FF00FF00FF00FF00FF00FF00FF00FFC67300B54A08006B52
      8C0094ADF7004A7BFF004A7BFF004A84FF004A7BFF00527BFF00527BFF004A7B
      FF00527BFF005A7BFF005A7BFF004A7BFF004273FF00426BFF00426BFF004A6B
      E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC6
      7300B54A08006B528C0094ADF7004A7BFF004A7BFF004A84FF004A7BFF00527B
      FF00527BFF004A7BFF00527BFF005A7BFF005A7BFF004A7BFF004273FF00426B
      FF00426BFF004A6BE7006B73C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5947300E7A5
      2900E79C1800E79C1000E7940800E7940800E79C0800E79C0800DE8C0800CE63
      0000CE630000CE630000CE630000CE6B0800C67B3900BDB5B500BDBDBD00BDBD
      B500736B7300FF00FF00FF00FF00FF00FF00FF00FF00849CB5006B9CCE006B9C
      D6006B9CD6006B9CD6006B9CCE006394CE005A94C600527BAD00315A8C003963
      94004A6B9C005273AD005A84B5006394C6006B9CD6007BADE70073ADE7005273
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC673008C4218006B6B
      CE009CB5FF009CB5EF0094ADF7005A8CFF005284FF00528CFF006394FF007394
      FF005A8CFF005284FF00528CFF005284FF005284FF005284FF006B94FF005252
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC6
      73008C4218006B6BCE009CB5FF009CB5EF0094ADF7005A8CFF005284FF00528C
      FF006394FF007394FF005A8CFF005284FF00528CFF005284FF005284FF005284
      FF006B94FF005252C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AD946B00E79C
      2100E7A53100E7AD4A00E7B55A00E7BD7300EFCE9400EFD6AD00DED6BD00BDA5
      8C00C69C7B00C6946300C68C5200CE732900CE6B1800C6946B00BDB5BD00BDB5
      BD0073737300FF00FF00FF00FF00FF00FF00FF00FF009CADBD005A84B500739C
      CE006B9CD600639CD600639CD6005A94CE006394CE006394CE00315A8C002142
      6B0018396B0021396B0029427300314A840042639400527BAD004A73AD005A63
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC67300845263009CAD
      E700C6D6EF00B59C9400B5ADBD0073A5FF00639CFF0084ADFF00BDBDCE00BDAD
      A500ADC6FF006394FF005A94FF008CADFF00B5BDDE00BDC6E7008C9CF7005A5A
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC6
      7300845263009CADE700C6D6EF00B59C9400B5ADBD0073A5FF00639CFF0084AD
      FF00BDBDCE00BDADA500ADC6FF006394FF005A94FF008CADFF00B5BDDE00BDC6
      E7008C9CF7005A5AC600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADA500EFE7
      D600EFE7E700EFEFEF00EFEFEF00F7EFF700F7F7F700F7F7F700F7F7F700BDBD
      BD00BDB5BD00BDB5BD00B5BDBD00BDB5B500BDB5AD00BDB5AD00BDB5BD00BDB5
      BD00736B7300FF00FF00FF00FF00FF00FF00FF00FF005A84B5007BB5E70084B5
      EF0084BDEF008CBDF7008CBDEF0084B5EF007BADE700638CC600315A8400638C
      BD007BADDE0084B5EF008CBDEF008CC6F7008CBDF7008CBDEF0084B5EF005273
      9C007B848C00FF00FF00FF00FF00FF00FF00FF00FF00FFC673005A428C008CA5
      E7009CADDE00B5A5A5009494A50094B5F70094B5FF009CBDFF00B5B5C600A594
      8C008CADDE006BA5FF006BA5FF00BDCEEF00AD9C9400A5A5A5006B7BD600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFC6
      73005A428C008CA5E7009CADDE00B5A5A5009494A50094B5F70094B5FF009CBD
      FF00B5B5C600A5948C008CADDE006BA5FF006BA5FF00BDCEEF00AD9C9400A5A5
      A5006B7BD600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADAD00F7F7
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700E7E7
      E700DEDEDE00D6D6D600D6D6D600CECECE00C6C6C600C6C6C600C6BDC600C6BD
      C6007B737B00FF00FF00FF00FF00FF00FF0052739C0073A5DE0073ADDE007BAD
      DE007BADE70084B5E70084B5EF0084B5EF0084B5EF00527B9C00C6CED6006B8C
      B50084B5E70084B5EF0084B5EF0084B5E7007BB5E7007BADE7007BADDE0073A5
      D60042638400A5A5A500FF00FF00FF00FF00FF00FF00EFDEC600A58C7B008473
      73008C6B7B00ADA59C00947B8C006B63A5005A529C005A529C008C7BA5009C8C
      9400635AA5005A63C6005A73CE006373CE00A59CA500847B94004242B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00A58C7B00847373008C6B7B00ADA59C00947B8C006B63A5005A529C005A52
      9C008C7BA5009C8C9400635AA5005A63C6005A73CE006373CE00A59CA500847B
      94004242B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADAD00F7F7
      F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700F7F7F700E7E7
      E700DEDEDE00D6D6D600D6D6D600CECECE00C6C6C600C6C6C600C6BDC600C6BD
      C6007B737B00FF00FF00FF00FF00ADBDCE00738CAD005A84AD005A84B5005A8C
      BD006B94CE0073A5D6007BADDE007BADE7005A8CBD009CA5B500FF00FF00FF00
      FF005A84AD0073A5DE0073A5DE006BA5D6006B9CCE005A94C6005A8CB5005A84
      AD0052739C0094A5AD00FF00FF00FF00FF00FF00FF00FF00FF00EFEFEF009C8C
      8C00AD9C9C00AD9C9400E7DEDE00FF00FF00C6B5AD009C8C8C00B5A59C00AD9C
      8C00DED6E700BDBDCE0084737B007B738400B5A59C00948494009C9CD600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009C8C8C00AD9C9C00AD9C9400E7DEDE00FF00FF00C6B5AD009C8C
      8C00B5A59C00AD9C8C00FF00FF00BDBDCE0084737B007B738400B5A59C009484
      94009C9CD600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADAD
      AD00ADADAD00ADADAD00ADADAD00B5B5B500BDBDBD00CECECE00D6D6D600E7E7
      E700EFEFEF00E7E7E700D6D6D600BDBDBD00ADADAD00A5A5A500A5A5A500A5A5
      A500BDBDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008CA5BD007394B5006384AD00738CA500FF00FF00FF00FF00FF00
      FF00FF00FF005A7BA5006384AD007B94B500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7E7
      DE00D6BDBD00E7DEDE00FF00FF00FF00FF00FF00FF00BDADA500B5ADA500FF00
      FF00FF00FF00FF00FF00B5A59C00B59C9C00AD9C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7E7DE00D6BDBD00E7DEDE00FF00FF00FF00FF00FF00FF00BDAD
      A500B5ADA500FF00FF00FF00FF00FF00FF00B5A59C00B59C9C00AD9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DED6DE00CECECE00C6BD
      C600B5B5B500BDBDBD00CECECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00949494005A73
      5A00316342001073310039A5630052947300426B4A00395242005A635A00848C
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADAD00B5B5
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00AD848400A57B7B009C7B7B009C847B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00312929003129290031292900312929003129
      29003129290031292900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C9C9C006B7B6B00396342001873310008843100109C
      3900109C3900109C390039AD63005AB57B005AB57B0063C68C005AB58C004A9C
      730042735200425A4A006B736B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00738C73006B8C6B006B8C730084948400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B500BDBD
      BD0094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7B5A500E7B5A500DEAD9C00CEA59400A57B7B00FF00
      FF00FF00FF00BD9C9C00AD949400A58C9400A5949400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000000000180000005A000000840000008400000084000000840000008400
      00008400000084000000420000001800000039212100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005273520021733900107B3100108C310010943900109C3900109C310010A5
      3900109C3900109C390031A5520052B57B005AB57B0052BD840052B57B005AB5
      7B0052B57B0052B57B0039634200FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00087B0800108C100008730800108C1000188C1000107B1000107318001863
      1800396B39006B847300FF00FF00FF00FF00B5B5B50084848400A59CA500F7F7
      F70094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00D6B5B500F7C6AD00FFD6AD00FFD6AD00F7CEA500B58C8400FF00
      FF00FF00FF00D6A59C00E7B5A500D6A59C00C69C9400B58C8400AD8484009C7B
      7B0094848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00395A39000039
      000018000000840000005A000000420000004200000042000000420000004200
      000042000000420000006B0000008400000073000000390000006B525200FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094AD
      9C00108C310010943900109C390010A53900109C3900109C390010A5390008BD
      4A0000D65A0000E7630008F77B0021F78C0039F7940042DE8C0042C67B0052B5
      730052B57B0052AD7300315A3900FF00FF00FF00FF00FF00FF00FF00FF00398C
      390018A5210021AD21001084100031B5310039B5390039B5390039B53900188C
      180029A52900188C180029732900848C8400ADADAD00BDBDBD00D6D6D600EFEF
      EF00BDB5BD0094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6AD00FFD6AD00FFD6AD00F7D6AD00C69C8C009484
      7B00B5949400F7CEB500FFDEBD00FFDEBD00FFDEC600F7D6BD00EFCEBD00DEB5
      AD00A5848400FF00FF00FF00FF00B58C8C00A58484009C8484009C8C8400A59C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0031523100006B00000084
      0000080000002900000073310000A5520000A5520000A5520000A5520000A552
      0000A5520000A55200005A210000290000003900000084000000630000005A4A
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009CAD
      9C0010943900109C390010AD420008BD4A0000DE5A0000EF6B0000F7730000FF
      7B0000FF730008C6630010945200318C5A00318C630021945A0018B5630010F7
      7B0018DE730029AD6B0063846B00FF00FF00FF00FF00FF00FF00FF00FF00298C
      290029AD290031B531001884180042BD420042BD4A004ABD4A0042B542002194
      210063C663008494AD00525A9C004242AD002129AD005A5AAD009494AD00BDBD
      BD00D6D6D600B5B5B50094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6B500FFD6B500FFDEB500FFDEB500EFCEAD00C6A5
      8C00DEB5A500FFDEBD00FFE7C600FFE7C600FFE7CE00FFE7CE00FFE7CE00EFD6
      C600A5847B00FF00FF00D6BDB500EFC6BD00EFCEBD00E7BDB500D6ADAD00B58C
      8C00B5A5A500FF00FF00FF00FF00FF00FF001839180000730000008400000084
      00000000000052290000EF730000FF840000FF840000FF840000FF840000FF84
      0000FF840000FF840000EF730000DE6B0000B55A000021000000520000001800
      00004A4A5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5B5
      A5000894390008BD5A0000E7630008C66300217B52004A735A00637B6B005A84
      6B0039735A00394A4A006B6B6B007B7373007B6363008C8C8C005A635A004A63
      42007B946B00AD9C8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002984
      290039B5390039B53900218C210052C6520052C65A005AC65A0052BD4A00319C
      310084CE84003939C6002131E7001829E7001021E7000818DE000000BD004239
      A500BDBDBD00D6D6DE00B5B5B50039397B004A4A8C00FF00FF00FF00FF00FF00
      FF00FF00FF00D6ADAD00F7C6B500FFDEB500E7D6AD00DECE9C00CEC69C00D6C6
      9C00DECEAD00F7DEBD00FFE7CE00FFE7CE00FFE7CE00FFEFD600FFEFD600F7E7
      CE00B59C8C009C848400D6B5AD00FFEFDE00FFEFE700FFEFE700F7E7DE00CEB5
      AD00BDADA500FF00FF00FF00FF00313131000084000000840000008400000084
      000000180000005A000073420000F77B0000FF840000FF840000FF840000FF84
      0000FF840000FF840000FF840000FF840000F77B0000BD5A00004A2129000000
      08000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00ADA59C00ADBD9C007B9C730042524A005A525A007373730094949400948C
      8C0063636300424242006B6B6B008C8C8C008C7B7B008C848C00635A63009C73
      6300E7BD9C00F7C6AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00318C
      310042BD42004ABD4A0042AD420063CE63006BCE6B006BCE6B004AB54A0042A5
      42008CD694003942CE002939EF002131EF002129E7001021E7000000C6000000
      BD004239A500B5B5BD00D6D6DE00B5B5C6002121A50042428400FF00FF00FF00
      FF00FF00FF00DEB5AD00F7CEB500ADB584004A943900429C39004AA542004AA5
      420042943900639C4A008CAD7300D6D6AD00FFEFD600FFEFDE00FFEFDE00FFEF
      DE00EFDECE00DEC6BD00F7E7D600FFF7E700FFF7EF00FFF7EF00FFF7EF00D6BD
      B500B5ADAD00FF00FF00FF00FF00313131000084000000840000005A00000042
      0000006B0000005A0000005200006B420000FF840000FF840000FF840000FF84
      0000FF840000CE63000084420000844200006B311000000073000000CE000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFC6BD00FFE7C600F7CEB50073736B005A525A0073737B007B848C007B84
      8C006B6B6B00393939006B6363008C8C8C009C9CA5008484840052525200A573
      6B00DEBD9C00FFDEB500DEBDB500FF00FF00FF00FF00FF00FF00FF00FF004294
      42004ABD4A005AC65A006BCE6B0073D673007BD67B007BD67B00398C3100398C
      31009CDE9C00424AD6003142EF002939EF002129E7001821DE000000BD000000
      BD000000BD0084849C00BDBDBD00D6D6D600BD9C9400A5A5AD008C8C8C00FF00
      FF00FF00FF00DEB5B500EFCEB5007BA55A0029AD29004ABD4A005AC65A0052AD
      520063AD5A004AB54A0039AD390052A54A00DEDEBD00FFEFDE00FFEFDE00FFF7
      E700FFF7E700FFF7E700FFF7EF00FFF7EF00FFF7F700FFF7F700FFF7EF00D6BD
      BD00B5ADAD00FF00FF00FF00FF003131310000840000005A0000007B000000AD
      000000EF0000007B0000005A0000005A000073390000FF840000FF8400007339
      000052290000311842000000AD000000AD000000BD000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DECE
      CE00F7DECE00FFDEC600EFC6AD00736B6B005A5252007B737B007B8494008484
      94006B6B6B004A4A4A0084848400A59CA500A5A5A500948C9400636363009C73
      6300DEBDA500FFDEBD00CEA59C00FF00FF00FF00FF00FF00FF00FF00FF006BAD
      73004AB54A0063CE6B0073D6730084DE7B008CDE8C004AA55200B5C68C0073A5
      5A0094D69400424AD6003142EF003142EF002942EF002131EF000000CE000000
      BD000000BD006B6BB5005A5A9C00CECED600D6B5A500A5949400B5B5B500C6C6
      C600FF00FF00DEB5B500F7CEBD009CB57B0039A539005AC65A0063BD5A0094C6
      9400C6DEBD0052B552005AC65A004AA54200CEDEB500FFEFE700FFEFDE00FFF7
      E700FFF7EF00FFF7EF00FFF7EF00FFFFF700FFFFF700FFFFF700FFFFF700D6C6
      BD00BDADAD00FF00FF00FF00FF0031313100006300000073000000F7000000FF
      000000FF000000F700000073000000630000005A000018100000180808000000
      BD000000E7000000EF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CE
      C600FFEFD600F7D6C600EFCEB5006B6B6B00525252007B737B008C8C8C009494
      94006B6B6B0052525200A5949C00B5ADAD00B5B5B500ADA5A50094847B00B584
      7B00D6BDA500FFE7C600E7BDAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00399C390073D6730084DE84008CDE8C0073CE730073A56300FFEFE700BDCE
      AD0063B563006373C6004252F7003952FF00394AF7001018E7000008DE000008
      D6000008D6000008D6001010C600B5B5BD009C9CAD004A4A8C00ADADAD00DEDE
      DE00FF00FF00DEB5B500F7D6C600E7DEBD006BA552004AAD4A0063A56B00B5CE
      BD00C6D6C60063B563005ABD5A006BAD6300E7E7CE00FFE7D600FFD6BD00FFD6
      BD00FFDEC600FFDECE00FFEFDE00FFEFE700FFF7EF00FFFFFF00FFFFFF00D6C6
      BD00BDADAD00FF00FF00FF00FF0031313100006B000000FF000000FF000000FF
      000000FF000000FF000000FF0000006B000000630000004A000000009C000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6BD
      B500FFEFDE00EFC6B500EFC6B5005A5252006B636B0094949400ADA5AD00A59C
      A500847B840052424A0042528C00635A5A008C736B00C6A58C00F7CEAD00E7AD
      9400D6BDAD00FFE7CE00F7D6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00398C390073D673008CDE8C008CDE8C00529C4A00EFF7E700FFFFFF00EFF7
      EF004A9C4A0094DE9C006B7BC6004A5ADE00424ADE005252DE003942E7001821
      DE001821DE001018DE000810DE005A5AAD00ADADB50084848C00FF00FF00FF00
      FF00FF00FF00DEB5B500F7D6C600FFEFD600CED6B5005A9C7300217B9C00318C
      C600428CB500398C5A006BAD6300C6DEBD00FFF7EF00FFF7E700FFEFDE00FFE7
      D600FFE7D600FFDEC600FFD6BD00FFCEB500FFCEB500FFF7E700FFFFFF00DEC6
      C600BDADAD00FF00FF00FF00FF003131310000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF0000007300000021000000009C000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7D6
      CE00FFE7DE00EFCEBD00EFCEB500AD94840094848C00ADA5A500B5B5B500B5AD
      B50094949400636373001863D600215AAD00B59C8C00F7D6AD00FFD6B500DEAD
      9400D6BDAD00F7DEC600F7CEBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0094BD940042A542008CDE8C0042944200CED6A500FFEFDE00FFEFE700F7EF
      DE0052A5520094E794004A9C4A009C846B00E7A59400BD9494009C9CB5005A5A
      8C009494BD007373AD00735AA500846B9C00947B7300CECECE00FF00FF00FF00
      FF00FF00FF00DEBDB500F7D6C600FFEFDE00CED6D6004294D6002994F700319C
      FF002994F7004A9CD600D6DEE700FFF7EF00FFF7F700FFF7EF00FFF7EF00FFF7
      F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFFF00FFFFFF00DEC6
      BD00BDADAD00FF00FF00FF00FF003131310000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000EF0000006B000000009C000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00D6C6C600FFEF
      E700FFE7DE00EFD6C600EFCEBD00EFCEB500D6B5A500C6A59400BD948400949C
      AD008CADD600639CE7004294F7001063DE003163B500BDA59400F7D6AD00DEA5
      9400C6A59C00F7DECE00EFC6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0084B57B0029842900428463003984A500187BAD004284AD009CAD
      A500428C3100399439008CB58C00C6A59C00DE947300E7AD9400C6C6C600C6C6
      C600BDBDBD00AD9C9C00DE9C8400E79C7B009C7B6B00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500F7D6CE00FFEFDE0094BDD6003194EF0039A5FF0042A5
      FF0039A5FF00429CEF00ADCEDE00FFFFF700FFFFFF00FFE7E700FFD6C600FFDE
      C600FFDECE00FFE7D600FFE7DE00FFEFDE00FFEFE700FFFFF700FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF003131310000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF0000009C000000009C000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00424242004A5A
      6300CEBDB500EFD6C600EFD6C600EFCEBD00EFCEB500EFCEB500EFC6AD00DECE
      B500ADC6DE0084BDFF00529CFF004294F7001063DE002963B500B5A59400CE9C
      8C00CEB5AD00FFF7EF00E7CECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B9CAD001073BD002184DE002184DE002184DE00107B
      BD0018635A00FF00FF00FF00FF00FF00FF00B5847300B5735A00848C94006B9C
      B50084A5BD00B5A5A500C68C6B009C736300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500FFD6D600FFEFE7005A9CCE0042ADFF004AB5FF0052B5
      FF004AB5FF004AADF7009CC6DE00FFFFFF00FFFFFF00FFF7F700FFEFEF00FFEF
      E700FFE7DE00FFE7D600FFDECE00FFDECE00FFDECE00FFF7EF00FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF007373730000BD000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF0000009C000000009C000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF0084848400007B7B003184
      9C0018394200C6B5AD00F7DECE00FFE7DE00F7DECE00F7D6C600F7CEB500F7D6
      BD00E7D6BD00ADC6DE0084BDFF00529CFF004294F7001063DE002963B5009C7B
      7B00B59C9400E7C6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00217BC6002994F700319CFF00319CFF00319CFF002994
      FF001073BD008C949C00FF00FF00FF00FF00FF00FF00637B8C00397BA5004A84
      B500427BB500316B8C0073635A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDBD00FFDED600FFF7E7004A9CCE004AADFF0052B5FF004AB5
      F7004AADF70052ADEF009CCEE700FFFFFF00FFFFFF00FFF7F700FFEFEF00FFF7
      F700FFFFF700FFFFFF00FFFFFF00FFFFF700FFF7F700FFFFFF00FFFFFF00DEC6
      C600BDB5AD00FF00FF00FF00FF00FF00FF006B846B0000AD000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF0000009C000000009C000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      31000000630063636300FF00FF00FF00FF00FF00FF0094949400008C8C001084
      840031849C0021394200B5ADA500C6B5AD00CEBDB500F7E7D600FFEFD600FFE7
      CE00FFE7CE00E7CEBD00A5B5CE0084BDFF00529CFF004294F7001063DE002152
      AD0084737300BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007BADCE002994EF00399CFF0039A5FF0039A5FF0039A5FF0039A5
      FF002994E70052738C00FF00FF00FF00FF00FF00FF00428CBD0073A5DE0073AD
      DE0073A5DE00639CD600316B8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDBD00FFDED600FFF7EF006B9CC600398CCE004A9CD60052A5
      DE004AA5DE004A94CE00BDD6E700FFFFFF00FFFFFF00FFEFE700FFD6C600FFD6
      BD00FFD6BD00FFD6BD00FFD6C600FFDECE00FFE7D600FFF7F700FFFFFF00DECE
      C600BDB5AD00FF00FF00FF00FF00FF00FF00FF00FF00738C730000B5000000FF
      000000FF000000FF000000FF000000FF000000FF0000009C000000009C000000
      FF000000FF000000FF000000FF000000FF000000DE0000004200000042000000
      08000000630063636300FF00FF00FF00FF00FF00FF00DEC6C6006B7373000073
      7B00108C8C0031849C0000293100002931000031390073948C00F7DECE00FFE7
      CE00FFE7CE00EFC6B500BDA5A500ADC6DE0084BDFF00529CFF004294F7001063
      DE00215AAD00A5A5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF004A94C60042A5FF0042ADFF004AADFF004AADFF004AADFF0042AD
      FF0039A5F70039739400FF00FF00FF00FF007BADCE006BA5DE007BB5E7007BB5
      E7007BB5E7007BB5E700317BA500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBDBD00FFDEDE00FFFFF700B5CEDE005A9CCE0084BDDE008CBD
      E70063ADDE007BB5CE00EFF7F700FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700FFF7EF00FFEFE700FFEFDE00FFE7D600FFDED600FFF7EF00FFFFFF00DECE
      C600C6B5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00737B73002131
      210000DE000000DE000000F7000000FF000000FF0000009C000000009C000000
      E7000000DE000000940000002100000021000000310000007B0000007B000000
      7B000000100063636300FF00FF00FF00FF00FF00FF00D6B5B500FFFFFF006B94
      9C0010393900109CAD0029A5B50008BDCE0029DEDE00186B6B0073848400EFCE
      C600EFCEBD00D6AD9C00D6C6B500E7D6CE00ADBDD60084BDFF00529CFF004294
      F7001063DE002163B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00318CC6004AADFF004AB5FF0052B5FF0052B5FF0052B5FF0052B5
      FF0042ADF70039739C00FF00FF00FF00FF00639CC6007BB5EF0084BDEF0084BD
      EF0084BDEF0084B5EF004284B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBDBD00FFDEDE00FFFFFF00EFF7FF00B5D6E70094C6DE009CCE
      DE009CC6DE00DEEFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECE
      C600C6B5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A5A5A005A5A5A002184210000A5000000A5000000630000000063000000
      42000000290000004A0000008400000084000000840000008400000084000000
      84000000630063636300FF00FF00FF00FF00FF00FF00E7CECE00E7CECE00EFD6
      D600948C8C001894A50010B5C600188C940031CED60010ADAD004A7B7B00F7E7
      DE00DEB5AD00CEB5AD00EFDED600F7E7D600DECECE00ADCEE70084BDFF00529C
      FF004294F700186BDE00637B9400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00398CBD004AB5FF0052BDFF005AC6FF005AC6FF005AC6FF005AC6
      FF0042A5EF005A8C9C00FF00FF00FF00FF0063A5C6008CBDF7008CC6F7008CC6
      FF0094C6FF008CC6F7004284AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFDEDE00FFFFFF00FFFFFF00F7FFFF00EFF7F700EFF7
      F700F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECE
      C600C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C8C008C8C8C008C8C8C00393939000000
      6300000084000000840000008400000084000000840000008400000084000000
      84000000630063636300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7F7
      F7008C8C8C0042BDCE00299CAD0000425200425A6300188C940039636300CEB5
      AD00D6CECE00F7EFE700FFF7EF00FFE7DE00F7DED600CEB5B500A5C6DE008CBD
      FF005A9CFF00C6DEFF00DEDEDE0063738400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006BA5C6004AB5F70063C6FF006BCEFF006BD6FF006BD6FF0063CE
      FF003194D6009CB5BD00FF00FF00FF00FF0084B5CE0084BDEF0094CEFF009CCE
      FF009CCEFF008CC6F700528CA500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700F7DED600F7E7DE00FFEFE700FFEF
      EF00FFF7F700FFF7F700FFF7F700FFFFF700FFFFFF00FFFFFF00FFFFF700E7CE
      C600C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002121
      3900000084000000840000008400000084000000840000008400000084000000
      840021213900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF009CBDC6005AC6CE0042FFFF000863630018949400088C94007B8CA500E7CE
      CE00F7DEDE00F7DEDE00F7DEDE00F7CECE00DEB5B500D6CECE00C6C6CE00A5BD
      D600A5B5C600DEDED600BDD6EF001052BD0042639C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00399CD60063CEFF0073DEFF007BE7FF007BE7FF0063CE
      F7003984AD00FF00FF00FF00FF00FF00FF00FF00FF00529CCE009CCEFF00ADD6
      F700ADD6F700529CC600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00FFDEE700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00BD9C9400E7D6CE00FFE7DE00FFDE
      D600F7DED600F7DECE00F7DECE00FFDECE00FFDED600FFDED600FFE7D600EFD6
      CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00212139000000730000008400000084000000840000008400000073002121
      3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006BADC6004AADBD0052ADBD00398C9C009CBDCE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008C8C8C00849CBD00186BDE002163BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0039A5CE006BD6F7008CEFFF006BD6E700398C
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BA5CE0073AD
      CE0063A5C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFC6BD00F7D6D600FFF7F700FFF7F700FFFFF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00B59C9400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0039395A0000006B00000084000000730000004A0039395A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF003984D600317BD600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF007BB5CE0073ADCE008CBDCE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFD6CE00F7DED600F7DED600F7DED600F7DED600F7DE
      D600F7DED600F7DED600FFE7D600FFDECE00CEBDB500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0039395A000000310018184A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0084948C008C8C9400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094949400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0094949400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF005A735A00316342001073310039A5630052947300426B4A003952
      42005A635A00848C8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006B6B6B00735A5A006B393900424242009C9C9C00A5A5A500FF00
      FF00FF00FF00FF00FF008C8C8C004A4A5A0021218400212142009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A6B7300314A
      5A00524A4A006B6B7300FF00FF00FF00FF00FF00FF00FF00FF00737373006363
      63005A5A5A005A5A5A006363630063636300736B730084848400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C9C9C006B6B6B007B73
      7B00ADADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B7B6B00396342001873
      310008843100109C3900109C3900109C390039AD63005AB57B005AB57B0063C6
      8C005AB58C004A9C730042735200425A4A006B736B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C94
      94004A292900DE848400FF9C9C009C5A520052292900949494009C9C9C00848C
      84006B6B7300181839004A429400635ACE003131BD000000AD008C8C8C009C9C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00187BAD00107B
      BD00528CAD005A8CAD00317BA500186B9C0021394A00424242004A5252005A5A
      6300636B6300736B7300736B7300424242004A4A4A006B6B6B006B636B005A52
      5A00424242006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C9C9C00DEDEDE00C6BD
      C6006B636B008C8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF005273520021733900107B3100108C310010943900109C
      3900109C310010A53900109C3900109C390031A5520052B57B005AB57B0052BD
      840052B57B005AB57B0052B57B0052B57B0039634200FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073737300845A5A00AD6B
      6300FF9C9C00FF9C9C00FF9C9C009C5A520063313100423939004A4A4A003939
      5A00393973006363CE006363CE006363CE003131BD000000AD0021214A008C8C
      8C009C9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001884B500107B
      BD00A5B5B500FFDEC600DECEBD00BDBDAD004A4A4A004A4A4A005A5A6300736B
      6B007B737B00848484006B63630039313900393939007B7B7B00C6C6C600B5B5
      B50063635A004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A59CA500B5ADB500FF00FF009C9C9C00E7E7
      E700D6D6D6005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0094AD9C00108C310010943900109C390010A53900109C3900109C
      390010A5390008BD4A0000D65A0000E7630008F77B0021F78C0039F7940042DE
      8C0042C67B0052B5730052B57B0052AD7300315A3900FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A393900F7949400FF9C
      9C00FF9C9C00FF9C9C00FF9C9C009C5A52006331310052292900101029005A5A
      BD006363CE006363CE006363CE006363CE003131BD000000AD00000094002121
      420094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00188CC600107B
      C600A5B5B500FFE7C600FFDEBD00FFDEBD008C7B73004A4A52006B6363007B73
      7B008484840084848400949494004A4A4A0073737300737373008C8484008C8C
      8C006B6B6B004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00DEDEDE00949494006B636B00A5A5A500948C9400F7F7
      F700F7F7F70084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF009CAD9C0010943900109C390010AD420008BD4A0000DE5A0000EF
      6B0000F7730000FF7B0000FF730008C6630010945200318C5A00318C63002194
      5A0018B5630010F77B0018DE730029AD6B0063846B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073424200FF9C9C00FF9C
      9C00FF9C9C00FF9C9C00FF9C9C009C5A52006331310052212100101031005A5A
      C6006363CE006363CE006363CE006363CE003131BD000000AD000000AD000000
      940042424200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00188CBD002184
      C600BDC6BD00FFE7C600FFE7C600FFDEBD00DEBDA5005A5252006B6B6B00847B
      7B00848484007B737B00DED6D600635A6300C6BDBD00737373008C8C8C007B7B
      7B006363630073737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00DEDEDE00ADADAD00BDB5B5007B7B7B00ADADAD00F7F7
      F700FFFFFF009C949C00847B8400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A5B5A5000894390008BD5A0000E7630008C66300217B52004A73
      5A00637B6B005A846B0039735A00394A4A006B6B6B007B7373007B6363008C8C
      8C005A635A004A6342007B946B00AD9C8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073424200FF9C9C00FF9C
      9C00FF9C9C00FF9C9C00FF9C9C009C5A52006331310039080800080829003939
      A5005A5AC6006363CE006363CE006363CE003131BD000000AD000000AD000000
      94005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002194C600187B
      C600BDC6C600FFE7CE00FFE7CE00FFDEC600FFDEC600BDA58C005A5A52007B7B
      8400736B6B00BDB5A500A5ADAD004A525200BDB5AD00847B7B008C9494007B7B
      7B005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094949400C6C6C600D6CED600DEDEDE00E7E7
      E700DEDEDE00DEDEDE007B737B0084848400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00ADA59C00ADBD9C007B9C730042524A005A525A007373
      730094949400948C8C0063636300424242006B6B6B008C8C8C008C7B7B008C84
      8C00635A63009C736300E7BD9C00F7C6AD00FF00FF00FF00FF00FF00FF00FF00
      FF00BDBDC6008C8C9C00BDA5AD00FF00FF00FF00FF0073424200FF9C9C00FF9C
      9C00FF9C9C00FFA59C00FFB5B5009C636300633131004A000000080829002929
      8C00292984005A5AC6006363CE008484DE004A4AC6000000AD000000AD000000
      94005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002194C600187B
      C600C6CEC600FFE7D600FFE7CE00FFE7C600FFE7C600FFDEBD00BDA594004A42
      420039637B00398CC600187BCE00297BBD006394BD006B737300737373006363
      6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007B7B9C0052528C0039397B0084849C00BDBDBD00CECECE00D6D6
      D600CECECE00DEDEDE00DEDEDE007373730084848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFC6BD00FFE7C600F7CEB50073736B005A525A007373
      7B007B848C007B848C006B6B6B00393939006B6363008C8C8C009C9CA5008484
      840052525200A5736B00DEBD9C00FFDEB500DEBDB500FF00FF00FF00FF00FF00
      FF0084A5C6004A84D600737BAD00C6ADB500FF00FF0073424200FF9C9C00FF9C
      9C00FFBDB500FFD6D600FFE7E700CEA5A5006B3139004A000000000010000842
      6B0000527B00393984008484E700B5ADEF009494EF001010B5000000AD000000
      94005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002194CE002184
      C600D6DED600FFEFD600FFEFD600FFEFCE00FFE7CE00FFDEC600AD9C8400215A
      8C00218CDE00218CEF002994F7002994F700298CE700296BA50039313900FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00292994001818
      9C001010AD001018C6001018CE000810DE001821CE0042429C00525294008C8C
      9C00C6C6C600D6D6D600DEDEDE00D6D6D600737373008C848C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00DECECE00F7DECE00FFDEC6000000840000008400000084000000
      840000008400848494006B6B6B004A4A4A0084848400A59CA500A5A5A500948C
      9400636363009C736300DEBDA500FFDEBD00CEA59C00FF00FF00FF00FF00FF00
      FF0094CEF70052B5FF004284DE00737BAD00CEC6C600734A4A00FFA5A500FFE7
      E700FFDEDE00FFD6D600FFCECE00FFCECE00B58484001810100000A5CE0000BD
      E70000A5FF0008639C004A529C006363CE008484E7008484F7000000A5000000
      9C005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF0063848C002994D6002184
      C600EFE7DE00FFEFDE00FFEFDE00FFEFD600FFE7D600BDAD9C003973A500319C
      FF0039A5FF0039A5FF0042A5FF0042A5FF0039ADFF0039A5FF0031639C007373
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007373BD002131DE002131
      EF002129E7001829E7001021E7001018E7001018DE000008D6000000BD001810
      A50084849C00C6C6C600D6D6D600DEDEDE00DED6DE006B637300181863003939
      6B00636B7B00949CA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7CEC60000008400000084000000FF000000FF000000FF000000
      FF000000FF00000084000000840052525200A5949C00B5ADAD00B5B5B500ADA5
      A50094847B00B5847B00D6BDA500FFE7C600E7BDAD00FF00FF00FF00FF00FF00
      FF00FF00FF009CDEFF0052B5FF00428CDE009C8494009C8C8C00FFEFEF00FFCE
      CE00FFCECE00FFCECE00DEB5B500A5848400084A5A0000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00005A940042428C006363CE007B7BE7001008AD000000
      9C005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF0063849C002994DE002984
      C600FFF7E700FFEFE700FFEFDE00FFEFDE00FFEFD60084848400398CD60042AD
      FF0042ADFF0042ADFF004AB5FF004AADFF0042ADFF0042ADFF003984BD006B63
      6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007373BD002131E7002931
      EF002131EF002129E7001829E7001821E7001021DE000808CE000000C6000000
      BD001810A50094949C00C6C6C600D6D6D600DEDEDE00D6D6DE00635A8C000000
      AD0000009C0008086300B5B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000084000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000840042528C00635A5A008C736B00C6A5
      8C00F7CEAD00E7AD9400D6BDAD00FFE7CE00F7D6C600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009CD6FF0052B5FF00737BAD00C6A5AD00F7CECE00FFCE
      CE00FFCECE00FFCECE00A584840000526B0000CEF70000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00009CFF00005A9C00423984006363CE004A4AC6000808
      9C005A5A5A00FF00FF00FF00FF00FF00FF00FF00FF005A8494002994DE00217B
      BD00FFF7EF00FFF7E700FFEFE700FFEFDE00FFEFDE00636B7300429CEF004AAD
      FF004AB5FF0052B5FF0052BDFF0052B5FF0052B5FF004AB5FF003984BD00736B
      7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007373BD002939E7002942
      EF002939EF002131EF002131E7002129E7001829E7000810D6000000BD000000
      BD000000C6001810AD008C8CA500C6C6C600D6D6D600DEDEDE00DEDEDE006363
      94000000B50008007B00A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000084000000FF000000FF000000FF000000FF00A5ADFF00FFFFFF00A5AD
      FF000000FF000000FF000000FF000000FF0000008400215AAD00B59C8C00F7D6
      AD00FFD6B500DEAD9400D6BDAD00F7DEC600F7CEBD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094D6FF00428CDE007B84AD00635A5A00D6AD
      AD00F7C6C600F7C6C600AD8C8C00298CA50021CEF70000CEFF0000CEFF0000CE
      FF0000A5FF00009CFF00009CFF00009CFF00005284004A4A9C0042426B004242
      5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00527B8C00319CE7003184
      C600FFF7EF00FFF7EF00FFF7E700FFEFE700FFEFDE00636B73004AA5E70052B5
      FF0052BDFF0052BDFF0052B5FF0052BDFF005ABDFF0052BDFF00428CBD007B7B
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B73C6003142E7003142
      F7002942F7002939EF002131EF002131EF001829E7001010D6000000C6000000
      BD000000BD000000BD0029219C00A5A5A500C6C6C600D6D6D600D6DEDE00E7DE
      E70084849C006B6384005A5A5A009C9C9C00FF00FF00FF00FF00FF00FF00FF00
      FF00000084000000FF000000FF000000FF000000FF00A5ADFF00FFFFFF00A5AD
      FF000000FF000000FF000000FF000000FF00000084001063DE003163B500BDA5
      9400F7D6AD00DEA59400C6A59C00F7DECE00EFC6C600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0073BDF70094A5AD00C6BDB5008463
      5A00DEB59C00DEC6AD00E7D6BD00E7CEBD00CEC6BD0018CEF70000CEFF0000CE
      FF0000A5FF00009CFF00009CFF00009CFF0000528C0021214A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005A849C00319CE7004294
      CE00FFFFF700FFF7EF00FFF7EF00FFF7E700FFF7E700737B840052A5E7005AC6
      FF005ABDFF005ABDFF006BCEFF0073DEFF006BD6FF005ACEFF004A739C009C9C
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007373C6003142EF003142
      EF002939E7002131DE001829DE001821D6001821D6001008C6000000B5000000
      B5000000BD000000BD002121A500ADADAD00A59C9C00C6C6C600C6CECE00E7E7
      E700FFFFFF00F7F7F700CECECE0063636300ADADAD00FF00FF00FF00FF000000
      84000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF00000084001063DE002963
      B500B5A59400CE9C8C00CEB5AD00FFF7EF00E7CECE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DECEC600C69C8C00EFD6
      B500FFF7C600FFFFD600FFFFDE00FFFFE700F7F7EF00ADB5BD0000CEFF0008D6
      FF0000A5FF00009CFF00009CFF00009CFF0000528C008C8C8C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00427B8C00319CEF004A94
      C600FFFFFF00FFF7F700FFF7EF00FFF7EF00FFEFE700A5A59C004A8CB5006BCE
      FF0073DEFF0084EFFF0094F7FF0084E7FF0073DEFF006BC6EF004A5A6B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007B73C6002139DE002939
      E7003142EF003139EF002942EF002939EF002939EF001018DE000000C6000000
      BD000000BD000000BD002121A500D6D6DE006B6B94009494A500D6D6D600EFEF
      EF00F7F7F700F7F7F700E7EFEF00BDBDBD0073737300FF00FF00FF00FF000000
      84000000FF000000FF000000FF000000FF000000FF000000FF00FFFFFF000000
      FF000000FF000000FF000000FF000000FF000000FF00000084004294F7001063
      DE002963B5009C7B7B00B59C9400E7C6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CEC600F7D6AD00FFF7
      C600FFF7C600FFFFD600FFFFEF00FFFFFF00FFFFFF00D6BDB5005ACEE700ADFF
      FF0018C6FF00009CFF00009CFF00009CFF0000528C00BDBDBD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00528CAD002994EF006BAD
      CE00FFFFFF00FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7EF00CECEC6005A6B
      7B005A9CBD007BDEF7008CF7FF0084D6DE00528C9C0029394A008C8C8C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007373C6003952F7004252
      FF003952F700394AF700314AF7003142F7002939EF000810DE000000D6000000
      D6000000CE000000CE000000C6001010B5001008B50042429400CECECE00DEDE
      DE00B5B5BD00424273007B7B8400DEDEDE006B6B6B00FF00FF00FF00FF000000
      84000000FF000000FF000000FF000000FF000000FF00A5ADFF00FFFFFF00A5AD
      FF000000FF000000FF000000FF000000FF000000FF0000008400529CFF004294
      F7001063DE002152AD0084737300BDADAD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEBDAD00FFEFBD00FFE7
      B500FFF7C600FFFFD600FFFFEF00FFFFFF00FFFFFF00F7E7CE0084ADA50000FF
      FF0000FFFF0000C6FF00009CFF00009CFF0000528C00BDBDBD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A8CAD002994EF006BAD
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7EF00FFF7E700FFEF
      E700BDB5AD008C848400847B7B00948C840039739C00294A6B009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003131CE00425A
      FF00425AFF003952FF003952F700394AF7001021E7000008DE000008DE000008
      D6000008D6000008DE000008DE000008D6000008D6003939A500C6BDBD00D6D6
      D6007B73940008008400A5A5AD009494940094949400FF00FF00FF00FF000000
      84000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF000000FF000000840084BDFF00529C
      FF004294F7001063DE00215AAD00A5A5AD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CEB500FFEFBD00FFDE
      AD00FFF7BD00FFFFD600FFFFE700FFFFEF00FFFFEF00FFFFCE008CB5AD0000FF
      FF0000FFFF0000FFFF0000CEFF00009CFF0000528C00BDBDBD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00529CBD003194E7004263
      84009C9C9400B5B5AD00CECEC600D6D6D600E7E7E700F7EFEF00FFF7EF00FFF7
      EF00FFF7E700FFF7E700FFEFDE00EFE7D6004A8CBD00294A73009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003139
      C600425AFF00425AFF004252FF002939F7000810DE000008DE000008D6000008
      DE000008DE000008D6000008DE000008DE000008D6001018C600948C9C00C6C6
      C600ADADB5004A4A6B00B5B5B500FF00FF00FF00FF00FF00FF00FF00FF000000
      84000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF000000FF0000008400ADBDD60084BD
      FF00529CFF004294F7001063DE002163B500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7CEB500FFF7BD00FFE7
      B500FFEFBD00FFFFCE00FFFFDE00FFFFDE00FFFFDE00FFFFCE008CB5AD0000FF
      FF0000FFFF0000FFFF0000FFFF0000C6FF0000528C00BDBDBD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AA5C6003194EF004A6B
      7B00D6DEC600CECEB500BDBDAD00ADAD9C00ADAD9C009C9C8C009C948C00ADA5
      A500CEC6BD00EFE7DE00F7EFDE00E7DED600428CBD00294A6B009C9C9400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A5AC600424AC6003939C6003139CE00737BDE00A5ADF7005263EF002939
      E7002931E7002131E7002939E7001821E7000810DE000810DE002931B5007B84
      9400ADADB500949494009C9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000084000000FF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF0000008400F7E7D600DECECE00ADCE
      E70084BDFF00529CFF004294F700186BDE00637B9400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7C6AD00FFF7D600FFEF
      C600FFE7B500FFEFBD00FFF7C600FFFFCE00FFFFCE00FFE7BD0084A59C0000FF
      FF0000FFFF0000FFFF0000F7F70000525A005A737B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AADC6003194F700316B
      A500949C9C00D6CECE00D6DECE00DEDECE00DEDECE00E7E7CE00EFEFCE00D6DE
      BD00C6BD9C00A59C8C00A59C8400848C8400216BA500314A73009C9C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C6C6DE009C9CAD008C84A500524A
      94005A5AAD00737BBD00BDBDDE004A52BD002939BD002931B5003131AD007B7B
      B500CED6CE00D6D6D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000084000000FF000000FF000000FF000000FF000000FF00FFFFFF000000
      FF000000FF000000FF000000FF000000FF0000008400FFE7DE00F7DED600CEB5
      B500A5C6DE008CBDFF005A9CFF00C6DEFF00DEDEDE0063738400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7C6C600F7E7D600FFFF
      FF00FFF7E700FFEFBD00FFE7B500FFE7B500FFEFBD00DEB5940063D6D60000FF
      FF0000BDBD00188C8C004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BA5B5005AC6FF0042A5
      F7004284B5006B7B8C00ADADB500D6D6D600CEC6C600D6D6CE00D6D6CE00D6D6
      CE00DEDECE00DEDECE00E7E7CE008C949400186BA50029526B009CA5A500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5A5A500BDB5B5007373
      730073737300A5A59C009C9C9C00B5B5BD00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00000084000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF0000008400F7DEDE00F7CECE00DEB5B500D6CE
      CE00C6C6CE00A5BDD600A5B5C600DEDED600BDD6EF001052BD0042639C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEC6BD00FFEF
      EF00FFFFEF00FFF7C600FFEFBD00FFEFC600FFEFBD006B52420000D6D600006B
      6B007B8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084949C006B9CA50073AD
      C60073BDD6006BADC6007B848C00E7DEDE00A59C9C00636B73006B737B00BDB5
      BD00CECECE00ADADAD008C949C00316384002173BD00394A6300ADADB500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B500ADADB500C6C6
      C600D6D6D600D6D6D600948C9400E7E7E700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000008400000084000000FF000000FF000000FF000000
      FF000000FF000000840000008400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF008C8C8C00849CBD00186BDE002163BD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6AD
      A500E7C6AD00F7DEAD00F7E7BD00EFD6B500DEB5A500FF00FF005A737300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C949400CECECE00EFEFEF00EFE7E700CEC6
      C600847B84007B848C008C9C9C007BA5A50073A5AD00848C9400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF00E7E7
      E700D6D6D600C6C6C600E7E7E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000840000008400000084000000
      840000008400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF003984D600317BD600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00DECEC600D6BDB500DEC6BD00DEC6C600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD009C9C9C009C949C00B5B5
      B500E7E7E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B5B5B500949494007B737B00635A6300525252004A4A4A00635A
      630084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00635A6300636363006B6B6B00737373007B737B007B737B006B6B6B005A5A
      5A0052525200424242004A4A4A005A5A5A0084848400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A7B63005273630063736B008C949400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A59C9C00A5A5A500B5B5
      B500A59CA500736B6B007B848400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B63
      6B0094949400B5ADB500BDBDBD00CECECE00E7E7E700E7E7E700BDBDBD009494
      940052525200525252005A5A5A005A5A5A00524A52004A4A4A004A4A4A006363
      63008C8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0042396300292952004A4A6300736B8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00637B6B00317B4A00107B3100108C
      390010A542005AC68C005AB57B0052A5730052946B005273630063736300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0094949400C6CECE00A5A5A5008473
      6B00BD9C7300AD9C8C00524A4A004A42390063636B009C9C9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADAD00E7E7
      E700FFFFFF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700CECECE00BDBD
      BD00948C94006B6B6B005A525A004A4A4A004A4A4A005A525A005A5A5A005252
      52004A4A4A004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF003121520073425A00523152002921520018184A001818
      4A00292952004A4A630073738400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00527B5A0018733100108C3100109C3900109C3900109C390010A5
      390010AD420042BD7B005AC6840052BD7B0052AD730052B57B004A9C6B008C94
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094949400D6CED6009C9C9C00524231008C52
      18008C4A08009C5A1800847B7300A57B4200B58C4A006B5A4200524A4A007B7B
      7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B500E7E7
      E700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700CECECE00CEC6
      C600CEC6CE00CEC6CE00BDBDBD00ADADAD008C8C940073737300525252004A42
      4A005A5A5A00525252008C8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007B7394006B426300EFA58400EFB58C00DE9C8400BD7B73009C63
      6B006B3952004A295200292152001818520010184A0029214A004A4A63007373
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00107B3100109C3900109C390008AD420008C6520000DE5A0000F7
      6B0000EF730010D6730021D67B0029D67B0029DE7B0039CE7B00399C6300635A
      5A009C8C8C00B5B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C94007B7373008C848400B58C5A00DEAD
      7B00E7C6A500AD947B006B523900BD8C4200FFB55A00FFBD6300E7AD63009C7B
      52005A5242005A5A5A008C8C8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A59CA500847B7B009C949C0084848C00DEDE
      DE00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7E700C6C6C60073B5
      8C00C6C6CE00CECECE00CECECE00CECECE00CEC6CE00CEC6CE00CEC6CE00B5B5
      B500B5B5B500ADA5AD006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0031316300AD636B00FFBD8C00FFCE9400FFCEA500FFD6AD00FFDE
      BD00FFE7CE00EFCEC600D69C9400BD8484009C636B006B425A004A2952003121
      520018104A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00187B310008BD520000E76B00189C5A0042946B0052A57B003194
      630039524A006B6B6B0084848400736B6B004273520063A57B00949C8C00CEB5
      B500C6A5A500AD848C0094737B0094737B009C949400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C9C9C00949494006B636B009C520800AD5A
      0800AD520000B573310094847300B57B3100FFB54A00FFB55200FFBD6300FFBD
      6B00F7BD7300C69C6B00846B52005A524A00736B6B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00AD9C9400D6A59C00BD8C8C0094737300C6C6
      C600EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00DEDEDE00D6D6D600C6CE
      C600D6D6D600C6A5A500C6949400C69C9C00C6ADA500CEB5BD00D6CECE00CECE
      CE00CECECE00A5A5A50084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0029215A00D67B7300FFB58400FFB58400FFB58400FFBD8C00FFC6
      9C00FFD6AD00FFE7C600FFD6BD00FFD6B500FFD6BD00F7CEBD00E7B5AD00CE9C
      9C006B5A7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008CA594004A4A52007B7B7B00A59CA5006B6B
      6B004A4A4A007B7B7B00949C9C007B7B7B007B737300EFD6D600E7CECE00EFCE
      D600EFD6DE00EFDEDE00EFD6DE00E7CECE00D6B5B500B5848C00B5ADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00949494008C848C0073736B00AD846300CEAD
      8400CEAD9400A57B520063524200BD843100FFAD4200FFAD4A00FFB55A00FFB5
      6300FFBD6B00FFBD7B00FFC68400E7B58400947B6300736B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00B5A5A500E7C6C600DEC6C600D6BDBD00ADA5
      A500E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700DEDEDE00DEDE
      DE00D6ADAD00D69C9C00D6949400CE8C9400CE8C8C00C6848400CEA5A500D6D6
      D600D6D6D6008C848C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084849C0063395A00EF947300FFB57B00FFB58400FFBD8C00FFBD8C00FFC6
      8C00FFBD9400FFBD9400FFC69C00FFCEAD00FFDEC600F7E7D600C6ADA500B5AD
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00524A4A0084848400A5A5A5007373
      73004A424A007B737B009C9C9C007373730073636B00E7C6CE009C7B84009C7B
      7B00AD8C8C00BDA5A500D6C6C600F7E7E700F7E7E700CE9C9C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009494940084848C006B635A00BD630800BD6B
      0800C66B1800CE94520094846B00BD7B2100FFA53100FFAD3900FFB54A00FFB5
      5200FFBD6300FFBD6B00FFBD7B00FFC68400CEA57B006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BDA5A500E7CECE00E7C6C600E7CEC600948C
      8C00DEDEDE00E7E7E700E7E7E700EFE7EF00EFEFEF00EFEFEF00E7DEDE00DEAD
      B500E7ADAD00E7ADAD00DEA5A500DEA5A500D69C9C00D6949400D6B5BD00DEDE
      DE00C6C6C60084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00181852006B395200F7844A00FF8C5200FF9C6300FFA56B00FFB57B00FFBD
      8C00FFC69400FFCE9400FFC69400FFD6AD00FFDEBD00FFD6B500847B73005252
      5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004A4A4A00736B7300848484007373
      73006B636B00BDB5B500BDBDBD00ADA5AD0094848C00CEB5B500B59C9C00A584
      8400AD8C8C00A57B84009C7B7B00EFEFE700E7C6C600CEB5BD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C9494009494940063635A009C7B5A00B59C
      7B00B5946B008C5A2100635A5A00B5732900FFA52900FFAD3100FFAD4200FFB5
      4A00FFB55200FFBD6300FFBD6B00FFC67B00CEA56B006B6B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BDA5AD00E7D6CE00D6ADAD00CE949C00B584
      8C009C9C9C00CECECE00E7DEDE00EFEFE700DECECE00DEADAD00EFB5B500FFC6
      C600F7BDC600F7BDBD00EFB5B500EFB5B500E7ADAD00D6A5A500E7DEE700CECE
      CE007B7B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF002929630008084A0029184A0052314A007B424A00AD5A4A00CE6B4A00E77B
      4A00FF945A00FFA56B00FFAD7300FFAD7B00FFB58400FFC69C00A59C94006B63
      630073737300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C949C006B636B00ADADAD00BDB5BD009494
      94006B5A5A00B59C9C0094737B00AD949400D6BDBD00E7D6D600EFDEE700F7EF
      E700EFDEE700D6C6C600CEBDBD00FFEFEF00CE9C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C9400847B84006B5A5200D6730800DE7B
      1800D6944200CEAD84008C6B4A00CE7B0800FFA51800FFA52100FFAD3100FFAD
      3900FFAD4A00FFB55200FFB56300FFBD6B00CE9C6300736B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BDADAD00EFD6D600D6ADAD00D6ADAD00DEB5
      B500C6A5AD00948C8C00C6C6C600FFFFFF00F7EFEF00F7E7E700EFD6D600EFC6
      CE00EFC6C600E7B5B500EFB5B500E7ADAD00DEB5B500E7DEDE00ADADAD00948C
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007373940008085200101052001018520010185A0010216300182163002929
      630039315A005A425A0084525200A5635A00CE7B5A00E78C63005A4252008C8C
      8C004A4A4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C7B7B00A59494008C7B7B009C9494009C8C
      9400BDADAD00EFDEDE00BDADAD00F7E7E700E7D6D600CEBDBD00CEB5BD00C6B5
      B500CEBDBD00BDA5A500F7EFEF00EFCED600C6B5B500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A59C9C009C9C9C00524A4200946B3100A57B
      4A00A5733100A55A1000736B6B00B5731800FF9C0800FFA51800FFA52900FFAD
      3100FFAD4200FFB54A00FFB55200FFBD6300CE9C5A00736B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C6ADAD00EFDED600E7C6C600DEBDBD00DEB5
      B500B5949C009C9C9C00CED6CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6BDC60084737B00949494009C949C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A59C
      A5007B7B8C000810520010185A00182163001829630018296B0021316B002131
      6B00213173002139730021397B0029397B0021397B0031427300181852006363
      6B00737373006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00B5ADAD00C6ADB500DEBDBD009C737B00E7D6D600BDA5
      A500BDA5A500B5949C00E7D6D600F7EFEF00F7EFEF00F7EFEF00F7F7F700FFF7
      F700EFEFEF00C6B5B500FFFFFF00D6A5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C8C007B737B007B634A00D68C3100E79C
      4A00E7B57B00C6A58400735A3900C6730800BD731000CE841800F79C1800FFA5
      2900FFAD3100FFAD3900FFB54A00FFB55200CE945200736B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C6ADB500EFDEDE00DEB5B500D6A5A500CE9C
      9C00B5848C0084737300C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7F700B5B5B50073737300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0073737B00948C
      940073737B001818520018296B0018296B0021316B0021317300213973002139
      730021427B0029427B00294A8400294A8400294A8C0031528C0029427B003931
      52008C8C8C004A4A5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C848400EFD6D600D6A5AD00AD8C8C00F7E7DE00C6AD
      AD00F7E7E700C6ADAD00F7EFEF00F7EFEF00F7F7F700FFF7F700FFF7FF00FFFF
      FF00E7DEDE00E7D6DE00F7EFEF00C6A5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C9C9C00A5A5A500523929009C5A0800A563
      1000A55A0000AD6B1800847B7300B56B08009C7B4A00CEC6B500A58C7B009473
      4A00BD7B2900EFA53100FFAD3900FFB54A00CE944A006B6B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C6B5B500EFDEDE00EFE7E700EFE7E700CECE
      DE00D6CEE700BDB5B500ADADAD00C6CECE00DEDEDE00E7E7E700EFEFEF00F7F7
      F700FFFFFF00CECECE007B737B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00ADADAD00C6D6
      DE00BDD6DE00424A7B0029427B0029427B0021397B0021427B0021427B002942
      7B00294A8400314A840031528C0031528C0031529400395A9400395A94001821
      52007373730084848400635A6300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00B59C9C00EFCECE00BD8C9400CEBDBD00DEC6CE00BDA5
      AD00CEBDBD00CEC6C600FFF7F700FFF7F700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CEC6C600FFF7F700EFC6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C8C007B7B7B00846B5A00C6945A00DEB5
      8400E7CEAD00B5946B00634A2900B56B1000A58C6300EFEFDE00D6CEC600CEC6
      C600BDADB50094848C008C6B5A00CE8C3900CE944200736B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CEB5B500F7E7E700E7DEE7005A94E7002984
      EF002984F7004A84E700CECEDE00D6D6D600C6C6C600BDBDBD00B5B5B500ADA5
      A500948C8C00948C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00B5B5B5006BB5
      DE001894DE00106BB50018317B0021427B00314A840031528C00395A94004263
      9C0042639C0039639C0042639C0039639C0039639C0039639C00426B9C002939
      7B005A5A6B00949494005A525A009C9C9C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00ADA5A500DECECE00E7C6C600AD848C00EFDEDE00C6B5B500F7E7
      E700C6B5B500EFEFEF00D6C6CE00DED6D600EFE7E700FFFFFF00FFFFFF00FFFF
      FF00CEBDBD00FFFFFF00D6A5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009494940094949C0063391800C66B0000BD6B
      0000C66B0000C68431008C7B6B00A5630800A58C6B00F7F7EF00F7EFE700EFEF
      DE00DED6D600CEC6C600C6ADBD00AD7B4A00CE943900736B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00CEB5B500F7EFEF006B9CE7002994FF00319C
      FF003194FF002994FF005A94E700D6B5BD00D6A5A500D6ADAD00DEB5B500EFDE
      E700B5ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00B5B5B50073B5
      DE001894DE001094DE001094DE00108CD600107BC6000873BD000863AD000852
      9C00426394005A5A8400394A7B0039428400314A8400395A940042639C00426B
      A50039395A009C9C9C00737373005A525A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A58C8C00F7E7E700E7B5BD00AD8C8C00F7EFEF00AD9C9C00D6CE
      CE00C6B5B500EFEFEF00DED6D600E7DEDE00DED6D600F7EFEF00FFFFFF00EFEF
      E700DECECE00FFF7F700C69C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C8C94008C8C8C007B6B5200B5946300D6AD
      8400CEAD8C00A57342005A524200A5631000A58C6B00F7F7EF00E7E7D600DEDE
      CE00D6D6CE00DECECE00CEBDCE00B57B4200CE8431006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6BDB500E7E7EF00318CEF003194FF003194
      FF00319CFF003194FF002184F700D6DEEF00E7C6CE00E7CECE00E7D6D600EFE7
      E700B5ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00B5B5B500DEE7
      E700C6DEE700B5D6E7009CCEE7008CC6E70073BDE7005AB5E70042ADE70031A5
      DE009CCEEF00D6D6D600A57B5200DEA56B00D69C7300CECECE006B637B006B6B
      8C00ADADC600FF00FF007B7B7B0063636300ADA5AD00FF00FF00FF00FF00FF00
      FF00FF00FF00B59CA500F7E7E700D6ADAD00C6ADAD00EFEFEF00D6C6C600E7DE
      DE00CEC6C600EFE7E700DED6D600CEC6C600D6C6CE00FFFFFF00FFFFFF00D6CE
      CE00F7EFEF00FFDEDE00C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C94940084848400945A1800EF8C0000F78C
      0800F7942100D6A55A008C735A00AD630000AD733100A58C6B00ADA59C00C6C6
      B500E7DED600EFEFDE00DED6CE00AD7B3900CE8429006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6BDBD00CED6EF00318CF7003194FF003194
      FF003184F700318CF7002984F700A5BDEF00EFDEDE00E7CECE00E7C6C600F7E7
      E700B5ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00B5B5B500E7E7
      E700E7E7E700EFE7EF00EFE7EF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEF
      EF00EFF7F700D6D6D6009C5A2100CE630000CE630000FFF7E700948C9400C6BD
      C600FF00FF00FF00FF00FF00FF008C8C8C00FF00FF00FF00FF00FF00FF00FF00
      FF00CEBDBD00DECECE00F7DEDE00CE9C9C00DED6D600DED6D600E7DEDE00DED6
      D600E7E7E700E7E7E700D6CECE00CEBDBD00EFE7E700FFFFF700DEB59400BD94
      7300DEC6AD00EFB5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A5A5A500B5B5B500A5631000F78C0000F78C
      0000F78C0000DE7B0000736B6300A5631800EF840000E7840000DE840000D67B
      0800B57321009C733900947B6300A5732900CE8418006B6B7300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00D6BDBD00DEE7F700318CEF003194FF002994
      FF006BA5CE0063AD84006BAD9400BDD6D600FFFFFF00FFFFFF00FFFFFF00F7E7
      E700BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00B5B5B500DEAD
      8400D6844200DE945200DE9C6300DEAD7B00E7B58C00E7C6A500E7D6BD00F7E7
      CE00F7F7EF00DEDEDE00AD845A00DE945200DE944A00FFF7EF00948C9400CEC6
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00B59C9C00F7EFF700FFF7F700BD9C9C00F7EFEF00EFE7E700D6C6CE00C6B5
      BD00C6BDBD00CEC6C600CEC6C600D6C6C600DEDEDE00E7CEBD00DEAD5A00FFDE
      9C00EFBD9C00E7ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BDB5B5008C8C9400B56B1000F7940000F78C
      0000F7941800F7AD5200CE944A00DE842100EF840800EF840000F7840000F78C
      0000F7940000FF940000FF940000FF9C0000CE8418006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DEC6C600FFFFFF004A94EF00299CFF003194
      FF006394BD0000E7520000EF52009CCEA500FFFFFF00FFFFFF00FFFFFF00F7E7
      E700BDADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDBD00B5B5B500DE9C
      6300CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000E7BD8C00D6DEDE008C8C8C00BDB5BD00BDC6BD00BDC6C6007B7B7B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00B5949400FFFFFF00FFFFFF00C69C9C00D6BDBD00DEC6CE00EFD6DE00F7E7
      E700F7EFEF00FFF7F700F7F7F700F7F7F700E7E7E700C69C7300F7D6A500F7BD
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00949494008C5A1000C66B0000AD4A
      0800BD6B4200C68C6B00D6A58C00E7C6AD00EFCEAD00EFC68C00EFB57300F7A5
      4A00F7942100F7941000FF940000FF940000CE8408006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DEC6C600FFFFFF00BDD6F7002184EF003194
      FF005A9CB50000E74A0010C64A00DEEFDE00FFFFFF00CEA57B00D6AD8400D6A5
      8C00C6B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6BDC600B5B5AD00DEBD
      9C00D68C4A00D68C4200D6843100D67B2900CE732100D6731000CE6B0800CE63
      0000EFBD9400DEDEDE0073737300D6D6D600D6D6D600CECECE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00BD9C9C00FFFFFF00FFFFFF00F7F7F700F7EFEF00EFE7E700EFD6D600E7CE
      CE00E7C6C600E7BDC600DEA58C00EFB5AD00EFB5BD00E79C8C00EFC6C600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C949400947B
      730084634A007B523100844218008C42100094421000A5522100B5633900BD73
      5200BD847300AD7B7B0094634A00845A21007B5A2900948C8C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DEC6C600FFFFFF00FFFFFF00C6DEF7005294
      EF0073A5BD0042B56300B5D6BD00FFFFFF00FFFFFF00D69C5200FFDEA500E7BD
      AD00EFEFEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084848400ADAD
      AD00BDBDBD00BDBDBD00CECEC600CECECE00DED6D600DED6D600EFE7DE00EFE7
      DE00F7F7EF00BDBDBD0094949400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00CEB5B500CEADAD00D6ADB500DEB5B500DEB5BD00E7BDBD00EFC6C600F7D6
      D600F7E7DE00F7DED600DEA57B00F7BDB500F7DEDE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009C9C94008C7B7300736352006B42
      290063392100635A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00E7C6CE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFF700FFFFFF00FFFFFF00FFFFFF00D6A57B00EFC6B500E7DE
      DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00CECECE00CECECE00BDBDBD00BDB5BD00B5ADB500ADADAD00ADADAD00ADAD
      AD009C9C9C00A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFEFEF00F7DE
      DE00F7D6D600F7CECE00F7D6D600FFF7F700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00E7C6C600E7C6C600E7CEC600EFCECE00EFCE
      CE00F7CECE00F7CED600F7D6D600F7D6DE00FFDEDE00DEA58C00E7D6D600FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00424D3E000000000000003E000000
      2800000068000000EE0100000100010000000000E01E00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFC0000000000000000000000000
      FFFFFFC0000000000000000000000000FFFFFFC0000000000000000000000000
      FFFFFFC0000000000000000000000000FFE0FFC0000000000000000000000000
      FF807FC0000000000000000000000000FE003FC0000000000000000000000000
      FC001FC0000000000000000000000000F80010C0000000000000000000000000
      F00000C0000000000000000000000000F0000040000000000000000000000000
      F0002040000000000000000000000000F0002040000000000000000000000000
      F0007040000000000000000000000000F800F840000000000000000000000000
      C4000FC0000000000000000000000000C38E07C0000000000000000000000000
      83FE03C0000000000000000000000000818203C0000000000000000000000000
      818203C0000000000000000000000000C10187C0000000000000000000000000
      C381E7C0000000000000000000000000C381FFC0000000000000000000000000
      F7C1FFC0000000000000000000000000FFE7FFC0000000000000000000000000
      FFFFFFC0000000000000000000000000FF3FFFFFFF3FFFFE7FFFFFFFFF000000
      FC07FFFFFC03F9FC3FFFFF0001000000F001FFFFE000F00031FFFE0000000000
      8000C7FF0000100031E7FC0000000000000003FC0000000000C7FC0000000000
      000001E0000000000007E0000000000000000040000008000007C00000000000
      00000040000008000007C0000000000080000000000008000007800000000000
      E0000E40000008000003000000000000E0003FC0000018000003000000000000
      E0007FC0000038000002000000000000E007F3C00001F8000002000000000000
      E00FE3F80001FF000000000000000000E0BFC3FE0001FF800000000000000000
      F0BF03FE0001FF800000000000000000FFBF01FE0001FF800000000000000000
      FFBFC1FE0001FF800002000000000000FFBFC1FE0001FFE00003000000000000
      FF9F83FE0001FFF00003800000000000FFDF03FE0003FFF00003800000000000
      FFC707FE00CFFFF00003C00000000000FFC00FFE00FFFFF00003F80000000000
      FFE00FFE00FFFFF0000FFF803F000000FFF01FFF00FFFFF001FFFFFE7F000000
      FFFC3FFFFFFFFFF00FFFFFFFFF000000843F1FFFFFFFFFFE0FFFFC01FF000000
      001801FFFFFFFFF803FFC0001F0000000000003FFFFFFFC000FE000007000000
      0000003F807FFC00001C0000030000000000003F0007F800001C000003000000
      0000003E0000780000060000030000000000003C000038000006000007000000
      0000003C0000180000070000070000000000003C000018000007C0003F000000
      00000020000018000007E0003F00000000000020000018000007E0000F000000
      00000020000018000007E0000300000000000060000018000007C00001000000
      E0000060000018000007C00000000000F8000060000018000007800000000000
      F8000060000018000007800000000000F8000060000018000007800000000000
      F8000060000018000007800000000000F8000060000018000007800000000000
      F8000060000018000007800003000000F80001E000001C000007800003000000
      F80043E000001E00000FC00003000000F8007FE000001F80001FC00007000000
      FC00FFE000001FE007FFF0003F000000FE00FFE000001FFBF7FFFC007F000000
      FFFFFFFFFFFFFFFBFFFFFE007F000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      F8FFFFFFFC07FFFFFFFFFFFFFF000000E007FC7FF003FE3FFFFFFFFFFF000000
      C000307FF001FE01FFFFFFFFFF0000008000007E00007E001FFFFFFFFF000000
      8000007800003E0001FE00007F0000008000006000001E00001E00003F000000
      8000006000001E00001E00001F0000008000006000001E00001E000003000000
      8000006000001E00001E0000030000008000006000001E00001E000003000000
      8000006000001E00001E0000030000008000006000001E00001E000003000000
      8000006000001E00001E0000030000008000006000001E00001E000003000000
      800000E000001E00001E000003000000800001E000001E00001E000003000000
      80000FF000001F00001E00000300000080001FF800001F80001F800003000000
      80001FFE00007FC0001FC0000300000080001FFF00003FE0003FE00003000000
      80001FFF80003FF0007FFFFFFF00000080001FFFC001FFF801FFFFFFFF000000
      80003FFFE087FFFC03FFFFFFFF000000E0007FFFF7CFFFFE0FFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FF83FFFFFFFFFFFF1FFFFFFFFF000000FE007FFFFFFFFFFE0FFFFFFFFF000000
      FC0F3FFF007FFFD801FFFE03FF000000FC1FDFE0000FFFC0007FF800FF000000
      F83FEFE0000FFC60007FF0007F000000C03FF7E00009F800007FE0003F000000
      E03FF7E00000F380007FC0001F000000E01FFFE00000F380007F80000F000000
      F03FFFF00001F380007F80000F000000F0FFFFF00001F380007F00000F000000
      FBFFFFF00000F800007F000007000000FFFFFFF00000FC00001F000007000000
      FFFFFFF000007C00001F000007000000FFFFC7F000007F800007000007000000
      FFFF07F000003F00001F00000F000000F7FC03F000003E00000F80000F000000
      F7FF03F000001C00000780000F000000F7FF01F000019F800007C0001F000000
      F3FF07F00003DF80000FC0003F000000F9FE0FF00003FF80001FE0007F000000
      FCFC1FF00003FF00003FF800FF000000FE001FF00007FF00007FFE03FF000000
      FF003FF8003FFFC00CFFFFFFFF000000FFC0FFFE007FFFFE1FFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FF83FFFE0FFFFFFFFFFFFFFFFF000000FC01FFF803FFFFFFFFFFFFFFFF000000
      E000FFF001F07FC7FFFFFFFFFF00000080007FE000E03FC3FCFE000003000000
      00007FE000401FC0087E00000300000000007FE000001FC0003E000003000000
      80007FE000001FC0003E000003000000E0007FF000001FC0007E000003000000
      E00038F800001C00007E000003000000E000007800001800003E000003000000
      E000007800001C00001E000003000000E00000F800001F00001E000003000000
      E00001F800001F80000E000003000000E00003F800001F80000E000003000000
      E00003F800001F80000E000003000000E00003F800001F80001E000003000000
      E00003F800001F80000E000003000000E00003F800003F80000E000003000000
      E00003F800007FC0000E000003000000E00003F800007F80000E000003000000
      E00003FC0000FF80000E000003000000E00003FF8001FF80001F000007000000
      F00003FFF803FFFE07FFFFFFFF000000FF0003FFFF03FFFFFFFFFFFFFF000000
      FFFC03FFFFFFFFFFFFFFFFFFFF000000FFFFFFFF3FFFFFFFFFFFFFFFFF000000
      FFFFFFFF3FFFFFFFFFFFFFFFFF000000FFFFFFFC0FFFFC0FFFFFFFFFFF000000
      FF0FFFF801FFF800FFFFFFFFFF000000FE001FFF0003F8003FFF81C0FF000000
      FC0001FF0000F8001FFF80007F000000F80001FE0000F80003FF800003000000
      F00001FC0000F800001F800003000000E00001F80000F800000F800003000000
      E00001F80000F800000F800003000000E00001F80000FC00000F800007000000
      E00001FC0000FC00000F800007000000E00001FC0000FE00000F800007000000
      E00001FC00001E00400F800007000000E00000F800007F00E01F800003000000
      C00000F000007F00E03F800003000000C00001E000003F00F03F800003000000
      E00003E000001F00E03F800003000000F00007FC00003E00E03F000003000000
      F8000FFC00007E00E03F00000F000000FC003FFC0000FE00E03F00000F000000
      FE01FFFC0000FF00E03F00001F000000FF07FFFF0063FF01F07F00F01F000000
      FF9FFFFFF0FFFF83F8FFF1FF3F000000FFFFFFFFFEFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFE000FFF0003FFFC7F000000
      FFFE03FFF0000FF00003FFE003000000FFF0007F80000C000003FE0003000000
      FC00007100000C000003F80003000000FC000070000008000003800003000000
      E0000060000008000003000003000000E000006000003800000600000F000000
      C000006000003800000700000F000000800003E000003800000700000F000000
      800003E000003800000780000F000000C00003E0000038000007E0003F000000
      C00003E000007800000FC0003F000000E00003E00000F8000007C0003F000000
      F0000FE00000F8000007807E7F000000F0007FE00000F8000007807FFF000000
      E060FFE00000F8000007807E7F000000C03FFFE00000F800000780FE7F000000
      C03FFFE00000F8000007C0FF3F000000C03FFFE00000F8000007E1FF1F000000
      C03FFFE00000F8000007FFFF8F000000C03FFFE00000F8000007FFFF87000000
      C03FFFE00000F8000007FFF187000000E03FFFE00000F800000FFFF187000000
      E07FFFE003FFF8007FFFFFF80F000000F8FFFFF003FFFC007FFFFFFC1F000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFCFFFFFFFFFF000000
      FE1F8FFC0201FFF07FFFFFFFFF000000FC0E04FC8041FFE07FFFFFF8FF000000
      F000007C2241FFC03FFFFFF07F000000E00000FC0200FFC0007FFFE03F000000
      E00000FC0200FFC0001FFFC01F000000E00000FC2240FF00000FFF800F000000
      E00000FC2240FE000007FF0007000000E00000FC0201FC000007FE0003000000
      E00000E000001C000007FC0007000000E00000E0000018000007F8000F000000
      E00000E0000018000007F0001F000000E00000E000001800000FE0003F000000
      E00001E000001C00000FC0007F000000C0000FE000001E00001F8000FF000000
      80001FFC0000FE01C07F0001FF00000080001FFC0000FE03FFFE0003FF000000
      80001FFC0000FE0FFFFC0007FF00000080001FFC0000FE0FFFFC000FFF000000
      80001FFC0000FE1FFFFE001FFF000000C1801FFC0000FE1FFFFF003FFF000000
      F1C03FFC0000FE1FFFFF807FFF000000FFE07FFC0003FE3FFFFFC0FFFF000000
      FFF3FFFC0007FE3FFFFFE1FFFF000000FFFFFFFC000FFF7FFFFFF3FFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFE7FFFFFF87FFFFFFE7F83E0F000000FFE3E1FFFE07FFFFFF83F00407000000
      FFE1C1FFFE07FFFFFF03F00003000000FFF181FFFC03FFFFFE07C00003000000
      FFF101FE0001FFFFFC0F800007000000FE2003F800007FFFF81F000003000000
      FE0007E000001FF8F03F000003000000FF000FE000001F80007F000003000000
      FF801FE000001F0000FF000001000000FFE01FE000001E0001FF000003000000
      FFC00FE000003E0001FF000003000000FFC001E00000FC0001FF000007000000
      E78000E00001FC0001FF000003000000E30000600001FC0001FE000003000000
      C00100700003F80000FE00000700000080038E780007F80000FE00000F000000
      80078FFC001FF80000FF00001F000000C00F8FFE001FFC0001FF00003F000000
      E01F87FF001FFC0001FF80007F000000E01FC7FF001FFC0001FFC0007F000000
      F00FE7FF801FFE0003FFE001FF000000F807FFFFC07FFF0007FFF01FFF000000
      FC03FFFFE1FFFF800FFFF87FFF000000FE03FFFFF7FFFFE03FFFFCFFFF000000
      FF03FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FF0FC8FFFFFFFFFFFFFFFFA3FF000000FE00007820FFFC1FFFFFFE807F000000
      FC000070007FFC187FFFFE0007000000F0000070007FF81807FFFE0001000000
      E00000F00003F800060FFF0001000000E00001F0000078000407FB0001000000
      C00001F0000078000007F80003000000C00001F8000078000007E00003000000
      C00001F8000078000007C00007000000C00001F8000078000007C00007000000
      C00001F8000078000007800007000000C00001F8000078000007800007000000
      C00000F8000078000007800007000000C00000F800007800000780000F000000
      800001F800007800000780000F000000800001E000001800000780000F000000
      C00003E000001800000700000F000000E00007F000003800000700001F000000
      E0000FF800007800000700001F000000F0001FF800007800000700003F000000
      F8003FF00000380000070000FF000000FE03FFE001001800000E0003FF000000
      FF0FFFE0038018007FFF000FFF000000FF3FFFFF07C1FC007FFFFE1FFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFF8C7FFFFFFFFFFFFFFFFFFF000000FFFF00707FFFFFE007FFF0FE3F000000
      FFFF007060FFFF8003FFE0781F000000FFFF0060601FFE0001FF00000F000000
      FFFF006000183E00007F000007000000FFFF006000101E00001F000007000000
      8FFF806000001FC0000F00000700000087FFC0E000001FC0000F000007000000
      87FFC0E000001FC0000F000007000000800061E000001FC0003F000007000000
      800031E000001F80003F00000700000080001FE000001F00003F000007000000
      80000FE000001F00007F80000F00000080038EE000001F0000FFC0003F000000
      800EF86000001E0000FFE0007F000000FFFEF86000001E00007FF4007F000000
      FFFF78E000001E00007FFC007F000000FFFF39E000001C00007FFC007F000000
      FFFF81E000001C0000FFFC007F000000FFFFC3E000001C0001FFFE00FF000000
      FFFFFFE000001C0007FFFF01FF000000FFFFFFE000001C001FFFFF87FF000000
      FFFFFFE001FFFFF87FFFFFDFFF000000FFFFFFF001FFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFF9FFFFFFFFFFFFFF000000
      FFFFFFFFFF01FFFC0FFF8FFFFF000000C1FFFFFFF000FFE001FF03FFFF000000
      C183FFFFE000FF0000FF03F87F00000081807FFE0000F80000FF00000F000000
      800060FE0000F80000FF0000030000008000407C0000F80000FF000003000000
      8000007C0000F800030F0000010000008000007C0000FF00000F0000E3000000
      8000007C00007F8000070007FF0000008000007C00007F800007000FFF000000
      8000007C00003F800007FFFFFF0000008000007C00003F800007FFFFFF000000
      800000780001FF800007FFF1FF000000800000780001FFC00006FFC0FF000000
      800000780001FFF80006FF80FF000000800000700000FFFC000EFF007F000000
      800000700000FFFE001EFFC07F000000800000700000FFFF003EFFC07F000000
      800000700000FFFF803E7F81FF0000008000007000007FFFC03F3F81FF000000
      8000007F00003FFFC03F0F03FF000000800000FFC01C1FFFE07F8007FF000000
      8007FFFFFFFE3FFFF0FFE00FFF000000C007FFFFFFFF7FFFF9FFF83FFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFE03F000000800001F07FFFFFFFFFFFFF800F000000
      000001F061FFFFF07FFFFF0007000000000003E0601FFFE007FFFE0003000000
      800003E000183FC0007FFC0001000000C00003E000101F80003F040001000000
      C00001E000001F00003F000001000000C00000E000001E00003E000001000000
      800000E000001E00003E000001000000800000E000001C00003E000001000000
      800001E000001C00003E000001000000800001E000001C00003E000001000000
      C00003E000001C00001F000001000000C00003E000001C00003F000001000000
      E00003E000001C00007F800001000000F00007E000001C0000FF818003000000
      E00007E000001C0001FF81C307000000E00007E000001E0003FF81C38F000000
      E00007E000001F0007FF8183FF000000C0000FE000001F801FFF8183FF000000
      C0001FE000001FC03FFF8183FF000000C0007FE000003FE0FFFF81C3FF000000
      C001FFE001FFFFF3FFFFC3E7FF000000FF87FFF001FFFFFFFFFFC7FFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFE007FFFFFFFFFFFFF000000
      C00FFFF008003FFCFFFFFFFFFF00000080001FE000001FF87FFFFC1FFF000000
      80001FE000000E007FFFC003FF00000080001FE000000E007FFE0001FF000000
      80001FE0000008003C3E0000FF00000080000FE000000800001E00001F000000
      800001E000000800001E00000F000000800000E000000800001FC0000F000000
      800000E000000800000FC0000F000000800000E0000008000007C0000F000000
      800001E000000C000007C0000F000000800001E000000C000007C0000F000000
      800003E000000C000007C0000F000000800003E000001C000007C0000F000000
      800003E000003E000007000003000000800007E00001FE000006000003000000
      800007E00001FF80000700000700000080000FE00001FFC0000780000F000000
      80000FE00003FFC0000780000F00000080000FE00003FFC00007800007000000
      80001FE00007FFC0000700000300000080001FF00007FFC00006003003000000
      C1001FF84207FFE00007F878FF000000E39C7FF8E71FFFFF81FFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFC00FFFFFCFFC3FFFFFFE03FF000000
      FC0001F87FC7FC187FFFF0007F000000F00001F00307F81807FFC0001F000000
      E00001E00003F800060F80000F000000E00001E00001F8000407000007000000
      E00003E0000078000006000003000000F00003E0000038000006000003000000
      F00001E0000018000006000003000000E00001E0000008000006000003000000
      E00001F0000008000006000003000000E00001F0000038000006000003000000
      E00001F0000038000006000003000000C00001F8000078000006000003000000
      C00001FC0700F8000006000003000000800003FC0381F8000007000003000000
      800003F80381F8000007800003000000800003F80301F8000007C00003000000
      800003F80301F8000007F00003000000800001F80301F8000007FE0003000000
      E00000F80301F8000007FFE007000000F000007C0783F800000FFFF00F000000
      F83FF0FE0FC7F8007FFFFFF81F000000FFFFF9FF1FFFFC007FFFFFFC7F000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFF3FFFFEFF7FFFFFFF000000FFFFFFFFF803FFF81C1FC3C03F000000
      FF87FFFF80007FE0000FC00003000000FF83FFFC00007F800007C00003000000
      FE43FFF800007F800007C00003000000FC03FFF800007F800007C00003000000
      FC01FFF80000FF800007C00007000000FE00FFFC0000F1800007C0000F000000
      F8007FFC000070800007C0001F000000C0003FF800007000000780000F000000
      800003F800007800000780000F000000800001F800007C00000780000F000000
      800001F000007E00000F80000F000000800000F000007F00003F80000F000000
      8000006000007F80003F80001F000000800000600000FF80003F80001F000000
      800000600000FF80003F80001F000000C00000600000FF80003F80001F000000
      E00001E00000FF80003F80001F000000F00001F000007F80007F80001F000000
      FF0003F000003F8001FF80001F000000FF80FFF800001FC007FF80001F000000
      FF80FFFC01FC3FE05FFFFE003F000000FFC1FFFF07FE7FF0FFFFFF07FF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFFFFF807FF000000FFFFFFFFFFFFFFFFFFFFF0007F000000
      FFFFFFFFF0FFFF81FFFFE00007000000FC3FFFFF001FFF003FFFC00003000000
      FC01FFF8000FFE000FFFC00001000000F8000FF80003FE0001FE000001000000
      F80007F800007E00007E000001000000F80007FE00001E00003E000003000000
      F0000FFF00003E00003E000003000000F0000FFF00003E00003E000007000000
      F00007FE00007E00003E00000F000000F00007FE00007E00003E00003F000000
      E00003FC0000FE00003E0000FF000000C00003FC0000FE00003E0001FF000000
      800001FC0001FE00003E0003FF000000800000F80001FE00003E0007FF000000
      800000F80001FE00003E0007FF000000800004780001FE00003E0007FF000000
      80000EF00003FE00003E0007FF00000080000FF00003FE00003E0007FF000000
      80001FF0000FFF00003E0007FF00000080003FF0001FFFC0003E0007FF000000
      C001FFF0007FFFFF03FE000FFF000000F003FFFFC0FFFFFFFFFE001FFF000000
      FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
      000000000000}
  end
  object quAccess: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Password'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end
      item
        Name = 'MenuID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'SubMenuID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT UR.CanAccess'
      ''
      'FROM SystemUser SU '
      'JOIN UserType UT ON ( SU.UserTypeID = UT.IDUserType )'
      'JOIN UserRights UR ON  ( UR.UserTypeID = UT.IDUserType )'
      ''
      'WHERE ( SU.PW = :Password ) '
      'AND   ( UR.MenuID = :MenuID ) '
      'AND   ( UR.SubMenuID = :SubMenuID )'
      'AND   ( SU.Desativado = 0 )'
      ' ')
    Left = 331
    Top = 14
    object quAccessCanAccess: TBooleanField
      FieldName = 'CanAccess'
    end
  end
  object strepPredefined: TcxStyleRepository
    Left = 268
    Top = 23
  end
  object imgBTN: TImageList
    BkColor = clFuchsia
    Height = 22
    Width = 20
    Left = 696
    Top = 69
    Bitmap = {
      494C010117001800040014001600FF00FF00FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000005000000084000000010020000000000000A5
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000039FF000842E700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FDFDFD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF001829E7000029DE00FF00FF00FF00FF00C69C8400C69C8400C69C8400C69C
      8400C69C8400C69C8400C69C84000039FF000031DE000031DE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0031638400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF000031DE000031DE000031DE00C69C8400FFFFEF00FFFFDE00FFF7D600FFF7
      CE00FFF7D600FFE7C6000039FF000031DE000031DE00C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00399CEF0052B5F70052BDFF00107B
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4A40094A4A40094A4
      A400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF002921E7000031DE000829E700FFFFEF00FFFFEF00FFEFDE00FFEF
      D600FFE7CE000039FF000829DE000031DE00FFEFC600C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00429CEF00E7947300FF9473008C94
      AD005ABDFF004A94BD00085A8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0094A4A40094A4A4006FA2A2006FA2A2006FA2
      A20094A4A400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00C69C84001829E7000031DE000029DE00FFFFF700FFF7EF00FFEF
      DE000039FF000031DE000031DE00FFEFC600FFEFC600C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00429CEF00E79C7B00E7D6DE00FFF7
      EF00FFEFE700A55242005A849C004A9CCE00085A8400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0094A4A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A20094A4A40094A4A400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00C69C8400FFFFDE002931EF000031DE001829DE00FFFFEF000039
      FF001829E7000031DE00FFEFC600FFE7CE00FFEFC600C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0042A5EF00E79C8400DED6E7001831
      D600FFEFDE00BDA59400B5B5AD00B594840052CEFF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0094A4A40094A4A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A2006FA2A20094A4A400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00C69C8400FFFFEF00FFF7EF003163F7000029E7002129EF002129
      E7000031D600FFEFC600FFEFD600FFE7CE00FFF7D600C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004AA5EF00E7A58C001829BD001021
      C600FFD6BD0010181800ADD6EF00F7DECE0052CEFF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0094A4A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A2006FA2A2006FA2A200FF00FF00FF00FF0094A4A40094A4A400FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00C69C8400FFFFF700FFF7EF00FFFFEF00216BEF000029DE000031
      F7005A42FF00FFF7EF00FFEFDE00FFEFD600FFF7D600C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004AA5EF00E7AD8C00FFFFFF00FFFF
      FF00FFEFE70073BDFF00FF8C5A00D64A290052C6FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4
      A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A2006FA2A2006FA2A200FBFBFB00BFC9C9006FA2A2006FA2A20094A4A400FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400C69C
      8400C69C8400C69C8400FFFFF700FFFFF7008410EF000031EF000031EF00004A
      EF000052EF005A42FF00FFFFF700FFDED600FFBDB500C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004AADF700E7AD9400B5D6B5006BCE
      7300FFFFF7009C94A500FF946B00EF845A00E74A2100FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4
      A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A2006FA2A20094A4A400FCFDFD0096BCBC006FA2A2006FA2A2006FA2A200FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      DE00FFF7D600C69C8400FFFFFF008C10FF000031F7000031E7000039FF00FFFF
      FF004A18FF000052FF005A42FF00CE8C5A00BD8C2900C69C8400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004AADF700EFB59C00FFFFFF007BCE
      8400FFF7F700F79C7B00FFB58C00FF946B00DE523100BD523100FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4
      A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A20094A4A40094A4A400FF00FF009CABAB006FA2A2006FA2A2006FA2A200FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      EF00FFEFDE00C69C84009410FF000039F7000039FF000039FF00FFFFFF00FFFF
      FF00FFFFFF004221FF000063FF005A42FF00DE94A500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF004AADF700EFB59C00FFFFFF00FFFF
      FF00E7E7DE00FFF7F700FFDEB500FF8C6B00FF9C7B00D64A2900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BCBC
      BC006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2A2006FA2
      A20094A4A400FF00FF00FF00FF00FF00FF0094A4A4006FA2A2006FA2A200FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      F700FFF7EF00C69C84000039FF000039FF009410FF00EFD6AD00E7C6A500E7C6
      A500E7BDA500E7BDA5005A42FF00005AFF005A42FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052ADF700EFBDA500FFFFFF008CC6
      9400FFFFFF00FFF7F700EFB59C00FFD6AD00FF946B00DE7B63009CA5B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0094A4A40094A4A4006FA2A2006FA2A2006FA2A2006FA2A2006FA2A20094A4
      A40094A4A40094A4A40094A4A400FF00FF00FF00FF0097A0A800BDC1C100FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      F700FFF7EF000039FF000039FF009410FF00FFFFFF00FFFFFF00FFFFF700D6B5
      AD00CE8C5A00BD8C2900BD8C2900634AFF006318FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052B5F700EFC6A500FFFFFF0021CE
      5200FFE7D600FFA58400FFF7EF00EF9C7B00FFB58C009494BD00214AFF001829
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4A40094A4
      A400FF00FF0094A4A40094A4A4006FA2A2006FA2A20094A4A40094A4A400FF00
      FF006FA2A2006FA2A20094A4A40094A4A400FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      FF00EFD6AD000039FF008418FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6BD
      B500FFDE9400DE94A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0052B5F700EFC6AD00FFFFFF00FFFF
      FF00DEE7DE00FFFFFF00FFF7F700FFFFFF00DEC6AD006B8CFF00426BFF000039
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4A4006FA2A2006FA2
      A20094A4A400FF00FF00FF00FF00FF00FF00FBFBFB00FF00FF00FF00FF00FF00
      FF006FA2A2006FA2A2006FA2A2006FA2A200EBEBEB00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      FF00EFD6AD00EFD6AD00EFD6AD00E7C6A500E7C6A500E7BDA500DEBDA500C69C
      8400EF849C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0073D6FF007B9CC600E7E7E700BDBD
      BD00C6BDBD00FFFFFF00FFFFFF00FFFFFF0063B5D60094ADFF00315AFF003163
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006FA2A2006FA2A2006FA2
      A20094A4A400E1E1E100FF00FF0094A4A40094A4A40094A4A400E1E1E100FF00
      FF006FA2A2006FA2A2006FA2A2006FA2A20094A4A400FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFF700FFDED600FFBDB500C69C
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00297BA5004AB5EF00DED6D600CECE
      CE00D6D6D600F7F7F700B5B5AD00F7F7F70039ADF7008C8CD6007B94FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006FA2A2006FA2A2006FA2
      A2006FA2A20094A4A400FF00FF006FA2A2006FA2A2006FA2A20094A4A400FF00
      FF0094A4A4006FA2A2006FA2A2006FA2A20094A4A400FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700D6B5AD00CE8C5A00BD8C2900C69C
      8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CB5CE00CEBD
      B500B5B5B500C6C6C600D6D6D600C6947B0031A5F700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0094A4A4006FA2A2006FA2
      A20094A4A40094A4A40094A4A4006FA2A2006FA2A2006FA2A2006FA2A200FF00
      FF00FF00FF0094A4A40094A4A4006FA2A200FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6BDB500FFDE9400DE94A500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5
      B500E7E7E700ADA5A50042738C0042A5F70010639C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EBEBEB006FA2A2006FA2
      A20094A4A400FF00FF00FF00FF006FA2A2006FA2A2006FA2A2006FA2A200FF00
      FF00FF00FF00FF00FF0094A4A40094A4A400FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00C69C8400EFD6
      AD00E7C6A500E7C6A500E7BDA500DEBDA500C69C8400EF849C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F9F9
      F900FF00FF00FF00FF00FF00FF0094A4A4006FA2A2006FA2A20094A4A400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C4C4C40094A4A40094A4A40094A4A400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0039733900316B3100316B310039734200FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0094635A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A008C5A5A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0073A57300189C1800108C100018941800219C2100188C18000873
      0800106B100021632900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A6B
      7300314A5A006B6B7300FF00FF00FF00FF00FF00FF0073737300636363005A5A
      5A006363630063636300736B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00E7C6A500C69C8400C69C8400C69C8400C69C8400C69C8400C69C8400C69C
      8400C69C8400E7C6A500FF00FF00FF00FF0094635A00EFE7DE00F7EFDE00F7E7
      D600F7E7D600EFE7CE00EFE7C600EFDEC600EFDEBD00EFDEBD00EFD6B500E7D6
      AD00E7D6AD00E7D6AD00E7CEA5008C2900008C422900FF00FF00FF00FF00FF00
      FF00FF00FF00398C420021AD2100108C100029AD290039B5390042B542001894
      180031AD390029A5310010631000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001884
      B500107BBD00FFDEC600DECEBD00BDBDAD004A4A4A005A5A6300736B6B007B73
      7B006B6363003931390039393900C6C6C600B5B5B50063635A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00C69C8400FFFFDE00FFF7D600FFF7CE00FFF7D600FFE7C600FFEFBD00FFE7
      AD00FFFFB500C69C8400FF00FF00FF00FF009C6B5A00E7E7DE00F7EFE700F7EF
      DE00F7E7D600F7E7D600EFE7CE00EFE7CE00EFE7C600EFDEC600943910009C42
      18009C4218009C4218009C4218008C290000B5420000FF00FF00FF00FF00FF00
      FF00FF00FF00318C390042B54200218C21004ABD520052C652005ACE5A00218C
      21005AC65A0052C65200299C2900299C29004A52180073423100FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00188C
      C600107BC600FFE7C600FFDEBD00FFDEBD004A4A52006B6363007B737B008484
      8400949494004A4A4A00737373008C8484008C8C8C006B6B6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00C69C8400FFFFEF00FFEFDE00FFEFD600FFE7CE00FFE7CE00FFDEBD00FFDE
      BD00FFEFAD00C69C8400FF00FF00FF00FF009C6B5A00E7E7DE00F7EFE700F7EF
      DE00F7E7D600F7E7D600EFE7CE00EFE7CE00EFE7C600EFDEC600943910009C42
      18009C4218009C4218009C4218008C290000B5420000FF00FF00FF00FF00FF00
      FF00FF00FF00398C39004ABD4A0042AD420063C6630063CE63006BCE6B00218C
      21006BCE6B0063CE630039A5390031A531007B6B2900AD5A3900DE7B5200C66B
      42009452310094523900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00188C
      BD002184C600FFE7C600FFE7C600FFDEBD005A5252006B6B6B00847B7B008484
      8400DED6D600635A6300C6BDBD008C8C8C007B7B7B0063636300FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7C6A500C69C8400C69C
      8400C69C8400FFFFF700FFF7EF00FFEFDE00FFEFD600FFE7CE00FFE7CE00FFDE
      BD00FFEFC600C69C8400FF00FF00FF00FF00A56B6300EFEFE700F7F7EF00F7EF
      E700F7EFDE00F7EFDE00F7E7D600F7E7D600EFE7CE00EFE7C600CE520000D65A
      0000C64A0000BD4A0000BD4A0000BD4A0000BD4A00008C290800946352007342
      4200FF00FF004A944A005AC65A0063CE630073CE730073D673004AAD4A00317B
      21006BC66B0073D673004AB54A00319C3100846B2900C6734A00E78C6300CE7B
      5200C6734A00E78C5A008C4A3100FF00FF00FF00FF00FF00FF00FF00FF002194
      C600187BC600FFE7CE00FFE7CE00FFDEC600BDA58C005A5A52007B7B8400736B
      6B00A5ADAD004A525200BDB5AD008C9494007B7B7B005A5A5A00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C8400FFFFDE00FFF7
      D600C69C8400FFFFF700FFFFF700FFF7EF00FFEFDE00FFEFD600FFE7CE00FFE7
      CE00FFEFC600C69C8400FF00FF00FF00FF00A5736300F7EFEF00FFF7F700F7F7
      E700F7EFDE00F7EFDE00F7E7D600F7E7D600EFE7CE00EFE7C600DE6B0000F773
      0000DE6B0000CE520000BD4A0000BD4A0000BD4A00008C210000C68C63007342
      4200FF00FF007BAD7B0063CE630073D66B007BD67B0084DE840052944200CECE
      A500429C420084DE84006BCE6B00298C29009C6B3900CE7B5A00E79C7300BD73
      5200D6846300EF946B00DE845A00FF00FF00FF00FF00FF00FF00FF00FF002194
      C600187BC600FFE7D600FFE7CE00FFE7C600FFDEBD00BDA594004A4242003963
      7B00187BCE00297BBD006394BD007373730063636300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C8400FFFFEF00FFEF
      DE00C69C8400FFFFFF00FFFFEF00FFFFF700FFF7EF00FFEFDE00FFEFD600FFE7
      CE00FFF7D600C69C8400FF00FF00FF00FF00AD7B6300F7F7F700FFFFFF00FFF7
      F700848484008484840084848400848484008484840084848400944221009C42
      21009C4221009C4221009C42180084290000B5420000D6AD8400E7D6AD007342
      4200FF00FF00FF00FF006BD66B007BD67B008CDE8C008CDE8C00DEDEC600FFEF
      DE004A9442008CDE8C0073D67300397B1800D68C6300E7947300F7A58400A563
      4A00DE8C6B00EF9C7B00E78C6300FF00FF00FF00FF00FF00FF0063848C002994
      D6002184C600FFEFDE00FFEFDE00FFEFD600BDAD9C003973A500319CFF0039A5
      FF0042A5FF0042A5FF0039ADFF0031639C0073737300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C8400FFFFF700FFF7
      EF00C69C8400FFFFFF00FFFFFF00FFFFEF00FFFFEF00FFF7EF00FFEFDE00FFEF
      D600FFF7D600C69C8400FF00FF00FF00FF00B5846B00F7F7F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00F7EFDE00F7EFDE00F7E7
      D600EFE7CE00EFE7C600EFDEC6009431080094310800EFD6B500EFD6B5007342
      4200FF00FF00FF00FF006BCE6B0084DE840094E794005AAD5A00FFFFF700FFFF
      F70073AD6B0084D6840052AD52007B7B3900EF9C7B00F7A58400D69473009C73
      6B00AD735200F7AD8400D6846300FF00FF00FF00FF00FF00FF0063849C002994
      DE002984C600FFEFE700FFEFDE00FFEFDE0084848400398CD60042ADFF0042AD
      FF004AB5FF004AADFF0042ADFF003984BD006B636B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7C6A500C69C8400C69C8400C69C8400FFFFF700FFFF
      F700C69C8400FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFF700FFDE
      D600FFBDB500C69C8400FF00FF00FF00FF00BD846B00FFFFFF00FFFFFF00FFFF
      FF00848484008484840084848400848484008484840084848400DEDED600F7E7
      D600F7E7D600EFE7CE00EFE7CE0094310800E7CEB500EFDEBD00EFD6B5007342
      4200FF00FF00FF00FF0042A542008CDE8C0073C673006BA55A00FFF7EF00FFF7
      F7008CB5840084CE840021731800C6845A00F7A58400F7AD8C00A5735A00D6CE
      CE00A57B6B00F7AD8C00AD6B4A00FF00FF00FF00FF00FF00FF005A8494002994
      DE00217BBD00FFF7E700FFEFE700FFEFDE00636B7300429CEF004AADFF004AB5
      FF0052BDFF0052B5FF0052B5FF003984BD00736B7300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFDE00FFF7D600C69C8400FFFFFF00FFFF
      EF00C69C8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700D6B5AD00CE8C
      5A00BD8C2900C69C8400FF00FF00FF00FF00C68C6B00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00F7F7EF00F7EFE700F7EF
      DE00F7EFDE00F7EFDE00EFE7CE007B4A4A00EFE7C600EFDEBD00EFDEBD007B42
      4200FF00FF00FF00FF00FF00FF008CB59400106B7B00107BC600187BCE001073
      BD0018736300397B3900FF00FF00FF00FF00D68C6B00C68C6B00CED6DE00DEDE
      E700C6ADA500DEA58400FF00FF00FF00FF00FF00FF00FF00FF00527B8C00319C
      E7003184C600FFF7EF00FFF7E700FFEFE700636B73004AA5E70052B5FF0052BD
      FF0052B5FF0052BDFF005ABDFF00428CBD007B7B8400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFEF00FFEFDE00C69C8400FFFFFF00FFFF
      FF00C69C8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6BDB500FFDE
      9400EF849C00FF00FF00FF00FF00FF00FF00CE946B00FFFFFF00FFFFFF00D6AD
      9C00EFDED600FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700F7F7E700F7EF
      E7005A6B8400214A9C00DED6D6007B4A4A00F7E7D600EFE7C600EFDEC6007B4A
      4A00FF00FF00FF00FF00FF00FF005294BD001884DE002994EF002994F7002994
      F700107BC6004A6B8400FF00FF00FF00FF00C6AD9C005A525A002973A500317B
      AD0063737B0094635200FF00FF00FF00FF00FF00FF00FF00FF005A849C00319C
      E7004294CE00FFF7EF00FFF7EF00FFF7E700737B840052A5E7005AC6FF005ABD
      FF006BCEFF0073DEFF006BD6FF004A739C009C9C9C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFF700FFF7EF00C69C8400FFFFFF00FFFF
      FF00C69C8400EFD6AD00E7C6A500E7C6A500E7BDA500DEBDA500C69C8400EF84
      9C00FF00FF00FF00FF00FF00FF00FF00FF00D6947300FFFFFF00FFFFFF008C21
      0000DEBDAD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00F7F7
      EF005A73AD003184F700DED6D6007B4A4A00F7E7D600EFE7CE00EFE7CE007B4A
      4A00FF00FF00FF00FF00FF00FF00187BC600319CFF00319CFF0039A5FF0039A5
      FF00319CFF0018639C00FF00FF00FF00FF00FF00FF00397BAD006B9CCE00639C
      CE003984B5005A737B00FF00FF00FF00FF00FF00FF00FF00FF00427B8C00319C
      EF004A94C600FFF7F700FFF7EF00FFF7EF00A5A59C004A8CB5006BCEFF0073DE
      FF0094F7FF0084E7FF0073DEFF004A5A6B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFF700FFFFF700C69C8400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700D6B5AD00CE8C5A00BD8C2900E7C6A500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00D69C7300FFFFFF00B5735200B542
      0000942900009429000094290000942900009429000094290000F7F7EF00F7F7
      EF00F7F7EF00DED6D600DED6D6007B4A4A00E7DECE00EFE7CE00EFE7CE008452
      4A00FF00FF00FF00FF00FF00FF003194EF0039A5FF0042ADFF0042ADFF0042AD
      FF0042A5FF00187BC600FF00FF00FF00FF005A9CBD0073A5DE0073ADDE0073AD
      E70073ADDE00296B9400FF00FF00FF00FF00FF00FF00FF00FF004A8CAD002994
      EF006BADD600FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFF7E700FFEFE700BDB5
      AD00847B7B00948C840039739C009C9C9C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFFF00FFFFEF00C69C8400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D6BDB500FFDE9400EF849C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DE9C73009C390800C64A0000D65A
      0000C64A0000BD4A0000BD4A0000BD4A0000BD4A000094290000D6946B00D694
      6B00D6946B00D6946B00D6946B007B4A4A00E7DED6001852DE00EFE7CE008452
      5200FF00FF00FF00FF005294BD0042ADFF0042ADFF004AB5FF004AB5FF004AB5
      FF004AADFF002184CE00FF00FF00FF00FF004A94C6007BB5E70084B5EF007BB5
      EF0084B5E700317BAD00FF00FF00FF00FF00FF00FF00FF00FF00529CBD003194
      E70042638400B5B5AD00CECEC600D6D6D600F7EFEF00FFF7EF00FFF7EF00FFF7
      E700FFEFDE00EFE7D6004A8CBD009C9C9C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFFF00FFFFFF00C69C8400EFD6AD00E7C6
      A500E7C6A500E7BDA500DEBDA500C69C8400EF849C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DE9C73009C390800C64A0000D65A
      0000C64A0000BD4A0000BD4A0000BD4A0000BD4A000094290000D6946B00D694
      6B00D6946B00D6946B00D6946B007B4A4A00E7DED6001852DE00EFE7CE008452
      5200FF00FF00FF00FF004A94BD004AADFF004AB5FF0052BDFF0052BDFF0052BD
      FF0052B5FF002184CE00FF00FF00FF00FF00529CCE0084BDEF008CBDF7008CBD
      F70084BDEF003984B500FF00FF00FF00FF00FF00FF00FF00FF005AA5C6003194
      EF004A6B7B00CECEB500BDBDAD00ADAD9C009C9C8C009C948C00ADA5A500CEC6
      BD00F7EFDE00E7DED600428CBD009C9C9400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      EF00FFFFF700FFDED600FFBDB500EF849C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF009C390800E76B
      0000C64A0000B5420000AD420000AD420000AD42000094290000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700FFF7EF00E7E7DE006BADEF00EFE7CE008452
      5200FF00FF00FF00FF005A9CBD004AB5FF0052BDFF005AC6FF0063CEFF005AC6
      FF0052BDFF00217BAD00FF00FF00FF00FF005A9CCE008CBDF70094CEFF0094CE
      FF008CC6F700397BA500FF00FF00FF00FF00FF00FF00FF00FF005AADC6003194
      F700316BA500D6CECE00D6DECE00DEDECE00E7E7CE00EFEFCE00D6DEBD00C6BD
      9C00A59C8400848C8400216BA5009C9C9C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700D6B5AD00CE8C5A00BD8C2900EF849C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C65A
      0800C6947300DEBDAD00DEBDAD00DEBDAD00DEBDAD00E7C6BD00F7F7F700F7F7
      F700F7F7F700F7F7F700EFEFEF00EFEFEF00E7E7E700E7E7E700E7E7E7008C5A
      5200FF00FF00FF00FF00FF00FF00318CBD005AC6F70073DEFF0084EFFF007BDE
      FF00318CBD00FF00FF00FF00FF00FF00FF00FF00FF00529CCE00B5DEF7009CCE
      EF004A94B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BA5B5005AC6
      FF0042A5F7006B7B8C00ADADB500D6D6D600D6D6CE00D6D6CE00D6D6CE00DEDE
      CE00E7E7CE008C949400186BA5009CA5A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6BDB500FFDE9400DE94A500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C42
      2900D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D694
      6B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B008C5A
      5A00FF00FF00FF00FF00FF00FF00FF00FF00318CBD005AC6E70073DEEF003994
      BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BA5C6007BAD
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009C949400EFEFEF00EFE7E700CEC6C600847B
      84008C9C9C007BA5A50073A5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C69C8400EFD6AD00E7C6A500E7C6A500E7BDA500DEBD
      A500C69C8400EF849C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF009C9C9C009C949C00B5B5B500E7E7
      E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00C6C6C6009C9494009C949400FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00397B9C00007BB500007BB500007BB500007B
      B500007BB500007BB500007BB500007BB500007BB500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00CECECE00BDBDBD00DEDEDE00DEDEDE00ADADAD00B5B5B5009C949400BD8C
      8400A58C8400ADADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00188CCE00007BB5000094CE0031B5DE0063D6FF0073DE
      FF0084DEFF0084DEFF0052C6E70031B5DE00007BB500007BB500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008494A500427BA500848C9400CEC6
      C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBD
      BD00CECECE00EFEFEF00EFEFEF00DEDEDE00ADADAD00B5B5B5008C8C8C004A4A
      4A0063636300636363008C8C8C009C949400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00188CCE0029B5FF0063D6FF0073DEFF0084DEFF008CC6
      DE004A4A42004A6B7B004A6B7B006BADC60084DEFF00188CCE00007BB500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0084B5D60042A5F700317BB5007B84
      8C00C6BDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6C6C600EFEF
      EF00F7F7F700EFEFEF00EFEFEF00D6D6D600ADADAD00ADADAD008C8C8C004A4A
      4A00424242006363630063636300848484008C8C8C00ADADAD00C6C6C600FF00
      FF00FF00FF004AB5D60010A5D60052CEFF0073DEFF0084DEFF008CE7FF00ADEF
      FF00848C8C00292929000000080000000800ADEFFF008CE7FF00299CE700007B
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00945A6B008C527300945A6B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00CE8C4200C68C4A00B5844A00739CB500399CEF00317B
      B50084848400A57B5200CE844200CE844200CE844200CE844200CE844200CE84
      4200CE8C4200CE844200FF00FF00FF00FF00FF00FF00BDBDBD00FFFFFF00FFF7
      F700EFEFEF00EFEFEF00E7E7E700D6D6D600ADADAD00ADADAD00ADADAD00ADAD
      AD00ADADAD008C8C8C007373730063636300848484008C8C8C00B5B5B5009C9C
      9C00FF00FF0031B5DE0010A5D60063D6FF0073DEFF008CE7FF00ADEFFF00BDF7
      FF008CA5AD000000080000000800525A5A00BDF7FF008CE7FF0084DEFF00188C
      CE00007BB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00945A6B00945A6B00E78C8C00AD636300523131006B6B6B008484
      8400736384004A397B005A5AB5003131BD001010840063637300FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600DEEFEF00DEEFEF00CEDEE7007BBDEF0042A5
      F700317BB50084849400C6CED600B5BDBD00B5BDC600C6CED600D6E7EF00DEEF
      EF00DEEFEF00D6C6AD00C69C6B00FF00FF00BDBDBD00FFFFFF00FFF7F700EFEF
      EF00EFEFEF00DEDEDE00B5B5B5008C8C8C00848484008C8C8C00ADADAD00ADAD
      AD00ADADAD00B5B5B500BDBDBD00ADADAD009C9C9C006363630052525200CECE
      CE00FF00FF0031B5DE0010A5D60063D6FF0084DEFF008CE7FF00ADEFFF00BDF7
      FF009CB5BD0000000800000008008CA5AD00BDF7FF00ADEFFF008CE7FF0052C6
      E700007BB500397B9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008C527300CE847B00F79C9400FF9C9C00B56B6B005A292900522929003131
      52004A4A9C00635ACE006363CE003131BD000000A50010107B006B6B7B00FF00
      FF00FF00FF00B58C5A00DED6C600DEEFEF00DEEFEF00CEDEE7007BBDEF0042A5
      F700317BB50084849400C6CED600B5BDBD00B5BDC600C6CED600D6E7EF00DEEF
      EF00DEEFEF00D6C6AD00C69C6B00FF00FF00ADADAD00FFFFFF00EFEFEF00DEDE
      DE009C9C9C009C9C9C00BDBDBD00C6C6C6009C9C9C008C8C8C00848484008484
      84008C8C8C009C9C9C00B5B5B500BDBDBD00BDBDBD00C6C6C600BDBDBD00C6C6
      C600FF00FF0031B5DE0010A5D60063D6FF0084DEFF008CE7FF00BDF7FF00BDF7
      FF00848C8C000000080000000800C6E7F700BDF7FF00ADEFFF008CE7FF0063D6
      FF00007BB500007BB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF009C4A6B00FF9C9C00FF9C9C00FF9C9C00B56B6B0063313100522121002121
      52005A5AC6006363CE006363CE003131BD000000A5000000A50021217300FF00
      FF00FF00FF00B58C5A00DED6C600CEDEE700C6D6D600C6D6D600ADC6D6006BB5
      E70052A5DE0073849400B5A59C00BDB5A500C6BDAD00B5A5A500A5A5A500B5C6
      CE00D6DEE700D6C6AD00C69C6B00FF00FF00ADADAD00F7F7F7009C9494009C9C
      9C00D6D6D600DEDEDE00D6D6D600D6D6D600CECECE00BDBDBD00ADADAD00ADAD
      AD009C9C9C008C8C8C00848484008C8C8C009C9C9C00BDBDBD008CBD8C008CBD
      8C00FF00FF0031B5DE0010A5D60063D6FF0073DEFF008CE7FF00ADEFFF00BDF7
      FF00737373000000080000000800394A5A00BDF7FF00ADEFFF0084DEFF0073DE
      FF000094CE00188CCE00FF00FF00FF00FF0084A5C600ADA5B500FF00FF00FF00
      FF009C4A6B00FF9C9C00FF9C9C00FFA5A500B56B6B005A2929004A1010001810
      42003939A5005A5AC6006B6BD6003939C6000000A5000000A50021217B00FF00
      FF00FF00FF00B58C5A00DED6C600DEEFEF00DEEFEF00DEEFEF00DEEFEF00CEDE
      EF00B5CED600B5A5A500F7EFCE00F7F7DE00F7F7E700F7F7E700CEC6BD00A5A5
      A500D6E7E700D6C6AD00C6946B00FF00FF009C9C9C008C8C8C00DEDEDE00DEDE
      DE00DEDEDE00D6D6D600CECECE00EFEFEF00E7E7E700E7E7E700EFEFEF00DEDE
      DE00CECECE00BDBDBD00ADADAD00ADADAD009C94940084848400848484009C94
      9400FF00FF0031B5DE0010A5D60063D6FF0063D6FF008CE7FF008CE7FF00BDF7
      FF00848C8C00292929000000080000000800BDF7FF008CE7FF0084DEFF0063D6
      FF000094CE00188CCE00FF00FF00FF00FF0084A5C6007384BD00ADA5B500FF00
      FF009C4A6B00FFA59C00FFB5B500FFCECE00D6A5A50063293100420808000821
      3900084A84004252A5008C8CDE007373DE000808AD000000A50021217B00FF00
      FF00FF00FF00B58C5A00DED6C600D6E7E700CEDEDE00CEDEDE00CEDEDE00CEDE
      DE00BDC6CE00CEBDAD00EFEFCE00EFF7DE00EFF7E700EFF7EF00EFEFEF00B5A5
      9C00BDC6CE00D6C6AD00C6946B00FF00FF008C8C8C00EFEFEF00DEDEDE00DEDE
      DE00D6D6D600CECECE00E7E7E700DEDEDE00B5B5B500BDBDBD00BDBDBD00BDBD
      BD00CECECE00E7E7E700E7E7E700D6D6D600C6C6C600BDBDBD00BDBDBD00ADAD
      AD00FF00FF0031B5DE000094CE0039C6FF0063D6FF0073DEFF008CE7FF008CE7
      FF009CD6E700394A5A00292929005A8CA5008CE7FF0084DEFF0073DEFF0063D6
      FF00299CE7000094CE00FF00FF00FF00FF00A594FF005AADF7006B84BD00ADA5
      B5009C7B7B00FFCECE00FFDEDE00FFCECE00DEB5B5005A5A6300184A630000B5
      DE0000B5F7000873BD004252A5007373DE005A5AD6000808AD0021218400FF00
      FF00FF00FF00B58C5A00DED6C600D6E7EF00CEDEE700CEDEE700CEDEE700CEDE
      E700BDBDBD00E7D6C600EFEFCE00EFF7DE00EFF7E700EFF7EF00EFF7E700D6CE
      BD00ADADAD00D6C6A500C6946B00FF00FF008C8C8C00E7E7E700DEDEDE00D6D6
      D600CECECE00DEDEDE00E7E7E700C6C6C600EFEFEF00EFEFEF00EFEFEF00CECE
      CE00BDBDBD00BDBDBD00BDBDBD00BDBDBD00D6D6D600E7E7E700DEDEDE00D6D6
      D600FF00FF007BCEE7000094CE0010A5D60031B5DE0039C6FF0052C6E7008CE7
      FF008CE7FF008CE7FF008CE7FF008CE7FF0084DEFF0073DEFF0063D6FF0039C6
      FF0010A5D6000094CE00FF00FF00FF00FF00FF00FF00A59CFF00529CEF006B84
      BD00BDA5AD00FFD6D600FFCECE00E7B5B50052737B0000ADD60000C6F70000CE
      FF0000B5FF00009CFF00086BBD004252A5006B63D6004242BD0021218400FF00
      FF00FF00FF00B58C5A00DED6C600D6E7EF00D6E7EF00D6E7EF00D6E7EF00D6E7
      E700C6BDBD00EFE7CE00EFEFCE00EFF7D600F7F7DE00F7F7E700EFF7DE00DED6
      C600ADADAD00D6C6A500C6946B00FF00FF00FF00FF00D6D6D600D6D6D600CECE
      CE00DEDEDE00CECECE00C6C6C600F7F7F700F7F7F700EFEFEF00EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00DEDEDE00C6C6C600BDBDBD00BDBDBD00BDBDBD00CECE
      CE00FF00FF00FF00FF008CD6EF0031B5DE0010A5D60010A5D6000094CE000094
      CE0010A5D60010A5D60031B5DE0031B5DE0039C6FF0039C6FF0039C6FF0039C6
      FF0010A5D600188CCE00FF00FF00FF00FF00FF00FF00FF00FF00AD94FF005AAD
      EF007B8CAD009C848400E7B5AD00D6B5AD007BA5A50042C6E70010CEFF0000CE
      FF0000B5FF00009CFF00009CFF00085A9C004A4A8C0073399C00FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600D6DEE700C6D6DE00C6D6DE00C6D6DE00C6D6
      DE00BDBDBD00E7DEC600EFDEBD00EFE7C600EFEFCE00EFEFD600EFEFCE00D6C6
      AD00BDBDBD00D6C6AD00C6946B00FF00FF00FF00FF00FF00FF00ADADAD00BDBD
      BD00C6C6C600D6D6D600C6C6C600CECECE00E7E7E700F7F7F700EFEFEF00EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7E700D6D6D600ADADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00C6EFFF008CE7FF008CE7FF008CE7FF0073DE
      FF0063D6FF0052C6E70031B5DE0031B5DE000094CE000094CE000094CE000094
      CE000094CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AD94
      FF00C6A5BD00C6AD9400E7D6AD00F7EFC600F7EFD600D6D6D6008CBDCE0000CE
      FF0000B5FF00009CFF00009CFF0008639C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600DEE7EF00D6E7EF00D6E7EF00D6E7EF00D6E7
      EF00CED6DE00D6CEBD00F7EFDE00F7E7C600F7E7C600F7E7CE00EFE7CE00C6B5
      A500CED6DE00D6C6AD00C6946B00FF00FF00FF00FF00FF00FF00FF00FF00ADAD
      AD00E7E7E700E7E7E700ADADAD00B5B5B500BDBDBD00BDBDBD00C6C6C600CECE
      CE00DEDEDE00E7E7E700E7E7E700EFEFEF00CECECE00B5B5B500FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00ADEFFF0029B5FF004AB5D60073DEFF0073DE
      FF0084DEFF008CE7FF008CE7FF008CE7FF008CE7FF0052C6E70010A5D60031B5
      DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFADC600F7DEB500FFF7C600FFFFDE00FFFFF700FFFFFF00E7D6CE006BD6
      E70039E7FF0000ADFF00009CFF00186BA500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600D6DEE700C6D6DE00C6D6DE00C6D6DE00C6D6
      DE00C6D6D600BDBDC600EFE7D600EFE7C600EFE7C600E7DEBD00CEBDAD00B5BD
      BD00D6DEE700D6C6AD00C6946B00FF00FF00FF00FF00FF00FF00FF00FF00ADAD
      AD00FFFFF700FFF7E700EFDECE00D6D6D600C6C6C600C6C6C600BDBDBD00C6C6
      C600BDBDBD00BDADA500BDADA500B5B5B500DEDEDE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF009CDEFF0029B5FF0029B5FF00292929006363
      6B00FF00FF00FF00FF00FF00FF00A5D6EF0084CEFF0073CEFF000094CE00397B
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFADBD00FFE7B500FFEFC600FFFFDE00FFFFF700FFFFF700FFF7D60063C6
      C60000FFFF0000DEFF0000ADFF001873A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600DEE7EF00D6E7EF00D6E7EF00D6E7EF00D6E7
      EF00D6E7EF00D6E7EF00C6BDBD00D6C6B500DECEBD00CEC6BD00CED6DE00D6E7
      EF00DEE7EF00D6C6AD00C6946B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00CE9C8400FFD6AD00FFD6AD00FFD6AD00FFDEBD00FFDEBD00FFEFD600F7E7
      D600EFE7DE00CEADAD00DEDEDE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008CE7FF0018A5FF0029B5FF00292929006363
      6B00FF00FF00FF00FF00FF00FF00FF00FF00A5D6EF0063CEFF000094CE00397B
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFB5BD00FFEFBD00FFEFBD00FFFFCE00FFFFDE00FFFFDE00FFFFCE0063C6
      C60000FFFF0000FFFF0000D6F7002173A500FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600D6DEE700C6D6DE00C6D6DE00C6D6DE00C6D6
      DE00C6D6DE00C6D6DE00C6D6D600BDCECE00BDCED600C6D6D600C6D6DE00C6D6
      DE00D6E7E700D6C6AD00C6946B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00D6AD9400FFDEBD00FFD6AD00FFDEBD00FFD6AD00FFDEBD00FFD6AD00FFDE
      BD00F7D6A500BD9C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00C6EFFF0029B5FF00089CFF00000008002929
      2900848C8C00FF00FF00FF00FF00FF00FF00A5D6EF0063D6FF000094CE00397B
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFB5C600FFEFDE00FFEFCE00FFEFBD00FFEFBD00FFF7C600F7DEB5005ACE
      CE0000EFEF0010C6C600526BA500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B58C5A00DED6C600D6DEE700C6D6DE00C6D6DE00C6D6DE00C6D6
      DE00C6D6DE00C6D6DE00C6D6D600BDCECE00BDCED600C6D6D600C6D6DE00C6D6
      DE00D6E7E700D6C6AD00C6946B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FFD6B500FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFDE
      BD00D6B5AD00BD9C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008CD6FF00007BB500000008000000
      0800525A5A00FF00FF00FF00FF00FF00FF008CC6DE0073CEFF000094CE00397B
      9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFD6DE00FFF7E700FFEFBD00FFEFBD00F7D6B500B57B7B0018B5
      BD00428C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B58C5A00D6CEBD00DEDEDE00D6DEDE00D6DEDE00D6DEDE00D6DE
      DE00D6DEDE00D6DEDE00D6DEDE00D6DEDE00D6DEDE00D6DEDE00D6DEDE00D6DE
      DE00DEDEDE00D6BD9C00C69C7300FF00FF00FF00FF00FF00FF00FF00FF00DEC6
      B500FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00BD9C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C6EFFF005A8CA500000008000000
      08002929290073737300FF00FF00FF00FF0063CEFF0063CEFF000094CE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7B5BD00E7D6B500E7CEBD00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00BD844A00D68C4200CE8C4A00CE8C4A00CE8C4A00CE8C4A00CE8C
      4A00CE8C4A00CE8C4A00CE8C4A00CE8C4A00CE8C4A00CE8C4A00CE8C4A00CE8C
      4A00CE8C4A00CE843100C69C6B00FF00FF00FF00FF00FF00FF00FF00FF00BD9C
      9400FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600EFDE
      CE00BD9C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADEFFF006BADC600394A
      5A00000008004A4A42005A8CA50073BDE7008CD6FF0031B5DE00188CCE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00BD8C5200EF8C2100E77B1000DE731000DE731000DE731000DE73
      1000DE731000DE731000DE731000DE731000DE731000DE731000DE731000DE73
      1000D66B0800CE630000C69C7300FF00FF00FF00FF00FF00FF00FF00FF00DED6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEF
      EF00BD9C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6EFFF009CDE
      FF008CD6FF008CD6FF008CD6FF008CD6FF0052C6E70010A5D600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00D67B2100D6730800D6730800D6730800D6730800D673
      0800D6730800D6730800D6730800D6730800D6730800D6730800D6730800D673
      0800D66B0800CE731800FF00FF00FF00FF00FF00FF00FF00FF00CEBDB500BD9C
      9400BD9C9400BD9C9400BD9C9400BD9C9400BD9C9400BD9C9400BD9C9400BD9C
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6F7
      FF00C6EFFF00ADEFFF00ADEFFF007BCEE7000094CE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7BDB500F7BDB500F7BDB500F7BDB500F7BDB500F7BDB500F7BD
      B500F7BDB500F7BDB500F7BDB500F7BDB500E7BDB500F7BDB500D6B5AD00F7BD
      B500F7BDB500E7B58C008C5A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00A57B7300DED6CE00FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDE
      BD00FFDEBD00FFDEBD00FFD6AD00FFDEBD00FFD6AD00FFD6AD00FFD6AD00F7D6
      A500FFCE9C00FFCEC6008C5A5A00FF00FF008C948C007BA5B50039A5BD00399C
      B500399CBD00429CBD0042A5BD004AA5BD004AADC6005AADC6005AADC60063BD
      C60063BDC60063BDC60063BDCE0073C6C60073ADB500FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6C6
      BD00EFEFEF00E7E7E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00A57B7300DED6D600FFEFD600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7
      CE00FFDEBD00FFEFB500FFEFB500FFD6AD00FFD6AD00FFD6AD00FFD6AD00FFD6
      AD00F7D6A500FFCEC6008C5A5A00FF00FF00218CBD0084E7EF0010A5D60029B5
      D60039BDDE0042C6DE0039C6DE0039C6DE0042C6DE0042CEE70042CEE7004AD6
      EF004ACEE70052CEE70052D6E70052CEE70063C6D60063737B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD94
      AD00DEDEDE00C6C6C600BD9CB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF009C7BD600FF00FF00FF00FF00FF00FF00FF00FF007BDE
      FF007BDEFF007BDEFF007BDEFF00A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300FF00
      FF00B5847300DED6D600FFEFD600FFEFD600FFEFD600009C0000FFE7CE00FFE7
      CE00C6D694007BAD73008CBD8C00E7D6AD00FFDEBD00FFD6AD00FFD6AD00FFD6
      AD00FFD6AD00FFCEC6008C5A5A00FF00FF00218CBD0073E7EF0018A5CE00299C
      C600299CC600299CCE00299CC600299CC600299CC6002994C600299CC600299C
      C6002994C600299CC600299CC60021947B00299CBD003984B500849CB500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEC6
      C600CECECE00CECECE00BD9CAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00ADE7F70084E7FF00FF00FF00FF00FF00FF00FF009CFFFF007BDE
      FF007BDEFF007BDEFF007BDEFF00A57B7300DEC6B500FFCEC600FFCEC600FFCE
      C600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCE
      C600B5847300DEDEDE00FFF7E700FFEFD600FFEFD600009C00007BCE7B004AAD
      4A00009C0000009C0000009C0000009C00006BA56300FFEFB500FFD6AD00FFD6
      AD00FFD6AD00FFCEC6008C5A5A00FF00FF002194B50084DEEF002194BD00A5EF
      F700BDFFFF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00ADFF
      FF00ADFFFF00ADFFFF00A5F7EF0029A54A005ABD94004A94AD00BDB5BD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDB5
      B500CECECE00CEC6C600C66BB500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007B84CE00A5DEF7005AC6FF00FF00FF00FF00FF0042B5DE009CFFFF0084EF
      FF0084EFFF0084EFFF0084EFFF00A57B7300DECEC600F7EFE700F7EFE700F7EF
      E700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700FFDE
      BD00B5847300DEDEDE00FFF7E700FFF7E700FFEFD600009C0000009C0000009C
      0000009C0000009C0000009C0000009C0000009C00006BA56300FFD6AD00FFD6
      AD00FFD6AD00FFCEC6008C5A5A00FF00FF00218CBD007BDEEF0052ADCE00C6FF
      FF00C6FFFF00C6FFFF00C6FFFF009CEFF70073DEE7006BCEDE0063D6E7006BDE
      EF0094F7FF00ADFFF70039AD520000840000107B18009CADAD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5
      B500ADADAD00C6C6C600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00A5E7F7004AB5F7006BCEF700FF00FF00FF00FF0042B5DE00ADFFFF0084EF
      FF0084EFFF0084EFFF0084EFFF00CE9C8400EFDED600F7EFE700FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00F7EFE700FFDE
      BD00B5847300E7E7E700FFF7EF00FFF7E700FFF7E700009C0000009C0000009C
      0000009C000008A518007BCE7B006BA56300009C0000009C0000C6D69400FFD6
      AD00FFDEBD00FFCEC6008C5A5A00FF00FF001894BD007BE7EF005AADC600D6FF
      FF00CEFFFF00C6F7F700A5CECE00949C9400ADA59400B5A59C00B59C9C00A5B5
      BD0063BDC600299C4A00088C100052B56B000884080094CE9400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6BD
      BD00ADADAD00BDBDBD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF007384
      CE008CD6F70042ADEF0063BDDE00FF00FF00FF00FF0042B5DE00ADFFFF008CF7
      FF0084EFFF008CF7FF0084EFFF00CE9C8400EFDED600F7EFE700F7EFE700F7EF
      E700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700F7EFE700FFDE
      BD00BD8C8400E7E7E700FFF7EF00FFF7EF00FFF7E700009C0000009C0000009C
      0000009C00008CBD8C00FFE7CE00FFE7CE00EFDEB5004AAD4A004AAD4A00FFDE
      BD00FFDEBD00FFD6CE008C5A5A00FF00FF00188CBD007BDEEF005AA5C600DEFF
      FF00D6F7F700ADBDB500A5A59C00D6C69C00E7D6B5009CA5D600EFE7BD00D6C6
      A500BDADA500299C5A006BD6CE00BDFFFF001894310084C68400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5A5
      9C009C9C9400B5B5B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CD6
      F70042ADF7005ABDEF00FF00FF00FF00FF00FF00FF0042B5DE00ADFFFF008CF7
      FF008CF7FF008CF7FF008CF7FF00CE9C8400EFE7DE00FFF7F700FFDEBD00FFDE
      BD00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFDEBD00F7EFE700FFDE
      BD00BD8C8400E7E7E700FFFFEF00FFF7EF00FFF7E700009C0000009C0000009C
      0000009C0000009C0000009C0000FFE7CE00FFE7CE00EFDEB50021A53900FFD6
      AD00FFDEBD00FFCEC6009C6B6300FF00FF00188CBD006BDEEF005AA5C600E7FF
      FF00C6D6CE00ADADAD00E7D6AD00FFF7C600FFF7C600FFEFC600FFF7D600FFFF
      EF00D6CEB500BDADAD0063BDCE00B5FFFF0052ADAD0000840000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDBDC600ADAD
      AD008C8C8400ADA5A500FF00FF00FF00FF00FF00FF00FF00FF006B8CD60073CE
      F700399CDE0063BDE700FF00FF00FF00FF00FF00FF0042B5DE00C6FFFF008CF7
      FF009CFFFF008CF7FF009CFFFF00DEAD8400EFE7DE00FFF7F700FFCE9C00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00FFCE9C00F7EFE700FFDE
      BD00BD8C8400EFEFEF00FFFFEF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFEFD600FFE7CE00FFEFD600FFE7CE00FFE7CE00FFE7CE00EFDE
      B500FFDEBD00FFCEC6009C6B6300FF00FF00188CBD005AD6EF0063A5C600EFF7
      F700BDC6C600DED6AD00FFFFC600FFFFC600FFF7BD00FFEFB500FFEFA500FFEF
      CE00F7F7EF00D6BDAD0084ADB5009CEFF70073ADBD00217321006BB56B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5B5B500ADAD
      AD00638CAD005AA5DE00FF00FF00FF00FF00FF00FF007BCEEF004AB5FF002994
      E7004AADEF00FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00C6FFFF009CFF
      FF009CFFFF009CFFFF009CFFFF00DEAD8400F7EFDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFEF00FFF7EF00FFF7EF00FFF7E700FFEFD600FFE7CE00FFD6
      B500CE9C8400EFEFEF00FFFFFF00FFFFF7007BCE7B00FFF7E700FFF7E700FFF7
      E700FFF7E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFDEBD00FFD6CE009C6B6300FF00FF00108CBD004AD6EF006B9CC600F7F7
      F700BDB5B500EFE7BD00FFFFCE00FFFFCE00FFFFCE00D6C69400EFCEA500F7DE
      A500FFF7E700CECEB500A5ADA5008CEFF7007BB5BD007394730029942900FF00
      FF00FF00FF00FF00FF00C6C6C600BDBDBD00CECECE00CEC6C600B5ADAD009CAD
      BD005ABDF7005AC6FF0052BDFF0073ADE7007B9CDE0073DEFF0039A5FF00218C
      D6005AADEF00FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00D6FFFF009CFF
      FF009CFFFF009CFFFF009CFFFF00E7B58C00F7EFDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFEF00FFF7E700F7E7D600F7BDB500FFA5
      A500CE9C8400EFEFEF00FFFFFF00FFFFF7007BCE7B00BDE7BD00FFF7EF00FFF7
      EF00FFF7E700009C0000009C0000009C0000009C0000009C0000FFE7CE00FFE7
      CE00FFE7CE00FFD6CE009C6B6300FF00FF001084BD0039C6E7006BA5CE00FFFF
      FF00CEC6C600CEDED600EFF7F700FFFFDE00D6D6AD004A524A006B736300E794
      4A00EFCEAD00847BA500A5ADAD0094E7F70084ADBD00BDBDBD002994290084C6
      8400FF00FF00FF00FF00D6D6D600ADADAD00CECECE00F7F7FF00EFEFEF007BB5
      E70073DEFF0039A5FF005AC6FF008CEFFF006BD6FF0063CEFF002994E700319C
      E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00D6FFFF009CFF
      FF00ADFFFF009CFFFF00ADFFFF00EFBD9400FFF7EF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00B5847300E7B58C00DEC6
      B500CE9C8400EFEFEF00FFFFFF00FFFFF700D6E7CE0008A51800BDE7BD00FFF7
      EF00FFF7E700FFEFD60021A53900009C0000009C0000009C0000FFEFD600FFE7
      CE00FFE7CE00FFCEC6009C6B6300FF00FF00107BB50031BDDE006BA5CE00F7F7
      F700CECECE00F7E7CE00FFFFF700FFFFEF00FFFFE700C6CEAD00AD845200FFD6
      AD00FFCE9C00DEAD7B00BD9C6B00C6CEBD0084ADBD00BDBDBD00FF00FF0084C6
      8400FF00FF00FF00FF00DEDEDE00A5A5A500BDBDBD00E7E7E700D6E7F7006BCE
      FF0063CEFF00319CFF0063CEFF008CF7FF0084EFFF005AC6FF001884CE00429C
      F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00D6FFFF00ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00EFBD9400DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400B5847300E7CEBD00FF00
      FF00CE9C8400F7F7F700FFFFFF00FFFFFF00FFFFFF004AAD4A00009C00007BCE
      7B00DEEFCE00DEEFCE004AAD4A00009C0000009C0000009C0000FFEFD600FFEF
      D600FFE7CE00FFCEC600A57B7300FF00FF00107BB50029B5D6006BA5C600FFFF
      FF00E7E7DE00E7D6CE00F7F7F700FFFFFF00FFFFEF00FFFFDE00F7E7AD00DE9C
      5200E7A56300F7CE9C00FFCE9C00F7B57B00AD844A00B5ADB500FF00FF00FF00
      FF00FF00FF00CEBDBD00E7E7E700A5A5A500A5A5A5008C8484006BADD60084E7
      FF0042ADFF00319CFF0042A5DE0094E7F7008CEFFF005AC6FF0031A5FF005A8C
      E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00E7FFFF00C6FF
      FF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FF
      FF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF0094D6F700009CCE00FF00
      FF00DEAD8400F7F7F700FFFFFF00FFFFFF00FFFFFF00DEEFCE00009C0000009C
      0000009C0000009C0000009C0000009C0000009C0000009C0000FFEFD600FFEF
      D600FFEFD600F7BDB500A57B7300FF00FF00087BAD0018A5D6006BA5C600FFFF
      FF00F7EFEF00DEDED600D6CEC600FFF7E700FFFFFF00DEEFFF00FFFFD600EFCE
      A500B5845A00B57B4200DE944A00F7BD8400A59C9400636BAD002942B500FF00
      FF00FF00FF00C6C6C600E7E7E700ADADAD0094949400B5BDC60073D6FF0073DE
      FF00299CFF00319CF7007B848C00738494008CBDCE0084D6FF0039A5FF004AAD
      FF0073A5E700FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00E7FFFF00D6FF
      FF00C6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FF
      FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF0094D6F700009CCE00FF00
      FF00DEAD8400F7F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF0094DEAD00009C
      0000009C0000009C0000009C0000009C000008A51800009C0000FFEFD600F7BD
      B500FFA5A500FFA5A500A57B7300FF00FF000073AD0010A5CE006B9CC600FFFF
      FF00FFFFFF00DEDEDE00DEDEDE00D6CEC600E7D6BD00DED6CE00D6CEB500BDB5
      AD00B5C6B500DED6D600CE8C6300D6844A008C7B7B004252A5002152C600FF00
      FF00FF00FF00CECECE00EFEFEF00B5B5B5009C9C9C006B9CC600B5EFFF00ADDE
      FF00399CFF003194F7006B8CAD00BDA59C00948C8C008CADBD006BB5FF004AB5
      FF005ABDEF00FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00F7FFFF00D6FF
      FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FF
      FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00D6FFFF0094D6F700009CCE00FF00
      FF00DEAD8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEEF
      DE007BCE7B004AAD4A004AAD4A007BCE7B00FFEFD600009C0000E7BDB500D6AD
      9400DEAD8400CE9C8400A57B7300FF00FF000073AD000094CE006BA5C600FFFF
      FF00FFFFFF00FFFFFF00E7DEDE00E7E7E700CED6CE00C6C6BD00C6C6C600D6D6
      D600F7F7EF00FFFFFF00FFFFFF00FFFFFF008CADB5008C7B9400FF00FF00FF00
      FF00FF00FF00CECECE00F7F7F700EFE7EF00C6C6C600A5B5BD008CBDEF00C6DE
      FF00CEE7FF005AADFF005AC6FF007BB5BD00BD9C9C00738494002994EF004AAD
      FF007B94E700FF00FF00FF00FF00FF00FF00FF00FF0042B5DE00F7FFFF00E7FF
      FF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FF
      FF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FFFF0094D6F700009CCE00FF00
      FF00DEAD8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFFFF700FFFFEF00FFFFEF00FFF7EF00FFF7EF00FFF7EF00B5847300B584
      7300B5847300B5847300A57B7300FF00FF00006BAD000094C6006BA5C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084ADBD00BDC6BD00FF00FF00FF00
      FF00FF00FF009C948C00A59C9400BDB5B500D6D6D600E7E7E700E7E7E700ADCE
      EF009CCEFF00D6F7FF008CE7FF008CE7EF00A59C9C00848C9400319CF7004AA5
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0029ADDE009CC6
      DE009CC6DE009CC6DE009CC6DE009CC6DE009CC6DE009CC6DE009CC6DE009CC6
      DE009CC6DE009CC6DE009CC6DE009CC6DE007BCEE700009CCE00FF00FF00FF00
      FF00E7B58C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFEF00B5847300FFB5
      4A00DEAD8400CE9C8400E7D6CE00FF00FF00006BB5000094C600397BAD0073A5
      C60073ADCE0073ADCE0073ADD60073ADCE0073ADCE0073A5CE007BADCE0073A5
      CE0073A5CE0073ADCE0073A5CE007BADCE004A8CA500BDBDC600FF00FF00FF00
      FF00FF00FF00B5A59400CEB5A500FF00FF00FF00FF00FF00FF00B59CA500BDB5
      B500B5BDCE0084BDEF00B5F7FF009CBDC600BD9C9400738CA500319CFF00528C
      F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0042B5
      DE0042B5DE0042B5DE0042B5DE0042B5DE0042B5DE0042B5DE0042B5DE0042B5
      DE0042B5DE0042B5DE0042B5DE0042B5DE004ABDE700FF00FF00FF00FF00FF00
      FF00E7B58C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700B5847300DEAD
      8400CE9C8400EFDECE00FF00FF00FF00FF0000639C00005A9C0021ADCE0039C6
      E70039C6E70039C6E70039C6E70039C6E70039C6E70039C6E70039C6E70039C6
      E70039C6E70039C6E70039C6E70039C6E7005A9CD600BDBDBD00FF00FF00FF00
      FF00FF00FF00C6BDB500DEC6A500BD849C00FF00FF00FF00FF00FF00FF00FF00
      FF00CE9CA5009C8C8400738C9C00BDA59C00A5949C006BBDE700319CFF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00E7B58C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7
      F700FFF7F700F7F7F700EFEFEF00EFEFEF00EFEFEF00EFEFEF00B5847300DEAD
      8400EFDED600FF00FF00FF00FF00FF00FF007BB5DE00188CC600A5E7F700A5F7
      F700ADF7FF00ADF7FF00A5F7FF00A5F7FF00A5F7FF00ADF7FF00A5F7FF00A5F7
      FF00A5FFFF00A5F7F700A5F7FF00BDF7F700D6E7F700EFEFEF00FF00FF00FF00
      FF00FF00FF00FF00FF00C6BDB500CEBDA500CEBDB500CEBDB500C6BDB500C6BD
      B500BDB5B500C6B5B500C6ADA500B57BA5009C94D6008CDEF7005AADEF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00EFBD9400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400B5847300F7E7
      D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C6BDB500C6BDB500C6BDB500C6BD
      B500C6BDB500C6BDB500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B73008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00217B2100005200000073080000730800007308000052
      000000520000215A2900638C6300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C7B8C00CE9C
      9C00CEBDB500FFE7CE00FFE7CE00FFE7CE00FFD6CE00FFE7CE00FFD6CE00FFDE
      BD00FFDEBD00FFDEBD00FFD6B500FFD6B500FFD6B500FFD6B5008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000884180000730800189C290008B5180008B5180008B5180008B5180008B5
      180008B51800009C00000073080000520000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00428CB5005A73AD00AD8C
      A500CEADAD00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDE
      BD00FFDEBD00FFDEBD00FFDEBD00FFD6AD00FFD6AD00FFD6B5008C5A5A00FF00
      FF00FF00FF00D67321009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C31000084848400FF00FF00FF00FF00FF00FF00FFFFFF00FFFFFF000073
      0800189C290010B5310010B5310010B5310010B5310008B5180008B5180008B5
      180008B5180008B5180008B51800009C000000520000FF00FF00FF00FF00FF00
      FF00FF00FF00A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063C6FF003984E7005A73
      AD00AD8CA500D6B5AD00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFD6AD00FFD6B5008C5A5A00FF00
      FF00FF00FF00D6732100FFFFFF00FFE7D600FFF7F700FFFFFF00FFFFFF00FFF7
      EF00FFEFEF00F7EFE700F7EFE700F7EFE700FFEFEF00FFFFFF00FFFFFF009C39
      00009C39000084848400FF00FF00FF00FF00FF00FF00FFFFFF000884180010B5
      310021BD4A0021BD4A0010B5310010B5310010B5310010B5310010B5310008B5
      180008B5180008B5180008B5180008B51800009C000000520000FF00FF00FF00
      FF00FF00FF00A57B7300F7E7D600FFE7CE00FFD6CE00FFD6CE00FFD6B500FFD6
      B500FFD6B500FFD6AD00A57B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF005AB5FF003984
      E7005A73AD00AD8CA500D6B5AD00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFD6B5008C5A5A00FF00
      FF00FF00FF00D6732100FFFFFF00F7D6C600FFEFEF00FFFFFF00FFFFFF00FFF7
      EF00F7EFE700F7EFE700F7EFE700FFEFE700FFEFEF00FFFFFF00FFFFFF00A539
      00009494840084848400FF00FF00FF00FF00FF00FF000884180021A5390021BD
      4A0021BD4A0021BD4A0021BD4A0010B5310042CE7300F7FFF700F7FFF70039C6
      390010B5310008B5180008B5180008B5180008B5180008A5180000520000FF00
      FF00FF00FF00B5847300FFEFD600FFE7CE00FFE7CE00FFDEBD00C6D69400428C
      390000730800007308000884180000730800298C4200FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008C8C8C005AB5
      FF003984E7005A73AD00AD8CA500E7BDB500FFEFD600FFEFD600FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFDEBD00FFD6B5008C5A5A00FF00
      FF00FF00FF00D6732100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00A542
      0800A552180084848400FF00FF00FF00FF00FF00FF00189C290031C66B0031C6
      6B0021BD4A0021BD4A0021BD4A0021BD4A0094DEAD00FFFFFF00FFFFFF00F7FF
      F70031C66B0010B5310008B5180008B5180008B5180008B5180008A518000052
      0000FF00FF00BD8C8400FFEFD600FFEFD600FFE7CE00FFE7CE00428C39007BAD
      73007BAD7300428C390008841800189C290021A5390008841800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5847300CEBD
      B5005AB5FF003984E7005A73AD00BDADA500F7E7D600E7BDB500BD9C9400CEA5
      A500CEADAD00E7BDB500FFDEBD00FFDEBD00FFDEBD00FFCEC6008C5A5A00FF00
      FF00FF00FF00D6732100FFFFFF0084F7F700FFFFFF00FFFFFF00FFFFF700F7EF
      E700F7E7DE00F7E7DE00F7EFE700F7EFE700FFF7EF00FFFFF700FFFFFF00B552
      1000B552100084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B0031C6
      6B0031C66B0031C66B0021BD4A0021BD4A0042CE7300EFFFF700FFFFFF00FFFF
      FF00FFFFFF0039C6390010B5310010B5310008B5180008B5180008B518000073
      0800FF00FF00CE9C8400FFF7EF00FFEFD600FFEFD600FFE7CE00FFE7CE00FFDE
      BD00FFDEBD00FFDEBD00B5847300215A290021BD4A0031C66B0008841800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5847300FFF7
      EF00FFF7EF005AB5FF0084ADCE008C8C8C00BD9C9400DEB5A500FFEFB500FFFF
      D600FFF7C600DEC6B500CE9C9C00E7CEBD00FFDEBD00FFD6B5008C5A5A00FF00
      FF00FF00FF00D6732100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BD5A
      1000A59C7B0084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B0031C6
      6B0031C66B0031C66B0031C66B0021BD4A0021BD4A0042CE7300F7FFF700FFFF
      FF00FFFFFF00EFFFF70031C66B0010B5310010B5310008B5180008B5180008A5
      1800FF00FF00CE9C8400FFF7EF00FFF7E700FFF7E700FFEFD600FFE7CE00FFE7
      CE00FFDEBD00FFDEBD00B5847300FFF7E7000884180042CE730021BD4A00298C
      4200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5847300F7EF
      E700FFF7EF00FFF7EF00DED6D600BD9C9400FFD6AD00FFF7C600FFFFD600FFFF
      E700FFFFE700FFFFFF00F7EFE700BD9C9400EFDEB500FFCEC6009C6B6300FF00
      FF00FF00FF00D6732100FFFFFF00FF000000FFFFFF00FFFFFF00F7EFE700F7DE
      D600F7E7D600F7E7DE00F7EFE700FFF7EF00FFFFFF00FFFFFF00FFFFFF00C663
      1800A5B5940084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B0031C6
      6B0031C66B0031C66B0031C66B0031C66B0031C66B0031C66B0042CE7300F7FF
      F700FFFFFF00FFFFFF00F7FFF70031C66B0010B5310010B5310010B5310008B5
      1800FF00FF00DEAD8400FFFFF700FFF7EF00FFF7E700FFEFD600FFEFD600FFE7
      CE00FFE7CE00FFDEBD00B5847300FFF7E7000884180042CE73005AE784000884
      1800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD8C8400FFF7
      EF00FFFFEF00FFFFEF00D6B5AD00EFCEA500FFF7C600FFEFB500FFFFD600FFFF
      E700FFFFF700FFFFFF00FFFFFF00DED6CE00CEA5A500FFD6CE009C6B6300FF00
      FF00FF00FF00D6732100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE6B
      1800CE6B180084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B005AE7
      8400ADE7BD0094DEAD0094DEAD0094DEAD0094DEAD0094DEAD0094DEAD00ADE7
      BD00FFFFFF00FFFFFF00FFFFFF00F7FFF70031C66B0010B5310010B5310010B5
      3100FF00FF00E7B58C00FFFFFF00FFFFEF00FFF7EF00FFF7E700FFEFD600FFEF
      D600FFE7CE00088418000884180008841800088418005AE784005AE784000884
      18000884180008841800FF00FF00FF00FF00FF00FF00FF00FF00BD8C8400FFF7
      F700FFFFEF00FFFFF700CEADAD00FFEFB500FFEFB500FFF7C600FFFFD600FFFF
      E700FFFFFF00FFFFFF00FFFFEF00FFF7C600BD9C9400FFD6CE009C6B6300FF00
      FF00FF00FF00D673210052CEFF0052CEFF0052CEFF0052CEFF0052CEFF0052CE
      FF0052CEFF0052CEFF0052CEFF0052CEFF0029BDFF004AC6FF00C6EFFF00D673
      1800D673180084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B0094DE
      AD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFF70031C66B0021BD4A0010B5
      3100FF00FF00EFBD9400FFFFFF00FFFFF700FFFFF700FFF7EF00FFF7E700FFEF
      D600FFEFD600F7E7C600217B210021A5390042CE73005AE784005AE784005AE7
      840021A53900217B2100FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFF7
      F700FFFFF700FFFFFF00CEA5A500FFF7C600FFD6AD00FFEFB500FFFFD600FFFF
      D600FFFFE700FFFFE700FFFFE700FFFFD600BD9C9400FFD6CE009C6B6300FF00
      FF00FF00FF00D6732100BDEFFF00BDEFFF00C6EFFF00C6EFFF00C6EFFF00C6EF
      FF00C6EFFF00C6EFFF00C6EFFF00C6EFFF00C6EFFF00FFFFFF00FFFFFF00D67B
      2100ADBD940084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B0094DE
      AD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEF7E70021BD4A0010B5310010B5
      3100FF00FF00EFBD9400FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7EF00FFF7
      E700FFEFD600F7BDB500B58473000073080042CE73005AE784005AE784005AE7
      840008841800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFFF
      FF00FFFFFF00FFFFFF00CEA5A500FFF7C600FFEFB500FFEFB500FFFFD600FFFF
      D600FFFFD600FFFFE700FFFFD600FFF7C600BD9C9400FFD6CE00A57B7300FF00
      FF00FF00FF00D6732100BDF7FF00A5F7FF00EFFFFF00FFFFFF00FFFFFF00F7EF
      E700F7EFE700F7EFDE00FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DE84
      2100D6944A0084848400FF00FF00FF00FF00FF00FF0031C66B0031C66B005AE7
      8400ADE7BD0094DEAD0094DEAD00ADE7BD0094DEAD0094DEAD0094DEAD00DEF7
      E700FFFFFF00FFFFFF00FFFFFF00DEF7E70031C66B0021BD4A0021BD4A0021BD
      4A00FF00FF00EFBD9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      EF00B5847300B5847300B5847300B5A59400088418005AE784005AE78400217B
      2100B5847300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFFF
      FF00FFFFFF00FFFFFF00D6B5AD00EFDEB500FFF7E700FFEFB500FFD6AD00FFF7
      C600FFF7C600FFF7C600FFF7C600EFDEB500BD9C9400FFD6CE00A57B7300FF00
      FF00FF00FF00D6732100F7FFFF00CEF7FF00FFFFFF00FFFFFF00FFFFFF00FFF7
      F700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E78C
      2900E78C290084848400FF00FF00FF00FF00FF00FF0042CE730031C66B0031C6
      6B0031C66B0031C66B0031C66B0031C66B0031C66B0031C66B0094DEAD00FFFF
      FF00FFFFFF00FFFFFF00DEF7E70031C66B0031C66B0021BD4A0021BD4A0021BD
      4A00FF00FF00EFBD9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      EF00B5847300FFC67B00DEAD8400FFD6CE008CBD8C00217B210008841800FFCE
      C600B5847300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFF
      FF00FFFFFF00FFFFFF00DED6D600E7BDB500FFF7F700FFFFFF00FFEFB500FFEF
      B500FFD6AD00FFEFB500FFEFB500D6AD9400DEC6B500FFD6B500A57B7300FF00
      FF00FF00FF00D6732100EFF7EF0094D69400F7FFF700FFFFFF00F7E7DE00F7E7
      DE00F7E7DE00F7EFE700F7EFE700FFF7EF00FFFFFF00FFFFFF00FFFFFF00EF94
      2900C6BD840084848400FF00FF00FF00FF00FF00FF007BCE7B0042CE730042CE
      730031C66B0031C66B0031C66B0031C66B0031C66B0094DEAD00FFFFFF00FFFF
      FF00FFFFFF00DEF7E70031C66B0031C66B0031C66B0031C66B0021BD4A00189C
      2900FF00FF00DEAD8400FFFFFF00FFFFFF00FFFFFF00F7F7F700F7F7F700EFEF
      EF00B5847300D6AD9400F7E7D600FFF7E700FFF7E7007BAD73008CBD8C00FFCE
      C600B5847300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D6B5AD00DEC6B500EFE7DE00F7EFDE00FFEF
      B500FFEFB500EFDEB500D6AD9400CEA5A500FFD6CE00F7BDB500A57B7300FF00
      FF00FF00FF00D6732100DEF7DE0063C66300FFFFFF00FFFFFF00FFF7F700FFF7
      F700FFF7F700FFFFF700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00F79C
      3100BDCE9C0084848400FF00FF00FF00FF00FF00FF007BCE7B0094DEAD005AE7
      840042CE730031C66B0031C66B0031C66B005AE78400FFFFFF00FFFFFF00FFFF
      FF00DEF7E70042CE730031C66B0031C66B0031C66B0031C66B0031C66B000884
      1800FF00FF00DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400F7EFDE00FFFFEF00FFF7EF00FFF7E700FFEFD600FFCEC600F7BD
      B500B5847300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6BDBD00CEA5A500DEB5A500CEAD
      AD00DEB5A500CEA5A500E7BDB500FFD6CE00F7BDB500FFA5A500B5847300FF00
      FF00FF00FF00D6732100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EF9C
      3100E7AD520084848400FF00FF00FF00FF00FF00FF0010B5310094DEAD0094DE
      AD005AE784007BCE7B0042CE730031C66B007BCE7B00FFFFFF00FFFFFF00DEF7
      E70042CE730031C66B0031C66B0031C66B0031C66B0031C66B0021A539004AAD
      4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400FFFF
      F700FFFFF700FFFFFF00FFFFF700FFFFF700FFF7EF00B5847300B5847300B584
      7300B5847300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7B58C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDED600EFE7
      DE00F7E7E700FFFFEF00B5847300B5847300B5847300B5847300B5847300FF00
      FF00FF00FF00D6732100D67321004263B500397BC600A5735200E78C2900E78C
      2900E78C2900E78C2900E78C2900E78C2900E78C2900E78C2900E78C2900E78C
      2900E78C290084848400FF00FF00FF00FF00FF00FF0039C6390039C63900ADE7
      BD0094DEAD0094DEAD005AE7840042CE730042CE730094DEAD00ADE7BD0042CE
      730031C66B0031C66B0031C66B0031C66B0031C66B0021BD4A0008841800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700B5847300FFB54A00D694
      6300DEC6B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7B58C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700B5847300E7B58C00FFB54A00D6946300D6AD9400FF00
      FF00FF00FF00D6732100DE8429003994CE004294BD00A57B6300E78C2900E78C
      2900E78C2900E78C2900DE8C2900E78C2900E78C2900DE8C2900E78C2900E78C
      2900DE8C2900FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF0039C6390039C6
      3900BDE7BD0094DEAD0094DEAD007BCE7B005AE7840052B5940031C66B0031C6
      6B0031C66B0031C66B0031C66B0031C66B0021BD4A00009C0000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700B5847300EFBD9400DEC6
      B500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFFFF700FFFFF700B5847300EFCEA500FFC67B00D6AD9400FF00FF00FF00
      FF00FF00FF00FF00FF00FFA53100DE842900E78C2900EF943100F7A53100F79C
      3100F79C3100F79C3100F79C3100F79C3100EF9C3100EF9C3100F79C3100F79C
      3100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF0039C6
      390039C6390094DEAD00BDE7BD0094DEAD0094DEAD005AE784005AE7840031C6
      6B0031C66B0031C66B0031C66B0010B5310008A51800FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400FFF7
      E700FFF7E700F7EFDE00F7EFDE00EFE7DE00EFE7DE00EFDED600EFDED600EFDE
      D600DED6CE00DED6CE00B5847300DEAD8400E7B58C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF007BCE7B0008B5180039C639007BCE7B007BCE7B007BCE7B007BCE7B0042CE
      730021BD4A0010B53100009C000042CE7300FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400DEAD8400B5847300DEAD8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0039C6390039C6390008B5180008B5180008B5
      180039C63900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00009CCE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B73008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5390800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00009CCE00C6EFF70031B5E70018A5
      D600009CCE007BCEE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00295AF700FF00FF00A57B7300FFD6CE00FFD6
      CE00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFCEC600FFCE
      C600FFCEC600FFD6B500FFD6B500FFD6B500FFD6B500FFD6B5008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00AD522900BD5A0000A5390800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00009CCE0094D6F7009CE7FF007BDE
      FF0073D6FF0052C6F70031B5E70018A5D600009CCE004ABDE700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000031DE000031DE00FF00FF00A57B7300F7EFDE00FFEF
      D600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEBD00FFDE
      BD00FFDEBD00FFDEBD00FFD6AD00FFD6AD00FFD6AD00FFD6B5008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00BD7B5A00BD5A0000CE630000CE630000A539
      0800FF00FF00FF00FF00FF00FF00FF00FF00009CCE004ABDE700D6EFFF007BDE
      FF007BDEFF007BDEFF007BDEFF007BDEFF007BDEFF0063D6F7004ABDE70029AD
      DE00009CCE0018A5D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000031DE000031DE000031DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000031DE000031DE000031DE00FF00FF00B5847300F7EFDE00FFF7
      E700FFEFD600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDE
      BD00FFDEBD00FFDEBD00FFDEBD00FFD6AD00FFD6AD00FFD6B5008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A5390800CE630000CE630000CE63
      0000A5390800FF00FF00FF00FF00FF00FF00009CCE0031B5E700D6EFFF0084EF
      FF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EFFF0084EF
      FF0084EFFF0063D6F70031B5E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000031DE000031DE000031DE000031DE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000031DE000031DE000031DE00FF00FF00FF00FF00B5847300F7EFE700FFF7
      E700FFF7E700FFEFD600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFD6AD00FFD6B5008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5390800CE630000CE63
      0000CE630000A5390800FF00FF00FF00FF00009CCE0052C6F70094D6F700ADFF
      FF0084EFFF008CF7FF008CF7FF008CF7FF008CF7FF008CF7FF008CF7FF008CF7
      FF008CF7FF007BDEFF007BDEFF00009CCE00FF00FF00FF00FF00FF00FF00FF00
      FF000031DE000031DE000031DE000031DE000031DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031
      DE000031DE000031DE00FF00FF00FF00FF00FF00FF00B5847300F7EFE700FFF7
      EF00FFF7E700FFF7E700FFEFD600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFCEC6008C5A5A00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5390800CE63
      0000CE630000BD5A0000B5634200FF00FF0018A5D60063C6FF0063C6E700C6FF
      FF009CFFFF009CFFFF008CF7FF009CFFFF008CF7FF009CFFFF008CF7FF009CFF
      FF008CF7FF007BDEFF0084EFFF004ABDE700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000031DE000031DE000031DE000031DE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031DE000031
      DE000031DE00FF00FF00FF00FF00FF00FF00FF00FF00BD8C8400F7EFE700FFF7
      EF00FFF7EF00FFF7E700FFF7E700FFEFD600FFEFD600FFEFD600FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFDEBD00FFCEC6009C6B6300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AD4A
      0000CE630000CE630000A5390800FF00FF0018A5D60073D6FF0029ADDE00E7FF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF0084EFFF009CE7FF00ADFFFF00009CCE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000031DE000031DE000031DE000031DE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031DE000031DE000031
      DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD8C8400FFF7EF00FFFF
      EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFD600FFEFD600FFEFD600FFE7
      CE00FFE7CE00FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFCEC6009C6B6300FF00
      FF00B5634200BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A0000BD5A
      0000BD5A0000BD5A0000BD5A0000A5390800FF00FF00FF00FF00FF00FF00B563
      4200BD5A0000CE630000CE630000AD52290018A5D60073D6FF0029ADDE009CDE
      EF00D6FFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFF
      FF00ADFFFF0084EFFF009CE7FF00D6FFFF004ABDE700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000031DE000031DE000031DE000031
      DE00FF00FF00FF00FF00FF00FF00FF00FF000031DE000031DE000031DE00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD8C8400FFF7EF00FFFF
      F700FFFFEF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFD600FFEFD600FFEF
      D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEBD00FFCEC6009C6B6300FF00
      FF00B5634200CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000BD5A0000FF00FF00FF00FF00FF00FF00FF00
      FF00A5390800CE630000CE630000AD4A000018A5D6007BDEFF007BDEFF0031B5
      E7004ABDE7007BCEE700ADDEF700D6EFFF00E7FFFF00C6FFFF00C6FFFF00C6FF
      FF00C6FFFF009CE7FF009CE7FF00E7FFFF00ADDEF700009CCE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00295AF7000031DE000031
      DE000031DE00FF00FF00FF00FF000031DE000031DE000031DE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFF7F700FFFF
      F700FFFFEF00FFFFEF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFD600FFEF
      D600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFD6CE009C6B6300FF00
      FF00B5634200E77B0000E77B0000CE630000CE630000BD5A0000AD4A0000AD4A
      0000AD4A0000AD4A0000AD4A0000A5390800FF00FF00FF00FF00FF00FF00FF00
      FF00B5847300BD5A0000CE630000BD5A000029ADDE0084EFFF0084EFFF007BDE
      FF0084EFFF004ABDE70031B5E70031B5E70042B5DE00F7FFF700D6FFFF00D6FF
      FF00D6FFFF009CE7FF009CDEEF00088418008CBD8C0063C6E700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004273FF000031
      DE000031FF000031DE000031DE000031DE000031DE00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFFFFF00FFFF
      FF00FFFFF700FFFFEF00FFFFEF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEF
      D600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7CE00FFD6CE00A57B7300FF00
      FF00B5634200E77B0000E77B0000E77B0000CE630000CE630000A5390800FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD4A0000CE630000CE63000029ADDE008CF7FF008CF7FF008CF7
      FF008CF7FF008CF7FF008CF7FF008CF7FF0073EFFF0018A5D60042B5DE004ABD
      E7004ABDE7004ABDE700298C420042CE73000884180052B59400FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006384
      F7000031DE000031DE000031FF000031DE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFEF00FFFFEF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFEFD600FFEFD600FFEFD600FFE7CE00FFE7CE00FFD6CE00A57B7300FF00
      FF00B5634200E77B0000E77B0000E77B0000E77B0000E77B0000CE630000A539
      0800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD522900CE630000CE63000029ADDE009CFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF0073EF
      FF0063D6F700087B420021BD4A005AE784005AE78400189C2900FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031
      DE000031FF000031DE000031DE000031FF006384F700FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFEF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFEFD600FFEFD600FFEFD600FFE7CE00FFCEC600A57B7300FF00
      FF00B5634200FF9C0800E77B0000AD4A0000AD4A0000E77B0000E77B0000CE63
      0000A5390800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B5634200CE630000CE63000031B5E700ADFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF00D6FFFF00C6FFFF00C6FFFF00ADFFFF009CFFFF009CFF
      FF004AAD4A00189C29005AE784005AE784005AE784005AE78400217B2100FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031DE000031
      FF000031DE000031FF00295AF7000031FF000031DE006384F700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFFEF00FFF7EF00FFF7
      EF00FFF7E700FFF7E700FFEFD600FFD6CE00FFCEC600F7BDB500A57B7300FF00
      FF00B5634200FF9C0800FF9C0800AD4A0000FF00FF00AD4A0000E77B0000E77B
      0000CE630000A5390800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD522900CE630000CE63000031B5E700E7FFFF00ADFFFF00ADFF
      FF009CFFFF00D6FFFF007BCEE70031B5E70031B5E70031B5E70031B5E7008CBD
      8C000884180042CE73005AE784005AE784005AE784005AE784005AE784006BA5
      6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031FF000031FF000031
      DE000031FF00FF00FF00FF00FF00FF00FF000031FF000031FF006384F700FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFEF00FFFFEF00FFF7
      EF00FFF7EF00FFF7E700FFD6CE00F7BDB500FFA5A500FFA5A500B5847300FF00
      FF00B5634200FF9C0800FF9C0800AD4A0000FF00FF00FF00FF00BD5A0000E77B
      0000E77B0000E77B0000A5390800CE9C8400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD4A0000CE630000CE63000031B5E70063C6E70094D6F7009CDE
      EF00BDE7F70094D6F70031B5E700FF00FF00FF00FF00FF00FF00FF00FF008CBD
      8C007BAD7300428C390021BD4A005AE784005AE78400088418006BA563007BAD
      7300FF00FF00FF00FF00FF00FF00FF00FF000031FF000031DE000031FF000031
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031FF000031FF006384
      F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7B58C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFEF00FFFF
      EF00FFF7EF00B5847300B5847300B5847300A57B7300B5847300B5847300FF00
      FF00B5634200FFB54A00FF9C0800AD4A0000FF00FF00FF00FF00FF00FF00AD4A
      0000E77B0000E77B0000E77B0000BD5A0000AD522900FF00FF00FF00FF00FF00
      FF00A5390800CE630000CE630000BD5A0000FF00FF0031B5E70031B5E70031B5
      E70031B5E70031B5E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0021A5390042CE73005AE7840008841800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000031FF000031FF000031FF000031FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00295AF7000031
      FF006384F700FF00FF00FF00FF00FF00FF00FF00FF00E7B58C00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      EF00FFFFEF00B5847300E7B58C00FFB54A00FF9C0800D6946300D6AD9400FF00
      FF00B5634200FFB54A00FFB54A00AD4A0000FF00FF00FF00FF00FF00FF00FF00
      FF00AD4A0000E77B0000E77B0000E77B0000E77B0000BD5A0000BD5A0000BD5A
      0000CE630000CE630000CE630000A5390800FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0021A5390042CE730031C66B008CBD8C00FF00FF00FF00
      FF00FF00FF00FF00FF000031FF000031FF000031FF000031FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004273
      FF000031FF004273FF00FF00FF00FF00FF00FF00FF00EFBD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFEF00B5847300EFCEA500FFC67B00DEAD8400D6AD9400FF00FF00FF00
      FF00B5634200FFB54A00FFC67B00AD4A0000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD522900CE630000E77B0000E77B0000E77B0000E77B0000E77B
      0000CE630000CE630000A5390800FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00428C390021BD4A0042CE730008841800FF00FF00FF00FF00FF00
      FF00FF00FF000031FF000031FF000031FF000031FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF004273FF000031FF00FF00FF00FF00FF00FF00FF00EFBD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFFFF700B5847300EFCEA500E7B58C00D6AD9400FF00FF00FF00FF00FF00
      FF00FF00FF00AD522900AD4A0000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00CE9C8400AD4A0000CE630000CE630000E77B0000CE63
      0000BD5A0000A5390800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006BA56300189C290031C66B0008841800FF00FF00FF00FF00FF00FF00FF00
      FF000031FF000031FF000031FF000031FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400FFF7E700FFF7
      E700F7EFDE00F7EFDE00EFE7DE00EFE7DE00EFDED600EFDED600DED6D600DED6
      CE00DED6CE00B5847300DEAD8400E7B58C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D6946300B5634200BD7B
      5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00ADD6B50000730800428C3900007308000884
      180008A51800189C2900217B2100FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000031FF000031FF000031FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400DEAD8400DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400B5847300DEAD8400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ADD6B5006BA563007BAD
      73007BAD7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00424D3E000000000000003E000000
      2800000050000000840000000100010000000000300600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFF000000000FFFF3FFF
      FFFBFFF000000000F3003FBFFFFFFFF000000000F0003F0FFFFF8FF000000000
      F8003F01FFFE07F000000000F8003F007FFC03F000000000F8003F007FF003F0
      00000000F8003F007FF0033000000000F8003F007FE0001000000000C0003F00
      7FE0001000000000C0003F003FE0021000000000C0007F003FE0071000000000
      C0007F001FF0019000000000C0007F000FC810F000000000C003FF000F877070
      00000000C007FF000F82107000000000C00FFF001F82107000000000C00FFFC0
      7F8018F000000000C01FFFE07F861CF000000000C03FFFFFFFEE1FF000000000
      FFFFFFFFFFFE1FF000000000FFFFFFFFFFFFFFF000000000FFFFFFFFFFFFFFFF
      FFFF0000FFFFFC3FFFFFFFFFFFFF00000000F803FFE381FFF003000000007801
      FFE0003FF0030000000078003FE0003FF00300000000780003E0003F80030000
      0000080001E0003F800300000000080001E0007F8003000000000C0001C0007F
      8003000000000C0001C0007C0003000000000C0001C0007C0003000000000E03
      03C0007C0007000000000E0303C0007C000F000000000E0383C000FC001F0000
      00000E0303C000FC003F000000000C0303C000FC007F000000000C0303C000FC
      00FF0000C0000C0303C000FC00FF0000E0000E0787C000FC01FF0000E0000F0F
      CFFE01FC03FF0000FFFFFFFFFFFF0FFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000
      FC7FFE007FFFFFFFFFFF0000F003FC003FFFFFFF0FFF0000E000FC001FFFFFFF
      07FF0000C00018000FFE3FFC000300008000080007F800380001000000000800
      03F00018000100000000080003F0001800010000000008000330001800010000
      0000080003100018000100000000080003000018000100000000080003800018
      0001000080000C0003C0003800010000C0001E0007E000F800010000E0003E00
      0FF000F800010000E0007E0E0FF000F800010000F001FE0F0FF000F800010000
      F003FE070FF001F800010000F003FF070FF807F800010000E007FF031FFC7FF8
      00010000E007FF801FFFFFF800010000E007FFC03FFFFFFC00030000C00FFFE0
      7FFFFFFFFFFF0000FFFFF80001FFFFFFFFFF0000FFFFF0000100007FE3FF0000
      FFFFF0000100003FE1FD0000E00010000100001FE1F90000C00000000100001F
      E1F10000800000000100003FE3F10000800000000100003FE3E1000080000000
      0100003FE3E30000800000000100003FC3C30000800000000100001FC3870000
      800000000100001C00070000800000000100000C000F0000800000000100002C
      000F00008000100001000038000F000080001000010000180007000080001000
      01000018000700008000100001000038000700008000100001000038000F0000
      C000300001000039C00F0000E000700003000038F01F0000FFFFF0000700003C
      001F0000FFFFF0000FFFFFFF03FF0000C0001FFFFFFC01FFFFFF0000C0001FFF
      FFF000FFFFFF0000800018000380007801FF0000800018000380003801FF0000
      C000180003800018007F0000C000180003800008003F0000C000180003800008
      001F0000C000180003800008000F0000C000180003800008000F0000C0001800
      0380000800030000C00018000380000800030000C00018000380000800070000
      C00018000380000800070000C00018000380000800070000C000180003800008
      00070000C00018000380000800070000C00018000380000FC0070000C0001800
      0380001FC0070000C00018000780003FC00F0000C0003C000FC0007FC01F0000
      C0007FFFFFF000FFFFFF0000C000FFFFFFFE07FFFFFF0000FFFFFFFFFFBFFFFF
      FFFF000080001FFFBF03FFFFFFFE000080001FFF1F003FFFFFFC000080001FFE
      0F0003F1FFF8000080001FFF070001F0FFF1000080001FFF830000F07FE30000
      80001FFFC10000FC3FC7000080001FFFE100007E1F8F000080001000E000007F
      0F1F000080001000F000003F863F000080001000F000003FC07F00008000101F
      F800003FE0FF00008000100FF800003FE07F000080001007F800001FC03F0000
      80001083F800000F871F0000800010C0F801E00F0F8F0000800010E07083FC3E
      1FC70000800010F000FFFC3C3FE30000800030F801FFF8787FF30000800079FC
      03FFF0F0FFFF00008000FFFF8FFE01F1FFFF00008001FFFFFFFF87FFFFFF0000
      00000000000000000000000000000000000000000000}
  end
  object imgSmall: TImageList
    BkColor = clFuchsia
    Height = 18
    Width = 18
    Left = 644
    Top = 68
    Bitmap = {
      494C01011A001D00040012001200FF00FF00FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000004800000090000000010020000000000000A2
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00F700
      FF0029739C00007BB5001084BD00188CC6002194CE00108CC6000084AD00D610
      F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00848484008484
      840084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF006B52
      DE0008A5DE004AC6EF007BE7FF007BB5CE006BA5B5005AADC60052C6E700007B
      B500CE10EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005A425A003142310000390000003900000039
      00003142310052525200848484008C738C00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00E721F70018AD
      CE004ACEFF007BE7FF0094EFFF00A5C6CE0039393900000000007B9CAD007BE7
      FF000084C600DE08F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF001831180000730000007B000000840000008400000084
      0000007B000000730000104210006B6B6B008C7B8C00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00D621F70000B5
      D60063D6FF0084E7FF00ADEFFF00BDEFF7002121210010101000ADCED600A5F7
      FF005ACEEF000084AD00EF08EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00104A100000840000008400000084000000840000008400000084
      0000008400000084000000840000085208006B6B6B008C738C00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00D621F70000B5
      D60063D6FF008CE7FF00B5F7FF00BDDEE7001818180031313900D6FFFF00ADEF
      FF007BE7FF000084B500634ABD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF001831180000840000008400000084000000840000108C100052A552001084
      1000008400000084000000840000008400001042100084848400FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00D621F70000B5
      D60063D6FF0084E7FF00ADEFFF00ADCED600181010000000000094B5C600ADEF
      FF0084E7FF0000A5CE007352DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000730000008400000084000000840000108C1000B5CEB500FFFFFF0063AD
      6300008400000084000000840000008400000073000052525200FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00D621F70000AD
      CE0052CEFF0073DEFF0094EFFF00ADDEEF00424A5200000000007BADBD008CEF
      FF0073DEFF0010A5DE006B52DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00007B00000084000000840000108C1000B5CEB500FFF7FF00FFFFFF00CEE7
      CE0010841000008400000084000000840000007B00003142310084848400FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00E731FF0000BD
      CE0010A5DE0042C6F70063CEF700A5F7FF008CD6EF008CCEDE0094E7FF007BDE
      FF005AD6FF0010ADDE005A63DE00FF00FF00FF00FF00FF00FF00FF00FF000039
      0000008400000084000000840000ADCEAD00FFF7FF008CBD8C00C6DEC600FFFF
      FF0063AD6300008400000084000000840000008400000039000084848400FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00E75A
      FF004AC6E70029B5DE0018A5D600089CD60010A5DE0029ADDE0021ADE70021B5
      EF0029BDF70000B5D6009C39E700FF00FF00FF00FF00FF00FF00FF00FF000039
      0000008400000084000000840000399C3900399C3900088408005AA55A00FFFF
      FF00CEE7CE00088408000084000000840000008400000039000084848400FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00B5EFFF0063CEF7008CF7FF0073EFFF0073F7FF005AE7EF005ACEEF0021A5
      D60000ADD600844AE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000039
      000000840000008400000084000000840000008400000084000008840800C6DE
      C600FFFFFF0063AD630000840000008400000084000000390000FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF008CD6FF0018B5FF0029525200A552AD00FF08FF00E74AFF0094EFFF0063CE
      FF000094AD00F708F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00007B00000084000000840000008400000084000000840000008400005AA5
      5A00FFFFFF00D6E7D6000884080000840000007B000031423100FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF008CEFFF0008B5FF00103131008C4A8400FF00FF00FF00FF00DE7BF7004AD6
      FF00008CA500EF08EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00007300000084000000840000008400000084000000840000008400000884
      0800B5D6B500DEEFDE0042A5420000840000007300005A425A00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00E763FF0021BDF7000000100021391800EF18EF00FF00FF00C67BEF005AD6
      FF0000949C00E708EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00103110000084000000840000008400000084000000840000008400000084
      00000084000000840000008400000084000018311800FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF10FF009CDEE70010212100000000004A5A4200FF00FF00A584FF0039D6
      F700734ADE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00104A100000840000008400000084000000840000008400000084
      0000008400000084000000840000104A1000FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F731FF009CE7F7004A738C004A737B0063CEDE007BDEFF0018AD
      D600CE18F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF001031100000730000007B000000840000008400000084
      0000007B00000073000018311800FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF29FF00C6FFFF00ADF7FF00A5E7FF0021BDD600D610
      F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005A105A0000390000003900000039
      00005A105A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF004A5252003931
      3100393131006B736B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0084ADCE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063525200948C
      94008484840042393900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00217BAD0084B5D600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0052525200ADAD
      B50094848400635A6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF001073AD0073B5D600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006B6B6B00949C
      94006B7373005A525A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008CB5D60084BDD600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00296B8C009CC6
      CE007BA5B500396B7B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0010849C0084C6CE0084BDD600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084848400FFFFFF008484840084848400848484008484840084848400FFFF
      FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BADC600108CB50063F7
      FF004AF7FF002194B5005A9CC600ADDEF700B5E7E700B5DEEF00A5DEE700B5DE
      F700EFFFFF00CEEFF700ADDEEF0063B5CE002994AD00FF00FF00FF00FF00FF00
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0008739C005AEFEF0073F7
      FF006BFFF7004ADEEF0018739C00A5CEF7009CA5A5004A4A5A00737B7B00DEFF
      EF00E7F7FF00E7FFFF00D6FFFF00E7FFFF007BC6EF004AA5B500FF00FF00FF00
      FF0084848400FFFFFF008484840084848400848484008484840084848400FFFF
      FF0000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF003184AD0031B5CE008CFFFF008CFF
      FF0094FFFF008CFFFF0039ADCE004294BD00525263002118210021182100C6DE
      E700D6F7FF00D6F7FF00D6F7F700E7FFFF00D6F7FF002994C600FF00FF00FF00
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0008639C0063DEEF00A5FFFF00B5FF
      FF00B5FFF700A5FFF70063D6EF00086B9C00738C8C00212121004A5A6300CEF7
      F700D6F7FF00D6FFFF00CEF7FF00CEF7FF00D6F7FF002994CE00FF00FF00FF00
      FF0084848400FFFFFF008484840084848400FFFFFF0000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000FF00
      FF00FF00FF00FF00FF000000000000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000063A5006BDEEF00B5FFFF00CEF7
      FF00CEFFFF00BDFFF70073DEEF00006B9C00C6FFF70073848C00CEF7F700CEFF
      FF00D6F7FF00D6F7FF00CEF7FF00CEF7FF00CEF7FF00299CCE00FF00FF00FF00
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000FF00
      FF00FF00FF000000000000000000000000000000000000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF002173AD005AC6DE00B5FFF700DEFF
      FF00DEF7FF00BDFFFF0063C6D6002984AD00C6F7FF00525A63005A6B73008CAD
      AD00BDE7E700C6F7FF00C6EFFF00C6F7FF00C6F7FF00299CD600FF00FF00FF00
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF008484
      84008400000084000000FFFFFF000000840000008400C6C6C60000000000FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0084B5CE00187BA500ADF7F700DEFF
      F700DEFFFF00A5F7FF00187BA5005AADC600C6F7FF005A5A6B00313939003131
      31004A525A00B5F7FF00BDF7FF00B5F7FF00BDF7FF0031A5DE00FF00FF00FF00
      FF0084848400848484008484840084848400848484008484840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000840000008400C6C6C60000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004284AD00187BA50073C6
      D6006BBDD600187BA5002984B500B5F7FF00BDF7FF009CC6CE00426363003931
      390039313900B5F7FF00C6F7FF00B5F7F700B5F7FF0031ADE700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0084848400C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
      00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00188CC6001884
      AD002184AD005AB5CE00ADEFFF0084A5A5006B8C9C00ADE7EF00B5F7F700525A
      630042394200B5F7FF00B5EFFF00B5F7FF00B5F7FF0039B5E700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00
      FF00FF00FF00FF00FF000000000000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0052BDEF0084E7
      F700A5EFF700A5EFFF00A5EFEF004A4A520052424A0073ADA5009CBDBD00524A
      52004A4A5A009CF7FF009CF7FF0094F7FF00ADEFFF0042BDE700FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000000000000000000000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084D6FF0073CE
      F7009CF7FF00ADEFF700A5EFFF008CEFF70073ADB500637B840052738400639C
      A50094DEE7008CEFF7009CF7FF00A5EFFF006BD6F70063CEEF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0063CE
      E70084E7FF008CEFFF0094EFFF0084EFFF0094F7F700A5F7FF0094E7F70094EF
      FF0094EFFF0094EFFF008CE7FF007BDEF70063CEEF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008484
      8400848484008484840084848400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005ACEFF0052CEF70052D6F7004ACEF7005ACEFF004AC6F7005ACEFF004ACE
      F7004ACEF7005ACEF7005ACEF7006BD6FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF003139B5000008BD0010109C002121840042397B00636384008484
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0084000000FFFF0000FF000000FF00000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF002963BD000852EF000029F7000021E7000010D6000000BD000000
      A50042427B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00A5ADAD00A5ADAD00A5ADAD00A5ADAD00A5ADAD00DEDE
      DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0084000000FFFF0000FF000000FF000000C6C6C600FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A54221009C391000AD63
      4200AD7B63002984A50052E7EF001084FF004A9CD60000ADE7000094DE000073
      CE0042528400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A5ADAD00DEDEDE00DEDEDE00DEDEDE005A5A5A008C848400A5AD
      AD00A5ADAD008C7B7B007373730094949400A5A5A500949494008C8C8C00CECE
      CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0084000000FFFF0000FF000000FF000000C6C6C600FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B54A2900AD422100D68C
      7B00FFDED6005294BD0039C6FF003952FF0052A5FF0000D6E70000C6E70000B5
      D600425A8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00AD848400AD848400AD8C9400AD9C9C00BDADAD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A5ADAD00A5A5A500C6C6C600DEDEDE007B7B7B00948C8C00847B
      7B007B7373008C8C8C00636363005A5A5A007B7B7B00C6C6C600EFE7E7008C8C
      8C00EFEFEF00FF00FF00FF00FF00FF00FF008484840000000000000000008484
      8400C6C6C600FF000000FF000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00FF00FF00FF00FF00FF00B5523900B54A3900D694
      8C00FFDEE7004252C600185AFF000029F7000073EF00007B730000846B00008C
      8400214A5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00B5949400DE848C00D6A5A500DEBDBD00D6B5B500CEADAD00C6A5A500B594
      9400A5949400B5ADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A5ADAD00E7E7E700E7E7E700DEDEDE00848484008C8484009494
      9400B5B5B5005A5A5A0052525200424242005252520084848400D6D6D600ADAD
      AD00DEDEDE00FF00FF00FF00FF0084848400C6C6C600FFFF0000C6C6C6000000
      00008484840084848400C6C6C600848484008484840084848400848484008484
      8400FFFFFF0000000000FF00FF00FF00FF00FF00FF00C6524A00BD524A00DE9C
      9400FFE7EF003139BD000010EF000008EF000008E7000042310000730000086B
      0000D6BDBD00B5A5940031426B00183152005A636300FF00FF00FF00FF00FF00
      FF00D68C8C00EF949400D69CA500CEA5A500CEADAD00DEB5BD00DEBDBD00DEBD
      BD00DEB5BD00CEA5AD00BD949400AD949400B59C9C00B5A5A500FF00FF00FF00
      FF00FF00FF00A5ADAD00D6D6D600DEDEDE00DEDEDE0094949400DEDEDE00A5A5
      A500B5B5B500525252004A4A4200845A39004A4A4A0063635A00CECECE00ADAD
      AD00DEDEDE00FF00FF00FF00FF00FFFFFF00FFFF0000C6C6C600FFFF0000C6C6
      C60000000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00C65A5200C65A5A00DEA5
      A500FFEFEF00AD9CD6000008D6001008B5005242840018632900007B0000087B
      0800FFDEE700FFDEDE004A42CE000000B500394A5A00FF00FF00FF00FF00FF00
      FF00D68C8C00EF9C9C00CE9C9C00AD7B7B00A5737300A5737300AD7B7B00C69C
      9400CEA5A500CEA5A500CEA5AD00D6ADAD00D6ADAD00C6A5A500BDB5B500FF00
      FF00FF00FF00A5ADAD00DEDEDE00DEDEDE00E7E7E700B5B5B500E7E7E700A5A5
      A500C6C6C6005A5A5A004A4A4A00C673180052524A0052525200CECECE00A5A5
      A500DEDEDE00FF00FF00FF00FF00FFFF0000FFFFFF00FFFF0000C6C6C600FFFF
      000000000000C6C6C600C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF00FF00FF00BD524200C65A5200DEA5
      9C00FFEFEF00D6CEF7000018FF001810CE009452420021631000008400000884
      0800FFE7E700FFDEDE004A4ADE000008CE00394A5A00FF00FF00FF00FF00FF00
      FF00D6949400EFA5A500CE9C9C00A5737300A5737300A5737300AD7B7300E7C6
      A500B58C7B009C6B6300AD737300B5848400B5848400C6949400BDADB500FF00
      FF00FF00FF00A5ADAD00DEDEDE00CECECE00EFEFEF00ADADAD00E7E7E7009C9C
      9C00DEDEDE006B6B6B005252520042424A004A4A4A006B6B6B00D6D6D6009C9C
      9C00DEDEDE00FF00FF00FF00FF00FFFFFF00FFFF0000FFFFFF00FFFF0000C6C6
      C60000000000C6C6C600C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF007B7B840073635A0084736B009C7B
      6B00AD847300733952004A297B0063317B005A42AD001063310000940000088C
      0800FFEFEF00FFE7EF004A4AEF000008DE00394A6300FF00FF00FF00FF00FF00
      FF00D69C9C00EFADAD00C6949400A5737300A5737300A5737300B5847B00EFCE
      AD00AD8C7B009C6B6B00AD7B7B009C6B6B00A5737300B5848400BDADAD00FF00
      FF00FF00FF00A5ADAD00DEDEDE00CECECE00F7F7F700B5B5B500BDBDBD009C9C
      9C00CECECE00D6D6D60063636300636363005A5A5A00BDBDBD00BDBDBD009494
      9400DEDEDE00FF00FF00FF00FF0084848400FFFFFF00FFFF0000FFFFFF000000
      0000C6C6C60000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF00189CB50000B5DE000894BD001073
      94002963730073528C00736BDE00635AD6006B5AD60018633900009400000894
      0800FFF7F700FFEFEF004A52FF000008F700394A6300FF00FF00FF00FF00FF00
      FF00D6A5A500EFB5B500C6949400BD8C8C00B5848400AD7B7B00AD7B7B00C694
      8C00A57B73009C6B6B00A5736B00A57B7300A5736B00AD7B7B00BDADAD00FF00
      FF00FF00FF00A5ADAD00D6D6D600D6D6D600FFFFFF0073737300A5A5A500B5B5
      B500B5B5B500CECECE00F7F7F700D6D6D600EFEFEF00C6C6C600B5B5B5009494
      9400DEDEDE00FF00FF00FF00FF00FFFFFF00848484008484840000000000C6C6
      C600FFFFFF0000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF001084C60000ADFF0000B5FF0000B5
      F70008ADDE00AD847B00CE9CA500BD94AD007B63BD0029527300216B39002173
      290094A58C00A5B59C00425AB5000829BD004A637300FF00FF00FF00FF00FF00
      FF00D6ADAD00EFBDBD00BD8C8C00BD8C8C00BD8C8C00BD8C8C00BD8C8C00BD8C
      8C00BD8C8C00BD8C8C00B5848400AD7B7B00AD7B7B00B5848400BDADAD00FF00
      FF00FF00FF00A5ADAD00FFFFFF00E7E7E700A5A5A5006B6B6B00737373008C8C
      8C00A5A5A500949494007B7B7B00ADADAD007B7B7B00737373007B7B7B008484
      8400DEDEDE00FF00FF00FF00FF00FFFFFF000000000000000000FFFFFF000000
      0000FFFFFF0000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF001018CE000008FF000008EF000018
      DE000029C600B5737300DE949400D69C8C00946BB5006B6BEF006B63EF007B6B
      E7009C7B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00D6ADAD00EFC6C600BD8C8C00BD848400BD848400BD848400BD848400BD84
      8400BD848400BD848400BD848400BD848400BD848400B5847B00BDADAD00FF00
      FF00FF00FF00A5ADAD00A5ADAD008C8C8C00C6C6C600E7E7E700B5B5B500E7E7
      E700C6C6C600ADADAD00A5A5A5009494940063636300525252004A4A4A007B7B
      7B00DEDEDE00FF00FF00FF00FF00FFFFFF000000000000000000FFFFFF000000
      0000FFFFFF0000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF002939BD001829E7001021E7000810
      DE000808C600B5737300DEA5A500DEADA5009473B5006B6BFF006363F7006363
      EF009C7B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00D6B5B500E7C6BD00AD7B7B00AD737300AD737300AD7B7B00B57B7B00B57B
      7B00B57B7B00B57B7B00B57B7B00B57B7B00B57B7B00AD7B7B00BDADAD00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BDCECE00B5BDBD00B5ADAD00B5AD
      AD00BDB5B500C6C6C600ADADAD008C848400949494009C9C9C008C8484008484
      8400FF00FF00FF00FF00FF00FF00FFFFFF000000000000000000FFFFFF000000
      0000FFFFFF0000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF0084848C009494940084848C00736B
      7B00635A6B006B4A4200633931008C635200CEA59400C69C9C00B58C9C00A57B
      9400CEB5AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00B58C8C00CE8C8C00DE8C8C00DE8C8C00D68C8C00D68C8C00CE8C8C00CE84
      8C00C6848C00C6848400BD848400BD848400B57B7B00A56B6B00C6B5B500FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00ADBDC600527B8C00948C8C00A59C9C00C6BDBD00E7E7EF00FF00
      FF00FF00FF00FF00FF00FF00FF00FFFFFF000000000000000000FFFFFF000000
      0000FFFFFF0000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF0073737300847B84007B7B7B007373
      730063636B005A5A5A004242420084848400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00D6C6C600D6BDBD00DEBDBD00DEBDBD00D6B5B500CEADAD00CEA5A500C6A5
      A500C69C9C00C69C9C00C69C9C00C69C9C00C6A5A500CEB5BD00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FFFFFF000000000000000000FFFFFF000000
      0000FFFFFF0000000000C6C6C6000000000000000000FFFFFF0000000000C6C6
      C600FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00FF00FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF00FF00FF00840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0084000000840000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00FF00FF00008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A57B7B00B58C8400BD948C00BD948C00BD948C00BD948C00BD94
      8C00BD948400BD948400BD948400BD9484009C6B6300FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0021ADD6008CDEF70042BD
      EF0029B5E7007BADEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF008C5AC6009C849C00CEB5B500FFE7D600FFE7CE00FFDECE00FFE7CE00FFDE
      BD00FFDEBD00FFDEBD00FFD6B500FFD6B500AD7B7300FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0010A5D6008CD6F70094E7
      FF007BDEFF0063D6FF0052CEF70042C6EF0052CEEF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF005A9CEF00527BC600A594AD00E7CEC600FFEFD600FFE7CE00FFE7CE00FFE7
      C600FFDEBD00FFDEBD00FFDEB500FFD6B500AD7B7300FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0008A5D60073CEF700A5EF
      FF0084E7FF0084E7FF0084E7FF0084E7FF007BE7FF0073DEF70063DEF70052CE
      EF0052CEEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF005A9CE700527BC600A594A500E7CEBD00FFEFD600FFE7CE00FFE7
      CE00FFE7C600FFDEBD00FFDEBD00FFD6BD00AD7B7300FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0021ADDE005AC6F7009CE7
      F700A5FFFF009CFFFF0094FFFF0094FFFF009CFFFF0094FFFF0094FFFF0084EF
      FF0084E7FF0052CEEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00A5A5AD005A9CEF005A7BBD00AD9CAD00F7DECE00E7C6B500DEBD
      AD00E7C6B500F7D6BD00FFDEBD00FFD6BD00AD7B7300FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0029ADDE0052C6F70084D6
      EF00BDFFFF00A5FFFF00A5FFFF00A5FFFF00A5FFFF00A5FFFF00A5FFFF0094F7
      FF0094E7FF009CEFF700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00D6BDB500E7EFEF0084B5E7009C9CA500D6ADA500EFD6B500FFF7
      CE00F7E7C600DEBDB500E7C6B500FFD6BD00AD7B7300FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0029B5DE006BD6FF005ACE
      EF0073D6EF0094DEF700B5EFFF00CEFFFF00C6FFFF00BDFFFF00BDFFFF00A5EF
      FF009CE7FF00CEF7FF0073A5EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00DEC6BD00FFF7EF00EFE7DE00D6B5A500FFE7B500FFF7CE00FFFF
      DE00FFFFEF00FFFFF700D6BDB500EFCEB500B5848400FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0039BDE70084EFFF0073DE
      FF0073E7FF0052BDE7004ABDEF005AC6E700D6EFF700D6FFFF00D6FFFF00B5EF
      FF009CE7F70042A5520073C6BD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00DEC6C600FFF7EF00EFDED600EFCEAD00FFEFBD00FFFFCE00FFFF
      DE00FFFFFF00FFFFF700EFE7C600DEB5AD00B58C8400FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0039BDE7008CF7FF008CF7
      FF008CF7FF008CF7FF008CF7FF0084F7FF0039C6E70052C6E70052C6EF0042BD
      D600299C5A0039C66300299C4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7CEC600FFFFF700EFDED600EFDEBD00FFDEB500FFF7C600FFFF
      D600FFFFDE00FFFFDE00F7EFC600DEB5AD00B58C8400FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0042C6E7009CFFFF009CFF
      FF009CFFFF00A5FFFF00ADFFFF00ADFFFF00A5FFFF0094FFFF0073E7E700299C
      6B0029BD52005AE784004AD66B00299C4A00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7CEC600FFFFFF00EFDEDE00EFD6B500FFEFCE00FFEFBD00FFF7
      CE00FFFFCE00FFFFCE00EFDEBD00DEB5AD00BD948C00FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0052C6EF00BDFFFF00A5FF
      FF009CFFFF00B5FFFF0094DEF70073D6F7006BD6F7006BD6E70063BD840029AD
      420052DE7B005AE784005AE784004AC66B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFD6C600FFFFFF00F7EFEF00E7C6BD00F7EFEF00FFEFD600FFEF
      BD00FFE7B500FFE7B500DEBDA500E7C6B500BD948400FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF0042BDEF008CD6F7009CE7
      F700B5EFFF0094D6F7004AADEF00FF00FF00FF00FF00FF00FF007BB57B004A9C
      4A0031BD52005AE7840042C663004AAD520073AD6B00FF00FF00FF00FF00FF00
      FF00FF00FF00EFD6C600FFFFFF00FFFFFF00EFDEDE00DEC6BD00E7D6C600EFD6
      B500EFD6AD00DEBDA500E7BDB500FFBDBD00BD8C8400FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0042945A0039CE6B005AA57300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFDECE00FFFFFF00FFFFFF00FFFFFF00F7E7E700EFD6CE00E7CE
      C600EFD6CE00D6B5A500CE9C9400CE948C00BD847B00FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006373
      630029B5520031945200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7DECE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700D6ADA500DEAD8400E7A56300D68C9400FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF008C638C007B527B005A4A63004A735200219C
      290021943900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7DEC600FFF7F700FFF7F700FFF7EF00F7F7EF00F7EFEF00F7EF
      E700EFE7E700CEAD9C00E7B58C00EF94A500FF00FF00FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00A5A5AD005A9C520063A56300FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00EFBD9C00E7BD9C00E7BD9C00E7BD9C00E7B59C00DEB59C00DEB5
      9C00DEB59C00C6948400DE8C9400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000840000008400000084000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      000000840000008400000084000000840000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000831FF000831FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00B5848400D6ADA500D6ADA500D6AD
      A500D6ADA500D6ADA500D6ADA500D6A5A500D6AD9C00D6AD9400D6AD9400D6AD
      9400A5736B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004A84
      D600948CAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF002921E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF005A18EF000031DE006318EF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BD9C8C00FFE7DE00FFE7D600FFE7
      D600FFE7CE00FFE7CE00FFE7C600FFDEBD00FFDEBD00FFDEB500FFD6AD00FFD6
      B500AD7B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006BC6
      FF00428CDE00948CAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031
      DE000031DE002921E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006318EF000031DE006318EF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF008484840063636300CECE
      CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C69C9400FFF7E700FFEFDE00FFEF
      D600FFEFD600FFE7CE00FFE7CE00FFE7C600FFDEBD00FFDEBD00FFDEB500FFD6
      B500AD7B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006BC6FF00428CDE00948CAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003921
      E7002129E7000031DE002129E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF005221EF000029DE007318EF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00F7F7F700B5BDBD00DEDEDE00ADADAD00949C
      9C008C8C8C0063636300CECECE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C6A59400FFF7EF00FFF7E700FFEF
      DE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7C600FFDEBD00FFDEBD00FFD6
      BD00AD7B7300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF006BC6FF00428CD600948CAD00EFCEAD00EFCEAD00EFCEAD00EFCE
      AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF002129E7000031DE003121E700FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF005218EF000031DE006B18EF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7E7E700C6C6C600EFF7F70094949400636363009494
      9400C6C6C600ADADAD00949C9C008C8C8C0063636300CECECE00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CEAD9C00FFF7EF00FFF7EF00FFF7
      E700FFEFDE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7C600FFDEBD00FFD6
      C600B5847B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006BC6FF00B5948C00EFCEAD00FFFFCE00FFFFDE00FFF7
      DE00DEB59C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000829DE000031DE002929E700FF00FF00FF00FF00FF00
      FF005221EF000031DE006B18EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B5B5B500D6D6D600FFFFFF0063636300BDBDBD00949494006363
      630063636300C6C6C600C6C6C600C6C6C600ADADAD00949C9C0063636300CECE
      CE00FF00FF00FF00FF00FF00FF00FF00FF00CEADA500FFF7F700FFFFEF00FFF7
      EF00FFF7EF00FFEFDE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7C600FFD6
      C600B5847B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFCEAD00EFC6AD00FFF7BD00FFFFD600FFFFEF00FFFF
      FF00FFFFF700DEB59C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF003942F7000031E7001829E700FF00FF004A21
      E7000029DE007B18EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00B5B5B500C6C6C6008C8C8C00BDBDBD00DEDEDE00DEDEDE00BDBD
      BD008C8C8C00E7E7E700C6C6C600C6C6C600C6C6C600C6C6C600ADADAD006363
      6300FF00FF00FF00FF00FF00FF00FF00FF00DEB5A500FFFFF700FFFFF700FFFF
      EF00FFF7EF00FFF7E700FFEFDE00FFEFD600FFEFD600FFE7CE00FFE7CE00FFDE
      CE00B5848400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFCEAD00FFEFBD00FFE7B500FFFFD600FFFFEF00FFFF
      F700FFFFE700DEBDA500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00524AF7000031EF000031E7000031
      E7007B18EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0063636300C6C6C600DEDEDE00FFFFFF00F7F7F700BDBDBD008C8C
      8C00F7F7F700D6AD8C00E7E7E700DEC6B500DEDEDE00C6C6C600C6C6C6006363
      6300FF00FF00FF00FF00FF00FF00FF00FF00DEB5A500FFFFFF00FFFFFF00FFFF
      F700FFFFEF00FFF7EF00FFF7EF00FFEFDE00FFEFD600FFEFD600FFE7CE00FFDE
      CE00BD948C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFCEAD00FFF7C600FFEFB500FFF7C600FFFFDE00FFFF
      DE00FFFFD600DEC6AD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF006329EF000031F7000031E7000031
      F7008452FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF008C8C8C00FFFFFF00F7F7F700DEDEDE008C8C8C00C6C6C600FFFF
      FF00D6AD8C00F7F7F700D6AD8C00E7E7E700D6AD8C00DEDEDE00E7E7E7008C8C
      8C00FF00FF00FF00FF00FF00FF00FF00FF00E7BDA500FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFEF00FFF7EF00FFF7E700FFEFDE00FFEFD600FFEFD600FFDE
      CE00BD948C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFCEAD00F7E7D600FFF7DE00FFE7BD00FFF7BD00FFF7
      BD00FFFFCE00D6AD9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF006B18F7000031F7000829EF004A31FF004A31
      FF001031EF007B52FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00BDBDBD00C6C6C600BDBDBD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D6D6CE00F7F7F700D6AD8C00E7E7E700E7E7E7008C8C8C00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00E7C6A500FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFFFEF00FFF7EF00FFF7E700FFEFDE00FFDECE00FFC6
      BD00BD8C8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DEB59C00FFF7F700FFF7CE00FFE7B500FFEF
      BD00E7BD9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF006B18FF000031F7000031F7000831FF00FF00FF00FF00
      FF000831FF001042FF007B4AFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00E7DEDE00E79C9C00E78C8C00A56B6B00E78C8C00ADA5
      A500B5BDBD00C6C6C600B5BDBD00ADA5A5008C8C8C008C8C8C00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6AD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFEF00F7E7DE00E7BDB500DEA59C00E794
      9400C6847B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEB59C00DEB59C00DEC6A500DEB5
      A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007318FF000031FF000031FF000831FF00FF00FF00FF00FF00FF00
      FF00FF00FF000831FF00184AFF007B52FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00A56B6B00FFCECE00E7A5A500E79C9C00E78C8C00E78C
      8C00E78C8C00E78C8C008C8C8C008C8C8C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFC6AD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700E7D6C600CE947B00E79C5200D68C
      4A00CE947B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF006318FF000031FF000831FF000831FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000831FF00214AFF006B42FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00A56B6B00E79C9C00FFCECE00E7A5A500E79C
      9C00E78C8C00A56B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7CEB500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700E7D6C600D6AD9400F7BD7B00DE9C
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006321
      FF000031FF000031FF000831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000831FF000831FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A56B6B00E78C8C00A56B
      6B00CEADAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7CEAD00FFFFF700FFF7F700FFF7
      F700F7F7F700F7EFEF00F7EFEF00F7EFE700DEC6BD00D6A58C00E7A59400FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000031
      FF000031FF000831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00EFBD9400E7BD9C00E7BD9C00E7BD
      9C00E7BD9C00E7B59C00E7B59C00DEB59C00D6A58C00CE9C7B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD9C9C00AD8C
      8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C6A5A500BD94
      9400C69C9C00B5848C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000008080800FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7D600F7E7DE00F7E7DE00F7E7
      DE00F7E7D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00EFEFEF00E7E7E700E7DEDE00DECECE00CEADB500A58C
      9400AD848400CEA5A500B57B8C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C6A5B500CEC6C600D6C6C600D6C6
      C600CEB5B500BD9C9C00AD84840094637B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00292929006B6B6B005252520031313100FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00F7E7DE00FFFFFF00E7E7E700CEB5A500D6AD9400DEC6
      BD00EFF7F700F7F7F700F7E7D600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FFF7F700FFFFFF00F7F7F700E7DEE700D6BDBD00CEADAD00AD84
      8400B5848400CEA5A500C6949400FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00DED6D600E7E7E700E7E7E700DEDEDE00DECE
      CE00DEC6C600CEBDBD00C6ADAD00BD9494008C737300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00292929006B6B6B005252520010101000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7EFE700F7FFFF00CE9C8400B54A1000BD633900DEAD9C00C65A
      2100BD522100D6AD9C00F7FFFF00F7E7DE00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7F7F700F7EFEF00F7EFF700E7E7E700CEADB500CE9C9400BD7B
      7300BD7B7B00CEA5A500BD949C00FF00FF00CEA5A500C6ADAD00A59C9C00FF00
      FF00FF00FF00FF00FF00FF00FF00EFEFEF00F7F7F700EFEFEF00E7E7E700DECE
      CE00D6BDBD00CEA5A500CEA5A500C6949400AD8C8C00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00292929006B6B6B005252520010101000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7E7D600FFFFFF00C67B5A00BD420800C64A1000C6A59400FFFFFF00DE94
      6B00C64A0800BD420800CE9C8400FFFFFF00F7E7D600FF00FF00FF00FF00FF00
      FF00FF00FF00FFFFFF00CE948C00DEADA500D6B5B500CE9C9C00C67B7B00C66B
      6B00CE737300CEA5A500CEADAD00DEBDBD00D6B5B500C6A5A500AD9CA500AD9C
      A500A5949400FF00FF00FF00FF00EFEFEF00F7EFEF00F7EFEF00E7E7E700D6C6
      C600D6A5A500CE8C8C00CE848400C6949400FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00002139004AE7FF0000A5FF0000213900FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FFFFFF00DEAD9400BD4A0800CE632900CE632900CE6B3900DE8C6B00CE5A
      2900CE632900CE5A2900BD421000E7CEBD00F7EFEF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FFAD3100EFAD6B00D6947B00CE6B6B00C663
      6300C66B6B00E7C6C600DEC6C600DEB5B500D6A5A500C6949400A57B7B00AD8C
      8C00A5AD9C009C948C00FF00FF00FF00FF00FF00FF00DEAD9C00D6BDBD00CEA5
      A500CE7B7B00CE737300C66B6B00B5738C00FF00FF00FF00FF00FF00FF00FF00
      FF00526B5A0029843900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00004A7B004AE7FF0000A5FF00004A7B00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      D600FFFFFF00C6633100CE5A2100CE633100CE5A2100CE8C6B00F7E7DE00D66B
      3900CE5A2100CE633100C6521800C67B5200FFFFFF00DECEBD00FF00FF00FF00
      FF00FF00FF00FF00FF00E79C4A00FFAD2100FFAD2900FFB53900F7AD5A00DE94
      6B00CE7B7300D6ADAD00D6ADAD00DEB5B500D6B5B500C6A5A500AD8C8C00AD7B
      7B00AD7B7B00A5848400FF00FF00FF00FF00D6946B00FFAD3100EFB56B00DE9C
      8400CE7B7300C6636300B55A5A0094638400FF00FF00FF00FF00636B6B002994
      420021A5390039A55200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000031390008DEFF0018E7FF0008CEFF0000BDFF000031
      3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      DE00F7DED600C6521800CE633100CE633100CE5A2100C6846B00FFFFFF00EFAD
      9400C64A0800CE632900CE5A2900C65A2900F7F7F700F7DED600FF00FF00FF00
      FF00FF00FF00FF00FF00EFA54A00FFB53100FFB53900FFB53900FFB53900FFB5
      3900F7B54A00E79C6300D6948400DEB5B500D6B5B500CE9CA500BD848400BD8C
      8C00B5848400A5848400FF00FF00FF00FF00DE9C5A00FFAD2100FFAD2900FFB5
      3900F7B55200E7945A00C6735A00845A63006363730031A5520021AD420031BD
      520039AD5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000031390008DEFF005AFFFF007BFFFF0021E7FF0039FFFF0008DE
      FF0000313900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      DE00F7DECE00CE5A2100CE633100CE632900CE632900C6521800CEB5AD00FFFF
      FF00E79C7B00C6521800CE632900C65A2900F7F7EF00EFDED600FF00FF00FF00
      FF00FF00FF00FF00FF00F7B54A00FFBD4200FFC64A00FFC64A00FFC65200FFC6
      4A00FFBD4A00FFBD4200EF9C5200DEADAD00D6B5B500C69C9C00BD848400CE94
      9C00C68C8C00A5848400FF00FF00FF00FF00E7A55200FFBD3900FFBD4200FFBD
      4200FFAD2900FF940000CE7B10005A7B420029BD520031BD52004ACE6B004AA5
      5A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000031390021E7FF008CFFFF00BDFFFF00BDFFFF0031CEFF009CFFFF004AFF
      FF0008DEFF0000313900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7E7
      D600FFEFE700DE6B3100D66B3100CE5A2900CE5A2100CE521800C64A1000E7D6
      C600FFFFFF00D6733900CE5A2100CE6B3900FFFFFF00EFDED600FF00FF00FF00
      FF00FF00FF00FF00FF00FFBD5200FFCE5A00FFCE6300FFCE6300FFCE6300FFCE
      6300FFCE5A00FFC65200E79C5A00DEB5B500D6B5B500C6949400B57B7B00B584
      8400BD848400A5848400FF00FF00FF00FF00EFB55200FFC65200FFC64A00EF9C
      1800DE841800D6A56B00CEB59C0073A5730084D694005AB56B00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000637B0063FFFF00B5FFFF00F7FFFF007BCEFF00B5F7FF00B5FFFF0073FF
      FF0018E7FF0000637B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DE
      D600FFFFFF00F79C6B00E7632900CE8C6B00F7EFE700D67B5200BD310000D69C
      7B00FFFFFF00DE8C6300D6521000E79C7300FFFFFF00D6BDB500FF00FF00FF00
      FF00FF00FF00D6AD9400FFCE6300FFD66B00FFD67300FFD67B00FFD67B00FFD6
      7300FFD66B00FFCE6300DE9C6B00DEB5B500D6B5B500C6949400BD848400BD84
      8400BD848400A57B7B00FF00FF00D6AD9C00F7C65A00FFCE6B00DEAD4A005263
      63005A5A6300DEBD9C00F7CE9C00CEA56B0084735A00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000637B007BFFFF00E7FFFF00FFFFFF00BDE7FF009CE7FF00CEFFFF007BFF
      FF0021F7FF0000637B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7F7EF00FFEFDE00FF8C4A00DE845A00EFFFFF00FFFFFF00E7BDA500FFFF
      FF00F7FFFF00E7733900E7733100FFF7EF00F7E7E700FF00FF00FF00FF00FF00
      FF00FF00FF00D6B58C00FFD67300FFDE7B00FFDE8400FFE78C00FFE78C00FFE7
      8400FFDE7B00FFD67300DE9C7B00DEBDBD00D6B5B500CE8C9400B57B7B00C68C
      8C00C68C8C00AD7B7B00FF00FF00D6B59400FFCE6B00FFD67B007BADA5004AAD
      DE0042A5D60039739400948C7300CE9C5A00BD7B6300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF0000637B007BFFFF00E7FFFF00FFFFFF00FFFFFF00FFFFFF00B5FFFF008CFF
      FF0018E7FF0000637B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00F7DED600FFFFFF00FFEFCE00FFB57300EFAD8400EFE7DE00EFF7F700F7E7
      E700F7A57B00FF8C4A00FFDECE00FFFFFF00F7DED600FF00FF00FF00FF00FF00
      FF00FF00FF00DEBD8C00FFDE7B00FFE78C00FFE79C00FFEFA500FFEFA500FFE7
      9C00FFE78C00FFD68400D69C8C00DEBDBD00DEB5B500CE8C8C00C66B6B00BD6B
      6B00B56B6B00AD7B7B00FF00FF00DEBD8C00FFD67B00FFDE8C006BADB50039A5
      D60063C6F70063CEF7006BA5AD00EFCE7B00B5846B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000000000039E7FF00BDFFFF00FFFFFF00FFFFFF00F7FFFF009CFFFF004AFF
      FF0008DEFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F7DED600FFFFFF00FFFFFF00FFF7C600FFDEAD00FFCE9C00FFCE
      9400FFD6AD00FFFFFF00FFFFFF00F7DED600FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00E7C68400FFDE8C00FFEF9C00FFF7AD00FFF7B500FFF7B500FFF7
      AD00FFEF9C00FFDE8C00D6A59400E7D6D600EFDEE700EFDEDE00DEADAD00D684
      8400CE6B6B00AD7B7B00FF00FF00E7C68400FFDE8400FFE79C00F7EFAD00B5CE
      AD006BADBD0063B5D600E7E7A500FFD68C00A57B7300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000031390063F7FF009CFFFF00B5FFFF00B5FFFF0063FFFF0008DE
      FF0000313900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00F7DED600F7EFE700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7E7E700F7DED600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00ADA59400C6AD9400D6BD9C00E7D6AD00F7EFBD00FFF7C600FFF7
      BD00FFEFAD00F7D69400D6A5A500EFD6D600EFD6D600EFD6D600EFD6D600E7CE
      CE00DE94BD00FF00FF00FF00FF00B59C9C00BDAD9400CEBD9400E7D6AD00EFEF
      BD00EFEFC600EFEFB500FFEFA500F7D68C00947B7300FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF000839390018A5BD0031E7FF0021E7FF0018A5BD000031
      3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F7DED600EFDED600EFDED600EFDE
      D600F7DED600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BDA5A500BDA5A500C6A59C00CEB5
      9C00DEC69C00DEBD8C00CE9C9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B59CA500B59C
      9C00BDA59400CEAD9C00DEBD9400D6B58C00947B7B00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF0000000000000000000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CEAD
      B500C6A5A500BD948C00CE73B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00424D3E000000000000003E000000
      2800000048000000900000000100010000000000C00600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFF000000000000000E00FFFC7F000000000000000
      E007FE00F000000000000000C003FC007000000000000000C001F80030000000
      00000000C001F0003000000000000000C001F0003000000000000000C001F000
      1000000000000000C001E0001000000000000000E001E0001000000000000000
      F003E0003000000000000000F003F0003000000000000000F043F00030000000
      00000000F043F0007000000000000000F047F800F000000000000000F807FC01
      F000000000000000FC0FFF07F000000000000000FFFFFFFFF000000000000000
      C3FDFFFFFFFFFFFFFF000000C3F9FFFFFFFFFFFFFF000000C3F9F007FFFFFFFF
      FF000000C3F9F007FFFFFFFFFF000000C3F1F007FFFFFFFFFF00000080007000
      1FFFFFFFFF000000800030001F7FFC01FF000000000030001E3FFE03FF000000
      000030001C1FFF07FF00000000003000180FFF8FFF000000000030001007FFDF
      FF000000000030001F7FFC01FF00000080003E001E3FFE03FF000000C0003F00
      3C1FFF07FF000000C0003F80780FFF8FFF000000C0003FC0F007FFDFFF000000
      E0007FE1FFFFFFFFFF000000F000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000F80FFFFFFFFFFFFC1F000000F807FFFFFC0FFFF83F0000008007FFFF
      F8000FF07F0000008007F83FF8000700030000008007F003F800060003000000
      8000700038000600030000008000700018000600030000008000700018000600
      0300000000007000180006000300000000007000180006000300000000007000
      18000600030000000007F00018000600030000000007F0001F000E0003000000
      0007F0001FF81E000300000000FFF0003FFFFE0003000000FFFFFFFFFFFFFE00
      03000000FFFFFFFFFFFFFFFFFF00000080002000080002000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFF800020000000000FFFFF8007000000000000000
      83FFF0007000000000000000807FF00070000000000000008007F80070000000
      000000008003F80070000000000000008003F80070000000000000008001F800
      70000000000000008001F80070000000000000008001F8007000000000000000
      8000F80070000000000000008000F800700000000000000081C0780070000000
      00000000FFF1F8007000000000000000FFE3F8007000000000000000FE07F800
      F000000000000000FF1FF801F000000000000000FFFFFFFFF000000000000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF9FFFFF00
      07000000E7FFF7FF1FFFFF0007000000E3FFE3FE3F0FFF0007000000F1FFE1FC
      7E01FF0007000000F80FF8F8FC003F0007000000FC07FC71F8000F0007000000
      FC03FE23F8000F0007000000FC03FF07F8000F0007000000FC03FF07F8000F00
      07000000FC03FE03FC001F0007000000FE07FC31FC003F0007000000FF0FF878
      FC00FF0007000000FFFFF0FC7E03FF000F000000FFFFE1FE7F87FF001F000000
      FFFFE3FFFFFFFF003F000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFCFFFFF
      FF000000FFFFFFFFFFC3FFFFFF000000FF3FFF07FC01FF00FF000000FE1FFC01
      F801FE007F000000FE1FF800F8011E007F000000FE1FF00078000600FF000000
      FE1FF0007E000380F3000000FE1FE0003C000300C3000000FC0FE0003C000300
      07000000F807E0003C0003000F000000F003E0003C0003003F000000F003E000
      380002007F000000F003F000780002007F000000F003F000780002007F000000
      F003F800F80002007F000000F807FC01F80006007F000000FC0FFF07FF01FFC0
      7F000000FE1FFFFFFFE1FFFFFF00000000000000000000000000000000000000
      000000000000}
  end
  object quLookUpModelPack: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description,'#13#10 +
      '        IsNull(CaseQty,0) as CaseQty,'#13#10'        IsNull(NotVerifyQ' +
      'ty,0) as NotVerifyQty'#13#10'FROM'#13#10'        Model'#13#10'WHERE'#13#10#9'ModelType IN' +
      ' ('#39'R'#39','#39'S'#39','#39'K'#39', '#39'V'#39', '#39'C'#39', '#39'G'#39')'#13#10'ORDER BY'#13#10'        Model'#13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelClickButton
    Left = 840
    Top = 335
    object quLookUpModelPackIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quLookUpModelPackModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quLookUpModelPackDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quLookUpModelPackCaseQty: TBCDField
      FieldName = 'CaseQty'
      ReadOnly = True
      Precision = 32
    end
    object quLookUpModelPackNotVerifyQty: TBooleanField
      FieldName = 'NotVerifyQty'
      ReadOnly = True
    end
  end
  object dsLookUpModelPack: TDataSource
    DataSet = quLookUpModelPack
    Left = 843
    Top = 397
  end
  object LookUpModelMasterPack: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description'#13#10'F' +
      'ROM'#13#10'        Model '#13#10'WHERE'#13#10#9'ModelType IN ('#39'R'#39','#39'M'#39', '#39'K'#39', '#39'V'#39', '#39'C' +
      #39', '#39'G'#39')'#13#10'ORDER BY'#13#10'        Model'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelMasterClickButton
    Left = 842
    Top = 22
    object StringField15: TStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Size = 30
    end
    object IntegerField8: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDModel'
      Visible = False
    end
    object StringField16: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
  end
  object dsLookUpModelMasterPack: TDataSource
    DataSet = LookUpModelMasterPack
    Left = 840
    Top = 69
  end
  object LookUpBank: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'B.IDBanco,'#13#10#9'B.CodigoBanco,'#13#10#9'B.Banco'#13#10'FROM '#13#10#9'dbo.Fin' +
      '_Banco B'#13#10'ORDER BY'#13#10#9'B.Banco'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Banco'
    CodeField = 'CodigoBanco'
    LookUpField = 'IDBanco'
    Left = 545
    Top = 378
    object LookUpBankIDBanco: TIntegerField
      FieldName = 'IDBanco'
      Origin = 'Fin_Banco.IDBanco'
    end
    object LookUpBankCodigoBanco: TStringField
      FieldName = 'CodigoBanco'
      Origin = 'Fin_Banco.CodigoBanco'
    end
    object LookUpBankBanco: TStringField
      FieldName = 'Banco'
      Origin = 'Fin_Banco.Banco'
      Size = 35
    end
  end
  object dsLookUpBank: TDataSource
    DataSet = LookUpBank
    Left = 589
    Top = 373
  end
  object LookUpHistoryType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDHistoryType,'#13#10'        HistoryType'#13#10'FROM'#13#10'     ' +
      '   HistoryType (FastFirstRow NOLOCK)'#13#10'ORDER BY'#13#10'        HistoryT' +
      'ype'#13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'HistoryType'
    CodeField = 'IDHistoryType'
    LookUpField = 'IDHistoryType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpHistoryTypeClickButton
    Left = 842
    Top = 125
    object LookUpHistoryTypeIDHistoryType: TIntegerField
      FieldName = 'IDHistoryType'
    end
    object LookUpHistoryTypeHistoryType: TStringField
      FieldName = 'HistoryType'
      Size = 255
    end
  end
  object dsLookUpHistoryType: TDataSource
    DataSet = LookUpHistoryType
    Left = 851
    Top = 155
  end
  object LookUpModelService: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description'#13#10'F' +
      'ROM'#13#10'        Model '#13#10'WHERE'#13#10#9'ModelType = '#39'V'#39#13#10'ORDER BY'#13#10'        ' +
      'Model'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    SecondSQL = 
      'SELECT Model.IDModel , Description, Model  FROM dbo.Model Model,' +
      ' dbo.BarCode BarCode WHERE Model.IDModel = BarCode.IDModel AND B' +
      'arCode.IDBarCode = %s'
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelClickButton
    Left = 839
    Top = 224
    object StringField17: TStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Size = 30
    end
    object IntegerField9: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDModel'
      Visible = False
    end
    object StringField18: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
  end
  object dsLookUpModelService: TDataSource
    DataSet = LookUpModelService
    Left = 842
    Top = 276
  end
  object dsLookUpModelKit: TDataSource
    DataSet = LookUpModelKit
    Left = 663
    Top = 649
  end
  object LookUpModelKit: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDModel,'#13#10#9'Model,'#13#10#9'Description,'#13#10#9'IsNull(CaseQty,0) as' +
      ' CaseQty'#13#10'FROM'#13#10#9'Model '#13#10'WHERE'#13#10#9'ModelType IN ('#39'R'#39','#39'S'#39', '#39'K'#39')'#13#10'OR' +
      'DER BY'#13#10#9'Model'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelClickButton
    Left = 665
    Top = 592
    object StringField19: TStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Size = 30
    end
    object IntegerField10: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDModel'
      Visible = False
    end
    object StringField20: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
    object LookUpModelKitCaseQty: TBCDField
      FieldName = 'CaseQty'
      ReadOnly = True
      Precision = 32
    end
  end
  object LookUpProspects: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'C.IDCliente IDComissionado,'#13#10#9'C.Cliente,'#13#10#9'C.Code,'#13#10#9'C.' +
      'IDCliente as IDPessoa,'#13#10#9'C.IDCliente'#13#10'FROM '#9#13#10#9'vwCliente C'#13#10'ORDE' +
      'R BY'#13#10#9'C.Cliente '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Cliente'
    CodeField = 'Code'
    LookUpField = 'IDCliente'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpProspectsClickButton
    Left = 745
    Top = 437
    object LookUpProspectsIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpProspectsCliente: TStringField
      FieldName = 'Cliente'
      Size = 50
    end
    object LookUpProspectsCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpProspectsIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpProspectsIDCliente: TIntegerField
      FieldName = 'IDCliente'
    end
  end
  object dsLookUpProspects: TDataSource
    DataSet = LookUpProspects
    Left = 743
    Top = 485
  end
  object LookUpModelCredit: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description'#13#10'F' +
      'ROM'#13#10'        Model'#13#10'WHERE'#13#10#9'ModelType IN ('#39'R'#39','#39'S'#39','#39'C'#39')'#13#10'ORDER BY' +
      #13#10'        Model'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    SecondSQL = 
      'SELECT Model.IDModel , Description, Model  FROM dbo.Model Model,' +
      ' dbo.BarCode BarCode WHERE Model.IDModel = BarCode.IDModel AND B' +
      'arCode.IDBarCode = %s'
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelClickButton
    Left = 745
    Top = 567
    object StringField22: TStringField
      DisplayWidth = 30
      FieldName = 'Model'
      Size = 30
    end
    object IntegerField14: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDModel'
      Visible = False
    end
    object StringField23: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Visible = False
      Size = 50
    end
  end
  object dsLookUpModelCredit: TDataSource
    DataSet = LookUpModelCredit
    Left = 743
    Top = 624
  end
  object quSrvParamLanguage: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'IDLanguage'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDParam'
      'FROM'
      #9'ParamLanguage'
      'WHERE'
      #9'IDLanguage = :IDLanguage')
    Left = 762
    Top = 13
    object quSrvParamLanguageIDParam: TIntegerField
      FieldName = 'IDParam'
    end
  end
  object LookUpTaxCategPur: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        T.IDTaxCategory,'#13#10'        T.TaxCategory,'#13#10'      ' +
      '  IsNull(T.Tax,0) as Tax'#13#10'FROM'#13#10'        TaxCategory T'#13#10'WHERE'#13#10'  ' +
      '      T.IDTaxCategoryParent = 0'#13#10'        AND'#13#10'        T.Operatio' +
      'nType = 2'#13#10'Order by'#13#10'        T.TaxCategory'#13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'TaxCategory'
    CodeField = 'Tax'
    LookUpField = 'IDTaxCategory'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookUpTaxCategoryClickButton
    Left = 761
    Top = 264
    object AutoIncField1: TAutoIncField
      FieldName = 'IDTaxCategory'
      ReadOnly = True
    end
    object StringField24: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object BCDField1: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '0.00 %'
      Precision = 19
    end
  end
  object dsLookUpTaxCategPur: TDataSource
    DataSet = LookUpTaxCategPur
    Left = 761
    Top = 322
  end
  object dsLookUpSizeGroup: TDataSource
    DataSet = LookUpSizeGroup
    Left = 948
    Top = 74
  end
  object LookUpSizeGroup: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDSizeColorGroup,'#13#10#9'Description'#13#10'FROM '#13#10#9'Inv_SizeColor' +
      'Group'#13#10'WHERE'#13#10#9'IsColor = 0'#13#10'ORDER BY'#13#10#9'Description'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Description'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDSizeColorGroup'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpSizeGroupClickButton
    Left = 950
    Top = 17
    object LookUpSizeGroupIDSizeColorGroup: TIntegerField
      FieldName = 'IDSizeColorGroup'
    end
    object LookUpSizeGroupDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object dsLookUpColorGroup: TDataSource
    DataSet = LookUpColorGroup
    Left = 948
    Top = 184
  end
  object LookUpColorGroup: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDSizeColorGroup,'#13#10#9'Description'#13#10'FROM '#13#10#9'Inv_SizeColor' +
      'Group'#13#10'WHERE'#13#10#9'IsColor = 1'#13#10'ORDER BY'#13#10#9'Description'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Description'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDSizeColorGroup'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpColorGroupClickButton
    Left = 1015
    Top = 94
    object LookUpColorGroupIDSizeColorGroup: TIntegerField
      FieldName = 'IDSizeColorGroup'
    end
    object LookUpColorGroupDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object LookUpPetPorte: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDPorte,'#13#10#9'Porte'#13#10'FROM '#13#10#9'Pet_Porte (NOLOCK)'#13#10'ORDER BY' +
      #13#10#9'Porte'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Porte'
    CodeField = 'Porte'
    CodeFieldSearch = False
    LookUpField = 'IDPorte'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpPetPorteClickButton
    Left = 958
    Top = 237
    object LookUpPetPorteIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object LookUpPetPortePorte: TStringField
      FieldName = 'Porte'
      Size = 50
    end
  end
  object dsLookUpPorte: TDataSource
    DataSet = LookUpPetPorte
    Left = 956
    Top = 294
  end
  object LookUpPetRace: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDBreed,'#13#10#9'Breed'#13#10'FROM '#13#10#9'Pet_Breed (NOLOCK)'#13#10'ORDER BY' +
      #13#10#9'Breed'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Breed'
    CodeField = 'Breed'
    CodeFieldSearch = False
    LookUpField = 'IDBreed'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpPetRaceClickButton
    Left = 944
    Top = 347
    object LookUpPetRaceIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object LookUpPetRaceBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
  end
  object dsLookUpPetRace: TDataSource
    DataSet = LookUpPetRace
    Left = 942
    Top = 404
  end
  object dsLookUpPetSpecies: TDataSource
    DataSet = LookUpPetSpecies
    Left = 957
    Top = 519
  end
  object LookUpPetSpecies: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDSpecies,'#13#10#9'Species'#13#10'FROM '#13#10#9'Pet_Species (NOLOCK)'#13#10'OR' +
      'DER BY'#13#10#9'Species'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Species'
    CodeField = 'Species'
    CodeFieldSearch = False
    LookUpField = 'IDSpecies'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpPetSpeciesClickButton
    Left = 959
    Top = 462
    object LookUpPetSpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object LookUpPetSpeciesSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
  end
  object quTestMessage: TADOQuery
    Connection = ADODBConnect
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
      'SELECT Count(IDMessage) as Messages'
      'FROM Sis_MessageUser'
      'WHERE IDUserReceiver = :IDUser'
      'AND ReadDate IS NULL AND Desativado = 0')
    Left = 760
    Top = 64
    object quTestMessageMessages: TIntegerField
      FieldName = 'Messages'
      ReadOnly = True
    end
  end
  object LookUpRoundType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDRoundingTable,'#13#10#9'RoundingTable'#13#10'FROM'#13#10#9'RoundingTable' +
      #13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'RoundingTable'
    CodeField = 'RoundingTable'
    CodeFieldSearch = False
    LookUpField = 'IDRoundingTable'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpModelMasterClickButton
    Left = 726
    Top = 371
    object LookUpRoundTypeIDRoundingTable: TIntegerField
      FieldName = 'IDRoundingTable'
    end
    object LookUpRoundTypeRoundingTable: TStringField
      FieldName = 'RoundingTable'
      Size = 30
    end
  end
  object dsLookUpRoundType: TDataSource
    DataSet = LookUpRoundType
    Left = 624
    Top = 431
  end
  object LookUpModelGroup: TLookUpADOQuery
    Connection = ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'MG.IDModelGroup,'#13#10#9'MG.ModelGroup,'#13#10#9'MG.UserCode'#13#10'FROM'#13#10 +
      #9'vwModelGroup MG'#13#10'ORDER BY'#13#10#9'MG.ModelGroup'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'ModelGroup'
    CodeField = 'ModelGroup'
    LookUpField = 'IDModelGroup'
    Left = 527
    Top = 525
    object LookUpModelGroupIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object LookUpModelGroupUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object LookUpModelGroupModelGroup: TStringField
      FieldName = 'ModelGroup'
      ReadOnly = True
      Size = 61
    end
  end
  object LookUpModelSubGroup: TLookUpADOQuery
    Connection = ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'MSG.IDModelSubGroup,'#13#10#9'MSG.ModelSubGroup,'#13#10#9'MSG.UserCod' +
      'e'#13#10'FROM'#13#10#9'vwModelSubGroup MSG'#13#10'ORDER BY'#13#10#9'MSG.ModelSubGroup'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'ModelSubGroup'
    CodeField = 'ModelSubGroup'
    LookUpField = 'IDModelSubGroup'
    Left = 523
    Top = 474
    object LookUpModelSubGroupIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object LookUpModelSubGroupUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object LookUpModelSubGroupModelSubGroup: TStringField
      FieldName = 'ModelSubGroup'
      ReadOnly = True
      Size = 92
    end
  end
  object dsLookUpModelGroup: TDataSource
    DataSet = LookUpModelGroup
    Left = 607
    Top = 497
  end
  object dsLookUpModelSubGroup: TDataSource
    DataSet = LookUpModelSubGroup
    Left = 600
    Top = 432
  end
  object LookUpDefectType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 'SELECT'#13#10#9'IDDefectType,'#13#10#9'DefectType'#13#10'FROM'#13#10#9'Inv_DefectType'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'DefectType'
    CodeField = 'DefectType'
    CodeFieldSearch = False
    LookUpField = 'IDDefectType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpDefectTypeClickButton
    Left = 577
    Top = 413
    object LookUpDefectTypeIDDefectType: TIntegerField
      FieldName = 'IDDefectType'
    end
    object LookUpDefectTypeDefectType: TStringField
      FieldName = 'DefectType'
      Size = 30
    end
  end
  object dsLookUpDefectType: TDataSource
    DataSet = LookUpDefectType
    Left = 579
    Top = 466
  end
  object LookUpDepartment: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDDepartment,'#13#10#9'Department'#13#10'FROM'#13#10#9'Inv_Department'#13#10'ORDE' +
      'R BY'#13#10#9'Department'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Department'
    CodeField = 'IDDepartment'
    LookUpField = 'IDDepartment'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpDepartmentClickButton
    Left = 307
    Top = 427
    object LookUpDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object LookUpDepartmentDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object dsLookupDepartment: TDataSource
    DataSet = LookUpDepartment
    Left = 436
    Top = 443
  end
  object LookUpSalesPersonEdited: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDSalesPerson,'#13#10#9'IDSalesPerson IDComissionado,'#13#10#9'Pessoa' +
      'Edited,'#13#10#9'Code'#13#10'FROM '#9#13#10#9'vwSalesPerson'#13#10'ORDER BY '#13#10#9'PessoaEdited' +
      #13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PessoaEdited'
    CodeField = 'Code'
    LookUpField = 'IDSalesPerson'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpFornecedorClickButton
    Left = 749
    Top = 129
    object LookUpSalesPersonEditedIDSalesPerson: TIntegerField
      FieldName = 'IDSalesPerson'
    end
    object LookUpSalesPersonEditedIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpSalesPersonEditedPessoaEdited: TStringField
      FieldName = 'PessoaEdited'
      ReadOnly = True
      Size = 62
    end
    object LookUpSalesPersonEditedCode2: TIntegerField
      FieldName = 'Code'
    end
  end
  object dsLookUpSalesPersonEdited: TDataSource
    DataSet = LookUpSalesPersonEdited
    Left = 746
    Top = 194
  end
  object LookUpInvReason: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDMovReason,'#13#10'        Reason'#13#10'FROM'#13#10'        Inv_' +
      'MovReason'#13#10'ORDER BY'#13#10#9'Reason'#13#10#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Reason'
    CodeField = 'Reason'
    CodeFieldSearch = False
    LookUpField = 'IDMovReason'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpInvReasonClickButton
    Left = 959
    Top = 567
    object LookUpInvReasonIDMovReason: TIntegerField
      FieldName = 'IDMovReason'
    end
    object LookUpInvReasonReason: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
  object dsLookUpInvReason: TDataSource
    DataSet = LookUpInvReason
    Left = 962
    Top = 615
  end
  object LookUpMargemType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 'SELECT '#13#10#9'IDMargemTable,'#13#10#9'MargemTable'#13#10'FROM'#13#10#9'MargemTable'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'MargemTable'
    CodeField = 'MargemTable'
    CodeFieldSearch = False
    LookUpField = 'IDMargemTable'
    Left = 526
    Top = 474
    object LookUpMargemTypeIDMargemTable: TIntegerField
      FieldName = 'IDMargemTable'
    end
    object LookUpMargemTypeMargemTable: TStringField
      FieldName = 'MargemTable'
      Size = 30
    end
  end
  object dsLookUpMargemType: TDataSource
    DataSet = LookUpMargemType
    Left = 526
    Top = 522
  end
  object LookUpPHistoryType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDPessoaHistoryType,'#13#10#9'PessoaHistoryType'#13#10'FROM'#13#10#9'Mnt_Pe' +
      'ssoaHistoryType'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PessoaHistoryType'
    CodeField = 'PessoaHistoryType'
    CodeFieldSearch = False
    LookUpField = 'IDPessoaHistoryType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpPHistoryTypeClickButton
    Left = 359
    Top = 442
    object LookUpPHistoryTypeIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object LookUpPHistoryTypePessoaHistoryType: TStringField
      FieldName = 'PessoaHistoryType'
      Size = 30
    end
  end
  object dsLookUpPHistoryType: TDataSource
    DataSet = LookUpPHistoryType
    Left = 339
    Top = 492
  end
  object spInventoryCalcBalance: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_Inv_CalcBalance;1'
    Parameters = <>
    Left = 458
    Top = 58
  end
  object quLookupRebateCalendar: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDRebateCalendar,'#13#10#9'Description,'#13#10#9'DiscountPerc,'#13#10#9'Star' +
      'tDate,'#13#10#9'EndDate'#13#10'FROM'#13#10#9'Sal_RebateCalendar'#13#10'ORDER BY'#13#10#9'Descript' +
      'ion'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Description'
    CodeField = 'IDRebateCalendar'
    LookUpField = 'IDRebateCalendar'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookupRebateCalendarClickButton
    Left = 129
    Top = 588
    object quLookupRebateCalendarIDRebateCalendar: TIntegerField
      FieldName = 'IDRebateCalendar'
    end
    object quLookupRebateCalendarDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object quLookupRebateCalendarDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
    object quLookupRebateCalendarStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object quLookupRebateCalendarEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
  end
  object dsLookupRebateCalendar: TDataSource
    DataSet = quLookupRebateCalendar
    Left = 406
    Top = 635
  end
  object LookUpCashRegLogReason: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDCashRegLogReason,'#13#10#9'Reason'#13#10'FROM'#13#10#9'CashRegLogReason'#13#10 +
      'ORDER BY'#13#10#9'Reason'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Reason'
    CodeField = 'Reason'
    CodeFieldSearch = False
    LookUpField = 'IDCashRegLogReason'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpCashRegLogReasonClickButton
    Left = 418
    Top = 548
    object LookUpCashRegLogReasonIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object StringField25: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
  object dsLookUpCashRegLogReason: TDataSource
    DataSet = LookUpCashRegLogReason
    Left = 421
    Top = 616
  end
  object LookUpDocumentType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDDocumentType,'#13#10#9'DocumentType'#13#10'FROM'#13#10#9'Mnt_DocumentType' +
      #13#10'ORDER BY'#13#10#9'DocumentType'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'DocumentType'
    CodeField = 'IDDocumentType'
    LookUpField = 'IDDocumentType'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpDocumentTypeClickButton
    Left = 529
    Top = 601
    object LookUpDocumentTypeIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object LookUpDocumentTypeDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
  end
  object dsLookUpDocumentType: TDataSource
    DataSet = LookUpDocumentType
    Left = 608
    Top = 622
  end
  object quEntityFields: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDPessoaValidation,'#13#10#9'IDTipoPessoa,'#13#10#9'PessoaField'#13#10'FROM' +
      #13#10#9'PessoaValidation'#13#10#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 542
    Top = 571
  end
  object dspEntityFields: TDataSetProvider
    DataSet = quEntityFields
    Left = 554
    Top = 535
  end
  object cdsEntityFields: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEntityFields'
    Left = 542
    Top = 543
    object cdsEntityFieldsIDPessoaValidation: TIntegerField
      FieldName = 'IDPessoaValidation'
    end
    object cdsEntityFieldsIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object cdsEntityFieldsPessoaField: TStringField
      FieldName = 'PessoaField'
      Size = 40
    end
  end
  object LookUpCFOP: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'CFOP.IDCFOP,'#13#10#9'CFOP.Number,'#13#10#9'CFOP.[Description]'#13#10'FROM'#13 +
      #10#9'Mnt_CFOP CFOP'#13#10'ORDER BY'#13#10#9'CFOP.[Description]'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Number'
    CodeField = 'IDCFOP'
    LookUpField = 'IDCFOP'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpCFOPClickButton
    Left = 896
    Top = 387
    object LookUpCFOPIDCFOP: TIntegerField
      FieldName = 'IDCFOP'
    end
    object LookUpCFOPNumber: TStringField
      FieldName = 'Number'
      Size = 15
    end
    object LookUpCFOPDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
  end
  object dsLookUpCFOP: TDataSource
    DataSet = LookUpCFOP
    Left = 894
    Top = 444
  end
  object LookUpLot: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'SELECT'#13#10'        IDLote,'#13#10#9'Lot'#13#10'FROM'#13#10'        Inv_Lot (NOLOCK)'#13#10'O' +
      'RDER BY'#13#10'        Lot'#13#10#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Lot'
    CodeField = 'Lot'
    CodeFieldSearch = False
    LookUpField = 'IDLote'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpLotClickButton
    Left = 840
    Top = 637
    object LookUpLotIDLote: TIntegerField
      FieldName = 'IDLote'
    end
    object LookUpLotLot: TStringField
      FieldName = 'Lot'
      Size = 50
    end
  end
  object dsLookUpLot: TDataSource
    DataSet = LookUpLot
    Left = 845
    Top = 691
  end
  object LookUpNCM: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'SELECT'#13#10#9'IDNCM,'#13#10#9'Codigo,'#13#10#9'Descricao,'#13#10#9'MVAInterno,'#13#10#9'MVAIntere' +
      'stadual,'#13#10#9'Incide'#13#10'FROM'#13#10#9'Inv_NCM (NOLOCK)'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Codigo'
    CodeField = 'Codigo'
    CodeFieldSearch = False
    LookUpField = 'IDNCM'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpNCMClickButton
    Left = 535
    Top = 672
    object LookUpNCMIDNCM: TIntegerField
      FieldName = 'IDNCM'
    end
    object LookUpNCMCodigo: TStringField
      FieldName = 'Codigo'
    end
    object LookUpNCMDescricao: TStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object LookUpNCMMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object LookUpNCMMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object LookUpNCMIncide: TBooleanField
      FieldName = 'Incide'
    end
  end
  object dsLookUpNCM: TDataSource
    DataSet = LookUpNCM
    Left = 600
    Top = 691
  end
  object LookUpMunicipio: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'SELECT'#13#10#9'IDMunicipio,'#13#10#9'Codigo,'#13#10#9'Descricao'#13#10'FROM'#13#10#9'Sis_Municipi' +
      'o (NOLOCK)'#13#10'ORDER BY'#13#10'                Descricao'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Descricao'
    CodeField = 'Codigo'
    CodeFieldSearch = False
    LookUpField = 'IDMunicipio'
    quFreeSQL = quFreeSQL
    OnClickButton = LookUpMunicipioClickButton
    Left = 715
    Top = 682
    object LookUpMunicipioIDMunicipio: TIntegerField
      FieldName = 'IDMunicipio'
    end
    object LookUpMunicipioCodigo: TStringField
      FieldName = 'Codigo'
    end
    object LookUpMunicipioDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
  end
  object dsLookupMunicipio: TDataSource
    DataSet = LookUpMunicipio
    Left = 780
    Top = 637
  end
  object LookUpCustomerAddress: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 50
    CommandText = 
      'SELECT '#13#10#9'IDPessoaAddress,'#13#10#9'Name,'#13#10#9'Address +'#13#10#9'(CASE City WHEN' +
      ' '#39#39' THEN '#39#39' ELSE '#39', '#39' + City END) + '#13#10#9'(CASE IDEstado WHEN '#39#39' TH' +
      'EN '#39#39' ELSE '#39', '#39' + IDEstado END) + '#13#10#9'(CASE ZIP WHEN '#39#39' THEN '#39#39' E' +
      'LSE '#39' - '#39' + ZIP END) as Address'#13#10'FROM'#13#10#9'Mnt_PessoaAddress (NOLOC' +
      'K)'#13#10'ORDER BY'#13#10#9'Name'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'Name'
    CodeFieldSearch = False
    LookUpField = 'IDPessoaAddress'
    quFreeSQL = quFreeSQL
    Left = 965
    Top = 662
    object LookUpCustomerAddressIDPessoaAddress: TIntegerField
      FieldName = 'IDPessoaAddress'
    end
    object LookUpCustomerAddressName: TStringField
      FieldName = 'Name'
      Size = 60
    end
    object LookUpCustomerAddressAddress: TStringField
      FieldName = 'Address'
      ReadOnly = True
      Size = 130
    end
  end
  object dsLookUpCustomerAddress: TDataSource
    DataSet = LookUpCustomerAddress
    Left = 910
    Top = 632
  end
  object quLookupNutrition: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDNutrition,'#13#10#9'Description'#13#10'FROM '#13#10#9'Inv_Nutrition (NOL' +
      'OCK)'#13#10'ORDER BY'#13#10#9'Description'
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Description'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDNutrition'
    quFreeSQL = quFreeSQL
    OnClickButton = quLookupNutritionClickButton
    Left = 903
    Top = 262
    object quLookupNutritionIDNutrition: TIntegerField
      FieldName = 'IDNutrition'
    end
    object quLookupNutritionDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object dsLookUpNutrition: TDataSource
    DataSet = quLookupNutrition
    Left = 901
    Top = 319
  end
  object quCalcTaxST: TADODataSet
    Connection = ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'(CASE IsNull(TCE.SituacaoTributaria, 0) WHEN 0 THEN IsN' +
      'ull(TC.SituacaoTributaria, 1) ELSE TCE.SituacaoTributaria END) a' +
      's T_SituacaoTributaria,'#13#10#9'E.IDEstado as EstadoCliente,'#13#10#9'S.IDEst' +
      'ado as EstadoLoja,'#13#10#9'TC.Tax as TaxCategoriaPer,'#13#10#9'E.TaxPerc as T' +
      'axEstadoPerc,'#13#10#9'NCM.MVAInterno,'#13#10#9'NCM.MVAInterestadual,'#13#10#9'E.TaxP' +
      'erc2 as T_AliquotaST,'#13#10#9'PIM.QTY as IM_QTY,'#13#10#9'CAST((PIM.Discount ' +
      '/ PIM.QTY) as money) as IM_Discount,'#13#10#9'PIM.SalePrice as IM_SaleP' +
      'rice'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'JOIN PreInventoryMov PIM (NOLO' +
      'CK) ON (PIM.DocumentID = I.IDPreSale and PIM.InventMovTypeID = 1' +
      ')'#13#10#9'JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)'#13#10#9'JOIN Ta' +
      'bGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )'#13#10#9'JOIN Pessoa C' +
      ' (NOLOCK) ON (C.IDPessoa = I.IDCustomer)'#13#10#9'JOIN Store S (NOLOCK)' +
      ' ON (S.IDStore = I.IDStore)'#13#10#9'LEFT JOIN Estado E (NOLOCK) ON (E.' +
      'IDEstado = C.IDEstado)'#13#10#13#10#9'LEFT JOIN StoreToTabGroup STG (NOLOCK' +
      ') ON (STG.IDStore = I.IDStore AND STG.IDGroup = M.GroupID)'#13#10#9'LEF' +
      'T JOIN TaxCategory TC (NOLOCK) ON (TC.IDTaxCategory = STG.IDSale' +
      'Tax AND TC.OperationType = 1 AND TC.SaleTaxType = 2)'#13#10#13#10#9'LEFT JO' +
      'IN Inv_ModelStateTax MST (NOLOCK) ON (MST.IDModel = M.IDModel AN' +
      'D MST.IDEstado = C.IDEstado)'#13#10#9'LEFT JOIN TaxCategory TCE (NOLOCK' +
      ') ON (TCE.IDTaxCategory = MST.IDTaxCategory AND TCE.OperationTyp' +
      'e = 1 AND TCE.SaleTaxType = 2)'#13#10#13#10#9'LEFT JOIN Inv_NCM NCM (NOLOCK' +
      ') ON (NCM.IDNCM = M.IDNCM)'#13#10'WHERE'#13#10#9'I.IDPreSale = :IDPreSale'
    CommandTimeout = 360
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 900
    Top = 10
    object quCalcTaxSTT_SituacaoTributaria: TIntegerField
      FieldName = 'T_SituacaoTributaria'
      ReadOnly = True
    end
    object quCalcTaxSTEstadoCliente: TStringField
      FieldName = 'EstadoCliente'
      FixedChar = True
      Size = 3
    end
    object quCalcTaxSTEstadoLoja: TStringField
      FieldName = 'EstadoLoja'
      FixedChar = True
      Size = 3
    end
    object quCalcTaxSTTaxCategoriaPer: TBCDField
      FieldName = 'TaxCategoriaPer'
      Precision = 19
    end
    object quCalcTaxSTTaxEstadoPerc: TBCDField
      FieldName = 'TaxEstadoPerc'
      Precision = 19
    end
    object quCalcTaxSTMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object quCalcTaxSTMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object quCalcTaxSTT_AliquotaST: TBCDField
      FieldName = 'T_AliquotaST'
      Precision = 19
    end
    object quCalcTaxSTIM_QTY: TBCDField
      FieldName = 'IM_QTY'
      Precision = 32
    end
    object quCalcTaxSTIM_Discount: TBCDField
      FieldName = 'IM_Discount'
      ReadOnly = True
      Precision = 19
    end
    object quCalcTaxSTIM_SalePrice: TBCDField
      FieldName = 'IM_SalePrice'
      Precision = 19
    end
  end
  object cmdUpdateSTTax: TADOCommand
    CommandText = 'UPDATE Invoice SET Tax = :Tax WHERE IDPreSale = :IDPreSale'
    Connection = ADODBConnect
    Parameters = <
      item
        Name = 'Tax'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 900
    Top = 55
  end
  object HTTPReqRespCatalog: THTTPReqResp
    Agent = 'Borland SOAP 1.2'
    UseUTF8InHeader = False
    InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Left = 897
    Top = 112
  end
end
