unit uCCMercuryIntegration;

interface

uses Windows, SysUtils, Dialogs, DSICLIENTXLib_TLB, DSIPDCXLib_TLB, DSIEMVXLib_TLB, VER1000XLib_TLB, VER2000XLib_TLB, uXML,
  uCreditCardFunction, uOperationSystem, dbClient, classes, uSystemConst, OleCtrls, OleServer;


const
  ctab  = Chr(9);
  ccrlf = Chr(13) + Chr(10);

type

  TCCConfig = class
    FIpAddress       : String;   //IP address of server to use for this transaction. This address will override the addresses obtained via ServerIPConfig.
    FIpPort          : Integer;  //IP port number on server to use for this transaction. If omitted, default port is 9000.
    FMerchantID      : String;   //Merchant identification assigned by processor
    FDialUpBridge    : Boolean;
    FConnectTimeout  : Integer;
    FResponseTimeout : Integer;

    //amfsouza 12.26.2011
    FMercuryGiftIPPort: Integer;
    FMercuryGiftAddress: String;
    FTerminalID: String;
  end;

  TPinPad = class
    FVer1000X   : TVer1000X;
    FBaudRate   : String;
    FComPort    : String;
    FMsg        : String;
    FTimeout    : Integer;
    AXMLContent : TXMLContent;
    function ProcessRequest(FXML : WideString):String;
    public
      Constructor Create;
      Destructor Destroy; override;

      function InitializePinPad : Boolean;
      function SetBaudRate : Boolean;
      function GetPin(FAccountNo : String; FAmount: Currency; var FPINBlock, FDervdKey : String):Boolean;
      function CancelRequest : Boolean;
      function ResetPinPad : Boolean;
  end;

  TCCWidget  = class
  private
    function getTransactionErrorLevel: TTransactionErrorLevel;
    procedure setMercuryErrorsCode(const Value: TClientDataSet);
    function mappingCardType(arg_cardType: String): String;
  protected
    FChipMethod: String;
    // These labels just to chipmethod = 'chip'
    FAppLabel: String;
    FAppLabelAID: String;
    FAppLabelTVR: String;
    FAppLabelIAD: String;
    FAppLabelTSI: String;
    FAppLAbelARC: String;
    FAppLabelCVM: String;
    FAppLabelTranCode: String;
    FAppLabelRecordNo: String;

    FDateTransaction: String;
    FTimeTransaction: String;
    FMerchantID: String;
    FDeclinedDateTime: String;
    FCardType: String;
    FTrueCardTypeName: String;
    FEntryMethod: String;

    fProcessType: Integer;
    fSequenceNo: String;
    fAcctNoSecureDevice: String;
    fRecordNumberRequested: String;
    fMercuryResponse: TStringList;
    fDeviceName: TStringList;
    fDeviceInitialized: Boolean;
    FTransactionReturn     : TTransactionReturn;
    Ftax: Double;
    Faddress: String;
    fzip: String;
    FcvvData: String;
    FAcctNo                : String;     //Account number
    FExpDate               : String;     //Expiration date as MMYY
    FCustomerCode          : String;     //For Purchase Card Level II transactions – customer’s identifying information; such as PO number.
    FMemo                  : String;     //Identificador da transacao
    FOperatorID            : String;     //Operator (clerk, server, etc.) associated with the transaction
    FInvoiceNo             : String;     //Invoice number – the sequential receipt number or check number of the transaction.
    FRefNo                 : String;     //Usually the same data as the Invoice number. In some cases, the reference number returned by a previous transaction is required.
    FTrack2                : String;
    FCashier               : String;
    FPurchase              : Currency;   //Purchase price (with 2 place decimal – eg. 29.95)
    FAuthorize             : Currency;
    FErrorCode             : String;
    FResultAuth            : String;
    FResultAcqRefData      : String;
    FResultRefNo           : String;
    FLastDigits            : String;
    FBalance               : Currency;
    FMsgError              : String;
    FAuthCode              : String;
    FMsg                   : String;     //Msg Error ou Resultado de aprovacao da venda

    // Alex 09/27/2015
    FExecutionMode : String;

    // Antonio, September 16, 2013
    fCardNumberList: TStringList;

    fProcessorSelected: Integer;

    procedure setSequenceNo(const Value: String);
    procedure LoadRegistryValues;
    procedure setMercuryConfigGiftIntegration(arg_ipAddress: String);

    function getSecureSerialNumber(arg_serialNumber: String): String;
    function VerifyServerConfig : Boolean;
    function VerifyTransaction() : Boolean; virtual;
    procedure BeforeProcessCard;

    function GetFakeXMLSaleResult(): String;
    function GetFakeXMLVoidResult(): String;

  public
    // Alex 10/06/2015
    FIsSale : Boolean;

    FXMLResult             : WideString; //Resposta do XML do Servidor
    FXMLServer             : WideString; //Server XML
    FXMLSent               : WideString; //XML Enviado
    FXMLReceived           : WideString; //XML Recebido Aprovacao/Reprovacao
    FCardSwiped            : WideString; //String with the Swiped Card

    FCCConfig              : TCCConfig;
    FPinpad                : TPinPad;

    FXMLContent            : TXMLContent;
    FAfterSucessfullSwipe  : TAfterSucessfullSwipe;
    FOnNeedSwipe           : TNeedSwipeEvent;
    FOnNeedTroutD          : TNeedTroutDEvent;

    //amfsouza 12.01.2012
    FTransactionErrorLevel : TTransactionErrorLevel;
    FMercuryErrorsCode: TClientDataSet;

    Constructor Create;
    Destructor Destroy; override;

    property Msg: String read FMsg write FMsg;
    property Tax: Double read FTax write FTax;
    property Address: String read Faddress write fAddress;
    property Zip: String read fzip write FZip;
    property CVVData: String read FcvvData write FcvvData;
    property AcctNo: String read FAcctNo write FAcctNo;
    property ExpDate: String read FExpDate write FExpDate;
    property CustomerCode: String read FCustomerCode write FCustomerCode;
    property Memo: String read FMemo write fMemo;
    property OperatorID: String read FOperatorID write FOperatorID;
    property InvoiceNo: String read FInvoiceNo write FInvoiceNo;
    property RefNo: String read FRefNo write fRefNo;
    property Track2: String read FTrack2 write FTrack2;
    property Cashier: String read FCashier write FCashier;
    property Purchase: Currency read FPurchase write FPurchase;
    property Authorize: Currency read FAuthorize write FAuthorize;
    property ErrorCode: String read FErrorCode write FErrorCode;
    property ResultAuth: String read FResultAuth write FResultAuth;
    property ResultAcqRefData: String read FResultAcqRefData write FResultAcqRefData;
    property ResultRefNo: String read FResultRefNo write FResultRefNo;
    property LastDigits: String read FLastDigits write FLastDigits;
    property Balance: Currency read FBalance write FBalance;
    property ErrorMsg: String read FMsgError write FMsgError;
    property AuthCode: String read FAuthCode write FAuthCode;
    property RecordNumberRequested: String read fRecordNumberRequested write fRecordNumberRequested;

    //property Balance: Currency read FBalance;
    property MercuryErrorsCode: TClientDataSet write setMercuryErrorsCode;
    property TransactionErrorLevel: TTransactionErrorLevel read getTransactionErrorLevel;

    property TransactionReturn: TTransactionReturn read FTransactionReturn write FTransactionReturn;
    property OnNeedSwipe: TNeedSwipeEvent read FOnNeedSwipe write FOnNeedSwipe;
    property AfterSucessfullSwipe: TAfterSucessfullSwipe read FAfterSucessfullSwipe write FAfterSucessfullSwipe;
    property OnNeedTroutD: TNeedTroutDEvent read FOnNeedTroutD write FOnNeedTroutD;
    property DeviceInitialized: Boolean read fDeviceInitialized;
    property SequenceNo: String read fSequenceNo write setSequenceNo;
    property ProcessType: Integer read fProcessType write fProcessType;
    property DeclinedDateTime: String read FDeclinedDateTime write FDeclinedDateTime;
    property CardType: String read FCardType write FCardType;
    property EntryMethod: String read FEntryMethod write FEntryMethod;
    property MerchantID: String read FMerchantID write FMerchantID;
    property ChipMethod: String read FChipMethod write FChipMethod;
    property DateTransaction: String read FDateTransaction write FDateTransaction;
    property TimeTransaction: String read FTimeTransaction write FTimeTransaction;
    property AppLabel: String read FAppLabel write FAppLabel;
    property AppLabelAID: String read FAppLabelAID write FAppLabelAID;
    property AppLabelTVR: String read FAppLabelTVR write FAppLabelTVR;
    property AppLabelIAD: String read FAppLabelIAD write FAppLabelIAD;
    property AppLabelTSI: String read FAppLabelTSI write FAppLabelTSI;
    property AppLabelARC: String read FAppLabelARC write FAppLabelARC;
    property AppLabelCVM: String read FAppLabelCVM write FAppLabelCVM;
    property AppLabelTranCode : String read FAppLabelTranCode write FAppLabelTranCode;
    property AppLabelRecordNo : String read FAppLabelRecordNo  write FAppLabelRecordNo;

    function getMessageErrorCode(error_code: String): String; virtual;
    function ProcessSale : Boolean; virtual; abstract;
    function ProcessReturn : Boolean; virtual; abstract;

    // Antonio, September 16, 2013
    procedure setCardNumber(arg_cardNumber : String);
    procedure cleanupCardNumberList;
    function getActiveTransaction: TCCWidget; virtual; abstract;

    procedure setDeviceName(arg_name: String; arg_processType: Integer);
    function getDeviceName(arg_index: Integer): String;

  end;

  TCCredit  = class(TCCWidget)
    protected
      FCreditX               : TCCredit;
      function CreateSaleXML : String; virtual; abstract;
      function CreateReturnXML : String; virtual; abstract;
      function VoidSaleXML : String; virtual; abstract;
      function VoidReturnXML : String; virtual; abstract;
      function processCommand(FXML: WideString): Boolean; virtual; abstract;
      procedure BeforeVoid;
    public
      constructor create;
      destructor destroy; override;
      function getActiveTransaction: TCCWidget; override;
      function ProcessSale : Boolean; virtual;
      function ProcessReturn : Boolean; virtual;
      function VoidSale : Boolean; virtual;
      function VoidReturn : Boolean; virtual;
      procedure setCreditDevice(arg_processor: Integer; arg_type: Integer);
  end;

  TCCreditDSIClientx = class(TCCredit)
  private
  protected
    function CreateSaleXML : String; override;
    function CreateReturnXML : String; override;
    function VoidSaleXML : String; virtual;
    function VoidReturnXML : String; virtual;
    function processCommand(FXML: WideString): Boolean; override;
    procedure BeforeVoid;
  public
    FDevice: TDSICLientX;
    constructor create();
    destructor destroy; override;
    function ProcessSale : Boolean; override;
    function ProcessReturn : Boolean; override;
    function VoidSale : Boolean; override;
    function VoidReturn : Boolean; override;

  end;

  TCCreditDSIPDCx = class(TCCredit)
    private
      function initializeStatusXML(): String;
      procedure setAcctNoSecureDevice(arg_typeTransaction: String);
    protected
      function adjustByRecordNoXML(): String;
      function preAuthXML(): String;
      function preAuthByRecordNoXML(): String;
      function preAuthCaptureByRecordNoXML(): String;
      function CreateSaleXML(): String; override;
      function ResubmitSaleXML(): String;
      function CreateReturnXML(): String; override;
      function ResubmitReturnXML(): String;
      function ReturnByRecordNoXML(): String;
      function saleByRecordNoXML(): String;
      function voiceAuthXML(): String;
      function voidReturnByRecordNoXML(): String;
      function VoidSaleXML : String; virtual;
      function voidSaleByRecordNoXML(): String;
      function VoidReturnXML : String; virtual;
      function processCommand(FXML: WideString): Boolean; override;
      procedure BeforeVoid;
    public
      FDevice: TDsiPDCX;
      constructor create();

      function initializeStatus(): Boolean;
      function adjustByRecordNo(): Boolean;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;

  end;

  TCCreditDSIEMVx = class(TCCredit)
  private
    fDevice: TDsiEMVX;
    function getDeviceInfo(): WideString;
    protected
      function getEMVParamDownloadXML(): String;
      function getDeviceInfoXML(): String;
      function createPadResetXML(): String;
      function CreateSaleXML() : String; override;
      function resubmitSaleXML(): String;
      function VoidSaleXML() : String; virtual;
      function voidSaleByRecordNoXML(): string;
      function CreateReturnXML(): String; override; // In EMV doc match to RETURN Transaction ( Return = RETURN )
      function resubmitReturnXML(): String;
      function VoidReturnXML(): String; virtual;
      function voidReturnByRecordNoXML(): String; virtual;
      function emvVoiceAuthXML(): String;
      function emvZeroAuthXML(): String;
      function adjustByRecordNoXML(): String;
      function beforeTransaction(): Boolean;
      function afterTransaction(): Boolean;
      function processCommand(FXML: WideString): Boolean; override;
      function padReset: Boolean;

      procedure BeforeVoid;

    public
      constructor create();
      destructor destroy; override;
      function ProcessSale(): Boolean; override;
      function VoidSale(): Boolean; override;
      function voidSaleByRecordNo(): Boolean;
      function ProcessReturn(): Boolean; override;
      function VoidReturn(): Boolean; override;
      function voidReturnByRecordNo(): Boolean;
      function emvVoiceAuth(): Boolean;
      function emvZeroAuth(): Boolean;
      function adjustByRecordNo(): Boolean;
      function EMVParamDownload(): Boolean;

  end;


  TCDebit  = class(TCCWidget)
    FCashBack  : Currency;
    FPINBlock  : String;
    FDervdKey  : String;
    function GetPinNumber : Boolean;
    protected
      FDebitX: TCDebit;
      function CreateSaleXML : String; virtual; abstract;
      function CreateReturnXML : String; virtual; abstract;
      function processCommand(FXML: WideString): Boolean; virtual; abstract;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; virtual;
      function ProcessReturn : Boolean; virtual;
      procedure setDebitDevice(arg_processor: Integer; arg_type: Integer);
      function getActiveTransaction: TCCWidget; override;
  end;


  TCDebitDSiClientX = class(TCDebit)
    private
      FDevice: TDsiClientX;
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function processCommand(FXML: WideString): Boolean; override;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
  end;


  TCDebitDSIPDCx = class(TCDebit)
  private
      FDevice: TDsiPDCx;
  private
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function processCommand(FXML: WideString): Boolean; override;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
  end;


  TCDebitDSIEMVx = class(TCDebit)
  private
      FDevice: TDsiEMVx;
    protected
      function createPadResetXML(): String;
      function CreateSaleXML : String; override;
      function resubmitSaleXML(): String;
      function CreateReturnXML : String; override;
      function resubmitReturnXML(): String;
      function processCommand(FXML: WideString): Boolean; override;
      function beforeTransaction(): Boolean;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
  end;


  // amdfsouza 10.14.2011 - To GiftCard
  TCPrePaid = class(TCCredit)
    protected
      function prePaidIssueXML: String; virtual; abstract;
      function prePaidVoidIssueXML: String; virtual; abstract;
      function prePaidSaleXML: String; virtual; abstract;
      function CreateSaleXML : String; virtual; abstract;
      function CreateReturnXML : String; virtual; abstract;
      function VoidSaleXML : String; virtual; abstract;
      function VoidReturnXML : String; virtual; abstract;
      function prePaidReloadXML: String; virtual; abstract;
      function prePaidVoidReloadXML: String; virtual; abstract;
      function prePaidBalanceXML: String; virtual; abstract;
      function prePaidNoNSFSaleXML: String; virtual; abstract;
      function prePaidCashOutXML: String; virtual; abstract;
      function processCommand(FXML: WideString): Boolean; virtual; abstract;
    public
      FCreditX               : TCPrepaid; // testando...
      constructor create;
      function SwipCard: Boolean;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean; virtual;
      function prePaidVoidIssue: Boolean; virtual;
      function prePaidReload: Boolean; virtual;
      function prePaidVoidReload: Boolean; virtual;
      function prePaidBalance: Boolean; virtual;
      function prePaidNoNSFSale: Boolean; virtual;
      function prePaidCashOut: Boolean; virtual;

      // Antonio September 11, 2013
      function tryIssueCard(arg_salePrice: double): TTransactionReturn;
      function tryBalanceCard(arg_salePrice: double): TTransactionReturn;
      procedure setPrepaidDevice(arg_processor: Integer; arg_type: Integer);
   end;

   TCPrepaidDsiClientX = class(TCPrepaid)
   private
      FDevice: TDSICLientX;
    protected
      function prePaidIssueXML: String; override;
      function prePaidVoidIssueXML: String; override;
      function prePaidSaleXML: String; override;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String; override;
      function prePaidVoidReloadXML: String; override;
      function prePaidBalanceXML: String; override;
      function prePaidNoNSFSaleXML: String; override;
      function prePaidCashOutXML: String; override;
      function processCommand(FXML: WideString): Boolean; override;
    public
      function prepaidIssue: Boolean; override;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidVoidIssue: Boolean; override;
      function prePaidReload: Boolean; override;
      function prePaidVoidReload: Boolean; override;
      function prePaidBalance: Boolean; override;
      function prePaidNoNSFSale: Boolean; override;
      function prePaidCashOut: Boolean; override;

   end;

   TCPrepaidDsiPDCX = class(TCPrepaid)
   private
      FDevice: TDsiPDCX;
    protected
      function prePaidIssueXML: String; override;
      function prePaidVoidIssueXML: String; override;
      function prePaidSaleXML: String; override;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String; override;
      function prePaidVoidReloadXML: String; override;
      function prePaidBalanceXML: String; override;
      function prePaidNoNSFSaleXML: String; override;
      function prePaidCashOutXML: String; override;
      function processCommand(FXML: WideString): Boolean; override;
    public
      constructor create;
      destructor destroy();
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean; override;
      function prePaidVoidIssue: Boolean; override;
      function prePaidReload: Boolean; override;
      function prePaidVoidReload: Boolean; override;
      function prePaidBalance: Boolean; override;
      function prePaidNoNSFSale: Boolean; override;
      function prePaidCashOut: Boolean; override;
   end;

   TCPrepaidDsiEMVX = class(TCPrepaid)
   private
      FDevice: TDsiEMVX;
  private
    protected
      function prePaidIssueXML: String; override;
      function prePaidVoidIssueXML: String; override;
      function prePaidSaleXML: String; override;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String; override;
      function prePaidVoidReloadXML: String; override;
      function prePaidBalanceXML: String; override;
      function prePaidNoNSFSaleXML: String; override;
      function prePaidCashOutXML: String; override;
      function processCommand(FXML: WideString): Boolean; override;
    public
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean; override;
      function prePaidVoidIssue: Boolean; override;
      function prePaidReload: Boolean; override;
      function prePaidVoidReload: Boolean; override;
      function prePaidBalance: Boolean; override;
      function prePaidNoNSFSale: Boolean; override;
      function prePaidCashOut: Boolean; override;
   end;


implementation

uses Registry, uDebugFunctions, Controls, StrUtils, EMVAskingPopUp;

{ TCCredit }

procedure TCCredit.BeforeVoid;
var
  ATrouD, AInvNo, AAuthCode: WideString;
  ATroudCanceled: Boolean;
begin

  // Here we call an event in order to swipe the card
  if Assigned(FOnNeedTroutD) then
  begin
    ATroudCanceled := False;
    ATrouD         := '';
    AInvNo         := '';
    FOnNeedTroutD(Self, ATrouD, AInvNo, AAuthCode, ATroudCanceled);
    if ATroudCanceled then
      raise Exception.Create('Canceled by user');
    FInvoiceNo := AInvNo;
    FRefNo     := ATrouD;
    FAuthCode  := AAuthCode;
  end;

end;


constructor TCCredit.create;
begin
  inherited;
  fAcctNoSecureDevice := 'SecureDevice';
end;

destructor TCCredit.destroy;
begin
  freeAndNil(FCreditX);
  inherited;
end;

function TCCredit.ProcessReturn: Boolean;
begin
  BeforeProcessCard;
  Result := FCreditX.ProcessReturn();
end;


function TCCredit.ProcessSale: Boolean;
begin
  result := fCreditX.ProcessSale();
end;

procedure TCCredit.setCreditDevice(arg_processor: Integer; arg_type: Integer);
begin
   case ( arg_processor ) of
       PROCESSOR_MERCURY, PROCESSOR_WORLDPAY: begin
           case (arg_type) of
              PROCESSING_TYPE_DSICLIENTX: begin
                  FCreditX := TCCreditDSIClientx.create;
                  TCCreditDSIClientX(fcreditX).Tax := Tax;
                  TCCreditDSIClientX(fcreditX).Address := Address;
                  TCCreditDSIClientX(fcreditX).Zip := Zip;
                  TCCreditDSIClientX(fcreditX).CVVData := CVVData;
                  TCCreditDSIClientX(fcreditX).AcctNo := AcctNo;
                  TCCreditDSIClientX(fcreditX).ExpDate := ExpDate;
                  TCCreditDSIClientX(fcreditX).CustomerCode := CustomerCode;
                  TCCreditDSIClientX(fcreditX).Memo := Memo;
                  TCCreditDSIClientX(fcreditX).OperatorID := IfThen(FExecutionMode = 'T', 'test', OperatorID);
                  TCCreditDSIClientX(fcreditX).InvoiceNo := InvoiceNo;
                  TCCreditDSIClientX(fcreditX).RefNo := RefNo;
                  TCCreditDSIClientX(fcreditX).Track2 := Track2;
                  TCCreditDSIClientX(fcreditX).Cashier := Cashier;
                  TCCreditDSIClientX(fcreditX).Purchase := Purchase;
                  TCCreditDSIClientX(fcreditX).Authorize := Authorize;
              end;

              PROCESSING_TYPE_DSIPDCX: begin
                  FCreditX := TCCreditDSIPDCx.create;
                  TCCreditDSIPDCx(fcreditX).Tax := Tax;
                  TCCreditDSIPDCx(fcreditX).Address := Address;
                  TCCreditDSIPDCx(fcreditX).Zip := Zip;
                  TCCreditDSIPDCx(fcreditX).CVVData := CVVData;
                  TCCreditDSIPDCx(fcreditX).AcctNo := AcctNo;
                  TCCreditDSIPDCx(fcreditX).ExpDate := ExpDate;
                  TCCreditDSIPDCx(fcreditX).CustomerCode := CustomerCode;
                  TCCreditDSIPDCx(fcreditX).Memo := Memo;
                  TCCreditDSIPDCx(fcreditX).OperatorID := IfThen(FExecutionMode = 'T', 'test', OperatorID);
                  TCCreditDSIPDCx(fcreditX).InvoiceNo := InvoiceNo;
                  TCCreditDSIPDCx(fcreditX).RefNo := RefNo;
                  TCCreditDSIPDCx(fcreditX).Track2 := Track2;
                  TCCreditDSIPDCx(fcreditX).Cashier := Cashier;
                  TCCreditDSIPDCx(fcreditX).Purchase := Purchase;
                  TCCreditDSIPDCx(fcreditX).Authorize := Authorize;

              end;

              PROCESSING_TYPE_DSIEMVUS: begin
                  FCreditX := TCCreditDSIEMVx.create;
                  TCCreditDSIEMVx(fcreditX).Tax := Tax;
                  TCCreditDSIEMVx(fcreditX).Address := Address;
                  TCCreditDSIEMVx(fcreditX).Zip := Zip;
                  TCCreditDSIEMVx(fcreditX).CVVData := CVVData;
                  TCCreditDSIEMVx(fcreditX).AcctNo := AcctNo;
                  TCCreditDSIEMVx(fcreditX).ExpDate := ExpDate;
                  TCCreditDSIEMVx(fcreditX).CustomerCode := CustomerCode;
                  TCCreditDSIEMVx(fcreditX).Memo := Memo;
                  TCCreditDSIEMVx(fcreditX).OperatorID := IfThen(FExecutionMode = 'T', 'test', OperatorID);
                  TCCreditDSIEMVx(fcreditX).InvoiceNo := InvoiceNo;
                  TCCreditDSIEMVx(fcreditX).RefNo := RefNo;
                  TCCreditDSIEMVx(fcreditX).Track2 := Track2;
                  TCCreditDSIEMVx(fcreditX).Cashier := Cashier;
                  TCCreditDSIEMVx(fcreditX).Purchase := Purchase;
                  TCCreditDSIEMVx(fcreditX).Authorize := Authorize;
              end;

           end;
       end;
   end;
end;

function TCCredit.VoidReturn: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := FCreditX.VoidReturn();
end;


function TCCredit.VoidSale: Boolean;
begin
  result := FCreditX.voidSale();
end;

function TCCredit.getActiveTransaction: TCCWidget;
begin
  result := FCreditX as TCCWidget;
end;

{ TCDebit }

constructor TCDebit.Create;
begin
  inherited;
  fAcctNoSecureDevice := 'SecureDevice'; 
end;


destructor TCDebit.Destroy;
begin
  freeAndNil(FDebitX);
  inherited;
end;

function TCDebit.GetPinNumber: Boolean;
var
  sPINBlock, sDervdKey : String;
begin

  {
  Do not use this INIT before each transaction—it can cause slowdowns and even
  freeze the processing altogether. The little 1000se has just enough memory to
  hold on to the INIT so we have found, after the initial INIT is established
  it only need to be reinitialized should there be a com break of some kind.
  Some systems do this upon daily start up but if this is not done,
  there should really not be a need.
  }
  //if ( FMPinPad.InitializePinPad ) then
  Result := FPinPad.GetPin(FAcctNo, FPurchase, sPINBlock, sDervdKey);

  FMsg      := FPinPad.FMsg;
  FPINBlock := sPINBlock;
  FDervdKey := sDervdKey;

  if not Result then
    raise Exception.Create(FMsg);

end;

function TCDebit.getActiveTransaction: TCCWidget;
begin
  result := FDebitX as TCCWidget;
end;

function TCDebit.ProcessReturn: Boolean;
begin
//  Result := False;
//  BeforeProcessCard;
//  Result := GetPinNumber;
//  if Result then
    Result := FDebitX.processReturn();
end;

function TCDebit.ProcessSale: Boolean;
begin
  // Alex 09/09/2015 - Removed because I can't figure it out
  //Result := False;
  //BeforeProcessCard;
  //Result := GetPinNumber;
  //if Result then
  //  Result := FDebitX.ProcessSale();
  Result := FDebitX.ProcessSale();
end;



procedure TCDebit.setDebitDevice(arg_processor: Integer; arg_type: Integer);
begin
   case ( arg_processor ) of
       PROCESSOR_MERCURY, PROCESSOR_WORLDPAY: begin
           case (arg_type) of
              PROCESSING_TYPE_DSICLIENTX: begin
                  FDebitX := TCDebitDSiClientX.create;
                  TCDebitDSiClientX(FDebitX).Tax := Tax;
                  TCDebitDSiClientX(FDebitX).Address := Address;
                  TCDebitDSiClientX(FDebitX).Zip := Zip;
                  TCDebitDSiClientX(FDebitX).CVVData := CVVData;
                  TCDebitDSiClientX(FDebitX).AcctNo := AcctNo;
                  TCDebitDSiClientX(FDebitX).ExpDate := ExpDate;
                  TCDebitDSiClientX(FDebitX).CustomerCode := CustomerCode;
                  TCDebitDSiClientX(FDebitX).Memo := Memo;
                  TCDebitDSiClientX(FDebitX).OperatorID := IfThen(FExecutionMode = 'T', 'test', OperatorID);
                  TCDebitDSiClientX(FDebitX).InvoiceNo := InvoiceNo;
                  TCDebitDSiClientX(FDebitX).RefNo := RefNo;
                  TCDebitDSiClientX(FDebitX).Track2 := Track2;
                  TCDebitDSiClientX(FDebitX).Cashier := Cashier;
                  TCDebitDSiClientX(FDebitX).Purchase := Purchase;
                  TCDebitDSiClientX(FDebitX).Authorize := Authorize;
              end;

              PROCESSING_TYPE_DSIPDCX: begin
                  FDebitX := TCDebitDSIPDCx.create;
                  TCDebitDSIPDCx(FDebitX).Tax := Tax;
                  TCDebitDSIPDCx(FDebitX).Address := Address;
                  TCDebitDSIPDCx(FDebitX).Zip := Zip;
                  TCDebitDSIPDCx(FDebitX).CVVData := CVVData;
                  TCDebitDSIPDCx(FDebitX).AcctNo := AcctNo;
                  TCDebitDSIPDCx(FDebitX).ExpDate := ExpDate;
                  TCDebitDSIPDCx(FDebitX).CustomerCode := CustomerCode;
                  TCDebitDSIPDCx(FDebitX).Memo := Memo;
                  TCDebitDSIPDCx(FDebitX).OperatorID := IfThen(FExecutionMode = 'T', 'test', OperatorID);
                  TCDebitDSIPDCx(FDebitX).InvoiceNo := InvoiceNo;
                  TCDebitDSIPDCx(FDebitX).RefNo := RefNo;
                  TCDebitDSIPDCx(FDebitX).Track2 := Track2;
                  TCDebitDSIPDCx(FDebitX).Cashier := Cashier;
                  TCDebitDSIPDCx(FDebitX).Purchase := Purchase;
                  TCDebitDSIPDCx(FDebitX).Authorize := Authorize;
              end;

              PROCESSING_TYPE_DSIEMVUS: begin
                  FDebitX := TCDebitDSIEMVx.create;
                  TCDebitDSIEMVx(FDebitX).Tax := Tax;
                  TCDebitDSIEMVx(FDebitX).Address := Address;
                  TCDebitDSIEMVx(FDebitX).Zip := Zip;
                  TCDebitDSIEMVx(FDebitX).CVVData := CVVData;
                  TCDebitDSIEMVx(FDebitX).AcctNo := AcctNo;
                  TCDebitDSIEMVx(FDebitX).ExpDate := ExpDate;
                  TCDebitDSIEMVx(FDebitX).CustomerCode := CustomerCode;
                  TCDebitDSIEMVx(FDebitX).Memo := Memo;
                  TCDebitDSIEMVx(FDebitX).OperatorID := IfThen(FExecutionMode = 'T', 'test', OperatorID);
                  TCDebitDSIEMVx(FDebitX).InvoiceNo := InvoiceNo;
                  TCDebitDSIEMVx(FDebitX).RefNo := RefNo;
                  TCDebitDSIEMVx(FDebitX).Track2 := Track2;
                  TCDebitDSIEMVx(FDebitX).Cashier := Cashier;
                  TCDebitDSIEMVx(FDebitX).Purchase := Purchase;
                  TCDebitDSIEMVx(FDebitX).Authorize := Authorize;
              end;
           end;
       end;
   end;
end;

{ TPinPad }

function TPinPad.CancelRequest: Boolean;
begin
  try
    FVer1000X.CancelRequest;
    Result := True;
  except
    Result := False;
  end;
end;

constructor TPinPad.Create;
begin
  FVer1000X   := TVer1000x.Create(nil);
  AXMLContent := TXMLContent.Create;
end;

destructor TPinPad.Destroy;
begin
  FreeAndNil(FVer1000X);
  FreeAndNil(AXMLContent);
  inherited;
end;

function TPinPad.GetPin(FAccountNo: String; FAmount: Currency;
  var FPINBlock, FDervdKey: String): Boolean;
var
  strRequest, AResult: string;
begin

  try

    strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                  ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                  ctab + ctab + '<Command>GetPin</Command>' + ccrlf +
                  ctab + ctab + '<Timeout>' + IntToStr(FTimeout) + '</Timeout>' + ccrlf +
                  ctab + ctab + '<AccountNo>' + FAccountNo + '</AccountNo>' + ccrlf +
                  ctab + ctab + '<Amount>' + FormatFloat('0.00', FAmount) + '</Amount>' + ccrlf +
                  '</RequestStream>';

    FMsg := '';
    AXMLContent.XML := ProcessRequest(strRequest);

    AResult := AXMLContent.GetAttributeString('CmdStatus');

    if AResult <> 'Success' then
    begin
      FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
              AXMLContent.GetAttributeString('TextResponse');
      Result := False;
    end
    else
    begin
      FPINBlock := AXMLContent.GetAttributeString('PINBlock');
      FDervdKey := AXMLContent.GetAttributeString('DervdKey');
      Result := True;
    end;
  finally
    ResetPinPad;
    end;

end;

function TPinPad.InitializePinPad: Boolean;
var
  strRequest, AResult: string;
begin

  strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                ctab + ctab + '<Command>Init</Command>' + ccrlf +
                ctab + ctab + '<IdlePrompt>' + 'MainRetail' + '</IdlePrompt>' + ccrlf +
                '</RequestStream>';
  FMsg := '';
  AXMLContent.XML := ProcessRequest(strRequest);

  AResult := AXMLContent.GetAttributeString('CmdStatus');

  if AResult <> 'Success' then
  begin
    FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
            AXMLContent.GetAttributeString('TextResponse');
    Result := False;
  end
  else
    Result := True;

end;

function TPinPad.ProcessRequest(FXML: WideString): String;
begin
   Result := FVer1000X.ProcessRequest(FXML, 0);
end;

function TPinPad.ResetPinPad: Boolean;
var
  strRequest, AResult: string;
begin

  strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                ctab + ctab + '<Command>ResetPinPad</Command>' + ccrlf +
                '</RequestStream>';

  FMsg := '';
  AXMLContent.XML := ProcessRequest(strRequest);

  AResult := AXMLContent.GetAttributeString('CmdStatus');

  if AResult <> 'Success' then
  begin
    FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
            AXMLContent.GetAttributeString('TextResponse');
    Result := False;
  end
  else
    Result := True;

end;

function TPinPad.SetBaudRate: Boolean;
var
  strRequest, AResult: string;
begin

  strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                ctab + ctab + '<Command>SetBaudRate</Command>' + ccrlf +
                '</RequestStream>';

  FMsg := '';
  AXMLContent.XML := ProcessRequest(strRequest);

  AResult := AXMLContent.GetAttributeString('CmdStatus');

  if AResult <> 'Success' then
  begin
    FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
            AXMLContent.GetAttributeString('TextResponse');
    Result := False;
  end
  else
    Result := True;

end;


{ TCCWidget }

procedure TCCWidget.BeforeProcessCard; // specific to dsiClientX
var
  ASwipedTrack: WideString;
  ASwipeCanceled, ASwipeError: Boolean;
  sCard, sName, sDate, sTrack2 : WideString;
  assignedObject: TCCWidget;
begin

  // Here we call an event in order to swipe the card
  if Assigned(FOnNeedSwipe) then
  begin
    repeat
      ASwipeCanceled := False;
      ASwipeError    := False;

      if ( FCardSwiped = '' ) then begin
        FOnNeedSwipe(Self, ASwipedTrack, ASwipeCanceled);
        sCard := AswipedTrack;
      end
      else
        ASwipedTrack := FCardSwiped;

      if ASwipedTrack = '' then
        ASwipeCanceled := True;

      try
        ParseTrack(ASwipedTrack, sCard, sName, sDate, sTrack2);
        FTrack2  := sTrack2;
        FAcctNo  := sCard;
        FExpDate := sDate;
      except
        ASwipeError := True;
        raise Exception.Create('Card track not recognized');
      end;

      if ASwipeCanceled then
        raise Exception.Create('Card Swipe canceled by user');

    until not (ASwipeCanceled or ASwipeError)
  end;

  if Assigned(FAfterSucessfullSwipe) then
     FAfterSucessfullSwipe(Self, FAcctNo, FCustomerCode, FExpDate);

end;

procedure TCCWidget.cleanupCardNumberList;
begin
  fCardNumberList.Clear;
end;

constructor TCCWidget.Create;
begin

  // Alex 09/27/2015
  //FExecutionMode := 'T'; // Testing

  FExecutionMode := 'P'; // Production
  FIsSale := True; // Testing

  FXMLContent := TXMLContent.Create;
  FCCConfig   := TCCConfig.Create;
  FMercuryErrorsCode := TClientDataset.Create(nil);

  FPinPad := TPinPad.Create;

  FTransactionReturn := ttrException;

  fDeviceName := TStringList.Create();

  LoadRegistryValues;

  // Antonio, September 16, 2013
  fCardNumberList := TStringList.Create;
  fCardNumberList.Duplicates := dupError;
  fcardNumberList.Sorted := true;

  fMercuryResponse := TStringList.Create;

end;

destructor TCCWidget.Destroy;
begin
  FreeAndNil(FXMLContent);
  FreeAndNil(FCCConfig);
  freeAndNil(FMercuryErrorsCode);
  freeAndNil(fCardNumberList);
  freeAndNil(FDeviceName);
  freeAndNil(fMercuryResponse);
  inherited;
end;

function TCCWidget.getDeviceName(arg_index: Integer): String;
begin
  result := fDeviceName.Strings[arg_index];
end;

function TCCWidget.getMessageErrorCode(error_code: String): String;
begin
  FMercuryErrorsCode.Filter := 'CodeNumber = ' + error_code;
  FMercuryErrorsCode.Filtered := true;

  FTransactionErrorLevel := FMercuryErrorsCode.fieldByName('ErrorLevel').Value;

  FMsgError := FMercuryErrorsCode.fieldByname('PinogyCodeText').Value;

  result := FMercuryErrorsCode.fieldByname('PinogyCodeText').Value;

end;

function TCCWidget.getSecureSerialNumber(arg_serialNumber: String): String;
var
  serialSubPart: String;
begin
  serialSubPart := copy(arg_serialNumber, ( length(arg_serialNumber) - 6), 6);
  result := stringReplace(arg_serialNumber, serialSubPart, 'XXXXXX', [rfReplaceAll, rfIgnoreCase]);
end;

function TCCWidget.getTransactionErrorLevel: TTransactionErrorLevel;
begin
   result := FTransactionErrorLevel;
end;

procedure TCCWidget.LoadRegistryValues;
var
  buildInfo: String;
begin

 with TRegistry.Create do
 try

   // aponta para a chave CURRENT_USER se Windows 7
   if ( getOs(buildInfo) = osW7 ) then
     RootKey := HKEY_CURRENT_USER
   else
     RootKey := HKEY_LOCAL_MACHINE;

   OpenKey(REGISTRY_PATH, True);

   FCCConfig.FConnectTimeout     := ReadInteger('MercuryConnectTimeout');

   FCCConfig.FResponseTimeout    := ReadInteger('MercuryResponseTimeout');

   FCCConfig.FMerchantID         := ReadString('MercuryMerchatID');

   FCCConfig.FIpPort             := ReadInteger('MercuryIPPort');

   FCCConfig.FDialUpBridge       := ReadBool('MercuryDialUpBridge');

   FCCConfig.FIpAddress          := ReadString('MercuryIPs');


   //amfsouza 12.26.2011 - Mercury Gift Card settings.
   FCCConfig.FMercuryGiftIPPort  := ReadInteger('MercuryGiftIPPort');

   FCCConfig.FMercuryGiftAddress := readString('MercuryGiftIPs');

   // Antonio 2013 Oct 23, MR-74
   setMercuryConfigGiftIntegration(FCCConfig.FIpAddress);

   //Antonio:  get Pinpad device from Registry
   FPinpad.FComPort := ReadString('PinPadComm');

   fProcessType := readInteger('processType'); // dsi, pdcx or emv
   fProcessorSelected  := readInteger('processorType');
   setDeviceName(readString('PinPadDevice'), fProcessType);

   // Antonio 06/30/2016: TerminalID to EMV
   FCCConfig.FTerminalID := ReadString('TerminalID');

   try
     fDeviceInitialized := ( (readInteger('DeviceInitialized') = 1) or (readInteger('DeviceInitialized') = 2) );
   except
     writeInteger('DeviceInitialized', 0);
   end;

 finally
   Free;
 end;

end;



function TCCWidget.mappingCardType(arg_cardType: String): String;
begin
  if ( lowercase(arg_cardtype) = 'visa' ) then begin
     result := 'VISA';
  end else if ( lowercase(arg_cardType) = 'm/c' ) then begin
         result := 'MASTERCARD';
      end else if ( lowercase(arg_cardType) = 'amex' ) then begin
             result := 'AMEX';
          end else if ( lowercase(arg_cardType) = 'dcvr' ) then begin
                 result := 'DISCOVER';
              end else if ( lowercase(arg_cardType) = 'dclb' ) then begin
                     result := 'DINERS';
                  end else if ( lowercase(arg_cardType) = 'jcb' ) then begin
                         result := 'JCB';
                      end else if ( lowercase(arg_cardType) = 'debit' ) then begin
                             result := 'DEBIT';
                          end else begin
                                 result := 'OTHER';
                              end;
end;

procedure TCCWidget.setCardNumber(arg_cardNumber: String);
begin
   try
     if ( FTransactionReturn = ttrSuccessfull ) then
        fCardNumberList.Add(arg_cardNumber);
   except
     raise;
   end;
end;

procedure TCCWidget.setDeviceName(arg_name: String; arg_processType: Integer);
begin

  case fProcessorSelected of
      PROCESSOR_MERCURY: begin
          case arg_processType of
              PROCESSING_TYPE_DSIPDCX, PROCESSING_TYPE_DSIEMVUS : begin
                  if ( ansipos('Ingenico', arg_name) > 0 ) then begin
                      fDeviceName.add('ISC250');
                      fDeviceName.add('INGENICOISC250_MERCURY_E2E');
                  end else if ( ansipos('Verifone', arg_name) > 0 ) then begin
                              fDeviceName.add('VX805'); // 0
                              fDeviceName.add('VX805XPI_MERCURY_E2E'); // 1
                              fDeviceName.add('EMV_VX805_MERCURY'); // 2
                      end;
              end;
          end;
      end;

      PROCESSOR_WORLDPAY: begin
          case arg_processType of
              PROCESSING_TYPE_DSIPDCX, PROCESSING_TYPE_DSIEMVUS : begin
                  if ( ansipos('Ingenico', arg_name) > 0 ) then begin
                      fDeviceName.add('ISC250');
                      fDeviceName.add('INGENICOISC250_MERCURY_E2E');
                  end else if ( ansipos('Verifone', arg_name) > 0 ) then begin
                              fDeviceName.add('VX805'); // 0
                              fDeviceName.add('VX805XPI_CTLS'); // 1
                              fDeviceName.add('EMV_VX805_WORLDPAY'); // 2
                      end;
              end;
          end;
      end;

  end;


end;

procedure TCCWidget.setMercuryConfigGiftIntegration(arg_ipAddress: String);
begin
//   debugtofile('Set Mercury Config Gift Integration when IP address is blank');
   if ( trim(arg_ipAddress) = '' ) then begin
//      debugtofile('Ip Address before: ' + fccconfig.FIpAddress);
      FCCConfig.FIpAddress := fccConfig.FMercuryGiftAddress;
//      debugtofile('Ip Address after will be Mercury Gift IpAddress: ' + fccconfig.FIpAddress);
//      debugtofile('IP Port before: ' + inttoSTr(fccconfig.fipport));
      FCCConfig.FIpPort    := FCCConfig.FMercuryGiftIPPort;
//      debugtofile('IP Port after: ' + intToStr(fccconfig.fipport));
   end;
end;

procedure TCCWidget.setMercuryErrorsCode(const Value: TClientDataSet);
begin
   FMercuryErrorsCode := Value;
end;

procedure TCCWidget.setSequenceNo(const Value: String);
begin
  try
    if ( trim(value) = '' ) then begin
       fSequenceNo := '0010010010';
    end else begin
           fSequenceNo := Value;
        end;
  except
      fSequenceNo := '0010010010';
  end;
end;

function TCCWidget.VerifyServerConfig: Boolean;
var
  AResult : String;
  IResult : Integer;
begin

  try

    FXMLContent.XML := FXMLResult;
//    debugtofile('XML(connection) result from Mercury: ' + FXMLContent.xml);

    Result  := False;
    AResult := '';

    //Indicates the outcome of the command:
    //“Success” = command completed successfully
    //“Error” = error processing command. Check DSIXReturnCode and TextResponse for additional info on error
    AResult := FXMLContent.GetAttributeString('CmdStatus');

    //Six digit return code which identifies the error type. See Section 3 on error codes for possible values
    IResult := FXMLContent.GetAttributeInteger('DSIXReturnCode');

    if (AResult = 'Success') then
    begin
      Result := True;
      FTransactionReturn := ttrSuccessfull;
    end
    else
    begin
      FTransactionReturn := ttrError;
      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');

      // Antonio, August 05, 2013
      FMsg := AResult;
      debugtofile('connection error: ' + fMSG);

    end;

    FMsg := AResult;

  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      FMsg := E.Message;
      debugtofile('Connection had an Exception: ' + fmsg);
    end;
  end;
end;


function TCCreditDSIClientx.VoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TCCreditDSIPDCx.CreateSaleXML: String;
var
  strRequest: string;
  secureDevice : String;
begin

  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FInvoiceNo + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.ProcessReturn: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     setAcctNoSecureDevice('SecureDevice');
     result := processCommand(CreateReturnXML);

     // CmdStatus and TextResponse from Mercury
     if ( (fMercuryResponse.Strings[0] = 'Error') and
        ( (fMercuryResponse.Strings[1] = 'Cancelled.') or (fMercuryResponse.Strings[1] = 'Cancelled at POS.') ) ) then begin
        result := processCommand(resubmitReturnXML);
     end;

  end;
end;

function TCCreditDSIPDCx.ProcessSale: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     setAcctNoSecureDevice('SecureDevice');
     result := processCommand(CreateSaleXML);

     // CmdStatus and TextResponse from Mercury
     if ( (fMercuryResponse.Strings[0] = 'Error') and
        ( (fMercuryResponse.Strings[1] = 'Cancelled.') or (fMercuryResponse.Strings[1] = 'Cancelled at POS.') ) ) then begin
        result := processCommand(resubmitSaleXML);
     end;
  end;
end;

function TCCreditDSIPDCx.VoidReturn: Boolean;
begin
  if ( fDeviceInitialized ) then begin
      BeforeVoid;
      result := processCommand(VoidReturnXML);
  end;
end;

function TCCreditDSIPDCx.VoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>SecureDevice</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' + ccrlf +
//                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.VoidSale: Boolean;
begin
  if ( fDeviceInitialized ) then begin
      BeforeVoid;
      result := processCommand(VoidSaleXML);
  end;
end;

function TCCreditDSIPDCx.VoidSaleXML: String;
var
  strRequest: string;
  secureDevice: String;
begin

  strRequest := '';

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>SecureDevice</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' + ccrlf +
///                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;


function TCCWidget.VerifyTransaction: Boolean;
var
  AResult : String;
  IResult : Integer;
begin

  try

    FXMLContent.XML := FXMLResult;
    Result := False;
    FMsg   := '';

    fMercuryResponse.Clear();

    //Indicates the outcome of the command:
    //"Success" = command completed successfully
    //"Error" = error processing command. Check DSIXReturnCode and TextResponse for additional info on error
    AResult := FXMLContent.GetAttributeString('CmdStatus');
    fMercuryResponse.add(AResult);

    //Six digit return code which identifies the error type. See Section 3 on error codes for possible values
    IResult := FXMLContent.GetAttributeInteger('DSIXReturnCode');

    if (AResult = 'Approved') then
    begin
      FAuthCode := FXMLContent.GetAttributeString('AuthCode');
      FResultAcqRefData := FXMLContent.GetAttributeString('AcqRefData');
      FRefNo := FXMLContent.GetAttributeString('RefNo');

      //Alex 09/25/2015
      FAcctNo := FXMLContent.GetAttributeString('AcctNo');
      FLastDigits := Copy(Trim(FAcctNo), Length(Trim(FAcctNo)) - 3, 4);
      FMerchantID := FCCConfig.FMerchantID;

      FPurchase := FXMLcontent.GetAttributeDouble('Purchase');
      FAuthorize := FXMLContent.GetAttributeDouble('Authorize');
      SequenceNo := FXMLContent.GetAttributeString('SequenceNo');

      // # true name from XML response
      FTrueCardTypeName := FXMLContent.GetAttributeString('CardType');
      // # name mapped to assign correct IdMeioPag
      FCardType := mappingCardType(FTrueCardTypeName);
      FEntryMethod := FXMlContent.GetAttributeString('EntryMethod');
      FAppLabel := FXMLContent.GetAttributeString('ApplicationLabel');

      // to EMV transactions
      //showmessage('chip method = ' + fChipMethod);
      if ( FChipMethod = 'chip' ) then begin
         //showmessage('getting EMV fields ' + #13 + fXMLContent.XML);
         FDateTransaction := FXMLContent.GetAttributeString('Date');
         FTimeTransaction := FXMLContent.GetAttributeString('Time');
         FAppLabelAID := FXMLContent.GetAttributeString('AID');
         FAppLabelTVR := FXMLContent.GetAttributeString('TVR');
         FAppLabelIAD := FXMLContent.GetAttributeString('IAD');
         FAppLabelTSI := FXMLContent.GetAttributeString('TSI');
         FAppLAbelARC := FXMLContent.GetAttributeString('ARC');
         FAppLabelCVM := FXMLContent.GetAttributeString('CVM');
         FAppLabelTranCode := FXMLContent.GetAttributeString('TranCode');
         FAppLabelRecordNo := FXMLContent.GetAttributeString('RecordNo');
      end;

      // Antonio 2013 Oct 28,  MR-80
      if ( FXMLContent.GetAttributeString('TranCode') = 'Return' ) then begin
         FPurchase := ((-1) * FPurchase);
         FAuthorize:= ((-1) * FAuthorize);
      end;

      FMsg               := AResult;
      FTransactionReturn := ttrSuccessfull;
      Result             := True;
    end
    else
    begin
     // # see declined transaction and get info to receipt declined
      if (AResult = 'Declined') then begin
        FTransactionReturn := ttrDeclined;
        FAcctNo := FXMLContent.GetAttributeString('AcctNo');
        FLastDigits := Copy(Trim(FAcctNo), Length(Trim(FAcctNo)) - 3, 4);
        FMerchantID := FCCConfig.FMerchantID;
        FCardType := FXMLContent.GetAttributeString('CardType');
        FEntryMethod := FXMlContent.GetAttributeString('EntryMethod');
        FDeclinedDateTime := FXMLContent.GetAttributeString('Date') + ' Time: ' + FXMLContent.GetAttributeString('Time');

        // to EMV transactions
        if ( FChipMethod = 'chip' ) then begin
           FDateTransaction := FXMLContent.GetAttributeString('Date');
           FTimeTransaction := FXMLContent.GetAttributeString('Time');
           FAppLabelAID := FXMLContent.GetAttributeString('AID');
           FAppLabelTVR := FXMLContent.GetAttributeString('TVR');
           FAppLabelIAD := FXMLContent.GetAttributeString('IAD');
           FAppLabelTSI := FXMLContent.GetAttributeString('TSI');
           FAppLAbelARC := FXMLContent.GetAttributeString('ARC');
           FAppLabelCVM := FXMLContent.GetAttributeString('CVM');
           FAppLabelTranCode := FXMLContent.GetAttributeString('TranCode');
           FAppLabelRecordNo := FXMLContent.GetAttributeString('RecordNo');
        end;

      end
      else begin
        FTransactionReturn := ttrError;
      end;
      FErrorCode           := IntToStr(IResult);
      FMsg                 := 'Code: ' + IntToStr(IResult);
      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');
      fMercuryResponse.Add(AResult);

      FMsg := FMsg + '. ' + AResult;
    end;

  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      raise Exception.Create('Exception: ' + E.Message);
    end;
  end;

end;

{ TCPrePaid }
constructor TCPrePaid.create;
begin
  inherited;
end;

function TCPrePaid.prePaidBalance: Boolean;
begin
  result := FCreditX.prePaidBalance();
end;

function TCPrePaid.prePaidCashOut: Boolean;
begin
  result := FCreditX.prePaidCashOut();
end;


function TCPrePaid.prePaidIssue: Boolean;
begin
    result := FCreditX.prePaidIssue();
end;

function TCPrePaid.prePaidNoNSFSale: Boolean;
begin
   result := FCreditX.prepaidNONsFSale();
end;

function TCPrePaid.prePaidReload: Boolean;
begin
   result := FCreditX.prePaidReload();
end;

function TCPrePaid.prePaidVoidIssue: Boolean;
begin
  BeforeVoid;
  result := FCreditX.prePaidVoidIssue();
end;

function TCPrePaid.prePaidVoidReload: Boolean;
begin
  BeforeVoid;
  result := FCreditX.prePaidVoidReload();
end;

function TCPrePaid.ProcessReturn: Boolean;
begin
  result := FCreditX.VoidReturn();
end;

function TCPrePaid.ProcessSale: Boolean;
begin
   result := FCreditX.processSale();
end;

procedure TCPrePaid.setPrepaidDevice(arg_processor, arg_type: Integer);
begin
   case ( arg_processor ) of
       PROCESSOR_MERCURY, PROCESSOR_WORLDPAY: begin
           case (arg_type) of
              PROCESSING_TYPE_DSICLIENTX: begin
                  //FCreditX := TCCreditDSIClientx.create;
                  FCreditX := TCPrepaidDsiClientX.create;
                  TCPrepaidDsiClientX(fcreditX).Tax := Tax;
                  TCPrepaidDsiClientX(fcreditX).Address := Address;
                  TCPrepaidDsiClientX(fcreditX).Zip := Zip;
                  TCPrepaidDsiClientX(fcreditX).CVVData := CVVData;
                  TCPrepaidDsiClientX(fcreditX).AcctNo := AcctNo;
                  TCPrepaidDsiClientX(fcreditX).ExpDate := ExpDate;
                  TCPrepaidDsiClientX(fcreditX).CustomerCode := CustomerCode;
                  TCPrepaidDsiClientX(fcreditX).Memo := Memo;
                  TCPrepaidDsiClientX(fcreditX).OperatorID := 'test'; // OperatorID;  Alex - 09-27-2015
                  TCPrepaidDsiClientX(fcreditX).InvoiceNo := InvoiceNo;
                  TCPrepaidDsiClientX(fcreditX).RefNo := RefNo;
                  TCPrepaidDsiClientX(fcreditX).Track2 := Track2;
                  TCPrepaidDsiClientX(fcreditX).Cashier := Cashier;
                  TCPrepaidDsiClientX(fcreditX).Purchase := Purchase;
                  TCPrepaidDsiClientX(fcreditX).Authorize := Authorize;
              end;

              PROCESSING_TYPE_DSIPDCX: begin
//                  FCreditX := TCCreditDSIPDCx.create;
                  FCreditX := TCPrepaidDsiPDCX.create;
                  TCPrepaidDsiPDCX(fcreditX).Tax := Tax;
                  TCPrepaidDsiPDCX(fcreditX).Address := Address;
                  TCPrepaidDsiPDCX(fcreditX).Zip := Zip;
                  TCPrepaidDsiPDCX(fcreditX).CVVData := CVVData;
                  TCPrepaidDsiPDCX(fcreditX).AcctNo := AcctNo;
                  TCPrepaidDsiPDCX(fcreditX).ExpDate := ExpDate;
                  TCPrepaidDsiPDCX(fcreditX).CustomerCode := CustomerCode;
                  TCPrepaidDsiPDCX(fcreditX).Memo := Memo;
                  TCPrepaidDsiPDCX(fcreditX).OperatorID := 'test'; // OperatorID;  Alex - 09-27-2015
                  TCPrepaidDsiPDCX(fcreditX).InvoiceNo := InvoiceNo;
                  TCPrepaidDsiPDCX(fcreditX).RefNo := RefNo;
                  TCPrepaidDsiPDCX(fcreditX).Track2 := Track2;
                  TCPrepaidDsiPDCX(fcreditX).Cashier := Cashier;
                  TCPrepaidDsiPDCX(fcreditX).Purchase := Purchase;
                  TCPrepaidDsiPDCX(fcreditX).Authorize := Authorize;

              end;

              PROCESSING_TYPE_DSIEMVUS: begin
//                  FCreditX := TCCreditDSIEMVx.create;
                  FCreditX := TCPrepaidDsiEMVX.create;
                  TCPrepaidDsiEMVX(fcreditX).Tax := Tax;
                  TCPrepaidDsiEMVX(fcreditX).Address := Address;
                  TCPrepaidDsiEMVX(fcreditX).Zip := Zip;
                  TCPrepaidDsiEMVX(fcreditX).CVVData := CVVData;
                  TCPrepaidDsiEMVX(fcreditX).AcctNo := AcctNo;
                  TCPrepaidDsiEMVX(fcreditX).ExpDate := ExpDate;
                  TCPrepaidDsiEMVX(fcreditX).CustomerCode := CustomerCode;
                  TCPrepaidDsiEMVX(fcreditX).Memo := Memo;
                  TCPrepaidDsiEMVX(fcreditX).OperatorID := 'test'; // OperatorID;  Alex - 09-27-2015
                  TCPrepaidDsiEMVX(fcreditX).InvoiceNo := InvoiceNo;
                  TCPrepaidDsiEMVX(fcreditX).RefNo := RefNo;
                  TCPrepaidDsiEMVX(fcreditX).Track2 := Track2;
                  TCPrepaidDsiEMVX(FcreditX).Cashier := Cashier;
                  TCPrepaidDsiEMVX(fcreditX).Purchase := Purchase;
                  TCPrepaidDsiEMVX(fcreditX).Authorize := Authorize;
              end;

           end;
       end;
   end;
end;

function TCPrePaid.SwipCard: Boolean;
begin
  result := false;
  try
     BeforeProcessCard;
     result := true;
  except

  end;
end;

function TCPrePaid.tryBalanceCard(
  arg_salePrice: double): TTransactionReturn;
var
  msg: String;
  msgButtonSelected: Integer;
  balanceToBeAdded: double;
begin
  prePaidBalance();
  result := fTransactionReturn;

  // Antonio, 2013 Oct 19 - (MR-67)
  if ( FXMLContent.GetAttributeString('CmdStatus') = 'Approved' ) then begin
     balanceToBeAdded := Fbalance + arg_saleprice;
     msg := Format('Card %s already issued.'+#13#10+' New balance will be %f', [self.getSecureSerialNumber(self.FAcctNo),balanceToBeAdded]);
     messageDlg(msg, mtInformation, [mbOK], 0);
  end;
end;

function TCPrePaid.tryIssueCard(arg_salePrice: double): TTransactionReturn;
var
  msg: String;
  msgButtonSelected: Integer;
begin
  self.prePaidIssue;

  result := fTransactionReturn;

  if ( FXMLContent.GetAttributeString('CmdStatus') = 'Approved' ) then begin
        result := fTransactionReturn;
  end
  else begin
        msg := ' Card Declined. Try again.';
        MessageDlg(msg, mtError, [mbOk], 0);
        result := fTransactionReturn;
   end;
end;

function TCPrePaid.VoidReturn: Boolean;
begin
    result := FCreditX.VoidReturn();
end;

function TCPrePaid.VoidSale: Boolean;
begin
    result := FCreditX.VoidSale();
end;

{ TCreditDSIClientx }

procedure TCCreditDSIClientx.BeforeVoid;
begin
  inherited;
end;

constructor TCCreditDSIClientx.create;
begin
   inherited;
   FDevice := TDSICLientX.Create(nil);
end;

function TCCreditDSIClientx.CreateReturnXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIClientx.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' +FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;


  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
    // Account Info - Manual
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                  ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                  ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

destructor TCCreditDSIClientx.destroy;
begin
  freeAndNil(Fdevice);
  inherited;
end;

function TCCreditDSIClientx.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
    FDevice.SetConnectTimeout(FCCConfig.FConnectTimeout);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
    FDevice.SetResponseTimeout(FCCConfig.FResponseTimeout);
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes
  FXMLResult := FDevice.ServerIPConfig(FCCConfig.FIpAddress, 0);

  FXMLServer := FXMLResult;

  if VerifyServerConfig then
  begin
    //Params:
    //1 - BSTR XML Command – An XML formatted string containing the details of the transaction request. See subsequent sections on available XML commands, formats and usage.
    //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
    //   0 Process using visible dialog boxes
    //   1 Process without using visible dialog boxes
    //   2 Process asynchronously without visible dialog boxes and fire an event
    //3 - ClientServerPassword – A password consisting of 1-12 characters which is defined by the server. If the server is configured such that a ClientServerPassword is not required, then a null string should be supplied.
    //4 - UserTraceData – Optional value which will be returned unaltered with response to allow application to identify a particular response.
    FXMLSent     := FXML;

//    showmessage('dsi xml sent ' + fxmlSent);

    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;

//    showmessage('dsi xml response ' + FXMLResult);

    if VerifyTransaction then
      Result := True;
  end;

end;

function TCCreditDSIClientx.ProcessReturn: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreateReturnXML);
end;

function TCCreditDSIClientx.ProcessSale: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreateSaleXML);
end;


function TCCreditDSIClientx.VoidReturn: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreateReturnXML);
end;

function TCCreditDSIClientx.VoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIClientx.VoidSale: Boolean;
begin
  BeforeVoid();
  BeforeProcessCard();
  result := processCommand(VoidSaleXML);
end;


{ TCCreditDSIPDCx }

procedure TCCreditDSIPDCx.BeforeVoid;
begin

end;

constructor TCCreditDSIPDCx.create;
begin
   inherited;
   FDevice := TDsiPDCX.Create(nil);
end;

function TCCreditDSIPDCx.CreateReturnXML: String;
var
  strRequest: string;
  secureDevice: String;
begin
  secureDevice := fAcctNoSecureDevice;


  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FInvoiceNo + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TCCreditDSIPDCx.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
    FDevice.SetConnectTimeout(FCCConfig.FConnectTimeout);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
    FDevice.SetResponseTimeout(FCCConfig.FResponseTimeout);
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes

  FXMLResult := FDevice.ServerIPConfig(FCCConfig.FIpAddress, 0);

  FXMLServer := FXMLResult;

  if VerifyServerConfig then
  begin
    //Params:
    //1 - BSTR XML Command – An XML formatted string containing the details of the transaction request. See subsequent sections on available XML commands, formats and usage.
    //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
    //   0 Process using visible dialog boxes
    //   1 Process without using visible dialog boxes
    //   2 Process asynchronously without visible dialog boxes and fire an event
    //3 - ClientServerPassword – A password consisting of 1-12 characters which is defined by the server. If the server is configured such that a ClientServerPassword is not required, then a null string should be supplied.
    //4 - UserTraceData – Optional value which will be returned unaltered with response to allow application to identify a particular response.
    FXMLSent     := FXML;

//    showmessage('pdcx xml sent : ' + fxmlsent);
    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
//    showmessage('pdcx xml response : ' + fxmlresult);

    FXMLReceived := FXMLResult;
    if VerifyTransaction then
       Result := True;

  end;
end;


function TCCreditDSIPDCx.initializeStatus(): Boolean;
var
  FUserTraceData: String;
begin
   FXMLSent     := initializeStatusXML;

   FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
   FXMLReceived := FXMLResult;

   FXMLContent.XML := FXMLResult;
   fDeviceInitialized := ( FXMLContent.GetAttributeString('CmdStatus')  = 'Success' );

   result := fDeviceInitialized

end;

function TCCreditDSIPDCx.initializeStatusXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<TranType>Setup</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>SecureDeviceInit</TranCode>' + ccrlf +
                ctab + ctab + '<PadType>' + fDeviceName.Strings[0] + '</PadType>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Admin>' + ccrlf +
            strRequest +
            ctab + '</Admin>' + ccrlf +
            '</TStream>';
end;


function TCCreditDSIPDCx.adjustByRecordNo: Boolean;
begin

end;

function TCCreditDSIPDCx.AdjustByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
  manualTransaction: Boolean;
begin

  if ( manualTransaction ) then begin
     secureDevice := 'Prompt';
  end else begin
         secureDevice := 'SecureDevice';
      end;

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>AdjustByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.preAuthXML: String;
var
  strRequest: string;
  secureDevice: String;
  manualTransaction: Boolean;
begin

  if ( manualTransaction ) then begin
     secureDevice := 'Prompt';
  end else begin
         secureDevice := 'SecureDevice';
      end;

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>PreAuth</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<Authorize>' + FAuthCode + '</Authorize>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.preAuthByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
  manualTransaction: Boolean;
begin

  if ( manualTransaction ) then begin
     secureDevice := 'Prompt';
  end else begin
         secureDevice := 'SecureDevice';
      end;

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>PreAuthByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<Authorize>' + FAuthCode + '</Authorize>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.preAuthCaptureByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
  manualTransaction: Boolean;
begin

  if ( manualTransaction ) then begin
     secureDevice := 'Prompt';
  end else begin
         secureDevice := 'SecureDevice';
      end;

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>PreAuthCaptureByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<Authorize>' + FAuthCode + '</Authorize>' + ccrlf +
                ctab + ctab + '<Gratuity>Gratuity</Gratuity>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData +'</AcqRefData>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.returnByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
begin
  secureDevice := fAcctNoSecureDevice;


  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>ReturnByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>' + fRecordNumberRequested + '</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.saleByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>SaleByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>' + fRecordNumberRequested + '</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.voiceAuthXML: String;
var
  strRequest: string;
  secureDevice: String;
begin
  secureDevice := fAcctNoSecureDevice;


  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoiceAuth</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>' +fRecordNumberRequested +'</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;



function TCCreditDSIPDCx.voidReturnByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
begin

  secureDevice := 'SecureDevice';

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturnByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TCCreditDSIPDCx.voidSaleByRecordNoXML: String;
var
  strRequest: string;
  secureDevice: String;
begin

  secureDevice := 'SecureDevice';

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSaleByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

procedure TCCreditDSIPDCx.setAcctNoSecureDevice(
  arg_typeTransaction: String);
begin
  fAcctNoSecureDevice := arg_typeTransaction;
end;

function TCCreditDSIPDCx.resubmitSaleXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest :=
         ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FInvoiceNo + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIPDCx.resubmitReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FInvoiceNo + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

{ TCCreditDSIEMVx }

function TCCreditDSIEMVx.adjustByRecordNo: Boolean;
begin
   result := processCommand(adjustByRecordNoXML);
end;

function TCCreditDSIEMVx.adjustByRecordNoXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVAdjustByRecordNo</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				    //ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				    ctab + ctab + '</Amount>' + ccrlf +
				    //ctab + ctab + '<LaneID>' + LaneID + '</LaneID>' + ccrlf +
				    //ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                //ctab + ctab + '<PartialAuth>' + fPartialAuth + '</PartialAuth>' + ccrlf +
                ctab + ctab + '<RecordNo>' + FRefNo + '</RecordNo>' + ccrlf +
                //ctab + ctab + '<Frequency>' + FFrequency + '</Frequency>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' ;
                //ctab + ctab + '<ProcessData>' + FProcessData + '</ProcessData>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.afterTransaction: Boolean;
begin
  ProcessCommand(createPadResetXML);
end;

function TCCreditDSIEMVx.beforeTransaction: Boolean;
var
   status: String;
   seqNo: String;
begin
  result := ProcessCommand(createPadResetXML);

  status := FXMLContent.GetAttributeString('CmdStatus');


  if ( status = 'Success' ) then begin
     SeqNo := FXMLContent.GetAttributeString('SequenceNo');
     setSequenceNo(seqNo);
  end;


end;

procedure TCCreditDSIEMVx.BeforeVoid;
begin

end;

constructor TCCreditDSIEMVx.create;
begin
  inherited;
  FDevice := TDsiEMVX.Create(nil);

end;

function TCCreditDSIEMVx.createPadResetXML: String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<OperatorID> ' + FOperatorID + ' </OperatorID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVPadReset</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
		      	ctab + ctab + '<SequenceNo>0010010010</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.CreateReturnXML: String;
var
  strRequest: string;
  returnPurchase: Double;
begin

  returnPurchase := Fpurchase * (-1);

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(Abs(returnPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.CreateSaleXML(): String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
			   	ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

destructor TCCreditDSIEMVx.destroy;
begin
  freeAndNil(FDevice);
  inherited;
end;

function TCCreditDSIEMVx.EMVParamDownload: Boolean;
var
   status: String;
   seqNo: String;
begin
  processCommand(getEMVParamDownloadXML);
  status := FXMLContent.GetAttributeString('CmdStatus');

  if ( status = 'Success' ) then begin
     SeqNo := FXMLContent.GetAttributeString('SequenceNo');
     setSequenceNo(seqNo);
  end;

  result := ( status = 'Success');

end;

function TCCreditDSIEMVx.emvVoiceAuth: Boolean;
begin
   beforeTransaction();
   result := processCommand(emvVoiceAuthXML);
   afterTransaction();
end;

function TCCreditDSIEMVx.emvVoiceAuthXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoiceAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				    //ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				    ctab + ctab + '</Amount>';
				    //ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.emvZeroAuth: Boolean;
begin
  beforeTransaction();
  processCommand(emvZeroAuthXML);
  afterTransaction();
end;

function TCCreditDSIEMVx.emvZeroAuthXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVZeroAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				    ctab + ctab + '</Amount>';// + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.getDeviceInfo: WideString;
begin

  result := Fdevice.GetDevicesInfo;



end;

function TCCreditDSIEMVx.getDeviceInfoXML: String;
begin
    {<Devices>
<NumSecureDevices>SSSSSS</NumSecureDevices>
<SecureDeviceNN>
<DescriptionNN>Description</DescriptionNN>
<InterfaceNN>Interface</InterfaceNN>
<SecureDeviceIDNN>SecureDeviceID</SecureDeviceIDNN>
</SecureDeviceNN>
</Devices>}

end;

function TCCreditDSIEMVx.getEMVParamDownloadXML: String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVParamDownload</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Admin>' + ccrlf +
            strRequest +
            ctab + '</Admin>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.padReset: Boolean;
begin
  result := processCommand(createPadResetXML);
end;

function TCCreditDSIEMVx.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  // to call EMV method processTransaction

//  showmessage('emv xml sent ' + fxml);
  FXMLResult   := FDevice.ProcessTransaction(FXML);

(*
  If (FExecutionMode = 'T') Then
     ShowMessage( FXML );
*)

  // Alex 09/30/2015
  //(*
  FXMLReceived := FXMLResult;
//  showmessage('emv xml response ' + FXMLReceived);

  FChipMethod := 'chip';
  If VerifyTransaction then
  begin
    Result := True;
    FChipMethod := 'chip';
  end;
  //*)

(*
  If (FExecutionMode = 'T') Then
     ShowMessage( FXMLReceived );
*)

  (* to activate fake - remove this comment
  If (FExecutionMode = 'P') Then Begin
      FXMLReceived := FXMLResult;

      if VerifyTransaction then
      begin
          Result := True;
          FChipMethod := 'chip';
      end;
  End Else Begin
      If ( FIsSale = True ) Then
        FXMLResult := GetFakeXMLSaleResult()
      Else
        FXMLResult := GetFakeXMLVoidResult();
      VerifyTransaction();
      FChipMethod := 'chip';
      Result := True;
  End;
  *)
end;

function TCCreditDSIEMVx.ProcessReturn: Boolean;
var
   status: String;
   text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(CreateReturnXML);

     status := FXMLContent.GetAttributeString('CmdStatus');
     text :=   FXMLContent.GetAttributeString('TextResponse');

     {
     // CmdStatus and TextResponse from Mercury  - under test
     if ( (fMercuryResponse.Strings[0] = 'Error') and
        ( (fMercuryResponse.Strings[1] = 'Cancelled.') or (fMercuryResponse.Strings[1] = 'Cancelled at POS.') ) ) then begin
        result := processCommand(resubmitSaleXML);
     end;
     }

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(resubmitReturnXML);
     end;

     if ( result ) then begin
        FAuthorize := FAuthorize * (-1);
     end;


  end;
end;

function TCCreditDSIEMVx.ProcessSale: Boolean;
var
   status: String;
   text: String;
   code: Integer;
   viewPopup: TViewEMVAsking;
   actionSelected: Integer;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(CreateSaleXML);

     status := FXMLContent.GetAttributeString('CmdStatus');
     text   := FXMLContent.GetAttributeString('TextResponse');
     code := FXMLContent.GetAttributeInteger('DSIXReturnCode');

     {
     // CmdStatus and TextResponse from Mercury
     if ( (fMercuryResponse.Strings[0] = 'Error') and
        ( (fMercuryResponse.Strings[1] = 'Cancelled.') or (fMercuryResponse.Strings[1] = 'Cancelled at POS.') ) ) then begin
        result := processCommand(resubmitSaleXML);
     end;
      }

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(resubmitSaleXML)
     end else if ( (status = 'Error') and (code = 003328) ) then begin  //Error and Time Out

             try
                viewPopup := TviewEMVAsking.Create(nil);
                actionSelected := viewPopup.Start();

                if ( actionSelected = 0 ) then begin
                   raise Exception.Create('Cancel by user');
                end else if ( actionSelected = 1 ) then begin
                       result := processCommand(CreateSaleXML);
                    end else if ( actionSelected = 2 ) then begin
                            result := processCommand(resubmitSaleXML);
                        end;
             finally
                FreeAndNil(viewPopup);
             end;


         end;

  end;
end;


function TCCreditDSIEMVx.resubmitReturnXML: String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  returnPurchase := Fpurchase * (-1);

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(returnPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf+
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.resubmitSaleXML(): String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf+
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.VoidReturn: Boolean;
begin
  beforeTransaction();
  result := processCommand(VoidReturnXML);

  if ( result ) then begin
        FAuthorize := FAuthorize * (-1);
  end;

  afterTransaction();
end;

function TCCreditDSIEMVx.voidReturnByRecordNo: Boolean;
begin
  beforeTransaction();
  processCommand(voidReturnByRecordNoXML);
  afterTransaction();
end;

function TCCreditDSIEMVx.voidReturnByRecordNoXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturnByRecordNo</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				    //ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				    ctab + ctab + '</Amount>' + ccrlf +
				    //ctab + ctab + '<LaneID>' + LaneID + '</LaneID>' + ccrlf +
				    //ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                //ctab + ctab + '<PartialAuth>' + fPartialAuth + '</PartialAuth>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>'; // + ccrlf +
                //ctab + ctab + '<ProcessData>' + FProcessData + '</ProcessData>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.VoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.VoidSale: Boolean;
begin
   beforeTransaction();
   result := processCommand(VoidSaleXML);
   afterTransaction();
end;

function TCCreditDSIEMVx.voidSaleByRecordNo: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(voidSaleByRecordNoXML);
  end;
end;

function TCCreditDSIEMVx.voidSaleByRecordNoXML: string;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSaleByRecordNo</TranCode>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<RecordNo>' + FResultRefNo + '</RecordNo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + fAcctNoSecureDevice + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCCreditDSIEMVx.VoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

{ TCDebitDSiClientX }

constructor TCDebitDSiClientX.Create;
begin
   FDevice := TDSICLientX.Create(nil);
   inherited;
end;

function TCDebitDSiClientX.CreateReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  //Debit Card
  strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                ctab + ctab + '</Account>' +  ccrlf;

  //Amount
  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  //PinpadInfo
  strRequest := strRequest + ctab + ctab + '<PIN>' +  ccrlf +
                ctab + ctab + ctab + '<PINBlock>' + FPINBlock + '</PINBlock>' +  ccrlf +
                ctab + ctab + ctab + '<DervdKey>' + FDervdKey + '</DervdKey>' +  ccrlf +
                ctab + ctab + '</PIN>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCDebitDSiClientX.CreateSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  //Debit Card
  strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                ctab + ctab + '</Account>' +  ccrlf;

  //Amount
  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf;
  if FCashBack <> 0 then
    strRequest := strRequest + ctab + ctab + '<CashBack>' + formatfloat('0.00', FCashBack) + '</Purchase>' + ccrlf;
  strRequest := strRequest + ctab + ctab + '</Amount>' +  ccrlf;

  //PinpadInfo
  strRequest := strRequest + ctab + ctab + '<PIN>' +  ccrlf +
                ctab + ctab + ctab + '<PINBlock>' + FPINBlock + '</PINBlock>' +  ccrlf +
                ctab + ctab + ctab + '<DervdKey>' + FDervdKey + '</DervdKey>' +  ccrlf +
                ctab + ctab + '</PIN>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

destructor TCDebitDSiClientX.Destroy;
begin
  freeAndNil(FDebitX);
  inherited;
end;

function TCDebitDSiClientX.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
    FDevice.SetConnectTimeout(FCCConfig.FConnectTimeout);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
    FDevice.SetResponseTimeout(FCCConfig.FResponseTimeout);
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes
  FXMLResult := FDevice.ServerIPConfig(FCCConfig.FIpAddress, 0);


  FXMLServer := FXMLResult;

  if VerifyServerConfig then
  begin
    //Params:
    //1 - BSTR XML Command – An XML formatted string containing the details of the transaction request. See subsequent sections on available XML commands, formats and usage.
    //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
    //   0 Process using visible dialog boxes
    //   1 Process without using visible dialog boxes
    //   2 Process asynchronously without visible dialog boxes and fire an event
    //3 - ClientServerPassword – A password consisting of 1-12 characters which is defined by the server. If the server is configured such that a ClientServerPassword is not required, then a null string should be supplied.
    //4 - UserTraceData – Optional value which will be returned unaltered with response to allow application to identify a particular response.
    FXMLSent     := FXML;

    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;
    if VerifyTransaction then
      Result := True;
  end;

end;

function TCDebitDSiClientX.ProcessReturn: Boolean;
begin
  result := processCommand(CreateReturnXML);
end;

function TCDebitDSiClientX.ProcessSale: Boolean;
begin
  Result := False;
//  BeforeProcessCard;
  Result := GetPinNumber;
  result := processCommand(CreateSaleXML);
end;


{ TCDebitDSIEMVx }

function TCDebitDSIEMVx.beforeTransaction: Boolean;
var
   status: String;
   seqNo: String;
begin
  result := ProcessCommand(createPadResetXML);

  status := FXMLContent.GetAttributeString('CmdStatus');

  if ( status = 'Success' ) then begin
     SeqNo := FXMLContent.GetAttributeString('SequenceNo');
     setSequenceNo(seqNo);
  end;
end;

constructor TCDebitDSIEMVx.Create;
begin
   inherited; 
   FDevice := TDsiEMVX.Create(nil);
end;

function TCDebitDSIEMVx.createPadResetXML: String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<OperatorID>1</OperatorID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVPadReset</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
		      	ctab + ctab + '<SequenceNo>0010010010</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCDebitDSIEMVx.CreateReturnXML: String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  strRequest := '';

  returnPurchase := fPurchase * (-1);

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(Abs(returnPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCDebitDSIEMVx.CreateSaleXML: String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

destructor TCDebitDSIEMVx.Destroy;
begin
  freeAndNil(FDebitX);
  inherited;
end;

function TCDebitDSIEMVx.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

//  showmessage('send xml ' + FXML);
  FXMLResult := FDevice.ProcessTransaction(FXML);
  FXMLReceived := FXMLResult;
//  showmessage('received xml ' + FXMLReceived);


  if VerifyTransaction then begin
      Result := True;
  end;

end;

function TCDebitDSIEMVx.ProcessReturn: Boolean;
var
   status: String;
   text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(CreateReturnXML);

     status := FXMLContent.GetAttributeString('CmdStatus');
     text :=   FXMLContent.GetAttributeString('TextResponse');

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(resubmitReturnXML);
     end;

     if ( result ) then begin
        FAuthorize := FAuthorize * (-1);
     end;

  end;
end;

function TCDebitDSIEMVx.ProcessSale: Boolean;
var
  status: String;
  text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(CreateSaleXML);

     status := FXMLContent.GetAttributeString('CmdStatus');
     text :=   FXMLContent.GetAttributeString('TextResponse');

     // under test

     // CmdStatus and TextResponse from Mercury
     if ( (fMercuryResponse.Strings[0] = 'Error') and
        ( (fMercuryResponse.Strings[1] = 'Cancelled.') or (fMercuryResponse.Strings[1] = 'Cancelled at POS.') ) ) then begin
        result := processCommand(resubmitSaleXML);
     end;   

    {disabled temporarly
     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(resubmitSaleXML);
     end;
     }
  end;
end;


function TCDebitDSIEMVx.resubmitReturnXML: String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  strRequest := '';

  returnPurchase := fPurchase * (-1);

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(returnPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf+
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCDebitDSIEMVx.resubmitSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf+
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

{ TCDebitDSIPDCx }
constructor TCDebitDSIPDCx.Create;
begin
   FDevice := TDsiPDCX.Create(nil);
   inherited;
end;

function TCDebitDSIPDCx.CreateReturnXML: String;
var
  strRequest: string;
  secureDevice: String;
begin
  secureDevice := fAcctNoSecureDevice;

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FInvoiceNo + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf + 
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCDebitDSIPDCx.CreateSaleXML: String;
var
  strRequest: string;
  secureDevice: String;
begin

  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FInvoiceNo + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<CashBack>0.00</CashBack>' + ccrlf + 
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf + 
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

destructor TCDebitDSIPDCx.Destroy;
begin
  freeAndNil(FDebitX);
  inherited;
end;

function TCDebitDSIPDCx.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
    FDevice.SetConnectTimeout(FCCConfig.FConnectTimeout);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
    FDevice.SetResponseTimeout(FCCConfig.FResponseTimeout);
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes
  FXMLResult := FDevice.ServerIPConfig(FCCConfig.FIpAddress, 0);

  FXMLServer := FXMLResult;

  if VerifyServerConfig then
  begin
    //Params:
    //1 - BSTR XML Command – An XML formatted string containing the details of the transaction request. See subsequent sections on available XML commands, formats and usage.
    //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
    //   0 Process using visible dialog boxes
    //   1 Process without using visible dialog boxes
    //   2 Process asynchronously without visible dialog boxes and fire an event
    //3 - ClientServerPassword – A password consisting of 1-12 characters which is defined by the server. If the server is configured such that a ClientServerPassword is not required, then a null string should be supplied.
    //4 - UserTraceData – Optional value which will be returned unaltered with response to allow application to identify a particular response.
    FXMLSent     := FXML;

//    showmessage('xml sent ' + FXMLSent);
    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);

    FXMLReceived := FXMLResult;

//    showmessage('xml sent ' + FXMLSent);

    if VerifyTransaction then
      Result := True;

  end;

end;

function TCDebitDSIPDCx.ProcessReturn: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(CreateReturnXML);
  end;
end;

function TCDebitDSIPDCx.ProcessSale: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(CreateSaleXML);
  end;
end;


{ TCPrepaidDsiClientX }
function TCPrepaidDsiClientX.CreateReturnXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.CreateSaleXML: String;
var
   strRequest: String;
begin
  // Construct XML for PrePaid Sale
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress<>'' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidBalance: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(prePaidBalanceXML);
end;

function TCPrepaidDsiClientX.prePaidBalanceXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Balance</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidCashOut: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(prePaidCashOutXML);
end;

function TCPrepaidDsiClientX.prePaidCashOutXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>CashOut</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', 0) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidIssue: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(prePaidIssueXML);
end;

function TCPrepaidDsiClientX.prePaidIssueXML: String;
var
  strRequest: string;
begin

  // Construct XML for PrePaid
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;
  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress<>'' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;


    (* amfsouza 10.17.2011 - begin
    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
    amfsouza 10.17.2011 - end *)
  end;

  (* amfsouza 10.17.2011 - begin
  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;
   amfsouza 10.17.2011 - end *)

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidNoNSFSale: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(prePaidNoNSFSaleXML);
end;

function TCPrepaidDsiClientX.prePaidNoNSFSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>NoNSFSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Authorize>' + formatFloat('0.00', FAuthorize) + '</Authorize>' + ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Balance>' + formatFloat('0.00', FBalance) + '</Balance>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidReload: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(prePaidReloadXML);
end;

function TCPrepaidDsiClientX.prePaidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidSaleXML: String;
var
   strRequest: String;
begin
  // Construct XML for PrePaid Sale
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress<>'' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidVoidIssue: Boolean;
begin
  BeforeVoid();
  BeforeProcessCard();
  result := processCommand(prePaidVoidIssueXML);
end;

function TCPrepaidDsiClientX.prePaidVoidIssueXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidIssue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.prePaidVoidReload: Boolean;
begin
  BeforeVoid();
  BeforeProcessCard();
  result := processCommand(prePaidVoidReloadXML);
end;

function TCPrepaidDsiClientX.prePaidVoidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
//    TDSiClientx(FClientDevice).SetConnectTimeout(FCCConfig.FConnectTimeout);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
//    TDsiClientx(FClientDevice).SetResponseTimeout(FCCConfig.FResponseTimeout);
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes
  FXMLResult := FDevice.ServerIPConfig(FCCConfig.FIpAddress, 0);

  FXMLServer := FXMLResult;

  if VerifyServerConfig then
  begin
    //Params:
    //1 - BSTR XML Command – An XML formatted string containing the details of the transaction request. See subsequent sections on available XML commands, formats and usage.
    //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
    //   0 Process using visible dialog boxes
    //   1 Process without using visible dialog boxes
    //   2 Process asynchronously without visible dialog boxes and fire an event
    //3 - ClientServerPassword – A password consisting of 1-12 characters which is defined by the server. If the server is configured such that a ClientServerPassword is not required, then a null string should be supplied.
    //4 - UserTraceData – Optional value which will be returned unaltered with response to allow application to identify a particular response.
    FXMLSent     := FXML;

    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;

    if VerifyTransaction then
      Result := True;
  end;

end;

function TCPrepaidDsiClientX.ProcessReturn: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreateReturnXML);
end;

function TCPrepaidDsiClientX.ProcessSale: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreateSaleXML);
end;


function TCPrepaidDsiClientX.VoidReturn: Boolean;
begin
  BeforeVoid();
  BeforeProcessCard();
  result := processCommand(VoidReturnXML);
end;

function TCPrepaidDsiClientX.VoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiClientX.VoidSale: Boolean;
begin
   BeforeVoid();
   BeforeProcessCard();
   result := processCommand(VoidSaleXML);
end;

function TCPrepaidDsiClientX.VoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

{ TCPrepaidDsiPDCX }

constructor TCPrepaidDsiPDCX.create;
begin
  FDevice := TDsiPDCX.Create(nil);
  inherited;
end;

function TCPrepaidDsiPDCX.CreateReturnXML: String;
var
  strRequest: string;
  secureDevice : String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TCPrepaidDsiPDCX.CreateSaleXML: String;
var
  strRequest: string;
  secureDevice : String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;


destructor TCPrepaidDsiPDCX.destroy;
begin
  freeAndNil(FDevice);
end;

function TCPrepaidDsiPDCX.prePaidBalance: Boolean;
begin
//  if ( fDeviceInitialized ) then begin
//     BeforeProcessCard;
     result := processCommand(prePaidBalanceXML);
//  end;

end;

function TCPrepaidDsiPDCX.prePaidBalanceXML: String;
var
  strRequest: string;
  secureDevice : String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Balance</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCPrepaidDsiPDCX.prePaidCashOut: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(prePaidCashOutXML);
  end;
end;

function TCPrepaidDsiPDCX.prePaidCashOutXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>CashOut</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf;
  end else begin
               strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo></RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
     // Account Info - Manual
     strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiPDCX.prePaidIssue: Boolean;
begin
  if ( fDeviceInitialized ) then begin
      result := processCommand(prePaidIssueXML);
  end;
end;

function TCPrepaidDsiPDCX.prePaidIssueXML: String;
var
  strRequest: string;
  secureDevice : String;
begin

  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCPrepaidDsiPDCX.prePaidNoNSFSale: Boolean;
begin
  if ( fDeviceInitialized ) then begin
    result := processCommand(prePaidNoNSFSaleXML);

  end;
end;

function TCPrepaidDsiPDCX.prePaidNoNSFSaleXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>NoNSFSale</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf;
  end else begin
               strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo></RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
     // Account Info - Manual
     strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiPDCX.prePaidReload: Boolean;
begin
   if ( fDeviceInitialized ) then begin
      result := processCommand(prePaidReloadXML);
   end;

end;

function TCPrepaidDsiPDCX.prePaidReloadXML: String;
var
  strRequest: string;
  secureDevice : String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Reload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;


function TCPrepaidDsiPDCX.prePaidSaleXML: String;
var
  strRequest: string;
  secureDevice : String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCPrepaidDsiPDCX.prePaidVoidIssue: Boolean;
begin

end;

function TCPrepaidDsiPDCX.prePaidVoidIssueXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidIssue</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf;
  end else begin
                strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo></RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
     // Account Info - Manual
     strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCPrepaidDsiPDCX.prePaidVoidReload: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(prePaidVoidReloadXML);

  end;
end;

function TCPrepaidDsiPDCX.prePaidVoidReloadXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf;
  end else begin
               strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo></RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
     // Account Info - Manual
     strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiPDCX.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin
  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:

  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
    FDevice.SetConnectTimeout(FCCConfig.FConnectTimeout);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
    FDevice.SetResponseTimeout(FCCConfig.FResponseTimeout);
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes

  FXMLResult := FDevice.ServerIPConfig(FCCConfig.FIpAddress, 0);

  FXMLServer := FXMLResult;

  if VerifyServerConfig then
  begin
    //Params:
    //1 - BSTR XML Command – An XML formatted string containing the details of the transaction request. See subsequent sections on available XML commands, formats and usage.
    //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
    //   0 Process using visible dialog boxes
    //   1 Process without using visible dialog boxes
    //   2 Process asynchronously without visible dialog boxes and fire an event
    //3 - ClientServerPassword – A password consisting of 1-12 characters which is defined by the server. If the server is configured such that a ClientServerPassword is not required, then a null string should be supplied.
    //4 - UserTraceData – Optional value which will be returned unaltered with response to allow application to identify a particular response.
    FXMLSent     := FXML;
//    showmessage('xml sent ' + FXMLSent);
    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;
//    showmessage('xml received ' + FXMLSent);

    if VerifyTransaction then
      Result := True;
  end;

end;

function TCPrepaidDsiPDCX.ProcessReturn: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(CreateReturnXML);
  end;
end;

function TCPrepaidDsiPDCX.ProcessSale: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(CreateSaleXML);
  end;
end;


function TCPrepaidDsiPDCX.VoidReturn: Boolean;
begin
  if ( fDeviceInitialized ) then begin
     result := processCommand(VoidReturnXML);
  end;
end;

function TCPrepaidDsiPDCX.VoidReturnXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf;
  end else begin
             strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo></RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
     // Account Info - Manual
     strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiPDCX.VoidSale: Boolean;
begin

end;

function TCPrepaidDsiPDCX.VoidSaleXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + intToStr(FCCConfig.FMercuryGiftIPPort) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[1] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.FComPort+ '</ComPort>' +  ccrlf;
  end else begin
                strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo></RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
     // Account Info - Manual
     strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

{ TCPrepaidDsiEMVX }

function TCPrepaidDsiEMVX.CreateReturnXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.CreateSaleXML: String;
var
   strRequest: String;
begin
  // Construct XML for PrePaid Sale
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress<>'' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidBalance: Boolean;
begin
   result := FCreditX.prePaidBalance();
end;

function TCPrepaidDsiEMVX.prePaidBalanceXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Balance</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidCashOut: Boolean;
begin
   result := FCreditX.prePaidCashOut();
end;

function TCPrepaidDsiEMVX.prePaidCashOutXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>CashOut</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', 0) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidIssue: Boolean;
begin
   result := FCreditX.prePaidIssue();
end;

function TCPrepaidDsiEMVX.prePaidIssueXML: String;
var
  strRequest: string;
begin

  // Construct XML for PrePaid
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;
  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress<>'' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;


    (* amfsouza 10.17.2011 - begin
    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
    amfsouza 10.17.2011 - end *)
  end;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidNoNSFSale: Boolean;
begin
   result := FCreditX.prePaidNoNSFSale();
end;

function TCPrepaidDsiEMVX.prePaidNoNSFSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>NoNSFSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Authorize>' + formatFloat('0.00', FAuthorize) + '</Authorize>' + ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Balance>' + formatFloat('0.00', FBalance) + '</Balance>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidReload: Boolean;
begin
  result := FCreditX.prePaidReload();
end;

function TCPrepaidDsiEMVX.prePaidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidSaleXML: String;
var
   strRequest: String;
begin
  // Construct XML for PrePaid Sale
  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((FZip <> '') or (FAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if FAddress<>'' then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + FAddress + '</Address>' + ccrlf;

        if FZip <> '' then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + FZip + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if FCVVData <> '' then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + FCVVData + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidVoidIssue: Boolean;
begin
   result := FCreditX.prePaidVoidIssue();
end;

function TCPrepaidDsiEMVX.prePaidVoidIssueXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidIssue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.prePaidVoidReload: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  result := FCreditX.prePaidVoidReload();
end;

function TCPrepaidDsiEMVX.prePaidVoidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;


  FXMLServer := FXMLResult;

  // to call EMV method processTransaction
//  showmessage('xml sent ' + FXML);

  FXMLResult   := FDevice.ProcessTransaction(FXMLSent);
  FXMLReceived := FXMLResult;

//   showmessage('xml sent ' + FXMLReceived);


  if VerifyTransaction then
  begin
      Result := True;
  end;
end;

function TCPrepaidDsiEMVX.ProcessReturn: Boolean;
begin
   result := processCommand(createReturnXML);
end;

function TCPrepaidDsiEMVX.ProcessSale: Boolean;
begin
  result := processCommand(createSaleXML);
end;


function TCPrepaidDsiEMVX.VoidReturn: Boolean;
begin
   result := FCreditX.VoidReturn();
end;

function TCPrepaidDsiEMVX.VoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCPrepaidDsiEMVX.VoidSale: Boolean;
begin
   result := FCreditX.voidSale();
end;

function TCPrepaidDsiEMVX.VoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FCCConfig.FTerminalID + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FRefNo + '</RefNo>' + ccrlf;

  if FTrack2 <> '' then
  begin
    // Account Info - Use Track2
    strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                  ctab + ctab + '</Account>' +  ccrlf;
  end
  else
  begin
      // Account Info - Manual
      strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                    ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TCCWidget.GetFakeXMLSaleResult: String;
begin

  Result :=
          '<?xml version="1.0"?>'+
          '<RStream>'+
          ' <CmdResponse>'+
          '  <ResponseOrigin>Processor</ResponseOrigin>'+
          '  <DSIXReturnCode>000000</DSIXReturnCode>'+
          '  <CmdStatus>Approved</CmdStatus>'+
          '  <TextResponse>AP</TextResponse>'+
          '  <SequenceNo>0010010000</SequenceNo>'+
          '  <UserTrace></UserTrace>'+
          ' </CmdResponse>'+
          ' <TranResponse>'+
          '  <MerchantID>755847002</MerchantID>'+
          '  <AcctNo>************0010</AcctNo>'+
          '  <CardType>VISA</CardType>'+
          '  <TranCode>EMVSale</TranCode>'+
          '  <AuthCode>35473A</AuthCode>'+
          '  <CaptureStatus>Captured</CaptureStatus>'+
          '  <RefNo>1039</RefNo>'+
          '  <InvoiceNo>10022015045516166</InvoiceNo>'+
          '  <OperatorID>Test</OperatorID>'+
          '  <Amount>'+
          '   <Purchase>0.01</Purchase>'+
          '   <Authorize>0.01</Authorize>'+
          '  </Amount>'+
          '  <AcqRefData>aAb314282069480098c1234d e000</AcqRefData>'+
          '  <ProcessData>|00|410100500000</ProcessData>'+
          '  <RecordNo>rOmzUNSm8QZKnNKE1uvvzSz2BHp25M8Wvl9+P3qn/vciEgUQESIQDBkJ</RecordNo>'+
          '  <EntryMethod>CHIP</EntryMethod>'+
          '  <Date>10/02/2015</Date>'+
          '  <Time>17:22:47</Time>'+
          '  <ApplicationLabel>Visa Credit</ApplicationLabel>'+
          '  <AID>A0000000031010</AID>'+
          '  <TVR>0000008000</TVR>'+
          '  <IAD>06010A0360A000</IAD>'+
          '  <TSI>F800</TSI>'+
          '  <ARC>00</ARC>'+
          '  <CVM>SIGN</CVM>'+
          ' </TranResponse>'+
          ' <PrintData>'+
          '  <Line1>.MERCHANT ID: 755847002</Line1>'+
          '  <Line2>.CLERK ID: Test</Line2>'+
          '  <Line3>.</Line3>'+
          '  <Line4>.                  SALE                  </Line4>'+
          '  <Line5>.</Line5>'+
          '  <Line6>.************0010</Line6>'+
          '  <Line7>.VISA                 ENTRY METHOD: CHIP</Line7>'+
          '  <Line8>.DATE: 10/02/2015  TIME: 17:22:47</Line8>'+
          '  <Line9>.</Line9>'+
          '  <Line10>.INVOICE: 10022015045516166</Line10>'+
          '  <Line11>.REFERENCE: 1039</Line11>'+
          '  <Line12>.AUTH CODE: 35473A</Line12>'+
          '  <Line13>.</Line13>'+
          '  <Line14>.AMOUNT                       USD$ 2.02</Line14>'+
          '  <Line15>.                            ==========</Line15>'+
          '  <Line16>.TOTAL                        USD$ 2.02</Line16>'+
          '  <Line17>.</Line17>'+
          '  <Line18>.          APPROVED - THANK YOU          </Line18>'+
          '  <Line19>.</Line19>'+
          '  <Line20>.I AGREE TO PAY THE ABOVE TOTAL AMOUNT</Line20>'+
          '  <Line21>.ACCORDING TO CARD ISSUER AGREEMENT</Line21>'+
          '  <Line22>.(MERCHANT AGREEMENT IF CREDIT VOUCHER)</Line22>'+
          '  <Line23>.</Line23>'+
          '  <Line24>.</Line24>'+
          '  <Line25>.</Line25>'+
          '  <Line26>.x_______________________________________</Line26>'+
          '  <Line27>.          Cardholder Signature          </Line27>'+
          '  <Line28>.</Line28>'+
          '  <Line29>.</Line29>'+
          '  <Line30>.APPLICATION LABEL: Visa Credit</Line30>'+
          '  <Line31>.AID: A0000000031010</Line31>'+
          '  <Line32>.TVR: 0000008000</Line32>'+
          '  <Line33>.IAD: 06010A0360A000</Line33>'+
          '  <Line34>.TSI: F800</Line34>'+
          '  <Line35>.ARC: 00</Line35>'+
          '  <Line36>.CVM: SIGN</Line36>'+
          ' </PrintData>'+
          '</RStream>';
end;

function TCCWidget.GetFakeXMLVoidResult: String;
begin
  Result :=
          '<?xml version="1.0"?>'+
          '<RStream>'+
          '    <CmdResponse>'+
          '        <ResponseOrigin>Processor</ResponseOrigin>'+
          '        <DSIXReturnCode>000000</DSIXReturnCode>'+
          '        <CmdStatus>Approved</CmdStatus>'+
          '        <TextResponse>AP</TextResponse>'+
          '        <SequenceNo>0010010010</SequenceNo>'+
          '        <UserTrace></UserTrace>'+
          '    </CmdResponse>'+
          '    <TranResponse>'+
          '        <MerchantID>755847002</MerchantID>'+
          '        <AcctNo>************0434</AcctNo>'+
          '        <CardType>VISA</CardType>'+
          '        <TranCode>EMVVoidSale</TranCode>'+
          '        <AuthCode>VOIDED</AuthCode>'+
          '        <CaptureStatus>Captured</CaptureStatus>'+
          '        <RefNo>1017</RefNo>'+
          '        <InvoiceNo>6741</InvoiceNo>'+
          '        <OperatorID>test</OperatorID>'+
          '        <Amount>'+
          '            <Purchase>0.01</Purchase>'+
          '            <Authorize>0.01</Authorize>'+
          '        </Amount>'+
          '        <ProcessData>|A4|410100500000</ProcessData>'+
          '        <RecordNo>lsjKi2gsNImAka6kggPx5/XkydwA7c5o8XH6TTl1ARUiEgUQESIQDOsJ</RecordNo>'+
          '        <EntryMethod>CHIP</EntryMethod>'+
          '        <Date>10/06/2015</Date>  '+
          '        <Time>13:02:37</Time>'+
          '        <ApplicationLabel>Visa</ApplicationLabel>'+
          '        <AID>A0000000041010</AID>'+
          '        <TVR>4000008000</TVR>'+
          '        <IAD>021080000F240000DAC000000000000000F</IAD>'+
          '        <TSI>A800</TSI>'+
          '        <CVM>SIGN</CVM>'+
          '    </TranResponse>'+
          '    <PrintData>'+
          '        <Line1>.MERCHANT ID: 755847002</Line1>'+
          '        <Line2>.CLERK ID: test</Line2>'+
          '        <Line3>.</Line3>'+
          '        <Line4>.                VOID SALE               </Line4>'+
          '        <Line5>.</Line5>'+
          '        <Line6>.************0434</Line6>'+
          '        <Line7>.VISA           ENTRY METHOD: CHIP</Line7>'+
          '        <Line8>.DATE: 10/06/2015  TIME: 13:02:37</Line8>'+
          '        <Line9>.</Line9>'+
          '        <Line10>.INVOICE: 6741</Line10>'+
          '        <Line11>.REFERENCE: 1017</Line11>'+
          '        <Line12>.AUTH CODE: VOIDED</Line12>'+
          '        <Line13>.</Line13>'+
          '        <Line14>.AMOUNT                       USD$ 0.31</Line14>'+
          '        <Line15>.                            ==========</Line15>  '+
          '        <Line16>.TOTAL                        USD$ 0.31</Line16>'+
          '        <Line17>.</Line17>'+
          '        <Line18>.          APPROVED - THANK YOU          </Line18>'+
          '        <Line19>.</Line19>'+
          '        <Line20>.I AGREE TO PAY THE ABOVE TOTAL AMOUNT</Line20>'+
          '        <Line21>.ACCORDING TO CARD ISSUER AGREEMENT</Line21>'+
          '        <Line22>.(MERCHANT AGREEMENT IF CREDIT VOUCHER)</Line22>'+
          '        <Line23>.</Line23>                                        '+
          '        <Line24>.</Line24>'+
          '        <Line25>.</Line25>'+
          '        <Line26>.x_______________________________________</Line26>'+
          '        <Line27>.           Merchant Signature           </Line27>  '+
          '        <Line28>.</Line28>'+
          '        <Line29>.</Line29>'+
          '        <Line30>.APPLICATION LABEL: Visa</Line30>'+
          '        <Line31>.AID: A0000000041010</Line31>'+
          '        <Line32>.TVR: 4000008000</Line32>'+
          '        <Line33>.IAD: 021080000F240000DAC000000000000000F</Line33>'+
          '        <Line34>.TSI: A800</Line34>'+
          '        <Line35>.CVM: SIGN</Line35>'+
          '    </PrintData>'+
          '</RStream>';

end;

end.









































