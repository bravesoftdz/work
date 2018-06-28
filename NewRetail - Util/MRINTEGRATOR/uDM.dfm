object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 394
  Top = 233
  Height = 237
  Width = 298
  object MRDBConnection: TADOConnection
    CommandTimeout = 180
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mruser2000;Persist Security Info=Tr' +
      'ue;User ID=mruser;Initial Catalog=CeldomDB;Data Source=.;Use Pro' +
      'cedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workst' +
      'ation ID=RETAIL;Use Encryption for Data=False;Tag with column co' +
      'llation when possible=False'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 45
    Top = 10
  end
  object quCustomer: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT DISTINCT'#13#10#9'P.IDStore as StoreNumber,'#13#10#9'P.IDPessoa as Cust' +
      'omer_No,'#13#10#9'P.UserCode as UserCode,  '#13#10#9'P.Pessoa '#9'as EntityFullNa' +
      'me, '#13#10#9'P.Endereco'#9'as Address,'#13#10#9'P.NomeJuridico '#9'as DBA,'#13#10#9'P.Cida' +
      'de '#9'as City, '#13#10#9'P.CEP '#9#9'as Zip, '#13#10#9'P.Pais '#9#9'as Country, '#13#10#9'P.Tel' +
      'efone '#9'as Phone, '#13#10#9'P.Cellular '#9'as CellPhone, '#13#10#9'P.Fax '#9#9'as Fax,' +
      ' '#13#10#9'P.Contato '#9'as Contact, '#13#10#9'P.Juridico '#9'as Type, '#13#10#9'P.Nascimen' +
      'to '#9'as BirthDay, '#13#10#9'P.CartTrabalho '#9'as SocialSecurity, '#13#10#9'P.Insc' +
      'Estadual '#9'as FederalID,'#13#10#9'P.InscMunicipal as SalesTax, '#13#10#9'P.Cont' +
      'atos '#9'as CompanyContact,'#13#10#9'P.OrgaoEmissor '#9'as DriveLicence, '#13#10#9'P' +
      '.PessoaLastName '#9'as LastName, '#13#10#9'P.PessoaFirstName '#9'as FirstName' +
      ','#13#10#9'P.HorasSemana '#9#9'as HorsPerWeek, '#13#10#9'P.ValorHora '#9#9'as HourValu' +
      'e,'#13#10#9'P.ValorHoraExtra '#9'as OverHourValue,'#13#10#9'P.ValorHoraExtraExtra' +
      ' '#9'as DoubleHourValue,'#13#10#9'P.CustomerCard, '#13#10#9'P.Code, '#13#10#9'P.HomePage' +
      ', '#13#10#9'P.Email, '#13#10#9'P.OBS, '#13#10#9'ES.IDEstado as StateCode,'#13#10#9'ES.Estado' +
      ' as State'#13#10'FROM '#13#10#9'Pessoa P (NOLOCK)'#13#10#9'JOIN TipoPessoa TP ON (P.' +
      'IDTipoPessoa=TP.IDTipoPessoa)'#13#10#9'LEFT JOIN Estado ES ON (P.IDEsta' +
      'do=ES.IDEstado)'#13#10'WHERE '#13#10#9'Path LIKE '#39'.001%'#39' '#13#10#9'AND'#13#10#9'P.Desativad' +
      'o = 0'#13#10#9'AND'#13#10#9'P.Hidden = 0'
    CommandTimeout = 800
    Parameters = <>
    Left = 45
    Top = 85
    object quCustomerStoreNumber: TIntegerField
      FieldName = 'StoreNumber'
    end
    object quCustomerCustomer_No: TIntegerField
      FieldName = 'Customer_No'
    end
    object quCustomerUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object quCustomerEntityFullName: TStringField
      FieldName = 'EntityFullName'
      Size = 50
    end
    object quCustomerAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quCustomerDBA: TStringField
      FieldName = 'DBA'
      Size = 50
    end
    object quCustomerCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object quCustomerZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object quCustomerCountry: TStringField
      FieldName = 'Country'
      Size = 21
    end
    object quCustomerPhone: TStringField
      FieldName = 'Phone'
      Size = 40
    end
    object quCustomerCellPhone: TStringField
      FieldName = 'CellPhone'
      FixedChar = True
      Size = 18
    end
    object quCustomerFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quCustomerContact: TStringField
      FieldName = 'Contact'
      Size = 50
    end
    object quCustomerType: TBooleanField
      FieldName = 'Type'
    end
    object quCustomerBirthDay: TDateTimeField
      FieldName = 'BirthDay'
    end
    object quCustomerSocialSecurity: TStringField
      FieldName = 'SocialSecurity'
      Size = 30
    end
    object quCustomerFederalID: TStringField
      FieldName = 'FederalID'
      Size = 30
    end
    object quCustomerSalesTax: TStringField
      FieldName = 'SalesTax'
      Size = 30
    end
    object quCustomerCompanyContact: TStringField
      FieldName = 'CompanyContact'
      Size = 255
    end
    object quCustomerDriveLicence: TStringField
      FieldName = 'DriveLicence'
      Size = 50
    end
    object quCustomerLastName: TStringField
      FieldName = 'LastName'
      Size = 30
    end
    object quCustomerFirstName: TStringField
      FieldName = 'FirstName'
      Size = 30
    end
    object quCustomerHorsPerWeek: TIntegerField
      FieldName = 'HorsPerWeek'
    end
    object quCustomerHourValue: TBCDField
      FieldName = 'HourValue'
      Precision = 19
    end
    object quCustomerOverHourValue: TBCDField
      FieldName = 'OverHourValue'
      Precision = 19
    end
    object quCustomerDoubleHourValue: TBCDField
      FieldName = 'DoubleHourValue'
      Precision = 19
    end
    object quCustomerCustomerCard: TStringField
      FieldName = 'CustomerCard'
    end
    object quCustomerCode: TIntegerField
      FieldName = 'Code'
    end
    object quCustomerHomePage: TStringField
      FieldName = 'HomePage'
      Size = 200
    end
    object quCustomerEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quCustomerOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
    object quCustomerStateCode: TStringField
      FieldName = 'StateCode'
      FixedChar = True
      Size = 3
    end
    object quCustomerState: TStringField
      FieldName = 'State'
      Size = 50
    end
  end
  object quPaymentTotal: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT  '#13#10#9'MP.IDMeioPag AS IDPaymentType,'#13#10#9'MP.Tipo AS Type,'#13#10'  ' +
      '              MP.MeioPag AS PaymentType,'#13#10'                SUM(F.' +
      'ValorNominal) AS TotalType'#13#10'FROM '#13#10#9'Fin_Lancamento F'#13#10#9'INNER JOI' +
      'N Invoice I ON (I.IDPreSale = F.IDPreSale)'#13#10#9'INNER JOIN MeioPag ' +
      'MP ON (MP.IDMeioPag = F.IDQuitacaoMeioPrevisto)'#13#10'WHERE'#13#10#9'I.IDInv' +
      'oice IS NOT NULL'#13#10#9'AND'#13#10#9'I.Canceled = 0 '#13#10#9'AND'#9#13#10#9'MP.Tipo IS NOT' +
      ' NULL'#13#10#9'AND'#13#10#9'MP.ParentType = '#39'Sale'#39#13#10#9'AND'#13#10#9'(I.InvoiceDate>=:Be' +
      'ginDate)'#13#10#9'AND'#13#10#9'(I.InvoiceDate<:EndDate)'#13#10'GROUP BY '#13#10#9'MP.IDMeio' +
      'Pag,'#13#10#9'MP.Tipo,'#13#10#9'MP.MeioPag '#13#10
    CommandTimeout = 800
    Parameters = <
      item
        Name = 'BeginDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 135
    Top = 15
    object quPaymentTotalIDPaymentType: TIntegerField
      FieldName = 'IDPaymentType'
    end
    object quPaymentTotalType: TIntegerField
      FieldName = 'Type'
    end
    object quPaymentTotalPaymentType: TStringField
      FieldName = 'PaymentType'
      Size = 50
    end
    object quPaymentTotalTotalType: TBCDField
      FieldName = 'TotalType'
      ReadOnly = True
      Precision = 19
    end
  end
  object quPaymentDetail: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT  '#13#10#9'I.InvoiceCode AS InvoiceNumber,'#13#10#9'Convert(varchar,F.D' +
      'ataLancamento,103) AS RecordDate,'#13#10#9'P.Pessoa AS CustomerFullName' +
      ','#13#10#9'P.IDPessoa AS Customer_No, '#13#10#9'P.UserCode AS UserCode,'#13#10#9'MP.I' +
      'DMeioPag AS IDPaymentType,'#13#10#9'MP.Tipo AS Type,'#13#10#9'MP.MeioPag AS Pa' +
      'ymentType, '#13#10#9'F.ValorNominal AS TotalAmount'#13#10'FROM '#13#10#9'Fin_Lancame' +
      'nto F'#13#10#9'INNER JOIN Invoice I ON (I.IDPreSale = F.IDPreSale)'#13#10#9'IN' +
      'NER JOIN MeioPag MP ON (MP.IDMeioPag = F.IDQuitacaoMeioPrevisto)' +
      #13#10#9'INNER JOIN Pessoa P ON (P.IDPessoa = I.IDCustomer)'#13#10'WHERE '#13#10#9 +
      'I.IDInvoice IS NOT NULL'#13#10#9'AND'#13#10#9'I.Canceled = 0 '#13#10#9'AND'#9#13#10#9'MP.Tipo' +
      ' IS NOT NULL'#13#10#9'AND'#13#10#9'MP.ParentType = '#39'Sale'#39#13#10#9'AND'#13#10#9'(I.InvoiceDa' +
      'te>=:BeginDate)'#13#10#9'AND'#13#10#9'(I.InvoiceDate<:EndDate)'#13#10#9'AND'#13#10#9'MP.IDMe' +
      'ioPag = :IDMeioPag'#13#10
    Parameters = <
      item
        Name = 'BeginDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDMeioPag'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 230
    Top = 15
    object quPaymentDetailInvoiceNumber: TStringField
      FieldName = 'InvoiceNumber'
    end
    object quPaymentDetailRecordDate: TStringField
      FieldName = 'RecordDate'
      ReadOnly = True
      Size = 30
    end
    object quPaymentDetailCustomerFullName: TStringField
      FieldName = 'CustomerFullName'
      Size = 50
    end
    object quPaymentDetailCustomer_No: TIntegerField
      FieldName = 'Customer_No'
    end
    object quPaymentDetailUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object quPaymentDetailIDPaymentType: TIntegerField
      FieldName = 'IDPaymentType'
    end
    object quPaymentDetailType: TIntegerField
      FieldName = 'Type'
    end
    object quPaymentDetailPaymentType: TStringField
      FieldName = 'PaymentType'
      Size = 50
    end
    object quPaymentDetailTotalAmount: TBCDField
      FieldName = 'TotalAmount'
      Precision = 19
    end
  end
  object quSaleInvoice: TADODataSet
    Connection = MRDBConnection
    OnCalcFields = quSaleInvoiceCalcFields
    CommandText = 
      'SELECT  '#13#10#9'I.InvoiceCode as InvoiceNumber,'#13#10#9'I.InvoiceDate,'#13#10#9'P.' +
      'IDPessoa as Customer_No,'#13#10#9'P.UserCode as UserCode,'#13#10#9'B.IDBarcode' +
      ' as ItemNumber,'#13#10#9'( CASE WHEN (B.IDBarcode is NULL or B.IDBarcod' +
      'e = '#39#39')  THEN '#39'3'#39' ELSE '#39'1'#39' END  ) as LineType,'#13#10#9'( CASE WHEN MOV' +
      '.Discount = 0 THEN '#39'N'#39' ELSE '#39'Y'#39' END) as Discount,'#13#10#9'( CASE WHEN ' +
      'M.MODEL LIKE '#39'*%'#39' THEN '#39'Y'#39' ELSE '#39'N'#39' END) as MiscItemFlag,'#13#10#9'( CA' +
      'SE WHEN M.MODEL LIKE '#39'*%'#39' THEN M.MODEL ELSE '#39#39' END) as MiscItemC' +
      'ode,'#13#10#9'M.GroupID as ProductLine,'#13#10#9'MOV.Qty,'#13#10#9'MOV.SalePrice as U' +
      'nitPrice,'#13#10#9'((MOV.SalePrice - MOV.Discount) * MOV.Qty ) as Price' +
      'Extension,'#13#10#9'(I.SubTotal * (1 - I.TaxIsent)) as TaxableAmount,'#13#10 +
      #9'(I.SubTotal * TaxIsent) as NonTaxableAmount,'#13#10#9'I.Tax as SalesTa' +
      'x,'#13#10#9'( CASE WHEN MOV.SalePrice = 0 THEN 0 '#13#10#9'       ELSE ((MOV.D' +
      'iscount * -1) / MOV.SalePrice) * 100 END) as LineDiscountPercent' +
      ','#13#10#9'MOV.CostPrice '#9'as UnitCost,'#13#10#9'M.Description '#9'as ItemDescript' +
      'ion,'#13#10#9'I.DeliverDate '#9'as ShippingDate,'#13#10#9'I.PreSaleDate '#9'as Order' +
      'Date,'#13#10#9'I.InvoiceDate '#9'as InvoiceDueDate,'#13#10#9'I.InvoiceDate '#9'as Di' +
      'scountDueDate,'#13#10#9'P.Pessoa '#9'as CustomerName, '#13#10#9'P.Endereco'#9'as Cus' +
      'tomerAddress,'#13#10#9'P.Cidade '#9'as CustomerCity, '#13#10#9'P.CEP '#9#9'as Custome' +
      'rZip, '#13#10#9'ES.IDEstado'#9'as CustomerStateCode,'#13#10#9'ES.Estado '#9'as Custo' +
      'merState,'#13#10#9'I.DeliverAddress as ShipToAddress,'#13#10#9'I.DeliverOBS Co' +
      'mmentLine,'#13#10#9'(MOV.Discount * -1) as DiscountValue,'#13#10#9'M.FreightCo' +
      'st '#9'as Freight,'#13#10#9'(MOV.SalePrice * MOV.Qty - MOV.Discount) + ROU' +
      'ND(((MOV.SalePrice * MOV.Qty - MOV.Discount) * (MOV.SalesTax * I' +
      '.TaxIsent)),2) as ExtTotalSale,'#13#10#9'S.Name as StoreName,'#13#10#9'TG.Name' +
      ' as CategoryName,'#13#10#9'CTAX.TaxCategory,'#13#10#9'( CASE WHEN SM.SerialNum' +
      'ber IS NULL THEN '#39'N'#39' ELSE '#39'6'#39' END) as SerialNumber,'#13#10#9'( CASE WHE' +
      'N TaxIsent = 1 THEN '#39'NX'#39' '#13#10#9'       ELSE '#39'TX'#39' END) as TaxClass '#13#10 +
      'FROM '#13#10#9'Invoice I'#13#10#9'INNER JOIN Pessoa P ON (P.IDPessoa = I.IDCus' +
      'tomer)'#13#10#9'INNER JOIN InventoryMov MOV ON (MOV.DocumentID = I.IDIn' +
      'voice)'#13#10#9'LEFT JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov' +
      ' = MOV.IDInventoryMov)'#13#10#9'INNER JOIN InventoryMovTax MTAX ON (MTA' +
      'X.IDInventoryMov = MOV.IDInventoryMov)'#13#10#9'INNER JOIN Model M ON(M' +
      '.IDModel = MOV.ModelID)'#13#10#9'LEFT JOIN Barcode B ON (B.IDModel = M.' +
      'IDModel)'#13#10#9'INNER JOIN Store S ON (S.IDStore = I.IDStore)'#13#10#9'INNER' +
      ' JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)'#13#10#9'INNER JOIN TaxCa' +
      'tegory CTAX ON (CTAX.IDTaxCategory = MTAX.IDTaxCategory)'#13#10#9'LEFT ' +
      'JOIN Estado ES ON (P. IDEstado = ES.IDEstado)'#13#10#9'LEFT JOIN Serial' +
      'Mov SM ON (SM.InventoryMovID = MOV.IDInventoryMov)'#13#10'WHERE '#13#10#9'I.I' +
      'DInvoice IS NOT NULL'#13#10#9'AND'#13#10#9'I.Canceled = 0 '#13#10#9'AND'#13#10#9'(I.InvoiceD' +
      'ate>=:BeginDate)'#13#10#9'AND'#13#10#9'(I.InvoiceDate<:EndDate + 1)'#13#10#9#13#10#9
    Parameters = <
      item
        Name = 'BeginDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'EndDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 125
    Top = 85
    object quSaleInvoiceInvoiceNumber: TStringField
      FieldName = 'InvoiceNumber'
    end
    object quSaleInvoiceInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object quSaleInvoiceCustomer_No: TIntegerField
      FieldName = 'Customer_No'
    end
    object quSaleInvoiceDiscount: TStringField
      FieldName = 'Discount'
      ReadOnly = True
      Size = 1
    end
    object quSaleInvoiceProductLine: TIntegerField
      FieldName = 'ProductLine'
    end
    object quSaleInvoiceUnitPrice: TBCDField
      FieldName = 'UnitPrice'
      Precision = 19
    end
    object quSaleInvoicePriceExtension: TBCDField
      FieldName = 'PriceExtension'
      ReadOnly = True
      Precision = 19
    end
    object quSaleInvoiceTaxableAmount: TBCDField
      FieldName = 'TaxableAmount'
      ReadOnly = True
      Precision = 19
    end
    object quSaleInvoiceNonTaxableAmount: TBCDField
      FieldName = 'NonTaxableAmount'
      ReadOnly = True
      Precision = 19
    end
    object quSaleInvoiceSalesTax: TBCDField
      FieldName = 'SalesTax'
      Precision = 19
    end
    object quSaleInvoiceLineDiscountPercent: TBCDField
      FieldName = 'LineDiscountPercent'
      ReadOnly = True
      Precision = 19
    end
    object quSaleInvoiceUnitCost: TBCDField
      FieldName = 'UnitCost'
      Precision = 19
    end
    object quSaleInvoiceItemDescription: TStringField
      FieldName = 'ItemDescription'
      Size = 50
    end
    object quSaleInvoiceShippingDate: TDateTimeField
      FieldName = 'ShippingDate'
    end
    object quSaleInvoiceOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object quSaleInvoiceInvoiceDueDate: TDateTimeField
      FieldName = 'InvoiceDueDate'
    end
    object quSaleInvoiceDiscountDueDate: TDateTimeField
      FieldName = 'DiscountDueDate'
    end
    object quSaleInvoiceCustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 50
    end
    object quSaleInvoiceCustomerAddress: TStringField
      FieldName = 'CustomerAddress'
      Size = 80
    end
    object quSaleInvoiceCustomerCity: TStringField
      FieldName = 'CustomerCity'
      Size = 40
    end
    object quSaleInvoiceCustomerZip: TStringField
      FieldName = 'CustomerZip'
      FixedChar = True
      Size = 12
    end
    object quSaleInvoiceCustomerStateCode: TStringField
      FieldName = 'CustomerStateCode'
      FixedChar = True
      Size = 3
    end
    object quSaleInvoiceCustomerState: TStringField
      FieldName = 'CustomerState'
      Size = 50
    end
    object quSaleInvoiceShipToAddress: TStringField
      FieldName = 'ShipToAddress'
      Size = 100
    end
    object quSaleInvoiceDiscountValue: TBCDField
      FieldName = 'DiscountValue'
      ReadOnly = True
      Precision = 19
    end
    object quSaleInvoiceExtTotalSale: TBCDField
      FieldName = 'ExtTotalSale'
      ReadOnly = True
      Precision = 19
    end
    object quSaleInvoiceStoreName: TStringField
      FieldName = 'StoreName'
      Visible = False
      Size = 30
    end
    object quSaleInvoiceCategoryName: TStringField
      FieldName = 'CategoryName'
      Visible = False
      Size = 30
    end
    object quSaleInvoiceTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Visible = False
      Size = 50
    end
    object quSaleInvoiceTaxClass: TStringField
      FieldName = 'TaxClass'
      ReadOnly = True
      Size = 2
    end
    object quSaleInvoiceSerialNumber: TStringField
      FieldName = 'SerialNumber'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object quSaleInvoiceCommentLine: TStringField
      FieldName = 'CommentLine'
      Size = 255
    end
    object quSaleInvoiceFreight: TBCDField
      FieldName = 'Freight'
      Precision = 19
    end
    object quSaleInvoiceItemNumber: TStringField
      FieldName = 'ItemNumber'
      FixedChar = True
    end
    object quSaleInvoiceUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object quSaleInvoiceMiscItemFlag: TStringField
      FieldName = 'MiscItemFlag'
      ReadOnly = True
      Size = 1
    end
    object quSaleInvoiceMiscItemCode: TStringField
      FieldName = 'MiscItemCode'
      ReadOnly = True
      Size = 30
    end
    object quSaleInvoiceQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
    object quSaleInvoiceLineType: TStringField
      FieldName = 'LineType'
      ReadOnly = True
      Size = 1
    end
  end
  object quStoreList: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT'#13#10#9'IDStore,'#13#10#9'Name as Store'#13#10'FROM'#13#10#9'Store'#13#10'WHERE '#13#10#9'Hidden' +
      ' = 0'#13#10#9'AND'#13#10#9'Desativado= 0'
    Parameters = <>
    Left = 216
    Top = 84
    object quStoreListIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreListStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object quCategoryList: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT'#13#10#9'IDGroup,'#13#10#9'Name'#13#10'FROM'#13#10#9'TabGroup'#13#10'WHERE '#13#10#9'Hidden = 0'#13#10 +
      #9'AND'#13#10#9'Desativado= 0'
    Parameters = <>
    Left = 44
    Top = 148
    object quCategoryListIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quCategoryListName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object quTaxScheduleList: TADODataSet
    Connection = MRDBConnection
    CommandText = 
      'SELECT'#13#10#9'IDTaxCategory,'#13#10#9'TaxCategory'#13#10'FROM'#13#10#9'TaxCategory'#13#10'WHERE' +
      #13#10#9'Hidden = 0'#13#10#9'AND'#13#10#9'Desativado = 0'#13#10#9'AND'#13#10#9'IDTaxCategoryParent' +
      ' = 0'
    Parameters = <>
    Left = 128
    Top = 148
    object quTaxScheduleListIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quTaxScheduleListTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
  end
end
