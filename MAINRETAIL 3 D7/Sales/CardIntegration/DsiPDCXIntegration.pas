unit DsiPDCXIntegration;

Interface

uses SysUtils, ProcessorInterface, DeviceIntegrationInterface, uCreditCardFunction, DSIPDCXLib_TLB, VER1000XLib_TLB,
     VER2000XLib_TLB, uXML, uMRPinpad, classes, DeviceIntegration, MercuryProcessor, WorldPayProcessor,
	 CardTranMsgStatus;

type
	TDsiPDCXIntegration = class(TDeviceIntegration, IDeviceIntegration)
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
        function VerifyTransaction(): Boolean; override;

	public
	    constructor Create();
		destructor Destroy(); override;

        function InitializeStatus(): Boolean;
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
uses Math;

{ TDsiPDCXIntegration }

function TDsiPDCXIntegration.ShouldResubmit(): Boolean;
begin
   result := ( ( FtranMsgStatus.GetCmdStatus() = 'Error')  and ( ( FTranMsgStatus.GetCmdStatus() = 'Cancelled.') or FTranMsgStatus.GetTextResponse() = 'Cancelled at POS.') ) )
end;


procedure TDsiPDCXIntegration.BeforeProcessCard;
begin

end;

procedure TDsiPDCXIntegration.BeforeVoid;
begin

end;

constructor TDsiPDCXIntegration.Create;
begin
   FDevice := TDsiPDCX.Create(nil);
   
   FTranMsgStatus : TCardTranMsgStatus.Create();
   FProcessor.SetAcctNo('SecureDevice');

end;

destructor TDsiPDCXIntegration.Destroy();
begin
   FreeAndNil(FtranMsgStatus);
end;



function TDsiPDCXIntegration.CreditProcessReturn: Boolean;
begin
  if ( Fprocessor.IsDeviceInitialized ) then begin
     result := processCommand(CreditProcessReturnXML);

     // CmdStatus and TextResponse from Mercury
	 if ( ShouldResubmit ) then begin
        result := processCommand(resubmitReturnXML);
     end;

  end;
end;

function TDsiPDCXIntegration.CreditProcessReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetInvoiceNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FProcessor.GetPurchase())) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinpad.Comport+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TDsiPDCXIntegration.CreditProcessSale: Boolean;
begin
  if ( Fprocessor.IsDeviceInitialized ) then begin
     result := processCommand(CreateSaleXML);

     // CmdStatus and TextResponse from Mercury
	 if ( ShouldResubmit ) then begin
        result := processCommand(resubmitReturnXML);
     end;
  end;
end;

function TDsiPDCXIntegration.CreditProcessSaleXML: String;
var
  strRequest: string;
begin


  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + fProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + fProcessor.GetInvoice() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + fProcessor.GetRefNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', fprocessor.GetPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + fProcessor.GetSecureDevice() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + fProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + fProcessor.GetAppLabel + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TDsiPDCXIntegration.CreditResubmitProcessSaleXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + fProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + fProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + fProcessor.GetRefNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', fProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + fProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + fProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + fProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TDsiPDCXIntegration.CreditResubmitReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetInvoiceNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(FProcessor.GetPurchase())) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.CreditReturnByRecordNoXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>ReturnByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>' + fRecordNumberRequested + '</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.CreditSaleByRecordNoXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>SaleByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>' + fRecordNumberRequested + '</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.CreditVoiceAuthXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoiceAuth</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>' +fRecordNumberRequested +'</RecordNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GeAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.CreditVoidReturn: Boolean;
begin
  if ( fDeviceInitialized ) then begin
      BeforeVoid;
      result := processCommand(VoidReturnXML);
  end;
end;

function TDsiPDCXIntegration.CreditVoidReturnByRecordNoXML: String;
var
  strRequest: string;
begin

  secureDevice := 'SecureDevice';

  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturnByRecordNo</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GeAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinpad.Comport+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + SecureDevice + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.CreditVoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' +  FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinpad.Comport + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GeAcctNo() + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GeAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' +  FProcessor.GetResultAcqRefData() + '</AcqRefData>' + ccrlf +
//                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TDsiPDCXIntegration.CreditVoidSale: Boolean;
begin
  if ( fDeviceInitialized ) then begin
      BeforeVoid;
      result := processCommand(VoidSaleXML);
  end;
end;

function TDsiPDCXIntegration.CreditVoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest +
                ctab + ctab + '<IpPort>' +  FProcessor.GetIPPort() + '</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>' + FPinpad.Comport + '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' + ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GeAcctNo() + '</AcctNo>' + ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' + ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<AuthCode>' +  FProcessor.GeAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
				ctab + ctab + ctab + '<Purchase>' + floatToStr(FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<AcqRefData>' +  FProcessor.GetResultAcqRefData() + '</AcqRefData>' + ccrlf +
///                ctab + ctab + '<SequenceNo>' + SequenceNo + '</SequenceNo>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' +  FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;

function TDsiPDCXIntegration.DebitProcessReturn: Boolean;
begin
  if ( Fprocessor.IsDeviceInitialized() ) then begin
     result := processCommand(DebitProcessReturnXML);
  end;
end;

function TDsiPDCXIntegration.DebitProcessReturnXML: String;
var
  strRequest: string;
begin
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Amount>' + ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Abs(Fprocessor.GetPurchase())) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetSecureDevice() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf + 
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.DebitProcessSale: Boolean;
begin
  
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(DebitProcessSaleXML);
  end;
  
end;

function TDsiPDCXIntegration.DebitProcessSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<CashBack>0.00</CashBack>' + ccrlf + 
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ FPinpad.Comport+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf + 
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID()() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.GetTransaction: IProcessor;
begin
  result := FProcessor;
end;

function TDsiPDCXIntegration.GiftBalanceXML(): String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() ) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Balance</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAccNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end  





function TDsiPDCXIntegration.GiftBalance: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftBalanceXML());
  end;

end;

function TDsiPDCXIntegration.GiftCashOutXML(): Boolean;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + (FProcessor.GetGiftPort()) +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>CashOut</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf;
  end else begin
               strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
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
                        ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetManualCardNumber() +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FProcessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.GiftCashOut: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftCashOutXML());
  end;

end;

function TDsiPDCXIntegration.GiftIssueXML(): String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo()+ '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TDsiPDCXIntegration.GiftIssue: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftIssueXML());
  end;
end;

function TDsiPDCXIntegration.GiftNoNSFSaleXML(): String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>NoNSFSale</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf;
  end else begin
               strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
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
                        ctab + ctab + ctab + '<AcctNo>' + FProcesor.GetManualCardNumber() +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FProcessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;








function TDsiPDCXIntegration.GiftNoNSFSale: Boolean;
begin

  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftNoNSFSaleXML());
  end;

end;

function TDsiPDCXIntegration.GiftProcessReturn: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftProcessReturnXML());
  end;

end;

function TDsiPDCXIntegration.GiftProcessSale: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftProcessSaleXML());
  end;
end;

function TDsiPDCXIntegration.GiftVoidSaleXML(): String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GiftIpPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchandID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf;
  end else begin
                strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
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
                        ctab + ctab + ctab + '<AcctNo>' +  FProcessor.GetManualCard() +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FProcessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
   
end;

function TDsiPDCXIntegration.GiftProcessReturnXML(): String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;





function TDsiPDCXIntegration.GiftProcessSaleXML(): String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.GiftReloadXML(): Boolean;
var
  strRequest: string;
  secureDevice : String;
begin
  secureDevice := fAcctNoSecureDevice;

  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Reload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';


end;




function TDsiPDCXIntegration.GiftReload: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftReloadXML());
  end;

end;

function TDsiPDCXIntegration.GiftVoidIssueXML(): String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidIssue</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
//                ctab + ctab + '<SecureDevice>VX805XPI_MERCURY_E2E</SecureDevice>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf;
  end else begin
                strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLAbel() + '</Memo>' + ccrlf +
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
                        ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetManualCardNumber() +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FProcessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;


function TDsiPDCXIntegration.GiftVoidIssue: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftVoidIssueXML());
  end;

end;

function TDsiPDCXIntegration.GiftVoidReloadXML(): String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf;
  end else begin
               strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
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
                        ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetManualCardNumber() +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FProcessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';
      
end;




function TDsiPDCXIntegration.GiftVoidReload: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftVoidReloadXML());
  end;

end;

function TDsiPDCXIntegration.GiftVoidReturnXML(): String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf;

  if ( trim(track2)<> '' ) then begin
     strRequest := strRequest +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf;
  end else begin
             strRequest := strRequest + ctab + ctab + '<SecureDevice>NONE</SecureDevice>' +  ccrlf +
                ctab + ctab + '<ComPort>0</ComPort>' +  ccrlf ;
      end;

  strRequest := strRequest +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Memo>' + FProcessor.GetAppLabel() + '</Memo>' + ccrlf +
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
                        ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetManualCardNumber() +'</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + FProcessor.GetExpDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;

  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', FProcessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;








function TDsiPDCXIntegration.GiftVoidReturn: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftVoidReturnXML());
  end;

end;

function TDsiPDCXIntegration.GiftVoidSale: Boolean;
begin
  if ( FProcessor.IsDeviceInitialized() ) then begin
     result := processCommand(GiftVoidSaleXML());
  end;

end;

function TDsiPDCXIntegration.InitializeStatus: Boolean;
var
  FUserTraceData: String;
begin
   FXMLSent     := initializeStatusXML;

   FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
   FXMLReceived := FXMLResult;

   FXMLContent.XML := FXMLResult;
   Fprocessor.:= ( FXMLContent.GetAttributeString('CmdStatus')  = 'Success' );

   result := fDeviceInitialized

end;

function TDsiPDCXIntegration.initializeStatusXML: String;
var
  strRequest: string;
begin
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<MerchantID>' + Fprocessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<LaneID>02</LaneID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' +  ccrlf +
                ctab + ctab + '<Frequency>OneTime</Frequency>' + ccrlf +
                ctab + ctab + '<RecordNo>RecordNumberRequested</RecordNo>' + ccrlf +
                ctab + ctab + '<PartialAuth>Allow</PartialAuth>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + Fprocessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>Prompt</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf;

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


function TDsiPDCXIntegration.PrePaidIssueXML: String;
var
  strRequest: string;
begin

  FProcessor.SetAcctNo('SecureDevice');   
  
  // Construct XML for CC sale
  strRequest := '';

  strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetGiftPort() +'</IpPort>' + ccrlf +
                ctab + ctab + '<MerchantID>' + FProcessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  FProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' +  FProcessor.GetRefNo() + '</RefNo>' + ccrlf +
                ctab + ctab + '<Purchase>' + formatfloat('0.00',  FProcessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '<SecureDevice>' + FProcessor.GetSecureDevice() + '</SecureDevice>' + ccrlf +
                ctab + ctab + '<ComPort>'+ fpinpad.ComPort+ '</ComPort>' +  ccrlf +
                ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                ctab + ctab + '</Account>' + ccrlf +
                ctab + ctab + '<OperatorID>' +  FProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<Memo>' + FMemo + '</Memo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiPDCXIntegration.prePaidNoNSFSale: Boolean;
begin

end;


function TDsiPDCXIntegration.ProcessCommand(arg_xml: WideString): Boolean;
var
  FUserTraceData : String;
begin

  Result := False;

  //To set the connection timeout for PingServer and timeout to failover to the next server address in the list generated by ServerIPConfig while processing transactions with ProcessTransaction.
  //The default connection timeout value is 10 seconds if SetConnectTimeout is never called.
  //Param:
  //1 - Timeout – The timeout value in seconds (5 – 60).
  if ( Fprocessor.GetConnectionTimeOut() <> -1 ) then begin
    FDevice.SetConnectTimeout(Fprocessor.GetConnectionTimeOut);
  end;

  //To set the response timeout while processing transactions with ProcessTransaction.
  //Param:
  //1 - Timeout – The timeout value in seconds (60 – 3900).
  //The default connection timeout value is 300 seconds if SetResponseTimeout is never called. The default value should be used unless unusual response performance is experienced or as advised for a particular processing connection.
  if ( Fprocessor.GetResponseTimeOut() <> -1 ) then begin
    FDevice.SetResponseTimeout(Fprocessor.GetResponseTimeOut());
  end;

  //This method should be the first one called after the DSIClientX control is loaded
  //Params:
  //1 - HostList – up to 10 host names or IP addresses separated by semicolon (;). The host names entries in the list will be looked up via DNS.
  //2 - ProcessControl – This determines how the control will process the request. Allowed values are:
  //   0 Process using visible dialog boxes
  //   1 Process without using visible dialog boxes

  FXMLResult := FDevice.ServerIPConfig(Fprocessor.GetIPProcessorAddres(), 0);

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


procedure TDsiPDCXIntegration.SetPadType(arg_name: String);
begin
  inherited;

  if ( Fprocessor.GetPadType = 'ISC250' ) then begin // Ingenico
        Fprocessor.SetSecureDevice('INGENICOISC250_MERCURY_E2E');

  end else if ( Fprocessor.GetPadType = 'VX805' ) then begin  // Verifone

           if ( Fprocessor.GetclassTypeName = 'TMercuryProcessor' )  then begin
               Fprocessor.SetSecureDevice('VX805XPI_MERCURY_E2E');
           end else if ( Fprocessor.GetclassTypeName = 'TWorldPayProcessor' ) then begin
                      Fprocessor.SetSecureDevice('VX805XPI_CTLS');
               end;
      end;

end;

procedure TDsiPDCXIntegration.SetPinPad(arg_pinpad: TMRPinPad);
begin
  FPinPad := arg_pinpad;
end;

procedure TDsiPDCXIntegration.SetProcessor(arg_processor: IProcessor);
begin
  Fprocessor := arg_processor;
end;

function TDsiPDCXIntegration.tryBalanceCard(
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

function TDsiPDCXIntegration.tryIssueCard(
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

function TDsiPDCXIntegration.VerifyTransaction: Boolean;
begin
  inherited;
end;


end.
