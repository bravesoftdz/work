unit uDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMParent, ADODB, DB, uSystemObj, uUserObj, uFrmPOSFunctions,
  Registry, uPrint, ufrmServerInfo, PowerADOQuery, LookUpADOQuery,
  uHandleError, uSystemTypes, EFiscal, uTefDial, IniFiles, DBClient,
  uFilePersistence, Provider, uTXTCashInfo, ShellAPI, uMRTraceControl,
  uTefDedicado, uTefConsts, uTEFTypes, uFrmMsgScroll, uInvoicePollDisplay,
  uFrmWait;

const
   DELETE_LOG_DAYS    = 7;
   DELETE_LOG_SIZE_MB = 2;

   CASH_HOMOLOG = 'v1.6';
   CASH_VERSION = 'v1.6.95';
   POS_DIR      = 'POSSales\';
   SERVER_DIR   = 'PDVFiles\';

   MIRROR_DIR   = 'PDVFiles\';

   REGISTRY_PATH_POS = 'SOFTWARE\Applenet\POS';

   DISPLAY_MODEL       = 0;
   DISPLAY_DESCRIPTION = 1;
   DISPLAY_MODEL_DESC  = 2;

   ECF_CONFIGS = 'ECF.ini';

   FISCAL_PRINTERS = 'Impressoras';
   FISCAL_GRANDETOTAL = 'GT';

type
  TPersistenceType = (ptDB, ptTXT);

  TSrvParam = Array of Variant;

  TStore = Class
  private
    fID        : Integer;
    fIDDefault : Integer;
    fStoreHour : Integer;
    fStoreList : String;
    fName      : String;
    procedure setStoreHour(iIDStore:Integer);
  public
    property ID        : Integer read fID        write fID;
    property IDDefault : Integer read fIDDefault write fIDDefault;
    property StoreHour : Integer read fStoreHour write setStoreHour;
    property StoreList : String  read fStoreList write fStoreList;
    property Name      : String  read fName      write fName;
  end;

  TPollDisplay = class
    FIP : String;
    FPort : Integer;
    FClearSale : Boolean;
  end;

  //Object instantiated from uUserObj
  TMRUser = Class(TUser)
  private
    fIDCommission     : Integer;
    fIDCommissionType : Integer;
    function Manager:Boolean;
    function AssistManager:Boolean;
  public
    property IDCommission     : Integer read fIDCommission     write fIDCommission;
    property IDCommissionType : Integer read fIDCommissionType write fIDCommissionType;
    property IsManager        : Boolean read Manager;
    property IsAssistManager  : Boolean read AssistManager;
  end;

  TCupomFiscal = class
  private
    FCOO: Integer;
    FGNF: Integer;
    FCCF: String;
    FCDC: Integer;
    FDataHora: TDateTime;
  public
    property CCF      : String    read FCCF      write FCCF;
    property DataHora : TDateTime read FDataHora write FDataHora;
    property COO      : Integer   read FCOO      write FCOO;
    property GNF      : Integer   read FGNF      write FGNF;
    property CDC      : Integer   read FCDC      write FCDC;
  end;

  TModuloFiscal = class
  private
    FInvoiceDiscount: Boolean;
    FDecimal:         Char;
    FCGC:             String;
    FPDVImage:        String;
    FECFSerial:       String;
    FPrinterDate: TDateTime;
    FTotParciais: String;
    FLeituraDataMFD: TDateTime;
    FNumeroUsuarioECF: Integer;
    FMarcaECF: String;
    FTipoECF: String;
    FModeloECF: String;
    FMFAdicional: String;
    FDataInstalECF: TDateTime;
    FDataEmissaoECF: TDateTime;
    FNumeroECF: Integer;
    FVersaoSBECF: String;
    FNumeroLoja: Integer;
    function CopareDate15min(ADate1, ADate2: TDateTime): Boolean;
  public
    property CGC:             String    read FCGC              write FCGC;
    property Decimal:         Char      read FDecimal          write FDecimal;
    property InvoiceDiscount: Boolean   read FInvoiceDiscount  write FInvoiceDiscount;
    property PDVImage:        String    read FPDVImage         write FPDVImage;
    property ECFSerial:       String    read FECFSerial        write FECFSerial;
    property PrinterDate:     TDateTime read FPrinterDate      write FPrinterDate;
    property TotParciais:     String    read FTotParciais      write FTotParciais;
    property LeituraDataMFD:  TDateTime read FLeituraDataMFD   write FLeituraDataMFD;
    property TipoECF:         String    read FTipoECF          write FTipoECF;
    property MarcaECF:        String    read FMarcaECF         write FMarcaECF;
    property ModeloECF:       String    read FModeloECF        write FModeloECF;
    property DataInstalECF:   TDateTime read FDataInstalECF    write FDataInstalECF;
    property MFAdicional:     String    read FMFAdicional      write FMFAdicional;
    property NumeroUsuarioECF:Integer   read FNumeroUsuarioECF write FNumeroUsuarioECF;
    property NumeroECF:       Integer   read FNumeroECF        write FNumeroECF;
    property VersaoSBECF:     String    read FVersaoSBECF      write FVersaoSBECF;
    property NumeroLoja:      Integer   read FNumeroLoja       write FNumeroLoja;

    function ValidateSystemDate: Boolean;
  end;

  TCashRegister = Class
  private
    fIDDefault          : Integer;
    fIDMedia            : Integer;
    fOpen               : Boolean;
    fOpenCod            : String;
    fName               : String;
    fGeneratePAFSintegra: Boolean;
    fUseTef             : Integer; // Uso do TEF 0-Desabilitado
    MyReg               : TRegistry;
    fMainRetail         : String;
    FSalesFileName      : String;
    FLastSalesFiles     : String;
    FAskSalesPerson     : Boolean;
    FKeepSalesPerson    : Boolean;
    fShowShortCut       : Boolean;
    fRefreshGlobal      : Integer;
    fRecentClosedCash   : String;
    fDisplayType        : Integer;
    FComComitt          : Boolean;
    FServerFilesDir     : String;
    FLocalWorkingDir    : String;
    FRemoteWorkingDir   : String;
    FSalesFilesToExp    : Integer;
    FAfterPrintCode     : String;
    FSrvRefreshInSecond : Integer;
    FTEFDedCodLoja      : String;
    FTEFDedIPServer     : String;
    FTEFDedNumTerminal  : String;
    FTEFDedMsgOp        : String;
    FSellDrawerClosed   : Boolean;
    FPOSScaleCheck      : Boolean;
    FBarcodeScaleCheck  : Boolean;
    FScaleModel         : String;
    FScaleCommunicationType: Integer;
    FScaleSerialPort    : String;
    FScaleIPEthernet    : String;
    FScalePortEthernet  : String;
    FScaleBaudRate      : Integer;
    FScaleDecimal       : Integer;
    FBarcodeScaleType   : Integer;
    FPOSScaleType       : Integer;
    FMsgAfterCloseReg   : String;
    FAskCPF             : Boolean;
    FBlockNegativeSale  : Boolean;
    FValidateCPF        : Boolean;
    FHideOtherStoreQry  : Boolean;
    fFiscal             : Boolean;
    fFiscalPrinter      : Boolean;
    FMaxAmountAskPrice  : Currency;
    procedure SetSalesFileName(const Value: String);
    function GetFiscal: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property IDDefault            : Integer   read fIDDefault           write fIDDefault;
    property IDMedia              : Integer   read fIDMedia             write fIDMedia;
    property Open                 : Boolean   read fOpen                write fOpen;
    property OpenCod              : String    read fOpenCod             write fOpenCod;
    property Name                 : String    read fName                write fName;
    property Fiscal               : Boolean   read GetFiscal            write fFiscal;
    property FiscalPrinter        : Boolean   read fFiscalPrinter       write fFiscalPrinter;
    property GeneratePAFSintegra  : Boolean   read fGeneratePAFSintegra write fGeneratePAFSintegra;
    property UseTef               : Integer   read fUseTef           write fUseTef;
    property SalesFilesToExp      : Integer   read FSalesFilesToExp  write FSalesFilesToExp;
    property SalesFileName        : String    read FSalesFileName    write SetSalesFileName;
    property LastSalesFiles       : String    read FLastSalesFiles   write FLastSalesFiles;
    property LocalWorkingDir      : String    read FLocalWorkingDir  write FLocalWorkingDir;
    property RemoteWorkingDir     : String    read FRemoteWorkingDir write FRemoteWorkingDir;
    property ServerFilesDir       : String    read FServerFilesDir   write FServerFilesDir;
    property AskSalesPerson       : Boolean   read FAskSalesPerson   write FAskSalesPerson;
    property KeepSalesPerson      : Boolean   read FKeepSalesPerson  write FKeepSalesPerson;
    property ShowShortCut         : Boolean   read fShowShortCut     write fShowShortCut;
    property MainRetail           : String    read fMainRetail       write fMainRetail;
    property RefreshGlobal        : Integer   read fRefreshGlobal    write fRefreshGlobal;
    property DisplayType          : Integer   read fDisplayType      write fDisplayType;
    property RecentClosedCash     : String    read fRecentClosedCash write fRecentClosedCash;
    property ComComitt            : Boolean   read FComComitt        write FComComitt;
    property AfterPrintCode       : String    read FAfterPrintCode   write FAfterPrintCode;
    property SrvRefreshInSecond   : Integer   read FSrvRefreshInSecond write FSrvRefreshInSecond;
    property TEFDedCodLoja        : String    read FTEFDedCodLoja     write FTEFDedCodLoja;
    property TEFDedIPServer       : String    read FTEFDedIPServer    write FTEFDedIPServer;
    property TEFDedNumTerminal    : String    read FTEFDedNumTerminal write FTEFDedNumTerminal;
    property TEFDedMsgOp          : String    read FTEFDedMsgOp       write FTEFDedMsgOp;
    property SellDrawerClosed     : Boolean   read FSellDrawerClosed  write FSellDrawerClosed;
    property POSScaleCheck        : Boolean   read FPOSScaleCheck     write FPOSScaleCheck;
    property BarcodeScaleCheck    : Boolean   read FBarcodeScaleCheck write FBarcodeScaleCheck;
    property ScaleModel           : String    read FScaleModel        write FScaleModel;
    property ScaleCommunicationType : Integer read FScaleCommunicationType write FScaleCommunicationType;
    property ScaleSerialPort      : String    read FScaleSerialPort   write FScaleSerialPort;
    property ScaleBaudRate        : Integer   read FScaleBaudRate     write FScaleBaudRate;
    property ScaleIPEthernet      : String    read FScaleIPEthernet   write FScaleIPEthernet;
    property ScalePortEthernet    : String    read FScalePortEthernet write FScalePortEthernet;
    property ScaleDecimal         : Integer   read FScaleDecimal      write FScaleDecimal;
    property BarcodeScaleType     : Integer   read FBarcodeScaleType  write FBarcodeScaleType;
    property POSScaleType         : Integer   read FPOSScaleType      write FPOSScaleType;
    property MsgAfterCloseReg     : String    read FMsgAfterCloseReg  write FMsgAfterCloseReg;
    property AskCPF               : Boolean   read FAskCPF            write FAskCPF;
    property BlockNegativeSale    : Boolean   read FBlockNegativeSale write FBlockNegativeSale;
    property ValidateCPF          : Boolean   read FValidateCPF       write FValidateCPF;
    property HideOtherStoreQry    : Boolean   read FHideOtherStoreQry write FHideOtherStoreQry;
    property MaxAmountAskPrice    : Currency  read FMaxAmountAskPrice write FMaxAmountAskPrice;
  end;

  TMRPrintReceipt = Class
  private
    fPrintReceipt     : Boolean;
    fPrintCheck       : Boolean;
    fPrinterType      : Integer;
    fPrinterFontSize  : Integer;
    fPrinterLineSpace : Integer;
    fPrinterLineWidth : Integer;
    fPrinterPort      : String;
    fECFPrinterName   : String;
    fPrinterFontName  : String;
    fECFRodape        : String;
  public
    property PrintReceipt     : Boolean read fPrintReceipt     write fPrintReceipt;
    property PrintCheck       : Boolean read fPrintCheck       write fPrintCheck;
    property PrinterType      : Integer read fPrinterType      write fPrinterType;
    property PrinterFontSize  : Integer read fPrinterFontSize  write fPrinterFontSize;
    property PrinterPort      : String  read fPrinterPort      write fPrinterPort;
    property ECFPrinterName   : String  read fECFPrinterName   write fECFPrinterName;
    property PrinterFontName  : String  read fPrinterFontName  write fPrinterFontName;
    property PrinterLineSpace : Integer read fPrinterLineSpace write fPrinterLineSpace;
    property PrinterLineWidth : Integer read fPrinterLineWidth write fPrinterLineWidth;
    property ECFRodape        : String  read fECFRodape        write fECFRodape;
  end;

  TMRInvoice = class
  private
    fXpressSaleType  : integer;
    fXpressSaleImage : String;
    fOBSText         : String;
  public
    property XpressSaleType  : Integer read fXpressSaleType  write fXpressSaleType;
    property XpressSaleImage : String  read fXpressSaleImage write fXpressSaleImage;
    property OBSText         : String  read fOBSText         write fOBSText;
  end;

  //Object instantiated from uSystemObj
  TMRSystem = Class(TSystem)
  private
    fSrvParam : TSrvParam;
    function ConvertParam(SrvValue, SrvType : String) : Variant;
  public
    property SrvParam : TSrvParam read fSrvParam       write fSrvParam;
  end;

  TPOSImportTXTFiles = class
  private
    fCanUpdate      : Boolean;
    fLastImportDate : TDateTime;
  public
    property LastImportDate : TDateTime read fLastImportDate write fLastImportDate;
    property CanUpdate      : Boolean   read fCanUpdate      write fCanUpdate;
  end;

  TMRPOSColor = Class
  private
    fPOSBackgroundColor : TColor;
    fPOSReturnColor     : TColor;
    fPOSValuesColor     : TColor;
    fPOSTextColor       : TColor;
    fPOSBarcodeTextColor: TColor;
  public
    property POSBackgroundColor  : TColor  read fPOSBackgroundColor  write fPOSBackgroundColor;
    property POSReturnColor      : TColor  read fPOSReturnColor      write fPOSReturnColor;
    property POSValuesColor      : TColor  read fPOSValuesColor      write fPOSValuesColor;
    property POSTextColor        : TColor  read fPOSTextColor        write fPOSTextColor;
    property POSBarcodeTextColor : TColor  read fPOSBarcodeTextColor write fPOSBarcodeTextColor;
  end;


  TDM = class(TDMParent)
    quSrvParam: TADOQuery;
    quSrvParamSrvParameter: TStringField;
    quSrvParamSrvValue: TStringField;
    quSrvParamSrvType: TStringField;
    quSrvParamDescription: TStringField;
    quSrvParamDefaultValue: TStringField;
    dsLookUpUser: TDataSource;
    LookUpUser: TLookUpADOQuery;
    LookUpUserIDUser: TIntegerField;
    LookUpUserSystemUser: TStringField;
    LookUpSalesPerson: TLookUpADOQuery;
    LookUpSalesPersonIDPessoa: TIntegerField;
    LookUpSalesPersonIDComissionado: TIntegerField;
    LookUpSalesPersonCode: TIntegerField;
    LookUpSalesPersonPessoa: TStringField;
    dsLookUpSalesPerson: TDataSource;
    quAccess: TADOQuery;
    quAccessCanAccess: TBooleanField;
    LookUpModel: TLookUpADOQuery;
    LookUpModelModel: TStringField;
    LookUpModelIDModel: TIntegerField;
    LookUpModelDescription: TStringField;
    dsLookUpModel: TDataSource;
    LookUpMeioPag: TLookUpADOQuery;
    LookUpMeioPagIDMeioPag: TIntegerField;
    LookUpMeioPagMeioPag: TStringField;
    dsLookUpMeioPag: TDataSource;
    quLookUpStore: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    dsLookUpStore: TDataSource;
    spCheckOpenCash: TADOStoredProc;
    LookUpMedia: TLookUpADOQuery;
    LookUpMediaIDMedia: TIntegerField;
    LookUpMediaMedia: TStringField;
    dsLookUpMedia: TDataSource;
    dsLookUpCustomer: TDataSource;
    LookUpCustomer: TLookUpADOQuery;
    LookUpCustomerIDPessoa: TIntegerField;
    LookUpCustomerIDComissionado: TIntegerField;
    LookUpCustomerCode: TIntegerField;
    LookUpCustomerPessoa: TStringField;
    dsLookUpTipoCliente: TDataSource;
    LookUpTipoCliente: TLookUpADOQuery;
    LookUpTipoClienteIDTipoCliente: TIntegerField;
    LookUpTipoClientePathName: TStringField;
    LookUpTipoPessoa: TLookUpADOQuery;
    LookUpTipoPessoaIDTipoPessoa: TIntegerField;
    LookUpTipoPessoaPathName: TStringField;
    LookUpTipoPessoaPath: TStringField;
    dsLookUpTipoPessoa: TDataSource;
    dsLookUpEstado: TDataSource;
    LookUpEstado: TLookUpADOQuery;
    LookUpEstadoIDEstado: TStringField;
    LookUpEstadoEstado: TStringField;
    dsLookUpPais: TDataSource;
    LookUpPais: TLookUpADOQuery;
    LookUpPaisIDPais: TIntegerField;
    LookUpPaisCodPais: TStringField;
    LookUpPaisPais: TStringField;
    dsLookUpCashReg: TDataSource;
    LookUpCashReg: TLookUpADOQuery;
    LookUpCashRegIDCashRegister: TIntegerField;
    LookUpCashRegName: TStringField;
    dsLookUpDeliverType: TDataSource;
    LookUpDeliverType: TLookUpADOQuery;
    LookUpDeliverTypeIDDeliverType: TIntegerField;
    LookUpDeliverTypeName: TStringField;
    dsLookUpOther: TDataSource;
    LookUpOther: TLookUpADOQuery;
    LookUpOtherIDPessoa: TIntegerField;
    LookUpOtherIDComissionado: TIntegerField;
    LookUpOtherCode: TIntegerField;
    LookUpOtherPessoa: TStringField;
    EFiscal1: TEFiscal;
    quSrvParamIDParam: TIntegerField;
    dsLookUpBank: TDataSource;
    LookUpBank: TLookUpADOQuery;
    LookUpBankIDBanco: TIntegerField;
    LookUpBankCodigoBanco: TStringField;
    LookUpBankBanco: TStringField;
    LookUpMeioPagTipo: TIntegerField;
    LookUpMeioPagCodFiscal: TStringField;
    LookUpMeioPagDescFiscal: TStringField;
    TEFDial1: TTEFDial;
    dspSrvParam: TDataSetProvider;
    cdsSrvParam: TClientDataSet;
    cdsSrvParamSrvParameter: TStringField;
    cdsSrvParamSrvValue: TStringField;
    cdsSrvParamSrvType: TStringField;
    cdsSrvParamDescription: TStringField;
    cdsSrvParamDefaultValue: TStringField;
    cdsSrvParamIDParam: TIntegerField;
    quStore: TADOQuery;
    quStoreIDStore: TIntegerField;
    quStoreName: TStringField;
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
    dspStore: TDataSetProvider;
    cdsStore: TClientDataSet;
    cdsStoreIDStore: TIntegerField;
    cdsStoreName: TStringField;
    cdsStoreTicketHeader: TMemoField;
    cdsStoreTicketLayawayFooter: TMemoField;
    cdsStoreTicketTaxIsemptFooter: TMemoField;
    cdsStoreTicketFooter: TMemoField;
    cdsStoreTicketDetail: TMemoField;
    cdsStoreTicketTotals: TMemoField;
    cdsStorePrintTicketHeader: TBooleanField;
    cdsStorePrintLayawayFooter: TBooleanField;
    cdsStorePrintTaxInsemptFooter: TBooleanField;
    cdsStorePrintTicketFooter: TBooleanField;
    dsStore: TDataSource;
    quSystemUser: TADOQuery;
    quSystemUserUserTypeID: TIntegerField;
    quSystemUserIDUser: TIntegerField;
    quSystemUserSystemUser: TStringField;
    quSystemUserComissionID: TIntegerField;
    quSystemUserStoresAccess: TStringField;
    quSystemUserPW: TStringField;
    dspSystemUser: TDataSetProvider;
    cdsSystemUser: TClientDataSet;
    cdsSystemUserUserTypeID: TIntegerField;
    cdsSystemUserIDUser: TIntegerField;
    cdsSystemUserSystemUser: TStringField;
    cdsSystemUserComissionID: TIntegerField;
    cdsSystemUserStoresAccess: TStringField;
    cdsSystemUserPW: TStringField;
    dsSystemUser: TDataSource;
    quPreSale: TADODataSet;
    quPreSaleItem: TADODataSet;
    quPreSaleIDPreSale: TIntegerField;
    quPreSaleIDCustomer: TIntegerField;
    quPreSaleIDStore: TIntegerField;
    quPreSaleOtherComissionID: TIntegerField;
    quPreSaleDeliverTypeID: TIntegerField;
    quPreSaleMediaID: TIntegerField;
    quPreSaleIDTouristGroup: TIntegerField;
    quPreSaleTaxIsent: TBooleanField;
    quPreSaleLayaway: TBooleanField;
    quPreSalePreSaleDate: TDateTimeField;
    quPreSaleNote: TStringField;
    dsPreSale: TDataSource;
    quPreSaleItemIDPreInventoryMov: TIntegerField;
    quPreSaleItemUserID: TIntegerField;
    quPreSaleItemStoreID: TIntegerField;
    quPreSaleItemModelID: TIntegerField;
    quPreSaleItemDiscount: TBCDField;
    quPreSaleItemSalePrice: TBCDField;
    quPreSaleItemCostPrice: TBCDField;
    quPreSaleItemTaxValue: TBCDField;
    quPreSaleItemMovDate: TDateTimeField;
    quPreSaleItemModel: TStringField;
    quPreSaleItemDescription: TStringField;
    quPreSaleItemLargeImage: TStringField;
    quPreSaleItemIDTaxCategory: TIntegerField;
    quPreSaleMedia: TStringField;
    quPreSalePessoa: TStringField;
    quPreSaleEndereco: TStringField;
    quPreSaleBairro: TStringField;
    quPreSaleCidade: TStringField;
    quPreSaleCPF: TStringField;
    quPreSaleTelefone: TStringField;
    cmdFreeSQL: TADOCommand;
    quCashRegister: TADOQuery;
    dspCashRegister: TDataSetProvider;
    cdsCashRegister: TClientDataSet;
    dsCashRegister: TDataSource;
    quCashRegisterIDCashRegister: TIntegerField;
    quCashRegisterName: TStringField;
    quCashRegisterIsAssociated: TBooleanField;
    cdsCashRegisterIDCashRegister: TIntegerField;
    cdsCashRegisterName: TStringField;
    cdsCashRegisterIsAssociated: TBooleanField;
    dspAccess: TDataSetProvider;
    cdsAccess: TClientDataSet;
    quAccessPW: TStringField;
    quAccessMenuID: TIntegerField;
    quAccessSubMenuID: TIntegerField;
    cdsAccessCanAccess: TBooleanField;
    cdsAccessPW: TStringField;
    cdsAccessMenuID: TIntegerField;
    cdsAccessSubMenuID: TIntegerField;
    quMedia: TADODataSet;
    dspMedia: TDataSetProvider;
    cdsMedia: TClientDataSet;
    cdsMediaIDMedia: TIntegerField;
    cdsMediaMedia: TStringField;
    dsMedia: TDataSource;
    quBanco: TADODataSet;
    dspBanco: TDataSetProvider;
    cdsBanco: TClientDataSet;
    cdsBancoIDBanco: TIntegerField;
    cdsBancoCodigoBanco: TStringField;
    cdsBancoBanco: TStringField;
    dsBanco: TDataSource;
    quSystemUserIDTipoPessoa: TIntegerField;
    cdsSystemUserIDTipoPessoa: TIntegerField;
    quPreSaleItemPuppyTracker: TBooleanField;
    quPreSaleItemRequestCustomer: TBooleanField;
    quPreSaleItemCaseQty: TFloatField;
    quKitModel: TADODataSet;
    dspKitModel: TDataSetProvider;
    cdsKitModel: TClientDataSet;
    cdsKitModelIDModel: TIntegerField;
    cdsKitModelSellingPrice: TBCDField;
    quPreSaleItemQty: TFloatField;
    quSaleItemCommission: TADODataSet;
    quSaleItemCommissionIDCommission: TIntegerField;
    quPreSaleItemMaxDiscount: TFloatField;
    quPreSaleItemIDDepartment: TIntegerField;
    quSystemUserCodSystemUser: TStringField;
    cdsSystemUserCodSystemUser: TStringField;
    quPreSaleInvoiceDiscount: TBCDField;
    TEFDedicado1: TTEFDedicado;
    cdsKitModelQty: TBCDField;
    quPreSaleItemDiscount2: TBCDField;
    quPreSaleAditionalExpenses: TBCDField;
    quPreSaleSubTotal: TBCDField;
    quPreSaleItemIDDescriptionPrice: TIntegerField;
    quPreSaleItemIDVendor: TIntegerField;
    quPreSaleItemSuggPrice: TBCDField;
    quDocumentType: TADOQuery;
    dspDocumentType: TDataSetProvider;
    cdsDocumentType: TClientDataSet;
    dsDocumentType: TDataSource;
    quDocumentTypeIDDocumentType: TIntegerField;
    quDocumentTypeDocumentType: TStringField;
    quDocumentTypeDefaultType: TBooleanField;
    cdsDocumentTypeIDDocumentType: TIntegerField;
    cdsDocumentTypeDocumentType: TStringField;
    cdsDocumentTypeDefaultType: TBooleanField;
    quPreSaleItemDocumentNumber: TStringField;
    quPreSaleItemIDDocumentType: TIntegerField;
    quPreSaleSaleCode: TStringField;
    quSaleItemCommissionIDPreInventoryMov: TIntegerField;
    quPreSerialMov: TADODataSet;
    quMovDocument: TADODataSet;
    quCheckPayments: TADODataSet;
    quCheckPaymentsAmountPaid: TBCDField;
    quCheckPaymentsIDPreSale: TIntegerField;
    quCheckPaymentsLayaway: TBooleanField;
    quCashRegLogReason: TADOQuery;
    dspCashRegLogReason: TDataSetProvider;
    cdsCashRegLogReason: TClientDataSet;
    dsCashRegLogReason: TDataSource;
    quCashRegLogReasonIDCashRegLogReason: TIntegerField;
    quCashRegLogReasonReason: TStringField;
    cdsCashRegLogReasonIDCashRegLogReason: TIntegerField;
    cdsCashRegLogReasonReason: TStringField;
    quNegativeItems: TADODataSet;
    quNegativeItemsIDPreInventoryMov: TIntegerField;
    quPreSaleItemUnidade: TStringField;
    quPreSaleItemSigla: TStringField;
    quPreSaleNegativeItems: TADODataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure EFiscal1AfterReducaoZ(Sender: TObject);
    procedure TEFDial1Dialog(Sender: TObject;
      MessageType: TTEFDialMessageType; NeedUserOK: Boolean);
    procedure TEFDial1NeedPrintLineVinculado(Sender: TObject;
      LineToPrint: String; var LinePrinted: Boolean);
    procedure TEFDial1NeedCloseVinculado(Sender: TObject;
      var Closed: Boolean);
    procedure TEFDial1NeedOpenGerencial(Sender: TObject;
      var Opened: Boolean);
    procedure TEFDial1NeedPrintLineGerencial(Sender: TObject;
      LineToPrint: String; var LinePrinted: Boolean);
    procedure TEFDial1NeedCloseGerencial(Sender: TObject;
      var Closed: Boolean);
    procedure TEFDial1TryAgainDialog(Sender: TObject;
      var TryAgain: Boolean);
    procedure TEFDial1StatusPrinter(Sender: TObject; var Online: Boolean);
    procedure TEFDial1NeedOpenVinculado(Sender: TObject;
      AVinculadoInfo: TVinculadoInfo; var Opened: Boolean);
    procedure TEFDedicado1ExecutaComando21(Sender: TObject; Msg: String;
      var Opcao: String);
    procedure TEFDedicado1ExecutaComando23(Sender: TObject; Msg: String;
      var Opcao: String);
    procedure TEFDedicado1ExecutaComando4(Sender: TObject; Msg: String);
    procedure TEFDedicado1ExecutaComando20(Sender: TObject; Msg: String;
      var Opcao: String);
    procedure TEFDedicado1ExecutaComando34(Sender: TObject; Msg: String;
      TamMin, TamMax: Integer; var CampoInput: Double);
    procedure TEFDedicado1ExecutaComando31(Sender: TObject; Msg: String;
      var Opcao: String);
    procedure TEFDedicado1ExecutaComando14(Sender: TObject);
    procedure TEFDedicado1ExecutaComando30(Sender: TObject; Msg: String;
      TamMin, TamMax: Integer; var CampoInput: String; const Comando,
      TipoCampo: Integer);
    procedure TEFDedicado1ExecutaComandoSenha(Sender: TObject; Msg: String;
      TamMin, TamMax: Integer; var CampoInput: String; const Comando,
      TipoCampo: Integer);
    procedure EFiscal1AfterAbrirCupom(Sender: TObject);
    procedure EFiscal1AfterSuprimento(Sender: TObject);
    procedure EFiscal1AfterSangria(Sender: TObject);
    procedure EFiscal1AfterAbreDiaFiscal(Sender: TObject);
    procedure EFiscal1TotalCupom(ValorCupom: String);
    procedure EFiscal1BeforeAbrirCupom(Sender: TObject;
      var CanOpen: Boolean);
  private
    fStoreList: TStringList;
    FHandleError: THandleError;
    MyLocalPrinter: TPrinterDefaultClass;
    FPersistenceType: TPersistenceType;
    CDSImport: TCDSImportFile;
    FSaleWritter: TSaleWritter;
    FrmServrInfo: TFrmServerInfo;
    FCabecalhoInput: String;
    fInvPoleDisplay : TInvoice;
    FFrmWait : TFrmWait;

    function PersisteTipo60Mestre(RegTipo60Mestre : TRegTipo60Mestre): Boolean;
    function PersisteTipo60Analitico(VetTipo60Analitico : TVetTipo60Analitico): Boolean;
    function CreateADOQuery: TADOQuery;
    procedure MsgTEF(ATitle, ACaption: String);
    function GetPersistenceIni: String;
    procedure CreateSaleWritter;
    procedure LoadTEFDialInfo;
    procedure CreatePollDisplay;
    function GetDataEmissaoECF: TDateTime;
  public
    fStore            : TStore;         //Store information
    fUser             : TMRUser;        //User information
    fCashRegister     : TCashRegister;  //Cash Reg information
    fSystem           : TMRSystem;      //System information
    fPrintReceipt     : TMRPrintReceipt;//Printer info
    fInvoice          : TMRInvoice;     //Invoice information
    fPOS              : TFrmPOSFunctions; //POS functions
    //fPOSFiscal        : TFrmFiscalFunctions; //Impressora fical
    fPOSImportFiles   : TPOSImportTXTFiles;
    fModuloFiscal     : TModuloFiscal; //Infomacoes da impressora fiscal
    fCupomFiscal      : TCupomFiscal;
    fMRPOSColor       : TMRPOSColor;
    fKeyFunctionFile  : TIniFile;
    fPoleDisplay      : TPollDisplay; //Ploe Display

    fStartPoleDisplay : Boolean;

    FTraceControl: TMRTraceControl;
    FTEFDialTypes : set of byte;

    //PAF
    FLocalPath : String;
    FPrinters : String;
    PrinterFile: TIniFile;
    FMD5: String;

    function ValidateStore(StoreList, IDStore: String): Boolean;

    property PersistenceType: TPersistenceType read FPersistenceType write FPersistenceType;
    property SaleWritter:     TSaleWritter     read FSaleWritter     write FSaleWritter;

    function GetFunction(Key:Word):Integer;
    procedure SetFunction(Key:Word; Func:Integer);

    procedure SendCashCode(ACode: String; NeedCloseOpenDoc: Boolean = True);
    procedure SendAfterPrintCode(StartPrinter:Boolean = False);
    function GetPrinterCode(Code:String):String;

    procedure OpenCashRegister;  //Colocar no Cash Reg Object mais com o TPrinter tb
    function CheckCashRegState(var IDCashRegMov : integer) : integer;

    function ModelRestored(IDModel:Integer):Boolean;
    procedure SetError(ErrorType: Integer; sSource, sError: String);


    procedure PrintLine(MyText:String); //Print text to local port
    procedure PrinterStart;             //Print text to local port
    procedure PrinterStop;              //Print text to local port
    function CanAccessMenu(IDMenu, IDSubMenu:Integer; PW:String):Boolean;

    function GetTaxName(IDPreInvMov:Integer):String;

    function IsCheck(IDPay:String; var CodBank:String):Boolean;

    function DynamicRunSQL(ACaller: TComponent; sSQL: String): Boolean;
    function SelectReturnsRow(ACaller: TComponent; ASQL: String): Boolean;

    function POSScript : Boolean;
    function TableFieldExists(ATableName, AFieldName: String): Boolean;
    procedure PrepareCDS(CDS: TClientDataset; Tabela: String; IndexField: String = '';AOpen: Boolean = True);
    function FiltraCDS(CDS : TClientDataset; Filtro: String): Boolean;
    function GetStoreUsersFilter(CDS : TClientDataset):String;

    function CreateSaleCodeTXT(COO: String): String;

    function UpdatePOS:Boolean;
    function GetServerTXTDate:TDateTime;
    function CanImportServerTXT:Boolean;

    function OpenHold(SaleCode : String):Boolean;
    procedure CloseHold;
    function HoldExist(IDPreSale:Integer):Boolean;
    function DeleteHoldItens(IDPreSale:Integer):Boolean;

    function DatabaseOpenConnection:Boolean;
    procedure DatabaseCloseConnection;
    function BuildServerConnection(sParans: String): String;

    function TXTCashInfoFactory(AAlternativeFileName: String = ''): TTXTCashInfo;

    procedure CopyServerFiles;

    function IncHold(IDPreSale:Integer): Boolean;
    function DecHold(IDPreSale:Integer): Boolean;

    function DadosReducaoZ: TRegReducaoZ;

    procedure MsgBoxScroll(Msg : String);

    procedure PoleDisplayAddItem(AID, AIDModel: Integer; AModel,
      ADescription: String; AQty: Double; ASalePrice, ADiscount: Currency);
    procedure PoleDisplayAddPayment(AID: Integer; APayment: String;
      AAMount: Currency);
    procedure PoleDisplayCloseSale;
    procedure PoleDisplayDeleteItem(AID: Integer);
    procedure PoleDisplayDeletePayment(AID: Integer);
    procedure PoleDisplayInvInfo(ASaleCode: String; ASaleDate: TDatetime;
      AAddCostTotal, ADiscountTotal, ATaxTotal, ASubTotal: Currency;
      UpdateFile: Boolean = False);
    function PoleDisplayStatus: Boolean;
    procedure RefreshPoleDisplay;
    procedure OpenSaleItemCommission(APreInventoryMovIDs: String);
    procedure OpenPreSerialMov(APreInventoryMovIDs: String);
    procedure OpenMovDocument(APreInventoryMovIDs: String);
    function GetPreInventoryMovIDs: String;
    function GetCommission(AIDPreInvMov: Integer): Integer;
    function GetSerialNumber(AIDPreInvMov: Integer): String;
    function GetIdentificationNumber(AIDPreInvMov: Integer): String;

    procedure ShowWait;
    procedure HideWait;
    //PAF
    procedure ClearCupomFiscal;

    procedure CreateSerialNumber;
    procedure ReadSerialNumbers;
    function VerifySerialNumber: Boolean;

    procedure CreateGrandTotal;
    function VerifyGrandeTotal: Boolean;
    function UpdateGrandeTotal(AGrandeTotal : Currency):Boolean;
    function RetornaGrandeTotal: Currency;

    function VerifyMD5: Boolean;

    procedure LoadBematechTermInfo;
    procedure LoadElginTermInfo;
    procedure LoadSwedaTermInfo;

    function NegativeQty(sHoldNum: String): Boolean;
  end;

var
  DM: TDM;

implementation

uses uMsgBox, uSystemConst, uParamFunctions, uEncryptFunctions, uSqlFunctions,
     uDateTimeFunctions, uStringFunctions, uMsgConstant, uNumericFunctions,
     uDMGlobal, uPassword, uFrmPOSSQL, uFrmMsgTEF, uDMPDV, uFrmOption,
     uFrmImput, uFrmTEFCheque, DateUtils, uOperationSystem;

{$R *.dfm}

//TMRUser ============================
function TMRUser.Manager:Boolean;
begin
   Result := (IDUserType in [USER_TYPE_MANAGER, USER_TYPE_ADMINISTRATOR]);
end;

function TMRUser.AssistManager:Boolean;
begin
  Result := (IDUserType in [USER_TYPE_ASSIST_MANAGER, USER_TYPE_ADMINISTRATOR]);
end;

//TStore ============================
procedure TStore.SetStoreHour(iIDStore:Integer); //Atualiza o Hora da Store no - DM
begin
  with DM.quFreeSQL do
     begin
     if Active then Close;
     SQL.Clear;
     SQL.Add('SELECT S.HourDefault FROM Store S');
     SQL.Add('WHERE S.IDStore = ' + IntToStr(iIDStore));
     Open;
     If FieldByName('HourDefault').AsString <> '' then //Set o IDStoreHour para a variavel global
        fStoreHour := FieldByName('HourDefault').AsInteger
     else
        fStoreHour := 0;
     Close;
     end;
end;

//TMRSystem ============================
function TMRSystem.ConvertParam(SrvValue, SrvType : String) : Variant;
var
  MyType, MyValue : String;
begin

  MyType  := Trim(UpperCase(SrvType));
  MyValue := Trim(SrvValue);

  if MyType = 'STRING' then
    begin
     Result := MyValue;
    end
  else if MyType = 'BOOLEAN' then
    begin
     Result := (UpperCase(MyValue) = 'TRUE')
    end
  else if MyType = 'INTEGER' then
    begin
     Result := StrToInt(UpperCase(MyValue))
    end
  else if MyType = 'FLOAT' then
    begin
     Result := MyStrToMoney(UpperCase(MyValue))
    end;
end;

//TDM ============================
function TDM.GetTaxName(IDPreInvMov:Integer):String;
begin
// Removida

{
   with quFreeSQL do
     begin
     if Active then
        Close;
     SQL.Clear;
     SQL.Add('SELECT');
     SQL.Add('	TC.ECFTaxIndex');
     SQL.Add('FROM');
     SQL.Add('	PreInventoryMov PIM');
     SQL.Add('	JOIN Model M ON (M.IDModel = PIM.ModelID)');
     SQL.Add('	JOIN StoreToTabGroup STG ON (STG.IDGroup = M.GroupID AND STG.IDStore = PIM.StoreID)');
     SQL.Add('	JOIN TaxCategory TC ON (STG.IDSaleTax = TC.IDTaxCategory)');
     SQL.Add('WHERE');
     SQL.Add('	PIM.IDPreInventoryMov = ' + IntToStr(IDPreInvMov));
     SQL.Add('	AND');
     SQL.Add('	PIM.InventMovTypeID = 1');
     SQL.Add('	AND');
     SQL.Add('	TC.OperationType = 1');
     SQL.Add('	AND');
     SQL.Add('	TC.SaleTaxType = 2');

     Open;
     Result := FieldByName('ECFTaxIndex').AsString;
     Close;
     end;
}
end;


function TDM.CanAccessMenu(IDMenu, IDSubMenu:Integer; PW:String):Boolean;
begin
   Result := False;
   With cdsAccess do
     begin
       case PersistenceType of
         ptDB:
           begin
             if Active then
                Close;
             Params.ParambyName('Password').Value    := PW;
             Params.ParambyName('MenuID').Value      := IDMenu;
             Params.ParambyName('SubMenuID').Value   := IDSubMenu;
             Open;
             Result := cdsAccessCanAccess.AsBoolean;
             Close;
           end;
         ptTXT:
         begin
           PrepareCDS(cdsAccess, 'Access');
           Filtered := False;
           try
             Filter := Format('PW = %S AND MenuID = %D AND SubMenuID = %D', [QuotedStr(PW), IDMenu, IDSubMenu]);
             Filtered := True;
             Result   := cdsAccessCanAccess.AsBoolean;
           finally
             Filtered := False;
           end;
         end;
       end;
     end;
end;

procedure TDM.SetError(ErrorType: Integer; sSource, sError: String);
begin

  if not Assigned(FHandleError.Connection) then
     FHandleError.Connection := ADODBConnect;

  FHandleError.ErrorDetected(DM.GetNextID(MR_APPHISTORY_ID),
                             ErrorType,
                             fUser.ID,
                             sSource,
                             sError,
                             FormatDateTime('mm/dd/yyyy', Now));

end;

function TDM.ModelRestored(IDModel:Integer):Boolean;
var
  IsDesativedo : Integer;
begin

   with quFreeSQL do
     begin

     if Active then
        Close;

     SQL.Clear;
     SQL.Add('SELECT M.Desativado ');
     SQL.Add('FROM Model M  ');
     SQL.Add('WHERE M.IDModel = '+IntToStr(IDModel));

     Open;

     IsDesativedo := FieldByName('Desativado').AsInteger;

     Close;

     if IsDesativedo = 1 then
        begin
        SQL.Clear;
        SQL.Add('UPDATE Model');
        SQL.Add('SET Desativado = 0');
        SQL.Add('WHERE IDModel = '+IntToStr(IDModel));
        ExecSQL;

        MsgBox(MSG_INF_MODEL_RESTORED, vbOKOnly + vbInformation);
        end;
     end;

   Result := True;
end;

function TDM.CheckCashRegState(var IDCashRegMov : integer) : integer;
begin
  if DM.PersistenceType = ptTXT then
  begin
    if fCashRegister.SalesFileName = '' then
      Result := CASHREG_CLOSE
    else
      Result := CASHREG_OPEN;
    Exit;
  end;

  IDCashRegMov := 0;

  if not (fCashRegister.IDDefault > 0) then
    begin
      MessageBeep(MB_ICONASTERISK);
      MsgBox(MSG_EXC_NO_DEFAULT_CASREG, vbOkOnly + vbExclamation);
      Result := CASHREG_ERROR;
      Exit;
    end;

  if DescCodigo(['IDCashRegister'], [IntToStr(fCashRegister.IDDefault)],
                 'CashRegister', 'IDCashRegister') = '' then
    begin
     MessageBeep(MB_ICONASTERISK);
     MsgBox(MSG_EXC_NO_ASSOCIETE_CASREG, vbOkOnly + vbExclamation);
     Result := CASHREG_ERROR;
     Exit;
    end;

  with spCheckOpenCash do
    begin
      Parameters.ParambyName('@CashRegID').Value := fCashRegister.IDDefault;
      ExecProc;

      if Parameters.ParambyName('@IsOpen').Value then
        begin
          IDCashRegMov := Parameters.ParambyName('@IDCashRegMov').Value;
          Result := CASHREG_OPEN;

          if (NOT DM.fSystem.SrvParam[PARAM_ANYONEMANAGECASHREG])
             AND
             (Parameters.ParambyName('@IDOpenUser').Value <> DM.fUser.ID) then
            begin
             if not Password.HasFuncRight(24) then
               begin
                MsgBox(MSG_INF_ONE_OPEN_CASREG_MANAGER, vbOKOnly + vbInformation);
                Result := CASHREG_ERROR;
               end
             else if MsgBox(MSG_QST_ONE_OPEN_MANAGER_CONTUE, vbYesNo + vbQuestion) = vbNo then
                     Result := CASHREG_ERROR;
            end;
        end
      else
         Result := CASHREG_CLOSE;
    end;
end;

procedure TDM.OpenCashRegister;
var
  Code, SubCode, SendCode : String;
  i    : integer;
  NotOk: Boolean;
  //WaitForm: TWaitForm;
  iEstado : Integer;

begin

  if not fCashRegister.Open then
     Exit;

  if fCashRegister.FiscalPrinter then
  begin
    EFiscal1.VerificaEstadoGaveta(iEstado);
    EFiscal1.AbreGaveta;
    Exit;
  end;

  Code := fCashRegister.OpenCod;

  SubCode  := '';
  SendCode := '';

  for i := 1 to Length(Code) do
    begin
     if (Code[i] <> ',') then
        SubCode := SubCode + Code[i];

     if (Code[i] = ',') or (i = Length(Code)) then
       begin
        // Manda o caracter
        SendCode := SendCode + Chr(MyStrToInt(SubCode));
        SubCode := '';
       end;
    end;

  //WaitForm := TWaitForm.Create(Self);

  //WaitForm.Start(False);

  NotOk := True;

  Application.ProcessMessages;

  while NotOk do
    begin
      try
        PrinterStart;
        PrintLine(SendCode);
        PrinterStop;
        NotOk := False;
      except
        if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
          NotOk := True
        else
          begin
            //WaitForm.Free;
            Exit;
          end;
      end;
    end;
  //WaitForm.Free;
end;


procedure TDM.PrinterStart;
begin
   MyLocalPrinter.StartPrinter;
end;

procedure TDM.PrinterStop;
begin
   MyLocalPrinter.ClosePrinter;
end;

procedure TDM.PrintLine(MyText:String);
begin
   //Create Local Printer and set params
   Case fPrintReceipt.PrinterType of
     PORT_LPT1,
     PORT_LPT2  : TLPTPrinter(MyLocalPrinter).PrintlnText(MyText);
     PORT_WIN   : TWindowsPrinter(MyLocalPrinter).PrintText(MyText);
   end;

end;

procedure TDM.CreateSaleWritter;
begin

  FSaleWritter := TSaleWritter.Create(DELETE_LOG_DAYS, DELETE_LOG_SIZE_MB);

  if DM.PersistenceType = ptTXT then
  begin
    FSaleWritter.IDCashReg        := fCashRegister.IDDefault;
    FSaleWritter.LocalWorkingDir  := fCashRegister.FLocalWorkingDir;
    FSaleWritter.RemoteWorkingDir := fCashRegister.RemoteWorkingDir;
    if fCashRegister.SalesFileName <> '' then
      FSaleWritter.OpenFile(DM.fCashRegister.SalesFileName);
  end;
end;

function TDM.TXTCashInfoFactory(AAlternativeFileName: String = ''): TTXTCashInfo;
begin
  Result := TTXTCashInfo.Create;
  with Result do
  begin
    if Trim(AAlternativeFileName) = '' then
      FileName := fCashRegister.FLocalWorkingDir + fCashRegister.SalesFileName
    else
      FileName := fCashRegister.FLocalWorkingDir + AAlternativeFileName;
    Load;
  end;
end;


procedure TDM.DataModuleCreate(Sender: TObject);
var
  I, iLastParam: Integer;
  bAbort, ExitConnection: Boolean;
  sResult: String;
  buildInfo: String;
begin
  inherited;
  fModuloFiscal       := TModuloFiscal.Create;
  fCupomFiscal        := TCupomFiscal.Create;
  DMGlobal.IDLanguage := LANG_ENGLISH;
  FrmServrInfo        := TFrmServerInfo.Create(self);
  FHandleError        := THandleError.Create;
  fStoreList          := TStringList.Create;
  fStore              := TStore.Create;
  fUser               := TMRUser.Create;
  fCashRegister       := TCashRegister.Create;
  fSystem             := TMRSystem.Create;
  fPrintReceipt       := TMRPrintReceipt.Create;
  fInvoice            := TMRInvoice.Create;
  fPOS                := TFrmPOSFunctions.Create(Self);
  fPOSImportFiles     := TPOSImportTXTFiles.Create;
  fMRPOSColor         := TMRPOSColor.Create;
  fPoleDisplay        := TPollDisplay.Create;
  FFrmWait            := TFrmWait.Create(Self);

  FLocalPath := ExtractFilePath(Application.ExeName);

  if not FileExists(FLocalPath + 'Impressoras.ini') then
     FileCreate(FLocalPath + 'Impressoras.ini');

  PrinterFile := TIniFile.Create(FLocalPath + 'Impressoras.ini');

  with TRegistry.Create do
  try

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REGISTRY_PATH_POS, True);

    if not ValueExists('PersistenceType') then
      WriteInteger('PersistenceType', 0);
    if not ValueExists('SalesFilesToExp') then
      WriteInteger('SalesFilesToExp', 3);
    if not ValueExists('LocalWorkingDir') then
      WriteString('LocalWorkingDir', ExtractFilePath(Application.ExeName) + POS_DIR);
    if not ValueExists('RemoteWorkingDir') then
      WriteString('RemoteWorkingDir', '');
    if not ValueExists('ServerFilesDir') then
      WriteString('ServerFilesDir', ExtractFilePath(Application.Exename) + SERVER_DIR);
    if not ValueExists('SrvRefreshInSecond') then
      WriteInteger('SrvRefreshInSecond', 60);

    if not ValueExists('TEFDedCodLoja') then
      WriteString('TEFDedCodLoja', '');
    if not ValueExists('TEFDedIPServer') then
      WriteString('TEFDedIPServer', '');
    if not ValueExists('TEFDedNumTerminal') then
      WriteString('TEFDedNumTerminal', '');
    if not ValueExists('TEFDedMsgOp') then
      WriteString('TEFDedMsgOp', 'MainRetail3');

    if not ValueExists('ECFPrinterName') then
      WriteString('ECFPrinterName', 'None');
    if not ValueExists('ECFRodape') then
      WriteString('ECFRodape', 'Volte Sempre!');
    if not ValueExists('UseTEF') then
      WriteInteger('UseTEF', 0);
    if not ValueExists('SalesFileName') then
      WriteString('SalesFileName', '');
    if not ValueExists('LastSalesFiles') then
      WriteString('LastSalesFiles', '');
    if not ValueExists('SaleCodeTXT') then
      WriteInteger('SaleCodeTXT', 1);
    if not ValueExists('AskSalesPerson') then
      WriteBool('AskSalesPerson', False);
    if not ValueExists('KeepSalesPerson') then
      WriteBool('KeepSalesPerson', False);
    if not ValueExists('PDVImage') then
      WriteString('PDVImage', ExtractFilePath(Application.ExeName)+'MRPDV.bmp');
    if not ValueExists('ShowShortCuts') then
      WriteBool('ShowShortCuts', False);
    if not ValueExists('MainRetailPath') then
      WriteString('MainRetailPath', '');
    if not ValueExists('RefreshGlobalTXT') then
      WriteInteger('RefreshGlobalTXT', 60);
    if not ValueExists('PDVDisplayType') then
      WriteInteger('PDVDisplayType', DISPLAY_DESCRIPTION);
    if not ValueExists('POSBackgroundColor') then
      WriteString('POSBackgroundColor', ColorToString($00804000));
    if not ValueExists('POSReturnBackgroundColor') then
      WriteString('POSReturnBackgroundColor', ColorToString($003E3E00));
    if not ValueExists('POSValuesColor') then
      WriteString('POSValuesColor', ColorToString(clYellow));
    if not ValueExists('POSTextColor') then
      WriteString('POSTextColor', ColorToString($00FFCE9D));
    if not ValueExists('POSBarcodeTextColor') then
      WriteString('POSBarcodeTextColor', ColorToString($008080FF));
    if not ValueExists('FiscalPrinter') then
      WriteBool('FiscalPrinter', false);
    if not ValueExists('SellWithCashDrawClosed') then
      WriteBool('SellWithCashDrawClosed', False);
    if not ValueExists('MsgCashAfterClose') then
      WriteString('MsgCashAfterClose', '');
    if not ValueExists('AskCPF') then
      WriteBool('AskCPF', False);
    if not ValueExists('BlockNegativeSale') then
      WriteBool('BlockNegativeSale', False);
    if not ValueExists('ValidateCPF') then
      WriteBool('ValidateCPF', False);
    if not ValueExists('HideOtherStoreQry') then
      WriteBool('HideOtherStoreQry', False);
    if not ValueExists('LeituraDataMFD') then
      WriteDate('LeituraDataMFD', Trunc(Now));
    if not ValueExists('MD5') then
      WriteString('MD5', '');
    if not ValueExists('MaxAmountAskPrice') then
      WriteCurrency('MaxAmountAskPrice', 100000);

    if ReadInteger('PersistenceType') = 0 then
      FPersistenceType  := ptDB
    else
      FPersistenceType  := ptTXT;

    if FPersistenceType = ptTXT then
    begin
      fCashRegister.FSalesFilesToExp   := ReadInteger('SalesFilesToExp');
      fCashRegister.FLocalWorkingDir   := ReadString('LocalWorkingDir');
      fCashRegister.FRemoteWorkingDir  := ReadString('RemoteWorkingDir');
      fCashRegister.FServerFilesDir    := ReadString('ServerFilesDir');
      fCashRegister.SrvRefreshInSecond := ReadInteger('SrvRefreshInSecond');
    end;
    {
    //fPrintReceipt.ECFPrinterName    := 'Daruma';
    fPrintReceipt.ECFPrinterName    := ReadString('ECFPrinterName');
    }

    fModuloFiscal.PDVImage          := ReadString('PDVImage');
    fModuloFiscal.LeituraDataMFD    := ReadDate('LeituraDataMFD');
    fCashRegister.AskSalesPerson    := ReadBool('AskSalesPerson');
    fCashRegister.KeepSalesPerson   := ReadBool('KeepSalesPerson');
    fPrintReceipt.ECFPrinterName    := ReadString('ECFPrinterName');
    fPrintReceipt.ECFRodape         := ReadString('ECFRodape');
    fCashRegister.LastSalesFiles    := ReadString('LastSalesFiles');
    fCashRegister.SalesFileName     := ReadString('SalesFileName');
    fCashRegister.fUseTef           := ReadInteger('UseTEF');
    fCashRegister.fShowShortCut     := ReadBool('ShowShortCuts');
    fCashRegister.MainRetail        := ReadString('MainRetailPath');
    fCashRegister.RefreshGlobal     := ReadInteger('RefreshGlobalTXT');
    fCashRegister.DisplayType       := ReadInteger('PDVDisplayType');
    fCashRegister.FiscalPrinter     := ReadBool('FiscalPrinter');
    fCashRegister.FMsgAfterCloseReg := ReadString('MsgCashAfterClose');
    fCashRegister.AskCPF            := ReadBool('AskCPF');
    fCashRegister.ValidateCPF       := ReadBool('ValidateCPF');
    fCashRegister.BlockNegativeSale := ReadBool('BlockNegativeSale');
    fCashRegister.HideOtherStoreQry := ReadBool('HideOtherStoreQry');
    fCashRegister.TEFDedCodLoja     := ReadString('TEFDedCodLoja');
    fCashRegister.TEFDedIPServer    := ReadString('TEFDedIPServer');
    fCashRegister.TEFDedNumTerminal := ReadString('TEFDedNumTerminal');
    fCashRegister.TEFDedMsgOp       := ReadString('TEFDedMsgOp');
    fCashRegister.SellDrawerClosed  := ReadBool('SellWithCashDrawClosed');
    fCashRegister.MaxAmountAskPrice := ReadCurrency('MaxAmountAskPrice');

    fMRPOSColor.POSBackgroundColor  := StringToColor(ReadString('POSBackgroundColor'));
    fMRPOSColor.POSReturnColor      := StringToColor(ReadString('POSReturnBackgroundColor'));
    fMRPOSColor.POSValuesColor      := StringToColor(ReadString('POSValuesColor'));
    fMRPOSColor.POSTextColor        := StringToColor(ReadString('POSTextColor'));
    fMRPOSColor.POSBarcodeTextColor := StringToColor(ReadString('POSBarcodeTextColor'));

    FMD5                            := ReadString('MD5');
  finally
    Free;
  end;

  CDSImport :=  TCDSImportFile.Create;

  if PersistenceType = ptTXT then
  begin
    CopyServerFiles;
    sResult := FrmServrInfo.Start(fSystem.StartMode, False, '', bAbort);
    ADOConnectionString := BuildServerConnection(sResult);
  end;

  TFrmMsgConstant.Create(Self);

  //SYS_MODULE_TRIAL - Demo, 1,2,3,4 - Modules
  fSystem.StartMode := SYS_MODULE_3;

  if FPersistenceType = ptDB then
  begin
    sResult := FrmServrInfo.Start(fSystem.StartMode, False, '', bAbort);
    ExitConnection := bAbort;

    while not ExitConnection do
    try
      ADOConnectionString := BuildServerConnection(sResult);
      ADOConnectionOpen;
      ExitConnection := True;
    except
      on E: Exception do
      begin
        sResult := FrmServrInfo.Start(fSystem.StartMode, True, E.Message, bAbort);
        ExitConnection := bAbort;
      end;
    end;

    FTraceControl := TMRTraceControl.Create;
    FTraceControl.ADOConn := ADODBConnect;

    if bAbort then
    begin
      fSystem.StartMode := SYS_ERROR;
      Application.Terminate;
    end;
  end;

  iLastParam := -1;
  SetLength(fSystem.fSrvParam, 0);

  PrepareCDS(cdsSrvParam, 'Param', 'IDParam');
  PrepareCDS(cdsStore, 'Store', 'Name', True);
  PrepareCDS(cdsSystemUser, 'SystemUser', 'SystemUser');
  PrepareCDS(cdsDocumentType, 'MntDocumentType', 'DocumentType');

  with cdsSrvParam do
  begin
    while not Eof do
    begin
      if (cdsSrvParamIDParam.Value - iLastParam) > 1 then
      begin
        for I := (iLastParam + 1) to cdsSrvParamIDParam.Value -1 do
        begin
          SetLength(fSystem.fSrvParam, Length(fSystem.fSrvParam) + 1);
          fSystem.fSrvParam[Length(fSystem.fSrvParam) - 1] := Null;
        end;
      end;
      SetLength(fSystem.fSrvParam, Length(fSystem.fSrvParam) + 1);
      fSystem.fSrvParam[Length(fSystem.fSrvParam) - 1] := DM.fSystem.ConvertParam(cdsSrvParamSrvValue.AsString, cdsSrvParamSrvType.AsString);
      iLastParam := cdsSrvParamIDParam.Value;
      Next;
    end;
    Close;
  end;

  if FPersistenceType = ptDB then
    POSScript; // Gera as tabelas fiscais

  // Abre o registry
  with TRegistry.Create do
  try

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REGISTRY_PATH, True);

    if not ValueExists('DefaultCashRegID') then
      WriteInteger('DefaultCashRegID', 0);
    if not ValueExists('DefaultStoreID') then
      WriteInteger('DefaultStoreID', 1);
    if not ValueExists('DefaultMediaID') then
      WriteInteger('DefaultMediaID', 7);
    if not ValueExists('XPressSaleType') then
      WriteInteger('XPressSaleType', 0);
    if not ValueExists('CashRegOpenCodeStr') then
      WriteString('CashRegOpenCodeStr', '7');
    if not ValueExists('CashRegAfterPrintStr') then
      WriteString('CashRegAfterPrintStr', '');
    if not ValueExists('PrintReceipt') then
      WriteBool('PrintReceipt', True);
    if not ValueExists('PrintCheck') then
      WriteBool('PrintCheck', True);
    if not ValueExists('GeneratePAFSintegra') then
      WriteBool('GeneratePAFSintegra', False);
    if not ValueExists('OpenCashReg') then
      WriteBool('OpenCashReg', True);
    if not ValueExists('DefaultLanguage') then
      WriteInteger('DefaultLanguage', LANG_ENGLISH);
    if not ValueExists('LangPath') then
      WriteString('LangPath', ExtractFilePath(ParamStr(0)) + LANG_DIRECTORY);
    if not ValueExists('DefaultDecimalSeparator') then
      WriteString('DefaultDecimalSeparator', '.');
    if not ValueExists('DefaultThousandSeparator') then
      WriteString('DefaultThousandSeparator', ',');
    if not ValueExists('DefaultDateFormat') then
      WriteString('DefaultDateFormat', 'mm/dd/yyyy');
    if not ValueExists('XpressSaleImage') then
      WriteString('XpressSaleImage', '');
    if not ValueExists('PrinterType') then
      WriteInteger('PrinterType', 1);
    if not ValueExists('PrinterPort') then
      WriteString('PrinterPort', 'LPT1');
    if not ValueExists('InvObsText') then
      WriteString('InvObsText', '');
    if not ValueExists('PrinterFontName') then
      WriteString('PrinterFontName', 'Courier New');
    if not ValueExists('PrinterFontSize') then
      WriteInteger('PrinterFontSize', 10);
    if not ValueExists('PrinterLineSpace') then
      WriteInteger('PrinterLineSpace', 50);
    if not ValueExists('PrinterLineWidth') then
      WriteInteger('PrinterLineWidth', 40);
    if not ValueExists('FiscalMode') then
      WriteBool('FiscalMode', false);
    if not ValueExists('PollDisplayIP') then
      WriteString('PollDisplayIP', '');
    if not ValueExists('PollDisplayPort') then
      WriteInteger('PollDisplayPort', 9091);
    if not ValueExists('PollDisplayClearSale') then
      WriteBool('PollDisplayClearSale', True);
    if not ValueExists('BarcodeScaleCheck') then
      WriteBool('BarcodeScaleCheck', False);
    if not ValueExists('POSScaleCheck') then
      WriteBool('POSScaleCheck', False);
    if not ValueExists('ScaleCommunicationType') then
      WriteInteger('ScaleCommunicationType', -1);
    if not ValueExists('ScaleSerialPort') then
      WriteString('ScaleSerialPort', 'COM1');
    if not ValueExists('ScaleBaudRate') then
      WriteInteger('ScaleBaudRate', -1);
    if not ValueExists('ScaleIPEthernet') then
      WriteString('ScaleIPEthernet', '');
    if not ValueExists('ScalePortEthernet') then
      WriteString('ScalePortEthernet', '');
    if not ValueExists('ScaleDecimal') then
      WriteInteger('ScaleDecimal', 3);
    if not ValueExists('BarcodeScaleType') then
      WriteInteger('BarcodeScaleType', -1);
    if not ValueExists('POSScaleType') then
      WriteInteger('POSScaleType', -1);

    fCashRegister.Fiscal               := ReadBool('FiscalMode');
    fCashRegister.IDDefault            := ReadInteger('DefaultCashRegID');
    fCashRegister.fGeneratePAFSintegra := ReadBool('GeneratePAFSintegra');
    fStore.IDDefault                := ReadInteger('DefaultStoreID');
    fCashRegister.IDMedia           := ReadInteger('DefaultMediaID');
    fInvoice.XpressSaleType         := ReadInteger('XPressSaleType');
    fInvoice.XpressSaleImage        := ReadString('XpressSaleImage');
    fInvoice.OBSText                := ReadString('InvObsText');
    fStore.ID                       := fStore.IDDefault;
    fCashRegister.OpenCod           := ReadString('CashRegOpenCodeStr');
    fCashRegister.AfterPrintCode    := ReadString('CashRegAfterPrintStr');
    fPrintReceipt.PrintReceipt      := ReadBool('PrintReceipt');
    fPrintReceipt.PrintCheck        := ReadBool('PrintCheck');
    fCashRegister.Open              := ReadBool('OpenCashReg');
    DMGlobal.IDLanguage             := ReadInteger('DefaultLanguage');
    DMGlobal.LangFilesPath          := ReadString('LangPath');
    DecimalSeparator                := ReadString('DefaultDecimalSeparator')[1];
    ThousandSeparator               := ReadString('DefaultThousandSeparator')[1];
    ShortDateFormat                 := ReadString('DefaultDateFormat');
    fPrintReceipt.PrinterType       := ReadInteger('PrinterType');
    fPrintReceipt.PrinterFontName   := ReadString('PrinterFontName');
    fPrintReceipt.PrinterFontSize   := ReadInteger('PrinterFontSize');
    fPrintReceipt.PrinterLineSpace  := ReadInteger('PrinterLineSpace');
    fPrintReceipt.PrinterLineWidth  := ReadInteger('PrinterLineWidth');
    fPrintReceipt.PrinterPort       := ReadString('PrinterPort');
    //Pole Display
    fPoleDisplay.FIP                := ReadString('PollDisplayIP');
    fPoleDisplay.FPort              := ReadInteger('PollDisplayPort');
    fPoleDisplay.FClearSale         := ReadBool('PollDisplayClearSale');
    //Fiscal
    fModuloFiscal.CGC               := '';
    fModuloFiscal.Decimal           := '.';
    //Scale
    fCashRegister.BarcodeScaleCheck := ReadBool('BarcodeScaleCheck');
    fCashRegister.POSScaleCheck     := ReadBool('POSScaleCheck');
    fCashRegister.ScaleModel        := ReadString('ScaleModel');
    fCashRegister.ScaleCommunicationType := ReadInteger('ScaleCommunicationType');
    fCashRegister.ScaleSerialPort   := ReadString('ScaleSerialPort');
    fCashRegister.ScaleBaudRate     := ReadInteger('ScaleBaudRate');
    fCashRegister.ScaleIPEthernet   := ReadString('ScaleIPEthernet');
    fCashRegister.ScalePortEthernet := ReadString('ScalePortEthernet');
    fCashRegister.ScaleDecimal      := ReadInteger('ScaleDecimal');
    fCashRegister.BarcodeScaleType  := ReadInteger('BarcodeScaleType');
    fCashRegister.POSScaleType      := ReadInteger('POSScaleType');
  finally
    Free;
  end;

  //Homologacao BA
  {
  fCashRegister.FiscalPrinter := True;
  fCashRegister.Fiscal := True;
  }

  // Atualiza as variáveis do sistema para a lingua
  ChangeLocalSetings(DMGlobal.IDLanguage);

  CreateSalewritter;

  // Seta a data do cliente igual a do server
  if FPersistenceType = ptDB then
    fStore.StoreHour := fStore.ID;

  //Mudar MsgBox Lang
  SetMsgBoxLand(DMGlobal.IDLanguage);

  //Carrega os atalhos do sistema
  fKeyFunctionFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+'KeyFunction.ini');

  //Create Local Printer and set parameters
  case fPrintReceipt.PrinterType of
    PORT_LPT1, PORT_LPT2:
    begin
      MyLocalPrinter := TLPTPrinter.Create;
      TLPTPrinter(MyLocalPrinter).SetPort(fPrintReceipt.PrinterPort);
    end;

    PORT_WIN:
    begin
      MyLocalPrinter := TWindowsPrinter.Create;
      TWindowsPrinter(MyLocalPrinter).SetStartPos(0);
      TWindowsPrinter(MyLocalPrinter).SetFontName(fPrintReceipt.PrinterFontName);
      TWindowsPrinter(MyLocalPrinter).SetFontSize(fPrintReceipt.PrinterFontSize);
      TWindowsPrinter(MyLocalPrinter).SetLineSpace(fPrintReceipt.PrinterLineSpace);
    end;
  end;

  {ajustar a impressora escolhida}
  with DM.EFiscal1 do
  begin
    with fPrintReceipt do
    begin
      if ECFPrinterName = 'None' then Impressora := None;
      if ECFPrinterName = 'Sweda03' then Impressora := Sweda03;
      if ECFPrinterName = 'Sweda10' then Impressora := Sweda10;
      if ECFPrinterName = 'NCR2x' then Impressora := NCR2x;
      if ECFPrinterName = 'NCR1x' then Impressora := NCR1x;
      if ECFPrinterName = 'NCR7141' then Impressora := NCR7141;
      if ECFPrinterName = 'Urano2EFE' then Impressora := Urano2EFE;
      if ECFPrinterName = 'Urano1EFC' then Impressora := Urano1EFC;
      if ECFPrinterName = 'Urano2EFC' then Impressora := Urano2EFC;
      if ECFPrinterName = 'Urano1FIT' then Impressora := Urano1FIT;
      if ECFPrinterName = 'Zanthus2e' then Impressora := Zanthus2e;
      if ECFPrinterName = 'ZanthusIZ20' then Impressora := ZanthusIZ20;
      if ECFPrinterName = 'ZanthusIZ21' then Impressora := ZanthusIZ21;
      if ECFPrinterName = 'ZanthusIZ41' then Impressora := ZanthusIZ41;
      if ECFPrinterName = 'ZanthusIZ11' then Impressora := ZanthusIZ11;
      if ECFPrinterName = 'ZanthusIZ10' then Impressora := ZanthusIZ10;
      if ECFPrinterName = 'Schalter3D' then Impressora := Schalter3D;
      if ECFPrinterName = 'Schalter2S' then Impressora := Schalter2S;
      if ECFPrinterName = 'Trends10E' then Impressora := Trends10E;
      if ECFPrinterName = 'Dataregis' then Impressora := Dataregis;
      if ECFPrinterName = 'BematechMP40' then Impressora := BematechMP40;
      if ECFPrinterName = 'BematechMP20' then Impressora := BematechMP20;
      if ECFPrinterName = 'BematechTermica' then Impressora := BematechTermica;
      if ECFPrinterName = 'Procomp_2011' then Impressora := Procomp_2011;
      if ECFPrinterName = 'AFRAC' then Impressora := AFRAC;
      if ECFPrinterName = 'Daruma' then Impressora := DarumaMatr;
      if ECFPrinterName = 'DarumaTermica' then Impressora := DarumaTerm;
      if ECFPrinterName = 'Elgin' then Impressora := Elgin;
      if ECFPrinterName = 'Schalter_SCFI' then Impressora := SCFI;
    end;
  end;

  //Abrir porta pra impressora fiscal
  if DM.fCashRegister.FiscalPrinter then
    DM.EFiscal1.AbreComunicacao;

  if fCashRegister.UseTef = TEF_DEDICADO then
  begin
    TEFDedicado1.CodigoLoja     := fCashRegister.TEFDedCodLoja;
    TEFDedicado1.IPServidor     := fCashRegister.TEFDedIPServer;
    TEFDedicado1.NumeroTerminal := fCashRegister.TEFDedNumTerminal;
    TEFDedicado1.MensagemPinPad := fCashRegister.TEFDedMsgOp;
  end
  else if fCashRegister.UseTef = TEF_DIAL then
    LoadTEFDialInfo;

  CreatePollDisplay;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;

  //Fechar porta pra impressora fiscal
  if DM.fCashRegister.FiscalPrinter then
    DM.EFiscal1.FechaComunicacao;

  if Assigned(FHandleError) then
    FHandleError.Free;

  if Assigned(fSystem) then
    FreeAndNil(fSystem);

  if Assigned(MyLocalPrinter) then
    FreeAndNil(MyLocalPrinter);

  if Assigned(fStore) then
    FreeAndNil(fStore);

  if Assigned(fUser) then
    FreeAndNil(fUser);

  if Assigned(fCashRegister) then
    FreeAndNil(fCashRegister);

  if Assigned(fPrintReceipt) then
    FreeAndNil(fPrintReceipt);

  if Assigned(fInvoice) then
    FreeAndNil(fInvoice);

  if Assigned(fPOSImportFiles) then
    FreeAndNil(fPOSImportFiles);

  if Assigned(fPOS) then
    FreeAndNil(fPOS);

  if Assigned(FFrmWait) then
    FreeAndNil(FFrmWait);

  if Assigned(fMRPOSColor) then
    FreeAndNil(fMRPOSColor);

  if Assigned(fModuloFiscal) then
    FreeAndNil(fModuloFiscal);

  if Assigned(fCupomFiscal) then
    FreeAndNil(fCupomFiscal);

  if Assigned(fKeyFunctionFile) then
    FreeAndNil(fKeyFunctionFile);

  if Assigned(FTraceControl) then
    FreeAndNil(FTraceControl);

  if Assigned(PrinterFile) then
    FreeAndNil(PrinterFile);

  fPoleDisplay.Free;

  if Assigned(fInvPoleDisplay) then
    FreeAndNil(fInvPoleDisplay);

  FrmServrInfo.Free;

  FSaleWritter.Free;

  CDSImport.Free;

  if Assigned(fStoreList) then
    FreeAndNil(fStoreList);

end;

function TDM.IsCheck(IDPay:String; var CodBank:String):Boolean;
begin
  with quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'Select M.Tipo, B.CodigoBanco from MeioPag M ' +
                'JOIN MeioPagToStore MPS ON (MPS.IDMeioPag = M.IDMeioPag) ' +
                'LEFT OUTER JOIN Fin_ContaCorrente CC ON (MPS.IDContaCorrente = CC.IDContaCorrente) ' +
                'LEFT OUTER JOIN Fin_Banco B ON (B.IDBanco = CC.IDBanco) ' +
                'Where M.IDMeioPag = ' + IDPay +
                ' AND MPS.IDStore = ' + IntToStr(fStore.ID) ;
    Open;
    CodBank := FieldByName('CodigoBanco').AsString;
    Result  := (FieldByName('Tipo').AsInteger = QuitacaoMeioTipo_Cheque);
    Close;
  end;
end;

function TDM.DynamicRunSQL(ACaller: TComponent; sSQL: String): Boolean;
begin
  Result := True;
  try
    with TAdoQuery.Create(Self) do
    try
      Connection := DM.ADODBConnect;
      LockType   := ltReadOnly;
      SQL.Text   := sSQL;
      ExecSQL;
    finally
      Close;
      Free;
    end;
  except
    on E:Exception do
    begin
      Result := False;
      SetError(CRITICAL_ERROR, ACaller.Name, 'DM.DynamicRunSQL' + #13#10 + E.Message);
    end;
  end;
end;

procedure TDM.EFiscal1AfterReducaoZ(Sender: TObject);
var
  RegTipo60Mestre : TRegTipo60Mestre;
  VetTipo60Analitico : TVetTipo60Analitico;
begin
  inherited;
  {
  if FPersistenceType = ptDB then
    if EFiscal1.RelatorioTipo60Mestre(RegTipo60Mestre) then
    begin
      if PersisteTipo60Mestre(RegTipo60Mestre) then
        if EFiscal1.RelatorioTipo60Analitico(VetTipo60Analitico) then
          PersisteTipo60Analitico(VetTipo60Analitico);
    end;
  }
end;

function TDM.PersisteTipo60Mestre(RegTipo60Mestre : TRegTipo60Mestre): Boolean;
var
  bFound: Boolean;
begin
  Result := True;
  try
    with quFreeSQL, RegTipo60Mestre do
    try
      if Active then
         Close;
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('  NumeroSerie');
      SQL.Add('FROM');
      SQL.Add('  Fis_Registro60Mestre');
      SQL.Add('WHERE');
      SQL.Add(Format('  NumeroSerie = %S AND', [QuotedStr(sNumeroSerie)]));
      SQL.Add(Format('  DataEmissao = CONVERT(datetime, %S, 3)', [FormatDateTime('dd/mm/yy', dDataEmissao)]));
      Open;
      bFound := not IsEmpty;
    finally
      Close;
    end;

    if Not bFound then
    with quFreeSQL, RegTipo60Mestre Do
    begin
      if Active then
       Close;

      SQL.Clear;
      SQL.Add('INSERT INTO Fis_Registro60Mestre');
      SQL.Add('  (NumeroSerie, DataEmissao, NumeroOrdem, ModeloDocumentoFiscal,');
      SQL.Add('   NumeroInicialDia, NumeroFinalDia, NumeroReducao, NumeroReinicioOperacao,');
      SQL.Add('   ValorVendaBruta, ValorTotalGeral)');
      SQL.Add('   VALUES');
      SQL.Add(Format('  (%S, Convert(DateTime, %S, 3), %D, %S, %D, %D, %D, %D, %S, %S )',
                    [QuotedStr(sNumeroSerie), QuotedStr(FormatDateTime('dd/mm/yy', dDataEmissao)),
                     nNumeroOrdem, QuotedStr(sModelo), nContInicio, nContFim,
                     nContReducaoZ, nContReinicio, MyFormatCur(nVendaBruta, '.'), MyFormatCur(nTotalGeral, '.')]));
      ExecSQL;
    end;
  except
    on E:Exception do
    begin
      Result := False;
      SetError(CRITICAL_ERROR, SELF.Name, 'DM.PersisteTipo60Mestre' + #13#10 + E.Message);
    end;
  end;
end;

function TDM.PersisteTipo60Analitico(VetTipo60Analitico : TVetTipo60Analitico): Boolean;
var
  I: Integer;
  bFound: Boolean;
begin
  Result := True;
  try
    for I := 0 To Length(VetTipo60Analitico) - 1 do
    begin
      with quFreeSQL, VetTipo60Analitico[I] do
        try
          if Active then
            Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('  NumeroSerie');
          SQL.Add('FROM');
          SQL.Add('  Fis_Registro60Analitico');
          SQL.Add('WHERE');
          SQL.Add(Format('  NumeroSerie = %S AND', [QuotedStr(sNumeroSerie)]));
          SQL.Add(Format('  DataEmissao = Convert(DateTime, %S, 3) AND', [QuotedStr(FormatDateTime('dd/mm/yy', dDataEmissao))]));
          SQL.Add(Format('  SituacaoTributaria = %S', [QuotedStr(sSitTributaria)]));
          Open;
          bFound := not IsEmpty;
        finally
          Close;
        end;

        if not bFound then
        with quFreeSQL, VetTipo60Analitico[I] Do
        begin
          if Active then
            Close;

          SQL.Clear;
          SQL.Add('INSERT INTO Fis_Registro60Analitico');
          SQL.Add('  (NumeroSerie, DataEmissao, SituacaoTributaria, ValorAcumuladoParcial)');
          SQL.Add('   VALUES');
          SQL.Add(Format('  (%S, Convert(DateTime, %S, 3), %S, %S)',
                         [QuotedStr(sNumeroSerie), QuotedStr(FormatDateTime('dd/mm/yy', dDataEmissao)),
                          QuotedStr(sSitTributaria), MyFormatCur(nVlrAcumTotPar, '.')]));
          ExecSQL;
        end;
    end;
  except
    on E:Exception do
    begin
      Result := False;
      SetError(CRITICAL_ERROR, SELF.Name, 'DM.PersisteTipo60Analitico' + #13#10 + E.Message);
    end;
  end;
end;

function TDM.SelectReturnsRow(ACaller: TComponent; ASQL: String): Boolean;
begin
  try
    with TAdoQuery.Create(Self) Do
    try
      Connection := DM.ADODBConnect;
      LockType   := ltReadOnly;
      SQL.Text   := ASQL;
      Open;
      Result := not IsEmpty;
    finally
      Close;
      Free;
    end;
  except
    on E:Exception do
    begin
      Result := False;
      SetError(CRITICAL_ERROR, ACaller.Name, 'DM.DynamicRunSQL' + #13#10 + E.Message);
    end;
  end;
end;

function TDM.POSScript: Boolean;
var
  FrmPOSSQL: TFrmPOSSQL;
begin
  FrmPOSSQL := TFrmPOSSQL.Create(Self);
  try
    Result := FrmPOSSQL.GenerateAll;
  finally
    FreeAndNil(FrmPOSSQL);
  end;
end;

function TDM.TableFieldExists(ATableName, AFieldName: String): Boolean;
begin
  with CreateADOQuery do
  try
    SQL.Add('SELECT');
    SQL.Add('	SC.name');
    SQL.Add('FROM');
    SQL.Add('	sysobjects O');
    SQL.Add('	INNER JOIN syscolumns SC ON (O.id = SC.id)');
    SQL.Add('WHERE');
    SQL.Add('	O.xtype = ' + QuotedStr('U'));
    SQL.Add('	AND');
    SQL.Add('	O.Name = '+ QuotedStr(ATableName));
    SQL.Add('	AND');
    SQL.Add('	SC.name = '+ QuotedStr(AFieldName));
    Open;
    Result := not IsEmpty;
  finally
    Close;
    Free;
  end;
end;

procedure TDM.TEFDial1Dialog(Sender: TObject;
  MessageType: TTEFDialMessageType; NeedUserOK: Boolean);
var
  sTitle, sMensagem : String;
begin
  case MessageType of
    mtCliente:
      begin
        sTitle    := 'Mensagem para o Cliente';
        sMensagem := TTEFDial(Sender).TextoEspCliente;
      end;
    mtOperador:
      begin
        sTitle    := 'Mensagem para o Operador';
        sMensagem := TTEFDial(Sender).TextoEspOperador;
      end;
    mtPendencia:
      begin
        Application.ProcessMessages;
        sTitle    := 'Cancelada a Transação:';
        with TStringList.Create do
        begin
          if TTEFDial(Sender).NomeRede <> '' then
            Add('Rede: '+TTEFDial(Sender).NomeRede);

          if TTEFDial(Sender).NSU <> '' then
            Add('NSU: '+TTEFDial(Sender).NSU);

          if TTEFDial(Sender).ValorAprovado <> 0 then
            Add('Valor: '+FormatFloat('0.00', TTEFDial(Sender).ValorAprovado));

          sMensagem := GetText;
          Free;
        end;
      end;
    mtAtividade :
      begin
        sTitle    := 'Mensagem para o Operador';
        sMensagem := 'O Gerenciador Padrão está ativo';
      end;
    mtInatividade :
      begin
        sTitle    := 'Mensagem para o Operador';
        sMensagem := 'O Gerenciador Padrão NÃO está ativo';
      end;

  end;

  if TTEFDial(Sender).TemCupom and not (MessageType in [mtPendencia, mtAtividade, mtInatividade]) then
    MsgTEF(sTitle, sMensagem)
  else
    Application.MessageBox(PChar(sMensagem), PChar(sTitle), MB_OK + MB_ICONINFORMATION);
end;

function TDM.CreateADOQuery: TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  try
    Result.Connection := ADODBConnect;
  except
    FreeAndNil(Result);
    Raise;
  end;
end;

procedure TDM.TEFDial1NeedOpenVinculado(Sender: TObject;
  AVinculadoInfo: TVinculadoInfo; var Opened: Boolean);
begin
  inherited;
  if fCashRegister.fUseTef in [TEF_DIAL, TEF_DEDICADO] then
    Opened := EFiscal1.AbreCupomVinculado(AVinculadoInfo.CupomVinculado,
                                           AVinculadoInfo.FormaPagamento,
                                           '',
                                           DMPDV.GetECFVinIndex(AVinculadoInfo.IDMeioPag),
                                           FloatToStr(AVinculadoInfo.ValorAprovado))
  else
    Opened := True;

end;

procedure TDM.TEFDial1NeedPrintLineVinculado(Sender: TObject;
  LineToPrint: String; var LinePrinted: Boolean);
begin
  if fCashRegister.fUseTef in [TEF_DIAL, TEF_DEDICADO] then
    LinePrinted := EFiscal1.TextoCupomVinculado(LineToPrint)
  else
    LinePrinted := True;
end;

procedure TDM.TEFDial1NeedCloseVinculado(Sender: TObject;
  var Closed: Boolean);
var
  sResult : String;
begin
  if fCashRegister.fUseTef in [TEF_DIAL, TEF_DEDICADO] then
    Closed := EFiscal1.FechaCupomVinculadoSemErro('')
  else
    Closed := True;

  if Closed then
  begin
    fCupomFiscal.DataHora := DM.EFiscal1.DataImpressora;

  case EFiscal1.Impressora of
    BematechMP20, BematechMP40:
    begin
      fCupomFiscal.FCOO := 0;
      fCupomFiscal.FGNF := 0;
      fCupomFiscal.FCDC := 0;
    end;

    BematechTermica:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);

      EFiscal1.ContadorComprovantesCreditoMFD(sResult);
      fCupomFiscal.FCDC := StrToInt(sResult);
    end;

    DarumaTerm:
    begin
      EFiscal1.RetornaInformacao('26', 6, sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.RetornaInformacao('28', 6, sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);

      EFiscal1.RetornaInformacao('45', 4, sResult);
      fCupomFiscal.FCDC := StrToInt(sResult);
    end;

    Elgin:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);

      EFiscal1.ContadorComprovantesCreditoMFD(sResult);
      fCupomFiscal.FCDC := StrToInt(sResult);
    end;

  end;

    case PersistenceType of
    ptDB: fPOS.AddVinculadoInfo(TEFDial1.IDPreSale,
                          fCupomFiscal.FCOO,
                          fCupomFiscal.FGNF,
                          fCupomFiscal.FCDC,
                          fCupomFiscal.DataHora);

    ptTXT: SaleWritter.AddVinculadoInfo(fCupomFiscal.FCOO,
                          fCupomFiscal.FGNF,
                          fCupomFiscal.FCDC,
                          fCupomFiscal.DataHora);
    end;
  end;

end;

procedure TDM.TEFDial1NeedOpenGerencial(Sender: TObject;
  var Opened: Boolean);
begin
  if fCashRegister.fUseTef in [TEF_DIAL, TEF_DEDICADO] then
    Opened := EFiscal1.AbreRelatorioGerencial('')
  else
    Opened := true;
end;

procedure TDM.TEFDial1NeedPrintLineGerencial(Sender: TObject;
  LineToPrint: String; var LinePrinted: Boolean);
begin
  if fCashRegister.fUseTef in [TEF_DIAL, TEF_DEDICADO] then
    LinePrinted := EFiscal1.RelatorioGerencial(LineToPrint)
  else
    LinePrinted := True;
end;

procedure TDM.TEFDial1NeedCloseGerencial(Sender: TObject;
  var Closed: Boolean);
begin
  if fCashRegister.fUseTef in [TEF_DIAL, TEF_DEDICADO] then
    Closed := EFiscal1.FechaRelatorioGerencial
  else
    Closed := True;
end;

procedure TDM.TEFDial1TryAgainDialog(Sender: TObject;
  var TryAgain: Boolean);
begin
  inherited;
  TryAgain := (MsgBox('Impressora não responde. Tentar novamente ?', vbYesNo +vbQuestion) = vbYes);
end;

function TDM.GetFunction(Key: Word): Integer;
begin
  Result := fKeyFunctionFile.ReadInteger('Keys', IntToStr(Key), -1);
end;

procedure TDM.SetFunction(Key: Word; Func: Integer);
begin
  fKeyFunctionFile.WriteInteger('Keys', IntToStr(Key), Func);
end;

procedure TDM.MsgTEF(ATitle, ACaption: String);
begin
  with TFrmMsgTEF.Create(Self) do
  begin
    Caption        := ATitle;
    Label1.Caption := ACaption;
    Application.ProcessMessages;
    Show;
    Application.ProcessMessages;
    Sleep(5000);
    Close;
    free;
  end;
end;

procedure TDM.TEFDial1StatusPrinter(Sender: TObject; var Online: Boolean);
begin
  Online := DM.EFiscal1.VerificaImpressoraLigadaTEF;
end;

{ TCashRegister }

constructor TCashRegister.Create;
var
  buildInfo: String;
begin
  inherited Create;
  MyReg         := TRegistry.Create;

  if ( getOS(buildInfo) = osW7 ) then
     MyReg.RootKey := HKEY_CURRENT_USER
  else
      MyReg.RootKey := HKEY_LOCAL_MACHINE;

  MyReg.OpenKey(REGISTRY_PATH, True);
end;

destructor TCashRegister.Destroy;
begin
  if Assigned(MyReg) then
     FreeAndNil(MyReg);
  inherited Destroy;
end;

procedure TDM.PrepareCDS(CDS:TClientDataset; Tabela: String; IndexField: String = ''; AOpen: Boolean = True);
begin
  CDS.Close;
  case PersistenceType of
    ptDB:
      if AOpen then
        CDS.Open;
    ptTXT:
      CDS.LoadFromFile(ExtractFilePath(Application.ExeName) + MIRROR_DIR + Tabela + '.xml');
  end;
end;

function TDM.GetPersistenceIni: String;
begin
  Result := ExtractFilePath(Application.ExeName) + MIRROR_DIR + 'MRPDVPersistence.ini';
end;

function TCashRegister.GetFiscal: Boolean;
begin
  fFiscal := MyReg.ReadBool('FiscalMode') and fFiscalPrinter;
  Result  := fFiscal;
end;

procedure TCashRegister.SetSalesFileName(const Value: String);
var
  iCount: Integer;
  sNewLastSalesFiles: String;
  SaleFileList : TStringList;
  buildInfo: String;
begin
  FSalesFileName := Value;
  SaleFileList := TStringList.Create;

  SaleFileList.Delimiter := ';';
  SaleFileList.DelimitedText := FLastSalesFiles;

  if (SaleFileList.Count > 0) then
    SaleFileList.Delete(SaleFileList.Count-1);

  with TRegistry.Create do
  try
    try

      if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
      else
        RootKey := HKEY_LOCAL_MACHINE;

      OpenKey('\' + REGISTRY_PATH_POS, True);
      WriteString('SalesFileName', Value);

      if (Value <> '') then
      begin
        if (SaleFileList.Count = 0) then
          WriteString('LastSalesFiles', FSalesFileName + ';')
        else if (Pos(Value, FLastSalesFiles) = 0) then
        begin
          if SaleFileList.Count >= FSalesFilesToExp then
            SaleFileList.Delete(SaleFileList.Count-1);

          FLastSalesFiles := FSalesFileName + ';';
          for iCount := 0 to SaleFileList.Count-1 do
            if SaleFileList.Strings[iCount] <> '' then
              FLastSalesFiles := FLastSalesFiles + SaleFileList.Strings[iCount] + ';';

          WriteString('LastSalesFiles', FLastSalesFiles);
        end;
      end;
    except
      on E: Exception do
        MsgBox(E.Message, vbCritical + vbOKOnly);
    end;
  finally
    Free;
    FreeAndNil(SaleFileList);
  end;
end;

function TDM.FiltraCDS(CDS : TClientDataset; Filtro: String): Boolean;
begin
  CDS.Filtered := False;
  CDS.Filter   := Filtro;
  CDS.Filtered := True;
  Result       := not CDS.IsEmpty;
end;

function TDM.CreateSaleCodeTXT(COO: String): String;
var
  iSaleCodeTXT: Integer;
  buildInfo: String;
begin
  if (COO = '') or (COO = CUPOM_VAZIO) then
    with TRegistry.Create do
    begin

      if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
      else
        RootKey := HKEY_LOCAL_MACHINE;

      OpenKey(REGISTRY_PATH_POS, True);

      iSaleCodeTXT := ReadInteger('SaleCodeTXT');
      WriteInteger('SaleCodeTXT', iSaleCodeTXT + 1);

      Result := IntToStr(iSaleCodeTXT);
    end
  else
    Result := COO;
end;

function TDM.UpdatePOS: Boolean;
begin
  Result := False;

  if not fPOSImportFiles.CanUpdate then
    Exit;

  if fPOSImportFiles.LastImportDate = GetServerTXTDate then
    Exit;

  fPOSImportFiles.CanUpdate := False;
  try
    DMPDV.AbreTabelas;
  finally
    fPOSImportFiles.CanUpdate := True;
  end;
end;

function TDM.GetServerTXTDate: TDateTime;
begin
  //Pega a data e hora do servidor
  Result := Now;
end;

function TDM.CanImportServerTXT: Boolean;
begin
  //Verifica se o server asta rodando os arquivos
  Result := True;
end;

function TDM.OpenHold(SaleCode: String): Boolean;
var
  sPreInventoryMovIDs: String;
  iIDPreSale : Integer;
  bLayaway : Boolean;
begin
  Result := False;

  with quCheckPayments do
  try
      Parameters.ParamByName('SaleCode').Value := SaleCode;
      Open;

      if not IsEmpty then
      begin
        Result     := (quCheckPayments.FieldByName('AmountPaid').AsCurrency = 0);
        iIDPreSale := quCheckPayments.FieldByName('IDPreSale').AsInteger;
        bLayaway   := quCheckPayments.FieldByName('Layaway').AsBoolean;
      end;

      if not Result then
        Exit
      else
      begin
        if bLayaway then
          DM.RunSQL('UPDATE Invoice Set Layaway = 0 Where IDPreSale = ' + IntToStr(iIDPreSale));
      end;
  finally
    Close;
  end;

  with quNegativeItems do
  try
    Parameters.ParamByName('SaleCode').Value := SaleCode;
    Open;
    Result := IsEmpty;
    if not Result then
      Exit;
  finally
    Close;
  end;

  with quPreSale do
    if not Active then
    begin
      Parameters.ParamByName('SaleCode').Value := SaleCode;
      Open;
      Result := (RecordCount <> 0) and (quPreSaleAditionalExpenses.AsCurrency = 0);
    end;

  if not Result then
    Exit;

  with quPreSaleItem do
    if not Active then
      Open;

  sPreInventoryMovIDs := GetPreInventoryMovIDs;

  OpenSaleItemCommission(sPreInventoryMovIDs);
  OpenPreSerialMov(sPreInventoryMovIDs);
  OpenMovDocument(sPreInventoryMovIDs);

  //Homologacao BA
  //fPOS.DeleteHold(iIDPreSale, DM.fUser.ID);

  if Result then
    if fStartPoleDisplay then
    begin
      PoleDisplayInvInfo(SaleCode,
                         quPreSale.FieldByName('PreSaleDate').AsDateTime,
                         quPreSale.FieldByName('AditionalExpenses').AsCurrency,
                         (quPreSale.FieldByName('InvoiceDiscount').AsCurrency + quPreSale.FieldByName('ItemDiscount').AsCurrency),
                         0,
                         quPreSale.FieldByName('SubTotal').AsCurrency);
    end;
end;

procedure TDM.CloseHold;
begin
  with quPreSaleItem do
    if Active then
      Close;

  with quPreSale do
    if Active then
      Close;

  //Fechar a conneccao se for Texto
  if PersistenceType = ptTXT then
    DatabaseCloseConnection;
end;

function TDM.HoldExist(IDPreSale: Integer): Boolean;
begin
  with quFreeSQL do
    try
      SQl.Text := 'Select IDPreSale From Invoice Where IDPreSale = ' + IntToStr(IDPreSale) +
                  ' AND IDInvoice IS NULL ';
      Open;
      Result := not IsEmpty;
      Close;
    except
      Result := False;
    end;
end;

function TDM.DeleteHoldItens(IDPreSale: Integer): Boolean;
var
  iErro : Integer;
begin
  Result := True;

  try

    with quFreeSQL do
    try
      if Active then
      Close;
      SQL.Clear;
      SQL.Add('SELECT IDPreInventoryMov, ModelID, Qty, Discount, SalePrice, CostPrice ');
      SQL.Add('FROM PreInventoryMov');
      SQL.Add('WHERE DocumentID = ' + IntToStr(IDPreSale) + ' AND InventMovTypeID = 1');
      Open;
      First;

      while not EOF do
      begin
        fPOS.DeleteHoldItem(IDPreSale,
                            FieldByName('IDPreInventoryMov').AsInteger,
                            FieldByName('ModelID').AsInteger,
                            fUser.ID,
                            FieldByName('Qty').AsFloat,
                            FieldByName('Discount').AsCurrency,
                            FieldByName('SalePrice').AsCurrency,
                            True, True, Now, iErro);

        if iErro <> 0 then
          raise exception.Create('Erro removendo itens do pedido!');

        Next;
      end;

    finally
      Close;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      MsgBox(E.Message, vbCritical);
    end;
  end;
end;

procedure TDM.DatabaseCloseConnection;
begin
  ADOConnectionClose;
end;

function TDM.DatabaseOpenConnection: Boolean;
var
  sResult : String;
  bAbort  : Boolean;
begin
  Result := True;

  if PersistenceType = ptDB then
    Exit;

  sResult := FrmServrInfo.Start(fSystem.StartMode, False, '', bAbort);
  Result  := False;

  if sResult = '' then
    Exit;

  try
    ADOConnectionString := BuildServerConnection(sResult);
    ADOConnectionOpen;
    Result := True;
  except
    Result := False;
  end;
end;

function TDM.BuildServerConnection(sParans:String): String;
begin
  fSQLConnectParam.Server   := ParseParam(sParans, SV_SERVER);
  fSQLConnectParam.DBAlias  := ParseParam(sParans, SV_DATABASE);
  fSQLConnectParam.UserName := ParseParam(sParans, SV_USER);
  fSQLConnectParam.PW       := ParseParam(sParans, SV_PASSWORD);
  fSQLConnectParam.WinLogin := (ParseParam(sParans, SV_WIN_LOGIN)[1] in ['Y']);
  fSQLConnectParam.Status   := SQL_STATUS_NO_CONNECTED;

  if not fSQLConnectParam.WinLogin then
    Result := SetConnectionStrNoNETLIB(fSQLConnectParam.UserName,
                                       fSQLConnectParam.PW,
                                       fSQLConnectParam.DBAlias,
                                       fSQLConnectParam.Server)
  else
    Result := SetWinConnectionStrNoNETLIB(fSQLConnectParam.DBAlias,
                                          fSQLConnectParam.Server);

end;

procedure TDM.CopyServerFiles;
var
  SR: TSearchRec;
  sLocal: String;
begin
  sLocal := ExtractFilePath(Application.ExeName) + MIRROR_DIR;
  if not DirectoryExists(sLocal) then
    ForceDirectories(sLocal);
  try
    if FindFirst(fCashRegister.FServerFilesDir + '*.*', faAnyFile, SR) = 0 then
    repeat
      if (SR.Attr and faDirectory) = 0 then
        CopyFile(PChar(fCashRegister.FServerFilesDir + SR.Name), PChar(sLocal + ExtractFileName(SR.Name)), False);
    until FindNext(SR) <> 0;
  except
  end;
end;

function TDM.GetStoreUsersFilter(CDS : TClientDataset): String;
begin
  Result := '';

  with CDS do
  try
    First;
    while not EOF do
    begin
      if ValidateStore(FieldByName('StoresAccess').AsString, IntToStr(fStore.ID)) then
      begin
        if Result <> '' then
          Result := Result + ' OR ';
          Result := Result + 'IDUser = ' + FieldByName('IDUser').AsString
      end;
    Next;
  end;
  finally

  end;
end;

function TDM.ValidateStore(StoreList, IDStore: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  fStoreList.CommaText := StoreList;

  for i := 0 to fStoreList.Count-1 do
    if fStoreList.Strings[i] = IDStore then
    begin
      Result := True;
      Break;
    end;
end;

function TDM.DecHold(IDPreSale: Integer): Boolean;
begin
  Result := True;

  with cmdFreeSQL do
  begin
    CommandText := 'UPDATE Invoice SET nOpenHoldCaixa = IsNull(nOpenHoldCaixa,0) - 1 ' +
                   'WHERE IDPreSale = ' + IntToStr(IDPreSale);
    try
      Execute;
    except
      Result := False;
    end;
  end;
end;

function TDM.IncHold(IDPreSale: Integer): Boolean;
begin
  Result := True;

  with cmdFreeSQL do
  begin
    CommandText := 'UPDATE Invoice SET nOpenHoldCaixa = IsNull(nOpenHoldCaixa,0) + 1 ' +
                   'WHERE IDPreSale = ' + IntToStr(IDPreSale);
    try
      Execute;
    except
      Result := False;
    end;
  end;
end;

function TDM.GetDataEmissaoECF: TDateTime;
var
  sData : String;
  sDataReducao,  sHoraReducao : String;
begin
  SetLength(sDataReducao, 6);
  SetLength(sHoraReducao, 6);
  EFiscal1.DataHoraReducao(sDataReducao, sHoraReducao);
  sData := sDataReducao + sHoraReducao;
  Result := EFiscal1.FormatarDataHoraImpressora(sData);
end;


{ TModuloFiscal }

function TModuloFiscal.CopareDate15min(ADate1, ADate2: TDateTime): Boolean;
var
   AD1Day, AD1Month, AD1Year, AD1Hour, AD1Minute, AD1Second, AD1MilliSecond: Word;
   AD2Day, AD2Month, AD2Year, AD2Hour, AD2Minute, AD2Second, AD2MilliSecond: Word;
begin
  Result := False;

  DecodeDateTime(ADate1, AD1Day, AD1Month, AD1Year, AD1Hour, AD1Minute, AD1Second, AD1MilliSecond);
  DecodeDateTime(ADate2, AD2Day, AD2Month, AD2Year, AD2Hour, AD2Minute, AD2Second, AD2MilliSecond);

  if (AD1Day = AD2Day) and (AD1Month = AD2Month) and (AD1Year = AD2Year) and (AD1Hour = AD2Hour) then
    if Abs(AD1Minute - AD2Minute) <= 15  then
      Result := True;

  if not Result then
    ShowMessage('Data do Sistema e da Impressora fiscal não sincronizados');
end;

function TModuloFiscal.ValidateSystemDate: Boolean;
var
  ServerSysTime : TSystemTime;
begin
  Result := True;

  DM.fModuloFiscal.PrinterDate := DM.EFiscal1.DataImpressora;

  if Trunc(DM.fModuloFiscal.PrinterDate) <> Trunc(NOW) then
  begin
    DM.fModuloFiscal.PrinterDate := DM.EFiscal1.DataImpressora;
    if Trunc(DM.fModuloFiscal.PrinterDate) <> Trunc(NOW) then
    begin
      Result := False;
      MsgBox('Data do Sistema e da Impressora fiscal não sincronizados', vbOKOnly + vbCritical);
    end;
  end;

  //Homologacao BA
  //Verificar essa funcao, pois se a hora for diferente nao funciona
  //Result := CopareDate15min(DM.fModuloFiscal.PrinterDate, Now);

end;

function TDM.DadosReducaoZ: TRegReducaoZ;
var
  i: Integer;
  DadosReducaoZ: TRegDadosReducaoZ;
begin

  if fCashRegister.FiscalPrinter then
  begin
    try
      ShowWait;

      EFiscal1.DadosReducaoZ(DadosReducaoZ);

      Result.AMovDate := DadosReducaoZ.AMovDate;

      case EFiscal1.Impressora of
        BematechTermica:
        begin
          Result.ANumeroSerie      := DM.fModuloFiscal.ECFSerial;
          Result.ACOOInicial       := 0;
          Result.ACOOFinal         := 0;
          Result.ANumeroECF        := DM.fModuloFiscal.NumeroECF;
          Result.ANumeroLoja       := DM.fModuloFiscal.NumeroLoja;
        end;

        Sweda03, Sweda10:
        begin
          Result.ANumeroSerie         := DM.fModuloFiscal.ECFSerial;
          Result.ACOOInicial          := 0;
          Result.ACOOFinal            := 0;
          Result.ANumeroECF           := DM.fModuloFiscal.NumeroECF;
          Result.ANumeroLoja          := DM.fModuloFiscal.NumeroLoja;
        end;

        Elgin:
        begin
          Result.ANumeroSerie         := DM.fModuloFiscal.ECFSerial;
          Result.ACOOInicial          := DadosReducaoZ.ACOOInicial;
          Result.ACOOFinal            := DadosReducaoZ.ACOOFinal;
        end
        else
        begin
          Result.ANumeroSerie      := DadosReducaoZ.ANumeroSerie;
          Result.ACOOInicial       := DadosReducaoZ.ACOOInicial;
          Result.ACOOFinal         := DadosReducaoZ.ACOOFinal;
          Result.ANumeroECF        := DadosReducaoZ.ANumeroECF;
          Result.ANumeroLoja       := DadosReducaoZ.ANumeroLoja;
        end;
      end;

      Result.ANumReducaoZ      := DadosReducaoZ.ANumReducaoZ;
      Result.ANumCancelamentos := DadosReducaoZ.ANumCancelamentos;
      Result.AValCancelamentos := DadosReducaoZ.AValCancelamentos;
      Result.AValDescontos     := DadosReducaoZ.AValDescontos;
      Result.AGTInicial        := DadosReducaoZ.AGTInicial;
      Result.AGTFinal          := DadosReducaoZ.AGTFinal;
      Result.ASubstituicaoTrib := DadosReducaoZ.ASubstituicaoTrib;
      Result.AIsencao          := DadosReducaoZ.AIsencao;
      Result.ANaoTributavel    := DadosReducaoZ.ANaoTributavel;

      for i := 0 to Pred(Length(DadosReducaoZ.AAliquota)) do
      begin
        SetLength(Result.AAliquota, Length(Result.AAliquota)+1);
        Result.AAliquota[i] := DadosReducaoZ.AAliquota[i];

        SetLength(Result.ABaseCalculo, Length(Result.ABaseCalculo)+1);
        Result.ABaseCalculo[i] := DadosReducaoZ.ABaseCalculo[i];

        SetLength(Result.AValImposto, Length(Result.AValImposto)+1);
        Result.AValImposto[i] := DadosReducaoZ.AValImposto[i];
      end;

      case EFiscal1.Impressora of
        BematechTermica,
        Elgin, Sweda03, Sweda10 :
          begin
            Result.ATipoECF                  := DM.fModuloFiscal.TipoECF;
            Result.AMarcaECF                 := DM.fModuloFiscal.MarcaECF;
            Result.AModeloECF                := DM.fModuloFiscal.ModeloECF;
            Result.ADataInstalacaoSBECF      := DM.fModuloFiscal.DataInstalECF;
            Result.AMFAdicional              := DM.fModuloFiscal.MFAdicional;
            Result.ANumeroUsuarioECF         := DM.fModuloFiscal.NumeroUsuarioECF;
            Result.ADataEmissao              := GetDataEmissaoECF;
            Result.AVersaoSBECF              := DM.fModuloFiscal.VersaoSBECF;
          end
        else
        begin
          Result.ATipoECF                  := DadosReducaoZ.ATipoECF;
          Result.AMarcaECF                 := DadosReducaoZ.AMarcaECF;
          Result.AModeloECF                := DadosReducaoZ.AModeloECF;
          Result.ADataInstalacaoSBECF      := DadosReducaoZ.ADataInstalacaoSBECF;
          Result.AMFAdicional              := DadosReducaoZ.AMFAdicional;
          Result.ANumeroUsuarioECF         := DadosReducaoZ.ANumeroUsuarioECF;
          Result.ADataEmissao              := DadosReducaoZ.ADataEmissao;
          Result.AVersaoSBECF              := DadosReducaoZ.AVersaoSBECF;
        end;
      end;

      Result.AContadorReducaoZ         := DadosReducaoZ.AContadorReducaoZ;
      Result.AContadorOrdemOperacao    := DadosReducaoZ.AContadorOrdemOperacao;
      Result.AContadorReinicioOperacao := DadosReducaoZ.AContadorReinicioOperacao;
      Result.AIncideISSQN              := DadosReducaoZ.AIncideISSQN;

      for i := 0 to Pred(Length(DadosReducaoZ.ATribReducaoZList)) do
      begin
        SetLength(Result.ATribReducaoZList, Length(Result.ATribReducaoZList)+1);
        Result.ATribReducaoZList[i].Codigo := DadosReducaoZ.ATribReducaoZList[i].Codigo;
        Result.ATribReducaoZList[i].ValorAcumulado := DadosReducaoZ.ATribReducaoZList[i].ValorAcumulado;
      end;
  finally
    HideWait;
  end;

  end
  else
    Result.ANumeroSerie := '';

end;

procedure TDM.SendAfterPrintCode(StartPrinter: Boolean);
begin
  if fCashRegister.AfterPrintCode <> '' then
    SendCashCode(fCashRegister.AfterPrintCode, StartPrinter);
end;

procedure TDM.SendCashCode(ACode: String; NeedCloseOpenDoc: Boolean);
var
  SendCode: String;
  NotOk: Boolean;
begin
  SendCode := GetPrinterCode(ACode);
  NotOk := True;
  Application.ProcessMessages;

  while NotOk do
  try
    if NeedCloseOpenDoc then
      PrinterStart;

    case fPrintReceipt.PrinterType of
      PORT_LPT1,
      PORT_LPT2 : TLPTPrinter(MyLocalPrinter).PrintlnText(SendCode);
      PORT_WIN  : TWindowsPrinter(MyLocalPrinter).SendCommand(SendCode);
    end;

    if NeedCloseOpenDoc then
      PrinterStop;

    NotOk := False;
  except
    if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
      NotOk := True
    else
      Exit;
  end;
end;

function TDM.GetPrinterCode(Code: String): String;
var
  i: Integer;
  SubCode: String;
begin
  SubCode := '';
  Result  := '';

  for i := 1 to Length(Code) do
  begin
    if (Code[i] <> ',') then
      SubCode := SubCode + Code[i];

    if (Code[i] = ',') or (i = Length(Code)) then
    begin
      Result  := Result + Chr(MyStrToInt(SubCode));
      SubCode := '';
    end;
  end;
end;

procedure TDM.TEFDedicado1ExecutaComando21(Sender: TObject; Msg: String;
  var Opcao: String);
begin
  inherited;
  with TFrmOption.Create(self) do
  try
    Opcao := Start(FCabecalhoInput, Msg);
  finally
    Free;
  end;
end;

procedure TDM.TEFDedicado1ExecutaComando23(Sender: TObject; Msg: String;
  var Opcao: String);
begin
  Opcao := '0';
end;

procedure TDM.TEFDedicado1ExecutaComando4(Sender: TObject; Msg: String);
begin
  FCabecalhoInput := Msg;
end;

procedure TDM.TEFDedicado1ExecutaComando20(Sender: TObject; Msg: String;
  var Opcao: String);
begin
  inherited;
  if Pos('?', msg) = 0 then
    msg := msg + '?';

  if MsgBox(msg, vbQuestion + vbYesNo) = vbYes then
    Opcao := '0'
  else
    Opcao := '1';
end;

procedure TDM.MsgBoxScroll(Msg: String);
begin
  with TFrmMsgScroll.Create(Self) do
    Start(Msg);
end;

procedure TDM.TEFDedicado1ExecutaComando34(Sender: TObject; Msg: String;
  TamMin, TamMax: Integer; var CampoInput: Double);
begin
  inherited;
  with TFrmImput.Create(Self) do
  try
    CampoInput := StartDouble(Msg, TamMin, TamMax);
  finally
    Free;
  end;
end;

procedure TDM.TEFDedicado1ExecutaComando31(Sender: TObject; Msg: String;
  var Opcao: String);
var
  FManual : Boolean;
begin
  inherited;
  FManual := (MsgBox('Informar dados do cheque manualmente?', vbQuestion + vbYesNo) = vbYes);

  with TFrmTEFCheque.Create(Self) do
    if FManual then
      Opcao := StartManual(Msg)
    else
      Opcao := StartLeitura(Msg);
end;

procedure TDM.TEFDedicado1ExecutaComando14(Sender: TObject);
begin
  inherited;
  FCabecalhoInput := '';
end;

procedure TDM.LoadTEFDialInfo;
var
  ECFIni: TIniFile;
  stlTipoTEF: TStringList;
  i : Integer;
begin
  FTEFDialTypes := [];

  ECFIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + ECF_CONFIGS);
  try
    stlTipoTEF := TStringList.Create;
    try
      ECFIni.ReadSection('TIPOTEF', stlTipoTEF);
      for I := 0 to stlTipoTEF.Count - 1 do
      begin
        FTEFDialTypes := FTEFDialTypes + [ECFIni.ReadInteger('TIPOTEF', stlTipoTEF[I], 0)];
      end;
    finally
      FreeAndNil(stlTipoTEF);
    end;
  finally
    FreeAndNil(ECFIni);
  end;
end;

procedure TDM.TEFDedicado1ExecutaComando30(Sender: TObject; Msg: String;
  TamMin, TamMax: Integer; var CampoInput: String; const Comando,
  TipoCampo: Integer);
begin
  inherited;
  with TFrmImput.Create(Self) do
  try
    CampoInput := Start(Msg, TamMin, TamMax, False, Comando, TipoCampo);
  finally
    Free;
  end;
end;

procedure TDM.TEFDedicado1ExecutaComandoSenha(Sender: TObject; Msg: String;
  TamMin, TamMax: Integer; var CampoInput: String; const Comando,
  TipoCampo: Integer);
begin
  with TFrmImput.Create(Self) do
  try
    CampoInput := Start(Msg, TamMin, TamMax, True, Comando, TipoCampo);
  finally
    Free;
  end;
end;

procedure TDM.CreatePollDisplay;
begin
  if (fPoleDisplay.FIP <> '') then
  begin
    fInvPoleDisplay := TInvoice.Create;
    fInvPoleDisplay.SetServerInfo(fPoleDisplay.FIP, fPoleDisplay.FPort);
    fStartPoleDisplay := fInvPoleDisplay.ConnectPole;
  end
  else
    fStartPoleDisplay := False;
end;

procedure TDM.PoleDisplayAddItem(AID, AIDModel: Integer; AModel,
  ADescription: String; AQty: Double; ASalePrice, ADiscount: Currency);
begin
  if fStartPoleDisplay and Assigned(fInvPoleDisplay) then
    fInvPoleDisplay.AddItem(AID,
                            AIDModel,
                            AModel,
                            ADescription,
                            AQty,
                            ASalePrice,
                            ADiscount);
end;

procedure TDM.PoleDisplayAddPayment(AID: Integer; APayment: String;
  AAMount: Currency);
begin
  if fStartPoleDisplay and Assigned(fInvPoleDisplay) then
    fInvPoleDisplay.AddPayment(AID,
                               APayment,
                               AAMount);
end;

procedure TDM.PoleDisplayCloseSale;
begin
  if fStartPoleDisplay and Assigned(fInvPoleDisplay) then
  begin
    if not fInvPoleDisplay.ConnectedPole then
      fStartPoleDisplay := fInvPoleDisplay.ConnectPole;

    if fStartPoleDisplay then
      fInvPoleDisplay.CloseSale(fPoleDisplay.FClearSale);
  end;
end;

procedure TDM.PoleDisplayInvInfo(ASaleCode: String; ASaleDate: TDatetime;
  AAddCostTotal, ADiscountTotal, ATaxTotal, ASubTotal: Currency; UpdateFile : Boolean = False);
begin
  if fStartPoleDisplay and Assigned(fInvPoleDisplay) then
    fInvPoleDisplay.InvoiceInfo(ASaleCode,
                                ASaleDate,
                                AAddCostTotal,
                                ADiscountTotal,
                                ATaxTotal,
                                ASubTotal,
                                UpdateFile);
end;

procedure TDM.PoleDisplayDeleteItem(AID: Integer);
begin
  if fStartPoleDisplay and Assigned(fInvPoleDisplay) then
    fInvPoleDisplay.DeleteItem(AID, True);
end;

procedure TDM.PoleDisplayDeletePayment(AID: Integer);
begin
  if fStartPoleDisplay and Assigned(fInvPoleDisplay) then
    fInvPoleDisplay.DeletePayment(AID, True);
end;

function TDM.PoleDisplayStatus: Boolean;
begin
  Result := False;

  if Assigned(fInvPoleDisplay) then
    Result := fInvPoleDisplay.ConnectedPole;
end;

procedure TDM.RefreshPoleDisplay;
begin
  if Assigned(fInvPoleDisplay) then
  begin
    fStartPoleDisplay := True;
    PoleDisplayCloseSale;
  end;
end;

procedure TDM.OpenSaleItemCommission(APreInventoryMovIDs: String);
begin
  if APreInventoryMovIDs <> '' then
    with quSaleItemCommission do
    begin
      if Active then
        Close;
      CommandText := 'SELECT ' +
                     '  IDPreInventoryMov, ' +
                     '  IDCommission ' +
                     'FROM ' +
                     '  SaleItemCommission ' +
                     'WHERE ' +
                     '  IDPreInventoryMov in (' + APreInventoryMovIDs + ')';
      Open;
    end;
end;

function TDM.GetCommission(AIDPreInvMov: Integer): Integer;
begin
  Result := 0;
  with quSaleItemCommission do
  try
    First;
    while not Eof do
    begin
      if AIDPreInvMov = FieldByName('IDPreInventoryMov').AsInteger then
      begin
        Result := FieldByName('IDCommission').AsInteger;
        Exit;
      end;

      Next;
    end;
  finally
    First;
  end;
end;

function TDM.GetPreInventoryMovIDs: String;
begin
  Result := '';

  with quPreSaleItem do
  try
    First;
    while not Eof do
    begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + FieldByName('IDPreInventoryMov').AsString;
      Next;
    end;
  finally
    First;
  end;
end;

procedure TDM.OpenPreSerialMov(APreInventoryMovIDs: String);
begin
  if APreInventoryMovIDs <> '' then
    with quPreSerialMov do
    begin
      if Active then
        Close;
      CommandText := 'SELECT ' +
                     '  PreInventoryMovID, ' +
                     '  SerialNumber, ' +
                     '  IdentificationNumber ' +
                     'FROM ' +
                     '  PreSerialMov ' +
                     'WHERE ' +
                     '  PreInventoryMovID in (' + APreInventoryMovIDs + ')';
      Open;
    end;
end;

procedure TDM.OpenMovDocument(APreInventoryMovIDs: String);
begin
  if APreInventoryMovIDs <> '' then
    with quMovDocument do
    begin
      if Active then
        Close;
      CommandText := 'SELECT ' +
                     '  IDPreInventoryMov, ' +
                     '  DocumentNumber, ' +
                     '  IDDocumentType, ' +
                     '  OBS ' +
                     'FROM ' +
                     '  Inv_MovDocument ' +
                     'WHERE ' +
                     '  IDPreInventoryMov in (' + APreInventoryMovIDs + ')';
      Open;
    end;
end;

function TDM.GetIdentificationNumber(AIDPreInvMov: Integer): String;
begin
  Result := '';
  with quPreSerialMov do
  try
    First;
    while not Eof do
    begin
      if AIDPreInvMov = FieldByName('PreInventoryMovID').AsInteger then
      begin
        Result := FieldByName('IdentificationNumber').AsString;
        Exit;
      end;

      Next;
    end;
  finally
    First;
  end;
end;

function TDM.GetSerialNumber(AIDPreInvMov: Integer): String;
begin
  Result := '';
  with quPreSerialMov do
  try
    First;
    while not Eof do
    begin
      if AIDPreInvMov = FieldByName('PreInventoryMovID').AsInteger then
      begin
        Result := FieldByName('SerialNumber').AsString;
        Exit;
      end;

      Next;
    end;
  finally
    First;
  end;
end;

procedure TDM.EFiscal1AfterAbrirCupom(Sender: TObject);
var
  sCCF : String;
begin
  inherited;
  fCupomFiscal.DataHora := DM.EFiscal1.DataImpressora;

  case EFiscal1.Impressora of
    BematechMP20, BematechMP40:
    begin
      fCupomFiscal.CCF := '';
    end;

    BematechTermica:
    begin
      EFiscal1.ContadorCupomFiscalMFD(sCCF);
      fCupomFiscal.CCF := Trim(sCCF);
    end;

    DarumaTerm:
    begin
      EFiscal1.RetornaInformacao('30', 6, sCCF);
      fCupomFiscal.CCF := Trim(sCCF);
    end;

    Elgin:
    begin
      EFiscal1.ContadorCupomFiscalMFD(sCCF);
      fCupomFiscal.CCF := Trim(sCCF);
    end;
  end;
end;


procedure TDM.EFiscal1AfterSuprimento(Sender: TObject);
var
  sResult: String;
begin
  inherited;
  fCupomFiscal.DataHora := DM.EFiscal1.DataImpressora;

  case EFiscal1.Impressora of
    BematechMP20, BematechMP40:
    begin
      fCupomFiscal.FCOO := 0;
      fCupomFiscal.FGNF := 0;
    end;

    BematechTermica:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;

    DarumaTerm:
    begin
      EFiscal1.RetornaInformacao('26', 6, sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.RetornaInformacao('28', 6, sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;

    Elgin:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;
  end;
end;

procedure TDM.EFiscal1AfterSangria(Sender: TObject);
var
  sResult: String;
begin
  inherited;
  fCupomFiscal.DataHora := DM.EFiscal1.DataImpressora;

  case EFiscal1.Impressora of
    BematechMP20, BematechMP40:
    begin
      fCupomFiscal.FCOO := 0;
      fCupomFiscal.FGNF := 0;
    end;

    BematechTermica:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;

    DarumaTerm:
    begin
      EFiscal1.RetornaInformacao('26', 6, sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.RetornaInformacao('28', 6, sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;

    Elgin:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);
      
      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;
  end;
end;

procedure TDM.ClearCupomFiscal;
begin
   fCupomFiscal.DataHora := 0;
   fCupomFiscal.COO      := 0;
   fCupomFiscal.GNF      := 0;
   fCupomFiscal.CDC      := 0;
   fCupomFiscal.CCF      := '';
end;

procedure TDM.EFiscal1AfterAbreDiaFiscal(Sender: TObject);
var
  sResult: String;
begin
  inherited;
  fCupomFiscal.DataHora := DM.EFiscal1.DataImpressora;

  case EFiscal1.Impressora of
    BematechMP20, BematechMP40:
    begin
      fCupomFiscal.FCOO := 0;
      fCupomFiscal.FGNF := 0;
    end;

    BematechTermica:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;

    DarumaTerm:
    begin
      EFiscal1.RetornaInformacao('26', 6, sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.RetornaInformacao('28', 6, sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;

    Elgin:
    begin
      EFiscal1.NumeroCupom(sResult);
      fCupomFiscal.FCOO := StrToInt(sResult);

      EFiscal1.NumeroOperacoesNaoFiscais(sResult);
      fCupomFiscal.FGNF := StrToInt(sResult);
    end;
  end;
end;

procedure TDM.HideWait;
begin
  FFrmWait.Hide;
  Application.ProcessMessages;
end;

procedure TDM.ShowWait;
begin
  Application.ProcessMessages;
  FFrmWait.Show;
end;

procedure TDM.CreateSerialNumber;
var
  sResult: string;
begin
  //Sava o Novo numero de seria para arquivo
  sResult := InputBox('Entre com o numero de serie da impressora', 'Numero Serie', '');
  if sResult = '' then
    Exit;
  FPrinters := FPrinters + '['+ sResult + ']';
  PrinterFile.WriteString('Settings', FISCAL_PRINTERS, EncodeServerInfo(FPrinters, 'Printer', CIPHER_TEXT_STEALING, FMT_UU));
end;

procedure TDM.ReadSerialNumbers;
begin
  //Pega o serial do arquivo encriptografado
  FPrinters := DecodeServerInfo(PrinterFile.ReadString('Settings',FISCAL_PRINTERS,''), 'Printer', CIPHER_TEXT_STEALING, FMT_UU);
end;

function TDM.VerifySerialNumber: Boolean;
var
  i: Integer;
  sSerial: String;
begin

  DM.EFiscal1.NumeroSerie(sSerial);
  DM.fModuloFiscal.ECFSerial := Trim(sSerial);
  Result := (Pos(Trim(sSerial), FPrinters) <> 0);

  if not Result then
    InputBox('Nº de Serie da Impressora', 'Nº Serie', sSerial);

end;

function TDM.UpdateGrandeTotal(AGrandeTotal: Currency): Boolean;
begin
  PrinterFile.WriteString('GranTotal', FISCAL_GRANDETOTAL, EncodeServerInfo(FormatFloat('0.00', AGrandeTotal), 'Printer', CIPHER_TEXT_STEALING, FMT_UU));
end;

function TDM.RetornaGrandeTotal: Currency;
var
  sResult : String;
begin

  if EFiscal1.GrandeTotal(sResult) then
    Result := (StrToCurr(sResult)/100);

end;


function TDM.VerifyGrandeTotal: Boolean;
var
  dGrandeTotalFile,
  dGrandeTotalPrinter : Currency;
  sResult : String;
begin


  Result := True;

  {
  Result := False;

  dGrandeTotalFile    := StrToCurrDef(DecodeServerInfo(PrinterFile.ReadString('GranTotal',FISCAL_GRANDETOTAL,''), 'Printer', CIPHER_TEXT_STEALING, FMT_UU),0);
  dGrandeTotalPrinter := RetornaGrandeTotal;

  if dGrandeTotalFile = 0 then
  begin
    UpdateGrandeTotal(dGrandeTotalPrinter);
    dGrandeTotalFile := dGrandeTotalPrinter;
  end;

  Result := ((dGrandeTotalFile <> 0) and (dGrandeTotalPrinter = dGrandeTotalFile));
  }
end;

procedure TDM.CreateGrandTotal;
var
  sResult : string;
  dResult : Currency;
begin
  //Sava o Novo numero de seria para arquivo
  sResult := InputBox('Entre com o valor do grande total da impressora', 'Grande Total', '');

  try
    dResult := StrToCurr(sResult);
  except
    ShowMessage('Grande Total invalido');
    Exit;
  end;
  
  UpdateGrandeTotal(dResult);
  
end;

procedure TDM.EFiscal1TotalCupom(ValorCupom: String);
begin
  inherited;
  UpdateGrandeTotal(RetornaGrandeTotal);
end;


procedure TDM.EFiscal1BeforeAbrirCupom(Sender: TObject;
  var CanOpen: Boolean);
begin
  inherited;

  CanOpen := False;
  ReadSerialNumbers;

  if VerifySerialNumber then
    CanOpen := True
  else
    MsgBox('Nº de série não encontrado._Abortar!', vbCritical + vbOKOnly);

end;

function TDM.VerifyMD5: Boolean;
begin
  Result := (FMD5 <> '');
end;

procedure TDM.LoadBematechTermInfo;
var
  sNumeroSubstituicoes : String;
  sMarca, sModelo, sTipo : String;
  sVersaoFirmware : String;
  sNumLoja : String;
  sNumCaixa : String;
  sUsuario, SWBasico : String;
  sMFAdicional : Char;
  sData : String;
  buildInfo: String;
begin

  with TRegistry.Create do
  try

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REGISTRY_PATH_POS, True);

    if not ValueExists('Bema_NumeroUsuarioECF') then
    begin
      SetLength(sNumeroSubstituicoes, 4);
      EFiscal1.NumeroSubstituicoesProprietario(sNumeroSubstituicoes);
      WriteInteger('Bema_NumeroUsuarioECF', StrToIntDef(sNumeroSubstituicoes,1));
    end;

    if not ValueExists('Bema_MarcaECF') then
    begin
      SetLength(sMarca, 15);
      SetLength(sModelo, 20);
      SetLength(sTipo, 7);
      EFiscal1.MarcaModeloTipoImpressoraMFD(sMarca, sModelo, sTipo);
      WriteString('Bema_MarcaECF', sMarca);
      WriteString('Bema_ModeloECF', sModelo);
      WriteString('Bema_TipoECF', sTipo);
    end;

    if not ValueExists('Bema_VersaoSBECF') then
    begin
      SetLength(sVersaoFirmware, 6);
      EFiscal1.VersaoFirmwareMFD(sVersaoFirmware);
      WriteString('Bema_VersaoSBECF', sVersaoFirmware);
    end;

    if not ValueExists('Bema_NumeroLoja') then
    begin
      SetLength(sNumLoja, 4);
      EFiscal1.NumeroLoja(sNumLoja);
      WriteInteger('Bema_NumeroLoja', StrToIntDef(sNumLoja,1));
    end;

    if not ValueExists('Bema_NumeroECF') then
    begin
      SetLength(sNumCaixa, 4);
      EFiscal1.NumeroCaixa(sNumCaixa);
      WriteInteger('Bema_NumeroECF', StrToIntDef(sNumCaixa,1));
    end;

    if not ValueExists('Bema_DataInstalECF') then
    begin
      SetLength(sUsuario, 20);
      SetLength(SWBasico, 20);
      sMFAdicional := ' ';
      EFiscal1.DataHoraGravacaoUsuarioSWBasicoMFAdicional(sUsuario, SWBasico, sMFAdicional);

      sData := Copy(SWBasico,1,2) + Copy(SWBasico,4,2) + Copy(SWBasico,7,4) +
               Copy(SWBasico,12,2) + Copy(SWBasico,15,2) + Copy(SWBasico,18,2);

      WriteDateTime('Bema_DataInstalECF', EFiscal1.FormatarDataHoraImpressora(sData));
      WriteString('Bema_MFAdicional', sMFAdicional);
    end;


    fModuloFiscal.NumeroUsuarioECF := ReadInteger('Bema_NumeroUsuarioECF');
    fModuloFiscal.MarcaECF         := ReadString('Bema_MarcaECF');
    fModuloFiscal.ModeloECF        := ReadString('Bema_ModeloECF');
    fModuloFiscal.TipoECF          := ReadString('Bema_TipoECF');
    fModuloFiscal.VersaoSBECF      := ReadString('Bema_VersaoSBECF');
    fModuloFiscal.NumeroLoja       := ReadInteger('Bema_NumeroLoja');
    fModuloFiscal.NumeroECF        := ReadInteger('Bema_NumeroECF');
    fModuloFiscal.DataInstalECF    := ReadDateTime('Bema_DataInstalECF');
    fModuloFiscal.MFAdicional      := ReadString('Bema_MFAdicional');
  finally
    Free;
  end;

end;

procedure TDM.LoadElginTermInfo;
var
  sNumeroSubstituicoes : String;
  sMarca, sModelo, sTipo : String;
  sVersaoFirmware : String;
  sNumLoja : String;
  sNumCaixa : String;
  sUsuario, SWBasico : String;
  sMFAdicional : Char;
  sData : String;
  buildInfo: String;
begin

  with TRegistry.Create do
  try

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REGISTRY_PATH_POS, True);

    if not ValueExists('Bema_NumeroUsuarioECF') then
    begin
      SetLength(sNumeroSubstituicoes, 4);
      EFiscal1.NumeroSubstituicoesProprietario(sNumeroSubstituicoes);
      WriteInteger('Bema_NumeroUsuarioECF', StrToIntDef(sNumeroSubstituicoes,1));
    end;

    if not ValueExists('Bema_MarcaECF') then
    begin
      SetLength(sMarca, 15);
      SetLength(sModelo, 20);
      SetLength(sTipo, 7);
      EFiscal1.MarcaModeloTipoImpressoraMFD(sMarca, sModelo, sTipo);
      WriteString('Bema_MarcaECF', sMarca);
      WriteString('Bema_ModeloECF', sModelo);
      WriteString('Bema_TipoECF', sTipo);
    end;

    if not ValueExists('Bema_VersaoSBECF') then
    begin
      SetLength(sVersaoFirmware, 8);
      EFiscal1.VersaoFirmwareMFD(sVersaoFirmware);
      WriteString('Bema_VersaoSBECF', sVersaoFirmware);
    end;

    if not ValueExists('Bema_NumeroLoja') then
    begin
      SetLength(sNumLoja, 4);
      EFiscal1.NumeroLoja(sNumLoja);
      WriteInteger('Bema_NumeroLoja', StrToIntDef(sNumLoja,1));
    end;

    if not ValueExists('Bema_NumeroECF') then
    begin
      SetLength(sNumCaixa, 4);
      EFiscal1.NumeroCaixa(sNumCaixa);
      WriteInteger('Bema_NumeroECF', StrToIntDef(sNumCaixa,1));
    end;

   if not ValueExists('Bema_DataInstalECF') then
    begin
      SetLength(sUsuario, 6);
      SetLength(SWBasico, 6);
      sMFAdicional := ' ';
      EFiscal1.DataHoraGravacaoUsuarioSWBasicoMFAdicional(sUsuario, SWBasico, sMFAdicional);

      sData := Copy(sUsuario,1,2) + Copy(sUsuario,3,2) + Copy(sUsuario,5,2) +
               Copy(SWBasico,1,2) + Copy(SWBasico,3,2) + Copy(SWBasico,5,2);

      WriteDateTime('Bema_DataInstalECF', EFiscal1.FormatarDataHoraImpressora(sData));
      WriteString('Bema_MFAdicional', sMFAdicional);
    end;

    fModuloFiscal.NumeroUsuarioECF := ReadInteger('Bema_NumeroUsuarioECF');
    fModuloFiscal.MarcaECF         := ReadString('Bema_MarcaECF');
    fModuloFiscal.ModeloECF        := ReadString('Bema_ModeloECF');
    fModuloFiscal.TipoECF          := ReadString('Bema_TipoECF');
    fModuloFiscal.VersaoSBECF      := ReadString('Bema_VersaoSBECF');
    fModuloFiscal.NumeroLoja       := ReadInteger('Bema_NumeroLoja');
    fModuloFiscal.NumeroECF        := ReadInteger('Bema_NumeroECF');
    fModuloFiscal.DataInstalECF    := ReadDateTime('Bema_DataInstalECF');
    fModuloFiscal.MFAdicional      := ReadString('Bema_MFAdicional');
  finally
    Free;
  end;

end;

function TDM.NegativeQty(sHoldNum: String): Boolean;
begin
  Result := False;

  with quPreSaleNegativeItems do
  Try
    if Active then
      Close;

    Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
    Parameters.ParamByName('SaleCode').Value := sHoldNum;
    Open;
    Result := not IsEmpty;
    
  Finally
    Close;
  end;


end;

procedure TDM.LoadSwedaTermInfo;
var
  sNumeroSubstituicoes : String;
  sMarca, sModelo, sTipo : String;
  sVersaoFirmware : String;
  sNumLoja : String;
  sNumCaixa : String;
  sUsuario, SWBasico : String;
  sMFAdicional : Char;
  sData : String;
  buildInfo: String;
begin

  with TRegistry.Create do
  try

    if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
    else
        RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REGISTRY_PATH_POS, True);

    if not ValueExists('Sweda_NumeroUsuarioECF') then
    begin
      SetLength(sNumeroSubstituicoes, 4);
      EFiscal1.NumeroSubstituicoesProprietario(sNumeroSubstituicoes);
      WriteInteger('Sweda_NumeroUsuarioECF', StrToIntDef(sNumeroSubstituicoes,1));
    end;

    if not ValueExists('Sweda_MarcaECF') then
    begin
      SetLength(sMarca, 15);
      SetLength(sModelo, 20);
      SetLength(sTipo, 7);
      EFiscal1.MarcaModeloTipoImpressoraMFD(sMarca, sModelo, sTipo);
      WriteString('Sweda_MarcaECF', sMarca);
      WriteString('Sweda_ModeloECF', sModelo);
      WriteString('Sweda_TipoECF', sTipo);
    end;

    if not ValueExists('Sweda_VersaoSBECF') then
    begin
      SetLength(sVersaoFirmware, 6);
      EFiscal1.VersaoFirmwareMFD(sVersaoFirmware);
      WriteString('Sweda_VersaoSBECF', sVersaoFirmware);
    end;

    if not ValueExists('Sweda_NumeroLoja') then
    begin
      SetLength(sNumLoja, 4);
      EFiscal1.NumeroLoja(sNumLoja);
      WriteInteger('Sweda_NumeroLoja', StrToIntDef(sNumLoja,1));
    end;

    if not ValueExists('Sweda_NumeroECF') then
    begin
      SetLength(sNumCaixa, 4);
      EFiscal1.NumeroCaixa(sNumCaixa);
      WriteInteger('Sweda_NumeroECF', StrToIntDef(sNumCaixa,1));
    end;

   if not ValueExists('Sweda_DataInstalECF') then
    begin
      SetLength(sUsuario, 20);
      SetLength(SWBasico, 20);
      sMFAdicional := ' ';

      EFiscal1.DataHoraGravacaoUsuarioSWBasicoMFAdicional(sUsuario, SWBasico, sMFAdicional);

      sData := Copy(sUsuario,1,2) + Copy(sUsuario,4,2) + Copy(sUsuario,9,2) +
               Copy(sUsuario,12,2) + Copy(sUsuario,15,2) + Copy(sUsuario,18,2);

      WriteDateTime('Sweda_DataInstalECF', EFiscal1.FormatarDataHoraImpressora(sData));
      WriteString('Sweda_MFAdicional', sMFAdicional);
    end;

    fModuloFiscal.NumeroUsuarioECF := ReadInteger('Sweda_NumeroUsuarioECF');
    fModuloFiscal.MarcaECF         := ReadString('Sweda_MarcaECF');
    fModuloFiscal.ModeloECF        := ReadString('Sweda_ModeloECF');
    fModuloFiscal.TipoECF          := ReadString('Sweda_TipoECF');
    fModuloFiscal.VersaoSBECF      := ReadString('Sweda_VersaoSBECF');
    fModuloFiscal.NumeroLoja       := ReadInteger('Sweda_NumeroLoja');
    fModuloFiscal.NumeroECF        := ReadInteger('Sweda_NumeroECF');
    fModuloFiscal.DataInstalECF    := ReadDateTime('Sweda_DataInstalECF');
    fModuloFiscal.MFAdicional      := ReadString('Sweda_MFAdicional');
  finally
    Free;
  end;

end;

end.
