program MRPuppyTracker;

uses
  Forms,
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uFrmPetFilePath in 'uFrmPetFilePath.pas' {FrmPetFilePath},
  uFrmSchedule in 'uFrmSchedule.pas' {FrmSchedule},
  uFrmDefaultValues in 'uFrmDefaultValues.pas' {FrmDefaultValues},
  uFrmMRConnection in 'uFrmMRConnection.pas' {FrmMRConnection};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MRPuppy';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
