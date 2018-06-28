(*
-----------------------------------------------------------------------------------------------------
Date    : 12.30.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Activity: add new parameters due Mercury Gift Card.
-----------------------------------------------------------------------------------------------------
Version : (297 - 315)
Date    : 11.04.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   : Run parameters is not calling PuppyTracker Integration
-----------------------------------------------------------------------------------------------------
Version : (288 - 278)
Date    : 12.31.2010
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Solution: get IdPresale having a hold number/salecode
Version : (288 - 279)
-----------------------------------------------------------------------------------------------------
*)


unit uDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, PaideFichas, PowerADOQuery, PaiDeBrowses, registry, uHandleError,
  RCADOQuery, ADOdb, LookUpADOQuery, uSystemTypes, uPrint, uDMParent, uSystemObj,
  uUserObj, Variants, cxStyles, cxClasses, cxGridTableView, ImgList, uFrmPOSFunctions,
  uWaitForm, uFrmNewMessage, IniFiles, uDMCalcPrice, ComObj, uMRTraceControl,
  uMRPinPad, uInvoicePollDisplay, uOperationSystem, uEntityFields, uGynboSyncClasses,
  DBClient, Provider, cxGridDBTableView, cxGridCustomView, uDMInventory,
  SOAPHTTPTrans, ItemPurchaseModel, uccMercuryIntegration, DsiPDCXLib_TLB,
  contnrs, AdjustReasonCls;

const
  //Large images
  BTN_ADD       = 0;
  BTN_RESTORE   = 1;
  BTN_OPEN      = 2;
  BTN_DELETE    = 3;
  BTN_PREVIEW   = 4;
  BTN_COLUMN    = 5;
  BTN_EXPORT    = 6;
  BTN_GROUPING  = 7;
  BTN_FILTER    = 8;
  BTN_REFRESH   = 9;
  BTN_HOLD      = 10;
  BTN_KEY       = 11;
  BTN_PRINT     = 12;
  BTN_LOCK      = 13;
  BTN_INVENTORY = 14;
  BTN_HISTORY   = 15;
  BTN_EMAIL     = 16;
  BTN_USER      = 17;
  BTN_REQUEST   = 18;
  BTN_ADDALL    = 19;
  BTN_DELETEALL = 20;
  BTN_BUDGET    = 21;
  BTN_REPOST_PUPPY = 22;

  //Small images
  BTN18_LAMP       = 0;
  BTN18_HELP       = 1;
  BTN18_COMPUTER   = 2;
  BTN18_DISPLAY    = 3;
  BTN18_SEARCH     = 4;
  BTN18_DELETE     = 5;
  BTN18_FAX        = 6;
  BTN18_NEW        = 7;
  BTN18_OPEN       = 8;
  BTN18_PREVIEW    = 9;
  BTM18_FLAGS      = 16;
  BTM18_BACKUP     = 17;
  BTN18_CAMERA     = 18;
  BTN18_BARCODE    = 19;
  BTN18_ONLINEHELP = 20;
  BTN18_MESSAGE    = 21;
  BTN18_DOWN       = 22;
  BTN18_UP         = 23;
  BTN18_LOCK       = 24;
  BTN18_CONFIRMED  = 25;

  //Start Options
  START_LAYAWAY     = 1;
  START_INVENT_TYPE = 2;

  PAYMENT_PROCESSOR = 'MRProcessor.ini';

  CONNECTION_ERROR = -2147467259;

Type
   TSrvParam = Array of Variant;

   TStore = Class
      private
        fID          : Integer;
        fIDStoreSale : Integer;
        fIDStorePur  : Integer;
        fIDDefault   : Integer;
        fStoreHour   : Integer;
        fFranchase   : Boolean;
        fStoreList   : String;
        fName        : String;
        fState       : String;
        procedure setStoreHour(iIDStore:Integer);
        function GetIDStorePur : Integer;
        function GetIDStoreSale : Integer;
      public
        property ID          : Integer read fID            write fID;
        property IDStoreSale : Integer read GetIDStoreSale write fIDStoreSale;
        property IDStorePur  : Integer read GetIDStorePur  write fIDStorePur;
        property IDDefault   : Integer read fIDDefault     write fIDDefault;
        property StoreHour   : Integer read fStoreHour     write setStoreHour;
        property StoreList   : String  read fStoreList     write fStoreList;
        property Name        : String  read fName          write fName;
        property Franchase   : Boolean read fFranchase     write fFranchase;
        property State       : String  read fState         write fState;
   end;

  //Object instantiated from uUserObj
  TMRUser = Class(TUser)
      private
        fIDUserCliente : Integer;
        fIDCommissionCliente : Integer;
        fIDCommission : Integer;
        FCheckMessage: Boolean;
        function Manager:Boolean;
        function AssistManager:Boolean;
      public
        property IDCommission        : Integer read fIDCommission        write fIDCommission;
        property IsManager           : Boolean read Manager;
        property CheckMessage        : Boolean read FCheckMessage        write FCheckMessage;
        property IsAssistManager     : Boolean read AssistManager;
        property IDUserCliente       : Integer read fIDUserCliente       write fIDUserCliente;
        property IDCommissionCliente : Integer read fIDCommissionCliente write fIDCommissionCliente;
  end;

  TPollDisplay = class
    FIP : String;
    FPort : Integer;
    FClearSale : Boolean;
  end;

  TPetCenter = class
    FIP : String;
    FPort : Integer;
  end;

  TCashRegister = Class
  private
    fIDDefault:  Integer;
    fIDMedia:    Integer;
    fOpen:       Boolean;
    fOpenCod:    String;
    fViewOthers: Boolean;
    fViewOthersStores: Boolean;
    FAfterPrintCode: String;
    FAskSalesPerson: Boolean;
    FIDShippingReg : Integer;
    FShippingPackingRep : String;
    FShippingPickRep : String;
    FScaleType: Integer;
    FScaleCheck: Boolean;
    FDefaulServOrderCat: String;
  public
    property IDDefault:          Integer read fIDDefault         write fIDDefault;
    property IDMedia:            Integer read fIDMedia           write fIDMedia;
    property Open:               Boolean read fOpen              write fOpen;
    property OpenCod:            String  read fOpenCod           write fOpenCod;
    property ViewOthers:         Boolean read fViewOthers        write fViewOthers;
    property ViewOthersStores:   Boolean read fViewOthersStores  write fViewOthersStores;
    property AfterPrintCode:     String  read FAfterPrintCode    write FAfterPrintCode;
    property AskSalesPerson:     Boolean read FAskSalesPerson    write FAskSalesPerson;
    property IDShippingReg:      Integer read FIDShippingReg     write FIDShippingReg;
    property ShippingPackingRep: String  read FShippingPackingRep write FShippingPackingRep;
    property ShippingPickRep   : String  read FShippingPickRep    write FShippingPickRep;
    property ScaleType         : Integer read FScaleType          write FScaleType;
    property ScaleCheck        : Boolean read FScaleCheck         write FScaleCheck;
    property DefaulServOrderCat: String  read FDefaulServOrderCat write FDefaulServOrderCat;
  end;

  //Object instantiated from uSystemObj
  TMRSystem = Class(TSystem)
    private
      fLocalPath      : String;
      fVersionType    : String;
      fExpirationDate : Integer;
      fSystemDate     : Integer;
      //fSrvParam    : Variant;
      fSrvParam       : TSrvParam;
      fLogo           : TPicture;
      fWinDateFormat: String;
      fMRBuildValidate : Boolean;
      function ConvertParam(SrvValue, SrvType : String) : Variant;
    public
      property SrvParam       : TSrvParam read fSrvParam       write fSrvParam;
      property VersionType    : String    read fVersionType    write fVersionType;
      property LocalPath      : String    read fLocalPath      write fLocalPath;
      property ExpirationDate : Integer   read fExpirationDate write fExpirationDate;
      property SystemDate     : Integer   read fSystemDate     write fSystemDate;
      property WinDateFormat  : String    read fWinDateFormat  write fWinDateFormat;
      property Logo           : TPicture  read fLogo           write fLogo;
      property MRBuildValidate: Boolean   read fMRBuildValidate write fMRBuildValidate;

      Constructor Create;
      Destructor Destroy; override;
  end;

  TMRGrid = Class
     private
       fLayout : Integer;
       fKind   : Integer;
     public
       property Layout : Integer read fLayout write fLayout;
       property Kind   : Integer read fKind   write fKind;
  end;

  TMRMenu = Class
     private
       fMenuColor          : TColor;
       fMenuColorHighlight : TColor;
       fMenuBackColor      : TColor;
       fBackGroundColor    : TColor;
       fSubMenuColor       : TColor;
       fSubMenuHighlight   : TColor;
       fPanelShorcuts      : TColor;
       fPanelSystem        : TColor;
       fPanelHelp          : TColor;
       fImage              : Integer;
       fMenuName           : String;
       fSubMenuName        : String;
       fLogo               : String;
       fWindowMode         : Boolean;
     public
       property MenuColor          : TColor  read fMenuColor          write fMenuColor;
       property MenuColorHighlight : TColor  read fMenuColorHighlight write fMenuColorHighlight;
       property MenuBackColor      : TColor  read fMenuBackColor      write fMenuBackColor;
       property BackGroundColor    : TColor  read fBackGroundColor    write fBackGroundColor;
       property SubMenuColor       : TColor  read fSubMenuColor       write fSubMenuColor;
       property SubMenuHighlight   : TColor  read fSubMenuHighlight   write fSubMenuHighlight;
       property PanelShorcuts      : TColor  read fPanelShorcuts      write fPanelShorcuts;
       property PanelSystem        : TColor  read fPanelSystem        write fPanelSystem;
       property PanelHelp          : TColor  read fPanelHelp          write fPanelHelp;
       property Image              : Integer read fImage              write fImage;
       property MenuName           : String  read fMenuName           write fMenuName;
       property SubMenuName        : String  read fSubMenuName        write fSubMenuName;
       property Logo               : String  read fLogo               write fLogo;
       property WindowMode         : Boolean read fWindowMode         write fWindowMode;

       procedure SetColors(Menu, MenuHighlight, MenuBack, BackGround,
                           SubMenu, SubMenuHighlight, PanelShortCuts,
                           PanelSystem, PanelHelp : TColor);
  end;

  TMRPrintReceipt = Class
    private
    fPrintReceipt            : Boolean;
    fPrinterType             : Integer;
    fPrinterFontSize         : Integer;
    fPrinterLineSpace        : Integer;
    fPrinterLineWidth        : Integer;
    fPaperType               : Integer;
    fPrinterPort             : String;
    fPrinterFontName         : String;
    fPreview                 : Boolean;
    fNumOfCopies             : Integer;
    fReportPath              : String;
    fReportPathFooter        : String;
    fInvoiceReportPrinter    : String;
    fDeliveryReportPath      : String;
    fDeliveryReportPreview   : Boolean;
    fDeliveryReportNumCopy   : Integer;
    fDeliveryReportPrinter   : String;
    fBudgetReportPath        : String;
    fBudgetReportPreview     : Boolean;
    fBudgetReportNumCopy     : Integer;
    fBudgetReportPrinter     : String;
    fTransferReportPath      : String;
    fTransferReportPreview   : Boolean;
    fTransferReportNumCopy   : Integer;
    fTransferReportPrinter   : String;
    fPOReportPath            : String;
    fPOReportPreview         : Boolean;
    fPOReportNumCopy         : Integer;
    fPOReportPrinter         : String;
    fCommissionReportPath    : String;
    fCommissionReportPreview : Boolean;
    fCommissionReportNumCopy : Integer;
    fCommissionReportPrinter : String;
    fUseUSBPrinter           : Boolean;
    fUSBOpenDraw             : String;
    fUSBCutCode              : String;
    fTransferSuggestPrint    : Boolean;
    fRepairReportPreview     : Boolean;
    fRepairReportNumCopy     : Integer;
    fRepairReportPrinter     : String;
    fRepairReportPath        : String;
    fReceivingReportPreview  : Boolean;
    fReceivingReportNumCopy  : Integer;
    fReceivingReportPrinter  : String;
    fReceivingReportPath     : String;
    fPOEmailFile             : Integer;
    fServiceReportPreview    : Boolean;
    fServiceReportNumCopy    : Integer;
    fServiceReportPrinter    : String;
    fServiceReportPath       : String;
    fStoreAccReportPreview   : Boolean;
    fStoreAccReportNumCopy   : Integer;
    fStoreAccReportPath      : String;
    fStoreAccReportPrinter   : String;
    fStoreAccFooterPath      : String;
    fPrintItemsPerPage       : Integer;
  public
    property PrintReceipt            : Boolean read fPrintReceipt            write fPrintReceipt;
    property PrinterType             : Integer read fPrinterType             write fPrinterType;
    property PrinterFontSize         : Integer read fPrinterFontSize         write fPrinterFontSize;
    property PrinterPort             : String  read fPrinterPort             write fPrinterPort;
    property PrinterFontName         : String  read fPrinterFontName         write fPrinterFontName;
    property PrinterLineSpace        : Integer read fPrinterLineSpace        write fPrinterLineSpace;
    property PrinterLineWidth        : Integer read fPrinterLineWidth        write fPrinterLineWidth;
    property PaperType               : Integer read fPaperType               write fPaperType;
    property Preview                 : Boolean read fPreview                 write fPreview;
    property NumOfCopies             : Integer read fNumOfCopies             write fNumOfCopies;
    property ReportPath              : String  read fReportPath              write fReportPath;
    property ReportPathFooter        : String  read fReportPathFooter        write fReportPathFooter;
    property InvoiceReportPrinter    : String  read fInvoiceReportPrinter    write fInvoiceReportPrinter;
    property BudgetReportPath        : String  read fBudgetReportPath        write fBudgetReportPath;
    property BudgetReportPreview     : Boolean read fBudgetReportPreview     write fBudgetReportPreview;
    property BudgetReportNumCopy     : Integer read fBudgetReportNumCopy     write fBudgetReportNumCopy;
    property BudgetReportPrinter     : String  read fBudgetReportPrinter     write fBudgetReportPrinter;
    property TransferReportPath      : String  read fTransferReportPath      write fTransferReportPath;
    property TransferReportPreview   : Boolean read fTransferReportPreview   write fTransferReportPreview;
    property TransferSuggestPrint    : Boolean read fTransferSuggestPrint    write fTransferSuggestPrint;
    property TransferReportNumCopy   : Integer read fTransferReportNumCopy   write fTransferReportNumCopy;
    property TransferReportPrinter   : String  read fTransferReportPrinter   write fTransferReportPrinter;
    property POReportPath            : String  read fPOReportPath            write fPOReportPath;
    property POReportPreview         : Boolean read fPOReportPreview         write fPOReportPreview;
    property POReportNumCopy         : Integer read fPOReportNumCopy         write fPOReportNumCopy;
    property POReportPrinter         : String  read fPOReportPrinter         write fPOReportPrinter;
    property POEmailFile             : Integer read fPOEmailFile             write fPOEmailFile;
    property RepairReportPath        : String  read fRepairReportPath        write fRepairReportPath;
    property RepairReportPreview     : Boolean read fRepairReportPreview     write fRepairReportPreview;
    property RepairReportNumCopy     : Integer read fRepairReportNumCopy     write fRepairReportNumCopy;
    property RepairReportPrinter     : String  read fRepairReportPrinter     write fRepairReportPrinter;
    property ReceivingReportPath     : String  read fReceivingReportPath     write fReceivingReportPath;
    property ReceivingReportPreview  : Boolean read fReceivingReportPreview  write fReceivingReportPreview;
    property ReceivingReportNumCopy  : Integer read fReceivingReportNumCopy  write fReceivingReportNumCopy;
    property ReceivingReportPrinter  : String  read fReceivingReportPrinter  write fReceivingReportPrinter;
    property CommissionReportPath    : String  read fCommissionReportPath    write fCommissionReportPath;
    property CommissionReportPreview : Boolean read fCommissionReportPreview write fCommissionReportPreview;
    property CommissionReportNumCopy : Integer read fCommissionReportNumCopy write fCommissionReportNumCopy;
    property CommissionReportPrinter : String  read fCommissionReportPrinter write fCommissionReportPrinter;
    property DeliveryReportPath      : String  read fDeliveryReportPath      write fDeliveryReportPath;
    property DeliveryReportPreview   : Boolean read fDeliveryReportPreview   write fDeliveryReportPreview;
    property DeliveryReportNumCopy   : Integer read fDeliveryReportNumCopy   write fDeliveryReportNumCopy;
    property DeliveryReportPrinter   : String  read fDeliveryReportPrinter   write fDeliveryReportPrinter;
    property UseUSBPrinter           : Boolean read fUseUSBPrinter           write fUseUSBPrinter;
    property USBOpenDraw             : String  read fUSBOpenDraw             write fUSBOpenDraw;
    property USBCutCode              : String  read fUSBCutCode              write fUSBCutCode;
    property ServiceReportPath       : String  read fServiceReportPath       write fServiceReportPath;
    property ServiceReportPreview    : Boolean read fServiceReportPreview    write fServiceReportPreview;
    property ServiceReportNumCopy    : Integer read fServiceReportNumCopy    write fServiceReportNumCopy;
    property ServiceReportPrinter    : String  read fServiceReportPrinter    write fServiceReportPrinter;
    property StoreAccReportPreview   : Boolean read fStoreAccReportPreview   write fStoreAccReportPreview;
    property StoreAccReportNumCopy   : Integer read fStoreAccReportNumCopy   write fStoreAccReportNumCopy;
    property StoreAccReportPath      : String  read fStoreAccReportPath      write fStoreAccReportPath;
    property StoreAccFooterPath      : String  read fStoreAccFooterPath      write fStoreAccFooterPath;
    property StoreAccReportPrinter   : String  read fStoreAccReportPrinter   write fStoreAccReportPrinter;
    property PrintItemsPerPage       : Integer read fPrintItemsPerPage       write fPrintItemsPerPage;

  end;

  TMRMercury = class
  private
    fProcessor: Integer;
    fDeviceProcess: Integer;
    FIpAddress       : String;
    FIpPort          : Integer;
    FMerchantID      : String;
    FDialUpBridge    : Boolean;
    FConnectTimeout  : Integer;
    FResponseTimeout : Integer;

    // Antonio M F Souza 01.13.2012 - to subtract quantity of serial numbers.
    FQtyToRemove: Double;

    //Antonio M F Souza 01.12.2012
    FMercuryErrorsCode: TClientDataSet;

    //Antonio M F Souza 12.30.2011
    FGiftIP: String;
    FGiftIPPort: Integer;
    FGiftProcessor: Integer;
    function getMercuryErrorsCode: TClientDataSet;
    procedure fillMercuryErrorsCode();
    function getQtyToRemove: Double;
    procedure setQtyToRemove(const Value: Double);
  public
    constructor create();
    property Processor: Integer read fProcessor write FProcessor;
    property DeviceProcess: Integer read fDeviceProcess write fDeviceProcess;
    property QtyToRemove: Double read getQtyToRemove write setQtyToRemove;
    property IpAddress       : String  read FIpAddress       write FIpAddress;
    property IpPort          : Integer read FIpPort          write FIpPort;
    property MerchantID      : String  read FMerchantID      write FMerchantID;
    property DialUpBridge    : Boolean read FDialUpBridge    write FDialUpBridge;
    property ConnectTimeout  : Integer read FConnectTimeout  write FConnectTimeout;
    property ResponseTimeout : Integer read FResponseTimeout write FResponseTimeout;

    //Antonio M F Souza 01.12.2012
    property MercuryErrorsCode: TClientDataSet read getMercuryErrorsCode;

    //Antonio M F Souza 12.30.2011
    property GiftIP          : String read FGiftIP write FGiftIP;
    property GiftIPPort      : Integer read FGiftIpPort write FGiftIPPort;
    property GiftProcessor   : Integer read FGiftProcessor write FGiftProcessor;
  end;

  TMRGynbo = class
  private
    FStoreNum: Integer;
    FUrl: String;
    FTerminal: String;
    FPartnerKey: String;
    FUrlPW: String;
    FUrlUser: String;
    FPartnerAcc: String;
    FMinSale: Currency;
    FDaysToUse: Integer;
    FExpireDays: Integer;
  public
    property Url : String        read FUrl        write FUrl;
    property UrlUser : String    read FUrlUser    write FUrlUser;
    property UrlPW : String      read FUrlPW      write FUrlPW;
    property PartnerAcc : String read FPartnerAcc write FPartnerAcc;
    property PartnerKey : String read FPartnerKey write FPartnerKey;
    property Terminal : String   read FTerminal   write FTerminal;
    property StoreNum : Integer  read FStoreNum   write FStoreNum;
    property MinSale : Currency  read FMinSale    write FMinSale;
    property DaysToUse : Integer read FDaysToUse  write FDaysToUse;
    property ExpireDays: Integer read FExpireDays write FExpireDays;
  end;

  TMRPCCharge = class
    private
      fTimeOut: Integer;
      fPrintNum: Integer;
      fPort: Integer;
      fLastDate: Integer;
      fServer: string;
      fUser: string;
      fPath: string;
      fMultTrans: Boolean;
      fProcessorType: Integer;
      fDeviceProcess: Integer;
      fPCChargeConfig : TIniFile;
      fPCChargeCardID : TStringList;
    public

      property Path          : string  read fPath          write fPath;
      property User          : string  read fUser          write fUser;
      property Server        : string  read fServer        write fServer;
      property TimeOut       : Integer read fTimeOut       write fTimeOut;
      property LastDate      : Integer read fLastDate      write fLastDate;
      property PrintNum      : Integer read fPrintNum      write fPrintNum;
      property Port          : Integer read fPort          write fPort;
      property ProcessorType : Integer read fProcessorType write fProcessorType;
      property DeviceProcess: Integer read fDeviceProcess write fDeviceProcess;
      property MultTrans     : Boolean read fMultTrans     write fMultTrans;

      function IdentifySwipedCard(AInputText: WideString): Integer;
      function GetIDMeioPag(sCardID : String) : Integer;
      procedure GetProcessor(IDMeioPag : Integer; var Processor, MercantAcc: String; var Copies: Integer; var CardID : String);overload;
      procedure SetProcessor(MeioPag, Processor, MercantAcc: String; Copies: Integer; CardID : String);overload;
      procedure SetProcessor(IDMeioPag: Integer; Processor, MercantAcc: String; Copies: Integer; CardID : String);overload;

      Constructor Create;
      Destructor Destroy; override;
  end;

  TMRInvoice = class
    private
       fXpressSaleType  : integer;
       fXpressSaleImage : String;
       fOBSText         : String;
       fDisplayBudget   : Boolean;
       fDisplayHold     : Boolean;
       fDisplaySearch   : Boolean;
       fDisplayCloseDay : Boolean;
       fDisplayFinalize : Boolean;
       fDisplayPOSHold: Boolean;
    public
       property XpressSaleType  : Integer read fXpressSaleType  write fXpressSaleType;
       property XpressSaleImage : String  read fXpressSaleImage write fXpressSaleImage;
       property OBSText         : String  read fOBSText         write fOBSText;
       property DisplayBudget   : Boolean read fDisplayBudget   write fDisplayBudget;
       property DisplayHold     : Boolean read fDisplayHold     write fDisplayHold;
       property DisplaySearch   : Boolean read fDisplaySearch   write fDisplaySearch;
       property DisplayCloseDay : Boolean read fDisplayCloseDay write fDisplayCloseDay;
       property DisplayFinalize : Boolean read fDisplayFinalize write fDisplayFinalize;
       property DisplayPOSHold  : Boolean read fDisplayPOSHold  write fDisplayPOSHold;
  end;


  // Antonio 03/31/2017
  TPayMethod = class
    private
        idType: integer;
        idBaseType: integer;  // according to payment buttons on FrmPaymentReceive
        nameType: String;
        baseNameType: String;
        inUse: boolean;
    public

        procedure SetIdType(argValue: Integer);
        function GetIdType(): Integer;

        procedure SetIdBaseType(argValue: Integer);
        function GetIdBaseType(): Integer;

        procedure SetNameType(argValue: String);
        function GetNameType(): String;

        procedure SetInUse(argValue: Boolean);
        function GetInUse(): Boolean;

  end;

  TPayMethodList = class
    private
       FPayList: TObjectList;
    public
        constructor Create();
        procedure AddPaymethodToList(argPayMethod: TPayMethod);
        function GetPayMethodList(): TObjectList;
        function FoundPayMethod(argPayIndex: Integer): Boolean;
        function GetPayMethod(argPayIndex: Integer): TPayMethod;
  end;


  TDM = class(TDMParent)
    quLookUpGroup: TLookUpADOQuery;
    quLookUpGroupIDGroup: TIntegerField;
    quLookUpGroupName: TStringField;
    quLookUpGroupPathName: TStringField;
    dsLookUpGroup: TDataSource;
    quLookUpStore: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    dsLookUpStore: TDataSource;
    LookUpComissionado: TLookUpADOQuery;
    LookUpComissionadoIDComissionado: TIntegerField;
    LookUpComissionadoComissionado: TStringField;
    LookUpComissionadoCode: TIntegerField;
    dsLookUpComissionado: TDataSource;
    LookUpUserType: TLookUpADOQuery;
    LookUpUserTypeIDUserType: TIntegerField;
    LookUpUserTypeName: TStringField;
    dsLookUpUserType: TDataSource;
    LookUpCashReg: TLookUpADOQuery;
    LookUpCashRegIDCashRegister: TIntegerField;
    LookUpCashRegName: TStringField;
    dsLookUpCashReg: TDataSource;
    LookUpUser: TLookUpADOQuery;
    LookUpUserIDUser: TIntegerField;
    LookUpUserSystemUser: TStringField;
    dsLookUpUser: TDataSource;
    LookUpTipoComissionado: TLookUpADOQuery;
    LookUpTipoComissionadoIDTipoComissionado: TIntegerField;
    LookUpTipoComissionadoPathName: TStringField;
    dsLookUpTipoComissionado: TDataSource;
    quLookUpIMT: TLookUpADOQuery;
    quLookUpIMTIDInventMovType: TIntegerField;
    quLookUpIMTName: TStringField;
    dsLookUpIMT: TDataSource;
    LookUpModel: TLookUpADOQuery;
    LookUpModelModel: TStringField;
    LookUpModelIDModel: TIntegerField;
    LookUpModelDescription: TStringField;
    dsLookUpModel: TDataSource;
    LookUpDeliverType: TLookUpADOQuery;
    LookUpDeliverTypeIDDeliverType: TIntegerField;
    LookUpDeliverTypeName: TStringField;
    dsLookUpDeliverType: TDataSource;
    LookUpSpcPrice: TLookUpADOQuery;
    LookUpSpcPriceIDSpecialPrice: TIntegerField;
    LookUpSpcPriceSpecialPrice: TStringField;
    dsLookUpSpcPrice: TDataSource;
    LookUpFornecedor: TLookUpADOQuery;
    LookUpFornecedorCode: TIntegerField;
    dsLookUpFornecedor: TDataSource;
    dsLookUpPreSale: TDataSource;
    dsLookUpEstado: TDataSource;
    LookUpEstado: TLookUpADOQuery;
    LookUpEstadoIDEstado: TStringField;
    LookUpEstadoEstado: TStringField;
    LookUpAgency: TLookUpADOQuery;
    LookUpAgencyIDPessoa: TIntegerField;
    LookUpAgencyPessoa: TStringField;
    LookUpAgencyCode: TIntegerField;
    LookUpAgencyIDComissionado: TIntegerField;
    dsLookUpAgency: TDataSource;
    LookUpGuide: TLookUpADOQuery;
    LookUpGuideIDPessoa: TIntegerField;
    LookUpGuideIDComissionado: TIntegerField;
    LookUpGuideCode: TIntegerField;
    LookUpGuidePessoa: TStringField;
    dsLookUpGuide: TDataSource;
    LookUpCustomer: TLookUpADOQuery;
    dsLookUpCustomer: TDataSource;
    LookUpTipoFornecedor: TLookUpADOQuery;
    LookUpTipoFornecedorIDTipoFornecedor: TIntegerField;
    LookUpTipoFornecedorPathName: TStringField;
    dsLookUpTipoFornecedor: TDataSource;
    LookUpTipoCliente: TLookUpADOQuery;
    LookUpTipoClienteIDTipoCliente: TIntegerField;
    LookUpTipoClientePathName: TStringField;
    dsLookUpTipoCliente: TDataSource;
    LookUpTipoPessoa: TLookUpADOQuery;
    LookUpTipoPessoaIDTipoPessoa: TIntegerField;
    LookUpTipoPessoaPathName: TStringField;
    LookUpTipoPessoaPath: TStringField;
    dsLookUpTipoPessoa: TDataSource;
    LookUpPessoa: TLookUpADOQuery;
    LookUpPessoaIDPessoa: TIntegerField;
    LookUpPessoaCode: TIntegerField;
    dsLookUpPessoa: TDataSource;
    LookUpContaCorrente: TLookUpADOQuery;
    LookUpContaCorrenteIDContaCorrente: TAutoIncField;
    LookUpContaCorrenteNumero: TStringField;
    dsLookUpContaCorrente: TDataSource;
    LookUpTipoConta: TLookUpADOQuery;
    LookUpTipoContaIDTipoConta: TIntegerField;
    LookUpTipoContaPathName: TStringField;
    LookUpTipoContaPath: TStringField;
    dsLookUpTipoConta: TDataSource;
    LookUpLancamentoTipo: TLookUpADOQuery;
    LookUpLancamentoTipoIDLancamentoTipo: TIntegerField;
    LookUpLancamentoTipoLancamentoTipo: TStringField;
    LookUpLancamentoTipoCodigoContabil: TStringField;
    dsLookUpLancamentoTipo: TDataSource;
    LookUpDocumentoTipo: TLookUpADOQuery;
    dsLookUpDocumentoTipo: TDataSource;
    dsLookUpDocumento: TDataSource;
    LookUpDocumento: TLookUpADOQuery;
    LookUpDocumentoDocumento: TStringField;
    LookUpTipoFabricante: TLookUpADOQuery;
    LookUpTipoFabricanteIDTipoFabricante: TIntegerField;
    StringField1: TStringField;
    dsLookUpTipoFabricante: TDataSource;
    LookUpFabricante: TLookUpADOQuery;
    LookUpFabricanteIDPessoa: TIntegerField;
    LookUpFabricanteCode: TIntegerField;
    LookUpFabricanteIDFabricante: TIntegerField;
    dsLookUpFabricante: TDataSource;
    LookUpCotacao: TLookUpADOQuery;
    LookUpCotacaoIDCotacao: TIntegerField;
    LookUpCotacaoCotacao: TStringField;
    dsLookUpCotacao: TDataSource;
    LookUpCentroCusto: TLookUpADOQuery;
    StringField2: TStringField;
    LookUpCentroCustoIDCentroCusto: TIntegerField;
    dsLookUpCentroCusto: TDataSource;
    LookUpMeioPag: TLookUpADOQuery;
    LookUpMeioPagIDMeioPag: TIntegerField;
    LookUpMeioPagMeioPag: TStringField;
    dsLookUpMeioPag: TDataSource;
    LookUpRamoAtividade: TLookUpADOQuery;
    LookUpRamoAtividadeIDRamoAtividade: TIntegerField;
    LookUpRamoAtividadeRamoAtividade: TStringField;
    dsLookUpRamoAtividade: TDataSource;
    LookUpCostType: TLookUpADOQuery;
    LookUpCostTypeIDCostType: TIntegerField;
    LookUpCostTypeCostType: TStringField;
    dsLookUpCostType: TDataSource;
    LookUpUnidade: TLookUpADOQuery;
    LookUpUnidadeIDUnidade: TIntegerField;
    LookUpUnidadeUnidade: TStringField;
    LookUpUnidadeSigla: TStringField;
    dsLookUpUnidade: TDataSource;
    LookUpSalesPerson: TLookUpADOQuery;
    LookUpSalesPersonIDPessoa: TIntegerField;
    LookUpSalesPersonIDComissionado: TIntegerField;
    LookUpSalesPersonCode: TIntegerField;
    LookUpSalesPersonPessoa: TStringField;
    dsLookUpSalesPerson: TDataSource;
    LookUpNewModel: TLookUpADOQuery;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    dsLookUpNewModel: TDataSource;
    LookUpMedia: TLookUpADOQuery;
    LookUpMediaIDMedia: TIntegerField;
    LookUpMediaMedia: TStringField;
    dsLookUpMedia: TDataSource;
    LookUpCashRegStatus: TLookUpADOQuery;
    LookUpCashRegStatusIDCashRegStatus: TIntegerField;
    LookUpCashRegStatusCashRegStatus: TStringField;
    dsLookUpCashRegStatus: TDataSource;
    LookUpOther: TLookUpADOQuery;
    LookUpOtherIDPessoa: TIntegerField;
    LookUpOtherIDComissionado: TIntegerField;
    LookUpOtherCode: TIntegerField;
    LookUpOtherPessoa: TStringField;
    dsLookUpOther: TDataSource;
    LookUpHotel: TLookUpADOQuery;
    LookUpHotelIDHotel: TIntegerField;
    LookUpHotelHotel: TStringField;
    dsLookUpHotel: TDataSource;
    LookUpBarCode: TLookUpADOQuery;
    LookUpBarCodeDescBarCode: TStringField;
    LookUpBarCodeIDBarCode: TStringField;
    LookUpBarCodeIDModel: TIntegerField;
    LookUpBarCodeModel: TStringField;
    LookUpBarCodeDescription: TStringField;
    dsLookUpBarCode: TDataSource;
    LookUpModelInv: TLookUpADOQuery;
    IntegerField2: TIntegerField;
    StringField5: TStringField;
    StringField6: TStringField;
    dsLookUpModelInv: TDataSource;
    LookUpPais: TLookUpADOQuery;
    LookUpPaisIDPais: TIntegerField;
    LookUpPaisCodPais: TStringField;
    LookUpPaisPais: TStringField;
    dsLookUpPais: TDataSource;
    dsLookUpEmpresa: TDataSource;
    quLookUPEmpresa: TLookUpADOQuery;
    quLookUPEmpresaIDEmpresa: TIntegerField;
    quLookUPEmpresaEmpresa: TStringField;
    LookUpGroupPath: TLookUpADOQuery;
    IntegerField3: TIntegerField;
    StringField7: TStringField;
    StringField8: TStringField;
    LookUpGroupPathPath: TStringField;
    dsLookUpGroupPath: TDataSource;
    LookUpColor: TLookUpADOQuery;
    LookUpColorIDColor: TIntegerField;
    LookUpColorColor: TStringField;
    LookUpColorCodColor: TStringField;
    dsLookUpColor: TDataSource;
    LookUpSize: TLookUpADOQuery;
    LookUpSizeIDSize: TIntegerField;
    LookUpSizeSizeName: TStringField;
    LookUpSizeCodSize: TStringField;
    dsLookUpSize: TDataSource;
    LookUpModelMaster: TLookUpADOQuery;
    StringField9: TStringField;
    IntegerField4: TIntegerField;
    StringField10: TStringField;
    dsLookUpModelMaster: TDataSource;
    quLookUpTaxCategory: TLookUpADOQuery;
    quLookUpTaxCategoryIDTaxCategory: TAutoIncField;
    quLookUpTaxCategoryTaxCategory: TStringField;
    quLookUpTaxCategoryTax: TBCDField;
    dsLookUpTaxCategory: TDataSource;
    LookUpMeioPagBatch: TLookUpADOQuery;
    IntegerField5: TIntegerField;
    StringField11: TStringField;
    dsLookUpMeioPagBatch: TDataSource;
    LookUpStoreAll: TLookUpADOQuery;
    IntegerField6: TIntegerField;
    StringField12: TStringField;
    dsLookUpStoreAll: TDataSource;
    quSrvParam: TADOQuery;
    quSrvParamSrvParameter: TStringField;
    quSrvParamSrvValue: TStringField;
    quSrvParamSrvType: TStringField;
    quSrvParamDescription: TStringField;
    quSrvParamDefaultValue: TStringField;
    quRebuildIdent: TADOQuery;
    quRebuildIdentTABLE_QUALIFIER: TStringField;
    quRebuildIdentTABLE_OWNER: TStringField;
    quRebuildIdentTABLE_NAME: TStringField;
    quRebuildIdentTABLE_TYPE: TStringField;
    quRebuildIdentREMARKS: TStringField;
    spGetIDUser: TADOStoredProc;
    spCheckOpenCash: TADOStoredProc;
    imgSubMenu: TImageList;
    quAccess: TADOQuery;
    quAccessCanAccess: TBooleanField;
    strepPredefined: TcxStyleRepository;
    imgBTN: TImageList;
    imgSmall: TImageList;
    quLookUpModelPack: TLookUpADOQuery;
    dsLookUpModelPack: TDataSource;
    LookUpModelMasterPack: TLookUpADOQuery;
    StringField15: TStringField;
    IntegerField8: TIntegerField;
    StringField16: TStringField;
    dsLookUpModelMasterPack: TDataSource;
    LookUpBank: TLookUpADOQuery;
    LookUpBankIDBanco: TIntegerField;
    LookUpBankCodigoBanco: TStringField;
    LookUpBankBanco: TStringField;
    dsLookUpBank: TDataSource;
    quSrvParamIDParam: TIntegerField;
    LookUpHistoryType: TLookUpADOQuery;
    dsLookUpHistoryType: TDataSource;
    LookUpHistoryTypeIDHistoryType: TIntegerField;
    LookUpHistoryTypeHistoryType: TStringField;
    LookUpModelService: TLookUpADOQuery;
    StringField17: TStringField;
    IntegerField9: TIntegerField;
    StringField18: TStringField;
    dsLookUpModelService: TDataSource;
    dsLookUpModelKit: TDataSource;
    LookUpModelKit: TLookUpADOQuery;
    StringField19: TStringField;
    IntegerField10: TIntegerField;
    StringField20: TStringField;
    LookUpProspects: TLookUpADOQuery;
    dsLookUpProspects: TDataSource;
    LookUpModelCredit: TLookUpADOQuery;
    StringField22: TStringField;
    IntegerField14: TIntegerField;
    StringField23: TStringField;
    dsLookUpModelCredit: TDataSource;
    quSrvParamLanguage: TADOQuery;
    quSrvParamLanguageIDParam: TIntegerField;
    LookUpTaxCategPur: TLookUpADOQuery;
    AutoIncField1: TAutoIncField;
    StringField24: TStringField;
    BCDField1: TBCDField;
    dsLookUpTaxCategPur: TDataSource;
    dsLookUpSizeGroup: TDataSource;
    LookUpSizeGroup: TLookUpADOQuery;
    dsLookUpColorGroup: TDataSource;
    LookUpColorGroup: TLookUpADOQuery;
    LookUpColorGroupIDSizeColorGroup: TIntegerField;
    LookUpColorGroupDescription: TStringField;
    LookUpSizeGroupIDSizeColorGroup: TIntegerField;
    LookUpSizeGroupDescription: TStringField;
    LookUpPetPorte: TLookUpADOQuery;
    dsLookUpPorte: TDataSource;
    LookUpPetPorteIDPorte: TIntegerField;
    LookUpPetPortePorte: TStringField;
    LookUpPetRace: TLookUpADOQuery;
    dsLookUpPetRace: TDataSource;
    dsLookUpPetSpecies: TDataSource;
    LookUpPetSpecies: TLookUpADOQuery;
    LookUpPetSpeciesIDSpecies: TIntegerField;
    LookUpPetSpeciesSpecies: TStringField;
    LookUpDeliverTypeMaxDeliverDelay: TIntegerField;
    LookUpDeliverTypeCanExchangeItem: TBooleanField;
    quLookUpGroupUserCode: TStringField;
    LookUpFabricanteUserCode: TStringField;
    quTestMessage: TADOQuery;
    quTestMessageMessages: TIntegerField;
    LookUpRoundType: TLookUpADOQuery;
    dsLookUpRoundType: TDataSource;
    LookUpRoundTypeIDRoundingTable: TIntegerField;
    LookUpRoundTypeRoundingTable: TStringField;
    LookUpModelGroup: TLookUpADOQuery;
    LookUpModelSubGroup: TLookUpADOQuery;
    dsLookUpModelGroup: TDataSource;
    dsLookUpModelSubGroup: TDataSource;
    LookUpModelGroupIDModelGroup: TIntegerField;
    LookUpModelSubGroupIDModelSubGroup: TIntegerField;
    LookUpModelSubGroupUserCode: TStringField;
    LookUpModelGroupUserCode: TStringField;
    LookUpCustomerIDCliente: TIntegerField;
    LookUpCustomerIDComissionado: TIntegerField;
    LookUpCustomerCliente: TStringField;
    LookUpCustomerCode: TIntegerField;
    LookUpModelGroupModelGroup: TStringField;
    LookUpModelSubGroupModelSubGroup: TStringField;
    LookUpDefectType: TLookUpADOQuery;
    dsLookUpDefectType: TDataSource;
    LookUpDefectTypeIDDefectType: TIntegerField;
    LookUpDefectTypeDefectType: TStringField;
    LookUpDepartment: TLookUpADOQuery;
    dsLookupDepartment: TDataSource;
    LookUpDepartmentIDDepartment: TIntegerField;
    LookUpDepartmentDepartment: TStringField;
    LookUpSalesPersonEdited: TLookUpADOQuery;
    dsLookUpSalesPersonEdited: TDataSource;
    LookUpSalesPersonEditedIDSalesPerson: TIntegerField;
    LookUpSalesPersonEditedIDComissionado: TIntegerField;
    LookUpSalesPersonEditedPessoaEdited: TStringField;
    LookUpSalesPersonEditedCode2: TIntegerField;
    LookUpInvReason: TLookUpADOQuery;
    dsLookUpInvReason: TDataSource;
    LookUpInvReasonIDMovReason: TIntegerField;
    LookUpInvReasonReason: TStringField;
    LookUpMargemType: TLookUpADOQuery;
    LookUpMargemTypeIDMargemTable: TIntegerField;
    LookUpMargemTypeMargemTable: TStringField;
    dsLookUpMargemType: TDataSource;
    LookUpPHistoryType: TLookUpADOQuery;
    dsLookUpPHistoryType: TDataSource;
    LookUpPHistoryTypeIDPessoaHistoryType: TIntegerField;
    LookUpPHistoryTypePessoaHistoryType: TStringField;
    LookUpFabricantePessoa: TStringField;
    spInventoryCalcBalance: TADOStoredProc;
    quLookupRebateCalendar: TLookUpADOQuery;
    dsLookupRebateCalendar: TDataSource;
    quLookupRebateCalendarIDRebateCalendar: TIntegerField;
    quLookupRebateCalendarDescription: TStringField;
    quLookupRebateCalendarDiscountPerc: TFloatField;
    quLookupRebateCalendarStartDate: TDateTimeField;
    quLookupRebateCalendarEndDate: TDateTimeField;
    LookUpCashRegLogReason: TLookUpADOQuery;
    StringField25: TStringField;
    dsLookUpCashRegLogReason: TDataSource;
    LookUpCashRegLogReasonIDCashRegLogReason: TIntegerField;
    LookUpModelKitCaseQty: TBCDField;
    LookUpModelCaseQty: TBCDField;
    LookUpPetRaceIDBreed: TIntegerField;
    LookUpPetRaceBreed: TStringField;
    LookUpFornecedorIDFornecedor: TIntegerField;
    LookUpFornecedorFornecedor: TStringField;
    LookUpDocumentoTipoIDDocumentoTipo: TIntegerField;
    LookUpDocumentoTipoDocumentoTipo: TStringField;
    LookUpDocumentType: TLookUpADOQuery;
    dsLookUpDocumentType: TDataSource;
    LookUpDocumentTypeIDDocumentType: TIntegerField;
    LookUpDocumentTypeDocumentType: TStringField;
    quEntityFields: TADODataSet;
    dspEntityFields: TDataSetProvider;
    cdsEntityFields: TClientDataSet;
    cdsEntityFieldsIDPessoaValidation: TIntegerField;
    cdsEntityFieldsIDTipoPessoa: TIntegerField;
    cdsEntityFieldsPessoaField: TStringField;
    LookUpMeioPagTipo: TIntegerField;
    LookUpCFOP: TLookUpADOQuery;
    dsLookUpCFOP: TDataSource;
    LookUpCFOPIDCFOP: TIntegerField;
    LookUpCFOPNumber: TStringField;
    LookUpCFOPDescription: TStringField;
    LookUpPessoaPessoa: TStringField;
    LookUpFornecedorIDPessoa: TIntegerField;
    LookUpMeioPagRequireCustomer: TBooleanField;
    LookUpLot: TLookUpADOQuery;
    dsLookUpLot: TDataSource;
    LookUpLotIDLote: TIntegerField;
    LookUpLotLot: TStringField;
    LookUpMeioPagPrintBankBillet: TBooleanField;
    LookUpLancamentoTipoPagando: TBooleanField;
    LookUpNCM: TLookUpADOQuery;
    dsLookUpNCM: TDataSource;
    LookUpNCMIDNCM: TIntegerField;
    LookUpNCMCodigo: TStringField;
    LookUpNCMDescricao: TStringField;
    LookUpNCMMVAInterno: TBCDField;
    LookUpNCMMVAInterestadual: TBCDField;
    LookUpNCMIncide: TBooleanField;
    LookUpMunicipio: TLookUpADOQuery;
    LookUpMunicipioIDMunicipio: TIntegerField;
    LookUpMunicipioCodigo: TStringField;
    LookUpMunicipioDescricao: TStringField;
    dsLookupMunicipio: TDataSource;
    LookUpMeioPagValidateNonpayer: TBooleanField;
    LookUpCustomerAddress: TLookUpADOQuery;
    dsLookUpCustomerAddress: TDataSource;
    LookUpCustomerAddressIDPessoaAddress: TIntegerField;
    LookUpCustomerAddressName: TStringField;
    LookUpCustomerAddressAddress: TStringField;
    LookUpProspectsIDComissionado: TIntegerField;
    LookUpProspectsCliente: TStringField;
    LookUpProspectsCode: TIntegerField;
    LookUpProspectsIDPessoa: TIntegerField;
    LookUpProspectsIDCliente: TIntegerField;
    quLookupNutrition: TLookUpADOQuery;
    dsLookUpNutrition: TDataSource;
    quLookupNutritionIDNutrition: TIntegerField;
    quLookupNutritionDescription: TStringField;
    quCalcTaxST: TADODataSet;
    quCalcTaxSTT_SituacaoTributaria: TIntegerField;
    quCalcTaxSTEstadoCliente: TStringField;
    quCalcTaxSTEstadoLoja: TStringField;
    quCalcTaxSTTaxCategoriaPer: TBCDField;
    quCalcTaxSTTaxEstadoPerc: TBCDField;
    quCalcTaxSTMVAInterno: TBCDField;
    quCalcTaxSTMVAInterestadual: TBCDField;
    quCalcTaxSTT_AliquotaST: TBCDField;
    quCalcTaxSTIM_QTY: TBCDField;
    quCalcTaxSTIM_Discount: TBCDField;
    quCalcTaxSTIM_SalePrice: TBCDField;
    cmdUpdateSTTax: TADOCommand;
    HTTPReqRespCatalog: THTTPReqResp;
    quLookUpModelPackIDModel: TIntegerField;
    quLookUpModelPackModel: TStringField;
    quLookUpModelPackDescription: TStringField;
    quLookUpModelPackCaseQty: TBCDField;
    quLookUpModelPackNotVerifyQty: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure LookUpBarCodeCalcFields(DataSet: TDataSet);
    function quLookUpGroupClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLookUpStoreClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpComissionadoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpUserTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpCashRegClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpUserClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpSalesPersonClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpEstadoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLookUpIMTClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpHotelClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpFornecedorClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpModelInvClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpDeliverTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpSpcPriceClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpModelClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpMeioPagClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpAgencyClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpGuideClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpFabricanteClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpCentroCustoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpUnidadeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpNewModelClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpCostTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpOtherClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpPaisClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpCustomerClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpColorClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpSizeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpModelMasterClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLookUpTaxCategoryClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    procedure quLookUpStoreBeforeOpenGrid(Sender: TObject);
    function LookUpHistoryTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpProspectsClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpColorGroupClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpSizeGroupClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpPetPorteClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpPetRaceClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpPetSpeciesClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpDefectTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpDepartmentClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpInvReasonClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpPHistoryTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLookupRebateCalendarClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpCashRegLogReasonClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpDocumentTypeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpCFOPClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpRamoAtividadeClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpLotClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpNCMClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpMunicipioClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLookupNutritionClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
  private
    // Antonio M F Souza: March 15, 2013
    fTableName: String;

    FCounterPuppyFromHold: Integer;
    FHandleError      : THandleError;
    MyLocalPrinter    : TPrinterDefaultClass;
    slOriginalSQL     : TStringList;
    fInvPollDisplay   : TInvoice;
    fRestricForms     : String; //Used to replication
    fGridLayoutFileName  : String;
    fStartPollDisplay : Boolean;
    fGridRegistry : TRegistry;

    //Antonio M F Souza 01.10.2012
    FCdsMercuryGift: TClientDataSet;

    fCdsPreSerialMov: TClientDataset;

    function IsDBaseEmpty: boolean;
    procedure CreatePredefinedStyleSheetsList;
    procedure SendCashCode(ACode: String; NeedCloseOpenDoc: Boolean = True);
    function ReconnectDatabase(AConnection: TADOConnection): Boolean;
    procedure AppException(Sender: TObject; E: Exception);
    procedure CreatePollDisplay;
    procedure OpenEntityFields;
    procedure CloseEntiryFields;
    procedure GetSQLServerInfo;
    procedure setServerFormat(AToIndustry: boolean);
    function getNextKeyPreinventoryMov(): Integer;



    // Antonio M F Souza,
    { SQL searches should be outside of dataware components to make easy and clean to read the code}

    function deleteSalAccountCardByPreInvMovSQL(): String;
    function getPaymentWaySQL(): String; overload;
    function getPaymentWaySQL(arg_payMethod: String): String; overload;
    function getPaymentWaySQL(arg_idpayMethod: Integer): String; overload;

    // Antonio 04/18/2016
    function getPaymentWayByPayTypeSQL(argIdPayType: Integer; arg_parentType: String = ''): String;

    // Antonio 2013 Oct 9, MR-60
    function insertMercuryGiftPaymentTypeSQL(): String;
    function dealMercuryPaymentType(arg_idPaymentType: Integer): Integer;
    function selectAnyMercuryPaymentType(arg_paymentType: TClientDataset): Integer;
    function isGiftMercuryPaymentType(arg_idPaymentType: Integer): Boolean;
    function isGiftCardPaymentType(arg_idPaymentType: Integer): Boolean;

    function getOnePreInventoryMovSQL(arg_idPreInventoryMov: Integer): String;
    function getPresaleByModelSQL(arg_document: String; arg_IdModel: Integer): String;
    function getPreSaleSQL(arg_document: String): String;

    function searchPreserialMovSQL(): String;
    function searchPreserialMovEmptySQL(): String;
    function searchPreserialMovInInventoryMovSQL(arg_documentInvoice: Integer): String;

    function searchInvoiceRefundSQL(): String; overload;
    function searchInvoiceRefundSQL(arg_storeId: Integer): String; overload;

    function searchSysModuleSQL(): String;

    function searchModelSQL(): String;
    function searchModelByModelSQL(): String;
    function searchModelByIDModelSQL(): String;

    function updateModelAddQuantityOnHandSQL(): String;

    function searchVendorSQL(): String;
    function searchVendorByIdModelSQL(): String;
    function searchVendorByVendorSQL(): String;

    // Antonio 2014 May 09
    function searchVendorByIdVendorSQL(arg_id: Integer): String;
    function searchDefectTypeSQL(): String;

    // Antonio June 25, 2013
    function getRepairEmptyRecordSQL(): String;
    function insertRepairSQL(): String;
    function getSaleItemRepairSQL(): String;
    function returnToVendorSQL(): String;

    function getStoredProcObject(arg_procedureName: String):TADOStoredProc;
    function getClientDatasetObject(arg_sql: String): TClientDataset;
    procedure mountProviderName(arg_provider: TDatasetProvider);

    function getPromosByModelSQL(): String;
    function getTagsByModelSQL(): String;
    function getAvailableTagsByModelSQL(): String;
    function getTagByTagNameSQL(): String;
    function GetPromoSQL(): String;
    function SeekForConflictOnTagsSQL(): String;
    function SeekForConflictOnPromosSQL(): String;
    function SeekForConflictOnBogoPromoSQL(): string;


    // Antonio M F Souza, Feb 19, 2013
    function searchInventorySQL(arg_idmodel: Integer): String;
    function searchInvoiceItemsSQL(arg_idInventoryMov: Integer): String;

    function searchSaleAccountCardSQL(arg_number: String): String;
    function searchInactiveCategorySQL(arg_name: String): String;
    function searchActiveCategorySQL(arg_name: String) : String;
    function activateCategorySQL(arg_name: String): String;

    // Antonio 201 Nov 20, MR-18
    function getPromoSettingsOnDateSQL(arg_date: TDateTime): String;
    function getCustomerDiscountSQL(arg_idPessoa: Integer): String;

    // Antonio 2013 Dec 14
    function getVendorFromModelSQL(arg_idModel, arg_idVendorCost: Integer): String;
    function getCostFromModelSQL(arg_idModel: Integer): String;

    // Antonio 2013 Nov 08, MR-100
    function getDbVersionSQL(): String;

    // Antonio 2014 Feb 27
    function getPromoYProductSQL(arg_idPromo: Integer; arg_vendorOrder: Integer): String;

    // Antonio 2013 Nov 25, MR-114
    function createDiscountPromoItemList(): TClientDataset;

    // Antonio 2013 Dec 14
    function getVendorFromModel(arg_idmodel, arg_idvendor: Integer): TClientDataset;
    function getCostFromModel(arg_idmodel: Integer): TClientdataset;

    function getIDTagSQL(arg_tagName: String): String;

    // Antonio 2014 Apr 28
    function getTagModelRegistryAttNameSQL(arg_attributeName: String): String;

    // Antonio 2014 Apr 29
    function insertTagModelRegistryAttNameSQL(arg_attributeName: String): String;
    function updateTagModelRegistryAttNameSQL(arg_attValue: String; arg_Id: Integer): String;

    // Antonio 2014 May 05
    function insertItemPurchaseToPOSQL(arg_itemPurchase: TItemPurchaseModel): String;
    function updateItemPurchaseToPOSQL(arg_itemPurchase: TItemPurchaseModel): String;
    function getItemPurchaseToPOSQL(arg_idpo: Integer): String;
    function getNameStoreSQL(arg_idstore: Integer): String;

    // Antonio 2014 May 16
    function updateInvoiceGettingHoldNumberSQL(arg_idPresale, arg_idInvoice: Integer): String;
    function updateInvoiceSettingInvoiceDiscountSQL(arg_idpresale: Integer; arg_invoiceDiscount: double): String;

    function selectManualPriceSQL(arg_idpreinvMov: Integer): String;
    function selectManualPrice(arg_idpreinvmov: Integer): TClientDataset;

    function selectManualDiscountSQL(arg_idpreinvmov: Integer): String;
    function selectManualDiscount(arg_idpreinvmov: Integer): TClientDataset;

    // MR-23
    function getCustomerTaxExemptionSQL(arg_idpessoa: Integer): String;
    function insertCustomerTaxExemptionSQL(arg_idPessoa: Integer; arg_idPresale: Integer): String;

    // Antonio 02/17/2017
    function GetStandardBarcodeSearchSQL(argSearchIndex: Integer; argMakeLabelLikeQtyOnHand: Boolean = false;
    argPrimaryUPC: Boolean = false; argIsEmpty: Boolean = false): String; overload;

    function GetStandardBarcodeSelect(): String;

    function GetStandardBarcodeJoin(): String;

    function GetStandardBarcodeWhere(): String;

    function GetBarcodeFromPurchaseSQL(argMakeLabelLikeQtyOnHand: Boolean = false; argPrimaryUPC: Boolean = false;
    argNumberCopies: Integer = 1): String;

    function GetBarcodeFromTransferSQL(argIdTransfer: String): String;


    function InsertBarcodePrintQueueSQL(): String;

    function UpdateBarcodePrintQueueSQL(): String;

    // Antonio 03/24/2017
    function GetKitInfoSQL(): String;
    function GetKitItemsSQL(): String;  overload;
    function GetKitItemSQL(argKitId: String; argListOfIdModels: String): String; overload;

    function GetBrowseReceivingSQL(): String;

    function GetVendorTermsSQL(): String;
    function IsQuoteHasPOSQL(): String;

    function UpdateItemToPurchaseVerificationSQL(): String;
    function InsertItemToPurchaseVerificationSQL(): String;

    function SelectItemsFromPurchaseVerificationSQL(): String;
    function SelectItemFromPurchaseVerificationSQL(): String;

    function SelectItemByBarcodeInPurchaseSQL(): String;
    function SelectItemByIdModelInPurchaseSQL(): String;

    function InsertReceivingSQL(): String;
    function UpdateReceivingSQL(): String;
    function UpdatePurchaseItemSQL(): String;
    function GetSumByModelInPurchaseSQL(): String;

    // MR-230
    function CreateReasonSQL(): String;
    function ReadAllReasonSQL(): String;
    function ReadReasonSQL(): String;
    function UpdateReasonSQL(): String;
    function DeleteReasonSQL(): String;
    function IsThereMovementReasonSQL(): String;

    // MR-108
    function DeactivateModelSQL(): String;

    function FoundPaymentReferenceTypeSQL(): String;
    function ReadCustomerInfoSQL(): String;

    function ActivateTagModelSQL(): String;
    function ActivateTagModelByPKSQL(): String;
    function GetModelsFromTagModelSQL(): String;
    function GetModelsFromPromoSQL(): String;
    function GetModelsRewardFromPromoSQL(): string;
    function GetTagsFromPromoSQL(): String;
    function GetTagsRewardFromPromoSQL(): string;
    function GetNameTagSQL(): String;

    function DeletePurchaseTagListSQL(): String;
    function deleteRewardTagListSQL(): string;
    function DeleteCouponListSQL(): String;
    function getSalesWithBogoSQL(): String;
    function getSaleTotalBogosSQL(): String;
    function getBogoOrphansFromSaleSQL(): string;

    function GetCurrentPromoByDiscountTypeSQL(): string;   //Discount Type: promo, coupon

  public
    FTraceControl     : TMRTraceControl;
    fStore            : TStore;         //Store information
    fUser             : TMRUser;        //User information
    fCashRegister     : TCashRegister;  //Cash Reg information
    fSystem           : TMRSystem;      //System information
    fMainMenu         : TMRMenu;        //Menu information
    fPrintReceipt     : TMRPrintReceipt;//Printer info
    fGrid             : TMRGrid;        //Grid Layout
    fInvoice          : TMRInvoice;     //Invoice information
    fPinPad           : TMRPinPad;      //Pinpad information
    fPOS              : TFrmPOSFunctions; //POS functions
    fPredefinedStyle  : TStringList;    //Style for Grid
    WaitForm          : TWaitForm;      //Show Wait search
    fPCCharge         : TMRPCCharge;    //PCCharge
    fMRMercury        : TMRMercury;     //Mercury Credit Card
    fMRGynbo          : TMRGynbo;       //MRGynbo integration
    fPollDisplay      : TPollDisplay;   //Poll Dispplay
    fPetCenter        : TPetCenter;     //Pet Center
    fStartOption      : Integer;
    fFrmNewMessage    : TFrmNewMessage;
    FDMCalcPrice      : TDMCalcPrice;
    FMainRetailConfig : TIniFile;
    FFchParam         : String;         //Parametro criado para passar para fch no Add/update do lookup
    FDMInventory      : TDMInventory;
    FQtyDecimal       : Integer;
    FQtyDecimalFormat : String;
    FBonusSync        : TbgBonusSync;
    FDsiPDCX: TDsiPDCX;


    // Antonio 03/31/2017
    FPayMethod: TPayMethod; // to save payMethod objects.
    FPayMethodList: TPayMethodList;

    property cdsPreserialMov: TClientDataset read fCdsPreSerialMov write fCdsPreSerialMov;

    property CounterPuppyFromHold: Integer read FCounterPuppyFromHold write FCounterPuppyFromHold;

    property cdsMercuryGift: TClientDataSet read FCdsMercuryGift;

    // Antonio 2013 Oct 9, MR-60
    function createMercuryPaymentType(arg_idPaymentType: Integer): Integer;

    // Antonio 2013 Nov 19, MR-18
    function getSellingPriceAfterCustomerDiscount(arg_idPessoa: Integer; arg_sellingPrice: Double): Currency;
    function getDiscountPromoItemList(arg_date: TDateTime): TClientDataset;

    // Antonio 2013 Dec 11
    function getCustomerDiscount(arg_idpessoa: Integer): Double;

    //Antonio M F Souza 01.10.2012
    procedure CreateCdsMercuryGift();
    function AddCardNumberToCdsMercuryGift(card_number: String; balance: Double; gift_transaction: String; issued: Integer): Boolean;
    function CleanCdsMercuryGift(): Boolean;
    procedure DestroyCdsMercuryGift(cdsMercury: TClientDataset);

    //Antonio M F Souza 12.06.2011
    function isGiftCardModel(idmodel: Integer): Boolean;

    // Antonio M F Souza 10.06.2011
    function verifyPuppyInPetCategory(pIdModel: Integer): boolean;

    //Antonio M F Souza 12.31.2010 - gives a idpresale having a hold number
    function getIdPreSale(AHoldNumber: Integer): Integer;
    function IsFormsRestric(fForm:String):Boolean; //Replication restriction
    procedure BuildRestricForms(fForms:String);

    procedure OpenCashRegister(iType : Integer);  //Colocar no Cash Reg Object mais com o TPrinter tb

    procedure SendAfterPrintCode(StartPrinter:Boolean = False);

    procedure SetClientToServerDate;
    procedure SetError(ErrorType: Integer; sSource, sError: String);
    procedure PrintLine(MyText:String); //Print text to local port
    procedure PrinterStart;             //Print text to local port
    procedure PrinterStop;              //Print text to local port

    function foundManualPrice(arg_idpreinvmov: Integer): Boolean;
    function foundManualDiscount(arg_idpreinvmov: Integer): Boolean;
    function NewQuery: TADOQuery;
    function CheckCashRegState(IDDefaultReg : Integer; var IDCashRegMov : integer) : integer;
    function GetIDUserComission(IDComission : integer) : integer;
    function GetServerDate:TDateTime;
    function GetActualPathName(strSQL, FieldName : String; IDItem : Integer) : String;
    function ModelRestored(IDModel:Integer):Boolean;
    function GetContaCorrente(iIDMeioPag,iIDStore:Integer):Integer; //Financeiro function
    function SetupStore(quQuery: TADOQuery; sIDStore: String): boolean; //Replicagem
    function CreateLocalRegistry:TRegistry;
    function CanAccessMenu(IDMenu, IDSubMenu:Integer; PW:String):Boolean;

    property GridLayoutFileName  : String read fGridLayoutFileName;

    procedure CallReport(PW : String);

    function DisplayLicenseForm:Boolean;
    procedure ValidateLicense;

    procedure SendPuppyInfo(fIDInvoice:Integer);
    procedure SendPetCenterInfo(fIDPreSale : Integer);

    procedure VerifyMessage;

    function GetPrinterCode(Code:String):String;
    function SaleHavePuppyTrackerItem(IDPreSale:Integer): Boolean;

    //Printer
    procedure SendPrinterCommands(aReportCanvas: TCanvas; aPrinterCommands: String);

    procedure ProcessInventoryBalance;

    procedure PollDisplayInvInfo(ASaleCode: String; ASaleDate: TDatetime; AAddCostTotal,
              ADiscountTotal, ATaxTotal, ASubTotal: Currency; UpdateFile : Boolean = False);
    procedure PollDisplayAddItem(AID, AIDModel : Integer; AModel, ADescription : String; AQty : Double;
              ASalePrice, ADiscount : Currency);
    procedure PollDisplayAddPayment(AID : Integer; APayment : String; AAMount : Currency);
    procedure PollDisplayCloseSale;
    procedure PollDisplayDeleteItem(AID : Integer);
    procedure PollDisplayDeletePayment(AID : Integer);
    procedure PollDisplayOpenHoldItems(FspquPreSaleItem: TADOStoredProc);

    //PetCenter
    function CreatePetSale(AIDPreInvMov, AIDPet, AIDCustomer : Integer; AQty : Double) : Integer;
    function GetWarrantyReportID(AIDPet : Integer) : Integer;

    function ExecRunning : Integer;

    //Entity Field
    procedure RefreshEntityField;
    function FilterEntyField(AIDTipoPessoa : Integer):String;

    //Grid
    procedure SaveGridToRegistry(AGrid: TcxGridDBTableView; APath : String;
                                 ARecreate: Boolean; AOptions: TcxGridStorageOptions);
    procedure LoadGridFromRegistry(AGrid: TcxGridDBTableView; APath : String;
                                 AOptions: TcxGridStorageOptions);

   //Calculo Imposrto ST
   function CalcularImpostoST(IDPreSale: Integer):Currency;

   //Bonus
   function BonusGenerate(AInvoiceTotal, ABonusValue : Currency; AInvoiceNumber : String; AInvoiceDate : TDateTime;
                         var ABonusCode : String; var AIDError: Integer; var AErrorMsg: String):Boolean;
   function BonusUse(ABonusCode : String; var ABonusValue : Currency; var AIDError: Integer; var AErrorMsg: String):Boolean;
   function BonusVoid(ABonusCode : String; var AIDError: Integer; var AErrorMsg: String):Boolean;
   function BonusUnUse(ABonusCode : String; var AIDError: Integer; var AErrorMsg: String):Boolean;

   //Antonio M F Souza September 10, 2012
   function IsCashRegisterOpen(pIdCashRegister: Integer): Boolean;
   function setCashRegister(pIdCashRegister: Integer; pOpen: Boolean = true): Boolean;
   function getCashRegisterName(pIdCashRegister: Integer): String;
   function IsUserTypeSystem(pIdUserType: Integer): Boolean;

   // Antonio 2013 Oct 2, MR-15
   function isInactiveSameCategory(arg_name: String): Boolean;

   // Antonio 2013 Nov 6, MR-15
   function IsActiveSameCategory(arg_name: String): Boolean;


    // Antonio M F Souza - Objects to retrieve information from database according to SQL passed by argument.
   function promosByModel(arg_idmodel: Integer): TClientDataset;
   function tagsByModel(arg_idmodel: Integer): TClientDataset;
   function getTagsAvailableByModel(arg_idmodel: Integer): TClientDataset;
   function getTagByTagName(arg_tagname: String): TClientDataset;
   function GetPromos(endOnDate: TDateTime): TObjectList;
   function SeekForConflictOnTag(idModelList: String; idtagList: String): TObjectList; overload;
   function SeekForConflictOnTag(idTagList: String; idModelList: String; toGridView: Integer): TClientDataset; overload;

   function SeekForConflictOnPromo(idModelList: String; idPromoList: TObjectList): TObjectList; overload;
   function SeekForConflictOnPromo(idPromoList: TObjectList; idModelList:String; toGridView: Integer): TClientDataset; overload;
   function SeekForConflictBogoPromo(idModelList: string; idPromoList: TObjectList): TObjectList;


   function callSpCouponUpsert(arg_document: Integer; arg_coupon: String): TADOStoredProc;

   function callSpItemSale(arg_idpresale, arg_idpreinvmov: Integer; arg_presaledate: TDateTime): TADOStoredProc;
   function callSpInvoiceSale(arg_idpresale: Integer): TADOStoredProc;
   function callSpCreateHold(arg_list: TStringList): TADOStoredProc;

   // Antonio Apr 11, 2014 - Sps to Tag tables
   function callSpTagSelect(arg_idTag: Integer): TADOStoredProc;
   function callSpTagDelete(arg_idTag: Integer): TADOStoredProc;
   function callSpTagUpSert(out arg_idTag: Integer; arg_tagName, arg_oper: String): TADOStoredProc;

   function callSpTagModelSelect(arg_idTagModel: Integer): TADOStoredProc;
   function callSpTagModelDelete(arg_idTagModel: Integer): TADOStoredProc;
   function callSpTagModelUpSert(arg_idTag, arg_idModel: Integer): TADOStoredProc;
   function callSpTagModelCount(): TADOStoredProc;
   function callSpTagsForModel(arg_idModel: Integer): TADOStoredProc;


   function callSpTagQtyDiscountBreakSelect(arg_idTag: Integer): TADOStoredProc;
   function callSpTagQtyDiscountBreakDelete(arg_idTag: Integer): TADOStoredProc;
   function callSpTagQtyDiscountBreakUpSert(arg_idDiscount, arg_idTag, arg_minQty: Integer): TADOStoredProc;

   function callSpTagQtyPriceBreakSelect(arg_idTag: Integer): TADOStoredProc;
   function callSpTagQtyPriceBreakDelete(arg_idTag: Integer; arg_minQty: Integer): TADOStoredProc;
   function callSpTagQtyPriceBreakUpSert(arg_discount: Currency; arg_idTag, arg_minQty: Integer): TADOStoredProc;

   // Antonio 2013 Oct 9, MR-60
   function insertMercuryGiftPaymentType(arg_PaymentType: TClientDataset): Integer;

   function getPaymentWay(): TClientDataset; overload;
   function getPaymentWay(arg_payMethod: String): TClientDataset; overload;
   function getPayMentWay(arg_IdpayMethod: Integer): TClientDataset; overload;

   // Antonio 04/18/2016
   function getPaymentWayByPayType(argIdPayTYpe: Integer; arg_parentType: String = ''): TClientDataset;

   // Antonio June 24, 2013
   function getOnePreInventoryMov(arg_idPreinventoryMov: Integer): TClientDataset;

  // Antonio June 20, 2013
  function getSaleItemRepair(arg_item: TClientDataset): TClientDataset;

  function getPresaleByModel(arg_document: String; arg_IdModel: Integer): TClientDataset;
  function getPresale(arg_document: String): TClientDataset;

  function searchPreserialMov(): TClientDataset;
  function searchPreserialMovEmpty(): TClientDataset;
  function searchPreserialMovInInventoryMov(arg_documentInvoice: Integer): TClientdataset;
  function searchSysModule(): TClientDataset;

  function searchInvoiceRefund(): TClientDataset; overload;
  function searchInvoiceRefund(arg_storeId: Integer): TClientDataset; overload;

  function searchInvoiceItems(arg_idInventoryMov: Integer): TClientDataset;

  function searchModel(): TClientDataset; overload;
  function searchModel(arg_model: String): TClientDataset; overload;
  function searchModel(arg_IdModel: Integer): TClientDataset; overload;

  function updateModelAddQuantityOnHand(arg_record: TClientDataset): Boolean;
  function deleteSalAccountCardByPreInvMov(arg_idpreinvmov: Integer): Boolean;

  function searchVendor(): TClientDataset; overload;
  function searchVendor(arg_idModel: Integer): TClientDataset; overload;
  function searchVendor(arg_vendor: String): TClientDataset; overload;

  function searchDefectType(): TClientDataset;

  // Antonio June 25, 2013
  function getRepairEmptyRecord(): TClientDataset;
  function insertRepair(arg_item: TClientDataset): boolean;
  function returnToVendor(arg_Item: TClientDataset): Boolean;

  // Antonio M F Souza, Feb 19, 2013
  function searchInventory(arg_idmodel: Integer): TClientDataset;

  function searchSaleAccountCard(arg_number: String): TClientDataSet;

  // Antonio 2013 oct 2, MR-15
  function searchInactiveCategory(arg_name: String): TClientDataset;
  function activateCategory(arg_name: String): Boolean; overload;
  function activateCategory(arg_id: Integer): Boolean; overload;

  // Antonio 2013 Nov 6, MR-15
  function searchActiveCategory(arg_name: String): TClientDataset;

  // Antonio 2013 Nov 08, MR-100
  function getDbVersion(): TClientDataset;
  function getBuildDbVersion(): Integer;

  // Antonio 2013 Dec 14
  function getCostToPO(arg_idModel, arg_idVendor: Integer): Double;

  function getPromoSettingsOnDate(arg_date: TDateTime): TClientDataset;

  // Antonio 2014 Feb 27
  function getPromoItemsHigherPrice(arg_idPromo: Integer; arg_vendorOrder: Integer = 1): TClientDataset;

  function getIDTag(arg_tagName: String): TClientDataset;

  function getTagModelRegistryAttName(arg_attributeName: String): TClientDataset;

  procedure insertTagModelRegistryAttName(arg_attributeValue: String);
  procedure updateTagModelRegistryAttName(arg_attValue: String; arg_Id: Integer);

  function getItemPurchaseToPO(arg_idpo: Integer): TClientDataset;
  function insertItemPurchaseToPO(arg_itemPurchase: TItemPurchaseModel): Integer;
  procedure updateItemPurchaseToPO(arg_itemPurchase: TItemPurchaseModel);

  // Antonio 2014 May 9
  function getNameStore(arg_id: Integer): String;
  function searchVendorByIdVendor(arg_id: Integer): String;

  procedure updateInvoiceGettingHoldNumber(arg_idPresale, arg_idInvoice: Integer);
  procedure updateInvoiceSettingInvoiceDiscount(arg_idpresale: Integer; arg_invoiceDiscount: double);

  function getCustomerTaxExemption(arg_idpessoa: Integer): TClientDataset;
  procedure insertCustomerTaxExemption(arg_idpresale: Integer; arg_idcustomer: Integer);

  procedure InitializeDsiPDCXDevice();

  procedure UpdatePriceInInventory(aIdInventory: Integer; aSalePrice: Double);

  // Antonio 02/17/2017
  function GetBarcodeSearchSQL(argIdmodel: Integer; argMakeLabelLikeQtyOnHand: Boolean;
argPrimaryUPC: Boolean): String; overload;

  function GetBarcodeSearchSQL(argCategory: String; argSubCategory: String; argGroup: String;
  argMakeLabelLikeQtyOnHand: Boolean = false; argPrimaryUPC: Boolean = false;
  argIsEmpty: Boolean = false): String; overload;

  function GetBarcodeSearchSQL(argSearchType: Integer; argSearchMethod: Integer; argNameField: String;
  argMakeLabelLikeQtyOnHand: Boolean = false; argPrimaryUPC: Boolean = false;
  argIsEmpty: Boolean = false): String; overload;

  function GetBarcodeSearchSQL(argInitDate, argEndDate: TDateTime; argMakeLabelLikeQtyOnHand: Boolean = false;
  argPrimaryUPC: Boolean = false; argIsEmpty: Boolean = false): String; overload;

  function GetBarcodeSearchSQL(argSearchWith: Integer; argSearchValue: String; argVendor: String;
  argMakeLabelLikeQtyOnHand: Boolean = false; argPrimaryUPC: Boolean = false; argNumberCopy: String = '1';
  argIsEmpty: Boolean = false): String; overload;

  function GetBarcodeSearchSQL(argPurchase: String; argMakeLabelLikeQtyOnHand: Boolean = false;
  argPrimaryUPC: Boolean = false; argNumberCopies: Integer = 1): String; overload;

  function GetBarcodeSearchSQL(argIdTransfer: String; argNumberCopies: Integer): String; overload;

  function GetBarcodeSearch(argSqlSearch: String): TClientDataset;

  function GetBarcodeFromPurchase(argPurchase: String; argMakeLabelLikeQtyOnHand: Boolean = false;
  argPrimaryUPC: Boolean = false; argNumberCopies: Integer = 1): TClientDataset;

  function GetBarcodeFromTransfer(argIdTransfer: String): TClientDataset;

  // Antonio 03/24/2017 - MR-32
  function GetKintInfo(argInvoice: Integer): TClientDataset;
  function GetKitCategory(argSQL: String): TClientDataset;
  function GetKitItems(argIdModel: Integer): TClientDataset; overload;
  function GetKitItems(argKitId: String; argListOfIdModels: String): TClientDataset; overload;

  procedure InsertBarcodePrintQueue(argIdUser: Integer; argIdModel: Integer; argModel: String;
  argDescription: String; argIdBarcode: String; argQtyOnHand: Double; argSellingPrice: Double; argNumCopy: Double;
  argReport: String; argIdSearchType: Integer; argStraightToPrinter: Integer; argPrintQueue: Integer;
  argLabelQtyOnHand: Integer; argPrimaryBarcode: Integer; argLargeImage: String; argLargeImage2: String;
  argManufacturer: String; argVendorNum: String; argVendor: String; argSizeName: String; argColor: String;
  argCodColor: String; argModelToScan: String; argBarcodeToScan: String);

  procedure UpdateBarcodePrintQueue(argNumCopy: Double; argReport: String; argIdSearchType: Integer;
  argStraightToPrinter: Integer; argPrintQueue: Integer; argLabelQtyOnHand: Integer; argPrimaryBarcode: Integer;
  argIdModel: Integer; argModel: String; argDescription: String; argQtyOnHand: Double; argSellingPrice: Double;
  argLargeImage: String; argLargeImage2: String; argManufacturer: String; argVendorNum: String; argVendor: String;
  argSizeName: String; argColor: String; argCodColor: String; argModelToScan: String; argBarcodeToScan: String;
  argIduser: Integer; argIdBarcode: String);

  function GetBrowseReceiving(argStore, argVendor: String; argIniDate, argEndDate: TDateTime; argIsFinal: Boolean = false): String;
  function GetDayShiftVendorTerms(argIDVendor: Integer): Integer;

  function IsQuoteHasPOS(argQuote: String): Boolean;
  procedure UpdateItemToPurchaseVerification(argIdUser, argIdPurchase: Integer; argIdBarcode: String;
            argQtyCounted: Double);

  procedure InsertItemToPurchaseVerification(argIdPurchaseVerify, argIdPurchase, argIdUSer, argIdModel: Integer;
             argIdBarcode: String; argQtyReceiving, argQtyCounted: Double; argScanDate: TDateTime);

  function SelectItemInPurchase(argIdPurchase, argIdModel: Integer): TClientDataSet; overload;
  function SelectItemInPurchase(argIdPurchase: Integer; argIdBarcode: String): TClientDataset; overload;
  function SelectItemsFromPurchaseVerification(argIdPurchase: Integer): TClientDataset;

  function SelectItemFromPurchaseVerification(argIdPurchase, argIdModel: Integer): TClientDataset;
  function GetSumByModelInPurchase(argIdPurchase: Integer): TClientDataset;

  procedure InsertReceiving(argIdPurchase, argIdModel, argIdGroup, argIdVendor: Integer; argQtyScan, argCaseQty: Double; argCost,
                            argSale, argSugg: Currency; argCalcTax: Boolean);

  procedure UpdateReceiving(argIdModel, argIdppItem: Integer; argCaseQtyScan, argQtyScan, argQtyRec: Double;
                            argCostPrice: Currency; argCalcTax: Boolean);

  // Antonio 07/28/2017  MR-230
  procedure CreateReason(argReason: TAdjustReason);
  function ReadAllReason(): TObjectList;
  function ReadReason(argId: Integer): TAdjustReason;
  procedure UpdateReason(argReason: TAdjustReason);
  procedure DeleteReason(argId: Integer);
  function IsThereMovementReason(argId: Integer): Boolean;

  // MR-108
  procedure DeactivateModel(argIdList: TStringList);


  function FoundPaymentReferenceType(payTypeRef: Integer): Integer;

  function ReadCustomerInfo(argIdCustomer: Integer): TClientdataset;

  procedure ActivateTagModel(argIdTag: Integer; argIdModelList: String; argActive: Boolean);
  procedure ActivateTagModelByPK(pkTagModelList: String; argActive: Boolean = false);
  function GetModelsFromTagModel(idTag: Integer): TStringList; overload;
  function GetModelsFromTagModel(idTag: String): TClientDataset; overload;
  function GetTagsFromPromo(idTagSelected: Integer; idPromo: Integer): String;
  function GetTagsRewardFromPromo(idTagSelected: Integer; idPromo: Integer): string;
  function GetModelsFromPromo(idPromo: Integer): String;
  function GetModelsRewardFromPromo(idpromo: integer): string;
  function GetNameTag(idTag: Integer): String;

  procedure DeletePurchaseTagList(idPromo: Integer; idTagList: String);
  procedure deleteRewardTagList(idPromo: integer; idTagList: string);
  procedure DeleteCouponList(idPromo: Integer; idCouponList: String);

  function getCurrentPromoDetails(): TClientdataset;
  function getSalesWithBogo(documentID: integer): TClientdataset;
  function getSaleTotalBogos(documentID: integer; modelID: integer): integer;
  function getBogoOrphansFromSale(idPresale: integer; IdPreInvMovList: string): TClientDataset;

  function GetCurrentPromoByDiscountType(endDate: TDateTime; discountType: string = 'Promo'; idPromo: integer = 0): TClientDataset;

  end;

var
  DM: TDM;

implementation

{$R *.DFM}

uses xBase, uFrmUser, uFrmUserType, uFchPessoa, uFrmGroup, uFrmStore,
  uFrmCashRegister, uBrwUser, uFrmInventMovType, ubrwfrmPais, uModuleConfig,
  uFchModel, uFrmDeliverType, uFrmSpecialPrice, uFchTaxCategory, uFileFunctions,
  uFrmEstado, uFchCostType, uFchUnidade, uPassword, SuperComboADO, ufrmServerInfo,
  uFchHotel, uMsgBox, uFchMeioPag, uBrwFrmColor, uDMGlobal, uSystemConst,
  uBrwFrmSize, uParamFunctions, uEncryptFunctions, uSqlFunctions, uDateTimeFunctions,
  uStringFunctions, uMsgConstant, uNumericFunctions, uFrmLicenseKey, uFchHistoryType,
  uBrwFrmSizeColorGroup, uFchPetSpecies, uFchPetRace, uFchPetPorte,
  DateUtils, uFchSubgroup, StdConvs, uFchDefectType, uFchDepartment,
  uFchInventoryReason, uFchPessoaHistoryType, ADOInt, uFchRebateCalendar,
  uFchCashRegLogReason, uFchDocumentType, uPetCenterCli, uFchCFOP,
  uFchRamoAtividade, uFchLot, uFchNCM, uFchMunicipio, uFchNutrition, Math,
  MRPuppyIntegrationCls, ufrmModelAdd, uDebugFunctions, SelectCorporateView,
  PromoDTO;


//TStore ============================
function TStore.GetIDStorePur: Integer;
begin
  if fIDStorePur = -1 then
    Result := fID
  else
    Result := fIDStorePur;
end;

function TStore.GetIDStoreSale: Integer;
begin
  if fIDStoreSale = -1 then
    Result := fID
  else
    Result := fIDStoreSale;
end;

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

//TMRUser ============================
function TMRUser.Manager:Boolean;
begin
   Result := (IDUserType in [USER_TYPE_MANAGER, USER_TYPE_ADMINISTRATOR]);
end;

function TMRUser.AssistManager:Boolean;
begin
  Result := (IDUserType in [USER_TYPE_ASSIST_MANAGER, USER_TYPE_ADMINISTRATOR]);
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
     Result := StrToIntDef(UpperCase(MyValue),0)
    end
  else if MyType = 'FLOAT' then
    begin
     Result := MyStrToMoney(UpperCase(MyValue))
    end;
end;

//TMRMenu ============================
procedure TMRMenu.SetColors(Menu, MenuHighlight, MenuBack, BackGround,
                            SubMenu, SubMenuHighlight, PanelShortCuts,
                           PanelSystem, PanelHelp : TColor);
begin
      fMenuColor          := Menu;
      fMenuColorHighlight := MenuHighlight;
      fMenuBackColor      := MenuBack;
      fBackGroundColor    := BackGround;
      fSubMenuColor       := SubMenu;
      fSubMenuHighlight   := SubMenuHighlight;
      fPanelShorcuts      := PanelShortCuts;
      fPanelSystem        := PanelSystem;
      fPanelHelp          := PanelHelp;
end;

//TDM ============================
procedure TDM.CallReport(PW : String);
var
  fReportParam : String;
begin

  if (PW <> '') then
     fReportParam := 'PW='+PW+';';

  if FileExists(fSystem.LocalPath + MRREPORT_FILE) then
  try
    ExecuteFile(fSystem.LocalPath + MRREPORT_FILE, fReportParam, fSystem.LocalPath, SW_SHOWNORMAL);
    except
      MsgBox(MSG_INF_ERROR, vbOkOnly + vbCritical);
    end
  else if FileExists(fSystem.LocalPath + REPORT_FILE) then
  try
    ExecuteFile(fSystem.LocalPath + REPORT_FILE, fReportParam, fSystem.LocalPath, SW_SHOWNORMAL);
    except
      MsgBox(MSG_INF_ERROR, vbOkOnly + vbCritical);
    end
  else
    MsgBox(MSG_INF_ERROR, vbOkOnly + vbCritical);

end;

procedure TDM.CreatePredefinedStyleSheetsList;
var
  I: Integer;
begin
  fGridLayoutFileName := fSystem.LocalPath+'GridLayout.ini';

  if not FileExists(fGridLayoutFileName) then
     Exit;

  LoadStyleSheetsFromIniFile(fGridLayoutFileName,
                             strepPredefined,
                             TcxGridTableViewStyleSheet);
  with strepPredefined do
     begin
     fPredefinedStyle.Clear;
     for I := 0 to StyleSheetCount - 1 do
         fPredefinedStyle.AddObject(StyleSheets[I].Caption, StyleSheets[I]);
     end;
end;

function TDM.IsFormsRestric(fForm:String):Boolean;
begin
  Result := False;
  if fSystem.VersionType <> SYSTEM_STANDALONE_TYPE then
     Result := (Pos(UpperCase(fForm)+',',UpperCase(fRestricForms))<>0); //Estiver na lista
end;

procedure TDM.BuildRestricForms(fForms:String);
begin
  fRestricForms := fForms;
end;

function TDM.CanAccessMenu(IDMenu, IDSubMenu:Integer; PW:String):Boolean;
begin
   With quAccess do
     begin
     If Active then
        Close;
     Parameters.ParambyName('Password').Value    := PW;
     Parameters.ParambyName('MenuID').Value      := IDMenu;
     Parameters.ParambyName('SubMenuID').Value   := IDSubMenu;
     Open;
     Result := quAccessCanAccess.AsBoolean;
     Close;
     end;
end;

function TDM.CreateLocalRegistry:TRegistry;
var
  buildInfo: String;
begin
  Result := TRegistry.Create;

  if ( GetOS(buildInfo) = osW7 ) then
    result.RootKey := HKEY_CURRENT_USER
  else
    result.RootKey := HKEY_LOCAL_MACHINE;

  Result.OpenKey(REGISTRY_PATH, True);
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

   Case fPrintReceipt.PaperType of
     PAPER_TYPE_4A :
        begin
        TWindowsPrinter(MyLocalPrinter).PrintText(MyText);
        end;
     PAPER_TYPE_80COL:
        begin
        Case fPrintReceipt.PrinterType of
          PORT_LPT1,
          PORT_LPT2  : TLPTPrinter(MyLocalPrinter).PrintlnText(MyText);
          PORT_WIN   : TWindowsPrinter(MyLocalPrinter).PrintText(MyText);
        end;
        end;
   end;
end;

function TDM.SetupStore(quQuery: TADOQuery; sIDStore: String): boolean;
var
  sQueryName: String;
  sSQL: String;
  iIndex: integer;

begin
  try
    // Pego o nome da query e do owner
    with quQuery do
      sQueryName := Owner.Name + '.' + Name;

    iIndex := slOriginalSQL.IndexOf(sQueryName);

    if iIndex = -1 then
      begin
        // Primeira vez que é chamado.
        // Grava o original SQL no String List
        iIndex := slOriginalSQL.AddObject(sQueryName, quQuery.SQL);
      end;

    sSQL := TStringList(slOriginalSQL.Objects[iIndex]).Text;

    if sIDStore = '' then
      begin
        // Não foi especificada nenhuma loja. Pego todas que o usuário tem acesso.
        sIDStore := fStore.StoreList;
      end;

    quQuery.SQL.Text := StringReplace(sSQL, STORE_MARK, sIDStore, [rfReplaceAll]);

    Result := True;
  except
    Result := False;
  end;

end;

function TDM.GetContaCorrente(iIDMeioPag, iIDStore:Integer):Integer;
begin

   with quFreeSQL do
      begin
      if Active then
         Close;

      SQL.Clear;
      SQL.Add('SELECT MPS.IDContaCorrente');
      SQL.Add('FROM MeioPagToStore MPS');
      SQL.Add('JOIN MeioPag MP ON (MP.IDMeioPagBatch = MPS.IDMeioPag)');
      SQL.Add('WHERE MP.IDMeioPag = :IDMeioPag');
      SQL.Add('AND MPS.IDStore = :IDStore');

      Parameters.ParamByName('IDMeioPag').Value := iIDMeioPag;
      Parameters.ParamByName('IDStore').Value   := iIDStore;

      Open;

      Result := FieldByName('IDContaCorrente').AsInteger;

      Close;

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
  IsDesativado, ParentModel : Integer;
begin

   with quFreeSQL do
     begin

     if Active then
        Close;

     SQL.Clear;
     SQL.Add('SELECT M.Desativado, M.IDModelParent ');
     SQL.Add('FROM Model M  ');
     SQL.Add('WHERE M.IDModel = '+IntToStr(IDModel));

     Open;

     IsDesativado := FieldByName('Desativado').AsInteger;
     ParentModel  := FieldByName('IDModelParent').AsInteger;

     Close;

     if (IsDesativado = 1) and (MsgBox(MSQ_QST_DELETED_ITEM_RESTORE, vbYesNo + vbQuestion) = vbYes) then
        begin
        SQL.Clear;
        SQL.Add('UPDATE Model');
        SQL.Add('SET Desativado = 0');
        SQL.Add('WHERE IDModel = '+IntToStr(IDModel));
        ExecSQL;

        if ParentModel <> 0 then
        begin
          SQL.Clear;
          SQL.Add('UPDATE Model');
          SQL.Add('SET Desativado = 0');
          SQL.Add('WHERE IDModel = '+IntToStr(ParentModel));
          ExecSQL;
        end;

        MsgBox(MSG_INF_MODEL_RESTORED, vbOKOnly + vbInformation);
        Result := true;
        end
     else if IsDesativado = 1 then
        Result := False
     else
        Result := true;

     end;
end;


function TDM.GetActualPathName(strSQL, FieldName : String; IDItem : Integer) : String;
begin
    // Descobre o Path Name do no selecionado
    with quFreeSQL do
      begin
        try
        If Active then Close;
          SQL.Text := 'SELECT PathName FROM ' +
                      GetSQLFirstTableName(strSQL) +
                      ' WHERE ' + FieldName + ' = ' + IntToStr(IDItem);
          Open;
          Result := Trim(Fields[0].AsString);
          Close;
        except
          on exception do
             raise exception.create('You enter an invalid search.');
        end;
      end;
end;

function TDM.GetServerDate:TDateTime;
var
dServerDate : TDateTime;
begin
  with quFreeSQL do
    begin
      if Active then Close;
      SQL.Text := 'SELECT GetDate()';
      Open;
      dServerDate := Fields[0].AsDateTime;
      Close;
    end;

  if (fSystem.StartMode = SYS_MODULE_TRIAL) then
     Result := Now
  else
     //Retorno a hora original ao server
     //(60/60/24) --> Significa 1 hora em float
     Result := dServerDate + (fStore.StoreHour*(60/60/24));
end;

procedure TDM.SetClientToServerDate;
var
  ServerTime: TDateTime;
  ServerSysTime : TSystemTime;
begin
  with quFreeSQL do
    begin
      if Active then Close;
      SQL.Text := 'SELECT GetDate()';
      Open;
      ServerTime := Fields[0].AsDateTime;
      Close;
    end;

  if (fSystem.StartMode = SYS_MODULE_TRIAL) then
     ServerTime := Now
  else
     //(60/60/24) --> Significa 1 hora em float
     ServerTime := ServerTime + (fStore.StoreHour*(60/60/24));

  DateTimeToSystemTime(ServerTime, ServerSysTime);
  SetLocalTime(ServerSysTime);
end;

function TDM.GetIDUserComission(IDComission : integer) : integer;
begin
  with spGetIDUser do
    begin
      Parameters.ParambyName('@IDCOmission').Value := IDComission;
      ExecProc;
      Result := Parameters.ParambyName('@IDUser').Value
    end;
end;

function TDM.CheckCashRegState(IDDefaultReg : Integer;
    var IDCashRegMov : integer) : integer;
begin
  IDCashRegMov := 0;

  if not (fCashRegister.IDDefault > 0) then
    begin
      MessageBeep(MB_ICONASTERISK);
      MsgBox(MSG_EXC_NO_DEFAULT_CASREG, vbOkOnly + vbExclamation);
      Result := CASHREG_ERROR;
      Exit;
    end;

  if DescCodigo(['IDCashRegister'], [IntToStr(IDDefaultReg)],
                 'CashRegister', 'IDCashRegister') = '' then
    begin
     MessageBeep(MB_ICONASTERISK);
     MsgBox(MSG_EXC_NO_ASSOCIETE_CASREG, vbOkOnly + vbExclamation);
     Result := CASHREG_ERROR;
     Exit;
    end;

  with spCheckOpenCash do
    begin
      Parameters.ParambyName('@CashRegID').Value := IDDefaultReg;
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


function TDM.NewQuery:TADOQuery;
begin
  Result := TADOQuery.Create(self);
  Result.Connection := quFreeSQL.Connection;
end;

procedure TDM.OpenCashRegister(iType : Integer);
var
  iIDCash : Integer;
  sSQL : String;
begin

  if not fCashRegister.Open then
     Exit;

   //Testar com a gaveta
  if (fPrintReceipt.PaperType = PAPER_TYPE_80COL) and (fPrintReceipt.PrinterType = PORT_WIN) then
    SendCashCode(fCashRegister.OpenCod, True)
  else if (fPrintReceipt.PaperType = PAPER_TYPE_80COL) or
     ((fPrintReceipt.PaperType = PAPER_TYPE_4A) and (not fPrintReceipt.UseUSBPrinter)) then
    //SendCashCode(fCashRegister.OpenCod, False)
    SendCashCode(fCashRegister.OpenCod, True)
  else if (fPrintReceipt.PaperType = PAPER_TYPE_4A) and (fPrintReceipt.UseUSBPrinter) and (fPrintReceipt.USBOpenDraw <> '') then
    SendCashCode(fPrintReceipt.USBOpenDraw, True)
  else if (fPrintReceipt.PaperType = PAPER_TYPE_4A) and (fPrintReceipt.UseUSBPrinter) and (fPrintReceipt.USBOpenDraw = '') and (fCashRegister.OpenCod <> '') then
    SendCashCode(fCashRegister.OpenCod, True);

  //Insert Cash RegLog teste
  if iType = DRAW_KICK_TYPO_NO_SALE then
  begin
    iIDCash := GetNextID('Sal_DrawerKickLog.IDDrawerKickLog');
    sSQL := 'INSERT Sal_DrawerKickLog (IDDrawerKickLog, IDUser, IDCashRegister, MovDate, Type) ' +
            'VALUES ('+IntToStr(iIDCash)+','+IntToStr(fUser.ID)+','+ IntToStr(fCashRegister.IDDefault)+
            ', GetDate(),'+IntToStr(iType)+')';
    RunSQL(sSQL);
  end;

end;

procedure TDM.SendAfterPrintCode(StartPrinter:Boolean = False);
begin
  if fCashRegister.AfterPrintCode = '' then
    Exit;
  SendCashCode(fCashRegister.AfterPrintCode, StartPrinter);
end;


procedure TDM.SendPrinterCommands(aReportCanvas: TCanvas;
  aPrinterCommands: String);
type
  TppEscapeDataRec = packed record
    DataLen: Word;
    DataBuf: Array [0..128] of Char;
  end;

var
  lEscapeDataRec: TppEscapeDataRec;
  iError : Integer;
begin

  // setup the data
  lEscapeDataRec.DataLen := Length(aPrinterCommands);

  StrLCopy(lEscapeDataRec.DataBuf, PChar(aPrinterCommands), 128);

  // Windows API Escape call
  iError := Escape(aReportCanvas.Handle, PASSTHROUGH, 0, @lEscapeDataRec, nil);

  if iError < 0 then
    case iError of
     SP_ERROR : ShowMessage('General error.');
     SP_OUTOFDISK : ShowMessage('Not enough disk space is currently available for spooling, and no more space will become available.');
     SP_OUTOFMEMORY : ShowMessage('Not enough memory is available for spooling.');
     SP_USERABORT	: ShowMessage('The user terminated the job through Windows Print Manager.');
    end;


end;


procedure TDM.SendCashCode(ACode: String; NeedCloseOpenDoc: Boolean = True);
var
  SendCode : String;
  NotOk: Boolean;
begin

  SendCode := GetPrinterCode(ACode);

  WaitForm.Start(False);

  NotOk := True;

  Application.ProcessMessages;

  while NotOk do
    begin
      try
        if NeedCloseOpenDoc then
          PrinterStart;
        case fPrintReceipt.fPaperType of
          PAPER_TYPE_4A:
            TWindowsPrinter(MyLocalPrinter).SendCommand(SendCode);
          PAPER_TYPE_80COL:
                Case fPrintReceipt.PrinterType of
                  PORT_LPT1,
                  PORT_LPT2  : TLPTPrinter(MyLocalPrinter).PrintlnText(SendCode);
                  PORT_WIN   : TWindowsPrinter(MyLocalPrinter).SendCommand(SendCode);
                end;
        end;

        if NeedCloseOpenDoc then
          PrinterStop;
        NotOk := False;
      except
        if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
          NotOk := True
        else
          begin
            WaitForm.Hide;
            Exit;
          end;
      end;
    end;
  WaitForm.Hide;
end;

function TDM.GetPrinterCode(Code: String): String;
var
  SubCode : String;
  i : Integer;
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

function TDM.IsDBaseEmpty: boolean;
begin
  with quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text:= 'SELECT IDUser FROM SystemUser WHERE IDUser > 0';
    Open;
    Result:= IsEmpty;
    Close
  end;
end;

function TDM.DisplayLicenseForm:Boolean;
begin
  with TFrmLicenseKey.Create(Self) do
       Result := Start(DM.fSystem.ExpirationDate);
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  Cont, iMinOfUse,
  iLastParam, I : Integer;
  Continua      : Boolean;
  Year, Dummy   : Word;
  tmpDateFormat : String;
  sConnection   : String;
  bAbort,
  ExitConnection : Boolean;

  //Client StatUp Variables
  sResult : String;

  FrmServrInfo : TFrmServerInfo;
  buildInfo: String;
  startIntegration: boolean;
  puppyIntegration: TMRPuppyIntegration;
  IdMessage: Integer;
  fUserList: TStringList;
  sIDUSers: String;
  corporateView: TdlgSelectCorpView;
begin
  inherited;

  TFrmMsgConstant.Create(Self);
  DMGlobal.IDLanguage := LANG_ENGLISH;
  slOriginalSQL       := TStringList.Create;
  FHandleError        := THandleError.Create;
  FrmServrInfo        := TFrmServerInfo.Create(self);
  WaitForm            := TWaitForm.Create(Self);

  fStore           := TStore.Create;
  fUser            := TMRUser.Create;
  fCashRegister    := TCashRegister.Create;
  fSystem          := TMRSystem.Create;
  fMainMenu        := TMRMenu.Create;
  fPrintReceipt    := TMRPrintReceipt.Create;
  fGrid            := TMRGrid.Create;
  fInvoice         := TMRInvoice.Create;
  fPinPad          := TMRPinPad.Create;
  fPCCharge        := TMRPCCharge.Create;
  fMRMercury       := TMRMercury.Create;
  fMRGynbo         := TMRGynbo.Create;

  fPollDisplay     := TPollDisplay.Create;
  fPetCenter       := TPetCenter.Create;
  fPOS             := TFrmPOSFunctions.Create(Self);
  fPredefinedStyle := TStringList.Create;
  FMainRetailConfig := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  FDMInventory      := TDMInventory.Create(Self);

  Application.OnException := AppException;

  fStartOption := -1;

  debugtofile('number of parameters in command line ' + intToStr(paramCount));

  for i:= 0 to paramCount -1 do begin
      debugToFile('parameter['+intToStr(i)+'] = ' + paramStr(i));
  end;

  //Antonio M F Souza 10.24.2011 -
  //At this point, I verify if MainRetail was called by windows service.
  startIntegration := ( ParamStr(1) = '--import_PT' );

  if ParamCount <> 0 then begin
     if ParamStr(1) = (PARAM_START_LAYAWAY) then
        fStartOption := START_LAYAWAY
     else if ParamStr(1) = PARAM_START_INVENT_ADJST then
        fStartOption := START_INVENT_TYPE
  end;

  //Extract EXE local path
  fSystem.LocalPath := ExtractFilePath(Application.ExeName);

  CreatePredefinedStyleSheetsList;

  //SYS_MODULE_TRIAL - Demo, 1,2,3,4 - Modules
  fSystem.StartMode := SYS_MODULE_3;

  sResult := FrmServrInfo.Start(fSystem.StartMode, False, '', bAbort);

  ExitConnection := bAbort;

  While not ExitConnection do
     try
      //VBNET DEMO ACCESS ONLY
      { fSQLConnectParam.Server  := '192.168.100.100';
       fSQLConnectParam.DBAlias := 'ApresentationDB';
       fSQLConnectParam.User    := 'checkcustomer';
       fSQLConnectParam.PW      := '7740';

       with TRegistry.Create do
       begin
          RootKey := HKEY_LOCAL_MACHINE;
          OpenKey('SOFTWARE\Applenet\CurrentVersions', True);
          if not ValueExists('TrialCount') then
            WriteString('TrialCount', EncodeServerInfo('0', 'Count', CIPHER_TEXT_STEALING, FMT_UU));
          Free;
       end;
      }

       fSQLConnectParam.Server    := ParseParam(sResult, SV_SERVER);
       fSQLConnectParam.DBAlias   := ParseParam(sResult, SV_DATABASE);
       fSQLConnectParam.UserName  := ParseParam(sResult, SV_USER);
       fSQLConnectParam.PW        := ParseParam(sResult, SV_PASSWORD);
       fSQLConnectParam.WinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
       fSQLConnectParam.UseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');
       fSQLConnectParam.Status    := SQL_STATUS_NO_CONNECTED;

        if not fSQLConnectParam.WinLogin then
           if fSQLConnectParam.UseNetLib then
              sResult := SetConnectionStr(fSQLConnectParam.UserName,
                                          fSQLConnectParam.PW,
                                          fSQLConnectParam.DBAlias,
                                          fSQLConnectParam.Server)
           else
              sResult := SetConnectionStrNoNETLIB(fSQLConnectParam.UserName,
                                                  fSQLConnectParam.PW,
                                                  fSQLConnectParam.DBAlias,
                                                  fSQLConnectParam.Server)
        else
           if fSQLConnectParam.UseNetLib then
              sResult := SetWinConnectionStr(fSQLConnectParam.DBAlias,
                                             fSQLConnectParam.Server)
           else
              sResult := SetWinConnectionStrNoNETLIB(fSQLConnectParam.DBAlias,
                                                     fSQLConnectParam.Server);

        ADOConnectionString := sResult;
//Antonio M F Souza May 15, 2012        debugtofile('connection after schedule = ' + sResult);


        ADOConnectionOpen;
 //under test
  if ( startIntegration ) then begin
     try
         try
//Antonio M F Souza May 15, 2012   debugtofile('connection before = '+ ADODBConnect.ConnectionString);

           debugToFile('Start Integration');
           puppyIntegration := TMRPuppyIntegration.Create(dm.ADODBConnect);
           puppyIntegration.StoreId := dm.fStore.fID;
           debugtoFile('Store to Integration = ' + intToStr(dm.fStore.fID));
           debugtoFile('PuppyIntegration object created');

           puppyIntegration.RunNow;

           debugtofile('RunNow method was called');

           //message to user
           IDMessage := DM.GetNextID('Sis_Message.IDMessage');

           DM.RunSQL('INSERT INTO Sis_Message (IDMessage, CreationDate, Subject, Body, IDUserSender) ' +
                    ' VALUES (' + IntToStr(IDMessage) + ', GetDate(), ' + QuotedStr('PuppySchedule') +
                    ', ' + QuotedStr('There are new puppies imported') + ', '+IntToStr(DM.fUser.ID)+')');
           debugtofile('Sis_Message was inserted');

           fUserList := TStringList.Create;
           fUserList.CommaText := sIDUsers;

           for i := 0 to fUserList.Count-1 do begin
              DM.RunSQL('INSERT INTO Sis_MessageUser (IDMessage, IDUserReceiver) ' +
                        'VALUES (' + IntToStr(IDMessage) + ', '+fUserList.Strings[i]+')');
           end;

           debugtofile('Sis_MessageUser was inserted');

         except
            // Antonio M F Souza 11.04.2011 - deal quietly behind the scenes.
            DM.ADODBConnect.Connected := false;
            debugtofile('database disconected due exception');
         end;

     finally
         DMParent.ADODBConnect.Connected := false;
         DM.ADODBConnect.Connected := false;
         freeAndNil(puppyIntegration);
         debugtoFile('database disconected');
         debugtoFile('PuppyIntegration was destroyed');

         FreeAndNil(fUserList);

         debugtoFile('Call Application.Terminate method to ' + Application.ExeName);
         Application.Terminate;
         debugtoFile('Application.Terminate was called to ' + Application.ExeName);
     end;
  end;

// under test
        ExitConnection := True;
      except
        on E: Exception do
          begin
          sResult := FrmServrInfo.Start(fSystem.StartMode, True, E.Message, bAbort);
          ExitConnection := bAbort;
          end;
       end;

  if bAbort then
     begin
     fSystem.StartMode := SYS_ERROR;
     Application.Terminate;
     end;

  try

     if not ModuleStart then
     begin
       MsgBox(MSG_CRT_NO_MODEL_INFORMTION, vbCritical + vbOKOnly);
       Abort;
     end;

     fSQLConnectParam.Status     := SQL_STATUS_CONNECTED;
     fSQLConnectParam.Time       := DateTimeToStr(Now);
     fSQLConnectParam.ConType    := fSystem.VersionType;
     fSQLConnectParam.Expiration := FormatDateTime('ddddd', fSystem.ExpirationDate);

     //validate license key
     if ((fSystem.StartMode <> SYS_MODULE_TRIAL) and (not fSystem.ValidLicense))
        or ((fSystem.StartMode <> SYS_MODULE_TRIAL) and (DM.fSystem.ExpirationDate < DM.fSystem.SystemDate)) then
           if not DisplayLicenseForm then
              begin
              MsgBox(MSG_CRT_ERROR_INVALID_KEY, vbCritical + vbOKOnly);
              Abort;
              end;

     if IsDBaseEmpty then
     begin
       // Launching Wizard for the 1st time
       if WinExec(pchar(fSystem.LocalPath +'Wizard.exe'), SW_NORMAL) > 31 then
       begin
         Abort;
         with TRegistry.Create do
         begin
           if ( getOS(buildInfo) = osW7 ) then
              RootKey:= HKEY_CURRENT_USER
           else
              RootKey:= HKEY_LOCAL_MACHINE;

           OpenKey('SOFTWARE\Applenet\CurrentVersions', True);

           if not ValueExists('TrialCount') then
             WriteString('TrialCount', EncodeServerInfo('0', 'Count', CIPHER_TEXT_STEALING, FMT_UU));

           Free;
         end;
       end
       else
       begin
         MsgBox(MSG_CRT_NO_VALID_WIZARD, vbCritical + vbOKOnly);
         Abort;
       end;
     end;

     FrmServrInfo.Free;

     Continua := True;
  except
     Continua := False;
     //raise exception.create('Unabled to connect the server.');
     if not ADODBConnect.Connected then
        begin
        if fSystem.StartMode in [SYS_MODULE_TRIAL, SYS_MODULE_2] then //Se for no server
          begin
          if WinExec(pchar(fSystem.LocalPath +'Errors.exe'), SW_NORMAL) < 31 then
             MsgBox(MSG_CRT_NO_CONNECT_SERVER, vbOKOnly + vbInformation);
          end
        else
          begin
          MsgBox(MSG_CRT_NO_PARAM_SERVER, vbOKOnly + vbInformation);
          //MsgBox(MSG_CRT_NO_VPN_SERVER, vbOKOnly + vbInformation);

          //Inicio o frm de Srvr Information - como error
          FrmServrInfo.Start(fSystem.StartMode, True, '', bAbort);
          FrmServrInfo.Free;
          fSQLConnectParam.Status := SQL_STATUS_ERROR;
          end;
        end;
     fSystem.StartMode := SYS_ERROR;
     Application.Terminate;
     raise;
   end;

   if (fSystem.StartMode = SYS_MODULE_TRIAL) and Continua then
   begin
      with TRegistry.Create do
      begin
        try
           if ( getOS(buildInfo) = osW7 ) then
              RootKey:= HKEY_CURRENT_USER
           else
              RootKey:= HKEY_LOCAL_MACHINE;

          OpenKey('SOFTWARE\Applenet\CurrentVersions', True);
          if not ValueExists('TrialCount') then
          begin
            MsgBox(MSG_CRT_NO_VALID_TRIAL_INFO, vbOKOnly + vbCritical);
            Application.Terminate;
          end;

          iMinOfUse:= StrToInt(DecodeServerInfo(ReadString('TrialCount'), 'Count', CIPHER_TEXT_STEALING, FMT_UU));
          if iMinOfUse > TRIAL_LIMIT then
          begin
            MsgBox(MSG_INF_ACCOUNT_EXPIRED, vbOKOnly + vbInformation);
            Application.Terminate;
          end
          else
            MsgBox(MSG_INF_PART1_USE_MR+ IntToStr(TRIAL_LIMIT - iMinOfUse) + MSG_INF_PART2_USE_MR,
                                vbOKOnly + vbInformation);

          CloseKey;
        finally
          Free;
        end;
      end;
   end;

   // Seta o decimalseparator
   fSystem.WinDateFormat := ShortDateFormat;
   DecimalSeparator := '.';
   ShortDateFormat  := 'mm' + DateSeparator + 'dd' + DateSeparator + 'yy';

   // Seta se mostra data com 4 digitos, quando passa do ano 2000
   DecodeDate(Date, Year, Dummy, Dummy);
   if Year >= 2000 then
     begin
      tmpDateFormat := UpperCase(ShortDateFormat);
      if(pos('YYYY', tmpDateFormat) = 0) and (pos('YY', tmpDateFormat) <> 0) then
        insert('YY', tmpDateFormat, pos('YY', tmpDateFormat));
      ShortDateFormat := tmpDateFormat;
     end;

   //Pega as informacoes do SQL Server
   GetSQLServerInfo;

 // Abre o registry
  with TRegistry.Create do
     begin
       if ( getOS(buildInfo) = osW7 ) then
          RootKey:= HKEY_CURRENT_USER
       else
          RootKey:= HKEY_LOCAL_MACHINE;

       OpenKey(REGISTRY_PATH, True);

       if not ValueExists('DefaultCashRegID') then
          WriteInteger('DefaultCashRegID', 0);
       if not ValueExists('IDShippingReg') then
          WriteInteger('IDShippingReg', 0);
       if not ValueExists('ShippingPackingRep') then
          WriteString('ShippingPackingRep', '[SYSTEM]');
       if not ValueExists('ShippingPickRep') then
          WriteString('ShippingPickRep', '[SYSTEM]');
       if not ValueExists('DefaultStoreID') then
          WriteInteger('DefaultStoreID', 1);
       if not ValueExists('DefaultSaleStoreID') then
          WriteInteger('DefaultSaleStoreID', -1);
       if not ValueExists('PurchaseDefaultStoreID') then
          WriteInteger('PurchaseDefaultStoreID', -1);
       if not ValueExists('DefaultMediaID') then
          WriteInteger('DefaultMediaID', 7);
       if not ValueExists('XPressSaleType') then
          WriteInteger('XPressSaleType', 0);
       if not ValueExists('CashRegOpenCodeStr') then
          WriteString('CashRegOpenCodeStr', '7');
       if not ValueExists('CashRegAfterPrintStr') then
          WriteString('CashRegAfterPrintStr', '');
       if not ValueExists('CashRegViewOthers') then
          WriteBool('CashRegViewOthers', False);
       if not ValueExists('CashRegViewOthersStores') then
          WriteBool('CashRegViewOthersStores', False);
       if not ValueExists('ShutDownOnExit') then
          WriteBool('ShutDownOnExit', False);
       if not ValueExists('PrintReceipt') then
          WriteBool('PrintReceipt', False);
       if not ValueExists('OpenCashReg') then
          WriteBool('OpenCashReg', False);
       if not ValueExists('DefaultLanguage') then
          WriteInteger('DefaultLanguage', LANG_ENGLISH);
       if not ValueExists('LangPath') then
          WriteString('LangPath', fSystem.LocalPath + LANG_DIRECTORY);
       if not ValueExists('DefaultDecimalSeparator') then
          WriteString('DefaultDecimalSeparator', '.');
       if not ValueExists('DefaultThousandSeparator') then
          WriteString('DefaultThousandSeparator', ',');
       if not ValueExists('DefaultDateFormat') then
          WriteString('DefaultDateFormat', 'mm/dd/yyyy');
       if not ValueExists('ShowTip') then
          WriteBool('ShowTip', True);
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
       if not ValueExists('PaperType') then
          WriteInteger('PaperType', PAPER_TYPE_80COL);
       if not ValueExists('PreviewA4') then
          WriteBool('PreviewA4', True);
       if not ValueExists('NumCopiesA4') then
          WriteInteger('NumCopiesA4', 1);
       if not ValueExists('ReportPathA4') then
          WriteString('ReportPathA4', '[SYSTEM]');
       if not ValueExists('ReportPathA4Footer') then
          WriteString('ReportPathA4Footer', '');
       if not ValueExists('InvoiceReportPrinter') then
          WriteString('InvoiceReportPrinter', '');
       if not ValueExists('UseUSBPrinter') then
          WriteBool('UseUSBPrinter', False);
       if not ValueExists('USBOpenDraw') then
          WriteString('USBOpenDraw', '');
       if not ValueExists('USBCutPaper') then
          WriteString('USBCutPaper', '');
       if not ValueExists('TransferReportPathA4') then
          WriteString('TransferReportPathA4', '[SYSTEM]');
       if not ValueExists('TransferReportPreview') then
          WriteBool('TransferReportPreview', True);
       if not ValueExists('TransferSuggestPrint') then
          WriteBool('TransferSuggestPrint', True);
       if not ValueExists('TransferReportNumCopy') then
          WriteInteger('TransferReportNumCopy', 1);
       if not ValueExists('TransferReportPrinter') then
          WriteString('TransferReportPrinter', '');
       if not ValueExists('POReportPathA4') then
          WriteString('POReportPathA4', '[SYSTEM]');
       if not ValueExists('POReportPreview') then
          WriteBool('POReportPreview', True);
       if not ValueExists('POReportNumCopy') then
          WriteInteger('POReportNumCopy', 1);
       if not ValueExists('POReportPrinter') then
          WriteString('POReportPrinter', '');
       if not ValueExists('POEmailFile') then
          WriteInteger('POEmailFile', 1);
       if not ValueExists('RepairReportPathA4') then
          WriteString('RepairReportPathA4', '[SYSTEM]');
       if not ValueExists('RepairReportPreview') then
          WriteBool('RepairReportPreview', True);
       if not ValueExists('RepairReportNumCopy') then
          WriteInteger('RepairReportNumCopy', 1);
       if not ValueExists('RepairReportPrinter') then
          WriteString('RepairReportPrinter', '');
       if not ValueExists('ServiceReportPathA4') then
          WriteString('ServiceReportPathA4', '[SYSTEM]');
       if not ValueExists('StoreAccReportPathA4') then
          WriteString('StoreAccReportPathA4', '[SYSTEM]');

       if ( not ValueExists('StoreAccReportFooterPath') ) then begin
           writeString('StoreAccReportFooterPath', '[SYSTEM]');
       end;

       if not ValueExists('ServiceReportPreview') then
          WriteBool('ServiceReportPreview', True);
       if not ValueExists('StoreAccReportPreview') then
          WriteBool('StoreAccReportPreview', True);
       if not ValueExists('ServiceReportNumCopy') then
          WriteInteger('ServiceReportNumCopy', 1);
       if not ValueExists('StoreAccReportNumCopy') then
          WriteInteger('StoreAccReportNumCopy', 2);
       if not ValueExists('ServiceReportPrinter') then
          WriteString('ServiceReportPrinter', '');
       if not ValueExists('ServiceDefaulCateg') then
          WriteString('ServiceDefaulCateg', '');
       if not ValueExists('StoreAccReportPrinter') then
          WriteString('StoreAccReportPrinter', '');
       if not ValueExists('PrintItemsPerPage') then
          WriteInteger('PrintItemsPerPage', 0);
       if not ValueExists('ReceivingReportPathA4') then
          WriteString('ReceivingReportPathA4', '[SYSTEM]');
       if not ValueExists('ReceivingReportPreview') then
          WriteBool('ReceivingReportPreview', True);
       if not ValueExists('ReceivingReportNumCopy') then
          WriteInteger('ReceivingReportNumCopy', 1);
       if not ValueExists('ReceivingReportPrinter') then
          WriteString('ReceivingReportPrinter', '');
       if not ValueExists('BudgetReportPathA4') then
          WriteString('BudgetReportPathA4', '[SYSTEM]');
       if not ValueExists('BudgetReportPreview') then
          WriteBool('BudgetReportPreview', True);
       if not ValueExists('BudgetReportNumCopy') then
          WriteInteger('BudgetReportNumCopy', 1);
       if not ValueExists('BudgetReportPrinter') then
          WriteString('BudgetReportPrinter', '');
       if not ValueExists('DeliveryReportPathA4') then
          WriteString('DeliveryReportPathA4', '[SYSTEM]');
       if not ValueExists('DeliveryReportPreview') then
          WriteBool('DeliveryReportPreview', True);
       if not ValueExists('DeliveryReportNumCopy') then
          WriteInteger('DeliveryReportNumCopy', 1);
       if not ValueExists('DeliveryReportPrinter') then
          WriteString('DeliveryReportPrinter', '');
       if not ValueExists('CommissionReportPathA4') then
          WriteString('CommissionReportPathA4', '[SYSTEM]');
       if not ValueExists('CommissionReportPreview') then
          WriteBool('CommissionReportPreview', True);
       if not ValueExists('CommissionReportNumCopy') then
          WriteInteger('CommissionReportNumCopy', 1);
       if not ValueExists('CommissionReportPrinter') then
          WriteString('CommissionReportPrinter', '');
       if not ValueExists('AskSalesPerson') then
          WriteBool('AskSalesPerson', False);


       if not ValueExists('MenuHighlightColor') then
          WriteString('MenuHighlightColor', ColorToString(clWhite));
       if not ValueExists('MenuHighlightTextColor') then
          WriteString('MenuHighlightTextColor', ColorToString(clBlack));
       if not ValueExists('MenuBackgroundColor') then
          WriteString('MenuBackgroundColor', ColorToString($00B78900));
       if not ValueExists('BackgroundColor') then
          WriteString('BackgroundColor', ColorToString(clWhite));
       if not ValueExists('SubMenuTextColor') then
          WriteString('SubMenuTextColor', ColorToString($00B78900));
       if not ValueExists('SubMenuHighlightColor') then
          WriteString('SubMenuHighlightColor', ColorToString($000080FF));
       if not ValueExists('PanelShortcutsColor') then
          WriteString('PanelShortcutsColor', ColorToString(clTeal));
       if not ValueExists('PanelSystemColor') then
          WriteString('PanelSystemColor', ColorToString($008080FF));
       if not ValueExists('PanelHelpColor') then
          WriteString('PanelHelpColor', ColorToString($00C08000));
       if not ValueExists('MRWindowMode') then
          WriteBool('MRWindowMode', False);
       if not ValueExists('CompanyLogo') then
           WriteString('CompanyLogo', fSystem.LocalPath+'logo.JPG');
       if not ValueExists('GridLayout') then
          WriteInteger('GridLayout', 22);
       if not ValueExists('GridKind') then
          WriteInteger('GridKind', 1);
       if not ValueExists('DisplayBudget') then
          WriteBool('DisplayBudget', True);
       if not ValueExists('DisplayHold') then
          WriteBool('DisplayHold', True);
       if not ValueExists('DisplaySearch') then
          WriteBool('DisplaySearch', True);
       if not ValueExists('DisplayCloseDay') then
          WriteBool('DisplayCloseDay', True);
       if not ValueExists('DisplayFinalize') then
          WriteBool('DisplayFinalize', True);
       if not ValueExists('DisplayPOSHold') then
          WriteBool('DisplayPOSHold', False);
       if not ValueExists('PCChargePath') then
          WriteString('PCChargePath', '');
       if not ValueExists('PCChargeUser') then
          WriteString('PCChargeUser', '');
       if not ValueExists('PCChargeServer') then
          WriteString('PCChargeServer', '');
       if not ValueExists('PCChargeTimeOut') then
          WriteInteger('PCChargeTimeOut', 75);
       if not ValueExists('PCChargeLastDate') then
          WriteInteger('PCChargeLastDate', 12);
       if not ValueExists('PCChargePrintNum') then
          WriteInteger('PCChargePrintNum', 2);
       if not ValueExists('PCChargePort') then
          WriteInteger('PCChargePort', 0);
       if not ValueExists('ProcessorType') then
          WriteInteger('ProcessorType', 0);
       if not ValueExists('PCChargeMultTrans') then
          WriteBool('PCChargeMultTrans', False);
       if not ValueExists('MercuryIPs') then
          WriteString('MercuryIPs', '');
       if not ValueExists('MercuryIPPort') then
          WriteInteger('MercuryIPPort', 0);
       if not ValueExists('MercuryMerchatID') then
          WriteString('MercuryMerchatID', '');
       if not ValueExists('MercuryDialUpBridge') then
          WriteBool('MercuryDialUpBridge', True);
       if not ValueExists('MercuryConnectTimeout') then
          WriteInteger('MercuryConnectTimeout', 30);
       if not ValueExists('MercuryResponseTimeout') then
          WriteInteger('MercuryResponseTimeout', 300);
       if not ValueExists('GynboStoreNum') then
          WriteInteger('GynboStoreNum', 0);
       if not ValueExists('GynboUrl') then
          WriteString('GynboUrl', '');
       if not ValueExists('GynboTerminal') then
          WriteString('GynboTerminal', '');
       if not ValueExists('GynboPartnerKey') then
          WriteString('GynboPartnerKey', '');
       if not ValueExists('GynboUrlPW') then
          WriteString('GynboUrlPW', '');
       if not ValueExists('GynboUrlUser') then
          WriteString('GynboUrlUser', '');
       if not ValueExists('PartnerAcc') then
          WriteString('PartnerAcc', '');
       if not ValueExists('PinPadDevice') then
          WriteString('PinPadDevice', 'Verifone');
       if not ValueExists('PinPadBaud') then
          WriteString('PinPadBaud', '1200');
       if not ValueExists('PinPadParity') then
          WriteString('PinPadParity', 'E');
       if not ValueExists('PinPadDataBits') then
          WriteString('PinPadDataBits', '7');
       if not ValueExists('PinPadComm') then
          WriteString('PinPadComm', '1');
       if not ValueExists('PinEncryptMethod') then
          WriteString('PinEncryptMethod', '1');
       if not ValueExists('PinTimeOut') then
          WriteString('PinTimeOut', '4');
       if not ValueExists('PollDisplayIP') then
          WriteString('PollDisplayIP', '');
       if not ValueExists('PollDisplayPort') then
          WriteInteger('PollDisplayPort', 9091);
       if not ValueExists('PollDisplayClearSale') then
          WriteBool('PollDisplayClearSale', True);
       if not ValueExists('PetCenterIP') then
          WriteString('PetCenterIP', '');
       if not ValueExists('PetCenterPort') then
          WriteInteger('PetCenterPort', 1555);
       if not ValueExists('ScaleType') then
          WriteInteger('ScaleType', -1);
       if not ValueExists('ScaleCheck') then
          WriteBool('ScaleCheck', False);

       //Parametro que será utilizado para validação ou não da versão do executável.
       if not ValueExists('MRBuildValidate') then
          WriteBool('MRBuildValidate', True);

       if ( not ValueExists('ProcessType') ) then begin
       	  WriteInteger('ProcessType', -1);
       end;

       fCashRegister.IDDefault                := ReadInteger('DefaultCashRegID');
       fCashRegister.IDShippingReg            := ReadInteger('IDShippingReg');
       fCashRegister.ShippingPackingRep       := ReadString('ShippingPackingRep');
       fCashRegister.ShippingPickRep          := ReadString('ShippingPickRep');
       fCashRegister.ViewOthers               := ReadBool('CashRegViewOthers');
       fCashRegister.ViewOthersStores         := ReadBool('CashRegViewOthersStores');
       fStore.IDDefault                       := ReadInteger('DefaultStoreID');
       fStore.IDStoreSale                     := ReadInteger('DefaultSaleStoreID');
       fStore.IDStorePur                      := ReadInteger('PurchaseDefaultStoreID');
       fCashRegister.IDMedia                  := ReadInteger('DefaultMediaID');
       fInvoice.XpressSaleType                := ReadInteger('XPressSaleType');
       fInvoice.XpressSaleImage               := ReadString('XpressSaleImage');
       fInvoice.OBSText                       := ReadString('InvObsText');
       fInvoice.DisplayBudget                 := ReadBool('DisplayBudget');
       fInvoice.DisplayHold                   := ReadBool('DisplayHold');
       fInvoice.DisplaySearch                 := ReadBool('DisplaySearch');
       fInvoice.DisplayCloseDay               := ReadBool('DisplayCloseDay');
       fInvoice.DisplayFinalize               := ReadBool('DisplayFinalize');
       fInvoice.DisplayPOSHold                := ReadBool('DisplayPOSHold');
       fStore.ID                              := fStore.IDDefault;
       fCashRegister.OpenCod                  := ReadString('CashRegOpenCodeStr');
       fCashRegister.AfterPrintCode           := ReadString('CashRegAfterPrintStr');
       fCashRegister.AskSalesPerson           := ReadBool('AskSalesPerson');
       fSystem.ShutDownOnExit                 := ReadBool('ShutDownOnExit');
       fPrintReceipt.PrintReceipt             := ReadBool('PrintReceipt');
       fCashRegister.Open                     := ReadBool('OpenCashReg');
       DMGlobal.IDLanguage                    := ReadInteger('DefaultLanguage');
       DMGlobal.LangFilesPath                 := ReadString('LangPath');
       DecimalSeparator                       := ReadString('DefaultDecimalSeparator')[1];
       ThousandSeparator                      := ReadString('DefaultThousandSeparator')[1];
       ShortDateFormat                        := ReadString('DefaultDateFormat');
       fSystem.ShowTip                        := ReadBool('ShowTip');
       fPrintReceipt.PrinterType              := ReadInteger('PrinterType');
       fPrintReceipt.PrinterPort              := ReadString('PrinterPort');
       fPrintReceipt.PrinterFontName          := ReadString('PrinterFontName');
       fPrintReceipt.PrinterFontSize          := ReadInteger('PrinterFontSize');
       fPrintReceipt.PrinterLineSpace         := ReadInteger('PrinterLineSpace');
       fPrintReceipt.PrinterLineWidth         := ReadInteger('PrinterLineWidth');
       fPrintReceipt.PaperType                := ReadInteger('PaperType');
       fPrintReceipt.Preview                  := ReadBool('PreviewA4');
       fPrintReceipt.NumOfCopies              := ReadInteger('NumCopiesA4');
       fPrintReceipt.ReportPath               := ReadString('ReportPathA4');
       fPrintReceipt.ReportPathFooter         := ReadString('ReportPathA4Footer');
       fPrintReceipt.InvoiceReportPrinter     := ReadString('InvoiceReportPrinter');
       fPrintReceipt.UseUSBPrinter            := ReadBool('UseUSBPrinter');
       fPrintReceipt.USBOpenDraw              := ReadString('USBOpenDraw');
       fPrintReceipt.USBCutCode               := ReadString('USBCutPaper');
       fPrintReceipt.DeliveryReportPath      := ReadString('DeliveryReportPathA4');
       fPrintReceipt.DeliveryReportPreview   := ReadBool('DeliveryReportPreview');
       fPrintReceipt.DeliveryReportNumCopy   := ReadInteger('DeliveryReportNumCopy');
       fPrintReceipt.DeliveryReportPrinter   := ReadString('DeliveryReportPrinter');
       fPrintReceipt.BudgetReportPath        := ReadString('BudgetReportPathA4');
       fPrintReceipt.BudgetReportPreview     := ReadBool('BudgetReportPreview');
       fPrintReceipt.BudgetReportNumCopy     := ReadInteger('BudgetReportNumCopy');
       fPrintReceipt.BudgetReportPrinter     := ReadString('BudgetReportPrinter');
       fPrintReceipt.TransferReportPath      := ReadString('TransferReportPathA4');
       fPrintReceipt.TransferReportPreview   := ReadBool('TransferReportPreview');
       fPrintReceipt.TransferSuggestPrint    := ReadBool('TransferSuggestPrint');
       fPrintReceipt.TransferReportNumCopy   := ReadInteger('TransferReportNumCopy');
       fPrintReceipt.TransferReportPrinter   := ReadString('TransferReportPrinter');
       fPrintReceipt.POReportPath            := ReadString('POReportPathA4');
       fPrintReceipt.POReportPreview         := ReadBool('POReportPreview');
       fPrintReceipt.POReportNumCopy         := ReadInteger('POReportNumCopy');
       fPrintReceipt.POReportPrinter         := ReadString('POReportPrinter');
       fPrintReceipt.POEmailFile             := ReadInteger('POEmailFile');
       fPrintReceipt.RepairReportPath        := ReadString('RepairReportPathA4');
       fPrintReceipt.RepairReportPreview     := ReadBool('RepairReportPreview');
       fPrintReceipt.RepairReportNumCopy     := ReadInteger('RepairReportNumCopy');
       fPrintReceipt.RepairReportPrinter     := ReadString('RepairReportPrinter');
       fPrintReceipt.ServiceReportPath       := ReadString('ServiceReportPathA4');
       fPrintReceipt.StoreAccReportPath      := ReadString('StoreAccReportPathA4');
       fPrintReceipt.StoreAccFooterPath      := ReadString('StoreAccReportFooterPath');
       fPrintReceipt.ServiceReportPreview    := ReadBool('ServiceReportPreview');
       fPrintReceipt.StoreAccReportPreview   := ReadBool('StoreAccReportPreview');
       fPrintReceipt.ServiceReportNumCopy    := ReadInteger('ServiceReportNumCopy');
       fPrintReceipt.StoreAccReportNumCopy   := ReadInteger('StoreAccReportNumCopy');
       fPrintReceipt.ServiceReportPrinter    := ReadString('ServiceReportPrinter');
       fCashRegister.DefaulServOrderCat      := ReadString('ServiceDefaulCateg');
       fPrintReceipt.StoreAccReportPrinter   := ReadString('StoreAccReportPrinter');
       fPrintReceipt.PrintItemsPerPage       := ReadInteger('PrintItemsPerPage');
       fPrintReceipt.ReceivingReportPath     := ReadString('ReceivingReportPathA4');
       fPrintReceipt.ReceivingReportPreview  := ReadBool('ReceivingReportPreview');
       fPrintReceipt.ReceivingReportNumCopy  := ReadInteger('ReceivingReportNumCopy');
       fPrintReceipt.ReceivingReportPrinter  := ReadString('ReceivingReportPrinter');
       fPrintReceipt.CommissionReportPath    := ReadString('CommissionReportPathA4');
       fPrintReceipt.CommissionReportPreview := ReadBool('CommissionReportPreview');
       fPrintReceipt.CommissionReportNumCopy := ReadInteger('CommissionReportNumCopy');
       fPrintReceipt.CommissionReportPrinter := ReadString('CommissionReportPrinter');
       fMainMenu.MenuColor                   := StringToColor(ReadString('MenuHighlightColor'));
       fMainMenu.MenuColorHighlight          := StringToColor(ReadString('MenuHighlightTextColor'));
       fMainMenu.MenuBackColor               := StringToColor(ReadString('MenuBackgroundColor'));
       fMainMenu.BackGroundColor             := StringToColor(ReadString('BackgroundColor'));
       fMainMenu.SubMenuColor                := StringToColor(ReadString('SubMenuTextColor'));
       fMainMenu.SubMenuHighlight            := StringToColor(ReadString('SubMenuHighlightColor'));
       fMainMenu.PanelShorcuts               := StringToColor(ReadString('PanelShortcutsColor'));
       fMainMenu.PanelSystem                 := StringToColor(ReadString('PanelSystemColor'));
       fMainMenu.PanelHelp                   := StringToColor(ReadString('PanelHelpColor'));
       fMainMenu.WindowMode                  := ReadBool('MRWindowMode');
       fMainMenu.Logo                        := ReadString('CompanyLogo');
       fGrid.Layout                          := ReadInteger('GridLayout');
       fGrid.Kind                            := ReadInteger('GridKind');
       //PCCharge
       fPCCharge.TimeOut                    := ReadInteger('PCChargeTimeOut');
       fPCCharge.PrintNum                   := ReadInteger('PCChargePrintNum');
       fPCCharge.Port                       := ReadInteger('PCChargePort');
       fPCCharge.LastDate                   := ReadInteger('PCChargeLastDate');
       fPCCharge.Server                     := ReadString('PCChargeServer');
       fPCCharge.User                       := ReadString('PCChargeUser');
       fPCCharge.Path                       := ReadString('PCChargePath');
       fPCCharge.MultTrans                  := ReadBool('PCChargeMultTrans');
       fPCCharge.ProcessorType              := ReadInteger('ProcessorType');
       fPCCharge.DeviceProcess := readInteger('ProcessType');


       //Mercury
       fMRMercury.IpAddress                 := ReadString('MercuryIPs');
       fMRMercury.IpPort                    := ReadInteger('MercuryIPPort');
       fMRMercury.MerchantID                := ReadString('MercuryMerchatID');
       fMRMercury.DialUpBridge              := ReadBool('MercuryDialUpBridge');
       fMRMercury.ConnectTimeout            := ReadInteger('MercuryConnectTimeout');
       fMRMercury.ResponseTimeout           := ReadInteger('MercuryResponseTimeout');
       fMRMercury.DeviceProcess := readInteger('ProcessType');
       fMRMercury.Processor := readInteger('ProcessorType');

       //Antonio M F Souza 02.09.2012
       try
          fMRMercury.GiftIP                    := readString('MercuryGiftIPs');
       except
          fMRMercury.GiftIP                    := '';
       end;

       try
          fMRMercury.GiftIPPort                := readInteger('MercuryGiftIPPort');
       except
          fMRMercury.GiftIPPort                := 0;
       end;


       try
          fMRMercury.GiftProcessor             := readInteger('GiftProcessor');
       except
          fMRMercury.GiftProcessor             := 0;
       end;

       //Gynbo
       fMRGynbo.StoreNum                    := ReadInteger('GynboStoreNum');
       fMRGynbo.Url                         := ReadString('GynboUrl');
       fMRGynbo.Terminal                    := ReadString('GynboTerminal');
       fMRGynbo.PartnerKey                  := ReadString('GynboPartnerKey');
       fMRGynbo.UrlPW                       := ReadString('GynboUrlPW');
       fMRGynbo.UrlUser                     := ReadString('GynboUrlUser');
       fMRGynbo.PartnerAcc                  := ReadString('PartnerAcc');
       //Poll Display
       fPollDisplay.FIP                     := ReadString('PollDisplayIP');
       fPollDisplay.FPort                   := ReadInteger('PollDisplayPort');
       fPollDisplay.FClearSale              := ReadBool('PollDisplayClearSale');
       //PetCenter
       fPetCenter.FIP                       := ReadString('PetCenterIP');
       fPetCenter.FPort                     := ReadInteger('PetCenterPort');
       //PinPad
       fPinPad.Device                       := ReadString('PinPadDevice');
       fPinPad.Baud                         := ReadString('PinPadBaud');
       fPinPad.Parity                       := ReadString('PinPadParity');
       fPinPad.DataBits                     := ReadString('PinPadDataBits');
       fPinPad.Comm                         := ReadString('PinPadComm');
       fPinPad.EncryptMethod                := ReadString('PinEncryptMethod');
       fPinPad.TimeOut                      := ReadString('PinTimeOut');
       //Scale
       fCashRegister.ScaleCheck             := ReadBool('ScaleCheck');
       fCashRegister.ScaleType              := ReadInteger('ScaleType');
       fSystem.fMRBuildValidate             := ReadBool('MRBuildValidate');
       Free;
     end;

   //Carrega os parametros do sistema
   Cont := 0;

   // Pega parametros do Server
   {with quSrvParam do
     begin
      Open;
      while not Eof do
       begin
         Inc(Cont);
         if Cont = 1 then
            DM.fSystem.SrvParam := VarArrayCreate([1, 1], varVariant)
         else
            VarArrayRedim(fSystem.fSrvParam, Cont);
         DM.fSystem.fSrvParam[Cont] := DM.fSystem.ConvertParam(quSrvParamSrvValue.AsString, quSrvParamSrvType.AsString);
         Next;
       end;
      Close;
     end;}
    iLastParam := -1;
    SetLength(fSystem.fSrvParam, 0);

    with quSrvParam do
    try
      quSrvParamLanguage.Close;
      quSrvParamLanguage.Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
      quSrvParamLanguage.Open;
      Open;
      while not Eof do
      begin
        if (quSrvParamIDParam.Value - iLastParam) > 1 then
        begin
          for I := (iLastParam + 1) to quSrvParamIDParam.Value -1 do
          begin
            SetLength(fSystem.fSrvParam, Length(fSystem.fSrvParam) + 1);
            fSystem.fSrvParam[Length(fSystem.fSrvParam) - 1] := Null;
          end;
        end;

        SetLength(fSystem.fSrvParam, Length(fSystem.fSrvParam) + 1);
        if quSrvParamLanguage.Locate('IDParam', quSrvParamIDParam.AsString, []) then
          fSystem.fSrvParam[Length(fSystem.fSrvParam) - 1] := DM.fSystem.ConvertParam(quSrvParamSrvValue.AsString, quSrvParamSrvType.AsString)
        else
          fSystem.fSrvParam[Length(fSystem.fSrvParam) - 1] := DM.fSystem.ConvertParam(quSrvParamDefaultValue.AsString, quSrvParamSrvType.AsString);
        iLastParam := quSrvParamIDParam.Value;
        Next;
      end;
    finally
      Close;
      quSrvParamLanguage.Close;
    end;

   // Atualiza as variáveis do sistema para a lingua
   ChangeLocalSetings(DMGlobal.IDLanguage);

   //Mudar MsgBox Lang
   SetMsgBoxLand(DMGlobal.IDLanguage);

   //Crio a Aviso de msg
   fFrmNewMessage := TFrmNewMessage.Create(Self);

   // seta se parâmetro obedecerá formato para indústria ( 4 casa decimais )
   // work around to fix
   setServerFormat(DM.fSystem.SrvParam[PARAM_ENABLE_INDUSTRY_OPTION]);


   // DMCalcPrice
   FDMCalcPrice := TDMCalcPrice.Create(Self);
   FDMCalcPrice.SetConnection(ADODBConnect);
   FDMCalcPrice.UseMargin       := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
   FDMCalcPrice.UseRound        := DM.fSystem.SrvParam[PARAM_CALC_ROUNDING];
   FDMCalcPrice.UseMarkupOnCost := DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST];

   //Antonio M F Souza 06.03.2011
   FDMCalcPrice.IncreasePriceOnly := DM.fSystem.SrvParam[PARAM_INCREASE_SELLINGPRICE_ONLY];
   FDMCalcPrice.RoundDecimal    := Power(10, FQtyDecimal);

   // Seta a data do cliente igual a do server
   fStore.StoreHour := fStore.ID;
   SetClientToServerDate;

   //Create Local Printer and set parameters
   Case fPrintReceipt.PaperType of
     PAPER_TYPE_4A :
      begin
      MyLocalPrinter := TWindowsPrinter.Create;
      TWindowsPrinter(MyLocalPrinter).SetStartPos(0);
      TWindowsPrinter(MyLocalPrinter).SetFontName(fPrintReceipt.PrinterFontName);
      TWindowsPrinter(MyLocalPrinter).SetFontSize(fPrintReceipt.PrinterFontSize);
      TWindowsPrinter(MyLocalPrinter).SetLineSpace(fPrintReceipt.PrinterLineSpace);
      // 12-05-06 Carlos Lima. Uses the defined printer name instead default printer
      TWindowsPrinter(MyLocalPrinter).PrinterName := fPrintReceipt.InvoiceReportPrinter;
      end;

     PAPER_TYPE_80COL:
      begin
       Case fPrintReceipt.PrinterType of
         PORT_LPT1,
         PORT_LPT2  : begin
                      MyLocalPrinter := TLPTPrinter.Create;
                      TLPTPrinter(MyLocalPrinter).SetPort(fPrintReceipt.PrinterPort);
                      end;
         PORT_WIN   : begin
                      MyLocalPrinter := TWindowsPrinter.Create;
                      TWindowsPrinter(MyLocalPrinter).SetStartPos(0);
                      TWindowsPrinter(MyLocalPrinter).SetFontName(fPrintReceipt.PrinterFontName);
                      TWindowsPrinter(MyLocalPrinter).SetFontSize(fPrintReceipt.PrinterFontSize);
                      TWindowsPrinter(MyLocalPrinter).SetLineSpace(fPrintReceipt.PrinterLineSpace);
                      end;
         end;
      end;
   end;

  // Criação do objeto de log de erro
  FTraceControl := TMRTraceControl.Create;
  FTraceControl.ADOConn := ADODBConnect ;

  CreatePollDisplay;

  OpenEntityFields;

  fGridRegistry := TRegistry.Create;
  fGridRegistry.RootKey := HKEY_CURRENT_USER;

  FBonusSync := TbgBonusSync.Create;

  FBonusSync.Init(HTTPReqRespCatalog,
                  fMRGynbo.Url, fMRGynbo.UrlUser, fMRGynbo.UrlPW,
                  fMRGynbo.PartnerAcc, fMRGynbo.PartnerKey, fMRGynbo.StoreNum);
  FBonusSync.Notes := fMRGynbo.FTerminal;

  fMRGynbo.MinSale := StrToCurrDef(DescCodigo(['Property'], [QuotedStr('BonusBuckMinSaleValue')], 'Sis_PropertyDomain', 'PropertyValue'), 100000);;
  fMRGynbo.DaysToUse := StrToIntDef(DescCodigo(['Property'], [QuotedStr('DaysToUseBonusBucks')], 'Sis_PropertyDomain', 'PropertyValue'), 1);
  fMRGynbo.ExpireDays := StrToIntDef(DescCodigo(['Property'], [QuotedStr('ExpireDaysBonusBucks')], 'Sis_PropertyDomain', 'PropertyValue'), 0);

  //Antonio M F Souza May 13 2012 - short term to get IdStore Level
  corporateView := TdlgSelectCorpView.Create(nil);
  corporateView.start(ADODBConnect);
  corporateView.Free;
  corporateView := nil;

  // amfsouza 2013, April 26:  create preserialMov object
  fCdsPreSerialMov := searchPreserialMovEmpty();

  // setup to initialize DsiPDCx (EMV transactions)
  InitializeDsiPDCXDevice();

  // Antonio 04/03/2017
  FPayMethod := TPayMethod.Create();
  FPayMethodList := TPayMethodList.Create();

end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin

  if ADODBConnect.Connected then
     ADODBConnect.Close;

  //Create Local Printer
  if Assigned(MyLocalPrinter) then
     FreeAndNil(MyLocalPrinter);

  slOriginalSQL.Free;

  if Assigned(FHandleError) then
     FHandleError.Free;

  if Assigned(fStore) then
     FreeAndNil(fStore);

  if Assigned(fUser) then
     FreeAndNil(fUser);

  if Assigned(fCashRegister) then
     FreeAndNil(fCashRegister);

  if Assigned(fSystem) then
     FreeAndNil(fSystem);

  if Assigned(fMainMenu) then
     FreeAndNil(fMainMenu);

  if Assigned(fPrintReceipt) then
     FreeAndNil(fPrintReceipt);

  if Assigned(fGrid) then
     FreeAndNil(fGrid);

  if Assigned(fInvoice) then
     FreeAndNil(fInvoice);

  if Assigned(fPCCharge) then
     FreeAndNil(fPCCharge);

  if Assigned(fMRMercury) then
     FreeAndNil(fMRMercury);

  if Assigned(fMRGynbo) then
     FreeAndNil(fMRGynbo);

  if Assigned(fPollDisplay) then
     FreeAndNil(fPollDisplay);

  if Assigned(fPetCenter) then
     FreeAndNil(fPetCenter);

  if Assigned(fInvPollDisplay) then
     FreeAndNil(fInvPollDisplay);

  if Assigned(fPOS) then
     FreeAndNil(fPOS);

  if Assigned(fPredefinedStyle) then
     FreeAndNil(fPredefinedStyle);

  if Assigned(WaitForm) then
     FreeAndNil(WaitForm);

  if Assigned(fFrmNewMessage) then
     FreeAndNil(fFrmNewMessage);

  if Assigned(fPinPad) then
     FreeAndNil(fPinPad);

  if Assigned(FDMCalcPrice) then
     FreeAndNil(FDMCalcPrice);

  if Assigned(FMainRetailConfig) then
     FreeAndNil(FMainRetailConfig);

  if Assigned(fGridRegistry) then
     FreeAndNil(fGridRegistry);

  if Assigned(FDMInventory) then
    FreeAndNil(FDMInventory);

  if Assigned(FBonusSync) then
    FreeAndNil(FBonusSync);

  CloseEntiryFields;

  FreeAndNil(FTraceControl);

  // release DsiPDCx
  freeAndNil(FDsiPDCX);

  //  Antonio 04/03/2017
  FreeAndNil(FPayMethodList);

  inherited;
end;

procedure TDM.LookUpBarCodeCalcFields(DataSet: TDataSet);
begin
  inherited;
  LookUpBarCodeDescBarCode.AsString := Trim(LookUpBarCodeModel.AsString) + '/' +
                                       Trim(LookUpBarCodeDescription.AsString);
end;

function TDM.quLookUpGroupClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('BrwFrmGroup') and (ClickedButton = btInc))then
     Exit;

  with TBrwFrmGroup.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.quLookUpStoreClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmStore') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmStore.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpComissionadoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=3;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;

end;

function TDM.LookUpUserTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('BrwFrmUserType') and (ClickedButton = btInc))then
     Exit;

  with TBrwFrmUserType.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpCashRegClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmCashRegister') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmCashRegister.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpUserClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmUser') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmUser.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpSalesPersonClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=4;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;
end;

function TDM.LookUpEstadoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmEstado') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmEstado.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.quLookUpIMTClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmInventMovType') and (ClickedButton = btInc))then
     Exit;

  With TbrwFrmInventMovType.Create(Self) do
     begin
     Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
     Free;
     end;
end;

function TDM.LookUpHotelClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchHotel') and (ClickedButton = btInc))then
     Exit;

  with TFchHotel.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpFornecedorClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
      sParam := 'IDTipoPessoa=2;';
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpModelInvClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchModel') and (ClickedButton = btInc))then
     Exit;

  with TFchModel.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpDeliverTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmDeliverType') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmDeliverType.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpSpcPriceClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmSpecialPrice') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmSpecialPrice.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpModelClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
var
   frmModelAdd: TfrmModelAdd;
   fchModel: TFchModel;
begin
  inherited;

  if (IsFormsRestric('FchModel') and (ClickedButton = btInc))then
     Exit;

  //Antonio M F Souza 01.21.2012
   if ( ClickedButton = btInc ) then begin
      frmModelAdd := TfrmModelAdd.Create(self);
      frmModelAdd.Start(False, False, False, '');
      freeAndNil(frmModelAdd);
   end
   else begin
      if ( ClickedButton = btAlt ) then begin
         fchModel := TFchModel.Create(self);
         fchModel.Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
         freeAndNil(fchModel);
      end;
   end;

end;

function TDM.LookUpMeioPagClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchMeioPag') and (ClickedButton = btInc))then
     Exit;

  With TFchMeioPag.Create(Self) do
     begin
     Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
     Free;
     end;
end;

function TDM.LookUpAgencyClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=6;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;
end;

function TDM.LookUpGuideClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=5;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;
end;

function TDM.LookUpFabricanteClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=7;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;
end;

function TDM.LookUpCentroCustoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchCostType') and (ClickedButton = btInc))then
     Exit;

  with TFchCostType.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpUnidadeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFchUnidade.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpNewModelClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchModel') and (ClickedButton = btInc))then
     Exit;

  with TFchModel.Create(Self) do
    begin
      IsDetail := False;
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpCostTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchCostType') and (ClickedButton = btInc))then
     Exit;

  with TFchCostType.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpOtherClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=9;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;
end;

function TDM.LookUpPaisClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmPais') and (ClickedButton = btInc))then
     Exit;

  with TbrwFrmPais.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.LookUpCustomerClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=1;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;
end;

function TDM.LookUpColorClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmColor') and (ClickedButton = btInc))then
     Exit;

  With TbrwFrmColor.Create(Self) do
     begin
     Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
     Free;
     end;
end;

function TDM.LookUpSizeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('brwFrmSize') and (ClickedButton = btInc))then
     Exit;

  With TbrwFrmSize.Create(Self) do
     begin
     Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
     Free;
     end;
end;

function TDM.LookUpModelMasterClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchModel') and (ClickedButton = btInc))then
     Exit;

  with TFchModel.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

function TDM.quLookUpTaxCategoryClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchTaxCategory') and (ClickedButton = btInc))then
     Exit;

  with TFchTaxCategory.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;
end;

procedure TDM.quLookUpStoreBeforeOpenGrid(Sender: TObject);
begin
  inherited;
  TSuperComboADO(Sender).SpcWhereClause :=
      MontaComboWhereClause('Store', 'IDStore', fStore.StoreList);
end;

function TDM.LookUpHistoryTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  //Code Here

  if (IsFormsRestric('FchHistoryType') and (ClickedButton = btInc))then
     Exit;

  with TFchHistoryType.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;

end;

function TDM.LookUpProspectsClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

    if (IsFormsRestric('FchPessoa') and (ClickedButton = btInc))then
     Exit;

  with TFchPessoa.Create(Self) do
    begin
    sParam := 'IDTipoPessoa=10;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
    end;

end;

function TDM.LookUpColorGroupClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('brwFrmSizeColorGroup') and (ClickedButton = btInc))then
    Exit;

  with TBrwFrmSizeColorGroup.Create(Self) do
  begin
    sParam := 'IsColor=1;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpSizeGroupClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('brwFrmSizeColorGroup') and (ClickedButton = btInc))then
    Exit;

  with TBrwFrmSizeColorGroup.Create(Self) do
  begin
    sParam := 'IsColor=0;';
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpPetPorteClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchPetPorte') and (ClickedButton = btInc))then
    Exit;

  with TFchPetPorte.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpPetRaceClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchPetRace') and (ClickedButton = btInc))then
    Exit;

  with TFchPetRace.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpPetSpeciesClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchPetSpecies') and (ClickedButton = btInc))then
    Exit;

  with TFchPetSpecies.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

procedure TDM.ValidateLicense;
begin
  if (fSystem.StartMode = SYS_MODULE_TRIAL) then
    Exit;

  if (DM.fSystem.ExpirationDate < DM.fSystem.SystemDate) then
  begin
    if DisplayLicenseForm then
      MsgBox(MSG_INF_CHANGES_SYS, vbOKOnly  + vbInformation);
  end
  else if ((DM.fSystem.ExpirationDate-5) < DM.fSystem.SystemDate) then
  begin
    if MsgBox(Format(MSG_QST_ENTER_LICENSE, [DaysBetween(DM.fSystem.ExpirationDate, DM.fSystem.SystemDate)]), vbYesNo + vbSuperCritical) = vbYes then
      if DisplayLicenseForm Then
        MsgBox(MSG_INF_CHANGES_SYS, vbOKOnly  + vbInformation);
  end
  else if ((DM.fSystem.ExpirationDate-10) < DM.fSystem.SystemDate) then
  begin
    if MsgBox(Format(MSG_QST_ENTER_LICENSE, [DaysBetween(DM.fSystem.ExpirationDate, DM.fSystem.SystemDate)]), vbYesNo + vbQuestion) = vbYes then
      if DisplayLicenseForm Then
        MsgBox(MSG_INF_CHANGES_SYS, vbOKOnly  + vbInformation);
  end;
end;

procedure TDM.SendPetCenterInfo(fIDPreSale : Integer);
begin

  if (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') and (fPetCenter.FIP <> '') and
     FileExists(fPetCenter.FIP) then
    ExecuteFile(fPetCenter.FIP, 'SALE ' + Trim(IntToStr(fIDPreSale)), '', SW_HIDE);

end;


procedure TDM.SendPuppyInfo(fIDInvoice: Integer);
begin
  if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') and
      FileExists(DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION]) then
  begin
    ExecuteFile(DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION], Trim(IntToStr(fIDInvoice)), '', SW_HIDE);
  end;
end;

procedure TDM.VerifyMessage;
begin

  try
    with quTestMessage do
    begin
      if not Active then
      begin
        Parameters.ParamByName('IDUser').Value := DM.fUser.ID;
        Open;
      end;

      if quTestMessageMessages.AsInteger <= 0 then
        fFrmNewMessage.MessageHide
      else
        fFrmNewMessage.Start(quTestMessageMessages.AsInteger);

      Close;
    end;
 except
   MsgBox(MSG_CRT_NO_CONECTION, vbOKOnly + vbCritical);
 end;
end;

{ TMRPCCharge }

constructor TMRPCCharge.Create;
begin
  fPCChargeConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + PAYMENT_PROCESSOR );
  fPCChargeCardID := TStringList.Create;
  fPCChargeConfig.ReadSections(fPCChargeCardID);
end;

destructor TMRPCCharge.Destroy;
begin
  FreeAndNil(fPCChargeConfig);
  FreeAndNil(fPCChargeCardID);
  inherited;
end;

function TMRPCCharge.GetIDMeioPag(sCardID: String): Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to Pred(fPCChargeCardID.Count) do
    if fPCChargeConfig.ReadString(fPCChargeCardID[i], 'CardID', '') = sCardID then
    begin
      Result := StrToIntDef(fPCChargeCardID[i], -1);
      Break;
    end;
end;

procedure TMRPCCharge.GetProcessor(IDMeioPag: Integer; var Processor,
  MercantAcc: String; var Copies: Integer; var CardID : String);
begin
  Processor  := fPCChargeConfig.ReadString(IntToStr(IDMeioPag), 'Processor', '');
  MercantAcc := fPCChargeConfig.ReadString(IntToStr(IDMeioPag), 'MercantNum', '');
  Copies     := fPCChargeConfig.ReadInteger(IntToStr(IDMeioPag), 'Copies', 1);
  CardID     := fPCChargeConfig.ReadString(IntToStr(IDMeioPag), 'CardID', '');
  DeviceProcess := fPCChargeConfig.ReadInteger(intToStr(IdMeioPag), 'ProcessType', -1);
end;

procedure TMRPCCharge.SetProcessor(MeioPag, Processor,
  MercantAcc: String; Copies: Integer; CardID : String);
var
  IDMeioPag: Integer;
begin
  IDMeioPag := StrToIntDef(DM.DescCodigo(['MeioPag'], [QuotedStr(MeioPag)], 'MeioPag', 'IDMeioPag'), 0);

  SetProcessor(IDMeioPag, Processor, MercantAcc, Copies, CardID);
end;

function TMRPCCharge.IdentifySwipedCard(AInputText: WideString): Integer;
var
  CardInfo : WideString;
  CardType : String;
  posSemicolumn, posQuestion: Integer;
begin
  Result := -1;

  CardInfo := AInputText;

  posSemicolumn := Pos(';', CardInfo);
  Delete(CardInfo, 1, posSemicolumn);

  posQuestion   := Pos('?', CardInfo);
  CardInfo := Copy(CardInfo, 1, posQuestion - 1);

  CardType  := '';

  if StrToIntDef(Copy(CardInfo, 1, 1),0) = 4 then
    CardType := 'VISA'
  else if StrToIntDef(Copy(CardInfo, 1, 2), 0) in [51 .. 55] then
    CardType := 'MASTERCARD'
  // Antonio M F Souza 02.12.2011 - according to Nick's request  else if StrToIntDef(Copy(CardInfo, 1, 4), 0) = 6011 then
  else if StrToIntDef(Copy(CardInfo, 1, 1), 0) = 6 then
    CardType := 'DISCOVER'
  else if ((StrToIntDef(Copy(CardInfo, 1, 2), 0) = 34) or (StrToIntDef(Copy(CardInfo, 1, 2), 0) = 37)) then
    CardType := 'AMEX'
  else if ((StrToIntDef(Copy(CardInfo, 1, 2), 0) = 36) or (StrToIntDef(Copy(CardInfo, 1, 2), 0) = 30)) then
    CardType := 'DINERS'
  else if StrToIntDef(Copy(CardInfo, 1, 2), 0) = 38 then
    CardType := 'CARTEBLANCHE'
  else if StrToIntDef(Copy(CardInfo, 1, 1), 0) = 2 then
    CardType := 'ENROUTE'
  else if StrToIntDef(Copy(CardInfo, 1, 2), 0) = 56 then
    CardType := 'BANKCARD'
  else if ((StrToIntDef(Copy(CardInfo, 1, 1), 0) = 3) or (StrToIntDef(Copy(CardInfo, 1, 4), 0) = 2131) or (StrToIntDef(Copy(CardInfo, 1, 4), 0) = 1800)) then
    CardType := 'JCB'
  //;Antonio M F Souza 12.26.2011 - to identify Mercury Gift Card
  else if ( strToIntDef(copy(CardInfo, 1, 7), 0) = 6050110 ) then //Mercury Gift Card.
    CardType := 'MERCURY GIFT CARD';
  if (CardType <> '') then
    Result := GetIDMeioPag(CardType);

end;

procedure TMRPCCharge.SetProcessor(IDMeioPag: Integer; Processor,
  MercantAcc: String; Copies: Integer; CardID : String);
begin
  fPCChargeConfig.WriteString(IntToStr(IDMeioPag), 'Processor', Processor);
  fPCChargeConfig.WriteString(IntToStr(IDMeioPag), 'MercantNum', MercantAcc);
  fPCChargeConfig.WriteInteger(IntToStr(IDMeioPag), 'Copies', Copies);
  fPCChargeConfig.WriteString(IntToStr(IDMeioPag), 'CardID', CardID);
end;


function TDM.LookUpDefectTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchDefectType') and (ClickedButton = btInc))then
    Exit;

  with TFchDefectType.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpDepartmentClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchDepartment') and (ClickedButton = btInc))then
    Exit;

  with TFchDepartment.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpInvReasonClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchInventoryReason') and (ClickedButton = btInc))then
    Exit;

  with TFchInventoryReason.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.SaleHavePuppyTrackerItem(IDPreSale:Integer): Boolean;
begin
  Result := False;

 if (fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
    (fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
    with quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT TG.PuppyTracker');
      SQL.Add('FROM Invoice I');
      SQL.Add('LEFT JOIN InventoryMov IM ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID = 1 AND IM.IDParentPack Is Null)');
      SQL.Add('LEFT JOIN PreInventoryMov PIM ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID = 1 AND PIM.IDParentPack Is Null)');
      SQL.Add('JOIN Model M ON ( IM.ModelID = M.IDModel OR PIM.ModelID = M.IDModel)');
      SQL.Add('JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )');
      SQL.Add('WHERE I.IDPreSale = :IDPreSale');

      Parameters.ParamByName('IDPreSale').Value := IDPreSale;
      try
       Open;
       if Locate('PuppyTracker',True,[]) then
         Result := True;
      finally
        Close;
      end;
    end;

end;

function TDM.LookUpPHistoryTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchPessoaHistoryType') and (ClickedButton = btInc))then
    Exit;

  with TFchPessoaHistoryType.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;

end;

function TDM.ReconnectDatabase(AConnection: TADOConnection): Boolean;
begin
  Result := false;

  Application.ProcessMessages;
  if (MsgBox(MSG_INF_RECONNECT_TO_THE_SERVER, vbYesNo + vbQuestion) = vbYes) then
    begin
      if AConnection.Connected then
        AConnection.Connected := False;

      AConnection.Connected := True;
      Result := True;
    end
  else
    begin
      if AConnection.Connected then
        AConnection.Connected := False;

      Application.Terminate;
    end;
end;

procedure TDM.AppException(Sender: TObject; E: Exception);
begin
  if (E is EOleException) then
    begin
      if (EOleException(E).ErrorCode =  CONNECTION_ERROR) then
        ReconnectDatabase(ADODBConnect)
      else
        Application.ShowException(E.Create(e.Message));
    end
  else
    Application.ShowException(E);
end;

procedure TDM.ProcessInventoryBalance;
begin
  spInventoryCalcBalance.ExecProc;
end;

function TDM.quLookupRebateCalendarClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchRebateCalendar') and (ClickedButton = btInc))then
    Exit;

  with TFchRebateCalendar.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpCashRegLogReasonClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchCashRegLogReason') and (ClickedButton = btInc))then
    Exit;

  with TFchCashRegLogReason.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

procedure TDM.CreatePollDisplay;
begin
  if (fPollDisplay.FIP <> '') then
  begin
    fInvPollDisplay := TInvoice.Create;
    fInvPollDisplay.SetServerInfo(fPollDisplay.FIP, fPollDisplay.FPort);
    fStartPollDisplay := fInvPollDisplay.ConnectPole;
  end
  else
    fStartPollDisplay := False;
end;

procedure TDM.PollDisplayAddItem(AID, AIDModel: Integer; AModel,
  ADescription: String; AQty: Double; ASalePrice, ADiscount: Currency);
begin

  if fStartPollDisplay and Assigned(fInvPollDisplay) then
    fInvPollDisplay.AddItem(AID,
                            AIDModel,
                            AModel,
                            ADescription,
                            AQty,
                            ASalePrice,
                            ADiscount);

end;

procedure TDM.PollDisplayAddPayment(AID: Integer; APayment: String;
  AAMount: Currency);
begin
  if fStartPollDisplay and Assigned(fInvPollDisplay) then
    fInvPollDisplay.AddPayment(AID,
                               APayment,
                               AAMount);
end;

procedure TDM.PollDisplayCloseSale;
begin
  if fStartPollDisplay and Assigned(fInvPollDisplay) then
  begin
    fStartPollDisplay := fInvPollDisplay.ConnectPole;
    if fStartPollDisplay then
      fInvPollDisplay.CloseSale(fPollDisplay.FClearSale);
  end;
end;

procedure TDM.PollDisplayInvInfo(ASaleCode: String; ASaleDate: TDatetime;
  AAddCostTotal, ADiscountTotal, ATaxTotal, ASubTotal: Currency; UpdateFile : Boolean = False);
begin
  if fStartPollDisplay and Assigned(fInvPollDisplay) then
    fInvPollDisplay.InvoiceInfo(ASaleCode,
                                ASaleDate,
                                AAddCostTotal,
                                ADiscountTotal,
                                ATaxTotal,
                                ASubTotal,
                                UpdateFile);
end;

procedure TDM.PollDisplayDeleteItem(AID: Integer);
begin
  if fStartPollDisplay and Assigned(fInvPollDisplay) then
    fInvPollDisplay.DeleteItem(AID, True);
end;

procedure TDM.PollDisplayDeletePayment(AID: Integer);
begin
  if fStartPollDisplay and Assigned(fInvPollDisplay) then
    fInvPollDisplay.DeletePayment(AID, True);
end;

procedure TDM.PollDisplayOpenHoldItems(FspquPreSaleItem: TADOStoredProc);
begin
  if fStartPollDisplay and Assigned(fInvPollDisplay) then
  with FspquPreSaleItem do
    if Active and (RecordCount > 0) then
    begin
      First;
      while not EOF do
      begin
        PollDisplayAddItem(FieldByName('IDInventoryMov').AsInteger,
                           FieldByName('ModelID').AsInteger,
                           FieldByName('Model').AsString,
                           FieldByName('Description').AsString,
                           FieldByName('Qty').AsFloat,
                           FieldByName('SalePrice').AsCurrency,
                           FieldByName('Discount').AsCurrency);
        Next;
      end;
    end;
end;

function TDM.LookUpDocumentTypeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchDocumentType') and (ClickedButton = btInc))then
    Exit;

  with TFchDocumentType.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.CreatePetSale(AIDPreInvMov, AIDPet, AIDCustomer: Integer;
  AQty : Double): Integer;
var
  FCommand : TADOCommand;
begin

  FCommand := TADOCommand.Create(Self);
  try
    FCommand.Connection := ADODBConnect;

    FCommand.CommandText := 'INSERT Pet_PetSale (IDPetSale, IDPreInventoryMov, IDWarrantyReport, IDWarrantyCustomer, IDPet) ' +
                            'VALUES (:IDPetSale, :IDPreInventoryMov, :IDWarrantyReport, :IDWarrantyCustomer, :IDPet) ';

    Result := GetNextID('Pet_PetSale.IDPetSale');
    FCommand.Parameters.ParamByName('IDPetSale').Value          := Result;
    FCommand.Parameters.ParamByName('IDPreInventoryMov').Value  := AIDPreInvMov;
    FCommand.Parameters.ParamByName('IDWarrantyReport').Value   := GetWarrantyReportID(AIDPet);
    FCommand.Parameters.ParamByName('IDWarrantyCustomer').Value := AIDCustomer;
    FCommand.Parameters.ParamByName('IDPet').Value              := AIDPet;
    FCommand.Execute();

    //Altera o status do Pet
    if AQty > 0 then
      FCommand.CommandText := 'UPDATE Pet SET IDStatus = 5 ' +
                              'WHERE IDPet = :IDPet'
    else
      FCommand.CommandText := 'UPDATE Pet SET IDStatus = 1 ' +
                              'WHERE IDPet = :IDPet';

    FCommand.Parameters.ParamByName('IDPet').Value    := AIDPet;
    FCommand.Execute();

  finally
    FreeAndNil(FCommand);
    end;

end;

function TDM.GetWarrantyReportID(AIDPet: Integer): Integer;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := ADODBConnect;
    FQuery.SQL.Add('SELECT TOP 1 PW.IDWarrantyReport');
    FQuery.SQL.Add('FROM Pet_WarrantyReport PW');
    FQuery.SQL.Add('JOIN Pet P ON (P.IDSpecies = PW.IDSpecies)');
    FQuery.SQL.Add('WHERE P.IDPet = :IDPet');
    FQuery.SQL.Add('AND Report IS NOT NULL');
    FQuery.SQL.Add('ORDER BY IDWarrantyReport DESC');
    FQuery.Parameters.ParamByName('IDPet').Value := AIDPet;
    FQuery.Open;
    Result := FQuery.FieldByName('IDWarrantyReport').AsInteger;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TDM.ExecRunning: Integer;
var
  App : String;
begin
  App := Application.ExeName;
  Result := EXE_Running(ExtractFileName(App), False);
end;

procedure TDM.CloseEntiryFields;
begin
  with cdsEntityFields do
    if Active then
      Close;
end;

procedure TDM.OpenEntityFields;
begin
  with cdsEntityFields do
    if not Active then
      Open;
end;

procedure TDM.RefreshEntityField;
begin
  CloseEntiryFields;
  OpenEntityFields;
end;

function TDM.FilterEntyField(AIDTipoPessoa: Integer): String;
begin

  Result := '';

  with cdsEntityFields do
  begin
    Filtered := False;
    Filter   := 'IDTipoPessoa = ' + IntToStr(AIDTipoPessoa);
    Filtered := True;
    First;
    while not EOF do
    begin
      Result := Result + FieldByName('PessoaField').AsString + ',';
      Next;
    end;
  end;

end;

function TDM.LookUpCFOPClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;
  if (IsFormsRestric('FchCFOP') and (ClickedButton = btInc))then
    Exit;

  with TFchCFOP.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

function TDM.LookUpRamoAtividadeClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchRamoAtividade') and (ClickedButton = btInc))then
     Exit;

  with TFchRamoAtividade.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;

end;

constructor TMRSystem.Create;
begin

end;

destructor TMRSystem.Destroy;
begin
  if Assigned(FLogo) then
    FreeAndNil(FLogo);
  inherited;
end;

procedure TDM.LoadGridFromRegistry(AGrid: TcxGridDBTableView; APath : String;
  AOptions: TcxGridStorageOptions);
begin
  if APath <> '' then
    if fGridRegistry.KeyExists(APath) then
      AGrid.RestoreFromRegistry(APath, False, False, AOptions);
end;

procedure TDM.SaveGridToRegistry(AGrid: TcxGridDBTableView; APath : String;
  ARecreate: Boolean; AOptions: TcxGridStorageOptions);
begin
  if APath <> '' then
    AGrid.StoreToRegistry(APath, ARecreate, AOptions);
end;

function TDM.LookUpLotClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchLot') and (ClickedButton = btInc))then
     Exit;

  With TFchLot.Create(Self) do
  try
    sParam := FFchParam;
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
  Finally
    Free;
    end;

end;

function TDM.LookUpNCMClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchNCM') and (ClickedButton = btInc))then
     Exit;

  With TFchNCM.Create(Self) do
  try
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
  Finally
    Free;
    end;

end;

function TDM.LookUpMunicipioClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchMunicipio') and (ClickedButton = btInc))then
     Exit;

  With TFchMunicipio.Create(Self) do
  try
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
  Finally
    Free;
    end;

end;

procedure TDM.GetSQLServerInfo;
begin

  try

    with DM.quFreeSQL do
    begin
      if Active then
       Close;
      SQL.Clear;
      SQL.Add('SELECT CAST(SERVERPROPERTY(' + QuotedStr('productversion') + ') as varchar) as SQLVersion,');
      SQL.Add('CAST(SERVERPROPERTY(' + QuotedStr('productlevel') + ') as varchar) as SQLLevel,');
      SQL.Add('CAST(SERVERPROPERTY(' + QuotedStr('edition') + ') as varchar) as SQLEdition');
      try
        Open;
        fSQLConnectParam.SQLVersion := FieldByName('SQLVersion').AsString;
        fSQLConnectParam.SQLLevel   := FieldByName('SQLLevel').AsString;
        fSQLConnectParam.SQLEdition := FieldByName('SQLEdition').AsString;
      finally
        Close;
        end;
    end;

  except
  end;

end;

function TDM.quLookupNutritionClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if (IsFormsRestric('FchNutrition') and (ClickedButton = btInc))then
    Exit;

  with TFchNutrition.Create(Self) do
  begin
    Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
    Free;
  end;
end;

procedure TDM.setServerFormat(AToIndustry: boolean);
begin
   if ( AToIndustry ) then
   begin
      FQtyDecimal := 4;
      FQtyDecimalFormat := '0.0000';
   end
   else
   begin
      FQtyDecimal := 2;
      FQtyDecimalFormat := '0.00';
   end;
end;

function TDM.CalcularImpostoST(IDPreSale: Integer): Currency;
var
  MVAPercent, T_Aliquota, cAcrescimo, cDesconto : Currency;
  vDesc, qCom, vUnCom, vBC, pICMS, vICMS, pMVAST, pICMSST, vBCST, vICMSST : Currency;
begin

  vICMSST := 0;
  MVAPercent := 0;
  T_Aliquota := 0;
  cAcrescimo := 0;
  cDesconto := 0;
  vDesc  := 0;
  qCom  := 0;
  vUnCom := 0;
  vBC := 0;
  pICMS := 0;
  vICMS := 0;
  pMVAST := 0;
  pICMSST := 0;
  vBCST := 0;
  vICMSST := 0;

  with quCalcTaxST do
  try
    Parameters.ParamByName('IDPreSale').Value := IDPreSale;
    Open;
    First;
    while not EOF do
      if FieldByName('T_SituacaoTributaria').AsInteger = TAX_SUBSTITUICAO then
      begin
        if FieldByName('EstadoCliente').AsString = FieldByName('EstadoLoja').AsString then
          MVAPercent := FieldByName('MVAInterno').AsCurrency
        else
          MVAPercent := FieldByName('MVAInterestadual').AsCurrency;
        T_Aliquota := FieldByName('TaxCategoriaPer').AsCurrency;

        //Substituição Tributaria
        cAcrescimo := 0;
        cDesconto := FieldByName('IM_Discount').AsCurrency;
        if cDesconto < 0 then
          cAcrescimo := ABS(cDesconto)
        else
          vDesc := cDesconto;

        // Quantidade Comercial
        qCom := ABS(FieldByName('IM_QTY').AsCurrency);

        // Valor Unitário de comercialização/tributação
        vUnCom := ABS(FieldByName('IM_SalePrice').AsCurrency) + (cAcrescimo/qCom);

        //Base de calculo do ICMS/Valor Total Bruto dos Produtos ou Serviços
        vBC := TruncDecimal((vUnCom * qCom) - (vDesc * qCom), FQtyDecimal);

        //Alíquota do imposto loja
        pICMS := T_Aliquota;

        // Valor do ICMS loja
        vICMS := vBC * (pICMS/100);

        //Percentual da margem de valor Adicionado do ICMS ST
        pMVAST := MVAPercent;

        //Alíquota do imposto substituicao
        pICMSST := FieldByName('T_AliquotaST').AsCurrency;

        //Valor Base de calculo do ICMS Substituicao
        vBCST := (vBC + (vBC * (pICMSST/100)));

        //Valor do ICMS Substituicao
        vICMSST := vICMSST + ((vBCST * (pICMS/100)) - vICMS);

        Next;
      end;
    Result := vICMSST;
  finally
   Close;
  end;

  if (vICMSST <> 0) then
  with cmdUpdateSTTax do
  begin
    Parameters.ParamByName('Tax').Value := vICMSST;
    Parameters.ParamByName('IDPreSale').Value := IDPreSale;
    Execute;
  end;

end;

function TDM.BonusGenerate(AInvoiceTotal, ABonusValue: Currency; AInvoiceNumber: String;
  AInvoiceDate: TDateTime; var ABonusCode: String; var AIDError: Integer;
  var AErrorMsg: String): Boolean;
var
  bError : Boolean;
begin

  Result := False;

  FBonusSync.BonusCode := '';
  FBonusSync.BonusValue := 0;

  AIDError := 0;
  AErrorMsg := '';
  ABonusCode := '';

  if ABonusValue > 0 then
  begin
    if AInvoiceTotal >= fMRGynbo.MinSale then
    begin
      FBonusSync.BonusValue      := MyRound(ABonusValue, 2);
      FBonusSync.ValidFrom       := Trunc(AInvoiceDate + fMRGynbo.DaysToUse);
      FBonusSync.ExpirationDate  := (AInvoiceDate + fMRGynbo.DaysToUse + fMRGynbo.ExpireDays);
      FBonusSync.InvoiceNumber   := AInvoiceNumber;
      FBonusSync.InvoiceDate     := AInvoiceDate;
      bError := True;
      try
        if FBonusSync.Generate then
        begin
          bError := (FBonusSync.IDResult <> 0);
          if not bError then
          begin
            ABonusCode            := FBonusSync.BonusCode;
            FBonusSync.BonusValue := ABonusValue;
          end;
        end;
      except
      end;

      if bError then
      begin
        AIDError  := FBonusSync.IDResult;
        AErrorMsg := FBonusSync.ResultMessage;
        Exit;
      end;
    end;
  end;

  Result := True;

end;

function TDM.BonusUnUse(ABonusCode: String; var AIDError: Integer;
  var AErrorMsg: String): Boolean;
begin
  Result := False;
  AIDError := 0;
  AErrorMsg := '';

  //MSG_CRT_ERROR_UNUSE_BONUS
end;

function TDM.BonusUse(ABonusCode: String; var ABonusValue: Currency;
  var AIDError: Integer; var AErrorMsg: String): Boolean;
var
  bError : Boolean;
begin
  Result := False;
  AIDError := 0;
  AErrorMsg := '';
  ABonusValue := 0;

  if (ABonusCode <> '') then
  begin
     FBonusSync.BonusCode := ABonusCode;
      try
        bError := True;
        if FBonusSync.Use then
        begin
          bError := (FBonusSync.IDResult <> 0);
          if not bError then
            ABonusValue := DM.FBonusSync.BonusValue;
        end;
      except
      end;

      if bError then
      begin
        AIDError := FBonusSync.IDResult;
        AErrorMsg := FBonusSync.ResultMessage;
        Exit;
      end;
  end;

  Result := True;

end;

function TDM.BonusVoid(ABonusCode: String; var AIDError: Integer;
  var AErrorMsg: String): Boolean;
begin
  Result := False;
  AIDError := 0;
  AErrorMsg := '';

  //MSG_CRT_ERROR_VOIDING_BONUS
end;

function TDM.getIdPreSale(AHoldNumber: Integer): Integer;
var
   sql: String;
   dsInvoice: TADOQuery;
begin
  try
    dsInvoice := TADOQuery.Create(nil);
    dsInvoice.Connection := dm.ADODBConnect;

    sql := 'select idPreSale from Invoice where saleCode = :salecode';
    dsInvoice.SQL.Text := sql;
    dsInvoice.Parameters.ParamByName('salecode').Value := AHoldNumber;
    dsInvoice.Open;

    result := dsInvoice.fieldByName('idpresale').Value;

  finally
    freeAndNil(dsInvoice);
  end;

end;

function TDM.verifyPuppyInPetCategory(pIdModel: Integer): boolean;
var
  qry: TADOQuery;
  sql: String;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := ADODBConnect;

    result := false;

    sql :=
      'select m.IdModel ' +
      'from Model m ' +
      'join PT_GlobalSetting p on m.GroupID = p.IDPetCategory ' +
      'where m.Idmodel = :idmodel ';

    qry.SQL.Text := sql;
    qry.Parameters.ParamByName('idmodel').Value := pIdModel;
    qry.Open;

    result := ( not qry.IsEmpty )

  finally
     freeAndNil(qry);
  end;

end;

function TDM.isGiftCardModel(idmodel: Integer): Boolean;
var
   qry: TADOQuery;
begin
   result := false;

   try
      qry := TADOQuery.create(nil);
      qry.Connection := dm.ADODBConnect;

      qry.SQL.Add('select m.model, m.description, tg.serialnumber');
      qry.SQL.Add(' from model m join tabgroup tg on m.groupID = tg.idGroup');
      qry.SQL.Add(' where tg.serialnumber = 1 and m.Idmodel =:idmodel');
      qry.Parameters.ParamByName('idmodel').Value := idmodel;
      qry.Open;
      result := qry.recordcount > 0;

   finally
      freeandNil(qry);
   end;

end;

function TDM.AddCardNumberToCdsMercuryGift(card_number: String; balance: Double; gift_transaction: String; issued: Integer): Boolean;
begin
   // Antonio M F Souza 01.11.2012  - create memory structure to save card information.
   FCdsMercuryGift.Append;
   FCdsMercuryGift.FieldByName('CardNumber').Value      := card_number;
   FCdsMercuryGift.FieldByName('Balance').Value         := balance;
   FCdsMercuryGift.FieldByName('TransactionType').Value := gift_transaction;
   FCdsMercuryGift.FieldByName('Issued').Value          := issued;
   FCdsMercuryGift.Post;
end;

procedure TDM.CreateCdsMercuryGift;
begin
   // Antonio M F Souza 01.11.2012 - to save Mercury gift cards
   FCdsMercuryGift     := TClientDataSet.Create(nil);
   FCdsMercuryGift.FieldDefs.add('CardNumber', ftString, 20, false);
   FCdsMercuryGift.FieldDefs.Add('Balance', ftCurrency);
   FCdsMercuryGift.FieldDefs.Add('GiftTransaction', ftInteger, 0, true);
   FCdsMercuryGift.FieldDefs.Add('Issued', ftInteger, 0, false);
   FCdsMercuryGift.CreateDataSet;
end;

function TDM.CleanCdsMercuryGift: Boolean;
begin
   FCdsMercuryGift.EmptyDataSet;
end;

procedure TDM.DestroyCdsMercuryGift(cdsMercury: TClientDataSet);
begin
   freeAndNil(FCdsMercuryGift);
end;

{ TMRMercury }

constructor TMRMercury.create;
begin
   FMercuryErrorsCode := TClientDataSet.create(nil);

   // Create a memory structure to deal message error from Mercury.
   FMercuryErrorsCode.fieldDefs.add('CodeNumber', ftInteger, 0, false);
   FMercuryErrorsCode.fieldDefs.add('CodeText', ftString, 200 , false);
   FMercuryErrorsCode.fieldDefs.add('PinogyCodeText', ftString, 255 , false);
   FMercuryErrorsCode.fieldDefs.add('ErrorLevel', ftInteger, 0 , false);
   FMercuryErrorsCode.fieldDefs.add('Client', ftBoolean, 0 , true);
   FMercuryErrorsCode.CreateDataSet();

 //  fillMercuryErrorsCode();
end;

procedure TMRMercury.fillMercuryErrorsCode;
var
   qry: TADOQuery;
begin
   try
      qry := TADOQuery.Create(nil);
      qry.Connection := dm.ADODBConnect;
      qry.SQL.Add('select * from MercuryErrorCode');
      qry.Open;

      while ( not qry.Eof ) do begin
         // load all Mercury Errors Code
         FMercuryErrorsCode.Append;
         FMercuryErrorsCode.FieldByName('CodeNumber').Value := qry.fieldByName('CodNumber').Value;
         FMercuryErrorsCode.FieldByName('CodeText').Value := qry.fieldByName('CodeText').Value;
         FMercuryErrorsCode.FieldByName('PinogyCodeText').Value := qry.fieldByName('PinogyCodeText').Value;
         FMercuryErrorsCode.FieldByName('ErrorLevel').Value := qry.fieldByName('ErrorLevel').Value;
         FMercuryErrorsCode.FieldByName('Client').Value :=  StrToBoolDef(qry.fieldByName('Client').Value, true);

         FMercuryErrorsCode.Post;

         qry.Next();
      end;

   finally
      freeAndNil(qry);
   end;
end;

function TMRMercury.getMercuryErrorsCode: TClientDataSet;
begin
  result := FMercuryErrorsCode;
end;

function TMRMercury.getQtyToRemove: Double;
begin
  result :=  FQtyToRemove
end;

procedure TMRMercury.setQtyToRemove(const Value: Double);
begin
   FQtyToRemove := value
end;

function TDM.IsCashRegisterOpen(pIdCashRegister: Integer): Boolean;
var
  qry: TADOQuery;
begin
  qry := TADOQuery.Create(nil);
  qry.Connection := ADODBConnect;

  qry.SQL.Add('select * from CashRegister');
  qry.open();

  qry.Filter := 'IdCashRegister = ' + intToStr(pIdCashRegister);
  qry.Filtered := true;

  result := qry.fieldByName('IsOpen').AsBoolean = true;

  freeAndNil(qry);
end;

function TDM.setCashRegister(pIdCashRegister: Integer; pOpen: Boolean = true): Boolean;
var
  qry: TADOQuery;
begin
  try
     try
        result := false;
        qry := TADOQuery.Create(nil);
        qry.Connection := ADODBConnect;

        qry.SQL.Add('update CashRegister set IsOpen =:open where IdCashRegister =:id');
        qry.Parameters.ParamByName('open').Value := pOpen;
        qry.parameters.ParamByName('id').Value := pIdCashRegister;
        qry.ExecSQL();
        result := true;
     except
         on e:Exception do
           raise exception.Create('Update failed: '+ e.Message);
     end;
  finally
     freeAndNil(qry);
  end;
end;

function TDM.getCashRegisterName(pIdCashRegister: Integer): String;
var
  qry: TADOQuery;
begin

  result := '<undefined name>';

  qry := TADOQuery.Create(nil);
  qry.Connection := ADODBConnect;

  qry.SQL.Add('select * from CashRegister where IdCashRegister =:id');
  qry.Parameters.ParamByName('id').value := pIdCashRegister;
  qry.open();

  result := qry.fieldByName('Name').Value;

  freeAndNil(qry);
end;

function TDM.IsUserTypeSystem(pIdUserType: Integer): Boolean;
var
  qry: TADOQuery;
begin

  result := false;

  qry := TADOQuery.Create(nil);
  qry.Connection := ADODBConnect;

  qry.SQL.Add('select * from UserType where IdUserType =:id');
  qry.Parameters.ParamByName('id').value := pIdUserType;
  qry.open();

  result := qry.fieldByName('System').AsBoolean;

  freeAndNil(qry);
end;

function TDM.getClientDatasetObject(arg_sql: String): TClientDataset;
var
   myAdoDataset: TADOQuery;
   myProvider: TDataSetProvider;
   myClientDataset: TClientdataset;
begin
   try
     myAdoDataset := TADOQuery.Create(self);
     MyAdodataset.Connection := ADODBConnect;
     MyAdoDataset.SQL.Text := arg_sql;

     myProvider := TDataSetProvider.Create(self);
     fTableName := GetSQLFirstTableName(arg_sql);
     mountProviderName(myProvider);
     myProvider.DataSet := myAdoDataset;

     myClientDataset := TClientDataSet.Create(self);
     myClientDataset.ProviderName := myProvider.Name;
     myClientDataset.FetchParams;

     result := myClientDataset;
   except on e: Exception do begin
             freeAndNil(myClientDataset);
             freeAndNil(myProvider);
             freeAndNil(myAdoDataset);

             raise Exception.Create('Fail to create object to access data: ' + e.Message);
          end;
   end;
end;

function TDM.searchInvoiceRefundSQL(arg_storeId: Integer): String;
begin
 result := 'SELECT'  +
      'I.IDPreSale,' +
      'I.IDInvoice,' +
      'I.PreSaleDate,' +
      'I.InvoiceDate,' +
      'I.SaleCode,'    +
      'I.InvoiceCode,' +
      'I.Note,'        +
      'P.PessoaFirstName,' +
      'P.PessoaLastName,'  +
      'P.Pessoa,' +
      'P.IDPessoa,' +

      '(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0)) as TotInvoice, ' +
      'I.IDTouristGroup,' +
      'I.OtherComissionID,' +
      '((IM.Qty * IM.SalePrice) - IM.Discount) as ItemTotal,' +
      'IM.IDInventoryMov,' +
      '(IM.Qty - IsNull(IM.QtyExchanged,0)) as Qty,' +
      'IM.CostPrice,' +
      'IM.SalePrice,' +
      'IM.Discount,'  +
      'M.IDModel,' +
      'M.Model,' +
      'M.Description,' +
      'M.DateLastCost,' +
      'M.LastCost,' +
      'V.IDPessoa as IDVendor,' +
      'V.Pessoa as Vendor,' +
      'IM.IDDepartment,' +
      'cast(0 as bit) as Retorno,' +
      'IM.PreInventoryMovID,' +
      '0 as Action,' +
      'IM.SalesTax ' +
      'FROM '  +
      'Invoice I (NOLOCK) ' +
      'LEFT JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa ' +

      'JOIN InventoryMov IM (NOLOCK) ON (IM.DocumentID = I.IDInvoice A ' +
        'ND IM.InventMovTypeID = 1) ' +
      'JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID) ' +

      'LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDModel ' +
        'l AND VendorOrder = 1) ' +
      'LEFT JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa) ' +
      'WHERE ' +
      'I.IDInvoice Is NOT NULL ' +
      'AND I.Canceled = 0 ' +
      'AND I.InvoiceCode = :Invoice ' +
      'AND IM.StoreID = :IDStore ' +
      'AND IM.Qty > 0 ' +
      'AND IM.ExchangeInvoice IS NULL ' +
      'AND IM.IDParentPack Is Null' ;
end;

function TDM.searchInvoiceRefundSQL: String;
begin
 result := 'SELECT'  +
      'I.IDPreSale,' +
      'I.IDInvoice,' +
      'I.PreSaleDate,' +
      'I.InvoiceDate,' +
      'I.SaleCode,'    +
      'I.InvoiceCode,' +
      'I.Note,'        +
      'P.PessoaFirstName,' +
      'P.PessoaLastName,'  +
      'P.Pessoa,' +
      'P.IDPessoa,' +

      '(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0)) as TotInvoice, ' +
      'I.IDTouristGroup,' +
      'I.OtherComissionID,' +
      '((IM.Qty * IM.SalePrice) - IM.Discount) as ItemTotal,' +
      'IM.IDInventoryMov,' +
      '(IM.Qty - IsNull(IM.QtyExchanged,0)) as Qty,' +
      'IM.CostPrice,' +
      'IM.SalePrice,' +
      'IM.Discount,'  +
      'M.IDModel,' +
      'M.Model,' +
      'M.Description,' +
      'M.DateLastCost,' +
      'M.LastCost,' +
      'V.IDPessoa as IDVendor,' +
      'V.Pessoa as Vendor,' +
      'IM.IDDepartment,' +
      'cast(0 as bit) as Retorno,' +
      'IM.PreInventoryMovID,' +
      '0 as Action,' +
      'IM.SalesTax ' +
      'FROM '  +
      'Invoice I (NOLOCK) ' +
      'LEFT JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa ' +

      'JOIN InventoryMov IM (NOLOCK) ON (IM.DocumentID = I.IDInvoice A ' +
        'ND IM.InventMovTypeID = 1) ' +
      'JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID) ' +

      'LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDModel ' +
        'l AND VendorOrder = 1) ' +
      'LEFT JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa) ' +
      'WHERE ' +
      'I.IDInvoice Is NOT NULL ' +
      'AND I.Canceled = 0 ' +
      'AND I.InvoiceCode = :Invoice ' +
      'AND IM.Qty > 0 ' +
      'AND IM.ExchangeInvoice IS NULL ' +
      'AND IM.IDParentPack Is Null' ;
end;

function TDM.searchInvoiceItemsSQL(arg_idInventoryMov: Integer): String;
begin
  result :=
      'SELECT' +
      ' I.IDPreSale,' +
      ' I.IDInvoice,' +
      ' I.PreSaleDate,' +
      ' I.InvoiceDate,' +
      ' I.SaleCode,' +
      ' I.InvoiceCode,' +
      ' I.Note,' +
      ' P.PessoaFirstName,' +
      ' P.PessoaLastName,' +
      ' P.Pessoa,' +
      ' P.IDPessoa,' +

      ' (I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.AditionalExpenses, 0)) as TotInvoice,' +
      ' I.IDTouristGroup,' +
      ' I.OtherComissionID,' +
      ' ((PIM.Qty * PIM.SalePrice) - PIM.Discount) as ItemTotal,' +
      ' 0 as IDInventoryMov,' +
      ' ABS(PIM.Qty) as Qty,' +
      ' PIM.CostPrice,' +
      ' PIM.SalePrice,' +
      ' PIM.Discount,' +
      'M.IDModel,' +
      'M.Model,' +
      'M.Description,' +
      'M.DateLastCost,' +
      'M.LastCost,' +
      'V.IDPessoa as IDVendor,' +
      'V.Pessoa as Vendor,' +
      'PIM.IDDepartment,' +
      'cast(0 as bit) as Retorno,' +
      'PIM.IDPreInventoryMov as PreInventoryMovID,' +
      '0 as Action' +
      ' FROM' +
      'Invoice I ' +
      ' LEFT JOIN Pessoa P ON I.IDCustomer = P.IDPessoa' +
      ' JOIN PreInventoryMov PIM ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)' +
      ' JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)' +
      ' LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (MV.IDModel = M.IDModel AND VendorOrder = 1)' +
      ' LEFT JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa)' +
      ' WHERE ' +
      'PIM.IDPreInventoryMov = :IDPreInventoryMov';
end;

function TDM.insertRepair(arg_item: TClientDataset): boolean;
var
   insertRepair: TClientDataset;
begin
  result := false;
  try
     insertRepair := getClientDatasetObject(insertRepairSQL);

     insertRepair.Params.ParamByName('idrepair').Value := GetNextID('Repair.IdRepair');

     insertRepair.Params.ParamByName('idmodel').Value := arg_item.fieldByName('IdModel').Value;
     insertRepair.Params.ParamByName('idStore').Value := arg_item.fieldByname('IdStore').Value;

     insertRepair.params.ParamByName('fase').Value := arg_item.fieldByname('Fase').Value;
     insertRepair.Params.ParamByName('sentdate').Value := arg_item.FieldByName('SentDate').Value;

     insertRepair.Params.ParamByName('idfornecedor').Value := arg_item.fieldByname('IdFornecedor').Value;

     insertRepair.Params.ParamByName('tiporepair').Value := arg_item.fieldByname('TipoRepair').Value;
     insertRepair.Params.ParamByName('IdUserSent').Value := arg_item.fieldByname('IdUserSent').Value;

     insertRepair.Params.ParamByName('serialnumber').Value := arg_item.fieldByname('SerialNumber').value;

     insertRepair.Params.ParamByName('desativado').Value := 0;
     insertRepair.Params.ParamByName('iddefecttype').Value := arg_item.fieldByname('IdDefectType').Value;
     insertRepair.Params.ParamByName('qty').Value := arg_item.fieldByname('qty').Value;
     insertRepair.Params.ParamByName('tipo').Value := arg_item.fieldByname('Tipo').Value;


     insertRepair.Execute();

     result := true;
  except on e: Exception do
     raise;
  end;
end;

function TDM.searchModel(arg_IdModel: Integer): TClientDataset;
begin
  result := getClientDatasetObject(searchModelByIdModelSQL());
  result.Params.ParamByName('Idmodel').Value := arg_IdModel;
  result.Open;

end;

function TDM.searchModel(arg_model: String): TClientDataset;
begin
  result := getClientDatasetObject(searchModelByModelSQL());
  result.Params.ParamByName('model').Value := arg_model;
  result.Open;

end;

function TDM.searchModelByIdModelSQL(): String;
begin
   result := 'select * from Model where Idmodel = :Idmodel';
end;

function TDM.searchModelByModelSQL(): String;
begin
   result := 'select * from Model where model = :model';
end;

function TDM.searchModel: TClientDataset;
begin
  result := getClientDatasetObject(searchModelSQL());
  result.Open;
end;

function TDM.searchModelSQL(): String;
begin
  result := 'select * from Model';

end;


function TDM.searchDefectType: TClientDataset;
begin
  result := getClientDatasetObject(searchDefectTypeSQL());
  result.Open;
end;

function TDM.searchDefectTypeSQL: String;
begin
  result := 'select IDDefectType, DefectType from Inv_DefectType';
end;

function TDM.searchInvoiceRefund: TClientDataset;
begin

end;

function TDM.searchInvoiceRefund(arg_storeId: Integer): TClientDataset;
begin

end;

function TDM.searchVendor(arg_idModel: Integer): TClientDataset;
begin

end;

function TDM.searchVendor: TClientDataset;
begin
  result := getClientDatasetObject(searchVendorSQL());
  result.Open;
end;

function TDM.searchVendorSQL: String;
var
  sql: TstringList;
begin
  try
    sql := TStringList.Create();
    sql.Add('select');
    sql.add(' IdFornecedor');
    sql.add(', IdFornecedor as IdPessoa');
    sql.add(', Fornecedor');
    sql.add(', Code');
    sql.Add(' from');
    sql.Add(' vwFornecedor');
    sql.add(' order by');
    sql.add(' Fornecedor');
    result := String(sql.GetText);

  finally
    freeAndNil(sql);
  end;

end;

function TDM.searchVendorByIdModelSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create();
     sql.Add('select *');
     sql.add(' from PurchaseItem p');
     sql.add(' join vwFornecedor v on p.IdFornecedor = v.IdFornecedor');
     sql.Add(' join Model m on p.IdModel = m.IdModel');
     sql.add(' where m.Idmodel = :idmodel');

     result := String(sql.GetText);
  finally
     freeAndNil(sql);
  end;

end;

function TDM.searchInvoiceItems(arg_idInventoryMov: Integer): TClientDataset;
begin

end;

function TDM.getRepairEmptyRecordSQL: String;
var
   sql: TStringList;
begin
   try
     sql := TStringList.Create();
     sql.Add('select r.IdRepair, r.fase, r.SentDate, m.IdModel, m.Model');
     sql.add(',r.TipoRepair, m.Description, p.Pessoa, ');
     sql.add(' r.qty * r.lastCost as cost, r.qty,');
     sql.add(' r.serialNumber, r.defect, r.ReturnDate, r.IdUserSent,');
     sql.Add('s.Name as Store, r.IdFornecedor, r.IdStore, r.IdDefectType, r.tipo');
     sql.add('from Repair r ');
     sql.add(' left outer join Pessoa p on r.idfornecedor = p.idPessoa');
     sql.add(' join Model m on m.idModel = r.idModel');
     sql.add(' join Store s on s.idStore = r.idStore');
     sql.add(' where r.tipo = 2');
     sql.add(' and m.ModelType in (''R'', ''S'')');
     sql.add(' and r.IdRepair = -1');

     result := String(sql.GetText);
   finally
     freeAndNil(sql);
   end;

end;

function TDM.getRepairEmptyRecord: TClientDataset;
begin
   result := getClientDatasetObject(getRepairEmptyRecordSQL);
   result.Open();
end;

function TDM.searchVendor(arg_vendor: String): TClientDataset;
begin
   result := getClientDatasetObject(searchVendorByVendorSQL());
   result.Params.ParamByName('vendor').Value := arg_vendor;
   result.Open();
end;

function TDM.searchVendorByVendorSQL: String;
var
  sql: TstringList;
begin
  try
    sql := TStringList.Create();
    sql.Add('select');
    sql.add(' IdFornecedor');
    sql.add(', IdFornecedor as IdPessoa');
    sql.add(', Fornecedor');
    sql.add(', Code');
    sql.Add(' from');
    sql.Add(' vwFornecedor');
    sql.add(' order by');
    sql.add(' Fornecedor');
    sql.add(' where');
    sql.Add(' fornecedor = :vendor');
    result := String(sql.GetText);

  finally
    freeAndNil(sql);
  end;
end;

function TDM.insertRepairSQL: String;
var
  sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.Add('insert into Repair');
      sql.add(' (IdRepair, IdModel, IdStore, Fase, SentDate, IdFornecedor, TipoRepair, IdUserSent, serialNumber, Desativado, IdDefectType, Qty, Tipo)');
      sql.add(' values (:idrepair, :idmodel, :idstore, :fase, :sentdate, :idfornecedor, :tiporepair, :idusersent, :serialnumber, :desativado, :iddefecttype, :qty, :tipo)');
      result := String(sql.getText);
   finally
      freeAndNil(sql);
   end;
end;

procedure TDM.mountProviderName(arg_provider: TDatasetProvider);
var
  myProviderName: String;
  validProviderName: Boolean;
  counter: Integer;
begin
  try
     counter := 0;
     validProviderName := false;
     while ( not validProviderName ) do begin
         myProviderName := 'provider_'+ fTableName + '_' + inttoStr(counter);
         try
            arg_provider.Name := myProviderName;
            validProviderName := true;
         except
            inc(counter);
         end;
     end;
  except
     raise;
  end;

end;

function TDM.updateModelAddQuantityOnHand(arg_record: TClientDataset): Boolean;
var
   update: TClientDataset;
begin
   try
      update := getClientDatasetObject(updateModelAddQuantityOnHandSQL);
      update.Params.ParamByName('idmodel').Value := arg_record.fieldByname('IdModel').value;
      update.Params.ParamByName('qtyonhand').Value := arg_record.fieldByname('TotqtyOnHand').Value;
      update.Execute();
   except on e: Exception do
      raise;
   end;
end;

function TDM.updateModelAddQuantityOnHandSQL: String;
begin
   result := 'update Model set TotQtyOnHand = (TotQtyOnHand + :qtyonhand) where Idmodel = :idmodel';
end;

function TDM.searchInventory(arg_idmodel: Integer): TClientDataset;
begin
   result := getClientDatasetObject(searchInventorySQL(arg_idmodel));
   result.Params.ParamByName('ModelID').Value := arg_idmodel;
   result.Open();
end;

function TDM.searchInventorySQL(arg_idmodel: Integer): String;
begin
  result := 'select * from Inventory where ModelID = :modelid';
end;


function TDM.searchSysModuleSQL(): String;
begin
   result := 'select * from sys_module';
end;

function TDM.searchSysModule(): TClientDataset;
begin
  result := getClientDatasetObject(searchSysModuleSQL());
  result.Open();
end;

function TDM.searchPreserialMovInInventoryMovSQL(arg_documentInvoice: Integer): String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.add('SELECT IM.IDInventoryMov, IM.Qty, IM.SalePrice, IM.DocumentID, PSM.SerialNumber, PSM.IdentificationNumber, PSM.IsIssued');
      sql.Add(' FROM PreSerialMov PSM');
      sql.Add(' JOIN InventoryMov IM ON (PSM.PreInventoryMovID = IM.PreInventoryMovID) ');
      sql.Add(' WHERE IM.DocumentID = :IDInvoice AND IM.InventMovTypeID = 1 ');
      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;

end;

function TDM.searchPreserialMovInInventoryMov(
  arg_documentInvoice: Integer): TClientdataset;
begin
  result := getClientDatasetObject(searchPreserialMovInInventoryMovSQL(arg_documentInvoice));
  result.Params.ParamByName('IDInvoice').Value := IntToStr(arg_documentInvoice);
  result.Open();
end;

function TDM.searchPreserialMovEmptySQL: String;
begin
  result := 'select *, cast(''Invoice'' as varchar(20)) as Invoice from PreserialMov where PreInventoryMovID = -1';
end;

function TDM.searchPreserialMovEmpty: TClientDataset;
begin
   result := getClientDatasetObject(searchPreserialMovEmptySQL);
   result.Open();
   result.FieldByName('Invoice').ReadOnly := false;
end;

function TDM.searchPreserialMovSQL: String;
begin
  result := 'select * from PreserialMov';
end;

function TDM.searchPreserialMov: TClientDataset;
begin
  result := getClientDatasetObject(searchPreserialMovSQL);
  result.Open();
end;

function TDM.getPresaleByModelSQL(arg_document: String; arg_IdModel: Integer): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.create;
     sql.Add('SELECT 	ModelID, M.CaseQty, M.Model, Description,');
     sql.add('			 (SELECT dbo.SalesPersonPreInvMov(IDPreInventoryMov)) AS SalesPerson,');
     sql.add('			M.SuggRetail, SU.IDUser, 0 as IDComission, Qty,	ExchangeInvoice, SalePrice, CostPrice, PIM.Discount,');
     sql.add('       PIM.IDPreInventoryMov IDInventoryMov, TG.SerialNumber,');
     sql.add('			(CASE');
     sql.add('				  WHEN (TC.SpecialDateStart <= :startDate) AND');
     sql.Add('             (TC.SpecialDateEnd >= :endDate) AND');
     sql.add('					( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0)) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0))');
     sql.Add('				  ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0))');
     sql.add('        END) as Tax,');
     sql.add('			 SZ.CodSize,	SZ.SizeName, CL.CodColor, CL.Color,	M.NotVerifyQty,	PIM.IDDepartment,TG.RequestCustomer,');
     sql.add('			 TG.PuppyTracker, PIM.Promo,	M.SellingPrice,	PIM.IDPreInventoryMovParent as IDMovParent,	D.Department,');
     sql.add('			 isnull(CD.Discount, 0) as DiscountLoyalt, isNull(PIM.UnitDiscount, 0) as UnitDiscount');
     sql.add('from ');
     sql.Add('			 PreInventoryMov PIM (NOLOCK)');
     sql.add('	  JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )');

     sql.Add('	 LEFT OUTER JOIN InvSize SZ (NOLOCK) ON (M.IDSize = SZ.IDSize)');
     sql.add('	 LEFT OUTER JOIN InvColor CL (NOLOCK) ON (M.IDColor = CL.IDColor)');
     sql.add('	 JOIN SystemUser SU (NOLOCK) ON ( SU.IDUser = PIM.UserID )');
     sql.add('	 JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )');
     sql.add('	 JOIN StoreToTabGroup STC (NOLOCK) ON STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup');
     sql.add('	 LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))');
     sql.Add('  LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STC.IDSaleTax )');
     sql.add('  LEFT OUTER JOIN Inv_Department D (NOLOCK) ON (PIM.IDDepartment = D.IDDepartment)');
     sql.add('  LEFT OUTER JOIN Pessoa P (NOLOCK) ON PIM.IDPessoa = P.IDPessoa');
     sql.add('  LEFT OUTER JOIN Ent_CustomerDiscount CD (NOLOCK) ON (CD.IDGroup = M.GroupID) AND (CD.IDTipoPessoa = P.IDTipoPessoa)');
     sql.add('WHERE ');
     sql.add('     PIM.DocumentID = :documentID');
     sql.add(' AND PIM.InventMovTypeID IN (1,25)');
     sql.add(' AND PIM.IDParentPack Is Null');
     sql.add(' AND m.IDModel = :idModel');

     result := String(sql.GetText);

  finally
     freeAndNil(sql);
  end;
end;

function TDM.getPresaleByModel(arg_document: String; arg_IdModel: Integer): TClientDataset;
begin
   result := getClientDatasetObject(getPresaleByModelSQL(arg_document, arg_IdModel));
   result.Params.ParamByName('documentId').Value := arg_document;
   result.Params.ParamByName('startDate').value := now;
   result.params.parambyname('endDate').Value := now;
   result.params.ParamByName('idModel').Value := arg_idModel;
   result.Open();
end;

function TDM.getStoredProcObject(arg_procedureName: String): TADOStoredProc;
var
  myStoredProc: TADOStoredProc;
begin
  try
      myStoredProc := TADOStoredProc.Create(self);
      myStoredProc.Connection := dm.ADODBConnect;
      myStoredProc.ProcedureName := arg_procedureName;

      result := mystoredProc;

   except on e: Exception do begin
             freeAndNil(myStoredProc);
             raise Exception.Create('Fail to create object-stored to access data: ' + e.Message);
          end;

  end;
end;

function TDM.callSpCreateHold(arg_list: TStringList): TADOStoredProc;
var
  procName: String;
begin
    procName := 'sp_PreSale_CreateHold;1';
    result := getStoredProcObject(procName);
//    result.Parameters.ParamByName(@)

end;

function TDM.getSaleItemRepairSQL(): String;
begin
  result := 'select  * from Sal_ItemRepair where IDItemRepair = -1';
end;

function TDM.returnToVendor(arg_Item: TClientDataset): Boolean;
var
  qryInsertItem: TADOQuery;
begin
  try
     qryInsertItem := TADOQuery.Create(nil);
     qryInsertItem.Connection := dm.ADODBConnect;
     qryInsertItem.SQL.Text := returnToVendorSQL();
     qryInsertItem.Parameters.ParamByName('IDItemRepair').Value := DM.GetNextID(MR_DEFECT_TYPE_ID);
     qryInsertItem.Parameters.ParamByName('IDPreInventoryMov').Value := arg_item.fieldByName('IDPreInventoryMov').Value;
     qryInsertItem.Parameters.paramByName('Obs').Value := arg_item.fieldByName('Obs').Value;
     qryInsertItem.Parameters.ParamByName('IDDefectType').Value := arg_item.fieldByName('IDDefectType').Value;
     qryInsertItem.Parameters.ParamByName('RA').Value := arg_item.fieldByname('RA').Value;
     qryInsertItem.Parameters.paramByName('IDVendor').Value := arg_item.fieldByName('IDVendor').Value;

     qryInsertItem.ExecSQL();
  except
     on e: Exception do begin
        raise Exception.Create('fail to insert item ' + e.message);
     end;
  end;

end;

function TDM.returnToVendorSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('Insert Sal_ItemRepair (IDItemRepair, IDPreInventoryMov, Obs, IDDefectType, RA, IDVendor)');
     sql.add('values (:IDItemRepair, :IDPreInventoryMov, :Obs, :IDDefectType, :RA, :IDVendor)');
  finally
     result := String(sql.GetText);
  end;

end;

function TDM.getSaleItemRepair(arg_item: TClientDataset): TClientDataset;
begin
   result := getClientDatasetObject(getSaleItemRepairSQL());
   result.open;
end;

function TDM.getOnePreInventoryMovSQL(arg_idPreInventoryMov: Integer): String;
var
  sql: TStringList;
begin
   try
     sql := TStringList.Create;
     sql.add('select pim.*, m.model, m.description from PreInventoryMov pim');
     sql.Add(' join Model m on pim.ModelID = m.IdModel');
     sql.Add(' where IdPreInventoryMov = :par_id' );
     result := String(sql.gettext);
   finally
      freeAndNil(sql);
   end;
end;

function TDM.getOnePreInventoryMov(arg_idPreinventoryMov: Integer): TClientDataset;
begin
  result := getClientDatasetObject(getOnePreInventoryMovSQL(arg_idPreInventoryMov));
  result.Params.ParamByName('par_id').Value := arg_idPreInventoryMov;
  result.Open;

end;

function TDM.getPaymentWaySQL(arg_payMethod: String): String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.Add('select * from MeioPag where upper(MeioPag) = :param_meioPag');
      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;
end;

function TDM.getPaymentWay(arg_payMethod: String): TClientDataset;
begin
  result := getClientDatasetObject(getPaymentWaySQL(arg_payMethod));
  result.Params.ParamByName('param_meioPag').Value := arg_payMethod;
  result.Open;

end;


function TDM.getPaymentWaySQL(arg_idpayMethod: Integer): String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.Add('select * from MeioPag where IdMeioPag = :param_idMeioPag');
      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;
end;

function TDM.getPaymentWay(arg_IdpayMethod: Integer): TClientDataset;
begin
  result := getClientDatasetObject(getPaymentWaySQL(arg_IdpayMethod));
  result.Params.ParamByName('param_idMeioPag').Value := arg_IdpayMethod;
  result.Open;
end;

function TDM.searchSaleAccountCardSQL(arg_number: String): String;
begin
  result := 'select * from Sal_AccountCard where CardNumber = :arg_number';
end;

function TDM.searchSaleAccountCard(arg_number: String): TClientDataSet;
begin
 result := dm.getClientDatasetObject(searchSaleAccountCardSQL(arg_number));
 result.Params.ParamByName('arg_number').Value := arg_number;
 result.open;
end;

function TDM.isInactiveSameCategory(arg_name: String): Boolean;
var
   objCategoryCds: TClientDataset;
begin
   result := false;
   try
     objCategoryCds := searchInactiveCategory(upperCase(arg_name));
     result := ( objCategoryCds.RecordCount > 0 );
   finally
     freeAndNil(objCategoryCds);
   end;
end;

function TDM.searchInactiveCategory(arg_name: String): TClientDataset;
begin
	result := getClientDatasetObject(searchInactiveCategorySQL(arg_name));
   result.Params.ParamByName('param_name').Value := arg_name;
   result.open;
end;

function TDM.searchInactiveCategorySQL(arg_name: String): String;
var
   sql: TStringList;
begin
   try
     sql := TStringList.Create;
     sql.add('select UPPER(Name) CapName, *');
     sql.add('from tabgroup');
     sql.add('where upper(name) = :param_name');
     sql.Add('and desativado = 1');
     result := String(sql.GetText);
   finally
     freeAndNil(sql);
   end;

end;

function TDM.activateCategorySQL(arg_name: String): String;
var
  sql: TStringList;
begin
  try
    sql := TStringList.Create;
    sql.Add('update TabGroup set desativado = 0');
    sql.add('where name = :param_name');
    result := String(sql.GetText);

  finally
    freeAndNil(sql);
  end;
end;

function TDM.activateCategory(arg_name: String): Boolean;
var
  objUpdate: TClientDataset;
begin
  try
    try
      dm.ADODBConnect.BeginTrans;
      objUpdate := getClientDatasetObject(activateCategorySQL(arg_name));
      objUpdate.Params.ParamByName('param_name').value := arg_name;
      objUpdate.Execute;
      dm.ADODBConnect.CommitTrans;
      result := true;
    except
      dm.ADODBConnect.RollbackTrans;
      MessageDlg('Trying to activated category failed.',mtError, [mbOK], 0);
      result := false;
    end;
  finally
     freeAndNil(objUpdate);
  end;
end;

function TDM.activateCategory(arg_id: Integer): Boolean;
begin
// to be implemented
end;


function TDM.createMercuryPaymentType(arg_idPaymentType: Integer): Integer;
var
  anyGiftCardPayment: TClientDataset;
  anyMercury: TClientDataset;
begin
  result := 0;

  case ( dm.fMRMercury.FGiftProcessor ) of
      0 : result := 0;
      1 : begin
          if ( isGiftCardPaymentType(arg_idPaymentType) ) then begin
             result := 0;
          end
          else if ( isGiftMercuryPaymentType(arg_idPaymentType)) then begin
                  result := arg_idPaymentType;
          end
          else begin
               result := dealMercuryPaymentType(arg_idPaymentType);
          end;

      end;

      2: begin
         if ( isGiftMercuryPaymentType(arg_idPaymentType) ) then begin
                  result := arg_idPaymentType;
         end
         else begin
              result := dealMercuryPaymentType(arg_idPaymentType);
         end;

      end;

  end;
end;

function TDM.insertMercuryGiftPaymentTypeSQL: String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.Add('insert into MeioPag(IdMeioPag, IdLancamentoTipo, MeioPag, ParentType, PayOnCashRegClose, desativado, hidden)');
     sql.add('values (:param_IdMeioPag, :param_IdLancamentoTipo, :param_MeioPag, :param_ParentType, :param_PayOnCashRegClose,');
     sql.add(':param_desativado, :param_hidden)');
     result := String(sql.GetText);
  finally
     freeAndNil(sql);
  end;

end;

function TDM.insertMercuryGiftPaymentType(arg_PaymentType: TClientDataset): Integer;
const PAYMENT_TYPE_DESCRIPTION = 'Mercury Gift Card';
var
  paymentType: TClientDataset;
begin
   try
     try
       paymentType := getClientDatasetObject(insertMercuryGiftPaymentTypeSQL);
       paymentType.Params.ParamByName('param_IdMeioPag').AsInteger := GetNextID('MeioPag.IdMeioPag');
       paymentType.Params.ParamByName('param_IdLancamentoTipo').AsInteger := arg_PaymentType.fieldByName('IdLancamentoTipo').Value;
       paymentType.Params.ParamByName('param_MeioPag').AsString := PAYMENT_TYPE_DESCRIPTION;
       paymentType.Params.ParamByName('param_ParentType').AsInteger := arg_PaymentType.fieldByName('IdLancamentoTipo').Value;
       paymentType.Params.ParamByName('param_PayOnCashRegClose').AsInteger := arg_PaymentType.fieldByName('IdLancamentoTipo').Value;
       paymentType.Params.ParamByName('param_desativado').AsInteger := arg_PaymentType.fieldByName('IdLancamentoTipo').Value;
       paymentType.Params.ParamByName('param_hidden').AsInteger := arg_PaymentType.fieldByName('IdLancamentoTipo').Value;
       paymentType.Execute;
       result := paymentType.Params.ParamByName('param_IdMeioPag').AsInteger;
     except
       result := 0;
     end;
   finally
       freeAndNil(paymentType);
   end;
end;

function TDM.getPaymentWaySQL: String;
begin
  result := 'select * from MeioPag';
end;

function TDM.getPaymentWay: TClientDataset;
var
  idPaymentTypeSelected: Integer;
  payMethod: TPayMethod;
begin
   result := getClientDatasetObject(getPaymentWaySQL);
   result.Open;

  // Antonio 03/31/2017
  FPayMethodList.FPayList.Clear();
  while ( not result.eof ) do begin
      payMethod := TpayMethod.Create();
      payMethod.SetIdType(result.FieldByName('idmeiopag').Value);

      if ( not result.fieldByName('tipo').IsNull ) then begin
          payMethod.SetIdBaseType(result.fieldByName('tipo').value);
      end;

      payMethod.SetNameType(Result.fieldByName('meiopag').Value);
      payMethod.SetInUse(not result.fieldByName('tipo').IsNull);

      FPayMethodList.AddPaymethodToList(payMethod);
      result.Next();
  end;

   idPaymentTypeSelected := selectAnyMercuryPaymentType(result);
   result.Filter := 'IdMeioPag = ' + intToStr(idPaymentTypeSelected);
   result.Filtered := true;
end;

function TDM.selectAnyMercuryPaymentType(arg_paymentType: TClientDataset): Integer;
begin
   // Antonio 2013 Oct 23, MR-74
   result := -999;
   arg_paymentType.Filter := format('upper(MeioPag) like %s', [quotedStr('%MERCURY%')]);
   arg_paymentType.Filtered := true;
   arg_paymentType.First;

   if ( not arg_paymentType.IsEmpty ) then
      result := arg_paymentType.fieldByName('IdMeioPag').value;
end;

function TDM.isGiftMercuryPaymentType(arg_idPaymentType: Integer): Boolean;
var
   paymentType: TClientDataset;
begin
   result := false;
   try
     paymentType := getClientDatasetObject(getPaymentWaySQL(arg_idPaymentType));
     paymentType.Params.ParamByName('param_IdMeioPag').AsInteger := arg_idPaymentType;
     paymentType.Open;
     result := ( pos('Mercury', paymentType.FieldByName('MeioPag').asString) > 0 ) ;

   finally
     freeAndNil(paymentType);
   end;

end;

function TDM.isGiftCardPaymentType(arg_idPaymentType: Integer): Boolean;
var
   paymentType: TClientDataset;
begin
   result := false;
   try
      paymentType := getClientDatasetObject(getPaymentWaySQL(arg_idPaymentType));
      paymentType.Params.ParamByName('param_IdMeioPag').AsInteger := arg_idPaymentType;
      paymentType.Open;

      paymentType.Filter := format('upper(MeioPag) like %s', [quotedStr('GIFT CARD%')]);
      paymentType.Filtered := true;
      paymentType.First;

      if ( not paymentType.IsEmpty ) then
        result := true;

   finally
      freeAndNil(paymentType);
   end;
end;

function TDM.dealMercuryPaymentType(arg_idPaymentType: Integer): Integer;
var
  anyMercury: TClientDataset;
  anyGiftCardPayment: TClientDataset;
begin
  if ( isGiftMercuryPaymentType(arg_idPaymentType)) then begin
          result := arg_idPaymentType;
  end
  else begin
       anyMercury := getPaymentWay();
       if ( anyMercury.IsEmpty ) then begin
          anyGiftCardPayment := getPaymentWay('GIFT CARD');
          result := insertMercuryGiftPaymentType(anyGiftCardPayment);
          freeAndNil(anyGiftCardPayment);
       end
       else begin
          result := anyMercury.fieldByName('IdMeioPag').asInteger;
       end;
       freeAndNil(anyMercury);
  end;

end;

function TDM.IsActiveSameCategory(arg_name: String): Boolean;
var
   objCategoryCds: TClientDataset;
begin
   result := false;
   try
     objCategoryCds := searchActiveCategory(upperCase(arg_name));
     result := ( objCategoryCds.RecordCount > 0 );
   finally
     freeAndNil(objCategoryCds);
   end;
end;

function TDM.searchActiveCategorySQL(arg_name: String): String;
var
   sql: TStringList;
begin
   try
     sql := TStringList.Create;
     sql.add('select UPPER(Name) CapName, *');
     sql.add('from tabgroup');
     sql.add('where upper(name) = :param_name');
     sql.Add('and desativado = 0');
     result := String(sql.GetText);
   finally
     freeAndNil(sql);
   end;
end;

function TDM.searchActiveCategory(arg_name: String): TClientDataset;
begin
	result := getClientDatasetObject(searchActiveCategorySQL(arg_name));
   result.Params.ParamByName('param_name').Value := arg_name;
   result.open;
end;

function TDM.getDbVersionSQL: String;
begin
  result := 'select buildno from Sys_Module';
end;

function TDM.getDbVersion: TClientDataset;
begin
  result := getClientDatasetObject(getDbVersionSQL);
  result.open();
end;

function TDM.getBuildDbVersion: Integer;
var
	objSysModule: TClientdataset;
begin
   try
      objSysModule := getDbVersion();
      result := objSysModule.fieldByName('buildno').Value;
   finally
      freeAndNil(objSysModule);
   end;
end;

function TDM.getSellingPriceAfterCustomerDiscount(arg_idPessoa: Integer; arg_sellingPrice: Double): Currency;
var
	customerDiscount: TClientDataset;
begin
   try
      customerDiscount := getClientDatasetObject(getCustomerDiscountSQL(arg_idPessoa));
      customerDiscount.Params.ParamByName('param_idPessoa').Value := arg_idPessoa;
      customerDiscount.open();

      // Antonio 2013 Nov 29, MR-123
      if ( not customerDiscount.FieldByName('discount').IsNull ) then
          result := arg_sellingPrice - (arg_sellingPrice * (customerDiscount.fieldByName('discount').Value / 100) )
      else
         result := 0;

   finally
      freeAndNil(customerDiscount);
   end;

end;

function TDM.getDiscountPromoItemList(arg_date: TDateTime): TClientDataset;
var
	promoOnDate: TClientDataset;
begin
  result := createDiscountPromoItemList();
  promoOnDate := getPromoSettingsOnDate(arg_date);

  while ( not promoOnDate.eof ) do begin
    result.Insert;
    result.fieldByname('IdStore').Value := promoOnDate.fieldByName('IdStore').Value;
    result.FieldByName('IdPromo').Value := promoOnDate.fieldByname('IdPromo').Value;
    result.fieldByName('IdPromoItem').Value := promoOnDate.fieldByName('IdPromoItem').Value;
    result.fieldByname('IsPromoActive').Value := true;
    result.fieldByName('IdModelPromo').value := promoOnDate.fieldByName('IdModel').value;
    result.fieldByName('discountPromo').Value := promoOndate.fieldByName('DiscountValue').value;
    result.fieldByName('discountType').value := promoOnDate.fieldByName('DiscountType').Value;
    result.fieldByname('discountCalculatedInPromo').value := false;
    result.post;
    promoOnDate.Next;
  end;

  result.open();

end;

function TDM.getCustomerDiscountSQL(arg_idPessoa: Integer): String;
var
	sql: TStringList;
begin
	try
      sql := TStringList.Create();
      sql.add('select p.idpessoa, p.idTipoPessoa, p.idStore, p.pessoaFirstName, p.pessoaLastName, cd.Discount, cd.IDGroup');
      sql.add('from Pessoa p');
      sql.add('join tipopessoa tp on p.IDTipoPessoa = tp.IDTipoPessoa');
      sql.add('join Ent_CustomerDiscount cd on tp.IDTipoPessoa = cd.IDTipoPessoa');
      sql.add('join TabGroup tg on cd.IDGroup = tg.IDGroup');
      sql.add('where p.idpessoa = :param_idPessoa');

      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;
end;

function TDM.getPromoSettingsOnDateSQL(arg_date: TDateTime): String;
var
	sql: TStringList;
begin
   try
      sql := TStringList.create();
      sql.add('from sal_promo p');
      sql.add('join Sal_PromoItem pi on p.IDPromo = pi.IDPromo');
      sql.add('left join Sal_PromoPrizeItem ppi on pi.IDPromoItem = ppi.IDPromoItem');
      sql.add('where p.Desativado = 0');
      sql.add('and (p.EndDate IS NULL) or p.EndDate >= :endDate');
      sql.add('and p.DaysOfWeek like :arg_daysOfWeek ');
      result := String(sql.getText);
   finally
      freeAndNil(sql);
   end;
end;

function TDM.createDiscountPromoItemList: TClientDataset;
begin
  result := TClientDataset.Create(nil);
  result.FieldDefs.Add('IdStore', ftInteger, 0, false);
  result.FieldDefs.add('IdPromo', ftInteger, 0, false);
  result.FieldDefs.add('IdPromoItem', ftInteger, 0, false);
  result.FieldDefs.Add('IsPromoActive', ftBoolean, 0, true);
  result.FieldDefs.add('IdModelPromo', ftInteger, 0, false);
  result.FieldDefs.Add('discountPromo', ftCurrency);
  result.FieldDefs.add('discountType', ftString, 2, false);
  result.FieldDefs.Add('discountCalculatedInPromo', ftBoolean, 0, true);
  result.FieldDefs.add('SalePrice', ftCurrency);
  result.CreateDataSet;
end;

function TDM.getPromoSettingsOnDate(arg_date: TDateTime): TClientDataset;
var
  dayOfWeekStr: String;
begin
	dayOfWeekStr := '%' + intToStr(dayOfWeek(arg_date)) + '%';
	result := getClientDatasetObject(getPromoSettingsOnDateSQL(now));
   result.Params.paramByName('arg_daysOfWeek').AsString := dayOfWeekStr;
   result.params.paramByName('endDate').Value := now;
   result.Open();
end;

function TDM.getCostToPO(arg_idModel, arg_idVendor: Integer): Double;
var
  vendor: TClientdataset;
  model: TClientDataset;
  cost : Double;
begin
  cost := 0;
  vendor := getVendorFromModel(arg_idModel, arg_idVendor);
  if ( not vendor.IsEmpty ) then begin
     if ( vendor.fieldByName('caseQty').IsNull or vendor.fieldByName('caseQty').Value = 0 ) then begin
        if ( not vendor.fieldByName('VendorCost').IsNull and vendor.fieldByName('VendorCost').Value > 0 ) then begin
           cost := vendor.fieldByName('vendorCost').value;
           freeAndNil(vendor);
        end;
     end
     else begin
        cost := vendor.fieldByName('VendorCost').value;
     end;
  end
  else begin
     model := getCostFromModel(arg_idModel);
     if ( not model.fieldByname('vendorCost').IsNull and model.FieldByName('VendorCost').value > 0 ) then begin
        cost := model.fieldByname('vendorCost').value;
        freeAndNil(model);
     end;
  end;

  result := cost;

end;

function TDM.getCostFromModelSQL(arg_idModel: Integer): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.create();
     sql.add('select VendorCost from Model');
     sql.add('where IdModel =:idmodel');
     result := String(sql.getText);

  finally
     freeAndNil(sql);
  end;

end;

function TDM.getVendorFromModelSQL(arg_idModel, arg_idVendorCost: Integer): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.create();
     sql.add('select CaseQty, VendorCost from Inv_ModelVendor');
     sql.add('where IdPessoa =:vendor and IdModel =:idmodel');
     result := String(sql.getText);

  finally
     freeAndNil(sql);
  end;

end;

function TDM.getCostFromModel(arg_idmodel: Integer): TClientdataset;
begin
  result := getClientDatasetObject(getCostFromModelSQL(arg_idModel));
  result.params.ParamByName('idmodel').value := arg_idmodel;
  result.Open;
end;

function TDM.getVendorFromModel(arg_idmodel,
  arg_idvendor: Integer): TClientDataset;
begin
  result := getClientDatasetObject(getVendorFromModelSQL(arg_idModel, arg_idVendor));
  result.Params.ParamByName('vendor').Value := arg_idVendor;
  result.params.ParamByName('idmodel').value := arg_idmodel;
  result.Open;
end;

function TDM.getCustomerDiscount(arg_idpessoa: Integer): Double;
begin

end;

function TDM.getPromoItemsHigherPrice(arg_idPromo,
  arg_vendorOrder: Integer): TClientDataset;
begin
    result := getClientDatasetObject(getPromoYProductSQL(arg_idPromo, arg_vendorOrder));
    result.Params.ParamByName('param_vendor').value := arg_vendorOrder;
    result.params.paramByName('param_idpromo').value := arg_idpromo;
    result.open;
end;

function TDM.getPromoYProductSQL(arg_idPromo, arg_vendorOrder: Integer): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.create();
     sql.add('SELECT SP.IDPromo,');
     sql.add('SP.IDPromoItem,');
     sql.add('SPPI.IDModel,');
     sql.add('M.Model,');
     sql.Add('description,');
     sql.Add('M.SellingPrice as ASalePrice');
     sql.Add('FROM Sal_PromoItem SP');
     sql.add('     JOIN Sal_PromoPrizeItem SPPI ON SP.IDPromoItem = SPPI.IDPromoItem');
     sql.Add('     JOIN Model M ON (M.IDModel = SPPI.IDModel)');
     sql.add('     JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
     sql.add('		 LEFT OUTER JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGroup)');
     sql.add('     LEFT OUTER JOIN ModelSubGroup MGS ON (M.IDModelSubGroup = MGS.IDModelSubGroup)');
     sql.add('     LEFT JOIN Inv_ModelVendor IMV ON (M.IDModel = IMV.IDModel AND IMV.VendorOrder = :param_vendor)');
     sql.add('     LEFT JOIN Pessoa V ON (IMV.IDPessoa = V.IDPessoa)');
     sql.add('     LEFT OUTER JOIN Pessoa F ON (M.IDFabricante = F.IDPessoa)');
     sql.add('Where SP.IDPromo = :param_idpromo');
     sql.add('order by m.sellingPrice desc');
     result := String(sql.getText);

  finally
     freeAndNil(sql);
  end;
end;

function TDM.callSpTagDelete(arg_idTag: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_Tag_Delete';
    result := getStoredProcObject(procName);
    result.Parameters.Refresh();
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagModelCount(): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagModelCounts';
    result := getStoredProcObject(procName);
    result.Open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagModelDelete(arg_idTagModel: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagModel_Delete';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@PKTagModel', ftInteger, pdInput, 0, arg_idTagModel);
    result.Parameters.ParamByName('@PKTagModel').Value := arg_idTagModel;
    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagModelSelect(arg_idTagModel: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagModel_Select';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@PKTagModel', ftInteger, pdInput, 0, arg_idTagModel);
    result.Parameters.ParamByName('@PKTagModel').Value := arg_idTagModel;
    result.Open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagModelUpSert(arg_idTag, arg_idModel: Integer): TADOStoredProc;
var
  procName: String;
  pkTagModel: Integer;
begin
  try
    procName := 'sp_TagModel_Upsert';
    result := getStoredProcObject(procName);
    result.parameters.refresh();
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.Parameters.paramByName('@IDModel').Value := arg_idModel;
    result.Parameters.ParamByName('@Active').Value := 1; // = true = Activated

    result.ExecProc;

    pkTagModel := result.Parameters.paramByName('@PKTagModel').Value;

  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagQtyDiscountBreakDelete(arg_idTag: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagQtyDiscountBreak_Delete';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagQtyDiscountBreakSelect(arg_idTag: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagQtyDiscountBreak_Select';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagQtyDiscountBreakUpSert(arg_idDiscount, arg_idTag, arg_minQty: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagQtyDiscountBreak_Upsert';
    result := getStoredProcObject(procName);

    result.Parameters.CreateParameter('@IDDiscount', ftInteger, pdInput, 0, arg_idDiscount);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
    result.Parameters.CreateParameter('@MinQty', ftInteger, pdInput, 0, arg_minQty);

    result.Parameters.ParamByName('@IDDiscount').Value := arg_idDiscount;
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.Parameters.paramByName('@MinQty').Value := arg_minQty;

    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagQtyPriceBreakDelete(arg_idTag: Integer; arg_minQty: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagQtyPriceBreak_Delete';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
    result.Parameters.CreateParameter('@MinQuantity', ftInteger, pdInput, 0, arg_minQty);

    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.Parameters.ParamByName('@MinQuantity').Value := arg_minQty;

    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagQtyPriceBreakSelect(arg_idTag: Integer): TADOStoredProc;
var
  procName: String;
  param: TParam;
begin
  try
    procName := 'sp_TagQtyPriceBreak_Select';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
//    result.Parameters.CreateParameter('@MinQuantity', ftInteger, pdInput, 0, arg_minQty);
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
//    result.parameters.ParamByName('@MinQuantity').Value := arg_minQty;
    result.open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagQtyPriceBreakUpSert(arg_discount: Currency; arg_idTag, arg_minQty: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagQtyPriceBreak_Upsert';
    result   := getStoredProcObject(procName);

    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
    result.Parameters.CreateParameter('@MinQty', ftInteger, pdInput, 0, arg_minQty);
    result.Parameters.CreateParameter('@Discount', ftCurrency, pdInput, 0, arg_discount);

    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.Parameters.paramByName('@MinQty').Value := arg_minQty;
    result.Parameters.ParamByName('@Discount').Value := arg_discount;

    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;

end;

function TDM.callSpTagSelect(arg_idTag: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_Tag_Select';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInput, 0, arg_idTag);
    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;
    result.open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagsForModel(arg_idModel: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_TagsForModel';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDModel', ftInteger, pdInput, 0, arg_idModel);
    result.Parameters.ParamByName('@IDModel').Value := arg_idModel;
    result.open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpTagUpSert(out arg_idTag: Integer; arg_tagName, arg_oper: String): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_Tag_Upsert';
    result := getStoredProcObject(procName);
    result.Parameters.CreateParameter('@IDTag', ftInteger, pdInputOutput, 0, arg_idTag);
    result.Parameters.CreateParameter('@TagName', ftString, pdInput, 50, arg_tagName);


    result.Parameters.ParamByName('@IDTag').Value := arg_idTag;

    if ( arg_oper = 'I' ) then
       result.Parameters.ParamByName('@IDTag').Value := NULL;

    result.Parameters.ParamByName('@TagName').Value := arg_tagName;
    result.ExecProc;


    if ( arg_oper = 'I' ) then begin
       arg_idTag := result.Parameters.paramByName('@IDTag').Value;
    end;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.getIDTagSQL(arg_tagName: String): String;
begin
   result := 'select IdTag from Tag where TagName = :param_tagname';
end;

function TDM.getIDTag(arg_tagName: String): TClientDataset;
begin
  result := getClientDatasetObject(getIDTagSQL(arg_tagName));
  result.Params.ParamByName('param_tagName').Value := arg_tagName;
  result.open;
end;

function TDM.getTagModelRegistryAttNameSQL(arg_attributeName: String): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create();
     sql.add('select * from Sis_Registry');
     sql.add('where cast(AttributeName as varchar(8000)) = :param_attributeName');
     result := String(sql.GetText);
  finally
     freeAndNil(sql);
  end;

end;

function TDM.getTagModelRegistryAttName(arg_attributeName: String): TClientDataset;
begin
  result := getClientDatasetObject(getTagModelRegistryAttNameSQL(arg_attributeName));
  result.Params.ParamByName('param_attributeName').AsString := arg_attributeName;
  result.Open();
end;

procedure TDM.insertTagModelRegistryAttName(arg_attributeValue: String);
var
  save: TADOQuery;
begin
  try
     save := TADOQuery.Create(self);
     try
        save.Connection := ADODBConnect;
        save.SQL.Add(insertTagModelRegistryAttNameSQL(arg_attributeValue));
        save.Parameters.ParamByName('param_attName').value := 'TagModel.cbTypeSearch.ItemIndex';
        save.Parameters.ParamByName('param_attValue').value := arg_attributeValue;
        save.Parameters.ParamByName('param_attType').value := 'Int';
        save.Parameters.ParamByName('param_constrValue').value := arg_attributeValue;
        save.Parameters.ParamByName('param_constrType').value := strToInt(arg_attributeValue);
        save.ExecSQL();
     except
        on e: Exception do begin
           raise Exception.Create(format('Fail to save TagModel Sis_Registry: %s', [e.message]));
        end;
     end;
  finally
     freeAndNil(save);
  end;

end;

function TDM.insertTagModelRegistryAttNameSQL(
  arg_attributeName: String): String;
var
  save: TStringList;
begin
  try
    save := TStringList.Create();
    save.add('insert into Sis_Registry (AttributeName, AttributeValue, AttributeType, ConstraintValue, ContraintType)');
    save.Add('values (:param_attName, :param_attValue, :param_attType, :param_constrValue, :param_constrType)');
    result := String(save.GetText);
  finally
    freeAndNil(save);
  end;
end;

function TDM.updateTagModelRegistryAttNameSQL(arg_attValue: String; arg_Id: Integer): String;
var
  save: TStringList;
begin
  try
    save := TStringList.Create();
    save.add('update Sis_Registry set AttributeValue = :param_attValue');
    save.add('where Id = :param_Id');
    result := String(save.GetText);
  finally
    freeAndNil(save);
  end;
end;

procedure TDM.updateTagModelRegistryAttName(arg_attValue: String; arg_Id: Integer);
var
  save: TADOQuery;
begin
  try
     save := TADOQuery.Create(self);
     try
        save.Connection := ADODBConnect;
        save.SQL.Add(updateTagModelRegistryAttNameSQL(arg_attValue, arg_Id));
        save.Parameters.ParamByName('param_Id').value := arg_Id;
        save.Parameters.ParamByName('param_attValue').value := arg_attValue;
        save.ExecSQL();
     except
        on e: Exception do begin
           raise Exception.Create(format('Fail to save TagModel Sis_Registry: %s', [e.message]));
        end;
     end;
  finally
     freeAndNil(save);
  end;
end;

function TDM.getItemPurchaseToPOSQL(arg_idpo: Integer): String;
var
  select: TStringList;
begin
  try
    select := TStringList.Create();
    select.Add('select idPreInventoryMov');
    select.Add(', documentID');
    select.Add(', modelID');
    select.Add(', movDate');
    select.Add(', qty');
    select.Add(', salePrice');
    select.Add(', pim.suggRetail');
    select.Add(', costPrice');
    select.Add(', pim.idPessoa');
    select.Add(', vwf.vendor');
    select.Add(', dateEstimatedMov');
    select.Add(', storeID');
    select.Add(', s.name');
    select.Add(', inventMovTypeID');
    select.Add(', userID');
    select.Add(', isnull(imv.vendorCost, 0) as CaseCost');
    select.Add(', pim.CaseQty');
    select.add('from PreInventoryMov pim');
    select.add('join model m on m.Idmodel = pim.modelID');
    select.add('join Store s on s.IDStore = pim.StoreID');
    select.add('left join vwFornecedor vwf on vwf.IDFornecedor = pim.IDPessoa');
    select.add('left join Inv_ModelVendor imv on imv.IDModel = m.IDModel and imv.IDPessoa = pim.IDPessoa');
    select.add('where IDPreInventoryMov = :param_idPreInventoryMov ');

    result := String(select.GetText);

  finally
    freeAndNil(select);
  end;
end;

function TDM.getItemPurchaseToPO(arg_idpo: Integer): TClientDataset;
begin
   result := getClientDatasetObject(getItemPurchaseToPOSQL(arg_idpo));
   result.Params.ParamByName('param_idPreInventoryMov').value := arg_idpo;
   result.open();
end;

function TDM.insertItemPurchaseToPOSQL(arg_itemPurchase: TItemPurchaseModel): String;
var
  insert: TStringList;
begin
  try
    insert := TStringList.Create();
    insert.Add('insert into PreInventoryMov ');
    insert.Add('(idPreInventoryMov, documentID, modelID, movDate, qty, salePrice, suggRetail, costPrice, idPessoa, dateEstimatedMov');
    insert.Add(', storeID, inventMovTypeID, userID, CaseCost, CaseQty )');
    insert.add('values (:param_idpreinventorymov, :param_documentid, :param_modelid, :param_movdate, :param_qty, :param_saleprice');
    insert.add(', :param_suggretail, :param_costprice, :param_idpessoa, :param_dateestimatedmov, :param_storeid');
    insert.add(', :param_inventmovtypeid, :param_userid, :param_casecost, :param_caseqty)');

    result := String(insert.GetText);

  finally
    freeAndNil(insert);
  end;
end;

function TDM.updateItemPurchaseToPOSQL(arg_itemPurchase: TItemPurchaseModel): String;
var
  update: TStringList;
begin
  try
    try
      update := TStringList.Create();
      update.Add('update PreInventoryMov ');
      update.Add('set documentID = :param_documentid, modelID = :param_modelid, movDate = :param_movdate, qty = :param_qty');
      update.add(', salePrice = :param_saleprice, suggRetail = :param_suggretail, costPrice = :param_costprice');
      update.add(', idPessoa = :param_idpessoa, dateEstimatedMov = :param_dateestimatedmov, storeID = :param_storeid');
      update.Add(', inventMovTypeID = :param_inventmovtypeid, userID = :param_userid, CaseCost = :param_casecost');
      update.add(', CaseQty = :param_caseqty');
      update.add(' where IdPreInventoryMov = :param_idpreinventorymov');

      result := String(update.GetText);
    except
      on e: Exception do begin
         raise exception.Create(format('update item purchase error: %s', [e.message]));
      end;
    end;

  finally
    freeAndNil(update);
  end;
end;

function TDM.insertItemPurchaseToPO(arg_itemPurchase: TItemPurchaseModel): Integer;
var
  insert: TADOQuery;
  preInvMovID: Integer;
begin
   try
   try
      insert := TADOQuery.Create(nil);
      insert.Connection := dm.ADODBConnect;
      insert.sql.Add(insertItemPurchaseToPOSQL(arg_itemPurchase));

      preInvMovID := dm.getNextKeyPreinventoryMov();

      insert.Parameters.parambyname('param_idpreinventorymov').value := preInvMovID;
      insert.Parameters.parambyname('param_documentid').value := arg_itemPurchase.DocumentID;
      insert.Parameters.parambyname('param_modelid').value := arg_itemPurchase.ModelID;
      insert.Parameters.parambyname('param_movdate').value := arg_itemPurchase.MovDate;
      insert.Parameters.parambyname('param_qty').value := arg_itemPurchase.Qty;
      insert.Parameters.parambyname('param_saleprice').value := arg_itemPurchase.SalePrice;
      insert.Parameters.parambyname('param_suggretail').value := arg_itemPurchase.SuggRetail;
      insert.Parameters.parambyname('param_costprice').value := arg_itemPurchase.CostPrice;
      insert.Parameters.parambyname('param_idpessoa').value := arg_itemPurchase.IdPessoa;
      insert.Parameters.parambyname('param_dateestimatedmov').value := arg_itemPurchase.DateEstimatedMov;
      insert.Parameters.parambyname('param_storeid').value := arg_itemPurchase.StoreID;
      insert.Parameters.parambyname('param_inventmovtypeid').value := arg_itemPurchase.InventoryMovTypeID;
      insert.Parameters.parambyname('param_userid').value := arg_itemPurchase.UserID;
      insert.Parameters.parambyname('param_casecost').value := arg_itemPurchase.CaseCost;
      insert.Parameters.parambyname('param_caseqty').value := arg_itemPurchase.CaseQty;

      insert.ExecSQL();

      result := preInvMovID;

    except
      on e: Exception do begin
         raise Exception.Create(format('insert item purchase error: %s', [e.message]));
      end;
    end;
   finally
      freeAndNil(insert);
   end;
end;

procedure TDM.updateItemPurchaseToPO(arg_itemPurchase: TItemPurchaseModel);
var
  update: TADOQuery;
begin
  try
     try
        update := TADOQuery.Create(nil);
        update.Connection := dm.ADODBConnect;
        update.SQL.Add(updateItemPurchaseToPOSQL(arg_itemPurchase));

        update.Parameters.parambyname('param_idpreinventorymov').value := arg_itemPurchase.IdPreInventoryMov;
        update.Parameters.parambyname('param_documentid').value := arg_itemPurchase.DocumentID;
        update.Parameters.parambyname('param_modelid').value := arg_itemPurchase.ModelID;
        update.Parameters.parambyname('param_movdate').value := arg_itemPurchase.MovDate;
        update.Parameters.parambyname('param_qty').value := arg_itemPurchase.Qty;
        update.Parameters.parambyname('param_saleprice').value := arg_itemPurchase.SalePrice;
        update.Parameters.parambyname('param_suggretail').value := arg_itemPurchase.SuggRetail;
        update.Parameters.parambyname('param_costprice').value := arg_itemPurchase.CostPrice;
        update.Parameters.parambyname('param_idpessoa').value := arg_itemPurchase.IdPessoa;
        update.Parameters.parambyname('param_dateestimatedmov').value := arg_itemPurchase.DateEstimatedMov;
        update.Parameters.parambyname('param_storeid').value := arg_itemPurchase.StoreID;
        update.Parameters.parambyname('param_inventmovtypeid').value := arg_itemPurchase.InventoryMovTypeID;
        update.Parameters.parambyname('param_userid').value := arg_itemPurchase.UserID;
        update.Parameters.parambyname('param_casecost').value := arg_itemPurchase.CaseCost;
        update.Parameters.parambyname('param_caseqty').value := arg_itemPurchase.CaseQty;
        update.ExecSQL();

     except
        on e: Exception do begin
           raise Exception.Create(format('update item purchase error: %s', [e.message]));
        end;
     end;
  finally
     freeAndNil(update);
  end;

end;

function TDM.getNameStoreSQL(arg_idstore: Integer): String;
var
  select: TStringList;
begin
  try
     select := TStringList.Create();
     select.add('select name from Store where IdStore = :param_id');
     result := String(select.GetText);
  finally
     freeAndNil(select);
  end;
end;

function TDM.searchVendorByIdVendorSQL(arg_id: Integer): String;
var
  select: TStringList;
begin
  try
     select := TStringList.Create();
     select.add('select vendor from VwFornecedor where IdFornecedor = :param_id');
     result := String(select.GetText);
  finally
     freeAndNil(select);
  end;
end;

function TDM.getNameStore(arg_id: Integer): String;
var
  store: TClientDataset;
begin
  try
     store := getClientDatasetObject(getNameStoreSQL(arg_id));
     store.Params.ParamByName('param_id').value := arg_id;
     store.open();

     result := store.fieldbyname('name').value;

  finally
     freeAndNil(store);
  end;

end;

function TDM.searchVendorByIdVendor(arg_id: Integer): String;
var
  vendor: TClientDataset;
begin
  try
     vendor := getClientDatasetObject(searchVendorByIdVendor(arg_id));
     vendor.Params.ParamByName('param_id').value := arg_id;
     vendor.open();

     result := vendor.fieldbyname('vendor').value;

  finally
     freeAndNil(vendor);
  end;

end;

function TDM.getNextKeyPreInventoryMov(): Integer;
var
  storedProc: TADOStoredProc;
begin
  Result := -1;
  try
    try
      storedProc := TADOStoredProc.Create(nil);
      storedProc.Connection := ADODBConnect;
      storedProc.ProcedureName := 'sp_GetNextKey_IDPreInventoryMov';
      storedProc.Parameters.CreateParameter('return',ftInteger, pdReturnValue, 0, 0);
      storedProc.ExecProc;
      Result := storedProc.Parameters.ParamByName('return').Value;
    except
      on E: Exception do
        raise Exception.Create('-105: ' + E.Message);
    end;
  finally
      freeAndNil(storedProc);
  end;
end;

function TDM.updateInvoiceGettingHoldNumberSQL(arg_idPresale, arg_idInvoice: Integer): String;
var
  update: TStringList;
begin
   try
      update := TStringList.Create();
      update.Add('update Invoice set note = note' + ' - Exchange from Hold #' + ':param_idpresale');
      update.add(' where idInvoice = :param_idinvoice');

      result := String(update.GetText);

   finally
      freeAndNil(update)
   end;
end;

procedure TDM.updateInvoiceGettingHoldNumber(arg_idPresale,  arg_idInvoice: Integer);
var
  update: TADOQuery;
begin
  try
      try
        update := TADOQuery.Create(nil);
        update.Connection := ADODBConnect;
        update.SQl.Text := updateInvoiceGettingHoldNumberSQL(arg_idPresale, arg_idInvoice);

        update.Parameters.ParamByName('param_idpresale').Value := arg_idPresale;
        update.Parameters.ParamByName('param_idinvoice').Value := arg_idInvoice;

        update.ExecSQL;

      except
         on e: Exception do begin
            raise Exception.Create(format('Exchange error: %s', [e.Message]));
         end;
      end;
  finally
      freeAndNil(update);
  end;

end;

function TDM.foundManualPrice(arg_idpreinvmov: Integer): Boolean;
var
  manualPriceTuple: TClientDataset;
begin
  result := false;
  manualPriceTuple := selectManualPrice(arg_idpreinvmov);
  result :=  ( not manualPriceTuple.IsEmpty );
end;

function TDM.selectManualPrice(arg_idpreinvMov: Integer): TClientDataset;
begin
  result := getClientDatasetObject(selectManualPriceSQL(arg_idpreinvmov));
  result.Params.ParamByName('param_id').Value := arg_idpreinvmov;
  result.Open();
end;

function TDM.selectManualPriceSQL(arg_idpreinvMov: Integer): String;
begin
  result := 'select * from ManualPrice where IdPreInventoryMov = :param_id';
end;

function TDM.foundManualDiscount(arg_idpreinvmov: Integer): Boolean;
var
  manualDiscountTuple: TClientDataset;
begin
  result := false;
  manualDiscountTuple := selectManualDiscount(arg_idpreinvmov);
  result := ( not manualDiscountTuple.isEmpty );
end;

function TDM.selectManualDiscount(arg_idpreinvmov: Integer): TClientDataset;
begin
   result := getClientDatasetObject(selectManualDiscountSQL(arg_idpreinvmov));
   result.Params.ParamByName('param_id').value := arg_idpreinvmov;
   result.open;
end;

function TDM.selectManualDiscountSQL(arg_idpreinvmov: Integer): String;
begin
   result := 'select * from ManualDiscount where IdPreInventoryMov = :param_id';
end;

function TDM.callSpInvoiceSale(arg_idpresale: Integer): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_PreSale_quPreSaleValue';
    result := getStoredProcObject(procName);
    result.Parameters.Refresh;
    result.Parameters.ParamByName('@PresaleID').Value := arg_idpresale;
    result.open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.callSpItemSale(arg_idpresale, arg_idpreinvmov: Integer;
  arg_presaledate: TDateTime): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_PreSale_quPreSaleItem';
    result := getStoredProcObject(procName);

    result.Parameters.Refresh;
    result.Parameters.ParamByName('@DocumentID').Value := arg_idpresale;
    result.Parameters.ParamByName('@IsPresale').Value := true;
    result.Parameters.ParamByName('@Date').Value := arg_presaledate;

    result.open;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.getPromosByModelSQL(): String;
var
  select: TStringList;
begin
  try
      select := TStringList.Create();
      select.add('select * from vw_ModelDiscountSummaries where idmodel = :param_idmodel');
      {
      select.Add('select distinct qt.IDDiscount');
      select.add(',d.DiscountName');
      select.add(',d.DiscType');
      select.add(' ,d.AmountType');
      select.Add('from Tag t');
      select.Add('join DiscQualifyingTags qt on t.IdTag = qt.idTag');
      select.add('join Discounts d on qt.IdDiscount = d.idDiscount');
      select.add('join TagModel tm on t.idTag = tm.idtag and tm.idModel = :param_idmodel');
      }

      result := String(select.GetText)

  finally
      freeAndNil(select)
  end;

end;

function TDM.getTagsByModelSQL(): String;
var
  select: TStringList;
begin
  try
      select := TStringList.Create();
      select.Add('select * from vw_TagsWithAttrsAndModels where idmodel = :param_idmodel');
//      select.add(',coalesce(tpb.IdTag, 0, 1) as isPriceBreak');
      result := String(select.GetText)

  finally
      freeAndNil(select)
  end;

end;

function TDM.promosByModel(arg_idmodel: Integer): TClientDataset;
begin
  result := getClientDatasetObject(getPromosByModelSQL);
  result.Params.ParamByName('param_idmodel').value := arg_idmodel;
  result.open();
end;


function TDM.tagsByModel(arg_idmodel: Integer): TClientDataset;
begin
  result := getClientDatasetObject(getTagsByModelSQL);
  result.Params.ParamByName('param_idmodel').value := arg_idmodel;
  result.open();
end;


function TDM.getAvailableTagsByModelSQL: String;
var
  select: TStringList;
begin
  try
      select := TStringList.Create();
      select.Add('select * from vw_TagsWithAttrs where IDTag not in (select IDTag from TagModel where IDModel = :param_idmodel)');
      result := String(select.GetText)

  finally
      freeAndNil(select)
  end;
end;

function TDM.getTagsAvailableByModel(arg_idmodel: Integer): TClientDataset;
begin
  result := getClientDatasetObject(getAvailableTagsByModelSQL);
  result.Params.ParamByName('param_idmodel').value := arg_idmodel;
  result.open();
end;

function TDM.getTagByTagNameSQL: String;
var
  select: TStringList;
begin
  try
      select := TStringList.Create();
      select.Add('select IDTag, TagName');
      select.Add('from Tag');
      select.add('where TagName = :param_tagname');

      result := String(select.GetText)

  finally
      freeAndNil(select)
  end;
end;

function TDM.getTagByTagName(arg_tagname: String): TClientDataset;
begin
  result := getClientDatasetObject(getTagByTagNameSQL());
  result.Params.paramByName('param_tagname').Value := arg_tagname;
  result.open;
end;

function TDM.callSpCouponUpsert(arg_document: Integer;
  arg_coupon: String): TADOStoredProc;
var
  procName: String;
begin
  try
    procName := 'sp_PreSale_Coupon_Upsert';
    result := getStoredProcObject(procName);

    result.Parameters.Refresh;
    result.Parameters.ParamByName('@DocumentID').Value := arg_document;  //arg_idpresale;
    result.Parameters.ParamByName('@CouponCode').Value := arg_coupon;  //arg_idpresale;
    result.ExecProc;
  except
    on e:exception do begin
       raise exception.Create('error on ' + procName + ' ' + e.message);
    end;
  end;
end;

function TDM.deleteSalAccountCardByPreInvMovSQL: String;
begin
  result := 'delete from Sal_AccountCard where IdPreInventoryMov = :param_idpreinventorymov';
end;


function TDM.deleteSalAccountCardByPreInvMov(arg_idpreinvmov: Integer): Boolean;
var
   delete: TClientDataset;
begin
   try
      delete := getClientDatasetObject(deleteSalAccountCardByPreInvMovSQL());
      delete.Params.ParamByName('param_idpreinventorymov').Value := arg_idpreinvmov;
      delete.Execute();
   except on e: Exception do
      raise;
   end;
end;

function TDM.getPreSaleSQL(arg_document: String): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.create;
     sql.Add('select * from PreInventoryMov where documentID = :param_documentid ');
     result := String(sql.GetText);

  finally
     freeAndNil(sql);
  end;
end;

function TDM.getPresale(arg_document: String): TClientDataset;
begin
   result := getClientDatasetObject(getPresaleSQL(arg_document));
   result.Params.ParamByName('param_documentId').Value := arg_document;
   result.Open();
end;

function TDM.updateInvoiceSettingInvoiceDiscountSQL(arg_idpresale: Integer; arg_invoiceDiscount: double): String;
var
  update: TStringList;
begin
   try
      update := TStringList.Create();
      update.Add('update Invoice set InvoiceDiscount = :param_invoicediscount');
      update.add(' where IdPresale = :param_idpresale');

      result := String(update.GetText);

   finally
      freeAndNil(update)
   end;
end;

procedure TDM.updateInvoiceSettingInvoiceDiscount(arg_idpresale: Integer;
  arg_invoiceDiscount: double);
var
  update: TADOQuery;
begin
  try
      try
        update := TADOQuery.Create(nil);
        update.Connection := ADODBConnect;
        update.SQl.Text := updateInvoiceSettingInvoiceDiscountSQL(arg_idPresale, arg_invoiceDiscount);

        update.Parameters.ParamByName('param_idpresale').Value := arg_idPresale;
        update.Parameters.ParamByName('param_invoicediscount').Value := arg_invoiceDiscount;

        update.ExecSQL;

      except
         on e: Exception do begin
            raise Exception.Create(format('cannot update Invoice Discount to Invoice: %d, error = %s', [arg_idpresale, e.Message]));
         end;
      end;
  finally
      freeAndNil(update);
  end;
end;


function TDM.getCustomerTaxExemptionSQL(arg_idpessoa: Integer): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.create;
     sql.Add('Select TOP 100');
     sql.Add('P.IDPessoa,');
     sql.Add('P.OrgaoEmissor DriverLicense,');
     sql.add('P.CEP,');
     sql.add('P.CartTrabalho SocialSecurity,');
     sql.add('P.CustomerCard,');
     sql.add('P.PessoaFirstName,');
     sql.add('P.Pessoa,');
     sql.add('(PhoneAreaCode + ''-'' + P.Telefone) as Phone,');
     sql.add('P.email,');
     sql.add('P.PessoaLastName');
     sql.add('from Pessoa p');
     sql.add('join TipoPessoa tp on p.IdTipoPessoa = tp.IdTipoPessoa');
     sql.add('where TP.Path like ''.001%'' ');
     sql.add('and p.System = 0');
     sql.add('and p.desativado = 0');
     sql.add('and p.IdPessoa = :param_IdPessoa');

     result := String(sql.GetText);

  finally
     freeAndNil(sql);
  end;
end;

function TDM.getCustomerTaxExemption(arg_idpessoa: Integer): TClientDataset;
begin
   result := getClientDatasetObject(getCustomerTaxExemptionSQL(arg_idpessoa));
   result.Params.ParamByName('param_IdPessoa').Value := arg_idpessoa;
   result.Open();
end;

procedure TDM.insertCustomerTaxExemption(arg_idpresale: Integer; arg_idcustomer: Integer);
var
  save: TADOQuery;
begin
  try
     save := TADOQuery.Create(self);
     try
        save.Connection := ADODBConnect;
        save.SQL.Add(insertCustomerTaxExemptionSQL(arg_idPresale, arg_idCustomer));
        save.Parameters.ParamByName('param_IdInvoiceObs').value := DM.GetNextID('Mnt_DefaultInvoiceOBS.IDDefaultInvoiceOBS');
        save.Parameters.ParamByName('param_IdPresale').Value := arg_idPresale;
        save.parameters.parambyname('param_ObsDate').Value := now;
        save.parameters.parambyName('param_Obs').value := 'Tax Exemption to Customer';
        save.parameters.ParamByName('param_IdPessoaTax').Value := arg_idcustomer;
        save.ExecSQL();
     except
        on e: Exception do begin
           raise Exception.Create(format('Fail to save InvoiceObs: %s', [e.message]));
        end;
     end;
  finally
     freeAndNil(save);
  end;
end;

function TDM.insertCustomerTaxExemptionSQL(arg_idPessoa,
  arg_idPresale: Integer): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.Add('insert into InvoiceObs(IdInvoiceObs, IdPresale, ObsDate, Obs, IDPessoaTax)');
     sql.add('values (:param_IdInvoiceObs, :param_IdPresale, :param_ObsDate, :param_Obs, :param_IdPessoaTax)');
     result := String(sql.GetText);
  finally
     freeAndNil(sql);
  end;
end;

procedure TDM.InitializeDsiPDCXDevice();
begin
  try
    FDsiPDCX := TDsiPDCX.Create(nil);
  except
    ; // something here to warns the user
  end;
end;

function TDM.getPaymentWayByPayType(argIdPayTYpe: Integer; arg_parentType: String): TClientDataset;
begin
   result := getClientDatasetObject(getPaymentWayByPayTypeSQL(argIdPayType, arg_parentType));
   result.Params.ParamByName('param_tipo').Value := argIdPayType;

   if ( arg_parentType <> '' ) then begin
      result.Params.ParamByName('param_parentType').Value := arg_parentType;
   end;

   result.Open();
end;

function TDM.getPaymentWayByPayTypeSQL(argIdPayType: Integer; arg_parentType: String): String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.Add('select * from MeioPag where Tipo = :param_tipo');

      if ( arg_parentType <> '' ) then begin
         sql.Add('and lower(ParentType) = :param_parentType');
      end;

      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;
end;


procedure TDM.UpdatePriceInInventory(aIdInventory: Integer;
  aSalePrice: Double);
var
   update: TADOQuery;
   sql: TStringList;
begin

   try

      sql := TStringList.Create();
      sql.Add('update Inventory set sellingPrice = :p_sellingPrice where idInventory = :p_id');

      update := TADOQuery.Create(nil);
      update.Connection := ADODBConnect;

      update.SQL.Text := String(sql.GetText);

      update.Parameters.ParamByName('p_sellingPrice').Value := aSalePrice;
      update.Parameters.ParamByName('p_Id').Value := aIdInventory;

      update.ExecSQL();

   except
      on e: Exception do begin
         raise Exception.Create('Error in update Inventory ' + e.Message);
      end;
   end;

end;



function TDM.GetBarcodeSearch(argSqlSearch: String): TClientDataset;
begin
  (* The idea behind the scene is to get any search from "Barcode Print" screen, according to filter passed.
     Parameter will be entered as from as owner screen - "Barcode Print" *)

  result := getClientDatasetObject(argSQLSearch);
end;

// index = 0
function TDM.GetBarcodeSearchSQL(argCategory: String; argSubCategory: String; argGroup: String;
  argMakeLabelLikeQtyOnHand: Boolean; argPrimaryUPC: Boolean; argIsEmpty: Boolean): String;
var
   _select: TStringList;
   _join: TStringList;
   _where: TStringList;
   _attribute: String;
   _numberCopy: Integer;
begin
   try
       _select := TStringList.Create();
       _join := TStringList.Create();
       _where := TStringList.Create();

       _select.add(GetStandardBarcodeSelect());
       _join.add(GetStandardBarcodeJoin());
       _where.add(GetStandardBarcodeWhere());

       // select complement
      _select.add(', (case isnull(i.sellingprice, 0) when 0 then m.sellingprice else i.sellingprice end) as SellingPrice ');
      _select.add(', (select qtyonhand from Inventory i where i.modelid = m.idmodel and i.storeid = ' + IntToStr(fStore.ID) + ') as QtyOnHand');
      _select.add(', (select storeavgprice from Inventory i where i.modelid = m.idmodel and i.storeid =' + IntToStr(fstore.ID) +') as StoreAvgPrice');

      if ( argMakeLabelLikeQtyOnHand ) then begin
           _select.add(', cast((select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end) as Decimal) as  NumCopy, I.StoreAVGPrice');
           _join.add(' left join Inventory i on i.modelid = ba.idmodel');
      end else begin
              _numberCopy := 1;
              _select.add(',cast('+ IntToStr(_numberCopy) + ' as Integer) NumCopy, cast ('''' as varchar) Report');
              _join.add(' left join Inventory i on m.idmodel = i.modelid');
          end;

       // where complement
       if ( argCategory <> '' ) then begin
           _where.add('and m.groupid = ' + argCategory);
       end;

       if ( argSubCategory <> '' ) then begin
           _where.add('and m.idmodelgroup = ' + argSubcategory);
       end;

       if ( argGroup <> '' ) then begin
           _where.add('and m.idmodelsubgroup = ' + argGroup);
       end;

       if ( argPrimaryUPC ) then begin
           _where.add(' and ba.barcodeorder = 1');
       end;

       if ( argIsEmpty ) then begin
          _where.add('and m.idmodel = -1');
       end;

       result := String(_select.GetText()) + String(_join.GetText) +  String(_where.GetText());
(*
      _select.SaveToFile('c:\pinogy\SelectBarcodeFromCategory.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromCategory.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromCategory.sql');
 *)

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;

end;

function TDM.GetStandardBarcodeSearchSQL(argSearchIndex: Integer; argMakeLabelLikeQtyOnHand: Boolean;
argPrimaryUPC: Boolean; argIsEmpty: Boolean): String;
var
   _select, _join, _where: TStringList;
   _numberCopy: Integer;
   _numberCopyField: String;
begin

   // This method returns the standard select and joins to print barcode search
   // The search index ( searchIndex ) matches with the page of the search was triggered. Basically to work with "make label like qty on hand" condition.

   try
      _numberCopy := 1;

      _select := TStringList.Create();
      _join := TStringList.Create();
      _where := TStringList.Create();

      _select.add('select m.idmodel');
      _select.add(',m.model');
      _select.add(',tg.name category');
      _select.add(',mg.modelgroup subcategory');
      _select.add(',msg.modelsubgroup msgroup');
      _select.add(',m.description');
      _select.add(',m.datelastsellingprice');
      _select.add(',i.storeavgprice');
      _select.add(',m.sellingprice');
      _select.add(',cast(1.0 as decimal) QtyOnHand');
      _select.add(',ba.idbarcode');
      _select.add(',ba.data');
      _select.add(',vmc.vendorcode SKU');
      _select.add(',m.largeimage');
      _select.add(',m.largeimage2');
      _select.add(',f.pessoa as manufacturer');
      _select.Add(',v.usercode as vendornum');
      _select.add(',v.pessoa as vendor');
      _select.add(',s.sizename');
      _select.add(',c.color');
      _select.add(', c.codcolor');
      _select.add(', ''*'' + (ltrim(rtrim(m.model)) + ''*'') as modeltoscan');
      _select.add(', ''*'' + (ltrim(rtrim(ba.idbarcode)) + ''*'') as barcodetoscan');
      _select.add(', isnull(m.datelastsellingprice,' + Datetostr(Strtodate('01/01/2000')) +') as data');

      _join.Add(' from Barcode ba');

      _join.add(' join Model m on m.idmodel = ba.idmodel');
      _join.Add(' left join Inventory i on i.modelid = ba.idmodel');
      _join.add(' left join TabGroup tg on m.groupid = tg.idgroup');
      _join.Add(' left join ModelGroup mg on m.idmodelgroup = mg.idmodelgroup');
      _join.add(' left join ModelSubGroup msg on m.idmodelsubgroup = msg.idmodelsubgroup');
      _join.add(' left join InvSize s on s.idsize = m.idsize');
      _join.add(' left join InvColor c on c.idcolor = m.idcolor');
      _join.add(' left join VendorModelCode vmc on m.idmodel = vmc.idmodel');
      _join.add(' join Pessoa f on m.idfabricante = f.idpessoa');
      _join.add(' left join Inv_ModelVendor mv on ( m.idmodel = mv.idmodel ) and ( f.IDPessoa = mv.IDPessoa)');
      _join.add(' left join Pessoa v on ( mv.idpessoa = v.idpessoa ) and ( v.IDPessoa = f.IDPessoa )');

      _where.add(' where m.desativado = 0');

      _select.add(', (select qtyonhand from Inventory i where i.modelid = m.idmodel and i.storeid = ' + IntToStr(fStore.ID) + ') as QtyOnHand');
      _select.add(', (select storeavgprice from Inventory i where i.modelid = m.idmodel and i.storeid =' + IntToStr(fstore.ID) +') as StoreAvgPrice');

      _where.add(' and i.storeid = ' + IntTostr(fStore.ID));

      case ( argSearchIndex ) of
          0,1: begin
               if ( argMakeLabelLikeQtyOnHand ) then begin
                  _numberCopyField := 'qtyonhand';
                  _select.add(', cast((select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end) as Decimal) as  NumCopy, I.StoreAVGPrice');

               end else begin
                     _select.add(',cast('+ IntToStr(_numberCopy) + ' as Integer) NumCopy, cast ('''' as varchar) Report');
                  end;

               _select.add(', (case isnull(i.sellingprice, 0) when 0 then m.sellingprice else i.sellingprice end) as SellingPrice');

          end; // end 0, 1


          2: begin
                if ( argMakeLabelLikeQtyOnHand ) then begin
                   _select.add(', (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand');

                end else begin
                        _select.add(', (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, IsNull(I.QtyOnHand,0) QtyOnHand ');

                    end;

                _select.Add(',cast(' + IntToStr(_numberCopy) + ' as Integer) NumCopy ');
                _select.add(' ,cast (''Label 1'' as varchar) Report');


                _select.add(', m.sellingprice');
          end;

      end;

      if ( argPrimaryUPC ) then begin
         _where.add(' and ba.barcodeorder = 1');
      end;

      if ( argIsEmpty ) then begin
          _where.add('and m.idmodel = -1');
      end;

      result := String(_select.GetText) + String(_join.GetText) + String(_where.GetText);
      finally
          FreeAndNil(_select);
          FreeAndNil(_join);
          FreeAndNil(_where);
      end;
end;

function TDM.GetBarcodeSearchSQL(argPurchase: String; argMakeLabelLikeQtyOnHand: Boolean;
  argPrimaryUPC: Boolean; argNumberCopies: Integer): String;
var
   _select, _join, _where: TStringList;

begin
   try
      _select := TStringList.Create();
      _join := TStringList.Create();
      _where := TStringList.Create();

      _select.add(GetStandardBarcodeSelect());
      _join.add(GetStandardBarcodeJoin());
      _where.add(GetStandardBarcodeWhere());

      // where complement
     _where.add('   and m.idmodel in (select idmodel from Pur_PurchaseItem where idpurchase = ' + argPurchase +')');

      result := String(_select.GetText()) + String(_join.GetText) + String(_where.GetText());
(*
      _select.SaveToFile('c:\pinogy\SelectBarcodeFromPurchase.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromPurchase.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromPurchase.sql');
 *)

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;

end;

function TDM.GetBarcodeSearchSQL(argIdmodel: Integer; argMakeLabelLikeQtyOnHand: Boolean;
argPrimaryUPC: Boolean): String;
var
   _select, _where, _join: TStringList;
   _numberCopy: Integer;

begin
   try
      _select := TStringList.Create();
      _join := TStringList.Create();
      _where := TStringList.Create();

      _select.add(GetStandardBarcodeSelect());
      _join.add(GetStandardBarcodeJoin());
      _where.add(GetStandardBarcodeWhere());

      // select complement
      _select.add(', (case isnull(i.sellingprice, 0) when 0 then m.sellingprice else i.sellingprice end) as SellingPrice ');
      _select.add(', (select qtyonhand from Inventory i where i.modelid = m.idmodel and i.storeid = ' + IntToStr(fStore.ID) + ') as QtyOnHand');
      _select.add(', (select storeavgprice from Inventory i where i.modelid = m.idmodel and i.storeid =' + IntToStr(fstore.ID) +') as StoreAvgPrice');

      if ( argMakeLabelLikeQtyOnHand ) then begin
           _select.add(', cast((select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end) as Decimal) as  NumCopy, I.StoreAVGPrice');
           _join.add(' left join Inventory i on i.modelid = ba.idmodel');
      end else begin
              _numberCopy := 1;
              _select.add(',cast('+ IntToStr(_numberCopy) + ' as Integer) NumCopy, cast ('''' as varchar) Report');
              _join.add(' left join Inventory i on m.idmodel = i.modelid');
          end;


      _where.add(' and m.idmodel = ' + IntToStr(argIdmodel));

      result := String(_select.GetText()) + String(_join.GetText) + String(_where.GetText());
(*
      _select.SaveToFile('c:\pinogy\SelectBarcodeFromModel.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromModel.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromModel.sql');
 *)

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;

end;

function TDM.GetBarcodeSearchSQL(argSearchWith: Integer; argSearchValue: String;
  argVendor: String; argMakeLabelLikeQtyOnHand: Boolean; argPrimaryUPC: Boolean;
  argNumberCopy: String; argIsEmpty: Boolean): String;
var
   _select, _join, _where: TStringList;
   _numberCopy: Integer;
begin
   try
      _numberCopy := 1;

      _select := TStringList.Create();
      _join := TStringList.Create();
      _where := TStringList.Create();

      _select.add(GetStandardBarcodeSelect());
      _join.add(GetStandardBarcodeJoin());
      _where.add(GetStandardBarcodeWhere());

      // select complement
      _select.add(', (case isnull(i.sellingprice, 0) when 0 then m.sellingprice else i.sellingprice end) as SellingPrice ');
      _select.add(', (select qtyonhand from Inventory i where i.modelid = m.idmodel and i.storeid = ' + IntToStr(fStore.ID) + ') as QtyOnHand');
      _select.add(', (select storeavgprice from Inventory i where i.modelid = m.idmodel and i.storeid =' + IntToStr(fstore.ID) +') as StoreAvgPrice');

      if ( argMakeLabelLikeQtyOnHand ) then begin
         _select.add(', (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand');
         _join.add(' left join Inventory i on i.modelid = ba.idmodel');
      end else begin
              _select.add(', (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, IsNull(I.QtyOnHand,0) QtyOnHand ');
               _join.add(' left join Inventory i on i.modelid = m.idmodel');
          end;

      _select.Add(',cast(' + IntToStr(_numberCopy) + ' as Integer) NumCopy ');
      _select.add(' ,cast (''Label 1'' as varchar) Report');

      _where.add(' and ba.barcodeorder = 1');

      case ( argSearchWith ) of
          0: begin //  search by barcode
             _where.add(' and ba.idbarcode = ' + QuotedStr(argSearchValue));
          end;

          1: begin
             _where.add(' and m.model = ' + QuotedStr(argSearchValue));
          end;

           2: begin
              _where.add(' and vmc.vendorcode = ' + argVendor);
              //where.add(' and imv.idpessoa = ' + IntToStr(

           end;

      end;

      _where.add(' and i.storeid = ' + IntToStr(fStore.id));

      result := String(_select.GetText()) + String(_join.GetText) + String(_where.GetText());

(*
      _select.SaveToFile('c:\pinogy\SelectBarcodeFromVendor.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromVendor.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromVendor.sql');
  *)

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;

end;

function TDM.GetBarcodeSearchSQL(argInitDate, argEndDate: TDateTime;
  argMakeLabelLikeQtyOnHand, argPrimaryUPC, argIsEmpty: Boolean): String;
var
  _select, _join, _where: TStringList;
   _numberCopy: Integer;
begin
  try

      _select := TStringList.Create();
      _join := TStringList.Create();
      _where := TStringList.Create();

      _select.add(GetStandardBarcodeSelect());
      _join.add(GetStandardBarcodeJoin());
      _where.add(GetStandardBarcodeWhere());

      // select complement
      _select.add(', (case isnull(i.sellingprice, 0) when 0 then m.sellingprice else i.sellingprice end) as SellingPrice ');
      _select.add(', (select qtyonhand from Inventory i where i.modelid = m.idmodel and i.storeid = ' + IntToStr(fStore.ID) + ') as QtyOnHand');
      _select.add(', (select storeavgprice from Inventory i where i.modelid = m.idmodel and i.storeid =' + IntToStr(fstore.ID) +') as StoreAvgPrice');

      if ( argMakeLabelLikeQtyOnHand ) then begin
           _select.add(', cast((select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end) as Decimal) as  NumCopy, I.StoreAVGPrice');
           _join.add(' left join Inventory i on i.modelid = ba.idmodel');
      end else begin
              _numberCopy := 1;
              _select.add(',cast('+ IntToStr(_numberCopy) + ' as Integer) NumCopy, cast ('''' as varchar) Report');
              _join.add(' left join Inventory i on m.idmodel = i.modelid');
          end;

     _where.add(' and m.datelastsellingprice >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', argInitDate)));
     _where.add(' and m.datelastsellingprice <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', argEndDate + 1)));

     result := String(_select.GetText) + String(_join.GetText) + String(_where.GetText);

(* To uncomment just to debug
      _select.SaveToFile('c:\pinogy\SelectBarcodeDateTime.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromDateTime.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromDateTime.sql');
*)

  finally
     FreeAndNil(_select);
     FreeAndNil(_join);
     FreeAndNil(_where);
  end;
end;

procedure TDM.InsertBarcodePrintQueue(argIdUser: Integer; argIdModel: Integer; argModel: String;
  argDescription: String; argIdBarcode: String; argQtyOnHand: Double; argSellingPrice: Double; argNumCopy: Double;
  argReport: String; argIdSearchType: Integer; argStraightToPrinter: Integer; argPrintQueue: Integer;
  argLabelQtyOnHand: Integer; argPrimaryBarcode: Integer; argLargeImage: String; argLargeImage2: String;
  argManufacturer: String; argVendorNum: String; argVendor: String; argSizeName: String; argColor: String;
  argCodColor: String; argModelToScan: String; argBarcodeToScan: String);
var
  _new: TADOQuery;
begin
   try
       try
          _new := TADOQuery.Create(nil);
          _new.Connection := dm.ADODBConnect;
          _new.SQL.Add(InsertBarcodePrintQueueSQL());
          _new.Parameters.ParamByName('prm_idUser').Value := argIdUser;
          _new.parameters.ParamByName('prm_idModel').Value := argIdModel;
          _new.Parameters.ParamByName('prm_model').Value := argModel;

          _new.Parameters.ParamByName('prm_description').Value := argDescription;
          _new.Parameters.ParamByName('prm_idBarcode').Value := argIdBarcode;
          _new.Parameters.ParamByName('prm_qtyOnHand').Value := argQtyOnHand;
          _new.Parameters.ParamByName('prm_sellingPrice').Value := argSellingPrice;
          _new.Parameters.ParamByName('prm_numCopy').Value := argNumCopy;
          _new.Parameters.ParamByName('prm_report').Value := argReport;
          _new.Parameters.ParamByName('prm_searchWith').Value := argIdSearchType;
          _new.Parameters.ParamByName('prm_straight').Value := argStraightToPrinter;
          _new.Parameters.ParamByName('prm_label').Value := argLabelQtyOnHand;
          _new.Parameters.ParamByName('prm_primary').Value := argPrimaryBarcode;
          _new.Parameters.ParamByName('prm_largeImage').Value := argLargeImage;
          _new.Parameters.ParamByName('prm_largeImage2').Value := argLargeImage2;
          _new.Parameters.ParamByName('prm_manufacturer').Value := argManufacturer;
          _new.Parameters.ParamByName('prm_vendorNum').Value := argVendorNum;
          _new.Parameters.ParamByName('prm_vendor').Value := argVendor;
          _new.Parameters.ParamByName('prm_sizeName').Value := argSizeName;
          _new.Parameters.ParamByName('prm_color').Value := argColor;
          _new.Parameters.ParamByName('prm_codColor').Value := argCodColor;
          _new.Parameters.ParamByName('prm_modelToScan').Value := argModelToScan;
          _new.Parameters.ParamByName('prm_barcodeToScan').Value := argBarcodeToScan;

          _new.ExecSQL();

       except
          on e: Exception do begin
             raise e.Create('Cannot insert barcode queue to database');
          end;
       end;
   finally
      FreeAndNil(_new);
   end;

end;

function TDM.InsertBarcodePrintQueueSQL(): String;
var
  _insert: TStringList;
begin
   try
      _insert := TStringList.Create();
      _insert.add('insert into Inv_BarcodePrintSearch');
      _insert.add('(IdUser, IdModel, Model, Description, IdBarcode, QtyOnHand, SellingPrice, NumCopy, Report,');
      _insert.add('IdSearchType, StraightToPrinter, PrintQueue, LabelQtyOnHand, PrimaryBarcode, LargeImage,');
      _insert.add('LargeImage2, Manufacturer, VendorNum, Vendor, SizeName, Color, CodColor, ModelToScan,');
      _insert.add('BarcodeToScan) values (:prm_IdUser, :prm_IdModel, :prm_Model, :prm_Description, :prm_IdBarcode, :prm_QtyOnHand,');
      _insert.add(':prm_SellingPrice, :prm_NumCopy, :prm_Report, :prm_SearchWith, :prm_Straight, :prm_Queue, :prm_Label, :prm_Primary, ');
      _insert.add(':prm_LargeImage, :prm_LargeImage2, :prm_Manufacturer, :prm_VendorNum, :prm_Vendor, :prm_SizeName, :prm_Color');
      _insert.add(', :prm_CodColor, :prm_ModelToScan, :prm_BarcodeToScan)');

      result := String(_insert.GetText);

   finally
      FreeAndNil(_insert);

   end;

end;

procedure TDM.UpdateBarcodePrintQueue(argNumCopy: Double; argReport: String; argIdSearchType: Integer;
argStraightToPrinter: Integer; argPrintQueue: Integer; argLabelQtyOnHand: Integer; argPrimaryBarcode: Integer;
argIdModel: Integer; argModel: String; argDescription: String; argQtyOnHand: Double; argSellingPrice: Double;
argLargeImage: String; argLargeImage2: String; argManufacturer: String; argVendorNum: String; argVendor: String;
argSizeName: String; argColor: String; argCodColor: String; argModelToScan: String; argBarcodeToScan: String;
argIduser: Integer; argIdBarcode: String);
var
   _update: TADOQuery;
begin
   try
       try
          _update := TADOQuery.Create(nil);
          _update.connection := ADODBConnect;
          _update.SQL.Add(UpdateBarcodePrintQueueSQL());

          _update.Parameters.ParamByName('prm_report').Value := argReport;
          _update.Parameters.ParamByName('prm_searchType').Value := argIdSearchType;
          _update.Parameters.ParamByName('prm_straight').Value := argStraightToPrinter;
          _update.Parameters.ParamByName('prm_queue').Value := argPrintQueue;
          _update.Parameters.ParamByName('prm_label').Value := argLabelQtyOnHand;
          _update.Parameters.ParamByName('prm_primary').Value := argPrimaryBarcode;
          _update.Parameters.ParamByName('prm_largeImage').Value := argLargeImage;
          _update.Parameters.ParamByName('prm_largeImage2').Value := argLargeImage2;
          _update.Parameters.ParamByName('prm_manufacturer').Value := argManufacturer;
          _update.Parameters.ParamByName('prm_vendorNum').Value := argVendorNum;
          _update.Parameters.ParamByName('prm_sizeName').Value := argSizeName;
          _update.Parameters.ParamByName('prm_color').Value := argColor;
          _update.Parameters.ParamByName('prm_codColor').Value := argCodColor;
          _update.Parameters.ParamByName('prm_modelToScan').Value := argModelToScan;
          _update.Parameters.ParamByName('prm_barcodeToScan').Value := argBarcodeToScan;
          _update.Parameters.ParamByName('prm_numCopy').Value := argNumCopy;
          _update.Parameters.ParamByName('prm_idUser').Value := argIduser;
          _update.Parameters.ParamByName('prm_idBarcode').Value := argIdBarcode;

          _update.ExecSQL();

       except
          on e: Exception do begin
             raise Exception.Create('Cannot update barcode queue on database: ' + e.Message);
          end;
       end;

   finally
      FreeAndNil(_update);
   end;


end;

function TDM.UpdateBarcodePrintQueueSQL: String;
var
  _update: TStringList;
begin
   try
      _update := TStringList.Create();
      _update.add('update Inv_BarcodePrintSearch set NumCopy = :prm_numCopy');
      _update.add(', Report = :prm_Report');
      _update.add(', IdSearchType = :prm_SearchType');
      _update.add(', StraightToPrinter = :prm_Straight');
      _update.add(', PrintQueue = :prm_queue,');
      _update.add(', LabelQtyOnHand = :prm_label');
      _update.add(', PrimaryBarcode = :prm_primary');
      _update.add(', LargeImage = :prm_LargeImage');
      _update.add(', LargeImage2 = :prm_LargeImage2');
      _update.add(', Manufacturer = :prm_Manufacturer');
      _update.add(', VendorNum = :prm_VendorNum');
      _update.add(', Vendor = :prm_Vendor');
      _update.add(', SizeName = :prm_SizeName');
      _update.add(', Color = :prm_Color');
      _update.add(', CodColor = :prm_CodColor');
      _update.add(', ModelToScan = :prm_ModelToScan');
      _update.add(', BarcodeToScan = :prm_BarcodeToScan');
      _update.add(' where IdUser = :prm_IdUser and IdBarcode = :prm_IdBarcode');

      result := String(_update.GetText);

   finally
      FreeAndNil(_update);

   end;

end;

function TDM.GetBarcodeSearchSQL(argSearchType, argSearchMethod: Integer;
  argNameField: String; argMakeLabelLikeQtyOnHand, argPrimaryUPC,
  argIsEmpty: Boolean): String;
var
   _select, _join, _where: TStringList;
   _attribute: String;
   _numberCopy: Integer;
begin
   try

      _numberCopy := 1;

      _select := TStringList.Create();
      _join := TStringList.Create();
      _where := TStringList.Create();

      _select.add(GetStandardBarcodeSelect());
      _join.add(GetStandardBarcodeJoin());
      _where.add(GetStandardBarcodeWhere());

      // select complement
      _select.add(', (case isnull(i.sellingprice, 0) when 0 then m.sellingprice else i.sellingprice end) as SellingPrice ');
      _select.add(', (select qtyonhand from Inventory i where i.modelid = m.idmodel and i.storeid = ' + IntToStr(fStore.ID) + ') as QtyOnHand');
      _select.add(', (select storeavgprice from Inventory i where i.modelid = m.idmodel and i.storeid =' + IntToStr(fstore.ID) +') as StoreAvgPrice');

      if ( argMakeLabelLikeQtyOnHand ) then begin
           _select.add(', cast((select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end) as Decimal) as  NumCopy, I.StoreAVGPrice');
           _join.add(' left join Inventory i on i.modelid = ba.idmodel');
      end else begin
              _numberCopy := 1;
              _select.add(',cast('+ IntToStr(_numberCopy) + ' as Integer) NumCopy, cast ('''' as varchar) Report');
              _join.add(' left join Inventory i on m.idmodel = i.modelid');
          end;

      case ( argSearchType ) of
         0: _attribute := 'm.model %s';
         1: _attribute := 'm.description %s';
         2: _attribute := 'ba.idbarcode %s';
      end;

      if ( _attribute <> '' ) then begin
         case ( argSearchMethod ) of
           0: _where.add(' and ' + Format(_attribute, [' like ' + QuotedStr(argNameField + '%')]));
           1: _where.add(' and ' + Format(_attribute, [' like ' + QuotedStr('%' + argNameField)]));
           2: _where.add(' and ' + Format(_attribute, [' like ' + QuotedStr('%' + argNameField + '%')]));
         end;
      end;

      result := String(_select.GetText()) + String(_join.GetText()) + String(_where.GetText());
(*
      _select.SaveToFile('c:\pinogy\SelectBarcodeFromSearchMethod.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromSearchMethod.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromSeacrhMethod.sql');
*)

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;

end;

function TDM.GetBarcodeFromPurchase(argPurchase: String; argMakeLabelLikeQtyOnHand: Boolean;
  argPrimaryUPC: Boolean; argNumberCopies: Integer): TClientDataset;
begin
  result := getClientDatasetObject(GetBarcodeFromPurchaseSQL(argMakeLabelLikeQtyOnHand, argPrimaryUPC, argNumberCopies));
  result.Params.ParamByName('prm_purchase').Value := StrToInt(argPurchase);
  result.Open();

end;

function TDM.GetBarcodeFromPurchaseSQL(argMakeLabelLikeQtyOnHand: Boolean; argPrimaryUPC: Boolean;
argNumberCopies: Integer): String;
var
  _select: TStringList;
  _join: TStringList;
  _where: TStringList;
begin
   try
     _select := TStringList.Create();
     _where := TStringList.Create();
     _join := TStringList.Create();

     _select.add('select p.idpurchaseitem');
     _select.add(', p.idmodel');
     _select.add(', p.barcode');
     _select.add(', m.model');
     _select.add(', b.idbarcode');
     _select.add(', p.qty');
     _select.add(', m.description');
     _select.add(', p.qty as QtyOnHand');
     _select.add(', (case isnull(i.sellingprice, 0) when 0 then p.newsaleprice else i.sellingprice end) as SellingPrice');
     _select.add(', i.StoreAvgPrice');
     _select.add(', m.largeimage');
     _select.add(', m.largeimage2');
     _select.add(', f.pessoa as Manufacturer');
     _select.add(', v.usercode as VendorNum');
     _select.add(', v.pessoa as Vendor');
     _select.add(', s.sizename');
     _select.add(', c.color');
     _select.add(', c.codcolor');
     _select.add(', ''*'' + (ltrim(rtrim(m.model)) + ''*'') as modeltoscan');
     _select.add(', ''*'' + (ltrim(rtrim(b.idbarcode)) + ''*'') as barcodetoscan');

     if ( argMakeLabelLikeQtyOnHand ) then begin
   _select.add(',p.Qty as  NumCopy, p.NewSalePrice ');

     end else begin
             _select.add(',cast('+ IntToStr(argNumberCopies) + ' as Decimal) NumCopy, p.newSalePrice  ');
         end;

     _join.add(' from Pur_PurchaseItem p');
     _join.add(' left join Barcode b on b.idmodel = p.idmodel');
     _join.add(' left join Model m on m.idmodel = b.idmodel');
     _join.add(' left join Inventory i on m.idmodel = i.modelid');
     _join.add(' left join InvSize s on s.idsize = m.idsize');
     _join.add(' left join InvColor c on c.idcolor = m.idcolor');
     _join.add(' left join Inv_ModelVendor mv on m.idmodel = mv.idmodel');
     _join.add(' left join Pessoa v on mv.idpessoa = v.idpessoa');
     _join.add(' left join Pessoa f on m.idfabricante = f.idpessoa');

     _where.add(' where m.desativado = 0');
     _where.add('   and b.barcodeorder = 1');
     _where.add('   and p.idmodel is not null');
     _where.add('   and m.idmodel in (select idmodel from Pur_PurchaseItem where idpurchase = :prm_purchase)');
     _where.add('   and p.idpurchase = :prm_purchase');

      result := String(_select.GetText) + String(_join.GetText) + String(_where.GetText);

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;
end;

function TDM.GetStandardBarcodeJoin(): String;
var
   _join: TStringList;
begin
   try
       _join := TStringList.Create();

       {
        from Barcode ba
 join Model m on m.idmodel = ba.idmodel
 left join TabGroup tg on m.groupid = tg.idgroup
 left join ModelGroup mg on ( m.idmodelgroup = mg.idmodelgroup ) and (mg.IDGroup = tg.IDGroup )
 left join ModelSubGroup msg on ( m.idmodelsubgroup = msg.idmodelsubgroup ) and (msg.IDModelGroup = mg.IDGroup)
 left join InvSize s on s.idsize = m.idsize
 left join InvColor c on c.idcolor = m.idcolor
 join Pessoa ps on m.idfabricante = ps.idpessoa
 left join Inv_ModelVendor mv on ( m.idmodel = mv.idmodel ) and ( ps.IDPessoa = mv.IDPessoa)
 left join VendorModelCode vmc on (m.IDModel = vmc.IDModel) and (vmc.IDPessoa = ps.IDPessoa)
}

      _join.add(' from Barcode ba');
      _join.add(' join Model m on m.idmodel = ba.idmodel');
      _join.add(' left join TabGroup tg on m.groupid = tg.idgroup');
      _join.Add(' left join ModelGroup mg on ( m.idmodelgroup = mg.idmodelgroup ) and (mg.IDGroup = tg.IDGroup )');
      _join.add(' left join ModelSubGroup msg on ( m.idmodelsubgroup = msg.idmodelsubgroup ) and (msg.IDModelGroup = mg.IDGroup)');
      _join.add(' left join InvSize s on s.idsize = m.idsize');
      _join.add(' left join InvColor c on c.idcolor = m.idcolor');
      _join.add(' join Pessoa ps on m.idfabricante = ps.idpessoa');
      _join.add(' left join Inv_ModelVendor mv on ( m.idmodel = mv.idmodel ) and ( ps.IDPessoa = mv.IDPessoa)');
      _join.add(' left join VendorModelCode vmc on (m.IDModel = vmc.IDModel) and (vmc.IDPessoa = ps.IDPessoa)');

      result := String(_join.GetText);

   finally
       FreeAndNil(_join);
   end;

end;

function TDM.GetStandardBarcodeSelect(): String;
var
   _select: TStringList;
begin
   try
      _select := TStringList.Create();

      _select.add('select m.idmodel');
      _select.add(',m.model');
      _select.add(',tg.name category');
      _select.add(',mg.modelgroup subcategory');
      _select.add(',msg.modelsubgroup msgroup');
      _select.add(',m.description');
      _select.add(',m.datelastsellingprice');
//      _select.add(',cast(1.0 as decimal) QtyOnHand');  // specific according to conditions
//      _select.add(',i.storeavgprice');                 // specific according to conditions
//      _select.add(',m.sellingprice');                  // specific according to conditions
      _select.add(',ba.data as barcodedate');
      _select.add(', ba.idbarcode');
//      _select.add(',vmc.vendorcode SKU');              // specific according to conditions
      _select.add(',m.largeimage');
      _select.add(',m.largeimage2');
      _select.add(',ps.pessoa as manufacturer');
      _select.Add(',ps.usercode as vendornum');
      _select.add(',ps.pessoa as vendor');
      _select.add(',s.sizename');
      _select.add(',c.color');
      _select.add(', c.codcolor');
      _select.add(', ''*'' + (ltrim(rtrim(m.model)) + ''*'') as modeltoscan');
      _select.add(', ''*'' + (ltrim(rtrim(ba.idbarcode)) + ''*'') as barcodetoscan');
      _select.add(', isnull(m.datelastsellingprice,' + Datetostr(Strtodate('01/01/2000')) +') as data');

      result := String(_select.GetText);
   finally
      FreeAndNil(_select);
   end;
end;

function TDM.GetStandardBarcodeWhere(): String;
var
  _where: TStringList;
begin
   try
      _where := TStringList.Create();
      _where.add(' where m.desativado = 0');

      result := String(_where.GetText);

   finally
      FreeAndNil(_where);
   end;

end;

function TDM.GetBarcodeFromTransferSQL(argIdTransfer: String): String;
var
  _select: TStringList;
  _join: TStringList;
  _where: TStringList;
begin
   try

     _select := TStringList.Create();
     _where := TStringList.Create();
     _join := TStringList.Create();

     _select.add('select t.idmodel');
     _select.add(', b.idbarcode');
     _select.add(', t.qty');
     _select.add(', m.model');
     _select.add(', m.description');
     _select.add(', m.sellingprice');

     _join.add(' from ModelTransfDet t');
     _join.add(' left join Barcode b on b.idmodel = t.idmodel');
     _join.add(' left join Model m on m.idmodel = b.idmodel');

     _where.add(' where idmodeltransf = ' + argIdTransfer);

      result := String(_select.GetText) + String(_join.GetText) + String(_where.GetText);

   finally
      FreeAndNil(_select);
      FreeAndNil(_join);
      FreeAndNil(_where);
   end;
end;

function TDM.GetBarcodeFromTransfer(argIdTransfer: String): TClientDataset;
begin
  result := getClientDatasetObject(GetBarcodeFromTransferSQL(argIdTransfer));
  result.Open();
end;

function TDM.GetBarcodeSearchSQL(argIdTransfer: String; argNumberCopies: Integer): String;
var
  _select, _join, _where: TStringList;
begin
  try
     _select := TStringList.Create();
     _where := TStringList.Create();
     _join := TStringList.Create();

     _select.add(GetStandardBarcodeSelect());

     _select.add(', IsNull(I.QtyOnHand,0) as QtyOnHand');

     _join.add(GetStandardBarcodeJoin());
     _where.add(GetStandardBarcodeWhere());

     _where.add('WHERE M.IDModel IN (SELECT IDModel FROM ModelTRansfDet (NOLOCK) WHERE IDModelTransf = '+ argIDTransfer+')');

     result := String(_select.GetText) + String(_join.GetText) + String(_join.GetText);
(*
      _select.SaveToFile('c:\pinogy\SelectBarcodeFromTransfer.sql');
      _join.SaveToFile('c:\pinogy\JoinBarcodeFromTransfer.sql');
      _where.SaveToFile('c:\pinogy\WhereBarcodeFromTransfer.sql');
  *)

  finally
     FreeAndNil(_select);
     FreeAndNil(_join);
     FreeAndNil(_where);
  end;

end;

function TDM.GetKitInfoSQL: String;
begin

end;

function TDM.GetKitItemsSQL(): String;
var
   _select: TStringList;
begin
   try

      _select := TStringList.Create();
      _select.add('select pm.IdPackModel');
      _select.add(', m.model');
      _select.add(', pm.Qty');
      _select.add(', m.model');
      _select.add(', m.description');
      _select.add(', m.SellingPrice');
      _select.add(', m.FinalCost');
      _select.add(', m.TotQtyOnHand');
      _select.add(' from PackModel pm');
      _select.add('join Model m on pm.idmodel = m.idmodel');
      _select.add(' where pm.IdPackModel = :prm_IdModel');

      result := String(_select.Gettext);
   finally
       FreeAndNil(_select);
   end;

end;

function TDM.GetKintInfo(argInvoice: Integer): TClientDataset;
begin
   result := GetClientDatasetObject(GetKitInfoSQL);
   result.Params.ParamByName('prm_invoice').Value := argInvoice;
   result.open();
end;

function TDM.GetKitCategory(argSQL: String): TClientDataset;
begin
   result := GetClientDatasetObject(argSQL);
   result.Open();
end;

function TDM.GetKitItems(argIdModel: Integer): TClientDataset;
begin
   result := getClientDatasetObject(GetKitItemsSQL);
   result.Params.ParamByName('prm_idModel').Value := argIdModel;
   result.Open();
end;

function TDM.GetKitItemSQL(argKitId: String; argListOfIdModels: String): String;
var
  loSelect: TStringList; // lo prefix means local object
begin
  try

      loSelect := TStringList.Create();
      loSelect.add('select pm.idpackmodel');
      loSelect.add(', pm.idmodel');
      loSelect.add(', pm.qty');
      loSelect.add(', m.model');
      loSelect.add(', m.sellingprice');
      loSelect.add(', m.vendorcost');
      loSelect.add(', m.finalcost');
      loSelect.Add(', m.totqtyonhand');
      loSelect.add(', header.description as kit_description');
      loSelect.add(', m.desativado');
      loSelect.add(' from PackModel pm');
      loSelect.add(' join Model m on pm.idmodel = m.idmodel');
      loSelect.add(' join Model header on header.idmodel = pm.idpackmodel');
      loSelect.add(' join TabGroup tg on header.groupid = tg.idgroup');
      loSelect.add(' where header.modeltype in (''M'', ''R'', ''K'', ''V'', ''C'', ''G'')');
      loSelect.add(' and pm.idpackmodel in (' + argListOfIdModels + ')' );
      loSelect.Add(' and header.groupid = ' + argKitId);

      result := String(loSelect.GetText);

  finally
      FreeAndNil(loSelect);
  end;
end;

function TDM.GetKitItems(argKitId,
  argListOfIdModels: String): TClientDataset;
begin
   result := getClientDatasetObject(GetKitItemSQL(argKitId, argListOfIdModels));
   result.Open();
end;

{ TpayMethodType }

function TpayMethod.GetIdBaseType: Integer;
begin
  result := self.idBaseType;
end;

function TpayMethod.GetIdType: Integer;
begin
  result := self.idType;
end;

function TpayMethod.GetInUse: Boolean;
begin
  result := self.inUse;
end;

function TpayMethod.GetNameType: String;
begin
  result := self.nameType;
end;

procedure TpayMethod.SetIdBaseType(argValue: Integer);
begin
  self.idBaseType := argValue;
end;

procedure TpayMethod.SetIdType(argValue: Integer);
begin
  self.idType := argValue;
end;

procedure TpayMethod.SetInUse(argValue: Boolean);
begin
   self.inUse := argValue;
end;

procedure TpayMethod.SetNameType(argValue: String);
begin
  self.nameType := argValue;
end;

{ TPayMethodList }

procedure TPayMethodList.AddPaymethodToList(argPayMethod: TPayMethod);
begin
   self.FPayList.Add(argPayMethod);
end;

constructor TPayMethodList.Create;
begin
  inherited;
  fPayList := TObjectList.Create();
end;

function TPayMethodList.GetPayMethodList: TObjectList;
begin
  result := self.FPayList;
end;

function TPayMethodList.FoundPayMethod(argPayIndex: Integer): Boolean;
var
  objPay: TPayMethod;
  liCounter: Integer;
begin
  result := false;
  for liCounter := 0 to FPayList.Count - 1 do begin
      objPay := TPayMethod(FPayList.Items[liCounter]);

      if ( argPayIndex = objPay.GetIdBaseType() ) then begin
          result := true;
          break;
      end;

  end;

end;

function TPayMethodList.GetPayMethod(argPayIndex: Integer): TPayMethod;
var
  objPay: TPayMethod;
  liCounter: Integer;
begin
  result := nil;
  for liCounter := 0 to FPayList.Count - 1 do begin
      objPay := TPayMethod(FPayList.Items[liCounter]);

      if ( argPayIndex = objPay.GetIdBaseType() ) then begin
          result := objPay;
          break;
      end;

  end;

end;

function TDM.GetBrowseReceivingSQL(): String;
var
  slSelect: TStringList;
begin

   try
      slSelect := TStringList.Create();
      slSelect.Add('select PU.IdPurchase ');
      slSelect.Add(', PU.DatePreReceiving ');
      slSelect.Add(', PU.DateFinalReceiving ');
      slSelect.Add(', PE.Code as VendorCode ');
      slSelect.Add(', PE.Pessoa as Vendor ');
      slSelect.Add(', PT.Subtotal ');
      slSelect.Add(', PU.OtherCharges ');
      slSelect.Add(', PU.Freight ');
      slSelect.Add(', PU.IDPO ');
      slSelect.Add(', IsNull(PU.Discount, 0) as Discount ');
      slSelect.Add(', S.Name as Store ');
      slSelect.Add(', (PT.SubTotal + PU.OtherCharges + PU.Freight - IsNull(PU.Discount,0))  as Total');
      slSelect.Add(', SU.SystemUser as UserPreReceive');
      slSelect.Add(', SUF.SystemUser as UserFinalReceive');
      slSelect.Add(', PU.DocumentType');
      slSelect.Add(', PU.DocumentNumber');
      slSelect.Add(', PU.DocumentDate');
      slSelect.Add(', PU.DocumentDueDate');
      slSelect.add(', PU.DocumentTotal');

      slSelect.add(', CFOP.Number as CFOPNum');
      slSelect.add(', CFOP.Description as CFOP');
      slSelect.add(', isnull(Scaned.SubTotalCounted, 0) as SubTotalCounted');
      slSelect.add(' FROM Pur_Purchase PU');
      slSelect.add('      JOIN Pessoa PE ON (PU.IDFornecedor = PE.IDPessoa)');
      slSelect.add('      JOIN Store S ON (S.IDStore = PU.IDStore)');
      slSelect.add('      LEFT JOIN SystemUser SU ON ( PU.IDUserPreReceiving = SU.IDUser )');
      slSelect.add('      LEFT JOIN SystemUser SUF ON ( PU.IDUserFinalReceiving = SUF.IDUser )');
      slSelect.add('      LEFT JOIN Pur_PurchaseTotal PT ON (PU.IDPurchase = PT.IDPurchase)');
      slSelect.add('      LEFT JOIN Mnt_CFOP CFOP ON (CFOP.IDCFOP = PU.IDCFOP)');

      slSelect.add('      left join ( select SUM(ppv.QtyCounted * ppi.NewCostPrice) as SubTotalCounted, ppv.IDPurchase');
      slSelect.add('                  from Pur_PurchaseVerify ppv');
      slSelect.add('                  join Pur_PurchaseItem ppi on ppv.IDPurchase = ppi.IDPurchase and ppv.IDModel = ppi.IDModel');
      slSelect.add('                  group by ppv.IDPurchase) Scaned on pu.IDPurchase = Scaned.IDPurchase');
      slSelect.add('      where ( 1 = 1 )');


      result := String(slSelect.GetText);
   finally
      FreeAndNil(slSelect);
   end;
end;

function TDM.GetBrowseReceiving(argStore, argVendor: String; argIniDate,
  argEndDate: TDateTime; argIsFinal: Boolean): String;
var
   slBrwReceivingWhere: TStringList;
begin
   try
       slBrwReceivingWhere := TStringList.Create();
       slBrwReceivingWhere.add(GetBrowseReceivingSQL);

       if ( argStore = '' ) then begin
          slBrwReceivingWhere.Add(' and PU.IDStore IN ('+ DM.fStore.StoreList +')');
       end else begin
               slBrwReceivingWhere.Add(' and PU.IDStore = ' + argStore);
           end;

       if ( argVendor <> '' ) then begin
          slBrwReceivingWhere.add(' and PU.IDFornecedor = ' + argVendor);
       end;

       if ( not argIsFinal ) then begin
           slBrwReceivingWhere.add(' and PU.DateFinalReceiving is null');
           slBrwReceivingWhere.add(' and PU.DatePreReceiving >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(argIniDate))) + Chr(39) + ' AND ' +
                                    ' PU.DatePreReceiving < ' +Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(argEndDate)+1)) + Chr(39) );
       end else begin
           slBrwReceivingWhere.add(' and PU.DateFinalReceiving >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(argIniDate))) + Chr(39) + ' AND ' +
                                    ' PU.DateFinalReceiving < ' +Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(argEndDate)+1)) + Chr(39) );
           end;


       try
         result := String(slBrwReceivingWhere.GetText);

       except
         on e: Exception do begin
             raise e.Create('Fail to retrive SQL to Receiving.' + e.Message);
         end;
       end;
   finally
       FreeAndNil(slBrwReceivingWhere);
   end;
end;

function TDM.GetVendorTermsSQL(): String;
var
  _select: TStringList;
begin
   try

      _select := TStringList.Create();
      _select.add('select IdPessoa ');
      _select.add(', DueDateShift ');
      _select.add(', Discount ');
      _select.add('from PessoaTerm pt');
      _select.add(' where pt.IdPessoa = :param_IdPessoa ');

      result := String(_select.GetText);

   finally
      FreeAndNil(_select);
   end;

end;

function TDM.GetDayShiftVendorTerms(argIDVendor: Integer): Integer;
var
  cdsVendor: TClientDataset;
begin
  cdsVendor := getClientDatasetObject(GetVendorTermsSQL());
  cdsVendor.Params.ParamByName('param_IdPessoa').Value := argIDVendor;
  cdsVendor.Open();

  if ( not cdsvendor.IsEmpty ) then begin
      result := cdsVendor.fieldByName('DueDateShift').Value;
  end else begin
          result := 0;
      end;
  FreeAndNil(cdsVendor);
end;

function TDM.IsQuoteHasPOSQL(): String;
var
  _select: TStringList;

begin

     try
       _select := TStringList.Create();
       _select.add('select IdCotacao from PO where IdCotacao = :param_idcotacao');

       result := String(_select.GetText);
     finally
       FreeAndNil(_select);
     end;

end;

function TDM.IsQuoteHasPOS(argQuote: String): Boolean;
var
   _po: TClientDataset;
begin
   _po := getClientDatasetObject(IsQuoteHasPOSQL());
   _po.Params.ParamByName('param_idcotacao').AsString := argQuote;
   _po.Open;
   result := ( not _po.FieldByName('IdCotacao').IsNull );
end;

function TDM.InsertItemToPurchaseVerificationSQL(): String;
var
  _sql:TStringList;
begin
  try
     _sql := TStringList.Create();
     _sql.Add('insert into pur_purchaseVerify(');
     _sql.add('IdPurchaseVerify, IdPurchase, IdUser, IDmodel, IDBarcode, QtyReceiving, QtyCounted, EnterDate, ScanDate)');
     _sql.Add(' values (:prm_idpurchaseVerify, :prm_idpurchase, :prm_iduser, :prm_idmodel, :prm_idbarcode');
     _sql.add(', :prm_qtyrec, :prm_qtycounted, :prm_enterdate, :prm_scandate)');

     result := String(_sql.GetText);
  finally
     FreeAndNil(_sql);
  end;


end;

procedure TDM.UpdateItemToPurchaseVerification(argIdUser,
  argIdPurchase: Integer; argIdBarcode: String; argQtyCounted: Double);
var
   _cmdUpdate: TADOQuery;
begin
   try
     try
         _cmdUpdate := TADOQuery.Create(nil);
         _cmdUpdate.Connection := ADODBConnect;
         _cmdUpdate.SQL.Text := UpdateItemToPurchaseVerificationSQL();
         _cmdUpdate.Parameters.ParamByName('prm_iduser').Value := argIdUser;
         _cmdUpdate.Parameters.ParamByName('prm_idbarcode').Value := argIdBarcode;
         _cmdUpdate.Parameters.ParamByName('prm_enterdate').Value := NULL; //argEnterDate;
         _cmdUpdate.Parameters.ParamByName('prm_qtyCounted').Value := argQtyCounted; //argEnterDate;
         _cmdUpdate.Parameters.ParamByName('prm_id').Value := argIdPurchase;
         _cmdUpdate.ExecSQL();
     except
         on e: Exception do begin
            raise e.Create('Cannot update barcode to Verification'+e.Message);
         end;
     end;

   finally
      FreeAndNil(_cmdUpdate);
   end;

end;

function TDM.UpdateItemToPurchaseVerificationSQL: String;
var
   _sql: TStringList;
begin
   try
       _sql := TStringList.Create();
       _sql.add('update pur_PurchaseVerify ');
       _sql.add('set iduser = :prm_iduser');
       _sql.add(',idbarcode = :prm_idbarcode');
       _sql.add(',qtycounted = :prm_qtycounted');
       _sql.add(',enterdate = :prm_enterdate');
       _sql.add(' where idpurchaseVerify = :prm_id');

       result := String(_sql.GetText);

   finally
       FreeAndNil(_sql);
   end;

end;


procedure TDM.InsertItemToPurchaseVerification(argIdPurchaseVerify,
  argIdPurchase, argIdUSer, argIdModel: Integer; argIdBarcode: String;
  argQtyReceiving, argQtyCounted: Double;
  argScanDate: TDateTime);
var
  _cmdInsert: TADOQuery;
  _idmodel: variant;
  _scanDate: variant;
begin
   try
     try
         if ( argIdModel = -1 ) then begin
            _idmodel := NULL;
         end else begin
                 _idModel := ArgIdModel;
             end;

         if ( argScanDate = 0 ) then begin
               _scandate := NOW;
         end else begin
                _scanDate := argScanDate;
             end;


         _cmdInsert := TADOQuery.Create(nil);
         _cmdInsert.Connection := ADODBConnect;
         _cmdInsert.SQL.Text := InsertItemToPurchaseVerificationSQL();
         _cmdInsert.Parameters.ParamByName('prm_idpurchaseVerify').Value := argIdPurchaseVerify;
         _cmdInsert.Parameters.ParamByName('prm_idpurchase').Value := argIdPurchase;
         _cmdInsert.Parameters.ParamByName('prm_iduser').Value := argIdUSer;
         _cmdInsert.Parameters.ParamByName('prm_idmodel').Value := _idmodel;
         _cmdInsert.Parameters.ParamByName('prm_idbarcode').Value := argIdBarcode;
         _cmdInsert.Parameters.ParamByName('prm_qtyrec').Value := argQtyReceiving;
         _cmdInsert.Parameters.ParamByName('prm_qtycounted').Value := argQtyCounted;
         _cmdInsert.Parameters.ParamByName('prm_enterdate').Value := NULL;

         _cmdInsert.Parameters.ParamByName('prm_scandate').Value := _scanDate;

         _cmdInsert.ExecSQL();
     except
         on e: Exception do begin
            raise e.Create('Cannot insert barcode to Verification');
         end;
     end;

   finally
      FreeAndNil(_cmdInsert);
   end;
end;


function TDM.SelectItemInPurchase(argIdPurchase,
  argIdModel: Integer): TClientDataSet;
begin
  result := getClientDatasetObject(SelectItemByIDModelInPurchaseSQL());
  result.Params.ParamByName('prm_idpurchase').Value := argIdPurchase;
  result.params.ParamByName('prm_idmodel').Value  := argIdmodel;

  result.Open(); // must be destroyed for the caller.

end;

function TDM.SelectItemInPurchase(argIdPurchase: Integer;
  argIdBarcode: String): TClientDataset;
begin
  result := getClientDatasetObject(SelectItemByBarcodeInPurchaseSQL());
  result.Params.ParamByName('prm_idpurchase').Value := argIdPurchase;
  result.params.ParamByName('prm_idbarcode').Value  := argIdBarcode;

  result.Open(); // must be destroyed for the caller.
end;


function TDM.SelectItemsFromPurchaseVerification(
  argIdPurchase: Integer): TClientDataset;
begin
   result := getClientDatasetObject(SelectItemsFromPurchaseVerificationSQL());
   result.Params.ParamByName('prm_idpurchase').Value := argIdPurchase;
   result.Open();
end;

function TDM.SelectItemsFromPurchaseVerificationSQL(): String;
var
  _select: TStringList;
begin

   try
     _select := TStringList.Create();
     _select.Add('select pv.IdPurchaseVerify');
     _select.Add('   , pv.IdUser');
     _select.Add('   , pv.IdModel');
     _select.Add('   , pv.IdBarcode');
     _select.Add('   , pv.QtyReceiving');
     _select.Add('   , pv.QtyCounted');
     _select.Add('   , pv.EnterDate');
     _select.Add('   , su.SystemUSer');
     _select.Add('   , m.Model');
     _select.Add('   , m.Description');
     _select.Add('   , tg.name as Category');
     _select.Add('   , m.Sellingprice');
     _select.Add('   , m.FinalCost');
     _select.Add('   , m.SuggRetail');
     _select.Add('   , isnull(mv.caseqty, 0) as CaseQty');
     _select.Add('   , tg.IdGroup');
     _select.add('   , IsNull(PPI.CostPrice, 0) as PurchaseCost');
     _select.add('   , PPI.IDPurchaseItem');
     _select.add('   , P.IDFornecedor as IDVendor');
     _select.add('   , pv.ScanDate');
     _select.add('   , (pv.qtyCounted - pv.qtyReceiving) Difference');

     _select.add(' from pur_purchaseVerify pv');
     _select.add('    join SYSTEMUSER SU ON (SU.IDUSER = PV.IDUSER)');
     _select.Add('    join pur_purchase p on p.idpurchase = pv.idpurchase');
     _select.add('    left join model m on m.idmodel = pv.idmodel');
     _select.add('    left join inv_modelVendor mv on ( m.idmodel = mv.idmodel and p.idfornecedor = mv.idpessoa)');
     _select.add('    LEFT JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)');
     _select.add('    join Pur_PurchaseItem PPI on (ppi.IDPurchase = p.IDPurchase and m.IdModel = ppi.idmodel)');
     _select.Add(' where ');
     _select.add('     pv.idpurchase = :prm_idpurchase');

     result := String(_select.GetText());

   finally
     FreeAndNil(_select);
   end;

end;


function TDM.SelectItemByBarcodeInPurchaseSQL(): String;
var
  _select: TStringList;
begin
   try
     _select := TStringList.Create();
     _select := TStringList.Create();
     _select.Add('select ppi.IDPurchase');
     _select.Add('   , ppi.IDModel');
     _select.Add('   , ppi.BarCode');
     _select.Add('   , ppi.Qty as QtyReceiving');
     _select.Add('   , ppi.CaseQty as CaseQtyReceiving');
     _select.Add('   , m.Model');
     _select.Add('   , m.Description');
     _select.Add('   , m.SellingPrice');
     _select.add('   , m.SuggRetail');
     _select.add(' from Pur_PurchaseItem ppi');
     _select.Add('    join Model m on m.IDModel = ppi.IDModel');
     _select.Add(' where ');
     _select.Add('    ppi.barcode = :prm_barcode');
     _select.add('    and ppi.idpurchase = :prm_idpurchase');

     result := String(_select.GetText());

   finally
     FreeAndNil(_select);
   end;

end;

function TDM.SelectItemByIdModelInPurchaseSQL(): String;
var
  _select: TStringList;
begin
   try

     _select := TStringList.Create();
     _select.Add('select ppi.IDPurchase');
     _select.Add('   , ppi.IDModel');
     _select.Add('   , ppi.BarCode');
     _select.Add('   , ppi.Qty as QtyReceiving');
     _select.Add('   , ppi.CaseQty as CaseQtyReceiving');
     _select.Add('   , m.Model');
     _select.Add('   , m.Description');
     _select.Add('   , m.SellingPrice');
     _select.add('   , m.SuggRetail');
     _select.add(' from Pur_PurchaseItem ppi');
     _select.Add('    join Model m on m.IDModel = ppi.IDModel');
     _select.Add(' where ');
     _select.Add('    ppi.idmodel = :prm_idmodel');
     _select.add('    and ppi.idpurchase = :prm_idpurchase');

     result := String(_select.GetText());

   finally
     FreeAndNil(_select);
   end;

end;

function TDM.SelectItemFromPurchaseVerificationSQL: String;
var
  _select: TStringList;
begin
   try
     _select := TStringList.Create();
     _select.Add('select * from Pur_PurchaseVerify');
     _select.Add(' where ');
     _select.Add('    idmodel = :prm_idmodel');
     _select.add('   and idpurchase = :prm_idpurchase');

     result := String(_select.GetText());

   finally
     FreeAndNil(_select);
   end;

end;

function TDM.SelectItemFromPurchaseVerification(argIdPurchase,
  argIdModel: Integer): TClientDataset;
begin
  result := getClientDatasetObject(SelectItemFromPurchaseVerificationSQL());
  result.Params.ParamByName('prm_idpurchase').Value := argIdPurchase;
  result.params.ParamByName('prm_idmodel').Value  := argIdModel;

  result.Open();
end;

function TDM.GetSumByModelInPurchaseSQL: String;
var
   _sql: TStringList;
begin
   try

      _sql := TStringList.Create();
      _sql.Add('select ppi.Idmodel');
      _sql.Add(', isnull(ppi.barcode, b.idbarcode) barcode');
      _sql.add(', pf.IdPurchaseVerify');
      _sql.Add(', sum(ppi.qty) as Qty ');
      _sql.Add('from Pur_PurchaseItem ppi ');
      _sql.Add('  left join Barcode b on ppi.IdModel = b.IdModel');
      _sql.Add('  left join Pur_PurchaseVerify pf on ( ppi.IdPurchase = pf.IdPurchase and ppi.Idmodel = pf.IdModel )');
      _sql.Add(' where ppi.idpurchase = :prm_idpurchase');
      _sql.Add('   and b.BarcodeOrder = 1');
      _sql.Add(' group by ppi.Idmodel, isnull(ppi.Barcode, b.IdBarcode), pf.IdPurchaseVerify');

      result := String(_sql.GetText);

   finally
      FreeAndNil(_sql);

   end;

end;

function TDM.InsertReceivingSQL(): String;
var
   _sql: TStringList;
begin
   try
      _sql.Add('insert Pur_PurchaseItem (');
      _sql.add('IdPurchaseItem');
      _sql.Add(', IdPurchase');
      _sql.add(',IdModel');
      _sql.add(', Qty');
      _sql.add(', IdGroup');
      _sql.Add(', NewCostPrice');
      _sql.Add(', NewSalePrice');
      _sql.add(', NewSuggRetail');
      _sql.Add(', IdFornecedor');
      _sql.Add(', IdPoItem');
      _sql.Add(', CostPrice');
      _sql.add('CaseQty');
      _sql.add('CaseCost)');
      _sql.add(' values (');
      _sql.add(':prm_idPurchaseItem');
      _sql.add(', :prm_idpurchase');
      _sql.add(', :prm_idModel');
      _sql.add(', :prm_qty');
      _sql.add(', :prm_groupId');
      _sql.add(', :prm_costPrice');
      _sql.Add(', :prm_salePrice');
      _sql.add(', :prm_suggRetail');
      _sql.add(', :prm_idVendor');
      _sql.add(', :prm_idPreinventoryMov');
      _sql.add(', :prm_costWithTax');
      _sql.add(', :prm_caseQty');
      _sql.add(', :prm_caseCost');
      _sql.add(')');

      result := String(_sql.GetText);

   finally
      FreeAndNil(_sql);
   end;

end;

function TDM.UpdatePurchaseItemSQL: String;
var
   _sql: TStringList;
begin
   try
     _sql := TStringList.Create();
     _sql.Add('Update pv');
     _sql.Add(' set pv.qtyReceiving = pui.qty');
     _sql.add(' from Pur_PurchaseVerify pv');
     _sql.add('      join ( select ');
     _sql.add('                IdPurchase');
     _sql.Add('              , IdModel');
     _sql.add('              , sum(qty) as Qty');
     _sql.add('             from Pur_PurchaseItem');
     _sql.add('             where IdPurchase = :prm_idpurchase1');
     _sql.add('             group by IdPurchase');
     _sql.add('                   , IdModel ');
     _sql.add('           ) pui on (pui.IdPurchase = pv.IdPurchase and pui.IdModel = pv.IdModel)');
     _sql.Add(' where ');
     _sql.add('     pv.IdPurchase = :prm_idpurchase2');
     _sql.add(' and pv.qtyReceiving <> pui.Qty');

     result := String(_sql.GetText);

   finally
      FreeAndNiL(_sql);
   end;

end;

function TDM.UpdateReceivingSQL: String;
var
  _sql: TStringList;
begin
   try
      _sql := TstringList.Create();
      _sql.add('update Pur_PurchaseItem');
      _sql.Add(' set Qty = :prm_qty');
      _sql.Add(' , CostPrice = :prm_costprice');
      _sql.add(' where IdPurchase = :prm_idpurchase');
      _sql.Add(' and IdModel = :prm_idmodel');

      result := String(_sql.GetText());

   finally
      FreeAndNil(_sql);
   end;

end;

function TDM.GetSumByModelInPurchase(argIdPurchase: Integer): TClientDataset;
begin
   result := getClientDatasetObject(GetSumByModelInPurchaseSQL());
   result.Params.parambyname('prm_idpurchase').Value := argIdPurchase;
   result.open();
end;

procedure TDM.InsertReceiving(argIdPurchase, argIdModel, argIdGroup, argIdVendor: Integer;
  argQtyScan, argCaseQty: Double; argCost, argSale, argSugg: Currency; argCalcTax: Boolean);
var
  _insert: TADOQuery;
begin
  try
      try
         _insert := TADOQuery.Create(nil);
         _insert.Connection := dm.ADODBConnect;
         _insert.SQL.Text := InsertReceivingSQL();
         _insert.Parameters.ParamByName('prm_idPurchaseItem').Value := GetNextID(MR_PURCHASE_ITEM_ID);
         _insert.Parameters.ParamByName('prm_idPurchase').Value := argIdPurchase;
         _insert.Parameters.ParamByName('prm_idModel').Value := argIdModel;
         _insert.Parameters.ParamByName('prm_qty').Value := argQtyScan;
         _insert.Parameters.ParamByName('prm_groupId').Value := argIdGroup;

         if ( argCalcTax ) then begin
            _insert.Parameters.ParamByName('prm_costWithTax').Value := ( argCost * argQtyScan );
            _insert.Parameters.ParamByName('prm_costPrice').Value := NULL;
            _insert.Parameters.ParamByName('prm_saleprice').Value := NULL;
            _insert.Parameters.ParamByName('prm_SuggRetail').Value := NULL;
         end else begin
                _insert.Parameters.ParamByName('prm_costWithTax').Value := NULL;
                _insert.Parameters.ParamByName('prm_costPrice').Value := argCost;
                _insert.Parameters.ParamByName('prm_saleprice').Value := argSale;
                _insert.Parameters.ParamByName('prm_SuggRetail').Value := argSugg;
             end;

         _insert.Parameters.ParamByName('prm_idVendor').Value := argIdVendor;
         _insert.Parameters.ParamByName('prm_idPreInventoryMov').Value := NULL;


         _insert.Parameters.ParamByName('prm_caseQty').Value := argCaseQty;
         _insert.Parameters.ParamByName('prm_caseCost').value := argCaseQty * argCost;

         _insert.ExecSQL();

      except
         on e:Exception do begin
            raise e.Create('Insert Receiving Failed ' + e.Message);
         end;
      end;
  finally
    FreeAndNil(_insert);
  end;

end;

procedure TDM.UpdateReceiving(argIdModel, argIdppItem: Integer;
  argCaseQtyScan, argQtyScan, argQtyRec: Double; argCostPrice: Currency; argCalcTax: Boolean);
var
  _update: TADOQuery;
begin
  try
      try
         _update := TADOQuery.Create(nil);
         _update.Connection := dm.ADODBConnect;
         _update.SQL.Text := UpdateReceivingSQL();
         _update.Parameters.ParamByName('prm_idmodel').Value := argIdModel;
         _update.Parameters.ParamByName('prm_idpurchase').Value := argIdppItem;
         _update.Parameters.ParamByName('prm_qty').Value := argQtyRec;

         if ( argCalcTax ) then begin
            _update.Parameters.ParamByName('prm_costprice').Value := (argCostPrice / argQtyRec) * argQtyScan;
         end else begin
                _update.Parameters.ParamByName('prm_costprice').Value := NULL;
             end;

         _update.ExecSQL();

      except
         on e: Exception do begin
            raise e.Create('Update Receiving Failed ' + e.Message);
         end;
      end;
  finally
      FreeAndNil(_update);
  end;
end;

function TDM.CreateReasonSQL: String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.Add('insert into Inv_MovReason ');
      sql.Add('(idmovreason, reason, hidden, system, desativado)');
      sql.Add('values (:prm_id, :prm_reason, :prm_hidden, :prm_system, :prm_desativado)');

      result := String (sql.GetText());

   finally
      FreeAndNil(sql);
   end;

end;

function TDM.DeleteReasonSQL: String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.Add('delete from Inv_MovReason ');
      sql.Add('where idmovreason = :prm_id');

      result := String (sql.GetText());

   finally
      FreeAndNil(sql);
   end;

end;

function TDM.ReadAllReason(): TObjectList;
var
   select: TADOQuery;
   reason: TAdjustReason;
   reasons: TOBjectList;
begin
   try
       result := nil;
       
       reasons := TObjectList.Create(True);

       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.SQL.Text := ReadAllReasonSQL();
       select.Open();
       try
          while ( not select.Eof ) do begin
              reason := TAdjustReason.Create();
              reason.Id := select.fieldByName('IdMovReason').Value;
              reason.Reason := select.fieldByName('Reason').Value;
              reason.Hidden := select.FieldByName('Hidden').Value;
              reason.System := select.FieldByName('System').Value;
              reason.Activated := select.FieldByName('Desativado').Value;
              reasons.Add(reason);

              select.Next();
          end;
          result := reasons;

       except
             on e:Exception do begin
                 raise e.Create('Cannot retrieve Adjust Reasons');
             end;

       end;
   finally
       FreeAndNil(select);
   end;
end;

function TDM.ReadAllReasonSQL: String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.Add('select * from Inv_MovReason ');

      result := String (sql.GetText());

   finally
      FreeAndNil(sql);
   end;

end;

function TDM.ReadReasonSQL: String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.Add('select * from Inv_MovReason ');
      sql.add(' where idmovreason = :prm_id');

      result := String (sql.GetText());

   finally
      FreeAndNil(sql);
   end;

end;

function TDM.UpdateReasonSQL: String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.Add('update Inv_MovReason ');
      sql.Add(' set reason = :prm_reason, hidden = :prm_hidden, system = :prm_system, desativado = :prm_desativado ');
      sql.add(' where idmovreason = :prm_id');
      result := String (sql.GetText());

   finally
      FreeAndNil(sql);
   end;

end;

procedure TDM.CreateReason(argReason: TAdjustReason);
var
  cmd: TADOQuery; // cmd stands command
  _idReason: Integer;
begin
   try
       cmd := TADOQuery.Create(nil);
       cmd.Connection := ADODBConnect;

       cmd.SQL.Text := CreateReasonSQL();

       _idReason := GetNextID('Inv_MovReason.IDMovReason');
       cmd.Parameters.ParamByName('prm_id').Value := _idReason;
       cmd.Parameters.ParamByName('prm_reason').Value := argReason.Reason;


       cmd.Parameters.ParamByName('prm_hidden').Value := FALSE;
       if ( argReason.Hidden = 1 ) then begin
           cmd.Parameters.ParamByName('prm_hidden').Value := TRUE;
       end;


       cmd.Parameters.ParamByName('prm_system').Value := FALSE;
       if ( argReason.System = 1 ) then begin
          cmd.Parameters.ParamByName('prm_system').Value := TRUE;
       end;

       cmd.Parameters.ParamByName('prm_desativado').Value := FALSE;
       if ( argReason.Activated = 1 ) then begin
          cmd.Parameters.ParamByName('prm_desativado').Value := TRUE;
       end;

       try
          ADODBConnect.BeginTrans();
          cmd.ExecSQL();
          ADODBConnect.CommitTrans();
       except
          on e: Exception do begin
             ADODBConnect.RollbackTrans();
             raise e.Create('Cannot create this Adjust Reason -> ' + e.Message );
          end;
       end;
   finally
      FreeAndNil(cmd);
   end;

end;

procedure TDM.DeleteReason(argId: Integer);
var
  cmd: TADOQuery; // cmd stands command
begin
   if ( not IsThereMovementReason(argId) ) then begin
       if (MsgBox(MSG_QST_CONFIRM, vbYesNo + vbQuestion) = vbYes) then begin
           try
               cmd := TADOQuery.Create(nil);
               cmd.Connection := ADODBConnect;

               cmd.SQL.Text := DeleteReasonSQL();
               cmd.Parameters.ParamByName('prm_id').Value := argId;

               try
                  ADODBConnect.BeginTrans();
                  cmd.ExecSQL();
                  ADODBConnect.CommitTrans();
               except
                  on e: Exception do begin
                     ADODBConnect.RollbackTrans();
                     raise e.Create('Cannot delete this Adjust Reason -> ' + e.Message );
                  end;
               end;
           finally
              FreeAndNil(cmd);
           end;
       end;
   end else begin
           raise Exception.Create('Cannot delete this adjust reason. Already exists movements to this reason');
       end;

end;

procedure TDM.UpdateReason(argReason: TAdjustReason);
var
  cmd: TADOQuery; // cmd stands command
begin
   try
       cmd := TADOQuery.Create(nil);
       cmd.Connection := ADODBConnect;

       cmd.SQL.Text := UpdateReasonSQL();
       cmd.Parameters.ParamByName('prm_id').Value := argReason.Id;
       cmd.Parameters.ParamByName('prm_reason').Value := argReason.Reason;

       cmd.Parameters.ParamByName('prm_hidden').Value := FALSE;
       if ( argReason.Hidden = 1 ) then begin
           cmd.Parameters.ParamByName('prm_hidden').Value := TRUE;
       end;


       cmd.Parameters.ParamByName('prm_system').Value := FALSE;
       if ( argReason.System = 1 ) then begin
          cmd.Parameters.ParamByName('prm_system').Value := TRUE;
       end;

       cmd.Parameters.ParamByName('prm_desativado').Value := FALSE;
       if ( argReason.Activated = 1 ) then begin
          cmd.Parameters.ParamByName('prm_desativado').Value := TRUE;
       end;

       try
          ADODBConnect.BeginTrans();
          cmd.ExecSQL();
          ADODBConnect.CommitTrans();
       except
          on e: Exception do begin
             ADODBConnect.RollbackTrans();
             raise e.Create('Cannot update this Adjust Reason -> ' + e.Message );
          end;
       end;
   finally
      FreeAndNil(cmd);
   end;

end;

function TDM.ReadReason(argId: Integer): TAdjustReason;
var
   select: TADOQuery;
   reason: TAdjustReason;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.SQL.Text := ReadReasonSQL();
       select.Parameters.ParamByName('prm_id').Value := argId;
       select.Open();

       // must to be exists just one row
       try
          reason := TAdjustReason.Create();
          reason.Id := select.fieldByName('IdMovReason').Value;
          reason.Reason := select.fieldByName('Reason').Value;
          reason.Hidden := select.FieldByName('Hidden').Value;
          reason.System := select.FieldByName('System').Value;
          reason.Activated := select.FieldByName('Desativado').Value;

          result := reason;

       except
             on e:Exception do begin
                 raise e.Create('Cannot retrieve that Adjust Reason');
             end;

       end;
   finally
       FreeAndNil(select);
   end;

end;

function TDM.IsThereMovementReasonSQL(): String;
var
  select: TStringList;
begin
  try
     select := TStringList.Create();
     select.add('select idinventorymov from Inv_MovComplement where idmovreason = :prm_id');
     result := String(select.GetText);
  finally
     FreeAndNil(select);
  end;

end;

function TDM.IsThereMovementReason(argId: Integer): Boolean;
var
   select: TADOQuery;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.SQL.Text := IsThereMovementReasonSQL();
       select.Parameters.ParamByName('prm_id').Value := argId;
       select.Open();

       // must to be exists just one row
       try
         result := ( select.RecordCount > 0 );

       except
             on e:Exception do begin
                 raise e.Create('Cannot retrieve movements that has adjust reason '+ e.Message);
             end;

       end;
   finally
       FreeAndNil(select);
   end;

end;

procedure TDM.DeactivateModel(argIdList: TStringList);
var
  update: TADOQuery;
begin
  try
     update := TADOQuery.Create(nil);
     update.Connection := ADODBConnect;
     try
//        ADODBConnect.BeginTrans();
        update.SQL.Text := DeactivateModelSQL();
        update.SQL.Add(' in (' + argIdList.GetText() + ')');
        update.ExecSQL();
     except
        on e: Exception do begin
//           ADODBConnect.RollbackTrans();
           e.Create('I cannot delete these Model records');
        end;
     end;
  finally
     FreeAndNil(update);
  end;

end;

function TDM.DeactivateModelSQL(): String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create();
      sql.add('update Model set desativado = 1');
      sql.Add(' where IdModel ');

      result := String(sql.GetText);

   finally
      FreeAndNil(sql);
   end;
end;

function TDM.FoundPaymentReferenceTypeSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create();
     sql.Add('select IdMeioPag, Tipo ');
     sql.add('from MeioPag ');
     sql.add('where Tipo = :prm_ref');

     result := String(sql.GetText);

  finally
     FreeAndNil(sql);
  end;

end;

function TDM.FoundPaymentReferenceType(payTypeRef: Integer): Integer;
var
   select: TADOQuery;
begin
   try
      select := TADOQuery.Create(nil);
      select.Connection := ADODBConnect;
      select.SQL.Text := FoundPaymentReferenceTypeSQL();
      select.Parameters.ParamByName('prm_ref').Value := payTypeRef;
      try
         select.Open();
         if ( select.FieldByName('IdMeioPag').IsNull ) then begin
            result := payTypeRef;
         end else begin
                 result := select.fieldByName('IdMeioPag').Value;
              end;
      except
         on e: Exception do begin
            raise e.Create('I cannot select payment type reference: ' + e.Message);
         end;
      end;
   finally
       FreeAndNil(select);
   end;

end;

function TDM.ReadCustomerInfoSQL(): String;
var
   sql: TStringList;
begin
   try
       sql := TStringList.Create();
       sql.Add('select IDPessoa, Pessoa, Email from Pessoa ');
       sql.Add(' where IdPessoa = :prm_id');

       result := String(sql.GetText);

   finally
       FreeAndNil(sql);
   end;

end;

function TDM.ReadCustomerInfo(argIdCustomer: Integer): TClientdataset;
begin
  result := getClientDatasetObject(ReadCustomerInfoSQL());
  result.Params.ParamByName('prm_id').Value := argIdCustomer;
  result.Open();
end;

function TDM.ActivateTagModelSQL(): String;
var
  sql: TStringList;
begin
  try
    sql := TStringList.Create();
    sql.Add('update TagModel set Active = :param_active');
    sql.Add(' where IdTag = :param_idTag');

    result := String(sql.GetText);

  finally
    freeAndNil(sql);
  end;

end;

procedure TDM.ActivateTagModel(argIdTag: Integer; argIdModelList: String; argActive: Boolean);
var
  sql: TStringList;
  cmd: TADOQuery;
begin
  try
     try

       sql := TStringList.Create();
       cmd := TADOQuery.Create(nil);
       cmd.Connection := ADODBConnect;

       sql.Add(ActivateTagModelSQL());
       sql.add(' and IdModel in ('+argIdmodelList+')');

       cmd.SQL.Add(sql.GetText);
       cmd.Parameters.ParamByName('param_idTag').Value := argIdTag;
       cmd.Parameters.ParamByName('param_active').Value := argActive;

       cmd.ExecSQL();
     except
       on e: Exception do begin
          raise e.Create(format('I cannot activate or deactivate models to IdTag = %d', [argIdTag]));
       end;
     end;

  finally
     FreeAndNil(sql);
     FreeAndNil(cmd);
  end;

end;

function TDM.GetModelsFromTagModel(idTag: Integer): TStringList;
var
   select: TADOQuery;
   tagName: String;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := dm.ADODBConnect;
       select.SQL.Add(GetModelsFromTagModelSQL());
       select.Parameters.ParamByName('param_idtag').Value := idTag;
       try
          select.Open();

          result := TStringList.create;

          while ( not select.Eof ) do begin
              result.Add('PKtag:'+select.fieldByName('PKTagModel').AsString + ';' +
                         'IdTag:'+select.fieldByName('IdTag').AsString + ';' +
                         'IdModel:'+select.FieldByName('IdModel').AsString);
              select.Next();
          end;

       tagName := dm.GetNameTag(idTag);

       except
          on e: Exception do begin
             raise e.Create(format('cannot get models from tag %s', [tagName]));
          end;

       end;
   finally
       freeAndNil(select);
   end;
end;

function TDM.GetModelsFromTagModelSQL: String;
var
  sql: TStringList;
begin
  try
    sql := TStringList.Create();

    sql.add('select tg.PkTagModel, tg.idtag, t.TagName, tg.IDModel, m.Model, m.Description ');
    sql.add('   from TagModel tg ');
    sql.add(' join Tag t on tg.IDTag = t.IDTag ');
    sql.add(' join Model m on tg.IdModel = m.IdModel ');
    sql.add('where tg.IdTag = :param_idtag');
    sql.Add(' and tg.Active = 1');

    result := String(sql.GetText);
  finally
    FreeAndNil(sql);
  end;

end;

function TDM.GetNameTag(idTag: Integer): String;
var
  select: TADOQuery;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := dm.ADODBConnect;
       select.SQL.Add(GetNameTagSQL());
       select.Parameters.ParamByName('param_idtag').Value := idTag;
       try
          select.Open();
          if ( not select.Eof ) then begin
              result := select.fieldByName('TagName').Value;
          end;

       except
          on e: Exception do begin
             raise e.Create('cannot get tag name' + e.message);
          end;

       end;
   finally
       freeAndNil(select);
   end;

end;

function TDM.GetNameTagSQL: String;
var
  sql: TStringList;
begin
  try
    sql := TStringList.Create;
    sql.Add('select * from Tag');
    sql.Add(' where IdTag = :param_idTag');
    result := String(sql.GetText);
  finally
    FreeAndNil(sql);
  end;

end;

function TDM.GetPromoSQL(): String;
var
  sql: TStringList;
begin
  try
    sql := TStringList.Create;

    sql.Add('select distinct p.*');
    sql.add(' from Discounts p');
    sql.add(' join DiscValidOnDays pd on p.IDDiscount = pd.IDDiscount ');
    sql.add(' where ( p.EndOn is null ) or ( p.EndOn >= :param_EndOn )');
    result := String(sql.GetText);
  finally
    FreeAndNil(sql);
  end;

end;

function TDM.GetPromos(endOnDate: TDateTime): TObjectList;
var
  select: TADOQuery;
  promo: TPromoDTO;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := dm.ADODBConnect;
       select.SQL.Add(GetPromoSQL());
       select.Parameters.ParamByName('param_EndOn').Value := endOnDate;
       try
          select.Open;
          result := TObjectList.Create();

          while ( not select.Eof ) do begin
             promo := TPromoDTO.create();
             promo.IDDiscount := select.fieldByName('IdDiscount').Value;
             promo.DiscountName := select.fieldByName('DiscountName').Value;
             promo.StartDate := VarToDateTime(select.fieldByName('StartOn').Value);
             promo.EndDate := varToDateTime(select.fieldByName('EndOn').Value);
             promo.BeginTimeOfDay := TimeOf(StrToTime(select.fieldByName('BeginTimeOfDay').Value));
             promo.EndTimeOfDay := TimeOf(StrToTime(select.fieldByName('EndTimeOfDay').Value));
             promo.DiscountType := select.fieldByName('DiscType').Value;
             result.Add(promo);

             select.Next();
          end;

       except
          on e: Exception do begin
             raise e.Create('cannot get crossing promotions ' + e.message);
          end;

       end;
   finally
       freeAndNil(select);
   end;

end;

function TDM.SeekForConflictOnTagsSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select t.idTag, t.tagName, tm.PKTagModel, tm.IdModel, m.model, m.description ');
     sql.add(' from Tag t');
     sql.add(' join TagModel tm on t.IdTag = tm.idTag');
     sql.add(' join Model m on tm.IdModel = m.IdModel ');
//     sql.add('where ( t.idTag in ( :param_idTagList ) and tm.idModel in ( :param_idModelList ) )');

     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;

end;

function TDM.SeekForConflictOnPromo(idModelList: String;
  idPromoList: TObjectList): TObjectList;
var
  select: TADOQuery;
  promo: TPromoDTO;
  idPromos: String;
  i: integer;
begin
   try

       for i:= 0 to idPromoList.Count - 1 do begin
           if ( idPromos = '' ) then begin
              idPromos := IntToStr(TPromoDTO(idPromoList[i]).IDDiscount);
           end else begin
                  idPromos := idPromos + ',' + IntToStr(TPromoDTO(idPromoList[i]).IDDiscount);
               end;

       end;

       select := TADOQuery.Create(nil);
       select.Connection := dm.ADODBConnect;
       select.SQL.Add(SeekForConflictOnPromosSQL());
       select.sql.add('where ( d.IdDiscount in ('+idPromos+') and tm.idModel in ('+idModelList+') )');
       select.sql.add(' and tm.Active = 1 ');
       result := TObjectList.Create(true);
       try
          select.Open();
          while ( not select.Eof ) do begin
             promo := TPromoDTO.create();
             promo.IDDiscount := select.fieldByName('IdDiscount').Value;
             promo.DiscountName := select.fieldByName('DiscountName').Value;
             promo.StartDate := VarToDateTime(select.fieldByName('StartOn').Value);
             promo.EndDate := VarToDateTime(select.fieldByName('EndOn').Value);
             promo.BeginTimeOfDay := TimeOf(StrToTime(select.fieldByName('BeginTimeOfDay').Value));
             promo.EndTimeOfDay := TimeOf(StrToTime(select.fieldByName('EndTimeOfDay').Value));
             promo.DiscountType := select.fieldByName('DiscType').Value;
             result.Add(promo);

             select.Next();
          end;

       except
          on e: Exception do begin
             raise e.Create('cannot get crossing promotions ' + e.message);
          end;

       end;
   finally
       freeAndNil(select);
   end;

end;

function TDM.SeekForConflictOnPromosSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select d.IdDiscount, d.DiscountName, d.StartOn, d.EndOn, d.BeginTimeOfDay, d.EndTimeOfDay, d.DiscType,');
     sql.add(' tg.IdTag, tg.TagName, tm.PKTagModel, tm.IdModel, m.Model, m.Description ');
     sql.add(' from Discounts d');
     sql.add(' join DiscQualifyingTags t on d.IDDiscount = t.IdDiscount');
     sql.add(' join TagModel tm on tm.IdTag = t.IdTag ');
     sql.add(' join Tag tg on tm.idTag = tg.idTag ');
     sql.add(' join Model m on m.IdModel = tm.IdModel ');
//     sql.add('where ( d.IdDiscount in ( :param_idPromoList ) and tm.idModel in ( :param_idModelList ) )');

     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;

end;

function TDM.SeekForConflictOnTag(idModelList,
  idtagList: String): TObjectList;
var
  select: TADOQuery;
  tag: TDiscountPurchase;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := dm.ADODBConnect;
       select.SQL.Add(SeekForConflictOnTagsSQL());
       select.sql.add('where ( t.idTag in ('+ idTagList+') and tm.idModel in ('+ idModelList+') )');
       select.SQL.add(' and tm.Active = 1 ');

       result := TObjectList.Create;

       try
          select.Open();
          while ( not select.Eof ) do begin
             tag := TDiscountPurchase.create();
             tag.setIDTag(select.fieldByName('IdTag').Value);
             tag.setName(select.fieldByName('TagName').Value);
             result.Add(tag);

             select.Next();
          end;

       except
          on e: Exception do begin
             raise e.Create('cannot get crossing tags ' + e.message);
          end;

       end;
   finally
       freeAndNil(select);
   end;


end;

function TDM.GetModelsFromPromoSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select d.IdDiscount, d.DiscountName, tm.IdModel, m.Model, m.Description ');
     sql.add(' from Discounts d');
     sql.add(' join DiscQualifyingTags t on d.IDDiscount = t.IdDiscount');
     sql.add(' join TagModel tm on tm.IdTag = t.IdTag ');
     sql.add(' join Model m on m.IdModel = tm.IdModel ');
     sql.add('where d.IdDiscount = :param_idPromo ');
     sql.add(' and tm.Active = 1');

     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;


end;

function TDM.GetModelsFromPromo(idPromo: Integer): String;
var
   select: TADOQuery;
   idModelList: String;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.sql.add(GetModelsFromPromoSQL());
       select.Parameters.ParamByName('param_idPromo').Value := idPromo;
       select.open();
       try
          while ( not select.Eof ) do begin
              if ( idModelList = '' ) then begin
                 idModelList := select.fieldByName('IdModel').AsString;
              end else begin
                     idModelList := idModelList + ',' + select.fieldByName('IdModel').AsString;
                  end;
              select.Next();
          end;
          result := idModelList;
       except
          on e: Exception do begin
             raise e.Create('Cannot retrieve models from the current promo '+ e.Message);
          end;
       end;
   finally
       FreeAndNil(select);
   end;

end;

function TDM.GetTagsFromPromo(idTagSelected: Integer; idPromo: Integer): String;
var
   select: TADOQuery;
   idTagList: String;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.sql.add(GetTagsFromPromoSQL());

       if ( idPromo > 0 ) then begin
          select.sql.add(' where IDDiscount = :param_idpromo');
          select.Parameters.ParamByName('param_idPromo').Value := idPromo;
       end;

       select.open();
       try
          while ( not select.Eof ) do begin

              // avoid to get same tag on the list
              if ( select.fieldByName('IdTag').AsInteger = idTagSelected ) then begin
                  select.next();
                  continue;
              end;

              if ( idTagList = '' ) then begin
                 idTagList := select.fieldByName('IdTag').AsString;
              end else begin
                     idTagList := idTagList + ',' + select.fieldByName('IdTag').AsString;
                  end;
              select.Next();
          end;
          result := idTagList;
       except
          on e: Exception do begin
             raise e.Create('Cannot retrieve tags from the current promo '+ e.Message);
          end;
       end;
   finally
       FreeAndNil(select);
   end;

end;

function TDM.GetTagsFromPromoSQL(): String;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select * from DiscQualifyingTags ');
     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;
end;

function TDM.GetModelsFromTagModel(idTag: String): TClientDataset;
begin
   result := getClientDatasetObject(GetModelsFromTagModelSQL());
   result.Params.ParamByName('param_idtag').Value := strToInt(idTag);
   try
      result.Open();
   except
      on e: Exception do begin
         raise e.Create('cannot get models from tag selected: '+ e.message);
      end;

   end;

end;

function TDM.SeekForConflictOnPromo(idPromoList: TObjectList;
  idModelList: String; toGridView: Integer): TClientDataset;
var
  i: Integer;
  idPromos: String;
  sql: TStringList;
begin
  for i:= 0 to idPromoList.Count - 1 do begin
       if ( idPromos = '' ) then begin
          idPromos := IntToStr(TPromoDTO(idPromoList[i]).IDDiscount);
       end else begin
              idPromos := idPromos + ',' + IntToStr(TPromoDTO(idPromoList[i]).IDDiscount);
           end;
  end;

  try
     sql := TStringList.Create;
     sql.Add(SeekForConflictOnPromosSQL());
     sql.Add('where ( d.IdDiscount in ('+idPromos+') and tm.idModel in ('+idModelList+'))');
     sql.add(' and tm.Active = 1');
     result := getClientDatasetObject(sql.Text);
     result.Open();

     FreeAndNil(sql);

  except
     on e: Exception do begin
        raise e.Create('Cannot retrieve promo conflict '+ e.message);
     end;
  end;
end;

function TDM.SeekForConflictOnTag(idTagList,
  idModelList: String; toGridView: Integer): TClientDataset;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add(SeekForConflictOnTagsSQL());
     sql.add('where ( t.idTag in ('+ idTagList+') and tm.idModel in ('+ idModelList+') )');
     sql.add(' and tm.Active = 1');
     result := getClientDatasetObject(sql.Text);
     result.Open();
  except
     on e: Exception do begin
        raise e.Create('Cannot retrieve conflict on tags '+ e.Message);
     end;

  end;

end;

function TDM.ActivateTagModelByPKSQL(): String;
var
  sql: TStringList;
begin
  try
    sql := TStringList.Create();
    sql.Add('update TagModel set Active = :param_active');
    result := String(sql.GetText);

  finally
    freeAndNil(sql);
  end;

end;

procedure TDM.ActivateTagModelByPK(pkTagModelList: String; argActive: Boolean = false);
var
  sql: TStringList;
  cmd: TADOQuery;
begin
  try
     try

       sql := TStringList.Create();
       cmd := TADOQuery.Create(nil);
       cmd.Connection := ADODBConnect;

       sql.Add(ActivateTagModelByPKSQL());
       sql.add('where ( PkTagModel in ('+ pkTagModelList+') )');
       cmd.SQL.Add(sql.GetText);
       cmd.Parameters.ParamByName('param_active').Value := 0;

       cmd.ExecSQL();
     except
       on e: Exception do begin
          raise e.Create('I cannot deactivate models: '+e.Message);
       end;
     end;

  finally
     FreeAndNil(sql);
     FreeAndNil(cmd);
  end;

end;

function TDM.DeletePurchaseTagListSQL(): String;
var
  sql: TStringList;
begin
  try
     // select * from DiscQualifyingTags where IDDiscount = 1 and IDTag in (1, 2, 3)
     sql := TStringList.Create;
     sql.Add('delete from DiscQualifyingTags where IdDiscount = :prm_promo');
     result := String(sql.GetText);
  finally
     FreeAndNil(sql);
  end;

end;

procedure TDM.DeletePurchaseTagList(idPromo: Integer; idTagList: String);
var
   cmd: TADOQuery;
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.add(DeletePurchaseTagListSQL);
      sql.add(' and IdTag in ('+ idTagList +')');

      try
         cmd := TADOQuery.Create(nil);
         cmd.Connection := ADODBConnect;
         cmd.SQL.Add(sql.GetText);
         cmd.Parameters.ParamByName('prm_promo').value := idPromo;
         cmd.ExecSQL();

      except
         on e: Exception do begin
            raise e.Create('Fail to delete tags in promo. '+e.Message);
         end;

      end;
   finally
      FreeAndNil(sql);
      FreeAndNil(cmd);
   end;


end;

function TDM.DeleteCouponListSQL: String;
var
  sql: TStringList;
begin
  try
     sql.Add('delete from DiscCoupons where IdDiscount = :prm_promo');
     result := String(sql.GetText);
  finally
     FreeAndNil(sql);
  end;

end;

procedure TDM.DeleteCouponList(idPromo: Integer; idCouponList: String);
var
   cmd: TADOQuery;
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.add(DeleteCouponListSQL());
      sql.add(' and Code in ('+ idCouponList +')');

      try
         cmd := TADOQuery.Create(nil);
         cmd.Connection := ADODBConnect;
         cmd.SQL.Add(sql.GetText);
         cmd.Parameters.ParamByName('prm_idPromo').value := idPromo;
         cmd.ExecSQL();

      except
         on e: Exception do begin
            raise e.Create('Fail to delete coupons in promo. '+e.Message);
         end;

      end;
   finally
      FreeAndNil(sql);
      FreeAndNil(cmd);
   end;

end;

function TDM.deleteRewardTagListSQL: string;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.Add('delete from DiscRewardTags where IdDiscount = :prm_promo');
     result := String(sql.GetText);
  finally
     FreeAndNil(sql);
  end;

end;

procedure TDM.deleteRewardTagList(idPromo: integer; idTagList: string);
var
   cmd: TADOQuery;
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.add(deleteRewardTagListSQL);
      sql.add(' and IdTag in ('+ idTagList +')');

      try
         cmd := TADOQuery.Create(nil);
         cmd.Connection := ADODBConnect;
         cmd.SQL.Add(sql.GetText);
         cmd.Parameters.ParamByName('prm_promo').value := idPromo;
         cmd.ExecSQL();

      except
         on e: Exception do begin
            raise e.Create('Fail to delete tags in promo. '+e.Message);
         end;

      end;
   finally
      FreeAndNil(sql);
      FreeAndNil(cmd);
   end;

end;


function TDM.getCurrentPromoDetails(): TClientdataset;
begin
  try
     result := getClientDatasetObject('select * from ufn_CurrentPromoDetailsJustBOGO()');
     result.open;
  except
     on e: Exception do begin
        raise e.Create('Error found to try get promo details');
     end;
  end;


end;

function TDM.getSalesWithBogoSQL: String;
var
   sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.Add('select p.IDPreInventoryMov,');
      sql.add('       p.documentID,');
      sql.Add('       p.modelId,');
      sql.add('       p.qty,');
      sql.Add('       m.description,');
      sql.Add('       p.salePrice,');
      sql.Add('       d.IdDiscount,');
      sql.Add('       d.discountName,');
      sql.Add('       d.MinQuantity,');
      sql.Add('       d.RewardQuantity,');
      sql.Add('       d.AmountType,');
      sql.Add('       coalesce(d.BuyAnd, 1, 0) buyAnd,');
      sql.Add('       0 ''TotalBuy'',');
      sql.Add('       0 ''TotalGet'',');
      sql.Add('       0 ''TotalOrphan'',');
      sql.Add(' from PreinventoryMov p ');
      sql.Add(' join Model m on p.ModelID = m.IDModel ');
      sql.Add(' join TagModel tm on m.ModelID = tm.IDModel ');
      sql.Add(' join Tag t on tm.IDTag = t.IDTag ');
      sql.Add(' join DiscQualifyingTags dt on t.IDTag = dt.IDTag ');
      sql.Add(' join Discounts d on d.IDDiscount = dt.IDDiscount ');
      sql.Add('where p.DocumentID = :param_documentID and d.IsBogo = 1');

      sql.Add(' union ');

      sql.Add('select p.IDPreInventoryMov,');
      sql.add('       p.documentID,');
      sql.Add('       p.modelId,');
      sql.add('       p.qty,');
      sql.Add('       m.description,');
      sql.Add('       p.salePrice,');
      sql.Add('       d.IdDiscount,');
      sql.Add('       d.discountName,');
      sql.Add('       d.MinQuantity,');
      sql.Add('       d.RewardQuantity,');
      sql.Add('       d.AmountType,');
      sql.Add('       coalesce(d.BuyAnd, 1, 0) getAnd,');
      sql.Add('       0 ''TotalBuy'',');
      sql.Add('       0 ''TotalGet'',');
      sql.Add('       0 ''TotalOrphan'',');
      sql.Add(' from PreinventoryMov p ');
      sql.Add(' join Model m on p.ModelID = m.IDModel ');
      sql.Add(' join TagModel tm on m.ModelID = tm.IDModel ');
      sql.Add(' join Tag t on tm.IDTag = t.IDTag ');
      sql.Add(' join DiscQualifyingTags dt on t.IDTag = dt.IDTag ');
      sql.Add(' join Discounts d on d.IDDiscount = dt.IDDiscount ');
      sql.Add('where p.DocumentID = :param_documentID and d.IsBogo = 1');

      result := String(sql.GetText);

   finally
      freeAndNil(sql);

   end;
end;

function TDM.getSalesWithBogo(documentID: integer): TClientdataset;
begin
     result := getClientDatasetObject(getSalesWithBogoSQL());
     result.Params.ParamByName('param_documentId').Value := documentId;
     result.open();
end;

function TDM.getSaleTotalBogosSQL: String;
var sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.add('select SUM(p.qty) total,');
      sql.add('p.DocumentID,');
      sql.add('p.ModelID,');
      sql.add('m.Description,');
      sql.add('d.iddiscount,');
      sql.Add('d.discountName,');
      sql.add('1 ''buy'' ');
      sql.add(' from PreInventoryMov p' );
      sql.add(' join model m on p.ModelID = m.IDModel' );
      sql.add(' join TagModel tm on m.IDModel = tm.IDModel' );
      sql.add(' join Tag t on tm.IDTag = t.IDTag');
      sql.add(' join DiscQualifyingTags dt on t.IDTag = dt.IDTag');
      sql.add(' join Discounts d on d.IDDiscount = dt.IDDiscount');
      sql.add(' where p.DocumentID = :param_documentID and d.IsBogo = 1 and p.modelID = :param_modelID');
      sql.add('group by p.DocumentID, ');
		sql.Add('      p.ModelID,');
      sql.add('      m.Description,');
      sql.Add('      d.iddiscount,');
      sql.add('      d.discountName');
      sql.add('select SUM(p.qty) total,');
      sql.add('p.DocumentID,');
      sql.add('p.ModelID,');
      sql.add('m.Description,');
      sql.add('d.iddiscount,');
      sql.Add('d.discountName,');
      sql.add('2 ''get''');
      sql.add(' from PreInventoryMov p' );
      sql.add(' join model m on p.ModelID = m.IDModel' );
      sql.add(' join TagModel tm on m.IDModel = tm.IDModel' );
      sql.add(' join Tag t on tm.IDTag = t.IDTag');
      sql.add(' join DiscQualifyingTags dt on t.IDTag = dt.IDTag');
      sql.add(' join Discounts d on d.IDDiscount = dt.IDDiscount');
      sql.add(' where p.DocumentID = :param_documentID and d.IsBogo = 1 and p.modelID = :param_modelID');
      sql.add('group by p.DocumentID, ');
		sql.Add('      p.ModelID,');
      sql.add('      m.Description,');
      sql.Add('      d.iddiscount,');
      sql.add('      d.discountName');

      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;

end;

function TDM.getSaleTotalBogos(documentID: integer; modelID: integer): integer;
var saleTotalBogos: TClientDataSet;
begin
  saleTotalBogos := getClientDatasetObject(getSaleTotalBogosSQL());
  saleTotalBogos.Params.ParamByName('param_documentID').Value := documentID;
  saleTotalBogos.Params.ParamByName('param_modelID').Value := modelID;
  saleTotalBogos.open();

  result := saleTotalBogos.fieldByName('total').Value;

end;

function TDM.getBogoOrphansFromSaleSQL(): string;
var sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.add('select * from PreinventoryMov p ');
      sql.add(' join Model m on p.modelID = m.idModel ');
      sql.add(' where p.DocumentID = :param_documentID ');
      result := String(sql.GetText);
   finally
      freeAndNil(sql);
   end;

end;

function TDM.getBogoOrphansFromSale(idPresale: integer;  IdPreInvMovList: string): TClientDataset;
var sql: TStringList;
begin
   try
      sql := TStringList.Create;
      sql.add(getBogoOrphansFromSaleSQL());
      sql.add(' and p.IdPreinventoryMov in (' + IdPreInvMovList + ')');
      result := getClientDatasetObject(String(sql.GetText));
      result.Params.ParamByName('param_documentID').Value := idPresale;
      result.Open();

   finally
      freeAndNil(sql);
   end;
end;

function TDM.SeekForConflictOnBogoPromoSQL(): string;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select d.IdDiscount, d.DiscountName, d.StartOn, d.EndOn, d.BeginTimeOfDay, d.EndTimeOfDay, d.DiscType,');
     sql.add(' tg.IdTag, tg.TagName, tm.PKTagModel, tm.IdModel, m.Model, m.Description ');
     sql.add(' from Discounts d');
     sql.add(' join DiscRewardTags t on d.IDDiscount = t.IdDiscount');
     sql.add(' join TagModel tm on tm.IdTag = t.IdTag ');
     sql.add(' join Tag tg on tm.idTag = tg.idTag ');
     sql.add(' join Model m on m.IdModel = tm.IdModel ');

     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;
end;

function TDM.SeekForConflictBogoPromo(idModelList: string;
  idPromoList: TObjectList): TObjectList;
var
  select: TADOQuery;
  promo: TPromoDTO;
  idPromos: String;
  i: integer;
begin
   try

       for i:= 0 to idPromoList.Count - 1 do begin
           if ( idPromos = '' ) then begin
              idPromos := IntToStr(TPromoDTO(idPromoList[i]).IDDiscount);
           end else begin
                  idPromos := idPromos + ',' + IntToStr(TPromoDTO(idPromoList[i]).IDDiscount);
               end;

       end;

       select := TADOQuery.Create(nil);
       select.Connection := dm.ADODBConnect;
       select.SQL.Add(SeekForConflictOnBogoPromoSQL());
       select.sql.add('where ( d.IdDiscount in ('+idPromos+') and tm.idModel in ('+idModelList+') )');
       select.sql.add(' and tm.Active = 1 ');
       result := TObjectList.Create(true);
       try
          select.Open();
          while ( not select.Eof ) do begin
             promo := TPromoDTO.create();
             promo.IDDiscount := select.fieldByName('IdDiscount').Value;
             promo.DiscountName := select.fieldByName('DiscountName').Value;
             promo.StartDate := VarToDateTime(select.fieldByName('StartOn').Value);
             promo.EndDate := VarToDateTime(select.fieldByName('EndOn').Value);
             promo.BeginTimeOfDay := TimeOf(StrToTime(select.fieldByName('BeginTimeOfDay').Value));
             promo.EndTimeOfDay := TimeOf(StrToTime(select.fieldByName('EndTimeOfDay').Value));
             promo.DiscountType := select.fieldByName('DiscType').Value;
             result.Add(promo);

             select.Next();
          end;

       except
          on e: Exception do begin
             raise e.Create('cannot get crossing promotions ' + e.message);
          end;

       end;
   finally
       freeAndNil(select);
   end;
end;

function TDM.GetTagsRewardFromPromoSQL: string;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select * from DiscRewardTags ');
     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;
end;

function TDM.GetTagsRewardFromPromo(idTagSelected,
  idPromo: Integer): string;
var
   select: TADOQuery;
   idTagList: String;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.sql.add(GetTagsRewardFromPromoSQL());

       if ( idPromo > 0 ) then begin
          select.sql.add( 'where IDDiscount = :param_idpromo');
          select.Parameters.ParamByName('param_idPromo').Value := idPromo;
       end;

       select.open();
       try
          while ( not select.Eof ) do begin

              // avoid to get same tag on the list
              if ( select.fieldByName('IdTag').AsInteger = idTagSelected ) then begin
                  select.next();
                  continue;
              end;

              if ( idTagList = '' ) then begin
                 idTagList := select.fieldByName('IdTag').AsString;
              end else begin
                     idTagList := idTagList + ',' + select.fieldByName('IdTag').AsString;
                  end;
              select.Next();
          end;
          result := idTagList;
       except
          on e: Exception do begin
             raise e.Create('Cannot retrieve tags from the current promo '+ e.Message);
          end;
       end;
   finally
       FreeAndNil(select);
   end;
end;

function TDM.GetModelsRewardFromPromoSQL(): string;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select * from DiscRewardTags where IDDiscount = :param_idpromo');
     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;
end;

function TDM.GetModelsRewardFromPromo(idpromo: integer): string;
var
   select: TADOQuery;
   idModelList: String;
begin
   try
       select := TADOQuery.Create(nil);
       select.Connection := ADODBConnect;
       select.sql.add(GetModelsRewardFromPromoSQL());
       select.Parameters.ParamByName('param_idPromo').Value := idPromo;
       select.open();
       try
          while ( not select.Eof ) do begin
              if ( idModelList = '' ) then begin
                 idModelList := select.fieldByName('IdModel').AsString;
              end else begin
                     idModelList := idModelList + ',' + select.fieldByName('IdModel').AsString;
                  end;
              select.Next();
          end;
          result := idModelList;
       except
          on e: Exception do begin
             raise e.Create('Cannot retrieve models from the current promo '+ e.Message);
          end;
       end;
   finally
       FreeAndNil(select);
   end;
end;

function TDM.GetCurrentPromoByDiscountType(endDate: TDateTime; discountType: string = 'Promo'; idPromo: integer = 0): TClientDataset;
begin
   try
       result := getClientDatasetObject(GetCurrentPromoByDiscountTypeSQL());
       result.Params.ParamByName('param_EndOn').Value := endDate;
       result.Params.ParamByName('param_DiscType').Value := endDate;
       result.Open();
   Except on e: Exception do begin
             raise e.Create('Cannot retrieve details from the current promo '+ e.Message);
          end;
   end;

end;

function TDM.GetCurrentPromoByDiscountTypeSQL(): string;
var
  sql: TStringList;
begin
  try
     sql := TStringList.Create;
     sql.add('select d.IdDiscount, d.DiscountName, D.DiscType, D.AmountType, D.RewardAmount, tm.IdModel, m.Model, m.Description');
     sql.add(' from Discounts d');
     sql.add(' join DiscQualifyingTags t on d.IDDiscount = t.IdDiscount');
     sql.add(' join TagModel tm on tm.IdTag = t.IdTag');
     sql.add(' join Model m on m.IdModel = tm.IdModel');
     sql.add(' join DiscValidOnDays pd on d.IDDiscount = pd.IDDiscount ');
     sql.add('where (d.EndOn is null) or (d.EndOn >= :param_EndOn)');
     sql.add(' and tm.Active = 1 ');
     sql.add(' and d.DiscType = :param_DiscType');

     result := String(sql.GetText);

  finally
     FreeAndNil(sql);

  end;
end;

end.























