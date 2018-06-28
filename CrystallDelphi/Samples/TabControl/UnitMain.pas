unit UnitMain;
(*
The purpose of this demo is to show how to Tab in and out of the
Crystal Reports Preview Window when it is part of your Form.  Normally
the Crystal Preview retains the keyboard focus and is not in the Forms
internal List of controls, so cannot be tabbed in and out of.

One way around this is to trap the Windows messages that go to the
Crystal Preview Window.  The actual Report is drawn on a child window,
3 levels deep, so the Window Procedure for this child must be captured
and redirected to another user-defined procedure.  In this user-defined
procedure we can handle the messages as they come in and respond to
them as we like.

The following demo shows how to handle the TAB keypress to include the
Crystal window in the Tab order of the Form.  It also displays the Decimal
value of any keys that are pressed over the Crystal Window.  Many other
messages could be trapped, check a good book on Windows API messages, or
consult your Delphi source code for more ideas.
*)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32, UCrpeClasses;

type
  WParameter = LongInt;
  LParameter = LongInt;

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
    procedure btnAboutKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAboutClick(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure btnLoadKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain       : TfrmMain;
  OldWindowProc : Pointer;
  FromRpt       : Boolean;

implementation

uses UnitAbout;

{$R *.DFM}

procedure TfrmMain.btnLoadClick(Sender: TObject);
var
  a1        : array[0..255] of Char;
  s1        : string;
  xWnd      : HWnd;
  sWinName1 : string;
  sWinName2 : string;

  {This is the replacement Window Procedure for the Crystal Preview}
  function NewWindowProc(WindowHandle: hWnd; TheMessage: WParameter;
    ParamW: WParameter; ParamL: LParameter): LongInt stdcall;
  begin
    { Process the message of your choice here }
    case TheMessage of
      {Scroll keys}
      WM_VSCROLL:
      begin
        frmMain.Edit1.Text := 'Vertical Scroll';
      end;
      WM_HSCROLL:
      begin
        frmMain.Edit1.Text := 'Horizontal Scroll';
      end;
      {Any keys}
      WM_CHAR:
      begin
        {If not Tab, handle it...}
        if ParamW <> 9 then
          frmMain.Edit1.Text := 'Decimal: ' + IntToStr(ParamW) +
            ' / ' + 'Ascii: ' + CHR(ParamW);
        {Could do something like this in response to
         certain keypresses:
           SendMessage(WindowHandle, WM_VSCROLL, 1, 0);}
      end;
    end;
    case ParamW of
      {Tab key pressed}
      VK_TAB :
      begin
        FromRpt := True;
        {Is Shift key held down?}
        if GetKeyState(VK_SHIFT) < 0 then
        begin
          if ActiveControl = frmMain.btnAbout then
            ActiveControl := nil;
          frmMain.edit1.Text := 'About Btn Focused';
          frmMain.btnAbout.SetFocus;
        end
        {No Shift key}
        else
        begin
          if ActiveControl = frmMain.btnLoad then
            ActiveControl := nil;
          frmMain.edit1.Text := 'Load Btn Focused';
          frmMain.btnLoad.SetFocus;
        end;
      end;
    end;
    { Exit here and return zero if you want     }
    { to stop further processing of the message }
    { Call the old Window procedure to }
    { allow default processing of the message. }
    NewWindowProc := CallWindowProc(OldWindowProc, WindowHandle, TheMessage, ParamW, ParamL);
  end;

begin
  OpenDialog1.FileName := '*.rpt';
  OpenDialog1.Filter := 'Crystal Report (*.RPT)|*.rpt';
  OpenDialog1.Title := 'Load Report...';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    Exit;
  Refresh;
  FromRpt := False;
  Crpe1.ReportName := OpenDialog1.FileName;
  Crpe1.Output := toWindow;
  Crpe1.WindowParent := Panel2;
  Crpe1.WindowStyle.BorderStyle := bsNone;
  Crpe1.Execute;
  while Crpe1.Status <> crsJobCompleted do
    Application.ProcessMessages;

  {Check Versions}
  if Crpe1.Version.Crpe.Major > 6 then
  begin
    sWinName1 := 'AfxWnd42';
    sWinName2 := 'AfxFrameOrView42';
  end
  {SCR 6 uses AfxWnd42s, AfxFrameOrView42s}
  else
  begin
    sWinName1 := 'AfxWnd42s';
    sWinName2 := 'AfxFrameOrView42s';
  end;

  xWnd := Crpe1.ReportWindowHandle;
  {AfxWnd42 - The first child frame} {SCR 6 uses AfxWnd42s}
  xWnd := GetWindow(xWnd, GW_CHILD);
  {Afx:n2 or AfxWnd42 - could be either depending on WindowButtonBar
   settings.  We want AfxWnd42, so if this is not it, we need one
   more step.}
  xWnd := GetWindow(xWnd, GW_CHILD);
  GetClassName(xWnd, a1, 256);
  s1 := StrPas (a1);
  if s1 <> sWinName1 then
    xWnd := GetWindow(xWnd, GW_HWNDNEXT);
  {AfxMDIFrame42 or AfxFrameOrView42 - could be either depending
   WindowButtonBar settings.  We want AfxFrameOrView42, so if this
   is not it, we need to take two more steps.}
  xWnd := GetWindow(xWnd, GW_CHILD);
  GetClassName(xWnd, a1, 256);
  s1 := StrPas(a1);
  if s1 <> sWinName2 then
  begin
    xWnd := GetWindow(xWnd, GW_CHILD);
    GetClassName(xWnd, a1, 256);
    s1 := StrPas(a1);
    if s1 <> sWinName2 then
      xWnd := GetWindow(xWnd, GW_HWNDNEXT);
  end;

  { Set the new window procedure for the control
    and remember the old window procedure. If the
    Crystal Window is separate from the Form, you
    may have to restore the OldWindowProc if your
    Form is closed with the Crystal Window open. }
  OldWindowProc := Pointer(SetWindowLong(xWnd,
    GWL_WNDPROC, LongInt(@NewWindowProc)));
  Edit1.Text := 'Report Focused';
  Crpe1.SetFocus;
  ActiveControl := nil;
end;

procedure TfrmMain.btnAboutKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {This is the last control.  If the focus was changed
   in forward direction (Tab) set focus to Crpe}
  if FromRpt then
  begin
    FromRpt := False;
    Exit;
  end;
  if Crpe1.ReportWindowHandle = 0 then
    Exit;
  if (Key = vk_Tab) and not (ssShift in Shift) then
  begin
    if ActiveControl = btnAbout then
      ActiveControl := nil;
    Edit1.Text := 'Report Focused';
    Crpe1.SetFocus;
  end;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Crpe1.CloseWindow
end;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  dlgAbout.Show;
end;

procedure TfrmMain.Panel2Resize(Sender: TObject);
begin
  if Crpe1.ReportWindowHandle > 0 then
  begin
    SetWindowPos(Crpe1.ReportWindowHandle, HWND_TOP, 0, 0,
      Panel2.Width, Panel2.Height, SWP_NOZORDER);
  end;
end;

procedure TfrmMain.btnLoadKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {This is the first control.  If the focus was changed
   in reverse direction (Shift key) set focus to Crpe}
  if FromRpt then
  begin
    FromRpt := False;
    Exit;
  end;
  if Crpe1.ReportWindowHandle = 0 then
    Exit;
  if (Key = vk_Tab) and (ssShift in Shift) then
  begin
    if ActiveControl = btnLoad then
      ActiveControl := nil;
    Edit1.Text := 'Report Focused';
    Crpe1.SetFocus;
  end
  else
    Edit1.Text := 'Load Btn Focused';
end;


end.
