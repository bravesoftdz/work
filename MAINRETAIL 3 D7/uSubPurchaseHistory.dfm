inherited SubPurchaseHistory: TSubPurchaseHistory
  Left = 25
  Top = 141
  Width = 736
  Height = 241
  Caption = 'SubPurchaseHistory'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object grdFrameModelPruchaseHistory: TSMDBGrid [0]
    Left = 0
    Top = 0
    Width = 728
    Height = 214
    Align = alClient
    BorderStyle = bsNone
    Color = 14607076
    DataSource = dsHistory
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
    ColCount = 9
    RowCount = 2
    Columns = <
      item
        Expanded = False
        FieldName = 'MovDate'
        Width = 69
        Visible = True
        FooterType = ftCustom
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'IDPurchase'
        Width = 67
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'DocumentNumber'
        Width = 56
        Visible = True
        FooterType = ftCustom
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'IDFornecedor'
        Visible = False
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Vendor'
        Width = 289
        Visible = True
        FooterType = ftCustom
      end
      item
        Alignment = taLeftJustify
        Expanded = False
        FieldName = 'Qty'
        Width = 67
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'CostPrice'
        Title.Alignment = taRightJustify
        Width = 58
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'Freight'
        Title.Alignment = taRightJustify
        Width = 40
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'OtherCost'
        Title.Alignment = taRightJustify
        Width = 65
        Visible = True
        FooterType = ftCustom
      end>
  end
  object quHistory: TADOQuery [1]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
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
      end>
    SQL.Strings = (
      'SELECT'
      '        vwPurchaseItem.IDPurchase,'
      '        Vendor,'
      '        Code,'
      '        vwFornecedor.IDFornecedor,'
      '        MovDate,'
      '        Qty,'
      '        CostPrice,'
      '        vwPurchaseItem.Freight,'
      '        OtherCost,'
      #9'P.DocumentNumber'
      'FROM'
      '        vwPurchaseItem vwPurchaseItem (NOLOCK)'
      
        '        JOIN vwFornecedor vwFornecedor (NOLOCK) ON (vwPurchaseIt' +
        'em.IDFornecedor = vwFornecedor.IDFornecedor)'
      
        #9'JOIN Pur_Purchase P (NOLOCK) ON (P.IDPurchase = vwPurchaseItem.' +
        'IDPurchase)'
      'WHERE'
      '        ModelID = :IDModel'
      '        AND'
      
        '        vwPurchaseItem.IDStore = IsNull(:IDStore, vwPurchaseItem' +
        '.IDStore)'
      'ORDER BY'
      '        MovDate Desc')
    Left = 75
    Top = 16
    object quHistoryMovDate: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'MovDate'
      Origin = 'vw_PurchaseItem.MovDate'
      DisplayFormat = 'ddddd'
    end
    object quHistoryCostPrice: TFloatField
      DisplayLabel = 'Cost'
      DisplayWidth = 10
      FieldName = 'CostPrice'
      Origin = 'vw_PurchaseItem.CostPrice'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quHistoryIDFornecedor: TIntegerField
      DisplayLabel = 'IDVendor'
      FieldName = 'IDFornecedor'
      Origin = 'vwFornecedor.IDFornecedor'
    end
    object quHistoryFreight: TFloatField
      FieldName = 'Freight'
      Origin = 'vwFornecedor.Fornecedor'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quHistoryOtherCost: TFloatField
      FieldName = 'OtherCost'
      Origin = 'vwFornecedor.IDFornecedor'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quHistoryVendor: TStringField
      FieldName = 'Vendor'
      Origin = 'vwFornecedor.Vendor'
      Size = 50
    end
    object quHistoryCode: TIntegerField
      FieldName = 'Code'
      Origin = 'vwFornecedor.Vendor'
    end
    object quHistoryIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quHistoryDocumentNumber: TStringField
      DisplayLabel = 'Invoice#'
      FieldName = 'DocumentNumber'
    end
    object quHistoryQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object dsHistory: TDataSource [2]
    DataSet = quHistory
    Left = 75
    Top = 66
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubPurchaseHistory.sil'
  end
end
