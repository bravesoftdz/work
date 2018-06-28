inherited SubSaleHistory: TSubSaleHistory
  Left = 12
  Top = 174
  Width = 769
  Height = 264
  Caption = 'SubSaleHistory'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel [0]
    Left = 516
    Top = 9
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Store :'
  end
  object btnRefreshSales: TButton [1]
    Left = 720
    Top = 5
    Width = 37
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'All'
    TabOrder = 0
    OnClick = btnRefreshSalesClick
  end
  object grdSaleHist: TStringGrid [2]
    Left = 0
    Top = 34
    Width = 761
    Height = 203
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    Color = 14607076
    ColCount = 15
    Ctl3D = True
    DefaultColWidth = 40
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 2
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnSelectCell = grdSaleHistSelectCell
    ColWidths = (
      91
      59
      60
      46
      44
      49
      46
      47
      46
      48
      47
      44
      46
      45
      42)
  end
  object cmbStoreSale: TcxLookupComboBox [3]
    Left = 551
    Top = 5
    Width = 166
    Height = 21
    Anchors = [akTop, akRight]
    Properties.KeyFieldNames = 'IDStore'
    Properties.ListColumns = <
      item
        FieldName = 'Name'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = DM.dsLookUpStore
    Properties.OnChange = cxLookupComboBox1PropertiesChange
    Style.BorderStyle = ebsFlat
    Style.HotTrack = True
    Style.PopupBorderStyle = epbsDefault
    TabOrder = 2
    OnEnter = cmbStoreSaleEnter
  end
  object quSaleHistory: TADOQuery [4]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        Year,'
      '        Month,'
      '        TotSale,'
      '        TotCost'
      'FROM'
      '        InventoryMovTotal InventoryMovTotal (NOLOCK)'
      'WHERE'
      '        StoreID = 1'
      '        AND'
      '        ModelID = 1'
      '        AND'
      '        InventMovTypeID = 1'
      '        AND'
      '        ((Year >=  1 AND Month >= 1) or ((Year -1) = 1))'
      'ORDER BY'
      '        Year,'
      '        Month'
      ' ')
    Left = 86
    Top = 14
    object quSaleHistoryYear: TIntegerField
      FieldName = 'Year'
    end
    object quSaleHistoryMonth: TIntegerField
      FieldName = 'Month'
    end
    object quSaleHistoryTotSale: TFloatField
      FieldName = 'TotSale'
      DisplayFormat = '#,##0.00##'
    end
    object quSaleHistoryTotCost: TFloatField
      FieldName = 'TotCost'
      DisplayFormat = '#,##0.00'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubSaleHistory.sil'
  end
end
