unit PromoDiscountSaleTotalClass;

interface
uses PromoDiscountInterface, PromoItemClass;

type
  TPromoDiscountSaleTotal = class(TInterfacedObject, IPromoDiscount)
    public
      function calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
      function calculatePromoDiscount(arg_item: TPromoItem): Double;
  end;

implementation

{ TPromoDiscountSaleTotal }

function TPromoDiscountSaleTotal.calculatePromoDiscount(
  arg_item: TPromoItem): Double;
begin
  if ( arg_item.getFlatPromo ) then
     result := 0;

  // deal Modelx and ModelY

end;

function TPromoDiscountSaleTotal.calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
begin
  result := 0;
end;

end.
