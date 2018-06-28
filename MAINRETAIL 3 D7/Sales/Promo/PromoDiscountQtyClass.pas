unit PromoDiscountQtyClass;

interface
uses PromoDiscountInterface, PromoItemClass;

type
  TPromoDiscountQty = class(TInterfacedObject, IPromoDiscount)
  public
     function calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
     function calculatePromoDiscount(arg_item: TPromoItem): Double;
  end;

implementation

{ TPromoDiscountQty }

function TPromoDiscountQty.calculatePromoDiscount(
  arg_item: TPromoItem): Double;
begin
  if ( arg_item.getFlatPromo ) then
     result := 0;

  // deal Modelx and ModelY
end;

function TPromoDiscountQty.calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
begin
   result := 0;
   // deal modelX and modelY
end;

end.
 