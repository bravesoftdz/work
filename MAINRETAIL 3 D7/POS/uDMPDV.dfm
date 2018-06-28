object DMPDV: TDMPDV
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 588
  Top = 81
  Height = 492
  Width = 606
  object quPreSaleInfo: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        IDPreSale,'
      '        IDMeioPag ,'
      '        IDTouristGroup,'
      '        PreSaleDate ,'
      '        OtherComissionID ,'
      '        IDCustomer ,'
      '        DeliverTypeID ,'
      '        DeliverDate ,'
      '        DeliverAddress ,'
      '        PassportDate ,'
      '        AirLine ,'
      '        CompanyName ,'
      '        CompanyCGC ,'
      '        DepositDate ,'
      '        Note ,'
      '        InvoiceDate ,'
      '        IDInvoice ,'
      '        Passport ,'
      '        Ticket,'
      '        MediaID,'
      '        CardNumber,'
      '        IDStore,'
      '        Address,'
      '        Layaway,'
      '        FirstName,'
      '        LastName,'
      '        Zip,'
      '        SaleCode'
      'FROM'
      '        Invoice Invoice'
      'WHERE'
      '        IDPreSale = :IDPreSale'
      ' '
      ' ')
    Left = 36
    Top = 80
    object quPreSaleInfoIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
      Origin = 'Invoice.IDPreSale'
    end
    object quPreSaleInfoIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
      Origin = 'Invoice.IDMeioPag'
    end
    object quPreSaleInfoIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
      Origin = 'Invoice.IDTouristGroup'
    end
    object quPreSaleInfoPreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
      Origin = 'Invoice.PreSaleDate'
      EditMask = '!99/99/00;1;_'
    end
    object quPreSaleInfoOtherComissionID: TIntegerField
      FieldName = 'OtherComissionID'
      Origin = 'Invoice.OtherComissionID'
    end
    object quPreSaleInfoIDCustomer: TIntegerField
      FieldName = 'IDCustomer'
      Origin = 'Invoice.IDCustomer'
    end
    object quPreSaleInfoDeliverTypeID: TIntegerField
      FieldName = 'DeliverTypeID'
      Origin = 'Invoice.DeliverTypeID'
    end
    object quPreSaleInfoDeliverDate: TDateTimeField
      FieldName = 'DeliverDate'
      Origin = 'Invoice.DeliverDate'
      EditMask = '!99/99/00;1;_'
    end
    object quPreSaleInfoDeliverAddress: TStringField
      FieldName = 'DeliverAddress'
      Origin = 'Invoice.DeliverAddress'
      Size = 100
    end
    object quPreSaleInfoPassportDate: TDateTimeField
      FieldName = 'PassportDate'
      Origin = 'Invoice.PassportDate'
      EditMask = '!99/99/00;1;_'
    end
    object quPreSaleInfoAirLine: TStringField
      FieldName = 'AirLine'
      Origin = 'Invoice.AirLine'
      Size = 40
    end
    object quPreSaleInfoCompanyName: TStringField
      FieldName = 'CompanyName'
      Origin = 'Invoice.CompanyName'
      Size = 40
    end
    object quPreSaleInfoCompanyCGC: TStringField
      FieldName = 'CompanyCGC'
      Origin = 'Invoice.CompanyCGC'
    end
    object quPreSaleInfoDepositDate: TDateTimeField
      FieldName = 'DepositDate'
      Origin = 'Invoice.DepositDate'
      EditMask = '!99/99/00;1;_'
    end
    object quPreSaleInfoNote: TStringField
      FieldName = 'Note'
      Origin = 'Invoice.Note'
      Size = 150
    end
    object quPreSaleInfoInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
      Origin = 'Invoice.InvoiceDate'
      EditMask = '!99/99/00;1;_'
    end
    object quPreSaleInfoIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
      Origin = 'Invoice.IDInvoice'
    end
    object quPreSaleInfoPassport: TStringField
      FieldName = 'Passport'
      Origin = 'Invoice.Passport'
    end
    object quPreSaleInfoTicket: TStringField
      FieldName = 'Ticket'
      Origin = 'Invoice.Ticket'
    end
    object quPreSaleInfoMediaID: TIntegerField
      FieldName = 'MediaID'
      Origin = 'Invoice.IDPreSale'
    end
    object quPreSaleInfoCardNumber: TStringField
      FieldName = 'CardNumber'
      Origin = 'Invoice.IDPreSale'
      Size = 30
    end
    object quPreSaleInfoIDStore: TIntegerField
      FieldName = 'IDStore'
      Origin = 'Invoice.IDPreSale'
    end
    object quPreSaleInfoAddress: TStringField
      FieldName = 'Address'
      Origin = 'Invoice.IDPreSale'
      Size = 200
    end
    object quPreSaleInfoLayaway: TBooleanField
      FieldName = 'Layaway'
    end
    object quPreSaleInfoFirstName: TStringField
      FieldName = 'FirstName'
    end
    object quPreSaleInfoLastName: TStringField
      FieldName = 'LastName'
    end
    object quPreSaleInfoZip: TStringField
      FieldName = 'Zip'
    end
    object quPreSaleInfoSaleCode: TStringField
      FieldName = 'SaleCode'
    end
  end
  object spquPreSaleItem: TADOStoredProc
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    ProcedureName = 'sp_PreSale_quPreSaleItem;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@DocumentID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IsPreSale'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 112
    Top = 80
    object spquPreSaleItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object spquPreSaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object spquPreSaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object spquPreSaleItemSalePrice: TFloatField
      DisplayLabel = 'Our Price'
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemDiscActual: TFloatField
      FieldKind = fkCalculated
      FieldName = 'DiscActual'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleItemDiscount: TFloatField
      DisplayLabel = 'Disc.'
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object spquPreSaleItemTotalItem: TFloatField
      DisplayLabel = 'Total'
      FieldKind = fkCalculated
      FieldName = 'TotalItem'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleItemSalesPerson: TStringField
      FieldName = 'SalesPerson'
      Size = 50
    end
    object spquPreSaleItemIDComission: TIntegerField
      FieldName = 'IDComission'
    end
    object spquPreSaleItemCostPrice: TFloatField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemExchangeInvoice: TIntegerField
      FieldName = 'ExchangeInvoice'
    end
    object spquPreSaleItemSuggRetail: TFloatField
      DisplayLabel = 'MSRP'
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleItemSerialNumber: TBooleanField
      DisplayLabel = 'S/N'
      FieldName = 'SerialNumber'
    end
    object spquPreSaleItemIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object spquPreSaleItemTax: TFloatField
      DisplayLabel = 'Tax %'
      FieldName = 'Tax'
      DisplayFormat = '0.00'
    end
    object spquPreSaleItemSubTotalItem: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SubTotalItem'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleItemQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object spquPreSaleValue: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_quPreSaleValue;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PreSaleID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 196
    Top = 80
    object spquPreSaleValueTaxIsent: TBooleanField
      DisplayLabel = 'TaxExempt'
      DisplayWidth = 5
      FieldName = 'TaxIsent'
    end
    object spquPreSaleValueSubTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'SubTotal'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleValueItemDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'ItemDiscount'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleValueTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleValueTaxPrc: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TaxPrc'
      DisplayFormat = '#,##0.00 %'
      Calculated = True
    end
    object spquPreSaleValueDiscountPrc: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'DiscountPrc'
      DisplayFormat = '#,##0.00 %'
      Calculated = True
    end
    object spquPreSaleValueTotalInvoice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalInvoice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleValueSpecialPriceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SpecialPriceID'
    end
    object spquPreSaleValueSpecialPrice: TStringField
      DisplayWidth = 30
      FieldName = 'SpecialPrice'
      Size = 30
    end
    object spquPreSaleValuenOpenUser: TIntegerField
      DisplayWidth = 10
      FieldName = 'nOpenUser'
    end
    object spquPreSaleValueShowOpenUser: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ShowOpenUser'
      Calculated = True
    end
    object spquPreSaleValueNewSubTotal: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'NewSubTotal'
      DisplayFormat = '#,##0.00'
      currency = True
      Calculated = True
    end
    object spquPreSaleValueTaxIsemptValue: TFloatField
      DisplayWidth = 10
      FieldName = 'TaxIsemptValue'
      DisplayFormat = '#,##0.00'
    end
    object spquPreSaleValueSubTotalTaxable: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'SubTotalTaxable'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object spquPreSaleValueTaxIsemptItemDiscount: TFloatField
      FieldName = 'TaxIsemptItemDiscount'
    end
    object spquPreSaleValueInvoiceDiscount: TCurrencyField
      FieldName = 'InvoiceDiscount'
    end
  end
  object quBarcode: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'M.IDModel,'
      #9'B.IDBarcode,'
      #9'M.Model,'
      '                IsNull(B.Qty,1) as CaseQty'
      'FROM'
      #9'Barcode B'
      #9'JOIN Model M ON (M.IDModel = B.IDModel)'
      'WHERE'
      #9'TC.OperationType = 1'
      #9'AND'
      #9'TC.SaleTaxType = 2')
    Left = 224
    Top = 336
    object quBarcodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quBarcodeModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quBarcodeIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object quBarcodeCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
  end
  object dsPreSaleValue: TDataSource
    DataSet = spquPreSaleValue
    Left = 196
    Top = 32
  end
  object dsPreSaleItem: TDataSource
    DataSet = spquPreSaleItem
    Left = 116
    Top = 32
  end
  object dsPreSaleInfo: TDataSource
    DataSet = quPreSaleInfo
    Left = 36
    Top = 32
  end
  object quMeioPag: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDMeioPag,'
      #9'MeioPag,'
      #9'ImageIndex,'
      '                Tipo,'
      #9'RequireCustomer,'
      #9'ValidateNonpayer'
      'FROM'
      #9'MeioPag'
      'WHERE'
      #9'ParentType = '#39'Sale'#39' '
      #9'AND'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0')
    Left = 35
    Top = 191
  end
  object FormasPagamento: TFormasPagamento
    Left = 160
    Top = 144
  end
  object quCustomer: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 150
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10'        '#9'P.Pessoa,'#13#10#9'P.PessoaFirstName,'#13#10#9 +
      'P.PessoaLastName,'#13#10'        '#9'P.Endereco,'#13#10#9'P.Cidade,'#13#10#9'P.CEP,'#13#10#9'P' +
      '.Telefone,'#13#10#9'(CASE P.Juridico WHEN 1 THEN P.InscEstadual ELSE P.' +
      'CPF END) as CPF,'#13#10#9'P.InscEstadual,'#13#10#9'P.Bairro,'#13#10#9'P.StoreAccountL' +
      'imit,'#13#10#9'P.Nonpayer'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10#9'JOIN TipoPessoa' +
      ' TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'#13#10'WHERE '#9#13#10#9'TP.Path lik' +
      'e '#39'.001%'#39#13#10'ORDER BY '#13#10#9'P.Pessoa'
    Parameters = <>
    Left = 32
    Top = 256
  end
  object dspCustomer: TDataSetProvider
    DataSet = quCustomer
    Left = 32
    Top = 256
  end
  object cdsCustomer: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCustomer'
    Left = 32
    Top = 256
    object cdsCustomerIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Visible = False
    end
    object cdsCustomerPessoa: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 60
      FieldName = 'Pessoa'
      Size = 50
    end
    object cdsCustomerPessoaFirstName: TStringField
      DisplayLabel = 'FirstName'
      FieldName = 'PessoaFirstName'
      Visible = False
      Size = 30
    end
    object cdsCustomerPessoaLastName: TStringField
      DisplayLabel = 'LastName'
      FieldName = 'PessoaLastName'
      Visible = False
      Size = 30
    end
    object cdsCustomerEndereco: TStringField
      DisplayLabel = 'Address'
      FieldName = 'Endereco'
      Visible = False
      Size = 80
    end
    object cdsCustomerCidade: TStringField
      DisplayLabel = 'City'
      FieldName = 'Cidade'
      Visible = False
      Size = 40
    end
    object cdsCustomerCEP: TStringField
      DisplayLabel = 'Zip'
      FieldName = 'CEP'
      Visible = False
      FixedChar = True
      Size = 12
    end
    object cdsCustomerTelefone: TStringField
      DisplayLabel = 'Phone'
      DisplayWidth = 15
      FieldName = 'Telefone'
      Size = 40
    end
    object cdsCustomerCPF: TStringField
      DisplayLabel = 'Document'
      FieldName = 'CPF'
      Size = 30
    end
    object cdsCustomerInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Visible = False
      Size = 30
    end
    object cdsCustomerBairro: TStringField
      DisplayWidth = 30
      FieldName = 'Bairro'
      Size = 50
    end
    object cdsCustomerStoreAccountLimit: TBCDField
      FieldName = 'StoreAccountLimit'
      Visible = False
      Precision = 19
    end
    object cdsCustomerNonpayer: TBooleanField
      FieldName = 'Nonpayer'
      Visible = False
    end
  end
  object quOtherCommission: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.IDPessoa IDComissionado,'#13#10#9'P.Pessoa'#13#10'FR' +
      'OM '#9#13#10#9'Pessoa P'#13#10'WHERE '#9#13#10#9'P.IDTipoPessoaRoot = 9'#13#10'ORDER BY '#13#10#9'P' +
      '.Pessoa'
    Parameters = <>
    Left = 124
    Top = 256
  end
  object dspOtherCommission: TDataSetProvider
    DataSet = quOtherCommission
    Left = 124
    Top = 256
  end
  object cdsOtherCommission: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOtherCommission'
    Left = 124
    Top = 256
    object cdsOtherCommissionIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object cdsOtherCommissionIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object cdsOtherCommissionPessoa: TStringField
      DisplayLabel = 'Name'
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object quSystemUser: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'SU.IDUser, '#13#10#9'SU.SystemUser,'#13#10#9'SU.ComissionID,'#13#10#9'P.IDTi' +
      'poPessoa'#13#10'FROM'#13#10#9'SystemUser SU'#13#10#9'JOIN Pessoa P ON (P.IDPessoa = ' +
      'SU.ComissionID)'#13#10'WHERE'#13#10#9'SU.Desativado = 0'#13#10#9'AND'#13#10#9'SU.Hidden = 0' +
      #13#10#9'AND'#13#10#9'SU.System = 0'#13#10#9'AND'#13#10#9'SU.ComissionID IS NOT NULL'
    Parameters = <>
    Left = 124
    Top = 336
  end
  object dspSystemUser: TDataSetProvider
    DataSet = quSystemUser
    Left = 124
    Top = 336
  end
  object cdsSystemUser: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSystemUser'
    Left = 124
    Top = 336
    object cdsSystemUserIDUser: TIntegerField
      FieldName = 'IDUser'
      Visible = False
    end
    object cdsSystemUserSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object cdsSystemUserComissionID: TIntegerField
      FieldName = 'ComissionID'
      Visible = False
    end
    object cdsSystemUserIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
      Visible = False
    end
  end
  object quModel: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.ReplacementC' +
      'ost,'#13#10#9'M.Peso,'#13#10#9'M.SuggRetail,'#13#10#9'M.AvgCost,'#13#10#9'M.LargeImage,'#13#10#9'M.' +
      'LargeImage2,'#13#10#9'M.PromotionPrice,'#13#10#9'M.AskUserOnSale,'#13#10#9'CASE WHEN ' +
      'M.DiscountPerc IS NULL THEN ISNULL(TG.PrcPartDiscount, 100) ELSE' +
      ' M.DiscountPerc END AS DiscountPerc,'#13#10#9'M.CustomSalePrice,'#13#10#9'I.Se' +
      'llingPrice as StoreSellingPrice,'#13#10#9'TG.Name as TabGroup,'#13#10#9'U.Unid' +
      'ade,'#13#10#9'U.Sigla,'#13#10#9'F.Pessoa as Fabricante,'#13#10#9'IVS.SizeName,'#13#10#9'IVS.' +
      'CodSize,'#13#10#9'IVC.Color,'#13#10#9'IVC.CodColor,'#13#10#9'TG.RequestCustomer,'#13#10#9'TG' +
      '.PuppyTracker,'#13#10#9'(IsNull(M.VendorCost,0) + IsNull(M.FreightCost,' +
      '0)+ IsNull(M.OtherCost,0)) as VendorCostM,'#13#10#9'IsNull(I.StoreCostP' +
      'rice, 0) as VendorCostI,'#13#10#9'M.SellingPrice as InvSellingPriceM,'#13#10 +
      #9'I.SellingPrice as InvSellingPriceI,'#13#10#9'STG.IDSaleTax as IDTaxCat' +
      'egory,'#13#10#9'TG.IDDepartment,'#13#10#9'CAST('#39#39' as varchar(50)) as Fornecedo' +
      'r,'#13#10#9'M.CaseQty,'#13#10#9'TG.SerialNumber,'#13#10#9'TG.UseDocumentOnSale,'#13#10#9'M.U' +
      'seScale,'#13#10#9'M.IndicadorProducao,'#13#10#9'M.IndicadorAT,'#13#10#9'TC.SituacaoTr' +
      'ibutaria,'#13#10#9'CAST('#39#39' as varchar(20)) as DescSituTribut'#13#10'FROM'#13#10#9'Mo' +
      'del M (NOLOCK)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.Gr' +
      'oupID)'#13#10#9'JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.G' +
      'roupID)'#13#10#9'JOIN TaxCategory TC ON (STG.IDSaleTax = TC.IDTaxCatego' +
      'ry)'#13#10#9'JOIN Store S (NOLOCK) ON (STG.IDStore = S.IDStore)'#13#10#9'LEFT ' +
      'OUTER JOIN Unidade U (NOLOCK) ON (U.IDUnidade = M.IDUnidade)'#13#10#9'L' +
      'EFT OUTER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante' +
      ')'#13#10#9'LEFT OUTER JOIN InvSize IVS (NOLOCK) ON (IVS.IDSize = M.IDSi' +
      'ze)'#13#10#9'LEFT OUTER JOIN InvColor IVC (NOLOCK) ON (IVC.IDColor = M.' +
      'IDColor)'#13#10#9'LEFT OUTER JOIN Inventory I (NOLOCK) ON (I.ModelID = ' +
      'M.IDModel AND I.StoreID = S.IDStore)'#13#10'WHERE'#13#10#9'M.Desativado = 0'#13#10 +
      #9'AND'#13#10#9'M.Hidden = 0'#13#10#9'AND'#13#10#9'M.ModelType IN ('#39'S'#39', '#39'R'#39', '#39'V'#39', '#39'C'#39','#39 +
      'K'#39', '#39'G'#39' )'#13#10'ORDER BY'#13#10#9'M.Model'#13#10
    Parameters = <>
    Left = 224
    Top = 256
  end
  object dspModel: TDataSetProvider
    DataSet = quModel
    Left = 224
    Top = 256
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <>
    ProviderName = 'dspModel'
    OnCalcFields = cdsModelCalcFields
    Left = 224
    Top = 256
    object cdsModelIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object cdsModelModel: TStringField
      DisplayLabel = 'Modelo'
      FieldName = 'Model'
      Size = 30
    end
    object cdsModelDescription: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Description'
      Size = 50
    end
    object cdsModelReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Visible = False
      Precision = 19
    end
    object cdsModelPeso: TBCDField
      FieldName = 'Peso'
      Visible = False
      Precision = 19
    end
    object cdsModelSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Visible = False
      Precision = 19
    end
    object cdsModelAvgCost: TBCDField
      FieldName = 'AvgCost'
      Visible = False
      Precision = 19
    end
    object cdsModelLargeImage: TStringField
      FieldName = 'LargeImage'
      Visible = False
      Size = 255
    end
    object cdsModelLargeImage2: TStringField
      FieldName = 'LargeImage2'
      Visible = False
      Size = 255
    end
    object cdsModelPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelAskUserOnSale: TBooleanField
      FieldName = 'AskUserOnSale'
      Visible = False
    end
    object cdsModelDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
      ReadOnly = True
      Visible = False
    end
    object cdsModelCustomSalePrice: TBooleanField
      FieldName = 'CustomSalePrice'
      Visible = False
    end
    object cdsModelStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      Visible = False
      Precision = 19
    end
    object cdsModelTabGroup: TStringField
      FieldName = 'TabGroup'
      Visible = False
      Size = 30
    end
    object cdsModelUnidade: TStringField
      FieldName = 'Unidade'
      Visible = False
      Size = 100
    end
    object cdsModelSigla: TStringField
      FieldName = 'Sigla'
      Visible = False
      FixedChar = True
      Size = 4
    end
    object cdsModelFabricante: TStringField
      FieldName = 'Fabricante'
      Size = 50
    end
    object cdsModelSizeName: TStringField
      FieldName = 'SizeName'
      Visible = False
    end
    object cdsModelCodSize: TStringField
      FieldName = 'CodSize'
      Visible = False
      Size = 10
    end
    object cdsModelColor: TStringField
      FieldName = 'Color'
      Visible = False
    end
    object cdsModelCodColor: TStringField
      FieldName = 'CodColor'
      Visible = False
      Size = 10
    end
    object cdsModelRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
      Visible = False
    end
    object cdsModelPuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
      Visible = False
    end
    object cdsModelVendorCostM: TBCDField
      FieldName = 'VendorCostM'
      ReadOnly = True
      Visible = False
      Precision = 19
    end
    object cdsModelVendorCostI: TBCDField
      FieldName = 'VendorCostI'
      ReadOnly = True
      Visible = False
      Precision = 19
    end
    object cdsModelInvSellingPriceM: TBCDField
      FieldName = 'InvSellingPriceM'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelInvSellingPriceI: TBCDField
      FieldName = 'InvSellingPriceI'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
      Visible = False
    end
    object cdsModelIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
      Visible = False
    end
    object cdsModelFornecedor: TStringField
      FieldName = 'Fornecedor'
      Visible = False
      Size = 50
    end
    object cdsModelCaseQty: TBCDField
      FieldName = 'CaseQty'
      Visible = False
      Precision = 32
    end
    object cdsModelSerialNumber: TBooleanField
      FieldName = 'SerialNumber'
      Visible = False
    end
    object cdsModelUseDocumentOnSale: TBooleanField
      FieldName = 'UseDocumentOnSale'
      Visible = False
    end
    object cdsModelUseScale: TBooleanField
      FieldName = 'UseScale'
      Visible = False
    end
    object cdsModelSellingPrice: TCurrencyField
      DisplayLabel = 'Pr'#231' Venda'
      FieldKind = fkCalculated
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsModelInvSellingPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'InvSellingPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsModelVendorCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'VendorCost'
      Visible = False
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsModelIndicadorProducao: TStringField
      FieldName = 'IndicadorProducao'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cdsModelIndicadorAT: TStringField
      FieldName = 'IndicadorAT'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cdsModelSituacaoTributaria: TIntegerField
      FieldName = 'SituacaoTributaria'
      Visible = False
    end
    object cdsModelDescSituTribut: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescSituTribut'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
  end
  object ADODataSet1: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.IDPessoa IDComissionado,'#13#10#9'P.Pessoa'#13#10'FR' +
      'OM '#9#13#10#9'Pessoa P'#13#10'WHERE '#9#13#10#9'P.IDTipoPessoaRoot = 9'#13#10'ORDER BY '#13#10#9'P' +
      '.Pessoa'
    Parameters = <>
    Left = 428
    Top = 68
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = ADODataSet1
    Left = 428
    Top = 72
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 428
    Top = 72
  end
  object quBarcodeSearch: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'B.IDBarcode,'#13#10#9'B.IDModel,'#13#10#9'M.Model,'#13#10'                I' +
      'sNull(B.Qty,1) as CaseQty'#13#10'FROM'#13#10#9'Barcode B'#13#10#9'JOIN Model M ON (M' +
      '.IDModel = B.IDModel)'#13#10'WHERE'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M.Hidden' +
      ' = 0'#13#10#9'AND'#13#10#9'M.ModelType IN ('#39'S'#39', '#39'R'#39', '#39'V'#39', '#39'C'#39','#39'K'#39', '#39'G'#39' )'#13#10'ORDE' +
      'R BY'#13#10#9'B.IDBarcode'
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 436
    Top = 268
  end
  object dspBarcodeSearch: TDataSetProvider
    DataSet = quBarcodeSearch
    Left = 436
    Top = 267
  end
  object cdsBarcodeSearch: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDStore'
        ParamType = ptInput
      end>
    ProviderName = 'dspBarcodeSearch'
    Left = 436
    Top = 269
    object cdsBarcodeSearchIDBarcode: TStringField
      DisplayLabel = 'Barcode'
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object cdsBarcodeSearchIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object cdsBarcodeSearchModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsBarcodeSearchCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
      Visible = False
    end
  end
  object quMDescription: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.ReplacementC' +
      'ost,'#13#10#9'M.Peso,'#13#10#9'M.SuggRetail,'#13#10#9'M.AvgCost,'#13#10#9'M.LargeImage,'#13#10#9'M.' +
      'LargeImage2,'#13#10#9'M.PromotionPrice,'#13#10#9'M.AskUserOnSale,'#13#10#9'CASE WHEN ' +
      'M.DiscountPerc IS NULL THEN ISNULL(TG.PrcPartDiscount, 100) ELSE' +
      ' M.DiscountPerc END AS DiscountPerc,'#13#10#9'M.CustomSalePrice,'#13#10#9'I.Se' +
      'llingPrice as StoreSellingPrice,'#13#10#9'TG.Name as TabGroup,'#13#10#9'U.Unid' +
      'ade,'#13#10#9'U.Sigla,'#13#10#9'F.Pessoa as Fabricante,'#13#10#9'IVS.SizeName,'#13#10#9'IVS.' +
      'CodSize,'#13#10#9'IVC.Color,'#13#10#9'IVC.CodColor,'#13#10#9'TG.RequestCustomer,'#13#10#9'TG' +
      '.PuppyTracker,'#13#10#9'(IsNull(M.VendorCost,0) + IsNull(M.FreightCost,' +
      '0)+ IsNull(M.OtherCost,0)) as VendorCostM,'#13#10#9'IsNull(I.StoreCostP' +
      'rice, 0) as VendorCostI,'#13#10#9'M.SellingPrice as InvSellingPriceM,'#13#10 +
      #9'I.SellingPrice as InvSellingPriceI,'#13#10#9'STG.IDSaleTax as IDTaxCat' +
      'egory,'#13#10#9'TG.IDDepartment,'#13#10#9'CAST('#39#39' as varchar(50)) as Fornecedo' +
      'r,'#13#10#9'M.CaseQty,'#13#10#9'TG.SerialNumber,'#13#10#9'TG.UseDocumentOnSale,'#13#10#9'M.U' +
      'seScale,'#13#10#9'M.IndicadorProducao,'#13#10#9'M.IndicadorAT,'#13#10#9'TC.SituacaoTr' +
      'ibutaria,'#13#10#9'CAST('#39#39' as varchar(20)) as DescSituTribut'#13#10'FROM'#13#10#9'Mo' +
      'del M (NOLOCK)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.Gr' +
      'oupID)'#13#10#9'JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.G' +
      'roupID)'#13#10#9'JOIN TaxCategory TC ON (STG.IDSaleTax = TC.IDTaxCatego' +
      'ry)'#13#10#9'JOIN Store S (NOLOCK) ON (STG.IDStore = S.IDStore)'#13#10#9'LEFT ' +
      'OUTER JOIN Unidade U (NOLOCK) ON (U.IDUnidade = M.IDUnidade)'#13#10#9'L' +
      'EFT OUTER JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante' +
      ')'#13#10#9'LEFT OUTER JOIN InvSize IVS (NOLOCK) ON (IVS.IDSize = M.IDSi' +
      'ze)'#13#10#9'LEFT OUTER JOIN InvColor IVC (NOLOCK) ON (IVC.IDColor = M.' +
      'IDColor)'#13#10#9'LEFT OUTER JOIN Inventory I (NOLOCK) ON (I.ModelID = ' +
      'M.IDModel AND I.StoreID = S.IDStore)'#13#10'WHERE'#13#10#9'M.Desativado = 0'#13#10 +
      #9'AND'#13#10#9'M.Hidden = 0'#13#10#9'AND'#13#10#9'M.ModelType IN ('#39'S'#39', '#39'R'#39', '#39'V'#39', '#39'C'#39','#39 +
      'K'#39', '#39'G'#39' )'#13#10#9'AND '#13#10#9'S.IDStore = :IDStore'#13#10'ORDER BY'#13#10#9'M.Descriptio' +
      'n'
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 332
    Top = 256
  end
  object dspMDescription: TDataSetProvider
    DataSet = quMDescription
    Left = 332
    Top = 256
  end
  object cdsMDescription: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDStore'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspMDescription'
    BeforeOpen = cdsMDescriptionBeforeOpen
    OnCalcFields = cdsMDescriptionCalcFields
    Left = 332
    Top = 256
    object cdsMDescriptionIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object cdsMDescriptionModel: TStringField
      DisplayLabel = 'Modelo'
      FieldName = 'Model'
      Visible = False
      Size = 30
    end
    object cdsMDescriptionDescription: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Description'
      Size = 50
    end
    object cdsMDescriptionReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Visible = False
      Precision = 19
    end
    object cdsMDescriptionPeso: TBCDField
      FieldName = 'Peso'
      Visible = False
      Precision = 19
    end
    object cdsMDescriptionSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMDescriptionAvgCost: TBCDField
      FieldName = 'AvgCost'
      Visible = False
      Precision = 19
    end
    object cdsMDescriptionLargeImage: TStringField
      FieldName = 'LargeImage'
      Visible = False
      Size = 255
    end
    object cdsMDescriptionLargeImage2: TStringField
      FieldName = 'LargeImage2'
      Visible = False
      Size = 255
    end
    object cdsMDescriptionPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMDescriptionAskUserOnSale: TBooleanField
      FieldName = 'AskUserOnSale'
      Visible = False
    end
    object cdsMDescriptionDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
      ReadOnly = True
      Visible = False
    end
    object cdsMDescriptionCustomSalePrice: TBooleanField
      FieldName = 'CustomSalePrice'
      Visible = False
    end
    object cdsMDescriptionStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      Visible = False
      Precision = 19
    end
    object cdsMDescriptionTabGroup: TStringField
      FieldName = 'TabGroup'
      Visible = False
      Size = 30
    end
    object cdsMDescriptionUnidade: TStringField
      FieldName = 'Unidade'
      Visible = False
      Size = 100
    end
    object cdsMDescriptionSigla: TStringField
      FieldName = 'Sigla'
      Visible = False
      FixedChar = True
      Size = 4
    end
    object cdsMDescriptionFabricante: TStringField
      FieldName = 'Fabricante'
      Size = 50
    end
    object cdsMDescriptionSizeName: TStringField
      FieldName = 'SizeName'
      Visible = False
    end
    object cdsMDescriptionCodSize: TStringField
      FieldName = 'CodSize'
      Visible = False
      Size = 10
    end
    object cdsMDescriptionColor: TStringField
      FieldName = 'Color'
      Visible = False
    end
    object cdsMDescriptionCodColor: TStringField
      FieldName = 'CodColor'
      Visible = False
      Size = 10
    end
    object cdsMDescriptionRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
      Visible = False
    end
    object cdsMDescriptionPuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
      Visible = False
    end
    object cdsMDescriptionVendorCostM: TBCDField
      FieldName = 'VendorCostM'
      ReadOnly = True
      Visible = False
      Precision = 19
    end
    object cdsMDescriptionVendorCostI: TBCDField
      FieldName = 'VendorCostI'
      ReadOnly = True
      Visible = False
      Precision = 19
    end
    object cdsMDescriptionInvSellingPriceM: TBCDField
      FieldName = 'InvSellingPriceM'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMDescriptionInvSellingPriceI: TBCDField
      FieldName = 'InvSellingPriceI'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsMDescriptionIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
      Visible = False
    end
    object cdsMDescriptionIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
      Visible = False
    end
    object cdsMDescriptionFornecedor: TStringField
      FieldName = 'Fornecedor'
      Visible = False
      Size = 50
    end
    object cdsMDescriptionCaseQty: TBCDField
      FieldName = 'CaseQty'
      Visible = False
      Precision = 32
    end
    object cdsMDescriptionSerialNumber: TBooleanField
      FieldName = 'SerialNumber'
      Visible = False
    end
    object cdsMDescriptionUseDocumentOnSale: TBooleanField
      FieldName = 'UseDocumentOnSale'
      Visible = False
    end
    object cdsMDescriptionUseScale: TBooleanField
      FieldName = 'UseScale'
      Visible = False
    end
    object cdsMDescriptionSellingPrice: TCurrencyField
      DisplayLabel = 'Pr'#231' Venda'
      FieldKind = fkCalculated
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsMDescriptionInvSellingPrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'InvSellingPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsMDescriptionVendorCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'VendorCost'
      Visible = False
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object cdsMDescriptionIndicadorProducao: TStringField
      FieldName = 'IndicadorProducao'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cdsMDescriptionIndicadorAT: TStringField
      FieldName = 'IndicadorAT'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cdsMDescriptionSituacaoTributaria: TIntegerField
      FieldName = 'SituacaoTributaria'
      Visible = False
    end
    object cdsMDescriptionDescSituTribut: TStringField
      FieldKind = fkCalculated
      FieldName = 'DescSituTribut'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
  end
  object quNewCustomer: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoaRoot'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
        Name = 'PessoaFirstName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'PessoaLastName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Endereco'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 80
        Value = Null
      end
      item
        Name = 'Cidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Bairro'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'CEP'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end
      item
        Name = 'Telefone'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Juridico'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'CPF'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO Pessoa'
      '('
      'IDPessoa,'
      'IDTipoPessoa,'
      'IDStore,'
      'IDTipoPessoaRoot,'
      'IDUser,'
      'PessoaFirstName,'
      'PessoaLastName,'
      'Pessoa,'
      'Endereco,'
      'Cidade,'
      'Bairro,'
      'CEP,'
      'Telefone,'
      'Juridico,'
      'CPF'
      ')'
      'VALUES'
      '('
      ':IDPessoa,'
      ':IDTipoPessoa,'
      ':IDStore,'
      ':IDTipoPessoaRoot,'
      ':IDUser,'
      ':PessoaFirstName,'
      ':PessoaLastName,'
      ':Pessoa,'
      ':Endereco,'
      ':Cidade,'
      ':Bairro,'
      ':CEP,'
      ':Telefone,'
      ':Juridico,'
      ':CPF'
      ')')
    Left = 296
    Top = 144
  end
  object cmdPessoa: TADOCommand
    CommandText = 
      'INSERT Pessoa (IDPessoa, IDTipoPessoa, IDStore, IDTipoPessoaRoot' +
      ', IDUser, Pessoa, PessoaFirstName, PessoaLastName, Endereco, Cid' +
      'ade, CEP, Telefone, Juridico, CPF, Bairro, PhoneAreaCode, CellAr' +
      'eaCode, Cellular, Email, HomePage, Identidade, OrgaoEmissor, Dat' +
      'aExpedicao, Nascimento, CustomerCard, CartMotorista, NomeJuridic' +
      'o, InscEstadual, InscMunicipal, Contatos, OBS, CreationDate)'#13#10'VA' +
      'LUES (:IDPessoa, :IDTipoPessoa, :IDStore, :IDTipoPessoaRoot, :ID' +
      'User, :Pessoa, :PessoaFirstName, :PessoaLastName, :Endereco, :Ci' +
      'dade, :CEP, :Telefone, :Juridico, :CPF, :Bairro, :PhoneAreaCode,' +
      ' :CellAreaCode, :Cellular, :Email, :HomePage, :Identidade, :Orga' +
      'oEmissor, :DataExpedicao, :Nascimento, :CustomerCard, :CartMotor' +
      'ista, :NomeJuridico, :InscEstadual, :InscMunicipal, :Contatos, :' +
      'OBS, :CreationDate)'#13#10#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoaRoot'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
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
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PessoaFirstName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'PessoaLastName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Endereco'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 80
        Value = Null
      end
      item
        Name = 'Cidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CEP'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end
      item
        Name = 'Telefone'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Juridico'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'CPF'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Bairro'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PhoneAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'CellAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'Cellular'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 18
        Value = Null
      end
      item
        Name = 'Email'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'HomePage'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 200
        Value = Null
      end
      item
        Name = 'Identidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'OrgaoEmissor'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'DataExpedicao'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Nascimento'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'CustomerCard'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end
      item
        Name = 'CartMotorista'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'NomeJuridico'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'InscEstadual'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'InscMunicipal'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Contatos'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end
      item
        Name = 'CreationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    Left = 364
    Top = 32
  end
  object siLang: TsiLangRT
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = DMGlobal.LanguageDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Portugu'#234's'
      'Espa'#241'ol')
    Language = 'English'
    StorageDelimiter = '~!@#'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    RTEditorActionsOptions = []
    Left = 452
    Top = 16
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A636473426172636F64654944426172636F646501494442617263
      6F64650101010D0A636473426172636F646549444D6F64656C0149444D6F6465
      6C0101010D0A636473426172636F64654D6F64656C014D6F64656C0101010D0A
      636473426172636F64655365617263684944426172636F646501426172636F64
      650143F36469676F204261727261730143F36469676F204261727261010D0A63
      6473426172636F646553656172636849444D6F64656C0149444D6F64656C0101
      010D0A636473426172636F64655365617263684D6F64656C014D6F64656C014D
      6F64656C6F014D6F64656C6F010D0A636473437573746F6D657242616972726F
      0142616972726F0101010D0A636473437573746F6D6572434550015A69700143
      455001436F642E20506F7374616C010D0A636473437573746F6D657243696461
      646501436974790143696461646501436975646164010D0A636473437573746F
      6D657243504601446F63756D656E74014350462F434E504A014964656E746966
      6963616369F36E2023010D0A636473437573746F6D6572456E64657265636F01
      4164647265737301456E64657265E76F0144697265636369F36E010D0A636473
      437573746F6D65724944506573736F61014944506573736F610101010D0A6364
      73437573746F6D6572496E7363457374616475616C01496E7363457374616475
      616C0101010D0A636473437573746F6D6572506573736F61014E616D65014E6F
      6D65014E6F6D627265010D0A636473437573746F6D6572506573736F61466972
      73744E616D650146697273744E616D65014E6F6D65014E6F6D627265010D0A63
      6473437573746F6D6572506573736F614C6173744E616D65014C6173744E616D
      6501536F6272656E6F6D65014170656C6C69646F010D0A636473437573746F6D
      657254656C65666F6E650150686F6E650154656C0154656C010D0A6364734D65
      696F50616749444D65696F5061670149444D65696F5061670101010D0A636473
      4D65696F506167496D616765496E64657801496D616765496E6465780101010D
      0A6364734D65696F5061674D65696F506167014D65696F5061670101010D0A63
      64734D65696F5061675469706F015469706F0101010D0A6364734D6F64656C41
      63636573736F72794465736372697074696F6E014465736372697074696F6E01
      01010D0A6364734D6F64656C4163636573736F7279446973636F756E74506572
      6301446973636F756E74506572630101010D0A6364734D6F64656C4163636573
      736F727948696E740148696E740101010D0A6364734D6F64656C416363657373
      6F72794944496E764163636573736F7279014944496E764163636573736F7279
      0101010D0A6364734D6F64656C4163636573736F727949444D6F64656C014944
      4D6F64656C0101010D0A6364734D6F64656C4163636573736F72794C61726765
      496D616765014C61726765496D6167650101010D0A6364734D6F64656C416363
      6573736F72794D6F64656C014D6F64656C0101010D0A6364734D6F64656C4163
      636573736F727950726F6D6F74696F6E50726963650150726F6D6F74696F6E50
      726963650101010D0A6364734D6F64656C4163636573736F727953656C6C696E
      6750726963650153656C6C696E6750726963650101010D0A6364734F74686572
      436F6D6D697373696F6E4944436F6D697373696F6E61646F014944436F6D6973
      73696F6E61646F0101010D0A6364734F74686572436F6D6D697373696F6E4944
      506573736F61014944506573736F610101010D0A6364734F74686572436F6D6D
      697373696F6E506573736F61014E616D65014E6F6D65014E6F6D627265010D0A
      63647353797374656D55736572436F6D697373696F6E494401436F6D69737369
      6F6E49440101010D0A63647353797374656D5573657249445573657201494455
      7365720101010D0A63647353797374656D5573657253797374656D5573657201
      5573657201557375E172696F015573756172696F010D0A7175426172636F6465
      4944426172636F6465014944426172636F64650101010D0A7175426172636F64
      6549444D6F64656C0149444D6F64656C0101010D0A7175426172636F64654D6F
      64656C014D6F64656C0101010D0A717550726553616C65496E666F4164647265
      737301416464726573730101010D0A717550726553616C65496E666F4169724C
      696E65014169724C696E650101010D0A717550726553616C65496E666F436172
      644E756D62657201436172644E756D6265720101010D0A717550726553616C65
      496E666F436F6D70616E7943474301436F6D70616E794347430101010D0A7175
      50726553616C65496E666F436F6D70616E794E616D6501436F6D70616E794E61
      6D650101010D0A717550726553616C65496E666F44656C697665724164647265
      73730144656C69766572416464726573730101010D0A717550726553616C6549
      6E666F44656C69766572446174650144656C69766572446174650101010D0A71
      7550726553616C65496E666F44656C697665725479706549440144656C697665
      725479706549440101010D0A717550726553616C65496E666F4465706F736974
      44617465014465706F736974446174650101010D0A717550726553616C65496E
      666F46697273744E616D650146697273744E616D650101010D0A717550726553
      616C65496E666F4944437573746F6D6572014944437573746F6D65720101010D
      0A717550726553616C65496E666F4944496E766F696365014944496E766F6963
      650101010D0A717550726553616C65496E666F49444D65696F5061670149444D
      65696F5061670101010D0A717550726553616C65496E666F494450726553616C
      6501494450726553616C650101010D0A717550726553616C65496E666F494453
      746F726501494453746F72650101010D0A717550726553616C65496E666F4944
      546F757269737447726F7570014944546F757269737447726F75700101010D0A
      717550726553616C65496E666F496E766F6963654461746501496E766F696365
      446174650101010D0A717550726553616C65496E666F4C6173744E616D65014C
      6173744E616D650101010D0A717550726553616C65496E666F4C617961776179
      014C6179617761790101010D0A717550726553616C65496E666F4D6564696149
      44014D6564696149440101010D0A717550726553616C65496E666F4E6F746501
      4E6F74650101010D0A717550726553616C65496E666F4F74686572436F6D6973
      73696F6E4944014F74686572436F6D697373696F6E49440101010D0A71755072
      6553616C65496E666F50617373706F72740150617373706F72740101010D0A71
      7550726553616C65496E666F50617373706F7274446174650150617373706F72
      74446174650101010D0A717550726553616C65496E666F50726553616C654461
      74650150726553616C65446174650101010D0A717550726553616C65496E666F
      53616C65436F64650153616C65436F64650101010D0A717550726553616C6549
      6E666F5469636B6574015469636B65740101010D0A717550726553616C65496E
      666F5A6970015A69700101010D0A7370717550726553616C654974656D436F73
      74507269636501436F737450726963650101010D0A7370717550726553616C65
      4974656D4465736372697074696F6E014465736372697074696F6E0101010D0A
      7370717550726553616C654974656D4469736341637475616C01446973634163
      7475616C0101010D0A7370717550726553616C654974656D446973636F756E74
      01446973632E0101010D0A7370717550726553616C654974656D45786368616E
      6765496E766F6963650145786368616E6765496E766F6963650101010D0A7370
      717550726553616C654974656D4944436F6D697373696F6E014944436F6D6973
      73696F6E0101010D0A7370717550726553616C654974656D4944496E76656E74
      6F72794D6F76014944496E76656E746F72794D6F760101010D0A737071755072
      6553616C654974656D494455736572014944557365720101010D0A7370717550
      726553616C654974656D4D6F64656C014D6F64656C0101010D0A737071755072
      6553616C654974656D4D6F64656C4944014D6F64656C49440101010D0A737071
      7550726553616C654974656D53616C655072696365014F757220507269636501
      01010D0A7370717550726553616C654974656D53616C6573506572736F6E0153
      616C6573506572736F6E0101010D0A7370717550726553616C654974656D5365
      7269616C4E756D62657201532F4E0101010D0A7370717550726553616C654974
      656D537562546F74616C4974656D01537562546F74616C4974656D0101010D0A
      7370717550726553616C654974656D5375676752657461696C014D5352500101
      010D0A7370717550726553616C654974656D5461780154617820250101010D0A
      7370717550726553616C654974656D546F74616C4974656D01546F74616C0101
      010D0A7370717550726553616C6556616C7565446973636F756E745072630144
      6973636F756E745072630101010D0A7370717550726553616C6556616C756549
      74656D446973636F756E74014974656D446973636F756E740101010D0A737071
      7550726553616C6556616C75654E6577537562546F74616C014E657753756254
      6F74616C0101010D0A7370717550726553616C6556616C75656E4F70656E5573
      6572016E4F70656E557365720101010D0A7370717550726553616C6556616C75
      6553686F774F70656E557365720153686F774F70656E557365720101010D0A73
      70717550726553616C6556616C75655370656369616C50726963650153706563
      69616C50726963650101010D0A7370717550726553616C6556616C7565537065
      6369616C50726963654944015370656369616C507269636549440101010D0A73
      70717550726553616C6556616C7565537562546F74616C01537562546F74616C
      0101010D0A7370717550726553616C6556616C7565537562546F74616C546178
      61626C6501537562546F74616C54617861626C650101010D0A73707175507265
      53616C6556616C7565546178015461780101010D0A7370717550726553616C65
      56616C75655461784973656D70744974656D446973636F756E74015461784973
      656D70744974656D446973636F756E740101010D0A7370717550726553616C65
      56616C75655461784973656D707456616C7565015461784973656D707456616C
      75650101010D0A7370717550726553616C6556616C75655461784973656E7401
      5461784578656D70740101010D0A7370717550726553616C6556616C75655461
      78507263015461785072630101010D0A7370717550726553616C6556616C7565
      546F74616C496E766F69636501546F74616C496E766F6963650101010D0A6364
      7353797374656D5573657249445469706F506573736F610149445469706F5065
      73736F610101010D0A6364734469736352616E676549445469706F436F6D6973
      73696F6E61646F0149445469706F436F6D697373696F6E61646F0101010D0A63
      64734469736352616E6765546F7456656E64614D696E01546F7456656E64614D
      696E0101010D0A6364734469736352616E676550657263446973634D61780150
      657263446973634D61780101010D0A636473496E764665617475726573494449
      6E764665617475726573014944496E7646656174757265730101010D0A636473
      496E76466561747572657349444D6F64656C0149444D6F64656C0101010D0A63
      6473496E76466561747572657346656174757265014665617475726501436172
      6163746572ED7374696361014361726163746572ED7374696361010D0A636473
      496E7654656368466561744944496E7654656368466561747572657301494449
      6E765465636846656174757265730101010D0A636473496E7654656368466561
      7449444D6F64656C0149444D6F64656C0101010D0A636473496E765465636846
      6561745465636846656174757265015465636846656174757265014361726163
      746572ED7374696361205465632E014361726163746572ED7374696361205465
      632E010D0A7374466F6E74730D0A73744D756C74694C696E65730D0A71755072
      6553616C65496E666F2E53514C0153454C4543542C2220202020202020204944
      50726553616C652C222C22202020202020202049444D65696F506167202C222C
      2220202020202020204944546F757269737447726F75702C222C222020202020
      20202050726553616C6544617465202C222C2220202020202020204F74686572
      436F6D697373696F6E4944202C222C2220202020202020204944437573746F6D
      6572202C222C22202020202020202044656C69766572547970654944202C222C
      22202020202020202044656C6976657244617465202C222C2220202020202020
      2044656C6976657241646472657373202C222C22202020202020202050617373
      706F727444617465202C222C2220202020202020204169724C696E65202C222C
      222020202020202020436F6D70616E794E616D65202C222C2220202020202020
      20436F6D70616E79434743202C222C2220202020202020204465706F73697444
      617465202C222C2220202020202020204E6F7465202C222C2220202020202020
      20496E766F69636544617465202C222C2220202020202020204944496E766F69
      6365202C222C22202020202020202050617373706F7274202C222C2220202020
      202020205469636B65742C222C2220202020202020204D6564696149442C222C
      222020202020202020436172644E756D6265722C222C22202020202020202049
      4453746F72652C222C222020202020202020416464726573732C222C22202020
      20202020204C6179617761792C222C22202020202020202046697273744E616D
      652C222C2220202020202020204C6173744E616D652C222C2220202020202020
      205A69702C222C22202020202020202053616C65436F6465222C46524F4D2C22
      2020202020202020496E766F69636520496E766F696365222C57484552452C22
      2020202020202020494450726553616C65203D203A494450726553616C65222C
      2220222C2220220101010D0A7175426172636F64652E53514C0153454C454354
      2C22094D2E49444D6F64656C2C222C2209422E4944426172636F64652C222C22
      094D2E4D6F64656C222C46524F4D2C2209426172636F64652042222C22094A4F
      494E204D6F64656C204D204F4E20284D2E49444D6F64656C203D20422E49444D
      6F64656C29222C57484552452C220954432E4F7065726174696F6E5479706520
      3D2031222C2209414E44222C220954432E53616C6554617854797065203D2032
      220101010D0A71754D65696F5061672E53514C0153454C4543542C220949444D
      65696F5061672C222C22094D65696F5061672C222C2209496D616765496E6465
      782C222C22202020202020202020202020202020205469706F222C46524F4D2C
      22094D65696F506167222C57484552452C2209506172656E7454797065203D20
      2753616C652720222C2209414E44222C22094465736174697661646F203D2030
      222C2209414E44222C220948696464656E203D2030220101010D0A71754E6577
      437573746F6D65722E53514C0122494E5345525420494E544F20506573736F61
      222C282C224944506573736F612C222C2249445469706F506573736F612C222C
      22494453746F72652C222C2249445469706F506573736F61526F6F742C222C22
      4944557365722C222C22506573736F6146697273744E616D652C222C22506573
      736F614C6173744E616D652C222C22506573736F612C222C22456E6465726563
      6F2C222C224369646164652C222C2242616972726F2C222C224345502C222C22
      54656C65666F6E652C222C224A7572696469636F2C222C4350462C292C56414C
      5545532C282C223A4944506573736F612C222C223A49445469706F506573736F
      612C222C223A494453746F72652C222C223A49445469706F506573736F61526F
      6F742C222C223A4944557365722C222C223A506573736F6146697273744E616D
      652C222C223A506573736F614C6173744E616D652C222C223A506573736F612C
      222C223A456E64657265636F2C222C223A4369646164652C222C223A42616972
      726F2C222C223A4345502C222C223A54656C65666F6E652C222C223A4A757269
      6469636F2C222C3A4350462C290101010D0A7374446C677343617074696F6E73
      0D0A5761726E696E67015761726E696E670101010D0A4572726F72014572726F
      720101010D0A496E666F726D6174696F6E01496E666F726D6174696F6E010101
      0D0A436F6E6669726D01436F6E6669726D0101010D0A59657301265965730101
      010D0A4E6F01264E6F0101010D0A4F4B014F4B0101010D0A43616E63656C0143
      616E63656C0101010D0A41626F7274012641626F72740101010D0A5265747279
      012652657472790101010D0A49676E6F7265012649676E6F72650101010D0A41
      6C6C0126416C6C0101010D0A4E6F20546F20416C6C014E266F20746F20416C6C
      0101010D0A59657320546F20416C6C0159657320746F2026416C6C0101010D0A
      48656C70012648656C700101010D0A7374537472696E67730D0A73744F746865
      72537472696E67730D0A717550726553616C65496E666F2E436F6E6E65637469
      6F6E537472696E67010101010D0A717550726553616C65496E666F2E46696C74
      6572010101010D0A717550726553616C65496E666F494450726553616C652E43
      6F6E73747261696E744572726F724D657373616765010101010D0A7175507265
      53616C65496E666F494450726553616C652E437573746F6D436F6E7374726169
      6E74010101010D0A717550726553616C65496E666F494450726553616C652E44
      656661756C7445787072657373696F6E010101010D0A717550726553616C6549
      6E666F494450726553616C652E45646974466F726D6174010101010D0A717550
      726553616C65496E666F494450726553616C652E496D706F72746564436F6E73
      747261696E74010101010D0A717550726553616C65496E666F49445072655361
      6C652E4B65794669656C6473010101010D0A717550726553616C65496E666F49
      4450726553616C652E4C6F6F6B75704B65794669656C6473010101010D0A7175
      50726553616C65496E666F494450726553616C652E4C6F6F6B7570526573756C
      744669656C64010101010D0A717550726553616C65496E666F49445072655361
      6C652E4F726967696E01496E766F6963652E494450726553616C650101010D0A
      717550726553616C65496E666F49444D65696F5061672E436F6E73747261696E
      744572726F724D657373616765010101010D0A717550726553616C65496E666F
      49444D65696F5061672E437573746F6D436F6E73747261696E74010101010D0A
      717550726553616C65496E666F49444D65696F5061672E44656661756C744578
      7072657373696F6E010101010D0A717550726553616C65496E666F49444D6569
      6F5061672E45646974466F726D6174010101010D0A717550726553616C65496E
      666F49444D65696F5061672E496D706F72746564436F6E73747261696E740101
      01010D0A717550726553616C65496E666F49444D65696F5061672E4B65794669
      656C6473010101010D0A717550726553616C65496E666F49444D65696F506167
      2E4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C6549
      6E666F49444D65696F5061672E4C6F6F6B7570526573756C744669656C640101
      01010D0A717550726553616C65496E666F49444D65696F5061672E4F72696769
      6E01496E766F6963652E49444D65696F5061670101010D0A717550726553616C
      65496E666F4944546F757269737447726F75702E436F6E73747261696E744572
      726F724D657373616765010101010D0A717550726553616C65496E666F494454
      6F757269737447726F75702E437573746F6D436F6E73747261696E7401010101
      0D0A717550726553616C65496E666F4944546F757269737447726F75702E4465
      6661756C7445787072657373696F6E010101010D0A717550726553616C65496E
      666F4944546F757269737447726F75702E45646974466F726D6174010101010D
      0A717550726553616C65496E666F4944546F757269737447726F75702E496D70
      6F72746564436F6E73747261696E74010101010D0A717550726553616C65496E
      666F4944546F757269737447726F75702E4B65794669656C6473010101010D0A
      717550726553616C65496E666F4944546F757269737447726F75702E4C6F6F6B
      75704B65794669656C6473010101010D0A717550726553616C65496E666F4944
      546F757269737447726F75702E4C6F6F6B7570526573756C744669656C640101
      01010D0A717550726553616C65496E666F4944546F757269737447726F75702E
      4F726967696E01496E766F6963652E4944546F757269737447726F7570010101
      0D0A717550726553616C65496E666F50726553616C65446174652E436F6E7374
      7261696E744572726F724D657373616765010101010D0A717550726553616C65
      496E666F50726553616C65446174652E437573746F6D436F6E73747261696E74
      010101010D0A717550726553616C65496E666F50726553616C65446174652E44
      656661756C7445787072657373696F6E010101010D0A717550726553616C6549
      6E666F50726553616C65446174652E496D706F72746564436F6E73747261696E
      74010101010D0A717550726553616C65496E666F50726553616C65446174652E
      4B65794669656C6473010101010D0A717550726553616C65496E666F50726553
      616C65446174652E4C6F6F6B75704B65794669656C6473010101010D0A717550
      726553616C65496E666F50726553616C65446174652E4C6F6F6B757052657375
      6C744669656C64010101010D0A717550726553616C65496E666F50726553616C
      65446174652E4F726967696E01496E766F6963652E50726553616C6544617465
      0101010D0A717550726553616C65496E666F4F74686572436F6D697373696F6E
      49442E436F6E73747261696E744572726F724D657373616765010101010D0A71
      7550726553616C65496E666F4F74686572436F6D697373696F6E49442E437573
      746F6D436F6E73747261696E74010101010D0A717550726553616C65496E666F
      4F74686572436F6D697373696F6E49442E44656661756C744578707265737369
      6F6E010101010D0A717550726553616C65496E666F4F74686572436F6D697373
      696F6E49442E45646974466F726D6174010101010D0A717550726553616C6549
      6E666F4F74686572436F6D697373696F6E49442E496D706F72746564436F6E73
      747261696E74010101010D0A717550726553616C65496E666F4F74686572436F
      6D697373696F6E49442E4B65794669656C6473010101010D0A71755072655361
      6C65496E666F4F74686572436F6D697373696F6E49442E4C6F6F6B75704B6579
      4669656C6473010101010D0A717550726553616C65496E666F4F74686572436F
      6D697373696F6E49442E4C6F6F6B7570526573756C744669656C64010101010D
      0A717550726553616C65496E666F4F74686572436F6D697373696F6E49442E4F
      726967696E01496E766F6963652E4F74686572436F6D697373696F6E49440101
      010D0A717550726553616C65496E666F4944437573746F6D65722E436F6E7374
      7261696E744572726F724D657373616765010101010D0A717550726553616C65
      496E666F4944437573746F6D65722E437573746F6D436F6E73747261696E7401
      0101010D0A717550726553616C65496E666F4944437573746F6D65722E446566
      61756C7445787072657373696F6E010101010D0A717550726553616C65496E66
      6F4944437573746F6D65722E45646974466F726D6174010101010D0A71755072
      6553616C65496E666F4944437573746F6D65722E496D706F72746564436F6E73
      747261696E74010101010D0A717550726553616C65496E666F4944437573746F
      6D65722E4B65794669656C6473010101010D0A717550726553616C65496E666F
      4944437573746F6D65722E4C6F6F6B75704B65794669656C6473010101010D0A
      717550726553616C65496E666F4944437573746F6D65722E4C6F6F6B75705265
      73756C744669656C64010101010D0A717550726553616C65496E666F49444375
      73746F6D65722E4F726967696E01496E766F6963652E4944437573746F6D6572
      0101010D0A717550726553616C65496E666F44656C697665725479706549442E
      436F6E73747261696E744572726F724D657373616765010101010D0A71755072
      6553616C65496E666F44656C697665725479706549442E437573746F6D436F6E
      73747261696E74010101010D0A717550726553616C65496E666F44656C697665
      725479706549442E44656661756C7445787072657373696F6E010101010D0A71
      7550726553616C65496E666F44656C697665725479706549442E45646974466F
      726D6174010101010D0A717550726553616C65496E666F44656C697665725479
      706549442E496D706F72746564436F6E73747261696E74010101010D0A717550
      726553616C65496E666F44656C697665725479706549442E4B65794669656C64
      73010101010D0A717550726553616C65496E666F44656C697665725479706549
      442E4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C65
      496E666F44656C697665725479706549442E4C6F6F6B7570526573756C744669
      656C64010101010D0A717550726553616C65496E666F44656C69766572547970
      6549442E4F726967696E01496E766F6963652E44656C69766572547970654944
      0101010D0A717550726553616C65496E666F44656C69766572446174652E436F
      6E73747261696E744572726F724D657373616765010101010D0A717550726553
      616C65496E666F44656C69766572446174652E437573746F6D436F6E73747261
      696E74010101010D0A717550726553616C65496E666F44656C69766572446174
      652E44656661756C7445787072657373696F6E010101010D0A71755072655361
      6C65496E666F44656C69766572446174652E496D706F72746564436F6E737472
      61696E74010101010D0A717550726553616C65496E666F44656C697665724461
      74652E4B65794669656C6473010101010D0A717550726553616C65496E666F44
      656C69766572446174652E4C6F6F6B75704B65794669656C6473010101010D0A
      717550726553616C65496E666F44656C69766572446174652E4C6F6F6B757052
      6573756C744669656C64010101010D0A717550726553616C65496E666F44656C
      69766572446174652E4F726967696E01496E766F6963652E44656C6976657244
      6174650101010D0A717550726553616C65496E666F44656C6976657241646472
      6573732E436F6E73747261696E744572726F724D657373616765010101010D0A
      717550726553616C65496E666F44656C69766572416464726573732E43757374
      6F6D436F6E73747261696E74010101010D0A717550726553616C65496E666F44
      656C69766572416464726573732E44656661756C7445787072657373696F6E01
      0101010D0A717550726553616C65496E666F44656C6976657241646472657373
      2E496D706F72746564436F6E73747261696E74010101010D0A71755072655361
      6C65496E666F44656C69766572416464726573732E4B65794669656C64730101
      01010D0A717550726553616C65496E666F44656C69766572416464726573732E
      4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C65496E
      666F44656C69766572416464726573732E4C6F6F6B7570526573756C74466965
      6C64010101010D0A717550726553616C65496E666F44656C6976657241646472
      6573732E4F726967696E01496E766F6963652E44656C69766572416464726573
      730101010D0A717550726553616C65496E666F50617373706F7274446174652E
      436F6E73747261696E744572726F724D657373616765010101010D0A71755072
      6553616C65496E666F50617373706F7274446174652E437573746F6D436F6E73
      747261696E74010101010D0A717550726553616C65496E666F50617373706F72
      74446174652E44656661756C7445787072657373696F6E010101010D0A717550
      726553616C65496E666F50617373706F7274446174652E496D706F7274656443
      6F6E73747261696E74010101010D0A717550726553616C65496E666F50617373
      706F7274446174652E4B65794669656C6473010101010D0A717550726553616C
      65496E666F50617373706F7274446174652E4C6F6F6B75704B65794669656C64
      73010101010D0A717550726553616C65496E666F50617373706F727444617465
      2E4C6F6F6B7570526573756C744669656C64010101010D0A717550726553616C
      65496E666F50617373706F7274446174652E4F726967696E01496E766F696365
      2E50617373706F7274446174650101010D0A717550726553616C65496E666F41
      69724C696E652E436F6E73747261696E744572726F724D657373616765010101
      010D0A717550726553616C65496E666F4169724C696E652E437573746F6D436F
      6E73747261696E74010101010D0A717550726553616C65496E666F4169724C69
      6E652E44656661756C7445787072657373696F6E010101010D0A717550726553
      616C65496E666F4169724C696E652E496D706F72746564436F6E73747261696E
      74010101010D0A717550726553616C65496E666F4169724C696E652E4B657946
      69656C6473010101010D0A717550726553616C65496E666F4169724C696E652E
      4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C65496E
      666F4169724C696E652E4C6F6F6B7570526573756C744669656C64010101010D
      0A717550726553616C65496E666F4169724C696E652E4F726967696E01496E76
      6F6963652E4169724C696E650101010D0A717550726553616C65496E666F436F
      6D70616E794E616D652E436F6E73747261696E744572726F724D657373616765
      010101010D0A717550726553616C65496E666F436F6D70616E794E616D652E43
      7573746F6D436F6E73747261696E74010101010D0A717550726553616C65496E
      666F436F6D70616E794E616D652E44656661756C7445787072657373696F6E01
      0101010D0A717550726553616C65496E666F436F6D70616E794E616D652E496D
      706F72746564436F6E73747261696E74010101010D0A717550726553616C6549
      6E666F436F6D70616E794E616D652E4B65794669656C6473010101010D0A7175
      50726553616C65496E666F436F6D70616E794E616D652E4C6F6F6B75704B6579
      4669656C6473010101010D0A717550726553616C65496E666F436F6D70616E79
      4E616D652E4C6F6F6B7570526573756C744669656C64010101010D0A71755072
      6553616C65496E666F436F6D70616E794E616D652E4F726967696E01496E766F
      6963652E436F6D70616E794E616D650101010D0A717550726553616C65496E66
      6F436F6D70616E794347432E436F6E73747261696E744572726F724D65737361
      6765010101010D0A717550726553616C65496E666F436F6D70616E794347432E
      437573746F6D436F6E73747261696E74010101010D0A717550726553616C6549
      6E666F436F6D70616E794347432E44656661756C7445787072657373696F6E01
      0101010D0A717550726553616C65496E666F436F6D70616E794347432E496D70
      6F72746564436F6E73747261696E74010101010D0A717550726553616C65496E
      666F436F6D70616E794347432E4B65794669656C6473010101010D0A71755072
      6553616C65496E666F436F6D70616E794347432E4C6F6F6B75704B6579466965
      6C6473010101010D0A717550726553616C65496E666F436F6D70616E79434743
      2E4C6F6F6B7570526573756C744669656C64010101010D0A717550726553616C
      65496E666F436F6D70616E794347432E4F726967696E01496E766F6963652E43
      6F6D70616E794347430101010D0A717550726553616C65496E666F4465706F73
      6974446174652E436F6E73747261696E744572726F724D657373616765010101
      010D0A717550726553616C65496E666F4465706F736974446174652E43757374
      6F6D436F6E73747261696E74010101010D0A717550726553616C65496E666F44
      65706F736974446174652E44656661756C7445787072657373696F6E01010101
      0D0A717550726553616C65496E666F4465706F736974446174652E496D706F72
      746564436F6E73747261696E74010101010D0A717550726553616C65496E666F
      4465706F736974446174652E4B65794669656C6473010101010D0A7175507265
      53616C65496E666F4465706F736974446174652E4C6F6F6B75704B6579466965
      6C6473010101010D0A717550726553616C65496E666F4465706F736974446174
      652E4C6F6F6B7570526573756C744669656C64010101010D0A71755072655361
      6C65496E666F4465706F736974446174652E4F726967696E01496E766F696365
      2E4465706F736974446174650101010D0A717550726553616C65496E666F4E6F
      74652E436F6E73747261696E744572726F724D657373616765010101010D0A71
      7550726553616C65496E666F4E6F74652E437573746F6D436F6E73747261696E
      74010101010D0A717550726553616C65496E666F4E6F74652E44656661756C74
      45787072657373696F6E010101010D0A717550726553616C65496E666F4E6F74
      652E496D706F72746564436F6E73747261696E74010101010D0A717550726553
      616C65496E666F4E6F74652E4B65794669656C6473010101010D0A7175507265
      53616C65496E666F4E6F74652E4C6F6F6B75704B65794669656C647301010101
      0D0A717550726553616C65496E666F4E6F74652E4C6F6F6B7570526573756C74
      4669656C64010101010D0A717550726553616C65496E666F4E6F74652E4F7269
      67696E01496E766F6963652E4E6F74650101010D0A717550726553616C65496E
      666F496E766F696365446174652E436F6E73747261696E744572726F724D6573
      73616765010101010D0A717550726553616C65496E666F496E766F6963654461
      74652E437573746F6D436F6E73747261696E74010101010D0A71755072655361
      6C65496E666F496E766F696365446174652E44656661756C7445787072657373
      696F6E010101010D0A717550726553616C65496E666F496E766F696365446174
      652E496D706F72746564436F6E73747261696E74010101010D0A717550726553
      616C65496E666F496E766F696365446174652E4B65794669656C647301010101
      0D0A717550726553616C65496E666F496E766F696365446174652E4C6F6F6B75
      704B65794669656C6473010101010D0A717550726553616C65496E666F496E76
      6F696365446174652E4C6F6F6B7570526573756C744669656C64010101010D0A
      717550726553616C65496E666F496E766F696365446174652E4F726967696E01
      496E766F6963652E496E766F696365446174650101010D0A717550726553616C
      65496E666F4944496E766F6963652E436F6E73747261696E744572726F724D65
      7373616765010101010D0A717550726553616C65496E666F4944496E766F6963
      652E437573746F6D436F6E73747261696E74010101010D0A717550726553616C
      65496E666F4944496E766F6963652E44656661756C7445787072657373696F6E
      010101010D0A717550726553616C65496E666F4944496E766F6963652E456469
      74466F726D6174010101010D0A717550726553616C65496E666F4944496E766F
      6963652E496D706F72746564436F6E73747261696E74010101010D0A71755072
      6553616C65496E666F4944496E766F6963652E4B65794669656C647301010101
      0D0A717550726553616C65496E666F4944496E766F6963652E4C6F6F6B75704B
      65794669656C6473010101010D0A717550726553616C65496E666F4944496E76
      6F6963652E4C6F6F6B7570526573756C744669656C64010101010D0A71755072
      6553616C65496E666F4944496E766F6963652E4F726967696E01496E766F6963
      652E4944496E766F6963650101010D0A717550726553616C65496E666F506173
      73706F72742E436F6E73747261696E744572726F724D65737361676501010101
      0D0A717550726553616C65496E666F50617373706F72742E437573746F6D436F
      6E73747261696E74010101010D0A717550726553616C65496E666F5061737370
      6F72742E44656661756C7445787072657373696F6E010101010D0A7175507265
      53616C65496E666F50617373706F72742E496D706F72746564436F6E73747261
      696E74010101010D0A717550726553616C65496E666F50617373706F72742E4B
      65794669656C6473010101010D0A717550726553616C65496E666F5061737370
      6F72742E4C6F6F6B75704B65794669656C6473010101010D0A71755072655361
      6C65496E666F50617373706F72742E4C6F6F6B7570526573756C744669656C64
      010101010D0A717550726553616C65496E666F50617373706F72742E4F726967
      696E01496E766F6963652E50617373706F72740101010D0A717550726553616C
      65496E666F5469636B65742E436F6E73747261696E744572726F724D65737361
      6765010101010D0A717550726553616C65496E666F5469636B65742E43757374
      6F6D436F6E73747261696E74010101010D0A717550726553616C65496E666F54
      69636B65742E44656661756C7445787072657373696F6E010101010D0A717550
      726553616C65496E666F5469636B65742E496D706F72746564436F6E73747261
      696E74010101010D0A717550726553616C65496E666F5469636B65742E4B6579
      4669656C6473010101010D0A717550726553616C65496E666F5469636B65742E
      4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C65496E
      666F5469636B65742E4C6F6F6B7570526573756C744669656C64010101010D0A
      717550726553616C65496E666F5469636B65742E4F726967696E01496E766F69
      63652E5469636B65740101010D0A717550726553616C65496E666F4D65646961
      49442E436F6E73747261696E744572726F724D657373616765010101010D0A71
      7550726553616C65496E666F4D6564696149442E437573746F6D436F6E737472
      61696E74010101010D0A717550726553616C65496E666F4D6564696149442E44
      656661756C7445787072657373696F6E010101010D0A717550726553616C6549
      6E666F4D6564696149442E45646974466F726D6174010101010D0A7175507265
      53616C65496E666F4D6564696149442E496D706F72746564436F6E7374726169
      6E74010101010D0A717550726553616C65496E666F4D6564696149442E4B6579
      4669656C6473010101010D0A717550726553616C65496E666F4D656469614944
      2E4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C6549
      6E666F4D6564696149442E4C6F6F6B7570526573756C744669656C6401010101
      0D0A717550726553616C65496E666F4D6564696149442E4F726967696E01496E
      766F6963652E494450726553616C650101010D0A717550726553616C65496E66
      6F436172644E756D6265722E436F6E73747261696E744572726F724D65737361
      6765010101010D0A717550726553616C65496E666F436172644E756D6265722E
      437573746F6D436F6E73747261696E74010101010D0A717550726553616C6549
      6E666F436172644E756D6265722E44656661756C7445787072657373696F6E01
      0101010D0A717550726553616C65496E666F436172644E756D6265722E496D70
      6F72746564436F6E73747261696E74010101010D0A717550726553616C65496E
      666F436172644E756D6265722E4B65794669656C6473010101010D0A71755072
      6553616C65496E666F436172644E756D6265722E4C6F6F6B75704B6579466965
      6C6473010101010D0A717550726553616C65496E666F436172644E756D626572
      2E4C6F6F6B7570526573756C744669656C64010101010D0A717550726553616C
      65496E666F436172644E756D6265722E4F726967696E01496E766F6963652E49
      4450726553616C650101010D0A717550726553616C65496E666F494453746F72
      652E436F6E73747261696E744572726F724D657373616765010101010D0A7175
      50726553616C65496E666F494453746F72652E437573746F6D436F6E73747261
      696E74010101010D0A717550726553616C65496E666F494453746F72652E4465
      6661756C7445787072657373696F6E010101010D0A717550726553616C65496E
      666F494453746F72652E45646974466F726D6174010101010D0A717550726553
      616C65496E666F494453746F72652E496D706F72746564436F6E73747261696E
      74010101010D0A717550726553616C65496E666F494453746F72652E4B657946
      69656C6473010101010D0A717550726553616C65496E666F494453746F72652E
      4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C65496E
      666F494453746F72652E4C6F6F6B7570526573756C744669656C64010101010D
      0A717550726553616C65496E666F494453746F72652E4F726967696E01496E76
      6F6963652E494450726553616C650101010D0A717550726553616C65496E666F
      416464726573732E436F6E73747261696E744572726F724D6573736167650101
      01010D0A717550726553616C65496E666F416464726573732E437573746F6D43
      6F6E73747261696E74010101010D0A717550726553616C65496E666F41646472
      6573732E44656661756C7445787072657373696F6E010101010D0A7175507265
      53616C65496E666F416464726573732E496D706F72746564436F6E7374726169
      6E74010101010D0A717550726553616C65496E666F416464726573732E4B6579
      4669656C6473010101010D0A717550726553616C65496E666F41646472657373
      2E4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C6549
      6E666F416464726573732E4C6F6F6B7570526573756C744669656C6401010101
      0D0A717550726553616C65496E666F416464726573732E4F726967696E01496E
      766F6963652E494450726553616C650101010D0A717550726553616C65496E66
      6F4C6179617761792E436F6E73747261696E744572726F724D65737361676501
      0101010D0A717550726553616C65496E666F4C6179617761792E437573746F6D
      436F6E73747261696E74010101010D0A717550726553616C65496E666F4C6179
      617761792E44656661756C7445787072657373696F6E010101010D0A71755072
      6553616C65496E666F4C6179617761792E446973706C617956616C7565730101
      01010D0A717550726553616C65496E666F4C6179617761792E496D706F727465
      64436F6E73747261696E74010101010D0A717550726553616C65496E666F4C61
      79617761792E4B65794669656C6473010101010D0A717550726553616C65496E
      666F4C6179617761792E4C6F6F6B75704B65794669656C6473010101010D0A71
      7550726553616C65496E666F4C6179617761792E4C6F6F6B7570526573756C74
      4669656C64010101010D0A717550726553616C65496E666F4C6179617761792E
      4F726967696E010101010D0A717550726553616C65496E666F46697273744E61
      6D652E436F6E73747261696E744572726F724D657373616765010101010D0A71
      7550726553616C65496E666F46697273744E616D652E437573746F6D436F6E73
      747261696E74010101010D0A717550726553616C65496E666F46697273744E61
      6D652E44656661756C7445787072657373696F6E010101010D0A717550726553
      616C65496E666F46697273744E616D652E496D706F72746564436F6E73747261
      696E74010101010D0A717550726553616C65496E666F46697273744E616D652E
      4B65794669656C6473010101010D0A717550726553616C65496E666F46697273
      744E616D652E4C6F6F6B75704B65794669656C6473010101010D0A7175507265
      53616C65496E666F46697273744E616D652E4C6F6F6B7570526573756C744669
      656C64010101010D0A717550726553616C65496E666F46697273744E616D652E
      4F726967696E010101010D0A717550726553616C65496E666F4C6173744E616D
      652E436F6E73747261696E744572726F724D657373616765010101010D0A7175
      50726553616C65496E666F4C6173744E616D652E437573746F6D436F6E737472
      61696E74010101010D0A717550726553616C65496E666F4C6173744E616D652E
      44656661756C7445787072657373696F6E010101010D0A717550726553616C65
      496E666F4C6173744E616D652E496D706F72746564436F6E73747261696E7401
      0101010D0A717550726553616C65496E666F4C6173744E616D652E4B65794669
      656C6473010101010D0A717550726553616C65496E666F4C6173744E616D652E
      4C6F6F6B75704B65794669656C6473010101010D0A717550726553616C65496E
      666F4C6173744E616D652E4C6F6F6B7570526573756C744669656C6401010101
      0D0A717550726553616C65496E666F4C6173744E616D652E4F726967696E0101
      01010D0A717550726553616C65496E666F5A69702E436F6E73747261696E7445
      72726F724D657373616765010101010D0A717550726553616C65496E666F5A69
      702E437573746F6D436F6E73747261696E74010101010D0A717550726553616C
      65496E666F5A69702E44656661756C7445787072657373696F6E010101010D0A
      717550726553616C65496E666F5A69702E496D706F72746564436F6E73747261
      696E74010101010D0A717550726553616C65496E666F5A69702E4B6579466965
      6C6473010101010D0A717550726553616C65496E666F5A69702E4C6F6F6B7570
      4B65794669656C6473010101010D0A717550726553616C65496E666F5A69702E
      4C6F6F6B7570526573756C744669656C64010101010D0A717550726553616C65
      496E666F5A69702E4F726967696E010101010D0A717550726553616C65496E66
      6F53616C65436F64652E436F6E73747261696E744572726F724D657373616765
      010101010D0A717550726553616C65496E666F53616C65436F64652E43757374
      6F6D436F6E73747261696E74010101010D0A717550726553616C65496E666F53
      616C65436F64652E44656661756C7445787072657373696F6E010101010D0A71
      7550726553616C65496E666F53616C65436F64652E496D706F72746564436F6E
      73747261696E74010101010D0A717550726553616C65496E666F53616C65436F
      64652E4B65794669656C6473010101010D0A717550726553616C65496E666F53
      616C65436F64652E4C6F6F6B75704B65794669656C6473010101010D0A717550
      726553616C65496E666F53616C65436F64652E4C6F6F6B7570526573756C7446
      69656C64010101010D0A717550726553616C65496E666F53616C65436F64652E
      4F726967696E010101010D0A7370717550726553616C654974656D2E436F6E6E
      656374696F6E537472696E67010101010D0A7370717550726553616C65497465
      6D2E46696C746572010101010D0A7370717550726553616C654974656D2E5072
      6F6365647572654E616D650173705F50726553616C655F717550726553616C65
      4974656D3B310101010D0A7370717550726553616C654974656D4D6F64656C49
      442E436F6E73747261696E744572726F724D657373616765010101010D0A7370
      717550726553616C654974656D4D6F64656C49442E437573746F6D436F6E7374
      7261696E74010101010D0A7370717550726553616C654974656D4D6F64656C49
      442E44656661756C7445787072657373696F6E010101010D0A73707175507265
      53616C654974656D4D6F64656C49442E45646974466F726D6174010101010D0A
      7370717550726553616C654974656D4D6F64656C49442E496D706F7274656443
      6F6E73747261696E74010101010D0A7370717550726553616C654974656D4D6F
      64656C49442E4B65794669656C6473010101010D0A7370717550726553616C65
      4974656D4D6F64656C49442E4C6F6F6B75704B65794669656C6473010101010D
      0A7370717550726553616C654974656D4D6F64656C49442E4C6F6F6B75705265
      73756C744669656C64010101010D0A7370717550726553616C654974656D4D6F
      64656C49442E4F726967696E010101010D0A7370717550726553616C65497465
      6D4D6F64656C2E436F6E73747261696E744572726F724D657373616765010101
      010D0A7370717550726553616C654974656D4D6F64656C2E437573746F6D436F
      6E73747261696E74010101010D0A7370717550726553616C654974656D4D6F64
      656C2E44656661756C7445787072657373696F6E010101010D0A737071755072
      6553616C654974656D4D6F64656C2E496D706F72746564436F6E73747261696E
      74010101010D0A7370717550726553616C654974656D4D6F64656C2E4B657946
      69656C6473010101010D0A7370717550726553616C654974656D4D6F64656C2E
      4C6F6F6B75704B65794669656C6473010101010D0A7370717550726553616C65
      4974656D4D6F64656C2E4C6F6F6B7570526573756C744669656C64010101010D
      0A7370717550726553616C654974656D4D6F64656C2E4F726967696E01010101
      0D0A7370717550726553616C654974656D4465736372697074696F6E2E436F6E
      73747261696E744572726F724D657373616765010101010D0A73707175507265
      53616C654974656D4465736372697074696F6E2E437573746F6D436F6E737472
      61696E74010101010D0A7370717550726553616C654974656D44657363726970
      74696F6E2E44656661756C7445787072657373696F6E010101010D0A73707175
      50726553616C654974656D4465736372697074696F6E2E496D706F7274656443
      6F6E73747261696E74010101010D0A7370717550726553616C654974656D4465
      736372697074696F6E2E4B65794669656C6473010101010D0A73707175507265
      53616C654974656D4465736372697074696F6E2E4C6F6F6B75704B6579466965
      6C6473010101010D0A7370717550726553616C654974656D4465736372697074
      696F6E2E4C6F6F6B7570526573756C744669656C64010101010D0A7370717550
      726553616C654974656D4465736372697074696F6E2E4F726967696E01010101
      0D0A7370717550726553616C654974656D53616C6550726963652E436F6E7374
      7261696E744572726F724D657373616765010101010D0A737071755072655361
      6C654974656D53616C6550726963652E437573746F6D436F6E73747261696E74
      010101010D0A7370717550726553616C654974656D53616C6550726963652E44
      656661756C7445787072657373696F6E010101010D0A7370717550726553616C
      654974656D53616C6550726963652E45646974466F726D6174010101010D0A73
      70717550726553616C654974656D53616C6550726963652E496D706F72746564
      436F6E73747261696E74010101010D0A7370717550726553616C654974656D53
      616C6550726963652E4B65794669656C6473010101010D0A7370717550726553
      616C654974656D53616C6550726963652E4C6F6F6B75704B65794669656C6473
      010101010D0A7370717550726553616C654974656D53616C6550726963652E4C
      6F6F6B7570526573756C744669656C64010101010D0A7370717550726553616C
      654974656D53616C6550726963652E4F726967696E010101010D0A7370717550
      726553616C654974656D4469736341637475616C2E436F6E73747261696E7445
      72726F724D657373616765010101010D0A7370717550726553616C654974656D
      4469736341637475616C2E437573746F6D436F6E73747261696E74010101010D
      0A7370717550726553616C654974656D4469736341637475616C2E4465666175
      6C7445787072657373696F6E010101010D0A7370717550726553616C65497465
      6D4469736341637475616C2E45646974466F726D6174010101010D0A73707175
      50726553616C654974656D4469736341637475616C2E496D706F72746564436F
      6E73747261696E74010101010D0A7370717550726553616C654974656D446973
      6341637475616C2E4B65794669656C6473010101010D0A737071755072655361
      6C654974656D4469736341637475616C2E4C6F6F6B75704B65794669656C6473
      010101010D0A7370717550726553616C654974656D4469736341637475616C2E
      4C6F6F6B7570526573756C744669656C64010101010D0A737071755072655361
      6C654974656D4469736341637475616C2E4F726967696E010101010D0A737071
      7550726553616C654974656D446973636F756E742E436F6E73747261696E7445
      72726F724D657373616765010101010D0A7370717550726553616C654974656D
      446973636F756E742E437573746F6D436F6E73747261696E74010101010D0A73
      70717550726553616C654974656D446973636F756E742E44656661756C744578
      7072657373696F6E010101010D0A7370717550726553616C654974656D446973
      636F756E742E45646974466F726D6174010101010D0A7370717550726553616C
      654974656D446973636F756E742E496D706F72746564436F6E73747261696E74
      010101010D0A7370717550726553616C654974656D446973636F756E742E4B65
      794669656C6473010101010D0A7370717550726553616C654974656D44697363
      6F756E742E4C6F6F6B75704B65794669656C6473010101010D0A737071755072
      6553616C654974656D446973636F756E742E4C6F6F6B7570526573756C744669
      656C64010101010D0A7370717550726553616C654974656D446973636F756E74
      2E4F726967696E010101010D0A7370717550726553616C654974656D4944496E
      76656E746F72794D6F762E436F6E73747261696E744572726F724D6573736167
      65010101010D0A7370717550726553616C654974656D4944496E76656E746F72
      794D6F762E437573746F6D436F6E73747261696E74010101010D0A7370717550
      726553616C654974656D4944496E76656E746F72794D6F762E44656661756C74
      45787072657373696F6E010101010D0A7370717550726553616C654974656D49
      44496E76656E746F72794D6F762E45646974466F726D6174010101010D0A7370
      717550726553616C654974656D4944496E76656E746F72794D6F762E496D706F
      72746564436F6E73747261696E74010101010D0A7370717550726553616C6549
      74656D4944496E76656E746F72794D6F762E4B65794669656C6473010101010D
      0A7370717550726553616C654974656D4944496E76656E746F72794D6F762E4C
      6F6F6B75704B65794669656C6473010101010D0A7370717550726553616C6549
      74656D4944496E76656E746F72794D6F762E4C6F6F6B7570526573756C744669
      656C64010101010D0A7370717550726553616C654974656D4944496E76656E74
      6F72794D6F762E4F726967696E010101010D0A7370717550726553616C654974
      656D546F74616C4974656D2E436F6E73747261696E744572726F724D65737361
      6765010101010D0A7370717550726553616C654974656D546F74616C4974656D
      2E437573746F6D436F6E73747261696E74010101010D0A737071755072655361
      6C654974656D546F74616C4974656D2E44656661756C7445787072657373696F
      6E010101010D0A7370717550726553616C654974656D546F74616C4974656D2E
      45646974466F726D6174010101010D0A7370717550726553616C654974656D54
      6F74616C4974656D2E496D706F72746564436F6E73747261696E74010101010D
      0A7370717550726553616C654974656D546F74616C4974656D2E4B6579466965
      6C6473010101010D0A7370717550726553616C654974656D546F74616C497465
      6D2E4C6F6F6B75704B65794669656C6473010101010D0A737071755072655361
      6C654974656D546F74616C4974656D2E4C6F6F6B7570526573756C744669656C
      64010101010D0A7370717550726553616C654974656D546F74616C4974656D2E
      4F726967696E010101010D0A7370717550726553616C654974656D53616C6573
      506572736F6E2E436F6E73747261696E744572726F724D657373616765010101
      010D0A7370717550726553616C654974656D53616C6573506572736F6E2E4375
      73746F6D436F6E73747261696E74010101010D0A7370717550726553616C6549
      74656D53616C6573506572736F6E2E44656661756C7445787072657373696F6E
      010101010D0A7370717550726553616C654974656D53616C6573506572736F6E
      2E496D706F72746564436F6E73747261696E74010101010D0A73707175507265
      53616C654974656D53616C6573506572736F6E2E4B65794669656C6473010101
      010D0A7370717550726553616C654974656D53616C6573506572736F6E2E4C6F
      6F6B75704B65794669656C6473010101010D0A7370717550726553616C654974
      656D53616C6573506572736F6E2E4C6F6F6B7570526573756C744669656C6401
      0101010D0A7370717550726553616C654974656D53616C6573506572736F6E2E
      4F726967696E010101010D0A7370717550726553616C654974656D4944436F6D
      697373696F6E2E436F6E73747261696E744572726F724D657373616765010101
      010D0A7370717550726553616C654974656D4944436F6D697373696F6E2E4375
      73746F6D436F6E73747261696E74010101010D0A7370717550726553616C6549
      74656D4944436F6D697373696F6E2E44656661756C7445787072657373696F6E
      010101010D0A7370717550726553616C654974656D4944436F6D697373696F6E
      2E45646974466F726D6174010101010D0A7370717550726553616C654974656D
      4944436F6D697373696F6E2E496D706F72746564436F6E73747261696E740101
      01010D0A7370717550726553616C654974656D4944436F6D697373696F6E2E4B
      65794669656C6473010101010D0A7370717550726553616C654974656D494443
      6F6D697373696F6E2E4C6F6F6B75704B65794669656C6473010101010D0A7370
      717550726553616C654974656D4944436F6D697373696F6E2E4C6F6F6B757052
      6573756C744669656C64010101010D0A7370717550726553616C654974656D49
      44436F6D697373696F6E2E4F726967696E010101010D0A737071755072655361
      6C654974656D436F737450726963652E436F6E73747261696E744572726F724D
      657373616765010101010D0A7370717550726553616C654974656D436F737450
      726963652E437573746F6D436F6E73747261696E74010101010D0A7370717550
      726553616C654974656D436F737450726963652E44656661756C744578707265
      7373696F6E010101010D0A7370717550726553616C654974656D436F73745072
      6963652E45646974466F726D6174010101010D0A7370717550726553616C6549
      74656D436F737450726963652E496D706F72746564436F6E73747261696E7401
      0101010D0A7370717550726553616C654974656D436F737450726963652E4B65
      794669656C6473010101010D0A7370717550726553616C654974656D436F7374
      50726963652E4C6F6F6B75704B65794669656C6473010101010D0A7370717550
      726553616C654974656D436F737450726963652E4C6F6F6B7570526573756C74
      4669656C64010101010D0A7370717550726553616C654974656D436F73745072
      6963652E4F726967696E010101010D0A7370717550726553616C654974656D45
      786368616E6765496E766F6963652E436F6E73747261696E744572726F724D65
      7373616765010101010D0A7370717550726553616C654974656D45786368616E
      6765496E766F6963652E437573746F6D436F6E73747261696E74010101010D0A
      7370717550726553616C654974656D45786368616E6765496E766F6963652E44
      656661756C7445787072657373696F6E010101010D0A7370717550726553616C
      654974656D45786368616E6765496E766F6963652E45646974466F726D617401
      0101010D0A7370717550726553616C654974656D45786368616E6765496E766F
      6963652E496D706F72746564436F6E73747261696E74010101010D0A73707175
      50726553616C654974656D45786368616E6765496E766F6963652E4B65794669
      656C6473010101010D0A7370717550726553616C654974656D45786368616E67
      65496E766F6963652E4C6F6F6B75704B65794669656C6473010101010D0A7370
      717550726553616C654974656D45786368616E6765496E766F6963652E4C6F6F
      6B7570526573756C744669656C64010101010D0A7370717550726553616C6549
      74656D45786368616E6765496E766F6963652E4F726967696E010101010D0A73
      70717550726553616C654974656D5375676752657461696C2E436F6E73747261
      696E744572726F724D657373616765010101010D0A7370717550726553616C65
      4974656D5375676752657461696C2E437573746F6D436F6E73747261696E7401
      0101010D0A7370717550726553616C654974656D5375676752657461696C2E44
      656661756C7445787072657373696F6E010101010D0A7370717550726553616C
      654974656D5375676752657461696C2E45646974466F726D6174010101010D0A
      7370717550726553616C654974656D5375676752657461696C2E496D706F7274
      6564436F6E73747261696E74010101010D0A7370717550726553616C65497465
      6D5375676752657461696C2E4B65794669656C6473010101010D0A7370717550
      726553616C654974656D5375676752657461696C2E4C6F6F6B75704B65794669
      656C6473010101010D0A7370717550726553616C654974656D53756767526574
      61696C2E4C6F6F6B7570526573756C744669656C64010101010D0A7370717550
      726553616C654974656D5375676752657461696C2E4F726967696E010101010D
      0A7370717550726553616C654974656D53657269616C4E756D6265722E436F6E
      73747261696E744572726F724D657373616765010101010D0A73707175507265
      53616C654974656D53657269616C4E756D6265722E437573746F6D436F6E7374
      7261696E74010101010D0A7370717550726553616C654974656D53657269616C
      4E756D6265722E44656661756C7445787072657373696F6E010101010D0A7370
      717550726553616C654974656D53657269616C4E756D6265722E446973706C61
      7956616C756573010101010D0A7370717550726553616C654974656D53657269
      616C4E756D6265722E496D706F72746564436F6E73747261696E74010101010D
      0A7370717550726553616C654974656D53657269616C4E756D6265722E4B6579
      4669656C6473010101010D0A7370717550726553616C654974656D5365726961
      6C4E756D6265722E4C6F6F6B75704B65794669656C6473010101010D0A737071
      7550726553616C654974656D53657269616C4E756D6265722E4C6F6F6B757052
      6573756C744669656C64010101010D0A7370717550726553616C654974656D53
      657269616C4E756D6265722E4F726967696E010101010D0A7370717550726553
      616C654974656D4944557365722E436F6E73747261696E744572726F724D6573
      73616765010101010D0A7370717550726553616C654974656D4944557365722E
      437573746F6D436F6E73747261696E74010101010D0A7370717550726553616C
      654974656D4944557365722E44656661756C7445787072657373696F6E010101
      010D0A7370717550726553616C654974656D4944557365722E45646974466F72
      6D6174010101010D0A7370717550726553616C654974656D4944557365722E49
      6D706F72746564436F6E73747261696E74010101010D0A737071755072655361
      6C654974656D4944557365722E4B65794669656C6473010101010D0A73707175
      50726553616C654974656D4944557365722E4C6F6F6B75704B65794669656C64
      73010101010D0A7370717550726553616C654974656D4944557365722E4C6F6F
      6B7570526573756C744669656C64010101010D0A7370717550726553616C6549
      74656D4944557365722E4F726967696E010101010D0A7370717550726553616C
      654974656D5461782E436F6E73747261696E744572726F724D65737361676501
      0101010D0A7370717550726553616C654974656D5461782E437573746F6D436F
      6E73747261696E74010101010D0A7370717550726553616C654974656D546178
      2E44656661756C7445787072657373696F6E010101010D0A7370717550726553
      616C654974656D5461782E45646974466F726D6174010101010D0A7370717550
      726553616C654974656D5461782E496D706F72746564436F6E73747261696E74
      010101010D0A7370717550726553616C654974656D5461782E4B65794669656C
      6473010101010D0A7370717550726553616C654974656D5461782E4C6F6F6B75
      704B65794669656C6473010101010D0A7370717550726553616C654974656D54
      61782E4C6F6F6B7570526573756C744669656C64010101010D0A737071755072
      6553616C654974656D5461782E4F726967696E010101010D0A73707175507265
      53616C654974656D537562546F74616C4974656D2E436F6E73747261696E7445
      72726F724D657373616765010101010D0A7370717550726553616C654974656D
      537562546F74616C4974656D2E437573746F6D436F6E73747261696E74010101
      010D0A7370717550726553616C654974656D537562546F74616C4974656D2E44
      656661756C7445787072657373696F6E010101010D0A7370717550726553616C
      654974656D537562546F74616C4974656D2E45646974466F726D617401010101
      0D0A7370717550726553616C654974656D537562546F74616C4974656D2E496D
      706F72746564436F6E73747261696E74010101010D0A7370717550726553616C
      654974656D537562546F74616C4974656D2E4B65794669656C6473010101010D
      0A7370717550726553616C654974656D537562546F74616C4974656D2E4C6F6F
      6B75704B65794669656C6473010101010D0A7370717550726553616C65497465
      6D537562546F74616C4974656D2E4C6F6F6B7570526573756C744669656C6401
      0101010D0A7370717550726553616C654974656D537562546F74616C4974656D
      2E4F726967696E010101010D0A7370717550726553616C6556616C75652E436F
      6E6E656374696F6E537472696E67010101010D0A7370717550726553616C6556
      616C75652E46696C746572010101010D0A7370717550726553616C6556616C75
      652E50726F6365647572654E616D650173705F50726553616C655F7175507265
      53616C6556616C75653B310101010D0A7370717550726553616C6556616C7565
      5461784973656E742E436F6E73747261696E744572726F724D65737361676501
      0101010D0A7370717550726553616C6556616C75655461784973656E742E4375
      73746F6D436F6E73747261696E74010101010D0A7370717550726553616C6556
      616C75655461784973656E742E44656661756C7445787072657373696F6E0101
      01010D0A7370717550726553616C6556616C75655461784973656E742E446973
      706C617956616C756573010101010D0A7370717550726553616C6556616C7565
      5461784973656E742E496D706F72746564436F6E73747261696E74010101010D
      0A7370717550726553616C6556616C75655461784973656E742E4B6579466965
      6C6473010101010D0A7370717550726553616C6556616C75655461784973656E
      742E4C6F6F6B75704B65794669656C6473010101010D0A737071755072655361
      6C6556616C75655461784973656E742E4C6F6F6B7570526573756C744669656C
      64010101010D0A7370717550726553616C6556616C75655461784973656E742E
      4F726967696E010101010D0A7370717550726553616C6556616C756553756254
      6F74616C2E436F6E73747261696E744572726F724D657373616765010101010D
      0A7370717550726553616C6556616C7565537562546F74616C2E437573746F6D
      436F6E73747261696E74010101010D0A7370717550726553616C6556616C7565
      537562546F74616C2E44656661756C7445787072657373696F6E010101010D0A
      7370717550726553616C6556616C7565537562546F74616C2E45646974466F72
      6D6174010101010D0A7370717550726553616C6556616C7565537562546F7461
      6C2E496D706F72746564436F6E73747261696E74010101010D0A737071755072
      6553616C6556616C7565537562546F74616C2E4B65794669656C647301010101
      0D0A7370717550726553616C6556616C7565537562546F74616C2E4C6F6F6B75
      704B65794669656C6473010101010D0A7370717550726553616C6556616C7565
      537562546F74616C2E4C6F6F6B7570526573756C744669656C64010101010D0A
      7370717550726553616C6556616C7565537562546F74616C2E4F726967696E01
      0101010D0A7370717550726553616C6556616C75654974656D446973636F756E
      742E436F6E73747261696E744572726F724D657373616765010101010D0A7370
      717550726553616C6556616C75654974656D446973636F756E742E437573746F
      6D436F6E73747261696E74010101010D0A7370717550726553616C6556616C75
      654974656D446973636F756E742E44656661756C7445787072657373696F6E01
      0101010D0A7370717550726553616C6556616C75654974656D446973636F756E
      742E45646974466F726D6174010101010D0A7370717550726553616C6556616C
      75654974656D446973636F756E742E496D706F72746564436F6E73747261696E
      74010101010D0A7370717550726553616C6556616C75654974656D446973636F
      756E742E4B65794669656C6473010101010D0A7370717550726553616C655661
      6C75654974656D446973636F756E742E4C6F6F6B75704B65794669656C647301
      0101010D0A7370717550726553616C6556616C75654974656D446973636F756E
      742E4C6F6F6B7570526573756C744669656C64010101010D0A73707175507265
      53616C6556616C75654974656D446973636F756E742E4F726967696E01010101
      0D0A7370717550726553616C6556616C75655461782E436F6E73747261696E74
      4572726F724D657373616765010101010D0A7370717550726553616C6556616C
      75655461782E437573746F6D436F6E73747261696E74010101010D0A73707175
      50726553616C6556616C75655461782E44656661756C7445787072657373696F
      6E010101010D0A7370717550726553616C6556616C75655461782E4564697446
      6F726D6174010101010D0A7370717550726553616C6556616C75655461782E49
      6D706F72746564436F6E73747261696E74010101010D0A737071755072655361
      6C6556616C75655461782E4B65794669656C6473010101010D0A737071755072
      6553616C6556616C75655461782E4C6F6F6B75704B65794669656C6473010101
      010D0A7370717550726553616C6556616C75655461782E4C6F6F6B7570526573
      756C744669656C64010101010D0A7370717550726553616C6556616C75655461
      782E4F726967696E010101010D0A7370717550726553616C6556616C75655461
      785072632E436F6E73747261696E744572726F724D657373616765010101010D
      0A7370717550726553616C6556616C75655461785072632E437573746F6D436F
      6E73747261696E74010101010D0A7370717550726553616C6556616C75655461
      785072632E44656661756C7445787072657373696F6E010101010D0A73707175
      50726553616C6556616C75655461785072632E45646974466F726D6174010101
      010D0A7370717550726553616C6556616C75655461785072632E496D706F7274
      6564436F6E73747261696E74010101010D0A7370717550726553616C6556616C
      75655461785072632E4B65794669656C6473010101010D0A7370717550726553
      616C6556616C75655461785072632E4C6F6F6B75704B65794669656C64730101
      01010D0A7370717550726553616C6556616C75655461785072632E4C6F6F6B75
      70526573756C744669656C64010101010D0A7370717550726553616C6556616C
      75655461785072632E4F726967696E010101010D0A7370717550726553616C65
      56616C7565446973636F756E745072632E436F6E73747261696E744572726F72
      4D657373616765010101010D0A7370717550726553616C6556616C7565446973
      636F756E745072632E437573746F6D436F6E73747261696E74010101010D0A73
      70717550726553616C6556616C7565446973636F756E745072632E4465666175
      6C7445787072657373696F6E010101010D0A7370717550726553616C6556616C
      7565446973636F756E745072632E45646974466F726D6174010101010D0A7370
      717550726553616C6556616C7565446973636F756E745072632E496D706F7274
      6564436F6E73747261696E74010101010D0A7370717550726553616C6556616C
      7565446973636F756E745072632E4B65794669656C6473010101010D0A737071
      7550726553616C6556616C7565446973636F756E745072632E4C6F6F6B75704B
      65794669656C6473010101010D0A7370717550726553616C6556616C75654469
      73636F756E745072632E4C6F6F6B7570526573756C744669656C64010101010D
      0A7370717550726553616C6556616C7565446973636F756E745072632E4F7269
      67696E010101010D0A7370717550726553616C6556616C7565546F74616C496E
      766F6963652E436F6E73747261696E744572726F724D65737361676501010101
      0D0A7370717550726553616C6556616C7565546F74616C496E766F6963652E43
      7573746F6D436F6E73747261696E74010101010D0A7370717550726553616C65
      56616C7565546F74616C496E766F6963652E44656661756C7445787072657373
      696F6E010101010D0A7370717550726553616C6556616C7565546F74616C496E
      766F6963652E45646974466F726D6174010101010D0A7370717550726553616C
      6556616C7565546F74616C496E766F6963652E496D706F72746564436F6E7374
      7261696E74010101010D0A7370717550726553616C6556616C7565546F74616C
      496E766F6963652E4B65794669656C6473010101010D0A737071755072655361
      6C6556616C7565546F74616C496E766F6963652E4C6F6F6B75704B6579466965
      6C6473010101010D0A7370717550726553616C6556616C7565546F74616C496E
      766F6963652E4C6F6F6B7570526573756C744669656C64010101010D0A737071
      7550726553616C6556616C7565546F74616C496E766F6963652E4F726967696E
      010101010D0A7370717550726553616C6556616C75655370656369616C507269
      636549442E436F6E73747261696E744572726F724D657373616765010101010D
      0A7370717550726553616C6556616C75655370656369616C507269636549442E
      437573746F6D436F6E73747261696E74010101010D0A7370717550726553616C
      6556616C75655370656369616C507269636549442E44656661756C7445787072
      657373696F6E010101010D0A7370717550726553616C6556616C756553706563
      69616C507269636549442E45646974466F726D6174010101010D0A7370717550
      726553616C6556616C75655370656369616C507269636549442E496D706F7274
      6564436F6E73747261696E74010101010D0A7370717550726553616C6556616C
      75655370656369616C507269636549442E4B65794669656C6473010101010D0A
      7370717550726553616C6556616C75655370656369616C507269636549442E4C
      6F6F6B75704B65794669656C6473010101010D0A7370717550726553616C6556
      616C75655370656369616C507269636549442E4C6F6F6B7570526573756C7446
      69656C64010101010D0A7370717550726553616C6556616C7565537065636961
      6C507269636549442E4F726967696E010101010D0A7370717550726553616C65
      56616C75655370656369616C50726963652E436F6E73747261696E744572726F
      724D657373616765010101010D0A7370717550726553616C6556616C75655370
      656369616C50726963652E437573746F6D436F6E73747261696E74010101010D
      0A7370717550726553616C6556616C75655370656369616C50726963652E4465
      6661756C7445787072657373696F6E010101010D0A7370717550726553616C65
      56616C75655370656369616C50726963652E496D706F72746564436F6E737472
      61696E74010101010D0A7370717550726553616C6556616C7565537065636961
      6C50726963652E4B65794669656C6473010101010D0A7370717550726553616C
      6556616C75655370656369616C50726963652E4C6F6F6B75704B65794669656C
      6473010101010D0A7370717550726553616C6556616C75655370656369616C50
      726963652E4C6F6F6B7570526573756C744669656C64010101010D0A73707175
      50726553616C6556616C75655370656369616C50726963652E4F726967696E01
      0101010D0A7370717550726553616C6556616C75656E4F70656E557365722E43
      6F6E73747261696E744572726F724D657373616765010101010D0A7370717550
      726553616C6556616C75656E4F70656E557365722E437573746F6D436F6E7374
      7261696E74010101010D0A7370717550726553616C6556616C75656E4F70656E
      557365722E44656661756C7445787072657373696F6E010101010D0A73707175
      50726553616C6556616C75656E4F70656E557365722E45646974466F726D6174
      010101010D0A7370717550726553616C6556616C75656E4F70656E557365722E
      496D706F72746564436F6E73747261696E74010101010D0A7370717550726553
      616C6556616C75656E4F70656E557365722E4B65794669656C6473010101010D
      0A7370717550726553616C6556616C75656E4F70656E557365722E4C6F6F6B75
      704B65794669656C6473010101010D0A7370717550726553616C6556616C7565
      6E4F70656E557365722E4C6F6F6B7570526573756C744669656C64010101010D
      0A7370717550726553616C6556616C75656E4F70656E557365722E4F72696769
      6E010101010D0A7370717550726553616C6556616C756553686F774F70656E55
      7365722E436F6E73747261696E744572726F724D657373616765010101010D0A
      7370717550726553616C6556616C756553686F774F70656E557365722E437573
      746F6D436F6E73747261696E74010101010D0A7370717550726553616C655661
      6C756553686F774F70656E557365722E44656661756C7445787072657373696F
      6E010101010D0A7370717550726553616C6556616C756553686F774F70656E55
      7365722E45646974466F726D6174010101010D0A7370717550726553616C6556
      616C756553686F774F70656E557365722E496D706F72746564436F6E73747261
      696E74010101010D0A7370717550726553616C6556616C756553686F774F7065
      6E557365722E4B65794669656C6473010101010D0A7370717550726553616C65
      56616C756553686F774F70656E557365722E4C6F6F6B75704B65794669656C64
      73010101010D0A7370717550726553616C6556616C756553686F774F70656E55
      7365722E4C6F6F6B7570526573756C744669656C64010101010D0A7370717550
      726553616C6556616C756553686F774F70656E557365722E4F726967696E0101
      01010D0A7370717550726553616C6556616C75654E6577537562546F74616C2E
      436F6E73747261696E744572726F724D657373616765010101010D0A73707175
      50726553616C6556616C75654E6577537562546F74616C2E437573746F6D436F
      6E73747261696E74010101010D0A7370717550726553616C6556616C75654E65
      77537562546F74616C2E44656661756C7445787072657373696F6E010101010D
      0A7370717550726553616C6556616C75654E6577537562546F74616C2E456469
      74466F726D6174010101010D0A7370717550726553616C6556616C75654E6577
      537562546F74616C2E496D706F72746564436F6E73747261696E74010101010D
      0A7370717550726553616C6556616C75654E6577537562546F74616C2E4B6579
      4669656C6473010101010D0A7370717550726553616C6556616C75654E657753
      7562546F74616C2E4C6F6F6B75704B65794669656C6473010101010D0A737071
      7550726553616C6556616C75654E6577537562546F74616C2E4C6F6F6B757052
      6573756C744669656C64010101010D0A7370717550726553616C6556616C7565
      4E6577537562546F74616C2E4F726967696E010101010D0A7370717550726553
      616C6556616C75655461784973656D707456616C75652E436F6E73747261696E
      744572726F724D657373616765010101010D0A7370717550726553616C655661
      6C75655461784973656D707456616C75652E437573746F6D436F6E7374726169
      6E74010101010D0A7370717550726553616C6556616C75655461784973656D70
      7456616C75652E44656661756C7445787072657373696F6E010101010D0A7370
      717550726553616C6556616C75655461784973656D707456616C75652E456469
      74466F726D6174010101010D0A7370717550726553616C6556616C7565546178
      4973656D707456616C75652E496D706F72746564436F6E73747261696E740101
      01010D0A7370717550726553616C6556616C75655461784973656D707456616C
      75652E4B65794669656C6473010101010D0A7370717550726553616C6556616C
      75655461784973656D707456616C75652E4C6F6F6B75704B65794669656C6473
      010101010D0A7370717550726553616C6556616C75655461784973656D707456
      616C75652E4C6F6F6B7570526573756C744669656C64010101010D0A73707175
      50726553616C6556616C75655461784973656D707456616C75652E4F72696769
      6E010101010D0A7370717550726553616C6556616C7565537562546F74616C54
      617861626C652E436F6E73747261696E744572726F724D657373616765010101
      010D0A7370717550726553616C6556616C7565537562546F74616C5461786162
      6C652E437573746F6D436F6E73747261696E74010101010D0A73707175507265
      53616C6556616C7565537562546F74616C54617861626C652E44656661756C74
      45787072657373696F6E010101010D0A7370717550726553616C6556616C7565
      537562546F74616C54617861626C652E45646974466F726D6174010101010D0A
      7370717550726553616C6556616C7565537562546F74616C54617861626C652E
      496D706F72746564436F6E73747261696E74010101010D0A7370717550726553
      616C6556616C7565537562546F74616C54617861626C652E4B65794669656C64
      73010101010D0A7370717550726553616C6556616C7565537562546F74616C54
      617861626C652E4C6F6F6B75704B65794669656C6473010101010D0A73707175
      50726553616C6556616C7565537562546F74616C54617861626C652E4C6F6F6B
      7570526573756C744669656C64010101010D0A7370717550726553616C655661
      6C7565537562546F74616C54617861626C652E4F726967696E010101010D0A73
      70717550726553616C6556616C75655461784973656D70744974656D44697363
      6F756E742E436F6E73747261696E744572726F724D657373616765010101010D
      0A7370717550726553616C6556616C75655461784973656D70744974656D4469
      73636F756E742E437573746F6D436F6E73747261696E74010101010D0A737071
      7550726553616C6556616C75655461784973656D70744974656D446973636F75
      6E742E44656661756C7445787072657373696F6E010101010D0A737071755072
      6553616C6556616C75655461784973656D70744974656D446973636F756E742E
      45646974466F726D6174010101010D0A7370717550726553616C6556616C7565
      5461784973656D70744974656D446973636F756E742E496D706F72746564436F
      6E73747261696E74010101010D0A7370717550726553616C6556616C75655461
      784973656D70744974656D446973636F756E742E4B65794669656C6473010101
      010D0A7370717550726553616C6556616C75655461784973656D70744974656D
      446973636F756E742E4C6F6F6B75704B65794669656C6473010101010D0A7370
      717550726553616C6556616C75655461784973656D70744974656D446973636F
      756E742E4C6F6F6B7570526573756C744669656C64010101010D0A7370717550
      726553616C6556616C75655461784973656D70744974656D446973636F756E74
      2E4F726967696E010101010D0A7175426172636F64652E436F6E6E656374696F
      6E537472696E67010101010D0A7175426172636F64652E46696C746572010101
      010D0A71754D65696F5061672E436F6E6E656374696F6E537472696E67010101
      010D0A71754D65696F5061672E46696C746572010101010D0A7175437573746F
      6D65722E436F6D6D616E64546578740153454C454354191A09502E4944506573
      736F612C191A202020202020202009502E506573736F612C191A09502E506573
      736F6146697273744E616D652C191A09502E506573736F614C6173744E616D65
      2C191A202020202020202009502E456E64657265636F2C191A09502E43696461
      64652C191A09502E4345502C191A09502E54656C65666F6E652C191A09502E43
      50462C191A09502E496E7363457374616475616C2C191A09502E42616972726F
      191A46524F4D2009191A09506573736F61205020284E4F4C4F434B29191A094A
      4F494E205469706F506573736F61205450204F4E202854502E49445469706F50
      6573736F61203D20502E49445469706F506573736F6129191A57484552452009
      191A0954502E50617468206C696B6520272E3030312527191A4F524445522042
      5920191A09502E506573736F610101010D0A7175437573746F6D65722E436F6E
      6E656374696F6E537472696E67010101010D0A7175437573746F6D65722E4669
      6C746572010101010D0A7175437573746F6D65722E496E6465784669656C644E
      616D6573010101010D0A636473437573746F6D65722E436F6D6D616E64546578
      74010101010D0A636473437573746F6D65722E46696C746572010101010D0A63
      6473437573746F6D65722E496E6465784669656C644E616D6573010101010D0A
      636473437573746F6D65722E50726F76696465724E616D650164737043757374
      6F6D65720101010D0A636473437573746F6D65724944506573736F612E436F6E
      73747261696E744572726F724D657373616765010101010D0A63647343757374
      6F6D65724944506573736F612E437573746F6D436F6E73747261696E74010101
      010D0A636473437573746F6D65724944506573736F612E44656661756C744578
      7072657373696F6E010101010D0A636473437573746F6D65724944506573736F
      612E45646974466F726D6174010101010D0A636473437573746F6D6572494450
      6573736F612E496D706F72746564436F6E73747261696E74010101010D0A6364
      73437573746F6D65724944506573736F612E4B65794669656C6473010101010D
      0A636473437573746F6D65724944506573736F612E4C6F6F6B75704B65794669
      656C6473010101010D0A636473437573746F6D65724944506573736F612E4C6F
      6F6B7570526573756C744669656C64010101010D0A636473437573746F6D6572
      4944506573736F612E4F726967696E010101010D0A636473437573746F6D6572
      506573736F612E436F6E73747261696E744572726F724D657373616765010101
      010D0A636473437573746F6D6572506573736F612E437573746F6D436F6E7374
      7261696E74010101010D0A636473437573746F6D6572506573736F612E446566
      61756C7445787072657373696F6E010101010D0A636473437573746F6D657250
      6573736F612E496D706F72746564436F6E73747261696E74010101010D0A6364
      73437573746F6D6572506573736F612E4B65794669656C6473010101010D0A63
      6473437573746F6D6572506573736F612E4C6F6F6B75704B65794669656C6473
      010101010D0A636473437573746F6D6572506573736F612E4C6F6F6B75705265
      73756C744669656C64010101010D0A636473437573746F6D6572506573736F61
      2E4F726967696E010101010D0A636473437573746F6D6572506573736F614669
      7273744E616D652E436F6E73747261696E744572726F724D6573736167650101
      01010D0A636473437573746F6D6572506573736F6146697273744E616D652E43
      7573746F6D436F6E73747261696E74010101010D0A636473437573746F6D6572
      506573736F6146697273744E616D652E44656661756C7445787072657373696F
      6E010101010D0A636473437573746F6D6572506573736F6146697273744E616D
      652E496D706F72746564436F6E73747261696E74010101010D0A636473437573
      746F6D6572506573736F6146697273744E616D652E4B65794669656C64730101
      01010D0A636473437573746F6D6572506573736F6146697273744E616D652E4C
      6F6F6B75704B65794669656C6473010101010D0A636473437573746F6D657250
      6573736F6146697273744E616D652E4C6F6F6B7570526573756C744669656C64
      010101010D0A636473437573746F6D6572506573736F6146697273744E616D65
      2E4F726967696E010101010D0A636473437573746F6D6572506573736F614C61
      73744E616D652E436F6E73747261696E744572726F724D657373616765010101
      010D0A636473437573746F6D6572506573736F614C6173744E616D652E437573
      746F6D436F6E73747261696E74010101010D0A636473437573746F6D65725065
      73736F614C6173744E616D652E44656661756C7445787072657373696F6E0101
      01010D0A636473437573746F6D6572506573736F614C6173744E616D652E496D
      706F72746564436F6E73747261696E74010101010D0A636473437573746F6D65
      72506573736F614C6173744E616D652E4B65794669656C6473010101010D0A63
      6473437573746F6D6572506573736F614C6173744E616D652E4C6F6F6B75704B
      65794669656C6473010101010D0A636473437573746F6D6572506573736F614C
      6173744E616D652E4C6F6F6B7570526573756C744669656C64010101010D0A63
      6473437573746F6D6572506573736F614C6173744E616D652E4F726967696E01
      0101010D0A636473437573746F6D6572456E64657265636F2E436F6E73747261
      696E744572726F724D657373616765010101010D0A636473437573746F6D6572
      456E64657265636F2E437573746F6D436F6E73747261696E74010101010D0A63
      6473437573746F6D6572456E64657265636F2E44656661756C74457870726573
      73696F6E010101010D0A636473437573746F6D6572456E64657265636F2E496D
      706F72746564436F6E73747261696E74010101010D0A636473437573746F6D65
      72456E64657265636F2E4B65794669656C6473010101010D0A63647343757374
      6F6D6572456E64657265636F2E4C6F6F6B75704B65794669656C647301010101
      0D0A636473437573746F6D6572456E64657265636F2E4C6F6F6B757052657375
      6C744669656C64010101010D0A636473437573746F6D6572456E64657265636F
      2E4F726967696E010101010D0A636473437573746F6D65724369646164652E43
      6F6E73747261696E744572726F724D657373616765010101010D0A6364734375
      73746F6D65724369646164652E437573746F6D436F6E73747261696E74010101
      010D0A636473437573746F6D65724369646164652E44656661756C7445787072
      657373696F6E010101010D0A636473437573746F6D65724369646164652E496D
      706F72746564436F6E73747261696E74010101010D0A636473437573746F6D65
      724369646164652E4B65794669656C6473010101010D0A636473437573746F6D
      65724369646164652E4C6F6F6B75704B65794669656C6473010101010D0A6364
      73437573746F6D65724369646164652E4C6F6F6B7570526573756C744669656C
      64010101010D0A636473437573746F6D65724369646164652E4F726967696E01
      0101010D0A636473437573746F6D65724345502E436F6E73747261696E744572
      726F724D657373616765010101010D0A636473437573746F6D65724345502E43
      7573746F6D436F6E73747261696E74010101010D0A636473437573746F6D6572
      4345502E44656661756C7445787072657373696F6E010101010D0A6364734375
      73746F6D65724345502E496D706F72746564436F6E73747261696E7401010101
      0D0A636473437573746F6D65724345502E4B65794669656C6473010101010D0A
      636473437573746F6D65724345502E4C6F6F6B75704B65794669656C64730101
      01010D0A636473437573746F6D65724345502E4C6F6F6B7570526573756C7446
      69656C64010101010D0A636473437573746F6D65724345502E4F726967696E01
      0101010D0A636473437573746F6D657254656C65666F6E652E436F6E73747261
      696E744572726F724D657373616765010101010D0A636473437573746F6D6572
      54656C65666F6E652E437573746F6D436F6E73747261696E74010101010D0A63
      6473437573746F6D657254656C65666F6E652E44656661756C74457870726573
      73696F6E010101010D0A636473437573746F6D657254656C65666F6E652E496D
      706F72746564436F6E73747261696E74010101010D0A636473437573746F6D65
      7254656C65666F6E652E4B65794669656C6473010101010D0A63647343757374
      6F6D657254656C65666F6E652E4C6F6F6B75704B65794669656C647301010101
      0D0A636473437573746F6D657254656C65666F6E652E4C6F6F6B757052657375
      6C744669656C64010101010D0A636473437573746F6D657254656C65666F6E65
      2E4F726967696E010101010D0A636473437573746F6D65724350462E436F6E73
      747261696E744572726F724D657373616765010101010D0A636473437573746F
      6D65724350462E437573746F6D436F6E73747261696E74010101010D0A636473
      437573746F6D65724350462E44656661756C7445787072657373696F6E010101
      010D0A636473437573746F6D65724350462E496D706F72746564436F6E737472
      61696E74010101010D0A636473437573746F6D65724350462E4B65794669656C
      6473010101010D0A636473437573746F6D65724350462E4C6F6F6B75704B6579
      4669656C6473010101010D0A636473437573746F6D65724350462E4C6F6F6B75
      70526573756C744669656C64010101010D0A636473437573746F6D6572435046
      2E4F726967696E010101010D0A71754F74686572436F6D6D697373696F6E2E43
      6F6D6D616E64546578740153454C454354191A09502E4944506573736F612C19
      1A09502E4944506573736F61204944436F6D697373696F6E61646F2C191A0950
      2E506573736F61191A46524F4D2009191A09506573736F612050191A57484552
      452009191A09502E49445469706F506573736F61526F6F74203D2039191A4F52
      44455220425920191A09502E506573736F610101010D0A71754F74686572436F
      6D6D697373696F6E2E436F6E6E656374696F6E537472696E67010101010D0A71
      754F74686572436F6D6D697373696F6E2E46696C746572010101010D0A71754F
      74686572436F6D6D697373696F6E2E496E6465784669656C644E616D65730101
      01010D0A6364734F74686572436F6D6D697373696F6E2E436F6D6D616E645465
      7874010101010D0A6364734F74686572436F6D6D697373696F6E2E46696C7465
      72010101010D0A6364734F74686572436F6D6D697373696F6E2E496E64657846
      69656C644E616D6573010101010D0A6364734F74686572436F6D6D697373696F
      6E2E50726F76696465724E616D65016473704F74686572436F6D6D697373696F
      6E0101010D0A6364734F74686572436F6D6D697373696F6E4944506573736F61
      2E436F6E73747261696E744572726F724D657373616765010101010D0A636473
      4F74686572436F6D6D697373696F6E4944506573736F612E437573746F6D436F
      6E73747261696E74010101010D0A6364734F74686572436F6D6D697373696F6E
      4944506573736F612E44656661756C7445787072657373696F6E010101010D0A
      6364734F74686572436F6D6D697373696F6E4944506573736F612E4564697446
      6F726D6174010101010D0A6364734F74686572436F6D6D697373696F6E494450
      6573736F612E496D706F72746564436F6E73747261696E74010101010D0A6364
      734F74686572436F6D6D697373696F6E4944506573736F612E4B65794669656C
      6473010101010D0A6364734F74686572436F6D6D697373696F6E494450657373
      6F612E4C6F6F6B75704B65794669656C6473010101010D0A6364734F74686572
      436F6D6D697373696F6E4944506573736F612E4C6F6F6B7570526573756C7446
      69656C64010101010D0A6364734F74686572436F6D6D697373696F6E49445065
      73736F612E4F726967696E010101010D0A6364734F74686572436F6D6D697373
      696F6E4944436F6D697373696F6E61646F2E436F6E73747261696E744572726F
      724D657373616765010101010D0A6364734F74686572436F6D6D697373696F6E
      4944436F6D697373696F6E61646F2E437573746F6D436F6E73747261696E7401
      0101010D0A6364734F74686572436F6D6D697373696F6E4944436F6D69737369
      6F6E61646F2E44656661756C7445787072657373696F6E010101010D0A636473
      4F74686572436F6D6D697373696F6E4944436F6D697373696F6E61646F2E4564
      6974466F726D6174010101010D0A6364734F74686572436F6D6D697373696F6E
      4944436F6D697373696F6E61646F2E496D706F72746564436F6E73747261696E
      74010101010D0A6364734F74686572436F6D6D697373696F6E4944436F6D6973
      73696F6E61646F2E4B65794669656C6473010101010D0A6364734F7468657243
      6F6D6D697373696F6E4944436F6D697373696F6E61646F2E4C6F6F6B75704B65
      794669656C6473010101010D0A6364734F74686572436F6D6D697373696F6E49
      44436F6D697373696F6E61646F2E4C6F6F6B7570526573756C744669656C6401
      0101010D0A6364734F74686572436F6D6D697373696F6E4944436F6D69737369
      6F6E61646F2E4F726967696E010101010D0A6364734F74686572436F6D6D6973
      73696F6E506573736F612E436F6E73747261696E744572726F724D6573736167
      65010101010D0A6364734F74686572436F6D6D697373696F6E506573736F612E
      437573746F6D436F6E73747261696E74010101010D0A6364734F74686572436F
      6D6D697373696F6E506573736F612E44656661756C7445787072657373696F6E
      010101010D0A6364734F74686572436F6D6D697373696F6E506573736F612E49
      6D706F72746564436F6E73747261696E74010101010D0A6364734F7468657243
      6F6D6D697373696F6E506573736F612E4B65794669656C6473010101010D0A63
      64734F74686572436F6D6D697373696F6E506573736F612E4C6F6F6B75704B65
      794669656C6473010101010D0A6364734F74686572436F6D6D697373696F6E50
      6573736F612E4C6F6F6B7570526573756C744669656C64010101010D0A636473
      4F74686572436F6D6D697373696F6E506573736F612E4F726967696E01010101
      0D0A717553797374656D557365722E436F6D6D616E64546578740153454C4543
      54191A0953552E4944557365722C20191A0953552E53797374656D557365722C
      191A0953552E436F6D697373696F6E49442C191A09502E49445469706F506573
      736F61191A46524F4D191A0953797374656D55736572205355191A094A4F494E
      20506573736F612050204F4E2028502E4944506573736F61203D2053552E436F
      6D697373696F6E494429191A5748455245191A0953552E446573617469766164
      6F203D2030191A09414E44191A0953552E48696464656E203D2030191A09414E
      44191A0953552E53797374656D203D2030191A09414E44191A0953552E436F6D
      697373696F6E4944204953204E4F54204E554C4C0101010D0A71755379737465
      6D557365722E436F6E6E656374696F6E537472696E67010101010D0A71755379
      7374656D557365722E46696C746572010101010D0A717553797374656D557365
      722E496E6465784669656C644E616D6573010101010D0A63647353797374656D
      557365722E436F6D6D616E6454657874010101010D0A63647353797374656D55
      7365722E46696C746572010101010D0A63647353797374656D557365722E496E
      6465784669656C644E616D6573010101010D0A63647353797374656D55736572
      2E50726F76696465724E616D650164737053797374656D557365720101010D0A
      63647353797374656D557365724944557365722E436F6E73747261696E744572
      726F724D657373616765010101010D0A63647353797374656D55736572494455
      7365722E437573746F6D436F6E73747261696E74010101010D0A636473537973
      74656D557365724944557365722E44656661756C7445787072657373696F6E01
      0101010D0A63647353797374656D557365724944557365722E45646974466F72
      6D6174010101010D0A63647353797374656D557365724944557365722E496D70
      6F72746564436F6E73747261696E74010101010D0A63647353797374656D5573
      65724944557365722E4B65794669656C6473010101010D0A6364735379737465
      6D557365724944557365722E4C6F6F6B75704B65794669656C6473010101010D
      0A63647353797374656D557365724944557365722E4C6F6F6B7570526573756C
      744669656C64010101010D0A63647353797374656D557365724944557365722E
      4F726967696E010101010D0A63647353797374656D5573657253797374656D55
      7365722E436F6E73747261696E744572726F724D657373616765010101010D0A
      63647353797374656D5573657253797374656D557365722E437573746F6D436F
      6E73747261696E74010101010D0A63647353797374656D557365725379737465
      6D557365722E44656661756C7445787072657373696F6E010101010D0A636473
      53797374656D5573657253797374656D557365722E496D706F72746564436F6E
      73747261696E74010101010D0A63647353797374656D5573657253797374656D
      557365722E4B65794669656C6473010101010D0A63647353797374656D557365
      7253797374656D557365722E4C6F6F6B75704B65794669656C6473010101010D
      0A63647353797374656D5573657253797374656D557365722E4C6F6F6B757052
      6573756C744669656C64010101010D0A63647353797374656D55736572537973
      74656D557365722E4F726967696E010101010D0A63647353797374656D557365
      72436F6D697373696F6E49442E436F6E73747261696E744572726F724D657373
      616765010101010D0A63647353797374656D55736572436F6D697373696F6E49
      442E437573746F6D436F6E73747261696E74010101010D0A6364735379737465
      6D55736572436F6D697373696F6E49442E44656661756C744578707265737369
      6F6E010101010D0A63647353797374656D55736572436F6D697373696F6E4944
      2E45646974466F726D6174010101010D0A63647353797374656D55736572436F
      6D697373696F6E49442E496D706F72746564436F6E73747261696E7401010101
      0D0A63647353797374656D55736572436F6D697373696F6E49442E4B65794669
      656C6473010101010D0A63647353797374656D55736572436F6D697373696F6E
      49442E4C6F6F6B75704B65794669656C6473010101010D0A6364735379737465
      6D55736572436F6D697373696F6E49442E4C6F6F6B7570526573756C74466965
      6C64010101010D0A63647353797374656D55736572436F6D697373696F6E4944
      2E4F726967696E010101010D0A71754D6F64656C2E436F6D6D616E6454657874
      0153454C454354191A094D2E49444D6F64656C2C191A0943415345205748454E
      20532E4672616E6368697365203D2031205448454E20492E53746F7265436F73
      74507269636520454C5345202849734E756C6C284D2E56656E646F72436F7374
      2C3029202B2049734E756C6C284D2E46726569676874436F73742C30292B2049
      734E756C6C284D2E4F74686572436F73742C30292920454E442061732056656E
      646F72436F73742C191A0943415345205748454E20532E4672616E6368697365
      203D2031205448454E20492E53656C6C696E67507269636520454C5345204D2E
      53656C6C696E67507269636520454E4420617320496E7653656C6C696E675072
      6963652C191A094D2E4465736372697074696F6E2C191A094D2E4D6F64656C2C
      191A094D2E5265706C6163656D656E74436F73742C191A094D2E5065736F2C19
      1A094D2E5375676752657461696C2C191A094D2E417667436F73742C191A094D
      2E4C61726765496D6167652C191A094D2E4C61726765496D616765322C191A09
      4D2E50726F6D6F74696F6E50726963652C191A094D2E446973636F756E745065
      72632C191A094D2E437573746F6D53616C6550726963652C191A09492E53656C
      6C696E6750726963652061732053746F726553656C6C696E6750726963652C19
      1A0954472E4E616D652061732054616247726F75702C191A09552E556E696461
      64652C191A09552E5369676C612C191A09462E506573736F6120617320466162
      726963616E74652C191A094956532E53697A654E616D652C191A094956532E43
      6F6453697A652C191A094956432E436F6C6F722C191A094956432E436F64436F
      6C6F722C191A0953472E53756247726F75702C191A0954472E50757070795472
      61636B65722C191A0954472E52657175657374437573746F6D65722C191A094D
      2E436173655174792C191A095354472E494453616C6554617820415320494454
      617843617465676F72792C191A0954472E50726350617274446973636F756E74
      191A46524F4D191A094D6F64656C204D191A094A4F494E2054616247726F7570
      205447204F4E202854472E494447726F7570203D204D2E47726F757049442919
      1A094A4F494E2053746F7265546F54616247726F757020535447204F4E202854
      472E494447726F7570203D205354472E494447726F757029191A094A4F494E20
      54617843617465676F7279205443204F4E20285354472E494453616C65546178
      203D2054432E494454617843617465676F727929191A094A4F494E2053746F72
      652053204F4E20285354472E494453746F7265203D20532E494453746F726529
      191A094C454654204F55544552204A4F494E20556E69646164652055204F4E20
      28552E4944556E6964616465203D204D2E4944556E696461646529191A094C45
      4654204F55544552204A4F494E20506573736F612046204F4E2028462E494450
      6573736F61203D204D2E4944466162726963616E746529191A094C454654204F
      55544552204A4F494E20496E7653697A6520495653204F4E20284956532E4944
      53697A65203D204D2E494453697A6529191A094C454654204F55544552204A4F
      494E20496E76436F6C6F7220495643204F4E20284956432E4944436F6C6F7220
      3D204D2E4944436F6C6F7229191A094C454654204F55544552204A4F494E2053
      756247726F7570205347204F4E202853472E494453756247726F7570203D204D
      2E494453756247726F757029191A094C454654204F55544552204A4F494E2049
      6E76656E746F72792049204F4E2028492E4D6F64656C4944203D204D2E49444D
      6F64656C20414E4420492E53746F72654944203D20532E494453746F72652919
      1A5748455245191A094D2E4465736174697661646F203D2030191A09414E4419
      1A094D2E48696464656E203D2030191A09414E44191A094D2E4D6F64656C5479
      706520494E20282753272C202752272C202756272C202743272C274B27202919
      1A09414E44191A09532E494453746F7265203D203A494453746F7265191A4F52
      444552204259191A094D2E4D6F64656C191A0101010D0A71754D6F64656C2E43
      6F6E6E656374696F6E537472696E67010101010D0A71754D6F64656C2E46696C
      746572010101010D0A71754D6F64656C2E496E6465784669656C644E616D6573
      010101010D0A6364734D6F64656C2E436F6D6D616E6454657874010101010D0A
      6364734D6F64656C2E46696C746572010101010D0A6364734D6F64656C2E496E
      6465784669656C644E616D6573010101010D0A6364734D6F64656C2E50726F76
      696465724E616D65016473704D6F64656C0101010D0A41444F44617461536574
      312E436F6D6D616E64546578740153454C454354191A09502E4944506573736F
      612C191A09502E4944506573736F61204944436F6D697373696F6E61646F2C19
      1A09502E506573736F61191A46524F4D2009191A09506573736F612050191A57
      484552452009191A09502E49445469706F506573736F61526F6F74203D203919
      1A4F5244455220425920191A09502E506573736F610101010D0A41444F446174
      61536574312E436F6E6E656374696F6E537472696E67010101010D0A41444F44
      617461536574312E46696C746572010101010D0A41444F44617461536574312E
      496E6465784669656C644E616D6573010101010D0A436C69656E744461746153
      6574312E436F6D6D616E6454657874010101010D0A436C69656E744461746153
      6574312E46696C746572010101010D0A436C69656E7444617461536574312E49
      6E6465784669656C644E616D6573010101010D0A436C69656E74446174615365
      74312E50726F76696465724E616D65010101010D0A7175426172636F64655365
      617263682E436F6D6D616E64546578740153454C454354191A09422E49444261
      72636F64652C191A09422E49444D6F64656C2C191A094D2E4D6F64656C191A46
      524F4D191A09426172636F64652042191A094A4F494E204D6F64656C204D204F
      4E20284D2E49444D6F64656C203D20422E49444D6F64656C29191A5748455245
      191A094D2E4465736174697661646F203D2030191A09414E44191A094D2E4869
      6464656E203D2030191A09414E44191A094D2E4D6F64656C5479706520494E20
      282753272C202752272C202756272C202743272C274B272029191A4F52444552
      204259191A09422E4944426172636F64650101010D0A7175426172636F646553
      65617263682E436F6E6E656374696F6E537472696E67010101010D0A71754261
      72636F64655365617263682E46696C746572010101010D0A7175426172636F64
      655365617263682E496E6465784669656C644E616D6573010101010D0A636473
      426172636F64655365617263682E436F6D6D616E6454657874010101010D0A63
      6473426172636F64655365617263682E46696C746572010101010D0A63647342
      6172636F64655365617263682E496E6465784669656C644E616D657301010101
      0D0A636473426172636F64655365617263682E50726F76696465724E616D6501
      647370426172636F64655365617263680101010D0A71754D4465736372697074
      696F6E2E436F6D6D616E64546578740153454C454354191A094D2E49444D6F64
      656C2C191A092849734E756C6C284D2E56656E646F72436F73742C3029202B20
      191A0949734E756C6C284D2E46726569676874436F73742C30292B191A094973
      4E756C6C284D2E4F74686572436F73742C3029292061732056656E646F72436F
      73742C191A094D2E53656C6C696E67507269636520617320496E7653656C6C69
      6E6750726963652C191A094D2E4465736372697074696F6E2C191A094D2E4D6F
      64656C2C191A094D2E5265706C6163656D656E74436F73742C191A094D2E5065
      736F2C191A094D2E5375676752657461696C2C191A094D2E417667436F73742C
      191A094D2E4C61726765496D6167652C191A094D2E4C61726765496D61676532
      2C191A094D2E50726F6D6F74696F6E50726963652C191A094D2E446973636F75
      6E74506572632C191A094D2E437573746F6D53616C6550726963652C191A0949
      2E53656C6C696E6750726963652061732053746F726553656C6C696E67507269
      63652C191A0954472E4E616D652061732054616247726F75702C191A09552E55
      6E69646164652C191A09552E5369676C612C191A09462E506573736F61206173
      20466162726963616E74652C191A094956532E53697A654E616D652C191A0949
      56532E436F6453697A652C191A094956432E436F6C6F722C191A094956432E43
      6F64436F6C6F722C191A0953472E53756247726F75702C191A0954472E507570
      7079547261636B65722C191A0954472E52657175657374437573746F6D65722C
      191A094D2E43617365517479191A46524F4D191A094D6F64656C204D191A094A
      4F494E2054616247726F7570205447204F4E202854472E494447726F7570203D
      204D2E47726F7570494429191A094C454654204F55544552204A4F494E20556E
      69646164652055204F4E2028552E4944556E6964616465203D204D2E4944556E
      696461646529191A094C454654204F55544552204A4F494E20506573736F6120
      46204F4E2028462E4944506573736F61203D204D2E4944466162726963616E74
      6529191A094C454654204F55544552204A4F494E20496E7653697A6520495653
      204F4E20284956532E494453697A65203D204D2E494453697A6529191A094C45
      4654204F55544552204A4F494E20496E76436F6C6F7220495643204F4E202849
      56432E4944436F6C6F72203D204D2E4944436F6C6F7229191A094C454654204F
      55544552204A4F494E2053756247726F7570205347204F4E202853472E494453
      756247726F7570203D204D2E494453756247726F757029191A094C454654204F
      55544552204A4F494E20496E76656E746F72792049204F4E2028492E4D6F6465
      6C4944203D204D2E49444D6F64656C20414E4420492E53746F72654944203D20
      3A494453746F726529191A5748455245191A094D2E4465736174697661646F20
      3D2030191A09414E44191A094D2E48696464656E203D2030191A09414E44191A
      094D2E4D6F64656C5479706520494E20282753272C202752272C202756272C20
      2743272C274B272029191A4F52444552204259191A094D2E4465736372697074
      696F6E0101010D0A71754D4465736372697074696F6E2E436F6E6E656374696F
      6E537472696E67010101010D0A71754D4465736372697074696F6E2E46696C74
      6572010101010D0A71754D4465736372697074696F6E2E496E6465784669656C
      644E616D6573010101010D0A6364734D4465736372697074696F6E2E436F6D6D
      616E6454657874010101010D0A6364734D4465736372697074696F6E2E46696C
      746572010101010D0A6364734D4465736372697074696F6E2E496E6465784669
      656C644E616D6573010101010D0A6364734D4465736372697074696F6E2E5072
      6F76696465724E616D65016473704D4465736372697074696F6E0101010D0A71
      754E6577437573746F6D65722E436F6E6E656374696F6E537472696E67010101
      010D0A71754E6577437573746F6D65722E46696C746572010101010D0A636D64
      506573736F612E436F6D6D616E645465787401494E5345525420506573736F61
      20284944506573736F612C2049445469706F506573736F612C20494453746F72
      652C2049445469706F506573736F61526F6F742C204944557365722C20506573
      736F612C20506573736F6146697273744E616D652C20506573736F614C617374
      4E616D652C20456E64657265636F2C204369646164652C204345502C2054656C
      65666F6E652C204A7572696469636F2C204350462C2042616972726F2C205068
      6F6E6541726561436F64652C2043656C6C41726561436F64652C2043656C6C75
      6C61722C20456D61696C2C20486F6D65506167652C204964656E746964616465
      2C204F7267616F456D6973736F722C204461746145787065646963616F2C204E
      617363696D656E746F2C20437573746F6D6572436172642C20436172744D6F74
      6F72697374612C204E6F6D654A7572696469636F2C20496E7363457374616475
      616C2C20496E73634D756E69636970616C2C20436F6E7461746F732C204F4253
      29191A56414C55455320283A4944506573736F612C203A49445469706F506573
      736F612C203A494453746F72652C203A49445469706F506573736F61526F6F74
      2C203A4944557365722C203A506573736F612C203A506573736F614669727374
      4E616D652C203A506573736F614C6173744E616D652C203A456E64657265636F
      2C203A4369646164652C203A4345502C203A54656C65666F6E652C203A4A7572
      696469636F2C203A4350462C203A42616972726F2C203A50686F6E6541726561
      436F64652C203A43656C6C41726561436F64652C203A43656C6C756C61722C20
      3A456D61696C2C203A486F6D65506167652C203A4964656E7469646164652C20
      3A4F7267616F456D6973736F722C203A4461746145787065646963616F2C203A
      4E617363696D656E746F2C203A437573746F6D6572436172642C203A43617274
      4D6F746F72697374612C203A4E6F6D654A7572696469636F2C203A496E736345
      7374616475616C2C203A496E73634D756E69636970616C2C203A436F6E746174
      6F732C203A4F425329191A191A0101010D0A636D64506573736F612E436F6E6E
      656374696F6E537472696E67010101010D0A71754D6F64656C4163636573736F
      72792E436F6D6D616E64546578740153454C454354191A0949412E4944496E76
      4163636573736F72792C191A0949412E49444D6F64656C2C191A094D2E4D6F64
      656C2C20191A094D2E4465736372697074696F6E2C191A0949412E4465736372
      697074696F6E2061732048696E742C191A094D2E4C61726765496D6167652C19
      1A094D2E50726F6D6F74696F6E50726963652C191A094D2E446973636F756E74
      506572632C191A0928434153452049734E756C6C28492E53656C6C696E675072
      6963652C3029205748454E2030205448454E204D2E53656C6C696E6750726963
      6520191A09454C534520492E53656C6C696E67507269636520454E4429204153
      2053656C6C696E675072696365191A46524F4D191A09496E764163636573736F
      7279204941191A094A4F494E204D6F64656C204D204F4E20284D2E49444D6F64
      656C3D49412E4944496E764163636573736F727929191A094C454654204F5554
      4552204A4F494E20496E76656E746F72792049204F4E2028492E4D6F64656C49
      44203D204D2E49444D6F64656C20414E4420492E53746F72654944203D203A49
      4453746F726529191A5748455245191A0949412E49444D6F64656C203D203A49
      444D6F64656C191A09414E44191A094D2E546F745174794F6E48616E64203E20
      30191A09414E44191A094D2E4465736174697661646F203D2030191A0101010D
      0A71754D6F64656C4163636573736F72792E436F6E6E656374696F6E53747269
      6E67010101010D0A71754D6F64656C4163636573736F72792E46696C74657201
      0101010D0A71754D6F64656C4163636573736F72792E496E6465784669656C64
      4E616D6573010101010D0A7175426172636F646549444D6F64656C2E436F6E73
      747261696E744572726F724D657373616765010101010D0A7175426172636F64
      6549444D6F64656C2E437573746F6D436F6E73747261696E74010101010D0A71
      75426172636F646549444D6F64656C2E44656661756C7445787072657373696F
      6E010101010D0A7175426172636F646549444D6F64656C2E45646974466F726D
      6174010101010D0A7175426172636F646549444D6F64656C2E496D706F727465
      64436F6E73747261696E74010101010D0A7175426172636F646549444D6F6465
      6C2E4B65794669656C6473010101010D0A7175426172636F646549444D6F6465
      6C2E4C6F6F6B75704B65794669656C6473010101010D0A7175426172636F6465
      49444D6F64656C2E4C6F6F6B7570526573756C744669656C64010101010D0A71
      75426172636F646549444D6F64656C2E4F726967696E010101010D0A71754261
      72636F64654D6F64656C2E436F6E73747261696E744572726F724D6573736167
      65010101010D0A7175426172636F64654D6F64656C2E437573746F6D436F6E73
      747261696E74010101010D0A7175426172636F64654D6F64656C2E4465666175
      6C7445787072657373696F6E010101010D0A7175426172636F64654D6F64656C
      2E496D706F72746564436F6E73747261696E74010101010D0A7175426172636F
      64654D6F64656C2E4B65794669656C6473010101010D0A7175426172636F6465
      4D6F64656C2E4C6F6F6B75704B65794669656C6473010101010D0A7175426172
      636F64654D6F64656C2E4C6F6F6B7570526573756C744669656C64010101010D
      0A7175426172636F64654D6F64656C2E4F726967696E010101010D0A71754261
      72636F64654944426172636F64652E436F6E73747261696E744572726F724D65
      7373616765010101010D0A7175426172636F64654944426172636F64652E4375
      73746F6D436F6E73747261696E74010101010D0A7175426172636F6465494442
      6172636F64652E44656661756C7445787072657373696F6E010101010D0A7175
      426172636F64654944426172636F64652E496D706F72746564436F6E73747261
      696E74010101010D0A7175426172636F64654944426172636F64652E4B657946
      69656C6473010101010D0A7175426172636F64654944426172636F64652E4C6F
      6F6B75704B65794669656C6473010101010D0A7175426172636F646549444261
      72636F64652E4C6F6F6B7570526573756C744669656C64010101010D0A717542
      6172636F64654944426172636F64652E4F726967696E010101010D0A63647343
      7573746F6D6572496E7363457374616475616C2E436F6E73747261696E744572
      726F724D657373616765010101010D0A636473437573746F6D6572496E736345
      7374616475616C2E437573746F6D436F6E73747261696E74010101010D0A6364
      73437573746F6D6572496E7363457374616475616C2E44656661756C74457870
      72657373696F6E010101010D0A636473437573746F6D6572496E736345737461
      6475616C2E496D706F72746564436F6E73747261696E74010101010D0A636473
      437573746F6D6572496E7363457374616475616C2E4B65794669656C64730101
      01010D0A636473437573746F6D6572496E7363457374616475616C2E4C6F6F6B
      75704B65794669656C6473010101010D0A636473437573746F6D6572496E7363
      457374616475616C2E4C6F6F6B7570526573756C744669656C64010101010D0A
      636473437573746F6D6572496E7363457374616475616C2E4F726967696E0101
      01010D0A636473437573746F6D657242616972726F2E436F6E73747261696E74
      4572726F724D657373616765010101010D0A636473437573746F6D6572426169
      72726F2E437573746F6D436F6E73747261696E74010101010D0A636473437573
      746F6D657242616972726F2E44656661756C7445787072657373696F6E010101
      010D0A636473437573746F6D657242616972726F2E496D706F72746564436F6E
      73747261696E74010101010D0A636473437573746F6D657242616972726F2E4B
      65794669656C6473010101010D0A636473437573746F6D657242616972726F2E
      4C6F6F6B75704B65794669656C6473010101010D0A636473437573746F6D6572
      42616972726F2E4C6F6F6B7570526573756C744669656C64010101010D0A6364
      73437573746F6D657242616972726F2E4F726967696E010101010D0A6364734D
      6F64656C4163636573736F72792E436F6D6D616E6454657874010101010D0A63
      64734D6F64656C4163636573736F72792E46696C746572010101010D0A636473
      4D6F64656C4163636573736F72792E496E6465784669656C644E616D65730101
      01010D0A6364734D6F64656C4163636573736F72792E50726F76696465724E61
      6D65016473704D6F64656C4163636573736F72790101010D0A6364734D6F6465
      6C4163636573736F72794944496E764163636573736F72792E436F6E73747261
      696E744572726F724D657373616765010101010D0A6364734D6F64656C416363
      6573736F72794944496E764163636573736F72792E437573746F6D436F6E7374
      7261696E74010101010D0A6364734D6F64656C4163636573736F72794944496E
      764163636573736F72792E44656661756C7445787072657373696F6E01010101
      0D0A6364734D6F64656C4163636573736F72794944496E764163636573736F72
      792E45646974466F726D6174010101010D0A6364734D6F64656C416363657373
      6F72794944496E764163636573736F72792E496D706F72746564436F6E737472
      61696E74010101010D0A6364734D6F64656C4163636573736F72794944496E76
      4163636573736F72792E4B65794669656C6473010101010D0A6364734D6F6465
      6C4163636573736F72794944496E764163636573736F72792E4C6F6F6B75704B
      65794669656C6473010101010D0A6364734D6F64656C4163636573736F727949
      44496E764163636573736F72792E4C6F6F6B7570526573756C744669656C6401
      0101010D0A6364734D6F64656C4163636573736F72794944496E764163636573
      736F72792E4F726967696E010101010D0A6364734D6F64656C4163636573736F
      727949444D6F64656C2E436F6E73747261696E744572726F724D657373616765
      010101010D0A6364734D6F64656C4163636573736F727949444D6F64656C2E43
      7573746F6D436F6E73747261696E74010101010D0A6364734D6F64656C416363
      6573736F727949444D6F64656C2E44656661756C7445787072657373696F6E01
      0101010D0A6364734D6F64656C4163636573736F727949444D6F64656C2E4564
      6974466F726D6174010101010D0A6364734D6F64656C4163636573736F727949
      444D6F64656C2E496D706F72746564436F6E73747261696E74010101010D0A63
      64734D6F64656C4163636573736F727949444D6F64656C2E4B65794669656C64
      73010101010D0A6364734D6F64656C4163636573736F727949444D6F64656C2E
      4C6F6F6B75704B65794669656C6473010101010D0A6364734D6F64656C416363
      6573736F727949444D6F64656C2E4C6F6F6B7570526573756C744669656C6401
      0101010D0A6364734D6F64656C4163636573736F727949444D6F64656C2E4F72
      6967696E010101010D0A6364734D6F64656C4163636573736F72794D6F64656C
      2E436F6E73747261696E744572726F724D657373616765010101010D0A636473
      4D6F64656C4163636573736F72794D6F64656C2E437573746F6D436F6E737472
      61696E74010101010D0A6364734D6F64656C4163636573736F72794D6F64656C
      2E44656661756C7445787072657373696F6E010101010D0A6364734D6F64656C
      4163636573736F72794D6F64656C2E496D706F72746564436F6E73747261696E
      74010101010D0A6364734D6F64656C4163636573736F72794D6F64656C2E4B65
      794669656C6473010101010D0A6364734D6F64656C4163636573736F72794D6F
      64656C2E4C6F6F6B75704B65794669656C6473010101010D0A6364734D6F6465
      6C4163636573736F72794D6F64656C2E4C6F6F6B7570526573756C744669656C
      64010101010D0A6364734D6F64656C4163636573736F72794D6F64656C2E4F72
      6967696E010101010D0A6364734D6F64656C4163636573736F72794465736372
      697074696F6E2E436F6E73747261696E744572726F724D657373616765010101
      010D0A6364734D6F64656C4163636573736F72794465736372697074696F6E2E
      437573746F6D436F6E73747261696E74010101010D0A6364734D6F64656C4163
      636573736F72794465736372697074696F6E2E44656661756C74457870726573
      73696F6E010101010D0A6364734D6F64656C4163636573736F72794465736372
      697074696F6E2E496D706F72746564436F6E73747261696E74010101010D0A63
      64734D6F64656C4163636573736F72794465736372697074696F6E2E4B657946
      69656C6473010101010D0A6364734D6F64656C4163636573736F727944657363
      72697074696F6E2E4C6F6F6B75704B65794669656C6473010101010D0A636473
      4D6F64656C4163636573736F72794465736372697074696F6E2E4C6F6F6B7570
      526573756C744669656C64010101010D0A6364734D6F64656C4163636573736F
      72794465736372697074696F6E2E4F726967696E010101010D0A6364734D6F64
      656C4163636573736F727948696E742E436F6E73747261696E744572726F724D
      657373616765010101010D0A6364734D6F64656C4163636573736F727948696E
      742E437573746F6D436F6E73747261696E74010101010D0A6364734D6F64656C
      4163636573736F727948696E742E44656661756C7445787072657373696F6E01
      0101010D0A6364734D6F64656C4163636573736F727948696E742E496D706F72
      746564436F6E73747261696E74010101010D0A6364734D6F64656C4163636573
      736F727948696E742E4B65794669656C6473010101010D0A6364734D6F64656C
      4163636573736F727948696E742E4C6F6F6B75704B65794669656C6473010101
      010D0A6364734D6F64656C4163636573736F727948696E742E4C6F6F6B757052
      6573756C744669656C64010101010D0A6364734D6F64656C4163636573736F72
      7948696E742E4F726967696E010101010D0A6364734D6F64656C416363657373
      6F72794C61726765496D6167652E436F6E73747261696E744572726F724D6573
      73616765010101010D0A6364734D6F64656C4163636573736F72794C61726765
      496D6167652E437573746F6D436F6E73747261696E74010101010D0A6364734D
      6F64656C4163636573736F72794C61726765496D6167652E44656661756C7445
      787072657373696F6E010101010D0A6364734D6F64656C4163636573736F7279
      4C61726765496D6167652E496D706F72746564436F6E73747261696E74010101
      010D0A6364734D6F64656C4163636573736F72794C61726765496D6167652E4B
      65794669656C6473010101010D0A6364734D6F64656C4163636573736F72794C
      61726765496D6167652E4C6F6F6B75704B65794669656C6473010101010D0A63
      64734D6F64656C4163636573736F72794C61726765496D6167652E4C6F6F6B75
      70526573756C744669656C64010101010D0A6364734D6F64656C416363657373
      6F72794C61726765496D6167652E4F726967696E010101010D0A6364734D6F64
      656C4163636573736F727950726F6D6F74696F6E50726963652E436F6E737472
      61696E744572726F724D657373616765010101010D0A6364734D6F64656C4163
      636573736F727950726F6D6F74696F6E50726963652E437573746F6D436F6E73
      747261696E74010101010D0A6364734D6F64656C4163636573736F727950726F
      6D6F74696F6E50726963652E44656661756C7445787072657373696F6E010101
      010D0A6364734D6F64656C4163636573736F727950726F6D6F74696F6E507269
      63652E45646974466F726D6174010101010D0A6364734D6F64656C4163636573
      736F727950726F6D6F74696F6E50726963652E496D706F72746564436F6E7374
      7261696E74010101010D0A6364734D6F64656C4163636573736F727950726F6D
      6F74696F6E50726963652E4B65794669656C6473010101010D0A6364734D6F64
      656C4163636573736F727950726F6D6F74696F6E50726963652E4C6F6F6B7570
      4B65794669656C6473010101010D0A6364734D6F64656C4163636573736F7279
      50726F6D6F74696F6E50726963652E4C6F6F6B7570526573756C744669656C64
      010101010D0A6364734D6F64656C4163636573736F727950726F6D6F74696F6E
      50726963652E4F726967696E010101010D0A6364734D6F64656C416363657373
      6F7279446973636F756E74506572632E436F6E73747261696E744572726F724D
      657373616765010101010D0A6364734D6F64656C4163636573736F7279446973
      636F756E74506572632E437573746F6D436F6E73747261696E74010101010D0A
      6364734D6F64656C4163636573736F7279446973636F756E74506572632E4465
      6661756C7445787072657373696F6E010101010D0A6364734D6F64656C416363
      6573736F7279446973636F756E74506572632E45646974466F726D6174010101
      010D0A6364734D6F64656C4163636573736F7279446973636F756E7450657263
      2E496D706F72746564436F6E73747261696E74010101010D0A6364734D6F6465
      6C4163636573736F7279446973636F756E74506572632E4B65794669656C6473
      010101010D0A6364734D6F64656C4163636573736F7279446973636F756E7450
      6572632E4C6F6F6B75704B65794669656C6473010101010D0A6364734D6F6465
      6C4163636573736F7279446973636F756E74506572632E4C6F6F6B7570526573
      756C744669656C64010101010D0A6364734D6F64656C4163636573736F727944
      6973636F756E74506572632E4F726967696E010101010D0A6364734D6F64656C
      4163636573736F727953656C6C696E6750726963652E436F6E73747261696E74
      4572726F724D657373616765010101010D0A6364734D6F64656C416363657373
      6F727953656C6C696E6750726963652E437573746F6D436F6E73747261696E74
      010101010D0A6364734D6F64656C4163636573736F727953656C6C696E675072
      6963652E44656661756C7445787072657373696F6E010101010D0A6364734D6F
      64656C4163636573736F727953656C6C696E6750726963652E45646974466F72
      6D6174010101010D0A6364734D6F64656C4163636573736F727953656C6C696E
      6750726963652E496D706F72746564436F6E73747261696E74010101010D0A63
      64734D6F64656C4163636573736F727953656C6C696E6750726963652E4B6579
      4669656C6473010101010D0A6364734D6F64656C4163636573736F727953656C
      6C696E6750726963652E4C6F6F6B75704B65794669656C6473010101010D0A63
      64734D6F64656C4163636573736F727953656C6C696E6750726963652E4C6F6F
      6B7570526573756C744669656C64010101010D0A6364734D6F64656C41636365
      73736F727953656C6C696E6750726963652E4F726967696E010101010D0A6364
      734D65696F5061672E436F6D6D616E6454657874010101010D0A6364734D6569
      6F5061672E46696C746572010101010D0A6364734D65696F5061672E496E6465
      784669656C644E616D6573010101010D0A6364734D65696F5061672E50726F76
      696465724E616D65016473704D65696F5061670101010D0A6364734D65696F50
      616749444D65696F5061672E436F6E73747261696E744572726F724D65737361
      6765010101010D0A6364734D65696F50616749444D65696F5061672E43757374
      6F6D436F6E73747261696E74010101010D0A6364734D65696F50616749444D65
      696F5061672E44656661756C7445787072657373696F6E010101010D0A636473
      4D65696F50616749444D65696F5061672E45646974466F726D6174010101010D
      0A6364734D65696F50616749444D65696F5061672E496D706F72746564436F6E
      73747261696E74010101010D0A6364734D65696F50616749444D65696F506167
      2E4B65794669656C6473010101010D0A6364734D65696F50616749444D65696F
      5061672E4C6F6F6B75704B65794669656C6473010101010D0A6364734D65696F
      50616749444D65696F5061672E4C6F6F6B7570526573756C744669656C640101
      01010D0A6364734D65696F50616749444D65696F5061672E4F726967696E0101
      01010D0A6364734D65696F5061674D65696F5061672E436F6E73747261696E74
      4572726F724D657373616765010101010D0A6364734D65696F5061674D65696F
      5061672E437573746F6D436F6E73747261696E74010101010D0A6364734D6569
      6F5061674D65696F5061672E44656661756C7445787072657373696F6E010101
      010D0A6364734D65696F5061674D65696F5061672E496D706F72746564436F6E
      73747261696E74010101010D0A6364734D65696F5061674D65696F5061672E4B
      65794669656C6473010101010D0A6364734D65696F5061674D65696F5061672E
      4C6F6F6B75704B65794669656C6473010101010D0A6364734D65696F5061674D
      65696F5061672E4C6F6F6B7570526573756C744669656C64010101010D0A6364
      734D65696F5061674D65696F5061672E4F726967696E010101010D0A6364734D
      65696F506167496D616765496E6465782E436F6E73747261696E744572726F72
      4D657373616765010101010D0A6364734D65696F506167496D616765496E6465
      782E437573746F6D436F6E73747261696E74010101010D0A6364734D65696F50
      6167496D616765496E6465782E44656661756C7445787072657373696F6E0101
      01010D0A6364734D65696F506167496D616765496E6465782E45646974466F72
      6D6174010101010D0A6364734D65696F506167496D616765496E6465782E496D
      706F72746564436F6E73747261696E74010101010D0A6364734D65696F506167
      496D616765496E6465782E4B65794669656C6473010101010D0A6364734D6569
      6F506167496D616765496E6465782E4C6F6F6B75704B65794669656C64730101
      01010D0A6364734D65696F506167496D616765496E6465782E4C6F6F6B757052
      6573756C744669656C64010101010D0A6364734D65696F506167496D61676549
      6E6465782E4F726967696E010101010D0A6364734D65696F5061675469706F2E
      436F6E73747261696E744572726F724D657373616765010101010D0A6364734D
      65696F5061675469706F2E437573746F6D436F6E73747261696E74010101010D
      0A6364734D65696F5061675469706F2E44656661756C7445787072657373696F
      6E010101010D0A6364734D65696F5061675469706F2E45646974466F726D6174
      010101010D0A6364734D65696F5061675469706F2E496D706F72746564436F6E
      73747261696E74010101010D0A6364734D65696F5061675469706F2E4B657946
      69656C6473010101010D0A6364734D65696F5061675469706F2E4C6F6F6B7570
      4B65794669656C6473010101010D0A6364734D65696F5061675469706F2E4C6F
      6F6B7570526573756C744669656C64010101010D0A6364734D65696F50616754
      69706F2E4F726967696E010101010D0A636473426172636F64652E436F6D6D61
      6E6454657874010101010D0A636473426172636F64652E46696C746572010101
      010D0A636473426172636F64652E496E6465784669656C644E616D6573010101
      010D0A636473426172636F64652E50726F76696465724E616D65016473704261
      72636F64650101010D0A636473426172636F646549444D6F64656C2E436F6E73
      747261696E744572726F724D657373616765010101010D0A636473426172636F
      646549444D6F64656C2E437573746F6D436F6E73747261696E74010101010D0A
      636473426172636F646549444D6F64656C2E44656661756C7445787072657373
      696F6E010101010D0A636473426172636F646549444D6F64656C2E4564697446
      6F726D6174010101010D0A636473426172636F646549444D6F64656C2E496D70
      6F72746564436F6E73747261696E74010101010D0A636473426172636F646549
      444D6F64656C2E4B65794669656C6473010101010D0A636473426172636F6465
      49444D6F64656C2E4C6F6F6B75704B65794669656C6473010101010D0A636473
      426172636F646549444D6F64656C2E4C6F6F6B7570526573756C744669656C64
      010101010D0A636473426172636F646549444D6F64656C2E4F726967696E0101
      01010D0A636473426172636F64654D6F64656C2E436F6E73747261696E744572
      726F724D657373616765010101010D0A636473426172636F64654D6F64656C2E
      437573746F6D436F6E73747261696E74010101010D0A636473426172636F6465
      4D6F64656C2E44656661756C7445787072657373696F6E010101010D0A636473
      426172636F64654D6F64656C2E496D706F72746564436F6E73747261696E7401
      0101010D0A636473426172636F64654D6F64656C2E4B65794669656C64730101
      01010D0A636473426172636F64654D6F64656C2E4C6F6F6B75704B6579466965
      6C6473010101010D0A636473426172636F64654D6F64656C2E4C6F6F6B757052
      6573756C744669656C64010101010D0A636473426172636F64654D6F64656C2E
      4F726967696E010101010D0A636473426172636F64654944426172636F64652E
      436F6E73747261696E744572726F724D657373616765010101010D0A63647342
      6172636F64654944426172636F64652E437573746F6D436F6E73747261696E74
      010101010D0A636473426172636F64654944426172636F64652E44656661756C
      7445787072657373696F6E010101010D0A636473426172636F64654944426172
      636F64652E496D706F72746564436F6E73747261696E74010101010D0A636473
      426172636F64654944426172636F64652E4B65794669656C6473010101010D0A
      636473426172636F64654944426172636F64652E4C6F6F6B75704B6579466965
      6C6473010101010D0A636473426172636F64654944426172636F64652E4C6F6F
      6B7570526573756C744669656C64010101010D0A636473426172636F64654944
      426172636F64652E4F726967696E010101010D0A636473426172636F64655365
      617263684944426172636F64652E436F6E73747261696E744572726F724D6573
      73616765010101010D0A636473426172636F6465536561726368494442617263
      6F64652E437573746F6D436F6E73747261696E74010101010D0A636473426172
      636F64655365617263684944426172636F64652E44656661756C744578707265
      7373696F6E010101010D0A636473426172636F64655365617263684944426172
      636F64652E496D706F72746564436F6E73747261696E74010101010D0A636473
      426172636F64655365617263684944426172636F64652E4B65794669656C6473
      010101010D0A636473426172636F64655365617263684944426172636F64652E
      4C6F6F6B75704B65794669656C6473010101010D0A636473426172636F646553
      65617263684944426172636F64652E4C6F6F6B7570526573756C744669656C64
      010101010D0A636473426172636F64655365617263684944426172636F64652E
      4F726967696E010101010D0A636473426172636F646553656172636849444D6F
      64656C2E436F6E73747261696E744572726F724D657373616765010101010D0A
      636473426172636F646553656172636849444D6F64656C2E437573746F6D436F
      6E73747261696E74010101010D0A636473426172636F64655365617263684944
      4D6F64656C2E44656661756C7445787072657373696F6E010101010D0A636473
      426172636F646553656172636849444D6F64656C2E45646974466F726D617401
      0101010D0A636473426172636F646553656172636849444D6F64656C2E496D70
      6F72746564436F6E73747261696E74010101010D0A636473426172636F646553
      656172636849444D6F64656C2E4B65794669656C6473010101010D0A63647342
      6172636F646553656172636849444D6F64656C2E4C6F6F6B75704B6579466965
      6C6473010101010D0A636473426172636F646553656172636849444D6F64656C
      2E4C6F6F6B7570526573756C744669656C64010101010D0A636473426172636F
      646553656172636849444D6F64656C2E4F726967696E010101010D0A63647342
      6172636F64655365617263684D6F64656C2E436F6E73747261696E744572726F
      724D657373616765010101010D0A636473426172636F64655365617263684D6F
      64656C2E437573746F6D436F6E73747261696E74010101010D0A636473426172
      636F64655365617263684D6F64656C2E44656661756C7445787072657373696F
      6E010101010D0A636473426172636F64655365617263684D6F64656C2E496D70
      6F72746564436F6E73747261696E74010101010D0A636473426172636F646553
      65617263684D6F64656C2E4B65794669656C6473010101010D0A636473426172
      636F64655365617263684D6F64656C2E4C6F6F6B75704B65794669656C647301
      0101010D0A636473426172636F64655365617263684D6F64656C2E4C6F6F6B75
      70526573756C744669656C64010101010D0A636473426172636F646553656172
      63684D6F64656C2E4F726967696E010101010D0A63647353797374656D557365
      7249445469706F506573736F612E436F6E73747261696E744572726F724D6573
      73616765010101010D0A63647353797374656D5573657249445469706F506573
      736F612E437573746F6D436F6E73747261696E74010101010D0A636473537973
      74656D5573657249445469706F506573736F612E44656661756C744578707265
      7373696F6E010101010D0A63647353797374656D5573657249445469706F5065
      73736F612E45646974466F726D6174010101010D0A63647353797374656D5573
      657249445469706F506573736F612E496D706F72746564436F6E73747261696E
      74010101010D0A63647353797374656D5573657249445469706F506573736F61
      2E4B65794669656C6473010101010D0A63647353797374656D55736572494454
      69706F506573736F612E4C6F6F6B75704B65794669656C6473010101010D0A63
      647353797374656D5573657249445469706F506573736F612E4C6F6F6B757052
      6573756C744669656C64010101010D0A63647353797374656D55736572494454
      69706F506573736F612E4F726967696E010101010D0A71754469736352616E67
      652E436F6D6D616E64546578740153454C454354191A0949445469706F436F6D
      697373696F6E61646F2C191A09546F7456656E64614D696E2C191A0950657263
      446973634D6178191A46524F4D2009191A094469736352616E67650101010D0A
      71754469736352616E67652E436F6E6E656374696F6E537472696E6701010101
      0D0A71754469736352616E67652E46696C746572010101010D0A717544697363
      52616E67652E496E6465784669656C644E616D6573010101010D0A6364734469
      736352616E67652E436F6D6D616E6454657874010101010D0A63647344697363
      52616E67652E46696C746572010101010D0A6364734469736352616E67652E49
      6E6465784669656C644E616D6573010101010D0A6364734469736352616E6765
      2E50726F76696465724E616D65016473704469736352616E67650101010D0A63
      64734469736352616E676549445469706F436F6D697373696F6E61646F2E436F
      6E73747261696E744572726F724D657373616765010101010D0A636473446973
      6352616E676549445469706F436F6D697373696F6E61646F2E437573746F6D43
      6F6E73747261696E74010101010D0A6364734469736352616E67654944546970
      6F436F6D697373696F6E61646F2E44656661756C7445787072657373696F6E01
      0101010D0A6364734469736352616E676549445469706F436F6D697373696F6E
      61646F2E45646974466F726D6174010101010D0A6364734469736352616E6765
      49445469706F436F6D697373696F6E61646F2E496D706F72746564436F6E7374
      7261696E74010101010D0A6364734469736352616E676549445469706F436F6D
      697373696F6E61646F2E4B65794669656C6473010101010D0A63647344697363
      52616E676549445469706F436F6D697373696F6E61646F2E4C6F6F6B75704B65
      794669656C6473010101010D0A6364734469736352616E676549445469706F43
      6F6D697373696F6E61646F2E4C6F6F6B7570526573756C744669656C64010101
      010D0A6364734469736352616E676549445469706F436F6D697373696F6E6164
      6F2E4F726967696E010101010D0A6364734469736352616E6765546F7456656E
      64614D696E2E436F6E73747261696E744572726F724D65737361676501010101
      0D0A6364734469736352616E6765546F7456656E64614D696E2E437573746F6D
      436F6E73747261696E74010101010D0A6364734469736352616E6765546F7456
      656E64614D696E2E44656661756C7445787072657373696F6E010101010D0A63
      64734469736352616E6765546F7456656E64614D696E2E45646974466F726D61
      74010101010D0A6364734469736352616E6765546F7456656E64614D696E2E49
      6D706F72746564436F6E73747261696E74010101010D0A636473446973635261
      6E6765546F7456656E64614D696E2E4B65794669656C6473010101010D0A6364
      734469736352616E6765546F7456656E64614D696E2E4C6F6F6B75704B657946
      69656C6473010101010D0A6364734469736352616E6765546F7456656E64614D
      696E2E4C6F6F6B7570526573756C744669656C64010101010D0A636473446973
      6352616E6765546F7456656E64614D696E2E4F726967696E010101010D0A6364
      734469736352616E676550657263446973634D61782E436F6E73747261696E74
      4572726F724D657373616765010101010D0A6364734469736352616E67655065
      7263446973634D61782E437573746F6D436F6E73747261696E74010101010D0A
      6364734469736352616E676550657263446973634D61782E44656661756C7445
      787072657373696F6E010101010D0A6364734469736352616E67655065726344
      6973634D61782E45646974466F726D6174010101010D0A636473446973635261
      6E676550657263446973634D61782E496D706F72746564436F6E73747261696E
      74010101010D0A6364734469736352616E676550657263446973634D61782E4B
      65794669656C6473010101010D0A6364734469736352616E6765506572634469
      73634D61782E4C6F6F6B75704B65794669656C6473010101010D0A6364734469
      736352616E676550657263446973634D61782E4C6F6F6B7570526573756C7446
      69656C64010101010D0A6364734469736352616E676550657263446973634D61
      782E4F726967696E010101010D0A7175496E7646656174757265732E436F6D6D
      616E64546578740153454C454354191A094944496E7646656174757265732C20
      191A0949444D6F64656C2C20191A094665617475726520191A46524F4D191A09
      496E764665617475726573191A5748455245191A094465736174697661646F20
      3D2030191A09414E44191A0949444D6F64656C203D203A49444D6F64656C191A
      0101010D0A7175496E7646656174757265732E436F6E6E656374696F6E537472
      696E67010101010D0A7175496E7646656174757265732E46696C746572010101
      010D0A7175496E7646656174757265732E496E6465784669656C644E616D6573
      010101010D0A636473496E7646656174757265732E436F6D6D616E6454657874
      010101010D0A636473496E7646656174757265732E46696C746572010101010D
      0A636473496E7646656174757265732E496E6465784669656C644E616D657301
      0101010D0A636473496E7646656174757265732E50726F76696465724E616D65
      01647370496E7646656174757265730101010D0A636473496E76466561747572
      65734944496E7646656174757265732E436F6E73747261696E744572726F724D
      657373616765010101010D0A636473496E7646656174757265734944496E7646
      656174757265732E437573746F6D436F6E73747261696E74010101010D0A6364
      73496E7646656174757265734944496E7646656174757265732E44656661756C
      7445787072657373696F6E010101010D0A636473496E76466561747572657349
      44496E7646656174757265732E45646974466F726D6174010101010D0A636473
      496E7646656174757265734944496E7646656174757265732E496D706F727465
      64436F6E73747261696E74010101010D0A636473496E76466561747572657349
      44496E7646656174757265732E4B65794669656C6473010101010D0A63647349
      6E7646656174757265734944496E7646656174757265732E4C6F6F6B75704B65
      794669656C6473010101010D0A636473496E7646656174757265734944496E76
      46656174757265732E4C6F6F6B7570526573756C744669656C64010101010D0A
      636473496E7646656174757265734944496E7646656174757265732E4F726967
      696E010101010D0A636473496E76466561747572657349444D6F64656C2E436F
      6E73747261696E744572726F724D657373616765010101010D0A636473496E76
      466561747572657349444D6F64656C2E437573746F6D436F6E73747261696E74
      010101010D0A636473496E76466561747572657349444D6F64656C2E44656661
      756C7445787072657373696F6E010101010D0A636473496E7646656174757265
      7349444D6F64656C2E45646974466F726D6174010101010D0A636473496E7646
      6561747572657349444D6F64656C2E496D706F72746564436F6E73747261696E
      74010101010D0A636473496E76466561747572657349444D6F64656C2E4B6579
      4669656C6473010101010D0A636473496E76466561747572657349444D6F6465
      6C2E4C6F6F6B75704B65794669656C6473010101010D0A636473496E76466561
      747572657349444D6F64656C2E4C6F6F6B7570526573756C744669656C640101
      01010D0A636473496E76466561747572657349444D6F64656C2E4F726967696E
      010101010D0A636473496E764665617475726573466561747572652E436F6E73
      747261696E744572726F724D657373616765010101010D0A636473496E764665
      617475726573466561747572652E437573746F6D436F6E73747261696E740101
      01010D0A636473496E764665617475726573466561747572652E44656661756C
      7445787072657373696F6E010101010D0A636473496E76466561747572657346
      6561747572652E496D706F72746564436F6E73747261696E74010101010D0A63
      6473496E764665617475726573466561747572652E4B65794669656C64730101
      01010D0A636473496E764665617475726573466561747572652E4C6F6F6B7570
      4B65794669656C6473010101010D0A636473496E764665617475726573466561
      747572652E4C6F6F6B7570526573756C744669656C64010101010D0A63647349
      6E764665617475726573466561747572652E4F726967696E010101010D0A7175
      496E7654656368466561742E436F6D6D616E64546578740153454C454354191A
      094944496E765465636846656174757265732C20191A0949444D6F64656C2C20
      191A095465636846656174757265191A46524F4D191A09496E76546563684665
      617475726573191A5748455245191A094465736174697661646F203D2030191A
      09414E44191A0949444D6F64656C203D203A49444D6F64656C0101010D0A7175
      496E7654656368466561742E436F6E6E656374696F6E537472696E6701010101
      0D0A7175496E7654656368466561742E46696C746572010101010D0A7175496E
      7654656368466561742E496E6465784669656C644E616D6573010101010D0A63
      6473496E7654656368466561742E436F6D6D616E6454657874010101010D0A63
      6473496E7654656368466561742E46696C746572010101010D0A636473496E76
      54656368466561742E496E6465784669656C644E616D6573010101010D0A6364
      73496E7654656368466561742E50726F76696465724E616D6501647370496E76
      54656368466561740101010D0A636473496E7654656368466561744944496E76
      5465636846656174757265732E436F6E73747261696E744572726F724D657373
      616765010101010D0A636473496E7654656368466561744944496E7654656368
      46656174757265732E437573746F6D436F6E73747261696E74010101010D0A63
      6473496E7654656368466561744944496E765465636846656174757265732E44
      656661756C7445787072657373696F6E010101010D0A636473496E7654656368
      466561744944496E765465636846656174757265732E45646974466F726D6174
      010101010D0A636473496E7654656368466561744944496E7654656368466561
      74757265732E496D706F72746564436F6E73747261696E74010101010D0A6364
      73496E7654656368466561744944496E765465636846656174757265732E4B65
      794669656C6473010101010D0A636473496E7654656368466561744944496E76
      5465636846656174757265732E4C6F6F6B75704B65794669656C647301010101
      0D0A636473496E7654656368466561744944496E765465636846656174757265
      732E4C6F6F6B7570526573756C744669656C64010101010D0A636473496E7654
      656368466561744944496E765465636846656174757265732E4F726967696E01
      0101010D0A636473496E76546563684665617449444D6F64656C2E436F6E7374
      7261696E744572726F724D657373616765010101010D0A636473496E76546563
      684665617449444D6F64656C2E437573746F6D436F6E73747261696E74010101
      010D0A636473496E76546563684665617449444D6F64656C2E44656661756C74
      45787072657373696F6E010101010D0A636473496E7654656368466561744944
      4D6F64656C2E45646974466F726D6174010101010D0A636473496E7654656368
      4665617449444D6F64656C2E496D706F72746564436F6E73747261696E740101
      01010D0A636473496E76546563684665617449444D6F64656C2E4B6579466965
      6C6473010101010D0A636473496E76546563684665617449444D6F64656C2E4C
      6F6F6B75704B65794669656C6473010101010D0A636473496E76546563684665
      617449444D6F64656C2E4C6F6F6B7570526573756C744669656C64010101010D
      0A636473496E76546563684665617449444D6F64656C2E4F726967696E010101
      010D0A636473496E76546563684665617454656368466561747572652E436F6E
      73747261696E744572726F724D657373616765010101010D0A636473496E7654
      6563684665617454656368466561747572652E437573746F6D436F6E73747261
      696E74010101010D0A636473496E765465636846656174546563684665617475
      72652E44656661756C7445787072657373696F6E010101010D0A636473496E76
      546563684665617454656368466561747572652E496D706F72746564436F6E73
      747261696E74010101010D0A636473496E765465636846656174546563684665
      61747572652E4B65794669656C6473010101010D0A636473496E765465636846
      65617454656368466561747572652E4C6F6F6B75704B65794669656C64730101
      01010D0A636473496E76546563684665617454656368466561747572652E4C6F
      6F6B7570526573756C744669656C64010101010D0A636473496E765465636846
      65617454656368466561747572652E4F726967696E010101010D0A73744C6F63
      616C65730D0A43757272656E637920537472696E67015224200101010D0A5468
      6F7573616E6420536570617261746F72012E0101010D0A446563696D616C2053
      6570617261746F72012C0101010D0A4461746520536570617261746F72012F01
      01010D0A53686F7274204461746520466F726D61740164642F4D4D2F79790101
      010D0A4C6F6E67204461746520466F726D617401646464642C20642720646520
      274D4D4D4D272064652027797979790101010D0A54696D652053657061726174
      6F72013A0101010D0A54696D6520414D20537472696E67010101010D0A54696D
      6520504D20537472696E67010101010D0A53686F72742054696D6520466F726D
      61740168683A6D6D0101010D0A4C6F6E672054696D6520466F726D6174016868
      3A6D6D3A73730101010D0A53686F7274204D6F6E7468204E616D6573016A616E
      2C6665762C6D61722C6162722C6D61692C6A756E2C6A756C2C61676F2C736574
      2C6F75742C6E6F762C64657A0101010D0A4C6F6E67204D6F6E7468204E616D65
      73016A616E6569726F2C66657665726569726F2C6D6172E76F2C616272696C2C
      6D61696F2C6A756E686F2C6A756C686F2C61676F73746F2C736574656D62726F
      2C6F75747562726F2C6E6F76656D62726F2C64657A656D62726F0101010D0A53
      686F727420446179204E616D657301646F6D2C7365672C7465722C7175612C71
      75692C7365782C73E1620101010D0A4C6F6E6720446179204E616D657301646F
      6D696E676F2C736567756E64612D66656972612C746572E7612D66656972612C
      7175617274612D66656972612C7175696E74612D66656972612C73657874612D
      66656972612C73E16261646F0101010D0A7374436F6C6C656374696F6E730D0A
      737443686172536574730D0A}
  end
  object quModelAccessory: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IA.IDInvAccessory,'#13#10#9'IA.IDModel,'#13#10#9'M.Model, '#13#10#9'M.Descri' +
      'ption,'#13#10#9'IA.Description as Hint,'#13#10#9'M.LargeImage,'#13#10#9'M.PromotionPr' +
      'ice,'#13#10#9'M.DiscountPerc,'#13#10#9'(CASE IsNull(I.SellingPrice,0) WHEN 0 T' +
      'HEN M.SellingPrice '#13#10#9'ELSE I.SellingPrice END) AS SellingPrice'#13#10 +
      'FROM'#13#10#9'InvAccessory IA'#13#10#9'JOIN Model M ON (M.IDModel=IA.IDInvAcce' +
      'ssory)'#13#10#9'LEFT OUTER JOIN Inventory I ON (I.ModelID = M.IDModel A' +
      'ND I.StoreID = :IDStore)'#13#10'WHERE'#13#10#9'IA.IDModel = :IDModel'#13#10#9'AND'#13#10#9 +
      'M.TotQtyOnHand > 0'#13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
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
    Left = 336
    Top = 336
  end
  object dspModelAccessory: TDataSetProvider
    DataSet = quModelAccessory
    Left = 336
    Top = 336
  end
  object cdsModelAccessory: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDStore'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDModel'
        ParamType = ptInput
      end>
    ProviderName = 'dspModelAccessory'
    BeforeOpen = cdsModelAccessoryBeforeOpen
    Left = 336
    Top = 336
    object cdsModelAccessoryIDInvAccessory: TIntegerField
      FieldName = 'IDInvAccessory'
    end
    object cdsModelAccessoryIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelAccessoryModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsModelAccessoryDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsModelAccessoryHint: TStringField
      FieldName = 'Hint'
      Size = 255
    end
    object cdsModelAccessoryLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
    object cdsModelAccessoryPromotionPrice: TBCDField
      FieldName = 'PromotionPrice'
      Precision = 19
    end
    object cdsModelAccessoryDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
    object cdsModelAccessorySellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
  end
  object dspMeioPag: TDataSetProvider
    DataSet = quMeioPag
    Left = 35
    Top = 192
  end
  object cdsMeioPag: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPag'
    Left = 36
    Top = 194
    object cdsMeioPagIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object cdsMeioPagMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object cdsMeioPagImageIndex: TIntegerField
      FieldName = 'ImageIndex'
    end
    object cdsMeioPagTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object cdsMeioPagRequireCustomer: TBooleanField
      FieldName = 'RequireCustomer'
    end
    object cdsMeioPagValidateNonpayer: TBooleanField
      FieldName = 'ValidateNonpayer'
    end
  end
  object dspBarcode: TDataSetProvider
    DataSet = quBarcode
    Left = 224
    Top = 336
  end
  object cdsBarcode: TClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    Params = <
      item
        DataType = ftInteger
        Name = 'StoreID'
        ParamType = ptInput
      end>
    ProviderName = 'dspBarcode'
    Left = 224
    Top = 336
    object cdsBarcodeIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsBarcodeModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsBarcodeIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object cdsBarcodeCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
      Visible = False
    end
  end
  object dspQty: TDataSetProvider
    DataSet = quQty
    Left = 436
    Top = 336
  end
  object tmLoadGlobal: TTimer
    Enabled = False
    OnTimer = tmLoadGlobalTimer
    Left = 432
    Top = 128
  end
  object quDiscRange: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDTipoComissionado,'#13#10#9'TotVendaMin,'#13#10#9'PercDiscMax'#13#10'FROM ' +
      #9#13#10#9'DiscRange'
    Parameters = <>
    Left = 28
    Top = 336
  end
  object dspDiscRange: TDataSetProvider
    DataSet = quDiscRange
    Left = 28
    Top = 336
  end
  object cdsDiscRange: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDiscRange'
    Left = 28
    Top = 336
    object cdsDiscRangeIDTipoComissionado: TIntegerField
      FieldName = 'IDTipoComissionado'
    end
    object cdsDiscRangeTotVendaMin: TBCDField
      FieldName = 'TotVendaMin'
      Precision = 19
    end
    object cdsDiscRangePercDiscMax: TBCDField
      FieldName = 'PercDiscMax'
      Precision = 19
    end
  end
  object quInvFeatures: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDInvFeatures, '#13#10#9'IDModel, '#13#10#9'Feature '#13#10'FROM'#13#10#9'InvFeatu' +
      'res'#13#10'WHERE'#13#10#9'Desativado = 0'#13#10#9'AND'#13#10#9'IDModel = :IDModel'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 28
    Top = 408
  end
  object dspInvFeatures: TDataSetProvider
    DataSet = quInvFeatures
    Left = 28
    Top = 408
  end
  object cdsInvFeatures: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDModel'
        ParamType = ptInput
      end>
    ProviderName = 'dspInvFeatures'
    Left = 28
    Top = 408
    object cdsInvFeaturesIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object cdsInvFeaturesIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsInvFeaturesFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object quInvTechFeat: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDInvTechFeatures, '#13#10#9'IDModel, '#13#10#9'TechFeature'#13#10'FROM'#13#10#9'I' +
      'nvTechFeatures'#13#10'WHERE'#13#10#9'Desativado = 0'#13#10#9'AND'#13#10#9'IDModel = :IDMode' +
      'l'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 120
    Top = 408
  end
  object dspInvTechFeat: TDataSetProvider
    DataSet = quInvTechFeat
    Left = 120
    Top = 408
  end
  object cdsInvTechFeat: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDModel'
        ParamType = ptInput
      end>
    ProviderName = 'dspInvTechFeat'
    Left = 120
    Top = 408
    object cdsInvTechFeatIDInvTechFeatures: TIntegerField
      FieldName = 'IDInvTechFeatures'
    end
    object cdsInvTechFeatIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsInvTechFeatTechFeature: TStringField
      FieldName = 'TechFeature'
      Size = 255
    end
  end
  object quQty: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'S.Name,'#13#10#9'I.QtyOnPreSale,'#13#10#9'I.QtyOnHand,'#13#10#9'I.QtyOnOrder' +
      ','#13#10#9'I.QtyOnRepair,'#13#10#9'I.StoreID,'#13#10#9'I.QtyOnPrePurchase,'#13#10#9'(IsNull(' +
      'M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost,0' +
      ')) as CurrentCost,'#13#10#9'M.FloatPercent,'#13#10#9'M.IDModel'#13#10'FROM'#13#10#9'Invento' +
      'ry I'#13#10#9'JOIN Model M ON (I.ModelID = M.IDModel)'#13#10#9'JOIN Store S ON' +
      ' (S.IDStore = I.StoreID)'#13#10'WHERE'#13#10#9'M.Desativado = 0'#13#10#9'AND M.Hidde' +
      'n = 0'#13#10#9'AND S.Desativado = 0'#13#10#9'AND S.Hidden = 0'#13#10#9'AND ModelType ' +
      'IN ('#39'S'#39','#39'R'#39','#39'V'#39', '#39'C'#39', '#39'K'#39')'#13#10#9'AND I.ModelID = :ModelID'
    Parameters = <
      item
        Name = 'ModelID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 436
    Top = 336
    object quQtyName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quQtyQtyOnPreSale: TBCDField
      FieldName = 'QtyOnPreSale'
      Precision = 32
    end
    object quQtyQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      Precision = 32
    end
    object quQtyQtyOnOrder: TBCDField
      FieldName = 'QtyOnOrder'
      Precision = 32
    end
    object quQtyQtyOnRepair: TBCDField
      FieldName = 'QtyOnRepair'
      Precision = 32
    end
    object quQtyStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object quQtyQtyOnPrePurchase: TBCDField
      FieldName = 'QtyOnPrePurchase'
      Precision = 32
    end
    object quQtyCurrentCost: TBCDField
      FieldName = 'CurrentCost'
      ReadOnly = True
      Precision = 19
    end
    object quQtyFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object quQtyIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object cdsQty: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspQty'
    Left = 436
    Top = 336
    object cdsQtyName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object cdsQtyQtyOnPreSale: TBCDField
      FieldName = 'QtyOnPreSale'
      Precision = 32
    end
    object cdsQtyQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      Precision = 32
    end
    object cdsQtyQtyOnOrder: TBCDField
      FieldName = 'QtyOnOrder'
      Precision = 32
    end
    object cdsQtyQtyOnRepair: TBCDField
      FieldName = 'QtyOnRepair'
      Precision = 32
    end
    object cdsQtyStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object cdsQtyQtyOnPrePurchase: TBCDField
      FieldName = 'QtyOnPrePurchase'
      Precision = 32
    end
    object cdsQtyCurrentCost: TBCDField
      FieldName = 'CurrentCost'
      ReadOnly = True
      Precision = 19
    end
    object cdsQtyFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object cdsQtyIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object quInvDepartment: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IDDepartment, '#13#10#9'Department '#13#10'FROM'#13#10#9'Inv_Department'#13#10'WH' +
      'ERE'#13#10#9'Desativado = 0'#13#10#9'AND'#13#10#9'Hidden = 0'
    Parameters = <>
    Left = 224
    Top = 408
  end
  object quInvModelDepartment: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'MD.ModelID, '#13#10#9'MD.IDDepartment,'#13#10#9'D.Department'#13#10'FROM'#13#10#9 +
      'Inv_ModelDepartment MD INNER JOIN'#13#10#9'Inv_Department D ON (MD.IDDe' +
      'partment = D.IDDepartment)'#13#10'WHERE'#13#10#9'D.Desativado = 0'#13#10#9'AND'#13#10#9'D.H' +
      'idden = 0'#13#10#9'AND'#13#10#9'MD.StoreID = :IDStore'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 336
    Top = 408
    object quInvModelDepartmentModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quInvModelDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object quInvModelDepartmentDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object dspInvDepartment: TDataSetProvider
    DataSet = quInvDepartment
    Options = [poIncFieldProps]
    Left = 224
    Top = 408
  end
  object dspInvModelDepartment: TDataSetProvider
    DataSet = quInvModelDepartment
    Options = [poIncFieldProps]
    Left = 336
    Top = 408
  end
  object cdsInvDepartment: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvDepartment'
    Left = 224
    Top = 408
    object cdsInvDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object cdsInvDepartmentDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object cdsInvModelDepartment: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspInvModelDepartment'
    Left = 336
    Top = 408
    object cdsInvModelDepartmentModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object cdsInvModelDepartmentIDDepartment: TIntegerField
      FieldName = 'IDDepartment'
    end
    object cdsInvModelDepartmentDepartment: TStringField
      FieldName = 'Department'
      Size = 50
    end
  end
  object quTotalMeioPag: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'CASE WHEN MP.Tipo = 1 THEN '#39'Cash'#39
      #9'     WHEN MP.Tipo = 2 THEN '#39'Credit card'#39' '
      #9'     WHEN MP.Tipo = 3 THEN '#39'Others'#39
      '             WHEN MP.Tipo = 4 THEN '#39'Check'#39
      '             WHEN MP.Tipo = 5 THEN '#39'StoreCredit'#39#9
      #9'     WHEN MP.Tipo = 6 THEN '#39'GiftCard'#39' '
      #9'     WHEN MP.Tipo = 7 THEN '#39'DebitCard'#39' END DescriptionType,'
      #9'MP.Tipo,'
      #9'SUM(FL.ValorNominal) Total'
      'FROM'
      #9'Fin_Lancamento FL'
      #9'JOIN MeioPag MP ON (MP.IDMeioPag = FL.IDQuitacaoMeioprevisto)'#9
      'WHERE'
      #9'FL.IDCashRegMov = :IDCashRegMov'
      'GROUP BY MP.Tipo')
    Left = 287
    Top = 82
  end
  object quTotalDeposited: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SUM(CRL.TotalCard) as TotalCard,'#13#10#9'SUM(CRL.TotalOther) ' +
      'as TotalOther,'#13#10#9'SUM(CRL.TotalCash) as TotalCash,'#13#10#9'SUM(CRL.Tota' +
      'lCheck) as TotalCheck,'#13#10#9'SUM(CRL.TotalCardPre) as TotalPre,'#13#10#9'SU' +
      'M(CRL.TotalDebit) as TotalDebit'#13#10'FROM'#13#10#9'CashRegLog CRL'#13#10'WHERE'#13#10#9 +
      'CRL.IDCashRegMov = :IDCashRegMov'#13#10#9'AND'#13#10#9'CRL.IDCashRegTipoLog in' +
      ' (2,6)'
    Parameters = <
      item
        Name = 'IDCashRegMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 288
    Top = 36
  end
  object tmrSaveFilesToServer: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrSaveFilesToServerTimer
    Left = 524
    Top = 128
  end
  object dspInvSerial: TDataSetProvider
    DataSet = quInvSerial
    Left = 432
    Top = 408
  end
  object quInvSerial: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'StoreID,'#13#10#9'ModelID,'#13#10#9'Serial'#13#10'FROM'#13#10#9'InventorySerial'#13#10'W' +
      'HERE'#13#10#9'StoreID = :StoreID'#13#10#9'AND'#13#10#9'ModelID = :ModelID'#13#10
    Parameters = <
      item
        Name = 'StoreID'
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
      end>
    Left = 432
    Top = 408
    object quInvSerialStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object quInvSerialModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quInvSerialSerial: TStringField
      FieldName = 'Serial'
      Size = 30
    end
  end
  object cdsInvSerial: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'StoreID'
        ParamType = ptInput
        Size = 4
      end
      item
        DataType = ftInteger
        Precision = 10
        Name = 'ModelID'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspInvSerial'
    BeforeOpen = cdsInvSerialBeforeOpen
    Left = 432
    Top = 408
    object cdsInvSerialStoreID: TIntegerField
      FieldName = 'StoreID'
      Visible = False
    end
    object cdsInvSerialModelID: TIntegerField
      FieldName = 'ModelID'
      Visible = False
    end
    object cdsInvSerialSerial: TStringField
      FieldName = 'Serial'
      Size = 30
    end
  end
  object dspStoreTablePrice: TDataSetProvider
    DataSet = quStoreTablePrice
    Left = 524
    Top = 408
  end
  object quStoreTablePrice: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'ISP.IDStore,'#13#10#9'ISP.IDModel,'#13#10#9'ISP.IDDescriptionPrice,'#13#10 +
      #9'ISP.IDVendor,'#13#10#9'ISP.SuggPrice,'#13#10#9'ISP.SalePrice,'#13#10#9'IDP.Descripti' +
      'onPrice,'#13#10#9'V.Pessoa Vendor'#13#10'FROM'#13#10#9'Inv_StorePrice ISP'#13#10#9'JOIN Inv' +
      '_DescriptionPrice IDP ON (ISP.IDDescriptionPrice = IDP.IDDescrip' +
      'tionPrice)'#13#10#9'LEFT JOIN Pessoa V ON (ISP.IDVendor = V.IDPessoa)'#13#10 +
      'WHERE'#13#10#9'ISP.IDStore = :IDStore'#13#10#9'AND ISP.IDModel = :IDModel'#13#10
    Parameters = <
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = 4
        Value = Null
      end>
    Left = 524
    Top = 408
    object quStoreTablePriceIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreTablePriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quStoreTablePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object quStoreTablePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quStoreTablePriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      Precision = 19
    end
    object quStoreTablePriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quStoreTablePriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
    object quStoreTablePriceVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object cdsStoreTablePrice: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDStore'
        ParamType = ptInput
        Size = 4
      end
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDModel'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspStoreTablePrice'
    BeforeOpen = cdsInvSerialBeforeOpen
    Left = 524
    Top = 408
    object cdsStoreTablePriceIDStore: TIntegerField
      FieldName = 'IDStore'
      Visible = False
    end
    object cdsStoreTablePriceIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object cdsStoreTablePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
      Visible = False
    end
    object cdsStoreTablePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
      Visible = False
    end
    object cdsStoreTablePriceDescriptionPrice: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DescriptionPrice'
    end
    object cdsStoreTablePriceVendor: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsStoreTablePriceSuggPrice: TBCDField
      DisplayLabel = 'Pr'#231' Sugerido'
      FieldName = 'SuggPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsStoreTablePriceSalePrice: TBCDField
      DisplayLabel = 'Pr'#231' Venda'
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dspModelTablePrice: TDataSetProvider
    DataSet = quModelTablePrice
    Left = 520
    Top = 335
  end
  object quModelTablePrice: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'IMP.IDModel,'#13#10#9'IMP.IDDescriptionPrice,'#13#10#9'IMP.IDVendor,'#13 +
      #10#9'IMP.SuggPrice,'#13#10#9'IMP.SalePrice,'#13#10#9'IDP.DescriptionPrice,'#13#10#9'V.Pe' +
      'ssoa Vendor'#13#10'FROM'#13#10#9'Inv_ModelPrice IMP'#13#10#9'JOIN Inv_DescriptionPri' +
      'ce IDP ON (IMP.IDDescriptionPrice = IDP.IDDescriptionPrice)'#13#10#9'LE' +
      'FT JOIN Pessoa V ON (IMP.IDVendor = V.IDPessoa)'#13#10'WHERE'#13#10#9'IMP.IDM' +
      'odel = :IDModel'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = 4
        Value = Null
      end>
    Left = 520
    Top = 335
    object quModelTablePriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelTablePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object quModelTablePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quModelTablePriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      Precision = 19
    end
    object quModelTablePriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quModelTablePriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
    object quModelTablePriceVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object cdsModelTablePrice: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDModel'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspModelTablePrice'
    BeforeOpen = cdsInvSerialBeforeOpen
    Left = 520
    Top = 336
    object cdsModelTablePriceIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object cdsModelTablePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
      Visible = False
    end
    object cdsModelTablePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
      Visible = False
    end
    object cdsModelTablePriceDescriptionPrice: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DescriptionPrice'
    end
    object cdsModelTablePriceVendor: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'Vendor'
      Size = 50
    end
    object cdsModelTablePriceSuggPrice: TBCDField
      DisplayLabel = 'Pr'#231' Sugerido'
      FieldName = 'SuggPrice'
      Visible = False
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelTablePriceSalePrice: TBCDField
      DisplayLabel = 'Pr'#231' Venda'
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dspDocumentType: TDataSetProvider
    DataSet = quDocumentType
    Left = 524
    Top = 256
  end
  object quDocumentType: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'DT.IDDocumentType,'#13#10#9'DT.DocumentType,'#13#10#9'DT.DefaultType'#13 +
      #10'FROM'#13#10#9'Mnt_DocumentType DT'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = 4
        Value = Null
      end>
    Left = 524
    Top = 256
    object quDocumentTypeIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object quDocumentTypeDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object quDocumentTypeDefaultType: TBooleanField
      FieldName = 'DefaultType'
    end
  end
  object cdsDocumentType: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDModel'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspDocumentType'
    BeforeOpen = cdsInvSerialBeforeOpen
    Left = 524
    Top = 256
    object cdsDocumentTypeIDDocumentType: TIntegerField
      FieldName = 'IDDocumentType'
    end
    object cdsDocumentTypeDocumentType: TStringField
      FieldName = 'DocumentType'
      Size = 40
    end
    object cdsDocumentTypeDefaultType: TBooleanField
      FieldName = 'DefaultType'
    end
  end
  object quMeioPagMinSale: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'MPMS.IDMeioPag,'
      #9'MPMS.DifDay,'
      #9'MPMS.TotalSale'
      'FROM'
      #9'MeioPagMinSale MPMS(NOLOCK)')
    Left = 124
    Top = 200
  end
  object dspMeioPagMinSale: TDataSetProvider
    DataSet = quMeioPagMinSale
    Left = 124
    Top = 200
  end
  object cdsMeioPagMinSale: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPagMinSale'
    Left = 124
    Top = 200
    object cdsMeioPagMinSaleIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object cdsMeioPagMinSaleDifDay: TIntegerField
      FieldName = 'DifDay'
    end
    object cdsMeioPagMinSaleTotalSale: TBCDField
      FieldName = 'TotalSale'
      Precision = 19
    end
  end
  object cdsQtySold: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 525
    Top = 185
    object cdsQtySoldIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsQtySoldQty: TBCDField
      FieldName = 'Qty'
      Precision = 32
    end
    object cdsQtySoldSaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
  end
end
