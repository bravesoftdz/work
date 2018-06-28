inherited ParentListInfo: TParentListInfo
  Caption = 'ParentListInfo'
  ClientWidth = 656
  Color = clCaptionText
  PixelsPerInch = 96
  TextHeight = 13
  inherited EspacamentoDireito: TPanel
    Left = 653
  end
  inherited EspacamentoSuperior: TPanel
    Width = 656
    inherited imgOff: TImage
      Left = -222
    end
    inherited imgOn: TImage
      Left = 217
    end
  end
  inherited pnlEspacamentoInferiror: TPanel
    Width = 656
  end
  object grid: TdxDBGrid [4]
    Left = 2
    Top = 48
    Width = 376
    Height = 332
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'IDContaCorrente'
    ShowGroupPanel = True
    ShowSummaryFooter = True
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alLeft
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    BandFont.Charset = ANSI_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'Tahoma'
    BandFont.Style = []
    DataSource = dsBrowse
    Filter.Criteria = {00000000}
    GroupPanelColor = clHighlightText
    GroupPanelFontColor = clBackground
    GroupNodeColor = clHighlightText
    GroupNodeTextColor = clBackground
    HeaderColor = clHighlightText
    HeaderFont.Charset = ANSI_CHARSET
    HeaderFont.Color = clNavy
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    HideFocusRect = True
    LookAndFeel = lfUltraFlat
    OptionsBehavior = [edgoDragScroll]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords]
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoHideFocusRect, edgoHotTrack, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'Tahoma'
    PreviewFont.Style = []
    RowFooterColor = clBtnHighlight
    RowFooterTextColor = clBackground
    ShowGrid = False
    ShowPreviewGrid = False
    ShowRowFooter = True
    OnCustomDrawCell = gridCustomDrawCell
    OnCustomDraw = gridCustomDraw
  end
  inherited bmMDI: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      0
      0)
  end
  object quBrowse: TPowerADOQuery
    Connection = DM.DBADOConnection
    CommandTimeout = 180
    Parameters = <>
    Left = 417
    Top = 134
  end
  object dsBrowse: TDataSource
    DataSet = quBrowse
    Left = 417
    Top = 190
  end
end
