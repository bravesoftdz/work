inherited ParentPrintForm: TParentPrintForm
  Left = 257
  Top = 250
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ParentPrintForm'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblPrint: TLabel
    Left = 71
    Top = 72
    Width = 182
    Height = 27
    Alignment = taCenter
    AutoSize = False
    Caption = 'Receipt Printed!'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 178
    Width = 339
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      339
      28)
    object btnOk: TXiButton
      Left = 261
      Top = 3
      Width = 75
      Height = 24
      ColorFace = 14737632
      ColorGrad = 3653375
      ColorDark = 11447982
      ColorLight = 16250871
      ColorBorder = 6447714
      ColorText = clBlack
      OverColorFace = 13619151
      OverColorGrad = 41968
      OverColorDark = 7960953
      OverColorLight = 15658734
      OverColorBorder = 7697781
      OverColorText = clBlack
      DownColorFace = 13882323
      DownColorGrad = 7852799
      DownColorDark = 15329769
      DownColorLight = 8158332
      DownColorBorder = 5131854
      DownColorText = clBlack
      DisabledColorFace = 14869218
      DisabledColorGrad = clWhite
      DisabledColorDark = 14211288
      DisabledColorLight = 15395562
      DisabledColorBorder = 12895428
      DisabledColorText = clGray
      ColorFocusRect = 9079434
      ColorScheme = csSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Glyph.Data = {
        9E020000424D9E0200000000000036000000280000000E0000000E0000000100
        1800000000006802000000000000000000000000000000000000EAB3A6C06860
        B05850A05050A05050A050509048509048409048408040408038408038407038
        407038300000D06870F09090E08080B04820403020C0B8B0C0B8B0D0C0C0D0C8
        C0505050A04030A04030A038307038400000D07070FF98A0F08880E080807058
        50404030907870F0E0E0F0E8E0908070A04030A04040A040308038400000D078
        70FFA0A0F09090F08880705850000000404030F0D8D0F0E0D0807860B04840B0
        4840A040408040400000D07880FFA8B0FFA0A0F0909070585070585070585070
        5850706050806860C05850B05050B048408040400000E08080FFB0B0FFB0B0FF
        A0A0F09090F08880E08080E07880D07070D06870C06060C05850B05050904840
        0000E08890FFB8C0FFB8B0D06060C06050C05850C05040B05030B04830A04020
        A03810C06060C058509048400000E09090FFC0C0D06860FFFFFFFFFFFFFFF8F0
        F0F0F0F0E8E0F0D8D0E0D0C0E0C8C0A03810C060609048500000E098A0FFC0C0
        D07070FFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0E0D0C0A04020D068
        60A050500000F0A0A0FFC0C0E07870FFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0
        F0F0E8E0F0D8D0B04830D07070A050500000F0A8A0FFC0C0E08080FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0B05030E07880A050500000F0B0
        B0FFC0C0F08890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0C0
        5040603030B058500000F0B0B0FFC0C0FF9090FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF8F0C05850B05860B058600000F0B8B0F0B8B0F0B0B0F0
        B0B0F0A8B0F0A0A0E098A0E09090E09090E08890E08080D07880D07870D07070
        0000}
      Spacing = 4
      TransparentGlyph = True
      Gradient = False
      HotTrack = True
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object ppReport: TppReport
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Carta, 8,5x11 pol.'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 44
    Top = 16
    Version = '7.02'
    mmColumnWidth = 0
  end
  object ppDesigner: TppDesigner
    Caption = 'ReportBuilder'
    DataSettings.SessionType = 'BDESession'
    DataSettings.AllowEditSQL = False
    DataSettings.CollationType = ctASCII
    DataSettings.DatabaseType = dtParadox
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqBDELocal
    Position = poScreenCenter
    Report = ppReport
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    WindowState = wsMaximized
    Left = 120
    Top = 16
  end
  object RBExportrControl: TPsRBExportMasterControl
    PDF.ExportImageFormat = ifJPG
    PDF.EncryptionLevel = el40Bit
    HTML.DefaultFont.Charset = DEFAULT_CHARSET
    HTML.DefaultFont.Color = clWindowText
    HTML.DefaultFont.Height = -13
    HTML.DefaultFont.Name = 'Arial'
    HTML.DefaultFont.Style = []
    HTML.DocumentPreferences.AutoMaximizeWindow = False
    HTML.DocumentPreferences.DisableRightClick = False
    HTML.DocumentPreferences.DisableCopying = False
    HTML.LinkFont.Charset = DEFAULT_CHARSET
    HTML.LinkFont.Color = clBlue
    HTML.LinkFont.Height = -24
    HTML.LinkFont.Name = 'Wingdings'
    HTML.LinkFont.Style = []
    HTML.LinkTextFirst = #217
    HTML.LinkTextNext = #216
    HTML.LinkTextPrev = #215
    HTML.LinkTextLast = #218
    XHTML.DefaultFont.Charset = DEFAULT_CHARSET
    XHTML.DefaultFont.Color = clWindowText
    XHTML.DefaultFont.Height = -13
    XHTML.DefaultFont.Name = 'Arial'
    XHTML.DefaultFont.Style = []
    XHTML.DocumentPreferences.AutoMaximizeWindow = False
    XHTML.DocumentPreferences.DisableRightClick = False
    XHTML.DocumentPreferences.DisableCopying = False
    XHTML.LinkFont.Charset = DEFAULT_CHARSET
    XHTML.LinkFont.Color = clBlue
    XHTML.LinkFont.Height = -24
    XHTML.LinkFont.Name = 'Wingdings'
    XHTML.LinkFont.Style = []
    RTF.Active = True
    Excel.Active = True
    Excel.PositionalGridDimensions.Height = 4234
    Excel.PositionalGridDimensions.Width = 16934
    GIF.Active = True
    GIF.ScaleX = 1.000000000000000000
    GIF.ScaleY = 1.000000000000000000
    JPEG.Active = True
    JPEG.ScaleX = 1.000000000000000000
    JPEG.ScaleY = 1.000000000000000000
    JPEG.ProgressiveEncoding = True
    BMP.Active = True
    BMP.ScaleX = 1.000000000000000000
    BMP.ScaleY = 1.000000000000000000
    EMF.Active = True
    EMF.ScaleX = 1.000000000000000000
    EMF.ScaleY = 1.000000000000000000
    WMF.Active = True
    WMF.ScaleX = 1.000000000000000000
    WMF.ScaleY = 1.000000000000000000
    Left = 200
    Top = 16
  end
end
