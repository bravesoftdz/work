unit uLoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentModalForm, XiButton, ExtCtrls, uUserObj, DB, DBClient,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls;

type
  TLoginForm = class(TParentModalForm)
    cdsLogin: TClientDataSet;
    edPassword: TcxTextEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure ConfirmFrm; override;
    procedure CancelFrm; override;
  public
    function Start : Boolean;
  end;

implementation

uses uDMPet, uDMGlobalNTier, mrMsgBox, uDMMaintenance;

{$R *.dfm}

{ TLoginForm }

procedure TLoginForm.CancelFrm;
begin
  inherited;

end;

procedure TLoginForm.ConfirmFrm;
var
  bResult : boolean;
begin
  inherited;

  with cdsLogin do
  try
    FetchParams;
    Params.ParamByName('Password').Value  := edPassword.Text;
    Params.ParamByName('MenuID').Value    := 1;
    Params.ParamByName('SubMenuID').Value := 1;
    Open;

    bResult := FieldByName('CanAccess').AsBoolean;

    DMPet.SystemUser.UserName   := FieldByName('SystemUser').AsString;
    DMPet.SystemUser.Password   := edPassword.Text;
    DMPet.SystemUser.ID         := FieldByName('IDUser').AsInteger;
    DMPet.SystemUser.IDUserType := FieldByName('IDUserType').AsInteger;

    Close;

    if not bResult then
    begin
      MsgBox('Invalid login. Try again!', vbInformation + vbOKOnly);
      ModalResult := mrNone;
    end;
  except
    on E: Exception do
    begin
      MsgBox('Connection failure! Error: ' + E.Message, vbCritical + vbOKOnly);
      DMPet.CloseConnection;
      ModalResult := mrNone;
    end;
  end;

end;

function TLoginForm.Start: Boolean;
begin
  Result := (ShowModal = mrOK);
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  inherited;
  cdsLogin.RemoteServer := DMPet.ActiveConnection;
end;

end.
