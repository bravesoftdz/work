inherited FinCentroCustoList: TFinCentroCustoList
  Left = 174
  Top = 158
  HelpContext = 31
  Caption = 'FinCentroCustoList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBrowse: TPanel
    inherited brwGrid: TdxDBGrid
      Filter.Criteria = {00000000}
      object brwGridCodigoCentroCusto: TdxDBGridMaskColumn
        Sorted = csUp
        BandIndex = 0
        RowIndex = 0
        FieldName = 'CodigoCentroCusto'
      end
      object brwGridCentroCusto: TdxDBGridMaskColumn
        BandIndex = 0
        RowIndex = 0
        FieldName = 'CentroCusto'
      end
    end
  end
  inherited bpmHeader: TdxBarPopupMenu [6]
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
  inherited bpmSummary: TdxBarPopupMenu [7]
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
  inherited siLang: TsiLangRT [8]
    StorageFile = 'OM_FinCentroCustoList.sil'
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
    CommandText = 
      'SELECT'#13#10#9'CC.IDCentroCusto,'#13#10#9'CC.CodigoCentroCusto,'#13#10#9'CC.CentroCu' +
      'sto'#13#10'FROM'#13#10#9'Fin_CentroCusto CC'
    object quBrowseIDCentroCusto: TIntegerField
      FieldName = 'IDCentroCusto'
      Origin = 'RETAILDB.Fin_CentroCusto.IDCentroCusto'
    end
    object quBrowseCodigoCentroCusto: TStringField
      DisplayLabel = 'Code'
      FieldName = 'CodigoCentroCusto'
      Origin = 'RETAILDB.Fin_CentroCusto.CodigoCentroCusto'
    end
    object quBrowseCentroCusto: TStringField
      DisplayLabel = 'Description'
      FieldName = 'CentroCusto'
      Origin = 'RETAILDB.Fin_CentroCusto.CentroCusto'
      Size = 35
    end
  end
  inherited dsBrowse: TDataSource [12]
  end
  inherited BrowseConfig: TBrowseConfig [13]
    FchClassName = 'TFinCentroCustoFch'
  end
  inherited SaveDialog: TSaveDialog [14]
  end
  inherited bpmDetail: TdxBarPopupMenu [15]
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
  inherited cpList: TdxComponentPrinter
    inherited cpListGridLink: TdxDBGridReportLink
      DateTime = 37404.7336317477
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
