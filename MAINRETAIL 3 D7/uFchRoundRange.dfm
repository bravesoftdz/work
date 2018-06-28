inherited FchRoundRange: TFchRoundRange
  Left = 191
  Top = 150
  Caption = 'FchRoundRange'
  ClientHeight = 342
  ClientWidth = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 414
    inherited Image1: TImage
      Width = 140
    end
    inherited lblMenu: TLabel
      Left = 153
    end
    inherited EspacamentoSuperior: TPanel
      Width = 414
      inherited EEE: TPanel
        Width = 414
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 367
    end
  end
  inherited Panel1: TPanel
    Top = 301
    Width = 414
    inherited EspacamentoInferior: TPanel
      Width = 414
      inherited Panel3: TPanel
        Width = 414
      end
    end
    inherited hhh: TPanel
      Left = 193
    end
  end
  inherited pnlKey: TPanel
    Width = 414
    Height = 14
    inherited Panel4: TPanel
      Top = 12
      Width = 414
    end
  end
  inherited pnlDetail: TPanel
    Top = 54
    Width = 408
    Height = 247
    object Label2: TLabel
      Left = 92
      Top = 49
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'MinValue :'
      FocusControl = dbMinValue
    end
    object Label3: TLabel
      Left = 88
      Top = 83
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'MaxValue :'
      FocusControl = dbMaxValue
    end
    object Label4: TLabel
      Left = 72
      Top = 121
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'RoundValues :'
    end
    object Label5: TLabel
      Left = 79
      Top = 13
      Width = 62
      Height = 13
      Alignment = taRightJustify
      Caption = 'RoundType :'
    end
    object Label35: TLabel
      Left = 270
      Top = 10
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
    object Label1: TLabel
      Left = 207
      Top = 45
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
    object Label6: TLabel
      Left = 207
      Top = 80
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
    object dbMinValue: TDBEdit
      Left = 144
      Top = 44
      Width = 61
      Height = 21
      DataField = 'MinValue'
      DataSource = dsForm
      TabOrder = 1
      OnExit = dbMinValueExit
    end
    object dbMaxValue: TDBEdit
      Left = 144
      Top = 79
      Width = 61
      Height = 21
      DataField = 'MaxValue'
      DataSource = dsForm
      TabOrder = 2
      OnExit = dbMaxValueExit
    end
    object BitBtn1: TBitBtn
      Left = 267
      Top = 116
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 4
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 267
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 5
      OnClick = BitBtn2Click
    end
    object cbRoundType: TComboBox
      Left = 144
      Top = 8
      Width = 123
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnCloseUp = cbRoundTypeCloseUp
      Items.Strings = (
        'Up'
        'Down'
        'Nearest')
    end
    object edRoundValue: TEdit
      Left = 144
      Top = 117
      Width = 121
      Height = 21
      TabOrder = 3
      OnKeyPress = edRoundValueKeyPress
    end
    object lbRoundValues: TListBox
      Left = 144
      Top = 140
      Width = 121
      Height = 97
      ItemHeight = 13
      TabOrder = 6
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 54
    Height = 247
  end
  inherited EspacamentoDireito: TPanel
    Left = 411
    Top = 54
    Height = 247
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchRoundRange.sil'
  end
  inherited dsForm: TDataSource
    Left = 360
  end
  inherited quForm: TPowerADOQuery
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'IDRoundingTableRange,'#13#10#9'IDRoundingTable,'#13#10#9'MinValue,'#13#10#9 +
      'MaxValue,'#13#10#9'RoundValues,'#13#10#9'RoundType'#13#10'FROM'#13#10#9'RoundingTableRange'#13 +
      #10'WHERE'#13#10#9'IDRoundingTableRange = :IDRoundingTableRange'
    Parameters = <
      item
        Name = 'IDRoundingTableRange'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 360
    object quFormIDRoundingTableRange: TIntegerField
      FieldName = 'IDRoundingTableRange'
    end
    object quFormIDRoundingTable: TIntegerField
      FieldName = 'IDRoundingTable'
    end
    object quFormMinValue: TBCDField
      FieldName = 'MinValue'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormMaxValue: TBCDField
      FieldName = 'MaxValue'
      Required = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormRoundValues: TStringField
      FieldName = 'RoundValues'
      Size = 100
    end
    object quFormRoundType: TIntegerField
      FieldName = 'RoundType'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDRoundingTableRange'
    Left = 360
  end
end
