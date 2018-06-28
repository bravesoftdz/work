object ReducaoZList: TReducaoZList
  Left = 255
  Top = 246
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Redu'#231#227'o Z'
  ClientHeight = 303
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grdECF: TcxGrid
    Left = 0
    Top = 53
    Width = 686
    Height = 220
    Align = alClient
    TabOrder = 1
    object grdECFTableView: TcxGridDBTableView
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
  object grdReducaoZ: TcxGrid
    Left = 0
    Top = 53
    Width = 686
    Height = 220
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfFlat
    object grdReducaoZTableView: TcxGridDBTableView
      DataController.DataSource = dsReducaoZ
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDReducaoZ'
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
      object grdReducaoZTableViewIDReducaoZ: TcxGridDBColumn
        DataBinding.FieldName = 'IDReducaoZ'
        Visible = False
      end
      object grdReducaoZTableViewMovDate: TcxGridDBColumn
        DataBinding.FieldName = 'MovDate'
      end
      object grdReducaoZTableViewNumeroSerie: TcxGridDBColumn
        DataBinding.FieldName = 'NumeroSerie'
      end
      object grdReducaoZTableViewNumeroLoja: TcxGridDBColumn
        DataBinding.FieldName = 'NumeroLoja'
      end
      object grdReducaoZTableViewNumeroECF: TcxGridDBColumn
        DataBinding.FieldName = 'NumeroECF'
      end
      object grdReducaoZTableViewNumReducaoZ: TcxGridDBColumn
        DataBinding.FieldName = 'NumReducaoZ'
      end
      object grdReducaoZTableViewCOOInicial: TcxGridDBColumn
        DataBinding.FieldName = 'COOInicial'
      end
      object grdReducaoZTableViewCOOFinal: TcxGridDBColumn
        DataBinding.FieldName = 'COOFinal'
      end
      object grdReducaoZTableViewNumCancelamentos: TcxGridDBColumn
        DataBinding.FieldName = 'NumCancelamentos'
      end
      object grdReducaoZTableViewValCancelamentos: TcxGridDBColumn
        DataBinding.FieldName = 'ValCancelamentos'
      end
      object grdReducaoZTableViewValDescontos: TcxGridDBColumn
        DataBinding.FieldName = 'ValDescontos'
      end
      object grdReducaoZTableViewGTInicial: TcxGridDBColumn
        DataBinding.FieldName = 'GTInicial'
      end
      object grdReducaoZTableViewGTFinal: TcxGridDBColumn
        DataBinding.FieldName = 'GTFinal'
      end
      object grdReducaoZTableViewSubstituicaoTrib: TcxGridDBColumn
        DataBinding.FieldName = 'SubstituicaoTrib'
      end
      object grdReducaoZTableViewIsencao: TcxGridDBColumn
        DataBinding.FieldName = 'Isencao'
      end
    end
    object grdReducaoZLevel: TcxGridLevel
      GridView = grdReducaoZTableView
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 273
    Width = 686
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    DesignSize = (
      686
      30)
    object btnClose: TcxButton
      Left = 606
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
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 686
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      686
      53)
    object Label1: TLabel
      Left = 17
      Top = 20
      Width = 14
      Height = 13
      Caption = 'De'
    end
    object Label2: TLabel
      Left = 165
      Top = 20
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object deInicial: TcxDateEdit
      Left = 40
      Top = 16
      Width = 121
      Height = 21
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 0
    end
    object deFinal: TcxDateEdit
      Left = 188
      Top = 16
      Width = 121
      Height = 21
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
    end
    object btGO: TcxButton
      Left = 624
      Top = 4
      Width = 51
      Height = 41
      Anchors = [akTop, akRight]
      Caption = 'GO!'
      TabOrder = 2
      OnClick = btGOClick
    end
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
        Visible = False
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
      0
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
  object dsReducaoZ: TDataSource
    DataSet = cdsReducaoZ
    OnDataChange = dsReducaoZDataChange
    Left = 88
    Top = 240
  end
  object quReducaoZ: TADOQuery
    Connection = DMSintegra.ADOConn
    Parameters = <
      item
        Name = 'FirstDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'LastDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.IDReducaoZ,'
      #9'RZ.MovDate,'
      #9'RZ.NumeroSerie,'
      #9'RZ.NumeroLoja,'
      #9'RZ.NumeroECF,'
      #9'RZ.NumReducaoZ,'
      #9'RZ.COOInicial,'
      #9'RZ.COOFinal,'
      #9'RZ.NumCancelamentos,'
      #9'RZ.ValCancelamentos,'
      #9'RZ.ValDescontos,'
      #9'RZ.GTInicial,'
      #9'RZ.GTFinal,'
      #9'RZ.SubstituicaoTrib,'
      #9'RZ.Isencao'
      'FROM'
      #9'Sal_ReducaoZ RZ'
      'WHERE'
      #9'RZ.MovDate >= :FirstDate'
      #9'AND RZ.MovDate <= :LastDate')
    Left = 88
    Top = 80
    object quReducaoZIDReducaoZ: TIntegerField
      FieldName = 'IDReducaoZ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quReducaoZMovDate: TDateTimeField
      FieldName = 'MovDate'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZNumeroSerie: TStringField
      FieldName = 'NumeroSerie'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZNumeroLoja: TIntegerField
      FieldName = 'NumeroLoja'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZNumeroECF: TIntegerField
      FieldName = 'NumeroECF'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZNumReducaoZ: TIntegerField
      FieldName = 'NumReducaoZ'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZCOOInicial: TIntegerField
      FieldName = 'COOInicial'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZCOOFinal: TIntegerField
      FieldName = 'COOFinal'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZNumCancelamentos: TIntegerField
      FieldName = 'NumCancelamentos'
      ProviderFlags = [pfInUpdate]
    end
    object quReducaoZValCancelamentos: TBCDField
      FieldName = 'ValCancelamentos'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object quReducaoZValDescontos: TBCDField
      FieldName = 'ValDescontos'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object quReducaoZGTInicial: TBCDField
      FieldName = 'GTInicial'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object quReducaoZGTFinal: TBCDField
      FieldName = 'GTFinal'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object quReducaoZSubstituicaoTrib: TBCDField
      FieldName = 'SubstituicaoTrib'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object quReducaoZIsencao: TBCDField
      FieldName = 'Isencao'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
  end
  object dspReducaoZ: TDataSetProvider
    DataSet = quReducaoZ
    Options = [poIncFieldProps]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 136
  end
  object cdsReducaoZ: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspReducaoZ'
    Left = 88
    Top = 188
  end
end
