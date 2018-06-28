inherited SubVendorHistory: TSubVendorHistory
  Left = 4
  Top = 159
  Width = 743
  Caption = 'SubVendorHistory'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object grdModelFrameVendorHistory: TSMDBGrid [0]
    Left = 0
    Top = 0
    Width = 735
    Height = 187
    Align = alClient
    BorderStyle = bsNone
    Color = 14607076
    DataSource = dsVendorHistory
    Options = [dgTitles, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Flat = True
    Groupings = <>
    GridStyle.Style = gsCustom
    GridStyle.OddColor = 14607076
    GridStyle.EvenColor = 14607076
    FooterColor = clBtnFace
    ExOptions = [eoAutoWidth, eoKeepSelection]
    RegistryKey = 'Software\Scalabium'
    RegistrySection = 'SMDBGrid'
    WidthOfIndicator = 11
    DefaultRowHeight = 17
    ScrollBars = ssVertical
    ColCount = 8
    RowCount = 2
    Columns = <
      item
        Expanded = False
        FieldName = 'LastDate'
        Width = 84
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Model'
        Width = 117
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Description'
        Width = 221
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Qty'
        Width = 47
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'CostPrice'
        Width = 62
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Freight'
        Width = 62
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'OtherCost'
        Width = 62
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Total'
        Width = 62
        Visible = True
        FooterType = ftCustom
      end>
  end
  object dsVendorHistory: TDataSource [1]
    DataSet = quVendorHistory
    Left = 175
    Top = 16
  end
  object quVendorHistory: TADOQuery [2]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  Max (MovDate) as LastDate,'
      '  ModelID,'
      '  Model,'
      '  Description,'
      '  IM.Qty ,'
      '  IM.CostPrice,'
      '  IM.Freight,'
      '  IM.OtherCost,'
      
        '  (IsNull(IM.OtherCost,0) +  IsNull(IM.CostPrice,0) + IsNull(IM.' +
        'Freight,0) + IsNull(IM.OtherCost,0)) * IM.Qty as Total'
      ''
      'FROM'
      '  InventoryMov IM (NOLOCK)'
      '  JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)'
      ''
      'WHERE'
      '  IM.StoreID = IsNull(:IDStore, IM.StoreID)'
      '  AND'
      '  IM.IDPessoa = IsNull(:IDFornecedor, IM.IDPessoa)'
      '  AND'
      '  IM.InventMovTypeID = 2 -- Compra'
      ''
      'GROUP BY'
      '  ModelID,'
      '  Model,'
      '  Description,'
      '  IM.Qty ,'
      '  IM.CostPrice,'
      '  IM.Freight,'
      '  IM.OtherCost,'
      
        '  (IsNull(IM.OtherCost,0) +  IsNull(IM.CostPrice,0) + IsNull(IM.' +
        'Freight,0) + IsNull(IM.OtherCost,0)) * IM.Qty'
      ''
      ' '
      ' ')
    Left = 85
    Top = 16
    object quVendorHistoryLastDate: TDateTimeField
      FieldName = 'LastDate'
      DisplayFormat = 'ddddd'
    end
    object quVendorHistoryModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quVendorHistoryModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quVendorHistoryDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quVendorHistoryCostPrice: TFloatField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object quVendorHistoryFreight: TFloatField
      FieldName = 'Freight'
      DisplayFormat = '#,##0.00'
    end
    object quVendorHistoryOtherCost: TFloatField
      FieldName = 'OtherCost'
      DisplayFormat = '#,##0.00'
    end
    object quVendorHistoryTotal: TFloatField
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
    end
    object quVendorHistoryQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubVendorHistory.sil'
  end
end
