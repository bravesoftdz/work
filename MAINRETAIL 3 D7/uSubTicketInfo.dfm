inherited SubTicketInfo: TSubTicketInfo
  Left = 482
  Top = 348
  Width = 504
  Height = 392
  BorderIcons = [biSystemMenu]
  Caption = 'Ticket Info'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgTicket: TPageControl [0]
    Left = 0
    Top = 0
    Width = 496
    Height = 365
    ActivePage = tsHeader
    Align = alClient
    TabOrder = 0
    object tsHeader: TTabSheet
      Caption = 'Header'
      object Label13: TLabel
        Left = 5
        Top = 1
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 5
        Top = 16
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object memHeader: TDBMemo
        Left = 5
        Top = 34
        Width = 366
        Height = 292
        DataField = 'TicketHeader'
        DataSource = dsStore
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object DBCheckBox1: TDBCheckBox
        Left = 380
        Top = 36
        Width = 112
        Height = 17
        Caption = 'Print Header'
        DataField = 'PrintTicketHeader'
        DataSource = dsStore
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object Panel2: TPanel
        Left = 372
        Top = 60
        Width = 115
        Height = 266
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 2
        DesignSize = (
          115
          266)
        object Label11: TLabel
          Left = 0
          Top = 0
          Width = 115
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Insert'
          Color = clBtnShadow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object btnDateH: TSpeedButton
          Left = 2
          Top = 20
          Width = 111
          Height = 22
          BiDiMode = bdLeftToRight
          Caption = '[date]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentBiDiMode = False
          OnClick = btnDateHClick
        end
        object btnTimeH: TSpeedButton
          Left = 2
          Top = 44
          Width = 111
          Height = 22
          Caption = '[time]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnTimeHClick
        end
        object SpeedButton9: TSpeedButton
          Tag = 5
          Left = 2
          Top = 236
          Width = 111
          Height = 26
          Anchors = [akLeft, akBottom]
          Caption = '&Preview'
          Flat = True
          Glyph.Data = {
            06050000424D0605000000000000360000002800000012000000160000000100
            180000000000D004000000000000000000000000000000000000FF00FFA47874
            A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
            74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
            CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
            D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
            E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
            000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
            FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
            3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
            BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
            ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
            DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
            E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
            0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
            FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
            F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
            F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
            EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
            A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
            E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
            0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
            FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
            F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
            E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
            FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
            9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
            F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
            0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
            FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
            FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
            A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
            8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
            FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
            0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
            FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
            FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
            CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
            87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
            00FFFF00FFFF00FF0000}
          Margin = 5
          Spacing = 7
          OnClick = btPrintClick
        end
        object btnCustomerH: TSpeedButton
          Left = 2
          Top = 69
          Width = 111
          Height = 22
          Caption = '[customer]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnCustomerHClick
        end
        object btnMediaH: TSpeedButton
          Left = 3
          Top = 94
          Width = 111
          Height = 22
          Caption = '[media]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnMediaHClick
        end
        object btnCashier: TSpeedButton
          Left = 4
          Top = 119
          Width = 111
          Height = 22
          Caption = '[cashier]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnCashierClick
        end
        object btnHoldH: TSpeedButton
          Left = 4
          Top = 144
          Width = 111
          Height = 22
          Caption = '[hold #]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnHoldHClick
        end
        object btnInvoiceH: TSpeedButton
          Left = 4
          Top = 168
          Width = 111
          Height = 22
          Caption = '[Invoice #]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnInvoiceHClick
        end
        object btRestoreHeader: TSpeedButton
          Tag = 6
          Left = 2
          Top = 211
          Width = 111
          Height = 25
          Caption = '&Restore'
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360000002800000015000000140000000100
            18000000000000050000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAD55
            29BD5900A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD795ABD59
            00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA53C
            08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFA53C08CE6500CE6500BD5900B56542FF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFAD4900CE6500CE6500A53C08FF00FFFF00FF00B56542BD5900
            BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900A53C08FF00
            FFFF00FFFF00FFB56542BD5900CE6500CE6500AD5529FF00FF00B56542CE6500
            CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500BD5900FF00
            FFFF00FFFF00FFFF00FFA53C08CE6500CE6500AD4900FF00FF00B56542E77D00
            E77D00CE6500CE6500BD5900AD4900AD4900AD4900AD4900AD4900A53C08FF00
            FFFF00FFFF00FFFF00FFB58273BD5900CE6500BD5900BD795A00B56542E77D00
            E77D00E77D00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542E77D00
            E77D00E77D00E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            E77D00AD4900AD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFB56542CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFAD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFFF00FFBD5900E77D00E77D00E77D00A53C08CE9A84FF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542FFB24A
            FF9A08AD4900FF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00BD5900AD55
            29FF00FFFF00FFFF00FFA53C08CE6500CE6500BD5900BD795A00B56542FFB24A
            FFB24AAD4900FF00FFFF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00E77D
            00BD5900BD5900BD5900CE6500CE6500CE6500A53C08FF00FF00B56542FFB24A
            FFC77BAD4900FF00FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500E77D00E77D
            00E77D00E77D00E77D00CE6500CE6500A53C08FF00FFFF00FF00FF00FFAD5529
            AD4900FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9A84AD4900CE65
            00CE6500E77D00CE6500BD5900A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFD69263B56542BD795AFF00FFFF00FFFF00FFFF00FFFF00FF00}
          Margin = 6
          Spacing = 6
          OnClick = btRestoreHeaderClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Detail'
      ImageIndex = 1
      object Label3: TLabel
        Left = 5
        Top = 1
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 5
        Top = 16
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object memDetail: TDBMemo
        Left = 5
        Top = 34
        Width = 366
        Height = 303
        DataField = 'TicketDetail'
        DataSource = dsStore
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pnlbtnDetail: TPanel
        Left = 372
        Top = 3
        Width = 115
        Height = 338
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 1
        DesignSize = (
          115
          338)
        object Label9: TLabel
          Left = 0
          Top = 0
          Width = 115
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Insert'
          Color = clBtnShadow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object btnModelD: TSpeedButton
          Left = 2
          Top = 20
          Width = 111
          Height = 18
          BiDiMode = bdLeftToRight
          Caption = '[model]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentBiDiMode = False
          OnClick = btnModelDClick
        end
        object btnDescD: TSpeedButton
          Left = 2
          Top = 40
          Width = 111
          Height = 18
          Caption = '[description]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnDescDClick
        end
        object btnSPD: TSpeedButton
          Left = 2
          Top = 60
          Width = 111
          Height = 18
          Hint = 'Sales person number'
          Caption = '[sales person]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSPDClick
        end
        object btnBarcodeD: TSpeedButton
          Left = 2
          Top = 100
          Width = 111
          Height = 18
          Caption = '[barcode]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnBarcodeDClick
        end
        object btnSerialNumD: TSpeedButton
          Left = 2
          Top = 121
          Width = 111
          Height = 18
          Caption = '[Serial Number]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSerialNumDClick
        end
        object btnQtyD: TSpeedButton
          Left = 2
          Top = 142
          Width = 111
          Height = 18
          Caption = '[quantity]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnQtyDClick
        end
        object btnUnitPriceD: TSpeedButton
          Left = 2
          Top = 163
          Width = 111
          Height = 18
          Caption = '[unit price]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUnitPriceDClick
        end
        object btnUnitTotal: TSpeedButton
          Left = 2
          Top = 184
          Width = 111
          Height = 18
          Caption = '[total price]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUnitTotalClick
        end
        object btPrint: TSpeedButton
          Tag = 5
          Left = 2
          Top = 308
          Width = 111
          Height = 26
          Anchors = [akLeft, akBottom]
          Caption = '&Preview'
          Flat = True
          Glyph.Data = {
            06050000424D0605000000000000360000002800000012000000160000000100
            180000000000D004000000000000000000000000000000000000FF00FFA47874
            A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
            74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
            CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
            D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
            E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
            000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
            FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
            3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
            BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
            ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
            DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
            E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
            0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
            FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
            F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
            F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
            EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
            A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
            E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
            0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
            FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
            F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
            E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
            FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
            9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
            F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
            0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
            FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
            FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
            A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
            8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
            FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
            0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
            FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
            FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
            CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
            87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
            00FFFF00FFFF00FF0000}
          Margin = 5
          Spacing = 7
          OnClick = btPrintClick
        end
        object btnSPNumberD: TSpeedButton
          Left = 2
          Top = 80
          Width = 111
          Height = 18
          Hint = 'Sales person number'
          Caption = '[sales person #]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSPNumberDClick
        end
        object btnRightD: TSpeedButton
          Left = 2
          Top = 205
          Width = 111
          Height = 18
          Caption = '[right]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnRightDClick
        end
        object btRestoreDetail: TSpeedButton
          Tag = 6
          Left = 2
          Top = 282
          Width = 111
          Height = 25
          Caption = '&Restore'
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360000002800000015000000140000000100
            18000000000000050000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAD55
            29BD5900A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD795ABD59
            00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA53C
            08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFA53C08CE6500CE6500BD5900B56542FF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFAD4900CE6500CE6500A53C08FF00FFFF00FF00B56542BD5900
            BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900A53C08FF00
            FFFF00FFFF00FFB56542BD5900CE6500CE6500AD5529FF00FF00B56542CE6500
            CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500BD5900FF00
            FFFF00FFFF00FFFF00FFA53C08CE6500CE6500AD4900FF00FF00B56542E77D00
            E77D00CE6500CE6500BD5900AD4900AD4900AD4900AD4900AD4900A53C08FF00
            FFFF00FFFF00FFFF00FFB58273BD5900CE6500BD5900BD795A00B56542E77D00
            E77D00E77D00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542E77D00
            E77D00E77D00E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            E77D00AD4900AD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFB56542CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFAD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFFF00FFBD5900E77D00E77D00E77D00A53C08CE9A84FF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542FFB24A
            FF9A08AD4900FF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00BD5900AD55
            29FF00FFFF00FFFF00FFA53C08CE6500CE6500BD5900BD795A00B56542FFB24A
            FFB24AAD4900FF00FFFF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00E77D
            00BD5900BD5900BD5900CE6500CE6500CE6500A53C08FF00FF00B56542FFB24A
            FFC77BAD4900FF00FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500E77D00E77D
            00E77D00E77D00E77D00CE6500CE6500A53C08FF00FFFF00FF00FF00FFAD5529
            AD4900FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9A84AD4900CE65
            00CE6500E77D00CE6500BD5900A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFD69263B56542BD795AFF00FFFF00FFFF00FFFF00FFFF00FF00}
          Margin = 6
          Spacing = 6
          OnClick = btRestoreDetailClick
        end
        object btnManufacturer: TSpeedButton
          Left = 3
          Top = 224
          Width = 111
          Height = 18
          Caption = '[manufacturer]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnManufacturerClick
        end
        object btnUnit: TSpeedButton
          Left = 3
          Top = 243
          Width = 111
          Height = 18
          Caption = '[unit]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUnitClick
        end
        object btnCategText: TSpeedButton
          Left = 3
          Top = 262
          Width = 111
          Height = 18
          Caption = '[Cat. Note]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCategTextClick
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Totals'
      ImageIndex = 5
      object Label7: TLabel
        Left = 5
        Top = 1
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 5
        Top = 16
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object memTotals: TDBMemo
        Left = 5
        Top = 34
        Width = 366
        Height = 292
        DataField = 'TicketTotals'
        DataSource = dsStore
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 372
        Top = 3
        Width = 115
        Height = 323
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 1
        DesignSize = (
          115
          323)
        object Label10: TLabel
          Left = 0
          Top = 0
          Width = 115
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Insert'
          Color = clBtnShadow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object btnNoTaxableT: TSpeedButton
          Left = 2
          Top = 20
          Width = 111
          Height = 18
          BiDiMode = bdLeftToRight
          Caption = '[non taxable]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentBiDiMode = False
          OnClick = btnNoTaxableTClick
        end
        object btnTaxableT: TSpeedButton
          Left = 2
          Top = 40
          Width = 111
          Height = 18
          Caption = '[taxable]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          OnClick = btnTaxableTClick
        end
        object btnTaxT: TSpeedButton
          Left = 2
          Top = 60
          Width = 111
          Height = 18
          Hint = 'Sales person number'
          Caption = '[tax]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnTaxTClick
        end
        object btnTotalT: TSpeedButton
          Left = 2
          Top = 100
          Width = 111
          Height = 18
          Caption = '[total]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnTotalTClick
        end
        object btnCashRecT: TSpeedButton
          Left = 2
          Top = 120
          Width = 111
          Height = 18
          Caption = '[cash]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCashRecTClick
        end
        object btnChangeT: TSpeedButton
          Left = 2
          Top = 140
          Width = 111
          Height = 18
          Caption = '[change]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnChangeTClick
        end
        object btnDiscount: TSpeedButton
          Left = 2
          Top = 181
          Width = 111
          Height = 18
          Caption = '[invoice discount]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDiscountClick
        end
        object SpeedButton10: TSpeedButton
          Tag = 5
          Left = 2
          Top = 293
          Width = 111
          Height = 26
          Anchors = [akLeft, akBottom]
          Caption = '&Preview'
          Flat = True
          Glyph.Data = {
            06050000424D0605000000000000360000002800000012000000160000000100
            180000000000D004000000000000000000000000000000000000FF00FFA47874
            A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
            74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
            CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
            D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
            E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
            000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
            FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
            3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
            BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
            ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
            DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
            E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
            0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
            FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
            F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
            F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
            EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
            A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
            E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
            0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
            FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
            F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
            E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
            FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
            9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
            F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
            0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
            FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
            FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
            A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
            8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
            FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
            0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
            FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
            FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
            CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
            87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
            00FFFF00FFFF00FF0000}
          Margin = 5
          Spacing = 7
          OnClick = btPrintClick
        end
        object btnPayDateT: TSpeedButton
          Left = 2
          Top = 201
          Width = 111
          Height = 18
          Caption = '[date_type_$]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnPayDateTClick
        end
        object SpeedButton4: TSpeedButton
          Left = 3
          Top = 221
          Width = 111
          Height = 18
          Caption = '[right]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton4Click
        end
        object btRestoreTotal: TSpeedButton
          Tag = 6
          Left = 2
          Top = 268
          Width = 111
          Height = 25
          Caption = '&Restore'
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360000002800000015000000140000000100
            18000000000000050000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAD55
            29BD5900A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD795ABD59
            00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA53C
            08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFA53C08CE6500CE6500BD5900B56542FF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFAD4900CE6500CE6500A53C08FF00FFFF00FF00B56542BD5900
            BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900A53C08FF00
            FFFF00FFFF00FFB56542BD5900CE6500CE6500AD5529FF00FF00B56542CE6500
            CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500BD5900FF00
            FFFF00FFFF00FFFF00FFA53C08CE6500CE6500AD4900FF00FF00B56542E77D00
            E77D00CE6500CE6500BD5900AD4900AD4900AD4900AD4900AD4900A53C08FF00
            FFFF00FFFF00FFFF00FFB58273BD5900CE6500BD5900BD795A00B56542E77D00
            E77D00E77D00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542E77D00
            E77D00E77D00E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            E77D00AD4900AD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFB56542CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFAD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFFF00FFBD5900E77D00E77D00E77D00A53C08CE9A84FF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542FFB24A
            FF9A08AD4900FF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00BD5900AD55
            29FF00FFFF00FFFF00FFA53C08CE6500CE6500BD5900BD795A00B56542FFB24A
            FFB24AAD4900FF00FFFF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00E77D
            00BD5900BD5900BD5900CE6500CE6500CE6500A53C08FF00FF00B56542FFB24A
            FFC77BAD4900FF00FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500E77D00E77D
            00E77D00E77D00E77D00CE6500CE6500A53C08FF00FFFF00FF00FF00FFAD5529
            AD4900FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9A84AD4900CE65
            00CE6500E77D00CE6500BD5900A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFD69263B56542BD795AFF00FFFF00FFFF00FFFF00FFFF00FF00}
          Margin = 6
          Spacing = 6
          OnClick = btRestoreTotalClick
        end
        object btnRefund: TSpeedButton
          Left = 3
          Top = 241
          Width = 111
          Height = 18
          Caption = '[refund]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnRefundClick
        end
        object btnItemDiscount: TSpeedButton
          Left = 2
          Top = 160
          Width = 111
          Height = 18
          Caption = '[item discount]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnItemDiscountClick
        end
        object btnSubTotal: TSpeedButton
          Left = 2
          Top = 80
          Width = 111
          Height = 18
          Caption = '[subtotal]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSubTotalClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Footer'
      ImageIndex = 2
      DesignSize = (
        488
        337)
      object Label1: TLabel
        Left = 5
        Top = 1
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 16
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object SpeedButton1: TSpeedButton
        Tag = 5
        Left = 376
        Top = 302
        Width = 110
        Height = 26
        Anchors = [akLeft, akBottom]
        Caption = '&Preview'
        Flat = True
        Glyph.Data = {
          06050000424D0605000000000000360000002800000012000000160000000100
          180000000000D004000000000000000000000000000000000000FF00FFA47874
          A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
          74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
          CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
          D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
          E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
          000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
          FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
          3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
          BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
          ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
          DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
          E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
          0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
          FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
          F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
          F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
          EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
          A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
          E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
          0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
          FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
          F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
          E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
          FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
          9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
          F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
          0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
          FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
          FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
          A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
          8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
          FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
          0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
          FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
          FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
          CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
          87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
          00FFFF00FFFF00FF0000}
        Margin = 5
        Spacing = 7
        OnClick = btPrintClick
      end
      object DBMemo4: TDBMemo
        Left = 5
        Top = 40
        Width = 366
        Height = 286
        DataField = 'TicketFooter'
        DataSource = dsStore
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object DBCheckBox2: TDBCheckBox
        Left = 377
        Top = 40
        Width = 107
        Height = 17
        Caption = 'Print Footer'
        DataField = 'PrintTicketFooter'
        DataSource = dsStore
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Layaway Footer'
      ImageIndex = 3
      object Label16: TLabel
        Left = 5
        Top = 3
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 5
        Top = 18
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object memLayaway: TDBMemo
        Left = 5
        Top = 40
        Width = 366
        Height = 286
        DataField = 'TicketLayawayFooter'
        DataSource = dsStore
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object DBCheckBox3: TDBCheckBox
        Left = 376
        Top = 40
        Width = 118
        Height = 17
        Caption = 'Print Footer'
        DataField = 'PrintLayawayFooter'
        DataSource = dsStore
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object Panel3: TPanel
        Left = 372
        Top = 60
        Width = 115
        Height = 266
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 2
        DesignSize = (
          115
          266)
        object Label15: TLabel
          Left = 0
          Top = 0
          Width = 115
          Height = 16
          Align = alTop
          Alignment = taCenter
          Caption = 'Insert'
          Color = clBtnShadow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindow
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Visible = False
        end
        object btnPayTotalL: TSpeedButton
          Left = 2
          Top = 20
          Width = 111
          Height = 22
          BiDiMode = bdLeftToRight
          Caption = '[payment_totals]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          ParentBiDiMode = False
          Visible = False
          OnClick = btnPayTotalLClick
        end
        object btnPayBalL: TSpeedButton
          Left = 2
          Top = 44
          Width = 111
          Height = 22
          Caption = '[pay_balance]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Margin = 5
          ParentFont = False
          Visible = False
          OnClick = btnPayBalLClick
        end
        object SpeedButton3: TSpeedButton
          Tag = 5
          Left = 2
          Top = 236
          Width = 111
          Height = 26
          Anchors = [akLeft, akBottom]
          Caption = '&Preview'
          Flat = True
          Glyph.Data = {
            06050000424D0605000000000000360000002800000012000000160000000100
            180000000000D004000000000000000000000000000000000000FF00FFA47874
            A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
            74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
            CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
            D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
            E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
            000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
            FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
            3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
            BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
            ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
            DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
            E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
            0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
            FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
            F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
            F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
            EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
            A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
            E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
            0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
            FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
            F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
            E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
            FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
            9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
            F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
            0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
            FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
            FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
            A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
            FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
            8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
            FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
            0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
            FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
            FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
            CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
            87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
            00FFFF00FFFF00FF0000}
          Margin = 5
          Spacing = 7
          OnClick = SpeedButton3Click
        end
        object btRestoreLayaway: TSpeedButton
          Tag = 6
          Left = 2
          Top = 211
          Width = 111
          Height = 25
          Caption = '&Restore'
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360000002800000015000000140000000100
            18000000000000050000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAD55
            29BD5900A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD795ABD59
            00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA53C
            08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFA53C08CE6500CE6500CE6500A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFA53C08CE6500CE6500BD5900B56542FF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFAD4900CE6500CE6500A53C08FF00FFFF00FF00B56542BD5900
            BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900BD5900A53C08FF00
            FFFF00FFFF00FFB56542BD5900CE6500CE6500AD5529FF00FF00B56542CE6500
            CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500CE6500BD5900FF00
            FFFF00FFFF00FFFF00FFA53C08CE6500CE6500AD4900FF00FF00B56542E77D00
            E77D00CE6500CE6500BD5900AD4900AD4900AD4900AD4900AD4900A53C08FF00
            FFFF00FFFF00FFFF00FFB58273BD5900CE6500BD5900BD795A00B56542E77D00
            E77D00E77D00CE6500CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542E77D00
            E77D00E77D00E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            E77D00AD4900AD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFB56542CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFAD4900E77D00E77D00CE6500A53C08FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500CE6500AD490000B56542FF9A08
            FF9A08AD4900FF00FFFF00FFBD5900E77D00E77D00E77D00A53C08CE9A84FF00
            FFFF00FFFF00FFFF00FFFF00FFAD4900CE6500CE6500A53C0800B56542FFB24A
            FF9A08AD4900FF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00BD5900AD55
            29FF00FFFF00FFFF00FFA53C08CE6500CE6500BD5900BD795A00B56542FFB24A
            FFB24AAD4900FF00FFFF00FFFF00FFFF00FFAD4900E77D00E77D00E77D00E77D
            00BD5900BD5900BD5900CE6500CE6500CE6500A53C08FF00FF00B56542FFB24A
            FFC77BAD4900FF00FFFF00FFFF00FFFF00FFFF00FFAD5529CE6500E77D00E77D
            00E77D00E77D00E77D00CE6500CE6500A53C08FF00FFFF00FF00FF00FFAD5529
            AD4900FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9A84AD4900CE65
            00CE6500E77D00CE6500BD5900A53C08FF00FFFF00FFFF00FF00FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFD69263B56542BD795AFF00FFFF00FFFF00FFFF00FFFF00FF00}
          Margin = 6
          Spacing = 6
          OnClick = btRestoreLayawayClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Exempt Tax Footer'
      ImageIndex = 4
      DesignSize = (
        488
        337)
      object Label18: TLabel
        Left = 6
        Top = 3
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label17: TLabel
        Left = 6
        Top = 18
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 5
        Top = 1
        Width = 296
        Height = 13
        Caption = '1       10       20       30       40'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 5
        Top = 16
        Width = 336
        Height = 13
        Caption = '|---+----|---+----|---+----|---+----|---+-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
      end
      object SpeedButton2: TSpeedButton
        Tag = 5
        Left = 376
        Top = 302
        Width = 108
        Height = 26
        Anchors = [akLeft, akBottom]
        Caption = '&Preview'
        Flat = True
        Glyph.Data = {
          06050000424D0605000000000000360000002800000012000000160000000100
          180000000000D004000000000000000000000000000000000000FF00FFA47874
          A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
          74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
          CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
          D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
          E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
          000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
          FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
          3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
          BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
          ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
          DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
          E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
          0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
          FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
          F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
          F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
          EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
          A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
          E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
          0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
          FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
          F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
          E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
          FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
          9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
          F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
          0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
          FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
          FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
          A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
          FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
          8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
          FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
          0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
          FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
          FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
          CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
          87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
          00FFFF00FFFF00FF0000}
        Margin = 5
        Spacing = 7
        OnClick = SpeedButton2Click
      end
      object DBMemo3: TDBMemo
        Left = 5
        Top = 35
        Width = 366
        Height = 291
        DataField = 'TicketTaxIsemptFooter'
        DataSource = dsStore
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object DBCheckBox4: TDBCheckBox
        Left = 376
        Top = 36
        Width = 120
        Height = 17
        Caption = 'Print Footer'
        DataField = 'PrintTaxInsemptFooter'
        DataSource = dsStore
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
  end
  object quStore: TPowerADOQuery [1]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    BeforeClose = quStoreBeforeClose
    CommandText = 
      'SELECT'#13#10'        TicketHeader,'#13#10'        TicketLayawayFooter,'#13#10'   ' +
      '     TicketTaxIsemptFooter,'#13#10'        TicketDetail,'#13#10'        Tick' +
      'etTotals,'#13#10#9'TicketFooter,'#13#10#9'PrintTicketHeader,'#13#10#9'PrintLayawayFoo' +
      'ter,'#13#10#9'PrintTaxInsemptFooter,'#13#10#9'PrintTicketFooter'#13#10'FROM'#13#10'       ' +
      ' Store Store (NOLOCK)'#13#10'WHERE'#13#10'        (IDStore = :IDStore)'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 74
    Top = 69
    object quStoreTicketHeader: TMemoField
      FieldName = 'TicketHeader'
      BlobType = ftMemo
    end
    object quStoreTicketLayawayFooter: TMemoField
      FieldName = 'TicketLayawayFooter'
      BlobType = ftMemo
    end
    object quStoreTicketTaxIsemptFooter: TMemoField
      FieldName = 'TicketTaxIsemptFooter'
      BlobType = ftMemo
    end
    object quStoreTicketFooter: TMemoField
      FieldName = 'TicketFooter'
      BlobType = ftMemo
    end
    object quStorePrintTicketHeader: TBooleanField
      FieldName = 'PrintTicketHeader'
    end
    object quStorePrintLayawayFooter: TBooleanField
      FieldName = 'PrintLayawayFooter'
    end
    object quStorePrintTaxInsemptFooter: TBooleanField
      FieldName = 'PrintTaxInsemptFooter'
    end
    object quStorePrintTicketFooter: TBooleanField
      FieldName = 'PrintTicketFooter'
    end
    object quStoreTicketDetail: TMemoField
      FieldName = 'TicketDetail'
      BlobType = ftMemo
    end
    object quStoreTicketTotals: TMemoField
      FieldName = 'TicketTotals'
      BlobType = ftMemo
    end
  end
  object dsStore: TDataSource [2]
    DataSet = quStore
    Left = 77
    Top = 16
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubTicketInfo.sil'
  end
end
