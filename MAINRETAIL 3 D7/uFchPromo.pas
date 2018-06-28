(*
-----------------------------------------------------------------------------------------------------
Version : (287 - 272)
Date    : 10.26.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Promo issues: Flat Promo Error, Flat Promo Error for Freq Buyer, Promo Sale Total
Solution: I fixed some routines related to mistake flow interface.
Version : (287 - 273)
-----------------------------------------------------------------------------------------------------
*)

unit uFchPromo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, CheckLst, DateBox, Mask,
  SuperComboADO, DBCtrls, StrUtils, uFrmPromoItem, uNewPersonType,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxCalendar, cxDBEdit, cxSpinEdit,
  cxTimeEdit, PromoDTO, Spin, cxCurrencyEdit, ComCtrls, dbClient, StoreCls, StoreDAO,
  contnrs, PromoHandleConflict;

type

//  TPromoType = ( ptSale, ptFrequentBuyer, ptCoupon, ptLoyalty);
  TPromoType = (ptCoupon, ptSale);
//  TPromoTypes = set of TPromoType;

  TFchPromo = class(TbrwFrmParent)
    quFormIDPromo: TIntegerField;
    quFormBarcode: TStringField;
    quFormPromo: TStringField;
    quFormPromoType: TIntegerField;
    quFormQtyFrequent: TFloatField;
    quFormStartDate: TDateTimeField;
    quFormEndDate: TDateTimeField;
    quFormDaysOfWeek: TStringField;
    quFormDiscountType: TIntegerField;
    quFormDiscountValue: TFloatField;
    quFormQtyPromoItem: TFloatField;
    quFormIDStore: TIntegerField;
    quFormFlatPromo: TBooleanField;
    pnlTopo: TPanel;
    pnlDiscount: TPanel;
    pnDiscount: TPanel;
    pnlSchedule: TPanel;
    pnSchedule: TPanel;
    pnlPromo: TPanel;
    pnPromo: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    pnlDiscountAll: TPanel;
    lblStartDate: TLabel;
    lblEndDate: TLabel;
    lblDayOfWeek: TLabel;
    cbxDayOfWeek: TCheckListBox;
    Label2: TLabel;
    Label4: TLabel;
    startHour: TDateTimePicker;
    endHour: TDateTimePicker;
    Panel5: TPanel;
    lblPromo: TLabel;
    lblPromoType: TLabel;
    Label35: TLabel;
    Label1: TLabel;
    promoType: TComboBox;
    Label5: TLabel;
    amountType: TComboBox;
    Label6: TLabel;
    promoName: TEdit;
    firstTimeCustomer: TCheckBox;
    maxUsesSelected: TCheckBox;
    minimumSaleSubtotal: TCheckBox;
    canBeCombinedDiscounts: TCheckBox;
    customerGroup: TCheckBox;
    storeGroup: TCheckBox;
    maxUses: TSpinEdit;
    maxUsesPerCustomer: TCheckBox;
    maxUsesCustomer: TSpinEdit;
    minimumSaleSubtotalValue: TcxCurrencyEdit;
    minimumQualifiedItemsAmount: TCheckBox;
    minimumQualifiedItemsAmountValue: TcxCurrencyEdit;
    customerGroupBox: TGroupBox;
    addGroupImage: TImage;
    customerGroupList: TListBox;
    storeGroupBox: TGroupBox;
    addStoreImage: TImage;
    storeList: TListBox;
    panelGroupTag: TPanel;
    customGroupSelect: TComboBox;
    storeSelect: TComboBox;
    deleteCustomerGroup: TImage;
    deleteStore: TImage;
    loyaltyCardRequired: TCheckBox;
    startDate: TDateBox;
    endDate: TDateBox;
    pagePromo: TPageControl;
    tabBOGO: TTabSheet;
    pgcTag: TPageControl;
    tbsTag: TTabSheet;
    purchaseTagGroup: TGroupBox;
    addPurchaseTagImage: TImage;
    deletePurchaseTag: TImage;
    purchaseTagSelect: TComboBox;
    purchaseTagList: TListBox;
    rewardTagGroup: TGroupBox;
    quantitySelected: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    minimumQuantity: TcxCurrencyEdit;
    rewardQuantity: TcxCurrencyEdit;
    chkBogo: TCheckBox;
    cxGridModelsInTag: TcxGrid;
    cxGridModelsInTagDBTableView1: TcxGridDBTableView;
    cxGridModelsInTagDBTableView1DBColumn3: TcxGridDBColumn;
    cxGridModelsInTagDBTableView1DBColumn4: TcxGridDBColumn;
    cxGridModelsInTagLevel1: TcxGridLevel;
    dsModelsInsideTag: TDataSource;
    dsModelsInsideReward: TDataSource;
    tabSale: TTabSheet;
    salePriceSelected: TGroupBox;
    salePriceInfo: TLabel;
    saleprice: TcxCurrencyEdit;
    tabAmount: TTabSheet;
    rewardAmountSelected: TGroupBox;
    rewardamount: TcxCurrencyEdit;
    tabItem: TTabSheet;
    rewardPercentSelected: TGroupBox;
    rewardpercent: TcxCurrencyEdit;
    lbReward: TLabel;
    cmbAndOrGet: TComboBox;
    lbRewardAmountValue: TLabel;
    lbPercent: TLabel;
    pnlReward: TPanel;
    addRewardTagImage: TImage;
    deleteRewardTag: TImage;
    rewardTagSelect: TComboBox;
    rewardTagList: TListBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    tabCoupon: TTabSheet;
    couponGroup: TGroupBox;
    addCouponImage: TImage;
    deleteCoupon: TImage;
    couponList: TListBox;
    coupon: TEdit;
    chbWarning: TCheckBox;
    procedure cbxDayOfWeekExit(Sender: TObject);
    procedure promoTypeCloseUp(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure amountTypeCloseUp(Sender: TObject);
    procedure addPurchaseTagImageClick(Sender: TObject);
    procedure addRewardTagImageClick(Sender: TObject);
    procedure addGroupImageClick(Sender: TObject);
    procedure addStoreImageClick(Sender: TObject);
    procedure addCouponImageClick(Sender: TObject);
    procedure deleteCouponClick(Sender: TObject);
    procedure deletePurchaseTagClick(Sender: TObject);
    procedure deleteRewardTagClick(Sender: TObject);
    procedure deleteCustomerGroupClick(Sender: TObject);
    procedure deleteStoreClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure customerGroupClick(Sender: TObject);
    procedure storeGroupClick(Sender: TObject);
    procedure maxUsesSelectedClick(Sender: TObject);
    procedure maxUsesPerCustomerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btCancelClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btNextRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure btLastRecClick(Sender: TObject);
    procedure purchaseTagListDblClick(Sender: TObject);
    procedure endDateExit(Sender: TObject);
    procedure endDateClick(Sender: TObject);
    procedure endDateChange(Sender: TObject);
    procedure purchaseTagSelectExit(Sender: TObject);
    procedure purchaseTagListClick(Sender: TObject);
    procedure rewardTagListClick(Sender: TObject);
    procedure rewardQuantityExit(Sender: TObject);
    procedure cmbAndOrGetCloseUp(Sender: TObject);
  private
    flagClose: Boolean;
    purchaseList: TObjectList;
    rewardList: TObjectList;
    customerList: TObjectList;
    stores: TList;

    fIdDiscount: Integer;
    storeDAO: TStoreDAO;
    rewardTags: TClientDataset;
    customerGroups: TClientDataset;

    fDaysOfWeek: String;
    objPromoDTO: TPromoDTO;
    FPromotypes: TPromoType;
    FFrmPromoItem: TFrmPromoItem;
    fRegistryPath : String;
    AOptions      : TcxGridStorageOptions;
    promoConflict: TPromoHandleConflict;
    saveOnEndDate: TDateTime;
    FMustToCallConflict: Boolean;

    procedure emptyTagSelect(arg_selectTagIndex: Integer);

    // Antonio 2014 Aug 27
    procedure uncheckAllDays();

    // Antonio 2014 Aug 18
    procedure resetScreen();
    procedure showPromoSettings(arg_idDiscount: Integer);

    procedure showMasterPromoDiscount(arg_idDiscount: Integer);
    procedure showPurchaseTagsDiscount(arg_idDiscount: Integer);
    procedure showRewardTagsDiscount(arg_idDiscount: Integer);
    procedure showCouponsDiscount(arg_idDiscount: Integer);
    procedure showCustomersDiscount(arg_idDiscount: Integer);
    procedure showDaysOfWeekDiscount(arg_idDiscount: Integer);
    procedure showStoresDiscount(arg_idDiscount: Integer);

    // Antonio 2014 Jul 24
    procedure resetAmountTypeValues();
    procedure resetPromoType();

    // Antonio 2014 Jul 14
    procedure savePromo();
    procedure loadPromoDTO();

    function getPromoType: TPromoType;

    procedure SetDayOfWeek;
    procedure GetDayOfWeek;
    procedure fillScreen(arg_idDiscount: Integer);

    procedure LoadImages;
    procedure CloseScreen;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure loadPurchaseTag();
    procedure loadRewardTag();
    procedure loadCustomerGroup();
    procedure loadStores();

    procedure pickStoresToPromo();
    procedure pickPurchaseTagsToPromo();
    procedure pickRewardTagsToPromo();
    procedure pickCustomersToPromo();
    procedure pickValidDaysToPromo();
    procedure pickCouponsToPromo();

    function CanNavigate(): Boolean;
    procedure VerifyPromoDateSettings();
    procedure RestartPromoDeactivated(nextDate: TDatetime);
    procedure setPromoInterface(promoType, amountType: integer; isBogo: boolean = false);
    procedure loadModelsFromTagInsideList(idTag: integer);
    procedure loadModelsFromRewardInsideList(idtag: integer);
    procedure changeToPercentType();
  protected
    procedure onBeforeShow(); override;
  public
    { Public declarations }
    function start(arg_idDiscount: Integer): Boolean;
  end;

implementation

uses uDM, uSystemConst, uMsgBox, uMsgConstant, uDMGlobal, uSystemTypes,
     uNumericFunctions, uCharFunctions, uFrmPromoItemList, uFrmExport, PromoDAO,
  PaiDeTodos, TagView, TagViewEdit;


{$R *.dfm}

{ TFchPromo }

procedure TFchPromo.SetDayOfWeek;
var
  i : Integer;
  DayOfWeek: String;
begin
  for i := 0 to cbxDayOfWeek.Items.Count-1 do
    if cbxDayOfWeek.Checked[i] then
        DayOfWeek := DayOfWeek + InttoStr(i + 1) + ';';

  // Antonio 2014 Jul 14
  fDaysOfWeek := DayOfWeek;
end;

procedure TFchPromo.GetDayOfWeek;
var
  i,value : Integer;
  //DaysOfWeek : String;
begin

  for i := 0 to cbxDayOfWeek.Count-1 do
    cbxDayOfWeek.Checked[i] := (frmCommand = btInc);

  if (frmCommand <> btInc) then
  begin
    //DaysOfWeek := StringReplace(quFormDaysOfWeek.AsString,';','',[rfReplaceAll]);
    for i := 1 to length(fDaysOfWeek) do
    begin
      value := StrToInt(copy(fDaysOfWeek,i,1)) -1;
      cbxDayOfWeek.Checked[value] := True;
    end;
  end;
end;

procedure TFchPromo.cbxDayOfWeekExit(Sender: TObject);
begin
  inherited;
 // Antonio 2014 Aug 13 SetDayOfWeek;
end;

procedure TFchPromo.LoadImages;
begin
  // background color to land image
  dm.imgSmall.BkColor := clWhite;

  DM.imgSmall.GetBitmap(BTN18_NEW, addPurchaseTagImage.Picture.Bitmap);
  dm.imgSmall.GetBitmap(BTN18_DELETE, deletePurchaseTag.Picture.Bitmap);

  dm.imgSmall.GetBitmap(BTN18_NEW, addCouponImage.Picture.Bitmap);
  dm.imgSmall.GetBitmap(BTN18_DELETE, deleteCoupon.Picture.Bitmap);

  dm.imgSmall.GetBitmap(BTN18_NEW, addRewardTagImage.Picture.Bitmap);
  dm.imgSmall.GetBitmap(BTN18_DELETE, deleteRewardTag.Picture.Bitmap);

  dm.imgSmall.GetBitmap(BTN18_NEW, addGroupImage.Picture.Bitmap);
  dm.imgSmall.GetBitmap(BTN18_DELETE, deleteCustomerGroup.Picture.Bitmap);

  dm.imgSmall.GetBitmap(BTN18_NEW, addStoreImage.Picture.Bitmap);
  dm.imgSmall.GetBitmap(BTN18_DELETE, deleteStore.Picture.Bitmap);

end;


procedure TFchPromo.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quForm.FieldByName('FlatPromo').AsBoolean    := False;
  quForm.FieldByName('StartDate').AsDateTime   := Now;
  quForm.FieldByName('PromoType').AsInteger    := 1;
  quForm.FieldByName('DiscountType').AsInteger := 1;
  quForm.FieldByName('DaysOfWeek').AsString    := '1;2;3;4;5;6;7;';
end;

procedure TFchPromo.promoTypeCloseUp(Sender: TObject);
begin
  inherited;
{
  couponGroup.Visible := ( promoType.ItemIndex = NEW_PROMO_TYPE_COUPON );
  panelGroupTag.Visible := (promoType.ItemIndex = NEW_PROMO_TYPE_PROMO) or (promoType.ItemIndex = NEW_PROMO_TYPE_COUPON) ;
  panelGroupTag.Left := 0;
  panelGroupTag.Top := 122;
 }
end;

function TFchPromo.getPromoType: TPromoType;
begin
   result := TPromotype(promoType.ItemIndex);
end;

procedure TFchPromo.btCloseClick(Sender: TObject);
begin
//  inherited;
  try
      savePromo();
      CanNavigate();
      btCancelClick(sender); // get out of screen

  except
      on e: Exception do begin
         raise Exception.Create(format('Cannot save that promo: %s', [e.Message]));
      end;
  end;
end;

procedure TFchPromo.savePromo();
var
  promotype: TPromoType;
  objPromoDAO: TPromoDAO;
begin
  promotype := getPromoType;
  objpromoDTO := TPromoDTO.Create();
  loadPromoDTO();

  try
      objPromoDAO := TPromoDAO.Create();
      try
        if ( promotype in [ptCoupon, ptSale] ) then begin
           objPromoDAO.setConnection(dm.ADODBConnect);
           objPromoDAO.savePromo(objPromoDTO);
        end;
      except
        on e: Exception do begin
           raise Exception.Create(format('Save Promo error: %s', [e.Message]));
        end;
      end;
  finally
 //     freeAndNil(objPromoDTO);
      freeAndNil(objPromoDAO);
  end;
end;

procedure TFchPromo.loadPromoDTO();
begin
  objPromoDTO.AmountType := amountType.Text;
  objPromoDTO.IDDiscount := fIdDiscount ;
  objPromoDTO.IDStore := dm.fStore.ID;
  objPromoDTO.DiscountName := promoName.Text;
  objPromoDTO.DiscountType := promoType.Text;

  objPromoDTO.StartDate := StartDate.Date;
  objPromoDTO.EndDate := endDate.Date;
  SetDayOfWeek();

  objPromoDTO.BeginTimeOfDay := startHour.Time;
  objPromoDTO.EndTimeOfDay := endHour.Time;

  objPromoDTO.MinSubTotal  := minimumSaleSubtotalValue.Value;

  objPromoDTO.MaxUsesPerCustomer := maxUsesCustomer.Value;
  objPromoDTO.MaxUsesInTotal := maxUses.Value;

  objPromoDTO.FirstTimeCustomerOnly := false;
  objPromoDTO.CustomerCardRequired := loyaltyCardRequired.Checked;

  objPromoDTO.CustomerGroup := customerGroup.Checked;

  objPromoDTO.salePrice := salePrice.Value;

  objPromoDTO.IsStackable := canBeCombinedDiscounts.Checked;
  objPromoDTO.AmountType := amountType.Text;

  if ( pos('Percent', amountType.text) > 0 ) then begin
     objPromoDTO.RewardAmount := rewardpercent.Value;
  end else begin
         objPromoDTO.RewardAmount := rewardamount.Value;
      end;

  // Buy 1 Get 1 -> BOGO
  if ( chkBogo.Checked ) then begin
      objPromoDTO.RewardQuantity := trunc(rewardQuantity.Value);
      if ( trim(minimumQuantity.Text) = '' ) then begin
         objPromoDTO.MinQuantity := 1;
      end else begin
             objpromoDTO.MinQuantity := minimumQuantity.EditValue;
          end;
  end else begin
         // default values
         objPromoDTO.RewardQuantity := null;
         objPromoDTO.MinQuantity := 1;
      end;

  { Antonio, Nov 21th 2017
  if ( pos('Quantity', amountType.text) > 0 ) then begin
      objPromoDTO.RewardQuantity := trunc(rewardQuantity.Value);
      if ( trim(minimumQuantity.Text) = '' ) then begin
         objPromoDTO.MinQuantity := 1;
      end else begin
             objpromoDTO.MinQuantity := minimumQuantity.EditValue;
          end;
  end else begin
         // default values
         objPromoDTO.RewardQuantity := null;
         objPromoDTO.MinQuantity := 1;
      end;
   }

  if ( minimumQualifiedItemsAmount.Checked ) then begin
      objPromoDTO.MinDollarAmount := minimumQualifiedItemsAmountValue.Value;
  end else begin
         objpromodto.MinDollarAmount := null;
      end;

  objPromoDTO.IsBogo := chkBogo.Checked;
  objPromoDto.BuyAnd := cmbAndOrGet.ItemIndex = 0;
  objPromoDTO.CashierShouldWarn := chbWarning.Checked;

  pickStoresToPromo();
  pickPurchaseTagsToPromo();
  pickRewardTagsToPromo();
  pickCustomersToPromo();
  pickValidDaysToPromo();
  pickCouponsToPromo();

  objPromoDTO.IsInclude := ( frmCommand = btInc );
end;

procedure TFchPromo.CloseScreen;
begin
  inherited;
  close;
end;

procedure TFchPromo.fillScreen(arg_idDiscount: Integer);
begin
  if ( arg_idDiscount = 0 ) then begin
     resetScreen();
  end
  else begin
     btCancel.Caption := 'Cancel';
     showPromoSettings(arg_idDiscount);
  end;
end;

procedure TFchPromo.amountTypeCloseUp(Sender: TObject);
begin
  inherited;
//  tagPanel.Visible := true;
//  salePriceSelected.Visible := ( amountType.ItemIndex = NEW_PROMO_SALE_PRICE );
//  salePriceInfo.Visible := salePriceSelected.Visible;


  rewardAmountSelected.Visible := ( amountType.ItemIndex = (NEW_PROMO_AMOUNT_OFITEM -1)) or
                                  ( amountType.ItemIndex = NEW_PROMO_AMOUNT_OFSUBTOTAL );

  rewardPercentSelected.Visible := ( amountType.ItemIndex = (NEW_PROMO_PERCENT_OFITEM-1) ) or
                                  ( amountType.ItemIndex = NEW_PROMO_PERCENT_OFSUBTOTAL );

  tbsTag.Caption := 'Tag -> Models';
  lbReward.caption := '';
  lbReward.Caption := 'Reward Amount';
  lbRewardAmountValue.caption := 'Reward Amount';

(*
  if ( promoType.ItemIndex = promoType.Items.IndexOf('Coupon') ) then begin
     chkBogo.Checked := true;
     pagePromo.ActivePage := tabCoupon;
  end;
 *)

  if ( chkBogo.Checked ) then begin
     tbsTag.Caption := 'Bogo -> Buy';
     lbReward.Caption := 'Reward Amount to GET';
     lbRewardAmountValue.caption := 'Reward Amount to GET';

  end;

  quantitySelected.Visible := chkBogo.Checked;

  setPromoInterface(promoType.ItemIndex, amountType.ItemIndex, chkBogo.Checked);

  if ( dsModelsInsideTag.Dataset <> nil ) then begin
     dsModelsInsideTag.DataSet.close;
  end;

  if ( dsModelsInsideReward.dataset <> nil ) then begin
     dsModelsInsideReward.DataSet.close;
  end;

end;

procedure TFchPromo.resetAmountTypeValues;
begin
  saleprice.Value := 0.00;
  rewardamount.Clear;
  rewardpercent.Clear;
  minimumQuantity.Clear;
  rewardQuantity.Clear;
end;

procedure TFchPromo.resetPromoType;
begin
  coupon.clear();
  couponList.clear();
  purchaseTagList.clear();
  rewardTagList.clear;
  storeList.clear();
end;

procedure TFchPromo.loadCustomerGroup();
var
  i: Integer;
  promoDAO: TPromoDAO;
  customerGroupList: TObjectList;
begin
  try
      promoDAO := TPromoDAO.create();
      promoDAO.setConnection(dm.ADODBConnect);
      customerGroupList := promoDAO.getCustomerGroups();

      customGroupSelect.Clear();

      for i:= 0 to customerGroupList.Count - 1 do begin
          customGroupSelect.AddItem(TDiscountCustomerGroup(customerGroupList[i]).getName(), TObject(TDiscountCustomerGroup(customerGroupList[i])));
      end;
  finally
      freeAndNil(promoDAO);
      freeAndNil(customerGroupList);
  end;
end;

procedure TFchPromo.loadPurchaseTag;
var
  i: Integer;
  promoDAO: TPromoDAO;
  purchaseTag: TDiscountPurchase;
begin
  try
      promoDAO := TPromoDAO.create();
      promoDAO.setConnection(dm.ADODBConnect);
      purchaseList := promoDAO.getPurchaseTags();

      purchaseTagSelect.Clear();

      for i:= 0 to purchaseList.Count - 1 do begin
         purchaseTag := TDiscountPurchase(purchaseList.Items[i]);
         purchaseTagSelect.AddItem(purchaseTag.getName, TObject(purchaseTag));
      end;
  finally
      freeAndNil(promoDAO);
  end;
end;

procedure TFchPromo.loadRewardTag;
var
  i: Integer;
  promoDAO: TPromoDAO;
  rewardTag: TDiscountReward;
begin
  try
      promoDAO := TPromoDAO.create();
      promoDAO.setConnection(dm.ADODBConnect);

      // get a list of reward tags from database
      rewardList := promoDAO.getRewardTags(fIdDiscount);

      // clean up on the screen
      rewardTagSelect.Clear();

      // read each item to add in screen list
      for i:= 0 to rewardList.Count - 1 do begin
         rewardTag := TDiscountReward(rewardList.Items[i]);
         rewardTagSelect.AddItem(rewardTag.getName, TObject(rewardTag));
      end;
  finally
      freeAndNil(promoDAO);
  end;
end;

procedure TFchPromo.loadStores;
var
  i: Integer;
begin
  storeDao := TStoreDAO.create(dm.ADODBConnect);
  stores := storeDao.getStores();

  storeSelect.Clear();

  for i:= 0 to stores.Count - 1 do begin
      storeSelect.AddItem(TStoreRegistry(stores[i]).Name, TObject(TStoreRegistry(stores[i])));
  end;

(*
  for i:= (stores.Count - 1) downto 0 do begin
      stores.Delete(i);
  end;

  stores.Free;
*)
end;

procedure TFchPromo.pickStoresToPromo;
var
  i: Integer;
//  store: TStoreRegistry;
begin
  objPromoDTO.StoreDefined := false;
  for i:= 0 to storeList.Count - 1 do begin
     //store := TStoreRegistry(storeList.Items.Objects[i]);
     //objPromoDTO.addStoreToList(store);
     objPromoDTO.addStoreToList(TStoreRegistry(storeList.Items.Objects[i]));
     objPromoDTO.StoreDefined := true;
  end;
end;


procedure TFchPromo.pickValidDaysToPromo;
var
  i: Integer;
  index: Integer;
begin
  index := 0;
  for i:= 0 to cbxDayOfWeek.Count - 1 do begin
     if ( cbxDayOfWeek.Checked[i] ) then begin
        objPromoDTO.addDiscountValidOnDayToList(intToSTr(i+1));
     end;
  end;
end;

procedure TFchPromo.pickCouponsToPromo;
var
  i: Integer;
begin
  objPromoDTO.CouponDefined := false;
  for i:= 0 to couponList.Count - 1 do begin
     objPromoDTO.addCouponsToList(couponlist.Items.Strings[i]);
     objPromoDTO.CouponDefined := true;
  end;
end;

procedure TFchPromo.pickCustomersToPromo;
var
  i: Integer;
begin
  objPromoDTO.CustomerGroupDefined := false;
  for i:= 0 to customerGroupList.Count - 1 do begin
     objPromoDTO.addCustomerGroupToList(TDiscountCustomerGroup(customerGroupList.Items.Objects[i]));
     objPromoDTO.CustomerGroupDefined := true;
  end;
end;

procedure TFchPromo.pickPurchaseTagsToPromo;
var
  i: Integer;
begin
  objPromoDTO.PurchaseTagDefined := false;
  for i:= 0 to purchaseTagList.Count - 1 do begin
     objPromoDTO.addPurchaseTagToList(TDiscountPurchase(purchaseTagList.Items.Objects[i]));
     objPromoDTO.PurchaseTagDefined := true;
  end;
end;

procedure TFchPromo.pickRewardTagsToPromo;
var
  i: Integer;
begin
  objPromoDTO.RewardTagDefined := false;
  for i:= 0 to rewardTagList.Count - 1 do begin
     objPromoDTO.addRewardTagToList(TDiscountReward(rewardTagList.Items.Objects[i]));
     objPromoDTO.RewardTagDefined := true;
  end;
end;

function TFchPromo.start(arg_idDiscount: Integer): Boolean;
begin
  LoadImages;
  loadPurchaseTag();
  loadCustomerGroup(); // to change
  loadStores();

  if ( frmCommand = btInc ) then begin
     arg_idDiscount := 0;
  end;

  fIdDiscount := arg_idDiscount;
  loadRewardTag();

  fillScreen(arg_IdDiscount);
  result := ( ShowModal = mrOK );
end;

procedure TFchPromo.onBeforeShow;
begin
  inherited;
  start(StrToIntDef(FieldKey1, 0));
end;

procedure TFchPromo.addPurchaseTagImageClick(Sender: TObject);
var
  purchaseTag: TDiscountPurchase;
  index: Integer;
begin
  inherited;
  index := purchaseTagSelect.Items.IndexOf(purchaseTagSelect.Text);

  // empty tag
  emptyTagSelect(index);

  // pic the purchaseTag object according to index selected
  purchaseTag := TDiscountPurchase(purchaseTagSelect.Items.Objects[index]);

  // search for the index in the Purchase Tag List gettting by name of the tag
  index := purchaseTagList.Items.IndexOf(purchaseTagSelect.Text);

  if ( index = - 1 ) then begin

     // Antonio 2017 Oct 13 - having conflict needs to be fixed.
     VerifyPromoDateSettings();

     if ( chkBogo.Checked ) then begin
         if ( not promoConflict.HandleConflict(purchaseTag.getIDTag, fIdDiscount, endDate.Date) ) then begin
            exit;
         end
     end else begin
             if ( not promoConflict.HandleConflict(endDate.Date, purchaseTag.getIDTag, fIdDiscount) ) then begin
                exit;
             end;
         end;

     purchaseTagList.AddItem(purchaseTagSelect.Text, TObject(purchaseTag));

     purchaseTagSelect.ItemIndex := -1;
     loadRewardTag();
  end else begin
         showMessage(format('Item %s already in the tags selected to this promo.',[purchaseTag.getName]));
      end;
end;

procedure TFchPromo.addRewardTagImageClick(Sender: TObject);
var
  index: Integer;
  rewardTag: TDiscountReward;
begin
  inherited;

  index := rewardTagSelect.Items.IndexOf(rewardTagSelect.Text);

  emptyTagSelect(index);

  rewardTag := TDiscountReward(rewardTagSelect.Items.Objects[index]);

  index := rewardTagList.Items.IndexOf(rewardTagSelect.Text);

  if ( index = -1 ) then begin
     VerifyPromoDateSettings();

     if ( not promoConflict.HandleConflict(rewardTag.getIDTag, endDate.Date, fIdDiscount) ) then begin
        exit;
     end;

     rewardTagList.AddItem(rewardTagSelect.Text, TObject(rewardTag));
     changeToPercentType();
     rewardTagSelect.ItemIndex := -1;
  end else begin
         showMessage(format('Item %s already in the Others Promo Settings.',[rewardTag.getName]));
      end;
end;

procedure TFchPromo.addGroupImageClick(Sender: TObject);
var
  customerGroup: TDiscountCustomerGroup;
  index: Integer;
begin
  inherited;
  index := customGroupSelect.Items.IndexOf(customGroupSelect.Text);
  customerGroup := TDiscountCustomerGroup(customGroupSelect.Items.Objects[index]);

  index := customerGroupList.Items.IndexOf(customGroupSelect.Text);

  if ( index = - 1 ) then begin
     customerGroupList.AddItem(customGroupSelect.Text, TObject(customerGroup));
  end;
end;

procedure TFchPromo.addStoreImageClick(Sender: TObject);
var
  store: TStoreRegistry;
  index: Integer;
begin
  inherited;
  index := storeSelect.Items.IndexOf(storeSelect.Text);
  store := TStoreRegistry(storeSelect.Items.Objects[index]);

  index := storeList.Items.IndexOf(storeSelect.Text);

  // to avoid duplicates
  if ( index = -1 ) then begin
     storeList.AddItem(storeSelect.Text, TObject(store));
  end;
end;

procedure TFchPromo.addCouponImageClick(Sender: TObject);
begin
  inherited;

  if ( trim(coupon.Text) = '' ) then begin
     emptyTagSelect(-1);
  end;

  couponList.items.Add(coupon.Text);
  coupon.Clear;

end;

procedure TFchPromo.deleteCouponClick(Sender: TObject);
var
  i: Integer;
  idCouponList: String;
begin
  inherited;
  try
     for i:= 0 to couponList.Count - 1 do begin
         if ( couponList.Selected[i] ) then begin
            if ( length(idCouponList) = 0 ) then begin
                idCouponList := couponList.Items.Strings[i];
            end else begin
                   idCouponList := idCouponList + ',' + couponList.Items.Strings[i];
                end;
         end;
     end;

     couponList.DeleteSelected;
     dm.DeleteCouponList(fIdDiscount, idCouponList);
  except
     on e: Exception do begin
        e.Create('Error: '+ e.Message);
     end;
  end;
end;

procedure TFchPromo.deletePurchaseTagClick(Sender: TObject);
var
  i: Integer;
  idTagList: String;
begin
  inherited;
  try
     for i:= 0 to purchaseTagList.Count - 1 do begin
         if ( purchaseTagList.Selected[i] ) then begin
            if ( length(idtagList) = 0 ) then begin

                idTagList := IntToStr(TDiscountPurchase(purchaseTagList.Items.Objects[i]).getIDTag);
            end else begin
                   idTagList := idTagList + ',' + IntToStr(TDiscountPurchase(purchaseTagList.Items.Objects[i]).getIDTag);
                end;
         end;
     end;

     purchaseTagList.DeleteSelected;
     dm.DeletePurchaseTagList(fIdDiscount, idTagList);
  except
     on e: Exception do begin
       raise e.Create('Error: '+ e.Message);
     end;
  end;
end;

procedure TFchPromo.deleteRewardTagClick(Sender: TObject);
var
  i: Integer;
  idTagList: String;
begin
  inherited;
  try
     for i:= 0 to rewardTagList.Count - 1 do begin
         if ( rewardTagList.Selected[i] ) then begin
            if ( length(idtagList) = 0 ) then begin

                idTagList := IntToStr(TDiscountReward(rewardTagList.Items.Objects[i]).getIDTag);
            end else begin
                   idTagList := idTagList + ',' + IntToStr(TDiscountReward(rewardTagList.Items.Objects[i]).getIDTag);
                end;
         end;
     end;

     rewardTagList.DeleteSelected;
     dm.DeletePurchaseTagList(fIdDiscount, idTagList);
  except
     on e: Exception do begin
       raise e.Create('Error: '+ e.Message);
     end;
  end;
end;

procedure TFchPromo.deleteCustomerGroupClick(Sender: TObject);
begin
  inherited;
  customerGroupList.DeleteSelected;
end;

procedure TFchPromo.deleteStoreClick(Sender: TObject);
begin
  inherited;
  storeList.DeleteSelected;
end;

procedure TFchPromo.FormShow(Sender: TObject);
begin
//  inherited;
  pgcTag.Visible := true;
  lblUserName.Caption := dm.fUser.UserName;
  self.Width := 900;

  CanNavigate();

  promoName.SetFocus;
end;

procedure TFchPromo.FormCreate(Sender: TObject);
begin
//  inherited;
    promoConflict := TPromoHandleConflict.Create;
    FMustToCallConflict := false;
end;

procedure TFchPromo.FormDestroy(Sender: TObject);
begin
//  inherited;
   purchaseList.Free;
   customerList.free;
   rewardList.Free;

end;

procedure TFchPromo.customerGroupClick(Sender: TObject);
begin
  inherited;
  customerGroupBox.enabled := customerGroup.Checked;
end;

procedure TFchPromo.storeGroupClick(Sender: TObject);
begin
  inherited;
  storeGroupBox.enabled := storeGroup.Checked;
end;

procedure TFchPromo.resetScreen;
var
  i: Integer;
begin
  // promo section
  promoName.Clear;
  promoType.ItemIndex := 1;
 // promoTypeCloseUp(self);
  amountType.ItemIndex := 0;
  amountTypeCloseUp(self);

  resetPromoType();
  resetAmountTypeValues();

  {
  minimumQuantity.Value := 0;
  saleprice.Value := 0.00;
  rewardQuantity.Value := 0;
  rewardAmount.Value := 0.00;
  rewardpercent.Value := 0.00;
   }
  // time restrictions section
  startDate.Date := now;
  endDate.date := now + 1;

  for i:= 0 to cbxDayOfWeek.Items.Count - 1 do begin
     cbxDayOfWeek.Checked[i] := true;
  end;

  startHour.Time := strToTime('00:00');
  endHour.Time := strToTime('23:59');

  // Qualifiers section
  canBeCombinedDiscounts.Checked := false;
  customerGroup.Checked := false;
  firstTimeCustomer.Checked := false;
  loyaltyCardRequired.checked := false;
  maxUsesPerCustomer.Checked := false;
  maxUsesSelected.Checked := false;
  minimumQualifiedItemsAmount.Checked := false;
  minimumSaleSubtotal.Checked := false;
  storeGroup.Checked := false;

  maxUses.Value := 0;
  maxUsesCustomer.Value := 0;
  minimumQualifiedItemsAmountValue.editValue := null;
  minimumSaleSubtotalValue.value := 0.00;

  fIdDiscount := 0;
  cmbAndOrGet.ItemIndex := 0

end;

procedure TFchPromo.showPromoSettings(arg_idDiscount: Integer);
begin
  showMasterPromoDiscount(arg_idDiscount);
  showpurchaseTagsDiscount(arg_idDiscount);
  showrewardTagsDiscount(arg_idDiscount);
  showStoresDiscount(arg_idDiscount);
  showCouponsDiscount(arg_idDiscount);
  showCustomersDiscount(arg_idDiscount);
  showDaysOfWeekDiscount(arg_idDiscount);
end;

procedure TFchPromo.showCouponsDiscount(arg_idDiscount: Integer);
var
  daoPromo: TPromoDAO;
  coupons: TStringList;
  i: Integer;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);

  couponList.Clear();

  coupons := daoPromo.getCouponsDiscount(arg_idDiscount);

  if ( coupons <> nil ) then begin
     for i:= 0 to coupons.Count - 1 do begin
        couponList.Items.Add(coupons[i]);
     end;
  end;

  freeAndNil(coupons);
end;

procedure TFchPromo.showCustomersDiscount(arg_idDiscount: Integer);
var
  daoPromo: TPromoDAO;
  customers: TObjectList;
  i: Integer;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);
  customers := daoPromo.getCustomerGroupsDiscount(arg_idDiscount);
  customerGroup.Checked := customers.Count > 0;

  customerGroupList.Clear();

  for i:= 0 to customers.Count -1 do begin
     customerGroupList.AddItem(TDiscountPurchase(customers.Items[i]).getName, TObject(customers.Items[i]));
  end;

  freeAndNil(daoPromo);
end;

procedure TFchPromo.showDaysOfWeekDiscount(arg_idDiscount: Integer);
var
  daoPromo: TPromoDAO;
  weekDays: TStringList;
  i: Integer;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);

  uncheckAllDays();

  weekDays := daoPromo.getValidOnDays(arg_idDiscount);
  for i:= 0 to weekDays.Count - 1 do begin
     cbxDayOfWeek.Checked[strToInt(weekdays.Strings[i]) - 1] := true;
  end;

  freeAndNil(weekdays);
end;

procedure TFchPromo.showMasterPromoDiscount(arg_idDiscount: Integer);
var
  objPromo: TPromoDTO;
  daoPromo: TPromoDAO;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);
  objPromo := daoPromo.getOnePromo(arg_idDiscount);

  // Promo section
  promoName.Text := objPromo.DiscountName;
  promoType.ItemIndex := promoType.Items.IndexOf(objPromo.DiscountType);

  // IsBogo
  chkBogo.Checked := objPromo.IsBogo;

  if ( objPromo.BuyAnd ) then begin
     cmbAndOrGet.ItemIndex := 0
  end else begin
          cmbAndOrGet.ItemIndex := 1;
      end;

//  amountTypeCloseUp(self);

  promoTypeCloseUp(self);
  amountType.ItemIndex := amountType.Items.IndexOf(objPromo.AmountType);
  amountTypeCloseUp(self);

  saleprice.Value := objPromo.SalePrice;

  minimumQuantity.Value := objPromo.MinQuantity;
  rewardQuantity.Value := objPromo.RewardQuantity;

  // search for word "Percent" to define how "RewardAmount" should appears
  if ( pos('Percent', objPromo.AmountType) > 0 ) then begin
      rewardpercent.Value := objpromo.RewardAmount;
  end else begin
           rewardamount.Value := objPromo.RewardAmount;
      end;

  // Time Restriction section
  startDate.Date := objPromo.StartDate;
  endDate.Date := objPromo.EndDate;

  saveOnEndDate := endDate.Date;

  startHour.Time := objPromo.BeginTimeOfDay;
  endHour.Time := objPromo.EndTimeOfDay;

  // Qualifiers section
  firstTimeCustomer.Checked := false;
  loyaltyCardRequired.Checked := objPromo.CustomerCardRequired;

  maxUsesSelected.Checked := ( objPromo.MaxUsesInTotal > 0 );
  maxUses.Value := objPromo.MaxUsesInTotal;

  maxUsesPerCustomer.Checked := ( objPromo.MaxUsesPerCustomer > 0 );
  maxUsesCustomer.Value := objPromo.MaxUsesPerCustomer;

  minimumSaleSubtotal.Checked := ( objPromo.MinSubTotal > 0 );
  minimumSaleSubtotalValue.value := objPromo.MinSubTotal;

  if ( objPromo.MinDollarAmount <> null ) then begin
      minimumQualifiedItemsAmount.Checked := true;
      minimumQualifiedItemsAmountValue.editValue := objPromo.MinDollarAmount;
  end else begin
         minimumQualifiedItemsAmount.Checked := false;
         minimumQualifiedItemsAmountValue.EditValue := objPromo.MinDollarAmount;
      end;

  canBeCombinedDiscounts.Checked := objPromo.IsStackable;

  chbWarning.Checked := objPromo.CashierShouldWarn;

  freeAndNil(objPromo);
  freeAndNil(daoPromo);
end;

procedure TFchPromo.showPurchaseTagsDiscount(arg_idDiscount: Integer);
var
  daoPromo: TPromoDAO;
  tags: TObjectList;
  i: Integer;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);
  tags := daoPromo.getPurchaseTagsDiscount(arg_idDiscount);

  purchaseTagList.Clear();

  for i:= 0 to tags.Count -1 do begin
     purchaseTagList.AddItem(TDiscountPurchase(tags.Items[i]).getName, TObject(tags.Items[i]));
  end;

  freeAndNil(daoPromo);
  purchaseTagListClick(self);
end;

procedure TFchPromo.showRewardTagsDiscount(arg_idDiscount: Integer);
var
  daoPromo: TPromoDAO;
  tags: TObjectList;
  i: Integer;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);
  tags := daoPromo.getRewardTagsDiscount(arg_idDiscount);

  rewardTagList.clear();

  for i:= 0 to tags.Count -1 do begin
     rewardTagList.AddItem(TDiscountReward(tags.Items[i]).getName, TObject(tags.Items[i]));
  end;

  freeAndNil(daoPromo);
  rewardTagListClick(self);
end;

procedure TFchPromo.showStoresDiscount(arg_idDiscount: Integer);
var
  daoPromo: TPromoDAO;
  stores: TObjectList;
  i: Integer;
begin
  daoPromo := TPromoDAO.Create();
  daoPromo.setConnection(dm.ADODBConnect);
  stores := daoPromo.getStoreGroupDiscount(arg_idDiscount);

  storeList.clear();
  storeGroup.Checked := ( stores.Count > 0 );

  for i:= 0 to stores.Count -1 do begin
     storeList.AddItem(TStoreRegistry(stores.Items[i]).Name, TObject(stores.Items[i]));
  end;

  freeAndNil(daoPromo);
end;

procedure TFchPromo.uncheckAllDays;
var
  i: Integer;
begin
  for i:= 0 to cbxDayOfWeek.Count - 1 do begin
    cbxDayOfWeek.Checked[i] := false;
  end;

end;

procedure TFchPromo.maxUsesSelectedClick(Sender: TObject);
begin
  inherited;

  if ( not maxUsesSelected.Checked ) then
     maxUses.value := 0;
end;

procedure TFchPromo.maxUsesPerCustomerClick(Sender: TObject);
begin
  inherited;

  if ( not maxUsesPerCustomer.Checked ) then
     maxUsesCustomer.value := 0;

end;

procedure TFchPromo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //inherited;
  // canClose := true; //( ModalResult = mrOK );
end;

procedure TFchPromo.btCancelClick(Sender: TObject);
begin
  modalResult := mrOK;
  // Antonio 2014 Sep 01 - I had to do that to close the form anyway because I could not close the form like I used (modalResult := mrCancel ).
  PostMessage(self.Handle, WM_CLOSE, 0, 0);
end;

procedure TFchPromo.FormKeyPress(Sender: TObject; var Key: Char);
begin
 // inherited;
  if ( key = chr(VK_RETURN) ) then begin
     modalresult  := mrNone;
  end;
end;

procedure TFchPromo.emptyTagSelect(arg_selectTagIndex: Integer);
begin
   if ( arg_selectTagIndex = -1 ) then begin
      raise Exception.Create('Select a tag before adding');
   end;
end;

procedure TFchPromo.btNextRecClick(Sender: TObject);
begin
//  inherited;
  MybrwQuery.Next;
  btNextRec.Enabled := not MybrwQuery.Eof;
  if ( not MybrwQuery.Eof ) then begin
     fillScreen(MybrwQuery.FieldByName('IdDiscount').Value);
  end;
end;

procedure TFchPromo.btPriorRecClick(Sender: TObject);
begin
  inherited;
  fillScreen(MybrwQuery.FieldByName('IdDiscount').Value);
end;

procedure TFchPromo.btFirstRecClick(Sender: TObject);
begin
  inherited;
  fillScreen(MybrwQuery.FieldByName('IdDiscount').Value);
end;

procedure TFchPromo.btLastRecClick(Sender: TObject);
begin
  inherited;
  fillScreen(MybrwQuery.FieldByName('IdDiscount').Value);
end;

function TFchPromo.CanNavigate: Boolean;
begin
  result := false;
  if ( MybrwQuery <> nil ) then begin
     MybrwQuery.Active := true;
     result := ( MybrwQuery.RecordCount > 0 );
  end;

  btFirstRec.Enabled := result;
  btPriorRec.Enabled := result;
  btNextRec.Enabled :=  result;
  btLastRec.Enabled := result;


end;

procedure TFchPromo.VerifyPromoDateSettings();
var
  emptyDefaultDate: String;

begin
  emptyDefaultDate := '';

  if ( startDate.Text = emptyDefaultDate ) then begin
     startDate.SetFocus;
     raise Exception.Create('Type a valid start date to promo');
  end;

  if ( endDate.Text = emptyDefaultDate ) then begin
     endDate.SetFocus;
     raise Exception.Create('Type a valid end date to promo');
  end;



end;

procedure TFchPromo.purchaseTagListDblClick(Sender: TObject);
var
   index: Integer;
   iTemSelected: TDiscountPurchase;
   view: TfrmTagViewEdit;
begin
  inherited;
  // get Index selected in tag list
  index := purchaseTagList.ItemIndex;


  iTemSelected :=  TDiscountPurchase(purchaseTagList.Items.Objects[index]);

  try
     view := TfrmTagViewEdit.Create(nil);
     view.Start(itemSelected, 'U');
  finally
     FreeAndNil(view);
  end;

end;

procedure TFchPromo.RestartPromoDeactivated(nextDate: TDatetime);
const
   NO_TAG_SELECTED = 0;
begin
  if ( fIDDiscount <> 0 ) then begin
      // In case of user try reutilizes same promo changing the range of date.
      if ( not promoConflict.HandleConflict(nextDate, NO_TAG_SELECTED, fIdDiscount) ) then begin
          nextDate := saveOnEndDate;
      end;
  end;

end;

procedure TFchPromo.endDateExit(Sender: TObject);
begin
  inherited;
  RestartPromoDeactivated(endDate.Date);
end;

procedure TFchPromo.endDateClick(Sender: TObject);
var
  ctrl: TWinControl;
begin
  inherited;
  FMustToCallConflict := true;
  endDateChange(sender);
{
  ctrl := ActiveControl;
  ActiveControl := nil;
  PostMessage(TWinControl(Ctrl).Handle, WM_SETFOCUS, 0, 0);
  TWinControl(Ctrl).SetFocus;

  RestartPromoDeactivated(endDate.Date); }
end;

procedure TFchPromo.endDateChange(Sender: TObject);
begin
  inherited;
  if ( FMustToCallConflict ) then begin
     RestartPromoDeactivated(endDate.Date);

  end;
end;

procedure TFchPromo.purchaseTagSelectExit(Sender: TObject);
var
   view: TfrmTagView;
begin
  inherited;
  if ( purchaseTagSelect.Items.Count = 0 ) then begin
     showMessage('All tags are in use for other promos. There are no tags available. Please create new ones to set up this promo.');
     try
        view := TfrmTagView.Create(nil);
        view.start();
     finally
        FreeAndNil(view);
     end;
  end;

end;

procedure TFchPromo.setPromoInterface(promoType, amountType: integer;
  isBogo: boolean);
begin
  pagePromo.Visible := true;

  tabBOGO.TabVisible := isBogo;
//  tabSale.TabVisible := ( amountType = NEW_PROMO_SALE_PRICE );
  tabCoupon.TabVisible := ( promoType = NEW_PROMO_TYPE_COUPON );
  tabAmount.TabVisible := ( amountType = ( NEW_PROMO_AMOUNT_OFITEM - 1)  );
  tabItem.TabVisible := ( amountType = ( NEW_PROMO_PERCENT_OFITEM - 1) );

  if ( isBogo ) then begin
     pagePromo.ActivePage := tabBOGO;
  end else if ( tabCoupon.TabVisible ) then begin
              pagePromo.ActivePage := tabCoupon;
      end;
end;

procedure TFchPromo.purchaseTagListClick(Sender: TObject);
var index: Integer;
    iTemSelected: TDiscountPurchase;
begin
  inherited;

  if ( purchaseTagList.Count > 0 ) then begin
    // get Index selected in tag list
    index := purchaseTagList.ItemIndex;
    iTemSelected :=  TDiscountPurchase(purchaseTagList.Items.Objects[index]);
    loadModelsFromTagInsideList(iTemSelected.getIDTag());
  end;
end;

procedure TFchPromo.rewardTagListClick(Sender: TObject);
var index: Integer;
    iTemSelected: TDiscountReward;
begin
  inherited;

  // get Index selected in tag list
  if ( rewardTagList.Count > 0 ) then begin
    index := rewardTagList.ItemIndex;

    if ( index = -1 ) then  begin
        index := 0;
    end;

    iTemSelected :=  TDiscountReward(rewardTagList.Items.Objects[index]);
    loadModelsFromRewardInsideList(iTemSelected.getIDTag());
  end;
end;

procedure TFchPromo.loadModelsFromRewardInsideList(idtag: integer);
var
  cdsReward: TClientDataset;
begin
  if ( cdsReward <> nil ) then begin
     FreeAndNil(cdsReward);
  end;
  cdsReward := dm.GetModelsFromTagModel(IntToStr(idtag));
  dsModelsInsideReward.DataSet := cdsReward;
end;

procedure TFchPromo.loadModelsFromTagInsideList(idTag: integer);
var
  cdsOffer: TClientDataset;
begin

  if ( cdsOffer <> nil ) then begin
     freeAndNil(cdsOffer);
  end;

  cdsOffer := dm.GetModelsFromTagModel(IntToStr(idtag));
  dsModelsInsideTag.DataSet := cdsOffer;
end;

procedure TFchPromo.changeToPercentType;
begin
   if ( (rewardTagList.Count > 1) and (amountType.ItemIndex = NEW_PROMO_AMOUNT_OFITEM) ) then begin
      MessageDlg('Cannot possible apply Amount Off Discount to more than one reward items. Will be applied Percent Off Discount to 100% ( get free )',mtWarning, [mbOK], 0);
      amountType.ItemIndex := NEW_PROMO_PERCENT_OFITEM;
      amountTypeCloseUp(self);
      rewardpercent.Value := 100;
   end;
end;

procedure TFchPromo.rewardQuantityExit(Sender: TObject);
begin
  inherited;
  cmbAndOrGet.OnCloseUp(sender);
end;

procedure TFchPromo.cmbAndOrGetCloseUp(Sender: TObject);
begin
  inherited;
  if ( objPromoDTO <> nil ) then begin
     objPromoDto.BuyAnd := cmbAndOrGet.ItemIndex = 0;
  end;
end;

end.
