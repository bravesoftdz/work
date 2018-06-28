inherited NewModelReceipt: TNewModelReceipt
  Left = 397
  Top = 248
  Width = 410
  Height = 244
  Caption = 'NewModelReceipt'
  PixelsPerInch = 96
  TextHeight = 13
  object lblReceiptText: TLabel [0]
    Left = 8
    Top = 36
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Receipt text :'
  end
  inherited Panel1: TPanel
    Top = 176
    Width = 402
    inherited EspacamentoInferior: TPanel
      Width = 402
      inherited Panel3: TPanel
        Width = 402
      end
    end
    inherited hhh: TPanel
      Left = 189
      Width = 213
      inherited btClose: TButton
        Left = 144
        Cancel = True
        ModalResult = 2
      end
      object btOK: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 170
  end
  inherited EspacamentoDireito: TPanel
    Left = 399
    Height = 170
  end
  inherited EspacamentoSuperior: TPanel
    Width = 402
  end
  object mmReceiptText: TMemo [5]
    Left = 76
    Top = 36
    Width = 293
    Height = 125
    TabOrder = 4
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_NewModelReceipt.sil'
    Left = 20
    Top = 76
  end
end
