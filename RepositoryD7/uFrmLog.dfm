inherited FrmLog: TFrmLog
  Left = 39
  Top = 89
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'FrmLog'
  ClientHeight = 470
  ClientWidth = 658
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel [0]
    Left = 0
    Top = 444
    Width = 658
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      658
      26)
    object btClose: TcxButton
      Left = 580
      Top = 1
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Close'
      TabOrder = 0
      OnClick = btCloseClick
    end
  end
  object pnlClient: TPanel [1]
    Left = 0
    Top = 0
    Width = 658
    Height = 444
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object grdLog: TcxGrid
      Left = 0
      Top = 28
      Width = 658
      Height = 416
      Align = alClient
      TabOrder = 0
      object grdLogDBTableView: TcxGridDBTableView
        DataController.DataSource = dsLog
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object grdLogDBTableViewType: TcxGridDBColumn
          DataBinding.FieldName = 'Type'
          Width = 57
        end
        object grdLogDBTableViewMessage: TcxGridDBColumn
          DataBinding.FieldName = 'Message'
          PropertiesClassName = 'TcxMemoProperties'
          Width = 477
        end
      end
      object grdLogLevel: TcxGridLevel
        GridView = grdLogDBTableView
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 658
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 1
      object btnExport: TBitBtn
        Left = 5
        Top = 3
        Width = 25
        Height = 25
        Hint = 'Export'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnExportClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E000000000000000000008000FF8000FF
          8000FF8486840000000000000000000000000000000000000000000000000000
          000000000000000000008000FF8000FF8000FF848684C6C7C6C6C7C6C6C7C6C6
          C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C6C6C7C60000008000FF8000FF
          8000FF848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFC6C7C60000008000FF8000FF8000FF848684FFFFFFC6C7C6C6C7C6C6
          C7C6C6C7C6FFFFFFC6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600008600
          008600008600008600008600008600008600008600008600C6C7C6FFFFFFC6C7
          C6FFFFFFC6C7C6000000008600FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF008600FFFFFFFFFFFFC6C7C6FFFFFFC6C7C6000000008600FFFFFF
          008600008600008600008600008600008600008600008600FFFFFFFFFFFFFFFF
          FFFFFFFFC6C7C6000000008600FFFFFF008600008600008600C6C7C600860000
          8600008600008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
          FFFFFF008600C6C7C6008600008600008600FFFFFF008600FFFFFFFFFFFFC6C7
          C6FFFFFFC6C7C6000000008600FFFFFF008600C6C7C6008600008600008600FF
          FFFFFFFFFF008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
          C6C7C6008600008600008600008600008600FFFFFF008600FFFFFFFFFFFFC6C7
          C6FFFFFFC6C7C6000000008600FFFFFF008600008600FFFFFFFFFFFF00860000
          8600FFFFFF008600C6C7C6C6C7C6C6C7C6FFFFFFC6C7C6000000008600FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008600FFFFFFFFFFFF0000
          0000000000000000000000860000860000860000860000860000860000860000
          8600008600008600FFFFFFFFFFFF848684FFFFFF0000008000FF8000FF8000FF
          8000FF848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8486
          840000008000FF8000FF8000FF8000FF8000FF84868484868484868484868484
          86848486848486848486848486848486848000FF8000FF8000FF}
      end
    end
  end
  inherited siLang: TsiLang
    Top = 36
  end
  object dsLog: TDataSource
    DataSet = cdsLog
    Left = 28
    Top = 132
  end
  object cdsLog: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 28
    Top = 84
    object cdsLogType: TIntegerField
      FieldName = 'Type'
    end
    object cdsLogMessage: TStringField
      FieldName = 'Message'
      Size = 255
    end
  end
  object imgSmall: TImageList
    Left = 28
    Top = 180
  end
  object SD: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls'
    Left = 140
    Top = 109
  end
end
