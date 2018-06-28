unit BogoPromoCls;

interface
uses contnrs, SysUtils, db, dbClient;

type
    TBogoPromoDistribution = class
    private
      FIdPromo: integer;  // = IdDiscont
      FIdTag: integer;
      FIdPreinventory: integer;
      FIdPreInventBogoX: integer;
      FIdModel: integer;
      FIsBogo: boolean;
      FRewardAmount: double;
      FAmountType: string;
      FBuyQty: double;  // to control minimum quantity to distributes
      FGetQty: double;  // to control in how many quantities get must be distributed
      FIsBuy: boolean;
      FIsFree: boolean;
      FTotalBuy: double;
      FTotalGet: double;
      FTotalBuyRule: double;
      FTotalGetRule: double;
      FBuyLacking: double;
      FGetFreeLacking: double;
      FCashRegisterQuantity: double;

      // mark orphans to delete
      FToDelete: boolean;

      // list of all free items to
      FGetFreeList: TObjectList;
      // list if orphan items
      FGetOrphanList: TObjectList;

      // list of regular discounts
      FGetDiscountList: TObjectList;

      FBuyDatasetFromSale, FGetDatasetFromSale: TDataset;

      function computeBogo(): double;

    protected


    public
      constructor create();
      destructor destroy(); override;
      property IdPromo: integer read FIdPromo write FIdPromo;
      property IdTag: integer read FIdTag write FIdTag;
      property IdPreInventBogoX: integer read FIdPreInventBogoX write FIdPreInventBogoX;
      property IdPreInventory: integer read FIdPreinventory write FIdPreinventory;
      property IdModel: integer read FIdModel write FIdModel;
      property IsBogo: boolean read FIsBogo write FIsBogo;
      property RewardAmount: double read FRewardAmount write FRewardAmount;
      property AmountType: string read FAmountType write FAmountType;
      property BuyQty: double read FBuyQty write FBuyQty;
      property GetQty: double read FGetQty write FGetQty;
      property IsBuy: boolean read FIsBuy write FIsBuy;
      property IsFree: boolean read FIsFree write FIsFree;
      property ToDelete: boolean read FToDelete write FToDelete;
      property TotalBuy: double read FTotalBuy write FTotalBuy;

      procedure addToGetFreeList(freeItem: TBogoPromoDistribution);
      procedure addToOrphanList(orphanItem: TBogoPromoDistribution);
      procedure addToDiscountList(discountItem: TBogoPromoDistribution);
      procedure removeOrphansFromOrphanList();

      function getOneFree(IdModel: integer): TBogoPromoDistribution;
      function getFreeList(): TObjectList;
      function getOrphanList(): TObjectList;
      function getTotalQtyBogoGet(cashregQuantity: double; buyQty, getQty: integer): double;
      function computeSaleBogo(documentID: integer; dsBogo: Tdataset): boolean;
      function isFoundInBogoGetFreeList(idModel: integer): boolean;
      function isFoundInBogoGetDiscountList(idModel: integer): boolean;
      function isFoundInBogoGetY(idModel: integer): boolean;
    end;


implementation
uses uDM;

{ TBogoPromo }

procedure TBogoPromoDistribution.addToDiscountList(
  discountItem: TBogoPromoDistribution);
begin
  self.FGetDiscountList.Add(discountItem);
end;

procedure TBogoPromoDistribution.addToGetFreeList(freeItem: TBogoPromoDistribution);
begin
  FGetFreeList.Add(freeItem);
end;


procedure TBogoPromoDistribution.addToOrphanList(
  orphanItem: TBogoPromoDistribution);
begin
  self.FGetOrphanList.add(orphanItem);
end;

function TBogoPromoDistribution.computeBogo(): double;
var
   cashRegQty, _buyQty, _getQty: integer;
begin
   try
     cashRegQty := trunc(FCashRegisterQuantity);
     _buyQty := trunc(FBuyQty);
     _getQty := trunc(FGetQty);
     result := ( cashRegQty / _buyQty ) * _getQty;
   except
      result := 0;
   end;
end;

function TBogoPromoDistribution.computeSaleBogo(documentID: integer; dsBogo: Tdataset): boolean;
var bogosOnSale: TDataset;
begin

  bogosOnSale := dm.getSalesWithBogo(documentID);

  result := true;
end;

constructor TBogoPromoDistribution.create;
begin
  inherited;
  FGetFreeList := TObjectList.Create(true);
  FGetOrphanList := TObjectList.Create(true);
  FGetDiscountList := TObjectList.Create(true);

end;

destructor TBogoPromoDistribution.destroy;
begin
  if ( FGetFreeList <> nil ) then begin
     FreeAndNil(FGetFreeList);
  end;

  if ( FGetOrphanList <> nil ) then begin
     FreeAndNil(FGetOrphanList);
  end;

  if ( FGetDiscountList <> nil ) then begin
     FreeAndNil(FGetDiscountList);
  end;

end;

function TBogoPromoDistribution.getFreeList: TObjectList;
begin
   result := FGetFreeList;
end;

function TBogoPromoDistribution.getTotalQtyBogoGet(cashregQuantity: double; buyQty,
  getQty: integer): double;
begin
  FBuyQty := buyQty;
  FGetQty := getQty;
  FCashRegisterQuantity := cashregQuantity;
  result := computeBogo();
end;

function TBogoPromoDistribution.getOneFree(IdModel: integer): TBogoPromoDistribution;
begin

end;

function TBogoPromoDistribution.getOrphanList: TObjectList;
begin
  result := FGetOrphanList;
end;

function TBogoPromoDistribution.isFoundInBogoGetDiscountList(
  idModel: integer): boolean;
var i: integer;
begin
  for i:=0 to self.FGetDiscountList.Count - 1 do begin
      if ( TBogoPromoDistribution(FGetDiscountList.Items[i]).IdModel = idModel ) then begin
          result := true;
          break;
      end;
  end;
end;

function TBogoPromoDistribution.isFoundInBogoGetFreeList(
  idModel: integer): boolean;
var i: integer;
begin
  for i:=0 to self.FGetFreeList.Count - 1 do begin
      if ( TBogoPromoDistribution(FGetFreeList.Items[i]).IdModel = idModel ) then begin
          result := true;
          break;
      end;
  end;
end;

function TBogoPromoDistribution.isFoundInBogoGetY(
  idModel: integer): boolean;
begin
   result := isFoundInBogoGetFreeList(idModel) or isFoundInBogoGetDiscountList(idModel);
end;

procedure TBogoPromoDistribution.removeOrphansFromOrphanList;
var
  i: integer;
begin
  for i := 0 to FGetOrphanList.Count -1 do begin
      if ( TBogoPromoDistribution(FGetOrphanList.Items[i]).ToDelete ) then begin
         FGetOrphanList.Delete(i);
      end;
  end;

end;

end.
 