inherited PctTreatmentFch: TPctTreatmentFch
  Left = 270
  Top = 161
  Caption = 'Treatment'
  ClientHeight = 423
  ClientWidth = 436
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgTreatment: TPageControl [0]
    Left = 109
    Top = 211
    Width = 311
    Height = 161
    ActivePage = tsEspecies
    Style = tsButtons
    TabOrder = 6
    object tsEspecies: TTabSheet
      Caption = 'Species'
      object slpTreatmentSpecies: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 303
        Height = 130
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctTreatmentSpeciesSubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctTreatmentSpeciesSubList'
        OnGetFilter = slpTreatmentSpeciesGetFilter
        OnStateChange = slpTreatmentSpeciesStateChange
        OnGetTransaction = slpTreatmentSpeciesGetTransaction
        OnGetForeignKeyValue = slpTreatmentSpeciesGetForeignKeyValue
      end
    end
    object tsLot: TTabSheet
      Caption = 'Lot'
      ImageIndex = 1
      object slpTreatmentLot: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 303
        Height = 130
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctTreatmentLotSubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctTreatmentLotSubList'
        OnGetFilter = slpTreatmentLotGetFilter
        OnStateChange = slpTreatmentLotStateChange
        OnGetTransaction = slpTreatmentLotGetTransaction
        OnGetForeignKeyValue = slpTreatmentLotGetForeignKeyValue
      end
    end
  end
  object edtTreatmentLotSize: TmrDBEdit [1]
    Left = 109
    Top = 176
    Width = 211
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'TreatmentLotSize'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 3
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'Lot Size : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtMfg: TmrDBEdit [2]
    Left = 109
    Top = 139
    Width = 211
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Mfg'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 2
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Manufacture : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object cmxTreatmentType: TmrDBImageComboBox [3]
    Left = 109
    Top = 101
    Width = 211
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'TreatmentType'
    Properties.Items = <
      item
        Description = 'Vaccine'
        Value = 1
      end
      item
        Description = 'Wormer'
        Value = 2
      end
      item
        Description = 'Preventative'
        Value = 3
      end>
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 1
    EditLabel.Width = 84
    EditLabel.Height = 13
    EditLabel.Caption = 'Treatment Type :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object edtTreatment: TmrDBEdit [4]
    Left = 109
    Top = 64
    Width = 211
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Treatment'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'Treatment : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  inherited pnlBottom: TPanel
    Top = 395
    Width = 436
    TabOrder = 4
    inherited btnOk: TXiButton
      Left = 281
    end
    inherited btnCancel: TXiButton
      Left = 359
    end
  end
  inherited pnlTitulo: TPanel
    Width = 436
    Caption = '  Treatment'
    TabOrder = 5
    inherited lbLoop: TLabel
      Left = 381
    end
    inherited btnLoop: TXiButton
      Left = 408
    end
  end
  inherited dsFch: TDataSource
    Left = 72
  end
  inherited PrintFch: TPrintDialog
    Left = 140
    Top = 28
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    OnAfterNavigation = ConfigFchAfterNavigation
    Left = 12
  end
end
