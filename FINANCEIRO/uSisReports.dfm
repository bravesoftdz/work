inherited SisReports: TSisReports
  Left = -6
  Top = 32
  Caption = 'SisReports'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Top = 111
    Height = 468
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 111
    Height = 468
  end
  inherited EspacamentoDireito: TPanel
    Top = 111
    Height = 468
  end
  inherited EspacamentoSuperior: TPanel
    Height = 83
    inherited pnlBasicFilter: TPanel
      Height = 83
      inherited pnlExecuta: TPanel
        Height = 83
        inherited pnlAviso: TPanel
          Top = 20
          inherited btExecuta: TSpeedButton
            OnClick = btExecutaClick
          end
        end
      end
      inline FrameFilterAcc: TFrameFilterAcc
        Width = 734
        Height = 83
        Align = alClient
        TabOrder = 1
      end
    end
  end
  inherited Panel4: TPanel
    Top = 111
    Height = 468
    inherited gridRep: TdxDBGrid
      Height = 436
      OnDblClick = gridRepDblClick
      Filter.Criteria = {00000000}
    end
    inherited pnlFields: TPanel
      Top = 436
    end
  end
  inherited ppViewer: TppViewer
    Top = 111
    Height = 468
  end
  inherited ilSmallButtons: TImageList [7]
  end
  inherited OpenDialog: TOpenDialog [8]
  end
  inherited siLang: TsiLangRT [9]
    StorageFile = 'OM_SisReports.sil'
  end
  inherited bmMDI: TdxBarManager [10]
    Bars = <
      item
        Caption = 'Edit'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 276
        FloatTop = 216
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btnNew
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnEdit
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnRemove
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = btnOpen
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnSave
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnCopy
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = barFilter
            UserGlyph.Data = {00000000}
            Visible = True
          end>
        Name = 'Edit'
        OneOnRow = False
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = 'View'
        DockedDockingStyle = dsTop
        DockedLeft = 321
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 276
        FloatTop = 216
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btnFull
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnWidth
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnAll
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = btnStopPrint
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = btnFirst
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnPrior
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = edtPagNum
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnNext
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = btnLast
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = btnPrint
            UserGlyph.Data = {00000000}
            Visible = True
          end>
        Name = 'View'
        OneOnRow = False
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      28
      0)
    inherited btnNew: TdxBarButton
      OnClick = btnNewClick
    end
    inherited btnEdit: TdxBarButton
      OnClick = btnEditClick
    end
    inherited btnRemove: TdxBarButton
      OnClick = btnRemoveClick
    end
    inherited btnOpen: TdxBarButton
      OnClick = btnOpenClick
    end
    inherited btnSave: TdxBarButton
      OnClick = btnSaveClick
    end
    inherited btnSaveFilters: TdxBarButton
      OnClick = btnSaveFilterClick
    end
    inherited barFilter: TdxBarSubItem
      OnClick = barFilterClick
      ItemLinks = <
        item
          Item = btnSaveFilters
          UserGlyph.Data = {00000000}
          Visible = True
        end
        item
          BeginGroup = True
          Item = btnDelFilters
          UserGlyph.Data = {00000000}
          Visible = True
        end>
    end
    inherited btnDelFilters: TdxBarButton
      OnClick = btnDelFiltersClick
    end
    inherited btnAppendFilters: TdxBarButton
      OnClick = btnAppendFiltersClick
    end
  end
  inherited quReport: TADODataSet [12]
    OnNewRecord = quReportNewRecord
  end
  inherited trmAviso: TTimer [13]
  end
  inherited quSelectedReport: TADODataSet
    OnNewRecord = quSelectedReportNewRecord
    CommandText = 
      'SELECT'#13#10#9'RI.ItemID,'#13#10#9'RI.FolderID,'#13#10#9'RI.Name,'#13#10#9'RI.Template'#13#10'FRO' +
      'M'#13#10#9'Rep_Item RI'#13#10'WHERE'#13#10#9'RI.ItemID = :ItemID'#13#10
    object quSelectedReportItemID: TIntegerField [0]
      FieldName = 'ItemID'
    end
  end
  inherited ppDesigner: TppDesigner
    OnCloseQuery = ppDesignerCloseQuery
  end
  inherited ppReport: TppReport
    DataPipelineName = 'ppPipeline'
    inherited ppDetailBand2: TppDetailBand
      inherited ppDBText9: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText10: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText11: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText12: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText13: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText14: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText15: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText16: TppDBText
        DataPipelineName = 'ppPipeline'
      end
    end
  end
  inherited ppModelo: TppReport
    DataPipelineName = 'ppPipeline'
    inherited ppDetailBand1: TppDetailBand
      inherited ppDBText1: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText2: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText3: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText4: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText5: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText6: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText7: TppDBText
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBText8: TppDBText
        DataPipelineName = 'ppPipeline'
      end
    end
    inherited ppSummaryBand1: TppSummaryBand
      inherited ppDBCalc1: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBCalc2: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBCalc3: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBCalc5: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBCalc4: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBCalc6: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
      inherited ppDBCalc7: TppDBCalc
        DataPipelineName = 'ppPipeline'
      end
    end
  end
end
