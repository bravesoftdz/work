unit uSisSelPerfilDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, ExtCtrls, StdCtrls, Buttons, siComp, siLangRT;

type
  TSisSelPerfilDlg = class(TParentDialogFrm)
    Label1: TLabel;
    cmbPerfil: TComboBox;
    Image1: TImage;
    procedure cmbPerfilChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(sPerfil: TStrings): String;
  end;

implementation

{$R *.DFM}

function TSisSelPerfilDlg.Start(sPerfil: TStrings): String;
begin
  Self.Caption := 'Perfis de Acesso';

  cmbPerfil.Items := sPerfil;

  cmbPerfil.ItemIndex := 0;

  if ShowModal = mrOk then
    Result := cmbPerfil.Text
  else
    Result := '';
end;

procedure TSisSelPerfilDlg.cmbPerfilChange(Sender: TObject);
begin
  inherited;
  btOk.Enabled := (cmbPerfil.ItemIndex <> -1);
end;

end.
