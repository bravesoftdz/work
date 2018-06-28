inherited FrmEntityValidation: TFrmEntityValidation
  Left = 212
  Top = 179
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Entity Validation'
  ClientHeight = 303
  ClientWidth = 548
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 262
    Width = 548
    TabOrder = 3
    inherited EspacamentoInferior: TPanel
      Width = 548
      inherited Panel3: TPanel
        Width = 548
      end
    end
    inherited hhh: TPanel
      Left = 337
      Width = 211
      inherited sbHelp: TSpeedButton
        Left = 2
        Visible = False
      end
      inherited btClose: TButton
        Left = 141
        ModalResult = 2
      end
      object Button1: TButton
        Left = 70
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        ModalResult = 1
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 256
    TabOrder = 4
  end
  inherited EspacamentoDireito: TPanel
    Left = 545
    Height = 256
    TabOrder = 5
  end
  inherited EspacamentoSuperior: TPanel
    Width = 548
    TabOrder = 6
  end
  object gbxContact: TGroupBox [4]
    Left = 273
    Top = 8
    Width = 264
    Height = 129
    Caption = '  Required Contact Info  '
    TabOrder = 1
    object chkPhone: TCheckBox
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Phone'
      TabOrder = 0
    end
    object chkCellular: TCheckBox
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Cellular'
      TabOrder = 1
    end
    object chkEmail: TCheckBox
      Left = 16
      Top = 72
      Width = 97
      Height = 17
      Caption = 'Email'
      TabOrder = 2
    end
    object chkBeeper: TCheckBox
      Left = 16
      Top = 96
      Width = 97
      Height = 17
      Caption = 'Beeper'
      TabOrder = 3
    end
    object chkFax: TCheckBox
      Left = 144
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Fax'
      TabOrder = 4
    end
    object chkHomePage: TCheckBox
      Left = 144
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Home Page'
      TabOrder = 5
    end
    object chkContact: TCheckBox
      Left = 144
      Top = 72
      Width = 97
      Height = 17
      Caption = 'Contact'
      TabOrder = 6
    end
  end
  object gbxPersonalDocument: TGroupBox [5]
    Left = 8
    Top = 144
    Width = 261
    Height = 105
    Caption = '  Required Personal Document Info  '
    TabOrder = 2
    object chkSocialSecurity: TCheckBox
      Left = 8
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Social Security #'
      TabOrder = 0
    end
    object chkBirthDate: TCheckBox
      Left = 8
      Top = 48
      Width = 117
      Height = 17
      Caption = 'Birth Date'
      TabOrder = 1
    end
    object chkCustomerCard: TCheckBox
      Left = 136
      Top = 48
      Width = 122
      Height = 17
      Caption = 'Customer Card'
      TabOrder = 2
    end
    object chkDriverLicence: TCheckBox
      Left = 136
      Top = 24
      Width = 122
      Height = 17
      Caption = 'Driver'#39's Licence #'
      TabOrder = 3
    end
    object chkEmployeeID: TCheckBox
      Left = 8
      Top = 71
      Width = 97
      Height = 17
      Caption = 'Employee ID'
      TabOrder = 4
    end
  end
  object gbxAddress: TGroupBox [6]
    Left = 8
    Top = 8
    Width = 262
    Height = 129
    Caption = ' Required  Address Info  '
    TabOrder = 0
    object chkAddress: TCheckBox
      Left = 8
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Address'
      TabOrder = 0
    end
    object chkNeighborhood: TCheckBox
      Left = 8
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Neighborhood'
      TabOrder = 1
    end
    object chkCity: TCheckBox
      Left = 136
      Top = 48
      Width = 89
      Height = 17
      Caption = 'City'
      TabOrder = 5
    end
    object chkZip: TCheckBox
      Left = 8
      Top = 96
      Width = 89
      Height = 17
      Caption = 'ZIP'
      TabOrder = 3
    end
    object chkCountry: TCheckBox
      Left = 136
      Top = 24
      Width = 89
      Height = 17
      Caption = 'Country'
      TabOrder = 4
    end
    object chkState: TCheckBox
      Left = 8
      Top = 72
      Width = 97
      Height = 17
      Caption = 'State'
      TabOrder = 2
    end
    object chkCityCode: TCheckBox
      Left = 136
      Top = 72
      Width = 89
      Height = 17
      Caption = 'City Code'
      TabOrder = 6
    end
  end
  object gbxBusinessDocument: TGroupBox [7]
    Left = 272
    Top = 145
    Width = 266
    Height = 104
    Caption = '  Required Business Document Info  '
    TabOrder = 7
    object chkSalesTax: TCheckBox
      Left = 146
      Top = 23
      Width = 97
      Height = 17
      Caption = 'Sales Tax #'
      TabOrder = 0
    end
    object chkFederalID: TCheckBox
      Left = 12
      Top = 48
      Width = 121
      Height = 17
      Caption = 'Federal ID #'
      TabOrder = 1
    end
    object chkDBA: TCheckBox
      Left = 12
      Top = 24
      Width = 121
      Height = 17
      Caption = 'DBA'
      TabOrder = 2
    end
  end
  object quClearAndWrite: TADOCommand [8]
    Connection = DM.ADODBConnect
    Parameters = <>
    Left = 216
    Top = 96
  end
  object quLoadSelected: TADOQuery [9]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDTipoPessoa'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PessoaField'
      'FROM'
      #9'PessoaValidation'
      'WHERE'
      #9'IDTipoPessoa = :IDTipoPessoa')
    Left = 96
    Top = 96
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmEntityValidation.sil'
  end
end
