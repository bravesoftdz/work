inherited FrmAdjustMinMax: TFrmAdjustMinMax
  Left = 208
  Top = 147
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Adjust Min/Max'
  ClientHeight = 543
  ClientWidth = 790
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbManufect: TLabel [0]
    Left = 370
    Top = 72
    Width = 72
    Height = 13
    Alignment = taRightJustify
    Caption = 'Manufacturer :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbVerti: TLabel [1]
    Left = 399
    Top = 120
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vertical :'
  end
  object lbHoriz: TLabel [2]
    Left = 387
    Top = 96
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = 'Horizontal :'
  end
  object lbCategory: TLabel [3]
    Left = 42
    Top = 72
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Category :'
  end
  object lbGroup: TLabel [4]
    Left = 23
    Top = 96
    Width = 71
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Category:'
  end
  object lbStore: TLabel [5]
    Left = 61
    Top = 47
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object lbSubGroup: TLabel [6]
    Left = 61
    Top = 119
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Group:'
  end
  object lbVendor: TLabel [7]
    Left = 401
    Top = 47
    Width = 41
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vendor :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbSalePeriod: TLabel [8]
    Left = 32
    Top = 144
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sale Period :'
  end
  object lbDays: TLabel [9]
    Left = 222
    Top = 145
    Width = 3
    Height = 13
  end
  object lblMinSafetyStock: TLabel [10]
    Left = 356
    Top = 145
    Width = 85
    Height = 13
    Alignment = taRightJustify
    Caption = 'Min safety stock :'
  end
  object lblMaxSafetyStock: TLabel [11]
    Left = 496
    Top = 145
    Width = 89
    Height = 13
    Alignment = taRightJustify
    Caption = 'Max safety stock :'
  end
  object lblInDays: TLabel [12]
    Left = 636
    Top = 144
    Width = 42
    Height = 13
    Caption = '(in days)'
  end
  inherited Panel2: TPanel
    Width = 790
    TabOrder = 22
    DesignSize = (
      790
      40)
    inherited Image1: TImage
      Width = 563
    end
    inherited lblMenu: TLabel
      Left = 574
    end
    inherited EspacamentoSuperior: TPanel
      Width = 790
      inherited EEE: TPanel
        Width = 790
      end
    end
  end
  inherited Panel1: TPanel
    Top = 502
    Width = 790
    TabOrder = 24
    inherited EspacamentoInferior: TPanel
      Width = 790
      inherited Panel3: TPanel
        Width = 790
      end
    end
    inherited hhh: TPanel
      Left = 636
      Width = 154
      inherited btClose: TButton
        Left = 86
        Cancel = True
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 16
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 159
    TabOrder = 12
  end
  inherited EspacamentoDireito: TPanel
    Left = 787
    Height = 159
    TabOrder = 13
  end
  object edBarcode: TEdit [17]
    Left = 327
    Top = 172
    Width = 292
    Height = 21
    TabOrder = 11
  end
  object btSearch: TBitBtn [18]
    Left = 626
    Top = 171
    Width = 91
    Height = 24
    Caption = '&Search'
    TabOrder = 14
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
  object cbxMethod: TComboBox [19]
    Left = 98
    Top = 172
    Width = 100
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 10
    Text = 'Start with'
    Items.Strings = (
      'Start with'
      'End with'
      'Contains')
  end
  object cbxType: TComboBox [20]
    Left = 199
    Top = 172
    Width = 125
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 9
    Items.Strings = (
      'Model'
      'Description'
      'Vendor Code')
  end
  object scFabricante: TSuperComboADO [21]
    Left = 447
    Top = 69
    Width = 181
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = '<-->'
    LookUpSource = DM.dsLookUpFabricante
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btFabricanteAll: TButton [22]
    Left = 635
    Top = 70
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 15
    TabStop = False
    OnClick = btFabricanteAllClick
  end
  object scColor: TSuperComboADO [23]
    Left = 447
    Top = 117
    Width = 181
    Height = 21
    TabOrder = 6
    Text = '<-->'
    LookUpSource = DM.dsLookUpColor
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scSize: TSuperComboADO [24]
    Left = 447
    Top = 93
    Width = 181
    Height = 21
    TabOrder = 7
    Text = '<-->'
    LookUpSource = DM.dsLookUpSize
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSizeClear: TButton [25]
    Left = 634
    Top = 93
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 16
    TabStop = False
    OnClick = btnSizeClearClick
  end
  object btnColorClear: TButton [26]
    Left = 634
    Top = 118
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 17
    TabStop = False
    OnClick = btnColorClearClick
  end
  object scCategory: TSuperComboADO [27]
    Left = 99
    Top = 69
    Width = 181
    Height = 21
    TabOrder = 1
    Text = '<-->'
    LookUpSource = DM.dsLookUpGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnCategClear: TButton [28]
    Left = 290
    Top = 69
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 18
    TabStop = False
    OnClick = btnCategClearClick
  end
  object scGroup: TSuperComboADO [29]
    Left = 99
    Top = 93
    Width = 181
    Height = 21
    TabOrder = 2
    Text = '<-->'
    LookUpSource = DM.dsLookUpModelGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnGroupClear: TButton [30]
    Left = 290
    Top = 93
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 19
    TabStop = False
    OnClick = btnGroupClearClick
  end
  object scStore: TSuperComboADO [31]
    Left = 99
    Top = 44
    Width = 181
    Height = 21
    TabStop = False
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 0
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scSubGroup: TSuperComboADO [32]
    Left = 99
    Top = 116
    Width = 181
    Height = 21
    TabOrder = 3
    Text = '<-->'
    LookUpSource = DM.dsLookUpModelSubGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSubGroupClear: TButton [33]
    Left = 290
    Top = 116
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 20
    TabStop = False
    OnClick = btnSubGroupClearClick
  end
  object scVendor: TSuperComboADO [34]
    Left = 447
    Top = 44
    Width = 181
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = '<-->'
    LookUpSource = DM.dsLookUpFornecedor
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object Button1: TButton [35]
    Left = 635
    Top = 45
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 21
    TabStop = False
    OnClick = Button1Click
  end
  object dtPeriod: TDateBox [36]
    Left = 99
    Top = 140
    Width = 117
    Height = 21
    TabOrder = 8
    OnChange = dtPeriodChange
  end
  object Panel4: TPanel [37]
    Left = 0
    Top = 199
    Width = 790
    Height = 303
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 23
    object pnlButtons: TPanel
      Left = 673
      Top = 0
      Width = 117
      Height = 303
      Align = alRight
      TabOrder = 0
      object btExcel: TSpeedButton
        Tag = 7
        Left = 3
        Top = 61
        Width = 111
        Height = 26
        Hint = 'Export grid'
        Caption = 'E&xport'
        Flat = True
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btExcelClick
      end
      object btGroup: TSpeedButton
        Tag = 3
        Left = 3
        Top = 93
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 88997
        Caption = '&Grouping'
        Flat = True
        Margin = 7
        Spacing = 8
        OnClick = btGroupClick
      end
      object btColumn: TSpeedButton
        Tag = 4
        Left = 3
        Top = 118
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 1235
        Caption = 'Colum&ns'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btColumnClick
      end
      object btnApplyMax: TSpeedButton
        Tag = 4
        Left = 4
        Top = 173
        Width = 111
        Height = 25
        Caption = 'Apply Max Sug.'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnApplyMaxClick
      end
      object btnApplyMinMax: TSpeedButton
        Tag = 4
        Left = 4
        Top = 198
        Width = 111
        Height = 25
        Caption = 'Apply Min/Max'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnApplyMinMaxClick
      end
      object btSelectAll: TSpeedButton
        Tag = 7
        Left = 2
        Top = 3
        Width = 112
        Height = 26
        Hint = 'Export grid'
        Caption = 'Select all'
        Flat = True
        Glyph.Data = {
          76030000424D7603000000000000360000002800000011000000100000000100
          1800000000004003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
          FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00
          FFFF00FF808080C8D0D4FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF
          FFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFF
          FF000000000000000000000000000000FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
          00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFF000000000000FFFFFF0000
          00000000000000FFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF
          808080C8D0D4FFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFF
          FFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFC8D0D4FF00FFFF00FFFF00
          FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000FFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
          FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00
          FFFF00FF80808080808080808080808080808080808080808080808080808080
          8080808080808080FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btSelectAllClick
      end
      object btUnSelectAll: TSpeedButton
        Tag = 7
        Left = 2
        Top = 29
        Width = 112
        Height = 26
        Hint = 'Export grid'
        Caption = 'Un select all'
        Flat = True
        Glyph.Data = {
          EE030000424DEE03000000000000360000002800000012000000110000000100
          180000000000B803000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FF80808080808080808080808080808080
          8080808080808080808080808080808080808080FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btUnSelectAllClick
      end
      object btnApplyMin: TSpeedButton
        Tag = 4
        Left = 4
        Top = 148
        Width = 111
        Height = 25
        Caption = 'Apply Min Sug.'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnApplyMinClick
      end
      object pnlDivisoria2: TPanel
        Left = 8
        Top = 89
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 7
        Top = 145
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 1
      end
      object Panel6: TPanel
        Left = 8
        Top = 57
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
    object grdBrowseMinMax: TcxGrid
      Left = 0
      Top = 0
      Width = 673
      Height = 303
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object grdBrowseMinMaxDB: TcxGridDBTableView
        DataController.DataSource = dsMinMax
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'ModelID'
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
        OnFocusedItemChanged = grdBrowseMinMaxDBFocusedItemChanged
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        OnColumnHeaderClick = grdBrowseMinMaxDBColumnHeaderClick
        OnCustomization = grdBrowseMinMaxDBCustomization
        object grdBrowseMinMaxDBMarked: TcxGridDBColumn
          DataBinding.FieldName = 'Marked'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          MinWidth = 40
          Options.Moving = False
          Width = 40
        end
        object grdBrowseMinMaxDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Options.Editing = False
          Width = 88
        end
        object grdBrowseMinMaxDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Width = 201
        end
        object grdBrowseMinMaxDBModelPrice: TcxGridDBColumn
          Caption = 'Price'
          DataBinding.FieldName = 'ModelPrice'
          Options.Editing = False
          Width = 77
        end
        object grdBrowseMinMaxDBStoreSellingPrice: TcxGridDBColumn
          Caption = 'Store Price'
          DataBinding.FieldName = 'StoreSellingPrice'
          Visible = False
          Options.Editing = False
          Width = 93
        end
        object grdBrowseMinMaxDBQtyOnHand: TcxGridDBColumn
          Caption = 'On Hand'
          DataBinding.FieldName = 'QtyOnHand'
          Options.Editing = False
          Width = 62
        end
        object grdBrowseMinMaxDBTotalQtySold: TcxGridDBColumn
          Caption = 'Qty Sold'
          DataBinding.FieldName = 'TotalQtySold'
          Options.Editing = False
          Width = 60
        end
        object grdBrowseMinMaxDBAvgQtySold: TcxGridDBColumn
          Caption = 'Qty Avg'
          DataBinding.FieldName = 'AvgQtySold'
          Options.Editing = False
          Width = 60
        end
        object grdBrowseMinMaxDBMinSugg: TcxGridDBColumn
          Caption = 'Min Sugg'
          DataBinding.FieldName = 'MinSug'
          Options.Editing = False
        end
        object grdBrowseMinMaxDBMaxSugg: TcxGridDBColumn
          Caption = 'Max Sugg'
          DataBinding.FieldName = 'MaxSug'
          Options.Editing = False
        end
        object grdBrowseMinMaxDBMinQty: TcxGridDBColumn
          Caption = 'Min'
          DataBinding.FieldName = 'MinQty'
          Options.Grouping = False
          Options.Moving = False
          Width = 61
        end
        object grdBrowseMinMaxDBMaxQty: TcxGridDBColumn
          Caption = 'Max'
          DataBinding.FieldName = 'MaxQty'
          Options.Grouping = False
          Options.Moving = False
          Width = 62
        end
      end
      object grdBrowseMinMaxLevel: TcxGridLevel
        GridView = grdBrowseMinMaxDB
      end
    end
  end
  object edtMinSafetyStock: TEdit [38]
    Left = 447
    Top = 141
    Width = 38
    Height = 21
    TabOrder = 25
    OnKeyPress = edtMinSafetyStockKeyPress
  end
  object edtMaxSafetyStock: TEdit [39]
    Left = 591
    Top = 141
    Width = 38
    Height = 21
    TabOrder = 26
    OnKeyPress = edtMinSafetyStockKeyPress
  end
  object dsMinMax: TDataSource [40]
    DataSet = cdsMinMax
    Left = 313
    Top = 368
  end
  object dspMinMax: TDataSetProvider [41]
    DataSet = quMinMax
    Options = [poIncFieldProps]
    OnGetTableName = dspMinMaxGetTableName
    Left = 308
    Top = 263
  end
  object cdsMinMax: TClientDataSet [42]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMinMax'
    Left = 312
    Top = 311
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAdjustMinMax.sil'
  end
  object strepPredefined: TcxStyleRepository
    Left = 420
    Top = 259
    object cxMinMax: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object GridTableViewStyleSheetRose: TcxGridTableViewStyleSheet
      Caption = 'Rose'
      Styles.Selection = cxMinMax
    end
  end
  object quMinMax: TADODataSet
    Connection = DM.ADODBConnect
    OnCalcFields = quMinMaxCalcFields
    CommandText = 
      'SELECT'#13#10#9'CAST(0 as bit) as Marked,'#13#10#9'M.IDModel as ModelID,'#13#10#9'I.S' +
      'toreID,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.SellingPrice as ModelPri' +
      'ce,'#13#10#9'I.SellingPrice as StoreSellingPrice,'#13#10#9'I.QtyOnHand,'#13#10#9'SUM(' +
      'IM.Qty) AS TotalQtySold,'#13#10#9'P.Pessoa as Manufacture,'#13#10#9'TG.Name as' +
      ' Category,'#13#10#9'MG.ModelGroup as SubCategory,'#13#10#9'MGS.ModelSubGroup a' +
      's MGroup,'#13#10#9'I.MinQty,'#13#10#9'I.MaxQty'#13#10'FROM '#13#10#9'Inventory I (NOLOCK)'#13#10 +
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = I.ModelID) '#13#10#9'JOIN TabGro' +
      'up TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'#13#10#9'LEFT OUTER JOIN Mod' +
      'elGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup)'#13#10#9'LEFT' +
      ' OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = M' +
      'GS.IDModelSubGroup)'#13#10#9'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.ID' +
      'Pessoa = M.IDFabricante)'#13#10#9'LEFT JOIN InventoryMov IM (NOLOCK) ON' +
      ' (IM.ModelID = I.ModelID AND IM.StoreID = I.StoreID AND InventMo' +
      'vTypeID = 1)'#13#10'GROUP BY '#13#10#9'M.IDModel,'#13#10#9'I.StoreID,'#13#10#9'M.Model,'#13#10#9'M' +
      '.Description,'#13#10#9'M.SellingPrice,'#13#10#9'I.SellingPrice,'#13#10#9'I.QtyOnHand,' +
      #13#10#9'P.Pessoa,'#13#10#9'TG.Name,'#13#10#9'MG.ModelGroup,'#13#10#9'MGS.ModelSubGroup,'#13#10#9 +
      'I.MinQty,'#13#10#9'I.MaxQty'
    CommandTimeout = 380
    Parameters = <>
    Left = 212
    Top = 267
    object quMinMaxMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quMinMaxModelID: TIntegerField
      FieldName = 'ModelID'
      ReadOnly = True
    end
    object quMinMaxStoreID: TIntegerField
      FieldName = 'StoreID'
      ReadOnly = True
    end
    object quMinMaxModel: TStringField
      FieldName = 'Model'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quMinMaxDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quMinMaxModelPrice: TBCDField
      FieldName = 'ModelPrice'
      ProviderFlags = []
      ReadOnly = True
      Precision = 19
    end
    object quMinMaxStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      ProviderFlags = []
      ReadOnly = True
      Precision = 19
    end
    object quMinMaxQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ProviderFlags = []
      ReadOnly = True
    end
    object quMinMaxTotalQtySold: TFloatField
      FieldName = 'TotalQtySold'
      ProviderFlags = []
      ReadOnly = True
    end
    object quMinMaxManufacture: TStringField
      FieldName = 'Manufacture'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quMinMaxCategory: TStringField
      FieldName = 'Category'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quMinMaxSubCategory: TStringField
      FieldName = 'SubCategory'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quMinMaxMGroup: TStringField
      FieldName = 'MGroup'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quMinMaxMinQty: TFloatField
      FieldName = 'MinQty'
      ProviderFlags = [pfInUpdate]
    end
    object quMinMaxMaxQty: TFloatField
      FieldName = 'MaxQty'
      ProviderFlags = [pfInUpdate]
    end
    object quMinMaxAvgQtySold: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvgQtySold'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quMinMaxMaxSug: TFloatField
      FieldKind = fkCalculated
      FieldName = 'MaxSug'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Calculated = True
    end
    object quMinMaxMinSug: TFloatField
      FieldKind = fkCalculated
      FieldName = 'MinSug'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Calculated = True
    end
  end
  object cmdUpdateMinMax: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Inventory'#13#10'SET'#13#10#9'MinQty = :MinQty,'#13#10#9'MaxQty = :MaxQty'#13#10 +
      'WHERE'#13#10#9'StoreID = :IDStore'#13#10#9'AND ModelID = :IDModel'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'MinQty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'MaxQty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 120
    Top = 267
  end
end
