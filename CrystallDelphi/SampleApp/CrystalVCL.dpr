program CrystalVCL;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  USPreview in 'USPreview.pas' {CrpePreviewDlg},
  USWinEvents in 'USWinEvents.pas' {CrpeWindowEventsDlg},
  USActvEvents in 'USActvEvents.pas' {CrpeActiveEventsDlg},
  USError1 in 'USError1.pas' {CrpeLoadErrorDlg},
  USError2 in 'USError2.pas' {CrpeErrorDlg},
  USAbout in 'USAbout.pas' {CrpeAboutBoxSA};

{$R *.RES}
{$R winxp.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
