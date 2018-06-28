unit uSaleItem;

interface

uses SysUtils;

type
  TSaleItem = class
  private
    FDiscount: Currency;
    FCostPrice: Currency;
    FSellingPrice: Currency;
    FQty: Double;
    FIDCommission: Integer;
    FIDCustomer: Integer;
    FIDModel: Integer;
    FIDStore: Integer;
    FIDUser: Integer;
    FIDPreSale: Integer;
    FIDPreInventoryMovParent: Integer;
    FIDItemExchange: Integer;
    FPreSaleDate: TDateTime;
    FIDPreInventoryMov: Integer;
    FExchange: Boolean;
    FIDInvoiceExchange: Integer;
    FDepartment: Integer;
    FPromo: Boolean;
    FKitSellingPrice : Currency;
    FCustomerSellingPrice : Currency;
    FPromoSellingPrice : Currency;
    FIsManager : Boolean;
    FAskedSalePrice: Boolean;
    FSuggPrice: Currency;
    FIDVendorPrice: Integer;
    FIDDescriptionPrice: Integer;
    FIDDocumentType: Integer;
    FDocumentNumber: String;
    FBarcode: String;

    // Antonio Apr 2014 03 - new fields to sp addItem
    FManualPrice: Currency;
    FManualDiscount: Currency;
    FIDSpecialPrice: Integer;
    FIsManualPrice: Boolean;
    FIsManualDiscount: Boolean;
    FEachDiscount: currency;

    procedure OnBeforeAdd;
    procedure UpdateParentPromo(IDPreInventoryMovParent: Integer);
    procedure OnBeforeUpdate;
    procedure ApplyDiscount;
  public
    procedure CleanUpValues();
    procedure Add;
    procedure Update;
    procedure Remove;
    procedure SetDiscountItem(SaleItem: TSaleItem; DiscountSaleValue: Double; TaxExemptOnSale: Boolean);
    property IDPreInventoryMov: Integer read FIDPreInventoryMov write FIDPreInventoryMov;
    property IDCustomer: Integer read FIDCustomer write FIDCustomer;
    property IDPreSale: Integer read FIDPreSale write FIDPreSale;
    property IDPreInventoryMovParent: Integer read FIDPreInventoryMovParent write FIDPreInventoryMovParent;
    property IDInvoiceExchange: Integer read FIDInvoiceExchange write FIDInvoiceExchange;
    property IDModel: Integer read FIDModel write FIDModel;
    property IDStore: Integer read FIDStore write FIDStore;
    property Qty: Double read FQty write FQty;
    property Discount: Currency read FDiscount write FDiscount;
    property SellingPrice: Currency read FSellingPrice write FSellingPrice;
    property CostPrice: Currency read FCostPrice write FCostPrice;
    property IDUser: Integer read FIDUser write FIDUser;
    property IDCommission: Integer read FIDCommission write FIDCommission;
    property PreSaleDate: TDateTime read FPreSaleDate write FPreSaleDate;
    property IDItemExchange: Integer read FIDItemExchange write FIDItemExchange;
    property Exchange: Boolean read FExchange write FExchange;
    property Promo: Boolean read FPromo write FPromo;
    property Department: Integer read FDepartment write FDepartment;
    property KitSellingPrice : Currency read FKitSellingPrice write FKitSellingPrice;
    property CustomerSellingPrice : Currency read FCustomerSellingPrice write FCustomerSellingPrice;
    property PromoSellingPrice : Currency read FPromoSellingPrice write FPromoSellingPrice;
    property IsManager : Boolean read FIsManager write FIsManager;
    property AskedSalePrice: Boolean read FAskedSalePrice write FAskedSalePrice Default false;
    property IDDescriptionPrice: Integer read FIDDescriptionPrice write FIDDescriptionPrice;
    property IDVendorPrice: Integer read FIDVendorPrice write FIDVendorPrice;
    property SuggPrice: Currency read FSuggPrice write FSuggPrice;
    property IDDocumentType: Integer read FIDDocumentType write FIDDocumentType;
    property DocumentNumber: String read FDocumentNumber write FDocumentNumber;
    property Barcode: String read FBarcode write FBarcode;

    property ManualPrice: Currency read FManualPrice write FManualPrice;
    property ManualDiscount: Currency read FManualDiscount write FManualDiscount;
    property IDSpecialPrice: Integer read FIDSpecialPrice write FIDSpecialPrice;
    property IsManualPrice: Boolean read FIsManualPrice write FIsManualPrice;
    property IsManualDiscount: Boolean read FIsManualDiscount write FIsManualDiscount;
    property EachDiscount: currency read FEachDiscount write FEachDiscount;

  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uPassword, uDMCalcPrice, uNumericFunctions;

{ TSaleItem }

procedure TSaleItem.Add;
var
  iError: Integer;
begin

  OnBeforeAdd;
  DM.fPOS.AddHoldItem(FIDCustomer,
                      FIDPreSale,
                      FIDModel,
                      FIDStore,
                      FQty,
                      FDiscount,
                      FSellingPrice,
                      FCostPrice,
                      FIDUser,
                      FIDCommission,
                      FPreSaleDate,
                      Now,
                      False,
                      FIsManager,
                      FIDItemExchange,
                      FDepartment,
                      iError,
                      FIDPreInventoryMov,
                      FIDPreInventoryMovParent,
                      FPromo,
                      FIDDescriptionPrice,
                      FIDVendorPrice,
                      FSuggPrice,
                      FDocumentNumber,
                      FIDDocumentType,
                      0,
                      (FEachDiscount / FQty),//0,
                      true,
                      FManualPrice,
                      FManualDiscount,
                      FIDSpecialPrice,
                      FIsManualPrice,
                      FIsManualDiscount);

  
  FIDPreInventoryMov := 0;
  FSellingPrice := 0; 


  //Se o error acontecer, tem que tratar
  if (iError <> 0)  then
  begin
    // Excecao para manager
    if Password.HasFuncRight(9) then
    begin
      if MsgBox(MSG_QST_DISCOUNT_WAS_REACHED, vbYesNo + vbQuestion) = vbYes then
      begin
        DM.fPOS.AddHoldItem(FIDCustomer,
                            FIDPreSale,
                            FIDModel,
                            FIDStore,
                            FQty,
                            FDiscount,
                            FSellingPrice,
                            FCostPrice,
                            FIDUser,
                            FIDCommission,
                            FPreSaleDate,
                            Now,
                            False,
                            True,
                            FIDItemExchange,
                            FDepartment,
                            iError,
                            FIDPreInventoryMov,
                            FIDPreInventoryMovParent,
                            FPromo,
                            FIDDescriptionPrice,
                            FIDVendorPrice,
                            FSuggPrice);
      end
      else
      begin
        //EditSalePrice.SetFocus;
        Exit;
      end;
    end
    else
    begin
      case iError of
        -1:
        begin
          // Desconto vale se zerar
          if MsgBox(MSG_QST_ERASE_ALL_DISCOUNT_ADD, vbYesNo + vbQuestion) = vbYes then
            DM.fPOS.AddHoldItem(FIDCustomer,
                                FIDPreSale,
                                FIDModel,
                                FIDStore,
                                FQty,
                                FDiscount,
                                FSellingPrice,
                                FCostPrice,
                                FIDUser,
                                FIDCommission,
                                FPreSaleDate,
                                Now,
                                True,
                                False,
                                IDItemExchange,
                                FDepartment,
                                iError,
                                FIDPreInventoryMov,
                                FIDPreInventoryMovParent,
                                FPromo,
                                FIDDescriptionPrice,
                                FIDVendorPrice,
                                FSuggPrice);
        end;

        -2:
        begin
          //EditSalePrice.SetFocus;
          MsgBox(MSG_INF_DISCOUNT_LIMT_REACHED, vbOKOnly + vbInformation);
          Exit;
        end;

        else
        begin
          if FExchange then // Atualiza o Invoice original colocando o numero do Hold
            with DM.quFreeSQL do
            begin
              SQL.Text := 'UPDATE Invoice SET Note = Note + ' +
                          Chr(39) + ' - Exchange from Hold #' +
                          IntToStr(FIDPreSale) + ' ' + Chr(39) +
                          'WHERE IDInvoice = ' + IntToStr(IDInvoiceExchange);
              ExecSQL;
            end;
        end;
      end; //end case
    end; //end else HasFuncRight
  end; //end Error

  // Faz a atualização no item gerador da promoção para saber que ele já gerou a promoção.
  if (iError = 0) and (FPromo = True) and (FIDPreInventoryMovParent <> 0) then
    UpdateParentPromo(FIDPreInventoryMovParent);
end;

procedure TSaleItem.Remove;
begin

end;

procedure TSaleItem.Update;
var
  iError: Integer;
begin
  OnBeforeUpdate;

  DM.fPOS.UpdateHoldItem(FIDPreSale,
                         FIDPreInventoryMov,
                         FIDModel,
                         FIDCommission,
                         FIDUser,
                         FQty,
                         FDiscount,
                         FSellingPrice,
                         FCostPrice,
                         FPreSaleDate,
                         Now,
                         True,
                         True,
                         FDepartment,
                         iError,
                         FIDPreInventoryMov,
                         FIDPreInventoryMovParent,
                         FPromo,
                         FIDDescriptionPrice,
                         FIDVendorPrice,
                         FSuggPrice,
                         FDocumentNumber,
                         FIDDocumentType);

  if (iError = 0) and (FPromo = True) and (FIDPreInventoryMovParent <> 0) then
    UpdateParentPromo(FIDPreInventoryMovParent);

end;

procedure TSaleItem.SetDiscountItem(SaleItem: TSaleItem;
  DiscountSaleValue: Double; TaxExemptOnSale: Boolean);
var
  IDDiscount: Integer;
  NewDiscountSale: Double;
begin
  NewDiscountSale := DiscountSaleValue;

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Text := ' SELECT SubTotal, ItemDiscount FROM Invoice WHERE IDPreSale = ' + InttoStr(SaleItem.IDPreSale);
    Open;

    NewDiscountSale := DM.FDMCalcPrice.FormatPrice(((NewDiscountSale + FieldByName('ItemDiscount').AsCurrency) * 100)/ FieldByName('SubTotal').AsCurrency);
    Close;
  end;

  DM.fPOS.ManageDiscount(SaleItem.IDPreSale,
                         NewDiscountSale,
                         Now,
                         TaxExemptOnSale,
                         Password.HasFuncRight(9),
                         False);

  IDDiscount := DM.GetNextID('Sal_Discount.IDDiscount');

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Text := 'INSERT INTO Sal_Discount (IDDiscount,IDPreSale,IDPreInventoryMov,Discount) ' +
                'VALUES (' + InttoStr(IDDiscount) + ' , ' + InttoStr(SaleItem.IDPreSale) + ' , ' + InttoStr(Saleitem.IDPreInventoryMov)+ ' , ' + FloattoStr(DiscountSaleValue) + ' ) ';
    ExecSQL;
    Close;
  end;
end;

procedure TSaleItem.OnBeforeAdd;
begin
  // Opção pede preço.
  if not(FAskedSalePrice) then
    ApplyDiscount;
end;

procedure TSaleItem.OnBeforeUpdate;
begin
  ApplyDiscount;
end;

procedure TSaleItem.ApplyDiscount;
var
  roundSellingPrice: Extended;
begin
  FIsManager := True;

  if ((FPromo) and (FPromoSellingPrice < FCustomerSellingPrice) and (FPromoSellingPrice < FKitSellingPrice)) then
  begin
    FDiscount := 0;
    FSellingPrice := DM.FDMCalcPrice.FormatPrice(FPromoSellingPrice);
  end
  else if ((FCustomerSellingPrice <> 0) and (FCustomerSellingPrice <> FSellingPrice) and (FCustomerSellingPrice <= FKitSellingPrice)) then begin
    // AmfSouza November 14, 2012: to round discount.
    //FDiscount :=  ((roundSellingPrice - CustomerSellingPrice) * FQty);
    FDiscount := 0;
  end
  else if ((FKitSellingPrice <> 0) and (FKitSellingPrice <> FSellingPrice)) then begin
    //amfsouza August, 29 2012
    FDiscount := 0;
    FSellingPrice := FKitSellingPrice;
    //FDiscount := (FSellingPrice - FKitSellingPrice) * FQty
    end
  else
    FIsManager := False;
end;

procedure TSaleItem.UpdateParentPromo(IDPreInventoryMovParent: Integer);
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

procedure TSaleItem.CleanUpValues;
begin
    self.FDiscount := 0;
    self.FCostPrice := 0;
    self.FSellingPrice := 0;
    self.FQty := 0;
    self.FIDModel := 0;
    self. FIDVendorPrice := 0;
    self.FIDDescriptionPrice := 0;

    // Antonio Apr 2014 03 - new fields to sp addItem
    self.FManualPrice := 0;
    self.FManualDiscount := 0;
    self.FIDSpecialPrice := 0;
    self.FIsManualPrice := false;
    self.FIsManualDiscount := false;
    self.EachDiscount := 0;
    self.ManualDiscount := 0;
    self.SellingPrice := 0;
    self.IsManualDiscount := false;
    self.IsManualPrice := false;
end;

end.
