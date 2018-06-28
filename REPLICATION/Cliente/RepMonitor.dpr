program RepMonitor;

uses
  MidasLib,
  Forms,
  uMainConf in 'uMainConf.pas' {FrmMain},
  uFrmSchedule in 'uFrmSchedule.pas' {FrmSchedule},
  uDMParent in '..\..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  tExecuteTask in 'tExecuteTask.pas',
  uFrmJobs in 'uFrmJobs.pas' {FrmJobs},
  uFrmHistory in 'uFrmHistory.pas' {FrmHistory},
  uJobsSQLConst in 'uJobsSQLConst.pas',
  uFrmConnection in 'uFrmConnection.pas' {FrmConnection},
  uFrmStoreType in 'uFrmStoreType.pas' {FrmStoreType},
  uReplicationClasses in '..\..\RepositoryD7\uReplicationClasses.pas',
  uDMRepl in '..\uDMRepl.pas' {DMRepl: TDataModule},
  uDMClient in 'uDMClient.pas' {DMClient: TDataModule},
  uClientThread in '..\uClientThread.pas',
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uDMClientThread in 'uDMClientThread.pas' {DMClientThread: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Replication Monitor';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDMClient, DMClient);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
