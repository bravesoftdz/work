program Stream;

uses
  Forms,
  StrmTest in '..\StrmTest.pas' {Form1},
  FileDlg in '..\FileDlg.Pas' {FileDialog};

{$R *.RES}

begin
{$IFDEF WIN32}
  Application.Initialize;
{$ENDIF}
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFileDialog, FileDialog);
  Application.Run;
end.
