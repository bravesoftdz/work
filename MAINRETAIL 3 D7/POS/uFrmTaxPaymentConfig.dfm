inherited FrmTaxPaymentConfig: TFrmTaxPaymentConfig
  Left = 84
  Top = 156
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar'
  ClientHeight = 292
  ClientWidth = 604
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl [0]
    Left = 0
    Top = 6
    Width = 604
    Height = 249
    ActivePage = tsTax
    Align = alClient
    TabOrder = 0
    object tsTax: TTabSheet
      Caption = 'ECF configurar Impostos'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 596
        Height = 221
        Align = alClient
        DataSource = dsTaxCategoryMem
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IDTaxCategory'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'TaxCategory'
            Title.Caption = 'Categoria'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Tax'
            Title.Caption = 'Imposto'
            Width = 92
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ECFTaxIndex'
            Title.Caption = 'ECF Cod. impostos'
            Width = 112
            Visible = True
          end>
      end
    end
    object tsPayment: TTabSheet
      Caption = 'ECF Configurar pagamentos'
      ImageIndex = 1
      object lbTEFDedInfo: TLabel
        Left = 0
        Top = 0
        Width = 596
        Height = 26
        Align = alTop
        AutoSize = False
        Caption = 'Cart'#227'o Fininvest o valor da bandeira '#233' 32.'
        WordWrap = True
      end
      object DBGrid2: TDBGrid
        Left = 0
        Top = 26
        Width = 596
        Height = 195
        Align = alClient
        DataSource = dsMeioPagMem
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IDMeioPag'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'MeioPag'
            Title.Caption = 'Pagamento'
            Width = 257
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CodFiscal'
            Width = 136
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CodVinc'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Bandeira'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TipoTEF'
            Visible = True
          end>
      end
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 255
    Width = 604
    Height = 37
    Align = alBottom
    TabOrder = 1
    object spHelp: TSpeedButton
      Tag = 5
      Left = 267
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
      OnClick = spHelpClick
    end
    object btCancel: TButton
      Left = 531
      Top = 3
      Width = 66
      Height = 31
      Cancel = True
      Caption = '&Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btCancelClick
    end
    object btnResult: TButton
      Left = 461
      Top = 3
      Width = 66
      Height = 31
      Cancel = True
      Caption = 'Informar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnResultClick
    end
  end
  object EspacamentoInferior: TPanel [2]
    Left = 0
    Top = 0
    Width = 604
    Height = 6
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Panel3: TPanel
      Left = 0
      Top = 4
      Width = 604
      Height = 2
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  inherited siLang: TsiLangRT
    Left = 19
    Top = 116
  end
  object quTaxCategory: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDTaxCategory,'
      #9'TaxCategory,'
      #9'Tax'
      'FROM'
      #9'TaxCategory'
      'WHERE'
      #9'OperationType = 1'
      #9'AND'
      #9'SaleTaxType = 2'
      'ORDER BY'
      #9'TaxCategory')
    Left = 103
    Top = 65
  end
  object dsTaxCategoryMem: TDataSource
    DataSet = cdsTaxCategoryMem
    Left = 102
    Top = 184
  end
  object quMeioPag: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDMeioPag,'
      #9'MeioPag'
      'FROM'
      #9'MeioPag'
      'WHERE'
      #9'Desativado = 0 '
      #9'AND'
      #9'Hidden = 0'
      #9'AND'
      #9'IDMeioPag <> 0'
      #9'AND'
      #9'IDMeioPagBatch IS NOT NULL'
      'ORDER BY'
      #9'MeioPag'
      '')
    Left = 289
    Top = 62
  end
  object dsMeioPagMem: TDataSource
    DataSet = cdsMeioPagMem
    Left = 291
    Top = 181
  end
  object cdsTaxCategoryMem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 100
    Top = 134
    object cdsTaxCategoryMemIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
      ProviderFlags = [pfInWhere]
      Visible = False
    end
    object cdsTaxCategoryMemTaxCategory: TStringField
      DisplayLabel = 'Tax Category'
      FieldName = 'TaxCategory'
      ProviderFlags = [pfInWhere]
      Size = 50
    end
    object cdsTaxCategoryMemTax: TBCDField
      FieldName = 'Tax'
      ProviderFlags = [pfInWhere]
      DisplayFormat = '##0.00 %'
      Precision = 19
    end
    object cdsTaxCategoryMemECFTaxIndex: TStringField
      DisplayWidth = 5
      FieldName = 'ECFTaxIndex'
      OnSetText = cdsTaxCategoryMemECFTaxIndexSetText
      Size = 5
    end
  end
  object cdsMeioPagMem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 292
    Top = 126
    object cdsMeioPagMemIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
      ReadOnly = True
      Visible = False
    end
    object cdsMeioPagMemMeioPag: TStringField
      DisplayLabel = 'Payment'
      FieldName = 'MeioPag'
      ReadOnly = True
      Size = 50
    end
    object cdsMeioPagMemCodFiscal: TStringField
      DisplayLabel = 'Cod. Fiscal/Desc. Fiscal'
      FieldName = 'CodFiscal'
      OnSetText = cdsMeioPagMemCodFiscalSetText
    end
    object cdsMeioPagMemCodVinc: TStringField
      DisplayLabel = 'Cod. Vinc.'
      FieldName = 'CodVinc'
      OnSetText = cdsMeioPagMemCodVincSetText
      Size = 2
    end
    object cdsMeioPagMemBandeira: TIntegerField
      FieldName = 'Bandeira'
      OnSetText = cdsMeioPagMemBandeiraSetText
    end
    object cdsMeioPagMemTipoTEF: TIntegerField
      FieldName = 'TipoTEF'
      OnSetText = cdsMeioPagMemTipoTEFSetText
    end
  end
  object dspTaxCategory: TDataSetProvider
    DataSet = quTaxCategory
    Left = 104
    Top = 64
  end
  object cdsTaxCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTaxCategory'
    Left = 104
    Top = 64
    object cdsTaxCategoryIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
      ReadOnly = True
    end
    object cdsTaxCategoryTaxCategory: TStringField
      FieldName = 'TaxCategory'
      ReadOnly = True
      Size = 50
    end
    object cdsTaxCategoryTax: TBCDField
      FieldName = 'Tax'
      ReadOnly = True
      Precision = 19
    end
  end
  object dspMeioPag: TDataSetProvider
    DataSet = quMeioPag
    Left = 288
    Top = 64
  end
  object cdsMeioPag: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPag'
    Left = 288
    Top = 64
    object cdsMeioPagIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
      ReadOnly = True
    end
    object cdsMeioPagMeioPag: TStringField
      FieldName = 'MeioPag'
      ReadOnly = True
      Size = 50
    end
  end
end
