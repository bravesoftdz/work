inherited FrmDescriptionPrice: TFrmDescriptionPrice
  Left = 399
  Top = 189
  Width = 402
  Height = 368
  Caption = 'FrmDescriptionPrice'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 394
    inherited Image1: TImage
      Width = 167
    end
    inherited lblMenu: TLabel
      Left = 178
    end
    inherited EspacamentoSuperior: TPanel
      Width = 394
      inherited EEE: TPanel
        Width = 394
      end
    end
  end
  inherited Panel1: TPanel
    Top = 300
    Width = 394
    inherited EspacamentoInferior: TPanel
      Width = 394
      inherited Panel3: TPanel
        Width = 394
      end
    end
    inherited hhh: TPanel
      Left = 249
      Width = 145
      inherited btClose: TButton
        Left = 76
        Top = 4
        Cancel = True
        ModalResult = 2
      end
      object btSave: TButton
        Left = 4
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 260
  end
  inherited EspacamentoDireito: TPanel
    Left = 391
    Height = 260
  end
  object pnlButton: TPanelRights [4]
    Left = 287
    Top = 40
    Width = 104
    Height = 260
    Align = alRight
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 4
    object btRemove: TSpeedButton
      Tag = 7
      Left = 2
      Top = 29
      Width = 98
      Height = 26
      Caption = '&Remove'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btRemoveClick
    end
    object btAdd: TSpeedButton
      Tag = 7
      Left = 2
      Top = 3
      Width = 98
      Height = 26
      Caption = '&Add'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btAddClick
    end
  end
  object grdModelPrice: TcxGrid [5]
    Left = 3
    Top = 40
    Width = 284
    Height = 260
    Align = alClient
    TabOrder = 5
    LookAndFeel.Kind = lfFlat
    object grdModelPriceDBTableView: TcxGridDBTableView
      DataController.DataSource = dsDescriptionPrice
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdModelPriceDBTableViewIDDescriptionPrice: TcxGridDBColumn
        DataBinding.FieldName = 'IDDescriptionPrice'
        Visible = False
      end
      object grdModelPriceDBTableViewDescriptionPrice: TcxGridDBColumn
        Caption = 'Description'
        DataBinding.FieldName = 'DescriptionPrice'
      end
    end
    object grdModelPriceLevel: TcxGridLevel
      GridView = grdModelPriceDBTableView
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmDescriptionPrice.sil'
  end
  object dsDescriptionPrice: TDataSource
    DataSet = cdsDescriptionPrice
    Left = 196
    Top = 164
  end
  object cdsDescriptionPrice: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDescriptionPrice'
    Left = 196
    Top = 116
    object cdsDescriptionPriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object cdsDescriptionPriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
  end
  object dspDescriptionPrice: TDataSetProvider
    DataSet = qryDescriptionPrice
    Options = [poIncFieldProps]
    BeforeUpdateRecord = dspDescriptionPriceBeforeUpdateRecord
    Left = 196
    Top = 68
  end
  object qryDescriptionPrice: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'DP.IDDescriptionPrice,'
      #9'DP.DescriptionPrice'
      'FROM'
      #9'Inv_DescriptionPrice DP (NOLOCK) ')
    Left = 196
    Top = 20
    object qryDescriptionPriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object qryDescriptionPriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
  end
end
