inherited brwPurchase: TbrwPurchase
  Left = 325
  Top = 88
  Width = 765
  Height = 570
  Caption = 'brwPurchase'
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 757
    inherited Image1: TImage
      Width = 530
    end
    inherited lblMenu: TLabel
      Left = 526
    end
    inherited EspacamentoSuperior: TPanel
      Width = 757
      inherited EEE: TPanel
        Width = 757
      end
    end
  end
  inherited Panel1: TPanel
    Top = 502
    Width = 757
    inherited EspacamentoInferior: TPanel
      Width = 757
      inherited Panel3: TPanel
        Width = 757
      end
    end
    inherited hhh: TPanel
      Left = 609
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 468
  end
  inherited EspacamentoDireito: TPanel
    Left = 757
    Height = 468
  end
  inherited pnlMain: TPanel
    Width = 757
    Height = 468
    inherited pnlBasicFilter: TPanel
      Width = 757
      Height = 58
      Visible = True
      object Label2: TLabel [0]
        Left = 34
        Top = 33
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vendor :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel [1]
        Left = 43
        Top = 7
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited pblGO: TPanel
        Left = 405
        Width = 352
        Height = 58
        Visible = True
        object Label1: TLabel [0]
          Left = 14
          Top = 7
          Width = 36
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbFrom: TLabel [1]
          Left = 16
          Top = 32
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
        object lbTo: TLabel [2]
          Left = 167
          Top = 32
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
        inherited pnlAviso: TPanel
          Left = 276
          Top = 11
          inherited btnExec: TSpeedButton
            OnClick = btnExecClick
          end
        end
        object cbxDate: TComboBox
          Left = 53
          Top = 3
          Width = 214
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'Receiving'
            'Final Receiving')
        end
        object DateInicio: TDateBox
          Left = 54
          Top = 28
          Width = 91
          Height = 21
          TabOrder = 2
          OnChange = DateInicioChange
          InputTime = False
          Language = Portuguese
        end
        object DateFim: TDateBox
          Left = 185
          Top = 28
          Width = 82
          Height = 21
          TabOrder = 3
          OnChange = DateInicioChange
          InputTime = False
          Language = Portuguese
        end
      end
      object scVendor: TSuperComboADO
        Left = 85
        Top = 29
        Width = 189
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '<-->'
        LookUpSource = DM.dsLookUpFornecedor
        DropDownRows = 18
        ShowBtnAddNew = False
        IDLanguage = 0
        OnSelectItem = scVendorSelectItem
      end
      object scStore: TSuperComboADO
        Left = 85
        Top = 3
        Width = 189
        Height = 21
        TabOrder = 2
        Text = '<-->'
        CodeLength = 5
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
        OnSelectItem = scStoreSelectItem
      end
      object btAreaTodas: TButton
        Left = 278
        Top = 4
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 3
        OnClick = btAreaTodasClick
      end
      object Button1: TButton
        Left = 279
        Top = 30
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 4
        OnClick = Button1Click
      end
    end
    inherited pnlButton: TPanelRights
      Left = 644
      Top = 58
      Height = 410
      inherited btRemove: TSpeedButton
        OnClick = btRemoveClick
      end
      inherited imgFolder: TImage
        Top = 340
      end
      inherited ImgTrash: TImage
        Top = 375
      end
      object btnPrintPurchase: TSpeedButton [11]
        Left = 2
        Top = 222
        Width = 111
        Height = 26
        Caption = 'Print'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btnPrintPurchaseClick
      end
      object Panel: TPanel
        Left = 11
        Top = 218
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
    inherited pnlMainBrowse: TPanel
      Top = 58
      Width = 644
      Height = 410
      inherited pnlPage: TPanel
        Top = 391
        Width = 644
        inherited pnlDivisor: TPanel
          Width = 644
        end
      end
      inherited pnlGenFilter: TPanel
        Width = 644
        inherited lblGenFilter: TLabel
          Width = 644
        end
      end
      inherited grdBrowse: TcxGrid
        Width = 644
        Height = 363
        inherited grdBrowseDB: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPurchase'
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = grdBrowseDBTotal
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Freight'
              Column = grdBrowseDBFreight
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'OtherCharges'
              Column = grdBrowseDBOtherCharges
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'SubTotalCounted'
              Column = grdBrowseDBSubTotalCounted
            end>
          object grdBrowseDBIDPurchase: TcxGridDBColumn
            DataBinding.FieldName = 'IDPurchase'
            Width = 65
          end
          object grdBrowseDBDatePreReceiving: TcxGridDBColumn
            DataBinding.FieldName = 'DatePreReceiving'
            Width = 102
          end
          object grdBrowseDBUserPreReceive: TcxGridDBColumn
            Caption = 'Received By'
            DataBinding.FieldName = 'UserPreReceive'
            Visible = False
          end
          object grdBrowseDBDateFinalReceiving: TcxGridDBColumn
            DataBinding.FieldName = 'DateFinalReceiving'
            Visible = False
          end
          object grdBrowseDBUserFinalReceive: TcxGridDBColumn
            DataBinding.FieldName = 'UserFinalReceive'
            Visible = False
          end
          object grdBrowseDBVendorCode: TcxGridDBColumn
            DataBinding.FieldName = 'VendorCode'
            Width = 72
          end
          object grdBrowseDBVendor: TcxGridDBColumn
            DataBinding.FieldName = 'Vendor'
            Width = 155
          end
          object grdBrowseDBOtherCharges: TcxGridDBColumn
            Caption = 'Other Charges'
            DataBinding.FieldName = 'OtherCharges'
            Visible = False
          end
          object grdBrowseDBSubTotal: TcxGridDBColumn
            DataBinding.FieldName = 'SubTotal'
            Visible = False
            Width = 51
          end
          object grdBrowseDBFreight: TcxGridDBColumn
            DataBinding.FieldName = 'Freight'
            Visible = False
          end
          object grdBrowseDBStore: TcxGridDBColumn
            DataBinding.FieldName = 'Store'
            Width = 98
          end
          object grdBrowseDBTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            Width = 90
          end
          object grdBrowseDBDocumentType: TcxGridDBColumn
            DataBinding.FieldName = 'DocumentType'
            Visible = False
          end
          object grdBrowseDBDocumentNumber: TcxGridDBColumn
            DataBinding.FieldName = 'DocumentNumber'
            Visible = False
          end
          object grdBrowseDBDocumentDate: TcxGridDBColumn
            DataBinding.FieldName = 'DocumentDate'
            Visible = False
          end
          object grdBrowseDBDocumentDueDate: TcxGridDBColumn
            DataBinding.FieldName = 'DocumentDueDate'
            Visible = False
          end
          object grdBrowseDBDocumentTotal: TcxGridDBColumn
            DataBinding.FieldName = 'DocumentTotal'
            Visible = False
          end
          object grdBrowseDBIDPO: TcxGridDBColumn
            DataBinding.FieldName = 'IDPO'
            Visible = False
          end
          object grdBrowseDBCFOP: TcxGridDBColumn
            DataBinding.FieldName = 'CFOP'
            Visible = False
            Options.Filtering = False
          end
          object grdBrowseDBCFOPNum: TcxGridDBColumn
            DataBinding.FieldName = 'CFOPNum'
            Visible = False
            Options.Filtering = False
          end
          object grdBrowseDBDiscount: TcxGridDBColumn
            DataBinding.FieldName = 'Discount'
            Visible = False
            Options.Filtering = False
          end
          object grdBrowseDBSubTotalCounted: TcxGridDBColumn
            Caption = 'Subtotal Received'
            DataBinding.FieldName = 'SubTotalCounted'
            Width = 52
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_brwPurchase.sil'
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
      6E67730D0A73744F74686572537472696E67730D0A67726442726F7773652E49
      6E6946696C654E616D65010101010D0A67726442726F7773652E496E69536563
      74696F6E4E616D65010101010D0A67726442726F7773652E4B65794669656C64
      010101010D0A67726442726F7773652E507265766965774669656C644E616D65
      010101010D0A67726442726F7773652E52656769737472795061746801010101
      0D0A67726442726F7773652E53756D6D617279536570617261746F72012C2001
      01010D0A717542726F7773652E436F6D6D616E6454657874010101010D0A7175
      42726F7773652E436F6E6E656374696F6E537472696E67010101010D0A717542
      726F7773652E46696C746572010101010D0A717542726F7773652E496E646578
      4669656C644E616D6573010101010D0A717542726F7773652E4B65794669656C
      6473010101010D0A42726F777365436F6E6669672E44656661756C7442757474
      6F6E01627444657461696C0101010D0A42726F777365436F6E6669672E466368
      436C6173734E616D65010101010D0A42726F777365436F6E6669672E56696577
      44656C6574655461626C65010101010D0A53442E46696C746572014D6963726F
      736F667420457863656C7C2A2E786C730101010D0A53442E5469746C65010101
      010D0A73744C6F63616C65730D0A43757272656E637920537472696E67012401
      01010D0A54686F7573616E6420536570617261746F72012C0101010D0A446563
      696D616C20536570617261746F72012E0101010D0A4461746520536570617261
      746F72012F0101010D0A53686F7274204461746520466F726D6174014D2F642F
      797979790101010D0A4C6F6E67204461746520466F726D617401646464642C20
      4D4D4D4D2064642C20797979790101010D0A54696D6520536570617261746F72
      013A0101010D0A54696D6520414D20537472696E6701414D0101010D0A54696D
      6520504D20537472696E6701504D0101010D0A53686F72742054696D6520466F
      726D617401683A6D6D20414D504D0101010D0A4C6F6E672054696D6520466F72
      6D617401683A6D6D3A737320414D504D0101010D0A53686F7274204D6F6E7468
      204E616D6573014A616E2C4665622C4D61722C4170722C4D61792C4A756E2C4A
      756C2C4175672C5365702C4F63742C4E6F762C4465630101010D0A4C6F6E6720
      4D6F6E7468204E616D6573014A616E756172792C46656272756172792C4D6172
      63682C417072696C2C4D61792C4A756E652C4A756C792C4175677573742C5365
      7074656D6265722C4F63746F6265722C4E6F76656D6265722C446563656D6265
      720101010D0A53686F727420446179204E616D65730153756E2C4D6F6E2C5475
      652C5765642C5468752C4672692C5361740101010D0A4C6F6E6720446179204E
      616D65730153756E6461792C4D6F6E6461792C547565736461792C5765646E65
      736461792C54687572736461792C4672696461792C5361747572646179010101
      0D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A}
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT PU.IDPurchase'#13#10',PU.DatePreReceiving'#13#10',PU.DateFinalReceivi' +
      'ng'#13#10',PE.Code as VendorCode'#13#10',   PE.Pessoa as Vendor'#13#10',   PT.SubT' +
      'otal'#13#10',   PU.OtherCharges'#13#10',   PU.Freight'#13#10',   PU.IDPO'#13#10',   IsNu' +
      'll(PU.Discount,0) as Discount'#13#10',   S.Name as Store'#13#10',   (PT.SubT' +
      'otal + PU.OtherCharges + PU.Freight - IsNull(PU.Discount,0))  as' +
      ' Total'#13#10',   SU.SystemUser as UserPreReceive'#13#10',   SUF.SystemUser ' +
      'as UserFinalReceive'#13#10',           PU.DocumentType'#13#10',           PU' +
      '.DocumentNumber'#13#10',           PU.DocumentDate'#13#10',           PU.Doc' +
      'umentDueDate'#13#10',           PU.DocumentTotal'#13#10',   CFOP.Number as C' +
      'FOPNum'#13#10',   CFOP.Description as CFOP '#13#10',   isnull(Scaned.SubTota' +
      'lCounted, 0) as SubTotalCounted'#13#10'FROM Pur_Purchase PU (NOLOCK)  ' +
      ' '#13#10'JOIN Pessoa PE (NOLOCK) ON (PU.IDFornecedor = PE.IDPessoa)   ' +
      #13#10'JOIN Store S (NOLOCK) ON (S.IDStore = PU.IDStore)   '#13#10'LEFT JOI' +
      'N SystemUser SU (NOLOCK) ON ( PU.IDUserPreReceiving = SU.IDUser ' +
      ')   '#13#10'LEFT JOIN SystemUser SUF (NOLOCK) ON ( PU.IDUserFinalRecei' +
      'ving = SUF.IDUser )           '#13#10'LEFT JOIN Pur_PurchaseTotal PT (' +
      'NOLOCK) ON (PU.IDPurchase = PT.IDPurchase)   '#13#10'LEFT JOIN Mnt_CFO' +
      'P CFOP (NOLOCK) ON (CFOP.IDCFOP = PU.IDCFOP) '#13#10'left join ( selec' +
      't SUM(ppv.QtyCounted * ppi.NewCostPrice) as SubTotalCounted, ppv' +
      '.IDPurchase'#13#10'            from Pur_PurchaseVerify ppv '#13#10'         ' +
      '   join Pur_PurchaseItem ppi on ppv.IDPurchase = ppi.IDPurchase ' +
      'and ppv.IDModel = ppi.IDModel'#13#10'            group by ppv.IDPurcha' +
      'se) Scaned on pu.IDPurchase = Scaned.IDPurchase '#13#10' '#13#10' '#13#10' '#13#10
    Left = 212
    Top = 174
    object quBrowseIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object quBrowseDatePreReceiving: TDateTimeField
      FieldName = 'DatePreReceiving'
    end
    object quBrowseDateFinalReceiving: TDateTimeField
      FieldName = 'DateFinalReceiving'
    end
    object quBrowseVendorCode: TIntegerField
      FieldName = 'VendorCode'
    end
    object quBrowseVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quBrowseSubTotal: TBCDField
      FieldName = 'SubTotal'
      Precision = 19
    end
    object quBrowseOtherCharges: TBCDField
      FieldName = 'OtherCharges'
      Precision = 19
    end
    object quBrowseFreight: TBCDField
      FieldName = 'Freight'
      Precision = 19
    end
    object quBrowseIDPO: TIntegerField
      FieldName = 'IDPO'
    end
    object quBrowseDiscount: TBCDField
      FieldName = 'Discount'
      ReadOnly = True
      Precision = 19
    end
    object quBrowseStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quBrowseTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseUserPreReceive: TStringField
      FieldName = 'UserPreReceive'
      Size = 50
    end
    object quBrowseUserFinalReceive: TStringField
      FieldName = 'UserFinalReceive'
      Size = 50
    end
    object quBrowseDocumentType: TStringField
      FieldName = 'DocumentType'
    end
    object quBrowseDocumentNumber: TStringField
      FieldName = 'DocumentNumber'
    end
    object quBrowseDocumentDate: TDateTimeField
      FieldName = 'DocumentDate'
    end
    object quBrowseDocumentDueDate: TDateTimeField
      FieldName = 'DocumentDueDate'
    end
    object quBrowseDocumentTotal: TBCDField
      FieldName = 'DocumentTotal'
      Precision = 19
    end
    object quBrowseCFOPNum: TStringField
      FieldName = 'CFOPNum'
      Size = 15
    end
    object quBrowseCFOP: TStringField
      FieldName = 'CFOP'
      Size = 30
    end
    object quBrowseSubTotalCounted: TBCDField
      FieldName = 'SubTotalCounted'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
  end
  inherited BrowseConfig: TBrowseConfig
    MostraDesativado = STD_AMBOSDESATIVADO
    MostraHidden = STD_AMBOSHIDDEN
    AutoOpen = False
    CheckSystemOnDelete = False
    RealDeletion = True
  end
  inherited SD: TSaveDialog
    Left = 383
    Top = 207
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37946.721032662040000000
      PrinterPage.Footer = 9220
      PrinterPage.Header = 508
      PrinterPage.Margins.Bottom = 322580
      PrinterPage.Margins.Left = 322580
      PrinterPage.Margins.Right = 322580
      PrinterPage.Margins.Top = 322580
      PrinterPage.PageSize.X = 5334178
      PrinterPage.PageSize.Y = 7543851
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
    end
  end
  object spRemove: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Purchase_Remove;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
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
      end>
    Left = 492
    Top = 277
  end
  object quQuitacao: TADOQuery
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
      #9'L.IDLancamento,'
      #9'Q.IDQuitacao'
      'FROM'
      #9'Fin_Lancamento L'
      
        '        JOIN Fin_LancQuit LQ ON (L.IDLancamento = LQ.IDLancament' +
        'o)'
      '        JOIN Fin_Quitacao Q ON (LQ.IDQuitacao = Q.IDQuitacao)'
      'WHERE'
      #9'L.IDPurchase = :IDPurchase'
      ' '
      ' ')
    Left = 490
    Top = 226
  end
end
