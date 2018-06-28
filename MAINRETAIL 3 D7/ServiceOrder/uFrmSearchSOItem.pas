unit uFrmSearchSOItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, Buttons,
  Mask, SuperComboADO, SuperEdit, SuperEditCurrency, SubListPanel, DB,
  ADODB, uFrmBarcodeSearch;

type
  TFrmSearchSOItem = class(TDialogParent)
    Label4: TLabel;
    cmbModel: TSuperComboADO;
    btnPicture: TSpeedButton;
    lbQty: TLabel;
    EditQty: TEdit;
    Label2: TLabel;
    EditSalePrice: TSuperEditCurrency;
    lbTotal: TLabel;
    EditTotal: TSuperEdit;
    SubQty: TSubListPanel;
    spSalePrice: TADOStoredProc;
    cdmAddItem: TADOCommand;
    lbCategory: TLabel;
    scCategoria: TSuperComboADO;
    lbSearch: TLabel;
    rbServices: TRadioButton;
    rbProducts: TRadioButton;
    cmdAddInvMov: TADOCommand;
    btnSearchDesc: TBitBtn;
    lbComissionado: TLabel;
    scMRUser: TSuperComboADO;
    procedure FormCreate(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
    procedure cmbModelSelectItem(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
    procedure EditQtyKeyPress(Sender: TObject; var Key: Char);
    procedure EditSalePriceEnter(Sender: TObject);
    procedure EditSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure EditSalePriceClick(Sender: TObject);
    procedure EditSalePriceCurrChange(Sender: TObject);
    procedure EditQtyChange(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure scCategoriaSelectItem(Sender: TObject);
    procedure rbServicesClick(Sender: TObject);
    procedure rbProductsClick(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FResult : Boolean;
    FIDSOItem, FIDCustomer, FIDUser : Integer;
    FSalePrice, FCostPrice, FOriginalSalePrice,
    FAvgCost, FCustomerDiscount : Currency;
    fOnHand, fOnPreSale, fOnPrePurchase, fOnAvailable : Double;
    FAddKitItems : Boolean;
    fFrmBarcodeSearch : TFrmBarcodeSearch;
    procedure RefreshQty;
    procedure SelectModel;
    procedure RefreshType;

    function ValidadateFields : Boolean;
    procedure ValidateWarning;
    function InsertItem : Boolean;
  public
    function Start(AIDSOItem, AIDCustomer, AIDUser : Integer):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uFrmModelPicture, uNumericFunctions, uMsgConstant, uMsgBox,
     uSystemConst, uCharFunctions, uPassword;

{$R *.dfm}

{ TFrmSearchSOItem }

function TFrmSearchSOItem.Start(AIDSOItem, AIDCustomer, AIDUser : Integer): Boolean;
begin
  FIDSOItem   := AIDSOItem;
  FIDCustomer := AIDCustomer;
  FIDUser     := AIDUser;
  scCategoria.LookUpValue := DM.fCashRegister.DefaulServOrderCat;

  if scMRUser.LookUpValue = '' then
    scMRUser.LookUpValue := IntToStr(AIDUser);

  RefreshType;

  FResult := False;

  ShowModal;

  Result := FResult;
  
end;

procedure TFrmSearchSOItem.FormCreate(Sender: TObject);
begin
  inherited;

  DM.imgSmall.GetBitmap(BTN18_CAMERA, btnPicture.Glyph);
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);

  fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);
    
  SubQty.CreateSubList;

end;

procedure TFrmSearchSOItem.btnPictureClick(Sender: TObject);
begin
  inherited;
  if cmbModel.LookUpValue <> '' then
    with TFrmModelPicture.Create(Self) do
      Start(cmbModel.LookUpValue);
end;

procedure TFrmSearchSOItem.RefreshQty;
begin
  if cmbModel.LookUpValue <> '' then
  begin
    SubQty.Param := 'IDModel='+cmbModel.LookUpValue+';';
    DM.fPOS.GetQty(StrToInt(cmbModel.LookUpValue), DM.fStore.IDStoreSale, fOnHand, fOnPreSale, fOnPrePurchase, fOnAvailable);
  end;
end;

procedure TFrmSearchSOItem.cmbModelSelectItem(Sender: TObject);
begin
  inherited;
  SelectModel;
end;

procedure TFrmSearchSOItem.SelectModel;
var
  cCostValue, cStoreCost, cStoreAvg, cStoreSell, cPromotionPrice: Currency;
begin

  if cmbModel.LookUpValue = '' then
    Exit;

  RefreshQty;

  FCustomerDiscount := 0;


  with spSalePrice do
  begin
    Parameters.ParambyName('@ModelID').Value        := StrToInt(cmbModel.LookUpValue);
    Parameters.ParambyName('@IDStore').Value        := DM.fStore.ID;
    Parameters.ParambyName('@IDCustomer').Value     := FIDCustomer;
    Parameters.ParambyName('@Discount').Value       := FCustomerDiscount;
    Parameters.ParambyName('@SpecialPriceID').Value := 0;
    ExecProc;

    cStoreCost        := Parameters.ParambyName('@StoreCostPrice').Value;
    cStoreSell        := Parameters.ParambyName('@StoreSalePrice').Value;
    cStoreAvg         := Parameters.ParambyName('@StoreAvgCost').Value;
    FCustomerDiscount := Parameters.ParambyName('@Discount').Value;
    FAddKitItems      := Parameters.ParambyName('@AddKitItems').Value;
    cPromotionPrice   := Parameters.ParambyName('@PromotionPrice').Value;

    if DM.fStore.Franchase then
      FSalePrice := cStoreSell
    else
    begin
      if (cStoreSell <> 0) then
        FSalePrice := cStoreSell
      else
        FSalePrice := Parameters.ParambyName('@SalePrice').Value;
    end;

    FOriginalSalePrice := FSalePrice;

    // Seta o valor do sale price
    try
      if  (cPromotionPrice < (FSalePrice - FCustomerDiscount)) and (cPromotionPrice <> 0) then
              EditSalePrice.Text := MyFloatToStr(cPromotionPrice)
            else
            EditSalePrice.Text := MyFloatToStr(FSalePrice - FCustomerDiscount);
    finally
    end;

    if DM.fStore.Franchase then
    begin
      FCostPrice := cStoreCost;
      if cStoreAvg = 0 then
        FAvgCost := cStoreCost
      else
        FAvgCost := cStoreAvg;
    end
    else
    begin
      //utilizado para salvar o custo futuro
      if DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
        FCostPrice := Parameters.ParambyName('@ReplacementCost').Value
      else
        FCostPrice := Parameters.ParambyName('@CostPrice').Value;

      FAvgCost := Parameters.ParambyName('@AvgCostPrice').Value;
    end;
  end;

end;

procedure TFrmSearchSOItem.RefreshType;
begin
  EditQty.Text            := '1';
  cmbModel.LookUpValue    := '';
  EditSalePrice.Text      := '0.00';
  EditTotal.Text          := '';
  lbCategory.Visible      := False;
  scCategoria.Visible     := False;
  cmbModel.SpcWhereClause := '';

  if rbServices.Checked then
  begin
    cmbModel.LookUpSource := DM.dsLookUpModelService;
    EditQty.Visible       := False;
    EditTotal.Visible     := False;
    lbQty.Visible         := False;
    lbTotal.Visible       := False;
  end
  else
  begin
    cmbModel.LookUpSource := DM.dsLookUpModelPack;
    lbCategory.Visible    := True;
    scCategoria.Visible   := True;
    EditQty.Visible       := True;
    EditTotal.Visible     := True;
    lbQty.Visible         := True;
    lbTotal.Visible       := True;
    if scCategoria.LookUpValue <> '' then
      cmbModel.SpcWhereClause := 'GroupID = ' + scCategoria.LookUpValue;
  end;
end;

procedure TFrmSearchSOItem.AplicarClick(Sender: TObject);
begin
  inherited;
  if ValidadateFields then
  begin
    FResult := InsertItem;
    ValidateWarning;
    ModalResult := mrNone;
    RefreshType;
    if cmbModel.Visible then
      cmbModel.SetFocus;
  end
  else
  begin
    ModalResult := mrNone;
    FResult := False;
  end;
end;

function TFrmSearchSOItem.InsertItem: Boolean;
var
  iID : Integer;
begin

  try
    DM.ADODBConnect.BeginTrans;

    iID := DM.GetNextID('Ser_SOItemProduct.IDSOItemProduct');

    with cdmAddItem do
    begin
      Parameters.ParamByName('IDSOItemProduct').Value := iID;
      Parameters.ParamByName('IDUser').Value          := FIDUser;
      Parameters.ParamByName('IDSOItem').Value        := FIDSOItem;
      Parameters.ParamByName('IDModel').Value         := StrToInt(cmbModel.LookUpValue);
      Parameters.ParamByName('IDStore').Value         := DM.fStore.ID;
      Parameters.ParamByName('Qty').Value             := MyStrToDouble(EditQty.Text);
      Parameters.ParamByName('CostPrice').Value       := FCostPrice;
      Parameters.ParamByName('SalePrice').Value       := FSalePrice;
      Parameters.ParamByName('MovDate').Value         := Now;
      Parameters.ParamByName('IDCustomer').Value      := FIDCustomer;
      Execute;
    end;

    with cmdAddInvMov do
    begin
      Parameters.ParamByName('IDInventoryMov').Value  := DM.GetNextID(MR_INVENTORY_MOV_ID);
      Parameters.ParamByName('InventMovTypeID').Value := 50;
      Parameters.ParamByName('DocumentID').Value      := iID;
      Parameters.ParamByName('StoreID').Value         := DM.fStore.ID;
      Parameters.ParamByName('ModelID').Value         := StrToInt(cmbModel.LookUpValue);
      Parameters.ParamByName('MovDate').Value         := Now;
      Parameters.ParamByName('Qty').Value             := MyStrToDouble(EditQty.Text);
      Parameters.ParamByName('CostPrice').Value       := FCostPrice;
      Parameters.ParamByName('SalePrice').Value       := FSalePrice;
      Parameters.ParamByName('Discount').Value        := 0;
      Parameters.ParamByName('IDUser').Value          := StrToIntDef(scMRUser.LookUpValue, FIDUser);
      Parameters.ParamByName('IDDepartment').Value    := 0;
      Parameters.ParamByName('IDPessoa').Value        := FIDCustomer;
      Execute;
    end;

    DM.ADODBConnect.CommitTrans;
    Result := True;
  except
    on E: Exception do
    begin
      DM.ADODBConnect.RollbackTrans;
      Result := False;
      ShowMessage(E.Message);
    end;

  end;

end;

function TFrmSearchSOItem.ValidadateFields: Boolean;
begin

  Result := False;

  if scMRUser.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_SELECT_USER, vbOkOnly + vbCritical);
    scMRUser.SetFocus;
    Exit;
  end;

  if cmbModel.LookUpValue = '' then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbOkOnly + vbCritical);
    cmbModel.SetFocus;
    Exit;
  end;

  if MyStrToDouble(EditQty.Text) < 0 then
  begin
    MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbOkOnly + vbCritical);
    EditQty.SetFocus;
    Exit;
  end;

  Result := True;
  
end;

procedure TFrmSearchSOItem.EditQtyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateDouble(Key);
end;

procedure TFrmSearchSOItem.EditSalePriceEnter(Sender: TObject);
begin
  inherited;
  EditSalePrice.SelectAll;
end;

procedure TFrmSearchSOItem.EditSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmSearchSOItem.EditSalePriceClick(Sender: TObject);
begin
  inherited;
  EditSalePrice.SelectAll;
end;

procedure TFrmSearchSOItem.EditSalePriceCurrChange(Sender: TObject);
var
   Code  : Integer;
begin
  inherited;

  try
    FSalePrice := MyStrToMoney(EditSalePrice.Text);
    EditTotal.Text := MyFloatToStr(TruncMoney(FSalePrice * MyStrToFloat(EditQty.Text), 2));
  finally
  end;

end;

procedure TFrmSearchSOItem.EditQtyChange(Sender: TObject);
var
  IsKit, bEmpty: Boolean;
begin
  inherited;

  if Trim(EditQty.Text) = '-' then
    Exit;

  FSalePrice := DM.fPOS.GetKitPrice(StrToIntDef(cmbModel.LookUpValue, 0), MyStrToDouble(EditQty.Text), FOriginalSalePrice, bEmpty);

  FOriginalSalePrice := FSalePrice;

  if (not bEmpty) then
  begin
    try
      EditSalePrice.Text := MyFloatToStr(FSalePrice - FCustomerDiscount);
    finally
    end;
  end
  else if FSalePrice <> MyStrToMoney(EditSalePrice.Text) then
    FSalePrice := MyStrToMoney(EditSalePrice.Text);

  try
    EditTotal.Text := MyFloatToStr(TruncMoney(MyStrToFloat(EditQty.Text) * MyStrToMoney(EditSalePrice.Text), 2));
  finally
  end;

end;

procedure TFrmSearchSOItem.CancelarClick(Sender: TObject);
begin
  inherited;
  FResult := True;
  Close;
end;

procedure TFrmSearchSOItem.scCategoriaSelectItem(Sender: TObject);
begin
  inherited;
  if scCategoria.LookUpValue <> '' then
    cmbModel.SpcWhereClause := 'GroupID = ' + scCategoria.LookUpValue
  else
    cmbModel.SpcWhereClause := '';
end;

procedure TFrmSearchSOItem.rbServicesClick(Sender: TObject);
begin
  inherited;
  RefreshType;
end;

procedure TFrmSearchSOItem.rbProductsClick(Sender: TObject);
begin
  inherited;
  RefreshType;
end;

procedure TFrmSearchSOItem.ValidateWarning;
var
  fQtyTest : Double;
begin

  if not rbServices.Checked then
  begin
    fQtyTest := fOnAvailable;

    if DM.fSystem.SrvParam[PARAM_INCLUDEPREPURCHASE] then
      fQtyTest := fQtyTest + fOnPrePurchase;

    if (fQtyTest - MyStrToDouble(EditQty.Text)) <= 0 then
      MsgBox(MSG_CRT_INVENTORY_IS_ZERO, vbOKOnly + vbInformation);
  end;


end;

procedure TFrmSearchSOItem.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;

  with fFrmBarcodeSearch do
    begin
      R := Start;
      if R <> -1 then
        begin
          cmbModel.LookUpValue := IntToStr(R);
          cmbModelSelectItem(Self);
        end;
    end;

end;

procedure TFrmSearchSOItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fFrmBarcodeSearch);
end;

end.
