unit PromoDiscountPercentClass;

interface
uses PromoDiscountInterface, PromoItemClass;

type
  TPromoDiscountPercent = class(TInterfacedObject, IPromoDiscount)
    public
      function calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
      function calculatePromoDiscount(arg_item: TPromoItem): Double;
  end;

implementation

{ TPromoDiscountPercent }

function TPromoDiscountPercent.calculatePromoDiscount(
  arg_item: TPromoItem): Double;
begin
  if ( arg_item.getFlatPromo ) then
     result := 0;

  // deal Modelx and ModelY

end;

function TPromoDiscountPercent.calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
var
  discount: Double;
  itemDiscount: Double;
begin
   itemDiscount := arg_item.getSellingPrice * ( arg_item.getDiscount / 100);

   if ( itemDiscount > arg_item.getCustomerDiscount ) then
      discount := itemDiscount
   else
      discount := arg_item.getCustomerDiscount;

  result := arg_item.getHighestDiscount(discount); // better item discount
end;

end.
