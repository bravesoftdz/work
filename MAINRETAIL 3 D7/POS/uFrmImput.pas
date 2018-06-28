unit uFrmImput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SuperEdit, SuperEditCurrency;

type
  TFrmImput = class(TForm)
    Selecionar: TButton;
    edtInput: TEdit;
    lbInput: TLabel;
    btnAbort: TButton;
    edtCurrency: TSuperEditCurrency;
    btnVoltar: TButton;
    procedure SelecionarClick(Sender: TObject);
    procedure btnAbortClick(Sender: TObject);
    procedure edtCurrencyPressEnter(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    FResult : String;
    FValue : Double;
    FMin: Integer;
    FStartType : Integer;
    FValidarSenha : Boolean;
    FComando: Integer;
    FTipoCampo: Integer;
    function SenhaValida : Boolean;
    function ValidateInput: Boolean;
  public
    function Start(Texto : String; AMin, Max : Integer; ValidarSenha : Boolean; const Comando,
  TipoCampo: Integer):String;
    function StartDouble(Texto : String; AMin, Max : Integer):Double;
  end;

implementation

uses uMsgBox, uDM, DBClient, DB, uSystemConst;

{$R *.dfm}

function TFrmImput.Start(Texto: String; AMin, Max: Integer; 
  ValidarSenha : Boolean; const Comando,
  TipoCampo: Integer): String;
begin
  lbInput.Caption := Texto;
  edtInput.MaxLength := Max;
  FMin := AMin;
  edtInput.Clear;
  FStartType := 0;
  edtCurrency.Visible := False;
  edtInput.Visible    := True;
  FValidarSenha := ValidarSenha;
  FComando := Comando;
  FTipoCampo := TipoCampo;

  if FValidarSenha then
    edtInput.PasswordChar := '*'
  else
    edtInput.PasswordChar := #0;
  ShowModal;
  Result := FResult;
end;

function TFrmImput.StartDouble(Texto: String; AMin, Max: Integer): Double;
begin
  lbInput.Caption := Texto;
  edtCurrency.MaxLength := Max;
  FMin := AMin;
  edtInput.Clear;
  FStartType := 1;
  edtCurrency.Visible := True;
  edtInput.Visible    := False;
  ShowModal;
  Result := FValue;
end;

function TFrmImput.ValidateInput: Boolean;
begin
  Result := False;
  if (FComando = 30) and (FTipoCampo = 513) then
    if Trim(edtInput.Text) = '' then
      Exit;
  Result := True;
end;

procedure TFrmImput.SelecionarClick(Sender: TObject);
begin
  if not ValidateInput then
    Exit;
    
  if FStartType = 0 then
  begin
    {if Length(Trim(edtInput.Text)) < FMin then
    begin
      MessageBeep($FFFFFFFF);
      Exit;
    end;}

    if FValidarSenha and (not SenhaValida) then
    begin
      edtInput.Clear;
      Exit;
    end;

    FResult := edtInput.Text;
  end else
  begin
    try
      StrToCurr(edtCurrency.Text);
    Except
      MsgBox('Formatação inválida', vbCritical + vbOKOnly);
      Exit;
    end;
    FValue := StrToCurr(edtCurrency.Text);
  end;

  Close;
end;

procedure TFrmImput.btnAbortClick(Sender: TObject);
begin
  if FStartType = 0 then
    FResult := '-1'
  else
    FValue := -1;
  Close;
end;

procedure TFrmImput.edtCurrencyPressEnter(Sender: TObject);
begin
  SelecionarClick(self);
end;

function TFrmImput.SenhaValida: Boolean;
begin

  Result := False;

  with DM.cdsSystemUser do
  begin
   if not Active then
     Open;
   if Locate('PW', edtInput.Text, []) then
   begin
     Result := (FieldByName('UserTypeID').AsInteger in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);
     if not Result then
       MsgBox('Você não tem acesso para esta operaçao', vbInformation + vbOKOnly);
   end
   else
     MsgBox('Senha inválida', vbInformation + vbOKOnly);
  end;

end;

procedure TFrmImput.btnVoltarClick(Sender: TObject);
begin
  if FStartType = 0 then
    FResult := '-2'
  else
    FValue := -2;
  Close;

end;

end.
