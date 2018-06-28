object FrmSearchHold: TFrmSearchHold
  Left = 380
  Top = 178
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Procurar Pedido'
  ClientHeight = 375
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grdHolds: TcxGrid
    Left = 0
    Top = 73
    Width = 417
    Height = 271
    Align = alClient
    BevelOuter = bvNone
    BevelKind = bkTile
    TabOrder = 1
    LookAndFeel.Kind = lfFlat
    object grdHoldsDB: TcxGridDBTableView
      OnDblClick = grdHoldsDBDblClick
      DataController.DataSource = dsSearchHold
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
      object grdHoldsDBIDPreSale: TcxGridDBColumn
        DataBinding.FieldName = 'IDPreSale'
        Visible = False
      end
      object grdHoldsDBSaleCode: TcxGridDBColumn
        Caption = 'N'#186' Pedido'
        DataBinding.FieldName = 'SaleCode'
        Width = 72
      end
      object grdHoldsDBPreSaleDate: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'PreSaleDate'
        Width = 75
      end
      object grdHoldsDBPessoa: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'Pessoa'
        Width = 302
      end
    end
    object grdHoldsLevel: TcxGridLevel
      GridView = grdHoldsDB
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 344
    Width = 417
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnOk: TcxButton
      Left = 256
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Ok'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 336
      Top = 4
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblDataIni: TLabel
      Left = 48
      Top = 40
      Width = 14
      Height = 13
      Caption = 'De'
    end
    object lblDataFim: TLabel
      Left = 156
      Top = 40
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object lblNumPedido: TLabel
      Left = 12
      Top = 12
      Width = 47
      Height = 13
      Caption = 'N'#186' pedido'
    end
    object edtDataIni: TcxDateEdit
      Left = 68
      Top = 36
      Width = 85
      Height = 21
      TabOrder = 1
    end
    object edtDataFim: TcxDateEdit
      Left = 176
      Top = 36
      Width = 85
      Height = 21
      TabOrder = 2
    end
    object btnProcurar: TcxButton
      Left = 344
      Top = 12
      Width = 55
      Height = 45
      Caption = 'Procurar'
      TabOrder = 3
      OnClick = btnProcurarClick
    end
    object edtNumPedido: TcxTextEdit
      Left = 68
      Top = 8
      Width = 85
      Height = 21
      TabOrder = 0
    end
  end
  object dsSearchHold: TDataSource
    DataSet = cdsSearchHold
    Left = 72
    Top = 280
  end
  object qrySearchHold: TADOQuery
    Connection = FrmMain.Connection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale,'
      #9'I.SaleCode,'
      #9'I.PreSaleDate,'
      #9'P.Pessoa'
      'FROM'
      #9'Invoice I'
      #9'JOIN Pessoa P ON (I.IDCustomer = P.IDPessoa)')
    Left = 72
    Top = 112
    object qrySearchHoldIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object qrySearchHoldSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object qrySearchHoldPreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
    end
    object qrySearchHoldPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object qryHasService: TADOQuery
    Connection = FrmMain.Connection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'COUNT(*) TotalService'
      'FROM'
      #9'PreInventoryMov PIM'
      #9'JOIN Model M ON (PIM.ModelID = M.IDModel)'
      #9'JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)'
      'WHERE'
      #9'PIM.InventMovTypeID = 1'
      #9'AND TG.Service = 1'
      #9'AND PIM.DocumentID = :IDPreSale')
    Left = 160
    Top = 112
    object qryHasServiceTotalService: TIntegerField
      FieldName = 'TotalService'
      ReadOnly = True
    end
  end
  object dspSearchHold: TDataSetProvider
    DataSet = qrySearchHold
    Left = 72
    Top = 168
  end
  object cdsSearchHold: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSearchHold'
    AfterOpen = cdsSearchHoldAfterOpen
    Left = 72
    Top = 224
    object cdsSearchHoldIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object cdsSearchHoldSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object cdsSearchHoldPreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
    end
    object cdsSearchHoldPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object qryHasChange: TADOQuery
    Connection = FrmMain.Connection
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'COUNT(*) TotalChange'
      'FROM'
      #9'PreInventoryMov PIM'
      'WHERE'
      #9'PIM.InventMovTypeID = 1'
      #9'AND PIM.Qty < 0'
      #9'AND PIM.DocumentID = :IDPreSale')
    Left = 244
    Top = 112
    object qryHasChangeTotalChange: TIntegerField
      FieldName = 'TotalChange'
      ReadOnly = True
    end
  end
end
