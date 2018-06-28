program MRBackup;

{$R 7za.RES}

uses
  Forms,
  SysUtils,
  MiscUtils,
  uDMGlobal in 'RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uMsgConstant in 'RepositoryD7\uMsgConstant.pas' {FrmMsgConstant},
  uFrmBackUpRestoreDB in 'uFrmBackUpRestoreDB.pas' {FrmBackUpRestoreDB};

{$R *.RES}

var
  _7zaExeAbsolutePath: string;

begin
  _7zaExeAbsolutePath:=  ExtractFilePath(Application.ExeName) + '7za.exe';
  if not FileExists(_7zaExeAbsolutePath) then
    StrToFile(GetResourceAsString('7za', 'EXE'), _7zaExeAbsolutePath);

  Application.Initialize;
  Application.Title := 'MR Backup';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TFrmBackUpRestoreDB, FrmBackUpRestoreDB);
  Application.CreateForm(TFrmMsgConstant, FrmMsgConstant);
  Application.Run;
  Application.Terminate; 
end.
