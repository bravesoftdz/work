unit uPCCIntegration;

interface

uses Classes, SysUtils, StrUtils, PSCharge_TLB, ActiveX, uMsgBox, Forms, Debit_TLB,
     Device_TLB, Dialogs, uFrmPCCEnterPin, IniFiles, SC550_TLB, uCreditCardFunction;

Const
  DEBIT_SALE        = 41;
  DEBIT_RETURN      = 42;
  PCC_ERROR_TIMEOUT = 6;


type
  TPCCTransaction = class(TComponent)
  private
    FTimeOut: Integer;
    FUser: WideString;
    FLastValidDate: WideString;
    FPrintReceipts: WideString;
    FMulti: WideString;
    FPath: WideString;
    FProcessor: WideString;
    FMerchantNumber: WideString;
    FAuth: WideString;
    FRefNumber: WideString;
    FTroutD: WideString;
    FErrorCode: Integer;
    FErrorDesc: WideString;
    FPCCResult: WideString;
    FTransactionReturn: TTransactionReturn;
    FOnNeedSwipe: TNeedSwipeEvent;
    FAfterSucessfullSwipe: TAfterSucessfullSwipe;
    FAVS: WideString;
    FCVV2Ver: WideString;
    FPort: Integer;
    FIPAddress: WideString;
    FOnNeedTroutD: TNeedTroutDEvent;
    FLastDigits: WideString;

    fPinTimeOut: Integer;
    fPinEncryptMethod: Integer;
    fPinDevice: Integer;
    fPinBaud: WideString;
    fPinDataBits: WideString;
    fPinParity: WideString;
    fPinComm: WideString;

    function CreateCharge(ACommand: WideString): TCharge;
    function ProccesCharge(ACharge: TCharge; AFileType: TOleEnum): Boolean;
    procedure ResetResultCodes;
    function CreateDevice : TOCXDevice;

    function CreateDebit(AAction : Integer; ACommand: WideString) : TOCXDebit;
    function ProccesDebit(ADebit: TOCXDebit; AFileType: TOleEnum): Boolean;

    function FormatPCChargeError(PCError:String):String;

    function CreditTransactionError(ACharge: TCharge) : Boolean;
    function DebitTransactionError(ADebit: TOCXDebit) : Boolean;

    function CreditTransactionAlreadyCharged(ACharge: TCharge; AFileType : TOleEnum) : Boolean;
    function DebitTransactionAlreadyCharged(ADebit: TOCXDebit; AFileType : TOleEnum) : Boolean;
    function ErrorFileExist : Boolean;
  public
    property Path:           WideString read FPath           write FPath;
    property User:           WideString read FUser           write FUser;
    property Processor:      WideString read FProcessor      write FProcessor;
    property MerchantNumber: WideString read FMerchantNumber write FMerchantNumber;
    property TimeOut:        Integer    read FTimeOut        write FTimeOut;
    property Multi:          WideString read FMulti          write FMulti;
    property LastValidDate:  WideString read FLastValidDate  write FLastValidDate;
    property PrintReceipts:  WideString read FPrintReceipts  write FPrintReceipts;
    property Port:           Integer    read FPort           write FPort;
    property IPAddress:      WideString read FIPAddress      write FIPAddress;

    //PinPad
    property PinDevice        : Integer    read fPinDevice        write fPinDevice;
    property PinEncryptMethod : Integer    read fPinEncryptMethod write fPinEncryptMethod;
    property PinTimeOut       : Integer    read fPinTimeOut       write fPinTimeOut;
    property PinBaud          : WideString read fPinBaud          write fPinBaud;
    property PinParity        : WideString read fPinParity        write fPinParity;
    property PinComm          : WideString read fPinComm          write fPinComm;
    property PinDataBits      : WideString read fPinDataBits      write fPinDataBits;

    // Retornos
    property Auth: WideString           read FAuth           write FAuth;
    property RefNumber: WideString      read FRefNumber      write FRefNumber;
    property TroutD: WideString         read FTroutD         write FTroutD;
    property PCCResult: WideString      read FPCCResult      write FPCCResult;
    property ErrorCode: Integer         read FErrorCode      write FErrorCode;
    property ErrorDesc: WideString      read FErrorDesc      write FErrorDesc;
    property AVS:       WideString      read FAVS            write FAVS;
    property CVV2Ver:   WideString      read FCVV2Ver        write FCVV2Ver;
    property LastDigits: WideString     read FLastDigits     write FLastDigits;

    property TransactionReturn: TTransactionReturn read FTransactionReturn write FTransactionReturn;


    property OnNeedSwipe: TNeedSwipeEvent read FOnNeedSwipe write FOnNeedSwipe;
    property AfterSucessfullSwipe: TAfterSucessfullSwipe read FAfterSucessfullSwipe write FAfterSucessfullSwipe;
    property OnNeedTroutD: TNeedTroutDEvent read FOnNeedTroutD write FOnNeedTroutD;

    constructor Create(AOwner: TComponent); override;

    function RetailCreditOrAutorizationCardPresent(AAmount, ATicket, ACardSwiped: WideString; ARefund: Boolean): Boolean;
    function RetailCreditOrAutorizationCardNotPresent(ACard, AMember, AExpDate, AAmount, ATicket, AStreet, AZip, ACVV2: WideString; ARefund: Boolean): Boolean;
    function RetailVoidSale: Boolean;

    //Debit
    function RetailDebitCardPresent(AAmount, ACashBack, ATicket, ACardSwiped: WideString; AAction: Integer): Boolean;
  end;

implementation

uses uFrmPCCWaitTransaction, OleCtrls, uNumericFunctions, uPCCRecords,
     uFileFunctions;



{ TPCCTransaction }

function TPCCTransaction.CreateCharge(ACommand: WideString): TCharge;
var
  oleCommMet: TOleEnum;
begin
  Result := TCharge.Create(Self);
  Result.Command        := ACommand;
  Result.Path           := FPath;
  Result.User           := FUser;
  Result.Processor      := FProcessor;
  Result.MerchantNumber := FMerchantNumber;


  // Set Optional Initial Properties
  Result.TimeOut        := FTimeOut;
  Result.Multi          := FMulti;
  Result.LastValidDate  := FLastValidDate;
  Result.PrintReceipts  := FPrintReceipts;
  Result.Port           := FPort;
  Result.IPAddress      := FIPAddress;
  Result.EnableSSL      := False;
  Result.XMLTrans       := True;

  if (FPort <> 0) and (FIPAddress <> '') then
    oleCommMet := TCPIP
  else
    oleCommMet := File_Transfer;

  Result.CommMethod  := oleCommMet;

  FLastDigits := '';
end;

function TPCCTransaction.RetailCreditOrAutorizationCardPresent(AAmount, ATicket, ACardSwiped: WideString; ARefund: Boolean): Boolean;
var
  ACharge: TCharge;
  AFileType: TOleEnum;
  ASwipedTrack: WideString;
  ASwipeCanceled, ASwipeError: Boolean;
  AType: WideString;
  frmWait: TFrmPCCWaitTransaction;
  ATrouD: WideString;
  ATroudCanceled: Boolean;
begin
  Result := False;
  try
    ResetResultCodes;
    AFileType   := 3;

    if ARefund then
      AType := '2'
    else
      AType := '1';

    ACharge := CreateCharge(AType);
    try

      if (ACharge.CommMethod = File_Transfer) and ACharge.PccSysExists then
        raise Exception.Create('PC Charge is not Running / Ready');

      ACharge.Amount      := AAmount;
      ACharge.Ticket      := ATicket;

      ACharge.Manual      := 1;
      ACharge.CardPresent := '1';


      // Here we call an event in order to swipe the card
      if Assigned(FOnNeedSwipe) then
      begin
        repeat
          ASwipeCanceled := False;
          ASwipeError    := False;

          if ACardSwiped = '' then
            FOnNeedSwipe(Self, ASwipedTrack, ASwipeCanceled)
          else
            ASwipedTrack := ACardSwiped;

          if ASwipedTrack = '' then
            ASwipeCanceled := True;

          try
            ACharge.GetParseData(ASwipedTrack);
            ACharge.Track := CopyLevelIIData(ASwipedTrack);
          except
            ASwipeError    := True;
            raise Exception.Create('Card track not recognized');
          end;

          if ASwipeCanceled then
            raise Exception.Create('Card Swipe canceled by user');

        until not (ASwipeCanceled or ASwipeError)
      end;

      if Assigned(FAfterSucessfullSwipe) then
        FAfterSucessfullSwipe(Self, ACharge.Card, ACharge.Member, ACharge.ExpDate);


      (*

      // Here we call an event in inform the ATrouD
      if ARefund then
        if Assigned(FOnNeedTroutD) then
        begin
          ATroudCanceled := False;
          ATrouD         := '';
          FOnNeedTroutD(Self, ATrouD, ATroudCanceled);
          if ATroudCanceled then
            raise Exception.Create('Canceled by user');
          ACharge.TroutD := ATrouD;
        end;

      *)

      // Show the wait form until Transaction is processed
      frmWait := TFrmPCCWaitTransaction.Create(nil);
      try
        frmWait.Show;
        Application.ProcessMessages;
        Result := ProccesCharge(ACharge, AFileType);
      finally
        frmWait.Close;
        frmWait.Free;
      end;

    finally
      ACharge.DeleteUserFiles;
      ACharge.Free;
    end;
  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      FErrorDesc := E.Message;
      //MsgBox(E.Message, vbOKOnly + vbCritical);
    end;
  end;
end;

function TPCCTransaction.ProccesCharge(ACharge: TCharge; AFileType: TOleEnum): Boolean;
var
  FTransactionCharged : Boolean;
begin
  Result := False;
  FTransactionCharged := False;
  ResetResultCodes;

  if ACharge.CheckCard then
  begin
    if not ACharge.VerifyCreditCard(ACharge.Card) then
      raise Exception.Create('Invalid Account !');

    if not ACharge.VerifyExpDate then
      raise Exception.Create('Invalid Expire Date !');

    if not ACharge.VerifyAmount then
      raise Exception.Create('Invalid Amount !');
  end;

  //Verifica se a transacao ja foi aprovada
  if ErrorFileExist then
    FTransactionCharged := CreditTransactionAlreadyCharged(ACharge, AFileType);

  if not FTransactionCharged then
  begin
    ACharge.Send(AFileType);

    FPCCResult := ACharge.GetResult;
    FErrorCode := ACharge.GetErrorCode;
  end;

  if FErrorCode = 0 then
  begin
    if (FPCCresult = 'CAPTURED') or (FPCCresult = 'APPROVED') or (FPCCresult = 'VOIDED') or (FPCCresult = 'PROCESSED') then
      begin

        if not FTransactionCharged then
        begin
          FAuth      := ACharge.GetAuth;
          FRefNumber := ACharge.GetRefnumber;
          FTroutD    := ACharge.GetTroutD;
        end;

        FLastDigits := Copy(Trim(ACharge.Card), Length(Trim(ACharge.Card)) - 3, 4);

        Result := True;

        FTransactionReturn := ttrSuccessfull;
      end
    else
      if (FPCCresult = 'NOT CAPTURED') or (FPCCresult = 'NOT APPROVED') or (FPCCresult = 'CANCELED') or (FPCCresult = 'Error') or (FPCCresult = 'NOT PROCESSED') then
        begin
          FAuth              := FormatPCChargeError(ACharge.GetAuth);
          FTransactionReturn := ttrNotSuccessfull;

          if ACharge.CVV2 <> '' then
            FCVV2Ver := ACharge.GetCVV2;

          if (ACharge.Street <> '') or (ACharge.Zip <> '') then
            FAVS := ACharge.GetAVS;
       end;
  end
    else
    begin
      FErrorDesc         := ACharge.GetErrorDesc;
      FTransactionReturn := ttrError;
      //Grava error
      if FErrorCode = PCC_ERROR_TIMEOUT then
        CreditTransactionError(ACharge);
    end;
end;

procedure TPCCTransaction.ResetResultCodes;
begin
    FPCCresult         := '';
    FAuth              := '';
    FRefNumber         := '';
    FTroutD            := '';
    FErrorCode         := 0;
    FErrorDesc         := '';
    FAVS               := '';
    FCVV2Ver           := '';

    FTransactionReturn := ttrException;
end;

function TPCCTransaction.RetailCreditOrAutorizationCardNotPresent(ACard,
  AMember, AExpDate, AAmount, ATicket, AStreet, AZip,
  ACVV2: WideString; ARefund: Boolean): Boolean;
var
  ACharge: TCharge;
  AFileType: TOleEnum;
  AType: WideString;
  frmWait: TFrmPCCWaitTransaction;
begin
  Result := False;

  try
    ResetResultCodes;
    AFileType   := 3;

    if ARefund then
      AType := '2'
    else
      AType := '1';

    ACharge := CreateCharge(AType);
    try
      if (ACharge.CommMethod = File_Transfer) and ACharge.PccSysExists then
        raise Exception.Create('PC Charge is not Running / Ready');

      ACharge.Card        := ACard;
      ACharge.Member      := AMember;
      ACharge.ExpDate     := AExpDate;
      ACharge.Amount      := AAmount;
      ACharge.Ticket      := ATicket;

      if AStreet <> '' then
        ACharge.Street      := AStreet;

      if AZip <> '' then
        ACharge.Zip         := AZip;

      if ACVV2 <> '' then
        ACharge.CVV2        := ACVV2;

      ACharge.Manual      := 0;
      ACharge.CardPresent := '0';

      Result := ProccesCharge(ACharge, AFileType);
    finally
      ACharge.DeleteUserFiles;
      ACharge.Free;
    end;
  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      FErrorDesc := E.Message;
      //MsgBox(E.Message, vbOKOnly + vbCritical);
    end;
  end;
end;

constructor TPCCTransaction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ResetResultCodes;
end;


function TPCCTransaction.RetailVoidSale: Boolean;
var
  ACharge: TCharge;
  AFileType: TOleEnum;
  ATrouD, AInvNo, AAuthCode: WideString;
  ATroudCanceled: Boolean;
begin
  Result := False;
  try
    ResetResultCodes;
    AFileType   := 3;

    ACharge := CreateCharge('3');
    try

      if ACharge.PccSysExists then
        raise Exception.Create('PC Charge is not Running / Ready');

      ACharge.CheckCard   := False;

      // Here we call an event in order to swipe the card
      if Assigned(FOnNeedTroutD) then
      begin
        ATroudCanceled := False;
        ATrouD         := '';
        FOnNeedTroutD(Self, ATrouD, AInvNo, AAuthCode, ATroudCanceled);
        if ATroudCanceled then
          raise Exception.Create('Canceled by user');
        ACharge.TroutD   := ATrouD;
        ACharge.Authcode := AAuthCode;
      end;

      Result := ProccesCharge(ACharge, AFileType);
    finally
      ACharge.DeleteUserFiles;
      ACharge.Free;
    end;
  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;

      MsgBox(E.Message, vbOKOnly + vbCritical);
    end;
  end;
end;

function TPCCTransaction.RetailDebitCardPresent(AAmount, ACashBack,
  ATicket, ACardSwiped: WideString; AAction: Integer): Boolean;
var
  ADebit: TOCXDebit;
  APinPad: TOCXDevice;
  AFileType: TOleEnum;
  ASwipedTrack: WideString;
  ASwipeCanceled, ASwipeError: Boolean;
  frmWait: TFrmPCCWaitTransaction;

  ACard, AName, ADate, ATrack2: WideString;

  AKSN, APIN : String;

  FrmPCCEnterPin : TFrmPCCEnterPin;

begin
  Result := False;
  try
    ResetResultCodes;
    AFileType   := 3;

    APinPad := CreateDevice;
    try
      if APinPad.Initialize(True) then
      begin
        ADebit := CreateDebit(AAction, '1');
        try

          if ADebit.PccSysExists then
            raise Exception.Create('PC Charge is not Running / Ready');

          // Here we call an event in order to swipe the card
          if Assigned(FOnNeedSwipe) then
          begin
            repeat
              ASwipeCanceled := False;
              ASwipeError    := False;

              if ACardSwiped = '' then
                FOnNeedSwipe(Self, ASwipedTrack, ASwipeCanceled)
              else
                ASwipedTrack := ACardSwiped;


              if ASwipedTrack = '' then
                ASwipeCanceled := True;

              try
                ParseTrack(ASwipedTrack ,ACard, AName, ADate, ATrack2);
              except
                ASwipeError    := True;
                raise Exception.Create('Card track not recognized');
              end;

              {
              ShowMessage('DEBIT: Swipe :' + ASwipedTrack );
              ShowMessage('DEBIT: Card :' + ACard);
              ShowMessage('DEBIT: Track :' + ATrack2);
              ShowMessage('DEBIT: ExpDate :' + ADate);
              ShowMessage('DEBIT: Name :' + AName);
              }
              if ASwipeCanceled then
                raise Exception.Create('Card Swipe canceled by user');

            APinPad.Amount := MyFormatCur((StrToCurr(AAmount) + StrToCurr(ACashBack)), '.');
            APinPad.Card   := ACard;

            FrmPCCEnterPin := TFrmPCCEnterPin.Create(Self);
            try
              FrmPCCEnterPin.Start;
              //Inicializa o PinPad
              APIN         := APinPad.GetPin;
              AKSN         := APinPad.GetKeySerialNumber;
            finally
              FrmPCCEnterPin.Close; 
              FreeAndNil(FrmPCCEnterPin);
              end;

            if APIN = '' then
              raise Exception.Create('PIN NOT Entered!');

            ADebit.Track           := ATrack2;
            ADebit.Pin             := APIN;
            ADebit.KeySerialNumber := AKSN;
            ADebit.ExpDate         := ADate;
            ADebit.Amount          := AAmount;
            ADebit.Ticket          := ATicket;
            ADebit.Member          := AName;
            ADebit.Card            := ACard;

            until not (ASwipeCanceled or ASwipeError)
          end;

          if Assigned(FAfterSucessfullSwipe) then
            FAfterSucessfullSwipe(Self, ADebit.Card, ADebit.Member, ADebit.ExpDate);

          // Show the wait form until Transaction is processed
          frmWait := TFrmPCCWaitTransaction.Create(nil);
          try
            frmWait.Show;
            Application.ProcessMessages;
            Result := ProccesDebit(ADebit, AFileType);
          finally
            frmWait.Close;
            frmWait.Free;
          end;


        finally
          ADebit.DeleteUserFiles;
          FreeAndNil(ADebit);
        end;
      end
      else
      begin
        raise Exception.Create('PinPad NOT Initialized. Aborted!_' +
                               IntToStr(APinPad.GetErrorCode) + ' - ' +
                               APinPad.GetErrorDesc);
      end;


    finally
      FreeAndNil(APinPad);
      end;
  except
    on E: Exception do
    begin
      FTransactionReturn := ttrException;
      Result := False;
      FErrorDesc := E.Message;
      //MsgBox(E.Message, vbOKOnly + vbCritical);
    end;
  end;
end;

function TPCCTransaction.CreateDevice: TOCXDevice;
begin
  Result := TOCXDevice.Create(Self);

  Result.Device        := PinDevice;
  Result.Baud          := PinBaud;
  Result.Parity        := PinParity;
  Result.DataBits      := PinDataBits;

  Result.TimeOut       := PinTimeOut;

  Result.EncryptMethod := PinEncryptMethod;
  Result.Port          := PinComm;

end;

function TPCCTransaction.CreateDebit(AAction: Integer; ACommand: WideString): TOCXDebit;
var
  oleCommMet: TOleEnum;
begin

  Result := TOCXDebit.Create(Self);

  //Result.Action         := AAction;
  Result.User           := FUser;
  Result.Manual         := True;
  Result.Processor      := FProcessor;
  Result.MerchantNumber := FMerchantNumber;
  Result.Path           := FPath;
  Result.TimeOut        := FTimeOut;

  Result.Command        := IntToStr(AAction);

  Result.IPAddress      := FIPAddress;
  Result.Port           := FPort;
  Result.EnableSSL      := False;

  if (FPort <> 0) and (FIPAddress <> '') then
    oleCommMet := TCPIP
  else
    oleCommMet := File_Transfer;

  Result.CommMethod  := oleCommMet;
  
end;

function TPCCTransaction.ProccesDebit(ADebit: TOCXDebit;
  AFileType: TOleEnum): Boolean;
var
  FTransactionCharged : Boolean;
begin

  Result := False;
  FTransactionCharged := False;
  ResetResultCodes;

  {
  if ACharge.CheckCard then
  begin
    if not ACharge.VerifyCreditCard(ACharge.Card) then
      raise Exception.Create('Invalid Account !');
    if not ACharge.VerifyExpDate then
      raise Exception.Create('Invalid Expire Date !');
  end;}

  if not ADebit.VerifyAmount then
    raise Exception.Create('Invalid Amount !');

  //Verifica se a transacao ja foi aprovada
  if ErrorFileExist then
    FTransactionCharged := DebitTransactionAlreadyCharged(ADebit, AFileType);

  if not FTransactionCharged then
  begin
    ADebit.Send(AFileType);
    FPCCResult := ADebit.GetResult;
    FErrorCode := ADebit.GetErrorCode;
  end;

  if FErrorCode = 0 then
  begin
    if (FPCCresult = 'CAPTURED') or (FPCCresult = 'APPROVED') or (FPCCresult = 'VOIDED') or (FPCCresult = 'PROCESSED') then
    begin
    
      if not FTransactionCharged then
      begin
        FAuth      := ADebit.GetAuth;
        FRefNumber := ADebit.GetRefnumber;
        FTroutD    := ADebit.GetTroutD;
      end;

      FLastDigits := Copy(Trim(ADebit.Card), Length(Trim(ADebit.Card)) - 3, 4);
      Result := True;

      FTransactionReturn := ttrSuccessfull;
    end
    else
    if (FPCCresult = 'NOT CAPTURED') or (FPCCresult = 'NOT APPROVED') or (FPCCresult = 'CANCELED') or (FPCCresult = 'Error') or (FPCCresult = 'NOT PROCESSED') then
    begin
      FAuth              := FormatPCChargeError(ADebit.GetAuth);
      FTransactionReturn := ttrNotSuccessfull;


      {if ADebit.CVV2Ver <> '' then
        FCVV2Ver := ADebit.CVV2Ver;

      if (ADebit.Street <> '') or (ADebit.Zip <> '') then
        FAVS := ADebit.AVS;
      }
    end;
  end
  else
    begin
      FErrorDesc         := ADebit.GetErrorDesc;
      FTransactionReturn := ttrError;
      //Grava error
      if FErrorCode = PCC_ERROR_TIMEOUT then
        DebitTransactionError(ADebit);
    end;

end;

function TPCCTransaction.FormatPCChargeError(PCError: String): String;
begin
  //NOT CAPTURED
  if PCError = 'IP Init' then
    Result := '(IP Init) PC Charge was unable to connect to the internet, Check your internet connection and try again.'
  else if PCError = 'Timeout' then
    Result := '(Time Out) Time-Out Error, Re-send Information'
  else if PCError = 'CALL AUTH CENTER' then
    Result := '(CALL AUTH CENTER) Call for approval'
  else
    Result := PCError;
end;

function TPCCTransaction.DebitTransactionError(ADebit: TOCXDebit): Boolean;
var
  FTransError : TIniFile;
begin

  FTransError := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');

  FTransError.WriteString('Transaction', 'Type', 'Debit');
  FTransError.WriteString('Transaction', 'Card', ADebit.Card);
  FTransError.WriteString('Transaction', 'Amount', ADebit.Amount);
  FTransError.WriteString('Transaction', 'Ticket', ADebit.Ticket);
  FTransError.WriteString('Transaction', 'User', FUser);
  FTransError.WriteString('Transaction', 'FAuth', FAuth);
  FTransError.WriteString('Transaction', 'FRefNumber', FRefNumber);
  FTransError.WriteString('Transaction', 'FTroutD', FTroutD);
  FTransError.WriteDateTime('Transaction', 'Date', Trunc(Now));


end;


function TPCCTransaction.CreditTransactionError(ACharge: TCharge): Boolean;
var
  FTransError : TIniFile;
begin

  FTransError := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');

  FTransError.WriteString('Transaction', 'Type', 'Credit');
  FTransError.WriteString('Transaction', 'Card', ACharge.Card);
  FTransError.WriteString('Transaction', 'Amount', ACharge.Amount);
  FTransError.WriteString('Transaction', 'Ticket', ACharge.Ticket);
  FTransError.WriteString('Transaction', 'CVV2', ACharge.CVV2);
  FTransError.WriteString('Transaction', 'User', FUser);
  FTransError.WriteString('Transaction', 'Manual', IntToStr(ACharge.Manual));
  FTransError.WriteString('Transaction', 'CardPresent', ACharge.CardPresent);
  FTransError.WriteString('Transaction', 'FAuth', FAuth);
  FTransError.WriteString('Transaction', 'FRefNumber', FRefNumber);
  FTransError.WriteString('Transaction', 'FTroutD', FTroutD);
  FTransError.WriteDateTime('Transaction', 'Date', Trunc(Now));
end;

function TPCCTransaction.ErrorFileExist: Boolean;
begin
  Result := FileExists(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');
end;

function TPCCTransaction.CreditTransactionAlreadyCharged(
  ACharge: TCharge; AFileType : TOleEnum): Boolean;
var
  FTransError : TIniFile;
  FPCCRecordList : TPCCRecordList;
  FPCCRecord : TPCCRecord;
  sCCard, sDate, sTicket, sCommand : String;
  FProcessOK : Boolean;
begin

  FProcessOK := False;
  Result := False;

  FTransError := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');
  try

    sCCard  := FTransError.ReadString('Transaction', 'Card', '');
    sDate   := FTransError.ReadString('Transaction', 'Date', '');
    sTicket := FTransError.ReadString('Transaction', 'Ticket', '');

    if (sCCard = '') or (sCCard <> ACharge.Card) or (sTicket <> ACharge.Ticket) then
    begin
      Result := False;
      FProcessOK := True;
    end
    else
    begin
      sCommand        := ACharge.Command;
      ACharge.Command := 'ZI';
      ACharge.Send(AFileType);
      FProcessOK := True;

      FPCCRecordList := TPCCRecordList.Create;
      try
        FPCCRecordList.BuildRecords(ACharge.GetXMLResponse);
        FPCCRecord := FPCCRecordList.FindRecord(ACharge.Ticket, sDate, ACharge.User, ACharge.Amount, ACharge.Card);
        if FPCCRecord <> nil then
        begin
          FAuth      := FPCCRecord.Auth;
          FRefNumber := FPCCRecord.Ref;
          FTroutD    := FPCCRecord.TroutD;
          FPCCResult := FPCCRecord.Result;
          FErrorCode := 0;
          Result     := True;
        end;
      finally
        FreeAndNil(FPCCRecordList);
        ACharge.Command := sCommand;
      end;

    end;

  finally
    if FProcessOK then
      FileDelete(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');
  end;

end;


function TPCCTransaction.DebitTransactionAlreadyCharged(ADebit: TOCXDebit;
  AFileType: TOleEnum): Boolean;
var
  FTransError : TIniFile;
  FPCCRecordList : TPCCRecordList;
  FPCCRecord : TPCCRecord;
  sCCard, sDate, sTicket, sCommand : String;
  FProcessOK : Boolean;
begin

  FProcessOK := False;
  Result := False;

  FTransError := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');
  try

    sCCard  := FTransError.ReadString('Transaction', 'Card', '');
    sDate   := FTransError.ReadString('Transaction', 'Date', '');
    sTicket := FTransError.ReadString('Transaction', 'Ticket', '');

    if (sCCard = '') or (sCCard <> ADebit.Card) or (sTicket <> ADebit.Ticket) then
    begin
      Result := False;
      FProcessOK := True;
    end
    else
    begin
      sCommand       := ADebit.Command;
      ADebit.Command := 'ZI';
      ADebit.Send(AFileType);
      FProcessOK := True;

      FPCCRecordList := TPCCRecordList.Create;
      try
        FPCCRecordList.BuildRecords(ADebit.GetXMLResponse);
        FPCCRecord := FPCCRecordList.FindRecord(ADebit.Ticket, sDate, ADebit.User, ADebit.Amount, ADebit.Card);
        if FPCCRecord <> nil then
        begin
          FAuth      := FPCCRecord.Auth;
          FRefNumber := FPCCRecord.Ref;
          FTroutD    := FPCCRecord.TroutD;
          FPCCResult := FPCCRecord.Result;
          FErrorCode := 0;
          Result     := True;
        end;
      finally
        FreeAndNil(FPCCRecordList);
        ADebit.Command := sCommand;
      end;

    end;

  finally
    if FProcessOK then
      FileDelete(ExtractFileDir(Application.ExeName)+'\PCCTransError.ini');
  end;

end;

end.
