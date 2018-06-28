inherited MntSystemUserFch: TMntSystemUserFch
  Caption = 'MntSystemUserFch'
  ClientHeight = 214
  ClientWidth = 359
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 186
    Width = 359
    TabOrder = 3
    inherited btnOk: TXiButton
      Left = 204
    end
    inherited btnCancel: TXiButton
      Left = 282
    end
  end
  inherited pnlTitulo: TPanel
    Width = 359
    TabOrder = 4
    inherited lbLoop: TLabel
      Left = 304
    end
    inherited btnLoop: TXiButton
      Left = 331
    end
  end
  object edtUser: TmrDBEdit [2]
    Left = 119
    Top = 88
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'SystemUser'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 1
    EditLabel.Width = 59
    EditLabel.Height = 13
    EditLabel.Caption = 'User Name :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object edtUserCode: TmrDBEdit [3]
    Left = 119
    Top = 52
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'CodSystemUser'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 0
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Code :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object edtPw: TmrDBEdit [4]
    Left = 119
    Top = 124
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'PW'
    Properties.EchoMode = eemPassword
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 2
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Password :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  inherited dsFch: TDataSource
    Left = 76
    Top = 40
  end
  inherited PrintFch: TPrintDialog
    Left = 128
    Top = 44
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    Left = 16
    Top = 44
  end
end
