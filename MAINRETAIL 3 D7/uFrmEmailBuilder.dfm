inherited FrmEmailBuilder: TFrmEmailBuilder
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmEmailBuilder'
  ClientHeight = 442
  ClientWidth = 479
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 19
    Top = 136
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = 'Subject :'
  end
  object Label2: TLabel [1]
    Left = 7
    Top = 86
    Width = 54
    Height = 13
    Alignment = taRightJustify
    Caption = 'Email BCC :'
  end
  object Label3: TLabel [2]
    Left = 30
    Top = 184
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Body :'
  end
  object Label5: TLabel [3]
    Left = 11
    Top = 160
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = 'Attached :'
  end
  object btnOpenFile: TSpeedButton [4]
    Left = 444
    Top = 156
    Width = 23
    Height = 22
    Glyph.Data = {
      62010000424D62010000000000003600000028000000060000000F0000000100
      1800000000002C010000C40E0000C40E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FF0000FF00FF000000000000000000000000FF00FF
      0000000000000000FF00FFFF00FF0000000000000000000000FF00FFFF00FFFF
      00FFFF00FF0000000000000000FF00FF000000000000FF00FF00000000000000
      00000000FF00FFFF00FF0000000000000000000000000000FF00FFFF00FF0000
      000000000000000000000000FF00FFFF00FF0000000000000000000000000000
      FF00FFFF00FF0000000000000000FF00FF000000FF00FFFF00FFFF00FF000000
      0000FF00FF000000FF00FFFF00FFFF00FF0000000000FF00FFFF00FF00000000
      0000000000FF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF0000}
    OnClick = btnOpenFileClick
  end
  inherited Panel2: TPanel
    Width = 479
    inherited Image1: TImage
      Width = 252
    end
    inherited lblMenu: TLabel
      Left = 263
    end
    inherited EspacamentoSuperior: TPanel
      Width = 479
      inherited EEE: TPanel
        Width = 479
      end
    end
  end
  inherited Panel1: TPanel
    Top = 401
    Width = 479
    inherited EspacamentoInferior: TPanel
      Width = 479
      inherited Panel3: TPanel
        Width = 479
      end
    end
    inherited hhh: TPanel
      Left = 397
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
    object btnSend: TButton
      Left = 308
      Top = 9
      Width = 94
      Height = 31
      Caption = 'Call &Email'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnSendClick
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 361
  end
  inherited EspacamentoDireito: TPanel
    Left = 476
    Height = 361
  end
  object edtSubject: TEdit [9]
    Left = 65
    Top = 132
    Width = 400
    Height = 21
    MaxLength = 99
    TabOrder = 4
  end
  object mmReceivers: TMemo [10]
    Left = 65
    Top = 84
    Width = 400
    Height = 46
    TabStop = False
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object memBody: TMemo [11]
    Left = 65
    Top = 180
    Width = 400
    Height = 216
    TabStop = False
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object edtAttached: TEdit [12]
    Left = 65
    Top = 156
    Width = 376
    Height = 21
    MaxLength = 99
    TabOrder = 7
  end
  object rbEmailTo: TRadioGroup [13]
    Left = 66
    Top = 44
    Width = 279
    Height = 37
    Caption = 'Send email to'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Customer XXXXXX'
      'All')
    TabOrder = 8
    OnClick = rbEmailToClick
  end
  object Emails: TEmail [14]
    ShowDialog = False
    UseAppHandle = False
    Left = 30
    Top = 213
  end
  object OP: TOpenDialog [15]
    Filter = 'All|*.*'
    Left = 28
    Top = 268
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmEmailBuilder.sil'
  end
end
