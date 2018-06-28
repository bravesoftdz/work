inherited frmTagQtyPriceBreak: TfrmTagQtyPriceBreak
  Left = 537
  Top = 224
  Width = 316
  Height = 183
  BorderIcons = [biSystemMenu]
  Caption = 'Tag - Price Break'
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 14
    Top = 25
    Width = 48
    Height = 13
    Caption = 'Quantity'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 14
    Top = 56
    Width = 67
    Height = 13
    Caption = 'Price Break'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited Panel1: TPanel
    Top = 104
    Width = 300
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 300
      inherited Panel3: TPanel
        Width = 300
      end
    end
    inherited hhh: TPanel
      Left = 149
      inherited btClose: TButton
        Caption = '&Save'
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 98
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 297
    Height = 98
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 300
    TabOrder = 5
  end
  object cedPrice: TcxCurrencyEdit [6]
    Left = 88
    Top = 49
    Width = 73
    Height = 21
    EditValue = 0.000000000000000000
    Properties.DisplayFormat = '0'
    TabOrder = 1
  end
  object cedQty: TcxCurrencyEdit [7]
    Left = 88
    Top = 23
    Width = 73
    Height = 21
    EditValue = 0.000000000000000000
    Properties.DisplayFormat = '0'
    TabOrder = 0
  end
  inherited siLang: TsiLangRT
    Left = 479
    Top = 11
  end
end
