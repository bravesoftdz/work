inherited PctColorSpeciesFch: TPctColorSpeciesFch
  Caption = 'PctColorSpeciesFch'
  ClientHeight = 153
  ClientWidth = 298
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
    Top = 125
    Width = 298
    inherited btnOk: TXiButton
      Left = 143
    end
    inherited btnCancel: TXiButton
      Left = 221
    end
  end
  inherited pnlTitulo: TPanel
    Width = 298
    inherited lbLoop: TLabel
      Left = 243
    end
    inherited btnLoop: TXiButton
      Left = 270
    end
  end
  inherited dsFch: TDataSource
    Left = 96
    Top = 8
  end
  inherited PrintFch: TPrintDialog
    Left = 148
    Top = 12
  end
  inherited ConfigFch: TmrConfigFch
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 36
    Top = 12
  end
end
