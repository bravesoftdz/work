unit uFrmGiftCardNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmGiftCardNumber = class(TFrmParentAll)
    edtGiftCardNumber: TEdit;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FGiftCardNumber: String;
  public
    function Start: Boolean;

    property GiftCardNumber: String read FGiftCardNumber write FGiftCardNumber;
  end;

implementation

uses uMsgBox, uMsgConstant;

{$R *.dfm}

function TFrmGiftCardNumber.Start: Boolean;
begin
  edtGiftCardNumber.Text := '';
  Result := ShowModal = mrOk;
  FGiftCardNumber := edtGiftCardNumber.Text;
end;

procedure TFrmGiftCardNumber.btnOkClick(Sender: TObject);
begin
  inherited;
  if edtGiftCardNumber.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_NUMBER, vbInformation + vbOKOnly);
    ModalResult := mrNone;
    edtGiftCardNumber.SetFocus;
  end;
end;

procedure TFrmGiftCardNumber.FormShow(Sender: TObject);
begin
  inherited;
  edtGiftCardNumber.SetFocus;
end;

end.
