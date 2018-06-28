unit uPaymentBonusBucks;

interface

uses
  uPayment, uBonusBucks;

type
  TPaymentBonusBucks = class(TPayment)
  private
    FBonusBucks: TBonusBucks;
    procedure UpdateBonusBucks;
  protected
    procedure OnProcessPayment; override;
    procedure BeforeDeletePayment; override;
    function GetPaymentType: Integer; override;
    function ValidatePayment: Boolean; override;
    function GetAutoProcess: Boolean; override;

  public
    property BonusBucks: TBonusBucks read FBonusBucks write FBonusBucks;
  end;

implementation

uses SysUtils, uMsgConstant, uSystemConst, ADODB, uDocumentInfo;

{ TPaymentBonusBucks }

function TPaymentBonusBucks.GetAutoProcess: Boolean;
begin
  Result := True;
end;

function TPaymentBonusBucks.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_BONUSBUCK;
end;

procedure TPaymentBonusBucks.OnProcessPayment;
begin
  inherited;
  FTraceControl.TraceIn(Self.ClassName + '.OnProcessPayment');

  case DocumentType of
    dtInvoice:
      with TADOCommand.Create(nil) do
      try
        Connection := FADOConnection;
        CommandText := 'UPDATE Sal_RebateDiscount SET IDPreSaleUsed = :IDPreSaleUsed WHERE IDPreSaleCreated = :IDPreSaleCreated';
        Parameters.ParamByName('IDPreSaleUsed').Value := FIDPreSale;
        Parameters.ParamByName('IDPreSaleCreated').Value := FBonusBucks.IDPreSaleCreated;
        Execute;
      finally
        Free;
      end;
    dtServiceOrder:;
  end;

  FTraceControl.TraceOut;
end;

function TPaymentBonusBucks.ValidatePayment: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ValidatePayment');
  Result := False;

  if FBonusBucks.IDPreSaleCreated = -1 then
    raise Exception.Create(MSG_CRT_BONUS_NOT_FOUND)

  else if not FBonusBucks.ValidCupon then
    raise Exception.Create(MSG_CRT_BONUS_IS_NOT_VALID)

  else if FBonusBucks.ExpiredCupon then
    raise Exception.Create(MSG_CRT_BONUS_EXPIRED);

  Result := True;
  FTraceControl.TraceOut;
end;

procedure TPaymentBonusBucks.BeforeDeletePayment;
begin
  FTraceControl.TraceIn(Self.ClassName + '.BeforeDeletePayment');
  UpdateBonusBucks;
  FTraceControl.TraceOut;
end;

procedure TPaymentBonusBucks.UpdateBonusBucks;
begin
  FTraceControl.TraceIn(Self.ClassName, '.UpdateBonusBucks');

  case DocumentType of
    dtInvoice:
      with TADOCommand.Create(nil) do
      try
        Connection := FADOConnection;
        CommandText := 'UPDATE Sal_RebateDiscount ' +
                       'SET IDPreSaleUsed = NULL ' +
                       'WHERE IDPreSaleUsed = :IDPreSale';
        Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
        Execute;
      finally
        Free;
      end;
    dtServiceOrder:;
  end;

  with TADOCommand.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'UPDATE CashRegMov ' +
                   'SET TotalSales = IsNull(TotalSales, 0) - ROUND(IsNull(:Value,0),2) ' +
                   'WHERE IDCashRegMov = :IDCashRegMov';
    Parameters.ParamByName('IDCashRegMov').Value := IDCashRegMov;
    Parameters.ParamByName('Value').Value := PaymentValue;
    Execute;
  finally
    Free;
  end;


  FTraceControl.TraceOut;
end;

end.
