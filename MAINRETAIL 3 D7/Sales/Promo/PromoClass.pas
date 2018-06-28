unit PromoClass;

interface
uses PromoDiscountInterface, dbClient, uSystemConst, PromoConfigClass, udm, PromoItemClass, contnrs,
     PromoDiscountFactoryClass;

type
  TPromo = class
  private
     fPromoDiscountFactory: TPromoDiscountFactory;
     fFlatPromo: Boolean;
  protected
     fdiscount: IPromoDiscount;
     fPromoConfig: TPromoConfig;
     fDatePromo: TDateTime;
     procedure setPromoDiscount(arg_promoDiscount: IPromoDiscount);
     procedure addQuantity(arg_promoItem: TPromoItem);
  public
     ItemsPromoXList: TObjectList;
     constructor create(arg_item: TPromoItem);
     procedure setFlatPromo(arg_flat: Boolean);
     function getFlatPromo(): Boolean;
     function getPromoDiscount(arg_item: TPromoItem): Double; virtual; abstract;
  end;

implementation

{ TPromo }

constructor TPromo.create(arg_item: TPromoItem);
begin
 fPromoDiscountFactory := TPromoDiscountFactory.Create();
 fdiscount := fPromoDiscountFactory.createPromoDiscount(arg_item);
 itemsPromoXList := TObjectList.Create(true);
end;

function TPromo.getFlatPromo: Boolean;
begin
  result := fFlatPromo;
end;

procedure TPromo.setFlatPromo(arg_flat: Boolean);
begin
  fFlatPromo := arg_flat;
end;

procedure TPromo.setPromoDiscount(arg_promoDiscount: IPromoDiscount);
begin
  fdiscount := arg_promoDiscount;
end;

procedure TPromo.addQuantity(arg_promoItem: TPromoItem);
var
  i: Integer;
  itemPromo: TPromoItem;
begin
  for i:= ItemsPromoXList.Count - 1 to 0 do begin
     itemPromo := TPromoItem(itemsPromoXlist.Items[i]);
     if ( itemPromo.getIdModel = arg_promoItem.getIdModel ) then begin
        arg_promoItem.addQuantityToToTal(arg_promoItem.getQuantity);
        break;
     end;
  end;
end;

end.
