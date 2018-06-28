object ECFList: TECFList
  Left = 326
  Top = 204
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ECF'
  ClientHeight = 361
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grdECF: TcxGrid
    Left = 0
    Top = 22
    Width = 598
    Height = 309
    Align = alClient
    TabOrder = 0
    object grdECFTableView: TcxGridDBTableView
      DataController.DataSource = dsECF
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDECF'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdECFTableViewIDECF: TcxGridDBColumn
        DataBinding.FieldName = 'IDECF'
      end
      object grdECFTableViewNumeroECF: TcxGridDBColumn
        DataBinding.FieldName = 'NumeroECF'
      end
      object grdECFTableViewNumeroSerie: TcxGridDBColumn
        DataBinding.FieldName = 'NumeroSerie'
      end
      object grdECFTableViewCashRegister: TcxGridDBColumn
        DataBinding.FieldName = 'CashRegister'
      end
      object grdECFTableViewStore: TcxGridDBColumn
        DataBinding.FieldName = 'Store'
      end
    end
    object grdECFLevel: TcxGridLevel
      GridView = grdECFTableView
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 331
    Width = 598
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      598
      30)
    object btnClose: TcxButton
      Left = 518
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object dsECF: TDataSource
    DataSet = cdsECF
    OnDataChange = dsECFDataChange
    Left = 88
    Top = 240
  end
  object bmList: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Bars = <
      item
        AllowCustomizing = False
        AllowQuickCustomizing = False
        AllowReset = False
        BorderStyle = bbsNone
        Caption = 'OperationBar'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 326
        FloatTop = 257
        FloatClientWidth = 23
        FloatClientHeight = 22
        IsMainMenu = True
        ItemLinks = <
          item
            Item = bbNew
            Visible = True
          end
          item
            Item = bbEdit
            Visible = True
          end
          item
            Item = bbDelete
            Visible = True
          end>
        MultiLine = True
        Name = 'OperationBar'
        NotDocking = [dsNone, dsLeft, dsRight, dsBottom]
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end>
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    Style = bmsFlat
    UseSystemFont = True
    Left = 284
    Top = 156
    DockControlHeights = (
      0
      0
      22
      0)
    object bbNew: TdxBarButton
      Caption = 'Novo'
      Category = 0
      Hint = 'Novo'
      Visible = ivAlways
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Editar'
      Category = 0
      Hint = 'Editar'
      Visible = ivAlways
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Excluir'
      Category = 0
      Hint = 'Excluir'
      Visible = ivAlways
      OnClick = bbDeleteClick
    end
  end
  object quECF: TADOQuery
    Connection = DMSintegra.ADOConn
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'ECF.IDECF,'
      #9'ECF.IDStore,'
      #9'ECF.IDCashRegister,'
      #9'ECF.NumeroECF,'
      #9'ECF.NumeroSerie,'
      #9'CR.Name CashRegister,'
      #9'S.Name Store'
      'FROM'
      #9'Sal_ECF ECF'
      
        #9'JOIN CashRegister CR ON (ECF.IDCashRegister = CR.IDCashRegister' +
        ')'
      #9'JOIN Store S ON (ECF.IDStore = S.IDStore)')
    Left = 88
    Top = 80
    object quECFIDECF: TIntegerField
      FieldName = 'IDECF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quECFIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quECFIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object quECFNumeroECF: TIntegerField
      FieldName = 'NumeroECF'
    end
    object quECFNumeroSerie: TStringField
      FieldName = 'NumeroSerie'
      Size = 15
    end
    object quECFCashRegister: TStringField
      FieldName = 'CashRegister'
      ProviderFlags = []
      Size = 15
    end
    object quECFStore: TStringField
      FieldName = 'Store'
      ProviderFlags = []
      Size = 30
    end
  end
  object dspECF: TDataSetProvider
    DataSet = quECF
    Options = [poIncFieldProps]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 136
  end
  object cdsECF: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspECF'
    Left = 88
    Top = 188
  end
end
