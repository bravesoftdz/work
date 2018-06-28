inherited FchTransferModel: TFchTransferModel
  Left = 144
  Top = 52
  Caption = 'FchTransferModel'
  ClientHeight = 487
  ClientWidth = 639
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 639
    DesignSize = (
      639
      40)
    inherited Image1: TImage
      Width = 365
    end
    inherited lblMenu: TLabel
      Left = 443
      Width = 631
    end
    inherited EspacamentoSuperior: TPanel
      Width = 639
      inherited EEE: TPanel
        Width = 639
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 592
    end
  end
  inherited Panel1: TPanel
    Top = 446
    Width = 639
    inherited EspacamentoInferior: TPanel
      Width = 639
      inherited Panel3: TPanel
        Width = 639
      end
    end
    inherited hhh: TPanel
      Left = 418
      inherited btCancel: TButton
        Cancel = False
      end
    end
  end
  inherited pnlKey: TPanel
    Width = 639
    Height = 2
    inherited Panel4: TPanel
      Top = 0
      Width = 639
    end
  end
  inherited pnlDetail: TPanel
    Top = 42
    Width = 633
    Height = 109
    object Label3: TLabel
      Left = 28
      Top = 5
      Width = 43
      Height = 16
      Alignment = taRightJustify
      Caption = 'FROM :'
    end
    object Label2: TLabel
      Left = 352
      Top = 5
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Date :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 45
      Top = 31
      Width = 26
      Height = 16
      Alignment = taRightJustify
      Caption = 'TO :'
    end
    object Label5: TLabel
      Left = 353
      Top = 31
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbNumber: TLabel
      Left = 17
      Top = 56
      Width = 54
      Height = 16
      Alignment = taRightJustify
      Caption = 'Number :'
    end
    object lblCFOP: TLabel
      Left = 343
      Top = 89
      Width = 40
      Height = 16
      Alignment = taRightJustify
      Caption = 'CFOP :'
    end
    object lbOBS: TLabel
      Left = 30
      Top = 76
      Width = 41
      Height = 16
      Alignment = taRightJustify
      Caption = 'Notes :'
    end
    object cmbLojaOrigem: TDBSuperComboADO
      Left = 75
      Top = 1
      Width = 194
      Height = 24
      Color = clWhite
      TabOrder = 0
      Text = 'cmbLojaOrigem'
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDLojaOrigem'
      DataSource = dsForm
    end
    object cmbLojaDestino: TDBSuperComboADO
      Left = 75
      Top = 27
      Width = 194
      Height = 24
      Color = clWhite
      TabOrder = 1
      Text = 'cmbLojaDestino'
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDLojaDestino'
      DataSource = dsForm
    end
    object cbmUser: TDBSuperComboADO
      Left = 387
      Top = 27
      Width = 160
      Height = 24
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
      Text = 'cbmUser'
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 18
      ShowBtnSelecao = False
      IDLanguage = 0
      DataField = 'IDUser'
      DataSource = dsForm
    end
    object dbNumber: TDBEdit
      Left = 75
      Top = 51
      Width = 194
      Height = 24
      Color = clWhite
      DataField = 'Number'
      DataSource = dsForm
      TabOrder = 2
    end
    object rbType: TDBRadioGroup
      Left = 387
      Top = 50
      Width = 161
      Height = 32
      Caption = 'Transfer Type'
      Columns = 2
      DataField = 'TransferType'
      DataSource = dsForm
      Items.Strings = (
        'OUT'
        'IN')
      TabOrder = 6
      TabStop = True
      Values.Strings = (
        'False'
        'True')
    end
    object edtDate: TDBDateBox
      Left = 387
      Top = 1
      Width = 161
      Height = 24
      ReadOnly = False
      TabOrder = 4
      DataField = 'Data'
      DataSource = dsForm
    end
    object scCFOP: TDBSuperComboADO
      Left = 387
      Top = 85
      Width = 161
      Height = 24
      TabOrder = 7
      Text = 'scCFOP'
      LookUpSource = DM.dsLookUpCFOP
      DropDownRows = 18
      MostraDesativado = STD_AMBOSDESATIVADO
      MostraHidden = STD_AMBOSHIDDEN
      IDLanguage = 0
      DataField = 'IDCFOP'
      DataSource = dsForm
    end
    object memOBS: TDBMemo
      Left = 75
      Top = 75
      Width = 195
      Height = 32
      DataField = 'OBS'
      DataSource = dsForm
      MaxLength = 255
      TabOrder = 3
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 42
    Height = 109
  end
  inherited EspacamentoDireito: TPanel
    Left = 636
    Top = 42
    Height = 109
  end
  inherited pnlPPageControl: TPanel
    Top = 151
    Width = 639
    Height = 295
    inherited PPageControl: TPageControl
      Width = 639
      Height = 295
      inherited tsBrowse: TTabSheet
        inherited LabelName: TLabel
          Width = 631
        end
        inherited pnlComand: TPanel
          Left = 524
          Height = 243
          inherited btAdd: TSpeedButton
            Width = 91
          end
          object btnPrintBarcode: TSpeedButton [5]
            Left = 3
            Top = 186
            Width = 104
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
          object btnAddQuick: TSpeedButton [6]
            Left = 93
            Top = 0
            Width = 13
            Height = 24
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
          Width = 631
        end
        inherited grdBrowse: TcxGrid
          Width = 524
          Height = 243
          inherited grdBrowseDB: TcxGridDBTableView
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDModelTransfDet'
            DataController.Summary.FooterSummaryItems = <
              item
                Format = '0'
                Kind = skSum
                FieldName = 'QtyTransfer'
                Column = grdBrowseDBQtyTransfer
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'FinalCost'
                Column = grdBrowseDBLastCost
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'TotalLastCost'
                Column = grdBrowseDBTotalLastCost
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'TotalSellingPrice'
                Column = grdBrowseDBTotalSellingPrice
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'TotalSuggRetail'
                Column = grdBrowseDBTotalSuggRetail
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'FinalCost'
                Column = grdBrowseDBFinalCost
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                FieldName = 'TotalFinalCost'
                Column = grdBrowseDBTotalFinalCost
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
                FieldName = 'TotalCost'
                Column = grdBrowseDBTotalCost
              end>
            object grdBrowseDBIDModelTransfDet: TcxGridDBColumn
              DataBinding.FieldName = 'IDModelTransfDet'
              Visible = False
              Hidden = True
              Options.Filtering = False
            end
            object grdBrowseDBIDModelTransf: TcxGridDBColumn
              DataBinding.FieldName = 'IDModelTransf'
              Visible = False
              Hidden = True
              Options.Filtering = False
            end
            object grdBrowseDBIDModel: TcxGridDBColumn
              DataBinding.FieldName = 'IDModel'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBModel: TcxGridDBColumn
              DataBinding.FieldName = 'Model'
              Options.Filtering = False
              Width = 88
            end
            object grdBrowseDBDescription: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Options.Filtering = False
              Width = 183
            end
            object grdBrowseDBVendorCost: TcxGridDBColumn
              DataBinding.FieldName = 'VendorCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBDateLastCost: TcxGridDBColumn
              DataBinding.FieldName = 'DateLastCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSellingPrice: TcxGridDBColumn
              DataBinding.FieldName = 'SellingPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBDateLastSellingPrice: TcxGridDBColumn
              DataBinding.FieldName = 'DateLastSellingPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBLastCost: TcxGridDBColumn
              DataBinding.FieldName = 'LastCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBSuggRetail: TcxGridDBColumn
              DataBinding.FieldName = 'SuggRetail'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBOtherCost: TcxGridDBColumn
              DataBinding.FieldName = 'OtherCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBFreightCost: TcxGridDBColumn
              DataBinding.FieldName = 'FreightCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBQtyOnHand: TcxGridDBColumn
              DataBinding.FieldName = 'QtyOnHand'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBQtyTransfer: TcxGridDBColumn
              DataBinding.FieldName = 'QtyTransfer'
              Options.Filtering = False
              Width = 78
            end
            object grdBrowseDBFinalCost: TcxGridDBColumn
              Caption = 'NetCost'
              DataBinding.FieldName = 'FinalCost'
              Visible = False
              Options.Filtering = False
              Width = 59
            end
            object grdBrowseDBTotalLastCost: TcxGridDBColumn
              Caption = 'ExtendedCost'
              DataBinding.FieldName = 'TotalLastCost'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBTotalSellingPrice: TcxGridDBColumn
              Caption = 'Ext OurPrice'
              DataBinding.FieldName = 'TotalSellingPrice'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBTotalSuggRetail: TcxGridDBColumn
              Caption = 'Ext MSRP'
              DataBinding.FieldName = 'TotalSuggRetail'
              Visible = False
              Options.Filtering = False
            end
            object grdBrowseDBTotalFinalCost: TcxGridDBColumn
              Caption = 'Ext NetCost'
              DataBinding.FieldName = 'TotalFinalCost'
              Visible = False
              Options.Filtering = False
              Width = 61
            end
            object grdBrowseDBCostPrice: TcxGridDBColumn
              Caption = 'Transfer Cost'
              DataBinding.FieldName = 'CostPrice'
              Options.Filtering = False
              Width = 89
            end
            object grdBrowseDBTotalCost: TcxGridDBColumn
              Caption = 'Transfer Total'
              DataBinding.FieldName = 'TotalCost'
              Options.Filtering = False
              Width = 91
            end
            object grdBrowseDBManufacturer: TcxGridDBColumn
              DataBinding.FieldName = 'Manufacturer'
              Visible = False
              Options.Editing = False
              Options.Filtering = False
            end
            object grdBrowseDBCaseQty: TcxGridDBColumn
              Caption = 'Case Qty'
              DataBinding.FieldName = 'CaseQty'
              Visible = False
              Options.Editing = False
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
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchTransferModel.sil'
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
      42726F77736501747342726F7773650101010D0A706E6C436F6D616E64010101
      010D0A627441646401463220264164640101010D0A627452656D6F7665014634
      205265266D6F76650101010D0A627447726F7570012647726F7570696E670101
      010D0A6274436F6C756D6E0126436F6C756D6E730101010D0A62745072657669
      65770146352026507265766965770101010D0A6274457863656C014636205370
      7265616473686565740101010D0A50616E656C38010101010D0A50616E656C36
      010101010D0A706E6C73646A68666B736468666A6B73646866010101010D0A73
      7448696E74730D0A5462727746726D506172656E7442727701010D0A50616E65
      6C31010101010D0A6C626C557365724E616D65010101010D0A4C6162656C3135
      010101010D0A4573706163616D656E746F496E666572696F72010101010D0A50
      616E656C33010101010D0A686868010101010D0A737048656C70010101010D0A
      627443616E63656C010101010D0A6274436C6F7365010101010D0A706E6C4E61
      7669676174696F6E010101010D0A62744669727374526563014D6F766520746F
      204669727374205265636F72640101010D0A62745072696F72526563014D6F76
      6520746F205072696F72205265636F72640101010D0A62744E65787452656301
      4D6F766520746F204E657874205265636F72640101010D0A62744C6173745265
      63014D6F766520746F204C617374205265636F72640101010D0A50616E656C32
      010101010D0A496D61676531010101010D0A6C626C5375624D656E7501010101
      0D0A6C626C4D656E75010101010D0A4573706163616D656E746F537570657269
      6F72010101010D0A454545010101010D0A706E6C4175746F496E630150726573
      73206865726520746F20636F6E74696E75696E6720696E736572742064617461
      0101010D0A62744C6F6F70496E6301436F6E74696E75696E6720696E73657274
      206461746120776974686F757420636C6F73696E67207468652073637265656E
      2E0101010D0A6C626C4D6F646966696564010101010D0A706E6C4B6579010101
      010D0A50616E656C34010101010D0A706E6C44657461696C010101010D0A4573
      706163616D656E746F457371756572646F010101010D0A4573706163616D656E
      746F4469726569746F010101010D0A706E6C5050616765436F6E74726F6C0101
      01010D0A5050616765436F6E74726F6C010101010D0A747342726F7773650101
      01010D0A706E6C436F6D616E64010101010D0A6274416464010101010D0A6274
      52656D6F7665010101010D0A627447726F7570010101010D0A6274436F6C756D
      6E010101010D0A627450726576696577010101010D0A6274457863656C014578
      706F7274206772696420746F2053707265616473686565740101010D0A50616E
      656C38010101010D0A50616E656C36010101010D0A706E6C73646A68666B7364
      68666A6B73646866010101010D0A7374446973706C61794C6162656C730D0A73
      74466F6E74730D0A5462727746726D506172656E74427277015461686F6D6101
      01010D0A6C626C557365724E616D6501417269616C0101010D0A4C6162656C31
      3501417269616C0101010D0A627443616E63656C015461686F6D610101010D0A
      6274436C6F7365015461686F6D610101010D0A62744669727374526563014172
      69616C0101010D0A62745072696F7252656301417269616C0101010D0A62744E
      65787452656301417269616C0101010D0A62744C61737452656301417269616C
      0101010D0A6C626C5375624D656E750156657264616E610101010D0A6C626C4D
      656E750156657264616E610101010D0A6C626C4D6F64696669656401536D616C
      6C20466F6E74730101010D0A73744D756C74694C696E65730D0A7175466F726D
      2E46696C7465724669656C6473010101010D0A7175466F726D2E46696C746572
      56616C756573010101010D0A466F726D436F6E6669672E446570656E64656E74
      5461626C654B657973010101010D0A466F726D436F6E6669672E446570656E64
      656E745461626C6573010101010D0A466F726D436F6E6669672E526571756972
      65644669656C6473010101010D0A466F726D436F6E6669672E556E6971756546
      69656C6473010101010D0A717542726F7773652E46696C7465724669656C6473
      010101010D0A717542726F7773652E46696C74657256616C756573010101010D
      0A7374446C677343617074696F6E730D0A5761726E696E67015761726E696E67
      0101010D0A4572726F72014572726F720101010D0A496E666F726D6174696F6E
      01496E666F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D
      0101010D0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B01
      4F4B0101010D0A43616E63656C0143616E63656C0101010D0A41626F72740126
      41626F72740101010D0A5265747279012652657472790101010D0A49676E6F72
      65012649676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F
      20416C6C014E266F20746F20416C6C0101010D0A59657320546F20416C6C0159
      657320746F2026416C6C0101010D0A48656C70012648656C700101010D0A7374
      537472696E67730D0A73744F74686572537472696E67730D0A7175466F726D2E
      436F6D6D616E6454657874010101010D0A7175466F726D2E436F6E6E65637469
      6F6E537472696E67010101010D0A7175466F726D2E46696C746572010101010D
      0A7175466F726D2E496E6465784669656C644E616D6573010101010D0A717546
      6F726D2E4B65794669656C6473010101010D0A466F726D436F6E6669672E456E
      7469646164654E6F6D65010101010D0A717542726F7773652E436F6D6D616E64
      54657874010101010D0A717542726F7773652E436F6E6E656374696F6E537472
      696E67010101010D0A717542726F7773652E46696C746572010101010D0A7175
      42726F7773652E496E6465784669656C644E616D6573010101010D0A71754272
      6F7773652E4B65794669656C6473010101010D0A53442E46696C746572014D69
      63726F736F667420457863656C7C2A2E786C730101010D0A53442E5469746C65
      010101010D0A73744C6F63616C65730D0A43757272656E637920537472696E67
      01240101010D0A54686F7573616E6420536570617261746F72012C0101010D0A
      446563696D616C20536570617261746F72012E0101010D0A4461746520536570
      617261746F72012F0101010D0A53686F7274204461746520466F726D6174014D
      2F642F797979790101010D0A4C6F6E67204461746520466F726D617401646464
      642C204D4D4D4D2064642C20797979790101010D0A54696D6520536570617261
      746F72013A0101010D0A54696D6520414D20537472696E6701414D0101010D0A
      54696D6520504D20537472696E6701504D0101010D0A53686F72742054696D65
      20466F726D617401683A6D6D20414D504D0101010D0A4C6F6E672054696D6520
      466F726D617401683A6D6D3A737320414D504D0101010D0A53686F7274204D6F
      6E7468204E616D6573014A616E2C4665622C4D61722C4170722C4D61792C4A75
      6E2C4A756C2C4175672C5365702C4F63742C4E6F762C4465630101010D0A4C6F
      6E67204D6F6E7468204E616D6573014A616E756172792C46656272756172792C
      4D617263682C417072696C2C4D61792C4A756E652C4A756C792C417567757374
      2C53657074656D6265722C4F63746F6265722C4E6F76656D6265722C44656365
      6D6265720101010D0A53686F727420446179204E616D65730153756E2C4D6F6E
      2C5475652C5765642C5468752C4672692C5361740101010D0A4C6F6E67204461
      79204E616D65730153756E6461792C4D6F6E6461792C547565736461792C5765
      646E65736461792C54687572736461792C4672696461792C5361747572646179
      0101010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A
      5462727746726D506172656E7442727701414E53495F43484152534554010101
      0D0A6C626C557365724E616D650144454641554C545F43484152534554010101
      0D0A4C6162656C31350144454641554C545F434841525345540101010D0A6274
      436C6F736501414E53495F434841525345540101010D0A6C626C4D656E750141
      4E53495F434841525345540101010D0A6C626C5375624D656E7501414E53495F
      434841525345540101010D0A627443616E63656C01414E53495F434841525345
      540101010D0A6274466972737452656301414E53495F43484152534554010101
      0D0A62745072696F7252656301414E53495F434841525345540101010D0A6274
      4E65787452656301414E53495F434841525345540101010D0A62744C61737452
      656301414E53495F434841525345540101010D0A6C626C4D6F64696669656401
      414E53495F434841525345540101010D0A6C6162656C4E616D6501414E53495F
      434841525345540101010D0A}
  end
  inherited dsForm: TDataSource
    Left = 24
    Top = 248
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT '#13#10#9'MT.IDModelTransf,'#13#10#9'MT.IDLojaOrigem,'#13#10#9'MT.IDLojaDestin' +
      'o,'#13#10#9'MT.Data,'#13#10#9'MT.Number,'#13#10#9'MT.TransferType,'#13#10#9'MT.IDUser,'#13#10#9'MT.' +
      'Imported,'#13#10#9'MT.IDCFOP,'#13#10#9'MT.OBS'#13#10'FROM '#13#10#9'ModelTransf MT (NOLOCK)' +
      #13#10'WHERE '#13#10#9'MT.IDModelTransf = :IDModelTransf'#13#10' '
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 24
    Top = 200
    object quFormIDModelTransf: TIntegerField
      FieldName = 'IDModelTransf'
    end
    object quFormIDLojaOrigem: TIntegerField
      FieldName = 'IDLojaOrigem'
    end
    object quFormIDLojaDestino: TIntegerField
      FieldName = 'IDLojaDestino'
    end
    object quFormData: TDateTimeField
      FieldName = 'Data'
    end
    object quFormIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quFormNumber: TStringField
      FieldName = 'Number'
    end
    object quFormTransferType: TBooleanField
      FieldName = 'TransferType'
    end
    object quFormImported: TBooleanField
      FieldName = 'Imported'
    end
    object quFormIDCFOP: TIntegerField
      FieldName = 'IDCFOP'
    end
    object quFormOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    ConfirmPost = False
    ConfirmCancel = False
    AutoIncField = 'IDModelTransf'
    RequiredFields.Strings = (
      'IDLojaDestino'
      'Number')
    DependentTables.Strings = (
      'ModelTransfDet')
    DependentTableKeys.Strings = (
      'IDModelTransf')
    Left = 104
    Top = 200
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#9#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.VendorCost,' +
      #13#10#9'M.DateLastCost,'#13#10#9'M.DateLastSellingPrice,'#13#10#9'M.LastCost,'#13#10#9'M.S' +
      'uggRetail,'#13#10#9'M.OtherCost,'#13#10#9'M.FreightCost,'#13#10#9'M.TotQtyOnHand as Q' +
      'tyOnHand,'#13#10#9'IsNull(M.CaseQty, 0) as CaseQty,'#13#10#9'MT.IDModelTransfD' +
      'et,'#13#10#9'MT.IDModelTransf,'#13#10#9'MT.Qty as QtyTransfer,'#13#10#9'MT.CostPrice,' +
      #13#10#9'MT.SellingPrice,'#13#10#9'P.Pessoa as Manufacturer,'#13#10#9'L.IDLote,'#13#10#9'L.' +
      'Lot,'#13#10#9'M.UseLot'#13#10'FROM'#13#10#9'ModelTransfDet MT (NOLOCK)'#13#10#9'JOIN Model ' +
      'M (NOLOCK) ON (MT.IDModel = M.IDModel)'#13#10#9'LEFT JOIN Pessoa P (NOL' +
      'OCK) ON (M.IDFabricante = P.IDPessoa)'#13#10#9'LEFT JOIN Inv_Lot L (NOL' +
      'OCK) ON (L.IDLote = MT.IDLote)'#13#10'WHERE'#13#10#9'MT.IDModelTransf = :IDMo' +
      'delTransf'#13#10
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 24
    Top = 300
    object quBrowseIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quBrowseModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quBrowseDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quBrowseVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quBrowseDateLastCost: TDateTimeField
      FieldName = 'DateLastCost'
    end
    object quBrowseSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseDateLastSellingPrice: TDateTimeField
      FieldName = 'DateLastSellingPrice'
    end
    object quBrowseLastCost: TBCDField
      FieldName = 'LastCost'
      Precision = 19
    end
    object quBrowseSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quBrowseOtherCost: TBCDField
      FieldName = 'OtherCost'
      Precision = 19
    end
    object quBrowseFreightCost: TBCDField
      FieldName = 'FreightCost'
      Precision = 19
    end
    object quBrowseIDModelTransfDet: TIntegerField
      FieldName = 'IDModelTransfDet'
    end
    object quBrowseIDModelTransf: TIntegerField
      FieldName = 'IDModelTransf'
    end
    object quBrowseFinalCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'FinalCost'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseTotalLastCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalLastCost'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseTotalSellingPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalSellingPrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseTotalSuggRetail: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalSuggRetail'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseTotalFinalCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalFinalCost'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseTotalCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalCost'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quBrowseCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
    end
    object quBrowseQtyTransfer: TFloatField
      FieldName = 'QtyTransfer'
      DisplayFormat = '0.#####'
    end
    object quBrowseManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object quBrowseCaseQty: TFloatField
      FieldName = 'CaseQty'
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
  end
  inherited dsBrowse: TDataSource
    Left = 24
    Top = 348
  end
  inherited SD: TSaveDialog
    Left = 104
    Top = 248
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {0000000000000000ED03000072020000}
    Left = 104
    Top = 300
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37965.734994236110000000
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
  object spDelInventoryMov: TADOStoredProc [15]
    Connection = DM.ADODBConnect
    CommandTimeout = 1800
    ProcedureName = 'sp_Inventory_Del_Moviment;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDInventoryMov'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 340
    Top = 200
  end
  inherited GridPopupMenu: TcxGridPopupMenu
    Left = 104
    Top = 348
  end
  object quOriginalTransfer: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'MT.IDLojaOrigem,'#13#10#9'MT.IDLojaDestino,'#13#10#9'MT.Number'#13#10'FROM'#13 +
      #10#9'ModelTransf MT (NOLOCK)'#13#10'WHERE'#13#10#9'MT.IDModelTransf = :IDModelTr' +
      'ansf'#13#10#9'AND MT.TransferType = 0'#13#10#9'AND MT.Imported = 0'#13#10
    CommandTimeout = 1800
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 176
    Top = 248
    object quOriginalTransferIDLojaOrigem: TIntegerField
      FieldName = 'IDLojaOrigem'
    end
    object quOriginalTransferIDLojaDestino: TIntegerField
      FieldName = 'IDLojaDestino'
    end
    object quOriginalTransferNumber: TStringField
      FieldName = 'Number'
    end
  end
  object PopNew: TPopupMenu
    Left = 176
    Top = 200
    object menuAdd: TMenuItem
      Caption = 'Add'
      OnClick = btAddClick
    end
    object menuQuickEntry: TMenuItem
      Caption = 'Quick Entry'
      OnClick = menuQuickEntryClick
    end
  end
  object cmdUpdAVGCost: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'MTD'#13#10'SET'#13#10#9'MTD.AvgCost = IsNull(I.StoreAvgPrice, 0)'#13#10'FR' +
      'OM'#13#10#9'ModelTransfDet MTD (NOLOCK)'#13#10#9'JOIN ModelTransf MT (NOLOCK) ' +
      'ON (MTD.IDModelTransf = MT.IDModelTransf)'#13#10#9'JOIN Inventory I (NO' +
      'LOCK) ON (MT.IDLojaOrigem = I.StoreID AND MTD.IDModel = I.ModelI' +
      'D)'#13#10'WHERE'#13#10#9'MTD.IDModelTransf = :IDModelTransf'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 464
    Top = 200
  end
  object cmdInsInventoryMov: TADOCommand
    CommandText = 
      'INSERT InventoryMov'#13#10#9'('#13#10#9'IDInventoryMov,'#13#10#9'InventMovTypeID,'#13#10#9'D' +
      'ocumentID,'#13#10#9'StoreID,'#13#10#9'ModelID,'#13#10#9'IDPessoa,'#13#10#9'MovDate,'#13#10#9'Qty,'#13#10 +
      #9'IDUser,'#13#10#9'PreInventoryMovID,'#13#10#9'CostPrice,'#13#10#9'AvgCost'#13#10#9')'#13#10'VALUES' +
      #13#10#9'('#13#10#9':IDInventoryMov,'#13#10#9':InventMovTypeID,'#13#10#9':DocumentID,'#13#10#9':St' +
      'oreIDOrigem,'#13#10#9':ModelID,'#13#10#9'0,'#13#10#9':TrasfDate,'#13#10#9':Qty,'#13#10#9':IDUser,'#13#10 +
      #9':PreInventoryMovID,'#13#10#9':CostPrice,'#13#10#9':AvgCost'#13#10#9')'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'InventMovTypeID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DocumentID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'StoreIDOrigem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ModelID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'TrasfDate'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 38
        Size = 19
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'PreInventoryMovID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'AvgCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    Left = 340
    Top = 252
  end
  object quTransfModel: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'MTD.IDModelTransf,'#13#10#9'MT.IDLojaOrigem,'#13#10#9'MT.IDLojaDestin' +
      'o,'#13#10#9'MTD.IDModel,'#13#10#9'MTD.Qty,'#13#10#9'MT.Data,'#13#10#9'MT.IDUser,'#13#10#9'MTD.IDMod' +
      'elTransfDet,'#13#10#9'MTD.CostPrice,'#13#10#9'MTD.IDLote,'#13#10#9'CASE WHEN (I.QtyOn' +
      'Hand - MTD.Qty) = 0 THEN 0 ELSE I.StoreAvgPrice END AvgCost'#13#10'FRO' +
      'M'#13#10#9'ModelTransfDet MTD (NOLOCK)'#13#10#9'JOIN ModelTransf MT (NOLOCK) O' +
      'N (MTD.IDModelTransf = MT.IDModelTransf)'#13#10#9'LEFT JOIN Inventory I' +
      ' (NOLOCK) ON (MT.IDLojaOrigem = I.StoreID AND MTD.IDModel = I.Mo' +
      'delID)'#13#10'WHERE'#13#10#9'MT.IDModelTransf = :IDModelTransf'#13#10
    Parameters = <
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 464
    Top = 252
  end
  object quTransfPackModel: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'P.IDModel,'#13#10#9'(P.Qty * MTD.Qty) Qty,'#13#10#9'M.VendorCost,'#13#10#9'M' +
      '.AvgCost'#13#10'FROM'#13#10#9'ModelTransfDet MTD (NOLOCK)'#13#10#9'JOIN Model M (NOL' +
      'OCK) ON (MTD.IDModel = M.IDModel)'#13#10#9'JOIN PackModel P (NOLOCK)ON ' +
      '(M.IDModel = P.IDPackModel)'#13#10'WHERE'#13#10#9'MTD.IDModelTransfDet = :IDM' +
      'odelTransfDet'#13#10
    Parameters = <
      item
        Name = 'IDModelTransfDet'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 464
    Top = 308
  end
  object quHasInventory: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'ModelID'#13#10'FROM'#13#10#9'Inventory (NOLOCK)'#13#10'WHERE'#13#10#9'StoreID = :' +
      'IDStore'#13#10#9'AND ModelID = :IDModel'#13#10
    Parameters = <
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
    Left = 340
    Top = 308
  end
  object cmdInsertInventory: TADOCommand
    CommandText = 
      'INSERT Inventory'#13#10#9'('#13#10#9'IDInventory,'#13#10#9'StoreID,'#13#10#9'ModelID'#13#10#9')'#13#10'VA' +
      'LUES'#13#10#9'('#13#10#9':IDInventory,'#13#10#9':IDStore,'#13#10#9':IDModel'#13#10#9')'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDInventory'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
    Left = 340
    Top = 360
  end
  object quInventoryMovOld: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IDInventoryMov'#13#10'FROM'#13#10#9'InventoryMov (NOLOCK)'#13#10'WHERE'#13#10#9'I' +
      'nventoryMov.InventMovTypeID = :IDInventMovType'#13#10#9'AND InventoryMo' +
      'v.DocumentID = :IDModelTransf'#13#10
    Parameters = <
      item
        Name = 'IDInventMovType'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModelTransf'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 464
    Top = 360
  end
  object cmdUpdModelAVGCost: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Model'#13#10'SET'#13#10#9'AvgCostTotal = IsNull(AvgCostTotal, 0) + (' +
      ':AvgCostA * :QtyA),'#13#10#9'AvgCost ='#9'CASE'#13#10#9#9#9#9'WHEN (IsNull(TotQtyOnH' +
      'and, 0) + :QtyB) = 0'#13#10#9#9#9#9'THEN 0'#13#10#9#9#9#9'ELSE (IsNull(AvgCostTotal,' +
      ' 0) + (:AvgCostB * :QtyC)) / (IsNull(TotQtyOnHand, 0) + :QtyD)'#13#10 +
      #9#9#9'END'#13#10'WHERE'#13#10#9'IDModel = :IDModel'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'AvgCostA'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'QtyA'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'QtyB'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'AvgCostB'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'QtyC'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'QtyD'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
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
    Left = 464
    Top = 152
  end
  object cmdUpdInventoryAVGCost: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Inventory'#13#10'SET'#13#10#9'AvgCostTotal = IsNull(Inventory.AvgCos' +
      'tTotal, 0) + (:AvgCostA * :Qty),'#13#10#9'StoreAvgPrice = :AvgCostB'#13#10'WH' +
      'ERE'#13#10#9'ModelID = :IDModel'#13#10#9'AND StoreID = :IDStore'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'AvgCostA'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'AvgCostB'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
    Left = 340
    Top = 152
  end
  object cmdUpdTransfOUT: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'ModelTransf'#13#10'SET'#13#10#9'Imported = 1'#13#10'WHERE'#13#10#9'IDModelTransf ' +
      '= :IDTransfOUT'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDTransfOUT'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 340
    Top = 88
  end
  object quTransfSerial: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDModelTransfDet'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '            MTS.IDModelTransfSerial,'
      '            MTS.IDModelTransfDet,'
      '            MTS.SerialNum'
      'FROM'
      '            ModelTransfSerial MTS (NOLOCK)'
      'WHERE'
      '            MTS.IDModelTransfDet =:IDModelTransfDet ')
    Left = 212
    Top = 351
    object quTransfSerialIDModelTransfSerial: TIntegerField
      FieldName = 'IDModelTransfSerial'
    end
    object quTransfSerialIDModelTransfDet: TIntegerField
      FieldName = 'IDModelTransfDet'
    end
    object quTransfSerialSerialNum: TStringField
      FieldName = 'SerialNum'
      Size = 30
    end
  end
end
