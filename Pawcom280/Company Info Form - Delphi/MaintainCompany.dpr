program MaintainCompany;

uses
  Forms,
  UMCompany in 'UMCompany.pas' {FMCompany};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFMCompany, FMCompany);
  Application.Run;
end.
