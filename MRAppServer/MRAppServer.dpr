program MRAppServer;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  MRAppServer_TLB in 'MRAppServer_TLB.pas',
  uRDMApplicationHub in 'uRDMApplicationHub.pas' {RDMApplicationHub: TRemoteDataModule} {ApplicationHub: CoClass},
  uDMImportTextFile in 'ImportExportSrv\Import\uDMImportTextFile.pas' {DMImportTextFile: TDataModule},
  uDMImportVCTextFile in 'ImportExportSrv\Import\uDMImportVCTextFile.pas' {DMImportVCTextFile: TDataModule},
  uDMValidateVCTextFile in 'ImportExportSrv\Import\uDMValidateVCTextFile.pas' {DMValidateVCTextFile: TDataModule},
  uFrmConnection in 'uFrmConnection.pas' {FrmConnection},
  uDMValidateTextFile in 'ImportExportSrv\Import\uDMValidateTextFile.pas' {DMValidateTextFile: TDataModule},
  uParamFunctions in '..\RepositoryD7\uParamFunctions.pas',
  uDMImportPersonTextFile in 'ImportExportSrv\Import\uDMImportPersonTextFile.pas' {DMImportPersonTextFile: TDataModule},
  uDMImportInventoryTextFile in 'ImportExportSrv\Import\uDMImportInventoryTextFile.pas' {DMImportInventoryTextFile: TDataModule},
  uContentClasses in '..\MAINRETAIL 3 D7\Inventory\uContentClasses.pas',
  uDMImportInventory in 'ImportExportSrv\Import\uDMImportInventory.pas' {DMImportInventory: TDataModule},
  uDMGlobal in 'uDMGlobal.pas' {DMGlobal: TDataModule},
  uDMValidateInventoryTextFile in 'ImportExportSrv\Import\uDMValidateInventoryTextFile.pas' {DMValidateInventoryTextFile: TDataModule},
  uRDMExport in 'ImportExportSrv\Export\uRDMExport.pas' {RDMExport: TRemoteDataModule} {RDMExport: CoClass},
  uDMExportPO in 'ImportExportSrv\Export\uDMExportPO.pas' {DMExportPO: TDataModule},
  uRDMImport in 'ImportExportSrv\Import\uRDMImport.pas' {RDMImport: TRemoteDataModule} {RDMImport: CoClass},
  uRDMReport in 'ReportSrv\uRDMReport.pas' {RDMReport: TRemoteDataModule} {RDMReport: CoClass},
  uRDMLookupInventory in 'LookupSrv\uRDMLookupInventory.pas' {RDMLookupInventory: TRemoteDataModule} {RDMLookupInventory: CoClass},
  uRDMLookupPurchase in 'LookupSrv\uRDMLookupPurchase.pas' {RDMLookupPurchase: TRemoteDataModule} {RDMLookupPurchase: CoClass},
  uRDMLookupMaintenance in 'LookupSrv\uRDMLookupMaintenance.pas' {RDMLookupMaintenance: TRemoteDataModule} {RDMLookupMaintenance: CoClass},
  uDMCalcPrice in '..\RepositoryD7\uDMCalcPrice.pas' {DMCalcPrice: TDataModule},
  uRDMCatalog in 'CatalogSrv\uRDMCatalog.pas' {RDMCatalog: TRemoteDataModule} {RDMCatalog: CoClass},
  uMRParam in '..\RepositoryD7\uMRParam.pas',
  uMRSQLParam in '..\RepositoryD7\uMRSQLParam.pas',
  uNumericFunctions in '..\RepositoryD7\uNumericFunctions.pas',
  uDMExportTextFile in 'ImportExportSrv\Export\uDMExportTextFile.pas' {DMExportTextFile: TDataModule},
  uDMImportInventoryCatalog in 'ImportExportSrv\Import\uDMImportInventoryCatalog.pas' {DMImportInventoryCatalog: TDataModule},
  uRDMPetCenter in 'PetSrv\PetCenter\uRDMPetCenter.pas' {RDMPetCenter: TRemoteDataModule} {RDMPetCenter: CoClass},
  uRDMMaintenance in 'Global\uRDMMaintenance.pas' {RDMMaintenance: TRemoteDataModule} {RDMMaintenance: CoClass},
  uRDMLookUpPet in 'Global\uRDMLookUpPet.pas' {RDMLookUpPet: TRemoteDataModule} {RDMLookUpPet: CoClass},
  uRDMSearchPet in 'Global\uRDMSearchPet.pas' {RDMSearchPet: TRemoteDataModule} {RDMSearchPet: CoClass},
  uDMValidatePetTextFile in 'ImportExportSrv\Import\uDMValidatePetTextFile.pas' {DMValidatePetTextFile: TDataModule},
  uPetClasses in '..\RepositoryD7\uPetClasses.pas',
  uDMImportPetTextFile in 'ImportExportSrv\Import\uDMImportPetTextFile.pas' {DMImportPetTextFile: TDataModule},
  uDMImportPet in 'ImportExportSrv\Import\uDMImportPet.pas' {DMImportPet: TDataModule},
  uRDMLookUpSO in 'LookupSrv\uRDMLookUpSO.pas' {RDMLookUpSO: TRemoteDataModule} {RDMLookUpSO: CoClass},
  uDMValidatePOTextFile in 'ImportExportSrv\Import\uDMValidatePOTextFile.pas' {DMValidatePOTextFile: TDataModule},
  uDMImportPOTextFile in 'ImportExportSrv\Import\uDMImportPOTextFile.pas' {DMImportPOTextFile: TDataModule};

{$R *.TLB}

{$R *.res}

begin
  Application.Title := 'MR Application Server';
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TDMCalcPrice, DMCalcPrice);
  Application.Run;
end.
