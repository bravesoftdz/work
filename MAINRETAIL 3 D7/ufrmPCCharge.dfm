inherited frmPCCharge: TfrmPCCharge
  Left = 295
  Top = 56
  Width = 337
  Height = 273
  BorderIcons = [biSystemMenu]
  Caption = 'Enter credit card information'
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 38
    Top = 24
    Width = 62
    Height = 13
    Caption = 'Card Number'
  end
  object Label2: TLabel [1]
    Left = 31
    Top = 48
    Width = 69
    Height = 13
    Caption = 'Member Name'
  end
  object Label3: TLabel [2]
    Left = 45
    Top = 72
    Width = 55
    Height = 13
    Caption = 'Expire Date'
  end
  object Label4: TLabel [3]
    Left = 31
    Top = 97
    Width = 69
    Height = 13
    Caption = 'Street Address'
  end
  object Label5: TLabel [4]
    Left = 57
    Top = 122
    Width = 43
    Height = 13
    Caption = 'Zip Code'
  end
  object Label6: TLabel [5]
    Left = 73
    Top = 148
    Width = 27
    Height = 13
    Caption = 'CVV2'
  end
  object lbProcessing: TLabel [6]
    Left = 108
    Top = 175
    Width = 124
    Height = 13
    Caption = 'Processing ... Please wait!'
    Visible = False
  end
  object Label7: TLabel [7]
    Left = 184
    Top = 73
    Width = 38
    Height = 13
    Caption = '(MMYY)'
  end
  inherited Panel1: TPanel
    Top = 194
    Width = 321
    TabOrder = 9
    inherited EspacamentoInferior: TPanel
      Width = 321
      inherited Panel3: TPanel
        Width = 321
      end
    end
    inherited hhh: TPanel
      Left = 72
      Width = 249
      inherited sbHelp: TSpeedButton
        Left = 38
        Visible = False
      end
      inherited btClose: TButton
        Left = 181
        TabOrder = 1
        TabStop = True
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 111
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        TabOrder = 0
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 188
    TabOrder = 0
  end
  inherited EspacamentoDireito: TPanel
    Left = 318
    Height = 188
    TabOrder = 1
  end
  inherited EspacamentoSuperior: TPanel
    Width = 321
    TabOrder = 2
  end
  object edtCardNumber: TEdit [12]
    Left = 107
    Top = 20
    Width = 169
    Height = 21
    TabOrder = 3
    OnKeyPress = edtCardNumberKeyPress
  end
  object edtMemberName: TEdit [13]
    Left = 107
    Top = 44
    Width = 170
    Height = 21
    TabOrder = 4
    OnKeyPress = edtMemberNameKeyPress
  end
  object edtExpireDate: TEdit [14]
    Left = 107
    Top = 69
    Width = 73
    Height = 21
    MaxLength = 4
    TabOrder = 5
    OnKeyPress = edtExpireDateKeyPress
  end
  object edtStreetAddress: TEdit [15]
    Left = 107
    Top = 94
    Width = 121
    Height = 21
    TabOrder = 6
    OnKeyPress = edtStreetAddressKeyPress
  end
  object edtZipCode: TEdit [16]
    Left = 107
    Top = 119
    Width = 121
    Height = 21
    TabOrder = 7
    OnKeyPress = edtZipCodeKeyPress
  end
  object edtCVV2: TEdit [17]
    Left = 107
    Top = 143
    Width = 120
    Height = 21
    TabOrder = 8
    OnKeyPress = edtCVV2KeyPress
  end
  inherited siLang: TsiLangRT
    Left = 16
    Top = 8
  end
end
