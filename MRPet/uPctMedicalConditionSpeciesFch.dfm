inherited PctMedicalConditionSpeciesFch: TPctMedicalConditionSpeciesFch
  Caption = 'PctMedicalConditionSpeciesFch'
  ClientHeight = 160
  ClientWidth = 301
  PixelsPerInch = 96
  TextHeight = 13
  object scSpecies: TmrDBSuperCombo [0]
    Left = 87
    Top = 63
    Width = 154
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
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 2
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPetSpecies'
    ProviderSourceName = 'dspSpecies'
    FchClassName = 'TPctSpeciesFch'
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Species : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDSpecies'
  end
  inherited pnlBottom: TPanel
    Top = 132
    Width = 301
    inherited btnOk: TXiButton
      Left = 146
    end
    inherited btnCancel: TXiButton
      Left = 224
    end
  end
  inherited pnlTitulo: TPanel
    Width = 301
    inherited lbLoop: TLabel
      Left = 247
    end
    inherited btnLoop: TXiButton
      Left = 273
    end
  end
  inherited dsFch: TDataSource
    Left = 104
    Top = 40
  end
  inherited PrintFch: TPrintDialog
    Left = 156
    Top = 44
  end
  inherited ConfigFch: TmrConfigFch
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 44
    Top = 44
  end
end
