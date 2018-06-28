unit uFrmPreSaleItemDiscount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, Math;

type
  TFrmPreSaleItemDiscount = class(TFrmParentAll)
    btApply: TButton;
    Label2: TLabel;
    cmbCalcType: TComboBox;
    edtValue: TEdit;
    lblValue: TLabel;
    Label1: TLabel;
    edtSellingPrice: TEdit;
    Label3: TLabel;
    edtNewPrice: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbCalcTypeChange(Sender: TObject);
    procedure edtValueChange(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure btApplyClick(Sender: TObject);
  private
    fDiscountApplied: Boolean;
    fSellingPrice : Currency;
    function ValidadeDiscount:Boolean;
    function ApplyDiscount(fType:Integer; Value:Currency):Currency;
  public
    property DiscountApplied: Boolean read fDiscountApplied;
    function Start(SellingPrice:Currency):Currency;
  end;

implementation

uses uNumericFunctions, uDMGlobal, uCharFunctions, uMsgBox, uMsgConstant, uDM;

{$R *.dfm}

{ TFrmPreSaleItemDiscount }

function TFrmPreSaleItemDiscount.Start(SellingPrice: Currency): Currency;
begin
   fDiscountApplied := false;
   fSellingPrice := SellingPrice;
   // Antonio M F Souza November 27, 2012: edtSellingPrice.Text := MyFloatToStr(SellingPrice, DM.FQtyDecimalFormat);
   edtSellingPrice.Text := MyFloatToStr(SellingPrice, getDisplayFormat(CountDecimalPlaces(sellingPrice)));
   ShowModal;
   if (ModalResult = mrOK) then begin
     Result := ApplyDiscount(cmbCalcType.ItemIndex, MyStrToMoney(edtValue.Text));
     fDiscountApplied := true;
   end
   else
     Result := fSellingPrice;
end;

procedure TFrmPreSaleItemDiscount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPreSaleItemDiscount.cmbCalcTypeChange(Sender: TObject);
begin
  inherited;
  lblValue.Caption:= cmbCalcType.Items[cmbCalcType.ItemIndex];
  if edtValue.Text <> '' then
    edtNewPrice.Text := MyFloatToStr(ApplyDiscount(cmbCalcType.ItemIndex, MyStrToMoney(edtValue.Text)), DM.FQtyDecimalFormat);
end;

procedure TFrmPreSaleItemDiscount.edtValueChange(Sender: TObject);
begin
  inherited;
  edtNewPrice.Text := MyFloatToStr(ApplyDiscount(cmbCalcType.ItemIndex, MyStrToMoney(edtValue.Text)), DM.FQtyDecimalFormat);;
end;

procedure TFrmPreSaleItemDiscount.edtValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);

  if Key = ThousandSeparator then
    begin
    Key:=#0;
    MessageBeep($FFFFFFFF);
    end;

end;

function TFrmPreSaleItemDiscount.ValidadeDiscount: Boolean;
begin
  Result := True;                               
  if (cmbCalcType.ItemIndex = 0) and (MyStrToMoney(edtValue.Text) > 99) then
  begin
    MsgBox(MSG_INF_DISCOUNT_LIMT_REACHED, vbOKOnly + vbInformation);
    Result := False;
  end;
end;

procedure TFrmPreSaleItemDiscount.btApplyClick(Sender: TObject);
begin
  inherited;
  if not ValidadeDiscount then
    ModalResult := mrNone;
end;

function TFrmPreSaleItemDiscount.ApplyDiscount(fType: Integer;
  Value: Currency): Currency;
var
  roundValue: extended;
  roundSellingPrice: extended;
begin
  // Antonio M F Souza November 11, 2012
  //roundValue := forceRoundInThirdPosition(value, 2);
  //roundSellingPrice := forceRoundInThirdPosition(fSellingPrice, 2);

  if fType = 0 then
     Result := fSellingPrice - (fSellingPrice * (Value/power(10, CountDecimalPlaces(value))))
    // Antonio M F Souza November 11, 2012: Result := fSellingPrice - (fSellingPrice * (Value/power(10, DM.FQtyDecimal)))
    //   result := roundSellingPrice - (roundSellingPrice * ( roundValue / power(10, dm.FQtyDecimal)))
  else
    Result := fSellingPrice - Value;
    // Antonio M F Souza November 11, 2012: Result := fSellingPrice - Value;
    //   result := roundSellingPrice - roundValue;
end;

end.
