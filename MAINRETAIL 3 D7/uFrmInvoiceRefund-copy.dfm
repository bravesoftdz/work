inherited FrmInvoiceRefund: TFrmInvoiceRefund
  Left = 333
  Top = 135
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Invoice Refund'
  ClientHeight = 612
  ClientWidth = 750
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbInvoiceNumber: TLabel [0]
    Left = 28
    Top = 15
    Width = 45
    Height = 13
    Alignment = taRightJustify
    Caption = 'Invoice #'
  end
  object Label19: TLabel [1]
    Left = 26
    Top = 91
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Hold Date'
  end
  object lblInvoiceDate: TLabel [2]
    Left = 14
    Top = 67
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Invoice Date'
  end
  object Label1: TLabel [3]
    Left = 9
    Top = 41
    Width = 68
    Height = 13
    Alignment = taRightJustify
    Caption = 'Invoice Total :'
  end
  object lbBarcode: TLabel [4]
    Left = 28
    Top = 115
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Barcode'
  end
  inherited Panel1: TPanel
    Top = 571
    Width = 750
    inherited EspacamentoInferior: TPanel
      Width = 750
      inherited Panel3: TPanel
        Width = 750
      end
    end
    inherited hhh: TPanel
      Left = 527
      Width = 223
      inherited sbHelp: TSpeedButton
        Left = 12
        Top = 4
        Visible = False
      end
      inherited btClose: TButton
        Left = 149
        Caption = '&Cancel'
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 80
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Apply'
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 565
  end
  inherited EspacamentoDireito: TPanel
    Left = 747
    Height = 565
  end
  inherited EspacamentoSuperior: TPanel
    Width = 750
  end
  object EditPreSaleDate: TDBEdit [9]
    Left = 78
    Top = 88
    Width = 128
    Height = 21
    TabStop = False
    Color = cl3DLight
    DataField = 'PreSaleDate'
    DataSource = dsInvoice
    ReadOnly = True
    TabOrder = 4
  end
  object EditInvoiceDate: TDBEdit [10]
    Left = 79
    Top = 63
    Width = 128
    Height = 21
    TabStop = False
    Color = cl3DLight
    DataField = 'InvoiceDate'
    DataSource = dsInvoice
    ReadOnly = True
    TabOrder = 5
  end
  object DBEdit1: TDBEdit [11]
    Left = 79
    Top = 12
    Width = 128
    Height = 21
    TabStop = False
    Color = cl3DLight
    DataField = 'InvoiceCode'
    DataSource = dsInvoice
    ReadOnly = True
    TabOrder = 6
  end
  object DBEdit2: TDBEdit [12]
    Left = 79
    Top = 38
    Width = 128
    Height = 21
    TabStop = False
    Color = cl3DLight
    DataField = 'TotInvoice'
    DataSource = dsInvoice
    ReadOnly = True
    TabOrder = 7
  end
  object edtBarcode: TmrBarCodeEdit [13]
    Left = 78
    Top = 111
    Width = 130
    Height = 21
    Color = 8454143
    TabOrder = 8
    Connection = DM.ADODBConnect
    SQL.Strings = (
      'SELECT'
      '      B.IDModel'
      'FROM'
      '      Barcode B'
      'WHERE'
      '      B.IDBarcode = :IDBarcode')
    SecondSQL.Strings = (
      'SELECT'
      '      M.IDModel'
      'FROM'
      '      Model M'
      'WHERE'
      '      M.Model = :Model')
    KeyField = 'IDBarcode'
    SecondKeyField = 'Model'
    DisplayQty = False
    RunSecondSQL = False
    CheckBarcodeDigit = 0
    MinimalDigits = 0
    AfterSearchBarcode = edtBarcodeAfterSearchBarcode
  end
  object pnlDetail: TPanel [14]
    Left = 8
    Top = 138
    Width = 735
    Height = 393
    BevelOuter = bvNone
    TabOrder = 10
    object pnlInvoiceItems: TPanel
      Left = 0
      Top = 0
      Width = 735
      Height = 176
      Align = alTop
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 735
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Invoice items'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object grdInvoiceItems: TcxGrid
        Left = 0
        Top = 16
        Width = 735
        Height = 160
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdInvoiceItemsDB: TcxGridDBTableView
          DataController.DataSource = dsInvoice
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDInventoryMov'
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
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdInvoiceItemsDBAction: TcxGridDBColumn
            DataBinding.FieldName = 'Action'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Items = <
              item
                Description = 'Return to shelf'
                Value = 0
              end
              item
                Description = 'Return to vendor'
                Value = 1
              end>
            Properties.OnEditValueChanged = grdInvoiceItemsDBActionPropertiesEditValueChanged
            Width = 117
          end
          object grdInvoiceItemsDBRetorna: TcxGridDBColumn
            Caption = 'Return'
            DataBinding.FieldName = 'Retorno'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayUnchecked = 'False'
            Properties.ImmediatePost = True
            Properties.OnEditValueChanged = grdInvoiceItemsDBRetornaPropertiesEditValueChanged
            Width = 51
          end
          object grdInvoiceItemsDBModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
            SortOrder = soAscending
            Width = 128
          end
          object grdInvoiceItemsDBDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
            Width = 244
          end
          object grdInvoiceItemsDBQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
            Width = 84
          end
          object grdInvoiceItemsDBCostPrice: TcxGridDBColumn
            DataBinding.FieldName = 'CostPrice'
            Visible = False
            Options.Editing = False
            Width = 54
          end
          object grdInvoiceItemsDBSalePrice: TcxGridDBColumn
            DataBinding.FieldName = 'SalePrice'
            Visible = False
            Options.Editing = False
            Width = 57
          end
          object grdInvoiceItemsDBDiscount: TcxGridDBColumn
            DataBinding.FieldName = 'Discount'
            Visible = False
            Options.Editing = False
            Width = 58
          end
          object grdInvoiceItemsDBItemTotal: TcxGridDBColumn
            Caption = 'Total'
            DataBinding.FieldName = 'ItemTotal'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Options.Editing = False
            Width = 108
          end
        end
        object grdInvoiceItemsLevel: TcxGridLevel
          GridView = grdInvoiceItemsDB
        end
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 176
      Width = 735
      Height = 217
      Align = alClient
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 1
      object pnlModelConfig: TPanel
        Left = 0
        Top = 0
        Width = 735
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Refund type'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object pnlRepair: TPanel
        Left = 0
        Top = 16
        Width = 735
        Height = 201
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object grdItemRepair: TcxGrid
          Left = 0
          Top = 59
          Width = 735
          Height = 142
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object grdItemRepairDB: TcxGridDBTableView
            DataController.DataSource = dsItemRepair
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'ID'
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
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLines = glHorizontal
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfVisibleWhenExpanded
            OptionsView.HeaderAutoHeight = True
            OptionsView.HeaderEndEllipsis = True
            Preview.AutoHeight = False
            Preview.MaxLineCount = 2
            object grdItemRepairDBModel: TcxGridDBColumn
              DataBinding.FieldName = 'Model'
              Options.Editing = False
              Width = 59
            end
            object grdItemRepairDBDescription: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Options.Editing = False
              Width = 128
            end
            object grdItemRepairDBQty: TcxGridDBColumn
              DataBinding.FieldName = 'Qty'
              Width = 33
            end
            object grdItemRepairDBCostPrice: TcxGridDBColumn
              DataBinding.FieldName = 'CostPrice'
              Visible = False
              Options.Editing = False
              Width = 51
            end
            object grdItemRepairDBIDVendor: TcxGridDBColumn
              Caption = 'Vendor'
              DataBinding.FieldName = 'IDVendor'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'IDFornecedor'
              Properties.ListColumns = <
                item
                  FieldName = 'Fornecedor'
                end>
              Properties.ListOptions.ShowHeader = False
              Properties.ListSource = DM.dsLookUpFornecedor
              Width = 92
            end
            object grdItemRepairDBIDDefectType: TcxGridDBColumn
              Caption = 'Defect'
              DataBinding.FieldName = 'IDDefectType'
              PropertiesClassName = 'TcxLookupComboBoxProperties'
              Properties.KeyFieldNames = 'IDDefectType'
              Properties.ListColumns = <
                item
                  FieldName = 'DefectType'
                end>
              Properties.ListOptions.ShowHeader = False
              Properties.ListSource = DM.dsLookUpDefectType
              Width = 76
            end
            object grdItemRepairDBRA: TcxGridDBColumn
              DataBinding.FieldName = 'RA'
              Width = 49
            end
            object grdItemRepairDBObs: TcxGridDBColumn
              DataBinding.FieldName = 'Obs'
              Width = 143
            end
          end
          object grdItemRepairLevel: TcxGridLevel
            GridView = grdItemRepairDB
          end
        end
        object pnlUpdate: TPanel
          Left = 0
          Top = 0
          Width = 735
          Height = 59
          Align = alTop
          BevelOuter = bvNone
          Color = 14607076
          TabOrder = 1
          Visible = False
          object Label3: TLabel
            Left = 31
            Top = 9
            Width = 40
            Height = 13
            Alignment = taRightJustify
            Caption = 'Vendor :'
          end
          object lbDefeito: TLabel
            Left = 6
            Top = 34
            Width = 65
            Height = 13
            Alignment = taRightJustify
            Caption = 'Defect Type :'
          end
          object lbRA: TLabel
            Left = 310
            Top = 7
            Width = 25
            Height = 13
            Alignment = taRightJustify
            Caption = 'RA #'
          end
          object Label4: TLabel
            Left = 308
            Top = 29
            Width = 25
            Height = 13
            Alignment = taRightJustify
            Caption = 'Obs :'
          end
          object scDefectType: TSuperComboADO
            Left = 75
            Top = 30
            Width = 202
            Height = 21
            TabOrder = 0
            LookUpSource = DM.dsLookUpDefectType
            IDLanguage = 0
          end
          object scVendor: TSuperComboADO
            Left = 76
            Top = 5
            Width = 201
            Height = 21
            TabOrder = 1
            LookUpSource = DM.dsLookUpFornecedor
            IDLanguage = 0
          end
          object edtRA: TEdit
            Left = 339
            Top = 4
            Width = 121
            Height = 21
            TabOrder = 2
          end
          object memOBS: TMemo
            Left = 339
            Top = 27
            Width = 200
            Height = 29
            MaxLength = 255
            TabOrder = 3
          end
          object btnUpdate: TBitBtn
            Left = 630
            Top = 30
            Width = 75
            Height = 25
            Caption = 'Update'
            TabOrder = 4
            OnClick = btnUpdateClick
          end
          object btnRemove: TBitBtn
            Left = 630
            Top = 2
            Width = 75
            Height = 25
            Caption = 'Remove'
            TabOrder = 5
            OnClick = btnRemoveClick
          end
        end
      end
    end
  end
  object Panel2: TPanel [15]
    Left = 217
    Top = 9
    Width = 269
    Height = 125
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 11
    object Shape5: TShape
      Left = 0
      Top = 0
      Width = 269
      Height = 125
      Align = alClient
      Brush.Color = 14671839
      Pen.Color = 13793052
      Shape = stRoundRect
    end
    object Label37: TLabel
      Left = 10
      Top = 7
      Width = 55
      Height = 13
      Caption = 'Sub-Total'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label38: TLabel
      Left = 13
      Top = 30
      Width = 86
      Height = 13
      Caption = 'Item Discounts'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label39: TLabel
      Left = 15
      Top = 55
      Width = 76
      Height = 13
      Caption = 'Sale Discount'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label40: TLabel
      Left = 15
      Top = 78
      Width = 66
      Height = 13
      Caption = 'Other Costs'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label41: TLabel
      Left = 18
      Top = 100
      Width = 21
      Height = 13
      Caption = 'Tax'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblItemDiscountSign: TLabel
      Left = 106
      Top = 26
      Width = 8
      Height = 20
      Caption = '-'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Visible = False
    end
    object lblSaleDiscountSign: TLabel
      Left = 107
      Top = 48
      Width = 8
      Height = 20
      Caption = '-'
      Color = 14671839
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Visible = False
    end
    object dbedTax: TDBEdit
      Left = 122
      Top = 95
      Width = 104
      Height = 21
      BiDiMode = bdRightToLeft
      Color = 14671839
      DataField = 'Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object dbedOtherCost: TDBEdit
      Left = 122
      Top = 72
      Width = 104
      Height = 21
      BiDiMode = bdRightToLeft
      Color = 14671839
      DataField = 'AditionalExpenses'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object dbedSaleDiscount: TDBEdit
      Left = 122
      Top = 49
      Width = 104
      Height = 21
      BiDiMode = bdRightToLeft
      Color = 14671839
      DataField = 'InvoiceDiscount'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object dbedItemDiscount: TDBEdit
      Left = 122
      Top = 26
      Width = 104
      Height = 21
      BiDiMode = bdRightToLeft
      Color = 14671839
      DataField = 'TotalDiscount'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object dbedSubTotal: TDBEdit
      Left = 122
      Top = 3
      Width = 104
      Height = 21
      BiDiMode = bdRightToLeft
      Color = 14671839
      DataField = 'SubTotal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object pnlSaleDiscount: TPanel [16]
    Left = 493
    Top = 9
    Width = 246
    Height = 125
    BevelOuter = bvNone
    TabOrder = 12
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 246
      Height = 125
      Align = alClient
      Brush.Color = 14671839
      Pen.Color = clRed
      Shape = stRoundRect
    end
    object Label2: TLabel
      Left = 8
      Top = 14
      Width = 180
      Height = 58
      Caption = 'A sale level discount exists.'
      Color = 14671839
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
  end
  object pnlRefund: TPanel [17]
    Left = 8
    Top = 535
    Width = 736
    Height = 41
    TabOrder = 13
    object btnCalcRefund: TBitBtn
      Left = 390
      Top = 7
      Width = 133
      Height = 29
      Caption = 'Show Refund'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnCalcRefundClick
    end
    object pnlTotalRefund: TPanel
      Left = 534
      Top = 6
      Width = 200
      Height = 30
      TabOrder = 1
      Visible = False
      object lblRefund: TLabel
        Left = 10
        Top = 10
        Width = 75
        Height = 13
        Caption = 'Total Refund:'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object curreditRefund: TcxCurrencyEdit
        Left = 99
        Top = 5
        Width = 91
        Height = 21
        ParentFont = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.NullString = '0.00'
        Properties.UseThousandSeparator = True
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clRed
        Style.Font.Height = -12
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        TabOrder = 0
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmInvoiceRefund.sil'
    Left = 5
    Top = 2
    TranslationData = {
      737443617074696F6E730D0A5446726D496E766F696365526566756E6401496E
      766F69636520526566756E640101010D0A50616E656C31010101010D0A457370
      6163616D656E746F496E666572696F72010101010D0A50616E656C3301010101
      0D0A686868010101010D0A6274436C6F73650126436C6F73650101010D0A4573
      706163616D656E746F457371756572646F010101010D0A4573706163616D656E
      746F4469726569746F010101010D0A4573706163616D656E746F537570657269
      6F72010101010D0A736248656C70012648656C700101010D0A6C62496E766F69
      63654E756D62657201496E766F69636520230101010D0A4C6162656C31390148
      6F6C6420446174650101010D0A6C626C496E766F6963654461746501496E766F
      69636520446174650101010D0A4C6162656C3101496E766F69636520546F7461
      6C203A0101010D0A6C62426172636F646501426172636F64650101010D0A6274
      6E536176650126536176650101010D0A737448696E74730D0A5446726D496E76
      6F696365526566756E6401010D0A50616E656C31010101010D0A457370616361
      6D656E746F496E666572696F72010101010D0A50616E656C33010101010D0A68
      6868010101010D0A6274436C6F7365010101010D0A4573706163616D656E746F
      457371756572646F010101010D0A4573706163616D656E746F4469726569746F
      010101010D0A4573706163616D656E746F5375706572696F72010101010D0A73
      6248656C70010101010D0A6C62496E766F6963654E756D626572010101010D0A
      4C6162656C3139010101010D0A6C626C496E766F69636544617465010101010D
      0A4C6162656C31010101010D0A6C62426172636F6465010101010D0A62746E53
      617665010101010D0A4564697450726553616C6544617465010101010D0A4564
      6974496E766F69636544617465010101010D0A44424564697431010101010D0A
      44424564697432010101010D0A656474426172636F6465010101010D0A737444
      6973706C61794C6162656C730D0A6364734974656D5265706169724944014944
      0101010D0A6364734974656D52657061697249444D6F64656C0149444D6F6465
      6C0101010D0A6364734974656D5265706169724D6F64656C014D6F64656C0101
      010D0A6364734974656D5265706169724465736372697074696F6E0144657363
      72697074696F6E0101010D0A6364734974656D52657061697251747901517479
      0101010D0A6364734974656D526570616972436F7374507269636501436F7374
      50726963650101010D0A6364734974656D526570616972494456656E646F7201
      494456656E646F720101010D0A6364734974656D52657061697256656E646F72
      0156656E646F720101010D0A6364734974656D52657061697249444465666563
      7454797065014944446566656374547970650101010D0A6364734974656D5265
      706169724465666563745479706501446566656374547970650101010D0A6364
      734974656D5265706169724F6273014F62730101010D0A6364734974656D5265
      706169724944496E76656E746F72794D6F76014944496E76656E746F72794D6F
      760101010D0A6364734974656D526570616972524101524120230101010D0A71
      754974656D436F6D6D697373696F6E4944436F6D6D697373696F6E014944436F
      6D6D697373696F6E0101010D0A71754974656D436F6D6D697373696F6E436F6D
      6D697373696F6E50657263656E7401436F6D6D697373696F6E50657263656E74
      0101010D0A7374466F6E74730D0A5446726D496E766F696365526566756E6401
      4D532053616E732053657269660101010D0A686868015461686F6D610101010D
      0A73744D756C74694C696E65730D0A656474426172636F64652E5365636F6E64
      53514C0153454C4543542C222020202020204D2E49444D6F64656C222C46524F
      4D2C222020202020204D6F64656C204D222C57484552452C222020202020204D
      2E4D6F64656C203D203A4D6F64656C220101010D0A656474426172636F64652E
      53514C0153454C4543542C22202020202020422E49444D6F64656C222C46524F
      4D2C22202020202020426172636F64652042222C57484552452C222020202020
      20422E4944426172636F6465203D203A4944426172636F6465220101010D0A71
      75496E766F6963652E53514C0153454C4543542C222020202020202020492E49
      4450726553616C652C222C222020202020202020492E4944496E766F6963652C
      222C222020202020202020492E50726553616C65446174652C222C2220202020
      20202020492E496E766F696365446174652C222C222020202020202020492E53
      616C65436F64652C222C222020202020202020492E496E766F696365436F6465
      2C222C222020202020202020492E4E6F74652C222C222020202020202020502E
      506573736F6146697273744E616D652C222C222020202020202020502E506573
      736F614C6173744E616D652C222C222020202020202020502E506573736F612C
      222C222020202020202020502E4944506573736F612C222C2220202020202020
      2028492E537562546F74616C202D20492E4974656D446973636F756E74202B20
      492E546178202B2049734E756C6C28492E41646974696F6E616C457870656E73
      65732C2030292920617320546F74496E766F6963652C222C2220202020202020
      20492E4944546F757269737447726F75702C222C222020202020202020492E4F
      74686572436F6D697373696F6E49442C222C22092828494D2E517479202A2049
      4D2E53616C65507269636529202D20494D2E446973636F756E74292061732049
      74656D546F74616C2C222C2209494D2E4944496E76656E746F72794D6F762C22
      2C220928494D2E517479202D2049734E756C6C28494D2E51747945786368616E
      6765642C302929206173205174792C222C2209494D2E436F737450726963652C
      222C2209494D2E53616C6550726963652C222C2209494D2E446973636F756E74
      2C222C22094D2E49444D6F64656C2C222C22094D2E4D6F64656C2C222C22094D
      2E4465736372697074696F6E2C222C22094D2E446174654C617374436F73742C
      222C22094D2E4C617374436F73742C222C2209562E4944506573736F61206173
      20494456656E646F722C222C2209562E506573736F612061732056656E646F72
      2C222C2209494D2E49444465706172746D656E742C222C220963617374283020
      61732062697429206173205265746F726E6F2C222C2209494D2E507265496E76
      656E746F72794D6F764944222C46524F4D2C222020202020202020496E766F69
      6365204920284E4F4C4F434B29222C2220202020202020204C454654204A4F49
      4E20506573736F61205020284E4F4C4F434B29204F4E20492E4944437573746F
      6D6572203D20502E4944506573736F61222C22094A4F494E20496E76656E746F
      72794D6F7620494D20284E4F4C4F434B29204F4E2028494D2E446F63756D656E
      744944203D20492E4944496E766F69636520414E4420494D2E496E76656E744D
      6F76547970654944203D203129222C22094A4F494E204D6F64656C204D204F4E
      20284D2E49444D6F64656C203D20494D2E4D6F64656C494429222C22094C4546
      54204A4F494E20496E765F4D6F64656C56656E646F72204D56204F4E20284D56
      2E49444D6F64656C203D204D2E49444D6F64656C20414E442056656E646F724F
      72646572203D203129222C22094C454654204A4F494E20506573736F61205620
      4F4E20284D562E4944506573736F61203D20562E4944506573736F6129222C57
      484552452C222020202020202020492E4944496E766F696365204973204E4F54
      204E554C4C222C222020202020202020414E4420492E43616E63656C6564203D
      2030222C222020202020202020414E4420492E496E766F696365436F6465203D
      203A496E766F696365222C2209414E4420494D2E53746F72654944203D203A49
      4453746F7265222C2209414E4420494D2E517479203E2030222C2209414E4420
      494D2E45786368616E6765496E766F696365204953204E554C4C220101010D0A
      7374446C677343617074696F6E730D0A5761726E696E67015761726E696E6701
      01010D0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01
      496E666F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D01
      01010D0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F
      4B0101010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641
      626F72740101010D0A5265747279012652657472790101010D0A49676E6F7265
      012649676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20
      416C6C014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965
      7320746F2026416C6C0101010D0A48656C70012648656C700101010D0A737453
      7472696E67730D0A73744F74686572537472696E67730D0A5446726D496E766F
      696365526566756E642E48656C7046696C65010101010D0A636D644974656D52
      65706169722E436F6D6D616E645465787401494E534552542053616C5F497465
      6D526570616972202849444974656D5265706169722C204944507265496E7665
      6E746F72794D6F762C204F62732C204944446566656374547970652C2052412C
      20494456656E646F7229191A56414C55455320283A49444974656D5265706169
      722C203A4944507265496E76656E746F72794D6F762C203A4F62732C203A4944
      446566656374547970652C203A52412C203A494456656E646F7229191A010101
      0D0A636D644974656D5265706169722E436F6E6E656374696F6E537472696E67
      010101010D0A4564697450726553616C65446174652E446174614669656C6401
      50726553616C65446174650101010D0A45646974496E766F696365446174652E
      446174614669656C6401496E766F696365446174650101010D0A444245646974
      312E446174614669656C6401496E766F696365436F64650101010D0A44424564
      6974322E446174614669656C6401546F74496E766F6963650101010D0A656474
      426172636F64652E4B65794669656C64014944426172636F64650101010D0A65
      6474426172636F64652E5365636F6E644B65794669656C64014D6F64656C0101
      010D0A656474426172636F64652E54657874010101010D0A7175496E766F6963
      652E436F6E6E656374696F6E537472696E67010101010D0A7175496E766F6963
      652E46696C746572010101010D0A6364734974656D5265706169722E436F6D6D
      616E6454657874010101010D0A6364734974656D5265706169722E46696C7465
      72010101010D0A6364734974656D5265706169722E496E6465784669656C644E
      616D6573010101010D0A6364734974656D5265706169722E50726F7669646572
      4E616D65010101010D0A6364734974656D52657061697249442E436F6E737472
      61696E744572726F724D657373616765010101010D0A6364734974656D526570
      61697249442E437573746F6D436F6E73747261696E74010101010D0A63647349
      74656D52657061697249442E44656661756C7445787072657373696F6E010101
      010D0A6364734974656D52657061697249442E45646974466F726D6174010101
      010D0A6364734974656D52657061697249442E496D706F72746564436F6E7374
      7261696E74010101010D0A6364734974656D52657061697249442E4B65794669
      656C6473010101010D0A6364734974656D52657061697249442E4C6F6F6B7570
      4B65794669656C6473010101010D0A6364734974656D52657061697249442E4C
      6F6F6B7570526573756C744669656C64010101010D0A6364734974656D526570
      61697249442E4F726967696E010101010D0A6364734974656D52657061697249
      444D6F64656C2E436F6E73747261696E744572726F724D657373616765010101
      010D0A6364734974656D52657061697249444D6F64656C2E437573746F6D436F
      6E73747261696E74010101010D0A6364734974656D52657061697249444D6F64
      656C2E44656661756C7445787072657373696F6E010101010D0A636473497465
      6D52657061697249444D6F64656C2E45646974466F726D6174010101010D0A63
      64734974656D52657061697249444D6F64656C2E496D706F72746564436F6E73
      747261696E74010101010D0A6364734974656D52657061697249444D6F64656C
      2E4B65794669656C6473010101010D0A6364734974656D52657061697249444D
      6F64656C2E4C6F6F6B75704B65794669656C6473010101010D0A636473497465
      6D52657061697249444D6F64656C2E4C6F6F6B7570526573756C744669656C64
      010101010D0A6364734974656D52657061697249444D6F64656C2E4F72696769
      6E010101010D0A6364734974656D5265706169724D6F64656C2E436F6E737472
      61696E744572726F724D657373616765010101010D0A6364734974656D526570
      6169724D6F64656C2E437573746F6D436F6E73747261696E74010101010D0A63
      64734974656D5265706169724D6F64656C2E44656661756C7445787072657373
      696F6E010101010D0A6364734974656D5265706169724D6F64656C2E496D706F
      72746564436F6E73747261696E74010101010D0A6364734974656D5265706169
      724D6F64656C2E4B65794669656C6473010101010D0A6364734974656D526570
      6169724D6F64656C2E4C6F6F6B75704B65794669656C6473010101010D0A6364
      734974656D5265706169724D6F64656C2E4C6F6F6B7570526573756C74466965
      6C64010101010D0A6364734974656D5265706169724D6F64656C2E4F72696769
      6E010101010D0A6364734974656D5265706169724465736372697074696F6E2E
      436F6E73747261696E744572726F724D657373616765010101010D0A63647349
      74656D5265706169724465736372697074696F6E2E437573746F6D436F6E7374
      7261696E74010101010D0A6364734974656D5265706169724465736372697074
      696F6E2E44656661756C7445787072657373696F6E010101010D0A6364734974
      656D5265706169724465736372697074696F6E2E496D706F72746564436F6E73
      747261696E74010101010D0A6364734974656D52657061697244657363726970
      74696F6E2E4B65794669656C6473010101010D0A6364734974656D5265706169
      724465736372697074696F6E2E4C6F6F6B75704B65794669656C647301010101
      0D0A6364734974656D5265706169724465736372697074696F6E2E4C6F6F6B75
      70526573756C744669656C64010101010D0A6364734974656D52657061697244
      65736372697074696F6E2E4F726967696E010101010D0A6364734974656D5265
      706169725174792E436F6E73747261696E744572726F724D6573736167650101
      01010D0A6364734974656D5265706169725174792E437573746F6D436F6E7374
      7261696E74010101010D0A6364734974656D5265706169725174792E44656661
      756C7445787072657373696F6E010101010D0A6364734974656D526570616972
      5174792E45646974466F726D6174010101010D0A6364734974656D5265706169
      725174792E496D706F72746564436F6E73747261696E74010101010D0A636473
      4974656D5265706169725174792E4B65794669656C6473010101010D0A636473
      4974656D5265706169725174792E4C6F6F6B75704B65794669656C6473010101
      010D0A6364734974656D5265706169725174792E4C6F6F6B7570526573756C74
      4669656C64010101010D0A6364734974656D5265706169725174792E4F726967
      696E010101010D0A6364734974656D526570616972436F737450726963652E43
      6F6E73747261696E744572726F724D657373616765010101010D0A6364734974
      656D526570616972436F737450726963652E437573746F6D436F6E7374726169
      6E74010101010D0A6364734974656D526570616972436F737450726963652E44
      656661756C7445787072657373696F6E010101010D0A6364734974656D526570
      616972436F737450726963652E45646974466F726D6174010101010D0A636473
      4974656D526570616972436F737450726963652E496D706F72746564436F6E73
      747261696E74010101010D0A6364734974656D526570616972436F7374507269
      63652E4B65794669656C6473010101010D0A6364734974656D52657061697243
      6F737450726963652E4C6F6F6B75704B65794669656C6473010101010D0A6364
      734974656D526570616972436F737450726963652E4C6F6F6B7570526573756C
      744669656C64010101010D0A6364734974656D526570616972436F7374507269
      63652E4F726967696E010101010D0A6364734974656D52657061697249445665
      6E646F722E436F6E73747261696E744572726F724D657373616765010101010D
      0A6364734974656D526570616972494456656E646F722E437573746F6D436F6E
      73747261696E74010101010D0A6364734974656D526570616972494456656E64
      6F722E44656661756C7445787072657373696F6E010101010D0A636473497465
      6D526570616972494456656E646F722E45646974466F726D6174010101010D0A
      6364734974656D526570616972494456656E646F722E496D706F72746564436F
      6E73747261696E74010101010D0A6364734974656D526570616972494456656E
      646F722E4B65794669656C6473010101010D0A6364734974656D526570616972
      494456656E646F722E4C6F6F6B75704B65794669656C6473010101010D0A6364
      734974656D526570616972494456656E646F722E4C6F6F6B7570526573756C74
      4669656C64010101010D0A6364734974656D526570616972494456656E646F72
      2E4F726967696E010101010D0A6364734974656D52657061697256656E646F72
      2E436F6E73747261696E744572726F724D657373616765010101010D0A636473
      4974656D52657061697256656E646F722E437573746F6D436F6E73747261696E
      74010101010D0A6364734974656D52657061697256656E646F722E4465666175
      6C7445787072657373696F6E010101010D0A6364734974656D52657061697256
      656E646F722E496D706F72746564436F6E73747261696E74010101010D0A6364
      734974656D52657061697256656E646F722E4B65794669656C6473010101010D
      0A6364734974656D52657061697256656E646F722E4C6F6F6B75704B65794669
      656C6473010101010D0A6364734974656D52657061697256656E646F722E4C6F
      6F6B7570526573756C744669656C64010101010D0A6364734974656D52657061
      697256656E646F722E4F726967696E010101010D0A6364734974656D52657061
      69724944446566656374547970652E436F6E73747261696E744572726F724D65
      7373616765010101010D0A6364734974656D5265706169724944446566656374
      547970652E437573746F6D436F6E73747261696E74010101010D0A6364734974
      656D5265706169724944446566656374547970652E44656661756C7445787072
      657373696F6E010101010D0A6364734974656D52657061697249444465666563
      74547970652E45646974466F726D6174010101010D0A6364734974656D526570
      6169724944446566656374547970652E496D706F72746564436F6E7374726169
      6E74010101010D0A6364734974656D5265706169724944446566656374547970
      652E4B65794669656C6473010101010D0A6364734974656D5265706169724944
      446566656374547970652E4C6F6F6B75704B65794669656C6473010101010D0A
      6364734974656D5265706169724944446566656374547970652E4C6F6F6B7570
      526573756C744669656C64010101010D0A6364734974656D5265706169724944
      446566656374547970652E4F726967696E010101010D0A6364734974656D5265
      70616972446566656374547970652E436F6E73747261696E744572726F724D65
      7373616765010101010D0A6364734974656D5265706169724465666563745479
      70652E437573746F6D436F6E73747261696E74010101010D0A6364734974656D
      526570616972446566656374547970652E44656661756C744578707265737369
      6F6E010101010D0A6364734974656D526570616972446566656374547970652E
      496D706F72746564436F6E73747261696E74010101010D0A6364734974656D52
      6570616972446566656374547970652E4B65794669656C6473010101010D0A63
      64734974656D526570616972446566656374547970652E4C6F6F6B75704B6579
      4669656C6473010101010D0A6364734974656D52657061697244656665637454
      7970652E4C6F6F6B7570526573756C744669656C64010101010D0A6364734974
      656D526570616972446566656374547970652E4F726967696E010101010D0A63
      64734974656D5265706169724F62732E436F6E73747261696E744572726F724D
      657373616765010101010D0A6364734974656D5265706169724F62732E437573
      746F6D436F6E73747261696E74010101010D0A6364734974656D526570616972
      4F62732E44656661756C7445787072657373696F6E010101010D0A6364734974
      656D5265706169724F62732E496D706F72746564436F6E73747261696E740101
      01010D0A6364734974656D5265706169724F62732E4B65794669656C64730101
      01010D0A6364734974656D5265706169724F62732E4C6F6F6B75704B65794669
      656C6473010101010D0A6364734974656D5265706169724F62732E4C6F6F6B75
      70526573756C744669656C64010101010D0A6364734974656D5265706169724F
      62732E4F726967696E010101010D0A6364734974656D5265706169724944496E
      76656E746F72794D6F762E436F6E73747261696E744572726F724D6573736167
      65010101010D0A6364734974656D5265706169724944496E76656E746F72794D
      6F762E437573746F6D436F6E73747261696E74010101010D0A6364734974656D
      5265706169724944496E76656E746F72794D6F762E44656661756C7445787072
      657373696F6E010101010D0A6364734974656D5265706169724944496E76656E
      746F72794D6F762E45646974466F726D6174010101010D0A6364734974656D52
      65706169724944496E76656E746F72794D6F762E496D706F72746564436F6E73
      747261696E74010101010D0A6364734974656D5265706169724944496E76656E
      746F72794D6F762E4B65794669656C6473010101010D0A6364734974656D5265
      706169724944496E76656E746F72794D6F762E4C6F6F6B75704B65794669656C
      6473010101010D0A6364734974656D5265706169724944496E76656E746F7279
      4D6F762E4C6F6F6B7570526573756C744669656C64010101010D0A6364734974
      656D5265706169724944496E76656E746F72794D6F762E4F726967696E010101
      010D0A6364734974656D52657061697252412E436F6E73747261696E74457272
      6F724D657373616765010101010D0A6364734974656D52657061697252412E43
      7573746F6D436F6E73747261696E74010101010D0A6364734974656D52657061
      697252412E44656661756C7445787072657373696F6E010101010D0A63647349
      74656D52657061697252412E496D706F72746564436F6E73747261696E740101
      01010D0A6364734974656D52657061697252412E4B65794669656C6473010101
      010D0A6364734974656D52657061697252412E4C6F6F6B75704B65794669656C
      6473010101010D0A6364734974656D52657061697252412E4C6F6F6B75705265
      73756C744669656C64010101010D0A6364734974656D52657061697252412E4F
      726967696E010101010D0A71754974656D436F6D6D697373696F6E2E436F6D6D
      616E64546578740153656C65637420191A094944436F6D6D697373696F6E2C19
      1A09436F6D6D697373696F6E50657263656E74191A46726F6D20191A0953616C
      654974656D436F6D6D697373696F6E191A5768657265191A094944496E76656E
      746F72794D6F76203D203A4944496E76656E746F72794D6F76191A0101010D0A
      71754974656D436F6D6D697373696F6E2E436F6E6E656374696F6E537472696E
      67010101010D0A71754974656D436F6D6D697373696F6E2E46696C7465720101
      01010D0A71754974656D436F6D6D697373696F6E2E496E6465784669656C644E
      616D6573010101010D0A71754974656D436F6D6D697373696F6E4944436F6D6D
      697373696F6E2E436F6E73747261696E744572726F724D657373616765010101
      010D0A71754974656D436F6D6D697373696F6E4944436F6D6D697373696F6E2E
      437573746F6D436F6E73747261696E74010101010D0A71754974656D436F6D6D
      697373696F6E4944436F6D6D697373696F6E2E44656661756C74457870726573
      73696F6E010101010D0A71754974656D436F6D6D697373696F6E4944436F6D6D
      697373696F6E2E45646974466F726D6174010101010D0A71754974656D436F6D
      6D697373696F6E4944436F6D6D697373696F6E2E496D706F72746564436F6E73
      747261696E74010101010D0A71754974656D436F6D6D697373696F6E4944436F
      6D6D697373696F6E2E4B65794669656C6473010101010D0A71754974656D436F
      6D6D697373696F6E4944436F6D6D697373696F6E2E4C6F6F6B75704B65794669
      656C6473010101010D0A71754974656D436F6D6D697373696F6E4944436F6D6D
      697373696F6E2E4C6F6F6B7570526573756C744669656C64010101010D0A7175
      4974656D436F6D6D697373696F6E4944436F6D6D697373696F6E2E4F72696769
      6E010101010D0A71754974656D436F6D6D697373696F6E436F6D6D697373696F
      6E50657263656E742E436F6E73747261696E744572726F724D65737361676501
      0101010D0A71754974656D436F6D6D697373696F6E436F6D6D697373696F6E50
      657263656E742E437573746F6D436F6E73747261696E74010101010D0A717549
      74656D436F6D6D697373696F6E436F6D6D697373696F6E50657263656E742E44
      656661756C7445787072657373696F6E010101010D0A71754974656D436F6D6D
      697373696F6E436F6D6D697373696F6E50657263656E742E45646974466F726D
      6174010101010D0A71754974656D436F6D6D697373696F6E436F6D6D69737369
      6F6E50657263656E742E496D706F72746564436F6E73747261696E7401010101
      0D0A71754974656D436F6D6D697373696F6E436F6D6D697373696F6E50657263
      656E742E4B65794669656C6473010101010D0A71754974656D436F6D6D697373
      696F6E436F6D6D697373696F6E50657263656E742E4C6F6F6B75704B65794669
      656C6473010101010D0A71754974656D436F6D6D697373696F6E436F6D6D6973
      73696F6E50657263656E742E4C6F6F6B7570526573756C744669656C64010101
      010D0A71754974656D436F6D6D697373696F6E436F6D6D697373696F6E506572
      63656E742E4F726967696E010101010D0A636473496E766F6963652E436F6D6D
      616E6454657874010101010D0A636473496E766F6963652E46696C7465720101
      01010D0A636473496E766F6963652E496E6465784669656C644E616D65730101
      01010D0A636473496E766F6963652E50726F76696465724E616D650164737049
      6E766F6963650101010D0A73744C6F63616C65730D0A43757272656E63792053
      7472696E6701240101010D0A54686F7573616E6420536570617261746F72012C
      0101010D0A446563696D616C20536570617261746F72012E0101010D0A446174
      6520536570617261746F72012F0101010D0A53686F7274204461746520466F72
      6D6174014D2F642F797979790101010D0A4C6F6E67204461746520466F726D61
      7401646464642C204D4D4D4D2064642C20797979790101010D0A54696D652053
      6570617261746F72013A0101010D0A54696D6520414D20537472696E6701414D
      0101010D0A54696D6520504D20537472696E6701504D0101010D0A53686F7274
      2054696D6520466F726D617401683A6D6D20414D504D0101010D0A4C6F6E6720
      54696D6520466F726D617401683A6D6D3A737320414D504D0101010D0A53686F
      7274204D6F6E7468204E616D6573014A616E2C4665622C4D61722C4170722C4D
      61792C4A756E2C4A756C2C4175672C5365702C4F63742C4E6F762C4465630101
      010D0A4C6F6E67204D6F6E7468204E616D6573014A616E756172792C46656272
      756172792C4D617263682C417072696C2C4D61792C4A756E652C4A756C792C41
      75677573742C53657074656D6265722C4F63746F6265722C4E6F76656D626572
      2C446563656D6265720101010D0A53686F727420446179204E616D6573015375
      6E2C4D6F6E2C5475652C5765642C5468752C4672692C5361740101010D0A4C6F
      6E6720446179204E616D65730153756E6461792C4D6F6E6461792C5475657364
      61792C5765646E65736461792C54687572736461792C4672696461792C536174
      75726461790101010D0A7374436F6C6C656374696F6E730D0A73744368617253
      6574730D0A5446726D496E766F696365526566756E640144454641554C545F43
      4841525345540101010D0A6274436C6F736501414E53495F4348415253455401
      01010D0A6868680144454641554C545F43484152534554010D0A}
  end
  object dspInvoice: TDataSetProvider
    DataSet = quInvoice
    Left = 670
    Top = 53
  end
  object cdsInvoice: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'Invoice'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftInteger
        Name = 'IDStore'
        ParamType = ptInput
        Size = -1
      end>
    ProviderName = 'dspInvoice'
    AfterOpen = cdsInvoiceAfterOpen
    Left = 130
    Top = 201
  end
  object quItemCommission: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'Select '#13#10#9'IDCommission,'#13#10#9'CommissionPercent'#13#10'From '#13#10#9'SaleItemCom' +
      'mission (NOLOCK) '#13#10'Where'#13#10#9'IDInventoryMov = :IDInventoryMov'#13#10
    Parameters = <
      item
        Name = 'IDInventoryMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 186
    Top = 181
    object quItemCommissionIDCommission: TIntegerField
      FieldName = 'IDCommission'
    end
    object quItemCommissionCommissionPercent: TBCDField
      FieldName = 'CommissionPercent'
      Precision = 18
      Size = 0
    end
  end
  object dsItemRepair: TDataSource
    DataSet = cdsItemRepair
    Left = 78
    Top = 481
  end
  object cdsItemRepair: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 78
    Top = 433
    object cdsItemRepairID: TIntegerField
      FieldName = 'ID'
    end
    object cdsItemRepairIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsItemRepairModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsItemRepairDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsItemRepairQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.######'
    end
    object cdsItemRepairCostPrice: TCurrencyField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsItemRepairVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsItemRepairDefectType: TStringField
      FieldName = 'DefectType'
      Size = 30
    end
    object cdsItemRepairIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object cdsItemRepairObs: TStringField
      FieldName = 'Obs'
      Size = 255
    end
    object cdsItemRepairIDDefectType: TIntegerField
      FieldName = 'IDDefectType'
    end
    object cdsItemRepairRA: TStringField
      DisplayLabel = 'RA #'
      FieldName = 'RA'
    end
    object cdsItemRepairIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
  end
  object quInvoice: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quInvoiceAfterOpen
    Parameters = <
      item
        Name = 'Invoice'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale,'
      #9'I.IDInvoice,'
      #9'I.PreSaleDate,'
      #9'I.InvoiceDate,'
      #9'I.SaleCode,'
      #9'I.InvoiceCode,'
      #9'I.Note,'
      #9'P.PessoaFirstName,'
      #9'P.PessoaLastName,'
      #9'P.Pessoa,'
      #9'P.IDPessoa,'
      
        #9'(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNu' +
        'll(I.AditionalExpenses, 0)) as TotInvoice,'
      #9'I.IDTouristGroup,'
      #9'I.OtherComissionID,'
      #9'((IM.Qty * IM.SalePrice) - IM.Discount) as ItemTotal,'
      #9'IM.IDInventoryMov,'
      #9'(IM.Qty - IsNull(IM.QtyExchanged,0)) as Qty,'
      #9'IM.CostPrice,'
      #9'IM.SalePrice,'
      #9'IM.Discount,'
      #9'M.IDModel,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.DateLastCost,'
      #9'M.LastCost,'
      #9'V.IDPessoa as IDVendor,'
      #9'V.Pessoa as Vendor,'
      #9'IM.IDDepartment,'
      #9'cast(0 as bit) as Retorno,'
      #9'IM.PreInventoryMovID,'
      #9'0 as Action,'
      '                IM.SalesTax'
      'FROM'
      #9'Invoice I (NOLOCK)'
      #9'LEFT JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa'
      
        #9'JOIN InventoryMov IM (NOLOCK) ON (IM.DocumentID = I.IDInvoice A' +
        'ND IM.InventMovTypeID = 1)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)'
      
        #9'LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDMode' +
        'l AND VendorOrder = 1)'
      #9'LEFT JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa)'
      'WHERE'
      #9'I.IDInvoice Is NOT NULL'
      #9'AND I.Canceled = 0'
      #9'AND I.InvoiceCode = :Invoice'
      #9'AND IM.StoreID = :IDStore'
      #9'AND IM.Qty > 0'
      #9'AND IM.ExchangeInvoice IS NULL'
      #9'AND IM.IDParentPack Is Null')
    Left = 701
    Top = 52
  end
  object dsInvoice: TDataSource
    DataSet = cdsInvoice
    Left = 133
    Top = 153
  end
  object cmdItemRepair: TADOCommand
    CommandText = 
      'INSERT Sal_ItemRepair (IDItemRepair, IDPreInventoryMov, Obs, IDD' +
      'efectType, RA, IDVendor)'#13#10'VALUES (:IDItemRepair, :IDPreInventory' +
      'Mov, :Obs, :IDDefectType, :RA, :IDVendor)'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDItemRepair'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Obs'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'IDDefectType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'RA'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'IDVendor'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 78
    Top = 381
  end
  object quItem: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quItemAfterOpen
    Parameters = <
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale,'
      #9'I.IDInvoice,'
      #9'I.PreSaleDate,'
      #9'I.InvoiceDate,'
      #9'I.SaleCode,'
      #9'I.InvoiceCode,'
      #9'I.Note,'
      #9'P.PessoaFirstName,'
      #9'P.PessoaLastName,'
      #9'P.Pessoa,'
      #9'P.IDPessoa,'
      
        #9'(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNu' +
        'll(I.AditionalExpenses, 0)) as TotInvoice,'
      #9'I.IDTouristGroup,'
      #9'I.OtherComissionID,'
      #9'((PIM.Qty * PIM.SalePrice) - PIM.Discount) as ItemTotal,'
      #9'0 as IDInventoryMov,'
      #9'ABS(PIM.Qty) as Qty,'
      #9'PIM.CostPrice,'
      #9'PIM.SalePrice,'
      #9'PIM.Discount,'
      #9'M.IDModel,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.DateLastCost,'
      #9'M.LastCost,'
      #9'V.IDPessoa as IDVendor,'
      #9'V.Pessoa as Vendor,'
      #9'PIM.IDDepartment,'
      #9'cast(0 as bit) as Retorno,'
      #9'PIM.IDPreInventoryMov as PreInventoryMovID,'
      #9'0 as Action'
      'FROM'
      #9'Invoice I (NOLOCK)'
      #9'LEFT JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa'
      
        #9'JOIN PreInventoryMov PIM (NOLOCK) ON (PIM.DocumentID = I.IDPreS' +
        'ale AND PIM.InventMovTypeID = 1)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)'
      
        #9'LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDMode' +
        'l AND VendorOrder = 1)'
      #9'LEFT JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa)'
      'WHERE'
      #9'PIM.IDPreInventoryMov = :IDPreInventoryMov')
    Left = 701
    Top = 14
  end
  object dspItem: TDataSetProvider
    DataSet = quItem
    Left = 671
    Top = 14
  end
end
