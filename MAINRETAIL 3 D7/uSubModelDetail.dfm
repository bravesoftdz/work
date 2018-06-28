inherited SubModelDetail: TSubModelDetail
  Left = 283
  Top = 464
  Width = 754
  Height = 302
  Caption = 'SubModelDetail'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel [0]
    Left = 0
    Top = 0
    Width = 746
    Height = 16
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Informations about select model and vendor'
    Color = clBtnShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object pcModel: TPageControl [1]
    Left = 0
    Top = 16
    Width = 746
    Height = 259
    ActivePage = tsModel
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpBottom
    OnChange = pcModelChange
    object tsModel: TTabSheet
      Caption = 'Cost, Retail, Quantities'
      object pnlQuantity: TPanel
        Left = 368
        Top = 0
        Width = 370
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlQuantity'
        Color = 14607076
        TabOrder = 0
        object SubListQty: TSubListPanel
          Left = 0
          Top = 0
          Width = 370
          Height = 233
          Align = alClient
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 0
          SubListClassName = 'TSubStoreQty'
        end
      end
      object pnlCost: TPanel
        Left = 0
        Top = 0
        Width = 183
        Height = 233
        Align = alLeft
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 1
        object Label17: TLabel
          Left = 49
          Top = 26
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cost :'
          FocusControl = editNetCost
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 3
          Top = 46
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = 'Other Charges :'
          FocusControl = editOtherCost
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 40
          Top = 66
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = 'Freight :'
          FocusControl = editFreightCost
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 26
          Top = 108
          Width = 55
          Height = 13
          Alignment = taRightJustify
          Caption = 'Avg cost :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape1: TShape
          Left = 5
          Top = 85
          Width = 175
          Height = 3
          Brush.Color = clNavy
          Pen.Style = psClear
        end
        object Label22: TLabel
          Left = 163
          Top = 44
          Width = 13
          Height = 18
          Hint = 'Campo de preenchimento Obrigat'#243'rio !'
          Caption = '+'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object Label23: TLabel
          Left = 163
          Top = 65
          Width = 13
          Height = 18
          Hint = 'Campo de preenchimento Obrigat'#243'rio !'
          Caption = '+'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object Label24: TLabel
          Left = 163
          Top = 23
          Width = 13
          Height = 18
          Hint = 'Campo de preenchimento Obrigat'#243'rio !'
          Caption = '+'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object Label25: TLabel
          Left = 163
          Top = 87
          Width = 13
          Height = 18
          Caption = '='
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object editNetCost: TDBText
          Left = 85
          Top = 26
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'VendorCost'
          DataSource = dsModel
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object editOtherCost: TDBText
          Left = 85
          Top = 46
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'OtherCost'
          DataSource = dsModel
        end
        object editFreightCost: TDBText
          Left = 85
          Top = 66
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'FreightCost'
          DataSource = dsModel
        end
        object DBEdit4: TDBText
          Left = 85
          Top = 90
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'FinalCost'
          DataSource = dsModel
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 31
          Top = 5
          Width = 50
          Height = 13
          Alignment = taRightJustify
          Caption = 'Last cost :'
          FocusControl = DBText4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DBText4: TDBText
          Left = 85
          Top = 5
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'LastCost'
          DataSource = dsModel
        end
        object lbTotal: TLabel
          Left = 46
          Top = 91
          Width = 35
          Height = 13
          Alignment = taRightJustify
          Caption = 'Total :'
          FocusControl = DBEdit4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbReplacCost: TLabel
          Left = 4
          Top = 125
          Width = 77
          Height = 13
          Alignment = taRightJustify
          Caption = 'Custom Cost :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBText5: TDBText
          Left = 84
          Top = 107
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'AvgCost'
          DataSource = dsModel
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBText6: TDBText
          Left = 84
          Top = 125
          Width = 74
          Height = 16
          Alignment = taRightJustify
          DataField = 'ReplacementCost'
          DataSource = dsModel
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object pnlRetail: TPanel
        Left = 187
        Top = 0
        Width = 177
        Height = 233
        Align = alLeft
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 2
        object Label21: TLabel
          Left = 3
          Top = 65
          Width = 82
          Height = 13
          Alignment = taRightJustify
          Caption = 'Markup percent :'
          FocusControl = DBEdit13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 27
          Top = 91
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Our Price :'
          FocusControl = DBEdit6
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape2: TShape
          Left = 4
          Top = 85
          Width = 169
          Height = 3
          Brush.Color = clNavy
          Pen.Style = psClear
        end
        object Label27: TLabel
          Left = 156
          Top = 88
          Width = 13
          Height = 18
          Caption = '='
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object DBEdit13: TDBText
          Left = 87
          Top = 65
          Width = 64
          Height = 16
          Alignment = taRightJustify
          DataField = 'RealMarkUpPercet'
          DataSource = dsModel
        end
        object DBEdit6: TDBText
          Left = 87
          Top = 91
          Width = 64
          Height = 16
          Alignment = taRightJustify
          DataField = 'SellingPrice'
          DataSource = dsModel
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 14
          Top = 45
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Caption = 'Markup value :'
          FocusControl = DBText1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DBText1: TDBText
          Left = 87
          Top = 45
          Width = 64
          Height = 16
          Alignment = taRightJustify
          DataField = 'RealMarkUpValue'
          DataSource = dsModel
        end
        object Label2: TLabel
          Left = 156
          Top = 43
          Width = 13
          Height = 18
          Caption = '+'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
        end
        object Label5: TLabel
          Left = 20
          Top = 25
          Width = 65
          Height = 13
          Alignment = taRightJustify
          Caption = 'Sugg. Retail :'
          FocusControl = DBText3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DBText3: TDBText
          Left = 87
          Top = 25
          Width = 64
          Height = 16
          Alignment = taRightJustify
          DataField = 'SuggRetail'
          DataSource = dsModel
        end
        object lbCaseQty: TLabel
          Left = 54
          Top = 4
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Case :'
          FocusControl = DBText2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBtnShadow
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DBText2: TDBText
          Left = 87
          Top = 4
          Width = 64
          Height = 16
          Alignment = taRightJustify
          DataField = 'CaseQty'
          DataSource = dsModel
        end
      end
      object pnlFrameRequest_fdskjfhg: TPanel
        Left = 364
        Top = 0
        Width = 4
        Height = 233
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
      end
      object pnlFrameRequest_fdjkswf: TPanel
        Left = 183
        Top = 0
        Width = 4
        Height = 233
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 4
      end
    end
    object tsPurchaseHistory: TTabSheet
      Caption = 'Purchase History'
      ImageIndex = 8
      object SubListPurHistory: TSubListPanel
        Left = 0
        Top = 0
        Width = 738
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubPurchaseHistory'
      end
    end
    object tsSaleHistory: TTabSheet
      Caption = 'Sales History'
      object SubListSalesHistory: TSubListPanel
        Left = 0
        Top = 0
        Width = 738
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubSaleHistory'
      end
    end
    object tsInventoryMov: TTabSheet
      Caption = 'Movement History'
      object SubListMovHistory: TSubListPanel
        Left = 0
        Top = 0
        Width = 738
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubMovHistory'
      end
    end
    object tsInventoryMovTotal: TTabSheet
      Caption = 'Movement Totals'
      object SubListMovTotal: TSubListPanel
        Left = 0
        Top = 0
        Width = 738
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubMovTotal'
      end
    end
    object tsOrder: TTabSheet
      Caption = 'Orders'
      object SubListOrderHistory: TSubListPanel
        Left = 0
        Top = 0
        Width = 738
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubOrderHistory'
      end
    end
    object tsVendorHistory: TTabSheet
      Caption = 'Vendor History'
      object SubListVendor: TSubListPanel
        Left = 0
        Top = 0
        Width = 738
        Height = 233
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubVendorHistory'
      end
    end
  end
  object quModel: TADOQuery [2]
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    AfterOpen = quModelAfterOpen
    OnCalcFields = quModelCalcFields
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        IDModel,'
      '        FreightCost,'
      '        OtherCost,'
      '        VendorCost,'
      '        DateLastCost,'
      '        MarkUp,'
      '        AvgCost,'
      '        SuggRetail,'
      '        SellingPrice,'
      '        DateLastSellingPrice,'
      '        LastCost,'
      '        ReplacementCost,'
      '        TotQtyOnHand,'
      '        CaseQty'
      'FROM'
      '        Model Model (NOLOCK)'
      'WHERE'
      '        IDModel = :IDModel'
      ' '
      ' ')
    Left = 75
    Top = 16
    object quModelRealMarkUpPercet: TFloatField
      FieldKind = fkCalculated
      FieldName = 'RealMarkUpPercet'
      DisplayFormat = '% 0.00'
      EditFormat = '0.00'
      Calculated = True
    end
    object quModelRealMarkUpValue: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'RealMarkUpValue'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quModelIDModel: TIntegerField
      FieldName = 'IDModel'
      Origin = 'Model.IDModel'
    end
    object quModelFreightCost: TFloatField
      FieldName = 'FreightCost'
      Origin = 'Model.FreightCost'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quModelOtherCost: TFloatField
      FieldName = 'OtherCost'
      Origin = 'Model.OtherCost'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quModelVendorCost: TFloatField
      FieldName = 'VendorCost'
      Origin = 'Model.VendorCost'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quModelDateLastCost: TDateTimeField
      FieldName = 'DateLastCost'
      Origin = 'Model.DateLastCost'
      DisplayFormat = '#,##0.00'
      EditMask = '!99/99/00;1;_'
    end
    object quModelMarkUp: TFloatField
      FieldName = 'MarkUp'
      Origin = 'Model.MarkUp'
      DisplayFormat = '0.00%'
    end
    object quModelSellingPrice: TFloatField
      FieldName = 'SellingPrice'
      Origin = 'Model.SellingPrice'
      DisplayFormat = '#,##0.00##'
      currency = True
    end
    object quModelDateLastSellingPrice: TDateTimeField
      FieldName = 'DateLastSellingPrice'
      Origin = 'Model.DateLastSellingPrice'
      DisplayFormat = 'mm/dd/yy'
      EditMask = '!99/99/00;1;_'
    end
    object quModelLastCost: TFloatField
      FieldName = 'LastCost'
      Origin = 'Model.IDModel'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quModelSuggRetail: TFloatField
      FieldName = 'SuggRetail'
      Origin = 'Model.IDModel'
      DisplayFormat = '#,##0.00'
    end
    object quModelAvgCost: TBCDField
      FieldName = 'AvgCost'
      Precision = 19
    end
    object quModelReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quModelFinalCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'FinalCost'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quModelTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      DisplayFormat = '0.#####'
    end
    object quModelCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
  end
  object dsModel: TDataSource [3]
    DataSet = quModel
    Left = 135
    Top = 21
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubModelDetail.sil'
  end
end
