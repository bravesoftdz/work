inherited WizImportPO: TWizImportPO
  Left = 149
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Wizard Import PO'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgOption: TPageControl
    ActivePage = tsConfigFile
    inherited tsSpecificConfig: TTabSheet
      OnShow = tsSpecificConfigShow
      object gbSupplier: TGroupBox
        Left = 121
        Top = 58
        Width = 442
        Height = 213
        Caption = '  Purchase Order file information  '
        TabOrder = 0
        object Label3: TLabel
          Left = 64
          Top = 80
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Vendor :'
        end
        object Label11: TLabel
          Left = 43
          Top = 132
          Width = 61
          Height = 13
          Alignment = taRightJustify
          Caption = 'PO Number :'
        end
        object Label12: TLabel
          Left = 9
          Top = 106
          Width = 95
          Height = 13
          Alignment = taRightJustify
          Caption = 'Document Number :'
        end
        object Label13: TLabel
          Left = 73
          Top = 24
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Store :'
        end
        object Label14: TLabel
          Left = 76
          Top = 52
          Width = 28
          Height = 13
          Alignment = taRightJustify
          Caption = 'User :'
        end
        object Label15: TLabel
          Left = 220
          Top = 106
          Width = 67
          Height = 13
          Alignment = taRightJustify
          Caption = 'Record Date :'
        end
        object Label16: TLabel
          Left = 235
          Top = 131
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'Due Date :'
        end
        object Freight: TLabel
          Left = 66
          Top = 157
          Width = 38
          Height = 13
          Caption = 'Freight :'
        end
        object Label17: TLabel
          Left = 48
          Top = 185
          Width = 56
          Height = 13
          Caption = 'Other Cost :'
        end
        object Label19: TLabel
          Left = 401
          Top = 22
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
        object Label18: TLabel
          Left = 401
          Top = 50
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
        object Label21: TLabel
          Left = 401
          Top = 77
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
        object Label2: TLabel
          Left = 401
          Top = 103
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
        object Label4: TLabel
          Left = 401
          Top = 130
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
          Left = 112
          Top = 76
          Width = 285
          Height = 21
          ItemHeight = 0
          TabOrder = 2
        end
        object edPONumber: TEdit
          Left = 112
          Top = 128
          Width = 81
          Height = 21
          TabOrder = 4
        end
        object edPurchaseNumber: TEdit
          Left = 112
          Top = 102
          Width = 81
          Height = 21
          TabOrder = 3
        end
        object dbRecordDate: TDateBox
          Left = 292
          Top = 102
          Width = 105
          Height = 21
          TabOrder = 7
        end
        object dbDueDate: TDateBox
          Left = 292
          Top = 129
          Width = 105
          Height = 21
          TabOrder = 8
        end
        object edFreight: TEdit
          Left = 112
          Top = 153
          Width = 81
          Height = 21
          TabOrder = 5
        end
        object edOtherCost: TEdit
          Left = 112
          Top = 181
          Width = 81
          Height = 21
          TabOrder = 6
        end
        object cbxStore: TcxLookupComboBox
          Left = 112
          Top = 20
          Width = 286
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'IDStore'
          Properties.ListColumns = <
            item
              FieldName = 'Store'
            end>
          Properties.ListOptions.GridLines = glNone
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = DMImportExport.dtsLookupStore
          Style.BorderStyle = ebs3D
          TabOrder = 0
        end
        object cbxUser: TcxLookupComboBox
          Left = 112
          Top = 48
          Width = 286
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.KeyFieldNames = 'IDUser'
          Properties.ListColumns = <
            item
              FieldName = 'User'
            end>
          Properties.ListOptions.GridLines = glNone
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = DMImportExport.dtsLookupUser
          Style.BorderStyle = ebs3D
          TabOrder = 1
        end
      end
    end
    inherited tsDatabase: TTabSheet
      inherited grdFile: TcxGrid
        inherited grdFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
        end
      end
    end
    inherited tsCrossColumn: TTabSheet
      inherited sgColumns: TStringGrid
        OnExit = sgColumnsExit
      end
      inherited btClean: TBitBtn
        TabOrder = 4
      end
      object cbxCostIncCaseCost: TCheckBox
        Left = 244
        Top = 16
        Width = 257
        Height = 17
        Caption = 'Cost column includes case cost'
        TabOrder = 2
      end
    end
    object tsValidModel: TTabSheet [4]
      Hint = 
        'The following items are new and will be created in your database' +
        '.'
      Caption = 'Validate Model'
      ImageIndex = 6
      object grdValidateModelFile: TcxGrid
        Left = 0
        Top = 28
        Width = 677
        Height = 319
        Align = alClient
        TabOrder = 0
        object grdValidateModelFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object grdValidateModelFileTableViewDBCategory: TcxGridDBColumn
            Caption = 'Category'
            DataBinding.FieldName = 'IDGroup'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'IDCategory'
            Properties.ListColumns = <
              item
                FieldName = 'Category'
              end>
            Properties.ListOptions.GridLines = glNone
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = DMImportExport.dtsLookupCategory
            Width = 208
          end
          object grdValidateModelFileTableViewDBSubCategory: TcxGridDBColumn
            Tag = 1
            Caption = 'SubCategory'
            DataBinding.FieldName = 'IDModelGroup'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'IDSubCategory'
            Properties.ListColumns = <
              item
                FieldName = 'SubCategory'
              end>
            Properties.ListOptions.GridLines = glNone
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = DMImportExport.dtsLookupSubCategory
            Width = 268
          end
          object grdValidateModelFileTableViewDBGroup: TcxGridDBColumn
            Tag = 2
            Caption = 'Group'
            DataBinding.FieldName = 'IDModelSubGroup'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.KeyFieldNames = 'IDGroup'
            Properties.ListColumns = <
              item
                FieldName = 'ModelGroup'
              end>
            Properties.ListOptions.GridLines = glNone
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = DMImportExport.dtsLookupGroup
            Width = 199
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
        Color = clBtnShadow
        TabOrder = 1
        object btnExport: TBitBtn
          Left = 5
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Export'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnExportClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E000000000000000000008000FF8000FF
            8000FF8486840000000000000000000000000000000000000000000000000000
            000000000000000000008000FF8000FF8000FF848684C6C7C6C6C7C6C6C7C6C6
            C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C60000008000FF8000FF
            8000FF848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFC6C7C60000008000FF8000FF8000FF848684FFFFFFC6C7C6C6C7C6C6
            C7C6C6C7C6FFFFFFC6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600008600
            008600008600008600008600008600008600008600008600C6C7C6FFFFFFC6C7
            C6FFFFFFC6C7C6000000008600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF008600FFFFFFFFFFFFC6C7C6FFFFFFC6C7C6000000008600FFFFFF
            008600008600008600008600008600008600008600008600FFFFFFFFFFFFFFFF
            FFFFFFFFC6C7C6000000008600FFFFFF008600008600008600C6C7C600860000
            8600008600008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
            FFFFFF008600C6C7C6008600008600008600FFFFFF008600FFFFFFFFFFFFC6C7
            C6FFFFFFC6C7C6000000008600FFFFFF008600C6C7C6008600008600008600FF
            FFFFFFFFFF008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
            C6C7C6008600008600008600008600008600FFFFFF008600FFFFFFFFFFFFC6C7
            C6FFFFFFC6C7C6000000008600FFFFFF008600008600FFFFFFFFFFFF00860000
            8600FFFFFF008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008600FFFFFFFFFFFF0000
            0000000000000000000000860000860000860000860000860000860000860000
            8600008600008600FFFFFFFFFFFF848684FFFFFF0000008000FF8000FF8000FF
            8000FF848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8486
            840000008000FF8000FF8000FF8000FF8000FF84868484868484868484868484
            86848486848486848486848486848486848000FF8000FF8000FF}
        end
      end
    end
    object tsList: TTabSheet [5]
      Hint = 'It shows the results of the validation of the file. '
      Caption = 'Result of the Validation '
      ImageIndex = 5
      object grdListFile: TcxGrid
        Left = 0
        Top = 29
        Width = 677
        Height = 318
        Align = alClient
        TabOrder = 0
        object grdListFileTableView: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OnCustomDrawCell = grdListFileTableViewCustomDrawCell
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          Preview.Visible = True
        end
        object cxGridLevel1: TcxGridLevel
          GridView = grdListFileTableView
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 1
        object btnExport2: TBitBtn
          Left = 5
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Export'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnExport2Click
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E000000000000000000008000FF8000FF
            8000FF8486840000000000000000000000000000000000000000000000000000
            000000000000000000008000FF8000FF8000FF848684C6C7C6C6C7C6C6C7C6C6
            C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C60000008000FF8000FF
            8000FF848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFC6C7C60000008000FF8000FF8000FF848684FFFFFFC6C7C6C6C7C6C6
            C7C6C6C7C6FFFFFFC6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600008600
            008600008600008600008600008600008600008600008600C6C7C6FFFFFFC6C7
            C6FFFFFFC6C7C6000000008600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF008600FFFFFFFFFFFFC6C7C6FFFFFFC6C7C6000000008600FFFFFF
            008600008600008600008600008600008600008600008600FFFFFFFFFFFFFFFF
            FFFFFFFFC6C7C6000000008600FFFFFF008600008600008600C6C7C600860000
            8600008600008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
            FFFFFF008600C6C7C6008600008600008600FFFFFF008600FFFFFFFFFFFFC6C7
            C6FFFFFFC6C7C6000000008600FFFFFF008600C6C7C6008600008600008600FF
            FFFFFFFFFF008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
            C6C7C6008600008600008600008600008600FFFFFF008600FFFFFFFFFFFFC6C7
            C6FFFFFFC6C7C6000000008600FFFFFF008600008600FFFFFFFFFFFF00860000
            8600FFFFFF008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008600FFFFFFFFFFFF0000
            0000000000000000000000860000860000860000860000860000860000860000
            8600008600008600FFFFFFFFFFFF848684FFFFFF0000008000FF8000FF8000FF
            8000FF848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8486
            840000008000FF8000FF8000FF8000FF8000FF84868484868484868484868484
            86848486848486848486848486848486848000FF8000FF8000FF}
        end
      end
    end
  end
  inherited OD: TOpenDialog
    Left = 508
    Top = 91
  end
end
