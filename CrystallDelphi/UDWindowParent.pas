unit UDWindowParent;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Buttons, StdCtrls, ExtCtrls, Dialogs, UCrpe32;

type
  TCrpeWindowParentDlg = class(TForm)
    pnlBtnBar: TPanel;
    cbZoom: TComboBox;
    sbClose: TSpeedButton;
    pnlStatus: TPanel;
    pnlReportName: TPanel;
    lblExplanation: TLabel;
    sbPrint: TSpeedButton;
    sbExport: TSpeedButton;
    sbPageNext: TSpeedButton;
    sbPageFirst: TSpeedButton;
    sbPagePrev: TSpeedButton;
    sbPageLast: TSpeedButton;
    cbPage: TComboBox;
    sbZoom1: TSpeedButton;
    sbZoom2: TSpeedButton;
    sbZoom3: TSpeedButton;
    lblPages: TLabel;
    pnlRecordsRead: TPanel;
    lblRead: TLabel;
    pnlRecordsSelected: TPanel;
    lblSelected: TLabel;
    pnlRecordsPrinted: TPanel;
    lblRecordsPrinted: TLabel;
    Timer1: TTimer;
    lblPrinted: TLabel;
    lblRecordsSelected: TLabel;
    lblRecordsRead: TLabel;
    sbCancel: TSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbZoomChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbPrintClick(Sender: TObject);
    procedure sbExportClick(Sender: TObject);
    procedure sbPageFirstClick(Sender: TObject);
    procedure sbPagePrevClick(Sender: TObject);
    procedure sbPageNextClick(Sender: TObject);
    procedure sbPageLastClick(Sender: TObject);
    procedure sbZoom1Click(Sender: TObject);
    procedure sbZoom2Click(Sender: TObject);
    procedure sbZoom3Click(Sender: TObject);
    procedure cbPageChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    PagePlus : string;
  end;

var
  CrpeWindowParentDlg  : TCrpeWindowParentDlg;
  bWindowParent        : boolean;
  iPreventInfiniteLoop : integer;

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.FormCreate(Sender: TObject);
begin
  iPreventInfiniteLoop := 0;
  bWindowParent := True;
  PagePlus := '+';
  Timer1.Enabled := True;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.FormShow(Sender: TObject);
begin
  cbPage.OnChange := nil;
  {Set zoom combo box}
  cbZoom.ItemIndex := Cr.WindowZoom.Magnification;
  {Set up the Page combo box}
  cbPage.Clear;
  cbPage.Items.Add('1');
  cbPage.ItemIndex := 0;
  lblPages.Caption := 'of 1' + PagePlus;
  cbPage.OnChange := cbPageChange;
  SetFocus;
end;
{------------------------------------------------------------------------------}
{ Timer1Timer procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.Timer1Timer(Sender: TObject);
var
  temp1,
  temp2,
  temp3 : string;
begin
  {Update Status Display}
  Str(Cr.Records.Printed, temp1);
  Str(Cr.Records.Read, temp2);
  Str(Cr.Records.Selected, temp3);
  lblRecordsPrinted.Caption := temp1 + ' ';
  lblRecordsRead.Caption := temp2 + ' ';
  lblRecordsSelected.Caption := temp3 + ' ';
  if Cr.Status = crsJobCompleted then
  begin
    Timer1.Enabled := False;
    sbPrint.Enabled := True;
    sbExport.Enabled := True;
    sbPageNext.Enabled := True;
    sbPageFirst.Enabled := True;
    sbPagePrev.Enabled := True;
    sbPageLast.Enabled := True;
    cbPage.Enabled := True;
    sbZoom1.Enabled := True;
    sbZoom2.Enabled := True;
    sbZoom3.Enabled := True;
    cbZoom.Enabled := True;
  end;
end;
{------------------------------------------------------------------------------}
{ sbPrintClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbPrintClick(Sender: TObject);
begin
  Cr.PrintWindow;
end;
{------------------------------------------------------------------------------}
{ sbExportClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbExportClick(Sender: TObject);
begin
  Cr.ExportWindow(False); {default to disk file}
//  Cr.ExportWindow(True);  {default to application}
end;
{------------------------------------------------------------------------------}
{ cbZoomChange procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.cbZoomChange(Sender: TObject);
begin
  Cr.WindowZoom.Magnification := StrToInt(cbZoom.Items[cbZoom.ItemIndex]);
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbZoom1Click procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbZoom1Click(Sender: TObject);
begin
  Cr.WindowZoom.Preview := pwNormal;
  cbZoom.ItemIndex := 3;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbZoom2Click procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbZoom2Click(Sender: TObject);
begin
  Cr.WindowZoom.Preview := pwPageWidth;
  cbZoom.ItemIndex := -1;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbZoom3Click procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbZoom3Click(Sender: TObject);
begin
  Cr.WindowZoom.Preview := pwWholePage;
  cbZoom.ItemIndex := -1;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbPageFirstClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbPageFirstClick(Sender: TObject);
begin
  cbPage.OnChange := nil;
  Cr.Pages.First;
  {Loop until page is drawn}
  while Cr.Status <> crsJobCompleted do
    Application.ProcessMessages;
  cbPage.ItemIndex := 0;
  cbPage.OnChange := cbPageChange;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbPagePrevClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbPagePrevClick(Sender: TObject);
var
  pg1: integer;
begin
  cbPage.OnChange := nil;
  Cr.Pages.Previous;
  {Loop until page is drawn}
  while Cr.Status <> crsJobCompleted do
    Application.ProcessMessages;
  pg1 := Cr.Pages.GetDisplayed;
  {Update the Page Number}
  cbPage.ItemIndex := pg1 - 1;
  cbPage.OnChange := cbPageChange;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbPageNextClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbPageNextClick(Sender: TObject);
var
  pg1,pg2,pg3 : integer;
  cnt         : integer;
begin
  cbPage.OnChange := nil;
  {Get the Displayed page number}
  pg1 := Cr.Pages.GetDisplayed;
  {Show the next page}
  Cr.Pages.Next;
  {Loop until page is drawn}
  while Cr.Status <> crsJobCompleted do
    Application.ProcessMessages;
  {Get the Displayed page number}
  pg2 := Cr.Pages.GetDisplayed;
  {Get the Latest page number}
  pg3 := Cr.Pages.GetLatest;

  {If the Latest Page number increased, add to the combo box}
  if pg3 > cbPage.Items.Count then
  begin
    for cnt := (cbPage.Items.Count + 1) to pg3 do
      cbPage.Items.Add(IntToStr(cnt));
  end;
  {if Page number stayed the same, it is the Last Page}
  if pg2 = pg1 then
    PagePlus := '';
  {Update the Page Number}
  cbPage.ItemIndex := pg2 - 1;
  {Redraw the Pages Label}
  lblPages.Caption := 'of ' + IntToStr(pg3) + PagePlus;
  cbPage.OnChange := cbPageChange;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbPageLastClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbPageLastClick(Sender: TObject);
var
  pg1  : integer;
  cnt1 : integer;
begin
  cbPage.OnChange := nil;
  Cr.Pages.Last;
  while Cr.Status <> crsJobCompleted do
    Application.ProcessMessages;
  pg1 := Cr.Pages.GetLatest;
  {If the Page number increased, add to the combo box}
  if pg1 > cbPage.Items.Count then
  begin
    for cnt1 := (cbPage.Items.Count + 1) to pg1 do
      cbPage.Items.Add(IntToStr(cnt1));
  end;
  cbPage.ItemIndex := pg1 - 1;
  {Redraw the Pages Label}
  PagePlus := '';
  lblPages.Caption := 'of ' + IntToStr(pg1);
  cbPage.OnChange := cbPageChange;
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbPageChange procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.cbPageChange(Sender: TObject);
var
  nPage : smallint;
begin
  nPage := StrToInt(cbPage.Items[cbPage.ItemIndex]);
  {The ShowPage call seems to cause the CRPE to
   finish printing all the records}
  Cr.Pages.GoToPage(nPage);
  pnlBtnBar.SetFocus;
end;
{------------------------------------------------------------------------------}
{ FormResize procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.FormResize(Sender: TObject);
var
  WinHandle: hWnd;
begin
  WinHandle := Cr.ReportWindowHandle;
  SetWindowPos(WinHandle, HWND_TOP, 0, pnlBtnBar.Height, ClientWidth,
    ClientHeight - pnlBtnBar.Height - pnlStatus.Height, SWP_NOZORDER);
end;
{------------------------------------------------------------------------------}
{ sbCancelClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbCancelClick(Sender: TObject);
begin
  Cr.CancelJob;
end;
{------------------------------------------------------------------------------}
{ sbCloseClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.sbCloseClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeWindowParentDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  {This is to prevent shutting the window before either
   the PrintJob is finished processing or before the window
   has finished drawing: either case can cause a crash}
  if (not Cr.CanCloseEngine) and (iPreventInfiniteLoop < 3) then
  begin
    Inc(iPreventInfiniteLoop);
    Cr.CancelJob;
    Action := caNone;
    Exit;
  end;
  Cr.CloseWindow;
  bWindowParent := False;
  Release;
end;


end.
