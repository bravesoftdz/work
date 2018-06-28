object FrmPromoControl: TFrmPromoControl
  Left = 0
  Top = 9
  Width = 671
  Height = 440
  Caption = 'FrmPromoControl'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 2
    Top = 10
    Width = 938
    Height = 181
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = DataSource1
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1IDModel: TcxGridDBColumn
        DataBinding.FieldName = 'IDModel'
      end
      object cxGrid1DBTableView1IDInventoryMov: TcxGridDBColumn
        DataBinding.FieldName = 'IDInventoryMov'
      end
      object cxGrid1DBTableView1IDInventoryMovParent: TcxGridDBColumn
        DataBinding.FieldName = 'IDInventoryMovParent'
      end
      object cxGrid1DBTableView1IDPromo: TcxGridDBColumn
        DataBinding.FieldName = 'IDPromo'
      end
      object cxGrid1DBTableView1PromoType: TcxGridDBColumn
        DataBinding.FieldName = 'PromoType'
      end
      object cxGrid1DBTableView1DiscountType: TcxGridDBColumn
        DataBinding.FieldName = 'DiscountType'
      end
      object cxGrid1DBTableView1Qty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        Width = 37
      end
      object cxGrid1DBTableView1SalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'SalePrice'
        Width = 60
      end
      object cxGrid1DBTableView1TotalDiscountApplied: TcxGridDBColumn
        DataBinding.FieldName = 'TotalDiscountApplied'
      end
      object cxGrid1DBTableView1InUse: TcxGridDBColumn
        DataBinding.FieldName = 'InUse'
        Width = 49
      end
      object cxGrid1DBTableView1IsPrize: TcxGridDBColumn
        DataBinding.FieldName = 'IsPrize'
        Width = 48
      end
      object cxGrid1DBTableView1IsNew: TcxGridDBColumn
        DataBinding.FieldName = 'IsNew'
        Width = 50
      end
      object cxGrid1DBTableView1IsDeleted: TcxGridDBColumn
        DataBinding.FieldName = 'IsDeleted'
        Width = 50
      end
      object cxGrid1DBTableView1IsUpdate: TcxGridDBColumn
        DataBinding.FieldName = 'IsUpdate'
        Width = 51
      end
      object cxGrid1DBTableView1Indice: TcxGridDBColumn
        DataBinding.FieldName = 'Indice'
        Width = 51
      end
      object cxGrid1DBTableView1FlatPromo: TcxGridDBColumn
        DataBinding.FieldName = 'FlatPromo'
      end
      object cxGrid1DBTableView1DiscountLoyalt: TcxGridDBColumn
        DataBinding.FieldName = 'DiscountLoyalt'
        Width = 51
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object btnteste: TButton
    Left = 943
    Top = 15
    Width = 30
    Height = 42
    Caption = 'Calc'
    TabOrder = 1
    OnClick = btntesteClick
  end
  object cxGrid2: TcxGrid
    Left = 2
    Top = 200
    Width = 938
    Height = 181
    TabOrder = 2
    object cxGridDBTableView1: TcxGridDBTableView
      DataController.DataSource = dsclone
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGridDBTableView1IDModel: TcxGridDBColumn
        DataBinding.FieldName = 'IDModel'
      end
      object cxGridDBTableView1IDInventoryMov: TcxGridDBColumn
        DataBinding.FieldName = 'IDInventoryMov'
      end
      object cxGridDBTableView1IDInventoryMovParent: TcxGridDBColumn
        DataBinding.FieldName = 'IDInventoryMovParent'
      end
      object cxGridDBTableView1IDPromo: TcxGridDBColumn
        DataBinding.FieldName = 'IDPromo'
      end
      object cxGridDBTableView1PromoType: TcxGridDBColumn
        DataBinding.FieldName = 'PromoType'
      end
      object cxGridDBTableView1DiscountType: TcxGridDBColumn
        DataBinding.FieldName = 'DiscountType'
      end
      object cxGridDBTableView1Qty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        Width = 39
      end
      object cxGridDBTableView1SalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'SalePrice'
      end
      object cxGridDBTableView1SalePriceDiscount: TcxGridDBColumn
        DataBinding.FieldName = 'SalePriceDiscount'
        Width = 73
      end
      object cxGridDBTableView1InUse: TcxGridDBColumn
        DataBinding.FieldName = 'InUse'
        Width = 48
      end
      object cxGridDBTableView1IsPrize: TcxGridDBColumn
        DataBinding.FieldName = 'IsPrize'
        Width = 47
      end
      object cxGridDBTableView1IsNew: TcxGridDBColumn
        DataBinding.FieldName = 'IsNew'
        Width = 45
      end
      object cxGridDBTableView1IsDeleted: TcxGridDBColumn
        DataBinding.FieldName = 'IsDeleted'
        Width = 42
      end
      object cxGridDBTableView1IsUpdate: TcxGridDBColumn
        DataBinding.FieldName = 'IsUpdate'
        Width = 39
      end
      object cxGridDBTableView1Indice: TcxGridDBColumn
        DataBinding.FieldName = 'Indice'
        Width = 52
      end
      object cxGridDBTableView1FlatPromo: TcxGridDBColumn
        DataBinding.FieldName = 'FlatPromo'
        Width = 37
      end
      object cxGridDBTableView1DiscountLoyalt: TcxGridDBColumn
        DataBinding.FieldName = 'DiscountLoyalt'
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object chkTestPromo: TCheckBox
    Left = 840
    Top = 385
    Width = 97
    Height = 17
    Caption = 'chkTestPromo'
    TabOrder = 3
  end
  object cdsPromo: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPromo'
    Left = 36
    Top = 6
    object cdsPromoIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object cdsPromoPromo: TStringField
      FieldName = 'Promo'
      Size = 35
    end
    object cdsPromoPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object cdsPromoIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsPromoBarcode: TStringField
      FieldName = 'Barcode'
    end
    object cdsPromoQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
    object cdsPromoStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object cdsPromoEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object cdsPromoDaysOfWeek: TStringField
      FieldName = 'DaysOfWeek'
      Size = 14
    end
    object cdsPromoDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object cdsPromoDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object cdsPromoQtyPromoItem: TFloatField
      FieldName = 'QtyPromoItem'
    end
  end
  object cdsPromoItem: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDPromoItem'
        DataType = ftInteger
      end
      item
        Name = 'IDPromo'
        DataType = ftInteger
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
      end
      item
        Name = 'PromoType'
        DataType = ftInteger
      end
      item
        Name = 'DiscountType'
        DataType = ftInteger
      end
      item
        Name = 'DiscountValue'
        DataType = ftFloat
      end
      item
        Name = 'QtyPromoitem'
        Attributes = [faReadonly]
        DataType = ftFloat
      end
      item
        Name = 'FlatPromo'
        DataType = ftBoolean
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
      end
      item
        Name = 'Barcode'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QtyFrequent'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'cdsPromoItemIndex1'
        Fields = 'QtyPromoitem;DiscountValue'
        Options = [ixDescending]
      end>
    Params = <>
    ProviderName = 'dspPromoItem'
    StoreDefs = True
    Left = 31
    Top = 58
    object cdsPromoItemIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object cdsPromoItemIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object cdsPromoItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsPromoItemPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object cdsPromoItemDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object cdsPromoItemDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object cdsPromoItemQtyPromoitem: TFloatField
      FieldName = 'QtyPromoitem'
      ReadOnly = True
    end
    object cdsPromoItemFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
    object cdsPromoItemStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object cdsPromoItemEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object cdsPromoItemBarcode: TStringField
      FieldName = 'Barcode'
    end
    object cdsPromoItemQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
  end
  object cdsPromoPrizeItem: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDPromoPrizeItem'
        DataType = ftInteger
      end
      item
        Name = 'IDPromoItem'
        DataType = ftInteger
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
      end
      item
        Name = 'IDModelPromoItem'
        DataType = ftInteger
      end
      item
        Name = 'IDPromo'
        DataType = ftInteger
      end
      item
        Name = 'DiscountType'
        DataType = ftInteger
      end
      item
        Name = 'DiscountValue'
        DataType = ftFloat
      end
      item
        Name = 'QtyPromoItem'
        DataType = ftFloat
      end
      item
        Name = 'SellingPrice'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
      end
      item
        Name = 'PromoType'
        DataType = ftInteger
      end
      item
        Name = 'QtyFrequent'
        DataType = ftFloat
      end
      item
        Name = 'FlatPromo'
        DataType = ftBoolean
      end>
    IndexDefs = <
      item
        Name = 'cdsPromoPrizeItemIndex1'
        Fields = 'IDModel;SellingPrice'
      end
      item
        Name = 'cdsPromoPrizeItemIndex2'
        Fields = 'SellingPrice;IDModel'
        Options = [ixDescending]
      end>
    Params = <
      item
        DataType = ftString
        Name = 'StartDate'
        ParamType = ptInput
        Size = 10
      end
      item
        DataType = ftString
        Name = 'EndDate'
        ParamType = ptInput
        Size = 10
      end
      item
        DataType = ftString
        Name = 'DayOfWeek'
        ParamType = ptInput
        Size = 1
      end
      item
        DataType = ftString
        Name = 'StartDate'
        ParamType = ptInput
        Size = 10
      end
      item
        DataType = ftString
        Name = 'EndDate'
        ParamType = ptInput
        Size = 10
      end
      item
        DataType = ftString
        Name = 'DayOfWeek'
        ParamType = ptInput
        Size = 1
      end>
    ProviderName = 'dspPromoPrizeItem'
    StoreDefs = True
    Left = 36
    Top = 111
    object cdsPromoPrizeItemIDPromoPrizeItem: TIntegerField
      FieldName = 'IDPromoPrizeItem'
    end
    object cdsPromoPrizeItemIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object cdsPromoPrizeItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsPromoPrizeItemIDModelPromoItem: TIntegerField
      FieldName = 'IDModelPromoItem'
    end
    object cdsPromoPrizeItemIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object cdsPromoPrizeItemDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object cdsPromoPrizeItemDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object cdsPromoPrizeItemQtyPromoItem: TFloatField
      FieldName = 'QtyPromoItem'
    end
    object cdsPromoPrizeItemSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object cdsPromoPrizeItemStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object cdsPromoPrizeItemEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object cdsPromoPrizeItemPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object cdsPromoPrizeItemQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
    object cdsPromoPrizeItemFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
  end
  object dspPromo: TDataSetProvider
    DataSet = qryPromo
    Left = 140
    Top = 6
  end
  object dspPromoItem: TDataSetProvider
    DataSet = qryPromoItem
    Left = 140
    Top = 58
  end
  object dspPromoPrizeItem: TDataSetProvider
    DataSet = qryPromoPrizeItem
    Left = 140
    Top = 110
  end
  object qryPromo: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'StartDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 14
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPromo,'
      #9'P.Promo,'
      #9'P.PromoType,'
      #9'P.IDStore,'
      #9'P.Barcode,'
      #9'P.QtyFrequent,'
      #9'P.StartDate,'
      #9'P.EndDate,'
      #9'P.DaysOfWeek,'
      #9'P.DiscountType,'
      #9'P.DiscountValue,'
      #9'P.QtyPromoItem'
      'FROM'
      #9'Sal_Promo P (NOLOCK) '
      'WHERE'
      #9'P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0')
    Left = 244
    Top = 11
    object qryPromoIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object qryPromoPromo: TStringField
      FieldName = 'Promo'
      Size = 35
    end
    object qryPromoPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object qryPromoIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object qryPromoBarcode: TStringField
      FieldName = 'Barcode'
    end
    object qryPromoQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
    object qryPromoStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object qryPromoEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object qryPromoDaysOfWeek: TStringField
      FieldName = 'DaysOfWeek'
      Size = 14
    end
    object qryPromoDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object qryPromoDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object qryPromoQtyPromoItem: TFloatField
      FieldName = 'QtyPromoItem'
    end
  end
  object qryPromoItem: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'StartDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 14
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PI.IDPromoItem,'
      #9'PI.IDPromo,'
      #9'PI.IDModel,'
      #9'P.PromoType,'
      #9'P.DiscountType,'
      #9'P.DiscountValue,'
      '  IsNull(P.QtyPromoitem, 0) as QtyPromoitem,'
      #9'P.FlatPromo,'
      #9'P.StartDate,'
      #9'P.EndDate,'
      #9'P.Barcode,'
      '  QtyFrequent'
      'FROM'
      #9'Sal_PromoItem PI (NOLOCK) '
      #9'JOIN Sal_Promo P (NOLOCK) ON (PI.IDPromo = P.IDPromo)'
      'WHERE'
      #9'P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0')
    Left = 244
    Top = 58
    object qryPromoItemIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object qryPromoItemIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object qryPromoItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryPromoItemPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object qryPromoItemDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object qryPromoItemDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object qryPromoItemQtyPromoitem: TFloatField
      FieldName = 'QtyPromoitem'
      ReadOnly = True
    end
    object qryPromoItemFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
    object qryPromoItemStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object qryPromoItemEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object qryPromoItemBarcode: TStringField
      FieldName = 'Barcode'
    end
    object qryPromoItemQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
  end
  object qryPromoPrizeItem: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'StartDate'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'EndDate'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'StartDate'
        Size = -1
        Value = Null
      end
      item
        Name = 'EndDate'
        Size = -1
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PPI.IDPromoPrizeItem,'
      #9'PPI.IDPromoItem,'
      #9'PPI.IDModel,'
      #9'PI.IDModel IDModelPromoItem,'
      #9'P.IDPromo,'
      '  P.PromoType,'
      #9'P.DiscountType,'
      #9'P.DiscountValue,'
      #9'P.QtyPromoItem,'
      #9'M.SellingPrice,'
      '  P.FlatPromo,'
      #9'P.StartDate,'
      #9'P.EndDate,'
      '  P.QtyFrequent'
      'FROM'
      #9'Sal_PromoPrizeItem PPI (NOLOCK)'
      
        #9'JOIN Sal_PromoItem PI (NOLOCK) ON (PPI.IDPromoItem = PI.IDPromo' +
        'Item)'
      #9'JOIN Sal_Promo P (NOLOCK) ON (PI.IDPromo = P.IDPromo)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = PPI.IDModel)'
      'WHERE'
      #9'P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0'
      ''
      'UNION'
      ''
      'SELECT'
      #9'PI.IDPromoItem as IDPromoPrizeItem,'
      #9'PI.IDPromoItem,'
      #9'PI.IDModel,'
      #9'PI.IDModel IDModelPromoItem,'
      #9'PI.IDPromo,'
      '  P.PromoType,'
      #9'P.DiscountType,'
      #9'P.DiscountValue,'
      '  IsNull(P.QtyPromoitem, 0) as QtyPromoitem,'
      #9'M.SellingPrice,'
      #9'P.FlatPromo,'
      #9'P.StartDate,'
      #9'P.EndDate,'
      '  P.QtyFrequent'
      'FROM'
      #9'Sal_PromoItem PI (NOLOCK)'
      #9'JOIN Sal_Promo P (NOLOCK) ON (PI.IDPromo = P.IDPromo)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = PI.IDModel)'
      'WHERE'
      #9'P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0'
      '               AND P.FlatPromo = 1')
    Left = 244
    Top = 110
    object qryPromoPrizeItemIDPromoPrizeItem: TIntegerField
      FieldName = 'IDPromoPrizeItem'
    end
    object qryPromoPrizeItemIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object qryPromoPrizeItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryPromoPrizeItemIDModelPromoItem: TIntegerField
      FieldName = 'IDModelPromoItem'
    end
    object qryPromoPrizeItemIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object qryPromoPrizeItemDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object qryPromoPrizeItemDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object qryPromoPrizeItemQtyPromoItem: TFloatField
      FieldName = 'QtyPromoItem'
    end
    object qryPromoPrizeItemSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object qryPromoPrizeItemStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object qryPromoPrizeItemEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object qryPromoPrizeItemPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object qryPromoPrizeItemQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
    object qryPromoPrizeItemFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
  end
  object cdsPrizeItemList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 36
    Top = 272
    object cdsPrizeItemListIDPromoPrizeItem: TIntegerField
      FieldName = 'IDPromoPrizeItem'
    end
    object cdsPrizeItemListIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsPrizeItemListIDParentSaleItem: TIntegerField
      FieldName = 'IDParentSaleItem'
    end
    object cdsPrizeItemListDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object cdsPrizeItemListQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsPrizeItemListDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object cdsPrizeItemListIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object cdsPrizeItemListIDModelPromoItem: TIntegerField
      FieldName = 'IDModelPromoItem'
    end
    object cdsPrizeItemListIDInventoryMovParent: TIntegerField
      FieldName = 'IDInventoryMovParent'
    end
    object cdsPrizeItemListIDFrequentPromo: TIntegerField
      FieldName = 'IDFrequentPromo'
    end
    object cdsPrizeItemListQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
  end
  object cdsBestPrizeList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 119
    Top = 272
    object cdsBestPrizeListIDPromoPrizeItem: TIntegerField
      FieldName = 'IDPromoPrizeItem'
    end
    object cdsBestPrizeListIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsBestPrizeListDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object cdsBestPrizeListQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsBestPrizeListDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object cdsBestPrizeListIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object cdsBestPrizeListIDModelPromoItem: TIntegerField
      FieldName = 'IDModelPromoItem'
    end
  end
  object qryFrequentQty: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
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
    SQL.Strings = (
      'SELECT IsNull(SUM(fp.Qty), 0) as Qty'
      '   FROM Sal_FrequentPromo fp (NOLOCK)'
      '  WHERE fp.IsUsed = 0'
      '  AND fp.IDPessoa = :IDPessoa'
      '  AND fp.IDModel = :IDModel')
    Left = 609
    Top = 275
    object qryFrequentQtyQty: TBCDField
      FieldName = 'Qty'
      Precision = 32
    end
  end
  object cdsDiscountPromoQtyList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 226
    Top = 272
    object cdsDiscountPromoQtyListIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
    object cdsDiscountPromoQtyListIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object cdsDiscountPromoQtyListIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsDiscountPromoQtyListQty: TFloatField
      FieldName = 'Qty'
    end
  end
  object spquPreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    ProcedureName = 'sp_PreSale_quPreSaleItem;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@DocumentID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IsPreSale'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 272
    Top = 336
    object spquPreSaleItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object spquPreSaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object spquPreSaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object spquPreSaleItemSalePrice: TFloatField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemDiscActual: TFloatField
      FieldKind = fkCalculated
      FieldName = 'DiscActual'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleItemDiscount: TFloatField
      DisplayLabel = 'Disc.'
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object spquPreSaleItemTotalItem: TFloatField
      DisplayLabel = 'Total'
      FieldKind = fkCalculated
      FieldName = 'TotalItem'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleItemSalesPerson: TStringField
      FieldName = 'SalesPerson'
      Size = 50
    end
    object spquPreSaleItemIDComission: TIntegerField
      FieldName = 'IDComission'
    end
    object spquPreSaleItemCostPrice: TFloatField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemExchangeInvoice: TIntegerField
      FieldName = 'ExchangeInvoice'
    end
    object spquPreSaleItemSuggRetail: TFloatField
      DisplayLabel = 'MSRP'
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemSerialNumber: TBooleanField
      DisplayLabel = 'S/N'
      FieldName = 'SerialNumber'
    end
    object spquPreSaleItemIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object spquPreSaleItemTax: TFloatField
      DisplayLabel = 'Tax %'
      FieldName = 'Tax'
      DisplayFormat = '0.00'
    end
    object spquPreSaleItemSubTotalItem: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SubTotalItem'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleItemQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object spquPreSaleItemIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object spquPreSaleItemRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
    end
    object spquPreSaleItemPuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
    end
    object spquPreSaleItemPromo: TBooleanField
      FieldName = 'Promo'
    end
    object spquPreSaleItemIDMovParent: TIntegerField
      FieldName = 'IDMovParent'
      ReadOnly = True
    end
    object spquPreSaleItemDiscountLoyalt: TFloatField
      FieldName = 'DiscountLoyalt'
      ReadOnly = True
    end
  end
  object cdsSaleItems: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsSaleItemsIndex1'
        Fields = 'IDModel;Indice'
      end>
    IndexFieldNames = 'IDModel;Indice'
    Params = <>
    StoreDefs = True
    AfterPost = cdsSaleItemsAfterPost
    Left = 385
    Top = 220
    object cdsSaleItemsIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsSaleItemsIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object cdsSaleItemsIDInventoryMovParent: TIntegerField
      FieldName = 'IDInventoryMovParent'
    end
    object cdsSaleItemsIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object cdsSaleItemsPromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object cdsSaleItemsDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object cdsSaleItemsQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsSaleItemsSalePrice: TFloatField
      FieldName = 'SalePrice'
    end
    object cdsSaleItemsTotalDiscountApplied: TFloatField
      FieldName = 'TotalDiscountApplied'
    end
    object cdsSaleItemsInUse: TBooleanField
      FieldName = 'InUse'
    end
    object cdsSaleItemsIsPrize: TBooleanField
      FieldName = 'IsPrize'
    end
    object cdsSaleItemsIsNew: TBooleanField
      FieldName = 'IsNew'
    end
    object cdsSaleItemsIsDeleted: TBooleanField
      FieldName = 'IsDeleted'
    end
    object cdsSaleItemsIsUpdate: TBooleanField
      FieldName = 'IsUpdate'
    end
    object cdsSaleItemsIndice: TIntegerField
      FieldName = 'Indice'
    end
    object cdsSaleItemsIDComission: TIntegerField
      FieldName = 'IDComission'
    end
    object cdsSaleItemsIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsSaleItemsIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object cdsSaleItemsCostPrice: TFloatField
      FieldName = 'CostPrice'
    end
    object cdsSaleItemsFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
    object cdsSaleItemsDiscountLoyalt: TFloatField
      FieldName = 'DiscountLoyalt'
    end
    object cdsSaleItemsSumQty: TAggregateField
      FieldName = 'SumQty'
      Active = True
      Expression = 'Sum(Qty)'
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsSaleItems
    Left = 385
    Top = 268
  end
  object qryValidateSaleItemInPromo: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DocumentID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        DataType = ftString
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PI.IDModel, P.FlatPromo'
      #9'   FROM (SELECT DISTINCT ModelID'
      #9'    FROM PreInventoryMov (NOLOCK)'
      #9'  WHERE DocumentID = :DocumentID) PM'
      #9'JOIN Sal_PromoItem PI (NOLOCK)'
      #9'  ON PM.ModelID = PI.IDModel'
      #9'JOIN Sal_Promo P (NOLOCK)'
      #9'  ON (PI.IDPromo = P.IDPromo)'
      ' '#9'  AND P.StartDate <= :StartDate'
      #9'  AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'  AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'  AND P.System = 0'
      #9'  AND P.Hidden = 0'
      #9'  AND P.Desativado = 0'
      #9'GROUP BY PI.IDModel, P.FlatPromo')
    Left = 615
    Top = 53
    object qryValidateSaleItemInPromoIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryValidateSaleItemInPromoFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
  end
  object qryValidateSaleitemInPromoPrize: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DocumentID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DocumentID2'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        DataType = ftString
        Size = 20
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PPI.IDModel'
      '   FROM (SELECT DISTINCT ModelID'
      #9'    FROM PreInventoryMov (NOLOCK)'
      #9'  WHERE DocumentID = :DocumentID) PM'
      #9'join Sal_PromoPrizeItem PPI (NOLOCK)'
      #9'  ON PM.ModelID = PPI.IDModel'
      #9'JOIN Sal_PromoItem PI (NOLOCK)'
      #9'  ON (PPI.IDPromoItem = PI.IDPromoItem)'
      #9'JOIN (SELECT DISTINCT ModelID'
      '  '#9'      FROM PreInventoryMov (NOLOCK)'
      #9'       WHERE DocumentID = :DocumentID2) PM2'
      #9'  ON PPI.IDModel = PM2.ModelID'
      #9'JOIN Sal_Promo P (NOLOCK)'
      #9'  ON (PI.IDPromo = P.IDPromo)'
      ' '#9'  AND P.StartDate <= :StartDate'
      #9'  AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'  AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'  AND P.System = 0'
      #9'  AND P.Hidden = 0'
      #9'  AND P.Desativado = 0')
    Left = 456
    Top = 53
    object qryValidateSaleitemInPromoPrizeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object dspValidateSaleItemInPromo: TDataSetProvider
    DataSet = qryValidateSaleItemInPromo
    Left = 618
    Top = 102
  end
  object cdsValidateSaleItemInPromo: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'DocumentID'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftDateTime
        Name = 'StartDate'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftDateTime
        Name = 'EndDate'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftString
        Name = 'DayOfWeek'
        ParamType = ptInput
        Size = 20
      end>
    ProviderName = 'dspValidateSaleItemInPromo'
    StoreDefs = True
    Left = 622
    Top = 151
    object cdsValidateSaleItemInPromoIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsValidateSaleItemInPromoFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
  end
  object dspValidateSaleitemInPromoPrize: TDataSetProvider
    DataSet = qryValidateSaleitemInPromoPrize
    Left = 455
    Top = 100
  end
  object cdsValidateSaleitemInPromoPrize: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspValidateSaleitemInPromoPrize'
    Left = 460
    Top = 151
    object cdsValidateSaleitemInPromoPrizeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object dsclone: TDataSource
    DataSet = CdsSaleItemsClone
    Left = 470
    Top = 270
  end
  object CdsSaleItemsClone: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'ixIDModel'
        Fields = 'IDModel'
      end
      item
        Name = 'CdsSaleItemsCloneIndex2'
        Fields = 'SalePrice;IDModel'
        Options = [ixDescending]
      end>
    IndexName = 'ixIDModel'
    Params = <>
    StoreDefs = True
    Left = 480
    Top = 220
    object CdsSaleItemsCloneIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object CdsSaleItemsCloneIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object CdsSaleItemsCloneIDInventoryMovParent: TIntegerField
      FieldName = 'IDInventoryMovParent'
    end
    object CdsSaleItemsCloneIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object CdsSaleItemsClonePromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object CdsSaleItemsCloneDiscountType: TIntegerField
      FieldName = 'DiscountType'
    end
    object CdsSaleItemsCloneQty: TFloatField
      FieldName = 'Qty'
    end
    object CdsSaleItemsCloneSalePrice: TFloatField
      FieldName = 'SalePrice'
    end
    object CdsSaleItemsCloneSalePriceDiscount: TFloatField
      FieldName = 'SalePriceDiscount'
    end
    object CdsSaleItemsCloneInUse: TBooleanField
      FieldName = 'InUse'
    end
    object CdsSaleItemsCloneIsPrize: TBooleanField
      FieldName = 'IsPrize'
    end
    object CdsSaleItemsCloneIsNew: TBooleanField
      FieldName = 'IsNew'
    end
    object CdsSaleItemsCloneIsDeleted: TBooleanField
      FieldName = 'IsDeleted'
    end
    object CdsSaleItemsCloneIsUpdate: TBooleanField
      FieldName = 'IsUpdate'
    end
    object CdsSaleItemsCloneIndice: TIntegerField
      FieldName = 'Indice'
    end
    object CdsSaleItemsCloneIDComission: TIntegerField
      FieldName = 'IDComission'
    end
    object CdsSaleItemsCloneIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object CdsSaleItemsCloneIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object CdsSaleItemsCloneCostPrice: TFloatField
      FieldName = 'CostPrice'
    end
    object CdsSaleItemsCloneFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
    object CdsSaleItemsCloneDiscountLoyalt: TFloatField
      FieldName = 'DiscountLoyalt'
    end
    object cdsSaleItemsCloneSumQty: TAggregateField
      FieldName = 'SumQty'
      Active = True
      Expression = 'sum(Qty)'
    end
  end
  object qryItemTotal: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDSale'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 14
        Value = Null
      end
      item
        Name = 'IDPromo'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'#9'sum((pre.Qty * pre.SalePrice)-pre.Discount) as ItemTotal'
      'FROM'
      #9'Sal_PromoItem PI (NOLOCK) '
      #9'JOIN Sal_Promo P (NOLOCK)'
      #9'  ON (PI.IDPromo = P.IDPromo)'
      #9'JOIN PreInventoryMov pre (NOLOCK)'
      '    ON PI.IDModel =  pre.ModelID'
      #9'  AND DocumentID = :IDSale'
      'WHERE'
      #9'P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0'
      #9'AND PI.IDPromo = :IDPromo')
    Left = 435
    Top = 335
    object qryItemTotalItemTotal: TBCDField
      FieldName = 'ItemTotal'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
  end
  object qryFrequentQtySale: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DocumentID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 14
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PI.IDModel IDModelPromoItem,'
      #9'P.IDPromo,'
      #9'P.PromoType,'
      #9'P.DiscountValue,'
      #9'P.QtyFrequent,'
      #9'P.FlatPromo,'
      #9'P.QtyPromoItem'
      '   FROM Sal_PromoPrizeItem PPI (NOLOCK)'
      #9'JOIN Sal_PromoItem PI (NOLOCK)'
      #9'  ON (PPI.IDPromoItem = PI.IDPromoItem)'
      #9'JOIN Sal_Promo P (NOLOCK)'
      #9'  ON (PI.IDPromo = P.IDPromo)'
      #9'JOIN PreInventoryMov PIV'
      #9'  ON PPI.IDModel = PIV.ModelID'
      #9'  AND PIV.DocumentID = :DocumentID'
      '  WHERE P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0'
      #9'AND P.PromoType = 2'
      #9'AND P.DiscountType = 3')
    Left = 610
    Top = 325
    object qryFrequentQtySaleIDModelPromoItem: TIntegerField
      FieldName = 'IDModelPromoItem'
    end
    object qryFrequentQtySaleIDPromo: TIntegerField
      FieldName = 'IDPromo'
    end
    object qryFrequentQtySaleDiscountValue: TFloatField
      FieldName = 'DiscountValue'
    end
    object qryFrequentQtySaleQtyFrequent: TFloatField
      FieldName = 'QtyFrequent'
    end
    object qryFrequentQtySalePromoType: TIntegerField
      FieldName = 'PromoType'
    end
    object qryFrequentQtySaleFlatPromo: TBooleanField
      FieldName = 'FlatPromo'
    end
    object qryFrequentQtySaleQtyPromoItem: TFloatField
      FieldName = 'QtyPromoItem'
    end
  end
  object cdsItemsFrequentUse: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'IDModel'
    Params = <>
    Left = 605
    Top = 225
    object cdsItemsFrequentUseIDCustomer: TIntegerField
      FieldName = 'IDCustomer'
    end
    object cdsItemsFrequentUseIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsItemsFrequentUseQtyUsed: TFloatField
      FieldName = 'QtyUsed'
    end
  end
  object qryFrequentQtySalePromo: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DocumentID'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DayOfWeek'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 14
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PIV.IDPessoa, PI.IDModel,'
      #9'SUM(PIV.Qty) as Qty'
      '   FROM Sal_PromoItem PI (NOLOCK)'
      #9'JOIN Sal_Promo P (NOLOCK)'
      #9'  ON (PI.IDPromo = P.IDPromo)'
      #9'JOIN PreInventoryMov PIV (NOLOCK)'
      #9'  ON PI.IDModel = PIV.ModelID'
      #9'  AND PIV.DocumentID = :DocumentID'
      '  WHERE P.StartDate <= :StartDate'
      #9'AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)'
      #9'AND P.DaysOfWeek LIKE '#39'%'#39' + :DayOfWeek + '#39'%'#39
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.Desativado = 0'
      #9'AND P.PromoType = 2'
      #9'AND P.DiscountType = 3'
      'GROUP BY PIV.IDPessoa, PI.IDModel')
    Left = 750
    Top = 235
    object qryFrequentQtySalePromoIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryFrequentQtySalePromoQty: TBCDField
      FieldName = 'Qty'
      ReadOnly = True
      Precision = 32
    end
    object qryFrequentQtySalePromoIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
  end
end
