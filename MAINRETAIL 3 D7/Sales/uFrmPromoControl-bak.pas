(*
-----------------------------------------------------------------------------------------------------
Version : (293 - 298)
Date    : 05.11.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Combine lines is not working if sale has discount
Solution: I had to get another discounts to documentID
Version : (291 - 293)
------------------------------------------------------------------------------------------------------
*)


unit uFrmPromoControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, Provider, DB, DBClient, uSaleItem, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, StdCtrls, DBCtrls;

type
  TDiscountInfo = class
     IDPromoItem : Integer;
     Qty         : Double;
  end;

  TFrequentInfo = class(TDiscountInfo)
    IDModel     : Integer;
    QtyPrizeItem : Double;
  end;

  TFrmPromoControl = class(TForm)
    cdsPromo: TClientDataSet;
    cdsPromoItem: TClientDataSet;
    cdsPromoPrizeItem: TClientDataSet;
    dspPromo: TDataSetProvider;
    dspPromoItem: TDataSetProvider;
    dspPromoPrizeItem: TDataSetProvider;
    qryPromo: TADOQuery;
    qryPromoItem: TADOQuery;
    qryPromoPrizeItem: TADOQuery;
    cdsPrizeItemList: TClientDataSet;
    cdsPrizeItemListIDModel: TIntegerField;
    cdsPrizeItemListDiscountValue: TFloatField;
    cdsBestPrizeList: TClientDataSet;
    cdsBestPrizeListIDModel: TIntegerField;
    cdsBestPrizeListDiscountValue: TFloatField;
    cdsBestPrizeListIDPromoPrizeItem: TIntegerField;
    cdsPrizeItemListIDPromoPrizeItem: TIntegerField;
    cdsPrizeItemListIDParentSaleItem: TIntegerField;
    qryFrequentQty: TADOQuery;
    cdsBestPrizeListQty: TFloatField;
    cdsPrizeItemListQty: TFloatField;
    cdsDiscountPromoQtyList: TClientDataSet;
    cdsDiscountPromoQtyListIDPreInventoryMov: TIntegerField;
    cdsDiscountPromoQtyListIDModel: TIntegerField;
    cdsDiscountPromoQtyListQty: TFloatField;
    cdsDiscountPromoQtyListIDPromoItem: TIntegerField;
    cdsBestPrizeListDiscountType: TIntegerField;
    cdsPrizeItemListDiscountType: TIntegerField;
    cdsBestPrizeListIDPromoItem: TIntegerField;
    cdsPrizeItemListIDPromoItem: TIntegerField;
    cdsPrizeItemListIDModelPromoItem: TIntegerField;
    cdsBestPrizeListIDModelPromoItem: TIntegerField;
    cdsPrizeItemListIDInventoryMovParent: TIntegerField;
    cdsPrizeItemListIDFrequentPromo: TIntegerField;
    cdsPrizeItemListQtyFrequent: TFloatField;
    spquPreSaleItem: TADOStoredProc;
    spquPreSaleItemModelID: TIntegerField;
    spquPreSaleItemModel: TStringField;
    spquPreSaleItemDescription: TStringField;
    spquPreSaleItemSalePrice: TFloatField;
    spquPreSaleItemDiscActual: TFloatField;
    spquPreSaleItemDiscount: TFloatField;
    spquPreSaleItemIDInventoryMov: TIntegerField;
    spquPreSaleItemTotalItem: TFloatField;
    spquPreSaleItemSalesPerson: TStringField;
    spquPreSaleItemIDComission: TIntegerField;
    spquPreSaleItemCostPrice: TFloatField;
    spquPreSaleItemExchangeInvoice: TIntegerField;
    spquPreSaleItemSuggRetail: TFloatField;
    spquPreSaleItemSerialNumber: TBooleanField;
    spquPreSaleItemIDUser: TIntegerField;
    spquPreSaleItemTax: TFloatField;
    spquPreSaleItemSubTotalItem: TFloatField;
    spquPreSaleItemQty: TFloatField;
    spquPreSaleItemIDDepartment: TIntegerField;
    spquPreSaleItemRequestCustomer: TBooleanField;
    spquPreSaleItemPuppyTracker: TBooleanField;
    spquPreSaleItemPromo: TBooleanField;
    spquPreSaleItemIDMovParent: TIntegerField;
    cdsSaleItems: TClientDataSet;
    cdsSaleItemsIDModel: TIntegerField;
    cdsSaleItemsPromoType: TIntegerField;
    cdsSaleItemsDiscountType: TIntegerField;
    cdsSaleItemsIDInventoryMov: TIntegerField;
    cdsSaleItemsIDInventoryMovParent: TIntegerField;
    cdsSaleItemsInUse: TBooleanField;
    cdsSaleItemsSalePrice: TFloatField;
    cdsSaleItemsQty: TFloatField;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    btnteste: TButton;
    qryValidateSaleItemInPromo: TADOQuery;
    qryValidateSaleitemInPromoPrize: TADOQuery;
    dspValidateSaleItemInPromo: TDataSetProvider;
    cdsValidateSaleItemInPromo: TClientDataSet;
    dspValidateSaleitemInPromoPrize: TDataSetProvider;
    cdsValidateSaleitemInPromoPrize: TClientDataSet;
    qryValidateSaleitemInPromoPrizeIDModel: TIntegerField;
    cdsValidateSaleitemInPromoPrizeIDModel: TIntegerField;
    cdsSaleItemsSumQty: TAggregateField;
    cdsSaleItemsIsPrize: TBooleanField;
    cdsSaleItemsIsNew: TBooleanField;
    qryPromoItemIDPromoItem: TIntegerField;
    qryPromoItemIDPromo: TIntegerField;
    qryPromoItemIDModel: TIntegerField;
    qryPromoItemPromoType: TIntegerField;
    qryPromoItemDiscountType: TIntegerField;
    qryPromoItemDiscountValue: TFloatField;
    qryPromoItemQtyPromoitem: TFloatField;
    qryPromoItemFlatPromo: TBooleanField;
    qryPromoItemStartDate: TDateTimeField;
    qryPromoItemEndDate: TDateTimeField;
    qryPromoItemBarcode: TStringField;
    cdsPromoItemIDPromoItem: TIntegerField;
    cdsPromoItemIDPromo: TIntegerField;
    cdsPromoItemIDModel: TIntegerField;
    cdsPromoItemPromoType: TIntegerField;
    cdsPromoItemDiscountType: TIntegerField;
    cdsPromoItemDiscountValue: TFloatField;
    cdsPromoItemQtyPromoitem: TFloatField;
    cdsPromoItemFlatPromo: TBooleanField;
    cdsPromoItemStartDate: TDateTimeField;
    cdsPromoItemEndDate: TDateTimeField;
    cdsPromoItemBarcode: TStringField;
    qryPromoPrizeItemIDPromoPrizeItem: TIntegerField;
    qryPromoPrizeItemIDPromoItem: TIntegerField;
    qryPromoPrizeItemIDModel: TIntegerField;
    qryPromoPrizeItemIDModelPromoItem: TIntegerField;
    qryPromoPrizeItemIDPromo: TIntegerField;
    qryPromoPrizeItemDiscountType: TIntegerField;
    qryPromoPrizeItemDiscountValue: TFloatField;
    qryPromoPrizeItemQtyPromoItem: TFloatField;
    qryPromoPrizeItemSellingPrice: TBCDField;
    cdsPromoPrizeItemIDPromoPrizeItem: TIntegerField;
    cdsPromoPrizeItemIDPromoItem: TIntegerField;
    cdsPromoPrizeItemIDModel: TIntegerField;
    cdsPromoPrizeItemIDModelPromoItem: TIntegerField;
    cdsPromoPrizeItemIDPromo: TIntegerField;
    cdsPromoPrizeItemDiscountType: TIntegerField;
    cdsPromoPrizeItemDiscountValue: TFloatField;
    cdsPromoPrizeItemQtyPromoItem: TFloatField;
    cdsPromoPrizeItemSellingPrice: TBCDField;
    qryPromoIDPromo: TIntegerField;
    qryPromoPromo: TStringField;
    qryPromoPromoType: TIntegerField;
    qryPromoIDStore: TIntegerField;
    qryPromoBarcode: TStringField;
    qryPromoQtyFrequent: TFloatField;
    qryPromoStartDate: TDateTimeField;
    qryPromoEndDate: TDateTimeField;
    qryPromoDaysOfWeek: TStringField;
    qryPromoDiscountType: TIntegerField;
    qryPromoDiscountValue: TFloatField;
    qryPromoQtyPromoItem: TFloatField;
    cdsPromoIDPromo: TIntegerField;
    cdsPromoPromo: TStringField;
    cdsPromoPromoType: TIntegerField;
    cdsPromoIDStore: TIntegerField;
    cdsPromoBarcode: TStringField;
    cdsPromoQtyFrequent: TFloatField;
    cdsPromoStartDate: TDateTimeField;
    cdsPromoEndDate: TDateTimeField;
    cdsPromoDaysOfWeek: TStringField;
    cdsPromoDiscountType: TIntegerField;
    cdsPromoDiscountValue: TFloatField;
    cdsPromoQtyPromoItem: TFloatField;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsclone: TDataSource;
    CdsSaleItemsClone: TClientDataSet;
    CdsSaleItemsCloneIDModel: TIntegerField;
    CdsSaleItemsCloneIDInventoryMov: TIntegerField;
    CdsSaleItemsCloneIDInventoryMovParent: TIntegerField;
    CdsSaleItemsClonePromoType: TIntegerField;
    CdsSaleItemsCloneDiscountType: TIntegerField;
    CdsSaleItemsCloneQty: TFloatField;
    CdsSaleItemsCloneSalePrice: TFloatField;
    CdsSaleItemsCloneSalePriceDiscount: TFloatField;
    CdsSaleItemsCloneInUse: TBooleanField;
    CdsSaleItemsCloneIsPrize: TBooleanField;
    CdsSaleItemsCloneIsNew: TBooleanField;
    cdsSaleItemsCloneSumQty: TAggregateField;
    cdsSaleItemsTotalDiscountApplied: TFloatField;
    cdsSaleItemsIsDeleted: TBooleanField;
    cdsSaleItemsIsUpdate: TBooleanField;
    cdsSaleItemsIndice: TIntegerField;
    CdsSaleItemsCloneIsUpdate: TBooleanField;
    CdsSaleItemsCloneIndice: TIntegerField;
    CdsSaleItemsCloneIsDeleted: TBooleanField;
    cdsSaleItemsIDPromo: TIntegerField;
    CdsSaleItemsCloneIDPromo: TIntegerField;
    cdsSaleItemsIDComission: TIntegerField;
    cdsSaleItemsIDUser: TIntegerField;
    cdsSaleItemsIDDepartment: TIntegerField;
    cdsSaleItemsCostPrice: TFloatField;
    CdsSaleItemsCloneIDComission: TIntegerField;
    CdsSaleItemsCloneIDUser: TIntegerField;
    CdsSaleItemsCloneIDDepartment: TIntegerField;
    CdsSaleItemsCloneCostPrice: TFloatField;
    chkTestPromo: TCheckBox;
    qryValidateSaleItemInPromoIDModel: TIntegerField;
    qryValidateSaleItemInPromoFlatPromo: TBooleanField;
    cdsValidateSaleItemInPromoIDModel: TIntegerField;
    cdsValidateSaleItemInPromoFlatPromo: TBooleanField;
    qryPromoPrizeItemStartDate: TDateTimeField;
    qryPromoPrizeItemEndDate: TDateTimeField;
    cdsPromoPrizeItemStartDate: TDateTimeField;
    cdsPromoPrizeItemEndDate: TDateTimeField;
    cdsSaleItemsFlatPromo: TBooleanField;
    CdsSaleItemsCloneFlatPromo: TBooleanField;
    cdsSaleItemsDiscountLoyalt: TFloatField;
    CdsSaleItemsCloneDiscountLoyalt: TFloatField;
    spquPreSaleItemDiscountLoyalt: TFloatField;
    cxGrid1DBTableView1IDModel: TcxGridDBColumn;
    cxGrid1DBTableView1IDInventoryMov: TcxGridDBColumn;
    cxGrid1DBTableView1IDInventoryMovParent: TcxGridDBColumn;
    cxGrid1DBTableView1IDPromo: TcxGridDBColumn;
    cxGrid1DBTableView1PromoType: TcxGridDBColumn;
    cxGrid1DBTableView1DiscountType: TcxGridDBColumn;
    cxGrid1DBTableView1Qty: TcxGridDBColumn;
    cxGrid1DBTableView1SalePrice: TcxGridDBColumn;
    cxGrid1DBTableView1TotalDiscountApplied: TcxGridDBColumn;
    cxGrid1DBTableView1InUse: TcxGridDBColumn;
    cxGrid1DBTableView1IsPrize: TcxGridDBColumn;
    cxGrid1DBTableView1IsNew: TcxGridDBColumn;
    cxGrid1DBTableView1IsDeleted: TcxGridDBColumn;
    cxGrid1DBTableView1IsUpdate: TcxGridDBColumn;
    cxGrid1DBTableView1Indice: TcxGridDBColumn;
    cxGrid1DBTableView1FlatPromo: TcxGridDBColumn;
    cxGrid1DBTableView1DiscountLoyalt: TcxGridDBColumn;
    cxGridDBTableView1IDModel: TcxGridDBColumn;
    cxGridDBTableView1IDInventoryMov: TcxGridDBColumn;
    cxGridDBTableView1IDInventoryMovParent: TcxGridDBColumn;
    cxGridDBTableView1IDPromo: TcxGridDBColumn;
    cxGridDBTableView1PromoType: TcxGridDBColumn;
    cxGridDBTableView1DiscountType: TcxGridDBColumn;
    cxGridDBTableView1Qty: TcxGridDBColumn;
    cxGridDBTableView1SalePrice: TcxGridDBColumn;
    cxGridDBTableView1SalePriceDiscount: TcxGridDBColumn;
    cxGridDBTableView1InUse: TcxGridDBColumn;
    cxGridDBTableView1IsPrize: TcxGridDBColumn;
    cxGridDBTableView1IsNew: TcxGridDBColumn;
    cxGridDBTableView1IsDeleted: TcxGridDBColumn;
    cxGridDBTableView1IsUpdate: TcxGridDBColumn;
    cxGridDBTableView1Indice: TcxGridDBColumn;
    cxGridDBTableView1FlatPromo: TcxGridDBColumn;
    cxGridDBTableView1DiscountLoyalt: TcxGridDBColumn;
    qryItemTotal: TADOQuery;
    qryItemTotalItemTotal: TBCDField;
    qryFrequentQtyQty: TBCDField;
    qryFrequentQtySale: TADOQuery;
    qryPromoItemQtyFrequent: TFloatField;
    cdsPromoItemQtyFrequent: TFloatField;
    qryPromoPrizeItemPromoType: TIntegerField;
    cdsPromoPrizeItemPromoType: TIntegerField;
    qryPromoPrizeItemQtyFrequent: TFloatField;
    cdsPromoPrizeItemQtyFrequent: TFloatField;
    qryPromoPrizeItemFlatPromo: TBooleanField;
    cdsPromoPrizeItemFlatPromo: TBooleanField;
    qryFrequentQtySaleIDModelPromoItem: TIntegerField;
    qryFrequentQtySaleIDPromo: TIntegerField;
    qryFrequentQtySaleDiscountValue: TFloatField;
    qryFrequentQtySaleQtyFrequent: TFloatField;
    qryFrequentQtySalePromoType: TIntegerField;
    qryFrequentQtySaleFlatPromo: TBooleanField;
    qryFrequentQtySaleQtyPromoItem: TFloatField;
    cdsItemsFrequentUse: TClientDataSet;
    cdsItemsFrequentUseIDModel: TIntegerField;
    cdsItemsFrequentUseIDCustomer: TIntegerField;
    cdsItemsFrequentUseQtyUsed: TFloatField;
    qryFrequentQtySalePromo: TADOQuery;
    qryFrequentQtySalePromoIDModel: TIntegerField;
    qryFrequentQtySalePromoQty: TBCDField;
    qryFrequentQtySalePromoIDPessoa: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btntesteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cdsSaleItemsAfterPost(DataSet: TDataSet);
  private
    // T E S T E
    FPreSaleDate: TDateTime;
    FIDCustomer: Integer;
    FIsLoyalty : Boolean;

    FSaleItem: TSaleItem;


    FDiscountSaleValue,
    FFrequencyQtySold: Double;

    FDiscountQty      : TStringList;
    FPromoFrequentQty : TStringList;

    FSaleItemQty      : Double;

    FDefaultPromoFilter : String;

    FStart : Boolean;

    //Eliandro
    //FCdsSaleItemsClone : TClientDataSet;
    //FSomaQtyClone : TAggregateField;
    FNewIDInventoryMov : Integer;
    FIndiceInsert      : Integer;

    //Será utilizado para clone do cdsSaleItem  e CdsSaleItemClone
    //FCdsClone : TClientDataSet;

    procedure OpenPromo;
    procedure OpenPromoItem;
    procedure OpenPromoPrizeItem;

    procedure ClosePromo;
    procedure ClosePromoItem;
    procedure ClosePromoPrizeItem;

    procedure AddPrizeItemList(Qty: Double);
    procedure SelectPromo;
    procedure SelectPrizeItem(APromoFilter: String);
    procedure ProcessByDiscountType;

    procedure RemovePrizeItemList(AIDPromoPrizeItem: Integer);
    procedure ApplyDiscount;
    procedure ClearAllFilters;

    //amfsouza 07.07.2011 - looking for promo already done.
    function IsDonePromo(qtySold, qtyPrize: double; count_X, count_Y: integer): boolean;
    function getQtyPrizeBySale(qtySold: double; count_x, count_y: integer): integer;

    function ExistPromoItem: Boolean;

    function GetPromoFilter: String;
    function GetValidFrequentBuyerID(IDCustomer,IDModel, IDPreSale: Integer;ItemQty: Double): Integer;
    function GetValidLoyaltyID: Integer;
    function VerifyValidCoupon(PromoType: Integer; Coupon: String): Boolean;
    function GetDiscountValue(DiscountType: Integer; DiscountValue,
      QtyPromoItem, SellingPrice: Double): Double;
    function GetFlatPromoDiscountValue(DiscountType: Integer; DiscountValue, SellingPrice: Double): Double;
    function ValidateDiscount(PromoFilter: String): Boolean;
    function GetNewIDPreInventoryMov: Integer;
    function ExistFlatPromoItem: Boolean;
    procedure CalcFlatPromoItem;
    function GetCustomerSalePrice_FlatPromo(IDCostumer: Integer;
      SellingPrice: Currency): Currency;
    function ValidateDiscountQty: Boolean;
    function GetIDPromoItem(AIDPromo, AIDModel: Integer): Integer;
    function GetPromoQtyPromoItem(AIDPromoItem: Integer): Double;
    procedure UpdateDiscountPromoQtyList(AIDModel, AIDPromoItem: Integer);
    procedure RemoveAnotherPromoQtyList(AIDModelPromoItem, AIDPromoItem: Integer);
    procedure ClearDiscountQty;
    procedure AddDiscountQty(IDPromoItem : Integer; Qty : Double);
    function GetDiscountQty(IDPromoItem : Integer):Double;
    procedure OnBeforerApplyPromo;
    function IsPromoSellingPriceBetter: Boolean;
    //procedure ClearPromoFrequentQty;
    procedure AddPromoFrequentQty(IDModel, IDCustomer, IDPreSale: Integer; Qty: Double; CleanQtyPrizeItem: Boolean);
    function GetPromoFrequentQty(IDModel: Integer): Double;
    function GetPrizeFrequentQty(IDModel: Integer; FrequentQty: Double): Integer;
    function GetValidCouponID: Integer;
    procedure UpdateInventoryMovParent(IDInventoryMovParent: Integer);
    function GetPromoFrequentQtyPromoItem(AIDPromoItem: Integer): Double;
    function GetParentSaleItemFrequentPromo(IDModel,IDCostumer: Integer; FrequentQtyPromoItem: Double): Integer;
    function GetCustomerProductsList(IDCustomer, IDPreSale: Integer) : String;

    //ELIANDRO

    function VerifySaleItemsInPromo(ADocumentID: Integer; var HavePrize : Boolean) : Boolean;

    function CalcPromoItem(FCoupon : String;
                           fIDPreSale, fIDCliente : Integer;
                           APreSaleDate: TDateTime;
                           IsLoyalty : Boolean) : Double;

    function CalPromoSaleQuantity(APromoFlat: Boolean;
                                  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
                                  AQty : Double) : Double;

    function CalPromoSalePercentAmount(APromoFlat: Boolean;
                                  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
                                  AQty, ADiscountValue, ACurrentDiscount, ADiscountLoyalt: Double) : Double;

    function CalPromoCouponQuantity(APromoFlat: Boolean;
                                  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
                                  AQty: Double) : Double;

    function CalPromoCouponPercentAmount(APromoFlat: Boolean;
                                  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
                                  AQty, ADiscountValue: Double) : Double;

    function CalPromoFrequentByer(AIDCliente, ADocumentID: Integer) : Double;

    function CalPromoFrequentByerQuantity(APromoFlat: Boolean;
                                          AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
                                          AQty : Double) : Double;

    procedure InsertNewSaleItemClone(AIDInventoryMov,
                                    AIDModel, AIndice, AIDComission,
                                    AIDUser, AIDDepartment: Integer;
                                    ASalePrice, AQty, ACostPrice: Double;
                                    AInUse, AIsPrize, AIsNew, AIsUpdate, AIsFlatPromo: Boolean;
                                    ADiscountLoyalt: Double);
    {
    procedure UpdateSaleItemClone(AIDInventoryMov, APromoType, ADiscountType: Integer; AInUse: Boolean;
                                  ASalePriceDiscount, AQty: Double);
    }
    procedure InsertNewSaleItem(AIDInventoryMov, AIDModel, AIndice: Integer;
                                    ASalePrice, AQty: Double;
                                    AInUse, AIsPrize, AIsNew, AIsUpdate: Boolean);
    function AlterListSaleItens(AIDModel, AIDInventoryMov : Integer; AQty : Double) : Boolean;

    procedure SetSaleItemInUse(APromoType, ADiscountType, AIDPromo: Integer;
                                  ATotalDiscount: Double);
    procedure CancelPromoItem(AIDInventoryMov : Integer; UseLocate : Boolean);

    //Processos para ajustar os itens da Venda com as promoções aplicadas
    Procedure SettingSaleItemsWithPromo(fIDPreSale, fIDCliente : Integer; APreSaleDate: TDateTime);

    Procedure DelSaleItemwithPromo(fIDPreSale, fIDPreInvMov, fIDModel : Integer;
                                         fQty, fSale : Double);
    Procedure UpdateSaleItemWithPromo(fIDPreSale, fPreInvMovID, fIDModel,
                                         fIDCommis, fIDUSer, fDepartment, fIDPreSaleParent : Integer;
                                         fQty, fDiscount, fSale, fCost : Double;
                                         fMovDate : TDateTime);

    Procedure InsertSaleItemWithPromo(fIDCliente, fIDPreSale,
                                      fPreInvMovID, fIDModel, fIDCommis,
                                      fIDUSer, fDepartment: Integer;
                                      fQty, fDiscount, fSale, fCost: Double;
                                      fMovDate: TDateTime);

    Procedure UpdateSaleTotalWithPromo(fIDPreSale: Integer;
                                       fDiscountPercent, SubTotalSale: Double);

    //procedure UpdateSaleWithPromo;
    //Procedure UpdateSaleItemWithPromo;
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  public
    FCoupon: String;
    FHaveDeletedItem : Boolean;
    FIDPreSale : Integer;

    procedure RefreshPromoList;
    procedure LoadValidityPromo;
    procedure ApplyPromo(ASaleItem: TSaleItem; AIDCustomer: Integer; Coupon: String; var DiscountSaleValue: Double);
    procedure SetParentSaleItem(ASaleItem: TSaleItem);
    procedure CancelApplyPromo(AIDParentSaleItem: Integer);
    procedure CancelFrequentPromo(AIDModel, AIDCustomer : Integer; Qty : Double);
    procedure AdjustFrequentPromo(AIDFrequentPromo : Integer; Qty : Double);

    //amfsouza 05.17.2011
    function IsStackable(promoType, discountType: integer): Integer;
    function ApplyPromoPrizeItem(ASaleItem: TSaleItem): Boolean;
    function HasPrizeItem(AIDPreInventoryMov: Integer): Boolean;
    function IsPrizeItem(IDModel: Integer): Boolean;
    procedure VerifyFrequentPromo(IDCostumer, IDPreSale: Integer);
    procedure UpdateParentPromo(IDPreInventoryMovParent: Integer);

    function IsValidCupom(Coupon: String): Boolean;

    //ELIANDRO
    procedure NewAdjustFrequentPromo();

    function ApplySalePromo(ADocumentID, AIDCliente: Integer;
                            APreSaleDate: TDateTime;
                            IsLoyalty : Boolean) : Boolean;

    function CalcPromoTotal(fIDPreSale: Integer;
                            IsLoyalty: Boolean;
                            SubTotalSale: Double): Boolean;
  end;

implementation

uses uDM, uSystemConst, uCDSFunctions, Math, uPassword;

{$R *.dfm}

{ TFrmPromoControl }

procedure TFrmPromoControl.AddPrizeItemList(Qty: Double);
var
  dDiscountValue: Double;
  iDiscountType  : Integer;
  dFrequentQtyPromoItem : Double;
begin
  with cdsPromoPrizeItem do
  begin
    First;
    while not Eof do
    begin
      dDiscountValue := GetDiscountValue(FieldByName('DiscountType').AsInteger,
                                         FieldByName('DiscountValue').AsFloat,
                                         FieldByName('QtyPromoItem').AsFloat,
                                         FieldByName('SellingPrice').AsFloat);

      if (cdsBestPrizeList.FieldByName('DiscountType').AsInteger <> DISCOUNT_PROMO_TYPE_QTY) and
         (cdsBestPrizeList.Locate('IDModel',FieldByName('IDModel').AsInteger,[])) then
      begin
        if cdsBestPrizeList.FieldByName('DiscountValue').AsFloat < dDiscountValue then
        begin
          cdsBestPrizeList.Delete;

          cdsBestPrizeList.Append;
          cdsBestPrizeList.FieldByName('IDPromoPrizeItem').AsInteger := FieldByName('IDPromoPrizeItem').AsInteger;
          cdsBestPrizeList.FieldByName('IDModel').AsInteger          := FieldByName('IDModel').AsInteger;
          cdsBestPrizeList.FieldByName('IDModelPromoItem').AsInteger := FieldByName('IDModelPromoItem').AsInteger;
          cdsBestPrizeList.FieldByName('IDPromoItem').AsInteger      := FieldByName('IDPromoItem').AsInteger;
          cdsBestPrizeList.FieldByName('DiscountType').AsInteger     := FieldByName('DiscountType').AsInteger;
          cdsBestPrizeList.FieldByName('DiscountValue').AsFloat      := dDiscountValue;
          cdsBestPrizeList.FieldByName('Qty').AsFloat                := Qty;
          cdsBestPrizeList.Post;
        end;
      end
      else
      begin
        cdsBestPrizeList.Append;
        cdsBestPrizeList.FieldByName('IDPromoPrizeItem').AsInteger := FieldByName('IDPromoPrizeItem').AsInteger;
        cdsBestPrizeList.FieldByName('IDModel').AsInteger          := FieldByName('IDModel').AsInteger;
        cdsBestPrizeList.FieldByName('IDModelPromoItem').AsInteger := FieldByName('IDModelPromoItem').AsInteger;
        cdsBestPrizeList.FieldByName('IDPromoItem').AsInteger      := FieldByName('IDPromoItem').AsInteger;
        cdsBestPrizeList.FieldByName('DiscountType').AsInteger     := FieldByName('DiscountType').AsInteger;
        cdsBestPrizeList.FieldByName('DiscountValue').AsFloat      := dDiscountValue;
        cdsBestPrizeList.FieldByName('Qty').AsFloat                := Qty;
        cdsBestPrizeList.Post
      end;

      Next;
    end;
    First;
  end;

    with cdsBestPrizeList do
    begin
      First;
      while not Eof do
      begin
        cdsPrizeItemList.Append;
        cdsPrizeItemList.FieldByName('IDPromoPrizeItem').AsInteger := FieldByName('IDPromoPrizeItem').AsInteger;
        cdsPrizeItemList.FieldByName('IDModel').AsInteger          := FieldByName('IDModel').AsInteger;
        cdsPrizeItemList.FieldByName('IDModelPromoItem').AsInteger := FieldByName('IDModelPromoItem').AsInteger;
        cdsPrizeItemList.FieldByName('IDPromoItem').AsInteger      := FieldByName('IDPromoItem').AsInteger;
        cdsPrizeItemList.FieldByName('DiscountValue').AsFloat      := FieldByName('DiscountValue').AsFloat;
        cdsPrizeItemList.FieldByName('DiscountType').AsInteger     := FieldByName('DiscountType').AsInteger;
        cdsPrizeItemList.FieldByName('Qty').AsFloat                := FieldByName('Qty').AsFloat;

        if cdsPromo.FieldByName('PromoType').AsInteger = PROMO_TYPE_FREQUENTBUYER then
        begin
          dFrequentQtyPromoItem := GetPromoFrequentQtyPromoItem(FieldByName('IDPromoItem').AsInteger);

          cdsPrizeItemList.FieldByName('Qty').AsFloat := GetPrizeFrequentQty(cdsPrizeItemList.FieldByName('IDModelPromoItem').AsInteger,
                                                                             cdsPromo.FieldByName('QtyFrequent').AsFloat);


          cdsPrizeItemList.FieldByName('IDFrequentPromo').AsInteger := GetParentSaleItemFrequentPromo(
                                                                FieldByName('IDModelPromoItem').AsInteger,
                                                                FIDCustomer,
                                                                dFrequentQtyPromoItem
                                                           );
          cdsPrizeItemList.FieldByName('QtyFrequent').AsFloat  := dFrequentQtyPromoItem;
        end;

        //Trunc((FFrequencyQtySold + FieldByName('Qty').AsFloat)/cdsPromo.FieldByName('QtyFrequent').AsFloat);

        if cdsPromo.FieldByName('DiscountType').AsInteger = DISCOUNT_PROMO_TYPE_QTY then
          cdsPrizeItemList.FieldByName('Qty').AsFloat := GetDiscountQty(cdsPrizeItemList.FieldByName('IDPromoItem').AsInteger);

        cdsPrizeItemList.Post;

        Delete;
      end;
    end;
end;

function TFrmPromoControl.GetDiscountValue(DiscountType: Integer; DiscountValue,QtyPromoItem,SellingPrice: Double): Double;
begin
  case DiscountType of
    DISCOUNT_PROMO_TYPE_PERCENTUAL: Result := (DiscountValue / 100)  * SellingPrice;
    DISCOUNT_PROMO_TYPE_VALUE     : Result := DiscountValue;
    //DISCOUNT_PROMO_TYPE_QTY       : Result := (DiscountValue * SellingPrice);
    DISCOUNT_PROMO_TYPE_QTY       : Result := SellingPrice;
    DISCOUNT_PROMO_TYPE_SALE      : Result := DiscountValue;
  else
    Result := 0;
  end;
end;

procedure TFrmPromoControl.ClosePromo;
begin
  with cdsPromo do
    if Active then
      Close;
end;

procedure TFrmPromoControl.ClosePromoItem;
begin
  with cdsPromoItem do
    if Active then
      Close;
end;

procedure TFrmPromoControl.ClosePromoPrizeItem;
begin
  with cdsPromoPrizeItem do
    if Active then
      Close;
end;

procedure TFrmPromoControl.OpenPromo;
begin
  with cdsPromo do
  begin
    DisableControls;
    if not Active then
    begin
      FetchParams;
      Params.ParamByName('StartDate').Value := Now;
      Params.ParamByName('EndDate').Value := Now;
      Params.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
      Open;
    end;
  end;
end;

procedure TFrmPromoControl.OpenPromoItem;
begin
  with cdsPromoItem do
  begin
    DisableControls;
    if not Active then
    begin
      FetchParams;
      Params.ParamByName('StartDate').Value := Now;
      Params.ParamByName('EndDate').Value := Now;
      Params.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
      Open;
    end;
  end;
end;

procedure TFrmPromoControl.OpenPromoPrizeItem;
begin
  with cdsPromoPrizeItem do
  begin
    DisableControls;
    if not Active then
    begin
      FetchParams;
      Params.ParamByName('StartDate').Value := Now;
      Params.ParamByName('EndDate').Value := Now;
      Params.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
      Open;
    end;
  end;
end;

procedure TFrmPromoControl.LoadValidityPromo;
begin
  try
    Screen.Cursor := crHourGlass;

    ClosePromo;
    OpenPromo;

    ClosePromoItem;
    OpenPromoItem;

    ClosePromoPrizeItem;
    OpenPromoPrizeItem;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmPromoControl.RefreshPromoList;
var
  dtData : TDateTime;
begin
{
  ClearCDSIndex(cdsPrizeItemList);
  cdsPrizeItemList.Close;
  cdsPrizeItemList.CreateDataSet;

  cdsBestPrizeList.Close;
  cdsBestPrizeList.CreateDataSet;

  ClearCDSIndex(cdsDiscountPromoQtyList);
  cdsDiscountPromoQtyList.Close;
  cdsDiscountPromoQtyList.CreateDataSet;
}

  dtData := DM.GetServerDate;

  FDefaultPromoFilter := ' StartDate <= ' + QuotedStr(FormatDateTime('ddddd hh:mm',dtData)) + ' AND (EndDate IS NULL OR EndDate >= ' + QuotedStr(FormatDateTime('ddddd hh:mm',dtData)) + ')';

  //ClearPromoFrequentQty;
end;

procedure TFrmPromoControl.ApplyPromo(ASaleItem: TSaleItem; AIDCustomer: Integer; Coupon: String; var DiscountSaleValue: Double);
begin
  FSaleItem   := ASaleItem;
  FIDCustomer := AIDCustomer;
  FCoupon     := Coupon;

  OnBeforerApplyPromo;

  if ExistFlatPromoItem then
  begin
    CalcFlatPromoItem;
    ClearAllFilters;
  end
  else if ApplyPromoPrizeItem(ASaleItem) then //Y
  begin
  end
  else if ExistPromoItem then //X
  begin
    SelectPromo;
    ProcessByDiscountType;
    ClearAllFilters;
  end;

  DiscountSaleValue := FDiscountSaleValue;
end;

procedure TFrmPromoControl.OnBeforerApplyPromo;
begin
  FDiscountSaleValue := 0;
  ClearDiscountQty;

  cdsPromo.Filter :=  FDefaultPromoFilter;
  cdsPromo.Filtered := True;

  cdsPromoItem.Filter :=  FDefaultPromoFilter;
  cdsPromoItem.Filtered := True;

  cdsPromoPrizeItem.Filter :=  FDefaultPromoFilter;
  cdsPromoPrizeItem.Filtered := True;
end;

procedure TFrmPromoControl.CalcFlatPromoItem;
var
  cdsOldFilter : String;
  fPromoLoyalt, fPromoSale, fPromoCupom : Boolean;
  BestNewLoyaltySellingPrice, NewSaleSellingPrice, BestNewSaleSellingPrice : Currency;
begin

  BestNewLoyaltySellingPrice := 0;
  NewSaleSellingPrice        := 0;
  BestNewSaleSellingPrice    := 0;
  fPromoLoyalt               := False;
  fPromoSale                 := False;
  fPromoCupom                := False;

  with cdsPromoItem do
  begin

    if (FIDCustomer <> 1) and Locate('PromoType', PROMO_TYPE_LOYALTY, []) then
    begin
      BestNewLoyaltySellingPrice := GetCustomerSalePrice_FlatPromo(FIDCustomer,FSaleItem.SellingPrice);
      fPromoLoyalt := True;
    end;

    if (FCoupon <> '') then     
      fPromoCupom := cdsPromo.Locate('PromoType;Barcode', VarArrayOf([PROMO_TYPE_COUPON, FCoupon]), []);

    cdsOldFilter := Filter;
    Filtered     := False;
    Filter       := cdsOldFilter + ' AND (PromoType = ' + IntToStr(PROMO_TYPE_SALE) + ' ) ';

    if fPromoCupom then
      Filter     := Filter + ' OR (PromoType = 3 AND Barcode = ' + QuotedStr(FCoupon) + ' ) ';

    Filtered     := True;

    try
      if (RecordCount > 0) then
        begin
          fPromoSale := True;
          First;
          while not Eof do
          begin
            NewSaleSellingPrice := FSaleItem.SellingPrice - GetFlatPromoDiscountValue(FieldByName('DiscountType').AsInteger,
                                                                                      FieldByName('DiscountValue').AsFloat,
                                                                                      FSaleItem.SellingPrice);

            if (NewSaleSellingPrice < BestNewSaleSellingPrice) or (BestNewSaleSellingPrice = 0) then
              BestNewSaleSellingPrice := NewSaleSellingPrice;
            Next;
          end;
        end;
    finally
      Filtered := False;
      Filter   := cdsOldFilter;
      Filtered := True;
      end;

    if fPromoSale then
      FSaleItem.PromoSellingPrice := BestNewSaleSellingPrice;

    if fPromoLoyalt then
      if (BestNewSaleSellingPrice > BestNewLoyaltySellingPrice) or
         ((BestNewSaleSellingPrice = 0) and (BestNewLoyaltySellingPrice >= 0)) then
         FSaleItem.PromoSellingPrice := BestNewLoyaltySellingPrice;

    if IsPromoSellingPriceBetter then
      FSaleItem.Promo := (fPromoSale or fPromoLoyalt);
  end;
end;

function TFrmPromoControl.ExistPromoItem: Boolean;
var
  Teste : Boolean;
begin
  with cdsPromoItem do
  begin
    Filtered := True;
    Filter := FDefaultPromoFilter + ' AND IDModel = ' + IntToStr(FSaleItem.IDModel);
    Result := RecordCount > 0;
  end;
end;

function TFrmPromoControl.ExistFlatPromoItem: Boolean;
begin
  with cdsPromoItem do
  begin
    cdsPromoItem.Filtered := True;
    cdsPromoItem.Filter := FDefaultPromoFilter + ' AND FlatPromo <> False and IDModel = ' + IntToStr(FSaleItem.IDModel);
    Result := cdsPromoItem.RecordCount > 0;
  end;
end;

function TFrmPromoControl.IsPrizeItem(IDModel: Integer): Boolean;
begin
  with cdsPrizeItemList do
  begin
    Filtered := True;
    Filter := 'IDModel = ' + IntToStr(IDModel);
    Result := RecordCount > 0;
  end;
end;

procedure TFrmPromoControl.ProcessByDiscountType;
var
 sPromoFilter : String;
begin
  sPromoFilter := GetPromoFilter;

  SelectPrizeItem(sPromoFilter);

  //Pega o valor de Desconto na venda caso tenha.
  ValidateDiscount(sPromoFilter);

  AddPrizeItemList(FSaleItem.Qty);
end;

function TFrmPromoControl.ValidateDiscount(PromoFilter:String): Boolean;
var
  sTempFilter : string;
  IDModelPromoItem, QtyDiscountSaleValue : Integer;
begin
  Result := True;

  with cdsPromo do
  begin
    Filtered := False;
    sTempFilter := Filter;
    Filter := PromoFilter;
    Filtered := True;
    First;
    while not Eof do
    begin
      if (FieldByName('DiscountType').AsInteger = DISCOUNT_PROMO_TYPE_SALE) then
      begin
        QtyDiscountSaleValue := Trunc(FSaleItem.Qty);

        if (FieldByName('PromoType').AsInteger = PROMO_TYPE_FREQUENTBUYER) then
          QtyDiscountSaleValue := GetPrizeFrequentQty(FSaleItem.IDModel, FieldByName('QtyFrequent').AsFloat);

        if (FieldByName('PromoType').AsInteger <> PROMO_TYPE_COUPON) or
            VerifyValidCoupon(FieldByName('PromoType').AsInteger, FieldByName('Barcode').AsString) then
          if FDiscountSaleValue < (FieldByName('DiscountValue').AsFloat * QtyDiscountSaleValue) then
            FDiscountSaleValue := (FieldByName('DiscountValue').AsFloat * QtyDiscountSaleValue)
      end
      else if (FieldByName('DiscountType').AsInteger = DISCOUNT_PROMO_TYPE_QTY) then
      begin
        FSaleItemQty := FSaleItem.Qty;
        if not ValidateDiscountQty then
          cdsPromoPrizeItem.Filter := FDefaultPromoFilter + ' AND IDPromo <> ' + FieldByName('IDPromo').AsString;
      end;
      Next;
    end;
    Filtered := False;
    Filter := sTempFilter;
    Filtered := True;
  end;
end;

procedure TFrmPromoControl.ApplyDiscount;
var
  iIDBestPrizeItem, iIDBestPrizeItemParent,
  iIDParentSaleItem, iIDInventoryMovParent, iIDFrequentPromo: Integer;
  dBestDiscount, Qty, QtyFrequent: Double;
begin
  dBestDiscount := -1;
  with cdsPrizeItemList do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('DiscountValue').AsFloat > dBestDiscount then
      begin
        iIDBestPrizeItem       := FieldByName('IDPromoPrizeItem').AsInteger;
        iIDBestPrizeItemParent := FieldByName('IDParentSaleItem').AsInteger;
        dBestDiscount          := FieldByName('DiscountValue').AsFloat;
        iIDParentSaleItem      := FieldByName('IDParentSaleItem').AsInteger;
        iIDInventoryMovParent  := FieldByName('IDInventoryMovParent').AsInteger;
        iIDFrequentPromo       := FieldByName('IDFrequentPromo').AsInteger;
        Qty                    := FieldByName('Qty').AsFloat;
        QtyFrequent            := FieldByName('QtyFrequent').AsFloat;
      end;
      Next;
    end;
  end;

  if FSaleItem.Qty >= Qty then
    FSaleItem.PromoSellingPrice := FSaleItem.SellingPrice - ((dBestDiscount * Qty) / FSaleItem.Qty)
  else
    FSaleItem.PromoSellingPrice := FSaleItem.SellingPrice - dBestDiscount;

  if IsPromoSellingPriceBetter then
  begin
    FSaleItem.IDPreInventoryMovParent := iIDBestPrizeItemParent;
    FSaleItem.Promo := True;

    if cdsPrizeItemList.FieldByName('DiscountType').AsInteger = DISCOUNT_PROMO_TYPE_QTY then
      begin
        UpdateDiscountPromoQtyList(cdsPrizeItemList.FieldByName('IDModelPromoItem').AsInteger,
                                   cdsPrizeItemList.FieldByName('IDPromoItem').AsInteger);

        RemoveAnotherPromoQtyList(cdsPrizeItemList.FieldByName('IDModelPromoItem').AsInteger,
                                  cdsPrizeItemList.FieldByName('IDPromoItem').AsInteger);
      end;

    if (iIDFrequentPromo <> 0) then
      AdjustFrequentPromo(iIDFrequentPromo, QtyFrequent);

    RemovePrizeItemList(iIDBestPrizeItem);
  end;
end;


procedure TFrmPromoControl.AdjustFrequentPromo(AIDFrequentPromo : Integer; Qty : Double);
var
  iIDModel, iIDPessoa : Integer;
  dDiff : Double;
  sSQL : String;
begin

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Text := ' SELECT Qty, IDModel, IDPessoa FROM Sal_FrequentPromo (NOLOCK) ' +
                ' WHERE IDFrequentPromo = ' + IntToStr(AIDFrequentPromo) +
                ' AND IsUsed = 0 ';
    Open;
    if not IsEmpty then
    begin
      dDiff     := FieldByName('Qty').AsFloat;
      iIDModel  := FieldByName('IDModel').AsInteger;
      iIDPessoa := FieldByName('IDPessoa').AsInteger;
    end
    else
      dDiff := -1;
  finally
    Close;
  end;

  if (dDiff <> -1) and ((dDiff - Qty) >= 0) then
  begin
    dDiff := (dDiff - Qty);

    sSQL := ' UPDATE Sal_FrequentPromo SET IsUsed = 1 ' +
            ' WHERE IDFrequentPromo = ' + IntToStr(AIDFrequentPromo);

    DM.ADODBConnect.Execute(sSQL);

    if dDiff <> 0 then
      AddPromoFrequentQty(iIDModel, iIDPessoa, -1, dDiff, True);
  end;

end;

procedure TFrmPromoControl.UpdateInventoryMovParent(IDInventoryMovParent: Integer);
begin
  with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Clear;

      SQL.Text := ' UPDATE InventoryMov SET Promo = 1 ' +
                  ' WHERE IDInventoryMov = ' + InttoStr(IDInventoryMovParent);
      ExecSQL;
      Close;
    end;
end;

procedure TFrmPromoControl.RemovePrizeItemList(AIDPromoPrizeItem: Integer);
var
  IDParent : Integer;
begin

  with cdsPrizeItemList do
  begin
    if (FieldByName('IDFrequentPromo').AsInteger) = 0 then
    begin
      if Locate('IDPromoPrizeItem', AIDPromoPrizeItem, []) then
        IDParent := FieldByName('IDParentSaleItem').AsInteger;
      Filter := 'IDParentSaleItem = ' + IntToStr(IDParent);
    end
    else
    begin
      if Locate('IDPromoPrizeItem', AIDPromoPrizeItem, []) then
        IDParent := FieldByName('IDFrequentPromo').AsInteger;
      Filter := 'IDFrequentPromo = ' + IntToStr(IDParent);
    end;

    Filtered := True;
    First;
    While not EOF do
    begin
      if (FieldByName('Qty').AsFloat - FSaleItem.Qty) <= 0 then
        Delete
      else
      begin
        Edit;
        FieldByName('Qty').AsFloat := (FieldByName('Qty').AsFloat - FSaleItem.Qty);
        Post;
        Next;
      end;
    end;

    Filter := '';
    Filtered := False;
  end;
end;

procedure TFrmPromoControl.SelectPromo;
var
  sPromoFilter: String;
begin
  with cdsPromoItem do
  begin
    Filter := FDefaultPromoFilter;
    First;
    while not Eof do
    begin
      if sPromoFilter <> '' then
        sPromoFilter := sPromoFilter + ' OR '
      else
        sPromoFilter := ' ( ';

      sPromoFilter := sPromoFilter + 'IDPromo = ' + FieldByName('IDPromo').AsString;
      Next;
    end;
    First;

    if sPromoFilter <> '' then
    begin
      sPromoFilter := sPromoFilter + ' ) ';
      cdsPromo.Filter := FDefaultPromoFilter + ' AND ' + sPromoFilter;
    end
    else
      cdsPromo.Filter := FDefaultPromoFilter;

    cdsPromo.Filtered := True;
  end;
end;

procedure TFrmPromoControl.SelectPrizeItem(APromoFilter: String);
begin
  with cdsPromoPrizeItem do
  begin
    Filtered := True;
    Filter := FDefaultPromoFilter + ' AND IDModelPromoItem = ' + IntToStr(FSaleItem.IDModel) + ' AND ' + APromoFilter;
  end;
end;

function TFrmPromoControl.GetPromoFilter: String;
var
  iIDPromo: Integer;
begin
  Result := '';
  iIDPromo := -1;

  with cdsPromo do
  begin
    First;

    while not Eof do
    begin
      if FieldByName('PromoType').AsInteger = PROMO_TYPE_FREQUENTBUYER then
        iIDPromo := GetValidFrequentBuyerID(FIDCustomer, FSaleItem.IDModel, FSaleItem.IDPreSale, FSaleItem.Qty)
      else if FieldByName('PromoType').AsInteger = PROMO_TYPE_LOYALTY then
        iIDPromo := GetValidLoyaltyID
      else if VerifyValidCoupon(FieldByName('PromoType').AsInteger,FieldByName('Barcode').AsString) then
        iIDPromo := FieldByName('IDPromo').AsInteger
      else if (FieldByName('PromoType').AsInteger = PROMO_TYPE_SALE) then
        iIDPromo := FieldByName('IDPromo').AsInteger;

      if Result <> '' then
        Result := Result + ' OR '
      else
        Result := ' ( ';

      Result := Result + 'IDPromo = ' + IntToStr(iIDPromo);

      Next;
    end;

    if Result <> '' then
      Result := Result + ' ) '
    else
      Result := 'IDPromo = ' + IntToStr(iIDPromo);

    First;
  end;
end;

function TFrmPromoControl.GetValidFrequentBuyerID(IDCustomer, IDModel, IDPreSale: Integer;ItemQty: Double): Integer;
var
  NewQty: Double;
begin

  Result := -1;
  FFrequencyQtySold := 0;

  if (IDCustomer <> 1) then
  begin
    AddPromoFrequentQty(IDModel, IDCustomer,IDPreSale, ItemQty, True);

    if (cdsPromo.FieldByName('QtyFrequent').AsFloat <= GetPromoFrequentQty(IDModel)) then
      Result := cdsPromo.FieldByName('IDPromo').AsInteger;
  end;
end;

function TFrmPromoControl.GetValidCouponID: Integer;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := ' SELECT SP.IDPromo FROM Sal_PromoLoyaltyCustomer SP (NOLOCK) ' +
                ' JOIN Pessoa P (NOLOCK) ON (P.IDTipoPessoa = SP.IDTipoPessoa) ' +
                ' WHERE	SP.IDPromo = ' + cdsPromo.FieldByName('IDPromo').AsString +
                ' AND P.IDPessoa = ' + InttoStr(FIDCustomer);
    Open;

    if not IsEmpty then
      Result := FieldByName('IDPromo').AsInteger
    else
      Result := -1;
  finally
    Close;
  end;
end;

function TFrmPromoControl.GetCustomerSalePrice_FlatPromo(IDCostumer : Integer; SellingPrice : Currency): Currency;
var
  NewSellingPrice : Currency;
begin
  NewSellingPrice := 0;
  Result := 0;

  with DM.quFreeSQL do
  begin
    if Active then
      Close;


    SQL.Text := ' SELECT '+
                '   PRO.IDPromo, '+
                '   PRO.DiscountType, '+
                '   PRO.DiscountValue '+
                ' FROM '+
                '   SaL_Promo PRO (NOLOCK) '+
                '   JOIN Sal_PromoLoyaltyCustomer SP (NOLOCK) ON (SP.IDPromo = Pro.IDPromo) '+
                '   JOIN Pessoa P (NOLOCK) ON (P.IDTipoPessoa = SP.IDTipoPessoa) '+
                '   JOIN Sal_PromoItem SPI (NOLOCK) ON (SPI.IDPromo = PRO.IDPromo) ' +
                ' WHERE '+
                '   PRO.FlatPromo = 1 '+
                '   AND SPI.IDModel = ' + IntToStr(FSaleItem.IDModel) +
                '   AND P.IDPessoa = ' + InttoStr(IDCostumer) +
	              '   AND PRO.StartDate <= :StartDate ' +
                '   AND (PRO.EndDate IS NULL OR PRO.EndDate >= :EndDate ) ' +
                '   AND PRO.DaysOfWeek LIKE ' + QuotedStr('%' + IntToStr(DayOfWeek(Now)) + '%');
    try
      Parameters.ParamByName('StartDate').Value := Now;
      Parameters.ParamByName('EndDate').Value   := Now;
      //Parameters.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
      Open;

      if not IsEmpty then
      begin
        First;
        while not Eof do
        begin
          NewSellingPrice := SellingPrice - GetFlatPromoDiscountValue(FieldByName('DiscountType').AsInteger,
                                                                      FieldByName('DiscountValue').AsFloat,
                                                                      SellingPrice);
          if (NewSellingPrice < Result) or (Result = 0) then
            Result := NewSellingPrice;
          Next;
        end;
      end
      else
        Result := SellingPrice;
    finally
      Close;
     end; 
  end;
end;

procedure TFrmPromoControl.SetParentSaleItem(ASaleItem: TSaleItem);
begin
  with cdsPrizeItemList do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('IDParentSaleItem').AsInteger = 0) and (FieldByName('IDInventoryMovParent').AsInteger = 0) then
      begin
        Edit;
        FieldByName('IDParentSaleItem').AsInteger := ASaleItem.IDPreInventoryMov;
        Post;
      end;
      Next;
    end;
    First;
  end;

  with cdsDiscountPromoQtyList do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('IDPreInventoryMov').AsInteger = 0 then
      begin
        Edit;
        FieldByName('IDPreInventoryMov').AsInteger := ASaleItem.IDPreInventoryMov;
        Post;
      end;
      Next;
    end;
    First;
  end;
end;

procedure TFrmPromoControl.ClearAllFilters;
begin
  cdsPromo.Filter := '';
  cdsPromo.Filtered := False;

  cdsPromoItem.Filter := '';
  cdsPromoItem.Filtered := False;

  cdsPromoPrizeItem.Filter := '';
  cdsPromoPrizeItem.Filtered := False;

  cdsPrizeItemList.Filter := '';
  cdsPrizeItemList.Filtered := False;
end;

procedure TFrmPromoControl.CancelFrequentPromo(AIDModel, AIDCustomer : Integer;  Qty : Double);
begin

  with qryFrequentQty do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := AIDCustomer;
    Parameters.ParamByName('IDModel').Value  := AIDModel;
    Open;
    if not IsEmpty then
    begin
      Edit;
      FieldByName('Qty').Value := FieldByName('Qty').Value - Qty;
      Post;
    end;
  finally
    Close;
  end;

end;

procedure TFrmPromoControl.CancelApplyPromo(AIDParentSaleItem: Integer);
begin
  //se for X.
  with cdsPrizeItemList do
  begin
    Filter := 'IDParentSaleItem = ' + IntToStr(AIDParentSaleItem);
    Filtered := True;
    First;

    while not Eof do
      Delete;
      
    Filter := '';
    Filtered := False;
    First;
  end;
end;

function TFrmPromoControl.GetNewIDPreInventoryMov: Integer;
begin
  with DM.quFreeSQL do
      begin
      if Active then
         Close;
      SQL.Clear;

      SQL.Text := ' SELECT Max(IDPreInventoryMov) IDPreInventoryMov FROM PreInventoryMov (NOLOCK) ';
      Open;

      Result := FieldByName('IDPreInventoryMov').AsInteger + 1;

      Close;
      end;
end;

function TFrmPromoControl.GetFlatPromoDiscountValue(DiscountType: Integer;
  DiscountValue, SellingPrice: Double): Double;
begin
  case DiscountType of
    DISCOUNT_PROMO_TYPE_PERCENTUAL: Result := (DiscountValue / 100)  * SellingPrice;
    DISCOUNT_PROMO_TYPE_VALUE     : Result := DiscountValue;
  else
    Result := 0;
  end;
end;

function TFrmPromoControl.ApplyPromoPrizeItem(ASaleItem: TSaleItem): Boolean;
begin
  Result := False;
  FSaleItem := ASaleItem;

  if IsPrizeItem(FSaleItem.IDModel) then
  begin
    ApplyDiscount;
    ClearAllFilters;
    Result := True;
  end
end;

function TFrmPromoControl.HasPrizeItem(AIDPreInventoryMov: Integer): Boolean;
begin
  with cdsPrizeItemList do
  begin
    Filter := 'IDParentSaleItem = ' + IntToStr(AIDPreInventoryMov);
    Filtered := True;
    Result := RecordCount > 0;
    Filter := '';
    Filtered := True;
  end;
end;

function TFrmPromoControl.ValidateDiscountQty: Boolean;
var
  iIDPromoItem: Integer;
  SumQty : Double;
begin
  Result := True;

  with cdsPromo do
  begin
    iIDPromoItem := GetIDPromoItem(FieldByName('IDPromo').AsInteger, FSaleItem.IDModel);

    if FieldByName('QtyPromoItem').AsFloat > FSaleItemQty then
    begin
      SumQty := FSaleItemQty;

      cdsDiscountPromoQtyList.Filter := 'IDPromoItem = ' + InttoStr(iIDPromoItem);
      cdsDiscountPromoQtyList.Filtered := True;

      cdsDiscountPromoQtyList.First;
      while not cdsDiscountPromoQtyList.Eof do
      begin
        SumQty := SumQty + cdsDiscountPromoQtyList.FieldByName('Qty').AsFloat;
        cdsDiscountPromoQtyList.Next;
      end;

      if FieldByName('QtyPromoItem').AsFloat <= SumQty then
      begin
        SetCDSIndex(cdsDiscountPromoQtyList, 'QTY_INDEX', ['Qty'], []);
        SumQty := FSaleItemQty;
        cdsDiscountPromoQtyList.First;
        while not cdsDiscountPromoQtyList.Eof do
        begin
          SumQty := SumQty + cdsDiscountPromoQtyList.FieldByName('Qty').AsFloat;
          if FieldByName('QtyPromoItem').AsFloat >= SumQty then
          begin
            UpdateParentPromo(cdsDiscountPromoQtyList.FieldByName('IDPreInventoryMov').AsInteger);
            cdsDiscountPromoQtyList.Delete;
          end
          else
          begin
            cdsDiscountPromoQtyList.Edit;
            cdsDiscountPromoQtyList.FieldByName('Qty').AsFloat := (SumQty - FieldByName('QtyPromoItem').AsFloat);
            cdsDiscountPromoQtyList.Post;
            break;
          end;
        end;
      end
      else
      begin
        cdsDiscountPromoQtyList.Append;
        cdsDiscountPromoQtyList.FieldByName('IDPromoItem').AsInteger := iIDPromoItem;
        cdsDiscountPromoQtyList.FieldByName('IDPreInventoryMov').AsInteger := FSaleItem.IDPreInventoryMov;
        cdsDiscountPromoQtyList.FieldByName('IDModel').AsInteger := FSaleItem.IDModel;
        cdsDiscountPromoQtyList.FieldByName('Qty').AsFloat := FSaleItemQty;
        cdsDiscountPromoQtyList.Post;
        Result := False;
      end;

      cdsDiscountPromoQtyList.Filter := '';
      cdsDiscountPromoQtyList.Filtered := False;
    end
    else if FieldByName('QtyPromoItem').AsFloat < FSaleItemQty then
    begin
      FSaleItemQty := FSaleItemQty - FieldByName('QtyPromoItem').AsFloat;
      repeat
        ValidateDiscountQty
      until FSaleItemQty < FieldByName('QtyPromoItem').AsFloat;
    end
    else
      FSaleItemQty := 0;
  end;

  if Result then
    AddDiscountQty(iIDPromoItem, 1);
end;

function TFrmPromoControl.GetIDPromoItem(AIDPromo, AIDModel: Integer): Integer;
begin
  Result := -1;

  if cdsPromoPrizeItem.Locate('IDPromo;IDModelPromoItem', VarArrayOf([AIDPromo, AIDModel]), []) then
    Result := cdsPromoPrizeItem.FieldByName('IDPromoItem').AsInteger;
end;

procedure TFrmPromoControl.UpdateDiscountPromoQtyList(AIDModel, AIDPromoItem: Integer);
var
  dQtyPromoItem: Double;
begin
  with cdsDiscountPromoQtyList do
  begin
    Filter := 'IDModel = ' + InttoStr(AIDModel) + ' AND IDPromoItem <> ' + InttoStr(AIDPromoItem);
    Filtered := True;
    dQtyPromoItem := GetPromoQtyPromoItem(AIDPromoItem);

    while not Eof do
    begin
      Edit;
      FieldByName('Qty').AsFloat := FieldByName('Qty').AsFloat - dQtyPromoItem;
      Post;
      if FieldByName('Qty').AsFloat <= 0 then
        Delete
      else
        Next;
    end;

    Filter := '';
    Filtered := False;
  end;
end;

function TFrmPromoControl.GetPromoQtyPromoItem(AIDPromoItem: Integer): Double;
var
   OldFilter : String;
begin
  Result := 0;
  OldFilter := cdsPromoItem.Filter;
  cdsPromoItem.Filter := FDefaultPromoFilter;

  if cdsPromoItem.Locate('IDPromoItem', AIDPromoItem, []) then
    if cdsPromo.Locate('IDPromo', cdsPromoItem.FieldByName('IDPromo').AsInteger, []) then
      Result := cdsPromo.FieldByName('QtyPromoItem').AsFloat;

  cdsPromoItem.Filter := OldFilter;
end;

function TFrmPromoControl.GetPromoFrequentQtyPromoItem(AIDPromoItem: Integer): Double;
var
   OldFilter : String;
begin
  Result := 0;
  OldFilter := cdsPromoItem.Filter;
  cdsPromoItem.Filter := FDefaultPromoFilter;

  if cdsPromoItem.Locate('IDPromoItem', AIDPromoItem, []) then
    if cdsPromo.Locate('IDPromo', cdsPromoItem.FieldByName('IDPromo').AsInteger, []) then
      Result := cdsPromo.FieldByName('QtyFrequent').AsFloat;

  cdsPromoItem.Filter := OldFilter;
end;

procedure TFrmPromoControl.RemoveAnotherPromoQtyList(AIDModelPromoItem, AIDPromoItem: Integer);
var
  iIDModel, iIDPromoItem: Integer;
  dItemQty, dQty: Double;
  sOldFilter: String;
begin
  dItemQty     := GetPromoQtyPromoItem(AIDPromoItem);
  iIDPromoItem := -1;

  with cdsPrizeItemList do
  begin
    sOldFilter := Filter;

    Filter := ' IDPromoItem <> ' + InttoStr(AIDPromoItem) + ' AND DiscountType = ' + InttoStr(DISCOUNT_PROMO_TYPE_QTY);
    Filtered := True;

    SetCDSIndex(cdsPrizeItemList, 'PROMOITEM_INDEX', ['IDPromoItem'], []);

    First;
    while not Eof do
    begin
      if iIDPromoItem <> FieldByName('IDPromoItem').AsInteger then
      begin
        iIDPromoItem := FieldByName('IDPromoItem').AsInteger;

        if AIDModelPromoItem = iIDModel then
        begin
          dQty := GetPromoQtyPromoItem(iIDPromoItem);

          if dQty > dItemQty then
            begin
              cdsDiscountPromoQtyList.Append;
              cdsDiscountPromoQtyList.FieldByName('IDPromoItem').AsInteger := iIDPromoItem;
              cdsDiscountPromoQtyList.FieldByName('IDPreInventoryMov').AsInteger := FieldByName('IDParentSaleItem').AsInteger;
              cdsDiscountPromoQtyList.FieldByName('IDModel').AsInteger := iIDModel;
              cdsDiscountPromoQtyList.FieldByName('Qty').AsFloat := dQty - dItemQty;
              cdsDiscountPromoQtyList.Post;
            end;

          Delete;
        end;
      end;
      Next;
    end;
    Filter := sOldFilter;
  end;
end;

procedure TFrmPromoControl.FormCreate(Sender: TObject);
begin
  FDiscountQty := TStringList.Create;
  FPromoFrequentQty := TStringList.Create;
end;

procedure TFrmPromoControl.ClearDiscountQty;
var
  i : Integer;
  ADiscountInfo : TDiscountInfo;
begin

  for i := 0 to (FDiscountQty.Count-1) do
  begin
    ADiscountInfo := TDiscountInfo(FDiscountQty.Objects[i]);
    ADiscountInfo.Free;
  end;

  FDiscountQty.Clear;

end;

{
procedure TFrmPromoControl.ClearPromoFrequentQty;
var
  AFrequentInfo : TFrequentInfo;
begin

  while FPromoFrequentQty.Count > 0 do
  begin
    AFrequentInfo := TFrequentInfo(FPromoFrequentQty.Objects[0]);

    if AFrequentInfo <> nil then
      FreeAndNil(AFrequentInfo);

    FPromoFrequentQty.Delete(0);
  end;

  FPromoFrequentQty.Clear;
end;
}

procedure TFrmPromoControl.AddDiscountQty(IDPromoItem: Integer;
  Qty: Double);
var
  iIndex : Integer;
  ADiscountInfo : TDiscountInfo;
begin

  iIndex := FDiscountQty.IndexOf(IntToStr(IDPromoItem));

  if iIndex = -1 then
  begin
    ADiscountInfo             := TDiscountInfo.Create;
    ADiscountInfo.IDPromoItem := IDPromoItem;
    ADiscountInfo.Qty         := Qty;

    FDiscountQty.AddObject(IntToStr(IDPromoItem), ADiscountInfo);
  end
  else
  begin
    ADiscountInfo := TDiscountInfo(FDiscountQty.Objects[iIndex]);
    ADiscountInfo.Qty := ADiscountInfo.Qty + Qty;

    FDiscountQty.Objects[iIndex] := ADiscountInfo;
  end;

end;

procedure TFrmPromoControl.AddPromoFrequentQty(IDModel, IDCustomer, IDPreSale: Integer;
  Qty: Double; CleanQtyPrizeItem: Boolean);
var
  iIndex : Integer;
  AFrequentInfo : TFrequentInfo;
  iMaxID : Integer;
  QtyFreq : Double;
begin

  iIndex := FPromoFrequentQty.IndexOf(IntToStr(IDModel));

  with qryFrequentQty do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := IDCustomer;
    Parameters.ParamByName('IDModel').Value :=  IDModel;
    Open;

    if (not (IDCustomer in [0, 1])) and (IDCustomer <> -1) then
    begin
      if Qty <> 0 then
        if IsEmpty then
        begin
          Append;
          FieldByName('IDFrequentPromo').Value := DM.GetNextID('Sal_FrequentPromo.IDFrequentPromo');
          FieldByName('IDPessoa').Value        := IDCustomer;
          FieldByName('IDModel').Value         := IDModel;
          FieldByName('Qty').Value             := Qty;
          FieldByName('IsUsed').Value          := 0;
          Post;
        end
        else
        begin
          Edit;
          FieldByName('Qty').Value             := FieldByName('Qty').Value + Qty;
          Post;
        end;

      QtyFreq := FieldByName('Qty').asFloat;
    end;

  finally
    Close;
  end;

  if iIndex = -1 then
  begin
    AFrequentInfo             := TFrequentInfo.Create;
    AFrequentInfo.IDModel     := IDModel;
    AFrequentInfo.Qty         := QtyFreq;

    FPromoFrequentQty.AddObject(IntToStr(IDModel), AFrequentInfo);
  end
  else
  begin
    AFrequentInfo := TFrequentInfo(FPromoFrequentQty.Objects[iIndex]);
    AFrequentInfo.Qty := AFrequentInfo.Qty + Qty;

    if CleanQtyPrizeItem then
      AFrequentInfo.QtyPrizeItem := 0;

    FPromoFrequentQty.Objects[iIndex] := AFrequentInfo;
  end;

end;

function TFrmPromoControl.GetDiscountQty(IDPromoItem: Integer): Double;
var
  iIndex : Integer;
begin

  Result := 0;

  iIndex := FDiscountQty.IndexOf(IntToStr(IDPromoItem));

  if iIndex <> -1 then
    Result := TDiscountInfo(FDiscountQty.Objects[iIndex]).Qty;

end;

function TFrmPromoControl.GetPromoFrequentQty(IDModel: Integer): Double;
var
  iIndex : Integer;
begin

  Result := 0;

  iIndex := FPromoFrequentQty.IndexOf(IntToStr(IDModel));

  if iIndex <> -1 then
    Result := TFrequentInfo(FPromoFrequentQty.Objects[iIndex]).Qty;

end;

function TFrmPromoControl.GetPrizeFrequentQty(IDModel: Integer; FrequentQty: Double): Integer;
var
  iIndex: Integer;
  NewQty, QtyTotal: Double;
begin

  Result := 0;

  iIndex := FPromoFrequentQty.IndexOf(IntToStr(IDModel));

  if iIndex <> -1 then
  begin
    if TFrequentInfo(FPromoFrequentQty.Objects[iIndex]).QtyPrizeItem = 0 then
    begin
      NewQty := TFrequentInfo(FPromoFrequentQty.Objects[iIndex]).Qty;
      QtyTotal := NewQty;

      while  NewQty >= FrequentQty do
      begin
        NewQty := (NewQty - FrequentQty);
        inc(Result);
      end;

      if Result <> 0 then
        AddPromoFrequentQty(IDModel, -1, -1, (QtyTotal * -1), False);

      TFrequentInfo(FPromoFrequentQty.Objects[iIndex]).QtyPrizeItem := Result;
    end
    else
      Result := Trunc(TFrequentInfo(FPromoFrequentQty.Objects[iIndex]).QtyPrizeItem);
  end;
end;

function TFrmPromoControl.IsValidCupom(Coupon: String): Boolean;
var
  sFilter, OldFilter : String;
begin
 OldFilter := cdsPromo.Filter;
 cdsPromo.Filter := FDefaultPromoFilter;
 Result := cdsPromo.Locate('PromoType;Barcode', VarArrayOf([PROMO_TYPE_COUPON, Coupon]),[]);
 cdsPromo.Filter := OldFilter;
end;

procedure TFrmPromoControl.VerifyFrequentPromo(IDCostumer, IDPreSale: Integer);
var
  sIDPromo, sCustomerHistory : String;
  dFrequentQtyPromoItem, dPrizeFrequentQty: Double;
begin
  sIDPromo := '';
  sCustomerHistory := GetCustomerProductsList(IDCostumer, IDPreSale);
  //ClearPromoFrequentQty;

  if sCustomerHistory <> '' then
  begin
    with cdsPromo do
    begin
      Filter := FDefaultPromoFilter;
      Filtered := True;
      First;
      while not Eof do
      begin
        if FieldByName('PromoType').AsInteger = PROMO_TYPE_FREQUENTBUYER then
        begin
          if sIDPromo <> '' then
            sIDPromo := sIDPromo + ' OR '
          else
            sIDPromo := ' ( ';

          sIDPromo := sIDPromo + 'IDPromo = ' + FieldByName('IDPromo').AsString;
        end;
        Next;
      end;

      if sIDPromo <> '' then
        sIDPromo := sIDPromo + ' ) ';

      First;
    end;

    if sIDPromo <> '' then
    begin
      with cdsPromoItem do
      begin
        Filtered := False;
        Filter   := FDefaultPromoFilter + ' AND ' + sIDPromo + sCustomerHistory;
        Filtered := True;
        sIDPromo := '';
        First;
        while not Eof do
        begin
          if GetValidFrequentBuyerID(IDCostumer, FieldByName('IDModel').AsInteger, IDPreSale, 0) <> -1 then
          begin
            if sIDPromo <> '' then
              sIDPromo := sIDPromo + ' OR '
            else
              sIDPromo := ' ( ';

            sIDPromo := sIDPromo + 'IDPromo = ' + FieldByName('IDPromo').AsString;
          end;
          Next;
        end;

        if sIDPromo <> '' then
          sIDPromo := sIDPromo + ' ) ';

      end;

      if sIDPromo <> '' then
      begin
      with cdsPromoPrizeItem do
        begin
          Filtered := False;
          Filter   := FDefaultPromoFilter + ' AND ' + sIDPromo;
          Filtered := True;
          AddPrizeItemList(1);
        end;
      end;

      if sIDPromo <> '' then
      begin
      with cdsPrizeItemList do
        begin
          First;
          While not Eof do
          begin
            if FieldByName('IDParentSaleItem').AsInteger = 0 then
            begin
              dFrequentQtyPromoItem := GetPromoFrequentQtyPromoItem(FieldByName('IDPromoItem').AsInteger);
              dPrizeFrequentQty     := GetPrizeFrequentQty(FieldByName('IDModelPromoItem').AsInteger, dFrequentQtyPromoItem);

              cdsPrizeItemList.Edit;
              FieldByName('Qty').AsInteger                  := GetPrizeFrequentQty(
                                                                    FieldByName('IDModelPromoItem').AsInteger,
                                                                    dFrequentQtyPromoItem
                                                               );
              FieldByName('IDFrequentPromo').AsInteger := GetParentSaleItemFrequentPromo(
                                                                    FieldByName('IDModelPromoItem').AsInteger,
                                                                    IDCostumer,
                                                                    dFrequentQtyPromoItem
                                                               );
              FieldByName('QtyFrequent').AsFloat       := dFrequentQtyPromoItem;

              cdsPrizeItemList.Post;
            end;
            Next;
          end;
        end;
      end;
    end;
  end;

  ClearAllFilters;
end;

function TFrmPromoControl.GetCustomerProductsList(IDCustomer,
   IDPreSale: Integer): String;
begin

  Result := '';

  DM.quFreeSQL.SQL.Clear;
  DM.quFreeSQL.SQL.Add('SELECT IM.IDModel');
  DM.quFreeSQL.SQL.Add('FROM Sal_FrequentPromo IM (NOLOCK)');
  DM.quFreeSQL.SQL.Add('JOIN Model M (NOLOCK) ON (M.IDModel = IM.IDModel)');
  DM.quFreeSQL.SQL.Add('WHERE IM.IDPessoa = :IDPessoa AND IM.IsUsed = 0');
  DM.quFreeSQL.SQL.Add(' AND M.ModelType in ('+QuotedStr('S')+', ' + QuotedStr('R') + ', ' + QuotedStr('K')+')');
  DM.quFreeSQL.SQL.Add('GROUP BY IM.IDModel');


  DM.quFreeSQL.Parameters.ParamByName('IDPessoa').Value    := IDCustomer;
  DM.quFreeSQL.Open;
  while not DM.quFreeSQL.EOF do
  begin
    Result := Result + DM.quFreeSQL.FieldByName('IDModel').AsString;
    DM.quFreeSQL.Next;
    if not DM.quFreeSQL.EOF then
      Result := Result + ', ';
  end;
  DM.quFreeSQL.Close;

  if Result <> '' then
    Result := ' AND IDModel IN ( ' + Result +' )';

end;


function TFrmPromoControl.GetParentSaleItemFrequentPromo(IDModel,IDCostumer: Integer; FrequentQtyPromoItem: Double): Integer;
var
  dQty: Double;
begin

  Result := 0;

  with qryFrequentQty do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPessoa').Value := IDCostumer;
    Parameters.ParamByName('IDModel').Value  := IDModel;
    Open;
    if not IsEmpty then
      Result := FieldByName('IDFrequentPromo').AsInteger;
  finally
    Close;
  end;

end;

function TFrmPromoControl.IsPromoSellingPriceBetter: Boolean;
begin
  Result := True;

  if (FSaleItem.KitSellingPrice <> 0) or (FSaleItem.CustomerSellingPrice <> 0) then
    Result := ((FSaleItem.PromoSellingPrice < FSaleItem.KitSellingPrice) and
              (FSaleItem.PromoSellingPrice < FSaleItem.CustomerSellingPrice));
end;

procedure TFrmPromoControl.UpdateParentPromo(IDPreInventoryMovParent: Integer);
begin
  with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Clear;

      SQL.Text := ' UPDATE PreInventoryMov SET Promo = 1 ' +
                  ' WHERE IDPreInventoryMov = ' + InttoStr(IDPreInventoryMovParent);
      ExecSQL;
      Close;
    end;
end;

function TFrmPromoControl.GetValidLoyaltyID: Integer;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Text := ' SELECT SP.IDPromo FROM Sal_PromoLoyaltyCustomer SP (NOLOCK) ' +
                ' JOIN Pessoa P (NOLOCK) ON (P.IDTipoPessoa = SP.IDTipoPessoa) ' +
                ' WHERE SP.IDPromo = ' + cdsPromo.FieldByName('IDPromo').AsString +
                ' AND P.IDPessoa = ' + InttoStr(FIDCustomer);
    Open;

    if not IsEmpty then
      Result := FieldByName('IDPromo').AsInteger
    else
      Result := -1;
  end;
end;

function TFrmPromoControl.VerifyValidCoupon(PromoType: Integer;
  Coupon: String): Boolean;
begin
  Result := ((PromoType = PROMO_TYPE_COUPON) and (Coupon = FCoupon));
end;


procedure TFrmPromoControl.FormDestroy(Sender: TObject);
begin
  ClearDiscountQty;
  FreeAndNil(FDiscountQty);
  FreeAndNil(FPromoFrequentQty);
end;

function TFrmPromoControl.ApplySalePromo(ADocumentID, AIDCliente: Integer;
                                         APreSaleDate: TDateTime;
                                         IsLoyalty : Boolean): Boolean;
var
  bLocateInPromoPrize, HavePrize, bIsPromoItem : Boolean;
  dTotalDiscountPromo: Double;
  betterDiscount: currency;
begin
  FStart := True;
  OnBeforerApplyPromo;

  //Verifica se os itens que estão na venda possuem Promoção
  if VerifySaleItemsInPromo(ADocumentID, HavePrize) then
  //if 1=1 then
  begin
    //Faz a leitura de todos os Itens que pertencem a venda
    with spquPreSaleItem do
    begin
      Close;
      Parameters.ParambyName('@DocumentID').Value := ADocumentID;
      Parameters.ParambyName('@IsPreSale').Value  := True;
      Parameters.ParambyName('@Date').Value       := Now;
      Open;
    end;

    //Inclui todos os itens no ClientDataSet que será utilizado
    //para econtrar o melhor desconto de cada item
    if spquPreSaleItem.RecordCount > 0 then
    begin
      cdsSaleItems.Close;
      cdsSaleItems.CreateDataSet;

      CdsSaleItemsClone.Close;
      CdsSaleItemsClone.CreateDataSet;

      //cdsSaleItems.DisableControls;

      FIndiceInsert := 0;
      while not spquPreSaleItem.Eof do
      begin
        if HavePrize then
          bLocateInPromoPrize := cdsValidateSaleitemInPromoPrize.Locate('IDModel', spquPreSaleItemModelID.AsInteger, [])
        else
          bLocateInPromoPrize := False;

        bIsPromoItem := cdsValidateSaleItemInPromo.Locate('IDModel', spquPreSaleItemModelID.AsInteger, []);

        if (bIsPromoItem or bLocateInPromoPrize) then
          begin
            Inc(FIndiceInsert);

            cdsSaleItems.Append;
            cdsSaleItemsIDInventoryMov.AsInteger := spquPreSaleItemIDInventoryMov.AsInteger;
            cdsSaleItemsIDModel.AsInteger := spquPreSaleItemModelID.AsInteger;
            cdsSaleItemsSalePrice.AsFloat := spquPreSaleItemSalePrice.AsFloat;
            cdsSaleItemsTotalDiscountApplied.AsFloat := 0;
            cdsSaleItemsQty.AsFloat := spquPreSaleItemQty.AsFloat;
            cdsSaleItemsInUse.AsBoolean := False;
            cdsSaleItemsIsPrize.AsBoolean := bLocateInPromoPrize;
            cdsSaleItemsIsNew.AsBoolean := False;
            cdsSaleItemsIsDeleted.AsBoolean := False;
            cdsSaleItemsIsUpdate.AsBoolean := False;
            cdsSaleItemsIndice.AsInteger := FIndiceInsert;
            cdsSaleItemsDiscountLoyalt.AsFloat := spquPreSaleItemDiscountLoyalt.AsFloat;

            if bIsPromoItem then
              cdsSaleItemsFlatPromo.AsBoolean := cdsValidateSaleItemInPromoFlatPromo.AsBoolean
            else
              cdsSaleItemsFlatPromo.AsBoolean := False;

            cdsSaleItemsIDComission.AsInteger := spquPreSaleItemIDComission.AsInteger;
            cdsSaleItemsIDUser.AsInteger := spquPreSaleItemIDUser.AsInteger;
            cdsSaleItemsIDDepartment.AsInteger := spquPreSaleItemIDDepartment.AsInteger;
            cdsSaleItemsCostPrice.asFloat := spquPreSaleItemCostPrice.AsFloat;
            cdsSaleItems.Post;

            if bIsPromoItem and cdsValidateSaleItemInPromoFlatPromo.AsBoolean then
              bLocateInPromoPrize := True;

            InsertNewSaleItemClone(spquPreSaleItemIDInventoryMov.AsInteger,
                                   spquPreSaleItemModelID.AsInteger,
                                   FIndiceInsert,
                                   spquPreSaleItemIDComission.AsInteger,
                                   spquPreSaleItemIDUser.AsInteger,
                                   spquPreSaleItemIDDepartment.AsInteger,
                                   spquPreSaleItemSalePrice.AsFloat,
                                   spquPreSaleItemQty.AsFloat,
                                   spquPreSaleItemCostPrice.AsFloat,
                                   False,
                                   bLocateInPromoPrize,
                                   False,
                                   False,
                                   cdsValidateSaleItemInPromoFlatPromo.AsBoolean,
                                   spquPreSaleItemDiscountLoyalt.AsFloat);
          end;

        spquPreSaleItem.Next;
      end;//Fim while

   end;//Fim if spquPreSaleItem.RecordCount > 0

   spquPreSaleItem.Close;

   FStart := False;

   dTotalDiscountPromo := 0;
   if not chkTestPromo.Checked then
   begin
     if AIDCliente > 1 then
     begin
      dTotalDiscountPromo := CalPromoFrequentByer(AIDCliente, ADocumentID);
     end;

     dTotalDiscountPromo := dTotalDiscountPromo + CalcPromoItem(FCoupon, ADocumentID,
                                                                AIDCliente, APreSaleDate, IsLoyalty);

     if dTotalDiscountPromo > 0 then
       SettingSaleItemsWithPromo(ADocumentID, AIDCliente, APreSaleDate);

     CdsSaleItems.Close;
     CdsSaleItemsClone.Close;

   end
   else
     Result := True;
  end;

  if AIDCliente > 1 then
  begin
    with qryFrequentQtySalePromo do
    begin
      Close;
      Parameters.ParamByName('DocumentID').value := ADocumentID;
      Parameters.ParamByName('StartDate').value := now;
      Parameters.ParamByName('EndDate').value := now;
      Parameters.ParamByName('DayOfWeek').value := IntToStr(DayOfWeek(Now));
      Open;
    end;
  end;


  ClearAllFilters;

  FPreSaleDate := APreSaleDate;
  FIDCustomer := AIDCliente;
  FIsLoyalty  := IsLoyalty;
  FIDPreSale := ADocumentID;

end;

function TFrmPromoControl.VerifySaleItemsInPromo(
  ADocumentID: Integer; var HavePrize : Boolean): Boolean;
var
  QtdNoFlatPromo, QtdFlatPromo : Integer;
begin
  QtdNoFlatPromo := 0;
  QtdFlatPromo := 0;
  HavePrize := False;

  //Abre a consulta que retorna se algum item da venda atual está em alguma promoção
  with cdsValidateSaleItemInPromo do
  begin
    Close;
    //DisableControls;
    //FetchParams;
    if not Active then
    begin
      Params.ParamByName('DocumentID').Value := ADocumentID;
      Params.ParamByName('StartDate').Value := Now;
      Params.ParamByName('EndDate').Value := Now;
      Params.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
      Open;
      Filtered := True;

      Filter := '[FlatPromo]';
      if not cdsValidateSaleItemInPromo.IsEmpty then
         QtdFlatPromo := cdsValidateSaleItemInPromo.RecordCount;

      Filter := 'not [FlatPromo]';
      if not cdsValidateSaleItemInPromo.IsEmpty then
         QtdNoFlatPromo := cdsValidateSaleItemInPromo.RecordCount;

      Filtered := False;

    end;
  end;
  {
    QtdNoFlatPromo = Quantidade de Itens que estão em promoção mas não é do tipo FlatPromo
    QtdFlatPromo = Quantidade de Itens que estão em promoção dotipo FlatPromo
  }
  {
  if (QtdNoFlatPromo = 0) and
     (QtdFlatPromo = 0) then
     Result := False
  else if (QtdFlatPromo >= 1) and (QtdNoFlatPromo >= 0) then
    Result := True
  else if (QtdNoFlatPromo >= 1) then
  begin
  }
    //HavePrize := True;
    {
      Se existem item em promoção que não são do tipo FlatPromo, então procura
      pelos seus itens na PromoPrize
    }
    with cdsValidateSaleitemInPromoPrize do
    begin
      Close;
      DisableControls;
      FetchParams;
      if not Active then
      begin
        Params.ParamByName('DocumentID').Value := ADocumentID;
        Params.ParamByName('DocumentID2').Value := ADocumentID;
        Params.ParamByName('StartDate').Value := Now;
        Params.ParamByName('EndDate').Value := Now;
        Params.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
        Open;
      end;
    end;

    {
    if cdsValidateSaleitemInPromoPrize.RecordCount = 0 then
    begin
      Result := False
    end
    else
    begin
      HavePrize := True;
      Result := True;
    end;
    }

    if cdsValidateSaleitemInPromoPrize.RecordCount > 0 then
      HavePrize := True;


  if ((QtdFlatPromo >= 1) or (QtdNoFlatPromo >= 0) or (HavePrize))  then
    Result := True
  else
    Result := False;


  //end;

end;

function TFrmPromoControl.CalcPromoItem(FCoupon : String; fIDPreSale,
                                        fIDCliente : Integer;
                                        APreSaleDate: TDateTime;
                                        IsLoyalty : Boolean) : Double;
var
  iIDInventoryMov, iIDPromo : Integer;
  bFlatPromo : Boolean;
  dQtyPromoitem, dDiscountValue, dTotalDiscount,
  dTotalDiscountPromo, dFrequentQty: Double;
begin
  FNewIDInventoryMov := 0;
  dTotalDiscountPromo := 0;

  cdsSaleItems.Filter := 'IsPrize=False';
  cdsSaleItems.Filtered := True;

  If not cdsSaleItems.IsEmpty then
  begin
    //Percorre os Itens que foram encontrados na venda e possuem promoção
    cdsSaleItems.First;
    while not cdsSaleItems.Eof do
    begin
      if not cdsSaleItemsIsDeleted.AsBoolean then
      begin
        //Armazena o IDInventoryMov Corrente
        iIDInventoryMov := cdsSaleItemsIDInventoryMov.AsInteger;


        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

        { PROMO_TYPE_SALE e DISCOUNT_PROMO_TYPE_QTY}
        cdsPromoItem.Filter := FDefaultPromoFilter + ' AND IDModel = ' + cdsSaleItemsIDModel.AsString +
                               ' AND PromoType = ' + IntToStr(PROMO_TYPE_SALE) +
                               ' AND DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_QTY);

        cdsPromoItem.Filtered := True;

        if not cdsPromoItem.IsEmpty then
        begin

          cdsPromoItem.IndexName := 'cdsPromoItemIndex1';
          cdsPromoItem.First;
          CdsSaleItemsClone.Filtered := True;
          while (not cdsPromoItem.eof) do
          begin
            dTotalDiscount := 0;

            CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString +
                                        ' and IsDeleted=False' +
                                        ' and IDPromo <> ' + InttoStr(cdsPromoItemIDPromo.asInteger);
            CdsSaleItemsClone.Filtered := True;
            //cdsSaleItemsCloneSumQty.Active := True;

            //amfsouza July 30. 2012 - under test yet.
            if CdsSaleItemsClone.FieldByName('SumQty').Value > cdsPromoItem.FieldByName('QtyPromoItem').Value then
            begin
              iIDPromo       := cdsPromoItem.FieldByName('IDPromo').AsInteger;
              bFlatPromo     := cdsPromoItem.FieldByName('FlatPromo').AsBoolean;
              dQtyPromoitem  := cdsPromoItem.FieldByName('QtyPromoitem').AsFloat;
              dDiscountValue := cdsPromoItem.FieldByName('DiscountValue').AsFloat;

              //Pode calcular o desconto
              dTotalDiscount := CalPromoSaleQuantity(bFlatPromo,
                                   cdsSaleItemsIDInventoryMov.AsInteger,
                                   cdsSaleItemsIDModel.AsInteger,
                                   iIDPromo,
                                   cdsPromoItemPromoType.AsInteger,
                                   cdsPromoItemDiscountType.AsInteger,
                                   dDiscountValue);


                if dTotalDiscount > 0 then
                begin
                  dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;
                  //Caso o item corrente tenha a quantidade maior ou menor que o neessário
                  //então chama a função que vai efetuar o ajuste na quantidade do item

                  if ( cdsPromoItem.FieldByName('DiscountType').Value <> DISCOUNT_PROMO_TYPE_QTY ) then begin
                      if cdsSaleItemsQty.AsFloat <> cdsPromoItem.FieldByName('QtyPromoItem').Value then
                      begin
                        AlterListSaleItens(cdsSaleItemsIDModel.AsInteger,
                                           cdsSaleItemsIDInventoryMov.AsInteger,
                                           dQtyPromoitem);
                      end;
                  end;

                  SetSaleItemInUse(cdsPromoItemPromoType.AsInteger,
                                   cdsPromoItemDiscountType.AsInteger,
                                   iIDPromo,
                                   dTotalDiscount);
                end;

              end;//fim if CdsSaleItemsClone.FieldByName('SumQty').Value >= cdsPromoItem.FieldByName('QtyPromoItem').Value then

            cdsPromoItem.Next;
          end;//fim while not cdsPromoItem.eof do

        end;// if not cdsPromoItem.IsEmpty then
// ---------------- PROMO_TYPE = SALE AND DISCOUNT_TYPE = QUANTITY -----------------------------------------

        { PROMO_TYPE_SALE e DISCOUNT_PROMO_TYPE_PERCENTUAL ou DISCOUNT_PROMO_TYPE_VALUE}
        cdsPromoItem.IndexName := '';
        cdsPromoItem.Filter := FDefaultPromoFilter + ' AND IDModel = ' + cdsSaleItemsIDModel.AsString +
                               ' AND PromoType = ' + IntToStr(PROMO_TYPE_SALE) +
                               ' AND ( (DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_PERCENTUAL) + ') or' +
                               '       (DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_VALUE) + ') )';

        cdsPromoItem.Filtered := True;

        if not cdsPromoItem.IsEmpty then
        begin

          cdsPromoItem.First;
          CdsSaleItemsClone.Filtered := True;
          while (not cdsPromoItem.eof) do
          begin
            dTotalDiscount := 0;

            CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString;
            CdsSaleItemsClone.AggregatesActive := True;
            cdsSaleItemsCloneSumQty.Active := True;

            iIDPromo       := cdsPromoItem.FieldByName('IDPromo').AsInteger;
            bFlatPromo     := cdsPromoItem.FieldByName('FlatPromo').AsBoolean;
            dQtyPromoitem  := cdsPromoItem.FieldByName('QtyPromoitem').AsFloat;
            dDiscountValue := cdsPromoItem.FieldByName('DiscountValue').AsFloat;

            dTotalDiscount := CalPromoSalePercentAmount(bFlatPromo,
                                                        cdsSaleItemsIDInventoryMov.AsInteger,
                                                        cdsSaleItemsIDModel.AsInteger,
                                                        iIDPromo,
                                                        cdsPromoItemPromoType.AsInteger,
                                                        cdsPromoItemDiscountType.AsInteger,
                                                        cdsSaleItemsQty.AsFloat,
                                                        cdsPromoItemDiscountValue.AsFloat,
                                                        cdsSaleItemsTotalDiscountApplied.AsFloat,
                                                        0);

            if dTotalDiscount > 0 then
            begin
              dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;

              SetSaleItemInUse(cdsPromoItemPromoType.AsInteger,
                               cdsPromoItemDiscountType.AsInteger,
                               iIDPromo,
                               dTotalDiscount);
            end;

            cdsPromoItem.Next;
          end;//fim while not cdsPromoItem.eof do

        end; //if not cdsPromoItem.IsEmpty then



//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

        if IsLoyalty then
        begin
          { PROMO_TYPE_LOYALTY e DISCOUNT_PROMO_TYPE_PERCENTUAL ou DISCOUNT_PROMO_TYPE_VALUE}
          cdsPromoItem.IndexName := '';
          cdsPromoItem.Filter := FDefaultPromoFilter + ' AND IDModel = ' + cdsSaleItemsIDModel.AsString +
                                 ' AND PromoType = ' + IntToStr(PROMO_TYPE_LOYALTY) +
                                 ' AND ( (DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_PERCENTUAL) + ') or' +
                                 '       (DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_VALUE) + ') )';

          cdsPromoItem.Filtered := True;

          if not cdsPromoItem.IsEmpty then
          begin

            cdsPromoItem.First;
            CdsSaleItemsClone.Filtered := True;
            while (not cdsPromoItem.eof) do
            begin
              dTotalDiscount := 0;

              CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString;
              CdsSaleItemsClone.AggregatesActive := True;
              cdsSaleItemsCloneSumQty.Active := True;

              iIDPromo       := cdsPromoItem.FieldByName('IDPromo').AsInteger;
              bFlatPromo     := cdsPromoItem.FieldByName('FlatPromo').AsBoolean;
              dQtyPromoitem  := cdsPromoItem.FieldByName('QtyPromoitem').AsFloat;
              dDiscountValue := cdsPromoItem.FieldByName('DiscountValue').AsFloat;

              dTotalDiscount := CalPromoSalePercentAmount(bFlatPromo,
                                                          cdsSaleItemsIDInventoryMov.AsInteger,
                                                          cdsSaleItemsIDModel.AsInteger,
                                                          iIDPromo,
                                                          cdsPromoItemPromoType.AsInteger,
                                                          cdsPromoItemDiscountType.AsInteger,
                                                          cdsSaleItemsQty.AsFloat,
                                                          cdsPromoItemDiscountValue.AsFloat,
                                                          cdsSaleItemsTotalDiscountApplied.AsFloat,
                                                          cdsSaleItemsDiscountLoyalt.AsFloat);

              if dTotalDiscount > 0 then
              begin
                dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;

                SetSaleItemInUse(cdsPromoItemPromoType.AsInteger,
                                 cdsPromoItemDiscountType.AsInteger,
                                 iIDPromo,
                                 dTotalDiscount);
              end;

              cdsPromoItem.Next;
            end;//fim while not cdsPromoItem.eof do

          end; //if not cdsPromoItem.IsEmpty the



        { PROMO_TYPE_LOYALTY e DISCOUNT_PROMO_TYPE_QTY}
        cdsPromoItem.Filter := FDefaultPromoFilter + ' AND IDModel = ' + cdsSaleItemsIDModel.AsString +
                               ' AND PromoType = ' + IntToStr(PROMO_TYPE_LOYALTY) +
                               ' AND DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_QTY);

        cdsPromoItem.Filtered := True;

        if not cdsPromoItem.IsEmpty then
        begin

          cdsPromoItem.IndexName := 'cdsPromoItemIndex1';
          cdsPromoItem.First;
          CdsSaleItemsClone.Filtered := True;
          while (not cdsPromoItem.eof) do
          begin
            dTotalDiscount := 0;

            //CdsSaleItemsClone.AggregatesActive := True;
            //cdsSaleItemsCloneSumQty.Active := False;
            CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString +
                                        ' and IsDeleted=False' +
                                        ' and IDPromo <> ' + InttoStr(cdsPromoItemIDPromo.asInteger);
            CdsSaleItemsClone.Filtered := True;
            //cdsSaleItemsCloneSumQty.Active := True;

            if CdsSaleItemsClone.FieldByName('SumQty').Value >= cdsPromoItem.FieldByName('QtyPromoItem').Value then
            begin
              iIDPromo       := cdsPromoItem.FieldByName('IDPromo').AsInteger;
              bFlatPromo     := cdsPromoItem.FieldByName('FlatPromo').AsBoolean;
              dQtyPromoitem  := cdsPromoItem.FieldByName('QtyPromoitem').AsFloat;
              dDiscountValue := cdsPromoItem.FieldByName('DiscountValue').AsFloat;

              //Pode calcular o desconto
              dTotalDiscount := CalPromoSaleQuantity(bFlatPromo,
                                   cdsSaleItemsIDInventoryMov.AsInteger,
                                   cdsSaleItemsIDModel.AsInteger,
                                   iIDPromo,
                                   cdsPromoItemPromoType.AsInteger,
                                   cdsPromoItemDiscountType.AsInteger,
                                   dDiscountValue);


                if dTotalDiscount > 0 then
                begin
                  dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;
                  //Caso o item corrente tenha a quantidade maior ou menor que o neessário
                  //então chama a função que vai efetuar o ajuste na quantidade do item
                  if cdsSaleItemsQty.AsFloat <> cdsPromoItem.FieldByName('QtyPromoItem').Value then
                  begin
                    AlterListSaleItens(cdsSaleItemsIDModel.AsInteger,
                                       cdsSaleItemsIDInventoryMov.AsInteger,
                                       dQtyPromoitem);
                  end;

                  SetSaleItemInUse(cdsPromoItemPromoType.AsInteger,
                                   cdsPromoItemDiscountType.AsInteger,
                                   iIDPromo,
                                   dTotalDiscount);
                end;

              end;//fim if CdsSaleItemsClone.FieldByName('SumQty').Value >= cdsPromoItem.FieldByName('QtyPromoItem').Value then

            cdsPromoItem.Next;
          end;//fim while not cdsPromoItem.eof do

        end;// if not cdsPromoItem.IsEmpty then


        end;//fim if IsLoyalty then

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


        if FCoupon <> '' then
        begin
          { PROMO_TYPE_COUPON e DISCOUNT_PROMO_TYPE_QTY}
          cdsPromoItem.Filter := FDefaultPromoFilter + ' AND IDModel = ' + cdsSaleItemsIDModel.AsString +
                                 ' AND PromoType = ' + IntToStr(PROMO_TYPE_COUPON) +
                                 ' AND DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_QTY) +
                                 ' AND Barcode = ''' + FCoupon + '''';

          cdsPromoItem.Filtered := True;

          if not cdsPromoItem.IsEmpty then
          begin

            cdsPromoItem.IndexName := 'cdsPromoItemIndex1';
            cdsPromoItem.First;
            CdsSaleItemsClone.Filtered := True;
            while (not cdsPromoItem.eof) do
            begin
                CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString;
                CdsSaleItemsClone.AggregatesActive := True;
                cdsSaleItemsCloneSumQty.Active := True;

                if CdsSaleItemsClone.FieldByName('SumQty').Value >= cdsPromoItem.FieldByName('QtyPromoItem').Value then
                begin
                  iIDPromo       := cdsPromoItem.FieldByName('IDPromo').AsInteger;
                  bFlatPromo     := cdsPromoItem.FieldByName('FlatPromo').AsBoolean;
                  dQtyPromoitem  := cdsPromoItem.FieldByName('QtyPromoitem').AsFloat;
                  dDiscountValue := cdsPromoItem.FieldByName('DiscountValue').AsFloat;

                  //Pode calcular o desconto
                  dTotalDiscount := CalPromoSaleQuantity(bFlatPromo,
                                       cdsSaleItemsIDInventoryMov.AsInteger,
                                       cdsSaleItemsIDModel.AsInteger,
                                       iIDPromo,
                                       cdsPromoItemPromoType.AsInteger,
                                       cdsPromoItemDiscountType.AsInteger,
                                       dDiscountValue);


                    if dTotalDiscount > 0 then
                    begin
                      dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;

                      cdsSaleItems.Edit;
                      cdsSaleItemsTotalDiscountApplied.AsFloat := cdsSaleItemsTotalDiscountApplied.AsFloat + dTotalDiscount;
                      cdsSaleItems.Post;
                    end;

                end;//fim if CdsSaleItemsClone.FieldByName('SumQty').Value >= cdsPromoItem.FieldByName('QtyPromoItem').Value then

              cdsPromoItem.Next;
            end;//fim while not cdsPromoItem.eof do

          end;// if not cdsPromoItem.IsEmpty then


        { PROMO_TYPE_SALE e DISCOUNT_PROMO_TYPE_PERCENTUAL ou DISCOUNT_PROMO_TYPE_VALUE}
        cdsPromoItem.IndexName := '';
        cdsPromoItem.Filter := FDefaultPromoFilter + ' AND IDModel = ' + cdsSaleItemsIDModel.AsString +
                               ' AND PromoType = ' + IntToStr(PROMO_TYPE_COUPON) +
                               ' AND ( (DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_PERCENTUAL) + ') or' +
                               '       (DiscountType = ' + IntToStr(DISCOUNT_PROMO_TYPE_VALUE) + ') )';

        cdsPromoItem.Filtered := True;

        if not cdsPromoItem.IsEmpty then
        begin

          cdsPromoItem.First;
          CdsSaleItemsClone.Filtered := True;
          while (not cdsPromoItem.eof) do
          begin
            dTotalDiscount := 0;

            CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString;
            CdsSaleItemsClone.AggregatesActive := True;
            cdsSaleItemsCloneSumQty.Active := True;

            iIDPromo       := cdsPromoItem.FieldByName('IDPromo').AsInteger;
            bFlatPromo     := cdsPromoItem.FieldByName('FlatPromo').AsBoolean;
            dQtyPromoitem  := cdsPromoItem.FieldByName('QtyPromoitem').AsFloat;
            dDiscountValue := cdsPromoItem.FieldByName('DiscountValue').AsFloat;

            dTotalDiscount := CalPromoCouponPercentAmount(bFlatPromo,
                                                        cdsSaleItemsIDInventoryMov.AsInteger,
                                                        cdsSaleItemsIDModel.AsInteger,
                                                        iIDPromo,
                                                        cdsPromoItemPromoType.AsInteger,
                                                        cdsPromoItemDiscountType.AsInteger,
                                                        cdsSaleItemsQty.AsFloat,
                                                        cdsPromoItemDiscountValue.AsFloat);

            if dTotalDiscount > 0 then
            begin
              dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;

              cdsSaleItems.Edit;
              cdsSaleItemsTotalDiscountApplied.AsFloat := cdsSaleItemsTotalDiscountApplied.AsFloat + dTotalDiscount;
              cdsSaleItems.Post;
            end;

            cdsPromoItem.Next;
          end;//fim while not cdsPromoItem.eof do

        end; //if not cdsPromoItem.IsEmpty then

        end;//fim if FCoupon <> '' then


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



        CdsSaleItemsClone.Filtered := False;
        CdsSaleItemsClone.Filter   := '';

        cdsPromoItem.IndexName := '';

      end;//fim if not cdsSaleItemsIsDeleted.AsBoolean then

      cdsSaleItems.Next;

    end;//fim while not cdsSaleItems.Eof do

    cdsPromoItem.Filter := FDefaultPromoFilter;
  end;
  cdsSaleItems.Filter := '';
  cdsSaleItems.Filtered := False;

  cdsPromoItem.Filtered := False;
  cdsPromoPrizeItem.Filtered := False;
  CdsSaleItemsClone.Filtered := False;

  Result := dTotalDiscountPromo;

end;

function TFrmPromoControl.CalPromoSaleQuantity(APromoFlat: Boolean;
  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
  AQty : Double): Double;
var
  dQtyNew, dSalePrice, dTotalDiscount, dQtdUsed : Double;
  bCanCalcPromo : Boolean;
  sFiltroPrize : String;
  qtyFree: integer;
  i, k: integer;
  qryADOItemY: TADOQUery;
  sqlItemY: String;
  savePriceDiscount: Double;
  count_X, count_Y, count_X_Ref_Y, countFree: integer;
  saveSumQty, sumQtyFree: double;
  itemSold, itemPrize: integer;
  IdInventoryMovSale, IdInventoryMovPrize: integer;
  fixQty: Integer;
  qtyFreeTemp: Integer;
begin
    sqlItemY :=
    ' SELECT SP.IDPromo, ' +
    '        SP.IDPromoItem, '+
    '        SPPI.IDPromoPrizeItem, '+
    '        SPPI.IDModel,          '+
    '        M.Model,               '+
    '        M.Description,         '+
    '        M.SellingPrice,        '+
    '        M.VendorCost,          '+
    '        TG.Name as Category,   '+
    '        MG.ModelGroup as SubCategory, '+
    '        MGS.ModelSubGroup as MGroup,  '+
    '        F.Pessoa as Manufacturer,     '+
    '        V.Pessoa as Vendor            '+
    ' FROM Sal_PromoItem SP (NOLOCK)       '+
    'JOIN Sal_PromoPrizeItem SPPI (NOLOCK) '+
    '  ON SP.IDPromoItem = SPPI.IDPromoItem '+
    'JOIN Model M (NOLOCK)                  '+
    '  ON (M.IDModel = SPPI.IDModel)        '+
    'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) '+
    'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) '+
    'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup) '+
    'LEFT JOIN Inv_ModelVendor IMV ON (M.IDModel = IMV.IDModel AND IMV.VendorOrder = 1)'+
    '      LEFT JOIN Pessoa V ON (IMV.IDPessoa = V.IDPessoa) ' +
    'LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa) ' +
    'WHERE ' +
    '	SP.IDPromo = :IdPromo ';

    dTotalDiscount := 0;
    dQtdUsed := AQty;

    //Busca os itens Prêmio do Item da Venda.
    cdsPromoPrizeItem.Filter := FDefaultPromoFilter +
                                ' AND IDModelPromoItem = '+ IntToStr(AIDModel) +
                                ' AND IDPromo = ' + IntToStr(AIDPromo);
    cdsPromoPrizeItem.Filtered := True;

    CdsSaleItemsClone.Filtered := True;
    cdsPromoPrizeItem.First;
    while (not cdsPromoPrizeItem.Eof) do begin

(*  if ( cdsPromoPrizeItemIdModel.Value <> AIdModel ) then begin
           cdsPromoPrizeItem.Next;
           Continue;
        end;
*)


        sFiltroPrize := ' IDModel = ' + IntToStr(AIDModel);
        CdsSaleItemsClone.AggregatesActive := False;
        CdsSaleItemsClone.Filter := sFiltroPrize;
        CdsSaleItemsClone.IndexName := 'ixIDModel';
        CdsSaleItemsClone.AggregatesActive := True;
        //testing
        cdsSaleItemsCloneSumQty.Active := True;

        // salvar a quantidade aqui.
        saveSumQty := cdsSaleItemsCloneSumQty.Value;

        if not CdsSaleItemsClone.IsEmpty then begin
           CdsSaleItemsClone.First;
            if CdsSaleItemsClone.FieldByName('SumQty').Value < dQtdUsed then
              AQty := CdsSaleItemsClone.FieldByName('SumQty').Value
            else
              AQty := dQtdUsed;

            dQtdUsed := dQtdUsed - AQty;

            dSalePrice := CdsSaleItemsCloneSalePrice.AsFloat;

            //VERIFICA SE O ITEM JA PARTICIPA DE OUTRA PROMOÇÃO
            bCanCalcPromo := True;
            if CdsSaleItemsCloneIDInventoryMovParent.value <> 0 then
            begin
              cdsSaleItems.Locate('IDInventoryMov', CdsSaleItemsCloneIDInventoryMovParent.value, []);
              if ((AQty * dSalePrice) > cdsSaleItemsTotalDiscountApplied.AsFloat) then
              begin
                CancelPromoItem(cdsSaleItemsIDInventoryMov.AsInteger, False);
                cdsSaleItems.Locate('IDInventoryMov', AIDInventoryMov, []);
              end
              else
              begin
                bCanCalcPromo := False;
                cdsSaleItems.Locate('IDInventoryMov', AIDInventoryMov, []);
              end;
            end;
            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

            cdsSaleItemsClone.Filter := 'IdModel = ' + intToStr(AIDModel) + ' and ( SalePriceDiscount = 0 or SalePriceDiscount Is Null )';
            cdsSaleItemsClone.Filtered := true;
            itemSold := CdsSaleItemsCloneQty.AsInteger;
            IdInventoryMovSale := CdsSaleItemsCloneIDInventoryMov.Value;

            // amfsouza 07.07.20111 - begin: to fix list SaleItemsClone
            // To fix a mess made by Eliandro with ItemsClone,  when user add a new model.
            // normal item sale
            cdsSaleItemsClone.Filter := 'IdInventoryMov = ' + intToStr(IdInventoryMovSale);
            cdsSaleItemsClone.Filtered := true;
            cdsSaleItemsClone.Edit;
            CdsSaleItemsCloneSalePriceDiscount.Value := 0;
            CdsSaleItemsCloneIsPrize.Value := false;
            cdsSaleItemsCloneIdPromo.Value := AIDPromo;
            CdsSaleItemsClonePromoType.Value :=  APromoType;
            CdsSaleItemsCloneDiscountType.Value :=  ADiscountType;
            CdsSaleItemsCloneIsUpDate.Value := true;
            cdsSaleItemsClone.Post;

            //force update in cdsSaleItems
            cdsSaleItems.Filter := 'IdModel = ' + intToStr(AIDModel) + ' and IdInventoryMov = ' + intToStr(IdInventoryMovSale);
            cdsSaleItems.Filtered := true;
            cdsSaleItems.edit;

            cdsSaleItemsIsUpdate.Value := true;
            cdsSaleItems.Post;

            cdsSaleItems.Filter := 'IsPrize=False';
            cdsSaleItems.Filtered := True;
            //force update in cdsSaleItems

            cdsSaleItems.Locate('IdInventoryMov', IdInventoryMovSale, []);


            CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoItem.FieldByName('IDModel').AsString +
                                        ' and IsDeleted=False' +
                                        ' and IDPromo <> ' + InttoStr(cdsPromoItemIDPromo.asInteger);
            CdsSaleItemsClone.Filtered := True;

            // according to ItemSold I can get correct qtyPrize by conditions
            qtyFree := getQtyPrizeBySale(trunc(saveSumQty), cdsPromoPrizeItemQtyPromoItem.AsInteger, cdsPromoPrizeItemDiscountValue.AsInteger );

//            if ( ((trunc(cdsSaleItemsClone.fieldByname('SumQty').value) - qtyFree) mod cdsPromoPrizeItemQtyPromoItem.AsInteger = 0) ) then
//               qtyFree := getQtyPrizeBySale((trunc(cdsSaleItemsClone.fieldByname('SumQty').value) - qtyFree), cdsPromoPrizeItemQtyPromoItem.AsInteger, cdsPromoPrizeItemDiscountValue.AsInteger )
//            else begin
//                qtyFree := 0;
//                //bCanCalcPromo := false;
//                //cdsPromoPrizeItem.Next;
//                //continue;
//            end;

            //force filter again
            cdsSaleItemsClone.Filter := 'IdInventoryMov = ' + intToStr(IdInventoryMovSale);
            cdsSaleItemsClone.Filtered := true;

            // to fix list when flat promo = true
            if ( cdsPromoPrizeItem.FieldByName('FlatPromo').AsBoolean = true ) then begin
                cdsSaleItemsClone.Filter := 'IdModel = ' + intToStr(AIDModel) + ' and ( Qty = ' + floatToStr(qtyFree) + ')';
                cdsSaleItemsClone.Filtered := true;

                // to guarantee of correct list prize.
                if ( not cdsSaleItemsClone.IsEmpty ) then begin
                   cdsSaleItemsClone.Edit;
                   CdsSaleItemsCloneSalePriceDiscount.Value := CdsSaleItemsCloneSalePrice.Value;
                   CdsSaleItemsCloneIsPrize.Value := true;
                   cdsSaleItemsCloneIdPromo.Value := AIDPromo;
                   CdsSaleItemsClonePromoType.Value :=  APromoType;
                   CdsSaleItemsCloneDiscountType.Value :=  ADiscountType;
                   CdsSaleItemsCloneIsDeleted.Value := true;
                   cdsSaleItemsClone.Post;

                   cdsSaleItemsClone.Filtered := false;

                end;

                cdsSaleItemsClone.Filter := 'IdModel = ' + intToStr(AIDModel) + ' and ( SalePrice = SalePriceDiscount )';
                cdsSaleItemsClone.Filtered := true;
                itemPrize := CdsSaleItemsCloneQty.AsInteger;
                IdInventoryMovPrize := CdsSaleItemsCloneIDInventoryMov.Value;
            end // to fix list when flat promo = false
            else begin
                qryADOItemY := TADOQuery.Create(nil);
                qryADOItemy.Connection := dm.ADODBConnect;
                qryADOItemY.SQL.Text := sqlItemY;
                qryADOItemY.Parameters.ParamByName('IdPromo').Value := AIdPromo;
                qryADOItemY.open;
                while not qryADOItemY.Eof do begin
                     cdsSaleItemsClone.Filter := 'IdModel = ' + qryADOItemY.fieldByName('IdModel').AsString;// + ' and ( Qty = ' + floatToStr(qtyFree) + ')';
                     cdsSaleItemsClone.Filtered := true;

                     while ( not cdsSaleItemsClone.Eof) do begin
//                     if ( not cdsSaleItemsClone.IsEmpty ) then begin
                         cdsSaleItemsClone.Edit;
                         CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
                         CdsSaleItemsClonePromoType.AsInteger := APromoType;
                         CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
                         CdsSaleItemsCloneInUse.AsBoolean := True;
                         CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.Value;
                         CdsSaleItemsCloneIsPrize.AsBoolean := True;
                         cdsSaleItemsCloneIsDeleted.Value := true;
                         cdsSaleItemsClone.Post;
                         cdsSaleItemsClone.Next;
                     end;

                     cdsSaleItemsClone.Filter := 'IdModel = ' + qryADOItemY.fieldByName('IdModel').AsString + ' and ( SalePrice = SalePriceDiscount )';
                     cdsSaleItemsClone.Filtered := true;
                     itemPrize := CdsSaleItemsCloneQty.AsInteger;
                     IdInventoryMovPrize := CdsSaleItemsCloneIDInventoryMov.Value;
                     cdsSaleItemsClone.filtered := false;

                     qryADOItemY.Next;
                end;
                freeAndNil(qryADOItemY);
            end;
            // amfsouza 07.07.20111 - end: to fix list SaleItemsClone

            cdsSaleItemsClone.Filter   := 'IdModel = ' + intToStr(AIDModel) + ' and IdInventoryMov <> ' + intToStr(IdInventoryMovSale);
            cdsSaleItemsClone.Filtered := true;
            while ( not cdsSaleItemsClone.Eof) do begin
                  cdsSaleItemsClone.Edit;
                  CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
                  CdsSaleItemsClonePromoType.AsInteger := APromoType;
                  CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
                  CdsSaleItemsCloneInUse.AsBoolean := false;
                  cdsSaleItemsCloneIsDeleted.Value := true;
                  cdsSaleItemsClone.Post;
                  cdsSaleItemsClone.Next;
            end;

            sFiltroPrize := ' IDModel = ' + IntToStr(AIDModel);
            CdsSaleItemsClone.AggregatesActive := False;
            CdsSaleItemsClone.Filter := sFiltroPrize;
            CdsSaleItemsClone.IndexName := 'ixIDModel';
            CdsSaleItemsClone.AggregatesActive := True;
            //testing
            cdsSaleItemsCloneSumQty.Active := True;

            cdsSaleItemsClone.Locate('IdInventoryMov', IdInventoryMovSale, []);
            cdsSaleItemsClone.Edit;
            CdsSaleItemsCloneSalePriceDiscount.Value := 0;
            CdsSaleItemsCloneIsPrize.Value := false;
            cdsSaleItemsCloneIdPromo.Value := AIDPromo;
            CdsSaleItemsClonePromoType.Value :=  APromoType;
            CdsSaleItemsCloneDiscountType.Value :=  ADiscountType;
            CdsSaleItemsCloneIsUpDate.Value := true;
            cdsSaleItemsClone.Post;

            //amfsouza 07.06.2011
            if ( bCanCalcPromo ) then begin
               if ( cdsPromoPrizeItem.FieldByName('PromoType').value = 1 ) and
                  ( cdsPromoPrizeItem.FieldByname('DiscountType').value = 3 ) then begin

                  { Alex 09/18/2011 - Dont know why in ist taking ItemPrize from SumQty when promo type }
                  { is by n get n - so took the code off for furder checking.                           }
{
                  if ( cdsPromoPrizeItem.FieldByName('FlatPromo').AsBoolean = true ) then
                      if ( cdsSaleItemsClone.fieldByName('SumQty').Value > 1 ) then
                     saveSumQty    := ( CdsSaleItemsClone.FieldByName('SumQty').Value - itemPrize )
                  else if ( cdsPromoPrizeItem.FieldByName('Flatpromo').Asboolean = False ) then
                     saveSumQty    := CdsSaleItemsClone.FieldByName('SumQty').Value
                  else
                     saveSumQty    := CdsSaleItemsClone.FieldByName('SumQty').Value;
}
                  count_X       := cdsPromoPrizeItem.FieldByName('QtyPromoItem').Value;
                  count_Y       := cdsPromoprizeItem.FieldByName('DiscountValue').Value;

                  cdsSaleItemsClone.Edit;
                  CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
                  CdsSaleItemsClonePromoType.AsInteger := APromoType;
                  CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
                  CdsSaleItemsCloneInUse.AsBoolean := True;
                  CdsSaleItemsCloneIsUpdate.Value := true;
                  CdsSaleItemsCloneSalePriceDiscount.AsFloat := 0;

                  // amfsouza August 02, 2012
                  //amfsouza July 27, 2012 - to fix sale items and free items.
                  cdsSaleItemsCloneQty.Value := ( saveSumQty - 1 );

                  fixQty := trunc( saveSumQty - ( cdsSaleItemsCloneQty.Value + qtyFree) );

                  if ( abs(fixQty) > 0 ) then
                     cdsSaleItemsCloneQty.Value := cdsSaleItemsCloneQty.Value - abs(fixQty);

                  CdsSaleItemsCloneIsPrize.AsBoolean := false;
                  cdsSaleItemsClone.Post;

                  cdsSaleItems.Filter   := 'IdModel = ' + intToStr(AIDModel) + ' and IdInventoryMov = ' + intToStr(IdInventoryMovSale);
                  cdsSaleItems.Filtered := true;
                  cdsSaleItems.edit;

                  //amfsouza July 27, 2012 - to fix sale items and free items.
                  cdsSaleItemsQty.Value := cdsSaleItemsCloneQty.Value;
                  cdsSaleItemsIsUpdate.Value := true;
                  cdsSaleItems.Post;

                  cdsSaleItems.Filter := 'IsPrize=False';
                  cdsSaleItems.Filtered := True;
                  cdsSaleItems.Locate('IdInventoryMov', IdInventoryMovSale, []);


                  if ( cdsPromoPrizeItem.FieldByName('FlatPromo').AsBoolean = true ) then begin
                     count_X_Ref_Y := 0;
                     i := 1;

                     while ( i <= saveSumQty ) do begin
                           inc(count_X_Ref_Y);
                           if ( i mod (count_x + count_y) = 0 ) then begin
                              if ( count_X_Ref_Y >= count_X ) then begin
                                 for k:= 1 to count_Y do
                                     inc(countFree);

                                 count_X_Ref_Y := 0;
                              end;
                           end;
                           inc(i);
                     end;

                     if ( countFree > 0 ) then begin
                         Inc(FNewIDInventoryMov);
                         Inc(FIndiceInsert);
                         InsertNewSaleItemClone(FNewIDInventoryMov,
                                               cdsPromoPrizeItem.fieldByName('IdModel').Value,
                                               FIndiceInsert,
                                               CdsSaleItemsCloneIDComission.AsInteger,
                                               cdsSaleItemsCloneIDUser.AsInteger,
                                               CdsSaleItemsCloneIDDepartment.AsInteger,
                                               CdsPromoPrizeItem.fieldByName('SellingPrice').AsFloat,
                                               countFree,
                                               CdsSaleItemsCloneCostPrice.AsFloat,
                                               False,
                                               True,
                                               True,
                                               False,
                                               False,
                                               0);
                         cdsSaleItemsClone.Locate('IdInventoryMov', FNewIDInventoryMov, []);
                         cdsSaleItemsClone.Edit;
                         CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
                         CdsSaleItemsClonePromoType.AsInteger := APromoType;
                         CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
                         CdsSaleItemsCloneInUse.AsBoolean := True;
                         CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsPromoPrizeItem.fieldByName('SellingPrice').AsFloat;
                         CdsSaleItemsCloneIsPrize.AsBoolean := True;
                         CdsSaleItemsClone.Post;
                     end;
                  end
                  else begin
                       count_X_Ref_Y := 0;
                       i := 1;

                     while ( i <= saveSumQty ) do begin
                           inc(count_X_Ref_Y);
                           if ( i mod (count_x + count_y) = 0 ) then begin
                              if ( count_X_Ref_Y >= count_X ) then begin
                                 for k:= 1 to count_Y do
                                     inc(countFree);

                                 count_X_Ref_Y := 0;
                              end;
                           end;
                           inc(i);
                     end;

                       if ( countFree > 0 ) then begin
                          qryADOItemY := TADOQuery.Create(nil);
                          qryADOItemy.Connection := dm.ADODBConnect;
                          qryADOItemY.SQL.Text := sqlItemY;
                          qryADOItemY.Parameters.ParamByName('IdPromo').Value := AIdPromo;
                          qryADOItemY.open;
                          while not qryADOItemY.Eof do begin
                               Inc(FNewIDInventoryMov);
                               Inc(FIndiceInsert);
                               InsertNewSaleItemClone(FNewIDInventoryMov,
                                                     qryADOItemY.fieldByName('IdModel').Value,
                                                     FIndiceInsert,
                                                     CdsSaleItemsCloneIDComission.AsInteger,
                                                     cdsSaleItemsCloneIDUser.AsInteger,
                                                     CdsSaleItemsCloneIDDepartment.AsInteger,
                                                     qryADOItemY.fieldByName('SellingPrice').AsFloat,
                                                     countFree,
                                                     qryADOItemY.fieldByName('VendorCost').AsFloat,
                                                     False,
                                                     True,
                                                     True,
                                                     false,
                                                     true,
                                                     0);
                               savePriceDiscount := qryADOItemY.fieldByName('SellingPrice').Value;
                               cdsSaleItemsClone.Filter := 'IdModel = ' + qryADOItemY.fieldByName('IdModel').AsString + ' and IdInventoryMov = ' + IntToStr(FNewIdInventoryMov);
                               cdsSaleItemsClone.Filtered := true;
                               cdsSaleItemsClone.Edit;
                               CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
                               CdsSaleItemsClonePromoType.AsInteger := APromoType;
                               CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
                               CdsSaleItemsCloneInUse.AsBoolean := True;
                               CdsSaleItemsCloneSalePriceDiscount.AsFloat := savePriceDiscount;
                               CdsSaleItemsCloneIsPrize.AsBoolean := True;
                               CdsSaleItemsCloneQty.Value := countFree;
                               CdsSaleItemsCloneIsNew.Value := true;
                               CdsSaleItemsClone.Post;
                               qryADOItemY.Next;
                          end;
                          freeAndNil(qryADOItemY);
                       end;
                  end;
               end;
            end;
        end;

        dTotalDiscount := AQty * dSalePrice;
        cdsPromoPrizeItem.Next;
    end;

    CdsSaleItemsClone.Filtered := False;
    CdsSaleItemsClone.Filter := '';
    CdsSaleItemsClone.IndexName := '';

    cdsPromoPrizeItem.Filter := '';
    cdsPromoPrizeItem.Filtered := False;

    Result := dTotalDiscount;
end;


procedure TFrmPromoControl.btntesteClick(Sender: TObject);
begin
  CalPromoFrequentByer(FIDCustomer, FIDPreSale);
  CalcPromoItem(FCoupon, FIDPreSale, FIDCustomer, fPreSaleDate, FIsLoyalty);
end;

procedure TFrmPromoControl.InsertNewSaleItemClone(AIDInventoryMov,
                                    AIDModel, AIndice, AIDComission,
                                    AIDUser, AIDDepartment: Integer;
                                    ASalePrice, AQty, ACostPrice: Double;
                                    AInUse, AIsPrize, AIsNew, AIsUpdate, AIsFlatPromo: Boolean;
                                    ADiscountLoyalt: Double);
begin
  CdsSaleItemsClone.Append;
  CdsSaleItemsCloneIDInventoryMov.AsInteger := AIDInventoryMov;
  CdsSaleItemsCloneIDModel.AsInteger := AIDModel;
  CdsSaleItemsCloneSalePrice.AsFloat := ASalePrice;
  CdsSaleItemsCloneQty.AsFloat := AQty;
  CdsSaleItemsCloneInUse.AsBoolean := AInUse;
  CdsSaleItemsCloneIsPrize.AsBoolean := AIsPrize;
  CdsSaleItemsCloneIsNew.AsBoolean := AIsNew;
  CdsSaleItemsCloneIsUpdate.AsBoolean := AIsUpdate;
  CdsSaleItemsCloneIndice.AsInteger := AIndice;
  CdsSaleItemsCloneIsDeleted.AsBoolean := False;
  CdsSaleItemsCloneIDComission.AsInteger := AIDComission;
  CdsSaleItemsCloneIDUser.AsInteger := AIDUser;
  CdsSaleItemsCloneIDDepartment.AsInteger := AIDDepartment;
  CdsSaleItemsCloneCostPrice.asFloat := ACostPrice;
  CdsSaleItemsCloneFlatPromo.AsBoolean := AIsFlatPromo;
  CdsSaleItemsCloneDiscountLoyalt.AsFloat := ADiscountLoyalt;

  CdsSaleItemsClone.Post;
end;

{
procedure TFrmPromoControl.UpdateSaleItemClone(AIDInventoryMov, APromoType, ADiscountType: Integer;
  AInUse: Boolean; ASalePriceDiscount, AQty: Double);
begin
  CdsSaleItemsClone.Edit;
  if AQty > 0 then
    CdsSaleItemsClone.FieldByName('Qty').AsFloat := AQty;

  CdsSaleItemsClone.FieldByName('PromoType').AsInteger := APromoType;
  CdsSaleItemsClone.FieldByName('DiscountType').AsInteger := ADiscountType;
  CdsSaleItemsClone.FieldByName('IDInventoryMovParent').AsInteger := AIDInventoryMov;
  CdsSaleItemsClone.FieldByName('InUse').AsBoolean := AInUse;
  CdsSaleItemsClone.FieldByName('SalePriceDiscount').AsFloat := ASalePriceDiscount;
  CdsSaleItemsClone.Post;
end;
}

procedure TFrmPromoControl.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //cdsteste
  cdsSaleItems.Close;
  CdsSaleItemsClone.Close;
  cdsItemsFrequentUse.Close;
end;

function TFrmPromoControl.AlterListSaleItens(AIDModel, AIDInventoryMov : Integer; AQty : Double): Boolean;
var
//  iIndice, iIndiceLocate, iIDInventoryMov : Integer;
//  dQtyNew, dQtyItem : Double;
//  bFindItem : Boolean;
  dQtyNew : Double;
begin
   Result := False;

     {
       Se a quantidade do Item é maior, então iguala quantidae e adiciona a
       sobra no próximo item
     }
     if cdsSaleItemsQty.AsFloat > AQty then
     begin
       dQtyNew := cdsSaleItemsQty.AsFloat - AQty;
       cdsSaleItems.Edit;
       cdsSaleItemsQty.AsFloat := AQty;
       cdsSaleItemsIsUpdate.AsBoolean := True;
       cdsSaleItems.Post;

       {
       Verifica se existe mais te um item lançado na venda para efetuar a redistribuição
       das quantidades
       }
       cdsSaleItems.Next;
       if (AIDModel = cdsSaleItemsIDModel.AsInteger) and (not cdsSaleItems.eof) then
       begin
         cdsSaleItems.Edit;
         cdsSaleItemsQty.AsFloat := cdsSaleItemsQty.AsFloat + dQtyNew;
         cdsSaleItemsIsUpdate.AsBoolean := True;
         cdsSaleItems.Post;
       end//if CdsSaleItemsClone.RecordCount > 1 then
       else
       begin
         Inc(FNewIDInventoryMov);
         Inc(FIndiceInsert);
         InsertNewSaleItem(FNewIDInventoryMov,
                                cdsSaleItemsIDModel.AsInteger,
                                FIndiceInsert,
                                cdsSaleItemsSalePrice.AsFloat,
                                dQtyNew,
                                False,
                                cdsSaleItemsIsPrize.AsBoolean,
                                True,
                                False);
       end;

       Result := True;
     end
     else if cdsSaleItemsQty.AsFloat < AQty then
     begin
       {
         Como a quanitade é menor o valor precisa ser subtraído dos demais itens
         da venda
       }
       dQtyNew := AQty - cdsSaleItemsQty.AsFloat;
       cdsSaleItems.Edit;
       cdsSaleItemsQty.AsFloat := AQty;
       cdsSaleItemsIsUpdate.AsBoolean := True;
       cdsSaleItems.Post;

       cdsSaleItems.Next;
       while ( (AIDModel = cdsSaleItemsIDModel.AsInteger) and (dQtyNew > 0) ) do
       begin

         cdsSaleItems.Edit;
         if (cdsSaleItemsQty.AsFloat - dQtyNew) > 0 then
         begin
           cdsSaleItemsQty.AsFloat := cdsSaleItemsQty.AsFloat - dQtyNew;
           cdsSaleItemsIsUpdate.AsBoolean := True;
           dQtyNew := 0;
           cdsSaleItems.Post;
           cdsSaleItems.Next;
         end
         else
         begin
           { se for menor que zero então exclui o item da lista
             pois não tem quantidade disponível}
           dQtyNew := dQtyNew - cdsSaleItemsQty.AsFloat;
           cdsSaleItemsIsDeleted.AsBoolean := True;
           cdsSaleItems.Post;
           cdsSaleItems.Next;
         end;

       end;//Fim while
       Result := True;
     end;

   cdsSaleItems.Locate('IDInventoryMov', AIDInventoryMov, []);
end;

procedure TFrmPromoControl.InsertNewSaleItem(AIDInventoryMov, AIDModel,
  AIndice: Integer; ASalePrice, AQty: Double; AInUse, AIsPrize, AIsNew,
  AIsUpdate: Boolean);
begin
  CdsSaleItems.Append;
  CdsSaleItems.FieldByName('IDInventoryMov').AsInteger := AIDInventoryMov;
  CdsSaleItems.FieldByName('IDModel').AsInteger := AIDModel;
  CdsSaleItems.FieldByName('SalePrice').AsFloat := ASalePrice;
  CdsSaleItems.FieldByName('Qty').AsFloat := AQty;
  CdsSaleItems.FieldByName('InUse').AsBoolean := AInUse;
  CdsSaleItems.FieldByName('IsPrize').AsBoolean := AIsPrize;
  CdsSaleItems.FieldByName('IsNew').AsBoolean := AIsNew;
  CdsSaleItems.FieldByName('IsUpdate').AsBoolean := AIsUpdate;
  CdsSaleItems.FieldByName('Indice').AsInteger := AIndice;
  CdsSaleItems.FieldByName('IsDeleted').AsBoolean := False;
  CdsSaleItems.Post;
end;

function TFrmPromoControl.CalPromoSalePercentAmount(APromoFlat: Boolean;
  AIDInventoryMov, AIDModel, AIDPromo, APromoType,
  ADiscountType: Integer; AQty, ADiscountValue, ACurrentDiscount,
  ADiscountLoyalt: Double): Double;
var
  dQtyNew, dTotalDiscount, dTotalItemDiscount,
  dSalePriceCorrente, dQtyPromo, dCostPrice, dDiscountLoyalt : Double;
  iIDModelCorrente, iIDComissionCorrente, iIDUserCorrente,
  iIDDepartmentCorrente: Integer;

  bIsPrizeCorrente : Boolean;
begin
  dTotalDiscount := 0;
  dTotalItemDiscount := 0;

  //Busca os itens Prêmio do Item da Venda.
  cdsPromoPrizeItem.Filter := FDefaultPromoFilter +
                              ' AND IDModelPromoItem = '+ IntToStr(AIDModel) +
                              ' AND IDPromo = ' + IntToStr(AIDPromo);
  cdsPromoPrizeItem.Filtered := True;

  CdsSaleItemsClone.Filtered := True;
  cdsPromoPrizeItem.First;
  while ( (not cdsPromoPrizeItem.Eof) and (dTotalDiscount = 0) ) do
  begin
    dTotalItemDiscount := 0;

    CdsSaleItemsClone.AggregatesActive := False;
    CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoPrizeItem.FieldByName('IDModel').asString
                                 + ' AND InUse = False';
    CdsSaleItemsClone.IndexName := 'ixIDModel';
    CdsSaleItemsClone.AggregatesActive := True;

    if not CdsSaleItemsClone.IsEmpty then
    begin
      { para PromoType Loyalty }
      if APromoType = PROMO_TYPE_LOYALTY then
      begin
        if ADiscountType = DISCOUNT_PROMO_TYPE_PERCENTUAL then
        begin
          if ADiscountLoyalt > ADiscountValue then
            ADiscountValue := ADiscountLoyalt; 
        end
        else if ADiscountType = DISCOUNT_PROMO_TYPE_VALUE then
        begin
          dTotalItemDiscount := (ADiscountLoyalt * CdsSaleItemsCloneSalePrice.AsFloat) / 100;
          if RoundTo(dTotalItemDiscount, 2) > ADiscountValue then
            ADiscountValue := RoundTo(dTotalItemDiscount, 2);

          dTotalItemDiscount := 0;
        end;
      end;

      {Valida se o desconto encontrado é maior do que o já existente para o SaleItem}
      if ADiscountType = DISCOUNT_PROMO_TYPE_PERCENTUAL then
        dTotalItemDiscount := (ADiscountValue * CdsSaleItemsCloneSalePrice.AsFloat) / 100
      else if ADiscountType = DISCOUNT_PROMO_TYPE_VALUE then
        dTotalItemDiscount := ADiscountValue;

      if CdsSaleItemsCloneSalePrice.AsFloat - dTotalDiscount <= 0 then
        dTotalItemDiscount := CdsSaleItemsCloneSalePrice.AsFloat;


      if (not CdsSaleItemsClone.IsEmpty) and ((AQty * dTotalItemDiscount) > ACurrentDiscount)
        and (CdsSaleItemsCloneIDInventoryMovParent.AsInteger = 0) then
      begin
        if ((AQty * dTotalItemDiscount) > ACurrentDiscount) and (ACurrentDiscount > 0) then
          CancelPromoItem(AIDInventoryMov, True);

        if not CdsSaleItemsClone.Locate('Qty', AQty, []) then
        begin
          CdsSaleItemsClone.First;
          if CdsSaleItemsCloneQty.AsFloat > AQty then
          begin
            {Quantidade maior. Então a quantidade do Item será alterada
             e a diferença será adicionada a outro item, caso exista, senão
             será criado um novo Item }
            dQtyPromo := AQty;

            iIDModelCorrente := CdsSaleItemsCloneIDModel.AsInteger;
            dSalePriceCorrente := CdsSaleItemsCloneSalePrice.AsFloat;
            bIsPrizeCorrente := CdsSaleItemsCloneIsPrize.AsBoolean;

            iIDComissionCorrente := CdsSaleItemsCloneIDComission.AsInteger;
            iIDUserCorrente := CdsSaleItemsCloneIDUser.AsInteger;
            iIDDepartmentCorrente := CdsSaleItemsCloneIDDepartment.AsInteger;
            dCostPrice := CdsSaleItemsCloneCostPrice.AsFloat;
            dDiscountLoyalt := CdsSaleItemsCloneDiscountLoyalt.AsFloat;

            dQtyNew := CdsSaleItemsCloneQty.AsFloat - AQty;
            CdsSaleItemsClone.Edit;
            CdsSaleItemsCloneQty.AsFloat := AQty;
            CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
            CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
            CdsSaleItemsClonePromoType.AsInteger := APromoType;
            CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
            CdsSaleItemsCloneInUse.AsBoolean := True;
            CdsSaleItemsCloneIsUpdate.AsBoolean := True;
            CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - dTotalItemDiscount;
            CdsSaleItemsClone.Post;

            //CdsSaleItemsClone.Next;
            if (not CdsSaleItemsClone.eof) then
            begin
             CdsSaleItemsClone.Edit;
             CdsSaleItemsCloneQty.AsFloat := CdsSaleItemsCloneQty.AsFloat + dQtyNew;
             CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
             CdsSaleItemsClonePromoType.AsInteger := APromoType;
             CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
             CdsSaleItemsCloneInUse.AsBoolean := True;
             CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - dTotalItemDiscount;
             CdsSaleItemsClone.Post;
            end
            else
            begin
             Inc(FNewIDInventoryMov);
             Inc(FIndiceInsert);
             InsertNewSaleItemClone(FNewIDInventoryMov,
                                    iIDModelCorrente,
                                    FIndiceInsert,
                                    iIDComissionCorrente,
                                    iIDUserCorrente,
                                    iIDDepartmentCorrente,
                                    dSalePriceCorrente,
                                    dQtyNew,
                                    dCostPrice,
                                    False,
                                    bIsPrizeCorrente,
                                    True,
                                    False,
                                    False,
                                    dDiscountLoyalt);
            end;
          end
          else if CdsSaleItemsCloneQty.AsFloat < AQty then
          begin
            if cdsSaleItemsCloneSumQty.Value < AQty then
            begin
              dQtyPromo := CdsSaleItemsCloneQty.AsFloat;

              CdsSaleItemsClone.Edit;
              CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
              CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
              CdsSaleItemsClonePromoType.AsInteger := APromoType;
              CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
              CdsSaleItemsCloneInUse.AsBoolean := True;
              CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - dTotalItemDiscount;
              CdsSaleItemsClone.Post;

              AlterListSaleItens(AIDModel,
                                 AIDInventoryMov,
                                 dQtyPromo);
            end
            else
            begin
             {
               Como a quanitade é menor o valor precisa ser subtraído dos demais itens
               da venda
              }
              dQtyPromo := AQty;

              dQtyNew := AQty - CdsSaleItemsCloneQty.AsFloat;
              CdsSaleItemsClone.Edit;
              CdsSaleItemsCloneQty.AsFloat := AQty;
              CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
              CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
              CdsSaleItemsClonePromoType.AsInteger := APromoType;
              CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
              CdsSaleItemsCloneInUse.AsBoolean := True;
              CdsSaleItemsCloneIsUpdate.AsBoolean := True;
              CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - dTotalItemDiscount;
              CdsSaleItemsClone.Post;

               //CdsSaleItemsClone.Next;
               while (dQtyNew > 0) do
               begin

                 if (CdsSaleItemsCloneQty.AsFloat - dQtyNew) > 0 then
                 begin
                   CdsSaleItemsClone.Edit;
                   CdsSaleItemsCloneQty.AsFloat := CdsSaleItemsCloneQty.AsFloat - dQtyNew;
                   CdsSaleItemsCloneIsUpdate.AsBoolean := True;
                   dQtyNew := 0;
                   CdsSaleItemsClone.Post;
                   CdsSaleItemsClone.Next;
                 end
                 else
                 begin
                   { se for menor que zero então exclui o item da lista
                     pois não tem quantidade disponível}
                   CdsSaleItemsClone.Edit;
                   dQtyNew := dQtyNew - CdsSaleItemsCloneQty.AsFloat;
                   CdsSaleItemsCloneIsDeleted.AsBoolean := True;
                   CdsSaleItemsClone.Post;
                 end;

               end;//Fim while

            end;
          end;
        end
        else
        begin
         //ENCONTROU O ITEM PRIZE COM A MESMA QUANTIDADE
         dQtyPromo := CdsSaleItemsCloneQty.AsFloat;

         CdsSaleItemsClone.Edit;
         CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
         CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
         CdsSaleItemsClonePromoType.AsInteger := APromoType;
         CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
         CdsSaleItemsCloneInUse.AsBoolean := True;
         CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - dTotalItemDiscount;
         CdsSaleItemsClone.Post;

        end;

          {
          if ADiscountType = DISCOUNT_PROMO_TYPE_PERCENTUAL then
            dTotalItemDiscount := (ADiscountValue * CdsSaleItemsCloneSalePrice.AsFloat) / 100
          else if ADiscountType = DISCOUNT_PROMO_TYPE_VALUE then
            dTotalItemDiscount := ADiscountValue;

          if CdsSaleItemsCloneSalePrice.AsFloat - dTotalDiscount <= 0 then
            dTotalItemDiscount := CdsSaleItemsCloneSalePrice.AsFloat;
          }

          {
          CdsSaleItemsClone.Edit;
          CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
          CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - dTotalItemDiscount;
          CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
          CdsSaleItemsClone.Post;
          }

      end//Fim if not CdsSaleItemsClone.IsEmpty then
      else
        dTotalItemDiscount := 0;

      dTotalDiscount := dTotalDiscount + (dQtyPromo * dTotalItemDiscount);

    end;//fim if CdsSaleItemsClone.RecordCount > 0 then

    cdsPromoPrizeItem.Next;
  end;//fim while (not cdsPromoPrizeItem.Eof) do

  CdsSaleItemsClone.Filtered := False;
  CdsSaleItemsClone.Filter := '';
  CdsSaleItemsClone.IndexName := '';

  cdsPromoPrizeItem.Filter := '';
  cdsPromoPrizeItem.Filtered := False;

  Result := dTotalDiscount;
end;

procedure TFrmPromoControl.SetSaleItemInUse(APromoType,
  ADiscountType, AIDPromo: Integer; ATotalDiscount: Double);
begin
  cdsSaleItems.Edit;
  cdsSaleItemsInUse.AsBoolean := True;
  //amfsouza 06.24.2011
  cdsSaleItemsIsUpdate.AsBoolean := True;
  cdsSaleItemsPromoType.AsInteger := APromoType;
  cdsSaleItemsDiscountType.AsInteger := ADiscountType;
  CdsSaleItemsIDPromo.AsInteger := AIDPromo;
  cdsSaleItemsTotalDiscountApplied.AsFloat := ATotalDiscount;
  cdsSaleItems.Post;
end;

procedure TFrmPromoControl.CancelPromoItem(AIDInventoryMov : Integer; UseLocate : Boolean);
var
  boUpdate : Boolean;
begin
  boUpdate := False;
  if UseLocate then
  begin
    if CdsSaleItemsClone.Locate('IDInventoryMov', AIDInventoryMov, []) then
      boUpdate := True;
  end
  else
    boUpdate := True;

  if boUpdate then
  begin
    cdsSaleItems.Edit;
    cdsSaleItemsInUse.AsBoolean := False;
    cdsSaleItemsPromoType.AsInteger := null;
    cdsSaleItemsDiscountType.AsInteger := null;
    CdsSaleItemsIDPromo.AsInteger := null;
    cdsSaleItemsTotalDiscountApplied.AsFloat := 0;
    cdsSaleItems.Post;

    CdsSaleItemsClone.Edit;
    CdsSaleItemsCloneIDInventoryMovParent.AsInteger := Null;
    CdsSaleItemsCloneIsUpdate.AsBoolean := False;
    CdsSaleItemsCloneSalePriceDiscount.AsFloat := Null;
    CdsSaleItemsCloneIDPromo.AsInteger := null;
    CdsSaleItemsClone.Post;
  end;

end;

procedure TFrmPromoControl.FormShow(Sender: TObject);
begin
  //FCdsClone := TClientDataSet.Create(self);

end;

procedure TFrmPromoControl.cdsSaleItemsAfterPost(DataSet: TDataSet);
begin
  if not FStart then
  begin
  CdsSaleItemsClone.Locate('IDInventoryMov', cdsSaleItemsIDInventoryMov.AsInteger, []);
  CdsSaleItemsClone.Edit;
  CdsSaleItemsCloneIDPromo.AsInteger := CdsSaleItemsIDPromo.AsInteger;
  CdsSaleItemsClonePromoType.AsInteger := CdsSaleItemsPromoType.AsInteger;
  CdsSaleItemsCloneDiscountType.AsInteger := CdsSaleItemsDiscountType.AsInteger;
  CdsSaleItemsCloneIsDeleted.AsBoolean := CdsSaleItemsIsDeleted.AsBoolean;
  CdsSaleItemsClone.Post;
  end;
end;

function TFrmPromoControl.CalPromoCouponQuantity(APromoFlat: Boolean;
  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
  AQty: Double): Double;

var
  dQtyNew, dTotalDiscount, dDiscountItem : Double;
begin
  dQtyNew := AQty;

  dTotalDiscount := 0;
  dDiscountItem := 0;

  //Busca os itens Prêmio do Item da Venda.
  cdsPromoPrizeItem.Filter := FDefaultPromoFilter +
                              ' AND IDModelPromoItem = '+ IntToStr(AIDModel) +
                              ' AND IDPromo = ' + IntToStr(AIDPromo);
  cdsPromoPrizeItem.Filtered := True;

  CdsSaleItemsClone.Filtered := True;
  cdsPromoPrizeItem.First;
  while (not cdsPromoPrizeItem.Eof) do
  begin
    CdsSaleItemsClone.AggregatesActive := False;
    CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoPrizeItem.FieldByName('IDModel').asString +
                                 ' AND InUse = False';
    CdsSaleItemsClone.IndexName := 'ixIDModel';
    CdsSaleItemsClone.AggregatesActive := True;

    CdsSaleItemsClone.First;
    while (not CdsSaleItemsClone.eof) and (dQtyNew > 0) do
    begin
      if CdsSaleItemsCloneQty.AsFloat >= dQtyNew then
      begin
        dDiscountItem := dQtyNew * CdsSaleItemsCloneSalePrice.AsFloat;
        dQtyNew := 0;
      end
      else if CdsSaleItemsCloneQty.AsFloat < dQtyNew then
      begin
        dDiscountItem := CdsSaleItemsCloneQty.AsFloat * CdsSaleItemsCloneSalePrice.AsFloat;
        dQtyNew := dQtyNew - CdsSaleItemsCloneQty.AsFloat;
      end;

      if dDiscountItem > 0 then
      begin
        CdsSaleItemsClone.Edit;
        CdsSaleItemsCloneSalePriceDiscount.AsFloat := dDiscountItem;
        CdsSaleItemsClone.Post;
      end;

      dTotalDiscount := dTotalDiscount + dDiscountItem; //dQtyNew * CdsSaleItemsCloneSalePrice.AsFloat;
      dDiscountItem := 0;

      CdsSaleItemsClone.Next;
    end;

    cdsPromoPrizeItem.Next;
  end;

  CdsSaleItemsClone.Filtered := False;
  CdsSaleItemsClone.Filter := '';
  CdsSaleItemsClone.IndexName := '';

  cdsPromoPrizeItem.Filter := '';
  cdsPromoPrizeItem.Filtered := False;

  Result := dTotalDiscount;

end;

function TFrmPromoControl.CalPromoCouponPercentAmount(APromoFlat: Boolean;
  AIDInventoryMov, AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
  AQty, ADiscountValue: Double): Double;

var
  dQtyNew, dTotalDiscount, dDiscountItem, dSalePriceCalc : Double;
begin
  dQtyNew := AQty;

  dTotalDiscount := 0;
  dDiscountItem := 0;

  //Busca os itens Prêmio do Item da Venda.
  cdsPromoPrizeItem.Filter := FDefaultPromoFilter +
                              ' AND IDModelPromoItem = '+ IntToStr(AIDModel) +
                              ' AND IDPromo = ' + IntToStr(AIDPromo);
  cdsPromoPrizeItem.Filtered := True;

  CdsSaleItemsClone.Filtered := True;
  cdsPromoPrizeItem.First;
  while (not cdsPromoPrizeItem.Eof) do
  begin
    CdsSaleItemsClone.AggregatesActive := False;
    CdsSaleItemsClone.Filter := ' IDModel = ' + cdsPromoPrizeItem.FieldByName('IDModel').asString;
                                 //' AND InUse = False';
    CdsSaleItemsClone.IndexName := 'ixIDModel';
    CdsSaleItemsClone.AggregatesActive := True;

    CdsSaleItemsClone.First;
    while (not CdsSaleItemsClone.eof) and (dQtyNew > 0) do
    begin
      if CdsSaleItemsCloneSalePriceDiscount.AsFloat > 0 then
        dSalePriceCalc := CdsSaleItemsCloneSalePriceDiscount.AsFloat
      else
        dSalePriceCalc := CdsSaleItemsCloneSalePrice.AsFloat;

      {Valida se o desconto encontrado é maior do que o já existente para o SaleItem}
      if ADiscountType = DISCOUNT_PROMO_TYPE_PERCENTUAL then
        //dDiscountItem := (ADiscountValue * CdsSaleItemsCloneSalePrice.AsFloat) / 100
        dDiscountItem := (ADiscountValue * dSalePriceCalc) / 100
      else if ADiscountType = DISCOUNT_PROMO_TYPE_VALUE then
        dDiscountItem := ADiscountValue;

      //if CdsSaleItemsCloneSalePrice.AsFloat - dTotalDiscount <= 0 then
      if dSalePriceCalc - dTotalDiscount <= 0 then
        dDiscountItem := CdsSaleItemsCloneSalePrice.AsFloat;

      if CdsSaleItemsCloneQty.AsFloat >= dQtyNew then
      begin
        dDiscountItem := dQtyNew * dDiscountItem;
        dQtyNew := 0;
      end
      else if CdsSaleItemsCloneQty.AsFloat < dQtyNew then
      begin
        dDiscountItem := CdsSaleItemsCloneQty.AsFloat * dDiscountItem;
        dQtyNew := dQtyNew - CdsSaleItemsCloneQty.AsFloat;
      end;

      if dDiscountItem > 0 then
      begin
        CdsSaleItemsClone.Edit;
        //CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - (CdsSaleItemsCloneSalePriceDiscount.AsFloat + dDiscountItem);
        //CdsSaleItemsCloneSalePriceDiscount.AsFloat := CdsSaleItemsCloneSalePrice.AsFloat - ((CdsSaleItemsCloneSalePrice.AsFloat - CdsSaleItemsCloneSalePriceDiscount.AsFloat) + dDiscountItem);
        CdsSaleItemsCloneSalePriceDiscount.AsFloat := dSalePriceCalc - dDiscountItem;
        CdsSaleItemsClone.Post;
      end;

      dTotalDiscount := dTotalDiscount + dDiscountItem; //dQtyNew * CdsSaleItemsCloneSalePrice.AsFloat;
      dDiscountItem := 0;

      CdsSaleItemsClone.Next;
    end;

    cdsPromoPrizeItem.Next;
  end;

  CdsSaleItemsClone.Filtered := False;
  CdsSaleItemsClone.Filter := '';
  CdsSaleItemsClone.IndexName := '';

  cdsPromoPrizeItem.Filter := '';
  cdsPromoPrizeItem.Filtered := False;

  Result := dTotalDiscount;

end;

{
procedure TFrmPromoControl.UpdateSaleItemWithPromo;
begin

  cdsSaleItems.Filter := 'IsPrize=False and InUse=True and IsUpdate=True';
  cdsSaleItems.Filtered := True;

  if cdsSaleItems.RecordCount > 0 then
  begin
    cdsSaleItems.First;
    while cdsSaleItems.Eof do
    begin

      cdsSaleItems.Next;
    end;//fim while cdsSaleItems.Eof do

  end;//fim if cdsSaleItems.RecordCount > 0 then



  CdsSaleItemsClone.Filter := 'IsPrize=True and InUse=True';
  CdsSaleItemsClone.Filtered := True;

  if CdsSaleItemsClone.RecordCount > 0 then
  begin
    CdsSaleItemsClone.First;
    while CdsSaleItemsClone.Eof do
    begin

      CdsSaleItemsClone.Next;
    end;//fim while CdsSaleItemsClone.Eof do

  end;//fim if CdsSaleItemsClone.RecordCount > 0 then
end;
}

procedure TFrmPromoControl.SettingSaleItemsWithPromo(fIDPreSale, fIDCliente : Integer; APreSaleDate: TDateTime);
var
  dDiscount : Double;
  betterDiscount: currency;
begin
  FHaveDeletedItem := False;

  cdsSaleItems.Filter := 'IsPrize=False';
  cdsSaleItems.Filtered := True;

  if not cdsSaleItems.IsEmpty then
  begin
    cdsSaleItems.First;
    while not cdsSaleItems.Eof do
    begin
      if cdsSaleItemsIsDeleted.AsBoolean then
      begin
        FHaveDeletedItem := True;
        DelSaleItemwithPromo(fIDPreSale,
                             CdsSaleItemsIDInventoryMov.AsInteger,
                             CdsSaleItemsIDModel.AsInteger,
                             CdsSaleItemsQty.AsFloat,
                             CdsSaleItemsSalePrice.AsFloat);
      end
      else if cdsSaleItemsIsNew.AsBoolean then
      begin
        InsertSaleItemWithPromo(fIDCliente,
                                fIDPreSale,
                                CdsSaleItemsIDInventoryMov.AsInteger,
                                CdsSaleItemsIDModel.AsInteger,
                                CdsSaleItemsIDComission.AsInteger,
                                CdsSaleItemsIDUser.AsInteger,
                                CdsSaleItemsIDDepartment.AsInteger,
                                CdsSaleItemsQty.AsFloat,
                                0,
                                CdsSaleItemsSalePrice.AsFloat,
                                CdsSaleItemsCostPrice.AsFloat,
                                APreSaleDate);
      end
      else if cdsSaleItemsIsUpdate.AsBoolean then
      begin
        UpdateSaleItemWithPromo(fIDPreSale,
                                CdsSaleItemsIDInventoryMov.AsInteger,
                                CdsSaleItemsIDModel.AsInteger,
                                CdsSaleItemsIDComission.AsInteger,
                                CdsSaleItemsIDUser.AsInteger,
                                CdsSaleItemsIDDepartment.AsInteger,
                                0,
                                CdsSaleItemsQty.AsFloat,
                                0,
                                CdsSaleItemsSalePrice.AsFloat,
                                CdsSaleItemsCostPrice.AsFloat,
                                APreSaleDate);
      end;

      cdsSaleItems.Next;
    end;//fim while cdsSaleItems.Eof do

  end;//fim if cdsSaleItems.RecordCount > 0 then


  CdsSaleItemsClone.Filter := 'IsPrize=True';
  CdsSaleItemsClone.Filtered := True;

  if not CdsSaleItemsClone.IsEmpty then
  begin
    CdsSaleItemsClone.First;
    while not CdsSaleItemsClone.Eof do
    begin
      if CdsSaleItemsCloneIsDeleted.AsBoolean then
      begin
        FHaveDeletedItem := True;

        DelSaleItemwithPromo(fIDPreSale,
                             CdsSaleItemsCloneIDInventoryMov.AsInteger,
                             CdsSaleItemsCloneIDModel.AsInteger,
                             CdsSaleItemsCloneQty.AsFloat,
                             CdsSaleItemsCloneSalePrice.AsFloat);
      end
      else if CdsSaleItemsCloneIsNew.AsBoolean then
      begin
        if CdsSaleItemsCloneDiscountType.AsInteger = DISCOUNT_PROMO_TYPE_QTY then
          dDiscount := CdsSaleItemsCloneQty.AsFloat * CdsSaleItemsCloneSalePrice.AsFloat
        else if CdsSaleItemsCloneSalePriceDiscount.AsFloat = 0 then
          dDiscount := 0
        else
        begin
          dDiscount := CdsSaleItemsCloneSalePrice.AsFloat - CdsSaleItemsCloneSalePriceDiscount.AsFloat;
          dDiscount := CdsSaleItemsCloneQty.AsFloat * dDiscount;
        end;

        InsertSaleItemWithPromo(fIDCliente,
                                fIDPreSale,
                                CdsSaleItemsCloneIDInventoryMov.AsInteger,
                                CdsSaleItemsCloneIDModel.AsInteger,
                                CdsSaleItemsCloneIDComission.AsInteger,
                                CdsSaleItemsCloneIDUser.AsInteger,
                                CdsSaleItemsCloneIDDepartment.AsInteger,
                                CdsSaleItemsCloneQty.AsFloat,
                                dDiscount,
                                CdsSaleItemsCloneSalePrice.AsFloat,
                                CdsSaleItemsCloneCostPrice.AsFloat,
                                APreSaleDate);
      end
      else if ( CdsSaleItemsCloneIsUpdate.AsBoolean or
               ((CdsSaleItemsCloneIsUpdate.AsBoolean = False) and
                (CdsSaleItemsCloneIDInventoryMov.AsInteger > 0)) ) then
      begin
        if CdsSaleItemsCloneDiscountType.AsInteger = DISCOUNT_PROMO_TYPE_QTY then
          dDiscount := CdsSaleItemsCloneQty.AsFloat * CdsSaleItemsCloneSalePrice.AsFloat
        else if CdsSaleItemsCloneSalePriceDiscount.AsFloat = 0 then
          dDiscount := 0
        else
        begin
          dDiscount := CdsSaleItemsCloneSalePrice.AsFloat - CdsSaleItemsCloneSalePriceDiscount.AsFloat;
          dDiscount := CdsSaleItemsCloneQty.AsFloat * dDiscount;
        end;

        //amfsouza 05.17.2011 - to avoid update if not stackable discount type
        if ( (not cdsSaleItems.FieldByName('SalePrice').IsNull) and ( not cdsSaleItems.FieldByName('DiscountLoyalt').IsNull) ) then begin
             if ( IsStackable(cdsPromoItem.fieldByName('PromoType').Value, cdsPromoItem.fieldByName('DiscountType').Value) = 0) then begin
                UpdateSaleItemWithPromo(fIDPreSale,
                                        CdsSaleItemsCloneIDInventoryMov.AsInteger,
                                        CdsSaleItemsCloneIDModel.AsInteger,
                                        CdsSaleItemsCloneIDComission.AsInteger,
                                        CdsSaleItemsCloneIDUser.AsInteger,
                                        CdsSaleItemsCloneIDDepartment.AsInteger,
                                        CdsSaleItemsCloneIDInventoryMovParent.AsInteger,
                                        CdsSaleItemsCloneQty.AsFloat,
                                        dDiscount,
                                        CdsSaleItemsCloneSalePrice.AsFloat,
                                        CdsSaleItemsCloneCostPrice.AsFloat,
                                        APreSaleDate);
             end
             else if ( cdsSaleItems.FieldByName('DiscountLoyalt').Value = 0 ) then
                     if ( dDiscount > 0 ) then
                                        UpdateSaleItemWithPromo(fIDPreSale,
                                        CdsSaleItemsCloneIDInventoryMov.AsInteger,
                                        CdsSaleItemsCloneIDModel.AsInteger,
                                        CdsSaleItemsCloneIDComission.AsInteger,
                                        CdsSaleItemsCloneIDUser.AsInteger,
                                        CdsSaleItemsCloneIDDepartment.AsInteger,
                                        CdsSaleItemsCloneIDInventoryMovParent.AsInteger,
                                        CdsSaleItemsCloneQty.AsFloat,
                                        dDiscount,
                                        CdsSaleItemsCloneSalePrice.AsFloat,
                                        CdsSaleItemsCloneCostPrice.AsFloat,
                                        APreSaleDate);
        end;
      end;

      CdsSaleItemsClone.Next;
    end;//fim while CdsSaleItemsClone.Eof do

  end;//fim if CdsSaleItemsClone.RecordCount > 0 then

end;

procedure TFrmPromoControl.DelSaleItemwithPromo(fIDPreSale, fIDPreInvMov, fIDModel : Integer;
                                                fQty, fSale : Double);
var iError : Integer;
begin
  DM.fPOS.DeleteHoldItem(fIDPreSale,
                         fIDPreInvMov,
                         fIDModel,
                         DM.fUser.ID,
                         fQty,
                         0,
                         fSale,
                         True,
                         True,
                         True,
                         now,
                         iError);
end;

procedure TFrmPromoControl.UpdateSaleItemWithPromo(fIDPreSale, fPreInvMovID, fIDModel,
                                         fIDCommis, fIDUSer, fDepartment, fIDPreSaleParent : Integer;
                                         fQty, fDiscount, fSale, fCost : Double;
                                         fMovDate : TDateTime);
var
  iError, iIDPreInvMov, iIDPreSaleParent, iIDDescriptionPrice,
  iIDVendorPrice, iIDDocumentType : Integer;

  bPromo : Boolean;

  dSuggPrice: Currency;
  sDocumentNumber: String;
begin

  DM.fPOS.UpdateHoldItem(fIDPreSale,
                         fPreInvMovID,
                         fIDModel,
                         fIDCommis,
                         fIDUSer,
                         fQty,
                         0,
                         fSale,
                         fCost,
                         fMovDate,
                         Now,
                         True,
                         True,
                         fDepartment,
                         iError,//Aqui
                         iIDPreInvMov,
                         0,
                         False,
                         0,
                         0,
                         0,
                         '',
                         0,
                         fDiscount);
                         {
                         iError,//Aqui
                         iIDPreInvMov,
                         iIDPreSaleParent,
                         bPromo,
                         iIDDescriptionPrice,
                         iIDVendorPrice,
                         dSuggPrice,
                         sDocumentNumber);
                         }

end;

procedure TFrmPromoControl.InsertSaleItemWithPromo(fIDCliente, fIDPreSale,
  fPreInvMovID, fIDModel, fIDCommis, fIDUSer, fDepartment: Integer; fQty,
  fDiscount, fSale, fCost: Double; fMovDate: TDateTime);

var
  iError, iIDDescriptionPrice,
  iIDVendorPrice, iIDDocumentType : Integer;

  EachDiscount : Double;
  bPromo : Boolean;

  dSuggPrice: Currency;
  sDocumentNumber: String;
begin

  EachDiscount := ( fDiscount/fQty );

    DM.fPOS.AddHoldItem(fIDCliente,
                        fIDPreSale,
                        fIDModel,
                        DM.fStore.IDStoreSale,
                        fQty,
                        0,
                        fSale,
                        fCost,
                        DM.fUser.ID,
                        fIDUSer,
                        fMovDate,
                        Now,
                        True,
                        True,
                        0,
                        fDepartment,
                        iError,
                        fPreInvMovID,
                        0,
                        False,
                        0,
                        0,
                        0,
                        '',
                        0,
                        fDiscount,
                        { Alex 09/18/2011 }
                        EachDiscount,
                        False,
                        );

                        {
                        fPreInvMovID,
                        0,
                        bPromo,
                        iIDDescriptionPrice,
                        iIDVendorPrice,
                        dSuggPrice,
                        sDocumentNumber,
                        iIDDocumentType);
                        }

end;

function TFrmPromoControl.CalcPromoTotal(fIDPreSale: Integer;
                                         IsLoyalty: Boolean;
                                         SubTotalSale: Double): Boolean;
var
 sListaItensVenda : String;
 CalculaPromo : Boolean;
begin
  cdsPromo.Filter :=  FDefaultPromoFilter+' and DiscountType='+InttoStr(DISCOUNT_PROMO_TYPE_SALE);
  cdsPromo.Filtered := True;

  if (not cdsPromo.IsEmpty) then
  begin
    while not cdsPromo.eof do
    begin
      CalculaPromo := True;

      if (cdsPromoPromoType.AsInteger = PROMO_TYPE_COUPON) then
      begin
        if cdsPromoBarcode.AsString <> FCoupon then
          CalculaPromo := False;
      end;

      if (cdsPromoPromoType.AsInteger = PROMO_TYPE_LOYALTY) then
      begin
        if not IsLoyalty then
          CalculaPromo := False;
      end;

      if CalculaPromo then
      begin

        with qryItemTotal do
        begin
          close;
          Parameters.ParamByName('StartDate').Value := Now;
          Parameters.ParamByName('EndDate').Value := Now;
          Parameters.ParamByName('DayOfWeek').Value := IntToStr(DayOfWeek(Now));
          Parameters.ParamByName('IDSale').Value := fIDPreSale;
          Parameters.ParamByName('IDPromo').Value := cdsPromoIDPromo.Value;
          open;

          if qryItemTotalItemTotal.AsFloat >= cdsPromoQtyPromoItem.AsFloat then
          begin
            UpdateSaleTotalWithPromo(fIDPreSale,
                                     cdsPromoDiscountValue.AsFloat,
                                     SubTotalSale);
          end;
          close;
        end

      end; //if CalculaPromo then

      cdsPromo.Next;
    end;//fim while not cdsPromo.eof do

  end;//if (not cdsPromo.IsEmpty) then

end;

procedure TFrmPromoControl.UpdateSaleTotalWithPromo(fIDPreSale: Integer;
                                                    fDiscountPercent, SubTotalSale: Double);
var
  dDiscount : Double;
begin
  dDiscount := (fDiscountPercent * 100) / SubTotalSale;

  DM.fPOS.ManageDiscount(fIDPreSale,
                         dDiscount,
                         Now,
                         DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE],
                         True,
                         True);
end;

function TFrmPromoControl.CalPromoFrequentByer(AIDCliente, ADocumentID: Integer): Double;
var
  iIDInventoryMov : Integer;
  dTotalDiscount, dTotalDiscountPromo, dFrequentQty, dQtyInUse: Double;
begin
  //QUANDO NEHNUM CLIENTE É SELECIONADO O IDCLIENTE É IGUAL A 1
  if (AIDCliente > 1) then
  begin
    FNewIDInventoryMov := 0;
    dTotalDiscountPromo := 0;


  //1) VERIFICAR SE O ITEM DA VENDA PERTENCE A UMA FREQUENT E A QUANTIDADE É MAIOR OU IGUAL AO PARAMETRIZADO.
  //2) CASO POISITIVO BUSCAR O ITEM PAI NO CDSPROMOITEM;
  //3) PASSAR COMO CÓDIGO PAI PARA A CDSPRIZEITEM
    with qryFrequentQtySale do
    begin
      Parameters.ParamByName('DocumentID').value := ADocumentID;
      Parameters.ParamByName('StartDate').value := now;
      Parameters.ParamByName('EndDate').value := now;
      Parameters.ParamByName('DayOfWeek').value := IntToStr(DayOfWeek(Now));
      Open;
    end;

    If not qryFrequentQtySale.IsEmpty then
    begin
      cdsItemsFrequentUse.Close;
      cdsItemsFrequentUse.CreateDataSet;

      //Percorre os Itens que foram encontrados na venda e possuem promoção
      qryFrequentQtySale.First;
      while not qryFrequentQtySale.Eof do
      begin
        dTotalDiscount := 0;

        qryFrequentQty.Parameters.ParamByName('IDPessoa').Value := AIDCliente;
        qryFrequentQty.Parameters.ParamByName('IDModel').Value := qryFrequentQtySaleIDModelPromoItem.AsInteger;
        qryFrequentQty.Open;

        if cdsItemsFrequentUse.Locate('IDModel', qryFrequentQtySaleIDModelPromoItem.AsInteger, []) then
          dQtyInUse := cdsItemsFrequentUseQtyUsed.AsFloat
        else
          dQtyInUse := 0;

        if ((qryFrequentQtyQty.AsFloat - dQtyInUse) >= qryFrequentQtySaleQtyFrequent.AsFloat) and (qryFrequentQtyQty.AsFloat > 0) then
        begin
          //Pode calcular o desconto
          dTotalDiscount := CalPromoFrequentByerQuantity(qryFrequentQtySaleFlatPromo.AsBoolean,
                                                 qryFrequentQtySaleIDModelPromoItem.AsInteger,
                                                 qryFrequentQtySaleIDPromo.AsInteger,
                                                 PROMO_TYPE_FREQUENTBUYER,
                                                 DISCOUNT_PROMO_TYPE_QTY,
                                                 qryFrequentQtySaleDiscountValue.AsFloat);
          {
          dTotalDiscount := CalPromoFrequentByerQuantity(bFlatPromo,
                               cdsSaleItemsIDInventoryMov.AsInteger,
                               cdsSaleItemsIDModel.AsInteger,
                               iIDPromo,
                               cdsPromoPrizeItemPromoType.AsInteger,
                               cdsPromoPrizeItemDiscountType.AsInteger,
                               dDiscountValue);
           }

            if dTotalDiscount > 0 then
            begin
              dTotalDiscountPromo := dTotalDiscountPromo + dTotalDiscount;

              if cdsItemsFrequentUse.Locate('IDModel', qryFrequentQtySaleIDModelPromoItem.AsInteger, []) then
              begin
                cdsItemsFrequentUse.Edit;
                cdsItemsFrequentUseQtyUsed.AsFloat := cdsItemsFrequentUseQtyUsed.AsFloat + qryFrequentQtySaleQtyFrequent.AsFloat;
                cdsItemsFrequentUse.Post;
              end
              else
              begin
                cdsItemsFrequentUse.Append;
                cdsItemsFrequentUseIDModel.AsInteger := qryFrequentQtySaleIDModelPromoItem.AsInteger;
                cdsItemsFrequentUseIDCustomer.AsInteger := AIDCliente;
                cdsItemsFrequentUseQtyUsed.AsFloat := qryFrequentQtySaleQtyFrequent.AsFloat;
                cdsItemsFrequentUse.Post;
              end;

              //Caso o item corrente tenha a quantidade maior ou menor que o neessário
              //então chama a função que vai efetuar o ajuste na quantidade do item
              {
              if cdsSaleItemsQty.AsFloat <> cdsPromoItem.FieldByName('QtyPromoItem').Value then
              begin
                AlterListSaleItens(cdsSaleItemsIDModel.AsInteger,
                                   cdsSaleItemsIDInventoryMov.AsInteger,
                                   dQtyPromoitem);
              end;

              SetSaleItemInUse(cdsPromoPrizeItemPromoType.AsInteger,
                               cdsPromoPrizeItemDiscountType.AsInteger,
                               iIDPromo,
                               dTotalDiscount);
              }
            end;

          end;//fim if CdsSaleItemsClone.FieldByName('SumQty').Value >= cdsPromoItem.FieldByName('QtyPromoItem').Value then

          qryFrequentQty.Close;


        qryFrequentQtySale.Next;
      end;

    end;//fim If not cdsSaleItems.IsEmpty then

    qryFrequentQtySale.Close;

    cdsSaleItems.Filter := '';
    cdsSaleItems.Filtered := False;

    cdsPromoItem.Filtered := False;
    cdsPromoPrizeItem.Filtered := False;
    CdsSaleItemsClone.Filtered := False;

    Result := dTotalDiscountPromo;
  end
  else
    Result := 0; 
end;

function TFrmPromoControl.CalPromoFrequentByerQuantity(APromoFlat: Boolean;
  AIDModel, AIDPromo, APromoType, ADiscountType: Integer;
  AQty: Double): Double;
var
  dQtyNew, dSalePrice, dTotalDiscount, dQtdUsed : Double;

  bCanCalcPromo : Boolean;

  sFiltroPrize : String;

begin
  dTotalDiscount := 0;
  dQtdUsed := AQty;

  //Busca os itens Prêmio do Item da Venda.
  cdsPromoPrizeItem.Filter := FDefaultPromoFilter +
                              ' AND IDModelPromoItem = '+ IntToStr(AIDModel) +
                              ' AND IDPromo = ' + IntToStr(AIDPromo);
  cdsPromoPrizeItem.Filtered := True;
  cdsPromoPrizeItem.IndexName := 'cdsPromoPrizeItemIndex2';

  CdsSaleItemsClone.Filtered := True;
  cdsPromoPrizeItem.First;
  while (not cdsPromoPrizeItem.Eof) do
  begin
    sFiltroPrize := ' IDModel = ' + cdsPromoPrizeItem.FieldByName('IDModel').asString;
                    //' AND InUse = False and IsDeleted = False';
    CdsSaleItemsClone.AggregatesActive := False;
    CdsSaleItemsClone.Filter := sFiltroPrize;
    CdsSaleItemsClone.IndexName := 'ixIDModel';
    CdsSaleItemsClone.AggregatesActive := True;

    if not CdsSaleItemsClone.IsEmpty then
    begin
      CdsSaleItemsClone.First;
//      while not CdsSaleItemsClone.eof do
//      begin

        if CdsSaleItemsClone.FieldByName('SumQty').Value < dQtdUsed then
          AQty := CdsSaleItemsClone.FieldByName('SumQty').Value
        else
          AQty := dQtdUsed;

        dQtdUsed := dQtdUsed - AQty;

        dSalePrice := CdsSaleItemsCloneSalePrice.AsFloat;

        //VERIFICA SE O ITEM JA PARTICIPA DE OUTRA PROMOÇÃO
        bCanCalcPromo := True;
        {
        if CdsSaleItemsCloneIDInventoryMovParent.value <> 0 then
        begin
          cdsSaleItems.Locate('IDInventoryMov', CdsSaleItemsCloneIDInventoryMovParent.value, []);
          if ((AQty * dSalePrice) > cdsSaleItemsTotalDiscountApplied.AsFloat) then
          begin
            CancelPromoItem(cdsSaleItemsIDInventoryMov.AsInteger, False);
            cdsSaleItems.Locate('IDInventoryMov', AIDInventoryMov, []);
          end
          else
          begin
            bCanCalcPromo := False;
            cdsSaleItems.Locate('IDInventoryMov', AIDInventoryMov, []);
          end;
        end;
        }
        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

//        sFiltroPrize := sFiltroPrize + '';

//        CdsSaleItemsClone.Next;
//      end;//fim while not CdsSaleItemsClone.eof do


     if bCanCalcPromo then
     begin

       //if CdsSaleItemsCloneQty.AsFloat = AQty then
       if CdsSaleItemsClone.Locate('Qty', AQty, []) then
       begin
         CdsSaleItemsClone.Edit;
         //CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
         CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
         CdsSaleItemsClonePromoType.AsInteger := APromoType;
         CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
         CdsSaleItemsCloneInUse.AsBoolean := True;
         CdsSaleItemsCloneSalePriceDiscount.AsFloat := 0;
         CdsSaleItemsClone.Post;
       end
       else if CdsSaleItemsCloneQty.AsFloat > AQty then
       begin
         dQtyNew := CdsSaleItemsCloneQty.AsFloat - AQty;
         CdsSaleItemsClone.Edit;
         CdsSaleItemsCloneQty.AsFloat := AQty;
         //CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
         CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
         CdsSaleItemsClonePromoType.AsInteger := APromoType;
         CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
         CdsSaleItemsCloneInUse.AsBoolean := True;
         CdsSaleItemsCloneIsUpdate.AsBoolean := True;
         CdsSaleItemsCloneSalePriceDiscount.AsFloat := 0;
         CdsSaleItemsClone.Post;

         {
         Verifica se existe mais um item lançado na venda para efetuar a redistribuição
         das quantidades
         }
         CdsSaleItemsClone.Next;
         if (not CdsSaleItemsClone.eof) then
         begin
           CdsSaleItemsClone.Edit;
           CdsSaleItemsCloneQty.AsFloat := CdsSaleItemsCloneQty.AsFloat + dQtyNew;
           CdsSaleItemsClone.Post;
         end//if CdsSaleItemsClone.RecordCount > 1 then
         else
         begin
           Inc(FNewIDInventoryMov);
           Inc(FIndiceInsert);
           InsertNewSaleItemClone(FNewIDInventoryMov,
                                  CdsSaleItemsCloneIDModel.AsInteger,
                                  FIndiceInsert,
                                  CdsSaleItemsCloneIDComission.AsInteger,
                                  CdsSaleItemsCloneIDUser.AsInteger,
                                  CdsSaleItemsCloneIDDepartment.AsInteger,
                                  CdsSaleItemsCloneSalePrice.AsFloat,
                                  dQtyNew,
                                  CdsSaleItemsCloneCostPrice.AsFloat,
                                  False,
                                  CdsSaleItemsCloneIsPrize.AsBoolean,
                                  True,
                                  False,
                                  False,
                                  CdsSaleItemsCloneDiscountLoyalt.AsFloat);
         end;

       end
       else if CdsSaleItemsCloneQty.AsFloat < AQty then
       begin
         {
           Como a quanitade é menor o valor precisa ser subtraído dos demais itens
           da venda
          }
         dQtyNew := AQty - CdsSaleItemsCloneQty.AsFloat;
         CdsSaleItemsClone.Edit;
         CdsSaleItemsCloneQty.AsFloat := AQty;
        // CdsSaleItemsCloneIDInventoryMovParent.AsInteger := AIDInventoryMov;
         CdsSaleItemsCloneIDPromo.AsInteger := AIDPromo;
         CdsSaleItemsClonePromoType.AsInteger := APromoType;
         CdsSaleItemsCloneDiscountType.AsInteger := ADiscountType;
         CdsSaleItemsCloneInUse.AsBoolean := True;
         CdsSaleItemsCloneIsUpdate.AsBoolean := True;
         CdsSaleItemsCloneSalePriceDiscount.AsFloat := 0;
         CdsSaleItemsClone.Post;

         CdsSaleItemsClone.Next;
         while (dQtyNew > 0) do
         begin

           if (CdsSaleItemsCloneQty.AsFloat - dQtyNew) > 0 then
           begin
             CdsSaleItemsClone.Edit;
             CdsSaleItemsCloneQty.AsFloat := CdsSaleItemsCloneQty.AsFloat - dQtyNew;
             CdsSaleItemsCloneIsUpdate.AsBoolean := True;
             dQtyNew := 0;
             CdsSaleItemsClone.Post;
             CdsSaleItemsClone.Next;
           end
           else
           begin
             { se for menor que zero então exclui o item da lista
               pois não tem quantidade disponível}
             CdsSaleItemsClone.Edit;
             dQtyNew := dQtyNew - CdsSaleItemsCloneQty.AsFloat;
             CdsSaleItemsCloneIsDeleted.AsBoolean := True;
             CdsSaleItemsClone.Post;
             CdsSaleItemsClone.Next;
           end;

         end;//Fim while

       end;

       dTotalDiscount := AQty * dSalePrice;

      end; //fim if bCanCalcPromo then

    end;//fim if not CdsSaleItemsClone.IsEmpty then

    if (dQtdUsed > 0) then
      cdsPromoPrizeItem.Next
    else
      cdsPromoPrizeItem.Last;
  end;

  CdsSaleItemsClone.Filtered := False;
  CdsSaleItemsClone.Filter := '';
  CdsSaleItemsClone.IndexName := '';

  cdsPromoPrizeItem.Filter := '';
  cdsPromoPrizeItem.Filtered := False;

  Result := dTotalDiscount;

end;

procedure TFrmPromoControl.NewAdjustFrequentPromo;
var
  NewIDFrequentPromo : Integer;
  sSQL : String;
begin
{
ATUALIZA O SALDO NA TABELA Sal_FrequentPromo SUBTRAINDO OS ITENS
UTILIZADOS NA PROMOÇÃO DE FREQUENT
}
  if not cdsItemsFrequentUse.IsEmpty then
  begin
    while not cdsItemsFrequentUse.eof do
    begin
      sSQL := ' UPDATE Sal_FrequentPromo SET Qty = Qty - ' + cdsItemsFrequentUseQtyUsed.AsString +
              ' WHERE IDModel = ' + cdsItemsFrequentUseIDModel.AsString +
              '       AND IDPessoa = ' + cdsItemsFrequentUseIDCustomer.AsString;

      DM.ADODBConnect.Execute(sSQL);

      cdsItemsFrequentUse.Next;
    end;
  end;

{
ATUALIZA O SALDO NA TABELA Sal_FrequentPromo ADICIONANDO OS ITENS
QUE ESTÃO NA VENDA E FAZEM PARTE DA PROMOÇÃO DE FREQUENT
}
  if not qryFrequentQtySalePromo.IsEmpty then
  begin
    while not qryFrequentQtySalePromo.eof do
    begin
      with DM.quFreeSQL do
      try
        if Active then
          Close;

        SQL.Text := ' SELECT IDFrequentPromo FROM Sal_FrequentPromo (NOLOCK) ' +
                    ' WHERE IDModel = ' + qryFrequentQtySalePromoIDModel.AsString +
                    '       AND IDPessoa = ' + qryFrequentQtySalePromoIDPessoa.AsString;
        Open;

        //Se ja existe o registro então atualiza, senão cria um novo
        if not IsEmpty then
          sSQL := ' UPDATE Sal_FrequentPromo SET Qty = Qty + ' + qryFrequentQtySalePromoQty.AsString +
                  ' WHERE IDModel = ' + qryFrequentQtySalePromoIDModel.AsString +
                  '       AND IDPessoa = ' + qryFrequentQtySalePromoIDPessoa.AsString
        else
        begin
          NewIDFrequentPromo := DM.GetNextID('Sal_FrequentPromo.IDFrequentPromo');

          sSQL := ' Insert Into Sal_FrequentPromo(IDFrequentPromo, IDPessoa, IDModel, Qty, IsUsed)' +
                  'Values('+IntToStr(NewIDFrequentPromo)+','+qryFrequentQtySalePromoIDPessoa.AsString+','+
                          qryFrequentQtySalePromoIDModel.AsString+','+qryFrequentQtySalePromoQty.AsString+',0)';
        end;
      finally
        Close;
        DM.ADODBConnect.Execute(sSQL);
      end;

      qryFrequentQtySalePromo.Next;
    end;//fmi while not qryFrequentQtySalePromo.eof do
  end;//fim if not qryFrequentQtySalePromo.IsEmpty then

  qryFrequentQtySalePromo.Close;
  cdsItemsFrequentUse.Close;

end;

function TFrmPromoControl.IsStackable(promoType,
  discountType: integer): Integer;
begin
  (*
    //PromoType
  PROMO_TYPE_SALE          = 1;
  PROMO_TYPE_FREQUENTBUYER = 2;
  PROMO_TYPE_COUPON        = 3;
  PROMO_TYPE_LOYALTY       = 4;

  //DiscountType
  DISCOUNT_PROMO_TYPE_PERCENTUAL = 1;
  DISCOUNT_PROMO_TYPE_VALUE      = 2;
  DISCOUNT_PROMO_TYPE_QTY        = 3;
  DISCOUNT_PROMO_TYPE_SALE       = 4;

  *)

  case promoType of
    PROMO_TYPE_SALE : begin
       case discountType of
         DISCOUNT_PROMO_TYPE_PERCENTUAL..DISCOUNT_PROMO_TYPE_QTY: result := -1;
         DISCOUNT_PROMO_TYPE_SALE: result := 0;
       end;
    end;
    PROMO_TYPE_LOYALTY: begin
       case discountType of
         DISCOUNT_PROMO_TYPE_PERCENTUAL..DISCOUNT_PROMO_TYPE_QTY: result := -1;
         DISCOUNT_PROMO_TYPE_SALE: result := 0;
       end;
    end;
  else
    result := 1;
  end;
end;

function TFrmPromoControl.IsDonePromo(qtySold, qtyPrize: double; count_X, count_Y: integer): boolean;
var
   i: integer;
   k: integer;
   count_X_Ref_Y, countFree: integer;
begin
   i := 1;
   count_X_Ref_y := 0;
   countFree     := 0;
   while ( i <= qtySold ) do begin
         inc(count_X_Ref_Y);

         if ( count_X_Ref_Y = count_X ) then begin
            for k:= 1 to count_Y do
                inc(countFree);

            count_X_Ref_Y := 0;
         end;

         inc(i);
   end;

   result := ( countFree = qtyPrize );

end;

function TFrmPromoControl.getQtyPrizeBySale(qtySold: double; count_x,
  count_y: integer): integer;
var
   i: integer;
   k: integer;
   count_X_Ref_Y, countFree: integer;
   sumXY: Integer;
begin
   i := 1;
   count_X_Ref_y := 0;
   countFree     := 0;

   sumXY := count_X + count_Y;
//   if ( (trunc(qtySold) mod sumXY) = 0 ) then begin
       while ( i <= qtySold ) do begin
             inc(count_X_Ref_Y);
             if ( i mod (count_x + count_y) = 0 ) then begin
                if ( count_X_Ref_Y >= count_X ) then begin
                   for k:= 1 to count_Y do
                       inc(countFree);

                   count_X_Ref_Y := 0;
                end;
             end;
             inc(i);
       end;

       result := countFree;
  // end;
end;

end.

