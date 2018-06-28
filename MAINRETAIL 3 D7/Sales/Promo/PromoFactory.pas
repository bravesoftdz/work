unit PromoFactory;

interface
uses PromoClass, PromoSaleClass, PromoLoyaltyClass, PromoFreqBuyerClass, PromoCouponClass, uSystemConst, SysUtils;

type
  TPromoFactory = class
  public
    function createPromo(arg_type: Integer; arg_invoice, arg_idmov: Integer): TPromo;

  end;

implementation

{ TPromoFactory }

function TPromoFactory.createPromo(arg_type: Integer; arg_invoice, arg_idmov: Integer): TPromo;
begin

  case arg_type of
    PROMO_COUPON_TYPE : result := TPromoCoupon.create(arg_invoice, arg_idmov);
    PROMO_FREQBUYER_TYPE: result := TPromoFreqBuyer.Create(arg_invoice, arg_idmov);
    PROMO_LOYALTY_TYPE: result := TPromoLoyalty.Create(arg_invoice, arg_idmov);
    PROMO_SALE_TYPE: result := TPromoSale.create(arg_invoice, arg_idmov);

    else begin
      raise Exception.Create('Unknown type of Promo');
    end;

  end;

end;

end.
