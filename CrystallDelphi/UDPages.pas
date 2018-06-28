unit UDPages;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpePagesDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlPages: TPanel;
    editStartPageNumber: TEdit;
    lblStartPageNumber: TLabel;
    sbFirst: TSpeedButton;
    sbPrevious: TSpeedButton;
    sbNext: TSpeedButton;
    sbLast: TSpeedButton;
    pnlMonitor: TPanel;
    cbMonitor: TCheckBox;
    Label1: TLabel;
    editStart: TEdit;
    Label2: TLabel;
    editLatest: TEdit;
    Label3: TLabel;
    editDisplayed: TEdit;
    btnGoToPage: TButton;
    editGoToPage: TEdit;
    Timer1: TTimer;
    lblInstructions: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdatePages;
    procedure InitializeControls(OnOff: boolean);
    procedure sbFirstClick(Sender: TObject);
    procedure sbPreviousClick(Sender: TObject);
    procedure btnGoToPageClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure cbMonitorClick(Sender: TObject);
    procedure editGoToPageEnter(Sender: TObject);
    procedure editGoToPageExit(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure editStartPageNumberEnter(Sender: TObject);
    procedure editStartPageNumberExit(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr         : TCrpe;
    rStartPage : LongInt;
    PrevNum    : string;
  end;

var
  CrpePagesDlg: TCrpePagesDlg;
  bPages      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.FormCreate(Sender: TObject);
begin
  bPages := True;
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.FormShow(Sender: TObject);
begin
  {Store current VCL settings}
  rStartPage := Cr.Pages.StartPageNumber;
  editGoToPage.Text := '1';
  editStartPageNumber.Text := '1';
  UpdatePages;
end;
{------------------------------------------------------------------------------}
{ UpdatePages                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.UpdatePages;
var
  OnOff : Boolean;
begin
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    editStartPageNumber.Text := IntToStr(Cr.Pages.StartPageNumber);
    cbMonitor.Checked := (Cr.ReportWindowHandle > 0);
    Timer1.Enabled := cbMonitor.Checked;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TSpeedButton then
        TSpeedButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TEdit then
      begin
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ sbFirstClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.sbFirstClick(Sender: TObject);
begin
  Cr.Pages.First;
end;
{------------------------------------------------------------------------------}
{ sbPreviousClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.sbPreviousClick(Sender: TObject);
begin
  Cr.Pages.Previous;
end;
{------------------------------------------------------------------------------}
{ btnGoToPageClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.btnGoToPageClick(Sender: TObject);
begin
  if IsNumeric(editGoToPage.Text) then
    Cr.Pages.GoToPage(StrToInt(editGoToPage.Text));
end;
{------------------------------------------------------------------------------}
{ sbNextClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.sbNextClick(Sender: TObject);
begin
  Cr.Pages.Next;
end;
{------------------------------------------------------------------------------}
{ sbLastClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.sbLastClick(Sender: TObject);
begin
  Cr.Pages.Last;
end;
{------------------------------------------------------------------------------}
{ editGoToPageEnter                                                            }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.editGoToPageEnter(Sender: TObject);
begin
  PrevNum := editGoToPage.Text;
end;
{------------------------------------------------------------------------------}
{ editGoToPageExit                                                             }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.editGoToPageExit(Sender: TObject);
begin
  if not IsNumeric(editGoToPage.Text) then
    editGoToPage.Text := PrevNum;
end;
{------------------------------------------------------------------------------}
{ editStartPageNumberEnter                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.editStartPageNumberEnter(Sender: TObject);
begin
  PrevNum := editStartPageNumber.Text;
end;
{------------------------------------------------------------------------------}
{ editStartPageNumberExit                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.editStartPageNumberExit(Sender: TObject);
begin
  if not IsNumeric(editStartPageNumber.Text) then
    editStartPageNumber.Text := PrevNum;
  Cr.Pages.StartPageNumber := StrToInt(editStartPageNumber.Text);
end;
{------------------------------------------------------------------------------}
{ cbMonitorClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.cbMonitorClick(Sender: TObject);
begin
  Timer1.Enabled := (Cr.ReportWindowHandle > 0) and cbMonitor.Checked;
end;
{------------------------------------------------------------------------------}
{ Timer1Timer                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.Timer1Timer(Sender: TObject);
begin
  editStart.Text := IntToStr(Cr.Pages.GetStart);
  editLatest.Text := IntToStr(Cr.Pages.GetLatest);
  editDisplayed.Text := IntToStr(Cr.Pages.GetDisplayed);
  cbMonitor.Checked := (Cr.ReportWindowHandle > 0);
  Timer1.Enabled := cbMonitor.Checked;
end;
{------------------------------------------------------------------------------}
{ FormDeactivate                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.FormDeactivate(Sender: TObject);
begin
  if not IsStrEmpty(Cr.ReportName) then
  begin
    editGoToPageExit(Self);
    editStartPageNumberExit(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  if not IsStrEmpty(Cr.ReportName) then
  begin
    editGoToPageExit(Self);
    editStartPageNumberExit(Self);
  end;
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePagesDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  if ModalResult = mrCancel then
    Cr.Pages.StartPageNumber := rStartPage;
  bPages := False;
  Release;
end;


end.
