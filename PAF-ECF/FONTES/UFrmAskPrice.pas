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
    procedure edtSalePriceKeyPress(Sender: TObject; var Key: Char);
  private
  public
    function Start(sModel:String):Currency;
  end;

implementation

uses uNumericFunctions, uCharFunctions;

{$R *.dfm}

{ TFrmAskPrice }

function TFrmAskPrice.Start(sModel:String): Currency;
begin
  lbModel.Caption := sModel;
  ShowModal;
  Result := MyStrToMoney(edtSalePrice.Text);
end;

procedure TFrmAskPrice.edtSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

end.
