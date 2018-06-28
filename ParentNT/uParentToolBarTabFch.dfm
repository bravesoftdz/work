inherited ParentToolBarTabFch: TParentToolBarTabFch
  Caption = 'ParentToolBarTabFch'
  PixelsPerInch = 96
  TextHeight = 13
  object pcFch: TcxPageControl [2]
    Left = 0
    Top = 67
    Width = 452
    Height = 179
    Align = alClient
    TabOrder = 6
    ClientRectBottom = 179
    ClientRectRight = 452
    ClientRectTop = 0
  end
  inherited ConfigFch: TConfigFch
    OnAfterNavigation = ConfigFchAfterNavigation
  end
  inherited bmFch: TdxBarManager
    Bars = <
      item
        AllowQuickCustomizing = False
        Caption = 'Fch'
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
            Item = bbPrint
            Visible = True
          end
          item
            BeginGroup = True
            Item = bbFirst
            Visible = True
          end
          item
            Item = bbPrior
            Visible = True
          end
          item
            Item = bbNext
            Visible = True
          end
          item
            Item = bbLast
            Visible = True
          end
          item
            BeginGroup = True
            Item = bbLoop
            Visible = True
          end>
        MultiLine = True
        Name = 'Fch1'
        NotDocking = [dsNone, dsLeft, dsRight, dsBottom]
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end>
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      26
      0)
  end
end
