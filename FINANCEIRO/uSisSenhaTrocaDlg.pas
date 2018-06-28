unit uSisSenhaTrocaDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Buttons, ExtCtrls, siComp, siLangRT, Mask,
  SuperComboADO;

type
  TSisSenhaTrocaDlg = class(TParentDialogFrm)
    edAtual: TEdit;
    edNova1: TEdit;
    edNova2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    scUser: TSuperComboADO;
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uMsgBox, uMsgCOnstant;

{$R *.DFM}

procedure TSisSenhaTrocaDlg.btOkClick(Sender: TObject);
begin
  inherited;
  if edNova1.text <> edNova2.text then
    MsgBox(MSG_CRT_ERROR_PW_NOT_MATCH, vbCritical + vbOkOnly)
  else
  begin
    with DM.quFreeSQL do
    begin
      Close;
      SQL.Text := 'SELECT U.CodSystemUser as CodigoUsuario, U.PW as Senha ' +
                  'FROM SystemUser U ' +
                  'WHERE U.IDUser = ' + scUser.LookUpValue + ' and Desativado = 0';
      Open;

      if DM.quFreeSQL.IsEmpty or (UpperCase(edAtual.Text) <> UpperCase(DM.quFreeSQL.FieldByName('Senha').AsString)) then
        MsgBox(MSG_INF_INVALID_USER_PASSWORD, vbOKOnly + vbInformation)
      else
      begin
        if MsgBox(MSG_QST_SURE, vbQuestion + vbYesNo) = vbYes then
        begin
          Close;
          DM.RunSQL('UPDATE SystemUser SET PW = ' + #39 + edNova1.Text + #39 + ' WHERE IDUser = ' + scUser.LookUpValue);
          Self.Close;
        end;
      end;

      Close;
    end;
  end;
end;

procedure TSisSenhaTrocaDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
