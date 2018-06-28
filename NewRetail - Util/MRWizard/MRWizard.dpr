program MRWizard;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uFrmParentWizard in 'uFrmParentWizard.pas' {FrmParentWizard},
  uWzdPortugueseBR in 'uWzdPortugueseBR.pas' {WzdPortugueseBR},
  uFrmCreateModel in 'uFrmCreateModel.pas' {FrmCreateModel},
  uDMParent in '..\..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  uDMExport in 'uDMExport.pas' {DMExport: TDataModule},
  uMsgBox in '..\..\RepositoryD7\uMsgBox.pas' {FrmMsgBox},
  uFrmSizeColorGrid in 'uFrmSizeColorGrid.pas' {FrmSizeColorGrid},
  uFrmBuildGrid in 'uFrmBuildGrid.pas' {FrmBuildGrid},
  uWzdEnglish in 'uWzdEnglish.pas' {WzdEnglish},
  uWzdPetCenter in 'uWzdPetCenter.pas' {WzdPetCenter},
  uSysModules in '..\..\RepositoryD7\uSysModules.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MRWizard';
  Application.CreateForm(TDMParent, DMParent);
  Application.CreateForm(TDMExport, DMExport);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMsgBox, FrmMsgBox);
  Application.Run;
end.
