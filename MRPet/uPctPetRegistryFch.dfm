inherited PctPetRegistryFch: TPctPetRegistryFch
  Left = 416
  Top = 224
  Caption = 'PctPetRegistryFch'
  ClientHeight = 177
  ClientWidth = 322
  PixelsPerInch = 96
  TextHeight = 13
  object edtRegistryNum: TmrDBEdit [0]
    Left = 112
    Top = 92
    Width = 145
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'RegistrationNum'
    Properties.ReadOnly = False
    TabOrder = 1
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Reg Num : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scRegistry: TmrDBSuperCombo [1]
    Left = 112
    Top = 55
    Width = 145
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    TabOrder = 0
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPetRegistry'
    ProviderSourceName = 'dspRegistry'
    FchClassName = 'TPctRegistryFch'
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'Registry :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDRegistry'
  end
  inherited pnlBottom: TPanel
    Top = 149
    Width = 322
    TabOrder = 2
    inherited btnOk: TXiButton
      Left = 167
    end
    inherited btnCancel: TXiButton
      Left = 245
    end
  end
  inherited pnlTitulo: TPanel
    Width = 322
    TabOrder = 3
    inherited lbLoop: TLabel
      Left = 267
    end
    inherited btnLoop: TXiButton
      Left = 294
    end
  end
  inherited dsFch: TDataSource
    Left = 80
  end
  inherited PrintFch: TPrintDialog
    Left = 132
  end
  inherited ConfigFch: TmrConfigFch
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 20
  end
end
