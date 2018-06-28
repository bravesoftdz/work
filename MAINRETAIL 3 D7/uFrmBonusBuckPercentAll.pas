unit uFrmBonusBuckPercentAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmBonusBucksPercentAll = class(TFrmParentAll)
    edtPercent: TEdit;
    lblPercent: TLabel;
    btnOk: TButton;
    procedure edtPercentKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
  public
    function Start: Double;
  end;

implementation

uses uCharFunctions, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmBonusBucksPercentAll }

function TFrmBonusBucksPercentAll.Start: Double;
begin
  Result := -1;
  edtPercent.Text := '0';  
  ShowModal;

  if ModalResult = mrOk then
    Result := StrToFloat(edtPercent.Text);
end;

procedure TFrmBonusBucksPercentAll.edtPercentKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

procedure TFrmBonusBucksPercentAll.btnOkClick(Sender: TObject);
begin
  inherited;
  if edtPercent.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_EMPTY_VALUE, vbInformation + vbOKOnly);
    edtPercent.SetFocus;
    ModalResult := mrNone;
  end;
end;

end.
