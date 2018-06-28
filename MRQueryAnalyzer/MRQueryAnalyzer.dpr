program MRQueryAnalyzer;

uses
  Forms,
  uMainFrm in 'uMainFrm.pas' {MainFrm},
  uConfigConnFrm in 'uConfigConnFrm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TForm1, Form1);  
  Application.Run;
end.
