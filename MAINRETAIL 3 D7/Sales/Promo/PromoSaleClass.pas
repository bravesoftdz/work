unit PromoSaleClass;

interface
uses PromoClass, PromoConfigClass, PromoItemClass;

type
  TPromoSale = class(TPromo)
  protected
     function getPromoDiscount(arg_item: TPromoItem): Double; override;

  public

  end;

implementation

{ TPromoSale }

function TPromoSale.getPromoDiscount(arg_item: TPromoItem): Double;
begin
  addQuantity(arg_item);
  if ( arg_item.getFlatPromo ) then begin
      result := fdiscount.calculatePromoDiscountFlat(arg_item);
      ItemsPromoXList.Add(arg_item);
  end
  else begin
      result := fdiscount.calculatePromoDiscount(arg_item);
      ItemsPromoXList.Add(arg_item);
  end;

end;

end.
