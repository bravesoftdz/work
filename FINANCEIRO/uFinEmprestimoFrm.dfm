inherited FinEmprestimoFrm: TFinEmprestimoFrm
  Left = 228
  Top = 199
  BorderIcons = [biSystemMenu]
  Caption = 'Emprestimo'
  ClientHeight = 507
  ClientWidth = 427
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 79
    Top = 28
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
  end
  object Label6: TLabel [1]
    Left = 373
    Top = 26
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
  object Label14: TLabel [2]
    Left = 56
    Top = 52
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Company :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel [3]
    Left = 373
    Top = 49
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
  object Label2: TLabel [4]
    Left = 43
    Top = 74
    Width = 65
    Height = 13
    Alignment = taRightJustify
    Caption = 'Cost Center :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblPessoa: TLabel [5]
    Left = 59
    Top = 121
    Width = 49
    Height = 13
    Alignment = taRightJustify
    Caption = 'Entidade :'
  end
  object Label9: TLabel [6]
    Left = 374
    Top = 119
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
  object lblPessoaTipo: TLabel [7]
    Left = 36
    Top = 97
    Width = 72
    Height = 13
    Alignment = taRightJustify
    Caption = 'Tipo Entidade :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel [8]
    Left = 374
    Top = 96
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
  object Label8: TLabel [9]
    Left = 64
    Top = 168
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Amount :'
    FocusControl = edtAmount
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [10]
    Left = 213
    Top = 166
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
  object Label4: TLabel [11]
    Left = 73
    Top = 191
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Memo :'
    FocusControl = DBEdit3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblDocumentoTipo: TLabel [12]
    Left = 26
    Top = 145
    Width = 82
    Height = 13
    Alignment = taRightJustify
    Caption = 'Document Type :'
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 5
    Height = 459
  end
  inherited EspacamentoDireito: TPanel
    Left = 424
    Top = 5
    Height = 459
  end
  inherited EspacamentoSuperior: TPanel
    Width = 427
    Height = 5
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 464
    Width = 427
  end
  inherited pnlPBarra: TPanel
    Top = 470
    Width = 427
    inherited pnlPDAlignRight: TPanel
      Left = 227
      inherited btOk: TBitBtn
        Left = 15
      end
    end
    inherited pnlPLinhaSuperior: TPanel
      Width = 427
    end
  end
  object scUser: TDBSuperComboADO [18]
    Left = 112
    Top = 25
    Width = 261
    Height = 21
    TabStop = False
    TabOrder = 5
    Text = 'scUser'
    CodeLength = 70
    LookUpSource = DM.dsLookUpUsuario
    DropDownRows = 18
    DataField = 'IDUsuarioQuitacao'
    DataSource = dsEmprestimo
  end
  object scCompany: TDBSuperComboADO [19]
    Left = 112
    Top = 49
    Width = 261
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'scCompany'
    CodeLength = 70
    LookUpSource = DM.dsLookUpEmpresa
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    DataField = 'IDEmpresa'
    DataSource = dsEmprestimo
  end
  object dcCostCenter: TDBSuperComboADO [20]
    Left = 112
    Top = 71
    Width = 261
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Text = 'dcCostCenter'
    CodeLength = 70
    SpcWhereClause = 'CC.Hidden = 0 AND CC.Desativado = 0'
    LookUpSource = DM.dsLUCentroCusto
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    DataField = 'IDCentroCusto'
    DataSource = dsEmprestimo
  end
  object scPessoa: TDBSuperComboADO [21]
    Left = 112
    Top = 118
    Width = 262
    Height = 21
    TabOrder = 9
    Text = 'scPessoa'
    CodeLength = 70
    LookUpSource = DM.dsLUPessoa
    DropDownRows = 18
    DataField = 'IDPessoa'
    DataSource = dsEmprestimo
  end
  object scPessoaTipo: TDBSuperComboADO [22]
    Left = 112
    Top = 94
    Width = 262
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = 'scPessoaTipo'
    CodeLength = 70
    LookUpSource = DM.dsLUPessoaTipo
    IsListFiltered = False
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    OnSelectItem = scPessoaTipoSelectItem
    DataField = 'IDPessoaTipo'
    DataSource = dsEmprestimo
  end
  object edtAmount: TDBEdit [23]
    Tag = 99
    Left = 112
    Top = 165
    Width = 101
    Height = 21
    DataField = 'ValorEmprestimo'
    DataSource = dsEmprestimo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object DBEdit3: TDBEdit [24]
    Tag = 99
    Left = 112
    Top = 188
    Width = 261
    Height = 21
    DataField = 'Memo'
    DataSource = dsEmprestimo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object GroupBox1: TGroupBox [25]
    Left = 21
    Top = 218
    Width = 395
    Height = 145
    Caption = '  Accounts Receivable  '
    TabOrder = 12
    object lblContaCorrente: TLabel
      Left = 14
      Top = 47
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bank Account :'
    end
    object Label5: TLabel
      Left = 352
      Top = 45
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
    object lblQuitacaoMeio: TLabel
      Left = 7
      Top = 72
      Width = 79
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payment Type  :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbQuitStart: TLabel
      Left = 352
      Top = 69
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
    object lblLancamentoTipo: TLabel
      Left = 19
      Top = 24
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
    object Label12: TLabel
      Left = 354
      Top = 21
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
    object lblNumDocQuitacao: TLabel
      Left = 17
      Top = 94
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Doc. Number :'
      FocusControl = DocQuit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 11
      Top = 118
      Width = 74
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payment date :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 219
      Top = 116
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
    object scContaCorrente: TDBSuperComboADO
      Left = 90
      Top = 44
      Width = 261
      Height = 21
      TabOrder = 0
      Text = 'scContaCorrente'
      CodeLength = 70
      SpcWhereClause = 'CC.Hidden = 0 AND CC.Desativado = 0'
      LookUpSource = DM.dsLUContaCorrente
      DropDownRows = 18
      DataField = 'IDContaCorrente'
      DataSource = dsEmprestimo
    end
    object scQuitacaoMeio: TDBSuperComboADO
      Left = 90
      Top = 68
      Width = 261
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'scQuitacaoMeio'
      CodeLength = 70
      LookUpSource = DM.dsLUQuitacaoMeio
      DropDownRows = 18
      DataField = 'IDQuitacaoMeio'
      DataSource = dsEmprestimo
    end
    object scLancamentoTipo: TDBSuperComboADO
      Left = 90
      Top = 20
      Width = 261
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'scLancamentoTipo'
      CodeLength = 70
      SpcWhereClause = 'Pagando = 0'
      LookUpSource = DM.dsLULancamentoTipo
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      ShowEditCode = True
      DataField = 'IDLancamentoTipo'
      DataSource = dsEmprestimo
    end
    object DocQuit: TDBEdit
      Tag = 99
      Left = 90
      Top = 91
      Width = 123
      Height = 21
      DataField = 'NumeroMeioQuit'
      DataSource = dsEmprestimo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtDataQuitacao: TdxDBDateEdit
      Left = 90
      Top = 115
      Width = 127
      TabOrder = 4
      DataField = 'DataQuitacao'
      DataSource = dsEmprestimo
    end
  end
  object GroupBox2: TGroupBox [26]
    Left = 21
    Top = 369
    Width = 396
    Height = 84
    Caption = '  Accounts Payable  '
    TabOrder = 13
    object Label13: TLabel
      Left = 19
      Top = 24
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
    object Label16: TLabel
      Left = 354
      Top = 21
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
    object Label17: TLabel
      Left = 11
      Top = 48
      Width = 74
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payment date :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 219
      Top = 45
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
    object scLancaTipo: TDBSuperComboADO
      Left = 90
      Top = 20
      Width = 260
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'scLancaTipo'
      CodeLength = 70
      SpcWhereClause = 'Pagando = 1'
      LookUpSource = DM.dsLULancamentoTipo
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      ShowEditCode = True
      DataField = 'IDLancamentoTipoPay'
      DataSource = dsEmprestimo
    end
    object edtPayDate: TdxDBDateEdit
      Left = 90
      Top = 45
      Width = 127
      TabOrder = 1
      DataField = 'DataPay'
      DataSource = dsEmprestimo
    end
  end
  object scDocumentoTipo: TDBSuperComboADO [27]
    Left = 112
    Top = 142
    Width = 261
    Height = 21
    TabOrder = 14
    Text = 'scDocumentoTipo'
    SpcWhereClause = 'DT.Desativado = 0 AND DT.Hidden = 0'
    LookUpSource = DM.dsLUDocumentoTipo
    IsListFiltered = False
    DropDownRows = 18
    DataField = 'IDDocumentoTipo'
    DataSource = dsEmprestimo
  end
  object dsEmprestimo: TDataSource [28]
    DataSet = cdsEmprestimo
    Left = 235
    Top = 15
  end
  object cdsEmprestimo: TClientDataSet [29]
    Aggregates = <>
    Params = <>
    OnNewRecord = cdsEmprestimoNewRecord
    Left = 235
    Top = 65
    object cdsEmprestimoIDUsuarioQuitacao: TIntegerField
      FieldName = 'IDUsuarioQuitacao'
    end
    object cdsEmprestimoIDEmpresa: TIntegerField
      FieldName = 'IDEmpresa'
    end
    object cdsEmprestimoIDCentroCusto: TIntegerField
      FieldName = 'IDCentroCusto'
    end
    object cdsEmprestimoIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object cdsEmprestimoIDPessoaTipo: TIntegerField
      FieldName = 'IDPessoaTipo'
    end
    object cdsEmprestimoValorEmprestimo: TCurrencyField
      FieldName = 'ValorEmprestimo'
      DisplayFormat = '#,##0.00'
    end
    object cdsEmprestimoMemo: TStringField
      FieldName = 'Memo'
      Size = 100
    end
    object cdsEmprestimoIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object cdsEmprestimoIDContaCorrente: TIntegerField
      FieldName = 'IDContaCorrente'
    end
    object cdsEmprestimoIDQuitacaoMeio: TIntegerField
      FieldName = 'IDQuitacaoMeio'
    end
    object cdsEmprestimoNumeroMeioQuit: TStringField
      FieldName = 'NumeroMeioQuit'
    end
    object cdsEmprestimoDataQuitacao: TDateTimeField
      FieldName = 'DataQuitacao'
      DisplayFormat = 'ddddd'
    end
    object cdsEmprestimoIDLancamentoTipoPay: TIntegerField
      FieldName = 'IDLancamentoTipoPay'
    end
    object cdsEmprestimoDataPay: TDateTimeField
      FieldName = 'DataPay'
      DisplayFormat = 'ddddd'
    end
    object cdsEmprestimoIDDocumentoTipo: TIntegerField
      FieldName = 'IDDocumentoTipo'
    end
  end
  object cmdInsertLancamento: TADOCommand [30]
    CommandText = 
      'INSERT Fin_Lancamento (IDLancamento, IDPessoaTipo, IDEmpresa, ID' +
      'Pessoa, IDUsuarioLancamento, IDCentroCusto, IDLancamentoTipo, Si' +
      'tuacao, DataLancamento, DataEmissao, DataVencimento, Pagando, Va' +
      'lorNominal, Historico, IDDocumentoTipo)'#13#10'VALUES (:IDLancamento, ' +
      ':IDPessoaTipo, :IDEmpresa, :IDPessoa, :IDUsuarioLancamento, :IDC' +
      'entroCusto, :IDLancamentoTipo, :Situacao, :DataLancamento, :Data' +
      'Emissao, :DataVencimento, :Pagando, :ValorNominal, :Historico, :' +
      'IDDocumentoTipo)'
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'IDLancamento'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoaTipo'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDEmpresa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUsuarioLancamento'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDCentroCusto'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDLancamentoTipo'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Situacao'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataLancamento'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataEmissao'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataVencimento'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Pagando'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'ValorNominal'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Historico'
        Attributes = [paNullable, paLong]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 2147483647
        Value = Null
      end
      item
        Name = 'IDDocumentoTipo'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 280
    Top = 145
  end
  object cmdInsertQuitacao: TADOCommand [31]
    CommandText = 
      'INSERT Fin_Quitacao (IDQuitacao, IDQuitacaoMeio, IDContaCorrente' +
      ', IDUsuarioQuitacao, Pagando, ValorQuitacao, DataQuitacao, Numer' +
      'oMeioQuit)'#13#10'VALUES (:IDQuitacao, :IDQuitacaoMeio, :IDContaCorren' +
      'te, :IDUsuarioQuitacao, :Pagando, :ValorQuitacao, :DataQuitacao,' +
      ' :NumeroMeioQuit)'
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'IDQuitacao'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDQuitacaoMeio'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDContaCorrente'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUsuarioQuitacao'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Pagando'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'ValorQuitacao'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'DataQuitacao'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'NumeroMeioQuit'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 285
    Top = 195
  end
  object cmdInsertLancQuit: TADOCommand [32]
    CommandText = 
      'INSERT Fin_LancQuit (IDQuitacao, IDLancamento, ValorQuitado, IDU' +
      'suarioQuitacao, DataQuitacao)'#13#10'VALUES (:IDQuitacao, :IDLancament' +
      'o, :ValorQuitado, :IDUsuarioQuitacao, :DataQuitacao)'#13#10
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'IDQuitacao'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDLancamento'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ValorQuitado'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDUsuarioQuitacao'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataQuitacao'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 286
    Top = 251
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FinEmprestimoFrm.sil'
  end
end
