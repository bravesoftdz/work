inherited SubHoldPayments: TSubHoldPayments
  Width = 415
  Height = 276
  Caption = 'Payments'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object grdBrowse: TcxGrid [0]
    Left = 0
    Top = 107
    Width = 407
    Height = 142
    Align = alClient
    PopupMenu = popBrowse
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object grdBrowseDB: TcxGridDBTableView
      DataController.DataSource = dsPayment
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDLancamento'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ValorNominal'
          Column = grdBrowseDBValorNominal
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdBrowseDBImageIndex: TcxGridDBColumn
        Caption = ' '
        DataBinding.FieldName = 'ImageIndex'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = DMGlobal.imgPayments
        Properties.Items = <
          item
            ImageIndex = 0
            Value = 0
          end
          item
            ImageIndex = 1
            Value = 1
          end
          item
            ImageIndex = 2
            Value = 2
          end
          item
            ImageIndex = 3
            Value = 3
          end
          item
            ImageIndex = 4
            Value = 4
          end
          item
            ImageIndex = 5
            Value = 5
          end
          item
            ImageIndex = 6
            Value = 6
          end
          item
            ImageIndex = 7
            Value = 7
          end
          item
            ImageIndex = 8
            Value = 8
          end
          item
            ImageIndex = 9
            Value = 9
          end
          item
            ImageIndex = 10
            Value = 10
          end
          item
            ImageIndex = 11
            Value = 11
          end
          item
            ImageIndex = 12
            Value = 12
          end
          item
            ImageIndex = 13
            Value = 13
          end
          item
            ImageIndex = 14
            Value = 14
          end
          item
            ImageIndex = 15
            Value = 15
          end>
        Properties.LargeImages = DMGlobal.imgPayments
        Properties.ReadOnly = True
        Properties.ShowDescriptions = False
        Width = 31
      end
      object grdBrowseDBMeioPag: TcxGridDBColumn
        Caption = 'PaymentType'
        DataBinding.FieldName = 'MeioPag'
        Width = 120
      end
      object grdBrowseDBPayPlace: TcxGridDBColumn
        Caption = 'Payment Place'
        DataBinding.FieldName = 'PayPlace'
        Width = 90
      end
      object grdBrowseDBDataVencimento: TcxGridDBColumn
        DataBinding.FieldName = 'DataVencimento'
        Width = 91
      end
      object grdBrowseDBValorNominal: TcxGridDBColumn
        DataBinding.FieldName = 'ValorNominal'
        HeaderAlignmentHorz = taRightJustify
        Width = 73
      end
      object grdBrowseDBHistorico: TcxGridDBColumn
        DataBinding.FieldName = 'Historico'
        Visible = False
      end
    end
    object grdBrowseLevel: TcxGridLevel
      GridView = grdBrowseDB
    end
  end
  object pnlPaymentDetail: TPanel [1]
    Left = 0
    Top = 0
    Width = 407
    Height = 107
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object lbCheckNum: TLabel
      Left = 13
      Top = 34
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Number :'
      FocusControl = DBEdit4
    end
    object lbBank: TLabel
      Left = 25
      Top = 9
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bank :'
    end
    object lbHistory: TLabel
      Left = 9
      Top = 59
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Historico :'
      FocusControl = DBMemo1
    end
    object lbDoc: TLabel
      Left = 232
      Top = 34
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'Doc :'
      FocusControl = DBEdit6
    end
    object lbPhone: TLabel
      Left = 221
      Top = 59
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Phone :'
      FocusControl = DBEdit7
    end
    object lbCustomer: TLabel
      Left = 208
      Top = 10
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Customer :'
      FocusControl = DBEdit8
    end
    object DBEdit4: TDBEdit
      Left = 60
      Top = 31
      Width = 133
      Height = 21
      TabStop = False
      Color = clScrollBar
      DataField = 'CheckNumber'
      DataSource = dsPayment
      ReadOnly = True
      TabOrder = 0
    end
    object DBMemo1: TDBMemo
      Left = 60
      Top = 59
      Width = 133
      Height = 46
      TabStop = False
      Color = clScrollBar
      DataField = 'Historico'
      DataSource = dsPayment
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit6: TDBEdit
      Left = 264
      Top = 31
      Width = 114
      Height = 21
      TabStop = False
      Color = clScrollBar
      DataField = 'CustomerDocument'
      DataSource = dsPayment
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit7: TDBEdit
      Left = 264
      Top = 59
      Width = 115
      Height = 21
      TabStop = False
      Color = clScrollBar
      DataField = 'CustomerPhone'
      DataSource = dsPayment
      ReadOnly = True
      TabOrder = 3
    end
    object DBEdit8: TDBEdit
      Left = 264
      Top = 4
      Width = 114
      Height = 21
      TabStop = False
      Color = clScrollBar
      DataField = 'CustomerName'
      DataSource = dsPayment
      ReadOnly = True
      TabOrder = 4
    end
    object scBankEdit: TSuperComboADO
      Left = 60
      Top = 5
      Width = 133
      Height = 21
      Color = clMenuBar
      ReadOnly = True
      TabOrder = 5
      Text = 'scBankEdit'
      LookUpSource = DM.dsLookUpBank
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      ShowBtnSelecao = False
      IDLanguage = 0
    end
  end
  object dsPayment: TDataSource [2]
    DataSet = quPayment
    OnDataChange = dsPaymentDataChange
    Left = 178
    Top = 16
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubHoldPayments.sil'
    TranslationData = {
      737443617074696F6E730D0A54537562486F6C645061796D656E747301506179
      6D656E74730101010D0A67726442726F7773654442496D616765496E64657801
      200101010D0A67726442726F77736544424D65696F506167015061796D656E74
      547970650101010D0A67726442726F77736544424461746156656E63696D656E
      746F014461746156656E63696D656E746F0101010D0A67726442726F77736544
      42486973746F7269636F01486973746F7269636F0101010D0A67726442726F77
      7365444256616C6F724E6F6D696E616C0156616C6F724E6F6D696E616C010101
      0D0A67726442726F7773654C6576656C010101010D0A706E6C5061796D656E74
      44657461696C010101010D0A6C62436865636B4E756D014E756D626572203A01
      01010D0A6C6242616E6B0142616E6B203A0101010D0A6C62486973746F727901
      486973746F7269636F203A0101010D0A6C62446F6301446F63203A0101010D0A
      6C6250686F6E650150686F6E65203A0101010D0A6C62437573746F6D65720143
      7573746F6D6572203A0101010D0A6D6E7544656C6574655061796D656E740144
      656C657465205061796D656E74014578636C75697220506167616D656E746F01
      4F626C697465726172205061676F010D0A737448696E74730D0A54537562486F
      6C645061796D656E747301010D0A67726442726F777365010101010D0A706E6C
      5061796D656E7444657461696C010101010D0A6C62436865636B4E756D010101
      010D0A6C6242616E6B010101010D0A6C62486973746F7279010101010D0A6C62
      446F63010101010D0A6C6250686F6E65010101010D0A6C62437573746F6D6572
      010101010D0A44424564697434010101010D0A44424D656D6F31010101010D0A
      44424564697436010101010D0A44424564697437010101010D0A444245646974
      38010101010D0A736342616E6B45646974010101010D0A6D6E7544656C657465
      5061796D656E74010101010D0A7374446973706C61794C6162656C730D0A7374
      466F6E74730D0A54537562486F6C645061796D656E7473014D532053616E7320
      53657269660101010D0A73744D756C74694C696E65730D0A736342616E6B4564
      69742E46696C7465724669656C6473010101010D0A736342616E6B456469742E
      46696C74657256616C756573010101010D0A7374446C677343617074696F6E73
      0D0A5761726E696E67015761726E696E670101010D0A4572726F72014572726F
      720101010D0A496E666F726D6174696F6E01496E666F726D6174696F6E010101
      0D0A436F6E6669726D01436F6E6669726D0101010D0A59657301265965730101
      010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63656C0143
      616E63656C0101010D0A41626F7274012641626F72740101010D0A5265747279
      012652657472790101010D0A49676E6F7265012649676E6F72650101010D0A41
      6C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F20746F20416C6C
      0101010D0A59657320546F20416C6C0159657320746F2026416C6C0101010D0A
      48656C70012648656C700101010D0A7374537472696E67730D0A73744F746865
      72537472696E67730D0A54537562486F6C645061796D656E74732E48656C7046
      696C65010101010D0A67726442726F7773654442496D616765496E6465782E50
      726F70657274696573436C6173734E616D6501546378496D616765436F6D626F
      426F7850726F706572746965730101010D0A67726442726F77736544424D6569
      6F5061672E50726F70657274696573436C6173734E616D65010101010D0A6772
      6442726F77736544424461746156656E63696D656E746F2E50726F7065727469
      6573436C6173734E616D65010101010D0A67726442726F777365444248697374
      6F7269636F2E50726F70657274696573436C6173734E616D65010101010D0A67
      726442726F777365444256616C6F724E6F6D696E616C2E50726F706572746965
      73436C6173734E616D65010101010D0A444245646974342E446174614669656C
      6401436865636B4E756D6265720101010D0A44424D656D6F312E446174614669
      656C6401486973746F7269636F0101010D0A444245646974362E446174614669
      656C6401437573746F6D6572446F63756D656E740101010D0A44424564697437
      2E446174614669656C6401437573746F6D657250686F6E650101010D0A444245
      646974382E446174614669656C6401437573746F6D65724E616D650101010D0A
      736342616E6B456469742E4F74686572436F6C756D6E73010101010D0A736342
      616E6B456469742E5370635768657265436C61757365010101010D0A73634261
      6E6B456469742E5465787401736342616E6B456469740101010D0A73744C6F63
      616C65730D0A43757272656E637920537472696E6701240101010D0A54686F75
      73616E6420536570617261746F72012C0101010D0A446563696D616C20536570
      617261746F72012E0101010D0A4461746520536570617261746F72012F010101
      0D0A53686F7274204461746520466F726D6174014D2F642F797979790101010D
      0A4C6F6E67204461746520466F726D617401646464642C204D4D4D4D2064642C
      20797979790101010D0A54696D6520536570617261746F72013A0101010D0A54
      696D6520414D20537472696E6701414D0101010D0A54696D6520504D20537472
      696E6701504D0101010D0A53686F72742054696D6520466F726D617401683A6D
      6D20414D504D0101010D0A4C6F6E672054696D6520466F726D617401683A6D6D
      3A737320414D504D0101010D0A53686F7274204D6F6E7468204E616D6573014A
      616E2C4665622C4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C53
      65702C4F63742C4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E61
      6D6573014A616E756172792C46656272756172792C4D617263682C417072696C
      2C4D61792C4A756E652C4A756C792C4175677573742C53657074656D6265722C
      4F63746F6265722C4E6F76656D6265722C446563656D6265720101010D0A5368
      6F727420446179204E616D65730153756E2C4D6F6E2C5475652C5765642C5468
      752C4672692C5361740101010D0A4C6F6E6720446179204E616D65730153756E
      6461792C4D6F6E6461792C547565736461792C5765646E65736461792C546875
      72736461792C4672696461792C53617475726461790101010D0A7374436F6C6C
      656374696F6E730D0A737443686172536574730D0A54537562486F6C64506179
      6D656E74730144454641554C545F434841525345540101010D0A}
  end
  object popBrowse: TPopupMenu
    OnPopup = popBrowsePopup
    Left = 30
    Top = 152
    object mnuDeletePayment: TMenuItem
      Caption = 'Delete Payment'
      OnClick = mnuDeletePaymentClick
    end
    object munPrintBillter: TMenuItem
      Caption = 'Print Billet'
      Visible = False
      OnClick = munPrintBillterClick
    end
  end
  object spPreSaleDeleteSingleDelayPayment: TADOStoredProc
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    ProcedureName = 'sp_PreSale_DeleteSingleDelayPayment;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDLancamento'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 160
    Top = 96
  end
  object quPayment: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quPaymentAfterOpen
    OnCalcFields = quPaymentCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        MP.IDMeioPag,'
      '        MP.MeioPag,'
      '        MP.ImageIndex,'
      '        MP.PrintBankBillet,'
      '        L.ValorNominal,'
      '        L.DataVencimento,'
      '        L.IDQuitacaoMeioPrevisto ,'
      '        L.IDLancamentoTipo,'
      '        L.IDDocumentoTipo,'
      '        L.IDPreSale,'
      '        L.CheckNumber,'
      '        L.IDBankCheck,'
      '        L.CustomerDocument,'
      '        L.CustomerName,'
      '        L.CustomerPhone,'
      '        L.Historico,'
      '        L.IDLancamento,'
      '        L.IDCashRegMovClosed,'
      '        L.PaymentPlace'
      'FROM'
      '        Fin_Lancamento L (NOLOCK)'
      
        '        Join MeioPag MP (NOLOCK) on ( L.IDQuitacaoMeioPrevisto =' +
        ' MP.IDMeioPag )'
      'ORDER BY'
      '        MP.IDMeioPag'
      ' '
      ' ')
    Left = 108
    Top = 11
    object quPaymentIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
      Origin = 'RETAIL.MeioPag.IDMeioPag'
    end
    object quPaymentMeioPag: TStringField
      DisplayLabel = 'Payment Type'
      FieldName = 'MeioPag'
      Origin = 'RETAIL.MeioPag.MeioPag'
      Size = 50
    end
    object quPaymentValorNominal: TFloatField
      DisplayLabel = 'Amount'
      FieldName = 'ValorNominal'
      Origin = 'RETAIL.Fin_Lancamento.ValorNominal'
      DisplayFormat = '#,##0.00'
    end
    object quPaymentDataVencimento: TDateTimeField
      DisplayLabel = 'Due Date'
      FieldName = 'DataVencimento'
      Origin = 'RETAIL.Fin_Lancamento.DataVencimento'
    end
    object quPaymentIDQuitacaoMeioPrevisto: TIntegerField
      FieldName = 'IDQuitacaoMeioPrevisto'
      Origin = 'RETAIL.Fin_Lancamento.IDQuitacaoMeioPrevisto'
    end
    object quPaymentIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
      Origin = 'RETAIL.Fin_Lancamento.IDLancamentoTipo'
    end
    object quPaymentIDDocumentoTipo: TIntegerField
      FieldName = 'IDDocumentoTipo'
      Origin = 'RETAIL.Fin_Lancamento.IDDocumentoTipo'
    end
    object quPaymentIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
      Origin = 'RETAIL.Fin_Lancamento.IDPreSale'
    end
    object quPaymentCheckNumber: TStringField
      FieldName = 'CheckNumber'
    end
    object quPaymentIDBankCheck: TIntegerField
      FieldName = 'IDBankCheck'
    end
    object quPaymentCustomerDocument: TStringField
      FieldName = 'CustomerDocument'
    end
    object quPaymentCustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 80
    end
    object quPaymentCustomerPhone: TStringField
      FieldName = 'CustomerPhone'
    end
    object quPaymentHistorico: TMemoField
      FieldName = 'Historico'
      BlobType = ftMemo
    end
    object quPaymentImageIndex: TIntegerField
      FieldName = 'ImageIndex'
    end
    object quPaymentIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quPaymentIDCashRegMovClosed: TIntegerField
      FieldName = 'IDCashRegMovClosed'
    end
    object quPaymentPaymentPlace: TIntegerField
      FieldName = 'PaymentPlace'
    end
    object quPaymentPayPlace: TStringField
      FieldKind = fkCalculated
      FieldName = 'PayPlace'
      Calculated = True
    end
    object quPaymentPrintBankBillet: TBooleanField
      FieldName = 'PrintBankBillet'
    end
  end
  object quEstimated: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quEstimatedAfterOpen
    OnCalcFields = quEstimatedCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        MP.IDMeioPag,'
      '        MP.MeioPag,'
      '        MP.ImageIndex,'
      '        MP.PrintBankBillet,'
      '        PC.Amount as ValorNominal,'
      '        PC.EstimetedDate as DataVencimento,'
      '        L.IDQuitacaoMeioPrevisto ,'
      '        L.IDLancamentoTipo,'
      '        L.IDDocumentoTipo,'
      '        L.IDPreSale,'
      '        L.CheckNumber,'
      '        L.IDBankCheck,'
      '        L.CustomerDocument,'
      '        L.CustomerName,'
      '        L.CustomerPhone,'
      '        L.Historico,'
      '        PC.IDPaymentCondition as IDLancamento,'
      '        L.IDCashRegMovClosed,'
      '        L.PaymentPlace'
      'FROM'
      #9'Sal_PaymentCondition PC (NOLOCK)'
      
        '        JOIN MeioPag MP (NOLOCK) on ( PC.IDMeioPag = MP.IDMeioPa' +
        'g )'
      
        '        LEFT JOIN Fin_Lancamento L (NOLOCK) ON (L.IDLancamento =' +
        ' -1)'
      'ORDER BY'
      '        MP.IDMeioPag')
    Left = 108
    Top = 61
    object quEstimatedIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quEstimatedMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object quEstimatedImageIndex: TIntegerField
      FieldName = 'ImageIndex'
    end
    object quEstimatedPrintBankBillet: TBooleanField
      FieldName = 'PrintBankBillet'
    end
    object quEstimatedValorNominal: TBCDField
      FieldName = 'ValorNominal'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quEstimatedDataVencimento: TDateTimeField
      FieldName = 'DataVencimento'
      DisplayFormat = 'ddddd'
    end
    object quEstimatedIDQuitacaoMeioPrevisto: TIntegerField
      FieldName = 'IDQuitacaoMeioPrevisto'
    end
    object quEstimatedIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quEstimatedIDDocumentoTipo: TIntegerField
      FieldName = 'IDDocumentoTipo'
    end
    object quEstimatedIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quEstimatedCheckNumber: TStringField
      FieldName = 'CheckNumber'
    end
    object quEstimatedIDBankCheck: TIntegerField
      FieldName = 'IDBankCheck'
    end
    object quEstimatedCustomerDocument: TStringField
      FieldName = 'CustomerDocument'
    end
    object quEstimatedCustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 80
    end
    object quEstimatedCustomerPhone: TStringField
      FieldName = 'CustomerPhone'
    end
    object quEstimatedHistorico: TMemoField
      FieldName = 'Historico'
      BlobType = ftMemo
    end
    object quEstimatedIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quEstimatedIDCashRegMovClosed: TIntegerField
      FieldName = 'IDCashRegMovClosed'
    end
    object quEstimatedPaymentPlace: TIntegerField
      FieldName = 'PaymentPlace'
    end
    object quEstimatedPayPlace: TStringField
      FieldKind = fkCalculated
      FieldName = 'PayPlace'
      Calculated = True
    end
  end
end
