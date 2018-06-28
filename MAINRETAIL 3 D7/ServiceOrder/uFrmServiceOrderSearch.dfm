inherited FrmServiceOrderSearch: TFrmServiceOrderSearch
  Left = 12
  Top = 69
  Width = 852
  Height = 636
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'FrmServiceOrderSearch'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 844
    inherited Image1: TImage
      Width = 617
    end
    inherited lblMenu: TLabel
      Left = 628
    end
    inherited EspacamentoSuperior: TPanel
      Width = 844
      inherited EEE: TPanel
        Width = 844
      end
    end
  end
  inherited Panel1: TPanel
    Top = 568
    Width = 844
    inherited EspacamentoInferior: TPanel
      Width = 844
      inherited Panel3: TPanel
        Width = 844
      end
    end
    inherited hhh: TPanel
      Left = 687
      Width = 157
      inherited btClose: TButton
        Left = 83
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 10
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 148
    Height = 420
  end
  inherited EspacamentoDireito: TPanel
    Left = 841
    Top = 148
    Height = 420
  end
  object pnlBasicFilter: TPanel [4]
    Left = 0
    Top = 40
    Width = 844
    Height = 108
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
    object Label4: TLabel
      Left = 437
      Top = 8
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Status :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 59
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
      Left = 61
      Top = 33
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
      Left = 217
      Top = 33
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
      Left = 424
      Top = 34
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Products :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 39
      Top = 58
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Customer :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 454
      Top = 59
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'S/N :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCustDoc: TLabel
      Left = 41
      Top = 84
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cust. Doc :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbSONumber: TLabel
      Left = 443
      Top = 83
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'SO N'#186' :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pblGO: TPanel
      Left = 775
      Top = 0
      Width = 69
      Height = 108
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 13
      object pnlAviso: TPanel
        Left = 1
        Top = 24
        Width = 65
        Height = 35
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        object btnExec: TSpeedButton
          Left = 5
          Top = 5
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
    object csStatus: TSuperComboADO
      Left = 482
      Top = 4
      Width = 216
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      LookUpSource = DMServiceOrder.dsLookUpSOStatus
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btStatusC: TButton
      Left = 702
      Top = 5
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 8
      OnClick = btStatusCClick
    end
    object cmbStore: TSuperComboADO
      Left = 103
      Top = 5
      Width = 214
      Height = 21
      TabOrder = 0
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btStoreC: TButton
      Left = 322
      Top = 6
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 1
      OnClick = btStoreCClick
    end
    object DateInicio: TDateBox
      Left = 103
      Top = 29
      Width = 87
      Height = 21
      TabOrder = 2
      InputTime = False
    end
    object DateFim: TDateBox
      Left = 236
      Top = 29
      Width = 82
      Height = 21
      TabOrder = 3
      InputTime = False
      Language = Portuguese
    end
    object scProduct: TSuperComboADO
      Left = 482
      Top = 30
      Width = 216
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      LookUpSource = DMServiceOrder.dsSOCutomerProduct
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btProducts: TButton
      Left = 702
      Top = 31
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 10
      OnClick = btProductsClick
    end
    object csCustomer: TSuperComboADO
      Left = 102
      Top = 54
      Width = 216
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      LookUpSource = DM.dsLookUpCustomer
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object edtSerialNum: TEdit
      Left = 482
      Top = 55
      Width = 215
      Height = 21
      TabOrder = 11
    end
    object btCustomerC: TButton
      Left = 322
      Top = 55
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 5
      OnClick = btCustomerCClick
    end
    object edtCustDoc: TEdit
      Left = 101
      Top = 80
      Width = 215
      Height = 21
      TabOrder = 6
    end
    object edtSONumber: TEdit
      Left = 482
      Top = 79
      Width = 215
      Height = 21
      TabOrder = 12
    end
  end
  object grdServiceOrder: TcxGrid [5]
    Left = 3
    Top = 148
    Width = 838
    Height = 420
    Align = alClient
    BevelOuter = bvNone
    BevelKind = bkTile
    TabOrder = 5
    LookAndFeel.Kind = lfFlat
    object grdServiceOrderDB: TcxGridDBTableView
      OnDblClick = grdServiceOrderDBDblClick
      DataController.DataSource = dsSearchSO
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDServiceOrder'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'SalePrice'
        end>
      DataController.Summary.SummaryGroups = <>
      OnCustomDrawCell = grdServiceOrderDBCustomDrawCell
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
      Preview.MaxLineCount = 2
      Preview.Visible = True
      object grdServiceOrderDBSONumber: TcxGridDBColumn
        DataBinding.FieldName = 'SONumber'
        Width = 61
      end
      object grdServiceOrderDBPessoa: TcxGridDBColumn
        DataBinding.FieldName = 'Pessoa'
        Width = 110
      end
      object grdServiceOrderDBSODate: TcxGridDBColumn
        DataBinding.FieldName = 'SODate'
        Width = 65
      end
      object grdServiceOrderDBSOCloseDate: TcxGridDBColumn
        DataBinding.FieldName = 'SOCloseDate'
        Width = 72
      end
      object grdServiceOrderDBCPhone: TcxGridDBColumn
        DataBinding.FieldName = 'CPhone'
        Width = 55
      end
      object grdServiceOrderDBCCell: TcxGridDBColumn
        DataBinding.FieldName = 'CCell'
        Width = 53
      end
      object grdServiceOrderDBEmail: TcxGridDBColumn
        DataBinding.FieldName = 'Email'
        Width = 75
      end
      object grdServiceOrderDBSOStatus: TcxGridDBColumn
        DataBinding.FieldName = 'SOStatus'
        Width = 66
      end
      object grdServiceOrderDBSerialNumber: TcxGridDBColumn
        Caption = 'S/N'
        DataBinding.FieldName = 'SerialNumber'
        Width = 105
      end
      object grdServiceOrderDBStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
        Width = 84
      end
      object grdServiceOrderDBSalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'SalePrice'
        Width = 88
      end
      object grdServiceOrderDBColor: TcxGridDBColumn
        DataBinding.FieldName = 'Color'
        Visible = False
      end
    end
    object grdServiceOrderView: TcxGridLevel
      GridView = grdServiceOrderDB
    end
  end
  object quSearchSO: TADODataSet [6]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'SO.IDServiceOrder,'#13#10#9'SO.SONumber,'#13#10#9'SO.SODate,'#13#10#9'SO.SOC' +
      'loseDate,'#13#10#9'P.Pessoa,'#13#10#9'P.PhoneAreaCode,'#13#10#9'P.Telefone,'#13#10#9'P.CellA' +
      'reaCode,'#13#10#9'P.Cellular,'#13#10#9'P.Email,'#13#10#9'SOS.SOStatus,'#13#10#9'IsNull(SOS.C' +
      'olor, '#39#39') as Color,'#13#10#9'S.Name as Store,'#13#10#9'SUM((SOIP.Qty * SOIP.Sa' +
      'lePrice) - IsNull(Discount, 0)) as SalePrice,'#13#10#9'SOI.SerialNumber' +
      #13#10'FROM'#13#10#9'Ser_ServiceOrder SO (NOLOCK)'#13#10#9'JOIN Pessoa P (NOLOCK) O' +
      'N (P.IDPessoa = SO.IDCustomer)'#13#10#9'LEFT JOIN Ser_SOStatus SOS (NOL' +
      'OCK) ON (SOS.IDSOStatus = SO.IDSOStatus)'#13#10#9'JOIN Store S (NOLOCK)' +
      ' ON (S.IDStore = SO.IDStore)'#13#10#9'LEFT JOIN Ser_SOItem SOI (NOLOCK)' +
      ' ON (SOI.IDServiceOrder = SO.IDServiceOrder)'#13#10#9'LEFT JOIN Ser_SOI' +
      'temProduct SOIP (NOLOCK) ON (SOIP.IDSOItem = SOI.IDSOItem)'#13#10'GROU' +
      'P BY'#13#10#9'SO.IDServiceOrder,'#13#10#9'SO.SONumber,'#13#10#9'SO.SODate,'#13#10#9'SO.SOClo' +
      'seDate,'#13#10#9'P.Pessoa,'#13#10#9'P.PhoneAreaCode,'#13#10#9'P.Telefone,'#13#10#9'P.CellAre' +
      'aCode,'#13#10#9'P.Cellular,'#13#10#9'P.Email,'#13#10#9'SOS.SOStatus,'#13#10#9'SOS.Color,'#13#10#9'S' +
      '.Name,'#13#10#9'SOI.SerialNumber'#13#10'HAVING '#13#10#9'Count(SOI.IDServiceOrder) >' +
      ' 0'
    Parameters = <>
    Left = 280
    Top = 244
  end
  object dsSearchSO: TDataSource [7]
    DataSet = cdsSearchSO
    Left = 280
    Top = 416
  end
  object dspSearchSO: TDataSetProvider [8]
    DataSet = quSearchSO
    Left = 280
    Top = 300
  end
  object cdsSearchSO: TClientDataSet [9]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSearchSO'
    OnCalcFields = cdsSearchSOCalcFields
    Left = 280
    Top = 360
    object cdsSearchSOIDServiceOrder: TIntegerField
      FieldName = 'IDServiceOrder'
    end
    object cdsSearchSOSONumber: TStringField
      DisplayLabel = 'SO Number'
      FieldName = 'SONumber'
    end
    object cdsSearchSOSODate: TDateTimeField
      DisplayLabel = 'Ini Date'
      FieldName = 'SODate'
      DisplayFormat = 'ddddd hh:nn'
    end
    object cdsSearchSOSOCloseDate: TDateTimeField
      DisplayLabel = 'End Date'
      FieldName = 'SOCloseDate'
      DisplayFormat = 'ddddd hh:nn'
    end
    object cdsSearchSOPessoa: TStringField
      DisplayLabel = 'Customer'
      FieldName = 'Pessoa'
      Size = 50
    end
    object cdsSearchSOPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object cdsSearchSOTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object cdsSearchSOCellAreaCode: TStringField
      FieldName = 'CellAreaCode'
      Size = 5
    end
    object cdsSearchSOCellular: TStringField
      FieldName = 'Cellular'
      FixedChar = True
      Size = 18
    end
    object cdsSearchSOEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object cdsSearchSOSOStatus: TStringField
      DisplayLabel = 'Status'
      FieldName = 'SOStatus'
      Size = 50
    end
    object cdsSearchSOColor: TStringField
      FieldName = 'Color'
    end
    object cdsSearchSOStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsSearchSOSalePrice: TBCDField
      DisplayLabel = 'Total'
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
    object cdsSearchSOCPhone: TStringField
      DisplayLabel = 'Phone'
      FieldKind = fkCalculated
      FieldName = 'CPhone'
      Size = 30
      Calculated = True
    end
    object cdsSearchSOCCell: TStringField
      DisplayLabel = 'Cell'
      FieldKind = fkCalculated
      FieldName = 'CCell'
      Size = 30
      Calculated = True
    end
    object cdsSearchSOSerialNumber: TStringField
      FieldName = 'SerialNumber'
      Size = 50
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmServiceOrderSearch.sil'
  end
end
