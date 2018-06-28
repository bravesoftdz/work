(*
-----------------------------------------------------------------------------------------------------
Version : (288 - 276)
Date    : 12.09.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : component loosing numeric format.
Solution: I linked correct property to component.
Version : (288 - 277)
-----------------------------------------------------------------------------------------------------
*)

unit uFrmAskPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  SuperEdit, SuperEditCurrency;

type
  TFrmAskPrice = class(TFrmParentAll)
    lbPrice: TLabel;
    lbModel: TLabel;
    btOk: TButton;
    edtSalePrice: TSuperEditCurrency;
    procedure edtSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtSalePricePressEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function Start(sModel, sDesc: String):Currency;
  end;

implementation

uses
  uCharFunctions, uNumericFunctions, uDM;
{$R *.dfm}

{ TFrmAskPrice }

function TFrmAskPrice.Start(sModel, sDesc: String): Currency;
begin
  lbModel.Caption := (sModel + ' - ' + sDesc);
  ShowModal;
  Result := MyStrToMoney(edtSalePrice.Text);
end;

procedure TFrmAskPrice.edtSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
  if Key = ThousandSeparator then
    Key := #0;
end;

procedure TFrmAskPrice.FormShow(Sender: TObject);
begin
  inherited;
  edtSalePrice.SetFocus;
end;

procedure TFrmAskPrice.edtSalePricePressEnter(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmAskPrice.FormCreate(Sender: TObject);
begin
  inherited;
  //amfsouza 12.09.2010
  edtSalePrice.DisplayFormat := DM.FQtyDecimalFormat;
end;

end.
