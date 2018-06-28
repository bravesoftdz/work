program MRSintegra;

uses
  Forms,
  MRSintegraMain in 'MRSintegraMain.pas' {MainFrm},
  uDMSintegra in 'uDMSintegra.pas' {DMSintegra: TDataModule},
  uSaleFrm in 'uSaleFrm.pas' {SintegraSaleFrm},
  uSintegraFrm in 'uSintegraFrm.pas' {SintegraFrm},
  uSintegraConfigFrm in 'uSintegraConfigFrm.pas' {SintegraConfigFrm},
  uReducaoZList in 'uReducaoZList.pas' {ReducaoZList};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MRSintegra';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TDMSintegra, DMSintegra);
  Application.Run;
end.
