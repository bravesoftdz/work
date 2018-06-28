unit PaymentPrepaidCard;

interface
uses uPaymentCard, ADODB, uMRTraceControl;

type

  //amfsouza 10.18.2011 - Gift cards by Mercury
  TPaymentPrePaid = class(TPaymentCard)
  private
  protected
    procedure BeforeProcessPayment; override;
  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl); override;
    function getCardNumber: Boolean;
  end;


implementation

{ TPaymentPrePaid }

procedure TPaymentPrePaid.BeforeProcessPayment;
begin
  inherited;

end;

constructor TPaymentPrePaid.Create(AADOConnection: TADOConnection;
  ATraceControl: TMrTraceControl);
begin
  inherited;

end;

function TPaymentPrePaid.getCardNumber: Boolean;
begin

end;

end.
