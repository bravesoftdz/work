inherited FrmNewPOAuto: TFrmNewPOAuto
  Left = 668
  Top = 119
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'New PO Auto'
  ClientHeight = 573
  ClientWidth = 792
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgPOAuto: TPageControl [0]
    Left = 0
    Top = 18
    Width = 792
    Height = 327
    ActivePage = tsPOFilter
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 4
    object tsPOFilter: TTabSheet
      Caption = 'Filter'
      object Panel4: TPanel
        Left = 0
        Top = 129
        Width = 784
        Height = 170
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object pnlButtons: TPanel
          Left = 667
          Top = 0
          Width = 117
          Height = 170
          Align = alRight
          TabOrder = 0
          object btSelectAll: TSpeedButton
            Tag = 7
            Left = 3
            Top = 59
            Width = 111
            Height = 26
            Hint = 'Export grid'
            Caption = 'Select all'
            Flat = True
            Glyph.Data = {
              76030000424D7603000000000000360000002800000011000000100000000100
              1800000000004003000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
              C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
              D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
              FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFF00
              0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00
              FFFF00FF808080C8D0D4FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF
              FFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFF
              FF000000000000000000000000000000FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
              00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFF000000000000FFFFFF0000
              00000000000000FFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF
              808080C8D0D4FFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFF
              FFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFC8D0D4FF00FFFF00FFFF00
              FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF000000FFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
              D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
              FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8
              D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00
              FFFF00FF80808080808080808080808080808080808080808080808080808080
              8080808080808080FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
            Margin = 4
            ParentShowHint = False
            ShowHint = True
            Spacing = 5
            OnClick = btSelectAllClick
          end
          object btCreatePO: TSpeedButton
            Tag = 3
            Left = 3
            Top = 143
            Width = 111
            Height = 25
            AllowAllUp = True
            Caption = 'Create PO'
            Flat = True
            Glyph.Data = {
              42030000424D42030000000000003600000028000000110000000F0000000100
              1800000000000C030000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FF00871E
              0096241CBE4D5FD18947AC6A3F9A603E8550FF00FFFF00FFFF00FFFF00FFFF00
              FF00FF00FF0E7F23068B2500A72A0B992A129D330DAB3B18C0564AD28B5ACD8A
              53AD735CB9803AB05BFF00FFFF00FFFF00FFFF00FF00FF00FF00B72604B93F07
              C14E00D35800EB6600F7730DBD652CB06B2BB06E1FD2771BDA712CA150FF00FF
              FF00FFFF00FFFF00FF00FF00FFFF00FF34B580207C4C6F76738F96954E5D5759
              4D55907D8695818A555350878B8AFF00FFFF00FF222572FF00FFFF00FF00FF00
              FFFF00FFFF00FF51484C7C7A7EACA4A95F595D50494C8D898C898789534E4E49
              46504A59A05E67CC0B0EB807265EFF00FF00FF00FFFF00FFFF00FF4E4E4D6B6B
              6B8B8A8D5D5B5E7C7A7EBEBCBDB5B5B76455542515466964E06664D1100FB100
              00A2FF00FF00FF00FFFF00FFFF00FF445042969B95B1B4B267686A8A6265A388
              87977A7C5B1B16180725223A87948AE23838C100009EFF00FF00FF00FFFF00FF
              FF00FFFF00FFA6869EAF82AC898D85E3BDBAFFE7E6DDB2B125536300B1D600AA
              F838519C8780EC0016AEFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFB5B39BFFD8D3276B7D00E1FF00D6FF00ABFF0094EE304A885745A0FF00
              FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB6AF901F727F
              00D6FF19D3FF0AA8FF00A3FE6A28A5FF00FFFF00FF00FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FF39639454F4FF4BFFFF0BEAFF00A2FB
              FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FF8C78AA00FFF500FFFF00FFFF00EDE2FF00FFFF00FFFF00FF00FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF689FAB00
              FDE40EAFA2FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FF00}
            Margin = 7
            Spacing = 8
            OnClick = btCreatePOClick
          end
          object btUnSelectAll: TSpeedButton
            Tag = 7
            Left = 3
            Top = 85
            Width = 111
            Height = 26
            Hint = 'Export grid'
            Caption = 'Un select all'
            Flat = True
            Glyph.Data = {
              EE030000424DEE03000000000000360000002800000012000000110000000100
              180000000000B803000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              0000FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
              C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
              808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
              00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
              0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
              808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
              00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
              0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
              808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4C8D0
              D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF
              00FFFF00FFFF00FF0000FF00FFFF00FF80808080808080808080808080808080
              8080808080808080808080808080808080808080FF00FFFF00FFFF00FFFF00FF
              0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
            Margin = 4
            ParentShowHint = False
            ShowHint = True
            Spacing = 5
            OnClick = btUnSelectAllClick
          end
          object btPOGroup: TSpeedButton
            Tag = 3
            Left = 3
            Top = 2
            Width = 111
            Height = 25
            AllowAllUp = True
            GroupIndex = 88997
            Caption = '&Grouping'
            Flat = True
            Margin = 7
            Spacing = 8
            OnClick = btPOGroupClick
          end
          object btPOColumn: TSpeedButton
            Tag = 4
            Left = 3
            Top = 27
            Width = 111
            Height = 25
            AllowAllUp = True
            GroupIndex = 1235
            Caption = 'Colum&ns'
            Flat = True
            Margin = 6
            Spacing = 7
            OnClick = btPOColumnClick
          end
          object btnItemsDetail: TSpeedButton
            Tag = 4
            Left = 3
            Top = 117
            Width = 111
            Height = 25
            AllowAllUp = True
            GroupIndex = 87742
            Caption = 'Show Details'
            Enabled = False
            Flat = True
            Glyph.Data = {
              5E050000424D5E05000000000000360000002800000014000000160000000100
              18000000000028050000D40E0000D40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF915868885170915868FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF915868915868E2
              8F8DAD66655333336E69688582877461804838785958B23533B8111181636376
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8C5073CA807EF69896FF9E9CB469
              685F2E2F512F2F3635514E4D9D615FC96361CE3634BF0000A511127C6C6D78FF
              00FFFF00FFFF00FFFF00FFFF00FF9B4A6CFD9D9BFF9E9CFF9E9CB46968633031
              5725262725565C5AC76260CD6361CE3634BF0000A70000A4232372FF00FF81A1
              C7ABA2B2FF00FFFF00FF9E4C6EFF9E9CFF9E9CFFA2A0B46F6E5F2C2D4A111119
              16463D3CA05D5BC76A68D03E3DC10000A70000A722227DFF00FF81A1C77086BA
              ABA2B2FF00FF9D4E6DFFA19FFFB3B1FFCDCCD2A7A6622F304709090B213C0D4B
              814550A28B8ADF7777DC0D0EAE0000A622227FFF00FFA693F859A8F06E87BFAB
              A2B29F7E7EFFCECDFFD9D8F9CDCCDEB5B4595E67194E6000B5DF00B0F70E75BE
              4356A77171D85B5CD70F0FAC222282FF00FFFF00FFA798FC519FEA6981B9B9A2
              ACFCD1D0FFCFCEE0B5B554727C02AAD100C7F500CFFF00B7FF009AF80C6FB946
              50A26867D44241BF272781FF00FFFF00FFFF00FFA893FB5FAAEF7C8BA89D8684
              E0B6AED7B5AC7BA1A743C7E510CCF800CEFE00B7FF009EFF009CFD095C9B4B4A
              8B753998FF00FFFF00FFFF00FFFF00FFFF00FFA893FBC0A7BEC4A894E6D3AEF3
              E9C7F4EBD1D3D5D389BECE07CEFD04B7FF009EFF009EFF0D649BFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE9ACC5F6DFB5FEF4C5FFFEDDFEFD
              F3FDFBF8E5D7CC69D5E13DE2FF02A9FF009EFF186FA4FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFE9AFBCFDE5B6FFEFC0FFFEDDFFFDF1FFFDF0
              FBF4D565C7C100FDFF00DBFF00A9FF1970A5FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFECB4BFFEEABAFFEBB9FFF9CFFFFDDBFFFDDAFEF8CC66
              C7C100FFFF00FCFE00D0F12471A0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFEAB1C6FAEFD9FFEBCBFEEAB8FEEEBCFEF4C4F2DAB35ACECA00ED
              ED10C4C45068A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFEDD3D9FBF0E3FDEABCFBE8BAF5D7B2B07F7E1FB4BA45899DFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFE1B5B9E7D1B4E7CDB9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FF}
            Margin = 7
            Spacing = 5
            OnClick = btnItemsDetailClick
          end
          object Label1: TLabel
            Left = 15
            Top = 176
            Width = 31
            Height = 13
            Caption = 'Total :'
          end
          object lbTotalOrder: TLabel
            Left = 48
            Top = 176
            Width = 22
            Height = 13
            Caption = '0.00'
          end
          object lbWeight: TLabel
            Left = 5
            Top = 193
            Width = 41
            Height = 13
            Alignment = taRightJustify
            Caption = 'Weight :'
          end
          object lbTotalWeight: TLabel
            Left = 48
            Top = 193
            Width = 22
            Height = 13
            Caption = '0.00'
          end
          object lbMinPO: TLabel
            Left = 6
            Top = 213
            Width = 40
            Height = 13
            Alignment = taRightJustify
            Caption = 'Min PO :'
          end
          object lbMinAmount: TLabel
            Left = 49
            Top = 213
            Width = 22
            Height = 13
            Caption = '0.00'
          end
          object pnlDivisoria2: TPanel
            Left = 8
            Top = 114
            Width = 101
            Height = 2
            BevelOuter = bvLowered
            TabOrder = 0
          end
          object Panel9: TPanel
            Left = 8
            Top = 55
            Width = 101
            Height = 2
            BevelOuter = bvLowered
            TabOrder = 1
          end
          object Panel10: TPanel
            Left = 8
            Top = 170
            Width = 101
            Height = 2
            BevelOuter = bvLowered
            TabOrder = 2
          end
          object Panel: TPanel
            Left = 8
            Top = 209
            Width = 101
            Height = 2
            BevelOuter = bvLowered
            TabOrder = 3
          end
          object gbLegend: TGroupBox
            Left = 4
            Top = 232
            Width = 107
            Height = 65
            Caption = ' Legend '
            TabOrder = 4
            object lbOnPO: TLabel
              Left = 24
              Top = 42
              Width = 45
              Height = 13
              Caption = 'On Order'
            end
            object shpOnPO: TShape
              Left = 4
              Top = 41
              Width = 14
              Height = 14
              Brush.Color = 33023
              Pen.Color = 33023
            end
            object cbShowLegend: TCheckBox
              Left = 4
              Top = 18
              Width = 97
              Height = 17
              Caption = 'Show'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
          end
        end
        object grdPOFilter: TcxGrid
          Left = 0
          Top = 0
          Width = 667
          Height = 170
          Align = alClient
          TabOrder = 1
          LookAndFeel.Kind = lfFlat
          object grdPOFilterDB: TcxGridDBTableView
            OnKeyUp = grdPOFilterDBKeyUp
            DataController.DataSource = dtsRequest
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDModel'
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubSellingPrice'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubFinalCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubVendorCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubFreightCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubOtherCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubRealMarkUpValue'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubSuggRetail'
              end
              item
                Format = '0'
                Kind = skSum
                Position = spFooter
                FieldName = 'PositiveQty'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubSellingPrice'
              end>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OnCustomDrawCell = grdPOFilterDBCustomDrawCell
            OnFocusedItemChanged = grdPOFilterDBFocusedItemChanged
            Filtering.MaxDropDownCount = 50
            Filtering.Visible = fvNever
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLines = glHorizontal
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfVisibleWhenExpanded
            OptionsView.HeaderAutoHeight = True
            OptionsView.HeaderEndEllipsis = True
            Preview.AutoHeight = False
            Preview.MaxLineCount = 2
            Styles.Selection = cxHilight
            OnColumnHeaderClick = grdPOFilterDBColumnHeaderClick
            OnCustomization = grdPOFilterDBCustomization
            object grdPOFilterDBMarked: TcxGridDBColumn
              Caption = ' '
              DataBinding.FieldName = 'Marked'
              Options.Grouping = False
              Options.Moving = False
              Width = 20
            end
            object grdPOFilterDBModel: TcxGridDBColumn
              DataBinding.FieldName = 'Model'
              Visible = False
              Options.Editing = False
              Width = 73
            end
            object grdPOFilterDBDescription: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Options.Editing = False
              Options.Moving = False
              Width = 137
            end
            object grdPOFilterDBVendor: TcxGridDBColumn
              DataBinding.FieldName = 'Vendor'
              Options.Editing = False
              Width = 90
            end
            object grdPOFilterDBStore: TcxGridDBColumn
              DataBinding.FieldName = 'Store'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBCategory: TcxGridDBColumn
              DataBinding.FieldName = 'Category'
              Visible = False
              Options.Editing = False
              Width = 89
            end
            object grdPOFilterDBClasseABC: TcxGridDBColumn
              Caption = 'ABC'
              DataBinding.FieldName = 'ClasseABC'
              Options.Editing = False
              Width = 44
            end
            object grdPOFilterDBMinQty: TcxGridDBColumn
              Caption = 'Min'
              DataBinding.FieldName = 'MinQty'
              Options.Editing = False
              Width = 40
            end
            object grdPOFilterDBMaxQty: TcxGridDBColumn
              Caption = 'Max'
              DataBinding.FieldName = 'MaxQty'
              Options.Editing = False
              Width = 44
            end
            object grdPOFilterDBQtyOnHand: TcxGridDBColumn
              Caption = 'OnHand'
              DataBinding.FieldName = 'QtyOnHand'
              Options.Editing = False
              Width = 54
            end
            object grdPOFilterDBAvgSaleQty: TcxGridDBColumn
              Caption = 'Sales Avg'
              DataBinding.FieldName = 'AvgSaleQty'
              Options.Editing = False
              Options.Filtering = False
              Width = 61
            end
            object grdPOFilterDBAvgSaleWeek: TcxGridDBColumn
              Caption = 'Week Sale Avg'
              DataBinding.FieldName = 'AvgSaleWeek'
              Options.Editing = False
            end
            object grdPOFilterDBAvgSaleMonth: TcxGridDBColumn
              Caption = 'Month Sale Avg'
              DataBinding.FieldName = 'AvgSaleMonth'
              Options.Editing = False
            end
            object grdPOFilterDBUnitType: TcxGridDBColumn
              Caption = 'Type'
              DataBinding.FieldName = 'UnitType'
              Options.Editing = False
              Options.Filtering = False
              Width = 48
            end
            object grdPOFilterDBQtyToOrder: TcxGridDBColumn
              DataBinding.FieldName = 'QtyToOrder'
              Width = 67
            end
            object grdPOFilterDBFinalCost: TcxGridDBColumn
              DataBinding.FieldName = 'FinalCost'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBMSRP: TcxGridDBColumn
              DataBinding.FieldName = 'MSRP'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBSellingPrice: TcxGridDBColumn
              DataBinding.FieldName = 'SellingPrice'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBTotQtyOnHand: TcxGridDBColumn
              DataBinding.FieldName = 'TotQtyOnHand'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBCaseQty: TcxGridDBColumn
              DataBinding.FieldName = 'CaseQty'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBSubCategory: TcxGridDBColumn
              DataBinding.FieldName = 'SubCategory'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBMGroup: TcxGridDBColumn
              DataBinding.FieldName = 'MGroup'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBManufacture: TcxGridDBColumn
              DataBinding.FieldName = 'Manufacture'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBDateRequest: TcxGridDBColumn
              DataBinding.FieldName = 'DateRequest'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBSystemUser: TcxGridDBColumn
              DataBinding.FieldName = 'SystemUser'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBQtySold: TcxGridDBColumn
              DataBinding.FieldName = 'QtySold'
              Visible = False
              Options.Editing = False
              Options.Filtering = False
            end
            object grdPOFilterDBExtCost: TcxGridDBColumn
              DataBinding.FieldName = 'ExtCost'
              Options.Editing = False
              Width = 60
            end
            object grdPOFilterDBQtyOnOrder: TcxGridDBColumn
              Caption = 'Qty On Order'
              DataBinding.FieldName = 'QtyOnOrder'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBQtyPositiveOrdered: TcxGridDBColumn
              Caption = 'QtyPositiveToOrder'
              DataBinding.FieldName = 'QtyPositiveOrdered'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBWeight: TcxGridDBColumn
              DataBinding.FieldName = 'Weight'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBExtWeight: TcxGridDBColumn
              DataBinding.FieldName = 'ExtWeight'
              Visible = False
              Options.Editing = False
            end
            object grdPOFilterDBBarcode: TcxGridDBColumn
              DataBinding.FieldName = 'Barcode'
              Visible = False
              Options.Editing = False
            end
          end
          object grdPOFilterLevel: TcxGridLevel
            GridView = grdPOFilterDB
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 129
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblRequest: TLabel
          Left = 33
          Top = 8
          Width = 47
          Height = 13
          Alignment = taRightJustify
          Caption = 'Request :'
        end
        object lblStore: TLabel
          Left = 379
          Top = 9
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Store :'
        end
        object lblCategory: TLabel
          Left = 362
          Top = 34
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'Category :'
        end
        object lblGroup: TLabel
          Left = 343
          Top = 61
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sub-Category:'
        end
        object lblSubGroup: TLabel
          Left = 381
          Top = 88
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Group:'
        end
        object lblManufect: TLabel
          Left = 8
          Top = 61
          Width = 72
          Height = 13
          Alignment = taRightJustify
          Caption = 'Manufacturer :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblVendor: TLabel
          Left = 39
          Top = 88
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = 'Vendor :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbSales: TLabel
          Left = 21
          Top = 35
          Width = 59
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sales since :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbDay: TLabel
          Left = 237
          Top = 36
          Width = 6
          Height = 13
          Caption = '0'
        end
        object cmbList: TComboBox
          Left = 87
          Top = 5
          Width = 146
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cmbListChange
          Items.Strings = (
            'Min/Max Qty'
            'Auto Request'
            'Sales Qty'
            'All Inventory')
        end
        object scStore: TSuperComboADO
          Left = 419
          Top = 6
          Width = 206
          Height = 21
          TabOrder = 4
          Text = '<-->'
          LookUpSource = DM.dsLookUpStore
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object scCategory: TSuperComboADO
          Left = 419
          Top = 31
          Width = 208
          Height = 21
          TabOrder = 5
          Text = '<-->'
          LookUpSource = DM.dsLookUpGroup
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object btnCategClear: TButton
          Left = 632
          Top = 31
          Width = 34
          Height = 20
          Caption = 'All'
          TabOrder = 6
          TabStop = False
          OnClick = btnCategClearClick
        end
        object scGroup: TSuperComboADO
          Left = 419
          Top = 58
          Width = 208
          Height = 21
          TabOrder = 7
          Text = '<-->'
          LookUpSource = DM.dsLookUpModelGroup
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object btnGroupClear: TButton
          Left = 632
          Top = 58
          Width = 34
          Height = 20
          Caption = 'All'
          TabOrder = 8
          TabStop = False
          OnClick = btnGroupClearClick
        end
        object scSubGroup: TSuperComboADO
          Left = 419
          Top = 85
          Width = 208
          Height = 21
          TabOrder = 9
          Text = '<-->'
          LookUpSource = DM.dsLookUpModelSubGroup
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object btnSubGroupClear: TButton
          Left = 632
          Top = 85
          Width = 34
          Height = 20
          Caption = 'All'
          TabOrder = 10
          TabStop = False
          OnClick = btnSubGroupClearClick
        end
        object scFabricante: TSuperComboADO
          Left = 86
          Top = 58
          Width = 147
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '<-->'
          LookUpSource = DM.dsLookUpFabricante
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object btFabricanteAll: TButton
          Left = 238
          Top = 59
          Width = 34
          Height = 20
          Caption = 'All'
          TabOrder = 11
          TabStop = False
          OnClick = btFabricanteAllClick
        end
        object scVendor: TSuperComboADO
          Left = 86
          Top = 85
          Width = 147
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = '<-->'
          LookUpSource = DM.dsLookUpFornecedor
          DropDownRows = 18
          ShowBtnAddNew = False
          IDLanguage = 0
          OnSelectItem = scVendorSelectItem
        end
        object btnAllVendor: TButton
          Left = 238
          Top = 86
          Width = 34
          Height = 20
          Caption = 'All'
          TabOrder = 12
          TabStop = False
          OnClick = btnAllVendorClick
        end
        object btSearch: TBitBtn
          Left = 687
          Top = 36
          Width = 74
          Height = 27
          Caption = '&Search'
          TabOrder = 13
          OnClick = btSearchClick
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000130B0000130B00000000000000000000FF00FF7D8497
            747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF747DAE4985D6767DAC747DAEFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4B1F75BB9FD
            4589DF707CAF747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFA0A5FA55B5FC4588DE727CAF747DAEFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            A1AFFA57B6FC4689DE747DAE747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1A5FB57B1FC468AD59385A6FF
            00FFFF00FFCEA890CEA890CEA890CEA890FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFA5ADFA95BFE4A69E9EC86DA4E0A5A3EDD5ADF0E4C2F2E7C9EBD6
            BDDE8EBECEA890FE02FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEADA9E6
            C1A0FBF0C2FFFCD1FFFFD9FFFFE7FFFFF6F8F2EED4B6B5CEA890FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFDEB6ABFFEDBCFFEFBAFFFCD0FFFFDFFFFDF2FFFF
            FFFEFEFCEEE1D0D57FB6FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E9D2B4FF
            EABAFFE4B2FFFCD1FFFFDFFFFEF6FFFDFAFFFCF3FCF6D7CBA693FF00FFFF00FF
            FF00FFFF00FFFF00FFCEA890F2E1BCFFE4B2FFE4B2FFF8C9FFFFDAFFFEE6FFFD
            EAFFFEDFFFFDD3D1B7A5FF00FFFF00FFFF00FFFF00FFFF00FFCEA890F1DFBBFF
            F1C3FFE9B6FFECB9FFF9CBFFFDD4FFFDD5FFFDD3FFF6CAD0A993FF00FFFF00FF
            FF00FFFF00FFFF00FFCEA890E7CAB6FFF9E8FFF2DAFFE2BBFFEBB5FFF0BCFFF1
            BDFFF6C4F7E4BCCDA294FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA890F4
            E7E0FEFDFCFFEACBFFE4B3FBDCADFFE8B9FCEEBEDDAA94CEA890FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E8D2CAF9EED1FFF4C3FDF2C1F2E0
            B7DFAF9BCEA890FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFCEA890CCA590CEA890D1B09DD5B1A8CEA890FF00FFFF00FF}
        end
        object cbxReqType: TComboBox
          Left = 237
          Top = 5
          Width = 96
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 14
          Visible = False
          Items.Strings = (
            'All'
            'Computer'
            'Sales Person'
            'HandHeld')
        end
        object dtSale: TDateBox
          Left = 87
          Top = 32
          Width = 146
          Height = 21
          TabOrder = 1
          OnChange = dtSaleChange
        end
        object cbxPrimaryVendor: TCheckBox
          Left = 85
          Top = 109
          Width = 168
          Height = 17
          Caption = 'Only primary vendor'
          TabOrder = 15
        end
      end
    end
    object tsRevise: TTabSheet
      Caption = 'Revise'
      ImageIndex = 1
      object pnlPO: TPanel
        Left = 0
        Top = 0
        Width = 206
        Height = 280
        Align = alLeft
        BevelOuter = bvLowered
        Caption = 'pnlPO'
        TabOrder = 0
        object pnlPODetail: TPanel
          Left = 1
          Top = 158
          Width = 204
          Height = 121
          Align = alBottom
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 0
          object lblObs: TLabel
            Left = 56
            Top = 69
            Width = 26
            Height = 13
            Alignment = taRightJustify
            Caption = 'Obs :'
            Color = clGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblTotal: TLabel
            Left = 47
            Top = 103
            Width = 35
            Height = 13
            Alignment = taRightJustify
            Caption = 'Total :'
            Color = clGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblPOInfo: TLabel
            Left = 0
            Top = 0
            Width = 204
            Height = 17
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'PO Info'
            Color = clBtnShadow
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
          end
          object lblOrderDate: TLabel
            Left = 22
            Top = 35
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = 'Order date :'
            Color = clGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblPayDays: TLabel
            Left = 12
            Top = 18
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Pay in (days) :'
            Color = clGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lblEstArrival: TLabel
            Left = 30
            Top = 52
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'Est Arriv. :'
            Color = clGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object edtTotal: TDBEdit
            Left = 87
            Top = 103
            Width = 111
            Height = 16
            AutoSize = False
            BorderStyle = bsNone
            Color = clBtnFace
            DataField = 'Total'
            DataSource = dtsPO
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edPayDays: TDBEdit
            Left = 87
            Top = 18
            Width = 111
            Height = 16
            AutoSize = False
            BorderStyle = bsNone
            Color = clBtnFace
            DataField = 'PayDays'
            DataSource = dtsPO
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object mmObs: TDBMemo
            Left = 87
            Top = 69
            Width = 111
            Height = 33
            BorderStyle = bsNone
            DataField = 'Obs'
            DataSource = dtsPO
            TabOrder = 2
          end
          object edtOrderDate: TDBDateBox
            Left = 87
            Top = 35
            Width = 111
            Height = 16
            BorderStyle = bsNone
            ReadOnly = False
            TabOrder = 3
            DataField = 'DataPedido'
            DataSource = dtsPO
          end
          object edtEstArriv: TDBDateBox
            Left = 87
            Top = 52
            Width = 111
            Height = 16
            BorderStyle = bsNone
            Color = clBtnFace
            ReadOnly = False
            TabOrder = 4
            DataField = 'EstArrival'
            DataSource = dtsPO
          end
        end
        object grdPO: TcxGrid
          Left = 1
          Top = 1
          Width = 204
          Height = 157
          Align = alClient
          TabOrder = 1
          LookAndFeel.Kind = lfFlat
          object grdPODB: TcxGridDBTableView
            DataController.DataSource = dtsPO
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDVendor;IDStore'
            DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'Total'
              end>
            DataController.Summary.SummaryGroups = <
              item
                Links = <
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end
                  item
                  end>
                SummaryItems = <>
              end>
            Filtering.CustomizeDialog = False
            Filtering.MaxDropDownCount = 1000
            OptionsBehavior.DragOpening = False
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.HideFocusRect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLines = glHorizontal
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            OptionsView.HeaderEndEllipsis = True
            Preview.AutoHeight = False
            Preview.MaxLineCount = 2
            object grdPODBVendor: TcxGridDBColumn
              DataBinding.FieldName = 'Vendor'
            end
            object grdPODBStore: TcxGridDBColumn
              DataBinding.FieldName = 'Store'
            end
            object grdPODBIDStore: TcxGridDBColumn
              DataBinding.FieldName = 'IDStore'
              Visible = False
            end
            object grdPODBIDVendor: TcxGridDBColumn
              DataBinding.FieldName = 'IDVendor'
              Visible = False
            end
          end
          object grdPOLevel: TcxGridLevel
            GridView = grdPODB
          end
        end
      end
      object Panel6: TPanel
        Left = 667
        Top = 0
        Width = 117
        Height = 280
        Align = alRight
        TabOrder = 1
        object btExport: TSpeedButton
          Tag = 7
          Left = 4
          Top = 34
          Width = 111
          Height = 26
          Hint = 'Export grid'
          Caption = 'E&xport'
          Flat = True
          Margin = 4
          ParentShowHint = False
          ShowHint = True
          Spacing = 5
          OnClick = btExportClick
        end
        object btGroup: TSpeedButton
          Tag = 3
          Left = 4
          Top = 64
          Width = 111
          Height = 25
          AllowAllUp = True
          GroupIndex = 88997
          Caption = '&Grouping'
          Flat = True
          Margin = 7
          Spacing = 8
          OnClick = btGroupClick
        end
        object btColumn: TSpeedButton
          Tag = 4
          Left = 4
          Top = 89
          Width = 111
          Height = 25
          AllowAllUp = True
          GroupIndex = 1235
          Caption = 'Colum&ns'
          Flat = True
          Margin = 6
          Spacing = 7
          OnClick = btColumnClick
        end
        object btRemoveItem: TSpeedButton
          Tag = 4
          Left = 3
          Top = 3
          Width = 111
          Height = 25
          AllowAllUp = True
          Caption = 'Remove'
          Flat = True
          Margin = 7
          Spacing = 5
          OnClick = btRemoveItemClick
        end
        object btDetail: TSpeedButton
          Tag = 4
          Left = 4
          Top = 120
          Width = 111
          Height = 25
          AllowAllUp = True
          GroupIndex = 87742
          Caption = 'Show Details'
          Flat = True
          Glyph.Data = {
            5E050000424D5E05000000000000360000002800000014000000160000000100
            18000000000028050000D40E0000D40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF915868885170915868FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF915868915868E2
            8F8DAD66655333336E69688582877461804838785958B23533B8111181636376
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8C5073CA807EF69896FF9E9CB469
            685F2E2F512F2F3635514E4D9D615FC96361CE3634BF0000A511127C6C6D78FF
            00FFFF00FFFF00FFFF00FFFF00FF9B4A6CFD9D9BFF9E9CFF9E9CB46968633031
            5725262725565C5AC76260CD6361CE3634BF0000A70000A4232372FF00FF81A1
            C7ABA2B2FF00FFFF00FF9E4C6EFF9E9CFF9E9CFFA2A0B46F6E5F2C2D4A111119
            16463D3CA05D5BC76A68D03E3DC10000A70000A722227DFF00FF81A1C77086BA
            ABA2B2FF00FF9D4E6DFFA19FFFB3B1FFCDCCD2A7A6622F304709090B213C0D4B
            814550A28B8ADF7777DC0D0EAE0000A622227FFF00FFA693F859A8F06E87BFAB
            A2B29F7E7EFFCECDFFD9D8F9CDCCDEB5B4595E67194E6000B5DF00B0F70E75BE
            4356A77171D85B5CD70F0FAC222282FF00FFFF00FFA798FC519FEA6981B9B9A2
            ACFCD1D0FFCFCEE0B5B554727C02AAD100C7F500CFFF00B7FF009AF80C6FB946
            50A26867D44241BF272781FF00FFFF00FFFF00FFA893FB5FAAEF7C8BA89D8684
            E0B6AED7B5AC7BA1A743C7E510CCF800CEFE00B7FF009EFF009CFD095C9B4B4A
            8B753998FF00FFFF00FFFF00FFFF00FFFF00FFA893FBC0A7BEC4A894E6D3AEF3
            E9C7F4EBD1D3D5D389BECE07CEFD04B7FF009EFF009EFF0D649BFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE9ACC5F6DFB5FEF4C5FFFEDDFEFD
            F3FDFBF8E5D7CC69D5E13DE2FF02A9FF009EFF186FA4FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFE9AFBCFDE5B6FFEFC0FFFEDDFFFDF1FFFDF0
            FBF4D565C7C100FDFF00DBFF00A9FF1970A5FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFECB4BFFEEABAFFEBB9FFF9CFFFFDDBFFFDDAFEF8CC66
            C7C100FFFF00FCFE00D0F12471A0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFEAB1C6FAEFD9FFEBCBFEEAB8FEEEBCFEF4C4F2DAB35ACECA00ED
            ED10C4C45068A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFEDD3D9FBF0E3FDEABCFBE8BAF5D7B2B07F7E1FB4BA45899DFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFE1B5B9E7D1B4E7CDB9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FF}
          Margin = 7
          Spacing = 5
          OnClick = btDetailClick
        end
        object Panel7: TPanel
          Left = 8
          Top = 62
          Width = 101
          Height = 2
          BevelOuter = bvLowered
          TabOrder = 0
        end
        object Panel8: TPanel
          Left = 8
          Top = 116
          Width = 101
          Height = 2
          BevelOuter = bvLowered
          TabOrder = 1
        end
        object pnlSeparator: TPanel
          Left = 8
          Top = 30
          Width = 101
          Height = 2
          BevelOuter = bvLowered
          TabOrder = 2
        end
      end
      object grdPOItem: TcxGrid
        Left = 206
        Top = 0
        Width = 461
        Height = 280
        Align = alClient
        TabOrder = 2
        LookAndFeel.Kind = lfFlat
        object grdPOItemDB: TcxGridDBTableView
          OnKeyUp = grdPOItemDBKeyUp
          DataController.DataSource = dtsPOItem
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDModel;IDVendor;IDStore'
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Total'
            end>
          DataController.Summary.SummaryGroups = <
            item
              Links = <
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end
                item
                end>
              SummaryItems = <>
            end>
          Filtering.CustomizeDialog = False
          Filtering.MaxDropDownCount = 1000
          OptionsBehavior.DragOpening = False
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdPOItemDBModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
          end
          object grdPOItemDBDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
          end
          object grdPOItemDBQtyOrdered: TcxGridDBColumn
            Caption = 'Qty Ordered'
            DataBinding.FieldName = 'QtyOrdered'
            Options.IncSearch = False
          end
          object grdPOItemDBCaseQtyOrdered: TcxGridDBColumn
            DataBinding.FieldName = 'CaseQtyOrdered'
            Options.IncSearch = False
          end
          object grdPOItemDBCostPrice: TcxGridDBColumn
            DataBinding.FieldName = 'CostPrice'
            Options.IncSearch = False
          end
          object grdPOItemDBSalePrice: TcxGridDBColumn
            DataBinding.FieldName = 'SalePrice'
            Options.IncSearch = False
          end
          object grdPOItemDBSuggRetail: TcxGridDBColumn
            DataBinding.FieldName = 'SuggRetail'
            Options.IncSearch = False
          end
          object grdPOItemDBIDModel: TcxGridDBColumn
            DataBinding.FieldName = 'IDModel'
            Visible = False
          end
          object grdPOItemDBIDStore: TcxGridDBColumn
            DataBinding.FieldName = 'IDStore'
            Visible = False
          end
          object grdPOItemDBIDVendor: TcxGridDBColumn
            DataBinding.FieldName = 'IDVendor'
            Visible = False
          end
        end
        object grdPOItemLevel: TcxGridLevel
          GridView = grdPOItemDB
        end
      end
    end
  end
  inherited Panel2: TPanel
    Width = 792
    DesignSize = (
      792
      40)
    inherited Image1: TImage
      Width = 565
    end
    inherited lblMenu: TLabel
      Left = 576
    end
    inherited EspacamentoSuperior: TPanel
      Width = 792
      inherited EEE: TPanel
        Width = 792
      end
    end
  end
  inherited Panel1: TPanel
    Top = 532
    Width = 792
    inherited EspacamentoInferior: TPanel
      Width = 792
      inherited Panel3: TPanel
        Width = 792
      end
    end
    inherited hhh: TPanel
      Left = 505
      Width = 287
      object spHelp: TSpeedButton [0]
        Tag = 5
        Left = 6
        Top = 3
        Width = 65
        Height = 17
        Caption = '&Help'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D002000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFF3E1D7F4E3D9F4E3DAF3E2D8F3E1D7FF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFF4E3D8F8FAFBE4E2E2CFB1A2D4
          AB96DDC6BBECF1F0F6F3F2F2E1D6FF00FFFF00FFFF00FF000000FF00FFFF00FF
          F5EAE2F4FFFFCF9A80B74C15B9643CD9AF9AC05823B95624D5AF9FF7FFFFF4E2
          D9FF00FFFF00FF000000FF00FFF2E1D7F8FFFFC77D58BB450CC64E13C2A495FF
          FFFFD9926FC14A0FB8450BCE9A80F8FFFFF2E0D6FF00FF000000FF00FFFAFAF9
          D8A890BD480DCD622ECD6029CB6B3AD88E68CA5E29CC622DC95D29B94710E0C9
          BDF6EDE8FF00FF000000F3E0D7F8FAFBC56232CA5C26CE6733CB5B23CA8969F7
          E7DFD06B38CA5A23CD6531C3531BC77850F8FCFDDCC8BE000000F3E1D8F2DED6
          C5561ECE6632CC6531CC5A21C28669FFFFFFE8AD91C44A0FCC622DCB5F28C35E
          2BF3F2F1F1DFD5000000F2E1D9F3D8CACD5B22CF6632CC642FCC602BC4551FCF
          B5A8FFFFFFE09C7AC7531ACD602BC65E29F5F1EDEFDED4000000F1E0D7FBEDE6
          DB6A32D36833CA5E28C95821C95419C14B10E2D0C6FFFFFFD0703FCD5A20CE6A
          38FCFBFBEEDDD2000000F1DED4FFFFFFF5986AE2662AC88B6DF0EAE3D77E51BD
          3000D79C7EFFFFFFDA8C65D15314E29A76FEFDFED3BDB2000000FF00FFF6F1EF
          FFEADBFF8A49DE875CEEFFFFFEFCFDE7B9A1FAFFFFF3F9FEE0723CE67035FFF3
          EEF4E7E0FF00FF000000FF00FFF1DED4FFFFFFFFE9CEFFB270ECAF87ECE2DFEB
          F0F4F1E4E0F6A478FE8C4DFFDECAFDFFFFF0DDD2FF00FF000000FF00FFFF00FF
          F0DFD6FFFFFFFFFFFBFFF3C6FEDDA8FCCF98FFC991FFD4A9FFFEF8FCFFFFF1DF
          D4FF00FFFF00FF000000FF00FFFF00FFFF00FFF1DCD3F5E8E4FDFCFDFFFFFFFF
          FFFFFFFFFFFCFBFDF3E6E0F1DDD2FF00FFFF00FFFF00FF000000FF00FFFF00FF
          FF00FFFF00FFFF00FFF1DCD1EFDBD0EFDBD1EFDCD1F1DBD0FF00FFFF00FFFF00
          FFFF00FFFF00FF000000}
        Margin = 5
        ParentFont = False
        OnClick = spHelpClick
      end
      object btnVideo: TSpeedButton [1]
        Tag = 5
        Left = 6
        Top = 19
        Width = 65
        Height = 16
        Caption = '&Video'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          D6020000424DD60200000000000036000000280000000F0000000E0000000100
          180000000000A002000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FF84474091251A961E1607A5CA07A5CA19839C556A6EFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFA4331AB23011BA4327BA4F362B
          C7EC2BC7EC17C0E801AFD9226E80FF00FFFF00FFFF00FF000000FF00FFFF00FF
          B43B12C24D1DC8622FCE6A36D17A5143CCED43CCED4AC7E53AC4E402BBE82072
          84FF00FFFF00FF000000FF00FFB85328CB5B1BD0661DDE8F56F6DDCAFEF9F6F9
          FEFFD2F2FA73D6ED47C8E53BC3E301AFDA567179FF00FF000000FF00FFCE5C16
          DA741EE99C54F0EFEA888E93BEC0C1FBF9F9FFFFFFFFFFFF78D8EE48C7E51BC0
          E8138BA7FF00FF000000D0804AE17618EF8D21F4DEC1E9F1F81E1D1D131313A7
          A7A7CFCFCFFFFDFCE3F7FC4ACBEA37C5E707A8D0FF00FF000000CF7F46DE832B
          E9A448EAE7E0E9F1F84847481B1B1B0404041C1C1CCFCFCFE3E0E068D5ED38C0
          DE06A8CDFF00FF0000005373F01B4AFF4D73FFDADCE1E9F1F84847484E4E4E21
          2121080808646464EAE8E855B499288A72065A49FF00FF0000005373F01B4AFF
          4D73FFC5CBE1E9F1F84847486B6B6B797979C7C7C7FFFEFFE1EEE92CA1771C81
          5F0A533AFF00FF000000FF00FF1B48F84C71FF9EAFF5E9F1F86B6B6BC6C6C4EB
          E9E9F4EBEEF7EAEF67C4A0149B6D05734F2A6150FF00FF000000FF00FF3E63F4
          2E59FE5376FFA1B1F1C7CBDBD9D8D8D9D8D7C3DCD35FCEA301A96D068D610167
          45FF00FFFF00FF000000FF00FFFF00FF244EF7315AFE5376FF5D7DFF597AF530
          D1A80DD58401B773019C66017A4E578375FF00FFFF00FF000000FF00FFFF00FF
          FF00FF385EF51B47F9234DFC224EF901B99101BE7101A065098A5C689685FF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FF8EA2F25876EB3258EC1A
          A58B29AE785AA98CFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Margin = 5
        ParentFont = False
        OnClick = btnVideoClick
      end
      inherited btClose: TButton
        Left = 213
        Top = 4
        Cancel = True
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btNavigate: TButton
        Left = 143
        Top = 4
        Width = 66
        Height = 31
        Caption = 'Next >>'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btNavigateClick
      end
      object btBack: TButton
        Left = 73
        Top = 4
        Width = 66
        Height = 31
        Caption = '<< Back'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        Visible = False
        OnClick = btBackClick
      end
    end
    object pnlProgress: TPanel
      Left = 4
      Top = 11
      Width = 503
      Height = 29
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object lbProgress: TLabel
        Left = 230
        Top = 8
        Width = 89
        Height = 13
        Alignment = taRightJustify
        Caption = 'Creating PO Num :'
      end
      object pb: TProgressBar
        Left = 323
        Top = 8
        Width = 177
        Height = 16
        TabOrder = 0
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Width = 0
    Height = 300
  end
  inherited EspacamentoDireito: TPanel
    Left = 792
    Width = 0
    Height = 300
  end
  object slModelDetail: TSubListPanel [5]
    Left = 0
    Top = 340
    Width = 792
    Height = 192
    Align = alBottom
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 5
    Visible = False
    SubListClassName = 'TSubModelDetail'
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmNewPOAuto.sil'
    Left = 44
    Top = 4
  end
  object dtsRequest: TDataSource
    DataSet = cdsRequest
    OnDataChange = dtsRequestDataChange
    Left = 328
    Top = 260
  end
  object quMin: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quMinCalcFields
    CommandText = 
      'SELECT'#13#10#9'0 as IDRequest,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description' +
      ','#13#10#9'M.ClasseABC,'#13#10#9'(CASE IsNull(MV.VendorCost, 0) WHEN 0 THEN M.' +
      'FinalCost ELSE IsNull(MV.VendorCost, 0) END) as FinalCost,'#13#10#9'M.S' +
      'uggRetail as MSRP,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'(CASE W' +
      'HEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.' +
      'CaseQty END) as CaseQty,'#13#10#9'M.Peso as Weight,'#13#10#9'(M.Peso * 0) as E' +
      'xtWeight,'#13#10#9'TG.Name as Category,'#13#10#9'MG.ModelGroup as SubCategory,' +
      #13#10#9'MGS.ModelSubGroup as MGroup,'#13#10#9'F.Pessoa as Manufacture,'#13#10#9'INV' +
      '.StoreID as IDStore,'#13#10#9'INV.UltimaMovimentacao as DateRequest,'#13#10#9 +
      'INV.QtyOnHand,'#13#10#9'PO.QtyOnOrder,'#13#10#9'INV.MaxQty,'#13#10#9'INV.MinQty,'#13#10#9'IM' +
      'V.Qty as QtySold,'#13#10#9'((IsNull(INV.MaxQty,0) - IsNull(INV.QtyOnHan' +
      'd,0)) - IsNull(PO.QtyOnOrder,0)) as QtyOrdered,'#13#10#9'CASE WHEN (CAS' +
      'E WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE ' +
      'MV.CaseQty END) > 1 THEN IsNull(Round((((IsNull(INV.MaxQty,0) - ' +
      'IsNull(INV.QtyOnHand,0)) - IsNull(PO.QtyOnOrder,0))/(CASE WHEN I' +
      'SNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQ' +
      'ty END))+0.4, 0), 0) ELSE 0 END as CaseQtyOrdered,'#13#10#9'S.Name as S' +
      'tore,'#13#10#9#39'System'#39' as [SystemUser],'#13#10#9'CAST(0 as Bit) as Marked,'#13#10#9 +
      'MV.IDPessoa as IDVendor,'#13#10#9'V.Pessoa as Vendor,'#13#10#9'(M.FinalCost * ' +
      '0) as ExtCost,'#13#10#9'B.IDBarcode as Barcode,'#13#10#9'CASE WHEN ((CASE WHEN' +
      ' ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.Cas' +
      'eQty END) > 1) THEN (CASE WHEN IsNull(Round((((IsNull(INV.MaxQty' +
      ',0) - IsNull(INV.QtyOnHand,0)) - IsNull(PO.QtyOnOrder,0))/(CASE ' +
      'WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV' +
      '.CaseQty END))+0.4, 0), 0) < MV.MinQtyPO THEN MV.MinQtyPO'#13#10#9#9#9#9#9 +
      #9'       ELSE IsNull(Round((((IsNull(INV.MaxQty,0) - IsNull(INV.Q' +
      'tyOnHand,0)) - IsNull(PO.QtyOnOrder,0))/(CASE WHEN ISNULL(MV.Cas' +
      'eQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty END))+0.4' +
      ', 0), 0) END) '#13#10#9'     ELSE (CASE WHEN ((IsNull(INV.MaxQty,0) - I' +
      'sNull(INV.QtyOnHand,0)) - IsNull(PO.QtyOnOrder,0)) < MV.MinQtyPO' +
      ' THEN MV.MinQtyPO'#13#10#9#9'        ELSE ((IsNull(INV.MaxQty,0) - IsNul' +
      'l(INV.QtyOnHand,0)) - IsNull(PO.QtyOnOrder,0)) END) END as QtyTo' +
      'Order'#9#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (' +
      'M.GroupID = TG.IDGroup)'#13#10#9'LEFT JOIN Barcode B (NOLOCK) ON (B.IDM' +
      'odel = M.IDModel and B.BarcodeOrder = 1)'#13#10#9'LEFT OUTER JOIN Model' +
      'Group MG (NOLOCK)ON (M.IDModelGroup = MG.IDModelGroup)'#13#10#9'LEFT OU' +
      'TER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.' +
      'IDModelSubGroup)'#13#10#9'LEFT OUTER JOIN Pessoa F (NOLOCK) ON (F.IDPes' +
      'soa = M.IDFabricante)'#13#10#9'JOIN Inventory INV (NOLOCK)ON (INV.Model' +
      'ID = M.IDModel)'#13#10#9'JOIN Store S (NOLOCK) ON (INV.StoreID = S.IDSt' +
      'ore)'#13#10#9'JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDMod' +
      'el and IsNull(MV.VendorOrder,-1) = IsNull(:VendorOrder, IsNull(M' +
      'V.VendorOrder,-1)))'#13#10#9'JOIN Pessoa V (NOLOCK) ON (V.IDPessoa = MV' +
      '.IDPessoa)'#13#10#9'LEFT JOIN (SELECT'#13#10#9#9#9'PIM.ModelID,'#13#10#9#9#9'PIM.StoreID,' +
      #13#10#9#9#9'SUM(IsNull(PIM.Qty, 0) - IsNull(PIM.QtyRealMov, 0)) as QtyO' +
      'nOrder'#13#10#9#9'FROM'#13#10#9#9#9'PO (NOLOCK) '#13#10#9#9#9'JOIN PreInventoryMov PIM (NO' +
      'LOCK) ON (PIM.InventMovTypeID = 2 AND PIM.DocumentID = PO.IDPO)'#13 +
      #10#9#9'WHERE'#13#10#9#9#9'PO.Aberto = 1'#13#10#9#9'GROUP BY'#13#10#9#9#9'PIM.ModelID,'#13#10#9#9#9'PIM.' +
      'StoreID'#13#10#9#9') PO ON (PO.ModelID = INV.ModelID AND PO.StoreID = IN' +
      'V.StoreID)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID,'#13#10#9#9#9'SUM(' +
      'IsNull(IMV.Qty, 0)) as Qty'#13#10#9#9'FROM'#13#10#9#9#9'Inventory I (NOLOCK) '#13#10#9#9 +
      #9'LEFT JOIN InventoryMov IMV (NOLOCK) ON (I.ModelID = IMV.ModelID' +
      ' AND I.StoreID = IMV.StoreID AND IMV.InventMovTypeID = 1 AND IMV' +
      '.MovDate >=:MovDate)'#13#10#9#9'GROUP BY'#13#10#9#9#9'I.StoreID,'#13#10#9#9#9'I.ModelID'#13#10#9 +
      #9') IMV ON (IMV.StoreID = S.IDStore AND IMV.ModelID = M.IDModel)'#13 +
      #10'WHERE'#13#10#9'INV.StoreID = IsNull(:IDStore, INV.StoreID)'#13#10#9'AND'#13#10#9'IsN' +
      'ull(M.IDModelGroup, -1) = IsNull(:IDModelGroup, IsNull(M.IDModel' +
      'Group, -1))'#13#10#9'AND'#13#10#9'IsNull(M.IDModelSubGroup, -1) = IsNull(:IDMo' +
      'delSubGroup, IsNull(M.IDModelSubGroup, -1))'#13#10#9'AND'#13#10#9'IsNull(INV.M' +
      'inQty,0) >= INV.QtyOnHand'#13#10#9'AND'#13#10#9'M.GroupID = IsNull(:IDGroup, M' +
      '.GroupID)'#13#10#9'AND'#13#10'      '#9'IsNull(MV.IDPessoa,-1) = IsNull(:IDPesso' +
      'a, IsNull(MV.IDPessoa,-1))'#13#10#9'AND'#13#10#9'IsNull(M.IDFabricante,-1) = I' +
      'sNull(:IDFabricante, IsNull(M.IDFabricante,-1))'#13#10#9'AND'#13#10#9'M.ModelT' +
      'ype IN ('#39'R'#39','#39'S'#39')'#13#10#9'AND'#13#10#9'IsNull(INV.MinQty,0) <> 0'#13#10#9'AND'#13#10#9'IsNul' +
      'l(INV.MaxQty,0) <> 0'#13#10#9'AND'#13#10#9'((IsNull(INV.MaxQty,0) - IsNull(INV' +
      '.QtyOnHand,0)) > IsNull(PO.QtyOnOrder,0))'#13#10#9'AND'#13#10#9'M.Desativado =' +
      ' 0'#13#10#9'AND'#13#10#9'M.Hidden = 0'#13#10'        AND'#13#10'        MV.DoNotOrder = 0'#13 +
      #10'GROUP BY'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.ClasseABC' +
      ','#13#10#9'M.FinalCost,'#13#10#9'M.SuggRetail,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnH' +
      'and,'#13#10#9'M.CaseQty,'#13#10#9'MV.CaseQty,'#13#10#9'M.Peso,'#13#10#9'TG.Name,'#13#10#9'MG.ModelG' +
      'roup,'#13#10#9'MGS.ModelSubGroup,'#13#10#9'F.Pessoa,'#13#10#9'INV.StoreID,'#13#10#9'INV.Ulti' +
      'maMovimentacao,'#13#10#9'INV.QtyOnHand,'#13#10#9'INV.QtyOnOrder,'#13#10#9'INV.MinQty,' +
      #13#10#9'INV.MaxQty,'#13#10#9'S.Name,'#13#10#9'MV.IDPessoa,'#13#10#9'V.Pessoa,'#13#10#9'PO.QtyOnOr' +
      'der,'#13#10#9'IMV.Qty,'#13#10#9'MV.MinQtyPO,'#13#10#9'MV.VendorCost,'#13#10#9'B.IDBarcode'
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'VendorOrder'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 216
    Top = 208
    object quMinIDRequest: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object quMinIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quMinIDVendor: TIntegerField
      FieldName = 'IDVendor'
      ReadOnly = True
    end
    object quMinIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quMinModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object quMinDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object quMinClasseABC: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object quMinFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quMinMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quMinSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quMinTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
    end
    object quMinCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object quMinCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object quMinSubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object quMinMGroup: TStringField
      FieldName = 'MGroup'
      ReadOnly = True
      Size = 30
    end
    object quMinManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object quMinDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object quMinQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object quMinMaxQty: TFloatField
      FieldName = 'MaxQty'
      ReadOnly = True
    end
    object quMinMinQty: TFloatField
      FieldName = 'MinQty'
      ReadOnly = True
    end
    object quMinSystemUser: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 6
    end
    object quMinQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
    end
    object quMinCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
    end
    object quMinMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quMinVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quMinStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quMinUnitType: TStringField
      FieldKind = fkCalculated
      FieldName = 'UnitType'
      Size = 10
      Calculated = True
    end
    object quMinQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object quMinQtyToOrder: TFloatField
      FieldName = 'QtyToOrder'
    end
    object quMinExtCost: TCurrencyField
      FieldName = 'ExtCost'
      DisplayFormat = '#,##0.00'
    end
    object quMinAvgSaleQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleQty'
      ReadOnly = True
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quMinAvgSaleWeek: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleWeek'
      ReadOnly = True
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quMinAvgSaleMonth: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleMonth'
      ReadOnly = True
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quMinQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
      ReadOnly = True
    end
    object quMinWeight: TCurrencyField
      FieldName = 'Weight'
      ReadOnly = True
      DisplayFormat = '0.####'
    end
    object quMinExtWeight: TCurrencyField
      FieldName = 'ExtWeight'
      DisplayFormat = '0.####'
    end
    object quMinBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
  end
  object dspRequest: TDataSetProvider
    DataSet = quMin
    Options = [poIncFieldProps]
    Left = 264
    Top = 208
  end
  object cdsRequest: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDRequest'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'IDModel'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'IDVendor'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'IDStore'
        DataType = ftInteger
      end
      item
        Name = 'Model'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Description'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ClasseABC'
        Attributes = [faReadonly, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FinalCost'
        Attributes = [faReadonly]
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'MSRP'
        Attributes = [faReadonly]
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'SellingPrice'
        Attributes = [faReadonly]
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'TotQtyOnHand'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'CaseQty'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'Category'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'SubCategory'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MGroup'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Manufacture'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DateRequest'
        Attributes = [faReadonly]
        DataType = ftDateTime
      end
      item
        Name = 'QtyOnHand'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'MaxQty'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'MinQty'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'SystemUser'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'QtyOrdered'
        DataType = ftFloat
      end
      item
        Name = 'CaseQtyOrdered'
        DataType = ftFloat
      end
      item
        Name = 'Marked'
        DataType = ftBoolean
      end
      item
        Name = 'Vendor'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Store'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'UnitType'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'QtySold'
        DataType = ftFloat
      end
      item
        Name = 'QtyToOrder'
        DataType = ftFloat
      end
      item
        Name = 'ExtCost'
        DataType = ftCurrency
      end
      item
        Name = 'AvgSaleQty'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'AvgSaleWeek'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'AvgSaleMonth'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'QtyOnOrder'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'Weight'
        Attributes = [faReadonly]
        DataType = ftCurrency
      end
      item
        Name = 'ExtWeight'
        DataType = ftCurrency
      end
      item
        Name = 'Barcode'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'dspRequest'
    StoreDefs = True
    AfterOpen = cdsRequestAfterOpen
    BeforePost = cdsRequestBeforePost
    OnCalcFields = cdsRequestCalcFields
    Left = 328
    Top = 208
    object cdsRequestIDRequest: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object cdsRequestIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object cdsRequestIDVendor: TIntegerField
      FieldName = 'IDVendor'
      ReadOnly = True
    end
    object cdsRequestIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsRequestModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsRequestDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsRequestClasseABC: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsRequestFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      Precision = 19
    end
    object cdsRequestMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      Precision = 19
    end
    object cdsRequestSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      Precision = 19
    end
    object cdsRequestTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
    end
    object cdsRequestCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object cdsRequestCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object cdsRequestSubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object cdsRequestMGroup: TStringField
      FieldName = 'MGroup'
      ReadOnly = True
      Size = 30
    end
    object cdsRequestManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object cdsRequestDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object cdsRequestQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object cdsRequestMaxQty: TFloatField
      FieldName = 'MaxQty'
      ReadOnly = True
    end
    object cdsRequestMinQty: TFloatField
      FieldName = 'MinQty'
      ReadOnly = True
    end
    object cdsRequestSystemUser: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 6
    end
    object cdsRequestQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
    end
    object cdsRequestCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
    end
    object cdsRequestMarked: TBooleanField
      FieldName = 'Marked'
    end
    object cdsRequestVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsRequestStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsRequestUnitType: TStringField
      FieldName = 'UnitType'
      ReadOnly = True
      Size = 10
    end
    object cdsRequestQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object cdsRequestAvgSaleQty: TFloatField
      FieldName = 'AvgSaleQty'
      ReadOnly = True
    end
    object cdsRequestQtyToOrder: TFloatField
      FieldName = 'QtyToOrder'
    end
    object cdsRequestExtCost: TCurrencyField
      FieldName = 'ExtCost'
    end
    object cdsRequestAvgSaleWeek: TFloatField
      FieldName = 'AvgSaleWeek'
      ReadOnly = True
    end
    object cdsRequestAvgSaleMonth: TFloatField
      FieldName = 'AvgSaleMonth'
      ReadOnly = True
    end
    object cdsRequestQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
    end
    object cdsRequestQtyPositiveOrdered: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QtyPositiveOrdered'
      Calculated = True
    end
    object cdsRequestWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '0.####'
    end
    object cdsRequestExtWeight: TCurrencyField
      FieldName = 'ExtWeight'
    end
    object cdsRequestBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
  end
  object cdsPO: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 380
    Top = 208
    object cdsPOIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsPOIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsPOVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsPOStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsPODataPedido: TDateTimeField
      FieldName = 'DataPedido'
    end
    object cdsPOEstArrival: TDateTimeField
      FieldName = 'EstArrival'
    end
    object cdsPOPayDays: TIntegerField
      FieldName = 'PayDays'
    end
    object cdsPOObs: TStringField
      FieldName = 'Obs'
      Size = 255
    end
    object cdsPOTotal: TCurrencyField
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
    end
  end
  object cdsPOItem: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cdsPOItemAfterOpen
    BeforeEdit = cdsPOItemBeforeEdit
    AfterPost = cdsPOItemAfterPost
    Left = 432
    Top = 208
    object cdsPOItemIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsPOItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsPOItemIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsPOItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsPOItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsPOItemQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
    end
    object cdsPOItemCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
    end
    object cdsPOItemCaseQty: TIntegerField
      FieldName = 'CaseQty'
    end
    object cdsPOItemCostPrice: TCurrencyField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsPOItemCaseCost: TCurrencyField
      FieldName = 'CaseCost'
      DisplayFormat = '#,##0.00'
    end
    object cdsPOItemSalePrice: TCurrencyField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsPOItemSuggRetail: TCurrencyField
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsPO: TDataSource
    DataSet = cdsPO
    OnDataChange = dtsPODataChange
    Left = 380
    Top = 260
  end
  object dtsPOItem: TDataSource
    DataSet = cdsPOItem
    OnDataChange = dtsPOItemDataChange
    Left = 432
    Top = 260
  end
  object cmdInsPO: TADOCommand
    CommandText = 
      'INSERT INTO PO (IDPO, IDFornecedor, IDStore, DataPedido, Aberto,' +
      ' SubTotal, EstArrival, PayDays, OBS)'#13#10'VALUES (:IDPO, :IDForneced' +
      'or, :IDStore, :DataPedido, :Aberto, :SubTotal, :EstArrival, :Pay' +
      'Days, :OBS)'
    CommandTimeout = 1800
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPO'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataPedido'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Aberto'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'SubTotal'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'EstArrival'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'PayDays'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 496
    Top = 208
  end
  object cmdInsPOItem: TADOCommand
    CommandText = 
      'INSERT INTO PreInventoryMov (IDPreInventoryMov, InventMovTypeID,' +
      ' StoreID, ModelID, IDPessoa, UserID, DocumentID, MovDate, DateEs' +
      'timatedMov, Qty, CaseQty, CostPrice, CaseCost, SalePrice, SuggRe' +
      'tail)'#13#10'VALUES (:IDPreInventoryMov, :InventMovTypeID, :StoreID, :' +
      'ModelID, :IDPessoa, :UserID, :DocumentID, :MovDate, :DateEstimat' +
      'edMov, :Qty, :CaseQty, :CostPrice, :CaseCost, :SalePrice, :SuggR' +
      'etail)'
    CommandTimeout = 1800
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'InventMovTypeID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'StoreID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ModelID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'UserID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DocumentID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DateEstimatedMov'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'CaseQty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'CaseCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SuggRetail'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    Left = 496
    Top = 260
  end
  object quSales: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quMinCalcFields
    CommandText = 
      'SELECT'#13#10#9'0 as IDRequest,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description' +
      ','#13#10#9'M.ClasseABC,'#13#10#9'(CASE IsNull(MV.VendorCost, 0) WHEN 0 THEN M.' +
      'FinalCost ELSE IsNull(MV.VendorCost, 0) END) as FinalCost,'#13#10#9'M.S' +
      'uggRetail as MSRP,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'(CASE W' +
      'HEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.' +
      'CaseQty END) as CaseQty,'#13#10#9'M.Peso as Weight,'#13#10#9'(M.Peso * 0) as E' +
      'xtWeight,'#13#10#9'TG.Name as Category,'#13#10#9'MG.ModelGroup as SubCategory,' +
      #13#10#9'MGS.ModelSubGroup as MGroup,'#13#10#9'F.Pessoa as Manufacture,'#13#10#9'IM.' +
      'StoreID as IDStore,'#13#10#9'INV.UltimaMovimentacao as DateRequest,'#13#10#9'I' +
      'NV.QtyOnHand,'#13#10#9'INV.QtyOnOrder,'#13#10#9'INV.MaxQty,'#13#10#9'INV.MinQty,'#13#10#9'SU' +
      'M(IM.Qty) as QtySold,'#13#10#9'(SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyO' +
      'nOrder,0)) as QtyOrdered,'#13#10#9'CASE WHEN (CASE WHEN ISNULL(MV.CaseQ' +
      'ty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty END) > 1 TH' +
      'EN  IsNull(Round(((SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder' +
      ',0))/(CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty' +
      ',0) ELSE MV.CaseQty END))+0.4, 0), 0) ELSE 0 END as CaseQtyOrder' +
      'ed,'#13#10#9'S.Name as Store,'#13#10#9#39'System'#39' as [SystemUser],'#13#10#9'CAST(0 as B' +
      'it) as Marked,'#13#10#9'MV.IDPessoa as IDVendor,'#13#10#9'V.Pessoa as Vendor,'#13 +
      #10#9'(M.FinalCost * 0) as ExtCost,'#13#10#9'B.IDBarcode as Barcode,'#13#10#9'CASE' +
      ' WHEN ((CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQ' +
      'ty,0) ELSE MV.CaseQty END) > 1) THEN (CASE WHEN IsNull(Round(((S' +
      'UM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder,0))/(CASE WHEN ISNU' +
      'LL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty ' +
      'END))+0.4, 0), 0) < MV.MinQtyPO THEN MV.MinQtyPO'#13#10#9#9#9#9#9#9'       E' +
      'LSE IsNull(Round(((SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder' +
      ',0))/(CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty' +
      ',0) ELSE MV.CaseQty END))+0.4, 0), 0) END) '#13#10#9'     ELSE (CASE WH' +
      'EN (SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder,0)) < MV.MinQt' +
      'yPO THEN MV.MinQtyPO'#13#10#9#9'        ELSE (SUM(IsNull(IM.Qty, 0)) - I' +
      'sNull(PO.QtyOnOrder,0)) END) END as QtyToOrder'#13#10'FROM'#13#10#9'Inventory' +
      'Mov IM (NOLOCK) '#13#10#9'JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDMo' +
      'del)'#13#10#9'LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel an' +
      'd B.BarcodeOrder = 1)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID ' +
      '= TG.IDGroup)'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDM' +
      'odelGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup MGS' +
      ' (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup)'#13#10#9'LEFT OU' +
      'TER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante)'#13#10#9'JO' +
      'IN Inventory INV (NOLOCK) ON (INV.ModelID = IM.ModelID AND IM.St' +
      'oreID = INV.StoreID)'#13#10#9'JOIN Store S (NOLOCK) ON (IM.StoreID = S.' +
      'IDStore)'#13#10#9'JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.I' +
      'DModel and IsNull(MV.VendorOrder,-1) = IsNull(:VendorOrder, IsNu' +
      'll(MV.VendorOrder,-1)))'#13#10#9'JOIN Pessoa V (NOLOCK) ON (V.IDPessoa ' +
      '= MV.IDPessoa)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID,'#13#10#9#9#9 +
      'SUM(IsNull(PIM.Qty, 0) - IsNull(PIM.QtyRealMov, 0)) as QtyOnOrde' +
      'r'#13#10#9#9'FROM'#13#10#9#9#9'Inventory I (NOLOCK) '#13#10#9#9#9'LEFT JOIN PreInventoryMo' +
      'v PIM (NOLOCK) ON (I.ModelID = PIM.ModelID AND I.StoreID = PIM.S' +
      'toreID AND PIM.InventMovTypeID = 2)'#13#10#9#9#9'LEFT JOIN PO (NOLOCK) ON' +
      ' (PIM.DocumentID = PO.IDPO AND PO.Aberto = 1)'#13#10#9#9'GROUP BY'#13#10#9#9#9'I.' +
      'ModelID,'#13#10#9#9#9'I.StoreID'#13#10#9#9') PO ON (PO.ModelID = INV.ModelID AND ' +
      'PO.StoreID = INV.StoreID)'#13#10'WHERE'#13#10#9'IM.MovDate > :MovDate'#13#10#9'AND'#13#10 +
      #9'IM.InventMovTypeID = 1'#13#10#9'AND'#13#10#9'IM.StoreID = IsNull(:IDStore, IM' +
      '.StoreID)'#13#10#9'AND'#13#10#9'IsNull(M.IDModelGroup, -1) = IsNull(:IDModelGr' +
      'oup, IsNull(M.IDModelGroup, -1))'#13#10#9'AND'#13#10#9'IsNull(M.IDModelSubGrou' +
      'p, -1) = IsNull(:IDModelSubGroup, IsNull(M.IDModelSubGroup, -1))' +
      #13#10#9'AND'#13#10#9'M.GroupID = IsNull(:IDGroup, M.GroupID)'#13#10#9'AND'#13#10'      '#9'I' +
      'sNull(MV.IDPessoa, -1) = IsNull(:IDPessoa, IsNull(MV.IDPessoa, -' +
      '1))'#13#10#9'AND'#13#10#9'IsNull(M.IDFabricante, -1) = IsNull(:IDFabricante, I' +
      'sNull(M.IDFabricante, -1))'#13#10#9'AND '#13#10#9'M.ModelType IN ('#39'R'#39', '#39'S'#39')'#13#10#9 +
      'AND'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.Hidden = 0'#13#10'        AND'#13#10'      ' +
      '  MV.DoNotOrder = 0'#13#10'GROUP BY'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Descri' +
      'ption,'#13#10#9'M.ClasseABC,'#13#10#9'M.FinalCost,'#13#10#9'M.SuggRetail,'#13#10#9'M.Selling' +
      'Price,'#13#10#9'M.TotQtyOnHand,'#13#10#9'M.CaseQty,'#13#10#9'MV.CaseQty,'#13#10#9'M.Peso,'#13#10#9 +
      'TG.Name,'#13#10#9'MG.ModelGroup,'#13#10#9'MGS.ModelSubGroup,'#13#10#9'F.Pessoa,'#13#10#9'IM.' +
      'StoreID,'#13#10#9'INV.UltimaMovimentacao,'#13#10#9'INV.QtyOnHand,'#13#10#9'INV.QtyOnO' +
      'rder,'#13#10#9'INV.MinQty,'#13#10#9'INV.MaxQty,'#13#10#9'S.Name,'#13#10#9'MV.IDPessoa,'#13#10#9'V.P' +
      'essoa,'#13#10#9'PO.QtyOnOrder,'#13#10#9'MV.MinQtyPO,'#13#10#9'MV.VendorCost,'#13#10#9'B.IDBa' +
      'rcode'#13#10'HAVING'#13#10#9'SUM(IsNull(IM.Qty, 0)) > IsNull(PO.QtyOnOrder,0)'
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'VendorOrder'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 216
    Top = 264
    object quSalesIDRequest: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object quSalesIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quSalesModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object quSalesDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object quSalesClasseABC: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object quSalesFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSalesMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSalesSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSalesTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
    end
    object quSalesCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object quSalesCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object quSalesSubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object quSalesMGroup: TStringField
      FieldName = 'MGroup'
      ReadOnly = True
      Size = 30
    end
    object quSalesManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object quSalesIDStore: TIntegerField
      FieldName = 'IDStore'
      ReadOnly = True
    end
    object quSalesDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object quSalesQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object quSalesMaxQty: TFloatField
      FieldName = 'MaxQty'
      ReadOnly = True
    end
    object quSalesMinQty: TFloatField
      FieldName = 'MinQty'
      ReadOnly = True
    end
    object quSalesQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
    end
    object quSalesCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
    end
    object quSalesStore: TStringField
      FieldName = 'Store'
      ReadOnly = True
      Size = 30
    end
    object quSalesSystemUser: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 6
    end
    object quSalesMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quSalesIDVendor: TIntegerField
      FieldName = 'IDVendor'
      ReadOnly = True
    end
    object quSalesVendor: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 50
    end
    object quSalesUnitType: TStringField
      FieldKind = fkCalculated
      FieldName = 'UnitType'
      Size = 10
      Calculated = True
    end
    object quSalesQtySold: TFloatField
      FieldName = 'QtySold'
      ReadOnly = True
    end
    object quSalesAvgSaleQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleQty'
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quSalesQtyToOrder: TFloatField
      FieldName = 'QtyToOrder'
    end
    object quSalesExtCost: TCurrencyField
      FieldName = 'ExtCost'
      DisplayFormat = '#,##0.00'
    end
    object quSalesQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
    end
    object quSalesAvgSaleWeek: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleWeek'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quSalesAvgSaleMonth: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleMonth'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quSalesWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '0.#####'
    end
    object quSalesExtWeight: TCurrencyField
      FieldName = 'ExtWeight'
      DisplayFormat = '0.####'
    end
    object quSalesBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
  end
  object quPreSales: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quMinCalcFields
    CommandText = 
      'SELECT'#13#10#9'0 as IDRequest,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description' +
      ','#13#10#9'M.ClasseABC,'#13#10#9'(CASE IsNull(MV.VendorCost, 0) WHEN 0 THEN M.' +
      'FinalCost ELSE IsNull(MV.VendorCost, 0) END) as FinalCost,'#13#10#9'M.S' +
      'uggRetail as MSRP,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'(CASE W' +
      'HEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.' +
      'CaseQty END) as CaseQty,'#13#10#9'M.Peso as Weight,'#13#10#9'(M.Peso * 0) as E' +
      'xtWeight,'#13#10#9'TG.Name as Category,'#13#10#9'MG.ModelGroup as SubCategory,' +
      #13#10#9'MGS.ModelSubGroup as MGroup,'#13#10#9'F.Pessoa as Manufacture,'#13#10#9'IM.' +
      'StoreID as IDStore,'#13#10#9'INV.UltimaMovimentacao as DateRequest,'#13#10#9'I' +
      'NV.QtyOnHand,'#13#10#9'INV.QtyOnOrder,'#13#10#9'INV.MaxQty,'#13#10#9'INV.MinQty,'#13#10#9'SU' +
      'M(IM.Qty) as QtySold,'#13#10#9'(SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyO' +
      'nOrder,0)) as QtyOrdered,'#13#10#9'CASE WHEN (CASE WHEN ISNULL(MV.CaseQ' +
      'ty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty END) > 1 TH' +
      'EN  IsNull(Round(((SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder' +
      ',0))/(CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty' +
      ',0) ELSE MV.CaseQty END))+0.4, 0), 0) ELSE 0 END as CaseQtyOrder' +
      'ed,'#13#10#9'S.Name as Store,'#13#10#9#39'System'#39' as [SystemUser],'#13#10#9'CAST(0 as B' +
      'it) as Marked,'#13#10#9'MV.IDPessoa as IDVendor,'#13#10#9'V.Pessoa as Vendor,'#13 +
      #10#9'(M.FinalCost * 0) as ExtCost,'#13#10#9'B.IDBarcode as Barcode,'#13#10#9'CASE' +
      ' WHEN ((CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQ' +
      'ty,0) ELSE MV.CaseQty END) > 1) THEN (CASE WHEN IsNull(Round(((S' +
      'UM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder,0))/(CASE WHEN ISNU' +
      'LL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty ' +
      'END))+0.4, 0), 0) < MV.MinQtyPO THEN MV.MinQtyPO'#13#10#9#9#9#9#9#9'       E' +
      'LSE IsNull(Round(((SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder' +
      ',0))/(CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty' +
      ',0) ELSE MV.CaseQty END))+0.4, 0), 0) END) '#13#10#9'     ELSE (CASE WH' +
      'EN (SUM(IsNull(IM.Qty, 0)) - IsNull(PO.QtyOnOrder,0)) < MV.MinQt' +
      'yPO THEN MV.MinQtyPO'#13#10#9#9'        ELSE (SUM(IsNull(IM.Qty, 0)) - I' +
      'sNull(PO.QtyOnOrder,0)) END) END as QtyToOrder'#13#10'FROM'#13#10#9'PreInvent' +
      'oryMov IM (NOLOCK) '#13#10#9'JOIN Model M (NOLOCK) ON (IM.ModelID = M.I' +
      'DModel)'#13#10#9'LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel' +
      ' and B.BarcodeOrder = 1)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.Group' +
      'ID = TG.IDGroup)'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.' +
      'IDModelGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup ' +
      'MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup)'#13#10#9'LEFT' +
      ' OUTER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante)'#13#10 +
      #9'JOIN Inventory INV (NOLOCK) ON (INV.ModelID = IM.ModelID AND IM' +
      '.StoreID = INV.StoreID)'#13#10#9'JOIN Store S (NOLOCK) ON (IM.StoreID =' +
      ' S.IDStore)'#13#10#9'JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = ' +
      'M.IDModel and IsNull(MV.VendorOrder,-1) = IsNull(:VendorOrder, I' +
      'sNull(MV.VendorOrder,-1)))'#13#10#9'JOIN Pessoa V (NOLOCK) ON (V.IDPess' +
      'oa = MV.IDPessoa)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID,'#13#10 +
      #9#9#9'SUM(IsNull(PIM.Qty, 0) - IsNull(PIM.QtyRealMov, 0)) as QtyOnO' +
      'rder'#13#10#9#9'FROM'#13#10#9#9#9'Inventory I (NOLOCK) '#13#10#9#9#9'LEFT JOIN PreInventor' +
      'yMov PIM (NOLOCK) ON (I.ModelID = PIM.ModelID AND'#13#10#9#9#9'I.StoreID ' +
      '= PIM.StoreID AND PIM.InventMovTypeID = 2)'#13#10#9#9#9'LEFT JOIN PO (NOL' +
      'OCK) ON (PIM.DocumentID = PO.IDPO AND PO.Aberto = 1)'#13#10#9#9'GROUP BY' +
      #13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID'#13#10#9#9') PO ON (PO.ModelID = INV.Model' +
      'ID AND PO.StoreID = INV.StoreID)'#13#10'WHERE'#13#10#9'IM.MovDate > :MovDate'#13 +
      #10#9'AND'#13#10#9'IM.InventMovTypeID = 1'#13#10#9'AND'#13#10#9'IM.StoreID = IsNull(:IDSt' +
      'ore, IM.StoreID)'#13#10#9'AND'#13#10#9'IsNull(M.IDModelGroup, -1) = IsNull(:ID' +
      'ModelGroup, IsNull(M.IDModelGroup, -1))'#13#10#9'AND'#13#10#9'IsNull(M.IDModel' +
      'SubGroup, -1) = IsNull(:IDModelSubGroup, IsNull(M.IDModelSubGrou' +
      'p, -1))'#13#10#9'AND'#13#10#9'M.GroupID = IsNull(:IDGroup, M.GroupID)'#13#10#9'AND'#13#10' ' +
      '     '#9'IsNull(MV.IDPessoa, -1) = IsNull(:IDPessoa, IsNull(MV.IDPe' +
      'ssoa, -1))'#13#10#9'AND'#13#10#9'IsNull(M.IDFabricante, -1) = IsNull(:IDFabric' +
      'ante, IsNull(M.IDFabricante, -1))'#13#10#9'AND '#13#10#9'M.ModelType IN ('#39'R'#39', ' +
      #39'S'#39')'#13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.Hidden = 0'#13#10'GROUP BY'#13#10#9'M' +
      '.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.ClasseABC,'#13#10#9'M.FinalCo' +
      'st,'#13#10#9'M.SuggRetail,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'M.Case' +
      'Qty,'#13#10#9'MV.CaseQty,'#13#10#9'M.Peso,'#13#10#9'TG.Name,'#13#10#9'MG.ModelGroup,'#13#10#9'MGS.M' +
      'odelSubGroup,'#13#10#9'F.Pessoa,'#13#10#9'IM.StoreID,'#13#10#9'INV.UltimaMovimentacao' +
      ','#13#10#9'INV.QtyOnHand,'#13#10#9'INV.QtyOnOrder,'#13#10#9'INV.MinQty,'#13#10#9'INV.MaxQty,' +
      #13#10#9'S.Name,'#13#10#9'MV.IDPessoa,'#13#10#9'V.Pessoa,'#13#10#9'PO.QtyOnOrder,'#13#10#9'MV.MinQ' +
      'tyPO,'#13#10#9'MV.VendorCost,'#13#10#9'B.IDBarcode'#13#10'HAVING'#13#10#9'SUM(IsNull(IM.Qty' +
      ', 0)) > IsNull(PO.QtyOnOrder,0)'#13#10
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'VendorOrder'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 216
    Top = 316
    object IntegerField4: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object IntegerField5: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object StringField10: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object StringField11: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object StringField12: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object BCDField4: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object BCDField5: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object BCDField6: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object FloatField7: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
    end
    object FloatField8: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object StringField13: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object StringField14: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object StringField15: TStringField
      FieldName = 'MGroup'
      ReadOnly = True
      Size = 30
    end
    object StringField16: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object IntegerField6: TIntegerField
      FieldName = 'IDStore'
      ReadOnly = True
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object FloatField9: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object FloatField10: TFloatField
      FieldName = 'MaxQty'
      ReadOnly = True
    end
    object FloatField11: TFloatField
      FieldName = 'MinQty'
      ReadOnly = True
    end
    object FloatField12: TFloatField
      FieldName = 'QtyOrdered'
    end
    object quPreSalesCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
    end
    object StringField17: TStringField
      FieldName = 'Store'
      ReadOnly = True
      Size = 30
    end
    object StringField18: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 6
    end
    object BooleanField2: TBooleanField
      FieldName = 'Marked'
    end
    object IntegerField7: TIntegerField
      FieldName = 'IDVendor'
      ReadOnly = True
    end
    object StringField19: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 50
    end
    object quPreSalesUnitType: TStringField
      FieldKind = fkCalculated
      FieldName = 'UnitType'
      Size = 10
      Calculated = True
    end
    object quPreSalesQtySold: TFloatField
      FieldName = 'QtySold'
      ReadOnly = True
    end
    object quPreSalesAvgSaleQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleQty'
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quPreSalesQtyToOrder: TFloatField
      FieldName = 'QtyToOrder'
    end
    object quPreSalesExtCost: TCurrencyField
      FieldName = 'ExtCost'
      DisplayFormat = '#,##0.00'
    end
    object quPreSalesAvgSaleWeek: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleWeek'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quPreSalesAvgSaleMonth: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleMonth'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quPreSalesWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '0.####'
    end
    object quPreSalesExtWeight: TCurrencyField
      FieldName = 'ExtWeight'
    end
    object quPreSalesQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
    end
    object quPreSalesBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
  end
  object quRequest: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quMinCalcFields
    CommandText = 
      'SELECT '#9#13#10#9'R.IDRequest,'#13#10#9'M.IDModel,'#13#10#9'IsNull(M.Model, '#39'New Mode' +
      'l'#39') as Model,'#13#10#9'IsNull(M.Description, R.Description) as Descript' +
      'ion,'#13#10#9'M.ClasseABC,'#13#10#9'(CASE IsNull(MV.VendorCost, 0) WHEN 0 THEN' +
      ' M.FinalCost ELSE IsNull(MV.VendorCost, 0) END) as FinalCost,'#13#10#9 +
      'M.SuggRetail as MSRP,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'(CAS' +
      'E WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE ' +
      'MV.CaseQty END) as CaseQty,'#13#10#9'M.Peso as Weight,'#13#10#9'(M.Peso * 0) a' +
      's ExtWeight,'#13#10#9'TG.Name as Category,'#13#10#9'MG.ModelGroup as SubCatego' +
      'ry,'#13#10#9'MGS.ModelSubGroup as MGroup,'#13#10#9'F.Pessoa as Manufacture,'#13#10#9 +
      'INV.StoreID as IDStore,'#13#10#9'INV.UltimaMovimentacao as DateRequest,' +
      #13#10#9'INV.QtyOnHand,'#13#10#9'INV.QtyOnOrder,'#13#10#9'INV.MaxQty,'#13#10#9'INV.MinQty,'#13 +
      #10#9'IMV.Qty as QtySold,'#13#10#9'(IsNull(R.QtyReq,0) - IsNull(PO.QtyOnOrd' +
      'er,0)) as QtyOrdered,'#13#10#9'CASE WHEN (CASE WHEN ISNULL(MV.CaseQty, ' +
      '-1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty END) > 1 THEN I' +
      'sNull(Round(((IsNull(R.QtyReq,0) - IsNull(PO.QtyOnOrder,0))/ (CA' +
      'SE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE' +
      ' MV.CaseQty END))+0.4, 0), 0) ELSE 0 END as CaseQtyOrdered,'#13#10#9'S.' +
      'Name as Store,'#13#10#9'SU.[SystemUser] as [SystemUser],'#13#10#9'CAST(0 as Bi' +
      't) as Marked,'#13#10#9'MV.IDPessoa as IDVendor,'#13#10#9'V.Pessoa as Vendor,'#13#10 +
      #9'(M.FinalCost * 0) as ExtCost,'#13#10#9'B.IDBarcode as Barcode,'#13#10#9'CASE ' +
      'WHEN ((CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQt' +
      'y,0) ELSE MV.CaseQty END) > 1) THEN (CASE WHEN IsNull(Round(((Is' +
      'Null(R.QtyReq, 0) - IsNull(PO.QtyOnOrder, 0))/ (CASE WHEN ISNULL' +
      '(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty EN' +
      'D))+0.4, 0), 0) < MV.MinQtyPO THEN MV.MinQtyPO'#13#10#9#9#9#9#9#9'       ELS' +
      'E IsNull(Round(((IsNull(R.QtyReq, 0) - IsNull(PO.QtyOnOrder, 0))' +
      '/(CASE WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ' +
      'ELSE MV.CaseQty END))+0.4, 0), 0) END) '#13#10#9'     ELSE (CASE WHEN (' +
      'IsNull(R.QtyReq,0) - IsNull(PO.QtyOnOrder,0)) < MV.MinQtyPO THEN' +
      ' MV.MinQtyPO'#13#10#9#9'        ELSE (IsNull(R.QtyReq,0) - IsNull(PO.Qty' +
      'OnOrder,0)) END) END as QtyToOrder'#13#10'FROM'#13#10#9'Request R (NOLOCK) '#13#10 +
      #9'LEFT OUTER JOIN Model M (NOLOCK) ON ( R.ModelID = M.IDModel )'#13#10 +
      #9'LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel and B.Ba' +
      'rcodeOrder = 1)'#13#10#9'LEFT JOIN TabGroup TG (NOLOCK) ON (M.GroupID =' +
      ' TG.IDGroup)'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDMo' +
      'delGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup MGS ' +
      '(NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup)'#13#10#9'LEFT OUT' +
      'ER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante)'#13#10#9'LEF' +
      'T JOIN Inventory INV (NOLOCK) ON (INV.ModelID = M.IDModel)'#13#10#9'JOI' +
      'N Store S (NOLOCK) ON (INV.StoreID = S.IDStore)'#13#10#9'LEFT JOIN Inv_' +
      'ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDModel and IsNull(MV' +
      '.VendorOrder,-1) = IsNull(:VendorOrder, IsNull(MV.VendorOrder,-1' +
      ')))'#13#10#9'LEFT JOIN Pessoa V (NOLOCK) ON (V.IDPessoa = MV.IDPessoa)'#13 +
      #10#9'LEFT OUTER JOIN [SystemUser] SU (NOLOCK) ON (SU.IDUser = R.Use' +
      'rID)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID,'#13#10#9#9#9'SUM(IsNull' +
      '(PIM.Qty, 0) - IsNull(PIM.QtyRealMov, 0)) as QtyOnOrder'#13#10#9#9'FROM'#13 +
      #10#9#9#9'Inventory I (NOLOCK) '#13#10#9#9#9'LEFT JOIN PreInventoryMov PIM (NOL' +
      'OCK) ON (I.ModelID = PIM.ModelID AND'#13#10#9#9#9'I.StoreID = PIM.StoreID' +
      ' AND PIM.InventMovTypeID = 2)'#13#10#9#9#9'LEFT JOIN PO (NOLOCK) ON (PIM.' +
      'DocumentID = PO.IDPO AND PO.Aberto = 1)'#13#10#9#9'GROUP BY'#13#10#9#9#9'I.ModelI' +
      'D,'#13#10#9#9#9'I.StoreID'#13#10#9#9') PO ON (PO.ModelID = INV.ModelID AND PO.Sto' +
      'reID = INV.StoreID)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID,' +
      #13#10#9#9#9'SUM(IsNull(IMV.Qty, 0)) as Qty'#13#10#9#9'FROM'#13#10#9#9#9'Inventory I (NOL' +
      'OCK) '#13#10#9#9#9'LEFT JOIN InventoryMov IMV (NOLOCK) ON (I.ModelID = IM' +
      'V.ModelID AND I.StoreID = IMV.StoreID AND IMV.InventMovTypeID = ' +
      '1 AND IMV.MovDate >=:MovDate)'#13#10#9#9'GROUP BY'#13#10#9#9#9'I.StoreID,'#13#10#9#9#9'I.M' +
      'odelID'#13#10#9#9') IMV ON (IMV.StoreID = S.IDStore AND IMV.ModelID = M.' +
      'IDModel)'#13#10'WHERE'#13#10#9'R.StoreID = IsNull(:IDStore, R.StoreID)'#13#10#9'AND'#13 +
      #10#9'INV.StoreID = IsNull(:IDStore, INV.StoreID)'#13#10#9'AND'#13#10#9'IsNull(M.I' +
      'DModelGroup, -1) = IsNull(:IDModelGroup, IsNull(M.IDModelGroup, ' +
      '-1))'#13#10#9'AND'#13#10#9'IsNull(M.IDModelSubGroup, -1) = IsNull(:IDModelSubG' +
      'roup, IsNull(M.IDModelSubGroup, -1))'#13#10#9'AND'#13#10#9'M.GroupID = IsNull(' +
      ':IDGroup, M.GroupID)'#13#10#9'AND'#13#10'      '#9'IsNull(MV.IDPessoa,-1) = IsNu' +
      'll(:IDPessoa, IsNull(MV.IDPessoa,-1))'#13#10#9'AND'#13#10#9'IsNull(M.IDFabrica' +
      'nte,-1) = IsNull(:IDFabricante, IsNull(M.IDFabricante,-1))'#13#10#9'AND' +
      ' '#13#10#9'M.ModelType IN ('#39'R'#39','#39'S'#39')'#13#10#9'AND'#13#10'      '#9'R.Type = IsNull(:Type' +
      ', R.Type)'#13#10#9'AND'#13#10#9'(IsNull(R.QtyReq,0) > IsNull(PO.QtyOnOrder,0))' +
      #13#10#9'AND'#13#10#9'IsNull(R.QtyOrdered, 0) = 0'#13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10#9 +
      'AND'#13#10#9'M.Hidden = 0'#13#10'GROUP BY'#13#10#9'R.IDRequest,'#13#10#9'M.IDModel,'#13#10#9'M.Mod' +
      'el,'#13#10#9'R.Description,'#13#10#9'M.Description,'#13#10#9'M.ClasseABC,'#13#10#9'M.FinalCo' +
      'st,'#13#10#9'M.SuggRetail,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'M.Case' +
      'Qty,'#13#10#9'MV.CaseQty,'#13#10#9'M.Peso,'#13#10#9'TG.Name,'#13#10#9'MG.ModelGroup,'#13#10#9'MGS.M' +
      'odelSubGroup,'#13#10#9'F.Pessoa,'#13#10#9'INV.StoreID,'#13#10#9'INV.UltimaMovimentaca' +
      'o,'#13#10#9'INV.QtyOnHand,'#13#10#9'R.QtyReq,'#13#10#9'SU.[SystemUser],'#13#10#9'INV.MinQty,' +
      #13#10#9'INV.MaxQty,'#13#10#9'S.Name,'#13#10#9'MV.IDPessoa,'#13#10#9'V.Pessoa,'#13#10#9'PO.QtyOnOr' +
      'der,'#13#10#9'IMV.Qty,'#13#10#9'MV.MinQtyPO,'#13#10#9'INV.QtyOnOrder,'#13#10#9'MV.VendorCost' +
      ','#13#10#9'B.IDBarcode'
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'VendorOrder'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Type'
        DataType = ftString
        Size = 1
        Value = Null
      end>
    Left = 216
    Top = 364
    object quRequestIDRequest: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object quRequestIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quRequestModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object quRequestDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object quRequestClasseABC: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object quRequestFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quRequestMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quRequestSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quRequestTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
    end
    object quRequestCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object quRequestCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object quRequestSubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object quRequestMGroup: TStringField
      FieldName = 'MGroup'
      ReadOnly = True
      Size = 30
    end
    object quRequestManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object quRequestIDStore: TIntegerField
      FieldName = 'IDStore'
      ReadOnly = True
    end
    object quRequestDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object quRequestQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object quRequestMaxQty: TFloatField
      FieldName = 'MaxQty'
      ReadOnly = True
    end
    object quRequestMinQty: TFloatField
      FieldName = 'MinQty'
      ReadOnly = True
    end
    object quRequestQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
    end
    object quRequestCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
    end
    object quRequestStore: TStringField
      FieldName = 'Store'
      ReadOnly = True
      Size = 30
    end
    object quRequestSystemUser: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 50
    end
    object quRequestMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quRequestIDVendor: TIntegerField
      FieldName = 'IDVendor'
      ReadOnly = True
    end
    object quRequestVendor: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 50
    end
    object quRequestUnitType: TStringField
      FieldKind = fkCalculated
      FieldName = 'UnitType'
      Size = 10
      Calculated = True
    end
    object quRequestQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object quRequestAvgSaleQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleQty'
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quRequestQtyToOrder: TFloatField
      FieldName = 'QtyToOrder'
    end
    object quRequestExtCost: TCurrencyField
      FieldName = 'ExtCost'
      DisplayFormat = '#,##0.00'
    end
    object quRequestQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
    end
    object quRequestAvgSaleWeek: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleWeek'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quRequestAvgSaleMonth: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleMonth'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quRequestWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '0.####'
    end
    object quRequestExtWeight: TCurrencyField
      FieldName = 'ExtWeight'
      DisplayFormat = '0.####'
    end
    object quRequestBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
  end
  object quAllInventory: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quMinCalcFields
    CommandText = 
      'SELECT '#9#13#10#9'0 as IDRequest,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Descripti' +
      'on,'#13#10#9'M.ClasseABC,'#13#10#9'(CASE IsNull(MV.VendorCost, 0) WHEN 0 THEN ' +
      'M.FinalCost ELSE IsNull(MV.VendorCost, 0) END) as FinalCost,'#13#10#9'M' +
      '.SuggRetail as MSRP,'#13#10#9'M.SellingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'(CASE' +
      ' WHEN ISNULL(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE M' +
      'V.CaseQty END) as CaseQty,'#13#10#9'M.Peso as Weight,'#13#10#9'(M.Peso * 0) as' +
      ' ExtWeight,'#13#10#9'TG.Name as Category,'#13#10#9'MG.ModelGroup as SubCategor' +
      'y,'#13#10#9'MGS.ModelSubGroup as MGroup,'#13#10#9'F.Pessoa as Manufacture,'#13#10#9':' +
      'IDStore1 as IDStore,'#13#10#9'CAST(NULL as DateTime) as DateRequest,'#13#10#9 +
      'IVT.QtyOnHand,'#13#10#9'IVT.QtyOnOrder,'#13#10#9'IVT.MaxQty,'#13#10#9'IVT.MinQty,'#13#10#9'I' +
      'MV.Qty as QtySold,'#13#10#9'cast(0 as float) as QtyOrdered,'#13#10#9'cast(0 as' +
      ' float) as CaseQtyOrdered,'#13#10#9'S.Name as Store,'#13#10#9#39'System'#39' as [Sys' +
      'temUser],'#13#10#9'CAST(0 as Bit) as Marked,'#13#10#9'MV.IDPessoa as IDVendor,' +
      #13#10#9'V.Pessoa as Vendor,'#13#10#9'(M.FinalCost * 0) as ExtCost,'#13#10#9'MV.MinQ' +
      'tyPo as QtyToOrder,'#13#10#9'B.IDBarcode as Barcode'#13#10'FROM'#13#10#9'Model M (NO' +
      'LOCK) '#13#10#9'LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel ' +
      'and B.BarcodeOrder = 1)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.GroupI' +
      'D = TG.IDGroup)'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.I' +
      'DModelGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup M' +
      'GS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup)'#13#10#9'LEFT ' +
      'OUTER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante)'#13#10#9 +
      'JOIN Store S (NOLOCK) ON (:IDStore2 = S.IDStore)'#13#10#9'JOIN Inventor' +
      'y IVT (NOLOCK) ON (IVT.ModelID = M.IDModel AND IVT.StoreID = S.I' +
      'DStore)'#13#10#9'JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.ID' +
      'Model and IsNull(MV.VendorOrder,-1) = IsNull(:VendorOrder, IsNul' +
      'l(MV.VendorOrder,-1)))'#13#10#9'JOIN Pessoa V (NOLOCK) ON (V.IDPessoa =' +
      ' MV.IDPessoa)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I.StoreID,'#13#10#9#9#9'S' +
      'UM(IsNull(PIM.Qty, 0) - IsNull(PIM.QtyRealMov, 0)) as QtyOnOrder' +
      #13#10#9#9'FROM'#13#10#9#9#9'Inventory I (NOLOCK) '#13#10#9#9#9'LEFT JOIN PreInventoryMov' +
      ' PIM (NOLOCK) ON (I.ModelID = PIM.ModelID AND'#13#10#9#9#9'I.StoreID = PI' +
      'M.StoreID AND PIM.InventMovTypeID = 2)'#13#10#9#9#9'LEFT JOIN PO (NOLOCK)' +
      ' ON (PIM.DocumentID = PO.IDPO AND PO.Aberto = 1)'#13#10#9#9'GROUP BY'#13#10#9#9 +
      #9'I.ModelID,'#13#10#9#9#9'I.StoreID'#13#10#9#9') PO ON (PO.ModelID = IVT.ModelID A' +
      'ND PO.StoreID = IVT.StoreID)'#13#10#9'JOIN (SELECT'#13#10#9#9#9'I.ModelID,'#13#10#9#9#9'I' +
      '.StoreID,'#13#10#9#9#9'SUM(IsNull(IMV.Qty, 0)) as Qty'#13#10#9#9'FROM'#13#10#9#9#9'Invento' +
      'ry I (NOLOCK) '#13#10#9#9#9'LEFT JOIN InventoryMov IMV (NOLOCK) ON (I.Mod' +
      'elID = IMV.ModelID AND I.StoreID = IMV.StoreID AND IMV.InventMov' +
      'TypeID = 1 AND IMV.MovDate >=:MovDate)'#13#10#9#9'GROUP BY'#13#10#9#9#9'I.StoreID' +
      ','#13#10#9#9#9'I.ModelID'#13#10#9#9') IMV ON (IMV.StoreID = S.IDStore AND IMV.Mod' +
      'elID = M.IDModel)'#13#10'WHERE'#13#10#9'IsNull(M.IDModelGroup, -1) = IsNull(:' +
      'IDModelGroup, IsNull(M.IDModelGroup, -1))'#13#10#9'AND'#13#10#9'IsNull(M.IDMod' +
      'elSubGroup, -1) = IsNull(:IDModelSubGroup, IsNull(M.IDModelSubGr' +
      'oup, -1))'#13#10#9'AND'#13#10#9'M.GroupID = IsNull(:IDGroup, M.GroupID)'#13#10#9'AND'#13 +
      #10'      '#9'IsNull(MV.IDPessoa,-1) = IsNull(:IDPessoa, IsNull(MV.IDP' +
      'essoa,-1))'#13#10#9'AND'#13#10#9'IsNull(M.IDFabricante,-1) = IsNull(:IDFabrica' +
      'nte, IsNull(M.IDFabricante,-1))'#13#10#9'AND'#13#10#9'M.ModelType IN ('#39'R'#39','#39'S'#39')' +
      #13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.Hidden = 0'#13#10'        AND'#13#10'   ' +
      '     MV.DoNotOrder = 0'#13#10'GROUP BY'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Des' +
      'cription,'#13#10#9'M.ClasseABC,'#13#10#9'M.FinalCost,'#13#10#9'M.SuggRetail,'#13#10#9'M.Sell' +
      'ingPrice,'#13#10#9'M.TotQtyOnHand,'#13#10#9'M.CaseQty,'#13#10#9'MV.CaseQty,'#13#10#9'M.Peso,' +
      #13#10#9'IVT.QtyOnHand,'#13#10#9'IVT.QtyOnOrder,'#13#10#9'IVT.MaxQty,'#13#10#9'IVT.MinQty,'#13 +
      #10#9'TG.Name,'#13#10#9'MG.ModelGroup,'#13#10#9'MGS.ModelSubGroup,'#13#10#9'F.Pessoa,'#13#10#9'S' +
      '.Name,'#13#10#9'MV.IDPessoa,'#13#10#9'V.Pessoa,'#13#10#9'PO.QtyOnOrder,'#13#10#9'IMV.Qty,'#13#10#9 +
      'MV.MinQtyPo,'#13#10#9'MV.VendorCost,'#13#10#9'B.IDBarcode'#13#10
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'IDStore1'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore2'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'VendorOrder'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModelSubGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDFabricante'
        Attributes = [paSigned]
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 216
    Top = 420
    object quAllInventoryIDRequest: TIntegerField
      FieldName = 'IDRequest'
      ReadOnly = True
    end
    object quAllInventoryIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quAllInventoryModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object quAllInventoryDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object quAllInventoryClasseABC: TStringField
      FieldName = 'ClasseABC'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object quAllInventoryFinalCost: TBCDField
      FieldName = 'FinalCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quAllInventoryMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quAllInventorySellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quAllInventoryTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
    end
    object quAllInventoryCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object quAllInventoryCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object quAllInventorySubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object quAllInventoryMGroup: TStringField
      FieldName = 'MGroup'
      ReadOnly = True
      Size = 30
    end
    object quAllInventoryManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object quAllInventoryIDStore: TIntegerField
      FieldName = 'IDStore'
      ReadOnly = True
    end
    object quAllInventoryDateRequest: TDateTimeField
      FieldName = 'DateRequest'
      ReadOnly = True
    end
    object quAllInventoryQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object quAllInventoryMaxQty: TFloatField
      FieldName = 'MaxQty'
      ReadOnly = True
    end
    object quAllInventoryMinQty: TFloatField
      FieldName = 'MinQty'
      ReadOnly = True
    end
    object quAllInventoryStore: TStringField
      FieldName = 'Store'
      ReadOnly = True
      Size = 30
    end
    object quAllInventorySystemUser: TStringField
      FieldName = 'SystemUser'
      ReadOnly = True
      Size = 6
    end
    object quAllInventoryMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quAllInventoryIDVendor: TIntegerField
      FieldName = 'IDVendor'
      ReadOnly = True
    end
    object quAllInventoryVendor: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 50
    end
    object quAllInventoryUnitType: TStringField
      FieldKind = fkCalculated
      FieldName = 'UnitType'
      Size = 10
      Calculated = True
    end
    object quAllInventoryQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object quAllInventoryAvgSaleQty: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleQty'
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quAllInventoryQtyToOrder: TFloatField
      FieldName = 'QtyToOrder'
    end
    object quAllInventoryExtCost: TCurrencyField
      FieldName = 'ExtCost'
      DisplayFormat = '#,##0.00'
    end
    object quAllInventoryQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
    end
    object quAllInventoryAvgSaleWeek: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleWeek'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quAllInventoryAvgSaleMonth: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'AvgSaleMonth'
      DisplayFormat = '0.###'
      Calculated = True
    end
    object quAllInventoryQtyOrdered: TFloatField
      FieldName = 'QtyOrdered'
      ReadOnly = True
    end
    object quAllInventoryCaseQtyOrdered: TFloatField
      FieldName = 'CaseQtyOrdered'
      ReadOnly = True
    end
    object quAllInventoryWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '0.####'
    end
    object quAllInventoryExtWeight: TCurrencyField
      FieldName = 'ExtWeight'
      DisplayFormat = '0.####'
    end
    object quAllInventoryBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
  end
  object strepPredefined: TcxStyleRepository
    Left = 576
    Top = 207
    object cxHilight: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = 8404992
    end
    object GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
      Styles.Header = cxHilight
    end
  end
end
