object FrmRptBuildPrintGrid: TFrmRptBuildPrintGrid
  Left = 155
  Top = 179
  Width = 213
  Height = 150
  Caption = 'FrmRptBuildPrintGrid'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RptGrid: TppReport
    AutoStop = False
    DataPipeline = DBPipeline
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Units = utMillimeters
    DeviceType = 'Screen'
    Icon.Data = {
      0000010001002020100000000000E80200001600000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000999999999999999999999999999999999999
      9999999999999999999999999999999999000099999999900000000000009999
      9900099999999900000000000000999999009999999990000000000000009999
      9909999999990000000000000000999999999999999000000000000000009999
      9999999999000000000000000000999999999999900000000000000000009999
      9999999900000000000000000000999999999990000000000000000000009999
      9999990000000000000000000000999999999000000000000000000000009999
      99990000000000000000000000009999999000000000000000000000000003FF
      FFF803FFFFF003FFFFE003FFFFC003FFFF8003FFFF0003FFFE0003FFFC0003FF
      F80003FFF00003FFE00003FFC00003FF804003FF00C003FE01C003FC03C003F8
      07C0000000000000000003C01FFF03803FFF03007FFF0200FFFF0001FFFF0003
      FFFF0007FFFF000FFFFF001FFFFF003FFFFF007FFFFF00FFFFFF01FFFFFF}
    OnPreviewFormCreate = RptGridPreviewFormCreate
    Left = 80
    Top = 10
    Version = '6.03'
    mmColumnWidth = 197300
    DataPipelineName = 'DBPipeline'
    object RtpTitle: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 163248
        mmTop = 8467
        mmWidth = 33602
        BandType = 1
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'User :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 265
        mmTop = 7938
        mmWidth = 9525
        BandType = 1
      end
      object lbUser: TppLabel
        UserName = 'lbUser'
        Caption = 'lbUser'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 10583
        mmTop = 7938
        mmWidth = 11642
        BandType = 1
      end
      object lbTitle: TppLabel
        UserName = 'lbTitle'
        Caption = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 12
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5027
        mmLeft = 93927
        mmTop = 0
        mmWidth = 9525
        BandType = 1
      end
    end
    object RtpHeader: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 4233
      mmPrintPosition = 0
    end
    object RepDetail: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 4233
      mmPrintPosition = 0
      object shpDetail: TppShape
        OnPrint = shpDetailPrint
        UserName = 'shpDetail'
        Pen.Style = psClear
        mmHeight = 4498
        mmLeft = 0
        mmTop = 0
        mmWidth = 197380
        BandType = 4
      end
    end
    object RepFooter: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 6350
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 178859
        mmTop = 1323
        mmWidth = 17992
        BandType = 8
      end
    end
    object RepSummary: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 7144
      mmPrintPosition = 0
    end
  end
  object DBPipeline: TppDBPipeline
    OpenDataSource = False
    UserName = 'DBPipeline'
    Left = 80
    Top = 70
  end
end
