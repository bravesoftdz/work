unit ProcessorInterface;

interface
uses uCreditCardFunction;

type
	IProcessor = Interface
	
	    procedure SetTerminalID(arg_terminalID: String);
		function GetTerminalID(): String;

        procedure SetDeviceInitialized(arg_initialized: Boolean);
        function IsDeviceInitialized(): Boolean;

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

        // Pin Pad Parameters



        {       //PinPad
       fPinPad.Device                       := ReadString('PinPadDevice');
       fPinPad.Baud                         := ReadString('PinPadBaud');
       fPinPad.Parity                       := ReadString('PinPadParity');
       fPinPad.DataBits                     := ReadString('PinPadDataBits');
       fPinPad.Comm                         := ReadString('PinPadComm');
       fPinPad.EncryptMethod                := ReadString('PinEncryptMethod');
       fPinPad.TimeOut                      := ReadString('PinTimeOut');
}

	end;

implementation

end.
