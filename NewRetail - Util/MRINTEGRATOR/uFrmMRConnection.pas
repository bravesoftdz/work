unit uFrmMRConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

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
    function Start : Boolean;
  end;


implementation

uses uDM;

{$R *.dfm}

{ TFrmMRConnection }

function TFrmMRConnection.Start: Boolean;
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
     DM.CloseDatabase; 
     DM.OpenDatabase;
     end;
end;

end.
