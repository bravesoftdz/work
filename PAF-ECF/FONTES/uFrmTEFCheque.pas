unit uFrmTEFCheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmTEFCheque = class(TForm)
    btnAbort: TButton;
    Selecionar: TButton;
    pnlManual: TPanel;
    edtCompens: TLabeledEdit;
    edtBanco: TLabeledEdit;
    edtAgencia: TLabeledEdit;
    edtC1: TLabeledEdit;
    edtContaC: TLabeledEdit;
    edtC2: TLabeledEdit;
    edtNumCheque: TLabeledEdit;
    edtC3: TLabeledEdit;
    pnlLeituraCMC7: TPanel;
    edtCMC7: TEdit;
    Label1: TLabel;
    procedure btnAbortClick(Sender: TObject);
    procedure SelecionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtCompensKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCompensEnter(Sender: TObject);
  private
    iStartType : Integer;
    FResult : String;
  public
    function StartManual(Msg: String) : String;
    function StartLeitura(Msg: String) : String;
  end;

implementation

{$R *.dfm}

{ TFrmTEFCheque }

function TFrmTEFCheque.StartManual(Msg: String): String;
begin
  Self.Caption := Msg;
  pnlManual.Visible := True;
  pnlLeituraCMC7.Visible := False;
  iStartType := 0;
  FResult := '-1';
  ShowModal;
  Result := FResult;
end;

procedure TFrmTEFCheque.btnAbortClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmTEFCheque.SelecionarClick(Sender: TObject);
begin
  if iStartType = 0 then
    FResult := '0:' + edtCompens.Text + edtBanco.Text + edtAgencia.Text + edtC1.Text + edtContaC.Text + edtC2.Text + edtNumCheque.Text + edtC3.Text
  else
    FResult := '1:' + edtCMC7.Text;
  Close;
end;

procedure TFrmTEFCheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmTEFCheque.StartLeitura(Msg: String): String;
begin
  Self.Caption := Msg;
  pnlManual.Visible := False;
  pnlLeituraCMC7.Visible := True;
  iStartType := 1;
  edtCMC7.Clear;
  FResult := '-1';
  ShowModal;
  Result := FResult;
end;

procedure TFrmTEFCheque.FormShow(Sender: TObject);
begin
  if iStartType = 1 then
    if edtCMC7.CanFocus then
      edtCMC7.SetFocus;
end;

procedure TFrmTEFCheque.edtCompensKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if TEdit(Sender).MaxLength = Length(TEdit(Sender).Text) then
    if TEdit(Sender).Name = 'edtCompens' then
      edtBanco.SetFocus
    else if TEdit(Sender).Name = 'edtBanco' then
      edtAgencia.SetFocus
    else if TEdit(Sender).Name = 'edtAgencia' then
      edtC1.SetFocus
    else if TEdit(Sender).Name = 'edtC1' then
      edtContaC.SetFocus
    else if TEdit(Sender).Name = 'edtContaC' then
      edtC2.SetFocus
    else if TEdit(Sender).Name = 'edtC2' then
      edtNumCheque.SetFocus
    else if TEdit(Sender).Name = 'edtNumCheque' then
      edtC3.SetFocus;

end;

procedure TFrmTEFCheque.edtCompensEnter(Sender: TObject);
begin
  TEdit(Sender).Clear;
end;

end.
