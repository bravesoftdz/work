unit uFrmCashBackValue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmCashBackValue = class(TFrmParentAll)
    btOk: TButton;
    edtCaskBackValue: TEdit;
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCaskBackValueKeyPress(Sender: TObject; var Key: Char);
  private
    FCashBackValue: Currency;
  public
    function Start: Boolean;

    property CashBackValue: Currency read FCashBackValue write FCashBackValue;
  end;

implementation

uses uMsgBox, uMsgConstant, uNumericFunctions, uCharFunctions;

{$R *.dfm}

function TFrmCashBackValue.Start: Boolean;
begin
  edtCaskBackValue.Text := '';
  Result := ShowModal = mrOk;
end;

procedure TFrmCashBackValue.btOkClick(Sender: TObject);
begin
  inherited;
  if edtCaskBackValue.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_NUMBER, vbInformation + vbOKOnly);
    ModalResult := mrNone;
    edtCaskBackValue.SetFocus;
  end
  else
  begin
    FCashBackValue := MyStrToCurrency(edtCaskBackValue.Text);
    if FCashBackValue = 0 then
    begin
      edtCaskBackValue.Text := '0';
      ModalResult := mrNone;
    end;
  end;
end;

procedure TFrmCashBackValue.FormShow(Sender: TObject);
begin
  inherited;
  edtCaskBackValue.SetFocus;
end;

procedure TFrmCashBackValue.edtCaskBackValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key <> '-' then
  begin
    Key := ValidateCurrency(Key);
  end
  else
    Key := #0;
end;

end.
