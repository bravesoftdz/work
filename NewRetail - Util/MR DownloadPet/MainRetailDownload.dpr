program MainRetailDownload;

uses
  Forms,
  MRDownload in 'MRDownload.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Pet Center Setup Wizard';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
