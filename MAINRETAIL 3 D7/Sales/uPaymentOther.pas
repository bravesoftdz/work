unit uPaymentOther;

interface

uses
  uPayment;

type
  TPaymentOther = class(TPayment)
  public
    function GetPaymentType: Integer; override;
  end;

implementation

uses uSystemConst;

{ TPaymentOther }

function TPaymentOther.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_OTHER;
end;

end.
