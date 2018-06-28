program MRDailyMaintenance;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  MsTask in 'MsTask.pas',
  MsTaskUtils in 'MsTaskUtils.pas',
  AuxProcs in 'AuxProcs.pas',
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MainRetail - Daily Maintenance';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
