unit USActvEvents;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, StdCtrls, ExtCtrls, Buttons;

type
  TCrpeActiveEventsDlg = class(TForm)
    pnlActivatedEvents: TPanel;
    gbButtonEvents: TGroupBox;
    cbCancelBtn: TCheckBox;
    cbCloseBtn: TCheckBox;
    cbExportBtn: TCheckBox;
    cbGroupTreeBtn: TCheckBox;
    cbPrintBtn: TCheckBox;
    cbPrintSetupBtn: TCheckBox;
    cbRefreshBtn: TCheckBox;
    cbSearchBtn: TCheckBox;
    cbZoomLevel: TCheckBox;
    gbPagingBtnEvents: TGroupBox;
    cbFirstPageBtn: TCheckBox;
    cbPreviousPageBtn: TCheckBox;
    cbNextPageBtn: TCheckBox;
    cbLastPageBtn: TCheckBox;
    gbWindowEvents: TGroupBox;
    cbActivateWindow: TCheckBox;
    cbDeActivateWindow: TCheckBox;
    cbCloseWindow: TCheckBox;
    gbDrillDownEvents: TGroupBox;
    cbShowGroup: TCheckBox;
    cbDrillGroup: TCheckBox;
    cbDrillDetail: TCheckBox;
    gbOtherEvents: TGroupBox;
    cbReadingRecords: TCheckBox;
    cbStartEvent: TCheckBox;
    cbStopEvent: TCheckBox;
    cbButtonEvents: TCheckBox;
    cbPagingButtonEvents: TCheckBox;
    cbWindowStateEvents: TCheckBox;
    cbDrillDownEvents: TCheckBox;
    cbOtherEvents: TCheckBox;
    cbMouseClick: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    cbWindowEvents: TCheckBox;
    cbDrillHyperLink: TCheckBox;
    cbLaunchBtn: TCheckBox;
    btnSave: TButton;
    btnReload: TButton;
    procedure cbButtonEventsClick(Sender: TObject);
    procedure cbPagingButtonEventsClick(Sender: TObject);
    procedure cbWindowStateEventsClick(Sender: TObject);
    procedure cbDrillDownEventsClick(Sender: TObject);
    procedure cbOtherEventsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbWindowEventsClick(Sender: TObject);
    procedure UpdateActiveEvents;
    procedure InitializeControls(OnOff: boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
  private
  public
  end;

var
  CrpeActiveEventsDlg: TCrpeActiveEventsDlg;

implementation

uses UCrpe32, UCrpeUtl, UnitMain, Registry;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.FormShow(Sender: TObject);
begin
  cbWindowEvents.Tag := 1;
  cbWindowEvents.Checked := frmMain.Crpe1.WindowEvents;
  UpdateActiveEvents;
end;
{------------------------------------------------------------------------------}
{ UpdateActiveEvents                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.UpdateActiveEvents;
var
  OnOff : Boolean;
begin
  {Cancel Button}
  cbCancelBtn.Checked := Assigned(frmMain.Crpe1.wOnCancelBtnClick);
  {Close Button}
  cbCloseBtn.Checked := Assigned(frmMain.Crpe1.wOnCloseBtnClick);
  {Export Button}
  cbExportBtn.Checked := Assigned(frmMain.Crpe1.wOnExportBtnClick);
  {GroupTree Button}
  cbGroupTreeBtn.Checked := Assigned(frmMain.Crpe1.wOnGroupTreeBtnClick);
  {Launch SA Button}
  cbLaunchBtn.Checked := Assigned(frmMain.Crpe1.wOnLaunchSeagateAnalysis);
  {Print Button}
  cbPrintBtn.Checked := Assigned(frmMain.Crpe1.wOnPrintBtnClick);
  {Print Setup Button}
  cbPrintSetupBtn.Checked := Assigned(frmMain.Crpe1.wOnPrintSetupBtnClick);
  {Refresh Button}
  cbRefreshBtn.Checked := Assigned(frmMain.Crpe1.wOnRefreshBtnClick);
  {Search Button}
  cbSearchBtn.Checked := Assigned(frmMain.Crpe1.wOnSearchBtnClick);
  {Zoom Level}
  cbZoomLevel.Checked := Assigned(frmMain.Crpe1.wOnZoomLevelChange);
  {FirstPage Button}
  cbFirstPageBtn.Checked := Assigned(frmMain.Crpe1.wOnFirstPageBtnClick);
  {PreviousPage Button}
  cbPreviousPageBtn.Checked := Assigned(frmMain.Crpe1.wOnPreviousPageBtnClick);
  {NextPage Button}
  cbNextPageBtn.Checked := Assigned(frmMain.Crpe1.wOnNextPageBtnClick);
  {LastPage Button}
  cbLastPageBtn.Checked := Assigned(frmMain.Crpe1.wOnLastPageBtnClick);
  {Activate Window}
  cbActivateWindow.Checked := Assigned(frmMain.Crpe1.wOnCloseBtnClick);
  {DeActivate Window}
  cbDeActivateWindow.Checked := Assigned(frmMain.Crpe1.wOnActivateWindow);
  {Close Window}
  cbCloseWindow.Checked := Assigned(frmMain.Crpe1.wOnCloseWindow);
  {Show Group}
  cbShowGroup.Checked := Assigned(frmMain.Crpe1.wOnShowGroup);
  {Drill Group}
  cbDrillGroup.Checked := Assigned(frmMain.Crpe1.wOnDrillGroup);
  {Drill Detail}
  cbDrillDetail.Checked := Assigned(frmMain.Crpe1.wOnDrillDetail);
  {Drill Hyperlink}
  cbDrillHyperlink.Checked := Assigned(frmMain.Crpe1.wOnDrillHyperlink);
  {Reading Records}
  cbReadingRecords.Checked := Assigned(frmMain.Crpe1.wOnReadingRecords);
  {Start Event}
  cbStartEvent.Checked := Assigned(frmMain.Crpe1.wOnStartEvent);
  {Stop Event}
  cbStopEvent.Checked := Assigned(frmMain.Crpe1.wOnStopEvent);
  {RightMouseClick Event}
  cbMouseClick.Checked := Assigned(frmMain.Crpe1.wOnMouseClick);

  {Activate/DeActivate the Group checkboxes}
  if cbCancelBtn.Checked and cbCloseBtn.Checked and
     cbExportBtn.Checked and cbGroupTreeBtn.Checked and
     cbPrintBtn.Checked and cbPrintSetupBtn.Checked and
     cbRefreshBtn.Checked and cbSearchBtn.Checked and
     cbZoomLevel.Checked and cbLaunchBtn.Checked then
    cbButtonEvents.Checked := True
  else
    cbButtonEvents.Checked := False;

  if cbFirstPageBtn.Checked and cbPreviousPageBtn.Checked and
     cbNextPageBtn.Checked and cbLastPageBtn.Checked then
    cbPagingButtonEvents.Checked := True
  else
    cbPagingButtonEvents.Checked := False;

  if cbActivateWindow.Checked and cbDeActivateWindow.Checked and
     cbCloseWindow.Checked then
    cbWindowStateEvents.Checked := True
  else
    cbWindowStateEvents.Checked := False;

  if cbShowGroup.Checked and cbDrillGroup.Checked and
     cbDrillDetail.Checked and cbDrillHyperlink.Checked then
    cbDrillDownEvents.Checked := True
  else
    cbDrillDownEvents.Checked := False;

  if cbReadingRecords.Checked and cbStartEvent.Checked and
     cbStopEvent.Checked then
    cbOtherEvents.Checked := True
  else
    cbOtherEvents.Checked := False;

  {Enable/Disable the checkboxes}
  OnOff := cbWindowEvents.Checked;
  InitializeControls(OnOff);
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbWindowEventsClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.cbWindowEventsClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  OnOff := cbWindowEvents.Checked;
  InitializeControls(OnOff);
end;
{------------------------------------------------------------------------------}
{ cbButtonEventsClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.cbButtonEventsClick(Sender: TObject);
begin
  cbCancelBtn.Checked := cbButtonEvents.Checked;
  cbCloseBtn.Checked := cbButtonEvents.Checked;
  cbExportBtn.Checked := cbButtonEvents.Checked;
  cbGroupTreeBtn.Checked := cbButtonEvents.Checked;
  cbLaunchBtn.Checked := cbButtonEvents.Checked;
  cbPrintBtn.Checked := cbButtonEvents.Checked;
  cbPrintSetupBtn.Checked := cbButtonEvents.Checked;
  cbRefreshBtn.Checked := cbButtonEvents.Checked;
  cbSearchBtn.Checked := cbButtonEvents.Checked;
  cbZoomLevel.Checked := cbButtonEvents.Checked;
end;
{------------------------------------------------------------------------------}
{ cbPagingButtonEventsClick                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.cbPagingButtonEventsClick(Sender: TObject);
begin
  cbFirstPageBtn.Checked := cbPagingButtonEvents.Checked;
  cbPreviousPageBtn.Checked := cbPagingButtonEvents.Checked;
  cbNextPageBtn.Checked := cbPagingButtonEvents.Checked;
  cbLastPageBtn.Checked := cbPagingButtonEvents.Checked;
end;
{------------------------------------------------------------------------------}
{ cbWindowStateEventsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.cbWindowStateEventsClick(Sender: TObject);
begin
  cbActivateWindow.Checked := cbWindowStateEvents.Checked;
  cbDeActivateWindow.Checked := cbWindowStateEvents.Checked;
  cbCloseWindow.Checked := cbWindowStateEvents.Checked;
end;
{------------------------------------------------------------------------------}
{ cbDrillDownEventsClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.cbDrillDownEventsClick(Sender: TObject);
begin
  cbShowGroup.Checked := cbDrillDownEvents.Checked;
  cbDrillGroup.Checked := cbDrillDownEvents.Checked;
  cbDrillDetail.Checked := cbDrillDownEvents.Checked;
  cbDrillHyperLink.Checked := cbDrillDownEvents.Checked;
end;
{------------------------------------------------------------------------------}
{ cbOtherEventsClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.cbOtherEventsClick(Sender: TObject);
begin
  cbReadingRecords.Checked := cbOtherEvents.Checked;
  cbStartEvent.Checked := cbOtherEvents.Checked;
  cbStopEvent.Checked := cbOtherEvents.Checked;
  cbMouseClick.Checked := cbOtherEvents.Checked;
end;
{------------------------------------------------------------------------------}
{ btnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.btnOKClick(Sender: TObject);
begin
  frmMain.Crpe1.wOnCancelBtnClick := nil;
  frmMain.Crpe1.wOnCloseBtnClick := nil;
  frmMain.Crpe1.wOnExportBtnClick := nil;
  frmMain.Crpe1.wOnGroupTreeBtnClick := nil;
  frmMain.Crpe1.wOnPrintBtnClick := nil;
  frmMain.Crpe1.wOnPrintSetupBtnClick := nil;
  frmMain.Crpe1.wOnRefreshBtnClick := nil;
  frmMain.Crpe1.wOnSearchBtnClick := nil;
  frmMain.Crpe1.wOnZoomLevelChange := nil;
  frmMain.Crpe1.wOnFirstPageBtnClick := nil;
  frmMain.Crpe1.wOnPreviousPageBtnClick := nil;
  frmMain.Crpe1.wOnNextPageBtnClick := nil;
  frmMain.Crpe1.wOnDeActivateWindow := nil;
  frmMain.Crpe1.wOnCloseWindow := nil;
  frmMain.Crpe1.wOnShowGroup := nil;
  frmMain.Crpe1.wOnStopEvent := nil;
  frmMain.Crpe1.wOnDrillGroup := nil;
  frmMain.Crpe1.wOnDrillDetail := nil;
  frmMain.Crpe1.wOnStartEvent := nil;
  frmMain.Crpe1.wOnReadingRecords := nil;
  frmMain.Crpe1.wOnMouseClick := nil;
  frmMain.Crpe1.wOnLastPageBtnClick := nil;
  frmMain.Crpe1.wOnActivateWindow := nil;
  frmMain.Crpe1.wOnLaunchSeagateAnalysis := nil;
  frmMain.Crpe1.wOnDrillHyperlink := nil;

  if cbWindowEvents.Checked then
  begin
    {Cancel Button}
    if cbCancelBtn.Checked then
      frmMain.Crpe1.wOnCancelBtnClick := frmMain.Crpe1wOnCancelBtnClick;
    {Close Button}
    if cbCloseBtn.Checked then
      frmMain.Crpe1.wOnCloseBtnClick := frmMain.Crpe1wOnCloseBtnClick;
    {Export Button}
    if cbExportBtn.Checked then
      frmMain.Crpe1.wOnExportBtnClick := frmMain.Crpe1wOnExportBtnClick;
    {GroupTree Button}
    if cbGroupTreeBtn.Checked then
      frmMain.Crpe1.wOnGroupTreeBtnClick := frmMain.Crpe1wOnGroupTreeBtnClick;
    {Print Button}
    if cbPrintBtn.Checked then
      frmMain.Crpe1.wOnPrintBtnClick := frmMain.Crpe1wOnPrintBtnClick;
    {Print Setup Button}
    if cbPrintSetupBtn.Checked then
      frmMain.Crpe1.wOnPrintSetupBtnClick := frmMain.Crpe1wOnPrintSetupBtnClick;
    {Refresh Button}
    if cbRefreshBtn.Checked then
      frmMain.Crpe1.wOnRefreshBtnClick := frmMain.Crpe1wOnRefreshBtnClick;
    {Search Button}
    if cbSearchBtn.Checked then
      frmMain.Crpe1.wOnSearchBtnClick := frmMain.Crpe1wOnSearchBtnClick;
    {Zoom Level}
    if cbZoomLevel.Checked then
      frmMain.Crpe1.wOnZoomLevelChange := frmMain.Crpe1wOnZoomLevelChange;
    {FirstPage Button}
    if cbFirstPageBtn.Checked then
      frmMain.Crpe1.wOnFirstPageBtnClick := frmMain.Crpe1wOnFirstPageBtnClick;
    {PreviousPage Button}
    if cbPreviousPageBtn.Checked then
      frmMain.Crpe1.wOnPreviousPageBtnClick := frmMain.Crpe1wOnPreviousPageBtnClick;
    {NextPage Button}
    if cbNextPageBtn.Checked then
      frmMain.Crpe1.wOnNextPageBtnClick := frmMain.Crpe1wOnNextPageBtnClick;
    {LastPage Button}
    if cbLastPageBtn.Checked then
      frmMain.Crpe1.wOnLastPageBtnClick := frmMain.Crpe1wOnLastPageBtnClick;
    {Activate Window}
    if cbActivateWindow.Checked then
      frmMain.Crpe1.wOnActivateWindow := frmMain.Crpe1wOnActivateWindow;
    {DeActivate Window}
    if cbDeActivateWindow.Checked then
      frmMain.Crpe1.wOnDeActivateWindow := frmMain.Crpe1wOnDeActivateWindow;
    {Close Window}
    if cbCloseWindow.Checked then
      frmMain.Crpe1.wOnCloseWindow := frmMain.Crpe1wOnCloseWindow;
    {Show Group}
    if cbShowGroup.Checked then
      frmMain.Crpe1.wOnShowGroup := frmMain.Crpe1wOnShowGroup;
    {Drill Group}
    if cbDrillGroup.Checked then
      frmMain.Crpe1.wOnDrillGroup := frmMain.Crpe1wOnDrillGroup;
    {Drill Detail}
    if cbDrillDetail.Checked then
      frmMain.Crpe1.wOnDrillDetail := frmMain.Crpe1wOnDrillDetail;
    {Reading Records}
    if cbReadingRecords.Checked then
      frmMain.Crpe1.wOnReadingRecords := frmMain.Crpe1wOnReadingRecords;
    {Start Event}
    if cbStartEvent.Checked then
      frmMain.Crpe1.wOnStartEvent := frmMain.Crpe1wOnStartEvent;
    {Stop Event}
    if cbStopEvent.Checked then
      frmMain.Crpe1.wOnStopEvent := frmMain.Crpe1wOnStopEvent;
    {RightMouseClick Event}
    if cbMouseClick.Checked then
      frmMain.Crpe1.wOnMouseClick := frmMain.Crpe1wOnMouseClick;
    {Launch Seagate Analysis Event}
    if cbLaunchBtn.Checked then
      frmMain.Crpe1.wOnLaunchSeagateAnalysis := frmMain.Crpe1wOnLaunchSeagateAnalysis;
    {Drill Hyperlink Event}
    if cbDrillHyperlink.Checked then
      frmMain.Crpe1.wOnDrillHyperlink := frmMain.Crpe1wOnDrillHyperlink;
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ btnSaveClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.btnSaveClick(Sender: TObject);
var
  RegIni : TRegIniFile;
  i      : integer;
  s1     : string;
begin
  {Read the status of the checkboxes}
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
      s1 := s1 + IntToStr(Ord(TCheckBox(Components[i]).Checked));
  end;

  {Write to the Registry}
  RegIni := TRegIniFile.Create('Software\Crystal Decisions\10.0\CrystalVCL\');
  try
    RegIni.WriteString('Sample Application','WindowEventsState',s1);
  finally
    RegIni.Free;
  end;
end;
{------------------------------------------------------------------------------}
{ btnReloadClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.btnReloadClick(Sender: TObject);
var
  RegIni : TRegIniFile;
  i      : integer;
  s1     : string;
begin
  {Read the Registry}
  RegIni := TRegIniFile.Create('Software\Crystal Decisions\10.0\CrystalVCL\');
  try
    s1 := RegIni.ReadString('Sample Application','WindowEventsState','');
  finally
    RegIni.Free;
  end;

  {Set the status of the checkboxes}
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
    begin
      if Length(s1) < 1 then Break;
      TCheckBox(Components[i]).Checked := (s1[1] = '1');
      s1 := Copy(s1,2,Length(s1)-1);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeActiveEventsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CrpeActiveEventsDlg := nil;
  Release;
end;



end.
