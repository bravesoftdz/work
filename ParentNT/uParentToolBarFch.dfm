inherited ParentToolBarFch: TParentToolBarFch
  Caption = 'ParentToolBarFch'
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel [1]
    Left = 0
    Top = 253
    Width = 452
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    DesignSize = (
      452
      45)
    object btnOk: TButton
      Left = 214
      Top = 8
      Width = 75
      Height = 36
      Anchors = [akTop, akRight]
      Caption = '&Ok'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 293
      Top = 8
      Width = 75
      Height = 36
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 373
      Top = 8
      Width = 75
      Height = 36
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited dsFch: TDataSource
    Left = 352
  end
  object bmFch: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Bars = <
      item
        AllowQuickCustomizing = False
        BorderStyle = bbsNone
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
        Name = 'Fch'
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
    Left = 400
    Top = 12
    DockControlHeights = (
      0
      0
      22
      0)
    object bbPrint: TdxBarButton
      Caption = '&Imprimir'
      Category = 0
      Hint = 'Imprimir'
      Visible = ivAlways
      OnClick = OnPrintClick
    end
    object bbFirst: TdxBarButton
      Caption = '&Primeiro'
      Category = 0
      Hint = 'Primeiro'
      Visible = ivAlways
      OnClick = OnFirstClick
    end
    object bbPrior: TdxBarButton
      Caption = '&Anterior'
      Category = 0
      Hint = 'Anterior'
      Visible = ivAlways
      OnClick = OnPriorClick
    end
    object bbNext: TdxBarButton
      Caption = '&Proximo'
      Category = 0
      Hint = 'Proximo'
      Visible = ivAlways
      OnClick = OnNextClick
    end
    object bbLast: TdxBarButton
      Caption = '&Ultimo'
      Category = 0
      Hint = 'Ultimo'
      Visible = ivAlways
      OnClick = OnLastClick
    end
    object bbLoop: TdxBarButton
      Caption = '&Loop'
      Category = 0
      Hint = 'Loop'
      Visible = ivAlways
      OnClick = OnLoopClick
    end
  end
end
