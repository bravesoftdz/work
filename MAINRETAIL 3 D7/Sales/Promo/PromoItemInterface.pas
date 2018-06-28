unit PromoItemInterface;

interface

type
  IPromoItem = interface
    function getHighestDiscount(arg_discount: Double): Double;
  end;

implementation

end.
