inherited SubModelWebInfo: TSubModelWebInfo
  Left = 63
  Top = 164
  Width = 510
  Height = 223
  Caption = 'SubModelWebInfo'
  Color = clWhite
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFeatures: TPanel [0]
    Left = 248
    Top = 0
    Width = 254
    Height = 196
    Align = alRight
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object lbFeatures: TLabel
      Left = 4
      Top = 5
      Width = 386
      Height = 13
      Caption = 
        'Features                                                        ' +
        '                            '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16384
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbTechFeatures: TLabel
      Left = 2
      Top = 100
      Width = 381
      Height = 13
      Caption = 
        'Technical Features                                              ' +
        '                    _'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object grdFetaures: TcxGrid
      Left = 9
      Top = 20
      Width = 288
      Height = 79
      BorderStyle = cxcbsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      object grdFetauresDB: TcxGridDBTableView
        DataController.DataSource = dsFeatures
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDInvFeatures'
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
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdFetauresDBFeature: TcxGridDBColumn
          DataBinding.FieldName = 'Feature'
        end
      end
      object cxgrdFetaures: TcxGridLevel
        GridView = grdFetauresDB
      end
    end
    object grdTechFeatures: TcxGrid
      Left = 9
      Top = 115
      Width = 288
      Height = 87
      BorderStyle = cxcbsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = False
      object grdTechFeaturesDB: TcxGridDBTableView
        DataController.DataSource = dsTechFeature
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDInvTechFeatures'
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
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object cxGridDBTechFeature: TcxGridDBColumn
          DataBinding.FieldName = 'TechFeature'
        end
      end
      object cxgrdTechFeatures: TcxGridLevel
        GridView = grdTechFeaturesDB
      end
    end
  end
  object pgImage: TPageControl [1]
    Left = 0
    Top = 0
    Width = 248
    Height = 196
    ActivePage = tsImage1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tsImage1: TTabSheet
      Caption = 'Image 1'
      object SubListImage: TSubListPanel
        Left = 0
        Top = 0
        Width = 240
        Height = 165
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubModelImage'
      end
    end
    object tsImage2: TTabSheet
      Caption = 'Image 2'
      ImageIndex = 1
      object SubListImage2: TSubListPanel
        Left = 0
        Top = 0
        Width = 240
        Height = 165
        Align = alClient
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TSubModelImage'
      end
    end
  end
  object dsFeatures: TDataSource [2]
    DataSet = quFeatures
    Left = 222
    Top = 63
  end
  object quFeatures: TPowerADOQuery [3]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    AfterOpen = quFeaturesAfterOpen
    CommandText = 
      'SELECT '#13#10#9'F.IDInvFeatures,'#13#10#9'F.Feature'#13#10'FROM'#13#10#9'InvFeatures F (NO' +
      'LOCK)'#13#10'WHERE'#13#10#9'F.IDModel = :IDModel'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 225
    Top = 17
    object quFeaturesIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object quFeaturesFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object quTechFeature: TADOQuery [4]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quTechFeatureAfterOpen
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
      #9'F.IDInvTechFeatures,'
      #9'F.TechFeature'
      'FROM'
      #9'InvTechFeatures F (NOLOCK)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = F.IDModel)'
      'WHERE'
      #9'F.IDModel = :IDModel')
    Left = 222
    Top = 110
    object quTechFeatureIDInvTechFeatures: TIntegerField
      FieldName = 'IDInvTechFeatures'
    end
    object quTechFeatureTechFeature: TStringField
      FieldName = 'TechFeature'
      Size = 255
    end
  end
  object dsTechFeature: TDataSource [5]
    DataSet = quTechFeature
    Left = 220
    Top = 158
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubModelWebInfo.sil'
  end
end
