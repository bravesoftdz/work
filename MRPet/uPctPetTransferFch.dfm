inherited PctPetTransferFch: TPctPetTransferFch
  Caption = 'PctPetTransferFch'
  ClientHeight = 289
  ClientWidth = 362
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object scStoreFrom: TmrDBSuperCombo [0]
    Left = 116
    Top = 121
    Width = 154
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
    TabOrder = 2
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ProviderListName = 'dspLuStore'
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'From : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDStoreSource'
  end
  object cdStoreTo: TmrDBSuperCombo [1]
    Left = 116
    Top = 165
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
    TabOrder = 3
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ProviderListName = 'dspLuStore'
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'To : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDStoreDest'
  end
  object edtWhelpDate: TmrDBDateEdit [2]
    Left = 116
    Top = 209
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'TransferDate'
    Properties.ReadOnly = False
    Properties.SaveTime = False
    Properties.ShowTime = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 4
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object scSystemUser: TmrDBSuperCombo [3]
    Left = 116
    Top = 44
    Width = 152
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
    TabOrder = 0
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
  object scPet: TmrDBSuperCombo [4]
    Left = 116
    Top = 83
    Width = 153
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
    TabOrder = 1
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
    Required = True
    Locked = False
    DependentLookUps = <>
    OnStartSearch = scPetStartSearch
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDPet'
  end
  inherited pnlBottom: TPanel
    Top = 261
    Width = 362
    TabOrder = 5
    inherited btnOk: TXiButton
      Left = 207
    end
    inherited btnCancel: TXiButton
      Left = 285
    end
  end
  inherited pnlTitulo: TPanel
    Width = 362
    TabOrder = 6
    inherited lbLoop: TLabel
      Left = 307
    end
    inherited btnLoop: TXiButton
      Left = 334
    end
  end
  inherited dsFch: TDataSource
    Left = 104
    Top = 8
  end
  inherited PrintFch: TPrintDialog
    Left = 156
    Top = 12
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 44
    Top = 12
  end
end
