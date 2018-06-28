program ModelUpd;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FrmModelUpd};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmModelUpd, FrmModelUpd);
  Application.Run;
end.
