inherited SubMovHistory: TSubMovHistory
  Left = 157
  Top = 251
  Width = 776
  Height = 280
  Caption = 'SubMovHistory'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 768
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      768
      27)
    object Label34: TLabel
      Left = 14
      Top = 5
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
    end
    object Label31: TLabel
      Left = 432
      Top = 6
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'From'
    end
    object Label33: TLabel
      Left = 585
      Top = 6
      Width = 13
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'To'
    end
    object btnExec: TSpeedButton
      Left = 704
      Top = 1
      Width = 57
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '&GO!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Layout = blGlyphRight
      NumGlyphs = 2
      ParentFont = False
      OnClick = btnExecClick
    end
    object DateInicio: TDateBox
      Left = 459
      Top = 2
      Width = 98
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      InputTime = False
    end
    object DateFim: TDateBox
      Left = 601
      Top = 2
      Width = 97
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      InputTime = False
    end
    object btAreaTodas: TButton
      Left = 220
      Top = 2
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 2
      OnClick = btAreaTodasClick
    end
    object cmbStoreMov: TcxLookupComboBox
      Left = 48
      Top = 2
      Width = 166
      Height = 21
      Properties.KeyFieldNames = 'IDStore'
      Properties.ListColumns = <
        item
          FieldName = 'Name'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = DM.dsLookUpStore
      Properties.OnChange = cmbStoreMovPropertiesChange
      Style.BorderStyle = ebsFlat
      Style.HotTrack = True
      Style.PopupBorderStyle = epbsDefault
      TabOrder = 3
      OnEnter = cmbStoreMovEnter
    end
  end
  object grdMovHist: TcxGrid [1]
    Left = 0
    Top = 27
    Width = 768
    Height = 226
    Align = alClient
    TabOrder = 1
    LookAndFeel.Kind = lfFlat
    object grdMovHistDBTableView: TcxGridDBTableView
      OnDblClick = grdMovHistDBTableViewDblClick
      DataController.DataSource = dsMovHistory
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDInventoryMov'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glNone
      OptionsView.GroupByBox = False
      Styles.Background = DefaultStyle
      Styles.Content = DefaultStyle
      Styles.Inactive = DefaultStyle
      object grdMovHistDBTableViewMovDate: TcxGridDBColumn
        DataBinding.FieldName = 'MovDate'
        Width = 72
      end
      object grdMovHistDBTableViewStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
        Width = 91
      end
      object grdMovHistDBTableViewName: TcxGridDBColumn
        DataBinding.FieldName = 'Name'
        Width = 51
      end
      object grdMovHistDBTableViewDocumentID: TcxGridDBColumn
        DataBinding.FieldName = 'DocumentID'
        Width = 63
      end
      object grdMovHistDBTableViewSalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'SalePrice'
        Width = 74
      end
      object grdMovHistDBTableViewCostPrice: TcxGridDBColumn
        DataBinding.FieldName = 'CostPrice'
        Width = 80
      end
      object grdMovHistDBTableViewAvgCostOut: TcxGridDBColumn
        Caption = 'Avg Cost'
        DataBinding.FieldName = 'AvgCostOut'
        Width = 63
      end
      object grdMovHistDBTableViewBalanceTotal: TcxGridDBColumn
        Caption = 'Total Cost'
        DataBinding.FieldName = 'BalanceTotal'
      end
      object grdMovHistDBTableViewSystemUser: TcxGridDBColumn
        DataBinding.FieldName = 'SystemUser'
        Width = 106
      end
      object grdMovHistDBTableViewQty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        Width = 34
      end
      object grdMovHistDBTableViewBalance: TcxGridDBColumn
        DataBinding.FieldName = 'Balance'
        Width = 68
      end
    end
    object grdMovHistLevel: TcxGridLevel
      GridView = grdMovHistDBTableView
    end
  end
  object quMovHistory: TADODataSet [2]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quMovHistoryAfterOpen
    OnCalcFields = quMovHistoryCalcFields
    CommandText = 
      'SELECT'#13#10#9'MH.Name,'#13#10#9'MH.DocumentID,'#13#10#9'MH.MovDate,'#13#10#9'MH.Qty,'#13#10#9'MH.' +
      'SalePrice,'#13#10#9'MH.IDInventoryMov,'#13#10#9'MH.System,'#13#10#9'MH.CostPrice,'#13#10#9'M' +
      'H.SystemUser,'#13#10#9'MH.Store,'#13#10#9'MB.AvgCostOut,'#13#10#9'MB.Qty as BalanceQt' +
      'y,'#13#10#9'MB.BalanceTotal,'#13#10#9'cast(0 as Float) Balance'#13#10'FROM'#13#10#9'vwModel' +
      'HistoryMov MH (NOLOCK)'#13#10#9'LEFT JOIN Inv_ModelBalance MB (NOLOCK) ' +
      'ON (MH.ModelID = MB.IDModel AND dbo.fn_Sys_RemoveTime(MH.MovDate' +
      ') = MB.BalanceDate)'#13#10'WHERE'#13#10#9'ModelID = 1'#13#10#9'AND StoreID = 1'#13#10#9'AND' +
      ' MovDate >= '#39'10/10/2000'#39#13#10#9'AND MovDate < '#39'10/10/2009'#39
    ParamCheck = False
    Parameters = <>
    Left = 88
    Top = 92
    object quMovHistoryName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quMovHistoryDocumentID: TIntegerField
      FieldName = 'DocumentID'
    end
    object quMovHistoryMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object quMovHistoryQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
    end
    object quMovHistorySalePrice: TFloatField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
    end
    object quMovHistoryIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quMovHistorySystem: TBooleanField
      FieldName = 'System'
    end
    object quMovHistoryCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quMovHistorySystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quMovHistoryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quMovHistoryAvgCostOut: TBCDField
      FieldName = 'AvgCostOut'
      Precision = 19
    end
    object quMovHistoryBalanceQty: TFloatField
      FieldName = 'BalanceQty'
    end
    object quMovHistoryBalanceTotal: TBCDField
      FieldName = 'BalanceTotal'
      Precision = 19
    end
    object quMovHistoryBalance: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Balance'
      ReadOnly = True
      Calculated = True
    end
  end
  object dsMovHistory: TDataSource [3]
    DataSet = quMovHistory
    Left = 164
    Top = 88
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubMovHistory.sil'
    Top = 88
  end
  object grdStyle: TcxStyleRepository
    Left = 340
    Top = 188
    object DefaultStyle: TcxStyle
      AssignedValues = [svColor]
      Color = 14607076
    end
  end
  object quBalanceOpen: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as Va' +
      'lue'#13#10'FROM'#13#10#9'InventoryMov IM (NOLOCK)'#13#10#9'JOIN InventoryMovType IMT' +
      ' (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)'#13#10'WHERE'#13#10 +
      #9'IM.ModelID = :IDModel'#13#10#9'AND'#13#10#9'IM.StoreID = IsNull(:IDStore, IM.' +
      'StoreID)'#13#10#9'AND'#13#10#9'IM.MovDate < :OpenDate'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'OpenDate'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 316
    Top = 88
    object quBalanceOpenValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
end
