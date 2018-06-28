program PicViewer;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitPath in 'UnitPath.pas' {PathDlg},
  Utilities in 'Utilities.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
