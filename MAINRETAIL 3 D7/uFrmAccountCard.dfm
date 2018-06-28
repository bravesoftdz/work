inherited FrmAccountCard: TFrmAccountCard
  Left = 223
  Top = 66
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gift Cards'
  ClientHeight = 545
  ClientWidth = 771
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 771
    inherited Image1: TImage
      Width = 544
    end
    inherited lblMenu: TLabel
      Left = 555
    end
    inherited EspacamentoSuperior: TPanel
      Width = 771
      inherited EEE: TPanel
        Width = 771
      end
    end
  end
  inherited Panel1: TPanel
    Top = 504
    Width = 771
    inherited EspacamentoInferior: TPanel
      Width = 771
      inherited Panel3: TPanel
        Width = 771
      end
    end
    inherited hhh: TPanel
      Left = 689
      inherited btClose: TButton
        Cancel = True
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 286
    Height = 218
  end
  inherited EspacamentoDireito: TPanel
    Left = 768
    Top = 286
    Height = 218
  end
  object Panel4: TPanel [4]
    Left = 0
    Top = 100
    Width = 771
    Height = 170
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object pnlButtons: TPanel
      Left = 599
      Top = 0
      Width = 172
      Height = 170
      Align = alRight
      TabOrder = 0
      object btPOGroup: TSpeedButton
        Tag = 3
        Left = 2
        Top = 2
        Width = 154
        Height = 25
        Caption = '&Disable Card'
        Flat = True
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
        Margin = 7
        Spacing = 8
        OnClick = btPOGroupClick
      end
      object btPOColumn: TSpeedButton
        Tag = 4
        Left = 2
        Top = 53
        Width = 154
        Height = 25
        Caption = 'Add to Balance'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          0000000000000000000000000000000000000000000000000000000000000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF00000000800000800000800000800089
          C489008000008000008000008000000000FF00FFFF00FFFF00FFFF00FFFF00FF
          000000008000008000008000008000BADDBA0080000080000080000080000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF00000000800000800075BA75EEF7EEFF
          FFFFEEF7EE75BA75008000008000000000FF00FFFF00FFFF00FFFF00FFFF00FF
          00000000800000800099CC9965B265CEE7CE89C489FFFFFF0080000080000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF000000008000008000008000108810CE
          E7CEAAD5AAFFFFFF008000008000000000FF00FFFF00FFFF00FFFF00FFFF00FF
          00000000800000800075BA75FFFFFFFFFFFFFFFFFFBADDBA0080000080000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF000000008000008000FFFFFFDEEFDEFF
          FFFF008000CEE7CEFFFFFF008000000000FF00FFFF00FFFF00FFFF00FFFF00FF
          000000008000008000CEE7CEEEF7EECEE7CEEEF7EEFFFFFFFF0000FFFFFFFFFF
          FFFFFFFFFFFFFFFF00FFFF00FFFF00FF00000000800000800020902089C48920
          9020FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFF00FFFF00FFFF00FF
          000000008000008000008000008000FFFFFFFF0000FF0000FF0000FF0000FF00
          00FF0000FFFFFFFF00FFFF00FFFF00FF00000000800000800000800000800000
          8000FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFF00FFFF00FFFF00FF
          000000000000000000000000000000000000000000FFFFFFFF0000FFFFFFFFFF
          FFFFFFFFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FF}
        Margin = 6
        Spacing = 7
        OnClick = btPOColumnClick
      end
      object SpeedButton1: TSpeedButton
        Tag = 4
        Left = 2
        Top = 78
        Width = 154
        Height = 28
        Caption = 'Subtract From New Card'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          0000000000000000000000000000000000000000000000000000000000000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF0000000084000084000084000084008C
          C68C008400008400008400008400000000FF00FFFF00FFFF00FFFF00FFFF00FF
          000000008400008400008400008400BDDEBD0084000084000084000084000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF00000000840000840073BD73EFF7EFFF
          FFFFEFF7EF73BD73008400008400000000FF00FFFF00FFFF00FFFF00FFFF00FF
          0000000084000084009CCE9C63B563CEE7CE8CC68CFFFFFF0084000084000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF000000008400008400008400108C10CE
          E7CEADD6ADFFFFFF008400008400000000FF00FFFF00FFFF00FFFF00FFFF00FF
          00000000840000840073BD73FFFFFFFFFFFFFFFFFFBDDEBD0084000084000000
          00FF00FFFF00FFFF00FFFF00FFFF00FF000000008400008400FFFFFFDEEFDECE
          E7CE108C10008400008400FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FF
          000000008400008400CEE7CEEFF7EFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000000084000084002194218CC68CFF
          FFFF0000FF0000FF0000FF0000FF0000FFFFFFFFFF00FFFF00FFFF00FFFF00FF
          000000008400008400008400008400FFFFFF0000FF0000FF0000FF0000FF0000
          FF0000FFFFFFFFFF00FFFF00FFFF00FF000000008400008400008400008400FF
          FFFF0000FF0000FF0000FF0000FF0000FFFFFFFFFF00FFFF00FFFF00FFFF00FF
          000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FF}
        Margin = 6
        Spacing = 7
        OnClick = SpeedButton1Click
      end
      object btnExpDate: TSpeedButton
        Tag = 3
        Left = 2
        Top = 28
        Width = 154
        Height = 25
        Caption = 'Expiration Date'
        Flat = True
        Glyph.Data = {
          CA050000424DCA05000000000000360000002800000016000000150000000100
          1800000000009405000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9F9F9F9FA8A8
          A88F8F8FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9F8C89889F9F9FB9AAA6C8
          ABABCABCB7D6BCBBD5B3AFB1A097868585FF00FFFF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8C89889996979996978F8E8D
          8F8E8DA4968EA18C82A4968E8C8988C8ABABFECFC2BF9895FF00FFFF00FFFF00
          FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FF8791859F9F9F8C8988B1A0
          97EDD9B7FDE8B7CFCFCF6682F1FDF6C6FDE8B7D8C5B5868585E2BDB3E2BDB38C
          8988FF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FF0F8319267D27879185E3
          D3AAFDE8B7FDF6C6FEF9F3BEC6DC4571FAFFFDF8FEFFFCFFF8EEFDF6C6A4968E
          D5B3AFE2BDB3FF00FFFF00FF0000FF00FFFF00FFFF00FF267D2758E08730C369
          448A3EFDE8B7FDF6C6FDE8B7FED7ABFED7ABFED7ABFDE8B7FEEBD7FFFDF8FEFF
          FCFDF6C68F8E8DE2BDB3AB8FA3FF00FF0000FF00FFFF00FF18992E30C36958E0
          8758E08725A63D7DA972FDE8B7FDE8B7FDE8B7FDE8B7FED7ABFED7ABFED7ABFE
          DDBBFFFDF8FFFDF8FDF6C68F8E8DFECFC29996970000FF00FF448A3E25A63D47
          CE7158E08758E08758E0870EA31BA1C79EFDE8B7FDE8B7FDE8B7FDE8B7FDE8B7
          FED7ABFED7ABFDE8B7FCFEFBFFF8EEB9AAA6D5B3AFA4968E00007DA9720F8319
          30C36947CE7158E08758E08758E08758E0870F8319C7D195FED7ABFED7ABFDE8
          B7FDE8B7FDE8B7FED7ABFED7ABFEF0E2FCFEFEFDE8B7A4968EC8ABAB00000571
          0A25BB4F25BB4F30C36930C36947CE7158E08758E08747CE71267D27FED7ABFD
          E8B7FDE8B7FDE8B7FDE8B7FDE8B7FED7ABFDE8B7FFFFFEFDF6C6808080D6BCBB
          0000448A3E448A3E0F831925BB4F47CE7147CE7125BB4F267D27448A3E448A3E
          8DBC8BFEFED3FEFED3FED7ABFED7ABFED7ABFED7ABFED7ABD0E3EC4571FA9996
          97D6BCBB0000FF00FFFF00FF0F831916B43225BB4F30C36918992EC0D5C2FEFF
          E1FEFED3FEFED3FEFED3FEFED3FEFED3FED7ABFED7ABFED7ABFED7ABECEAEA45
          71FA8F8E8DC8ABAB0000FF00FFFF00FF05710A16B43225BB4F25BB4F18992EC0
          D5C2FFFDF8FEFFE1FEFFE1F0E4C7FEFED3FEFED3FEFED3FED7ABFDE8B7FDE8B7
          FFF8EEFDE8B7868585B9AAA60000FF00FFFF00FF448A3E0F831916B43225BB4F
          18992EA1C79EFFFDF8FEFFE1FEFFE1FEFFE1FEFED3FEFED3FEFED3FEFED3FED7
          ABFDF6C6FEEBD7C7D1958F8F8F9996970000FF00FFFF00FFFF00FF05710A0EA3
          1B16B43216B432448A3EFFFFFFFCFEFBFEF9F3FEFFE1FEFED3FEFED3FEFED3FE
          FED3FED7ABFED7ABFDE8B7B1A0979996978685850000FF00FFFF00FFFF00FF66
          8E670F83190EA31B16B4320F83198DBC8BFFFEFFFFFFFFFFFFFEFFFDF8FEFED3
          FEFED3E3D3AAFED7ABE3B18EE3D3AA8C8988999697FF00FF0000FF00FFFF00FF
          FF00FFFF00FF668E670F83190EA31B16B4320F8319448A3EA1C79EDDEADDD1EF
          F9FFFDF88DBC8BC7D195EDD9B7E3D3AA8C8988A8A8A88F8E8DFF00FF0000FF00
          FFFF00FFFF00FFFF00FFFF00FF8DBC8B0F83190F831916B43225BB4F18992E0F
          831905710A05710A267D27E3D3AAEAC8A1999697AFAFAF999697FF00FFFF00FF
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE6E5E47DA972267D2705710A
          0F831905710A448A3E7DA972DAB4A0B1A097A8A8A8B9B9B99F9F9FFF00FFFF00
          FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE6E5
          E4E6E5E4C7C7C7BFBFBFB9B9B9B5B3B3C4C4C4CFCFCFC0C0C09F9F9FFF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFDAD9D9DAD9D9D1D1D1CCCACAB9B9B9A8A8A8FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF0000}
        Margin = 2
        Spacing = 8
        OnClick = btnExpDateClick
      end
    end
    object grdAccountCard: TcxGrid
      Left = 0
      Top = 0
      Width = 599
      Height = 170
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object grdAccountCardDB: TcxGridDBTableView
        DataController.DataSource = dsAccount
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDAccountCard'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSellingPrice'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubFinalCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubVendorCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubFreightCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubOtherCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubRealMarkUpValue'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSuggRetail'
          end
          item
            Format = '0'
            Kind = skSum
            Position = spFooter
            FieldName = 'PositiveQty'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSellingPrice'
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
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
        object grdAccountCardDBCardNumber: TcxGridDBColumn
          DataBinding.FieldName = 'CardNumber'
          Width = 106
        end
        object grdAccountCardDBCardDate: TcxGridDBColumn
          DataBinding.FieldName = 'CardDate'
          Visible = False
          Width = 97
        end
        object grdAccountCardDBSystemUser: TcxGridDBColumn
          DataBinding.FieldName = 'SystemUser'
          Width = 260
        end
        object grdAccountCardDBExpirationDate: TcxGridDBColumn
          DataBinding.FieldName = 'ExpirationDate'
          Width = 101
        end
        object grdAccountCardDBTotalAmount: TcxGridDBColumn
          DataBinding.FieldName = 'TotalAmount'
          Width = 102
        end
      end
      object grdAccountCardLevel: TcxGridLevel
        GridView = grdAccountCardDB
      end
    end
  end
  object gridAccountMov: TcxGrid [5]
    Left = 3
    Top = 286
    Width = 765
    Height = 218
    Align = alClient
    TabOrder = 5
    LookAndFeel.Kind = lfFlat
    object gridAccountMovDB: TcxGridDBTableView
      DataController.DataSource = dsAccountMov
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDAccountCardMov'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSellingPrice'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubFinalCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubVendorCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubFreightCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubOtherCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubRealMarkUpValue'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSuggRetail'
        end
        item
          Format = '0'
          Kind = skSum
          Position = spFooter
          FieldName = 'PositiveQty'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSellingPrice'
        end>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
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
      object gridAccountMovDBDateMov: TcxGridDBColumn
        DataBinding.FieldName = 'DateMov'
        SortOrder = soDescending
        Width = 124
      end
      object gridAccountMovDBCredit: TcxGridDBColumn
        DataBinding.FieldName = 'Credit'
        Width = 46
      end
      object gridAccountMovDBSystemUser: TcxGridDBColumn
        DataBinding.FieldName = 'SystemUser'
        Width = 183
      end
      object gridAccountMovDBObs: TcxGridDBColumn
        Caption = 'Notes'
        DataBinding.FieldName = 'Obs'
        Width = 330
      end
      object gridAccountMovDBValue: TcxGridDBColumn
        DataBinding.FieldName = 'Value'
        Width = 94
      end
      object gridAccountMovDBSaleCode: TcxGridDBColumn
        DataBinding.FieldName = 'SaleCode'
      end
    end
    object gridAccountMovLevel: TcxGridLevel
      GridView = gridAccountMovDB
    end
  end
  object pnlTitle2: TPanel [6]
    Left = 0
    Top = 270
    Width = 771
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Transaction History'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object Panel5: TPanel [7]
    Left = 0
    Top = 40
    Width = 771
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 7
    object lbUser: TLabel
      Left = 51
      Top = 8
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbSales: TLabel
      Left = 387
      Top = 32
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Card Date :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label1: TLabel
      Left = 373
      Top = 7
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = 'Card Number :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btSearch: TBitBtn
      Left = 687
      Top = 16
      Width = 74
      Height = 27
      Caption = '&Search'
      TabOrder = 0
      OnClick = btSearchClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000130B0000130B00000000000000000000FF00FF7D8497
        747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF747DAE4985D6767DAC747DAEFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4B1F75BB9FD
        4589DF707CAF747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFA0A5FA55B5FC4588DE727CAF747DAEFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        A1AFFA57B6FC4689DE747DAE747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1A5FB57B1FC468AD59385A6FF
        00FFFF00FFCEA890CEA890CEA890CEA890FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFA5ADFA95BFE4A69E9EC86DA4E0A5A3EDD5ADF0E4C2F2E7C9EBD6
        BDDE8EBECEA890FE02FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEADA9E6
        C1A0FBF0C2FFFCD1FFFFD9FFFFE7FFFFF6F8F2EED4B6B5CEA890FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFDEB6ABFFEDBCFFEFBAFFFCD0FFFFDFFFFDF2FFFF
        FFFEFEFCEEE1D0D57FB6FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E9D2B4FF
        EABAFFE4B2FFFCD1FFFFDFFFFEF6FFFDFAFFFCF3FCF6D7CBA693FF00FFFF00FF
        FF00FFFF00FFFF00FFCEA890F2E1BCFFE4B2FFE4B2FFF8C9FFFFDAFFFEE6FFFD
        EAFFFEDFFFFDD3D1B7A5FF00FFFF00FFFF00FFFF00FFFF00FFCEA890F1DFBBFF
        F1C3FFE9B6FFECB9FFF9CBFFFDD4FFFDD5FFFDD3FFF6CAD0A993FF00FFFF00FF
        FF00FFFF00FFFF00FFCEA890E7CAB6FFF9E8FFF2DAFFE2BBFFEBB5FFF0BCFFF1
        BDFFF6C4F7E4BCCDA294FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA890F4
        E7E0FEFDFCFFEACBFFE4B3FBDCADFFE8B9FCEEBEDDAA94CEA890FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E8D2CAF9EED1FFF4C3FDF2C1F2E0
        B7DFAF9BCEA890FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFCEA890CCA590CEA890D1B09DD5B1A8CEA890FF00FFFF00FF}
    end
    object scUser: TSuperComboADO
      Left = 86
      Top = 3
      Width = 147
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '<-->'
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnAllUser: TButton
      Left = 238
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 2
      TabStop = False
      OnClick = btnAllUserClick
    end
    object dtCardDate: TDateBox
      Left = 448
      Top = 29
      Width = 92
      Height = 21
      TabOrder = 3
      Visible = False
    end
    object edtCardNumber: TEdit
      Left = 448
      Top = 3
      Width = 90
      Height = 21
      TabOrder = 4
    end
  end
  object quAccounts: TADODataSet [8]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quAccountsAfterOpen
    CommandText = 
      'SELECT'#13#10#9'AC.IDAccountCard,'#13#10#9'AC.CardNumber,'#13#10'    CONVERT(date,  ' +
      'AC.CardDate, 103) as CardDate,'#13#10'    CONVERT(date, AC.ExpirationD' +
      'ate, 103) as ExpirationDate,'#13#10'    AC.Amount as TotalAmount,'#13#10'   ' +
      ' AC.Canceled,'#13#10#9'SU.SystemUser'#13#10'FROM'#13#10#9'Sal_AccountCard AC (NOLOCK' +
      ')'#13#10#9'JOIN SystemUser SU (NOLOCK) ON (AC.IDUser = SU.IDUser)'#13#10'WHER' +
      'E'#13#10'                 ( 1 = 1 ) and  isnull(AC.Canceled, 0) = 0'#13#10' ' +
      '            '
    Parameters = <>
    Left = 272
    Top = 144
    object quAccountsIDAccountCard: TIntegerField
      FieldName = 'IDAccountCard'
    end
    object quAccountsCardNumber: TStringField
      FieldName = 'CardNumber'
    end
    object quAccountsCardDate: TWideStringField
      FieldName = 'CardDate'
      ReadOnly = True
      Size = 10
    end
    object quAccountsExpirationDate: TWideStringField
      FieldName = 'ExpirationDate'
      ReadOnly = True
      Size = 10
    end
    object quAccountsTotalAmount: TBCDField
      FieldName = 'TotalAmount'
      Precision = 19
    end
    object quAccountsSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
  end
  object dsAccount: TDataSource [9]
    DataSet = quAccounts
    OnDataChange = dsAccountDataChange
    Left = 272
    Top = 192
  end
  object quAccountMov: TADODataSet [10]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'H.IDAccountCardMov,'#13#10#9'H.DateMov,'#13#10#9'H.Value,'#13#10#9'H.Credit,' +
      #13#10#9'H.Obs,'#13#10#9'SU.SystemUser,'#13#10'                 I.SaleCode'#13#10'FROM'#13#10#9 +
      'Sal_AccountCardMov H (NOLOCK)'#13#10#9'JOIN SystemUser SU (NOLOCK) ON (' +
      'H.IDUser = SU.IDUser)'#13#10'                LEFT JOIN Invoice I (NOLO' +
      'CK) ON (H.IDPreSale = I.IDPreSale) '#13#10'WHERE'#13#10#9'H.IDAccountCard = :' +
      'IDAccountCard'#13#10#13#10
    Parameters = <
      item
        Name = 'IDAccountCard'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 276
    Top = 344
    object quAccountMovIDAccountCardMov: TIntegerField
      FieldName = 'IDAccountCardMov'
    end
    object quAccountMovDateMov: TDateTimeField
      FieldName = 'DateMov'
    end
    object quAccountMovValue: TBCDField
      DisplayLabel = 'Amount'
      FieldName = 'Value'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quAccountMovCredit: TBooleanField
      FieldName = 'Credit'
    end
    object quAccountMovSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quAccountMovObs: TStringField
      FieldName = 'Obs'
      Size = 100
    end
    object quAccountMovSaleCode: TStringField
      FieldName = 'SaleCode'
    end
  end
  object dsAccountMov: TDataSource [11]
    DataSet = quAccountMov
    Left = 276
    Top = 392
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAccountCard.sil'
  end
end
