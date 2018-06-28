inherited LoginForm: TLoginForm
  Caption = 'Login'
  ClientHeight = 147
  ClientWidth = 262
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 37
    Top = 52
    Width = 53
    Height = 13
    Alignment = taRightJustify
    Caption = 'Password :'
  end
  inherited pnlBottom: TPanel
    Top = 119
    Width = 262
    TabOrder = 1
    inherited btnOk: TXiButton
      Left = 107
      Default = True
    end
    inherited btnCancel: TXiButton
      Left = 185
    end
  end
  object edPassword: TcxTextEdit
    Left = 97
    Top = 48
    Width = 121
    Height = 21
    Properties.EchoMode = eemPassword
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 0
  end
  object cdsLogin: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLogin'
    Left = 16
    Top = 16
  end
end
