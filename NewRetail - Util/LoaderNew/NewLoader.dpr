program NewLoader;

uses
  Forms,
  uFrmNewLoader in 'uFrmNewLoader.pas' {FrmNewLoader},
  uFrmFTPConfig in 'uFrmFTPConfig.pas' {FrmFTPConfig},
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'New Loader';
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TFrmNewLoader, FrmNewLoader);
  Application.Run;
end.
