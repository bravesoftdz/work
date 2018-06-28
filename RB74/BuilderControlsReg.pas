unit BuilderControlsReg;

interface

uses
  Classes,
  BuilderControls;

procedure Register;

implementation

{Register}
procedure Register;
begin
  RegisterNoIcon([TRotatedLabel, TSimpleGrid]);
end;


end.
