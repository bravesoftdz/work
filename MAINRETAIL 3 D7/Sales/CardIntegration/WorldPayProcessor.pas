unit WorldPayProcessor;

interface
uses SysUtils, Classes, contnrs, ProcessorInterface, uCreditCardFunction;

type
	TWorldPayProcessor = class(TInterfacedObject, IProcessor)
	private
	    FTerminalID: String; 
        fDeviceParamValue: Integer;
        fIsDeviceInitialized: Boolean;
        fClassTypeName: String;
        fPadType: String;
        fSecureDevice: String;
        FIdPaymentType: Integer;
        FManualCvv: String;
        FmanualCvv2: String;
        FmanualZipCode: String;
        FmanualStreet: String;
        FManualMember: String;
        FExpiresDate: String;
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
uses StrUtils, Controls;

{ TWorldPayProcessor }

constructor TWorldPayProcessor.create;
begin
  fClassTypeName := 'TWorldPayProcessor';
end;

function TWorldPayProcessor.GetAcctNo: String;
begin
   result := FAcctNo;
end;

function TWorldPayProcessor.GetAppLabel: String;
begin
   result := FAppLabel;
end;

function TWorldPayProcessor.GetAuthCode: String;
begin
   result := FAuthCode;
end;

function TWorldPayProcessor.GetAuthorize: Currency;
begin
   result := FAuthorize;
end;

function TWorldPayProcessor.GetBalance: Currency;
begin

end;

function TWorldPayProcessor.GetCardType: String;
begin
   result := FCardType;
end;

function TWorldPayProcessor.GetClassTypeName: String;
begin
  result := fClassTypeName;
end;

function TWorldPayProcessor.GetConnectionTimeOut: Integer;
begin
   result := FConnectionTimeOut;
end;

function TWorldPayProcessor.GetCustomerCode: String;
begin

end;

function TWorldPayProcessor.GetDateTransaction: String;
begin
  result := FDateTransaction;
end;

function TWorldPayProcessor.GetDialUpBridge: Boolean;
begin
//
end;

function TWorldPayProcessor.GetEntryMethod: String;
begin
  result := FEntryMethod;
end;

function TWorldPayProcessor.GetExpireDate: String;
begin

end;

function TWorldPayProcessor.GetGiftIP: String;
begin

end;

function TWorldPayProcessor.GetGiftMerchantID: String;
begin
  result := FgiftMerchantID
end;

function TWorldPayProcessor.GetGiftPort: String;
begin

end;

function TWorldPayProcessor.GetIdPaymentType: Integer;
begin
  result := FIdPaymentType;
end;

function TWorldPayProcessor.GetInvoiceNo: String;
begin
   result := FinvoiceNo;
end;

function TWorldPayProcessor.GetIPPort: String;
begin
  result := FIPPort;
end;

function TWorldPayProcessor.GetIPProcessorAddres: String;
begin
  result := FIPProcessorAddress;
end;

function TWorldPayProcessor.GetLabelAID: String;
begin
  result := FLabelAID;
end;

function TWorldPayProcessor.GetLabelARC: String;
begin
  result := FLabelARC;
end;

function TWorldPayProcessor.GetLabelCVM: String;
begin
  result := FLabelCVM;
end;

function TWorldPayProcessor.GetLabelIAD: String;
begin
  result := FLabelIAD;
end;

function TWorldPayProcessor.GetLabelTSI: String;
begin
  result := FLabelTSI;
end;

function TWorldPayProcessor.GetLabelTVR: String;
begin
  result := FLabelTVR;
end;

function TWorldPayProcessor.GetLastDigits: String;
begin
  result := FlastDigits;
end;

function TWorldPayProcessor.GetManualCardNumber: String;
begin
   result := FAcctNo;
end;

function TWorldPayProcessor.GetManualCvv: String;
begin
   result := FManualCvv;
end;

function TWorldPayProcessor.GetManualCvv2: String;
begin
  result := FmanualCvv2;
end;

function TWorldPayProcessor.GetManualMemberName: String;
begin
   result := FManualMember;
end;

function TWorldPayProcessor.GetManualStreeAddress: String;
begin
   result := FmanualStreet;
end;

function TWorldPayProcessor.GetManualZipCode: String;
begin

end;

function TWorldPayProcessor.GetMerchandID: String;
begin

end;

function TWorldPayProcessor.GetMerchantID: String;
begin
 result := FMerchantID;
end;

function TWorldPayProcessor.GetMessage: String;
begin
  result := FMessage;
end;

function TWorldPayProcessor.GetOperatorID: String;
begin
  result := FoperatorId;
end;

function TWorldPayProcessor.GetPadType: String;
begin
  result := fPadType;
end;

function TWorldPayProcessor.GetPurchase: Currency;
begin
  result := FPurchase;
end;

function TWorldPayProcessor.GetransactionErrorCode: String;
begin
  result := FTrancode;
end;

function TWorldPayProcessor.GetRecordNo: String;
begin
  result := FRecordNo;
end;

function TWorldPayProcessor.GetRefNo: String;
begin
  result := FRefNo;
end;

function TWorldPayProcessor.GetResponseTimeOut: Integer;
begin
   result := FResponseTimeOut;
end;

function TWorldPayProcessor.GetResultAcqRefData: String;
begin
   result := FResultAcqRefData;
end;

function TWorldPayProcessor.GetSecureDevice: String;
begin

end;

function TWorldPayProcessor.GetSequenceNo: String;
begin
   result := FSequenceNo;
end;

function TWorldPayProcessor.GetTax: Double;
begin
  result := FTax;
end;

function TWorldPayProcessor.GetTimeTransaction: String;
begin
   result := FTimeTransaction;
end;

function TWorldPayProcessor.GetTrancode: String;
begin
   result := FTrancode;
end;

function TWorldPayProcessor.GetTransactionResult: TTransactionReturn;
begin

end;

function TWorldPayProcessor.GetTrueCardTypeName: String;
begin
  result := FTrueCardTypeName;
end;

function TWorldPayProcessor.IsDeviceInitialized: Boolean;
begin

end;

procedure TWorldPayProcessor.SetAcctNo(arg_acctNo: String);
begin
   FAcctNo := arg_acctNo;
end;

procedure TWorldPayProcessor.SetAppLabel(arg_appLabel: String);
begin
   FAppLabel := arg_appLabel;
end;

procedure TWorldPayProcessor.SetAuthCode(arg_authCode: String);
begin
   FAuthCode := arg_authCode;
end;

procedure TWorldPayProcessor.SetAuthorize(arg_authorize: Currency);
begin
   FAuthorize := arg_authorize;
end;

procedure TWorldPayProcessor.SetBalance(arg_balance: Currency);
begin

end;

procedure TWorldPayProcessor.SetCardType(arg_type: String);
begin
   FCardType := arg_type;
end;

procedure TWorldPayProcessor.SetConnectionTimeOut(arg_timeOut: Integer);
begin
   FConnectionTimeOut := arg_timeOut;
end;

procedure TWorldPayProcessor.SetCustomerCode(arg_customerCode: String);
begin

end;

procedure TWorldPayProcessor.SetDateTransaction(arg_date: String);
begin
   FDateTransaction := arg_date;
end;

procedure TWorldPayProcessor.SetDeviceIniParameter(arg_value: Integer);
begin

end;

procedure TWorldPayProcessor.SetDeviceInitialized(arg_started: Boolean);
begin
  fIsDeviceInitialized := arg_started;
end;

procedure TWorldPayProcessor.SetDialUpBridge(arg_dialBridge: Boolean);
begin
//
end;

procedure TWorldPayProcessor.SetEntryMethod(arg_entryMethod: String);
begin
   FEntryMethod := arg_entryMethod;
end;

procedure TWorldPayProcessor.SetExpireDate(arg_date: String);
begin

end;

procedure TWorldPayProcessor.SetGiftIP(arg_giftIP: String);
begin

end;

procedure TWorldPayProcessor.SetGiftMerchantID(arg_merchantid: String);
begin
  FgiftMerchantID := arg_merchantid;
end;

procedure TWorldPayProcessor.SetGiftPort(arg_giftPort: String);
begin

end;

procedure TWorldPayProcessor.SetIdPaymentType(arg_paymentType: Integer);
begin

end;

procedure TWorldPayProcessor.SetInvoiceNo(arg_invoiceNo: String);
begin
   FinvoiceNo := arg_invoiceNo;
end;

procedure TWorldPayProcessor.SetIPPort(arg_port: String);
begin
   FIPPort := arg_port;
end;

procedure TWorldPayProcessor.SetIPProcessorAddress(arg_address: String);
begin
   FIPProcessorAddress := arg_address;
end;

procedure TWorldPayProcessor.SetLabelAID(arg_label: String);
begin
   FLabelAID := arg_label;
end;

procedure TWorldPayProcessor.SetLabelARC(arg_label: String);
begin
   FLabelARC := arg_label;
end;

procedure TWorldPayProcessor.SetLabelCVM(arg_label: String);
begin
   FLabelCVM := arg_label;
end;

procedure TWorldPayProcessor.SetLabelIAD(arg_label: String);
begin

end;

procedure TWorldPayProcessor.SetLabelTSI(arg_label: String);
begin
   FLabelTSI := arg_label;
end;

procedure TWorldPayProcessor.SetLabelTVR(arg_label: String);
begin
   FLabelTVR := arg_label;
end;

procedure TWorldPayProcessor.SetLastDigits(arg_lastDigits: String);
begin
   FLastDigits := arg_lastDigits;
end;

procedure TWorldPayProcessor.SetManualCardNumber(arg_cardNumber: String);
begin

end;

procedure TWorldPayProcessor.SetManualCvv(arg_cvv: String);
begin

end;

procedure TWorldPayProcessor.SetManualCVV2(arg_cvv2: String);
begin

end;

procedure TWorldPayProcessor.SetManualMemberName(arg_member: String);
begin

end;

procedure TWorldPayProcessor.SetManualStreeAddress(arg_address: String);
begin

end;

procedure TWorldPayProcessor.SetManualZipCode(arg_zipCode: String);
begin

end;

procedure TWorldPayProcessor.SetMerchantID(arg_merchantID: String);
begin
  FMerchantID := arg_merchantID;
end;

procedure TWorldPayProcessor.SetMessage(arg_msg: String);
begin
  FMessage := arg_msg;
end;

procedure TWorldPayProcessor.SetOperatorID(arg_operatorID: String);
begin

end;

procedure TWorldPayProcessor.SetPadType(arg_name: String);
begin
  fPadType := arg_name;
end;

procedure TWorldPayProcessor.SetPurchase(arg_purchase: Currency);
begin
   FPurchase := arg_purchase;
end;

procedure TWorldPayProcessor.SetRecordNo(arg_recordNo: String);
begin
   FRecordNo := arg_recordNo;
end;

procedure TWorldPayProcessor.SetRefNo(arg_refNo: String);
begin
   FRefNo := arg_refNo;
end;

procedure TWorldPayProcessor.SetResponseTimeOut(
  arg_responseTimeOut: Integer);
begin
   FResponseTimeOut := arg_responseTimeOut;
end;

procedure TWorldPayProcessor.SetResultAcqRefData(arg_acqRefData: String);
begin
  FResultAcqRefData := arg_acqRefData;
end;

procedure TWorldPayProcessor.SetSecureDevice(arg_sdcode: String);
begin

end;

procedure TWorldPayProcessor.SetSequenceNo(arg_sequence: String);
begin
   FSequenceNo := arg_sequence;
end;

procedure TWorldPayProcessor.SetTax(arg_tax: double);
begin

end;

procedure TWorldPayProcessor.SetTimeTransaction(arg_time: String);
begin
   FTimeTransaction := arg_time;
end;

procedure TWorldPayProcessor.SetTrancode(arg_trancode: String);
begin
   FTrancode := arg_trancode;
end;

procedure TWorldPayProcessor.SetTransactionErrorCode(
  arg_transerror: String);
begin
   FTrancode := arg_transerror;
end;

procedure TWorldPayProcessor.SetTransactionResult(
  arg_result: TTransactionReturn);
begin

end;

procedure TWorldPayProcessor.SetTrueCardTypeName(arg_name: String);
begin
   FTrueCardTypeName := arg_name;
end;

end.

