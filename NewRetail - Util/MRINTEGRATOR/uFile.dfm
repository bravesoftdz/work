object FrmFile: TFrmFile
  Left = 391
  Top = 74
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export File'
  ClientHeight = 418
  ClientWidth = 296
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Shape7: TShape
    Left = 0
    Top = 0
    Width = 322
    Height = 30
    Align = alCustom
    Brush.Color = 10485760
    Pen.Color = 10485760
  end
  object lbType: TLabel
    Left = 6
    Top = 8
    Width = 87
    Height = 16
    Caption = 'Sale Invoice'
    Color = 10485760
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object sgColumns: TStringGrid
    Left = 0
    Top = 30
    Width = 296
    Height = 227
    ColCount = 3
    DefaultColWidth = 78
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    TabOrder = 0
    ColWidths = (
      22
      106
      106)
  end
  object Panel: TPanel
    Left = -1
    Top = 257
    Width = 297
    Height = 127
    BevelOuter = bvNone
    TabOrder = 1
    object Label2: TLabel
      Left = 4
      Top = 8
      Width = 123
      Height = 13
      Caption = 'Where is the file located ?'
    end
    object sbOpenFile: TSpeedButton
      Left = 268
      Top = 25
      Width = 23
      Height = 21
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C0000000000000000000000000000000000000000
        0000000000001F7C1F7C604E604E604E604E604E604E604E604E604E604E604E
        604E000000001F7C1F7C604EFF7F337FF37F337FF37F337F337F337F337F2C67
        604E000000001F7C604EFF7FF37FF37F337FF37F337FF37F337F337F337F2C67
        0000604E00001F7C604EFF7FF37FF37FF37FF37FF37F337FF37F337F337F604E
        0000604E0000604EFF7FF37FF37FF37FF37F337FF37FF37F337FF37F2C670000
        2C672C670000604EFF7FF37FF37FF37FF37FF37FF37F337FF37F337F2C670000
        2C672C670000604E604E604E604E604E604E604E604E604E604E604E604E2C67
        F37F2C6700001F7C604EFF7FF37FF37FF37FF37FF37FF37FF37FF37FF37FF37F
        F37F2C6700001F7C604EFF7FF37FF37FF37FF37FF37FF37FF37FFF7FFF7FFF7F
        FF7F2C6700001F7C604EFF7FF37FF37FF37FF37FF37FFF7F604E604E604E604E
        604E604E1F7C1F7C1F7C604EFF7FFF7FFF7FFF7FFF7F604E1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C604E604E604E604E604E1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      OnClick = sbOpenFileClick
    end
    object lbPB: TLabel
      Left = 4
      Top = 93
      Width = 22
      Height = 13
      Caption = 'lbPB'
    end
    object edtPath: TEdit
      Left = 3
      Top = 25
      Width = 260
      Height = 21
      Color = clInfoBk
      TabOrder = 0
    end
    object PanelDate: TPanel
      Left = 2
      Top = 46
      Width = 216
      Height = 43
      BevelOuter = bvNone
      TabOrder = 1
      object lbBeginDate: TLabel
        Left = 1
        Top = 6
        Width = 91
        Height = 13
        Caption = 'Begin Invoice Date'
      end
      object lbEndDate: TLabel
        Left = 104
        Top = 6
        Width = 83
        Height = 13
        Caption = 'End Invoice Date'
      end
      object edtBeginDate: TDateBox
        Left = 1
        Top = 21
        Width = 98
        Height = 21
        TabOrder = 0
      end
      object edtEndDate: TDateBox
        Left = 106
        Top = 21
        Width = 101
        Height = 21
        TabOrder = 1
      end
    end
    object PBar: TProgressBar
      Left = 4
      Top = 107
      Width = 204
      Height = 16
      TabOrder = 2
    end
  end
  object sgColumnsClient: TStringGrid
    Left = 0
    Top = 30
    Width = 296
    Height = 229
    ColCount = 3
    DefaultColWidth = 78
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    TabOrder = 2
    ColWidths = (
      22
      106
      106)
  end
  object Panel1: TPanel
    Left = 0
    Top = 383
    Width = 296
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object bvBottom: TBevel
      Left = 0
      Top = 0
      Width = 296
      Height = 3
      Align = alTop
      Shape = bsTopLine
    end
    object BClose: TButton
      Left = 216
      Top = 7
      Width = 80
      Height = 23
      Caption = 'Close'
      TabOrder = 0
      OnClick = BCloseClick
    end
    object btFile: TBitBtn
      Left = 131
      Top = 7
      Width = 77
      Height = 23
      Caption = 'Create File'
      TabOrder = 1
      OnClick = btFileClick
    end
  end
  object SD: TSaveDialog
    InitialDir = 'C:\'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 179
    Top = 51
  end
end
