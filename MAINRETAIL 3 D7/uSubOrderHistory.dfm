inherited SubOrderHistory: TSubOrderHistory
  Left = 30
  Top = 137
  Width = 848
  Height = 241
  Caption = 'SubOrderHistory'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object grdOrder: TSMDBGrid [0]
    Left = 0
    Top = 0
    Width = 832
    Height = 203
    Align = alClient
    BorderStyle = bsNone
    Color = 14607076
    DataSource = dsOrder
    Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
    ExOptions = [eoAutoWidth, eoENTERlikeTAB, eoKeepSelection]
    RegistryKey = 'Software\Scalabium'
    RegistrySection = 'SMDBGrid'
    WidthOfIndicator = 11
    DefaultRowHeight = 17
    ColCount = 1
    RowCount = 2
  end
  object quOrder: TADOQuery [1]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        IDFornecedor,'
      '        Vendor,'
      '        MovDate,'
      '        DocumentID,'
      '        CostPrice,'
      '        DateEstimatedMov,'
      '        DateRealMov,'
      '        Qty,'
      '        QtyRealMov,'
      '        SalePrice'
      'FROM'
      '        PreInventoryMov (NOLOCK)'
      
        '        JOIN vwFornecedor (NOLOCK) ON ( PreInventoryMov.IDPessoa' +
        ' = vwFornecedor.IDFornecedor )'
      'WHERE'
      '        InventMovTypeID = 2'
      '        AND'
      '        ModelID = :IDModel'
      'ORDER BY'
      '        MovDate desc'
      ' ')
    Left = 67
    Top = 14
    object quOrderIDFornecedor: TIntegerField
      DisplayLabel = 'IDVendor'
      FieldName = 'IDFornecedor'
      Origin = 'vwFornecedor.IDFornecedor'
      Visible = False
    end
    object quOrderMovDate: TDateTimeField
      DisplayLabel = 'ReqDate'
      FieldName = 'MovDate'
      Origin = 'PreInventoryMov.MovDate'
      DisplayFormat = 'ddddd'
      EditMask = '!99/99/00;1;_'
    end
    object quOrderVendor: TStringField
      DisplayWidth = 30
      FieldName = 'Vendor'
      Origin = 'vwFornecedor.IDFornecedor'
      Size = 50
    end
    object quOrderDocumentID: TIntegerField
      DisplayLabel = 'PO#'
      FieldName = 'DocumentID'
      Origin = 'PreInventoryMov.DocumentID'
    end
    object quOrderCostPrice: TFloatField
      FieldName = 'CostPrice'
      Origin = 'PreInventoryMov.CostPrice'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quOrderDateEstimatedMov: TDateTimeField
      DisplayLabel = 'Est.Arrived'
      FieldName = 'DateEstimatedMov'
      Origin = 'PreInventoryMov.DateEstimatedMov'
      DisplayFormat = 'ddddd'
      EditMask = '!99/99/00;1;_'
    end
    object quOrderDateRealMov: TDateTimeField
      DisplayLabel = 'LastArrive'
      FieldName = 'DateRealMov'
      Origin = 'PreInventoryMov.DateRealMov'
      DisplayFormat = 'ddddd'
      EditMask = '!99/99/00;1;_'
    end
    object quOrderSalePrice: TFloatField
      FieldName = 'SalePrice'
      Origin = 'vwFornecedor.IDFornecedor'
      DisplayFormat = '#,##0.00##'
      currency = True
    end
    object quOrderQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quOrderQtyRealMov: TFloatField
      FieldName = 'QtyRealMov'
      DisplayFormat = '0.#####'
    end
  end
  object dsOrder: TDataSource [2]
    DataSet = quOrder
    Left = 115
    Top = 15
  end
  object quArrivals: TADOQuery [3]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        IDFornecedor,'
      '        Vendor,'
      '        MovDate,'
      '        DocumentID,'
      '        CostPrice,'
      '        DateEstimatedMov,'
      '        DateRealMov,'
      '        Qty,'
      '        QtyRealMov,'
      '        SalePrice'
      'FROM'
      '        PreInventoryMov (NOLOCK)'
      
        '        JOIN vwFornecedor (NOLOCK) ON ( PreInventoryMov.IDPessoa' +
        ' = vwFornecedor.IDFornecedor )'
      'WHERE'
      '        InventMovTypeID = 2'
      '        AND'
      '        ModelID = :IDModel'
      '        AND'
      '        Qty > QtyRealMov'
      'ORDER BY'
      '        MovDate desc'
      ' ')
    Left = 179
    Top = 22
    object quArrivalsIDFornecedor: TIntegerField
      DisplayLabel = 'IDVendor'
      FieldName = 'IDFornecedor'
      Origin = 'vwFornecedor.IDFornecedor'
      Visible = False
    end
    object quArrivalsMovDate: TDateTimeField
      DisplayLabel = 'ReqDate'
      FieldName = 'MovDate'
      Origin = 'PreInventoryMov.MovDate'
      Visible = False
      DisplayFormat = 'ddddd'
      EditMask = '!99/99/00;1;_'
    end
    object quArrivalsVendor: TStringField
      FieldName = 'Vendor'
      Origin = 'vwFornecedor.IDFornecedor'
      Size = 50
    end
    object quArrivalsDocumentID: TIntegerField
      DisplayLabel = 'PO#'
      FieldName = 'DocumentID'
      Origin = 'PreInventoryMov.DocumentID'
    end
    object quArrivalsCostPrice: TFloatField
      FieldName = 'CostPrice'
      Origin = 'PreInventoryMov.CostPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quArrivalsDateEstimatedMov: TDateTimeField
      DisplayLabel = 'Est.Arrived'
      FieldName = 'DateEstimatedMov'
      Origin = 'PreInventoryMov.DateEstimatedMov'
      DisplayFormat = 'ddddd'
      EditMask = '!99/99/00;1;_'
    end
    object quArrivalsDateRealMov: TDateTimeField
      DisplayLabel = 'LastArrive'
      FieldName = 'DateRealMov'
      Origin = 'PreInventoryMov.DateRealMov'
      Visible = False
      DisplayFormat = 'ddddd'
      EditMask = '!99/99/00;1;_'
    end
    object quArrivalsSalePrice: TFloatField
      FieldName = 'SalePrice'
      Origin = 'vwFornecedor.IDFornecedor'
      Visible = False
      DisplayFormat = '#,##0.00##'
      currency = True
    end
    object quArrivalsQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quArrivalsQtyRealMov: TFloatField
      FieldName = 'QtyRealMov'
      DisplayFormat = '0.#####'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubOrderHistory.sil'
  end
end
