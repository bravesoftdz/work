unit uPaymentStoreAccount;

interface

uses
  uPayment, DBClient, SysUtils;

type
  TPaymentStoreAccount = class(TPayment)
  private
    FIDStoreAccount: Integer;
    procedure UpdateStoreAccount(AUsing: Boolean);
    function InsertStoreAccount : Boolean;
  protected
    procedure OnProcessPayment; override;
    procedure BeforeDeletePayment; override;
    function GetPaymentType: Integer; override;
    function CanUpdateCashregMov : Boolean; override;
  public
    property IDStoreAccount: Integer read FIDStoreAccount write FIDStoreAccount;
    //property CreditList : TClientDataSet read FCreditList write FCreditList;
  end;

implementation

uses ADODB, Variants, uSystemConst, DB;

{ TPaymentStoreAccount }

procedure TPaymentStoreAccount.BeforeDeletePayment;
begin
  inherited;
  UpdateStoreAccount(True);
end;

function TPaymentStoreAccount.CanUpdateCashregMov: Boolean;
begin
  Result := True;
end;

function TPaymentStoreAccount.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_STOREACCOUNT;
end;

function TPaymentStoreAccount.InsertStoreAccount : Boolean;
var
  iError : Integer;
begin
  FTraceControl.TraceIn(Self.ClassName, '.InsertStoreAccount');

  FIDStoreAccount := -1;

  with TADOStoredProc.Create(nil) do
  begin
    Connection := FADOConnection;
    ProcedureName := 'sp_PreSale_AddStoreAccount;1';
    Parameters.Refresh;

    Parameters.ParamByName('@IDPessoa').Value         := IDCustomer;
    Parameters.ParamByName('@IDUser').Value           := IDUser;
    Parameters.ParamByName('@IDStore').Value          := IDStore;
    if IDPayment = 0 then
      Parameters.ParamByName('@IDLancamento').Value   := Null
    else
      Parameters.ParamByName('@IDLancamento').Value   := IDPayment;
    Parameters.ParamByName('@TransDate').Value        := Now;
    Parameters.ParamByName('@Amount').Value           := PaymentValue;
    Parameters.ParamByName('@IDStoreAccount').Value   := 0;
    ExecProc;

    iError := Parameters.ParambyName('@RETURN_VALUE').Value;

    if (iError = 0)  then
    begin
      FIDStoreAccount := Parameters.ParamByName('@IDStoreAccount').Value;
      Result := True;
    end
    else
    begin
      Result := False;
      raise Exception.Create('sp_PreSale_AddStoreAccount Error ' + IntToStr(iError));
    end;
  end;
  
  FTraceControl.TraceOut;
end;

procedure TPaymentStoreAccount.OnProcessPayment;
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName, 'OnProcessPayment');
  InsertStoreAccount;
  FTraceControl.TraceOut;
end;

procedure TPaymentStoreAccount.UpdateStoreAccount(AUsing: Boolean);
begin

  FTraceControl.TraceIn(Self.ClassName, '.UpdateStoreAccount');

  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'UPDATE Sal_StoreAccount ' +
                   'SET	IsUsed = 1, IDLancamento = :IDLancamento ' +
                   'WHERE IDStoreAccount = :IDStoreAccount';
    Parameters.ParamByName('IDStoreAccount').Value := FIDStoreAccount;

    if AUsing then
      Parameters.ParamByName('IDLancamento').Value := FIDPayment
    else
      Parameters.ParamByName('IDLancamento').Value := 0;
    Execute;
  finally
    Free;
  end;

  FTraceControl.TraceOut;

end;

end.
