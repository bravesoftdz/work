unit PromoDTO;

interface
uses Classes, contnrs, StoreCls, SysUtils, variants, dialogs, PromoHandleConflict;

type

  TDiscountQualifying = class
  private
    fIDDiscount: Integer;
  protected
    procedure setIDDiscount(arg_id: Integer);
    function getIDDiscount(): Integer;
  end;

  TDiscountCustomerGroup = class(TDiscountQualifying)
  private
    fIdTipoPessoa: Integer;
    fName: String;
  public
    procedure setIDTipoPessoaStr(arg_id: String);
    procedure setIDTipoPessoa(arg_id: Integer);
    function getIDTipoPessoa(): Integer;
    function getIDTipoPessoaStr(): String;
    procedure setName(arg_name: String);
    function getName(): String;
  end;

  TDiscountPurchase = class(TDiscountQualifying)
  private
    fIDTag: Integer;
    fNameTag: String;
  public
    procedure setIDTag(arg_tag: Integer);
    function getIDTag(): Integer;
    procedure setName(arg_name: String);
    function getName(): String;
  end;

  TDiscountReward = class(TDiscountPurchase);

  TPromoDTO = class
  private
    fIsInclude: Boolean;
    fDiscountValidOnDays: TStringList;
    fDiscountCoupons: TStringList;

    fPurchaseTagList: TObjectList;
    fRewardTagList: TObjectList;
    fCustomerList: TObjectList;
    fStoreList: TObjectList;

    // seek for conflicts between promos and tags
    FHandleConfllict: TPromoHandleConflict;

    fIDStore: Integer;
    fIDDiscount: Integer;
    fDiscountName: String;
    fEndDate: TDateTime;
    fStartDate: TDateTime;
    fDayOfWeek: String;
    fBeginTimeOfDay: TDateTime;
    fEndTimeOfDay: TDateTime;
    fDiscType: String;
    fMinSubTotal: Double;
    fStoreDefined: Boolean;
    fCustomerGroupDefined: Boolean;
    fPurchaseTagDefined: Boolean;
    fRewardTagDefined: Boolean;
    fCouponDefined: Boolean;
    fCouponNumber: String;
    fIDTagQualifyingDiscount: Integer;
    fIdDiscUses: Integer;
    fIDTagRewards: Integer;
    fMaxUsesPerCustomer: Integer;
    fMaxUsesInTotal: Integer;
    fFirstTimeCustomerOnly: Boolean;
    fCustomerCardRequired: Boolean;
    fCustomerGroup: Boolean;
    fAllowedCustomerGroup: String;
    fIsStackable: Boolean;
    fRewardAmount: Double;
    fAmountType: String;
    fRewardQuantity: variant;
    fMinQuantity: variant;
    fMinDollarAmount: variant;
    fSalePrice: Double;
    fIsBogo: boolean;
    FBuyAnd: boolean;
    FCashierShouldWarn: boolean;
    function getIDDiscount: Integer;
    procedure setIDDiscount(const Value: Integer);
    function getAllowedCustomerGroup: String;
    function getAmountType: String;
    function getBeginTimeOfDay: TDateTime;
    //function getDayOfWeek: String;
    function getDiscountType: String;
    function getEndTimeOfDay: TDateTime;
    function getIsStackable: Boolean;
    function getMaxUsesInTotal: Integer;
    function getMaxUsesPerCustomer: Integer;
    function getMinDollarAmount: variant;
    function getMinQuantity: variant;
    function getMinSubTotal: Double;
    function getRewardAmount: Double;
    function getRewardQuantity: variant;
    procedure setAllowedCustomerGroup(const Value: String);
    procedure setAmountType(const Value: String);
    procedure setBeginTimeOfDay(const Value: TDateTime);
    procedure setCustomerCardRequired(const Value: Boolean);
    //procedure setDayOfWeek(const Value: String);
    procedure setDiscountType(const Value: String);
    procedure setMinDollarAmount(const Value: variant);
    procedure setEndTimeOfDay(const Value: TDateTime);
    procedure setFirstTimeCustomerOnly(const Value: Boolean);
    procedure setIsStackable(const Value: Boolean);
    procedure setMaxUsesInTotal(const Value: Integer);
    procedure setMaxUsesPerCustomer(const Value: Integer);
    procedure setMinQuantity(const Value: variant);
    procedure setMinSubTotal(const Value: Double);
    procedure setRewardAmount(const Value: Double);
    procedure setRewardQuantity(const Value: variant);
    function getCustomerCardRequired: Boolean;
    function getFirstTimeCustomerOnly: Boolean;
    function getEndDate: TDateTime;
    function getStartDate: TDateTime;
    procedure setEndDate(const Value: TDateTime);
    procedure setStartDate(const Value: TDateTime);
    function getCouponNumber: String;
    procedure setCouponNumber(const Value: String);
    function getIDDiscUses: Integer;
    function getIDTagQualifyingDiscount: Integer;
    procedure setDiscUses(const Value: Integer);
    procedure setIDTagQualifyingDiscount(const Value: Integer);
    function getIDTagRewards: Integer;
    procedure setIDTagRewards(const Value: Integer);
    function getCustomerGroup: Boolean;
    procedure setCustomerGroup(const Value: Boolean);

    function getDiscountName: String;
    procedure setDiscountName(const Value: String);
    function getCouponDefined: Boolean;
    function getPurchaseTagDefined: Boolean;
    function getRewardTagDefined: Boolean;
    function getStoredDefined: Boolean;
    procedure setCouponDefined(const Value: Boolean);
    procedure setPurchaseTagDefined(const Value: Boolean);
    procedure setRewardTagDefined(const Value: Boolean);
    procedure setStoreDefined(const Value: Boolean);
    function getCustomerGroupDefined: Boolean;
    procedure setCustomerGroupDefined(const Value: Boolean);
    function getIDStore: Integer;
    procedure setIDStore(const Value: Integer);
    function getSalePrice: Double;
    procedure setSalePrice(const Value: Double);

    function getIsBogo(): boolean;
    procedure setIsBogo(const value: boolean);

    function getBuyAnd(): boolean;
    procedure setBuyAnd(const value: boolean);

  public
    constructor create();
    destructor destroy(); override;

    property IsInclude: Boolean read fIsInclude write fIsInclude;
    property StoreDefined: Boolean read getStoredDefined write setStoreDefined;
    property CustomerGroupDefined: Boolean read getCustomerGroupDefined write setCustomerGroupDefined;
    property PurchaseTagDefined: Boolean read getPurchaseTagDefined write setPurchaseTagDefined;
    property RewardTagDefined: Boolean read getRewardTagDefined write setRewardTagDefined;
    property CouponDefined: Boolean read getCouponDefined write setCouponDefined;

    property IDStore: Integer read getIDStore write setIDStore;
    property IDDiscount: Integer read getIDDiscount write setIDDiscount;
    property DiscountName: String read getDiscountName write setDiscountName;
    property StartDate: TDateTime read getStartDate write setStartDate;
    property EndDate: TDateTime read getEndDate write setEndDate;
    property DayOfWeek: String read FDayOfWeek write FDayOfWeek;
    property BeginTimeOfDay: TDateTime read getBeginTimeOfDay write setBeginTimeOfDay;
    property EndTimeOfDay: TDateTime read getEndTimeOfDay write setEndTimeOfDay;
    property DiscountType: String read getDiscountType write setDiscountType;
    property MinSubTotal: Double read getMinSubTotal write setMinSubTotal;
    property CouponNumber: String read getCouponNumber write setCouponNumber;
    property IDTagQualifyingDiscount: Integer read getIDTagQualifyingDiscount write setIDTagQualifyingDiscount;
    property IDDiscUses: Integer read getIDDiscUses write setDiscUses;
    property IDTagRewards: Integer read getIDTagRewards write setIDTagRewards;
    property MaxUsesPerCustomer: Integer read getMaxUsesPerCustomer write setMaxUsesPerCustomer;
    property MaxUsesInTotal: Integer read getMaxUsesInTotal write setMaxUsesInTotal;
    property FirstTimeCustomerOnly: Boolean read getFirstTimeCustomerOnly write setFirstTimeCustomerOnly;
    property CustomerCardRequired: Boolean read getCustomerCardRequired write setCustomerCardRequired;
    property CustomerGroup: Boolean read getCustomerGroup write setCustomerGroup;
    property AllowedCustomerGroup: String read getAllowedCustomerGroup write setAllowedCustomerGroup;
    property IsStackable: Boolean read getIsStackable write setIsStackable;
    property RewardAmount: Double read getRewardAmount write setRewardAmount;
    property AmountType: String read getAmountType write setAmountType;
    property RewardQuantity: variant read getRewardQuantity write setRewardQuantity;
    property MinQuantity: variant read getMinQuantity write setMinQuantity;
    property MinDollarAmount: variant read getMinDollarAmount write setMinDollarAmount;
    property SalePrice: Double read getSalePrice write setSalePrice;
    property IsBogo: boolean read getIsBogo write setIsBogo;
    property BuyAnd: boolean read getBuyAnd write setBuyAnd;
    property CashierShouldWarn: boolean read FCashierShouldWarn write FCashierShouldWarn;

    function getCouponsDiscount(): TStringList;
    function getValidOnDaysDiscount(): TStringList;
    function getCustomerGroupList: TObjectList;
    function getPurchaseTagList: TObjectList;
    function getRewardTagList: TObjectList;
    function getStoreList: TObjectList;

    procedure addCouponsToList(arg_coupon: String);
    procedure addPurchaseTagToList(arg_tag: TDiscountPurchase);
    procedure addRewardTagToList(arg_tag: TDiscountReward);
    procedure addCustomerGroupToList(arg_customGroup: TDiscountCustomerGroup);
    procedure addStoreToList(arg_store: TStoreRegistry);
    procedure addDiscountValidOnDayToList(arg_day: String);

  end;

  TCouponPromo = class(TPromoDTO)
  private
     FCouponCode: string;
     FCashierShouldWarn: boolean;
     FNeedsPhysicalCoupon: boolean;
  public
     property CouponCode: string read FCouponCode write FCouponCode;
     property CashierShouldWarn: boolean read FCashierShouldWarn  write FCashierShouldWarn;
     property NeedsPhysicalCoupon: boolean read FNeedsPhysicalCoupon write FNeedsPhysicalCoupon; 
  end;

implementation

{ TPromoDTO }

function TPromoDTO.getAllowedCustomerGroup: String;
begin
  result := fAllowedCustomerGroup
end;

function TPromoDTO.getAmountType: String;
begin
  result := fAmountType
end;

function TPromoDTO.getBeginTimeOfDay: TDateTime;
begin
  result := fBeginTimeOfDay
end;

function TPromoDTO.getCustomerCardRequired: Boolean;
begin
  result := fCustomerCardRequired
end;

(*
function TPromoDTO.getDayOfWeek: String;
begin
  Result := fDayOfWeek
end;
*)

function TPromoDTO.getDiscountType: String;
begin
  result := fDiscType
end;

function TPromoDTO.getEndDate: TDateTime;
begin
  result := fEndDate
end;

function TPromoDTO.getEndTimeOfDay: TDateTime;
begin
  result := fEndTimeOfDay
end;

function TPromoDTO.getFirstTimeCustomerOnly: Boolean;
begin
  result := fFirstTimeCustomerOnly
end;

function TPromoDTO.getIDDiscount: Integer;
begin
  result := fIDDiscount
end;

function TPromoDTO.getIsStackable: Boolean;
begin
  result := fIsStackable
end;

function TPromoDTO.getMaxUsesInTotal: Integer;
begin
  result := fMaxUsesInTotal
end;

function TPromoDTO.getMaxUsesPerCustomer: Integer;
begin
  result := fMaxUsesPerCustomer
end;

function TPromoDTO.getMinDollarAmount: variant;
begin
  result := fMinDollarAmount
end;

function TPromoDTO.getMinQuantity: variant;
begin
  result := fMinQuantity
end;

function TPromoDTO.getMinSubTotal: Double;
begin
  result := fMinSubTotal
end;

function TPromoDTO.getRewardAmount: Double;
begin
   result := fRewardAmount;
end;

function TPromoDTO.getRewardQuantity: variant;
begin
  result := fRewardQuantity
end;

function TPromoDTO.getStartDate: TDateTime;
begin
  result := fStartDate
end;

procedure TPromoDTO.setAllowedCustomerGroup(const Value: String);
begin
  fAllowedCustomerGroup := value
end;

procedure TPromoDTO.setAmountType(const Value: String);
begin
  fAmountType := value
end;

procedure TPromoDTO.setBeginTimeOfDay(const Value: TDateTime);
begin
  fBeginTimeOfDay := value
end;

procedure TPromoDTO.setCustomerCardRequired(const Value: Boolean);
begin
  fCustomerCardRequired := value
end;

(*
procedure TPromoDTO.setDayOfWeek(const Value: String);
begin
  DayOfWeek := value
end;
*)

procedure TPromoDTO.setDiscountType(const Value: String);
begin
  fDiscType := value
end;

procedure TPromoDTO.setMinDollarAmount(const Value: variant);
begin
  fMinDollarAmount := value
end;

procedure TPromoDTO.setEndDate(const Value: TDateTime);
begin
  fEndDate := value
end;

procedure TPromoDTO.setEndTimeOfDay(const Value: TDateTime);
begin
  fEndTimeOfDay := value
end;

procedure TPromoDTO.setFirstTimeCustomerOnly(const Value: Boolean);
begin
  fFirstTimeCustomerOnly := value
end;

procedure TPromoDTO.setIDDiscount(const Value: Integer);
begin
  fIDDiscount := value
end;

procedure TPromoDTO.setIsStackable(const Value: Boolean);
begin
  fIsStackable := value;
end;

procedure TPromoDTO.setMaxUsesInTotal(const Value: Integer);
begin
  fMaxUsesInTotal := value
end;

procedure TPromoDTO.setMaxUsesPerCustomer(const Value: Integer);
begin
  fMaxUsesPerCustomer := value
end;

procedure TPromoDTO.setMinQuantity(const Value: variant);
begin
   fMinQuantity := value
end;

procedure TPromoDTO.setMinSubTotal(const Value: Double);
begin
  fMinSubTotal := value
end;

procedure TPromoDTO.setRewardAmount(const Value: Double);
begin

  if ( pos('Sale', fAmountType) > 0 ) then begin
     fRewardAmount := fSalePrice;
  end else if ( pos('Amount', fAmountType) > 0 ) then begin
     		fRewardAmount := value;
     		fSalePrice := 0;
  		end
  		else if ( (pos('Percent', fAmountType) > 0) and ( value > 0) ) then begin
     		fRewardAmount := value;
     		fSalePrice := 0;
  		end;

end;

procedure TPromoDTO.setRewardQuantity(const Value: variant);
begin
  fRewardQuantity := value
end;

procedure TPromoDTO.setStartDate(const Value: TDateTime);
begin
  fStartDate := value
end;

function TPromoDTO.getCouponNumber: String;
begin
  result := fCouponNumber
end;

procedure TPromoDTO.setCouponNumber(const Value: String);
begin
  fCouponNumber := value
end;

function TPromoDTO.getIDDiscUses: Integer;
begin
  Result := fIdDiscUses
end;

function TPromoDTO.getIDTagQualifyingDiscount: Integer;
begin
  result := fIDTagQualifyingDiscount
end;

procedure TPromoDTO.setDiscUses(const Value: Integer);
begin
  fIdDiscUses := value
end;

procedure TPromoDTO.setIDTagQualifyingDiscount(const Value: Integer);
begin
  fIDTagQualifyingDiscount := value
end;

function TPromoDTO.getIDTagRewards: Integer;
begin
  result := fIDTagRewards
end;

procedure TPromoDTO.setIDTagRewards(const Value: Integer);
begin
  fIDTagRewards := value
end;

function TPromoDTO.getCustomerGroup: Boolean;
begin
  result := fCustomerGroup;
end;

procedure TPromoDTO.setCustomerGroup(const Value: Boolean);
begin
  fCustomerGroup := value;
end;

constructor TPromoDTO.create;
begin
  fPurchaseTagList := TObjectList.Create();
  fRewardTagList := TObjectList.Create();
  fCustomerList := TObjectList.Create();
  fStoreList := TObjectList.Create();

  fDiscountValidOnDays := TStringList.Create();
  fDiscountCoupons := TStringList.create();




end;

procedure TPromoDTO.addCustomerGroupToList(arg_customGroup: TDiscountCustomerGroup);
begin
  fCustomerList.Add(arg_customGroup)
end;

procedure TPromoDTO.addPurchaseTagToList(arg_tag: TDiscountPurchase);
begin
//  showmessage(format('Purchase Tag Object values: Id = %d, name = %s', [arg_tag.fIDTag, arg_tag.fNameTag]));
  fPurchaseTagList.add(arg_tag)
end;

procedure TPromoDTO.addRewardTagToList(arg_tag: TDiscountReward);
begin
//  showmessage(format('Reward Tag Object values: Id = %d, name = %s', [arg_tag.fIDTag, arg_tag.fNameTag]));
  fRewardTagList.add(arg_tag)
end;

procedure TPromoDTO.addStoreToList(arg_store: TStoreRegistry);
begin
  fStoreList.Add(arg_store);
end;

function TPromoDTO.getCustomerGroupList: TObjectList;
begin
  result := fCustomerList;
end;

function TPromoDTO.getPurchaseTagList: TObjectList;
begin
  result := fPurchaseTagList
end;

function TPromoDTO.getRewardTagList: TObjectList;
begin
  result := fRewardTagList
end;

function TPromoDTO.getStoreList: TObjectList;
begin
  result := fStoreList
end;

function TPromoDTO.getDiscountName: String;
begin
  result := fDiscountName
end;

procedure TPromoDTO.setDiscountName(const Value: String);
begin
  fDiscountName := value;
end;

function TPromoDTO.getCouponDefined: Boolean;
begin
  result := fCouponDefined
end;

function TPromoDTO.getPurchaseTagDefined: Boolean;
begin
  result := fPurchaseTagDefined
end;

function TPromoDTO.getRewardTagDefined: Boolean;
begin
  result := fRewardTagDefined
end;

function TPromoDTO.getStoredDefined: Boolean;
begin
  result := fStoreDefined
end;

procedure TPromoDTO.setCouponDefined(const Value: Boolean);
begin
  fCouponDefined := value
end;

procedure TPromoDTO.setPurchaseTagDefined(const Value: Boolean);
begin
  fPurchaseTagDefined := value
end;

procedure TPromoDTO.setRewardTagDefined(const Value: Boolean);
begin
  fRewardTagDefined := value
end;

procedure TPromoDTO.setStoreDefined(const Value: Boolean);
begin
  fStoreDefined := value
end;

function TPromoDTO.getCustomerGroupDefined: Boolean;
begin
  result := fCustomerGroupDefined
end;

procedure TPromoDTO.setCustomerGroupDefined(const Value: Boolean);
begin
  fCustomerGroupDefined := value
end;

procedure TPromoDTO.addDiscountValidOnDayToList(arg_day: String);
begin
  fDiscountValidOnDays.Add(arg_day);
end;

destructor TPromoDTO.destroy;
begin
  freeAndNil(fpurchaseTagList);
  freeAndNil(fRewardTagList);
  freeAndNil(fCustomerList);
  freeAndNil(fStoreList);
  freeAndNil(fDiscountValidOnDays);
  inherited;
end;

procedure TPromoDTO.addCouponsToList(arg_coupon: String);
begin
  fDiscountCoupons.Add(arg_coupon);
end;

function TPromoDTO.getCouponsDiscount: TStringList;
begin
  result := fDiscountCoupons
end;

function TPromoDTO.getValidOnDaysDiscount: TStringList;
begin
  result := fDiscountValidOnDays;
end;

function TPromoDTO.getIDStore: Integer;
begin
  result := fIDStore
end;

procedure TPromoDTO.setIDStore(const Value: Integer);
begin
  fIDStore := value
end;

function TPromoDTO.getSalePrice: Double;
begin
   result := fSalePrice;
end;

procedure TPromoDTO.setSalePrice(const Value: Double);
begin
  fSalePrice := value;
end;

function TPromoDTO.getIsBogo: boolean;
begin
  result := fIsBogo;
end;

procedure TPromoDTO.setIsBogo(const value: boolean);
begin
  fIsBogo := value;   
end;

function TPromoDTO.getBuyAnd: boolean;
begin
  result := self.FBuyAnd;
end;

procedure TPromoDTO.setBuyAnd(const value: boolean);
begin
  self.FBuyAnd := value;
end;

{ TDiscountQualifying }

function TDiscountQualifying.getIDDiscount: Integer;
begin
  result := fIDDiscount
end;

procedure TDiscountQualifying.setIDDiscount(arg_id: Integer);
begin
  fIDDiscount := arg_id
end;

{ TDiscountCustomerGroup }

function TDiscountCustomerGroup.getIDTipoPessoa: Integer;
begin
  result := fIDTipoPessoa
end;

function TDiscountCustomerGroup.getIDTipoPessoaStr: String;
begin
  result := intToStr(fIdTipoPessoa);
end;

function TDiscountCustomerGroup.getName: String;
begin
  result := fName;
end;

procedure TDiscountCustomerGroup.setIDTipoPessoa(arg_id: Integer);
begin
  fIdTipoPessoa := arg_id
end;

procedure TDiscountCustomerGroup.setIDTipoPessoaStr(arg_id: String);
begin
  fIdTipoPessoa := strToInt(arg_id)
end;

procedure TDiscountCustomerGroup.setName(arg_name: String);
begin
  fName := arg_name;
end;

{ TDiscountPurchase }

function TDiscountPurchase.getIDTag: Integer;
begin
  result := fIDTag
end;

function TDiscountPurchase.getName: String;
begin
  result := fNameTag
end;

procedure TDiscountPurchase.setIDTag(arg_tag: Integer);
begin
  fIDTag := arg_tag;
end;

procedure TDiscountPurchase.setName(arg_name: String);
begin
  fNameTag := arg_name
end;

end.
