program POSServer;

uses
  Windows,
  MidasLib,
  Forms,
  uMainConf in 'uMainConf.pas' {FrmMain},
  uFrmSchedule in 'uFrmSchedule.pas' {FrmSchedule},
  uDMParent in '..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  tExecuteTask in 'tExecuteTask.pas',
  uFrmHistory in 'uFrmHistory.pas' {FrmHistory},
  uJobsSQLConst in 'uJobsSQLConst.pas',
  uFrmConnection in 'uFrmConnection.pas' {FrmConnection},
  uDMGlobal in '..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uDMPOS in 'uDMPOS.pas' {DMPOS: TDataModule},
  uFrmPDVTerminal in 'uFrmPDVTerminal.pas' {FrmPDVTerminal},
  uFilePersistence in '..\LibD7\uFilePersistence.pas',
  uFrmSelectDate in 'uFrmSelectDate.pas' {frmSelectDate},
  uFrmServerConnection in 'uFrmServerConnection.pas' {FrmServerConnection},
  uFrmImportInfo in 'uFrmImportInfo.pas' {FrmImportInfo},
  uFrmSalesExplorer in 'uFrmSalesExplorer.pas' {frmSalesExplorer},
  uPOSSalesExplorer in '..\LibD7\uPOSSalesExplorer.pas',
  uDMThread in 'uDMThread.pas' {DMThread: TDataModule},
  uPOSServerConsts in 'uPOSServerConsts.pas',
  uPOSServerTypes in 'uPOSServerTypes.pas',
  uInvoiceClasses in 'uInvoiceClasses.pas',
  uFrmPDVLog in 'uFrmPDVLog.pas' {FrmPDVLog};

{$R *.res}

var
  AMutex: Cardinal;
  hJanela: THandle;
begin
  AMutex := CreateMutex(nil, True, PChar('PDVServer'));
  if (AMutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then
    begin
      hJanela := FindWindow('TFrmMain', nil);
      if hJanela > 0 then
        SetForegroundWindow(hJanela);
    end
  else
    begin
      Application.Initialize;
      Application.Title := 'POS Server';
      Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDMParent, DMParent);
  Application.CreateForm(TDMPOS, DMPOS);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
    end;
end.
