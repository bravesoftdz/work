inherited NewPersonType: TNewPersonType
  Left = 228
  Top = 220
  Width = 395
  Height = 145
  Caption = 'NewPersonType'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblTypePerson: TLabel [0]
    Left = 28
    Top = 36
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'Customer :'
  end
  inherited Panel1: TPanel
    Top = 70
    Width = 387
    inherited EspacamentoInferior: TPanel
      Width = 387
      inherited Panel3: TPanel
        Width = 387
      end
    end
    inherited hhh: TPanel
      Left = 176
      Width = 211
      inherited sbHelp: TSpeedButton
        Left = 3
      end
      inherited btClose: TButton
        Left = 143
      end
      object btOK: TButton
        Left = 73
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        ModalResult = 1
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 64
  end
  inherited EspacamentoDireito: TPanel
    Left = 384
    Height = 64
  end
  inherited EspacamentoSuperior: TPanel
    Width = 387
  end
  object cmbPersonType: TSuperComboADO [5]
    Left = 86
    Top = 32
    Width = 293
    Height = 21
    TabOrder = 4
    Text = 'cmbPersonType'
    LookUpSource = DM.dsLookUpTipoPessoa
    DropDownRows = 18
    ShowEditCode = True
    IDLanguage = 0
    OnSelectItem = cmbPersonTypeSelectItem
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_NewPersonType.sil'
  end
end
