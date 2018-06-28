unit uSisSenha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, ExtCtrls, Buttons, Db, DBTables, registry,
  Mask, ComCtrls, ADODB, RCADOQuery, SuperComboADO, siComp, siLangRT;

type
  TSisSenha = class(TParentDialogFrm)
    quSenha: TRCADOQuery;
    quSenhaIDUsuario: TIntegerField;
    quSenhaUsuario: TStringField;
    quSenhaSenha: TStringField;
    quSenhaCodigoUsuario: TStringField;
    EditSenha: TEdit;
    Titulo1: TLabel;
    Titulo1Sombra: TLabel;
    btAlterarSenha: TButton;
    quSenhaContadorClasse: TIntegerField;
    quSenhaIDGrupo: TIntegerField;
    scCompany: TSuperComboADO;
    Image1: TImage;
    Titulo2: TLabel;
    Titulo2Sombra: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    quSenhaIDUser: TIntegerField;
    scUser: TSuperComboADO;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAlterarSenhaClick(Sender: TObject);
  private
    nRetry    : integer;
    procedure DefaultCompany(isGet:Boolean);
  public
    IDUsuario : integer;
    IDUser    : integer;
    IDEspaco  : integer;
    IDGrupo   : integer;
    ContadorClasse : integer;
    CodUsuario, Usuario : String;
    function Start : boolean;
    function HasAccess(ActionIndex: integer) : boolean;
  end;

var
  SisSenha: TSisSenha;

implementation

uses uDM, uMsgBox, uSisSenhaTrocaDlg, uDMGlobal, uMsgConstant,
     uNumericFunctions, uOperationSystem;

{$R *.DFM}

procedure TSisSenha.DefaultCompany(isGet:Boolean);
var
  buildInfo: String;
begin

  with TRegistry.Create do
     begin

     if ( getOS(buildInfo) = osW7 ) then
         RootKey:= HKEY_CURRENT_USER
     else
         RootKey := HKEY_LOCAL_MACHINE;

     OpenKey('SOFTWARE\Applenet\OfficeManager', True);
     if not ValueExists('IDDefaultCompany') then
        WriteInteger('IDDefaultCompany', 0);

     if isGet then
        begin
        if ReadInteger('IDDefaultCompany') <> 0 then
           begin
             DM.IDDefaultCompany       := ReadInteger('IDDefaultCompany');
             DMGlobal.IDDefaultCompany := DM.IDDefaultCompany;
           end;
        end
     else
       if scCompany.LookUpValue <> '' then
       begin
         WriteInteger('IDDefaultCompany', MyStrToInt(scCompany.LookUpValue));
         DM.IDDefaultCompany       := MyStrToInt(scCompany.LookUpValue);
         DMGlobal.IDDefaultCompany := MyStrToInt(scCompany.LookUpValue);
       end;

     CloseKey;
     Free;
     end;

end;

function TSisSenha.HasAccess(ActionIndex: integer) : boolean;
begin
  Result := True;
end;

function TSisSenha.Start : boolean;
begin
  Result := (ShowModal = mrOK);
end;

procedure TSisSenha.FormShow(Sender: TObject);
begin
  inherited;
  nRetry := 0;
  EditSenha.Clear;

  Titulo1.Caption := Application.Title;
  Titulo1Sombra.Caption := Application.Title;
  Titulo2.Caption := Application.Title;
  Titulo2Sombra.Caption := Application.Title;

  DefaultCompany(True);
  scCompany.LookUpValue := IntToStr(DM.IDDefaultCompany);

end;

procedure TSisSenha.btOkClick(Sender: TObject);
begin
  inherited;
  // Testa a validade da senha e usuario
{  if EditSenha.Text = 'udetacos' then // senha master do costa
    begin
      IDUsuario   := 1002;
      CodUsuario  := 'ECosta';
      Usuario     := 'Eduardo Costa';
      DM.sSisUser := 'Eduardo Costa';
      Exit;
    end;}

  if nRetry > 3 then
    begin
      MsgBox(MSG_INF_LOGIN_EXPIRED, vbOKOnly + vbInformation);
      ModalResult := mrCancel;
      Exit;
    end;

  if scCompany.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_COMPANY_SELECTED, vbOKOnly + vbInformation);
    ModalResult := mrNone;
    Exit;
  end;

  DefaultCompany(False);

  with quSenha do
    begin
      Close;
      Parameters.ParamByName('IDUsuario').Value := scUser.LookUpValue;
      Open;
      if (Trim(UpperCase(quSenhaSenha.AsString)) = Trim(UpperCase(EditSenha.Text))) and not ( Bof and Eof) then
        begin
         IDUsuario      := quSenhaIDUsuario.AsInteger;
         IDUser         := quSenhaIDUser.AsInteger;
         IDGrupo        := quSenhaIDGrupo.AsInteger; 
         CodUsuario     := quSenhaCodigoUsuario.AsString;
         Usuario        := quSenhaUsuario.AsString;
         ContadorClasse := quSenhaContadorClasse.AsInteger;
         DM.sSisUser    := Usuario;
         Close;
        end
      else
        begin
         Inc(nRetry);
         MsgBox(MSG_INF_INVALID_USER_PASSWORD, vbOKOnly + vbInformation);
         ModalResult := mrNone;
         editSenha.SetFocus;
         editSenha.Text := '';
        end;
    end;
end;

procedure TSisSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  quSenha.Close;
end;

procedure TSisSenha.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSisSenha.FormCreate(Sender: TObject);
begin
  inherited;

  if Application.Terminated then
    Close;

end;

procedure TSisSenha.btAlterarSenhaClick(Sender: TObject);
begin
  inherited;
  with TSisSenhaTrocaDlg.Create(self) do
    begin
      ShowModal;
      Free;
    end;
end;

end.
