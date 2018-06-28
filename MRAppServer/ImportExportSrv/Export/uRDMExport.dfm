object RDMExport: TRDMExport
  OldCreateOrder = False
  Left = 207
  Top = 364
  Height = 376
  Width = 817
  object dspInvoice: TDataSetProvider
    DataSet = qryInvoice
    BeforeGetRecords = dspInvoiceBeforeGetRecords
    AfterGetRecords = dspInvoiceAfterGetRecords
    Left = 48
    Top = 82
  end
  object qryInvoice: TADODataSet
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'CAST(0 as bit) as Marked,'#13#10#9'I.IDInvoice,'#13#10#9'I.MediaID,'#13#10 +
      #9'P.PessoaFirstName as FirstName, '#13#10#9'P.PessoaLastName as LastName' +
      ','#13#10#9'P.Pessoa as Customer,'#13#10#9'P.Telefone,'#13#10#9'P.Fax,'#13#10#9'P.Pais as Cou' +
      'ntry,'#13#10#9'P.IDEstado as State,'#13#10#9'P.Endereco as Address,'#13#10#9'P.Cidade' +
      ' as City,'#13#10#9'P.CEP as Zip,'#13#10#9'P.Email,'#13#10#9'P.Contato as Contact,'#13#10#9'P' +
      '.PhoneAreaCode,'#13#10#9'I.InvoiceDate ,'#13#10#9'I.IDPreSale,'#13#10#9'I.Canceled,'#13#10 +
      #9'((((I.SubTotal + I.Tax) - I.ItemDiscount) - I.InvoiceDiscount) ' +
      '+ IsNull(I.AditionalExpenses, 0)) as TotalInvoice,'#13#10#9'I.SubTotal-' +
      'I.ItemDiscount as SubTotal,'#13#10#9'I.Tax,'#13#10'        I.Layaway,'#13#10'      ' +
      '  IsNull(I.AditionalExpenses, 0) AS AditionalExpenses,'#13#10'        ' +
      'I.SaleCode,'#13#10'        I.InvoiceCode,'#13#10'        CAST('#39#39' as varchar(' +
      '15)) as AccGLMainAccount,'#13#10#9'(CAST(I.IDStore as varchar) + '#39'-'#39' + ' +
      'I.InvoiceCode) as AccInvoiceNumber,'#13#10#9'CAST('#39#39' as varchar(15)) as' +
      ' AccSalesTaxCode,'#13#10#9'CAST('#39#39' as varchar(15)) as AccCashAccount,'#13#10 +
      #9'CAST('#39#39' as varchar(20)) as AccCustomerID'#13#10'FROM'#13#10#9'Invoice I (NOL' +
      'OCK)'#13#10#9'JOIN Pessoa P (NOLOCK) ON (I.IDCustomer = P.IDPessoa)'#13#10#9'L' +
      'EFT OUTER JOIN Pais C (NOLOCK) ON (P.IDPais = C.IDPais)'
    Parameters = <>
    Left = 48
    Top = 28
    object qryInvoiceMarked: TBooleanField
      FieldName = 'Marked'
    end
    object qryInvoiceIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
      ReadOnly = True
    end
    object qryInvoiceMediaID: TIntegerField
      FieldName = 'MediaID'
      ReadOnly = True
    end
    object qryInvoiceFirstName: TStringField
      FieldName = 'FirstName'
      ReadOnly = True
      Size = 30
    end
    object qryInvoiceLastName: TStringField
      FieldName = 'LastName'
      ReadOnly = True
      Size = 30
    end
    object qryInvoiceCustomer: TStringField
      FieldName = 'Customer'
      ReadOnly = True
      Size = 50
    end
    object qryInvoiceInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
      ReadOnly = True
    end
    object qryInvoiceIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
      ReadOnly = True
    end
    object qryInvoiceCanceled: TBooleanField
      FieldName = 'Canceled'
      ReadOnly = True
    end
    object qryInvoiceTotalInvoice: TBCDField
      FieldName = 'TotalInvoice'
      ReadOnly = True
      Precision = 19
    end
    object qryInvoiceSubTotal: TBCDField
      FieldName = 'SubTotal'
      ReadOnly = True
      Precision = 19
    end
    object qryInvoiceTax: TBCDField
      FieldName = 'Tax'
      ReadOnly = True
      Precision = 19
    end
    object qryInvoiceLayaway: TBooleanField
      FieldName = 'Layaway'
      ReadOnly = True
    end
    object qryInvoiceAditionalExpenses: TBCDField
      FieldName = 'AditionalExpenses'
      ReadOnly = True
      Precision = 19
    end
    object qryInvoiceSaleCode: TStringField
      FieldName = 'SaleCode'
      ReadOnly = True
    end
    object qryInvoiceInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
      ReadOnly = True
    end
    object qryInvoiceAccGLMainAccount: TStringField
      FieldName = 'AccGLMainAccount'
      Size = 15
    end
    object qryInvoiceAccInvoiceNumber: TStringField
      FieldName = 'AccInvoiceNumber'
      Size = 51
    end
    object qryInvoiceAccSalesTaxCode: TStringField
      FieldName = 'AccSalesTaxCode'
      Size = 15
    end
    object qryInvoiceAccCashAccount: TStringField
      FieldName = 'AccCashAccount'
      Size = 15
    end
    object qryInvoiceAccCustomerID: TStringField
      FieldName = 'AccCustomerID'
    end
    object qryInvoiceTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object qryInvoiceCountry: TStringField
      FieldName = 'Country'
      Size = 21
    end
    object qryInvoiceState: TStringField
      FieldName = 'State'
      FixedChar = True
      Size = 3
    end
    object qryInvoiceAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object qryInvoiceCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object qryInvoiceZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object qryInvoiceEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object qryInvoiceContact: TStringField
      FieldName = 'Contact'
      Size = 50
    end
    object qryInvoicePhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object qryInvoiceFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
  end
  object ADOConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=MainRetailDB;Data Source=(local)'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 760
    Top = 25
  end
  object qryCategory: TADODataSet
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDGroup as IDCategory,'#13#10#9'Name as Category '#13#10'FROM '#13#10#9'Tab' +
      'Group'#13#10'WHERE'#13#10#9'Desativado = 0'
    Parameters = <>
    Left = 123
    Top = 28
    object qryCategoryIDCategory: TIntegerField
      FieldName = 'IDCategory'
    end
    object qryCategoryCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
  end
  object dspCategory: TDataSetProvider
    DataSet = qryCategory
    Left = 123
    Top = 82
  end
  object qryEntity: TADODataSet
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.IDTipoPessoa,'#13#10#9'TP.Path,'#13#10#9'P.Pessoa,'#13#10#9 +
      'P.Telefone,'#13#10#9'P.Cellular,'#13#10#9'P.Fax,'#13#10#9'P.Code,'#13#10#9'P.System,'#13#10#9'P.Des' +
      'ativado,'#13#10#9'P.Hidden,'#13#10#9'C.Pais as Country,'#13#10#9'E.Estado as StateNam' +
      'e,'#13#10#9'E.IDEstado as State,'#13#10#9'P.Endereco as Address,'#13#10#9'P.Cidade as' +
      ' City,'#13#10#9'P.CEP as Zip,'#13#10#9'P.Email,'#13#10#9'P.Contato as Contact,'#13#10#9'P.In' +
      'scEstadual as FederalID,'#13#10#9'P.InscMunicipal as SalesTax,'#13#10#9'P.Cart' +
      'Motorista as DriverLicense,'#13#10#9'P.CartTrabalho as JobDoc,'#13#10#9'P.User' +
      'Code,'#13#10#9'P.Identidade as SocialSecurity,'#13#10#9'P.DataExpedicao as SCD' +
      'ate,'#13#10#9'P.OrgaoEmissor as SCGov,'#13#10#9'P.PessoaLastName as LastName,'#13 +
      #10#9'P.PessoaFirstName as FirstName,'#13#10#9'P.CPF,'#13#10#9'P.CGC,'#13#10#9'P.Customer' +
      'Card as CustomerCard,'#13#10#9'P.Bairro as Neighborwood,'#13#10#9'P.PhoneAreaC' +
      'ode,'#13#10#9'P.CellAreaCode,'#13#10#9'P.Nascimento'#13#10'FROM'#13#10#9'Pessoa P (NOLOCK)'#13 +
      #10#9'JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPess' +
      'oa)'#13#10#9'LEFT OUTER JOIN Pais C (NOLOCK) ON (P.IDPais = C.IDPais)'#13#10 +
      #9'LEFT OUTER JOIN Estado E (NOLOCK) ON (P.IDEstado = E.IDEstado)'
    Parameters = <>
    Left = 212
    Top = 28
    object qryEntityIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object qryEntityIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
    end
    object qryEntityPath: TStringField
      FieldName = 'Path'
      Size = 150
    end
    object qryEntityPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object qryEntityTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object qryEntityCellular: TStringField
      FieldName = 'Cellular'
      FixedChar = True
      Size = 18
    end
    object qryEntityFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object qryEntityCode: TIntegerField
      FieldName = 'Code'
    end
    object qryEntitySystem: TBooleanField
      FieldName = 'System'
    end
    object qryEntityDesativado: TIntegerField
      FieldName = 'Desativado'
    end
    object qryEntityHidden: TIntegerField
      FieldName = 'Hidden'
    end
    object qryEntityCountry: TStringField
      FieldName = 'Country'
      Size = 50
    end
    object qryEntityStateName: TStringField
      FieldName = 'StateName'
      Size = 50
    end
    object qryEntityState: TStringField
      FieldName = 'State'
      FixedChar = True
      Size = 3
    end
    object qryEntityAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object qryEntityCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object qryEntityZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object qryEntityEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object qryEntityContact: TStringField
      FieldName = 'Contact'
      Size = 50
    end
    object qryEntityFederalID: TStringField
      FieldName = 'FederalID'
      Size = 30
    end
    object qryEntitySalesTax: TStringField
      FieldName = 'SalesTax'
      Size = 30
    end
    object qryEntityDriverLicense: TStringField
      FieldName = 'DriverLicense'
      Size = 15
    end
    object qryEntityJobDoc: TStringField
      FieldName = 'JobDoc'
      Size = 30
    end
    object qryEntityUserCode: TStringField
      FieldName = 'UserCode'
      Size = 6
    end
    object qryEntitySocialSecurity: TStringField
      FieldName = 'SocialSecurity'
      Size = 30
    end
    object qryEntitySCDate: TDateTimeField
      FieldName = 'SCDate'
    end
    object qryEntitySCGov: TStringField
      FieldName = 'SCGov'
      Size = 50
    end
    object qryEntityLastName: TStringField
      FieldName = 'LastName'
      Size = 50
    end
    object qryEntityFirstName: TStringField
      FieldName = 'FirstName'
      Size = 30
    end
    object qryEntityCPF: TStringField
      FieldName = 'CPF'
      Size = 30
    end
    object qryEntityCGC: TStringField
      FieldName = 'CGC'
      Size = 30
    end
    object qryEntityCustomerCard: TStringField
      FieldName = 'CustomerCard'
    end
    object qryEntityNeighborwood: TStringField
      FieldName = 'Neighborwood'
      Size = 50
    end
    object qryEntityPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object qryEntityCellAreaCode: TStringField
      FieldName = 'CellAreaCode'
      Size = 5
    end
    object qryEntityNascimento: TDateTimeField
      FieldName = 'Nascimento'
    end
  end
  object dspEntity: TDataSetProvider
    DataSet = qryEntity
    BeforeGetRecords = dspEntityBeforeGetRecords
    AfterGetRecords = dspEntityAfterGetRecords
    Left = 212
    Top = 82
  end
  object qrySaleItem: TADODataSet
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'ModelID,'#13#10#9'M.CaseQty,'#13#10#9'M.Model,'#13#10#9'Description,'#13#10#9'TG.Na' +
      'me as Category,'#13#10#9'M.SuggRetail,'#13#10#9'Qty,'#13#10#9'ExchangeInvoice,'#13#10#9'Sale' +
      'Price,'#13#10#9'CostPrice,'#13#10#9'Discount,'#13#10#9'((SalePrice * Qty) - Discount)' +
      ' as ItemTotalSold,'#13#10#9'SU.IDUser,'#13#10#9'0 AS IDComission,'#13#10#9'IM.IDInven' +
      'toryMov IDInventoryMov,'#13#10#9'IM.SalesTax as Tax,'#13#10#9'M.NotVerifyQty,'#13 +
      #10#9'IM.IDDepartment,'#13#10#9'TG.RequestCustomer,'#13#10#9'TG.PuppyTracker,'#13#10#9'IM' +
      '.Promo,'#13#10#9'M.SellingPrice,'#13#10#9'0 as IDMovParent'#13#10'FROM'#13#10#9'InventoryMo' +
      'v IM (NOLOCK) '#13#10#9'JOIN Model M (NOLOCK) ON ( IM.ModelID = M.IDMod' +
      'el )'#13#10#9'JOIN SystemUser SU (NOLOCK) ON ( SU.IDUser = IM.IDUser )'#13 +
      #10#9'JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )'#13#10#9'JOIN' +
      ' StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = IM.StoreID AND ' +
      'STC.IDGroup = TG.IDGroup )'#13#10#9'LEFT JOIN TaxCategory TC (NOLOCK) O' +
      'N ( TC.IDTaxCategory = STC.IDTaxCategory )'
    Parameters = <>
    Left = 48
    Top = 143
    object qrySaleItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object qrySaleItemCaseQty: TBCDField
      FieldName = 'CaseQty'
      Precision = 32
    end
    object qrySaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object qrySaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object qrySaleItemCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object qrySaleItemSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object qrySaleItemQty: TBCDField
      FieldName = 'Qty'
      Precision = 32
    end
    object qrySaleItemExchangeInvoice: TIntegerField
      FieldName = 'ExchangeInvoice'
    end
    object qrySaleItemSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object qrySaleItemCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object qrySaleItemDiscount: TBCDField
      FieldName = 'Discount'
      Precision = 19
    end
    object qrySaleItemItemTotalSold: TBCDField
      FieldName = 'ItemTotalSold'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
    object qrySaleItemIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object qrySaleItemIDComission: TIntegerField
      FieldName = 'IDComission'
      ReadOnly = True
    end
    object qrySaleItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object qrySaleItemTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object qrySaleItemNotVerifyQty: TBooleanField
      FieldName = 'NotVerifyQty'
    end
    object qrySaleItemIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object qrySaleItemRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
    end
    object qrySaleItemPuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
    end
    object qrySaleItemPromo: TBooleanField
      FieldName = 'Promo'
    end
    object qrySaleItemSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object qrySaleItemIDMovParent: TIntegerField
      FieldName = 'IDMovParent'
      ReadOnly = True
    end
  end
  object dspSaleItem: TDataSetProvider
    DataSet = qrySaleItem
    BeforeGetRecords = dspSaleItemBeforeGetRecords
    AfterGetRecords = dspSaleItemAfterGetRecords
    Left = 48
    Top = 197
  end
  object qrySalePayment: TADODataSet
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'L.IDLancamento,'#13#10#9'L.ValorNominal,'#13#10#9'L.DataLancamento,'#13#10 +
      #9'MP.MeioPag,'#13#10#9'MP.Tipo'#13#10'FROM'#13#10#9'Fin_Lancamento L (NOLOCK)'#13#10#9'JOIN ' +
      'MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)' +
      #13#10
    Parameters = <>
    Left = 128
    Top = 146
    object qrySalePaymentIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object qrySalePaymentValorNominal: TBCDField
      FieldName = 'ValorNominal'
      Precision = 19
    end
    object qrySalePaymentMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object qrySalePaymentTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object qrySalePaymentDataLancamento: TDateTimeField
      FieldName = 'DataLancamento'
    end
  end
  object dspSalePayment: TDataSetProvider
    DataSet = qrySalePayment
    BeforeGetRecords = dspSalePaymentBeforeGetRecords
    AfterGetRecords = dspSalePaymentAfterGetRecords
    Left = 128
    Top = 200
  end
  object qryTimeClock: TADODataSet
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'CAST(0 as bit) as Marked,'#13#10#9'TC.EnterDate,'#13#10#9'TC.ExitDat' +
      'e,'#13#10'        CONVERT(DateTime, (ExitDate - EnterDate)) as WorkedH' +
      'our,'#13#10#9'DATEPART(hh,CONVERT(DateTime, (ExitDate - EnterDate))) as' +
      ' WorkHourPay,'#13#10#9'ROUND((DATEPART(n,CONVERT(DateTime, (ExitDate - ' +
      'EnterDate)))*1.66)/100,2) as WorkMunitPay,'#13#10#9'(P.PessoaFirstName ' +
      '+ '#39' '#39' + P.PessoaLastName) as Pessoa,'#13#10#9'TC.IDUser,'#13#10#9'S.Name as St' +
      'ore '#13#10'FROM '#13#10#9'TMC_TimeControl TC (NOLOCK) '#13#10#9'JOIN Pessoa P (NOLO' +
      'CK) ON (TC.IDPessoa = P.IDPessoa)'#13#10#9'JOIN Store S (NOLOCK) ON (S.' +
      'IDStore = TC.IDStore) '#13#10
    Parameters = <>
    Left = 213
    Top = 148
    object qryTimeClockMarked: TBooleanField
      FieldName = 'Marked'
    end
    object qryTimeClockEnterDate: TDateTimeField
      FieldName = 'EnterDate'
    end
    object qryTimeClockExitDate: TDateTimeField
      FieldName = 'ExitDate'
    end
    object qryTimeClockWorkedHour: TDateTimeField
      FieldName = 'WorkedHour'
      ReadOnly = True
    end
    object qryTimeClockWorkHourPay: TIntegerField
      FieldName = 'WorkHourPay'
      ReadOnly = True
    end
    object qryTimeClockWorkMunitPay: TBCDField
      FieldName = 'WorkMunitPay'
      ReadOnly = True
      Precision = 18
      Size = 6
    end
    object qryTimeClockPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object qryTimeClockIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object qryTimeClockStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object dspTimeClock: TDataSetProvider
    DataSet = qryTimeClock
    BeforeGetRecords = dspTimeClockBeforeGetRecords
    AfterGetRecords = dspTimeClockAfterGetRecords
    Left = 213
    Top = 202
  end
  object dspQBCashRegMov: TDataSetProvider
    DataSet = qryQBCashRegMov
    Left = 343
    Top = 82
  end
  object ctQBCashRegMov: TmrConfigTable
    DataSetProvider = dspQBCashRegMov
    OnBeforeGetRecords = ctQBCashRegMovBeforeGetRecords
    Left = 344
    Top = 139
  end
  object qryQBCashRegMov: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryQBCashRegMovCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT'
      #9'CAST(0 as bit) as Marked,'
      #9'I.IDStore,'
      #9'CR.Name as CashRegister,'
      #9'CRM.IDCashRegMov,'
      #9'CRM.OpenTime,'
      #9'CRM.TotalPetty,'
      
        #9'CAST(SUBSTRING(CAST(CRM.OpenTime as varchar), 1, 11) as DateTim' +
        'e) TransDate,'
      
        #9'IsNull(CASE IsNull(CRL.TotalCashConf,0) WHEN 0 THEN IsNull(CRL.' +
        'TotalCash,0) ELSE IsNull(CRL.TotalCashConf,0) END ,0) as TotalCa' +
        'sh,'
      
        #9'IsNull(CASE IsNull(CRL.TotalCheckConf,0) WHEN 0 THEN IsNull(CRL' +
        '.TotalCheck,0) ELSE IsNull(CRL.TotalCheckConf,0) END ,0) as Tota' +
        'lCheck'
      'FROM '
      #9'CashRegMov CRM (NOLOCK)'
      
        #9'JOIN CashRegister CR (NOLOCK) ON (CRM.IDCashRegister = CR.IDCas' +
        'hRegister)'
      
        #9'JOIN CashRegLog CRL (NOLOCK) ON (CRL.IDCashRegMov = CRM.IDCashR' +
        'egMov AND IDCashRegTipoLog = 4)'
      #9'JOIN Invoice I (NOLOCK) ON (I.CashRegMovID = CRL.IDCashRegMov)'
      'WHERE'
      #9'CRM.IDCashRegStatus in (2, 3)'
      'ORDER BY'
      #9'CRM.OpenTime DESC')
    Left = 344
    Top = 27
    object qryQBCashRegMovMarked: TBooleanField
      FieldName = 'Marked'
    end
    object qryQBCashRegMovIDCashRegMov: TIntegerField
      FieldName = 'IDCashRegMov'
    end
    object qryQBCashRegMovOpenTime: TDateTimeField
      FieldName = 'OpenTime'
    end
    object qryQBCashRegMovTotalCash: TBCDField
      FieldName = 'TotalCash'
      ReadOnly = True
      Precision = 19
    end
    object qryQBCashRegMovTotalCheck: TBCDField
      FieldName = 'TotalCheck'
      ReadOnly = True
      Precision = 19
    end
    object qryQBCashRegMovGrandTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'GrandTotal'
      Calculated = True
    end
    object qryQBCashRegMovCashRegister: TStringField
      FieldName = 'CashRegister'
      Size = 15
    end
    object qryQBCashRegMovIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object qryQBCashRegMovTransDate: TDateTimeField
      FieldName = 'TransDate'
      ReadOnly = True
    end
    object qryQBCashRegMovTransNum: TStringField
      FieldKind = fkCalculated
      FieldName = 'TransNum'
      Calculated = True
    end
    object qryQBCashRegMovTotalTax: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotalTax'
      Calculated = True
    end
    object qryQBCashRegMovTotalPetty: TBCDField
      FieldName = 'TotalPetty'
      Precision = 19
    end
  end
  object dspQBPayments: TDataSetProvider
    DataSet = quQBPayments
    Left = 468
    Top = 82
  end
  object ctQBPayments: TmrConfigTable
    DataSetProvider = dspQBPayments
    OnBeforeGetRecords = ctQBPaymentsBeforeGetRecords
    Left = 469
    Top = 139
  end
  object quQBPayments: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryQBCashRegMovCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'MP.IDMeioPag,'
      #9'MP.MeioPag,'
      #9'SUM(L.ValorNominal) as Amount'
      'FROM'
      #9'Fin_Lancamento L (NOLOCK)'
      
        #9'JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMe' +
        'ioPag)'
      'WHERE'
      #9'MP.Tipo IN (2, 7)'
      'GROUP BY'
      #9'MP.IDMeioPag,'
      #9'MP.MeioPag')
    Left = 469
    Top = 27
    object quQBPaymentsIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quQBPaymentsMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object quQBPaymentsAmount: TBCDField
      FieldName = 'Amount'
      ReadOnly = True
      Precision = 19
    end
  end
  object dspQBCashRegItem: TDataSetProvider
    DataSet = quQBCashRegItem
    Left = 578
    Top = 82
  end
  object ctQBCashRegItem: TmrConfigTable
    DataSetProvider = dspQBCashRegItem
    Left = 579
    Top = 139
  end
  object quQBCashRegItem: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryQBCashRegMovCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'TG.IDGroup,'
      #9'TG.Name as Category,'
      #9'SUM((IM.SalePrice * IM.Qty) - IM.Discount) as ItemTotalSold,'
      #9'SUM(IMX.TaxValue) as Tax'
      'FROM'
      #9'Invoice I (NOLOCK)'
      
        #9'JOIN InventoryMov IM (NOLOCK) ON (IM.DocumentID = I.IDInvoice a' +
        'nd IM.InventMovTypeID = 1)'
      #9'JOIN Model M (NOLOCK) ON ( IM.ModelID = M.IDModel )'
      #9'JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )'
      
        #9'LEFT JOIN InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = ' +
        'IMX.IDInventoryMov)'
      'GROUP BY'
      #9'TG.IDGroup,'
      #9'TG.Name')
    Left = 579
    Top = 27
    object quQBCashRegItemIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quQBCashRegItemCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quQBCashRegItemItemTotalSold: TBCDField
      FieldName = 'ItemTotalSold'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
    object quQBCashRegItemTax: TBCDField
      FieldName = 'Tax'
      ReadOnly = True
      Precision = 19
    end
  end
end
