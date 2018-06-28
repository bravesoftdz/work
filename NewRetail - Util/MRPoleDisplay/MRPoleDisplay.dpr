program MRPoleDisplay;

uses
  Windows,
  Forms,
  uMainDisplay in 'uMainDisplay.pas' {FrmMainDisplay},
  uFrmConfiguration in 'uFrmConfiguration.pas' {FrmConfig},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmScreenConf in 'uFrmScreenConf.pas' {FrmScreenConf},
  uFrmAdvertisingConfig in 'uFrmAdvertisingConfig.pas' {FrmAdvertisingConfig},
  uInvoicePollDisplayConst in '..\..\RepositoryD7\uInvoicePollDisplayConst.pas',
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uThreadConnectMRPDS in 'uThreadConnectMRPDS.pas';

var
  Mutex : THandle;
{$R *.res}

begin

  Mutex := CreateMutex(nil, True, 'MRPollDisplay');
  if (Mutex <> 0) and (GetLastError = 0) then
  begin
    Application.Initialize;
    Application.Title := 'MRPoleDisplay';
    Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMainDisplay, FrmMainDisplay);
  Application.Run;
    if Mutex <> 0 then
      CloseHandle(Mutex);
  end;

end.
