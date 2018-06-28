inherited FinHoraList: TFinHoraList
  Left = 27
  Top = 18
  Width = 784
  Height = 550
  HelpContext = 4
  Caption = 'FinHoraList'
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 365
    Width = 776
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 235
  end
  inherited EspacamentoDireito: TPanel
    Left = 776
    Height = 235
  end
  inherited EspacamentoSuperior: TPanel
    Width = 776
    inherited imgOn: TImage
      Left = 337
    end
    inherited imgOff: TImage
      Left = -102
    end
  end
  inherited pnlBasicFilter: TPanel
    Width = 776
    Visible = True
    object Label3: TLabel [0]
      Left = 355
      Top = 31
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sales person :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 6
      Top = 6
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Enter date :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel [2]
      Left = 178
      Top = 6
      Width = 12
      Height = 13
      Alignment = taRightJustify
      Caption = 'to'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel [3]
      Left = 396
      Top = 6
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel [4]
      Left = 14
      Top = 31
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'Grouping :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited pnlExecuta: TPanel
      Left = 711
      Visible = True
      inherited pnlExecutaAviso: TPanel
        Height = 44
      end
    end
    object scPessoa: TSuperComboADO
      Left = 436
      Top = 28
      Width = 171
      Height = 21
      TabOrder = 1
      Text = 'scPessoa'
      CodeLength = 45
      SpcWhereClause = 'P.IDTipoPessoaRoot = 4'
      LookUpSource = DM.dsLUPessoa
      DropDownRows = 16
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      OnSelectItem = scStoreSelectItem
    end
    object btTodasPessoas: TButton
      Left = 611
      Top = 29
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 2
      OnClick = btTodasPessoasClick
    end
    object scStore: TSuperComboADO
      Left = 436
      Top = 3
      Width = 171
      Height = 21
      TabOrder = 3
      Text = 'scPessoa'
      CodeLength = 45
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 16
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      OnSelectItem = scStoreSelectItem
    end
    object btTodasStore: TButton
      Left = 611
      Top = 3
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 4
      OnClick = btTodasStoreClick
    end
    object cmbGroup: TComboBox
      Left = 74
      Top = 28
      Width = 202
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnChange = cmbGroupChange
      Items.Strings = (
        'Daily'
        'Weekly'
        'Monthly'
        'Quarterly'
        'Yearly')
    end
    object dbFim: TDateBox
      Left = 193
      Top = 4
      Width = 83
      Height = 21
      TabOrder = 6
    end
    object dbInicio: TDateBox
      Left = 75
      Top = 4
      Width = 83
      Height = 21
      TabOrder = 7
    end
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 520
    Width = 776
  end
  inherited pnlBrowse: TPanel
    Width = 776
    Height = 235
    inherited pnlGenFilter: TPanel
      Width = 776
    end
    inherited brwGrid: TdxDBGrid
      Width = 776
      Height = 195
      KeyField = 'GroupIndex'
      ShowSummaryFooter = True
      Filter.Criteria = {00000000}
      OptionsBehavior = [edgoAutoSearch, edgoCaseInsensitive, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoShowHourGlass, edgoTabThrough, edgoVertThrough]
      object brwGridGroupIndex: TdxDBGridMaskColumn
        Visible = False
        Width = 70
        BandIndex = 0
        RowIndex = 0
        FieldName = 'GroupIndex'
      end
      object brwGridIDPessoa: TdxDBGridMaskColumn
        Width = 35
        BandIndex = 0
        RowIndex = 0
        FieldName = 'IDPessoa'
      end
      object brwGridYear: TdxDBGridMaskColumn
        Caption = 'Year'
        Width = 54
        BandIndex = 0
        RowIndex = 0
        FieldName = 'YIndex'
      end
      object brwGridRange: TdxDBGridMaskColumn
        Width = 105
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Range'
      end
      object brwGridPessoa: TdxDBGridMaskColumn
        Width = 149
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Pessoa'
      end
      object brwGridUsuario: TdxDBGridMaskColumn
        Visible = False
        Width = 335
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Usuario'
      end
      object brwGridStore: TdxDBGridMaskColumn
        Width = 146
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Store'
      end
      object brwGridHoursFull: TdxDBGridMaskColumn
        Width = 57
        BandIndex = 0
        RowIndex = 0
        FieldName = 'HoursFull'
        SummaryFooterType = cstSum
        SummaryFooterField = 'HoursFull'
        SummaryFooterFormat = '#,##0.00'
        SummaryType = cstSum
        SummaryField = 'HoursFull'
        SummaryFormat = '#,##0.00'
      end
      object brwGridHour: TdxDBGridMaskColumn
        Caption = 'Reg.Hour'
        Width = 54
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Hour'
        SummaryFooterType = cstSum
        SummaryFooterField = 'Hour'
        SummaryFooterFormat = '#,##0.00'
        SummaryType = cstSum
        SummaryField = 'Hour'
        SummaryFormat = '#,##0.00'
      end
      object brwGridOverHour: TdxDBGridColumn
        Width = 57
        BandIndex = 0
        RowIndex = 0
        FieldName = 'OverHour'
        SummaryFooterType = cstSum
        SummaryFooterField = 'OverHour'
        SummaryFooterFormat = '#,##0.00'
        SummaryType = cstSum
        SummaryField = 'OverHour'
        SummaryFormat = '#,##0.00'
      end
      object brwGridDoubleHour: TdxDBGridColumn
        Width = 57
        BandIndex = 0
        RowIndex = 0
        FieldName = 'DoubleHour'
        SummaryFooterType = cstSum
        SummaryFooterField = 'DoubleHour'
        SummaryFooterFormat = '#,##0.00'
        SummaryType = cstSum
        SummaryField = 'DoubleHour'
        SummaryFormat = '#,##0.00'
      end
      object brwGridValorHora: TdxDBGridMaskColumn
        Visible = False
        Width = 70
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ValorHora'
      end
      object brwGridValorHoraExtra: TdxDBGridMaskColumn
        Visible = False
        Width = 85
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ValorHoraExtra'
      end
      object brwGridValorHoraExtraExtra: TdxDBGridMaskColumn
        Visible = False
        Width = 113
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ValorHoraExtraExtra'
      end
      object brwGridValue: TdxDBGridColumn
        Width = 60
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Value'
        SummaryFooterType = cstSum
        SummaryFooterField = 'Value'
        SummaryFooterFormat = '#,##0.00'
        SummaryType = cstSum
        SummaryField = 'Value'
        SummaryFormat = '#,##0.00'
      end
    end
    inherited pnlCountLine: TPanel
      Top = 217
      Width = 776
      Visible = False
      inherited pnlDivisor: TPanel
        Width = 776
      end
    end
  end
  object pnlTime: TPanel [7]
    Left = 0
    Top = 368
    Width = 776
    Height = 152
    Align = alBottom
    BevelOuter = bvNone
    UseDockManager = False
    TabOrder = 10
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 776
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Time details'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Panel6Click
    end
    object grdTime: TdxDBCGrid
      Left = 0
      Top = 18
      Width = 776
      Height = 134
      Bands = <
        item
        end>
      DefaultLayout = True
      HeaderPanelRowCount = 1
      KeyField = 'IDTime'
      SummaryGroups = <>
      SummarySeparator = ', '
      Align = alClient
      TabOrder = 1
      OnDblClick = grdTimeDblClick
      ArrowsColor = clBlue
      DataSource = dsTime
      Filter.Criteria = {00000000}
      LookAndFeel = lfFlat
      OptionsBehavior = [edgoAutoSort, edgoCaseInsensitive, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
      OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowSelect, edgoUseBitmap]
      ShowGrid = False
      object grdTimeIDPessoa: TdxDBGridMaskColumn
        Caption = 'ID'
        Width = 36
        BandIndex = 0
        RowIndex = 0
        FieldName = 'IDPessoa'
      end
      object grdTimeEnterDate: TdxDBGridDateColumn
        Width = 286
        BandIndex = 0
        RowIndex = 0
        FieldName = 'EnterDate'
      end
      object grdTimeExitDate: TdxDBGridDateColumn
        Width = 286
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ExitDate'
      end
      object grdTimeHours: TdxDBGridMaskColumn
        Width = 166
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Hours'
      end
    end
  end
  inherited bpmDetail: TdxBarPopupMenu [8]
    ItemLinks = <
      item
        Item = bbListaOpen
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbListaRemove
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        BeginGroup = True
        Item = bbDetailHelp
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbDetailFiltraCampo
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbDetailFIltraExcluindoCampo
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bdcFiltraData
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = beFiltraTexto
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbDetailRemoveFiltro
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        BeginGroup = True
        Item = bbDetailClassificacaoCre
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbDetailClassificaoDesc
        UserGlyph.Data = {00000000}
        Visible = True
      end>
    Left = 382
    Top = 233
  end
  inherited bpmHeader: TdxBarPopupMenu [9]
    ItemLinks = <
      item
        Item = bbHeaderAgrupar
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbListaAgrupamento
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        BeginGroup = True
        Item = bbHeaderRemoveColuna
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbListaColuna
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        BeginGroup = True
        Item = bsHeaderAlinhamento
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbHeaderAjuste
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbHeaderAjusteAll
        UserGlyph.Data = {00000000}
        Visible = True
      end>
  end
  inherited bpmSummary: TdxBarPopupMenu [10]
    ItemLinks = <
      item
        Item = bbFooterTotal
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbFooterMin
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbFooterMax
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        Item = bbFooterAVG
        UserGlyph.Data = {00000000}
        Visible = True
      end
      item
        BeginGroup = True
        Item = bbFooterNenhum
        UserGlyph.Data = {00000000}
        Visible = True
      end>
  end
  inherited bmMDI: TdxBarManager [11]
    Bars = <
      item
        Caption = 'Lista'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 318
        FloatTop = 184
        FloatClientWidth = 92
        FloatClientHeight = 153
        ItemLinks = <
          item
            Item = bbListaImprime
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = bbListaAgrupamento
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = bbListaColuna
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = Zoom
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = bbListaZoom
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = siListaExporta
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = bbShowTime
            UserDefine = [udPaintStyle]
            UserGlyph.Data = {00000000}
            UserPaintStyle = psCaptionGlyph
            Visible = True
          end>
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = 'Visao'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 26
        DockingStyle = dsTop
        FloatLeft = 157
        FloatTop = 367
        FloatClientWidth = 182
        FloatClientHeight = 41
        ItemLinks = <
          item
            Item = bbVisaoOrganiza
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = bbVisaoSalva
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = bbVisaoDelete
            UserGlyph.Data = {00000000}
            Visible = True
          end>
        OneOnRow = True
        Row = 1
        UseOwnFont = False
        Visible = False
        WholeRow = False
      end>
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True)
    Left = 315
    DockControlHeights = (
      0
      0
      28
      0)
    inherited bsHeaderAlinhamento: TdxBarSubItem
      ItemLinks = <
        item
          Item = bbHeaderEsquerda
          UserGlyph.Data = {00000000}
          Visible = True
        end
        item
          Item = bbHeaderCentro
          UserGlyph.Data = {00000000}
          Visible = True
        end
        item
          Item = bbHeaderDireita
          UserGlyph.Data = {00000000}
          Visible = True
        end>
    end
    inherited siListaExporta: TdxBarSubItem
      ItemLinks = <
        item
          Item = bbExportaExcel
          UserGlyph.Data = {00000000}
          Visible = True
        end
        item
          Item = bbExportaHTML
          UserGlyph.Data = {00000000}
          Visible = True
        end
        item
          Item = btnXML
          UserGlyph.Data = {00000000}
          Visible = True
        end
        item
          Item = bbExportaTexto
          UserGlyph.Data = {00000000}
          Visible = True
        end>
    end
    inherited cbxStatus: TdxBarImageCombo
      ImageIndexes = (
        34
        54)
    end
    object bbShowTime: TdxBarButton
      Caption = 'Show time details'
      Category = 0
      Hint = 'Show time details'
      Visible = ivAlways
      ButtonStyle = bsChecked
      ImageIndex = 28
      OnClick = bbShowTimeClick
    end
  end
  inherited quBrowse: TPowerADOQuery [12]
    AfterOpen = quBrowseAfterOpen
    AfterScroll = quBrowseAfterScroll
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'SELECT'#13#10'        P.IDPessoa,'#13#10'        S.IDStore,'#13#10'        P.Pesso' +
      'a as Pessoa,'#13#10'        U.SystemUser as Usuario,'#13#10'        S.Name a' +
      's Store,'#13#10'        DatePart(week, T.EnterDate) as GroupIndex,'#13#10'  ' +
      '      DatePart(year, T.EnterDate) as YIndex,'#13#10'        P.ValorHor' +
      'a,'#13#10'        P.ValorHoraExtra,'#13#10'        P.ValorHoraExtraExtra,'#13#10' ' +
      '       SUM (DateDiff(Minute, T.EnterDate, T.ExitDate) / 60.0) as' +
      ' HoursFull'#13#10#13#10'FROM'#13#10'        TMC_TimeControl T (NOLOCK)'#13#10'        ' +
      'JOIN Pessoa P ON (T.IDPessoa = P.IDPessoa)'#13#10'        LEFT OUTER J' +
      'OIN SystemUser U ON (T.IDUser = U.IDUser)'#13#10'        JOIN Store S ' +
      'ON (T.IDStore = S.IDStore)'#13#10#13#10'GROUP BY'#13#10'        P.ValorHora,'#13#10'  ' +
      '      P.ValorHoraExtra,'#13#10'        P.ValorHoraExtraExtra,'#13#10'       ' +
      ' P.IDPessoa,'#13#10'        S.IDStore,'#13#10'        P.Pessoa ,'#13#10'        U.' +
      'SystemUser,'#13#10'        S.Name,'#13#10'        DatePart(Week, T.EnterDate' +
      '),'#13#10'        DatePart(Year, T.EnterDate)'#13#10#13#10'ORDER BY'#13#10'        Dat' +
      'ePart(Week, T.EnterDate)'#13#10#13#10
    Top = 209
    object quBrowseIDPessoa: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDPessoa'
    end
    object quBrowseIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quBrowsePessoa: TStringField
      DisplayLabel = 'Sales Person'
      FieldName = 'Pessoa'
      Size = 50
    end
    object quBrowseUsuario: TStringField
      DisplayLabel = 'User'
      FieldName = 'Usuario'
      Size = 50
    end
    object quBrowseStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quBrowseGroupIndex: TIntegerField
      FieldName = 'GroupIndex'
    end
    object quBrowseHoursFull: TFloatField
      DisplayLabel = 'TotalHours'
      FieldName = 'HoursFull'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseOverHour: TFloatField
      FieldKind = fkCalculated
      FieldName = 'OverHour'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseDoubleHour: TFloatField
      FieldKind = fkCalculated
      FieldName = 'DoubleHour'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseHour: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Hour'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseValorHora: TFloatField
      DisplayLabel = 'HourValue'
      FieldName = 'ValorHora'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseValorHoraExtra: TFloatField
      DisplayLabel = 'OverHourValue'
      FieldName = 'ValorHoraExtra'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseValorHoraExtraExtra: TFloatField
      DisplayLabel = 'DoubleHourValue'
      FieldName = 'ValorHoraExtraExtra'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseValue: TFloatField
      DisplayLabel = 'Subtotal'
      FieldKind = fkCalculated
      FieldName = 'Value'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseRange: TStringField
      FieldKind = fkCalculated
      FieldName = 'Range'
      Calculated = True
    end
    object quBrowseYIndex: TIntegerField
      FieldName = 'YIndex'
    end
  end
  inherited dsBrowse: TDataSource [13]
  end
  inherited siLang: TsiLangRT [14]
    StorageFile = 'OM_FinHoraList.sil'
  end
  inherited ilSmallButtons: TImageList [15]
  end
  inherited BrowseConfig: TBrowseConfig [16]
    MostraDesativado = STD_AMBOSDESATIVADO
    MostraHidden = STD_AMBOSHIDDEN
    AutoOpen = False
    CheckSystemOnDelete = False
  end
  inherited SaveDialog: TSaveDialog [17]
  end
  inherited cpList: TdxComponentPrinter
    inherited cpListGridLink: TdxDBGridReportLink
      DateTime = 37404.7336658333
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
  object dsTime: TDataSource
    DataSet = quTime
    Left = 615
    Top = 236
  end
  object quTime: TPowerADOQuery
    Connection = DM.DBADOConnection
    CommandText = 
      'SELECT'#13#10'IDPessoa,'#13#10'        T.IDTime,'#13#10'        T.EnterDate,'#13#10'    ' +
      '    T.ExitDate,'#13#10'        (DateDiff(Minute, T.EnterDate, T.ExitDa' +
      'te) / 60.0) as Hours'#13#10'FROM'#13#10'        TMC_TimeControl T'#13#10'WHERE'#13#10'  ' +
      '      T.IDPessoa = :IDPessoa'#13#10'        AND'#13#10'        T.IDStore = :' +
      'IDStore'#13#10'        AND'#13#10'        DatePart(Week, T.EnterDate) = :Gro' +
      'upIndex'#13#10'ORDER BY'#13#10'        T.EnterDate'#13#10
    CommandTimeout = 180
    DataSource = dsBrowse
    MasterFields = 'IDPessoa;IDStore;GroupIndex'
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'GroupIndex'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 620
    Top = 291
    object quTimeIDTime: TIntegerField
      FieldName = 'IDTime'
    end
    object quTimeEnterDate: TDateTimeField
      FieldName = 'EnterDate'
      DisplayFormat = 'ddddd'
    end
    object quTimeExitDate: TDateTimeField
      FieldName = 'ExitDate'
      DisplayFormat = 'ddddd'
    end
    object quTimeHours: TFloatField
      FieldName = 'Hours'
      DisplayFormat = '#,##0.00'
    end
    object quTimeIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
  end
end
