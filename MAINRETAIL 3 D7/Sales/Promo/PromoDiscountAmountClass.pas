unit PromoDiscountAmountClass;

interface
uses PromoDiscountInterface, PromoItemClass;

type
  TPromoDiscountAmount = class(TInterfacedObject, IPromoDiscount)
  public
     function calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
     function calculatePromoDiscount(arg_item: TPromoItem): Double;
  end;

implementation

{ TPromoDiscountAmount }

function TPromoDiscountAmount.calculatePromoDiscount(
  arg_item: TPromoItem): Double;
begin
   result := 0;

   // deal Modelx and ModelY
end;

function TPromoDiscountAmount.calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
var
  discount: Double;
begin
   if ( arg_item.getDiscount > arg_item.getCustomerDiscount ) then
      discount := arg_Item.getDiscount
   else
      discount := arg_item.getCustomerDiscount;

  result := arg_item.getHighestDiscount(discount); // better item discount
end;

end.
