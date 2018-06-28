(*
 Receipt to Declined Transactions from Mercury ( Credt and Debit )
*)

unit PrintReceiptDeclinedView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, siComp, siLangRT,
  PaiDeForms, PaidePrinter, ppDB, ppDBPipe, ppEndUsr, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, ppPrnabl, ppCtrls, ppBands, ppCache, ppStrtch,
  ppMemo, ppModule, raCodMod, ppSubRpt, ppParameter, ppRegion, jpeg, ppVar,
  PsRBExport_MasterControl, PowerADOQuery, DBCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, BuilderControls, myChkBox, Provider, DBClient,
  XiButton, EanRB, clsInfoCashSale;

const
  RECEIPT_TYPE_HOLD             = 1;
  RECEIPT_TYPE_INVOICE          = 2;
  RECEIPT_TYPE_TICKET           = 3;
  RECEIPT_TYPE_TAXISEMPTION     = 4;
  RECEIPT_TYPE_LAYAWAY_RECEIVE  = 5;
  RECEIPT_TYPE_DECLINED         = 6;  

type
  TPrintReceiptDeclined = class(TFrmParentPrint)
    quBarCode: TADOQuery;
    quBarCodeBarCode: TStringField;
    quPreSaleValue: TADOStoredProc;
    quPreSaleValueTaxIsent: TBooleanField;
    quPreSaleValueSubTotal: TFloatField;
    quPreSaleValueItemDiscount: TFloatField;
    quPreSaleValueTax: TFloatField;
    quPreSaleValueTaxPrc: TFloatField;
    quPreSaleValueDiscountPrc: TFloatField;
    quPreSaleValueTotalInvoice: TFloatField;
    quPreSaleValueSpecialPriceID: TIntegerField;
    quPreSaleValueSpecialPrice: TStringField;
    quPreSaleValuenOpenUser: TIntegerField;
    quPreSaleValueShowOpenUser: TIntegerField;
    quPreSaleInfo: TADOQuery;
    quPreSaleInfoIDPreSale: TIntegerField;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoPassportDate: TDateTimeField;
    quPreSaleInfoAirLine: TStringField;
    quPreSaleInfoCompanyName: TStringField;
    quPreSaleInfoCompanyCGC: TStringField;
    quPreSaleInfoDepositDate: TDateTimeField;
    quPreSaleInfoNote: TStringField;
    quPreSaleInfoInvoiceDate: TDateTimeField;
    quPreSaleInfoIDInvoice: TIntegerField;
    quPreSaleInfoPassport: TStringField;
    quPreSaleInfoTicket: TStringField;
    quPreSaleInfoMediaID: TIntegerField;
    quPreSaleItem: TADOStoredProc;
    quPreSaleItemModelID: TIntegerField;
    quPreSaleItemModel: TStringField;
    quPreSaleItemDescription: TStringField;
    quPreSaleItemSalePrice: TFloatField;
    quPreSaleItemDiscount: TFloatField;
    quPreSaleItemIDInventoryMov: TIntegerField;
    quPreSaleItemTotalItem: TFloatField;
    quPreSaleItemSalesPerson: TStringField;
    quPreSaleItemIDComission: TIntegerField;
    quPreSaleItemCostPrice: TFloatField;
    quPreSaleInfoCashReceived: TFloatField;
    quPreSaleInfoCashRegMovID: TIntegerField;
    quDescCashier: TADOQuery;
    quDescCashierSystemUser: TStringField;
    quPreSaleInfoPrinted: TBooleanField;
    quPreSaleItemIDUser: TIntegerField;
    quPreSaleItemExchangeInvoice: TIntegerField;
    quPreSaleInfoTaxIsent: TBooleanField;
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoAddress: TStringField;
    quSerial: TADOQuery;
    quSerialDocumentID: TIntegerField;
    quSerialSerialNumber: TStringField;
    quSerialInventoryMovID: TIntegerField;
    quPreSaleValueTaxIsemptValue: TFloatField;
    quPreSaleValueSubTotalTaxable: TFloatField;
    quPreSaleValueTaxIsemptItemDiscount: TFloatField;
    quPreSaleValueTotalDiscount: TCurrencyField;
    quPreSaleParc: TADOQuery;
    quPreSaleParcIDDocumentoTipo: TIntegerField;
    quPreSaleParcNumDocumento: TStringField;
    quPreSaleParcDataVencimento: TDateTimeField;
    quPreSaleParcValorNominal: TFloatField;
    quPreSaleParcMeioPag: TStringField;
    quPreSaleParcIDMeioPag: TIntegerField;
    quStore: TADOQuery;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quPreSaleInfoPrintNotes: TBooleanField;
    quPreSaleInfoMedia: TStringField;
    quPayments: TADOQuery;
    quPaymentsIDMeioPag: TIntegerField;
    quPaymentsMeioPag: TStringField;
    quPaymentsValorNominal: TFloatField;
    quPaymentsDataVencimento: TDateTimeField;
    quPaymentsIDQuitacaoMeioPrevisto: TIntegerField;
    quPaymentsIDLancamentoTipo: TIntegerField;
    quPaymentsIDDocumentoTipo: TIntegerField;
    quPaymentsIDPreSale: TIntegerField;
    quPaymentsCheckNumber: TStringField;
    quPaymentsIDBankCheck: TIntegerField;
    quPaymentsCustomerDocument: TStringField;
    quPaymentsCustomerName: TStringField;
    quPaymentsCustomerPhone: TStringField;
    quPaymentsHistorico: TMemoField;
    ppDesigner: TppDesigner;
    dsPreSaleInfo: TDataSource;
    ppPreSaleInfo: TppDBPipeline;
    dsPreSaleItem: TDataSource;
    ppPreSaleItem: TppDBPipeline;
    dsPayments: TDataSource;
    quPreSaleInfoCountryCod: TStringField;
    quPreSaleInfoCountry: TStringField;
    quPreSaleInfoStateCode: TStringField;
    quPreSaleInfoState: TStringField;
    quPreSaleInfoClientAddress: TStringField;
    quPreSaleInfoClientCity: TStringField;
    quPreSaleInfoClientNeighborhood: TStringField;
    quPreSaleInfoClientZip: TStringField;
    quPreSaleInfoClientPhone: TStringField;
    quPreSaleInfoClientCell: TStringField;
    quPreSaleInfoClientEmail: TStringField;
    quPreSaleInfoClientBirthDate: TDateTimeField;
    quPreSaleInfoClientEmployeeID: TStringField;
    quPreSaleInfoClientSocialSecurity: TStringField;
    quPreSaleInfoClientFederalID: TStringField;
    quPreSaleInfoClientSalesTax: TStringField;
    quPreSaleInfoClientDBA: TStringField;
    quPreSaleItemTax: TBCDField;
    quPreSaleItemUnitSalePrice: TCurrencyField;
    dsPreSaleValue: TDataSource;
    ppPreSaleValue: TppDBPipeline;
    ppStore: TppDBPipeline;
    dsStore: TDataSource;
    quPreSaleValueSubTotalDiscount: TCurrencyField;
    quPreSaleItemTaxValue: TFloatField;
    ppSerial: TppDBPipeline;
    dsSerial: TDataSource;
    quPreSaleItemCodSize: TStringField;
    quPreSaleItemSizeName: TStringField;
    quPreSaleItemCodColor: TStringField;
    quPreSaleItemColor: TStringField;
    quPreSaleItemSuggRetail: TBCDField;
    quPaymentsPaymentPlace: TIntegerField;
    quPreSaleValueAditionalExpenses: TBCDField;
    quPreSaleInfoIDFormOfPayment: TIntegerField;
    quPaymentsPaymentPlaceDesc: TStringField;
    quInvoiceCosts: TADODataSet;
    quInvoiceCostsCostType: TStringField;
    quInvoiceCostsIDInvoiceCost: TIntegerField;
    quInvoiceCostsIDCostType: TIntegerField;
    quInvoiceCostsAmount: TBCDField;
    dsInvoiceCosts: TDataSource;
    ppInvoiceCosts: TppDBPipeline;
    quDeliveryInfo: TADOQuery;
    quDeliveryInfoIDPreSale: TIntegerField;
    quDeliveryInfoDeliverTypeID: TIntegerField;
    quDeliveryInfoDeliverDate: TDateTimeField;
    quDeliveryInfoDeliverAddress: TStringField;
    quDeliveryInfoDeliverOBS: TStringField;
    quDeliveryInfoDeliverConfirmation: TBooleanField;
    quDeliveryInfoIDFormOfPayment: TIntegerField;
    quDeliveryInfoDeliverType: TStringField;
    ppDelivery: TppDBPipeline;
    dsDeliveryIndo: TDataSource;
    quPreSaleItemIsDelivered: TBooleanField;
    quPreSaleInfoSaleCode: TStringField;
    quPreSaleInfoInvoiceCode: TStringField;
    quPreSaleItemSaleCode: TStringField;
    quPreSaleItemInvoiceCode: TStringField;
    quDeliveryInfoSaleCode: TStringField;
    quDeliveryInfoInvoiceCode: TStringField;
    quPreSaleInfoFullName: TStringField;
    quPreSaleItemTaxes: TADODataSet;
    dsItemTax: TDataSource;
    ppItemTaxes: TppDBPipeline;
    quPreSaleItemTaxesTaxCategory: TStringField;
    quPreSaleItemTaxesOperationType: TIntegerField;
    quPreSaleItemTaxesSaleTaxType: TIntegerField;
    quPreSaleItemTaxesTax: TBCDField;
    quPreSaleItemTaxesIDMov: TIntegerField;
    PsRBExportMasterControl: TPsRBExportMasterControl;
    quFeatures: TPowerADOQuery;
    quFeaturesIDInvFeatures: TIntegerField;
    quFeaturesFeature: TStringField;
    dsFeatures: TDataSource;
    ppFeatures: TppDBPipeline;
    quTechFeature: TADOQuery;
    quTechFeatureIDInvTechFeatures: TIntegerField;
    quTechFeatureTechFeature: TStringField;
    dsTechFeature: TDataSource;
    ppTechFeatures: TppDBPipeline;
    quPreSaleItemIDModel: TIntegerField;
    quPreSaleItemQty: TFloatField;
    quPreSaleInfoClientPhoneAreaCode: TStringField;
    quPreSaleInfoClientCellAreaCode: TStringField;
    quPreSaleInfoClientFax: TStringField;
    quPreSaleInfoClientContacts: TStringField;
    quPreSaleInfoClientContact: TStringField;
    quPaymentsPayType: TIntegerField;
    quPreSaleInfoLayaway: TBooleanField;
    quPreSaleInfoChange: TFloatField;
    quPaymentsChange: TCurrencyField;
    quPaymentsCashReceived: TBCDField;
    ppPayments: TppDBPipeline;
    quPaymentsAuthorization: TStringField;
    quPaymentsCardNumber: TStringField;
    quPaymentsNumMeioQuitPreVisto: TStringField;
    quModelReceipt: TADODataSet;
    quCategoryReceipt: TADODataSet;
    quModelReceiptIDModel: TIntegerField;
    quModelReceiptReceiptText: TStringField;
    quPreSaleItemModelReceipt: TStringField;
    quCategoryReceiptIDModel: TIntegerField;
    quCategoryReceiptReceiptText: TStringField;
    quPreSaleItemCategoryReceipt: TStringField;
    quPaymentsDrawerKickOnPay: TBooleanField;
    quPreSaleItemPromo: TBooleanField;
    quPreSaleItemSellingPrice: TBCDField;
    quBonusBucks: TADOQuery;
    dsBonusBucks: TDataSource;
    quBonusBucksBonusCupon: TStringField;
    quBonusBucksDiscountValue: TBCDField;
    ppBonusBucks: TppDBPipeline;
    quBonusBucksValidFromDate: TDateTimeField;
    quBonusBucksExpirationDate: TDateTimeField;
    tmrPrint: TTimer;
    pnlPayment: TPanel;
    pnlPrintControl: TPanel;
    lblInvoice: TLabel;
    lblInvoiceTotal: TLabel;
    dbValue: TDBText;
    dbTotalValue: TDBText;
    lblChange: TLabel;
    lblChangeValue: TLabel;
    grdPayments: TcxGrid;
    grdPaymentsDBTV: TcxGridDBTableView;
    grdPaymentsDBTVMeioPag: TcxGridDBColumn;
    grdPaymentsDBTVDataVencimento: TcxGridDBColumn;
    grdPaymentsDBTVValorNominal: TcxGridDBColumn;
    grdPaymentsLVL: TcxGridLevel;
    lblPrint: TLabel;
    pnlPrinter: TPanel;
    AniPrint: TAnimate;
    btOk: TButton;
    pnlGiftBalance: TPanel;
    mmGiftBalance: TMemo;
    lblGift: TLabel;
    quGiftBalance: TADOQuery;
    quGiftBalanceIDAccountCard: TIntegerField;
    quGiftBalanceCardNumber: TStringField;
    quGiftBalanceAmount: TBCDField;
    quShippingInfo: TADODataSet;
    dsShippingInfo: TDataSource;
    ppShippingInfo: TppDBPipeline;
    quShippingInfoIDPreSale: TIntegerField;
    quShippingInfoIDInvoiceShipping: TIntegerField;
    quShippingInfoShipDate: TDateTimeField;
    quShippingInfoTracking: TStringField;
    quShippingInfoIDDeliverType: TIntegerField;
    quShippingInfoAddressName: TStringField;
    quShippingInfoAddress: TStringField;
    quShippingInfoCity: TStringField;
    quShippingInfoZIP: TStringField;
    quShippingInfoIDEstado: TStringField;
    quShippingInfoIDPais: TIntegerField;
    quShippingInfoState: TStringField;
    quShippingInfoCountryCod: TStringField;
    quShippingInfoCountry: TStringField;
    quPreSaleItemDiscountPercent: TFloatField;
    quPreSaleValueInvoiceDiscount: TBCDField;
    quPreSaleItemSerialNumber: TBooleanField;
    quPreSaleItemAutoServiceNum: TIntegerField;
    quPreSaleItemCupomFiscal: TStringField;
    quPreSaleItemManufacturer: TStringField;
    quPreSaleItemUnit: TStringField;
    quPreSaleItemDepartment: TStringField;
    quStoreStore: TStringField;
    quStoreAddress: TStringField;
    quStoreCity: TStringField;
    quStoreZip: TStringField;
    quStorePhone: TStringField;
    quStoreFax: TStringField;
    quStoreContact: TStringField;
    quStoreTicketHeader: TMemoField;
    quStoreTicketLayawayFooter: TMemoField;
    quStoreTicketTaxIsemptFooter: TMemoField;
    quStoreTicketFooter: TMemoField;
    quStoreTicketDetail: TMemoField;
    quStoreTicketTotals: TMemoField;
    quStorePrintTicketHeader: TBooleanField;
    quStorePrintLayawayFooter: TBooleanField;
    quStorePrintTaxInsemptFooter: TBooleanField;
    quStorePrintTicketFooter: TBooleanField;
    quStoreEmail: TStringField;
    quStoreWebPage: TStringField;
    quStoreStateCod: TStringField;
    quStoreState: TStringField;
    quStoreEmpresa: TStringField;
    quStoreRazaoEMP: TStringField;
    quStoreCNPJEMP: TStringField;
    quStoreIEEMP: TStringField;
    quStoreIMEMP: TStringField;
    quStoreEndEMP: TStringField;
    quStoreBairroEMP: TStringField;
    quStoreCidadeEMP: TStringField;
    quStoreCEPEMP: TStringField;
    quStoreEstadoEMP: TStringField;
    quStoreLogoEMP: TBlobField;
    quPreSaleInfoIDStore: TIntegerField;
    quPreSaleInfoTaxPerc: TBCDField;
    quPreSaleInfoIDCFOP: TIntegerField;
    quPreSaleInfoCFOP: TStringField;
    quPreSaleInfoNaturezaOperacao: TStringField;
    quPreSaleInfoPessoaTax: TStringField;
    quPreSaleInfoFreightType: TIntegerField;
    quPreSaleInfoCarrier: TStringField;
    quPreSaleInfoCarrierAddress: TStringField;
    quPreSaleInfoCarrierCity: TStringField;
    quPreSaleInfoCarrierNeighborhood: TStringField;
    quPreSaleInfoCarrierZip: TStringField;
    quPreSaleInfoCarrierFederalID: TStringField;
    quPreSaleInfoCarrierDBA: TStringField;
    quPreSaleInfoCarrierEmployeeID: TStringField;
    quPreSaleInfoAgent: TStringField;
    quPreSaleInfoAgentPhone: TStringField;
    quPreSaleInfoAgentCell: TStringField;
    quPreSaleInfoAgentEmail: TStringField;
    quPreSaleItemSerialNumbers: TStringField;
    quPreSaleInfoClientIdentidade: TStringField;
    quPreSaleInfoClientOrgaoEmissor: TStringField;
    quPreSaleInfoClientDataExpedicao: TDateTimeField;
    quPaymentsIDLancamento: TIntegerField;
    quPreSaleInfoClientOBS: TStringField;
    cdsPreSaleItem: TClientDataSet;
    dspPreSaleItem: TDataSetProvider;
    cdsPreSaleItemModelID: TIntegerField;
    cdsPreSaleItemModel: TStringField;
    cdsPreSaleItemDescription: TStringField;
    cdsPreSaleItemSalePrice: TFloatField;
    cdsPreSaleItemDiscount: TFloatField;
    cdsPreSaleItemIDInventoryMov: TIntegerField;
    cdsPreSaleItemTotalItem: TFloatField;
    cdsPreSaleItemSalesPerson: TStringField;
    cdsPreSaleItemIDComission: TIntegerField;
    cdsPreSaleItemCostPrice: TFloatField;
    cdsPreSaleItemIDUser: TIntegerField;
    cdsPreSaleItemExchangeInvoice: TIntegerField;
    cdsPreSaleItemTax: TBCDField;
    cdsPreSaleItemUnitSalePrice: TCurrencyField;
    cdsPreSaleItemTaxValue: TFloatField;
    cdsPreSaleItemCodSize: TStringField;
    cdsPreSaleItemSizeName: TStringField;
    cdsPreSaleItemCodColor: TStringField;
    cdsPreSaleItemColor: TStringField;
    cdsPreSaleItemSuggRetail: TBCDField;
    cdsPreSaleItemIsDelivered: TBooleanField;
    cdsPreSaleItemSaleCode: TStringField;
    cdsPreSaleItemInvoiceCode: TStringField;
    cdsPreSaleItemIDModel: TIntegerField;
    cdsPreSaleItemQty: TFloatField;
    cdsPreSaleItemModelReceipt: TStringField;
    cdsPreSaleItemCategoryReceipt: TStringField;
    cdsPreSaleItemPromo: TBooleanField;
    cdsPreSaleItemSellingPrice: TBCDField;
    cdsPreSaleItemDiscountPercent: TFloatField;
    cdsPreSaleItemSerialNumber: TBooleanField;
    cdsPreSaleItemAutoServiceNum: TIntegerField;
    cdsPreSaleItemCupomFiscal: TStringField;
    cdsPreSaleItemManufacturer: TStringField;
    cdsPreSaleItemUnit: TStringField;
    cdsPreSaleItemDepartment: TStringField;
    cdsPreSaleItemSerialNumbers: TStringField;
    quPaymentCondition: TADODataSet;
    quPaymentConditionIDMeioPag: TIntegerField;
    quPaymentConditionMeioPag: TStringField;
    quPaymentConditionPayType: TIntegerField;
    quPaymentConditionDrawerKickOnPay: TBooleanField;
    quPaymentConditionAmount: TBCDField;
    quPaymentConditionOBS: TStringField;
    quPaymentConditionEstimetedDate: TDateTimeField;
    dsPaymentCondition: TDataSource;
    ppPaymentCondition: TppDBPipeline;
    quPaymentsNumDesdobramento: TStringField;
    quPaymentsTotalQuitado: TBCDField;
    quPreSaleValueValorExtenso: TStringField;
    btnReprint: TXiButton;
    quPaymentsLayaway: TBooleanField;
    quPaymentsRemains: TCurrencyField;
    ppReport: TppReport;
    ppParameterList1: TppParameterList;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleValueTotalSaved: TCurrencyField;
    ppReportDeclined: TppReport;
    ppParameterList2: TppParameterList;
    ppTitleBand3: TppTitleBand;
    ppRegion19: TppRegion;
    ppLabel28: TppLabel;
    ppRegion7: TppRegion;
    ppLabel5: TppLabel;
    ppDBText18: TppDBText;
    ppLabel3: TppLabel;
    ppDBText17: TppDBText;
    ppDBText19: TppDBText;
    ppDBText21: TppDBText;
    ppLabel7: TppLabel;
    ppLabel13: TppLabel;
    ppLabel24: TppLabel;
    ppRegion3: TppRegion;
    ppLabel4: TppLabel;
    ppDBText6: TppDBText;
    ppRegion8: TppRegion;
    ppLabel16: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLine1: TppLine;
    ppLogoImage: TppImage;
    ppDetailBand1: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand2: TppDetailBand;
    ppRegion1: TppRegion;
    ppVariable4: TppVariable;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppRegion2: TppRegion;
    ppDBText1: TppDBText;
    ppLabel6: TppLabel;
    ppDBText5: TppDBText;
    ppRegion11: TppRegion;
    ppDBMemo1: TppDBMemo;
    ppRegion14: TppRegion;
    ppVariable3: TppVariable;
    ppLabel18: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppRegion4: TppRegion;
    ppLabel8: TppLabel;
    ppDBText2: TppDBText;
    ppLabel27: TppLabel;
    ppLabel30: TppLabel;
    ppDBText14: TppDBText;
    ppDBText29: TppDBText;
    ppRegion5: TppRegion;
    ppLabel9: TppLabel;
    ppDBText3: TppDBText;
    ppRegion6: TppRegion;
    ppDBText8: TppDBText;
    ppLine2: TppLine;
    ppLabel10: TppLabel;
    ppDBText4: TppDBText;
    ppLabel11: TppLabel;
    ppRegion20: TppRegion;
    raCodeModule1: TraCodeModule;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppDetailBand3: TppDetailBand;
    ppRegion10: TppRegion;
    ppDBText23: TppDBText;
    ppLabel14: TppLabel;
    ppLabel31: TppLabel;
    ppRegion9: TppRegion;
    ppDBText20: TppDBText;
    ppVariable1: TppVariable;
    ppDBText22: TppDBText;
    ppRegion15: TppRegion;
    ppDBText13: TppDBText;
    ppLabel19: TppLabel;
    ppDBText7: TppDBText;
    ppSummaryBand4: TppSummaryBand;
    ppRegion13: TppRegion;
    RBEan1: TRBEan;
    ppDBMemo3: TppDBMemo;
    ppRegion12: TppRegion;
    ppMemo5: TppMemo;
    raCodeModule3: TraCodeModule;
    ppSubReport4: TppSubReport;
    ppChildReport4: TppChildReport;
    ppTitleBand4: TppTitleBand;
    ppDetailBand5: TppDetailBand;
    ppRegion16: TppRegion;
    ppLabel25: TppLabel;
    ppDBText24: TppDBText;
    ppLabel32: TppLabel;
    ppRegion17: TppRegion;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText30: TppDBText;
    ppRegion18: TppRegion;
    ppDBText27: TppDBText;
    ppLabel26: TppLabel;
    ppDBText28: TppDBText;
    ppSummaryBand2: TppSummaryBand;
    ppRegion22: TppRegion;
    RBEan3: TRBEan;
    ppRegion21: TppRegion;
    ppMemo1: TppMemo;
    ppRegion23: TppRegion;
    ppLabel29: TppLabel;
    ppDBMemo4: TppDBMemo;
    raCodeModule5: TraCodeModule;
    ppSummaryBand3: TppSummaryBand;
    ppDBMemo2: TppDBMemo;
    ppLabel1: TppLabel;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand4: TppDetailBand;
    ppImage2: TppImage;
    RBEan2: TRBEan;
    ppLabel15: TppLabel;
    ppLabel12: TppLabel;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppLabel22: TppLabel;
    ppDBText15: TppDBText;
    ppLabel17: TppLabel;
    ppDBText16: TppDBText;
    ppLabel23: TppLabel;
    ppImage1: TppImage;
    ppSummaryBand5: TppSummaryBand;
    raCodeModule4: TraCodeModule;
    raCodeModule2: TraCodeModule;
    ppTitleBand5: TppTitleBand;
    ppRegion25: TppRegion;
    ppDBText32: TppDBText;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    ppLabel36: TppLabel;
    ppImage3: TppImage;
    ppDetailBand6: TppDetailBand;
    ppSummaryBand9: TppSummaryBand;
    raCodeModule10: TraCodeModule;
    quPaymentsCodSystemUser: TStringField;
    virtualSelectDeclined: TADOQuery;
    ppVirtualSelectDeclined: TppDBPipeline;
    dataSourceVirtualSelect: TDataSource;
    labelEntryNethod: TppLabel;
    entryMethod: TppDBText;
    ppLabelDate: TppLabel;
    ppDbDateTime: TppDBText;
    ppLabel2: TppLabel;
    ppDBText31: TppDBText;
    ppLabel33: TppLabel;
    ppDBAmount: TppDBText;
    ppLabel37: TppLabel;
    ppDBTotal: TppDBText;
    ppLabelMessage: TppLabel;
    ppDBMemo5: TppDBMemo;
    ppDBMemo6: TppDBMemo;
    ppDBMemo7: TppDBMemo;
    ppDBMemo8: TppDBMemo;
    virtualSelectDeclinedMerchantID: TStringField;
    virtualSelectDeclinedLastDigit: TStringField;
    virtualSelectDeclinedCardType: TStringField;
    virtualSelectDeclinedInvoice: TStringField;
    virtualSelectDeclinedAmount: TStringField;
    virtualSelectDeclinedSaleDateTime: TStringField;
    virtualSelectDeclinedEntryMethod: TStringField;
    virtualSelectDeclinedNumMeioQuitPrevisto: TStringField;
    virtualSelectDeclinedcalc: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quPreSaleValueCalcFields(DataSet: TDataSet);
    procedure quPreSaleItemCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quPaymentsCalcFields(DataSet: TDataSet);
    procedure quPreSaleItemAfterOpen(DataSet: TDataSet);
    procedure quPreSaleItemAfterClose(DataSet: TDataSet);
    procedure tmrPrintTimer(Sender: TObject);
    procedure quPaymentsAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure btnReprintClick(Sender: TObject);
    procedure virtualSelectDeclinedCalcFields(DataSet: TDataSet);
  private
    // Antonio M F Souza June 29, 2012
    reprint: boolean;

    // Antonio M F Souza June 21, 2012: Internal reference to InfoCashSale
    objInfocashSale: InfoCashSale;

    //Translation
    sEndereco,
    sItems,
    sTelefone,
    sNoTaxAble,
    sTaxAble,
    sTax,
    sSubTotal,
    sTotal,
    sDiscount,
    sHold,
    sTaxExpHeadr,
    sIInvNum,
    sIInvDate,
    sICustomer,
    sIPassPort,
    sIPassPrtNum,
    sITicketNum,
    sIAirLine,
    sIArrivalNum,
    sIBusName,
    sILicencNum,
    sIAddress,
    sRecImpresso,
    sClickOK,
    sPayStore,
    sPayOuter,
    sPayOther,
    sBonusCode,
    sBonusValue,
    sBonusDate,
    sMsgBonus,
    sBonusGynbo1,
    sBonusGynbo2,
    sBonusGynbo3: String;
    MyIDPreSale, MyIDInvoice    : Integer;
    MyTotCash      : Currency;
    MyCashReceived : Currency;
    MyTotRefund    : Currency;
    MyChange       : Currency;
    ActualTime     : TDateTime;
    FPaymentDrawKick : Boolean;
    FChangeList    : TStringList;

    //Antonio M F Souza 11.02.2010 : save layaway payments to avoid fail in sum.
    FLayawayPayments: TStringList;

    // Max e Maic
    FPrintFooter, FHeightChanged: Boolean;
    FCopies, FReceiptType: Integer;
    FChangeValue: Double;

    //Antonio M F Souza 10.29.2010 : save total items to calculate remains.
    FSumLayawayPaid: double;
    FTotalInvoice: double;

    //Antonio M F Souza 10.29.2010 - get total to invoice
    function getTotalInvoice(AIdPreSale: integer): double;

    procedure OpenQueries(var ReceiptType: Integer);
    //New Function

    procedure LoadReport(sReport : String);
    procedure LoadLogoImage;
    // Alex 10/01/2015
    function BuildExtraInformationText( originalText:String ): String;

  public
    function DesignReport:Boolean;
    procedure Start(IDPreSale : Integer; ReceiptType: Integer; arg_sqlDeclined: String = '');
    procedure StartShipping(IDPreSale, ReceiptType, NumCopy: Integer;
       ReportPath, Printer : String; Preview : Boolean; AChangeValue: Double = 0);
  end;

implementation

uses uDM, XBase, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst, Variants,
     uStringFunctions, ppTypes, Math, uNumericFunctions, raIDE,
     ppCTDsgn, ppChrt, PsRBRoutines, StrUtils, ConvUtils, uInvoiceInfo;

{$R *.DFM}

function TPrintReceiptDeclined.DesignReport:Boolean;
begin
  Result := True;
  try

    { Alex - 7/14/2011 }
    ppReport.Template.FileName := DM.fPrintReceipt.ReportPath;
    ppReport.Template.LoadFromFile;

    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

procedure TPrintReceiptDeclined.LoadReport(sReport : String);
var
  sMessage: String;
  saveDefaultTemplate: String;
begin

  if sReport <> '[SYSTEM]' then begin
    // Antonio M F Souza 10.03.2011 - begin
    saveDefaultTemplate := ppReportDeclined.Template.FileName;
    ppReport.Template.FileName := sReport;
 end;

 // Antonio M F Souza 10.03.2011 - end
 if FileExists(sReport) then
 begin
    // Antonio, August 13, 2013
    ppReport.Reset;

    ppReport.Template.FileName := sReport;
    ppReport.Template.LoadFromFile;
    ppReport.AllowPrintToArchive := True;
    ppReport.AllowPrintToFile    := True;
 end
  //Antonio M F Souza 10.20.2011 - begin
 else begin
    sMessage := 'Receipt specified in client parameters is not present. Default receipt will be used instead';
    application.MessageBox(Pchar(sMessage), 'File not found', mb_OK + mb_IconStop);
    ppReport.Template.Filename := saveDefaultTemplate;
 end;
  //Antonio M F Souza 10.20.2011 - end

 if DM.fPrintReceipt.InvoiceReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.InvoiceReportPrinter;

 if DM.fPrintReceipt.Preview then
    ppReport.DeviceType := dtScreen
  else
    begin
    ppReport.DeviceType      := dtPrinter;
    ppReport.ShowPrintDialog := False;
  end;

  LoadLogoImage;
end;

procedure TPrintReceiptDeclined.StartShipping(IDPreSale, ReceiptType, NumCopy: Integer;
  ReportPath, Printer : String; Preview : Boolean; AChangeValue: Double);
var
  PaperType : Integer;
  ReportTemp : String;
  USBPrinter,
  PreviewTemp : Boolean;
  PrinterTemp : String;
  NumCopyTemp : Integer;
begin

  DM.FTraceControl.TraceIn('TPrintReceiptDeclined.StartShipping');

  FChangeValue := AChangeValue;
  try
    FReceiptType   := ReceiptType;
    MyIDPreSale    := IDPreSale;
    Self.FormStyle := fsNormal;

    FCopies := 1;

    PaperType   := DM.fPrintReceipt.PaperType;
    ReportTemp  := DM.fPrintReceipt.ReportPath;
    USBPrinter  := DM.fPrintReceipt.UseUSBPrinter;
    PrinterTemp := DM.fPrintReceipt.InvoiceReportPrinter;
    PreviewTemp := DM.fPrintReceipt.Preview;
    NumCopyTemp := DM.fPrintReceipt.NumOfCopies;

    DM.fPrintReceipt.PaperType            := PAPER_TYPE_4A;
    DM.fPrintReceipt.ReportPath           := ReportPath;
    DM.fPrintReceipt.UseUSBPrinter        := False;
    DM.fPrintReceipt.InvoiceReportPrinter := Printer;
    DM.fPrintReceipt.Preview              := Preview;
    DM.fPrintReceipt.NumOfCopies          := NumCopy;

    try
      tmrPrint.Enabled := True;
      ShowModal;
    finally
      DM.fPrintReceipt.PaperType            := PaperType;
      DM.fPrintReceipt.ReportPath           := ReportTemp;
      DM.fPrintReceipt.UseUSBPrinter        := USBPrinter;
      DM.fPrintReceipt.InvoiceReportPrinter := PrinterTemp;
      DM.fPrintReceipt.Preview              := PreviewTemp;
      DM.fPrintReceipt.NumOfCopies          := NumCopyTemp;
      end;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPrintReceiptDeclined');
  end;


  DM.FTraceControl.TraceOut;
end;


procedure TPrintReceiptDeclined.Start(IDPreSale : Integer; ReceiptType: Integer; arg_sqlDeclined: String = '');
var
  i, iPaymentCopies: Integer;
  sProcessor, sMercantNum, sCardID: String;
begin

  if ( virtualSelectDeclined.Active ) then begin
     virtualSelectDeclined.Close;
  end;

  virtualSelectDeclined.SQL.Text := arg_sqlDeclined;
  virtualSelectDeclined.Open;

  FHeightChanged := False;

  if DM.fPrintReceipt.PrintReceipt then
  begin
    DM.FTraceControl.TraceIn('TPrintReceiptDeclined.Start');

    try
      FReceiptType := ReceiptType;

      //Antonio M F Souza 03.18.2011
      case FReceiptType of
           RECEIPT_TYPE_DECLINED: begin
              //lblInvoice.Visible := false;
              //dbValue.Visible    := false;
              //lblInvoiceTotal.Caption := 'Delivery Total #:';
              //lblchange.Visible := false;
              //lblChangeValue.Visible := lblChange.Visible;
              //grdPayments.Visible := false;
           end;
      end;

      MyIDPreSale  := IDPreSale;
      FPrintFooter := False;

      if DM.fPrintReceipt.PaperType = PAPER_TYPE_4A then
        Self.FormStyle := fsNormal
      else
        Self.FormStyle := fsStayOnTop;

      // Number of Copies by Payment registered as PCCharge payment
      FCopies := 1;

      FPaymentDrawKick := False;
      (*
      with quPayments do
      begin
        if Active then
          Close;
        Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
        Open;

        //Antonio M F Souza 03.18.2011
        if ( not quPayments.FieldByName('IdPreSale').IsNull ) then
           FTotalInvoice := getTotalInvoice(quPayments.fieldByName('IdPreSale').Value);

        First;
        while not EOF do
        begin

         if (not FPrintFooter) then
           FPrintFooter := quPaymentsPayType.AsInteger in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_DEBIT, PAYMENT_TYPE_STOREACCOUNT];

         Next;
        end;
      end;
      *)
      tmrPrint.Enabled := True;
      ShowModal;
    except
      on E: Exception do
        DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPrintReceiptDeclined');
    end;

    DM.FTraceControl.TraceOut;
  end;
end;

procedure TPrintReceiptDeclined.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with quPreSaleInfo do
    if Active then
      Close;

  with cdsPreSaleItem do
    if Active then
      Close;

  with quStore do
    if Active then
      Close;

  with quPayments do
    if Active then
      Close;

  with quPaymentCondition do
    if Active then
      Close;

  with quInvoiceCosts do
    if Active then
      Close;

  with quDeliveryInfo do
    if Active then
      Close;

  with quBonusBucks do
    if Active then
      Close;

  with quShippingInfo do
    if Active then
      Close;

  Action := caFree;
end;

procedure TPrintReceiptDeclined.quPreSaleValueCalcFields(DataSet: TDataSet);
var
  // Antonio M F Souza, December 13 2012
  tempInvoiceTaxStr: String;
  tempInvoiceTax: Extended;
  tempInvoiceSubTotal: Extended;
  tempInvoiceDiscount: Extended;
  tempInvoiceItemDiscount: Extended;
  tempInvoiceTaxIsemptItemDiscount: Extended;
  tempInvoiceTaxIsemptValue: Extended;
  tempInvoiceAddExpens: Extended;
  tempInvoiceTotal: Extended;
  tempInvoiceTotalStr: String;
  tempInvoiceTotalDiscount: Extended;
  tempInvoiceTotalSaved: Extended;
  tempInvoiceNewSubtotal: Extended;
  tempInvoiceSubtotalTaxable: Extended;

  // Antonio M F Souza October 25, 2012 - to fix rounding issues
  invoiceInfo: TInvoiceInfo;
begin
  try
    try
      invoiceInfo := TInvoiceInfo.Create(dm.ADODBConnect);

      invoiceInfo.InfoCashSale := self.objInfocashSale;
      invoiceInfo.treatInvoice( (quPreSaleValueSubTotal.Value < 0), quPresaleValue);

      // Antonio 2014 Jun 18: Getting results
      qupresaleValueSubtotal.Value := invoiceInfo.Subtotal;
      quPreSaleValueItemDiscount.value := invoiceInfo.ItemsDiscount;
      quPreSaleValueInvoiceDiscount.Value := invoiceInfo.InvoiceDiscount;
      quPreSaleValueTotalInvoice.Value := invoiceInfo.TotalInvoice;
      quPreSaleValueTotalDiscount.Value := invoiceInfo.TotalDiscount;
      quPreSaleValueTotalSaved.Value := invoiceInfo.TotalDiscount;
      quPreSaleValueSubTotalTaxable.Value := invoiceInfo.SubTotalTaxable;
    except
      on e: Exception do begin
        raise Exception.Create(format('error to get totals in invoice: %s', [e.Message]));
      end;
    end;
  finally
    freeAndNil(invoiceInfo);
  end;


end;

procedure TPrintReceiptDeclined.quPreSaleItemCalcFields(DataSet: TDataSet);
var
  tempTotalItem: extended;
  tempTotalItemStr: String;
begin
  // total item
  //Antonio June 12, 2013
  if ( quPresaleItemQty.value < 0 ) then begin
     quPresaleItemDiscount.Value := roundLikeDatabase(quPresaleItemDiscount.Value, 2);
     quPreSaleItemDiscount.Value := {(-1) *} qupresaleItemDiscount.Value;
  end;

  quPreSaleItemTotalItem.AsFloat := (quPreSaleItemQty.AsFloat * quPreSaleItemSalePrice.AsFloat) - quPreSaleItemDiscount.AsFloat;

  // Antonio M F Souza, December 19 2012
  tempTotalItem := roundLikeDatabase(quPreSaleItemTotalItem.Value, 2);
  quPreSaleItemTotalItem.Value := tempTotalItem;

  //Unit price
  quPreSaleItemUnitSalePrice.AsCurrency := quPreSaleItemSalePrice.AsFloat - (quPreSaleItemDiscount.AsFloat / quPreSaleItemQty.AsFloat);
  //Tax Value
  quPreSaleItemTaxValue.AsFloat := (((quPreSaleItemSalePrice.AsFloat-quPreSaleItemDiscount.AsFloat) / quPreSaleItemQty.AsFloat) * quPreSaleItemTax.AsFloat)/100;
  //Model para Features
  quPreSaleItemIDModel.AsInteger := quPreSaleItemModelID.AsInteger;

  //Discount Percent
  if (quPreSaleItemSalePrice.AsCurrency <> 0 ) and (quPreSaleItemDiscount.AsCurrency > 0) then
    quPreSaleItemDiscountPercent.AsFloat := (quPreSaleItemDiscount.AsCurrency/quPreSaleItemSalePrice.AsCurrency)* 100;

end;

procedure TPrintReceiptDeclined.FormShow(Sender: TObject);
begin
  AniPrint.Active := True;
  btOk.Visible := False;
end;

procedure TPrintReceiptDeclined.btOkClick(Sender: TObject);
begin
  Close;
end;


procedure TPrintReceiptDeclined.FormCreate(Sender: TObject);
begin
  inherited;

  FChangeList := TStringList.Create;
  FLayawayPayments := TStringList.Create;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sEndereco      := ' Address:';
      sTelefone      := 'Phone:';
      sNoTaxAble     := '  Non taxable:';
      sTaxAble       := '      Taxable:';
      sTax           := '          Tax:';
      sSubTotal      := '     SubTotal:';
      sTotal         := '        Total:';
      sDiscount      := '     Discount:';
      sHold          := 'HOLD';
      sItems         := '---------------- Items -----------------';
      sTaxExpHeadr   := '======= T A X   E X E M P T I O N ======';
      sIInvNum       := 'Invoice #     : ';
      sIInvDate      := 'Invoice Date  : ';
      sICustomer     := 'Customer      : ';
      sIPassPort     := 'Passport #    : ';
      sIPassPrtNum   := 'Passport Date : ';
      sITicketNum    := 'Ticket #      : ';
      sIAirLine      := 'AirLine       : ';
      sIArrivalNum   := 'Arrival Number: ';
      sIBusName      := 'Business Name : ';
      sILicencNum    := 'Licence #     : ';
      sIAddress      := 'Address       : ';
      sRecImpresso   := 'Receipt Printed';
      sClickOK       := 'Click OK to continue';
      sPayStore      := 'Store';
      sPayOuter      := 'Outer';
      sPayOther      := 'Another';
      sBonusCode     := 'Bonus :';
      sBonusValue    := 'Value :';
      sBonusDate     := 'Valid :';
      sMsgBonus      := '$$$$$$$ You got bonus $$$$$$$';
      sBonusGynbo1   := 'Access the website www.gynbo.com to';
      sBonusGynbo2   := 'collect your bonus using the bonus code';
      sBonusGynbo3   := 'or your e-mail :';

      lblInvoice.Caption                    := 'Invoice #:';
      lblInvoiceTotal.Caption               := 'Invoice Total:';
      lblChange.Caption                     := 'Change';
      grdPaymentsDBTVMeioPag.Caption        := 'Payment';
      grdPaymentsDBTVDataVencimento.Caption := 'Date';
      grdPaymentsDBTVValorNominal.Caption   := 'Amount';
      ppReport.Language := lgEnglish;
    end;

    LANG_PORTUGUESE :
    begin
      sEndereco      := ' Endereço:';
      sTelefone      := ' Telefone:';
      sNoTaxAble     := 'Não Tributável:';
      sTaxAble       := '    Tributável:';
      sTax           := '          Taxa:';
      sSubTotal      := '      SubTotal:';
      sTotal         := '         Total:';
      sDiscount      := '      Desconto:';
      sHold          := 'PEND';
      sItems         := '---------------- Itens -----------------';
      sTaxExpHeadr   := '=== I S E N Ç Ã O    D E    T A X A ====';
      sIInvNum       := 'N. da Nota    : ';
      sIInvDate      := 'Data da Nota  : ';
      sICustomer     := 'Cliente       : ';
      sIPassPort     := 'N. Passaporte : ';
      sIPassPrtNum   := 'Data Passporte: ';
      sITicketNum    := 'N. do Bilhete : ';
      sIAirLine      := 'Linha Aérea   : ';
      sIArrivalNum   := 'N. da Chegada : ';
      sIBusName      := 'Empresa       : ';
      sILicencNum    := 'N. Taxa ID    : ';
      sIAddress      := 'Endereço      : ';
      sRecImpresso   := 'Recibo Impresso';
      sClickOK       := 'Clique OK para continuar';
      sPayStore      := 'Loja';
      sPayOuter      := 'Contra-Entrega';
      sPayOther      := 'Outros';
      sBonusCode     := 'Bónus : ';
      sBonusValue    := 'Valor :';
      sBonusDate     := 'Valid.:';
      sMsgBonus      := '$$$$$$$ Você ganhou bônus $$$$$$$';
      sBonusGynbo1   := 'Acesse o site www.gynbo.com para ';
      sBonusGynbo2   := 'resgatar os seus bônus digitando o Bónus';
      sBonusGynbo3   := 'ou o e-mail :';
      lblInvoice.Caption                    := 'Nota #';
      lblInvoiceTotal.Caption               := 'Total Nota';
      lblChange.Caption                     := 'Troco';
      grdPaymentsDBTVMeioPag.Caption        := 'Pagamento';
      grdPaymentsDBTVDataVencimento.Caption := 'Vencimento';
      grdPaymentsDBTVValorNominal.Caption   := 'Valor';
      ppReport.Language := lgPortugueseBrazil;
    end;

    LANG_SPANISH :
    begin
      sEndereco      := ' Dirección:';
      sTelefone      := '  Teléfono:';
      sNoTaxAble     := 'No Tributable:';
      sTaxAble       := '   Tributable:';
      sTax           := '     Impuesto:';
      sSubTotal      := '     SubTotal:';
      sTotal         := '        Total:';
      sDiscount      := '    Descuento:';
      sHold          := 'PEND';
      sItems         := '---------------- Items -----------------';
      sTaxExpHeadr   := '========= EXENCIÒN DE IMPUESTO =========';
      sIInvNum       := 'Boleta #        : ';
      sIInvDate      := 'Fecha Boleta    : ';
      sICustomer     := 'Cliente         : ';
      sIPassPort     := 'Pasaporte       : ';
      sIPassPrtNum   := 'Fecha Pasaporte : ';
      sITicketNum    := 'Pasaje #        : ';
      sIAirLine      := 'Linea Aérea     : ';
      sIArrivalNum   := 'Número Vuelo    : ';
      sIBusName      := 'Empresa         : ';
      sILicencNum    := 'Impuesto ID #   : ';
      sIAddress      := 'Dirección       : ';
      sRecImpresso   := 'Recibo Imprimido';
      sClickOK       := 'Clic OK para continuar';
      sPayStore      := 'Tienda';
      sPayOuter      := 'Contra-Entrega';
      sPayOther      := 'Otros';
      sBonusCode     := 'Bónus : ';
      sBonusValue    := 'Valor :';
      sBonusDate     := 'Valid.:';
      sMsgBonus      := ' $$$$$$$ Você ganhou bônus $$$$$$$';
      sBonusGynbo1   := 'Acesse o site www.gynbo.com para ';
      sBonusGynbo2   := 'resgatar os seus bônus digitando o Bónus';
      sBonusGynbo3   := 'ou o e-mail :';
      lblInvoice.Caption                    := 'Boleta #';
      lblInvoiceTotal.Caption               := 'Total Boleta';
      lblChange.Caption                     := 'Cambio';
      grdPaymentsDBTVMeioPag.Caption        := 'Pagamiento';
      grdPaymentsDBTVDataVencimento.Caption := 'Vencimiento';
      grdPaymentsDBTVValorNominal.Caption   := 'Valor';
      ppReport.Language       := lgSpanish;
    end;
  end;
end;

procedure TPrintReceiptDeclined.quPaymentsCalcFields(DataSet: TDataSet);
var
  CardInfo : String;
begin
  inherited;
  case quPaymentsPaymentPlace.AsInteger of
    0: quPaymentsPaymentPlaceDesc.AsString  := sPayStore;
    1: quPaymentsPaymentPlaceDesc.AsString  := sPayOuter;
    else quPaymentsPaymentPlaceDesc.AsString := sPayOther;
  end;

  if quPaymentsPayType.AsInteger = PAY_TYPE_CASH then
  begin

    //controle criado pois a impressao do relatorio chama o evento vairias vezes
    if Assigned(FChangeList) and (FChangeList.IndexOf(quPaymentsIDLancamento.AsString) = -1) then
    begin
      FChangeList.Add(quPaymentsIDLancamento.AsString);
      MyChange := MyChange + quPaymentsValorNominal.AsFloat;
    end;

    if ((quPaymentsCashReceived.AsFloat - MyChange) > 0) then
      quPaymentsChange.AsFloat := quPaymentsCashReceived.AsFloat - MyChange
    else
      quPaymentsChange.AsFloat := 0;

    lblChangeValue.Caption := FormatFloat('#,##0.00', quPaymentsChange.AsFloat * -1);
  end;

  CardInfo := quPaymentsNumMeioQuitPreVisto.AsString;
  if CardInfo <> '' then
     if PosEx('A:', CardInfo) > 0 then
       begin
       quPaymentsAuthorization.AsString := Copy(CardInfo, Pos('A:', (CardInfo))+2, Pos(' R:', CardInfo)-2);
       quPaymentsCardNumber.AsString    := '************' + Copy(CardInfo, Pos('L:', CardInfo)+2, 4);
       end
     else
       begin
       quPaymentsAuthorization.AsString := quPaymentsNumMeioQuitPreVisto.AsString;
       end;

  (* Antonio M F Souza 11.02.2010 - This solution not worked.
  //Antonio M F Souza 10.29.2010 - Layaway
  if ( quPaymentsLayaway.AsBoolean ) then begin
      if ( FTotalInvoice > 0 ) then begin
          if ( (Assigned(FLayawayPayments)) and (FLayawayPayments.IndexOf(quPaymentsIDLancamento.AsString) = -1) ) then begin
             FSumLayawayPaid := FSumLayawayPaid + quPaymentsValorNominal.Value;
             quPaymentsRemains.Value := ( FTotalInvoice - FSumLayawayPaid);
          end;
          FLayawayPayments.Add(quPaymentsIDLancamento.AsString);
       end;
  end;
  *)
end;

procedure TPrintReceiptDeclined.quPreSaleItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  quPreSaleItemTaxes.Open;
  quFeatures.Open;
  quTechFeature.Open;
end;

procedure TPrintReceiptDeclined.quPreSaleItemAfterClose(DataSet: TDataSet);
begin
  inherited;
  quPreSaleItemTaxes.Close;
  quFeatures.Close;
  quTechFeature.Close;
end;

procedure TPrintReceiptDeclined.OpenQueries(var ReceiptType: Integer);
begin

  DM.FTraceControl.TraceIn('TPrintReceiptDeclined.OpenQueries');

  try

    with quPreSaleInfo do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
      Open;
      MyIDInvoice := quPreSaleInfoIDInvoice.AsInteger;
      MyCashReceived := quPreSaleInfoCashReceived.AsFloat;
    end;

    with quStore do
    begin
      if Active then
        Close;
      Parameters.ParamByName('IDStore').Value := quPreSaleInfoIDStore.AsInteger;
      Open;
    end;

    // Se é invoice, imprime o serial
    with quSerial do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDInvoice').Value := MyIDInvoice;
      Open;
    end;

    with cdsPreSaleItem do
    begin
      if Active then
        Close;

      if MyIDInvoice = 0 then
      begin
        Params.ParambyName('@DocumentID').Value := MyIDPreSale;
        Params.ParambyName('@IsPreSale').Value  := True;
        Params.ParambyName('@Date').Value       := Now;
      end
      else
      begin
        if (ReceiptType = RECEIPT_TYPE_HOLD) or
           (ReceiptType = RECEIPT_TYPE_LAYAWAY_RECEIVE) then
          ReceiptType := RECEIPT_TYPE_INVOICE;

        //O presale tem que passar esses parametros para os items
        Params.ParambyName('@DocumentID').Value := MyIDPreSale;
        Params.ParambyName('@IsPreSale').Value  := False;
        Params.ParambyName('@Date').Value       := Now;
      end;

      Open;

    end;

    with quPreSaleValue do
    begin
      if Active then
        Close;
      Parameters.ParambyName('@PreSaleID').Value := MyIDPreSale;
      Open;
    end;

    with quPayments do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
      Open;
    end;

    with quPaymentCondition do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
      Open;
    end;

    with quInvoiceCosts do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
      Open;
    end;

    with quDeliveryInfo do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale1').Value := MyIDPreSale;
      Parameters.ParambyName('IDPreSale').Value  := MyIDPreSale;
      Open;
    end;

    with quShippingInfo do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
      Open;
    end;


    if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      with quBonusBucks do
      begin
        if Active then
          Close;
        Parameters.ParambyName('IDPreSale').Value  := MyIDPreSale;
        Open;
      end;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPrintReceiptDeclined');
  end;

  DM.FTraceControl.TraceOut;
end;


procedure TPrintReceiptDeclined.tmrPrintTimer(Sender: TObject);
var
  I: Integer;
  bNotOk: Boolean;
  dDate: TDateTime;
  cPaymentTotal: Currency;
begin
  inherited;
  tmrPrint.Enabled := False;

  if (DM.fPrintReceipt.NumOfCopies > 1) then
    FCopies := DM.fPrintReceipt.NumOfCopies;

  try
    for I := 1 to FCopies do
    begin
      OpenQueries(FReceiptType);

      Update;

      Application.ProcessMessages;
      bNotOk := True;

      try

        //Impressao do Novo Relatorio
        if DM.fPrintReceipt.PaperType = PAPER_TYPE_4A then
        begin

          if ( not reprint ) then begin
              //Abrir gateta para imp. paralela
              if (DM.fCashRegister.Open and FPaymentDrawKick) and
                 (DM.fPrintReceipt.USBOpenDraw = '') and (DM.fCashRegister.OpenCod <> '') then
                 DM.OpenCashRegister(DRAW_KICK_TYPE_SALE);
          end;

          // Alex 10/01/2015
          //LoadReport(DM.fPrintReceipt.ReportPath);
          LoadReport(ppReportDeclined.Template.FileName);
          try
            ppReportDeclined.Print;
          except
            raise;
          end;
          //Cortar papel para impre. paralela
          if (not DM.fPrintReceipt.UseUSBPrinter) and (DM.fPrintReceipt.USBCutCode = '') then
            DM.SendAfterPrintCode(True);

          //Footer
          if FPrintFooter and (DM.fPrintReceipt.ReportPathFooter <> '') then
          begin
            FPaymentDrawKick := False;
            LoadReport(DM.fPrintReceipt.ReportPathFooter);
            try
              ppReportDeclined.Print;
            except
              raise;
            end;
            //Cortar papel para impre. paralela
            if (not DM.fPrintReceipt.UseUSBPrinter) and (DM.fPrintReceipt.USBCutCode = '') then
              DM.SendAfterPrintCode(True);
          end;


          DM.FTraceControl.TraceOut;
          Continue;
        end;

        if ( not reprint ) then begin
            // Open CashRegister
            if DM.fCashRegister.Open and FPaymentDrawKick then
               DM.OpenCashRegister(DRAW_KICK_TYPE_SALE);
        end;

        while bNotOk do
        begin
          try
            if DM.fPrintReceipt.PaperType <> PAPER_TYPE_4A then
              DM.PrinterStart;
            bNotOk := False;
          except
            if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
              bNotOk := True
            else
            begin
              MsgBox(MSG_INF_REPRINT_INVOICE, vbInformation + vbOkOnly);
              Exit;
            end;
          end;
        end;


        // -----------------------------------------------------------------
        // Impressão do cabecalho do ticket
        case FReceiptType of
          RECEIPT_TYPE_INVOICE,
          RECEIPT_TYPE_LAYAWAY_RECEIVE: // INVOICE
          begin
            // Tem que descobrir quem pagou o Invoice
            with quDescCashier do
            begin
              if Active then Close;
                Parameters.ParambyName('IDCashRegMov').Value := quPreSaleInfoCashRegMovID.AsInteger;
              Open;
              Close;
            end;
          end;

          RECEIPT_TYPE_HOLD: // HOLD
          begin
            if quPreSaleInfoInvoiceDate.IsNull then
              dDate := quPreSaleInfoPreSaleDate.AsDateTime
            else
              dDate := quPreSaleInfoInvoiceDate.AsDateTime;

          end;

          RECEIPT_TYPE_TICKET: // HOTEL TICKET
          begin
          end;
        end;

        // -----------------------------------------------------------------
        // Impressão dos itens do Ticket
        //ImpMemoNoEmptyLine(sItems + #13#10);

        with cdsPreSaleItem do
        begin
          DisableControls;
          First;
          while not Eof do
          begin
            quBarCode.Parameters.ParambyName('IDModel1').Value := FieldByName('ModelID').AsInteger;
            quBarCode.Parameters.ParambyName('IDModel2').Value := FieldByName('ModelID').AsInteger;
            quBarCode.Open;

            quBarCode.Close;
            Next;
          end;
          EnableControls;
        end;

        // --------------------------------------------------------------------
        // Impressão dos Totais
        with quPreSaleParc do
        begin
          if Active then Close;
            Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
          Open;
          cPaymentTotal := 0;
          MyTotCash := 0;
          while not EOF do
          begin
            cPaymentTotal := cPaymentTotal + quPreSaleParcValorNominal.AsCurrency;
            if quPreSaleParcIDMeioPag.AsInteger = 1 then
              MyTotCash := MyTotCash + quPreSaleParcValorNominal.AsCurrency;
            Next;
          end;
          Close;
        end;

        case FReceiptType of
          RECEIPT_TYPE_INVOICE,
          RECEIPT_TYPE_LAYAWAY_RECEIVE: // INVOICE
          begin
            with quPreSaleValue do
          end;

          RECEIPT_TYPE_HOLD,
          RECEIPT_TYPE_TICKET: // HOLD AND HOTEL TICKET
          begin
            with quPreSaleValue do
          end;
        end;

        // -----------------------------------------------------------------
        // Impressão das parcelas
        case FReceiptType of
          RECEIPT_TYPE_INVOICE,
          RECEIPT_TYPE_LAYAWAY_RECEIVE: // INVOICE & LAYAWAY
          begin
            with quPreSaleParc do
            begin
              if Active then Close;
                Parameters.ParambyName('IDPreSale').Value := MyIDPreSale;
              Open;
            end;
          end;

          RECEIPT_TYPE_HOLD, RECEIPT_TYPE_TICKET: // HOLD & HOTEL TICKET
          begin
            // Não tem impressao de parcelas
          end;
        end;


        // -----------------------------------------------------------------
        // Impressão do rodape
        case FReceiptType of
          RECEIPT_TYPE_INVOICE,
          RECEIPT_TYPE_TICKET,
          RECEIPT_TYPE_HOLD: // INVOICE, HOTEL TICKET, HOLD
        end;

        // Marca o Invoice como Printed
        if FReceiptType = RECEIPT_TYPE_INVOICE then
        begin
          with DM.quFreeSQL do
          begin
            if Active then
              Close;
            SQL.Text := 'UPDATE Invoice SET Printed = 1 WHERE IDInvoice = ' + IntToStr(MyIDInvoice);
            ExecSQL;
          end;
        end;

        // -----------------------------------------------------------------
        // Cortar o papel
        if DM.fPrintReceipt.PaperType <> PAPER_TYPE_4A then
          DM.SendAfterPrintCode;

      finally
        if DM.fPrintReceipt.PaperType <> PAPER_TYPE_4A then
          DM.PrinterStop;
      end;
    end;
  finally
    lblPrint.Caption := sRecImpresso;
    btOk.Visible     := True;
    AniPrint.Active  := False;
    AniPrint.Visible  := False;
    pnlPrinter.Caption := sClickOK;

    ActualTime := Now;
    btnReprint.Visible := true;
    Application.ProcessMessages;
  end;
end;


procedure TPrintReceiptDeclined.LoadLogoImage;
var
  msLogo: TMemoryStream;
  img: TJPEGImage;
begin
  if Assigned(ppLogoImage) then
  begin
    msLogo := TMemoryStream.Create;
    try
      if not quStoreLogoEMP.IsNull then
      begin
        quStoreLogoEMP.SaveToStream(msLogo);
        msLogo.Seek(0, soFromBeginning);
        img := TJPEGImage.Create;
        try
          img.LoadFromStream(msLogo);
          ppLogoImage.Picture.Bitmap.Assign(img);
        finally
          FreeAndNil(img);
        end;
      end
      else
        ppLogoImage.Picture.CleanupInstance;
    finally
      msLogo.Free;
    end;
  end;
end;


procedure TPrintReceiptDeclined.quPaymentsAfterOpen(DataSet: TDataSet);
begin
  inherited;

  MyChange := 0;
  if Assigned(FChangeList) then begin
    FChangeList.Clear;
  end;

  //Antonio M F Souza 10.29.2010 : To layaway remains to each sale item.
  FSumLayawayPaid := 0;
  if Assigned(FLayawayPayments) then begin
    FLayawayPayments.Clear;
  end;

end;

procedure TPrintReceiptDeclined.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FChangeList);
  freeAndNil(FLayawayPayments);
end;



procedure TPrintReceiptDeclined.btnReprintClick(Sender: TObject);
begin
  inherited;

  //Antonio M F Souza June 29, 2012
  reprint := true;
  tmrPrintTimer(Sender);
  reprint := false;
end;

function TPrintReceiptDeclined.getTotalInvoice(AIdPreSale: integer): double;
var
  dsTotalInvoice: TADOQuery;
  sql: String;
begin
  try

    sql:= 'select ( (i.SubTotal + i.Tax + i.AditionalExpenses)  - (i.TaxIsent + i.ItemDiscount + i.InvoiceDiscount) ) total ' +
          'from Invoice i where i.IDPreSale = :idpresale ';

    dsTotalInvoice := TADOQuery.Create(nil);
    dsTotalInvoice.Connection := DM.ADODBConnect;

    dsTotalInvoice.SQL.Text := sql;
    dsTotalInvoice.Parameters.ParamByName('idpresale').Value := AIdPreSale;
    dsTotalInvoice.Open;

    if ( not dsTotalInvoice.FieldByName('total').IsNull ) then
       result := dsTotalInvoice.fieldbyname('total').Value
    else
       result := 0;

  finally
     freeAndNil(dsTotalInvoice);
  end;
end;

function TPrintReceiptDeclined.BuildExtraInformationText(originalText: String): String;
Var
  cmvPosition : Integer;
  tempString : String;
  List: TStringList;
begin
  originalText := StringReplace(originalText, 'Visa Credit', 'Visa_Credit', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'PIN VERIFIED', 'PIN_VERIFIED', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'NO CVM', 'NO_CVM', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'OFFLINE PIN', 'OFFLINE_PIN', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'ONLINE PIN', 'ONLINE_PIN', [rfReplaceAll, rfIgnoreCase]);
  originalText := StringReplace(originalText, 'EMV', '', [rfReplaceAll]);

  cmvPosition := IfThen( Pos( 'CVM:', originalText ) > 0, Pos( 'CVM:', originalText ), Length( originalText ) );
  tempString := Copy( originalText, 0, cmvPosition );

  List := TStringList.Create;
  ExtractStrings([' '], [], PChar(originalText), List);

  Result := StringReplace(List[8], 'P:', 'Application Label:', [rfReplaceAll, rfIgnoreCase]) + #13 +
            StringReplace(List[1], 'R:', 'Reference:', [rfReplaceAll, rfIgnoreCase]) + #13 +
            StringReplace(List[4], 'E:', 'Entry Method:', [rfReplaceAll, rfIgnoreCase]) + #13 +
            StringReplace(List[1], 'R:', 'Reference:', [rfReplaceAll, rfIgnoreCase]) + #13 +
            List[9]  + #13 +
            List[10] + #13 +
            List[11] + #13 +
            List[12] + #13 +
            List[13] + #13 +
            StringReplace(List[14], '_', ' ', [rfReplaceAll, rfIgnoreCase]) + #13 +
            StringReplace(List[15], 'TC:', 'Transaction Type:', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TPrintReceiptDeclined.virtualSelectDeclinedCalcFields(DataSet: TDataSet);
Var
  CardInfo : String;
begin
  inherited;
  CardInfo := virtualSelectDeclinedNumMeioQuitPrevisto.AsString;
  If ( Pos('chip',cardInfo) > 0 ) Then
     virtualSelectDeclinedNumMeioQuitPrevisto.AsString := BuildExtraInformationText( cardInfo )
  Else
     virtualSelectDeclinedNumMeioQuitPrevisto.AsString := '';
end;

end.

