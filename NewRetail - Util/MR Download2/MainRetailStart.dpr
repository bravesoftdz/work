program MainRetailStart;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uWebFunctions in '..\..\RepositoryD7\uWebFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
