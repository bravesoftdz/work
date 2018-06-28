unit uFrmTEFOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, Buttons, StdCtrls,
  uTefDedicadoInterface, ExtCtrls;

type
  TFrmTEFOptions = class(TFrmParentAll)
    msgClient: TMemo;
    TefDedicadoInterface1: TTefDedicadoInterface;
    btnCancelTEF: TBitBtn;
    btnAdmTEF: TBitBtn;
    btnVerificaTEF: TBitBtn;
    btnFechar: TBitBtn;
    rgTEFDial: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdmTEFClick(Sender: TObject);
    procedure btnVerificaTEFClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando1(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1ExecutaComando11(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando12(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando13(Sender: TObject);
    procedure TefDedicadoInterface1ExecutaComando2(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1ExecutaComando22(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1ExecutaComando3(Sender: TObject;
      Msg: String);
    procedure TefDedicadoInterface1LimpaMsg(Sender: TObject);
    procedure btnCancelTEFClick(Sender: TObject);
  private
    procedure SetMessage(msg : String);
    procedure EnableTEFDialOptions;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, ufrmTEFDialConfig, uTefDedicado, uTefConsts, uMsgBox;

{$R *.dfm}

{ TFrmTEFOptions }

function TFrmTEFOptions.Start: Boolean;
begin
  SetMessage('');
  msgClient.Font.Color := DM.fMRPOSColor.POSTextColor;
  rgTEFDial.Font.Color := DM.fMRPOSColor.POSTextColor;
  Self.Color := DM.fMRPOSColor.POSBackgroundColor;
  if DM.fCashRegister.UseTef = TEF_DIAL then
    EnableTEFDialOptions;
  ShowModal;
  Result := True;
end;

procedure TFrmTEFOptions.EnableTEFDialOptions;
var
  i : integer;
begin
  rgTEFDial.Items.Clear;
  for i := 0 to Length(TEF_DIAL_NAMES)-1 do
    if i in DM.FTEFDialTypes then
      rgTEFDial.Items.AddObject(TEF_DIAL_NAMES[i], Pointer(LongInt(i)));
  rgTEFDial.Visible := True;
  rgTEFDial.ItemIndex := 0;
end;

procedure TFrmTEFOptions.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmTEFOptions.btnAdmTEFClick(Sender: TObject);
var
 fResult : Boolean;
begin
  inherited;

  case DM.fCashRegister.UseTef of
    TEF_DIAL : begin
                  DM.TEFDial1.TEFDIALType := LongInt(rgTEFDial.Items.Objects[rgTEFDial.ItemIndex]);
                  DM.TEFDial1.Administracao;
               end;
    //ALTERADO
    TEF_DEDICADO : if DM.TEFDedicado1.FazTransacao(FUNCAO_TRANS_GERENCIAIS, 0, '', Now, '', '', '', nil, TefDedicadoInterface1) = 0 then
                     DM.TEFDedicado1.ConfirmaTransacao;

    {
    TEF_DEDICADO : begin
                     fResult := DM.TEFDedicado1.FazTransacao(FUNCAO_TRANS_GERENCIAIS, 0, '', Now, '', '', '', nil, TefDedicadoInterface1) = 0;
                     if DM.TEFDedicado1.TemPendencia then
                     begin
                       if fResult then
                         fResult := DM.TEFDedicado1.ConfirmaTransacao
                       else
                         repeat
                         until DM.TEFDedicado1.ResolvePendencias;
                     end;
                   end;
    }
  end;

end;

procedure TFrmTEFOptions.btnVerificaTEFClick(Sender: TObject);
begin
  inherited;

  case DM.fCashRegister.UseTef of
    TEF_DIAL : begin
                 DM.TEFDial1.TEFDIALType := LongInt(rgTEFDial.Items.Objects[rgTEFDial.ItemIndex]);
                 DM.TEFDial1.Ativacao;
               end;
    TEF_DEDICADO : DM.TEFDedicado1.TestaCominicacao(TefDedicadoInterface1);
  end;

end;

procedure TFrmTEFOptions.SetMessage(msg: String);
begin

  msgClient.Clear;
  msgClient.Text := msg;
  msgClient.SelStart := 0;
  msgClient.SelLength := 0;
  Application.ProcessMessages;

end;

procedure TFrmTEFOptions.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando1(
  Sender: TObject; Msg: String);
begin
  inherited;
  SetMessage(Msg); //Operador
end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando11(
  Sender: TObject);
begin
  inherited;
  SetMessage(''); //Operador
end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando12(
  Sender: TObject);
begin
  inherited;
  SetMessage(''); //Cliente
end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando13(
  Sender: TObject);
begin
  inherited;
  SetMessage(''); //Operador e Cliente
end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando2(
  Sender: TObject; Msg: String);
begin
  inherited;
  SetMessage(Msg); //Cliente
end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando22(
  Sender: TObject; Msg: String);
begin
  inherited;

  if Length(Msg) < 50 then
    MsgBox(Msg, vbInformation + vbOKOnly)
  else
    DM.MsgBoxScroll(Msg);

end;

procedure TFrmTEFOptions.TefDedicadoInterface1ExecutaComando3(
  Sender: TObject; Msg: String);
begin
  inherited;
  SetMessage(Msg); //Operador e Cliente
end;

procedure TFrmTEFOptions.TefDedicadoInterface1LimpaMsg(Sender: TObject);
begin
  inherited;
  SetMessage(''); //Operador e Cliente
end;

procedure TFrmTEFOptions.btnCancelTEFClick(Sender: TObject);
begin
  inherited;

  case DM.fCashRegister.UseTef of
    TEF_DIAL : begin
                 DM.TEFDial1.TEFDIALType := LongInt(rgTEFDial.Items.Objects[rgTEFDial.ItemIndex]);
                 with TfrmTEFDialConfig.Create(self) do
                  begin
                    Start(DM.TEFDial1.TEFDIALType);
                    Free;
                  end;
               end;
    TEF_DEDICADO : if DM.TEFDedicado1.FazTransacao(FUNCAO_CANCELAMENTO, 0, '', Now, '', '', '', nil, TefDedicadoInterface1) = 0 then
                     DM.TEFDedicado1.ConfirmaTransacao;
  end;

end;

end.
