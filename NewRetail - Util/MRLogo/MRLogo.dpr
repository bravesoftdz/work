program MRLogo;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uDMGlobal in '..\..\RepositoryD7\uDMGlobal.pas' {DMGlobal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMGlobal, DMGlobal);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
