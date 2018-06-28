inherited FrmShippingDistrubSale: TFrmShippingDistrubSale
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Shipping Distrubution Sale'
  ClientHeight = 710
  ClientWidth = 1016
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel [0]
    Left = 0
    Top = 53
    Width = 1016
    Height = 117
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object lbBillTo: TLabel
      Left = 26
      Top = 4
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bill to :'
    end
    object lbDate: TLabel
      Left = 823
      Top = 8
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Hold date :'
    end
    object lbHoldNum: TLabel
      Left = 807
      Top = 55
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'Hold Number :'
    end
    object lbShipVia: TLabel
      Left = 389
      Top = 80
      Width = 39
      Height = 13
      Caption = 'Ship Via'
    end
    object lbShipDate: TLabel
      Left = 531
      Top = 80
      Width = 47
      Height = 13
      Caption = 'Ship Date'
    end
    object Label2: TLabel
      Left = 626
      Top = 79
      Width = 42
      Height = 13
      Caption = 'Tracking'
    end
    object Bevel12: TBevel
      Left = 388
      Top = 92
      Width = 364
      Height = 5
      Shape = bsTopLine
    end
    object lbSaleCode: TDBText
      Left = 879
      Top = 55
      Width = 65
      Height = 13
      AutoSize = True
      DataField = 'SaleCode'
      DataSource = dsPreSaleInfo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbMidia: TLabel
      Left = 840
      Top = 34
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Media :'
    end
    object btnSearchCustomer: TSpeedButton
      Left = 28
      Top = 19
      Width = 26
      Height = 25
      Flat = True
      Glyph.Data = {
        F6030000424DF603000000000000360000002800000010000000140000000100
        180000000000C003000000000000000000000000000000000000FFFFFFFFFFFF
        4A494A4A494A4A494A4A494A4A494A4A494A4A494A4A494A4A494A4A494AFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF4A494A18961829AE2931B63142BE424ABE4A4A
        BE4A08710839B639218E21218E214A494A4A494AFFFFFFFFFFFF18961818A618
        29AE2939B6394ABE4A52C7525ACF5A299629B5D79C42B6424AC74A42BE4231B6
        311879184A494AFFFFFF18961829A62939B6394ABE4A5ACF5A63CF635ABE5A9C
        C78CFFFFF7298E2963CF6352C75242BE4229A629393821FFFFFFFFFFFF189618
        4ABE4A5ACF5A73CF737BD77B428E39FFFFF7FFFFF7428E3973D77363CF634AC7
        4A31B6314A4929FFFFFFFFFFFF18961842B64263CF637BD77B42A642DEE7D6FF
        FFFFFFFFFF7BB67B8CDF8C73D7735ACF5A299629636152FFFFFFFFFFFFFFFFFF
        18961863CF6352B652A5B673DECFC6D6CFC6FFE7CE7BAE6B8CDF8C7BD77B42A6
        42396931FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5A8E520869420871AD1079BD10
        79C60871AD31795273CF73298E295A794AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF1079C62996E7298EEF298EEF298EEF0871AD184131FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1079BD3196FF319EFF319EFF31
        9EFF319EFF3196FF298EB54A3831FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        42799C319EFF319EFF319EFF39A6FF39A6FF39A6FF319EFF1886D629384AFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1079C639A6FF42A6FF42A6FF42AEFF42
        AEFF42A6FF42A6FF39A6F7184152FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3986A5
        2996E742A6FF4AAEFF4AB6FF4AB6FF4AB6FF4AB6FF4AAEFF42AEFF186184FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0869A539A6F74AAEFF4AB6FF52BEFF52BEFF52
        BEFF52BEFF52BEFF4AB6FF3186ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0869A5
        399EE74AB6FF52BEFF5ABEFF5ABEFF5ABEFF5ABEFF5ABEFF52BEFF3986A5FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0869A51861A51079C61886D61886D61079BD21
        86B52179BD1871B53196D631494AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0869A54A86C67BAED69CC7E794C7F76BAEF74AA6DE3996CE1871B5FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3986A5298EBD4AA6DE73BEE784C7E77B
        BEE76BB6DE3996CE31595AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF3986A53986A573BEE7A5D7EF9CCFEF398EBD21617BFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3986A53986A542
        799C7B8E9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = btnSearchCustomerClick
    end
    object btnSaveShipping: TSpeedButton
      Left = 754
      Top = 92
      Width = 23
      Height = 22
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000
        0000000000000000000000000000000000000000000000FF00FFFF00FF000000
        008284008284000000000000000000000000000000000000C6C3C6C6C3C60000
        00008284000000FF00FFFF00FF00000000828400828400000000000000000000
        0000000000000000C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
        008284008284000000000000000000000000000000000000C6C3C6C6C3C60000
        00008284000000FF00FFFF00FF00000000828400828400000000000000000000
        0000000000000000000000000000000000008284000000FF00FFFF00FF000000
        0082840082840082840082840082840082840082840082840082840082840082
        84008284000000FF00FFFF00FF00000000828400828400000000000000000000
        0000000000000000000000000000008284008284000000FF00FFFF00FF000000
        008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
        00008284000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
        C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
        008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
        00008284000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
        C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000008284000000FF00FFFF00FF000000
        008284000000C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C60000
        00000000000000FF00FFFF00FF000000008284000000C6C3C6C6C3C6C6C3C6C6
        C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000C6C3C6000000FF00FFFF00FF000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnSaveShippingClick
    end
    object SubCustomer: TSubListPanel
      Left = 59
      Top = 6
      Width = 194
      Height = 57
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 0
      SubListClassName = 'TSubCustomerInfo'
    end
    object dbPreSale: TDBDateBox
      Left = 879
      Top = 5
      Width = 121
      Height = 21
      TabStop = False
      ReadOnly = False
      TabOrder = 1
      DataField = 'PreSaleDate'
      DataSource = dsPreSaleInfo
    end
    object pnlShipp: TPanel
      Left = 323
      Top = 3
      Width = 292
      Height = 77
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Bevel7: TBevel
        Left = 64
        Top = 21
        Width = 209
        Height = 53
        Shape = bsFrame
        Style = bsRaised
      end
      object lbShipTo: TLabel
        Left = 19
        Top = 4
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Ship to :'
      end
      object Bevel8: TBevel
        Left = 66
        Top = 38
        Width = 206
        Height = 4
        Shape = bsTopLine
      end
      object Bevel9: TBevel
        Left = 66
        Top = 56
        Width = 206
        Height = 4
        Shape = bsTopLine
      end
      object Bevel10: TBevel
        Left = 184
        Top = 56
        Width = 1
        Height = 18
        Shape = bsLeftLine
      end
      object Bevel11: TBevel
        Left = 211
        Top = 56
        Width = 1
        Height = 18
        Shape = bsLeftLine
      end
      object DBText3: TDBText
        Left = 67
        Top = 41
        Width = 202
        Height = 13
        DataField = 'Address'
        DataSource = dsSaleShipInfo
      end
      object DBText4: TDBText
        Left = 67
        Top = 58
        Width = 114
        Height = 13
        DataField = 'City'
        DataSource = dsSaleShipInfo
      end
      object DBText5: TDBText
        Left = 185
        Top = 59
        Width = 24
        Height = 13
        DataField = 'IDEstado'
        DataSource = dsSaleShipInfo
      end
      object DBText6: TDBText
        Left = 215
        Top = 59
        Width = 55
        Height = 13
        DataField = 'ZIP'
        DataSource = dsSaleShipInfo
      end
      object DBText7: TDBText
        Left = 67
        Top = 24
        Width = 203
        Height = 13
        DataField = 'AddressName'
        DataSource = dsSaleShipInfo
      end
      object btnCopyAddress: TSpeedButton
        Left = 2
        Top = 23
        Width = 59
        Height = 22
        Caption = 'Copy >>'
        OnClick = btnCopyAddressClick
      end
      object btnUpdate: TSpeedButton
        Left = 273
        Top = 2
        Width = 17
        Height = 17
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD7DDDDDDDDDDDDDDD47DDD
          DDDDDDDDDD4447DDDDDDDDDDD444447DDDDDDDDD44444447DDDDDDD444444444
          DDDDDDDDDD4447DDDDDDDDDDDD444DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
          DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
        OnClick = cbmShipToListPropertiesChange
      end
      object cbmShipToList: TcxLookupComboBox
        Left = 65
        Top = 1
        Width = 209
        Height = 21
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 10
        Properties.KeyFieldNames = 'IDPessoaAddress'
        Properties.ListColumns = <
          item
            Width = 250
            FieldName = 'FullAddress'
          end
          item
            Width = 100
            FieldName = 'Name'
          end>
        Properties.ListOptions.GridLines = glVertical
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsShipToList
        Properties.OnChange = cbmShipToListPropertiesChange
        Style.HotTrack = False
        Style.LookAndFeel.Kind = lfStandard
        TabOrder = 0
      end
    end
    object dtShip: TDBDateBox
      Left = 530
      Top = 94
      Width = 95
      Height = 21
      TabStop = False
      ReadOnly = False
      TabOrder = 3
      DataField = 'ShipDate'
      DataSource = dsSaleShipInfo
    end
    object edtTrackNum: TDBEdit
      Left = 626
      Top = 94
      Width = 127
      Height = 21
      DataField = 'Tracking'
      DataSource = dsSaleShipInfo
      TabOrder = 4
    end
    object scDeliverType: TDBSuperComboADO
      Left = 388
      Top = 94
      Width = 141
      Height = 21
      TabOrder = 5
      Text = 'scDeliverType'
      LookUpSource = DM.dsLookUpDeliverType
      IDLanguage = 0
      DataField = 'IDDeliverType'
      DataSource = dsSaleShipInfo
    end
    object pnlInvoice: TPanel
      Left = 801
      Top = 78
      Width = 205
      Height = 36
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      Visible = False
      object Label1: TLabel
        Left = 28
        Top = 0
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Invoice #'
      end
      object lbInvoiceNum: TDBText
        Left = 78
        Top = 0
        Width = 78
        Height = 13
        AutoSize = True
        DataField = 'InvoiceCode'
        DataSource = dsPreSaleInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 6
        Top = 19
        Width = 67
        Height = 13
        Alignment = taRightJustify
        Caption = 'Invoice Date :'
      end
      object DBText2: TDBText
        Left = 78
        Top = 19
        Width = 50
        Height = 13
        AutoSize = True
        DataField = 'InvoiceDate'
        DataSource = dsPreSaleInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object scMedia: TDBSuperComboADO
      Left = 879
      Top = 30
      Width = 119
      Height = 21
      TabOrder = 7
      Text = 'scMedia'
      LookUpSource = DM.dsLookUpMedia
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'MediaID'
      DataSource = dsPreSaleInfo
    end
  end
  object pnlBottom: TPanel [1]
    Left = 0
    Top = 170
    Width = 1016
    Height = 365
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    DesignSize = (
      1016
      365)
    object btnAddItem: TSpeedButton
      Left = 976
      Top = 4
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      OnClick = OnAddClick
    end
    object btnOpenItem: TSpeedButton
      Left = 976
      Top = 29
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      OnClick = OnDetailClick
    end
    object btnDeleteItem: TSpeedButton
      Left = 976
      Top = 55
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      OnClick = OnRemoveClick
    end
    object btnHistory: TSpeedButton
      Left = 976
      Top = 107
      Width = 23
      Height = 22
      Hint = 'History'
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        DE030000424DDE03000000000000360000002800000011000000120000000100
        180000000000A803000000000000000000000000000000000000FF00FFC3C2CA
        8880849C9B9BC5C0BD9293943F3E3C7E7E7EFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00BBBCBB979592F6FDFD858584593F25CC6905
        C0B1A9664C3136343454565DA6A3A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF00B7B9B79F97998683818C8078C9B094B28E756A492461554DFBB158E2A85F
        84684A4341427B7779FF00FFFF00FFFF00FFFF00FF00D6D4D67E8081CAC5CB9F
        5A0FCD5F07CA6901C0B39F95652BFEB14AFFB658FEBA61FFBD79C7996A3E3E39
        585150929598FF00FF00BBBABB9B949479746B9D8F81CCBCAFB99D857350175E
        5346FDA945FEAE45FFB65AFFB76BFFBD72FFC47EEBBA8F927C6471737200CDCB
        CD89878AA3A0A3C46807CA6401CF690AC1AB938C6023FFA534FFAD3FFFB24AFF
        B558FFBA65FFBE71FFC17FE5BA8C726E7000BFBDBF939090746C6AA4948BD3C4
        B8C9B09971490D5E5048FEA228FFAA31FFAB43FFAF4CFFB45BFFBA65FBBD78F1
        B97E706E7200C0C0C08B898C6A6661CC6E03C86907CA6F03BEA77F915E14FB9E
        13FEA51FFFA82FFFAD3EFFB04DFFB657FFB866F1B373726E7200C0BEC08E8B92
        6F6C66ABA095DCCDD0D5BEAA714A0B585043FA9709FF9C1DFFA425FFA731FFAC
        43FFAF4BFFB458F1AD67726E7200BBBABB989394423C3DCB6F02C36C00D17005
        BEA1798E5519BF760F897365A96F29E29329FFAA32FCAC3EFEB24CF1A75A746D
        7300C3C1C37D80876B6C72A8A4A1DDDDE2DACCBE6C400E4F4843AC732BEBEBE8
        D8CEC4EAD3D38979816A5131F1A342E2A34A726E7000B4B0B4A29C9B1B2027CB
        7302C56D00D17302BF9D7283561AAF7026FBF7F0FDFBE9ECE4DCD1C3C8BEB4BE
        876D62EDA53E736E7100C8C5C87A7A7F6B7082B1ADA9F0E5DEE2D0C475441053
        4B39A96B25FFF8F7E9EEE1BCC0BAC3BCBEE3D4D4897462F19E32726F7200B0AF
        B0AEA8A7282426F18C02FE8F01F78902C49768865218CC760C95693084736BA4
        9E98E5E4D4FFEDE38D7864F09B23706E7200D3CDD3CBCACB644B25FA9303EF8F
        01ED8B00BF700C60543DE88000E08302EA8A00FE9100FB9407AB6D14765720F0
        9913726D7200FF00FFAAACAA5D3E1DF59300D06B04F0C9A5FDF1E2F7E1BDF5C0
        81EF9728EE8804F48E00F58D03F79000FB9804EC900C706E7300FF00FFFF00FF
        6461715D514E7D4F27954D0C9B41089E3D039F400ABC7956D5AA97D5B2B7DEAC
        ADDE8F51D78013C47C1279777800FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFB4B6B87875744E3C2F4F392B804D1B66361A9697A2FF00FFFF00FFFF00
        FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = OnHistoryClick
    end
    object btnSaleTax: TSpeedButton
      Left = 976
      Top = 81
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF00FFFF848284FF00FFFF00FF00FFFF84
        8284000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00FFFF84828400FFFF84828400FFFF848284000000000000FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FFFF84828400FFFF84828400
        FFFF84828400FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FF00FFFF
        848284FF00FF00FFFF84828400FFFF848284848284FFFFFF00FFFF0000000000
        00FF00FFFF00FFFF00FF00FFFF84828400FFFF84828400FFFF848284FF00FFFF
        00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FF00FFFF848284
        00FFFF848284FF00FF00FFFF848284000000000000000000000000FFFFFF00FF
        FF000000000000FF00FFFF00FF00FFFF848284FF00FFFF00FFFF00FFFF00FF84
        8284FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000FF00FFFF00FF
        FF00FFFF00FF000000000000000000FF00FF848284FFFFFF00FFFF0000000000
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000848200000000FF
        00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000C6C3C6000000FF00FFFF00FF848284FFFFFF00FFFF00FF
        FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FF000000C6C3C6000000FF
        00FFFF00FFFF00FF848284FFFFFF00FFFF00FFFF000000000000FF00FFFF00FF
        FF00FF000000C6C3C6C6C3C6848200000000FF00FFFF00FFFF00FF848284FFFF
        FF00FFFF00FFFF000000FF00FFFF00FF000000C6C3C6C6C3C6C6C3C6C6C3C684
        8200000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
        848200FFFFFFFFFFFFC6C3C6C6C3C6C6C3C6848200000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000000000
        0000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnSaleTaxClick
    end
    object grdItems: TcxGrid
      Left = 29
      Top = 4
      Width = 944
      Height = 361
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      BevelKind = bkTile
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdItemsDB: TcxGridDBTableView
        DataController.DataSource = dsPreSaleItem
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDInventoryMov'
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
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        Styles.Content = cxStyleContent2
        Styles.ContentEven = cxStyleContentEven
        Styles.Selection = cxStyleSelection2
        Styles.Header = cxStyleHeader2
        object grdItemsDBQty: TcxGridDBColumn
          DataBinding.FieldName = 'Qty'
          Width = 27
        end
        object grdItemsDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 70
        end
        object grdItemsDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 124
        end
        object grdItemsDBSalesPerson: TcxGridDBColumn
          DataBinding.FieldName = 'SalesPerson'
          Visible = False
          Width = 84
        end
        object grdItemsDBSellingPrice: TcxGridDBColumn
          Caption = 'Retail Price'
          DataBinding.FieldName = 'SellingPrice'
          Visible = False
          Width = 62
        end
        object grdItemsDBSalePrice: TcxGridDBColumn
          DataBinding.FieldName = 'SalePrice'
          Width = 60
        end
        object grdItemsDBSuggRetail: TcxGridDBColumn
          DataBinding.FieldName = 'SuggRetail'
          Visible = False
          Width = 46
        end
        object grdItemsDBDiscount: TcxGridDBColumn
          DataBinding.FieldName = 'Discount'
          Width = 48
        end
        object grdItemsDBTotalItem: TcxGridDBColumn
          DataBinding.FieldName = 'TotalItem'
          Width = 46
        end
        object grdItemsDBTax: TcxGridDBColumn
          DataBinding.FieldName = 'Tax'
          Width = 41
        end
        object grdItemsDBSerialNumber: TcxGridDBColumn
          DataBinding.FieldName = 'SerialNumber'
          Visible = False
          Width = 32
        end
      end
      object grdItemsLevel: TcxGridLevel
        GridView = grdItemsDB
      end
    end
  end
  object pnlClient: TPanel [2]
    Left = 0
    Top = 535
    Width = 1016
    Height = 138
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    DesignSize = (
      1016
      138)
    object lbStatus: TLabel
      Left = 403
      Top = 36
      Width = 66
      Height = 19
      Caption = 'UNPAID'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel6: TBevel
      Left = 680
      Top = 100
      Width = 294
      Height = 3
      Shape = bsTopLine
    end
    object lbAmountPaidInfo: TLabel
      Left = 684
      Top = 108
      Width = 102
      Height = 13
      Caption = 'Amount Paid at Sale :'
    end
    object btnPaiAmount: TSpeedButton
      Left = 661
      Top = 106
      Width = 17
      Height = 17
      Glyph.Data = {
        0E010000424D0E01000000000000360000002800000008000000090000000100
        180000000000D800000000000000000000000000000000000000C5C5C7C3C4C6
        C3C3C5C3C2C5C2C1C3BFC0C2BFC0C1BEC0C0C6C5C8C6C6C7C3C3C6000000C3C3
        C5C0C3C4C0C1C2BFC0C1C8C7CAC8C7C9000000000000000000C2C3C6C1C1C4C1
        C0C3C9C9CBC8C8CAC7C7C8000000000000000000C1C2C5C2C1C4C9CACBC8C8CB
        C8C8CAC8C8C9000000000000000000C3C3C4C9CACCC9C8CBCAC8CA0000000000
        00000000C5C4C6C3C3C5CBCACFCBC9CC000000000000000000C7C6CAC6C5C8C4
        C4C7CDCCCFCCCBCDCACACC000000C9C9CBC9C8CAC6C6CAC5C5C9CECDCFCCCCCE
        CBCDCDCCCBCDCACACCC9C9CAC8C8CAC6C6C9}
      OnClick = OnProcesseSaleClick
    end
    object lbNetDueInfo: TLabel
      Left = 843
      Top = 108
      Width = 46
      Height = 13
      Caption = 'Net Due :'
    end
    object lbAmountPaid: TLabel
      Left = 792
      Top = 108
      Width = 25
      Height = 13
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object btnPayments: TSpeedButton
      Left = 381
      Top = 38
      Width = 17
      Height = 17
      Glyph.Data = {
        0E010000424D0E01000000000000360000002800000008000000090000000100
        180000000000D800000000000000000000000000000000000000C5C5C7C3C4C6
        C3C3C5C3C2C5C2C1C3BFC0C2BFC0C1BEC0C0C6C5C8C6C6C7C3C3C6000000C3C3
        C5C0C3C4C0C1C2BFC0C1C8C7CAC8C7C9000000000000000000C2C3C6C1C1C4C1
        C0C3C9C9CBC8C8CAC7C7C8000000000000000000C1C2C5C2C1C4C9CACBC8C8CB
        C8C8CAC8C8C9000000000000000000C3C3C4C9CACCC9C8CBCAC8CA0000000000
        00000000C5C4C6C3C3C5CBCACFCBC9CC000000000000000000C7C6CAC6C5C8C4
        C4C7CDCCCFCCCBCDCACACC000000C9C9CBC9C8CAC6C6CAC5C5C9CECDCFCCCCCE
        CBCDCDCCCBCDCACACCC9C9CAC8C8CAC6C6C9}
      OnClick = OnShowPaymentsClick
    end
    object lbNetDue: TLabel
      Left = 893
      Top = 108
      Width = 77
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object pnlTotals: TPanel
      Left = 697
      Top = -2
      Width = 279
      Height = 95
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Bevel1: TBevel
        Left = 99
        Top = 0
        Width = 177
        Height = 95
        Shape = bsFrame
        Style = bsRaised
      end
      object lbSalesTax: TLabel
        Left = 45
        Top = 4
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sales Tax :'
      end
      object edtTax: TDBText
        Left = 137
        Top = 2
        Width = 136
        Height = 17
        Alignment = taRightJustify
        Color = 14671839
        DataField = 'Tax'
        DataSource = dsPreSaleValue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbOtherExpenses: TLabel
        Left = 6
        Top = 22
        Width = 92
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tickets/Expenses :'
      end
      object edtOtherCosts: TDBText
        Left = 137
        Top = 22
        Width = 136
        Height = 17
        Alignment = taRightJustify
        Color = 14671839
        DataField = 'AditionalExpenses'
        DataSource = dsPreSaleValue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbDiscount: TLabel
        Left = 50
        Top = 41
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Discount :'
      end
      object edtDiscount: TDBText
        Left = 137
        Top = 41
        Width = 136
        Height = 17
        Alignment = taRightJustify
        Color = 14671839
        DataField = 'ItemDiscount'
        DataSource = dsPreSaleValue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbSubTotal: TLabel
        Left = 49
        Top = 60
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'SubTotal :'
      end
      object edtSubTotal: TDBText
        Left = 137
        Top = 59
        Width = 136
        Height = 17
        Alignment = taRightJustify
        Color = 14671839
        DataField = 'SubTotal'
        DataSource = dsPreSaleValue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbInvoiceTotal: TLabel
        Left = 34
        Top = 80
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Invoice Total'
      end
      object DBText1: TDBText
        Left = 137
        Top = 78
        Width = 136
        Height = 17
        Alignment = taRightJustify
        Color = 14671839
        DataField = 'TotalInvoice'
        DataSource = dsPreSaleValue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Bevel5: TBevel
        Left = 101
        Top = 76
        Width = 174
        Height = 5
        Shape = bsTopLine
      end
      object Bevel2: TBevel
        Left = 101
        Top = 56
        Width = 174
        Height = 4
        Shape = bsTopLine
      end
      object Bevel3: TBevel
        Left = 101
        Top = 37
        Width = 174
        Height = 4
        Shape = bsTopLine
      end
      object Bevel4: TBevel
        Left = 101
        Top = 18
        Width = 174
        Height = 4
        Shape = bsTopLine
      end
      object btnSearchTax: TSpeedButton
        Left = 102
        Top = 2
        Width = 16
        Height = 16
        Glyph.Data = {
          16020000424D160200000000000036000000280000000D0000000C0000000100
          180000000000E001000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB89DA0674E79043EA94486
          BB00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB99DA1694D77
          003AA6088EF674C0EE00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBF
          ADB4694C77003AAA0A8EF572B9ECFF00FF00FF00FFFF00FFC09D93C08F7FBA89
          77BB8F7BBDA49E7780990042BA0990F877BBEBFF00FFFF00FF00FF00FFBC8A78
          CE9D7DE6C899EDD2A0DEB37ABD7D5A8C686768A9DC71BEEDFF00FFFF00FFFF00
          FF00BB8779D7A893FEFCFAFFFFF2FFFFDAFFF6B1F4D992CF8054B8B5B8FF00FF
          FF00FFFF00FFFF00FF00BE7D5FF0E1B9FFFFFFFFFFF6FFFFD7FFFAAEFFDF94E4
          B582C18F7FFF00FFFF00FFFF00FFFF00FF00C27D5DFFFCCBFFFFDCFFFFDEFFFF
          CAFFF2A7FFD791F2D19AB9816CFF00FFFF00FFFF00FFFF00FF00C07B56FCEAAD
          FFFDBAFFFDB7FFF8AEFFE3A1FFE6B0ECCB95BD8773FF00FFFF00FFFF00FFFF00
          FF00BD816CDCB477FFFCAFFFD989FFE099FFEDCDFBF7EDCEA173C8A59AFF00FF
          FF00FFFF00FFFF00FF00FF00FFBA7354DFAF75FADA94FFF0B5F3E3BFD1A590C7
          9783FF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFBE9381BF825EC37F
          5CBD7B5CC6AAA7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        OnClick = btnSearchTaxClick
      end
      object btnTicketExpenses: TSpeedButton
        Left = 102
        Top = 20
        Width = 16
        Height = 17
        Glyph.Data = {
          0E010000424D0E01000000000000360000002800000008000000090000000100
          180000000000D800000000000000000000000000000000000000C5C5C7C3C4C6
          C3C3C5C3C2C5C2C1C3BFC0C2BFC0C1BEC0C0C6C5C8C6C6C7C3C3C6000000C3C3
          C5C0C3C4C0C1C2BFC0C1C8C7CAC8C7C9000000000000000000C2C3C6C1C1C4C1
          C0C3C9C9CBC8C8CAC7C7C8000000000000000000C1C2C5C2C1C4C9CACBC8C8CB
          C8C8CAC8C8C9000000000000000000C3C3C4C9CACCC9C8CBCAC8CA0000000000
          00000000C5C4C6C3C3C5CBCACFCBC9CC000000000000000000C7C6CAC6C5C8C4
          C4C7CDCCCFCCCBCDCACACC000000C9C9CBC9C8CAC6C6CAC5C5C9CECDCFCCCCCE
          CBCDCDCCCBCDCACACCC9C9CAC8C8CAC6C6C9}
        OnClick = btnTicketExpensesClick
      end
      object btnApplyDiscount: TSpeedButton
        Left = 101
        Top = 39
        Width = 17
        Height = 17
        Glyph.Data = {
          0E010000424D0E01000000000000360000002800000008000000090000000100
          180000000000D800000000000000000000000000000000000000C5C5C7C3C4C6
          C3C3C5C3C2C5C2C1C3BFC0C2BFC0C1BEC0C0C6C5C8C6C6C7C3C3C6000000C3C3
          C5C0C3C4C0C1C2BFC0C1C8C7CAC8C7C9000000000000000000C2C3C6C1C1C4C1
          C0C3C9C9CBC8C8CAC7C7C8000000000000000000C1C2C5C2C1C4C9CACBC8C8CB
          C8C8CAC8C8C9000000000000000000C3C3C4C9CACCC9C8CBCAC8CA0000000000
          00000000C5C4C6C3C3C5CBCACFCBC9CC000000000000000000C7C6CAC6C5C8C4
          C4C7CDCCCFCCCBCDCACACC000000C9C9CBC9C8CAC6C6CAC5C5C9CECDCFCCCCCE
          CBCDCDCCCBCDCACACCC9C9CAC8C8CAC6C6C9}
        OnClick = btnApplyDiscountClick
      end
    end
    object grCustomerAccount: TGroupBox
      Left = 29
      Top = 8
      Width = 277
      Height = 70
      Caption = ' Customer Account '
      TabOrder = 1
      object lbCustomerSince: TLabel
        Left = 33
        Top = 21
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Since :'
      end
      object lbCredit: TLabel
        Left = 5
        Top = 42
        Width = 61
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store Credit :'
      end
      object DBText8: TDBText
        Left = 71
        Top = 21
        Width = 42
        Height = 13
        AutoSize = True
        DataField = 'CreationDate'
        DataSource = dsCustomerInfo
      end
      object DBText9: TDBText
        Left = 70
        Top = 43
        Width = 65
        Height = 17
        DataField = 'TotalCredit'
        DataSource = dsCustomerInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlControl: TPanel [3]
    Left = 0
    Top = 673
    Width = 1016
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lblUserName: TLabel
      Left = 75
      Top = 17
      Width = 221
      Height = 15
      AutoSize = False
      Caption = 'lblUserName'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 45
      Top = 16
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'User:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EspacamentoInferior: TPanel
      Left = 0
      Top = 0
      Width = 1016
      Height = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1016
        Height = 2
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object hhh: TPanel
      Left = 866
      Top = 2
      Width = 150
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object spHelp: TSpeedButton
        Tag = 5
        Left = 7
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Help'
        Glyph.Data = {
          0E060000424D0E06000000000000360000002800000016000000160000000100
          180000000000D8050000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFADA6A5BDBABDCECBCECED3D6D6D7D6D6D7D6D6D3
          D6CECBCEC6C3C6ADAEADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
          FFFF00FFFF00FFFF00FFA5A29CC6C3C6D6D7DEDEDFE7D6D7D6D6CBC6D6BEB5D6
          BEB5D6C7C6D6D7D6DEDFE7D6DBDEC6C7C6ADA6A5FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FFFF00FFB5B2ADD6D7D6E7EBEFE7D7CED6A28CC67952BD6539
          BD5D31BD5929BD5D31BD6D4AC69684D6CBC6DEE3E7D6D7D6B5B6B5FF00FFFF00
          FFFF00FF0000FF00FFFF00FFB5B6B5DEDFDEF7F7F7E7C3ADD67D52CE6D39CE6D
          42CE6D42B57D63AD7963B55D31BD5929B55521BD6139CEA694E7E3E7DEDFDEC6
          BEBDFF00FFFF00FF0000FF00FFBDB2ADDEDFDEFFFFFFF7C3ADDE7D4AE78252E7
          8252DE794ACE9E84D6DBDEC6CFD6B58A73BD5D29BD6131BD5929B55529CE967B
          E7E3E7E7E3E7C6B6B5FF00FF0000FF00FFD6D3D6FFFFFFFFD7C6EF8652EF8A5A
          EF8A63E78A5AE77D52DEB6A5FFFFFFD6DFE7B58E7BC65D31C66131BD6131BD5D
          31B55529CEA694E7E7EFDEDFDEFF00FF0000CEC3C6F7F7F7FFFFF7F79A73EF8A
          5AEF9263EF8E63EF8A63E7865ADE865ACEA294BD9684C66D42C66539C66131BD
          6131BD6131BD5929BD6139DECFC6E7EBEFCEC7C60000DEDBDEFFFFFFFFD3BDF7
          8E5AF79263F79263EF8E63EF8A5AE78652DE926BD6AE9CC69684C6714AC66539
          C66539C66131BD6131BD6131BD5521CE9684E7E7E7DEDBDE0000EFEBEFFFFFFF
          FFAE8CF79263F79263F79263EF8E63EF8A5AE78252E7AE9CFFFFFFCED7DEBD7D
          63CE6531C66539C66131BD6131BD6131BD5929C6714ADEDFDEDEDFDE0000F7FB
          FFFFFFFFFFA273F7966BF79263F79263EF8E63EF8A5AE78252DEAA94FFFFFFD6
          D7D6BD8A73C66131C66539C66131BD6131BD6131BD5D31BD6131DECFCEDEE3E7
          0000FFFFFFFFFBF7FF9E73F7966BF79263F79263EF8E63EF8A5AE78252DE8E6B
          FFFBFFF7F7F7C6C3C6B58263C66131C66131C66131BD6131BD5D31BD6131D6C7
          BDDEE3E70000FFFFFFFFFBF7FFA27BFF966BF79263F79263EF8E63EF8A5AE782
          52DE794AD69E84F7F7F7F7F7FFCECFCEB5866BC65D31C66131BD6131BD5D31BD
          6131D6C7BDDEDFE70000FFFFFFFFFFFFFFAA84FF9A6BF7966BF79263EF8A5AE7
          8252E77D4ADE7D4AD66D42CE8663F7EBE7F7F7F7C6C7C6B56D4AC66131BD6131
          BD5D31BD6539DED3CED6D7DE0000F7F7FFFFFFFFFFC39CFF9A6BF7966BF79263
          E7A284E7B6A5D6A28CD67D52D6754ACE6531D69273FFFFFFD6DFDEB58A73BD59
          29BD6131BD5929C67952DEDFDECECFCE0000EFE7E7FFFFFFFFE3CEFF9E73FF9A
          6BFF9263E7BAA5FFFFFFD6DFE7C6927BD66D39CE6531CE8663EFF3F7D6DFE7AD
          8A7BBD5929BD6131BD5529CEA28CDEE3E7BDBABD0000D6CFCEFFFFFFFFFFFFFF
          BA94FF9E6BFF9A6BEFA284FFFBFFF7F3F7CEC7C6C69E8CC69684CEC3BDE7E7E7
          C6CBCEAD715AC65D29BD5929BD6D42DED7D6D6D7DEFF00FF0000FF00FFEFEFEF
          FFFFFFFFF3E7FFAA7BFF9E73FF9A6BE7BEADFFFFFFF7FBFFE7EBEFDEE7EFE7E7
          EFD6D7DEAD968CB55D31BD5D29BD5D29D6B6ADDEE3E7BDBEBDFF00FF0000FF00
          FFFF00FFFFFFFFFFFFFFFFEBDEFFAE84FFA273FF9A6BE7AE94E7D7D6DEDFDED6
          D3D6BDBAB5AD8A7BB56139BD5929BD5D31D6AE9CE7E7E7CECFCEFF00FFFF00FF
          0000FF00FFFF00FFD6D3D6FFFFFFFFFFFFFFF7EFFFC39CFFA273FF9263E7865A
          CE8263C67952BD6939C65929BD5D29C67952D6BEB5E7E7E7D6D3D6FF00FFFF00
          FFFF00FF0000FF00FFFF00FFFF00FFCECBCEFFFBFFFFFFFFFFFFFFFFEBDEFFC7
          ADF7A27BE78A63D67D52CE7D5ACE9273D6B6A5DEDBDEDEE3E7CECFCEFF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFDEDFDEF7F7F7FF
          FFFFFFFFFFFFF7F7EFEBE7E7E3DEE7DFDEDEE3E7DEDFE7D6D7D6BDBEBDFF00FF
          FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          BDB6B5CECBCED6D7D6D6DBDED6DBDED6D7D6CED3D6C6C7C6B5B6B5FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
        Margin = 5
        Visible = False
      end
      object btClose: TButton
        Left = 77
        Top = 3
        Width = 66
        Height = 31
        Cancel = True
        Caption = 'Close'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btCloseClick
      end
    end
  end
  object pnlButton: TPanel [4]
    Left = 0
    Top = 0
    Width = 1016
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    Color = 14475748
    TabOrder = 4
    object btnOpenHold: TSpeedButton
      Left = 137
      Top = 3
      Width = 65
      Height = 47
      Caption = 'Open Hold'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360000002800000015000000140000000100
        1800000000000005000000000000000000000000000000000000FF00FF009CCE
        009CCEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009CCEC6EFF7
        31B5E718A5D6009CCE7BCEE7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009CCE94D6F7
        9CE7FF7BDEFF73D6FF52C6F731B5E718A5D6009CCE4ABDE7FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009CCE4ABDE7
        D6EFFF7BDEFF7BDEFF7BDEFF7BDEFF7BDEFF7BDEFF63D6F74ABDE729ADDE009C
        CE18A5D6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009CCE31B5E7
        D6EFFF84EFFF84EFFF84EFFF84EFFF84EFFF84EFFF84EFFF84EFFF84EFFF84EF
        FF63D6F731B5E7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009CCE52C6F7
        94D6F7ADFFFF84EFFF8CF7FF8CF7FF8CF7FF8CF7FF8CF7FF8CF7FF8CF7FF8CF7
        FF7BDEFF7BDEFF009CCEFF00FFFF00FFFF00FFFF00FFFF00FF0018A5D663C6FF
        63C6E7C6FFFF9CFFFF9CFFFF8CF7FF9CFFFF8CF7FF9CFFFF8CF7FF9CFFFF8CF7
        FF7BDEFF84EFFF4ABDE7FF00FFFF00FFFF00FFFF00FFFF00FF0018A5D673D6FF
        29ADDEE7FFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
        FF84EFFF9CE7FFADFFFF009CCEFF00FFFF00FFFF00FFFF00FF0018A5D673D6FF
        29ADDE9CDEEFD6FFFFADFFFFADFFFFADFFFFADFFFFADFFFFADFFFFADFFFFADFF
        FF84EFFF9CE7FFD6FFFF4ABDE7FF00FFFF00FFFF00FFFF00FF0018A5D67BDEFF
        7BDEFF31B5E74ABDE77BCEE7ADDEF7D6EFFFE7FFFFC6FFFFC6FFFFC6FFFFC6FF
        FF9CE7FF9CE7FFE7FFFFADDEF7009CCEFF00FFFF00FFFF00FF0029ADDE84EFFF
        84EFFF5252005252004ABDE731B5E731B5E742B5DEF7FFF7D6FFFFD6FFFFD6FF
        FF9CE7FF9CDEEF9CDEEF9CDEEF63C6E7009CCE009CCEFF00FF0018A5D684EFFF
        84EFFF525200008C00008C00008C00009C00009C00009C0029ADDEF7FFFFF7FF
        FFF7FFFFF7FFFFD6FFFF9CE7FFF7FFFFF7FFFFF7FFFF009CCE0018A5D68CF7FF
        8CF7FF525200008C00008C00008C00008C00009C00009C00009C0029ADDE29AD
        DE29ADDEDEEFFFFFFFFFE7FFFFFFFFFFFFFFFFFFFFFF009CCE0018A5D69CFFFF
        9CFFFF636300008400008C00008C00008C00008C00009C00009C00009C00009C
        0052520073EFFF009CCE009CCE009CCE009CCE009CCE009CCE0018A5D69CFFFF
        9CFFFF636300008400008400008400008C00008C00008C00009C00009C00009C
        005252009CFFFF9CFFFF29ADDEFF00FFFF00FFFF00FFFF00FF0018A5D6D6FFFF
        9CFFFF848400008400008400008400008400008C00008C00009C00009C00009C
        00525200C6FFFFADFFFF29ADDEFF00FFFF00FFFF00FFFF00FF0018A5D6DEEFFF
        E7FFFF848400008400008400008400008400008C00008C000084000084000084
        0052520029ADDE29ADDE29ADDEFF00FFFF00FFFF00FFFF00FF00FF00FF42B5DE
        42B5DE848400008400008400008400008400008400008C000084008484008484
        00424200FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FF8484000084000084000084000084000084000084000084008484008484
        00424200FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FF6363006363006363006363006363006363006363006363004242004242
        00424200FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
      Layout = blGlyphTop
      Margin = 5
      OnClick = OnOpenHoldClick
    end
    object btnInvoiceList: TSpeedButton
      Left = 203
      Top = 3
      Width = 65
      Height = 47
      Caption = 'Invoice List'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360000002800000015000000140000000100
        18000000000000050000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FFFF00FF8695A1427AA5858895C8C4C5FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FFFF00FF83B1D342A3F1357FB57A818FC0BDBDFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        C88847C78849B3804B739CB53F9FEA367EB3838087A77C55C88746C98745C887
        44C88745C88747C98746C98745C98845C98541FF00FFFF00FF00FF00FFB78A5D
        D8D1C4DBE9EFDAE8EECADCE779BDEE42A4F1377EB2808793C8D5DAC4CFD4B5BA
        BEB7BBC0C0CCD1D4E2E8DAE8EEDBE9EFD6C2A8C2986EFF00FF00FF00FFB78A5D
        D8D1C4CFDEE3C2D1D6C1D0D6ABC3D06FB5E753A1DC758390A49D9DB3A099BDB0
        A1C5B9ADB5A4A0A0A0A3B6C4C9D1DFE5D6C2A8C2986DFF00FF00FF00FFB78A5D
        D8D1C4DBE9EFDBE9EFDBE9EFDAE8EECCDEE8B5CAD5B0A2A1DEC7B3F0ECCEF2F6
        DAF2F7E1F0F4E5CEC0BCA6A3A4D3E0E6D6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D3E2E7CBDADFCBDADFCBDADFCBDADFBDC4C8CFBBADECE6C7ECEBCBEDF2
        DAEDF2E5EDF2EFE9ECE8B5A79FBDC6CAD5C1A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D4E2E8CDDBE1CDDBE1CDDBE1CCDBE0BCBBBAE3D7C0EDE0C0EDEACBEDF2
        DBEEF3E7EEF2ECEEF3E2D5CCBAACADAFD4C0A7C2976CFF00FF00FF00FFB78A5D
        D8D1C4D7E5EBD4E2E8D4E2E8D4E2E8D3E1E7C4BFBCEAE1C8EFDCBCEFE8C8EFF3
        D7F0F5DFF0F5E2EFF5DDDED7C1AEABABD4C0A7C2976CFF00FF00FF00FFB78A5D
        D8D1C4D0DFE4C5D4D9C5D4D9C5D4D9C5D4D9BDBEBEE1D9C2EADFC4EADEBEEAE6
        C6EAECCEEBEDD0EAECCDD2C2AEBABCBED5C1A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D9E7EDD7E5EBD7E5EBD7E5EBD7E5EBCDD5DAD5CCBFF0F2EDF0ECDAF0E2
        C2F0E4C4F0E7C8ECE4C8C3B0A6CED7DCD6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D0DFE4C4D3D8C4D3D8C4D3D8C4D3D8C2D1D6BABDC0D6D0CBE8E7D6EAE4
        C7EAE0C2E7DCBFCCB8AAB6B8BAD0DEE4D6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D9E7EDD7E5EBD7E5EBD7E5EBD7E5EBD7E5EBD6E4EACCD0D4C6BCB9D2C3
        B6D8CABDCBC1BECED4D8D6E4EAD9E7EDD6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D1DFE5C5D4DAC5D4DAC5D4DAC5D4DAC5D4DAC5D4DAC5D4D9C2D1D6BDC9
        CEBFCCD1C3D2D7C5D4DAC5D4DAD3E1E7D6C2A8C3976DFF00FF00FF00FFB78A5C
        D7CBB8D8DFDED6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DD
        DCD6DDDCD6DDDCD6DDDCD6DDDCD8DFDED5BC9EC29A71FF00FF00FF00FFB8834E
        D38B41CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D
        49CF8D49CF8D49CF8D49CF8D49CF8D49CF8234C2986DFF00FF00FF00FFBF8952
        EB8A26E07A17DA7410DA7410DA7410DA7410DA7410DA7410DA7410DA7410DA74
        10DA7410DA7410DA7410DA7410D46E0ACC6702C49D76FF00FF00FF00FFFF00FF
        D47B22D7720FD6700DD6700DD6700DD6700DD6700DD6700DD6700DD6700DD670
        0DD6700DD6700DD6700DD6700DD36E0AC9731DFF00FFFF00FF00FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
      Layout = blGlyphTop
      Spacing = 5
      OnClick = btnInvoiceListClick
    end
    object btnNewInvoice: TSpeedButton
      Left = 71
      Top = 3
      Width = 65
      Height = 47
      Caption = 'New Invoice'
      Flat = True
      Glyph.Data = {
        5E050000424D5E05000000000000360000002800000014000000160000000100
        18000000000028050000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA57973A57973A5
        7973A57973A57973A57973A57973A57973A57973A57973A57973A57973A57973
        A57973A57973A57973A579738C5D5AFF00FFFF00FFA57973FFD7CEFFD7CEFFD7
        CEFFD7CEFFD7CEFFD7CEFFD7CEFFD7CEFFCFC6FFCFC6FFCFC6FFD3B5FFD3B5FF
        D3B5FFD3B5FFD3B58C5D5AFF00FFFF00FFA57973F7EBDEFFEBD6FFEBD6FFEBD6
        FFE7CEFFE7CEFFE7CEFFE7CEFFDFBDFFDFBDFFDFBDFFDFBDFFD7ADFFD7ADFFD7
        ADFFD3B58C5D5AFF00FFFF00FFB58273F7EBDEFFF3E7FFEBD6FFEBD6FFEBD6FF
        E7CEFFE7CEFFE7CEFFE7CEFFDFBDFFDFBDFFDFBDFFDFBDFFD7ADFFD7ADFFD3B5
        8C5D5AFF00FFFF00FFB58273F7EFE7FFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7
        CEFFE7CEFFE7CEFFE7CEFFDFBDFFDFBDFFDFBDFFDFBDFFD7ADFFD3B58C5D5AFF
        00FFFF00FFB58273F7EFE7FFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CE
        FFE7CEFFE7CEFFE7CEFFDFBDFFDFBDFFDFBDFFDFBDFFCFC68C5D5AFF00FFFF00
        FFBD8E84F7EFE7FFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFF
        E7CEFFE7CEFFE7CEFFDFBDFFDFBDFFDFBDFFCFC69C6963FF00FFFF00FFBD8E84
        FFF3EFFFFBEFFFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFFE7
        CEFFE7CEFFE7CEFFDFBDFFDFBDFFCFC69C6963FF00FFFF00FFBD8E84FFF3EFFF
        FBF7FFFBEFFFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFFE7CE
        FFE7CEFFE7CEFFDFBDFFCFC69C6963FF00FFFF00FFCE9A84FFF7F7FFFBF7FFFB
        EFFFFBEFFFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFFE7CEFF
        E7CEFFE7CEFFD7CE9C6963FF00FFFF00FFCE9A84FFFBFFFFFFFFFFFBF7FFFBEF
        FFFBEFFFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFFE7CEFFE7
        CEFFD7CEA57973FF00FFFF00FFCE9A84FFFBFFFFFFFFFFFFFFFFFBF7FFFBEFFF
        FBEFFFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFFE7CEFFD7CE
        A57973FF00FFFF00FFDEAA84FFFBFFFFFFFFFFFFFFFFFFFFFFFBF7FFFBEFFFFB
        EFFFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFEBD6FFEBD6FFE7CEFFCFC6A57973FF
        00FFFF00FFDEAA84FFFBFFFFFFFFFFFFFFFFFFFFFFFBF7FFFBF7FFFBF7FFFBEF
        FFF7EFFFF7EFFFF3E7FFF3E7FFEBD6FFD7CEFFCFC6F7BAB5A57973FF00FFFF00
        FFDEAA84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7FFFBF7FFFBEFFFFBEFFF
        F7EFFFF7EFFFF3E7FFD7CEF7BAB5FFA2A5FFA2A5B58273FF00FFFF00FFE7B28C
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7FFFBF7FFFBEFFFFBEFFFF7
        EFB58273B58273B58273A57973B58273B58273FF00FFFF00FFE7B28CFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFBF7FFFBEFFFFBEFB58273
        E7B28CFFB24AFF9A08D69263D6AA94FF00FFFF00FFEFBE94FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7FFFBF7FFFBEFB58273EFCBA5FF
        C77BDEAA84D6AA94FF00FFFF00FFFF00FFEFBE94FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7FFFBF7B58273EFCBA5E7B28CD6AA
        94FF00FFFF00FFFF00FFFF00FFEFBE94FFF3E7FFF3E7F7EBDEF7EBDEEFE7DEEF
        E7DEEFDBD6EFDBD6DED7D6DED3CEDED3CEB58273DEAA84E7B28CFF00FFFF00FF
        FF00FFFF00FFFF00FFEFBE94DEAA84DEAA84DEAA84DEAA84DEAA84DEAA84DEAA
        84DEAA84DEAA84DEAA84DEAA84B58273DEAA84FF00FFFF00FFFF00FFFF00FFFF
        00FF}
      Layout = blGlyphTop
      OnClick = btnNewInvoiceClick
    end
    object btnImportCustomerPO: TSpeedButton
      Left = 4
      Top = 3
      Width = 65
      Height = 47
      Caption = 'Estimate'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        76050000424D7605000000000000360000002800000015000000150000000100
        18000000000040050000C40E0000C40E00000000000000000000FF00FF63C3E7
        9CDFEFDEEFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009ACEDEEFFF
        52C7F729AEDE29AEDE63C3E794D3F7D6EFFFFF00FFFF00FFFF00FFFF00FFFF00
        FF0071086BA663FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009ACE94D3F7
        9CE3FF7BDFFF73D3FF63D7F752C7F731B6E718A6D64ABEE794D3F7C6EFF7D6EF
        FF088218088218428A39FF00FFFF00FFFF00FFFF00FFFF00FF00009ACE63C3E7
        D6EFFF7BDFFF7BDFFF7BDFFF7BDFFF7BDFFF7BDFFF73D3FF63D7F731B6E731B6
        E708821808A218088218217D21FF00FFFF00FFFF00FFFF00FF00009ACE4ABEE7
        F7F7FF7BDFFF84EBFF7BDFFF298E420882180882180882180882180882180882
        1808821810B63108A21808A218007108FF00FFFF00FFFF00FF00009ACE52C7F7
        9CDFEFADFBFF84EBFF84EBFF298E425AE38442CF7342CF7342CF7331C36B31C3
        6B21BA4A10B63110B63108A21808A218007108FF00FFFF00FF00009ACE52C7F7
        29AEDED6FFFF84EBFF8CF3FF298E425AE3845AE3845AE38442CF7331C36B42CF
        7321BA4A21BA4A10B63110B63108A21808A218007108FF00FF00009ACE63C7FF
        31B6E7F7F7FF9CFFFF8CF3FF298E425AE3845AE3845AE38442CF7342CF7331C3
        6B42CF7321BA4A21BA4A10B63110B63108A218007108FF00FF00009ACE73D3FF
        63C7FF9CDFEFC6FFFF9CFFFF298E424AAA4A21A63921A63921A63921A639189A
        2921BA4A31C36B31C36B21BA4A10B631007108ADD3B5FF00FF00009ACE73D3FF
        63C7FF9CC3DED6FFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
        FF21A63931C36B31C36B189A29298E426BCFC6D6EFFFFF00FF00009ACE7BDFFF
        7BDFFF404000BDE7F7F7FFFFE7FFFFD6FFFFC6FFFFC6FFFFADFBFFADFBFFC6FF
        FF21A63942CF73189A29298E42C6EFF7D6FFFF29AEDEFF00FF00009ACE7BDFFF
        7BDFFF515100C6DFE79CC3DE31B6E742B2DE31B6E729AEDEF7FFFFC6FFFFC6FF
        FF21A6390882186BA6639CE3FFE7FFFFE7FFFF29AEDEDEEFFF0018A6D684EBFF
        84EBFF515100008C00008C00008C00009B00009B00009B0029AEDEF7FFFFF7FF
        FF007108A5C79CD6FFFF9CE3FFF7FFFFF7FFFFF7FFFF009ACE0018A6D68CF3FF
        8CF3FF515100008C00008C00008C00008C00009B00009B00009B0029AEDE29AE
        DE29AEDEDEEFFFFFFFFFE7FFFFFFFFFFFFFFFFFFFFFF009ACE0018A6D69CFFFF
        9CFFFF666600008000008C00008C00008C00008C00009B00009B00009B00009B
        0051510073EBFF009ACE009ACE009ACE009ACE009ACE009ACE0018A6D69CFFFF
        9CFFFF666600008000008000008000008C00008C00008C00009B00009B00009B
        005151009CFFFF9CFFFF29AEDEFF00FFFF00FFFF00FFFF00FF0018A6D6D6FFFF
        9CFFFF808000008000008000008000008000008C00008C00009B00009B00009B
        00515100C6FFFFADFBFF29AEDEFF00FFFF00FFFF00FFFF00FF0018A6D6DEEFFF
        E7FFFF808000008000008000008000008000008C00008C000080000080000080
        0051510029AEDE29AEDE29AEDEFF00FFFF00FFFF00FFFF00FF00FF00FF42B2DE
        42B2DE808000008000008000008000008000008000008C000080008080008080
        00404000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FF8080000080000080000080000080000080000080000080008080008080
        00404000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FF6666006666006666006666006666006666006666006666004040004040
        00404000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
      Layout = blGlyphTop
      Margin = 2
      ParentFont = False
      Spacing = 6
      OnClick = btnImportCustomerPOClick
    end
    object btnPrint: TSpeedButton
      Left = 268
      Top = 3
      Width = 65
      Height = 47
      Caption = 'Print'
      Flat = True
      Glyph.Data = {
        A2070000424DA207000000000000360000002800000019000000190000000100
        1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C69C96949C9694FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECBCEBDBA
        BDDEDBDEDEDFDEADAEADB5B2B59C9694BD8E84A58E84ADAEADFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFBDBABDCECFCEEFEFEFEFEFEFDEDBDEADAEADB5B2B58C8E8C4A4D4A63
        61636361638C8A8C9C9694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFBDBEBDC6C3C6EFEBEFF7F3F7EFEFEFEFEBEFD6D3D6AD
        AAADADAEAD8C8E8C4A4D4A4241426361636361638486848C8E8CADAEADC6C7C6
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDBABDDEDFDEFFFBFFFFF7F7EF
        EFEFEFEBEFE7E3E7D6D3D6ADAAADADAAADADAEADADAEADADAAAD8C8A8C737173
        6361638486848C8E8CB5B2B59C9E9CFFFFFFFFFFFF00FFFFFFFFFFFFBDBABDFF
        FFFFFFFBFFFFF7F7EFEFEFEFEBEFDEDBDEB5B2B58C8E8C8482848C8E8CADAAAD
        ADAEADADAEADB5B2B5BDBABDADAEAD9C9E9C636163525152CECBCEFFFFFFFFFF
        FF00FFFFFFFFFFFFADAEADFFFBFFFFF7F7EFEFEFDEDBDE9C9E9C9C9E9CBDBABD
        C6C7C69C9E9C8C8E8C8482848482848C8E8C9C9E9CB5B2B5BDBABDBDBEBDC6C3
        C6BDBABDC6C7C6FFFFFFFFFFFF00FFFFFFFFFFFFADAAADF7F3F7CECFCE9C9694
        9C9E9CD6D3D6DEDBDED6D3D6D6D3D6CECBCEBDBEBDADAAADADAAAD9C9E9C8C8E
        8C8486848C8A8C9C9E9CBDBABD8CBE8C8CBE8CFFFFFFFFFFFF00FFFFFFFFFFFF
        9C9E9C8C8A8C9C9694DEDBDEDEDFDEDEDBDED6D3D6CECBCEEFEBEFE7E7E7E7E7
        E7EFEBEFDEDBDECECBCEBDBABDADAEADADAEAD9C96948486848482849C9694FF
        FFFFFFFFFF00FFFFFFFFFFFF8C8E8CEFEBEFE7E3E7DEDFDEDEDBDED6D3D6CECF
        CEE7E3E7DEDBDEB5B2B5BDBABDBDBABDBDBEBDCECFCEE7E7E7E7E7E7D6D3D6C6
        C7C6BDBEBDBDBABDADAAADFFFFFFFFFFFF00FFFFFFFFFFFF8C8A8CE7E3E7DEDF
        DEDEDBDED6D3D6CECFCEDEDBDEE7E7E7C6C3C6EFEFEFEFEFEFEFEBEFCECFCEBD
        BEBDBDBABDBDBABDBDBEBDD6D3D6E7E3E7DEDFDED6D3D6FFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFD6D3D6DEDBDED6D3D6CECFCEDEDFDECECFCEC6C3C6F7F3F7F7
        F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEFDEDBDEC6C7C6BDBABDBDBABDBDBABD
        CECBCEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADAEADBDBEBDC6
        C3C6D6D3D6C6C7C6CECBCEE7E7E7F7F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEF
        E7E7E7E7E7E7D6D3D6ADAEADFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFADAAADE7E7E7E7E7E7ADAEADB5B2B5BDBABDBDBABDC6C3C6
        CECBCEDEDBDEE7E7E7E7E7E7EFEBEFCECBCEB5B2B5FFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAAADFFFBF7FFF3E7EFDBCE
        D6D3D6C6C7C6C6C7C6BDBABDC6C3C6BDBEBDBDAAA5BDAAA5B5B2B5DEDBDEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFCE9A84FFD7ADFFD7ADFFD7ADFFDFBDFFDFBDFFEBD6F7E3D6EFE7DECEAA
        ADDEDBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6AA94FFDFBDFFD7ADFFDFBDFFD7ADFFDF
        BDFFD7ADFFDFBDF7D3A5BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3B5FFDF
        BDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDD6B2ADBD9A94FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFDEC7B5FFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEBD
        9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9A94FFEBD6FFEBD6FFEBD6FFEBD6FF
        EBD6FFEBD6FFEBD6EFDBCEBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECBC6FF
        F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7D6B2ADBD9A94FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFD6BEBDFFF7EFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFF7EF
        BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED7D6FFFFFFFFFBFFFFFFFFFFFFFF
        FFFBFFFFFFFFFFFFFFEFEBEFBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFCEBEB5BD9A94
        BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00}
      Layout = blGlyphTop
      Spacing = 3
      OnClick = btnPrintClick
    end
    object Panel1: TPanel
      Left = 0
      Top = 51
      Width = 1016
      Height = 2
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  inherited siLang: TsiLangRT
    Left = 56
    Top = 68
  end
  inherited spquPreSaleValue: TADOStoredProc
    AfterOpen = spquPreSaleValueAfterOpen
  end
  inherited strepSaleItem: TcxStyleRepository
    object cxStyleContent2: TcxStyle [14]
      AssignedValues = [svColor]
      Color = 14737632
    end
    object cxStyleSelection2: TcxStyle [15]
      AssignedValues = [svColor]
      Color = clGray
    end
    object cxStyleHeader2: TcxStyle [16]
      AssignedValues = [svColor]
      Color = 14548991
    end
  end
  inherited quTestSerialNumber: TADODataSet
    CommandText = 
      'SELECT '#13#10#9'PIM.IDPreInventoryMov'#13#10'FROM'#9#13#10#9'PreInventoryMov PIM (NO' +
      'LOCK) '#13#10#9'LEFT OUTER JOIN PreSerialMov PSM (NOLOCK) ON  (PIM.IDPr' +
      'eInventoryMov = PSM.PreInventoryMovID)'#13#10#9'JOIN Model M (NOLOCK) O' +
      'N (PIM.ModelID = M.IDModel)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.Gr' +
      'oupID = TG.IDGroup)'#13#10'WHERE '#13#10#9'TG.SerialNumber = 1'#13#10#9'AND '#13#10#9'PIM.U' +
      'serID = :IDUser'#13#10#9'AND  '#13#10#9'PIM.DocumentID = :DocumentID'#13#10'GROUP BY' +
      ' '#13#10#9'IDPreInventoryMov, '#13#10#9'PIM.Qty'#13#10'HAVING '#13#10#9'COUNT(PSM.SerialNum' +
      'ber) < ABS(PIM.Qty)'#13#10
  end
  inherited quPreSaleInfo: TADOQuery
    BeforeClose = quPreSaleInfoBeforeClose
    SQL.Strings = (
      'SELECT'
      '        I.IDPreSale,'
      '        I.IDMeioPag ,'
      '        I.IDTouristGroup,'
      '        I.PreSaleDate ,'
      '        I.OtherComissionID ,'
      '        I.IDCustomer ,'
      '        I.DeliverTypeID ,'
      '        I.DeliverDate ,'
      '        I.DeliverAddress ,'
      '        I.PassportDate , '
      #9'I.AirLine ,'
      '        I.CompanyName ,'
      '        I.CompanyCGC ,'
      '        I.DepositDate ,'
      '        I.Note ,'
      '        I.PrintNotes,'
      '        I.InvoiceDate ,'
      '        I.IDInvoice ,'
      '        I.Passport ,'
      '        I.Ticket,'
      '        I.MediaID,'
      '        I.CardNumber,'
      '        I.IDStore,'
      '        I.Address,'
      '        I.Layaway,'
      '        I.FirstName,'
      '        I.LastName,'
      '        I.Zip,'
      '        I.DeliverOBS,'
      '        I.DeliverConfirmation,'
      '        I.IDFormOfPayment,'
      '        I.IDPreSaleParent,'
      '        I.SaleCode,'
      #9'I.InvoiceCode,'
      #9'I.PuppyTracker,'
      #9'I.TaxIsent'
      'FROM'
      '        Invoice I (NOLOCK) '
      'WHERE'
      '        IDPreSale = :IDPreSale')
    inherited quPreSaleInfoInvoiceDate: TDateTimeField
      DisplayFormat = 'ddddd'
    end
  end
  object quShipToList: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quShipToListCalcFields
    CommandText = 
      'SELECT'#13#10#9'PA.IDPessoaAddress,'#13#10#9'PA.Name,'#13#10#9'PA.Address,'#13#10#9'PA.City,' +
      #13#10#9'PA.ZIP,'#13#10#9'PA.IDEstado as IDState,'#13#10#9'PA.IDPais,'#13#10#9'E.Estado as ' +
      'State,'#13#10#9'P.CodPais as CountryCod,'#13#10#9'P.Pais as Country'#13#10'FROM'#13#10#9'Mn' +
      't_PessoaAddress PA (NOLOCK) '#13#10#9'LEFT JOIN Estado E (NOLOCK) ON (P' +
      'A.IDEstado = E.IDEstado)'#13#10#9'LEFT JOIN Pais P (NOLOCK) ON (PA.IDPa' +
      'is = P.IDPais)'#13#10'WHERE'#13#10#9'IDPessoa = :IDPessoa'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 564
    Top = 268
    object quShipToListIDPessoaAddress: TIntegerField
      FieldName = 'IDPessoaAddress'
    end
    object quShipToListName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quShipToListAddress: TStringField
      FieldName = 'Address'
      Size = 50
    end
    object quShipToListCity: TStringField
      FieldName = 'City'
    end
    object quShipToListZIP: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object quShipToListIDState: TStringField
      FieldName = 'IDState'
      FixedChar = True
      Size = 3
    end
    object quShipToListState: TStringField
      FieldName = 'State'
      Size = 50
    end
    object quShipToListCountryCod: TStringField
      FieldName = 'CountryCod'
      Size = 3
    end
    object quShipToListCountry: TStringField
      FieldName = 'Country'
      Size = 50
    end
    object quShipToListFullAddress: TStringField
      FieldKind = fkCalculated
      FieldName = 'FullAddress'
      Size = 150
      Calculated = True
    end
    object quShipToListIDPais: TIntegerField
      FieldName = 'IDPais'
    end
  end
  object dsShipToList: TDataSource
    DataSet = quShipToList
    Left = 566
    Top = 223
  end
  object quPreSaleShipInfo: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'S.IDPreSale,'#13#10#9'S.IDInvoiceShipping,'#13#10#9'S.ShipDate,'#13#10#9'S.T' +
      'racking,'#13#10#9'S.IDDeliverType,'#13#10#9'S.AddressName,'#13#10#9'S.Address,'#13#10#9'S.Ci' +
      'ty,'#13#10#9'S.ZIP,'#13#10#9'S.IDEstado,'#13#10#9'S.IDPais'#13#10'FROM'#13#10#9'Sal_InvoiceShippin' +
      'g S (NOLOCK) '#13#10'WHERE'#13#10#9'S.IDPreSale = :IDPreSale'#13#10#13#10
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 652
    Top = 267
    object quPreSaleShipInfoIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quPreSaleShipInfoIDInvoiceShipping: TIntegerField
      FieldName = 'IDInvoiceShipping'
    end
    object quPreSaleShipInfoShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object quPreSaleShipInfoTracking: TStringField
      FieldName = 'Tracking'
      Size = 255
    end
    object quPreSaleShipInfoIDDeliverType: TIntegerField
      FieldName = 'IDDeliverType'
    end
    object quPreSaleShipInfoAddressName: TStringField
      FieldName = 'AddressName'
      Size = 30
    end
    object quPreSaleShipInfoAddress: TStringField
      FieldName = 'Address'
      Size = 50
    end
    object quPreSaleShipInfoCity: TStringField
      FieldName = 'City'
    end
    object quPreSaleShipInfoZIP: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object quPreSaleShipInfoIDPais: TIntegerField
      FieldName = 'IDPais'
    end
    object quPreSaleShipInfoIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
  end
  object cmdInsertShipInfo: TADOCommand
    CommandText = 
      'INSERT Sal_InvoiceShipping (IDInvoiceShipping, ShipDate, IDPreSa' +
      'le)'#13#10'VALUES (:IDInvoiceShipping, :ShipDate, :IDPreSale)'
    CommandTimeout = 180
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDInvoiceShipping'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ShipDate'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 228
    Top = 319
  end
  object dsSaleShipInfo: TDataSource
    DataSet = quPreSaleShipInfo
    OnStateChange = dsSaleShipInfoStateChange
    Left = 656
    Top = 219
  end
  object quCustomerInfo: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'P.Pessoa,'#9#13#10#9'P.Endereco, '#13#10#9'P.Cidade, '#13#10#9'P.CEP, '#13#10#9'P.ID' +
      'Estado, '#13#10#9'P.IDPais,'#13#10#9'P.CreationDate,'#13#10#9'SUM(ISNULL(CC.Amount, 0' +
      ')) AS TotalCredit'#13#10'FROM'#13#10#9'Pessoa P (NOLOCK) '#13#10#9'LEFT JOIN Custome' +
      'rCredit CC (NOLOCK) ON (CC.IDPessoa = P.IDPessoa AND IsUsed = 0)' +
      #13#10'WHERE'#13#10#9'P.IDPessoa = :IDPessoa'#13#10'GROUP BY'#13#10#9'P.Pessoa,'#9#13#10#9'P.Ende' +
      'reco, '#13#10#9'P.Cidade, '#13#10#9'P.CEP, '#13#10#9'P.IDEstado, '#13#10#9'P.IDPais,'#13#10#9'P.Cre' +
      'ationDate'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 748
    Top = 270
    object quCustomerInfoPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quCustomerInfoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object quCustomerInfoCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object quCustomerInfoCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quCustomerInfoIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quCustomerInfoIDPais: TIntegerField
      FieldName = 'IDPais'
    end
    object quCustomerInfoCreationDate: TDateTimeField
      FieldName = 'CreationDate'
      DisplayFormat = 'ddddd'
    end
    object quCustomerInfoTotalCredit: TBCDField
      FieldName = 'TotalCredit'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dsCustomerInfo: TDataSource
    DataSet = quCustomerInfo
    Left = 748
    Top = 222
  end
end
