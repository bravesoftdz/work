object FrmLog: TFrmLog
  Left = 336
  Top = 204
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MREcommerceSync'
  ClientHeight = 373
  ClientWidth = 592
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
  object grdLog: TcxGrid
    Left = 0
    Top = 33
    Width = 592
    Height = 307
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
      OptionsView.GroupByBox = False
      object grdLogDBTableViewID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
        Width = 51
      end
      object grdLogDBTableViewMsgError: TcxGridDBColumn
        DataBinding.FieldName = 'MsgError'
        Width = 437
      end
      object grdLogDBTableViewDateTime: TcxGridDBColumn
        DataBinding.FieldName = 'DateTime'
        Width = 102
      end
    end
    object grdLogLevel: TcxGridLevel
      GridView = grdLogDBTableView
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      592
      33)
    object lblLog: TLabel
      Left = 284
      Top = 12
      Width = 79
      Height = 13
      Caption = 'Arquivo de LOG:'
    end
    object cbxLogFile: TcxComboBox
      Left = 365
      Top = 8
      Width = 217
      Height = 21
      Anchors = [akTop, akRight]
      Properties.OnChange = cbxLogFilePropertiesChange
      TabOrder = 0
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 340
    Width = 592
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnClose: TcxButton
      Left = 512
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnEmail: TcxButton
      Left = 434
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Enviar LOG'
      TabOrder = 1
      OnClick = btnEmailClick
    end
  end
  object dsLog: TDataSource
    DataSet = cdsLogs
    Left = 332
    Top = 172
  end
  object cdsLogs: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 276
    Top = 172
    object cdsLogsID: TIntegerField
      FieldName = 'ID'
    end
    object cdsLogsMsgError: TStringField
      FieldName = 'MsgError'
      Size = 255
    end
    object cdsLogsDateTime: TDateTimeField
      FieldName = 'DateTime'
    end
  end
end
