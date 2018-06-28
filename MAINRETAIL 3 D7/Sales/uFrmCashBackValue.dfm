inherited FrmCashBackValue: TFrmCashBackValue
  Left = 262
  Top = 18
  Width = 334
  Height = 159
  Caption = 'Enter Cash Back Value'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 80
    Width = 318
    inherited EspacamentoInferior: TPanel
      Width = 318
      inherited Panel3: TPanel
        Width = 318
      end
    end
    inherited hhh: TPanel
      Left = 101
      Width = 217
      inherited btClose: TButton
        Left = 145
        ModalResult = 2
      end
      object btOk: TButton
        Left = 76
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Ok'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 74
  end
  inherited EspacamentoDireito: TPanel
    Left = 315
    Height = 74
  end
  inherited EspacamentoSuperior: TPanel
    Width = 318
  end
  object edtCaskBackValue: TEdit [4]
    Left = 76
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
    OnKeyPress = edtCaskBackValueKeyPress
  end
end
