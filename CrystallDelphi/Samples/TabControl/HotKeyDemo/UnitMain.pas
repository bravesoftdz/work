unit UnitMain;
(*
The purpose of this demo is to show how to Tab in and out of the
Crystal Reports Preview Window when it is part of your Form.  Normally
the Crystal Preview retains the keyboard focus, and since there is no
OnKeyPress window callback event, there is no way to get the focus
back to the Form.  This demo uses the Windows HotKey API to institute
an Application-wide keypress that allows the application to process
the Tab key even when the Crystal Preview window has focus.

Some of the ideas used in the demo were gleaned from an excellent
freeware Delphi component (available on the Internet - search the
Delphi file areas):
  HotKeys Utility by Arjen Broeze (SheAr software)
  E-Mail: Arjen@Earthling.net
*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32, UCrpeClasses;

type
  TWMHotKey = record
    Msg: Cardinal;
    idHotKey: Word;
    Modifiers: Integer;
    VirtKey : Integer;
  end;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnLoad: TButton;
    btnClose: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Panel2: TPanel;
    Crpe1: TCrpe;
    OpenDialog1: TOpenDialog;
    btnAbout: TButton;
    procedure btnLoadClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure wmHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    procedure AppActivate(Sender: TObject);
    procedure AppDeActivate(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

uses UnitAbout;

{$R *.DFM}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Application.OnActivate := AppActivate;
  Application.OnDeactivate := AppDeActivate;
end;

procedure TfrmMain.btnLoadClick(Sender: TObject);
var
  prevCur : TCursor;
begin
  OpenDialog1.FileName := '*.rpt';
  OpenDialog1.Filter := 'Crystal Report (*.RPT)|*.rpt';
  OpenDialog1.Title := 'Load Report...';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    Exit;
  prevCur := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Refresh;
  Crpe1.CloseJob;
  Crpe1.ReportName := OpenDialog1.FileName;
  Crpe1.Output := toWindow;
  Crpe1.WindowParent := Panel2;
  Crpe1.WindowStyle.BorderStyle := bsNone;
  Crpe1.Execute;
  while Crpe1.Status <> crsJobCompleted do
    Application.ProcessMessages;
  Screen.Cursor := prevCur;
  ActiveControl := nil;
end;

{The HotKey is only active if the App is focused}
procedure TfrmMain.AppActivate(Sender: TObject);
begin
  if not RegisterHotKey(Handle, 1, 0, $09) then
    ShowMessage('failed register');
end;

{The HotKey is deactived if the App is not focused}
procedure TfrmMain.AppDeActivate(Sender: TObject);
begin
  if not UnRegisterHotKey(Handle, 1) then
    ShowMessage('failed unregister');
end;

{HotKey event handles the Tabbing}
procedure TfrmMain.wmHotKey(var Msg: TWMHotKey);
begin
  if btnLoad.Focused then
  begin
    Edit1.Text := 'Close Button Focused';
    btnClose.SetFocus;
    Exit;
  end;
  if btnClose.Focused then
  begin
    Edit1.Text := 'CheckBox1 Focused';
    CheckBox1.SetFocus;
    Exit;
  end;
  if CheckBox1.Focused then
  begin
    Edit1.Text := 'Edit1 Focused';
    Edit1.SetFocus;
    Exit;
  end;
  if Edit1.Focused then
  begin
    Edit1.Text := 'About button Focused';
    btnAbout.SetFocus;
    Exit;
  end;
  if btnAbout.Focused then
  begin
    {If the Preview Window is open, focus to it}
    if Crpe1.ReportWindowHandle <> 0 then
    begin
      Edit1.Text := 'Report Focused';
      Crpe1.SetFocus;
      Exit;
    end
    else
    begin
      {Otherwise go to Panel2}
      Edit1.Text := 'Panel Focused';
      Panel2.SetFocus;
      Exit;
    end;
  end;
  if Panel2.Focused then
  begin
    {if the Preview Window is open, set focus to it}
    if Crpe1.ReportWindowHandle <> 0 then
    begin
      Edit1.Text := 'Report Focused';
      Crpe1.SetFocus;
      Exit;
    end;
  end;
  {The default}
  Edit1.Text := 'Load Button Focused';
  ActiveControl := btnLoad;
  btnLoad.SetFocus;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Crpe1.CloseWindow;
  Crpe1.CloseJob;
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  dlgAbout.ShowModal;
end;

end.
