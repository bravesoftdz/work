program LicenseKeyPrj;

uses
  Forms,
  LicenseKey in 'LicenseKey.pas' {frmLicenseKey},
  DataModule in 'DataModule.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmLicenseKey, frmLicenseKey);
  Application.Run;
end.
