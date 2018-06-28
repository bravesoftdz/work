program MRUpdate;

uses
  Forms,
  uMain in 'uMain.pas' {FrmMain},
  uDM in 'uDM.pas' {DM: TDataModule},
  uCopyFiles in 'uCopyFiles.pas' {frmCopyFiles},
  uSystemConst in '..\..\Repository\uSystemConst.pas',
  uSQLFileReader in '..\..\Repository\uSQLFileReader.pas',
  uMsgBox in '..\..\RepositoryD7\uMsgBox.pas' {FrmMsgBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MR - UpdatePack';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMsgBox, FrmMsgBox);
  Application.Run;
end.
