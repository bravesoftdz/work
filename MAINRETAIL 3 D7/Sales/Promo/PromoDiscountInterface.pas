unit PromoDiscountInterface;

interface
uses PromoItemClass;


type
  IPromoDiscount = interface
    function calculatePromoDiscount(arg_item: TPromoItem): Double;
    function calculatePromoDiscountFlat(arg_item: TPromoItem): Double;
  end;

implementation

end.
