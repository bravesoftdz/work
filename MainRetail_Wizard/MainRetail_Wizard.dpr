program MainRetail_Wizard;
{$R MainRetail_Wizard.REC}


uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uDownloadFunctions in 'uDownloadFunctions.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uDataBaseOperation in '..\..\RepositoryD7\uDataBaseOperation.pas';

{$R *.res}

 begin
  Application.Initialize;
  Application.Title := 'MainRetail';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
