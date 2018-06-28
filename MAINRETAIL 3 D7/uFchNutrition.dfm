inherited FchNutrition: TFchNutrition
  Left = 36
  Top = 120
  Caption = 'FchNutrition'
  ClientHeight = 391
  ClientWidth = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 414
    inherited Image1: TImage
      Width = 140
    end
    inherited lblMenu: TLabel
      Left = 153
    end
    inherited EspacamentoSuperior: TPanel
      Width = 414
      inherited EEE: TPanel
        Width = 414
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 367
    end
  end
  inherited Panel1: TPanel
    Top = 350
    Width = 414
    inherited EspacamentoInferior: TPanel
      Width = 414
      inherited Panel3: TPanel
        Width = 414
      end
    end
    inherited hhh: TPanel
      Left = 193
    end
  end
  inherited pnlKey: TPanel
    Width = 414
    Height = 6
    inherited Panel4: TPanel
      Top = 4
      Width = 414
    end
  end
  inherited pnlDetail: TPanel
    Top = 46
    Width = 408
    Height = 304
    object Label43: TLabel
      Left = 295
      Top = 13
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnAddNutri: TSpeedButton
      Left = 325
      Top = 44
      Width = 82
      Height = 24
      Caption = '&Add'
      Flat = True
      Margin = 6
      OnClick = btnAddNutriClick
    end
    object lbDescription: TLabel
      Left = 25
      Top = 17
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Description :'
      FocusControl = DBEdit2
    end
    object lbNutItem: TLabel
      Left = 13
      Top = 49
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nut.Item/Size :'
      FocusControl = DBEdit2
    end
    object DBEdit2: TDBEdit
      Left = 88
      Top = 12
      Width = 206
      Height = 21
      DataField = 'Description'
      DataSource = dsForm
      TabOrder = 0
    end
    object pnlVendorList: TPanel
      Left = 0
      Top = 75
      Width = 408
      Height = 229
      Align = alBottom
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 1
      object btnRemoveNutri: TSpeedButton
        Left = 326
        Top = 18
        Width = 82
        Height = 24
        Caption = '&Remove'
        Flat = True
        Margin = 6
        OnClick = btnRemoveNutriClick
      end
      object btnModelNutriUP: TSpeedButton
        Left = 326
        Top = 42
        Width = 82
        Height = 24
        Caption = 'Up'
        Flat = True
        Margin = 5
        OnClick = btnModelNutriUPClick
      end
      object btnModelNutriDown: TSpeedButton
        Left = 326
        Top = 67
        Width = 82
        Height = 24
        Caption = 'Down'
        Flat = True
        Margin = 5
        OnClick = btnModelNutriDownClick
      end
      object pnlNutritionItem: TPanel
        Left = 0
        Top = 0
        Width = 408
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Nutrition Item'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object grdNutritionItem: TcxGrid
        Left = 3
        Top = 16
        Width = 322
        Height = 213
        TabOrder = 1
        LookAndFeel.Kind = lfStandard
        object grdNutritionItemDB: TcxGridDBTableView
          DataController.DataSource = dsNutritionItem
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDNutritionItem'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          object grdNutritionItemDBFieldPos: TcxGridDBColumn
            Caption = 'Pos'
            DataBinding.FieldName = 'FieldPos'
            Width = 43
          end
          object grdNutritionItemDBDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 212
          end
          object grdNutritionItemDBFieldLength: TcxGridDBColumn
            Caption = 'Length'
            DataBinding.FieldName = 'FieldLength'
            Width = 63
          end
        end
        object grdNutritionItemLvl: TcxGridLevel
          GridView = grdNutritionItemDB
        end
      end
    end
    object edtNutItem: TEdit
      Left = 90
      Top = 45
      Width = 140
      Height = 21
      TabOrder = 2
    end
    object edtNutSize: TEdit
      Left = 233
      Top = 45
      Width = 46
      Height = 21
      TabOrder = 3
      Text = '5'
    end
    object UpDownItemSize: TUpDown
      Left = 279
      Top = 45
      Width = 15
      Height = 21
      Associate = edtNutSize
      Position = 5
      TabOrder = 4
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 46
    Height = 304
  end
  inherited EspacamentoDireito: TPanel
    Left = 411
    Top = 46
    Height = 304
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchNutrition.sil'
  end
  inherited dsForm: TDataSource
    Left = 376
    Top = 46
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforeClose = quFormBeforeClose
    CommandText = 
      'SELECT'#13#10'        IDNutrition,'#13#10'        Description'#13#10'FROM'#13#10'       ' +
      ' Inv_Nutrition'#13#10'WHERE'#13#10'        IDNutrition = :IDNutrition'
    Parameters = <
      item
        Name = 'IDNutrition'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 376
    Top = 102
    object quFormIDNutrition: TIntegerField
      FieldName = 'IDNutrition'
    end
    object quFormDescription: TStringField
      FieldName = 'Description'
      Required = True
      Size = 50
    end
  end
  object quNutritionItem: TADODataSet [9]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10'       IDNutritionItem,'#13#10'       IDNutrition,'#13#10'       De' +
      'scription,'#13#10'       FieldLength,'#13#10'       FieldPos             '#13#10'F' +
      'ROM'#13#10'       Inv_NutritionItem'#9#13#10'WHERE '#13#10'       IDNutrition = :ID' +
      'Nutrition'#13#10'ORDER BY'#13#10'       FieldPos '
    Parameters = <
      item
        Name = 'IDNutrition'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 353
    Top = 236
    object quNutritionItemIDNutritionItem: TIntegerField
      FieldName = 'IDNutritionItem'
    end
    object quNutritionItemIDNutrition: TIntegerField
      FieldName = 'IDNutrition'
    end
    object quNutritionItemDescription: TStringField
      FieldName = 'Description'
      Size = 100
    end
    object quNutritionItemFieldLength: TIntegerField
      FieldName = 'FieldLength'
    end
    object quNutritionItemFieldPos: TIntegerField
      FieldName = 'FieldPos'
    end
  end
  object dsNutritionItem: TDataSource [10]
    DataSet = quNutritionItem
    Left = 353
    Top = 291
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    AutoIncField = 'IDNutrition'
    DependentTables.Strings = (
      'Inv_NutritionItem')
    DependentTableKeys.Strings = (
      'IDNutrition')
    Left = 331
    Top = 44
  end
end
