unit PaymentCreditCard;

interface
uses uPaymentCard, ADODB, uMRTraceControl;

type

  TPaymentCreditCard = class(TPaymentCard)
  private
  protected
    procedure BeforeProcessPayment; override;
  public
      constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl); override;
  end;


implementation

uses uPayment, DeviceIntegrationInterface;

{ TPaymentCreditCard }

procedure TPaymentCreditCard.BeforeProcessPayment;
var
  return: Boolean;
begin
  inherited;
  processor.SetPurchase(FPaymentValue);

  // credit transaction
  if ( FPaymentValue > 0 ) then begin
     return  := device.CreditProcessSale();
  end else if ( VoidSaleTransaction ) then begin
              return := device.CreditVoidSale();
      end else begin
               return := device.CreditProcessReturn();
          end;


end;

constructor TPaymentCreditCard.Create(AADOConnection: TADOConnection;
  ATraceControl: TMrTraceControl);
begin
  inherited;
  //
end;

end.
