program Loader;

uses
  Forms,
  uLoaderMain in 'uLoaderMain.pas' {Main},
  NewPower in '..\Lib\NewPower.pas',
  Xbase in '..\Lib\Xbase.pas',
  E2Query in '..\Lib\E2Query.pas',
  PowerQuery in '..\Lib\PowerQuery.pas',
  uMsgBox in '..\Lib\uMsgBox.pas' {FrmMsgBox},
  SuperCombo in '..\Lib\SuperCombo.pas',
  LookUpQuery in '..\Lib\LookUpQuery.pas',
  PowerParam in '..\Lib\PowerParam.pas',
  uFileUtil in '..\Lib\uFileUtil.Pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TFrmMsgBox, FrmMsgBox);
  Application.Run;
end.
