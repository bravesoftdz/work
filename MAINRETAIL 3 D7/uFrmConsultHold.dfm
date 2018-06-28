inherited FrmConsultHold: TFrmConsultHold
  Left = 191
  Top = 91
  Width = 803
  Height = 586
  BorderIcons = [biSystemMenu]
  Caption = 'Consult Hold'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 124
    Top = 91
    Width = 4
    Height = 427
    Visible = False
  end
  inherited Panel1: TPanel
    Top = 518
    Width = 795
    inherited EspacamentoInferior: TPanel
      Width = 795
      inherited Panel3: TPanel
        Width = 795
      end
    end
    inherited hhh: TPanel
      Left = 644
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 91
    Height = 427
  end
  inherited EspacamentoDireito: TPanel
    Left = 795
    Top = 91
    Width = 0
    Height = 427
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 795
    Visible = False
  end
  object pnlBasicFilter: TPanel [5]
    Left = 0
    Top = 6
    Width = 795
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label3: TLabel
      Left = 373
      Top = 9
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbFrom: TLabel
      Left = 375
      Top = 56
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'From :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTo: TLabel
      Left = 531
      Top = 56
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 13
      Top = 56
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Document :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 39
      Top = 32
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = 'Name :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 46
      Top = 8
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Hold :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 366
      Top = 33
      Width = 45
      Height = 13
      Alignment = taRightJustify
      Caption = 'Status :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pblGO: TPanel
      Left = 717
      Top = 0
      Width = 78
      Height = 85
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 10
      object pnlAviso: TPanel
        Left = 8
        Top = 21
        Width = 65
        Height = 30
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        object btnExec: TSpeedButton
          Left = 5
          Top = 2
          Width = 56
          Height = 26
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          ParentFont = False
          OnClick = btnExecClick
        end
      end
    end
    object cmbStore: TSuperComboADO
      Left = 417
      Top = 5
      Width = 214
      Height = 21
      TabOrder = 5
      Text = '<-->'
      OnChange = edtHoldNumberChange
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object Button2: TButton
      Left = 636
      Top = 6
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 6
      OnClick = Button2Click
    end
    object DateInicio: TDateBox
      Left = 417
      Top = 52
      Width = 87
      Height = 21
      TabOrder = 8
      OnChange = edtHoldNumberChange
      InputTime = False
    end
    object DateFim: TDateBox
      Left = 550
      Top = 52
      Width = 82
      Height = 21
      TabOrder = 9
      OnChange = edtHoldNumberChange
      InputTime = False
      Language = Portuguese
    end
    object cbmDocs: TComboBox
      Left = 84
      Top = 52
      Width = 98
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 3
      OnChange = edtHoldNumberChange
      Items.Strings = (
        ''
        'Driver License'
        'Social Security'
        'Customer Card'
        'Employee ID')
    end
    object edtDocs: TEdit
      Left = 183
      Top = 52
      Width = 86
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edtHoldNumberChange
    end
    object cbmName: TComboBox
      Left = 84
      Top = 28
      Width = 98
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      OnChange = edtHoldNumberChange
      Items.Strings = (
        ''
        'First Name'
        'Last Name'
        'Full Name')
    end
    object edtNames: TEdit
      Left = 183
      Top = 28
      Width = 86
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edtHoldNumberChange
    end
    object edtHoldNumber: TEdit
      Left = 84
      Top = 4
      Width = 98
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edtHoldNumberChange
    end
    object cbsStatus: TComboBox
      Left = 418
      Top = 29
      Width = 213
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 7
      Text = 'All'
      OnChange = edtHoldNumberChange
      Items.Strings = (
        'All'
        'Holds only'
        'Invoices only')
    end
  end
  object pnlInvoices: TPanel [6]
    Left = 3
    Top = 91
    Width = 121
    Height = 427
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object grdHold: TcxGrid
      Left = 0
      Top = 0
      Width = 121
      Height = 427
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdHoldDB: TcxGridDBTableView
        DataController.DataSource = dsHolds
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPreSale'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skCount
            FieldName = 'SaleCode'
            Column = grdHoldDBSaleCode
          end>
        DataController.Summary.SummaryGroups = <>
        OnCellClick = grdHoldDBCellClick
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdHoldDBName: TcxGridDBColumn
          DataBinding.FieldName = 'Name'
          Visible = False
          GroupIndex = 0
          SortOrder = soAscending
        end
        object grdHoldDBSaleCode: TcxGridDBColumn
          Caption = 'Hold'
          DataBinding.FieldName = 'SaleCode'
          SortOrder = soAscending
          Width = 33
        end
        object grdHoldDBPreSaleDate: TcxGridDBColumn
          Caption = 'HoldDate'
          DataBinding.FieldName = 'PreSaleDate'
          Width = 69
        end
      end
      object grdHoldLevel: TcxGridLevel
        GridView = grdHoldDB
      end
    end
  end
  object pnlDetail: TPanel [7]
    Left = 128
    Top = 91
    Width = 667
    Height = 427
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object pnlBotton: TPanel
      Left = 0
      Top = 248
      Width = 667
      Height = 179
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object PageControl1: TPageControl
        Left = 0
        Top = 4
        Width = 659
        Height = 175
        ActivePage = tsOtherCosts
        TabOrder = 0
        object tsOtherCosts: TTabSheet
          Caption = 'Other Costs'
          ImageIndex = 2
          object grdInvExpenses: TcxGrid
            Left = 0
            Top = 0
            Width = 651
            Height = 147
            Align = alClient
            TabOrder = 0
            LookAndFeel.Kind = lfFlat
            object grdInvExpensesDB: TcxGridDBTableView
              DataController.DataSource = dsAddExpenses
              DataController.Filter.Criteria = {FFFFFFFF0000000000}
              DataController.KeyFieldNames = 'IDInvoiceCost'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'SubTotal'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'Tax'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'TotalInvoice'
                end>
              DataController.Summary.SummaryGroups = <>
              Filtering.MaxDropDownCount = 50
              Filtering.Visible = fvNever
              OptionsBehavior.IncSearch = True
              OptionsCustomize.ColumnFiltering = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLines = glHorizontal
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              OptionsView.HeaderEndEllipsis = True
              Preview.AutoHeight = False
              Preview.MaxLineCount = 2
              Preview.Visible = True
              object grdInvExpensesDBCostType: TcxGridDBColumn
                DataBinding.FieldName = 'CostType'
              end
              object grdInvExpensesDBAmount: TcxGridDBColumn
                DataBinding.FieldName = 'Amount'
              end
            end
            object grdLevelInvExpenses: TcxGridLevel
              GridView = grdInvExpensesDB
            end
          end
        end
        object tsPayments: TTabSheet
          Caption = 'Payments'
          object btnPayments: TSpeedButton
            Tag = 10
            Left = 564
            Top = 2
            Width = 82
            Height = 25
            Caption = 'Detail'
            Enabled = False
            Flat = True
            Margin = 6
            OnClick = btnPaymentsClick
          end
          object SubPaymentType: TSubListPanel
            Left = 0
            Top = 0
            Width = 559
            Height = 151
            Align = alLeft
            BevelOuter = bvNone
            Color = clBtnShadow
            TabOrder = 0
            SubListClassName = 'TSubHoldPayments'
          end
        end
        object tsDelivery: TTabSheet
          Caption = 'Delivery'
          ImageIndex = 1
          object grdDelivery: TcxGrid
            Left = 0
            Top = 0
            Width = 651
            Height = 147
            Align = alClient
            TabOrder = 0
            LookAndFeel.Kind = lfFlat
            object grdDeliveryDB: TcxGridDBTableView
              DataController.DataSource = dsDeliveryInfo
              DataController.Filter.Criteria = {FFFFFFFF0000000000}
              DataController.KeyFieldNames = 'IDPreSale'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'SubTotal'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'Tax'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'TotalInvoice'
                end>
              DataController.Summary.SummaryGroups = <>
              Filtering.MaxDropDownCount = 50
              Filtering.Visible = fvNever
              OptionsBehavior.IncSearch = True
              OptionsCustomize.ColumnFiltering = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLines = glHorizontal
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              OptionsView.HeaderEndEllipsis = True
              Preview.AutoHeight = False
              Preview.Column = grdDeliveryDBDeliverOBS
              Preview.MaxLineCount = 2
              Preview.Visible = True
              object grdDeliveryDBDeliverType: TcxGridDBColumn
                DataBinding.FieldName = 'DeliverType'
                Visible = False
                GroupIndex = 0
                SortOrder = soAscending
                Width = 53
              end
              object grdDeliveryDBDeliverDate: TcxGridDBColumn
                DataBinding.FieldName = 'DeliverDate'
                SortOrder = soAscending
                Width = 89
              end
              object grdDeliveryDBDeliverAddress: TcxGridDBColumn
                DataBinding.FieldName = 'DeliverAddress'
                Width = 274
              end
              object grdDeliveryDBDeliverOBS: TcxGridDBColumn
                DataBinding.FieldName = 'DeliverOBS'
                Width = 70
              end
              object grdDeliveryDBSaleCode: TcxGridDBColumn
                DataBinding.FieldName = 'SaleCode'
                Width = 71
              end
              object grdDeliveryDBInvoiceCode: TcxGridDBColumn
                DataBinding.FieldName = 'InvoiceCode'
                Width = 83
              end
              object grdDeliveryDBUserDeliver: TcxGridDBColumn
                DataBinding.FieldName = 'UserDeliver'
                Width = 115
              end
            end
            object cxgrdDelivery: TcxGridLevel
              GridView = grdDeliveryDB
            end
          end
        end
        object tsNotes: TTabSheet
          Caption = 'Notes'
          ImageIndex = 3
          object EditNote: TDbMemoStr
            Tag = 3
            Left = 0
            Top = 0
            Width = 648
            Height = 151
            TabStop = False
            Align = alLeft
            BorderStyle = bsNone
            Color = clInfoBk
            DataField = 'Note'
            DataSource = dsHolds
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
    end
    object pnlPaymentInfo: TPanel
      Left = 2
      Top = 1
      Width = 541
      Height = 93
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 541
        Height = 93
        Align = alClient
        Brush.Color = clBtnFace
        Pen.Color = clGray
        Shape = stRoundRect
      end
      object lbCustomer: TLabel
        Left = 0
        Top = 0
        Width = 545
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customer Info'
        Color = 12615680
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object SubCustomer: TSubListPanel
        Left = 1
        Top = 13
        Width = 539
        Height = 71
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubCustomerInfo'
      end
    end
    object Panel5: TPanel
      Left = 3
      Top = 98
      Width = 659
      Height = 153
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      object Shape3: TShape
        Left = 0
        Top = -5
        Width = 659
        Height = 157
        Brush.Color = clBtnFace
        Pen.Color = clGray
        Shape = stRoundRect
      end
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 663
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Items'
        Color = 4227072
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lblCanceledHold: TLabel
        Left = 284
        Top = 134
        Width = 63
        Height = 16
        Caption = 'Canceled!'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object grdItem: TcxGrid
        Left = 2
        Top = 13
        Width = 655
        Height = 121
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdItemDB: TcxGridDBTableView
          DataController.DataSource = dsPreSaleItem
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDInventoryMov'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'SubTotal'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Tax'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'TotalInvoice'
            end>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          Preview.Visible = True
          object grdItemDBSaleCode: TcxGridDBColumn
            Caption = 'Hold #'
            DataBinding.FieldName = 'SaleCode'
            Width = 59
          end
          object grdItemDBInvoiceCode: TcxGridDBColumn
            Caption = 'Invoice #'
            DataBinding.FieldName = 'ItemNumber'
            Width = 62
          end
          object grdItemDBModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Width = 75
          end
          object grdItemDBDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 221
          end
          object grdItemDBIsDelivered: TcxGridDBColumn
            Caption = 'Delivered'
            DataBinding.FieldName = 'IsDelivered'
            Visible = False
          end
          object grdItemDBSalesPerson: TcxGridDBColumn
            DataBinding.FieldName = 'SalesPerson'
            Width = 121
          end
          object grdItemDBQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
            Width = 39
          end
          object grdItemDBTotalItem: TcxGridDBColumn
            DataBinding.FieldName = 'TotalItem'
            Width = 76
          end
        end
        object cxgrdItem: TcxGridLevel
          GridView = grdItemDB
        end
      end
    end
    object Panel2: TPanel
      Left = 545
      Top = 1
      Width = 118
      Height = 94
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 3
      object Shape2: TShape
        Left = 0
        Top = -5
        Width = 118
        Height = 99
        Brush.Color = clBtnFace
        Pen.Color = clGray
        Shape = stRoundRect
      end
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 118
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Actions'
        Color = 8404992
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object btnHistory: TSpeedButton
        Tag = 10
        Left = 2
        Top = 15
        Width = 115
        Height = 25
        Caption = 'Add History'
        Enabled = False
        Flat = True
        Margin = 2
        OnClick = btnHistoryClick
      end
      object btnPrint: TSpeedButton
        Tag = 10
        Left = 2
        Top = 40
        Width = 115
        Height = 25
        Caption = 'Print'
        Enabled = False
        Flat = True
        Margin = 2
        OnClick = btnPrintClick
      end
      object btnUpdateHold: TSpeedButton
        Tag = 10
        Left = 2
        Top = 41
        Width = 115
        Height = 25
        Caption = 'Update Hold #'
        Enabled = False
        Flat = True
        Margin = 2
        Visible = False
        OnClick = btnUpdateHoldClick
      end
      object btnUpdateInv: TSpeedButton
        Tag = 10
        Left = 2
        Top = 65
        Width = 115
        Height = 25
        Caption = 'Update Invoice #'
        Enabled = False
        Flat = True
        Margin = 2
        OnClick = btnUpdateInvClick
      end
    end
  end
  object quHolds: TPowerADOQuery [8]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 500
    AfterOpen = quHoldsAfterOpen
    AfterScroll = quHoldsAfterScroll
    CommandText = 
      'SELECT'#13#10#9'I.IDPreSale,'#13#10#9'I.IDInvoice,'#13#10#9'I.InvoiceDate,'#13#10#9'I.PreSal' +
      'eDate,'#13#10#9'I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax' +
      ' + IsNull(I.AditionalExpenses, 0) as TotalInvoice,'#13#10#9'I.SubTotal ' +
      '- I.InvoiceDiscount - I.ItemDiscount as SubTotal,'#13#10#9'I.Tax,'#13#10#9'I.L' +
      'ayaway,'#13#10#9'I.SaleCode,'#13#10#9'I.InvoiceCode,'#13#10#9'IsNull(I.AditionalExpen' +
      'ses, 0) AS AditionalExpenses,'#13#10#9'I.Note,'#13#10#9'I.Canceled,'#13#10#9'S.IDStor' +
      'e,'#13#10#9'S.Name,'#13#10#9'P.IDPessoa'#13#10'FROM'#13#10#9'Invoice I (NOLOCK) '#13#10#9'LEFT OUT' +
      'ER JOIN Store S (NOLOCK)  ON (I.IDStore = S.IDStore)'#13#10#9'LEFT OUTE' +
      'R JOIN Pessoa P (NOLOCK)  ON (I.IDCustomer = P.IDPessoa)'#13#10'ORDER ' +
      'BY'#13#10#9'I.IDStore,'#13#10#9'I.SaleCode '#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 40
    Top = 144
    object quHoldsIDPreSale: TIntegerField
      DisplayLabel = 'Hold'
      FieldName = 'IDPreSale'
      ReadOnly = True
    end
    object quHoldsIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
      ReadOnly = True
    end
    object quHoldsInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object quHoldsTotalInvoice: TBCDField
      FieldName = 'TotalInvoice'
      ReadOnly = True
      Precision = 19
    end
    object quHoldsSubTotal: TBCDField
      FieldName = 'SubTotal'
      ReadOnly = True
      Precision = 19
    end
    object quHoldsTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object quHoldsLayaway: TBooleanField
      FieldName = 'Layaway'
    end
    object quHoldsAditionalExpenses: TBCDField
      FieldName = 'AditionalExpenses'
      ReadOnly = True
      Precision = 19
    end
    object quHoldsIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quHoldsName: TStringField
      DisplayLabel = 'Store'
      FieldName = 'Name'
      Size = 30
    end
    object quHoldsIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quHoldsPreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
      ReadOnly = True
      DisplayFormat = 'ddddd'
    end
    object quHoldsNote: TStringField
      FieldName = 'Note'
      ReadOnly = True
      Size = 150
    end
    object quHoldsSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object quHoldsInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
    end
    object quHoldsCanceled: TBooleanField
      FieldName = 'Canceled'
    end
  end
  object dsHolds: TDataSource [9]
    DataSet = quHolds
    Left = 37
    Top = 190
  end
  object quPreSaleItem: TADOStoredProc [10]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    OnCalcFields = quPreSaleItemCalcFields
    ProcedureName = 'sp_PreSale_quPreSaleItemSplited;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@DocumentID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IsPreSale'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = True
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 266
    Top = 217
    object quPreSaleItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quPreSaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPreSaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPreSaleItemSalePrice: TFloatField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00##'
    end
    object quPreSaleItemDiscount: TFloatField
      FieldName = 'Discount'
      DisplayFormat = '0.00'
    end
    object quPreSaleItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quPreSaleItemTotalItem: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalItem'
      DisplayFormat = '#,##0.00##'
      Calculated = True
    end
    object quPreSaleItemSalesPerson: TStringField
      FieldName = 'SalesPerson'
      Size = 50
    end
    object quPreSaleItemIDComission: TIntegerField
      FieldName = 'IDComission'
    end
    object quPreSaleItemCostPrice: TFloatField
      FieldName = 'CostPrice'
    end
    object quPreSaleItemIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quPreSaleItemExchangeInvoice: TIntegerField
      FieldName = 'ExchangeInvoice'
    end
    object quPreSaleItemTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object quPreSaleItemUnitSalePrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'UnitSalePrice'
      DisplayFormat = '#,##0.00##'
      Calculated = True
    end
    object quPreSaleItemTaxValue: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TaxValue'
      Calculated = True
    end
    object quPreSaleItemCodSize: TStringField
      FieldName = 'CodSize'
      Size = 10
    end
    object quPreSaleItemSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quPreSaleItemCodColor: TStringField
      FieldName = 'CodColor'
      Size = 10
    end
    object quPreSaleItemColor: TStringField
      FieldName = 'Color'
    end
    object quPreSaleItemSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quPreSaleItemIsDelivered: TBooleanField
      FieldName = 'IsDelivered'
    end
    object quPreSaleItemSerialNumber: TBooleanField
      FieldName = 'SerialNumber'
    end
    object quPreSaleItemSaleCode: TStringField
      DisplayWidth = 20
      FieldName = 'SaleCode'
    end
    object quPreSaleItemInvoiceCode: TStringField
      DisplayWidth = 20
      FieldName = 'InvoiceCode'
    end
    object quPreSaleItemAutoServiceNum: TIntegerField
      FieldName = 'AutoServiceNum'
    end
    object quPreSaleItemItemNumber: TStringField
      FieldKind = fkCalculated
      FieldName = 'ItemNumber'
      Calculated = True
    end
    object quPreSaleItemQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quPreSaleItemPromo: TBooleanField
      FieldName = 'Promo'
    end
    object quPreSaleItemSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object quPreSaleItemCupomFiscal: TStringField
      FieldName = 'CupomFiscal'
      Size = 8
    end
  end
  object quDeliveryInfo: TADOQuery [11]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale1'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      #9'I.IDPreSale, '
      #9'I.DeliverTypeID, '
      #9'I.SaleCode, '
      #9'I.InvoiceCode, '
      #9'I.DeliverDate,'
      #9'I.DeliverAddress,'
      #9'I.DeliverOBS,'
      #9'I.DeliverConfirmation,'
      #9'I.IDFormOfPayment,'
      #9'DT.Name as DeliverType,'
      #9'SU.SystemUser as UserDeliver'
      'FROM '
      #9'Invoice I (NOLOCK) '
      
        #9'LEFT OUTER JOIN DeliverType DT (NOLOCK) ON (I.DeliverTypeID = D' +
        'T.IDDeliverType)'
      
        #9'LEFT JOIN InvoiceOBS OBS (NOLOCK) ON (OBS.IDPreSale = I.IDPreSa' +
        'le)'
      
        #9'LEFT JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = OBS.IDUserDeli' +
        'ver)'
      'WHERE '
      #9'I.IDPreSale = :IDPreSale1'
      #9'OR'
      #9'I.IDPreSaleParent = :IDPreSale'
      'ORDER BY'
      #9'DeliverDate')
    Left = 647
    Top = 367
    object quDeliveryInfoIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quDeliveryInfoDeliverTypeID: TIntegerField
      FieldName = 'DeliverTypeID'
    end
    object quDeliveryInfoDeliverDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'DeliverDate'
    end
    object quDeliveryInfoDeliverAddress: TStringField
      DisplayLabel = 'Address'
      FieldName = 'DeliverAddress'
      Size = 100
    end
    object quDeliveryInfoDeliverOBS: TStringField
      DisplayLabel = 'OBS'
      FieldName = 'DeliverOBS'
      Size = 255
    end
    object quDeliveryInfoDeliverConfirmation: TBooleanField
      FieldName = 'DeliverConfirmation'
    end
    object quDeliveryInfoIDFormOfPayment: TIntegerField
      FieldName = 'IDFormOfPayment'
    end
    object quDeliveryInfoDeliverType: TStringField
      DisplayLabel = 'Type'
      FieldName = 'DeliverType'
      Size = 30
    end
    object quDeliveryInfoSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object quDeliveryInfoInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
    end
    object quDeliveryInfoUserDeliver: TStringField
      DisplayLabel = 'User'
      FieldName = 'UserDeliver'
      Size = 50
    end
  end
  object dsPreSaleItem: TDataSource [12]
    DataSet = quPreSaleItem
    Left = 272
    Top = 265
  end
  object dsDeliveryInfo: TDataSource [13]
    DataSet = quDeliveryInfo
    Left = 647
    Top = 420
  end
  object quAddExpenses: TADODataSet [14]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'C.CostType,'#13#10#9'ICT.IDInvoiceCost,'#13#10#9'ICT.IDCostType,'#13#10#9'IC' +
      'T.Amount'#13#10'FROM '#13#10#9'InvoiceToCostType ICT (NOLOCK) '#13#10#9'LEFT OUTER J' +
      'OIN CostType C (NOLOCK)  ON (C.IDCostType = ICT.IDCostType)'#13#10'WHE' +
      'RE'#13#10#9'ICT.IDPreSale = :IDPreSale'#13#10
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 570
    Top = 415
    object quAddExpensesCostType: TStringField
      FieldName = 'CostType'
      Size = 50
    end
    object quAddExpensesIDInvoiceCost: TIntegerField
      FieldName = 'IDInvoiceCost'
    end
    object quAddExpensesIDCostType: TIntegerField
      FieldName = 'IDCostType'
    end
    object quAddExpensesAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dsAddExpenses: TDataSource [15]
    DataSet = quAddExpenses
    Left = 570
    Top = 365
  end
  object TimeAviso: TTimer [16]
    Enabled = False
    Interval = 300
    OnTimer = TimeAvisoTimer
    Left = 686
    Top = 38
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmConsultHold.sil'
  end
end
