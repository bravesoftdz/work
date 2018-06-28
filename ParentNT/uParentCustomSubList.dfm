inherited ParentCustomSubList: TParentCustomSubList
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'ParentCustomSubList'
  ClientHeight = 404
  ClientWidth = 540
  Visible = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    Width = 540
    inherited pnlImage: TPanel
      Width = 540
    end
    inherited pnlFilter: TPanel
      Width = 540
    end
  end
  inherited pnlBottom: TPanel
    Top = 363
    Width = 540
    Color = 13752539
  end
  inherited pnlLeft: TPanel
    Height = 274
    Color = 13752539
  end
  inherited pnlRight: TPanel
    Left = 499
    Height = 274
    Color = 13752539
  end
  inherited pnlClient: TPanel
    Width = 458
    Height = 274
    inherited grdList: TcxGrid
      Width = 458
      Height = 274
      inherited grdListDBTableView: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        Filtering.Visible = fvNever
        OptionsCustomize.ColumnFiltering = False
      end
    end
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 39269.489959490740000000
      PrinterPage.Footer = 161290
      PrinterPage.Header = 85801
      PrinterPage.Margins.Bottom = 322580
      PrinterPage.Margins.Left = 322580
      PrinterPage.Margins.Right = 322580
      PrinterPage.Margins.Top = 322580
      PrinterPage.PageSize.X = 5334178
      PrinterPage.PageSize.Y = 7543851
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
    end
  end
end
