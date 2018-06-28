program MRImportExport;

uses
  Forms,
  uMain in 'uMain.pas' {FrmMain},
  uParentWizard in 'uParentWizard.pas' {ParentWizard},
  uDMImportExport in 'uDMImportExport.pas' {DMImportExport: TDataModule},
  uDMGlobal in '..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule},
  uParentWizImp in 'uParentWizImp.pas' {ParentWizImp},
  uWizImportPO in 'uWizImportPO.pas' {WizImportPO},
  uWizImportCatalog in 'uWizImportCatalog.pas' {WizImportCatalog},
  uParent in 'uParent.pas' {FrmParent},
  uFrmServerConnection in 'uFrmServerConnection.pas' {FrmServerConnection},
  uDMGlobalNTier in '..\RepositoryD7\uDMGlobalNTier.pas' {DMGlobalNTier: TDataModule},
  uWizImportPerson in 'uWizImportPerson.pas' {WizImportPerson},
  uWizImportInventory in 'uWizImportInventory.pas' {WizImportInventory},
  uParentWizExp in 'uParentWizExp.pas' {ParentWizExp},
  uWizExportPO in 'uWizExportPO.pas' {WizExportPO},
  uFrmInventoryUpdate in 'uFrmInventoryUpdate.pas' {FrmInventoryUpdate},
  uFrmLog in '..\RepositoryD7\uFrmLog.pas' {FrmLog},
  uLogin in 'uLogin.pas' {RepLoginFrm},
  uSystemConfig in '..\RepositoryD7\uSystemConfig.pas',
  uFrmCatalogSearch in 'uFrmCatalogSearch.pas' {FrmCatalogSearch},
  uMRSQLParam in '..\RepositoryD7\uMRSQLParam.pas',
  uDMPeachtree in 'uDMPeachtree.pas' {DMPeachtree: TDataModule},
  PAW_TLB in 'PAW_TLB.pas',
  uFrmPeachtree in 'uFrmPeachtree.pas' {FrmPeachtree},
  uFrmCatalogSyncData in 'uFrmCatalogSyncData.pas' {FrmCatalogSyncData},
  uWizImportPet in 'uWizImportPet.pas' {WizImportPet},
  uDMPuppyTracker in 'uDMPuppyTracker.pas' {DMPuppyTracker: TDataModule},
  uFrmQuickBooks in 'uFrmQuickBooks.pas' {FrmQuickBooks},
  uFrmQuickBooksConfig in 'uFrmQuickBooksConfig.pas' {FrmQuickBooksConfig},
  uDMQuickBooks in 'uDMQuickBooks.pas' {DMQuickBooks: TDataModule},
  uWizImportVendor in 'uWizImportVendor.pas' {WizImportVendor},
  uWizImportVendorCatalog in 'uWizImportVendorCatalog.pas' {WizImportVendorCatalog};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMImportExport, DMImportExport);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
