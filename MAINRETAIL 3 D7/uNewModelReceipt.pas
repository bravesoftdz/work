unit uNewModelReceipt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, StdCtrls, siComp, siLangRT, Buttons, ExtCtrls;

type
  TNewModelReceipt = class(TFrmParentAll)
    lblReceiptText: TLabel;
    mmReceiptText: TMemo;
    btOK: TButton;
    procedure btOKClick(Sender: TObject);
  private
    fIDModel : Integer;
    procedure InsertModelReceipt;
    function ValidadeReceiptText: Boolean;
  public
    function Start(IDModel: Integer):Boolean;
  end;

implementation

uses uDM, uSystemConst, uMsgConstant, uMsgBox;

{$R *.dfm}

{ TNewModelReceipt }

procedure TNewModelReceipt.InsertModelReceipt;
var
  sSQL: String;
begin
  sSQL := 'INSERT Inv_ModelReceipt (IDModelReceipt, IDModel, ReceiptText)' +
          'VALUES (' + IntToStr(DM.GetNextID(MR_MODEL_RECEIPT_ID)) + ',' +
           IntToStr(fIDModel) + ',' + QuotedStr(mmReceiptText.Text) + ' )';
  DM.RunSQL(sSQL);
end;

function TNewModelReceipt.Start(IDModel: Integer): Boolean;
begin
  fIDModel := IDModel;
  Result := True;
  ShowModal;
end;

procedure TNewModelReceipt.btOKClick(Sender: TObject);
begin
  inherited;
  if ValidadeReceiptText then
    InsertModelReceipt
  else
    ModalResult := mrNone;
end;

function TNewModelReceipt.ValidadeReceiptText: Boolean;
begin
  Result := True;

  if mmReceiptText.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_RECEIPT_TEXT, vbInformation + vbOkOnly);
    mmReceiptText.SetFocus;
    Result := False;
    Exit;
  end;
end;

end.
