object FrmConfig: TFrmConfig
  Left = 352
  Top = 331
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#227'o'
  ClientHeight = 115
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 69
    Height = 13
    Alignment = taRightJustify
    Caption = 'Cod. Revend.:'
  end
  object Label2: TLabel
    Left = 28
    Top = 48
    Width = 65
    Height = 13
    Alignment = taRightJustify
    Caption = 'Revendedor :'
  end
  object Panel1: TPanel
    Left = 0
    Top = 84
    Width = 353
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      353
      31)
    object btnOk: TcxButton
      Left = 272
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Salvar'
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object edtCodRevendedor: TcxTextEdit
    Left = 97
    Top = 20
    Width = 173
    Height = 21
    TabOrder = 1
  end
  object edtRevendedor: TcxTextEdit
    Left = 97
    Top = 44
    Width = 173
    Height = 21
    TabOrder = 2
  end
end
