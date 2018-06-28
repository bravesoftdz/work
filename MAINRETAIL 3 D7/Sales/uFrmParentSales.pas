unit uFrmParentSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeForms, siComp, siLangRT, uPreSaleItem, DB, ADODB,
  cxClasses, cxStyles, cxGridTableView, uInvoiceInfo, uFrmPromoControl,
  uSaleItem, uFrmAddItemCommission, uBonusBucks, clsInfoCashSale, DbClient,
  uCCMercuryIntegration;

type
  TFrmParentSales = class(TFrmParentForms)
    dsPreSaleItem: TDataSource;
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
    dsPreSaleInfo: TDataSource;
    dsPreSaleValue: TDataSource;
    spquPreSaleValue: TADOStoredProc;
    spquPreSaleValueTaxIsent: TBooleanField;
    spquPreSaleValueSubTotal: TFloatField;
    spquPreSaleValueItemDiscount: TFloatField;
    spquPreSaleValueTax: TFloatField;
    spquPreSaleValueTaxPrc: TFloatField;
    spquPreSaleValueDiscountPrc: TFloatField;
    spquPreSaleValueTotalInvoice: TFloatField;
    spquPreSaleValueSpecialPriceID: TIntegerField;
    spquPreSaleValueSpecialPrice: TStringField;
    spquPreSaleValuenOpenUser: TIntegerField;
    spquPreSaleValueShowOpenUser: TIntegerField;
    spquPreSaleValueNewSubTotal: TFloatField;
    spquPreSaleValueTaxIsemptValue: TFloatField;
    spquPreSaleValueSubTotalTaxable: TCurrencyField;
    spquPreSaleValueTaxIsemptItemDiscount: TFloatField;
    spUpHold: TADOStoredProc;
    strepSaleItem: TcxStyleRepository;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    cxStyle1: TcxStyle;
    cxStyleContent: TcxStyle;
    cxStyleContentEven: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyleHeader: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyleSelection: TcxStyle;
    quPreSaleInfo: TADOQuery;
    quPreSaleInfoIDPreSale: TIntegerField;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoDeliverTypeID: TIntegerField;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleInfoDeliverAddress: TStringField;
    quPreSaleInfoPassportDate: TDateTimeField;
    quPreSaleInfoAirLine: TStringField;
    quPreSaleInfoCompanyName: TStringField;
    quPreSaleInfoCompanyCGC: TStringField;
    quPreSaleInfoDepositDate: TDateTimeField;
    quPreSaleInfoNote: TStringField;
    quPreSaleInfoInvoiceDate: TDateTimeField;
    quPreSaleInfoIDInvoice: TIntegerField;
    quPreSaleInfoPassport: TStringField;
    quPreSaleInfoTicket: TStringField;
    quPreSaleInfoMediaID: TIntegerField;
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoIDStore: TIntegerField;
    quPreSaleInfoAddress: TStringField;
    quPreSaleInfoLayaway: TBooleanField;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quPreSaleInfoZip: TStringField;
    quPreSaleInfoPrintNotes: TBooleanField;
    quPreSaleInfoDeliverOBS: TStringField;
    quPreSaleInfoDeliverConfirmation: TBooleanField;
    quPreSaleInfoIDFormOfPayment: TIntegerField;
    quPreSaleInfoIDPreSaleParent: TIntegerField;
    quPreSaleInfoSaleCode: TStringField;
    quPreSaleInfoInvoiceCode: TStringField;
    spquPreSaleValueAditionalExpenses: TBCDField;
    spquPreSaleItemIDDepartment: TIntegerField;
    spquPreSaleItemRequestCustomer: TBooleanField;
    spquPreSaleItemPuppyTracker: TBooleanField;
    quPreSaleInfoPuppyTracker: TBooleanField;
    spquPreSaleItemPromo: TBooleanField;
    spquPreSaleItemIDMovParent: TIntegerField;
    quPreSaleInfoTaxIsent: TBooleanField;
    spquPreSaleValueInvoiceDiscount: TCurrencyField;
    spquPreSaleValueTotalDiscount: TCurrencyField;
    spquPreSaleItemTotalSaved: TCurrencyField;
    spquPreSaleValueTotalSaved: TCurrencyField;
    spquPreSaleItemTotalSalePrice: TCurrencyField;
    spquPreSaleItemUnitDiscount: TCurrencyField;
    procedure OnAddClick(Sender:TObject);
    procedure OnDetailClick(Sender:TObject);
    procedure OnRemoveClick(Sender:TObject);
    procedure OnCancelClick(Sender:TObject);
    procedure OnAddSerialNumClick(Sender: TObject);
    procedure OnJoinHoldClick(Sender: TObject);
    procedure OnOpenHoldClick(Sender: TObject);
    procedure OnChangeUserClick(Sender : TObject);
    procedure OnHistoryClick(Sender : TObject);
    procedure OnCommissionClick(Sender : TObject);
    procedure OnSpecialPriceClick(Sender : TObject);
    procedure OnSelectCustomer(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spquPreSaleItemCalcFields(DataSet: TDataSet);
    procedure quPreSaleInfoAfterOpen(DataSet: TDataSet);
  private
    // Antonio 09/10/2015: To get concrete Prepaid instantied.
    fActivePrepaidTransaction: TCCWidget;
    mercuryGiftCard: TCPrePaid;

    //Antonio M F Souza September 26, 2012 - to save quantity after edit screen.
    fSaveQtyToPriceBreak: Double;

    fCountCard: Integer;
    fQtyTyped: Integer;
    FNeedSwip: Boolean;
    sJunction : String;

    // Antonio, August 06, 2013
    procedure writeSerialNumber(serial_number: String; arg_issued: Byte);

    function ViewSerialHistory: Boolean;

    procedure setNeedSwip(const Value: Boolean);
    procedure NeedSwipe(Sender: TObject; var SwipedTrack: WideString; var Canceled: Boolean);
    procedure setSaveQtyToPriceBreak(const Value: Double);

    //procedure RemoveHoldItem;
  protected
    FReturn: Boolean;
    //Antonio M F Souza June 16, 2012
    objInfoCashSale: InfoCashSale;

    ListIdPreInventoryOnSameSale: TStringList;
    //Antonio M F Souza 06.07.2011
    CalledSerialNumberScreen: boolean;
    HaveSerialNumber: boolean;
    ListSerialNumbers: TStringList;
    FApplyPromoOnSale: Boolean;
    FApplyCommissionToAll: Boolean;
    FInvoiceInfo: TInvoiceInfo;
    FFrmPreSaleItem: TFrmPreSaleItem;
    FFrmAddItemCommission: TFrmAddItemCommission;
    FFrmPromoControl: TFrmPromoControl;
    FCoupon: String;

    // to fix tax exempt
    procedure OnExemptTaxClick(Sender : TObject); virtual;

    //Antonio M F Souza 07.06.2011
    procedure RemoveHoldItem;

    procedure LoadImages; virtual; abstract;
    procedure Translation; virtual;

    procedure CreateHold(IsLayway: Boolean = False); virtual;
    procedure CloseHold; virtual;
    procedure OpenHold(IDPreSale: Integer); virtual;
    procedure JoinHold(IDPreSale: Integer; Customer, OBS : String); virtual;
    procedure DeleteHold; virtual;
    procedure CreateHoldNumber;
    procedure AfterCreateHoldNumber; virtual;
    procedure RefreshHold; virtual;
    procedure SaveHoldInfo;
    procedure NewHold(IsLayway: Boolean = False); virtual;
    procedure ClearHoldItems;
    procedure AddSerialNumber(qty_typed: Integer = 0; arg_idpreinvmov: Integer = 0);
    procedure ApplyCommission;
    function EmptyHold: Boolean;

    function TestUserComission: Boolean;
    function TestBeforeAdd : Boolean; virtual;
    function TestBeforeDetail : Boolean; virtual;
    function TestBeforeRemove : Boolean; virtual;

    procedure RefreshInfo;
    procedure AfterRefreshInfo; virtual;
    procedure RefreshItem(PreInventMovID: Integer); virtual;
    procedure RefreshValue;

    function GetSerialType: Integer; virtual;

    function ExemptCustomerTax(IDCustomer: Integer) : Boolean;
    procedure ApplyTaxExemption;
    procedure SubApplyTaxExemption(Exempt : Boolean);
    procedure UndoTaxExemption;
    procedure RefreshTaxControls; virtual;
    function GetModelDepartment(IDModel: Integer): Integer;

    procedure SetDefaultSalesPerson;
    function SaleNeedCustomer: Boolean;
    function ApplyPromoOnPrizeItems: Boolean;
    function ApplyPromoOnPromoItems: Boolean;
    procedure ApplyPromoOnAllItems;

    procedure ApplyBonusBucks(ACupom: String);
    procedure CloseUsedBonus;
    function BonusUtilized(AIDPreSale, AIndex: Integer): Boolean;
    procedure UpdatePuppyTrackerInfo;

    function dealCardSerialNumber: Boolean;

    public
      property SaveQtyToPriceBreak: Double read fSaveQtyToPriceBreak write setSaveQtyToPriceBreak;
      property NeedSwip: Boolean read FNeedSwip write setNeedSwip;
  end;

implementation

{$R *.dfm}

uses uMsgBox, uMsgConstant, uDM, uSystemConst, uPassword, uFrmSerialNumber,
     uFrmJoinHold, uDMGlobal, uFrmHistoryManage, uTaxIsent, uMakeSpcPrice,
     uSplitPreSale, uSelectDepartment, uDateTimeFunctions, uNumericFunctions,
     frmSerialNumberDialogView, frmCardNumberDialogView,
     uCreditCardFunction, ufrmSerialNumberHistory, uDebugFunctions, Math,
     SerialNumberCls;

{ TFrmParentSales }

procedure TFrmParentSales.FormCreate(Sender: TObject);
begin
  inherited;
  FApplyPromoOnSale := DM.fSystem.SrvParam[PARAM_APPLY_PROMO_ON_SALE];
  if FApplyPromoOnSale then
  begin
    FFrmPromoControl := TFrmPromoControl.Create(Self);
    FFrmPromoControl.LoadValidityPromo;
  end;

  FInvoiceInfo := TInvoiceInfo.Create(DM.ADODBConnect);
  LoadImages;
  FFrmPreSaleItem := TFrmPreSaleItem.Create(Self);
  FFrmAddItemCommission := TFrmAddItemCommission.Create(Self);

  if not Assigned(DM.fPOS.fCommisList) then
    DM.fPOS.fCommisList := TStringList.Create;

  Translation;

  ListIdPreInventoryOnSameSale := TStringList.Create;

  //Antonio M F Souza June 16, 2012
  objInfoCashSale := InfoCashSale.Create;
  mercuryGiftCard := TCPrePaid.Create;
end;

procedure TFrmParentSales.Translation;
begin
  case DMGlobal.IDLanguage of
    LANG_ENGLISH   : sJunction := 'Junction with Hold # ';
    LANG_PORTUGUESE: sJunction := 'Junção com o Pedido Nº ';
    LANG_SPANISH   : sJunction := 'El empalme con Boleta Nº ';
  end;
end;

procedure TFrmParentSales.FormDestroy(Sender: TObject);
begin
  inherited;
  if FApplyPromoOnSale then
    FreeAndNil(FFrmPromoControl);

  FreeAndNil(FInvoiceInfo);
  FreeAndNil(FFrmPreSaleItem);
  FreeAndNil(FFrmAddItemCommission);

  if Assigned(DM.fPOS.fDefaultSalesPerson) then
    FreeAndNil(DM.fPOS.fDefaultSalesPerson);

  if Assigned(DM.fPOS.fCommisList) then
    FreeAndNil(DM.fPOS.fCommisList);

  freeAndNil(ListIdPreInventoryOnSameSale);

  //Antonio M F Souza June 16, 2012
  freeAndNil(objInfoCashSale);


end;

procedure TFrmParentSales.SaveHoldInfo;
begin
  with quPreSaleInfo do
    if Active and (State in dsEditModes) then
      Post;
end;

procedure TFrmParentSales.CloseHold;
begin
  SaveHoldInfo;
  quPreSaleInfo.Close;
  spquPreSaleValue.Close;
  spquPreSaleItem.Close;

  FInvoiceInfo.RefreshStatus;
  FInvoiceInfo.DecHold;

  if EmptyHold then
    DeleteHold
  else
    CreateHoldNumber;
end;

procedure TFrmParentSales.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    CloseHold;
  finally
    Screen.Cursor := crDefault;
  end;

  if ( mercuryGiftCard <> nil ) then
     mercuryGiftCard.Free;

  Action := caFree;
end;

procedure TFrmParentSales.OnAddClick(Sender: TObject);
var
  PreInventMovID: Integer;
begin
  PreInventMovID := 0;
  if TestBeforeAdd and TestUserComission then
  begin
    //to review this assigned.
    FFrmPreSaleItem.Start(FInvoiceInfo.IDPreSale,
                          PreInventMovID,
                          quPreSaleInfoPreSaleDate.AsDateTime,
                          quPreSaleInfoIDCustomer.AsInteger,
                          spquPreSaleItem,
                          spquPreSaleValue,
                          True,
                          0,
                          FFrmPromoControl,
                          fReturn);

    if quPreSaleInfo.FieldByName('IDCustomer').AsInteger <> 1 then
      DM.fPOS.ApplyCustomerItemDiscount(FInvoiceInfo.IDPreSale,
                                        quPreSaleInfo.FieldByName('IDCustomer').AsInteger,
                                        PreInventMovID,
                                        quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime);

    RefreshItem(PreInventMovID);

    //Antonio M F Souza 05.18.2011 - need to refresh
    spquPreSaleItem.close;
    spquPreSaleItem.Open;
    spquPreSaleValue.close;
    spquPresaleValue.Open;

//    if FApplyPromoOnSale then
//      ApplyPromoOnAllItems;

    UpdatePuppyTrackerInfo;
  end;

end;

function TFrmParentSales.TestUserComission: Boolean;
begin
  Result := (DM.fUser.IDCommission > 0);
  if not Result then
  begin
    MessageBeep(MB_ICONASTERISK);
    MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbOKOnly + vbInformation);
  end;
end;

procedure TFrmParentSales.spquPreSaleItemCalcFields(DataSet: TDataSet);
(*
//Antonio M F Souza October 24, 2012 - preparing each operator to rounding
var
   tempSaleItemQty: Extended;
   tempSaleItemSalePrice: Extended;
   tempSaleItemSalePriceStr: String;
   tempSaleItemTotalSalePrice: Extended;
   tempSaleItemDiscount: Extended;
   tempSaleItemUnitDiscount: Extended;
   // Antonio M F Souza, December 06, 2012
   tempSaleItemTotalItem: Extended;
*)
begin
 // inherited;
(* Antonio 10/24/2016
  tempSaleItemQty := 0;
  tempSaleItemSalePrice := 0;

  tempSaleItemTotalSalePrice := 0;
  tempSaleItemDiscount := 0;

  // Antonio M F SOuza, December 05, 2012 - discount calculated by detail or other routine.
  tempSaleItemDiscount := spquPreSaleItemDiscount.Value;

  // Antonio M F Souza November 14, 2012
  tempSaleItemQty      := spquPresaleItemQty.Value;

  // unit price
  //november tempSaleItemSalePrice    := truncMoney(spquPreSaleItemSalePrice.Value, length(spquPreSaleItemSalePrice.asString));
  tempSaleItemSalePrice    := spquPreSaleItemSalePrice.Value;

  // Ext. Price
  tempSaleItemSalePrice := spquPreSaleItemSalePrice.Value;

  tempSaleItemTotalSalePrice := roundLikeDatabase((tempSaleItemQty * tempSaleItemSalePrice), 2);
  // november 30 spquPreSaleItemTotalSalePrice.Value := forceRoundInThirdPosition(tempSaleItemTotalSalePrice, 2);
  spquPreSaleItemTotalSalePrice.Value := tempSaleItemTotalSalePrice;

  tempSaleItemUnitDiscount := spquPreSaleItemUnitDiscount.Value;

  if ( tempSaleItemDiscount = 0 )
     then tempSaleItemUnitDiscount := 0;

  // Antonio M F Souza: May 21, 2013 - Extended Discount calculation to no refund sale must to multiply by quantity
  if ( objInfoCashSale.getNewTotalDue = 0 ) then begin
  		tempSaleItemDiscount := ( tempSaleItemUnitDiscount * tempSaleItemQty );
  end;

  spquPreSaleItemDiscount.Value := tempSaleItemDiscount;
  spquPreSaleItemUnitDiscount.Value := tempSaleItemUnitDiscount;

  if ( tempSaleQty >= 0 ) then begin
     tempSaleItemTotalItem := tempSaleItemTotalSalePrice - tempSaleItemDiscount;
  end;

  spquPresaleItemTotalItem.Value := tempSaleItemTotalSalePrice - tempSaleItemDiscount;

  //amfsouza May 20, 2013 - for any reason(...) customer discount affects unit discount.
  if ( tempSaleItemDiscount > 0 ) then begin
     if ( tempSaleItemUnitDiscount = 0 ) then begin
        tempSaleItemUnitDiscount := ( tempSaleItemDiscount / tempSaleItemQty );
        spquPreSaleItemUnitDiscount.Value := tempSaleItemUnitDiscount;
     end;
  end;

  //Calcula Discount correto ( what means ? )
  spquPreSaleItemDiscActual.value  := (tempSaleItemDiscount * -1);
  *)
end;

procedure TFrmParentSales.OnDetailClick(Sender: TObject);
Var
  PreInventMovID: Integer;
begin
  if TestBeforeDetail and TestUserComission then
  begin
    // Muda desconto novo item
    PreInventMovID := spquPreSaleItemIDInventoryMov.AsInteger;
    FFrmPreSaleItem.QuSerialMov.Close;
    FFrmPreSaleItem.QuSerialMov.Parameters.Items[0].Value := PreInventMovID;
    FFrmPreSaleItem.QuSerialMov.Open;

    //to review
    FFrmPreSaleItem.Start(FInvoiceInfo.IDPreSale,
                          PreInventMovID,
                          quPreSaleInfoPreSaleDate.AsDateTime,
                          quPreSaleInfoIDCustomer.AsInteger,
                          spquPreSaleItem,
                          spquPreSaleValue,
                          false,
                          spquPreSaleItemIDDepartment.AsInteger,
                          FFrmPromoControl);

    //Antonio M F Souza April 27, 2015 : MR-120, MR-121 ( see in Jira )
    if ( dm.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] = 'True' ) then begin
        fSaveQtyToPriceBreak := strToFloat(FFrmPreSaleItem.EditQty.Text)
    end else begin
           fSaveQtyToPriceBreak := trunc(strToFloat(FFrmPreSaleItem.EditQty.text));
        end;


    RefreshItem(PreInventMovID);

  end;
end;

procedure TFrmParentSales.RefreshInfo;
begin
  with quPreSAleInfo do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDPreSale').Value := FInvoiceInfo.IDPreSale;
    Open;
  end;

  AfterRefreshInfo;
  
end;

procedure TFrmParentSales.RefreshItem(PreInventMovID: Integer);
begin
  Screen.Cursor := crHourGlass;

  with spquPreSaleItem do
  begin
    Close;
    if (not FInvoiceInfo.IsInvoice) then
    begin
      Parameters.ParambyName('@DocumentID').Value := FInvoiceInfo.IDPreSale;
      Parameters.ParambyName('@IsPreSale').Value  := True;
    end
    else
    begin
      Parameters.ParambyName('@DocumentID').Value := FInvoiceInfo.IDInvoice;
      Parameters.ParambyName('@IsPreSale').Value  := False;
    end;
    Parameters.ParambyName('@Date').Value       := Now;
    Open;

    if PreInventMovID <> 0 then
      Locate('IDInventoryMov', IntToStr(PreInventMovID), []);

    // Antonio M F Souza 10.06.2011 - counter to puppy from hold.
    if ( dm.verifyPuppyInPetCategory(spquPreSaleItemModelID.Value) ) then
        dm.CounterPuppyFromHold := dm.CounterPuppyFromHold + 1;
  end;

  RefreshValue;
  Screen.Cursor := crDefault;
end;

procedure TFrmParentSales.RefreshValue;
begin
  Screen.Cursor := crHourGlass;

  with spquPreSaleValue do
  begin
    if Active then
      Close;
    Parameters.ParambyName('@PreSaleID').Value := FInvoiceInfo.IDPreSale;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TFrmParentSales.OnRemoveClick(Sender: TObject);
begin
  if TestBeforeRemove then
    if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
    try
      Screen.Cursor := crHourGlass;
      RemoveHoldItem;
    finally
      Screen.Cursor := crDefault;
    end;
end;

function TFrmParentSales.GetSerialType:Integer;
begin
  Result := SERIAL_HOLD;
end;

procedure TFrmParentSales.OnAddSerialNumClick(Sender: TObject);
begin
  if spquPreSaleItem.IsEmpty then
     Exit;

  viewSerialHistory;

end;

procedure TFrmParentSales.OnJoinHoldClick(Sender: TObject);
var
  iHold: Integer;
  sCustomer,
  sOBS: String;
begin
  with TFrmJoinHold.Create(Self) do
    iHold := Start(quPreSaleInfoIDPreSale.AsInteger, sCustomer, sOBS, False);

  if (iHold <> -1) then
     JoinHold(iHold, sCustomer, sOBS);
end;

procedure TFrmParentSales.JoinHold(IDPreSale: Integer; Customer, OBS : String);
begin
  if MsgBox(MSG_QST_PART1_MOVE_INVOICE_ITEM + ' ' +MSG_QST_PART2_MOVE_INVOICE_ITEM + ' ('+Customer+')',
     vbYesNo + vbQuestion) = vbYes Then
  begin
    with spUpHold do
    begin
      Parameters.ParambyName('@IDPreSaleOrigem').Value  := IDPreSale;
      Parameters.ParambyName('@IDPreSaleDestino').Value := FInvoiceInfo.IDPreSale;
      Parameters.ParambyName('@Date').Value             := Now;
      Parameters.ParambyName('@IDUser').Value           := DM.fUser.ID;
      ExecProc;
    end;
    RefreshItem(0);
    quPreSaleInfo.Edit;
    quPreSaleInfoNote.AsString := OBS + #13#10 + sJunction + IntToStr(IDPreSale);
    CreateHoldNumber;
  end;
end;

procedure TFrmParentSales.OnOpenHoldClick(Sender: TObject);
var
  iHold: Integer;
  sCustomer,
  sOBS: String;
begin

  with TFrmJoinHold.Create(Self) do
    iHold := Start(FInvoiceInfo.IDPreSale, sCustomer, sOBS, (not FInvoiceInfo.IsShipping));

  if (iHold <> -1) then
    OpenHold(iHold);
end;

procedure TFrmParentSales.OpenHold(IDPreSale : Integer);
begin
  //Deletar o Hold atual antes de abrir
  if FInvoiceInfo.IsNewHold then
    DeleteHold
  else
    CloseHold;

  FInvoiceInfo.IDPreSale := IDPreSale;

  //Create a New PreSale
  FInvoiceInfo.IsNewHold := False;
  FInvoiceInfo.IDInvoice := 0;

  //Information about Hold
  RefreshInfo;

  //PreSale Items
  RefreshItem(0);

  if (spquPreSaleItem.RecordCount > 0) and (not FInvoiceInfo.IsInvoice) then
  begin
    //PollDisplay
    DM.PollDisplayCloseSale;
    DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                          Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                          spquPreSaleValueAditionalExpenses.AsCurrency,
                          spquPreSaleValueTotalDiscount.AsCurrency,
                          spquPreSaleValueTax.AsCurrency,
                          spquPreSaleValueSubTotal.AsCurrency);

    DM.PollDisplayOpenHoldItems(spquPreSaleItem);
  end;


  if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
    FInvoiceInfo.LoadBonusBucks;
end;

procedure TFrmParentSales.CloseUsedBonus;
begin
  FInvoiceInfo.ClearBBList;
end;

procedure TFrmParentSales.ApplyBonusBucks(ACupom: String);
var
  iBBIndex: Integer;
  bbUsed: Boolean;
  bbBonus: TBonusBucks;
begin
  if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
  begin
    bbUsed := False;

    iBBIndex := FInvoiceInfo.BonusBuckList.Add(TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync));
    bbBonus := TBonusBucks(FInvoiceInfo.BonusBuckList[iBBIndex]);

    bbBonus.LoadByCupom(ACupom);
    if not BonusUtilized(bbBonus.IDPreSaleCreated, iBBIndex) then
    begin
      if bbBonus.ValidateCoupon then
      begin
        bbUsed := True;
        RefreshHold;
        RefreshValue;
      end
      else
        MsgBox(bbBonus.ErrorMsg, vbInformation + vbOKOnly);
    end
    else
      MsgBox(MSG_CRT_BONUS_ALREADY_UTILIZED, vbInformation + vbOKOnly);

    if not bbUsed then
      FInvoiceInfo.BonusBuckList.Remove(bbBonus);
  end;
end;

procedure TFrmParentSales.DeleteHold;
var
  i: Integer;
begin
  for i := 0 to Pred(FInvoiceInfo.BonusBuckList.Count) do
    TbonusBucks(FInvoiceInfo.BonusBuckList).UndoSetUsed(FInvoiceInfo.IDPreSale);

  DM.fPOS.DeleteHold(FInvoiceInfo.IDPreSale, DM.fUser.ID);
end;

function TFrmParentSales.EmptyHold: Boolean;
begin
  if not FInvoiceInfo.IsInvoice then
  begin
    with spquPreSaleItem do
    begin
      Close;
      Parameters.ParambyName('@DocumentID').Value := FInvoiceInfo.IDPreSale;
      Parameters.ParambyName('@IsPreSale').Value  := True;
      Parameters.ParambyName('@Date').Value       := Now;
      Open;
    end;
    Result := spquPreSaleItem.IsEmpty;
  end
  else
    Result := False;
end;

procedure TFrmParentSales.CreateHoldNumber;
begin
  if (not DM.fSystem.SrvParam[PARAM_SALECODE_ON_CREATE_SALE]) and (FInvoiceInfo.SaleCode = '') then
  begin
    FInvoiceInfo.SaleCode := DM.fPOS.CreateSaleCode(FInvoiceInfo.IDPreSale, 0, DM.fStore.ID);
    AfterCreateHoldNumber;
  end;
end;

procedure TFrmParentSales.AfterCreateHoldNumber;
begin
   //
end;

procedure TFrmParentSales.OnChangeUserClick(Sender: TObject);
begin
  if Password.PermanentLogOn then
    Password.PermanentLogOn := False;

  Password.Start(Password.MyMenuItem, Password.MySubMenuItem);
end;

procedure TFrmParentSales.OnHistoryClick(Sender: TObject);
begin
  with TFrmHistoryManage.Create(Self) do
    Start(FInvoiceInfo.IDPreSale);
end;

procedure TFrmParentSales.OnCommissionClick(Sender: TObject);
begin
  if not Password.HasFuncRight(63) then
  begin
    MsgBox(MSG_INF_NOT_MODIFY_COMMISSION, vbOKOnly + vbInformation);
    Exit;
  end;

  DM.fPOS.AddCommissionsList(spquPreSaleItemIDInventoryMov.AsInteger, FInvoiceInfo.PreSaleType);
  FFrmAddItemCommission.Start(1, FApplyCommissionToAll);

  ApplyCommission;
  DM.fPOS.ClearCommissionList;
  RefreshItem(0);
end;

procedure TFrmParentSales.OnExemptTaxClick(Sender: TObject);
begin
  with TFrmTaxIsent.Create(Self) do
    if Start(FInvoiceInfo.IDPreSale, quPreSaleInfo, (spquPreSaleValueSpecialPriceID.AsInteger > 0),
             not spquPreSaleValueTaxIsent.AsBoolean) then
    begin
      RefreshHold;
      RefreshValue;
      fInvoiceInfo.treatInvoiceTotals(spquPresaleValue);
      //PollDisplay
      DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                            Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                            spquPreSaleValueAditionalExpenses.AsCurrency,
                            spquPreSaleValueTotalDiscount.AsCurrency,
                            spquPreSaleValueTax.AsCurrency,
                            spquPreSaleValueSubTotal.AsCurrency,
                            True);
    end;
end;

procedure TFrmParentSales.OnSpecialPriceClick(Sender: TObject);
begin
  with TFrmMakeSpcPrice.Create(Self) do
    if Start(FInvoiceInfo.IDPreSale, spquPreSaleValueSpecialPriceID.AsInteger) then
      RefreshItem(0);
end;

procedure TFrmParentSales.ApplyTaxExemption;
begin

  if DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] then
  begin
    RefreshTaxControls;
    if (not spquPreSaleValueTaxIsent.AsBoolean) and (not FInvoiceInfo.IsInvoice) then
      SubApplyTaxExemption(True);
  end;
  
end;

procedure TFrmParentSales.RefreshTaxControls;
begin
  // para ser herdado
end;

procedure TFrmParentSales.CreateHold(IsLayway: Boolean = False);
var
  IDPreSale: Integer;
begin
  DM.FTraceControl.TraceIn('TFrmParentSales.CreateHold');

  try
    DM.fPOS.CreateHold(DELIVER_TYPE_ONHAND, IsLayway, DM.fStore.ID,
      '', '', '', 0, Now, 1, 20, 0, '', IDPreSale);

    FInvoiceInfo.IDPreSale       := IDPreSale;
    FInvoiceInfo.IsNewHold       := True;
    FInvoiceInfo.IDInvoice       := 0;
    FInvoiceInfo.Layaway         := IsLayway;
    FInvoiceInfo.FormOfPayment   := FORM_OF_PAYMENT_NOW;
    FInvoiceInfo.RefundDate      := 0;
    FInvoiceInfo.IDPreSaleRefund := 0;

    if DM.fSystem.SrvParam[PARAM_SALECODE_ON_CREATE_SALE] then
      DM.fPOS.CreateSaleCode(FInvoiceInfo.IDPreSale, 0, DM.fStore.ID);

    FInvoiceInfo.RefreshStatus;
    FInvoiceInfo.IncHold;

    if FApplyPromoOnSale then
    begin
      FFrmPromoControl.RefreshPromoList;
      FCoupon := '';
    end;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmParentSales');
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TFrmParentSales.RefreshHold;
begin
  RefreshInfo;
  RefreshItem(0);
end;

procedure TFrmParentSales.quPreSaleInfoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FInvoiceInfo.SaleCode := quPreSaleInfoSaleCode.AsString;
  FInvoiceInfo.Layaway  := quPreSaleInfoLayaway.AsBoolean;
end;

procedure TFrmParentSales.NewHold(IsLayway: Boolean = False);
begin
  CreateHold(IsLayway);
  RefreshHold;
  ApplyTaxExemption;
end;

procedure TFrmParentSales.OnSelectCustomer(Sender: TObject);
begin
{
  DM.fPOS.ApplyCustomerDiscount(FInvoiceInfo.IDPreSale,
    quPreSaleInfo.FieldByName('IDCustomer').AsInteger,
    quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime);
}
end;

procedure TFrmParentSales.AddSerialNumber(qty_typed: Integer; arg_idpreinvmov: Integer);
var
   viewDialogSerial: TfrmSerialDgView;
begin
    fQtyTyped := qty_typed;

    if ( spquPreSaleItem.IsEmpty ) then begin
       CalledSerialNumberScreen := false;
       exit;
    end;

    try
        case ( dm.fMRMercury.GiftProcessor ) of
             0: begin
                  viewDialogSerial := TfrmSerialDgView.Create(nil);
                  viewDialogSerial.Start('Enter serial Number ', 1, qty_typed,
                  spquPreSaleItemModelID.AsInteger, arg_idpreinvmov,
                  spquPreSaleItemSalePrice.Value, quPreSaleInfoIDPreSale.Value);
                  freeAndNil(viewDialogSerial);
             end;
             1: begin
                if ( application.MessageBox('Is Mercury Gift Card ?', 'Card', mb_YESNO + mb_IconQuestion )= idYes ) then begin
                    dealCardSerialNumber();
                end
                else begin
                   viewDialogSerial := TfrmSerialDgView.Create(nil);
                   viewDialogSerial.Start('Enter serial Number ', 1, qty_typed,
                   spquPreSaleItemModelID.AsInteger, arg_idpreinvmov,
                   spquPreSaleItemSalePrice.AsFloat, quPreSaleInfoIDPreSale.Value);
                   freeAndNil(viewDialogSerial);
                end;
             end;

             2: begin
                    dealCardSerialNumber();
             end;

        end;
    except on  E:Exception do begin
          raise Exception.Create('Exception in method AddSerialNumber. ' + e.Message);
          end;
    end;
end;

procedure TFrmParentSales.RemoveHoldItem;
var
  iError, iIDInvMov: Integer;
  sMsg: String;
begin
  iIDInvMov := spquPreSaleItemIDInventoryMov.AsInteger;
  DM.fPOS.DeleteHoldItem(FInvoiceInfo.IDPreSale,
                         iIDInvMov,
                         spquPreSaleItemModelID.AsInteger,
                         DM.fUser.ID,
                         spquPreSaleItemQty.AsFloat,
                         spquPreSaleItemDiscount.AsFloat,
                         spquPreSaleItemSalePrice.AsFloat,
                         False, False, Password.HasFuncRight(9), Now, iError);

  if iError <> 0  then
  begin
    if (Password.HasFuncRight(9)) then
      sMsg := MSG_QST_DISCOUNT_REACHED
    else
      sMsg := MSG_QST_ERASE_ALL_DISCOUNT;

    if MsgBox(sMsg, vbYesNo + vbQuestion) = vbYes then
      DM.fPOS.DeleteHoldItem(FInvoiceInfo.IDPreSale,
                             iIDInvMov,
                             spquPreSaleItemModelID.AsInteger,
                             DM.fUser.ID,
                             spquPreSaleItemQty.AsFloat,
                             spquPreSaleItemDiscount.AsFloat,
                             spquPreSaleItemSalePrice.AsFloat,
                             (not Password.HasFuncRight(9)),
                             Password.HasFuncRight(9), Password.HasFuncRight(9), Now, iError);
  end;

  dm.deleteSalAccountCardByPreInvMov(iIDInvMov);

  RefreshItem(0);

  //Poll Display
  DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                        Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                        spquPreSaleValueAditionalExpenses.AsCurrency,
                        spquPreSaleValueTotalDiscount.AsCurrency,
                        spquPreSaleValueTax.AsCurrency,
                        spquPreSaleValueSubTotal.AsCurrency);
  
  DM.PollDisplayDeleteItem(iIDInvMov);

  UpdatePuppyTrackerInfo;
  
end;

procedure TFrmParentSales.ClearHoldItems;
begin
  with spquPreSaleItem do
    while not IsEmpty do
    begin
      Last;
      RemoveHoldItem;
      Prior;
    end;
end;

procedure TFrmParentSales.OnCancelClick(Sender: TObject);
begin
  if EmptyHold then begin
    Close
  end else begin
        CloseHold;
        NewHold;
      end;

end;

procedure TFrmParentSales.ApplyCommission;
var
  i: Integer;
begin
  if DM.fPOS.FCommisList.Count > 0 then
    if FApplyCommissionToAll then
    begin
      if not Assigned(DM.fPOS.FDefaultSalesPerson) then
        DM.fPOS.FDefaultSalesPerson := TStringList.Create;

      DM.fPOS.FDefaultSalesPerson.Assign(DM.fPOS.fCommisList);  

      spquPreSaleItem.First;
      while not spquPreSaleItem.Eof do
      begin
        DM.fPOS.AddSaleItemCommission(spquPreSaleItemIDInventoryMov.AsInteger, FInvoiceInfo.PreSaleType);
        spquPreSaleItem.Next;
      end;
    end
    else
      DM.fPOS.AddSaleItemCommission(spquPreSaleItemIDInventoryMov.AsInteger, FInvoiceInfo.PreSaleType);
end;

function TFrmParentSales.GetModelDepartment(IDModel: Integer): Integer;
begin
  with DM.quFreeSQL do
   begin
     if Active then
      Close;
     SQL.Clear;

     SQL.Text := ' SELECT IDDepartment FROM Inv_ModelDepartment ' +
                 ' WHERE ModelID = ' + InttoStr(IDModel) + ' AND StoreID = ' + InttoStr(DM.fStore.IDStoreSale) ;
     Open;

     if IsEmpty then
     begin
       if Active then
         Close;

       SQL.Clear;

       SQL.Text := ' SELECT T.IDDepartment FROM Model M JOIN TabGroup T ON (T.IDGroup = M.GroupID) ' +
                   ' WHERE M.IDModel = ' + InttoStr(IDModel);
       Open;

       Result := FieldByName('IDDepartment').AsInteger;
     end
     else
      with TSelectDepartment.Create(self) do
       Start(IDModel, Result);
   end;
end;

procedure TFrmParentSales.AfterRefreshInfo;
begin
  //Herdado
end;

procedure TFrmParentSales.SetDefaultSalesPerson;
begin
  FFrmAddItemCommission.Start(3, FApplyCommissionToAll);

  if DM.fPOS.fCommisList.Count > 0 then
  begin
    if not Assigned(DM.fPOS.FDefaultSalesPerson) then
      DM.fPOS.FDefaultSalesPerson := TStringList.Create;

    DM.fPOS.FDefaultSalesPerson.Assign(DM.fPOS.fCommisList);

    DM.fPOS.ClearCommissionList;
  end;
end;

function TFrmParentSales.SaleNeedCustomer: Boolean;
begin
  Result := False;
  
  if spquPreSaleItem.Locate('RequestCustomer',True,[]) then
    Result := True;
end;

function TFrmParentSales.ApplyPromoOnPrizeItems: Boolean;
var
  bEmpty: Boolean;
  iSaleItem :TSaleItem;
  OldIDPreInventoryMov, i, iError : Integer;
  QtyPrizeItem : Double;
  PrizeItemSellingPrice : Currency;
begin
  iSaleItem := TSaleItem.Create;
  Result := False;

  with spquPreSaleItem do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if not spquPreSaleItem.FieldByName('Promo').AsBoolean then
      begin
        iSaleItem.IDPreSale            := FInvoiceInfo.IDPreSale;
        iSaleItem.IDPreInventoryMov    := spquPreSaleItem.FieldByName('IDInventoryMov').AsInteger;
        iSaleItem.IDUser               := FieldByName('IDUser').AsInteger;
        iSaleItem.PreSaleDate          := quPreSaleInfoPreSaleDate.AsDateTime;
        iSaleItem.Department           := FieldByName('IDDepartment').AsInteger;
        iSaleItem.IDCommission         := DM.fUser.IDCommission;
        iSaleItem.IDModel              := spquPreSaleItem.FieldByName('ModelID').AsInteger;
        iSaleItem.Qty                  := FieldByName('Qty').AsFloat;
        iSaleItem.SellingPrice         := FieldByName('SalePrice').AsCurrency;
        iSaleItem.CostPrice            := FieldByName('CostPrice').AsCurrency;
        iSaleItem.Discount             := 0;
        iSaleItem.CustomerSellingPrice := iSaleItem.SellingPrice;
        iSaleItem.KitSellingPrice      := iSaleItem.SellingPrice;
        iSaleItem.PromoSellingPrice   := 0;


        if FFrmPromoControl.IsPrizeItem(iSaleItem.IDModel) then
        begin
          if iSaleItem.Qty <= 1 then
          begin
            if FFrmPromoControl.ApplyPromoPrizeItem(iSaleItem) then
            begin
              Result := True;
              iSaleItem.Update;
              RefreshItem(iSaleItem.IDPreInventoryMov);
              First;
            end;
          end
          else
          begin
            Result := True;
            OldIDPreInventoryMov := iSaleItem.IDPreInventoryMov;
            QtyPrizeItem := iSaleItem.Qty;
            PrizeItemSellingPrice := iSaleItem.SellingPrice;

            for i := 0 to Pred(Trunc(QtyPrizeItem)) do
            begin
              if i = Pred(Trunc(QtyPrizeItem)) then
              begin
                iSaleItem.Qty := 1 + Frac(QtyPrizeItem);
                iSaleItem.SellingPrice := (PrizeItemSellingPrice * iSaleItem.Qty);
                iSaleItem.PromoSellingPrice := 0;
                iSaleItem.Promo := False;
              end
              else
              begin
                iSaleItem.Qty := 1;
                iSaleItem.SellingPrice := PrizeItemSellingPrice;
                iSaleItem.PromoSellingPrice := 0;
                iSaleItem.Promo := False;
                iSaleItem.IDCommission := DM.fUser.IDCommission;
              end;

              FFrmPromoControl.ApplyPromoPrizeItem(iSaleItem);
              iSaleItem.Add;
            end;

            DM.fPOS.DeleteHoldItem(iSaleItem.IDPreSale,
                                   OldIDPreInventoryMov,
                                   iSaleItem.IDModel,
                                   DM.fUser.ID,
                                   QtyPrizeItem ,
                                   0,
                                   PrizeItemSellingPrice,
                                   False, True, Password.HasFuncRight(9), Now, iError);

            RefreshItem(iSaleItem.IDPreInventoryMov);
            First;
          end;
        end
        else
          Next;
      end
      else
        Next;
    end;
    First;

  finally
    FreeAndNil(iSaleItem);
    EnableControls;
  end;
end;

function TFrmParentSales.ApplyPromoOnPromoItems: Boolean;
var
  bEmpty: Boolean;
  iSaleItem :TSaleItem;
  DiscountSaleValue : Double;
begin
  iSaleItem := TSaleItem.Create;
  Result := False;

  with spquPreSaleItem do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      if not spquPreSaleItem.FieldByName('Promo').AsBoolean then
      begin
        iSaleItem.IDPreSale         := FInvoiceInfo.IDPreSale;
        iSaleItem.IDPreInventoryMov := spquPreSaleItem.FieldByName('IDInventoryMov').AsInteger;
        iSaleItem.IDUser            := FieldByName('IDUser').AsInteger;
        iSaleItem.PreSaleDate       := quPreSaleInfoPreSaleDate.AsDateTime;
        iSaleItem.Department        := FieldByName('IDDepartment').AsInteger;
        iSaleItem.IDCommission      := DM.fUser.IDCommission;
        iSaleItem.IDModel           := spquPreSaleItem.FieldByName('ModelID').AsInteger;
        iSaleItem.Qty               := FieldByName('Qty').AsFloat;
        iSaleItem.SellingPrice      := FieldByName('SalePrice').AsCurrency;
        iSaleItem.CostPrice         := FieldByName('CostPrice').AsCurrency;
        iSaleItem.Discount          := 0;
        iSaleItem.Promo             := False;
        iSaleItem.CustomerSellingPrice := iSaleItem.SellingPrice;
        iSaleItem.KitSellingPrice      := iSaleItem.SellingPrice;
        iSaleItem.PromoSellingPrice    := 0;

        if not FFrmPromoControl.IsPrizeItem(iSaleItem.IDModel) then
          FFrmPromoControl.ApplyPromo(iSaleItem, quPreSaleInfoIDCustomer.AsInteger, FCoupon, DiscountSaleValue);

        if iSaleItem.Promo then
          iSaleItem.Update
        else
          FFrmPromoControl.SetParentSaleItem(iSaleItem);

        if DiscountSaleValue <> 0 then
          iSaleItem.SetDiscountItem(iSaleItem, DiscountSaleValue, DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE]);

        Result := True;
      end;
    Next;
    end;
    First;
  finally
    FreeAndNil(iSaleItem);
    EnableControls;
  end;
end;

procedure TFrmParentSales.ApplyPromoOnAllItems;
begin
  if (spquPreSaleItem.Active) and (spquPreSaleItem.RecordCount > 0) then
  begin
   if ApplyPromoOnPromoItems then
     RefreshItem(0);
   if ApplyPromoOnPrizeItems then
     RefreshItem(0);
  end;
end;

function TFrmParentSales.BonusUtilized(AIDPreSale, AIndex: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to Pred(FInvoiceInfo.BonusBuckList.Count) do
    if (TBonusBucks(FInvoiceInfo.BonusBuckList[i]).IDPreSaleCreated = AIDPreSale) and
       (i <> AIndex) then
      Result := True;
end;

function TFrmParentSales.TestBeforeAdd: Boolean;
begin

  Result := False;

  if (FInvoiceInfo.Layaway) and (DM.fSystem.SrvParam[PARAM_LIMIT_LAYAWAY_ON_MONTH]) and
     (not TestMonth(quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime, Now)) then
  begin
     MsgBox(MSG_INF_NOT_MODIFY_LAYAWAY, vbOKOnly + vbInformation);
     Exit;
  end;

  Result := True;

end;

function TFrmParentSales.TestBeforeDetail: Boolean;
begin

  Result := False;

  if (not spquPreSaleItem.Active) or (spquPreSaleItem.IsEmpty) then
    Exit;

  if (FInvoiceInfo.Layaway) and (DM.fSystem.SrvParam[PARAM_LIMIT_LAYAWAY_ON_MONTH]) and
     (not TestMonth(quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime, Now)) then
  begin
     MsgBox(MSG_INF_NOT_MODIFY_LAYAWAY, vbOKOnly + vbInformation);
     Exit;
  end;

  Result := True;

end;

function TFrmParentSales.TestBeforeRemove: Boolean;
begin

  Result := False;

  if (not spquPreSaleItem.Active) or (spquPreSaleItem.IsEmpty) then
    Exit;

  //Verificar se pode deletar item do pedido.
  if (not Password.HasFuncRight(66)) then
    begin
      MsgBox(MSG_INF_NOT_DEL_ITEMS_SALE, vbOKOnly + vbInformation);
      Exit;
    end;

  if (FInvoiceInfo.Layaway) and (DM.fSystem.SrvParam[PARAM_LIMIT_LAYAWAY_ON_MONTH]) and
     (not TestMonth(quPreSaleInfo.FieldByName('PreSaleDate').AsDateTime, Now)) then
  begin
     MsgBox(MSG_INF_NOT_MODIFY_LAYAWAY, vbOKOnly + vbInformation);
     Exit;
  end;

  Result := True;

end;


function TFrmParentSales.ExemptCustomerTax(IDCustomer: Integer): Boolean;
var
  quCustomerTax : TADOQuery;
begin
  Result := False;

  quCustomerTax := TADOQuery.Create(Self);
  try
    with quCustomerTax do
    try
      Connection := DM.ADODBConnect;
      SQl.Add('SELECT SalesTaxExempt FROM Pessoa WHERE IDPessoa = ' + IntToStr(IDCustomer));
      Open;
      Result := FieldByName('SalesTaxExempt').AsBoolean;
    finally
      Close;
      end;
  finally
    FreeAndNil(quCustomerTax);
    end;

end;

procedure TFrmParentSales.UndoTaxExemption;
begin
  DM.fPOS.RecalcTax(FInvoiceInfo.IDPreSale, Now);
end;

procedure TFrmParentSales.SubApplyTaxExemption(Exempt : Boolean);
begin
  DM.fPOS.ExemptTax(FInvoiceInfo.IDPreSale, Exempt);
end;

procedure TFrmParentSales.UpdatePuppyTrackerInfo;
begin
  if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
     (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
  begin
    quPreSaleInfo.Edit;
    quPreSaleInfoPuppyTracker.AsBoolean := DM.SaleHavePuppyTrackerItem(FInvoiceInfo.IDPreSale);
  end;
end;

procedure TFrmParentSales.setNeedSwip(const Value: Boolean);
begin
  FNeedSwip := value;
end;

procedure TFrmParentSales.NeedSwipe(Sender: TObject;
  var SwipedTrack: WideString; var Canceled: Boolean);
var
   viewDialogCard: TCardNumberDlgView;
  iIDMeioPag : Integer;
begin

  viewDialogCard := TCardNumberDlgView.Create(Self);
  viewDialogCard.setMercuryObject(mercuryGiftCard);

  try
    try
      Canceled := not viewDialogCard.Start(SwipedTrack, iIDMeioPag, 'Swipe Card ', fCountCard, fQtyTyped,
                   spquPreSaleItemModelID.AsInteger, spquPreSaleItemIDInventoryMov.AsInteger,
                   spquPreSaleItemSalePrice.AsFloat, quPreSaleInfoIDPreSale.Value );
    except
      on E: Exception do
      begin
        raise Exception.Create('Swiped Card Exception: ' + e.message);
        DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TPreSaleReceive');
      end;
    end;
  finally
     freeAndNil(viewDialogCard);
  end;
end;

function TFrmParentSales.dealCardSerialNumber: Boolean;
var
  cancelAll: Boolean;
  msgBox: String;
  passed: Boolean;
  balanceToBeAdded: double;
  reachedFirstStep: boolean;

begin
   FcountCard:= 1;
   balanceToBeAdded := 0;

   // Antonio, August 05, 2013
   mercuryGiftCard.MercuryErrorsCode := dm.fMRMercury.MercuryErrorsCode;
   mercuryGiftCard.OperatorID := intToStr(dm.fUser.ID);
   mercuryGiftCard.InvoiceNo  := IntToStr(quPreSaleInfoIDPreSale.Value);
   mercuryGiftCard.RefNo 	   := IntToStr(quPreSaleInfoIDPreSale.Value);
   mercuryGiftCard.Purchase   := spquPreSaleItemSalePrice.Value; // balance
   mercuryGiftCard.Memo       := 'MainRetail ' + dm.fSystem.VerBuild;

   // Antonio 09/11/2015 - to instantiate according to processor and device ( referenced object: fCreditX )
   mercuryGiftCard.setPrepaidDevice(dm.fMRMercury.Processor, dm.fMRMercury.DeviceProcess);

   cancelAll := false;

   repeat
         try
            passed := false;

            mercuryGiftCard.fCreditX.OnNeedSwipe := NeedSwipe;
            mercuryGiftCard.fCreditX.FCardSwiped := '';

            reachedFirstStep := false;

            repeat
                  case mercuryGiftCard.tryBalanceCard(spquPreSaleItemSalePrice.Value) of
                       ttrNotSuccessfull: begin
                           passed := true;
                           reachedFirstStep := false;
                       end;

                       ttrSuccessfull: begin
                           writeSerialNumber(mercuryGiftCard.AcctNo, 1);
                           reachedFirstStep := true;
                           break;
                       end;

                  end;

                  if ( not reachedFirstStep ) then begin
                      // Antonio, 2013 October 19 - to avoid to call prompt twice (MR-67)
                      mercuryGiftCard.OnNeedSwipe := nil;
                      writeSerialNumber(mercuryGiftCard.AcctNo, 0);
                  end;


            until ( (passed) or (mercuryGiftCard.TransactionReturn = ttrError) );

         except on e: Exception do begin
             dm.fMRMercury.qtyToRemove := dm.fMRMercury.QtyToRemove + 1;
             //raise Exception.create(e.Message + ' Item will be removed from the cash register.');
             end;
         end;

         inc(FcountCard);

   until ( (FcountCard > fQtyTyped) or (cancelAll) );

   mercuryGiftCard.cleanupCardNumberList;
   
end;

function TFrmParentSales.ViewSerialHistory: Boolean;
var
   viewSerialHistory: TviewSerialNumberHistory;
begin
   viewSerialHistory := TviewSerialNumberHistory.Create(self);
   viewSerialHistory.start(spquPreSaleItemIDInventoryMov.AsInteger);
end;

procedure TFrmParentSales.setSaveQtyToPriceBreak(const Value: Double);
begin
  fSaveQtyToPriceBreak := Value;
end;


procedure TFrmParentSales.writeSerialNumber(serial_number: String; arg_issued: Byte);
var
  objSerialNumber: TSerialNumberFromPreSale;
  serialNumber: String;
  accountCard: TClientDataset;

begin
   try
      try
         objSerialNumber := TSerialNumberFromPreSale.Create(spquPreSaleItemModelID.Value, dm.fStore.ID, spquPreSaleItemIDInventoryMov.Value, 0);

         // Antonio, August 06, 2013
         objSerialNumber.IsGiftCard := true;
         objSerialNumber.IsIssued	:= arg_issued;

         objSerialNumber.Connection := dm.ADODBConnect;
         objSerialNumber.Add(spquPreSaleItemIDInventoryMov.Value, serial_number, '', '0');
      except
         on e: Exception do begin
            raise Exception.Create('Error found when tried add serial number: ' + e.Message);
         end;
      end;
   finally
      freeAndNil(objSerialNumber);
      freeAndNil(accountCard);
   end;
end;

end.
