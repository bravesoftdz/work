unit PaymentDebitCard;

interface
uses uPaymentCard, uMRPinPad;

type

  TPaymentDebitCard = class(TPaymentCard)
  private
    FPinPad: TMRPinPad;
  protected
    procedure BeforeProcessPayment; override;
//    procedure PreparePCC; override;
  public
    property PinPad: TMRPinPad read FPinPad write FPinPad;
  end;


implementation

uses DeviceIntegrationInterface;

{ TPaymentDebitCard }

procedure TPaymentDebitCard.BeforeProcessPayment;
var
  return: Boolean;
begin
  inherited;
  processor.SetPurchase(FPaymentValue);

  // credit transaction
  if ( FPaymentValue > 0 ) then begin
     return  := device.DebitProcessSale();
  end else begin
           return := device.DebitProcessReturn();
      end;
end;


end.
