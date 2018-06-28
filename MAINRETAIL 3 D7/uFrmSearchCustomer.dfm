inherited FrmSearchCustomer: TFrmSearchCustomer
  Left = 551
  Top = 119
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Search Customer'
  ClientHeight = 479
  ClientWidth = 684
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 684
    inherited Image1: TImage
      Width = 457
    end
    inherited lblMenu: TLabel
      Left = 468
    end
    inherited EspacamentoSuperior: TPanel
      Width = 684
      inherited EEE: TPanel
        Width = 684
      end
    end
  end
  inherited Panel1: TPanel
    Top = 438
    Width = 684
    inherited EspacamentoInferior: TPanel
      Width = 684
      inherited Panel3: TPanel
        Width = 684
      end
    end
    inherited hhh: TPanel
      Left = 509
      Width = 175
      inherited btClose: TButton
        Left = 102
        Cancel = True
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 32
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 398
  end
  inherited EspacamentoDireito: TPanel
    Left = 681
    Height = 398
  end
  object Panel4: TPanel [4]
    Left = 3
    Top = 40
    Width = 678
    Height = 398
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Label5: TLabel
      Left = 5
      Top = 3
      Width = 50
      Height = 13
      Caption = 'Search for'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbParamSearch: TLabel
      Left = 138
      Top = 4
      Width = 27
      Height = 13
      Caption = 'Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btColumn: TSpeedButton
      Tag = 4
      Left = 560
      Top = 111
      Width = 111
      Height = 25
      AllowAllUp = True
      GroupIndex = 1235
      Caption = 'Colum&ns'
      Flat = True
      Margin = 2
      Spacing = 3
      OnClick = btColumnClick
    end
    object sbDetailCustumer: TSpeedButton
      Left = 560
      Top = 75
      Width = 111
      Height = 25
      Caption = '&Details'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Margin = 2
      ParentFont = False
      Spacing = 3
      OnClick = sbDetailCustumerClick
    end
    object sbNewCostumer: TSpeedButton
      Left = 560
      Top = 46
      Width = 111
      Height = 25
      Caption = '&New'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Margin = 2
      ParentFont = False
      Spacing = 5
      OnClick = sbNewCostumerClick
    end
    object edtParamText: TEdit
      Left = 136
      Top = 19
      Width = 413
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyUp = edtParamTextKeyUp
    end
    object cbSearchFor: TComboBox
      Left = 5
      Top = 19
      Width = 119
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
      OnChange = cbSearchForChange
      Items.Strings = (
        'Smart Search'
        'First Name'
        'Last Name'
        'Full Name'
        'Phone'
        'Email'
        'Customer Card'
        'Driver License')
    end
    object grdCustomer: TcxGrid
      Left = 5
      Top = 45
      Width = 546
      Height = 346
      TabOrder = 2
      LookAndFeel.Kind = lfFlat
      object grdCustomerDB: TcxGridDBTableView
        OnDblClick = grdCustomerDBDblClick
        DataController.DataSource = dsCostumer
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPessoa'
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
        OnFocusedItemChanged = grdCustomerDBFocusedItemChanged
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
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
        OnColumnHeaderClick = grdCustomerDBColumnHeaderClick
        OnCustomization = grdCustomerDBCustomization
        object grdCustomerDBPessoa: TcxGridDBColumn
          Caption = 'Customer'
          DataBinding.FieldName = 'Pessoa'
          Width = 127
        end
        object grdCustomerDBPhone: TcxGridDBColumn
          DataBinding.FieldName = 'Phone'
          Width = 97
        end
        object grdCustomerDBEmail: TcxGridDBColumn
          DataBinding.FieldName = 'Email'
          Width = 159
        end
        object grdCustomerDBPessoaLastName: TcxGridDBColumn
          Caption = 'Last Name'
          DataBinding.FieldName = 'PessoaLastName'
          Visible = False
        end
        object grdCustomerDBPessoaFirstName: TcxGridDBColumn
          Caption = 'First Name'
          DataBinding.FieldName = 'PessoaFirstName'
          Visible = False
        end
        object grdCustomerDBCEP: TcxGridDBColumn
          DataBinding.FieldName = 'CEP'
          Width = 60
        end
        object grdCustomerDBCustomerCard: TcxGridDBColumn
          Caption = 'Customer Card'
          DataBinding.FieldName = 'CustomerCard'
          SortOrder = soDescending
          Width = 120
        end
      end
      object grdCustomerLevel: TcxGridLevel
        GridView = grdCustomerDB
      end
    end
    object pnlDivisoria2: TPanel
      Left = 560
      Top = 105
      Width = 111
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 3
    end
  end
  object quCostumer: TPowerADOQuery [5]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'Select TOP 100'#13#10'        P.IDPessoa,'#13#10'        P.OrgaoEmissor Driv' +
      'erLicense,'#13#10'        P.CEP,'#13#10'        P.CartTrabalho SocialSecurit' +
      'y,'#13#10'        P.CustomerCard,'#13#10'        P.PessoaFirstName,'#13#10'       ' +
      ' P.Pessoa,'#13#10'        (PhoneAreaCode + '#39'-'#39' + P.Telefone) as Phone,' +
      #13#10'        P.Email,'#13#10'        P.PessoaLastName'#13#10'From'#13#10'        Pess' +
      'oa P (NOLOCK) '#13#10#9'JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa ' +
      '= TP.IDTipoPessoa)'#13#10'Where'#13#10'        TP.Path LIKE '#39'.001%'#39#13#10'       ' +
      ' AND'#13#10'        P.System = 0'#13#10'        AND'#13#10'        P.Desativado = ' +
      '0'#13#10
    Parameters = <>
    Left = 154
    Top = 551
    object quCostumerIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quCostumerDriverLicense: TStringField
      FieldName = 'DriverLicense'
      Origin = 'RETAIL.Pessoa.OrgaoEmissor'
      Size = 50
    end
    object quCostumerSocialSecurity: TStringField
      FieldName = 'SocialSecurity'
      Origin = 'RETAIL.Pessoa.CartTrabalho'
      Size = 30
    end
    object quCostumerCustomerCard: TStringField
      FieldName = 'CustomerCard'
      Origin = 'RETAIL.Pessoa.CustomerCard'
    end
    object quCostumerPessoaLastName: TStringField
      DisplayLabel = 'LastName'
      FieldName = 'PessoaLastName'
      Origin = 'RETAIL.Pessoa.PessoaLastName'
      Size = 30
    end
    object quCostumerCEP: TStringField
      DisplayLabel = 'ZIP'
      FieldName = 'CEP'
      Origin = 'RETAIL.Pessoa.CEP'
      FixedChar = True
      Size = 12
    end
    object quCostumerPessoaFirstName: TStringField
      DisplayLabel = 'FirstName'
      FieldName = 'PessoaFirstName'
      Origin = 'RETAIL.Pessoa.PessoaFirstName'
      Size = 30
    end
    object quCostumerPessoa: TStringField
      DisplayLabel = 'Full Name'
      FieldName = 'Pessoa'
      Origin = 'RETAIL.Pessoa.Pessoa'
      Size = 50
    end
    object quCostumerPhone: TStringField
      FieldName = 'Phone'
      Size = 40
    end
    object quCostumerEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
  end
  object dsCostumer: TDataSource [6]
    DataSet = quCostumer
    Left = 208
    Top = 552
  end
  object trSearchCustomer: TTimer [7]
    Enabled = False
    OnTimer = trSearchCustomerTimer
    Left = 274
    Top = 553
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSearchCustomer.sil'
    Left = 364
    Top = 551
  end
end
