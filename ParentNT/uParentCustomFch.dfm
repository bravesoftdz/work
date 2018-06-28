inherited ParentCustomFch: TParentCustomFch
  Left = 262
  Top = 244
  Width = 460
  Height = 325
  Caption = 'ParentCustomFch'
  Color = 13752539
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = '  Title'
    Color = 16767935
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12615680
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      452
      26)
    object lbLoop: TLabel
      Left = 397
      Top = 2
      Width = 24
      Height = 11
      Anchors = [akTop, akRight]
      Caption = 'Loop'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 12615680
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object btnLoop: TXiButton
      Left = 424
      Top = 2
      Width = 24
      Height = 22
      Hint = 'Auto-inc'
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
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF9891DF101880FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7CB9BE
        4593A82B6F762060702068704078807098A0A3B2DF2048C0102090FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF40B0C060D0E040B8D050B0C070B0C0A0
        B8E02048C01050FF1000C0100080847DC1FF00FFFF00FFFF00FFFF00FFFF00FF
        98CCD440C0D080E0F070E0F090D8F07088E090A8F08098FF1050FF1050FF1018
        909393D0FF00FFFF00FFFF00FFFF00FFFF00FF40C0D050D0E090F0F0A0F0F0B0
        D8FF7088E090A8F06080F05068D01050FF2040A09BB6B6FF00FFFF00FFFF00FF
        FF00FF84CED830C0D0A0F0FFA0F8FFB0F0FFB0D0FF7088E04058B0A0E8F05068
        D03050B080A0B08EABADFF00FFFF00FFFF00FFFF00FF30C0D0A0F0F0A0F8FFA0
        F8FFA0F0FFB0D0F07088E080E0F0A0C0F05068C080A8B066888FFF00FFFF00FF
        FF00FFFF00FF76B2A3804820A04820C0B09090F8FF90F0F090F0F090E8F0A0D0
        F06078D090D0E0578484FF00FFA36E55914A2AE9BCA676492BC04810B0400090
        402090F8FF80F0FF80F0F090E8F090C0F07088E090D8F0508090CA8969D05010
        B04810702800802800802800B0481070280080C0C070C0C090F8FF90F0F07088
        E090C8F080D8F0408080C07850F09870E06830A04010F0B8A0C07040E0683080
        280040404050505090F0F0A0F8FF90F0F080E8F070E0F0407880D6B49CFBD9C4
        F0A880C07850D08870FFD0B0F0B090A04010C0F8FFB0F8FFA0F8FFA0F8FF90F0
        FF80F0F070E0F0407070FF00FFE8B59AC58B6BE9BCA6FF00FFE08850C07850F0
        D0C0E0F8FFD0F8FFC0F8FFC0F8FFA0F8FF90F0FF70E0F0307070FF00FFFF00FF
        FF00FFFF00FFFF00FF40C8D0C0F0F0D0F8FFD0F8FFD0F8FFD0F8FFC0F8FFB0F8
        FFA0F8FF70E8F0307070FF00FFFF00FFFF00FFFF00FFFF00FF52CAD240C8D040
        C8D040C8D030C0D030C0D020B8D020B8D020B0D02AB2D04A757C}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = OnLoopClick
    end
  end
  object dsFch: TDataSource
    Left = 356
    Top = 28
  end
  object PrintFch: TPrintDialog
    Left = 408
    Top = 32
  end
  object ConfigFch: TmrConfigFch
    Left = 296
    Top = 32
  end
end
