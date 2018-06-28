object FrmExportItems: TFrmExportItems
  Left = 291
  Top = 127
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exportar Protudos'
  ClientHeight = 491
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 460
    Width = 563
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object lbPath: TLabel
      Left = 7
      Top = 10
      Width = 30
      Height = 13
      Caption = 'lbPath'
    end
    object btnOk: TcxButton
      Left = 396
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Exportar'
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 476
      Top = 4
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Cancelar'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object PB: TProgressBar
      Left = 275
      Top = 10
      Width = 116
      Height = 16
      Step = 1
      TabOrder = 2
      Visible = False
    end
  end
  object grdItems: TcxGrid
    Left = 0
    Top = 0
    Width = 563
    Height = 460
    Align = alClient
    BevelOuter = bvNone
    BevelKind = bkTile
    TabOrder = 1
    LookAndFeel.Kind = lfFlat
    object grdItemsDB: TcxGridDBTableView
      DataController.DataSource = dsItems
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModel'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdItemsDBModelo: TcxGridDBColumn
        DataBinding.FieldName = 'Modelo'
        Width = 91
      end
      object grdItemsDBDescricao: TcxGridDBColumn
        DataBinding.FieldName = 'Descricao'
        Width = 181
      end
      object grdItemsDBUnidade: TcxGridDBColumn
        DataBinding.FieldName = 'Unidade'
        Width = 56
      end
      object grdItemsDBCodTrib: TcxGridDBColumn
        DataBinding.FieldName = 'CodTrib'
        Width = 69
      end
      object grdItemsDBSellingPrice: TcxGridDBColumn
        Caption = 'Prc. Venda'
        DataBinding.FieldName = 'SellingPrice'
        Width = 162
      end
    end
    object grdItemsLevel: TcxGridLevel
      GridView = grdItemsDB
    end
  end
  object quItems: TADODataSet
    Connection = FrmMain.Connection
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model Modelo,'#13#10#9'M.[Description] Descrica' +
      'o,'#13#10#9'CAST('#39'UN'#39' as char(2)) Unidade,'#13#10#9'CASE'#13#10#9#9'WHEN STG.IDSaleTax' +
      ' = 14 THEN '#39'T01'#39#13#10#9#9'WHEN STG.IDSaleTax IN (5, 17) THEN '#39'T02'#39#13#10#9#9 +
      'WHEN STG.IDSaleTax = 38 THEN  '#39'F01'#39#13#10#9'END CodTrib,'#13#10#9'M.SellingPr' +
      'ice'#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10#9'LEFT JOIN StoreToTabGroup STG ON ' +
      '(M.GroupID = STG.IDGroup AND STG.IDStore = 1)'#13#10'WHERE'#13#10#9'M.ModelTy' +
      'pe IN ('#39'R'#39', '#39'S'#39')'#13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.GroupID <> 1' +
      '00'
    CommandTimeout = 180
    Parameters = <>
    Left = 75
    Top = 130
    object quItemsModelo: TStringField
      FieldName = 'Modelo'
      Size = 30
    end
    object quItemsDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object quItemsUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
    object quItemsCodTrib: TStringField
      FieldName = 'CodTrib'
      ReadOnly = True
      Size = 3
    end
    object quItemsSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quItemsIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object dsItems: TDataSource
    DataSet = quItems
    Left = 75
    Top = 185
  end
end
