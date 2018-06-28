inherited ParentToolBarSubList: TParentToolBarSubList
  Caption = 'ParentToolBarSubList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlLeft: TPanel
    Top = 111
    Height = 252
  end
  inherited pnlRight: TPanel
    Top = 111
    Height = 252
  end
  inherited pnlClient: TPanel
    Top = 111
    Height = 252
    inherited grdList: TcxGrid
      Height = 252
      inherited grdListDBTableView: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
      end
    end
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 39269.490849421290000000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
  object bmList: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Bars = <
      item
        AllowQuickCustomizing = False
        BorderStyle = bbsNone
        Caption = 'List'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 276
        FloatTop = 216
        FloatClientWidth = 23
        FloatClientHeight = 22
        IsMainMenu = True
        ItemLinks = <
          item
            Item = bbNew
            Visible = True
          end
          item
            Item = bbOpen
            Visible = True
          end
          item
            Item = bbRemove
            Visible = True
          end>
        MultiLine = True
        Name = 'List'
        NotDocking = [dsNone, dsLeft, dsRight, dsBottom]
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end>
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 136
    Top = 276
    DockControlHeights = (
      0
      0
      22
      0)
    object bbNew: TdxBarButton
      Caption = 'Novo'
      Category = 0
      Hint = 'Novo'
      Visible = ivAlways
      OnClick = OnInsertClick
    end
    object bbOpen: TdxBarButton
      Caption = 'Abrir'
      Category = 0
      Hint = 'Abrir'
      Visible = ivAlways
      OnClick = OnOpenClick
    end
    object bbRemove: TdxBarButton
      Caption = 'Excluir'
      Category = 0
      Hint = 'Excluir'
      Visible = ivAlways
      OnClick = OnDeleteClick
    end
  end
end
