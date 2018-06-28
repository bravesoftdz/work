unit UDRecords;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UCrpe32;

type
  TCrpeRecordsDlg = class(TForm)
    pnlRecords: TPanel;
    pnlMonitor: TPanel;
    lblRead: TLabel;
    lblSelected: TLabel;
    lblPrinted: TLabel;
    editRead: TEdit;
    editSelected: TEdit;
    editPrinted: TEdit;
    cbMonitor: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    Timer1: TTimer;
    btnSetRecordLimit: TButton;
    editSetRecordLimit: TEdit;
    btnSetTimeLimit: TButton;
    editSetTimeLimit: TEdit;
    lblPercentRead: TLabel;
    lblPercentCompleted: TLabel;
    editPercentRead: TEdit;
    editPercentCompleted: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure editSetRecordLimitEnter(Sender: TObject);
    procedure editSetRecordLimitExit(Sender: TObject);
    procedure editSetTimeLimitEnter(Sender: TObject);
    procedure editSetTimeLimitExit(Sender: TObject);
    procedure btnSetRecordLimitClick(Sender: TObject);
    procedure btnSetTimeLimitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateRecords;
    procedure InitializeControls(OnOff: boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure cbMonitorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr      : TCrpe;
    PrevNum : string;
  end;

var
  CrpeRecordsDlg: TCrpeRecordsDlg;
  bRecords      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.FormCreate(Sender: TObject);
begin
  bRecords := True;
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.FormShow(Sender: TObject);
begin
  editSetRecordLimit.Text := '0';
  editSetTimeLimit.Text := '0';
  UpdateRecords;
end;
{------------------------------------------------------------------------------}
{ UpdateRecords                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.UpdateRecords;
var
  OnOff : Boolean;
begin
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  if OnOff then
  begin
    cbMonitor.Checked := (Cr.ReportWindowHandle > 0);
    Timer1.Enabled := cbMonitor.Checked;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.InitializeControls(OnOff: boolean);
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
{ editSetRecordLimitEnter                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.editSetRecordLimitEnter(Sender: TObject);
begin
  if IsNumeric(editSetRecordLimit.Text) then
    PrevNum := editSetRecordLimit.Text;
end;
{------------------------------------------------------------------------------}
{ editSetRecordLimitExit                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.editSetRecordLimitExit(Sender: TObject);
begin
  if not IsNumeric(editSetRecordLimit.Text) then
    editSetRecordLimit.Text := PrevNum;
end;
{------------------------------------------------------------------------------}
{ editSetTimeLimitEnter                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.editSetTimeLimitEnter(Sender: TObject);
begin
  if IsNumeric(editSetTimeLimit.Text) then
    PrevNum := editSetTimeLimit.Text;
end;
{------------------------------------------------------------------------------}
{ editSetTimeLimitExit                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.editSetTimeLimitExit(Sender: TObject);
begin
  if not IsNumeric(editSetTimeLimit.Text) then
    editSetTimeLimit.Text := PrevNum;
end;
{------------------------------------------------------------------------------}
{ btnSetRecordLimitClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.btnSetRecordLimitClick(Sender: TObject);
begin
  if IsNumeric(editSetRecordLimit.Text) then
    Cr.Records.SetRecordLimit(StrToInt(editSetRecordLimit.Text));
end;
{------------------------------------------------------------------------------}
{ btnSetTimeLimitClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.btnSetTimeLimitClick(Sender: TObject);
begin
  if IsNumeric(editSetTimeLimit.Text) then
    Cr.Records.SetTimeLimit(StrToInt(editSetTimeLimit.Text));
end;
{------------------------------------------------------------------------------}
{ cbMonitorClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.cbMonitorClick(Sender: TObject);
begin
  Timer1.Enabled := cbMonitor.Checked;
end;
{------------------------------------------------------------------------------}
{ Timer1Timer                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.Timer1Timer(Sender: TObject);
begin
  editRead.Text := IntToStr(Cr.Records.Read);
  editSelected.Text := IntToStr(Cr.Records.Selected);
  editPrinted.Text := IntToStr(Cr.Records.Printed);
  editPercentRead.Text := IntToStr(Cr.Records.PercentRead);
  editPercentCompleted.Text := IntToStr(Cr.Records.PercentCompleted);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeRecordsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  bRecords := False;
  Release;
end;


end.
