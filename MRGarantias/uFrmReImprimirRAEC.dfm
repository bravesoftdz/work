object FrmReImprimir: TFrmReImprimir
  Left = 158
  Top = 176
  Width = 783
  Height = 480
  Caption = 'Re-imprimir RAEC'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 775
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      775
      53)
    object Label3: TLabel
      Left = 20
      Top = 20
      Width = 14
      Height = 13
      Caption = 'De'
    end
    object Label4: TLabel
      Left = 148
      Top = 20
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object edtDataInicial: TcxDateEdit
      Left = 40
      Top = 16
      Width = 101
      Height = 21
      TabOrder = 0
    end
    object edtDataFinal: TcxDateEdit
      Left = 168
      Top = 16
      Width = 101
      Height = 21
      TabOrder = 1
    end
    object btnExec: TcxButton
      Left = 715
      Top = 8
      Width = 50
      Height = 37
      Anchors = [akTop, akRight]
      Caption = '&GO!'
      TabOrder = 2
      OnClick = btnExecClick
    end
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 434
    Width = 775
    Height = 19
    Panels = <
      item
        Text = 'Total de 0 Garantias'
        Width = 50
      end>
  end
  object pnlCentro: TPanel
    Left = 0
    Top = 53
    Width = 775
    Height = 353
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grdGarantias: TcxGrid
      Left = 0
      Top = 0
      Width = 775
      Height = 353
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdGarantiasTableView: TcxGridDBTableView
        DataController.DataSource = dsForm
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object grdGarantiasTableViewCheck: TcxGridDBColumn
          Caption = 'Check'
          DataBinding.FieldName = 'Checado'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          Properties.ReadOnly = False
        end
        object grdGarantiasTableViewInvoiceCode: TcxGridDBColumn
          Caption = 'N'#186' Pedido'
          DataBinding.FieldName = 'SaleCode'
          Options.Editing = False
          Width = 77
        end
        object grdGarantiasTableViewDescription: TcxGridDBColumn
          Caption = 'Garantia'
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Width = 115
        end
        object grdGarantiasTableViewDBGarantiaMeses: TcxGridDBColumn
          Caption = 'Meses'
          DataBinding.FieldName = 'GarantiaMeses'
          Options.Editing = False
          Width = 26
        end
        object grdGarantiasTableViewQty: TcxGridDBColumn
          Caption = 'Qtd'
          DataBinding.FieldName = 'Qty'
          Options.Editing = False
          Width = 23
        end
        object grdGarantiasTableViewDBGarantiaFabrica: TcxGridDBColumn
          Caption = 'Gar. F'#225'brica'
          DataBinding.FieldName = 'GarantiaFabrica'
          Options.Editing = False
          Width = 45
        end
        object grdGarantiasTableViewSalePrice: TcxGridDBColumn
          Caption = 'R$ Garan.'
          DataBinding.FieldName = 'SalePrice'
          Options.Editing = False
          Width = 59
        end
        object grdGarantiasTableViewNFProduto: TcxGridDBColumn
          Caption = 'N'#186' fatura prod.'
          DataBinding.FieldName = 'NotaFiscalProduto'
          Options.Editing = False
          Width = 77
        end
        object grdGarantiasTableViewLookupProduct: TcxGridDBColumn
          Caption = 'Selecionar produto'
          DataBinding.FieldName = 'IDModel'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.DropDownListStyle = lsEditList
          Properties.KeyFieldNames = 'IDModel'
          Properties.ListColumns = <
            item
              FieldName = 'Description'
            end>
          Properties.ListOptions.ColumnSorting = False
          Properties.ListOptions.GridLines = glNone
          Properties.ListOptions.ShowHeader = False
          Options.Editing = False
          Width = 187
        end
        object grdGarantiasTableViewDBColumn1: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'DescProduto'
          Options.Editing = False
          Width = 157
        end
        object grdGarantiasTableViewValorProduto: TcxGridDBColumn
          Caption = 'R$ Prod.'
          DataBinding.FieldName = 'ValorProduto'
          Options.Editing = False
          Width = 62
        end
        object grdGarantiasTableViewIDInventoryMov: TcxGridDBColumn
          DataBinding.FieldName = 'IDInventoryMov'
          Visible = False
          Options.Editing = False
        end
        object grdGarantiasTableViewIDInvoice: TcxGridDBColumn
          DataBinding.FieldName = 'IDInvoice'
          Visible = False
          Options.Editing = False
        end
        object grdGarantiasTableViewModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Visible = False
          Options.Editing = False
        end
        object grdGarantiasTableViewStoreID: TcxGridDBColumn
          DataBinding.FieldName = 'StoreID'
          Visible = False
          Options.Editing = False
        end
        object grdGarantiasTableViewDiscount: TcxGridDBColumn
          DataBinding.FieldName = 'Discount'
          Visible = False
          Options.Editing = False
        end
        object grdGarantiasTableViewMovDate: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'MovDate'
          Visible = False
          Options.Editing = False
          Width = 50
        end
        object grdGarantiasTableViewDataEnvio: TcxGridDBColumn
          Caption = 'Data Envio'
          DataBinding.FieldName = 'DataEnvio'
          Options.Editing = False
        end
      end
      object grdGarantiasLevel: TcxGridLevel
        GridView = grdGarantiasTableView
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 406
    Width = 775
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object btnImprimir: TcxButton
      Left = 644
      Top = 4
      Width = 59
      Height = 21
      Caption = '&Imprimir'
      TabOrder = 0
      OnClick = btnImprimirClick
    end
    object btnFechar: TcxButton
      Left = 708
      Top = 4
      Width = 59
      Height = 21
      Caption = '&Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
  end
  object ppReport: TppReport
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4, 210x297 mm'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    Template.FileName = 'C:\Documents and Settings\Leonardo\Desktop\Garantias.rtm'
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = True
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 128
    Top = 132
    Version = '7.02'
    mmColumnWidth = 0
    object ppHeaderBand: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 21960
      mmPrintPosition = 0
      object ppImage: TppImage
        UserName = 'Image'
        MaintainAspectRatio = False
        Picture.Data = {
          0A544A504547496D6167652C090000FFD8FFE000104A46494600010101006000
          600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
          0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
          3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
          3232323232323232323232323232323232323232323232323232323232323232
          32323232323232323232323232FFC00011080054005503012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA
          290D1400B45725F10AEAE2D3C3C24B6B89607F340DD13953F98AF2CFEDDD63FE
          82FA87FE053FF8D7A186CBE588A7CEA563CAC666B0C2D4F6728B67D0145780C7
          ACEB72C8B1C7AA6A4EEC70AAB732124FA019ADBB7D2BC71730F9A92EAAA319C4
          972E87F22735ACF2BE4F8AA24634F39F69F0526FD0F63A2BC1EF2FFC47A7CDE5
          5DDF6AB049D42C93C8B91EA327915D67C36D46FAF358BC4BABDB9B8410642CD3
          3380770E79351572D953A4EA732691743378D5ACA97234D9E99452515E69EC0B
          451450021A283450071BF12BFE45A5FF00AEAB5E2BA86A96FA747990EE723E54
          1D4D7B57C4AFF916D7FEBAAD7CCD7376975AA9B894930993383FDDCF4FCABE83
          2FA9C986D3BB3C2AF8158BC7BE7F852573E83F86BA4476DE1FFF00849753558E
          59C168D4F3E4C438E7DC904FD31568FC4A6B8BF16FA768D25D06385265DAC7F0
          C1FE75D0358A6B1E0B86CECE548E39ED515587200DA2B39A4F0E780ED3088AD7
          8CA0101B74921C75E7EE83F80AF3E3385694A5522E537B23AAB42746D1A4D53A
          6B77FF000E6CEB1A7D9EB1A2B47A8A08432862588CC671EB5C27C348D62F11EA
          51A48254484AAC8BD18071C8FAD735AE789B51D76E1DA79DD6027E4814E140F7
          C75FC6BA2F85BFF21BBDFF00AF7FFD98576FD56743093E77BF4EC79BF5CA789C
          753E48EDD7B9EA9451457847D28B451450021A283450073FE2FD0EEB5FD205A5
          A3C292070D9958818FC01AF95B5AD2A7D0F59BBD32E40F36DA568C900E1B0719
          19C706BEC9AE07C7FF000CED3C603ED96F2FD975345C093195907A30FEB5DD85
          C57B3F725B111A518D47516EEDF81CFF00C1BF1C5BDCE94BE1BBF9163B9B727E
          CCCD802443CEDCFF00781CFE045757A87C38D36F2F1AE22B8961DEC59D31B81C
          9CF1CF15E3C7E0DF8CEDAE434115BE55B29225C0047BFB57A3F83FC1FE37B558
          D75BF134F0DB2601B687648CD8F59181E3D7BFBD5CE4A9C9D4A33B5C9AF87A55
          D5AA2B9D2BF8234A4D16E34FB48916695789A4F9981EC7E9D6A9782FC21A8F87
          751B8B8BC9AD5D248B6010BB139C83CE54575F6D6B15A42B1441B03BB31627F1
          3CD4D5CFF5AABC9283774F731FA8D0F691A8959C76B0514515CC758B45145003
          64758D19DD82AA8C927B0AC883C55A0DD4E218356B49256CE1164049C0C9FD01
          AB9AB02748BC0393E4B7F2AF13F874E2D6EF4E92E35F844518919F4F6D397790
          11B23CCCE7DFF0AD614D4A2DBE807B2BF88F458ED23BB7D52D160918A2399461
          987503DEA0FF0084BBC3DE6796759B30F9DBB4C8339F4AF1FD38DBE99E284F13
          5EE90EBE18BCB997EC908CC8217C0532152380C4135DBCBA65A37C5EB6C58C06
          0362EDFEA86D272BCF4EB572A518BDFA7F4867593F8A342B6B936F3EAB691CC3
          1946900232323F9D4C9AFE92F3DCC2BA85B996D8319D038CC601C1CFA62BC635
          25687E26F881CEB116991F9D16164B159C4A362F0093F2E3DAB3AF6CEE2CEF3C
          5DADC76D2BF95AADC5BCC1723314A9220FA8DEC87F0AB5878BEBD80F739FC51A
          15A98C4FAB5A466440E9BA40372924647B707F2A926F1068F6F6715E4BA9DA2D
          B4AC56397CD05588EA011DF835E33A6DD58E97E32D06EB578375A0D00210F16F
          1BBCD7C0C1EF58BE22D32FE2D04DE1826B6B1BDF10C975628F1FFAA8583153B3
          B0E41C50B0F1BA570B1EF43C57A01B7370357B4F2436D2FE60C67D2ADD86B1A6
          EAA0FD82FEDAE768CB08A40C47D40E95E23732C49A5696D71AA45AA470DFAB4A
          E964B08452A7820673D0D763A1AC3ABFC4C8F57D02D1ADF4986D5A2BA9045B12
          77C1C63D7191F9544A8C52BDC0F4BA28A2B9C435C12A42B6D247071D2B33FB3F
          53FF00A0D49FF80E9FE15A868A69D80E5B55D4D3459162BFF133472B2EF11ADA
          ABB6DFEF10A090383CF4E0D685B417B796D1DCDB6BE6586550E92241195607A1
          06B0FC41E18D565D7EE354D2A457FB5DB2412A19844F1EC2C415728E30777236
          F6EB58979E07F13DCDF68F72D77019AC9200F324CC9B8AE3CC0540C1C8CE3A62
          B64A2D6E33BCFECFD53FE83527FE03A7F851FD9FAA7FD06A4FFC074FF0AF3E9F
          E1CEB32E97342D2C2F3CF7B24923FDA5D5845C18C2B741825F231CE7AD4C3C01
          AE4D736D7177731492436B649BBCF6FF00591BC5E69FC51641EF9A5CB1FE6FC0
          0EC945CC91AC91788BCD42FE5EE8A08DC6EF4E0559FECFD53FE83527FE03A7F8
          5725A7782B53B1D062B08FECF1CB1EADF6C6916662248F07A8C7079031ED5830
          FC39F128174259C086608ED6D15FB2ABC808CFCC5095538271CE3A64F5A7CB1F
          E603D2FF00B3F54FFA0DC9FF0080E9FE1535ADA5EC33069F527B84C7DC30AAFE
          A2A2F0F595CE9DA059DA5E797E7C49B5FCA24A8E7B13C9AD3AC9BE82168A28A9
          00A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803FFD9}
        mmHeight = 20373
        mmLeft = 4498
        mmTop = 1588
        mmWidth = 21431
        BandType = 0
      end
      object ppLabel: TppLabel
        UserName = 'Label'
        Caption = 'Recibo de Aquisi'#231#227'o Extended'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5821
        mmLeft = 26988
        mmTop = 9260
        mmWidth = 71173
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'RAEC-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5842
        mmLeft = 26988
        mmTop = 15875
        mmWidth = 15494
        BandType = 0
      end
      object ppDBText26: TppDBText
        UserName = 'DBText26'
        DataField = 'SequencyNum'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 5821
        mmLeft = 42863
        mmTop = 15875
        mmWidth = 17198
        BandType = 0
      end
    end
    object ppDetailBand: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 168540
      mmPrintPosition = 0
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'Cliente Garantido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5821
        mmLeft = 2117
        mmTop = 2117
        mmWidth = 50536
        BandType = 4
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = 'Produto Garantido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5821
        mmLeft = 2117
        mmTop = 55298
        mmWidth = 51858
        BandType = 4
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = 'Garantia Complementar Extended Adquirida:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5821
        mmLeft = 2117
        mmTop = 98161
        mmWidth = 114565
        BandType = 4
      end
      object ppLine: TppLine
        UserName = 'Line'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 2381
        mmLeft = 2117
        mmTop = 1323
        mmWidth = 192088
        BandType = 4
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 2381
        mmLeft = 2117
        mmTop = 54504
        mmWidth = 192088
        BandType = 4
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 2381
        mmLeft = 2117
        mmTop = 8202
        mmWidth = 192088
        BandType = 4
      end
      object ppLine3: TppLine
        UserName = 'Line3'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 2381
        mmLeft = 2117
        mmTop = 61383
        mmWidth = 192088
        BandType = 4
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 2381
        mmLeft = 2117
        mmTop = 97367
        mmWidth = 192088
        BandType = 4
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Pen.Width = 2
        Weight = 1.500000000000000000
        mmHeight = 2381
        mmLeft = 2117
        mmTop = 104246
        mmWidth = 192088
        BandType = 4
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 10583
        mmWidth = 10583
        BandType = 4
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'CPF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 10583
        mmWidth = 8202
        BandType = 4
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        Caption = 'Tipo de Documento: N'#186' da identidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 20902
        mmWidth = 60061
        BandType = 4
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'Endere'#231'o completo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 31221
        mmWidth = 31485
        BandType = 4
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = 'Cidade - UF - CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 41540
        mmWidth = 30692
        BandType = 4
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'Data de expedi'#231#227'o: - '#211'rg'#227'o expeditor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 20902
        mmWidth = 60325
        BandType = 4
      end
      object ppLabel11: TppLabel
        UserName = 'Label101'
        Caption = 'Bairro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 31221
        mmWidth = 10583
        BandType = 4
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        Caption = '(DDD) Telefone - Telefone Celular:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 41540
        mmWidth = 55298
        BandType = 4
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        Caption = 'Tipo - Marca - Modelo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 63765
        mmWidth = 35719
        BandType = 4
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        Caption = 'Gar. F'#225'brica:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 63765
        mmWidth = 20902
        BandType = 4
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        Caption = 'Cupom/Nota Fiscal N'#250'mero:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 74083
        mmWidth = 44979
        BandType = 4
      end
      object ppLabel16: TppLabel
        UserName = 'Label16'
        Caption = 'Pre'#231'o do Produto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 84402
        mmWidth = 28575
        BandType = 4
      end
      object ppLabel17: TppLabel
        UserName = 'Label102'
        Caption = 'Data de Emiss'#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 74083
        mmWidth = 28046
        BandType = 4
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        Caption = 'N'#250'mero de S'#233'rie:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 84402
        mmWidth = 27781
        BandType = 4
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        Caption = 'C'#243'digo - Descri'#231#227'o da Garantia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 106627
        mmWidth = 50536
        BandType = 4
      end
      object ppLabel21: TppLabel
        UserName = 'Label21'
        Caption = 'Data de Aquisi'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 106627
        mmWidth = 29633
        BandType = 4
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        Caption = 'Cobertura Extended:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 116946
        mmWidth = 32808
        BandType = 4
      end
      object ppLabel23: TppLabel
        UserName = 'Label23'
        Caption = 'Documento de Aquisi'#231#227'o - Tipo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 127265
        mmWidth = 50536
        BandType = 4
      end
      object ppLabel24: TppLabel
        UserName = 'Label24'
        Caption = 'Documento de Aquisi'#231#227'o - N'#250'mero:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 116946
        mmWidth = 56092
        BandType = 4
      end
      object ppLabel25: TppLabel
        UserName = 'Label25'
        Caption = 'T'#233'rmino da Vig'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 127265
        mmWidth = 33602
        BandType = 4
      end
      object ppLabel26: TppLabel
        UserName = 'Label26'
        Caption = 'In'#237'cio da Vig'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 137584
        mmWidth = 29104
        BandType = 4
      end
      object ppLabel27: TppLabel
        UserName = 'Label27'
        Caption = 'Valor Pago:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 147902
        mmWidth = 18521
        BandType = 4
      end
      object ppLabel28: TppLabel
        UserName = 'Label28'
        Caption = 'Forma de Pagamento / Plano:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 137584
        mmWidth = 47625
        BandType = 4
      end
      object ppLabel29: TppLabel
        UserName = 'Label29'
        Caption = 'Loja Revendedora:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 101865
        mmTop = 147902
        mmWidth = 29898
        BandType = 4
      end
      object ppLabel30: TppLabel
        UserName = 'Label30'
        Caption = 'Revendedor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 2117
        mmTop = 158221
        mmWidth = 20373
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        AutoSize = True
        DataField = 'Nome'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 15346
        mmWidth = 9821
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        AutoSize = True
        DataField = 'Endereco'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 35983
        mmWidth = 16171
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        AutoSize = True
        DataField = 'CidadeUFCEP'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 46302
        mmWidth = 23876
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        AutoSize = True
        DataField = 'CPF'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 15346
        mmWidth = 7112
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        AutoSize = True
        DataField = 'Bairro'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 35983
        mmWidth = 10414
        BandType = 4
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        AutoSize = True
        DataField = 'Telefone'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 46302
        mmWidth = 14732
        BandType = 4
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        AutoSize = True
        DataField = 'DescProduto'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 68527
        mmWidth = 22098
        BandType = 4
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        AutoSize = True
        DataField = 'NotaFiscalProduto'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 78846
        mmWidth = 21167
        BandType = 4
      end
      object ppDBText11: TppDBText
        UserName = 'DBText11'
        AutoSize = True
        DataField = 'ValorProduto'
        DataPipeline = ppGarantias
        DisplayFormat = 'R$ #,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 89165
        mmWidth = 22606
        BandType = 4
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
        DataField = 'GarantiaFabrica'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 68527
        mmWidth = 6615
        BandType = 4
      end
      object ppDBText13: TppDBText
        UserName = 'DBText13'
        AutoSize = True
        DataField = 'MovDate'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 78846
        mmWidth = 14732
        BandType = 4
      end
      object ppDBText15: TppDBText
        UserName = 'DBText15'
        AutoSize = True
        DataField = 'Description'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 111390
        mmWidth = 19558
        BandType = 4
      end
      object ppDBText16: TppDBText
        UserName = 'DBText16'
        DataField = 'GarantiaMeses'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 29633
        mmTop = 121709
        mmWidth = 6879
        BandType = 4
      end
      object ppDBText17: TppDBText
        UserName = 'DBText17'
        AutoSize = True
        DataField = 'SaleCode'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 14817
        mmTop = 132027
        mmWidth = 16171
        BandType = 4
      end
      object ppDBText18: TppDBText
        UserName = 'DBText18'
        AutoSize = True
        DataField = 'InicioVigencia'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 142346
        mmWidth = 24045
        BandType = 4
      end
      object ppDBText19: TppDBText
        UserName = 'DBText19'
        AutoSize = True
        DataField = 'SalePrice'
        DataPipeline = ppGarantias
        DisplayFormat = 'R$ #,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 152665
        mmWidth = 15917
        BandType = 4
      end
      object ppDBText21: TppDBText
        UserName = 'DBText21'
        AutoSize = True
        DataField = 'MovDate'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 111390
        mmWidth = 14732
        BandType = 4
      end
      object ppDBText22: TppDBText
        UserName = 'DBText22'
        AutoSize = True
        DataField = 'SequencyNum'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 115623
        mmTop = 121709
        mmWidth = 24638
        BandType = 4
      end
      object ppDBText23: TppDBText
        UserName = 'DBText23'
        AutoSize = True
        DataField = 'TerminoVigencia'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 132027
        mmWidth = 28787
        BandType = 4
      end
      object ppDBText24: TppDBText
        UserName = 'DBText24'
        AutoSize = True
        DataField = 'FormaPagamento'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 142346
        mmWidth = 29972
        BandType = 4
      end
      object ppDBText25: TppDBText
        UserName = 'DBText25'
        AutoSize = True
        DataField = 'Loja'
        DataPipeline = ppGarantias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppGarantias'
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 152665
        mmWidth = 7366
        BandType = 4
      end
      object ppLabel31: TppLabel
        UserName = 'Label31'
        Caption = 'Convencional + '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 121709
        mmWidth = 27517
        BandType = 4
      end
      object ppLabel32: TppLabel
        UserName = 'Label32'
        Caption = 'ND'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 25665
        mmWidth = 5080
        BandType = 4
      end
      object ppLabel33: TppLabel
        UserName = 'Label301'
        Caption = 'CELDOM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 162984
        mmWidth = 15409
        BandType = 4
      end
      object ppLabel34: TppLabel
        UserName = 'Label34'
        Caption = 'RAEC - '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 102129
        mmTop = 121709
        mmWidth = 13123
        BandType = 4
      end
      object ppLabel35: TppLabel
        UserName = 'Label35'
        Caption = 'ND'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 25665
        mmWidth = 5080
        BandType = 4
      end
      object ppLabel36: TppLabel
        UserName = 'Label36'
        Caption = 'NT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 101865
        mmTop = 89165
        mmWidth = 4826
        BandType = 4
      end
      object ppLabel38: TppLabel
        UserName = 'Label38'
        Caption = 'meses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 108744
        mmTop = 68527
        mmWidth = 10848
        BandType = 4
      end
      object ppLabel39: TppLabel
        UserName = 'Label39'
        Caption = 'meses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 36777
        mmTop = 121709
        mmWidth = 10848
        BandType = 4
      end
      object ppLabel40: TppLabel
        UserName = 'Label40'
        Caption = 'Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 2117
        mmTop = 132027
        mmWidth = 11906
        BandType = 4
      end
    end
    object ppFooterBand: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 79640
      mmPrintPosition = 0
      object ppImage1: TppImage
        UserName = 'Image1'
        MaintainAspectRatio = False
        Picture.Data = {
          07544269746D61700A810000424D0A8100000000000036000000280000007100
          0000610000000100180000000000D48000000000000000000000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF8FFFFF5FFFEF4FCFBFAFFFFFB
          FFFFFFFFFFFEFCFCFFFEFFFCF7F8FFFDFEFFFEFFFEFCFCFFFFFFF8FAFAFDFFFF
          F6F8F8FFFEFFFFFEFFFFFEFFFFFFFFFCFCFCFAFCFCF6FBFAFBFFFFFBFFFFF9FE
          FDFBFDFDFFFFFFFCFAFAFFFEFFFAF4F5FFFEFFFCFEFEF6FBFAFDFFFFFBFBFBFF
          FEFEFFFEFFFFFEFFFDF7F8FCF4F5FFFEFFFDF8F9FDFBFBFFFFFFFDFFFFFBFFFF
          FDFFFFFFFCFDFFFEFFF9FBFBFAFFFFF8FFFFF8FFFFFBFFFFFFFFFFFFF5F7FFFD
          FFFFFCFFFFFDFFFFFEFFFDFFFFF6FFFFF6FFFFFBFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFBFFFFF6FFFFEFFCFAF1FCFAFAFFFFFDFFFFFFFDFDFFFCFDFFFEFFFF
          FEFFFFFAFBFFFEFFFFFEFFFFFDFEF4EFF0FCFAFAFDF8F9FFFDFFFFF5F7FFF9FB
          FFFDFFFFFEFFFFFBFCFFFDFDFAFAFAFDFFFFFFFFFFFFFFFFFFFEFFFDF7F8FFFE
          FFFFF4F6FFFEFFFFFFFFFFFFFFFFFFFFFFFEFFFFFBFCFFFDFFFFFDFFFFF8FAF6
          E8EADDD0D2B5AAACACA4A5DAD5D6FAF8F8F2F2F2FFFAFBFFFDFFFFFDFFFFFEFF
          FFFFFFFBFFFFF3F8F7F8F6F6FFFEFFFFFCFFFFFBFFFFF9FDFFF8FBFFFBFDFDFD
          FDEFFAF8E8F5F3FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF6FFFFF5FF
          FEF8FFFFFBFFFFFBFBFBFFFCFDFFFDFFFFFAFCFFF4F7E0CFD2E6D5D8F4E6E8FF
          F6F8FFFDFFFFFDFFFFFDFFFFF1F5F3D8DCECD5D9F5E0E3FFF5F8FFFDFFFFFDFF
          E7E1E2E7E1E2FAF4F5FFFEFFFFFBFDFFF5F7FFFDFFF1E0E3FAECEEF5EAECFFFE
          FFFFF7F9FFF5F7F5E4E7F0DDE0FFEFF2FFFBFFFFFBFFBDA8AB746164655457A6
          999BFEF3F5FFFEFFFFFDFFFFFBFFFBE2E6ECDBDEE3D8DAFFFAFBFFFEFFFFFDFF
          FFFCFFFFECF0F7D7DCF3D1D7FFE4E8FFF8FBFFFEFFF8FFFFF6FFFFFBFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFDFFFFF4FCFBF8FFFFFBFFFFFFFFFFFFFCFDFFFD
          FFF8E5E8C7B0B49D82867E636784696D907579B69B9FFDE4E8FFE8ECE7C9CEB6
          8D94A57B829E787E98767CBD9FA4E3CACEF1DCDF917E81A29194DAC9CCFFEFF2
          FFF5F8FFF4F7FFEAEEB39A9E987F83B09B9EFBE8EBFFF8FBDDC6CAB69B9FAF8F
          94DBB9BFFFF3F9D7B3B97D5B61523237472C3060494DC4AFB2FFEEF1EAD1D5CD
          A7AD9C737A8C6E737F686CB8A7AAE7D9DBF3DEE1E2C4C9A37A81A5767EA97A82
          AE858CBDA4A8E9DCDEFCFEFEF0F6F5FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FDFFFFFBFFFFFAFFFEFFFFFFFFFDFEFFFCFEFFF9FCCCB3B76A4A4F6743498660
          669F797F714B51694349D2AEB4E4C0C6BD949B733E478C535CA26D7694656DB3
          8990E0BCC2ECCCD1593B40664B4FC1A8ACFFEBEFFFFBFFFFFAFFD3B3B877555B
          46242A684A4FD1B3B8FFFAFFC09EA4754F55774D54C4959DFFD3DB7A4B536F43
          4A8E646B977177704E54A7878CEDCFD4BA969C915E66834E57A379807351577D
          6266B99EA2F0D0D5EBC2C9915C65A66D76A1687178454D78545ACEBBBEFFFEFF
          FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFCFFFEFF
          FFFDFFFFF7FAFFF1F5D1AFB5724950855960AF8088C3929A6D3C443C0B13A97A
          82BB8C949360684F101A8E4A55BF808AA1656FA16C75C798A0E4BAC1451F2555
          3137BB999FFFE4EAFFF9FFFFF5FB9D747B693F4651282F643E44906A70FFF1F8
          C89CA36B3A426E3B43C68F98E9B0B9440B1488515ACD98A1EDBCC4B88C93BC93
          9AE4BEC48F636A6C2D37985661F6BFC8966A71502A30805C62E1B7BEEEBBC39C
          5D67A7636E9E5A657337416F434AC7ACB0FFFDFFFDFBFBFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFBFFFFFBFFFFFBFFFFFBFFFFFD
          FFFFFDFFFFFFFFFFFFFFFFFFFFFFFCF7F8FFFEFFFFFDFFFFF5F8FFFAFEFFDFE5
          CB9FA6CD9AA2C28B94B37A8369323B4C1720BA8B93B68A918251595A1823A05B
          66CE8C9791545E763F48A26F77E6B7BF5D333A592F36B98F96FBD1D8FFEBF2FF
          DCE370444B6F434A83545C895A62572B32FED4DBD7ABB2804D557C434CD0939D
          D397A1410A13A26F77DFACB4FFDEE6FCC9D1EBBCC4EFC6CD794D54692C36AB69
          74FFECF5B5848C4F252C7E545BE5B6BEE3AEB78B4F5984454F90535D9C656EAE
          848BEBD0D4FFFDFFFFFCFDFFFFFFFDFFFFFDFFFFFDFFFFFDFFFFFDFFFFFDFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFDFFFFFAFAFAFCFAFAFFFEFEFFFF
          FFFCFEFEF5FBFAF6FFFFF4FFFFF3FFFFF4FFFFF8FFFFFAFFFFFDFFFFFFFFFFFF
          FFFFFFFFFFF9F7F7FFFEFFFFFAFCFFF9FCFFE4EA9E72796E353E64252F672832
          763A44B8878FFFDBE1E2C7CBA7858B673039793A44AE757E602B34714048B98D
          94EBBFC654282F42111965323AA16E76D5A2AAD2A1A94A1B23A0747BD3A4ACAB
          747D521D26987278C29EA47E4D557C434CCC8D97FFE0E960373E553137795057
          81525A763D46AE7982DFB9BFC4A0A67241497B444D804D5561323A5D3138B78D
          94EBC1C8B68C93390D146C424991686F99757BBC9EA3F9E2E6FFFCFFFFFCFDFF
          FFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFFFFBFFFFFDFFFFFDFFFFFBFDFDFBFBFB
          FFFFFFFFFFFFFFFCFDFEF9FAFFFCFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFDFFFFFEFEFEFFFDFDFFFDFEFFFEFFFFFEFFFFFFFFFBFFFFF5FFFEF3FF
          FEF2FFFEF3FFFEF7FFFEFAFFFEFFFEFEFFFEFEFFFFFFFFFFFFF5F5F5FFFFFFFF
          FDFEFFF3F6D9BBC054282F612831965761BA78839D616BAB7C84F6D6DBFFF0F3
          E8D3D6C19BA1966A71AF868D9F7D83CAAAAFF0D2D7FFE7EC9D7D82A27C82A47B
          82B38990CAA0A7D9B0B7916D73DABABFFDD9DFF7C8D0A2767DBDA4A8C9B4B799
          777DB0848BF2BDC6FFF5FCD7C0C49E8D908B74788B696FA07179E7BBC2FFF4F8
          F3DEE1D2B2B7A68288977379A38187C09EA4FBDBE0FFF4F9ECD1D5A1888C9984
          878E7B7E978689C6B9BBFEF3F5FFFEFFF9F4F5FBFDFDF8FEFDF8FEFDF8FEFDF8
          FEFDF8FEFDF9FEFDF9FEFDF5FAF9F8FAFAFBFDFDFFFFFFFFFFFFFFFFFFFFFEFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF
          FFFCFDFFF8FAFFF7F9FFF8F9FEF9FAFDFFFFFBFFFFFAFFFFFBFFFFFFFFFFFFFE
          FFFFFEFFFFFEFFFFFCFDFFFFFFFDFDFDFFFFFFFFFEFFFFFCFFE4C6CB633A415C
          27308549539A5D67763F48835960DEBEC3FFF4F7FEF0F2FFF5F8D1C0C3DACDCF
          E8E2E3FCF7F8F9F7F7FFFEFFE1DBDCF0E5E7EBDDDFE7D6D9E5D7D9F4E7E9DED6
          D7FBF6F7FFFAFBFFEEF2DBC6C9DFDDDDBABABA807375978285D7BCC0FFF1F4F7
          F5F5D8DDDCD7D5D5DFD4D6EED7DBFFF5F8FFFFFFF5F7F7FFFBFCDDD0D2D0C3C5
          E3D8DAF5EAECFFF8F9FFFEFFFFFEFFEBE6E7D8D8D8CBCDCDD2D7D6E7EDECF7FF
          FEF8FFFFF6FEFDFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFFAFFFFFA
          FFFFFBFFFFFBFFFFFDFFFFFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFCFCFCFEFCFCFFFCFDFFFEFFFFFDFFFFFDFFFFFDFF
          FFFEFFFFFEFEFEFEFEFEFEFEFEFEFEFFFDFEFFFDFEFFFCFEFFFCFEF1F3F3FAFF
          FFF8FEFDFAFFFEFAFAFAFFFEFFFFF0F3BFA1A6A87F8692636B8D5E668D636AB3
          9398F3DEE1FFFDFFFFFEFFFFFDFEFCF6F7FFFEFEFDFFFFF2F8F7EAF2F1F2F8F7
          F7F9F9FCFAFAFFFDFEFFFEFFFFFEFFFFFEFFFFFFFFF5FAF9F7F7F7FFFDFFFFFD
          FFFBFFFFD3D9D8979293A49799DBC8CBFFFDFFF2F7F6EFFAF8FBFFFFFFFEFFFF
          F5F7FFF2F4F6FBFAFAFFFFFEFCFCFFFEFFFFFEFFFFFEFFFFFCFDF8F6F6F9F7F7
          FFFFFFF6F8F8F8FDFCFAFFFFFAFFFFF8FFFFEDF8F6EEF9F7F7FFFEF8FEFDF9FE
          FDF9FEFDF9FEFDF9FEFDF9FEFDF9FEFDF9FEFDFBFFFFFBFFFFFBFFFFF3F8F7F3
          F5F5F9FBFBFCFEFEFBFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA
          FFFFFAFFFEFCFCFCFFFBFCFFFDFEFFFCFEFFFAFCFEF8F9FFFEFFFFFFFFFFFFFF
          FFFFFFFFFEFFFFFEFFFFFDFFFFFEFFF3FFFEEDFFFFEDFFFFEFFFFFE9F7F5F2FA
          F9FFFFFFFAEFF1E4D1D4C6AFB3CDB6BADECBCEEFE2E4F9F7F7F0F6F5F6FBFAFF
          F8F9FFFDFFFFFEFFFFFAFBFAFAFAFFFFFFFFFFFFFFFDFEFFF9FAFFF7F9FFFDFF
          FFFDFFFFF7F9FFFEFFFBF9F9FFFEFFFFF5F8FFF5F8FFFAFBE7E2E3D6C8CAE0CB
          CEF5DCE0FFF8FBFFFEFFFFFFFFFFFAFBFFFDFFFFFCFFFFFAFDFFFAFBFFFEFFFF
          F6F8FFFDFFFFFDFFFFFAFCFFFDFFFFFDFFFFFAFCFFFAFCFFFDFFFFFEFFFFFDFE
          FFF9FAFFFAFBFFFEFFFFFEFFFFFCFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFDFFFFFDFFFFFCFEFEFDFFFFFDFFFFFCFEFEFDFFFFFDFFFFFDFFFFFDFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FFFFF6FFFFFBFFFFFFFFFFFF
          FEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFDFF
          FFFEFFFAFFFFEFFDFBF3FFFEF6FFFFF8FFFFFAFCFCFFFDFEFFFAFCFFFCFFFFF4
          F8FFFBFFFFFCFFFFFDFFFFFEFFFDFFFFFEFEFEFFF8FAFFFDFFFFFAFBFFFAFBFF
          FFFFFFFFFFFFFBFCFFFEFFFFFDFFFFF7F9FFF4F7FFF8FBFFFBFDFFFEFFFEF9FA
          FFFEFFFFFCFFFFFBFEFFFBFDFFFEFFFFFCFFFFFBFEFFF9FDFFFCFFFFFEFFFEF8
          F9FFFAFBFFFDFFFFFCFFFFFCFFFFFAFCFFF8F9FFFCFEFFF8FBFFF0F3FFF3F5FF
          FBFDFFF9FBFFF8FAFFFDFFFFFCFEFFFDFFFFFAFCFFF3F5FFF7F9FFFDFFFFFDFF
          FFF9FBFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFBFCFFFB
          FCFFFEFFFFFFFFFFFFFFFFFDFDFCFAFAFDFBFBFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFEBF9F7F0FFFEF6FFFFFDFFFFFEF9FAFDF5F6FFF8F9FFFDFEFF
          FEFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFDFFFFFDFFFFFDFFFFF7F9FFFBFE
          FFFCFFFFFCFFFFFBFFFFF8FDFFF4FAFFF8FFFFF3FAFFF8FFFFF1F7FFECF2FFFA
          FFFFFBFFFFF8FBFFF9FBFFFEFFFFFEFFFFFFFFFDFFFFF1F3F3F8F6F6FFFEFFFF
          FDFFFFFDFFFFFBFDFFFDFFFFFDFFFFFDFEFEFEFEF9F7F7FFFBFDFFFDFFFFFEFF
          FFFEFFFFFDFFFFF9FBFFFDFFFFF9FBFFFEFFFFFBFCFFFCFDFFFBFCFEF1F3FFF4
          F6FFFEFFFFFEFFFFFDFFFFFDFFFFFDFFFFFDFFFFFAFCFFF8F9FFFEFFFFFEFFFD
          F5F6FFFEFFFFFEFFFFFDFFFFFDFFFFFBFDFFFCFEFFFCFEFFFBFEFFFBFEFFFBFE
          FFFBFEFFFBFEFFFBFEFFFBFEFFFBFEFFFCFFFFF8FBFFFDFFFFFDFFFFFBFDFDF2
          F4FFFCFDFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FFFFF6FF
          FFFAFCFCE5DFE0C4B7B9AB989BA38E91A48F92A49194A29194A09294A09294A2
          9194A49194A79094AB9094AC8E93B08E94B49298AD898FAF898FBB9198B98D94
          BB8C94BF8E96B4838BC3929ABE8F97B4888FB88E95B68D94B59399A68F939F8E
          91A39698978C8EA29A9B9D9294A295979D8C8FA68F93AC9397AB9094A48B8FAA
          9598978689A69B9D9C9193A29194A291949C8E909D8F919E8D90A79497AF9C9F
          9D8C8FA597999A8C8EA19395A9989BA08F92A49396A49698968588998689A28D
          90A69396A08D909B8A8DA8979AA9989B978689A8979AA29194A28F92A69194A7
          9094A58C90A68D91AC9195AE8E93AF8D93AF8D93AF8D93AF8D93AF8D93B18D93
          AF8D93B39197AB8B90AB8D92AE9397A68D91A28B8FC1ACAFE5D7D9FFFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBFFFEFFFFFCFFF5DCE0BB979D9268
          6F8B5F669061698D61688D646B8E686E8C666C8A646A8C626990646B92666D8B
          6269906A708B62698C626990646B93676E996A728F60688F636A8F636A8F636A
          8B6168895F668A606790646B91676E8C636A8F696F8D696F8563698563698A68
          6E8F696F8D636A95646C925D669A636C9D687191626A8C62698D696F89696E8C
          6A708662688B656B8A646A8C666C8C686E89656B906C72886268906A708A646A
          8C686E8F6B7185616789636991686F8F656C90666D90676E8F666D8E686E8E68
          6E8A666C8662688A646A8E686E8F666D865C6391626A99687091606899666E93
          6068925F679E697296616A8F5A639B666F9D666F935E6798636C9C6971905F67
          95666E996F7681585F9E787EF1D6DAFFF5F7FAFAFAFEFEFEFFFFFFFFFFFFFEFE
          FEFEFEFEFEFEFEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFAFBFFF9FBFFE8ECDEBCC2C299A0C3949CC798A0C69AA1C096
          9DBA949AB8949ABB959BBC969CBF959CBE959CB08E94B49499B6949ABC989EBB
          979DB79399BA969CB5959AB4969BB59A9EB69B9FB99EA2BFA1A6BD9DA2B8949A
          B38F95BB959BB79399B59399B8969CB7979CB39197B69096C1959CCA979FC992
          9BC9929BC6919AC19098C0969DBD999FB29297B99BA0B5959ABB959BBD979DBC
          989EB9999EB3959AB8989DB99399C299A0B99399B39197B7979CBA9A9FBF999F
          BB9299B98F96BA9097B88F96B48E94B48E94B59197B8969CBB999FB79399BE9A
          A0C29CA2BF959CC4989FC5969EBF8E96C4959DC79EA5B69096BC939AC299A0C2
          989FC4989FC0949BBE9299BA9097BE959CB89298B69298B49298AB8D92C5AAAE
          FAE5E8FEF8F9FCFCFCFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFE5FAF7F2FDFB
          FFFFFFFFF9FBFFEFF2FFF2F6FFF7FBFFFAFDFFF9FCFFF8FAFFF7F9FFF7F9FFF7
          F9FFF9FBFFFBFDFFFDFFFFF7F9FFF2F5FFF3F6FFF6F9FFF8FBFFFCFEFFFEFFFD
          FBFBF7F9F9ECEEEEEAEAEAF8F3F4FEF6F7FFF5F7FFF9FBFFFBFDFFF6F8FAF2F3
          FDF7F8FFFBFCFCF1F3FFF2F4FFFCFFFFF8FCFFF6FBFFF5FAFFF7FBFFFAFEFFFC
          FFFFF8FAF5EFF0FFFDFDFFFDFEFFFDFFFFFCFFFFFAFCF8F3F4F6F4F4FCF7F8FF
          F8FAFFFAFDFFF8FAF9EEF0F5F0F1FFFAFBFFFAFCFFF2F5FFFCFFFFFCFFFFFCFF
          FFFDFFFFF9FBFFF4F6FAF2F3F9F1F2F3EBECFFF4F6FFF5F7FFF8FBFFFCFFFFF8
          FBFFF3F7FFFCFFFFFFFFF3F8F7F1F3F3F9F9F9FCFAFAFCF7F8FFFAFBFFFEFFFF
          FEFFFFFFFFFFFFFFFBFFFFEEF4F3EDF5F4F4FFFDF8FFFFFBFDFDFEFEFEFFFFFF
          FFFFFFFEFEFEFDFDFDFEFEFEFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFF1FFFFE9FCF9F6FEFDFFFEFFFFFAFCFFFBFFFFFBFF
          FFFAFFFFF9FDFFFBFFFFFCFFFFFDFFFFFDFFFFFDFFFFFDFFFFFAFCFFFDFFFFFA
          FCFFFCFFFFF9FCFFF9FCFFFCFFFEF3F5FAF5F6F9FEFDF8FFFFF8FFFFF7FDFCFF
          FFFFFFFEFFFFFAFCFFFDFFFAF4F5FFFFFFFFFFFFFDFDFDFFFFFFFFFBFCFDF2F4
          FFF8FBFFFBFFFFFAFEFFFAFEFFFBFFFFFCFFFFFCFEFFFCFDFFFFFFFCFEFEFFFD
          FDFFF2F4FFF6F9FFF9FAF7F7F7FBFFFFFFFFFFFFFDFFFFFBFEFFFDFFFFFEFFFF
          FFFFFFFFFFFFFAFCFFFAFDFFF8FBFFF6F9FFF8FBFFFDFFFFFDFFFFFEFFFFFCFD
          FFFAFBFFFEFFFFFEFFFFF9FAFFFBFDFFFDFFFFFBFEFFFCFFFFFDFFF7F9F9F6FF
          FFFAFFFFFBFFFFFDFFFFFFFFFFFFFFFFFFFEFFFFFEFFF6F4F4FCFCFCFBFFFFF8
          FEFDF6FFFFF6FFFFE4EFEDFDFFFFFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FBFCFFFDFFFFF4F8F3CDD3D09FA7C99099CE8F99C58690C58892C18891BA878F
          BF8E96D2A6ADE0B4BBCFA3AAAF858CC19BA1E6C0C6FFF8FFFFF8FFFFE1E8E5BF
          C5B3959AA48F92B5A8AADFD9DAFDF7F8FFFEFFFFF6F9E1C8CCBC989EB49298BF
          AAADF6E8EAFFFDFFFFF6F8FFFAFCFDEAEDD3BABEB6989DBA949AB58C93AF858C
          B08A90AB8B909A8185AD9A9DDED0D2F4E7E9D5C2C5B69298CDA7ADF1D6DAFFF3
          F6FFFDFFFFF2F5C7A3A9B58B92B8949AD4B9BDF7E6E9EAD7DABA989EBB9198BF
          969DB58F95B38D93B9979DCBADB2E4C9CDFFE8ECFFFBFFFFF8FCFDE6EAC6ADB1
          B3959AB59399AE8A90B38D93A8848AA58A8EA68F93B1969AEACCD1FFDFE5D3AF
          B5BB9299B58C93C399A0B1888FB48E94C8A4AADDBDC2FADFE3FFFBFFFFFCFFFF
          FEFFFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFEFFFBFFFFECF2CFA0A880
          475062202B6D2531752D39742F3A6B29345E222C6E3740A5727ACC9BA3AB7A82
          6C3B435320289A656EFFD9E2FFEEF7E9B2BB96636B4E242B513136A38E91DED0
          D2FFFDFFFFFCFFFFF4F8C5A1A7774850592D34715156D7C0C4FFFAFDFFF3F6FF
          F3F7EBD0D49270764B22295F303867343C612E365D2C34552B324B272D75575C
          C3AAAEE4CDD19D7B81532028814A53DBB1B8FFEDF2FFF2F6DCBCC17B464F6226
          30653039A37980FADCE1E2C2C77B4850682C366229325E27305A252E58272F60
          313982585FC29CA2FAD6DCFFF9FFFCD6DC986F7660363D57283059262E6B363F
          5B28305E343B532A31663C43DDAEB6FFD7DFAB747D6D343D672B35642731672A
          345F232D612A337D4A52A7767EE8B9C1FFF9FFFFFBFDFEFEFEFFFFFFFFFFFFFE
          FEFEFDFDFDFEFEFEFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFEFFFBEAEDB99BA0592F3632000759202989505985
          505985545C764C537B575DB49499E3C5CABC9EA3734F553D0C14682F38D498A2
          F4B7C1B87C86662F383E121976545ACBB6B9F6E8EAFFFCFEFFFCFFFFECF0BC96
          9C622F373C0B135F3B41D9BEC2FFFBFFFFFBFFFFFAFFF2D2D7855F652F030A41
          0E166F3841874E5787525B83545C79505797757BD9BBC0F0D0D5966C733D0008
          76343FE3AEB7FFE3EAEFCDD39D737A53141E4C04104E0F198F5A63FFDAE1E8BE
          C562252F500814601B267E3A459556608448525920294D1821815058BF9098FF
          F7FEFECFD784535B400B143E07105F232D9356608B525B81555C795359855B62
          ECC0C7FFD5DD935C655216204C0F19652630985B658A4E585E252E5520295D2A
          329F6E76FFE4EAFFF7F9FCFCFCFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFFFFFAFA
          FAF3E6E8BDA2A65F353C3A050E794049C9929BEBBAC2F4CBD2E5C5CACEB7BBEC
          D7DAFFFCFFE8D5D8A4868B602D354C0D17874550A4626D7D404A4B141D522930
          BDA2A6EFE1E3FFFEFFFFFEFFFFF8FAFFF1F5CBA2A972394248111A653F45DBBD
          C2FFFBFFFFF3F7FFF6FAEDCDD28960673C0D15592029AF727CE8ABB5F6BDC6F2
          C3CBDFB9BFDFC4C8FFEDF1ECC8CEA06D754C020E883946E4A7B1F4C3CBBC939A
          58272F540A1664121F661E2A945862FFD9E0EDBEC66A25306516237B313DBB79
          84F2BBC4DDAAB2875059440D16551C25855059FFF2F9FCD2D986555D4B121B61
          1F2AA25E69F3B4BEF7C0C9E3B9C0F2CED4E3C1C7FFE6ECFFD0D89059625F222C
          581B258F565FF3BAC3EBB2BB9C606A6C303A460D166F3C44E4C0C6FFF5F7FAFA
          FAFEFEFEFFFFFFFFFFFFFEFEFEFEFEFEFEFEFEFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFFFDFEFFEAEEC79DA4682B354700
          0B934753E9A4AFFFD9E2FFDEE5FFE4E8F0DFE2FFFDFFFFFDFFFFF1F3F0D2D7AA
          717A5109155F17235C172253141E400D159F7F84EEE0E2FDFFFFE7F2F0F5FDFC
          FFFFFFFFF9FDB78D9476374154151F653B42E1C3C8FFF4F8FFF8FBFFFCFFE3CA
          CE89656B31020A5F222CC2808BFFC5D0FFE2EBFFDFE6F2D9DDFAEFF1FFFCFEEA
          CACF9F666F4E00049C4150DE99A4D19EA657313744131B6C1A276D101F5C0C19
          9D606AFDD4DBDBAFB67C323E5C0A177C3742CF9CA4FFFBFFFFF3F6BA91986833
          3C4F101A69323BF3D5DAECD5D9835D634D161F6B1C29B36471FFD8E1FFE6EDFF
          DCE3FFE2E8FBE4E8FFFBFFF5CCD396616A5B1C265A1D279F6E76FFF8FFFFF1F9
          F9BDC79D55614E091446111AC8A6ACF1E6E8F9F9F9FFFFFFFFFFFFFCFCFCFFFF
          FFFFFFFFFDFDFDFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFCFEFEFFFDFEFEE3E7C5949C78333E5907146D1B28823642672B354E24
          2B462B2F5C4B4EBBAEB0F6E9EBFFFDFFFFF4F9FEBFC988384560101D49000966
          212C854E57E1BDC3FFFCFFFEFEFEF4FCFBF6FCFBFBF5F6FFEFF3C491997D3541
          520A16693840E4C2C8FFFBFFFFFBFFFFFCFFE5CCD08E686E39060E56141F732B
          3771293565283251272E523B3F918C8DDBD3D4EFCFD4A86B755E01108E2C3C91
          495578454D3F191F6B3A429C4755801E2E651320A3646EFFDCE2E4BAC17A303C
          5F0A18863C48CF9CA4FFFCFFFFF6F8BF999F7337415107135E1F29E8CACFE2CD
          D0855F655417215C041269111F773E47471D244D232A59353B7A676AE5D2D5EF
          C9CF9D687163242E682B359A6E75FFF8FFFFF1F9FCBFC9AB5F6B570D19430C15
          B7959BF3E8EAFAFAFAFFFFFFFFFFFFFCFCFCFFFFFFFFFFFFFDFDFDFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFEFFFFEAEE
          C6959D722D3853031072202D904450B1757F996D74886A6F8C797CDAC9CCFFF6
          F9FFFCFFFFE1E7EFAAB5872F3D630B1951000862121F7A3540D6A1AAFFF2F8FF
          F9FCFFFDFFFFFDFFFFF8FCFFF8FFDE9FA98B36445D0B18723942E9BFC6FFF9FF
          FFFAFFFFF5FAEAC8CE94686F430A13621D288C404CA15561AD69749C6B738E6E
          73B6A9ABEEE0E2F0CED49F636D5D02117619285A15204F1C245F393FBA8B93C5
          73808225346515229C5F69FDD7DDE5BCC371293567101E8E3947DB99A4FFF9FF
          FFF1F6CA959E813945660F1D792D39F7CBD2EAC6CC905D65641C287A17279A37
          47B7737E99666E94656D977177AE979BFFF3F7FFD6DD9A636C52101B4F121C9D
          7178FFF8FFFFF2FAF6BAC4A95F6B570F1B4B161FC09EA4F7ECEEFBFBFBFFFFFF
          FFFFFFFDFDFDFFFFFFFFFFFFFEFEFEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFDFEFFECF0CD9EA66F2D384E020E91424F
          DE96A2E2A6B0E3B7BEDCBCC1C9B2B6FAE7EAFFFCFFFFEEF2E2B9C09C5762630C
          1A802836973F4D7C27354E020E975A64FFD2DAFFE7ECFFECF0EED7DBE4C2C8FF
          CDD5B9747F731C2A5E09176D303AC6979FF3CAD1F2CCD2FCD8DEEAC1C895646C
          41040E611723B56572ED9EABFFBCC7F1BAC3DCB6BCEBD6D9FFEFF2EECCD29760
          695E09176A13214E0C1762333BA38187FFDDE4D3879378212F5F1521975E67F6
          D4DAE5BFC56D29346A1825862F3DCC8490FFD7DEE2BCC29C606A6519256A1220
          994956FFF3FBFFD8DF965F68580E1A6D0A1AA54252E5A0ABEEB9C2DBAAB2DAB1
          B8DAC1C5FFF8FCF1C7CE935C65561721591D278E5F67FFD6DDF7C6CEC188917C
          384343010C5E2B33DABABFFBF0F2FCFCFCFFFFFFFFFFFFFEFEFEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF8F9FAE1E5C2989F6B2F3946010C732B37AD6974C8919ACCA0A7BA9A9F
          A1888CDDC6CAFFEBEFE4C9CD9D777D5316204F0511A85966DF8F9CAC5D6A4B01
          0D60212BBB8890FFE1E7FFE1E6C5A7AC825E6495626A79374263132066172460
          232D804F5792666DA37980DDB4BBF3C7CE9F6A7341020C5E1420A25360CA7B88
          D18995BA818AAA8087CFB4B8F9E2E6EECED394636B540A165203104A111A855B
          62D7B9BEFFF9FFC6828D671825510F1A915E66F4D6DBE5C5CA65293355091575
          25329A5560A87E85815B61592029530B17812F3CC67C88FFEEF5EFCBD18F5C64
          58141F6B132199414FC78892CD9CA4C4959DBC939AC1A3A8FFEBF0F1C7CE8E59
          62490D174B121B653940AB828996676F6E394255182253172191656CFFE5E9FF
          F5F7FDFDFDFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFFEFFFAE7EAB4929864
          31394307114F121C5A1E285C2B33542B3244262B482F33AC9599E4CDD1BFA6AA
          6A484E34080F69343DDFA3ADFFCED8CD8E98662933420D1664383FC9A7ADD0B5
          B98F767A2C0E13340B123F0C144A0B15470812410C1532030B2D030A4A2128A2
          7C82D5ABB28F5C643800064905106119256A222E74323D5F2A334B222981666A
          C8B1B5ECD3D78A646A42050F46040F704149C4A4A9FFE8ECFFFAFFB57C856523
          2E511A238C636AE5D0D3D8BFC365343C450610490510480C1638161C24060B36
          070F652C35A8646FE7AEB7FFFAFFE3CACE805C6247141C4C071256121D53242C
          411D23492027401C22614348DEC0C5F0C7CE93646C46111A43101831080F4521
          2731080F30040B4C1921794850C49EA4FFECF0FFFBFCFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFBFFFFFFFFFFFFF7F9D5BEC2A27C8292636B9B6A729A6B7390
          676E85656A7D6468826D70C7B4B7DECBCEC0ABAE846D71846F72B9A2A6FFEFF4
          FFF9FFF2CCD2B892988C6A708A6F73C9B6B9D6C8CABBAEB07B6D6F8570738C71
          75977379936A71A37D838D696F89676D95757ACFAFB4FAD8DED0A7AEA3747CA3
          6C75A1656F90576097626B8C62697B5B60A89195E2D1D4F6E5E8B49B9F8E5F67
          9B6A72C9A7ADFDE8EBFFFDFFFFFAFDD6ACB3AE7D859B7279BA9FA3EDE0E2DFD1
          D3A48086996A729D6E768C686E7B6D6F796E70A0898DD2B0B6F8CFD6FFFAFFFF
          FDFFE8E3E4A89B9D856C708E656C936A7186717479686B83686C88686D957C80
          F1D6DAFFDFE5C9A3A991686F8C636A9573798D6F7488686D9C7A80B8949ADFBD
          C3FFF6FAFFFCFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFF0F6
          F5FEF9FAFFFDFFFFF6FAFFEEF3FFF1F7FFF3F9FFEFF4FFF4F8FFFAFDFCEEF0FF
          FDFFFFF2F4FFF1F4FCEFF1FBF9F9F7F7F7FFFEFFFFFDFFFFFBFEFFFCFFFFEEF1
          FDEFF1FCF4F5F8F3F4FBF9F9F3F1F1FFFEFFF7ECEEFFF1F3FFFAFDFFF7FBFFF2
          F6FFFCFFFFEEF1FFF2F5FFFBFFFFF1F5FFEAF0FFEDF4FFF5FCFFEBF2FFF5FBFF
          F8FDFFEBEEFFF4F6FFFEFFFFFEFFFFF8FAFFF7FCFFF9FFFFFCFFFFF6F8FFFBFC
          FFFEFFFFFBFFFFF2F7FFEAEEFFF5F8FFFFFFFFFDFEFFECEFFFFAFFFFF2F7FFF1
          F4FCFAFAF5F7F7FFFEFFFFFDFFFFF2F5FFFDFFF2F7F6F6FFFFF4F9F8F8F2F3FF
          F5F8FFF5F8F9F7F7F8F6F6FEEDF0FFFBFFFFEDF0FFFCFFFFF7FBFFF6FAFFF1F5
          FFF5F9FFF7FBFFECF0FFF2F6FFFCFFFFF7FAFFF9FCFFFCFFFDF2F4FFFEFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FFFFF6FFFFFBFFFFFFFFFFFFFDFFFFFC
          FFFFFCFFFFFCFFFFFBFEFFFCFEFFFCFEFFFDFEFFFDFEFFFDFEFFFDFEFFFEFEF5
          FFFEF2FFFEF5FFFEFAFFFEFFFEFEFFFDFEFFFDFEFFFDFEFFFFFFFFFFFFFDFFFF
          FBFFFFFDFFFFFFFFFFFFFFFFFFFEFFFFFDFEFFFDFEFFFDFEFFFDFEFFFDFEFFFD
          FEFFFCFEFFFBFEFFFCFFFFFCFFFFFCFFFFFBFEFFFCFEFFFDFEFFFFFFFDFFFFFC
          FEFEFFFEFEFFFCFEFFFBFEFFFDFEFEFEFEF9FFFEFCFEFEFFFDFFFFFCFFFFFDFF
          FFFEFFFAFFFFFBFFFFFFFEFFFFFDFFFFFBFEFFFCFEFAFFFEF7FFFEFCFEFEFFFE
          FEFFFDFEFEFEFEF2FFFEEEFFFEF2FFFEF9FFFEFFFDFEFFFEFEF7FFFEF7FFFEFF
          FDFEFFFCFEFFFCFEFFFCFEFFFCFEFFFCFEFFFCFEFFFCFEFFFBFEFFFBFEFFFCFE
          FFFCFEFFFDFEFFFDFEFFFDFEFFFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFF4FFFFF3FFFFF6FFFFFBFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFDFEFFFD
          FEFFFDFEFFFEFEFFFEFEFFFEFEFFFDFEFCFEFEF2FFFEEEFFFEF2FFFEF7FFFEFA
          FFFEFEFEFEFFFEFEFFFDFEFFFFFFFFFFFFFFFFFFFDFFFFFDFFFFFBFFFFFBFFFF
          FBFFFFFCFEFEFCFEFEFAFFFEFAFFFEFAFFFEFCFEFEFEFEFEFFFEFEFFFCFDFFFC
          FDFFFCFDFFFDFDFEFEFEFAFFFEFAFFFFF8FFFFF5FFFEF9FFFEFFFEFEFFFDFEFC
          FEFEF7FFFEF5FFFEF7FFFEFFFFFFFFFEFFFFFFFFFBFFFFF4FFFFF6FFFFFDFFFF
          FFFEFFFFFCFEFFFDFEFAFFFEF9FFFEFCFEFEFEFEFEFEFEFEFAFFFEF2FFFEF0FF
          FEF2FFFEF7FFFEFCFEFEFCFEFEF5FFFEF5FFFEFAFFFEFFFEFEFFFDFEFFFCFEFF
          FDFEFFFDFEFFFEFEFFFDFEFFFCFEFFFCFEFFFDFEFEFEFEF9FFFEF9FFFEFCFEFE
          FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6FFFFF4FFFFF4FFFF
          F6FFFFFAFFFFFBFFFFFDFFFFFDFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
          FEFCFEFEFAFFFEF7FFFEF5FFFEF9FFFEFAFFFEFEFEFEFFFDFEFFFDFEFFFDFEFF
          FDFFFFFDFFFFFEFFFFFEFFFFFEFFFFFFFFFFFFFFFDFFFFF7FFFEF3FFFEF5FFFE
          F5FFFEF5FFFEF5FFFEF7FFFEF7FFFEF6FEFDF6FEFDF8FFFFF8FFFFF6FFFFF6FF
          FFF4FFFFF4FFFFF3FFFEF5FFFEF9FFFEFAFFFEF7FFFEF5FFFEF3FFFEF3FFFEFA
          FFFFFBFFFFFAFFFFF6FFFFF3FFFFF3FFFFF8FFFFFFFFFFFFFCFEFFFCFEFFFDFE
          FFFDFEFFFDFEFFFDFEFFFDFEFFFEFEFAFFFEF9FFFEFAFFFEFCFEFEFFFEFEFFFE
          FEFCFEFEFAFFFEF7FFFEFAFFFEFFFDFEFFFDFEFEFEFEFAFFFEF9FFFEFCFEFEFF
          FDFEFFFDFEFFFEFEFAFFFEF2FFFEF2FFFEF9FFFEFCFEFEFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFAFFFFF8FFFFF6FFFFF6FFFFF6FFFFF6FFFFF8FFFF
          FAFFFFFBFFFFFDFFFFFDFFFFFDFFFFFFFFFFFDFFFFFDFFFFFBFFFFFBFFFFFDFF
          FFFDFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFDFFFFFDFFFFFDFFFFFDFFFFFDFFFF
          FEFFFFFEFFFFFEFFFDFFFFF5FFFEF2FFFEF3FFFEF3FFFEF3FFFEF3FFFEF3FFFE
          F3FFFEF1FFFDF2FFFEF3FFFFF3FFFFF3FFFFF4FFFFF3FFFEF3FFFEF3FFFEF5FF
          FEF7FFFEF7FFFEF5FFFEF5FFFEF3FFFEF5FFFEF8FFFFF8FFFFF8FFFFF6FFFFF4
          FFFFF4FFFFF6FFFFFDFFFFFFFDFFFFFCFFFFFDFFFFFDFFFFFEFFFFFEFFFFFEFF
          FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFFFFF6FFFFF6FF
          FFFFFEFFFFFEFFFDFFFFF8FFFFF4FFFFFAFFFFFFFEFFFFFEFFFFFFFFFAFFFFEF
          FFFFEFFFFFFAFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD
          FFFFFDFFFFFBFFFFF8FFFFF8FFFFF6FFFFF6FFFFF8FFFFFBFFFFFDFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFDFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFFFFFEFFFFFDFFFFFDFFFFFDFFFFFDFFFFFDFFFFFEFFFFFEFFFFFFFFF7
          FFFEF3FFFEF5FFFEF7FFFEF9FFFEF7FFFEF7FFFEF5FFFEF4FFFFF3FFFFF3FFFF
          F3FFFFF3FFFEF4FFFDF7FDFCF7FDFCF9FFFEF9FFFEF7FFFEF7FFFEF7FFFEF7FF
          FEF9FFFEF9FFFEF8FFFFF8FFFFF8FFFFFAFFFFFAFFFFFAFFFFF8FFFFFDFFFFFF
          FDFFFFFDFFFFFDFFFFFDFFFFFDFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFF
          FFFEFFFFFEFFFFFEFFFFFDFFFFFEFFF4FFFFF6FFFFFFFEFFFFFEFFFDFFFFF8FF
          FFF4FFFFF8FFFFFFFEFFFFFDFFFFFEFFFAFFFFEFFFFFF1FFFFFBFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFBFFFFFBFFFFFDFFFFFFFFFFFFFEFFFFFE
          FFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFDFFFFF9FFFEF7FFFEFAFFFEFCFEFEFE
          FEFEFCFEFEFAFFFEF9FFFEF6FFFFF4FFFFF4FFFFF6FFFFF8FFFFFBFFFFFFFFFF
          FFFFFFFEFEFEFCFEFEF9FFFEF9FFFEFAFFFEFCFEFEFCFEFEFCFEFEFBFFFFFAFF
          FFFBFFFFFDFFFFFFFFFFFFFFFFFBFFFFFDFFFFFFFEFFFFFDFFFFFDFFFFFDFFFF
          FEFFFFFEFFFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFFFFFFEFFFFFEFF
          FFFEFFF4FFFFF6FFFFFFFEFFFFFDFFFFFFFFF8FFFFF4FFFFFAFFFFFFFDFFFFFC
          FFFFFEFFFDFFFFF1FFFFF1FFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFDFFFFFBFFFFF8FFFF
          F4FFFFF3FFFFF1FFFFF3FFFFF6FFFFFAFFFFFBFFFFFFFFFFFFFFFFFDFFFFFAFF
          FFF8FFFFF8FFFFFAFFFEFEFEFEFFFDFEFFFDFEFFFDFEFFFDFEFFFEFEFEFEFEFA
          FFFEF8FEFDF6FCFBF7FCFBFAFCFCFFFEFEFFFEFFFFFEFFFFFDFEFFFEFEFCFEFE
          FCFEFEFFFEFEFFFDFEFFFDFEFFFDFEFFFFFFFDFFFFFFFFFFFFFFFFFFFEFFFFFE
          FFFFFFFFFDFFFFFDFFFFFFFFFFFFFEFFFFFFFFFDFFFFFAFFFFF6FFFFF8FFFFFB
          FFFFFDFFFFFDFFFFFBFFFFFAFFFFFBFFFFFFFFFFFFFFFFF4FFFFF8FFFFFFFDFF
          FFFDFFFFFFFFFAFFFFF4FFFFFBFFFFFFFCFFFFFBFFFFFDFFFFFFFFF3FFFFF4FF
          FFFFFEFFFFFDFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFFFFFFFFFDFFFFFAFFFFF8FFFEF4FFFCF3FFFCF1FFFEF3FFFF
          F4FFFFF8FFFFFAFFFEFBFFFBFBFFF9FAFFFBF8FFFEF4FFFFF6FFFFFCFEFFFFFD
          FEFFFDFEFFFCFEFFFCFEFFFCFEFFFCFEFFFCFEF9ECEEF6EBEDF6E9EBF7E9EBFD
          E9EEFFEFF2FFF2F8FFF6FBFFFBFFFFFCFFFFFDFFFFFDFFFFFDFEFFFDFEFFFDFE
          FFFEFDFFFFFEFDFFFEFFFFFFFFFFFFFFFEFFFFFEFFFFFEFFFDFFFFFDFFFFFDFF
          FFFFFFFFFFFFFFFAFFFFF8FFFFF6FFFFF8FFFFFBFFFFFDFFFEFDFFFEFBFFFFFA
          FFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF
          FDFFFDFFFFFDFFF9FBFFF7FBFFF7FBFFFBFBFEFFFDFCFFFDFEFFFDFFFCFBFFF0
          FAFFEFF9FFF1F7FFF8F6FBFFF7FAFFFDFEFFFFFDFDFFF8F9FFF7F9FFF3F8FFE9
          EFF9DAE1F3CED6E6BDC5DDB2BBD6A9B2D6A4AEDAA5B2E5B0BAF7C1CEFFD1DDFF
          E2EFFFEDF9FFF5FDFFF6FCFFFCFFFFFEFFFFFFFEF5F6F2FAFFFBFAFFFBFAFFFD
          FAFFFEFBFDFEFCFDFFFDFDFFFDFEFFFFFFFFFFFFFEFFFFFFFFFEFFFDFEFFFBFE
          FFFDFFFFFFFFFFFFFFFEFFFFFCFFFFFCFFFFFEFDFFFFF8FEFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFFFFFEFFFFFFF8FFFFF4FF
          FFF5FFFFFBFFFCFFFFFBFFFFFCFFF8FCF7F6FFE9FBFFE9FBFFEEFBFFF8F8F8FF
          F9F5FFF8F1F8FFFDFFFFFCFFFFEEF2EFCED5D5AEB6B3818B9159646E303C6D2B
          376A25346C2535732A3A813848985161A56676AF8292D5B4C2FFE9F4FFFAFFFF
          FBFEFFF7F7FFFFFCFFFFFBFBFFF9F8FFF8F8FEF9F9FEFCFAFFFEFAFEFFFAFBFF
          FBFAFCFFFFFEFFFFFEFFFFFFFDFFFFFDFEFFFDFEFFFFFEFFFFFEFFFFFFFCFFFF
          FBFFFFFBFFFFFCFFFFFFFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFFFFFDFFFFFEFFFFFFF8FFFFF5FFFFF8FDFFFEFDFCFFFDFAFFFD
          FCFFFCFFFDFBFFF0FEFFEDFFFFF1FFFFF8FFFAFFFFF8FFFFFAFFFCE1E5C2A0A7
          885D6666323C571D28520D1A4B000E631422641322661224620E205604164D00
          0E4F0112510A1A4C101B511E2672434BA98186E0C0C1FFEAE8FFFBF5FFFFF8FF
          FFF9FFFFF9FFFFF9FFFFF9FFFFFBFFFFFBFFFFFCFFFFFCFFFFFCFFFFFEFDFFFF
          FBFFFFFBFEFFFBFEFFFDFFFFFFFFFFFFFFFEFFFFFCFFFFFBFFFFFCFFFFFEFBFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFFFFFE
          FFFFFFF9FFFFF8FDFFF9FBFFFFFBFBFFFBFAFFF7F8FFFDFFFFFFFFF5FCFFECFE
          FFEDFFFFF9FFFAFFFFECFEF6D0DCB3848C6F3A445A1C285A14215A0B19650D1D
          761A2B6101126505166D0C207115286D1427641022621022641725631B285611
          1E531620662F3883575EA9868AD2BABCF3E1E0FFF7F4FFFAF7FFFEFAFFFEF9FE
          FBF6FEFAF5FFFCF7FFFFFBFEFFFBFCFFFDFAFFFEF9FEFFF9FEFFF9FEFFF9FEFF
          FAFFFEFCFFFDFFFFFCFFFFFCFFFFFCFFFFFCFDFFFEFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFEFFFFFFFBFFFFF9FBFFFCFAFF
          FFFAFBFFFAFAFFF3F3FFFDFFFFFFFFF6FBFBEBFFFFF4FFFEFCF5DCEAD0A9BE8F
          56656A253250051361101F781C2D761224750A1D7E0F2385162A8011257A0F22
          7410226D0F20640C1C600D1C62102257021857041A570920530E234D12265A2D
          3E886474B298A6DFCED9EEE0EBFFF5FDFFFDFFFFFCFFFFF7FAFFF8FAFFFDFEFE
          FEFEF9FFFEF9FFFEF7FFFFF7FEFFF7FEFFF7FFFFF7FFFFF8FEFDFAFFFDFAFFFD
          FDFFFCFFFFFCFFFFFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFEFFFFFEFFFFFFFCFFFFFCFBFFFFFAFEFFF8FCFFFAFBFFFBFCFFFDFC
          FEFFFCF4FFFFF4FFFFF8FFEEF1C7A3B189566A6E283973202F6E15256E0E1F75
          0C1F7E0D21820D22840D22850E237F0C20790D207511236C1021620F1E5D101E
          6113247621377B274085374F8F4B6491576F8858707B576D74596DAC9AABC4B7
          C5E7DDE9FFF6FFFFFCFFFFFCFFFFFDFFFFFDFFFBFDFEF6FEFEF6FEFEF6FEFEF6
          FEFEF6FEFEF6FEFEF6FEFEF6FEFEF6FEFDF8FEFDFAFFFDFFFFFCFFFFFBFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFE
          FFFFFFFBFFFFFAFEFFF8FDFFFAFCFFFDFDFFFDFBFBFFFEF7FFFFF8FFEEEDD0AB
          AF8354645B1C304F0011660A1D751226780F247C0A21820D24891025880F248B
          14298413277A11246B0D1E5C0A17540C185D1B266C2C38924B5CB0697DD190A5
          E2AABFE3B5CBDCB9CDD1B8CCC7B7C9ABA1B1BCB5C2D4D0DBEAE5EEF5F1F6FAF5
          F7FFF8F9FFFAFBF9FCFFF6FCFFF6FDFFF8FDFEF9FEFDF9FEFDF8FEFDF8FDFEF5
          FDFDF5FCFFF8FDFFFAFEFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFFFEFFFFFEFFFBFEFFFAFEFFFAFEFF
          FBFFFFFFFEFDFDF7F2FFFFF9FFFDF9ECC5C78D5C645015244C04186E172B6E0D
          21720D2283172D88162D810D24830C218B162B7B0C20730A1D680A1B60101D68
          242F8D545DC998A0FCCDD5FFE9F1FFF4FDFFF7FFFFF6FFFFF7FFFFFAFFFFFBFF
          FCF9FFF7F9FFF5F9FEF6F9FDF7FBFCFBFDFDFFFEFDFFFFFCFFFFFEF8FCFFF6FC
          FFF9FCFFFBFDFDFFFEFAFFFFF9FFFEFAFDFEFCF7FCFBF7FCFFF8FCFFF9FCFFFE
          FDFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF
          FFFCFFFCF8FFFEFFFFFEFFFBFCFFF7F9FAFDFFFEFFFFF9FFFFF6FFFBEFFFFEF7
          FFE1DF845057531521581122621026650A1F78162C730F2570081F7D14297E12
          2874081E730C216F0F205C0716651B279D606AE5B4BCFFECF0FFFAFDFFF7F6FF
          FAF5FFFFF9FFFFF9FFFAF3FBF8F3FAFEF8FAFFFBF6FFFBF4FFFBF4FFFBF6FFFB
          F7FFF8F8FFF6FBFFF6FCFFF4FAFFF6FAFFFFF1F4F9FAF8F8FFFFFBFFFFF7FFFF
          F2FFFFF5FFFFF6FFFFFCFBFBFBFBFEFFFDFCFFFDFBFFFFFDFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFCFFFFFBFFFEFFFFFDFFFA
          F9FBFFFEFAFFFFF7FFFDEAFFFFECFFFFEBFFEDE0E0B0AE71323B570E1E611023
          670F266A0D2273142978162C710F256C0A2073122675162A6910235E0F1D712F
          3B9E6770D3A9B0FDE0E3FFFCFDFFFEFEFFFCF9FAFAF4FBFFF7FBFFF8F8FFF6F7
          FFF7F6FFF8F6FFF8EEFFF2ECFDF0EDFEF1F1FFF4F6FFF7F9FFFAFBFFFBFBFFFB
          FAFFFBF7FAFEFFFEFFFFFFF9FFFFEFFFFEE7FFFFE4FFFFE7FFFFEDFFFFF2FEFB
          F3FFFFFFFDFDFFF9F7FDFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFDFFFCFDFFFEFFFEFFFDF9FEFEF9FAFFFFF8FEF9E0E6DCBAF1
          E0B9FEE2C0E5BAA7A76D685C151F5D0B1E6B11286D0F2772122A70102875152D
          701328660D21681327661829520B1B672B369E6F78E2BEC4FFEEF2FFFEFEFFFF
          FEFCFFFBF3FCF9F4FFFFF3FFFFF0FDFBEDFBF7F3FFF9F8FFFCF8FFFBFAFFFBFA
          FFFCFAFFFCFBFFFFFBFEFFFAFDFFF9FAFFF8F8FFF7F8FFF5F4F6FFFFF9FFFEEC
          F5E1C2F6DDB3FBDFB0F9DCAFFCE3BBEDDBBEEBE1CFFAF4EDFFFFFFF9F8FCFDF9
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFEF8FEF9FBFF
          FEFDFDFFFFFCFFFFFFFCFFFFF1ECE1BBB7A877B59D67C4A175AC795F7C383160
          0E1A6A0F2472122A74122A79132C7510296D0B236C11286E192D5C10224D0A19
          501825A3767FD8B8BDFFF5F8FFFEFEFFFDFCF6FCF7F3FFF9F0FEFAEFFDFCEFFB
          FDF2FAF9F3FAF5F9FEF5FFFFF7FFFFF7FFFFF7FFFEF5FFFDF6FFFBFAFEF8FDFC
          F6FFF9F6FFF8F6FFFBF8FFF9F5F4FFFFF1F5E4C3C6AC7DC9A667CFA864C8A15D
          C8A66AB69C6DC7B695EBE3D2FFFFF8FFFEFEFDFCFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFDFFFEF3FDF7F8FFFEFDFDFFFFFDFFFFFFF9FFFF
          EAE3D2A1A18B4A9A7A389E733A8A4D2D6D20176F1522721028740F297A112C7A
          0C288416326D0720690B23701E314C05164A0F1D895B67EDCBD2FFF0F3FFFDFF
          FFFFFEF5F8F6F7FFFBF4FFFCF5FFFBFBFFFCFFFFFCFFFFF9FFFFF5FFFFEEFFF9
          E2FFF4D9FFF0D6FFFAE2FFFCEAFFFFF4FFFDFCFFFBFFFFF9FFFDF6FFFDF6FFFF
          FEF3FFFFDFDBC492A98843B08430BB8B2CB38324B185319B7A35B5A06CE6DBBB
          FFFFF1FFFFFBFCFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FBFFFFF6FFFEF6FFFFFBFEFFFFFBFDFFFFF8FFFFE3E9D699A98F43AA86389D6B
          2987431E6F1B0F791826710B24760D287C0E2A7A06238C1835790E286B0B2365
          12284C0617753F4CE2BBC3FFF5FBFFFDFFFFFFFEF6F7F5F3F9F4F8FFFCF6FFFB
          F3FCEFFFFFF0FFFADEF4E5C4E5D2ACDEC495D8B984DAB77FDCB981E8C48EEECD
          9FF8DDB8FFEDD3FFF9E9FFFFF8FFFDFFFFFFFBFFFFE7F7E8BAC6AC6AA8812CBA
          871FCB921FC68D1ABF8E22A78129BFA562EDE0B2FFFFE9FFFFF5FBFFF9FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF4FFFEF4FFFFFAFEFF
          FFFCFEFFFFF4FFFFDFF1DA96B69944BB933BA56E2591471D71190B7A1622750A
          247E132E7B0927850927880C2A84102D750F285F0A20692334B98491FFF2FAFF
          F9FEFFFDFFFFFBFAF6F7F5F7FDF8FAFFFCF5FDF6EFF2DCF1E9B4DBCB86B8A358
          A58B37A38225A5801EAC831CB28720A17815A58024B09440C1AD66D7CB91EDE8
          BBFFFFDDFFFFE6F6F0C5D2C48AB39546B28823CC951CD99C16D79A14CE981BB2
          8A20C7AD59F1E5ABFFFFE1FFFFEFF8FFF5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFDFFFFF8FFFEF6FFFFFAFCFFFFFEFFFFFFF5FFFFDBF0D890
          BB993FB98A2FA3651E9544216F140D771122790E28871E3378091D8E142C7800
          197C0E2877142E5C0C2386475BE2B6C3FFF8FFFFF6F9FFFCFCFFFFFCFCFFFBFB
          FFFCF9FFFDEEF5F2EBEDD7CCC282BDA952A88E30AC8B24BE9423C7981EC89614
          C6920FC99816BC9315B08E1CAC932DB6A54ECFC37BEBE3A7FFF9BEF0DFA0C0A7
          5DA8852BB88D20CE9716D4990DD49809CA920DAD8312C3A750EFE1A6FFFFE0FF
          FFF1FCFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FDFEFFFEFFF5F8FFF8FEFFFFFFF6FFFFD9F5E396B59336C28B36AA6125862E1D
          75141E740F287713297C1B1F811D1B7E111A7F11237412285D09215F1D36A778
          8EF6D7E6FFF9FFFFFBFBFFFFF9F5FBF0F8FFF7F8FFFCF6FFFFECF6FDDCE0D4CC
          C188BDA755A98930AE8522C99426DBA025DB9C16D19305D39A08CC9A0AC1970F
          B29015A78821AF933CCEB069F0CE88DCB25FCA9C3DB78B26BC8F20C7991CCB98
          12CB960AC89411B58A1DC1A350F2E3B2FFFFEAFFFFF9FFFFFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFDFFF5F8FFF4FDFFFA
          FFF7FFFFDAF5E396B79236C28632AB5E25882C1F731220700D27731127771A17
          791A117E141B77101F690F225B10256F364BBC96A8FFE9F7FFFCFFFAF8F7FDFF
          F9F9FFF6F7FFF6F4FEF8F0FAFAF6FEFFF1F4EBEDE7BAE1CF8EC6AB61B6903EB9
          8727C38A1DD09216D59911D8A011CF9E0CC99C0FC19A16BB9420B78F29B98E37
          C3953DD79E3BCB9328BB8C20BE921FC3971AC39611C9950CCA9816B5891EC1A2
          53F1E1B6FFFFEFFFFFFEFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFFFEFBFFFEFFF5F8FFF4FDFFFAFFFAFFFFDDF5E297B79236C2
          882FAF65238D351D74161B6F0D2373112776161C761414801722750E1D620A18
          5F19268A5562DBB8C2FFF9FFFFFEFFF8F9F7FBFFFCF9FDF8F8FCF7F8FBF9FAFC
          FCFFFEFFFDFBF3FFFFEDFFFFD9F5E5B7DAC189C49F5BB88C39BB8A28BE8E1EC6
          981BC09613BE9812C09915BF961BBB8F1AB8891DBD891EC68E1FC48C1DC09020
          C49823C6991AC4940DCB950CCE991AB5881FC3A155F2E0B7FFFFF1FFFFFFFFFE
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFF8FFFF
          FEF5F8FFF4FCFFFAFFFDFFFFE0F5E19AB79236C68E2FB8722597431F781E176E
          0F1E74122878162478121E821628750F21600917641F299E6C70ECCDCEFFFDFE
          FEFAF9FBFDFDFBFFFFF1F3F3FBF9F8FFFFFCFFFFF9FFFFF8FEF8EDFFFFF6FFFF
          F4FFFFF0FFF6D9F2D9B1D9B984C09D59B38E3AA88622AE8C1BB7941CC09A1CC1
          9819C49515CC9718D49C1FC99017C88F1BC69521C99C23CB9A1AC7940ECC950C
          CD9617B8881FC5A056F2DFB9FFFFF1FFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFF6FFFFFBF5F9FFF4FBFFFAFEFFFFFD
          E4F5DF9EB79238C7912CC17F26A2541F7C27116C0F167210267A152B7B102A7E
          102C781027630C1A69262BA87B78F3D9D3FFFFF9FCFBF7FBFFFFFBFEFFF4F3F7
          FFFAFBFFFAF4FFF5E5FFFFEBFFFFEDEFF4F2EFFAFEFBFFFFFFFFFBFFFEF0FEEC
          D5E2CDA7CCB47EA88F49A89038AD922AB99823C49B1CC99911D09809D3980CD1
          9716CB9519C7961CC7991CCC9A18CD9812D2960ECD9316BA8621C79F57F4DEBA
          FFFFF2FFFFFFFDFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFBFFFFF4FFFFF8F5FAFFF4FBFFFAFDFFFFFCE7F5DDA1B79238C28E24C789
          25AF672184350E6C140E6F0F2078112D7A0C307A092E7A0F2F650D1D6C292EAF
          837CF8E0D4FFFFF7FFFFFBF8FDFEFAFEFFFFFCFFFFFDFDF4E3D6E0C9AFFFE5BE
          FFFFE2FFFFFBF4FEFFF4FAFFF7F9FAFFFEFDFFFFF9FFF5E5F3E8CAD4C597BDAC
          6DA6913FA58825B58F19C69612D09809D29809D09614C89215C19016C39316C9
          9715D19914D69711D09117BC8522C79E59F4DEBBFFFEF4FFFEFFFBFEFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF1FFFFF5F5FBFF
          F4FBFFFAFCFFFFFAE9F5DCA4B79139BC8A1ACD9224BE7B2491470F721E0C7114
          1D78112D7808327905347A0F36640A2169252CB2847CFAE0D2FFFFF5FFFFF9F8
          FDFEFAFEFFFFFDFFFFFFFBE5D0BAB79B72D5B377F8DCA6FCF6DFFBFDF7FFFFFB
          FEFBF7FCF9F5FFFFFCFFFFFBFFFFF2FAF4DDE3DAB4C6B87EB59E52B39330BA92
          1CC99715D59D18C89314C59216C09117C09215C89516D09815D69612D29019BE
          8424C89D5AF6DDBBFFFEF4FDFFFFFAFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFBFFFFF0FFFFF5F5FBFFF4FCFFFAFCFFFFFAEBF5DAA7
          B7903BB98715D29A23CA8C269D5910792A09741A1979132C7709337906387B0E
          3C620520661F29B0807AF8DDCFFFFEF1FFFFF8FAFFFFF7FBFFFCF9FBFFFFF6E1
          CCACA0824BAE873CC9A95ED7C596F0E7C6FFFFE9FFFFEEFFFEEDFFFCF1FFFFFA
          FFFFFBFFFFF8FFFFEDFDF4D2E6D5A2C6AD63AF8E31B2881DBF901DC1901CC394
          20C19621C1961FC59518CC9516D49312D29019BE8425C89D5AF6DDBDFFFEF4FD
          FFFFF8FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFF
          FFF1FFFFF5F5FBFFF4FDFFFAFCFFFFF9ECF5DAA8B78F3CBD8B19C69013CA911E
          BD7F25954C1A6C17076907157B0F33770435780A3A781836641824A56F6EEFCE
          C5FFFFF7FBF8F3F9FDFEF9FEFFFFFFFEFFFDECF8E7BCAC904FAA852BAD892BA4
          8639BCA25FEBD294FFF8C4FFFFDEFFFFE7FFFFF1FFFFF8FFFFFCFFFFFBFFFFF5
          FFFEE6FFF2C7EDD59BC9AC62AF8C36AC8320B3891FB38C22B88F22C39420CF99
          1DD59616CE8E18BE8424C89E59F6DDBBFFFEF4FDFFFFF8FEFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF3FFFFF5F5FCFFF4FDFFFA
          FDFFFFF9ECF5D9AAB78F3DC18F1DCA9516CE981CC58B24A86421843514731613
          730B227C0C3471052F6908236313209B5F60DCB3B0FFFEF9FFFFFCFDFEFFFAFF
          FFFFFFFBFFFEE9FAECBCB69D57AE8C2FB38B25AA8320B38D2DCAA74DE9C878FF
          E4A1FFF4C0FFFCD8FFFFEBFEFAF5FDFBFBFFFDFDFFFFFAFFFFEFFFF8D8F3E0B5
          E6CC90D0AF60BC9840A6842AAA8725BB9225C7951FCD9115CC8E18BC8524C89E
          57F6DEBAFFFFF2FDFFFFF8FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFCFFFFF6FFFFF8F5FCFFF4FEFFFAFEFFFFFAEBF5D8ABB78D40C2
          8F21CB9617CF9B19CB9522BE802CA45C26852F176F0F0F781126750E29680819
          68151E8A4548C59393FFF6F7FFFCFEFFFEFFFAFFFFFAFFF8FFFFEEFFFDCECEB9
          75B89A43B18923C09223BB8C19B88C1BC1992FD4B255EED285FFF2B9FFFFE2FF
          FFEFFFFBFAFAF8FEFBF9FFFFFFFEFFFFF8FFFFEEFFF9D8F9DFA9E2C582BB9F58
          A78B37AF8A28BE9122CC931ACA9019BA8621C8A055F6E0B7FFFFEFFDFFFFF8FE
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFF8FFFF
          FBF5FDFDF4FFFFFAFFFDFFFBE8F5D8ABB78D42BE8A20C99316CC9815CA971BC8
          902BBB7A2F9E502180290F6C0E097A181E7011156C1518762B2DB07579FFE5EC
          FFF7FFFEF7FEF9FEFFF2FBF1FFFFEEFFFFE0EADA9FC5AA60AD882CCB9C30CC9A
          24C3941BB88D18B38C1FBA9A3BD1B76BE4CF9BFFFFE1FFFFF4FFFDFFF9F8FFF8
          F7FFFCFBFFFFFDF9FFFDEFFFFAD9FFF6C8EED9A5C6AF6BB69841C0992FCE9A22
          C7921AB8881FC7A252F4E1B4FFFFEEFDFFFEF8FEFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFFFFEF5FDFCF4FFFEFAFFF8FFFD
          E5F5D8ABB78B44BC8621C99219CA9711C69612C89521C88E2EB8732AA2541F80
          29077D220D6B10016D160C6513128C494EF0BEC8FFF8FFFDF4FEF9FEFFE6F3EB
          FBFFF2FFFFE7FFF4C8DCC490BF9C58AE8227B98B20C09423C09723B8931FB290
          25B1963BB49E57DBCB9DEBDFC7FCF6EFFFFDFFFCFCFFF9F9FFF9FBFCFFFDF8FF
          FFF3FFFFEDFFFFDFFDECB9E4CD7FCCAC49C59A23C09118B7891EC5A350F4E3B2
          FFFFEBFDFFFCFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFCFFFFFDFFF5FDFCF4FFFCFAFFF6FFFEE2F5D8ABB78A46BF8728CB93
          1CCB9812C6980FC79719CB9627CA8C2EC27C2FBA6D2F9341127920007C230E62
          0B07651B21AC7481FFF2FFFFF6FFFAFFFFE7F5EFF4FFF5FFFFF0FFFFEAFEE9C9
          EDCFA0BC9852B59036AE8724B08B1DB5921DB19120A98B269E84309A864CBCAC
          87E6DCCBFEF8F3FFFFFFFDFFFFFCFEFEFEFFFDFFFEFFFFF5F1FFFFEEFFFFE2FF
          F7B2D1B858B7911BBC9015B38A1DC5A44EF4E4AFFFFFEAFDFFFBFAFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFBFFFFFDFFF5FDFC
          F4FFFBFAFFF3FFFFE0F5D8ABB78A47C38A2FCB921FCB9812C79A0DC69912C898
          1ACD9427CE8E2FDA9440B96C27A6521E9E44257C231967171C6A2C3CD2ABBBF4
          E3F0FAFEFFEEFCFAF3FFFBFAFFF4FFFFF4FFFFF1FFF6DCFEE2B3E6C986C6A855
          B89837B79628B39421AB8E22A18729AF9650CAB686EDDFC3FFF6E8FFFDF4FFFF
          F9FCFFF6FCFDFBFFFBFFFCF4FEFFFBF6FFFDE0EADD9FBFA74DB28F1ABD9419B1
          8B1BC3A54CF2E5ADFFFFE8FDFFFBFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFEFFFFFCFFFFFDFFF5FCFFF6FFFCFCFFF3FFFFE0F3DBA7
          B58C43C18E2DC7911CC99512CB9A10C89810C79513CA931ACC9221CA8E24C989
          2BCE8639B66930994B2787402C51180F97716DDCC9C4FFFDF8F4FCF5F6FFFCED
          F4F1FFFFFFFFFDFFFFFCF6FFFFE4FFF7C6F6E4A7EAD990E8D47FE5D37AE6D57F
          E7D78BEFE1A7FBEFC5FFFFE4FFFFF4FFFFF6FFFFF6FFFFF6FFFDF8FFF7FDFFFD
          FFFFFFF7E5D6B5B8A463AC8F34BA9221C39922B08A1EC1A44FF4E3B2FFFFEBFF
          FFFCFBFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF7
          FFFFF4FFFFF1FAFFFAFFFFFFFFF8FFFEE0F1DEA1B09239B8901FC49515CC9711
          D09712D09615CF9517CD9617CA9417CB981EC4931FC48F21C18D29BC8631A776
          2C875B1E684715B8A17BDDD1B5FEFAE8FBFDF7F2F6FBF5FAFFF4F9FFF6F8FFFF
          FFF0FFFFE5FFFFE1F9FBD7EDF1CDEAEECBEDF2D3F2F7DCF0F4E1F6FAEEFFFFF8
          FFFFFBFFFFFAFFFEF6FFFFF6FFFFF7FFFBEEFFFFEDFFE5C6CFAA78B0863BB98C
          2BC69724BF921FAF8524C4A05AFADEBCFFFAF2FFFBFFFFFCFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFF3FFFEF3FFFFF3F9FFFDFCFFFF
          FEFBFFFDE1F1DF9EAD9436B5931CC29613CA9614D09517D09419CF9419CB9617
          C89516CA9919C69717C59518C5961DC29424B88B24A47B1F926D1D8E6E2DC0A7
          75F4E3C2FFFDEBFFFFFAFBFEFFF3F8FFECF2FDFAFFF6FDFFF2FBFFF5F8FFF7F5
          FFF9F2FDFBF0FCFEF0FCFEF4FFFFF6FFFFF8FCFDF9F9F9FDFAF6FFFCF5FFFEF5
          FFFFEFFFFFE2FFE6B9E0B681C0914DBD8A2EC59224C8971DBC911AAF8623C4A0
          5AFCDDBCFFF9F2FFFBFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFDFFFFF7FFFDF6FFFFF7F9FFFFFBFFFFFDFDFFFCE2F1DEA1AD9339B3
          9120BE9419C7941ACB931CCB9120C99120C6941EC7941ACE9619D09517D09418
          D0941CCE9521CB9326C58F2ABB8A2E976A19A9853FCDAF76F3DCAFFFFEDDFFFF
          EDFFFFF2FFF9F0FFFCFBFFFAFCFCF8FDFAF9FFFBFCFFFAFCFFF8F9FFF6F8FFFA
          FCFFF7F8FFFAF6FCFFFCFDFFFFFCFFFFF9FFFFF6FFFDE3FBE5B1D5B873B28B40
          B08429C19022C79719C4990EBE9812AD8B1AC2A451FAE2B4FFFEEBFFFFF8FFFF
          FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFAFFFDFBFF
          FFFCF8FFFFFAFFFFFCFDFFFBE4F3DCA4AD923CB19023BD931CC5921EC89220C8
          9025C49025C09223C3921ED0931BD79419D49319D4921BD1911BD0911FCF9224
          CC922BC39030B4852FB0893BC7A460EACD90FFEFB9FFFFD2FFFFE6FFFFF7FFFD
          FFFFFBFEFFF8FEFFF8FFFFF8FFFFF9FEFEF9FBFDF8F9FFFAF7FFFFF8FFFFF4FF
          FFF1FFF9E2F3E0C5E5CFA5C4AB63B2953AAA8424B98D22C7971AC6960EC49906
          C39F11AD8E15C1A74DF9E4B0FFFFE6FFFFF6FDFFFBFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFDFFFEFFFFF7FFFFFAFFFFFBFEFFFA
          E5F3DBA5AD913DB18E26BB921EC39121C69123C48F27C28F27BF9126C19022CD
          8F1DD3901DD4911ED3901DD18E1BD08D1ACE8F1DCD9022D1972DC69129BA8B29
          B58A2DB5903BCBA956F2D384FFF3B6FFF7D8FFF9E9FFFFF1FFFFF2FFFFF2FFFF
          F0FFFFF0FFFFEDFFFFEAFFFFE5FFFFDCFFF9CBF6E4AFD8C48BBAA266AA9147A6
          8829AD8C1FBA8F20C5951FCC9815CB9909C89D06C49F0FAD8E13C1A84CF9E4B0
          FFFFE6FFFFF7FBFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFFFFFBFFFEFFFFF7FFFFF9FFFFFBFDFFF9E5F5DBA5AE903DB18E26BD91
          1EC3911FC89023C68F26C49026C09223C19121C78C1FCC8D1FCE8F21D09020CF
          901ECE8F1DCF901DCE911DCB921FC89220C49222BA8C20B3891FB68E28C9A23F
          D4B25EDEC38BE5CFA5F8E2B8FFEEC4FFF2C7FFF2C3FFF4C3FFF6C1FFEDB2F8E6
          A5EBD790D9C375C5AB57B39740A78A2FA58521B28D1DBB931CC3931DC89216CF
          9611D39E0ECF9F0BC0980AAF8D16C2A64FF9E3B3FFFEEBFFFEFBFBFEFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFAFFFFFCFFF8FF
          FFFAFFFFFCFBFFFAE4F5DDA3AE913CB59022BE931AC7931BCB921ECB9120C991
          20C6941EC3931DC28E23C28E24C48E23C59022C99223CA9221CA9320CA941FC9
          941CC7931BC1911BC0911DC29623C39928BC9424B08A24B69742BC9F54CAAD62
          D5B96CDABE71DABF6FD9BE6DDBC06ACFB459CCAE4FC2A23EBA982DB79222B891
          1DBD951EC2991FC4981DC7961CC9911ACE9119D69515D79812D0990EC69513B0
          891DC2A256FADFBAFFFAF2FFFAFFFFFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFFFFF8FFFFFBFFF8FFFFFBFFFFFDFAFFFBE2F5DDA1
          B09239B5911FC09417CA9418CF9419CF931BCF931BCB9617C79418C29424BF91
          25BD9021BE9020C29320C59420C7951DC7941AC18E12CA971BCA991FC49319C0
          9118C4951CC59721C19522B89129B28D2BB28D2BB38E2CB6922EB9922FB8922C
          B69227BB9428BA9222BB901BBD9017C39316C79517C89614C89614C79415C892
          15D1931DD99621D8931AD18E11CE9210CE9B21B08621C4A158FCDDBCFFF9F3FF
          F8FFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF
          FFF9F8F8F2FFFDFFFFFCFFFFFAF4FFFCE1F3DC9EB2983AB5931CC19414CB9413
          D09313D29215D19212CE940DC7940EBE9419B9941CBB931CBD941ABE9419C094
          17C49417C69416C69515C79415C79416C79416C79317C79317C79317C6921AC0
          9020BE9021BE9021BE9021BE8F23C08F23C08F23C28F21C59021C7911FCA911E
          CE911DCF911BD1921AD3911AD19317C28E0CD19C1DD89A24D99321D48E19DD99
          22C08408D29D28AC821FC6A35AF8D8B5FFFAF3FFFAFFFFF8FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFFFCFFFFF8FBFEF5FFFDFFFFFDFFFF
          F7F1FFFDE1EDDA9DAC9539B69724C2991ACC991AD3991BD6981CD59818D39A15
          CD9A14C49C1BBF9C1DC19B1DC39B1DC49B1CC69B1CC89B1CCA9B1BCD9A1BCD9A
          1BCF991CCF991CD1981DD1981DD1981DCF981FCA9820C89822C89822C89723CA
          9723CA9624CC9624CC9526CD9526CF9524D39424D49424D69424D89324DA9423
          D49620CB9819CC9B1BC28713CF8F1FD89626D59624CB941BC89925AB8421C4A5
          5AF5D9B0FFFBEBFFFBFCFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFF2F3EFFDFFF8FCFFF6FFFEFFFFFDFFFFFDFAFFFFEBE8DBA3A7933EA4
          8A1EB08C16BB8D17C28C19C58B1AC58C18C38E15C09012BA9112B99212B99212
          BA9112BA9112BC9112BE9112C09013C38F13C38E15C58D16C78D16C98C18C98C
          18C98C18C58C18BE8F16BA9015BC8F16BC8F16BC8E18BC8D19BE8C1ABE8C1CBF
          8A1BC1891CC1891CC2881EC4881EC4881EC6871FC28A1BBF9719C39E1EBB8B1B
          C79027C58C23B1790CBE8F1BB5901EA68823C0AA58F3E0ADFFFFE7FFFFF5FFFD
          F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFAFEF3FEFF
          F8FFFDFFFFFCFFFFFEFFFFFFF0DFD5A59C8F45A79334B0952DBB9431BF9433C2
          9435C39536C19732C09A2EBF9A2ABF9B29C09B29C09A2AC09A2AC29A2AC4992C
          C4992CC6982DC7972EC9962EC99530CB9530CB9530CD9431C99530C2992CBD9B
          29BF9A2ABF9A2ABF9A2CBF992DC0982EC0982EC1962FC19530C19432C19433C3
          9333C39334C39334BF9532B39826AC9220AB8624B88C31C89A42C4983BC6A03A
          AF922A9A8627B6A95BEEE0AFFFFFE7FFFFF2FFFFF7FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF4F4F4FFFFFCFEFFF7FFFFFBFFFCFFFCF8FFFFF8FFFFFA
          F3DCD8B5AAA36A9E9349A89544AE9448B3934CB29251B39352AF954FB1974BB4
          9746B59843B59843B59744B59746B79646B79647B79647B99549B99549BB9449
          BB944ABC934ABC934ABE924BBB9449B59843B29A40B29A40B29A40B29A40B29A
          42B49942B49942B59A44B59945B59945B59847B59847B59748B59748B19947A3
          963AAEA24ABCA45CB89A59B59052B4914FAE9245B19C4AAFA355C2BC7BEAE6BD
          FFFFE9FFFFF6FFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
        mmHeight = 35454
        mmLeft = 6085
        mmTop = 44186
        mmWidth = 44979
        BandType = 8
      end
      object ppLabel37: TppLabel
        UserName = 'Label37'
        Caption = 'Revendedor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 82550
        mmTop = 40746
        mmWidth = 22754
        BandType = 8
      end
      object ppLabel42: TppLabel
        UserName = 'Label42'
        Caption = 'clientes@e-garantia.com.br'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 5292
        mmTop = 74083
        mmWidth = 46567
        BandType = 8
      end
      object ppLabel41: TppLabel
        UserName = 'Label41'
        Caption = 'garantia@celdom.com.br'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 72761
        mmTop = 65352
        mmWidth = 42598
        BandType = 8
      end
      object ppRichText1: TppRichText
        UserName = 'RichText1'
        Caption = 'RichText1'
        RichText = 
          '{\rtf1\ansi\ansicpg1252\deff0\deflang1046{\fonttbl{\f0\fnil Aria' +
          'l;}{\f1\fnil\fcharset0 Arial;}{\f2\fnil MS Sans Serif;}{\f3\fnil' +
          '\fcharset2 Symbol;}}'#13#10'\viewkind4\uc1\pard{\pntext\f3\'#39'B7\tab}{\*' +
          '\pn\pnlvlblt\pnf3\pnindent0{\pntxtb\'#39'B7}}\fi-200\li200\f0\fs16 M' +
          'antenha em local seguro este \b\f1 Recibo de Aquisi\'#39'e7\'#39'e3o\b0\' +
          'f0  e o seu \b Certificado de Garantia Extended\b0\f1  (que \'#39'e9' +
          ' entregue a voc\'#39'ea no momento da aquisi\'#39'e7\'#39'e3o da sua Garanti' +
          'a e o Cupom/Nota Fiscal original da compra do Produto Garantido)' +
          '.\f0\par'#13#10'{\pntext\f3\'#39'B7\tab}Sua \b Garantia Extended\b0\f1  es' +
          't\'#39'e1 registrada no \b\f0 Banco de Dados Extended-Garantech\b0\f' +
          '1  a partir do dia 15 do m\'#39'eas seguinte ao da aquisi\'#39'e7\'#39'e3o d' +
          'a Garantia.\f0\par'#13#10'{\pntext\f3\'#39'B7\tab}Este \b\f1 Recibo de Aqu' +
          'isi\'#39'e7\'#39'e3o\b0  \'#39'e9 o documento h\'#39'e1bil que comprova a aquisi' +
          '\'#39'e7\'#39'e3o de sua \b\f0 Garantia Extended\b0 , e para os \b Produ' +
          'tos\b0\f1  que ser\'#39'e3o entregues em sua resid\'#39'eancia, acompanh' +
          'ar\'#39'e1 a Nota Fiscal de entrega.\f0\par'#13#10'{\pntext\f3\'#39'B7\tab}Tod' +
          'as as \b\f1 Instru\'#39'e7\'#39'f5es para Utiliza\'#39'e7\'#39'e3o de sua Garant' +
          'ia Extended\b0  est\'#39'e3o descritas no \b\f0 Certificado de Garan' +
          'tia Extended\b0\f1 , inclusive os telefones para a solicita\'#39'e7\' +
          #39'e3o de futuros atendimentos.\f0\par'#13#10'\f1{\pntext\f3\'#39'B7\tab}Obs' +
          'erve sempre as Condi\'#39'e7\'#39'f5es de uso e Conserva\'#39'e7\'#39'e3o do Man' +
          'ual do Fabricante do Produto adquirido.\f2\par'#13#10'}'#13#10
        mmHeight = 28046
        mmLeft = 1588
        mmTop = 1058
        mmWidth = 189177
        BandType = 8
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
      end
      object ppImage3: TppImage
        UserName = 'Image3'
        AutoSize = True
        MaintainAspectRatio = False
        Picture.Data = {
          0A544A504547496D616765EE130000FFD8FFE000104A46494600010101006000
          600000FFED05D050686F746F73686F7020332E30003842494D04250000000000
          10000000000000000000000000000000003842494D03ED000000000010012C00
          0000010002012C0000000100023842494D042600000000000E00000000000000
          0000003F8000003842494D040D0000000000040000001E3842494D0419000000
          0000040000001E3842494D03F300000000000900000000000000000100384249
          4D040A00000000000100003842494D271000000000000A000100000000000000
          023842494D03F5000000000048002F66660001006C6666000600000000000100
          2F6666000100A1999A0006000000000001003200000001005A00000006000000
          000001003500000001002D000000060000000000013842494D03F80000000000
          700000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF03E800003842494D0408000000000010000000
          010000024000000240000000003842494D041E00000000000400000000384249
          4D041A00000000035F000000060000000000000000000002C500001357000000
          15004C006F0067006F007400690070006F0073002000430045004C0044004F00
          4D00200063006F00700079000000010000000000000000000000000000000000
          000001000000000000000000001357000002C500000000000000000000000000
          0000000100000000000000000000000000000000000000100000000100000000
          00006E756C6C0000000200000006626F756E64734F626A630000000100000000
          0000526374310000000400000000546F70206C6F6E6700000000000000004C65
          66746C6F6E67000000000000000042746F6D6C6F6E67000002C5000000005267
          68746C6F6E670000135700000006736C69636573566C4C73000000014F626A63
          00000001000000000005736C6963650000001200000007736C69636549446C6F
          6E67000000000000000767726F757049446C6F6E6700000000000000066F7269
          67696E656E756D0000000C45536C6963654F726967696E0000000D6175746F47
          656E6572617465640000000054797065656E756D0000000A45536C6963655479
          706500000000496D672000000006626F756E64734F626A630000000100000000
          0000526374310000000400000000546F70206C6F6E6700000000000000004C65
          66746C6F6E67000000000000000042746F6D6C6F6E67000002C5000000005267
          68746C6F6E67000013570000000375726C54455854000000010000000000006E
          756C6C54455854000000010000000000004D7367655445585400000001000000
          000006616C74546167544558540000000100000000000E63656C6C5465787449
          7348544D4C626F6F6C010000000863656C6C5465787454455854000000010000
          00000009686F727A416C69676E656E756D0000000F45536C696365486F727A41
          6C69676E0000000764656661756C740000000976657274416C69676E656E756D
          0000000F45536C69636556657274416C69676E0000000764656661756C740000
          000B6267436F6C6F7254797065656E756D0000001145536C6963654247436F6C
          6F7254797065000000004E6F6E6500000009746F704F75747365746C6F6E6700
          0000000000000A6C6566744F75747365746C6F6E67000000000000000C626F74
          746F6D4F75747365746C6F6E67000000000000000B72696768744F7574736574
          6C6F6E6700000000003842494D042800000000000C000000013FF00000000000
          003842494D041100000000000101003842494D04140000000000040000000238
          42494D042100000000005500000001010000000F00410064006F006200650020
          00500068006F0074006F00730068006F00700000001300410064006F00620065
          002000500068006F0074006F00730068006F0070002000430053003200000001
          003842494D04060000000000070008010100010100FFE100D445786966000049
          492A0008000000070012010300010000000100DCCB1A01050001000000620000
          001B010500010000006A00000028010300010000000200CC98310102001C0000
          007200000032010200140000008E0000006987040001000000A2000000000000
          00C0C62D0010270000C0C62D001027000041646F62652050686F746F73686F70
          204353322057696E646F777300323030363A30323A30372031303A30363A3430
          00030001A0030001000000FFFFFFFF02A00400010000005713000003A0040001
          000000C502000000000000FFDB004300080606070605080707070909080A0C14
          0D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C
          30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832
          211C213232323232323232323232323232323232323232323232323232323232
          323232323232323232323232323232323232323232FFC0001108002500FC0301
          2200021101031101FFC4001F0000010501010101010100000000000000000102
          030405060708090A0BFFC400B5100002010303020403050504040000017D0102
          0300041105122131410613516107227114328191A1082342B1C11552D1F02433
          627282090A161718191A25262728292A3435363738393A434445464748494A53
          5455565758595A636465666768696A737475767778797A838485868788898A92
          939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7
          C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FA
          FFC4001F0100030101010101010101010000000000000102030405060708090A
          0BFFC400B5110002010204040304070504040001027700010203110405213106
          1241510761711322328108144291A1B1C109233352F0156272D10A162434E125
          F11718191A262728292A35363738393A434445464748494A535455565758595A
          636465666768696A737475767778797A82838485868788898A92939495969798
          999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4
          D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002
          110311003F00F7FAAF7B7D69A75ABDCDEDC476F0275791801562BE7DF881E209
          F5DF145D44CEDF63B295A0822CFCB953B59FEA483CFA62B2AD57D9C6E7760304
          F175396F64B73D64FC46F0A0247F6B4671DC237F8527FC2C7F0A7FD0593FEF86
          FF000AF09D26C3FB5359B1D3F7F97F699D222E0676827AD7B52FC28F0B2A00D0
          5DB90396374E09FC8815853AB56A6A923D0C5E070385695494AEFB58B9FF000B
          1FC29FF4164FFBE1BFC2B774AD5AC75AB15BDD3E7135BB3150E011C8E0F5AE5F
          FE1557857FE7DAEBFF0002A4FF001AABE2D9A0F00781BEC3A1EF824B994C50B1
          72CC85B25D813DF00E3DCD6CA55229B9DAC713A385ACE34F0CE5CCDF5B5BF03A
          3D4FC63E1ED22E5ADAF7548239D7EF4609665FAE338FC6A8FF00C2C7F0A7FD05
          93FEF86FF0AF9FB1C93D493924F249F535DD7837C31E1DBED0A5D5FC45766288
          DC18225F38C6B900139239279F5AE78E267395A291E9D6CA30D429F3D4949FA5
          BF23D1FF00E163F853FE82C9FF007C37F8559D3FC71E1DD52FE2B2B3D4525B89
          49088118678CF715C7FF00C237F0C7FE8229FF0081EFFE35A3A0E85E02B5D72D
          67D2AF124BF462615FB633E4E0E78279E335B46752FAB470D4C3E1141B8A9DFC
          D2B1BFA878E3C3BA5DFCD6579A8A45710901D0A31C1201F4F422ABAFC46F0AB3
          051AAA649007C8DFE15E41E3EFF91F758FFAEA9FFA2D6B9E8BFD7C5FEFAFF315
          84B153526AC7A34725A13A519B6EED27D3B7A1F54D14515DE7CC19FAC6B9A768
          36A973A95C882277D8AC41393E9C562FFC2C7F0A7FD0593FEF86FF000AC5F8C3
          FF0022CD9FFD7DAFFE826BC62B8EB622509F2A3DFCBF2AA389A0AA4DBBEBB7FC
          31F40FFC2C7F0A7FD0593FEF86FF000A3FE163F853FE82C9FF007C37F85729E0
          8F00E81AEF846CF51BF8276B995A50EC970EA0ED9594700E3A01581F117C1F63
          E1696C26D35A5105D17468E57DDB5940208279C119EBE94E556B2873D9589A78
          3C0CEBBC3A72E6BB5D2DA1EBBA4F8A344D72431E9DA8C13CA064C60E1B1F43C9
          AD7AF95A2965B79E39EDE578678D8347221C3230E841AF65D43C793FFC2AE8B5
          881826A3738B5040FB92F21980F6009FCA9D2C4A927CDD09C664F2A528FB2775
          276D7A33A9D53C5DA068D706DEFF00538229C726304B30FA81D3F1AA1FF0B1FC
          29FF004164FF00BE1BFC2BE7E24B333B3333B12CCCC72589EA49EE6BD17E1E78
          1B4AF11E9171A86A7E7B959CC291C721400000E491C93CD4431152A4AD148E8A
          F94E170D4BDA5593F95BFAFC4EF3FE163F853FE82C9FF7C37F8568E95E2CD0B5
          A9BC8D3F528259B19F2F3B58FD01EBF85795FC45F05E9BE19B7B2BCD30CCA934
          86292291CB81C64104F3DAB825668E45923768E442191D0E1948E841EC694B13
          5212E59243A39461B114BDA5293D7BD8FA7B54D52CB46B07BDBF9C436E840672
          09C64E074AA9A3789F46D7E4963D32FA39E48802E8321803DF07B5701AC6BD27
          88BE0C3DE4E41BA8E5486723BBAB8E7F1183F8D798D95EDD69D7B15ED94EF05C
          C2772488791EC7D41EE0F06AEA627964ADB330C364EAB529F33B4D36BCB43EA4
          A2B8FF000578EED7C4F00B6B8D96FAA20F9E1CF120FEF27A8F6ED5D8574C64A4
          AE8F1EB519D19B85456682B3359F10E93E1F8E27D52F63B7F3491186C92D8EB8
          039C0F5F71597E30F1AD97856D369C4FA8483F736C0FFE3CDE8BFCEBC1B54D52
          FB5AD41EFB51B869EE1F8DC7A2AF6551D9464F1F53D49AC2B6214345B9E8E5F9
          5CB13EFCF48FE2FD0FA4748D66C35DB2377A6DC09E00E50B0047CC3A8E6AFD70
          3F087FE44C97FEBF65FF00D96BBEADA9C9CA2A4CE1C552546B4A9C764C2BE61D
          66D24B1D7B52B4973BE2BB954E463237920FE2083F8D7D3D5C178E7E1D8F11DC
          FF0069E9D34706A3B42C8B26764C074C91C8603BE0FA56389A6E71D3A1DD9463
          2187AAD54D148F27F0AC8B178BF467760AA2F23C93DB9AFA56BC04FC32F16FFD
          03A3FA8B94FF001ADD4D1FE2A22055BA9F006066EE327F3CD634252A69A7167A
          19952A38B94650AB156EECF61AF36F8C76F23E85A75C2826386E4873E9B9481F
          AD647F657C55FF009F99BFF02A2AEDF44D1B50D47C18FA5F8B019A798BACBB9C
          31DB9CA9047191C11E8456EE4EAC5C2CD1E742947055235FDA46567B27A9F3ED
          7A8781FC3561E2CF013D85E5C5C4421D41E5FF0047650D9DA319DCA78EB595AA
          FC28D7ED2ED974EF26FAD89F91CC823703FDA078CFD0F3EDD28D37C1BF103476
          90E9A8D6BE663788EEE301B1D32335C94E1284BDE8B68F771388A388A4BD9555
          17A3576757FF000A6B40FF00A08EADFF007F22FF00E3757F46F85FA3687AC5B6
          A76F7BA8C935B92C8B2BC654E411CE101EFEB5CAFF00657C55FF009F99BFF02A
          2AD5F0DE9DF10E1F10D9C9ABDC48DA7AB1F3835C46C08C1C7039EB8AE88F25D5
          A0CF2EABAFECE57C4C5AB3D2FBF91C37C4482483C7DAA6F04090C7221F5528A3
          3F9823F0AE6A321658D8F003A93F9D7BE78DFC0F0F8B208A68A616DA8DBA958A
          565CABA9E76377C67BF6F7E95E5F27C30F162BB20B082400E372DCA61BDC6707
          F315CF5A8CD4DB4AE7A780CC684A84633924D2B6BA6C7BE8208C839068AF1BB7
          D0BE285ADBA410CF3AC518DAABF6B8CE0761C9A93FB2BE2AFF00CFCCDFF81515
          75FB77FCACF09E5B0E95A1F79B7F18BFE45AB3FF00AFB1FF00A09AF19AF61F10
          786FC4FAD78034AB2B88C5C6AF14C5EE37CC838CB639E87822B8BFF8567E2DFF
          00A06C7FF8131FF8D72D784E53BA4CF672CAF428D0F6739ABA6FAA3D3FE187FC
          93ED3BFDF9FF00F47495CD7C68917C8D121CFCE6495F1EC140FE6C2B2EC7C37F
          12B4CB34B3B16782DE32C5634BA8F0324B1EFEA49AA7A87817C77AB5C8B9D420
          373305DA1E4BB4381E839E056929C9D2E45167351A14618C78875636BB7BF7BF
          F99C4576D7BA6DC27C1BD36E590845D41A73FEE3EE504FE2455DD0BE136AB757
          8ADADB476966A72F1C7207924F60470A0FAE73EDDEBD6EE749B1BAD21F4A96DD
          0D93C5E49880C00B8C003D3153470F269B7A1B63F34A519C1537CD67776FEBCC
          F986BDABE0FB29F095CA82370BE7C8F4F952B92D5BE136BB6776C34C68AFED49
          F919A411C8A3D181E09F7079F414DD37C1BF10747321D351AD7CCC6F11DDC786
          C74C8CD4D28CE94EEE2CD71B570F8CC3F246AA5D75674BF195D468BA64791B9A
          E8903E8A6BC7EBB9D47C11E3DD5E759B5184DD488BB54C97719DA3D8678A9747
          F84DADDE5D28D55A2B1B453F3EC9049238F45C703D324F1E869548CEA4EEA2CA
          C1D6C3E130EA12A89DBB319676B241F0475299C616EB5012C7EEA0A267F3435C
          257D01E2FF000ECD77E057D1745B652C8235862DC1405561DCFB0AF2CFF8567E
          2DFF00A06C7FF8131FF8D3AD4A49A495F4272FC751946739C946F26ECDADB431
          ACB48D4E4D224D7AC37ECB29F6BB424892120021C7B73F87D2BB883E2FDCAF86
          8C52DAAC9AC8C224D8C44C3FE7A103A1FF0064704FA0E9D47C36F0EEA5E1FD1E
          FADF55B7489E6B8DEAA1D5C15DA076FA1A8A7F853A1CFE2017E19D2C89DF2582
          8F919F3EBD42FAAFEA0715A429548C538697DCE5AF8EC255AB286215D4754D75
          F2FEB43C9EE74CD5AF348B8F135FB3B452CCA8269BEF4ECD9E47FB231F4EC2B2
          2BDFBE206837BAD785174FD26DD1E549E3658F70401467A678AF2EFF008567E2
          DFFA06C7FF008131FF008D635684A32B24D9DD82CCA955A7CD524A3AE8AEB6E8
          7A0FC21FF91324FF00AFD97FF65AEF6B92F875A1EA1A07865ECF5285619CDCC9
          2050E1BE538C723E95D6D7A149350499F2F8E9467899CA2EEAE1451456872051
          4514005145140051451400514514005145140051451400514514005145140051
          451400514514005145140051451400514514005145140051451401FFD9}
        mmHeight = 9790
        mmLeft = 60590
        mmTop = 55563
        mmWidth = 66675
        BandType = 8
      end
      object ppImage2: TppImage
        UserName = 'Image2'
        MaintainAspectRatio = False
        Picture.Data = {
          0A544A504547496D61676572120000FFD8FFE000104A46494600010101006000
          600000FFED05D050686F746F73686F7020332E30003842494D04250000000000
          10000000000000000000000000000000003842494D03ED000000000010012C00
          0000010002012C0000000100023842494D042600000000000E00000000000000
          0000003F8000003842494D040D0000000000040000001E3842494D0419000000
          0000040000001E3842494D03F300000000000900000000000000000100384249
          4D040A00000000000100003842494D271000000000000A000100000000000000
          023842494D03F5000000000048002F66660001006C6666000600000000000100
          2F6666000100A1999A0006000000000001003200000001005A00000006000000
          000001003500000001002D000000060000000000013842494D03F80000000000
          700000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF03E800000000FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF03E800003842494D0408000000000010000000
          010000024000000240000000003842494D041E00000000000400000000384249
          4D041A00000000035F000000060000000000000000000002C500001357000000
          15004C006F0067006F007400690070006F0073002000430045004C0044004F00
          4D00200063006F00700079000000010000000000000000000000000000000000
          000001000000000000000000001357000002C500000000000000000000000000
          0000000100000000000000000000000000000000000000100000000100000000
          00006E756C6C0000000200000006626F756E64734F626A630000000100000000
          0000526374310000000400000000546F70206C6F6E6700000000000000004C65
          66746C6F6E67000000000000000042746F6D6C6F6E67000002C5000000005267
          68746C6F6E670000135700000006736C69636573566C4C73000000014F626A63
          00000001000000000005736C6963650000001200000007736C69636549446C6F
          6E67000000000000000767726F757049446C6F6E6700000000000000066F7269
          67696E656E756D0000000C45536C6963654F726967696E0000000D6175746F47
          656E6572617465640000000054797065656E756D0000000A45536C6963655479
          706500000000496D672000000006626F756E64734F626A630000000100000000
          0000526374310000000400000000546F70206C6F6E6700000000000000004C65
          66746C6F6E67000000000000000042746F6D6C6F6E67000002C5000000005267
          68746C6F6E67000013570000000375726C54455854000000010000000000006E
          756C6C54455854000000010000000000004D7367655445585400000001000000
          000006616C74546167544558540000000100000000000E63656C6C5465787449
          7348544D4C626F6F6C010000000863656C6C5465787454455854000000010000
          00000009686F727A416C69676E656E756D0000000F45536C696365486F727A41
          6C69676E0000000764656661756C740000000976657274416C69676E656E756D
          0000000F45536C69636556657274416C69676E0000000764656661756C740000
          000B6267436F6C6F7254797065656E756D0000001145536C6963654247436F6C
          6F7254797065000000004E6F6E6500000009746F704F75747365746C6F6E6700
          0000000000000A6C6566744F75747365746C6F6E67000000000000000C626F74
          746F6D4F75747365746C6F6E67000000000000000B72696768744F7574736574
          6C6F6E6700000000003842494D042800000000000C000000013FF00000000000
          003842494D041100000000000101003842494D04140000000000040000000238
          42494D042100000000005500000001010000000F00410064006F006200650020
          00500068006F0074006F00730068006F00700000001300410064006F00620065
          002000500068006F0074006F00730068006F0070002000430053003200000001
          003842494D04060000000000070008010100010100FFE100D445786966000049
          492A0008000000070012010300010000000100DCCB1A01050001000000620000
          001B010500010000006A00000028010300010000000200CC98310102001C0000
          007200000032010200140000008E0000006987040001000000A2000000000000
          00C0C62D0010270000C0C62D001027000041646F62652050686F746F73686F70
          204353322057696E646F777300323030363A30323A30372031303A30363A3430
          00030001A0030001000000FFFFFFFF02A00400010000005713000003A0040001
          000000C502000000000000FFDB004300080606070605080707070909080A0C14
          0D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C
          30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832
          211C213232323232323232323232323232323232323232323232323232323232
          323232323232323232323232323232323232323232FFC0001108005900D80301
          2200021101031101FFC4001F0000010501010101010100000000000000000102
          030405060708090A0BFFC400B5100002010303020403050504040000017D0102
          0300041105122131410613516107227114328191A1082342B1C11552D1F02433
          627282090A161718191A25262728292A3435363738393A434445464748494A53
          5455565758595A636465666768696A737475767778797A838485868788898A92
          939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7
          C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FA
          FFC4001F0100030101010101010101010000000000000102030405060708090A
          0BFFC400B5110002010204040304070504040001027700010203110405213106
          1241510761711322328108144291A1B1C109233352F0156272D10A162434E125
          F11718191A262728292A35363738393A434445464748494A535455565758595A
          636465666768696A737475767778797A82838485868788898A92939495969798
          999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4
          D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002
          110311003F00F7FA28A0F4A0028A4A280168A4A5A0028A28A0028A3145001451
          4500145145001451450014518A2800A28A2800A28A2800A28A2800A28A2800A2
          8A2800A0F4A290F4A003B5140E951C92A4485A460AA3B9A4DA5B86BD0928CE05
          60DE789218B2B6EBE637AF6AC4B9D5EF2E4FCD31553D96B9E78A847637861E72
          3B09AFEDADFF00D6CC8BED9E6A8CBE23B38CFCA59FE95C7BB1639662C4FA9C9A
          9ADECAE6E88F26173EE460573BC55497C08DD61A11F8D9BAFE2AE7F776C48F77
          A81FC51727EE4283EA6A38BC3578E46F6441F5ABB1F85A3C7EF27663ED4D7D62
          42FF00674513E25BD3D163A41E24BEEE23AD65F0C59AF5790FE3520F0ED86394
          63FF000234FD9E23B8BDA50EC642F89AF01E638C8A997C5528FBF6EBF835689F
          0E581E88E3FE046A33E18B23D1A41FF02A39312BA873D07D08A3F14C2DFEB217
          4F7CE6AEC3AF58CAB9F37693D88AA4FE168083B66707DEAB49E16940CC7383EC
          455736223BA13541ECCE8E3BA8651FBB955BE86A60722B8D7D0B5184EE4E71FD
          D6A44BBD62C08DC25C0ECC3229AC4B5F1A27EAE9FC0CECE8CD735078A3042DD4
          3B7DC022B62D754B4BAFF573293E84F35BC6B425D4CA54A71DD17734B4D07233
          9A756A661451450014514500145145001487A52D326711C2CE7B0CD26EDA85AE
          53D43538B4F87739CB1E8A0F5AE42FB519EFA42D231099E141E94CBDBA7BDBC7
          95CE7B28F6AAFD39AF2EBD794A565B1E951A2A2AEC3D31DFD3BD685A68D7170A
          2472B0C23F89F8E2A7B1B6B7B4D3A6D5AF47EEA152E07D2BC863D7BC57F157C4
          ADA7D8DDB59E9C1B72AC49B7647D8B375CE315A50C3732E69135B12D7BB13DDA
          C6C34CB6E93432C9EACE0D6BAAA80368007B74AF247F828520DD6FE28D556EC7
          3BDA61B73F4C5755E08B4D77C3DE1FBC8BC49746E4DBBB3C7371968C0F4C5772
          8463A2470CA5296AD9D98E452E2BCBDFE37689F31834FBF9514E0BAC671FCAB7
          FC2DF12B41F165D9B3B291D2E80CF9720C135449D8E28AE2BC49F13745F0C6B6
          9A55F79DE7B286C85E0038E49FC6974FF89DE1ED53C4716896570D35C4838641
          95CE01C7EB4C0ED31462BCD2EFE3468B05CCD0C3637D3985CAB32467190707B5
          5FF0F7C58F0F7883524D3A3792DAE9F854986326803BBC515C978BBE20E93E0D
          96DE2D444C5E704AF96B9FCEB06FBE36F862D5A3588CD71B977131AF0BEC4FAD
          016B9E95C5040F4E3DEB07C39E2ED33C4FA47F69584C3CA04ABABF0C847AD45A
          8F8D746B085D8DE46F20E02061926B39D584776694A854AAFDC8B65BB9BBD3CE
          AB1E99244249E452F80BF747BD365F0E5A484B465A26EC41AE67C3DAC29BAB9D
          466D3AF64BBB96C96119C2AE7E5038C74AE8EF3C51A7E98B1FDB5CC324832232
          3E61F51DAB08CA94D7348EBAB42AC26A10571D1586A7607F73729347FDD7C83F
          9D5C8B5265212EA0789CF7EA0FE353595E417F6A9736D2ABC4FCAB03C5171796
          B6C84DC4D1C63FDB38AD945455D3D0E56E527CAD6A580E1864107E955EEAFE1B
          33109A4DA64708A3B934DB5B9B6B98FCCB59A375CF543915CCA31D7FC6BB81CD
          9698480474697A7E868954692E5D5B2A951E66F9F4495CEC413C669D4C1DA9F5
          A2300A28A298054572864B7741D4822A5A43D293575604EDA9E753C4F6D33C52
          0C3A93C7AD33A576BA968F0DF8DD9D92E38615CC5DE937766C7746593FBCB5E5
          55A1284AEB53D3A55A338D9BB32DEA10BEAFE02BEB3B5C99FC8640A3D6BC7FE0
          BEBF63A0788AEECB53716CF709B033701581E55BF2AF51B0D424D3E7DCB82ADC
          3213DAA9EB7F0CFC31E3191EFA169AC6F643B9DEDD872C7A92A47F222BB30F59
          4A3CAF467256A4E32E6398F881A6F8A7484BDD7EDFC545AC9E51B2DE295B383E
          98FA1AB9F0E3C5D716BF0DF59D675A9A7BC16B23F0E4B13C7DDE7DEACA7C0E8A
          44115DF8AB51B8B71C98B6003F526BAFD23E1E687A3F866EB41896592CEEB3E7
          79AC0B127B8C74AE9D4E7479EF86FC59E39F1C1BAFEC28B4CB0B180ED6129036
          E7A0C007B5721E0AFB4C7F196DD6EE446BA174C25688FC8C7BE3F5AF47B1F823
          67A7DE3BDB788B538AD9F868230A091E85BFFAD5A3A37C1FD2743F13C3ADDB6A
          176CD13EF5864C11F9E3268B0CF36F8C08B2FC4DB4898128CB1AB0CF505866BD
          9EC3C3BE1DF0F69916A10699042D6F0890CA918DF8C64F3DEB2BC51F0B74EF14
          788E2D6AE6FEE61963DB88D1415E0E6BB636B19B2FB238DD1F97E5907B8C6280
          3C5B42F1E78A7C69ACCF65E16B7B0D3ED53E7DD3100EDFC01AE375AB6D42D7E2
          B5A47AADCDB4F79E746CF25BFDDFFF005D7A6AFC12B3B4D55AEF4CD7F50B28E4
          277451AA938CF4DDFF00D6AB2DF063483AE5BEA8BA95F078983ED7DADBC8EE4D
          00721F1FB2351D2C8E3E535D7EA9A36987E0D926CE152B682452106777AE6B5F
          C6FF000E2C7C6F35B4B777B716ED00C0F28039FAE6B6A7F0E4171E156D00CD20
          84C3E4F9981B80A00F20F825676D7FA0EB36F7C336E482DCE31C7FFAEBBCF0DF
          85B4F975297544B6D96ABF2DB29FFD088A9FC2DF0DAC7C29A65FD8DBDEDC5C47
          78A55CB800804638C569DAE83A9D95B2DBC1AD910A0C286B70481F9FF4AC2AD3
          BCD3B5EC76E1EBCA149C54ED7F5FD0D8BABB82C2DA496570AB1A96393DABCC74
          C0FE256B9FB2424DC5CBEEB8BB9461638F3F757DEBB06F065BDD876BDD42F677
          9061FE70A0FE18E2996DE04B3B30EB6B7F7B0C6C72C88E307F4ACAB53AB36B4D
          0E8C355C3D084AD27CEFCB41757D46D7C25E18F26CDD04D1A6C893209CFA9FC6
          AA693E0DB7BC45BFD748BCBB9577104E5533CF15AA3C1FA51B7921963795A418
          6924725AA287C39A9DA288ADF5F9D605E151E156207A66A9D39735DC6EBD498E
          229C69B8D39DA4DEADAD5FA6E61788A6D23C1B04ABA54623BFB9006D53F747A9
          A5F0DF8B343D2F4DB5B322E50BE374CD090A643D493F526B613C0F632EA5F6FB
          F9E6BC9318DB291B7F4AD8BDD174FBED3CD94B6E82265DA028C6DF4C542A5554
          DCD69E4693C4E19D354E57937BBFEBB17A3759115A320A9190454A2B97D3B41D
          5B4FC5BA6AE5ACD4FCA1A205F1E99CD74E8085009CF1D6BAE0E4D6AAC7995610
          83F725743A8A28AB320A28A2800A42A08208C83EB4B4500529F4BB39C1DF0A64
          F702A8FF00C23C90CA25B49A485C77CE456DD159BA507AD8B5524BA9040B3246
          04CE1DBD40A9E8A2AD2B221EA18A314514C028C51450026051814B4500149814
          B450026051B6968A004DA28DA2968A004DA28DA2968A004C50452D1400DDB4EA
          28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A
          28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00FFF
          D9}
        mmHeight = 33602
        mmLeft = 132557
        mmTop = 46038
        mmWidth = 59796
        BandType = 8
      end
      object ppLabel19: TppLabel
        UserName = 'Label19'
        Caption = 'Programa de Garantias garantido por:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8731
        mmLeft = 142082
        mmTop = 40746
        mmWidth = 41010
        BandType = 8
      end
      object ppLabel43: TppLabel
        UserName = 'Label43'
        Caption = 'Garantias Extended providas por:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Tahoma'
        Font.Size = 10
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8636
        mmLeft = 11266
        mmTop = 40746
        mmWidth = 34883
        BandType = 8
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppGarantias: TppDBPipeline
    DataSource = dsForm
    UserName = 'Garantias'
    Left = 128
    Top = 184
  end
  object dsForm: TDataSource
    DataSet = cdsForm
    Left = 224
    Top = 192
  end
  object cdsForm: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDateTime
        Name = 'DataInicial'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DataFinal'
        ParamType = ptInput
      end>
    ProviderName = 'dspForm'
    Left = 224
    Top = 132
    object cdsFormMovDate: TDateTimeField
      FieldName = 'MovDate'
      ReadOnly = True
    end
    object cdsFormStoreID: TIntegerField
      FieldName = 'StoreID'
      ReadOnly = True
    end
    object cdsFormSequencyNum: TIntegerField
      FieldName = 'SequencyNum'
      ReadOnly = True
    end
    object cdsFormSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = 'R$ #,##0.00'
      Precision = 19
    end
    object cdsFormQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
    end
    object cdsFormIDPreInvMovExchange: TIntegerField
      FieldName = 'IDPreInvMovExchange'
      ReadOnly = True
    end
    object cdsFormModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsFormDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsFormFabricante: TStringField
      FieldName = 'Fabricante'
      ReadOnly = True
      Size = 50
    end
    object cdsFormSerialNumber: TStringField
      FieldName = 'SerialNumber'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object cdsFormValorProduto: TBCDField
      FieldName = 'ValorProduto'
      DisplayFormat = 'R$ #,##0.00'
      Precision = 19
    end
    object cdsFormGarantiaTipo: TStringField
      FieldName = 'GarantiaTipo'
      Size = 6
    end
    object cdsFormGarantiaMeses: TIntegerField
      FieldName = 'GarantiaMeses'
    end
    object cdsFormGarantiaFabrica: TIntegerField
      FieldName = 'GarantiaFabrica'
    end
    object cdsFormDescProduto: TStringField
      FieldName = 'DescProduto'
      Size = 50
    end
    object cdsFormDocumento: TStringField
      FieldName = 'Documento'
      ReadOnly = True
      Size = 30
    end
    object cdsFormFormaPagamento: TStringField
      FieldName = 'FormaPagamento'
      ReadOnly = True
      Size = 30
    end
    object cdsFormInicioVigencia: TDateTimeField
      FieldName = 'InicioVigencia'
    end
    object cdsFormTerminoVigencia: TDateTimeField
      FieldName = 'TerminoVigencia'
    end
    object cdsFormLoja: TStringField
      FieldName = 'Loja'
      ReadOnly = True
      Size = 30
    end
    object cdsFormNome: TStringField
      FieldName = 'Nome'
      ReadOnly = True
      Size = 50
    end
    object cdsFormEndereco: TStringField
      FieldName = 'Endereco'
      ReadOnly = True
      Size = 80
    end
    object cdsFormBairro: TStringField
      FieldName = 'Bairro'
      ReadOnly = True
      Size = 50
    end
    object cdsFormCEP: TStringField
      FieldName = 'CEP'
      ReadOnly = True
      FixedChar = True
      Size = 12
    end
    object cdsFormCidade: TStringField
      FieldName = 'Cidade'
      ReadOnly = True
      Size = 40
    end
    object cdsFormUF: TStringField
      FieldName = 'UF'
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
    object cdsFormCidadeUFCEP: TStringField
      FieldName = 'CidadeUFCEP'
      ReadOnly = True
      Size = 61
    end
    object cdsFormDataNascimento: TDateTimeField
      FieldName = 'DataNascimento'
      ReadOnly = True
    end
    object cdsFormCPF: TStringField
      FieldName = 'CPF'
      ReadOnly = True
      Size = 30
    end
    object cdsFormIdentidade: TStringField
      FieldName = 'Identidade'
      ReadOnly = True
      Size = 30
    end
    object cdsFormIdentidadeOrgaoEmissor: TStringField
      FieldName = 'IdentidadeOrgaoEmissor'
      ReadOnly = True
      Size = 50
    end
    object cdsFormIdentidadeDataExpedicao: TDateTimeField
      FieldName = 'IdentidadeDataExpedicao'
      ReadOnly = True
    end
    object cdsFormIdentidadeExpedicaoOrgao: TStringField
      FieldName = 'IdentidadeExpedicaoOrgao'
      ReadOnly = True
      Size = 83
    end
    object cdsFormTelefone: TStringField
      FieldName = 'Telefone'
      ReadOnly = True
      Size = 45
    end
    object cdsFormCelular: TStringField
      FieldName = 'Celular'
      ReadOnly = True
      Size = 23
    end
    object cdsFormSaleCode: TStringField
      FieldName = 'SaleCode'
      ReadOnly = True
    end
    object cdsFormInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
    end
    object cdsFormIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
    end
    object cdsFormIDPreSaleParent: TIntegerField
      FieldName = 'IDPreSaleParent'
    end
    object cdsFormNotaFiscalProduto: TStringField
      FieldName = 'NotaFiscalProduto'
      Size = 30
    end
    object cdsFormDataEnvio: TDateTimeField
      FieldName = 'DataEnvio'
    end
    object cdsFormIDModelGarantia: TIntegerField
      FieldName = 'IDModelGarantia'
    end
    object cdsFormIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsFormChecado: TBooleanField
      FieldName = 'Checado'
    end
  end
end
