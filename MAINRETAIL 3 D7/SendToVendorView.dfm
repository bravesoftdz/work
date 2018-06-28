object frmSendToVendorView: TfrmSendToVendorView
  Left = 955
  Top = 523
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Send to Vendor'
  ClientHeight = 238
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sendToVendor: TSpeedButton
    Left = 384
    Top = 202
    Width = 112
    Height = 31
    Caption = 'Send To Vendor'
    Glyph.Data = {
      EE000000424DEE000000000000007600000028000000090000000F0000000100
      04000000000078000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666000
      000066666666600000006006666660000000603066666000000060B306666000
      000060BB30666000000060BBB3066000000060BBBB306000000060BBB3066000
      000060BB30666000000060B30666600000006030666660000000600666666000
      000066666666600000006666666660000000}
    Margin = 5
    OnClick = sendToVendorClick
  end
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 503
    Height = 194
    Align = alTop
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 503
      Height = 18
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Return Item Info'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 36
      Top = 22
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
    end
    object Label19: TLabel
      Left = 49
      Top = 78
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'RA#'
    end
    object Label32: TLabel
      Left = 528
      Top = 48
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object noteLabel: TLabel
      Left = 49
      Top = 126
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'Note:'
    end
    object lbDefect: TLabel
      Left = 10
      Top = 104
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Defect Type :'
    end
    object Label3: TLabel
      Left = 233
      Top = 73
      Width = 42
      Height = 13
      Caption = 'Quantity:'
      Visible = False
    end
    object Label4: TLabel
      Left = 31
      Top = 53
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vendor:'
    end
    object Label6: TLabel
      Left = 421
      Top = 47
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label7: TLabel
      Left = 338
      Top = 100
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object serial: TdxEdit
      Left = 77
      Top = 72
      Width = 121
      TabOrder = 0
    end
    object note: TdxMemo
      Left = 78
      Top = 126
      Width = 338
      TabOrder = 1
      Lines.Strings = (
        '')
      Height = 37
    end
    object itemModel: TdxEdit
      Left = 77
      Top = 23
      Width = 339
      Color = clBtnFace
      TabOrder = 2
    end
    object dxEdit3: TdxEdit
      Left = 280
      Top = 71
      Width = 54
      TabOrder = 3
      Text = 'dxEdit2'
      Visible = False
    end
    object defectTypeList: TcxComboBox
      Left = 78
      Top = 100
      Width = 258
      Height = 21
      TabOrder = 4
    end
    object vendorList: TcxComboBox
      Left = 77
      Top = 47
      Width = 339
      Height = 21
      TabOrder = 5
    end
  end
  object cancel: TcxButton
    Left = 253
    Top = 206
    Width = 112
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = cancelClick
  end
end
