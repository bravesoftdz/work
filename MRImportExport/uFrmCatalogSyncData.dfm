inherited FrmCatalogSyncData: TFrmCatalogSyncData
  Left = 89
  Top = 155
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Catalog Sync Data'
  ClientHeight = 448
  ClientWidth = 524
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel [0]
    Left = 0
    Top = 409
    Width = 524
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      524
      39)
    object btnClose: TButton
      Left = 427
      Top = 10
      Width = 80
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnApply: TButton
      Left = 328
      Top = 10
      Width = 91
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Apply changes'
      Enabled = False
      TabOrder = 1
      OnClick = btnApplyClick
    end
  end
  object pgOption: TPageControl [1]
    Left = 0
    Top = 0
    Width = 524
    Height = 409
    ActivePage = tsVendor
    Align = alClient
    TabOrder = 1
    object tsVendor: TTabSheet
      Caption = 'Vendor'
      object grdCatalogVendor: TcxGrid
        Left = 3
        Top = 6
        Width = 506
        Height = 368
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdCatalogVendorDBTableView: TcxGridDBTableView
          DataController.DataSource = dsListVendor
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDVendor'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.CancelOnExit = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object grdCatalogVendorDBTableViewIDVendor: TcxGridDBColumn
            DataBinding.FieldName = 'IDVendor'
            Visible = False
            Width = 54
          end
          object grdCatalogVendorDBTableViewVendor: TcxGridDBColumn
            DataBinding.FieldName = 'Vendor'
            Options.Editing = False
            Options.Focusing = False
            Width = 229
          end
          object grdCatalogVendorDBTableViewIDVendorMR: TcxGridDBColumn
            DataBinding.FieldName = 'IDVendorMR'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownSizeable = True
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'IDVendor'
            Properties.ListColumns = <
              item
                FieldName = 'Vendor'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = DMImportExport.dtsLookupVendor
            Width = 221
          end
        end
        object grdCatalogVendorLevel: TcxGridLevel
          GridView = grdCatalogVendorDBTableView
        end
      end
    end
  end
  object cdsListVendor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspListVendor'
    RemoteServer = DMImportExport.CatalogConn
    Left = 252
    Top = 116
    object cdsListVendorIDVendorMR: TIntegerField
      DisplayLabel = 'MainRetail Vendor'
      FieldName = 'IDVendorMR'
    end
    object cdsListVendorIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsListVendorVendor: TStringField
      FieldName = 'Vendor'
      Size = 32
    end
  end
  object dsListVendor: TDataSource
    DataSet = cdsListVendor
    OnDataChange = dsListVendorDataChange
    Left = 252
    Top = 176
  end
end
