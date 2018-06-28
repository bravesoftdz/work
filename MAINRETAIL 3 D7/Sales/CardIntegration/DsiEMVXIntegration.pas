unit DsiEMVXIntegration;

Interface

uses ProcessorInterface, DeviceIntegrationInterface, uCreditCardFunction, DSIEMVXLib_TLB, VER1000XLib_TLB,
     VER2000XLib_TLB, uXML, uMRPinPad, DeviceIntegration;

type

	TDsiEMVXIntegration = class(TDeviceIntegration, IDeviceIntegration)
	private
	    FTranMsgStatus: TCardTranMsgStatus;
        Fprocessor: IProcessor;
        FPinPad: TMRPinPad;
		FDevice: TDsiPDCX;

        FXMLResult             : WideString; // XML answer from Server
        FXMLServer             : WideString; // XML Server
        FXMLSent               : WideString; // XML Sent
        FXMLReceived           : WideString; // XML Received Aprooved/Declined
        FXMLContent            : TXMLContent;

		function CreatePadResetXML(): String;
		
		
		function ShouldResubmit(): Boolean;
        function initializeStatusXML(): String;

		function CreditProcessSaleXML(): String;
        function CreditResubmitProcessSaleXML(): String;
		function CreditProcessReturnXML(): String;
        function CreditVoidSaleXML(): String;
        function CreditVoidReturnXML(): String;
        function CreditResubmitReturnXML(): String;
        function CreditReturnByRecordNoXML(): String;
        function CreditSaleByRecordNoXML(): String;
        function CreditVoiceAuthXML(): String;
        function CreditVoidReturnByRecordNoXML(): String;

        function DebitProcessSaleXML(): String;
        function DebitProcessReturnXML(): String;
		function DebitResubmitProcessSaleXML(): String;
		function DebitResubmitReturnXML(): String;
        
        { gift is lacking } 		
        function GiftProcessSaleXML(): String;
        function GiftProcessReturnXML() :String;
        function GiftVoidSaleXML(): String;
        function GiftVoidReturnXML(): String;
        function GiftIssueXML(): String;
        function GiftVoidIssueXML(): String;
        function GiftReloadXML(): String;
        function GiftVoidReloadXML(): String;
        function GiftBalanceXML(): String;
        function GiftNoNSFSaleXML(): String;
        function GiftCashOutXML(): String;
    protected
        procedure SetPadType(arg_name: String); override;
        procedure SetIdPaymentType(arg_paymentType: Integer);		
        function VerifyTransaction(): Boolean; override;


	public
	    constructor Create();

        function ProcessCommand(arg_xml: WideString): Boolean;

        // Credit Transactions
		function CreditProcessSale(): Boolean;
		function CreditProcessReturn(): Boolean;
        function CreditVoidSale(): Boolean;
        function CreditVoidReturn(): Boolean;

        // Debit Transactions
		function  DebitProcessSale(): Boolean;
		function  DebitProcessReturn(): Boolean;

        // Prepaid transactions
        function GiftProcessSale(): Boolean;
        function GiftProcessReturn(): Boolean;
        function GiftVoidSale(): Boolean;
        function GiftVoidReturn(): Boolean;
        function GiftIssue: Boolean;
        function GiftVoidIssue: Boolean;
        function GiftReload: Boolean;
        function GiftVoidReload: Boolean;
        function GiftBalance: Boolean;
        function GiftNoNSFSale: Boolean;
        function GiftCashOut: Boolean;

        // Antonio September 11, 2013
        function tryIssueCard(arg_salePrice: double): TTransactionReturn;
        function tryBalanceCard(arg_salePrice: double): TTransactionReturn;

		procedure SetProcessor(arg_processor: IProcessor);
        procedure SetPinPad(arg_pinpad: TMRPinPad);

		function GetTransaction(): IProcessor;

        procedure BeforeProcessCard();
        procedure BeforeVoid();

	end;

implementation

{ TDsiEMVXIntegration }

procedure TDsiEMVXIntegration.BeforeProcessCard;
begin

end;

procedure TDsiEMVXIntegration.BeforeVoid;
begin

end;

constructor TDsiEMVXIntegration.Create;
begin
   FDevice := TDsiEMVX.Create(nil);
   FTranMsgStatus : TCardTranMsgStatus.Create();
   
end;

function TDsiEMVXIntegration.DebitProcessSaleXML(): String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + fDeviceName.Strings[2] + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TDsiEMVXIntegration.CreditProcessReturn: Boolean;
var
   status: String;
   text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(CreditProcessReturnXML());

     status := FXMLContent.GetAttributeString('CmdStatus');
     text :=   FXMLContent.GetAttributeString('TextResponse');

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(CreditResubmitReturnXML);
     end;


     if ( result ) then begin
        FAuthorize := FAuthorize * (-1);
     end;

  end;

end;

function TDsiEMVXIntegration.InitializeStatusXML(): String;
begin
  {} 
end;



function TDsiEMVXIntegration.EMVAdjustByRecordNoXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVAdjustByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.ComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				    //ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				    ctab + ctab + '</Amount>' + ccrlf +
				    //ctab + ctab + '<LaneID>' + LaneID + '</LaneID>' + ccrlf +
				    //ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                //ctab + ctab + '<PartialAuth>' + fPartialAuth + '</PartialAuth>' + ccrlf +
                ctab + ctab + '<RecordNo>' +  FProcessor.GetRefNo() + '</RecordNo>' + ccrlf +
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



function TDsiEMVXIntegration.CreditEMVZeroAuthXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVZeroAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
				    ctab + ctab + '</Amount>';// + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;



function TDsiEMVIntegration.CreditEMVVoiceAuthXML():String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoiceAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.ComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
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





function TDsiEMVXIntegration.CreditVoidReturnByRecordNoXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' + FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' +  FProcessor.GetIPAddress() + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturnByRecordNo</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.ComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
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

function TDsiEMVXIntegration.CreditVoiceAuthXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' +  FProcessor.GetIPAddress() + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoiceAuth</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.FComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
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


function TDsiEMVXIntegration.CreditSaleByRecordNoXML(): String;
var
  strRequest: string;
begin

  FProcessor.SetAcctNo('SecureDevice');
  strRequest := '';

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSaleByRecordNo</TranCode>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<RecordNo>' + FProcessor.GetRecordNo() + '</RecordNo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;



function TDsiEMVXIntegration.CreditReturnByRecordNoXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                //ctab + ctab + '<IpPort>' +  FProcessor.GetIPAddress() + '</IpPort>' + ccrlf;
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                //ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                //ctab + ctab + '<UserTrace>' + '' + '</UserTrace>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturnByRecordNo</TranCode>' +  ccrlf +
                //ctab + ctab + '<CollectData>' + quotedStr('CardholderName') + //'</CollectData>' + ccrlf;
//                ctab + ctab + '<SecureDevice>INGENICOISC250_MERCURY_E2E</SecureDevice>' +  ccrlf +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinPad.ComPort + '</ComPort>' +  ccrlf +
                //ctab + ctab + '<Account>' + ccrlf +
                //ctab + ctab + ctab + '<AccttNo>' + FAcctNo + '</AcctNo>' + ccrlf +
                //ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
					 ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
				    ctab + ctab + '<Amount>' + ccrlf +
				    ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
				    //ctab + ctab + ctab + '<Gratuity>' + Gratuity + '</Gratuity>' + ccrlf +
				    //ctab + ctab + ctab + '<CashBack>' + CashBack + '</CashBack>' + ccrlf +
				    ctab + ctab + '</Amount>' + ccrlf +
				    //ctab + ctab + '<LaneID>' + LaneID + '</LaneID>' + ccrlf +
				    //ctab + ctab + '<Duplicate>' + Duplicate + '</Duplicate>' + ccrlf +
				    //ctab + ctab + '<SequenceNo>' + fSequenceNo + '</SequenceNo>' + ccrlf +
                //ctab + ctab + '<PartialAuth>' + fPartialAuth + '</PartialAuth>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FProcessor.GetResultAcqRefData() + '</AcqRefData>'; // + ccrlf +
                //ctab + ctab + '<ProcessData>' + FProcessData + '</ProcessData>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;




function TDsiEMVXIntegration.CreditResubmitReturnXML(): String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  returnPurchase :=  FProcessor.GetPurchase() * (-1);

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(returnPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf+
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;





function TDsiEMVXIntegration.CreditVoidReturnXML(): String;
var
  strRequest: string;
begin
  FProcessor.SetAcctNo('SecureDevice');
  
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPOrt() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiEMVIntegration.CreditResubmitProcessSaleXML(): String
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIpPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf+
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiEMVXIntegration.ShouldResubmit(): Boolean;
begin
   result := ( ( FtranMsgStatus.GetCmdStatus() = 'Error')  and ( ( FTranMsgStatus.GetCmdStatus() = 'Cancelled.') or FTranMsgStatus.GetTextResponse() = 'Cancelled at POS.') ) )
end;

function TDsiEMVXIntegration.CreditProcessSaleXML(): String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf+
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
end;

function TDsiEMVXIntegration.CreditProcessReturnXML(): String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  strRequest := '';

  returnPurchase :=  FProcessor.GetPurchase() * (-1);

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(Abs(returnPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiEMVXIntegration.CreditVoidSaleXML(): String;
var
  strRequest: string;
begin

  FProcessor.SetAcctNo('SecureDevice');
  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVVoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.FComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' + FResultAcqRefData + '</AcqRefData>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;






function TDsiEMVXIntegration.CreditResubmitProcessSaleXM(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf+
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;
			



function TDsiEMVXIntegration.CreditProcessSale: Boolean;
var
   status: String;
   text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(CreditProcessSaleXML());

     status := FXMLContent.GetAttributeString('CmdStatus');
     text   := FXMLContent.GetAttributeString('TextResponse');

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(CreditResubmitProcessSaleXML());
     end;

  end;

end;

function TDsiEMVXIntegration.CreditVoidReturn: Boolean;
begin
  beforeTransaction();
  result := processCommand(CreditVoidReturnXML());

  if ( result ) then begin
        FAuthorize := FAuthorize * (-1);
  end;

  afterTransaction();

end;

function TDsiEMVXIntegration.CreditVoidSale: Boolean;
begin
   beforeTransaction();
   result := processCommand(DebitVoidSaleXML());
   afterTransaction();

end;

function TDsiEMVXIntegration.DebitProcessReturn: Boolean;
var
   status: String;
   text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(DebitProcessReturnXML());

     status := FXMLContent.GetAttributeString('CmdStatus');
     text :=   FXMLContent.GetAttributeString('TextResponse');

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(DebitResubmitReturnXML());
     end;

     if ( result ) then begin
        FAuthorize := FAuthorize * (-1);
     end;

  end;

end;

function TDsiEMVXIntegration.DebitResubmitReturnXML(): String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  strRequest := '';

  returnPurchase :=  FProcessor.GetPurchase() * (-1);

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(returnPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf+
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TDsiEMVXIntegration.DebitResubmitProcessSaleXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' +FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr( FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf+
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TDsiEMVXIntegration.DebitProcessReturnXML: String;
var
  strRequest: string;
  returnPurchase: Double;
begin
  strRequest := '';

  returnPurchase :=  FProcessor.GetPurchase() * (-1);

  strRequest := ctab + ctab + '<HostOrIP>' +  FProcessor.GetIPAddress() + '</HostOrIP>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' + FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<TranCode>EMVReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinPad.ComPort + '</ComPort>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
				ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(Abs(returnPurchase)) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
			    ctab + ctab + '<SequenceNo>' + FProcessor.GetSequenceNo() + '</SequenceNo>' + ccrlf +
				ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
				ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiEMVXIntegration.DebitProcessSale: Boolean;
var
   status: String;
   text: String;
begin
  if ( fDeviceInitialized ) then begin
     beforeTransaction();
     fAcctNoSecureDevice := 'SecureDevice';
     result := processCommand(DebitProcessSaleXML());

     status := FXMLContent.GetAttributeString('CmdStatus');
     text   := FXMLContent.GetAttributeString('TextResponse');

     // CmdStatus and TextResponse from Mercury
     if ( (status = 'Error') and (text = 'TRANSACTION CANCELLED - Operation Cancelled 08.') ) then begin
        result := processCommand(DebitResubmitProcessSaleXML());
     end;

  end;

end;


function TDsiEMVXIntegration.GetIdPaymentType: Integer;
begin

end;

function TDsiEMVXIntegration.GetTransaction: IProcessor;
begin
  result := FProcessor;
end;

function TDsiEMVXIntegration.GiftCashOutXML(): String;
var
  strRequest: string;
begin

  FProcessor.SetAcctNo('SecureDevice');

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>CashOut</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
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



function TDsiEMVXIntegration.GiftNoNSFSaleXML(): String;
var
  strRequest: string;
begin

  strRequest := '';
  
  FProcessor.SetAcctNo('SecureDevice');  

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' +FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>NoNSFSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Authorize>' + formatFloat('0.00', FAuthorize) + '</Authorize>' + ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Balance>' + formatFloat('0.00', FBalance) + '</Balance>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;



function TDsiEMVXIntegration.GiftBalanceXML(): String;
var
  strRequest: string;
begin

  strRequest := '';
   
  FProcessor.SetAcctNo('SecureDeevice'); 

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Balance</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;



function TDSiEMVXIntegration.GiftVoidReloadXML(): String;
var
  strRequest: string;
begin

  strRequest := '';
   
  FProcessor.SetAcctNo('SecureDevice'); 

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID()+ '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;






function TDsiEMVXIntegration.GiftReloadXML(): String;
var
  strRequest: string;
begin

  strRequest := '';
  
  FProcessor.SetAcctNo('SecureDevice');

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftIPPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;






function TDsiEMVXIntegration.GiftVoidIssueXML(): String;
var
  strRequest: string;
begin

  strRequest := '';
  
  FProcessor.SetAcctNo('SecureDevice');

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftIPPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FFProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidIssue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TDsiEMVXIntegration.GiftIssueXML(): String;
var
  strRequest: string;
begin

  // Construct XML for PrePaid
  strRequest := '';
  FProcessor.SetAcctNo('SecureDevice'); 
   
  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

{
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

  end;
  }

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;



function TDsiEMVXIntegration.GiftVoidReturnXML(): String
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;


function TDsiEMVXIntegration.GiftVoidSaleXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;



function TDsiEMVXIntegration.GiftProcessReturnXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' +  FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiEMVXIntegration.GiftProcessSaleXML(): String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TerminalID>' + FProcessor.GetTerminalID() + '</TerminalID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' +  FProcessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;




function TDsiEMVXIntegration.GiftBalance: Boolean;
begin
   result := ProcessCommand(GiftBalanceXML());

end;

function TDsiEMVXIntegration.GiftCashOut: Boolean;
begin
   result := ProcessCommand(GiftCashOutXML());

end;

function TDsiEMVXIntegration.GiftIssue: Boolean;
begin
   result := ProcessCommand(GiftIssueXML());
end;

function TDsiEMVXIntegration.GiftNoNSFSale: Boolean;
begin
   result := ProcessCommand(GiftNoNSFSaleXML());

end;

function TDsiEMVXIntegration.GiftProcessReturn: Boolean;
begin
   result := ProcessCommand(GiftProcessReturnXML());

end;

function TDsiEMVXIntegration.GiftProcessSale: Boolean;
begin
   result := ProcessCommand(GiftProcessSaleXML());
end;

function TDsiEMVXIntegration.GiftReload: Boolean;
begin
   result := ProcessCommand(GiftReloadXML());
end;

function TDsiEMVXIntegration.GiftVoidIssue: Boolean;
begin
   result := ProcessCommand(GiftVoidIssueXML());
end;

function TDsiEMVXIntegration.GiftVoidReload: Boolean;
begin
   result := ProcessCommand(GiftVoidReloadXML());
end;


function TDsiEMVXIntegration.GiftVoidReturn: Boolean;
begin
   result := ProcessCommand(GiftVoidReturnXML());

end;

function TDsiEMVXIntegration.GiftVoidSale: Boolean;
begin
   result := ProcessCommand(GiftVoidSaleXML());
end;

function TDsiEMVXIntegration.ProcessCommand(arg_xml: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  FXMLResult := FDevice.ProcessTransaction(arg_xml);
  FXMLReceived := FXMLResult;

  if VerifyTransaction then begin
      Result := True;
  end;

end;

procedure TDsiEMVXIntegration.SetIDPaymentType(arg_paymentType: Integer);
begin

end;

procedure TDsiEMVXIntegration.SetPadType(arg_name: String);
begin
  inherited;

  if ( Fprocessor.GetPadType = 'ISC250' ) then begin // Ingenico
        Fprocessor.SetSecureDevice('INGENICOISC250_MERCURY_E2E');

  end else if ( Fprocessor.GetPadType = 'VX805' ) then begin  // Verifone

           if ( Fprocessor.GetClassTypeName() = 'TMercuryProcessor' ) then begin
               Fprocessor.SetSecureDevice('EMV_VX805_MERCURY');
           end else if ( Fprocessor.GetClassTypeName() = 'TWorldPayProcessor' ) then begin
                      Fprocessor.SetSecureDevice('EMV_VX805_WORLDPAY');
               end;
      end;

end;

procedure TDsiEMVXIntegration.SetPinPad(arg_pinpad: TMRPinPad);
begin
  fpinpad := arg_pinpad;
end;

procedure TDsiEMVXIntegration.SetProcessor(arg_processor: IProcessor);
begin
  fProcessor := arg_processor;
end;

function TDsiEMVXIntegration.tryBalanceCard(
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

function TDsiEMVXIntegration.tryIssueCard(
  arg_salePrice: double): TTransactionReturn;
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

function TDsiEMVXIntegration.VerifyTransaction: Boolean;
begin
  inherited;
end;

end.
