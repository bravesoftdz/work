unit UFrmAskPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmAskPrice = class(TFrmPai)
    lbPrice: TLabel;
    edtSalePrice: TEdit;
    lbModel: TLabel;
    lbMsg: TLabel;
    procedure edtSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure btCloseClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FResult : Boolean;
    function ValidateAmount : Boolean;
  public
    function Start(sModel:String):Currency;
  end;

implementation

uses uNumericFunctions, uCharFunctions, uDM;

{$R *.dfm}

{ TFrmAskPrice }

function TFrmAskPrice.Start(sModel:String): Currency;
begin
  Result := 0;
  FResult := False;
  lbModel.Caption := sModel;
  lbMsg.Caption := 'Erro no preço! Valor ultrapassou ' + FormatFloat('#,##0.00', DM.fCashRegister.MaxAmountAskPrice);
  ShowModal;
  if FResult then
    Result := MyStrToMoney(edtSalePrice.Text);
end;

procedure TFrmAskPrice.edtSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
  lbMsg.Visible := False;
end;

procedure TFrmAskPrice.btCloseClick(Sender: TObject);
begin
  inherited;
  if not ValidateAmount then
    ModalResult := mrNone
  else
    FResult := True;
end;

function TFrmAskPrice.ValidateAmount: Boolean;
var
  FAmount : Currency;
begin

  try
    FAmount := MyStrToMoney(edtSalePrice.Text);
  finally
    if (FAmount > DM.fCashRegister.MaxAmountAskPrice) or (FAmount = 0) then
    begin
      lbMsg.Visible := True;
      edtSalePrice.Clear;
      Result := False;
    end
    else
      Result := True;
  end;
end;

procedure TFrmAskPrice.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

   if key = VK_ESCAPE then
     Close;

end;

end.
