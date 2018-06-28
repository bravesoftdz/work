unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DB, DBClient, Provider,
  siComp;

type
  TRepLoginFrm = class(TForm)
    pnlBottom: TPanel;
    btLogin: TcxButton;
    btCancel: TcxButton;
    luStore: TcxLookupComboBox;
    lblPassword: TLabel;
    lblStore: TLabel;
    imgLogin: TImage;
    cdsLogin: TClientDataSet;
    edPassword: TEdit;
    bvTop: TBevel;
    siLang: TsiLang;
    cbPassword: TCheckBox;
    procedure btLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function ValidateLogin: Boolean;
  public
    function AutoLogin(APW: String) : Boolean;
    function Start: Boolean;
  end;

implementation

uses uDMImportExport, uDMGlobalNTier;

{$R *.dfm}

procedure TRepLoginFrm.btLoginClick(Sender: TObject);
begin
  if ValidateLogin then
    ModalResult := mrOk;
end;

function TRepLoginFrm.Start: Boolean;
begin
  Result := ShowModal = mrOk;
end;

function TRepLoginFrm.ValidateLogin: Boolean;
begin

  if (Trim(edPassword.Text) = '') then
  begin
    MessageDlg('Invalid login. Try again!', mtWarning, [mbOK], 0);
    Result := False;
  end
  else if cbPassword.Checked then
  begin
    with cdsLogin do
      try
        FetchParams;
        Params.ParamByName('Password').Value := edPassword.Text;
        Params.ParamByName('MenuID').Value := 2;
        Params.ParamByName('SubMenuID').Value := 12;
        Open;

        Result := FieldByName('CanAccess').AsBoolean;

        if Result then
        begin
          DMImportExport.FUser.UserName   := FieldByName('SystemUser').AsString;
          DMImportExport.FUser.Password   := edPassword.Text;
          DMImportExport.FUser.ID         := FieldByName('IDUser').AsInteger;
          DMImportExport.FUser.IDUserType := FieldByName('IDUserType').AsInteger;
        end
        else
        begin
          MessageDlg('Invalid login. Try again!', mtWarning, [mbOK], 0);
          cbPassword.Checked := False;
          edPassword.Clear;
          edPassword.SetFocus;
        end;

        Close;
      except
        on E: Exception do
        begin
          MessageDlg('Connection failure! Error: ' + E.Message, mtError, [mbOK], 0);
          Result := False;
        end;
      end;
  end
  else
  begin
    with cdsLogin do
      try
        FetchParams;
        Params.ParamByName('Password').Value := edPassword.Text;
        Params.ParamByName('MenuID').Value := 2;
//antonio 10-08-2010: why that ?  Params.ParamByName('SubMenuID').Value := 10;
        Params.ParamByName('SubMenuID').Value := 12;
        Open;

        Result := FieldByName('CanAccess').AsBoolean;

        if not Result then
          MessageDlg('Invalid login. Try again!', mtWarning, [mbOK], 0);
          edPassword.Clear;
          edPassword.SetFocus;
      except
        on E: Exception do
        begin
          MessageDlg('Connection failure! Error: ' + E.Message, mtError, [mbOK], 0);
          DMImportExport.CloseConnection;
          Result := False;
        end;
      end;
  end;
end;

procedure TRepLoginFrm.FormCreate(Sender: TObject);
begin
  //DMImportExport.OpenConnection;
  cdsLogin.RemoteServer := DMImportExport.ActiveConnection
end;

function TRepLoginFrm.AutoLogin(APW: String): Boolean;
begin
  edPassword.Text := APW;
  cbPassword.Checked := True;
  Result := ValidateLogin;
end;

end.
