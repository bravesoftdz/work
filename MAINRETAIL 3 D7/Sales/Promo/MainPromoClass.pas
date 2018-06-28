unit MainPromoClass;

interface
uses PromoConfigClass, dbClient, uSaleItem, PromoClass, PromoSaleClass, PromoFactoryClass, PromoItemClass, uSystemConst;

type
   TMainPromo = class
   private
      fSaleItem: TSaleItem;
      promoItem: TPromoItem;
      promoFactory: TPromoFactory;
      promo: TPromo;
      fCoupon: String;
      fIsLoyalty: Boolean;
      fSubtotalSale: Double;
      fDiscountValue: Double;
      procedure performPromo(arg_promoLine: TClientDataset; arg_item: TPromoItem);
      procedure insertPromoInCashRegisger();
   public
      procedure setSaleItem(arg_saleItem: TSaleItem);
      procedure setCoupon(arg_coupon: String);
      procedure setIsLoyalty(arg_isLoyalty: Boolean);
      procedure setSubtotal(arg_subtotal: Double);
      procedure start();
      function getDiscount(): Double;
   end;

implementation
uses uDM;

{ TMainPromo }
function TMainPromo.getDiscount: Double;
begin
  result := fDiscountValue;
end;

procedure TMainPromo.insertPromoInCashRegisger;
var
   i, j: Integer;
   promoItemInList: TPromoItem;
begin
   // X items
   for i:= 0 to promo.ItemsPromoXList.Count - 1 do begin
      promoItemInList := TPromoItem(promo.itemsPromoXList.items[i]);
      // deleta os itens da caixa
      // insere itens da promo
      
      // Y items
      for J := 0 to promoItemInList.fListModelY.Count - 1 do begin
          // deleta os itens da caixa
          // insere os itens da promo

      end;

   end;
end;

procedure TMainPromo.performPromo(arg_promoLine: TClientDataset; arg_item: TPromoItem);
begin
   promo := promoFactory.createPromo(arg_item);

   // final result of discount to promo
   fDiscountValue := promo.getPromoDiscount(arg_item);
end;

procedure TMainPromo.setCoupon(arg_coupon: String);
begin
  fCoupon := arg_coupon;
end;

procedure TMainPromo.setIsLoyalty(arg_isLoyalty: Boolean);
begin
  fIsLoyalty := arg_isLoyalty;
end;

procedure TMainPromo.setSaleItem(arg_saleItem: TSaleItem);
begin
  fSaleItem := arg_saleItem
end;

procedure TMainPromo.setSubtotal(arg_subtotal: Double);
begin
  fSubtotalSale := arg_subtotal;
end;

procedure TMainPromo.start;
var
  promoConfig: TPromoConfig;
  promoConfigLines: TClientDataset;
  customerDiscount: Double;
begin
  // Settings to Promotions
  promoConfig := TPromoConfig.getPromoConfigSingleton;
  promoConfigLines := promoConfig.loadValidPromos(fSaleItem.PreSaleDate);

  // settings to Customer discount
  customerDiscount := dm.getCustomerDiscount(fsaleItem.IDCustomer);
  

  while ( not promoConfigLines.Eof ) do begin

     // idmodel was found in promolist
     if ( fSaleItem.IDModel = promoConfigLines.fieldByName('idmodel').AsInteger ) then begin
         promoItem := TPromoItem.create(promoConfigLines, fSaleItem, customerDiscount);


         case ( promoConfigLines.FieldByName('promoType').asInteger ) of
            PROMO_COUPON_TYPE: performPromo(promoConfigLines, promoItem);
            PROMO_FREQBUYER_TYPE: performPromo(promoConfigLines, promoItem);
            PROMO_LOYALTY_TYPE: performPromo(promoConfigLines, promoItem);
            PROMO_SALE_TYPE: performPromo(promoConfigLines, promoItem);
         end;

     end;

     promoConfigLines.Next;

  end;

end;

end.
