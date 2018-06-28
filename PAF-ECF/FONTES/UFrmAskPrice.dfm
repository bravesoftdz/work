inherited FrmAskPrice: TFrmAskPrice
  Left = 206
  Top = 226
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ask Price'
  ClientHeight = 139
  ClientWidth = 335
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbPrice: TLabel [0]
    Left = 51
    Top = 53
    Width = 106
    Height = 23
    Alignment = taRightJustify
    Caption = 'Sale Price :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbModel: TLabel [1]
    Left = 7
    Top = 4
    Width = 314
    Height = 30
    AutoSize = False
    Caption = 'lbModel'
    WordWrap = True
  end
  inherited pnlButtom: TPanel
    Top = 98
    Width = 335
    TabOrder = 1
    inherited hhh: TPanel
      Left = 185
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Caption = 'OK'
        Default = True
        ModalResult = 1
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 96
    Width = 335
    TabOrder = 2
  end
  object edtSalePrice: TEdit [4]
    Left = 165
    Top = 48
    Width = 121
    Height = 33
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtSalePriceKeyPress
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAskPrice.sil'
  end
end
