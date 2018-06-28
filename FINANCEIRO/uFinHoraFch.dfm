inherited FinHoraFch: TFinHoraFch
  Left = 216
  Top = 175
  HelpContext = 5
  Caption = 'FinHoraFch'
  ClientHeight = 247
  ClientWidth = 391
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 53
    Top = 123
    Width = 58
    Height = 13
    Alignment = taRightJustify
    Caption = 'Enter date :'
  end
  object Label2: TLabel [1]
    Left = 61
    Top = 153
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'Exit date :'
  end
  object Label3: TLabel [2]
    Left = 43
    Top = 93
    Width = 68
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sales person :'
  end
  object Label4: TLabel [3]
    Left = 78
    Top = 63
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object Label7: TLabel [4]
    Left = 302
    Top = 61
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
  object Label5: TLabel [5]
    Left = 302
    Top = 91
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
  object Label6: TLabel [6]
    Left = 302
    Top = 121
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
  object Label8: TLabel [7]
    Left = 302
    Top = 151
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
  inherited EspacamentoEsquerdo: TPanel
    Height = 170
    TabOrder = 4
  end
  inherited EspacamentoDireito: TPanel
    Left = 388
    Height = 170
    TabOrder = 5
  end
  inherited EspacamentoSuperior: TPanel
    Width = 391
    TabOrder = 6
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 204
    Width = 391
    TabOrder = 7
  end
  inherited pnlPBarra: TPanel
    Top = 210
    Width = 391
    TabOrder = 8
    inherited pnlPBarraRightAlign: TPanel
      Left = 122
    end
    inherited pnlPLinha: TPanel
      Width = 391
    end
  end
  inherited pnlPTitulo: TPanel
    Width = 391
    TabOrder = 9
    inherited lblPTituloShadow: TLabel
      Width = 57
      Caption = 'Time'
    end
    inherited lblPTitulo: TLabel
      Width = 57
      Caption = 'Time'
    end
    inherited pnlAutoInc: TPanel
      Left = 357
    end
  end
  object meEnter: TMaskEdit [14]
    Left = 240
    Top = 120
    Width = 61
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 2
    Text = '  :  '
    OnChange = meEnterChange
  end
  object meExit: TMaskEdit [15]
    Left = 240
    Top = 150
    Width = 61
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 3
    Text = '  :  '
    OnChange = meExitChange
  end
  object scStore: TDBSuperComboADO [16]
    Left = 115
    Top = 60
    Width = 186
    Height = 21
    TabOrder = 0
    Text = 'scStore'
    CodeLength = 45
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 16
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    DataField = 'IDStore'
    DataSource = dsForm
  end
  object scPessoa: TDBSuperComboADO [17]
    Left = 115
    Top = 90
    Width = 186
    Height = 21
    TabOrder = 1
    Text = 'scPessoa'
    CodeLength = 45
    LookUpSource = DM.dsLUPessoa
    DropDownRows = 16
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    DataField = 'IDPessoa'
    DataSource = dsForm
  end
  object deEnter: TDBDateBox [18]
    Left = 116
    Top = 121
    Width = 119
    Height = 21
    ReadOnly = False
    TabOrder = 14
    DataField = 'EnterDate'
    DataSource = dsForm
  end
  object deExit: TDBDateBox [19]
    Left = 116
    Top = 149
    Width = 119
    Height = 21
    ReadOnly = False
    TabOrder = 15
    DataField = 'ExitDate'
    DataSource = dsForm
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FinHoraFch.sil'
  end
  inherited dsForm: TDataSource
    Left = 366
    Top = 136
  end
  inherited quForm: TPowerADOQuery
    AfterOpen = quFormAfterOpen
    BeforeClose = quFormBeforeClose
    BeforePost = quFormBeforePost
    CommandText = 
      'SELECT '#13#10#9'T.IDTime, '#13#10#9'T.EnterDate, '#13#10#9'T.ExitDate, '#13#10#9'T.IDPessoa' +
      ', '#13#10#9'T.IDStore '#13#10'FROM '#13#10#9'TMC_TimeControl T '#13#10'WHERE '#13#10#9'T.IDTime =' +
      ' :IDTime'
    Parameters = <
      item
        Name = 'IDTime'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 361
    Top = 32
    object quFormIDTime: TIntegerField
      FieldName = 'IDTime'
      Origin = 'RETAILDB.TMC_TimeControl.IDTime'
    end
    object quFormEnterDate: TDateTimeField
      FieldName = 'EnterDate'
      Origin = 'RETAILDB.TMC_TimeControl.EnterDate'
    end
    object quFormExitDate: TDateTimeField
      FieldName = 'ExitDate'
      Origin = 'RETAILDB.TMC_TimeControl.ExitDate'
    end
    object quFormIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Origin = 'RETAILDB.TMC_TimeControl.IDPessoa'
    end
    object quFormIDStore: TIntegerField
      FieldName = 'IDStore'
      Origin = 'RETAILDB.TMC_TimeControl.IDStore'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    AutoIncField = 'IDTime'
    Left = 38
    Top = 69
  end
  inherited bmMDI: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    Left = 385
    Top = 80
    DockControlHeights = (
      0
      0
      0
      0)
  end
  inherited ilSmallButtons: TImageList
    Left = 372
    Top = 185
  end
  inherited PrintFch: TPrintDialog
    Left = 405
  end
end
