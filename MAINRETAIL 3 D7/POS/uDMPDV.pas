unit uDMPDV;

interface

uses
  SysUtils, Classes, DB, ADODB,ComCtrls, ExtCtrls, uFormasPagamento,
  DBClient, Provider, Variants, uPreSale, siComp, siLangRT, IniFiles,
  Forms, uFilePersistence, uTransferFile, uMsgBox;

const
  ATiposPagto: array[1..9] of String = ('Dinheiro', 'Cartão Crédito', 'Outros', 'Cheque', 'Crédito', 'Vale Presente', 'Cartão Débito', 'Cupom', 'Conta Loja');

  ITEM_MODE_QTY_BARCODE = 1;
  ITEM_MODE_QTY_MODEL   = 2;

type


  TECFIDtoIndex = class
    ID: Integer;
    ECFIndex: String;
    ECFTotalizador: String;
  end;

  TECFTax = TECFIDtoIndex;

  TECFPag = class(TECFIDtoIndex)
    Bandeira : Integer;
    TipoTEF: Integer;
  end;

  TECFVin = TECFIDtoIndex;

  TDMPDV = class(TDataModule)
    quPreSaleInfo: TADOQuery;
    quPreSaleInfoIDPreSale: TIntegerField;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoDeliverTypeID: TIntegerField;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleInfoDeliverAddress: TStringField;
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
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoIDStore: TIntegerField;
    quPreSaleInfoAddress: TStringField;
    quPreSaleInfoLayaway: TBooleanField;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quPreSaleInfoZip: TStringField;
    quPreSaleInfoSaleCode: TStringField;
    spquPreSaleItem: TADOStoredProc;
    spquPreSaleItemModelID: TIntegerField;
    spquPreSaleItemModel: TStringField;
    spquPreSaleItemDescription: TStringField;
    spquPreSaleItemSalePrice: TFloatField;
    spquPreSaleItemDiscActual: TFloatField;
    spquPreSaleItemDiscount: TFloatField;
    spquPreSaleItemIDInventoryMov: TIntegerField;
    spquPreSaleItemTotalItem: TFloatField;
    spquPreSaleItemSalesPerson: TStringField;
    spquPreSaleItemIDComission: TIntegerField;
    spquPreSaleItemCostPrice: TFloatField;
    spquPreSaleItemExchangeInvoice: TIntegerField;
    spquPreSaleItemSuggRetail: TFloatField;
    spquPreSaleItemSerialNumber: TBooleanField;
    spquPreSaleItemIDUser: TIntegerField;
    spquPreSaleItemTax: TFloatField;
    spquPreSaleItemSubTotalItem: TFloatField;
    spquPreSaleValue: TADOStoredProc;
    spquPreSaleValueTaxIsent: TBooleanField;
    spquPreSaleValueSubTotal: TFloatField;
    spquPreSaleValueItemDiscount: TFloatField;
    spquPreSaleValueTax: TFloatField;
    spquPreSaleValueTaxPrc: TFloatField;
    spquPreSaleValueDiscountPrc: TFloatField;
    spquPreSaleValueTotalInvoice: TFloatField;
    spquPreSaleValueSpecialPriceID: TIntegerField;
    spquPreSaleValueSpecialPrice: TStringField;
    spquPreSaleValuenOpenUser: TIntegerField;
    spquPreSaleValueShowOpenUser: TIntegerField;
    spquPreSaleValueNewSubTotal: TFloatField;
    spquPreSaleValueTaxIsemptValue: TFloatField;
    spquPreSaleValueSubTotalTaxable: TCurrencyField;
    spquPreSaleValueTaxIsemptItemDiscount: TFloatField;
    quBarcode: TADOQuery;
    dsPreSaleValue: TDataSource;
    dsPreSaleItem: TDataSource;
    dsPreSaleInfo: TDataSource;
    quMeioPag: TADOQuery;
    FormasPagamento: TFormasPagamento;
    quCustomer: TADODataSet;
    dspCustomer: TDataSetProvider;
    cdsCustomer: TClientDataSet;
    quOtherCommission: TADODataSet;
    dspOtherCommission: TDataSetProvider;
    cdsOtherCommission: TClientDataSet;
    cdsCustomerIDPessoa: TIntegerField;
    cdsCustomerPessoa: TStringField;
    cdsCustomerPessoaFirstName: TStringField;
    cdsCustomerPessoaLastName: TStringField;
    cdsCustomerEndereco: TStringField;
    cdsCustomerCidade: TStringField;
    cdsCustomerCEP: TStringField;
    cdsCustomerTelefone: TStringField;
    cdsCustomerCPF: TStringField;
    cdsOtherCommissionIDPessoa: TIntegerField;
    cdsOtherCommissionIDComissionado: TIntegerField;
    cdsOtherCommissionPessoa: TStringField;
    quSystemUser: TADODataSet;
    dspSystemUser: TDataSetProvider;
    cdsSystemUser: TClientDataSet;
    quModel: TADODataSet;
    dspModel: TDataSetProvider;
    cdsModel: TClientDataSet;
    ADODataSet1: TADODataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    cdsSystemUserIDUser: TIntegerField;
    cdsSystemUserSystemUser: TStringField;
    cdsSystemUserComissionID: TIntegerField;
    quBarcodeSearch: TADODataSet;
    dspBarcodeSearch: TDataSetProvider;
    cdsBarcodeSearch: TClientDataSet;
    quMDescription: TADODataSet;
    dspMDescription: TDataSetProvider;
    cdsMDescription: TClientDataSet;
    quNewCustomer: TADOQuery;
    cmdPessoa: TADOCommand;
    siLang: TsiLangRT;
    quModelAccessory: TADODataSet;
    cdsCustomerInscEstadual: TStringField;
    cdsCustomerBairro: TStringField;
    dspModelAccessory: TDataSetProvider;
    cdsModelAccessory: TClientDataSet;
    cdsModelAccessoryIDInvAccessory: TIntegerField;
    cdsModelAccessoryIDModel: TIntegerField;
    cdsModelAccessoryModel: TStringField;
    cdsModelAccessoryDescription: TStringField;
    cdsModelAccessoryHint: TStringField;
    cdsModelAccessoryLargeImage: TStringField;
    cdsModelAccessoryPromotionPrice: TBCDField;
    cdsModelAccessoryDiscountPerc: TFloatField;
    cdsModelAccessorySellingPrice: TBCDField;
    dspMeioPag: TDataSetProvider;
    cdsMeioPag: TClientDataSet;
    cdsMeioPagIDMeioPag: TIntegerField;
    cdsMeioPagMeioPag: TStringField;
    cdsMeioPagImageIndex: TIntegerField;
    cdsMeioPagTipo: TIntegerField;
    dspBarcode: TDataSetProvider;
    cdsBarcode: TClientDataSet;
    quBarcodeIDModel: TIntegerField;
    quBarcodeModel: TStringField;
    quBarcodeIDBarcode: TStringField;
    dspQty: TDataSetProvider;
    cdsBarcodeIDModel: TIntegerField;
    cdsBarcodeModel: TStringField;
    cdsBarcodeIDBarcode: TStringField;
    cdsBarcodeSearchIDBarcode: TStringField;
    cdsBarcodeSearchIDModel: TIntegerField;
    cdsBarcodeSearchModel: TStringField;
    tmLoadGlobal: TTimer;
    quDiscRange: TADODataSet;
    dspDiscRange: TDataSetProvider;
    cdsDiscRange: TClientDataSet;
    cdsDiscRangeIDTipoComissionado: TIntegerField;
    cdsDiscRangeTotVendaMin: TBCDField;
    cdsDiscRangePercDiscMax: TBCDField;
    cdsSystemUserIDTipoPessoa: TIntegerField;
    quInvFeatures: TADODataSet;
    dspInvFeatures: TDataSetProvider;
    cdsInvFeatures: TClientDataSet;
    cdsInvFeaturesIDInvFeatures: TIntegerField;
    cdsInvFeaturesIDModel: TIntegerField;
    cdsInvFeaturesFeature: TStringField;
    quInvTechFeat: TADODataSet;
    dspInvTechFeat: TDataSetProvider;
    cdsInvTechFeat: TClientDataSet;
    cdsInvTechFeatIDInvTechFeatures: TIntegerField;
    cdsInvTechFeatIDModel: TIntegerField;
    cdsInvTechFeatTechFeature: TStringField;
    spquPreSaleItemQty: TFloatField;
    quQty: TADODataSet;
    cdsQty: TClientDataSet;
    quInvDepartment: TADODataSet;
    quInvModelDepartment: TADODataSet;
    quInvModelDepartmentModelID: TIntegerField;
    quInvModelDepartmentIDDepartment: TIntegerField;
    quInvModelDepartmentDepartment: TStringField;
    dspInvDepartment: TDataSetProvider;
    dspInvModelDepartment: TDataSetProvider;
    cdsInvDepartment: TClientDataSet;
    cdsInvModelDepartment: TClientDataSet;
    cdsInvDepartmentIDDepartment: TIntegerField;
    cdsInvDepartmentDepartment: TStringField;
    cdsInvModelDepartmentModelID: TIntegerField;
    cdsInvModelDepartmentIDDepartment: TIntegerField;
    cdsInvModelDepartmentDepartment: TStringField;
    quTotalMeioPag: TADOQuery;
    quTotalDeposited: TADODataSet;
    tmrSaveFilesToServer: TTimer;
    spquPreSaleValueInvoiceDiscount: TCurrencyField;
    quQtyName: TStringField;
    quQtyQtyOnPreSale: TBCDField;
    quQtyQtyOnHand: TBCDField;
    quQtyQtyOnOrder: TBCDField;
    quQtyQtyOnRepair: TBCDField;
    quQtyStoreID: TIntegerField;
    quQtyQtyOnPrePurchase: TBCDField;
    quQtyCurrentCost: TBCDField;
    quQtyFloatPercent: TIntegerField;
    quQtyIDModel: TIntegerField;
    cdsQtyName: TStringField;
    cdsQtyQtyOnPreSale: TBCDField;
    cdsQtyQtyOnHand: TBCDField;
    cdsQtyQtyOnOrder: TBCDField;
    cdsQtyQtyOnRepair: TBCDField;
    cdsQtyStoreID: TIntegerField;
    cdsQtyQtyOnPrePurchase: TBCDField;
    cdsQtyCurrentCost: TBCDField;
    cdsQtyFloatPercent: TIntegerField;
    cdsQtyIDModel: TIntegerField;
    dspInvSerial: TDataSetProvider;
    quInvSerial: TADODataSet;
    cdsInvSerial: TClientDataSet;
    quInvSerialStoreID: TIntegerField;
    quInvSerialModelID: TIntegerField;
    quInvSerialSerial: TStringField;
    cdsInvSerialStoreID: TIntegerField;
    cdsInvSerialModelID: TIntegerField;
    cdsInvSerialSerial: TStringField;
    dspStoreTablePrice: TDataSetProvider;
    quStoreTablePrice: TADODataSet;
    cdsStoreTablePrice: TClientDataSet;
    dspModelTablePrice: TDataSetProvider;
    quModelTablePrice: TADODataSet;
    cdsModelTablePrice: TClientDataSet;
    quStoreTablePriceIDStore: TIntegerField;
    quStoreTablePriceIDModel: TIntegerField;
    quStoreTablePriceIDDescriptionPrice: TIntegerField;
    quStoreTablePriceIDVendor: TIntegerField;
    quStoreTablePriceSuggPrice: TBCDField;
    quStoreTablePriceSalePrice: TBCDField;
    cdsStoreTablePriceIDStore: TIntegerField;
    cdsStoreTablePriceIDModel: TIntegerField;
    cdsStoreTablePriceIDDescriptionPrice: TIntegerField;
    cdsStoreTablePriceIDVendor: TIntegerField;
    cdsStoreTablePriceSuggPrice: TBCDField;
    cdsStoreTablePriceSalePrice: TBCDField;
    quModelTablePriceIDModel: TIntegerField;
    quModelTablePriceIDDescriptionPrice: TIntegerField;
    quModelTablePriceIDVendor: TIntegerField;
    quModelTablePriceSuggPrice: TBCDField;
    quModelTablePriceSalePrice: TBCDField;
    cdsModelTablePriceIDModel: TIntegerField;
    cdsModelTablePriceIDDescriptionPrice: TIntegerField;
    cdsModelTablePriceIDVendor: TIntegerField;
    cdsModelTablePriceSuggPrice: TBCDField;
    cdsModelTablePriceSalePrice: TBCDField;
    quModelTablePriceDescriptionPrice: TStringField;
    quModelTablePriceVendor: TStringField;
    cdsModelTablePriceDescriptionPrice: TStringField;
    cdsModelTablePriceVendor: TStringField;
    quStoreTablePriceDescriptionPrice: TStringField;
    quStoreTablePriceVendor: TStringField;
    cdsStoreTablePriceDescriptionPrice: TStringField;
    cdsStoreTablePriceVendor: TStringField;
    dspDocumentType: TDataSetProvider;
    quDocumentType: TADODataSet;
    cdsDocumentType: TClientDataSet;
    quDocumentTypeIDDocumentType: TIntegerField;
    quDocumentTypeDocumentType: TStringField;
    quDocumentTypeDefaultType: TBooleanField;
    cdsDocumentTypeIDDocumentType: TIntegerField;
    cdsDocumentTypeDocumentType: TStringField;
    cdsDocumentTypeDefaultType: TBooleanField;
    cdsModelIDModel: TIntegerField;
    cdsModelModel: TStringField;
    cdsModelDescription: TStringField;
    cdsModelReplacementCost: TBCDField;
    cdsModelPeso: TBCDField;
    cdsModelSuggRetail: TBCDField;
    cdsModelAvgCost: TBCDField;
    cdsModelLargeImage: TStringField;
    cdsModelLargeImage2: TStringField;
    cdsModelPromotionPrice: TBCDField;
    cdsModelAskUserOnSale: TBooleanField;
    cdsModelDiscountPerc: TFloatField;
    cdsModelCustomSalePrice: TBooleanField;
    cdsModelStoreSellingPrice: TBCDField;
    cdsModelTabGroup: TStringField;
    cdsModelUnidade: TStringField;
    cdsModelSigla: TStringField;
    cdsModelFabricante: TStringField;
    cdsModelSizeName: TStringField;
    cdsModelCodSize: TStringField;
    cdsModelColor: TStringField;
    cdsModelCodColor: TStringField;
    cdsModelRequestCustomer: TBooleanField;
    cdsModelPuppyTracker: TBooleanField;
    cdsModelVendorCostM: TBCDField;
    cdsModelVendorCostI: TBCDField;
    cdsModelInvSellingPriceM: TBCDField;
    cdsModelInvSellingPriceI: TBCDField;
    cdsModelIDTaxCategory: TIntegerField;
    cdsModelIDDepartment: TIntegerField;
    cdsModelFornecedor: TStringField;
    cdsModelCaseQty: TBCDField;
    cdsModelSerialNumber: TBooleanField;
    cdsModelUseDocumentOnSale: TBooleanField;
    cdsModelUseScale: TBooleanField;
    cdsModelSellingPrice: TCurrencyField;
    cdsModelInvSellingPrice: TCurrencyField;
    cdsModelVendorCost: TCurrencyField;
    cdsMDescriptionIDModel: TIntegerField;
    cdsMDescriptionModel: TStringField;
    cdsMDescriptionDescription: TStringField;
    cdsMDescriptionReplacementCost: TBCDField;
    cdsMDescriptionPeso: TBCDField;
    cdsMDescriptionSuggRetail: TBCDField;
    cdsMDescriptionAvgCost: TBCDField;
    cdsMDescriptionLargeImage: TStringField;
    cdsMDescriptionLargeImage2: TStringField;
    cdsMDescriptionPromotionPrice: TBCDField;
    cdsMDescriptionAskUserOnSale: TBooleanField;
    cdsMDescriptionDiscountPerc: TFloatField;
    cdsMDescriptionCustomSalePrice: TBooleanField;
    cdsMDescriptionStoreSellingPrice: TBCDField;
    cdsMDescriptionTabGroup: TStringField;
    cdsMDescriptionUnidade: TStringField;
    cdsMDescriptionSigla: TStringField;
    cdsMDescriptionFabricante: TStringField;
    cdsMDescriptionSizeName: TStringField;
    cdsMDescriptionCodSize: TStringField;
    cdsMDescriptionColor: TStringField;
    cdsMDescriptionCodColor: TStringField;
    cdsMDescriptionRequestCustomer: TBooleanField;
    cdsMDescriptionPuppyTracker: TBooleanField;
    cdsMDescriptionVendorCostM: TBCDField;
    cdsMDescriptionVendorCostI: TBCDField;
    cdsMDescriptionInvSellingPriceM: TBCDField;
    cdsMDescriptionInvSellingPriceI: TBCDField;
    cdsMDescriptionIDTaxCategory: TIntegerField;
    cdsMDescriptionIDDepartment: TIntegerField;
    cdsMDescriptionFornecedor: TStringField;
    cdsMDescriptionCaseQty: TBCDField;
    cdsMDescriptionSerialNumber: TBooleanField;
    cdsMDescriptionUseDocumentOnSale: TBooleanField;
    cdsMDescriptionUseScale: TBooleanField;
    cdsMDescriptionSellingPrice: TCurrencyField;
    cdsMDescriptionInvSellingPrice: TCurrencyField;
    cdsMDescriptionVendorCost: TCurrencyField;
    quMeioPagMinSale: TADOQuery;
    dspMeioPagMinSale: TDataSetProvider;
    cdsMeioPagMinSale: TClientDataSet;
    cdsMeioPagMinSaleIDMeioPag: TIntegerField;
    cdsMeioPagMinSaleDifDay: TIntegerField;
    cdsMeioPagMinSaleTotalSale: TBCDField;
    cdsMeioPagRequireCustomer: TBooleanField;
    cdsModelIndicadorProducao: TStringField;
    cdsModelIndicadorAT: TStringField;
    cdsModelSituacaoTributaria: TIntegerField;
    cdsModelDescSituTribut: TStringField;
    cdsMDescriptionIndicadorProducao: TStringField;
    cdsMDescriptionIndicadorAT: TStringField;
    cdsMDescriptionSituacaoTributaria: TIntegerField;
    cdsMDescriptionDescSituTribut: TStringField;
    cdsQtySold: TClientDataSet;
    cdsQtySoldIDModel: TIntegerField;
    cdsQtySoldQty: TBCDField;
    cdsQtySoldSaleDate: TDateTimeField;
    quBarcodeCaseQty: TFloatField;
    cdsBarcodeCaseQty: TFloatField;
    cdsBarcodeSearchCaseQty: TFloatField;
    cdsCustomerStoreAccountLimit: TBCDField;
    cdsCustomerNonpayer: TBooleanField;
    cdsMeioPagValidateNonpayer: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsModelCalcFields(DataSet: TDataSet);
    procedure cdsMDescriptionCalcFields(DataSet: TDataSet);
    procedure cdsMDescriptionBeforeOpen(DataSet: TDataSet);
    procedure cdsModelAccessoryBeforeOpen(DataSet: TDataSet);
    procedure tmLoadGlobalTimer(Sender: TObject);
    procedure tmrSaveFilesToServerTimer(Sender: TObject);
    procedure cdsInvSerialBeforeOpen(DataSet: TDataSet);
  private
    ECFTaxList,
    ECFPagList,
    ECFVinList: TStringList;

    FTransferFile: TTransferFile;
    FServerActive: Boolean;
    FCanTransferFile: Boolean;
    FSellNegative: Boolean;

    procedure PreencheFormaPagamento;
    procedure UnLoadECFTaxList;
    procedure UnLoadECFPagList;
    procedure UnLoadECFVinList;
    procedure InitGlobalTXT;
    procedure ServerStatus(Online: Boolean);
  public
    DefaultMeioPag : TMeioPagamento;
    FLastQtyUpdate : TDateTime;

    property ServerActive: Boolean read FServerActive write FServerActive;
    property CanTransferFile: Boolean read FCanTransferFile write FCanTransferFile;
    property TransferFile: TTransferFile read FTransferFile;
    property SellNegative: Boolean read FSellNegative write FSellNegative; 

    function ValidadeBarcode(iSearchItemMode : Integer; Barcode: String; var Cost,
      Selling, StorePrice: Currency; var IDModel : Integer;
      var Desc, Model, Tax, ImagePath : String;
      var AskPrice : Boolean; var PuppyTracker: Boolean;
      var RequestCustomer: Boolean; var CaseQty: Double;
      var PrcPartDiscount: Currency;
      var IDDepartment: Integer;
      var AskSalesPerson : Boolean;
      var HasSerialNumber : Boolean;
      var AskDocument : Boolean;
      var UseScale : Boolean;
      var TotParcial : String;
      var Unidade : String): Boolean;

    function TestInvoiceDiscRange(AIDCommissionType: Integer;
      AInvoiceValue, ADiscount: Currency): Boolean;

    procedure AbreTabelas;

    function GetECFTaxIndex(IDTaxCategory: Integer): String;
    procedure SetECFTaxIndex(IDTaxCategory: Integer; Value: String);
    function GetCodFiscal(IDMeioPag: Integer): String;
    procedure SetECFCodFiscal(IDMeioPag: Integer; Value: String);
    function GetECFVinIndex(IDMeioPag: Integer): String;
    procedure SetECFVinIndex(IDMeioPag: Integer; Value: String);
    function GetBandeira(IDMeioPag: Integer): Integer;
    procedure SetECFBandeira(IDMeioPag: Integer; Value: Integer);
    function GetTipoTEF(IDMeioPag: Integer): Integer;
    procedure SetECFTipoTEF(IDMeioPag: Integer; Value: Integer);

    procedure LoadECFPagList;
    procedure LoadECFTaxList;
    procedure LoadECFVinList;
    procedure LoadECFTEFList(ECFIni: TIniFile);

    procedure OpenSuggestions(IDModel:Integer);
    procedure CloseSuggestions;

    procedure OpenQuantity(IDModel:Integer; AFilter : String);
    procedure CloseQuantity;

    procedure OpenInvSerial(IDModel:Integer);
    procedure CloseInvSerial;

    procedure OpenTablePrice(IDStore, IDModel: Integer);
    procedure CloseTablePrice;

    function AddCustomer(Customer:TCustomerInfo):Integer;

    function SelectModelDepartment(const AIDModel: Integer;
      var AIDDepartment: Integer): Boolean;

    procedure SaveFilesToServer(AllLastFiles: Boolean =  False);

    function GetTotalCashSale(IDCashRegMov : Integer) : Currency;

    function GetTotalCashInRegister : Currency;

    function IsMinPayValue(AIDPaymentType: Integer; AValue: Real): boolean;

    function AjustaPreco(Qtde, PrecoBalanca, PrecoUnit: real): Real;
    function TruncarDecimal(Valor: Real; Decimal: integer): Double;
    procedure AddQtySold(AIDModel : Integer; AQty: Double);
    procedure SaveQtySold;
    function GetQtySold(AIDModel : Integer) : Double;

    //PAF
    function GetTotalizadorParcial(IDTaxCategory : Integer):String;
    function GetECFTotParcial(Aliquota: String): String;
  end;

var
  DMPDV: TDMPDV;

implementation

uses uDM, uSystemConst, uSQLFunctions, uDMGlobal, uFrmImport, uDateTimeFunctions,
  uFrmAskDepartment, uFileFunctions;

{$R *.dfm}

function TDMPDV.ValidadeBarcode(iSearchItemMode : Integer;
  Barcode: String; var Cost, Selling, StorePrice: Currency;
  var IDModel : Integer;
  var Desc, Model, Tax, ImagePath : String;
  var AskPrice : Boolean; var PuppyTracker: Boolean;
  var RequestCustomer: Boolean; var CaseQty: Double;
  var PrcPartDiscount: Currency;
  var IDDepartment: Integer;
  var AskSalesPerson : Boolean;
  var HasSerialNumber : Boolean;
  var AskDocument : Boolean;
  var UseScale : Boolean;
  var TotParcial : String;
  var Unidade : String): Boolean;
var
  sWhere, sOriginalWhere : String;
  sModel: String;
begin
  Result := False;
  if Trim(Barcode) = '' then
     Exit;

  try

     sModel := UpperCase(Trim(Barcode));

     if iSearchItemMode = ITEM_MODE_QTY_BARCODE then
     begin
       if DM.PersistenceType = ptDB then
         cdsBarcode.Close;

       cdsBarcode.Filtered := False;

       sWhere := 'IDBarcode = ' + QuotedStr(sModel);

       case DM.PersistenceType of
         ptDB:
         begin
           quBarcode.SQL.Text := ChangeWhereClause(quBarcode.SQL.Text, sWhere, True);
           cdsBarcode.Open;
         end;

         ptTXT:
         begin
           cdsBarcode.Filter := sWhere;
           cdsBarcode.Filtered := True;
         end;
       end;

       if not cdsBarcode.IsEmpty then
         sModel := cdsBarcodeIDModel.AsString
       else
         Exit;

       sWhere := 'IDModel = ' + QuotedStr(sModel);
     end //End Search Barcode
     else
       sWhere := 'Model = ' + QuotedStr(sModel);

     cdsModel.Filtered := False;

     if (DM.PersistenceType = ptDB) then
        sWhere := sWhere + ' AND TC.OperationType = 1 ' +
                           ' AND TC.SaleTaxType = 2 ';

     case DM.PersistenceType of
       ptDB:
       begin
         //Voltar com o Where Original no final da consulta

         sWhere := sWhere + Format(' AND	S.IDStore = %D ', [DM.fStore.ID]);


         sOriginalWhere := ' M.Desativado = 0 AND M.Hidden = 0 AND  ' +
                           'M.ModelType IN ('+QuotedStr('S')+', '+QuotedStr('R')+', '+QuotedStr('V')+', '+QuotedStr('C')+','+QuotedStr('K')+' ) ' +
                           Format('AND	S.IDStore = %D ', [DM.fStore.ID]);
         cdsModel.Close;
         quModel.CommandText := ChangeWhereClause(quModel.CommandText, sWhere, True);
         cdsModel.Open;
       end;

       ptTXT:
       begin
         cdsModel.Filter   := sWhere;
         cdsModel.Filtered := True;
       end;
     end;

     if cdsModel.IsEmpty then
       Exit;

     IDModel          := cdsModel.FieldByName('IDModel').AsInteger;
     Cost             := cdsModel.FieldByName('VendorCost').AsCurrency;
     Desc             := cdsModel.FieldByName('Description').AsString;
     Model            := cdsModel.FieldByName('Model').AsString;
     Tax              := GetECFTaxIndex(cdsModel.FieldByName('IDTaxCategory').AsInteger);
     AskPrice         := cdsModel.FieldByName('CustomSalePrice').AsBoolean;
     ImagePath        := cdsModel.FieldByName('LargeImage').AsString;
     RequestCustomer  := cdsModel.FieldByName('RequestCustomer').AsBoolean;
     PuppyTracker     := cdsModel.FieldByName('PuppyTracker').AsBoolean;
     CaseQty          := cdsModel.FieldByName('CaseQty').AsFloat;
     PrcPartDiscount  := cdsModel.FieldByName('DiscountPerc').AsCurrency;
     IDDepartment     := cdsModel.FieldByName('IDDepartment').AsInteger;
     AskSalesPerson   := cdsModel.FieldByName('AskUserOnSale').AsBoolean;
     HasSerialNumber  := cdsModel.FieldByName('SerialNumber').AsBoolean;
     AskDocument      := cdsModel.FieldByName('UseDocumentOnSale').AsBoolean;
     UseScale         := cdsModel.FieldByName('UseScale').AsBoolean;
     TotParcial       := GetTotalizadorParcial(cdsModel.FieldByName('IDTaxCategory').AsInteger);
     Unidade          := cdsModel.FieldByName('Sigla').AsString;

     CaseQty := cdsBarcodeCaseQty.AsFloat;

     if cdsModel.FieldByName('PromotionPrice').AsCurrency <> 0 then
        Selling := cdsModel.FieldByName('PromotionPrice').AsCurrency
     else
        Selling := cdsModel.FieldByName('SellingPrice').AsCurrency;

     StorePrice := cdsModel.FieldByName('StoreSellingPrice').AsCurrency;

     //Open Qty for Store
     //DM.fPOS.GetQty(IDModel, DM.fStore.ID, fOnHand, fOnPreSale, fOnPrePurchase);

     //Verifica se o Model esta deletado e Restaura
     if DM.PersistenceType = ptDB then
       DM.ModelRestored(IDModel);

     //cancelar os pagamentos pre-datados caso haja mudanca
     //CancelPreDatar;

     Result := True;
  finally
    if DM.PersistenceType = ptDB then
      begin
      cdsBarcode.Close;
      cdsModel.Close;
      quModel.CommandText := ChangeWhereClause(quModel.CommandText, sOriginalWhere, True);
      end;

      cdsBarcode.Filter := '';
      cdsModel.Filter   := '';

      cdsBarcode.Filtered := False;
      cdsModel.Filtered := False;
    end;

end;

function TDMPDV.GetECFTaxIndex(IDTaxCategory: Integer): String;
var
  Indice: Integer;
begin
  Result := '';

  Indice := ECFTaxList.IndexOf(IntToStr(IDTaxCategory));
  if Indice >= 0 then
   Result := TECFTax(ECFTaxList.Objects[Indice]).ECFIndex;
end;

function TDMPDV.GetCodFiscal(IDMeioPag: Integer): String;
var
  Indice: Integer;
begin
  Result := '';

  Indice := ECFPagList.IndexOf(IntToStr(IDMeioPag));
  if Indice >= 0 then
   Result := TECFPag(ECFPagList.Objects[Indice]).ECFIndex;
end;

function TDMPDV.GetECFVinIndex(IDMeioPag: Integer): String;
var
  Indice: Integer;
begin
  Result := '';

  Indice := ECFVinList.IndexOf(IntToStr(IDMeioPag));
  if Indice >= 0 then
   Result := TECFVin(ECFVinList.Objects[Indice]).ECFIndex;
end;

function TDMPDV.GetBandeira(IDMeioPag: Integer): Integer;
var
  Indice: Integer;
begin
  Result := 0;

  Indice := ECFPagList.IndexOf(IntToStr(IDMeioPag));
  if Indice >= 0 then
   Result := TECFPag(ECFPagList.Objects[Indice]).Bandeira;
end;

function TDMPDV.GetTipoTEF(IDMeioPag: Integer): Integer;
var
  Indice: Integer;
begin
  Result := 0;
  Indice := ECFPagList.IndexOf(IntToStr(IDMeioPag));
  if Indice >= 0 then
   Result := TECFPag(ECFPagList.Objects[Indice]).TipoTEF;
end;


procedure TDMPDV.PreencheFormaPagamento;
var
  I : Integer;
begin
  FormasPagamento.Clear;
  DefaultMeioPag := nil;

  DM.PrepareCDS(cdsMeioPag, 'MeioPag');

  try

    for I:= Low(ATiposPagto) to High(ATiposPagto) do
    begin

      cdsMeioPag.Filtered := False;
      cdsMeioPag.Filter   := Format('Tipo = %D', [I]);
      cdsMeioPag.Filtered := True;

      if not cdsMeioPag.IsEmpty then
        with FormasPagamento.Add(I, ATiposPagto[I]) do
          while not cdsMeioPag.Eof do
          begin
            Add(
              cdsMeioPag.FieldByName('IDMeioPag').AsInteger,
              cdsMeioPag.FieldByName('ImageIndex').AsInteger,
              GetCodFiscal(cdsMeioPag.FieldByName('IDMeioPag').AsInteger),
              Copy(cdsMeioPag.FieldByName('MeioPag').AsString, 1, 16),
              cdsMeioPag.FieldByName('MeioPag').AsString,
              cdsMeioPag.FieldByName('RequireCustomer').AsBoolean,
              cdsMeioPag.FieldByName('ValidateNonpayer').AsBoolean
              );

            if (DefaultMeioPag = nil) and (cdsMeioPag.FieldByName('IDMeioPag').AsInteger = PAY_TYPE_CASH) then
              DefaultMeioPag := MeiosPagamento[Count -1];

            cdsMeioPag.Next;
          end;
    end;
    
  finally
    cdsMeioPag.Filtered := False;
    cdsMeioPag.Filter   := '';
    end;

end;

procedure TDMPDV.DataModuleCreate(Sender: TObject);
var
  sOriginalWhere: String;
begin
  ECFTaxList := TStringList.Create;
  ECFPagList := TStringList.Create;
  ECFVinList := TStringList.Create;
  LoadECFTaxList;
  LoadECFPagList;
  LoadECFVinList;
  AbreTabelas;

  PreencheFormaPagamento;

  FTransferFile := TTransferFile.Create;
  FTransferFile.OnServerStatus := ServerStatus;

  FServerActive := True;

  if DM.PersistenceType = ptTXT then
  begin
    SaveFilesToServer(True);
    FCanTransferFile := True;
    tmrSaveFilesToServer.Interval := DM.fCashRegister.SrvRefreshInSecond * 1000;
    tmrSaveFilesToServer.Enabled := True;
  end;

  if DM.PersistenceType = ptDB then
  begin
    sOriginalWhere := ' M.Desativado = 0 AND M.Hidden = 0 AND  ' +
                       'M.ModelType IN ('+QuotedStr('S')+', '+QuotedStr('R')+', '+QuotedStr('V')+', '+QuotedStr('C')+','+QuotedStr('K')+' ) ' +
                       Format('AND S.IDStore = %D ', [DM.fStore.ID]);
    quModel.CommandText := ChangeWhereClause(quModel.CommandText, sOriginalWhere, True);
  end;

  FSellNegative := DM.fSystem.SrvParam[PARAM_SALEONNEGATIVE];

  //pega a data do arquivo de qty
  if (DM.fCashRegister.BlockNegativeSale) and (DM.PersistenceType = ptTXT) then
    if FileExists(ExtractFilePath(Application.ExeName) + MIRROR_DIR + 'Quantity.xml') then
    begin

      FLastQtyUpdate := FileDateTime(ExtractFilePath(Application.ExeName) + MIRROR_DIR + 'Quantity.xml');

      cdsQtySold.CreateDataSet;
      if FileExists(ExtractFilePath(Application.ExeName) + MIRROR_DIR + 'QtySold.xml') then
      begin
        DM.PrepareCDS(cdsQtySold, 'QtySold', 'IDModel', False);
        cdsQtySold.Filtered := False;
        cdsQtySold.Filter := 'SaleDate < ' + QuotedStr(FormatDateTime('ddddd hh:mm', FLastQtyUpdate));
        cdsQtySold.Filtered := True;
        cdsQtySold.First;
        while not cdsQtySold.EOF do
        begin
          cdsQtySold.Edit;
          cdsQtySold.Delete;
        end;
        cdsQtySold.Filtered := False;
        cdsQtySold.Filter   := '';
      end;
    end;

end;

procedure TDMPDV.ServerStatus(Online : Boolean);
begin
  FServerActive := Online;
end;

function TDMPDV.AddCustomer(Customer: TCustomerInfo): Integer;
begin
  case DM.PersistenceType of
    ptDB:
    begin
      Result := DM.GetNextID(MR_PESSOA_ID);
      // Criar rotina para inserir no Dataset e no texto
      with cmdPessoa do
      begin
         Parameters.ParamByName('IDPessoa').Value         := Result;
         Parameters.ParamByName('IDTipoPessoa').Value     := 1;
         Parameters.ParamByName('IDStore').Value          := DM.fStore.ID;
         Parameters.ParamByName('IDTipoPessoaRoot').Value := 1;
         Parameters.ParamByName('IDUser').Value           := DM.fUser.ID;
         Parameters.ParamByName('Pessoa').Value           := Customer.FirstName + ' ' + Customer.LastName;
         Parameters.ParamByName('PessoaFirstName').Value  := Customer.FirstName;
         Parameters.ParamByName('PessoaLastName').Value   := Customer.LastName;
         Parameters.ParamByName('Endereco').Value         := Customer.Endereco;
         Parameters.ParamByName('Cidade').Value           := Customer.Cidade;
         Parameters.ParamByName('CEP').Value              := Customer.Zip;
         Parameters.ParamByName('Telefone').Value         := Customer.Telefone;
         Parameters.ParamByName('Juridico').Value         := Customer.Juridico;
         Parameters.ParamByName('CPF').Value              := Customer.CPF;
         Parameters.ParamByName('Bairro').Value           := Customer.Bairro;
         Parameters.ParamByName('PhoneAreaCode').Value    := Customer.TelDDD;
         Parameters.ParamByName('CellAreaCode').Value     := Customer.CelDDD;
         Parameters.ParamByName('Cellular').Value         := Customer.Celelular;
         Parameters.ParamByName('Email').Value            := Customer.Email;
         Parameters.ParamByName('HomePage').Value         := Customer.WebSite;
         Parameters.ParamByName('Identidade').Value       := Customer.Identidate;
         Parameters.ParamByName('OrgaoEmissor').Value     := Customer.OrgEmiss;
         if Customer.ExpDate <> 0 then
         Parameters.ParamByName('DataExpedicao').Value    := Customer.ExpDate;
         if Customer.BirthDate <> 0 then
         Parameters.ParamByName('Nascimento').Value       := Customer.BirthDate;
         Parameters.ParamByName('CustomerCard').Value     := Customer.CustCard;
         Parameters.ParamByName('CartMotorista').Value    := Customer.CMotorista;
         Parameters.ParamByName('NomeJuridico').Value     := Customer.NomeJuridico;
         Parameters.ParamByName('InscEstadual').Value     := Customer.InscEstadual;
         Parameters.ParamByName('InscMunicipal').Value    := Customer.InscMunicipal;
         Parameters.ParamByName('Contatos').Value         := Customer.Contato;
         Parameters.ParamByName('OBS').Value              := Customer.OBS;
         Parameters.ParamByName('CreationDate').Value     := Now;

         Execute;
      end;
    end;
    ptTXT:
      Result := 1;
    else
      Result := 1;
  end;
end;

procedure TDMPDV.LoadECFTaxList;
var
  ECFIni: TIniFile;
  stlTax: TStringList;
  ECFTaxTemp: TECFTax;
  I: Integer;
begin
  UnLoadECFTaxList;
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    stlTax := TStringList.Create;
    try
      stlTax.Duplicates         := dupIgnore;
      ECFIni.ReadSection('TAX', stlTax);
      for I := 0 to stlTax.Count - 1 do
      begin
        ECFTaxTemp                := TECFTax.Create;
        ECFTaxTemp.ID             := StrToIntDef(stlTax[I], 0);
        ECFTaxTemp.ECFIndex       := ECFIni.ReadString('TAX', stlTax[I], '');
        ECFTaxList.AddObject(stlTax[I], ECFTaxTemp);
      end;
    finally
      stlTax.Free;
    end;
  finally
    ECFIni.Free;
  end;
end;

procedure TDMPDV.LoadECFVinList;
var
  ECFIni: TIniFile;
  stlVin: TStringList;
  ECFVinTemp: TECFVin;
  I: Integer;
begin
  UnLoadECFVinList;
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    stlVin := TStringList.Create;
    try
      stlVin.Duplicates         := dupIgnore;
      ECFIni.ReadSection('VINC', stlVin);
      for I := 0 to stlVin.Count - 1 do
      begin
        ECFVinTemp          := TECFVin.Create;
        ECFVinTemp.ID       := StrToIntDef(stlVin[I], 0);
        ECFVinTemp.ECFIndex := ECFIni.ReadString('VINC', stlVin[I], '');
        ECFVinList.AddObject(stlVin[I], ECFVinTemp);
      end;
    finally
      stlVin.Free;
    end;
  finally
    ECFIni.Free;
  end;
end;

procedure TDMPDV.LoadECFPagList;
var
  ECFIni: TIniFile;
  stlPag, stlBand: TStringList;
  ECFPagTemp: TECFPag;
  I, idx: Integer;
begin
  UnLoadECFPagList;
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    stlPag := TStringList.Create;
    try
      stlPag.Duplicates         := dupIgnore;
      ECFIni.ReadSection('PAYMENTS', stlPag);
      for I := 0 to stlPag.Count - 1 do
      begin
        ECFPagTemp          := TECFPag.Create;
        ECFPagTemp.ID       := StrToIntDef(stlPag[I], 0);
        ECFPagTemp.ECFIndex := ECFIni.ReadString('PAYMENTS', stlPag[I], '');
        ECFPagTemp.Bandeira := ECFIni.ReadInteger('BANDEIRA', stlPag[I], 0);
        ECFPagList.AddObject(stlPag[I], ECFPagTemp);
      end;

      stlBand := TStringList.Create;
      try
        ECFIni.ReadSection('BANDEIRA', stlBand);
        for I := 0 to stlBand.Count - 1 do
        begin
          idx := stlPag.IndexOf(stlBand[I]);
          if (idx <> -1) then
            ECFPagTemp := TECFPag(stlPag.Objects[idx])
          else
          begin
            ECFPagTemp := TECFPag.Create;
            ECFPagTemp.ID := StrToIntDef(stlBand[I], 0);
            ECFPagList.AddObject(stlBand[I], ECFPagTemp);
          end;
          ECFPagTemp.Bandeira := ECFIni.ReadInteger('BANDEIRA', stlBand[I], 0);
        end;
      finally
        stlBand.Free;
      end;

      LoadECFTEFList(ECFIni);
    finally
      stlPag.Free;
    end;
  finally
    ECFIni.Free;
  end;
end;


procedure TDMPDV.LoadECFTEFList(ECFIni: TIniFile);
var
  stlTipoTEF: TStringList;
  ECFPagTemp: TECFPag;
  I, idx: Integer;
begin
  stlTipoTEF := TStringList.Create;
  try
    ECFIni.ReadSection('TIPOTEF', stlTipoTEF);
    for I := 0 to stlTipoTEF.Count - 1 do
    begin
      idx := ECFPagList.IndexOf(stlTipoTEF[I]);
      if (idx <> -1) then
        ECFPagTemp := TECFPag(ECFPagList.Objects[idx])
      else
      begin
        ECFPagTemp := TECFPag.Create;
        ECFPagTemp.ID := StrToIntDef(stlTipoTEF[I], 0);
        ECFPagList.AddObject(stlTipoTEF[I], ECFPagTemp);
      end;
      ECFPagTemp.TipoTEF := ECFIni.ReadInteger('TIPOTEF', stlTipoTEF[I], 0);
    end;
  finally
    stlTipoTEF.Free;
  end;
end;

procedure TDMPDV.DataModuleDestroy(Sender: TObject);
begin
  UnLoadECFTaxList;
  UnLoadECFPagList;
  UnLoadECFVinList;
  ECFTaxList.Free;
  ECFPagList.Free;
  FTransferFile.Free;
end;

procedure TDMPDV.UnLoadECFTaxList;
var
  I: Integer;
  ECFTaxTemp: TECFTax;
begin
  for I := 0 to ECFTaxList.Count - 1 do
  begin
    ECFTaxTemp := TECFTax(ECFTaxList.Objects[I]);
    FreeAndNil(ECFTaxTemp);
  end;
  ECFTaxList.Clear;
end;

procedure TDMPDV.UnLoadECFPagList;
var
  I: Integer;
  ECFVinTemp: TECFVin;
begin
  for I := 0 to ECFVinList.Count - 1 do
  begin
    ECFVinTemp := TECFVin(ECFVinList.Objects[I]);
    FreeAndNil(ECFVinTemp);
  end;
  ECFVinList.Clear;
end;

procedure TDMPDV.UnLoadECFVinList;
var
  I: Integer;
  ECFVinTemp: TECFVin;
begin
  for I := 0 to ECFVinList.Count - 1 do
  begin
    ECFVinTemp := TECFVin(ECFVinList.Objects[I]);
    FreeAndNil(ECFVinTemp);
  end;
  ECFVinList.Clear;
end;


procedure TDMPDV.SetECFTaxIndex(IDTaxCategory: Integer; Value: String);
var
  ECFIni: TIniFile;
begin
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    ECFIni.WriteString('TAX', IntToStr(IDTaxCategory), Value);
  finally
    ECFIni.Free;
  end;
end;

procedure TDMPDV.SetECFBandeira(IDMeioPag: Integer; Value: Integer);
var
  ECFIni: TIniFile;
begin
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    ECFIni.WriteInteger('BANDEIRA', IntToStr(IDMeioPag), Value);
  finally
    ECFIni.Free;
  end;
end;

procedure TDMPDV.SetECFCodFiscal(IDMeioPag: Integer; Value: String);
var
  ECFIni: TIniFile;
begin
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    ECFIni.WriteString('PAYMENTS', IntToStr(IDMeioPag), Value);
  finally
    ECFIni.Free;
  end;
end;

procedure TDMPDV.SetECFVinIndex(IDMeioPag: Integer; Value: String);
var
  ECFIni: TIniFile;
begin
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    ECFIni.WriteString('VINC', IntToStr(IDMeioPag), Value);
  finally
    ECFIni.Free;
  end;
end;

procedure TDMPDV.SetECFTipoTEF(IDMeioPag, Value: Integer);
var
  ECFIni: TIniFile;
begin
  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    ECFIni.WriteInteger('TIPOTEF', IntToStr(IDMeioPag), Value);
  finally
    ECFIni.Free;
  end;
end;


procedure TDMPDV.cdsModelCalcFields(DataSet: TDataSet);
begin

  if cdsModel.FieldByName('InvSellingPriceI').AsCurrency <> 0 then
  begin
     cdsModel.FieldByName('SellingPrice').AsCurrency := cdsModel.FieldByName('InvSellingPriceI').AsCurrency;
     cdsModel.FieldByName('InvSellingPrice').AsCurrency := cdsModel.FieldByName('InvSellingPriceI').AsCurrency;
  end
  else
  begin
     cdsModel.FieldByName('SellingPrice').AsCurrency := cdsModel.FieldByName('InvSellingPriceM').AsCurrency;
     cdsModel.FieldByName('InvSellingPrice').AsCurrency := cdsModel.FieldByName('InvSellingPriceM').AsCurrency
  end;

  if cdsModel.FieldByName('VendorCostI').AsCurrency <> 0 then
    cdsModel.FieldByName('VendorCost').AsCurrency := cdsModel.FieldByName('VendorCostI').AsCurrency
  else
    cdsModel.FieldByName('VendorCost').AsCurrency := cdsModel.FieldByName('VendorCostM').AsCurrency;


  case cdsModelSituacaoTributaria.AsInteger of
    0,1 : cdsModelDescSituTribut.AsString := 'Tributável';
    2 : cdsModelDescSituTribut.AsString := 'Não Tributável';
    3 : cdsModelDescSituTribut.AsString := 'Substit. Tributária';
    4 : cdsModelDescSituTribut.AsString := 'Isento';
    5 : cdsModelDescSituTribut.AsString := 'ISS';
  end;

end;

procedure TDMPDV.cdsMDescriptionCalcFields(DataSet: TDataSet);
begin

  if cdsMDescription.FieldByName('InvSellingPriceI').AsCurrency <> 0 then
  begin
     cdsMDescription.FieldByName('SellingPrice').AsCurrency := cdsMDescription.FieldByName('InvSellingPriceI').AsCurrency;
     cdsMDescription.FieldByName('InvSellingPrice').AsCurrency := cdsMDescription.FieldByName('InvSellingPriceI').AsCurrency;
  end
  else
  begin
     cdsMDescription.FieldByName('SellingPrice').AsCurrency := cdsMDescription.FieldByName('InvSellingPriceM').AsCurrency;
     cdsMDescription.FieldByName('InvSellingPrice').AsCurrency := cdsMDescription.FieldByName('InvSellingPriceM').AsCurrency
  end;

  if cdsMDescription.FieldByName('VendorCostI').AsCurrency <> 0 then
    cdsMDescription.FieldByName('VendorCost').AsCurrency := cdsMDescription.FieldByName('VendorCostI').AsCurrency
  else
    cdsMDescription.FieldByName('VendorCost').AsCurrency := cdsMDescription.FieldByName('VendorCostM').AsCurrency;

  case cdsMDescriptionSituacaoTributaria.AsInteger of
    0,1 : cdsMDescriptionDescSituTribut.AsString := 'Tributável';
    2 : cdsMDescriptionDescSituTribut.AsString := 'Não Tributável';
    3 : cdsMDescriptionDescSituTribut.AsString := 'Substit. Tributária';
    4 : cdsMDescriptionDescSituTribut.AsString := 'Isento';
    5 : cdsMDescriptionDescSituTribut.AsString := 'ISS';
  end;

end;

procedure TDMPDV.cdsMDescriptionBeforeOpen(DataSet: TDataSet);
begin
  if DM.PersistenceType = ptDB then
    cdsMDescription.Params.ParamByName('IDStore').Value := DM.fStore.ID;
end;

procedure TDMPDV.cdsModelAccessoryBeforeOpen(DataSet: TDataSet);
begin
  if DM.PersistenceType = ptDB then
    cdsModelAccessory.Params.ParamByName('IDStore').Value := DM.fStore.ID;
end;

procedure TDMPDV.CloseSuggestions;
begin
  if DM.PersistenceType = ptDB then
    with cdsModelAccessory do
       if Active then
          Close;
end;

procedure TDMPDV.OpenSuggestions(IDModel: Integer);
begin
  with cdsModelAccessory do
  begin
    case DM.PersistenceType of
    ptDB:
      begin
       if not Active then
          begin
          cdsModelAccessory.Params.ParamByName('IDModel').Value := IDModel;
          Open;
          end;
      end;
    ptTXT:
      begin
       cdsModelAccessory.Filtered := False;
       cdsModelAccessory.Filter   := Format('IDModel = %D', [IDModel]);
       cdsModelAccessory.Filtered := True;
      end;
    end;
  end;
end;

procedure TDMPDV.CloseInvSerial;
begin
  with cdsInvSerial do
  begin
    case DM.PersistenceType of
    ptDB:
      begin
       if Active then
          Close;
      end;
    ptTXT:
      begin
       Filtered := False;
       Filter   := '';
      end;
    end;
  end;
end;

procedure TDMPDV.OpenInvSerial(IDModel: Integer);
begin

  with cdsInvSerial do
  begin
    case DM.PersistenceType of
    ptDB:
      begin
       if not Active then
          begin
          Params.ParamByName('ModelID').Value := IDModel;
          Open;
          end;
      end;
    ptTXT:
      begin
       Filtered := False;
       Filter   := Format('ModelID = %D AND StoreID = %D', [IDModel, DM.fStore.ID]);
       Filtered := True;
      end;
    end;
  end;
end;

procedure TDMPDV.AbreTabelas;
begin

  if DM.PersistenceType = ptDB then
     Exit;

  with TFrmImport.Create(Self) do
      UpdatePOS;

end;

procedure TDMPDV.CloseQuantity;
begin
  if DM.PersistenceType = ptDB then
    with cdsQty do
       if Active then
          Close;
end;

procedure TDMPDV.OpenQuantity(IDModel: Integer; AFilter : String);
begin
  with cdsQty do
  begin
    FetchParams;

    if not Active then
    begin
      if DM.PersistenceType = ptDB then
        Params.ParambyName('ModelID').Value := IDModel;
      DM.PrepareCDS(cdsQty, 'Quantity', 'Name', True);
    end;

    Filtered := False;
    Filter   := Format('IDModel = %D', [IDModel]);
    if AFilter <> '' then
      Filter := Filter + ' AND ' + AFilter;

    Filtered := True;

  end;

end;

procedure TDMPDV.InitGlobalTXT;
begin

  if (DM.PersistenceType = ptTXT) and (DM.fCashRegister.RefreshGlobal<>0) then
     begin
     tmLoadGlobal.Interval := DM.fCashRegister.RefreshGlobal*60000;
     tmLoadGlobal.Enabled  := True;
     end;

end;

procedure TDMPDV.tmLoadGlobalTimer(Sender: TObject);
begin
  {
  with TFrmImport.Create(Self) do
      UpdatePOS;
  }
end;

function TDMPDV.TestInvoiceDiscRange(AIDCommissionType: Integer; AInvoiceValue, ADiscount: Currency): Boolean;
begin
  try
    if DM.PersistenceType = ptDB then
       cdsDiscRange.Open;

    cdsDiscRange.Filtered := False;
    if cdsDiscRange.IsEmpty then
    begin
      Result := True;
      Exit;
    end;


    cdsDiscRange.Filter   := Format('IDTipoComissionado = %D and TotVendaMin <= %9.2f', [AIDCommissionType, AInvoiceValue]);
    cdsDiscRange.Filtered := True;

    cdsDiscRange.Last;

    Result := cdsDiscRangePercDiscMax.AsCurrency >= ADiscount;

  finally
    cdsDiscRange.Filter   := '';
    cdsDiscRange.Filtered := False;
    if DM.PersistenceType = ptDB then
      cdsDiscRange.Close;
  end;
end;

function TDMPDV.SelectModelDepartment(const AIDModel: Integer; var AIDDepartment: Integer): Boolean;
begin
  try
    try
      if DM.PersistenceType = ptDB then
        cdsInvModelDepartment.Open;

      cdsInvModelDepartment.Filter   := Format('ModelID = %D', [AIDModel]);
      cdsInvModelDepartment.Filtered := True;

      if cdsInvModelDepartment.IsEmpty then
        Result := True
      else
        if cdsInvModelDepartment.RecordCount = 1 then
          begin
            AIDDepartment := cdsInvModelDepartmentIDDepartment.AsInteger;
            Result := True;
          end
        else
          begin
            with TFrmAskDepartment.Create(self) do
            try
              Result := Start(AIDDepartment);
            finally
              Free;
            end;
          end;
    finally
      cdsInvModelDepartment.Filter   := '';
      cdsInvModelDepartment.Filtered := False;

      if DM.PersistenceType = ptDB then
        cdsInvModelDepartment.Close;
    end;
  except
    Result := False;
  end;
end;

procedure TDMPDV.SaveFilesToServer(AllLastFiles: Boolean = False);
begin
  if DM.PersistenceType = ptTXT then
  begin
    FTransferFile.RemoteWorkingDir := DM.fCashRegister.RemoteWorkingDir;
    FTransferFile.LocalWorkingDir := DM.fCashRegister.LocalWorkingDir;

    if AllLastFiles then
    begin
      if DM.fCashRegister.RecentClosedCash <> '' then
        FTransferFile.FileList := DM.fCashRegister.RecentClosedCash + ';' + DM.fCashRegister.LastSalesFiles
      else
        FTransferFile.FileList := DM.fCashRegister.LastSalesFiles
    end
    else
      FTransferFile.FileList := DM.fCashRegister.SalesFileName;

    FTransferFile.IDCashReg := DM.fCashRegister.IDDefault;

    FTransferFile.Execute;
  end;
end;

procedure TDMPDV.tmrSaveFilesToServerTimer(Sender: TObject);
begin
  if FCanTransferFile then
    SaveFilesToServer;
end;

procedure TDMPDV.cdsInvSerialBeforeOpen(DataSet: TDataSet);
begin
  if DM.PersistenceType = ptDB then
    cdsInvSerial.Params.ParamByName('StoreID').Value := DM.fStore.ID;
end;

procedure TDMPDV.CloseTablePrice;
begin
  case DM.PersistenceType of
    ptDB:
    begin
      if cdsStoreTablePrice.Active then
        cdsStoreTablePrice.Close;

      if cdsModelTablePrice.Active then
        cdsModelTablePrice.Close;
    end;

    ptTXT:
    begin
      cdsStoreTablePrice.Filtered := False;
      cdsStoreTablePrice.Filter   := '';

      cdsModelTablePrice.Filtered := False;
      cdsModelTablePrice.Filter   := '';
    end;
  end;
end;

procedure TDMPDV.OpenTablePrice(IDStore, IDModel: Integer);
begin
  case DM.PersistenceType of
    ptDB:
    begin
      if not cdsStoreTablePrice.Active then
      begin
        cdsStoreTablePrice.FetchParams;
        cdsStoreTablePrice.Params.ParamByName('IDStore').Value := IDStore;
        cdsStoreTablePrice.Params.ParamByName('IDModel').Value := IDModel;
        cdsStoreTablePrice.Open;
      end;
      if not cdsModelTablePrice.Active then
      begin
        cdsModelTablePrice.FetchParams;
        cdsModelTablePrice.Params.ParamByName('IDModel').Value := IDModel;
        cdsModelTablePrice.Open;
      end;
    end;

    ptTXT:
    begin
      cdsStoreTablePrice.Filtered := False;
      cdsStoreTablePrice.Filter   := Format('IDStore = %D AND IDModel = %D', [IDStore, IDModel]);
      cdsStoreTablePrice.Filtered := True;

      cdsModelTablePrice.Filtered := False;
      cdsModelTablePrice.Filter   := Format('IDModel = %D', [IDModel]);
      cdsModelTablePrice.Filtered := True;
    end;
  end;
end;

function TDMPDV.GetTotalCashInRegister: Currency;
begin
  Result := DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED];
end;

function TDMPDV.GetTotalCashSale(IDCashRegMov : Integer): Currency;
begin
  Result := DM.fPOS.GetTotalCashWithdraw(IDCashRegMov)
end;

function TDMPDV.IsMinPayValue(AIDPaymentType: Integer; AValue: Real): boolean;
begin
  Result := True;

  with cdsMeioPagMinSale do
  try
    Filtered := False;
    Filter := 'IDMeioPag = ' + IntToStr(AIDPaymentType);
    Filtered := True;
    if not IsEmpty then
      Result := AValue >= FieldByName('TotalSale').AsCurrency;
  finally
    Filtered := False;
  end;
end;

function TDMPDV.AjustaPreco(Qtde, PrecoBalanca, PrecoUnit: real): Real;
var
  PrecoECF, QtdeECF: real;
  sQTD: String;
begin
  sQTD := FormatFloat('0000.000', Qtde);

  QtdeECF := TruncarDecimal(StrToFloat(sQTD), 3);
  Qtde := TruncarDecimal(Qtde, 3);

  if QtdeECF <> Qtde then
    PrecoECF := QtdeECF * PrecoUnit
  else
    PrecoECF := Qtde * PrecoUnit;

  PrecoECF := TruncarDecimal(PrecoECF, 2);

  if PrecoBalanca <> PrecoECF then
    Result := PrecoECF
    else
    Result := PrecoBalanca;
end;

function TDMPDV.TruncarDecimal(Valor: Real; Decimal: integer): Double;
var
  aux: string;
  bNeg : Boolean;
begin

  bNeg := False;

  if Valor < 0 then
    bNeg := True;

  valor := Abs(valor);
  valor := valor * 100000;
  aux := FormatFloat('00000000000000000000',valor);
  aux := copy( aux, 1, 15) + copy( aux, 16, Decimal);
  case Decimal of
    2: valor := strToFloat(aux) / 100;
    3: valor := strToFloat(aux) / 1000;
    4: valor := strToFloat(aux) / 10000;
    5: valor := strToFloat(aux) / 100000;
  end;

  if bNeg then
    valor := valor * -1;
  
  result := Valor;

end;

function TDMPDV.GetTotalizadorParcial(IDTaxCategory: Integer): String;
var
  Indice: Integer;
begin
  Result := '';

  if DM.fCashRegister.GeneratePAFSintegra then
  begin
    Indice := ECFTaxList.IndexOf(IntToStr(IDTaxCategory));
    if Indice >= 0 then
    begin
     if TECFTax(ECFTaxList.Objects[Indice]).ECFTotalizador = '' then
       TECFTax(ECFTaxList.Objects[Indice]).ECFTotalizador := GetECFTotParcial(Trim(TECFTax(ECFTaxList.Objects[Indice]).ECFIndex));
     Result := Trim(TECFTax(ECFTaxList.Objects[Indice]).ECFTotalizador);
    end;
  end;
  
end;

function TDMPDV.GetECFTotParcial(Aliquota: String): String;
var
  sAliquotas, sTemp, sTax : String;
  i, iPosIni, iPosEnd, iCopy : Integer;
begin

  //PAF
  sAliquotas := '';

  iPosIni := 1;
  iPosEnd := 4;
  iCopy   := 5;
  sTax    := '0000';

  if DM.fPrintReceipt.ECFPrinterName = 'DarumaTermica' then
  begin
    iPosIni := 2;
    iPosEnd := 5;
    iCopy   := 6;
    sTax    := '00000';
  end;

  if Copy(Aliquota,1,1)[1] in ['I', 'F', 'N'] then
    Result := Aliquota
  else
  begin
      sAliquotas := DM.fModuloFiscal.TotParciais;

      i := 0;
      while Length(sAliquotas) > 0 do
      begin
        sTemp := Copy(sAliquotas, 1, iPosEnd);
        if (sTemp <> sTax) then
        begin
          if Length(Aliquota) = 4 then
          begin
            if Aliquota = Copy(sTemp, iPosIni, iPosEnd) then
            begin
              Result := FormatFloat('00', i+1) + 'T' + Aliquota;
              Exit;
            end;
          end
          else if StrToInt(Aliquota) = i+1 then
          begin
            Result := FormatFloat('00',i+1) + 'T' + Copy(sTemp, iPosIni, iPosEnd);
            Exit;
          end;

          inc(i);
        end
        else
          Break;
        sAliquotas := Copy(sAliquotas, iCopy, Length(sAliquotas));
      end;

  end;

end;

procedure TDMPDV.AddQtySold(AIDModel: Integer; AQty: Double);
begin
  if DM.fCashRegister.BlockNegativeSale and (DM.PersistenceType = ptTXT) then
  begin
    cdsQtySold.Append;
    cdsQtySoldIDModel.AsInteger   := AIDModel;
    cdsQtySoldQty.AsFloat         := AQty;
    cdsQtySoldSaleDate.AsDateTime := Now;
    cdsQtySold.Post;
  end;
end;

procedure TDMPDV.SaveQtySold;
begin
  if DM.fCashRegister.BlockNegativeSale and (DM.PersistenceType = ptTXT) then
    cdsQtySold.SaveToFile(ExtractFilePath(Application.ExeName) + MIRROR_DIR + 'QtySold.xml');
end;

function TDMPDV.GetQtySold(AIDModel: Integer): Double;
begin

  Result := 0;

  if DM.fCashRegister.BlockNegativeSale and (DM.PersistenceType = ptTXT) then
  begin
    with cdsQtySold do
    begin
      Filtered := False;
      Filter   := Format('IDModel = %D', [AIDModel]);
      Filtered := True;
      First;
      while not EOF do
      begin
        Result := Result + cdsQtySoldQty.AsFloat;
        Next;
      end;
      Filtered := False;
      Filter   := '';
    end;

  end;
end;

end.
