unit UDLogOnInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeLogOnInfoDlg = class(TForm)
    pnlLogOnInfo1: TPanel;
    lblTable: TLabel;
    lblTableType: TLabel;
    lblDLLName: TLabel;
    lblServerType: TLabel;
    lbTables: TListBox;
    pnlLogOnInfo2: TPanel;
    lblServerName: TLabel;
    lblDatabaseName: TLabel;
    lblUserID: TLabel;
    lblPassword: TLabel;
    editServerName: TEdit;
    editDatabaseName: TEdit;
    editUserID: TEdit;
    editPassword: TEdit;
    editTableType: TEdit;
    editDLLName: TEdit;
    editServerType: TEdit;
    btnOk: TButton;
    btnClear: TButton;
    cbSQLTablesOnly: TCheckBox;
    btnTest: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lbTablesClick(Sender: TObject);
    procedure editServerNameChange(Sender: TObject);
    procedure editUserIDChange(Sender: TObject);
    procedure editPasswordChange(Sender: TObject);
    procedure editDatabaseNameChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateLogOn;
    procedure cbSQLTablesOnlyClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr         : TCrpe;
    TableIndex : smallint;
  end;

var
  CrpeLogOnInfoDlg: TCrpeLogOnInfoDlg;
  bLogOnInfo      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.FormCreate(Sender: TObject);
begin
  bLogOnInfo := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.FormShow(Sender: TObject);
begin
  UpdateLogOn;
end;
{------------------------------------------------------------------------------}
{ UpdateLogOn                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.UpdateLogOn;
var
  OnOff : boolean;
  i     : integer;
begin
  TableIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    cbSQLTablesOnly.Checked := Cr.LogOnInfo.SQLTablesOnly;
    OnOff := (Cr.LogOnInfo.Count > 0);
    {Get LogOnInfo Index}
    if OnOff then
    begin
      if Cr.LogOnInfo.ItemIndex > -1 then
        TableIndex := Cr.LogOnInfo.ItemIndex
      else
        TableIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Tables ListBox}
    for i := 0 to (Cr.LogOnInfo.Count - 1) do
      lbTables.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.LogOnInfo.Count);
    lbTables.ItemIndex := TableIndex;
    lbTablesClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.InitializeControls(OnOff: boolean);
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
{ lbTablesClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.lbTablesClick(Sender: TObject);
begin
  TableIndex := lbTables.ItemIndex;
  Cr.LogOnInfo[TableIndex];
  {Fill in controls}
  editServerName.Text := Cr.LogOnInfo.Item.ServerName;
  editUserID.Text := Cr.LogOnInfo.Item.UserID;
  editPassword.Text := Cr.LogOnInfo.Item.Password;
  editDatabaseName.Text := Cr.LogOnInfo.Item.DatabaseName;
  cbSQLTablesOnly.Checked := Cr.LogOnInfo.SQLTablesOnly;
  case Ord(Cr.LogOnInfo.Item.TableType) of
    0: editTableType.Text := 'ttUnknown';
    1: editTableType.Text := 'ttStandard';
    2: editTableType.Text := 'ttSQL';
  end;
  editDLLName.Text := Cr.LogOnInfo.Item.DLLName;
  editServerType.Text := Cr.LogOnInfo.Item.ServerType;
end;
{------------------------------------------------------------------------------}
{ editServerNameChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.editServerNameChange(Sender: TObject);
begin
  Cr.LogOnInfo.Item.ServerName := editServerName.Text;
end;
{------------------------------------------------------------------------------}
{ editUserIDChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.editUserIDChange(Sender: TObject);
begin
  Cr.LogOnInfo.Item.UserID := editUserID.Text;
end;
{------------------------------------------------------------------------------}
{ editPasswordChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.editPasswordChange(Sender: TObject);
begin
  Cr.LogOnInfo.Item.Password := editPassword.Text;
end;
{------------------------------------------------------------------------------}
{ editDatabaseNameChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.editDatabaseNameChange(Sender: TObject);
begin
  Cr.LogOnInfo.Item.DatabaseName := editDatabaseName.Text;
end;
{------------------------------------------------------------------------------}
{ cbSQLTablesOnlyClick                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.cbSQLTablesOnlyClick(Sender: TObject);
begin
  Cr.LogOnInfo.SQLTablesOnly := cbSQLTablesOnly.Checked;
  UpdateLogOn;
end;
{------------------------------------------------------------------------------}
{ btnTestClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.btnTestClick(Sender: TObject);
begin
  if Cr.LogOnInfo.Item.Test then
    MessageDlg('LogOn Succeeded!', mtInformation, [mbOk], 0)
  else
    MessageDlg('LogOn Failed.' + Chr(10) + Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.btnClearClick(Sender: TObject);
begin
  Cr.LogOnInfo.Clear;
  UpdateLogOn;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeLogOnInfoDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bLogOnInfo := False;
  Release;
end;


end.
