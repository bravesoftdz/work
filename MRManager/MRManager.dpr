program MRManager;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uDMGlobal in 'uDMGlobal.pas' {DMGlobal: TDataModule},
  uSynchronizationClasses in 'uSynchronizationClasses.pas',
  DBUtils in 'DBUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.Run;
end.
