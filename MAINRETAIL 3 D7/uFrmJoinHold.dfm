inherited FrmJoinHold: TFrmJoinHold
  Left = 707
  Top = 31
  Width = 582
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Join Hold'
  KeyPreview = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 566
    inherited EspacamentoInferior: TPanel
      Width = 566
      inherited Panel3: TPanel
        Width = 566
      end
    end
    inherited hhh: TPanel
      Left = 348
      Width = 218
      inherited btClose: TButton
        Left = 147
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 77
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Select'
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 563
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 566
    Visible = False
  end
  object pgSearch: TPageControl [4]
    Left = 3
    Top = 6
    Width = 560
    Height = 367
    ActivePage = tsHold
    Align = alClient
    TabOrder = 4
    object tsHold: TTabSheet
      Caption = 'Hold'
      ImageIndex = 1
      object pnlInvoiceType: TPanel
        Left = 0
        Top = 0
        Width = 552
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbSearchOption: TLabel
          Left = 100
          Top = 12
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Search :'
        end
        object cbxOption: TComboBox
          Left = 144
          Top = 8
          Width = 77
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Invoice'
          Items.Strings = (
            'Invoice'
            'Layaway')
        end
      end
      object pnlFilter: TPanel
        Left = 0
        Top = 41
        Width = 552
        Height = 36
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label4: TLabel
          Left = 107
          Top = 11
          Width = 32
          Height = 13
          Alignment = taRightJustify
          Caption = 'Hold #'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbTo: TLabel
          Left = 229
          Top = 10
          Width = 9
          Height = 13
          Alignment = taRightJustify
          Caption = 'to'
        end
        object edtHold: TEdit
          Left = 144
          Top = 6
          Width = 72
          Height = 21
          TabOrder = 0
          OnEnter = edtHoldEnter
          OnKeyPress = edtHoldKeyPress
        end
        object btnExec: TButton
          Left = 395
          Top = 5
          Width = 131
          Height = 23
          Caption = '&Search Hold'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          TabStop = False
          OnClick = btnExecClick
        end
        object edtLastHold: TEdit
          Left = 244
          Top = 6
          Width = 72
          Height = 21
          TabOrder = 1
          OnEnter = edtHoldEnter
          OnKeyPress = edtHoldKeyPress
        end
      end
      object grdInvoice: TcxGrid
        Left = 0
        Top = 77
        Width = 552
        Height = 262
        Align = alClient
        TabOrder = 2
        LookAndFeel.Kind = lfFlat
        object grdInvoiceDB: TcxGridDBTableView
          DataController.DataSource = dsPreSale
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPreSale'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
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
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdInvoiceDBSaleCode: TcxGridDBColumn
            DataBinding.FieldName = 'SaleCode'
            Width = 71
          end
          object grdInvoiceDBPessoaFirstName: TcxGridDBColumn
            Caption = 'First Name'
            DataBinding.FieldName = 'PessoaFirstName'
            Width = 112
          end
          object grdInvoiceDBPessoaLastName: TcxGridDBColumn
            Caption = 'Last Name'
            DataBinding.FieldName = 'PessoaLastName'
            Width = 163
          end
          object grdInvoiceDBPessoa: TcxGridDBColumn
            Caption = 'Full Name'
            DataBinding.FieldName = 'Pessoa'
            Visible = False
          end
          object grdInvoiceDBPreSaleDate: TcxGridDBColumn
            DataBinding.FieldName = 'PreSaleDate'
            SortOrder = soDescending
            Width = 136
          end
          object grdInvoiceDBTotInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'TotInvoice'
            Width = 76
          end
          object grdInvoiceDBDBColumn1: TcxGridDBColumn
            Caption = 'Juridic Person'
            DataBinding.FieldName = 'juridico'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayUnchecked = 'False'
            Properties.DisplayGrayed = 'False'
            Properties.NullStyle = nssUnchecked
            Properties.ValueChecked = 1
            Properties.ValueGrayed = 0
          end
        end
        object grdInvoiceLevel: TcxGridLevel
          GridView = grdInvoiceDB
        end
      end
    end
    object tsInvoiceShipping: TTabSheet
      Caption = 'Invoice'
      object pnlSearchSH: TPanel
        Left = 0
        Top = 0
        Width = 552
        Height = 101
        Align = alTop
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        object Label1: TLabel
          Left = 13
          Top = 35
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
          Left = 27
          Top = 9
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
          Left = 23
          Top = 61
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
        object edtInvoiceNum: TEdit
          Left = 72
          Top = 30
          Width = 73
          Height = 21
          TabOrder = 2
          OnEnter = edtHoldEnter
          OnKeyPress = edtHoldKeyPress
        end
        object btnSearchSH: TButton
          Left = 478
          Top = 30
          Width = 74
          Height = 36
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
          Left = 72
          Top = 5
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
          Left = 184
          Top = 5
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
          Left = 72
          Top = 56
          Width = 73
          Height = 21
          TabOrder = 3
          OnEnter = edtHoldEnter
          OnKeyPress = edtHoldKeyPress
        end
      end
      object griInvoice: TcxGrid
        Left = 0
        Top = 101
        Width = 552
        Height = 317
        Align = alTop
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object griInvoiceDBTableView: TcxGridDBTableView
          DataController.DataSource = dsSHInvoice
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPreSale'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
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
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object griInvoiceDBTableViewPreSaleDate: TcxGridDBColumn
            DataBinding.FieldName = 'PreSaleDate'
            Visible = False
          end
          object griInvoiceDBTableViewPessoa: TcxGridDBColumn
            DataBinding.FieldName = 'Pessoa'
            Width = 89
          end
          object griInvoiceDBTableViewInvoiceDate: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceDate'
            Width = 68
          end
          object griInvoiceDBTableViewSaleCode: TcxGridDBColumn
            DataBinding.FieldName = 'SaleCode'
            Width = 62
          end
          object griInvoiceDBTableViewInvoiceCode: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceCode'
            Width = 71
          end
          object griInvoiceDBTableViewNote: TcxGridDBColumn
            DataBinding.FieldName = 'Note'
            Visible = False
          end
          object griInvoiceDBTableViewPessoaFirstName: TcxGridDBColumn
            DataBinding.FieldName = 'PessoaFirstName'
            Visible = False
          end
          object griInvoiceDBTableViewPessoaLastName: TcxGridDBColumn
            DataBinding.FieldName = 'PessoaLastName'
            Visible = False
          end
          object griInvoiceDBTableViewTotInvoice: TcxGridDBColumn
            DataBinding.FieldName = 'TotInvoice'
            Width = 63
          end
          object griInvoiceDBTableViewShipDate: TcxGridDBColumn
            DataBinding.FieldName = 'ShipDate'
            Width = 59
          end
          object griInvoiceDBTableViewShipVia: TcxGridDBColumn
            DataBinding.FieldName = 'ShipVia'
            Width = 80
          end
          object griInvoiceDBTableViewTracking: TcxGridDBColumn
            DataBinding.FieldName = 'Tracking'
            Width = 66
          end
          object griInvoiceDBTableViewAddressName: TcxGridDBColumn
            DataBinding.FieldName = 'AddressName'
            Visible = False
          end
          object griInvoiceDBTableViewAddress: TcxGridDBColumn
            DataBinding.FieldName = 'Address'
            Visible = False
          end
          object griInvoiceDBTableViewCity: TcxGridDBColumn
            DataBinding.FieldName = 'City'
            Visible = False
          end
          object griInvoiceDBTableViewZIP: TcxGridDBColumn
            DataBinding.FieldName = 'ZIP'
            Visible = False
          end
          object griInvoiceDBTableViewIDEstado: TcxGridDBColumn
            DataBinding.FieldName = 'IDEstado'
            Visible = False
          end
        end
        object griInvoiceLevel1: TcxGridLevel
          GridView = griInvoiceDBTableView
        end
      end
    end
  end
  object quPreSale: TADOQuery [5]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SaleCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'IDPreSale'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale,'
      #9'I.PreSaleDate,'
      #9'I.SaleCode,'
      #9'I.Note,'
      #9'P.PessoaFirstName,'
      #9'P.PessoaLastName,'
      #9'P.Pessoa,'
      #9'P.IDPessoa,'
      
        #9'(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNu' +
        'll(I.AditionalExpenses, 0)) as TotInvoice,'
      #9'I.IDTouristGroup,'
      #9'I.OtherComissionID'
      'FROM'
      #9'Invoice I (NOLOCK)'
      #9'INNER JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa'
      'WHERE'
      #9'P.IDTipoPessoa = 1'
      #9'AND I.IDInvoice Is Null'
      #9'AND I.Layaway = 1'
      #9'AND I.Canceled = 0'
      #9'AND I.PreSaleDate <= GetDate()'
      
        #9'AND I.IDPreSale NOT IN (Select IDPreSaleParent From Invoice Whe' +
        're IDPreSaleParent IS NOT NULL)'
      #9'AND I.SaleCode like :SaleCode'
      #9'AND I.IDPreSale <> :IDPreSale')
    Left = 62
    Top = 384
    object quPreSaleIDPreSale: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'IDPreSale'
    end
    object quPreSalePreSaleDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'PreSaleDate'
    end
    object quPreSaleTotInvoice: TFloatField
      DisplayLabel = 'Total'
      FieldName = 'TotInvoice'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quPreSalePessoaFirstName: TStringField
      DisplayLabel = 'First Name'
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quPreSalePessoaLastName: TStringField
      DisplayLabel = 'Last Name'
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quPreSaleIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
      Visible = False
    end
    object quPreSaleOtherComissionID: TIntegerField
      FieldName = 'OtherComissionID'
      Visible = False
    end
    object quPreSalePessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quPreSaleSaleCode: TStringField
      DisplayLabel = 'Hold #'
      FieldName = 'SaleCode'
    end
    object quPreSaleIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quPreSaleNote: TStringField
      FieldName = 'Note'
      Size = 150
    end
  end
  object dsPreSale: TDataSource [6]
    DataSet = quPreSale
    Left = 21
    Top = 385
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmJoinHold.sil'
  end
  object spUpHold: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_UpHold;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSaleOrigem'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPreSaleDestino'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 117
    Top = 384
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
      'S.IDPais,'#13#10#9'D.Name as ShipVia'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10#9'INNER' +
      ' JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa'#13#10#9'JOIN Sal_' +
      'InvoiceShipping S (NOLOCK) ON (S.IDPreSale = I.IDPreSale)'#13#10#9'LEFT' +
      ' JOIN DeliverType D (NOLOCK) ON (D.IDDeliverType = S.IDDeliverTy' +
      'pe)'#13#10'WHERE'#13#10#9'P.IDTipoPessoa = 1'#13#10#9'AND I.IDInvoice IS NOT NULL'#13#10#9 +
      'AND I.Canceled = 0'#13#10
    Parameters = <>
    Left = 187
    Top = 386
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
    object quSHInvoiceInvoiceCode: TStringField
      DisplayLabel = 'Invoice #'
      FieldName = 'InvoiceCode'
    end
    object quSHInvoiceInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
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
    object quSHInvoiceShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object quSHInvoiceTracking: TStringField
      FieldName = 'Tracking'
      Size = 255
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
  end
  object dsSHInvoice: TDataSource
    DataSet = quSHInvoice
    Left = 259
    Top = 386
  end
end
