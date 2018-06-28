unit UDMiscellaneous;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeMiscellaneousDlg = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    pnlMiscellaneous: TPanel;
    lblDetailCopies: TLabel;
    editDetailCopies: TEdit;
    editReportTitle: TEdit;
    lblReportTitle: TLabel;
    Line1: TBevel;
    cbReportStyle: TComboBox;
    Label2: TLabel;
    lblTempPath: TLabel;
    editTempPath: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editReportTitleChange(Sender: TObject);
    procedure editDetailCopiesEnter(Sender: TObject);
    procedure editDetailCopiesExit(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateMiscellaneous;
    procedure InitializeControls(OnOff: boolean);
    procedure cbReportStyleChange(Sender: TObject);
    procedure editTempPathChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr            : TCrpe;
    rReportTitle  : string;
    rReportStyle  : TCrReportStyle;
    rDetailCopies : Smallint;
    rCrpePath     : string;
    rTempPath     : string;
    PrevNum       : string;
  end;

var
  CrpeMiscellaneousDlg: TCrpeMiscellaneousDlg;
  bMiscellaneous      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.FormCreate(Sender: TObject);
begin
  bMiscellaneous := True;
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.FormShow(Sender: TObject);
begin
  {Store current VCL settings}
  rReportStyle  := Cr.ReportStyle;
  rReportTitle  := Cr.ReportTitle;
  rDetailCopies := Cr.DetailCopies;
  rTempPath     := Cr.TempPath;
  editDetailCopies.Text := '1';
  editReportTitle.Text := '';
  UpdateMiscellaneous;
end;
{------------------------------------------------------------------------------}
{ UpdateMiscellaneous                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.UpdateMiscellaneous;
var
  OnOff : Boolean;
begin
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    cbReportStyle.ItemIndex := Ord(Cr.ReportStyle);
    editReportTitle.Text := Cr.ReportTitle;
    editDetailCopies.Text := IntToStr(Cr.DetailCopies);
  end;
  editTempPath.Text := Cr.TempPath;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
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
{ cbReportStyleChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.cbReportStyleChange(Sender: TObject);
begin
  Cr.ReportStyle := TCrReportStyle(cbReportStyle.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editReportTitleChange                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.editReportTitleChange(Sender: TObject);
begin
  Cr.ReportTitle := editReportTitle.Text;
end;
{------------------------------------------------------------------------------}
{ editDetailCopiesEnter                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.editDetailCopiesEnter(Sender: TObject);
begin
  PrevNum := editDetailCopies.Text;
end;
{------------------------------------------------------------------------------}
{ editDetailCopiesExit                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.editDetailCopiesExit(Sender: TObject);
begin
  if not IsNumeric(editDetailCopies.Text) then
    editDetailCopies.Text := PrevNum;
  Cr.DetailCopies := StrToInt(editDetailCopies.Text);
end;
{------------------------------------------------------------------------------}
{ editTempPathChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.editTempPathChange(Sender: TObject);
begin
  Cr.TempPath := editTempPath.Text;
end;
{------------------------------------------------------------------------------}
{ FormDeactivate                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.FormDeactivate(Sender: TObject);
begin
  if not IsStrEmpty(Cr.ReportName) then
    editDetailCopiesExit(Self);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeMiscellaneousDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not IsStrEmpty(Cr.ReportName) then
    editDetailCopiesExit(Self);
  if ModalResult = mrCancel then
  begin
    Cr.ReportStyle := rReportStyle;
    Cr.ReportTitle := rReportTitle;
    Cr.DetailCopies := rDetailCopies;
    Cr.TempPath := rTempPath;
  end;
  bMiscellaneous := False;
  Release;
end;


end.
