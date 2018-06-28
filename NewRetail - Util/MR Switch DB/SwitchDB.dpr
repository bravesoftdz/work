program SwitchDB;

uses
  Forms,
  uMain in 'uMain.pas' {FrmMain},
  uFrmInfo in 'uFrmInfo.pas' {FrmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
