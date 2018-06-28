inherited PctColorFch: TPctColorFch
  Caption = 'PctColorFch'
  ClientHeight = 256
  ClientWidth = 366
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 228
    Width = 366
    inherited btnOk: TXiButton
      Left = 211
    end
    inherited btnCancel: TXiButton
      Left = 289
    end
  end
  inherited pnlTitulo: TPanel
    Width = 366
    inherited lbLoop: TLabel
      Left = 311
    end
    inherited btnLoop: TXiButton
      Left = 338
    end
  end
  object edtCode: TmrDBEdit [2]
    Left = 76
    Top = 47
    Width = 225
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Color'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 2
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Color :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object slpColorSpecies: TmrSubListPanel [3]
    Left = 76
    Top = 87
    Width = 270
    Height = 117
    BevelOuter = bvNone
    Caption = 'TPctColorSpeciesSubList'
    Color = clBtnShadow
    TabOrder = 3
    SubListClassName = 'TPctColorSpeciesSubList'
    OnGetFilter = slpColorSpeciesGetFilter
    OnStateChange = slpColorSpeciesStateChange
    OnGetTransaction = slpColorSpeciesGetTransaction
    OnGetForeignKeyValue = slpColorSpeciesGetForeignKeyValue
  end
  inherited dsFch: TDataSource
    Left = 76
    Top = 12
  end
  inherited PrintFch: TPrintDialog
    Left = 128
    Top = 16
  end
  inherited ConfigFch: TmrConfigFch
    Connection = 'PetCenterConn'
    ProviderName = 'dspPetColor'
    OnAfterAppend = ConfigFchAfterAppend
    OnAfterNavigation = ConfigFchAfterNavigation
    Left = 16
    Top = 16
  end
end
