inherited FrmExportScaleItem: TFrmExportScaleItem
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export Scale Item'
  ClientWidth = 652
  KeyPreview = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 652
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 652
      inherited Panel3: TPanel
        Width = 652
      end
    end
    inherited hhh: TPanel
      Left = 427
      Width = 225
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 153
        OnClick = btCloseClick
      end
      object btExport: TButton
        Left = 83
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Export'
        TabOrder = 1
        OnClick = btExportClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 133
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 649
    Height = 133
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 652
    TabOrder = 5
  end
  object Panel2: TPanel [4]
    Left = 3
    Top = 6
    Width = 646
    Height = 133
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel5: TPanel
      Left = 534
      Top = 0
      Width = 112
      Height = 133
      Align = alRight
      TabOrder = 0
      object btMarked: TSpeedButton
        Tag = 7
        Left = 3
        Top = 2
        Width = 107
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
        OnClick = btMarkedClick
      end
      object btUnMarked: TSpeedButton
        Tag = 7
        Left = 3
        Top = 28
        Width = 107
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
        OnClick = btUnMarkedClick
      end
      object btPOColumn: TSpeedButton
        Tag = 4
        Left = 4
        Top = 62
        Width = 106
        Height = 25
        Caption = 'Colum&ns'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btPOColumnClick
      end
      object Panel9: TPanel
        Left = 7
        Top = 90
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object Panel6: TPanel
        Left = 6
        Top = 57
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 1
      end
    end
    object grdScaleItem: TcxGrid
      Left = 0
      Top = 0
      Width = 534
      Height = 133
      Align = alClient
      TabOrder = 1
      object grdScaleItemDB: TcxGridDBTableView
        DataController.DataSource = dsScaleItem
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDBarcode'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        object grdScaleItemDBMarked: TcxGridDBColumn
          DataBinding.FieldName = 'Marked'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          Properties.ReadOnly = False
          Width = 26
        end
        object grdScaleItemDBIDBarcode: TcxGridDBColumn
          DataBinding.FieldName = 'IDBarcode'
          Options.Editing = False
          Width = 59
        end
        object grdScaleItemDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Options.Editing = False
          Width = 93
        end
        object grdScaleItemDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Width = 148
        end
        object grdScaleItemDBCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Options.Editing = False
          Width = 119
        end
        object grdScaleItemDBModelPrice: TcxGridDBColumn
          Caption = 'Selling Price'
          DataBinding.FieldName = 'FinalPrice'
          Options.Editing = False
          Width = 86
        end
        object grdScaleItemDBQtyOnHand: TcxGridDBColumn
          DataBinding.FieldName = 'QtyOnHand'
          Visible = False
          Options.Editing = False
        end
        object grdScaleItemDBManufacture: TcxGridDBColumn
          DataBinding.FieldName = 'Manufacture'
          Visible = False
          Options.Editing = False
        end
        object grdScaleItemDBVendor: TcxGridDBColumn
          DataBinding.FieldName = 'Vendor'
          Visible = False
          Options.Editing = False
        end
      end
      object grdScaleItemLevel1: TcxGridLevel
        GridView = grdScaleItemDB
      end
    end
  end
  object pnlError: TPanel [5]
    Left = 0
    Top = 139
    Width = 652
    Height = 223
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Panel7: TPanel
      Left = 536
      Top = 0
      Width = 116
      Height = 223
      Align = alRight
      TabOrder = 0
      object btViewModel: TSpeedButton
        Tag = -1
        Left = 2
        Top = 3
        Width = 107
        Height = 28
        Caption = '&Model'
        Flat = True
        Glyph.Data = {
          BE080000424DBE0800000000000036000000280000001B0000001A0000000100
          18000000000088080000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF926E6F816363FF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF83A1C20C63C57E81ABAD5D5DA38E8DFF00FF000000FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8CA3C30B5EC03D99F8ACD8FAD0AD
          B0E3D6D6FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF8EA5C20D5DBE3E97F6ABD5FFF2F8FCD9E9F7FF00FFFF00FF000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8BA3C00B5CBE3E98F8A8D6FF
          F5F9FFD4E8F9FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF87A0C10F5FBF4199F8AAD5FEF0F7FDD6E7F8FF00FFFF00FFFF00FF
          FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF9777718E6B65907774FF00FFFF00FFFF00FFFF00FF7C9EC20E5FC03E97F6A8
          D4FFEBF5FEDDE9F6FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
          FF00FFFF00FFFF00FFBCB3B18F6868B28889D5BAB9EAE0DFECE2E2E9DFDFDCD0
          D0A7817E906D6985A5B9165DB63D97F3A5D3FDE7F2FDDEEDFBFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFB89FA0AF7979
          EEDADCFEFFFCFEFEFFFEFEFFFEFFFFFDFFFEFBFFFDFEF8F5E8DADBA376789469
          81A9C4E7E9F4FEDEEDFBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFC1A4A5B77979E9DFDFCEC4C1A99585A2968AAAA3A2
          BCB9BDCFCDD3D3D5D0BBC0C5A5AAB1B1A9B0C08083C08887D6DFECFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFB2
          6B68CFB6ACA87D6C9F4E13C45902BC5806A54C0C91471F7C48315B443B0D5D80
          2080A9256E934C6F8B8B6263999A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFB67B7CCA9A94B55F2FC45A02DC6D01E1
          7801E27B00D97103D46E00D2650091400E0F718A3FC1DE33BDDE2AB2D78098A6
          9B7F7CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
          FFFF00FFB77979E0CDC2C26511E57A01E58000EC8700E77F01E27900DC7700D4
          6E0098480D207C974BC9E843C3E239BDE255B9D6866967FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFB88C88EADED6CE6F
          12F88D00F88F00F98E01EE8804E98100E37A00DF7400A14B0D31879954D3E850
          CDE742C4E339BDDE907D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF000000FF00FFBA9090BD9F9CEDDED4D17514FA9A0AFC9F19F89B14F88E
          01EF8800E78300E67B00A04D0E4092A25FDBEB5CD4EB4BCBE642C5DEA6949AB8
          9D97FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFAF8988
          BAA39EEBDBD4D07E30FEB149F9B054EA9933EA8808EE8508EA8504E88001AB51
          0F57A3AB6DE3EF66D9EF59D2EA4ECCE4AD999FB18E87FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF000000FF00FFBA9797B19995E6D8D7BB7045E19E57
          D5873DC77328C16C1FC36719BC5E15B95D0D9A5D2B82D7D87CEDF371E1F165D9
          F058D3E8A99092B6908AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFA08383FEFEFEDAC0BBD1A68FD9AB93CA916EA85A329E5C34
          94896C90BCAD94EFEA95FEFD87F5F777EBF56AE3F167DAEE9E797DFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF99706FE1
          DFDDFFFFFFFFFFFFFFFFFFFFFFFFAEC8D475D9E09BFFFE9CFCFC98FFFC99FEFE
          8FF6FB83EFF77DE9F594C9D1AD6C6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFC69FA1B6A5A4FFFFFFFFFFFFFFFFFFFF
          FFFFADC7D879D8E29BFDFC96FFFD8FFCFE66F2FE57ECF863EBFB86EAF69B9CA0
          B57677FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00
          FFFF00FFFF00FFA17979C5BEBCFFFFFFFFFFFFFFFFFFABC5D775D6E384FDFE56
          F7FB1DE9FB06DBFF00D2FE06D1FD6AA1B6B67472FF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FF9774
          73C8C0BEFFFFFFFFFFFFB4CCE639A6CA1DC6DE06CAE403CDEA02CEEF00D0F44C
          A2B0B17474FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FF9E7678A59694EFEDEAFFFF
          FFC8D9EABED4E3B2D1DFB0D5E29AC3CC607C81B0716FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFA684849D8989A29392A99C9AA39391A386
          85A07270FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000}
        Margin = 3
        OnClick = btViewModelClick
      end
    end
    object cxgridError: TcxGrid
      Left = 0
      Top = 0
      Width = 536
      Height = 223
      Align = alClient
      TabOrder = 1
      object cxGridDBTableView1: TcxGridDBTableView
        DataController.DataSource = dsBarcodeErro
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDBarcode'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Preview.Column = cxGridDBTableView1MsgError
        Preview.Visible = True
        object cxGridDBTableView1IDBarcode: TcxGridDBColumn
          Caption = 'Barcode'
          DataBinding.FieldName = 'IDBarcode'
          Options.Editing = False
          Width = 83
        end
        object cxGridDBTableView1Model: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Options.Editing = False
          Width = 125
        end
        object cxGridDBTableView1Description: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Width = 205
        end
        object cxGridDBTableView1Category: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Options.Editing = False
          Width = 123
        end
        object cxGridDBTableView1MsgError: TcxGridDBColumn
          Caption = 'Error'
          DataBinding.FieldName = 'MsgError'
          Options.Editing = False
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object Panel4: TPanel [6]
    Left = 0
    Top = 362
    Width = 652
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object Label1: TLabel
      Left = 7
      Top = 6
      Width = 43
      Height = 13
      Caption = 'Export :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rbModel: TRadioButton
      Left = 80
      Top = 6
      Width = 73
      Height = 17
      Caption = 'Model'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbDescription: TRadioButton
      Left = 152
      Top = 6
      Width = 81
      Height = 17
      Caption = 'Description'
      TabOrder = 1
    end
  end
  object quScaleItem: TPowerADOQuery [7]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quScaleItemCalcFields
    CommandText = 
      'SELECT'#13#10#9'CAST(0 as Bit) as Marked,'#13#10#9'M.IDModel,'#13#10#9'B.IDBarcode,'#13#10 +
      #9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.SellingPrice as ModelPrice,'#13#10#9'M.P' +
      'romotionPrice,'#13#10#9'M.ScaleValidDay,'#13#10#9'I.SellingPrice as StoreSelli' +
      'ngPrice,'#13#10#9'I.QtyOnHand,'#13#10#9'P.Pessoa as Manufacture,'#13#10#9'TG.Name as ' +
      'Category,'#13#10#9'V.Pessoa as Vendor,'#13#10#9'V.IDPessoa as IDVendor,'#13#10#9'M.Po' +
      'rtion     '#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10#9'JOIN TabGroup TG (NOLOCK) ' +
      'ON (M.GroupID = TG.IDGroup)'#13#10#9'LEFT JOIN Pessoa P (NOLOCK) ON (P.' +
      'IDPessoa = M.IDFabricante)'#13#10#9'LEFT JOIN Barcode B (NOLOCK) ON (B.' +
      'IDModel = M.IDModel)'#13#10#9'LEFT JOIN Inventory I (NOLOCK) ON (M.IDMo' +
      'del = I.ModelID AND I.StoreID = 1)'#13#10#9'LEFT JOIN Inv_ModelVendor M' +
      'V (NOLOCK) ON (M.IDModel = MV.IDModel AND MV.VendorOrder = 1)'#13#10#9 +
      'LEFT JOIN Pessoa V (NOLOCK) ON (V.IDPessoa = MV.IDPessoa)'#13#10'WHERE' +
      #13#10#9'M.UseScale = 1'#13#10'ORDER BY'#13#10#9'M.Model, '#13#10#9'B.IDBarcode'
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftSmallint
        Size = -1
        Value = 0
      end>
    Left = 159
    Top = 49
    object quScaleItemMarked: TBooleanField
      DisplayLabel = 'M'
      FieldName = 'Marked'
    end
    object quScaleItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quScaleItemIDBarcode: TStringField
      DisplayLabel = 'Barcode'
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object quScaleItemIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quScaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quScaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quScaleItemModelPrice: TBCDField
      DisplayLabel = 'Selling Price'
      FieldName = 'ModelPrice'
      Precision = 19
    end
    object quScaleItemStoreSellingPrice: TBCDField
      DisplayLabel = 'Store SellingPrice'
      FieldName = 'StoreSellingPrice'
      Precision = 19
    end
    object quScaleItemQtyOnHand: TBCDField
      DisplayLabel = 'On Hand'
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object quScaleItemManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
    object quScaleItemCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quScaleItemVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quScaleItemPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object quScaleItemFinalPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'FinalPrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quScaleItemScaleValidDay: TIntegerField
      FieldName = 'ScaleValidDay'
    end
    object quScaleItemPortion: TStringField
      FieldName = 'Portion'
      Size = 100
    end
  end
  object dspScaleItem: TDataSetProvider [8]
    DataSet = quScaleItem
    Options = [poIncFieldProps]
    Left = 157
    Top = 100
  end
  object cdsScaleItem: TClientDataSet [9]
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDStore'
        ParamType = ptInput
        Size = -1
        Value = 0
      end>
    ProviderName = 'dspScaleItem'
    AfterOpen = cdsScaleItemAfterOpen
    Left = 157
    Top = 156
    object cdsScaleItemMarked: TBooleanField
      DisplayLabel = 'M'
      FieldName = 'Marked'
    end
    object cdsScaleItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsScaleItemIDBarcode: TStringField
      DisplayLabel = 'Barcode'
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object cdsScaleItemIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsScaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsScaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsScaleItemModelPrice: TBCDField
      DisplayLabel = 'Selling Price'
      FieldName = 'ModelPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsScaleItemStoreSellingPrice: TBCDField
      DisplayLabel = 'Store Selling Price'
      FieldName = 'StoreSellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsScaleItemQtyOnHand: TBCDField
      DisplayLabel = 'On Hand'
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object cdsScaleItemCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object cdsScaleItemManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
    object cdsScaleItemVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsScaleItemPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object cdsScaleItemFinalPrice: TCurrencyField
      FieldName = 'FinalPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object cdsScaleItemScaleValidDay: TIntegerField
      FieldName = 'ScaleValidDay'
    end
    object cdsScaleItemPortion: TStringField
      FieldName = 'Portion'
      Size = 100
    end
  end
  object dsScaleItem: TDataSource [10]
    DataSet = cdsScaleItem
    Left = 156
    Top = 209
  end
  object SaveDialog: TSaveDialog [11]
    DefaultExt = 'TXT'
    Filter = 'Text Document|*.txt'
    Left = 453
    Top = 198
  end
  object cdsBarcodeErro: TClientDataSet [12]
    Aggregates = <>
    Params = <>
    AfterOpen = cdsScaleItemAfterOpen
    Left = 165
    Top = 316
    object cdsBarcodeErroIDBarcode: TStringField
      FieldName = 'IDBarcode'
    end
    object cdsBarcodeErroIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsBarcodeErroModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsBarcodeErroDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsBarcodeErroCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object cdsBarcodeErroMsgError: TStringField
      FieldName = 'MsgError'
      Size = 255
    end
  end
  object dsBarcodeErro: TDataSource [13]
    DataSet = cdsBarcodeErro
    Left = 164
    Top = 369
  end
  object quValidateBarcode: TADODataSet [14]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'B.IDBarcode,'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10 +
      #9'TG.Name as Category '#13#10'FROM'#13#10#9'Barcode B (NOLOCK)'#13#10#9'JOIN Model M ' +
      '(NOLOCK) ON (B.IDModel = M.IDModel)'#13#10#9'JOIN TabGroup TG (NOLOCK) ' +
      'ON (M.GroupID = TG.IDGroup)'#13#10'WHERE'#13#10#9'M.UseScale = 0'#13#10#9'AND'#13#10#9'B.ID' +
      'Barcode like '#39'2%'#39#13#10#9'AND'#13#10#9'LEN(RTRIM(B.IDBarcode)) = 13'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 336
    Top = 306
    object quValidateBarcodeIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object quValidateBarcodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quValidateBarcodeModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quValidateBarcodeDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quValidateBarcodeCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmExportScaleItem.sil'
  end
  object quScaleNutriItem: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'B.IDBarcode,'#13#10#9'M.Portion, '#13#10#9'INI.Descripti' +
      'on,'#13#10#9'INI.FieldLength,'#13#10#9'IMN.QtyPortion,'#13#10#9'IMN.VDPortion'#13#10'FROM'#13#10 +
      #9'Model M (NOLOCK)'#13#10#9'JOIN Barcode B (NOLOCK) ON (B.IDModel = M.ID' +
      'Model)'#13#10#9'JOIN Inv_ModelNutrition IMN (NOLOCK) ON (M.IDModel = IM' +
      'N.IDModel)'#13#10#9'JOIN Inv_NutritionItem INI (NOLOCK) ON (IMN.IDNutri' +
      'tionItem = INI.IDNutritionItem)'#13#10'WHERE'#13#10#9'M.UseScale = 1'#13#10'AND'#13#10#9'M' +
      '.IDModel = :IDModel'#13#10'ORDER BY'#13#10#9'INI.FieldPos'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 248
    Top = 56
    object quScaleNutriItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quScaleNutriItemIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object quScaleNutriItemPortion: TStringField
      FieldName = 'Portion'
      Size = 100
    end
    object quScaleNutriItemDescription: TStringField
      FieldName = 'Description'
      Size = 100
    end
    object quScaleNutriItemFieldLength: TIntegerField
      FieldName = 'FieldLength'
    end
    object quScaleNutriItemQtyPortion: TBCDField
      FieldName = 'QtyPortion'
      Precision = 32
    end
    object quScaleNutriItemVDPortion: TBCDField
      FieldName = 'VDPortion'
      Precision = 32
    end
  end
end
