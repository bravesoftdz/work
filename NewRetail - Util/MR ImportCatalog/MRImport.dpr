program MRImport;

uses
  Forms,
  uMain in '..\MRImportExport\uMain.pas' {FrmMain},
  uWizImportCatalog in '..\MRImportExport\uWizImportCatalog.pas',
  uParentWizard in '..\MRImportExport\uParentWizard.pas' {ParentWizard},
  uWizImportPO in '..\MRImportExport\uWizImportPO.pas' {WizImportPO},
  uDMImport in '..\MRImportExport\uDMImport.pas',
  uDMGlobal in '..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uDM in '..\MRImportExport\uDM.pas' {DM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MRImport';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDM, DM);
  Application.Run;
  Application.Terminate;
end.
