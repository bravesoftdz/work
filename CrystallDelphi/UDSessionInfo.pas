unit UDSessionInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSessionInfoDlg = class(TForm)
    pnlSessionIInfo: TPanel;
    lblTable: TLabel;
    lblUserID: TLabel;
    lblUserPassword: TLabel;
    lblDBPassword: TLabel;
    lbTables: TListBox;
    editUserID: TEdit;
    editUserPassword: TEdit;
    editDBPassword: TEdit;
    cbPropagate: TCheckBox;
    btnOk: TButton;
    btnClear: TButton;
    btnTest: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateSessionInfo;
    procedure lbTablesClick(Sender: TObject);
    procedure editUserIDChange(Sender: TObject);
    procedure editUserPasswordChange(Sender: TObject);
    procedure editDBPasswordChange(Sender: TObject);
    procedure cbPropagateClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr     : TCrpe;
    SIndex : smallint;
  end;

var
  CrpeSessionInfoDlg: TCrpeSessionInfoDlg;
  bSessionInfo      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.FormCreate(Sender: TObject);
begin
  bSessionInfo := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.FormShow(Sender: TObject);
begin
  UpdateSessionInfo;
end;
{------------------------------------------------------------------------------}
{ UpdateSessionInfo                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.UpdateSessionInfo;
var
  OnOff : boolean;
  i     : integer;
begin
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    SIndex := -1;
  end
  else
  begin
    OnOff := (Cr.SessionInfo.Count > 0);
    {Get SessionInfo Index}
    if OnOff then
    begin
      if Cr.SessionInfo.ItemIndex > -1 then
        SIndex := Cr.SessionInfo.ItemIndex
      else
        SIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {If there is SessionInfo information, fill the listbox}
  if OnOff then
  begin
    lbTables.Clear;
    for i := 0 to (Cr.SessionInfo.Count - 1) do
      lbTables.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.SessionInfo.Count);
    lbTables.ItemIndex := SIndex;
    lbTablesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioButton then
        TRadioButton(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
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
{ lbTablesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.lbTablesClick(Sender: TObject);
begin
  SIndex := lbTables.ItemIndex;
  {Fill in controls}
  editUserID.Text := Cr.SessionInfo[SIndex].UserID;
  editUserPassword.Text := Cr.SessionInfo.Item.UserPassword;
  editDBPassword.Text := Cr.SessionInfo.Item.DBPassword;
  cbPropagate.Checked := Cr.SessionInfo.Item.Propagate;
end;
{------------------------------------------------------------------------------}
{ editUserIDChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.editUserIDChange(Sender: TObject);
begin
  Cr.SessionInfo.Item.UserID := editUserID.Text;
end;
{------------------------------------------------------------------------------}
{ editUserPasswordChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.editUserPasswordChange(Sender: TObject);
begin
  Cr.SessionInfo.Item.UserPassword := editUserPassword.Text;
end;
{------------------------------------------------------------------------------}
{ editDBPasswordChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.editDBPasswordChange(Sender: TObject);
begin
  Cr.SessionInfo.Item.DBPassword := editDBPassword.Text;
end;
{------------------------------------------------------------------------------}
{ cbPropagateClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.cbPropagateClick(Sender: TObject);
begin
  Cr.SessionInfo.Item.Propagate := cbPropagate.Checked;
end;
{------------------------------------------------------------------------------}
{ btnTestClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.btnTestClick(Sender: TObject);
begin
  if Cr.SessionInfo.Item.Test then
    MessageDlg('Session Connected!', mtInformation, [mbOk], 0)
  else
    MessageDlg('Session Failed.' + Chr(10) + Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.btnClearClick(Sender: TObject);
begin
  Cr.SessionInfo.Clear;
  UpdateSessionInfo;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSessionInfoDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bSessionInfo := False;
  Release;
end;


end.
