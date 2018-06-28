inherited FchPurchase: TFchPurchase
  Left = 276
  Caption = 'FchPurchase'
  ClientHeight = 599
  ClientWidth = 924
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 924
    inherited Image1: TImage
      Width = 650
    end
    inherited lblMenu: TLabel
      Left = 595
    end
    inherited EspacamentoSuperior: TPanel
      Width = 924
      inherited EEE: TPanel
        Width = 924
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 877
    end
  end
  inherited Panel1: TPanel
    Top = 558
    Width = 924
    inherited EspacamentoInferior: TPanel
      Width = 924
      inherited Panel3: TPanel
        Width = 924
      end
    end
    inherited hhh: TPanel
      Left = 703
      inherited btClose: TButton
        Default = False
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 924
    Height = 1
    inherited Panel4: TPanel
      Top = -1
      Width = 924
    end
  end
  inherited pnlDetail: TPanel
    Top = 41
    Width = 918
    Height = 59
    object Label2: TLabel
      Left = 2
      Top = 28
      Width = 50
      Height = 16
      Alignment = taRightJustify
      Caption = 'Vendor :'
    end
    object Label9: TLabel
      Left = 374
      Top = 3
      Width = 78
      Height = 16
      Alignment = taRightJustify
      Caption = 'Received on :'
    end
    object Label11: TLabel
      Left = 343
      Top = 28
      Width = 109
      Height = 16
      Alignment = taRightJustify
      Caption = 'Final Received on :'
    end
    object Label14: TLabel
      Left = 550
      Top = 3
      Width = 22
      Height = 16
      Alignment = taRightJustify
      Caption = 'by :'
    end
    object Label16: TLabel
      Left = 550
      Top = 28
      Width = 22
      Height = 16
      Alignment = taRightJustify
      Caption = 'by :'
    end
    object Label17: TLabel
      Left = 12
      Top = 3
      Width = 40
      Height = 16
      Alignment = taRightJustify
      Caption = 'Store :'
    end
    object Label22: TLabel
      Left = 338
      Top = 0
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label18: TLabel
      Left = 338
      Top = 25
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object cmbVendor: TDBSuperComboADO
      Left = 55
      Top = 25
      Width = 281
      Height = 24
      TabOrder = 0
      Text = 'cmbVendor'
      CodeLength = 80
      LookUpSource = DM.dsLookUpFornecedor
      DropDownRows = 18
      IDLanguage = 0
      OnSelectItem = cmbVendorSelectItem
      DataField = 'IDFornecedor'
      DataSource = dsForm
    end
    object DBSuperCombo2: TDBSuperComboADO
      Left = 575
      Top = 25
      Width = 171
      Height = 24
      TabStop = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
      Text = 'DBSuperCombo2'
      CodeLength = 80
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDUserFinalReceiving'
      DataSource = dsForm
    end
    object DBSuperCombo1: TDBSuperComboADO
      Left = 575
      Top = 0
      Width = 171
      Height = 24
      TabStop = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
      Text = 'DBSuperCombo1'
      CodeLength = 80
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDUserPreReceiving'
      DataSource = dsForm
    end
    object scStore: TDBSuperComboADO
      Left = 55
      Top = 0
      Width = 281
      Height = 24
      TabStop = False
      TabOrder = 3
      Text = 'scStore'
      CodeLength = 101
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = scStoreSelectItem
      DataField = 'IDStore'
      DataSource = dsForm
    end
    object dxDBDateEdit3: TDBDateBox
      Left = 457
      Top = 0
      Width = 92
      Height = 24
      Color = cl3DLight
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      DataField = 'DatePreReceiving'
      DataSource = dsForm
    end
    object dxDBDateEdit4: TDBDateBox
      Left = 457
      Top = 25
      Width = 92
      Height = 24
      Color = cl3DLight
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      DataField = 'DateFinalReceiving'
      DataSource = dsForm
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 41
    Height = 59
  end
  inherited EspacamentoDireito: TPanel
    Left = 921
    Top = 41
    Height = 59
  end
  inherited pnlPPageControl: TPanel
    Top = 100
    Width = 924
    Height = 284
    inherited PPageControl: TPageControl
      Width = 924
      Height = 284
      inherited tsBrowse: TTabSheet
        inherited Label1: TLabel
          Width = 916
        end
        inherited pnlComand: TPanel
          Left = 809
          Height = 232
          inherited btAdd: TSpeedButton
            Width = 91
          end
          object btnPrintBarcode: TSpeedButton [6]
            Left = 3
            Top = 186
            Width = 91
            Height = 23
            Caption = 'Print &Barcode'
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF840000FFFF00FF0000FF0000000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF840000FF
              FF00FF0000FF0000C6C7C6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF840000FFFF00FF0000FF0000C6C7C6FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF848684000000000000848684C6C7C6FF0000FF
              0000C6C7C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848684C6C7C6
              FFFF00C6C7C6000000848684848684C6C7C68080808080808080808080808080
              80FFFFFF000000FFFFFFFFFFFFFFFF00C6C7C6FFFF00C6C7C6000000C6C7C6FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF00FFFFFF
              FFFF00C6C7C6FFFF00000000C6C7C6C0C0C0000000000000FFFFFF000000C0C0
              C0FFFFFF000000FFFFFFFFFFFFFFFF00FFFFFFFFFF00C6C7C6000000C6C7C6C0
              C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFF848684FFFFFF
              FFFF00FFFFFF000000C6C7C6000000C0C0C0000000000000FFFFFF000000C0C0
              C0FFFFFF000000FFFFFFFFFFFF848684848684000000C6C7C6FFFFFF000000C0
              C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFFFFFFFF000000
              000000FFFFFF000000FFFFFF000000C0C0C0000000000000FFFFFF000000C0C0
              C0FFFFFF000000FFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000C0
              C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFFFFFFFF000000
              000000FFFFFF000000FFFFFF000000C0C0C0000000000000FFFFFF000000C0C0
              C0FFFFFF000000FFFFFFFFFFFF000000000000FFFFFF000000FFFFFF000000C0
              C0C0000000000000FFFFFF000000C0C0C0FFFFFF000000FFFFFFFFFFFF000000
              000000FFFFFF000000FFFFFF000000C0C0C0000000000000FFFFFF000000C0C0
              C0FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            Margin = 3
            Spacing = 5
            OnClick = btnPrintBarcodeClick
          end
          object sbAddPO: TSpeedButton [7]
            Left = 3
            Top = 210
            Width = 104
            Height = 23
            Caption = 'Import P&O'
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84828400FFFF000000000000FF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF84828400FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
              0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000FF
              FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF848284FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
              0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00
              FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00FFFF000000000000FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84
              8284FFFFFF00FFFF00FFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            Margin = 3
            Spacing = 5
            OnClick = sbAddPOClick
          end
          object btnAddQuick: TSpeedButton [9]
            Left = 93
            Top = 2
            Width = 13
            Height = 22
            Flat = True
            Glyph.Data = {
              A6000000424DA600000000000000760000002800000009000000060000000100
              04000000000030000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888808888000
              0000888000888000000088000008800000008000000080000000000000000000
              00008888888880000000}
            OnClick = btnAddQuickClick
          end
          object btnPrint: TSpeedButton [10]
            Left = 94
            Top = 186
            Width = 13
            Height = 23
            Flat = True
            Glyph.Data = {
              A6000000424DA600000000000000760000002800000009000000060000000100
              04000000000030000000C40E0000C40E00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888808888000
              0000888000888000000088000008800000008000000080000000000000000000
              00008888888880000000}
            OnClick = btnPrintClick
          end
          object btnVerify: TSpeedButton [11]
            Left = 3
            Top = 234
            Width = 104
            Height = 23
            Caption = 'Scan. Receipts'
            Flat = True
            Glyph.Data = {
              76030000424D7603000000000000360000002800000011000000100000000100
              18000000000040030000C40E0000C40E00000000000000000000CED3D6CED3D6
              CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D60000000000000000
              00000000CED3D6CED3D6CED3D600CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6
              CED3D6CED3D6CED3D6000000FFFFFFFFFFFFFFFFFFFFFFFF000000CED3D6CED3
              D600CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6000000FFFFFF
              FFFFFFFFFFFF008000FFFFFFFFFFFF000000CED3D600CED3D600000000000000
              0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF008000008000
              FFFFFFFFFFFF00000000CED3D6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
              0000FFFFFF00800000800000800000FF0000FF00008000FFFFFF00000000CED3
              D6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF00FF0000FF0000
              FF0000FF0000FF0000FF00FFFFFF00000000CED3D6000000FFFFFFFFFFFF8400
              00840000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF00FFFFFFFF
              FFFF00000000CED3D6000000FFFFFFFFFFFF840000848284FFFFFFFFFFFF0000
              00FFFFFFFFFFFFFFFFFF00FF00FFFFFFFFFFFF000000CED3D600CED3D6000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
              FFFFFFFF000000CED3D6CED3D600CED3D6000000FFFFFFFFFFFF840000840000
              FFFFFF840000840000840000000000000000000000000000CED3D6CED3D6CED3
              D600CED3D6000000FFFFFFFFFFFF840000848284FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF000000CED3D6CED3D6CED3D600CED3D6000000FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
              CED3D6CED3D6CED3D600CED3D6000000FFFFFFFFFFFF840000840000FFFFFF84
              0000840000840000840000FFFFFFFFFFFF000000CED3D6CED3D6CED3D600CED3
              D6000000FFFFFFFFFFFF840000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF000000CED3D6CED3D6CED3D600CED3D6000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000CED3D6CE
              D3D6CED3D600CED3D60000000000000000000000000000000000000000000000
              00000000000000000000000000000000CED3D6CED3D6CED3D600}
            Margin = 3
            Spacing = 5
            OnClick = btnVerifyClick
          end
          object Panel7: TPanel
            Left = 12
            Top = 183
            Width = 89
            Height = 2
            BevelOuter = bvLowered
            TabOrder = 2
          end
        end
        inherited pnlsdjhfksdhfjksdhf: TPanel
          Width = 916
        end
        inherited grdBrowse: TcxGrid
          Width = 809
          Height = 232
          inherited grdBrowseDB: TcxGridDBTableView
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDPurchaseItem'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'SubTotal'
                Column = grdBrowseDBSubTotal
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'CostPrice'
                Column = grdBrowseDBCostPrice
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'FreightCost'
                Column = grdBrowseDBFreightCost
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'OtherCost'
                Column = grdBrowseDBOtherCost
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'SubTotalRet'
                Column = grdBrowseDBSubTotalRet
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'FreightCostRet'
                Column = grdBrowseDBFreightCostRet
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'Discount'
                Column = grdBrowseDBDiscount
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'CostPriceRet'
                Column = grdBrowseDBDiscountRet
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'SubTotalCounted'
                Column = grdBrowseDBSubTotalCounted
              end>
            object grdBrowseDBIDPurchaseItem: TcxGridDBColumn
              Caption = 'ID'
              DataBinding.FieldName = 'IDPurchaseItem'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBIDPurchase: TcxGridDBColumn
              DataBinding.FieldName = 'IDPurchase'
              Visible = False
              Hidden = True
            end
            object grdBrowseDBIDModel: TcxGridDBColumn
              DataBinding.FieldName = 'IDModel'
              Visible = False
              Hidden = True
            end
            object grdBrowseDBBarCode: TcxGridDBColumn
              DataBinding.FieldName = 'BarCode'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBVendorCode: TcxGridDBColumn
              DataBinding.FieldName = 'VendorCode'
              Visible = False
              Options.Filtering = False
              Width = 72
            end
            object grdBrowseDBModel: TcxGridDBColumn
              DataBinding.FieldName = 'Model'
              Options.Filtering = False
              Width = 48
            end
            object grdBrowseDBDescription: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Options.Filtering = False
              Width = 133
            end
            object grdBrowseDBQty: TcxGridDBColumn
              Caption = 'Qty Ordered'
              DataBinding.FieldName = 'Qty'
              Options.Filtering = False
              Width = 83
            end
            object grdBrowseDBCounted: TcxGridDBColumn
              Caption = 'Qty Received'
              DataBinding.FieldName = 'Counted'
              Options.Editing = False
              Options.Filtering = False
              SortOrder = soAscending
              Width = 111
            end
            object grdBrowseDBNewCostPrice: TcxGridDBColumn
              DataBinding.FieldName = 'NewCostPrice'
              Options.Filtering = False
              Width = 128
            end
            object grdBrowseDBNewSalePrice: TcxGridDBColumn
              DataBinding.FieldName = 'NewSalePrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBNewSuggRetail: TcxGridDBColumn
              DataBinding.FieldName = 'NewSuggRetail'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSubTotal: TcxGridDBColumn
              Caption = 'SubTotal On Order'
              DataBinding.FieldName = 'SubTotal'
              Options.Filtering = False
              Width = 126
            end
            object grdBrowseDBCategory: TcxGridDBColumn
              DataBinding.FieldName = 'Category'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBManufacturer: TcxGridDBColumn
              DataBinding.FieldName = 'Manufacturer'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBCostPrice: TcxGridDBColumn
              DataBinding.FieldName = 'CostPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSubTotalTax: TcxGridDBColumn
              DataBinding.FieldName = 'SubTotalTax'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBFreightCost: TcxGridDBColumn
              DataBinding.FieldName = 'FreightCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBOtherCost: TcxGridDBColumn
              DataBinding.FieldName = 'OtherCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSubTotalRet: TcxGridDBColumn
              DataBinding.FieldName = 'SubTotalRet'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBFreightCostRet: TcxGridDBColumn
              DataBinding.FieldName = 'FreightCostRet'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBCaseQty: TcxGridDBColumn
              DataBinding.FieldName = 'CaseQty'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBCaseCost: TcxGridDBColumn
              DataBinding.FieldName = 'CaseCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBMarkUp: TcxGridDBColumn
              Caption = 'MarkUp %'
              DataBinding.FieldName = 'MarkUp'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBMargin: TcxGridDBColumn
              Caption = 'Margin %'
              DataBinding.FieldName = 'Margin'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSubTotalUnit: TcxGridDBColumn
              DataBinding.FieldName = 'SubTotalUnit'
              Visible = False
            end
            object grdBrowseDBActualCostPrice: TcxGridDBColumn
              DataBinding.FieldName = 'ActualCostPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBActualSellingPrice: TcxGridDBColumn
              DataBinding.FieldName = 'ActualSellingPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBUseLot: TcxGridDBColumn
              DataBinding.FieldName = 'UseLot'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBLot: TcxGridDBColumn
              DataBinding.FieldName = 'Lot'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBUnitCostPrice: TcxGridDBColumn
              DataBinding.FieldName = 'UnitCostPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBDiscount: TcxGridDBColumn
              DataBinding.FieldName = 'Discount'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBDiscountRet: TcxGridDBColumn
              DataBinding.FieldName = 'DiscountRet'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSubTotalCounted: TcxGridDBColumn
              DataBinding.FieldName = 'SubTotalCounted'
              Options.Filtering = False
              Width = 178
            end
          end
        end
      end
    end
  end
  object Panel5: TPanel [7]
    Left = 0
    Top = 384
    Width = 924
    Height = 174
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    DesignSize = (
      924
      174)
    object Label6: TLabel
      Left = 542
      Top = 98
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total'
      FocusControl = edTotal
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape1: TShape
      Left = 518
      Top = 91
      Width = 211
      Height = 3
      Brush.Color = clBtnShadow
      Pen.Style = psClear
    end
    object Label5: TLabel
      Left = 494
      Top = 69
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Other Charges'
      FocusControl = edOther
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 714
      Top = 94
      Width = 15
      Height = 20
      Caption = '='
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnShadow
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
    end
    object Label23: TLabel
      Left = 714
      Top = 22
      Width = 15
      Height = 20
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnShadow
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
    end
    object Label4: TLabel
      Left = 535
      Top = 47
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Freight'
      FocusControl = edFreight
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 524
      Top = 24
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'SubTotal'
      FocusControl = edSubTotal
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 714
      Top = 44
      Width = 15
      Height = 20
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnShadow
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
    end
    object Label8: TLabel
      Left = 714
      Top = 67
      Width = 15
      Height = 20
      Caption = '+'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnShadow
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
    end
    object lbTotalCounted: TLabel
      Left = 481
      Top = 150
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Total Received'
      FocusControl = edtTotalTaxInCost
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edTotal: TEdit
      Left = 580
      Top = 97
      Width = 129
      Height = 22
      TabStop = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edPercOther: TEdit
      Left = 580
      Top = 67
      Width = 54
      Height = 21
      TabStop = False
      Color = clSilver
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edOther: TDBEdit
      Left = 634
      Top = 66
      Width = 75
      Height = 21
      DataField = 'OtherCharges'
      DataSource = dsForm
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edOtherChange
    end
    object edSubTotal: TEdit
      Left = 580
      Top = 21
      Width = 129
      Height = 21
      TabStop = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edFreight: TDBEdit
      Left = 634
      Top = 43
      Width = 75
      Height = 21
      DataField = 'Freight'
      DataSource = dsForm
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edFreightChange
    end
    object edPercFreight: TEdit
      Left = 580
      Top = 44
      Width = 54
      Height = 21
      TabStop = False
      Color = clSilver
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object pgPurchase: TPageControl
      Left = 5
      Top = 0
      Width = 439
      Height = 149
      ActivePage = tsTax
      TabOrder = 6
      OnChange = pgPurchaseChange
      object tsPurchaseInfo: TTabSheet
        Caption = 'Receiving &Information'
        object pnlReceiveType: TPanel
          Left = 0
          Top = 0
          Width = 431
          Height = 118
          Align = alClient
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 0
          object Label19: TLabel
            Left = 202
            Top = 5
            Width = 14
            Height = 23
            Hint = 'Field can not be empty'
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object lbDocType: TLabel
            Left = 27
            Top = 6
            Width = 61
            Height = 13
            Alignment = taRightJustify
            Caption = 'Doc. Type :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object pnlCOD: TPanel
            Left = 0
            Top = 22
            Width = 390
            Height = 99
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            Visible = False
            object Label30: TLabel
              Left = 39
              Top = 12
              Width = 48
              Height = 13
              Alignment = taRightJustify
              Caption = 'C.O.D. # :'
              FocusControl = DBEdit3
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label31: TLabel
              Left = 188
              Top = 10
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object Label32: TLabel
              Left = 188
              Top = 39
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object Label33: TLabel
              Left = 26
              Top = 42
              Width = 61
              Height = 13
              Alignment = taRightJustify
              Caption = 'C.O.D. total :'
              FocusControl = DBEdit4
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label36: TLabel
              Left = 188
              Top = 70
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object Label37: TLabel
              Left = 31
              Top = 71
              Width = 55
              Height = 13
              Alignment = taRightJustify
              Caption = 'Issue date :'
              FocusControl = DBEdit4
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object DBEdit3: TDBEdit
              Left = 91
              Top = 9
              Width = 95
              Height = 24
              DataField = 'DocumentNumber'
              DataSource = dsForm
              TabOrder = 0
            end
            object DBEdit4: TDBEdit
              Left = 91
              Top = 38
              Width = 95
              Height = 24
              DataField = 'DocumentTotal'
              DataSource = dsForm
              TabOrder = 1
            end
            object dxDBDateEdit6: TDBDateBox
              Left = 91
              Top = 68
              Width = 96
              Height = 24
              ReadOnly = False
              TabOrder = 2
              DataField = 'DocumentDate'
              DataSource = dsForm
            end
          end
          object pnlPackSl: TPanel
            Left = 0
            Top = 23
            Width = 390
            Height = 78
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            Visible = False
            object lblDocumentNumber: TLabel
              Left = 11
              Top = 20
              Width = 75
              Height = 13
              Alignment = taRightJustify
              Caption = 'Packing Slip # :'
              FocusControl = edDocumentNumber
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblDocumentNumberObri: TLabel
              Left = 186
              Top = 18
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object edDocumentNumber: TDBEdit
              Left = 91
              Top = 17
              Width = 94
              Height = 24
              DataField = 'DocumentNumber'
              DataSource = dsForm
              TabOrder = 0
            end
          end
          object cbPurType: TComboBox
            Left = 91
            Top = 4
            Width = 110
            Height = 24
            Style = csDropDownList
            ItemHeight = 16
            TabOrder = 3
            OnChange = cbPurTypeChange
            OnCloseUp = cbPurTypeCloseUp
            Items.Strings = (
              'Invoice'
              'Packing Slip'
              'C.O.D')
          end
          object pnlInvoice: TPanel
            Left = 0
            Top = 25
            Width = 431
            Height = 96
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            Visible = False
            object Label10: TLabel
              Left = 36
              Top = 10
              Width = 51
              Height = 13
              Alignment = taRightJustify
              Caption = 'Invoice # :'
              FocusControl = dbedInvoice
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label20: TLabel
              Left = 185
              Top = 8
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object Label24: TLabel
              Left = 185
              Top = 66
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object Label25: TLabel
              Left = 23
              Top = 68
              Width = 64
              Height = 13
              Alignment = taRightJustify
              Caption = 'Invoice total :'
              FocusControl = dbInvoiceTotal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label28: TLabel
              Left = 185
              Top = 36
              Width = 14
              Height = 23
              Hint = 'Field can not be empty'
              Caption = '*'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -19
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object Label29: TLabel
              Left = 22
              Top = 37
              Width = 65
              Height = 13
              Alignment = taRightJustify
              Caption = 'Invoice date :'
              FocusControl = dbInvoiceTotal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object dbedInvoice: TDBEdit
              Left = 91
              Top = 7
              Width = 94
              Height = 24
              DataField = 'DocumentNumber'
              DataSource = dsForm
              TabOrder = 0
            end
            object dbInvoiceTotal: TDBEdit
              Left = 91
              Top = 65
              Width = 94
              Height = 24
              DataField = 'DocumentTotal'
              DataSource = dsForm
              TabOrder = 2
              OnKeyDown = dbInvoiceTotalKeyDown
            end
            object dxInvoiceDate: TDBDateBox
              Left = 91
              Top = 35
              Width = 94
              Height = 24
              ReadOnly = False
              TabOrder = 1
              DataField = 'DocumentDate'
              DataSource = dsForm
            end
            object grDueDate: TcxGrid
              Left = 212
              Top = 0
              Width = 194
              Height = 94
              TabOrder = 3
              object grDueDateDBTableView1: TcxGridDBTableView
                DataController.DataSource = dsDueDate
                DataController.Filter.Criteria = {FFFFFFFF0000000000}
                DataController.KeyFieldNames = 'IDPurchaseDueDate'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.Inserting = False
                OptionsView.ColumnAutoWidth = True
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                object grDueDateDBTableView1DBDate: TcxGridDBColumn
                  Caption = 'Due Date'
                  DataBinding.FieldName = 'Date'
                  PropertiesClassName = 'TcxDateEditProperties'
                  Options.Filtering = False
                end
                object grDueDateDBTableView1DBAmount: TcxGridDBColumn
                  DataBinding.FieldName = 'Amount'
                  Options.Filtering = False
                end
              end
              object grDueDateLevel1: TcxGridLevel
                GridView = grDueDateDBTableView1
              end
            end
            object btnNewDueDate: TBitBtn
              Left = 408
              Top = 0
              Width = 23
              Height = 21
              TabOrder = 4
              TabStop = False
              OnClick = btnNewDueDateClick
              Glyph.Data = {
                B6020000424DB60200000000000036000000280000000D000000100000000100
                18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
                D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
                DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
                D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
                FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
                7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
                FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
                E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
                EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
                FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
                8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
                FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
                F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
                FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
                FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
                7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
                F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
                E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
                9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
            end
            object btnDelDueDate: TBitBtn
              Left = 408
              Top = 23
              Width = 23
              Height = 21
              TabOrder = 5
              TabStop = False
              OnClick = btnDelDueDateClick
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
            end
          end
        end
      end
      object tsTax: TTabSheet
        Caption = 'Taxes'
        ImageIndex = 2
        object grdSpecialPrice: TSMDBGrid
          Left = 0
          Top = 0
          Width = 431
          Height = 118
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsTax
          FixedColor = 14607076
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Flat = True
          Groupings = <>
          GridStyle.Style = gsCustom
          GridStyle.OddColor = clWindow
          GridStyle.EvenColor = 14607076
          FooterColor = clBtnFace
          ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
          RegistryKey = 'Software\Scalabium'
          RegistrySection = 'SMDBGrid'
          WidthOfIndicator = 11
          DefaultRowHeight = 17
          ScrollBars = ssVertical
          ColCount = 2
          RowCount = 2
          Columns = <
            item
              Expanded = False
              FieldName = 'TaxCategory'
              Width = 271
              Visible = True
              FooterType = ftCustom
            end
            item
              Expanded = False
              FieldName = 'TaxValue'
              Width = 159
              Visible = True
              FooterType = ftCustom
            end>
        end
      end
      object tsVendorTerm: TTabSheet
        Caption = '&Vendor Terms'
        ImageIndex = 1
        object pnlTerms: TPanel
          Left = 0
          Top = 0
          Width = 431
          Height = 118
          Align = alClient
          Color = 14607076
          TabOrder = 0
          object btNew: TSpeedButton
            Left = 355
            Top = 3
            Width = 70
            Height = 18
            Caption = 'New'
            Enabled = False
            Flat = True
            Glyph.Data = {
              B6020000424DB60200000000000036000000280000000D000000100000000100
              18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
              D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
              DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
              D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
              FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
              7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
              FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
              E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
              EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
              FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
              8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
              FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
              F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
              FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
              FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
              7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
              F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
              E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
              9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
            Margin = 3
            OnClick = btNewClick
          end
          object btDelete: TSpeedButton
            Tag = 2
            Left = 355
            Top = 21
            Width = 70
            Height = 17
            Caption = 'Remove'
            Enabled = False
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
            Margin = 3
            OnClick = btDeleteClick
          end
          object btPost: TSpeedButton
            Left = 355
            Top = 59
            Width = 70
            Height = 20
            Caption = 'Ok'
            Flat = True
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333333333333333330000333333333333333333333333F33333333333
              00003333344333333333333333388F3333333333000033334224333333333333
              338338F3333333330000333422224333333333333833338F3333333300003342
              222224333333333383333338F3333333000034222A22224333333338F338F333
              8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
              33333338F83338F338F33333000033A33333A222433333338333338F338F3333
              0000333333333A222433333333333338F338F33300003333333333A222433333
              333333338F338F33000033333333333A222433333333333338F338F300003333
              33333333A222433333333333338F338F00003333333333333A22433333333333
              3338F38F000033333333333333A223333333333333338F830000333333333333
              333A333333333333333338330000333333333333333333333333333333333333
              0000}
            Margin = 3
            NumGlyphs = 2
            OnClick = btPostClick
          end
          object btCancelPost: TSpeedButton
            Tag = 2
            Left = 355
            Top = 80
            Width = 70
            Height = 20
            Caption = 'Cancel'
            Flat = True
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000010000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              333333333333333333333333000033338833333333333333333F333333333333
              0000333911833333983333333388F333333F3333000033391118333911833333
              38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
              911118111118333338F3338F833338F3000033333911111111833333338F3338
              3333F8330000333333911111183333333338F333333F83330000333333311111
              8333333333338F3333383333000033333339111183333333333338F333833333
              00003333339111118333333333333833338F3333000033333911181118333333
              33338333338F333300003333911183911183333333383338F338F33300003333
              9118333911183333338F33838F338F33000033333913333391113333338FF833
              38F338F300003333333333333919333333388333338FFF830000333333333333
              3333333333333333333888330000333333333333333333333333333333333333
              0000}
            Margin = 3
            NumGlyphs = 2
          end
          object brImport: TSpeedButton
            Left = 355
            Top = 39
            Width = 70
            Height = 19
            Caption = 'Import'
            Flat = True
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000C40E0000C40E000000000000000000008000FF8000FF
              8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000
              FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80000080
              00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
              8000FF8000FF8000FF8000008000008000008000FF8000FF8000FF8000FF8000
              FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80000080000080000080
              00008000008000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
              8000FF8000008000008000008000008000008000008000008000FF8000FF8000
              FF8000FF8000FF8000FF8000FF8000FF80000080000080000080000080000080
              00008000008000008000008000FF8000FF8000FF8000FF8000FF8000FF8000FF
              8000FF8000FF8000FF8000008000008000008000FF8000FF8000FF8000FF8000
              FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80000080000080
              00008000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
              8000FF8000FF8000FF714A42800000800000714A428000FF8000FF8000FF8000
              FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF714A4280000080
              0000800000714A42714A428000008000008000FF8000FF8000FF8000FF8000FF
              8000FF8000FF8000FF8000FF714A428000008000008000008000008000008000
              008000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF714A4280
              00008000008000008000008000008000008000FF8000FF8000FF8000FF8000FF
              8000FF8000FF8000FF8000FF8000FF714A428000008000008000008000008000
              008000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
              00FF714A42714A428000008000008000008000FF8000FF8000FF8000FF8000FF
              8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000
              FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
              00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF}
            Margin = 3
            OnClick = brImportClick
          end
          object grdTerm: TSMDBGrid
            Left = 1
            Top = 1
            Width = 348
            Height = 116
            Align = alLeft
            BorderStyle = bsNone
            DataSource = dsTerm
            Options = [dgEditing, dgTitles, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = grdTermKeyDown
            Flat = True
            Groupings = <>
            GridStyle.Style = gsCustom
            GridStyle.OddColor = clWindow
            GridStyle.EvenColor = clWindow
            FooterColor = clBtnFace
            ExOptions = [eoAutoWidth, eoKeepSelection]
            RegistryKey = 'Software\Scalabium'
            RegistrySection = 'SMDBGrid'
            WidthOfIndicator = 11
            DefaultRowHeight = 20
            ScrollBars = ssVertical
            ColCount = 2
            RowCount = 2
            Columns = <
              item
                Expanded = False
                FieldName = 'DueDateShift'
                Width = 204
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Discount'
                Width = 126
                Visible = True
                FooterType = ftCustom
              end>
          end
        end
      end
      object tsReturnInfo: TTabSheet
        Caption = '&Return Info'
        ImageIndex = 3
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 431
          Height = 118
          Align = alClient
          BevelOuter = bvNone
          Color = 14607076
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label44: TLabel
            Left = 171
            Top = 6
            Width = 14
            Height = 23
            Hint = 'Field can not be empty'
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object Label13: TLabel
            Left = 226
            Top = 44
            Width = 30
            Height = 10
            Alignment = taRightJustify
            Caption = 'Freight :'
          end
          object Label34: TLabel
            Left = 199
            Top = 63
            Width = 57
            Height = 10
            Alignment = taRightJustify
            Caption = 'Other Charges :'
          end
          object Label43: TLabel
            Left = 20
            Top = 8
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'Invoice # :'
            FocusControl = DBEdit8
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label35: TLabel
            Left = 231
            Top = 107
            Width = 25
            Height = 10
            Alignment = taRightJustify
            Caption = 'Total :'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Shape2: TShape
            Left = 200
            Top = 100
            Width = 169
            Height = 3
            Brush.Color = clBtnShadow
            Pen.Style = psClear
          end
          object Label12: TLabel
            Left = 217
            Top = 7
            Width = 39
            Height = 10
            Alignment = taRightJustify
            Caption = 'Sub Total :'
          end
          object Label38: TLabel
            Left = 351
            Top = 0
            Width = 15
            Height = 20
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -17
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object Label39: TLabel
            Left = 351
            Top = 39
            Width = 15
            Height = 20
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -17
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object Label40: TLabel
            Left = 351
            Top = 59
            Width = 15
            Height = 20
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -17
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object Label41: TLabel
            Left = 351
            Top = 103
            Width = 15
            Height = 20
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -17
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object Label42: TLabel
            Left = 237
            Top = 25
            Width = 19
            Height = 10
            Alignment = taRightJustify
            Caption = 'Tax :'
          end
          object Label45: TLabel
            Left = 351
            Top = 20
            Width = 15
            Height = 20
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -17
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object Label54: TLabel
            Left = 43
            Top = 37
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = 'Date :'
            FocusControl = DBEdit8
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label55: TLabel
            Left = 172
            Top = 34
            Width = 14
            Height = 23
            Hint = 'Field can not be empty'
            Caption = '*'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -19
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object lbDiscountRet: TLabel
            Left = 220
            Top = 82
            Width = 36
            Height = 10
            Alignment = taRightJustify
            Caption = 'Discount :'
          end
          object Label57: TLabel
            Left = 354
            Top = 78
            Width = 8
            Height = 20
            Caption = '-'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnShadow
            Font.Height = -17
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object DBEdit8: TDBEdit
            Left = 77
            Top = 5
            Width = 91
            Height = 21
            DataField = 'DocumentNumberRet'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object edtOtherCostRet: TDBEdit
            Left = 264
            Top = 60
            Width = 81
            Height = 18
            TabStop = False
            Color = clSilver
            DataField = 'OtherChargesRet'
            DataSource = dsForm
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object edtSubTotalRet: TEdit
            Left = 264
            Top = 3
            Width = 81
            Height = 18
            TabStop = False
            Color = clSilver
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'edtSubTotalRet'
          end
          object edtTotalRet: TEdit
            Left = 264
            Top = 103
            Width = 81
            Height = 18
            TabStop = False
            Color = clSilver
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Text = 'edtSubTotalRet'
          end
          object edtTaxRet: TEdit
            Left = 264
            Top = 21
            Width = 81
            Height = 18
            TabStop = False
            Color = clSilver
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object DBDateBox1: TDBDateBox
            Left = 77
            Top = 33
            Width = 93
            Height = 21
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = False
            TabOrder = 5
            DataField = 'DocumentDueDateRet'
            DataSource = dsForm
          end
          object edtFreightRet: TEdit
            Left = 264
            Top = 40
            Width = 81
            Height = 18
            TabStop = False
            Color = clSilver
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object edtDiscountRet: TEdit
            Left = 264
            Top = 79
            Width = 81
            Height = 18
            TabStop = False
            Color = clSilver
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -8
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
        end
      end
      object tsComplement: TTabSheet
        Caption = 'Complement'
        ImageIndex = 4
        object lblCFOP: TLabel
          Left = 20
          Top = 15
          Width = 40
          Height = 16
          Alignment = taRightJustify
          Caption = 'CFOP :'
        end
        object scCFOP: TDBSuperComboADO
          Left = 64
          Top = 11
          Width = 189
          Height = 24
          TabOrder = 0
          Text = 'scCFOP'
          LookUpSource = DM.dsLookUpCFOP
          DropDownRows = 18
          MostraDesativado = STD_AMBOSDESATIVADO
          MostraHidden = STD_AMBOSHIDDEN
          IDLanguage = 0
          DataField = 'IDCFOP'
          DataSource = dsForm
        end
      end
    end
    object pnlTaxInCost: TPanel
      Left = 476
      Top = 6
      Width = 258
      Height = 143
      BevelOuter = bvNone
      TabOrder = 7
      DesignSize = (
        258
        143)
      object Label46: TLabel
        Left = 45
        Top = 5
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'SubTotal'
        FocusControl = edtSubTotalInCost
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label47: TLabel
        Left = 229
        Top = 2
        Width = 15
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBtnShadow
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Shape3: TShape
        Left = 33
        Top = 115
        Width = 211
        Height = 3
        Anchors = [akTop, akRight]
        Brush.Color = clBtnShadow
        Pen.Style = psClear
      end
      object Label48: TLabel
        Left = 229
        Top = 120
        Width = 15
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '='
        Font.Charset = ANSI_CHARSET
        Font.Color = clBtnShadow
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label49: TLabel
        Left = 4
        Top = 123
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total On Order'
        FocusControl = edtTotalTaxInCost
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label50: TLabel
        Left = 56
        Top = 28
        Width = 38
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Freight'
        FocusControl = edFreight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label51: TLabel
        Left = 73
        Top = 96
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Tax'
        FocusControl = edFreight
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label52: TLabel
        Left = 229
        Top = 25
        Width = 15
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBtnShadow
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object Label53: TLabel
        Left = 230
        Top = 93
        Width = 15
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBtnShadow
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object lbOtherInCost: TLabel
        Left = 14
        Top = 50
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Other Charges'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label27: TLabel
        Left = 230
        Top = 48
        Width = 15
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBtnShadow
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object btnCalcFreight: TSpeedButton
        Left = 205
        Top = 26
        Width = 23
        Height = 21
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
        OnClick = btnCalcFreightClick
      end
      object btnCalcOther: TSpeedButton
        Left = 205
        Top = 49
        Width = 23
        Height = 21
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
        OnClick = btnCalcFreightClick
      end
      object lbDiscount: TLabel
        Left = 46
        Top = 72
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Discount'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnCalcDiscount: TSpeedButton
        Left = 205
        Top = 71
        Width = 23
        Height = 21
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
        OnClick = btnCalcFreightClick
      end
      object Label56: TLabel
        Left = 233
        Top = 70
        Width = 8
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBtnShadow
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
      end
      object edtSubTotalInCost: TEdit
        Left = 100
        Top = 2
        Width = 128
        Height = 21
        TabStop = False
        Anchors = [akTop, akRight]
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtTotalTaxInCost: TEdit
        Left = 100
        Top = 120
        Width = 127
        Height = 22
        TabStop = False
        Anchors = [akTop, akRight]
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object edtFreightInCost: TEdit
        Left = 100
        Top = 25
        Width = 105
        Height = 21
        TabStop = False
        Anchors = [akTop, akRight]
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        OnKeyDown = edtFreightInCostKeyDown
      end
      object edtTaxInCost: TEdit
        Left = 100
        Top = 93
        Width = 127
        Height = 21
        TabStop = False
        Anchors = [akTop, akRight]
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object edtOtherInCost: TEdit
        Left = 100
        Top = 48
        Width = 105
        Height = 21
        TabStop = False
        Anchors = [akTop, akRight]
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        OnKeyDown = edtOtherInCostKeyDown
      end
      object edtDiscount: TEdit
        Left = 100
        Top = 70
        Width = 105
        Height = 21
        TabStop = False
        Anchors = [akTop, akRight]
        Color = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
    end
    object edtTotalCounted: TEdit
      Left = 577
      Top = 150
      Width = 127
      Height = 22
      TabStop = False
      Anchors = [akTop, akRight]
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPurchase.sil'
    TranslationData = {
      737443617074696F6E730D0A5462727746726D506172656E7442727701627277
      46726D506172656E744272770101010D0A50616E656C31010101010D0A6C626C
      557365724E616D65016C626C557365724E616D650101010D0A4C6162656C3135
      01557365723A0101010D0A4573706163616D656E746F496E666572696F720101
      01010D0A50616E656C33010101010D0A686868010101010D0A737048656C7001
      2648656C700101010D0A627443616E63656C0143616E63656C0101010D0A6274
      436C6F736501536176650101010D0A706E6C4E617669676174696F6E01010101
      0D0A62744669727374526563013C3C0101010D0A62745072696F72526563013C
      0101010D0A62744E657874526563013E0101010D0A62744C617374526563013E
      3E0101010D0A50616E656C32010101010D0A6C626C5375624D656E75014D6169
      6E204D656E750101010D0A6C626C4D656E75014669727374204D656E75204974
      656D0101010D0A4573706163616D656E746F5375706572696F72010101010D0A
      454545010101010D0A706E6C4175746F496E63010101010D0A62744C6F6F7049
      6E63010101010D0A6C626C4D6F6469666965640145646974204D6F6465010101
      0D0A706E6C4B6579010101010D0A50616E656C34010101010D0A706E6C446574
      61696C010101010D0A4573706163616D656E746F457371756572646F01010101
      0D0A4573706163616D656E746F4469726569746F010101010D0A706E6C505061
      6765436F6E74726F6C01706E6C5050616765436F6E74726F6C0101010D0A7473
      42726F77736501747342726F7773650101010D0A4C6162656C31014368616E67
      6520666F722074686520636F7272656374206E616D650101010D0A706E6C436F
      6D616E64010101010D0A627441646401463220264164640101010D0A62744465
      7461696C014633202644657461696C73200101010D0A627452656D6F76650146
      34205265266D6F76650101010D0A627447726F7570012647726F7570696E6701
      01010D0A6274436F6C756D6E0126436F6C756D6E730101010D0A627450726576
      6965770146352026507265766965770101010D0A50616E656C38010101010D0A
      50616E656C36010101010D0A706E6C73646A68666B736468666A6B7364686601
      0101010D0A737448696E74730D0A5462727746726D506172656E744272770101
      0D0A50616E656C31010101010D0A6C626C557365724E616D65010101010D0A4C
      6162656C3135010101010D0A4573706163616D656E746F496E666572696F7201
      0101010D0A50616E656C33010101010D0A686868010101010D0A737048656C70
      010101010D0A627443616E63656C010101010D0A6274436C6F7365010101010D
      0A706E6C4E617669676174696F6E010101010D0A62744669727374526563014D
      6F766520746F204669727374205265636F72640101010D0A62745072696F7252
      6563014D6F766520746F205072696F72205265636F72640101010D0A62744E65
      7874526563014D6F766520746F204E657874205265636F72640101010D0A6274
      4C617374526563014D6F766520746F204C617374205265636F72640101010D0A
      50616E656C32010101010D0A496D61676531010101010D0A6C626C5375624D65
      6E75010101010D0A6C626C4D656E75010101010D0A4573706163616D656E746F
      5375706572696F72010101010D0A454545010101010D0A706E6C4175746F496E
      63015072657373206865726520746F20636F6E74696E75696E6720696E736572
      7420646174610101010D0A62744C6F6F70496E6301436F6E74696E75696E6720
      696E73657274206461746120776974686F757420636C6F73696E672074686520
      73637265656E2E0101010D0A6C626C4D6F646966696564010101010D0A706E6C
      4B6579010101010D0A50616E656C34010101010D0A706E6C44657461696C0101
      01010D0A4573706163616D656E746F457371756572646F010101010D0A457370
      6163616D656E746F4469726569746F010101010D0A706E6C5050616765436F6E
      74726F6C010101010D0A5050616765436F6E74726F6C010101010D0A74734272
      6F777365010101010D0A4C6162656C31010101010D0A706E6C436F6D616E6401
      0101010D0A6274416464010101010D0A627444657461696C010101010D0A6274
      52656D6F7665010101010D0A627447726F7570010101010D0A6274436F6C756D
      6E010101010D0A627450726576696577010101010D0A50616E656C3801010101
      0D0A50616E656C36010101010D0A706E6C73646A68666B736468666A6B736468
      66010101010D0A7374446973706C61794C6162656C730D0A7374466F6E74730D
      0A5462727746726D506172656E74427277015461686F6D610101010D0A6C626C
      557365724E616D6501417269616C0101010D0A4C6162656C313501417269616C
      0101010D0A627443616E63656C015461686F6D610101010D0A6274436C6F7365
      015461686F6D610101010D0A6274466972737452656301417269616C0101010D
      0A62745072696F7252656301417269616C0101010D0A62744E65787452656301
      417269616C0101010D0A62744C61737452656301417269616C0101010D0A6C62
      6C5375624D656E750156657264616E610101010D0A6C626C4D656E7501566572
      64616E610101010D0A6C626C4D6F64696669656401536D616C6C20466F6E7473
      0101010D0A4C6162656C31015461686F6D610101010D0A73744D756C74694C69
      6E65730D0A7175466F726D2E46696C7465724669656C6473010101010D0A7175
      466F726D2E46696C74657256616C756573010101010D0A466F726D436F6E6669
      672E446570656E64656E745461626C654B657973010101010D0A466F726D436F
      6E6669672E446570656E64656E745461626C6573010101010D0A466F726D436F
      6E6669672E52657175697265644669656C6473010101010D0A466F726D436F6E
      6669672E556E697175654669656C6473010101010D0A717542726F7773652E46
      696C7465724669656C6473010101010D0A717542726F7773652E46696C746572
      56616C756573010101010D0A7374446C677343617074696F6E730D0A5761726E
      696E67015761726E696E670101010D0A4572726F72014572726F720101010D0A
      496E666F726D6174696F6E01496E666F726D6174696F6E0101010D0A436F6E66
      69726D01436F6E6669726D0101010D0A59657301265965730101010D0A4E6F01
      264E6F0101010D0A4F4B014F4B0101010D0A43616E63656C0143616E63656C01
      01010D0A41626F7274012641626F72740101010D0A5265747279012652657472
      790101010D0A49676E6F7265012649676E6F72650101010D0A416C6C0126416C
      6C0101010D0A4E6F20546F20416C6C014E266F20746F20416C6C0101010D0A59
      657320546F20416C6C0159657320746F2026416C6C0101010D0A48656C700126
      48656C700101010D0A7374537472696E67730D0A73744F74686572537472696E
      67730D0A7175466F726D2E436F6D6D616E6454657874010101010D0A7175466F
      726D2E436F6E6E656374696F6E537472696E67010101010D0A7175466F726D2E
      46696C746572010101010D0A7175466F726D2E496E6465784669656C644E616D
      6573010101010D0A7175466F726D2E4B65794669656C6473010101010D0A466F
      726D436F6E6669672E456E7469646164654E6F6D65010101010D0A717542726F
      7773652E436F6D6D616E6454657874010101010D0A717542726F7773652E436F
      6E6E656374696F6E537472696E67010101010D0A717542726F7773652E46696C
      746572010101010D0A717542726F7773652E496E6465784669656C644E616D65
      73010101010D0A717542726F7773652E4B65794669656C6473010101010D0A53
      442E46696C746572014D6963726F736F667420457863656C7C2A2E786C730101
      010D0A53442E5469746C65010101010D0A73744C6F63616C65730D0A43757272
      656E637920537472696E6701240101010D0A54686F7573616E64205365706172
      61746F72012C0101010D0A446563696D616C20536570617261746F72012E0101
      010D0A4461746520536570617261746F72012F0101010D0A53686F7274204461
      746520466F726D6174014D2F642F797979790101010D0A4C6F6E672044617465
      20466F726D617401646464642C204D4D4D4D2064642C20797979790101010D0A
      54696D6520536570617261746F72013A0101010D0A54696D6520414D20537472
      696E6701414D0101010D0A54696D6520504D20537472696E6701504D0101010D
      0A53686F72742054696D6520466F726D617401683A6D6D20414D504D0101010D
      0A4C6F6E672054696D6520466F726D617401683A6D6D3A737320414D504D0101
      010D0A53686F7274204D6F6E7468204E616D6573014A616E2C4665622C4D6172
      2C4170722C4D61792C4A756E2C4A756C2C4175672C5365702C4F63742C4E6F76
      2C4465630101010D0A4C6F6E67204D6F6E7468204E616D6573014A616E756172
      792C46656272756172792C4D617263682C417072696C2C4D61792C4A756E652C
      4A756C792C4175677573742C53657074656D6265722C4F63746F6265722C4E6F
      76656D6265722C446563656D6265720101010D0A53686F727420446179204E61
      6D65730153756E2C4D6F6E2C5475652C5765642C5468752C4672692C53617401
      01010D0A4C6F6E6720446179204E616D65730153756E6461792C4D6F6E646179
      2C547565736461792C5765646E65736461792C54687572736461792C46726964
      61792C53617475726461790101010D0A7374436F6C6C656374696F6E730D0A73
      7443686172536574730D0A5462727746726D506172656E7442727701414E5349
      5F434841525345540101010D0A6C626C557365724E616D650144454641554C54
      5F434841525345540101010D0A4C6162656C31350144454641554C545F434841
      525345540101010D0A6274436C6F736501414E53495F43484152534554010101
      0D0A6C626C4D656E7501414E53495F434841525345540101010D0A6C626C5375
      624D656E7501414E53495F434841525345540101010D0A627443616E63656C01
      414E53495F434841525345540101010D0A6274466972737452656301414E5349
      5F434841525345540101010D0A62745072696F7252656301414E53495F434841
      525345540101010D0A62744E65787452656301414E53495F4348415253455401
      01010D0A62744C61737452656301414E53495F434841525345540101010D0A6C
      626C4D6F64696669656401414E53495F434841525345540101010D0A4C616265
      6C3101414E53495F434841525345540101010D0A}
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforeOpen = quFormBeforeOpen
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'IDPurchase,'#13#10#9'PurchaseStatus,'#13#10#9'IDFornecedor,'#13#10#9'IDStore' +
      ','#13#10#9'IDUserPreReceiving,'#13#10#9'DatePreReceiving,'#13#10#9'IDUserFinalReceivi' +
      'ng,'#13#10#9'DateFinalReceiving,'#13#10#9'Freight,'#13#10#9'Discount,'#13#10#9'OtherCharges,' +
      #13#10#9'DocumentType,'#13#10#9'DocumentNumber,'#13#10#9'DocumentDate,'#13#10#9'DocumentDue' +
      'Date,'#13#10#9'PayDays,'#13#10#9'DocumentTotal,'#13#10#9'IDPO,'#13#10#9'FreightRet,'#13#10#9'OtherC' +
      'hargesRet,'#13#10#9'DocumentNumberRet,'#13#10#9'DocumentDueDateRet,'#13#10#9'IDCFOP'#13#10 +
      'FROM'#13#10#9'Pur_Purchase'#13#10'WHERE'#13#10#9'IDPurchase = :IDPurchase'
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    object quFormIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quFormPurchaseStatus: TStringField
      FieldName = 'PurchaseStatus'
    end
    object quFormIDFornecedor: TIntegerField
      FieldName = 'IDFornecedor'
      Required = True
    end
    object quFormIDStore: TIntegerField
      FieldName = 'IDStore'
      Required = True
    end
    object quFormIDUserPreReceiving: TIntegerField
      FieldName = 'IDUserPreReceiving'
    end
    object quFormDatePreReceiving: TDateTimeField
      FieldName = 'DatePreReceiving'
      DisplayFormat = 'ddddd'
    end
    object quFormIDUserFinalReceiving: TIntegerField
      FieldName = 'IDUserFinalReceiving'
    end
    object quFormDateFinalReceiving: TDateTimeField
      FieldName = 'DateFinalReceiving'
      DisplayFormat = 'ddddd'
    end
    object quFormFreight: TBCDField
      FieldName = 'Freight'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormOtherCharges: TBCDField
      FieldName = 'OtherCharges'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormDocumentType: TStringField
      FieldName = 'DocumentType'
      Required = True
    end
    object quFormDocumentNumber: TStringField
      FieldName = 'DocumentNumber'
    end
    object quFormDocumentDate: TDateTimeField
      FieldName = 'DocumentDate'
      DisplayFormat = 'ddddd'
    end
    object quFormDocumentDueDate: TDateTimeField
      FieldName = 'DocumentDueDate'
      DisplayFormat = 'ddddd'
    end
    object quFormDocumentTotal: TBCDField
      FieldName = 'DocumentTotal'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormPayDays: TIntegerField
      FieldName = 'PayDays'
    end
    object quFormIDPO: TIntegerField
      FieldName = 'IDPO'
    end
    object quFormFreightRet: TBCDField
      FieldName = 'FreightRet'
      Precision = 19
    end
    object quFormOtherChargesRet: TBCDField
      FieldName = 'OtherChargesRet'
      Precision = 19
    end
    object quFormDocumentNumberRet: TStringField
      FieldName = 'DocumentNumberRet'
    end
    object quFormDocumentDueDateRet: TDateTimeField
      FieldName = 'DocumentDueDateRet'
    end
    object quFormIDCFOP: TIntegerField
      FieldName = 'IDCFOP'
    end
    object quFormDiscount: TBCDField
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    PostOnInsert = True
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDPurchase'
    RequiredFields.Strings = (
      'Freight')
    DependentTables.Strings = (
      'Pur_PurchaseItemSerial'
      'Pur_PurchaseItemTax'
      'Pur_PurchaseItemTaxRet'
      'Pur_PurchaseItem'
      'Pur_PurchaseTotal'
      'Pur_PurchaseQtyOrder'
      'Pur_PurchaseTerm'
      'Pur_PurchaseDueDate'
      'Pur_PurchaseVerify')
    DependentTableKeys.Strings = (
      'IDPurchase'
      'IDPurchase'
      'IDPurchase'
      'IDPurchase'
      'IDPurchase'
      'IDPurchase'
      'IDPurchase'
      'IDPurchase'
      'IDPurchase')
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    AfterOpen = quBrowseAfterOpen
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'SELECT'#13#10#9'PI.IDPurchaseItem,'#13#10#9'PI.IDPurchase,'#13#10#9'PI.IDModel,'#13#10#9'ISN' +
      'ULL(PI.BarCode, B.IDBarcode) as Barcode,'#13#10#9'PI.Qty,'#13#10#9'PI.QtyRet,'#13 +
      #10#9'PI.CostPrice,'#13#10#9'PI.CostPriceRet,'#13#10#9'PI.FreightCost,'#13#10#9'PI.Freigh' +
      'tCostRet,'#13#10#9'PI.OtherCost,'#13#10#9'PI.OtherCostRet,'#13#10#9'PI.Discount,'#13#10#9'PI' +
      '.DiscountRet,'#13#10#9'PI.NewCostPrice,'#13#10#9'PI.NewCostPriceRet,'#13#10#9'PI.NewS' +
      'alePrice,'#13#10#9'PI.NewSuggRetail,'#13#10#9'PI.CaseQty,'#13#10#9'PI.CaseCost,'#13#10#9'cas' +
      'e isnull(PI.Qty, 0)'#13#10#9#9'when 0 '#13#10#9#9#9'then (((ISNULL(PI.CostPrice, ' +
      '0) + ISNULL(PI.FreightCost, 0) + ISNULL(PI.OtherCost, 0)) / 1) *' +
      ' PI.Qty) '#13#10#9#9#9'else (((ISNULL(PI.CostPrice, 0) + ISNULL(PI.Freigh' +
      'tCost, 0) + ISNULL(PI.OtherCost, 0)) / PI.Qty) * PI.Qty) '#13#10#9'end'#9 +
      'as SubTotalUnit,'#13#10#9'(PI.NewCostPrice * PI.Qty) as SubTotal,'#13#10#9'(PI' +
      '.NewCostPrice * IsNull(PPV.QtyCounted, 0)) as SubTotalCounted,'#13#10 +
      '               (ISNULL(CostPriceRet,0)) as SubTotalRet,'#13#10#9'(ISNUL' +
      'L(PI.CostPrice,0) * PI.Qty) as SubTotalTax,'#13#10#9'(ISNULL(CostPriceR' +
      'et,0)) as SubTotalTaxRet,'#13#10#9'CASE ISNULL(PI.NewCostPrice, 0) WHEN' +
      ' 0 THEN 0 ELSE (((ISNULL(PI.NewSalePrice, M.SellingPrice) - PI.N' +
      'ewCostPrice) / PI.NewCostPrice) * 100) END as MarkUp,'#13#10#9'CASE ISN' +
      'ULL(PI.NewSalePrice, 0) WHEN 0 THEN 0 ELSE ((1 - (PI.NewCostPric' +
      'e / PI.NewSalePrice)) * 100) END as Margin,'#13#10#9'M.Model,'#13#10#9'M.Descr' +
      'iption,'#13#10#9'M.SellingPrice as ActualSellingPrice,'#13#10#9'(M.VendorCost ' +
      '+ IsNull(M.FreightCost,0) + IsNull(M.OtherCost,0)) as ActualCost' +
      'Price,'#13#10#9'TG.Name as Category,'#13#10#9'P.Pessoa as Manufacturer,'#13#10#9'('#13#10#9 +
      'SELECT TOP 1'#13#10#9#9'VendorCode '#13#10#9'FROM '#13#10#9#9'VendorModelCode (NOLOCK)'#13 +
      #10#9'WHERE'#13#10#9#9'IDPessoa = PI.IDFornecedor'#13#10#9#9'AND'#13#10#9#9'IDModel = PI.IDM' +
      'odel'#13#10#9') as VendorCode,'#13#10#9'L.Lot,'#13#10#9'PI.IDLote,'#13#10#9'M.UseLot,'#13#10'     ' +
      '           IsNull(ppv.QtyReceiving, 0) as Ordered,'#13#10'            ' +
      '    IsNull(ppv.QtyCounted, 0) as Counted,'#13#10#9'(PI.NewCostPrice * P' +
      'PV.QtyCounted) as SubTotalCounted'#13#10'FROM'#13#10#9'Pur_PurchaseItem PI (N' +
      'OLOCK)'#13#10#9'JOIN Model M (NOLOCK) ON (PI.IDModel = M.IDModel)'#13#10#9'JOI' +
      'N TabGroup TG (NOLOCK) ON (PI.IDGroup = TG.IDGroup)'#13#10#9'LEFT OUTER' +
      ' JOIN Pessoa P (NOLOCK) ON (M.IDFabricante = P.IDPessoa)'#13#10#9'LEFT ' +
      'JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel and B.BarcodeO' +
      'rder = 1)'#13#10#9'LEFT JOIN Inv_Lot L (NOLOCK) ON (L.IDLote = PI.IDLot' +
      'e)'#13#10'                LEFT JOIN PUR_PURCHASEVERIFY PPV on PI.IdPur' +
      'chase = PPV.IdPurchase AND PI.IdModel = PPV.IdModel'#13#10'WHERE'#13#10#9'PI.' +
      'IDPurchase = :idpurchase'#13#10
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    object quBrowseIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object quBrowseIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quBrowseIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quBrowseBarCode: TStringField
      FieldName = 'BarCode'
    end
    object quBrowseNewCostPrice: TBCDField
      FieldName = 'NewCostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseNewSalePrice: TBCDField
      FieldName = 'NewSalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseNewSuggRetail: TBCDField
      FieldName = 'NewSuggRetail'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseSubTotal: TBCDField
      DisplayLabel = 'SubTotal Ordered'
      FieldName = 'SubTotal'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quBrowseDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quBrowseCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quBrowseManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object quBrowseCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseSubTotalTax: TBCDField
      FieldName = 'SubTotalTax'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseFreightCost: TBCDField
      FieldName = 'FreightCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseOtherCost: TBCDField
      FieldName = 'OtherCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseCostPriceRet: TBCDField
      FieldName = 'CostPriceRet'
      Precision = 19
    end
    object quBrowseFreightCostRet: TBCDField
      FieldName = 'FreightCostRet'
      Precision = 19
    end
    object quBrowseOtherCostRet: TBCDField
      FieldName = 'OtherCostRet'
      Precision = 19
    end
    object quBrowseNewCostPriceRet: TBCDField
      FieldName = 'NewCostPriceRet'
      Precision = 19
    end
    object quBrowseSubTotalRet: TBCDField
      FieldName = 'SubTotalRet'
      ReadOnly = True
      Precision = 19
    end
    object quBrowseSubTotalTaxRet: TBCDField
      FieldName = 'SubTotalTaxRet'
      ReadOnly = True
      Precision = 19
    end
    object quBrowseQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseQtyRet: TFloatField
      FieldName = 'QtyRet'
      DisplayFormat = '0.#####'
    end
    object quBrowseCaseQty: TFloatField
      FieldName = 'CaseQty'
      DisplayFormat = '0.#####'
    end
    object quBrowseCaseCost: TBCDField
      FieldName = 'CaseCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseVendorCode: TStringField
      FieldName = 'VendorCode'
      ReadOnly = True
      Size = 35
    end
    object quBrowseMarkUp: TBCDField
      FieldName = 'MarkUp'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseMargin: TBCDField
      FieldName = 'Margin'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseSubTotalUnit: TBCDField
      FieldName = 'SubTotalUnit'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
    object quBrowseActualSellingPrice: TBCDField
      DisplayLabel = 'Actual Selling Price'
      FieldName = 'ActualSellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseActualCostPrice: TBCDField
      DisplayLabel = 'Actual Cost Price'
      FieldName = 'ActualCostPrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseLot: TStringField
      FieldName = 'Lot'
      Size = 50
    end
    object quBrowseUseLot: TBooleanField
      FieldName = 'UseLot'
    end
    object quBrowseIDLote: TIntegerField
      FieldName = 'IDLote'
    end
    object quBrowseUnitCostPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'UnitCostPrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseDiscount: TCurrencyField
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseDiscountRet: TCurrencyField
      FieldName = 'DiscountRet'
      DisplayFormat = '#,##0.00'
    end
    object quBrowseOrdered: TBCDField
      FieldName = 'Ordered'
      Precision = 32
    end
    object quBrowseCounted: TBCDField
      FieldName = 'Counted'
      DisplayFormat = '#,##0.00'
      Precision = 32
    end
    object quBrowseSubTotalCounted: TBCDField
      DisplayLabel = 'SubTotal Received'
      FieldName = 'SubTotalCounted'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
  end
  object quTerm: TADOQuery [15]
    Connection = DM.ADODBConnect
    OnNewRecord = quTermNewRecord
    DataSource = dsForm
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      PT.IDPurchase,'
      '      PT.DueDateShift,'
      '      PT.Discount'
      'FROM'
      '      Pur_PurchaseTerm PT (NOLOCK)'
      'WHERE'
      '      PT.IDPurchase =  :IDPurchase'
      ''
      ' '
      ' ')
    Left = 400
    Top = 391
    object quTermIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quTermDueDateShift: TIntegerField
      DisplayLabel = 'Days'
      DisplayWidth = 2
      FieldName = 'DueDateShift'
      EditFormat = ';2;'
    end
    object quTermDiscount: TBCDField
      DisplayLabel = 'Discount % '
      FieldName = 'Discount'
      Precision = 19
    end
  end
  object dsTerm: TDataSource [16]
    DataSet = quTerm
    OnStateChange = dsTermStateChange
    Left = 400
    Top = 441
  end
  object spPurchaseDo: TADOStoredProc [17]
    Connection = DM.ADODBConnect
    CommandTimeout = 1800
    ProcedureName = 'sp_Purchase_Do;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchase'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@TaxInCost'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 287
    Top = 285
  end
  object spRemoveItem: TADOStoredProc [18]
    Connection = DM.ADODBConnect
    CommandTimeout = 1800
    ProcedureName = 'sp_Purchase_RemoveItem;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchase'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchaseItem'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TaxInCost'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 207
    Top = 285
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {0000000000000000E804000056030000}
    Left = 340
    Top = 234
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37963.680400046280000000
      PrinterPage.Footer = 8534
      PrinterPage.Header = 508
      PrinterPage.Margins.Bottom = 322580
      PrinterPage.Margins.Left = 322580
      PrinterPage.Margins.Right = 322580
      PrinterPage.Margins.Top = 322580
      PrinterPage.PageSize.X = 5483860
      PrinterPage.PageSize.Y = 7096760
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
    end
  end
  object dsTax: TDataSource
    DataSet = quTax
    Left = 445
    Top = 442
  end
  object quTax: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'SUM(IsNull(PIT.TaxValue,0)) as TaxValue,'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.TaxExempt'
      'FROM'
      #9'Pur_PurchaseItemTax PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchase = :IDPurchase'
      'GROUP BY'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.TaxExempt'
      '')
    Left = 445
    Top = 392
    object quTaxTaxCategory: TStringField
      DisplayLabel = 'Category'
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quTaxTaxValue: TBCDField
      DisplayLabel = 'Value'
      FieldName = 'TaxValue'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quTaxDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quTaxTaxExempt: TBooleanField
      FieldName = 'TaxExempt'
    end
  end
  object quTaxRet: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'SUM(IsNull(PIT.TaxValue,0)) as TaxValue,'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.TaxExempt'
      'FROM'
      #9'Pur_PurchaseItemTaxRet PIT (NOLOCK)'
      
        #9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax' +
        ')'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'PIT.IDPurchase = :IDPurchase'
      'GROUP BY'
      #9'TG.TaxCategory,'
      #9'TG.Debit,'
      #9'TG.TaxExempt')
    Left = 530
    Top = 232
    object quTaxRetTaxValue: TBCDField
      FieldName = 'TaxValue'
      ReadOnly = True
      Precision = 19
    end
    object quTaxRetTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quTaxRetDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quTaxRetTaxExempt: TBooleanField
      FieldName = 'TaxExempt'
    end
  end
  object dsTaxRet: TDataSource
    DataSet = quTaxRet
    Left = 530
    Top = 282
  end
  object popNew: TPopupMenu
    AutoPopup = False
    Left = 365
    Top = 281
    object menAdd: TMenuItem
      Caption = 'Add'
      OnClick = btAddClick
    end
    object menQuickEntry: TMenuItem
      Caption = 'Quick entry'
      OnClick = menQuickEntryClick
    end
  end
  object cdsDueDate: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDueDate'
    OnNewRecord = cdsDueDateNewRecord
    Left = 739
    Top = 440
  end
  object dsDueDate: TDataSource
    DataSet = cdsDueDate
    Left = 734
    Top = 484
  end
  object quDueDate: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  PDD.IDPurchaseDueDate,'
      '  PDD.IDPurchase,'
      '  PDD.Date,'
      '  PDD.Amount'
      'FROM'
      '  Pur_PurchaseDueDate PDD (NOLOCK)'
      'WHERE'
      '  PDD.IDPurchase = :IDPurchase')
    Left = 724
    Top = 352
    object quDueDateIDPurchaseDueDate: TStringField
      FieldName = 'IDPurchaseDueDate'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quDueDateIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
      ProviderFlags = [pfInUpdate]
    end
    object quDueDateDate: TDateTimeField
      FieldName = 'Date'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = 'ddddd'
    end
    object quDueDateAmount: TBCDField
      FieldName = 'Amount'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dspDueDate: TDataSetProvider
    DataSet = quDueDate
    Options = [poIncFieldProps]
    Left = 724
    Top = 396
  end
  object popPrint: TPopupMenu
    AutoPopup = False
    Left = 421
    Top = 281
    object memBarcode: TMenuItem
      Caption = 'Print Barcode'
      OnClick = btnPrintBarcodeClick
    end
    object memReceiving: TMenuItem
      Caption = 'Print Receiving'
      OnClick = memReceivingClick
    end
  end
  object quListOpenPOs: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'select 0 as Upd, '#13#10'       PO.IDPO,'#13#10'       m.model,'#13#10'       m.De' +
      'scription,'#13#10'       ppi.CostPrice,'#13#10'       m.SellingPrice NewPric' +
      'e,'#13#10'       ppi.NewSalePrice OldPrice,'#13#10'       ppi.IdPurchaseItem' +
      #13#10'from PO'#13#10'     join Pur_Purchase pp on PO.IDPO = pp.IDPO and PO' +
      '.IDFornecedor = pp.IDFornecedor'#13#10'     join Pur_PurchaseItem ppi ' +
      'on pp.IDPurchase = ppi.IDPurchase and pp.IDFornecedor = ppi.IDFo' +
      'rnecedor'#13#10'     join Model m on ppi.IDModel = m.IDModel'#13#10'where  p' +
      'pi.idmodel = -1'#13#10#13#10
    Parameters = <>
    Left = 392
    Top = 157
    object quListOpenPOsUpd: TIntegerField
      FieldName = 'Upd'
    end
    object quListOpenPOsIDPO: TIntegerField
      FieldName = 'IDPO'
    end
    object quListOpenPOsmodel: TStringField
      FieldName = 'model'
      Size = 30
    end
    object quListOpenPOsDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quListOpenPOsCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quListOpenPOsNewPrice: TBCDField
      FieldName = 'NewPrice'
      Precision = 19
    end
    object quListOpenPOsOldPrice: TBCDField
      FieldName = 'OldPrice'
      Precision = 19
    end
    object quListOpenPOsIdPurchaseItem: TIntegerField
      FieldName = 'IdPurchaseItem'
    end
  end
  object dspListOpenPOs: TDataSetProvider
    DataSet = quListOpenPOs
    ResolveToDataSet = True
    Options = [poAllowCommandText]
    Left = 472
    Top = 157
  end
  object cdsListOpenPOs: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspListOpenPOs'
    Left = 554
    Top = 157
    object cdsListOpenPOsUpd: TIntegerField
      FieldName = 'Upd'
    end
    object cdsListOpenPOsIDPO: TIntegerField
      FieldName = 'IDPO'
    end
    object cdsListOpenPOsmodel: TStringField
      FieldName = 'model'
      Size = 30
    end
    object cdsListOpenPOsDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsListOpenPOsCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object cdsListOpenPOsNewPrice: TBCDField
      FieldName = 'NewPrice'
      Precision = 19
    end
    object cdsListOpenPOsOldPrice: TBCDField
      FieldName = 'OldPrice'
      Precision = 19
    end
    object cdsListOpenPOsIdPurchaseItem: TIntegerField
      FieldName = 'IdPurchaseItem'
    end
  end
end
