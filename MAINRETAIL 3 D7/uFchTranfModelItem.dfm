inherited FchTranfModelItem: TFchTranfModelItem
  Left = 179
  Top = 96
  Caption = 'FchTranfModelItem'
  ClientHeight = 434
  ClientWidth = 562
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 562
    inherited Image1: TImage
      Width = 288
    end
    inherited lblMenu: TLabel
      Left = 529
    end
    inherited EspacamentoSuperior: TPanel
      Width = 562
      inherited EEE: TPanel
        Width = 562
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 515
    end
  end
  inherited Panel1: TPanel
    Top = 393
    Width = 562
    inherited EspacamentoInferior: TPanel
      Width = 562
      inherited Panel3: TPanel
        Width = 562
      end
    end
    inherited hhh: TPanel
      Left = 341
    end
  end
  inherited pnlKey: TPanel
    Width = 562
    Height = 0
    inherited Panel4: TPanel
      Top = -2
      Width = 562
    end
  end
  inherited pnlDetail: TPanel
    Left = 0
    Top = 40
    Width = 562
    Height = 0
    Align = alTop
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 40
    Height = 353
  end
  inherited EspacamentoDireito: TPanel
    Left = 559
    Top = 40
    Height = 353
  end
  inherited pnlPPageControl: TPanel
    Left = 3
    Top = 40
    Width = 556
    Height = 353
    Align = alClient
    inherited PPageControl: TPageControl
      Width = 556
      Height = 353
      ActivePage = tsItem
      inherited tsBrowse: TTabSheet
        TabVisible = False
        inherited Label1: TLabel
          Width = 548
        end
        inherited pnlComand: TPanel
          Left = 441
          Height = 304
        end
        inherited pnlsdjhfksdhfjksdhf: TPanel
          Width = 548
        end
        inherited grdBrowse: TcxGrid
          Width = 441
          Height = 304
          inherited grdBrowseDB: TcxGridDBTableView
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
          end
        end
      end
      object tsItem: TTabSheet
        Caption = 'Model'
        ImageIndex = 1
        object Label2: TLabel
          Left = 22
          Top = 80
          Width = 67
          Height = 13
          Alignment = taRightJustify
          Caption = 'Qty transfer :'
        end
        object Label4: TLabel
          Left = 0
          Top = 0
          Width = 548
          Height = 16
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Item to Transfer'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object lbCost: TLabel
          Left = 16
          Top = 108
          Width = 73
          Height = 13
          Alignment = taRightJustify
          Caption = 'Transfer Cost :'
          FocusControl = edtCostPrice
        end
        object lbTax: TLabel
          Left = 226
          Top = 80
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax Value :'
          FocusControl = DBEdit2
        end
        object lbBarcode: TLabel
          Left = 43
          Top = 24
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Barcode :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbModel: TLabel
          Left = 54
          Top = 52
          Width = 35
          Height = 13
          Alignment = taRightJustify
          Caption = 'Model :'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 528
          Top = 50
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
        object Label5: TLabel
          Left = 184
          Top = 76
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
        object Label6: TLabel
          Left = 184
          Top = 104
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
        object lbSellingPrice: TLabel
          Left = 217
          Top = 106
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Selling Price :'
          FocusControl = DBEdit1
        end
        object lbLot: TLabel
          Left = 64
          Top = 131
          Width = 22
          Height = 13
          Alignment = taRightJustify
          Caption = 'Lot :'
          FocusControl = DBEdit2
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lbTaxCode: TLabel
          Left = 395
          Top = 80
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tax Code :'
          FocusControl = edtTaxCode
          Visible = False
        end
        object EditQty: TDBEdit
          Left = 92
          Top = 76
          Width = 90
          Height = 21
          DataField = 'Qty'
          DataSource = dsForm
          TabOrder = 2
          OnKeyPress = EditQtyKeyPress
        end
        object cmbModel: TDBSuperComboADO
          Left = 92
          Top = 48
          Width = 409
          Height = 21
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'cmbModel'
          CodeLength = 320
          LookUpSource = DM.dsLookUpModelKit
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          ShowEditCode = True
          EditCodePos = taEditCodeRight
          MostraHidden = STD_AMBOSHIDDEN
          IDLanguage = 0
          OnSelectItem = cmbModelSelectItem
          DataField = 'IDModel'
          DataSource = dsForm
        end
        object SubQty: TSubListPanel
          Left = 0
          Top = 157
          Width = 548
          Height = 168
          Align = alBottom
          BevelOuter = bvNone
          Color = clBtnShadow
          TabOrder = 8
          SubListClassName = 'TSubStoreQty'
        end
        object edtCostPrice: TDBEdit
          Left = 92
          Top = 104
          Width = 90
          Height = 21
          DataField = 'CostPrice'
          DataSource = dsForm
          TabOrder = 3
          OnKeyPress = EditQtyKeyPress
        end
        object DBEdit2: TDBEdit
          Left = 283
          Top = 76
          Width = 91
          Height = 21
          DataField = 'Tax'
          DataSource = dsForm
          TabOrder = 4
          OnKeyPress = EditQtyKeyPress
        end
        object edtBarcode: TmrBarCodeEdit
          Left = 92
          Top = 20
          Width = 185
          Height = 21
          Color = 8454143
          TabOrder = 0
          OnEnter = edtBarcodeEnter
          OnExit = edtBarcodeExit
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
        object DBEdit1: TDBEdit
          Left = 283
          Top = 102
          Width = 92
          Height = 21
          DataField = 'SellingPrice'
          DataSource = dsForm
          TabOrder = 5
          OnKeyPress = EditQtyKeyPress
        end
        object btnSearchDesc: TBitBtn
          Left = 504
          Top = 48
          Width = 23
          Height = 22
          TabOrder = 10
          OnClick = btnSearchDescClick
        end
        object scLot: TDBSuperComboADO
          Left = 91
          Top = 129
          Width = 284
          Height = 21
          TabOrder = 7
          Text = 'scLot'
          Visible = False
          OnEnter = scLotEnter
          CodeLength = 240
          LookUpSource = DM.dsLookUpLot
          DropDownRows = 18
          EditCodePos = taEditCodeRight
          IDLanguage = 0
          DataField = 'IDLote'
          DataSource = dsForm
        end
        object edtTaxCode: TDBEdit
          Left = 451
          Top = 76
          Width = 50
          Height = 21
          DataField = 'TaxCode'
          DataSource = dsForm
          TabOrder = 6
          Visible = False
          OnKeyPress = EditQtyKeyPress
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchTranfModelItem.sil'
    TranslationData = {
      737443617074696F6E730D0A5462727746726D506172656E7442727701627277
      46726D506172656E744272770101010D0A50616E656C31010101010D0A6C626C
      557365724E616D65016C626C557365724E616D650101010D0A4C6162656C3135
      01557365723A0101010D0A4573706163616D656E746F496E666572696F720101
      01010D0A50616E656C33010101010D0A706E6C4E617669676174696F6E010101
      010D0A62744669727374526563013C3C0101010D0A62745072696F7252656301
      3C0101010D0A62744E657874526563013E0101010D0A62744C61737452656301
      3E3E0101010D0A50616E656C32010101010D0A6C626C4D656E75014669727374
      204D656E75204974656D0101010D0A4573706163616D656E746F537570657269
      6F72010101010D0A454545010101010D0A706E6C4175746F496E63010101010D
      0A62744C6F6F70496E63010101010D0A6C626C4D6F6469666965640145646974
      204D6F64650101010D0A706E6C4B6579010101010D0A50616E656C3401010101
      0D0A706E6C44657461696C010101010D0A4573706163616D656E746F45737175
      6572646F010101010D0A4573706163616D656E746F4469726569746F01010101
      0D0A706E6C5050616765436F6E74726F6C01706E6C5050616765436F6E74726F
      6C0101010D0A747342726F77736501747342726F7773650101010D0A4C616265
      6C31014368616E676520666F722074686520636F7272656374206E616D650101
      010D0A706E6C436F6D616E64010101010D0A6274416464014632202641646401
      01010D0A627444657461696C014633202644657461696C73200101010D0A6274
      52656D6F7665014634205265266D6F76650101010D0A627447726F7570012647
      726F7570696E670101010D0A6274436F6C756D6E0126436F6C756D6E73010101
      0D0A6274507265766965770146352026507265766965770101010D0A62744578
      63656C0146362053707265616473686565740101010D0A50616E656C38010101
      010D0A50616E656C36010101010D0A706E6C73646A68666B736468666A6B7364
      6866010101010D0A737448696E74730D0A5462727746726D506172656E744272
      7701010D0A50616E656C31010101010D0A6C626C557365724E616D6501010101
      0D0A4C6162656C3135010101010D0A4573706163616D656E746F496E66657269
      6F72010101010D0A50616E656C33010101010D0A706E6C4E617669676174696F
      6E010101010D0A62744669727374526563014D6F766520746F20466972737420
      5265636F72640101010D0A62745072696F72526563014D6F766520746F205072
      696F72205265636F72640101010D0A62744E657874526563014D6F766520746F
      204E657874205265636F72640101010D0A62744C617374526563014D6F766520
      746F204C617374205265636F72640101010D0A50616E656C32010101010D0A49
      6D61676531010101010D0A6C626C4D656E75010101010D0A4573706163616D65
      6E746F5375706572696F72010101010D0A454545010101010D0A706E6C417574
      6F496E63015072657373206865726520746F20636F6E74696E75696E6720696E
      7365727420646174610101010D0A62744C6F6F70496E6301436F6E74696E7569
      6E6720696E73657274206461746120776974686F757420636C6F73696E672074
      68652073637265656E2E0101010D0A6C626C4D6F646966696564010101010D0A
      706E6C4B6579010101010D0A50616E656C34010101010D0A706E6C4465746169
      6C010101010D0A4573706163616D656E746F457371756572646F010101010D0A
      4573706163616D656E746F4469726569746F010101010D0A706E6C5050616765
      436F6E74726F6C010101010D0A5050616765436F6E74726F6C010101010D0A74
      7342726F777365010101010D0A4C6162656C31010101010D0A706E6C436F6D61
      6E64010101010D0A6274416464010101010D0A627444657461696C010101010D
      0A627452656D6F7665010101010D0A627447726F7570010101010D0A6274436F
      6C756D6E010101010D0A627450726576696577010101010D0A6274457863656C
      014578706F7274206772696420746F2053707265616473686565740101010D0A
      50616E656C38010101010D0A50616E656C36010101010D0A706E6C73646A6866
      6B736468666A6B73646866010101010D0A7374446973706C61794C6162656C73
      0D0A7374466F6E74730D0A5462727746726D506172656E74427277015461686F
      6D610101010D0A6C626C557365724E616D6501417269616C0101010D0A4C6162
      656C313501417269616C0101010D0A6274466972737452656301417269616C01
      01010D0A62745072696F7252656301417269616C0101010D0A62744E65787452
      656301417269616C0101010D0A62744C61737452656301417269616C0101010D
      0A6C626C4D656E750156657264616E610101010D0A6C626C4D6F646966696564
      01536D616C6C20466F6E74730101010D0A4C6162656C31015461686F6D610101
      010D0A73744D756C74694C696E65730D0A7175466F726D2E46696C7465724669
      656C6473010101010D0A7175466F726D2E46696C74657256616C756573010101
      010D0A466F726D436F6E6669672E446570656E64656E745461626C654B657973
      010101010D0A466F726D436F6E6669672E446570656E64656E745461626C6573
      010101010D0A466F726D436F6E6669672E52657175697265644669656C647301
      0101010D0A466F726D436F6E6669672E556E697175654669656C647301010101
      0D0A717542726F7773652E46696C7465724669656C6473010101010D0A717542
      726F7773652E46696C74657256616C756573010101010D0A7374446C67734361
      7074696F6E730D0A5761726E696E67015761726E696E670101010D0A4572726F
      72014572726F720101010D0A496E666F726D6174696F6E01496E666F726D6174
      696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D0A59657301
      265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A4361
      6E63656C0143616E63656C0101010D0A41626F7274012641626F72740101010D
      0A5265747279012652657472790101010D0A49676E6F7265012649676E6F7265
      0101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F20
      746F20416C6C0101010D0A59657320546F20416C6C0159657320746F2026416C
      6C0101010D0A48656C70012648656C700101010D0A7374537472696E67730D0A
      73744F74686572537472696E67730D0A7175466F726D2E436F6D6D616E645465
      7874010101010D0A7175466F726D2E436F6E6E656374696F6E537472696E6701
      0101010D0A7175466F726D2E46696C746572010101010D0A7175466F726D2E49
      6E6465784669656C644E616D6573010101010D0A7175466F726D2E4B65794669
      656C6473010101010D0A466F726D436F6E6669672E456E7469646164654E6F6D
      65010101010D0A717542726F7773652E436F6D6D616E6454657874010101010D
      0A717542726F7773652E436F6E6E656374696F6E537472696E67010101010D0A
      717542726F7773652E46696C746572010101010D0A717542726F7773652E496E
      6465784669656C644E616D6573010101010D0A717542726F7773652E4B657946
      69656C6473010101010D0A53442E46696C746572014D6963726F736F66742045
      7863656C7C2A2E786C730101010D0A53442E5469746C65010101010D0A73744C
      6F63616C65730D0A43757272656E637920537472696E6701240101010D0A5468
      6F7573616E6420536570617261746F72012C0101010D0A446563696D616C2053
      6570617261746F72012E0101010D0A4461746520536570617261746F72012F01
      01010D0A53686F7274204461746520466F726D6174014D2F642F797979790101
      010D0A4C6F6E67204461746520466F726D617401646464642C204D4D4D4D2064
      642C20797979790101010D0A54696D6520536570617261746F72013A0101010D
      0A54696D6520414D20537472696E6701414D0101010D0A54696D6520504D2053
      7472696E6701504D0101010D0A53686F72742054696D6520466F726D61740168
      3A6D6D20414D504D0101010D0A4C6F6E672054696D6520466F726D617401683A
      6D6D3A737320414D504D0101010D0A53686F7274204D6F6E7468204E616D6573
      014A616E2C4665622C4D61722C4170722C4D61792C4A756E2C4A756C2C417567
      2C5365702C4F63742C4E6F762C4465630101010D0A4C6F6E67204D6F6E746820
      4E616D6573014A616E756172792C46656272756172792C4D617263682C417072
      696C2C4D61792C4A756E652C4A756C792C4175677573742C53657074656D6265
      722C4F63746F6265722C4E6F76656D6265722C446563656D6265720101010D0A
      53686F727420446179204E616D65730153756E2C4D6F6E2C5475652C5765642C
      5468752C4672692C5361740101010D0A4C6F6E6720446179204E616D65730153
      756E6461792C4D6F6E6461792C547565736461792C5765646E65736461792C54
      687572736461792C4672696461792C53617475726461790101010D0A7374436F
      6C6C656374696F6E730D0A737443686172536574730D0A5462727746726D5061
      72656E7442727701414E53495F434841525345540101010D0A6C626C55736572
      4E616D650144454641554C545F434841525345540101010D0A4C6162656C3135
      0144454641554C545F434841525345540101010D0A6C626C4D656E7501414E53
      495F434841525345540101010D0A6274466972737452656301414E53495F4348
      41525345540101010D0A62745072696F7252656301414E53495F434841525345
      540101010D0A62744E65787452656301414E53495F434841525345540101010D
      0A62744C61737452656301414E53495F434841525345540101010D0A6C626C4D
      6F64696669656401414E53495F434841525345540101010D0A4C6162656C3101
      414E53495F434841525345540101010D0A}
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    AfterInsert = quFormAfterInsert
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT '#13#10#9'MT.IDModelTransfDet,'#13#10#9'MT.IDModelTransf,'#13#10#9'MT.IDModel,' +
      #13#10#9'MT.Qty,'#13#10#9'MT.CostPrice,'#13#10#9'MT.SellingPrice,'#13#10#9'MT.Tax,'#13#10#9'MT.IDL' +
      'ote,'#13#10#9'MT.TaxCode'#13#10'FROM '#13#10#9'ModelTransfDet MT (NOLOCK)'#13#10'WHERE '#13#10#9 +
      'MT.IDModelTransfDet = :IDModelTransfDet'#13#10
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'IDModelTransfDet'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    object quFormIDModelTransfDet: TIntegerField
      FieldName = 'IDModelTransfDet'
    end
    object quFormIDModelTransf: TIntegerField
      FieldName = 'IDModelTransf'
    end
    object quFormIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quFormCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormTax: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '0.00'
      Precision = 19
    end
    object quFormQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quFormIDLote: TIntegerField
      FieldName = 'IDLote'
    end
    object quFormTaxCode: TStringField
      FieldName = 'TaxCode'
      Size = 10
    end
  end
  inherited FormConfig: TFormConfig
    ConfirmPost = False
    AutoIncField = 'IDModelTransfDet'
    DependentTables.Strings = (
      'ModelTransfSerial')
    DependentTableKeys.Strings = (
      'IDModelTransfDet')
  end
  inherited quBrowse: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'MTD.IDModelTransfDet,'#13#10#9'MTD.IDModelTransf,'#13#10#9'MT.IDLojaO' +
      'rigem,'#13#10#9'MT.IDLojaDestino'#13#10'FROM'#13#10#9'ModelTransfDet MTD (NOLOCK)'#13#10#9 +
      'JOIN ModelTransf MT (NOLOCK) ON (MT.IDModelTransf = MTD.IDModelT' +
      'ransf)'#13#10'WHERE'#13#10#9'MTD.IDModelTransfDet = :IDModelTransfDet'#13#10
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'IDModelTransfDet'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    object quBrowseIDModelTransfDet: TIntegerField
      FieldName = 'IDModelTransfDet'
    end
    object quBrowseIDModelTransf: TIntegerField
      FieldName = 'IDModelTransf'
    end
    object quBrowseIDLojaOrigem: TIntegerField
      FieldName = 'IDLojaOrigem'
    end
    object quBrowseIDLojaDestino: TIntegerField
      FieldName = 'IDLojaDestino'
    end
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {000000000000000000040000E2020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37965.735701759260000000
      PrinterPage.Footer = 336
      PrinterPage.Header = 20
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 215900
      PrinterPage.PageSize.Y = 279400
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
