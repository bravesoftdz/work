inherited FrmMarginTableUpdate: TFrmMarginTableUpdate
  Left = 0
  Top = 14
  Width = 778
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'MarginTableUpdate'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 762
    inherited Image1: TImage
      Width = 535
    end
    inherited lblMenu: TLabel
      Left = 554
    end
    inherited EspacamentoSuperior: TPanel
      Width = 762
      inherited EEE: TPanel
        Width = 762
      end
    end
  end
  inherited Panel1: TPanel
    Width = 762
    inherited EspacamentoInferior: TPanel
      Width = 762
      inherited Panel3: TPanel
        Width = 762
      end
    end
    inherited hhh: TPanel
      Left = 619
      Width = 143
      inherited btClose: TButton
        Left = 74
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btSave: TButton
        Left = 4
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited EspacamentoDireito: TPanel
    Left = 759
  end
  object grdMarginTableUp: TcxGrid [4]
    Left = 3
    Top = 40
    Width = 656
    Height = 333
    Align = alClient
    TabOrder = 4
    object grdMarginTableUpDBTableView1: TcxGridDBTableView
      DataController.DataSource = dsMarginTableUpdate
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModel'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdMarginTableUpDBTableView1IsUpdate: TcxGridDBColumn
        DataBinding.FieldName = 'IsUpdate'
        Width = 76
      end
      object grdMarginTableUpDBTableView1Model: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Visible = False
      end
      object grdMarginTableUpDBTableView1Description: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Width = 245
      end
      object grdMarginTableUpDBTableView1CostPrice: TcxGridDBColumn
        DataBinding.FieldName = 'CostPrice'
        Width = 109
      end
      object grdMarginTableUpDBTableView1NewSellingPrice: TcxGridDBColumn
        DataBinding.FieldName = 'NewSellingPrice'
        Width = 119
      end
      object grdMarginTableUpDBTableView1NewMSRPPrice: TcxGridDBColumn
        DataBinding.FieldName = 'NewMSRPPrice'
        Width = 113
      end
      object grdMarginTableUpDBTableView1SalePrice: TcxGridDBColumn
        Caption = 'Old SalePrice'
        DataBinding.FieldName = 'SalePrice'
        Visible = False
      end
      object grdMarginTableUpDBTableView1MSRP: TcxGridDBColumn
        Caption = 'Old MSRP'
        DataBinding.FieldName = 'MSRP'
        Visible = False
      end
      object grdMarginTableUpDBTableView1RealMarkUpValue: TcxGridDBColumn
        DataBinding.FieldName = 'RealMarkUpValue'
        Visible = False
      end
      object grdMarginTableUpDBTableView1RealMarkUpPercent: TcxGridDBColumn
        DataBinding.FieldName = 'RealMarkUpPercent'
        Visible = False
      end
      object grdMarginTableUpDBTableView1MarginPercent: TcxGridDBColumn
        DataBinding.FieldName = 'MarginPercent'
        Visible = False
      end
      object grdMarginTableUpDBTableView1MarginValue: TcxGridDBColumn
        DataBinding.FieldName = 'MarginValue'
        Visible = False
      end
      object grdMarginTableUpDBTableView1Category: TcxGridDBColumn
        DataBinding.FieldName = 'Category'
        Visible = False
      end
      object grdMarginTableUpDBTableView1SubCategory: TcxGridDBColumn
        DataBinding.FieldName = 'SubCategory'
        Visible = False
      end
      object grdMarginTableUpDBTableView1ModelGroup: TcxGridDBColumn
        DataBinding.FieldName = 'ModelGroup'
        Visible = False
      end
      object grdMarginTableUpDBTableView1MarkUp: TcxGridDBColumn
        DataBinding.FieldName = 'MarkUp'
      end
    end
    object grdMarginTableUpLevel1: TcxGridLevel
      GridView = grdMarginTableUpDBTableView1
    end
  end
  object Panel4: TPanel [5]
    Left = 659
    Top = 40
    Width = 100
    Height = 333
    Align = alRight
    TabOrder = 5
    object BitBtn1: TBitBtn
      Left = 3
      Top = 4
      Width = 92
      Height = 25
      Caption = 'Seletc All'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 3
      Top = 31
      Width = 92
      Height = 25
      Caption = 'UnSelect'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object pnlDivisoria2: TPanel
      Left = 4
      Top = 59
      Width = 92
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 2
    end
    object btnColumns: TBitBtn
      Left = 3
      Top = 63
      Width = 92
      Height = 25
      Caption = 'Columns'
      TabOrder = 3
      OnClick = btnColumnsClick
    end
  end
  object dsMarginTableUpdate: TDataSource [6]
    DataSet = cdsMarginTableUpdate
    Left = 380
    Top = 124
  end
  object cmdUpdateModel: TADOCommand [7]
    CommandText = 
      'UPDATE'#13#10#9'Model'#13#10'SET'#13#10#9'SellingPrice = :NewSellingPrice,'#13#10#9'SuggRet' +
      'ail = :NewMSRPPrice,'#13#10#9'DateLastSellingPrice = IsNull(:DateLastSe' +
      'llingPrice, DateLastSellingPrice),'#13#10#9'IDUserLastSellingPrice = Is' +
      'Null(:IDUserLastSellingPrice, IDUserLastSellingPrice)'#13#10'WHERE'#13#10#9'I' +
      'DModel = :IDModel'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'NewSellingPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewMSRPPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'DateLastSellingPrice'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDUserLastSellingPrice'
        Attributes = [paSigned, paNullable]
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
    Left = 380
    Top = 180
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmMarginTableUpdate.sil'
  end
  object cdsMarginTableUpdate: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 380
    Top = 80
    object cdsMarginTableUpdateIsUpdate: TBooleanField
      FieldName = 'IsUpdate'
    end
    object cdsMarginTableUpdateModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginTableUpdateDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsMarginTableUpdateIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object cdsMarginTableUpdateCostPrice: TBCDField
      FieldName = 'CostPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsMarginTableUpdateNewSellingPrice: TBCDField
      FieldName = 'NewSellingPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsMarginTableUpdateNewMSRPPrice: TBCDField
      FieldName = 'NewMSRPPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsMarginTableUpdateSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginTableUpdateMSRP: TBCDField
      FieldName = 'MSRP'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginTableUpdateRealMarkUpValue: TBCDField
      FieldName = 'RealMarkUpValue'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginTableUpdateRealMarkUpPercent: TBCDField
      FieldName = 'RealMarkUpPercent'
      ReadOnly = True
      DisplayFormat = '#,##0.00%'
      Precision = 19
    end
    object cdsMarginTableUpdateMarginPercent: TBCDField
      FieldName = 'MarginPercent'
      ReadOnly = True
      DisplayFormat = '#,##0.00%'
      Precision = 19
    end
    object cdsMarginTableUpdateMarginValue: TBCDField
      FieldName = 'MarginValue'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMarginTableUpdateCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginTableUpdateSubCategory: TStringField
      FieldName = 'SubCategory'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginTableUpdateModelGroup: TStringField
      FieldName = 'ModelGroup'
      ReadOnly = True
      Size = 30
    end
    object cdsMarginTableUpdateMarkUp: TBCDField
      FieldName = 'MarkUp'
      ReadOnly = True
      DisplayFormat = '#,##0.00%'
      Precision = 19
    end
  end
end
