unit dxDateEditReg;

interface

procedure Register;

implementation

uses
  Classes, dxDateEdit, dxDBDateEdit;

procedure Register;
begin
  RegisterComponents('ExpressDateEdit', [TdxDateEdit, TdxDBDateEdit]);
end;

end.
