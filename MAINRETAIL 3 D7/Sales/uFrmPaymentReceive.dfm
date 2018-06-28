inherited FrmPaymentReceive: TFrmPaymentReceive
  Left = 52
  Top = 5
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Receiving'
  ClientHeight = 586
  ClientWidth = 671
  KeyPreview = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 546
    Width = 671
    Height = 40
    TabOrder = 1
    object lbCardError: TLabel [0]
      Left = 4
      Top = 9
      Width = 443
      Height = 29
      AutoSize = False
      Caption = 'lbCardError'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    inherited EspacamentoInferior: TPanel
      Width = 671
      inherited Panel3: TPanel
        Width = 671
      end
    end
    inherited hhh: TPanel
      Left = 520
      Height = 34
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Caption = '&Cancel'
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Left = 336
    Height = 540
    TabOrder = 2
  end
  inherited EspacamentoDireito: TPanel
    Left = 668
    Height = 540
    TabOrder = 3
  end
  inherited EspacamentoSuperior: TPanel
    Width = 671
    TabOrder = 4
  end
  object pnlPaymentList: TPanel [4]
    Left = 339
    Top = 6
    Width = 331
    Height = 540
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 5
    object pnlSubTotal: TPanel
      Left = 2
      Top = 49
      Width = 321
      Height = 43
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Shape5: TShape
        Left = 0
        Top = 0
        Width = 321
        Height = 43
        Align = alClient
        Brush.Color = 14671839
        Pen.Color = 13793052
      end
      object Label1: TLabel
        Left = 36
        Top = 13
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Payments :'
        Color = 14671839
        Font.Charset = ANSI_CHARSET
        Font.Color = 13793052
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
      end
      object lbPayments: TStaticText
        Left = 116
        Top = 9
        Width = 191
        Height = 24
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0.00'
        Color = 14671839
        Font.Charset = ANSI_CHARSET
        Font.Color = 13793052
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel2: TPanel
      Left = 3
      Top = 142
      Width = 319
      Height = 392
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 319
        Height = 392
        Align = alClient
        Pen.Color = 13793052
      end
      object btnRemovePayment: TSpeedButton
        Left = 292
        Top = 368
        Width = 23
        Height = 22
        Hint = 'Delete payment'
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnRemovePaymentClick
      end
      object grdPayments: TcxGrid
        Left = 1
        Top = 1
        Width = 294
        Height = 366
        BorderStyle = cxcbsNone
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdPaymentsDB: TcxGridDBTableView
          DataController.DataSource = dsPayments
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'ID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          Styles.Background = csBackground
          Styles.Group = csGroup
          object grdPaymentsDBIDMeioPag: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            Visible = False
            Width = 31
          end
          object grdPaymentsDBImageIndex: TcxGridDBColumn
            Caption = ' '
            DataBinding.FieldName = 'Image'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = DMGlobal.imgPayments
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 0
              end
              item
                ImageIndex = 1
                Value = 1
              end
              item
                ImageIndex = 2
                Value = 2
              end
              item
                ImageIndex = 3
                Value = 3
              end
              item
                ImageIndex = 4
                Value = 4
              end
              item
                ImageIndex = 5
                Value = 5
              end
              item
                ImageIndex = 6
                Value = 6
              end
              item
                ImageIndex = 7
                Value = 7
              end
              item
                ImageIndex = 8
                Value = 8
              end
              item
                ImageIndex = 9
                Value = 9
              end
              item
                ImageIndex = 10
                Value = 10
              end>
            Properties.LargeImages = DMGlobal.imgPayments
            Properties.ReadOnly = True
            Properties.ShowDescriptions = False
            Width = 22
          end
          object grdPaymentsDBPaymentForm: TcxGridDBColumn
            Caption = 'Payment'
            DataBinding.FieldName = 'PaymentForm'
            SortOrder = soAscending
            Width = 162
          end
          object grdPaymentsDBMeioPag: TcxGridDBColumn
            Caption = ' '
            DataBinding.FieldName = 'PaymentType'
            Visible = False
            GroupIndex = 0
            SortOrder = soAscending
            Styles.Content = csPayment
            Width = 124
          end
          object grdPaymentsDBPaymentValue: TcxGridDBColumn
            DataBinding.FieldName = 'PaymentValue'
            Styles.Content = csAmount
            Width = 93
          end
        end
        object grdPaymentsLevel: TcxGridLevel
          GridView = grdPaymentsDB
        end
      end
    end
    object Panel4: TPanel
      Left = 2
      Top = 2
      Width = 321
      Height = 43
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 321
        Height = 43
        Align = alClient
        Brush.Color = 14671839
        Pen.Color = 13793052
      end
      object Label2: TLabel
        Left = 44
        Top = 13
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Due :'
        Color = 14671839
        Font.Charset = ANSI_CHARSET
        Font.Color = 13793052
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
      end
      object lbTotalDue: TStaticText
        Left = 122
        Top = 9
        Width = 186
        Height = 24
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0.00'
        Color = 14671839
        Font.Charset = ANSI_CHARSET
        Font.Color = 13793052
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 96
      Width = 321
      Height = 43
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Shape3: TShape
        Left = 0
        Top = 0
        Width = 321
        Height = 43
        Align = alClient
        Brush.Color = 14671839
        Pen.Color = 13793052
      end
      object Label3: TLabel
        Left = 43
        Top = 13
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Sale :'
        Color = 14607076
        Font.Charset = ANSI_CHARSET
        Font.Color = 13793052
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbSalesTotal: TStaticText
        Left = 122
        Top = 9
        Width = 187
        Height = 24
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0.00'
        Color = 14671839
        Font.Charset = ANSI_CHARSET
        Font.Color = 13793052
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object pnlPayment: TPanel [5]
    Left = 0
    Top = 6
    Width = 336
    Height = 540
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object lbLayway: TLabel
      Left = 18
      Top = 518
      Width = 58
      Height = 16
      Caption = 'Layaway'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCustomer: TLabel
      Left = 18
      Top = 483
      Width = 62
      Height = 16
      Caption = 'Customer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbStoreCredit: TLabel
      Left = 18
      Top = 501
      Width = 79
      Height = 16
      Caption = 'Store Credit'
      Font.Charset = ANSI_CHARSET
      Font.Color = 13793052
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 17
      Top = 387
      Width = 306
      Height = 6
      Shape = bsTopLine
    end
    object editInputString: TEdit
      Left = 28
      Top = 12
      Width = 200
      Height = 21
      TabStop = False
      Color = 8454143
      TabOrder = 15
      OnChange = editInputStringChange
    end
    object btnPayCash: TXiButton
      Tag = 1
      Left = 6
      Top = 161
      Width = 104
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Cash'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 4
      TabStop = False
      OnClick = btnPayCashClick
    end
    object btnAdd20: TXiButton
      Tag = 20
      Left = 6
      Top = 78
      Width = 104
      Height = 63
      Cursor = crHandPoint
      ColorFace = 14547432
      ColorGrad = 6217614
      ColorDark = 2406748
      ColorLight = 13366747
      ColorBorder = 1404727
      ColorText = clBlack
      OverColorFace = 12579538
      OverColorGrad = 4053111
      OverColorDark = 2339929
      OverColorLight = 11923659
      OverColorBorder = 1538365
      OverColorText = clBlack
      DownColorFace = 5168259
      DownColorGrad = 8447654
      DownColorDark = 9037740
      DownColorLight = 1539390
      DownColorBorder = 1471545
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 2406748
      ColorScheme = csNeoGrass
      Ctl3D = True
      Layout = blGlyphBottom
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = '$20'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnAdd20Click
    end
    object btnAdd10: TXiButton
      Tag = 10
      Left = 118
      Top = 78
      Width = 104
      Height = 63
      Cursor = crHandPoint
      ColorFace = 14547432
      ColorGrad = 6217614
      ColorDark = 2406748
      ColorLight = 13366747
      ColorBorder = 1404727
      ColorText = clBlack
      OverColorFace = 12579538
      OverColorGrad = 4053111
      OverColorDark = 2339929
      OverColorLight = 11923659
      OverColorBorder = 1538365
      OverColorText = clBlack
      DownColorFace = 5168259
      DownColorGrad = 8447654
      DownColorDark = 9037740
      DownColorLight = 1539390
      DownColorBorder = 1471545
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 2406748
      ColorScheme = csNeoGrass
      Ctl3D = True
      Layout = blGlyphBottom
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = '$10'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = btnAdd20Click
    end
    object btnAdd5: TXiButton
      Tag = 5
      Left = 229
      Top = 78
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 14547432
      ColorGrad = 6217614
      ColorDark = 2406748
      ColorLight = 13366747
      ColorBorder = 1404727
      ColorText = clBlack
      OverColorFace = 12579538
      OverColorGrad = 4053111
      OverColorDark = 2339929
      OverColorLight = 11923659
      OverColorBorder = 1538365
      OverColorText = clBlack
      DownColorFace = 5168259
      DownColorGrad = 8447654
      DownColorDark = 9037740
      DownColorLight = 1539390
      DownColorBorder = 1471545
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 2406748
      ColorScheme = csNeoGrass
      Ctl3D = True
      Layout = blGlyphBottom
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = '$5 '
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btnAdd20Click
    end
    object btnPayCreditCard: TXiButton
      Tag = 2
      Left = 229
      Top = 161
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Credit Card'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 5
      TabStop = False
      OnClick = btnPayCreditCardClick
    end
    object btnPayCheck: TXiButton
      Tag = 4
      Left = 118
      Top = 161
      Width = 104
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000
        00FFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Check'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 6
      TabStop = False
      OnClick = btnPayCheckClick
    end
    object btnPayDebitCard: TXiButton
      Tag = 7
      Left = 6
      Top = 237
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
        000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFF000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Debit Card'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 7
      TabStop = False
      OnClick = btnPayDebitCardClick
    end
    object btnPayGift: TXiButton
      Tag = 6
      Left = 118
      Top = 237
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000
        00000000000000000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Gift Card'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 8
      TabStop = False
      OnClick = btnPayGiftClick
    end
    object btnPayBonus: TXiButton
      Tag = 8
      Left = 229
      Top = 238
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 15987699
      ColorScheme = csCustom
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFF00
        0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Bonus Bucks'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 9
      TabStop = False
      OnClick = btnPayBonusClick
    end
    object btnPayStoreCredit: TXiButton
      Tag = 5
      Left = 7
      Top = 312
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFF0000000000
        00000000000000000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Store Credit'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 10
      TabStop = False
      OnClick = btnPayStoreCreditClick
    end
    object btnPayOther: TXiButton
      Tag = 3
      Left = 118
      Top = 312
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFF
        FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Other'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 11
      TabStop = False
      OnClick = btnPayOtherClick
    end
    object btnFinish: TXiButton
      Left = 229
      Top = 407
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 13036799
      ColorGrad = 3653375
      ColorDark = 40168
      ColorLight = 12183551
      ColorBorder = 22144
      ColorText = clBlack
      OverColorFace = 11790335
      OverColorGrad = 41968
      OverColorDark = 36562
      OverColorLight = 9820927
      OverColorBorder = 22144
      OverColorText = clBlack
      DownColorFace = 2865919
      DownColorGrad = 7852799
      DownColorDark = 9099775
      DownColorLight = 30647
      DownColorBorder = 28838
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 4227327
      ColorScheme = csNeoDesert
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        DA040000424DDA040000000000003600000028000000230000000B0000000100
        180000000000A404000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000000000000000FFFFFFFFFFFFFFFFFF000000000000000000
        000000000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
        000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000
        FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF0000000000
        00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Finish'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 12
      TabStop = False
      OnClick = btnFinishClick
    end
    object btnLayaway: TXiButton
      Left = 118
      Top = 407
      Width = 104
      Height = 63
      Cursor = crHandPoint
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
      Layout = blGlyphBottom
      Glyph.Data = {
        DA040000424DDA040000000000003600000028000000230000000B0000000100
        180000000000A404000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
        000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
        000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
        FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF0000000000
        00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Layaway'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 13
      TabStop = False
      OnClick = btnLayawayClick
    end
    object btnCustomer: TXiButton
      Left = 6
      Top = 407
      Width = 104
      Height = 63
      Cursor = crHandPoint
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
      Layout = blGlyphBottom
      Glyph.Data = {
        DA040000424DDA040000000000003600000028000000230000000B0000000100
        180000000000A404000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
        000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000
        0000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000
        000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000
        FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF0000000000
        00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFF000000000000FFFFFF000000FFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Customer'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 14
      TabStop = False
      OnClick = btnCustomerClick
    end
    object pnlValue: TPanel
      Left = 8
      Top = 1
      Width = 325
      Height = 62
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Shape4: TShape
        Left = 0
        Top = 0
        Width = 325
        Height = 62
        Align = alClient
        Brush.Color = 14607076
        Pen.Color = 8491416
      end
      object Label4: TLabel
        Left = 1
        Top = 13
        Width = 130
        Height = 14
        Alignment = taRightJustify
        Caption = 'Amount Tendered :'
        Color = 14607076
        Font.Charset = ANSI_CHARSET
        Font.Color = 8491416
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
      end
      object lbChange: TLabel
        Left = 69
        Top = 37
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Change :'
        Color = 14607076
        Font.Charset = ANSI_CHARSET
        Font.Color = 8491416
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object lbChangeValue: TStaticText
        Left = 143
        Top = 34
        Width = 170
        Height = 22
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0.00'
        Color = 14607076
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        Visible = False
      end
      object edtPayValue: TSuperEdit
        Left = 147
        Top = 10
        Width = 167
        Height = 21
        BorderStyle = bsNone
        Color = 14607076
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        TabOrder = 1
        Text = '0.00'
        OnChange = edtPayValueChange
        OnExit = edtPayValueExit
        OnKeyPress = edtPayValueKeyPress
        Alignment = taRightJustify
      end
    end
    object btnPayStoreAcc: TXiButton
      Tag = 9
      Left = 229
      Top = 312
      Width = 103
      Height = 63
      Cursor = crHandPoint
      ColorFace = 15987699
      ColorGrad = 12369084
      ColorDark = 10987431
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 15790320
      OverColorGrad = 10921638
      OverColorDark = 10658466
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13290186
      DownColorGrad = 14342874
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 11382189
      ColorScheme = csNeoSilver
      Ctl3D = True
      Layout = blGlyphBottom
      Glyph.Data = {
        D2030000424DD20300000000000036000000280000001B0000000B0000000100
        1800000000009C03000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000000000FF
        FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF000000000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFF
        FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000000000000000FFFFFF000000000000FFFFFFFFFF
        FFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFFFFFF00
        0000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
        000000000000FFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00
        0000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFF
        000000000000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFF
        FFFF000000000000FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
        FFFFFF000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF0000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF00
        0000FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Store Account'
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 16
      TabStop = False
      OnClick = btnPayStoreAccClick
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPaymentReceive.sil'
  end
  object strepPayments: TcxStyleRepository
    Left = 416
    Top = 219
    object csBackground: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
    object csGroup: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = 13793052
    end
    object csPayment: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = 13793052
    end
    object csAmount: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = 13793052
    end
    object GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
    end
  end
  object cdsPayments: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 418
    Top = 277
    object cdsPaymentsID: TIntegerField
      FieldName = 'ID'
    end
    object cdsPaymentsPaymentType: TStringField
      DisplayLabel = 'Payment'
      FieldName = 'PaymentType'
      Size = 30
    end
    object cdsPaymentsPaymentForm: TStringField
      DisplayLabel = ' '
      FieldName = 'PaymentForm'
      Size = 30
    end
    object cdsPaymentsPaymentDate: TDateTimeField
      FieldName = 'PaymentDate'
    end
    object cdsPaymentsPaymentValue: TCurrencyField
      FieldName = 'PaymentValue'
      DisplayFormat = '#,##0.00'
    end
    object cdsPaymentsImage: TIntegerField
      FieldName = 'Image'
    end
  end
  object dsPayments: TDataSource
    DataSet = cdsPayments
    Left = 423
    Top = 324
  end
  object quPaymentTypes: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDMeioPag,'#13#10#9'ImageIndex,'#13#10#9'MeioPag,'#13#10#9'RequireCustomer,'#13 +
      #10#9'ValidateNonpayer'#13#10'FROM'#13#10#9'MeioPag'#13#10'WHERE'#13#10#9'ParentType <> '#39'Batch' +
      #39#13#10
    Parameters = <>
    Left = 494
    Top = 161
  end
  object dspPaymentTypes: TDataSetProvider
    DataSet = quPaymentTypes
    Left = 549
    Top = 228
  end
  object cdsPaymentTypes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPaymentTypes'
    Left = 569
    Top = 188
  end
  object quCustomerInfo: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'Pessoa,'#13#10#9'PessoaFirstName,'#13#10#9'PessoaLastName,'#13#10#9'StoreAcc' +
      'ountLimit,'#13#10#9'Nonpayer,'#13#10#9'Email,'#13#10#9'CustomerCard'#13#10'FROM'#13#10'        Pe' +
      'ssoa'#13#10'WHERE'#13#10'        IDPessoa = :IDPessoa'#13#10#13#10#9#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 485
    Top = 247
  end
  object quCustomerCredits: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDDocument'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDCustomer'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  CONVERT(bit,0) as Marked,'
      '  C.IDCustomerCredit,'
      '  C.IDPessoa,'
      '  C.IDUser,'
      '  C.IDStore,'
      '  C.CreditDate,'
      '  C.ExpirationDate,'
      '  C.IDLancamento,'
      '  C.Amount'
      'FROM'
      #9'CustomerCredit C'
      
        #9'LEFT OUTER JOIN PreInventoryMov PIM ON (PIM.IDPreInventoryMov =' +
        ' C.IDPreInventoryMov AND PIM.InventMovTypeID = 1 AND IsNull(PIM.' +
        'DocumentID,0) <> :IDDocument)'
      'WHERE'
      #9'('
      
        #9#9'CONVERT(DateTime, CONVERT(varchar, C.ExpirationDate, 103), 103' +
        ') >= CONVERT(DateTime, CONVERT(varchar, GetDate(), 103), 103)'
      #9#9'OR'
      #9#9'ExpirationDate IS NULL'
      #9')'
      #9'AND'
      #9'C.IDPessoa = :IDCustomer'
      #9'AND'
      #9'ISNULL(C.IsUsed, 0) = 0'
      #9
      '')
    Left = 524
    Top = 320
    object quCustomerCreditsMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quCustomerCreditsIDCustomerCredit: TIntegerField
      FieldName = 'IDCustomerCredit'
    end
    object quCustomerCreditsIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quCustomerCreditsIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quCustomerCreditsIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quCustomerCreditsCreditDate: TDateTimeField
      FieldName = 'CreditDate'
    end
    object quCustomerCreditsExpirationDate: TDateTimeField
      FieldName = 'ExpirationDate'
    end
    object quCustomerCreditsIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quCustomerCreditsAmount: TBCDField
      FieldName = 'Amount'
      Precision = 19
    end
  end
  object sdpCustomerCredit: TDataSetProvider
    DataSet = quCustomerCredits
    Left = 524
    Top = 320
  end
  object cdsCustomerCredit: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDDocument'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDCustomer'
        ParamType = ptInput
      end>
    ProviderName = 'sdpCustomerCredit'
    Left = 524
    Top = 320
  end
  object tmrProccess: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrProccessTimer
    Left = 418
    Top = 172
  end
end
