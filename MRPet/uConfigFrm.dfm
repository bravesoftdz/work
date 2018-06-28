inherited ConfigFrm: TConfigFrm
  Caption = 'Config'
  ClientHeight = 255
  ClientWidth = 308
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 227
    Width = 308
    inherited btnOk: TXiButton
      Left = 153
    end
    inherited btnCancel: TXiButton
      Left = 231
    end
  end
  object pgConfig: TPageControl
    Left = 0
    Top = 0
    Width = 308
    Height = 227
    ActivePage = tsConnection
    Align = alClient
    TabOrder = 1
    object tsConnection: TTabSheet
      Caption = 'Connection'
      object Label1: TLabel
        Left = 22
        Top = 30
        Width = 86
        Height = 13
        Alignment = taRightJustify
        Caption = 'Connection type :'
      end
      object lbHost: TLabel
        Left = 77
        Top = 68
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'Host :'
      end
      object lbPort: TLabel
        Left = 79
        Top = 147
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Port :'
      end
      object Label2: TLabel
        Left = 55
        Top = 106
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Client ID : '
      end
      object cbxConnectionType: TComboBox
        Left = 116
        Top = 26
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 0
        Items.Strings = (
          'DCOM'
          'Socket'
          'Web')
      end
      object edtHost: TEdit
        Left = 116
        Top = 64
        Width = 119
        Height = 21
        TabOrder = 1
        Text = 'edtHost'
      end
      object edtPort: TEdit
        Left = 116
        Top = 143
        Width = 119
        Height = 21
        TabOrder = 2
        Text = 'edtPort'
      end
      object edtClientID: TEdit
        Left = 116
        Top = 102
        Width = 119
        Height = 21
        TabOrder = 3
        Text = 'edtClientID'
      end
    end
    object tsPetCenter: TTabSheet
      Caption = 'Pet Center'
      ImageIndex = 1
      object pgPetCenter: TPageControl
        Left = 0
        Top = 0
        Width = 300
        Height = 199
        ActivePage = tsBreeder
        Align = alClient
        TabOrder = 0
        object tsBreeder: TTabSheet
          Caption = 'Breeder'
          object lbBreederInfo: TLabel
            Left = 20
            Top = 31
            Width = 253
            Height = 33
            AutoSize = False
            Caption = 
              'Select default group you want to assign a Breeder when you creat' +
              'e it.'
            WordWrap = True
          end
          object scEntityType: TmrSuperCombo
            Left = 100
            Top = 84
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
                Visible = False
              end>
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 0
            OnBeforeGetRecordsList = scEntityTypeBeforeGetRecordsList
            DisableButtons = False
            ConnectionListName = 'LookUpMaintenanceConn'
            ProviderListName = 'dspLuEntityType'
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Breeder :'
            LabelPosition = lpLeft
            LabelSpacing = 6
            Required = False
            Locked = False
            DependentLookUps = <>
          end
        end
        object tsInventory: TTabSheet
          Caption = 'Inventory'
          ImageIndex = 1
          object scMicrochip: TmrSuperCombo
            Left = 92
            Top = 24
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
                Visible = False
              end>
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 0
            OnBeforeGetRecordsList = scMicrochipBeforeGetRecordsList
            DisableButtons = False
            ConnectionListName = 'LookUpInventoryConn'
            ProviderListName = 'dspLuCategory'
            EditLabel.Width = 51
            EditLabel.Height = 13
            EditLabel.Caption = 'Microchip :'
            LabelPosition = lpLeft
            LabelSpacing = 6
            Required = False
            Locked = False
            DependentLookUps = <>
          end
          object scPet: TmrSuperCombo
            Left = 92
            Top = 67
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
                Visible = False
              end>
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 1
            OnBeforeGetRecordsList = scPetBeforeGetRecordsList
            DisableButtons = False
            ConnectionListName = 'LookUpInventoryConn'
            ProviderListName = 'dspLuCategory'
            EditLabel.Width = 23
            EditLabel.Height = 13
            EditLabel.Caption = 'Pet :'
            LabelPosition = lpLeft
            LabelSpacing = 6
            Required = False
            Locked = False
            DependentLookUps = <>
          end
          object scKitPet: TmrSuperCombo
            Left = 92
            Top = 112
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
                Visible = False
              end>
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 2
            OnBeforeGetRecordsList = scKitPetBeforeGetRecordsList
            DisableButtons = False
            ConnectionListName = 'LookUpInventoryConn'
            ProviderListName = 'dspLuCategory'
            EditLabel.Width = 38
            EditLabel.Height = 13
            EditLabel.Caption = 'Pet Kit :'
            LabelPosition = lpLeft
            LabelSpacing = 6
            Required = False
            Locked = False
            DependentLookUps = <>
          end
        end
        object tsStore: TTabSheet
          Caption = 'Store'
          ImageIndex = 2
          object scStore: TmrSuperCombo
            Left = 92
            Top = 24
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
                Visible = False
              end>
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 0
            DisableButtons = False
            ConnectionListName = 'LookUpMaintenanceConn'
            ProviderListName = 'dspLuStore'
            EditLabel.Width = 71
            EditLabel.Height = 13
            EditLabel.Caption = 'Default Store :'
            LabelPosition = lpLeft
            LabelSpacing = 6
            Required = False
            Locked = False
            DependentLookUps = <>
          end
        end
        object tsWarrantyRep: TTabSheet
          Caption = 'Warranty'
          ImageIndex = 3
          DesignSize = (
            292
            171)
          object Label3: TLabel
            Left = 8
            Top = 12
            Width = 285
            Height = 33
            AutoSize = False
            Caption = 'Use this option to create and edit the warranty reports.'
            WordWrap = True
          end
          object lbPrinter: TLabel
            Left = 40
            Top = 83
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Print to :'
          end
          object btnEditReport: TXiButton
            Left = 94
            Top = 119
            Width = 128
            Height = 24
            ColorFace = 14737632
            ColorGrad = 3653375
            ColorDark = 11447982
            ColorLight = 16250871
            ColorBorder = 6447714
            ColorText = clBlack
            OverColorFace = 13619151
            OverColorGrad = 41968
            OverColorDark = 7960953
            OverColorLight = 15658734
            OverColorBorder = 7697781
            OverColorText = clBlack
            DownColorFace = 13882323
            DownColorGrad = 7852799
            DownColorDark = 15329769
            DownColorLight = 8158332
            DownColorBorder = 5131854
            DownColorText = clBlack
            DisabledColorFace = 14869218
            DisabledColorGrad = clWhite
            DisabledColorDark = 14211288
            DisabledColorLight = 15395562
            DisabledColorBorder = 12895428
            DisabledColorText = clGray
            ColorFocusRect = 9079434
            ColorScheme = csSilver
            Ctl3D = True
            Layout = blGlyphLeft
            Glyph.Data = {
              76030000424D7603000000000000360000002800000011000000100000000100
              1800000000004003000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFC8C6C3806850806050806050
              706050705840705840705040705040604830604830604830A29A92FF00FFFF00
              FF00FF00FFC1C4C3A38D85E0D0C0B0A090B0A090B0A090B0A090B0A090B0A090
              B0A090B0A090B0A090B0A090604830FF00FFFF00FF00FF00FFBCB7B0B29C94FF
              E8E0FFF8F0FFF0E0FFE8E0F0D8D0F0D0B0F0C0A000A00000A00000A000705840
              604830857767FF00FF00FF00FFB29485E0D8D0FFFFFFFFFFFFFFFFFFFFFFFFFF
              F0F0F0E0E0F0D8C000FF1000FFB000A000806850705040604830FF00FF00FF00
              FFB09080F0E8E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0E8E000FF1000
              FF1000A000907060706050604830FF00FF00FF00FFB09880D0C0B0D0B8B0C0B0
              A0B0A090B09880A0888090807090706080686080605070585090807080686070
              5840FF00FF00FF00FFC0A090FFF8F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFF8F0FFF0F0F0F0F0F0E8E0A08880907860806050FF00FF00FF00FFCEC9C3
              B6A18CD0B0A0C0A8A0D0B0A0C0A090B09080A080709070608060507060508070
              60B0A090A08870806050FF00FF00FF00FFFF00FFCBC7C2C0B0A0E0C8C0FFFFFF
              FFF8FFFFF8FFFFF0F0F0F0E0F0E0E0C0A8A0806050A09080C0B0A0806050FF00
              FF00FF00FFFF00FFFF00FFDEDFDDC0B0A0FFFFFFF0E8E0D0C8C0D0C8C0D0B8B0
              D0C0B0E0D0D0806860806050B09890B0A090FF00FF00FF00FFFF00FFFF00FFFF
              00FFD8CBBCF0E8E0FFFFFFFFFFFFFFFFFFFFF8FFFFF0F0F0E0D0D0B8B0806050
              BAADA8FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFE5E5E6D0B8B0FFFFFFF0
              F0F0D0C8C0D0C8C0D0B8B0C0B0B0E0D8D0807060866859FF00FFFF00FF00FF00
              FFFF00FFFF00FFFF00FFFF00FFDED5D3E0D1D1FFFFFFFFFFFFFFFFFFFFFFFFFF
              F8FFF0E8E0D0B8B0806050FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFDFD6D3D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0D0C0B0FF
              00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
            Spacing = 4
            TransparentGlyph = True
            Gradient = False
            HotTrack = True
            Anchors = [akTop, akRight]
            Caption = '&Edit Warranty Form'
            TabOrder = 0
            OnClick = btnEditReportClick
          end
          object chkPreview: TCheckBox
            Left = 89
            Top = 45
            Width = 169
            Height = 17
            Caption = 'Preview before print'
            TabOrder = 1
          end
          object cbxDefaultPrint: TcxComboBox
            Left = 89
            Top = 80
            Width = 184
            Height = 21
            Style.StyleController = DMPetCenter.cxStyleController
            TabOrder = 2
          end
        end
        object tsPrintServer: TTabSheet
          Caption = 'Print Server'
          ImageIndex = 4
          TabVisible = False
          object Label4: TLabel
            Left = 36
            Top = 48
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = 'IP Address :'
          end
          object Label5: TLabel
            Left = 68
            Top = 85
            Width = 27
            Height = 13
            Alignment = taRightJustify
            Caption = 'Port :'
          end
          object edtPrintIP: TcxTextEdit
            Left = 106
            Top = 45
            Width = 121
            Height = 21
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 0
          end
          object edtPrintPort: TcxTextEdit
            Left = 106
            Top = 81
            Width = 121
            Height = 21
            Style.StyleController = DMMaintenance.cxStyleController
            TabOrder = 1
            Text = '1555'
          end
        end
        object tsKey: TTabSheet
          Caption = 'License'
          ImageIndex = 5
          DesignSize = (
            292
            171)
          object Label6: TLabel
            Left = 20
            Top = 44
            Width = 63
            Height = 13
            Alignment = taRightJustify
            Caption = 'License Key :'
          end
          object lbKey: TLabel
            Left = 88
            Top = 45
            Width = 31
            Height = 13
            Caption = 'lbKey'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 28
            Top = 75
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'Expiration :'
          end
          object lbExpiration: TLabel
            Left = 88
            Top = 76
            Width = 26
            Height = 13
            Caption = 'lbKey'
          end
          object btnKey: TXiButton
            Left = 102
            Top = 119
            Width = 107
            Height = 24
            ColorFace = 14737632
            ColorGrad = 3653375
            ColorDark = 11447982
            ColorLight = 16250871
            ColorBorder = 6447714
            ColorText = clBlack
            OverColorFace = 13619151
            OverColorGrad = 41968
            OverColorDark = 7960953
            OverColorLight = 15658734
            OverColorBorder = 7697781
            OverColorText = clBlack
            DownColorFace = 13882323
            DownColorGrad = 7852799
            DownColorDark = 15329769
            DownColorLight = 8158332
            DownColorBorder = 5131854
            DownColorText = clBlack
            DisabledColorFace = 14869218
            DisabledColorGrad = clWhite
            DisabledColorDark = 14211288
            DisabledColorLight = 15395562
            DisabledColorBorder = 12895428
            DisabledColorText = clGray
            ColorFocusRect = 9079434
            ColorScheme = csSilver
            Ctl3D = True
            Layout = blGlyphLeft
            Spacing = 4
            TransparentGlyph = True
            Gradient = False
            HotTrack = True
            Anchors = [akTop, akRight]
            Caption = 'Update license'
            TabOrder = 0
            OnClick = btnKeyClick
          end
        end
      end
    end
  end
end
