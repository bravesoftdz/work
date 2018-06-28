inherited FchPessoaHistoryType: TFchPessoaHistoryType
  Left = 141
  Top = 169
  Caption = 'History Type'
  ClientHeight = 309
  ClientWidth = 452
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 452
    inherited Image1: TImage
      Width = 178
    end
    inherited lblMenu: TLabel
      Left = 191
    end
    inherited EspacamentoSuperior: TPanel
      Width = 452
      inherited EEE: TPanel
        Width = 452
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 405
    end
  end
  inherited Panel1: TPanel
    Top = 268
    Width = 452
    inherited EspacamentoInferior: TPanel
      Width = 452
      inherited Panel3: TPanel
        Width = 452
      end
    end
    inherited hhh: TPanel
      Left = 231
    end
  end
  inherited pnlKey: TPanel
    Width = 452
    Height = 5
    inherited Panel4: TPanel
      Top = 3
      Width = 452
    end
  end
  inherited pnlDetail: TPanel
    Top = 45
    Width = 446
    Height = 223
    object Label1: TLabel
      Left = 27
      Top = 22
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'History Type :'
    end
    object lbHasBairro: TLabel
      Left = 352
      Top = 18
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
    object DBEdit1: TDBEdit
      Left = 100
      Top = 18
      Width = 249
      Height = 21
      DataField = 'PessoaHistoryType'
      DataSource = dsForm
      TabOrder = 0
    end
    object pnlHistoryAdd: TPanel
      Left = 362
      Top = 58
      Width = 84
      Height = 162
      BevelOuter = bvNone
      TabOrder = 1
      object btnHistoryAdd: TSpeedButton
        Left = 4
        Top = 4
        Width = 80
        Height = 24
        Caption = 'A&dd'
        Flat = True
        Glyph.Data = {
          B6020000424DB60200000000000036000000280000000D000000100000000100
          18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
          D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
          DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
          D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
          FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
          7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
          FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
          E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
          EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
          FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
          8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
          FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
          F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
          FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
          7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
          F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
          E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
          9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
        Margin = 5
        OnClick = btnHistoryAddClick
      end
      object btnResultDelete: TSpeedButton
        Left = 4
        Top = 28
        Width = 80
        Height = 24
        Caption = '&Remove'
        Flat = True
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        Margin = 5
        OnClick = btnResultDeleteClick
      end
    end
    object grdTypeResult: TcxGrid
      Left = 19
      Top = 62
      Width = 345
      Height = 162
      TabOrder = 2
      LookAndFeel.Kind = lfFlat
      object grdTypeResultDB: TcxGridDBTableView
        DataController.DataSource = dsTrypeResult
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPessoaHistoryResult'
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
        object grdTypeResultDBPessoaHistoryResult: TcxGridDBColumn
          Caption = 'Result'
          DataBinding.FieldName = 'PessoaHistoryResult'
          OnCustomDrawCell = grdTypeResultDBPessoaHistoryResultCustomDrawCell
          Width = 266
        end
        object grdTypeResultDBResultColor: TcxGridDBColumn
          Caption = 'Color'
          DataBinding.FieldName = 'ResultColor'
          Visible = False
          Width = 77
        end
      end
      object grdTypeResultLevel: TcxGridLevel
        GridView = grdTypeResultDB
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 45
    Height = 223
  end
  inherited EspacamentoDireito: TPanel
    Left = 449
    Top = 45
    Height = 223
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPessoaHistoryType.sil'
  end
  inherited dsForm: TDataSource
    Left = 36
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'IDPessoaHistoryType,'#13#10#9'PessoaHistoryType'#13#10'FROM'#13#10#9'Mnt_Pe' +
      'ssoaHistoryType'#13#10'WHERE'#13#10#9'IDPessoaHistoryType = :IDPessoaHistoryT' +
      'ype'
    Parameters = <
      item
        Name = 'IDPessoaHistoryType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 36
    object quFormIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quFormPessoaHistoryType: TStringField
      FieldName = 'PessoaHistoryType'
      Required = True
      Size = 30
    end
  end
  object dsTrypeResult: TDataSource [9]
    DataSet = quTypeResult
    OnStateChange = dsFormStateChange
    Left = 220
    Top = 124
  end
  object quTypeResult: TADODataSet [10]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IDPessoaHistoryResult,'#13#10#9'IDPessoaHistoryType,'#13#10#9'PessoaH' +
      'istoryResult,'#13#10#9'ResultColor'#13#10'FROM'#13#10#9'Mnt_PessoaHistoryResult'#13#10'WHE' +
      'RE'#13#10#9'IDPessoaHistoryType = :IDPessoaHistoryType'#13#10
    Parameters = <
      item
        Name = 'IDPessoaHistoryType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 219
    Top = 177
    object quTypeResultIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quTypeResultIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quTypeResultPessoaHistoryResult: TStringField
      DisplayLabel = 'Result'
      FieldName = 'PessoaHistoryResult'
      Size = 30
    end
    object quTypeResultResultColor: TStringField
      DisplayLabel = 'Color'
      FieldName = 'ResultColor'
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    AutoIncField = 'IDPessoaHistoryType'
    RequiredFields.Strings = (
      'PessoaHistoryType')
    DependentTables.Strings = (
      'Mnt_PessoaHistoryResult')
    DependentTableKeys.Strings = (
      'IDPessoaHistoryType')
    Left = 36
  end
end
