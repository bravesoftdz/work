unit uPaymentCard;

interface

uses
  ADODB, uMRTraceControl, uPayment, uMRPCCharge, uMRPinPad, uPCCIntegration,
  uCCMercuryIntegration, uCreditCardFunction, Classes, uOperationSystem,
  DbClient;

const
  SERVICE_ORDER_PREFIX = 'SO';

type
  TPaymentCard = class(TPayment)
  private
    processResult: TCCWidget;

    FPCCharge: TMRPCCharge;
    FPCCT: TPCCTransaction;
    FMercuryWidget : TCCWidget;

    //amfsouza 02.14.2012
    FMercuryErrorsCode: TClientDataSet;

    // to new regular receipt to transactions cards.
    FMerchantID, FEntryMethod, FDate, FTime, FAppLabel, FAID, FTVR, FIAD, FTSI, FARC, FCVM, FAppLabelTranCode, FAppLabelRecordNo : String;

    FTroutD: String;
    FAuthorization: String;
    FLastDigits: String;
    FCardType: String;
    FTransactResult: Boolean;
    FProcessorType: Integer;
    fProcessingType: Integer;
    FCardSwiped: WideString;
    FRefundID: Integer;
    FRefundDate: TDateTime;
    FRefundCardInt : TStringList;

    procedure NeedSwipe(Sender: TObject; var SwipedTrack: WideString;
      var Canceled: Boolean);
    procedure SucessFullSwipe(Sender: TObject; const ACardNumber,
      ACardMember, ACardExpireDate: WideString);
    procedure NeedTroutD(Sender: TObject; var ATrouD, ARefNo, AAuthCode: WideString;
      var ACanceled: Boolean);

    function PCCResult: Boolean;
    function MercuryResult : Boolean;

    function DoPCCharge: Boolean;
    function DoMercury : Boolean;

    function GetRefundInfo : Boolean;

    function ReturnErrorMsg(AIDError:String):String;
    procedure printDeclinedReceipt();

  protected
    procedure BeforeProcessPayment; override;
    procedure BeforeDeletePayment; override;
    procedure FillParameters(FCmdPayment : TADOCommand); override;
    procedure SetProperties(ADSPayment: TADODataSet); override;
    procedure MoveValues();


  //  procedure PreparePCC; virtual;

    function ExecutePCCharge: Boolean; virtual;
    function ExecuteMercury: Boolean; virtual;

    function GetAutoProcess: Boolean; override;
    function GetSQLFields: String; override;
    function CanDelete: Boolean; override;
    function getTicketNumber: String;
  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl); override;
    destructor Destroy; override;

    property CardSwiped : WideString read FCardSwiped write FCardSwiped;
    property RefundID   : Integer    read FRefundID   write FRefundID;
    property RefundDate : TDateTime  read FRefundDate write FRefundDate;
    procedure PreparePCC; virtual;
    function getPaymentCard(arg_processor: Integer; arg_paymentType: Integer): TCCWidget;
    function VoidSaleTransation : Boolean;
  end;

  TPaymentDebitCard = class(TPaymentCard)
  private
    FPinPad: TMRPinPad;
  protected
    procedure BeforeProcessPayment; override;
    procedure PreparePCC; override;
    function ExecutePCCharge: Boolean; override;
    function ExecuteMercury: Boolean; override;
  public
    function GetPaymentType: Integer; override;

    property PinPad: TMRPinPad read FPinPad write FPinPad;
  end;

  TPaymentCreditCard = class(TPaymentCard)
  private
  protected
    procedure BeforeProcessPayment; override;
    function ExecutePCCharge: Boolean; override;
    function ExecutePCChargeNoCard: Boolean;
    function ExecutePCChargeWithCard: Boolean;

    function ExecuteMercury: Boolean; override;
    function ExecuteMercuryNoCard: Boolean;
    function ExecuteMercuryWithCard: Boolean;
  public
    function GetPaymentType: Integer; override;
  end;

  //amfsouza 10.18.2011 - Gift cards by Mercury
  TPaymentPrePaid = class(TPaymentCard)
  private
  protected
    procedure BeforeProcessPayment; override;
    function ExecuteMercuryNoCard: Boolean;
  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl); override;
    function getPaymentType: Integer; override;

    function ExecuteMercury: Boolean; override;
    function ExecuteMercuryWithCard: Boolean;
    function getCardNumber: Boolean;
  end;


implementation

uses SysUtils, uSystemConst, ufrmPCCharge, uFrmPCCSwipeCard, uNumericFunctions,
  uMsgBox, Math, Registry, Windows, Dialogs, uDocumentInfo, ufrmPCVoid,
  DateUtils,uDebugFunctions, DB, frmCardNumberDialogView, PrintReceiptDeclinedView;

{ TPaymentCard }

destructor TPaymentCard.Destroy;
begin

  if Assigned(FPCCharge) then
    FreeAndNil(FPCCharge);

  if Assigned(FPCCT) then
    FreeAndNil(FPCCT);

  if Assigned(FMercuryWidget) then
    FreeAndNil(FMercuryWidget);

  if Assigned(FRefundCardInt) then
    FreeAndNil(FRefundCardInt);

  inherited;
end;

function TPaymentCard.getTicketNumber: String;
begin
  case DocumentType of
    dtInvoice: Result := IntToStr(FIDPreSale);
    dtServiceOrder: Result := SERVICE_ORDER_PREFIX + IntToStr(FIDPreSale);
  end;
end;


function TPaymentCard.DoPCCharge: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.DoPCCharge');
  Result := False;


  PreparePCC;

  Result := ExecutePCCharge;

  if Result then
  begin
    FAuthorization := FPCCT.Auth;
    FTroutD        := FPCCT.TroutD;
    FLastDigits    := FPCCT.LastDigits;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentCard.FillParameters(FCmdPayment: TADOCommand);
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName + '.FillParameters');

  // Antonio 11/30/2015 - MR-263
  if ( processResult <> nil ) then begin

      if ( processResult.ChipMethod = 'chip') then begin
          FCmdPayment.Parameters.ParamByName('NumMeioQuitPrevisto').Value :=
          'A:'+ FAuthorization + ' R:' + FTroutD + ' L:' + FLastDigits + ' M:' + FMerchantID + ' E:' + FEntryMethod +
          ' D:' + FDate + ' T:' + FTime + ' C:' + 'chip' + ' P:' + FAppLabel + ' AID:' + FAID + ' TVR:' + FTVR +
          ' IAD:' + FIAD + ' TSI:' + FTSI + ' ARC:' + FARC + ' CVM:' + FCVM+
          ' TC:'+ FAppLabelTranCode;
      end else begin
              FCmdPayment.Parameters.ParamByName('NumMeioQuitPrevisto').Value :=
              'A:'+ FAuthorization + ' R:' + FTroutD + ' L:' + FLastDigits + ' M:' + FMerchantID + ' E:' + FEntryMethod +
              ' D:' + FDate + ' T:' + FTime + ' C:' + ' P:' + FAppLabel
          end;

  end;

  FTraceControl.TraceOut;
end;

function TPaymentCard.GetSQLFields: String;
begin
  Result := (inherited GetSQLFields) + ',NumMeioQuitPrevisto';
  FTraceControl.TraceOut;
end;

procedure TPaymentCard.NeedSwipe(Sender: TObject; var SwipedTrack: WideString;
  var Canceled: Boolean);
var
  FrmSC: TFrmPCCSwipeCard;
  iIDMeioPag : Integer;
begin
  FrmSC := TFrmPCCSwipeCard.Create(nil);
  try
    Canceled := not FrmSC.Start(SwipedTrack, iIDMeioPag);

    //Trocar o ID do Meio Pag pelo que foi feito no swipe
    if (not Canceled) and (iIDMeioPag <> -1) then
      IDPaymentType := iIDMeioPag;

  finally
    FreeAndNil(FrmSC);
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentCard.BeforeProcessPayment;
var
	processorMessage: String;
   salePaymentValue: Currency;
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName + '.BeforeProcessPayment');

  //##NEWCARD
  if GetAutoProcess then
  begin
    case FProcessorType of
      PROCESSOR_MERCURY, PROCESSOR_WORLDPAY :  begin

                              FAuthorization := '';
                              FTroutD := '';

                              FTransactResult := DoMercury;

                              processorMessage := processResult.Msg;
                              salePaymentValue := FPaymentValue;

                              // get real amount authorized from Mercury
                              // Antonio 09/16/2015 ( under test)
                              FPaymentValue := processResult.Authorize;
                              FTroutD := processResult.RefNo;
                              FLastDigits := processResult.LastDigits;
                              FCardType := processResult.CardType;
                              setIdMeioPrevisto(FCardType);

                              FMerchantID := processResult.MerchantID;
                              FEntryMethod := processResult.EntryMethod;

                              // to EMV response chipMethod = chip
                              if ( lowercase(processResult.ChipMethod) = 'chip' ) then begin
                                 FDate := processResult.DateTransaction;
                                 FTime := processResult.TimeTransaction;
                                 FAppLabel := processResult.AppLabel;
                                 FAID := processResult.AppLabelAID;
                                 FTVR := processResult.AppLabelTVR;
                                 FIAD := processResult.AppLabelIAD;
                                 FTSI := processResult.AppLabelTSI;
                                 FARC := processResult.AppLabelARC;
                                 FCVM := processResult.AppLabelCVM;
                                 FAppLabelTranCode := processResult.AppLabelTranCode;
                                 //FAppLabelRecordNo := processResult.AppLabelRecordNo;
                              end;

                           end;
    end;

    if not FTransactResult then begin
       // Antonio 09/22/2015
       case processResult.TransactionReturn of
           ttrDeclined: begin
              // Alex 09/25/2015  
              If ( ( processResult is TCCreditDSIEMVx ) or
                   ( processResult is TCDebitDSIEMVx ) ) Then
                 printDeclinedReceipt();
           end;
       end;


      raise Exception.Create('CARD NOT CHARGED!_' + processorMessage);  // Antonio 2013 Nov 6, MR-84
    end;

  end;

  FTraceControl.TraceOut;
end;

function TPaymentCard.PCCResult: Boolean;
var
  sMsg: String;
begin
  FTraceControl.TraceIn(Self.ClassName + '.PCCResult');
  Result := False;

  sMsg := '';
  try
    case FPCCT.TransactionReturn of
      ttrSuccessfull:
      begin
        Result := True;
        sMsg := Format('%S'#13#10'Auth: %S'#13#10'RefNumber: %S'#13#10'TroutD: %S', [FPCCT.PCCResult, FPCCT.Auth, FPCCT.RefNumber, FPCCT.TroutD]);

        if FPCCT.AVS <> '' then
          sMsg := Format(sMsg + #13#10'AVS: %S', [FPCCT.AVS]);

        if FPCCT.CVV2Ver <> '' then
          sMsg := Format(sMsg + #13#10'CVV2: %S', [FPCCT.CVV2Ver]);

        // TODO
        //Application.MessageBox(PChar(sMsg), 'Transaction result', MB_OK + MB_ICONINFORMATION);
      end;

      ttrNotSuccessfull:
      begin
        sMsg := Format('%S'#13#10'Reason: %S', [FPCCT.PCCResult, FPCCT.Auth]);
        raise Exception.Create(sMsg);
      end;

      ttrError:
      begin
        sMsg := Format('%S'#13#10'Error: %D - %S', [FPCCT.PCCResult, FPCCT.ErrorCode, FPCCT.ErrorDesc]);
        raise Exception.Create(sMsg);
      end;

      ttrException:
      begin
        sMsg := Format(''#13#10'Error: %S', [FPCCT.ErrorDesc]);
        raise Exception.Create(sMsg);
      end;
    end;
  except
    FErrorMsg := sMsg;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentCard.PreparePCC;
begin
  FTraceControl.TraceIn(Self.ClassName + '.PreparePCC');

  FPCCT.Path                 := FPCCharge.Path;
  FPCCT.User                 := FPCCharge.User;
  FPCCT.TimeOut              := FPCCharge.TimeOut;
  FPCCT.Multi                := IntToStr(Byte(FPCCharge.MultTrans));
  FPCCT.LastValidDate        := IntToStr(FPCCharge.LastDate);
  FPCCT.PrintReceipts        := IntToStr(FPCCharge.PrintNum);
  FPCCT.Processor            := FPCCharge.Processor;
  FPCCT.Port                 := FPCCharge.Port;
  FPCCT.IPAddress            := FPCCharge.Server;
  FPCCT.MerchantNumber       := FPCCharge.MercantAcc;
  FPCCT.OnNeedSwipe          := NeedSwipe;
  FPCCT.AfterSucessfullSwipe := SucessFullSwipe;
  FPCCT.OnNeedTroutD         := nil;

  FTraceControl.TraceOut;
end;

procedure TPaymentCard.SucessFullSwipe(Sender: TObject; const ACardNumber,
  ACardMember, ACardExpireDate: WideString);
begin
  // Adicionar neste evento qualquer código que precise ser executado após
  // uma tentativa bem sucedida de leitura do cartão
  FTraceControl.TraceIn(Self.ClassName + '.SucessFullSwipe');

  FTraceControl.TraceOut;
end;

procedure TPaymentCard.MoveValues();
begin
  FAuthorization := processResult.AuthCode;

  FPaymentValue := processResult.Authorize;
  FTroutD := processResult.RefNo;
  FLastDigits := processResult.LastDigits;
  FCardType := processResult.CardType;
  setIdMeioPrevisto(FCardType);

  FMerchantID := processResult.MerchantID;
  FEntryMethod := processResult.EntryMethod;

  // to EMV response chipMethod = chip
  if ( lowercase(processResult.ChipMethod) = 'chip' ) then begin
     FDate := processResult.DateTransaction;
     FTime := processResult.TimeTransaction;
     FAppLabel := processResult.AppLabel;
     FAID := processResult.AppLabelAID;
     FTVR := processResult.AppLabelTVR;
     FIAD := processResult.AppLabelIAD;
     FTSI := processResult.AppLabelTSI;
     FARC := processResult.AppLabelARC;
     FCVM := processResult.AppLabelCVM;
     FAppLabelTranCode := processResult.AppLabelTranCode;
     //FAppLabelRecordNo := processResult.AppLabelRecordNo;
  end;
End;

procedure TPaymentCard.SetProperties(ADSPayment: TADODataSet);
var
  Field: String;
  pA, pR, pL, pM, pE, pD, pT, pC,pP, pAid, pIad, pTvr, pTsi, pArc, pCvm: Integer;
begin
  inherited;

{
  'A:'+ FAuthorization + ' R:' + FTroutD + ' L:' + FLastDigits + ' M:' + FMerchantID + ' E:' + FEntryMethod +
  ' D:' + FDate + ' T:' + FTime + ' C:' + 'chip' + ' P:' + FAppLabel + ' AID:' + FAID + ' TVR:' + FTVR +
  ' IAD:' + FIAD + ' TSI:' + FTSI + ' ARC:' + FARC + ' CVM:' + FCVM+
  ' TC: '+ FAppLabelTranCode;
}

  FTraceControl.TraceIn(Self.ClassName + '.SetProperties');

  if ( not  ADSPayment.fieldByName('NumMeioQuitPrevisto').IsNull ) then begin
      Field := ADSPayment.FieldByName('NumMeioQuitPrevisto').Value;

      //showmessage(' field : ' + field);

      pA := Pos('A:', Field);
      pR := Pos('R:', Field);
      pL := Pos('L:', Field);

      // Alex 09/30/2015
      (*
      // Antonio 09/30/2015
      pM := pos(' M:', field);
      pE := pos(' E:', field);
      pD := pos(' D:', field);
      pT := pos(' T:', field);
      pC := pos(' C:', field);
      pP := pos(' P:', field);
      pAid: pos(' AID:', field);
      pTvr := pos(' TVR:', field);
      pIad := pos(' IAD:', field);
      pTsi := pos(' TSI:', field);
      pArc := pos(' ARC:', field);
      pCVM := pos(' CVM:', field);
      *)

      FAuthorization := copy(Field, pA+2, pR-1);
      FTroutD        := copy(Field, pR+2, pL-1);
      FLastDigits    := copy(Field, pL+2, pM-1);// Length(Field)) was replaced to pM-1;

      // Antonio 09/30/2015
      FMerchantID := copy(field, pM+2, pE-1);
      FEntryMethod := copy(field, pE+2, pD-1);
      FDate := copy(field, pD+2, pT-1);
      FTime := copy(field, pT+2, pC-1);
      FAppLabel := copy(field, pP+2, pAid-1);

  end;


  FTraceControl.TraceOut;
end;

function TPaymentCard.GetAutoProcess: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.GetAutoProcess');
  //amfsouza
  Result := ( FProcessorType <> 0 ) and ( FProcessorType <> 3 );

  FTraceControl.TraceOut;
end;

constructor TPaymentCard.Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl);
var
   buildInfo: String;
begin
  inherited Create(AADOConnection, ATraceControl);
  with TRegistry.Create do
  try
    if ( getOS(buildInfo) = osW7 ) then
       RootKey := HKEY_CURRENT_USER
    else
       RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REGISTRY_PATH, True);
    FProcessorType := ReadInteger('ProcessorType');
    fProcessingType := readInteger('ProcessType');

    FRemovePaymentWhenDeleting := False; // Alex 10/05/2015

  finally
    Free;
  end;
end;

function TPaymentCard.ExecutePCCharge: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecutePCCharge');

  Result := PCCResult;

  FTraceControl.TraceOut;
end;

function TPaymentCard.CanDelete: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.CanDelete');

  Result := True; // Alex 10/05/2015 False;

  FTraceControl.TraceOut;
end;

function TPaymentCard.DoMercury: Boolean;
begin
  Result := False;

  Result := ExecuteMercury;

  if Result then
  begin
    FAuthorization := processResult.AuthCode;
    FTroutD        := processResult.RefNo;
    FLastDigits    := processResult.LastDigits;
  end;

  FTraceControl.TraceOut;

end;

function TPaymentCard.ExecuteMercury: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecuteMercury');

  Result := MercuryResult;

  FTraceControl.TraceOut;
end;

function TPaymentCard.MercuryResult: Boolean;
var
  sMsg: String;
  sMsg2 : String;
begin
  FTraceControl.TraceIn(Self.ClassName + '.MercuryResult');
  Result := False;

  sMsg  := '';
  sMsg2 := '';

  try
    if FMercuryWidget <> nil then
    begin
      processResult := FMercuryWidget.getActiveTransaction();
      sMsg2 := ReturnErrorMsg(FMercuryWidget.ErrorCode);

      case processResult.TransactionReturn of
        ttrSuccessfull:
        begin
          Result := True;
          sMsg := Format('%S'#13#10'Auth: %S'#13#10'RefNumber: %S'#13#10'RefDataD: %S',
             [processResult.Msg, processResult.ResultAuth,
              processResult.ResultRefNo, processResult.ResultAcqRefData]);
        end;

        ttrNotSuccessfull:
        begin
          sMsg := Format('%S'#13#10'Reason: %S', [processResult.Msg, processResult.ResultAuth]) + sMsg2;
          raise Exception.Create(sMsg);
        end;

        ttrError:
        begin
          sMsg := Format(#13#10'Error: %S', [processResult.Msg]) + sMsg2;
          raise Exception.Create(sMsg);
        end;

        ttrException:
        begin
          sMsg := Format(''#13#10'Error: %S', [processResult.Msg + ' ' + FErrorMsg]);
          raise Exception.Create(sMsg);
        end;
      end;
    end;

  except
    FErrorMsg := sMsg;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentCard.NeedTroutD(Sender: TObject; var ATrouD,
  ARefNo, AAuthCode: WideString; var ACanceled: Boolean);
var
  PCV: TfrmPCVoid;
begin
  PCV := TfrmPCVoid.Create(nil);
  try
    ARefNo    := IntToStr(RefundID);
    ACanceled := not PCV.Start(PaymentValue, ATrouD, ARefNo, AAuthCode, FRefundCardInt);
  finally
    PCV.Free;
  end;
end;

function TPaymentCard.GetRefundInfo : Boolean;
var
  sResult : String;
  cInvoicePayment : Currency;
begin

  FTraceControl.TraceIn(Self.ClassName + '.GetRefundInfo');

  with TADODataSet.Create(nil) do
  try
    try
      Connection := FADOConnection;
      CommandText := 'SELECT NumMeioQuitPrevisto, ValorNominal FROM Fin_Lancamento WHERE IDPreSale = :IDPreSale';
      Parameters.ParamByName('IDPreSale').Value := RefundID;
      Open;
      Result := not IsEmpty;

      if Result then
      begin
        if not Assigned(FRefundCardInt) then
          FRefundCardInt := TStringList.Create;
        FRefundCardInt.Clear;
        cInvoicePayment := 0;
        First;
        while not EOF do
        begin
          FRefundCardInt.Add(FieldByName('NumMeioQuitPrevisto').AsString);
          cInvoicePayment := cInvoicePayment + FieldByName('ValorNominal').AsCurrency;
          Next;
        end;

        if ABS(FPaymentValue) <> ABS(cInvoicePayment) then
          Result := False;
      end;

      Close;
    finally
      Free;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ErrorMsg := E.Message;
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TPaymentCard.VoidSaleTransation: Boolean;
begin
  Result := (FRefundID <> 0) and (FPaymentValue < 0) and (DaysBetween(Trunc(PaymentDate), Trunc(FRefundDate)) = 0) and GetRefundInfo;
end;

function TPaymentCard.ReturnErrorMsg(AIDError: String): String;
begin

  if (AIDError = '1') or (AIDError = '2') then
    Result := Format(#13#10'%S'#13#10'%S'#13#10'%S', ['Visa/MasterCard: 800-944-1111', 'Amex: 800-528-2121', 'Discover: 800-347-1111'])
  else
    Result := '';

end;

function TPaymentCard.getPaymentCard(arg_processor, arg_paymentType: Integer): TCCWidget;
begin
    case (arg_paymentType) of
     PAYMENT_TYPE_CREDIT: begin
       result := TCCredit.Create();
     end;

     PAYMENT_TYPE_DEBIT: begin
       result := TCDebit.Create();
     end;

     PAYMENT_TYPE_GIFTCARD: begin
       result := TCPrePaid.Create();
     end;

   end;

end;

procedure TPaymentCard.printDeclinedReceipt;
var
  receipt: TPrintReceiptDeclined;
  dataField : String;
  sql: TSTringList;
begin
  try
     sql := TStringList.Create;
     sql.Add('select ' + QuotedStr(processResult.MerchantID)   + 'as MerchantID');
     sql.add(', ' + QuotedStr(processResult.LastDigits)        + ' as LastDigit');
     sql.Add(', ' + QuotedStr(processResult.CardType)          + ' as CardType');
     sql.add(', ' + QuotedStr(processResult.InvoiceNo)         + ' as Invoice');
     sql.add(', ' + QuotedStr(floatToStr(processResult.Purchase))         + ' as Amount');
     sql.Add(', ' + QuotedStr( processResult.DeclinedDateTime) + ' as SaleDateTime');
     sql.add(', ' + QuotedStr(processResult.EntryMethod)       + ' as EntryMethod');

     dataField :=
      'A:'  + FAuthorization +
      ' R:' + FTroutD +
      ' L:' + FLastDigits +
      ' M:' + FMerchantID +
      ' E:' + FEntryMethod +
      ' D:' + FDate +
      ' T:' + FTime +
      ' C:' + 'chip' +
      ' P:' + FAppLabel +
      ' AID:' + FAID +
      ' TVR:' + FTVR +
      ' IAD:' + FIAD +
      ' TSI:' + FTSI +
      ' ARC:' + FARC +
      ' CVM:' + FCVM+
      ' TC:'+ FAppLabelTranCode;

     sql.add(', ' + QuotedStr( dataField ) + ' as NumMeioQuitPrevisto');

     sql.add('from Sys_Module');

     receipt := TPrintReceiptDeclined.Create(nil);
     receipt.start(FIDPreSale, RECEIPT_TYPE_DECLINED, sql.GetText);
  finally
     freeAndNil(receipt);
     freeAndNil(sql);
  end;
end;

procedure TPaymentCard.BeforeDeletePayment;
var
   processAproved: Boolean;
   oldPaymentValue : Currency;
begin
  processAproved := false;

  if ( processResult is TCCreditDSIEMVx ) then begin
       if ( FPaymentValue > 0 ) then begin
          TCCreditDSIEMVx(processResult).FIsSale := False;
          processAproved := TCCreditDSIEMVx(processResult).VoidSale();
       end else if ( FPaymentValue < 0 ) then begin
                processAproved := TCCreditDSIEMVx(processResult).VoidReturn();
           end;

  end else if ( processResult is TCCreditDSIPDCx ) then begin
               if ( FPaymentValue > 0 ) then begin
                  processAproved := TCCreditDSIPDCx(processResult).VoidSale();
               end else if ( FPaymentValue < 0 ) then begin
                        processAproved := TCCreditDSIPDCx(processResult).VoidReturn();
                   end;
           end;

  if ( processAproved ) then begin
      MoveValues();
      FPaymentValue := (-1) * FPaymentValue;
      InsertPayment();
  end;

  inherited;
end;

{ TPaymentDebitCard }

procedure TPaymentDebitCard.BeforeProcessPayment;
begin
  inherited;

end;

function TPaymentDebitCard.ExecuteMercury: Boolean;
begin

  FTraceControl.TraceIn(Self.ClassName + '.ExecuteMercuryDebitCard');

  if not Assigned(FMercuryWidget) then begin
    FMercuryWidget := getPaymentCard(fProcessorType, PAYMENT_TYPE_DEBIT);
  end;

  with TCDebit(FMercuryWidget) do
  begin
    //Manual entry card
    OnNeedSwipe          := NeedSwipe;
    AfterSucessfullSwipe := AfterSucessfullSwipe;
    if VoidSaleTransation then
      OnNeedTroutD       := NeedTroutD
    else
      OnNeedTroutD       := nil;

    FPinPad.FBaudRate   := Self.FPinPad.Baud;

    FPinPad.FComPort    := Self.FPinPad.Comm;

    FPinPad.FTimeout    := StrToInt(Self.FPinPad.TimeOut);

    Memo                := PaymentMemo;
    OperatorID          := IntToStr(FIDUser);
    InvoiceNo           := getTicketNumber;

    RefNo               := FMercuryWidget.InvoiceNo;

    Purchase            := FPaymentValue;

    FCashBack            := 0;  // see this field

    Track2              := CardSwiped;

    TCDebit(FMercuryWidget).setDebitDevice(FProcessorType, fProcessingType);
    processResult := getActiveTransaction();

    processResult.OnNeedSwipe := NeedSwipe;
    processResult.FCardSwiped := CardSwiped;

    if (FPaymentValue > 0) then begin
      ProcessSale;
    end
    else begin
      ProcessReturn;
    end;
  end;

  Result := inherited ExecuteMercury;

  FTraceControl.TraceOut;
end;

function TPaymentDebitCard.ExecutePCCharge: Boolean;
var
  iAction: Integer;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecutePCCharge');

  if (FPaymentValue > 0) then
    iAction := DEBIT_SALE
  else
    iAction := DEBIT_RETURN;

  if not FPCCT.RetailDebitCardPresent(MyFormatCur(Abs(FPaymentValue), '.'), '0.00', getTicketNumber, CardSwiped, iAction) then
    FErrorMsg := FPCCT.ErrorDesc;

  Result := inherited ExecutePCCharge;

  FTraceControl.TraceOut;
end;

function TPaymentDebitCard.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_DEBIT;
end;

procedure TPaymentDebitCard.PreparePCC;
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName + '.PreparePCC');

  FPCCT.PinTimeOut       := StrToIntDef(FPinPad.TimeOut, 0);
  FPCCT.PinEncryptMethod := StrToIntDef(FPinPad.EncryptMethod, 0);
  FPCCT.PinDevice        := StrToIntDef(FPinPad.GetDevice, 0);
  FPCCT.PinBaud          := FPinPad.Baud;
  FPCCT.PinDataBits      := FPinPad.DataBits;
  FPCCT.PinParity        := FPinPad.Parity;
  FPCCT.PinComm          := FPinPad.Comm;

  FTraceControl.TraceOut;
end;

{ TPaymentCreditCard }

function TPaymentCreditCard.ExecutePCCharge: Boolean;
var
  iMsgResult: Integer;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecutePCCharge');

  if CardSwiped = '' then
    iMsgResult := MsgBox('Is the customer card present?_Total to be proccessed: ' + FormatCurr('#,##0.00', FPaymentValue), vbYesNoCancel)
  else
    iMsgResult := vbYes;

  case iMsgResult of
    vbYes:    Result := ExecutePCChargeWithCard;
    vbNo:     Result := ExecutePCChargeNoCard;
    vbCancel: FErrorMsg := 'Canceled.';
  end;

  Result := inherited ExecutePCCharge;

  FTraceControl.TraceOut;
end;

function TPaymentCreditCard.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_CARD;
end;

function TPaymentCreditCard.ExecutePCChargeNoCard: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecutePCChargeNoCard');

  with TfrmPCCharge.Create(nil) do
  try
    Result := Start(FPCCT, getTicketNumber, FPaymentValue);
    if not Result then
      FErrorMsg := 'Canceled by user.';
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;


function TPaymentCreditCard.ExecutePCChargeWithCard: Boolean;
begin

  FTraceControl.TraceIn(Self.ClassName + '.ExecutePCChargeWithCard');

  Result := FPCCT.RetailCreditOrAutorizationCardPresent(MyFormatCur(Abs(FPaymentValue), '.'), getTicketNumber, CardSwiped, FPaymentValue < 0);

  if not Result then
    FErrorMsg := FPCCT.ErrorDesc;

  FTraceControl.TraceOut;

end;

function TPaymentCreditCard.ExecuteMercury: Boolean;
var
  iMsgResult: Integer;
begin

  case ( fProcessingType ) of
      PROCESSING_TYPE_DSICLIENTX: begin
          if CardSwiped = '' then
            iMsgResult := MsgBox('Is the customer card present?_Total to be proccessed: ' + FormatCurr('#,##0.00', FPaymentValue), vbYesNoCancel)
          else
            iMsgResult := vbYes;

          case iMsgResult of
            vbYes:    Result := ExecuteMercuryWithCard;
            vbNo:     Result := ExecuteMercuryNoCard;
            vbCancel: FErrorMsg := 'Canceled.';
          end;
      end;

      PROCESSING_TYPE_DSIPDCX, PROCESSING_TYPE_DSIEMVUS: begin
      	result := ExecuteMercuryWithCard;
      end;

      else begin
      	raise Exception.Create('Dsi Device not found. See Client Parameter settings');
      end;
  end;

  Result := inherited ExecuteMercury;

  FTraceControl.TraceOut;
end;

function TPaymentCreditCard.ExecuteMercuryNoCard: Boolean;
var
  sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2 : String;
begin
  with TfrmPCCharge.Create(nil) do
  try
    Result := StartMercury(sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2);
    if Result then
    begin

      if not Assigned(FMercuryWidget) then begin
        FMercuryWidget := getPaymentCard(fProcessorType, PAYMENT_TYPE_CREDIT);
      end;

      with TCCredit(FMercuryWidget) do
      begin
        //Manual entry card
        OnNeedSwipe          := nil;
        AfterSucessfullSwipe := nil;

        if VoidSaleTransation then
          OnNeedTroutD       := NeedTroutD
        else
          OnNeedTroutD       := nil;

        Memo                := PaymentMemo;
        OperatorID          := IntToStr(FIDUser);
        InvoiceNo           := getTicketNumber;
        RefNo               := FMercuryWidget.InvoiceNo;
        Purchase            := FPaymentValue;
        Tax                 := 0;

        AcctNo              := sCardNumber;
        ExpDate             := sExpireDate;

        Address             := sStreetAddress;
        Zip                 := sZipCode;
        CustomerCode        := sMemberName;

        Track2              := '';
        CVVData             := sCVV2;

        TCCredit(FMercuryWidget).setCreditDevice(fProcessorType, fProcessingType);

        if (FPaymentValue > 0) then begin
          ProcessSale;
        end
        else
          if VoidSaleTransation then begin
            VoidSale
          end
          else begin
            ProcessReturn;
          end
      end;

    end
    else
      FErrorMsg := 'Canceled by user.';
  finally
    Free;
  end;

  FTraceControl.TraceOut;

end;

function TPaymentCreditCard.ExecuteMercuryWithCard: Boolean;
begin
  if not Assigned(FMercuryWidget) then
    FMercuryWidget := getPaymentCard(fProcessorType, PAYMENT_TYPE_CREDIT);

  with TCCredit(FMercuryWidget) do
  begin
    AfterSucessfullSwipe := AfterSucessfullSwipe;

    if VoidSaleTransation then
      OnNeedTroutD       := NeedTroutD
    else
      OnNeedTroutD       := nil;

    Memo                := PaymentMemo;
    OperatorID          := IntToStr(FIDUser);
    InvoiceNo           := getTicketNumber;
    RefNo               := FMercuryWidget.InvoiceNo;
    Purchase            := FPaymentValue;
    Tax                 := 0;
    FCardSwiped          := CardSwiped;

    TCCredit(FMercuryWidget).setCreditDevice(fProcessorType, fProcessingType);

    processResult := getActiveTransaction();
    processResult.OnNeedSwipe := NeedSwipe;
    ProcessResult.FCardSwiped := CardSwiped;

    if (FPaymentValue > 0) then
      ProcessSale
    else
      if VoidSaleTransation then begin
        VoidSale;
      end
      else
        ProcessReturn;
  end;

  FTraceControl.TraceOut;

end;

procedure TPaymentCreditCard.BeforeProcessPayment;
begin
  inherited;

end;

{ TPaymentPrePaid }

procedure TPaymentPrePaid.BeforeProcessPayment;
begin
  inherited;

end;

constructor TPaymentPrePaid.Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl);
begin
  inherited Create(AADOConnection, ATraceControl);

end;

function TPaymentPrePaid.ExecuteMercury: Boolean;
var
  iMsgResult: Integer;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecuteMercury');

  if CardSwiped = '' then
    iMsgResult := MsgBox('Is the customer card present?_Total to be proccessed: ' + FormatCurr('#,##0.00', FPaymentValue), vbYesNoCancel)
  else
    iMsgResult := vbYes;

  case iMsgResult of
    vbYes:    Result := ExecuteMercuryWithCard;
    vbNo:     Result := ExecuteMercuryNoCard;
    vbCancel: FErrorMsg := 'Canceled.';
  end;

  Result := inherited ExecuteMercury;

  FTraceControl.TraceOut;
end;

function TPaymentPrePaid.ExecuteMercuryNoCard: Boolean;
var
  sCardNumber, sMemberName, sExpireDate, sStreetAddress, sZipCode, sCVV2 : String;
begin

  FTraceControl.TraceIn(Self.ClassName + '.ExecuteMercuryNoCard');

  with TCardNumberDlgView.Create(nil) do
  try
    if not Assigned(FMercuryWidget) then
       FMercuryWidget := getPaymentCard(FProcessorType, PAYMENT_TYPE_GIFTCARD);

    setMercuryObject(FMercuryWidget);

    Result := Start(sCardNumber);
    if Result then
    begin

      if not Assigned(FMercuryWidget) then
        FMercuryWidget := getPaymentCard(FProcessorType, PAYMENT_TYPE_GIFTCARD);

      with TCPrePaid(FMercuryWidget) do
      begin
        //Manual entry card
        OnNeedSwipe          := nil;
        AfterSucessfullSwipe := nil;

        if VoidSaleTransation then
          OnNeedTroutD       := NeedTroutD
        else
          OnNeedTroutD       := nil;

        Memo                := PaymentMemo;
        OperatorID          := IntToStr(FIDUser);
        InvoiceNo           := getTicketNumber;
        RefNo               := FMercuryWidget.InvoiceNo;
        Purchase            := FPaymentValue;
        Tax                 := 0;

        AcctNo              := sCardNumber;
        ExpDate             := sExpireDate;

        Address             := sStreetAddress;
        Zip                 := sZipCode;
        CustomerCode        := sMemberName;

        Track2              := '';
        CVVData             := sCVV2;

        TCPrepaid(FMercuryWidget).setCreditDevice(FProcessorType, fProcessingType);

        if (FPaymentValue > 0) then
          prePaidNoNSFSale
//        else
//          if VoidSaleTransation then
//            VoidSale
          else
            ProcessReturn;
      end;

    end
    else
      FErrorMsg := 'Canceled by user.';
  finally
    Free;
  end;

  FTraceControl.TraceOut;

end;

function TPaymentPrePaid.ExecuteMercuryWithCard: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ExecuteMercuryWithCard');

  if not Assigned(FMercuryWidget) then
    FMercuryWidget := getPaymentCard(FProcessorType, PAYMENT_TYPE_GIFTCARD);

  with TCPrePaid(FMercuryWidget) do
  begin
    OnNeedSwipe          := NeedSwipe;
    AfterSucessfullSwipe := AfterSucessfullSwipe;

    if VoidSaleTransation then
      OnNeedTroutD       := NeedTroutD
    else
      OnNeedTroutD       := nil;

    Memo                := PaymentMemo;
    OperatorID          := IntToStr(FIDUser);
    InvoiceNo           := getTicketNumber;
    RefNo               := FMercuryWidget.InvoiceNo;
    Purchase            := FPaymentValue;
    Tax                 := 0;
    CardSwiped          := CardSwiped;

    TCPrePaid(FMercuryWidget).setCreditDevice(fProcessorType, fProcessingType);

    processResult := getActiveTransaction();
    processResult.OnNeedSwipe := NeedSwipe;
    ProcessResult.FCardSwiped := CardSwiped;

    if (FPaymentValue > 0) then
      ProcessSale
    else
      if VoidSaleTransation then begin
        VoidSale;
          (* amfsouza 09.26.2011-debug *)FTraceControl.SaveTrace(FIdUser, 'Debug-Step VoidSale ( Credit Card) - Value: ' + CurrToStr(FPaymentValue), '(PII):'+ self.ClassName);
      end
      else
        ProcessReturn();
  end;

  FTraceControl.TraceOut;

end;

function TPaymentPrePaid.getCardNumber: Boolean;
begin
  result := false;

  if not Assigned(FMercuryWidget) then
    FMercuryWidget := getPaymentCard(FProcessorType, PAYMENT_TYPE_GIFTCARD);

  with TCPrePaid(FMercuryWidget) do
  begin
    OnNeedSwipe          := NeedSwipe;
    AfterSucessfullSwipe := AfterSucessfullSwipe;

    if VoidSaleTransation then
      OnNeedTroutD       := NeedTroutD
    else
      OnNeedTroutD       := nil;

    Memo                := PaymentMemo;
    OperatorID          := IntToStr(FIDUser);
    InvoiceNo           := getTicketNumber;
    RefNo               := FMercuryWidget.InvoiceNo;
    Purchase            := FPaymentValue;
    Tax                 := 0;
    CardSwiped          := CardSwiped;
    
    result := ( FCardSwiped <> '' );  
  end;
end;

function TPaymentPrePaid.getPaymentType: Integer;
begin
// 3
end;

end.
