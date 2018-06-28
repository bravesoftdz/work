unit PromoItemClass;

interface
uses PromoItemInterface, PromoConfigClass, uSaleItem, contnrs, dbClient, SysUtils;

type
  TPromoItem = class(TInterfacedObject, IPromoItem)
  private
    fIdPresale: Integer;
    fIdMov: Integer;
    fIdPromo: Integer;
    fPromoType: Integer;
    fFlatPromo: Boolean;
    fIdPromoItem: Integer;
    fIdModel: Integer;
    fIdModelParent: Integer;
    fQuantity: Double;
    fQuantityXPromo: Double;
    fQuantityYPromo: Double;
    fDiscount: Double;
    fDiscountType: Integer;
    fSellingPrice: Double;
    fTotalQty: Double;
    fTotalDiscount: Double;
    fHighestDiscount: Double; // highest discount found to item.
    fCustomerDiscount: Double;
    function getSellingPrice(arg_IdModel: Integer; arg_sellingPrice: Double): Double; overload;
    function isPriceBreak(): Boolean;
    procedure createSubListOfItemsY(arg_promoConfigLines: TClientDataset);

  public
    fListModelY: TObjectList;
    constructor create(); overload;
    constructor create(arg_promoConfigLines: TClientDataset; arg_saleItem:TSaleItem; arg_customerDiscount: Double); overload;
    function getIdPresale(): Integer;
    function getDiscountType(): Integer;
    function getPromoType(): Integer;
    function getIdMov(): Integer;
    function getQuantity(): Double;
    function getIdPromo(): Integer;
    function getIdPromoItem(): Integer;
    function getIdModel(): Integer;
    function getIdModelParent(): Integer;
    function getQtyX(): Double;
    function getDiscount(): Double;
    function getSellingPrice(): Double; overload;
    function getFlatPromo(): Boolean;
    function getHighestDiscount(arg_discount: Double): Double; overload;
    function getHighestDiscount(): Double; overload;
    procedure addQuantityToToTal(arg_qty: Double);
    procedure addDiscount(arg_discount: Double);
    procedure setCustomerDiscount(arg_discount: Double);
    function getCustomerDiscount(): Double;

  end;

implementation

{ TPromoItem }

procedure TPromoItem.addDiscount(arg_discount: Double);
begin
  fTotalDiscount := fTotalDiscount + arg_discount;
end;

procedure TPromoItem.addQuantityToToTal(arg_qty: Double);
begin
  fTotalQty := fTotalQty + arg_qty;
end;

constructor TPromoItem.create(arg_promoConfigLines:TClientDataset; arg_saleItem:TSaleItem; arg_customerDiscount: Double);
begin
  fIdPresale := arg_saleItem.IDPreSale;
  fIdModel := arg_saleItem.IDModel;
  fQuantity := arg_saleItem.Qty;

  fIdPromo := arg_promoConfigLines.fieldByName('idPromo').value;
  fIdPromoItem := arg_promoConfigLines.fieldByName('idPromoItem').value;
  fQuantityXPromo := arg_promoConfigLines.fieldByName('qtyPromoItem').value;
  fDiscount := arg_promoConfigLines.fieldByName('discountValue').Value;
  fDiscountType := arg_promoConfigLines.fieldByName('discountType').value;
  fPromoType := arg_promoConfigLines.fieldByName('promoType').Value;
  fFlatPromo := arg_promoConfigLines.FieldByName('flatPromo').value;

  // todo -cPromoItemSubList -oAntonio: Creating createSubList
  if ( not fFlatPromo ) then begin
     createSubListOfItemsY(arg_promoConfigLines);
  end;


  fCustomerDiscount := arg_customerDiscount;
end;

function TPromoItem.getCustomerDiscount: Double;
begin
  result := fCustomerDiscount;
end;

function TPromoItem.getDiscount: Double;
begin
  result := fDiscount;
end;

function TPromoItem.getDiscountType: Integer;
begin
  result := fDiscountType;
end;

function TPromoItem.getFlatPromo: Boolean;
begin
  result := fFlatPromo;
end;

function TPromoItem.getHighestDiscount(arg_discount: Double): Double;
begin
  if ( arg_discount > fHighestDiscount ) then
     fHighestDiscount := arg_discount;

  addDiscount(fHighestDiscount);

  result := fHighestDiscount;
end;

function TPromoItem.getHighestDiscount: Double;
begin
  result := fHighestDiscount;
end;

function TPromoItem.getIdModel: Integer;
begin
  result := fIdModel;
end;

function TPromoItem.getIdModelParent: Integer;
begin
  Result := fIdModelParent;
end;

function TPromoItem.getIdMov: Integer;
begin
  result := fIdMov;
end;

function TPromoItem.getIdPresale: Integer;
begin
  result := fIdPresale;
end;

function TPromoItem.getIdPromo: Integer;
begin
  result := fIdPromo;
end;

function TPromoItem.getIdPromoItem: Integer;
begin
  result := fIdPromoItem
end;

function TPromoItem.getPromoType: Integer;
begin
  result := fPromoType;
end;

function TPromoItem.getQuantity: Double;
begin
  result := fQuantity;
end;

function TPromoItem.getQtyX: Double;
begin
  result := fQuantityXPromo;
end;

function TPromoItem.getSellingPrice(arg_IdModel: Integer; arg_sellingPrice: Double): Double;
begin
  if isPriceBreak() then begin
    result := 0
  end
  else
    result := arg_sellingPrice;

 fSellingPrice := result;
end;

function TPromoItem.getSellingPrice: Double;
begin
  result := fSellingPrice;
end;

function TPromoItem.isPriceBreak(): Boolean;
begin
  result := false // to be implemented.
end;

procedure TPromoItem.setCustomerDiscount(arg_discount: Double);
begin
  fCustomerDiscount := fSellingPrice * ( arg_discount / 100);
end;

constructor TPromoItem.create;
begin
//
end;

procedure TPromoItem.createSubListOfItemsY(arg_promoConfigLines: TClientDataset);
var
  subList: TClientDataset;
begin
  try
     subList := TClientDataset.create(nil);
     sublist := arg_promoConfigLines;

     sublist.First;
     sublist.Filter := format('idPromo = %d and idModel = %d', [fIdPromo, fIdModel]);
     sublist.Filtered := true;

     while ( not subList.Eof ) do begin
        self.create();
        self.fIdPromo := subList.fieldByName('idPromo').Value;
        self.fPromoType := subList.fieldByName('promoType').Value;
        self.fIdPromoItem := subList.fieldByName('idPromoItem').Value;
        self.fIdModelParent := subList.fieldByName('idModel').Value;
        self.fIdModel := sublist.fieldByName('prizeIdModel').Value;
        fListModelY.Add(self);
        sublist.Next;
     end;

  finally

  end;
end;

end.
