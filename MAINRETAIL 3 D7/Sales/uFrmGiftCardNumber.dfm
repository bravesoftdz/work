inherited FrmGiftCardNumber: TFrmGiftCardNumber
  Left = 356
  Top = 269
  Width = 334
  Height = 159
  Caption = 'Enter Gift Card'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 91
    Width = 326
    inherited EspacamentoInferior: TPanel
      Width = 326
      inherited Panel3: TPanel
        Width = 326
      end
    end
    inherited hhh: TPanel
      Left = 112
      Width = 214
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        Cancel = True
        ModalResult = 2
      end
      object btnOk: TButton
        Left = 76
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 85
  end
  inherited EspacamentoDireito: TPanel
    Left = 323
    Height = 85
  end
  inherited EspacamentoSuperior: TPanel
    Width = 326
  end
  object edtGiftCardNumber: TEdit [4]
    Left = 72
    Top = 36
    Width = 185
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
end
