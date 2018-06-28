program MRMaintenance;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uDMParent in '..\..\RepositoryD7\uDMParent.pas' {DMParent: TDataModule},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmAvgCostCalculation in 'uFrmAvgCostCalculation.pas' {FrmAvgCostCalculation};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMParent, DMParent);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmAvgCostCalculation, FrmAvgCostCalculation);
  Application.Run;
end.
