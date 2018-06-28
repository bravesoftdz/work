unit USPreview;

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  ExtCtrls, SysUtils, ComCtrls, UCrpe32;

type
  TCrpePreviewDlg = class(TForm)
    cbKeepOpen: TCheckBox;
    btnPreview: TBitBtn;
    pnlPreview: TPanel;
    btnWindowZoom: TButton;
    btnWindowStyle: TButton;
    btnWindowButtonBar: TButton;
    btnWindowCursor: TBitBtn;
    btnWindowSize: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    cbWindowEvents: TCheckBox;
    rgInterfaceStyle: TRadioGroup;
    rgDialogHandle: TRadioGroup;
    rgWindowState: TRadioGroup;
    cbSetFocus: TCheckBox;
    btnHideWindow: TButton;
    btnShowWindow: TButton;
    btnCloseWindow: TButton;
    editSearch: TEdit;
    sbSearch: TSpeedButton;
    procedure rgInterfaceStyleClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgWindowStateClick(Sender: TObject);
    procedure UpdatePreviewForm;
    procedure FormShow(Sender: TObject);
    procedure cbWindowEventsClick(Sender: TObject);
    procedure btnWindowCursorClick(Sender: TObject);
    procedure btnHideWindowClick(Sender: TObject);
    procedure btnShowWindowClick(Sender: TObject);
    procedure btnCloseWindowClick(Sender: TObject);
    procedure cbSetFocusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnWindowButtonBarClick(Sender: TObject);
    procedure btnWindowSizeClick(Sender: TObject);
    procedure btnWindowStyleClick(Sender: TObject);
    procedure btnWindowZoomClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure editSearchKeyPress(Sender: TObject; var Key: Char);
    procedure sbSearchClick(Sender: TObject);
    procedure editSearchEnter(Sender: TObject);
    procedure editSearchExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpePreviewDlg: TCrpePreviewDlg;
  bPreview      : boolean;

implementation

{$R *.DFM}

uses
  UnitMain, UCrpeUtl, USWinEvents, UDWindowParent, UDWindowCursor,
  UDWindowButtonBar, UDWindowSize, UDWindowStyle, UDWindowZoom;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.FormCreate(Sender: TObject);
begin
  bPreview := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.FormShow(Sender: TObject);
begin
  rgInterfaceStyle.ItemIndex := 0;
  rgDialogHandle.ItemIndex := 0;
  rgDialogHandle.Enabled := False;
  cbWindowEvents.Enabled := (Cr.Version.Crpe.Major > 5);
  btnWindowCursor.Enabled := (Cr.Version.Crpe.Major > 5);
  {Reset items for non-Parent Window}
  rgInterfaceStyleClick(Self);
  UpdatePreviewForm;
end;
{------------------------------------------------------------------------------}
{ UpdatePreviewForm procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.UpdatePreviewForm;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    {WindowState}
    case Cr.WindowState of
      wsNormal    : rgWindowState.ItemIndex := 2;
      wsMinimized : rgWindowState.ItemIndex := 1;
      wsMaximized : rgWindowState.ItemIndex := 0;
    end;
    {WindowEvents}
    cbWindowEvents.Checked := Cr.WindowEvents;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TBitBtn then
        TBitBtn(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ Interface Style                                                              }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.rgInterfaceStyleClick(Sender: TObject);
begin
  case rgInterfaceStyle.ItemIndex of
    0: begin
         rgDialogHandle.Enabled := False;
         Cr.WindowButtonBar.Visible := True;
         Cr.WindowStyle.BorderStyle := bsSizeable;
         Cr.WindowStyle.SystemMenu := True;
       end;
    1: begin
         rgDialogHandle.Enabled := True;
         Cr.WindowButtonBar.Visible := False;
         Cr.WindowStyle.BorderStyle := bsNone;
         Cr.WindowStyle.SystemMenu := False;
       end;
  end;
end;
{------------------------------------------------------------------------------}
{ WindowState                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.rgWindowStateClick(Sender: TObject);
begin
  case rgWindowState.ItemIndex of
     0: Cr.WindowState := wsMaximized;
     1: Cr.WindowState := wsMinimized;
     2: Cr.WindowState := wsNormal;
  end;
end;
{------------------------------------------------------------------------------}
{ WindowEvents                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.cbWindowEventsClick(Sender: TObject);
begin
  Cr.WindowEvents := cbWindowEvents.Checked;
  if Cr.WindowEvents then
  begin
    Cr.wOnCloseWindow := frmMain.Crpe1wOnCloseWindow;
    Cr.wOnPrintBtnClick := frmMain.Crpe1wOnPrintBtnClick;
    Cr.wOnExportBtnClick := frmMain.Crpe1wOnExportBtnClick;
    Cr.wOnFirstPageBtnClick := frmMain.Crpe1wOnFirstPageBtnClick;
    Cr.wOnPreviousPageBtnClick := frmMain.Crpe1wOnPreviousPageBtnClick;
    Cr.wOnNextPageBtnClick := frmMain.Crpe1wOnNextPageBtnClick;
    Cr.wOnLastPageBtnClick := frmMain.Crpe1wOnLastPageBtnClick;
    Cr.wOnCancelBtnClick := frmMain.Crpe1wOnCancelBtnClick;
    Cr.wOnActivateWindow := frmMain.Crpe1wOnActivateWindow;
    Cr.wOnDeActivateWindow := frmMain.Crpe1wOnDeActivateWindow;
    Cr.wOnPrintSetupBtnClick := frmMain.Crpe1wOnPrintSetupBtnClick;
    Cr.wOnRefreshBtnClick := frmMain.Crpe1wOnRefreshBtnClick;
    Cr.wOnZoomLevelChange := frmMain.Crpe1wOnZoomLevelChange;
    Cr.wOnCloseBtnClick := frmMain.Crpe1wOnCloseBtnClick;
    Cr.wOnSearchBtnClick := frmMain.Crpe1wOnSearchBtnClick;
    Cr.wOnGroupTreeBtnClick := frmMain.Crpe1wOnGroupTreeBtnClick;
    Cr.wOnReadingRecords := frmMain.Crpe1wOnReadingRecords;
    Cr.wOnStartEvent := frmMain.Crpe1wOnStartEvent;
    Cr.wOnStopEvent := frmMain.Crpe1wOnStopEvent;
    Cr.wOnShowGroup := frmMain.Crpe1wOnShowGroup;
    Cr.wOnDrillGroup := frmMain.Crpe1wOnDrillGroup;
    Cr.wOnDrillDetail := frmMain.Crpe1wOnDrillDetail;
    Cr.wOnMouseClick := frmMain.Crpe1wOnMouseClick;
    Cr.wOnDrillHyperLink := frmMain.Crpe1wOnDrillHyperLink;
    Cr.wOnLaunchSeagateAnalysis := frmMain.Crpe1wOnLaunchSeagateAnalysis;
  end
  else
  begin
    Cr.wOnCloseWindow := nil;
    Cr.wOnPrintBtnClick := nil;
    Cr.wOnExportBtnClick := nil;
    Cr.wOnFirstPageBtnClick := nil;
    Cr.wOnPreviousPageBtnClick := nil;
    Cr.wOnNextPageBtnClick := nil;
    Cr.wOnLastPageBtnClick := nil;
    Cr.wOnCancelBtnClick := nil;
    Cr.wOnActivateWindow := nil;
    Cr.wOnDeActivateWindow := nil;
    Cr.wOnPrintSetupBtnClick := nil;
    Cr.wOnRefreshBtnClick := nil;
    Cr.wOnZoomLevelChange := nil;
    Cr.wOnCloseBtnClick := nil;
    Cr.wOnSearchBtnClick := nil;
    Cr.wOnGroupTreeBtnClick := nil;
    Cr.wOnReadingRecords := nil;
    Cr.wOnStartEvent := nil;
    Cr.wOnStopEvent := nil;
    Cr.wOnShowGroup := nil;
    Cr.wOnDrillGroup := nil;
    Cr.wOnDrillDetail := nil;
    Cr.wOnMouseClick := nil;
    Cr.wOnDrillHyperLink := nil;
    Cr.wOnLaunchSeagateAnalysis := nil;
  end;
end;
{------------------------------------------------------------------------------}
{ btnWindowCursorClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnWindowCursorClick(Sender: TObject);
begin
  if not bWindowCursor then
  begin
    CrpeWindowCursorDlg := TCrpeWindowCursorDlg.Create(Application);
    CrpeWindowCursorDlg.Cr := Cr;
  end;
  CrpeWindowCursorDlg.Show;
end;
{------------------------------------------------------------------------------}
{ btnWindowButtonBarClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnWindowButtonBarClick(Sender: TObject);
begin
  if not bWindowButtonBar then
  begin
    CrpeWindowButtonBarDlg := TCrpeWindowButtonBarDlg.Create(Application);
    CrpeWindowButtonBarDlg.Cr := Cr;
  end;
  CrpeWindowButtonBarDlg.Show;
end;
{------------------------------------------------------------------------------}
{ btnWindowSizeClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnWindowSizeClick(Sender: TObject);
begin
  if not bWindowSize then
  begin
    CrpeWindowSizeDlg := TCrpeWindowSizeDlg.Create(Application);
    CrpeWindowSizeDlg.Cr := Cr;
  end;
  CrpeWindowSizeDlg.Show;
end;
{------------------------------------------------------------------------------}
{ btnWindowStyleClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnWindowStyleClick(Sender: TObject);
begin
  if not bWindowStyle then
  begin
    CrpeWindowStyleDlg := TCrpeWindowStyleDlg.Create(Application);
    CrpeWindowStyleDlg.Cr := Cr;
  end;
  CrpeWindowStyleDlg.Show;
end;
{------------------------------------------------------------------------------}
{ btnWindowZoomClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnWindowZoomClick(Sender: TObject);
begin
  if not bWindowZoom then
  begin
    CrpeWindowZoomDlg := TCrpeWindowZoomDlg.Create(Application);
    CrpeWindowZoomDlg.Cr := Cr;
  end;
  CrpeWindowZoomDlg.Show;
end;
{------------------------------------------------------------------------------}
{ Set Focus click                                                              }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.cbSetFocusClick(Sender: TObject);
begin
  if cbSetFocus.Checked then
  begin
    if not Cr.Focused then
      Cr.SetFocus;
  end;
end;
{------------------------------------------------------------------------------}
{ editSearchEnter                                                              }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.editSearchEnter(Sender: TObject);
begin
  btnOk.Default := False;
end;
{------------------------------------------------------------------------------}
{ editSearchExit                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.editSearchExit(Sender: TObject);
begin
  btnOk.Default := True;
end;
{------------------------------------------------------------------------------}
{ editSearchKeyPress                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.editSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Ord(Key) = 13 then
    sbSearchClick(Self);
end;
{------------------------------------------------------------------------------}
{ sbSearchClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.sbSearchClick(Sender: TObject);
begin
  Cr.Search(editSearch.Text);
end;
{------------------------------------------------------------------------------}
{ Preview Button                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnPreviewClick(Sender: TObject);
var
  prevOut : TCrOutput;
begin
  SaveFormPos(Self);
  {WindowEvents}
  if Cr.WindowEvents = True then
  begin
    if not bWindowEventsDlg then
      CrpeWindowEventsDlg := TCrpeWindowEventsDlg.Create(Application);
    CrpeWindowEventsDlg.Show;
  end;

  {Check Interface Style: Parent or Crystal Window}
  if rgInterfaceStyle.ItemIndex = 1 then
  begin
    {Create Parent Window}
    if not bWindowParent then
    begin
      CrpeWindowParentDlg := TCrpeWindowParentDlg.Create(Application);
      CrpeWindowParentDlg.Cr := Cr;
    end;

    {Size Parent Window from the VCL WindowSize settings}
    if Cr.WindowSize.Top > -1 then
      CrpeWindowParentDlg.Top := Cr.WindowSize.Top;
    if Cr.WindowSize.Left > -1 then
      CrpeWindowParentDlg.Left := Cr.WindowSize.Left;
    if Cr.WindowSize.Width > -1 then
      CrpeWindowParentDlg.Width := Cr.WindowSize.Width;
    if Cr.WindowSize.Height > -1 then
      CrpeWindowParentDlg.Height := Cr.WindowSize.Height;

    {Attach Crystal Window to Parent Window}
    Cr.WindowParent := CrpeWindowParentDlg;

    {Set ParentWindow WindowState to Crpe WindowState}
    CrpeWindowParentDlg.WindowState := Cr.WindowState;
    {If minimized, set the Crpe Window to Normal}
    if Cr.WindowState = wsMinimized then
      Cr.WindowState := wsNormal;

    {Set Parent Caption to Crpe WindowTitle}
    CrpeWindowParentDlg.Caption := Cr.WindowStyle.Title;

    {Crystal Window Size Settings}
    Cr.WindowSize.Top := CrpeWindowParentDlg.pnlBtnBar.Height;
    Cr.WindowSize.Left := 0;
    Cr.WindowSize.Height := CrpeWindowParentDlg.ClientHeight;
    Cr.WindowSize.Width := CrpeWindowParentDlg.ClientWidth;

    Cr.WindowStyle.SystemMenu := False;
    Cr.WindowStyle.BorderStyle := bsNone;

    {Check Dialog Handle}
    if rgDialogHandle.ItemIndex = 0 then
      Cr.DialogParent := nil
    else
      Cr.DialogParent := CrpeWindowParentDlg;

    {Show the Parent Form}
    CrpeWindowParentDlg.Show;
  end
  else
  begin
    Cr.WindowParent := nil;
    Cr.DialogParent := nil;
  end;
  {Preserve previous Output setting}
  prevOut := Cr.Output;
  {Set Output and Execute}
  Cr.Output := toWindow;

  {Run the Report}
  if Cr.Execute then
  begin
    frmMain.btnDiscardSavedData.Enabled := Cr.HasSavedData;
    frmMain.miDiscardSavedData.Enabled := Cr.HasSavedData;
  end;
  {Restore Output setting}
  Cr.Output := prevOut;

  if cbSetFocus.Checked then
  begin
    if not Cr.Focused then
      Cr.SetFocus;
  end;

  if not cbKeepOpen.Checked then
    Close;
end;
{------------------------------------------------------------------------------}
{ btnHideWindowClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnHideWindowClick(Sender: TObject);
begin
  Cr.HideWindow;
end;
{------------------------------------------------------------------------------}
{ btnShowWindowClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnShowWindowClick(Sender: TObject);
begin
  Cr.ShowWindow;
end;
{------------------------------------------------------------------------------}
{ btnCloseWindowClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnCloseWindowClick(Sender: TObject);
begin
  Cr.CloseWindow;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePreviewDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bPreview := False;
  Release;
end;


end.


