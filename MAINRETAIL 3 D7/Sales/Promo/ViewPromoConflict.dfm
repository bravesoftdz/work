object vwPromoConflict: TvwPromoConflict
  Left = 375
  Top = 111
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tag Selected:'
  ClientHeight = 507
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbTagSelected: TLabel
    Left = 421
    Top = 22
    Width = 161
    Height = 16
    Caption = 'Models Conflict With Tags: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbModelsToTagSelected: TLabel
    Left = 10
    Top = 20
    Width = 144
    Height = 16
    Caption = 'Models to Tag Selected'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 11
    Top = 223
    Width = 173
    Height = 16
    Caption = 'Models Conflict With Promos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object cxGridModelsInTag: TcxGrid
    Left = 10
    Top = 40
    Width = 401
    Height = 151
    TabOrder = 0
    object cxGridModelsInTagDBTableView1: TcxGridDBTableView
      DataController.DataSource = dsModels
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      object cxGridModelsInTagDBTableView1DBColumn1: TcxGridDBColumn
        DataBinding.FieldName = 'IdTag'
        Visible = False
      end
      object cxGridModelsInTagDBTableView1DBColumn2: TcxGridDBColumn
        Caption = 'Tag Name'
        DataBinding.FieldName = 'TagName'
        Visible = False
        GroupIndex = 0
        SortOrder = soAscending
      end
      object cxGridModelsInTagDBTableView1DBColumn3: TcxGridDBColumn
        Caption = 'Model'
        DataBinding.FieldName = 'model'
      end
      object cxGridModelsInTagDBTableView1DBColumn4: TcxGridDBColumn
        Caption = 'Model Description'
        DataBinding.FieldName = 'Description'
      end
    end
    object cxGridModelsInTagLevel1: TcxGridLevel
      GridView = cxGridModelsInTagDBTableView1
    end
  end
  object btnFixTagConfllict: TButton
    Left = 495
    Top = 197
    Width = 146
    Height = 25
    Caption = 'Fix Tag Conflict'
    TabOrder = 1
    Visible = False
    OnClick = btnFixTagConfllictClick
  end
  object btnSolvePromoConflict: TButton
    Left = 355
    Top = 470
    Width = 91
    Height = 25
    Caption = 'Fix Conflicts'
    TabOrder = 2
    OnClick = btnSolvePromoConflictClick
  end
  object cxGridTagConflict: TcxGrid
    Left = 420
    Top = 40
    Width = 351
    Height = 151
    TabOrder = 3
    object cxGridDBTagConflict: TcxGridDBTableView
      DataController.DataSource = dsTagConflict
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ExpandMasterRowOnDblClick = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      object cxGridDBColumn1: TcxGridDBColumn
        DataBinding.FieldName = 'IdTag'
        Visible = False
      end
      object cxGridDBColumn2: TcxGridDBColumn
        Caption = 'Tag Name'
        DataBinding.FieldName = 'TagName'
        Visible = False
        GroupIndex = 0
        SortOrder = soAscending
      end
      object cxGridDBColumn3: TcxGridDBColumn
        Caption = 'Model'
        DataBinding.FieldName = 'model'
      end
      object cxGridDBColumn4: TcxGridDBColumn
        Caption = 'Model Description'
        DataBinding.FieldName = 'Description'
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTagConflict
    end
  end
  object cxGridPromoConfict: TcxGrid
    Left = 10
    Top = 245
    Width = 766
    Height = 206
    TabOrder = 4
    object cxGridDBTableView1: TcxGridDBTableView
      DataController.DataSource = dsPromoConflict
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.ExpandMasterRowOnDblClick = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      object cxGridDBTableView1DBColumn1: TcxGridDBColumn
        Caption = 'Id Promo'
        DataBinding.FieldName = 'IdDiscount'
        Visible = False
      end
      object cxGridDBTableView1DBColumn2: TcxGridDBColumn
        Caption = 'Promo Name'
        DataBinding.FieldName = 'DiscountName'
        Visible = False
        GroupIndex = 0
        SortOrder = soAscending
      end
      object cxGridDBColumn5: TcxGridDBColumn
        DataBinding.FieldName = 'IdTag'
        Visible = False
      end
      object cxGridDBColumn6: TcxGridDBColumn
        Caption = 'Tag Name'
        DataBinding.FieldName = 'TagName'
        SortOrder = soAscending
      end
      object cxGridDBColumn7: TcxGridDBColumn
        Caption = 'Model'
        DataBinding.FieldName = 'model'
      end
      object cxGridDBColumn8: TcxGridDBColumn
        Caption = 'Model Description'
        DataBinding.FieldName = 'Description'
      end
    end
    object cxGridLevel2: TcxGridLevel
      GridView = cxGridDBTableView1
    end
  end
  object dsModels: TDataSource
    Left = 190
    Top = 20
  end
  object dsPromoConflict: TDataSource
    Left = 175
    Top = 245
  end
  object dsTagConflict: TDataSource
    Left = 590
    Top = 15
  end
end
