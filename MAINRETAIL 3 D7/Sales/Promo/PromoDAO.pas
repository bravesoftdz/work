unit PromoDAO;

interface
uses
  ADODb, PromoDTO, db, SysUtils, Classes, contnrs, variants, DateUtils, dialogs, CouponCls;

type
  TPromoDAO = class
  private
    fConnection: TADOConnection;
    stores: TObjectList;

    function convertPercentRewardValue(arg_amountType: String; arg_value: double): double;
    function revertPercentRewardValue(arg_amountType: String; arg_value: double): double;
    function deleteValidOnDays(arg_iddiscount: Integer): boolean;

  public
    procedure setConnection(arg_conn: TADOConnection);
    procedure savePromo(arg_promoDTO: TPromoDTO);
    procedure removePromo(arg_idDiscount: Integer);
    procedure saveValidOnDays(arg_promoDTO: TPromoDTO);
    procedure saveCouponDiscount(arg_promoDTO: TPromoDTO);
    procedure saveStoreDiscount(arg_promoDTO: TPromoDTO);
    procedure saveTagDiscount(arg_promoDTO: TPromoDTO);
    procedure saveUsesDiscount(arg_promoDTO: TPromoDTO);
    procedure saveRewardsDiscount(arg_promoDTO: TPromoDTO);
    procedure saveCustomerGroupDiscount(arg_promoDTO: TPromoDTO);

    function getOnePromo(arg_idDiscount: Integer): TPromoDTO;
    function getValidOnDays(arg_idDiscount: Integer): TStringList;
    function getPurchaseTags(): TObjectList;
    function getRewardTags(idDiscount: integer): TObjectList;
    function getCustomerGroups(): TObjectList;

    function getCoupons(arg_idDiscount: Integer): TStringList;
    function getPurchaseTagsDiscount(arg_idDiscount: Integer): TObjectList;
    function getRewardTagsDiscount(arg_idDiscount: Integer): TObjectList;
    function getCustomerGroupsDiscount(arg_idDiscount: Integer): TObjectList;
    function getCouponsDiscount(arg_idDiscount: Integer): TStringList;
    function getStoreGroupDiscount(arg_idDiscount: Integer): TObjectList;
    function IsModelInCurrentPromoCoupon(idModel: integer): TObjectList;

    // Coupon
    function GetCurrentCouponPromo(couponCode: string = ''; idPromo: integer = 0): TObjectList;
    function GetCoupon(select: TDataset): TCoupon;
    procedure SaveCouponOnSaleToApplyCouponDiscount(coupon: TCoupon);
  end;

  var
      purchaseTagList: TObjectList;
      rewardTagList: TObjectList;

implementation
uses
  StoreCls;


{ TPromoDAO }


function TPromoDAO.convertPercentRewardValue(arg_amountType: String;  arg_value: double): double;
begin
   result := arg_value;
   if ( pos('Percent', arg_amountType) > 0 ) then begin
      result := arg_value * 0.01;
   end;
end;

function TPromoDAO.deleteValidOnDays(arg_iddiscount: Integer): boolean;
var
  delete: TADOQuery;
begin
  try
    try
      delete := TADOQuery.Create(nil);
      delete.Connection := fConnection;
      delete.SQL.Add('delete from DiscValidOnDays');
      delete.SQL.add(' where IDDIScount = :param_idDiscount');

      delete.Parameters.ParamByName('param_idDiscount').Value := arg_idDiscount;
      delete.ExecSQL;

    except
       on e: Exception do begin
          raise Exception.create('Cannot delete DiscValidOnDays: ' + e.Message);

       end;
    end;
  finally
    freeAndNil(delete);
  end;
end;

function TPromoDAO.getCoupons(arg_idDiscount: Integer): TStringList;
var
  select: TADOQuery;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select * from DiscCoupons');
      select.SQL.add(' where IDDIScount = :param_idDiscount');

      select.Parameters.ParamByName('param_idDiscount').Value := arg_idDiscount;

      select.open();

      result := TStringList.create();

      while ( not select.Eof ) do begin
         result.Add(select.fieldByName('code').Value);
         select.Next();
      end;

    except

    end;
  finally
    freeAndNil(select);
  end;
end;

function TPromoDAO.getCouponsDiscount(arg_idDiscount: Integer): TStringList;
begin
  result := getCoupons(arg_idDiscount);
end;

function TPromoDAO.GetCurrentCouponPromo(couponCode: string = ''; idPromo: integer = 0): TObjectList;
var select: TADOQuery;
    coupon: TCoupon;
begin
  try
      try
          select := TADOQuery.Create(nil);
          select.Connection := fConnection;
          select.sql.add('select distinct d.IdDiscount, d.DiscountName, D.DiscType, D.AmountType, D.RewardAmount, tm.IdModel ');
          select.sql.add(', m.Model, m.Description, d.CashierShouldWarn, dc.Code, m.SellingPrice');
          select.sql.add(' from Discounts d');
          select.sql.add(' join DiscQualifyingTags t on d.IDDiscount = t.IdDiscount');
          select.sql.add(' join TagModel tm on tm.IdTag = t.IdTag');
          select.sql.add(' join Model m on m.IdModel = tm.IdModel');
          select.sql.add(' join DiscValidOnDays pd on d.IDDiscount = pd.IDDiscount ');
          select.sql.add(' join DiscCoupons dc on d.IdDiscount = dc.IdDiscount ');
          select.sql.add('where tm.Active = 1 ');
          select.sql.add(' and (d.StartOn <= GetDate() and (d.EndOn >= Cast(GetDate() as Date)))');
          select.sql.add(' and d.DiscType like :param_DiscType ');
          //select.sql.add(' and convert(nvarchar(max), d.DiscType) = N :prm_DiscType ');

          select.Parameters.ParamByName('param_DiscType').Value := 'Coupon';

          if ( idPromo > 0 ) then begin
             select.sql.add( ' and d.IdDiscount = :param_IdDiscount ');
             select.Parameters.ParamByName('param_IdDiscount').Value := idPromo;
          end;

          if ( Length(Trim(couponCode)) > 0 ) then begin
             select.sql.add( ' and dc.Code like :param_coupon ');
             select.Parameters.ParamByName('param_coupon').Value := couponCode;
          end;

          select.open();
          result := TObjectList.Create(true);
          while ( not select.Eof ) do begin
              result.Add(GetCoupon(select));
              select.Next;
          end;

      except
          on e: Exception do begin
              raise e.Create('Cannot retrieve details from the current promo '+ e.Message);
          end
      end;
  finally
      freeAndNil(select);
  end;
end;

function TPromoDAO.getCustomerGroups: TObjectList;
var
  select: TADOQuery;
  customerGroup: TDiscountCustomerGroup;
  customerGroupList: TObjectList;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select tp.IDTipoPessoa, tp.TipoPessoa');
      select.SQL.add(' from TipoPessoa tp');

      select.open();

      customerGroupList := TObjectList.create();

      while ( not select.Eof ) do begin
         customerGroup := TDiscountCustomerGroup.Create();
         customerGroup.setIDTipoPessoa(select.fieldByName('IDTipoPessoa').Value);
         customerGroup.setName(select.fieldByName('TipoPessoa').Value);
         customerGroupList.add(customerGroup);
         select.Next();
      end;
      result := customerGroupList;
    except
      freeAndNil(select);
    end;
  finally

  end;
end;

function TPromoDAO.getCustomerGroupsDiscount(arg_idDiscount: Integer): TObjectList;
var
  select: TADOQuery;
  customerGroup: TDiscountCustomerGroup;
  customerGroupList: TObjectList;
begin
  try
    try

      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select cg.IDTipoPessoa, tp.TipoPessoa');
      select.SQL.add(' from DiscAllowedCustGroups cg');
      select.sql.Add('      left join TipoPessoa tp on cg.IDTipoPessoa = tp.IDTipoPessoa');
      select.SQL.add(' where IDDiscount = :param_idDiscount');
      select.Parameters.ParamByName('param_idDiscount').Value := arg_idDiscount;

      select.open();

      customerGroupList := TObjectList.create();

      while ( not select.Eof ) do begin
         customerGroup := TDiscountCustomerGroup.Create();
         customerGroup.setIDTipoPessoa(select.fieldByName('IDTipoPessoa').Value);
         customerGroupList.add(customerGroup);
         select.Next();
      end;
      result := customerGroupList;
    except
      freeAndNil(select);
    end;
  finally

  end;
end;

function TPromoDAO.getOnePromo(arg_idDiscount: Integer): TPromoDTO;
var
  select: TADOQuery;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select * from Discounts');
      select.sql.add(' where IdDiscount = :param_iddiscount');
      select.Parameters.ParamByName('param_iddiscount').Value := arg_idDiscount;
      select.open();

      result := TPromoDTO.create();

      result.DiscountName := select.fieldByName('DiscountName').Value;
      result.DiscountType := select.fieldByName('DiscType').Value;
      result.AmountType := select.fieldByName('AmountType').Value;

      if ( not select.fieldByName('MinQuantity').IsNull ) then begin
         result.MinQuantity := select.fieldByName('MinQuantity').value;
      end;

      if ( not select.fieldbyname('MaxUsesInTotal').isnull ) then begin
         result.MaxUsesInTotal := select.fieldByName('MaxUsesInTotal').value;
      end;

      if ( not select.fieldbyname('MinSubTotal').isnull ) then begin
         result.MaxUsesInTotal := select.fieldByName('MinSubTotal').value;
      end;

      if ( not select.fieldbyname('FirstTimeCustomerOnly').isnull ) then begin
         result.MaxUsesInTotal := select.fieldByName('FirstTimeCustomerOnly').value;
      end;

      if ( not select.fieldbyname('MaxUsesPerCustomer').isnull ) then begin
         result.MaxUsesInTotal := select.fieldByName('MaxUsesPerCustomer').value;
      end;

      result.RewardAmount := select.fieldByName('RewardAmount').value;


      if ( not select.fieldByName('RewardQuantity').IsNull ) then begin
         result.RewardQuantity := select.fieldByName('RewardQuantity').value;
      end;

      // revert reward amount if amount type is "Percent"
      result.RewardAmount := revertPercentRewardValue(select.fieldByName('AmountType').Value, select.fieldByName('RewardAmount').value);

      result.StartDate := VarToDateTime(select.fieldByName('StartOn').value);
      result.EndDate := varToDateTime(select.fieldByName('EndOn').value);
      result.BeginTimeOfDay := TimeOf(StrToTime(select.fieldByName('BeginTimeOfDay').value));
      result.EndTimeOfDay := TimeOf(strToTime(select.fieldByName('EndTimeOfDay').value));
      result.CustomerCardRequired := select.fieldByName('CustomerCardRequired').value;
      result.MinDollarAmount := select.fieldByName('MinDollarAmount').value;
      result.IsStackable := select.fieldByName('IsStackable').value;

      if ( not select.fieldByname('IsBogo').IsNull ) then begin
         result.IsBogo := select.fieldByName('IsBogo').Value;
      end else begin
             result.isBogo := false;
          end;

      if ( not select.fieldByName('BuyAnd').isNull ) then begin
         result.BuyAnd := select.fieldByName('BuyAnd').Value;
      end else begin
             result.BuyAnd := false;
          end;

      if ( not select.fieldByName('CashierShouldWarn').isNull ) then begin
         result.CashierShouldWarn := select.fieldByName('CashierShouldWarn').Value;
      end else begin
             result.CashierShouldWarn := false;
          end;

    except
      on e: exception do begin
         raise exception.Create(format('can not get Discounts: %s', [e.Message]));
      end;

    end;
  finally
    freeAndNil(select);
  end;
end;

function TPromoDAO.getPurchaseTags: TObjectList;
var
  select: TADOQuery;
  purchaseTag: TDiscountPurchase;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select distinct t.IDTag, t.tagName, tm.Active from Tag t ');
      select.SQL.add('join TagModel tm on t.idtag = tm.idTag ');
      select.SQL.add('where tm.active = 1 ');
      select.SQL.add('and t.IdTag not in ( select IdTag from DiscQualifyingTags ) ');
      select.SQL.Add('order by t.IdTag');

      select.Open();

      result := TObjectList.Create();

      while ( not select.Eof ) do begin
         purchaseTag := TDiscountPurchase.Create();
         purchaseTag.setIDTag(0);
         purchaseTag.setIDTag(select.fieldByName('idTag').Value);
         purchaseTag.setName(select.fieldByName('tagName').Value);
         result.add(purchaseTag);
         select.Next();
      end;

    except

    end;
  finally
    freeAndNil(select);
  end;
end;

function TPromoDAO.getPurchaseTagsDiscount(arg_idDiscount: Integer): TObjectList;
var
  select: TADOQuery;
  purchaseTag: TDiscountPurchase;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select dq.IDTag, t.TagName');
      select.SQL.add(' from DiscQualifyingTags dq');
      select.sql.Add('      join Tag t on dq.IDTag = t.IDTag');
      select.SQL.Add( ' where dq.IdDiscount = :param_iddiscount');
      select.Parameters.ParamByName('param_iddiscount').Value := arg_idDiscount;

      select.open();

      result := TObjectList.Create();

      while ( not select.Eof ) do begin
         purchaseTag := TDiscountPurchase.Create();
         purchaseTag.setIDTag(select.fieldByName('idTag').Value);
         purchaseTag.setName(select.fieldByName('tagName').Value);
         result.add(purchaseTag);
         select.Next();
      end;


    except
      freeAndNil(select);
    end;
  finally

  end;
end;

function TPromoDAO.getRewardTags(idDiscount: integer): TObjectList;
var
  select: TADOQuery;
  rewardTag: TDiscountReward;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select distinct t.IDTag, t.tagName, tm.Active from Tag t ');
      select.SQL.add('join TagModel tm on t.idtag = tm.idTag ');
      select.SQL.add('where tm.active = 1 ');
      select.SQL.add('  and t.IdTag not in ( select IdTag from DiscRewardTags drt ');
      select.SQL.add('                      union ');
      select.SQL.add('                      select IdTag from DiscQualifyingTags dqt )');
//      select.Parameters.ParamByName('prm_idDiscount').Value := idDiscount;

      select.Open();

      result := TObjectList.Create();

      while ( not select.Eof ) do begin

         rewardTag := TDiscountReward.Create();
         rewardTag.setIDTag(select.fieldByName('idTag').Value);
         rewardTag.setName(select.fieldByName('tagName').Value);
         result.add(rewardTag);
         select.Next();
      end;

    except

    end;
  finally
    freeAndNil(select);
  end;
//  result := //getPurchaseTags; old approach
end;

function TPromoDAO.getRewardTagsDiscount(arg_idDiscount: Integer): TObjectList;
var
  select: TADOQuery;
  rewardtag: TDiscountReward;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select dr.IDTag, t.TagName');
      select.SQL.add(' from DiscRewardTags dr');
      select.sql.Add('      join Tag t on dr.IDTag = t.IDTag');
      select.SQL.Add( ' where dr.IdDiscount = :param_iddiscount');
      select.Parameters.ParamByName('param_iddiscount').Value := arg_idDiscount;

      select.open();

      result := TObjectList.Create();

      while ( not select.Eof ) do begin
         rewardtag := TDiscountReward.Create();
         rewardtag.setIDTag(select.fieldByName('idTag').Value);
         rewardtag.setName(select.fieldByName('tagName').Value);
         result.add(rewardtag);
         select.Next();
      end;


    except
      freeAndNil(select);
    end;
  finally

  end;
end;

function TPromoDAO.getStoreGroupDiscount(arg_idDiscount: Integer): TObjectList;
var
  select: TADOQuery;
  store: TStoreRegistry;
  storeDiscountList: TObjectList;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select s.IDStore, s.name');
      select.SQL.add(' from Store s');
      select.sql.Add(' join DiscStores ds on ds.IDStore = s.IDStore');
      select.sql.add(' where ds.IdDiscount = :param_idDiscount');
      select.Parameters.ParamByName('param_idDiscount').value := arg_idDiscount;

      select.open();

      storeDiscountList := TObjectList.Create();

      while ( not select.Eof ) do begin
         store := TStoreRegistry.Create();
         store.IdStore := select.fieldByName('IDStore').Value;
         store.Name := select.fieldByName('Name').Value;
         storeDiscountList.add(store);
         select.Next();
      end;

      result := storeDiscountList;

    except
      freeAndNil(select);
    end;
  finally

  end;
end;

function TPromoDAO.getValidOnDays(arg_idDiscount: Integer): TStringList;
var
  select: TADOQuery;
  i: Integer;
begin
  try
    try
      select := TADOQuery.Create(nil);
      select.Connection := fConnection;
      select.SQL.Add('select * from DiscValidOnDays');
      select.sql.add(' where IdDiscount = :param_idDiscount');

      select.Parameters.ParamByName('param_idDiscount').Value := arg_idDiscount;

      select.open();

      result := TStringList.Create();
      while ( not select.Eof ) do begin
         result.add(select.fieldByName('DayOfWeek').value);
         select.Next();
      end;

    except

    end;
  finally
    freeAndNil(select);
  end;
end;

function TPromoDAO.IsModelInCurrentPromoCoupon(idModel: integer): TObjectList;
var select: TADOQuery;
begin
  try
      try
          select := TADOQuery.Create(nil);
          select.Connection := fConnection;
          select.sql.add('select d.IdDiscount, d.DiscountName, D.DiscType, D.AmountType, D.RewardAmount, tm.IdModel, m.Model, m.Description');
          select.sql.add(' from Discounts d');
          select.sql.add(' join DiscQualifyingTags t on d.IDDiscount = t.IdDiscount');
          select.sql.add(' join TagModel tm on tm.IdTag = t.IdTag');
          select.sql.add(' join Model m on m.IdModel = tm.IdModel');
          select.sql.add(' join DiscValidOnDays pd on d.IDDiscount = pd.IDDiscount ');
          select.sql.add('where (d.EndOn is null) or (d.EndOn >= :param_EndOn)');
          select.sql.add(' and tm.Active = 1 ');
          select.sql.add(' and d.DiscType = :param_DiscType');

      except
          on e: Exception do begin

          end
      end;
  finally
      freeAndNil(select);
  end;

end;

procedure TPromoDAO.removePromo(arg_idDiscount: Integer);
var
  sp: TADOStoredProc;
begin
  try
     try
        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;
        sp.ProcedureName := 'sp_Discounts_Delete';
        sp.Parameters.Refresh();

        sp.Parameters.ParamByName('@IDDiscount').value := arg_idDiscount;
        sp.ExecProc();

     except
        on e: Exception do begin
          raise;
        end;
     end;
  finally
     freeAndNil(sp);
  end;
end;

function TPromoDAO.revertPercentRewardValue(arg_amountType: String;
  arg_value: double): double;
begin
   result := arg_value;
   if ( pos('Percent', arg_amountType) > 0 ) then begin
      result := arg_value * 100;
   end;
end;

function TPromoDAO.GetCoupon(select: TDataset): TCoupon;
var
  coupon: TCoupon;
begin
    coupon := TCoupon.create;
    coupon.IDPromo := select.fieldByName('IdDiscount').Value;
    coupon.RewardAmount := select.fieldByName('RewardAmount').Value;
    coupon.AmountType := select.fieldByName('AmountType').Value;
    coupon.CashierShouldWarn := select.FieldByName('CashierShouldWarn').Value;
    coupon.NeedsPhysicalCoupon := true; // needs to create that new field on the database
    coupon.CouponCode := select.fieldByName('Code').Value;
    coupon.IdModel := select.fieldByName('IdModel').Value;
    coupon.SellingPrice := select.fieldByName('SellingPrice').Value;
    result := coupon;
end;

procedure TPromoDAO.saveCouponDiscount(arg_promoDTO: TPromoDTO);
var
  sp: TADOStoredProc;
  couponList: TStringList;
  i: Integer;
begin
  try
     try
        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;
        sp.ProcedureName := 'sp_DiscCoupons_Upsert';
        sp.Parameters.Refresh();

        sp.Parameters.ParamByName('@IDDiscount').value := arg_promoDTO.IDDiscount;

        couponList := arg_promoDTO.getCouponsDiscount();

        for i:= 0 to couponList.Count - 1 do begin
           sp.Parameters.ParamByName('@Code').Value := couponList.Strings[i];
           sp.ExecProc();
        end;

     except
        on e: Exception do begin
          raise;
        end;
     end;
  finally
     freeAndNil(sp);
     freeAndNil(couponList);
  end;
end;

procedure TPromoDAO.saveCustomerGroupDiscount(arg_promoDTO: TPromoDTO);
var
  delete: TADOQuery;
  sp: TADOStoredProc;
  customerGroupList: TObjectList;
  i: Integer;
begin
  try
     try
        delete := TADOQuery.Create(nil);
        delete.Connection := fConnection;
        delete.SQL.add('delete from DiscAllowedCustGroups ');
        delete.sql.Add('where idDiscount = :param_idDiscount');
        delete.Parameters.ParamByName('param_idDiscount').Value := arg_promoDTO.IDDiscount;
        delete.ExecSQL();

        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;
        sp.Name := 'sp_DiscAllowedCustGroups_Upsert';
        sp.Parameters.Refresh();

        sp.Parameters.ParamByName('@IDDiscount').value := arg_promoDTO.IDDiscount;
        customerGroupList := arg_promoDTO.getCustomerGroupList();

        for i:= 0 to customerGroupList.Count - 1 do begin
            sp.Parameters.ParamByName('@IDTipoPessoa').Value := TDiscountCustomerGroup(customerGroupList.Items[i]).getIDTipoPessoa;
            sp.ExecProc();
        end;

        sp.ExecProc();

     except
        on e: Exception do begin

        end;
     end;
  finally
     freeAndNil(sp);
     freeAndNil(delete);
     freeAndNil(customerGroupList);
  end;
end;

procedure TPromoDAO.savePromo(arg_promoDTO: TPromoDTO);
var
  sp: TADOStoredProc;
begin
  try
     fConnection.BeginTrans;

     try
        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;
        sp.ProcedureName := 'sp_Discounts_Upsert';
        sp.Parameters.Refresh();
        sp.Parameters.ParamByName('@IDDiscount').Value := arg_promoDTO.IDDiscount;
        sp.Parameters.ParamByName('@DiscountName').value := arg_promoDTO.DiscountName;

        sp.Parameters.ParamByName('@StartOn').Value := StrToDateDef(DateToStr(arg_promoDTO.StartDate), 0);
        sp.Parameters.ParamByName('@EndOn').Value := StrToDateDef(DateToStr(arg_promoDTO.EndDate), 0);
        sp.Parameters.ParamByName('@BeginTimeOfDay').value := StrToTimeDef(TimeToStr(arg_promoDTO.BeginTimeOfDay), 0);
        sp.Parameters.ParamByName('@EndTimeOfDay').value := StrToTimeDef(TimeToStr(arg_promoDTO.EndTimeOfDay), 0);

        sp.Parameters.ParamByName('@DiscType').value := arg_promoDTO.DiscountType;
        sp.Parameters.ParamByName('@IDStore').value := arg_promoDTO.IDStore;

        if ( arg_promoDTO.MinSubTotal = 0 ) then begin
           sp.Parameters.ParamByName('@MinSubTotal').value := null
        end else begin
                 sp.Parameters.ParamByName('@MinSubtotal').Value := arg_promoDTO.MinSubTotal;
            end;

        if ( arg_promoDTO.MaxUsesPerCustomer = 0 ) then begin
           sp.Parameters.ParamByName('@MaxUsesPerCustomer').value := null;
        end else begin
                 sp.Parameters.ParamByName('@MaxUsesPerCustomer').value := arg_promoDTO.MaxUsesPerCustomer;
        		end;

        if ( arg_promoDTO.MaxUsesInTotal = 0 ) then begin
           sp.Parameters.ParamByName('@MaxUsesInTotal').value := null;
        end else begin
                 sp.Parameters.ParamByName('@MaxUsesInTotal').value := arg_promoDTO.MaxUsesInTotal;
            end;

        sp.Parameters.ParamByName('@MinQuantity').Value := arg_promoDTO.MinQuantity;

        if ( not arg_promodto.FirstTimeCustomerOnly ) then begin
        	  sp.Parameters.ParamByName('@FirstTimeCustomerOnly').value := 0;
        end else begin
                 sp.Parameters.ParamByName('@FirstTimeCustomerOnly').value := 1;
            end;

        sp.Parameters.ParamByName('@CustomerCardRequired').value := arg_promoDTO.CustomerCardRequired;
        sp.Parameters.ParamByName('@IsStackable').value := arg_promoDTO.IsStackable;

        // convert rewardAmount to amount type is "Percent"
        sp.Parameters.ParamByName('@RewardAmount').value := convertPercentRewardValue(arg_promoDTO.AmountType, arg_promoDTO.RewardAmount);

        sp.Parameters.ParamByName('@AmountType').value := arg_promoDTO.AmountType;
        sp.Parameters.ParamByName('@RewardQuantity').value := arg_promoDTO.RewardQuantity;
        sp.Parameters.ParamByName('@MinDollarAmount').value := arg_promoDTO.MinDollarAmount;
        sp.Parameters.paramByName('@IsBogo').value := arg_promoDTO.IsBogo;
        sp.Parameters.ParamByName('@BuyAnd').Value := arg_promoDTO.BuyAnd;
        sp.Parameters.ParamByName('@CashierShouldWarn').Value := arg_promoDTO.CashierShouldWarn;

        sp.ExecProc();

        if ( arg_promoDTO.idDiscount = 0 ) then // stands insert
           arg_promoDTO.IDDiscount := sp.Parameters.paramByName('@IDDiscount').Value;

        saveValidOnDays(arg_promoDTO);

        if ( arg_promoDTO.StoreDefined ) then begin
           saveStoreDiscount(arg_promoDTO);
        end;

        if ( arg_promoDTO.CouponDefined ) then begin
           saveCouponDiscount(arg_promoDTO);
        end;

        if ( arg_promoDTO.IDDiscUses > 0 ) then begin
           saveUsesDiscount(arg_promoDTO);
        end;

        if ( arg_promoDTO.PurchaseTagDefined ) then begin
           saveTagDiscount(arg_promoDTO);
        end;

        if ( arg_promoDTO.RewardTagDefined ) then begin
           saveRewardsDiscount(arg_promoDTO);
        end;

        if ( arg_promoDTO.CustomerGroupDefined ) then begin
           saveCustomerGroupDiscount(arg_promoDTO);
        end;

        fConnection.CommitTrans;
     except
        on e: Exception do begin
           fConnection.RollbackTrans;
           raise exception.Create(format('save promo error: %s', [e.message]));
        end;
     end;
  finally
     freeAndNil(sp);
  end;

end;

procedure TPromoDAO.saveRewardsDiscount(arg_promoDTO: TPromoDTO);
var
  delete: TADOQuery;
  sp: TADOStoredProc;
//  rewardTagList: TObjectList;
  i: Integer;
begin
  try
     try

        delete := TADOQuery.Create(nil);
        delete.Connection := fConnection;
        delete.SQL.add('delete from DiscRewardTags ');
        delete.sql.Add('where idDiscount = :param_idDiscount');
        delete.Parameters.ParamByName('param_idDiscount').Value := arg_promoDTO.IDDiscount;
        delete.ExecSQL();

        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;
        sp.procedureName := 'sp_DiscRewardTags_Upsert';
        sp.Parameters.Refresh();

        sp.Parameters.paramByName('@IDDiscount').Value := arg_promoDTO.IDDiscount;

        rewardTagList := arg_promoDTO.getRewardTagList();

        for i:= 0 to rewardTagList.Count - 1 do begin
            sp.Parameters.ParamByName('@IDTag').Value := TDiscountReward(rewardTagList.Items[i]).getIDTag;
//            showmessage(format('RewardTag is %d', [TDiscountReward(rewardTagList.Items[i]).getIDTag]));
            sp.ExecProc();
        end;

     except
        on e: Exception do begin
           raise;
        end;
     end;
  finally
     freeAndNil(sp);
     freeAndNil(delete);
//     freeAndNil(rewardTagList);
  end;
end;

procedure TPromoDAO.saveStoreDiscount(arg_promoDTO: TPromoDTO);
var
  delete: TADOQuery;
  sp: TADOStoredProc;
  i: Integer;
begin
  try
     try
        delete := TADOQuery.Create(nil);
        delete.Connection := fConnection;
        delete.SQL.add('delete from DiscStores ');
        delete.sql.Add('where idDiscount = :param_idDiscount');
        delete.Parameters.ParamByName('param_idDiscount').Value := arg_promoDTO.IDDiscount;
        delete.ExecSQL();

        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;
        sp.procedureName := 'sp_DiscStores_Upsert';
        sp.Parameters.Refresh();

        sp.Parameters.ParamByName('@IDDiscount').Value := arg_promoDTO.IDDiscount;
        sp.Parameters.ParamByName('@IsInclude').Value := arg_promoDTO.IsInclude;

        stores := arg_promoDTO.getStoreList();

        for i:= 0 to stores.Count - 1 do begin
            sp.Parameters.ParamByName('@IDStore').Value := TStoreRegistry(stores.Items[i]).IdStore;
            sp.ExecProc();
        end;

     except
        on e: Exception do begin
           raise;
        end;
     end;
  finally
     freeAndNil(sp);
     freeAndNil(delete);
  end;
end;

procedure TPromoDAO.saveTagDiscount(arg_promoDTO: TPromoDTO);
var
  sp: TADOStoredProc;
  delete: TADOQuery;
  i: Integer;
begin
  try
     try
        delete := TADOQuery.Create(nil);
        delete.Connection := fConnection;
        delete.SQL.add('delete from DiscQualifyingTags ');
        delete.sql.Add('where idDiscount = :param_idDiscount');
        delete.Parameters.ParamByName('param_idDiscount').Value := arg_promoDTO.IDDiscount;
        delete.ExecSQL();

        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;

        sp.procedureName := 'sp_DiscQualifyingTags_Upsert';
        sp.Parameters.Refresh();
        sp.Parameters.ParamByName('@IDDiscount').value :=  arg_promoDTO.IDDiscount;

        purchaseTagList := arg_promoDTO.getPurchaseTagList();

        for i:= 0 to purchaseTagList.Count - 1 do begin
            sp.Parameters.ParamByName('@IDTag').Value := TDiscountPurchase(purchaseTagList.items[i]).getIDTag; //(purchaseTagList.items[i] as TDiscountPurchase).getIdTag;///
//            showmessage(format('PurchaseTag is %d', [TDiscountPurchase(purchaseTagList.items[i]).getIDTag]));
            sp.ExecProc();
        end;

     except
        on e: Exception do begin
          raise;
        end;
     end;
  finally
//     purchaseTagList.Free;
     freeAndNil(sp);
     freeAndNil(delete);

  end;
end;

procedure TPromoDAO.saveUsesDiscount(arg_promoDTO: TPromoDTO);
var
  sp: TADOStoredProc;
begin
  try
     try
        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;

        sp.procedureName := 'sp_DiscUses_Upsert';
        sp.Parameters.Refresh();
        sp.Parameters.ParamByName('@IDDiscount').value := arg_promoDTO.IDDiscount;
        sp.Parameters.ParamByName('@IDInventoryMov').value := arg_promoDTO.IDDiscUses;

        sp.ExecProc();

     except
        on e: Exception do begin
          raise;
        end;
     end;
  finally
     freeAndNil(sp);
  end;
end;

procedure TPromoDAO.saveValidOnDays(arg_promoDTO: TPromoDTO);
var
  sp: TADOStoredProc;
  discountValidDaysList: TStringList;
  i: Integer;
begin
  try
     try
        deleteValidOnDays(arg_promoDto.IDDiscount);

        sp := TADOStoredProc.Create(nil);
        sp.Connection := fConnection;

        sp.procedureName := 'sp_DiscValidOnDays_Upsert';
        sp.Parameters.Refresh();

        sp.Parameters.ParamByName('@IDDiscount').value := arg_promoDTO.IDDiscount;
        discountValidDaysList := arg_promoDTO.getValidOnDaysDiscount();

        for i:= 0 to discountValidDaysList.Count - 1 do begin
           sp.Parameters.ParamByName('@DayOfWeek').Value := strToInt(discountValidDaysList.Strings[i]);
           sp.ExecProc();
        end;

     except
        on e: Exception do begin
          raise;
        end;
     end;
  finally
     freeAndNil(sp);
     freeAndNil(discountValidDaysList);
  end;
end;

procedure TPromoDAO.setConnection(arg_conn: TADOConnection);
begin
  fConnection := arg_conn;
end;

procedure TPromoDAO.SaveCouponOnSaleToApplyCouponDiscount(
  coupon: TCoupon);
var cmd: TADOQuery;
    select: TADOQuery;
begin
  try
     try
        select := TADOQuery.Create(nil);
        select.Connection := fConnection;
        select.SQL.add('select * from Sal_Coupon ');
        select.SQL.add(' where DocumentID = :param_DocId and CouponCode like :param_CouponCode ');
        select.Parameters.ParamByName('param_DocId').Value := coupon.DocumentId;
        select.Parameters.ParamByName('param_CouponCode').Value := coupon.CouponCode;
        select.Open();

        if ( select.IsEmpty ) then begin
            cmd := TADOQuery.Create(nil);
            cmd.Connection := fConnection;
            cmd.SQL.add('Insert into Sal_Coupon values (:param_DocId, :param_CouponCode)');
            cmd.Parameters.ParamByName('param_DocId').Value := coupon.DocumentId;
            cmd.Parameters.ParamByName('param_CouponCode').Value := coupon.CouponCode;
            cmd.ExecSQL();
        end;

     except
          on e: Exception do begin
             raise e.Create('Error: Cannot insert coupons to sale ' + e.Message);
          end;
     end;
  finally
     FreeAndNil(select);
     FreeAndNil(cmd);
  end;

end;

end.
