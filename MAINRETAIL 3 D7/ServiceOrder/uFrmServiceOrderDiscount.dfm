inherited FrmServiceOrderDiscount: TFrmServiceOrderDiscount
  Left = 229
  Top = 227
  Width = 385
  Height = 322
  BorderIcons = [biSystemMenu]
  Caption = 'Discount'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 254
    Width = 377
    inherited EspacamentoInferior: TPanel
      Width = 377
      inherited Panel3: TPanel
        Width = 377
      end
    end
    inherited hhh: TPanel
      Left = 161
      Width = 216
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        OnClick = btCloseClick
      end
      object btnApply: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Apply'
        TabOrder = 1
        TabStop = False
        Visible = False
        OnClick = btnApplyClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 3
    Width = 1
    Height = 251
  end
  inherited EspacamentoDireito: TPanel
    Left = 375
    Top = 3
    Width = 2
    Height = 251
  end
  inherited EspacamentoSuperior: TPanel
    Width = 377
    Height = 3
  end
  object pgDiscount: TPageControl [4]
    Left = 1
    Top = 3
    Width = 374
    Height = 251
    ActivePage = tsConfig
    Align = alClient
    TabOrder = 4
    TabStop = False
    object tsConfig: TTabSheet
      Caption = 'Config'
      object lbPayment: TLabel
        Left = 15
        Top = 10
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Payment :'
      end
      object lbDiscount: TLabel
        Left = 263
        Top = 9
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Discount :'
      end
      object btnDelPet: TSpeedButton
        Left = 283
        Top = 56
        Width = 80
        Height = 24
        Caption = '&Remove'
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
        Margin = 5
        OnClick = btnDelPetClick
      end
      object btnAddPet: TSpeedButton
        Left = 283
        Top = 31
        Width = 80
        Height = 24
        Caption = 'A&dd'
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
        Margin = 5
        OnClick = btnAddPetClick
      end
      object grdDiscount: TcxGrid
        Left = 4
        Top = 32
        Width = 277
        Height = 181
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdDiscountDBTableView: TcxGridDBTableView
          DataController.DataSource = dsPaymentDiscount
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPaymentDiscount'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object grdDiscountDBTableViewPayment: TcxGridDBColumn
            DataBinding.FieldName = 'Payment'
          end
          object grdDiscountDBTableViewDiscountPercent: TcxGridDBColumn
            DataBinding.FieldName = 'DiscountPercent'
          end
        end
        object grdDiscountLevel: TcxGridLevel
          GridView = grdDiscountDBTableView
        end
      end
      object spnSpecialDiscount: TcxSpinEdit
        Left = 313
        Top = 5
        Width = 50
        Height = 21
        Properties.MaxValue = 100.000000000000000000
        Properties.ValueType = vtInt
        Style.BorderStyle = ebs3D
        TabOrder = 1
      end
      object cmbPaymentType: TSuperComboADO
        Tag = 1
        Left = 65
        Top = 6
        Width = 182
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        LookUpSource = DM.dsLookUpMeioPag
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
    end
    object tsApply: TTabSheet
      Caption = 'Apply'
      ImageIndex = 1
      object Label1: TLabel
        Left = 107
        Top = 195
        Width = 91
        Height = 13
        Alignment = taRightJustify
        Caption = 'Selected discount :'
      end
      object cxGridApplyDisc: TcxGrid
        Left = 3
        Top = 6
        Width = 358
        Height = 177
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object cxApplyDiscTableView: TcxGridDBTableView
          DataController.DataSource = dsPaymentDiscount
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPaymentDiscount'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object cxGridDBColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'Payment'
            Width = 242
          end
          object cxGridDBColumn2: TcxGridDBColumn
            DataBinding.FieldName = 'DiscountPercent'
            Width = 109
          end
        end
        object cxApplyDiscLevel: TcxGridLevel
          GridView = cxApplyDiscTableView
        end
      end
      object seApplyDiscount: TcxSpinEdit
        Left = 202
        Top = 191
        Width = 50
        Height = 21
        Properties.MaxValue = 100.000000000000000000
        Properties.ValueType = vtInt
        Style.BorderStyle = ebs3D
        TabOrder = 1
      end
    end
  end
  object quPaymentDiscount: TADODataSet [5]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PD.IDPaymentDiscount,'#13#10#9'MP.MeioPag as Payment,'#13#10#9'MP.IDM' +
      'eioPag,'#13#10#9'PD.DiscountPercent'#13#10'FROM'#13#10#9'Sal_PaymentDiscount PD (NOL' +
      'OCK)'#13#10#9'JOIN MeioPag MP (NOLOCK) ON (MP.IDMeioPag = PD.IDMeioPag)' +
      #13#10
    Parameters = <>
    Left = 45
    Top = 82
    object quPaymentDiscountIDPaymentDiscount: TIntegerField
      FieldName = 'IDPaymentDiscount'
    end
    object quPaymentDiscountPayment: TStringField
      FieldName = 'Payment'
      Size = 50
    end
    object quPaymentDiscountDiscountPercent: TBCDField
      DisplayLabel = 'Discount %'
      FieldName = 'DiscountPercent'
      DisplayFormat = '0.##'
      Precision = 19
    end
    object quPaymentDiscountIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
  end
  object dsPaymentDiscount: TDataSource [6]
    DataSet = quPaymentDiscount
    OnDataChange = dsPaymentDiscountDataChange
    Left = 45
    Top = 127
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmServiceOrderDiscount.sil'
  end
end
