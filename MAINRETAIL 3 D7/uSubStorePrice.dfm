inherited SubStorePrice: TSubStorePrice
  Width = 331
  Caption = 'SubStorePrice'
  PixelsPerInch = 96
  TextHeight = 13
  object grdPrices: TcxGrid [0]
    Left = 0
    Top = 0
    Width = 315
    Height = 176
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object grdPricesDB: TcxGridDBTableView
      DataController.DataSource = dsInventoryPrice
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'StoreID'
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnHand'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnOrder'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnPrePurchase'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnPreSale'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnRepair'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyFloating'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'MaxQty'
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'MinQty'
        end>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
          SummaryItems = <>
        end>
      Filtering.CustomizeDialog = False
      Filtering.MaxDropDownCount = 1000
      OptionsBehavior.DragOpening = False
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideFocusRect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdPricesDBStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
        Options.Filtering = False
        Width = 125
      end
      object grdPricesDBCostPrice: TcxGridDBColumn
        Caption = 'Cost Price'
        DataBinding.FieldName = 'CostPrice'
        Options.Filtering = False
        Width = 67
      end
      object grdPricesDBStoreAvgPrice: TcxGridDBColumn
        Caption = 'Avg Store Price'
        DataBinding.FieldName = 'StoreAvgPrice'
        Visible = False
        Options.Filtering = False
        Width = 62
      end
      object grdPricesDBSellingPrice: TcxGridDBColumn
        Caption = 'Selling Price'
        DataBinding.FieldName = 'SellingPrice'
        Options.Filtering = False
        Width = 78
      end
    end
    object grdPricesLevel: TcxGridLevel
      GridView = grdPricesDB
    end
  end
  object dsInventoryPrices: TADODataSet [1]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'S.Name as Store,'#13#10#9'I.StoreID,'#13#10#9'coalesce(I.SellingPrice' +
      ', M.SellingPrice) SellingPrice,'#13#10#9'coalesce(I.StoreCostPrice, M.V' +
      'endorCost) CostPrice,'#13#10#9'I.StoreAvgPrice'#13#10'FROM'#13#10#9'Inventory I '#13#10#9'J' +
      'OIN Store S ON (I.StoreID = S.IDStore)'#13#10#9'Join Model M ON (M.IDMo' +
      'del = I.ModelID)'#13#10'WHERE M.IdModel = :IdModel'#13#10
    Parameters = <
      item
        Name = 'IdModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 172
    Top = 48
    object dsInventoryPricesStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object dsInventoryPricesStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object dsInventoryPricesSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object dsInventoryPricesCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dsInventoryPricesStoreAvgPrice: TBCDField
      FieldName = 'StoreAvgPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dsInventoryPrice: TDataSource [2]
    DataSet = dsInventoryPrices
    Left = 260
    Top = 52
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubStorePrice.sil'
  end
end
