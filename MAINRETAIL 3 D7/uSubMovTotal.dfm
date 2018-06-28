inherited SubMovTotal: TSubMovTotal
  Left = 11
  Top = 160
  Width = 772
  Height = 265
  Caption = 'SubMovTotal'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label29: TLabel [0]
    Left = 516
    Top = 13
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Store :'
  end
  object Button2: TButton [1]
    Left = 722
    Top = 9
    Width = 37
    Height = 21
    Anchors = [akTop, akRight]
    Caption = 'All'
    TabOrder = 0
    OnClick = Button2Click
  end
  object grdModelHist: TStringGrid [2]
    Left = 0
    Top = 35
    Width = 764
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
    ColWidths = (
      120
      44
      50
      48
      44
      53
      47
      47
      43
      44
      47
      46
      43
      46
      40)
  end
  object cmbStoreMovTotal: TcxLookupComboBox [3]
    Left = 552
    Top = 9
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
    Properties.OnChange = cmbStoreMovTotalPropertiesChange
    Style.BorderStyle = ebsFlat
    Style.HotTrack = True
    Style.PopupBorderStyle = epbsDefault
    TabOrder = 2
    OnEnter = cmbStoreMovTotalEnter
  end
  object quModelHistory: TADOQuery [4]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        Year,'
      '        Month,'
      '        InventMovTypeID,'
      '        Name,'
      '        TotQty'
      'FROM'
      '        InventoryMovTotal InventoryMovTotal (NOLOCK)'
      
        '        JOIN InventoryMovType InventoryMovType (NOLOCK) ON ( Inv' +
        'entoryMovType.IDInventMovType = InventoryMovTotal.InventMovTypeI' +
        'D )'
      'WHERE'
      '        StoreID = 1'
      '        AND'
      '        ModelID = 1'
      '        AND'
      '        ((Year >=  1 AND Month >= 1) or ((Year -1) = 1))'
      'ORDER BY'
      '        InventMovTypeID,'
      '        Year,'
      '        Month'
      ' ')
    Left = 96
    Top = 15
    object quModelHistoryYear: TIntegerField
      FieldName = 'Year'
    end
    object quModelHistoryMonth: TIntegerField
      FieldName = 'Month'
    end
    object quModelHistoryName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quModelHistoryInventMovTypeID: TIntegerField
      FieldName = 'InventMovTypeID'
    end
    object quModelHistoryTotQty: TFloatField
      FieldName = 'TotQty'
      DisplayFormat = '0.#####'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubMovTotal.sil'
  end
end
