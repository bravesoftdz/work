inherited PctRegistrySpeciesFch: TPctRegistrySpeciesFch
  Caption = 'PctRegistrySpeciesFch'
  ClientHeight = 165
  ClientWidth = 292
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
    Top = 137
    Width = 292
    inherited btnOk: TXiButton
      Left = 137
    end
    inherited btnCancel: TXiButton
      Left = 215
    end
  end
  inherited pnlTitulo: TPanel
    Width = 292
    inherited lbLoop: TLabel
      Left = 237
    end
    inherited btnLoop: TXiButton
      Left = 264
    end
  end
  inherited dsFch: TDataSource
    Left = 88
  end
  inherited PrintFch: TPrintDialog
    Left = 140
  end
  inherited ConfigFch: TmrConfigFch
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 28
  end
end
