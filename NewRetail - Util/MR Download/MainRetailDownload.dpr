program MainRetailDownload;

uses
  Forms,
  MRDownload in 'MRDownload.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MainRetail - Download';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
