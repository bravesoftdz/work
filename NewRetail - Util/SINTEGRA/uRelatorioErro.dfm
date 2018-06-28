object frmRelatorioErro: TfrmRelatorioErro
  Left = 264
  Top = 193
  BorderStyle = bsDialog
  Caption = 'Relatorio de Erros'
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 412
    Width = 688
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Panel3: TPanel
      Left = 425
      Top = 1
      Width = 262
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnCancela: TBitBtn
        Left = 133
        Top = 7
        Width = 121
        Height = 25
        Caption = 'Cancela'
        TabOrder = 0
        Kind = bkCancel
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 412
    Align = alClient
    BorderWidth = 5
    TabOrder = 1
    object Memo1: TMemo
      Left = 6
      Top = 6
      Width = 676
      Height = 400
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
  end
end
