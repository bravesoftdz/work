unit PromoFactoryClass;

interface
uses PromoClass, PromoSaleClass, PromoLoyaltyClass, PromoFreqBuyerClass, PromoCouponClass, uSystemConst, SysUtils,
     PromoItemClass;

type
  TPromoFactory = class
  public
    function createPromo(arg_item: TPromoItem): TPromo;

  end;

implementation

{ TPromoFactory }

function TPromoFactory.createPromo(arg_item: TPromoItem): TPromo;
begin

  case ( arg_item.getDiscountType ) of
    PROMO_COUPON_TYPE : result := TPromoCoupon.create(arg_item);
    PROMO_FREQBUYER_TYPE: result := TPromoFreqBuyer.Create(arg_item);
    PROMO_LOYALTY_TYPE: result := TPromoLoyalty.Create(arg_item);
    PROMO_SALE_TYPE: result := TPromoSale.create(arg_item);

    else begin
      raise Exception.Create('Unknown type of Promo');
    end;

  end;

end;

end.
