unit MercuryProcessor;

interface
uses Windows, Classes, SysUtils, contnrs, ProcessorInterface, uCreditCardFunction, uOperationSystem, uSystemConst;

type
	TMercuryProcessor = class(TInterfacedObject, IProcessor)
	private
	    FTerminalID: String;
        fDeviceParamValue: Integer;
        fIsDeviceInitialized: Boolean;
        fClassTypeName: String;
        FpadType: String;
        FsecureDevice: String;
        FIdPaymentType: Integer;
        FCustomerCode: String;
        FManualCvv: String;
        FmanualCvv2: String;
        FmanualZipCode: String;
        FmanualStreet: String;
        FManualMember: String;
        FExpireDate: String;
        FTax: Double;
        FInvoiceNo: String;
        FMessage: String;
        FoperatorID: String;
        FAcctNo: String;
        FAppLabel: String;
        FAuthCode: String;
        FCardType: String;
        FDateTransaction: String;
        FEntryMethod: String;
        FIpPort: String;
        FIPProcessorAddress: String;
        FLabelAID: String;
        FlabelARC: String;
        FLabelCVM: String;
        FLabelIAD: String;
        FLabelTSI: String;
        FLabelTVR: String;
        FLastDigits: String;
        FMerchantID: String;
        FRecordNo: String;
        FRefNo: String;
        FResultAcqRefData: String;
        FSequenceNo: String;
        FTimeTransaction: String;
        FTrancode: String;
        FTrueCardTypeName: String;

        FPurchase: Currency;
        FAuthorize: Currency;
        FBalance: Currency;

        FConnectionTimeOut: Integer;
        FResponseTimeOut: Integer;

        FgiftIP: String;
        FgiftPort: String;
        FgiftMerchantID: String;

        FdialUpBridge: Boolean;
        FTransactionResult: TTransactionReturn;

	public
        constructor create();

	    procedure SetTerminalID(arg_terminalID: String);
		function GetTerminalID(): String;
		
        procedure SetDeviceInitialized(arg_started: Boolean);
        function IsDeviceInitialized(): Boolean;
        procedure SetDeviceIniParameter(arg_value: Integer);

        function GetClassTypeName(): String;

        procedure SetPadType(arg_name: String);
        function GetPadType(): String;

        procedure SetSecureDevice(arg_sdcode: String);
        function GetSecureDevice(): String;
        
        procedure SetTax(arg_tax: double);
        function GetTax(): Double;

        procedure SetInvoiceNo(arg_invoiceNo: String);
        function GetInvoiceNo(): String;

        procedure SetOperatorID(arg_operatorID: String);
        function GetOperatorID(): String;

        procedure SetAuthCode(arg_authCode: String);
        function GetAuthCode(): String;

        procedure SetResultAcqRefData(arg_acqRefData: String);
        function GetResultAcqRefData(): String;

        procedure SetRefNo(arg_refNo: String);
        function GetRefNo(): String;

        procedure SetAcctNo(arg_acctNo: String);
        function GetAcctNo(): String;

        procedure SetLastDigits(arg_lastDigits: String);
        function GetLastDigits(): String;

        procedure SetMerchantID(arg_merchantID: String);
        function GetMerchantID(): String;

        procedure SetPurchase(arg_purchase: Currency);
        function GetPurchase(): Currency;

        procedure SetAuthorize(arg_authorize: Currency);
        function GetAuthorize(): Currency;

        procedure SetSequenceNo(arg_sequence: String);
        function GetSequenceNo(): String;

        procedure SetTrueCardTypeName(arg_name: String);
        function GetTrueCardTypeName(): String;

        procedure SetCardType(arg_type: String);
        function GetCardType(): String;

        procedure SetEntryMethod(arg_entryMethod: String);
        function GetEntryMethod(): String;

        procedure SetAppLabel(arg_appLabel: String);
        function GetAppLabel(): String;

        procedure SetRecordNo(arg_recordNo: String);
        function GetRecordNo(): String;

        procedure SetIPPort(arg_port: String);
        function GetIPPort(): String;

		procedure SetIPAddress(arg_address: String);
		function  GetIPAddress(): String;

        function GetMerchandID(): String;

        procedure SetIPProcessorAddress(arg_address: String);
        function GetIPProcessorAddres(): String;

        procedure SetConnectionTimeOut(arg_timeOut: Integer);
        function GetConnectionTimeOut(): Integer;

        procedure SetResponseTimeOut(arg_responseTimeOut: Integer);
        function GetResponseTimeOut(): Integer;

        procedure SetMessage(arg_msg: String);
        function GetMessage(): String;

        procedure SetGiftIP(arg_giftIP: String);
        function GetGiftIP(): String;

        procedure SetGiftPort(arg_giftPort: String);
        function GetGiftPort(): String;

        procedure SetGiftMerchantID(arg_merchantid: String);
        function GetGiftMerchantID(): String;

        procedure SetDialUpBridge(arg_dialBridge: Boolean);
        function GetDialUpBridge(): Boolean;

        procedure SetManualStreeAddress(arg_address: String);
        function GetManualStreeAddress(): String;

        procedure SetManualZipCode(arg_zipCode: String);
        function GetManualZipCode(): String;

        procedure SetManualCVV2(arg_cvv2: String);
        function GetManualCvv2(): String;

        procedure SetManualCardNumber(arg_cardNumber: String);
        function GetManualCardNumber(): String;

        procedure SetManualMemberName(arg_member: String);
        function GetManualMemberName(): String;

        procedure SetManualCvv(arg_cvv: String);
        function GetManualCvv(): String;

        procedure SetExpireDate(arg_date: String);
        function GetExpireDate(): String;

        procedure SetCustomerCode(arg_customerCode: String);
        function GetCustomerCode(): String;

        procedure SetIdPaymentType(arg_paymentType: Integer);
        function GetIdPaymentType(): Integer;

        procedure SetTransactionResult(arg_result: TTransactionReturn);
        function GetTransactionResult(): TTransactionReturn;

        procedure SetBalance(arg_balance: Currency);
        function GetBalance(): Currency;

         procedure SetTransactionErrorCode(arg_transerror: String);
        function GetransactionErrorCode(): String;


        // methods bellow are only to EMV transactions
        procedure SetDateTransaction(arg_date: String);
        function GetDateTransaction(): String;

        procedure SetTimeTransaction(arg_time: String);
        function GetTimeTransaction(): String;

        procedure SetLabelAID(arg_label: String);
        function GetLabelAID(): String;

        procedure SetLabelTVR(arg_label: String);
        function GetLabelTVR(): String;

        procedure SetLabelIAD(arg_label: String);
        function GetLAbelIAD(): String;

        procedure SetLabelTSI(arg_label: String);
        function GetLabelTSI(): String;

        procedure SetLabelARC(arg_label: String);
        function GetLabelARC(): String;

        procedure SetLabelCVM(arg_label: String);
        function GetLabelCVM(): String;

        procedure SetTrancode(arg_trancode: String);
        function GetTrancode(): String;


	end;


implementation
uses Registry;

{ TMercuryProcessor }

constructor TMercuryProcessor.create;
begin
   fClassTypeName := 'TMercuryProcessor';
end;

function TMercuryProcessor.GetAcctNo: String;
begin
   result := FAcctNo;
end;

function TMercuryProcessor.GetAppLabel: String;
begin
   result := FAppLabel;
end;

function TMercuryProcessor.GetAuthCode: String;
begin
   result := FAuthCode;
end;

function TMercuryProcessor.GetAuthorize: Currency;
begin
   result := FAuthorize;
end;

function TMercuryProcessor.GetCardType: String;
begin
   result := FCardType;
end;

function TMercuryProcessor.GetConnectionTimeOut: Integer;
begin
   result := FConnectionTimeOut;
end;

function TMercuryProcessor.GetCustomerCode: String;
begin
   result := fcustomerCode;
end;

function TMercuryProcessor.GetDateTransaction: String;
begin
  result := FDateTransaction;
end;

function TMercuryProcessor.GetDialUpBridge: Boolean;
begin
  result  := fdialUpBridge;
end;

function TMercuryProcessor.GetEntryMethod: String;
begin
  result := FEntryMethod;
end;

function TMercuryProcessor.GetExpireDate: String;
begin
   result :=  fExpireDate;
end;

function TMercuryProcessor.GetGiftIP: String;
begin
  result := FgiftIP;
end;

function TMercuryProcessor.GetGiftPort: String;
begin
  result := FgiftPort;
end;

function TMercuryProcessor.GetGiftMerchantID: String;
begin
  result := FgiftMerchantID;
end;

function TMercuryProcessor.GetIdPaymentType: Integer;
begin
  result := FIdPaymentType;
end;

function TMercuryProcessor.GetInvoiceNo: String;
begin
  result := fInvoiceNo;
end;

function TMercuryProcessor.GetIPPort: String;
begin
  result := FIPPort;
end;

function TMercuryProcessor.GetIPProcessorAddres: String;
begin
  result := FIPProcessorAddress;
end;

function TMercuryProcessor.GetLabelAID: String;
begin
  result := FLabelAID;
end;

function TMercuryProcessor.GetLabelARC: String;
begin
  result := FLabelARC;
end;

function TMercuryProcessor.GetLabelCVM: String;
begin
  result := FLabelCVM;
end;

function TMercuryProcessor.GetLabelIAD: String;
begin
  result := FLabelIAD;
end;

function TMercuryProcessor.GetLabelTSI: String;
begin
  result := FLabelTSI;
end;

function TMercuryProcessor.GetLabelTVR: String;
begin
  result := FLabelTVR;
end;

function TMercuryProcessor.GetLastDigits: String;
begin
  result := FlastDigits;
end;

function TMercuryProcessor.GetManualCardNumber: String;
begin
  result := FManualMember;
end;

function TMercuryProcessor.GetManualCvv: String;
begin
  result := FManualCvv;
end;

function TMercuryProcessor.GetManualCvv2: String;
begin
  result := FmanualCvv2;
end;

function TMercuryProcessor.GetManualMemberName: String;
begin
  result := FManualMember;
end;

function TMercuryProcessor.GetManualStreeAddress: String;
begin
   result := FmanualStreet;
end;

function TMercuryProcessor.GetManualZipCode: String;
begin
   result := FmanualZipCode;
end;

function TMercuryProcessor.GetMerchandID: String;
begin
 result := FMerchantID;
end;

function TMercuryProcessor.GetMerchantID: String;
begin
  result := FMerchantID;
end;

function TMercuryProcessor.GetMessage: String;
begin
  result := FMessage;
end;

function TMercuryProcessor.GetOperatorID: String;
begin
  result := FoperatorID;
end;

function TMercuryProcessor.GetPurchase: Currency;
begin
  result := FPurchase;
end;

function TMercuryProcessor.GetRecordNo: String;
begin
  result := FRecordNo;
end;

function TMercuryProcessor.GetRefNo: String;
begin
  result := FRefNo;
end;

function TMercuryProcessor.GetResponseTimeOut: Integer;
begin
   result := FResponseTimeOut;
end;

function TMercuryProcessor.GetResultAcqRefData: String;
begin
   result := FResultAcqRefData;
end;

function TMercuryProcessor.GetSequenceNo: String;
begin
   result := FSequenceNo;
end;

function TMercuryProcessor.GetTax: Double;
begin
  result := FTax;
end;

function TMercuryProcessor.GetTimeTransaction: String;
begin
   result := FTimeTransaction;
end;

function TMercuryProcessor.GetTrancode: String;
begin
   result := FTrancode;
end;

function TMercuryProcessor.GetTransactionResult: TTransactionReturn;
begin

end;

function TMercuryProcessor.GetTrueCardTypeName: String;
begin
  result := FTrueCardTypeName;
end;

procedure TMercuryProcessor.SetAcctNo(arg_acctNo: String);
begin
   FAcctNo := arg_acctNo;
end;

procedure TMercuryProcessor.SetAppLabel(arg_appLabel: String);
begin
   FAppLabel := arg_appLabel;
end;

procedure TMercuryProcessor.SetAuthCode(arg_authCode: String);
begin
   FAuthCode := arg_authCode;
end;

procedure TMercuryProcessor.SetAuthorize(arg_authorize: Currency);
begin
   FAuthorize := arg_authorize;
end;

procedure TMercuryProcessor.SetCardType(arg_type: String);
begin
   FCardType := arg_type;
end;

procedure TMercuryProcessor.SetConnectionTimeOut(arg_timeOut: Integer);
begin
   FConnectionTimeOut := arg_timeOut;
end;

procedure TMercuryProcessor.SetCustomerCode(arg_customerCode: String);
begin
  FCustomerCode := arg_customerCode;
end;

procedure TMercuryProcessor.SetDateTransaction(arg_date: String);
begin
   FDateTransaction := arg_date;
end;

procedure TMercuryProcessor.SetDialUpBridge(arg_dialBridge: Boolean);
begin
   FdialUpBridge := arg_dialBridge;
end;

procedure TMercuryProcessor.SetEntryMethod(arg_entryMethod: String);
begin
   FEntryMethod := arg_entryMethod;
end;

procedure TMercuryProcessor.SetExpireDate(arg_date: String);
begin
   FExpireDate := arg_date;
end;

procedure TMercuryProcessor.SetGiftIP(arg_giftIP: String);
begin
   FgiftIP := arg_giftIP;
end;

procedure TMercuryProcessor.SetGiftPort(arg_giftPort: String);
begin
   FgiftPort := arg_giftPort;
end;

procedure TMercuryProcessor.SetGiftMerchantID(arg_merchantid: String);
begin
   fGiftMerchantID := arg_merchantid;
end;

procedure TMercuryProcessor.SetIdPaymentType(arg_paymentType: Integer);
begin
  FIdPaymentType := arg_paymentType;
end;

procedure TMercuryProcessor.SetInvoiceNo(arg_invoiceNo: String);
begin
   FinvoiceNo := arg_invoiceNo;
end;

procedure TMercuryProcessor.SetIPPort(arg_port: String);
begin
   FIPPort := arg_port;
end;

procedure TMercuryProcessor.SetIPProcessorAddress(arg_address: String);
begin
   FIPProcessorAddress := arg_address;
end;

procedure TMercuryProcessor.SetLabelAID(arg_label: String);
begin
   FLabelAID := arg_label;
end;

procedure TMercuryProcessor.SetLabelARC(arg_label: String);
begin
   FLabelARC := arg_label;
end;

procedure TMercuryProcessor.SetLabelCVM(arg_label: String);
begin
   FLabelCVM := arg_label;
end;

procedure TMercuryProcessor.SetLabelIAD(arg_label: String);
begin

end;

procedure TMercuryProcessor.SetLabelTSI(arg_label: String);
begin
   FLabelTSI := arg_label;
end;

procedure TMercuryProcessor.SetLabelTVR(arg_label: String);
begin
   FLabelTVR := arg_label;
end;

procedure TMercuryProcessor.SetLastDigits(arg_lastDigits: String);
begin
   FLastDigits := arg_lastDigits;
end;

procedure TMercuryProcessor.SetManualCardNumber(arg_cardNumber: String);
begin
  FAcctNo := arg_cardNumber;
end;

procedure TMercuryProcessor.SetManualCvv(arg_cvv: String);
begin
  FManualCvv := arg_cvv;
end;

procedure TMercuryProcessor.SetManualCVV2(arg_cvv2: String);
begin
  FmanualCvv2 := arg_cvv2;
end;

procedure TMercuryProcessor.SetManualMemberName(arg_member: String);
begin
  FManualMember := arg_member;
end;

procedure TMercuryProcessor.SetManualStreeAddress(arg_address: String);
begin
   FmanualStreet := arg_address;
end;

procedure TMercuryProcessor.SetManualZipCode(arg_zipCode: String);
begin
   FmanualZipCode := arg_zipCode;
end;

procedure TMercuryProcessor.SetMerchantID(arg_merchantID: String);
begin
  FMerchantID := arg_merchantID;
end;

procedure TMercuryProcessor.SetMessage(arg_msg: String);
begin
  FMessage := arg_msg;
end;

procedure TMercuryProcessor.SetOperatorID(arg_operatorID: String);
begin
  FoperatorID := arg_operatorID;
end;

procedure TMercuryProcessor.SetPurchase(arg_purchase: Currency);
begin
   FPurchase := arg_purchase;
end;

procedure TMercuryProcessor.SetRecordNo(arg_recordNo: String);
begin
   FRecordNo := arg_recordNo;
end;

procedure TMercuryProcessor.SetRefNo(arg_refNo: String);
begin
   FRefNo := arg_refNo;
end;

procedure TMercuryProcessor.SetResponseTimeOut(
  arg_responseTimeOut: Integer);
begin
   FResponseTimeOut := arg_responseTimeOut;
end;

procedure TMercuryProcessor.SetResultAcqRefData(arg_acqRefData: String);
begin
  FResultAcqRefData := arg_acqRefData;
end;

procedure TMercuryProcessor.SetSequenceNo(arg_sequence: String);
begin
   FSequenceNo := arg_sequence;
end;

procedure TMercuryProcessor.SetTax(arg_tax: double);
begin

end;

procedure TMercuryProcessor.SetTimeTransaction(arg_time: String);
begin
   FTimeTransaction := arg_time;
end;

procedure TMercuryProcessor.SetTrancode(arg_trancode: String);
begin
   FTrancode := arg_trancode;
end;

procedure TMercuryProcessor.SetTransactionResult(
  arg_result: TTransactionReturn);
begin

end;

procedure TMercuryProcessor.SetTrueCardTypeName(arg_name: String);
begin
   FTrueCardTypeName := arg_name;
end;

function TMercuryProcessor.GetBalance: Currency;
begin
   result := fBalance;
end;

procedure TMercuryProcessor.SetBalance(arg_balance: Currency);
begin
  fBalance := arg_balance;
end;

function TMercuryProcessor.GetransactionErrorCode: String;
begin
   result := FTrancode;
end;

procedure TMercuryProcessor.SetTransactionErrorCode(
  arg_transerror: String);
begin
   FTrancode := arg_transerror;
end;

function TMercuryProcessor.GetPadType: String;
begin
  result := FpadType;
end;

function TMercuryProcessor.GetSecureDevice: String;
begin
   result := FsecureDevice;
end;

procedure TMercuryProcessor.SetPadType(arg_name: String);
begin
  FpadType := arg_name;
end;

procedure TMercuryProcessor.SetSecureDevice(arg_sdcode: String);
begin
  FsecureDevice := arg_sdcode;
end;

function TMercuryProcessor.GetClassTypeName: String;
begin
  result := fClassTypeName;
end;

function TMercuryProcessor.IsDeviceInitialized: Boolean;
var
  buildInfo: String;
begin
 with TRegistry.Create do begin
     try
       // aponta para a chave CURRENT_USER se Windows 7
       if ( getOs(buildInfo) = osW7 ) then
         RootKey := HKEY_CURRENT_USER
       else
         RootKey := HKEY_LOCAL_MACHINE;

       OpenKey(REGISTRY_PATH, True);

         try
           result := ( ( fDeviceParamValue = 1) or (fDeviceParamValue = 2) );
         except
            writeInteger('DeviceInitialized', 0);
         end;

     finally
       fIsDeviceInitialized := result;
       Free;
     end;
 end;
end;

procedure TMercuryProcessor.SetDeviceIniParameter(arg_value: Integer);
begin
  fDeviceParamValue := arg_value;
end;

procedure TMercuryProcessor.SetDeviceInitialized(arg_started: Boolean);
begin
   fIsDeviceInitialized := arg_started;
end;

end.
