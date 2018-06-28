inherited FrmTrackPackage: TFrmTrackPackage
  Left = 16
  Top = 124
  Width = 756
  Height = 526
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Track Package'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 461
    Width = 748
    Height = 38
    inherited EspacamentoInferior: TPanel
      Width = 748
      Height = 2
      inherited Panel3: TPanel
        Top = 0
        Width = 748
      end
    end
    inherited hhh: TPanel
      Left = 597
      Top = 2
      Height = 36
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 65
    Height = 396
  end
  inherited EspacamentoDireito: TPanel
    Left = 745
    Top = 65
    Height = 396
  end
  inherited EspacamentoSuperior: TPanel
    Top = 65
    Width = 748
    Height = 0
    Visible = False
  end
  object pnlSearchSH: TPanel [4]
    Left = 0
    Top = 0
    Width = 748
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    TabOrder = 4
    DesignSize = (
      748
      65)
    object Label1: TLabel
      Left = 59
      Top = 37
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'Invoice #'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbSelection: TLabel
      Left = 73
      Top = 12
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Select :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTrack: TLabel
      Left = 422
      Top = 38
      Width = 44
      Height = 13
      Alignment = taRightJustify
      Caption = 'Track #'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 383
      Top = 11
      Width = 84
      Height = 13
      Alignment = taRightJustify
      Caption = 'Delivery Type :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtInvoiceNum: TEdit
      Left = 118
      Top = 33
      Width = 110
      Height = 21
      TabOrder = 2
    end
    object btnSearchSH: TButton
      Left = 666
      Top = 20
      Width = 74
      Height = 36
      Anchors = [akTop, akRight]
      Caption = '&Search'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      TabStop = False
      OnClick = btnSearchSHClick
    end
    object cbSearchFor: TComboBox
      Left = 118
      Top = 8
      Width = 109
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
      TabOrder = 0
      Text = 'Company Name'
      Items.Strings = (
        'Company Name'
        'First Name'
        'Last Name'
        'Customer Account'
        'Phone'
        'Zip')
    end
    object edtParamText: TEdit
      Left = 230
      Top = 8
      Width = 141
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtTracNum: TEdit
      Left = 471
      Top = 33
      Width = 136
      Height = 21
      TabOrder = 3
    end
    object scDeliverType: TSuperComboADO
      Left = 472
      Top = 8
      Width = 136
      Height = 21
      TabOrder = 5
      Text = '<-->'
      LookUpSource = DM.dsLookUpDeliverType
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnDeliverClear: TButton
      Left = 614
      Top = 10
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 6
      TabStop = False
      OnClick = btnDeliverClearClick
    end
  end
  object gdTrackPackge: TcxGrid [5]
    Left = 3
    Top = 65
    Width = 742
    Height = 396
    Align = alClient
    TabOrder = 5
    LookAndFeel.Kind = lfFlat
    object gdTrackPackgeDBTableView: TcxGridDBTableView
      DataController.DataSource = dsSHInvoice
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPreSale'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OnCellClick = gdTrackPackgeDBTableViewCellClick
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object gdTrackPackgeDBTableViewInvoiceDate: TcxGridDBColumn
        Caption = 'Date'
        DataBinding.FieldName = 'InvoiceDate'
        Width = 70
      end
      object gdTrackPackgeDBTableViewInvoiceCode: TcxGridDBColumn
        Caption = 'Invoice #'
        DataBinding.FieldName = 'InvoiceCode'
        Width = 62
      end
      object gdTrackPackgeDBTableViewPessoa: TcxGridDBColumn
        Caption = 'Customer'
        DataBinding.FieldName = 'Pessoa'
        Width = 100
      end
      object gdTrackPackgeDBTableViewTotInvoice: TcxGridDBColumn
        Caption = 'Total'
        DataBinding.FieldName = 'TotInvoice'
        Width = 62
      end
      object gdTrackPackgeDBTableViewShipVia: TcxGridDBColumn
        DataBinding.FieldName = 'ShipVia'
        Width = 58
      end
      object gdTrackPackgeDBTableViewShipDate: TcxGridDBColumn
        DataBinding.FieldName = 'ShipDate'
        Width = 85
      end
      object gdTrackPackgeDBTableViewTracking: TcxGridDBColumn
        DataBinding.FieldName = 'Tracking'
        Width = 83
      end
      object gdTrackPackgeDBTableViewAddressName: TcxGridDBColumn
        DataBinding.FieldName = 'AddressName'
        Visible = False
      end
      object gdTrackPackgeDBTableViewAddress: TcxGridDBColumn
        DataBinding.FieldName = 'Address'
        Visible = False
      end
      object gdTrackPackgeDBTableViewCity: TcxGridDBColumn
        DataBinding.FieldName = 'City'
        Visible = False
      end
      object gdTrackPackgeDBTableViewZIP: TcxGridDBColumn
        DataBinding.FieldName = 'ZIP'
        Visible = False
      end
      object gdTrackPackgeDBTableViewIDEstado: TcxGridDBColumn
        DataBinding.FieldName = 'IDEstado'
        Visible = False
      end
      object gdTrackPackgeDBTableViewIDPais: TcxGridDBColumn
        DataBinding.FieldName = 'IDPais'
        Visible = False
      end
      object gdTrackPackgeDBTableViewWebsite: TcxGridDBColumn
        DataBinding.FieldName = 'Website'
        Options.Editing = False
        Styles.Content = cxWebLink
        Width = 220
      end
    end
    object gdTrackPackgeLevel: TcxGridLevel
      GridView = gdTrackPackgeDBTableView
    end
  end
  object quSHInvoice: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'I.IDPreSale,'#13#10#9'I.PreSaleDate,'#13#10#9'I.SaleCode,'#13#10#9'I.Invoice' +
      'Code,'#13#10#9'I.InvoiceDate,'#13#10#9'I.Note,'#13#10#9'P.PessoaFirstName,'#13#10#9'P.Pessoa' +
      'LastName,'#13#10#9'P.Pessoa,'#13#10#9'P.IDPessoa,'#13#10#9'(I.SubTotal - I.InvoiceDis' +
      'count - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0))' +
      ' as TotInvoice,'#13#10#9'S.ShipDate,'#13#10#9'S.Tracking,'#13#10#9'S.IDDeliverType,'#13#10 +
      #9'S.AddressName,'#13#10#9'S.Address,'#13#10#9'S.City,'#13#10#9'S.ZIP,'#13#10#9'S.IDEstado,'#13#10#9 +
      'S.IDPais,'#13#10#9'D.Name as ShipVia,'#13#10#9'D.Website'#13#10'FROM'#13#10#9'Invoice I (NO' +
      'LOCK)'#13#10#9'INNER JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPesso' +
      'a'#13#10#9'JOIN Sal_InvoiceShipping S (NOLOCK) ON (S.IDPreSale = I.IDPr' +
      'eSale)'#13#10#9'LEFT JOIN DeliverType D (NOLOCK) ON (D.IDDeliverType = ' +
      'S.IDDeliverType)'#13#10'WHERE'#13#10#9'P.IDTipoPessoa = 1'#13#10#9'AND I.IDInvoice I' +
      'S NOT NULL'#13#10#9'AND I.Canceled = 0'#13#10
    Parameters = <>
    Left = 259
    Top = 170
    object quSHInvoiceIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quSHInvoicePreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
    end
    object quSHInvoiceSaleCode: TStringField
      DisplayLabel = 'Hold #'
      FieldName = 'SaleCode'
    end
    object quSHInvoiceInvoiceDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'InvoiceDate'
      DisplayFormat = 'ddddd'
    end
    object quSHInvoiceInvoiceCode: TStringField
      DisplayLabel = 'Invoice #'
      FieldName = 'InvoiceCode'
    end
    object quSHInvoiceNote: TStringField
      FieldName = 'Note'
      Size = 150
    end
    object quSHInvoicePessoaFirstName: TStringField
      DisplayLabel = 'FirstName'
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quSHInvoicePessoaLastName: TStringField
      DisplayLabel = 'LastName'
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quSHInvoicePessoa: TStringField
      DisplayLabel = 'Customer'
      FieldName = 'Pessoa'
      Size = 50
    end
    object quSHInvoiceIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quSHInvoiceTotInvoice: TBCDField
      DisplayLabel = 'Total'
      FieldName = 'TotInvoice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSHInvoiceTracking: TStringField
      DisplayLabel = 'Tracking #'
      FieldName = 'Tracking'
      Size = 255
    end
    object quSHInvoiceShipDate: TDateTimeField
      FieldName = 'ShipDate'
      DisplayFormat = 'ddddd'
    end
    object quSHInvoiceIDDeliverType: TIntegerField
      FieldName = 'IDDeliverType'
    end
    object quSHInvoiceAddressName: TStringField
      FieldName = 'AddressName'
      Size = 30
    end
    object quSHInvoiceAddress: TStringField
      FieldName = 'Address'
      Size = 50
    end
    object quSHInvoiceCity: TStringField
      FieldName = 'City'
    end
    object quSHInvoiceZIP: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object quSHInvoiceIDEstado: TStringField
      DisplayLabel = 'State'
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quSHInvoiceIDPais: TIntegerField
      FieldName = 'IDPais'
    end
    object quSHInvoiceShipVia: TStringField
      FieldName = 'ShipVia'
      Size = 30
    end
    object quSHInvoiceWebsite: TStringField
      FieldName = 'Website'
      Size = 100
    end
  end
  object dsSHInvoice: TDataSource
    DataSet = quSHInvoice
    Left = 259
    Top = 226
  end
  object strepPredefined: TcxStyleRepository
    Left = 260
    Top = 283
    object cxWebLink: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      TextColor = clBlue
    end
    object GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
      Styles.Header = cxWebLink
    end
  end
end
