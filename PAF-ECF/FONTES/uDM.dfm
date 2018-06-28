inherited DM: TDM
  OldCreateOrder = True
  Left = 139
  Top = 176
  Height = 527
  Width = 848
  inherited spGetNextID: TADOStoredProc
    Top = 8
  end
  inherited ADODBConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=SupplyDB;Data Source=Desenv000;Use Proc' +
      'edure for Prepare=1;Auto Translate=True;Packet Size=4096;Worksta' +
      'tion ID=IGM013;Use Encryption for Data=False;Tag with column col' +
      'lation when possible=False'
    ConnectionTimeout = 360
    Left = 44
  end
  inherited quFreeSQL: TADOQuery
    Left = 244
    Top = 8
  end
  object quSrvParam: TADOQuery
    Connection = ADODBConnect
    Parameters = <>
    SQL.Strings = (
      'SELECT SrvParameter , SrvValue , SrvType , '
      ' Description , DefaultValue , IDParam'
      'FROM dbo.Param Param'
      'ORDER BY'
      ' IDParam')
    Left = 384
    Top = 8
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
  object dsLookUpUser: TDataSource
    DataSet = LookUpUser
    Left = 52
    Top = 180
  end
  object LookUpUser: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDUser , SystemUser'#13#10'FROM dbo.SystemUser (FastFirstRow NO' +
      'LOCK) ORDER BY SystemUser'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'SystemUser'
    CodeField = 'IDUser'
    LookUpField = 'IDUser'
    quFreeSQL = quFreeSQL
    Left = 52
    Top = 132
    object LookUpUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object LookUpUserSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
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
    Left = 156
    Top = 132
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
    Left = 156
    Top = 180
  end
  object quAccess: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Password'
        DataType = ftString
        Size = -1
        Value = ''
      end
      item
        Name = 'MenuID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'SubMenuID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'UR.CanAccess,'
      #9'SU.PW,'
      #9'UR.MenuID,'
      #9'UR.SubMenuID'
      'FROM SystemUser SU '
      'JOIN UserType UT ON ( SU.UserTypeID = UT.IDUserType )'
      'JOIN UserRights UR ON  ( UR.UserTypeID = UT.IDUserType )'
      ''
      'WHERE ( SU.PW = :Password ) '
      'AND   ( UR.MenuID = :MenuID ) '
      'AND   ( UR.SubMenuID = :SubMenuID )'
      'AND   ( SU.Desativado = 0 )'
      ' ')
    Left = 568
    Top = 72
    object quAccessCanAccess: TBooleanField
      FieldName = 'CanAccess'
    end
    object quAccessPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
    object quAccessMenuID: TIntegerField
      FieldName = 'MenuID'
    end
    object quAccessSubMenuID: TIntegerField
      FieldName = 'SubMenuID'
    end
  end
  object LookUpModel: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10'        IDModel,'#13#10'        Model,'#13#10'        Description'#13#10'F' +
      'ROM'#13#10'        Model (NOLOCK INDEX=XIE_Model_Combo)'#13#10'WHERE'#13#10#9'Model' +
      'Type IN ('#39'R'#39','#39'S'#39','#39'K'#39')'#13#10'ORDER BY'#13#10'        Model'#13#10' '#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    CodeFieldSearch = False
    LookUpField = 'IDModel'
    quFreeSQL = quFreeSQL
    Left = 368
    Top = 132
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
  end
  object dsLookUpModel: TDataSource
    DataSet = LookUpModel
    Left = 368
    Top = 180
  end
  object LookUpMeioPag: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDMeioPag,'#13#10#9'MeioPag,'#13#10#9'Tipo,'#13#10#9'CodFiscal,'#13#10#9'DescFiscal' +
      #13#10'FROM'#13#10#9'MeioPag (FastFirstRow NOLOCK)'#13#10'WHERE'#13#10#9'ParentType <> '#39'B' +
      'atch'#39#13#10'ORDER BY'#13#10#9'MeioPag'#13#10' '
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'MeioPag'
    CodeField = 'IDMeioPag'
    LookUpField = 'IDMeioPag'
    quFreeSQL = quFreeSQL
    Left = 272
    Top = 132
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
    object LookUpMeioPagCodFiscal: TStringField
      FieldName = 'CodFiscal'
      Size = 2
    end
    object LookUpMeioPagDescFiscal: TStringField
      FieldName = 'DescFiscal'
      Size = 16
    end
  end
  object dsLookUpMeioPag: TDataSource
    DataSet = LookUpMeioPag
    Left = 272
    Top = 180
  end
  object quLookUpStore: TLookUpADOQuery
    Connection = ADODBConnect
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
    quFreeSQL = quFreeSQL
    Left = 472
    Top = 132
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
    Left = 472
    Top = 180
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
    Left = 536
    Top = 8
  end
  object LookUpMedia: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDMedia , Media '#13#10'FROM dbo.Media (FastFirstRow NOLOCK)'#13#10'O' +
      'RDER BY'#13#10' Media'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Media'
    CodeField = 'IDMedia'
    LookUpField = 'IDMedia'
    quFreeSQL = quFreeSQL
    Left = 52
    Top = 240
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
    Left = 52
    Top = 292
  end
  object dsLookUpCustomer: TDataSource
    DataSet = LookUpCustomer
    Left = 156
    Top = 292
  end
  object LookUpCustomer: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10'        P.IDPessoa IDComissionado,'#13#10'      ' +
      '  P.Pessoa,'#13#10'        P.Code'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10'WHERE '#9 +
      #13#10#9'P.IDTipoPessoaRoot = 1'#13#10'ORDER BY P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    quFreeSQL = quFreeSQL
    Left = 156
    Top = 240
    object LookUpCustomerIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpCustomerIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpCustomerCode: TIntegerField
      FieldName = 'Code'
    end
    object LookUpCustomerPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object dsLookUpTipoCliente: TDataSource
    DataSet = LookUpTipoCliente
    Left = 272
    Top = 292
  end
  object LookUpTipoCliente: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoCliente , PathName '#13#10'FROM dbo.vwTipoCliente  (FastF' +
      'irstRow NOLOCK)'#13#10'ORDER BY'#13#10' PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'IDTipoCliente'
    LookUpField = 'IDTipoCliente'
    quFreeSQL = quFreeSQL
    Left = 272
    Top = 240
    object LookUpTipoClienteIDTipoCliente: TIntegerField
      FieldName = 'IDTipoCliente'
    end
    object LookUpTipoClientePathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  object LookUpTipoPessoa: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDTipoPessoa , PathName, Path'#13#10'FROM dbo.TipoPessoa  (Fast' +
      'FirstRow NOLOCK)'#13#10'ORDER BY'#13#10' PathName'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'PathName'
    CodeField = 'Path'
    LookUpField = 'IDTipoPessoa'
    quFreeSQL = quFreeSQL
    Left = 368
    Top = 240
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
    Left = 368
    Top = 292
  end
  object dsLookUpEstado: TDataSource
    DataSet = LookUpEstado
    Left = 472
    Top = 292
  end
  object LookUpEstado: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT IDEstado , Estado'#13#10'FROM dbo.Estado Estado (FastFirstRow N' +
      'OLOCK) '#13#10'ORDER BY Estado'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Estado'
    CodeField = 'IDEstado'
    LookUpField = 'IDEstado'
    quFreeSQL = quFreeSQL
    Left = 472
    Top = 240
    object LookUpEstadoIDEstado: TStringField
      FieldName = 'IDEstado'
      Size = 3
    end
    object LookUpEstadoEstado: TStringField
      FieldName = 'Estado'
      Size = 50
    end
  end
  object dsLookUpPais: TDataSource
    DataSet = LookUpPais
    Left = 564
    Top = 292
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
    Left = 564
    Top = 240
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
  object dsLookUpCashReg: TDataSource
    DataSet = LookUpCashReg
    Left = 564
    Top = 180
  end
  object LookUpCashReg: TLookUpADOQuery
    Connection = ADODBConnect
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
    quFreeSQL = quFreeSQL
    Left = 564
    Top = 132
    object LookUpCashRegIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object LookUpCashRegName: TStringField
      FieldName = 'Name'
      Size = 15
    end
  end
  object dsLookUpDeliverType: TDataSource
    DataSet = LookUpDeliverType
    Left = 676
    Top = 180
  end
  object LookUpDeliverType: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDDeliverType , Name'#13#10'FROM dbo.DeliverType (FastFirstRow ' +
      'NOLOCK) ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDDeliverType'
    LookUpField = 'IDDeliverType'
    quFreeSQL = quFreeSQL
    Left = 676
    Top = 132
    object LookUpDeliverTypeIDDeliverType: TIntegerField
      FieldName = 'IDDeliverType'
    end
    object LookUpDeliverTypeName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpOther: TDataSource
    DataSet = LookUpOther
    Left = 676
    Top = 292
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
    Left = 676
    Top = 240
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
  object EFiscal1: TEFiscal
    Pronto = False
    PortaSerial = 0
    OnTotalCupom = EFiscal1TotalCupom
    Operacao = False
    AfterReducaoZ = EFiscal1AfterReducaoZ
    AfterAbrirCupom = EFiscal1AfterAbrirCupom
    BeforeAbrirCupom = EFiscal1BeforeAbrirCupom
    AfterSuprimento = EFiscal1AfterSuprimento
    AfterAbreDiaFiscal = EFiscal1AfterAbreDiaFiscal
    AfterSangria = EFiscal1AfterSangria
    Left = 624
    Top = 8
  end
  object dsLookUpBank: TDataSource
    DataSet = LookUpBank
    Left = 768
    Top = 184
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
    Left = 768
    Top = 132
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
  object TEFDial1: TTEFDial
    BloqueiaTeclado = False
    RequisicaoAtual = rtATV
    LinhaVazia = ' '
    TEFDIALType = 1
    OnDialog = TEFDial1Dialog
    OnNeedOpenVinculado = TEFDial1NeedOpenVinculado
    OnNeedOpenGerencial = TEFDial1NeedOpenGerencial
    OnNeedCloseVinculado = TEFDial1NeedCloseVinculado
    OnNeedCloseGerencial = TEFDial1NeedCloseGerencial
    OnNeedPrintLineGerencial = TEFDial1NeedPrintLineGerencial
    OnNeedPrintLineVinculado = TEFDial1NeedPrintLineVinculado
    OnTryAgainDialog = TEFDial1TryAgainDialog
    OnStatusPrinter = TEFDial1StatusPrinter
    Left = 696
    Top = 8
  end
  object dspSrvParam: TDataSetProvider
    DataSet = quSrvParam
    Left = 384
    Top = 8
  end
  object cdsSrvParam: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSrvParam'
    Left = 384
    Top = 8
    object cdsSrvParamSrvParameter: TStringField
      FieldName = 'SrvParameter'
      Size = 30
    end
    object cdsSrvParamSrvValue: TStringField
      FieldName = 'SrvValue'
      Size = 30
    end
    object cdsSrvParamSrvType: TStringField
      FieldName = 'SrvType'
      Size = 10
    end
    object cdsSrvParamDescription: TStringField
      FieldName = 'Description'
      Size = 200
    end
    object cdsSrvParamDefaultValue: TStringField
      FieldName = 'DefaultValue'
      Size = 30
    end
    object cdsSrvParamIDParam: TIntegerField
      FieldName = 'IDParam'
    end
  end
  object quStore: TADOQuery
    Connection = ADODBConnect
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDStore,'
      #9'Name,'
      #9'TicketHeader,'
      #9'TicketLayawayFooter,'
      #9'TicketTaxIsemptFooter,'
      #9'TicketFooter,'
      #9'TicketDetail,'
      #9'TicketTotals,'
      #9'PrintTicketHeader,'
      #9'PrintLayawayFooter,'
      #9'PrintTaxInsemptFooter,'
      #9'PrintTicketFooter'
      'FROM'
      #9'Store'
      'WHERE'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0')
    Left = 296
    Top = 64
    object quStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quStoreTicketHeader: TMemoField
      FieldName = 'TicketHeader'
      BlobType = ftMemo
    end
    object quStoreTicketLayawayFooter: TMemoField
      FieldName = 'TicketLayawayFooter'
      BlobType = ftMemo
    end
    object quStoreTicketTaxIsemptFooter: TMemoField
      FieldName = 'TicketTaxIsemptFooter'
      BlobType = ftMemo
    end
    object quStoreTicketFooter: TMemoField
      FieldName = 'TicketFooter'
      BlobType = ftMemo
    end
    object quStoreTicketDetail: TMemoField
      FieldName = 'TicketDetail'
      BlobType = ftMemo
    end
    object quStoreTicketTotals: TMemoField
      FieldName = 'TicketTotals'
      BlobType = ftMemo
    end
    object quStorePrintTicketHeader: TBooleanField
      FieldName = 'PrintTicketHeader'
    end
    object quStorePrintLayawayFooter: TBooleanField
      FieldName = 'PrintLayawayFooter'
    end
    object quStorePrintTaxInsemptFooter: TBooleanField
      FieldName = 'PrintTaxInsemptFooter'
    end
    object quStorePrintTicketFooter: TBooleanField
      FieldName = 'PrintTicketFooter'
    end
  end
  object dspStore: TDataSetProvider
    DataSet = quStore
    Left = 308
    Top = 68
  end
  object cdsStore: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspStore'
    Left = 304
    Top = 76
    object cdsStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object cdsStoreTicketHeader: TMemoField
      FieldName = 'TicketHeader'
      BlobType = ftMemo
    end
    object cdsStoreTicketLayawayFooter: TMemoField
      FieldName = 'TicketLayawayFooter'
      BlobType = ftMemo
    end
    object cdsStoreTicketTaxIsemptFooter: TMemoField
      FieldName = 'TicketTaxIsemptFooter'
      BlobType = ftMemo
    end
    object cdsStoreTicketFooter: TMemoField
      FieldName = 'TicketFooter'
      BlobType = ftMemo
    end
    object cdsStoreTicketDetail: TMemoField
      FieldName = 'TicketDetail'
      BlobType = ftMemo
    end
    object cdsStoreTicketTotals: TMemoField
      FieldName = 'TicketTotals'
      BlobType = ftMemo
    end
    object cdsStorePrintTicketHeader: TBooleanField
      FieldName = 'PrintTicketHeader'
    end
    object cdsStorePrintLayawayFooter: TBooleanField
      FieldName = 'PrintLayawayFooter'
    end
    object cdsStorePrintTaxInsemptFooter: TBooleanField
      FieldName = 'PrintTaxInsemptFooter'
    end
    object cdsStorePrintTicketFooter: TBooleanField
      FieldName = 'PrintTicketFooter'
    end
  end
  object dsStore: TDataSource
    AutoEdit = False
    DataSet = cdsStore
    Left = 312
    Top = 80
  end
  object quSystemUser: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'SystemUser.UserTypeID, '
      #9'SystemUser.IDUser,'
      #9'SystemUser.SystemUser,'
      #9'SystemUser.ComissionID,'
      #9'SystemUser.StoresAccess,'
      #9'SystemUser.CodSystemUser,'
      #9'SystemUser.PW,'
      #9'Pessoa.IDTipoPessoa'
      'FROM'
      #9'SystemUser'
      #9'INNER JOIN Pessoa ON'
      #9#9'(SystemUser.ComissionID = Pessoa.IDPessoa)'
      'WHERE'
      #9'SystemUser.Desativado = 0'
      #9'AND'
      #9'SystemUser.Hidden = 0'
      #9'AND'
      #9'SystemUser.System = 0'
      '')
    Left = 456
    Top = 64
    object quSystemUserUserTypeID: TIntegerField
      FieldName = 'UserTypeID'
    end
    object quSystemUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quSystemUserSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quSystemUserComissionID: TIntegerField
      FieldName = 'ComissionID'
    end
    object quSystemUserStoresAccess: TStringField
      FieldName = 'StoresAccess'
      Size = 255
    end
    object quSystemUserPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
    object quSystemUserIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object quSystemUserCodSystemUser: TStringField
      FieldName = 'CodSystemUser'
    end
  end
  object dspSystemUser: TDataSetProvider
    DataSet = quSystemUser
    Left = 456
    Top = 64
  end
  object cdsSystemUser: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSystemUser'
    Left = 456
    Top = 64
    object cdsSystemUserUserTypeID: TIntegerField
      FieldName = 'UserTypeID'
    end
    object cdsSystemUserIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsSystemUserSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object cdsSystemUserComissionID: TIntegerField
      FieldName = 'ComissionID'
    end
    object cdsSystemUserStoresAccess: TStringField
      FieldName = 'StoresAccess'
      Size = 255
    end
    object cdsSystemUserPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
    object cdsSystemUserIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object cdsSystemUserCodSystemUser: TStringField
      FieldName = 'CodSystemUser'
    end
  end
  object dsSystemUser: TDataSource
    DataSet = cdsSystemUser
    Left = 468
    Top = 80
  end
  object quPreSale: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'I.IDPreSale,'#13#10#9'I.IDCustomer,'#13#10#9'I.IDStore,'#13#10#9'I.SaleCode,' +
      #13#10#9'I.OtherComissionID,'#13#10#9'I.DeliverTypeID,'#13#10#9'I.MediaID,'#13#10#9'I.IDTou' +
      'ristGroup,'#13#10#9'I.TaxIsent,'#13#10#9'I.Layaway,'#13#10#9'I.PreSaleDate,'#13#10#9'I.Invoi' +
      'ceDiscount,'#13#10#9'I.ItemDiscount,'#13#10#9'I.Note,'#13#10#9'I.AditionalExpenses,'#13#10 +
      #9'I.SubTotal,'#13#10#9'M.Media,'#13#10#9'P.Pessoa,'#13#10#9'P.Endereco,'#13#10#9'P.Bairro,'#13#10#9 +
      'P.Cidade,'#13#10#9'(CASE P.Juridico WHEN 1 THEN P.InscEstadual ELSE P.C' +
      'PF END) as CPF,'#13#10#9'P.Telefone'#13#10'FROM'#13#10#9'Invoice I'#13#10#9'JOIN Media M ON' +
      ' (M.IDMedia = I.MediaID)'#13#10#9'JOIN Pessoa P ON (P.IDPessoa = I.IDCu' +
      'stomer)'#13#10'WHERE'#13#10#9'I.SaleCode = :SaleCode'#13#10#9'AND'#13#10#9'I.IDPreSaleParen' +
      't IS NULL'#13#10#9'AND'#13#10#9'I.IDInvoice IS NULL'#13#10
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
    Left = 48
    Top = 364
    object quPreSaleIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quPreSaleIDCustomer: TIntegerField
      FieldName = 'IDCustomer'
    end
    object quPreSaleIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quPreSaleSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object quPreSaleOtherComissionID: TIntegerField
      FieldName = 'OtherComissionID'
    end
    object quPreSaleDeliverTypeID: TIntegerField
      FieldName = 'DeliverTypeID'
    end
    object quPreSaleMediaID: TIntegerField
      FieldName = 'MediaID'
    end
    object quPreSaleIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
    end
    object quPreSaleTaxIsent: TBooleanField
      FieldName = 'TaxIsent'
    end
    object quPreSaleLayaway: TBooleanField
      FieldName = 'Layaway'
    end
    object quPreSalePreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
    end
    object quPreSaleNote: TStringField
      FieldName = 'Note'
      Size = 150
    end
    object quPreSaleMedia: TStringField
      FieldName = 'Media'
      Size = 255
    end
    object quPreSalePessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quPreSaleEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object quPreSaleBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object quPreSaleCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object quPreSaleCPF: TStringField
      FieldName = 'CPF'
      Size = 30
    end
    object quPreSaleTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object quPreSaleInvoiceDiscount: TBCDField
      FieldName = 'InvoiceDiscount'
      Precision = 19
    end
    object quPreSaleItemDiscount2: TBCDField
      FieldName = 'ItemDiscount'
      Precision = 19
    end
    object quPreSaleAditionalExpenses: TBCDField
      FieldName = 'AditionalExpenses'
      Precision = 19
    end
    object quPreSaleSubTotal: TBCDField
      FieldName = 'SubTotal'
      Precision = 19
    end
  end
  object quPreSaleItem: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PIM.IDPreInventoryMov,'#13#10#9'PIM.UserID,'#13#10#9'PIM.StoreID,'#13#10#9'P' +
      'IM.ModelID,'#13#10#9'PIM.Discount,'#13#10#9'PIM.SalePrice,'#13#10#9'PIM.CostPrice,'#13#10#9 +
      'PIM.Qty,'#13#10#9' (CASE WHEN (TC.SpecialDateStart <= GetDate()) AND (T' +
      'C.SpecialDateEnd >= GetDate()) AND ( ISNULL((( ISNULL(PIM.SalePr' +
      'ice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.Ma' +
      'xItemValue, 0))'#13#10#9' THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Ta' +
      'x, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as TaxVa' +
      'lue,'#13#10#9'PIM.MovDate,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.LargeImage,'#13 +
      #10#9'TCI.IDTaxCategory,'#13#10#9'TG.PuppyTracker,'#13#10#9'TG.RequestCustomer,'#13#10#9 +
      'M.CaseQty,'#13#10#9'100.00 AS MaxDiscount,'#13#10#9'PIM.IDDepartment,'#13#10#9'IMP.ID' +
      'DescriptionPrice,'#13#10#9'IMP.IDVendor,'#13#10#9'IMP.SuggPrice,'#13#10#9'IMD.Documen' +
      'tNumber,'#13#10#9'IMD.IDDocumentType,'#13#10#9'U.Unidade,'#13#10#9'U.Sigla'#13#10'FROM'#13#10#9'Pr' +
      'eInventoryMov PIM'#13#10#9'JOIN Model M ON (M.IDModel = PIM.ModelID)'#13#10#9 +
      'JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )'#13#10#9'JOIN StoreToTab' +
      'Group STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.ID' +
      'Group )'#13#10#9'LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory =' +
      ' STC.IDTaxCategory )'#13#10#9'LEFT OUTER JOIN TaxCategory TCI ON ( TCI.' +
      'IDTaxCategory = STC.IDSaleTax )'#13#10#9'LEFT JOIN Inv_MovPrice IMP ON ' +
      '(PIM.IDPreInventoryMov = IMP.IDPreInventoryMov)'#13#10#9'LEFT JOIN Inv_' +
      'MovDocument IMD ON (PIM.IDPreInventoryMov = IMD.IDPreInventoryMo' +
      'v)'#13#10#9'LEFT OUTER JOIN Unidade U (NOLOCK) ON (U.IDUnidade = M.IDUn' +
      'idade)'#13#10'WHERE'#13#10#9'PIM.InventMovTypeID = 1'#13#10#9'AND PIM.DocumentID = :' +
      'IDPreSale'#13#10#9'AND PIM.IDParentPack Is Null'#13#10
    DataSource = dsPreSale
    MasterFields = 'IDPreSale'
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 92
    Top = 80
    object quPreSaleItemIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
    object quPreSaleItemUserID: TIntegerField
      FieldName = 'UserID'
    end
    object quPreSaleItemStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object quPreSaleItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quPreSaleItemDiscount: TBCDField
      FieldName = 'Discount'
      Precision = 19
    end
    object quPreSaleItemSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quPreSaleItemCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quPreSaleItemTaxValue: TBCDField
      FieldName = 'TaxValue'
      ReadOnly = True
      Precision = 19
    end
    object quPreSaleItemMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object quPreSaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPreSaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPreSaleItemLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
    object quPreSaleItemIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quPreSaleItemPuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
    end
    object quPreSaleItemRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
    end
    object quPreSaleItemCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object quPreSaleItemQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quPreSaleItemMaxDiscount: TFloatField
      FieldName = 'MaxDiscount'
      ReadOnly = True
    end
    object quPreSaleItemIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quPreSaleItemIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object quPreSaleItemIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quPreSaleItemSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      Precision = 19
    end
    object quPreSaleItemDocumentNumber: TStringField
      FieldName = 'DocumentNumber'
    end
    object quPreSaleItemIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object quPreSaleItemUnidade: TStringField
      FieldName = 'Unidade'
      Size = 100
    end
    object quPreSaleItemSigla: TStringField
      FieldName = 'Sigla'
      FixedChar = True
      Size = 4
    end
  end
  object dsPreSale: TDataSource
    DataSet = quPreSale
    Left = 56
    Top = 360
  end
  object cmdFreeSQL: TADOCommand
    CommandTimeout = 180
    Connection = ADODBConnect
    Parameters = <>
    Left = 244
    Top = 56
  end
  object quCashRegister: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDCashRegister, '
      #9'Name, '
      #9'IsAssociated'
      'FROM'
      #9'CashRegister'
      'WHERE'
      #9'Desativado = 0')
    Left = 696
    Top = 64
    object quCashRegisterIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object quCashRegisterName: TStringField
      FieldName = 'Name'
      Size = 15
    end
    object quCashRegisterIsAssociated: TBooleanField
      FieldName = 'IsAssociated'
    end
  end
  object dspCashRegister: TDataSetProvider
    DataSet = quCashRegister
    Left = 696
    Top = 64
  end
  object cdsCashRegister: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCashRegister'
    Left = 696
    Top = 64
    object cdsCashRegisterIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object cdsCashRegisterName: TStringField
      FieldName = 'Name'
      Size = 15
    end
    object cdsCashRegisterIsAssociated: TBooleanField
      FieldName = 'IsAssociated'
    end
  end
  object dsCashRegister: TDataSource
    DataSet = cdsCashRegister
    Left = 712
    Top = 80
  end
  object dspAccess: TDataSetProvider
    DataSet = quAccess
    Left = 568
    Top = 72
  end
  object cdsAccess: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'Password'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MenuID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'SubMenuID'
        ParamType = ptInput
      end>
    ProviderName = 'dspAccess'
    Left = 568
    Top = 72
    object cdsAccessCanAccess: TBooleanField
      FieldName = 'CanAccess'
    end
    object cdsAccessPW: TStringField
      FieldName = 'PW'
      Size = 10
    end
    object cdsAccessMenuID: TIntegerField
      FieldName = 'MenuID'
    end
    object cdsAccessSubMenuID: TIntegerField
      FieldName = 'SubMenuID'
    end
  end
  object quMedia: TADODataSet
    Connection = ADODBConnect
    CommandText = 'SELECT'#13#10#9'IDMedia,'#13#10#9'Media '#13#10'FROM'#13#10#9'Media'#13#10'ORDER BY'#13#10#9'Media'
    Parameters = <>
    Left = 376
    Top = 64
  end
  object dspMedia: TDataSetProvider
    DataSet = quMedia
    Left = 376
    Top = 64
  end
  object cdsMedia: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMedia'
    Left = 376
    Top = 64
    object cdsMediaIDMedia: TIntegerField
      FieldName = 'IDMedia'
      Visible = False
    end
    object cdsMediaMedia: TStringField
      FieldName = 'Media'
      Size = 255
    end
  end
  object dsMedia: TDataSource
    DataSet = cdsMedia
    Left = 384
    Top = 80
  end
  object quBanco: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDBanco, '#13#10#9'CodigoBanco, '#13#10#9'Banco'#13#10'FROM'#13#10#9' Fin_Banco'#13#10'W' +
      'HERE'#13#10#9'Desativado = 0'#13#10'ORDER BY'#13#10#9'Banco'
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 624
    Top = 64
  end
  object dspBanco: TDataSetProvider
    DataSet = quBanco
    Left = 624
    Top = 64
  end
  object cdsBanco: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDStore'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDModel'
        ParamType = ptInput
      end>
    ProviderName = 'dspBanco'
    Left = 624
    Top = 64
    object cdsBancoIDBanco: TIntegerField
      FieldName = 'IDBanco'
    end
    object cdsBancoCodigoBanco: TStringField
      FieldName = 'CodigoBanco'
    end
    object cdsBancoBanco: TStringField
      FieldName = 'Banco'
      Size = 35
    end
  end
  object dsBanco: TDataSource
    DataSet = cdsBanco
    Left = 632
    Top = 80
  end
  object quKitModel: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 'SELECT'#13#10#9'IDModel,'#13#10#9'Qty,'#13#10#9'SellingPrice'#13#10'FROM '#9#13#10#9' KitModel'#13#10
    Parameters = <>
    Left = 588
    Top = 340
  end
  object dspKitModel: TDataSetProvider
    DataSet = quKitModel
    Left = 588
    Top = 344
  end
  object cdsKitModel: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspKitModel'
    Left = 588
    Top = 344
    object cdsKitModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsKitModelSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object cdsKitModelQty: TBCDField
      FieldName = 'Qty'
      Precision = 32
    end
  end
  object quSaleItemCommission: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDPreInventoryMov,'#13#10#9'IDCommission'#13#10'FROM'#13#10#9'SaleItemCommi' +
      'ssion'#13#10'WHERE'#13#10#9'IDPreInventoryMov = :IDPreInventoryMov'#13#10
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 180
    Top = 80
    object quSaleItemCommissionIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
    object quSaleItemCommissionIDCommission: TIntegerField
      FieldName = 'IDCommission'
    end
  end
  object TEFDedicado1: TTEFDedicado
    IPServidor = 'localhost'
    CodigoLoja = '00000000'
    NumeroTerminal = 'SE000001'
    LinhaVazia = ' '
    MensagemPinPad = 'MainRetail 3'
    BloqueiaTeclado = False
    OnExecutaComando4 = TEFDedicado1ExecutaComando4
    OnExecutaComando14 = TEFDedicado1ExecutaComando14
    OnExecutaComando20 = TEFDedicado1ExecutaComando20
    OnExecutaComando21 = TEFDedicado1ExecutaComando21
    OnExecutaComando23 = TEFDedicado1ExecutaComando23
    OnExecutaComando30 = TEFDedicado1ExecutaComando30
    OnExecutaComando31 = TEFDedicado1ExecutaComando31
    OnExecutaComando34 = TEFDedicado1ExecutaComando34
    OnExecutaComandoSenha = TEFDedicado1ExecutaComandoSenha
    OnNeedOpenVinculado = TEFDial1NeedOpenVinculado
    OnNeedOpenGerencial = TEFDial1NeedOpenGerencial
    OnNeedCloseVinculado = TEFDial1NeedCloseVinculado
    OnNeedCloseGerencial = TEFDial1NeedCloseGerencial
    OnNeedPrintLineGerencial = TEFDial1NeedPrintLineGerencial
    OnNeedPrintLineVinculado = TEFDial1NeedPrintLineVinculado
    OnTryAgainDialog = TEFDial1TryAgainDialog
    OnStatusPrinter = TEFDial1StatusPrinter
    Left = 272
    Top = 352
  end
  object quDocumentType: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDDocumentType,'
      #9'DocumentType,'
      #9'DefaultType'
      'FROM'
      #9'Mnt_DocumentType')
    Left = 712
    Top = 348
    object quDocumentTypeIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object quDocumentTypeDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object quDocumentTypeDefaultType: TBooleanField
      FieldName = 'DefaultType'
    end
  end
  object dspDocumentType: TDataSetProvider
    DataSet = quDocumentType
    Left = 712
    Top = 348
  end
  object cdsDocumentType: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentType'
    Left = 712
    Top = 348
    object cdsDocumentTypeIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object cdsDocumentTypeDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object cdsDocumentTypeDefaultType: TBooleanField
      FieldName = 'DefaultType'
    end
  end
  object dsDocumentType: TDataSource
    DataSet = cdsDocumentType
    Left = 712
    Top = 348
  end
  object quPreSerialMov: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PreInventoryMovID,'#13#10#9'SerialNumber,'#13#10#9'IdentificationNumb' +
      'er'#13#10'FROM'#13#10#9'PreSerialMov'#13#10'WHERE'#13#10#9'PreInventoryMovID = :IDPreInven' +
      'toryMov'#13#10
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 140
    Top = 56
  end
  object quMovDocument: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDPreInventoryMov,'#13#10#9'DocumentNumber,'#13#10#9'IDDocumentType,'#13 +
      #10#9'OBS'#13#10'FROM'#13#10#9'Inv_MovDocument'#13#10'WHERE'#13#10#9'IDPreInventoryMov = :IDPr' +
      'eInventoryMov'#13#10
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 216
    Top = 56
  end
  object quCheckPayments: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IsNull(SUM(F.ValorNominal), 0 ) as AmountPaid,'#13#10#9'I.IDPr' +
      'eSale,'#13#10#9'I.Layaway'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'LEFT JOIN Fin_La' +
      'ncamento F (NOLOCK) ON (F.IDPreSale = I.IDPreSale)'#13#10'WHERE'#13#10#9'I.Sa' +
      'leCode = :SaleCode'#13#10#9'AND'#13#10#9'I.IDInvoice IS NULL'#13#10'GROUP BY'#13#10#9'I.IDP' +
      'reSale,'#13#10#9'I.Layaway'#13#10#13#10
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
    Left = 152
    Top = 356
    object quCheckPaymentsAmountPaid: TBCDField
      FieldName = 'AmountPaid'
      ReadOnly = True
      Precision = 19
    end
    object quCheckPaymentsIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quCheckPaymentsLayaway: TBooleanField
      FieldName = 'Layaway'
    end
  end
  object quCashRegLogReason: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDCashRegLogReason,'
      #9'Reason'
      'FROM'
      #9'CashRegLogReason'
      'WHERE'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0'
      'ORDER BY'
      #9'Reason')
    Left = 372
    Top = 352
    object quCashRegLogReasonIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object quCashRegLogReasonReason: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
  object dspCashRegLogReason: TDataSetProvider
    DataSet = quCashRegLogReason
    Left = 372
    Top = 352
  end
  object cdsCashRegLogReason: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCashRegLogReason'
    Left = 372
    Top = 352
    object cdsCashRegLogReasonIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object cdsCashRegLogReasonReason: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
  object dsCashRegLogReason: TDataSource
    AutoEdit = False
    DataSet = cdsCashRegLogReason
    Left = 372
    Top = 352
  end
  object quNegativeItems: TADODataSet
    Connection = ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PIM.IDPreInventoryMov'#13#10'FROM'#13#10#9'PreInventoryMov PIM (NOLO' +
      'CK)'#13#10#9'JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID)'#13 +
      #10'WHERE'#13#10#9'I.SaleCode = :SaleCode'#13#10#9'AND'#13#10#9'PIM.InventMovTypeID = 1'#13 +
      #10#9'AND'#13#10#9'PIM.Qty <= 0'#13#10#9'AND'#13#10#9'I.IDInvoice IS NULL'#13#10#13#10#13#10
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
    Left = 52
    Top = 424
    object quNegativeItemsIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
  end
end
