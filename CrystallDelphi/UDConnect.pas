unit UDConnect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeConnectDlg = class(TForm)
    pnlConnect1: TPanel;
    lblCServerName: TLabel;
    lblCDatabaseName: TLabel;
    lblCUserID: TLabel;
    lblCPassword: TLabel;
    editServerName: TEdit;
    editDatabaseName: TEdit;
    editUserID: TEdit;
    editPassword: TEdit;
    cbPropagate: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    btnTest: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure editServerNameChange(Sender: TObject);
    procedure editUserIDChange(Sender: TObject);
    procedure editPasswordChange(Sender: TObject);
    procedure editDatabaseNameChange(Sender: TObject);
    procedure cbPropagateClick(Sender: TObject);
    procedure UpdateConnect;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr            : TCrpe;
    rServerName   : string;
    rUserID       : string;
    rPassword     : string;
    rDatabaseName : string;
    rPropagate    : boolean;
  end;

var
  CrpeConnectDlg: TCrpeConnectDlg;
  bConnect      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
  bConnect := True;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.FormShow(Sender: TObject);
begin
  {Store VCL settings}
  rServerName   := Cr.Connect.ServerName;
  rUserID       := Cr.Connect.UserID;
  rPassword     := Cr.Connect.Password;
  rDatabaseName := Cr.Connect.DatabaseName;
  rPropagate    := Cr.Connect.Propagate;
  UpdateConnect;
end;
{------------------------------------------------------------------------------}
{ UpdateConnect                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.UpdateConnect;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);
  if OnOff then
  begin
    editServerName.Text := Cr.Connect.ServerName;
    editUserID.Text := Cr.Connect.UserID;
    editPassword.Text := Cr.Connect.Password;
    editDatabaseName.Text := Cr.Connect.DatabaseName;
    cbPropagate.Checked := Cr.Connect.Propagate;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.InitializeControls(OnOff: boolean);
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
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ editServerNameChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.editServerNameChange(Sender: TObject);
begin
  Cr.Connect.ServerName := editServerName.Text;
end;
{------------------------------------------------------------------------------}
{ editUserIDChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.editUserIDChange(Sender: TObject);
begin
  Cr.Connect.UserID := editUserID.Text;
end;
{------------------------------------------------------------------------------}
{ editPasswordChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.editPasswordChange(Sender: TObject);
begin
  Cr.Connect.Password := editPassword.Text;
end;
{------------------------------------------------------------------------------}
{ editDatabaseNameChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.editDatabaseNameChange(Sender: TObject);
begin
  Cr.Connect.DatabaseName := editDatabaseName.Text;
end;
{------------------------------------------------------------------------------}
{ cbPropagateClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.cbPropagateClick(Sender: TObject);
begin
  Cr.Connect.Propagate := cbPropagate.Checked;
end;
{------------------------------------------------------------------------------}
{ btnTestClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.btnTestClick(Sender: TObject);
begin
  if Cr.Connect.Test then
    MessageDlg('Connect Succeeded!', mtInformation, [mbOk], 0)
  else
    MessageDlg('Connect Failed.' + Chr(10) + Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.btnClearClick(Sender: TObject);
begin
  Cr.Connect.Clear;
  UpdateConnect;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.btnCancelClick(Sender: TObject);
begin
  {Restore Settings}
  Cr.Connect.ServerName := rServerName;
  Cr.Connect.UserID := rUserID;
  Cr.Connect.Password := rPassword;
  Cr.Connect.DatabaseName := rDatabaseName;
  Cr.Connect.Propagate := rPropagate;
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeConnectDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bConnect := False;
  Release;
end;


end.
