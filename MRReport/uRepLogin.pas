unit uRepLogin;

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
    procedure btLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function ValidateLogin: Boolean;
  public
    function Start: Boolean;
    function AutoLogin(APW: String) : Boolean;
  end;

implementation

uses uDMReport;

{$R *.dfm}

procedure TRepLoginFrm.btLoginClick(Sender: TObject);
begin
  if ValidateLogin then
    ModalResult := mrOk;
end;

function TRepLoginFrm.Start: Boolean;
begin
  Result := (ShowModal = mrOk);
end;

function TRepLoginFrm.ValidateLogin: Boolean;
begin
  with cdsLogin do
  try
    FetchParams;
    Params.ParamByName('Password').Value := edPassword.Text;
    Params.ParamByName('MenuID').Value := 1;
    Params.ParamByName('SubMenuID').Value := 4;
    Open;

    Result := FieldByName('CanAccess').AsBoolean;

    DMReport.FUser.UserName   := FieldByName('SystemUser').AsString;
    DMReport.FUser.Password   := edPassword.Text;
    DMReport.FUser.ID         := FieldByName('IDUser').AsInteger;
    DMReport.FUser.IDUserType := FieldByName('IDUserType').AsInteger;

    Close;

    if not Result then
      MessageDlg('Invalid login. Try again!', mtWarning, [mbOK], 0);
  except
    on E: Exception do
    begin
      MessageDlg('Connection failure! Error: ' + E.Message, mtError, [mbOK], 0);
      DMReport.CloseConnection;
      Result := False;
    end;
  end;
end;

procedure TRepLoginFrm.FormCreate(Sender: TObject);
begin
  DMReport.OpenConnection;
  cdsLogin.RemoteServer := DMReport.ActiveConnection;
end;

function TRepLoginFrm.AutoLogin(APW: String): Boolean;
begin
  edPassword.Text := APW;
  Result := ValidateLogin;
end;

end.
