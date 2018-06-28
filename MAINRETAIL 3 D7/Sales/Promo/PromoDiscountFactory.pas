unit PromoDiscountFactory;

interface
uses PromoDiscountInterface, PromoDiscountAmountClass, PromoDiscountPercentClass, PromoDiscountQtyClass,
     PromoDiscountSaleTotalClass, uSystemConst, SysUtils;

type
  TPromoDiscountFactory = class
  public
    function createPromoDiscount(arg_type: Integer): IPromoDiscount;

  end;

implementation

{ TPromoDiscountFactory }

function TPromoDiscountFactory.createPromoDiscount(arg_type: Integer): IPromoDiscount;
begin
  case arg_type of
    PROMO_DISCOUNT_AMOUNT : result := TPromoDiscountAmount.create();
    PROMO_DISCOUNT_PERCENT: result := TPromoDiscountPercent.create();
    PROMO_DISCOUNT_QTY: result := TPromoDiscountQty.create();
    PROMO_DISCOUNT_SALE: result := TPromoDiscountSaleTotal.create();

    else begin
      raise Exception.Create('Unknown type of Promo Discount');
    end;

  end;
end;

end.
