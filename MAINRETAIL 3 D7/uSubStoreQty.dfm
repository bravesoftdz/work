inherited SubStoreQty: TSubStoreQty
  Left = 702
  Width = 386
  Caption = 'SubStoreQty'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object grdQty: TcxGrid [0]
    Left = 0
    Top = 0
    Width = 370
    Height = 176
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object grdQtyDB: TcxGridDBTableView
      DataController.DataSource = dsQty
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'StoreID'
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnHand'
          Column = grdQtyDBQtyOnHand
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnOrder'
          Column = grdQtyDBQtyOnOrder
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnPrePurchase'
          Column = grdQtyDBQtyOnPrePurchase
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnPreSale'
          Column = grdQtyDBQtyOnPreSale
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyOnRepair'
          Column = grdQtyDBQtyOnRepair
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'QtyFloating'
          Column = grdQtyDBQtyFloating
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'MaxQty'
          Column = grdQtyDBMaxQty
        end
        item
          Format = '0.#####'
          Kind = skSum
          FieldName = 'MinQty'
          Column = grdQtyDBMinQty
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
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdQtyDBName: TcxGridDBColumn
        DataBinding.FieldName = 'Name'
        Options.Filtering = False
        Width = 54
      end
      object grdQtyDBQtyOnHand: TcxGridDBColumn
        Caption = 'OnHand'
        DataBinding.FieldName = 'QtyOnHand'
        Options.Filtering = False
        Width = 50
      end
      object grdQtyDBQtyFloating: TcxGridDBColumn
        Caption = 'Available'
        DataBinding.FieldName = 'QtyFloating'
        Visible = False
        Options.Filtering = False
      end
      object grdQtyDBHasInStore: TcxGridDBColumn
        DataBinding.FieldName = 'HasInStore'
        Visible = False
        Options.Filtering = False
        Width = 37
      end
      object grdQtyDBQtyOnPreSale: TcxGridDBColumn
        Caption = 'OnHold'
        DataBinding.FieldName = 'QtyOnPreSale'
        Options.Filtering = False
        Width = 46
      end
      object grdQtyDBQtyOnOrder: TcxGridDBColumn
        Caption = 'OnOrder'
        DataBinding.FieldName = 'QtyOnOrderPositive'
        Options.Filtering = False
        Width = 39
      end
      object grdQtyDBQtyOnRepair: TcxGridDBColumn
        Caption = 'OnRepair'
        DataBinding.FieldName = 'QtyOnRepair'
        Options.Filtering = False
        Width = 44
      end
      object grdQtyDBQtyOnPrePurchase: TcxGridDBColumn
        Caption = 'InReceiving'
        DataBinding.FieldName = 'QtyOnPrePurchase'
        Options.Filtering = False
        Width = 79
      end
      object grdQtyDBMinQty: TcxGridDBColumn
        Caption = 'Min'
        DataBinding.FieldName = 'MinQty'
        Visible = False
        Options.Filtering = False
        Width = 32
      end
      object grdQtyDBMaxQty: TcxGridDBColumn
        Caption = 'Max'
        DataBinding.FieldName = 'MaxQty'
        Visible = False
        Options.Filtering = False
        Width = 38
      end
      object grdQtyDBIDStore: TcxGridDBColumn
        DataBinding.FieldName = 'StoreID'
        Visible = False
      end
    end
    object grdQtyLevel: TcxGridLevel
      GridView = grdQtyDB
    end
  end
  object spQty: TADOStoredProc [1]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    AfterOpen = spQtyAfterOpen
    OnCalcFields = spQtyCalcFields
    ProcedureName = 'sp_PreSale_quQtyOnStore;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@ModelID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 104
    Top = 57
    object spQtyName: TStringField
      DisplayLabel = 'Store'
      DisplayWidth = 33
      FieldName = 'Name'
      Size = 30
    end
    object spQtyStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object spQtyCurrentCost: TFloatField
      FieldName = 'CurrentCost'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object spQtyFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object spQtyHasInStore: TStringField
      FieldKind = fkCalculated
      FieldName = 'HasInStore'
      Calculated = True
    end
    object spQtyQtyOnPreSale: TFloatField
      FieldName = 'QtyOnPreSale'
      DisplayFormat = '0.#####'
    end
    object spQtyQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
    end
    object spQtyQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
      DisplayFormat = '0.#####'
    end
    object spQtyQtyOnRepair: TFloatField
      FieldName = 'QtyOnRepair'
      DisplayFormat = '0.#####'
    end
    object spQtyQtyOnPrePurchase: TFloatField
      FieldName = 'QtyOnPrePurchase'
      DisplayFormat = '0.#####'
    end
    object spQtyQtyOnOrderPositive: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QtyOnOrderPositive'
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object spQtyQtyFloating: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QtyFloating'
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object spQtyMinQty: TFloatField
      FieldName = 'MinQty'
    end
    object spQtyMaxQty: TFloatField
      FieldName = 'MaxQty'
    end
  end
  object dsQty: TDataSource [2]
    DataSet = spQty
    OnDataChange = dsQtyDataChange
    Left = 52
    Top = 97
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubStoreQty.sil'
  end
end
