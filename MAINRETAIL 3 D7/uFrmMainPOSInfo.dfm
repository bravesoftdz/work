inherited FrmMainPOSInfo: TFrmMainPOSInfo
  Left = 1052
  Top = 313
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Hold Info'
  ClientHeight = 262
  ClientWidth = 455
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 221
    Width = 455
    inherited EspacamentoInferior: TPanel
      Width = 455
      inherited Panel3: TPanel
        Width = 455
      end
    end
    inherited hhh: TPanel
      Left = 304
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        ModalResult = 1
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 215
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 452
    Height = 215
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 455
    Visible = False
  end
  object pgInvoiceInfo: TPageControl [4]
    Left = 3
    Top = 6
    Width = 449
    Height = 215
    ActivePage = tsDiscount
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 4
    object tsDiscount: TTabSheet
      Caption = 'Discount'
      ImageIndex = 1
      object pnlSpecialDiscount: TPanel
        Left = 43
        Top = 37
        Width = 338
        Height = 128
        BevelOuter = bvNone
        Color = cl3DLight
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 23
          Top = 38
          Width = 94
          Height = 24
          Alignment = taRightJustify
          Caption = 'Discount :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbTotal: TLabel
          Left = 56
          Top = 78
          Width = 59
          Height = 24
          Alignment = taRightJustify
          Caption = 'Total :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtDollarDiscount: TEdit
          Left = 171
          Top = 36
          Width = 81
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          Text = '0'
          Visible = False
          OnChange = edtDollarDiscountChange
        end
        object spnSpecialDiscount: TcxSpinEdit
          Left = 171
          Top = 36
          Width = 82
          Height = 28
          ParentFont = False
          Properties.ValueType = vtFloat
          Properties.OnChange = spnSpecialDiscountPropertiesChange
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -16
          Style.Font.Name = 'MS Sans Serif'
          Style.Font.Style = [fsBold]
          Style.LookAndFeel.Kind = lfStandard
          TabOrder = 3
        end
        object btApplyPriceManager: TBitBtn
          Left = 260
          Top = 37
          Width = 35
          Height = 26
          TabOrder = 1
          OnClick = btApplyPriceManagerClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
        end
        object cbxType: TComboBox
          Left = 121
          Top = 36
          Width = 47
          Height = 28
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ItemHeight = 20
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = '%'
          OnChange = cbxTypeChange
          Items.Strings = (
            '%'
            '$')
        end
        object edtDisTotalInv: TSuperEditCurrency
          Left = 121
          Top = 76
          Width = 128
          Height = 28
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Text = '0.00'
          Visible = False
          Alignment = taRightJustify
          OnCurrChange = edtDisTotalInvCurrChange
          DisplayFormat = '0.00'
        end
      end
    end
    object tsOtherCosts: TTabSheet
      Caption = '  Other Costs  '
      ImageIndex = 3
      OnShow = tsOtherCostsShow
      object Label29: TLabel
        Left = 9
        Top = 9
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cost Type :'
      end
      object Label30: TLabel
        Left = 260
        Top = 10
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cost :'
      end
      object btAddCost: TSpeedButton
        Left = 370
        Top = 6
        Width = 71
        Height = 24
        Caption = 'Add'
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
        Margin = 6
        OnClick = btAddCostClick
      end
      object btRemoveCost: TSpeedButton
        Left = 370
        Top = 33
        Width = 71
        Height = 24
        Caption = 'Remove'
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
        OnClick = btRemoveCostClick
      end
      object grdSerial: TSMDBGrid
        Left = 6
        Top = 31
        Width = 360
        Height = 146
        DataSource = dsAditinalExpenses
        Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Flat = True
        Groupings = <>
        GridStyle.Style = gsCustom
        GridStyle.OddColor = clWindow
        GridStyle.EvenColor = 14607076
        FooterColor = clBtnFace
        ExOptions = [eoAutoWidth]
        RegistryKey = 'Software\Scalabium'
        RegistrySection = 'SMDBGrid'
        WidthOfIndicator = 11
        DefaultRowHeight = 17
        ScrollBars = ssVertical
        ColCount = 3
        RowCount = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'IDInvoiceCost'
            Visible = False
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'CostType'
            Width = 255
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Amount'
            Title.Alignment = taRightJustify
            Width = 101
            Visible = True
            FooterType = ftCustom
          end>
      end
      object editCustoUnitario: TEdit
        Left = 289
        Top = 6
        Width = 75
        Height = 21
        TabOrder = 1
        OnKeyDown = editCustoUnitarioKeyDown
        OnKeyPress = editCustoUnitarioKeyPress
      end
      object scCostType: TSuperComboADO
        Left = 65
        Top = 6
        Width = 181
        Height = 21
        TabOrder = 0
        LookUpSource = DM.dsLookUpCostType
        DropDownRows = 8
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
        OnSelectItem = scCostTypeSelectItem
      end
    end
    object tsNotes: TTabSheet
      Caption = 'Notes'
      object EditNote: TDbMemoStr
        Tag = 3
        Left = 3
        Top = 4
        Width = 438
        Height = 163
        BorderStyle = bsNone
        Color = clWhite
        DataField = 'Note'
        DataSource = dsInvoice
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 150
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object dbPrintNotes: TDBCheckBox
        Left = 3
        Top = 168
        Width = 222
        Height = 17
        Caption = 'Print notes'
        DataField = 'PrintNotes'
        DataSource = dsInvoice
        TabOrder = 1
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
    object tsDelivery: TTabSheet
      Caption = 'Delivery'
      ImageIndex = 2
      object pnlConfirmDeliver: TPanel
        Left = -4
        Top = 57
        Width = 453
        Height = 124
        BevelOuter = bvNone
        TabOrder = 0
        object Label6: TLabel
          Left = 10
          Top = 33
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'Address :'
        end
        object Label5: TLabel
          Left = 25
          Top = 7
          Width = 29
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date :'
        end
        object Label28: TLabel
          Left = 27
          Top = 61
          Width = 28
          Height = 13
          Caption = 'OBS :'
          FocusControl = edtDelOBS
        end
        object lbConfirmDelivery: TLabel
          Left = 191
          Top = 91
          Width = 21
          Height = 13
          Caption = 'aaa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label35: TLabel
          Left = 157
          Top = 6
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label34: TLabel
          Left = 336
          Top = 33
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditDelDate: TDBDateBox
          Tag = 2
          Left = 58
          Top = 4
          Width = 96
          Height = 21
          ReadOnly = False
          TabOrder = 0
          Text = 'EditDelDate'
          Language = Portuguese
          DataField = 'DeliverDate'
          DataSource = dsInvoice
        end
        object EditDelAddress: TDBEdit
          Tag = 2
          Left = 58
          Top = 30
          Width = 276
          Height = 21
          DataField = 'DeliverAddress'
          DataSource = dsInvoice
          TabOrder = 1
        end
        object edtDelOBS: TDBEdit
          Left = 58
          Top = 57
          Width = 276
          Height = 21
          DataField = 'DeliverOBS'
          DataSource = dsInvoice
          TabOrder = 2
        end
        object btnDelivery: TBitBtn
          Left = 58
          Top = 86
          Width = 126
          Height = 22
          Caption = 'Confirm Delivery'
          TabOrder = 3
          OnClick = btnDeliveryClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
        end
      end
      object Panel8: TPanel
        Left = 3
        Top = 30
        Width = 446
        Height = 27
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label4: TLabel
          Left = 17
          Top = 6
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Type :'
        end
        object cmbDelType: TDBSuperComboADO
          Tag = 2
          Left = 51
          Top = 3
          Width = 276
          Height = 21
          TabOrder = 0
          Text = 'cmbDelType'
          LookUpSource = DM.dsLookUpDeliverType
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          ShowEditCode = True
          IDLanguage = 0
          OnSelectItem = cmbDelTypeSelectItem
          DataField = 'DeliverTypeID'
          DataSource = dsInvoice
        end
        object btSplitHold: TBitBtn
          Left = 335
          Top = 0
          Width = 90
          Height = 27
          Caption = 'Split Hold'
          TabOrder = 1
          Visible = False
          Margin = 3
        end
      end
    end
    object tsSprecialPrice: TTabSheet
      Caption = 'Special Price'
      ImageIndex = 4
      object Panel5: TPanel
        Left = 22
        Top = 50
        Width = 383
        Height = 65
        BevelOuter = bvNone
        Color = cl3DLight
        TabOrder = 0
        object Label7: TLabel
          Left = 19
          Top = 4
          Width = 84
          Height = 13
          Caption = 'Special Price :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btMakeSpecialPrice: TSpeedButton
          Tag = 5
          Left = 107
          Top = 30
          Width = 206
          Height = 21
          Caption = 'Special  &Price'
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
            88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
            88880F080F08080008440FF08080808880440000080808888844888880808888
            8844888888088888804488888880000008448888888888888888}
          OnClick = btMakeSpecialPriceClick
        end
        object dbSpecialPrice: TDBEdit
          Tag = 5
          Left = 107
          Top = 0
          Width = 206
          Height = 21
          DataField = 'SpecialPrice'
          DataSource = dsValues
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    Left = 32
    Top = 224
  end
  object dsInvoice: TDataSource
    Left = 375
    Top = 54
  end
  object dsValues: TDataSource
    Left = 323
    Top = 54
  end
  object quAditionalExpenses: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'C.CostType,'#13#10#9'ICT.IDInvoiceCost,'#13#10#9'ICT.IDCostType,'#13#10#9'IC' +
      'T.Amount'#13#10'FROM'#13#10#9'InvoiceToCostType ICT (NOLOCK) '#13#10#9'LEFT OUTER JO' +
      'IN CostType C (NOLOCK) ON (C.IDCostType = ICT.IDCostType)'#13#10'WHERE' +
      #13#10#9'ICT.IDPreSale = :IDPreSale'#13#10
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 390
    Top = 147
    object quAditionalExpensesCostType: TStringField
      FieldName = 'CostType'
      Size = 50
    end
    object quAditionalExpensesIDInvoiceCost: TIntegerField
      FieldName = 'IDInvoiceCost'
    end
    object quAditionalExpensesIDCostType: TIntegerField
      FieldName = 'IDCostType'
    end
    object quAditionalExpensesAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dsAditinalExpenses: TDataSource
    DataSet = quAditionalExpenses
    Left = 386
    Top = 102
  end
end
