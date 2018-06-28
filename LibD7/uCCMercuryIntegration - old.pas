unit uCCMercuryIntegration;

interface

uses Windows, SysUtils, Dialogs, DSICLIENTXLib_TLB, VER1000XLib_TLB, uXML,
  uCreditCardFunction, uOperationSystem, dbClient, classes;

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

  TCCWidget  = class
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
    FDSICLientX            : TDSICLientX;
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

    procedure LoadRegistryValues;
    procedure setMercuryConfigGiftIntegration(arg_ipAddress: String);
  private
    function getTransactionErrorLevel: TTransactionErrorLevel;
    procedure setMercuryErrorsCode(const Value: TClientDataSet);
  protected
    // Antonio, August 23, 2013 - to be removed to a specific class
    function getSecureSerialNumber(arg_serialNumber: String): String;
    function VerifyServerConfig : Boolean;
    function VerifyTransaction : Boolean;
    function CreateSaleXML : String; virtual; abstract;
    function CreateRefundXML : String; virtual; abstract;
    function ProcessCommand(FXML : WideString) : Boolean;

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
    function ProcessRefund : Boolean; virtual; abstract;

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
      function CreateSaleXML : String; override;
      function CreateRefundXML : String; override;
      function VoidSaleXML : String; virtual;   // amfsouza 10.18.2011
      function VoidRefundXML : String; virtual; // amfsouza 10.18.2011
      procedure BeforeVoid;
    public
      function ProcessSale : Boolean; override;
      function ProcessRefund : Boolean; override;
      function VoidSale : Boolean; virtual;    // amfsouza 10.18.2011
      function VoidRefund : Boolean; virtual;  // amfsouza 10.18.2011
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

  TCDebit  = class(TCCWidget)
    FCashBack  : Currency;
    FPINBlock  : String;
    FDervdKey  : String;
    FMPinPad   : TPinPad;
    function GetPinNumber : Boolean;
    protected
      function CreateSaleXML : String; override;
      function CreateRefundXML : String; override;
    public
      Constructor Create;
      Destructor Destroy; override;

      function ProcessSale : Boolean; override;
      function ProcessRefund : Boolean; override;
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
      function CreateRefundXML : String; override;
      function VoidSaleXML : String; override;
      function VoidRefundXML : String; override;
      function prePaidReloadXML: String;
      function prePaidVoidReloadXML: String;
      function prePaidBalanceXML: String;
      function prePaidNoNSFSaleXML: String;
      function prePaidCashOutXML: String;

    public
      function SwipCard: Boolean;
      function ProcessSale : Boolean; override;
      function ProcessRefund : Boolean; override;
      function VoidSale : Boolean; override;
      function VoidRefund : Boolean; override;
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




implementation

uses Registry, uSystemConst, uDebugFunctions;

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

function TCCredit.CreateRefundXML: String;
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

function TCCredit.ProcessRefund: Boolean;
begin
  BeforeProcessCard;
  Result := ProcessCommand(CreateRefundXML);
end;

function TCCredit.ProcessSale: Boolean;
begin
  BeforeProcessCard;
  Result := ProcessCommand(CreateSaleXML);
end;

function TCCredit.VoidRefund: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidRefundXML);
end;

function TCCredit.VoidRefundXML: String;
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

function TCCredit.VoidSale: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidSaleXML);
end;

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

{ TCDebit }

constructor TCDebit.Create;
begin
  inherited;
  FMPinPad := TPinPad.Create;
end;

function TCDebit.CreateRefundXML: String;
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

function TCDebit.ProcessRefund: Boolean;
begin
  Result := False;
  BeforeProcessCard;
  Result := GetPinNumber;
  if Result then
    Result := ProcessCommand(CreateRefundXML);
end;

function TCDebit.ProcessSale: Boolean;
begin
  Result := False;
  BeforeProcessCard;
  Result := GetPinNumber;
  if Result then
    Result := ProcessCommand(CreateSaleXML);
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
  FVer1000X   := TVer1000X.Create(nil);
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
  FDSICLientX := TDSICLientX.Create(nil);
  FXMLContent := TXMLContent.Create;
  FCCConfig   := TCCConfig.Create;
  FMercuryErrorsCode := TClientDataset.Create(nil);
  LoadRegistryValues;
  FTransactionReturn := ttrException;

  // Antonio, September 16, 2013
  fCardNumberList := TStringList.Create;
  fCardNumberList.Duplicates := dupError;
  fcardNumberList.Sorted := true;

end;

destructor TCCWidget.Destroy;
begin
  FreeAndNil(FDSICLientX);
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

   debugtofile('Settings from Registry');
   FCCConfig.FConnectTimeout     := ReadInteger('MercuryConnectTimeout');
   debugtofile('Mercury Connection Time Out: ' + intToStr(fccconfig.FConnectTimeout));

   FCCConfig.FResponseTimeout    := ReadInteger('MercuryResponseTimeout');
   debugtofile('Mercury MerchantID: ' + intToStr(fccconfig.FResponseTimeout));

   FCCConfig.FMerchantID         := ReadString('MercuryMerchatID');
   debugtofile('Mercury MerchantID: ' + fccconfig.FMerchantID);

   FCCConfig.FIpPort             := ReadInteger('MercuryIPPort');
   debugtofile('Mercury IP Port: ' + intToStr(fccconfig.FIpPort));

   FCCConfig.FDialUpBridge       := ReadBool('MercuryDialUpBridge');


   FCCConfig.FIpAddress          := ReadString('MercuryIPs');
   debugtofile('Mercury IP Address: ' + fccconfig.FipAddress);


   //amfsouza 12.26.2011 - Mercury Gift Card settings.
   FCCConfig.FMercuryGiftIPPort  := ReadInteger('MercuryGiftIPPort');
   debugtofile('Mercury Gift IP Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));

   FCCConfig.FMercuryGiftAddress := readString('MercuryGiftIPs');
   debugtofile('Mercury Gift Address Port: ' + fccconfig.FMercuryGiftAddress);

   // Antonio 2013 Oct 23, MR-74
   setMercuryConfigGiftIntegration(FCCConfig.FIpAddress);
 finally
   Free;
 end;

end;

function TCCWidget.ProcessCommand(FXML: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if FCCConfig.FConnectTimeout <> -1 then
    FDSICLientX.SetConnectTimeout(FCCConfig.FConnectTimeout);

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if FCCConfig.FResponseTimeout <> -1 then
    FDSICLientX.SetResponseTimeout(FCCConfig.FResponseTimeout);

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes
  FXMLResult := FDSICLientX.ServerIPConfig(FCCConfig.FIpAddress, 0);

  debugtofile('Connection settings defined to send');
  debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
  debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
  debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));

  debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
  debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
  debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

  debugToFile('get Connection ServerIPConfig from DSIClient: ' + FXMLResult);

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
    debugtofile('Connection settings defined to send');
    debugtofile('Mercury Connection Time Out: '+ intTostr(fccconfig.FConnectTimeout));
    debugtofile('Mercury Response Time Out: '+ intTostr(fccconfig.FResponseTimeout));
    debugTofile('Mercury Ip Port: ' + intToStr(fccconfig.FMercuryGiftIPPort));
    debugtofile('Mercury IP Address: '+ FCCConfig.FIpAddress);
    debugtofile('Merchant ID: '+ FCCConfig.FMerchantID);
    debugtofile('Mercury Gift Address: ' + FCCConfig.FMercuryGiftAddress);

    FXMLResult   := FDSICLientX.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;

    debugtofile('XML received from Mercury in transaction: ' + FXMLReceived);
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
      end
      else begin
        FTransactionReturn := ttrError;
        debugtofile('transaction error');
      end;
      FErrorCode           := IntToStr(IResult);
      FMsg                 := 'Code: ' + IntToStr(IResult);
      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');

      FMsg := FMsg + '. ' + AResult;
      debugtofile('transaction message: ' + fmsg);
    end;

  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      raise Exception.Create('Exception: ' + E.Message);
      debugtofile('transaction had an exception: ' + e.Message);
    end;
  end;

end;


{ TCPrePaid }

function TCPrePaid.CreateRefundXML: String;
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

function TCPrePaid.CreateSaleXML: String;
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

function TCPrePaid.prePaidBalance: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(prePaidBalanceXML);
end;

function TCPrePaid.prePaidBalanceXML: String;
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

function TCPrePaid.prePaidCashOut: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(prePaidCashOutXML);
end;

function TCPrePaid.prePaidCashOutXML: String;
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

function TCPrePaid.prePaidIssue: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(prePaidIssueXML);
end;

function TCPrePaid.prePaidIssueXML: String;
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

function TCPrePaid.prePaidNoNSFSale: Boolean;
begin
  BeforeProcessCard;
  result := ProcessCommand(prePaidNoNSFSaleXML);
end;

function TCPrePaid.prePaidNoNSFSaleXML: String;
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

function TCPrePaid.prePaidReload: Boolean;
begin
  BeforeProcessCard;
  result := ProcessCommand(prePaidReloadXML);
end;

function TCPrePaid.prePaidReloadXML: String;
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

function TCPrePaid.prePaidSaleXML: String;
begin

end;

function TCPrePaid.prePaidVoidIssue: Boolean;
begin
   BeforeVoid;
   BeforeProcessCard;
   result := ProcessCommand(prePaidVoidIssueXML);
end;

function TCPrePaid.prePaidVoidIssueXML: String;
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

function TCPrePaid.prePaidVoidReload: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  result := ProcessCommand(prePaidVoidReloadXML);
end;

function TCPrePaid.prePaidVoidReloadXML: String;
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

function TCPrePaid.ProcessRefund: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(CreateRefundXML);
end;

function TCPrePaid.ProcessSale: Boolean;
begin
   BeforeProcessCard;
   result := ProcessCommand(CreateSaleXML);
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

function TCPrePaid.tryBalanceCard(arg_salePrice: double): TTransactionReturn;
var
  msg: String;
  msgButtonSelected: Integer;
  balanceToBeAdded: double;
begin
  self.prePaidBalance;

  result := fTransactionReturn;

  // Antonio, 2013 Oct 19 - (MR-67)
  if ( FXMLContent.GetAttributeString('CmdStatus') = 'Approved' ) then begin
     balanceToBeAdded := self.balance + arg_saleprice;
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

function TCPrePaid.VoidRefund: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidRefundXML);
end;

function TCPrePaid.VoidRefundXML: String;
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

function TCPrePaid.VoidSale: Boolean;
begin
  BeforeVoid;
  BeforeProcessCard;
  Result := ProcessCommand(VoidSaleXML);
end;

function TCPrePaid.VoidSaleXML: String;
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

(*
  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + FCustomerCode + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;
*)

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

end.
