unit PromoHandleConflict;

interface
uses contnrs, classes, SysUtils, Dialogs, uSystemConst;

Const
    NO_TAG_SELECTED = 0;

type
     TPromoHandleConflict = class
     private
        //
        FIdTag: Integer;
        FEndOnDate: TDateTime;
        FIdCurrentPromo: Integer;

        // current promo object
        FpromoList: TObjectList;

        // sign to conflict
        FfoundTagConflict: Boolean;
        FfoundPromoConflict: Boolean;
        FFoundAnyConflict: Boolean;

        // list of models found on tag
        FidModelList: String;
        FIdTagList: String;

        // list of promo objects on conflict
        FPromoListConflict: TObjectList;
        // list of tag objects on conflict
        FTagListConflict: TObjectList;

        // conflict was fixed inside the view
        FIsFixed: Boolean;
        FIsBogo: boolean;

        // ( Internal Conflict ) get the models associated to the tag inside the current promo ( add or edit screen )
        function GetModelListFromTag(idTag: Integer): TStringList;
        function GetTagListFromPromo(idTagSelected: Integer; idPromo: Integer): String;
        function GetTagListRewardFromPromo(idTagSelected: integer; idPromo: integer): string;
        function GetModelListFromPromo(idPromo: Integer): TStringList;
        function GetModelListRewardFromPromo(idPromo: integer): TStringList;

        // get all active promos already inserted that can be run in parallel.
        function GetPromoList(endOnDate: TDateTime): TObjectList;
        // Details about conflict to display on screen
        procedure ShowConflict(foundConflict: Boolean; var isFixed: Boolean);

        function SeekForConflictOnTag(idModelList: String; idTagList: String): TObjectList;
        function SeekForConflictOnPromos(idModelList: String; promoList: TObjectList): TObjectList;
        function SeekForConflictOnBogoPromos(idModelList: string; promoList: TObjectList): TObjectList;

        function DealWithConflicts(isConflict: Boolean): Boolean;

        function HandleConflictToPromoByTag(): Boolean;
        function HandleConflictToPromoDateChange(): Boolean;
        function HandleConflictToBogoPromoByTag(): boolean;
        function HandleConflictToBogoPromoRewardTag(): boolean;
        function HandleConflictToBogoPromoByDateChange(): boolean;
     public
        // Called to just to non Bogos
        function HandleConflict(endOnDate: TDateTime; idTag: Integer; idCurrentPromo: Integer): boolean; overload;

        // Called to Bogo Discount Tag sides
        function HandleConflict(idTag: integer; idCurrentPromo: integer; endOnDate: TDateTime): boolean; overload;

        // Called to Bogo Reward Tag sides
        function HandleConflict(idTag: integer; endOnDate: TDateTime; idCurrentPromo: integer): boolean; overload;

     end;


implementation
uses uDM, PromoDTO, ViewPromoConflict;

{ TPromoHandleConflict }

function TPromoHandleConflict.GetModelListFromTag(
  idTag: Integer): TStringList;
var
  i: Integer;
begin
  result := dm.GetModelsFromTagModel(idTag);

  for i := 0 to result.Count - 1 do begin
      if ( FidModelList = '' ) then begin
          FidModelList := Copy(result.Strings[i],  (Pos('IdModel', result.Strings[i])+8), 10);
      end else begin
             FidModelList := FIdModelList + ', ' + Copy(result.Strings[i],  (Pos('IdModel', result.Strings[i])+8), 10);
          end;
  end;

end;

function TPromoHandleConflict.GetPromoList(endOnDate: TDateTime): TObjectList;
begin
   FpromoList := dm.GetPromos(endOnDate);
end;

procedure TPromoHandleConflict.showConflict(foundConflict: Boolean; var IsFixed: Boolean);
var
  i: integer;
  view: TvwPromoConflict;
begin
   if ( foundConflict ) then begin
      view := TvwPromoConflict.Create(nil);
      view.Start(FIdTag, FidModelList, FidTagList, FPromoListConflict, IsFixed);
      FIsFixed := IsFixed;
      freeAndNil(view);
   end;

end;

function TPromoHandleConflict.SeekForConflictOnTag
(idModelList: String; idtagList: String): TObjectList;
begin
   result := dm.SeekForConflictOnTag(idModelList, idtagList);
   FFoundTagConflict := result.Count > 0;
   FFoundAnyConflict := FfoundTagConflict;
   FTagListConflict := result;

end;

function TPromoHandleConflict.SeekForConflictOnPromos(idModelList: String; promoList: TObjectList): TObjectList;
begin
   result := dm.SeekForConflictOnPromo(idModelList, promoList);
   FFoundPromoConflict := result.Count > 0;
   FFoundAnyConflict := FFoundAnyConflict or FfoundPromoConflict;
   FPromoListConflict := result;
end;

function TPromoHandleConflict.HandleConflictToPromoDateChange(): Boolean;
var
  index: Integer;
  counter: Integer;
begin
   result := false;
   // all promos that could be running
   GetPromoList(FEndOnDate);

   // all models inside tags in the current promo selected.
   GetModelListFromPromo(FIdCurrentPromo);

   // Get all models inside a tag that intends to be inserted.
   //GetModelListFromTag(FIdTag);

   // Internal seek ( models x internal tags )
   //SeekForConflictOnTag(FidModelList, FIdTagList);

   // search to find current promo inside the list
   for counter:= 0 to FpromoList.Count - 1 do begin
       if ( FIdCurrentPromo = TPromoDTO(FpromoList[counter]).IDDiscount ) then begin
          index := counter;
          break;
       end;

       index := 0;

   end;

   // remove from the list the promo that had date changed.
   FpromoList.Remove(FpromoList.Items[index]);

   // External seek ( models x external promos )
   SeekForConflictOnPromos(FidModelList, FpromoList);

   result := DealWithConflicts(FFoundAnyConflict);
end;

function TPromoHandleConflict.HandleConflictToPromoByTag(): Boolean;
begin
   result := false;

   // all promos that could be running
   GetPromoList(FEndOnDate);

   // Get all models inside a tag that intends to be inserted.
   GetModelListFromTag(FIdTag);

   // Get All tags already inserted
   GetTagListFromPromo(FIdTag, FIdCurrentPromo);

   // Internal seek ( models x internal tags )
   if ( length(FidTagList) > 0 ) then begin
      SeekForConflictOnTag(FidModelList, FIdTagList);
   end;

   // External seek ( models x external promos )
   if ( FpromoList.Count > 0 ) then begin
      SeekForConflictOnPromos(FidModelList, FpromoList);
   end;

   result := DealWithConflicts(FFoundAnyConflict);

   // save memory
   if ( FpromoList <> nil ) then FreeAndNil(FPromoList);
   if ( FPromoListConflict <> nil ) then FreeAndNil(FPromoListConflict);
   if ( FTagListConflict <> nil ) then FreeAndNil(FTagListConflict);

end;

function TPromoHandleConflict.GetModelListFromPromo(
  idPromo: Integer): TStringList;
begin
  FidModelList := dm.GetModelsFromPromo(idPromo);
end;

function TPromoHandleConflict.GetTagListFromPromo(idTagSelected: Integer; idPromo: Integer): String;
begin
   result := dm.GetTagsFromPromo(idTagSelected, idPromo);
   FidTagList := result;
end;

function TPromoHandleConflict.DealWithConflicts(
  isConflict: Boolean): Boolean;
begin
   if ( isConflict ) then begin
       ShowConflict(FfoundPromoConflict, FIsFixed);
   end else begin
           FIsFixed := true;
       end;

   result := FIsFixed;

end;

function TPromoHandleConflict.HandleConflictToBogoPromoByTag(): boolean;
begin
   result := false;

   // all promos that could be running
   GetPromoList(FEndOnDate);

   // Get all models inside a tag that intends to be inserted.
   GetModelListFromTag(FIdTag);

   // Get All tags already inserted
   GetTagListFromPromo(FIdTag, FIdCurrentPromo);

   // External seek ( models x external promos )
   if ( FpromoList.Count > 0 ) then begin
      SeekForConflictOnBogoPromos(FidModelList, FpromoList);
   end;

   result := DealWithConflicts(FFoundAnyConflict);

   // save memory
   if ( FpromoList <> nil ) then FreeAndNil(FPromoList);
   if ( FPromoListConflict <> nil ) then FreeAndNil(FPromoListConflict);
   if ( FTagListConflict <> nil ) then FreeAndNil(FTagListConflict);
end;

function TPromoHandleConflict.HandleConflictToBogoPromoByDateChange(): boolean;
var
  index: Integer;
  counter: Integer;
begin
   result := false;
   // all promos that could be running
   GetPromoList(FEndOnDate);

   // all models inside tags in the current promo selected.
   GetModelListRewardFromPromo(FIdCurrentPromo);

   // search to find current promo inside the list
   for counter:= 0 to FpromoList.Count - 1 do begin
       if ( FIdCurrentPromo = TPromoDTO(FpromoList[counter]).IDDiscount ) then begin
          index := counter;
          break;
       end;

   end;

   // remove from the list the promo that had date changed.
   FpromoList.Remove(FpromoList.Items[index]);

   // External seek ( models x external promos )
   SeekForConflictOnBogoPromos(FidModelList, FpromoList);

   result := DealWithConflicts(FFoundAnyConflict);
end;

function TPromoHandleConflict.SeekForConflictOnBogoPromos(
  idModelList: string; promoList: TObjectList): TObjectList;
begin
   result := dm.SeekForConflictBogoPromo(idModelList, promoList);
   FFoundPromoConflict := result.Count > 0;
   FFoundAnyConflict := FFoundAnyConflict or FfoundPromoConflict;
   FPromoListConflict := result;
end;

function TPromoHandleConflict.HandleConflict(endOnDate: TDateTime; idTag,
  idCurrentPromo: Integer): Boolean;
begin
   result := false;
   FFoundAnyConflict := false;
   FIdCurrentPromo := idCurrentPromo;
   FEndOnDate := endOnDate;
   FIdTag := idTag;

   if ( idTag = NO_TAG_SELECTED ) then begin
      HandleConflictToPromoDateChange();
   end else begin
          HandleConflictToPromoByTag();
       end;

   result := FIsFixed;
end;

function TPromoHandleConflict.HandleConflict(idTag,
  idCurrentPromo: integer; endOnDate: TDateTime): boolean;
begin
// To Bogo Discount Tags
   result := false;
   FFoundAnyConflict := false;
   FIdCurrentPromo := idCurrentPromo;
   FEndOnDate := endOnDate;
   FIsBogo := true;
   FIdTag := idTag;

   if ( idTag = NO_TAG_SELECTED ) then begin
      HandleConflictToBogoPromoByDateChange();
   end else begin
          HandleConflictToBogoPromoByTag();
       end;

   result := FIsFixed;
end;

function TPromoHandleConflict.GetTagListRewardFromPromo(idTagSelected,
  idPromo: Integer): String;
begin
   result := dm.GetTagsRewardFromPromo(idTagSelected, idPromo);
   FidTagList := result;
end;

function TPromoHandleConflict.GetModelListRewardFromPromo(
  idPromo: integer): TStringList;
begin
  FidModelList := dm.GetModelsRewardFromPromo(idPromo);
end;

function TPromoHandleConflict.HandleConflict(idTag: integer;
  endOnDate: TDateTime; idCurrentPromo: integer): boolean;
begin
// To Bogo Reward Discounts
   result := false;
   FFoundAnyConflict := false;
   FIdCurrentPromo := idCurrentPromo;
   FEndOnDate := endOnDate;
   FIsBogo := true;
   FIdTag := idTag;

   if ( idTag = NO_TAG_SELECTED ) then begin
      HandleConflictToBogoPromoByDateChange();
   end else begin
          HandleConflictToBogoPromoRewardTag();
       end;

   result := FIsFixed;

end;

function TPromoHandleConflict.HandleConflictToBogoPromoRewardTag: boolean;
begin
   result := false;

   // all promos that could be running
   GetPromoList(FEndOnDate);

   // Get all models inside a tag that intends to be inserted.
   GetModelListFromTag(FIdTag);

   // Get All tags already inserted
   GetTagListRewardFromPromo(FIdTag, FIdCurrentPromo);

   // External seek ( models x external promos )
   if ( FpromoList.Count > 0 ) then begin
      SeekForConflictOnBogoPromos(FidModelList, FpromoList);
   end;

   result := DealWithConflicts(FFoundAnyConflict);

   // save memory
   if ( FpromoList <> nil ) then FreeAndNil(FPromoList);
   if ( FPromoListConflict <> nil ) then FreeAndNil(FPromoListConflict);
   if ( FTagListConflict <> nil ) then FreeAndNil(FTagListConflict);
end;


end.
