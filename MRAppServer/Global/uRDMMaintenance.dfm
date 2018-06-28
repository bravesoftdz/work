object RDMMaintenance: TRDMMaintenance
  OldCreateOrder = False
  Left = 328
  Top = 138
  Height = 475
  Width = 623
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=MainRetailDB;Data Source=.'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 16
  end
  object ctEstado: TmrConfigTable
    DataSetProvider = dspEstado
    LogicalDeleteField = 'Desativado'
    TableName = 'Estado'
    Left = 44
    Top = 80
  end
  object qryEstado: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDEstado,'
      #9'Estado,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Estado'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 44
    Top = 128
    object qryEstadoIDEstado: TStringField
      DisplayLabel = 'State Code'
      FieldName = 'IDEstado'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryEstadoEstado: TStringField
      DisplayLabel = 'State'
      FieldName = 'Estado'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryEstadoHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryEstadoDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspEstado: TDataSetProvider
    DataSet = qryEstado
    Options = [poIncFieldProps]
    Left = 44
    Top = 180
  end
  object ctPais: TmrConfigTable
    DataSetProvider = dspPais
    IdentityField = 'IDPais'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pais'
    HiddenFields.Strings = (
      'IDPais')
    Left = 136
    Top = 80
  end
  object qryPais: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDPais,'
      #9'CodPais,'
      #9'Pais,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pais'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 136
    Top = 128
    object qryPaisIDPais: TIntegerField
      DisplayLabel = 'IDCountry'
      FieldName = 'IDPais'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPaisCodPais: TStringField
      DisplayLabel = 'Country Code'
      FieldName = 'CodPais'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 3
    end
    object qryPaisPais: TStringField
      DisplayLabel = 'Country'
      FieldName = 'Pais'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryPaisSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPaisHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPaisDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspPais: TDataSetProvider
    DataSet = qryPais
    Options = [poIncFieldProps]
    Left = 136
    Top = 180
  end
  object ctTipoPessoa: TmrConfigTable
    DataSetProvider = dspTipoPessoa
    DependentTables.Strings = (
      'IDTipoPessoa'
      'Path')
    IdentityField = 'IDTipoPessoa'
    LogicalDeleteField = 'Desativado'
    TableName = 'TipoPessoa'
    HiddenFields.Strings = (
      'IDTipoPessoa'
      'Path'
      'PathName')
    Left = 232
    Top = 80
  end
  object qryTipoPessoa: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDTipoPessoa,'
      #9'Path,'
      #9'TipoPessoa,'
      #9'PathName,'
      #9'LastCode,'
      #9'ComissionOnProfit,'
      #9'DefaultDiaPag,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'TipoPessoa'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 232
    Top = 130
    object qryTipoPessoaIDTipoPessoa: TIntegerField
      DisplayLabel = 'IDEntityType'
      FieldName = 'IDTipoPessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryTipoPessoaPath: TStringField
      FieldName = 'Path'
      ProviderFlags = [pfInUpdate]
      Size = 150
    end
    object qryTipoPessoaTipoPessoa: TStringField
      FieldName = 'TipoPessoa'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryTipoPessoaPathName: TStringField
      FieldName = 'PathName'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object qryTipoPessoaLastCode: TIntegerField
      FieldName = 'LastCode'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTipoPessoaComissionOnProfit: TBooleanField
      FieldName = 'ComissionOnProfit'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTipoPessoaDefaultDiaPag: TIntegerField
      FieldName = 'DefaultDiaPag'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTipoPessoaSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTipoPessoaHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTipoPessoaDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspTipoPessoa: TDataSetProvider
    DataSet = qryTipoPessoa
    Options = [poIncFieldProps]
    Left = 232
    Top = 182
  end
  object ctPessoa: TmrConfigTable
    DataSetProvider = dspPessoa
    IdentityField = 'IDPessoa'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pessoa'
    TableNamePrefix = 'P'
    HiddenFields.Strings = (
      'IDPais'
      'IDPessoa'
      'IDTipoPessoa'
      'UserCode'
      'PessoaLastName'
      'PessoaFirstName'
      'Bairro'
      'SalesTaxExempt'
      'PhoneAreaCode'
      'Telefone'
      'CellAreaCode'
      'Cellular'
      'Fax'
      'Email'
      'Beeper'
      'HomePage'
      'Identidade'
      'OrgaoEmissor'
      'DataExpedicao'
      'Nascimento'
      'CPF'
      'CustomerCard'
      'CartMotorista'
      'NomeJuridico'
      'InscEstadual'
      'InscMunicipal'
      'Contato'
      'CartTrabalho'
      'Juridico'
      'TipoPessoa'
      'Path')
    OnBeforeUpdateRecords = ctPessoaBeforeUpdateRecords
    OnNewRecord = ctPessoaNewRecord
    Left = 328
    Top = 80
  end
  object qryPessoa: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      ''
      'SELECT '
      #9'P.IDPessoa, '
      #9'P.IDTipoPessoa, '
      #9'P.IDEstado,'
      #9'P.IDPais,'
      #9'P.IDStore,'
      #9'P.IDUser,'
      #9'P.Code, '
      #9'P.UserCode,'
      #9'P.Pessoa, '
      #9'P.PessoaLastName,'
      #9'P.PessoaFirstName, '
      #9'P.Endereco, '
      #9'P.Bairro,'
      #9'P.Cidade, '
      #9'P.CEP, '
      #9'P.SalesTaxExempt,'
      #9'P.PhoneAreaCode,'
      #9'P.Telefone, '
      #9'P.CellAreaCode,'
      #9'P.Cellular,'
      #9'P.Fax, '
      #9'P.Email, '
      #9'P.Beeper,'
      #9'P.HomePage,'
      #9'P.Identidade,'
      #9'P.OrgaoEmissor,'
      #9'P.DataExpedicao,'
      #9'P.Nascimento,'
      #9'P.CPF, '
      #9'P.CustomerCard,'
      #9'P.CartMotorista,'
      #9'P.NomeJuridico,'
      #9'P.InscEstadual, '
      #9'P.InscMunicipal, '
      #9'P.Contato, '
      #9'P.CartTrabalho,'
      #9'P.Juridico,'
      #9'P.System, '
      #9'P.Desativado, '
      #9'P.Hidden,'
      #9'TP.TipoPessoa,'
      #9'TP.Path'
      'FROM '
      #9'Pessoa P'
      #9'Join TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'P.System = 0'
      #9'AND P.Desativado = 0'
      #9'AND P.Hidden = 0')
    Left = 328
    Top = 130
    object qryPessoaIDPessoa: TIntegerField
      DisplayLabel = 'IDEntity'
      FieldName = 'IDPessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPessoaIDTipoPessoa: TIntegerField
      DisplayLabel = 'IDEntityType'
      FieldName = 'IDTipoPessoa'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPessoaIDStore: TIntegerField
      FieldName = 'IDStore'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPessoaIDUser: TIntegerField
      FieldName = 'IDUser'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPessoaIDPais: TIntegerField
      DisplayLabel = 'IDCountry'
      FieldName = 'IDPais'
      ProviderFlags = [pfInUpdate]
    end
    object qryPessoaIDEstado: TStringField
      DisplayLabel = 'State'
      FieldName = 'IDEstado'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryPessoaCode: TIntegerField
      FieldName = 'Code'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPessoaUserCode: TStringField
      FieldName = 'UserCode'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object qryPessoaPessoa: TStringField
      DisplayLabel = 'Name'
      FieldName = 'Pessoa'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPessoaPessoaLastName: TStringField
      DisplayLabel = 'Last Name'
      FieldName = 'PessoaLastName'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaPessoaFirstName: TStringField
      DisplayLabel = 'First Name'
      FieldName = 'PessoaFirstName'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaEndereco: TStringField
      DisplayLabel = 'Address'
      FieldName = 'Endereco'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 80
    end
    object qryPessoaBairro: TStringField
      DisplayLabel = 'Neighborwood'
      FieldName = 'Bairro'
      ProviderFlags = [pfInUpdate]
      Visible = False
      Size = 50
    end
    object qryPessoaCidade: TStringField
      DisplayLabel = 'City'
      FieldName = 'Cidade'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 40
    end
    object qryPessoaCEP: TStringField
      DisplayLabel = 'Zip'
      FieldName = 'CEP'
      ProviderFlags = [pfInUpdate]
      Required = True
      FixedChar = True
      Size = 12
    end
    object qryPessoaSalesTaxExempt: TBooleanField
      FieldName = 'SalesTaxExempt'
      ProviderFlags = [pfInUpdate]
    end
    object qryPessoaPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object qryPessoaTelefone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'Telefone'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 40
    end
    object qryPessoaCellAreaCode: TStringField
      FieldName = 'CellAreaCode'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object qryPessoaCellular: TStringField
      DisplayLabel = 'Cell'
      FieldName = 'Cellular'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 18
    end
    object qryPessoaFax: TStringField
      FieldName = 'Fax'
      ProviderFlags = [pfInUpdate]
      Size = 40
    end
    object qryPessoaEmail: TStringField
      FieldName = 'Email'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryPessoaBeeper: TStringField
      FieldName = 'Beeper'
      ProviderFlags = [pfInUpdate]
      FixedChar = True
      Size = 25
    end
    object qryPessoaHomePage: TStringField
      FieldName = 'HomePage'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object qryPessoaIdentidade: TStringField
      DisplayLabel = 'Social Security'
      FieldName = 'Identidade'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaOrgaoEmissor: TStringField
      DisplayLabel = 'SCGov'
      FieldName = 'OrgaoEmissor'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPessoaDataExpedicao: TDateTimeField
      DisplayLabel = 'SCDate'
      FieldName = 'DataExpedicao'
      ProviderFlags = [pfInUpdate]
    end
    object qryPessoaNascimento: TDateTimeField
      DisplayLabel = 'BirthDate'
      FieldName = 'Nascimento'
      ProviderFlags = [pfInUpdate]
    end
    object qryPessoaCPF: TStringField
      DisplayLabel = 'Employee ID'
      FieldName = 'CPF'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaCustomerCard: TStringField
      DisplayLabel = 'Customer Card'
      FieldName = 'CustomerCard'
      ProviderFlags = [pfInUpdate]
    end
    object qryPessoaCartMotorista: TStringField
      DisplayLabel = 'Driver License'
      FieldName = 'CartMotorista'
      ProviderFlags = [pfInUpdate]
      Size = 15
    end
    object qryPessoaNomeJuridico: TStringField
      DisplayLabel = 'DBA'
      FieldName = 'NomeJuridico'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPessoaInscEstadual: TStringField
      DisplayLabel = 'Federal ID'
      FieldName = 'InscEstadual'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaInscMunicipal: TStringField
      DisplayLabel = 'Sales Tax'
      FieldName = 'InscMunicipal'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaContato: TStringField
      DisplayLabel = 'Contact'
      FieldName = 'Contato'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPessoaCartTrabalho: TStringField
      DisplayLabel = 'Job Doc'
      FieldName = 'CartTrabalho'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPessoaJuridico: TBooleanField
      DisplayLabel = 'Is Company'
      FieldName = 'Juridico'
      ProviderFlags = [pfInUpdate]
    end
    object qryPessoaSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPessoaDesativado: TIntegerField
      DisplayLabel = 'Deleted'
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPessoaHidden: TIntegerField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPessoaTipoPessoa: TStringField
      DisplayLabel = 'Entity Type'
      FieldName = 'TipoPessoa'
      ProviderFlags = []
      Size = 50
    end
    object qryPessoaPath: TStringField
      FieldName = 'Path'
      ProviderFlags = []
      Size = 150
    end
  end
  object dspPessoa: TDataSetProvider
    DataSet = qryPessoa
    Options = [poIncFieldProps]
    Left = 328
    Top = 182
  end
  object ctPropertDomain: TmrConfigTable
    DataSetProvider = dspPropertDomain
    TableName = 'Sis_PropertyDomain'
    Left = 424
    Top = 76
  end
  object qryPropertDomain: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'Property,'
      #9'PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain')
    Left = 424
    Top = 126
    object qryPropertDomainProperty: TStringField
      FieldName = 'Property'
      Size = 255
    end
    object qryPropertDomainPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object dspPropertDomain: TDataSetProvider
    DataSet = qryPropertDomain
    Options = [poIncFieldProps]
    Left = 424
    Top = 178
  end
  object ctSystemUser: TmrConfigTable
    DataSetProvider = dspSystemUser
    IdentityField = 'IDUser'
    LogicalDeleteField = 'Desativado'
    TableName = 'SystemUser'
    HiddenFields.Strings = (
      'IDUser'
      'CodSystemUser')
    Left = 528
    Top = 80
  end
  object qrySystemUser: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'SU.IDUser,'
      #9'SU.UserTypeID,'
      #9'SU.CodSystemUser,'
      #9'SU.ComissionID,'
      #9'SU.SystemUser,'
      #9'SU.PW,'
      #9'SU.Desativado,'
      #9'SU.Hidden,'
      #9'SU.System'
      'FROM'
      #9'SystemUser SU'
      'WHERE'
      #9'SU.Desativado = 0'
      #9'AND SU.Hidden = 0'
      #9'AND SU.System = 0'
      ''
      '')
    Left = 528
    Top = 128
    object qrySystemUserIDUser: TIntegerField
      FieldName = 'IDUser'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qrySystemUserUserTypeID: TIntegerField
      FieldName = 'UserTypeID'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qrySystemUserCodSystemUser: TStringField
      DisplayLabel = 'Code'
      FieldName = 'CodSystemUser'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qrySystemUserComissionID: TIntegerField
      FieldName = 'ComissionID'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qrySystemUserSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qrySystemUserPW: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PW'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
      Size = 10
    end
    object qrySystemUserDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qrySystemUserHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qrySystemUserSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspSystemUser: TDataSetProvider
    DataSet = qrySystemUser
    Options = [poIncFieldProps]
    Left = 528
    Top = 180
  end
  object ctSysModule: TmrConfigTable
    DataSetProvider = dspSysModule
    TableName = 'Sys_Module'
    Left = 44
    Top = 244
  end
  object qrySysModule: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'ModuleInfo,'
      #9'VersionNo,'
      #9'BuildNo,'
      #9'Seats,'
      #9'VersionType,'
      #9'RestricForms'
      'FROM'
      #9'Sys_Module')
    Left = 44
    Top = 292
    object qrySysModuleModuleInfo: TStringField
      FieldName = 'ModuleInfo'
      Size = 255
    end
    object qrySysModuleVersionNo: TIntegerField
      FieldName = 'VersionNo'
    end
    object qrySysModuleBuildNo: TIntegerField
      FieldName = 'BuildNo'
    end
    object qrySysModuleSeats: TStringField
      FieldName = 'Seats'
      Size = 50
    end
    object qrySysModuleVersionType: TStringField
      FieldName = 'VersionType'
      Size = 15
    end
    object qrySysModuleRestricForms: TMemoField
      FieldName = 'RestricForms'
      BlobType = ftMemo
    end
  end
  object dspSysModule: TDataSetProvider
    DataSet = qrySysModule
    Options = [poIncFieldProps]
    Left = 44
    Top = 344
  end
  object dspParam: TDataSetProvider
    DataSet = qryParam
    Left = 136
    Top = 348
  end
  object ctParam: TmrConfigTable
    DataSetProvider = dspParam
    TableName = 'Param'
    Left = 136
    Top = 248
  end
  object qryParam: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDParam,'
      #9'SrvParameter,'
      #9'SrvValue,'
      #9'SrvType,'
      #9'IDMenu'
      'FROM '
      #9'Param'
      'WHERE'
      #9'Desativado = 0'
      '')
    Left = 136
    Top = 296
    object qryParamIDParam: TIntegerField
      FieldName = 'IDParam'
    end
    object qryParamSrvParameter: TStringField
      FieldName = 'SrvParameter'
      Size = 40
    end
    object qryParamSrvValue: TStringField
      FieldName = 'SrvValue'
      Size = 30
    end
    object qryParamSrvType: TStringField
      FieldName = 'SrvType'
      FixedChar = True
      Size = 10
    end
    object qryParamIDMenu: TIntegerField
      FieldName = 'IDMenu'
    end
  end
  object ctPayment: TmrConfigTable
    DataSetProvider = dspPayment
    IdentityField = 'IDMeioPag'
    LogicalDeleteField = 'Desativado'
    TableName = 'MeioPag'
    HiddenFields.Strings = (
      'IDUser'
      'CodSystemUser')
    Left = 233
    Top = 245
  end
  object qryPayment: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDMeioPag,'
      #9'IDLancamentoTipo,'
      #9'MeioPag,'
      #9'Tipo'
      'FROM'
      #9'MeioPag'
      'WHERE'
      #9'Tipo IN (1,2,4,7)')
    Left = 233
    Top = 293
    object qryPaymentIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object qryPaymentIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object qryPaymentMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object qryPaymentTipo: TIntegerField
      FieldName = 'Tipo'
    end
  end
  object dspPayment: TDataSetProvider
    DataSet = qryPayment
    Options = [poIncFieldProps]
    Left = 233
    Top = 345
  end
end
