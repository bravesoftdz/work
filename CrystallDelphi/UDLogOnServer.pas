unit UDLogOnServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, UCrpe32;

type
  TCrpeLogOnServerDlg = class(TForm)
    pnlLogOnServer1: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    btnOk: TButton;
    btnLogOn: TButton;
    btnLogOff: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    btnRetrieve: TButton;
    btnClear: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    lblServerName: TLabel;
    lblDatabaseName: TLabel;
    lblUserID: TLabel;
    lblPassword: TLabel;
    lblDLLName: TLabel;
    editServerName: TEdit;
    editDatabaseName: TEdit;
    editUserID: TEdit;
    editPassword: TEdit;
    editDLLName: TEdit;
    lblLogNumber: TLabel;
    editLogNumber: TEdit;
    cbIsLoggedOn: TCheckBox;
    procedure btnLogOnClick(Sender: TObject);
    procedure btnLogOffClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnRetrieveClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure editServerNameChange(Sender: TObject);
    procedure editUserIDChange(Sender: TObject);
    procedure editPasswordChange(Sender: TObject);
    procedure editDatabaseNameChange(Sender: TObject);
    procedure editDLLNameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateLogOnServer;
  private
    { Private declarations }
  public
    { Public declarations }
    Cr     : TCrpe;
    SIndex : smallint;
  end;

var
  CrpeLogOnServerDlg: TCrpeLogOnServerDlg;
  bLogOnServer      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDLogOnServerAdd;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.FormCreate(Sender: TObject);
begin
  bLogOnServer := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnAdd.Tag := 1;
  btnRetrieve.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.FormShow(Sender: TObject);
begin
  UpdateLogOnServer;
end;
{------------------------------------------------------------------------------}
{ UpdateLogOnServer                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.UpdateLogOnServer;
var
  OnOff : boolean;
  i     : integer;
begin
  {Enable/Disable controls}
  btnRetrieve.Enabled := not IsStrEmpty(Cr.ReportName);
  OnOff := (Cr.LogOnServer.Count > 0);
  InitializeControls(OnOff);

  {Get LogOnServer Index}
  if Cr.LogOnServer.ItemIndex > -1 then
    SIndex := Cr.LogOnServer.ItemIndex
  else
    SIndex := 0;

  if OnOff then
  begin
    lbNumbers.Clear;
    for i := 0 to Cr.LogOnServer.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.LogOnServer.Count);
    lbNumbers.ItemIndex := SIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        if not OnOff then
          TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.lbNumbersClick(Sender: TObject);
begin
  SIndex := lbNumbers.ItemIndex;
  Cr.LogOnServer[SIndex];
  editServerName.Text := Cr.LogOnServer.Item.ServerName;
  editDatabaseName.Text := Cr.LogOnServer.Item.DatabaseName;
  editUserID.Text := Cr.LogOnServer.Item.UserID;
  editPassword.Text := Cr.LogOnServer.Item.Password;
  editDLLName.Text := Cr.LogOnServer.Item.DLLName;
  editLogNumber.Text := IntToStr(Cr.LogOnServer.Item.LogNumber);
  cbIsLoggedOn.Checked := Cr.LogOnServer.Item.IsLoggedOn;
  btnLogOff.Enabled := (Cr.LogOnServer.Item.LogNumber > 0);
  btnLogOn.Enabled := (Cr.LogOnServer.Item.LogNumber < 1);
end;
{------------------------------------------------------------------------------}
{ btnLogOnClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnLogOnClick(Sender: TObject);
begin
  {Check to see if already Logged On}
  if Cr.LogOnServer.Item.LogNumber > 0 then
  begin
    MessageDlg('Already Logged On!  Use "Add" to add another ServerName.',
      mtWarning, [mbOk], 0);
    Exit;
  end;
  {Try Logging On...}
  if Cr.LogOnServer.Item.LogOn then
    UpdateLogOnServer
  else
    MessageDlg('LogOn Failed.' + Chr(10) + Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnLogOffClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnLogOffClick(Sender: TObject);
begin
  {Try LogOff}
  if not Cr.LogOnServer.Item.LogOff then
    MessageDlg('LogOff Failed.' + Chr(10) + Cr.LastErrorString, mtError, [mbOk], 0)
  else
    UpdateLogOnServer;
end;
{------------------------------------------------------------------------------}
{ btnAddClick procedure                                                        }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnAddClick(Sender: TObject);
begin
  CrpeLogOnServerAddDlg := TCrpeLogOnServerAddDlg.Create(Application);
  CrpeLogOnServerAddDlg.ShowModal;
  if CrpeLogOnServerAddDlg.ModalResult = mrOk then
  begin
    {Add LogOnServer item to VCL}
    Cr.LogOnServer.Add(CrpeLogOnServerAddDlg.editServerName.Text);
    Cr.LogOnServer.Item.DatabaseName := CrpeLogOnServerAddDlg.editDatabaseName.Text;
    Cr.LogOnServer.Item.UserID := CrpeLogOnServerAddDlg.editUserID.Text;
    Cr.LogOnServer.Item.Password := CrpeLogOnServerAddDlg.editPassword.Text;
    Cr.LogOnServer.Item.DLLName := CrpeLogOnServerAddDlg.editDLLName.Text;
    {Set ItemIndex to new item}
    SIndex := (Cr.LogOnServer.Count-1);
    UpdateLogOnServer;
  end;
  CrpeLogOnServerAddDlg.Release;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnDeleteClick(Sender: TObject);
begin
  Cr.LogOnServer.Delete(SIndex);
  UpdateLogOnServer;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnClearClick(Sender: TObject);
begin
  Cr.LogOnServer.Clear;
  UpdateLogOnServer;
end;
{------------------------------------------------------------------------------}
{ btnRetrieveLogOnClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnRetrieveClick(Sender: TObject);
begin
  Cr.LogOnServer.Retrieve;
  UpdateLogOnServer;
end;
{------------------------------------------------------------------------------}
{ editServerName1Change procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.editServerNameChange(Sender: TObject);
begin
  Cr.LogOnServer.Item.ServerName := editServerName.Text;
end;
{------------------------------------------------------------------------------}
{ editDatabaseName1Change procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.editDatabaseNameChange(Sender: TObject);
begin
  Cr.LogOnServer.Item.DatabaseName := editDatabaseName.Text;
end;
{------------------------------------------------------------------------------}
{ editUserID1Change procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.editUserIDChange(Sender: TObject);
begin
  Cr.LogOnServer.Item.UserID := editUserID.Text;
end;
{------------------------------------------------------------------------------}
{ editPassword1Change procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.editPasswordChange(Sender: TObject);
begin
  Cr.LogOnServer.Item.Password := editPassword.Text;
end;
{------------------------------------------------------------------------------}
{ editDLLName1Change procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.editDLLNameChange(Sender: TObject);
begin
  Cr.LogOnServer.Item.DLLName := editDLLName.Text;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnServerDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bLogOnServer := False;
  Release;
end;


end.
