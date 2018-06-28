object FrmBarcodePrintSingle: TFrmBarcodePrintSingle
  Left = 228
  Top = 321
  Width = 244
  Height = 158
  Caption = 'FrmBarcodePrintSingle'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object cdsBarcode: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'model'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Barcode'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Price'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'SuggRetail'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'SizeName'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'cdsBarcodeListIndexAscending'
      end
      item
        Name = 'cdsBarcodeListIndexDescending'
        Options = [ixDescending]
      end>
    Params = <
      item
        DataType = ftInteger
        Name = 'StoreID'
        ParamType = ptInput
      end>
    StoreDefs = True
    Left = 69
    Top = 93
    object cdsBarcodemodel: TStringField
      FieldName = 'model'
      Size = 30
    end
    object cdsBarcodedescription: TStringField
      FieldName = 'description'
      Size = 50
    end
    object cdsBarcodeBarcode: TStringField
      FieldName = 'Barcode'
    end
    object cdsBarcodePrice: TBCDField
      FieldName = 'Price'
      Precision = 19
    end
    object cdsBarcodeSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object cdsBarcodeSizeName: TStringField
      FieldName = 'SizeName'
    end
  end
  object dsBarcode: TDataSource
    DataSet = cdsBarcode
    Left = 75
    Top = 146
  end
  object ppDBPipeline: TppDBPipeline
    DataSource = dsBarcode
    CloseDataSource = True
    UserName = 'Barcode'
    Left = 173
    Top = 70
  end
  object ppReport: TppReport
    AutoStop = False
    Columns = 3
    ColumnPositions.Strings = (
      '6350'
      '74082'
      '141814')
    DataPipeline = ppDBPipeline
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Carta'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    Template.FileName = 'C:\work\MAINRETAIL 3 D7\Forms\4.25x1.25_upc_model.rtm'
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 169
    Top = 21
    Version = '7.02'
    mmColumnWidth = 67733
    DataPipelineName = 'ppDBPipeline'
    object ppColumnHeaderBand1: TppColumnHeaderBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      ColumnTraversal = ctLeftToRight
      mmBottomOffset = 12700
      mmHeight = 36513
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Model'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3048
        mmLeft = 794
        mmTop = 794
        mmWidth = 35983
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Description'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3048
        mmLeft = 265
        mmTop = 9525
        mmWidth = 66146
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Price'
        DataPipeline = ppDBPipeline
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3048
        mmLeft = 53711
        mmTop = 1058
        mmWidth = 12171
        BandType = 4
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Price :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3048
        mmLeft = 39740
        mmTop = 1058
        mmWidth = 11853
        BandType = 4
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'MSRP :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3048
        mmLeft = 41434
        mmTop = 5027
        mmWidth = 10160
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'SuggRetail'
        DataPipeline = ppDBPipeline
        DisplayFormat = '#,0.00;-#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3048
        mmLeft = 53446
        mmTop = 5027
        mmWidth = 12435
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'SizeName'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Courier New'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3048
        mmLeft = 1852
        mmTop = 32279
        mmWidth = 63236
        BandType = 4
      end
      object RBDBEan: TRBDBEan
        UserName = 'DBEan'
        BackgroundColor = clWhite
        Transparent = False
        ShowLabels = False
        StartStopLines = True
        TypBarCode = bcCode128
        LinesColor = clBlack
        Ean13AddUp = True
        FontAutoSize = True
        Security = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Angle = 0
        LabelMask = '__________________________________________________'
        DisableEditor = False
        DataField = 'Barcode'
        DataPipeLine = ppDBPipeline
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 15610
        mmLeft = 3175
        mmTop = 13758
        mmWidth = 60061
        BandType = 4
      end
    end
    object ppColumnFooterBand1: TppColumnFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object raCodeModule1: TraCodeModule
      ProgramStream = {00}
    end
  end
  object dspBarcode: TDataSetProvider
    Left = 71
    Top = 51
  end
  object quBarcode: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'select '#13#10'         model'#13#10'       , description'#13#10'       ,cast ('#39' '#39 +
      ' as varchar(20)) Barcode'#13#10'      ,SellingPrice as Price'#13#10'      ,S' +
      'uggRetail'#13#10'     ,SizeName'#13#10'from Model M'#13#10'     left join InvSize ' +
      'S on M.IDSize = S.IDSize'#13#10
    CommandTimeout = 720
    Parameters = <
      item
        Name = 'StoreID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 71
    Top = 2
    object quBarcodemodel: TStringField
      FieldName = 'model'
      Size = 30
    end
    object quBarcodedescription: TStringField
      FieldName = 'description'
      Size = 50
    end
    object quBarcodeBarcode: TStringField
      FieldName = 'Barcode'
      ReadOnly = True
    end
    object quBarcodePrice: TBCDField
      FieldName = 'Price'
      Precision = 19
    end
    object quBarcodeSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quBarcodeSizeName: TStringField
      FieldName = 'SizeName'
    end
  end
end
