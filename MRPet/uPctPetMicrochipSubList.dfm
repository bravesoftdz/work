inherited PctPetMicrochipSubList: TPctPetMicrochipSubList
  Caption = 'PctPetMicrochipSubList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlRight: TPanel
    inherited btnOpen: TXiButton
      Top = 54
      Enabled = False
      Visible = False
    end
    inherited btnDelete: TXiButton
      Top = 28
    end
  end
  inherited pnlClient: TPanel
    inherited grdList: TcxGrid
      inherited grdListDBTableView: TcxGridDBTableView
        OnDblClick = nil
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
      end
    end
  end
  inherited ConfigList: TmrConfigList
    Connection = 'PetCenterConn'
    ProviderName = 'dspPetMicrochip'
    FchClassName = 'TPctPetMicrochipFch'
    CommandOptions = [tcoInsert, tcoDelete]
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 39270.605308333330000000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
