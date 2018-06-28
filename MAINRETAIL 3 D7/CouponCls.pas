unit CouponCls;

interface
uses contnrs, SysUtils;

type
    TCoupon = class
    private
      FIdPromo: integer;  // = IdDiscont
      FIdPreinventory: integer;
      FIdModel: integer;
      FRewardAmount: double;
      FAmountType: string;
      FIsFree: boolean;
      FCashierShouldWarn: boolean;
      FNeedsPhysicalCoupon: boolean;
      FCouponCode: string;
      FDocumentId: integer;
      FSellingPrice: double;
    public
      constructor create();
      destructor destroy(); override;
      property IdPromo: integer read FIdPromo write FIdPromo;
      property IdPreInventory: integer read FIdPreinventory write FIdPreinventory;
      property IdModel: integer read FIdModel write FIdModel;
      property RewardAmount: double read FRewardAmount write FRewardAmount;
      property AmountType: string read FAmountType write FAmountType;
      property CashierShouldWarn: boolean read FCashierShouldWarn write FCashierShouldWarn;
      property NeedsPhysicalCoupon: boolean read FNeedsPhysicalCoupon write FNeedsPhysicalCoupon;
      property CouponCode: string read FCouponCode write FCouponCode;
      property DocumentId: integer read FDocumentId write FDocumentId;
      property SellingPrice: double read FSellingPrice write FSellingPrice;
    end;


implementation

{ TCoupon }

constructor TCoupon.create;
begin
//
end;

destructor TCoupon.destroy;
begin

  inherited;
end;

end.
