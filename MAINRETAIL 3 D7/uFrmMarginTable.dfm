inherited FrmMarginTable: TFrmMarginTable
  Left = 343
  Top = 15
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'FrmMarginTable'
  ClientHeight = 392
  ClientWidth = 518
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 518
    inherited imgTopIni: TImage
      Height = 36
    end
    inherited Image1: TImage
      Width = 291
      Height = 36
    end
    inherited lblMenu: TLabel
      Left = 302
    end
    inherited Image3: TImage
      Height = 36
    end
    inherited EspacamentoSuperior: TPanel
      Top = 36
      Width = 518
      Height = 4
      Visible = False
      inherited EEE: TPanel
        Width = 518
      end
    end
  end
  inherited Panel1: TPanel
    Top = 351
    Width = 518
    inherited EspacamentoInferior: TPanel
      Width = 518
      inherited Panel3: TPanel
        Width = 518
      end
    end
    inherited hhh: TPanel
      Left = 436
      inherited btClose: TButton
        Cancel = True
        TabStop = True
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 311
  end
  inherited EspacamentoDireito: TPanel
    Left = 404
    Width = 0
    Height = 311
    Visible = False
  end
  object pnPanel: TPanel [4]
    Left = 404
    Top = 40
    Width = 114
    Height = 311
    Align = alRight
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 4
    object btGroup: TSpeedButton
      Left = 4
      Top = 1
      Width = 109
      Height = 28
      AllowAllUp = True
      Caption = 'A&pply'
      Flat = True
      Margin = 5
      Spacing = 8
      OnClick = btGroupClick
    end
    object btRecalcAllGroup: TSpeedButton
      Left = 5
      Top = 30
      Width = 109
      Height = 28
      AllowAllUp = True
      Caption = 'Recalc Inventory'
      Flat = True
      Margin = 5
      Spacing = 8
      OnClick = btRecalcAllGroupClick
    end
  end
  object TreeList: TdxTreeList [5]
    Left = 3
    Top = 40
    Width = 401
    Height = 311
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alClient
    TabOrder = 5
    HideSelection = False
    LookAndFeel = lfUltraFlat
    Options = [aoColumnSizing, aoColumnMoving, aoTabThrough, aoRowSelect, aoAutoWidth]
    TreeLineColor = clGrayText
    ScrollBars = ssVertical
    Data = {
      FFFFFFFF02000000180000000000000000000000FFFFFFFF0000000001000000
      050000000800000054656C65666F6E6500000000000000000000000000000000
      180000000000000000000000FFFFFFFF00000000010000000500000007000000
      43656C756C617200000000000000000000000000000000180000000000000000
      000000FFFFFFFF0000000000000000050000000300000054494D000000000000
      00000000000000000000180000000000000000000000FFFFFFFF000000000000
      0000050000000700000043616465697261000000000000000000000000000000
      00}
    object clTreeText: TdxTreeListColumn
      Caption = 'Tree'
      Width = 163
      BandIndex = 0
      RowIndex = 0
    end
    object clTreeValue: TdxTreeListColumn
      Caption = 'Sales Margin'
      Width = 112
      BandIndex = 0
      RowIndex = 0
    end
    object clTreeMSRP: TdxTreeListColumn
      Caption = 'MSRP Margin'
      Width = 124
      BandIndex = 0
      RowIndex = 0
    end
    object TreeListType: TdxTreeListColumn
      MinWidth = 0
      Width = 0
      BandIndex = 0
      RowIndex = 0
    end
    object TreeListID: TdxTreeListColumn
      MinWidth = 0
      Width = 0
      BandIndex = 0
      RowIndex = 0
    end
  end
  object dsBrowse: TDataSource [6]
    Left = 82
    Top = 185
  end
  object quMargemTable: TADODataSet [7]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'MargemTable'#13#10'FROM'#13#10#9'MargemTable (NOLOCK) '#13#10'WHERE'#13#10#9'IDM' +
      'argemTable =  :IDMargemTable'#13#10
    Parameters = <
      item
        Name = 'IDMargemTable'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 210
    Top = 125
    object quMargemTableMargemTable: TStringField
      FieldName = 'MargemTable'
      Size = 30
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmMarginTable.sil'
    Left = 49
    Top = 65532
  end
  object quBrowse: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quBrowseAfterOpen
    CommandText = 
      'SELECT '#13#10#9'TG.IDGroup,'#13#10#9'TG.Name Category,'#13#10#9'TG.IDSalePriceMargem' +
      'Table,'#13#10#9'TG.SalePriceMargemPercent,'#13#10#9'TG.UseSalePricePercent,'#13#10#9 +
      'TG.IDMSRPMargemTable,'#13#10#9'TG.MSRPMargemPercent,'#13#10#9'TG.UseMSRPPercen' +
      't,'#13#10#9'MG.IDModelGroup,'#13#10#9'MG.ModelGroup,'#13#10#9'MG.SalePriceMargemPerce' +
      'nt MGSalePriceMargemPercent,'#13#10#9'MG.UseSalePricePercent MGUseSaleP' +
      'ricePercent,'#13#10#9'MG.IDSalePriceMargemTable MGIDSalePriceMargemTabl' +
      'e,'#9#13#10#9'MG.IDMSRPMargemTable MGIDMSRPMargemTable,'#9#13#10#9'MG.MSRPMargem' +
      'Percent MGMSRPMargemPercent,'#13#10#9'MG.UseMSRPPercent MGUseMSRPPercen' +
      't,'#13#10#9'MSG.IDModelSubGroup,'#13#10#9'MSG.ModelSubGroup,'#13#10#9'MSG.SalePriceMa' +
      'rgemPercent MSGSalePriceMargemPercent,'#13#10#9'MSG.UseSalePricePercent' +
      ' MSGUseSalePricePercent,'#13#10#9'MSG.IDSalePriceMargemTable MSGIDSaleP' +
      'riceMargemTable,'#13#10#9'MSG.IDMSRPMargemTable MSGIDMSRPMargemTable,'#9#13 +
      #10#9'MSG.MSRPMargemPercent MSGMSRPMargemPercent,'#9#13#10#9'MSG.UseMSRPPerc' +
      'ent MSGUseMSRPPercent'#9#13#10'FROM'#13#10#9'TabGroup TG (NOLOCK) '#13#10#9'LEFT JOIN' +
      ' ModelGroup MG (NOLOCK) ON (MG.IDGroup = TG.IDGroup)'#13#10#9'LEFT JOIN' +
      ' ModelSubGroup MSG (NOLOCK) ON (MSG.IDModelGroup = MG.IDModelGro' +
      'up)'#13#10'WHERE'#13#10#9'TG.Hidden = 0'#13#10#9'AND'#13#10#9'TG.Desativado = 0'#13#10'ORDER BY'#13#10 +
      #9'TG.Name,'#13#10#9'MG.ModelGroup,'#13#10#9'MSG.ModelSubGroup'
    Parameters = <>
    Left = 80
    Top = 112
    object quBrowseIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quBrowseCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quBrowseIDSalePriceMargemTable: TIntegerField
      FieldName = 'IDSalePriceMargemTable'
    end
    object quBrowseSalePriceMargemPercent: TFloatField
      FieldName = 'SalePriceMargemPercent'
    end
    object quBrowseUseSalePricePercent: TBooleanField
      FieldName = 'UseSalePricePercent'
    end
    object quBrowseIDMSRPMargemTable: TIntegerField
      FieldName = 'IDMSRPMargemTable'
    end
    object quBrowseMSRPMargemPercent: TFloatField
      FieldName = 'MSRPMargemPercent'
    end
    object quBrowseUseMSRPPercent: TBooleanField
      FieldName = 'UseMSRPPercent'
    end
    object quBrowseIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object quBrowseModelGroup: TStringField
      FieldName = 'ModelGroup'
      Size = 30
    end
    object quBrowseMGSalePriceMargemPercent: TFloatField
      FieldName = 'MGSalePriceMargemPercent'
    end
    object quBrowseMGUseSalePricePercent: TBooleanField
      FieldName = 'MGUseSalePricePercent'
    end
    object quBrowseMGIDSalePriceMargemTable: TIntegerField
      FieldName = 'MGIDSalePriceMargemTable'
    end
    object quBrowseMGIDMSRPMargemTable: TIntegerField
      FieldName = 'MGIDMSRPMargemTable'
    end
    object quBrowseMGMSRPMargemPercent: TFloatField
      FieldName = 'MGMSRPMargemPercent'
    end
    object quBrowseMGUseMSRPPercent: TBooleanField
      FieldName = 'MGUseMSRPPercent'
    end
    object quBrowseIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object quBrowseModelSubGroup: TStringField
      FieldName = 'ModelSubGroup'
      Size = 30
    end
    object quBrowseMSGSalePriceMargemPercent: TFloatField
      FieldName = 'MSGSalePriceMargemPercent'
    end
    object quBrowseMSGUseSalePricePercent: TBooleanField
      FieldName = 'MSGUseSalePricePercent'
    end
    object quBrowseMSGIDSalePriceMargemTable: TIntegerField
      FieldName = 'MSGIDSalePriceMargemTable'
    end
    object quBrowseMSGIDMSRPMargemTable: TIntegerField
      FieldName = 'MSGIDMSRPMargemTable'
    end
    object quBrowseMSGMSRPMargemPercent: TFloatField
      FieldName = 'MSGMSRPMargemPercent'
    end
    object quBrowseMSGUseMSRPPercent: TBooleanField
      FieldName = 'MSGUseMSRPPercent'
    end
  end
  object cdsMarginRecalcAll: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 292
    Top = 204
    object cdsMarginRecalcAllIsUpdate: TBooleanField
      FieldName = 'IsUpdate'
    end
    object cdsMarginRecalcAllModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginRecalcAllDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsMarginRecalcAllIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object cdsMarginRecalcAllCostPrice: TBCDField
      FieldName = 'CostPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsMarginRecalcAllNewSellingPrice: TBCDField
      FieldName = 'NewSellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsMarginRecalcAllNewMSRPPrice: TBCDField
      FieldName = 'NewMSRPPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsMarginRecalcAllSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginRecalcAllMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginRecalcAllRealMarkUpValue: TBCDField
      FieldName = 'RealMarkUpValue'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginRecalcAllRealMarkUpPercent: TBCDField
      FieldName = 'RealMarkUpPercent'
      ReadOnly = True
      DisplayFormat = '#,##0.00%'
      Precision = 19
    end
    object cdsMarginRecalcAllMarginPercent: TBCDField
      FieldName = 'MarginPercent'
      ReadOnly = True
      DisplayFormat = '#,##0.00%'
      Precision = 19
    end
    object cdsMarginRecalcAllMarginValue: TBCDField
      FieldName = 'MarginValue'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginRecalcAllCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginRecalcAllSubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginRecalcAllModelGroup: TStringField
      FieldName = 'ModelGroup'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginRecalcAllMarkUp: TBCDField
      FieldName = 'MarkUp'
      DisplayFormat = '#,##0.00%'
      Precision = 19
    end
  end
  object cmdUpdateModel: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Model'#13#10'SET'#13#10#9'SellingPrice = :NewSellingPrice,'#13#10#9'SuggRet' +
      'ail = :NewMSRPPrice,'#13#10#9'DateLastSellingPrice = :DateLastSellingPr' +
      'ice,'#13#10#9'IDUserLastSellingPrice = :IDUserLastSellingPrice'#13#10'WHERE'#13#10 +
      #9'IDModel = :IDModel'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'NewSellingPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewMSRPPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'DateLastSellingPrice'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDUserLastSellingPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 292
    Top = 260
  end
end
