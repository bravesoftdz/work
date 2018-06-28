program HotKeyDemo;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitAbout in 'UnitAbout.pas' {dlgAbout};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdlgAbout, dlgAbout);
  Application.Run;
end.
