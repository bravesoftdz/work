unit uSaleReceive;

interface

uses
  ADODB, uMRTraceControl, Contnrs, uPayment, uBonusBucks, uInvoiceInfo,
  uMRPinPad, Dialogs, uDocumentInfo, uGynboSyncClasses, dbClient;

type
  TSaleReceive = class
  private
    FADOConnection: TADOConnection;
    FTraceControl: TMRTraceControl;
    //FIDPreSale: Integer;
    FPaymentList: TObjectList;
    //FIDStore: Integer;
    FIDUser: Integer;
    FErrorMsg: String;
    FPaymentCount: Integer;
    FDocumentInfo: TDocumentInfo;
    FLocalPath: String;
    FSoftwareVersion: String;

    FMercuryErrorsCode: TClientDataSet;

    //amfsouza 04.15.2011 - write only property to forces debit payment if user selected them.
    FSavePaymentTypeDebitCard: integer;
    FSaveIdPaymentTypeDebitCard: integer;

    function CreatePayment(APaymentType, AIDPaymentType, AIDCustomer,
      AIDCashRegMov: Integer; APaymentDate: TDateTime; APaymentValue: Currency; ASavePaymentType: integer = -11; arg_isMercuryGift: Boolean = false ): TPayment;
    procedure setSavePaymentTypeDebit(const Value: Integer);
  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl);
    destructor Destroy; override;

    function ProcessPayments: Boolean;
    function CompleteSale(AInvoiceInfo: TInvoiceInfo; AIDTouristGroup,
      AOtherComID: Integer; ABonusValue: Currency; ATotalCash : Currency; ABonusSync : TbgBonusSync; cdsmercury_gift: TClientDataSet = nil): Boolean;
    function CompleteServiceOrder : Boolean;

    function InsertPayment(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
      APaymentDate: TDateTime; APaymentValue: Currency): Boolean;
    function InsertPaymentBonusBucks(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
      APaymentDate: TDateTime; APaymentValue: Currency; ABonusBucks: TBonusBucks): Boolean;
    function InsertPaymentCheck(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
      APaymentDate: TDateTime; APaymentValue: Currency; ACheckNumber, APartNumber,
      ACustomerNumber, ACustomerName, ACustomerPhone, AOBS: String; AIDBankCheck,
      APaymentPlace: Integer; AIsPostDate: Boolean): Boolean;
    function InsertPaymentGiftCard(APaymentType, AIDPaymentType, AIDCashRegMov,
      AIDCustomer: Integer; APaymentDate: TDateTime; APaymentValue: Currency; AGiftCardNumber: String): Boolean;

    function InsertPaymentDebitCard(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
      APaymentDate: TDateTime; APaymentValue: Currency; APinPad: TMRPinPad; ARefundID : Integer;
      ARefundDate : TDateTime): Boolean;

    function InsertPaymentCreditCard(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
      APaymentDate: TDateTime; APaymentValue: Currency; ACardSwiped: WideString; ARefundID : Integer;
      ARefundDate : TDateTime): Boolean;

    // amfsouza 10.18.2011 - Gift cards from another companies
    function InsertPaymentGiftCardMercury(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
      APaymentDate: TDateTime; APaymentValue: Currency; ACardSwiped: WideString; ARefundID : Integer;
      ARefundDate : TDateTime): Boolean;

    function HasAutoProcessPayment : Boolean;
    //function LoadPayments(AIDPreSale, AIDStore, AIDUser: Integer): Boolean; overload;
    function LoadPayments(ADocumentInfo: TDocumentInfo; AIDUser: Integer): Boolean;
    function GetPaymentTotal: Currency;
    function GetPaymentTotalByType(AType: Integer): Currency;
    function GetLastPayment: TPayment;
    function DeletePayment(APaymentIndex: Integer): Boolean;

    //amfsouza 04.15.2011 -
    property SavePaymentTypeDebitCard: integer write setSavePaymentTypeDebit;
    property SaveIdPaymentTypeDebitCard: integer read FSaveIdPaymentTypeDebitCard write FSaveIdPaymentTypeDebitCard;
    property ADOConnection: TADOConnection read FADOConnection write FADOConnection;
    property TraceControl: TMRTraceControl read FTraceControl write FTraceControl;
    property ErrorMsg: String read FErrorMsg write FErrorMsg;
    property LocalPath: String read FLocalPath write FLocalPath;
    property PaymentList: TObjectList read FPaymentList write FPaymentList;
    property DocumentInfo: TDocumentInfo read FDocumentInfo;
    property SoftwareVersion: String read FSoftwareVersion write FSoftwareVersion;
  end;

implementation

uses SysUtils, uSystemConst, uPaymentBonusBucks, uPaymentCard,
  uPaymentCheck, uPaymentOther, uPaymentGiftCard, uPaymentStoreCredit,
  Classes, uSaleFinalize, uServiceOrderFinalize, uPaymentStoreAccount,
  uDebugFunctions{, PaymentCreditCard, PaymentPrePaidCard, PaymentDebitCard};

{ TSaleReceive }

function TSaleReceive.CompleteSale(AInvoiceInfo: TInvoiceInfo; AIDTouristGroup,
  AOtherComID: Integer; ABonusValue: Currency; ATotalCash : Currency; ABonusSync : TbgBonusSync; cdsmercury_gift: TClientDataset): Boolean;
var
  //iError: Integer;
  //sParamError: String;
  FSaleFinalize : TSaleFinalize;
  FIDInvoice : Integer;
  sError : String;

  //iniTime : TDateTime;
begin

   Result := False;

   //iniTime := Now;

   FIDInvoice := -1;
   //amfsouza september 05, 2012 FSaleFinalize := TSaleFinalize.Create(FADOConnection, FTraceControl);
   FSaleFinalize := TSaleFinalize.Create(FADOConnection, FTraceControl, AInvoiceInfo);
   try
     FSaleFinalize.IDPreSale      := AInvoiceInfo.IDPreSale;
     FSaleFinalize.IDTouristGroup := AIDTouristGroup;
     FSaleFinalize.OtherComID     := AOtherComID;
     FSaleFinalize.IDCashRegMov   := AInvoiceInfo.IDCashRegMov;
     FSaleFinalize.IDStore        := FDocumentInfo.IDStore;
     FSaleFinalize.IDUser         := FIDUser;
     FSaleFinalize.SaleDate       := Now;
     FSaleFinalize.PayDate        := Now;
     FSaleFinalize.CashReceived   := ATotalCash;
     FSaleFinalize.BonusBucks     := ABonusValue;
     FSaleFinalize.BonusSync      := ABonusSync;

     Result := FSaleFinalize.ProccessSale(FIDInvoice, sError, cdsmercury_gift);

     if Result then
       AInvoiceInfo.IDInvoice := FIDInvoice
     else
       ErrorMsg := sError;
   finally
     FreeAndNil(FSaleFinalize);
   end;


  {
  FTraceControl.TraceIn('TSaleReceive.CompleteSale');

  with TADOStoredProc.Create(nil) do
  try
    FADOConnection.BeginTrans;

    Connection := FADOConnection;
    CommandTimeout := 5000;
    ProcedureName := 'sp_PreSale_Pay;1';
    Parameters.Refresh;

    Parameters.ParambyName('@PreSaleID').Value      := AInvoiceInfo.IDPreSale;
    Parameters.ParambyName('@IDTouristGroup').Value := AIDTouristGroup;
    Parameters.ParambyName('@OtherComID').Value     := AOtherComID;
    Parameters.ParambyName('@IDCashRegMov').Value   := AInvoiceInfo.IDCashRegMov;
    Parameters.ParambyName('@IDStore').Value        := FIDStore;
    Parameters.ParambyName('@Date').Value           := Now;
    Parameters.ParambyName('@PayDate').Value        := Now;
    Parameters.ParambyName('@CashReceived').Value   := ATotalCash;
    Parameters.ParamByName('@BonusBucks').Value     := ABonusValue;
    Parameters.ParambyName('@IDInvoice').Value      := 0;
    ExecProc;
    AInvoiceInfo.IDInvoice := Parameters.ParambyName('@IDInvoice').Value;

    iError := Parameters.ParamByName('@RETURN_VALUE').Value;
    Result := (iError = 0);

    if iError <> 0 then
      raise Exception.Create('sp_PreSale_Pay Error ' + IntToStr(iError));

    FADOConnection.CommitTrans;
  except
    on E: Exception do
    begin
      FADOConnection.RollbackTrans;
      Result := False;
      FErrorMsg := E.Message;
      sParamError := 'fIDPreSale=' + IntTostr(AInvoiceInfo.IDPreSale) + ';fIDTourGroup=' +
        IntTostr(AIDTouristGroup) + ';fIDOtherCommis=' + IntTostr(AOtherComID) +
        ';fIDCashRegMov=' + IntTostr(AInvoiceInfo.IDCashRegMov) + ';fIDStore='+IntTostr(FIDStore) +
        ';fDate=' + FormatDateTime('ddddd hh:mm', Now) + ';fDate=' + FormatDateTime('ddddd hh:mm', Now) + '.';
      FTraceControl.SetException(E.Message + ' Param = ' + sParamError, 'TFrmPOSFunctions');
    end;
  end;

  FTraceControl.TraceOut;
  }

  //ShowMessage(FormatDateTime('ss:zzz', (Now - iniTime)));


end;

function TSaleReceive.CompleteServiceOrder: Boolean;
var
  FServiceOrderFinalize : TServiceOrderFinalize;
  sError : String;
begin
  Result := True;

  FServiceOrderFinalize := TServiceOrderFinalize.Create(FADOConnection, FTraceControl);
  try
    FServiceOrderFinalize.IDServiceOrder := FDocumentInfo.ID;
    FServiceOrderFinalize.IDUser         := FIDUser;
    FServiceOrderFinalize.IDStore        := FDocumentInfo.IDStore;

    Result := FServiceOrderFinalize.ProccessServiceOrder(sError);

    if not Result then
      ErrorMsg := sError;

  finally
    FreeAndNil(FServiceOrderFinalize);
  end;

  Result := True;

end;

constructor TSaleReceive.Create(AADOConnection: TADOConnection;
  ATraceControl: TMrTraceControl);
begin
  FADOConnection := AADOConnection;
  FTraceControl := ATraceControl;

  FPaymentList := TObjectList.Create;
end;

function TSaleReceive.CreatePayment(APaymentType, AIDPaymentType, AIDCustomer,
  AIDCashRegMov: Integer; APaymentDate: TDateTime; APaymentValue: Currency; ASavePaymentType: integer = -11; arg_isMercuryGift: Boolean = false ): TPayment;
var
  iPaymentIndex: Integer;
begin
  FTraceControl.TraceIn('TSaleReceive.CreatePayment');
  iPaymentIndex := -1;

  // Antonio, August 09, 2013
  if ( not arg_isMercuryGift ) then begin
      if ( ASavePaymentType <> - 11 ) then // is debit card payment.
         APaymentType := FSavePaymentTypeDebitCard;
  end;

  case APaymentType of
    PAYMENT_TYPE_CASH:
      iPaymentIndex := FPaymentList.Add(TPayment.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_CARD:
      iPaymentIndex := FPaymentList.Add(TPaymentCreditCard.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_OTHER:
      iPaymentIndex := FPaymentList.Add(TPaymentOther.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_CHECK:
      iPaymentIndex := FPaymentList.Add(TPaymentCheck.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_CREDIT:
      iPaymentIndex := FPaymentList.Add(TPaymentStoreCredit.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_GIFTCARD: begin
      // Antonio, August 09 2013
      if ( arg_isMercuryGift ) then
         iPaymentIndex := FPaymentList.Add(TPaymentPrePaid.Create(FADOConnection, FTraceControl))
      else
         iPaymentIndex := FPaymentList.Add(TPaymentGiftCard.Create(FADOConnection, FTraceControl));
    end;

    PAYMENT_TYPE_DEBIT:
      iPaymentIndex := FPaymentList.Add(TPaymentDebitCard.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_BONUSBUCK:
      iPaymentIndex := FPaymentList.Add(TPaymentBonusBucks.Create(FADOConnection, FTraceControl));

    PAYMENT_TYPE_STOREACCOUNT:
      iPaymentIndex := FPaymentList.Add(TPaymentStoreAccount.Create(FADOConnection, FTraceControl));

    //amfsouza 10.18.2011 - Gift Cards from another companies.
    PAYMENT_TYPE_GIFTCARD_OTHERS:
      iPaymentIndex := FPaymentList.Add(TPaymentPrePaid.Create(FADOConnection, FTraceControl));

    else
      Result := nil;
  end;

  if Assigned(Result) then
  begin
    TPayment(FPaymentList[iPaymentIndex]).PaymentIndex := FPaymentCount + 1;

    case FDocumentInfo.DocumentType of
      dtInvoice: TPayment(FPaymentList[iPaymentIndex]).IDPreSale := FDocumentInfo.ID;
      dtServiceOrder: TPayment(FPaymentList[iPaymentIndex]).IDServiceOrder := FDocumentInfo.ID;
    end;

    TPayment(FPaymentList[iPaymentIndex]).IDStore := FDocumentInfo.IDStore;
    TPayment(FPaymentList[iPaymentIndex]).IDUser := FIDUser;
    TPayment(FPaymentList[iPaymentIndex]).IDPaymentType := AIDPaymentType;
    TPayment(FPaymentList[iPaymentIndex]).IDCustomer := AIDCustomer;
    TPayment(FPaymentList[iPaymentIndex]).IDCashRegMov := AIDCashRegMov;
    TPayment(FPaymentList[iPaymentIndex]).PaymentDate := APaymentDate;
    TPayment(FPaymentList[iPaymentIndex]).PaymentValue := APaymentValue;
    TPayment(FPaymentList[iPaymentIndex]).DocumentType := FDocumentInfo.DocumentType;
    TPayment(FPaymentList[iPaymentIndex]).PaymentMemo := FSoftwareVersion;

    //amfsouza 04.15.2011 - save payment to each payment
    TPayment(FPaymentList[iPaymentIndex]).SaveIdPaymentDebitCard := FSaveIdPaymentTypeDebitCard;

    Result := TPayment(FPaymentList[iPaymentIndex]);
  end;

  FTraceControl.TraceOut;
end;

function TSaleReceive.DeletePayment(APaymentIndex: Integer): Boolean;
var
  i: Integer;
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.DeletePayment');
  Result := False;

  for i := 0 to Pred(FPaymentList.Count) do
    if TPayment(FPaymentList[i]).PaymentIndex = APaymentIndex then
      pPayment := TPayment(FPaymentList[i]);

  try
    if TPayment(pPayment).CanDelete then
    begin
      if pPayment.DeletePayment then
      begin
        PaymentList.Remove(pPayment);
        Result := True;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;

destructor TSaleReceive.Destroy;
begin
  FreeAndNil(FPaymentList);
  inherited;
end;

function TSaleReceive.GetLastPayment: TPayment;
begin
  Result := TPayment(FPaymentList[FPaymentList.Count-1]);
end;

function TSaleReceive.GetPaymentTotal: Currency;
var
  i: Integer;
begin
  FTraceControl.TraceIn('TSaleReceive.GetPaymentTotal');
  Result := 0;

  for i := 0 to Pred(FPaymentList.Count) do begin
    Result := Result + TPayment(FPaymentList[i]).PaymentValue;

  end;
  FTraceControl.TraceOut;
end;

function TSaleReceive.GetPaymentTotalByType(AType: Integer): Currency;
var
  i: Integer;
begin
  Result := 0;

  for i := 0 to Pred(FPaymentList.Count) do
    if TPayment(FPaymentList[i]).GetPaymentType = AType then
      Result := Result + TPayment(FPaymentList[i]).PaymentValue;
end;

function TSaleReceive.HasAutoProcessPayment: Boolean;
var
  i : Integer;
begin
  Result := False;

  for i := 0 to pred(FPaymentList.Count) do
    if TPayment(FPaymentList[i]).AutoProcess then
    begin
      Result := True;
      Break;
    end;
end;

function TSaleReceive.InsertPayment(APaymentType, AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
  APaymentDate: TDateTime; APaymentValue: Currency): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPayment');
  Result := False;

  try
    (* amfsouza 09.26.2011-debug *)FTraceControl.SaveTrace(FIdUser, 'Debug-Step-begin: create payment type: ' + intToStr(APaymentType) + ' value : ' + CurrToStr(APaymentValue) , '(PII):'+ self.ClassName);
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue);

    if Assigned(pPayment) then
    begin
      if TPayment(pPayment).ValidatePayment then
      begin
        if TPayment(pPayment).AutoProcess then
          if not TPayment(pPayment).ProcessPayment then
            raise Exception.Create('');
    (* amfsouza 09.26.2011-debug *)FTraceControl.SaveTrace(FIdUser, 'Debug-Step-end: create payment type: ' + intToStr(APaymentType) + ' value : ' + CurrToStr(APaymentValue) , '(PII):'+ self.ClassName);
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
(* amfsouza 09.26.2011-debug *)FTraceControl.SaveTrace(FIdUser, 'Debug-Step-end:  create payment Exception',  '(PII):'+ self.ClassName);
      FPaymentList.Remove(pPayment);
      FTraceControl.SaveTraceFile(FIDUser, E.Message, Self.ClassName, FLocalPath);
    end;
  end;
  
  FTraceControl.TraceOut;
end;

function TSaleReceive.InsertPaymentBonusBucks(APaymentType, AIDPaymentType,
  AIDCashRegMov, AIDCustomer: Integer; APaymentDate: TDateTime;
  APaymentValue: Currency; ABonusBucks: TBonusBucks): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPayment');
  Result := False;

  try
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue);

    if Assigned(pPayment) then
    begin
      TPaymentBonusBucks(pPayment).BonusBucks := ABonusBucks;

      if TPayment(pPayment).ValidatePayment then
      begin
        if TPaymentBonusBucks(pPayment).AutoProcess then
          TPaymentBonusBucks(pPayment).ProcessPayment;
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
      FPaymentList.Remove(pPayment);
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TSaleReceive.InsertPaymentCheck(APaymentType, AIDPaymentType,
  AIDCashRegMov, AIDCustomer: Integer; APaymentDate: TDateTime;
  APaymentValue: Currency; ACheckNumber, APartNumber, ACustomerNumber,
  ACustomerName, ACustomerPhone, AOBS: String; AIDBankCheck,
  APaymentPlace: Integer; AIsPostDate: Boolean): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPaymentCheck');
  Result := False;

  try
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue);

    if Assigned(pPayment) then
    begin
      TPaymentCheck(pPayment).CheckNumber    := ACheckNumber;
      TPaymentCheck(pPayment).PartNumber     := APartNumber;
      TPaymentCheck(pPayment).CustomerNumber := ACustomerNumber;
      TPaymentCheck(pPayment).CustomerName   := ACustomerName;
      TPaymentCheck(pPayment).CustomerPhone  := ACustomerPhone;
      TPaymentCheck(pPayment).OBS            := AOBS;
      TPaymentCheck(pPayment).IDBankCheck    := AIDBankCheck;
      TPaymentCheck(pPayment).PaymentPlace   := APaymentPlace;
      TPaymentCheck(pPayment).IsPostDate     := AIsPostDate;

      if TPayment(pPayment).ValidatePayment then
      begin
        if TPayment(pPayment).AutoProcess then
          TPayment(pPayment).ProcessPayment;
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');

      Result := True;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
      FPaymentList.Remove(pPayment);
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TSaleReceive.InsertPaymentCreditCard(APaymentType, AIDPaymentType,
  AIDCashRegMov, AIDCustomer: Integer; APaymentDate: TDateTime;
  APaymentValue: Currency; ACardSwiped: WideString; ARefundID : Integer;
  ARefundDate : TDateTime): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPaymentCreditCard');
  Result := False;

  try
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue);

    if Assigned(pPayment) then
    begin
      TPaymentCreditCard(pPayment).CardSwiped := ACardSwiped;

      if APaymentValue < 0 then
      begin
        TPaymentCreditCard(pPayment).RefundID   := ARefundID;
        TPaymentCreditCard(pPayment).RefundDate := ARefundDate;
      end;

      if TPayment(pPayment).ValidatePayment then
      begin
        if TPayment(pPayment).AutoProcess then
          if not TPayment(pPayment).ProcessPayment then
            raise Exception.Create('');
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
      FPaymentList.Remove(pPayment);
      FTraceControl.SaveTraceFile(FIDUser, E.Message, Self.ClassName, FLocalPath);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TSaleReceive.InsertPaymentDebitCard(APaymentType, AIDPaymentType,
  AIDCashRegMov, AIDCustomer: Integer; APaymentDate: TDateTime;
  APaymentValue: Currency; APinPad: TMRPinPad; ARefundID : Integer;
  ARefundDate : TDateTime): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPaymentDebitCard');
  Result := False;

  try                                                                                                                (* save *)
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue, FSaveIdPaymentTypeDebitCard);

    if Assigned(pPayment) then
    begin
      TPaymentDebitCard(pPayment).PinPad := APinPad;

      if APaymentValue < 0 then
      begin
        DebugToFile('Debit value is less than zero ( < 0 ) - Refund');
        TPaymentDebitCard(pPayment).RefundID   := ARefundID;
        TPaymentDebitCard(pPayment).RefundDate := ARefundDate;
        DebugToFile('Refund ID = ' + intToStr(ARefundID));
        DebugToFile('Refund Date = '+ dateToStr(ARefundDate));
      end;

      if TPayment(pPayment).ValidatePayment then
      begin
        if TPayment(pPayment).AutoProcess then
          if not TPayment(pPayment).ProcessPayment then
            raise Exception.Create('');
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');
      
    end;

    Result := True;

    //amfsouza 04.15.2011 - reset variables
    FSavePaymentTypeDebitCard := -11;
    FSaveIdPaymentTypeDebitCard := 0;

  except
    on E: Exception do
    begin
      debugtofile('Any Payment Exception');
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
      debugtofile('Message Payment Exception = '+ FErrorMsg);

      FPaymentList.Remove(pPayment);
      debugtofile('Payment removed = '+ FErrorMsg);

      FTraceControl.SaveTraceFile(FIDUser, E.Message, Self.ClassName, FLocalPath);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TSaleReceive.InsertPaymentGiftCardMercury(APaymentType,
  AIDPaymentType, AIDCashRegMov, AIDCustomer: Integer;
  APaymentDate: TDateTime; APaymentValue: Currency;
  ACardSwiped: WideString; ARefundID: Integer;
  ARefundDate: TDateTime): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPaymentGiftCardMercury');
  Result := False;

  try
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue, AIDPaymentType, true);

    if Assigned(pPayment) then
    begin
      TPaymentPrePaid(pPayment).CardSwiped := ACardSwiped;

      if APaymentValue < 0 then
      begin
        TPaymentPrePaid(pPayment).RefundID   := ARefundID;
        TPaymentPrePaid(pPayment).RefundDate := ARefundDate;
      end;

      if TPayment(pPayment).ValidatePayment then
      begin
        if TPayment(pPayment).AutoProcess then
          if(  not TPayment(pPayment).ProcessPayment ) then
            raise Exception.Create('');
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
      FPaymentList.Remove(pPayment);
      FTraceControl.SaveTraceFile(FIDUser, E.Message, Self.ClassName, FLocalPath);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TSaleReceive.InsertPaymentGiftCard(APaymentType, AIDPaymentType,
  AIDCashRegMov, AIDCustomer: Integer; APaymentDate: TDateTime;
  APaymentValue: Currency; AGiftCardNumber: String): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.InsertPaymentGiftCard');
  Result := False;

  try
    pPayment := CreatePayment(APaymentType, AIDPaymentType, AIDCustomer, AIDCashRegMov, APaymentDate, APaymentValue);

    if Assigned(pPayment) then
    begin
      TPaymentGiftCard(pPayment).CardNumber := AGiftCardNumber;

      if TPayment(pPayment).ValidatePayment then
      begin
        if TPayment(pPayment).AutoProcess then
          TPayment(pPayment).ProcessPayment;
        FPaymentCount := FPaymentCount + 1;
      end
      else
        raise Exception.Create('');
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      FErrorMsg := TPayment(pPayment).ErrorMsg;
      FPaymentList.Remove(pPayment);
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;


(*
function TSaleReceive.LoadPayments(AIDPreSale, AIDStore, AIDUser: Integer): Boolean;
var
  pPayment: TPayment;
begin
  FTraceControl.TraceIn('TSaleReceive.LoadPayments');

  FIDPreSale := AIDPreSale;
  FIDStore := AIDStore;
  FIDUser := AIDUser;
  FPaymentCount := 0;

  FPaymentList.Clear;

  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT ' +
                   '  L.IDLancamento, ' +
                   '  MP.Tipo ' +
                   'FROM ' +
                   '  Fin_Lancamento L ' +
                   '  JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag) ' +
                   'WHERE ' +
                   '  L.IDPreSale = :IDPreSale';
    Parameters.ParamByName('IDPreSale').Value := AIDPreSale;
    Open;

    while not Eof do
    begin
      pPayment := CreatePayment(FieldByName('Tipo').AsInteger, 0, 0, 0, 0, 0);

      if Assigned(pPayment) then
      begin
        pPayment.IDPayment := FieldByName('IDLancamento').AsInteger;
        pPayment.LoadPayment;
        FPaymentCount := FPaymentCount + 1;
      end;

      Next;
    end;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;
*)


function TSaleReceive.LoadPayments(ADocumentInfo: TDocumentInfo; AIDUser: Integer): Boolean;
var
  pPayment: TPayment;
  sWhere: String;
begin
  FTraceControl.TraceIn('TSaleReceive.LoadPayments');
  FDocumentInfo := ADocumentInfo;
  FIDUser := AIDUser;

  FPaymentCount := 0;

  FPaymentList.Clear;

  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    sWhere := '';

    case FDocumentInfo.DocumentType of
      dtInvoice:
        begin
          sWhere := '  L.IDPreSale = :ID';

        end;
      dtServiceOrder:
        begin
          sWhere := '  L.IDServiceOrder = :ID';
        end;

    end;

    CommandText := 'SELECT ' +
               '  L.IDLancamento, ' +
               '  MP.Tipo ' +
               'FROM ' +
               '  Fin_Lancamento L ' +
               '  JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag) ' +
               'WHERE ' +
               sWhere;
    Parameters.ParamByName('ID').Value := FDocumentInfo.ID;

    Open;

    while not Eof do
    begin
      pPayment := CreatePayment(FieldByName('Tipo').AsInteger, 0, 0, 0, 0, 0);

      if Assigned(pPayment) then
      begin
        pPayment.IDPayment := FieldByName('IDLancamento').AsInteger;
        pPayment.LoadPayment;
        FPaymentCount := FPaymentCount + 1;
      end;

      Next;
    end;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;


function TSaleReceive.ProcessPayments: Boolean;
var
  i: Integer;
begin
  FTraceControl.TraceIn('TSaleReceive.GetPaymentTotal');
  Result := True;

  for i := 0 to Pred(FPaymentList.Count) do
    if not TPayment(FPaymentList[i]).AutoProcess then
      if not TPayment(FPaymentList[i]).ProcessPayment then
      begin
        Result := False;
        FErrorMsg := TPayment(FPaymentList[i]).ErrorMsg;
        Break;
      end;

  FTraceControl.TraceOut;
end;

(*
procedure TSaleReceive.setIsCashBack(const Value: Boolean);
begin
  FIsCashBack := value;
end;
*)

procedure TSaleReceive.setSavePaymentTypeDebit(const Value: Integer);
begin
  FSavePaymentTypeDebitCard := value;
end;

end.
