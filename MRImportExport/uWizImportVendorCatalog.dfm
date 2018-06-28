inherited WizImportVendorCatalog: TWizImportVendorCatalog
  Left = 194
  Top = 217
  Caption = 'Vendor Catalog Import'
  ClientHeight = 495
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    Left = 5
    Top = 65
    Height = 391
    ActivePage = tsCrossColumn
    inherited tsConfigFile: TTabSheet
      Hint = 'Select a vendor catalog file and associated vendor.'
      inherited cbxBKPDevice: TGroupBox
        Top = 65
        Height = 116
        Caption = 
          '  Select a text file that contain the data to import  and the ve' +
          'ndor '
      end
    end
    inherited tsSpecificConfig: TTabSheet
      object GroupBox1: TGroupBox
        Left = 115
        Top = 63
        Width = 446
        Height = 98
        Caption = ' Vendor Catalog file information '
        TabOrder = 0
        object Label3: TLabel
          Left = 21
          Top = 31
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Vendor :'
        end
        object Label21: TLabel
          Left = 413
          Top = 28
          Width = 12
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbVendorList: TComboBox
          Left = 69
          Top = 27
          Width = 337
          Height = 21
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    inherited tsDatabase: TTabSheet
      inherited grdFile: TcxGrid
        Height = 360
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
        end
      end
    end
    inherited tsCrossColumn: TTabSheet
      Hint = 
        'Map fields in MainRetail with the fields in the vendor file. If ' +
        'your cost column includes case pricing, the select "Cost column ' +
        'includes case cost!'
      ImageIndex = 2
      inherited sgColumns: TStringGrid
        RowCount = 8
        RowHeights = (
          24
          24
          24
          24
          24
          24
          24
          24)
      end
      inherited cbColumns: TComboBox
        Left = 245
        Top = 259
        Visible = False
      end
      inherited btClean: TBitBtn
        Visible = False
      end
      inherited btSave: TBitBtn
        Visible = False
      end
      object cbxCostIncCaseCost: TCheckBox
        Left = 244
        Top = 16
        Width = 257
        Height = 17
        Caption = 'Cost column includes case cost'
        TabOrder = 4
      end
    end
    inherited tsImport: TTabSheet
      TabVisible = False
    end
    object tsValidModel: TTabSheet
      Hint = 'Vendor File Import'
      Caption = 'Validate Model'
      ImageIndex = 6
      object grdValidateModelFile: TcxGrid
        Left = 0
        Top = 28
        Width = 677
        Height = 332
        Align = alClient
        TabOrder = 0
        OnExit = grdValidateModelFileExit
        object grdValidateModelFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OnCustomDrawCell = grdValidateModelFileTableViewCustomDrawCell
          OptionsCustomize.ColumnFiltering = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object Update: TcxGridDBColumn
            DataBinding.FieldName = 'Update'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayUnchecked = 'False'
            Properties.ImmediatePost = True
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Width = 43
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = grdValidateModelFileTableView
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          677
          28)
        object Label2: TLabel
          Left = 171
          Top = 9
          Width = 61
          Height = 13
          Caption = 'Cost Change'
          Visible = False
        end
        object Label4: TLabel
          Left = 299
          Top = 9
          Width = 8
          Height = 13
          Caption = '%'
          Visible = False
        end
        object btnSelectAll: TBitBtn
          Left = 0
          Top = 1
          Width = 141
          Height = 25
          Hint = 'Select/Unselect All'
          Caption = 'Unselect All'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnSelectAllClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FF848284848284848284FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5C425C334333043E0404
            3E04043E043444345250528481848E778EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF1A341A017201007C00008200008200008200007C000170011140116E6C
            6E8C788CFF00FFFF00FFFF00FFFF00FF164B1600800000820000820000820000
            82000082000082000082000080000E550E6E6C6E8E778EFF00FFFF00FF193319
            00800000820000820000820014881450A4501287120082000082000082000080
            00114011848184FF00FFFF00FF017201008200008200008200148814B2CDB2FA
            FAFA60AA60008200008200008200008200017001525052FF00FFFF00FF007F00
            008200008200148814B2CDB2F8F7F8FBFBFBCCE1CC1087100082000082000082
            00007C00344434848284003E00008200008200008200ACCBACF8F7F88DBB8DC7
            DEC7FCFBFC60AB60008200008200008200008200043E04848284003E00008200
            008200008200399E393D9D3D09850958A758FBFBFBCEE1CE0E860E0082000082
            00008200043E04848284003E000082000082000082000082000082000082000E
            860EC6DDC6FBFBFB60AB60008200008200008200043E04FF00FFFF00FF007F00
            00820000820000820000820000820000820058A658FCFCFCD1E2D10B850B0082
            00007C00334333FF00FFFF00FF01750100820000820000820000820000820000
            82000F870FB2D5B2DAEBDA47A1470082000172015C425CFF00FFFF00FF143514
            0081000082000082000082000082000082000082000082000082000082000080
            001A341AFF00FFFF00FFFF00FFFF00FF124F1200810000820000820000820000
            8200008200008200008200008000164B16FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF143514017501007F00008200008200008200007F00017201193319FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF591459003E0000
            3E00003E005D125DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
        object CbCostChange: TComboBox
          Left = 236
          Top = 5
          Width = 56
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          Visible = False
          OnChange = CbCostChangeChange
          Items.Strings = (
            '0'
            '10'
            '20'
            '30'
            '40'
            '50'
            '60'
            '70'
            '80'
            '90'
            '100')
        end
        object TbItemsOption: TTabControl
          Left = 401
          Top = 0
          Width = 289
          Height = 30
          Anchors = [akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabHeight = 25
          TabOrder = 2
          Tabs.Strings = (
            'Update Items'
            'New Items'
            'Removed Items')
          TabIndex = 0
          OnChange = TbItemsOptionChange
        end
        object BtnConfirmCostChange: TBitBtn
          Left = 367
          Top = 1
          Width = 31
          Height = 25
          Hint = 'Confirm cost change'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Visible = False
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF08850D07850CDB5AAFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFF08850D07E58FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC57E5EF08850D5B4
            A1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFE07840F09060FF00FFFF00FFFF00FFFF00FFFF00FF
            E07840D07040C06840B06030B05830905030FF00FFFF00FFFF00FFC06840F088
            50DABEAEFF00FFFF00FFFF00FFFF00FFE08050E07030F08050F09870E09060FF
            00FFFF00FFFF00FFFF00FFC06840DF8558E8B89DFF00FFFF00FFFF00FFFF00FF
            E09060F08050F09060F0A070AA7969FF00FFFF00FFFF00FFFF00FFC06840DF7E
            49E9B497FF00FFFF00FFFF00FFFF00FFE09870F09870F0A070EF9568B06040B0
            6040CBAB97FF00FFFF00FFA3603ADF7E49E9B497FF00FFFF00FFFF00FFFF00FF
            F0A880FF00FFFF00FFF0B090E09060C07040C06840BB805CB57D53A06040F088
            50ECC3A7FF00FFFF00FFFF00FFFF00FFF0A890FF00FFFF00FFFF00FFF0B090EF
            9568D07040B06840B2673ADF7E49EEBAA3ECC3B5FF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFF0B090EEB69AEDAF8CEDAF8CEDBCA8EEC1
            B2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFECBDA5EDBDA8EBC8B0E6CDC6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        end
      end
    end
  end
  inherited PTitle: TPanel
    Height = 64
    inherited lbEditName: TLabel
      Top = 5
    end
    inherited lbEditDescription: TLabel
      Left = 10
      Top = 23
      Width = 596
      Height = 33
      Caption = 'Select a vendor file associated vendor.'
    end
  end
  inherited Panel1: TPanel
    Top = 456
  end
  inherited imgSmall: TImageList
    Left = 386
    Top = 65522
  end
  inherited OD: TOpenDialog
    Left = 411
    Top = 211
  end
  inherited cdsFile: TClientDataSet
    BeforePost = cdsFileBeforePost
    Left = 429
    Top = 65524
  end
  inherited dtsFile: TDataSource
    Left = 474
    Top = 65522
  end
  inherited SD: TSaveDialog
    Left = 585
    Top = 29
  end
end
