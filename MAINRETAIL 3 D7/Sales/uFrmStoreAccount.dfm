inherited FrmStoreAccount: TFrmStoreAccount
  Left = 650
  Top = 75
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Store Account'
  ClientHeight = 573
  ClientWidth = 601
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel [0]
    Left = -6
    Top = 359
    Width = 514
    Height = 6
    Shape = bsTopLine
  end
  inherited Panel1: TPanel
    Top = 532
    Width = 601
    TabOrder = 3
    inherited EspacamentoInferior: TPanel
      Width = 601
      inherited Panel3: TPanel
        Width = 601
      end
    end
    inherited hhh: TPanel
      Left = 360
      Width = 241
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 167
        OnClick = btCloseClick
      end
      object btnPayment: TButton
        Left = 30
        Top = 3
        Width = 133
        Height = 31
        Caption = '&Record Payment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnPaymentClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 526
    TabOrder = 4
  end
  inherited EspacamentoDireito: TPanel
    Left = 598
    Height = 526
    TabOrder = 5
  end
  inherited EspacamentoSuperior: TPanel
    Width = 601
    TabOrder = 6
  end
  object pnlCustomer: TPanel [5]
    Left = 8
    Top = 7
    Width = 585
    Height = 106
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Shape4: TShape
      Left = 0
      Top = 0
      Width = 585
      Height = 106
      Align = alClient
      Brush.Color = 14607076
      Pen.Color = 8491416
      Shape = stRoundRect
    end
    object Label4: TLabel
      Left = 99
      Top = 33
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Customer :'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = 8491416
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 113
      Top = 10
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Loyalty :'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = 8491416
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object Shape22: TShape
      Left = 173
      Top = 25
      Width = 191
      Height = 1
      Pen.Color = clGray
    end
    object SubCustomer: TSubListPanel
      Left = 172
      Top = 35
      Width = 194
      Height = 57
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 2
      SubListClassName = 'TSubCustomerInfo'
    end
    object btnCustomer: TBitBtn
      Left = 382
      Top = 8
      Width = 113
      Height = 25
      Caption = '&Change Customer'
      TabOrder = 1
      OnClick = btnCustomerClick
    end
    object edtLoyalty: TEdit
      Left = 173
      Top = 9
      Width = 192
      Height = 16
      BorderStyle = bsNone
      Color = 13487565
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyDown = edtLoyaltyKeyDown
    end
  end
  object pgHistory: TPageControl [6]
    Left = 8
    Top = 119
    Width = 587
    Height = 239
    ActivePage = tsActiveAcc
    Style = tsButtons
    TabOrder = 1
    object tsActiveAcc: TTabSheet
      Caption = 'Store Account'
      DesignSize = (
        579
        208)
      object btnEmail: TSpeedButton
        Left = 490
        Top = 121
        Width = 85
        Height = 27
        Caption = 'Email'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFC4CBCFAEB5B98C919474787A777C7F92989BB1B8BBC4CCD0C0C8CCB7BE
          C2C0C8CCFF00FFFF00FFC0C8CCAEB4B8A3A9AC979DA0987552BA6829A9723661
          534956595B7C81849EA4A7949A9C7E848691979AAEB4B8C0C8CCAEB4B8757A7C
          635F579D6627E97A0CFF7824FF940DF4A2388A684E494C4D5D6062B2795B4649
          4A4F5354757A7CAEB4B88A5855835151E4994DE98313D28F6AF4A33AFF8D0DFF
          9F17FFBA63A77F63835151FF9605835151835151595C5EA4ABAE8F5D59F8F1E6
          F8F1E6F8F1E6F8F1E6F5D9ACFE9517FF9805FFAB36FFC684FFB75AFF9605FFF4
          E9A97F7A595C5EA4ABAE97655DFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEF5D9ACFE
          9517FF9E0FFFB75AFFC684FF9605FFF4E9A97F7A595C5EA4ABAE9F6E62FFFFFE
          FFFFFEF2F1F1CCCCCCCCCCCCCCCCCCCEC8C0F29623FFA82EFF9605FF9605FFF4
          E9A97F7A595C5EA4ABAEAA7868FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEED
          6536ED6536ED6536ED6536ED6536FFF4E9A97F7A595C5EA4ABAEB4826EFFFFFF
          FFFFFFF2F1F1CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD6D4D0F4EBDBF2E8D5FFF4
          E9A97F7A595C5EA4ABAEBE8C75FFFFFFED6536ED6536DA5F40C36452C28C80FE
          FEFDFEFEFDFEFEFD4853886B81CAFFF4E9A97F7A595C5EA4ABAEC9977BFFFFFF
          FF8F12FF8F12ED6536BE4B0FF9F2EFFEFEFDFEFEFDFEFEFD6197D687ADDEFFF4
          E9A97F7A595C5EA4ABAED3A281FFFFFFFF8F12FEB45AFFA931F99614BF6E33FF
          FFFFFDFCF9FEFEFDFEFEFDFEFEFDFFF4E9A97F7A757A7CAEB4B8DCAA86DCAA86
          FF8F12DCAA86F4A45EFFC37DEC9E49B05F33C49E91C49E91C49E91C49E91C49E
          91A97F7AAEB4B8C0C8CCFF00FFFF00FFFF8F12B7BEC2D5C0A9F4A45EFFDAA8F2
          BD88B56130B35B40CE753F91593DA5ABAFC4CBCFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFCEC2B8F4A45EFFEDBBFFE3B0CC8755944219A2A8ABC1C9
          CDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC9CACCF4
          A45EF4A45EA56645B2B2B2C2CACEFF00FFFF00FFFF00FFFF00FF}
        Margin = 3
        OnClick = btnEmailClick
      end
      object grdAccount: TcxGrid
        Left = 0
        Top = 0
        Width = 485
        Height = 208
        Align = alLeft
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdAccountDB: TcxGridDBTableView
          DataController.DataSource = dsStoreAccount
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDStoreAccount'
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
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdAccountDBChecked: TcxGridDBColumn
            Caption = ' '
            DataBinding.FieldName = 'Checked'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayUnchecked = 'False'
            Width = 20
          end
          object grdAccountDBTransactionDate: TcxGridDBColumn
            DataBinding.FieldName = 'TransactionDate'
            Options.Editing = False
            Width = 54
          end
          object grdAccountDBDueDate: TcxGridDBColumn
            DataBinding.FieldName = 'DueDate'
            Width = 53
          end
          object grdAccountDBSystemUser: TcxGridDBColumn
            DataBinding.FieldName = 'SystemUser'
            Options.Editing = False
            Width = 63
          end
          object grdAccountDBStore: TcxGridDBColumn
            DataBinding.FieldName = 'Store'
            Options.Editing = False
            Width = 43
          end
          object grdAccountDBSaleCode: TcxGridDBColumn
            DataBinding.FieldName = 'SaleCode'
            Options.Editing = False
            Width = 44
          end
          object grdAccountDBInvoiceCode: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceCode'
            Options.Editing = False
            Width = 51
          end
          object grdAccountDBAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            Options.Editing = False
            Width = 49
          end
          object grdAccountDBInterest: TcxGridDBColumn
            DataBinding.FieldName = 'Interest'
            Width = 54
          end
          object grdAccountDBTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            Width = 52
          end
        end
        object grdAccountLevel: TcxGridLevel
          GridView = grdAccountDB
        end
      end
      object btnSellAll: TBitBtn
        Left = 489
        Top = 65
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Select All'
        TabOrder = 3
        OnClick = btnSellAllClick
        Margin = 0
      end
      object btnClearAll: TBitBtn
        Left = 489
        Top = 93
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Unselect All'
        TabOrder = 4
        OnClick = btnClearAllClick
        Margin = 0
      end
      object btnCheck: TBitBtn
        Left = 489
        Top = 10
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Select'
        TabOrder = 1
        OnClick = btnCheckClick
        Margin = 0
      end
      object btnUncheck: TBitBtn
        Left = 489
        Top = 38
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Unselect'
        TabOrder = 2
        OnClick = btnUncheckClick
        Margin = 0
      end
    end
    object tsHistory: TTabSheet
      Caption = 'History'
      ImageIndex = 1
      object btnPrint: TBitBtn
        Left = 494
        Top = 10
        Width = 80
        Height = 25
        Caption = 'Re-Print'
        TabOrder = 0
        OnClick = btnPrintClick
      end
      object grdHistory: TcxGrid
        Left = 0
        Top = 0
        Width = 491
        Height = 208
        Align = alLeft
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object cxgrdHistoryDB: TcxGridDBTableView
          DataController.DataSource = dsHistory
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDStoreAccount'
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
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object cxgrdHistoryDBIDStoreAccount: TcxGridDBColumn
            DataBinding.FieldName = 'IDStoreAccount'
            Width = 96
          end
          object cxgrdHistoryDBTransactionDate: TcxGridDBColumn
            DataBinding.FieldName = 'TransactionDate'
            Width = 86
          end
          object cxgrdHistoryDBSystemUser: TcxGridDBColumn
            DataBinding.FieldName = 'SystemUser'
            Width = 122
          end
          object cxgrdHistoryDBStore: TcxGridDBColumn
            DataBinding.FieldName = 'Store'
            Width = 97
          end
          object cxgrdHistoryDBAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            Width = 88
          end
        end
        object cxgrdHistoryLevel: TcxGridLevel
          GridView = cxgrdHistoryDB
        end
      end
    end
    object tsTemp: TTabSheet
      Caption = 'Temp'
      ImageIndex = 2
      TabVisible = False
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 401
        Height = 208
        Align = alLeft
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object dbGridTemp: TcxGridDBTableView
          DataController.DataSource = dsTemporary
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDStoreAccount'
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
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object dbGridTempTransactionDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'TransactionDate'
            Width = 93
          end
          object dbGridTempSystemUser: TcxGridDBColumn
            Caption = 'User'
            DataBinding.FieldName = 'SystemUser'
            Width = 110
          end
          object dbGridTempStore: TcxGridDBColumn
            DataBinding.FieldName = 'Store'
            Width = 122
          end
          object dbGridTempAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            Width = 74
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = dbGridTemp
        end
      end
      object btnRemoveTemp: TBitBtn
        Left = 404
        Top = 10
        Width = 80
        Height = 25
        Caption = 'Remove'
        TabOrder = 1
        OnClick = btnRemoveTempClick
      end
    end
  end
  object Panel4: TPanel [7]
    Left = 13
    Top = 365
    Width = 579
    Height = 43
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 7
    object Shape2: TShape
      Left = 0
      Top = 0
      Width = 579
      Height = 43
      Align = alClient
      Brush.Color = 14607076
      Pen.Color = 8491416
      Shape = stRoundRect
    end
    object Label2: TLabel
      Left = 116
      Top = 13
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total Due :'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = 8491416
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object lbTotalDue: TStaticText
      Left = 328
      Top = 9
      Width = 186
      Height = 24
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object pnlValue: TPanel [8]
    Left = 13
    Top = 411
    Width = 579
    Height = 117
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 579
      Height = 117
      Align = alClient
      Brush.Color = 14607076
      Pen.Color = 8491416
      Shape = stRoundRect
    end
    object Label1: TLabel
      Left = 123
      Top = 13
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payment :'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = 8491416
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object lbChange: TLabel
      Left = 133
      Top = 71
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'Change :'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = 8491416
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object lbPaymentAmount: TLabel
      Left = 70
      Top = 44
      Width = 118
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payment Amount :'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = 8491416
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
    end
    object btnPartialPayment: TSpeedButton
      Left = 198
      Top = 89
      Width = 89
      Height = 22
      Caption = '&Delay'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      Margin = 4
      ParentFont = False
      Visible = False
      OnClick = btnPartialPaymentClick
    end
    object lbPartialInfo: TLabel
      Left = 289
      Top = 92
      Width = 12
      Height = 16
      Caption = '   '
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object edtPayValue: TSuperEdit
      Left = 331
      Top = 35
      Width = 184
      Height = 28
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
      OnChange = edtPayValueChange
      OnExit = edtPayValueExit
      OnKeyPress = edtPayValueKeyPress
      Alignment = taRightJustify
    end
    object cmbPaymentType: TSuperComboADO
      Tag = 1
      Left = 198
      Top = 9
      Width = 317
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      LookUpSource = DM.dsLookUpMeioPag
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = cmbPaymentTypeSelectItem
    end
    object lbChangeValue: TStaticText
      Left = 342
      Top = 67
      Width = 170
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Color = 14607076
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
  end
  object quStoreAccount: TADODataSet [9]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quStoreAccountCalcFields
    CommandText = 
      'SELECT'#13#10#9'CAST(1 as bit) as Checked,'#13#10#9'SA.IDStoreAccount,'#13#10#9'SA.ID' +
      'Pessoa,'#13#10#9'SA.IDUser,'#13#10#9'SA.IDStore,'#13#10#9'SA.IDLancamento,'#13#10#9'SA.Trans' +
      'actionDate,'#13#10#9'SA.Amount,'#13#10#9'SU.SystemUser,'#13#10#9'S.Name as Store,'#13#10#9'I' +
      '.InvoiceCode,'#13#10#9'I.SaleCode,'#13#10#9'MP.IDMeioPagBatch as IDMeioPag,'#13#10#9 +
      'MPS.IDContaCorrente,'#13#10#9'L.DataVencimento as DueDate,'#13#10#9'MPB.FlatPe' +
      'nalty,'#13#10#9'MPB.PenaltyValue,'#13#10#9'MPB.DailtInterest'#13#10'FROM'#13#10#9'Sal_Store' +
      'Account SA (NOLOCK)'#13#10#9'JOIN SystemUser SU (NOLOCK) ON (SU.IDUser ' +
      '= SA.IDUser)'#13#10#9'JOIN Store S (NOLOCK) ON (SA.IDStore = S.IDStore)' +
      #13#10#9'LEFT JOIN Fin_Lancamento L (NOLOCK) ON (SA.IDLancamento = L.I' +
      'DLancamento)'#13#10#9'LEFT JOIN Invoice I (NOLOCK) ON (I.IDPreSale = L.' +
      'IDPreSale)'#13#10#9'LEFT JOIN MeioPag MP (NOLOCK) ON (MP.IDMeioPag = L.' +
      'IDQuitacaoMeioPrevisto)'#13#10#9'LEFT JOIN MeioPag MPB (NOLOCK) ON (MPB' +
      '.IDMeioPag = MP.IDMeioPagBatch)'#13#10#9'LEFT JOIN MeioPagToStore MPS (' +
      'NOLOCK) ON (MPS.IDStore = S.IDStore AND MPS.IDMeioPag = MPB.IDMe' +
      'ioPag)'#13#10'WHERE'#13#10#9'SA.IDStoreAccountUsed IS NULL'#13#10#9'AND'#13#10#9'SA.IsUsed ' +
      '= 0'#13#10#9'AND'#13#10#9'SA.IsReceiving = 0'#13#10#9'AND'#13#10#9'SA.IDPessoa = :IDPessoa'#13#10 +
      #9'AND'#13#10#9'SA.IDStore = IsNull(:IDStore, SA.IDStore)'#13#10#9'AND'#13#10#9'SA.Veri' +
      'fy = 0'#13#10'ORDER BY'#13#10#9'L.DataVencimento'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 44
    Top = 170
    object quStoreAccountChecked: TBooleanField
      FieldName = 'Checked'
    end
    object quStoreAccountIDStoreAccount: TIntegerField
      FieldName = 'IDStoreAccount'
    end
    object quStoreAccountIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quStoreAccountIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quStoreAccountIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreAccountIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quStoreAccountTransactionDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'TransactionDate'
    end
    object quStoreAccountAmount: TBCDField
      FieldName = 'Amount'
      Precision = 19
    end
    object quStoreAccountSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quStoreAccountStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quStoreAccountInvoiceCode: TStringField
      DisplayLabel = 'Invoice #'
      FieldName = 'InvoiceCode'
    end
    object quStoreAccountSaleCode: TStringField
      DisplayLabel = 'Hold #'
      FieldName = 'SaleCode'
    end
    object quStoreAccountIDContaCorrente: TIntegerField
      FieldName = 'IDContaCorrente'
    end
    object quStoreAccountIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quStoreAccountDueDate: TDateTimeField
      FieldName = 'DueDate'
      DisplayFormat = 'ddddd'
    end
    object quStoreAccountFlatPenalty: TBooleanField
      FieldName = 'FlatPenalty'
    end
    object quStoreAccountPenaltyValue: TBCDField
      FieldName = 'PenaltyValue'
      Precision = 19
    end
    object quStoreAccountDailtInterest: TBCDField
      FieldName = 'DailtInterest'
      Precision = 19
    end
    object quStoreAccountInterest: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Interest'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quStoreAccountTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
  end
  object dspStoreAccount: TDataSetProvider [10]
    DataSet = quStoreAccount
    Left = 109
    Top = 222
  end
  object cdsStoreAccount: TClientDataSet [11]
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDPessoa'
        ParamType = ptInput
        Size = 4
        Value = 0
      end
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDStore'
        ParamType = ptInput
        Size = 4
        Value = 0
      end>
    ProviderName = 'dspStoreAccount'
    Left = 44
    Top = 197
    object cdsStoreAccountChecked: TBooleanField
      FieldName = 'Checked'
    end
    object cdsStoreAccountIDStoreAccount: TIntegerField
      FieldName = 'IDStoreAccount'
    end
    object cdsStoreAccountIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object cdsStoreAccountIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsStoreAccountIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsStoreAccountIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object cdsStoreAccountTransactionDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'TransactionDate'
      DisplayFormat = 'ddddd'
    end
    object cdsStoreAccountAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object cdsStoreAccountSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object cdsStoreAccountStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsStoreAccountInvoiceCode: TStringField
      DisplayLabel = 'Invoice #'
      FieldName = 'InvoiceCode'
    end
    object cdsStoreAccountSaleCode: TStringField
      DisplayLabel = 'Hold #'
      FieldName = 'SaleCode'
    end
    object cdsStoreAccountIDContaCorrente: TIntegerField
      FieldName = 'IDContaCorrente'
    end
    object cdsStoreAccountIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object cdsStoreAccountDueDate: TDateTimeField
      FieldName = 'DueDate'
      DisplayFormat = 'ddddd'
    end
    object cdsStoreAccountFlatPenalty: TBooleanField
      FieldName = 'FlatPenalty'
    end
    object cdsStoreAccountPenaltyValue: TBCDField
      FieldName = 'PenaltyValue'
      Precision = 19
    end
    object cdsStoreAccountDailtInterest: TBCDField
      FieldName = 'DailtInterest'
      Precision = 19
    end
    object cdsStoreAccountInterest: TCurrencyField
      FieldName = 'Interest'
      ReadOnly = True
    end
    object cdsStoreAccountTotal: TCurrencyField
      FieldName = 'Total'
      ReadOnly = True
    end
  end
  object dsStoreAccount: TDataSource [12]
    DataSet = cdsStoreAccount
    Left = 74
    Top = 232
  end
  object quHistory: TADODataSet [13]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'SA.IDStoreAccount,'#13#10#9'SA.IDPessoa,'#13#10#9'SA.IDUser,'#13#10#9'SA.IDS' +
      'tore,'#13#10#9'SA.IDLancamento,'#13#10#9'SA.TransactionDate,'#13#10#9'SA.Amount,'#13#10#9'SU' +
      '.SystemUser,'#13#10#9'S.Name as Store'#13#10'FROM'#13#10#9'Sal_StoreAccount SA (NOLO' +
      'CK)'#13#10#9'JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = SA.IDUser)'#13#10#9'J' +
      'OIN Store S (NOLOCK) ON (SA.IDStore = S.IDStore)'#13#10'WHERE'#13#10#9'SA.IsU' +
      'sed = 1'#13#10#9'AND'#13#10#9'SA.IsReceiving = 1'#13#10#9'AND'#13#10#9'SA.IDPessoa = :IDPess' +
      'oa'#13#10#9'AND'#13#10#9'SA.IDStore = IsNull(:IDStore, SA.IDStore)'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 179
    Top = 182
    object quHistoryIDStoreAccount: TIntegerField
      DisplayLabel = 'Trans #'
      FieldName = 'IDStoreAccount'
    end
    object quHistoryIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quHistoryIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quHistoryIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quHistoryIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quHistoryTransactionDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'TransactionDate'
    end
    object quHistoryAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quHistorySystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quHistoryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object dsHistory: TDataSource [14]
    DataSet = quHistory
    Left = 207
    Top = 172
  end
  object quCustomerCard: TADODataSet [15]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'P.IDPessoa '#13#10'FROM '#13#10#9'Pessoa P'#13#10#9'JOIN TipoPessoa TP ON ' +
      '(P.IDTipoPessoa = TP.IDTipoPessoa)'#13#10'WHERE'#13#10#9'TP.Path like '#39'.001%'#39 +
      #13#10#9'AND'#13#10#9'P.CustomerCard = :CustomerCard'#13#10
    Parameters = <
      item
        Name = 'CustomerCard'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 291
    Top = 204
    object quCustomerCardIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmStoreAccount.sil'
  end
  object quTemporary: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SA.IDStoreAccount,'#13#10#9'SA.IDPessoa,'#13#10#9'SA.IDUser,'#13#10#9'SA.IDS' +
      'tore,'#13#10#9'SA.TransactionDate,'#13#10#9'SA.Amount,'#13#10#9'SU.SystemUser,'#13#10#9'S.Na' +
      'me as Store'#13#10'FROM'#13#10#9'Sal_StoreAccount SA (NOLOCK)'#13#10#9'JOIN SystemUs' +
      'er SU (NOLOCK) ON (SU.IDUser = SA.IDUser)'#13#10#9'JOIN Store S (NOLOCK' +
      ') ON (SA.IDStore = S.IDStore)'#13#10'WHERE'#13#10#9'SA.Verify = 1'#13#10#9'AND'#13#10#9'SA.' +
      'IDPessoa = :IDPessoa'#13#10#9'AND'#13#10#9'SA.IDStore = IsNull(:IDStore, SA.ID' +
      'Store)'#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 182
    Top = 231
    object quTemporaryIDStoreAccount: TIntegerField
      FieldName = 'IDStoreAccount'
    end
    object quTemporaryIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quTemporaryIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quTemporaryIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quTemporaryTransactionDate: TDateTimeField
      FieldName = 'TransactionDate'
      DisplayFormat = 'ddddd'
    end
    object quTemporaryAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quTemporarySystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quTemporaryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object dsTemporary: TDataSource
    DataSet = quTemporary
    Left = 182
    Top = 247
  end
end
