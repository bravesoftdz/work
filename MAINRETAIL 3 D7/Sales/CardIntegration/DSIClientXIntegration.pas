unit DSIClientXIntegration;

Interface

uses SysUtils, Dialogs, ProcessorInterface, DeviceIntegrationInterface, uCreditCardFunction, DSICLIENTXLib_TLB, VER1000XLib_TLB,
VER2000XLib_TLB, uXML, uMRPinPad, DeviceIntegration;

const
  ctab  = Chr(9);
  ccrlf = Chr(13) + Chr(10);

type
	TDsiClientXIntegration = class(TDeviceIntegration, IDeviceIntegration) 
	private
        FCashBack: Currency;
        FexpDate: String;
        Ftrack2: String;
        FcardSwiped : WideString;
        Fprocessor: IProcessor;
		FDevice: TDsiClientX;
        FPinPad: TMRPinPad;

        FXMLResult             : WideString; // XML answer from Server
        FXMLServer             : WideString; // XML Server
        FXMLSent               : WideString; // XML Sent
        FXMLReceived           : WideString; // XML Received Aprooved/Declined
        FXMLContent            : TXMLContent;

        FAfterSucessfullSwipe  : TAfterSucessfullSwipe;
        FOnNeedSwipe           : TNeedSwipeEvent;
        FOnNeedTroutD          : TNeedTroutDEvent;

        function ManualEntryCard(): Boolean;
        function getSecureSerialNumber(arg_serialNumber: String): String;

		function CreditProcessSaleXML(): String;
		function CreditProcessReturnXML(): String;
        function CreditVoidSaleXML(): String;
        function CreditVoidReturnXML(): String;

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

        function IsCustomerCardPresent(): Boolean;

        procedure NeedSwipe(Sender: TObject; var SwipedTrack: WideString; var Canceled: Boolean);

        procedure BeforeProcessCard();
	protected
        function VerifyTransaction(): Boolean; override;

	public
	    constructor Create();

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
        procedure SetPinPad(arg_pinpad: TMRPinpad);

		function GetTransaction(): IProcessor;

		procedure SetSwiped(arg_cardSwiped: WideString);

        procedure BeforeVoid();

        procedure SetIDPaymentType(arg_paymentType: Integer);
        function GetIdPaymentType(): Integer;

	end;

implementation
uses uMsgBox, Math, ufrmPCCharge, uFrmPCCSwipeCard, ufrmPCVoid;

{ TDsiClientXIntegration }

procedure TDsiClientXIntegration.BeforeProcessCard;
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
        Fprocessor.SetAcctNo(sCard);
        Fprocessor.SetExpireDate(sDate);
      except
        ASwipeError := True;
        raise Exception.Create('Card track not recognized');
      end;

      if ASwipeCanceled then
        raise Exception.Create('Card Swipe canceled by user');

    until not (ASwipeCanceled or ASwipeError)
  end;

end;

procedure TDsiClientXIntegration.BeforeVoid;
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

    Fprocessor.SetInvoiceNo(AInvNo);
    Fprocessor.SetRefNo(ATrouD);
    Fprocessor.SetAuthCode(AAuthCode);
    {
    FInvoiceNo := AInvNo;
    FRefNo     := ATrouD;
    FAuthCode  := AAuthCode;
    }
  end;
end;

constructor TDsiClientXIntegration.Create;
begin
  FDevice := TDSICLientX.Create(nil);

  if ( IsCustomerCardPresent ) then begin
     FOnNeedSwipe := NeedSwipe
  end else begin

          FOnNeedSwipe := nil;
      end;


end;

function TDsiClientXIntegration.CreditProcessReturn: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreditProcessReturnXML);
end;

function TDsiClientXIntegration.CreditProcessReturnXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not ( fProcessor.GetDialUpBridge ) then
    strRequest := ctab + ctab + '<IpPort>' + fProcessor.GetIpPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + fProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + fProcessor.getAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + fProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + fProcessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + fProcessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.CreditProcessSale: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreditProcessSaleXML);
end;

function TDsiClientXIntegration.CreditProcessSaleXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  if not(FProcessor.GetDialUpBridge) then
    strRequest := ctab + ctab + '<IpPort>' + FProcessor.GetIPPort + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.getMerchantID + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' +FProcessor.GetAppLabel + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + FProcessor.GetOperatorID + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + FProcessor.GetInvoiceNo + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + FProcessor.GetRefNo + '</RefNo>' + ccrlf;


  if ( FTrack2 <> '' ) then
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
                  ctab + ctab + ctab + '<AcctNo>' + FProcessor.GetAcctNo + '</AcctNo>' +  ccrlf +
                  ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate + '</ExpDate>' +  ccrlf +
                  ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', FProcessor.GetPurchase) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', Fprocessor.GetTax) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if ( FTrack2 = '' ) then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((Fprocessor.GetManualZipCode <> '') or ( Fprocessor.GetManualStreeAddress <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if ( Fprocessor.GetManualStreeAddress() <> '' ) then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + fprocessor.GetManualStreeAddress() + '</Address>' + ccrlf;

        if ( Fprocessor.GetManualZipCode <> '' ) then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + fprocessor.GetManualZipCode() + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if ( fprocessor.GetManualCvv()  <> '' ) then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + Fprocessor.GetManualCvv() + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + fprocessor.GetCustomerCode() + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.CreditVoidReturn: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(CreditVoidReturnXML);
end;

function TDsiClientXIntegration.CreditVoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  if not(Fprocessor.GetDialUpBridge()) then
    strRequest := ctab + ctab + '<IpPort>' + Fprocessor.GetIPPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.CreditVoidSale: Boolean;
begin
  BeforeVoid();
  BeforeProcessCard();
  result := processCommand(CreditVoidSaleXML);
end;

function TDsiClientXIntegration.CreditVoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  if not(FProcessor.GetDialUpBridge()) then
    strRequest := ctab + ctab + '<IpPort>' + Fprocessor.GetIPPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + FProcessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + fProcessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + fProcessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Credit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                        ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                        ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                        ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + Fprocessor.GetCustomerCode() + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.DebitProcessReturn: Boolean;
begin
  result := ProcessCommand(DebitProcessReturnXML);
end;

function TDsiClientXIntegration.DebitProcessReturnXML: String;
var
  strRequest: string;
  PINBLOCK, DervdKey: String;
begin

  strRequest := '';

  if not( Fprocessor.GetDialUpBridge() ) then
    strRequest := ctab + ctab + '<IpPort>' + Fprocessor.GetIPPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.getMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.getAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorId() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' +  fprocessor.getInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

  //Debit Card
  strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                ctab + ctab + '</Account>' +  ccrlf;

  //Amount
  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', fprocessor.getPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  //PinpadInfo
  FPinPad.GetPin(Fprocessor.GetAcctNo(), Fprocessor.GetPurchase(), PINBLOCK, DervdKey);
  strRequest := strRequest + ctab + ctab + '<PIN>' +  ccrlf +
                ctab + ctab + ctab + '<PINBlock>' + PINBlock + '</PINBlock>' +  ccrlf +
                ctab + ctab + ctab + '<DervdKey>' + DervdKey + '</DervdKey>' +  ccrlf +
                ctab + ctab + '</PIN>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.DebitProcessSale: Boolean;
begin
  Result := False;
  result := processCommand(DebitProcessSaleXML);
end;

function TDsiClientXIntegration.DebitProcessSaleXML: String;
var
  strRequest: string;
  PINBlock, DervdKey: String;
begin

  strRequest := '';

  if not( Fprocessor.GetDialUpBridge() ) then
    strRequest := ctab + ctab + '<IpPort>' + Fprocessor.GetIPPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>Debit</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

  //Debit Card
  strRequest := strRequest + ctab + ctab + '<Account>' +  ccrlf +
                ctab + ctab + ctab + '<Track2>' + FTrack2 + '</Track2>' +  ccrlf +
                ctab + ctab + '</Account>' +  ccrlf;

  //Amount
  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', fprocessor.GetPurchase()) + '</Purchase>' + ccrlf;
  if FCashBack <> 0 then
    strRequest := strRequest + ctab + ctab + '<CashBack>' + formatfloat('0.00', FCashBack) + '</Purchase>' + ccrlf;
  strRequest := strRequest + ctab + ctab + '</Amount>' +  ccrlf;

  //PinpadInfo
  FPinPad.GetPin(Fprocessor.GetAcctNo(), Fprocessor.GetPurchase(), PINBLOCK, DervdKey);
  strRequest := strRequest + ctab + ctab + '<PIN>' +  ccrlf +
                ctab + ctab + ctab + '<PINBlock>' + PINBlock + '</PINBlock>' +  ccrlf +
                ctab + ctab + ctab + '<DervdKey>' + DervdKey + '</DervdKey>' +  ccrlf +
                ctab + ctab + '</PIN>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GetIdPaymentType: Integer;
begin

end;

function TDsiClientXIntegration.getSecureSerialNumber(
  arg_serialNumber: String): String;
var
  serialSubPart: String;
begin
  serialSubPart := copy(arg_serialNumber, ( length(arg_serialNumber) - 6), 6);
  result := stringReplace(arg_serialNumber, serialSubPart, 'XXXXXX', [rfReplaceAll, rfIgnoreCase]);

end;

function TDsiClientXIntegration.GetTransaction: IProcessor;
begin
   result := FProcessor;

end;

function TDsiClientXIntegration.GiftBalance: Boolean;
begin
   BeforeProcessCard();
   result := ProcessCommand(GiftBalanceXML);
end;

function TDsiClientXIntegration.GiftBalanceXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Balance</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftCashOut: Boolean;
begin
   BeforeProcessCard();
   result := ProcessCommand(GiftCashOutXML);
end;

function TDsiClientXIntegration.GiftCashOutXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + fprocessor.GetGiftMerchantID()+ '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>CashOut</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
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

function TDsiClientXIntegration.GiftIssue: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(GiftIssueXML);
end;

function TDsiClientXIntegration.GiftIssueXML: String;
var
  strRequest: string;
begin

  // Construct XML for PrePaid
  strRequest := '';
  //fccconfig.FIpAddress := fccconfig.FMercuryGiftAddress;
  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Issue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', fprocessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((fprocessor.GetManualZipCode() <> '') or ( fprocessor.GetManualStreeAddress() <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if ( fprocessor.GetManualStreeAddress() <> '' ) then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + fprocessor.GetManualStreeAddress() + '</Address>' + ccrlf;

        if (Fprocessor.GetManualZipCode() <> '' ) then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + Fprocessor.GetManualZipCode() + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

  end;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftNoNSFSale: Boolean;
begin
   BeforeProcessCard();
   result := ProcessCommand(GiftNoNSFSaleXML);
end;

function TDsiClientXIntegration.GiftNoNSFSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>NoNSFSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Authorize>' + formatFloat('0.00', Fprocessor.GetAuthorize()) + '</Authorize>' + ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Balance>' + formatFloat('0.00', fprocessor.getBalance()) + '</Balance>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftProcessReturn: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(GiftProcessReturnXML);
end;

function TDsiClientXIntegration.GiftProcessReturnXML: String;
var
  strRequest: string;
begin

  // Construct XML for CC sale
  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' +  Fprocessor.GetMerchantID()+ '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Return</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;


  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftProcessSale: Boolean;
begin
  BeforeProcessCard();
  result := processCommand(GiftProcessSaleXML);

end;

function TDsiClientXIntegration.GiftProcessSaleXML: String;
var
   strRequest: String;
begin
  // Construct XML for PrePaid Sale
  strRequest := '';


  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>Sale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + ctab + '<Tax>' + formatfloat('0.00', fprocessor.GetTax()) + '</Tax>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf;

  if FTrack2 = '' then
  begin
    // Manually entered so do the Address and CVV blocks
    if ((fprocessor.GetManualZipCode() <> '') or (Fprocessor.GetManualStreeAddress() <> '')) then
    begin
        strRequest := strRequest + ctab + ctab + '<AVS>'+  ccrlf;

        if (Fprocessor.GetManualStreeAddress() <> '') then
          strRequest := strRequest + ctab + ctab + ctab + '<Address>' + Fprocessor.GetManualStreeAddress() + '</Address>' + ccrlf;

        if ( fprocessor.GetManualZipCode() <> '' ) then
          strRequest := strRequest + ctab + ctab + ctab + '<Zip>' + fprocessor.GetManualZipCode() + '</Zip>' + ccrlf;

        strRequest := strRequest + ctab + ctab + '</AVS>' + ccrlf;
    end;

    // Do CVV if there is CVV
    if ( Fprocessor.GetManualCvv <> '' ) then
        strRequest := strRequest + ctab + ctab + '<CVVData>' + Fprocessor.GetManualCvv() + '</CVVData>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<TranInfo>' + ccrlf +
                ctab + ctab + ctab + '<CustomerCode>' + Fprocessor.GetCustomerCode() + '</CustomerCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' + ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftReload: Boolean;
begin
   BeforeProcessCard();
   result := ProcessCommand(GiftReloadXML);
end;

function TDsiClientXIntegration.GiftReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftVoidIssue: Boolean;
begin
   BeforeVoid();
   BeforeProcessCard();
   result := ProcessCommand(GiftVoidIssueXML);
end;

function TDsiClientXIntegration.GiftVoidIssueXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidIssue</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftVoidReload: Boolean;
begin
   BeforeVoid();
   BeforeProcessCard();
   result := ProcessCommand(GiftVoidReloadXML);
end;

function TDsiClientXIntegration.GiftVoidReloadXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReload</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftVoidReturn: Boolean;
begin
   BeforeVoid();
   BeforeProcessCard();
   result := ProcessCommand(GiftVoidReturnXML);
end;

function TDsiClientXIntegration.GiftVoidReturnXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidReturn</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.GiftVoidSale: Boolean;
begin
   BeforeVoid();
   BeforeProcessCard();
   result := ProcessCommand(GiftVoidSaleXML);
end;

function TDsiClientXIntegration.GiftVoidSaleXML: String;
var
  strRequest: string;
begin

  strRequest := '';

  strRequest := strRequest + ctab + ctab + '<IpPort>' + Fprocessor.GetGiftPort() + '</IpPort>' + ccrlf;

  strRequest := strRequest +
                ctab + ctab + '<MerchantID>' + Fprocessor.GetGiftMerchantID() + '</MerchantID>' + ccrlf +
                ctab + ctab + '<Memo>' + Fprocessor.GetAppLabel() + '</Memo>' + ccrlf +
                ctab + ctab + '<OperatorID>' + Fprocessor.GetOperatorID() + '</OperatorID>' + ccrlf +
                ctab + ctab + '<TranType>PrePaid</TranType>' + ccrlf +
                ctab + ctab + '<TranCode>VoidSale</TranCode>' +  ccrlf +
                ctab + ctab + '<InvoiceNo>' + Fprocessor.GetInvoiceNo() + '</InvoiceNo>' +  ccrlf +
                ctab + ctab + '<RefNo>' + Fprocessor.GetRefNo() + '</RefNo>' + ccrlf;

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
                    ctab + ctab + ctab + '<AcctNo>' + Fprocessor.GetAcctNo() + '</AcctNo>' +  ccrlf +
                    ctab + ctab + ctab + '<ExpDate>' + Fprocessor.GetExpireDate() + '</ExpDate>' +  ccrlf +
                    ctab + ctab + '</Account>' + ccrlf;
  end;

  strRequest := strRequest + ctab + ctab + '<Amount>' +  ccrlf +
                ctab + ctab + ctab + '<Purchase>' + formatfloat('0.00', Fprocessor.GetPurchase()) + '</Purchase>' + ccrlf +
                ctab + ctab + '</Amount>' +  ccrlf +
                ctab + ctab + '<TranInfo>' +  ccrlf +
                ctab + ctab + ctab + '<AuthCode>' + Fprocessor.GetAuthCode() + '</AuthCode>' + ccrlf +
                ctab + ctab + '</TranInfo>' +  ccrlf;

  // Add XML, TStream and Transaction
  Result := '<?xml version="1.0"?>' + ccrlf + '<TStream>' + ccrlf +
            ctab + '<Transaction>' + ccrlf +
            strRequest +
            ctab + '</Transaction>' + ccrlf +
            '</TStream>';

end;

function TDsiClientXIntegration.InitializeStatus: Boolean;
begin

end;

function TDsiClientXIntegration.IsCustomerCardPresent: Boolean;
var
   imsgResult : Integer;
begin
  result := false;
  if ( FcardSwiped = '' ) then begin
    iMsgResult := MsgBox('Is the customer card present?_Total to be proccessed: ' + FormatCurr('#,##0.00', Fprocessor.GetPurchase), vbYesNoCancel)
  end else Begin
         iMsgResult := vbYes;
      end;

  result := ( imsgResult = vbYes );

end;

function TDsiClientXIntegration.ManualEntryCard: Boolean;
var
  sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2 : String;
begin
  with TfrmPCCharge.Create(nil) do
  try
    Result := StartMercury(sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2);

    if ( Result ) then begin
       Fprocessor.SetAcctNo(sCardNumber);
       fprocessor.SetManualMemberName(sMemberName);
       fprocessor.SetExpireDate(sExpireDate);
       Fprocessor.SetManualStreeAddress(sStreetAddress);
       Fprocessor.SetManualZipCode(sZipCode);
       Fprocessor.SetManualCVV2(sCvv2);
    end;

  finally
    Free;
  end;

end;


procedure TDsiClientXIntegration.NeedSwipe(Sender: TObject;  var SwipedTrack: WideString; var Canceled: Boolean);
var
  FrmSC: TFrmPCCSwipeCard;
  iIDMeioPag : Integer;
begin
  FrmSC := TFrmPCCSwipeCard.Create(nil);
  try
    Canceled := not FrmSC.Start(SwipedTrack, iIDMeioPag);

    //Trocar o ID do Meio Pag pelo que foi feito no swipe
    if (not Canceled) and (iIDMeioPag <> -1) then
      Fprocessor.SetIdPaymentType(iIdMeioPag);

  finally
    FreeAndNil(FrmSC);
  end;


end;


function TDsiClientXIntegration.ProcessCommand(arg_xml: WideString): Boolean;

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
    FXMLSent     := arg_xml;

//    showmessage('dsi xml sent ' + fxmlSent);

    FXMLResult   := FDevice.ProcessTransaction(FXMLSent, 0, '', FUserTraceData);
    FXMLReceived := FXMLResult;

//    showmessage('dsi xml response ' + FXMLResult);

    if VerifyTransaction then
      Result := True;
  end;

end;

procedure TDsiClientXIntegration.SetIDPaymentType(
  arg_paymentType: Integer);
begin

end;

procedure TDsiClientXIntegration.SetPinPad(arg_pinpad: TMRPinPad);
begin
  FPinPad := arg_pinpad;
end;

procedure TDsiClientXIntegration.SetProcessor(arg_processor: IProcessor);
begin
  Fprocessor := arg_processor;
end;

procedure TDsiClientXIntegration.SetSwiped(arg_cardSwiped: WideString);
begin
   FcardSwiped := arg_cardSwiped;
end;


function TDsiClientXIntegration.tryBalanceCard(
  arg_salePrice: double): TTransactionReturn;
var
  msg: String;
  msgButtonSelected: Integer;
  balanceToBeAdded: double;
begin
  GiftBalance();
  result := Fprocessor.GetTransactionResult();

  // Antonio, 2013 Oct 19 - (MR-67)
  if ( FXMLContent.GetAttributeString('CmdStatus') = 'Approved' ) then begin
     balanceToBeAdded := fprocessor.GetBalance + arg_saleprice;
     msg := Format('Card %s already issued.'+#13#10+' New balance will be %f', [self.getSecureSerialNumber(Fprocessor.GetAcctNo),balanceToBeAdded]);
     messageDlg(msg, mtInformation, [mbOK], 0);
  end;

end;

function TDsiClientXIntegration.tryIssueCard(
  arg_salePrice: double): TTransactionReturn;
var
  msg: String;
  msgButtonSelected: Integer;
  balanceToBeAdded: double;
begin
  GiftBalance();
  result := Fprocessor.GetTransactionResult();

  // Antonio, 2013 Oct 19 - (MR-67)
  if ( FXMLContent.GetAttributeString('CmdStatus') = 'Approved' ) then begin
     balanceToBeAdded := fprocessor.GetBalance + arg_saleprice;
     msg := Format('Card %s already issued.'+#13#10+' New balance will be %f', [self.getSecureSerialNumber(Fprocessor.GetAcctNo),balanceToBeAdded]);
     messageDlg(msg, mtInformation, [mbOK], 0);
  end;

end;


function TDsiClientXIntegration.VerifyTransaction: Boolean;
begin
  inherited;

end;

end.
