unit uFrmPessoaHistoryTypeResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  ADODB;

type
  TFrmPessoaHistoryTypeResult = class(TFrmParent)
    btnSave: TButton;
    Label1: TLabel;
    edtResult: TEdit;
    lbHasBairro: TLabel;
    Label2: TLabel;
    pnlMenuHighlight: TPanel;
    CD: TColorDialog;
    cmdInsResult: TADOCommand;
    procedure pnlMenuHighlightClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FIDPessoaHistoryType : Integer;
    function ValidateResult : Boolean;
    procedure InsertResult;
  public
    function Start(IDPessoaHistoryType : Integer) : Boolean;
  end;


implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmPessoaHistoryTypeResult }

function TFrmPessoaHistoryTypeResult.Start(IDPessoaHistoryType : Integer): Boolean;
begin
  FIDPessoaHistoryType := IDPessoaHistoryType;
  ShowModal;
  Result := True;
end;

procedure TFrmPessoaHistoryTypeResult.pnlMenuHighlightClick(
  Sender: TObject);
begin
  inherited;
  CD.Color := TPanel(Sender).Color;
  if CD.Execute then
     TPanel(Sender).Color := CD.Color;
end;

procedure TFrmPessoaHistoryTypeResult.InsertResult;
begin
  with cmdInsResult do
  begin
    Parameters.ParamByName('IDPessoaHistoryResult').Value := DM.GetNextID('Mnt_PessoaHistoryResult.IDPessoaHistoryResult');
    Parameters.ParamByName('IDPessoaHistoryType').Value   := FIDPessoaHistoryType;
    Parameters.ParamByName('PessoaHistoryResult').Value   := edtResult.Text;
    Parameters.ParamByName('ResultColor').Value           := ColorToString(pnlMenuHighlight.Color);
    Execute;
  end;

end;

function TFrmPessoaHistoryTypeResult.ValidateResult: Boolean;
begin
  Result := True;

  if Trim(edtResult.Text) = '' then
  begin
  MsgBox(MSG_CRT_NOT_RESULT_TYPE, vbCritical + vbOkOnly);
  Result := False;
  Exit;
  end;


end;

procedure TFrmPessoaHistoryTypeResult.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateResult then
  begin
    InsertResult;
    Close;
  end;
end;

end.
