inherited FrmModelQuickEntry: TFrmModelQuickEntry
  Left = 197
  Top = 181
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmModelQuickEntry'
  ClientHeight = 523
  ClientWidth = 497
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblCategory: TLabel [0]
    Left = 60
    Top = 128
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Category :'
  end
  object lblDescription: TLabel [1]
    Left = 52
    Top = 105
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Description :'
  end
  object lblManufacturer: TLabel [2]
    Left = 40
    Top = 199
    Width = 72
    Height = 13
    Alignment = taRightJustify
    Caption = 'Manufacturer :'
  end
  object lblGroup: TLabel [3]
    Left = 76
    Top = 175
    Width = 36
    Height = 13
    Alignment = taRightJustify
    Caption = 'Group :'
  end
  object lblSubCategory: TLabel [4]
    Left = 38
    Top = 151
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Category :'
  end
  object lblUnit: TLabel [5]
    Left = 86
    Top = 268
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Unit :'
  end
  object lbCaseQty: TLabel [6]
    Left = 255
    Top = 224
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Case Qty :'
    FocusControl = edtCaseQty
  end
  object lblSize: TLabel [7]
    Left = 86
    Top = 224
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Size :'
  end
  object lblColor: TLabel [8]
    Left = 80
    Top = 246
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'Color :'
  end
  object lblModel: TLabel [9]
    Left = 77
    Top = 82
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Model :'
  end
  object Label2: TLabel [10]
    Left = 397
    Top = 79
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
  object Label1: TLabel [11]
    Left = 397
    Top = 103
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
  object Label4: TLabel [12]
    Left = 397
    Top = 127
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
  object lblModelInformation: TLabel [13]
    Left = 0
    Top = 40
    Width = 497
    Height = 14
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Model Information'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lblBarcode: TLabel [14]
    Left = 66
    Top = 60
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Barcode :'
  end
  object lbCasePrice: TLabel [15]
    Left = 251
    Top = 245
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'Case Cost :'
    Visible = False
  end
  object lbBarcodeCase: TLabel [16]
    Left = 233
    Top = 270
    Width = 73
    Height = 13
    Alignment = taRightJustify
    Caption = 'Barcode Case :'
    Visible = False
  end
  inherited Panel2: TPanel
    Width = 497
    TabOrder = 15
    DesignSize = (
      497
      40)
    inherited Image1: TImage
      Width = 270
    end
    inherited lblMenu: TLabel
      Left = 281
    end
    inherited EspacamentoSuperior: TPanel
      Width = 497
      inherited EEE: TPanel
        Width = 497
      end
    end
  end
  inherited Panel1: TPanel
    Top = 482
    Width = 497
    TabOrder = 14
    object spHelp: TSpeedButton [2]
      Tag = 5
      Left = 287
      Top = 9
      Width = 65
      Height = 17
      Caption = '&Help'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D002000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFF3E1D7F4E3D9F4E3DAF3E2D8F3E1D7FF00FFFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFF4E3D8F8FAFBE4E2E2CFB1A2D4
        AB96DDC6BBECF1F0F6F3F2F2E1D6FF00FFFF00FFFF00FF000000FF00FFFF00FF
        F5EAE2F4FFFFCF9A80B74C15B9643CD9AF9AC05823B95624D5AF9FF7FFFFF4E2
        D9FF00FFFF00FF000000FF00FFF2E1D7F8FFFFC77D58BB450CC64E13C2A495FF
        FFFFD9926FC14A0FB8450BCE9A80F8FFFFF2E0D6FF00FF000000FF00FFFAFAF9
        D8A890BD480DCD622ECD6029CB6B3AD88E68CA5E29CC622DC95D29B94710E0C9
        BDF6EDE8FF00FF000000F3E0D7F8FAFBC56232CA5C26CE6733CB5B23CA8969F7
        E7DFD06B38CA5A23CD6531C3531BC77850F8FCFDDCC8BE000000F3E1D8F2DED6
        C5561ECE6632CC6531CC5A21C28669FFFFFFE8AD91C44A0FCC622DCB5F28C35E
        2BF3F2F1F1DFD5000000F2E1D9F3D8CACD5B22CF6632CC642FCC602BC4551FCF
        B5A8FFFFFFE09C7AC7531ACD602BC65E29F5F1EDEFDED4000000F1E0D7FBEDE6
        DB6A32D36833CA5E28C95821C95419C14B10E2D0C6FFFFFFD0703FCD5A20CE6A
        38FCFBFBEEDDD2000000F1DED4FFFFFFF5986AE2662AC88B6DF0EAE3D77E51BD
        3000D79C7EFFFFFFDA8C65D15314E29A76FEFDFED3BDB2000000FF00FFF6F1EF
        FFEADBFF8A49DE875CEEFFFFFEFCFDE7B9A1FAFFFFF3F9FEE0723CE67035FFF3
        EEF4E7E0FF00FF000000FF00FFF1DED4FFFFFFFFE9CEFFB270ECAF87ECE2DFEB
        F0F4F1E4E0F6A478FE8C4DFFDECAFDFFFFF0DDD2FF00FF000000FF00FFFF00FF
        F0DFD6FFFFFFFFFFFBFFF3C6FEDDA8FCCF98FFC991FFD4A9FFFEF8FCFFFFF1DF
        D4FF00FFFF00FF000000FF00FFFF00FFFF00FFF1DCD3F5E8E4FDFCFDFFFFFFFF
        FFFFFFFFFFFCFBFDF3E6E0F1DDD2FF00FFFF00FFFF00FF000000FF00FFFF00FF
        FF00FFFF00FFFF00FFF1DCD1EFDBD0EFDBD1EFDCD1F1DBD0FF00FFFF00FFFF00
        FFFF00FFFF00FF000000}
      Margin = 5
      ParentFont = False
      Visible = False
      OnClick = spHelpClick
    end
    object btnVideo: TSpeedButton [3]
      Tag = 5
      Left = 287
      Top = 25
      Width = 65
      Height = 16
      Caption = '&Video'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        D6020000424DD60200000000000036000000280000000F0000000E0000000100
        180000000000A002000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FF84474091251A961E1607A5CA07A5CA19839C556A6EFF00FFFF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFA4331AB23011BA4327BA4F362B
        C7EC2BC7EC17C0E801AFD9226E80FF00FFFF00FFFF00FF000000FF00FFFF00FF
        B43B12C24D1DC8622FCE6A36D17A5143CCED43CCED4AC7E53AC4E402BBE82072
        84FF00FFFF00FF000000FF00FFB85328CB5B1BD0661DDE8F56F6DDCAFEF9F6F9
        FEFFD2F2FA73D6ED47C8E53BC3E301AFDA567179FF00FF000000FF00FFCE5C16
        DA741EE99C54F0EFEA888E93BEC0C1FBF9F9FFFFFFFFFFFF78D8EE48C7E51BC0
        E8138BA7FF00FF000000D0804AE17618EF8D21F4DEC1E9F1F81E1D1D131313A7
        A7A7CFCFCFFFFDFCE3F7FC4ACBEA37C5E707A8D0FF00FF000000CF7F46DE832B
        E9A448EAE7E0E9F1F84847481B1B1B0404041C1C1CCFCFCFE3E0E068D5ED38C0
        DE06A8CDFF00FF0000005373F01B4AFF4D73FFDADCE1E9F1F84847484E4E4E21
        2121080808646464EAE8E855B499288A72065A49FF00FF0000005373F01B4AFF
        4D73FFC5CBE1E9F1F84847486B6B6B797979C7C7C7FFFEFFE1EEE92CA1771C81
        5F0A533AFF00FF000000FF00FF1B48F84C71FF9EAFF5E9F1F86B6B6BC6C6C4EB
        E9E9F4EBEEF7EAEF67C4A0149B6D05734F2A6150FF00FF000000FF00FF3E63F4
        2E59FE5376FFA1B1F1C7CBDBD9D8D8D9D8D7C3DCD35FCEA301A96D068D610167
        45FF00FFFF00FF000000FF00FFFF00FF244EF7315AFE5376FF5D7DFF597AF530
        D1A80DD58401B773019C66017A4E578375FF00FFFF00FF000000FF00FFFF00FF
        FF00FF385EF51B47F9234DFC224EF901B99101BE7101A065098A5C689685FF00
        FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FF8EA2F25876EB3258EC1A
        A58B29AE785AA98CFF00FFFF00FFFF00FFFF00FFFF00FF000000}
      Margin = 5
      ParentFont = False
      Visible = False
      OnClick = btnVideoClick
    end
    inherited EspacamentoInferior: TPanel
      Width = 497
      TabOrder = 2
      inherited Panel3: TPanel
        Width = 497
      end
    end
    inherited hhh: TPanel
      Left = 415
      inherited btClose: TButton
        Cancel = True
        ModalResult = 2
      end
    end
    object btAdd: TButton
      Left = 355
      Top = 9
      Width = 66
      Height = 31
      Caption = '&Add'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = btAddClick
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 54
    Height = 330
    TabOrder = 16
  end
  inherited EspacamentoDireito: TPanel
    Left = 494
    Top = 54
    Height = 330
    TabOrder = 17
  end
  object edtDescription: TDBEdit [21]
    Tag = 99
    Left = 116
    Top = 101
    Width = 277
    Height = 21
    DataField = 'Description'
    DataSource = dtsModel
    TabOrder = 2
  end
  object edtCaseQty: TDBEdit [22]
    Left = 311
    Top = 220
    Width = 83
    Height = 21
    DataField = 'CaseQty'
    DataSource = dtsModel
    TabOrder = 10
    OnExit = edtCaseQtyExit
    OnKeyPress = edtCaseQtyKeyPress
  end
  object edtModel: TDBEdit [23]
    Tag = 99
    Left = 116
    Top = 78
    Width = 277
    Height = 21
    DataField = 'Model'
    DataSource = dtsModel
    TabOrder = 1
    OnExit = edtModelExit
  end
  object edtBarcode: TDBEdit [24]
    Left = 116
    Top = 56
    Width = 113
    Height = 21
    Color = 8454143
    DataField = 'IDBarcode'
    DataSource = dtsModel
    TabOrder = 0
    OnExit = edtBarcodeExit
    OnKeyDown = edtBarcodeKeyDown
  end
  object scManufacturer: TDBSuperComboADO [25]
    Tag = 99
    Left = 116
    Top = 195
    Width = 277
    Height = 21
    TabOrder = 6
    Text = 'scManufacturer'
    FilterSugest = True
    LookUpSource = DM.dsLookUpFabricante
    DropDownRows = 18
    IDLanguage = 0
    DataField = 'IDManufacturer'
    DataSource = dtsModel
  end
  object scCategory: TDBSuperComboADO [26]
    Tag = 99
    Left = 116
    Top = 124
    Width = 277
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'scCategory'
    LookUpSource = DM.dsLookUpGroup
    DropDownRows = 18
    EditCodePos = taEditCodeRight
    IDLanguage = 0
    OnSelectItem = scCategorySelectItem
    DataField = 'IDGroup'
    DataSource = dtsModel
  end
  object scGroup: TDBSuperComboADO [27]
    Tag = 99
    Left = 116
    Top = 171
    Width = 277
    Height = 21
    TabOrder = 5
    Text = 'scGroup'
    FilterSugest = True
    LookUpSource = DM.dsLookUpModelSubGroup
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
    DataField = 'IDModelSubGroup'
    DataSource = dtsModel
  end
  object scSubCategory: TDBSuperComboADO [28]
    Tag = 99
    Left = 116
    Top = 147
    Width = 277
    Height = 21
    TabOrder = 4
    Text = 'scSubCategory'
    FilterSugest = True
    LookUpSource = DM.dsLookUpModelGroup
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
    DataField = 'IDModelGroup'
    DataSource = dtsModel
  end
  object scUnit: TDBSuperComboADO [29]
    Left = 116
    Top = 264
    Width = 105
    Height = 21
    TabOrder = 9
    Text = 'scUnit'
    LookUpSource = DM.dsLookUpUnidade
    DropDownRows = 10
    MostraDesativado = STD_AMBOSDESATIVADO
    MostraHidden = STD_AMBOSHIDDEN
    IDLanguage = 0
    DataField = 'IDUnit'
    DataSource = dtsModel
  end
  object scColor: TDBSuperComboADO [30]
    Left = 116
    Top = 242
    Width = 105
    Height = 21
    TabOrder = 8
    Text = 'scColor'
    LookUpSource = DM.dsLookUpColor
    DropDownRows = 18
    IDLanguage = 0
    DataField = 'IDColor'
    DataSource = dtsModel
  end
  object scSize: TDBSuperComboADO [31]
    Left = 116
    Top = 220
    Width = 105
    Height = 21
    TabOrder = 7
    Text = 'scSize'
    LookUpSource = DM.dsLookUpSize
    DropDownRows = 18
    IDLanguage = 0
    DataField = 'IDSize'
    DataSource = dtsModel
  end
  object edtCasePrice: TEdit [32]
    Left = 311
    Top = 242
    Width = 83
    Height = 21
    TabOrder = 11
    Text = '0'
    Visible = False
    OnExit = edtCasePriceExit
    OnKeyPress = edtCasePriceKeyPress
  end
  object pnlDetail: TPanel [33]
    Left = 0
    Top = 289
    Width = 496
    Height = 93
    BevelOuter = bvNone
    TabOrder = 13
    object lblMinQty: TLabel
      Left = 306
      Top = 49
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'Min qty :'
    end
    object lblMaxQty: TLabel
      Left = 302
      Top = 76
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Max qty :'
    end
    object lblUnitCost: TLabel
      Left = 61
      Top = 25
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Unit Cost :'
    end
    object lblPricing: TLabel
      Left = 0
      Top = 1
      Width = 245
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Pricing'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblOurPrice: TLabel
      Left = 61
      Top = 72
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Our Price :'
    end
    object lblMSRP: TLabel
      Left = 78
      Top = 49
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'MSRP :'
    end
    object lblEstoque: TLabel
      Left = 248
      Top = 1
      Width = 248
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Inventory'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblQtyOnHand: TLabel
      Left = 281
      Top = 25
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'Qty on hand :'
    end
    object Label3: TLabel
      Left = 204
      Top = 69
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
    object edtMinQty: TDBEdit
      Left = 352
      Top = 45
      Width = 70
      Height = 21
      DataField = 'MinQty'
      DataSource = dtsModel
      TabOrder = 4
      OnKeyPress = edtCaseQtyKeyPress
    end
    object edtMaxQty: TDBEdit
      Left = 352
      Top = 68
      Width = 70
      Height = 21
      DataField = 'MaxQty'
      DataSource = dtsModel
      TabOrder = 5
      OnKeyPress = edtCaseQtyKeyPress
    end
    object edtUnitCost: TDBEdit
      Left = 116
      Top = 21
      Width = 85
      Height = 21
      DataField = 'VendorCost'
      DataSource = dtsModel
      TabOrder = 0
      OnExit = edtUnitCostExit
      OnKeyPress = edtUnitCostKeyPress
    end
    object edtOurPrice: TDBEdit
      Left = 116
      Top = 68
      Width = 85
      Height = 21
      DataField = 'SellingPrice'
      DataSource = dtsModel
      TabOrder = 2
      OnExit = edtOurPriceExit
      OnKeyPress = edtUnitCostKeyPress
    end
    object edtMSRP: TDBEdit
      Left = 116
      Top = 45
      Width = 85
      Height = 21
      DataField = 'SuggRetail'
      DataSource = dtsModel
      TabOrder = 1
      OnExit = edtMSRPExit
      OnKeyPress = edtUnitCostKeyPress
    end
    object edtQtyOnHand: TDBEdit
      Left = 352
      Top = 21
      Width = 70
      Height = 21
      DataField = 'QtyOnHand'
      DataSource = dtsModel
      TabOrder = 3
      OnKeyPress = edtCaseQtyKeyPress
    end
  end
  object pnlVendor: TPanel [34]
    Left = 0
    Top = 384
    Width = 497
    Height = 98
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 18
    object lblVendorInfo: TLabel
      Left = 0
      Top = 0
      Width = 497
      Height = 14
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Vendor'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblVendorPart: TLabel
      Left = 45
      Top = 24
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vendor code :'
    end
    object lbMinQtyPO: TLabel
      Left = 50
      Top = 50
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Min Qty PO :'
    end
    object lblVendor: TLabel
      Left = 42
      Top = 74
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = 'Prime Vendor :'
    end
    object lbQtyType: TLabel
      Left = 236
      Top = 51
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Case Qty :'
    end
    object btnVendorSuggestion: TSpeedButton
      Left = 376
      Top = 36
      Width = 109
      Height = 31
      Caption = 'Other Vendors'
      Glyph.Data = {
        06080000424D060800000000000036000000280000001A000000190000000100
        180000000000D0070000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFAE8584A27C7C98787998817FA99C9CFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        E4B3A6E7B6A3DCAF9DCEA292A27F7EFF00FFFF00FFBD9D9DAF9291A68F90A494
        95AAA4A3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFD5B1B1F1C2ABFCD3AAFDD3AAF4C8A7B08B85FF
        00FFFF00FFD3A79CE0B3A7D5A79FC59993B58A87AA83839A7D7F958786FF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFD6AEAD
        F3C5AFFDD5AFFDD5ADF6D0ACC39E8C94817EB59790F1CCB0FCDCBDFADABFF8D8
        C0F3D1BFECC9B9DCB4A9A48580FF00FFFF00FFB68F88A786819C84819B8A86A5
        9898FF00FFFF00FF0000FF00FFD6AEADF4C6B1FDD6B1FCD9B3FDD8B4EDCAA9C4
        A28FD8B4A1FDDFBEFCE1C2FEE2C4FFE6C8FEE6CBFDE6CDEED4C1A2877FFF00FF
        D4B8B0EAC6BBEAC9BFE0BDB5D5AEA8B38F8BB7A7A7FF00FF0000FF00FFD6AFAD
        F4C6B5F8D9B7E6D0A8D9CA9FCFC799D2C79FDDCDAAF4DFBEFCE2C9FDE4CCFEE6
        CDFFE8D0FEEAD3F7E0CCB79B8F988480D5B4AAFBE9DAFDEEE2FBECE1F7E5DCCF
        B3ACBAA9A7FF00FF0000FF00FFD8B1AEF2C8B200008000008000008000008000
        0080000080000080000080D2D2ADFAE9D0FDEAD9FEEBDAFDEDDAEFDBCADEC3BB
        F5E1D6FCF2E4FDF4EAFEF5ECFDF1E9D2BCB5B7ABA8FF00FF0000FF00FFDBB4B0
        EDC8B20000800000800000FF0000FF0000FF8080FF0000FF000080000080DADB
        BCF9EEDEFDEFDEFEF0E1FEF0E4FEF2E7FDF3E9FBF6ECFBF5F0FDF7F0FDF4EED4
        BEBBB7ABA8FF00FF0000FF00FFDBB4B1F2CCBB0000800000800000FF0000FF80
        80FF8080FF0000FF0000FF000080CED8B4FAECE1FCECDBFDF2E2FEF4E8FEF6EB
        FCF7EEFCF8F1FDF9F6FEFAF7FCF8F6D4C2BEB8ACA8FF00FF0000FF00FFDBB5B4
        F5D0C4E5D8B80000800000800000FF8080FF8080FF0000FF0000FF000080E3E3
        CFF8E5D3FAD4BCFCD5BEFED8C4FFDFCEFEE8DAFDEEE5FDF4EDFEFBF9FCFBFAD5
        C5BFBAAEA9FF00FF0000FF00FFDBB5B4F5D1C7FDE9D5CED6B2000080247D9834
        89C4418DB7000080000080C7D8B8FAF1EAFDF2E4FCE9DCFAE3D7FDE1D2FFD9C7
        FDD3BEFACBB3FACEB6FBF0E6F9FBFAD8C5C0BBAFAAFF00FF0000FF00FFDEBBB4
        F5D5C7FEEBD9CFD5D44492D22F94F43498FA2F95F74E99D5D6DFE1FFF7EEFBF7
        F1FCF4EFFCF2ECFEF5F1FDF9F5FCFDFBFDFEFBFBFDFBFCFAF7FEFCFCFDFBFAD8
        C6BEBAAEAAFF00FF0000FF00FFE1BBB4F6D6CBFEEFDE93B9D23497EB3BA3FD42
        A6FD3CA3FD449EE8ABC8DBFEFAF2FCFBF8FBE7E0FCD6C3FDD9C7FEDFCEFEE3D4
        FBE5D9FAE8DEFBEEE6FDFAF7FBFBFAD8C7C0BBB0ABFF00FF0000FF00FFE4BBB5
        F8D7D0FFEFE5589FCE44A8FA4BB0FD50B4FD4DB1FE48A9F299C3DFFEFEF9FCFF
        FCFDF6F6FBEEE8FCEBE0FCE5D9FEE0D2FDDCCEFBDACBFBDDCEFCF4EEF9FBFADA
        C7C1BCB0ABFF00FF0000FF00FFE4BDBAF8D9D3FFF3E74998CE4DAEFA50B6FB4D
        B3F64AAEF251AEED9AC9E1FDFEFEFCFFFEFCF4F4FBEFEAFBF5F0FBFAF6FDFCFA
        FEFBF8FCF8F6FBF7F4FEFAFBFCFAFADAC7C2BDB0ADFF00FF0000FF00FFE7BEB9
        F8DAD5FCF6ED6B9FC63A8BCA4C9ED455A7DC4DA3D94C95C8B9D7E6FAFFFFFCFF
        FFF9E9E3FAD0C0FED0BAFED0B9FCD0BDFDD6C4FADCCCFBE2D6FCF6F2FDFBFADB
        CAC1BFB1ABFF00FF0000FF00FFE8BEB9F8DBD9FBF8F4B4CEDE5C9EC987BADF89
        BFE266AAD87AB0CDE9F1F6FDFFFEFCFFFFFBFDFCFBF9F6FDF6F1FEF2EDFEEEE6
        FEEADEFDE4D5FBDED0FAF3EDFCFBFADCCAC3C1B1ACFF00FF0000FF00FFE9BFBB
        F8DDDCFDF9FBEFF7F9B3D3E496C3DB9DC8DF9DC7DCDCEAF0F9FEFCFCFFFEFEFF
        FFFEFEFFFEFDFEFEFFFCFCFFFDFDFFFEFEFEFEFEFCFEFDFDFCFCFEFDFDFBFBDE
        CAC5C3B0ADFF00FF0000FF00FFEAC0BDF9DFDDFEFCFAFBFEFEF4FBFAEAF4F7E8
        F3F7F0F5F8FDFDFEFCFFFEFBFFFEFEFDFFFFFFFFFFFFFEFEFFFBFEFFFBFEFFFD
        FEFFFFFEFFFFFCFFFEFDFFFEFCFBF9DECBC4C3B0B0FF00FF0000FF00FFECC3BB
        F8E0DDFBFCFCFDFFFEFDFFFDFEFFFEFEFFFFFEFEFFFEFEFFFCFFFFFBF7F5F1DB
        D7F4E3D9F8EBE5FBEFEDFCF4F1FDF6F3FDF7F4FDF8F6FCFAF8FDFBF9FDFAF6E1
        CDC3C6B6B3FF00FF0000FF00FFEDC3BFFCDFE0FFFCFDFFFFFFFFFFFFFEFFFFFD
        FFFFFEFFFEFEFFFFFBFFFFFAF0EBBA9D92E5D2CAF8E0D8F8DED4F6DDD0F6DCCE
        F4DACDF8DCCEF9DCD0F8DFD2F9E1D3EBD5C9E1D9D7FF00FF0000FF00FFECC5BD
        F7D7D3FCF1F0FBF5F3FDF8F5FCFAF8FBFCFCFDFEFCFCFFFFFCFFFFFBF0ECB29A
        94FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFEFD4CDF2DCD4F1DAD1F5DAD3F6DAD3F7
        DBD3F7DDD4F6DDD4FBE1D7F8DACDCFB8B0FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0000}
      Margin = 1
      Visible = False
      OnClick = btnVendorSuggestionClick
    end
    object edtVendorPart: TDBEdit
      Left = 116
      Top = 20
      Width = 73
      Height = 21
      DataField = 'VendorCode'
      DataSource = dtsModel
      TabOrder = 0
    end
    object edMinQtyPO: TDBEdit
      Left = 116
      Top = 46
      Width = 73
      Height = 21
      DataField = 'VendorMinQtyPO'
      DataSource = dtsModel
      TabOrder = 1
    end
    object scVendor: TDBSuperComboADO
      Tag = 99
      Left = 116
      Top = 70
      Width = 250
      Height = 21
      TabOrder = 2
      Text = 'scVendor'
      FilterSugest = True
      LookUpSource = DM.dsLookUpFornecedor
      DropDownRows = 18
      ShowEditCode = True
      IDLanguage = 0
      DataField = 'IDVendor'
      DataSource = dtsModel
    end
    object edCaseQtyPO: TDBEdit
      Left = 297
      Top = 46
      Width = 69
      Height = 21
      DataField = 'VendorCaseQty'
      DataSource = dtsModel
      TabOrder = 3
    end
  end
  object edtBarcodeCase: TDBEdit [35]
    Left = 310
    Top = 265
    Width = 85
    Height = 21
    Color = 13303807
    DataField = 'BarcodeCase'
    DataSource = dtsModel
    TabOrder = 12
    Visible = False
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelQuickEntry.sil'
    Left = 12
    Top = 8
  end
  object dtsModel: TDataSource
    DataSet = cdsModel
    Left = 408
    Top = 436
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 388
    object cdsModelIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsModelIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object cdsModelIDManufacturer: TIntegerField
      FieldName = 'IDManufacturer'
    end
    object cdsModelIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object cdsModelIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object cdsModelIDSize: TIntegerField
      FieldName = 'IDSize'
    end
    object cdsModelIDColor: TIntegerField
      FieldName = 'IDColor'
    end
    object cdsModelCaseQty: TFloatField
      FieldName = 'CaseQty'
      OnChange = cdsModelCaseQtyChange
    end
    object cdsModelIDUnit: TIntegerField
      FieldName = 'IDUnit'
    end
    object cdsModelVendorCost: TFloatField
      FieldName = 'VendorCost'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelSuggRetail: TFloatField
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelSellingPrice: TFloatField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelIDBarcode: TStringField
      FieldName = 'IDBarcode'
    end
    object cdsModelIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsModelIDVendorModelCode: TIntegerField
      FieldName = 'IDVendorModelCode'
    end
    object cdsModelVendorCode: TStringField
      FieldName = 'VendorCode'
    end
    object cdsModelIDInventory: TIntegerField
      FieldName = 'IDInventory'
    end
    object cdsModelIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsModelQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
    end
    object cdsModelMaxQty: TFloatField
      FieldName = 'MaxQty'
    end
    object cdsModelMinQty: TFloatField
      FieldName = 'MinQty'
    end
    object cdsModelModelType: TStringField
      FieldName = 'ModelType'
      Size = 1
    end
    object cdsModelVerify: TBooleanField
      FieldName = 'Verify'
    end
    object cdsModelVendorMinQtyPO: TFloatField
      FieldName = 'VendorMinQtyPO'
    end
    object cdsModelVendorCaseQty: TFloatField
      FieldName = 'VendorCaseQty'
    end
    object cdsModelBarcodeCase: TStringField
      FieldName = 'BarcodeCase'
    end
  end
  object spAdjustInventory: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_Adjust;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDMovType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDStore'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Qty'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@IDUser'
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
        Name = '@Notes'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@IDMovReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 410
    Top = 280
  end
  object cdsVendorSuggestion: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 332
    object cdsVendorSuggestionIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsVendorSuggestionVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsVendorSuggestionVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 15
    end
    object cdsVendorSuggestionMinQtyPO: TFloatField
      FieldName = 'MinQtyPO'
    end
    object cdsVendorSuggestionCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object cdsVendorSuggestionVendorCost: TCurrencyField
      FieldName = 'VendorCost'
      DisplayFormat = '#,##0.00'
    end
  end
end
