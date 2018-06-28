inherited FinLancamentoDesdobramentoFch: TFinLancamentoDesdobramentoFch
  Left = 144
  Top = 144
  Caption = 'FinLancamentoDesdobramentoFch'
  PixelsPerInch = 96
  TextHeight = 13
  object lblLancamentoTipo: TLabel [0]
    Left = 32
    Top = 63
    Width = 68
    Height = 13
    Alignment = taRightJustify
    Caption = 'Record Type :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel [1]
    Left = 394
    Top = 60
    Width = 18
    Height = 18
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object lblValorNominal: TLabel [2]
    Left = 54
    Top = 106
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Amount :'
    FocusControl = deValorNominal
  end
  object Label13: TLabel [3]
    Left = 234
    Top = 103
    Width = 22
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '*'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -21
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label1: TLabel [4]
    Left = 60
    Top = 143
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Memo :'
    FocusControl = deValorNominal
  end
  inherited pnlPTitulo: TPanel
    inherited lblPTituloShadow: TLabel
      Width = 163
      Caption = 'Disbursement'
    end
    inherited lblPTitulo: TLabel
      Width = 163
      Caption = 'Disbursement'
    end
  end
  object scLancamentoTipo: TDBSuperComboADO [11]
    Left = 110
    Top = 59
    Width = 283
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = 'scLancamentoTipo'
    CodeLength = 70
    LookUpSource = DM.dsLULancamentoTipo
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    ShowEditCode = True
    DataField = 'IDLancamentoTipo'
    DataSource = dsForm
  end
  object deValorNominal: TDBEdit [12]
    Left = 110
    Top = 99
    Width = 121
    Height = 26
    DataField = 'ValorNominal'
    DataSource = dsForm
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object DBMemo1: TDBMemo [13]
    Left = 111
    Top = 137
    Width = 285
    Height = 100
    DataField = 'Historico'
    DataSource = dsForm
    TabOrder = 12
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FinLancamentoDesdobramentoFch.sil'
  end
  inherited quForm: TPowerADOQuery
    AfterOpen = quFormAfterOpen
    CommandText = 
      'SELECT '#13#10#9'L.IDLancamento,'#13#10#9'L.IDEmpresa,'#13#10#9'L.Previsao,'#13#10#9'L.IDDoc' +
      'umentoTipo,'#13#10#9'L.IDDesdobramentoTipo,'#13#10#9'L.NumeroRepeticoes,'#13#10#9'L.P' +
      'eriodicidadeRepeticoes,'#13#10#9'L.DiaRepeticoes,'#13#10#9'L.DataPrimeiraRepet' +
      'icao,'#13#10#9'L.IDMoedaCotacao,'#13#10#9'L.IDMoeda,'#13#10#9'L.IDUsuarioAprovacao,'#13#10 +
      #9'L.DataAprovacao,'#13#10#9'L.IDCentroCusto,'#13#10#9'L.IDPessoaTipo,'#13#10#9'L.Situa' +
      'cao,'#13#10#9'L.IDPessoa,'#13#10#9'L.DataLancamento,'#13#10#9'L.IDLancamentoTipo,'#13#10#9'L' +
      '.DataVencimento,'#13#10#9'L.DataInicioQuitacao,'#13#10#9'L.DataFimQuitacao,'#13#10#9 +
      'L.DataProtesto,'#13#10#9'L.Pagando,'#13#10#9'L.ValorNominal,'#13#10#9'L.TotalQuitado,' +
      #13#10#9'L.TotalJuros, '#13#10#9'L.NumDocumento,'#13#10#9'L.NumDesdobramento,'#13#10#9'L.Nu' +
      'mMeioQuitPrevisto, '#13#10#9'L.IDQuitacaoMeioPrevisto,'#13#10#9'L.IDContaCorre' +
      'ntePrevista,'#13#10#9'L.Desativado,'#13#10#9'L.Hidden,'#13#10#9'L.System,'#13#10#9'L.IDUsuar' +
      'ioLancamento,'#13#10#9'L.IDUsuarioProtesto,'#13#10#9'L.NumeroDuplicata,'#13#10#9'L.Da' +
      'taEmissao,'#13#10#9'L.IDLancamentoOriginal,'#13#10#9'L.DataVencimentoOriginal,' +
      #13#10#9'L.Historico,'#13#10#9'L.FavorecidoPrevisto, '#13#10#9'L.IDPreSale,'#13#10#9'L.IDLa' +
      'ncamentoParent,'#13#10#9'L.LancamentoType'#13#10'FROM '#13#10#9'Fin_Lancamento L'#13#10'WH' +
      'ERE '#13#10#9'L.IDLancamento = :IDLancamento'
    Parameters = <
      item
        Name = 'IDLancamento'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    object quFormIDLancamento: TAutoIncField
      FieldName = 'IDLancamento'
    end
    object quFormIDEmpresa: TIntegerField
      FieldName = 'IDEmpresa'
    end
    object quFormPrevisao: TBooleanField
      FieldName = 'Previsao'
    end
    object quFormIDDocumentoTipo: TIntegerField
      DisplayLabel = 'Document Type'
      FieldName = 'IDDocumentoTipo'
    end
    object quFormIDDesdobramentoTipo: TIntegerField
      FieldName = 'IDDesdobramentoTipo'
    end
    object quFormNumeroRepeticoes: TIntegerField
      FieldName = 'NumeroRepeticoes'
    end
    object quFormPeriodicidadeRepeticoes: TIntegerField
      FieldName = 'PeriodicidadeRepeticoes'
    end
    object quFormDiaRepeticoes: TIntegerField
      FieldName = 'DiaRepeticoes'
    end
    object quFormDataPrimeiraRepeticao: TDateTimeField
      FieldName = 'DataPrimeiraRepeticao'
    end
    object quFormIDMoedaCotacao: TIntegerField
      FieldName = 'IDMoedaCotacao'
    end
    object quFormIDMoeda: TIntegerField
      FieldName = 'IDMoeda'
    end
    object quFormIDUsuarioAprovacao: TIntegerField
      FieldName = 'IDUsuarioAprovacao'
    end
    object quFormDataAprovacao: TDateTimeField
      FieldName = 'DataAprovacao'
    end
    object quFormIDCentroCusto: TIntegerField
      FieldName = 'IDCentroCusto'
    end
    object quFormIDPessoaTipo: TIntegerField
      FieldName = 'IDPessoaTipo'
    end
    object quFormSituacao: TIntegerField
      FieldName = 'Situacao'
    end
    object quFormIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quFormDataLancamento: TDateTimeField
      FieldName = 'DataLancamento'
    end
    object quFormIDLancamentoTipo: TIntegerField
      DisplayLabel = 'Record Type'
      FieldName = 'IDLancamentoTipo'
      Required = True
    end
    object quFormDataVencimento: TDateTimeField
      FieldName = 'DataVencimento'
    end
    object quFormDataInicioQuitacao: TDateTimeField
      FieldName = 'DataInicioQuitacao'
    end
    object quFormDataFimQuitacao: TDateTimeField
      FieldName = 'DataFimQuitacao'
    end
    object quFormDataProtesto: TDateTimeField
      FieldName = 'DataProtesto'
    end
    object quFormPagando: TBooleanField
      FieldName = 'Pagando'
    end
    object quFormValorNominal: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'ValorNominal'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormTotalQuitado: TBCDField
      FieldName = 'TotalQuitado'
      Precision = 19
    end
    object quFormTotalJuros: TBCDField
      FieldName = 'TotalJuros'
      Precision = 19
    end
    object quFormNumDocumento: TStringField
      FieldName = 'NumDocumento'
    end
    object quFormNumDesdobramento: TStringField
      FieldName = 'NumDesdobramento'
    end
    object quFormNumMeioQuitPrevisto: TStringField
      FieldName = 'NumMeioQuitPrevisto'
    end
    object quFormIDQuitacaoMeioPrevisto: TIntegerField
      FieldName = 'IDQuitacaoMeioPrevisto'
    end
    object quFormIDContaCorrentePrevista: TIntegerField
      FieldName = 'IDContaCorrentePrevista'
    end
    object quFormDesativado: TBooleanField
      FieldName = 'Desativado'
    end
    object quFormHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
    end
    object quFormIDUsuarioLancamento: TIntegerField
      FieldName = 'IDUsuarioLancamento'
    end
    object quFormIDUsuarioProtesto: TIntegerField
      FieldName = 'IDUsuarioProtesto'
    end
    object quFormNumeroDuplicata: TStringField
      FieldName = 'NumeroDuplicata'
    end
    object quFormDataEmissao: TDateTimeField
      FieldName = 'DataEmissao'
    end
    object quFormIDLancamentoOriginal: TIntegerField
      FieldName = 'IDLancamentoOriginal'
    end
    object quFormDataVencimentoOriginal: TDateTimeField
      FieldName = 'DataVencimentoOriginal'
    end
    object quFormHistorico: TMemoField
      FieldName = 'Historico'
      BlobType = ftMemo
    end
    object quFormFavorecidoPrevisto: TStringField
      FieldName = 'FavorecidoPrevisto'
      Size = 65
    end
    object quFormIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quFormIDLancamentoParent: TIntegerField
      FieldName = 'IDLancamentoParent'
    end
    object quFormLancamentoType: TIntegerField
      FieldName = 'LancamentoType'
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    AutoIncField = 'IDLancamento'
    RequiredFields.Strings = (
      'IDEmpresa'
      'DataLancamento'
      'DataVencimento'
      'ValorNominal')
    DependentTables.Strings = (
      'Fin_LancamentoTerm')
    DependentTableKeys.Strings = (
      'IDLancamento')
  end
  inherited bmMDI: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      0
      0)
  end
end
