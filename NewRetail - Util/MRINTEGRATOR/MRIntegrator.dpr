program MRIntegrator;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {Main},
  uParentWizard in 'uParentWizard.pas' {ParentWizard},
  uDM in 'uDM.pas' {DM: TDataModule},
  uWizSetupColumns in 'uWizSetupColumns.pas' {WizSetupColumns},
  uFile in 'uFile.pas' {FrmFile},
  ufrmServerInfo in '..\..\RepositoryD7\ufrmServerInfo.pas' {FrmServerInfo},
  uWizSetupProgramsColumns in 'uWizSetupProgramsColumns.pas' {WizSetupProgramsColumns};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
