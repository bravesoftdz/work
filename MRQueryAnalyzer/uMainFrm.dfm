object MainFrm: TMainFrm
  Left = 157
  Top = 159
  Width = 696
  Height = 480
  Caption = 'MR Query Analyzer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 0
    Top = 22
    Width = 688
    Height = 431
    ActivePage = tsSelect
    Align = alClient
    TabOrder = 4
    object tsSelect: TTabSheet
      Caption = '  Select  '
      object spMain: TSplitter
        Left = 0
        Top = 200
        Width = 680
        Height = 3
        Cursor = crVSplit
        Align = alBottom
      end
      object grdResult: TcxGrid
        Left = 0
        Top = 203
        Width = 680
        Height = 200
        Align = alBottom
        TabOrder = 0
        object grdResultDBTableView: TcxGridDBTableView
          DataController.DataSource = dsResult
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
        end
        object grdResultLevel: TcxGridLevel
          GridView = grdResultDBTableView
        end
      end
      object mmQuery: TcxMemo
        Left = 0
        Top = 0
        Width = 680
        Height = 200
        Align = alClient
        TabOrder = 1
      end
    end
    object tsExecute: TTabSheet
      Caption = '  Execute  '
      ImageIndex = 1
      object mmExecute: TcxMemo
        Left = 0
        Top = 0
        Width = 680
        Height = 403
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object bmMain: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Bars = <
      item
        AllowCustomizing = False
        AllowQuickCustomizing = False
        BorderStyle = bbsNone
        Caption = 'Menu'
        DockedDockingStyle = dsTop
        DockedLeft = 16
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 276
        FloatTop = 216
        FloatClientWidth = 23
        FloatClientHeight = 22
        IsMainMenu = True
        ItemLinks = <
          item
            Item = bbRun
            Visible = True
          end
          item
            Item = bbConfigConn
            Visible = True
          end>
        MultiLine = True
        Name = 'Menu'
        NotDocking = [dsNone, dsLeft, dsRight, dsBottom]
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 316
    Top = 156
    DockControlHeights = (
      0
      0
      22
      0)
    object bbRun: TdxBarButton
      Caption = 'Run'
      Category = 0
      Hint = 'Run'
      Visible = ivAlways
      OnClick = bbRunClick
    end
    object bbConfigConn: TdxBarButton
      Caption = 'Connection'
      Category = 0
      Hint = 'Connection'
      Visible = ivAlways
      OnClick = bbConfigConnClick
    end
  end
  object cdsResult: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspResult'
    Left = 204
    Top = 308
  end
  object dsResult: TDataSource
    DataSet = cdsResult
    Left = 256
    Top = 308
  end
  object dspResult: TDataSetProvider
    DataSet = qryResult
    Left = 148
    Top = 308
  end
  object ADOConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mruser2000;Persist Security Info=Tr' +
      'ue;User ID=mruser;Initial Catalog=CeldomTestDB;Data Source=desen' +
      'v004'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 152
    Top = 52
  end
  object qryResult: TADODataSet
    Connection = ADOConn
    Parameters = <>
    Left = 92
    Top = 308
  end
  object cmdScript: TADOCommand
    Connection = ADOConn
    Parameters = <>
    Left = 92
    Top = 364
  end
end
