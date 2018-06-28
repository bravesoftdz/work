unit uPaymentGiftCard;

interface

uses
  uPayment, ADODB;

type
  TPaymentGiftCard = class(TPayment)
  private
    // Antonio, August 09, 2013
    FIsMercuryGiftCard: Boolean;
    FIDGiftCard: Integer;
    FAmountGiftCard: Currency;
    FCardNumber: String;

    procedure setMercuryGiftCard(value: Boolean);
    procedure SetCardNumber(const Value: String);
    procedure InsertGiftCardMov;
    procedure DeleteGiftCardMov;
    procedure UpdateGiftCardBalance(ACredit: Boolean);

    function GetNewIDGiftCardMov: Integer;
  protected
    procedure OnProcessPayment; override;
    procedure BeforeDeletePayment; override;
    procedure FillParameters(FCmdPayment: TADOCommand); override;
    procedure SetProperties(ADSPayment: TADODataSet); override;
    function GetSQLFields: String; override;
    function GetAutoProcess: Boolean; override;
    function ValidatePayment: Boolean; override;
    procedure BeforeProcessPayment; override;
  public
    function GetPaymentType: Integer; override;

    property IsMercuryGiftCard: Boolean write setMercuryGiftCard;
    property CardNumber: String read FCardNumber write SetCardNumber;
  end;

implementation

uses uSystemConst, DB, SysUtils, uMsgConstant, Math, uDocumentInfo;

{ TPaymentGiftCard }

procedure TPaymentGiftCard.BeforeDeletePayment;
begin
  FTraceControl.TraceIn(Self.ClassName + '.BeforeDeletePayment');

  DeleteGiftCardMov;
  UpdateGiftCardBalance(True);

  FTraceControl.TraceOut;
end;

procedure TPaymentGiftCard.DeleteGiftCardMov;
begin
  FTraceControl.TraceIn(Self.ClassName + '.DeleteGiftCardMov');

  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'DELETE Sal_AccountCardMov WHERE IDLancamento = :IDLancamento';
    Parameters.ParamByName('IDLancamento').Value := FIDPayment;
    Execute;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentGiftCard.FillParameters(FCmdPayment: TADOCommand);
begin
  inherited;
  FCmdPayment.Parameters.ParamByName('NumMeioQuitPrevisto').Value := FCardNumber;
end;

function TPaymentGiftCard.GetAutoProcess: Boolean;
begin
  Result := True;
end;

function TPaymentGiftCard.GetNewIDGiftCardMov: Integer;
begin
  FTraceControl.TraceIn(Self.ClassName + '.GetNewIDGiftCardMov');
  Result := 0;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FADOConnection;
    ProcedureName := 'sp_Sis_GetNextCode;1';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Sal_AccountCardMov.IDAccountCardMov';
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

function TPaymentGiftCard.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_GIFTCARD;
end;

function TPaymentGiftCard.GetSQLFields: String;
begin
  Result := (inherited GetSQLFields) + ',NumMeioQuitPrevisto';
end;

procedure TPaymentGiftCard.InsertGiftCardMov;
begin
  FTraceControl.TraceIn(Self.ClassName, '.InsertGiftCardMov');

  case DocumentType of
    dtInvoice:
      with TADOCommand.Create(nil) do
      try
        Connection := FADOConnection;
        CommandText := 'INSERT Sal_AccountCardMov(IDAccountCardMov,DateMov,Value,Credit,IDPreSale,IDLancamento,IDUser,IDAccountCard)' +
                       'VALUES(:IDAccountCardMov,GetDate(),:Amount,0,:IDPreSale,:IDLancamento,:IDUser,:IDAccountCard)';
        Parameters.ParamByName('IDAccountCardMov').Value := GetNewIDGiftCardMov;
        Parameters.ParamByName('Amount').Value := FPaymentValue;
        Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
        Parameters.ParamByName('IDLancamento').Value := FIDPayment;
        Parameters.ParamByName('IDUser').Value := FIDUser;
        Parameters.ParamByName('IDAccountCard').Value := FIDGiftCard;
        Execute;
      finally
        Free;
      end;
    dtServiceOrder:;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentGiftCard.BeforeProcessPayment;
begin
  inherited;

  if (FAmountGiftCard <> 0) and (FPaymentValue > FAmountGiftCard) then
     FPaymentValue := FAmountGiftCard;

end;

procedure TPaymentGiftCard.OnProcessPayment;
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName, '.OnProcessPayment');

  InsertGiftCardMov;
  UpdateGiftCardBalance(False);

  FTraceControl.TraceOut;
end;

procedure TPaymentGiftCard.SetCardNumber(const Value: String);
begin
  FTraceControl.TraceIn(Self.ClassName + '.GetIDGiftCard');

  FCardNumber := Value;
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT A.IDAccountCard, A.Amount ' +
                   'FROM Sal_AccountCard A ' +
                   'WHERE A.CardNumber = :CardNumber ';
    Parameters.ParamByName('CardNumber').Value := FCardNumber;
    Open;
    FIDGiftCard := FieldByName('IDAccountCard').AsInteger;
    FAmountGiftCard := FieldByName('Amount').AsCurrency;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentGiftCard.SetProperties(ADSPayment: TADODataSet);
begin
  inherited;
  CardNumber := ADSPayment.FieldByName('NumMeioQuitPrevisto').AsString;
end;

procedure TPaymentGiftCard.UpdateGiftCardBalance(ACredit: Boolean);
begin
  FTraceControl.TraceIn(Self.ClassName, '.InsertGiftCardMov');

  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'UPDATE Sal_AccountCard ' +
                   'SET	Amount = Amount + :Amount ' +
                   'WHERE IDAccountCard = :IDAccountCard';
    Parameters.ParamByName('Amount').Value := IfThen(ACredit, FPaymentValue, FPaymentValue*-1);
    Parameters.ParamByName('IDAccountCard').Value := FIDGiftCard;
    Execute;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

function TPaymentGiftCard.ValidatePayment: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName, '.ValidatePayment');

  Result := inherited ValidatePayment;

  // Antonio, August 09, 2013 - Mercury will be loaded by swiped event (card reader)
  if ( FIsMercuryGiftCard ) then begin
      result := true;
      exit;
  end;


  if FIDGiftCard = 0 then
  begin
    Result := False;
    FErrorMsg := Format(MSG_CRT_NO_GIFT_ACCOUNT, [FCardNumber]);
    raise Exception.Create(FErrorMsg);
  end;

  case DocumentType of
    dtInvoice:
      with TADODataSet.Create(nil) do
      try
        Connection := FADOConnection;
        CommandText := 'SELECT L.IDLancamento  ' +
                       'FROM Fin_Lancamento L ' +
                       'WHERE L.NumMeioQuitPrevisto = :CardNumber '+
                       'AND L.IDPreSale = :IDPreSale';
        Parameters.ParamByName('CardNumber').Value := FCardNumber;
        Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
        Open;
        Result := IsEmpty;
        if not Result then
        begin
          FErrorMsg := Format('Card %S has already been entered on this sale', [FCardNumber]);
          raise Exception.Create(FErrorMsg);
        end;
      finally
        Close;
        Free;
      end;
    dtServiceOrder:;
  end;

  if FAmountGiftCard <= 0 then
  begin
    Result := False;
    FErrorMsg := 'Gift Card balance is 0';
    raise Exception.Create(FErrorMsg);
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentGiftCard.setMercuryGiftCard(value: Boolean);
begin
  FIsMercuryGiftCard := value;
end;

end.
