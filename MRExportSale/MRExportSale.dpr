program MRExportSale;

uses
  Forms,
  uFrmHold in 'uFrmHold.pas' {FrmHold},
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uFrmSearchHold in 'uFrmSearchHold.pas' {FrmSearchHold},
  uFrmTransporter in 'uFrmTransporter.pas' {FrmTransporter},
  uFrmConfig in 'uFrmConfig.pas' {FrmConfig},
  uFrmExportItems in 'uFrmExportItems.pas' {FrmExportItems};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
