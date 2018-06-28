inherited FrmEstimated: TFrmEstimated
  Left = 196
  Top = 93
  Width = 799
  Height = 568
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Estimates'
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 222
    Top = 100
    Width = 4
    Height = 400
  end
  inherited Panel1: TPanel
    Top = 500
    Width = 791
    inherited EspacamentoInferior: TPanel
      Width = 791
      inherited Panel3: TPanel
        Width = 791
      end
    end
    inherited hhh: TPanel
      Left = 535
      Width = 256
      inherited sbHelp: TSpeedButton
        Left = 1
        Width = 80
      end
      inherited btClose: TButton
        Left = 167
        Width = 80
        OnClick = btCloseClick
      end
      object btnPrint: TBitBtn
        Left = 84
        Top = 3
        Width = 80
        Height = 31
        Caption = '&Print'
        TabOrder = 1
        OnClick = btnPrintClick
        Glyph.Data = {
          A2070000424DA207000000000000360000002800000019000000190000000100
          1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C69C96949C9694FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECBCEBDBA
          BDDEDBDEDEDFDEADAEADB5B2B59C9694BD8E84A58E84ADAEADFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFBDBABDCECFCEEFEFEFEFEFEFDEDBDEADAEADB5B2B58C8E8C4A4D4A63
          61636361638C8A8C9C9694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFBDBEBDC6C3C6EFEBEFF7F3F7EFEFEFEFEBEFD6D3D6AD
          AAADADAEAD8C8E8C4A4D4A4241426361636361638486848C8E8CADAEADC6C7C6
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDBABDDEDFDEFFFBFFFFF7F7EF
          EFEFEFEBEFE7E3E7D6D3D6ADAAADADAAADADAEADADAEADADAAAD8C8A8C737173
          6361638486848C8E8CB5B2B59C9E9CFFFFFFFFFFFF00FFFFFFFFFFFFBDBABDFF
          FFFFFFFBFFFFF7F7EFEFEFEFEBEFDEDBDEB5B2B58C8E8C8482848C8E8CADAAAD
          ADAEADADAEADB5B2B5BDBABDADAEAD9C9E9C636163525152CECBCEFFFFFFFFFF
          FF00FFFFFFFFFFFFADAEADFFFBFFFFF7F7EFEFEFDEDBDE9C9E9C9C9E9CBDBABD
          C6C7C69C9E9C8C8E8C8482848482848C8E8C9C9E9CB5B2B5BDBABDBDBEBDC6C3
          C6BDBABDC6C7C6FFFFFFFFFFFF00FFFFFFFFFFFFADAAADF7F3F7CECFCE9C9694
          9C9E9CD6D3D6DEDBDED6D3D6D6D3D6CECBCEBDBEBDADAAADADAAAD9C9E9C8C8E
          8C8486848C8A8C9C9E9CBDBABD8CBE8C8CBE8CFFFFFFFFFFFF00FFFFFFFFFFFF
          9C9E9C8C8A8C9C9694DEDBDEDEDFDEDEDBDED6D3D6CECBCEEFEBEFE7E7E7E7E7
          E7EFEBEFDEDBDECECBCEBDBABDADAEADADAEAD9C96948486848482849C9694FF
          FFFFFFFFFF00FFFFFFFFFFFF8C8E8CEFEBEFE7E3E7DEDFDEDEDBDED6D3D6CECF
          CEE7E3E7DEDBDEB5B2B5BDBABDBDBABDBDBEBDCECFCEE7E7E7E7E7E7D6D3D6C6
          C7C6BDBEBDBDBABDADAAADFFFFFFFFFFFF00FFFFFFFFFFFF8C8A8CE7E3E7DEDF
          DEDEDBDED6D3D6CECFCEDEDBDEE7E7E7C6C3C6EFEFEFEFEFEFEFEBEFCECFCEBD
          BEBDBDBABDBDBABDBDBEBDD6D3D6E7E3E7DEDFDED6D3D6FFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFD6D3D6DEDBDED6D3D6CECFCEDEDFDECECFCEC6C3C6F7F3F7F7
          F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEFDEDBDEC6C7C6BDBABDBDBABDBDBABD
          CECBCEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADAEADBDBEBDC6
          C3C6D6D3D6C6C7C6CECBCEE7E7E7F7F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEF
          E7E7E7E7E7E7D6D3D6ADAEADFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFADAAADE7E7E7E7E7E7ADAEADB5B2B5BDBABDBDBABDC6C3C6
          CECBCEDEDBDEE7E7E7E7E7E7EFEBEFCECBCEB5B2B5FFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAAADFFFBF7FFF3E7EFDBCE
          D6D3D6C6C7C6C6C7C6BDBABDC6C3C6BDBEBDBDAAA5BDAAA5B5B2B5DEDBDEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFCE9A84FFD7ADFFD7ADFFD7ADFFDFBDFFDFBDFFEBD6F7E3D6EFE7DECEAA
          ADDEDBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6AA94FFDFBDFFD7ADFFDFBDFFD7ADFFDF
          BDFFD7ADFFDFBDF7D3A5BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3B5FFDF
          BDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDD6B2ADBD9A94FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDEC7B5FFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEBD
          9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9A94FFEBD6FFEBD6FFEBD6FFEBD6FF
          EBD6FFEBD6FFEBD6EFDBCEBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECBC6FF
          F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7D6B2ADBD9A94FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFD6BEBDFFF7EFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFF7EF
          BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED7D6FFFFFFFFFBFFFFFFFFFFFFFF
          FFFBFFFFFFFFFFFFFFEFEBEFBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFCEBEB5BD9A94
          BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00}
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 100
    Height = 400
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 788
    Top = 100
    Height = 400
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Top = 100
    Width = 791
    Height = 0
    Visible = False
  end
  object pnlBasicFilter: TPanel [5]
    Left = 0
    Top = 0
    Width = 791
    Height = 100
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
      Top = 6
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
      Top = 30
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
      Top = 30
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
      Top = 54
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
      Top = 30
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
      Left = 14
      Top = 6
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estimated :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 43
      Top = 77
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pblGO: TPanel
      Left = 713
      Top = 0
      Width = 78
      Height = 100
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 13
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
      Top = 2
      Width = 214
      Height = 21
      TabOrder = 1
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
      Top = 3
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 2
      OnClick = Button2Click
    end
    object DateInicio: TDateBox
      Left = 417
      Top = 26
      Width = 87
      Height = 21
      TabOrder = 3
      OnChange = edtHoldNumberChange
      InputTime = False
    end
    object DateFim: TDateBox
      Left = 550
      Top = 26
      Width = 82
      Height = 21
      TabOrder = 4
      OnChange = edtHoldNumberChange
      InputTime = False
      Language = Portuguese
    end
    object cbmDocs: TComboBox
      Left = 84
      Top = 50
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
      TabOrder = 5
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
      Top = 50
      Width = 86
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object cbmName: TComboBox
      Left = 84
      Top = 26
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
      TabOrder = 7
      OnChange = edtHoldNumberChange
      Items.Strings = (
        ''
        'First Name'
        'Last Name'
        'Full Name')
    end
    object edtNames: TEdit
      Left = 183
      Top = 26
      Width = 86
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object edtHoldNumber: TEdit
      Left = 84
      Top = 2
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
    object scUser: TSuperComboADO
      Left = 83
      Top = 73
      Width = 187
      Height = 21
      TabOrder = 9
      Text = '<-->'
      OnChange = edtHoldNumberChange
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object Button1: TButton
      Left = 275
      Top = 74
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 10
      OnClick = Button1Click
    end
    object chUpdatePrice: TCheckBox
      Left = 417
      Top = 77
      Width = 188
      Height = 17
      Caption = 'Update Price'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 11
    end
    object chkImported: TCheckBox
      Left = 417
      Top = 53
      Width = 215
      Height = 17
      Caption = 'Estimate Imported'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
    end
  end
  object pnlInvoices: TPanel [6]
    Left = 3
    Top = 100
    Width = 219
    Height = 400
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    object grdEstimated: TcxGrid
      Left = 0
      Top = 46
      Width = 219
      Height = 354
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdEstimatedDB: TcxGridDBTableView
        OnDblClick = grdEstimatedDBDblClick
        DataController.DataSource = dsEstimated
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDEstimated'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OnCellClick = grdEstimatedDBCellClick
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
        object grdEstimatedDBIDEstimated: TcxGridDBColumn
          Caption = 'Estimated #'
          DataBinding.FieldName = 'IDEstimated'
          Width = 52
        end
        object grdEstimatedDBName: TcxGridDBColumn
          Caption = 'Store'
          DataBinding.FieldName = 'Name'
          Visible = False
          GroupIndex = 0
          SortOrder = soAscending
        end
        object grdEstimatedDBPessoa: TcxGridDBColumn
          Caption = 'Customer'
          DataBinding.FieldName = 'Pessoa'
          Width = 110
        end
        object grdEstimatedDBSystemUser: TcxGridDBColumn
          DataBinding.FieldName = 'SystemUser'
          Visible = False
          GroupIndex = 1
          SortOrder = soAscending
        end
      end
      object grdEstimatedLevel: TcxGridLevel
        GridView = grdEstimatedDB
      end
    end
    object pnlControl: TPanel
      Left = 0
      Top = 0
      Width = 219
      Height = 46
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object btNewEstimated: TSpeedButton
        Left = 1
        Top = 2
        Width = 72
        Height = 22
        Caption = 'Add'
        Flat = True
        Margin = 1
        Spacing = 3
        OnClick = btNewEstimatedClick
      end
      object btRemoveEst: TSpeedButton
        Left = 145
        Top = 2
        Width = 72
        Height = 22
        Caption = 'Remove'
        Enabled = False
        Flat = True
        Margin = 1
        Spacing = 3
        OnClick = btRemoveEstClick
      end
      object btOpenEstimated: TSpeedButton
        Left = 73
        Top = 2
        Width = 72
        Height = 22
        Caption = 'Open'
        Enabled = False
        Flat = True
        Margin = 1
        Spacing = 3
        OnClick = btOpenEstimatedClick
      end
      object btnCreateHold: TSpeedButton
        Left = 1
        Top = 24
        Width = 89
        Height = 22
        Caption = 'Create Hold'
        Enabled = False
        Flat = True
        Margin = 1
        Spacing = 3
        OnClick = btnCreateHoldClick
      end
      object btnConfirm: TSpeedButton
        Left = 91
        Top = 24
        Width = 89
        Height = 22
        Caption = 'Confirm'
        Enabled = False
        Flat = True
        Margin = 1
        Spacing = 3
        OnClick = btnConfirmClick
      end
    end
  end
  object pnlDetail: TPanel [7]
    Left = 226
    Top = 100
    Width = 562
    Height = 400
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object Splitter2: TSplitter
      Left = 0
      Top = 215
      Width = 562
      Height = 4
      Cursor = crVSplit
      Align = alTop
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 562
      Height = 25
      Align = alTop
      TabOrder = 0
      object btRemoveEstItem: TSpeedButton
        Left = 213
        Top = 2
        Width = 95
        Height = 22
        Caption = '&Remove item'
        Enabled = False
        Flat = True
        Margin = 3
        OnClick = btRemoveEstItemClick
      end
      object btNewEstItem: TSpeedButton
        Left = 2
        Top = 2
        Width = 99
        Height = 22
        Caption = 'Add item'
        Enabled = False
        Flat = True
        Margin = 3
        OnClick = btNewEstItemClick
      end
      object btOpenEstItem: TSpeedButton
        Left = 114
        Top = 2
        Width = 99
        Height = 22
        Caption = 'Open item'
        Enabled = False
        Flat = True
        Margin = 3
        OnClick = btOpenEstItemClick
      end
      object btnAddQuick: TSpeedButton
        Left = 101
        Top = 2
        Width = 13
        Height = 22
        Enabled = False
        Flat = True
        Glyph.Data = {
          A6000000424DA600000000000000760000002800000009000000060000000100
          04000000000030000000C40E0000C40E00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888808888000
          0000888000888000000088000008800000008000000080000000000000000000
          00008888888880000000}
        OnClick = btnAddQuickClick
      end
      object btPOItemPreview: TSpeedButton
        Left = 308
        Top = 2
        Width = 70
        Height = 22
        Caption = 'Preview'
        Enabled = False
        Flat = True
        Margin = 3
        OnClick = btPOItemPreviewClick
      end
      object btCustomizeColumns: TSpeedButton
        Tag = 4
        Left = 378
        Top = 2
        Width = 70
        Height = 22
        AllowAllUp = True
        Caption = 'Columns'
        Flat = True
        Margin = 3
        OnClick = btCustomizeColumnsClick
      end
      object btGroup: TSpeedButton
        Tag = 3
        Left = 448
        Top = 2
        Width = 75
        Height = 22
        AllowAllUp = True
        GroupIndex = 88997
        Caption = '&Grouping'
        Flat = True
        Margin = 3
        OnClick = btGroupClick
      end
    end
    object grdEstItems: TcxGrid
      Left = 0
      Top = 25
      Width = 562
      Height = 190
      Align = alTop
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object grdEstItemsDB: TcxGridDBTableView
        OnDblClick = grdEstItemsDBDblClick
        DataController.DataSource = dsEstimatedItems
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDEstimatedItem'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'GrandTotal'
            Column = grdEstItemsDBGrandTotal
          end>
        DataController.Summary.SummaryGroups = <>
        OnCellClick = grdEstItemsDBCellClick
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
        object grdEstItemsDBID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'IDEstimatedItem'
          Visible = False
          Options.Filtering = False
          SortOrder = soAscending
          Width = 37
        end
        object grdEstItemsDBCode: TcxGridDBColumn
          DataBinding.FieldName = 'Code'
          Width = 38
        end
        object grdEstItemsDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 73
        end
        object grdEstItemsDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 133
        end
        object grdEstItemsDBQty: TcxGridDBColumn
          DataBinding.FieldName = 'Qty'
          Width = 38
        end
        object grdEstItemsDBSalePrice: TcxGridDBColumn
          DataBinding.FieldName = 'SalePrice'
          Width = 55
        end
        object grdEstItemsDBGrandTotal: TcxGridDBColumn
          DataBinding.FieldName = 'GrandTotal'
          Width = 67
        end
        object grdEstItemsDBManufacturer: TcxGridDBColumn
          DataBinding.FieldName = 'Manufacturer'
          Width = 156
        end
        object grdEstItemsDBDepartment: TcxGridDBColumn
          DataBinding.FieldName = 'Department'
          Visible = False
        end
      end
      object cxgrdEstItems: TcxGridLevel
        GridView = grdEstItemsDB
      end
    end
    object SubWebModelInfo: TSubListPanel
      Left = 0
      Top = 219
      Width = 562
      Height = 181
      Align = alClient
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 2
      SubListClassName = 'TSubModelWebInfo'
    end
  end
  object TimeAviso: TTimer [8]
    Enabled = False
    Interval = 300
    OnTimer = TimeAvisoTimer
    Left = 686
    Top = 38
  end
  object dsEstimated: TDataSource [9]
    DataSet = quEstimated
    OnDataChange = dsEstimatedDataChange
    Left = 37
    Top = 190
  end
  object quEstimatedItems: TPowerADOQuery [10]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quEstimatedItemsCalcFields
    CommandText = 
      'SELECT '#13#10#9'EI.IDEstimatedItem,'#13#10#9'EI.Code,'#13#10#9'EI.IDModel,'#13#10#9'EI.Qty,' +
      #13#10#9'EI.SalePrice as EstSalePrice,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M' +
      '.SellingPrice as SellingPrice,'#13#10#9'Round(IsNull (EI.SalePrice, M.S' +
      'ellingPrice) * EI.Qty, 2, 1) as ExtSalePrice,'#13#10#9'F.Pessoa as Manu' +
      'facturer,'#13#10#9'D.Department'#13#10'FROM'#13#10#9'EstimatedItem EI (NOLOCK) '#13#10#9'JO' +
      'IN Model M (NOLOCK) ON (EI.IDModel = M.IDModel)'#13#10#9'LEFT JOIN Pess' +
      'oa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'#13#10#9'LEFT JOIN Inv_D' +
      'epartment D (NOLOCK) ON (EI.IDDepartment = D.IDDepartment)'#13#10'WHER' +
      'E'#13#10#9'EI.IDEstimated = :IDEstimated'#13#10'ORDER BY'#13#10#9'EI.Code'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDEstimated'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 260
    Top = 144
    object quEstimatedItemsIDEstimatedItem: TIntegerField
      FieldName = 'IDEstimatedItem'
    end
    object quEstimatedItemsCode: TIntegerField
      FieldName = 'Code'
    end
    object quEstimatedItemsIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quEstimatedItemsModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quEstimatedItemsDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quEstimatedItemsGrandTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'GrandTotal'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quEstimatedItemsEstSalePrice: TBCDField
      FieldName = 'EstSalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quEstimatedItemsSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quEstimatedItemsSalePrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quEstimatedItemsQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quEstimatedItemsManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object quEstimatedItemsDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
    object quEstimatedItemsExtSalePrice: TBCDField
      FieldName = 'ExtSalePrice'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
  end
  object dsEstimatedItems: TDataSource [11]
    DataSet = quEstimatedItems
    OnDataChange = dsEstimatedItemsDataChange
    Left = 257
    Top = 190
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmEstimated.sil'
  end
  object quEstimated: TPowerADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterScroll = quEstimatedAfterScroll
    CommandText = 
      'SELECT '#13#10#9'E.IDEstimated,'#13#10#9'E.EstimatedDate,'#13#10#9'E.IDStore,'#13#10#9'E.IDP' +
      'essoa,'#13#10#9'E.IDTouristGroup,'#13#10#9'E.Total,'#13#10#9'E.OBS,'#13#10#9'E.OBS2,'#13#10#9'E.IDP' +
      'reSale,'#13#10#9'S.[Name],'#13#10#9'SU.IDUser,'#13#10#9'SU.SystemUser,'#13#10#9'P.Pessoa,'#13#10#9 +
      'E.IDDeliverType,'#13#10#9'E.DeliverDate,'#13#10#9'E.DeliverAddress,'#13#10#9'E.Delive' +
      'rOBS,'#13#10#9'E.TotalDiscount,'#13#10#9'E.Confirmed'#13#10'FROM'#13#10#9'Estimated E (NOLO' +
      'CK) '#13#10#9'JOIN Store S (NOLOCK) ON (S.IDStore = E.IDStore)'#13#10#9'JOIN S' +
      'ystemUser SU (NOLOCK) ON (SU.IDUser = E.IDUser)'#13#10#9'LEFT JOIN Pess' +
      'oa P (NOLOCK) ON (P.IDPessoa = E.IDPEssoa)'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 40
    Top = 249
    object quEstimatedIDEstimated: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'IDEstimated'
    end
    object quEstimatedEstimatedDate: TDateTimeField
      FieldName = 'EstimatedDate'
      ReadOnly = True
    end
    object quEstimatedTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      Precision = 19
    end
    object quEstimatedOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object quEstimatedOBS2: TStringField
      FieldName = 'OBS2'
      Size = 255
    end
    object quEstimatedName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quEstimatedPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quEstimatedSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quEstimatedIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quEstimatedIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quEstimatedIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quEstimatedIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quEstimatedIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
    end
    object quEstimatedIDDeliverType: TIntegerField
      FieldName = 'IDDeliverType'
    end
    object quEstimatedDeliverDate: TDateTimeField
      FieldName = 'DeliverDate'
    end
    object quEstimatedDeliverAddress: TStringField
      FieldName = 'DeliverAddress'
      Size = 100
    end
    object quEstimatedDeliverOBS: TStringField
      FieldName = 'DeliverOBS'
      Size = 255
    end
    object quEstimatedTotalDiscount: TBCDField
      FieldName = 'TotalDiscount'
      Precision = 19
    end
    object quEstimatedConfirmed: TBooleanField
      FieldName = 'Confirmed'
    end
  end
  object cmdUpdEstimatedItemCode: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'EstimatedItem'#13#10'SET'#13#10#9'Code = :Code'#13#10'WHERE'#13#10#9'IDEstimatedI' +
      'tem = :IDEstimatedItem'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Code'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDEstimatedItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 368
    Top = 232
  end
  object pmAddItem: TPopupMenu
    AutoPopup = False
    Left = 369
    Top = 157
    object miAddItem: TMenuItem
      Caption = 'Add'
      OnClick = btNewEstItemClick
    end
    object miQuickEntry: TMenuItem
      Caption = 'Quick entry'
      OnClick = miQuickEntryClick
    end
  end
  object gridPrinter: TdxComponentPrinter
    CurrentLink = gridPrinterLink
    PreviewOptions.WindowState = wsMaximized
    Version = 0
    Left = 259
    Top = 239
    object gridPrinterLink: TdxGridReportLink
      Caption = 'New Report'
      DesignerHelpContext = 0
      PrinterPage.Footer = 250
      PrinterPage.Header = 106
      PrinterPage.Margins.Bottom = 500
      PrinterPage.Margins.Left = 500
      PrinterPage.Margins.Right = 500
      PrinterPage.Margins.Top = 500
      PrinterPage.MinMargins.Bottom = 0
      PrinterPage.MinMargins.Left = 0
      PrinterPage.MinMargins.Right = 0
      PrinterPage.MinMargins.Top = 0
      PrinterPage.PageFooter.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageFooter.Font.Color = clWindowText
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Tahoma'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageHeader.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageHeader.Font.Color = clWindowText
      PrinterPage.PageHeader.Font.Height = -11
      PrinterPage.PageHeader.Font.Name = 'Tahoma'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageSize.X = 8500
      PrinterPage.PageSize.Y = 11000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clWindowText
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Times New Roman'
      ReportTitle.Font.Style = [fsBold]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      OptionsCards.Shadow.Color = clBlack
      BuiltInReportLink = True
    end
  end
  object quCostumerFile: TPowerADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'Select'#13#10#9'P.IDPessoa,'#13#10#9'P.IDTipoPessoa'#13#10'From'#13#10#9'Pessoa P (NOLOCK) ' +
      #13#10'Where'#13#10#9'P.IDPessoa = :IDPessoa'
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 448
    Top = 160
    object quCostumerFileIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Origin = 'RETAIL.Pessoa.IDPessoa'
    end
    object quCostumerFileIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
  end
end
