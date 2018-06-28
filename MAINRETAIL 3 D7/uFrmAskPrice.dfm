inherited FrmAskPrice: TFrmAskPrice
  Left = 326
  Top = 307
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = ''
  ClientHeight = 144
  ClientWidth = 325
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
  inherited Panel1: TPanel
    Top = 103
    Width = 325
    TabOrder = 1
    inherited EspacamentoInferior: TPanel
      Width = 325
      inherited Panel3: TPanel
        Width = 325
      end
    end
    inherited hhh: TPanel
      Left = 78
      Width = 247
      inherited sbHelp: TSpeedButton
        Left = 9
        Visible = False
      end
      inherited btClose: TButton
        Left = 76
        ModalResult = 2
        Visible = False
      end
      object btOk: TButton
        Left = 171
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        TabOrder = 1
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 97
    TabOrder = 2
  end
  inherited EspacamentoDireito: TPanel
    Left = 322
    Height = 97
    TabOrder = 3
  end
  inherited EspacamentoSuperior: TPanel
    Width = 325
    TabOrder = 4
  end
  object edtSalePrice: TSuperEditCurrency [6]
    Left = 164
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
    Text = '0.00'
    OnKeyPress = edtSalePriceKeyPress
    OnPressEnter = edtSalePricePressEnter
    Alignment = taRightJustify
    DisplayFormat = '0.00'
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAskPrice.sil'
  end
end
