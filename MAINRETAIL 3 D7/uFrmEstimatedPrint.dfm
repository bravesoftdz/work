inherited FrmEstimatedPrint: TFrmEstimatedPrint
  Left = 356
  Top = 203
  Width = 385
  Height = 331
  BorderIcons = [biMaximize]
  Caption = 'Print Budget'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 17
    Top = 118
    Width = 25
    Height = 13
    Alignment = taRightJustify
    Caption = 'Obs :'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 189
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'Obs 2 :'
  end
  inherited Panel1: TPanel
    Top = 263
    Width = 377
    inherited EspacamentoInferior: TPanel
      Width = 377
      inherited Panel3: TPanel
        Width = 377
      end
    end
    inherited hhh: TPanel
      Left = 89
      Width = 288
      inherited sbHelp: TSpeedButton
        Left = 4
        Visible = False
      end
      inherited btClose: TButton
        Left = 217
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnPrint: TButton
        Left = 148
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Print'
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btnPrintClick
      end
      object btnEmail: TButton
        Left = 76
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Email'
        ModalResult = 1
        TabOrder = 2
        TabStop = False
        Visible = False
        OnClick = btnEmailClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 257
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 374
    Height = 257
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 377
    Visible = False
  end
  object chkImage: TCheckBox [6]
    Left = 49
    Top = 24
    Width = 155
    Height = 17
    Caption = 'Display image 1'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object chkImage2: TCheckBox [7]
    Left = 209
    Top = 24
    Width = 160
    Height = 17
    Caption = 'Display image 2'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object chkFeatures: TCheckBox [8]
    Left = 49
    Top = 59
    Width = 155
    Height = 17
    Caption = 'Display Features'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object chkTechFeatures: TCheckBox [9]
    Left = 209
    Top = 59
    Width = 160
    Height = 17
    Caption = 'Display Tech Features'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object memEstimet: TMemo [10]
    Left = 47
    Top = 118
    Width = 321
    Height = 66
    Lines.Strings = (
      'memEstimet')
    MaxLength = 255
    TabOrder = 8
  end
  object chkQty: TCheckBox [11]
    Left = 49
    Top = 89
    Width = 155
    Height = 17
    Caption = 'Display Qty and Prices'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object memEstimet2: TMemo [12]
    Left = 47
    Top = 189
    Width = 321
    Height = 66
    Lines.Strings = (
      'memEstimet')
    MaxLength = 255
    TabOrder = 10
  end
  object ppBudget: TppReport [13]
    AutoStop = False
    DataPipeline = ppEstimated
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = False
    OutlineSettings.CreatePageNodes = False
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zs100Percent
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 25
    Top = 70
    Version = '7.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppEstimated'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 20902
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'lbID'
        Caption = 'Budget #'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 11377
        mmTop = 2381
        mmWidth = 10848
        BandType = 0
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'IDEstimated'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 23019
        mmTop = 2381
        mmWidth = 16404
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'lbDate'
        Caption = 'Date :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 15081
        mmTop = 6615
        mmWidth = 7144
        BandType = 0
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'EstimatedDate'
        DataPipeline = ppEstimated
        DisplayFormat = 'mm/dd/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 23019
        mmTop = 6615
        mmWidth = 16404
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'lbCustomer'
        Caption = 'Customer :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 8731
        mmTop = 10848
        mmWidth = 13494
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'lbSalesP'
        Caption = 'Sales Person :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 4498
        mmTop = 15081
        mmWidth = 17727
        BandType = 0
      end
      object ppDBText13: TppDBText
        UserName = 'DBText13'
        DataField = 'Name'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 23019
        mmTop = 10848
        mmWidth = 59002
        BandType = 0
      end
      object ppDBText14: TppDBText
        UserName = 'DBText14'
        DataField = 'SystemUser'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 23019
        mmTop = 15081
        mmWidth = 59002
        BandType = 0
      end
      object ppLabel12: TppLabel
        UserName = 'lbPhone'
        Caption = 'Phone :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 84667
        mmTop = 10848
        mmWidth = 9260
        BandType = 0
      end
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        DataField = 'Telephone'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 94456
        mmTop = 10848
        mmWidth = 17198
        BandType = 0
      end
      object ppLabel13: TppLabel
        UserName = 'lbEmail'
        Caption = 'Email :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 85725
        mmTop = 15081
        mmWidth = 8202
        BandType = 0
      end
      object ppDBText16: TppDBText
        UserName = 'DBText16'
        DataField = 'Email'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 94456
        mmTop = 15081
        mmWidth = 47890
        BandType = 0
      end
      object ppLogoImage: TppImage
        UserName = 'LogoImage'
        MaintainAspectRatio = False
        mmHeight = 19050
        mmLeft = 154517
        mmTop = 794
        mmWidth = 44450
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 10319
      mmPrintPosition = 0
      object ppSubReport1: TppSubReport
        UserName = 'SubReport1'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'ppEstimatedItem'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 529
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = ppEstimatedItem
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppEstimatedItem'
          object ppTitleBand3: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 3440
            mmPrintPosition = 0
            object ppLabel5: TppLabel
              UserName = 'lbModel'
              Caption = 'Model'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              mmHeight = 3175
              mmLeft = 265
              mmTop = 265
              mmWidth = 10319
              BandType = 1
            end
            object ppLabel8: TppLabel
              UserName = 'lbDesc'
              Caption = 'Description'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              mmHeight = 3302
              mmLeft = 38100
              mmTop = 137
              mmWidth = 13716
              BandType = 1
            end
            object ppLabel3: TppLabel
              UserName = 'lbQty'
              Caption = 'Qty'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3175
              mmLeft = 128852
              mmTop = 265
              mmWidth = 4233
              BandType = 1
            end
            object ppLabel4: TppLabel
              UserName = 'lbPrice'
              Caption = 'Price'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3175
              mmLeft = 141817
              mmTop = 265
              mmWidth = 6350
              BandType = 1
            end
            object ppLabel9: TppLabel
              UserName = 'lbTotal'
              Caption = 'Total'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3175
              mmLeft = 156634
              mmTop = 265
              mmWidth = 6085
              BandType = 1
            end
          end
          object ppDetailBand2: TppDetailBand
            PrintHeight = phDynamic
            mmBottomOffset = 0
            mmHeight = 66411
            mmPrintPosition = 0
            object ppImage1: TppImage
              UserName = 'imgItem'
              MaintainAspectRatio = False
              Transparent = True
              mmHeight = 54504
              mmLeft = 10583
              mmTop = 4763
              mmWidth = 65088
              BandType = 4
            end
            object ppDBText7: TppDBText
              UserName = 'DBText7'
              DataField = 'Description'
              DataPipeline = ppEstimatedItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              Transparent = True
              DataPipelineName = 'ppEstimatedItem'
              mmHeight = 3175
              mmLeft = 38100
              mmTop = 1058
              mmWidth = 89165
              BandType = 4
            end
            object ppDBText6: TppDBText
              UserName = 'DBText6'
              DataField = 'Model'
              DataPipeline = ppEstimatedItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              Transparent = True
              DataPipelineName = 'ppEstimatedItem'
              mmHeight = 3175
              mmLeft = 0
              mmTop = 1058
              mmWidth = 37306
              BandType = 4
            end
            object ppDBText8: TppDBText
              UserName = 'dbQty'
              DataField = 'Qty'
              DataPipeline = ppEstimatedItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppEstimatedItem'
              mmHeight = 3175
              mmLeft = 128852
              mmTop = 1058
              mmWidth = 10319
              BandType = 4
            end
            object ppDBText9: TppDBText
              UserName = 'dbPrice'
              DataField = 'SalePrice'
              DataPipeline = ppEstimatedItem
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppEstimatedItem'
              mmHeight = 3175
              mmLeft = 140759
              mmTop = 1058
              mmWidth = 13758
              BandType = 4
            end
            object ppDBText10: TppDBText
              UserName = 'dbTotal'
              DataField = 'Total'
              DataPipeline = ppEstimatedItem
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppEstimatedItem'
              mmHeight = 3175
              mmLeft = 156104
              mmTop = 1058
              mmWidth = 19315
              BandType = 4
            end
            object ppSubReport2: TppSubReport
              UserName = 'SubReport2'
              ExpandAll = False
              NewPrintJob = False
              OutlineSettings.CreateNode = True
              ParentPrinterSetup = False
              ParentWidth = False
              TraverseAllData = False
              DataPipelineName = 'ppModelFeatures'
              mmHeight = 5027
              mmLeft = 11113
              mmTop = 60061
              mmWidth = 63765
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              object ppChildReport2: TppChildReport
                AutoStop = False
                DataPipeline = ppModelFeatures
                PrinterSetup.BinName = 'Default'
                PrinterSetup.DocumentName = 'Report'
                PrinterSetup.PaperName = 'Custom'
                PrinterSetup.PrinterName = 'Default'
                PrinterSetup.mmMarginBottom = 6350
                PrinterSetup.mmMarginLeft = 6350
                PrinterSetup.mmMarginRight = 6350
                PrinterSetup.mmMarginTop = 6350
                PrinterSetup.mmPaperHeight = 279401
                PrinterSetup.mmPaperWidth = 76200
                PrinterSetup.PaperSize = 199
                Version = '7.02'
                mmColumnWidth = 0
                DataPipelineName = 'ppModelFeatures'
                object ppTitleBand1: TppTitleBand
                  mmBottomOffset = 0
                  mmHeight = 3175
                  mmPrintPosition = 0
                  object ppLabel6: TppLabel
                    UserName = 'lbFeature'
                    Caption = 'Features'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Name = 'Arial'
                    Font.Size = 8
                    Font.Style = []
                    Transparent = True
                    mmHeight = 3175
                    mmLeft = 3175
                    mmTop = 0
                    mmWidth = 10583
                    BandType = 1
                  end
                end
                object ppDetailBand3: TppDetailBand
                  mmBottomOffset = 0
                  mmHeight = 3704
                  mmPrintPosition = 0
                  object ppDBText11: TppDBText
                    UserName = 'DBText11'
                    DataField = 'Feature'
                    DataPipeline = ppModelFeatures
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlack
                    Font.Name = 'Arial'
                    Font.Size = 8
                    Font.Style = []
                    Transparent = True
                    DataPipelineName = 'ppModelFeatures'
                    mmHeight = 3175
                    mmLeft = 3175
                    mmTop = 265
                    mmWidth = 57150
                    BandType = 4
                  end
                end
                object raCodeModule3: TraCodeModule
                  ProgramStream = {
                    01060F5472614576656E7448616E646C65720B50726F6772616D4E616D650610
                    5469746C654265666F72655072696E740B50726F6772616D54797065070B7474
                    50726F63656475726506536F75726365064E70726F636564757265205469746C
                    654265666F72655072696E743B0D0A626567696E0D0A202020206C6246656174
                    7572652E43617074696F6E203A3D2073466561747572653B0D0A656E643B0D0A
                    0D436F6D706F6E656E744E616D6506055469746C65094576656E744E616D6506
                    0B4265666F72655072696E74074576656E74494402180001060F547261457665
                    6E7448616E646C65720B50726F6772616D4E616D6506115375625265706F7274
                    324F6E5072696E740B50726F6772616D54797065070B747450726F6365647572
                    6506536F75726365062D70726F636564757265205375625265706F7274324F6E
                    5072696E743B0D0A626567696E0D0A0D0A656E643B0D0A0D436F6D706F6E656E
                    744E616D65060A5375625265706F727432094576656E744E616D6506074F6E50
                    72696E74074576656E74494402200000}
                end
              end
            end
            object ppSubReport3: TppSubReport
              UserName = 'SubReport3'
              ExpandAll = False
              NewPrintJob = False
              OutlineSettings.CreateNode = True
              ParentPrinterSetup = False
              ParentWidth = False
              TraverseAllData = False
              DataPipelineName = 'ppTechFeatures'
              mmHeight = 5027
              mmLeft = 98954
              mmTop = 60590
              mmWidth = 65617
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              object ppChildReport3: TppChildReport
                AutoStop = False
                DataPipeline = ppTechFeatures
                PrinterSetup.BinName = 'Default'
                PrinterSetup.DocumentName = 'Report'
                PrinterSetup.PaperName = 'Custom'
                PrinterSetup.PrinterName = 'Default'
                PrinterSetup.mmMarginBottom = 6350
                PrinterSetup.mmMarginLeft = 6350
                PrinterSetup.mmMarginRight = 6350
                PrinterSetup.mmMarginTop = 6350
                PrinterSetup.mmPaperHeight = 279401
                PrinterSetup.mmPaperWidth = 76200
                PrinterSetup.PaperSize = 199
                Version = '7.02'
                mmColumnWidth = 0
                DataPipelineName = 'ppTechFeatures'
                object ppTitleBand2: TppTitleBand
                  mmBottomOffset = 0
                  mmHeight = 3175
                  mmPrintPosition = 0
                  object ppLabel7: TppLabel
                    UserName = 'lbTechFeature'
                    Caption = 'Tech Features'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clMaroon
                    Font.Name = 'Arial'
                    Font.Size = 8
                    Font.Style = []
                    Transparent = True
                    mmHeight = 3302
                    mmLeft = 3175
                    mmTop = 0
                    mmWidth = 17611
                    BandType = 1
                  end
                end
                object ppDetailBand4: TppDetailBand
                  mmBottomOffset = 0
                  mmHeight = 3704
                  mmPrintPosition = 0
                  object ppDBText12: TppDBText
                    UserName = 'DBText12'
                    DataField = 'TechFeature'
                    DataPipeline = ppTechFeatures
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlack
                    Font.Name = 'Arial'
                    Font.Size = 8
                    Font.Style = []
                    Transparent = True
                    DataPipelineName = 'ppTechFeatures'
                    mmHeight = 3175
                    mmLeft = 3175
                    mmTop = 265
                    mmWidth = 57150
                    BandType = 4
                  end
                end
                object raCodeModule4: TraCodeModule
                  ProgramStream = {
                    01060F5472614576656E7448616E646C65720B50726F6772616D4E616D650610
                    5469746C654265666F72655072696E740B50726F6772616D54797065070B7474
                    50726F63656475726506536F75726365065370726F636564757265205469746C
                    654265666F72655072696E743B0D0A626567696E0D0A202020206C6254656368
                    466561747572652E43617074696F6E203A3D207354656368466561743B0D0A65
                    6E643B0D0A0D436F6D706F6E656E744E616D6506055469746C65094576656E74
                    4E616D65060B4265666F72655072696E74074576656E74494402180000}
                end
              end
            end
            object ppImage2: TppImage
              UserName = 'imgItem2'
              MaintainAspectRatio = False
              Transparent = True
              mmHeight = 54504
              mmLeft = 98954
              mmTop = 5292
              mmWidth = 65088
              BandType = 4
            end
            object ppLine2: TppLine
              UserName = 'Line2'
              Weight = 0.750000000000000000
              mmHeight = 794
              mmLeft = 0
              mmTop = 0
              mmWidth = 175684
              BandType = 4
            end
          end
          object ppSummaryBand1: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 3440
            mmPrintPosition = 0
            object ppDBCalc1: TppDBCalc
              UserName = 'dbGrandTotal'
              DataField = 'Total'
              DataPipeline = ppEstimatedItem
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppEstimatedItem'
              mmHeight = 3302
              mmLeft = 156104
              mmTop = 265
              mmWidth = 19315
              BandType = 7
            end
            object ppLabel15: TppLabel
              UserName = 'lbGrandTotal'
              Caption = 'Grand Total :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3302
              mmLeft = 139659
              mmTop = 137
              mmWidth = 15917
              BandType = 7
            end
          end
          object raCodeModule1: TraCodeModule
            ProgramStream = {
              01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060E
              696D674974656D4F6E5072696E740B50726F6772616D54797065070B74745072
              6F63656475726506536F757263650C0B01000070726F63656475726520696D67
              4974656D4F6E5072696E743B0D0A626567696E0D0A202020696620707053686F
              77496D61676520616E64202870704275646765744974656D5B274974656D496D
              616765275D203C3E20272729207468656E0D0A202020202020626567696E0D0A
              202020202020696D674974656D2E56697369626C65203A3D20547275653B0D0A
              202020202020696D674974656D2E506963747572652E4C6F616446726F6D4669
              6C652870704275646765744974656D5B274974656D496D616765275D293B0D0A
              202020202020656E640D0A202020656C73650D0A202020202020696D67497465
              6D2E56697369626C65203A3D2046616C73653B0D0A090D0A656E643B0D0A0D43
              6F6D706F6E656E744E616D650607696D674974656D094576656E744E616D6506
              074F6E5072696E74074576656E74494402200001060F5472614576656E744861
              6E646C65720B50726F6772616D4E616D65061144657461696C4265666F726550
              72696E740B50726F6772616D54797065070B747450726F63656475726506536F
              757263650C2101000070726F6365647572652044657461696C4265666F726550
              72696E743B0D0A626567696E0D0A205375625265706F7274322E56697369626C
              65203A3D20707053686F77466561743B0D0A205375625265706F7274332E5669
              7369626C65203A3D20707053686F7754656368466561743B0D0A206462517479
              2E56697369626C65203A3D20707053686F775174793B0D0A2064625072696365
              2E56697369626C65203A3D20707053686F775174793B0D0A206462546F74616C
              2E56697369626C65203A3D20707053686F775174793B0D0A2064625072696365
              2E56697369626C65203A3D20707053686F775174793B0D0A2064624772616E64
              546F74616C2E56697369626C65203A3D20707053686F775174793B0D0A656E64
              3B202020202020200D0A0D436F6D706F6E656E744E616D65060644657461696C
              094576656E744E616D65060B4265666F72655072696E74074576656E74494402
              180001060F5472614576656E7448616E646C65720B50726F6772616D4E616D65
              060F696D674974656D324F6E5072696E740B50726F6772616D54797065070B74
              7450726F63656475726506536F757263650C1101000070726F63656475726520
              696D674974656D324F6E5072696E743B0D0A626567696E0D0A0D0A2020206966
              20707053686F77496D6167653220616E64202870704275646765744974656D5B
              274974656D496D61676532275D203C3E20272729207468656E0D0A2020202020
              20626567696E0D0A202020202020696D674974656D322E56697369626C65203A
              3D20547275653B0D0A202020202020696D674974656D322E506963747572652E
              4C6F616446726F6D46696C652870704275646765744974656D5B274974656D49
              6D61676532275D293B0D0A202020202020656E640D0A202020656C73650D0A20
              2020202020696D674974656D322E56697369626C65203A3D2046616C73653B0D
              0A656E643B0D0A0D436F6D706F6E656E744E616D650608696D674974656D3209
              4576656E744E616D6506074F6E5072696E74074576656E74494402200001060F
              5472614576656E7448616E646C65720B50726F6772616D4E616D650610546974
              6C654265666F72655072696E740B50726F6772616D54797065070B747450726F
              63656475726506536F757263650C0001000070726F636564757265205469746C
              654265666F72655072696E743B0D0A626567696E0D0A206C625174792E436170
              74696F6E203A3D20735174793B0D0A206C6250726963652E43617074696F6E20
              3A3D207350726963653B202020200D0A206C624D6F64656C2E43617074696F6E
              203A3D20734D6F64656C3B0D0A206C62446573632E43617074696F6E203A3D20
              73446573633B0D0A200D0A206C625174792E56697369626C65203A3D20707053
              686F775174793B0D0A206C6250726963652E56697369626C65203A3D20707053
              686F775174793B0D0A206C62546F74616C2E56697369626C65203A3D20707053
              686F775174793B0D0A200D0A656E643B0D0A0D436F6D706F6E656E744E616D65
              06055469746C65094576656E744E616D65060B4265666F72655072696E740745
              76656E74494402180000}
          end
        end
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 25135
      mmPrintPosition = 0
      object ppLine3: TppLine
        UserName = 'Line3'
        Weight = 0.750000000000000000
        mmHeight = 794
        mmLeft = 1852
        mmTop = 11377
        mmWidth = 174361
        BandType = 8
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Name'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 70115
        mmTop = 14023
        mmWidth = 59267
        BandType = 8
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Address'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 70115
        mmTop = 17992
        mmWidth = 59267
        BandType = 8
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Email'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 3175
        mmLeft = 70115
        mmTop = 21696
        mmWidth = 59267
        BandType = 8
      end
      object ppDBMemo1: TppDBMemo
        UserName = 'DBMemo1'
        CharWrap = False
        DataField = 'OBS'
        DataPipeline = ppEstimated
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppEstimated'
        mmHeight = 10319
        mmLeft = 23019
        mmTop = 529
        mmWidth = 151607
        BandType = 8
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppLabel14: TppLabel
        UserName = 'lbEmail1'
        Caption = 'OBS :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3302
        mmLeft = 14774
        mmTop = 529
        mmWidth = 7451
        BandType = 8
      end
    end
    object raCodeModule2: TraCodeModule
      ProgramStream = {
        01060D54726156617250726F6772616D094368696C645479706502110B50726F
        6772616D4E616D6506095661726961626C65730B50726F6772616D5479706507
        0B747450726F63656475726506536F7572636506EC70726F6365647572652056
        61726961626C65733B0D0A7661720D0A707053686F77496D6167652C20707053
        686F77496D616765322C20707053686F77466561742C20707053686F77546563
        68466561742C0D0A707053686F77517479203A20426F6F6C65616E3B0D0A4944
        4C616E67203A20496E74656765723B0D0A7349442C2073446174652C20735174
        792C207350726963652C2073466561747572652C207354656368466561742C0D
        0A734D6F64656C2C2073446573632C207353502C2073437573746F6D65722C20
        7350686F6E65203A20537472696E673B0D0A626567696E0D0A0D0A656E643B0D
        0A0001060A54726150726F6772616D094368696C645479706502130B50726F67
        72616D4E616D65060E476C6F62616C4F6E4372656174650B50726F6772616D54
        797065070B747450726F63656475726506536F75726365142C06000070726F63
        656475726520476C6F62616C4F6E4372656174653B0D0A626567696E0D0A2020
        2020202049444C616E67203A3D205265706F72742E506172616D65746572732E
        56616C7565735B27707049444C616E6775616765275D3B0D0A09707053686F77
        496D616765203A3D205265706F72742E506172616D65746572732E56616C7565
        735B27707053686F77496D67275D3B0D0A202020202020707053686F77496D61
        676532203A3D205265706F72742E506172616D65746572732E56616C7565735B
        27707053686F77496D6732275D3B0D0A09707053686F7746656174203A3D2052
        65706F72742E506172616D65746572732E56616C7565735B27707053686F7746
        65617475726573275D3B0D0A09707053686F775465636846656174203A3D2052
        65706F72742E506172616D65746572732E56616C7565735B27707053686F7754
        65636846275D3B0D0A09707053686F77517479203A3D205265706F72742E5061
        72616D65746572732E56616C7565735B27707053686F77517479275D3B0D0A0D
        0A09436173652049444C616E67206F660D0A0931203A20626567696E0D0A0920
        202020734944202020202020203A3D20274275646765742023273B0D0A092020
        2020734461746520202020203A3D202744617465203A273B0D0A092020202073
        5174792020202020203A3D2027517479273B0D0A092020202073507269636520
        2020203A3D20275072696365273B0D0A0920202020734665617475726520203A
        3D202746656174757265273B0D0A0920202020735465636846656174203A3D20
        27546563682046656174757265273B0D0A0920202020734D6F64656C20202020
        3A3D20274D6F64656C273B0D0A0920202020734465736320202020203A3D2027
        4465736372697074696F6E273B0D0A0920202020735350202020202020203A3D
        202753616C657320506572736F6E203A273B0D0A092020202073437573746F6D
        6572203A3D2027437573746F6D6572203A273B0D0A09202020207350686F6E65
        202020203A3D202750686F6E65203A273B0D0A20202020202020202020656E64
        3B0D0A0932203A20626567696E20202020200D0A092020202073494420202020
        2020203A3D20274EC2BA204F72C3A7616D656E746F273B0D0A09202020207344
        61746520202020203A3D202744617461203A273B0D0A09202020207351747920
        20202020203A3D2027517464273B0D0A0920202020735072696365202020203A
        3D2027507265C3A76F273B0D0A0920202020734665617475726520203A3D2027
        4361726163746572C3AD7374696361273B0D0A09202020207354656368466561
        74203A3D20274361726163742E2054C3A9636E69636F273B0D0A092020202073
        4D6F64656C202020203A3D20274D6F64656C6F273B0D0A092020202073446573
        6320202020203A3D2027446573637269C3A7C3A36F273B0D0A09202020207353
        50202020202020203A3D202756656E6465646F72203A273B0D0A092020202073
        437573746F6D6572203A3D2027436C69656E7465203A273B0D0A092020202073
        50686F6E65202020203A3D202754656C203A273B0D0A20202020202020202020
        656E643B0D0A0933203A20626567696E20202020200D0A092020202073494420
        2020202020203A3D20274EC2BA20507265737570756573746F273B0D0A092020
        2020734461746520202020203A3D20274665636861203A273B0D0A0920202020
        735174792020202020203A3D2027437464273B0D0A0920202020735072696365
        202020203A3D202750726563696F273B0D0A0920202020734665617475726520
        203A3D20274361726163746572C3AD7374696361273B0D0A0920202020735465
        636846656174203A3D20274361726163746572C3AD73746963612054C3A9636E
        696361273B0D0A0920202020734D6F64656C202020203A3D20274D6F64656C6F
        273B0D0A0920202020734465736320202020203A3D2027446573637269706369
        C3B36E273B0D0A0920202020735350202020202020203A3D202756656E646564
        6F72203A273B0D0A092020202073437573746F6D6572203A3D2027436C69656E
        7465203A273B0D0A09202020207350686F6E65202020203A3D202754656C203A
        273B0D0A20202020202020202020656E643B0D0A202020202020656E643B0D0A
        656E643B0D0A0D0A0001060F5472614576656E7448616E646C65720B50726F67
        72616D4E616D6506115265706F72744265666F72655072696E740B50726F6772
        616D54797065070B747450726F63656475726506536F7572636506C270726F63
        6564757265205265706F72744265666F72655072696E743B0D0A626567696E0D
        0A2020206C6249442E43617074696F6E203A3D207349443B0D0A2020206C6244
        6174652E43617074696F6E203A3D2073446174653B0D0A2020206C6253616C65
        73502E43617074696F6E203A3D207353503B0D0A2020206C6250686F6E652E43
        617074696F6E203A3D207350686F6E653B0D0A2020206C62437573746F6D6572
        2E43617074696F6E203A3D2073437573746F6D65723B0D0A656E643B0D0A0D43
        6F6D706F6E656E744E616D6506065265706F7274094576656E744E616D65060B
        4265666F72655072696E74074576656E74494402010000}
    end
    object ppParameterList1: TppParameterList
      object ppIDLanguage: TppParameter
        DataType = dtInteger
        Value = 1
      end
      object ppShowImg: TppParameter
        DataType = dtBoolean
        Value = True
      end
      object ppShowImg2: TppParameter
        DataType = dtBoolean
        Value = True
      end
      object ppShowFeatures: TppParameter
        DataType = dtBoolean
        Value = True
      end
      object ppShowTechF: TppParameter
        DataType = dtBoolean
        Value = True
      end
      object ppShowQty: TppParameter
        DataType = dtBoolean
        Value = True
      end
    end
  end
  object quEstimated: TPowerADOQuery [14]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 100
    CommandText = 
      'SELECT '#13#10#9'E.IDEstimated,'#13#10#9'E.EstimatedDate,'#13#10#9'E.Total,'#13#10#9'E.OBS,'#13 +
      #10#9'E.OBS2,'#13#10#9'S.Name,'#13#10#9'SU.SystemUser,'#13#10#9'P.Pessoa,'#13#10#9'P.PessoaFirst' +
      'Name,'#13#10#9'P.PessoaLastName,'#13#10#9'P.Email as CustomerEmail,'#13#10#9'P.Telefo' +
      'ne as CustomerPhone,'#13#10#9'P.Cellular as Cell,'#13#10#9'P.CellAreaCode,'#13#10#9'P' +
      '.PhoneAreaCode,'#13#10#9'P.Endereco as EnderecoCliente,'#13#10#9'P.Bairro as B' +
      'airroCliente,'#13#10#9'P.Cidade as CidadeCliente,'#13#10#9'P.CEP as CEPCliente' +
      ','#13#10#9'P.IDEstado as EstadoCliente,'#13#10#9'P.Contato as ContatoCliente,'#13 +
      #10#9'S.Address,'#13#10#9'S.IDEstado,'#13#10#9'S.City,'#13#10#9'S.Zip,'#13#10#9'S.Telephone,'#13#10#9'S' +
      '.Fax,'#13#10#9'S.Beeper,'#13#10#9'S.Cellular,'#13#10#9'S.Contato,'#13#10#9'S.Email,'#13#10#9'S.WebP' +
      'age,'#13#10#9'EMP.Empresa,'#13#10#9'EMP.RazaoSocial RazaoEMP,'#13#10#9'EMP.CGC CNPJEM' +
      'P,'#13#10#9'EMP.InscricaoEstadual IEEMP,'#13#10#9'EMP.InscricaoMunicipal IMEMP' +
      ','#13#10#9'EMP.Endereco + '#39' '#39' +CAST(EMP.Numero AS VARCHAR) + '#39' '#39' + EMP.' +
      'Coplemento EndEMP,'#13#10#9'EMP.Bairro BairroEMP,'#13#10#9'EMP.Cidade CidadeEM' +
      'P,'#13#10#9'EMP.CEP CEPEMP,'#13#10#9'EMP.IDEstado EstadoEMP,'#13#10#9'EMP.LogoEmpresa' +
      ' LogoEMP,'#13#10#9'TG.TipTouristGroup,'#13#10#9'E.DeliverDate,'#13#10#9'E.DeliverAddr' +
      'ess,'#13#10#9'E.DeliverOBS,'#13#10#9'E.TotalDiscount,'#13#10#9'E.Confirmed,'#13#10#9'DT.Name' +
      ' as DeliverType'#13#10'FROM'#13#10#9'Estimated E (NOLOCK) '#13#10#9'LEFT OUTER JOIN ' +
      'Pessoa P (NOLOCK) ON (P.IDPessoa = E.IDPEssoa)'#13#10#9'JOIN Store S (N' +
      'OLOCK) ON (S.IDStore = E.IDStore)'#13#10#9'JOIN SystemUser SU (NOLOCK) ' +
      'ON (SU.IDUser = E.IDUser)'#13#10#9'LEFT JOIN Sis_Empresa EMP (NOLOCK) O' +
      'N (S.IDEmpresa = EMP.IDEmpresa)'#13#10#9'LEFT JOIN TouristGroup TG (NOL' +
      'OCK) ON (TG.IDTouristGroup = E.IDTouristGroup)'#13#10#9'LEFT JOIN Deliv' +
      'erType DT (NOLOCK) ON (DT.IDDeliverType = E.IDDeliverType)'#13#10'WHER' +
      'E'#13#10#9'IDEstimated = :IDEstimated'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDEstimated'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 182
    Top = 14
    object quEstimatedIDEstimated: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'IDEstimated'
    end
    object quEstimatedEstimatedDate: TDateTimeField
      FieldName = 'EstimatedDate'
      ReadOnly = True
    end
    object quEstimatedTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      Precision = 19
    end
    object quEstimatedOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object quEstimatedName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quEstimatedPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quEstimatedSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quEstimatedAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quEstimatedIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quEstimatedCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object quEstimatedZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object quEstimatedTelephone: TStringField
      FieldName = 'Telephone'
      Size = 40
    end
    object quEstimatedFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quEstimatedBeeper: TStringField
      FieldName = 'Beeper'
      Size = 25
    end
    object quEstimatedCellular: TStringField
      FieldName = 'Cellular'
      Size = 18
    end
    object quEstimatedContato: TStringField
      FieldName = 'Contato'
      Size = 50
    end
    object quEstimatedEmail: TStringField
      FieldName = 'Email'
      Size = 60
    end
    object quEstimatedWebPage: TStringField
      FieldName = 'WebPage'
      Size = 80
    end
    object quEstimatedPessoaFirstName: TStringField
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quEstimatedPessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quEstimatedCustomerEmail: TStringField
      FieldName = 'CustomerEmail'
      Size = 50
    end
    object quEstimatedCustomerPhone: TStringField
      FieldName = 'CustomerPhone'
      Size = 40
    end
    object quEstimatedOBS2: TStringField
      FieldName = 'OBS2'
      Size = 255
    end
    object quEstimatedCell: TStringField
      FieldName = 'Cell'
      FixedChar = True
      Size = 18
    end
    object quEstimatedCellAreaCode: TStringField
      FieldName = 'CellAreaCode'
      Size = 5
    end
    object quEstimatedPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object quEstimatedEnderecoCliente: TStringField
      FieldName = 'EnderecoCliente'
      Size = 80
    end
    object quEstimatedBairroCliente: TStringField
      FieldName = 'BairroCliente'
      Size = 50
    end
    object quEstimatedCidadeCliente: TStringField
      FieldName = 'CidadeCliente'
      Size = 40
    end
    object quEstimatedCEPCliente: TStringField
      FieldName = 'CEPCliente'
      FixedChar = True
      Size = 12
    end
    object quEstimatedEstadoCliente: TStringField
      FieldName = 'EstadoCliente'
      FixedChar = True
      Size = 3
    end
    object quEstimatedContatoCliente: TStringField
      FieldName = 'ContatoCliente'
      Size = 50
    end
    object quEstimatedEmpresa: TStringField
      FieldName = 'Empresa'
      Size = 35
    end
    object quEstimatedRazaoEMP: TStringField
      FieldName = 'RazaoEMP'
      Size = 100
    end
    object quEstimatedCNPJEMP: TStringField
      FieldName = 'CNPJEMP'
    end
    object quEstimatedIEEMP: TStringField
      FieldName = 'IEEMP'
    end
    object quEstimatedIMEMP: TStringField
      FieldName = 'IMEMP'
    end
    object quEstimatedEndEMP: TStringField
      FieldName = 'EndEMP'
      ReadOnly = True
      Size = 102
    end
    object quEstimatedBairroEMP: TStringField
      FieldName = 'BairroEMP'
    end
    object quEstimatedCidadeEMP: TStringField
      FieldName = 'CidadeEMP'
      Size = 30
    end
    object quEstimatedCEPEMP: TStringField
      FieldName = 'CEPEMP'
      Size = 10
    end
    object quEstimatedEstadoEMP: TStringField
      FieldName = 'EstadoEMP'
      FixedChar = True
      Size = 3
    end
    object quEstimatedLogoEMP: TBlobField
      FieldName = 'LogoEMP'
    end
    object quEstimatedTipTouristGroup: TStringField
      FieldName = 'TipTouristGroup'
      Size = 50
    end
    object quEstimatedDeliverDate: TDateTimeField
      FieldName = 'DeliverDate'
    end
    object quEstimatedDeliverAddress: TStringField
      FieldName = 'DeliverAddress'
      Size = 100
    end
    object quEstimatedDeliverOBS: TStringField
      FieldName = 'DeliverOBS'
      Size = 255
    end
    object quEstimatedTotalDiscount: TBCDField
      FieldName = 'TotalDiscount'
      Precision = 19
    end
    object quEstimatedConfirmed: TBooleanField
      FieldName = 'Confirmed'
    end
    object quEstimatedDeliverType: TStringField
      FieldName = 'DeliverType'
      Size = 30
    end
  end
  object dsEstimated: TDataSource [15]
    DataSet = quEstimated
    Left = 184
    Top = 70
  end
  object dsEstimatedItems: TDataSource [16]
    DataSet = quEstimetedItems
    Left = 94
    Top = 70
  end
  object quEstimetedItems: TPowerADOQuery [17]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quEstimetedItemsCalcFields
    CommandText = 
      'SELECT '#13#10#9'EI.IDEstimatedItem,'#13#10#9'EI.IDModel,'#13#10#9'EI.Qty,'#13#10#9'EI.SaleP' +
      'rice as EstSalePrice,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'IsNull(M.Ven' +
      'dorCost,0) + IsNull(M.FreightCost,0) + IsNull(M.OtherCost,0) as ' +
      'VendorCost,'#13#10#9'M.AvgCost,'#13#10#9'M.ReplacementCost,'#13#10#9'M.SellingPrice,'#13 +
      #10#9'M.LargeImage,'#13#10#9'M.LargeImage2,'#13#10#9'F.Pessoa Manufacturer,'#13#10#9'D.De' +
      'partment'#13#10'FROM'#13#10#9'EstimatedItem EI (NOLOCK) '#13#10#9'JOIN Model M (NOLO' +
      'CK) ON (EI.IDModel = M.IDModel)'#13#10#9'LEFT JOIN Pessoa F (NOLOCK) ON' +
      ' (M.IDFabricante = F.IDPessoa)'#13#10#9'LEFT JOIN Inv_Department D (NOL' +
      'OCK) ON (EI.IDDepartment = D.IDDepartment)'#13#10'WHERE'#13#10#9'EI.IDEstimat' +
      'ed = :IDEstimated'#13#10'ORDER BY'#13#10#9'D.Department,'#13#10#9'EI.IDEstimatedItem' +
      #13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDEstimated'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 92
    Top = 14
    object quEstimetedItemsIDEstimatedItem: TIntegerField
      FieldName = 'IDEstimatedItem'
    end
    object quEstimetedItemsIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quEstimetedItemsModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quEstimetedItemsDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quEstimetedItemsLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
    object quEstimetedItemsLargeImage2: TStringField
      FieldName = 'LargeImage2'
      Size = 255
    end
    object quEstimetedItemsTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Total'
      Calculated = True
    end
    object quEstimetedItemsItemImage: TStringField
      FieldKind = fkCalculated
      FieldName = 'ItemImage'
      Size = 200
      Calculated = True
    end
    object quEstimetedItemsItemImage2: TStringField
      FieldKind = fkCalculated
      FieldName = 'ItemImage2'
      Size = 255
      Calculated = True
    end
    object quEstimetedItemsReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quEstimetedItemsVendorCost: TBCDField
      FieldName = 'VendorCost'
      ReadOnly = True
      Precision = 19
    end
    object quEstimetedItemsAvgCost: TBCDField
      FieldName = 'AvgCost'
      Precision = 19
    end
    object quEstimetedItemsSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quEstimetedItemsEstSalePrice: TBCDField
      FieldName = 'EstSalePrice'
      Precision = 19
    end
    object quEstimetedItemsSalePrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'SalePrice'
      Calculated = True
    end
    object quEstimetedItemsQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quEstimetedItemsItemDiscount: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ItemDiscount'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quEstimetedItemsItemDiscPercent: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ItemDiscPercent'
      Calculated = True
    end
    object quEstimetedItemsManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object quEstimetedItemsDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object ppEstimated: TppDBPipeline [18]
    DataSource = dsEstimated
    UserName = 'ppBudget'
    Left = 184
    Top = 132
  end
  object ppEstimatedItem: TppDBPipeline [19]
    DataSource = dsEstimatedItems
    UserName = 'ppBudgetItem'
    Left = 98
    Top = 125
  end
  object dsFeatures: TDataSource [20]
    DataSet = quFeatures
    Left = 262
    Top = 68
  end
  object quFeatures: TPowerADOQuery [21]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'F.IDInvFeatures,'#13#10#9'F.Feature'#13#10'FROM'#13#10#9'InvFeatures F (NO' +
      'LOCK) '#13#10'WHERE'#13#10#9'F.IDModel = :IDModel'#13#10
    CommandTimeout = 180
    DataSource = dsEstimatedItems
    MasterFields = 'IDModel'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 265
    Top = 17
    object quFeaturesIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object quFeaturesFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object ppModelFeatures: TppDBPipeline [22]
    DataSource = dsFeatures
    SkipWhenNoRecords = False
    UserName = 'ppModelFeatures'
    Left = 266
    Top = 124
    MasterDataPipelineName = 'ppEstimatedItem'
  end
  object quTechFeature: TADOQuery [23]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    DataSource = dsEstimatedItems
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'F.IDInvTechFeatures,'
      #9'F.TechFeature'
      'FROM'
      #9'InvTechFeatures F (NOLOCK) '
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = F.IDModel)'
      'WHERE'
      #9'F.IDModel = :IDModel')
    Left = 349
    Top = 19
    object quTechFeatureIDInvTechFeatures: TIntegerField
      FieldName = 'IDInvTechFeatures'
    end
    object quTechFeatureTechFeature: TStringField
      FieldName = 'TechFeature'
      Size = 255
    end
  end
  object dsTechFeature: TDataSource [24]
    DataSet = quTechFeature
    Left = 352
    Top = 67
  end
  object ppTechFeatures: TppDBPipeline [25]
    DataSource = dsTechFeature
    SkipWhenNoRecords = False
    UserName = 'ppTechFeatures'
    Left = 353
    Top = 123
    MasterDataPipelineName = 'ppEstimatedItem'
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmEstimatedPrint.sil'
  end
  object ppDesigner: TppDesigner
    AllowDataSettingsChange = True
    Caption = 'Dynamic Reports'
    DataSettings.DatabaseName = 'ADODBConnect'
    DataSettings.SessionType = 'ADOSession'
    DataSettings.AllowEditSQL = True
    DataSettings.CollationType = ctASCII
    DataSettings.DatabaseType = dtMSSQLServer
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqSQL1
    DataSettings.UseDataDictionary = True
    Icon.Data = {
      0000010002002020000001001800A80C0000260000002020000001002000A810
      0000CE0C00002800000020000000400000000100180000000000800C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009D9D9C8988877275
      7569686A73727175767500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000008485847475738A8B8B9B999BA5A3A4A8A7A7A7A6A6A8A8
      A8A6A6A6DCDCDCDFDEDF78787873757500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006D6D6D717272A5A6A5CAC9C9CECECDC5C6C5BABBBBB2B2B2ABABAAA7A7
      A7A1A1A1CCCCCCFFFFFFF8F8F8A3A2A263636300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000686766
      979696CFCDCEE6E5E5E2E2E1D2D2D2C8C8C7BFBEBEB6B6B6AFAFAFA9A9AAA5A5
      A5A1A1A1D5D6D6FFFFFFF7F7F7FFFFFFCDCCCD61616200000000000000000000
      0000000000000000000000000000000000000000000000000000000000E2E0DF
      FFFFFFF3F3F3E5E4E4D9D7D7D1D0CFCBCBC9CBCACBC8C8C7C4C4C4BEBFBFBDBD
      BDB2B3B2A2A2A2EFEFEFFEFEFEF6F6F6FFFFFFF1F0F086868600000000000000
      0000000000000000000000000000000000000000000000000000000000F1F0F1
      F3F2F2EAE9E9E8E8E8E7E6E6E6E6E6E0DFDFCECECEBEBFBEB5B5B5B0B0B0ACAC
      AC9D9D9D6D6D6E858686DCDBDCFFFEFEF7F7F6FFFEFEFEFFFE8D8E8D00000000
      0000000000000000000000000000000000000000000000000000D3D2D2EDEBEB
      F7F7F6F2F1F1E1E1E0C9C8C8BEBEBFBCBCBDBBBABABBBBBBB8B7B7B1B0B1A6A6
      A6A6A7A7C7C7C7B5B4B5939293BBBBBAF9F9F9FBFBFBFFFEFFF6F5F674737200
      0000000000000000000000000000000000000000000000000000DBDBDAE0E1E0
      D0D0D0BBBBBBBCBBBBCFCECEE5E4E4F0EEEEE9E8E9D8D7D8C6C6C7B9B8B8AEAE
      AEA6A6A5BFC0BFD1D4D1D6D7D79394938F8E8CDEDEDEFFFFFFFFFFFFAEAEAA00
      0000000000000000000000000000000000000000000000000000C5C5C5A1A1A1
      CCCCCDE5E4E4F9F8F8F9F8F8F0EFEFE3E3E2D4D3D4C4C3C4BCBBBCBFBDBDC6C6
      C5A3A3A3919191C5C8C5CDCFCEDFE1E0ACADAB7B7A79B3B3B3FFFFFFD8D8D600
      0000000000000000000000000000000000000000000000000000B9BABAD1D1D0
      FFFDFEEFEEEEDBDBDAD6D6D6D4D4D3BFBFBDC5C5C5C9C7C6D0CDCCEAEAEACECD
      CBE1E0E09C9C9CA9A9A8C6C9C6CCCECDE7E8E7D2D2D18181828C8C8BDCDCDC00
      0000000000000000000000000000000000000000000000000000000000C2C0BE
      D2D2D2B2B1B0CDCDCDCFCECDD3D3D1E4E4E4CDCAC9E9E8E7E3E1DFDFDCDCF1F1
      F0D7D4D2E5E4E49C9C9DB4B6B4C4C6C3CACCCAE4E5E4EBEBEB9E9F9E7D7D7E00
      0000000000000000000000000000000000000000000000000000000000ACA8A5
      CCCBCBE0DFDED0CCC9E3E2E1DBDBDAC8C5C5CECFCECECDCBF0F0F0DBD8D8E1DE
      DEEAEAE9E5E4E3E0E1E1B3B3B3E5E6E5D0D2D0D5D6D5E1E2E1F4F5F4AEAEAE00
      0000000000000000000000000000000000000000000000000000000000000000
      AFA9A4D4D4D3E5E5E5DCDAD9DEDDDDD8D6D6CDCDCAD5D5D4D6D4D2F4F3F2E1DF
      DFEFEFF0E1DFDFECECECE7E6E7DCDBDCD1D1D0BDBFBDDBDDDBEDEEEDC8C9C800
      0000000000000000000000000000000000000000000000000000000000000000
      0000009F9C98E3E4E7E1E0DFCCCAC8FAFBFBF2F1F0F7F8F7DDDFE0E8E9EAE2E2
      E3BEBEBE9D9E9E7676776767684B4A4B605F5F3739397A7978DEDEDEDEDEDE00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3AFAEE1E2E3EAEBECDEDFE1ADB0B485888C7575757373727878
      784241421414141111110C0C0E0404044B4B4B3D3E3D1516154E4D4C9A999900
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000A8A6A75B5D5E545250797166AA977EDCC6A2998B7A5256
      5A4B494A0F0F0F1C1C1C2525242525254C4C4C77777633333235363561606000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B7A48FEFD0AAFFDCB2FFD8AFFFD9B1EDD2B0625F
      5D5A5B5D4B4B4A5555555A5A5A5657564F50503D3C3E5453545B5C5B9B9B9B00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E0CDB7FFDAAEFECAA8FED1B1FCD2B5FFE2C3CDC0
      AC949495ADAEAE3D3D3D222222232222161514454544A4A4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFDFC4FFE3CAFADEC5FBDCC4FBE1CCFFFD
      ECC6C4BF0000000000000000000000002529319FA1A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4E6D8FCEBDAF8E9D8F6EADDF9EF
      E2FEFBF4B6B6B6000000000000000000614E30645C4C756C5C877C6800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAD8D5FAF1E5F5EBE1F3EBE0F8F0
      E5FAF9F6ABAEB4000000C29840D09D2EFCB42AEEAC2FF9B927DAAD587F859000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000EFEDECFAF7F5F7F7F6FAFA
      F9F8F7F69FA5AEC7BAA5FFCE44FFC93AFFC338FFC135FFC529BA934E686D7700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000E8E8EAFFFFFFF9FAFBF1F1
      F1E9E7E7BFC1C6B5B3AFC59A43C29645A1844B9D7E469D7D4559504200000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CCCCCCD1D1D10000000000
      000000000000000000009795928E8E90888A9000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
      0FFFFF8003FFFE0001FFF80000FFF800007FF800003FF000001FF000001FF000
      001FF000001FF800001FF800001FFC00001FFE00001FFF00001FFF80001FFFC0
      001FFFC0007FFFE03CFFFFF01C3FFFF0101FFFF8001FFFF8003FFFF9F1FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000002000000040000000010020000000
      00008010000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FDFDFD02FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F1F112E3E4E322DFDFE024D9D8D929CACAC938BBBB
      BB45E8E8E81CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01EEEE
      EE11D8D8D828BDBCBD51A9A8A97A9D9D9C96898887B3727575D269686AE27372
      71F0757675CFA0A1A17FEFEFEF15FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F708C5C5C53A848584857475
      73B98A8B8BD19B999BEBA5A3A4F7A8A7A7FCA7A6A6FFA8A8A8FFA6A6A6FFDCDC
      DCFFDFDEDFFF787878FF737575B2E1E1E122FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E6199FA0A0656D6D6DAC717272E6A5A6A5FFCAC9
      C9FFCECECDFFC5C6C5FFBABBBBFFB2B2B2FFABABAAFFA7A7A7FFA1A1A1FFCCCC
      CCFDFFFFFFFDF8F8F8FFA3A2A2FF636363CBC4C4C33CFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5E5E530686766C3979696FFCFCDCEFFE6E5E5FFE2E2E1FFD2D2
      D2FFC8C8C7FFBFBEBEFFB6B6B6FFAFAFAFFFA9A9AAFFA5A5A5FFA1A1A1FFD5D6
      D6FEFFFFFFFDF7F7F7FDFFFFFFFDCDCCCDFF616162E9A0A0A05FFFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D8D7D764E2E0DFFFFFFFFFFFF3F3F3FFE5E4E4FFD9D7D7FFD1D0
      CFFFCBCBC9FFCBCACBFFC8C8C7FEC4C4C4FFBEBFBFFFBDBDBDFEB2B3B2FFA2A2
      A2FEEFEFEFFDFEFEFEFDF6F6F6FDFFFFFFFDF1F0F0FF868686F2A3A3A35FFEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D5D4D46AF1F0F1FFF3F2F2FFEAE9E9FFE8E8E8FFE7E6E6FFE6E6
      E6FFE0DFDFFECECECEFEBEBFBEFFB5B5B5FEB0B0B0FFACACACFF9D9D9DFE6D6D
      6EFD858686FEDCDBDCFEFFFEFEFDF7F7F6FDFFFEFEFDFEFFFEFF8D8E8DF2A0A0
      A063FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D3D2D280EDEBEBFFF7F7F6FFF2F1F1FFE1E1E0FFC9C8C8FFBEBE
      BFFFBCBCBDFFBBBABAFFBBBBBBFFB8B7B7FFB1B0B1FFA6A6A6FFA6A7A7FEC7C7
      C7FDB5B4B5FD939293FDBBBBBAFDF9F9F9FDFBFBFBFDFFFEFFFDF6F5F6FF7473
      72DBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DBDBDA93E0E1E0FFD0D0D0FFBBBBBBFEBCBBBBFECFCECEFEE5E4
      E4FFF0EEEEFFE9E8E9FFD8D7D8FFC6C6C7FFB9B8B8FFAEAEAEFFA6A6A5FEBFC0
      BFFED1D4D1FFD6D7D7FF939493FE8F8E8CFEDEDEDEFDFFFFFFFDFFFFFFFFAEAE
      AAFAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C59DA1A1A1FFCCCCCDFEE5E4E4FFF9F8F8FFF9F8F8FFF0EF
      EFFFE3E3E2FFD4D3D4FEC4C3C4FEBCBBBCFFBFBDBDFDC6C6C5FEA3A3A3FE9191
      91FEC5C8C5FFCDCFCEFFDFE1E0FEACADABFE7B7A79FDB3B3B3FEFFFFFFFFD8D8
      D6FAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9BABAA5D1D1D0FFFFFDFEFFEFEEEEFEDBDBDAFED6D6D6FED4D4
      D3FDBFBFBDFDC5C5C5FDC9C7C6FDD0CDCCFEEAEAEAFDCECDCBFEE1E0E0FD9C9C
      9CFDA9A9A8FEC6C9C6FFCCCECDFFE7E8E7FFD2D2D1FF818182FF8C8C8BFFDCDC
      DCF9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CDCDCD6BC2C0BEFFD2D2D2FFB2B1B0FDCDCDCDFECFCECDFDD3D3
      D1FDE4E4E4FDCDCAC9FEE9E8E7FDE3E1DFFEDFDCDCFEF1F1F0FDD7D4D2FDE5E4
      E4FD9C9C9DFDB4B6B4FDC4C6C3FECACCCAFFE4E5E4FFEBEBEBFF9E9F9EFF7D7D
      7EEFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F7F70FACA8A59ACCCBCBFEE0DFDEFFD0CCC9FEE3E2E1FDDBDB
      DAFDC8C5C5FDCECFCEFDCECDCBFEF0F0F0FDDBD8D8FEE1DEDEFDEAEAE9FDE5E4
      E3FDE0E1E1FDB3B3B3FDE5E6E5FED0D2D0FFD5D6D5FFE1E2E1FFF4F5F4FFAEAE
      AEEEFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F6F5F410AFA9A4A4D4D4D3FFE5E5E5FEDCDAD9FEDEDD
      DDFDD8D6D6FDCDCDCAFED5D5D4FED6D4D2FEF4F3F2FDE1DFDFFEEFEFF0FDE1DF
      DFFEECECECFDE7E6E7FDDCDBDCFDD1D1D0FDBDBFBDFEDBDDDBFFEDEEEDFFC8C9
      C8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7E5E7259F9C98DAE3E4E7FFE1E0DFFFCCCA
      C8FDFAFBFBFDF2F1F0FDF7F8F7FDDDDFE0FDE8E9EAFDE2E2E3FDBEBEBEFE9D9E
      9EFE767677FE676768FE4B4A4BFE605F5FFE373939FD7A7978FEDEDEDEFFDEDE
      DEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D0CE49B3AFAEBDE1E2E3FBEAEB
      ECFFDEDFE1FDADB0B4FD85888CFD757575FD737372FD787878FE424142FE1414
      14FE111111FE0C0C0EFE040404FE4B4B4BFD3D3E3DFD151615FF4E4D4CFF9A99
      99FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E5E428A8A6A7A25B5D
      5EFE545250FF797166FFAA977EFEDCC6A2FF998B7AFE52565AFD4B494AFF0F0F
      0FFF1C1C1CFD252524FD252525FD4C4C4CFD777776FD333332FF353635FF6160
      60DCFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D3D23EB7A4
      8FEAEFD0AAFFFFDCB2FFFFD8AFFFFFD9B1FFEDD2B0FF625F5DFD5A5B5DF64B4B
      4AFF555555FF5A5A5AFF565756FF4F5050FD3D3C3EFF545354FF5B5C5BFF9B9B
      9B9AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F5F50FE0CD
      B7C3FFDAAEFFFECAA8FFFED1B1FEFCD2B5FEFFE2C3FECDC0ACFE949495AFADAE
      AE8A3D3D3DEE222222FF232222FF161514FF454544DFA4A4A48EC0BFBF66F1F1
      F116FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E3
      E150FFDFC4F6FFE3CAFFFADEC5FEFBDCC4FEFBE1CCFEFFFDECFFC6C4BFE0D5D5
      D541DFDFDF34B9BAB969ABABAC77252931FF9FA1A38BFDFDFD02F0F0F016FAFA
      FA09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF01EDE8E570F4E6D8FBFCEBDAFFF8E9D8FEF6EADDFEF9EFE2FEFEFBF4FFB6B6
      B699FFFFFF00F0F0F014BBBAB95E614E30FF645C4CDB756C5CC7877C68E8B8B8
      BA7CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF01DAD8D5A9FAF1E5FFF5EBE1FEF3EBE0FEF8F0E5FEFAF9F6FFABAE
      B4AEBCB3A673C29840E3D09D2EFEFCB42AFFEEAC2FFFF9B927FFDAAD58FF7F85
      90BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E4E5E566EFEDECFFFAF7F5FEF7F7F6FEFAFAF9FFF8F7F6FF9FA5
      AEB8C7BAA5A1FFCE44FDFFC93AFFFFC338FFFFC135FFFFC529FFBA934EFF686D
      77C1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DFE0E04AE8E8EAFFFFFFFFFFF9FAFBFFF1F1F1FFE9E7E7FFBFC1
      C694B5B3AF8BC59A43FFC29645FFA1844BFF9D7E46FF9D7D45FF595042ED9FA0
      A16CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0F0F020CCCCCC98D1D1D190DCDDDC72E1E1E15DE3E3E34BF8F8
      F813CCCCCC599795929B8E8E908F888A9083999B9E74B2B4B75DCCCCCD3AF9F9
      F906FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFFFFFFF9FFFFFFF9
      FFFFFFF80FFFFF8003FFFE0001FFF80000FFF000007FF000001FF000001FF000
      001FF000001FF000001FF000001FF000001FF000001FF800001FFC00001FFE00
      001FFF00001FFF80001FFF80001FFFC0001FFFC0101FFFE0001FFFF0001FFFF0
      001FFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Position = poScreenCenter
    Report = ppBudget
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    WindowState = wsMaximized
    Left = 25
    Top = 139
  end
  object SV: TSaveDialog
    Filter = '*.PDF|*.PDF|All|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 270
    Top = 170
  end
  object PsRBExportMasterControl: TPsRBExportMasterControl
    PDF.ShowSetupDialog = False
    PDF.CompressionMethod = cmNormal
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
    JPEG.ShowSetupDialog = False
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
    Left = 23
    Top = 210
  end
  object quPayments: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    DataSource = dsEstimatedItems
    Parameters = <
      item
        Name = 'IDEstimated'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PC.IDPaymentCondition,'
      '        MP.IDMeioPag,'
      '        MP.MeioPag,'
      '        MP.ImageIndex,'
      #9'PC.Amount,'
      #9'PC.OBS'
      'FROM'
      '        Sal_PaymentCondition PC (NOLOCK)'
      
        '        Join MeioPag MP (NOLOCK) on ( PC.IDMeioPag = MP.IDMeioPa' +
        'g )'
      'WHERE'
      #9'PC.IDEstimated = :IDEstimated ')
    Left = 97
    Top = 191
    object quPaymentsIDPaymentCondition: TIntegerField
      FieldName = 'IDPaymentCondition'
    end
    object quPaymentsIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quPaymentsMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object quPaymentsImageIndex: TIntegerField
      FieldName = 'ImageIndex'
    end
    object quPaymentsAmount: TBCDField
      FieldName = 'Amount'
      Precision = 19
    end
    object quPaymentsOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
  end
  object dsPayments: TDataSource
    DataSet = quPayments
    Left = 100
    Top = 239
  end
  object ppPayments: TppDBPipeline
    DataSource = dsPayments
    SkipWhenNoRecords = False
    UserName = 'ppPayments'
    Left = 101
    Top = 295
  end
end
