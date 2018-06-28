unit uPaymentStoreCredit;

interface

uses
  uPayment, DBClient, SysUtils;

type
  TPaymentStoreCredit = class(TPayment)
  private
    FIDCustomerCredit: Integer;
    FCreditList : TClientDataSet;
    procedure UpdateCustomerCredit(AUsing: Boolean);
    procedure UpdateUsedCreditList;
    procedure InsertStoreCredit;
    function AddCustomerCredit(AIDPessoa, AIDUser, AIDStore, AIDLancamento: Integer;
      ACreditDate, AExpirationDate: TDateTime; AAmount: Double;
      var AIDCustomerCredit: Integer): Boolean;
  protected
    procedure OnProcessPayment; override;
    procedure BeforeDeletePayment; override;
    function GetPaymentType: Integer; override;
  public
    property IDCustomerCredit: Integer read FIDCustomerCredit write FIDCustomerCredit;
    property CreditList : TClientDataSet read FCreditList write FCreditList;
  end;

implementation

uses ADODB, Variants, uSystemConst, DB;

{ TPaymentStoreCredit }

function TPaymentStoreCredit.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_CREDIT;
end;

procedure TPaymentStoreCredit.BeforeDeletePayment;
begin
  inherited;
  UpdateCustomerCredit(True);
end;

procedure TPaymentStoreCredit.OnProcessPayment;
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName, 'OnProcessPayment');
  if PaymentValue > 0 then
    UpdateUsedCreditList
  else
    InsertStoreCredit;
  FTraceControl.TraceOut;
end;

procedure TPaymentStoreCredit.UpdateCustomerCredit(AUsing: Boolean);
begin
  FTraceControl.TraceIn(Self.ClassName, '.UpdateCustomerCredit');

  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'UPDATE CustomerCredit ' +
                   'SET	IsUsed = 1, IDLancamento = :IDLancamento ' +
                   'WHERE IDCustomerCredit = :IDCustomerCredit';
    Parameters.ParamByName('IDCustomerCredit').Value := FIDCustomerCredit;

    if AUsing then
      Parameters.ParamByName('IDLancamento').Value := FIDPayment
    else
      Parameters.ParamByName('IDLancamento').Value := NULL;
    Execute;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

procedure TPaymentStoreCredit.UpdateUsedCreditList;
var
  cValue : Currency;
  IDCustomerCredit : Integer;
begin

  FTraceControl.TraceIn(Self.ClassName, 'UpdateUsedCreditList');

  if Assigned(CreditList) then
    with CreditList do
    begin
      cValue := PaymentValue;
      First;
      while not EOF do
      begin
        cValue := cValue - FieldByName('Amount').AsCurrency;
        FADOConnection.Execute(Format('UPDATE CustomerCredit SET IsUsed = 1 WHERE IDCustomerCredit = %D', [FieldByName('IDCustomerCredit').AsInteger]));
        if cValue = 0 then
          Break;

        if cValue < 0 then
        begin
          AddCustomerCredit(FieldByName('IDPessoa').AsInteger,
                            FieldByName('IDUser').AsInteger,
                            FieldByName('IDStore').AsInteger,
                            FieldByName('IDLancamento').AsInteger,
                            FieldByName('CreditDate').AsDateTime,
                            FieldByName('ExpirationDate').AsDateTime,
                            ABS(cValue),
                            IDCustomerCredit);
          Break;
        end;

        Next;
      end;
    end;

  FTraceControl.TraceOut;

end;

function TPaymentStoreCredit.AddCustomerCredit(AIDPessoa, AIDUser,
  AIDStore, AIDLancamento: Integer; ACreditDate,
  AExpirationDate: TDateTime; AAmount: Double;
  var AIDCustomerCredit: Integer): Boolean;
var
  iError : Integer;
begin
  FTraceControl.TraceIn(Self.ClassName, '.AddCustomerCredit');

  fIDCustomerCredit := -1;

  with TADOStoredProc.Create(nil) do
  begin
    Connection := FADOConnection;
    ProcedureName := 'sp_PreSale_AddCustomerCredit;1';
    Parameters.Refresh;

    Parameters.ParamByName('@IDPessoa').Value         := AIDPessoa;
    Parameters.ParamByName('@IDUser').Value           := AIDUser;
    Parameters.ParamByName('@IDStore').Value          := AIDStore;
    Parameters.ParamByName('@CreditDate').Value       := ACreditDate;
    if AExpirationDate = 0 then
      Parameters.ParamByName('@ExpirationDate').Value := Null
    else
      Parameters.ParamByName('@ExpirationDate').Value := AExpirationDate;
    Parameters.ParamByName('@Amount').Value           := AAmount;
    if AIDLancamento = 0 then
      Parameters.ParamByName('@IDLancamento').Value   := Null
    else
      Parameters.ParamByName('@IDLancamento').Value   := AIDLancamento;
    Parameters.ParamByName('@IDCustomerCredit').Value := 0;
    ExecProc;
    iError := Parameters.ParambyName('@RETURN_VALUE').Value;

    if (iError = 0)  then
    begin
      AIDCustomerCredit := Parameters.ParamByName('@IDCustomerCredit').Value;
      Result := True;
    end
    else
    begin
      Result := False;
      raise Exception.Create('sp_PreSale_AddCustomerCredit Error ' + IntToStr(iError));
    end;
  end;
  
  FTraceControl.TraceOut;
end;

procedure TPaymentStoreCredit.InsertStoreCredit;
var
  FID : Integer;
begin
    AddCustomerCredit(IDCustomer,
                      IDUser,
                      IDStore,
                      0,
                      Now,
                      0,
                      ABS(PaymentValue),
                      FID);
end;

end.
