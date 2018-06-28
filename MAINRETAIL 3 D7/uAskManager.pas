unit uAskManager;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, siComp, siLangRT, PaiDeForms;

type
  TFrmAskManager = class(TFrmParentForms)
    EditPassword: TEdit;
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    Label3: TLabel;
    Panel10: TPanel;
    Image6: TImage;
    Image7: TImage;
    lblTip: TLabel;
    btOK: TButton;
    btCancel: TButton;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sNotPassword : String;
  public
    { Public declarations }
    function Start(TipText : String) : Boolean;
  end;

implementation

uses uDM, uNumericFunctions, uDMGlobal, uMsgBox, uMsgConstant, uSystemConst;

{$R *.DFM}

function TFrmAskManager.Start(TipText : String) : Boolean;
begin
  lblTip.Caption := TipText;

  Result := (ShowModal = mrOK);
end;

procedure TFrmAskManager.btOKClick(Sender: TObject);
begin
   if Trim(EditPassword.Text) = '' then
     begin
      EditPassword.SetFocus;
      raise exception.create(MSG_INF_PASSWORD_CANNOT_BE_NULL);
     end;

   if (MyStrToInt(DM.DescCodigo(['PW'], [Chr(39) + Trim(EditPassword.Text) + Chr(39)], 'SystemUser',
                'UserTypeID')) in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]) then
      ModalResult := mrOK
   else
     begin
      EditPassword.SetFocus;
      raise exception.create(sNotPassword);
     end;
end;

procedure TFrmAskManager.FormShow(Sender: TObject);
begin
   EditPassword.Text := '';
   EditPassword.SetFocus;
end;

procedure TFrmAskManager.btCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TFrmAskManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;



procedure TFrmAskManager.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
      LANG_ENGLISH :
          begin
          sNotPassword := 'This is not an administrator password.';
          end;
      LANG_PORTUGUESE :
          begin
          sNotPassword := 'Senha não é uma senha de Administrador.';
          end;
      LANG_SPANISH :
          begin
          sNotPassword := 'Contraseña no es valida de Administrador.';
          end;
  end;

end;

end.
