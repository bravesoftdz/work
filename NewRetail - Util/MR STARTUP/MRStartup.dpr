program MRStartup;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmSQLInstall in 'uFrmSQLInstall.pas' {FrmSQLInstall},
  uOperationSystem in '..\..\RepositoryD7\uOperationSystem.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Main Retail startup';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
