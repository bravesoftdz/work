unit DeviceIntegration;

interface
uses SysUtils, Dialogs, uXML, ProcessorInterface, uMRPinPad, uCreditCardFunction;

type

   TDeviceIntegration = class(TInterfacedObject)
   protected
      
      FCashBack: Currency;
      FexpDate: String;
      Ftrack2: String;
      FcardSwiped : WideString;
      Fprocessor: IProcessor;
      FPinPad: TMRPinPad;

      FXMLResult             : WideString; // XML answer from Server
      FXMLServer             : WideString; // XML Server
      FXMLSent               : WideString; // XML Sent
      FXMLReceived           : WideString; // XML Received Aprooved/Declined
      FXMLContent            : TXMLContent;

      FAfterSucessfullSwipe  : TAfterSucessfullSwipe;
      FOnNeedSwipe           : TNeedSwipeEvent;
      FOnNeedTroutD          : TNeedTroutDEvent;
      
	  function VerifyTransaction(): Boolean; virtual;
      function VerifyServerConfig() : Boolean; virtual;
      function MappingCardType(arg_cardType: String): String; virtual;
      procedure SetPadType(arg_name: String); virtual;

   end;



implementation

{ TDeviceIntegration }

function TDeviceIntegration.MappingCardType(arg_cardType: String): String;
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

procedure TDeviceIntegration.SetPadType(arg_name: String);
begin

    if ( ansipos('Ingenico', arg_name) > 0 ) then begin
        Fprocessor.SetPadType('ISC250');
    end else if ( ansipos('Verifone', arg_name) > 0 ) then begin
                Fprocessor.SetPadType('VX805');
        end;
end;

function TDeviceIntegration.VerifyTransaction(): Boolean;
var
  AResult : String;
  IResult : Integer;
  trueCardtypeName: String;
begin

  try

    FXMLContent.XML := FXMLResult;
    Result := False;
    Fprocessor.SetMessage('');

    //Indicates the outcome of the command:
    //"Success" = command completed successfully
    //"Error" = error processing command. Check DSIXReturnCode and TextResponse for additional info on error
    AResult := FXMLContent.GetAttributeString('CmdStatus');

    //Six digit return code which identifies the error type. See Section 3 on error codes for possible values
    IResult := FXMLContent.GetAttributeInteger('DSIXReturnCode');

    if (AResult = 'Approved') then
    begin

      Fprocessor.SetAuthCode(FXMLContent.GetAttributeString('AuthCode'));
      Fprocessor.SetResultAcqRefData(FXMLContent.GetAttributeString('AcqRefData'));

      Fprocessor.SetRefNo(FXMLContent.GetAttributeString('RefNo'));
      Fprocessor.SetAcctNo(FXMLContent.GetAttributeString('AcctNo'));

      Fprocessor.SetLastDigits(Copy(Trim(Fprocessor.GetAcctNo()), Length(Trim(Fprocessor.GetAcctNo())) - 3, 4));
      Fprocessor.SetPurchase(FXMLcontent.GetAttributeDouble('Purchase'));

      Fprocessor.SetAuthorize(FXMLContent.GetAttributeDouble('Authorize'));
      Fprocessor.SetSequenceNo(FXMLContent.GetAttributeString('SequenceNo'));

      // # true name from XML response
      trueCardTypeName := FXMLContent.GetAttributeString('CardType');
      // # name mapped to assign correct IdMeioPag
      Fprocessor.SetCardType(mappingCardType(trueCardTypeName));

      Fprocessor.SetEntryMethod(FXMlContent.GetAttributeString('EntryMethod'));
      Fprocessor.SetAppLabel(FXMLContent.GetAttributeString('ApplicationLabel'));

      // Antonio 2013 Oct 28,  MR-80
      if ( FXMLContent.GetAttributeString('TranCode') = 'Return' ) then begin
         Fprocessor.SetPurchase(((-1) * Fprocessor.GetPurchase()));
         Fprocessor.SetAuthorize(((-1) * Fprocessor.GetAuthorize()));
      end;

      Fprocessor.SetMessage(AResult);
      Fprocessor.SetTransactionResult(ttrSuccessfull);
      Result             := True;
    end
    else
    begin
     // # see declined transaction and get info to receipt declined
      if (AResult = 'Declined') then begin

        Fprocessor.SetTransactionResult(ttrDeclined);
        Fprocessor.SetAcctNo(FXMLContent.GetAttributeString('AcctNo'));

        Fprocessor.SetLastDigits(Copy(Trim(Fprocessor.GetAcctNo()), Length(Trim(Fprocessor.GetAcctNo())) - 3, 4));
		// # true name from XML response
        trueCardTypeName := FXMLContent.GetAttributeString('CardType');
        // # name mapped to assign correct IdMeioPag
        Fprocessor.SetCardType(mappingCardType(trueCardTypeName));
        Fprocessor.SetEntryMethod(FXMlContent.GetAttributeString('EntryMethod'));

        // declined date time
        Fprocessor.SetDateTransaction(FXMLContent.GetAttributeString('Date') + ' Time: ' + FXMLContent.GetAttributeString('Time'));

      end else begin
             Fprocessor.SetTransactionResult(ttrError);
          end;


      Fprocessor.SetTrancode(IntToStr(IResult));
      Fprocessor.SetMessage('Code: ' + IntToStr(IResult));

      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');
 
      Fprocessor.SetMessage(Fprocessor.GetMessage() + '. ' + AResult );

    end;

  except
    on E: Exception do
    begin
      Fprocessor.SetTransactionResult(ttrException);
      Result := False;
      raise Exception.Create('Exception: ' + E.Message);
    end;
  end;

end;


function TDeviceIntegration.VerifyServerConfig: Boolean;
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
      Fprocessor.SetTransactionResult(ttrSuccessFull);
    end
    else
    begin
      Fprocessor.SetTransactionResult(ttrError);
      //Indicates the source of the response: “Client” = generated by DSIClientX control
      AResult := FXMLContent.GetAttributeString('ResponseOrigin');
      //For Successful responses, this field contains the number of IP addresses that were stored. For other response codes, see Section 3 on Error Codes for values
      AResult := FXMLContent.GetAttributeString('TextResponse');

      Fprocessor.SetMessage(AResult);
      result := true;
    end;

  except
    on E: Exception do
    begin
      Fprocessor.SetTransactionResult(ttrException);
      Result := False;
    end;
  end;

end;


end.
