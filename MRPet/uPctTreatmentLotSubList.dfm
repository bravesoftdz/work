inherited PctTreatmentLotSubList: TPctTreatmentLotSubList
  Caption = 'PctTreatmentLotSubList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClient: TPanel
    inherited grdList: TcxGrid
      inherited grdListDBTableView: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
      end
    end
  end
  inherited ConfigList: TmrConfigList
    Connection = 'PetCenterConn'
    ProviderName = 'dspTreatmentLot'
    FchClassName = 'TPctTreatmentLotFch'
    CommandOptions = [tcoInsert, tcoOpen, tcoDelete]
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 39272.711877708330000000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
