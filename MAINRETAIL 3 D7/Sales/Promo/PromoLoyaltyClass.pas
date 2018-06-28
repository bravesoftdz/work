unit PromoLoyaltyClass;

interface
uses PromoClass, PromoItemClass, PromoConfigClass;

type
  TPromoLoyalty = class(TPromo)
  protected
     function getPromoDiscount(arg_item: TPromoItem): Double; override;

  public
  end;

implementation

{ TPromoLoyalty }


{ TPromoLoyalty }

function TPromoLoyalty.getPromoDiscount(arg_item: TPromoItem): Double;
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
