unit uFrmMRConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask;

Const
  CONFIG_SERVER_SCREEN = 1;
  CONFIG_LOCAL_SCREEN  = 2;

type
  TFrmMRConnection = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtServer: TLabeledEdit;
    edtDB: TLabeledEdit;
    edtUser: TLabeledEdit;
    edtPW: TLabeledEdit;
  private
    { Private declarations }
  public
    function Start(ScreenType: Integer) : Boolean;
  end;


implementation

uses uDM;

{$R *.dfm}

{ TFrmMRConnection }

function TFrmMRConnection.Start(ScreenType: Integer) : Boolean;
begin
  if (ScreenType = CONFIG_SERVER_SCREEN) then
  begin
    edtServer.Text := DM.fMRDatabase.Server;
    edtDB.Text     := DM.fMRDatabase.DatabaseName;
    edtUser.Text   := DM.fMRDatabase.User;
    edtPW.Text     := DM.fMRDatabase.PW;

    ShowModal;

    Result := (ModalResult = mrOK);

    If Result then
       begin
       DM.SetConnection(edtServer.Text, edtDB.Text, edtUser.Text, edtPW.Text);
       DM.MRInventoryConnectionClose;
       DM.MRInventoryConnectionOpen;
       end;
  end
  else
  begin
    edtServer.Text := DM.fMRLocalDatabase.LocalServer;
    edtDB.Text     := DM.fMRLocalDatabase.LocalDatabaseName;
    edtUser.Text   := DM.fMRLocalDatabase.LocalUser;
    edtPW.Text     := DM.fMRLocalDatabase.LocalPW;

    ShowModal;

    Result := (ModalResult = mrOK);

    If Result then
       begin
       DM.SetLocalConnection(edtServer.Text, edtDB.Text, edtUser.Text, edtPW.Text);
       DM.MRInventoryConnectionClose;
       DM.MRInventoryConnectionOpen;
       end;
  end;
end;

end.
