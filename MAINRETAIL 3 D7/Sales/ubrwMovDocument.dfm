inherited brwMovDocument: TbrwMovDocument
  Left = 59
  Top = 102
  Width = 769
  Height = 552
  Caption = 'brwMovDocument'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 761
    DesignSize = (
      761
      34)
    inherited Image1: TImage
      Width = 534
    end
    inherited lblMenu: TLabel
      Left = 546
    end
    inherited EspacamentoSuperior: TPanel
      Width = 761
      inherited EEE: TPanel
        Width = 761
      end
    end
  end
  inherited Panel1: TPanel
    Top = 484
    Width = 761
    inherited EspacamentoInferior: TPanel
      Width = 761
      inherited Panel3: TPanel
        Width = 761
      end
    end
    inherited hhh: TPanel
      Left = 613
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 450
  end
  inherited EspacamentoDireito: TPanel
    Left = 761
    Height = 450
  end
  inherited pnlMain: TPanel
    Width = 761
    Height = 450
    inherited pnlBasicFilter: TPanel
      Width = 761
      Height = 65
      Visible = True
      object lblDocumentType: TLabel [0]
        Left = 315
        Top = 12
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCustomer: TLabel [1]
        Left = 292
        Top = 40
        Width = 61
        Height = 13
        Alignment = taRightJustify
        Caption = 'Customer :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDocumentNumber: TLabel [2]
        Left = 541
        Top = 12
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Number :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDocumentStatus: TLabel [3]
        Left = 23
        Top = 40
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Status :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbFrom: TLabel [4]
        Left = 32
        Top = 12
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'From :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbTo: TLabel [5]
        Left = 164
        Top = 12
        Width = 16
        Height = 13
        Alignment = taRightJustify
        Caption = 'To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited pblGO: TPanel
        Left = 680
        Height = 65
        Visible = True
        inherited pnlAviso: TPanel
          Top = 15
          inherited btnExec: TSpeedButton
            Height = 27
            OnClick = btnExecClick
          end
        end
      end
      object scDocumentType: TSuperComboADO
        Left = 356
        Top = 8
        Width = 161
        Height = 21
        TabOrder = 4
        OnChange = dbxDateIniChange
        LookUpSource = DM.dsLookUpDocumentType
        MostraDesativado = STD_AMBOSDESATIVADO
        MostraHidden = STD_AMBOSHIDDEN
        IDLanguage = 0
      end
      object scCustomer: TSuperComboADO
        Left = 356
        Top = 36
        Width = 161
        Height = 21
        TabOrder = 5
        OnChange = dbxDateIniChange
        LookUpSource = DM.dsLookUpCustomer
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object edtDocumentNumber: TEdit
        Left = 596
        Top = 8
        Width = 85
        Height = 21
        TabOrder = 6
        OnChange = dbxDateIniChange
      end
      object cbxDocumentStatus: TComboBox
        Left = 72
        Top = 36
        Width = 201
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'All'
        OnChange = dbxDateIniChange
        Items.Strings = (
          'All'
          'Created'
          'Signed for the customer'
          'Waiting sending'
          'Sent'
          'Received'
          'Filed')
      end
      object dbxDateIni: TDateBox
        Left = 72
        Top = 8
        Width = 85
        Height = 21
        TabOrder = 1
        OnChange = dbxDateIniChange
        InputTime = False
        Language = Portuguese
      end
      object dbxDateFim: TDateBox
        Left = 188
        Top = 8
        Width = 85
        Height = 21
        TabOrder = 2
        OnChange = dbxDateIniChange
        InputTime = False
        Language = Portuguese
      end
    end
    inherited pnlButton: TPanelRights
      Left = 648
      Top = 65
      Height = 385
      inherited imgFolder: TImage
        Top = 315
      end
      inherited ImgTrash: TImage
        Top = 350
      end
    end
    inherited pnlMainBrowse: TPanel
      Top = 65
      Width = 648
      Height = 385
      inherited pnlPage: TPanel
        Top = 366
        Width = 648
        inherited pnlDivisor: TPanel
          Width = 648
        end
      end
      inherited pnlGenFilter: TPanel
        Width = 648
        inherited lblGenFilter: TLabel
          Width = 648
        end
      end
      inherited grdBrowse: TcxGrid
        Width = 648
        Height = 338
        inherited grdBrowseDB: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDMovDocument'
          object grdBrowseDBIDMovDocument: TcxGridDBColumn
            DataBinding.FieldName = 'IDMovDocument'
            Visible = False
          end
          object grdBrowseDBDocumentNumber: TcxGridDBColumn
            Caption = 'Number'
            DataBinding.FieldName = 'DocumentNumber'
          end
          object grdBrowseDBDocumentDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'DocumentDate'
          end
          object grdBrowseDBDocumentStatusDesc: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'DocumentStatusDesc'
          end
          object grdBrowseDBDocumentType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'DocumentType'
          end
          object grdBrowseDBCustomer: TcxGridDBColumn
            DataBinding.FieldName = 'Customer'
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_BrwMovDocument.sil'
    Left = 26
    Top = 173
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A73744D756C74694C696E65730D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E670101010D
      0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01496E66
      6F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D
      0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101
      010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641626F72
      740101010D0A5265747279012652657472790101010D0A49676E6F7265012649
      676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C
      014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965732074
      6F2026416C6C0101010D0A48656C70012648656C700101010D0A737453747269
      6E67730D0A73744F74686572537472696E67730D0A717542726F7773652E436F
      6D6D616E6454657874010101010D0A717542726F7773652E436F6E6E65637469
      6F6E537472696E67010101010D0A717542726F7773652E46696C746572010101
      010D0A717542726F7773652E496E6465784669656C644E616D6573010101010D
      0A717542726F7773652E496E6465784E616D65010101010D0A717542726F7773
      652E4B65794669656C6473010101010D0A717542726F7773652E4D6173746572
      4669656C6473010101010D0A42726F777365436F6E6669672E44656661756C74
      427574746F6E01627444657461696C0101010D0A42726F777365436F6E666967
      2E466368436C6173734E616D65010101010D0A42726F777365436F6E6669672E
      5669657744656C6574655461626C65010101010D0A53442E44656661756C7445
      7874012A2E786C730101010D0A53442E46696C654E616D65010101010D0A5344
      2E46696C746572014D6963726F736F667420457863656C7C2A2E786C73010101
      0D0A53442E496E697469616C44697201433A5C0101010D0A53442E5469746C65
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
      0101010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A}
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'SELECT'#13#10#9'IMD.IDMovDocument,'#13#10#9'IMD.DocumentNumber,'#13#10#9'IMD.Document' +
      'Date,'#13#10#9'IMD.DocumentStatus,'#13#10#9'D.DocumentType,'#13#10#9'C.Pessoa Custome' +
      'r'#13#10'FROM'#13#10#9'Inv_MovDocument IMD (NOLOCK)'#13#10#9'JOIN Mnt_DocumentType D' +
      ' (NOLOCK) ON (IMD.IDDocumentType = D.IDDocumentType)'#13#10#9'LEFT JOIN' +
      ' PreInventoryMov PIM (NOLOCK) ON (IMD.IDPreInventoryMov = PIM.ID' +
      'PreInventoryMov)'#13#10#9'LEFT JOIN InventoryMov IM (NOLOCK) ON (IMD.ID' +
      'InventoryMov = IM.IDInventoryMov)'#13#10#9'LEFT JOIN Pessoa C (NOLOCK) ' +
      'ON (PIM.IDPessoa = C.IDPessoa OR IM.IDPessoa = C.IDPessoa)'#13#10
    object quBrowseIDMovDocument: TIntegerField
      FieldName = 'IDMovDocument'
    end
    object quBrowseDocumentNumber: TStringField
      FieldName = 'DocumentNumber'
    end
    object quBrowseDocumentDate: TDateTimeField
      FieldName = 'DocumentDate'
    end
    object quBrowseDocumentStatus: TIntegerField
      FieldName = 'DocumentStatus'
    end
    object quBrowseDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object quBrowseCustomer: TStringField
      FieldName = 'Customer'
      Size = 50
    end
    object quBrowseDocumentStatusDesc: TStringField
      FieldKind = fkCalculated
      FieldName = 'DocumentStatusDesc'
      Size = 40
      Calculated = True
    end
  end
  inherited BrowseConfig: TBrowseConfig
    MostraDesativado = STD_AMBOSDESATIVADO
    MostraHidden = STD_AMBOSHIDDEN
    AutoOpen = False
    CheckSystemOnDelete = False
    RealDeletion = True
    FchClassName = 'TFchMovDocument'
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 39297.608015578710000000
      PrinterPage.Footer = 10
      PrinterPage.Header = 5
      PrinterPage.Margins.Bottom = 20
      PrinterPage.Margins.Left = 20
      PrinterPage.Margins.Right = 20
      PrinterPage.Margins.Top = 20
      PrinterPage.PageSize.X = 326
      PrinterPage.PageSize.Y = 460
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
