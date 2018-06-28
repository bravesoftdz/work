(*
-----------------------------------------------------------------------------------------------------
Version : (287 - 272)
Date    : 10.14.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : MR is not combine line items with same sale conditions
Solution: Implemented routine to verify previous quantity acording to previous conditions
          Fixed screen dimension because screen were cuted at some points.
Version : (287 - 273)
-----------------------------------------------------------------------------------------------------
*)

unit uFrmMainPOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, XiButton, PaiDeForms, siComp,
  siLangRT, LblEffct, uFrmParentSaleFull, DB, ADODB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridTableView,
  cxGridCustomTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGrid, DBCtrls, Mask, SubListPanel,
  dbcgrids, uFrmParentSales, SuperComboADO, mrBarCodeEdit, uSaleItem,
  uContentClasses, uFrmAskPrice, uNumericFunctions, uFrmBarcodeSearch,
  HTTPApp, HTTPProd, clsInfoCashSale, dbClient, contnrs,

  {new promotion}
  MainPromoClass, BogoPromoCls;

const
  SALE_OPTION_SALE  = 0;
  SALE_OPTION_ORDER = 1;
  SALE_OPTION_ADM   = 2;
  SALE_OPTION_ITEM  = 3;

  //amfsouza August 03, 2012
  NEED_RECALCULATE_PROMO_ANYREASON = -1;
  NEED_RECALCULATE_PROMO_STACKABLE = 0;
  NEED_RECALCULATE_PROMO = 1;


type
  TFrmMainPOS = class(TFrmParentSaleFull)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    pnlImage: TPanel;
    pnlDescription: TPanel;
    pnlSuggestion: TPanel;
    Shape1: TShape;
    imgTop: TImage;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    pnlSubTotal: TPanel;
    pnlTotal: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Shape5: TShape;
    Shape6: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Shape7: TShape;
    Panel10: TPanel;
    Shape8: TShape;
    Panel6: TPanel;
    Shape9: TShape;
    Panel8: TPanel;
    Shape10: TShape;
    Panel9: TPanel;
    Shape11: TShape;
    Panel15: TPanel;
    Shape12: TShape;
    Label9: TLabel;
    btnProccess: TXiButton;
    btnCancel: TXiButton;
    pnlLayalty: TPanel;
    Shape14: TShape;
    Panel16: TPanel;
    Shape15: TShape;
    Panel17: TPanel;
    pnlUPC: TPanel;
    Shape16: TShape;
    Panel19: TPanel;
    Shape17: TShape;
    Panel20: TPanel;
    pnlSale: TPanel;
    Shape18: TShape;
    Panel22: TPanel;
    Shape19: TShape;
    Panel23: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtLoyalty: TEdit;
    shBarcode: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    imgCustomer: TImage;
    lbTransaction: TLabel;
    lbUserName: TLabel;
    lbInvoiceDate: TLabel;
    btnItem: TXiButton;
    XiButton4: TXiButton;
    XiButton5: TXiButton;
    pnlSaleInfo: TPanel;
    btnCustomer: TXiButton;
    btnViewInventory: TXiButton;
    btnAditional: TXiButton;
    btnReturn: TXiButton;
    btnExempt: TXiButton;
    btnRTV: TXiButton;
    pnlAdmin: TPanel;
    btnCloseRegister: TXiButton;
    btnPrint: TXiButton;
    btnAdd: TSpeedButton;
    btnEdit: TSpeedButton;
    btnRemove: TSpeedButton;
    btnMessage: TSpeedButton;
    btnTimeClock: TSpeedButton;
    btnHelp: TSpeedButton;
    btnChangeUser: TSpeedButton;
    btnCommission: TSpeedButton;
    lbTime: TLabel;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    btnWithdraw: TXiButton;
    btnPrettyCash: TXiButton;
    pnlOrder: TPanel;
    btnNewHold: TXiButton;
    btnLayaway: TXiButton;
    lbPicture: TLabelEffect;
    LabelEffect1: TLabelEffect;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsLevel: TcxGridLevel;
    grdItemsDBModel: TcxGridDBColumn;
    grdItemsDBDescription: TcxGridDBColumn;
    grdItemsDBSalePrice: TcxGridDBColumn;
    grdItemsDBDiscount: TcxGridDBColumn;
    grdItemsDBTotalItem: TcxGridDBColumn;
    grdItemsDBSalesPerson: TcxGridDBColumn;
    grdItemsDBSuggRetail: TcxGridDBColumn;
    grdItemsDBSerialNumber: TcxGridDBColumn;
    grdItemsDBTax: TcxGridDBColumn;
    grdItemsDBQty: TcxGridDBColumn;
    edtZip: TDBEdit;
    btnSearchModel: TXiButton;
    DBText1: TDBText;
    LabelEffect2: TLabelEffect;
    LabelEffect3: TLabelEffect;
    LabelEffect4: TLabelEffect;
    LabelEffect5: TLabelEffect;
    SubListImage: TSubListPanel;
    SubListFeatures: TSubListPanel;
    quCrossSale: TADODataSet;
    grdCrossSale: TDBCtrlGrid;
    dsCrossSale: TDataSource;
    quCrossSaleIDInvAccessory: TIntegerField;
    quCrossSaleIDModel: TIntegerField;
    quCrossSaleModel: TStringField;
    quCrossSaleDescription: TStringField;
    quCrossSaleSellingPrice: TBCDField;
    quCrossSaleAvgCost: TBCDField;
    quCrossSaleFinalCost: TBCDField;
    quCrossSaleStoreCostPrice: TBCDField;
    quCrossSaleStoreSellingPrice: TBCDField;
    quCrossSaleStoreAvgPrice: TBCDField;
    quCrossSaleACostPrice: TCurrencyField;
    quCrossSaleASalePrice: TCurrencyField;
    quCrossSaleAAvgCost: TCurrencyField;
    edtModelCross: TDBText;
    edtDescriptionCross: TDBText;
    edtSalePriceCross: TDBText;
    btnSale: TXiButton;
    pnlItem: TPanel;
    btnItemRepair: TXiButton;
    btnGiftCard: TXiButton;
    SubCustomer: TSubListPanel;
    quCustomerCard: TADODataSet;
    quCustomerCardIDPessoa: TIntegerField;
    btnOpenHold: TXiButton;
    btnInvHistory: TXiButton;
    scMedia: TDBSuperComboADO;
    Shape28: TShape;
    edtBarcode: TmrBarCodeEdit;
    edtOtherCosts: TDBText;
    Label1: TLabel;
    pnlInvoiceScan: TPanel;
    Label2: TLabel;
    edtInvoiceSearch: TEdit;
    Shape20: TShape;
    btnSerialNumber: TSpeedButton;
    btnAdjust: TXiButton;
    XiButton3: TXiButton;
    btnRefreshPromo: TSpeedButton;
    btnNoSale: TXiButton;
    btnAdmin: TXiButton;
    XiButton: TXiButton;
    XiButton6: TXiButton;
    XiButton7: TXiButton;
    btnStoreAccount: TXiButton;
    XiButton9: TXiButton;
    XiButton10: TXiButton;
    XiButton11: TXiButton;
    XiButton15: TXiButton;
    XiButton16: TXiButton;
    XiButton17: TXiButton;
    XiButton18: TXiButton;
    lbLayaway: TLabel;
    spquPreSaleItemSellingPrice: TBCDField;
    grdItemsDBSellingPrice: TcxGridDBColumn;
    Shape32: TShape;
    btnColumn: TSpeedButton;
    pnlCupom: TPanel;
    lbCupom: TLabel;
    Shape33: TShape;
    edtCupom: TEdit;
    quItemsRepair: TADODataSet;
    tmrOverLoad: TTimer;
    pnlOverLoad: TPanel;
    lblOverLoad: TLabel;
    lblCashOverLoad: TLabel;
    btnTestPromo: TButton;
    quVerifyCustomerIsLoyalty: TADODataSet;
    quVerifyCustomerIsLoyaltyQTD: TIntegerField;
    PageProducer1: TPageProducer;
    lblTotalSaved: TLabel;
    Label17: TLabel;
    grdItemsDBTotalSalePrice: TcxGridDBColumn;
    grdItemsDBUnitDiscount: TcxGridDBColumn;
    subTotalDisplay: TLabel;
    itemDiscountDisplay: TLabel;
    saleDiscountDisplay: TLabel;
    taxDisplay: TLabel;
    totalInvoiceDisplay: TLabel;
    totalSavedDisplay: TLabel;
    signItemDiscount: TLabel;
    signSaleDiscount: TLabel;
    procedure FormShow(Sender: TObject);
    procedure XiButton4Click(Sender: TObject);
    procedure XiButton5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnChangeUserClick(Sender: TObject);
    procedure quPreSaleInfoAfterOpen(DataSet: TDataSet);
    procedure btnMessageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsPreSaleItemDataChange(Sender: TObject; Field: TField);
    procedure btnTimeClockClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure quCrossSaleCalcFields(DataSet: TDataSet);
    procedure btnSaleClick(Sender: TObject);
    procedure btnItemClick(Sender: TObject);
    procedure edtLoyaltyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPrettyCashClick(Sender: TObject);
    procedure btnWithdrawClick(Sender: TObject);
    procedure btnCloseRegisterClick(Sender: TObject);
    procedure btnNewHoldClick(Sender: TObject);
    procedure btnLayawayClick(Sender: TObject);
    procedure btnInvHistoryClick(Sender: TObject);
    procedure btnViewInventoryClick(Sender: TObject);
    procedure btnAditionalClick(Sender: TObject);
    procedure btnCustomerClick(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure edtBarcodeBeforeSearchBarcode(Sender: TObject);
    procedure edtInvoiceSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnItemRepairClick(Sender: TObject);
    procedure btnGiftCardClick(Sender: TObject);
    procedure btnAdjustClick(Sender: TObject);
    procedure btnRTVClick(Sender: TObject);
    procedure dsPreSaleInfoStateChange(Sender: TObject);
    procedure btnNoSaleClick(Sender: TObject);
    procedure btnColumnClick(Sender: TObject);
    procedure edtCupomKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrOverLoadTimer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSearchModelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnStoreAccountClick(Sender: TObject);
    procedure btnTestPromoClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure spquPreSaleItemAfterScroll(DataSet: TDataSet);
    procedure OnHoldPrintClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure spquPreSaleValueAfterOpen(DataSet: TDataSet);
    procedure OnProcesseSaleClick(Sender: TObject);
    procedure btnExemptClick(Sender: TObject);
  private

    // Antonio 2013 Dec 9
    mainPromo: TMainPromo;

    hasStoreSellingPrice: Boolean;
    FCountPuppies: Integer;
    dtData: TDateTime;
    FIsOverLoad : Boolean;
    FUserValidate: Boolean;
    FSaleOption: Integer;
    AView : TcxCustomGridTableView;
    fRegistryPath : String;
    FAskPrice : TFrmAskPrice;
    FClosingPressed : Boolean;
    AFrmBarcodeSearch : TFrmBarcodeSearch;

    // Bogo
    FPromoBogo: TBogoPromoDistribution;
    FFreeItemsBogo: TBogoPromoDistribution;
    FDiscountsBogo: TBogoPromoDistribution;
    FOrphansBogo: TBogoPromoDistribution;
    cdsBogo: TClientdataset;
    saleWithBogo: boolean;
    FLastPromoDiscount: integer;
    FKeepsWarning: boolean;
    FLastIdPreInventory: integer;
    FPromoBogoList: TObjectList;
    FOrphanList: TObjectList;

    // Antonio 2014 May 23 - cleaning up cash register
    function replaceQtyonRefund(arg_qty: Double): Double;
    procedure treatPackModel();
    function isPuppyRestrictionRechead(arg_counter: Integer): Boolean;
    function getCostPrice(): Double;
    function getSellingPrice(arg_isPromoOnSale: Boolean): Double;
    function isAskUserOnSale(arg_idUser, arg_idCommission: Integer; arg_condition: Boolean): Boolean;
    function getIdDepartment(arg_idModel: Integer): Integer;
    function getQuantity(arg_qty: Double): Double;
    function isModelVerified(arg_idModel: Integer): Boolean;
    function ifNeedsAskForSalePrice(arg_sellingPrice: Double): Double;

    procedure initializeInvoiceLabelValues();
    procedure treatInvoiceTotals();
    procedure askForNewModel();
    procedure callPollDisplay();
    procedure setStoreToBarcode();
    procedure doSale();
    procedure addSaleItem(arg_qty: Double);
    procedure addSaleItemAutoInsert(qty: Double);
    procedure fillSaleItem(arg_qty: Double);
    procedure treatInvoiceLabels(arg_refund: Boolean);
    procedure treatRefundCondition();
    procedure treatCommission();
    procedure treatSerialNumbers();

    // Antonio M F Souza, jan 29, 2013
    procedure dealRefundToItemWithoutInvoice(arg_ItemRefund: Integer);

    //amfsouza September 24, 2012 - to fix unit price when promo and price break
    procedure adjustSellingPriceInPromoPriceBreak(pIdPresale, pIdmodel:Integer; pQty: Double = 0);
    //amfsouza 03.05.2012 -
    function getSalesInCashRegister(id_presale: Integer): TADOQuery;

    //amfsouza 01.28.2012
    function isSerialNumberGroup(id_model: Integer): Boolean;

    //amfsouza 05.19.2011 - Open Promo
    function NeedRecalculatesPromo(IdModel: Integer): integer;

    procedure CallFunction(Key: Word);
    procedure SetPanel(iSaleOption:Integer);
    procedure RefreshTime;
    procedure RefreshUser;
    procedure CallMenuItem(IDMenu, IDSubMenu : Integer);
    procedure ClearItemImage;
    procedure ClearItemFeatures;
    procedure ClearCustomer;

    procedure OpenCrossSale;
    procedure CloseCrossSale;
    procedure RefreshCrossSale;
    procedure RefreshCustomer;
    function SearchCustomerCard(CustomerCard:String):Boolean;

    function ValidatePettyCash:Boolean;
    function ValidateWithdraw:Boolean;
    function ValidateCloseRegister:Boolean;
    procedure RefreshPromoItems;

    function HasPayment(IDPreSale : Integer):Boolean;
    function ValidateRefund(AQty: Double):Boolean;

    function CreateNewModel(Barcode : String):String;
    procedure SetSalesPerson;
    procedure AdjustSellingPrice(var ASellingPrice: Currency);
    function GetCustomerByInvoice(AInvoiceCode: String): Integer;

    procedure PrintReturnReceipt;

    procedure RefreshOverLoad(IsOverLoad : Boolean);

    procedure ResetDiscount(IDPreSale : Integer);

    function VerifyCustomerInLoyalty(IDCustomer : Integer) : Boolean;
    function BlockLayaway(AIdPreSale: integer): boolean;

    // Antonio 2013 Dec 9, promotion refactored ( under test )
    procedure ApplyPromotion(arg_saleItem: TSaleItem; arg_coupon: String; arg_isLoyalty: Boolean; arg_subTotalSale: Double);
    function getIdCommissionOnAskUserSale(
      arg_askUserOnSale: Boolean): Integer;
    function getIdUserOnAskUserSale(arg_askUserOnSale: Boolean): Integer;
    procedure setPriceManually(arg_isManually: Boolean; arg_sellingPrice: currency);

    procedure setPDCxStatusToRegistry(arg_section: String; arg_value: Integer);
    function loadPDCxStatusFromRegistry(arg_section: String): Integer;
    function initializePDCx(): Boolean;

    procedure FoundMediaFileParameter(argParameter: Boolean);

    // changed due the Bogo routines
    procedure RunSale();
    procedure prepareItemsToBogoObject(items: TDataset);
    procedure MountGetFreeItemsToBogoObject(items: TDataset; itemBuy: TBogoPromoDistribution);

    procedure doCommonSaleRoutine(quantity: double; isAutoInsert: boolean = false);
    procedure doSaleByAutoCaller(autoIdModel: integer; autoQuantity: double);
    procedure setSaleToBogo(isBogo: boolean);
    function getSaleToBogo(): boolean;
    procedure showBogoWarning(bogoDataset: TClientdataset; idModel: integer; messagePromo: string);
    function showBogoOrphansOnSale(saleDataset: TDataset; orphanFromSale: TDataset; orphanList: TObjectList): boolean;
    function isBogoBuyXFound(idModel: integer): boolean;
    function isBogoGetYFound(idDiscountPromo: integer; idModel: integer): boolean;
    procedure setLastPromoDiscount(value: integer);
    procedure createBogoBuyX(itemsBogo: TDataset);
    procedure createBogoGetY(itemsBogo: TDataset);
    procedure addToBogoGetYFreeList(itemsBogo: TDataset; bogoIdPreinv: integer);
    procedure addToBogoGetYDiscountList(itemsBogo: TDataset; bogoIdPreinv: integer);
    procedure addToBogoGetYOrphanList(itemsBogo: TDataset);
    function GetIdSalesFromBogoOrphans(orphanList: TObjectList): string;
    function RemoveBogoOrphansOnSale(orphanList: TObjectList): boolean;
    procedure SaveBogo(bogoDataset: TDataset; qtyComputedToDistribute: double);
    procedure SaveFreeBogoItems(qtyComputedToDistribute: double);
    procedure SaveDiscountBogoItems(qtyComputedToDistribute: double);
    function AddBogoBuyQtyToBogo(idModel: integer; idPromo: integer; isBuyX: boolean = true): TBogoPromoDistribution;
    procedure SearchForBogoGetItems(idPromo: integer; idModel: integer);

  protected
    IsLoyalty : Boolean;
    FSaleItem: TSaleItem;
    procedure OnExemptTaxClick(Sender : TObject); override;
    procedure LoadImages; override;
    procedure RefreshItem(PreInventMovID : Integer); override;
    procedure AfterReceivePayment(CloseSale : Boolean; pInfoCashSale:InfoCashSale = nil); override;
    procedure NewHold(IsLayway : Boolean = False); override;
    procedure OpenHold(IDPreSale : Integer); override;
    procedure CloseHold; override;
    procedure DeleteHold; override;
    procedure AfterRefreshInfo; override;
    function TestBeforeRemove:Boolean; override;
    procedure DisplayCustomer; override;
    procedure DisplayPetSKU; override;
  public
    function Start(PreSaleType, IDCashRegMov : Integer):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uMsgBox, uMsgConstant, uFrmUserMessager, MenuPrincipal,
     uQueryInventory, uPassword, uCashRegPetty, uCashRegWidraw, uCashRegClose,
     uSystemConst, uFrmMainPOSInfo, uFrmSearchCustomer, uInvoiceInfo,
     uFrmInventoryAdjust, uFrmModelQuickEntry, Math, uBonusBucks, uFrmAddKitItems,
     uPrintRepairStoreReceipt, uFrmAskSalesPerson, uFrmInvoiceRefund, uFrmPetSearch,
     uFrmStoreAccount, DateUtils, uDebugFunctions, ufrmModelAdd,
     RefundByItemWithoutInvoiceView, uccMercuryIntegration, registry, uOperationSystem,
     BogoWarningView, BogoWarningViewOrphans;


{$R *.dfm}

procedure TFrmMainPOS.SetPanel(iSaleOption: Integer);
begin
  FSaleOption := iSaleOption;
  pnlOrder.Visible    := False;
  pnlSaleInfo.Visible := False;
  pnlAdmin.Visible    := False;
  pnlItem.Visible     := False;

  case FSaleOption of
    SALE_OPTION_SALE  : pnlSaleInfo.Visible := True;
    SALE_OPTION_ORDER : pnlOrder.Visible    := True;
    SALE_OPTION_ADM   : pnlAdmin.Visible    := True;
    SALE_OPTION_ITEM  : pnlItem.Visible     := True;
  end;
end;

procedure TFrmMainPOS.FormShow(Sender: TObject);
begin
  // to keep correct boundary
  self.Top := 14;
//  self.Height := 920;
//  self.Width := 1262;

  IsLoyalty := False;

  SetPanel(SALE_OPTION_SALE);
  RefreshTime;
  RefreshUser;

  if (DM.fCashRegister.AskSalesPerson) then
    SetSalesPerson;

  RefreshOverLoad(DM.fPOS.GetTotalCashReceived(FInvoiceInfo.IDCashRegMov) > DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED]);
  initializeInvoiceLabelValues();

  // Antonio 04/04/2017, MR-20
  FoundMediaFileParameter(dm.fSystem.SrvParam[PARAM_ASK_MEDIA_FILES]);
end;

procedure TFrmMainPOS.XiButton4Click(Sender: TObject);
begin
  SetPanel(SALE_OPTION_ORDER);
end;

procedure TFrmMainPOS.XiButton5Click(Sender: TObject);
begin
  SetPanel(SALE_OPTION_ADM);
end;

procedure TFrmMainPOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //amfsouza 02.03.2011 - call inheritence to display form's name.
  inherited;

  case Key of
    VK_MENU    : SetPanel(SALE_OPTION_ADM);   //Alt
    VK_SHIFT   : SetPanel(SALE_OPTION_ORDER); //Shift
    VK_CONTROL : SetPanel(SALE_OPTION_ITEM);  //Crtl
    VK_ESCAPE  : SetPanel(SALE_OPTION_SALE);  //Esc
    VK_F11     : Close;
    VK_F12     : OnProcesseSaleClick(Self);
    else CallFunction(Key);
  end;
    //if (Key in [#13, #27]) then
    //Key := #0; //This will prevent the beep
end;

procedure TFrmMainPOS.RefreshTime;
begin
  lbTime.Caption := FormatDateTime('hh:mm AM/PM', Now);
end;

procedure TFrmMainPOS.RefreshUser;
begin
  lbUserName.Caption := DM.fUser.UserName;
end;

procedure TFrmMainPOS.OnChangeUserClick(Sender: TObject);
begin
  inherited;
  RefreshUser;
end;

procedure TFrmMainPOS.quPreSaleInfoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbTransaction.Caption := quPreSaleInfoSaleCode.AsString;
  lbInvoiceDate.Caption := FormatDateTime('ddddd hh:mm AM/PM', quPreSaleInfoPreSaleDate.AsDateTime);
  RefreshCustomer;
end;

function TFrmMainPOS.Start(PreSaleType, IDCashRegMov: Integer): Boolean;
var
  AOptions: TcxGridStorageOptions;
  ASaveViewName : String;
begin
  FUserValidate := False;
  FInvoiceInfo.PreSaleType   := PreSaleType;
  FInvoiceInfo.IDCashRegMov  := IDCashRegMov;

  CloseHold;
  NewHold;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  FUserValidate := True;

  // dataset with buy and gets to current promos
  cdsBogo := dm.getCurrentPromoDetails();
  FPromoBogoList := TObjectList.Create(true);
  FOrphanList := TObjectList.Create(true);
  //prepareItemsToBogoObject(cdsBogo);

  Result := (ShowModal = mrOK);

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

  //amfsouza 05.19.2011
  dtData := dm.GetServerDate;

end;

procedure TFrmMainPOS.LoadImages;
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_ADD, btnAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btnEdit.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btnRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btnColumn.Glyph);
end;

procedure TFrmMainPOS.btnMessageClick(Sender: TObject);
begin
  inherited;
  if DM.fUser.ID <> -1 then
    with TFrmUserMessager.Create(Self) do
      Start;
end;

procedure TFrmMainPOS.CallMenuItem(IDMenu, IDSubMenu: Integer);
var
  fImgOld : Integer;
  fsMenu,
  fsSubMenu : String;
begin
  try
    fImgOld   := DM.fMainMenu.Image;
    fsMenu    := DM.fMainMenu.MenuName;
    fsSubMenu := DM.fMainMenu.SubMenuName;

    MainMenu.IDMenu    := IDMenu;
    MainMenu.IDSubMenu := IDSubMenu;
    MainMenu.SubMenuClick(nil);
  finally
    MainMenu.IDMenu         := 1;
    MainMenu.IDSubMenu      := 1;
    DM.fMainMenu.Image      := fImgOld;
    DM.fMainMenu.MenuName   := fsMenu;
    DM.fMainMenu.SubMenuName:= fsSubMenu;
  end;
end;

procedure TFrmMainPOS.FormCreate(Sender: TObject);
begin
  inherited;

  FSaleItem := TSaleItem.Create;

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL  := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];

  AView := TcxCustomGridTableView(grdItems.FocusedView);

  SubListImage.CreateSubList;
  SubListFeatures.CreateSubList;
  SubCustomer.CreateSubList;
  ClearItemImage;
  ClearItemFeatures;

  AFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  // initialize DPCx
  if ( loadPDCxStatusFromRegistry('ProcessType') = PROCESSING_TYPE_DSIPDCX ) then begin
     initializePDCx();
  end;

  setSaleToBogo(false);

end;

procedure TFrmMainPOS.ClearItemImage;
begin
  SubListImage.Param := 'IDModel=0;ShowOpen=0;BackColor=$00DFDFDF;StartImage='+DM.fInvoice.XpressSaleImage+';';
end;

procedure TFrmMainPOS.dsPreSaleItemDataChange(Sender: TObject; Field: TField);
var
  CanEnable : Boolean;
begin
  inherited;
  CanEnable               := not (spquPreSaleItem.Bof and spquPreSaleItem.Eof);
  btnSerialNumber.Enabled := CanEnable and spquPreSaleItemSerialNumber.AsBoolean;

  btnEdit.Enabled := spquPreSaleItemModelID.AsString <> '';
  btnRemove.Enabled := btnEdit.Enabled;
  btnCommission.Enabled := btnEdit.Enabled;

  if (spquPreSaleItemModelID.AsString <> '') then
  begin
    SubListImage.Param := 'IDModel='+spquPreSaleItemModelID.AsString+';ShowOpen=0;BackColor=$00DFDFDF;StartImage=;Stretch=T;';
    SubListFeatures.Param := 'IDModel='+spquPreSaleItemModelID.AsString+';BackColor=$00DFDFDF;';
  end;
end;

procedure TFrmMainPOS.ClearItemFeatures;
begin
  SubListFeatures.Param := 'IDModel=0;ShowOpen=0;BackColor=$00DFDFDF;';
end;

procedure TFrmMainPOS.btnTimeClockClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(9,2);
end;

procedure TFrmMainPOS.btnHelpClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(9,1);
end;

procedure TFrmMainPOS.RefreshCrossSale;
begin
  CloseCrossSale;
  OpenCrossSale;
end;

procedure TFrmMainPOS.CloseCrossSale;
begin
  with quCrossSale do
    if Active then
      Close;
end;

procedure TFrmMainPOS.OpenCrossSale;
begin
  with quCrossSale do
    if not Active then
    begin
      Parameters.ParamByName('IDPreSale').Value := FInvoiceInfo.IDPreSale;
      Parameters.ParamByName('IDStore').Value   := DM.fStore.ID;
      Open;
      grdCrossSale.Visible := (not IsEmpty);
    end;
end;

procedure TFrmMainPOS.RefreshItem(PreInventMovID: Integer);
begin
  inherited;
  RefreshCrossSale;
end;

procedure TFrmMainPOS.quCrossSaleCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quCrossSaleStoreCostPrice.AsCurrency <> 0 then
    quCrossSaleACostPrice.AsCurrency := quCrossSaleStoreCostPrice.AsCurrency
  else
    quCrossSaleACostPrice.AsCurrency := quCrossSaleFinalCost.AsCurrency;

  if quCrossSaleStoreSellingPrice.AsCurrency <> 0 then
    quCrossSaleASalePrice.AsCurrency := quCrossSaleStoreSellingPrice.AsCurrency
  else
    quCrossSaleASalePrice.AsCurrency := quCrossSaleSellingPrice.AsCurrency;

  if quCrossSaleStoreAvgPrice.AsCurrency <> 0 then
    quCrossSaleAAvgCost.AsCurrency := quCrossSaleStoreAvgPrice.AsCurrency
  else
    quCrossSaleAAvgCost.AsCurrency := quCrossSaleAvgCost.AsCurrency;
end;

procedure TFrmMainPOS.btnSaleClick(Sender: TObject);
begin
  inherited;
  FReturn := false;
  SetPanel(SALE_OPTION_SALE);
end;

procedure TFrmMainPOS.btnItemClick(Sender: TObject);
begin
  inherited;
  SetPanel(SALE_OPTION_ITEM);
end;

procedure TFrmMainPOS.AfterReceivePayment(CloseSale : Boolean; pInfoCashSale:InfoCashSale = nil);
var
   qrySaleInCashRegister: TADOQuery;
begin

  DM.FTraceControl.TraceIn('TFrmMainPOS.AfterReceivePayment');

  try
    RefreshInfo;
    FInvoiceInfo.IDInvoice := quPreSaleInfoIDInvoice.AsInteger;
    CloseHold;
    if (FInvoiceInfo.IDInvoice <> 0) then
    begin
      // amfsouza 09.01.2011 - only if store has a PuppyTracker integration
      if ( dm.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] = 'True' ) then begin

         qrySaleInCashRegister := getSalesInCashRegister(FInvoiceInfo.IDPreSale);
         qrySaleInCashRegister.First;
         while ( not qrySaleInCashRegister.Eof ) do begin
             //amfsouza 02.29.2012 - test if is a puppy.
             if ( dm.verifyPuppyInPetCategory(qrySaleInCashRegister.fieldbyName('ModelID').AsInteger) ) then begin
                CallPuppyTracker( (qrySaleInCashRegister.FieldByName('qty').AsInteger < 0) );
                break;
             end;
             qrySaleInCashRegister.Next;
         end;
         freeAndNil(qrySaleInCashRegister);
      end;

      PrintReturnReceipt;
      FCountPuppies := 0; 
    end;
    inherited;
    NewHold;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmMainPOS');
  end;

  RefreshOverLoad(DM.fPOS.GetTotalCashReceived(FInvoiceInfo.IDCashRegMov) > DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED]);

  DM.FTraceControl.TraceOut;

end;

procedure TFrmMainPOS.NewHold(IsLayway : Boolean = False);
begin
  Password.PermanentLogOn := False;


  if FUserValidate then
  begin
    if not FClosingPressed then
      while not Password.Start(1, 1) do
      begin
      end;

    if (DM.fCashRegister.AskSalesPerson) then
      SetSalesPerson;

    if edtBarcode.CanFocus then
      edtBarcode.SetFocus;
  end;

  inherited;
  ClearItemImage;
  ClearItemFeatures;
  ClearCustomer;
  FReturn                := False;
  pnlInvoiceScan.Visible := False;
  FClosingPressed        := False;
  pnlCupom.Visible       := FApplyPromoOnSale;
  edtCupom.Clear;
  RefreshUser;
  
end;

procedure TFrmMainPOS.ClearCustomer;
begin
  SubCustomer.Param := 'IDCUSTOMER=0;DisplayType=R;BackColor=clWhite;';
end;

procedure TFrmMainPOS.SetSalesPerson;
begin
  DM.fPOS.ClearDefaultSalesPerson;
  SetDefaultSalesPerson;
end;

procedure TFrmMainPOS.RefreshCustomer;
begin
  SubCustomer.Param := Format('IDCUSTOMER=%S;DisplayType=R;BackColor=clWhite;', [quPreSaleInfoIDCustomer.AsString]);
end;

function TFrmMainPOS.SearchCustomerCard(CustomerCard: String):Boolean;
var
  spItems: TADOStoredProc;
begin

  Result := False;

  if Trim(CustomerCard) = '' then
    Exit;

  with quCustomerCard do
  begin
    if Active then
      Close;
    Parameters.ParamByName('CustomerCard').Value := CustomerCard;
    Open;
    try
      if not IsEmpty then
      begin
        Result := True;
        quPreSaleInfo.Edit;
        quPreSaleInfoIDCustomer.AsInteger := quCustomerCardIDPessoa.AsInteger;
        quPreSaleInfo.Post;
        SetCustomer(quCustomerCardIDPessoa.AsInteger);

        IsLoyalty := VerifyCustomerInLoyalty(quCustomerCardIDPessoa.AsInteger);
        result := isLoyalty;

        if ( isLoyalty ) then begin
           spItems := TADOStoredProc.Create(nil);
           spItems.Connection := dm.ADODBConnect;

           spItems := spquPreSaleItem;

           while ( not spItems.Eof ) do begin
               fillSaleItem(0);
               fsaleItem.Qty := spquPreSaleItemQty.Value;
               FSaleItem.IDModel := spquPreSaleItemModelID.Value;
               FSaleItem.IDPreInventoryMov := spquPreSaleItemIDInventoryMov.Value;
               FSaleItem.Add();
               spItems.Next();
           end;

            //RefreshItem(0);
            freeAndNil(spItems);
        end;


      end;
    finally
      Close;
    end;
  end;
end;

procedure TFrmMainPOS.edtLoyaltyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN) then
  begin
    SearchCustomerCard(edtLoyalty.Text);
    edtLoyalty.Clear;
  end;
end;


procedure TFrmMainPOS.btnPrettyCashClick(Sender: TObject);
begin
  inherited;
  RefreshOverLoad(False);

  if ValidatePettyCash then
     if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     begin
       with TCashRegPetty.Create(Self) do
         Start(FInvoiceInfo.IDCashRegMov, OP_PETTY_CASH);
     end;

   RefreshOverLoad(DM.fPOS.GetTotalCashReceived(FInvoiceInfo.IDCashRegMov) > DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED]);

end;

function TFrmMainPOS.ValidateCloseRegister: Boolean;
begin
  Result := True;

  if not Password.HasFuncRight(59) then
  begin
    MsgBox(MSG_CRT_NO_CLOSE_CASH_REGISTER, vbCritical + vbOkOnly);
    Result := False;
    Exit;
  end;
end;

function TFrmMainPOS.ValidatePettyCash: Boolean;
begin
  Result := True;

  if not Password.HasFuncRight(61) then
  begin
    MsgBox(MSG_CRT_NO_MAKE_PETTY_CASH, vbCritical + vbOkOnly);
    Result := False;
    Exit;
  end;
end;

function TFrmMainPOS.ValidateWithdraw: Boolean;
begin
  Result := True;

  if not Password.HasFuncRight(60) then
  begin
    MsgBox(MSG_CRT_NO_MAKE_DEPOSIT, vbCritical + vbOkOnly);
    Result := False;
    Exit;
  end;
end;

procedure TFrmMainPOS.btnWithdrawClick(Sender: TObject);
begin
  inherited;

  RefreshOverLoad(False);

  if ValidateWithdraw then
    if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
    begin
      with TCashRegWidraw.Create(Self) do
        Start(FInvoiceInfo.IDCashRegMov);
    end;

  RefreshOverLoad(DM.fPOS.GetTotalCashReceived(FInvoiceInfo.IDCashRegMov) > DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED]);

end;

procedure TFrmMainPOS.btnCloseRegisterClick(Sender: TObject);
var
  IDCashRegister : integer;
begin
  inherited;

  RefreshOverLoad(False);

  if ValidateCloseRegister then
    if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
    begin
      with TCashRegClose.Create(Self) do
      begin
        Start(FInvoiceInfo.IDCashRegMov, DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE]);
          if (DM.CheckCashRegState(DM.fCashRegister.IDDefault, IDCashRegister) = CASHREG_CLOSE) then begin
            //amfsouza September 11, 2012 - reset cash register to close.
            dm.setCashRegister(DM.fCashRegister.IDDefault, false);
            //dm.cdsPreserialMov := free;
            dm.cdsPreserialMov := nil;
            Self.Close;
          end;
      end;
    end;

  RefreshOverLoad(DM.fPOS.GetTotalCashReceived(FInvoiceInfo.IDCashRegMov) > DM.fSystem.SrvParam[PARAM_MAXCASHALLOWED]);

end;

procedure TFrmMainPOS.btnNewHoldClick(Sender: TObject);
begin
  inherited;
  CloseHold;
  NewHold;
end;

procedure TFrmMainPOS.btnLayawayClick(Sender: TObject);
begin
  inherited;
  CloseHold;
  NewHold(True);
end;

procedure TFrmMainPOS.btnInvHistoryClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(1,3);
end;

procedure TFrmMainPOS.btnViewInventoryClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(2,2);
end;

procedure TFrmMainPOS.btnAditionalClick(Sender: TObject);
var
  totalDiscountToPolleDisplay: Currency;
begin
  inherited;
  if not EmptyHold then
  begin
    with TFrmMainPOSInfo.Create(Self) do
      Start(quPreSaleInfo, spquPreSaleValue, TAB_ALL);

    // Antonio July 02, 2013
    dm.fpos.RecalcTax(quPreSaleInfoIDPreSale.Value, now);

    RefreshHold;
    RefreshValue;

    // Antonio 2104 Jun 03
    treatInvoiceTotals();

    //PollDisplay

    //amfsouza May 29, 2012
    if ( spquPreSaleValueInvoiceDiscount.Value > 0 ) then
       totalDiscountToPolleDisplay := spquPreSaleValueItemDiscount.Value +
                 spquPreSaleValueInvoiceDiscount.Value
    else totalDiscountToPolleDisplay := spquPreSaleValueTotalDiscount.Value;

    DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                          Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                          spquPreSaleValueAditionalExpenses.AsCurrency,
                          totalDiscountToPolleDisplay, // amfsouza May 29, 2012 spquPreSaleValueTotalDiscount.AsCurrency,
                          spquPreSaleValueTax.AsCurrency,
                          spquPreSaleValueSubTotal.AsCurrency,
                          True);
  end;
end;

procedure TFrmMainPOS.btnCustomerClick(Sender: TObject);
var
  iIDCustomer: Integer;
begin
  inherited;
  with TFrmSearchCustomer.Create(Self) do
    iIDCustomer := Start;

  SetCustomer(iIDCustomer);

  IsLoyalty := VerifyCustomerInLoyalty(iIDCustomer);

  FSaleItem.IDCustomer := iIDCustomer;

end;

//YAA (April 25, 2012): Added for testing purposes, but not used for now
function DigestSequentialBarcodes(aBarcodesSequence: string): string;
var
  BarcodeList: TStringList;
begin
  BarcodeList:= TStringList.Create;
  try
    aBarcodesSequence:= StringReplace(aBarcodesSequence, #10, '', [rfReplaceAll]);
    BarcodeList:= TStringList.Create;
    BarcodeList.Delimiter:= #13;
    BarcodeList.DelimitedText:= aBarcodesSequence;
    if BarcodeList.Count > 0 then
      Result:= StringReplace(BarcodeList[0], #13, '', [rfReplaceAll]);
  finally
    BarcodeList.Free;
  end;
end;

procedure TFrmMainPOS.edtBarcodeAfterSearchBarcode(Sender: TObject);
var idModel: integer;
    quantity: double;
    bogoGetQtyComputed: double;
    idPromoDiscount: integer;
    isBogoBuyFound: boolean;
    isBogoGetFound: boolean;
    bogoPreinventoryMov: integer;
    bogoDiscount: currency;
begin
 (* I have to review BOGO distribution seems even the quantities distribution are correct, the discount are not,
    due the quantity not be multiplied with discount and this seems affect the combine lines *)

  isBogoBuyFound := false;
  isBogoGetFound := false;
  try
     idModel := edtBarcode.GetFieldValue('IdModel');
  except
     MsgBox(MSG_INF_BARCODE_NOT_FOUND, vbCritical + vbOkOnly);
     edtBarcode.SetFocus;
     exit;
  end;

  // search for BuyX in BuyX models promo if not found tries to found GetY in GetY promo.
  if ( isBogoBuyXFound(idModel) ) then begin
     isBogoBuyFound := true;
  end else begin
          cdsBogo.Filter := 'IdModel = ' + IntToStr(idModel) + ' and BOGO = ' + QuotedStr('Get');
          cdsBogo.Filtered := true;

          if ( not cdsBogo.fieldByName('IdDiscount').IsNull ) then begin
              if ( isBogoGetYFound(cdsBogo.fieldByName('IdDiscount').Value, idModel) ) then begin
                isBogoGetFound := true;
              end else begin
                      isBogoGetFound := false;
                  end;
          end;
      end;

  runSale();

  // Means that did not find get first but found in get
  if ( isBogoGetFound ) then begin
       // if not found in freelist and not found in discountlist, that's why is an orphan
       addToBogoGetYOrphanList(cdsBogo);
  end;

  quantity := FSaleItem.Qty;

  if ( isBogoBuyFound ) then begin
        createBogoBuyX(cdsBogo);
        setSaleToBogo(true);

        if ( quantity >= cdsBogo.FieldByName('MinQuantity').Value ) then begin
            bogoGetQtyComputed := FPromoBogo.getTotalQtyBogoGet(quantity, cdsBogo.FieldByName('MinQuantity').Value, cdsBogo.fieldByName('RewardQuantity').Value);
            SearchForBogoGetItems(cdsBogo.FieldByName('IdDiscount').Value, idModel);
            SaveBogo(cdsBogo, bogoGetQtyComputed);
        end else begin
               FPromoBogo :=  AddBogoBuyQtyToBogo(cdsBogo.fieldByName('IdModel').Value,
                                   cdsBogo.fieldByName('IdDiscount').Value,
                                   (cdsBogo.fieldByName('BOGO').Value = 'Buy')
                                   );

               if ( fPromoBogo.TotalBuy >= cdsBogo.FieldByName('MinQuantity').Value ) then begin
                  bogoGetQtyComputed := FPromoBogo.getTotalQtyBogoGet(fPromoBogo.TotalBuy, cdsBogo.FieldByName('MinQuantity').Value, cdsBogo.fieldByName('RewardQuantity').Value);
                  SearchForBogoGetItems(cdsBogo.FieldByName('IdDiscount').Value, idModel);
                  SaveBogo(cdsBogo, bogoGetQtyComputed);
                  FPromoBogo.TotalBuy := 0;
               end;

            end
  end;

end;

procedure TFrmMainPOS.doSaleByAutoCaller(autoIdModel: integer;
  autoQuantity: double);
begin
  FSaleItem.IDModel := autoIdModel;
//  FSaleItem.ManualDiscount :=
  doCommonSaleRoutine(autoQuantity, true);
end;

procedure TFrmMainPOS.AdjustSellingPrice(var ASellingPrice: Currency);
begin
  try
    FAskPrice := TFrmAskPrice.Create(Self);
    ASellingPrice := -1;

    while (ASellingPrice < 0) do
    begin
      ASellingPrice := FAskPrice.Start(edtBarcode.GetFieldValue('Model'), edtBarcode.GetFieldValue('Description'));

      setPriceManually(true, AsellingPrice);

      if  ASellingPrice < 0 then
        MsgBox(MSG_INF_PRICE_INVALID, vbCritical + vbOKOnly)
    end;
  finally
    FreeAndNil(FAskPrice);
  end;
end;

procedure TFrmMainPOS.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FSaleItem);
end;

procedure TFrmMainPOS.CallFunction(Key: Word);
begin
  case Key of
    VK_F1:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnCustomerClick(Self);
        SALE_OPTION_ORDER : btnNewHoldClick(Self);
        SALE_OPTION_ADM   : btnCloseRegisterClick(Self);
        SALE_OPTION_ITEM  : btnItemRepairClick(Self);
      end;
    end;

    VK_F2:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnViewInventoryClick(Self);
        SALE_OPTION_ORDER : btnLayawayClick(Self);
        SALE_OPTION_ADM   : btnWithdrawClick(Self);
        SALE_OPTION_ITEM  : btnGiftCardClick(Self);
      end;
    end;

    VK_F3:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnAditionalClick(Self);
        SALE_OPTION_ORDER : OnOpenHoldClick(Self);
        SALE_OPTION_ADM   : btnPrettyCashClick(Self);
        SALE_OPTION_ITEM  : btnAdjustClick(Self);
      end;
    end;

    VK_F4:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnReturnClick(Self);
        SALE_OPTION_ORDER : btnInvHistoryClick(Self);
        SALE_OPTION_ADM   : btnNoSaleClick(Self);
        SALE_OPTION_ITEM  : ;
      end;
    end;

    VK_F5:
    begin
      case FSaleOption of
        // Antonio 2013 Oct 25, SALE_OPTION_SALE  : OnShowPaymentsClick(Self);
        SAlE_OPTION_SALE  : OnExemptTaxClick(Self);
        SALE_OPTION_ORDER : btnStoreAccountClick(Self);
        SALE_OPTION_ADM   : ;
        SALE_OPTION_ITEM  : ;
      end;
      end;

    VK_F6:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : OnHoldPrintClick(Self);
        SALE_OPTION_ORDER : ;
        SALE_OPTION_ADM   : ;
        SALE_OPTION_ITEM  : ;
      end;
    end;

    VK_F7:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnRTVClick(Self);
        SALE_OPTION_ORDER : ;
        SALE_OPTION_ADM   : ;
        SALE_OPTION_ITEM  : ;
      end;
    end;

    VK_F8:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnSearchModelClick(Self);
        SALE_OPTION_ORDER : ;
        SALE_OPTION_ADM   : ;
        SALE_OPTION_ITEM  : ;
      end;
    end;

    VK_F9:
    begin
      case FSaleOption of
        SALE_OPTION_SALE  : btnSearchModelClick(Self);
        SALE_OPTION_ORDER : ;
        SALE_OPTION_ADM   : ;
        SALE_OPTION_ITEM  : ;
      end;
    end;

  end;
end;

procedure TFrmMainPOS.btnReturnClick(Sender: TObject);
begin
  inherited;

  if quPreSaleInfo.Active and (spquPreSaleItem.RecordCount >= 0) and (quPreSaleInfoLayaway.Value) then
  begin
    MsgBox(MSG_INF_START_NEW_SALE_FOR_REFUND, vbCritical + vbOkOnly);
    Exit;
  end;

  pnlInvoiceScan.Visible := True;
  pnlCupom.Visible := False;
  edtInvoiceSearch.Clear;
  edtBarcode.Color := $00C4C4FF;
  shBarcode.Pen.Color := clRed;
  FReturn := True;
  lbLayaway.Visible := False;
  edtInvoiceSearch.SetFocus;
end;

procedure TFrmMainPOS.edtBarcodeBeforeSearchBarcode(Sender: TObject);
begin
  inherited;

  edtBarcode.SetParameterValue('IDStore', DM.fStore.ID);

//  if FReturn and (quPreSaleInfoIDCustomer.AsInteger = 1) then // ??

end;

procedure TFrmMainPOS.edtInvoiceSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (key = VK_RETURN) then
  begin
    if (Trim(edtInvoiceSearch.Text) <> '') and (ValidateRefund(-1)) then
    begin
      //if quPreSaleInfoIDCustomer.AsInteger = 1 then
      SetCustomer(GetCustomerByInvoice(Trim(edtInvoiceSearch.Text)));

      if quPreSaleInfoIDCustomer.AsInteger = 1 then
        btnCustomerClick(Sender);

      if quPreSaleInfoIDCustomer.AsInteger = 1 then
        Exit;

      if ( not FindInvoiceRefund(Trim(edtInvoiceSearch.Text)) ) then begin
          edtInvoiceSearch.Clear;
          edtInvoiceSearch.setfocus;
          exit;
      end;

      edtInvoiceSearch.Clear;

      // Antonio 2014 May 30
      RefreshHold;
      RefreshValue;
      treatInvoiceTotals();
    end;
  end;
end;

procedure TFrmMainPOS.btnItemRepairClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(2,5);
end;

procedure TFrmMainPOS.btnGiftCardClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(2, 8);
end;

procedure TFrmMainPOS.btnAdjustClick(Sender: TObject);
begin
  inherited;
  with TFrmInventoryAdjust.Create(Self) do
    Start(INV_TYPE_NONE);
end;

procedure TFrmMainPOS.btnRTVClick(Sender: TObject);
begin
  inherited;
  CallMenuItem(5,7);
end;

procedure TFrmMainPOS.RefreshPromoItems;
var
  i : Integer;
  DiscountSaleValue: Double;
begin
  with spquPreSaleItem do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if not FieldByName('Promo').AsBoolean then
      begin
        FSaleItem.IDPreSale := spquPreSaleItemIDInventoryMov.AsInteger;
        FSaleItem.IDModel   := spquPreSaleItemModelID.AsInteger;
        FSaleItem.Qty       := spquPreSaleItemQty.AsFloat;
      end;
      Next;
    end;
  finally
    EnableControls;
  end;
end;

procedure TFrmMainPOS.OpenHold(IDPreSale: Integer);
begin
  inherited;
  // to fix totals to open holds and layaway
  treatInvoiceTotals();
end;

procedure TFrmMainPOS.CloseHold;
begin
  CloseUsedBonus;

  if ((not EmptyHold) and (FInvoiceInfo.IDInvoice = 0)) then
    if ((FInvoiceInfo.IsNewHold and (not FInvoiceInfo.Layaway)) or
       (FInvoiceInfo.IsNewHold and FInvoiceInfo.Layaway and (DM.fPOS.GetInvoicePayments(FInvoiceInfo.IDPreSale)=0) ) ) then begin
      //amfsouza 03.11.2011 - if quote or onhold already pressed.
      if ( not FOnHoldSigned ) then
          if MsgBox(MSG_QST_CONFIRM_HOLD, vbQuestion + vbYesNo) = vbYes then
               ClearHoldItems;
    end;
  inherited;

  //Poll Display
  DM.PollDisplayCloseSale;

end;

procedure TFrmMainPOS.dsPreSaleInfoStateChange(Sender: TObject);
begin
  inherited;
  btnAdd.Enabled := quPreSaleInfo.Active;
end;

procedure TFrmMainPOS.btnNoSaleClick(Sender: TObject);
var
  iIDUser: Integer;
begin
  inherited;
  if Password.AquireAccess(65, MSG_CRT_NO_ACCESS, iIDUser, True) then
    DM.OpenCashRegister(DRAW_KICK_TYPO_NO_SALE);
end;

procedure TFrmMainPOS.AfterRefreshInfo;
begin
  inherited;

  if FInvoiceInfo.Layaway then
  begin
    lbLayaway.Visible   := True;
    edtBarcode.Color    := $00D9FFD9;
    shBarcode.Pen.Color := clGreen;
  end
  else
  begin
    lbLayaway.Visible   := False;
    edtBarcode.Color    := $00F8E1DC;
    shBarcode.Pen.Color := $00D2771C;
  end;

end;

function TFrmMainPOS.TestBeforeRemove: Boolean;
begin

  Result := False;

  if FInvoiceInfo.Layaway then
    if (spquPreSaleItem.RecordCount = 1) and (HasPayment(FInvoiceInfo.IDPreSale)) then
    begin
      MsgBox(MSG_INF_NOT_DEL_LAST_ITEM_LAYAWAY, vbCritical + vbOkOnly);
      Exit;
    end;

  Result := Inherited TestBeforeRemove;

end;

function TFrmMainPOS.HasPayment(IDPreSale : Integer): Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT IDLancamento FROM  Fin_Lancamento');
    SQL.Add('WHERE IDPreSale = ' + IntToStr(IDPreSale));
    try
      Open;
      Result := (RecordCount > 0);
    finally
      Close;
      end;
  end;
end;

function TFrmMainPOS.CreateNewModel(Barcode : String): String;
var
  //amfsouza August 21, 2012-   FFrmModelQuickEntry : TFrmModelQuickEntry;
  FFrmModelQuickEntry : TFrmModelAdd;
  ABarcode : TBarcode;
begin
  try
    Result := '';
    //amfsouza August 21, 2012
    //FFrmModelQuickEntry := TFrmModelQuickEntry.Create(Self);
    FFrmModelQuickEntry := TfrmModelAdd.create(self);
    ABarcode := FFrmModelQuickEntry.Start(False, True, True, Barcode);
    if VarToStr(ABarcode.IDBarcode) <> '' then
      Result := ABarcode.IDBarcode
    else if ABarcode.Model.Model <> '' then
      Result := ABarcode.Model.Model;
  finally
    FreeAndNil(FFrmModelQuickEntry);
    end;
end;

procedure TFrmMainPOS.btnColumnClick(Sender: TObject);
begin
  inherited;

  TcxGridDBTableView(AView).Controller.Customization := not
                  TcxGridDBTableView(AView).Controller.Customization;

end;

procedure TFrmMainPOS.edtCupomKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (key = VK_RETURN) then begin
     if ( Pos(BONUS_BUCKS_PREFIX, Trim(edtCupom.Text)) ) = 1 then begin
        ApplyBonusBucks(edtCupom.Text);
        edtCupom.Clear;
     end;   
     {
     end else if ( FApplyPromoOnSale ) then begin
             FCoupon := Trim(edtCupom.Text);
             // call sp cupom_upsert
             dm.callSpCouponUpsert(FInvoiceInfo.IDPreSale, FCoupon);
             edtCupom.Clear;
         end;}
  end;

end;

procedure TFrmMainPOS.DeleteHold;
begin
  inherited;
end;

function TFrmMainPOS.ValidateRefund(AQty: Double): Boolean;
begin
  Result := False;

  if (AQty < 0) and (not Password.HasFuncRight(31)) then
  begin
    MsgBox(MSG_INF_NOT_REFUND_ITEM, vbOKOnly + vbInformation);
    Exit;
  end;

  Result := True;
end;

function TFrmMainPOS.GetCustomerByInvoice(AInvoiceCode: String): Integer;
begin
  Result := -1;

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Text := 'SELECT IDCustomer FROM Invoice WHERE InvoiceCode = :InvoiceCode AND IDStore = :IDStore';
    Parameters.ParamByName('InvoiceCode').Value := AInvoiceCode;
    Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
    Open;

    if not IsEmpty then
      Result := FieldByName('IDCustomer').AsInteger;
  finally
    Close;
  end;
end;

procedure TFrmMainPOS.PrintReturnReceipt;
var
  RepairItem : TRepairReceipt;
  RepairList : TStringList;
begin
  if (FInvoiceInfo.IDInvoice <> 0) and (DM.fPrintReceipt.PrintReceipt) then
  try
    try
      if quItemsRepair.Active then
        quItemsRepair.Close;
      quItemsRepair.Parameters.ParamByName('IDInvoice').Value := FInvoiceInfo.IDInvoice;
      quItemsRepair.Open;
      if not quItemsRepair.IsEmpty then
      try
        quItemsRepair.First;
        RepairList := TStringList.Create;
        while not quItemsRepair.EOF do
        begin
          RepairItem              := TRepairReceipt.Create;
          RepairItem.RepairNumber := quItemsRepair.FieldByName('RA').AsString;
          RepairItem.Obs          := quItemsRepair.FieldByName('Obs').AsString;
          RepairItem.Model        := quItemsRepair.FieldByName('Model').AsString;
          RepairItem.Description  := quItemsRepair.FieldByName('Description').AsString;
          RepairItem.RecDate      := quItemsRepair.FieldByName('RepairDate').AsDateTime;
          RepairItem.Qty          := quItemsRepair.FieldByName('QtyRepair').AsFloat;
          RepairItem.ReturnedBy   := quItemsRepair.FieldByName('SystemUser').AsString;
          RepairItem.Vendor       := quItemsRepair.FieldByName('Vendor').AsString;
          RepairItem.DefectType   := quItemsRepair.FieldByName('DefectType').AsString;
          RepairItem.Store        := quItemsRepair.FieldByName('Store').AsString;
          RepairList.AddObject('', RepairItem);
          quItemsRepair.Next;
        end;

        with TPrintRepairStoreReceipt.Create(Self) do
          Start(RepairList);

      finally
        while (RepairList.Count > 0) do
        begin
          RepairItem := TRepairReceipt(RepairList.Objects[0]);
          FreeAndNil(RepairItem);
          RepairList.Delete(0);
        end;
        FreeAndNil(RepairList);
        end;
    except
       raise;
       end;
  finally
    quItemsRepair.Close;
    end;


end;

procedure TFrmMainPOS.tmrOverLoadTimer(Sender: TObject);
begin
  inherited;
  pnlOverLoad.Visible := FIsOverLoad;

  if FIsOverLoad then
  begin
    MessageBeep(0);
    if lblCashOverLoad.Font.Color = clMaroon then
    begin
      lblCashOverLoad.Font.Color := clRed;
      lblOverLoad.Font.Color     := clRed;
      pnlOverLoad.Color          := clMaroon;
    end
    else
    begin
      lblCashOverLoad.Font.Color := clMaroon;
      lblOverLoad.Font.Color     := clMaroon;
      pnlOverLoad.Color          := clBlack;
    end;
  end;

end;

procedure TFrmMainPOS.RefreshOverLoad(IsOverLoad: Boolean);
begin
  FIsOverLoad := IsOverLoad;
  tmrOverLoadTimer(nil);
end;

procedure TFrmMainPOS.btnCancelClick(Sender: TObject);
var
  lbIsMediaEmpty: Boolean;
begin

  lbIsMediaEmpty := ( scMedia.LookUpValue = '' );

  inherited;

  FClosingPressed := True;
  //amfsouza 10.06.2011 - reset puppy counter
  FCountPuppies := 0;

  //amfsouza September 10, 2012
  dm.fPOS.cdsPriceBreak.EmptyDataSet;

  OnCancelClick(Self);
  initializeInvoiceLabelValues();

  // Antonio 2014 Jun 03
  edtBarcode.Clear;

  //amfsouza September 11, 2012
  dm.setCashRegister(dm.fCashRegister.IDDefault, false);

  // Antonio 2014 Jan 28, MR-160
  if ( objInfoCashSale <> nil ) then
      objInfoCashSale.setTotalSaved(0.00);

  //  MR-20
  FoundMediaFileParameter(dm.fSystem.SrvParam[PARAM_ASK_MEDIA_FILES]);
  setSaleToBogo(false);

end;

procedure TFrmMainPOS.btnSearchModelClick(Sender: TObject);
var
  R : String;
  fRunSecondSQL : Boolean;
begin
  inherited;
  R := AFrmBarcodeSearch.StartModel(MOV_TYPE_SALE);
  if R <> '' then
  try
    fRunSecondSQL := edtBarcode.RunSecondSQL;
    edtBarcode.Text := edtBarcode.Text + R;
    edtBarcode.SearchBarcode;
  finally
    edtBarcode.RunSecondSQL := fRunSecondSQL;
    end;
end;

procedure TFrmMainPOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  AFrmBarcodeSearch.Free;

  // release memory back to the system
  if ( FPromoBogoList <> nil ) then begin
     FreeAndNil(FPromoBogoList);
  end;

  if ( FOrphanList <> nil ) then begin
     FreeAndNil(FOrphanList);
  end;

  if ( cdsBogo <> nil ) then begin
     cdsBogo.Close();
     freeAndnil(cdsBogo);
  end;





end;

procedure TFrmMainPOS.edtBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) and (edtBarcode.Text = '') and (not spquPreSaleItem.IsEmpty) then
    OnProcesseSaleClick(Self);

end;

procedure TFrmMainPOS.DisplayCustomer;
begin
  inherited;
  btnCustomerClick(Self);
end;

procedure TFrmMainPOS.DisplayPetSKU;
var
  AIDPet, AIDStatus : Integer;
  ACost, ASale : Currency;
  ASKU : String;
begin
  inherited;
  with TFrmPetSearch.Create(Self) do
  try
    if Start(spquPreSaleItemModelID.AsInteger, AIDPet, AIDStatus, ACost, ASale, ASKU) then
      DM.CreatePetSale(spquPreSaleItemIDInventoryMov.AsInteger,
                       AIDPet,
                       quPreSaleInfoIDCustomer.AsInteger,
                       spquPreSaleItemQty.AsFloat);
  finally
    Free;
  end;

end;

procedure TFrmMainPOS.btnStoreAccountClick(Sender: TObject);
begin
  inherited;

  with TFrmStoreAccount.Create(Self) do
    Start(FInvoiceInfo.IDCashRegMov, quPreSaleInfoIDCustomer.AsInteger);

end;

procedure TFrmMainPOS.btnTestPromoClick(Sender: TObject);
begin
  inherited;
  FFrmPromoControl.FCoupon := FCoupon;
  FFrmPromoControl.ApplySalePromo(FInvoiceInfo.IDPreSale, FSaleItem.IDCustomer,
                                  quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime,
                                  IsLoyalty);
  FFrmPromoControl.Show;
end;

procedure TFrmMainPOS.btnRemoveClick(Sender: TObject);
begin

  inherited;

  if ( dm.isGiftCardModel(FSaleItem.IDModel) ) then begin
     dm.RunSQL('delete from Sal_AccountCard where IdPreInventoryMov = ' + intToStr(FsaleItem.IDPreInventoryMov));
  end;

  OnRemoveClick(Sender);

  // Antonio 2104 Jun 03
  RefreshItem(spquPreSaleItemIDInventoryMov.Value);
  TreatInvoiceTotals();
end;

procedure TFrmMainPOS.btnEditClick(Sender: TObject);
var
  bEmpty: Boolean;
  //amfsouza September 26, 2012
  idInventoryMovAfterEdit: Integer;
  qtyAfterEdit: Double;
  qtyInLine: Integer;
begin
  inherited;
  OnDetailClick(Sender);
  // Antonio 2104 Jun 03
  treatInvoiceTotals();

end;

procedure TFrmMainPOS.btnAddClick(Sender: TObject);
begin
  inherited;
  OnAddClick(Sender);

  // Antonio 2104 Jun 03
  treatInvoiceTotals();
end;

procedure TFrmMainPOS.ResetDiscount(IDPreSale: Integer);
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('update PreInventoryMov set DiscountPromo = 0');
    SQL.Add('WHERE DocumentID  = ' + IntToStr(IDPreSale) + ' AND InventMovTypeID = 1 ');
    try
      ExecSQL;
    finally
      Close;
      end;
  end;
end;


function TFrmMainPOS.VerifyCustomerInLoyalty(IDCustomer: Integer): Boolean;
begin
  With quVerifyCustomerIsLoyalty do
  begin
    quVerifyCustomerIsLoyalty.Parameters.ParamByName('IDCustomer').Value := IDCustomer;
    quVerifyCustomerIsLoyalty.Open;
    if quVerifyCustomerIsLoyaltyQTD.AsInteger > 0 then
      Result := True
    else
      Result := False;

    quVerifyCustomerIsLoyalty.Close;
  end;
end;

procedure TFrmMainPOS.spquPreSaleItemAfterScroll(DataSet: TDataSet);
begin
  inherited;

  //amf 10-05-2010 block changes to layaway sale type.
  if ( (FInvoiceInfo.Layaway) and ( not FInvoiceInfo.IsNewHold) ) then begin
    btnAdd.Enabled    := ( not BlockLayaway(FInvoiceInfo.IDPreSale) );
    btnEdit.Enabled   := ( not BlockLayaway(FInvoiceInfo.IDPreSale) );
    btnRemove.Enabled := ( not BlockLayaway(FInvoiceInfo.IDPreSale) );
  end;

end;

function TFrmMainPOS.BlockLayaway(AIdPreSale: integer): boolean;
var
  ds: TADOQuery;
  sql: String;
begin
  try
     ds := TADOQuery.Create(nil);
     ds.Connection := dm.ADODBConnect;

     sql := 'select count(*) NumReg from INVOICE where Layaway = 1 and IdPreSale = :idpresale ';
     ds.SQL.Text := sql;
     ds.Parameters.ParamByName('idpresale').Value := AIdPreSale;
     ds.Open;
     result := (ds.FieldByName('NumReg').Value > 0 );
  finally
     freeAndNil(ds);
  end;
end;

procedure TFrmMainPOS.OnHoldPrintClick(Sender: TObject);
begin
  inherited;
  //amfsouza 03.20.2011
  btnCancelClick(sender);
end;

function TFrmMainPOS.NeedRecalculatesPromo(IdModel: Integer): integer;
var
   sql: String;
   qryPromo:TADOQuery;
   qryPromoItem: TADOQuery;
   findModel: boolean;
begin
   Result := -1;
   try
      //select to promo
      sql := 'SELECT            '+
             '     P.IDPromo,   '+
             '     P.Promo,     '+
             '     P.PromoType, '+
             '     P.IDStore,   '+
             '     P.Barcode,   '+
             '     P.QtyFrequent, '+
             '     P.StartDate,   '+
             '     P.EndDate,     '+
             '     P.DaysOfWeek,  '+
             '     P.DiscountType, '+
             '     P.DiscountValue, '+
             '     P.QtyPromoItem   '+
             'FROM                  '+
             '     Sal_Promo P (NOLOCK) '+
             'WHERE                     '+
             '     P.StartDate <= :StartDate '+
             '     AND (P.EndDate IS NULL OR P.EndDate >= :EndDate) '+
             '     AND P.DaysOfWeek LIKE ''%1;2;3;4;5;6;7%'' '+
             '     AND P.System = 0                 '+
             '     AND P.Hidden = 0                 '+
             '     AND P.Desativado = 0             ';
      qryPromo := TADOQuery.Create(nil);
      qryPromo.Connection := dm.ADODBConnect;
      qryPromo.SQL.Text := sql;
      qryPromo.Parameters.ParamByName('StartDate').Value := now;
      qryPromo.Parameters.ParamByName('EndDate').Value := now;
      qryPromo.Open;

      if ( qryPromo.IsEmpty ) then begin
         result := NEED_RECALCULATE_PROMO_ANYREASON;
         exit;
      end;

      //select to PromoItem
      sql :=
       'SELECT PI.IDPromoItem, '+
	     '       PI.IDPromo,     '+
       '       PI.IDModel,     '+
       '       P.PromoType,    '+
       '       P.DiscountType, '+
       '       P.DiscountValue,  '+
       '       IsNull(P.QtyPromoitem, 0) as QtyPromoitem, '+
       '       P.FlatPromo,                               '+
       '       P.StartDate,                               '+
       '       P.EndDate,                                 '+
       '       P.Barcode,                                 '+
       '       QtyFrequent                                '+
       'FROM   Sal_PromoItem PI (NOLOCK)                  '+
       '       JOIN Sal_Promo P (NOLOCK) ON (PI.IDPromo = P.IDPromo) '+
       'WHERE  P.StartDate <= :StartDate                             '+
       '  AND (P.EndDate IS NULL OR P.EndDate >= :EndDate)           '+
       '  AND P.DaysOfWeek LIKE ''%1;2;3;4;5;6;7%'' '+
       '  AND P.System = 0                                           '+
       '  AND P.Hidden = 0                                           '+
       '  AND P.Desativado = 0                                       '+
       '  AND PI.IDPROMO = :Idpromo                                  '+
       '  AND PI.IDModel = :Idmodel ';

      qryPromoItem := TADOQuery.Create(nil)   ;
      qryPromoItem.Connection := dm.ADODBConnect;
      qryPromoItem.SQL.Text := sql;
      qryPromoItem.Parameters.ParamByName('StartDate').Value := now;
      qryPromoItem.Parameters.ParamByName('EndDate').Value := now;

      while ( not  qryPromo.Eof ) do begin
          qryPromoItem.Close;
          qryPromoItem.Parameters.ParamByName('IdPromo').Value := qryPromo.fieldByName('IdPromo').Value;
          qryPromoItem.Parameters.ParamByName('IdModel').Value := intToStr(IdModel);
          qryPromoItem.Open;

          if ( not qryPromoItem.IsEmpty ) then begin
             result := FFrmPromoControl.IsStackable(qryPromoItem.fieldByName('PromoType').Value,
                                                    qryPromoItem.fieldByname('DiscountType').Value );
             break;
          end;

          qryPromo.Next;
      end;

   finally
      freeAndNil(qryPromo);
      freeAndNil(qryPromoItem);
   end;

end;

function TFrmMainPOS.isSerialNumberGroup(id_model: Integer): Boolean;
var
  qryIsSerial: TADOQuery;
begin
  result := false;
  try
     try
        qryIsSerial := TADOQuery.Create(nil);
        qryIsSerial.Connection := dm.ADODBConnect;
        qryIsSerial.SQL.Add('select t.SerialNumber');
        qryIsSerial.SQL.Add('from Model m');
        qryIsSerial.SQL.Add('join TabGroup t on m.groupId = t.idGroup');
        qryIsSerial.sql.add('where idmodel =:idmodel');
        qryIsSerial.Parameters.ParamByName('idmodel').Value := id_model;
        qryIsSerial.Open;
        result := ( qryIsSerial.FieldByName('SerialNumber').AsBoolean );
     except

     end;
  finally
     freeAndNil(qryIsSerial);
  end;

end;

function TFrmMainPOS.getSalesInCashRegister(id_presale: Integer): TADOQuery;
var
   sql: String;
begin

   sql:= 'select im.IDInventoryMov, im.modelID, im.Qty ' +
         'from Invoice i '+
         'join Fin_Lancamento f on i.IdPresale = f.IDPresale '+
         'join InventoryMov im on im.DocumentID = i.IdInvoice '+
         'where i.IDPresale = :idpresale';

   result := TADOQuery.create(self);
   result.Connection := dm.ADODBConnect;
   result.SQL.Text := sql;
   result.Parameters.ParamByName('idpresale').Value := id_presale;
   result.Open;
end;

procedure TFrmMainPOS.Button1Click(Sender: TObject);
begin
  inherited;
  edtBarcode.Text:= '076484377037';
  edtBarcode.DoKeyPress(#13);
  //edtBarcode.Text:= '076484377037'#13'076484377037';
  //edtBarcode.DoKeyPress(#13);
end;

procedure TFrmMainPOS.spquPreSaleValueAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(dataset.FieldByName('InvoiceDiscount')).DisplayFormat := '#,##0.00';
  TFloatField(dataset.FieldByName('TotalSaved')).DisplayFormat := '#,##0.00';
end;

procedure TFrmMainPOS.adjustSellingPriceInPromoPriceBreak(pIdPresale, pIdmodel:Integer; pQty: Double = 0);
var
   sp: TADOStoredProc;
   bEmpty: Boolean;
begin
  sp := dm.fPOS.getItemPreSaleDetail(FsaleItem.IDPreSale);
  if ( not sp.IsEmpty ) then begin
     sp.Filter := 'ModelID = ' +intToStr(pIdModel);
     sp.filtered := true;
     if ( not sp.Eof ) then begin
        dm.fPOS.GetKitPrice(pIdModel,
                            pQty,
                            sp.fieldByname('SellingPrice').Value,
                            bEmpty,
                            pIdPresale,
                            hasStoreSellingPrice,
                            (SaveQtyToPriceBreak > 0));
     end;
     freeAndNil(sp);
  end;
end;

procedure TFrmMainPOS.dealRefundToItemWithoutInvoice(arg_ItemRefund: Integer);
var
   view: TfrmRefundByItemWithoutInvoiceView;
begin
   try
      view := TfrmRefundByItemWithoutInvoiceView.Create(nil);

      // Antonio June 20, 2013
      view.startView(arg_itemRefund);
   finally
      freeAndNil(view);
   end;
end;

procedure TFrmMainPOS.ApplyPromotion(arg_saleItem: TSaleItem; arg_coupon: String; arg_isLoyalty: Boolean; arg_subTotalSale: Double);
begin
   try
       if ( mainPromo = nil ) then begin
          mainPromo := TMainPromo.create();
       end;


       mainPromo.start();
   except
       on E: Exception do begin
          raise Exception.create('cannot calculate promo: ' + e.message);
       end;
   end;
end;

procedure TFrmMainPOS.doSale();
var
  quantity: Double;
  idUser: Integer;
  idCommission: Integer;
begin

  if ( edtBarcode.SearchResult ) then begin
      quantity := StrToFloatDef(edtBarcode.QtyEdit.Text, 1);

    if ( isModelVerified(edtBarcode.GetFieldValue('IdModel')) ) then begin

       quantity := getQuantity(quantity);

      idUser := dm.fUser.ID;
      idCommission := dm.fUser.IDCommission;

      isAskUserOnSale(idUser, idCommission, edtBarcode.GetFieldValue('AskUserOnSale'));

      FSaleItem.IDModel := edtBarcode.GetFieldValue('IdModel');
      quantity := replaceQtyOnRefund(quantity);
      fsaleItem.Barcode := edtBarcode.Text;

      doCommonSaleRoutine(quantity);
    end;
  end else begin
          askForNewModel();
      end;
end;

procedure TFrmMainPOS.setStoreToBarcode;
begin
  edtBarcode.SetParameterValue('IDStore', DM.fStore.ID);
end;

procedure TFrmMainPOS.treatInvoiceLabels(arg_refund: Boolean);
begin
  lblTotalSaved.Visible := true;
  totalSavedDisplay.Visible  := true;
end;

procedure TFrmMainPOS.treatRefundCondition;
begin
  if ( FReturn ) then begin
    // assign to refund color
    treatInvoiceLabels(fReturn);
  end;
end;

procedure TFrmMainPOS.fillSaleItem
(arg_qty: Double);
//var
//  idModel: Integer;
begin
  //idModel := edtBarcode.GetFieldValue('IdModel');
  //fsaleItem.idModel := idModel;

  FSaleItem.IDCustomer := quPreSaleInfoIDCustomer.AsInteger;
  fsaleItem.IDPreSale := FInvoiceInfo.IDPreSale;
  fsaleItem.IDStore := dm.fStore.ID;
  fsaleItem.Qty := arg_qty;
  fsaleItem.IDUser := dm.fUser.ID;
  fsaleItem.IDCommission := dm.fUser.IDCommission;
  fsaleItem.PreSaleDate := quPreSaleInfoPreSaleDate.AsDateTime;
  fsaleItem.IDItemExchange := 0;
  fsaleItem.IDPreInventoryMovParent := 0;
  fsaleItem.IDPreInventoryMov := 0;
  fsaleItem.PromoSellingPrice := 0;
  fsaleItem.Promo := false;
  fsaleItem.AskedSalePrice := false;
  // fSaleItem.Discount := 0;
  //fsaleItem.Barcode := edtBarcode.Text;

end;

function TFrmMainPOS.isModelVerified(arg_idModel: Integer): Boolean;
begin
  result := dm.ModelRestored(arg_idModel);
end;

function TFrmMainPOS.getQuantity(arg_qty: Double): Double;
begin
  result := arg_qty * edtBarcode.GetFieldValue('caseQty');
  edtBarcode.QtyEdit.Text := FormatFloat('0', result);
end;

function TFrmMainPOS.getIdDepartment(arg_idModel: Integer): Integer;
begin
  result := GetModelDepartment(arg_idModel);
end;

function TFrmMainPOS.getIdCommissionOnAskUserSale(
  arg_askUserOnSale: Boolean): Integer;
begin

end;

function TFrmMainPOS.getIdUserOnAskUserSale(
  arg_askUserOnSale: Boolean): Integer;
begin
end;

function TFrmMainPOS.isAskUserOnSale(arg_idUser, arg_idCommission: Integer; arg_condition: Boolean): Boolean;
begin
  if ( arg_condition ) then begin
     with TFrmAskSalesPerson.Create(Self) do begin
       if not Start(arg_idUser, arg_idCommission) then begin
         ;
       end;
     end;
  end;
end;

function TFrmMainPOS.getCostPrice(): Double;
begin
  if DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
    result := edtBarcode.GetFieldValue('ReplacementCost')
  else
  begin
    if DM.fSystem.SrvParam[PARAM_MARKUPOVERCOST] then
      result := edtBarcode.GetFieldValue('VendorCost')
    else
      result := edtBarcode.GetFieldValue('AvgCost');
  end;
end;

function TFrmMainPOS.getSellingPrice(arg_isPromoOnSale: Boolean): Double;
begin
  if (edtBarcode.GetFieldValue('StoreSellingPrice') <> 0) then begin
    result := edtBarcode.GetFieldValue('StoreSellingPrice');
  end
  else
  begin
    if (edtBarcode.GetFieldValue('PromotionPrice') <> 0) then
      result := edtBarcode.GetFieldValue('PromotionPrice')
    else
      result := edtBarcode.GetFieldValue('SellingPrice');
  end;

//  result := treatPromoOnSale(result);

end;

function TFrmMainPOS.isPuppyRestrictionRechead(arg_counter: Integer): Boolean;
begin
  result := false;
  try
    if ( arg_counter > 1 ) then begin
       raise Exception.Create('Only one pet may be sold at a time when PuppyTracker integration is enabled');
    end;
  except
    on e:Exception do begin
       result := true;
       edtBarcode.SetFocus;
    end;
  end;
end;

procedure TFrmMainPOS.treatPackModel();
var
  isAKitItem: Boolean;
begin
   with TFrmAddKitItems.Create(Self) do begin
        isAKitItem := Start(FSaleItem, FCountPuppies);
   end;

   if ( isAkitItem ) then begin
      SetCustomer(FSaleItem.IDCustomer);
      RefreshCustomer;
      UpdatePuppyTrackerInfo;
      RefreshItem(FSaleItem.IDPreInventoryMov);
   end;
end;

function TFrmMainPOS.ifNeedsAskForSalePrice(arg_sellingPrice: Double): Double;
var
  sellingPrice: Currency;
  discountSaleValue: Double;
begin
  result := arg_sellingPrice;

  setPriceManually(false, arg_sellingPrice);

  if ( fReturn and (quPreSaleInfoIDCustomer.AsInteger = 1) ) then
  	  sellingPrice := 0;


    (* removed
    if FApplyPromoOnSale then begin
     if not FSaleItem.Promo and
         (edtBarcode.GetFieldValue('CustomSalePrice') or
         (DM.fSystem.SrvParam[PARAM_ASK_SALEPRICE] and (arg_SellingPrice = 0))) then begin
           AdjustSellingPrice(sellingPrice);
           setPriceManually(true, sellingPrice );
           result    := sellingPrice;
     end;

     if ( discountSaleValue <> 0 ) then
        fsaleItem.SetDiscountItem(FSaleItem, DiscountSaleValue, DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE]);

  end
  else begin  *)

  // Se pede preco de venda, chama o formulario FrmAskPrice
  if edtBarcode.GetFieldValue('CustomSalePrice') or (DM.fSystem.SrvParam[PARAM_ASK_SALEPRICE] and (arg_SellingPrice = 0)) then begin
    AdjustSellingPrice(sellingPrice);
    setPriceManually(true, sellingPrice );
    result := sellingPrice;
  end;

end;

procedure TFrmMainPOS.addSaleItem(arg_qty: Double);
var
  idModel: Integer;
  costPrice: Double;
  sellingPrice: Double;
  kitSellingPrice: Double;
  customerSellingPrice: Double;
  hasStoreSellingPrice: Boolean;
  bEmpty: Boolean; // ??
begin
  fillSaleItem(arg_qty);

  // Nov 29 isPuppyRestrictionRechead(FCountPuppies);

  costPrice := getCostPrice();

  hasStoreSellingPrice := ( edtBarcode.GetFieldValue('sellingPrice') <> 0 );

  sellingPrice := getSellingPrice(FApplyPromoOnSale);

  kitSellingPrice := dm.fPOS.GetKitPrice(idModel, arg_qty, SellingPrice, bEmpty, fInvoiceInfo.idPresale,
                     hasStoreSellingPrice);
  customerSellingPrice :=
    DM.FDMCalcPrice.FormatPrice((SellingPrice - (DM.fPOS.CalcCustomerDiscount(quPreSaleInfoIDCustomer.AsInteger, IDModel,
                                arg_qty, SellingPrice ) / arg_qty)));

  if ( edtBarcode.GetFieldValue('PackModelAddItems') ) then begin
      treatPackModel();
  end else begin
         sellingPrice := IfNeedsAskForSalePrice(sellingPrice);
         fsaleItem.Add();
      end;

  RefreshItem(fsaleItem.IDPreInventoryMov);

  if ( FReturn ) then begin
     if ( FSaleItem.Qty < 0 ) then begin
        if ( (trim(edtBarcode.Text) <> '') and (trim(edtInvoiceSearch.Text) = '') ) then begin
           dealRefundToItemWithoutInvoice(fSaleItem.IDPreInventoryMov);
        end;
     end;
     edtBarcode.color := $00C4C4FF;
  end;
end;

procedure TFrmMainPOS.callPollDisplay;
var
  totalDiscountToPolleDisplay: Double;
begin
  if ( spquPreSaleValueInvoiceDiscount.Value > 0 ) then begin
     totalDiscountToPolleDisplay :=  spquPreSaleValueTotalDiscount.Value +
                           spquPreSaleValueInvoiceDiscount.Value;
  end
  else totalDiscountToPolleDisplay := spquPreSaleValueTotalDiscount.Value;

  //Poll Display
  DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                        Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                        spquPreSaleValueAditionalExpenses.AsCurrency,
                        totalDiscountToPolleDisplay, // amfsouza May 29, 2012 spquPreSaleValueTotalDiscount.AsCurrency,
                        spquPreSaleValueTax.AsCurrency,
                        spquPreSaleValueSubTotal.AsCurrency);

  DM.PollDisplayAddItem(FSaleItem.IDPreInventoryMov,
                        FSaleItem.IDModel,
                        spquPreSaleItemModel.AsString,
                        spquPreSaleItemDescription.AsString,
                        FSaleItem.Qty,
                        FSaleItem.SellingPrice,
                        FSaleItem.Discount);
end;

procedure TFrmMainPOS.treatSerialNumbers;
var
  i: Integer;
  preInvMovTuple: TClientdataset;
  idMov: Integer;
begin
  CalledSerialNumberScreen := false;
  idMov := spquPreSaleItemIDInventoryMov.value;
  if ( isSerialNumberGroup(FSaleItem.IDModel) ) then begin

     // search for the next IdPreinventoryMov on sequence
     preinvMovTuple := dm.getOnePreInventoryMov(idMov + 1);

     // Id found, get this one to use on new gift card to serial numbers
     if ( not preinvMovTuple.IsEmpty ) then begin
        idMov := preinvMovTuple.fieldByName('IdpreinventoryMov').value;
     end;

     freeAndNil(preInvMovTuple);

     SetSerialNumber(trunc(fSaleItem.Qty), idMov);
  end;

  if ( CalledSerialNumberScreen ) then begin
      if ( not HaveSerialNumber ) then begin
         if (Assigned(ListSerialNumbers) ) then begin
             if ( ListSerialNumbers.Count > 0 ) then begin
                for i:= 0 to ListSerialNumbers.Count - 1 do
                   DM.RunSQL('DELETE Sal_AccountCard WHERE CardNumber = ' + QuotedStr(ListSerialNumbers.Strings[i]));
             end;
             ListSerialNumbers.Free;
             RemoveHoldItem();
         end;
         // amfsouza 12.01.2011 - RemoveHoldItem;
      end;
  end;
end;

procedure TFrmMainPOS.treatCommission;
begin
  if Assigned(DM.fPOS.fDefaultSalesPerson) and
     (DM.fPOS.fDefaultSalesPerson.Count > 0) and
     (DM.fCashRegister.AskSalesPerson) then
  begin
    DM.fPOS.AddPreSaleItemCommission(FSaleItem.IDPreInventoryMov, DM.fPOS.fDefaultSalesPerson);
    RefreshItem(FSaleItem.IDPreInventoryMov);
  end;
end;


function TFrmMainPOS.replaceQtyonRefund(arg_qty: Double): Double;
begin
  result := arg_qty;

  if ( FReturn ) then begin
    if ( quPreSaleInfoIDCustomer.AsInteger = 1 ) then
      btnCustomerClick(Self);

      if ( quPreSaleInfoIDCustomer.AsInteger = 1 ) then
        Exit;

    result := (arg_qty * -1);

    treatInvoiceLabels(fReturn);
  end;
end;

procedure TFrmMainPOS.askForNewModel;
var
  sBarcode: String;
begin
  //YAA: It crashes here if we scan the same item too fast
  if (DM.fSystem.VersionType <> QuotedStr(SYSTEM_CLIENT_TYPE)) and Password.HasFuncRight(69) then begin
    if (MsgBox(MSG_INF_MODEL_NOT_FOUND_CREATE, vbQuestion + vbYesNo) = vbYes) then begin
      sBarcode := CreateNewModel(edtBarcode.Text);
      if sBarcode <> '' then begin
        edtBarcode.clear;
        edtBarcode.Text := sBarcode;
        edtBarcode.DoKeyPress(#13);
      end;
    end
    else
    begin
      edtBarcode.Clear;
      btnSearchModelClick(Self);
    end;
  end;

  if edtBarcode.CanFocus then //YAA (April 25, 2012): Condition added for safety
    edtBarcode.SetFocus;

end;

procedure TFrmMainPOS.treatInvoiceTotals();
begin
  FInvoiceInfo.InfoCashSale := objInfoCashSale;
  FInvoiceInfo.treatInvoice(FReturn, spquPreSaleValue);

  // Labels
  subtotalDisplay.caption := floatToStrF(FInvoiceInfo.subtotal, ffNumber, 11, 2);
  itemDiscountDisplay.caption := floatToStrF(FInvoiceInfo.itemsDiscount, ffNumber, 11, 2);
  saleDiscountDisplay.caption := floatToStrF(FInvoiceInfo.InvoiceDiscount, ffNumber, 11, 2);
  taxDisplay.caption := floatToStrF(FInvoiceInfo.tax, ffNumber, 11, 2);
  totalInvoiceDisplay.Caption := floatToStrF(FInvoiceInfo.TotalInvoice, ffNumber, 11, 2);
  totalSavedDisplay.caption := floatToStrF(FInvoiceInfo.totalDiscount, ffNumber, 11, 2);
end;

procedure TFrmMainPOS.initializeInvoiceLabelValues;
begin
  // Labels
  subtotalDisplay.caption := floatToStrF(0, ffNumber, 11, 2);
  itemDiscountDisplay.caption := floatToStrF(0, ffNumber, 11, 2);
  saleDiscountDisplay.caption := floatToStrF(0, ffNumber, 11, 2);
  taxDisplay.caption := floatToStrF(0, ffNumber, 11, 2);
  totalInvoiceDisplay.Caption := floatToStrF(0, ffNumber, 11, 2);
  totalSavedDisplay.caption := floatToStrF(0, ffNumber, 11, 2);

  signItemDiscount.Caption := '';
  signSaleDiscount.Caption := '';

end;

procedure TFrmMainPOS.OnProcesseSaleClick(Sender: TObject);
var
  bogoOrphansInSale: TDataset;
  view: TvwBogoWarningOrphan;
  i: integer;
begin
  i := 0;
  if ( getSaleToBogo ) then begin
      if ( FOrphanList.Count > 0 ) then begin
         // found orphans
         MsgBox(format('Total of orphans on sale %d', [FOrphanList.Count]), vbExclamation + vbOkOnly);
         bogoOrphansInSale := dm.getBogoOrphansFromSale(FInvoiceInfo.IDPreSale, getIdSalesFromBogoOrphans(FOrphanList));
         // if orphans need to be deleted will be marked to ToDelete = true ( a property )
         showBogoOrphansOnSale(spquPreSaleItem, bogoOrphansInSale, FOrphanList);
         removeBogoOrphansOnSale(FOrphanList);
         for  i:= 0 to FOrphanList.Count - 1 do begin
            if ( TBogoPromoDistribution(FOrphanList.Items[i]).ToDelete ) then begin
               FOrphanList.Delete(i);
            end;
         end;
      end;
  end;

  // Antonio 04/06/2017 , MR-20
  if ( dm.fSystem.SrvParam[PARAM_ASK_MEDIA_FILES] ) then begin

     if ( scMedia.LookUpValue = ''  ) then begin
        MsgBox(MSG_CRT_MEDIA_QUESTION, vbOKOnly + vbInformation);
        exit;
     end;

  end;

  inherited;

  // initialize totals just if sale was finalized.
  if ( IsPaymentProcessed ) then begin
     initializeInvoiceLabelValues();
  end;

end;


procedure TFrmMainPOS.OnExemptTaxClick(Sender: TObject);
begin
  inherited;
end;

procedure TFrmMainPOS.btnExemptClick(Sender: TObject);
begin
  // to fix tax exempt
  OnExemptTaxClick(sender);
  treatInvoiceTotals();

end;

procedure TFrmMainPOS.setPriceManually(arg_isManually: Boolean;
  arg_sellingPrice: currency);
begin
   FSaleItem.AskedSalePrice := false;
   fsaleItem.ManualPrice := arg_sellingPrice;
   fsaleItem.IsManualPrice := false;

   if ( arg_isManually ) then begin
      // to sp knows that is price was changed manually
      FSaleItem.AskedSalePrice := true;
      fsaleItem.ManualPrice := arg_sellingPrice;
      fsaleItem.IsManualPrice := true;
   end;
end;

function TFrmMainPOS.initializePDCx(): Boolean;
var
  mercuryDPCx: TCCreditDSIPDCx;
  activeDevice: Integer;
begin
  result := false;
  try
      activeDevice := loadPDCxStatusFromRegistry('ProcessType');
      try
        if ( activeDevice in [PROCESSING_TYPE_DSIPDCX, PROCESSING_TYPE_DSIEMVUS] ) then begin
            mercuryDPCx := TCCreditDSIPDCx.create();
            result := mercuryDPCx.initializeStatus();
            setPDCxStatusToRegistry('DeviceInitialized', 1);
        end;
      except
          on e:Exception do begin
             setPDCxStatusToRegistry('DeviceInitialized', 0);
             raise Exception.Create(format('Device is not Initialized: %s', [e.Message]));
          end;
      end;
  finally
      freeAndNil(mercuryDPCx);
  end;

end;

function TFrmMainPOS.loadPDCxStatusFromRegistry(arg_section: String): Integer;
var
  objRegistry: TRegistry;
  buildInfo: String;
begin
  try
      objRegistry := TRegistry.Create(KEY_READ OR KEY_WRITE OR $0100);

      if ( getOS(buildInfo) = osW7 ) then begin
            objRegistry.RootKey := HKEY_CURRENT_USER;
      end else begin
            objRegistry.RootKey := HKEY_LOCAL_MACHINE;
          end;

      if ( getOS(buildInfo) = osW7 ) then
         objRegistry.RootKey := HKEY_CURRENT_USER
      else
         objRegistry.RootKey := HKEY_LOCAL_MACHINE;

      objRegistry.openKey(REGISTRY_PATH, true);
      result := objRegistry.readInteger(arg_section);
  finally
      freeAndNil(objRegistry);
  end;
end;

procedure TFrmMainPOS.setPDCxStatusToRegistry(arg_section: String;
  arg_value: Integer);
var
  objRegistry: TRegistry;
  buildInfo: String;
begin
  try
      objRegistry := TRegistry.Create(KEY_READ OR KEY_WRITE OR $0100);

      if ( getOS(buildInfo) = osW7 ) then begin
            objRegistry.RootKey := HKEY_CURRENT_USER;
      end else begin
            objRegistry.RootKey := HKEY_LOCAL_MACHINE;
          end;

      if ( getOS(buildInfo) = osW7 ) then
         objRegistry.RootKey := HKEY_CURRENT_USER
      else
         objRegistry.RootKey := HKEY_LOCAL_MACHINE;

      objRegistry.openKey(REGISTRY_PATH, true);
      objRegistry.WriteInteger(arg_section, arg_value);
  finally
      freeAndNil(objRegistry);
  end;
end;

procedure TFrmMainPOS.FoundMediaFileParameter(argParameter: Boolean);
begin
   if ( argParameter ) then begin
      scMedia.LookUpValue := ''
   end;
end;

procedure TFrmMainPOS.runSale();
begin
  try
    setStoreToBarcode();
    doSale();
    (*
    treatRefundCondition();
    treatInvoiceLabels(fReturn);
    treatInvoiceTotals;
    edtBarcode.Clear; *)
  except
    on e: Exception do begin
       raise Exception.Create('Seems there are something wrong to this sale: ' + e.Message);
    end;
  end;
end;

procedure TFrmMainPOS.prepareItemsToBogoObject(items: TDataset);
begin
  // filter to buy side from Bogo
  items.Filter := 'BOGO = ' + QuotedStr('Buy');
  items.Filtered := true;
  while (not items.eof ) do begin
     FPromoBogo := TBogoPromoDistribution.create();
     FPromoBogo.IdPromo := items.fieldByName('IdDiscount').Value;
     FPromoBogo.IdTag := items.fieldByName('IdTag').Value;
     FPromoBogo.IdModel := items.fieldByName('IdModel').Value;
     FPromoBogo.IsBogo := items.FieldByName('IsBogo').Value = 1;
     FPromoBogo.RewardAmount := items.fieldByName('RewardAmount').Value;
     FPromoBogo.BuyQty := items.fieldByName('MinQuantity').Value;
     FPromoBogo.GetQty := items.fieldByName('RewardQuantity').Value;
     FPromoBogo.IsBuy := items.FieldByName('Bogo').Value = 'Buy';
     FPromoBogo.IsFree := items.FieldByName('IsFree').Value = 'free';

     items.Filtered := false;
     items.Filter := 'BOGO = ' + QuotedStr('Get') + ' and IsFree = ' + QuotedStr('free') + ' and IdDiscount = ' + IntToStr(FPromoBogo.IdPromo);
     items.Filtered := true;

     MountGetFreeItemsToBogoObject(items, FPromoBogo);

     items.Filtered := false;
     items.Filter := 'BOGO = ' + QuotedStr('Buy');
     items.Filtered := true;

     items.Next;
  end;
end;

procedure TFrmMainPOS.MountGetFreeItemsToBogoObject(items: TDataset; itemBuy: TBogoPromoDistribution);
begin
  while (not items.eof ) do begin
     FPromoBogo := TBogoPromoDistribution.create();
     FPromoBogo.IdPromo := items.fieldByName('IdDiscount').Value;
     FPromoBogo.IdTag := items.fieldByName('IdTag').Value;
     FPromoBogo.IdModel := items.fieldByName('IdModel').Value;
     FPromoBogo.IsBogo := items.FieldByName('IsBogo').Value = 1;
     FPromoBogo.RewardAmount := items.fieldByName('RewardAmount').Value;
     FPromoBogo.BuyQty := items.fieldByName('MinQuantity').Value;
     FPromoBogo.GetQty := items.fieldByName('RewardQuantity').Value;
     FPromoBogo.IsBuy := items.FieldByName('Bogo').Value = 'Get';
     FPromoBogo.IsFree := items.FieldByName('IsFree').Value = 'free';

     // add free items like a list inside buy items ( Buy x Get y ) -> Get y is the list inside Buy x
     itemBuy.addToGetFreeList(FPromoBogo);

     items.Next;
  end;
end;

procedure TFrmMainPOS.doCommonSaleRoutine(quantity: double; isAutoInsert: boolean = false);
begin
  quantity := replaceQtyOnRefund(quantity);

  if ( not isAutoInsert ) then begin
      if ( btnAdd.Enabled and ValidateRefund(quantity) ) then begin
        addSaleItem(quantity);
      end;
  end else begin
          addSaleItemAutoInsert(quantity);
      end;

  treatSerialNumbers();
  treatCommission();
  callPollDisplay();

  treatRefundCondition();
  treatInvoiceLabels(fReturn);
  treatInvoiceTotals;
  edtBarcode.Clear;
end;

procedure TFrmMainPOS.addSaleItemAutoInsert(qty: Double);
begin
  fillSaleItem(qty);

  // Nov 29 isPuppyRestrictionRechead(FCountPuppies);
  fsaleItem.Add();
  FSaleItem.CleanUpValues();
  RefreshItem(fsaleItem.IDPreInventoryMov);
end;

procedure TFrmMainPOS.setSaleToBogo(isBogo: boolean);
begin
  saleWithBogo := isBogo;
end;

function TFrmMainPOS.getSaleToBogo: boolean;
begin
  result := self.saleWithBogo;
end;

procedure TFrmMainPOS.showBogoWarning(bogoDataset: TClientdataset; idModel: integer; messagePromo: string);
var view: TvwBogoWarning;
begin

   try
     FkeepsWarning := true;
     view := TvwBogoWarning.Create(nil);
     view.start(FkeepsWarning, FLastPromoDiscount, bogoDataset, idModel, messagePromo);
   finally
     freeAndNil(view);
   end;

end;

function TFrmMainPOS.isBogoBuyXFound(idModel: integer): boolean;
var
   messageWarning: string;
begin
  // verify if model is in BOGO Promo  and is a "buy" label
  cdsBogo.Filtered := false;
  cdsBogo.Filter := 'IdModel = ' + IntToStr(idModel) + ' and BOGO = ' + QuotedStr('Buy');
  cdsBogo.Filtered := true;

  if ( not cdsBogo.FieldByName('BuyAnd').IsNull ) then begin
      if ( cdsBogo.FieldByName('BuyAnd').Value ) then begin
          messageWarning := 'This promotion allows the client get all that items ''Get Y'' bellow:';
      end else begin
             messageWarning := 'This promotion allows the client choose one of these items ''Get Y'' bellow:';
          end;
  end;

  result := cdsBogo.RecordCount > 0;

  if ( result ) then begin
      if ( (cdsBogo.fieldByName('IdDiscount').Value <> FLastPromoDiscount) or (not FKeepsWarning) ) then begin
         setLastPromoDiscount(cdsBogo.fieldByName('IdDiscount').Value);
         showBogoWarning(cdsBogo, cdsBogo.fieldByname('IdModel').Value, messageWarning);

//      end else if ( FKeepsWarning ) then begin
//           setLastPromoDiscount(cdsBogo.fieldByName('IdDiscount').Value);
//           showBogoWarning(cdsBogo, cdsBogo.fieldByname('IdModel').Value, messageWarning);
        end;
  end;
end;

function TFrmMainPOS.isBogoGetYFound(idDiscountPromo: integer; idModel: integer): boolean;
var
  messageWarning: string;
begin
    // verify if model is in BOGO Promo  and is a "get" label
    cdsBogo.Filtered := false;
    cdsBogo.Filter := 'IdDiscount = ' + IntToStr(idDiscountPromo) + ' and BOGO = ' + QuotedStr('Get');
    cdsBogo.Filtered := true;

    result := cdsBogo.RecordCount > 0;

    if ( result ) then begin
        messageWarning := 'This items belongs to the promotion above';
        if ( (cdsBogo.fieldByName('IdDiscount').Value <> FLastPromoDiscount) or (not FKeepsWarning) ) then begin
           setLastPromoDiscount(cdsBogo.fieldByName('IdDiscount').Value);
           showBogoWarning(cdsBogo, cdsBogo.fieldByname('IdModel').Value, messageWarning);
          end;
    end;
end;

procedure TFrmMainPOS.setLastPromoDiscount(value: integer);
begin
  FLastPromoDiscount := value;
end;

procedure TFrmMainPOS.addToBogoGetYDiscountList(itemsBogo: TDataset; bogoIdPreinv: integer);
begin
//   showMessage(format('Document= %d ; IdMov= %d; DateMov= %s', [FInvoiceInfo.IDPreSale, spquPreSaleItemIDInventoryMov.Value, DateTimeToStr(now)]));
   self.FPromoBogo := TBogoPromoDistribution.create;
   self.FPromoBogo.IdPromo := cdsBogo.fieldByName('IDDiscount').Value;
   self.FPromoBogo.IdTag := cdsBogo.fieldByName('IdTag').Value;
   self.FPromoBogo.IdPreInventory := spquPreSaleItemIDInventoryMov.Value;
   self.FPromoBogo.IdPreInventBogoX := bogoIdPreinv;
   self.FPromoBogo.IdModel := cdsBogo.fieldByName('IdModel').Value;
   self.FPromoBogo.IsBogo := cdsBogo.FieldByName('IsBogo').Value = 1;
   self.FPromoBogo.RewardAmount := cdsBogo.FieldByName('RewardAmount').Value;
   self.FPromoBogo.BuyQty := cdsBogo.fieldByName('MinQuantity').Value;
   self.FPromoBogo.GetQty := cdsBogo.fieldByName('RewardQuantity').Value;
   self.FPromoBogo.IsBuy := cdsBogo.FieldByName('Bogo').Value = 'Get';
   self.FPromoBogo.IsFree := cdsBogo.FieldByName('IsFree').Value = 'free';

   // add get Y item to discount list ( no free items )
   self.FPromoBogoList.add(self.FPromoBogo);
end;

procedure TFrmMainPOS.addToBogoGetYFreeList(itemsBogo: TDataset; bogoIdPreinv: integer);
begin
   self.FFreeItemsBogo := TBogoPromoDistribution.create;
   self.FFreeItemsBogo.IdPromo := cdsBogo.fieldByName('IDDiscount').Value;
   self.FFreeItemsBogo.IdTag := cdsBogo.fieldByName('IdTag').Value;
   self.FFreeItemsBogo.IdPreInventory := spquPreSaleItemIDInventoryMov.Value;
   self.FFreeItemsBogo.IdPreInventBogoX := bogoIdPreinv;
   self.FFreeItemsBogo.IdModel := cdsBogo.fieldByName('IdModel').Value;
   self.FFreeItemsBogo.IsBogo := cdsBogo.FieldByName('IsBogo').Value = 1;
   self.FFreeItemsBogo.RewardAmount := cdsBogo.FieldByName('RewardAmount').Value;
   self.FFreeItemsBogo.BuyQty := cdsBogo.fieldByName('MinQuantity').Value;
   self.FFreeItemsBogo.GetQty := cdsBogo.fieldByName('RewardQuantity').Value;
   self.FFreeItemsBogo.IsBuy := cdsBogo.FieldByName('Bogo').Value = 'Get';
   self.FFreeItemsBogo.IsFree := cdsBogo.FieldByName('IsFree').Value = 'free';

   // get Y item to freeList
   self.FPromoBogoList.add(self.FFreeItemsBogo);
end;

procedure TFrmMainPOS.addToBogoGetYOrphanList(itemsBogo: TDataset);
begin
   self.FOrphansBogo := TBogoPromoDistribution.create;
   self.FOrphansBogo.IdPromo := itemsBogo.fieldByName('IDDiscount').Value;
   self.FOrphansBogo.IdTag := itemsBogo.fieldByName('IdTag').Value;
   self.FOrphansBogo.IdPreInventory := spquPreSaleItemIDInventoryMov.Value;
   self.FOrphansBogo.IdPreInventBogoX := 0;
   self.FOrphansBogo.IdModel := itemsBogo.fieldByName('IdModel').Value;
   self.FOrphansBogo.IsBogo := itemsBogo.FieldByName('IsBogo').Value = 1;
   self.FOrphansBogo.RewardAmount := itemsBogo.FieldByName('RewardAmount').Value;
   self.FOrphansBogo.BuyQty := itemsBogo.fieldByName('MinQuantity').Value;
   self.FOrphansBogo.GetQty := itemsBogo.fieldByName('RewardQuantity').Value;
   self.FOrphansBogo.IsBuy := itemsBogo.FieldByName('Bogo').Value = 'Buy';
   self.FOrphansBogo.IsFree := itemsBogo.FieldByName('IsFree').Value = 'free';
   self.FOrphanList.Add(self.FOrphansBogo);
end;

procedure TFrmMainPOS.createBogoBuyX(itemsBogo: TDataset);
begin
   self.FPromoBogo := TBogoPromoDistribution.create;
   self.FPromoBogo.IdPromo := itemsBogo.fieldByName('IDDiscount').Value;
   self.FPromoBogo.IdTag := itemsBogo.fieldByName('IdTag').Value;
   self.FPromoBogo.IdPreInventory := spquPreSaleItemIDInventoryMov.Value;
   self.FPromoBogo.IdPreInventBogoX := 0;
   self.FPromoBogo.IdModel := itemsBogo.fieldByName('IdModel').Value;
   self.FPromoBogo.IsBogo := itemsBogo.FieldByName('IsBogo').Value = 1;
   self.FPromoBogo.RewardAmount := itemsBogo.FieldByName('RewardAmount').Value;
   self.FPromoBogo.BuyQty := itemsBogo.fieldByName('MinQuantity').Value;
   self.FPromoBogo.GetQty := itemsBogo.fieldByName('RewardQuantity').Value;
   self.FPromoBogo.IsBuy := itemsBogo.FieldByName('Bogo').Value = 'Buy';
   self.FPromoBogo.IsFree := itemsBogo.FieldByName('IsFree').Value = 'free';
   self.FPromoBogoList.add(self.FpromoBogo);
end;

function TFrmMainPOS.getIdSalesFromBogoOrphans(orphanList: TObjectList): string;
var
   i:integer;
   idInventoryList: string;
begin
   result := '';
   for i:= 0 to orphanList.Count -1 do begin
       if ( idInventoryList = '' ) then begin
          idInventoryList := IntToStr(TBogoPromoDistribution(orphanList.Items[i]).IdPreInventory);
       end else begin
               idInventoryList := idInventoryList + ',' + IntToStr(TBogoPromoDistribution(orphanList.Items[i]).IdPreInventory);
           end;
   end;

   result := idInventoryList;

end;

function TFrmMainPOS.showBogoOrphansOnSale(saleDataset, orphanFromSale: TDataset; orphanList: TObjectList): boolean;
var
  view: TvwBogoWarningOrphan;
begin
  try
    view := TvwBogoWarningOrphan.Create(nil);
    result := view.start(saleDataset, orphanFromSale, orphanList);
  finally
    freeAndNil(view);
  end;

end;

function TFrmMainPOS.removeBogoOrphansOnSale(
  orphanList: TObjectList): boolean;
var i: integer;
    idMovToDelete: integer;
begin
    i := 0;
    for i:= 0 to orphanList.count - 1 do begin
        if ( TBogoPromoDistribution(orphanList.Items[i]).ToDelete ) then begin
           idMovToDelete := TBogoPromoDistribution(orphanList.Items[i]).IdPreInventory;

           // I gonna to call to remove button here to make things easy to use
           spquPreSaleItem.Locate('IdPreInventoryMov', idMovToDelete, []);
           btnRemoveClick(self);
        end;
    end;

end;

procedure TFrmMainPOS.createBogoGetY(itemsBogo: TDataset);
begin
   self.FPromoBogo := TBogoPromoDistribution.create;
   self.FPromoBogo.IdPromo := itemsBogo.fieldByName('IDDiscount').Value;
   self.FPromoBogo.IdTag := itemsBogo.fieldByName('IdTag').Value;
   self.FPromoBogo.IdPreInventory := spquPreSaleItemIDInventoryMov.Value;
   self.FPromoBogo.IdPreInventBogoX := 0;
   self.FPromoBogo.IdModel := itemsBogo.fieldByName('IdModel').Value;
   self.FPromoBogo.IsBogo := itemsBogo.FieldByName('IsBogo').Value = 1;
   self.FPromoBogo.RewardAmount := itemsBogo.FieldByName('RewardAmount').Value;
   self.FPromoBogo.BuyQty := itemsBogo.fieldByName('MinQuantity').Value;
   self.FPromoBogo.GetQty := itemsBogo.fieldByName('RewardQuantity').Value;
   self.FPromoBogo.IsBuy := itemsBogo.FieldByName('Bogo').Value = 'Get';
   self.FPromoBogo.IsFree := itemsBogo.FieldByName('IsFree').Value = 'free';
   self.FPromoBogoList.add(self.FpromoBogo);
end;

procedure TFrmMainPOS.SaveBogo(bogoDataset: TDataset; qtyComputedToDistribute: double);
begin
  if ( bogoDataset.FieldByName('IsFree').Value = 'free' ) then begin
     SaveFreeBogoItems(qtyComputedToDistribute);
  end else begin
          SaveDiscountBogoItems(qtyComputedToDistribute);
      end;

end;

procedure TFrmMainPOS.SaveDiscountBogoItems(qtyComputedToDistribute: double);
var
  bogoDiscount: double;
begin
   while ( not cdsBogo.EOF ) do begin
       FsaleItem.CleanUpValues();
       FSaleItem.Qty := qtyComputedToDistribute;
       bogoDiscount := cdsBogo.fieldByName('RewardAmount').Value;
       FSaleItem.EachDiscount := cdsBogo.fieldByName('SellingPrice').Value * bogoDiscount * qtyComputedToDistribute;
 //      FSaleItem.ManualDiscount := bogoDiscount * cdsBogo.fieldByName('SellingPrice').Value;
       FSaleItem.SellingPrice := cdsBogo.fieldByName('SellingPrice').Value;
       FSaleItem.IsManualDiscount := true;
//       FSaleItem.IsManualPrice := true;
       FSaleItem.IDModel := cdsBogo.fieldByName('IdModel').Value;
       doSaleByAutoCaller(cdsBogo.fieldByName('IdModel').Value, qtyComputedToDistribute);
       addToBogoGetYDiscountList(cdsBogo, spquPreSaleItemIDInventoryMov.Value);
       cdsBogo.Next;
   end;
end;

procedure TFrmMainPOS.SaveFreeBogoItems(qtyComputedToDistribute: double);
var bogoDiscount: double;
begin
   while ( not cdsBogo.Eof ) do begin
         FsaleItem.CleanUpValues();
         FSaleItem.Qty := qtyComputedToDistribute;
         bogoDiscount := cdsBogo.fieldByName('RewardAmount').Value;
         FSaleItem.EachDiscount := cdsBogo.fieldByName('SellingPrice').Value * bogoDiscount * qtyComputedToDistribute;
         //FSaleItem.ManualDiscount := bogoDiscount * cdsBogo.fieldByName('SellingPrice').Value * qtyComputedToDistribute;
         FSaleItem.Discount := bogoDiscount * cdsBogo.fieldByName('SellingPrice').Value * qtyComputedToDistribute;
         FSaleItem.SellingPrice := cdsBogo.fieldByName('SellingPrice').Value;
         FSaleItem.IsManualDiscount := true;
         //FSaleItem.IsManualPrice := true;
         FSaleItem.IDModel := cdsBogo.fieldByName('IdModel').Value;
         doSaleByAutoCaller(cdsBogo.fieldByName('IdModel').Value, qtyComputedToDistribute);
         addToBogoGetYFreeList(cdsBogo, spquPreSaleItemIDInventoryMov.Value);
//         showMessage(format('Document= %d ; IdMov= %d; DateMov= %s', [FInvoiceInfo.IDPreSale, spquPreSaleItemIDInventoryMov.Value, DateTimeToStr(now)]));
         cdsBogo.Next;
   end;

end;

function TFrmMainPOS.AddBogoBuyQtyToBogo(idModel: integer; idPromo: integer; isBuyX: boolean = true): TBogoPromoDistribution;
var
  i: integer;
begin
  for i := 0 to FPromoBogoList.Count - 1 do begin
      if ( TBogoPromoDistribution(FPromoBogoList.Items[i]).IdModel = idModel ) and
         ( TBogoPromoDistribution(FPromoBogoList.Items[i]).IdPromo = idPromo ) and
         ( TBogoPromoDistribution(FPromoBogoList.Items[i]).IsBuy = isBuyX ) then begin
         TBogoPromoDistribution(FPromoBogoList.Items[i]).TotalBuy := TBogoPromoDistribution(FPromoBogoList.Items[i]).TotalBuy + 1;
         result := TBogoPromoDistribution(FPromoBogoList.Items[i]);
         break;
      end;
  end;
  
end;

procedure TFrmMainPOS.SearchForBogoGetItems(idPromo, idModel: integer);
begin
  if ( isBogoGetYFound(idPromo, idModel) ) then begin
      cdsBogo.Filter := 'IdDiscount = ' + IntToStr(idPromo) + ' and BOGO = ' + QuotedStr('Get');
      cdsBogo.Filtered := true;
  end;    
end;

end.

