inherited PctMedicalConditionFch: TPctMedicalConditionFch
  Caption = 'Medical Condition'
  ClientHeight = 313
  ClientWidth = 430
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtSubMedicalCondition: TmrDBEdit [0]
    Left = 124
    Top = 105
    Width = 192
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'SubMedicalCondition'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 1
    EditLabel.Width = 114
    EditLabel.Height = 13
    EditLabel.Caption = 'Sub Medical Condition : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object edtMedicalCondition: TmrDBEdit [1]
    Left = 124
    Top = 64
    Width = 192
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'MedicalCondition'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    EditLabel.Width = 93
    EditLabel.Height = 13
    EditLabel.Caption = 'Medical Condition : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object slpMedicalCondSpecies: TmrSubListPanel [2]
    Left = 124
    Top = 148
    Width = 270
    Height = 117
    BevelOuter = bvNone
    Caption = 'TPctMedicalConditionSpeciesSubList'
    Color = clBtnShadow
    TabOrder = 2
    SubListClassName = 'TPctMedicalConditionSpeciesSubList'
    OnGetFilter = slpMedicalCondSpeciesGetFilter
    OnStateChange = slpMedicalCondSpeciesStateChange
    OnGetTransaction = slpMedicalCondSpeciesGetTransaction
    OnGetForeignKeyValue = slpMedicalCondSpeciesGetForeignKeyValue
  end
  inherited pnlBottom: TPanel
    Top = 285
    Width = 430
    TabOrder = 3
    inherited btnOk: TXiButton
      Left = 275
    end
    inherited btnCancel: TXiButton
      Left = 353
    end
  end
  inherited pnlTitulo: TPanel
    Width = 430
    Caption = '  Medical Condition'
    TabOrder = 4
    inherited lbLoop: TLabel
      Left = 375
    end
    inherited btnLoop: TXiButton
      Left = 402
    end
  end
  inherited dsFch: TDataSource
    Left = 84
    Top = 96
  end
  inherited PrintFch: TPrintDialog
    Left = 136
    Top = 100
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    OnAfterNavigation = ConfigFchAfterNavigation
    Left = 24
    Top = 100
  end
end
