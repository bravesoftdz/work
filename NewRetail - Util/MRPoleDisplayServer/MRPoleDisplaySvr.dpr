program MRPoleDisplaySvr;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMainScreen},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmAdvertisingConfig in 'uFrmAdvertisingConfig.pas' {FrmAdvertisingConfig},
  uFrmConf in 'uFrmConf.pas' {FrmConf},
  uFrmPoleClients in 'uFrmPoleClients.pas' {FrmPoleClients},
  uFrmCrossSellItems in 'uFrmCrossSellItems.pas' {FrmCrossSellItems},
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uDMThread in 'uDMThread.pas' {DMThread: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMainScreen, FrmMainScreen);
  Application.Run;
end.
