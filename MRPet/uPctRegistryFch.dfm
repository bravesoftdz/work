inherited PctRegistryFch: TPctRegistryFch
  Caption = 'Registry'
  ClientHeight = 290
  ClientWidth = 386
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object slpRegistrySpecies: TmrSubListPanel [0]
    Left = 96
    Top = 103
    Width = 245
    Height = 117
    BevelOuter = bvNone
    Caption = 'TPctRegistrySpeciesSubList'
    Color = clBtnShadow
    TabOrder = 1
    SubListClassName = 'TPctRegistrySpeciesSubList'
    OnGetFilter = slpRegistrySpeciesGetFilter
    OnStateChange = slpRegistrySpeciesStateChange
    OnGetTransaction = slpRegistrySpeciesGetTransaction
    OnGetForeignKeyValue = slpRegistrySpeciesGetForeignKeyValue
  end
  object edtRegistry: TmrDBEdit [1]
    Left = 97
    Top = 60
    Width = 168
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Registry'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'Registry : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  inherited pnlBottom: TPanel
    Top = 262
    Width = 386
    TabOrder = 2
    inherited btnOk: TXiButton
      Left = 231
    end
    inherited btnCancel: TXiButton
      Left = 309
    end
  end
  inherited pnlTitulo: TPanel
    Width = 386
    Caption = '  Registry'
    TabOrder = 3
    inherited lbLoop: TLabel
      Left = 331
    end
    inherited btnLoop: TXiButton
      Left = 358
    end
  end
  inherited dsFch: TDataSource
    Left = 88
    Top = 36
  end
  inherited PrintFch: TPrintDialog
    Left = 140
    Top = 40
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    OnAfterNavigation = ConfigFchAfterNavigation
    Left = 28
    Top = 40
  end
end
