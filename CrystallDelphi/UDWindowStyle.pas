unit UDWindowStyle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeWindowStyleDlg = class(TForm)
    pnlWindowStyle: TPanel;
    lblWindowTitle: TLabel;
    cbSystemMenu: TCheckBox;
    cbMinButton: TCheckBox;
    cbMaxButton: TCheckBox;
    rgBorderStyle: TRadioGroup;
    editTitle: TEdit;
    cbDisabled: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    procedure FormShow(Sender: TObject);
    procedure UpdateWindowStyle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClearClick(Sender: TObject);
    procedure cbSystemMenuClick(Sender: TObject);
    procedure cbMinButtonClick(Sender: TObject);
    procedure cbMaxButtonClick(Sender: TObject);
    procedure cbDisabledClick(Sender: TObject);
    procedure editTitleChange(Sender: TObject);
    procedure rgBorderStyleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr           : TCrpe;
    rSystemMenu  : boolean;
    rMinButton   : boolean;
    rMaxButton   : boolean;
    rBorderStyle : smallint;
    rDisabled    : boolean;
    rTitle       : string;
  end;

var
  CrpeWindowStyleDlg: TCrpeWindowStyleDlg;
  bWindowStyle      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.FormCreate(Sender: TObject);
begin
  bWindowStyle := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.FormShow(Sender: TObject);
begin
  {Store current VCL Settings}
  rSystemMenu  := Cr.WindowStyle.SystemMenu;
  rMinButton   := Cr.WindowStyle.MinButton;
  rMaxButton   := Cr.WindowStyle.MaxButton;
  rBorderStyle := Ord(Cr.WindowStyle.BorderStyle);
  rDisabled    := Cr.WindowStyle.Disabled;
  rTitle       := Cr.WindowStyle.Title;
  UpdateWindowStyle;
end;
{------------------------------------------------------------------------------}
{ UpdateWindowStyle                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.UpdateWindowStyle;
begin
  cbSystemMenu.Checked := Cr.WindowStyle.SystemMenu;
  cbMinButton.Checked := Cr.WindowStyle.MinButton;
  cbMaxButton.Checked := Cr.WindowStyle.MaxButton;
  rgBorderStyle.ItemIndex := Ord(Cr.WindowStyle.BorderStyle);
  cbDisabled.Checked := Cr.WindowStyle.Disabled;
  editTitle.Text := Cr.WindowStyle.Title;
  {Enable the applicable controls}
  cbMinButton.Enabled := True;
  cbMaxButton.Enabled := True;
  cbSystemMenu.Enabled := True;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.InitializeControls(OnOff: boolean);
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
{ cbSystemMenuClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.cbSystemMenuClick(Sender: TObject);
begin
  Cr.WindowStyle.SystemMenu := cbSystemMenu.Checked;
end;
{------------------------------------------------------------------------------}
{ cbMinButtonClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.cbMinButtonClick(Sender: TObject);
begin
  Cr.WindowStyle.MinButton := cbMinButton.Checked;
end;
{------------------------------------------------------------------------------}
{ cbMaxButtonClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.cbMaxButtonClick(Sender: TObject);
begin
  Cr.WindowStyle.MaxButton := cbMaxButton.Checked;
end;
{------------------------------------------------------------------------------}
{ cbDisabledClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.cbDisabledClick(Sender: TObject);
begin
  Cr.WindowStyle.Disabled := cbDisabled.Checked;
end;
{------------------------------------------------------------------------------}
{ rgBorderStyleClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.rgBorderStyleClick(Sender: TObject);
begin
  Cr.WindowStyle.BorderStyle := TCrFormBorderStyle(rgBorderStyle.ItemIndex);
  UpdateWindowStyle;
end;
{------------------------------------------------------------------------------}
{ editTitleChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.editTitleChange(Sender: TObject);
begin
  Cr.WindowStyle.Title := editTitle.Text;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.btnClearClick(Sender: TObject);
begin
  Cr.WindowStyle.Clear;
  UpdateWindowStyle;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowStyleDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.WindowStyle.SystemMenu := rSystemMenu;
    Cr.WindowStyle.MinButton := rMinButton;
    Cr.WindowStyle.MaxButton := rMaxButton;
    Cr.WindowStyle.BorderStyle := TCrFormBorderStyle(rBorderStyle);
    Cr.WindowStyle.Disabled := rDisabled;
    Cr.WindowStyle.Title := rTitle;
  end;
  bWindowStyle := False;
  Release;
end;


end.
