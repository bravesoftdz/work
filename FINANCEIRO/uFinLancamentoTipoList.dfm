inherited FinLancamentoTipoList: TFinLancamentoTipoList
  Left = 37
  Top = 54
  HelpContext = 35
  Caption = 'FinLancamentoTipoList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBrowse: TPanel
    inherited brwGrid: TdxDBGrid
      KeyField = 'IDLancamentoTipo'
      Filter.Criteria = {00000000}
      object brwGridCodigoContabil: TdxDBGridMaskColumn
        Sorted = csUp
        BandIndex = 0
        RowIndex = 0
        FieldName = 'CodigoContabil'
      end
      object brwGridLancamentoTipo: TdxDBGridMaskColumn
        Caption = 'RecordType'
        BandIndex = 0
        RowIndex = 0
        FieldName = 'LancamentoTipo'
      end
      object brwGridTipo: TdxDBGridMaskColumn
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Tipo'
      end
      object brwGridGroup: TdxDBGridColumn
        Visible = False
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Path'
      end
    end
  end
  inherited SaveDialog: TSaveDialog [6]
  end
  inherited bpmDetail: TdxBarPopupMenu [7]
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
  inherited siLang: TsiLangRT [8]
    StorageFile = 'OM_FinLancamentoTipoList.sil'
  end
  inherited bmMDI: TdxBarManager [9]
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
            Item = bbListaNovo
            UserGlyph.Data = {00000000}
            Visible = True
          end
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
            Item = bbListaRestore
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
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
            Item = cbxStatus
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
  end
  inherited ilSmallButtons: TImageList [10]
  end
  inherited quBrowse: TPowerADOQuery [11]
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'SELECT'#13#10'      LT.IDLancamentoTipo,'#13#10'      LT.CodigoContabil,'#13#10'  ' +
      '    LT.LancamentoTipo,'#13#10'      LT.Path,'#13#10'      LT.Pagando'#13#10'FROM'#13#10 +
      '      Fin_LancamentoTipo LT'
    Top = 209
    object quBrowseIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
      Origin = 'RETAILDB.Fin_LancamentoTipo.IDLancamentoTipo'
    end
    object quBrowseCodigoContabil: TStringField
      DisplayLabel = 'Code'
      FieldName = 'CodigoContabil'
      Origin = 'RETAILDB.Fin_LancamentoTipo.CodigoContabil'
      Size = 35
    end
    object quBrowseLancamentoTipo: TStringField
      DisplayLabel = 'Record Type'
      FieldName = 'LancamentoTipo'
      Origin = 'RETAILDB.Fin_LancamentoTipo.LancamentoTipo'
      Size = 65
    end
    object quBrowsePath: TStringField
      DisplayLabel = 'Group'
      FieldName = 'Path'
      Size = 150
    end
    object quBrowsePagando: TBooleanField
      FieldName = 'Pagando'
    end
    object quBrowseTipo2: TStringField
      DisplayLabel = 'Type'
      FieldKind = fkCalculated
      FieldName = 'Tipo'
      Calculated = True
    end
  end
  inherited dsBrowse: TDataSource [12]
  end
  inherited BrowseConfig: TBrowseConfig [13]
    FchClassName = 'TFinLancamentoTipoFch'
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
  inherited cpList: TdxComponentPrinter
    inherited cpListGridLink: TdxDBGridReportLink
      DateTime = 37404.7336829861
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
