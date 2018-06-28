inherited FrmPessoaHistory: TFrmPessoaHistory
  Left = 358
  Top = 145
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmPessoaHistory'
  ClientWidth = 378
  PixelsPerInch = 96
  TextHeight = 13
  object lbUser: TLabel [0]
    Left = 43
    Top = 68
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'User : '
  end
  object Label1: TLabel [1]
    Left = 20
    Top = 105
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'Customer : '
  end
  object Label2: TLabel [2]
    Left = 43
    Top = 143
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Date : '
  end
  object Label3: TLabel [3]
    Left = 42
    Top = 185
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'Type : '
  end
  object Label4: TLabel [4]
    Left = 36
    Top = 231
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Result : '
  end
  object Label5: TLabel [5]
    Left = 38
    Top = 279
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = 'Memo : '
  end
  object Label35: TLabel [6]
    Left = 353
    Top = 65
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel [7]
    Left = 353
    Top = 101
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel [8]
    Left = 311
    Top = 140
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel [9]
    Left = 355
    Top = 181
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel [10]
    Left = 358
    Top = 228
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel2: TPanel
    Width = 378
    TabOrder = 8
    inherited Image3: TImage [0]
    end
    inherited imgTopIni: TImage [1]
    end
    inherited Image1: TImage [2]
      Width = 151
    end
    inherited lblMenu: TLabel [3]
      Left = 162
    end
    inherited lblSubMenu: TLabelEffect [4]
    end
    inherited imgMenu: TImage [5]
    end
    inherited EspacamentoSuperior: TPanel
      Width = 378
      inherited EEE: TPanel
        Width = 378
      end
    end
  end
  inherited Panel1: TPanel
    Width = 378
    TabOrder = 7
    inherited EspacamentoInferior: TPanel
      Width = 378
      inherited Panel3: TPanel
        Width = 378
      end
    end
    inherited hhh: TPanel
      Left = 221
      Width = 157
      inherited btClose: TButton
        Left = 86
        Cancel = True
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 15
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    TabOrder = 9
  end
  inherited EspacamentoDireito: TPanel
    Left = 375
    TabOrder = 10
  end
  object scUser: TDBSuperComboADO [15]
    Left = 83
    Top = 65
    Width = 266
    Height = 21
    TabStop = False
    Color = clSilver
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = 'scUser'
    LookUpSource = DM.dsLookUpUser
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    ShowBtnSelecao = False
    IDLanguage = 0
    DataField = 'IDUser'
    DataSource = dsPessoaHistory
  end
  object scCustomer: TDBSuperComboADO [16]
    Left = 83
    Top = 101
    Width = 265
    Height = 21
    TabStop = False
    Color = clSilver
    Enabled = False
    ReadOnly = True
    TabOrder = 1
    Text = 'scCustomer'
    LookUpSource = DM.dsLookUpCustomer
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    ShowBtnSelecao = False
    IDLanguage = 0
    DataField = 'IDPessoa'
    DataSource = dsPessoaHistory
  end
  object memOBS: TDBMemo [17]
    Left = 83
    Top = 278
    Width = 274
    Height = 103
    DataField = 'Obs'
    DataSource = dsPessoaHistory
    MaxLength = 255
    TabOrder = 6
  end
  object scType: TDBSuperComboADO [18]
    Left = 83
    Top = 181
    Width = 267
    Height = 21
    TabOrder = 4
    Text = 'scType'
    CodeLength = 5
    LookUpSource = DM.dsLookUpPHistoryType
    DropDownRows = 18
    IDLanguage = 0
    OnSelectItem = scTypeSelectItem
    OnAfterAddUpdate = scTypeAfterAddUpdate
    DataField = 'IDPessoaHistoryType'
    DataSource = dsPessoaHistory
  end
  object cbxResult: TcxDBLookupComboBox [19]
    Left = 84
    Top = 228
    Width = 269
    Height = 21
    DataBinding.DataSource = dsPessoaHistory
    DataBinding.DataField = 'IDPessoaHistoryResult'
    Properties.KeyFieldNames = 'IDPessoaHistoryResult'
    Properties.ListColumns = <
      item
        FieldName = 'PessoaHistoryResult'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dsResultType
    Style.BorderStyle = ebs3D
    TabOrder = 5
  end
  object dtDate: TcxDBDateEdit [20]
    Left = 83
    Top = 140
    Width = 114
    Height = 21
    DataBinding.DataSource = dsPessoaHistory
    DataBinding.DataField = 'MovDate'
    Properties.ReadOnly = False
    Properties.ShowTime = False
    Style.BorderColor = clNone
    Style.BorderStyle = ebs3D
    Style.ButtonStyle = bts3D
    Style.ButtonTransparency = ebtNone
    TabOrder = 2
  end
  object dtTime: TcxDBTimeEdit [21]
    Left = 198
    Top = 140
    Width = 109
    Height = 21
    DataBinding.DataSource = dsPessoaHistory
    DataBinding.DataField = 'MovDate'
    Properties.ReadOnly = False
    Properties.TimeFormat = tfHourMin
    Style.BorderStyle = ebs3D
    Style.ButtonStyle = bts3D
    TabOrder = 3
  end
  object quPessoaHistory: TADODataSet [22]
    Connection = DM.ADODBConnect
    CommandText = 
      'Select'#13#10#9'PH.IDPessoaHistory,'#13#10#9'PH.IDPessoa,'#13#10#9'PH.IDUser,'#13#10#9'PH.ID' +
      'PessoaHistoryType,'#13#10#9'PH.IDPessoaHistoryResult,'#13#10#9'PH.MovDate,'#13#10#9'P' +
      'H.Obs'#13#10'From'#13#10#9'Mnt_PessoaHistory PH'#13#10'Where'#13#10#9'PH.IDPessoaHistory =' +
      ' :IDPessoaHistory'
    Parameters = <
      item
        Name = 'IDPessoaHistory'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 292
    Top = 40
    object quPessoaHistoryIDPessoaHistory: TIntegerField
      FieldName = 'IDPessoaHistory'
    end
    object quPessoaHistoryIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quPessoaHistoryIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quPessoaHistoryIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quPessoaHistoryIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quPessoaHistoryMovDate: TDateTimeField
      FieldName = 'MovDate'
      EditMask = '!99/99/00 90:00;1;_'
    end
    object quPessoaHistoryObs: TStringField
      FieldName = 'Obs'
      Size = 255
    end
  end
  object dsPessoaHistory: TDataSource [23]
    DataSet = cdsPessoaHistory
    Left = 292
    Top = 204
  end
  object dspPessoaHistory: TDataSetProvider [24]
    DataSet = quPessoaHistory
    Left = 292
    Top = 92
  end
  object cdsPessoaHistory: TClientDataSet [25]
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDPessoaHistory'
        ParamType = ptInput
      end>
    ProviderName = 'dspPessoaHistory'
    Left = 292
    Top = 148
  end
  object quTypeResult: TADODataSet [26]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IDPessoaHistoryResult,'#13#10#9'IDPessoaHistoryType,'#13#10#9'PessoaH' +
      'istoryResult,'#13#10#9'ResultColor'#13#10'FROM'#13#10#9'Mnt_PessoaHistoryResult (NOL' +
      'OCK) '#13#10
    Parameters = <>
    Left = 39
    Top = 301
    object quTypeResultIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quTypeResultIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quTypeResultPessoaHistoryResult: TStringField
      DisplayLabel = 'Result'
      FieldName = 'PessoaHistoryResult'
      Size = 30
    end
    object quTypeResultResultColor: TStringField
      DisplayLabel = 'Color'
      FieldName = 'ResultColor'
    end
  end
  object dspResultType: TDataSetProvider [27]
    DataSet = quTypeResult
    Left = 48
    Top = 320
  end
  object cdsResultType: TClientDataSet [28]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspResultType'
    Left = 64
    Top = 332
  end
  object dsResultType: TDataSource [29]
    DataSet = cdsResultType
    Left = 76
    Top = 344
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPessoaHistory.sil'
  end
end
