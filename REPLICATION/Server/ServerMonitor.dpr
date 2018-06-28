program ServerMonitor;

uses
  //FastMM4,
  Forms,
  MidasLib,
  uMainConf in 'uMainConf.pas' {FrmMain},
  uFrmSchedule in 'uFrmSchedule.pas' {FrmSchedule},
  tExecuteTask in 'tExecuteTask.pas',
  uFrmJobs in 'uFrmJobs.pas' {FrmJobs},
  uFrmHistory in 'uFrmHistory.pas' {FrmHistory},
  uJobsSQLConst in 'uJobsSQLConst.pas',
  uFrmStoreType in 'uFrmStoreType.pas' {FrmStoreType},
  uReplicationClasses in '..\..\RepositoryD7\uReplicationClasses.pas',
  uDMParent in '..\..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  uDMRepl in '..\uDMRepl.pas' {DMRepl: TDataModule},
  uDMServer in 'uDMServer.pas' {DMServer: TDataModule},
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uDMThread in 'uDMThread.pas' {DMThread: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Server Monitor';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDMServer, DMServer);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
