inherited PctPetTreatmentFch: TPctPetTreatmentFch
  Caption = 'PctPetTreatmentFch'
  ClientHeight = 343
  ClientWidth = 454
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object scTreatment: TmrDBSuperCombo [0]
    Left = 102
    Top = 83
    Width = 319
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.OnChange = scTreatmentPropertiesChange
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end
      item
        Glyph.Data = {
          EE010000424DEE0100000000000036000000280000000D0000000B0000000100
          180000000000B801000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF203040FF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3050604078C0
          304860FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF30
          50703080D04098E050B0F0506870FF00FF00FF00FFFF00FFFF00FFFF00FF7068
          6060686050586040709040A0E060C8FF7090A0FF00FFFF00FF00FF00FFFF00FF
          909090B0A8A0D0C0B0D0B0A08078705058506090B07098B0FF00FFFF00FFFF00
          FF00FF00FFB0B0B0C0B8B0FFF0E0FFE8E0F0D8C0F0D0B0807870949298FF00FF
          FF00FFFF00FFFF00FF00FF00FFA09890F0E8E0FFF8F0FFF0F0FFE8E0F0D8D0D0
          B0A0606861FF00FFFF00FFFF00FFFF00FF00FF00FFA0A090F0E8E0FFFFFFFFF8
          F0FFF0F0FFE8E0E0C0B06E6F6FFF00FFFF00FFFF00FFFF00FF00FF00FFC0C8C0
          C0C0C0FFFFFFFFFFFFFFF8F0FFF0E0B0A0909C9EA0FF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFC0B8B0C0C0C0F0E8E0F0E8E0B0B0A0707060FF00FFFF00FF
          FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFC0C8C0A0A090909080909090FF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        Kind = bkGlyph
      end>
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 2
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPetTreatment'
    ProviderSourceName = 'dspTreatment'
    FchClassName = 'TPctTreatmentFch'
    SchClassName = 'TPctPetTreatmentSearch'
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'Treatment : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <
      item
        LookUp = scTreatmentLot
      end>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDTreatment'
  end
  object scTreatmentLot: TmrDBSuperCombo [1]
    Left = 102
    Top = 115
    Width = 319
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.OnEditValueChanged = scTreatmentLotPropertiesEditValueChanged
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 3
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ProviderListName = 'dspLuPetTreatmentLot'
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'Treatment Lot : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDTreatmentLot'
  end
  object scSystemUser: TmrDBSuperCombo [2]
    Left = 277
    Top = 47
    Width = 142
    Height = 21
    TabStop = False
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
    TabOrder = 1
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ProviderListName = 'dspLuSystemUser'
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'User : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDUser'
  end
  object edtExpirationDate: TmrDBDateEdit [3]
    Left = 298
    Top = 146
    Width = 122
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'ExpirationDate'
    Properties.ReadOnly = False
    Properties.ShowTime = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 6
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Exp. Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtTreatmentDate: TmrDBDateEdit [4]
    Left = 103
    Top = 146
    Width = 122
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'TreatmentDate'
    Properties.ReadOnly = False
    Properties.ShowTime = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 7
    EditLabel.Width = 83
    EditLabel.Height = 13
    EditLabel.Caption = 'Treatment Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtDosesUsed: TmrDBEdit [5]
    Left = 103
    Top = 180
    Width = 119
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'DosesUsed'
    Properties.ReadOnly = False
    Style.Color = clWindow
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 8
    EditLabel.Width = 63
    EditLabel.Height = 13
    EditLabel.Caption = 'Doses Used :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object memNotes: TmrDBMemo [6]
    Left = 103
    Top = 215
    Width = 316
    Height = 46
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Notes'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 9
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Notes :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scPet: TmrDBSuperCombo [7]
    Left = 102
    Top = 48
    Width = 129
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
      end
      item
        Glyph.Data = {
          EE010000424DEE0100000000000036000000280000000D0000000B0000000100
          180000000000B801000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF203040FF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3050604078C0
          304860FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF30
          50703080D04098E050B0F0506870FF00FF00FF00FFFF00FFFF00FFFF00FF7068
          6060686050586040709040A0E060C8FF7090A0FF00FFFF00FF00FF00FFFF00FF
          909090B0A8A0D0C0B0D0B0A08078705058506090B07098B0FF00FFFF00FFFF00
          FF00FF00FFB0B0B0C0B8B0FFF0E0FFE8E0F0D8C0F0D0B0807870949298FF00FF
          FF00FFFF00FFFF00FF00FF00FFA09890F0E8E0FFF8F0FFF0F0FFE8E0F0D8D0D0
          B0A0606861FF00FFFF00FFFF00FFFF00FF00FF00FFA0A090F0E8E0FFFFFFFFF8
          F0FFF0F0FFE8E0E0C0B06E6F6FFF00FFFF00FFFF00FFFF00FF00FF00FFC0C8C0
          C0C0C0FFFFFFFFFFFFFFF8F0FFF0E0B0A0909C9EA0FF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFC0B8B0C0C0C0F0E8E0F0E8E0B0B0A0707060FF00FFFF00FF
          FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFC0C8C0A0A090909080909090FF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        Kind = bkGlyph
      end>
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPet'
    ProviderSourceName = 'dspPet'
    FchClassName = 'TPctPetFch'
    SchClassName = 'TPctPetSearch'
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'SKU :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDPet'
  end
  inherited pnlBottom: TPanel
    Top = 315
    Width = 454
    TabOrder = 5
    inherited btnOk: TXiButton
      Left = 299
    end
    inherited btnCancel: TXiButton
      Left = 377
    end
  end
  inherited pnlTitulo: TPanel
    Width = 454
    TabOrder = 4
    inherited lbLoop: TLabel
      Left = 399
    end
    inherited btnLoop: TXiButton
      Left = 426
    end
  end
  inherited ConfigFch: TmrConfigFch
    Connection = 'PetCenterConn'
    ProviderName = 'dspPetTreatment'
    OnAfterAppend = ConfigFchAfterAppend
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
  end
end
