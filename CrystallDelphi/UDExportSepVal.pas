unit UDExportSepVal;

interface

uses
  Windows, Forms, StdCtrls, Buttons, Controls, Classes, ExtCtrls,
  UCrpe32;

type
  TCrpeSepValDlg = class(TForm)
    pnlSepVal: TPanel;
    editStringDelimiter: TEdit;
    editFieldSeparator: TEdit;
    lblStringDelimiter: TLabel;
    lblFieldSeparator: TLabel;
    sb1: TSpeedButton;
    sb2: TSpeedButton;
    sb4: TSpeedButton;
    sb3: TSpeedButton;
    sb5: TSpeedButton;
    sb13: TSpeedButton;
    sb6: TSpeedButton;
    sb14: TSpeedButton;
    sb15: TSpeedButton;
    sb16: TSpeedButton;
    sb17: TSpeedButton;
    sb7: TSpeedButton;
    sb8: TSpeedButton;
    sb9: TSpeedButton;
    sb10: TSpeedButton;
    sb11: TSpeedButton;
    sb12: TSpeedButton;
    sb18: TSpeedButton;
    sb19: TSpeedButton;
    sb20: TSpeedButton;
    sb22: TSpeedButton;
    sb23: TSpeedButton;
    sb21: TSpeedButton;
    sb24: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    sbTab: TSpeedButton;
    sbComma: TSpeedButton;
    cbUseRptNumberFmt: TCheckBox;
    cbUseRptDateFmt: TCheckBox;
    procedure BtnCharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure editStringDelimiterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure sbTabClick(Sender: TObject);
    procedure sbCommaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeSepValDlg: TCrpeSepValDlg;

implementation

{$R *.DFM}

uses UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.FormShow(Sender: TObject);
begin
  editStringDelimiter.Text := Cr.ExportOptions.Text.StringDelimiter;
  editFieldSeparator.Text := Cr.ExportOptions.Text.FieldSeparator;
  cbUseRptNumberFmt.Checked := Cr.ExportOptions.Text.UseRptNumberFmt;
  cbUseRptDateFmt.Checked := Cr.ExportOptions.Text.UseRptDateFmt;
end;
{------------------------------------------------------------------------------}
{ editStringDelimiterKeyDown procedure                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.editStringDelimiterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  editStringDelimiter.Text := '';
end;
{------------------------------------------------------------------------------}
{ BtnCharClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.BtnCharClick(Sender: TObject);
begin
  if editFieldSeparator.Focused then
    editFieldSeparator.SelText := TSpeedButton(Sender).Caption
  else
    editStringDelimiter.Text := TSpeedButton(Sender).Caption;
end;
{------------------------------------------------------------------------------}
{ sbTabClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.sbTabClick(Sender: TObject);
begin
  editFieldSeparator.SelText := Chr(9);
end;
{------------------------------------------------------------------------------}
{ sbCommaClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.sbCommaClick(Sender: TObject);
begin
  editFieldSeparator.SelText := ',';
end;
{------------------------------------------------------------------------------}
{ sb1MouseDown procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.sb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if editStringDelimiter.Focused then
    editStringDelimiter.Text := '';
end;
{------------------------------------------------------------------------------}
{ btnOKClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.btnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  if Length(editStringDelimiter.Text) > 0 then
    Cr.ExportOptions.Text.StringDelimiter := editStringDelimiter.Text[1]
  else
    Cr.ExportOptions.Text.StringDelimiter := #0;
  Cr.ExportOptions.Text.FieldSeparator := editFieldSeparator.Text;
  Cr.ExportOptions.Text.UseRptNumberFmt := cbUseRptNumberFmt.Checked;
  Cr.ExportOptions.Text.UseRptDateFmt := cbUseRptDateFmt.Checked;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSepValDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;



end.
