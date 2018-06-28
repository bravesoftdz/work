inherited FchRepair: TFchRepair
  Left = 171
  Top = 161
  Caption = 'System User'#39's'
  ClientHeight = 476
  ClientWidth = 556
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 556
    inherited Image1: TImage
      Width = 282
    end
    inherited lblMenu: TLabel
      Left = 467
    end
    inherited EspacamentoSuperior: TPanel
      Width = 556
      inherited EEE: TPanel
        Width = 556
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 509
    end
  end
  inherited Panel1: TPanel
    Top = 435
    Width = 556
    inherited lblUserName: TLabel
      Width = 173
    end
    inherited EspacamentoInferior: TPanel
      Width = 556
      Height = 2
      inherited Panel3: TPanel
        Top = 0
        Width = 556
      end
    end
    inherited hhh: TPanel
      Left = 335
      Top = 2
      Height = 39
    end
    inherited pnlNavigation: TPanel
      Top = 2
      Height = 39
    end
  end
  inherited pnlKey: TPanel
    Width = 556
    Height = 3
    inherited Panel4: TPanel
      Top = 1
      Width = 556
    end
  end
  inherited pnlDetail: TPanel
    Top = 43
    Width = 550
    Height = 392
    object Label2: TLabel
      Left = 1168
      Top = -15
      Width = 33
      Height = 16
      Caption = 'Name'
    end
    object lbStatus: TLabel
      Left = 0
      Top = 194
      Width = 550
      Height = 18
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Status'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object PPageControl: TPageControl
      Left = 0
      Top = 212
      Width = 550
      Height = 173
      ActivePage = tsSentVendor
      Align = alTop
      TabOrder = 1
      object tsReceiveCustomer: TTabSheet
        Caption = 'Received from Customer'
        object Label8: TLabel
          Left = 38
          Top = 66
          Width = 32
          Height = 16
          Alignment = taRightJustify
          Caption = 'Notes'
        end
        object Label18: TLabel
          Left = 1
          Top = 40
          Width = 73
          Height = 16
          Alignment = taRightJustify
          Caption = 'Received by:'
        end
        object Label12: TLabel
          Left = 10
          Top = 12
          Width = 64
          Height = 16
          Alignment = taRightJustify
          Caption = 'Customer :'
        end
        object Label6: TLabel
          Left = 395
          Top = 7
          Width = 14
          Height = 23
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
        object Label22: TLabel
          Left = 254
          Top = 40
          Width = 16
          Height = 16
          Alignment = taRightJustify
          Caption = 'On'
        end
        object Label23: TLabel
          Left = 396
          Top = 37
          Width = 14
          Height = 23
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
        object btPrint: TSpeedButton
          Left = 399
          Top = 110
          Width = 125
          Height = 29
          Caption = '&Receipt'
          Flat = True
          Glyph.Data = {
            A2070000424DA207000000000000360000002800000019000000190000000100
            1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C69C96949C9694FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECBCEBDBA
            BDDEDBDEDEDFDEADAEADB5B2B59C9694BD8E84A58E84ADAEADFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFBDBABDCECFCEEFEFEFEFEFEFDEDBDEADAEADB5B2B58C8E8C4A4D4A63
            61636361638C8A8C9C9694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFFFFBDBEBDC6C3C6EFEBEFF7F3F7EFEFEFEFEBEFD6D3D6AD
            AAADADAEAD8C8E8C4A4D4A4241426361636361638486848C8E8CADAEADC6C7C6
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDBABDDEDFDEFFFBFFFFF7F7EF
            EFEFEFEBEFE7E3E7D6D3D6ADAAADADAAADADAEADADAEADADAAAD8C8A8C737173
            6361638486848C8E8CB5B2B59C9E9CFFFFFFFFFFFF00FFFFFFFFFFFFBDBABDFF
            FFFFFFFBFFFFF7F7EFEFEFEFEBEFDEDBDEB5B2B58C8E8C8482848C8E8CADAAAD
            ADAEADADAEADB5B2B5BDBABDADAEAD9C9E9C636163525152CECBCEFFFFFFFFFF
            FF00FFFFFFFFFFFFADAEADFFFBFFFFF7F7EFEFEFDEDBDE9C9E9C9C9E9CBDBABD
            C6C7C69C9E9C8C8E8C8482848482848C8E8C9C9E9CB5B2B5BDBABDBDBEBDC6C3
            C6BDBABDC6C7C6FFFFFFFFFFFF00FFFFFFFFFFFFADAAADF7F3F7CECFCE9C9694
            9C9E9CD6D3D6DEDBDED6D3D6D6D3D6CECBCEBDBEBDADAAADADAAAD9C9E9C8C8E
            8C8486848C8A8C9C9E9CBDBABD8CBE8C8CBE8CFFFFFFFFFFFF00FFFFFFFFFFFF
            9C9E9C8C8A8C9C9694DEDBDEDEDFDEDEDBDED6D3D6CECBCEEFEBEFE7E7E7E7E7
            E7EFEBEFDEDBDECECBCEBDBABDADAEADADAEAD9C96948486848482849C9694FF
            FFFFFFFFFF00FFFFFFFFFFFF8C8E8CEFEBEFE7E3E7DEDFDEDEDBDED6D3D6CECF
            CEE7E3E7DEDBDEB5B2B5BDBABDBDBABDBDBEBDCECFCEE7E7E7E7E7E7D6D3D6C6
            C7C6BDBEBDBDBABDADAAADFFFFFFFFFFFF00FFFFFFFFFFFF8C8A8CE7E3E7DEDF
            DEDEDBDED6D3D6CECFCEDEDBDEE7E7E7C6C3C6EFEFEFEFEFEFEFEBEFCECFCEBD
            BEBDBDBABDBDBABDBDBEBDD6D3D6E7E3E7DEDFDED6D3D6FFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFD6D3D6DEDBDED6D3D6CECFCEDEDFDECECFCEC6C3C6F7F3F7F7
            F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEFDEDBDEC6C7C6BDBABDBDBABDBDBABD
            CECBCEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADAEADBDBEBDC6
            C3C6D6D3D6C6C7C6CECBCEE7E7E7F7F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEF
            E7E7E7E7E7E7D6D3D6ADAEADFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFADAAADE7E7E7E7E7E7ADAEADB5B2B5BDBABDBDBABDC6C3C6
            CECBCEDEDBDEE7E7E7E7E7E7EFEBEFCECBCEB5B2B5FFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAAADFFFBF7FFF3E7EFDBCE
            D6D3D6C6C7C6C6C7C6BDBABDC6C3C6BDBEBDBDAAA5BDAAA5B5B2B5DEDBDEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFCE9A84FFD7ADFFD7ADFFD7ADFFDFBDFFDFBDFFEBD6F7E3D6EFE7DECEAA
            ADDEDBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6AA94FFDFBDFFD7ADFFDFBDFFD7ADFFDF
            BDFFD7ADFFDFBDF7D3A5BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3B5FFDF
            BDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDD6B2ADBD9A94FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFDEC7B5FFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEBD
            9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9A94FFEBD6FFEBD6FFEBD6FFEBD6FF
            EBD6FFEBD6FFEBD6EFDBCEBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECBC6FF
            F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7D6B2ADBD9A94FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFD6BEBDFFF7EFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFF7EF
            BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED7D6FFFFFFFFFBFFFFFFFFFFFFFF
            FFFBFFFFFFFFFFFFFFEFEBEFBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFCEBEB5BD9A94
            BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00}
          Margin = 5
          OnClick = btPrintClick
        end
        object sbSendToVendor: TSpeedButton
          Left = 400
          Top = 82
          Width = 124
          Height = 25
          Caption = 'Sent To Vendor'
          Flat = True
          Glyph.Data = {
            EE000000424DEE000000000000007600000028000000090000000F0000000100
            04000000000078000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666000
            000066666666600000006006666660000000603066666000000060B306666000
            000060BB30666000000060BBB3066000000060BBBB306000000060BBB3066000
            000060BB30666000000060B30666600000006030666660000000600666666000
            000066666666600000006666666660000000}
          Margin = 5
          OnClick = sbSendToVendorClick
        end
        object Label36: TLabel
          Left = 234
          Top = 38
          Width = 14
          Height = 23
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
        object scUser: TDBSuperComboADO
          Left = 77
          Top = 36
          Width = 153
          Height = 24
          TabOrder = 1
          Text = 'scUser'
          CodeLength = 5
          LookUpSource = DM.dsLookUpUser
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDUserReceive'
          DataSource = dsForm
        end
        object dbCustomer: TDBSuperComboADO
          Left = 76
          Top = 8
          Width = 317
          Height = 24
          TabOrder = 0
          Text = 'dbCustomer'
          CodeLength = 60
          FilterSugest = True
          LookUpSource = DM.dsLookUpCustomer
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDCliente'
          DataSource = dsForm
        end
        object DBDateBox1: TDBDateBox
          Left = 276
          Top = 36
          Width = 118
          Height = 24
          ReadOnly = False
          TabOrder = 2
          Text = 'DBDateBox1'
          InputTime = False
          Language = Portuguese
          DataField = 'ReceiveDate'
          DataSource = dsForm
        end
        object DbMemoStr3: TDbMemoStr
          Left = 76
          Top = 68
          Width = 318
          Height = 67
          DataField = 'OBSReceive'
          DataSource = dsForm
          ScrollBars = ssVertical
          TabOrder = 3
        end
      end
      object tsSentVendor: TTabSheet
        Caption = 'Sent to Vendor'
        object Label21: TLabel
          Left = 223
          Top = 75
          Width = 86
          Height = 16
          Alignment = taRightJustify
          Caption = 'LastPurchDate:'
          FocusControl = DBEdit2
        end
        object Label20: TLabel
          Left = 249
          Top = 103
          Width = 61
          Height = 16
          Alignment = taRightJustify
          Caption = 'Last Cost :'
          FocusControl = DBEdit1
        end
        object Label10: TLabel
          Left = 22
          Top = 11
          Width = 50
          Height = 16
          Alignment = taRightJustify
          Caption = 'Vendor :'
        end
        object Label24: TLabel
          Left = 42
          Top = 75
          Width = 29
          Height = 16
          Alignment = taRightJustify
          Caption = 'RA #'
        end
        object Label25: TLabel
          Left = 22
          Top = 103
          Width = 49
          Height = 16
          Alignment = taRightJustify
          Caption = 'Carrier :'
        end
        object Label4: TLabel
          Left = 24
          Top = 44
          Width = 48
          Height = 16
          Alignment = taRightJustify
          Caption = 'Sent by:'
        end
        object Label9: TLabel
          Left = 290
          Top = 44
          Width = 16
          Height = 16
          Alignment = taRightJustify
          Caption = 'On'
        end
        object Label11: TLabel
          Left = 427
          Top = 43
          Width = 14
          Height = 23
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
        object lblSend: TLabel
          Left = 275
          Top = 127
          Width = 241
          Height = 13
          Caption = 'The item has been debited from inventory.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label16: TLabel
          Left = 203
          Top = 41
          Width = 14
          Height = 23
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
        object Label31: TLabel
          Left = 203
          Top = 73
          Width = 14
          Height = 23
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
        object Label34: TLabel
          Left = 388
          Top = 10
          Width = 14
          Height = 23
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
        object btnBackVendor: TSpeedButton
          Left = 407
          Top = 7
          Width = 128
          Height = 25
          Caption = 'Back from Vendor'
          Flat = True
          Glyph.Data = {
            EE000000424DEE000000000000007600000028000000090000000F0000000100
            04000000000078000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666000
            00006666666660000000600666666000000060A0666660000000602A06666000
            00006022A0666000000060222A0660000000602222A06000000060222A066000
            00006022A06660000000602A06666000000060A0666660000000600666666000
            000066666666600000006666666660000000}
          Margin = 5
          OnClick = btnBackVendorClick
        end
        object DBEdit2: TDBEdit
          Left = 313
          Top = 70
          Width = 113
          Height = 24
          DataField = 'DateLastCost'
          DataSource = dsForm
          TabOrder = 5
        end
        object DBEdit1: TDBEdit
          Left = 313
          Top = 98
          Width = 113
          Height = 24
          DataField = 'LastCost'
          DataSource = dsForm
          TabOrder = 6
        end
        object cmbVendor: TDBSuperComboADO
          Left = 76
          Top = 8
          Width = 310
          Height = 24
          TabOrder = 0
          Text = 'cmbVendor'
          CodeLength = 60
          FilterSugest = True
          LookUpSource = DM.dsLookUpFornecedor
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDFornecedor'
          DataSource = dsForm
        end
        object dbedtRA: TDBEdit
          Left = 76
          Top = 71
          Width = 127
          Height = 24
          DataField = 'RA'
          DataSource = dsForm
          TabOrder = 2
        end
        object DBEdit4: TDBEdit
          Left = 76
          Top = 99
          Width = 127
          Height = 24
          DataField = 'UPS'
          DataSource = dsForm
          TabOrder = 3
        end
        object cmbSentBy: TDBSuperComboADO
          Left = 77
          Top = 40
          Width = 126
          Height = 24
          TabOrder = 1
          Text = 'cmbSentBy'
          CodeLength = 5
          LookUpSource = DM.dsLookUpUser
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDUserSent'
          DataSource = dsForm
        end
        object dbdtOn: TDBDateBox
          Left = 312
          Top = 40
          Width = 113
          Height = 24
          ReadOnly = False
          TabOrder = 4
          Text = 'dbdtOn'
          InputTime = False
          Language = Portuguese
          DataField = 'SentDate'
          DataSource = dsForm
        end
      end
      object tsReturnVendor: TTabSheet
        Caption = 'Back from Vendor'
        object Label13: TLabel
          Left = 36
          Top = 74
          Width = 32
          Height = 16
          Alignment = taRightJustify
          Caption = 'Notes'
        end
        object Label26: TLabel
          Left = 0
          Top = 12
          Width = 73
          Height = 16
          Alignment = taRightJustify
          Caption = 'Received by:'
        end
        object Label27: TLabel
          Left = 254
          Top = 12
          Width = 16
          Height = 16
          Alignment = taRightJustify
          Caption = 'On'
        end
        object Label28: TLabel
          Left = 399
          Top = 9
          Width = 14
          Height = 23
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
        object lblReturn: TLabel
          Left = 270
          Top = 132
          Width = 230
          Height = 13
          Caption = 'The item has been credited in inventory.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object btnSendToCustomer: TSpeedButton
          Left = 393
          Top = 81
          Width = 130
          Height = 25
          Caption = 'Returned To Customer'
          Flat = True
          Glyph.Data = {
            EE000000424DEE000000000000007600000028000000090000000F0000000100
            04000000000078000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666000
            000066666666600000006006666660000000604066666000000060C406666000
            000060CC40666000000060CCC4066000000060CCCC406000000060CCC4066000
            000060CC40666000000060C40666600000006040666660000000600666666000
            000066666666600000006666666660000000}
          Margin = 5
          OnClick = btnSendToCustomerClick
        end
        object Label37: TLabel
          Left = 226
          Top = 9
          Width = 14
          Height = 23
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
        object Label38: TLabel
          Left = 395
          Top = 46
          Width = 14
          Height = 23
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
        object rdgTipoRepairInv: TDBRadioGroup
          Left = 76
          Top = 33
          Width = 319
          Height = 36
          Caption = 'Return Status'
          Columns = 4
          DataField = 'TipoRepair'
          DataSource = dsForm
          Items.Strings = (
            'Exchanged'
            'Repaired'
            'Damaged'
            'Credited')
          TabOrder = 2
          Values.Strings = (
            '1'
            '2'
            '3'
            '4')
        end
        object cbxUserBack: TDBSuperComboADO
          Left = 76
          Top = 8
          Width = 147
          Height = 21
          TabOrder = 0
          Text = 'cbxUserBack'
          CodeLength = 5
          LookUpSource = DM.dsLookUpUser
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDUserReturn'
          DataSource = dsForm
        end
        object dbdtONBack: TDBDateBox
          Left = 277
          Top = 8
          Width = 118
          Height = 21
          ReadOnly = False
          TabOrder = 1
          Text = 'dbdtONBack'
          InputTime = False
          Language = Portuguese
          DataField = 'ReturnDate'
          DataSource = dsForm
        end
        object DbMemoStr4: TDbMemoStr
          Left = 75
          Top = 74
          Width = 315
          Height = 54
          DataField = 'OBSReturn'
          DataSource = dsForm
          TabOrder = 3
        end
        object rdgTipoRepairCli: TDBRadioGroup
          Left = 76
          Top = 33
          Width = 319
          Height = 36
          Caption = 'Return Status'
          Columns = 4
          DataField = 'TipoRepair'
          DataSource = dsForm
          Items.Strings = (
            'Exchanged'
            'Repaired'
            'Damaged')
          TabOrder = 4
          Values.Strings = (
            '1'
            '2'
            '3')
        end
      end
      object tsBackCustomer: TTabSheet
        Caption = 'Sent to Customer'
        object Label3: TLabel
          Left = -10
          Top = 12
          Width = 74
          Height = 16
          Alignment = taRightJustify
          Caption = 'Returned by:'
        end
        object Label29: TLabel
          Left = 237
          Top = 12
          Width = 16
          Height = 16
          Alignment = taRightJustify
          Caption = 'On'
        end
        object Label30: TLabel
          Left = 389
          Top = 10
          Width = 14
          Height = 23
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
        object btSentToCustomer: TSpeedButton
          Left = 392
          Top = 110
          Width = 125
          Height = 30
          Caption = '&Receipt'
          Flat = True
          Glyph.Data = {
            A2070000424DA207000000000000360000002800000019000000190000000100
            1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C69C96949C9694FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECBCEBDBA
            BDDEDBDEDEDFDEADAEADB5B2B59C9694BD8E84A58E84ADAEADFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFBDBABDCECFCEEFEFEFEFEFEFDEDBDEADAEADB5B2B58C8E8C4A4D4A63
            61636361638C8A8C9C9694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFFFFBDBEBDC6C3C6EFEBEFF7F3F7EFEFEFEFEBEFD6D3D6AD
            AAADADAEAD8C8E8C4A4D4A4241426361636361638486848C8E8CADAEADC6C7C6
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDBABDDEDFDEFFFBFFFFF7F7EF
            EFEFEFEBEFE7E3E7D6D3D6ADAAADADAAADADAEADADAEADADAAAD8C8A8C737173
            6361638486848C8E8CB5B2B59C9E9CFFFFFFFFFFFF00FFFFFFFFFFFFBDBABDFF
            FFFFFFFBFFFFF7F7EFEFEFEFEBEFDEDBDEB5B2B58C8E8C8482848C8E8CADAAAD
            ADAEADADAEADB5B2B5BDBABDADAEAD9C9E9C636163525152CECBCEFFFFFFFFFF
            FF00FFFFFFFFFFFFADAEADFFFBFFFFF7F7EFEFEFDEDBDE9C9E9C9C9E9CBDBABD
            C6C7C69C9E9C8C8E8C8482848482848C8E8C9C9E9CB5B2B5BDBABDBDBEBDC6C3
            C6BDBABDC6C7C6FFFFFFFFFFFF00FFFFFFFFFFFFADAAADF7F3F7CECFCE9C9694
            9C9E9CD6D3D6DEDBDED6D3D6D6D3D6CECBCEBDBEBDADAAADADAAAD9C9E9C8C8E
            8C8486848C8A8C9C9E9CBDBABD8CBE8C8CBE8CFFFFFFFFFFFF00FFFFFFFFFFFF
            9C9E9C8C8A8C9C9694DEDBDEDEDFDEDEDBDED6D3D6CECBCEEFEBEFE7E7E7E7E7
            E7EFEBEFDEDBDECECBCEBDBABDADAEADADAEAD9C96948486848482849C9694FF
            FFFFFFFFFF00FFFFFFFFFFFF8C8E8CEFEBEFE7E3E7DEDFDEDEDBDED6D3D6CECF
            CEE7E3E7DEDBDEB5B2B5BDBABDBDBABDBDBEBDCECFCEE7E7E7E7E7E7D6D3D6C6
            C7C6BDBEBDBDBABDADAAADFFFFFFFFFFFF00FFFFFFFFFFFF8C8A8CE7E3E7DEDF
            DEDEDBDED6D3D6CECFCEDEDBDEE7E7E7C6C3C6EFEFEFEFEFEFEFEBEFCECFCEBD
            BEBDBDBABDBDBABDBDBEBDD6D3D6E7E3E7DEDFDED6D3D6FFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFD6D3D6DEDBDED6D3D6CECFCEDEDFDECECFCEC6C3C6F7F3F7F7
            F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEFDEDBDEC6C7C6BDBABDBDBABDBDBABD
            CECBCEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADAEADBDBEBDC6
            C3C6D6D3D6C6C7C6CECBCEE7E7E7F7F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEF
            E7E7E7E7E7E7D6D3D6ADAEADFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFADAAADE7E7E7E7E7E7ADAEADB5B2B5BDBABDBDBABDC6C3C6
            CECBCEDEDBDEE7E7E7E7E7E7EFEBEFCECBCEB5B2B5FFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAAADFFFBF7FFF3E7EFDBCE
            D6D3D6C6C7C6C6C7C6BDBABDC6C3C6BDBEBDBDAAA5BDAAA5B5B2B5DEDBDEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFCE9A84FFD7ADFFD7ADFFD7ADFFDFBDFFDFBDFFEBD6F7E3D6EFE7DECEAA
            ADDEDBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6AA94FFDFBDFFD7ADFFDFBDFFD7ADFFDF
            BDFFD7ADFFDFBDF7D3A5BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3B5FFDF
            BDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDD6B2ADBD9A94FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFDEC7B5FFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEBD
            9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9A94FFEBD6FFEBD6FFEBD6FFEBD6FF
            EBD6FFEBD6FFEBD6EFDBCEBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECBC6FF
            F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7D6B2ADBD9A94FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFD6BEBDFFF7EFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFF7EF
            BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED7D6FFFFFFFFFBFFFFFFFFFFFFFF
            FFFBFFFFFFFFFFFFFFEFEBEFBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFCEBEB5BD9A94
            BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF00}
          Margin = 5
          OnClick = btSentToCustomerClick
        end
        object Label33: TLabel
          Left = 27
          Top = 42
          Width = 32
          Height = 16
          Alignment = taRightJustify
          Caption = 'Notes'
        end
        object Label39: TLabel
          Left = 200
          Top = 9
          Width = 14
          Height = 23
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
        object DBSuperCombo2: TDBSuperComboADO
          Left = 66
          Top = 8
          Width = 131
          Height = 21
          TabOrder = 0
          Text = 'DBSuperCombo2'
          CodeLength = 5
          LookUpSource = DM.dsLookUpUser
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDUserBack'
          DataSource = dsForm
        end
        object DBDateBox3: TDBDateBox
          Left = 259
          Top = 8
          Width = 125
          Height = 21
          ReadOnly = False
          TabOrder = 1
          Text = 'DBDateBox3'
          InputTime = False
          Language = Portuguese
          DataField = 'BackDate'
          DataSource = dsForm
        end
        object DbMemoStr5: TDbMemoStr
          Left = 65
          Top = 44
          Width = 318
          Height = 98
          DataField = 'OBSBack'
          DataSource = dsForm
          TabOrder = 2
        end
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 550
      Height = 194
      Align = alTop
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 0
      object Label14: TLabel
        Left = 0
        Top = 0
        Width = 550
        Height = 18
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Return Item Info'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 28
        Top = 52
        Width = 43
        Height = 16
        Alignment = taRightJustify
        Caption = 'Model :'
      end
      object Label19: TLabel
        Left = 25
        Top = 78
        Width = 46
        Height = 16
        Alignment = taRightJustify
        Caption = 'Serial #'
      end
      object lbPutSerial: TLabel
        Left = 214
        Top = 74
        Width = 14
        Height = 23
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
      object Label7: TLabel
        Left = 248
        Top = 78
        Width = 19
        Height = 16
        Alignment = taRightJustify
        Caption = 'Qty'
        FocusControl = dbQty
      end
      object Label5: TLabel
        Left = 315
        Top = 75
        Width = 14
        Height = 23
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
        Left = 528
        Top = 48
        Width = 14
        Height = 23
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
      object Label17: TLabel
        Left = 30
        Top = 126
        Width = 45
        Height = 16
        Alignment = taRightJustify
        Caption = 'Defect :'
      end
      object btnInStore: TSpeedButton
        Left = 269
        Top = 99
        Width = 150
        Height = 25
        Caption = 'Sent To Vendor'
        Flat = True
        Glyph.Data = {
          EE000000424DEE000000000000007600000028000000090000000F0000000100
          04000000000078000000C40E0000C40E00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666000
          000066666666600000006006666660000000603066666000000060B306666000
          000060BB30666000000060BBB3066000000060BBBB306000000060BBB3066000
          000060BB30666000000060B30666600000006030666660000000600666666000
          000066666666600000006666666660000000}
        Margin = 5
        OnClick = sbSendToVendorClick
      end
      object lbBarcode: TLabel
        Left = 26
        Top = 26
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
      object lbDefect: TLabel
        Left = -2
        Top = 104
        Width = 77
        Height = 16
        Alignment = taRightJustify
        Caption = 'Defect Type :'
      end
      object lbLot: TLabel
        Left = 50
        Top = 173
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
      object cmbModel: TDBSuperComboADO
        Left = 77
        Top = 48
        Width = 448
        Height = 24
        TabOrder = 1
        Text = 'cmbModel'
        CodeLength = 260
        LookUpSource = DM.dsLookUpModel
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
      object dbSerialNumber: TDBEdit
        Left = 77
        Top = 74
        Width = 134
        Height = 24
        DataField = 'SerialNumber'
        DataSource = dsForm
        TabOrder = 2
      end
      object dbQty: TDBEdit
        Left = 270
        Top = 75
        Width = 44
        Height = 24
        Color = clWhite
        DataField = 'Qty'
        DataSource = dsForm
        TabOrder = 3
      end
      object DbMemoStr2: TDbMemoStr
        Left = 77
        Top = 126
        Width = 446
        Height = 41
        DataField = 'Defect'
        DataSource = dsForm
        ScrollBars = ssVertical
        TabOrder = 5
      end
      object edtBarcode: TmrBarCodeEdit
        Left = 77
        Top = 22
        Width = 185
        Height = 24
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
      object scDefectType: TDBSuperComboADO
        Left = 78
        Top = 100
        Width = 132
        Height = 24
        TabOrder = 4
        Text = 'scDefectType'
        LookUpSource = DM.dsLookUpDefectType
        DropDownRows = 10
        IDLanguage = 0
        DataField = 'IDDefectType'
        DataSource = dsForm
      end
      object scLot: TDBSuperComboADO
        Left = 77
        Top = 169
        Width = 134
        Height = 24
        TabOrder = 7
        Text = 'scLot'
        Visible = False
        CodeLength = 240
        LookUpSource = DM.dsLookUpLot
        DropDownRows = 18
        EditCodePos = taEditCodeRight
        IDLanguage = 0
        DataField = 'IDLote'
        DataSource = dsForm
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 43
    Height = 392
  end
  inherited EspacamentoDireito: TPanel
    Left = 553
    Top = 43
    Height = 392
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchRepair.sil'
  end
  inherited dsForm: TDataSource
    Left = 479
    Top = 99
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    AfterInsert = quFormAfterInsert
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10'        IDRepair,'#13#10'        IDModel,'#13#10'        IDCliente,'#13 +
      #10'        Fase,'#13#10'        IDFornecedor,'#13#10'        IDUserReceive,'#13#10' ' +
      '       ReceiveDate,'#13#10'        SentDate,'#13#10'        OBSReceive,'#13#10'   ' +
      '     TipoRepair,'#13#10'        IDUserSent,'#13#10'        Qty,'#13#10'        UPS' +
      ','#13#10'        RA,'#13#10'        DateLastCost,'#13#10'        SerialNumber,'#13#10'  ' +
      '      LastCost,'#13#10'        Defect,'#13#10'        Desativado,'#13#10'        I' +
      'DUserReturn,'#13#10'        ReturnDate,'#13#10'        ReturnStatus,'#13#10'      ' +
      '  OBSReturn,'#13#10'        IDUserBack,'#13#10'        BackDate,'#13#10'        ID' +
      'InvMovSend,'#13#10'        IDInvMovReturn,'#13#10'        Tipo,'#13#10'        IDS' +
      'tore,'#13#10'        OBSBack,'#13#10'        IDDefectType,'#13#10'        IDLote'#13#10 +
      'FROM'#13#10'        Repair Repair'#13#10'WHERE'#13#10'        IDRepair = :IDRepair' +
      ' '#13#10' '#13#10
    Parameters = <
      item
        Name = 'IDRepair'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 495
    Top = 26
    object quFormIDRepair: TIntegerField
      FieldName = 'IDRepair'
    end
    object quFormIDModel: TIntegerField
      DisplayLabel = 'Model'
      FieldName = 'IDModel'
      Required = True
    end
    object quFormSerialNumber: TStringField
      FieldName = 'SerialNumber'
    end
    object quFormIDCliente: TIntegerField
      DisplayLabel = 'Customer'
      FieldName = 'IDCliente'
    end
    object quFormFase: TStringField
      FieldName = 'Fase'
    end
    object quFormIDFornecedor: TIntegerField
      DisplayLabel = 'Vendor'
      FieldName = 'IDFornecedor'
    end
    object quFormIDUserReceive: TIntegerField
      DisplayLabel = 'Received By'
      FieldName = 'IDUserReceive'
    end
    object quFormReceiveDate: TDateTimeField
      DisplayLabel = 'Receive On'
      FieldName = 'ReceiveDate'
    end
    object quFormSentDate: TDateTimeField
      DisplayLabel = 'Sent on'
      FieldName = 'SentDate'
    end
    object quFormOBSReceive: TStringField
      FieldName = 'OBSReceive'
      Size = 255
    end
    object quFormTipoRepair: TIntegerField
      DisplayLabel = 'Return status'
      FieldName = 'TipoRepair'
      OnChange = quFormTipoRepairChange
    end
    object quFormIDUserSent: TIntegerField
      DisplayLabel = 'Sent By'
      FieldName = 'IDUserSent'
    end
    object quFormUPS: TStringField
      FieldName = 'UPS'
    end
    object quFormRA: TStringField
      FieldName = 'RA'
    end
    object quFormDateLastCost: TDateTimeField
      FieldName = 'DateLastCost'
    end
    object quFormLastCost: TFloatField
      FieldName = 'LastCost'
      DisplayFormat = '#,##0.00'
    end
    object quFormDesativado: TIntegerField
      FieldName = 'Desativado'
    end
    object quFormIDUserReturn: TIntegerField
      DisplayLabel = 'Received by'
      FieldName = 'IDUserReturn'
    end
    object quFormReturnDate: TDateTimeField
      DisplayLabel = 'Return on'
      FieldName = 'ReturnDate'
    end
    object quFormReturnStatus: TStringField
      FieldName = 'ReturnStatus'
    end
    object quFormOBSReturn: TStringField
      FieldName = 'OBSReturn'
      Size = 255
    end
    object quFormIDUserBack: TIntegerField
      DisplayLabel = 'Returnd by'
      FieldName = 'IDUserBack'
    end
    object quFormBackDate: TDateTimeField
      DisplayLabel = 'Back on'
      FieldName = 'BackDate'
    end
    object quFormIDInvMovSend: TIntegerField
      FieldName = 'IDInvMovSend'
    end
    object quFormIDInvMovReturn: TIntegerField
      FieldName = 'IDInvMovReturn'
    end
    object quFormTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object quFormOBSBack: TStringField
      FieldName = 'OBSBack'
      Size = 255
    end
    object quFormIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quFormDefect: TStringField
      FieldName = 'Defect'
      Size = 255
    end
    object quFormQty: TFloatField
      FieldName = 'Qty'
      OnChange = quFormQtyChange
      DisplayFormat = '0.#####'
    end
    object quFormIDDefectType: TIntegerField
      FieldName = 'IDDefectType'
    end
    object quFormIDLote: TIntegerField
      FieldName = 'IDLote'
    end
  end
  inherited FormConfig: TFormConfig
    SystemReadOnly = False
    ConfirmCancel = False
    AutoIncField = 'IDRepair'
    Left = 480
    Top = 145
  end
  object spRepairDO: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Repair_Do;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDRepair'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 369
    Top = 60
  end
end
