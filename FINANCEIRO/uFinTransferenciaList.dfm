inherited FinTransferenciaList: TFinTransferenciaList
  Left = 9
  Top = 95
  HelpContext = 22
  Caption = 'FinTransferenciaList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited EspacamentoEsquerdo: TPanel
    Top = 122
    Height = 305
  end
  inherited EspacamentoDireito: TPanel
    Top = 122
    Height = 305
  end
  inherited pnlBasicFilter: TPanel
    Height = 46
    Visible = True
    object Label4: TLabel [0]
      Left = 11
      Top = 13
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Start date :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 196
      Top = 13
      Width = 55
      Height = 13
      Alignment = taRightJustify
      Caption = 'End date :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited pnlExecuta: TPanel
      Height = 46
      Visible = True
      inherited pnlExecutaAviso: TPanel
        Height = 37
        inherited btExecuta: TButton
          Height = 30
        end
      end
    end
    object dbFim: TDateBox
      Left = 256
      Top = 10
      Width = 101
      Height = 21
      TabOrder = 1
    end
    object dbInicio: TDateBox
      Left = 80
      Top = 10
      Width = 105
      Height = 21
      TabOrder = 2
    end
  end
  inherited pnlBrowse: TPanel
    Top = 122
    Height = 305
    inherited brwGrid: TdxDBGrid
      Height = 265
      KeyField = 'IDTransferencia'
      Filter.Criteria = {00000000}
      object brwGridIDTransferencia: TdxDBGridMaskColumn
        Width = 80
        BandIndex = 0
        RowIndex = 0
        FieldName = 'IDTransferencia'
      end
      object brwGridData: TdxDBGridDateColumn
        Width = 89
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Data'
      end
      object brwGridUsuario: TdxDBGridMaskColumn
        Width = 137
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Usuario'
      end
      object brwGridContaDebito: TdxDBGridMaskColumn
        Width = 159
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ContaDebito'
      end
      object brwGridContaCredito: TdxDBGridMaskColumn
        Width = 159
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ContaCredito'
      end
      object brwGridValor: TdxDBGridMaskColumn
        Width = 93
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Valor'
      end
      object brwGridObs: TdxDBGridBlobColumn
        Visible = False
        Width = 56
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Obs'
      end
    end
    inherited pnlCountLine: TPanel
      Top = 287
    end
  end
  inherited bmMDI: TdxBarManager [6]
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
  inherited ilSmallButtons: TImageList [7]
  end
  inherited siLang: TsiLangRT [8]
    StorageFile = 'OM_FinTransferenciaList.sil'
  end
  inherited quBrowse: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10'        T.IDTransferencia,'#13#10'        CD.Numero as ContaDe' +
      'bito,'#13#10'        CC.Numero as ContaCredito,'#13#10'        U.SystemUser ' +
      'as Usuario,'#13#10'        T.Data,'#13#10'        T.Valor,'#13#10'        T.Obs'#13#10'F' +
      'ROM'#13#10'        Fin_Transferencia T (NOLOCK)'#13#10'        JOIN Fin_Cont' +
      'aCorrente CD ON (T.IDContaCorrenteDebito = CD.IDContaCorrente)'#13#10 +
      '        JOIN Fin_ContaCorrente CC ON (T.IDContaCorrenteCredito =' +
      ' CC.IDContaCorrente)'#13#10'        JOIN SystemUser U ON (T.IDUsuario ' +
      '= U.IDUser)'#13#10#13#10'ORDER BY'#13#10'        T.Data DESC'#13#10
    object quBrowseIDTransferencia: TIntegerField
      DisplayLabel = 'Transfer ID'
      FieldName = 'IDTransferencia'
    end
    object quBrowseContaDebito: TStringField
      DisplayLabel = 'Debit Acc.'
      FieldName = 'ContaDebito'
      Size = 35
    end
    object quBrowseContaCredito: TStringField
      DisplayLabel = 'Credit Acc.'
      FieldName = 'ContaCredito'
      Size = 35
    end
    object quBrowseUsuario: TStringField
      DisplayLabel = 'User'
      FieldName = 'Usuario'
      Size = 35
    end
    object quBrowseData: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'Data'
      DisplayFormat = 'ddddd'
    end
    object quBrowseValor: TFloatField
      DisplayLabel = 'Amount'
      FieldName = 'Valor'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseObs: TMemoField
      DisplayLabel = 'Memo'
      FieldName = 'Obs'
      BlobType = ftMemo
    end
  end
  inherited BrowseConfig: TBrowseConfig
    MostraDesativado = STD_AMBOSDESATIVADO
    MostraHidden = STD_AMBOSHIDDEN
    AutoOpen = False
    CheckSystemOnDelete = False
    RealDeletion = True
    FchClassName = 'TFinTransferenciaFch'
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
  inherited cpList: TdxComponentPrinter
    inherited cpListGridLink: TdxDBGridReportLink
      DateTime = 37404.733705
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
