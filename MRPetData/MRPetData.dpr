program MRPetData;

uses
  Windows,
  Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uDM in 'uDM.pas' {DM: TDataModule};

var
  Mutex : THandle;
{$R *.res}

begin
  Mutex := CreateMutex(nil, True, 'MRPetData');
  if (Mutex <> 0) and (GetLastError = 0) then
  begin
    Application.Initialize;
    Application.Title := 'MRPetData';
    Application.CreateForm(TDM, DM);
  Application.Run;
      if Mutex <> 0 then
        CloseHandle(Mutex);
  end;
end.
