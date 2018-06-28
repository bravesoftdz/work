program ReplConfig;

uses
  Forms,
  uDMParent in '..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  uParentWizard in '..\RepositoryD7\uParentWizard.pas' {ParentWizard},
  uFrmStart in 'uFrmStart.pas' {FrmStart},
  ufrmServerInfo in '..\RepositoryD7\ufrmServerInfo.pas' {FrmServerInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Replication setup';
  Application.CreateForm(TDMParent, DMParent);
  Application.CreateForm(TFrmStart, FrmStart);
  Application.Run;
end.
