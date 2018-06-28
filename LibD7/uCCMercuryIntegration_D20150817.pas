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
    Ftax: Double;
    Faddress: String;
    fzip: String;
    FcvvData: String;
    FMsg                   : String;     //Msg Error ou Resultado de aprovacao da venda
    FXMLResult             : WideString; //Resposta do XML do Servidor
    FXMLServer             : WideString; //Server XML
    FXMLSent               : WideString; //XML Enviado
    FXMLReceived           : WideString; //XML Recebido Aprovacao/Reprovacao
    FCardSwiped            : WideString; //String with the Swiped Card
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

    FCCConfig              : TCCConfig;
    FXMLContent            : TXMLContent;
    FAfterSucessfullSwipe  : TAfterSucessfullSwipe;
    FOnNeedSwipe           : TNeedSwipeEvent;
    FOnNeedTroutD          : TNeedTroutDEvent;
    FTransactionReturn     : TTransactionReturn;

    //amfsouza 12.01.2012
    FTransactionErrorLevel : TTransactionErrorLevel;
    FMercuryErrorsCode: TClientDataSet;
    FBalance          : Currency;
    FMsgError         : String;

    // Antonio, September 16, 2013
    fCardNumberList: TStringList;

    fProcessorSelected: Integer;

    procedure LoadRegistryValues;
    procedure setMercuryConfigGiftIntegration(arg_ipAddress: String);
  private
    function getTransactionErrorLevel: TTransactionErrorLevel;
    procedure setMercuryErrorsCode(const Value: TClientDataSet);
    function initializeDsiPDCX: Boolean;
    function initializeDsiPDCxXML: String;
  protected
    function getSecureSerialNumber(arg_serialNumber: String): String;
    function VerifyServerConfig : Boolean;
    function CreateSaleXML : String; virtual; abstract;
    function CreateReturnXML : String; virtual; abstract;
    function ProcessCommand(FXML : WideString) : Boolean; virtual; abstract;
    function VerifyTransaction : Boolean; virtual; abstract;
    procedure BeforeProcessCard;
  public
    Constructor Create;
    Destructor Destroy; override;

    //amfsouza 12.01.2012
    property MsgError: String read FMsgError;
    property Balance: Currency read FBalance;
    property MercuryErrorsCode: TClientDataSet write setMercuryErrorsCode;
    property TransactionErrorLevel: TTransactionErrorLevel read getTransactionErrorLevel;

    property TransactionReturn: TTransactionReturn read FTransactionReturn write FTransactionReturn;
    property OnNeedSwipe: TNeedSwipeEvent read FOnNeedSwipe write FOnNeedSwipe;
    property AfterSucessfullSwipe: TAfterSucessfullSwipe read FAfterSucessfullSwipe write FAfterSucessfullSwipe;
    property OnNeedTroutD: TNeedTroutDEvent read FOnNeedTroutD write FOnNeedTroutD;
    function getMessageErrorCode(error_code: String): String; virtual;
    function ProcessSale : Boolean; virtual; abstract;
    function ProcessReturn : Boolean; virtual; abstract;

    // Antonio, September 16, 2013
    procedure setCardNumber(arg_cardNumber : String);
    procedure cleanupCardNumberList;
  end;

  TCCredit  = class(TCCWidget)
      FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
      FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function CreateSaleXML : String; virtual; abstract;
      function CreateReturnXML : String; virtual; abstract;
      function VoidSaleXML : String; virtual; abstract;
      function VoidReturnXML : String; virtual; abstract;
      function processCommand(FXML: WideString): Boolean; virtual; abstract;
      function verifyTransaction(): Boolean; virtual; abstract;
      procedure BeforeVoid;
    public
      FCreditX               : TCCredit;
      function ProcessSale : Boolean; virtual;
      function ProcessReturn : Boolean; virtual;
      function VoidSale : Boolean; virtual;
      function VoidReturn : Boolean; virtual;
      procedure setCreditDevice(arg_processor: Integer);
  end;

  TCreditDSIClientx = class(TCCredit)
  FTax                   : Currency;
  FAddress               : String;
  FZip                   : String;
  FCVVData               : String;
  FAuthCode              : String;
  protected
    function CreateSaleXML : String; override;
    function CreateReturnXML : String; override;
    function VoidSaleXML : String; virtual;
    function VoidReturnXML : String; virtual;
    function processCommand(FXML: WideString): Boolean; override;
    function verifyTransaction(): Boolean; override;

    procedure BeforeVoid;
  public
    FDevice: TDSICLientX;
    constructor create();
    function ProcessSale : Boolean; override;
    function ProcessReturn : Boolean; override;
    function VoidSale : Boolean; virtual;
    function VoidReturn : Boolean; virtual;
  end;

  TCreditDSIPDCx = class(TCCredit)
    FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
    FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; virtual;
      function VoidReturnXML : String; virtual;
      function processCommand(FXML: WideString): Boolean; override;
      function verifyTransaction(): Boolean; override;

      procedure BeforeVoid;
    public
      FDevice: TDsiPDCX;
      constructor create();
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; virtual;    // amfsouza 10.18.2011
      function VoidReturn : Boolean; virtual;  // amfsouza 10.18.2011
  end;

{
3.1 EMVPADRESET ................................................................................................................................. 8
3.2 EMVSALE ........................................................................................................................................ 10
3.3 EMVVOIDSALE ................................................................................................................................ 13
3.4 VOIDSALEBYRECORDNO .................................................................................................................. 18
3.5 EMVRETURN ................................................................................................................................... 21
3.6 EMVVOIDRETURN ........................................................................................................................... 25
3.7 VOIDRETURNBYRECORDNO ............................................................................................................. 29
3.8 EMVVOICEAUTH .............................................................................................................................. 32
3.9 EMVZEROAUTH ............................................................................................................................... 35
3.10 ADJUSTBYRECORDNO ................................................................................................................... 39}



  TCreditDSIEMVx = class(TCCredit)
    FDevice: TDsiEMVX;
    FEmvPinPad: TPinPad;
  private
    function padReset: Boolean;
    protected
      function createPadResetXML(): String;
      function CreateSaleXML() : String; override;
      function VoidSaleXML() : String; virtual;
      function voidSaleByRecordNoXML(): string;
      function CreateReturnXML(): String; override; // In EMV doc match to RETURN Transaction ( Return = RETURN )
      function VoidReturnXML(): String; virtual;
      function voidReturnByRecordNoXML(): String; virtual;
      function emvVoiceAuthXML(): String;
      function emvZeroAuthXML(): String;
      function adjustByRecordNoXML(): String;
      function beforeTransaction(): Boolean;
      function afterTransaction(): Boolean;
      function processCommand(FXML: WideString): Boolean; override;
      function verifyTransaction(): Boolean; override;

      procedure BeforeVoid;

    public
      constructor create();
      function ProcessSale(): Boolean; override;
      function VoidSale(): Boolean; virtual;
      function voidSaleByRecordNo(): Boolean;
      function ProcessReturn(): Boolean; override;
      function VoidReturn(): Boolean; virtual;
      function voidReturnByRecordNo(): Boolean;
      function emvVoiceAuth(): Boolean;
      function emvZeroAuth(): Boolean;
      function adjustByRecordNo(): Boolean;
  end;


  TCDebit  = class(TCCWidget)
    FCashBack  : Currency;
    FPINBlock  : String;
    FDervdKey  : String;
    FMPinPad   : TPinPad;
    function GetPinNumber : Boolean;
    protected
      function CreateSaleXML : String; virtual; abstract;
      function CreateReturnXML : String; virtual; abstract;
    public
      FDebitX: TCDebit;
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; virtual;
      function ProcessReturn : Boolean; virtual;
      procedure setDebitDevice(arg_processor: Integer);
  end;


  TCDebitDSiClientX = class(TCDebit)
      FDevice: TDsiClientX;





  end;


  TCDebitDSIPDCx = class(TCDebit)
      FDevice: TDsiPDCx;





  end;


  TCDebitDSIEMVx = class(TCDebit)
      FDevice: TDsiEMVx;





  end;






  // amdfsouza 10.14.2011 - To GiftCard
  TCPrePaid = class(TCCredit)
    private
      FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
      FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function prePaidIssueXML: String;
      function prePaidVoidIssueXML: String;
      function prePaidSaleXML: String;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String;
      function prePaidVoidReloadXML: String;
      function prePaidBalanceXML: String;
      function prePaidNoNSFSaleXML: String;
      function prePaidCashOutXML: String;

    public
      function SwipCard: Boolean;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean;
      function prePaidVoidIssue: Boolean;
      function prePaidReload: Boolean;
      function prePaidVoidReload: Boolean;
      function prePaidBalance: Boolean;
      function prePaidNoNSFSale: Boolean;
      function prePaidCashOut: Boolean;

      // Antonio September 11, 2013
      function tryIssueCard(arg_salePrice: double): TTransactionReturn;
      function tryBalanceCard(arg_salePrice: double): TTransactionReturn;
  end;

  (*
  TCCWidgetDSIClient = class(TCCWidget)
     FClientDevice: TDSICLientX;
  end;

  TCreditDSIClientx = class(TCCWidgetDSICLient)
    FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
    FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; virtual;   // amfsouza 10.18.2011
      function VoidReturnXML : String; virtual; // amfsouza 10.18.2011
      procedure BeforeVoid;
    public
      constructor create();
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; virtual;    // amfsouza 10.18.2011
      function VoidReturn : Boolean; virtual;  // amfsouza 10.18.2011
  end;


  TDebitDSIClientx = class(TDebit)
    FCashBack  : Currency;
    FPINBlock  : String;
    FDervdKey  : String;
    FMPinPad   : TPinPad;
    function GetPinNumber : Boolean;
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
  end;


  TPrePaidDSICLientx = class(TCreditDSIClientx)
    private
      FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
      FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function prePaidIssueXML: String;
      function prePaidVoidIssueXML: String;
      function prePaidSaleXML: String;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String;
      function prePaidVoidReloadXML: String;
      function prePaidBalanceXML: String;
      function prePaidNoNSFSaleXML: String;
      function prePaidCashOutXML: String;

    public
      function SwipCard: Boolean;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean;
      function prePaidVoidIssue: Boolean;
      function prePaidReload: Boolean;
      function prePaidVoidReload: Boolean;
      function prePaidBalance: Boolean;
      function prePaidNoNSFSale: Boolean;
      function prePaidCashOut: Boolean;

      // Antonio September 11, 2013
      function tryIssueCard(arg_salePrice: double): TTransactionReturn;
      function tryBalanceCard(arg_salePrice: double): TTransactionReturn;
  end;

  TCCWidgetDSIPDCX = class(TCCWidget)
     FClientDevice: TDSIPDCX;
  end;

  TCreditDSIPDCx = class(TCCWidgetDSIPDCX)
    FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
    FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; virtual;   // amfsouza 10.18.2011
      function VoidReturnXML : String; virtual; // amfsouza 10.18.2011
      procedure BeforeVoid;
    public
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; virtual;    // amfsouza 10.18.2011
      function VoidReturn : Boolean; virtual;  // amfsouza 10.18.2011
  end;


  TDebitDSIPDCx = class(TCCWidgetDSIPDCX)
    FCashBack  : Currency;
    FPINBlock  : String;
    FDervdKey  : String;
    FMPinPad   : TPinPad;
    function GetPinNumber : Boolean;
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
  end;


  TPrePaidDSIPDCx = class(TCreditDSIPDCx)
    private
      FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
      FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
      FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function prePaidIssueXML: String;
      function prePaidVoidIssueXML: String;
      function prePaidSaleXML: String;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String;
      function prePaidVoidReloadXML: String;
      function prePaidBalanceXML: String;
      function prePaidNoNSFSaleXML: String;
      function prePaidCashOutXML: String;

    public
      function SwipCard: Boolean;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean;
      function prePaidVoidIssue: Boolean;
      function prePaidReload: Boolean;
      function prePaidVoidReload: Boolean;
      function prePaidBalance: Boolean;
      function prePaidNoNSFSale: Boolean;
      function prePaidCashOut: Boolean;

      // Antonio September 11, 2013
      function tryIssueCard(arg_salePrice: double): TTransactionReturn;
      function tryBalanceCard(arg_salePrice: double): TTransactionReturn;


  end;

  TCCWidgetEMVX = class(TCCWidget)
    FClientDevice: TDSIEMVX;
  end;

  TCreditEMVx = class(TCCWidgetEMVX)
    FTax                   : Currency;  //For Purchase Card Level II transactions – Sales Tax amount (with 2 place decimal – eg. 29.95)
    FAddress               : String;    //For manually entered (hand-keyed) account numbers Address (building street) number. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FZip                   : String;    //For manually entered (hand-keyed) account numbers Zip code. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FCVVData               : String;    //For manually entered (hand-keyed) account numbers Three or four CVV card digits or “None” or “Illegible”. Supply this data whenever using a manually entered account number to ensure best transaction qualification.
    FAuthCode              : String;    //Use the AuthCode value returned in the original PreAuth
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; virtual;   // amfsouza 10.18.2011
      function VoidReturnXML : String; virtual; // amfsouza 10.18.2011
      procedure BeforeVoid;
    public
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; virtual;    // amfsouza 10.18.2011
      function VoidReturn : Boolean; virtual;  // amfsouza 10.18.2011
  end;


  TDebitEMVx = class(TCCWidgetEMVX)
    FCashBack  : Currency;
    FPINBlock  : String;
    FDervdKey  : String;
    FMPinPad   : TPinPad;
    function GetPinNumber : Boolean;
    protected
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
  end;


  TPrePaidEMVx = class(TCreditEMVx)
    private
      FTax                   : Currency;
      FAddress               : String;
      FZip                   : String;
      FCVVData               : String;
      FAuthCode              : String;
    protected
      function prePaidIssueXML: String;
      function prePaidVoidIssueXML: String;
      function prePaidSaleXML: String;
      function CreateSaleXML : String; override;
      function CreateReturnXML : String; override;
      function VoidSaleXML : String; override;
      function VoidReturnXML : String; override;
      function prePaidReloadXML: String;
      function prePaidVoidReloadXML: String;
      function prePaidBalanceXML: String;
      function prePaidNoNSFSaleXML: String;
      function prePaidCashOutXML: String;

    public
      function SwipCard: Boolean;
      function ProcessSale : Boolean; override;
      function ProcessReturn : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidReturn : Boolean; override;
      function prePaidIssue: Boolean;
      function prePaidVoidIssue: Boolean;
      function prePaidReload: Boolean;
      function prePaidVoidReload: Boolean;
      function prePaidBalance: Boolean;
      function prePaidNoNSFSale: Boolean;
      function prePaidCashOut: Boolean;

      function tryIssueCard(arg_salePrice: double): TTransactionReturn;
      function tryBalanceCard(arg_salePrice: double): TTransactionReturn;
 end;
    *)


implementation

uses Registry, uDebugFunctions, Controls;

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

(*
function TCCredit.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +

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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
          }
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
*)


(*
function TCCredit.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>'+ FComport+ '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
 }
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
*)

function TCCredit.ProcessReturn: Boolean;
begin
  BeforeProcessCard;
  Result := ProcessCommand(CreateReturnXML);
end;


function TCCredit.ProcessSale: Boolean;
begin
  BeforeProcessCard;
  Result := ProcessCommand(CreateSaleXML);
end;

procedure TCCredit.setCreditDevice(arg_processor: Integer);
begin
   if ( arg_processor = PROCESSOR_MERCURY ) then begin
      FCreditX := TCreditDSIClientx.create;
   end else if ( arg_processor = PROCESSOR_EMV ) then begin
                FCreditX := TCreditDSIEMVx.create;
            end;
end;

function TCCredit.VoidReturn: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidReturnXML);
end;

(*
function TCCredit.VoidReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + fComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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
*)

function TCCredit.VoidSale: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidSaleXML);
end;

(*
function TCCredit.VoidSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
               // ctab + ctab + '<Comport>'+ fComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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
*)


{ TCDebit }

constructor TCDebit.Create;
begin
  inherited;
  FMPinPad := TPinPad.Create;
end;

(*
function TCDebit.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
               // ctab + ctab + '<Comport>' + fComport +'</Comport>' +  ccrlf +
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


function TCDebit.CreateSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>' + fComport + '</Comport>' +  ccrlf +
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
*)

destructor TCDebit.Destroy;
begin
  FreeAndNil(FMPinPad);
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
  //if FMPinPad.InitializePinPad then
  Result := FMPinPad.GetPin(FAcctNo, FPurchase, sPINBlock, sDervdKey);

  FMsg      := FMPinPad.FMsg;
  FPINBlock := sPINBlock;
  FDervdKey := sDervdKey;

  if not Result then
    raise Exception.Create(FMsg);

end;

function TCDebit.ProcessReturn: Boolean;
begin
  Result := False;
  BeforeProcessCard;
  Result := GetPinNumber;
  if Result then
    Result := ProcessCommand(CreateReturnXML);
end;

function TCDebit.ProcessSale: Boolean;
begin
  Result := False;
  BeforeProcessCard;
  Result := GetPinNumber;
  if Result then
    Result := ProcessCommand(CreateSaleXML);
end;



procedure TCDebit.setDebitDevice(arg_processor: Integer);
begin
   if ( arg_processor = PROCESSOR_MERCURY ) then begin
      FDebitX := TCDebitDSIClientx.create;
   end else if ( arg_processor = PROCESSOR_EMV ) then begin
                FDebitX := TCDebitDSIEMVx.create;
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

procedure TCCWidget.BeforeProcessCard;
var
  ASwipedTrack: WideString;
  ASwipeCanceled, ASwipeError: Boolean;
  sCard, sName, sDate, sTrack2 : WideString;
begin

  // Here we call an event in order to swipe the card
  if Assigned(FOnNeedSwipe) then
  begin
    repeat
      ASwipeCanceled := False;
      ASwipeError    := False;

      if FCardSwiped = '' then begin
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
  FXMLContent := TXMLContent.Create;
  FCCConfig   := TCCConfig.Create;
  FMercuryErrorsCode := TClientDataset.Create(nil);
  debugtofile('loading registry values - begin' );
  showmessage('loading registry values - begin' );
  LoadRegistryValues;
  debugtofile('loading registry values - end' );
  showmessage('loading registry values - end' );
  FTransactionReturn := ttrException;

  // Antonio, September 16, 2013
  fCardNumberList := TStringList.Create;
  fCardNumberList.Duplicates := dupError;
  fcardNumberList.Sorted := true;

end;

destructor TCCWidget.Destroy;
begin
//  FreeAndNil(FClientDevice);
  FreeAndNil(FXMLContent);
  FreeAndNil(FCCConfig);
  freeAndNil(FMercuryErrorsCode);
  freeAndNil(fCardNumberList);
  inherited;
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

function TCCWidget.initializeDsiPDCxXML():String;
var
  strRequest: string;
begin

  strRequest := '';
  fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;

//  strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<TranType>Setup</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>SecureDeviceInit</TranCode>' +  ccrlf +
                ctab + ctab + '<PadType>UIC795</PadType>' +  ccrlf +
                ctab + ctab + '<SecureDevice>UIC795</SecureDevice>' + ccrlf +
                ctab + ctab + '<Comport>0</Comport>' + ccrlf;

  // Add XML, TStream to initialize device
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Admin>' + ccrlf +
            strRequest +
            ctab + '</Admin>' + ccrlf +
            '</TStream>';

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

//   debugtofile('Settings from Registry');
   FCCConfig.FConnectTimeout     := ReadInteger('MercuryConnectTimeout');
//   debugtofile('Mercury Connection Time Out: ' + intToStr(fccconfig.FConnectTimeout));

   FCCConfig.FResponseTimeout    := ReadInteger('MercuryResponseTimeout');
//   debugtofile('Mercury MerchantID: ' + intToStr(fccconfig.FResponseTimeout));

   FCCConfig.FMerchantID         := ReadString('MercuryMerchatID');
//   debugtofile('Mercury MerchantID: ' + fccconfig.FMerchantID);

   FCCConfig.FIpPort             := ReadInteger('MercuryIPPort');
//   debugtofile('Mercury IP Port: ' + intToStr(fccconfig.FIpPort));

   FCCConfig.FDialUpBridge       := ReadBool('MercuryDialUpBridge');


   FCCConfig.FIpAddress          := ReadString('MercuryIPs');
//   debugtofile('Mercury IP Address: ' + fccconfig.FipAddress);


   //amfsouza 12.26.2011 - Mercury Gift Card settings.
   FCCConfig.FMercuryGiftIPPort  := ReadInteger('MercuryGiftIPPort');
//   debugtofile('Mercury Gift IP Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));

   FCCConfig.FMercuryGiftAddress := readString('MercuryGiftIPs');
//   debugtofile('Mercury Gift Address Port: ' + fccconfig.FMercuryGiftAddress);

   // Antonio 2013 Oct 23, MR-74
   setMercuryConfigGiftIntegration(FCCConfig.FIpAddress);
 finally
   Free;
 end;

end;

(*
function TCCWidget.ProcessCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then begin
    debugtofile('settings to time out - begin');
    showmessage('settings to time out - begin');
//    TDSiClientx(FClientDevice).SetConnectTimeout(FCCConfig.FConnectTimeout);
    debugtofile('settings to time out - end');
    showmessage('settings to time out - end');
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then begin
    debugtofile('settings to response time out - begin');
    showmessage('settings to response time out - begin');
//    TDsiClientx(FClientDevice).SetResponseTimeout(FCCConfig.FResponseTimeout);
    debugtofile('settings to response time out - end');
    showmessage('settings to response time out - end');
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes
  debugtofile('getting a XML result from Server Config - begin');
  showmessage('getting a XML result from Server Config - begin');
//  FXMLResult := TDsiClientx(FClientDevice).ServerIPConfig(FCCConfig.FIpAddress, 0);
  debugtofile('getting a XML result from Server Config - end');
  showmessage('getting a XML result from Server Config - end');


  {
  debugtofile('Connection settings defined to send');
  debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
  debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
  debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));

  debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
  debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
  debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

  debugToFile('get Connection ServerIPConfig from DSIClient: ' + FXMLResult);
  }

  FXMLServer := FXMLResult;

//  debugToFile('Verifying Server Config');
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

    debugtofile('XML sent to Mercury in transaction: ' + FXMLsent);
    showmessage('XML sent to Mercury in transaction: ' + FXMLsent);
    debugtofile('Connection settings defined to send');
    debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
    debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
    debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));
    debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
    debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
    debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

//    FXMLResult   := FClientDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;

    debugtofile('XML received from Mercury in transaction: ' + FXMLReceived);
    showmessage('XML received from Mercury in transaction: ' + FXMLReceived);
    debugtofile('Connection settings defined in receive');
    debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
    debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
    debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));
    debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
    debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
    debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

    if VerifyTransaction then
      Result := True;
  end;

end;
*)

function TCCWidget.initializeDsiPDCX: Boolean;
begin
  result := ProcessCommand(initializeDsiPDCxXML);
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
      debugtofile('connection: Success');
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

(*
function TCCWidget.VerifyTransaction: Boolean;
var
  AResult : String;
  IResult : Integer;
begin

  try

    FXMLContent.XML := FXMLResult;
//    debugtofile('XML content to transaction: ' + FXMLContent.XML);
    Result := False;
    FMsg   := '';

    //Indicates the outcome of the command:
    //"Success" = command completed successfully
    //"Error" = error processing command. Check DSIXReturnCode and TextResponse for additional info on error
    AResult := FXMLContent.GetAttributeString('CmdStatus');

    //Six digit return code which identifies the error type. See Section 3 on error codes for possible values
    IResult := FXMLContent.GetAttributeInteger('DSIXReturnCode');

    if (AResult = 'Approved') then
    begin
      debugtofile('Transaction approved');
      showmessage('Transaction approved');
      FResultAuth        := FXMLContent.GetAttributeString('AuthCode');
      FResultAcqRefData  := FXMLContent.GetAttributeString('AcqRefData');
      FResultRefNo       := FXMLContent.GetAttributeString('RefNo');
      FLastDigits        := Copy(Trim(FAcctNo), Length(Trim(FAcctNo)) - 3, 4);
      FAcctNo            := FXMLContent.GetAttributeString('AcctNo');
      FPurchase          := FXMLcontent.GetAttributeDouble('Purchase');
      FAuthorize	       := FXMLContent.GetAttributeDouble('Authorize');
      FBalance           := FXMLContent.GetAttributeDouble('Balance');

      // Antonio 2013 Oct 28,  MR-80
      if ( FXMLContent.GetAttributeString('TranCode') = 'Return' ) then begin
         FPurchase :=(-1) * FPurchase;
      end;

      FMsg               := AResult;
      FTransactionReturn := ttrSuccessfull;
      Result             := True;
    end
    else
    begin
      if (AResult = 'Declined') then begin
        FTransactionReturn := ttrNotSuccessfull;
        debugtofile('transaction declined');
        showmessage('transaction declined');
      end
      else begin
        FTransactionReturn := ttrError;
        debugtofile('transaction error');
        showmessage('transaction error');
      end;
      FErrorCode           := IntToStr(IResult);
      FMsg                 := 'Code: ' + IntToStr(IResult);
      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');

      FMsg := FMsg + '. ' + AResult;
      debugtofile('transaction message: ' + fmsg);
      showmessage('transaction message: ' + fmsg);
    end;

  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      raise Exception.Create('Exception: ' + E.Message);
      debugtofile('transaction had an exception: ' + e.Message);
      showmessage('transaction had an exception: ' + e.Message);
    end;
  end;

end;
*)

(*
{ TCreditDSIClientx }
procedure TCreditDSIClientx.BeforeVoid;
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

constructor TCreditDSIClientx.create;
begin
  inherited;
  FClientDevice := TDSIClientX.create(nil);
end;

function TCreditDSIClientx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +

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

function TCreditDSIClientx.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>'+ FComport+ '</Comport>' +  ccrlf +
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
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
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

function TCreditDSIClientx.ProcessReturn: Boolean;
begin
  BeforeProcessCard;
  Result := ProcessCommand(CreateReturnXML);
end;

function TCreditDSIClientx.ProcessSale: Boolean;
begin
  BeforeProcessCard;
  Result := ProcessCommand(CreateSaleXML);
end;

function TCreditDSIClientx.VoidReturn: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidReturnXML);
end;

function TCreditDSIClientx.VoidReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + fComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

function TCreditDSIClientx.VoidSale: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidSaleXML);
end;

function TCreditDSIClientx.VoidSaleXML: String;
begin

end;

{ TPrePaidEMVx }

function TPrePaidEMVx.CreateReturnXML: String;
begin

end;

function TPrePaidEMVx.CreateSaleXML: String;
begin

end;

function TPrePaidEMVx.prePaidBalance: Boolean;
begin

end;

function TPrePaidEMVx.prePaidBalanceXML: String;
begin

end;

function TPrePaidEMVx.prePaidCashOut: Boolean;
begin

end;

function TPrePaidEMVx.prePaidCashOutXML: String;
begin

end;

function TPrePaidEMVx.prePaidIssue: Boolean;
begin

end;

function TPrePaidEMVx.prePaidIssueXML: String;
begin

end;

function TPrePaidEMVx.prePaidNoNSFSale: Boolean;
begin

end;

function TPrePaidEMVx.prePaidNoNSFSaleXML: String;
begin

end;

function TPrePaidEMVx.prePaidReload: Boolean;
begin

end;

function TPrePaidEMVx.prePaidReloadXML: String;
begin

end;

function TPrePaidEMVx.prePaidSaleXML: String;
begin

end;

function TPrePaidEMVx.prePaidVoidIssue: Boolean;
begin

end;

function TPrePaidEMVx.prePaidVoidIssueXML: String;
begin

end;

function TPrePaidEMVx.prePaidVoidReload: Boolean;
begin

end;

function TPrePaidEMVx.prePaidVoidReloadXML: String;
begin

end;

function TPrePaidEMVx.ProcessReturn: Boolean;
begin

end;

function TPrePaidEMVx.ProcessSale: Boolean;
begin

end;

function TPrePaidEMVx.SwipCard: Boolean;
begin

end;

function TPrePaidEMVx.tryBalanceCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TPrePaidEMVx.tryIssueCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TPrePaidEMVx.VoidReturn: Boolean;
begin

end;

function TPrePaidEMVx.VoidReturnXML: String;
begin

end;

function TPrePaidEMVx.VoidSale: Boolean;
begin

end;

function TPrePaidEMVx.VoidSaleXML: String;
begin

end;

{ TDebitEMVx }

constructor TDebitEMVx.Create;
begin

end;

function TDebitEMVx.CreateReturnXML: String;
begin

end;

function TDebitEMVx.CreateSaleXML: String;
begin

end;

destructor TDebitEMVx.Destroy;
begin

  inherited;
end;

function TDebitEMVx.GetPinNumber: Boolean;
begin

end;

function TDebitEMVx.ProcessReturn: Boolean;
begin

end;

function TDebitEMVx.ProcessSale: Boolean;
begin

end;

{ TCreditEMVx }

procedure TCreditEMVx.BeforeVoid;
begin

end;

function TCreditEMVx.CreateReturnXML: String;
begin

end;

function TCreditEMVx.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>'+ FComport+ '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
 }
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

function TCreditEMVx.ProcessReturn: Boolean;
begin

end;

function TCreditEMVx.ProcessSale: Boolean;
begin

end;

function TCreditEMVx.VoidReturn: Boolean;
begin

end;

function TCreditEMVx.VoidReturnXML: String;
begin

end;

function TCreditEMVx.VoidSale: Boolean;
begin

end;

function TCreditEMVx.VoidSaleXML: String;
begin

end;

{ TDebitDSIClientx }

constructor TDebitDSIClientx.Create;
begin

end;

function TDebitDSIClientx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
               // ctab + ctab + '<Comport>' + fComport +'</Comport>' +  ccrlf +
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

function TDebitDSIClientx.CreateSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>' + fComport + '</Comport>' +  ccrlf +
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

destructor TDebitDSIClientx.Destroy;
begin

  inherited;
end;

function TDebitDSIClientx.GetPinNumber: Boolean;
begin

end;

function TDebitDSIClientx.ProcessReturn: Boolean;
begin

end;

function TDebitDSIClientx.ProcessSale: Boolean;
begin

end;

{ TPrePaidDSICLientx }

function TPrePaidDSICLientx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + FComport + '</Comport>' +  ccrlf +
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
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end;
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

function TPrePaidDSICLientx.CreateSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
         //       ctab + ctab + '<Comport>' + FComport + '</Comport>' +  ccrlf +
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

function TPrePaidDSICLientx.prePaidBalance: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(prePaidBalanceXML);
end;

function TPrePaidDSICLientx.prePaidBalanceXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<IpAdress>' + FCCConfig.FMercuryGiftAddress + '</IpAddress>' + ccrlf;

  if not(FCCConfig.FDialUpBridge) then
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

function TPrePaidDSICLientx.prePaidCashOut: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(prePaidCashOutXML);
end;

function TPrePaidDSICLientx.prePaidCashOutXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<IpAdress>' + FCCConfig.FMercuryGiftAddress + '</IpAddress>' + ccrlf;

  if not(FCCConfig.FDialUpBridge) then
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

function TPrePaidDSICLientx.prePaidIssue: Boolean;
begin

end;

function TPrePaidDSICLientx.prePaidIssueXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
            //    ctab + ctab + '<Comport>' + FComport + '</Comport>' +  ccrlf +

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

function TPrePaidDSICLientx.prePaidNoNSFSale: Boolean;
begin
  BeforeProcessCard;
  result := ProcessCommand(prePaidNoNSFSaleXML);
end;

function TPrePaidDSICLientx.prePaidNoNSFSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<IpAdress>' + FCCConfig.FMercuryGiftAddress + '</IpAddress>' + ccrlf;

  if not(FCCConfig.FDialUpBridge) then
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
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TPrePaidDSICLientx.prePaidReload: Boolean;
begin
  BeforeProcessCard;
  result := ProcessCommand(prePaidReloadXML);
end;

function TPrePaidDSICLientx.prePaidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<IpAdress>' + FCCConfig.FMercuryGiftAddress + '</IpAddress>' + ccrlf;

  if not(FCCConfig.FDialUpBridge) then
    strRequest := strRequest + ctab + ctab + '<IpPort>' + IntToStr(FCCConfig.FMercuryGiftIPPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Reload</TranCode>' +  ccrlf +
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

function TPrePaidDSICLientx.prePaidSaleXML: String;
begin

end;

function TPrePaidDSICLientx.prePaidVoidIssue: Boolean;
begin
   BeforeVoid;
   BeforeProcessCard;
   result := ProcessCommand(prePaidVoidIssueXML);
end;

function TPrePaidDSICLientx.prePaidVoidIssueXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
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

function TPrePaidDSICLientx.prePaidVoidReload: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  result := ProcessCommand(prePaidVoidReloadXML);
end;

function TPrePaidDSICLientx.prePaidVoidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<IpAdress>' + FCCConfig.FMercuryGiftAddress + '</IpAddress>' + ccrlf;

  if not(FCCConfig.FDialUpBridge) then
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

function TPrePaidDSICLientx.ProcessReturn: Boolean;
begin

end;

function TPrePaidDSICLientx.ProcessSale: Boolean;
begin

end;

function TPrePaidDSICLientx.SwipCard: Boolean;
begin

end;

function TPrePaidDSICLientx.tryBalanceCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TPrePaidDSICLientx.tryIssueCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TPrePaidDSICLientx.VoidReturn: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidReturnXML);
end;

function TPrePaidDSICLientx.VoidReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
        //        ctab + ctab + '<Comport>' + fComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

function TPrePaidDSICLientx.VoidSale: Boolean;
begin

end;

function TPrePaidDSICLientx.VoidSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
             //   ctab + ctab + '<Comport>' + FComport +'</Comport>' +  ccrlf +

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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

{ TCreditDSIPDCx }

procedure TCreditDSIPDCx.BeforeVoid;
begin

end;

function TCreditDSIPDCx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + FComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

function TCreditDSIPDCx.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>'+ FComport+ '</Comport>' +  ccrlf +
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
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
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

function TCreditDSIPDCx.ProcessReturn: Boolean;
begin

end;

function TCreditDSIPDCx.ProcessSale: Boolean;
begin

end;

function TCreditDSIPDCx.VoidReturn: Boolean;
begin

end;

function TCreditDSIPDCx.VoidReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
               // ctab + ctab + '<Comport>'+ fComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

function TCreditDSIPDCx.VoidSale: Boolean;
begin

end;

function TCreditDSIPDCx.VoidSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
               // ctab + ctab + '<Comport>'+ fComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

{ TDebitDSIPDCx }

constructor TDebitDSIPDCx.Create;
begin

end;

function TDebitDSIPDCx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + FComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

function TDebitDSIPDCx.CreateSaleXML: String;
begin

end;

destructor TDebitDSIPDCx.Destroy;
begin

  inherited;
end;

function TDebitDSIPDCx.GetPinNumber: Boolean;
begin

end;

function TDebitDSIPDCx.ProcessReturn: Boolean;
begin
  Result := False;
  BeforeProcessCard;
  Result := GetPinNumber;
  if Result then
    Result := ProcessCommand(CreateReturnXML);

end;

function TDebitDSIPDCx.ProcessSale: Boolean;
begin
  Result := False;
  BeforeProcessCard;
  Result := GetPinNumber;
  if Result then
    Result := ProcessCommand(CreateSaleXML);

end;

{ TPrePaidDSIPDCx }

function TPrePaidDSIPDCx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + FComport + '</Comport>' +  ccrlf +
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
{
      // Account Info - Manual
      if ( TDsiClientX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
      end else if ( TDsiPDCX(FClientDevice) <> nil ) then begin
          strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                  //      ctab + ctab + ctab + '<AcctNo>' + FAcctNo + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<AcctNo>PDC</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FExpDate + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

          end;
}
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

function TPrePaidDSIPDCx.CreateSaleXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidBalance: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidBalanceXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidCashOut: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidCashOutXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidIssue: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidIssueXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidNoNSFSale: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidNoNSFSaleXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidReload: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidReloadXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidSaleXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidVoidIssue: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidVoidIssueXML: String;
begin

end;

function TPrePaidDSIPDCx.prePaidVoidReload: Boolean;
begin

end;

function TPrePaidDSIPDCx.prePaidVoidReloadXML: String;
begin

end;

function TPrePaidDSIPDCx.ProcessReturn: Boolean;
begin

end;

function TPrePaidDSIPDCx.ProcessSale: Boolean;
begin

end;

function TPrePaidDSIPDCx.SwipCard: Boolean;
begin

end;

function TPrePaidDSIPDCx.tryBalanceCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TPrePaidDSIPDCx.tryIssueCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TPrePaidDSIPDCx.VoidReturn: Boolean;
begin

end;

function TPrePaidDSIPDCx.VoidReturnXML: String;
begin

end;

function TPrePaidDSIPDCx.VoidSale: Boolean;
begin

end;

function TPrePaidDSIPDCx.VoidSaleXML: String;
begin

end;
*)

{ TCPrePaid }

function TCPrePaid.CreateReturnXML: String;
begin

end;

function TCPrePaid.CreateSaleXML: String;
begin

end;

function TCPrePaid.prePaidBalance: Boolean;
begin

end;

function TCPrePaid.prePaidBalanceXML: String;
begin

end;

function TCPrePaid.prePaidCashOut: Boolean;
begin

end;

function TCPrePaid.prePaidCashOutXML: String;
begin

end;

function TCPrePaid.prePaidIssue: Boolean;
begin

end;

function TCPrePaid.prePaidIssueXML: String;
begin

end;

function TCPrePaid.prePaidNoNSFSale: Boolean;
begin

end;

function TCPrePaid.prePaidNoNSFSaleXML: String;
begin

end;

function TCPrePaid.prePaidReload: Boolean;
begin

end;

function TCPrePaid.prePaidReloadXML: String;
begin

end;

function TCPrePaid.prePaidSaleXML: String;
begin

end;

function TCPrePaid.prePaidVoidIssue: Boolean;
begin

end;

function TCPrePaid.prePaidVoidIssueXML: String;
begin

end;

function TCPrePaid.prePaidVoidReload: Boolean;
begin

end;

function TCPrePaid.prePaidVoidReloadXML: String;
begin

end;

function TCPrePaid.ProcessReturn: Boolean;
begin

end;

function TCPrePaid.ProcessSale: Boolean;
begin

end;

function TCPrePaid.SwipCard: Boolean;
begin

end;

function TCPrePaid.tryBalanceCard(
  arg_salePrice: double): TTransactionReturn;
begin

end;

function TCPrePaid.tryIssueCard(arg_salePrice: double): TTransactionReturn;
begin

end;

function TCPrePaid.VoidReturn: Boolean;
begin

end;

function TCPrePaid.VoidReturnXML: String;
begin

end;

function TCPrePaid.VoidSale: Boolean;
begin

end;

function TCPrePaid.VoidSaleXML: String;
begin

end;

{ TCreditDSIClientx }

procedure TCreditDSIClientx.BeforeVoid;
begin

end;

constructor TCreditDSIClientx.create;
begin
   inherited;
   FDevice := TDSICLientX.Create(nil);
end;

function TCreditDSIClientx.CreateReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +

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

function TCreditDSIClientx.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>'+ FComport+ '</Comport>' +  ccrlf +
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

function TCreditDSIClientx.processCommand(FXML: WideString): Boolean;
begin

end;

function TCreditDSIClientx.ProcessReturn: Boolean;
begin

end;

function TCreditDSIClientx.ProcessSale: Boolean;
begin
  result := inherited processSale();  
end;


function TCreditDSIClientx.verifyTransaction: Boolean;
begin

end;

function TCreditDSIClientx.VoidReturn: Boolean;
begin
  result := inherited voidReturn;   
end;

function TCreditDSIClientx.VoidReturnXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
           //     ctab + ctab + '<Comport>' + fComport + '</Comport>' +  ccrlf +
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

function TCreditDSIClientx.VoidSale: Boolean;
begin
  result := inherited voidSale();
end;

function TCreditDSIClientx.VoidSaleXML: String;
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
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
               // ctab + ctab + '<Comport>'+ fComport + '</Comport>' +  ccrlf +
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

{ TCreditDSIPDCx }

procedure TCreditDSIPDCx.BeforeVoid;
begin

end;

constructor TCreditDSIPDCx.create;
begin
   inherited;
   FDevice := TDsiPDCX.Create(nil);
end;

function TCreditDSIPDCx.CreateReturnXML: String;
begin

end;

function TCreditDSIPDCx.CreateSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FCCConfig.FDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + inttostr(FCCConfig.FIpPort) + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>PDC</SecureDevice>' +  ccrlf +
              //  ctab + ctab + '<Comport>'+ FComport+ '</Comport>' +  ccrlf +
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

function TCreditDSIPDCx.processCommand(FXML: WideString): Boolean;
begin

end;

function TCreditDSIPDCx.ProcessReturn: Boolean;
begin
  result := inherited processReturn();
end;

function TCreditDSIPDCx.ProcessSale: Boolean;
begin
   result := inherited processSale;

end;

function TCreditDSIPDCx.verifyTransaction: Boolean;
begin

end;

function TCreditDSIPDCx.VoidReturn: Boolean;
begin
  result :=  inherited voidReturn;
end;

function TCreditDSIPDCx.VoidReturnXML: String;
begin

end;

function TCreditDSIPDCx.VoidSale: Boolean;
begin
   result := inherited voidSale();
end;

function TCreditDSIPDCx.VoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
              //  ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVPadReset</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>'+QuotedStr('EMV_VX805_MERCURY')+'</SecureDevice>' +  ccrlf +
                //ctab + ctab + '<Comport>' + FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
      			 ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
				    ctab + ctab + '<SequenceNo>0010010010</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

{ TCreditDSIEMVx }

function TCreditDSIEMVx.adjustByRecordNo: Boolean;
begin

end;

function TCreditDSIEMVx.adjustByRecordNoXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVAdjustByRecordNo</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>EMV_VX805_MERCURY</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
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

function TCreditDSIEMVx.afterTransaction: Boolean;
begin
  ProcessCommand(createPadResetXML);
end;

function TCreditDSIEMVx.beforeTransaction: Boolean;
begin
  ProcessCommand(createPadResetXML);
end;

procedure TCreditDSIEMVx.BeforeVoid;
begin

end;

constructor TCreditDSIEMVx.create;
begin
  inherited;
  FEmvPinPad := TPinPad.Create;
end;

function TCreditDSIEMVx.createPadResetXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
              //  ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVPadReset</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>'+QuotedStr('EMV_VX805_MERCURY')+'</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>' + FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
		      	 ctab + ctab + '<SequenceNo>0010010010</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCreditDSIEMVx.CreateReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>EMV_VX805_MERCURY</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				    //ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				    ctab + ctab + '</Amount>';
				    //ctab + ctab + '<LaneID>' + LaneID + '</LaneID>' + ccrlf +
				    //ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf ;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCreditDSIEMVx.CreateSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
              //  ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
              //  ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
              //  ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
              //  ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>'+QuotedStr('EMV_VX805_MERCURY')+'</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ '' + '</Comport>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
				ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				//ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				//ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				ctab + ctab + '</Amount>';
				//ctab + ctab + '<LaneID>' + LaneID + '</LaneID>' + ccrlf +
				//ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf +
			  //	ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
			  //	ctab + ctab + '<PartialAuth>' + PartialAuth + '</PartialAuth>' + ccrlf;
				//ctab + ctab + '<RecordNo>' + RecordNumberRequested + '</RecordNo>' + ccrlf +
				//ctab + ctab + '<Frequency>' + Frequency + '</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCreditDSIEMVx.emvVoiceAuth: Boolean;
begin
   beforeTransaction();
   processCommand(emvVoiceAuthXML);

end;

function TCreditDSIEMVx.emvVoiceAuthXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoiceAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>EMV_VX805_MERCURY</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
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

function TCreditDSIEMVx.emvZeroAuth: Boolean;
begin
  beforeTransaction();
  processCommand(emvZeroAuthXML)
end;

function TCreditDSIEMVx.emvZeroAuthXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVZeroAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>EMV_VX805_MERCURY</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
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

function TCreditDSIEMVx.padReset: Boolean;
begin
  result := processCommand(createPadResetXML);
end;

function TCreditDSIEMVx.processCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;


  FXMLServer := FXMLResult;

//  debugToFile('Verifying Server Config');
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

    debugtofile('XML sent to Mercury in transaction: ' + FXMLsent);
    showmessage('XML sent to Mercury in transaction: ' + FXMLsent);
    debugtofile('Connection settings defined to send');
    debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
    debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
    debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));
    debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
    debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
    debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

    // to call EMV method processTransaction
    FXMLResult   := FDevice.ProcessTransaction(FXMLSent);
    FXMLReceived := FXMLResult;

    debugtofile('XML received from Mercury in transaction: ' + FXMLReceived);
    showmessage('XML received from Mercury in transaction: ' + FXMLReceived);
    debugtofile('Connection settings defined in receive');
    debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
    debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
    debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));
    debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
    debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
    debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

    if VerifyTransaction then
      Result := True;
  end;

end;

function TCreditDSIEMVx.ProcessReturn: Boolean;
begin
  beforeTransaction();
  processCommand(CreateReturnXML);
end;

function TCreditDSIEMVx.ProcessSale: Boolean;
begin
  beforeTransaction();
  processCommand(CreateSaleXML);
//  afterTransaction();
end;

function TCreditDSIEMVx.verifyTransaction: Boolean;
var
  AResult : String;
  IResult : Integer;
begin

  try

    FXMLContent.XML := FXMLResult;
//    debugtofile('XML content to transaction: ' + FXMLContent.XML);
    Result := False;
    FMsg   := '';

    //Indicates the outcome of the command:
    //"Success" = command completed successfully
    //"Error" = error processing command. Check DSIXReturnCode and TextResponse for additional info on error
    AResult := FXMLContent.GetAttributeString('CmdStatus');

    //Six digit return code which identifies the error type. See Section 3 on error codes for possible values
    IResult := FXMLContent.GetAttributeInteger('DSIXReturnCode');

    if (AResult = 'Approved') then
    begin
      debugtofile('Transaction approved');
      showmessage('Transaction approved');
      FResultAuth        := FXMLContent.GetAttributeString('AuthCode');
      FResultAcqRefData  := FXMLContent.GetAttributeString('AcqRefData');
      FResultRefNo       := FXMLContent.GetAttributeString('RefNo');
      FLastDigits        := Copy(Trim(FAcctNo), Length(Trim(FAcctNo)) - 3, 4);
      FAcctNo            := FXMLContent.GetAttributeString('AcctNo');
      FPurchase          := FXMLcontent.GetAttributeDouble('Purchase');
      FAuthorize	       := FXMLContent.GetAttributeDouble('Authorize');
      FBalance           := FXMLContent.GetAttributeDouble('Balance');

      // Antonio 2013 Oct 28,  MR-80
      if ( FXMLContent.GetAttributeString('TranCode') = 'Return' ) then begin
         FPurchase :=(-1) * FPurchase;
      end;

      FMsg               := AResult;
      FTransactionReturn := ttrSuccessfull;
      Result             := True;
    end
    else
    begin
      if (AResult = 'Declined') then begin
        FTransactionReturn := ttrNotSuccessfull;
        debugtofile('transaction declined');
        showmessage('transaction declined');
      end
      else begin
        FTransactionReturn := ttrError;
        debugtofile('transaction error');
        showmessage('transaction error');
      end;
      FErrorCode           := IntToStr(IResult);
      FMsg                 := 'Code: ' + IntToStr(IResult);
      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');

      FMsg := FMsg + '. ' + AResult;
      debugtofile('transaction message: ' + fmsg);
      showmessage('transaction message: ' + fmsg);
    end;

  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      raise Exception.Create('Exception: ' + E.Message);
      debugtofile('transaction had an exception: ' + e.Message);
      showmessage('transaction had an exception: ' + e.Message);
    end;
  end;

end;

function TCreditDSIEMVx.VoidReturn: Boolean;
begin
  beforeTransaction();
  processCommand(VoidReturnXML);
end;

function TCreditDSIEMVx.voidReturnByRecordNo: Boolean;
begin
  beforeTransaction();
  processCommand(voidReturnByRecordNoXML);
end;

function TCreditDSIEMVx.voidReturnByRecordNoXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturnByRecordNo</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>EMV_VX805_MERCURY</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
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

function TCreditDSIEMVx.VoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturn</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>EMV_VX805_MERCURY</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '<InvoiceNo>' + ccrlf +
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
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>';// + ccrlf +
                //ctab + ctab + '<ProcessData>' + FProcessData + '</ProcessData>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCreditDSIEMVx.VoidSale: Boolean;
begin
   beforeTransaction();
   processCommand(VoidSaleXML);
end;

function TCreditDSIEMVx.voidSaleByRecordNo: Boolean;
begin
   beforeTransaction();
   processCommand(voidSaleByRecordNoXML);

end;

function TCreditDSIEMVx.voidSaleByRecordNoXML: string;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
              //  ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
              //  ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
              //  ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidSaleByRecordNo</TranCode>' +  ccrlf +
              //  ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>'+QuotedStr('EMV_VX805_MERCURY')+'</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ FEmvPinPad.FComPort + '</Comport>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FInvoiceNo + '</InvoiceNo>' + ccrlf +
			     	 ctab + ctab + '<RefNo>' + FrefNo + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' + FAuthCode + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
					 ctab + ctab + ctab + '<Purchase>' + floatToStr(fPurchase) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				//ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
					 ctab + ctab + '</Amount>' + ccrlf +
					 //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                //ctab + ctab + '<PartialAuth>' + fPartialauth + '</PartialAuth>' + ccrlf +
                ctab + ctab + '<RecordNo>' + FResultRefNo + '<RecordNo>' + ccrlf +
                //ctab + ctab + '<Frequency>' + fFrequency + '</Frequency>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AccqRefData>';// + ccrlf;
					 //ctab + ctab + '<ProcessData>' + fProcessData + '</ProcessData>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TCreditDSIEMVx.VoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FCCConfig.FIpAddress + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
              //  ctab + ctab + '<IpPort>' + FCCConfig.FIpAddress + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FCCConfig.FMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + '' + '</TerminalID>' + ccrlf +
              //  ctab + ctab + '<OperatorID>' + FOperatorID + '</OperatorID>' + ccrlf +
              //  ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidSale</TranCode>' +  ccrlf +
              //  ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
                ctab + ctab + '<SecureDevice>'+QuotedStr('EMV_VX805_MERCURY')+'</SecureDevice>' +  ccrlf +
                ctab + ctab + '<Comport>'+ '' + '</Comport>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
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
					// ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AccqRefData>';// + ccrlf;
					 //ctab + ctab + '<ProcessData>' + fProcessData + '</ProcessData>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

end.


