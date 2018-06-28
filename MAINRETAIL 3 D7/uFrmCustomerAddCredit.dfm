inherited FrmCustomerAddCredit: TFrmCustomerAddCredit
  Left = 390
  Top = 226
  Width = 349
  Height = 224
  BorderIcons = [biSystemMenu]
  Caption = 'Customer Add Credit'
  PixelsPerInch = 96
  TextHeight = 13
  object lblUser: TLabel [0]
    Left = 63
    Top = 60
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
  end
  object lblStore: TLabel [1]
    Left = 60
    Top = 26
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object lblExpirationDate: TLabel [2]
    Left = 15
    Top = 92
    Width = 78
    Height = 13
    Alignment = taRightJustify
    Caption = 'Expiration Date :'
  end
  object lblAmount: TLabel [3]
    Left = 51
    Top = 125
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Amount :'
  end
  inherited Panel1: TPanel
    Top = 156
    Width = 341
    inherited EspacamentoInferior: TPanel
      Width = 341
      inherited Panel3: TPanel
        Width = 341
      end
    end
    inherited hhh: TPanel
      Left = 126
      Width = 215
      inherited btClose: TButton
        Left = 145
        Cancel = True
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = 'Save'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 150
  end
  inherited EspacamentoDireito: TPanel
    Left = 338
    Height = 150
  end
  inherited EspacamentoSuperior: TPanel
    Width = 341
  end
  object scUser: TSuperComboADO [8]
    Left = 100
    Top = 56
    Width = 217
    Height = 21
    TabStop = False
    Color = clSilver
    ReadOnly = True
    TabOrder = 4
    LookUpSource = DM.dsLookUpUser
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scStore: TSuperComboADO [9]
    Left = 100
    Top = 22
    Width = 217
    Height = 21
    TabStop = False
    Color = clSilver
    ReadOnly = True
    TabOrder = 5
    LookUpSource = DM.dsLookUpStore
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object edtData: TDateBox [10]
    Left = 100
    Top = 88
    Width = 88
    Height = 21
    TabOrder = 6
    InputTime = False
    Language = Portuguese
  end
  object edtAmount: TEdit [11]
    Left = 100
    Top = 119
    Width = 87
    Height = 21
    TabOrder = 7
    OnKeyPress = edtAmountKeyPress
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmCustomerAddCredit.sil'
  end
end
