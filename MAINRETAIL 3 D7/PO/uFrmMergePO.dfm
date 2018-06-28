inherited FrmMergePO: TFrmMergePO
  Left = 166
  Top = 109
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Merge PO'
  ClientHeight = 323
  ClientWidth = 456
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 282
    Width = 456
    inherited EspacamentoInferior: TPanel
      Width = 456
      inherited Panel3: TPanel
        Width = 456
      end
    end
    inherited hhh: TPanel
      Left = 238
      Width = 218
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 146
        OnClick = btCloseClick
      end
      object btnMerge: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Merge'
        TabOrder = 1
        TabStop = False
        OnClick = btnMergeClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 47
    Height = 235
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 453
    Top = 47
    Height = 235
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 456
    Visible = False
  end
  object grdPOSearch: TcxGrid [4]
    Left = 3
    Top = 47
    Width = 450
    Height = 235
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdPOSearchDB: TcxGridDBTableView
      DataController.DataSource = dsPOMerge
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPO'
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
      object grdPOSearchDBIDPO: TcxGridDBColumn
        DataBinding.FieldName = 'IDPO'
        Width = 50
      end
      object grdPOSearchDBVendor: TcxGridDBColumn
        DataBinding.FieldName = 'Vendor'
        Width = 128
      end
      object grdPOSearchDBDataPedido: TcxGridDBColumn
        DataBinding.FieldName = 'DataPedido'
        Width = 72
      end
      object grdPOSearchDBStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
        Width = 119
      end
      object grdPOSearchDBSubTotal: TcxGridDBColumn
        DataBinding.FieldName = 'SubTotal'
        Width = 79
      end
    end
    object grdPOSearchLevel: TcxGridLevel
      GridView = grdPOSearchDB
    end
  end
  object pnlInfo: TPanel [5]
    Left = 0
    Top = 6
    Width = 456
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object lbPOMerge: TLabel
      Left = 20
      Top = 12
      Width = 86
      Height = 13
      Alignment = taRightJustify
      Caption = 'Merge with PO # :'
    end
    object lbPOActual: TLabel
      Left = 112
      Top = 12
      Width = 22
      Height = 13
      Caption = '000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object quPOMerge: TPowerADOQuery [6]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quPOMergeAfterOpen
    CommandText = 
      'SELECT'#13#10#9'PO.IDPO,'#13#10#9'PO.IDFornecedor,'#13#10#9'PE.Pessoa as Vendor,'#13#10#9'PO' +
      '.DataPedido,'#13#10#9'PO.Aberto,'#13#10#9'PO.SubTotal,'#13#10#9'S.Name as Store'#13#10'FROM' +
      #13#10#9'PO PO (NOLOCK)'#13#10#9'JOIN Pessoa PE (NOLOCK) ON (PO.IDFornecedor ' +
      '= PE.IDPessoa)'#13#10#9'JOIN Store S (NOLOCK) ON (PO.IDStore= S.IDStore' +
      ')'#13#10'WHERE'#13#10#9'PO.Aberto = 1'#13#10#9'AND'#13#10#9'PO.IDFornecedor = :IDFornecedor' +
      #13#10#9'AND'#13#10#9'PO.IDPO <> :IDPOActual'#13#10#9'AND'#13#10#9'PO.IDStore = :IDStore'#13#10
    Parameters = <
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPOActual'
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
      end>
    Left = 159
    Top = 93
    object quPOMergeIDPO: TIntegerField
      DisplayLabel = 'PO #'
      FieldName = 'IDPO'
    end
    object quPOMergeIDFornecedor: TIntegerField
      FieldName = 'IDFornecedor'
    end
    object quPOMergeVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quPOMergeDataPedido: TDateTimeField
      DisplayLabel = 'PO Date'
      FieldName = 'DataPedido'
    end
    object quPOMergeAberto: TBooleanField
      FieldName = 'Aberto'
    end
    object quPOMergeSubTotal: TBCDField
      FieldName = 'SubTotal'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quPOMergeStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object dsPOMerge: TDataSource [7]
    DataSet = quPOMerge
    Left = 160
    Top = 141
  end
  object spRemoveOldPO: TADOStoredProc [8]
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PO_Remove;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPO'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 158
    Top = 198
  end
  object cmdUpdatePO: TADOCommand [9]
    CommandText = 
      'UPDATE PIM  '#13#10'SET PIM.DocumentID = :IDPOActual'#13#10'FROM PreInventor' +
      'yMov PIM  '#13#10'WHERE PIM.DocumentID = :IDPOOld'#13#10'AND PIM.InventMovTy' +
      'peID = 2'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPOActual'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPOOld'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 64
    Top = 196
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmMergePO.sil'
  end
end
