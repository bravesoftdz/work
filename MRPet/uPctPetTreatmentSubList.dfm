inherited PctPetTreatmentSubList: TPctPetTreatmentSubList
  Caption = 'PctPetTreatmentSubList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlRight: TPanel
    object Bevel1: TBevel [0]
      Left = 6
      Top = 78
      Width = 67
      Height = 5
      Shape = bsTopLine
    end
    object btnViewNotes: TXiButton
      Left = 2
      Top = 82
      Width = 75
      Height = 24
      Hint = 'Show/Hide Notes'
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Notes'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnViewNotesClick
    end
  end
  inherited pnlClient: TPanel
    inherited grdList: TcxGrid
      inherited grdListDBTableView: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
      end
    end
  end
  inherited ConfigList: TmrConfigList
    Connection = 'PetCenterConn'
    ProviderName = 'dspPetTreatment'
    FchClassName = 'TPctPetTreatmentFch'
    LogicalDelete = False
    CommandOptions = [tcoInsert, tcoOpen, tcoDelete]
    PreviewGridField = 'Notes'
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 39272.750986863420000000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
