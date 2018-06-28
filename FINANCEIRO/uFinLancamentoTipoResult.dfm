inherited FinLancamentoTipoResult: TFinLancamentoTipoResult
  Width = 770
  Height = 630
  Caption = 'FinLancamentoTipoResult'
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter [0]
    Left = 109
    Top = 167
    Width = 4
    Height = 433
    Cursor = crHSplit
    Color = clBtnFace
    MinSize = 1
    ParentColor = False
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 167
    Height = 433
  end
  inherited EspacamentoDireito: TPanel
    Left = 762
    Top = 167
    Height = 433
  end
  inherited EspacamentoSuperior: TPanel
    Width = 762
    inherited imgOn: TImage
      Left = 323
    end
    inherited imgOff: TImage
      Left = -116
    end
  end
  inherited pnlBasicFilter: TPanel
    Width = 762
    Height = 91
    Visible = True
    object Label2: TLabel [0]
      Left = 85
      Top = 56
      Width = 34
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'to'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btSelEmpresa: TSpeedButton [1]
      Left = 402
      Top = 4
      Width = 140
      Height = 21
      AllowAllUp = True
      GroupIndex = 999
      Caption = 'Select company'
      OnClick = btSelEmpresaClick
    end
    object Label1: TLabel [2]
      Left = 241
      Top = 6
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Records :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbStartBalance: TLabel [3]
      Left = 26
      Top = 7
      Width = 82
      Height = 13
      Alignment = taRightJustify
      Caption = 'Start Balance :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited pnlExecuta: TPanel
      Left = 697
      Height = 91
      Caption = ''
      TabOrder = 7
      Visible = True
      inherited pnlExecutaAviso: TPanel
        Top = 26
      end
    end
    object cmbData: TComboBox
      Left = 3
      Top = 28
      Width = 197
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'Due Date'
      Items.Strings = (
        'Due Date'
        'Payment Day')
    end
    object dbInicio: TDateBox
      Left = 3
      Top = 52
      Width = 78
      Height = 21
      TabOrder = 2
      InputTime = False
    end
    object dbFim: TDateBox
      Left = 112
      Top = 52
      Width = 88
      Height = 21
      TabOrder = 3
      InputTime = False
    end
    object cbxHideZeros: TCheckBox
      Left = 242
      Top = 52
      Width = 163
      Height = 17
      Caption = 'Hide zero amounts'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 6
    end
    object cmbSituacao: TComboBox
      Left = 296
      Top = 3
      Width = 94
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'Open'
        'Partial Payment'
        'History'
        'Canceled'
        'All')
    end
    object edtStartBalance: TDateBox
      Left = 112
      Top = 3
      Width = 88
      Height = 21
      TabOrder = 0
      InputTime = False
    end
    object chkInterest: TCheckBox
      Left = 242
      Top = 31
      Width = 179
      Height = 17
      Caption = 'Add Interest'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 600
    Width = 762
  end
  inherited pnlBrowse: TPanel
    Left = 113
    Top = 167
    Width = 649
    Height = 433
    inherited pnlGenFilter: TPanel
      Width = 649
    end
    inherited brwGrid: TdxDBGrid
      Width = 649
      Height = 393
      KeyField = 'IDLancamentoTipo'
      ShowSummaryFooter = True
      SummaryGroups = <
        item
          DefaultGroup = True
          SummaryItems = <
            item
              ColumnName = 'brwGridPreviousBalance'
              SummaryField = 'PreviousBalance'
              SummaryFormat = '#,##0.00'
              SummaryType = cstMax
              OnSummary = brwGridSummaryGroups0SummaryItems0Summary
            end
            item
              ColumnName = 'brwGridAmount'
              SummaryField = 'Amount'
              SummaryFormat = '#,##0.00'
              SummaryType = cstMax
              OnSummary = brwGridSummaryGroups0SummaryItems1Summary
            end
            item
              ColumnName = 'brwGridActualBalace'
              SummaryField = 'ActualBalace'
              SummaryFormat = '#,##0.00'
              SummaryType = cstMax
              OnSummary = brwGridSummaryGroups0SummaryItems2Summary
            end>
          Name = 'brwGridSummaryGroup2'
        end>
      Filter.Criteria = {00000000}
      ShowRowFooter = True
      object brwGridIDLancamentoTipo: TdxDBGridColumn
        Caption = 'ID'
        Visible = False
        Width = 31
        BandIndex = 0
        RowIndex = 0
        FieldName = 'IDLancamentoTipo'
      end
      object brwGridAccountCode: TdxDBGridMaskColumn
        Width = 149
        BandIndex = 0
        RowIndex = 0
        FieldName = 'AccountCode'
      end
      object brwGridRecordType: TdxDBGridMaskColumn
        Width = 186
        BandIndex = 0
        RowIndex = 0
        FieldName = 'RecordType'
      end
      object brwGridPreviousBalance: TdxDBGridCurrencyColumn
        Width = 105
        BandIndex = 0
        RowIndex = 0
        FieldName = 'PreviousBalance'
        SummaryFooterType = cstMax
        SummaryFooterField = 'PreviousBalance'
        SummaryFooterFormat = '#,##0.00;-#,##0.00'
        OnSummaryFooter = brwGridPreviousBalanceSummaryFooter
        DisplayFormat = '#,##0.00;-#,##0.00'
        Nullable = False
      end
      object brwGridAmount: TdxDBGridCurrencyColumn
        Width = 86
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Amount'
        SummaryFooterType = cstMax
        SummaryFooterField = 'Amount'
        SummaryFooterFormat = '#,##0.00;-#,##0.00'
        OnSummaryFooter = brwGridAmountSummaryFooter
        DisplayFormat = '#,##0.00;-#,##0.00'
        Nullable = False
      end
      object brwGridActualBalace: TdxDBGridCurrencyColumn
        Width = 90
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ActualBalace'
        SummaryFooterType = cstMax
        SummaryFooterField = 'ActualBalace'
        SummaryFooterFormat = '#,##0.00;-#,##0.00'
        OnSummaryFooter = brwGridActualBalaceSummaryFooter
        DisplayFormat = '#,##0.00;-#,##0.00'
        Nullable = False
      end
      object brwGridAccType: TdxDBGridColumn
        Sorted = csUp
        Visible = False
        BandIndex = 0
        RowIndex = 0
        FieldName = 'AccType'
        GroupIndex = 0
      end
    end
    inherited pnlCountLine: TPanel
      Top = 415
      Width = 649
      inherited pnlDivisor: TPanel
        Width = 649
      end
    end
  end
  object pnlEmpresa: TPanel [7]
    Left = 0
    Top = 167
    Width = 109
    Height = 433
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 10
    object lvEmpresa: TListView
      Left = 0
      Top = 20
      Width = 109
      Height = 413
      Align = alClient
      Checkboxes = True
      Columns = <>
      SortType = stText
      TabOrder = 0
      ViewStyle = vsList
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 109
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Button1: TButton
        Left = 0
        Top = 0
        Width = 52
        Height = 19
        Caption = 'All'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 54
        Top = 0
        Width = 55
        Height = 19
        Caption = 'None'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  inherited ilSmallButtons: TImageList [8]
  end
  inherited quBrowse: TPowerADOQuery [9]
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'SELECT'#13#10#9'LT.IDLancamentoTipo,'#13#10#9'LT.CodigoContabil AS AccountCode' +
      ','#13#10#9'LT.LancamentoTipo as RecordType,'#13#10#9'LT.IDLancamentoTipoParent' +
      ','#13#10#9'LT.Pagando,'#13#10#9'CAST(0.00 as Money) as Amount,'#13#10#9'CAST(0.00 as ' +
      'Money) as PreviousBalance,'#13#10#9'CAST(0.00 as Money) as ActualBalace' +
      #13#10'FROM'#13#10#9'Fin_LancamentoTipo LT (NOLOCK) '#13#10'ORDER BY'#13#10#9'LT.Pagando,' +
      #13#10#9'LT.CodigoContabil'
    Parameters = <
      item
        Name = 'DataIni'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DataEnd'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    Top = 204
    object quBrowseIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quBrowseAccountCode: TStringField
      FieldName = 'AccountCode'
      Size = 35
    end
    object quBrowseRecordType: TStringField
      FieldName = 'RecordType'
      Size = 65
    end
    object quBrowseIDLancamentoTipoParent: TIntegerField
      FieldName = 'IDLancamentoTipoParent'
    end
    object quBrowseAmount: TBCDField
      FieldName = 'Amount'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowsePreviousBalance: TBCDField
      FieldName = 'PreviousBalance'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseActualBalace: TBCDField
      FieldName = 'ActualBalace'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowsePagando: TBooleanField
      FieldName = 'Pagando'
    end
    object quBrowseAccType: TStringField
      FieldKind = fkCalculated
      FieldName = 'AccType'
      Calculated = True
    end
  end
  object cdsBrowser: TClientDataSet [10]
    Aggregates = <>
    Params = <
      item
        DataType = ftDateTime
        Name = 'DataIni'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DataEnd'
        ParamType = ptInput
      end>
    ProviderName = 'dspBrowser'
    Left = 30
    Top = 300
    object cdsBrowserIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object cdsBrowserAccountCode: TStringField
      FieldName = 'AccountCode'
      Size = 35
    end
    object cdsBrowserRecordType: TStringField
      FieldName = 'RecordType'
      Size = 65
    end
    object cdsBrowserIDLancamentoTipoParent: TIntegerField
      FieldName = 'IDLancamentoTipoParent'
    end
    object cdsBrowserAmount: TBCDField
      FieldName = 'Amount'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsBrowserPreviousBalance: TBCDField
      FieldName = 'PreviousBalance'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsBrowserActualBalace: TBCDField
      FieldName = 'ActualBalace'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsBrowserPagando: TBooleanField
      FieldName = 'Pagando'
    end
    object cdsBrowserAccType: TStringField
      FieldName = 'AccType'
      ReadOnly = True
    end
  end
  inherited cpList: TdxComponentPrinter [11]
    inherited cpListGridLink: TdxDBGridReportLink
      DateTime = 40056.7677569792
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
  object dspBrowser: TDataSetProvider [12]
    DataSet = quBrowse
    Constraints = True
    Left = 30
    Top = 350
  end
  object quSaldo: TPowerADOQuery [13]
    Connection = DM.DBADOConnection
    OnCalcFields = quSaldoCalcFields
    CommandText = 
      'SELECT'#13#10#9'FT.IDLancamentoTipo,'#13#10#9'FT.IDLancamentoTipoParent,'#13#10#9'FT.' +
      'CodigoContabil,'#13#10#9'SUM(F.ValorNominal) as ValorNominal,'#13#10#9'SUM(F.T' +
      'otalJuros) as Juros'#13#10'FROM'#13#10#9'Fin_Lancamento F (NOLOCK)'#13#10#9'JOIN Fin' +
      '_LancamentoTipo FT (NOLOCK) ON (F.IDLancamentoTipo = FT.IDLancam' +
      'entoTipo)'#13#10'WHERE'#13#10#9'((IsNull(F.LancamentoType,0) = 0) OR (F.Lanca' +
      'mentoType = 2))'#13#10#9'AND'#13#10#9'F.Hidden = 0'#13#10'GROUP BY'#13#10#9'FT.IDLancamento' +
      'Tipo,'#13#10#9'FT.IDLancamentoTipoParent,'#13#10#9'FT.CodigoContabil'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 312
    Top = 354
    object quSaldoIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quSaldoIDLancamentoTipoParent: TIntegerField
      FieldName = 'IDLancamentoTipoParent'
    end
    object quSaldoCodigoContabil: TStringField
      FieldName = 'CodigoContabil'
      Size = 35
    end
    object quSaldoValorNominal: TBCDField
      FieldName = 'ValorNominal'
      ReadOnly = True
      Precision = 19
    end
    object quSaldoJuros: TBCDField
      FieldName = 'Juros'
      ReadOnly = True
      Precision = 19
    end
    object quSaldoAmount: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Amount'
      Calculated = True
    end
  end
  object quSaldoAnterior: TPowerADOQuery [14]
    Connection = DM.DBADOConnection
    OnCalcFields = quSaldoAnteriorCalcFields
    CommandText = 
      'SELECT'#13#10#9'FT.IDLancamentoTipo,'#13#10#9'IDLancamentoTipoParent,'#13#10#9'FT.Cod' +
      'igoContabil,'#13#10#9'SUM(F.ValorNominal) as ValorNominal,'#13#10#9'SUM(F.Tota' +
      'lJuros) as Juros'#13#10'FROM'#13#10#9'Fin_Lancamento F (NOLOCK)'#13#10#9'JOIN Fin_La' +
      'ncamentoTipo FT (NOLOCK) ON (F.IDLancamentoTipo = FT.IDLancament' +
      'oTipo)'#13#10'WHERE'#13#10#9'((IsNull(F.LancamentoType,0) = 0) OR (F.Lancamen' +
      'toType = 2))'#13#10#9'AND'#13#10#9'F.Hidden = 0'#13#10'GROUP BY'#13#10#9'FT.IDLancamentoTip' +
      'o,'#13#10#9'FT.IDLancamentoTipoParent,'#13#10#9'FT.CodigoContabil'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 312
    Top = 409
    object quSaldoAnteriorIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quSaldoAnteriorIDLancamentoTipoParent: TIntegerField
      FieldName = 'IDLancamentoTipoParent'
    end
    object quSaldoAnteriorCodigoContabil: TStringField
      FieldName = 'CodigoContabil'
      Size = 35
    end
    object quSaldoAnteriorValorNominal: TBCDField
      FieldName = 'ValorNominal'
      ReadOnly = True
      Precision = 19
    end
    object quSaldoAnteriorJuros: TBCDField
      FieldName = 'Juros'
      ReadOnly = True
      Precision = 19
    end
    object quSaldoAnteriorAmount: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Amount'
      Calculated = True
    end
  end
  inherited siLang: TsiLangRT [15]
    StorageFile = 'OM_FinLancamentoTipoResult.sil'
  end
  inherited dsBrowse: TDataSource
    DataSet = cdsBrowser
    Top = 250
  end
  inherited BrowseConfig: TBrowseConfig
    AutoOpen = False
  end
  inherited bpmDetail: TdxBarPopupMenu
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
  end
  inherited bpmHeader: TdxBarPopupMenu
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
  inherited bpmSummary: TdxBarPopupMenu
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
  inherited bmMDI: TdxBarManager [24]
    Bars = <
      item
        Caption = 'List'
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
          end>
        Name = 'List'
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = 'View'
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
        Name = 'View'
        OneOnRow = True
        Row = 1
        UseOwnFont = False
        Visible = False
        WholeRow = False
      end>
    CanCustomize = False
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
    DockControlHeights = (
      0
      0
      28
      0)
    inherited bbListaRemove: TdxBarButton
      Enabled = False
    end
    inherited bdcFiltraData: TdxBarDateCombo
      Enabled = False
    end
    inherited beFiltraTexto: TdxBarEdit
      Enabled = False
    end
    inherited bbDetailFiltraCampo: TdxBarButton
      Enabled = False
    end
    inherited bbDetailFIltraExcluindoCampo: TdxBarButton
      Enabled = False
    end
    inherited bbDetailRemoveFiltro: TdxBarButton
      Enabled = False
    end
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
    inherited bbDetailClassificacaoCre: TdxBarButton
      Enabled = False
    end
    inherited bbDetailClassificaoDesc: TdxBarButton
      Enabled = False
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
  end
  inherited pmFilterBar: TPopupMenu [25]
  end
  inherited quVisao: TADOQuery [26]
  end
  inherited dsVisao: TDataSource [27]
  end
end
