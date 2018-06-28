unit PromoConfigClass;

interface
uses classes, sysUtils, dbClient, DB, uSystemConst;

type
  TPromoConfig = class
  private
     fPromoMatrix: TClientDataset;
     fPromoStackMatrix: TClientDataset;
     fValidPromos: TClientDataset;

     procedure createPromoMatrix();
     procedure loadPromoMatrix();
     procedure createPromoStackMatrix();
     procedure loadPromoStackMatrix();
     constructor create();
  public
     class function getPromoConfigSingleton(): TPromoConfig;
     function loadValidPromos(arg_datePromo: TDateTime): TClientDataset;

  end;

implementation
uses uDM;

{ TPromoConfig }

constructor TPromoConfig.Create();
begin
  createPromoMatrix();
  createPromoStackMatrix();

end;

procedure TPromoConfig.createPromoMatrix();
begin
  try
    fPromoMatrix := TClientDataset.Create(nil);
    fPromoMatrix.FieldDefs.add('promoType', ftInteger, 0, true);
    fpromoMatrix.fieldDefs.add('discountPercent', ftBoolean, 0, true);
    fpromoMatrix.fieldDefs.add('discountAmount', ftBoolean, 0, true);
    fpromoMatrix.fieldDefs.add('discountQuantity', ftBoolean, 0 , true);
    fpromoMatrix.FieldDefs.add('discountSale', ftBoolean, 0, true);
    fPromoMatrix.CreateDataSet;
    loadPromoMatrix();
  except
    on E: Exception do begin
      raise Exception.Create('Cannot create matrix of discounts ' + e.message);
    end;
  end;
end;

procedure TPromoConfig.createPromoStackMatrix();
begin
  try
    fPromoStackMatrix := TClientDataset.Create(nil);
    fPromoStackMatrix.FieldDefs.add('promoType', ftInteger, 0, true);
    fPromoStackMatrix.fieldDefs.add('discountPercent', ftBoolean, 0, true);
    fPromoStackMatrix.fieldDefs.add('discountAmount', ftBoolean, 0, true);
    fPromoStackMatrix.fieldDefs.add('discountQuantity', ftBoolean, 0 , true);
    fPromoStackMatrix.FieldDefs.add('discountSale', ftBoolean, 0, true);
    fPromoStackMatrix.CreateDataSet;
    loadPromoStackMatrix();
  except
    on E: Exception do begin
      raise Exception.Create('Cannot create matrix of discounts ' + e.message);
    end;
  end;
end;

class function TPromoConfig.getPromoConfigSingleton: TPromoConfig;
begin
  if (self = nil ) then
     result := TPromoConfig.create()
  else
     result := TPromoConfig(self);
end;

procedure TPromoConfig.loadPromoMatrix();
var
  i: Integer;
begin
  i := 1;
  while ( i < 4 ) do begin
    fPromoMatrix.Insert;
    case i of
      1: begin
        fPromoMatrix.FieldByName('promoType').Value := PROMO_SALE_TYPE;
        fPromoMatrix.fieldByName('discountPercent').value := true;
        fPromoMatrix.fieldByName('discountAmount').value := true;
        fPromoMatrix.fieldByName('discountQuantity').value := true;
        fPromoMatrix.fieldByName('discountSale').value := true;
        fPromoMatrix.Post;
      end;

      2: begin
        fPromoMatrix.FieldByName('promoType').Value := PROMO_FREQBUYER_TYPE;
        fPromoMatrix.fieldByName('discountPercent').value := false;
        fPromoMatrix.fieldByName('discountAmount').value := false;
        fPromoMatrix.fieldByName('discountQuantity').value := true;
        fPromoMatrix.fieldByName('discountSale').value := false;
        fPromoMatrix.Post;
      end;

      3: begin
        fPromoMatrix.FieldByName('promoType').Value := PROMO_COUPON_TYPE;
        fPromoMatrix.fieldByName('discountPercent').value := true;
        fPromoMatrix.fieldByName('discountAmount').value := true;
        fPromoMatrix.fieldByName('discountQuantity').value := true;
        fPromoMatrix.fieldByName('discountSale').value := true;
        fPromoMatrix.Post;
      end;

      4: begin
        fPromoMatrix.FieldByName('promoType').Value := PROMO_LOYALTY_TYPE;
        fPromoMatrix.fieldByName('discountPercent').value := true;
        fPromoMatrix.fieldByName('discountAmount').value := true;
        fPromoMatrix.fieldByName('discountQuantity').value := true;
        fPromoMatrix.fieldByName('discountSale').value := true;
        fPromoMatrix.Post;
      end;

    end;
    inc(i);
  end;
end;

procedure TPromoConfig.loadPromoStackMatrix();
var
  i: Integer;
begin
  i := 1;
  while ( i < 4 ) do begin
    fPromoMatrix.Insert;
    case i of
      1: begin
        fPromoStackMatrix.FieldByName('promoType').Value := PROMO_SALE_TYPE;
        fPromoStackMatrix.fieldByName('discountPercent').value := false;
        fPromoStackMatrix.fieldByName('discountAmount').value := false;
        fPromoStackMatrix.fieldByName('discountQuantity').value := false;
        fPromoStackMatrix.fieldByName('discountSale').value := true;
        fPromoStackMatrix.Post;
      end;

      2: begin
        fPromoStackMatrix.FieldByName('promoType').Value := PROMO_FREQBUYER_TYPE;
        fPromoStackMatrix.fieldByName('discountPercent').value := false;
        fPromoStackMatrix.fieldByName('discountAmount').value := false;
        fPromoStackMatrix.fieldByName('discountQuantity').value := true;
        fPromoStackMatrix.fieldByName('discountSale').value := false;
        fPromoStackMatrix.Post;
      end;

      3: begin
        fPromoStackMatrix.FieldByName('promoType').Value := PROMO_COUPON_TYPE;
        fPromoStackMatrix.fieldByName('discountPercent').value := true;
        fPromoStackMatrix.fieldByName('discountAmount').value := true;
        fPromoStackMatrix.fieldByName('discountQuantity').value := true;
        fPromoStackMatrix.fieldByName('discountSale').value := true;
        fPromoStackMatrix.Post;
      end;

      4: begin
        fPromoStackMatrix.FieldByName('promoType').Value := PROMO_LOYALTY_TYPE;
        fPromoStackMatrix.fieldByName('discountPercent').value := false;
        fPromoStackMatrix.fieldByName('discountAmount').value := false;
        fPromoStackMatrix.fieldByName('discountQuantity').value := false;
        fPromoStackMatrix.fieldByName('discountSale').value := true;
        fPromoStackMatrix.Post;
      end;

    end;
    inc(i);
  end;
end;

function TPromoConfig.loadValidPromos(arg_datePromo: TDateTime): TClientDataset;
begin
  fValidPromos := dm.getPromoSettingsOnDate(arg_datePromo);
  result := fValidPromos;
end;


end.
