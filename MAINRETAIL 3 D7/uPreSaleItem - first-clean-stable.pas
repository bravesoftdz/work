(*
-----------------------------------------------------------------------------------------------------
Version : 
Date    : 02.03.2011
Author  : Antonio Marcos Fernandes de Souza (Antonio M F Souza)
Issue   :
Solution: call to inheritance
Version :
-----------------------------------------------------------------------------------------------------
*)


unit uPreSaleItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, Grids, DBGrids, DB, PaideForms,
  DBTables, Buttons, ADODB, SuperComboADO, siComp, siLangRT, Variants,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, SubListPanel,
  PowerADOQuery, uFrmPOSFunctions, mrBarCodeEdit, uSaleItem, uFrmPromoControl,
  LookUpADOQuery, SuperEdit, SuperEditCurrency, uFrmChoosePrice, uFrmEnterMovDocumet;

type
  TFrmPreSaleItem = class(TFrmParentForms)
    Panel1: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    spSalePrice: TADOStoredProc;
    pnlQuantity: TPanel;
    pnlSalesPerson: TPanel;
    Label7: TLabel;
    cmbSalesPerson: TSuperComboADO;
    quFindExchange: TADOQuery;
    quFindExchangeIDInventoryMov: TIntegerField;
    quFindExchangeUnitPrice: TFloatField;
    quFindExchangeQty: TFloatField;
    quFindExchangeQtyAvailable: TFloatField;
    spHelp: TSpeedButton;
    pnlModel: TPanel;
    pnlBarCode: TPanel;
    Label6: TLabel;
    Label4: TLabel;
    cmbModel: TSuperComboADO;
    Label1: TLabel;
    EditQty: TEdit;
    Label2: TLabel;
    Label9: TLabel;
    pnlCostPrice: TPanel;
    lblCost: TLabel;
    btShowCost: TSpeedButton;
    editCostPrice: TEdit;
    Label3: TLabel;
    EditOriginalSale: TEdit;
    pnlExchange: TPanel;
    Label8: TLabel;
    EditExchange: TEdit;
    btnExchange: TSpeedButton;
    btOK: TButton;
    btCancel: TButton;
    SubQty: TSubListPanel;
    QuSerialMov: TADOQuery;
    QuSerialMovSerialNumber: TStringField;
    dsSerial: TDataSource;
    Label5: TLabel;
    edtSerialNumber: TDBEdit;
    btnPicture: TSpeedButton;
    SubInvAccessoty: TSubListPanel;
    Bevel1: TBevel;
    WarrantyModels: TSubListPanel;
    quFindExchangedPre: TADOQuery;
    quFindExchangedPreIDPreInventoryMov: TIntegerField;
    quFindExchangedPreUnitPrice: TBCDField;
    quFindExchangedPreQty: TFloatField;
    quFindExchangePreInventoryMovID: TIntegerField;
    quFindExchangedPreQtyAvailable: TFloatField;
    quFindExchangeIDCustomer: TIntegerField;
    quFindExchangedPreIDCustomer: TIntegerField;
    quFindExchangedPreCanExchangeItem: TBooleanField;
    btDiscount: TSpeedButton;
    edtCommissions: TEdit;
    quSalesPerson: TPowerADOQuery;
    quSalesPersonPessoa: TStringField;
    quSalesPersonIDPessoa: TIntegerField;
    quSalesPersonCommissionPercent: TBCDField;
    btSplit: TBitBtn;
    lblDepartment: TLabel;
    cmbDepartment: TSuperComboADO;
    btSearch: TBitBtn;
    edtBarcode: TmrBarCodeEdit;
    EditSalePrice: TSuperEditCurrency;
    EditTotal: TSuperEdit;
    btUnlockPrice: TSpeedButton;
    edtPriceWithDiscount: TEdit;
    EditDiscount: TSuperEdit;
    LblDiscount: TLabel;
    LblEachTotal: TLabel;
    EditEachTotal: TSuperEdit;
    Label10: TLabel;
    EditTotalDiscount: TSuperEdit;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure cmbModelSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditQtyChange(Sender: TObject);
    procedure EditTotalChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btShowCostClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure EditQtyKeyPress(Sender: TObject; var Key: Char);
    procedure spHelpClick(Sender: TObject);
    procedure editCostPriceChange(Sender: TObject);
    procedure cmbSalesPersonChange(Sender: TObject);
    procedure EditSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure EditExchangeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExchangeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
    procedure WarrantyModelsAfterParamChanged(Changes: String);
    procedure btDiscountClick(Sender: TObject);
    procedure btSplitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbDepartmentSelectItem(Sender: TObject);
    procedure EditSalePriceCurrChange(Sender: TObject);
    procedure EditSalePriceEnter(Sender: TObject);
    procedure btUnlockPriceClick(Sender: TObject);
  private
    newItemToAddInCashRegister: boolean;

    quantityFromCashRegister: double;
    quantityChangedInThisScreen: double;
    FListIdPreInventoryOnSameSale: TStringList;
    FDepartmentId: String;
    //Antonio M F Souza 05.09.2011
    FManuallyDiscount: Double;
    FSaleItem: TSaleItem;
    FFrmPromoControl: TFrmPromoControl;
    IsItemInc, IsPost, IsModified, fHasWarranty: Boolean;
    MyIDPreSale, MyIDCliente : Integer;
    MyPreSaleDate : TDateTime;
    MyPreInventMovID : Integer;
    MyquPreSaleItem, MyquPreSaleValue : TADOStoredProc;
    OriginalSalePrice, SalePrice, CostPrice, AvgCost, CustomerDiscount : Double;
    IsChangeSale, IsChangeTotal, FIsNew : Boolean;
    fOnHand, fOnPreSale, fOnAvailable, fOnPrePurchase : Double;
    fNotVerifyQty : Boolean;
    SalesPerson : TSalesPerson;
    HaveCommissions : Boolean;
    FDepartment : Integer;
    FAddKitItems : Boolean;
    FModelCaseQty: double;
    FFrmChoosePrice: TFrmChoosePrice;
    FPriceTable: TChoosedPrice;
    FFrmEnterMovDocumet: TFrmEnterMovDocumet;
    bUnlockPrice : Boolean;
    bDisableIncresePrice : Boolean;

    procedure setScreenPosition();
    procedure treatLookupModel(isNewItem: boolean);
    procedure treatCostPrice();
    procedure treatSalePerson(isNewItem: boolean);
    procedure treatQuantity(isNewItem: boolean);

    function isVisiblePanelCostPrice(): boolean;
    function isVisiblePanelSalePerson(): boolean;

    procedure RefreshBrowse;
    procedure LoadEditValues(quantityAssigned: double);
    procedure NextAppend;
    procedure SelectModel;
    procedure EditValue(bValue:Boolean);
    procedure RefreshQty;
    procedure RefreshAccessory;
    procedure RefreshWarranty;
    procedure AfterInsertItem;
    procedure ModifytoCommissions;
    procedure ArrangeCommissionsList;
    procedure RefreshDepartment;
    function HasSerialNumber: Boolean;
    function ValidateFields: Boolean;
    procedure VerifyCommissions;
    procedure UpdateSalePriceControl;

    function HasPriceTable: Boolean;
    function NeedDocument: Boolean;
    procedure SetDocument;

    procedure GetTablePrice;
    procedure GetMovDocument;

    function ReturnIDUser  : Integer;
    function ReturnIDComis : Integer;
    procedure treatPanelCostPrice;
    procedure treatPanelSalePerson;
  public
    function Start(IDPreSale: Integer;
                   var PreInventMovID: Integer;
                   PreSaleDate: TDateTime;
                   IsInc: Boolean;
                   IDCliente: Integer;
                   quPreSaleItem,
                   quPreSaleValue: TADOStoredProc;
                   IsNew: Boolean;
                   Department: Integer;
                   AFrmPromoControl: TFrmPromoControl = nil): Boolean;
  end;

implementation

uses uPassword, uDM, uAskManager, uInvoice, uMsgBox, uFrmBarcodeSearch,
     uFrmSerialNumber, uMsgConstant, uNumericFunctions, uCharFunctions,
     uDMGlobal, uSystemConst, uFrmModelPicture, uParamFunctions, Math,
     uFrmPreSaleItemDiscount, uFrmAddItemCommission, uFrmAddKitItems,
     uFrmInvoiceRefund, uUserObj, uSystemTypes, DateUtils;

{$R *.DFM}

procedure TFrmPreSaleItem.EditValue(bValue:Boolean);
begin
  IsModified := bValue;
end;

function TFrmPreSaleItem.HasSerialNumber:Boolean;
begin
  // Teste se todos os serial numbers foram preenchidos
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT IDPreInventoryMov ');
    SQL.Add('FROM	PreInventoryMov PIM (NOLOCK) ');
    SQL.Add('LEFT OUTER JOIN PreSerialMov PSM (NOLOCK) ON (PIM.IDPreInventoryMov = PSM.PreInventoryMovID)');
    SQL.Add('JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)');
    SQL.Add('JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)');
    SQL.Add('WHERE TG.SerialNumber = 1');
    SQL.Add('AND PIM.UserID = ' + IntToStr(DM.fUser.ID));
    SQL.Add('AND  PIM.DocumentID = ' + IntToStr(MyIDPreSale));
    SQL.Add('AND  PIM.IDPreInventoryMov = ' + IntToStr(MyPreInventMovID));
    SQL.Add('GROUP BY IDPreInventoryMov, PIM.Qty ');
    SQL.Add('HAVING COUNT(PSM.SerialNumber) < ABS(PIM.Qty)');
    Open;
    Result := (RecordCount>0);
    Close;
  end;
end;

function TFrmPreSaleItem.Start(IDPreSale: Integer;
                               var PreInventMovID: Integer;
                               PreSaleDate: TDateTime;
                               IsInc: Boolean;
                               IDCliente: Integer;
                               quPreSaleItem,
                               quPreSaleValue: TADOStoredProc;
                               IsNew: Boolean;
                               Department: Integer;
                               AFrmPromoControl: TFrmPromoControl): Boolean;
begin
  IsItemInc        := IsInc;
  MyIDPreSale      := IDPreSale;
  MyPreSaleDate    := PreSaleDate;
  IsPost           := False;
  MyPreInventMovID := PreInventMovID;
  MyquPreSaleItem  := quPreSaleItem;
  MyquPreSaleValue := quPreSaleValue;
  MyIDCliente      := IDCliente;
  FIsNew           := IsNew;

  newItemToAddInCashRegister := isNew;

  FFrmPromoControl := AFrmPromoControl;
  FDepartment      := Department;
  FAddKitItems     := False;

  { Alex 09/17/2011 }
  EditSalePrice.Text     := MyFloatToStr( 0 );
  EditDiscount.Text      := MyFloatToStr( 0 );
  EditTotalDiscount.Text := MyFloatToStr( 0 );
  EditEachTotal.Text     := MyFloatToStr( 0 );
  EditTotal.Text         := MyFloatToStr( 0 );

  if DM.fPOS.fCommisList = Nil then
   DM.fPOS.fCommisList := TStringList.Create;

  edtCommissions.Visible := False;

  if not IsItemInc then
  begin
    GetTablePrice;
    GetMovDocument;
  end;

  //Antonio M F Souza 05.09.2011
  FManuallyDiscount := 0;
  EditDiscount.Text      := MyFloatToStr( 0 );
  EditTotalDiscount.Text := MyFloatToStr( 0 );

  FListIdPreInventoryOnSameSale := TStringList.Create();    

  ShowModal;

  Result := IsPost;

  // Retorna o alterado ou inserido
  if Result then
    PreInventMovID := MyPreInventMovID;
end;

procedure TFrmPreSaleItem.btOKClick(Sender: TObject);
var
  hasSameLine: boolean;
  //Antonio M F Souza 09.01.2011 - to be used in routine IsThereSameCondition
  sameLineInCashRegister: boolean;
  IdpreInvMov: integer;
  qtyPreInventoryCurrent: double;
  OutQtyPreSale: double;
  OutDiscount: double;

  NewSalesPerson     : Integer;
  QtyTest, Qty,
  ExchangeQty        : Double;
  IDCustomerExchange : Integer;
  bCanExchangeDeliver: Boolean;
  IDPreInvMovExchange: integer;
  iError             : Integer;
  EachDiscount,
  Discount : Double;
  DifLine            : Double;
  fFrmSerialNumber   : TFrmSerialNumber;
  ExchangeUnitPrice  : Currency;
  fEmptyExchanged    : Boolean;
  fCashRegType       : Integer;
  lExchange          : Boolean;
  fIDInvExchange     : Integer;
  fIDPreExchange     : Integer;
  DiscountSaleValue  : Double;
  IDPreInvMovUpdate  : Integer;

  procedure CheckSerialNumber;
  begin
    //Verify Serial numbers and popup serialnumber screen.
    //if HasSerialNumber then
    if ( dm.isGiftCardModel(strToInt(cmbModel.LookUpValue)) ) then begin
      fFrmSerialNumber := TFrmSerialNumber.Create(Self);
      FListIdPreInventoryOnSameSale.Add(intTostr(FSaleItem.IDPreSale) + '/' + intTostr(FSaleItem.IDPreInventoryMov));                                      
      fFrmSerialNumber.setListFromPreInventoryMovOnSameSale(FListIdPreInventoryOnSameSale);
      fFrmSerialNumber.StartOnSales(SERIAL_HOLD,
                                    StrToInt(cmbModel.LookUpValue),
                                    DM.fStore.IDStoreSale,
                                    MyStrToDouble(EditQty.Text),
                                    MyPreInventMovID);
    end;
  end;

begin

  if Trim(cmbModel.Text) = '' then
  begin
    btCancel.click;
    Exit;
  end;

  if not ValidateFields then
    Exit;

  Qty := MyStrToDouble(EditQty.Text);
  lExchange := False;


  Discount := 0;

  //Antonio M F Souza 09.05.2011 - in test
  if ( IsChangeSale ) then begin
     Discount := 0;
     IsChangeSale := False;
  end;


  { Begin Alex 09/16/2011 - Sale price can be changed manually, not configuring an   }
  { actual discount. So sale price will obey the form information and discount       }
  { will allways come from the textBox Each Disc.                                    }
  SalePrice := MyStrToMoney( EditSalePrice.Text );

  EachDiscount := MyStrToDouble( EditDiscount.Text );
  Discount     := MyStrToDouble( EditTotalDiscount.Text );

  FManuallyDiscount := Discount;

  { End Alex 09/16/2011                                                       }


  if (TruncMoney(MyStrToMoney(EditSalePrice.Text), DM.FQtyDecimal) < TruncMoney(CostPrice, DM.FQtyDecimal)) and
     (MyStrToMoney(EditSalePrice.Text) > 0) then
  begin
    if Password.HasFuncRight(4) then
    begin
      if MsgBox(MSG_QST_PRICE_BELLOW, vbYesNo + vbQuestion) = vbNo then
      begin
        EditSalePrice.SetFocus;
        Exit;
      end;
    end
    else
    begin
      EditSalePrice.SetFocus;
      MsgBox(MSG_INF_NOT_SELL_BELLOW_COST, vbOKOnly + vbInformation);
      Exit;
    end;
  end;

  if (Discount > 0) and (not bUnlockPrice) and (not Password.HasFuncRight(41)) then
  begin
    MsgBox(MSG_INF_NOT_GIVE_DICOUNT, vbCritical + vbOKOnly);
    Exit;
  end;

  // Testa se pode dar devolucao do Invoice Original
  fCashRegType := DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE];

  if pnlExchange.Visible then
  begin
    fEmptyExchanged := True;
    fHasWarranty    := False;
    fIDPreExchange  := 0;
    fIDInvExchange  := 0;

    case fCashRegType of
      CASHREG_TYPE_POS:
      begin
        fIDInvExchange := MyStrToInt(DM.DescCodigo(['InvoiceCode'], [QuotedStr(EditExchange.Text)], 'Invoice', 'IDInvoice'));
        if fIDInvExchange = 0 then
          fIDInvExchange := MyStrToInt(DM.DescCodigo(['CupomFiscal'], [QuotedStr(FormatFloat('000000', MyStrToInt(EditExchange.Text)))], 'Invoice', 'IDInvoice'));
      end;
      CASHREG_TYPE_OFFICE:
      begin
        fIDPreExchange := MyStrToInt(DM.DescCodigo(['SaleCode', 'IDStore'], [QuotedStr(EditExchange.Text),IntToStr(DM.fStore.ID)], 'Invoice', 'IDPreSale'));
        fIDInvExchange := MyStrToInt(DM.DescCodigo(['SaleCode', 'IDStore'], [QuotedStr(EditExchange.Text),IntToStr(DM.fStore.ID)], 'Invoice', 'IDInvoice'));
      end;
    end;

    //52 = Pode fazer troca por itens no invoice
    if (fIDInvExchange <> 0) and (Password.HasFuncRight(52)) then
      with quFindExchange do
        begin
          Close;
          Parameters.ParambyName('IDInvoice').Value := fIDInvExchange;
          Parameters.ParambyName('IDModel').Value   := MyStrToInt(cmbModel.LookUpValue);
          Open;

          fEmptyExchanged := IsEmpty;

          if (not fEmptyExchanged) and (RecordCount >= 1) then
          begin
            // em fase de teste !!
            // Achou item unico no Invoice
            IDPreInvMovExchange        := quFindExchangePreInventoryMovID.AsInteger;
            ExchangeUnitPrice          := TruncMoney(quFindExchangeUnitPrice.AsFloat, DM.FQtyDecimal);
            ExchangeQty                := quFindExchangeQtyAvailable.Value;
            IDCustomerExchange         := quFindExchangeIDCustomer.AsInteger;
          end
          else
          begin
            // Achou varios itens, deve escolher qual item
          end;
          Close;
        end;

    //Verifica se tem o Item no PreInv
    if fEmptyExchanged and (fCashRegType = CASHREG_TYPE_OFFICE) then
    begin
      with quFindExchangedPre do
      begin
        Close;
        Parameters.ParambyName('IDPreSale').Value := fIDPreExchange;
        Parameters.ParambyName('IDModel').Value   := MyStrToInt(cmbModel.LookUpValue);
        Open;

        fEmptyExchanged := IsEmpty;

        if (not fEmptyExchanged) and (RecordCount >= 1) then
        begin
          // em fase de teste !!
          // Achou item unico no Invoice
          IDPreInvMovExchange        := quFindExchangedPreIDPreInventoryMov.AsInteger;
          ExchangeUnitPrice          := TruncMoney(quFindExchangedPreUnitPrice.AsFloat, DM.FQtyDecimal);
          ExchangeQty                := quFindExchangedPreQtyAvailable.Value;
          IDCustomerExchange         := quFindExchangedPreIDCustomer.AsInteger;
          bCanExchangeDeliver        := quFindExchangedPreCanExchangeItem.AsBoolean;
        end
        else
        begin
          // Achou varios itens, deve escolher qual item
        end;
        Close;
      end;
    end;

    // Nao achou item no Invoice
    if fEmptyExchanged then
    begin
      if Password.HasFuncRight(5) then
      begin
        if MsgBox(MSG_QST_INVOICE_DONOT_HAVE_ITEM, vbYesNo + vbQuestion) = vbNo then
          Exit;
      end
      else
      begin
        MsgBox(MSG_INF_INVOICE_NOT_HAVE_ITEM, vbOKOnly + vbInformation);
        Exit;
      end;
    end;

    //Verifica se o cliente e o mesmo
    if Password.HasFuncRight(53) then
    begin
      if IDCustomerExchange <> MyIDCliente then
      begin
        MsgBox(MSG_INF_CUSTOMER_NOT_MATCH, vbOKOnly + vbInformation);
        Exit;
      end;
    end;

    //Verifica o estatos da entrega antes de trocar
    if DM.fSystem.SrvParam[PARAM_CONFIRM_DELIVERY_ON_SALE] then
      if (fIDInvExchange = 0) and (Password.HasFuncRight(54) and (not bCanExchangeDeliver)) then
      begin
        MsgBox(MSG_INF_VERIFY_DELIVER_STATUS, vbOKOnly + vbInformation);
        Exit;
      end;

    // Testa se valor do item e igual ao que foi vendido originalmente
    if Abs(StrToCurr(EditSalePrice.Text)) <> Abs(ExchangeUnitPrice) then
      if Password.HasFuncRight(6) then
       begin
        if MsgBox(MSG_INF_PART_ITEM_SOLD_FOR + FloatToStrF(ExchangeUnitPrice, ffCurrency, 20, DM.FQtyDecimal) + '._' +
                  MSG_QST_CONTINUE, vbYesNo + vbQuestion) = vbNo then
           Exit;
       end
      else
      begin
        MsgBox(MSG_INF_PART_ITEM_SOLD_FOR + FloatToStrF(ExchangeUnitPrice, ffCurrency, 20, DM.FQtyDecimal),
                    vbOKOnly + vbInformation);

        EditSalePrice.Text := FloatToStrF(ExchangeUnitPrice, ffNumber, 20, DM.FQtyDecimal);
        SalePrice          := MyStrToMoney(EditSalePrice.Text);
        Exit;
      end;

    // ** Testa se a qty de refund é maior que a qty vendida
    if (ExchangeQty < (-MyStrToDouble(EditQty.Text))) then
    begin
      MsgBox(MSG_INF_WRONG_QTY, vbOKOnly + vbInformation);
      EditQty.SetFocus;
      Exit;
    end;

    // Testa se o novo valor sera menor que zero, caso seja so o manager pode realizar
    if not IsItemInc then
      DifLine := MyquPreSaleItem.FieldByName('TotalItem').AsFloat
    else
      DifLine := 0;

    if (MyquPreSaleValue.FieldByName('SubTotal').AsFloat - DifLine +
        MyStrToMoney(EditTotal.Text) < 0) and not Password.HasFuncRight(7) then
    begin
      EditQty.SetFocus;
      MsgBox(MSG_INF_MANAGER_TONEGATIVE_DISC, vbOKOnly + vbInformation);
      Exit;
    end;

    // seta o vendedor
    if cmbSalesPerson.LookUpValue = '' then
    begin
      NewSalesPerson := DM.fUser.IDCommission;
      cmbSalesPerson.LookUpValue := IntToStr(NewSalesPerson);
    end;

    lExchange := True;
  end;

  if IsItemInc then
  begin
    // Teste de Model vazio
    if (cmbModel.LookUpValue = '') then
    begin
      cmbModel.SetFocus;
      MsgBox(MSG_CRT_NO_MODEL, vbOKOnly + vbInformation);
      Exit;
    end;

    if Qty > 0 then
    begin
      //Teste da quantidade disponivel
      QtyTest := fOnAvailable;

      if DM.fSystem.SrvParam[PARAM_INCLUDEPREPURCHASE] then
        QtyTest := QtyTest + fOnPrePurchase;

      if (Qty > QtyTest) and (not fNotVerifyQty) then
      begin
        if not (DM.fSystem.SrvParam[PARAM_SALEONNEGATIVE] or Password.HasFuncRight(8)) then
        begin
          if MsgBox(MSG_QST_INV_NEGATIVE, vbYesNo + vbQuestion) = vbNo then
            Exit;

          with TFrmAskManager.Create(Self) do
            if not Start('To complete this operation you must have Manager Authorization.') then
              Exit;
        end
        else
        begin
          MsgBox(MSG_EXC_QTY_BIGGER, vbOKOnly + vbExclamation);
        end;
      end;
    end;
  end;

  //Testa garantia selecionada
  //Garantia so pode ser trelada ha um item
  if fHasWarranty and (MyStrToDouble(EditQty.Text) <> 1) then
  begin
    MsgBox(MSG_INF_NOT_QTY_GREATER_1, vbOKOnly + vbExclamation);
    EditQty.SetFocus;
    Exit;
  end;

  IsPost := True;
  Screen.Cursor := crHourGlass;

  FSaleItem.IDCustomer              := MyIDCliente;
  FSaleItem.IDPreSale               := MyIDPreSale;
  FSaleItem.IDModel                 := StrToInt(cmbModel.LookUpValue);
  FSaleItem.IDStore                 := DM.fStore.IDStoreSale;
  FSaleItem.SellingPrice            := SalePrice;
  FSaleItem.Qty                     := Qty;
  FSaleItem.IDUser                  := DM.fUser.ID;
  FSaleItem.IDCommission            := MyStrToInt(cmbSalesPerson.LookUpValue);
  FSaleItem.PreSaleDate             := MyPreSaleDate;
  FSaleItem.IDPreInventoryMov       := MyquPreSaleItem.FieldByName('IDInventoryMov').AsInteger;
  FSaleItem.IDPreInventoryMovParent := MyquPreSaleItem.FieldByName('IDMovParent').AsInteger;
  FSaleItem.CustomerSellingPrice    := FSaleItem.SellingPrice;
  FSaleItem.KitSellingPrice         := FSaleItem.SellingPrice;
  FSaleItem.Barcode                 := edtBarcode.Text;
  if Assigned(FPriceTable) then
  begin
    FSaleItem.IDDescriptionPrice      := FPriceTable.IDDescriptionPrice;
    FSaleItem.IDVendorPrice           := FPriceTable.IDVendor;
    FSaleItem.SuggPrice               := FPriceTable.SuggPrice;
  end;

  //Antonio M F Souza 09.01.2011 - change operation if has a line with the same condition.
  sameLineInCashRegister := dm.fPOS.IsThereSameConditionsToSale(qtyPreInventoryCurrent, IdpreInvMov, OutQtyPreSale, OutDiscount,
                                                                FSaleItem.IDStore, FSaleItem.IDModel, FSaleItem.IdPreSale, ReturnIDComis,
                                                                fSaleItem.SellingPrice, fManuallyDiscount,
                                                                true, true,
                                                                0, EachDiscount );

  hasSameLine := sameLineInCashRegister;

  if IsitemInc then
    FSaleItem.Promo := false
  else
    FSaleItem.Promo := MyquPreSaleItem.FieldByName('Promo').AsBoolean;

  if NeedDocument then
    SetDocument;

  // Chama o PreSaleItem
  if IsItemInc then
  begin
    if FAddKitItems then
    begin
      with TFrmAddKitItems.Create(Self) do
        Start(FSaleItem);

      RefreshBrowse;
      Screen.Cursor := crDefault;
      Close;
      Exit;
    end;

    if ( hasSameLine ) then begin
    // Antonio M F Souza 09.16.2011 - add previous discount to typed discount only in Insert ( addHoldItem ).
       qty := strToFloat(EditQty.Text);
       dm.fPOS.DeleteHoldItem(MyIDPreSale, IdpreInvMov,  //MyPreInventMovID,
                                FSaleItem.IDModel,
                                FSaleItem.IDUser, qty,
                                discount, salePrice,
                                False, Password.HasFuncRight(9), Password.HasFuncRight(9), Now, iError);
       Discount := Discount + OutDiscount;
       qty      := qty + OutQtyPreSale;
    end;

    DM.fPOS.AddHoldItem(MyIDCliente,
                        MyIDPreSale,
                        StrToInt(cmbModel.LookUpValue),
                        DM.fStore.IDStoreSale,
                        Qty,
                        Discount,
                        SalePrice,
                        MyStrToMoney(editCostPrice.Text),
                        ReturnIDUser,
                        ReturnIDComis,
                        MyPreSaleDate,
                        Now,
                        False,
                        Password.HasFuncRight(9), //manager
                        IDPreInvMovExchange,
                        fDepartment,
                        iError,
                        MyPreInventMovID,
                        0,
                        FSaleItem.Promo,
                        FSaleItem.IDDescriptionPrice,
                        FSaleItem.IDVendorPrice,
                        FSaleItem.SuggPrice,
                        FSaleItem.DocumentNumber,
                        FSaleItem.IDDocumentType,
                        { Alex 09/17/2011 }
                        0, EachDiscount
                        );
    //Se o error acontecer, tem que tratar
    if (iError <> 0)  then
    begin
      // Excecao para manager
      if Password.HasFuncRight(9) then
      begin
        if MsgBox(MSG_QST_DISCOUNT_WAS_REACHED, vbYesNo + vbQuestion) = vbYes then
        begin
          DM.fPOS.AddHoldItem(MyIDCliente,
                              MyIDPreSale,
                              StrToInt(cmbModel.LookUpValue),
                              DM.fStore.IDStoreSale,
                              Qty,
                              Discount,
                              SalePrice,
                              MyStrToMoney(editCostPrice.Text),
                              ReturnIDUser,
                              ReturnIDComis,
                              MyPreSaleDate,
                              Now,
                              False,
                              True,
                              IDPreInvMovExchange,
                              fDepartment,
                              iError,
                              MyPreInventMovID,
                              0,
                              FSaleItem.Promo,
                              FSaleItem.IDDescriptionPrice,
                              FSaleItem.IDVendorPrice,
                              FSaleItem.SuggPrice,
                              FSaleItem.DocumentNumber,
                              FSaleItem.IDDocumentType);
        end
        else
        begin
          EditSalePrice.SetFocus;
          Screen.Cursor := crDefault;
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
              DM.fPOS.AddHoldItem(MyIDCliente,
                                  MyIDPreSale,
                                  StrToInt(cmbModel.LookUpValue),
                                  DM.fStore.IDStoreSale,
                                  Qty,
                                  Discount,
                                  SalePrice,
                                  MyStrToMoney(editCostPrice.Text),
                                  ReturnIDUser,
                                  ReturnIDComis,
                                  MyPreSaleDate,
                                  Now,
                                  True,
                                  False,
                                  IDPreInvMovExchange,
                                  fDepartment,
                                  iError,
                                  MyPreInventMovID,
                                  0,
                                  FSaleItem.Promo,
                                  FSaleItem.IDDescriptionPrice,
                                  FSaleItem.IDVendorPrice,
                                  FSaleItem.SuggPrice,
                                  FSaleItem.DocumentNumber,
                                  FSaleItem.IDDocumentType);
          end;
          -2:
          begin
            EditSalePrice.SetFocus;
            Screen.Cursor := crDefault;
            MsgBox(MSG_INF_DISCOUNT_LIMT_REACHED, vbOKOnly + vbInformation);
            Exit;
          end;
          else
          begin
            if lExchange then // Atualiza o Invoice original colocando o numero do Hold
              with DM.quFreeSQL do
              begin
                SQL.Text := 'UPDATE Invoice SET Note = Note + ' +
                            Chr(39) + ' - Exchange from Hold #' +
                            IntToStr(MyIDPreSale) + ' ' + Chr(39) +
                            ' WHERE IDInvoice = ' + Trim(EditExchange.Text);
                ExecSQL;
              end;
          end;
        end; //end case
      end; //end else HasFuncRight
    end; //end Error

    // Verifica se o Item tem Serial Number
    CheckSerialNumber;
    AfterInsertItem;
    RefreshBrowse;

    if (fCashRegType = CASHREG_TYPE_FULL_POS) and (Qty < 0) then
      if (MsgBox(MSG_QST_ITEM_RESALABLE, vbQuestion + vbYesNo) = vbNo) then
        with TFrmInvoiceRefund.Create(Self) do
          StartItem(MyPreInventMovID);

    //Poll Display
    DM.PollDisplayInvInfo('',
                          Trunc(MyPreSaleDate),
                          MyquPreSaleValue.FieldByName('AditionalExpenses').AsCurrency,
                          MyquPreSaleValue.FieldByName('TotalDiscount').AsCurrency,
                          MyquPreSaleValue.FieldByName('Tax').AsCurrency,
                          MyquPreSaleValue.FieldByName('SubTotal').AsCurrency);

    DM.PollDisplayAddItem(MyPreInventMovID,
                          StrToInt(cmbModel.LookUpValue),
                          MyquPreSaleItem.FieldByName('Model').AsString,
                          MyquPreSaleItem.FieldByName('Description').AsString,
                          Qty,
                          SalePrice,
                          Discount);


    NextAppend;
  end
  else // alteracao
  begin
//(*
    //Antonio M F Souza 09.01.2011 - under test
    if ( sameLineInCashRegister ) then begin  //delete line selected to changes
         // Antonio M F Souza 10.21.2011 - must be have more than one to delete.
         if ( dm.fPOS.canDeleteInDetail(dm.fStore.ID, FSaleItem.IDModel, MyIdPresale, FSaleItem.IDCommission, SalePrice) ) then begin

             dm.fPOS.DeleteHoldItem(MyIDPreSale, IdpreInvMov, FSaleItem.IDModel,
                                    FSaleItem.IDUser, MyquPreSaleItem.FieldByName('Qty').AsFloat,
                                    discount, MyquPreSaleItem.FieldByName('SalePrice').AsFloat,
                                    False, Password.HasFuncRight(9), Password.HasFuncRight(9), Now, iError);


             //Antonio M F Souza 09.19.2011 - add discount.
             discount := discount + OutDiscount;
             qty      := qty + OutQtyPreSale;

         end;

         DM.fPOS.UpdateHoldItem(MyIDPreSale,
                           MyPreInventMovID,
                           StrToInt(cmbModel.LookUpValue),
                           MyStrToInt(cmbSalesPerson.LookUpValue),
                           MyquPreSaleItem.FieldByName('IDUser').AsInteger,
                           Qty,
                           Discount,
                           SalePrice,
                           MyStrToMoney(editCostPrice.Text),
                           MyPreSaleDate,
                           Now,
                           False,
                           False,
                           fDepartment,
                           iError,
                           MyPreInventMovID,
                           FSaleItem.IDPreInventoryMovParent,
                           FSaleItem.Promo,
                           FSaleItem.IDDescriptionPrice,
                           FSaleItem.IDVendorPrice,
                           FSaleItem.SuggPrice,
                           FSaleItem.DocumentNumber,
                           FSaleItem.IDDocumentType,
                           0,
                           fSaleItem.IDStore,
                           EachDiscount);

    end
    else begin
//*)
          IDPreInvMovUpdate := MyPreInventMovID;
          // Chama a store procedure de alteracao
          DM.fPOS.UpdateHoldItem(MyIDPreSale,
                                 MyPreInventMovID,
                                 StrToInt(cmbModel.LookUpValue),
                                 MyStrToInt(cmbSalesPerson.LookUpValue),
                                 MyquPreSaleItem.FieldByName('IDUser').AsInteger,
                                 Qty,
                                 Discount,
                                 SalePrice,
                                 MyStrToMoney(editCostPrice.Text),
                                 MyPreSaleDate,
                                 Now,
                                 False,
                                 False,
                                 fDepartment,
                                 iError,
                                 MyPreInventMovID,
                                 FSaleItem.IDPreInventoryMovParent,
                                 FSaleItem.Promo,
                                 FSaleItem.IDDescriptionPrice,
                                 FSaleItem.IDVendorPrice,
                                 FSaleItem.SuggPrice,
                                 FSaleItem.DocumentNumber,
                                 FSaleItem.IDDocumentType,
                                 0,
                                 fSaleItem.IDStore,
                                 EachDiscount);

          if (iError <> 0)  then
          begin
            if Password.HasFuncRight(9) then
            begin
              if MsgBox(MSG_QST_DISCOUNT_WAS_REACHED, vbYesNo + vbQuestion) = vbYes then
                DM.fPOS.UpdateHoldItem(MyIDPreSale,
                                       MyPreInventMovID,
                                       StrToInt(cmbModel.LookUpValue),
                                       MyStrToInt(cmbSalesPerson.LookUpValue),
                                       DM.fUser.ID,
                                       Qty,
                                       Discount,
                                       SalePrice,
                                       MyStrToMoney(editCostPrice.Text),
                                       MyPreSaleDate,
                                       Now,
                                       False,
                                       True,
                                       fDepartment,
                                       iError,
                                       MyPreInventMovID,
                                       FSaleItem.IDPreInventoryMovParent,
                                       FSaleItem.Promo,
                                       FSaleItem.IDDescriptionPrice,
                                       FSaleItem.IDVendorPrice,
                                       FSaleItem.SuggPrice,
                                       FSaleItem.DocumentNumber,
                                       FSaleItem.IDDocumentType,
                                       0,
                                       fSaleItem.IDStore,
                                       EachDiscount);
            end
            else
            begin
              case iError of
                -1:
                begin
                  // Desconto vale se zerar
                  if MsgBox(MSG_QST_ERASE_ALL_DISCOUNT_MOD, vbYesNo + vbQuestion) = vbYes then
                    DM.fPOS.UpdateHoldItem(MyIDPreSale,
                                           MyPreInventMovID,
                                           StrToInt(cmbModel.LookUpValue),
                                           MyStrToInt(cmbSalesPerson.LookUpValue),
                                           DM.fUser.ID,
                                           Qty,
                                           Discount,
                                           SalePrice,
                                           MyStrToMoney(editCostPrice.Text),
                                           MyPreSaleDate,
                                           Now,
                                           True,
                                           False,
                                           fDepartment,
                                           iError,
                                           MyPreInventMovID,
                                           FSaleItem.IDPreInventoryMovParent,
                                           FSaleItem.Promo,
                                           FSaleItem.IDDescriptionPrice,
                                           FSaleItem.IDVendorPrice,
                                           FSaleItem.SuggPrice,
                                           FSaleItem.DocumentNumber,
                                           FSaleItem.IDDocumentType,
                                           0,
                                           fSaleItem.IDStore,
                                           EachDiscount);
                end;
                -2:
                begin
                  EditSalePrice.SetFocus;
                  Screen.Cursor := crDefault;
                  MsgBox(MSG_INF_DISCOUNT_LIMT_REACHED, vbOKOnly + vbInformation);
                  Exit;
                end;
              end; //end case
            end; //End Else  HasFuncRight
          end; //End iError

(*// Antonio M F Souza 09.01.2011*)    end;

    //Verifica se o Item tem Serial Number
    CheckSerialNumber;
    RefreshBrowse;

    //Poll Display
    DM.PollDisplayDeleteItem(IDPreInvMovUpdate);
    DM.PollDisplayInvInfo('',
                          Trunc(MyPreSaleDate),
                          MyquPreSaleValue.FieldByName('AditionalExpenses').AsCurrency,
                          MyquPreSaleValue.FieldByName('TotalDiscount').AsCurrency,
                          MyquPreSaleValue.FieldByName('Tax').AsCurrency,
                          MyquPreSaleValue.FieldByName('SubTotal').AsCurrency);

    DM.PollDisplayAddItem(MyPreInventMovID,
                          StrToInt(cmbModel.LookUpValue),
                          MyquPreSaleItem.FieldByName('Model').AsString,
                          MyquPreSaleItem.FieldByName('Description').AsString,
                          Qty,
                          SalePrice,
                          Discount);

    Screen.Cursor := crDefault;
    // Fecha depois da alteracao
    Close;
  end;

  if DM.fPOS.fCommisList.Count > 0 then
    DM.fPOS.AddSaleItemCommission(MyPreInventMovID,SALE_PRESALE);

  if Assigned(FPriceTable) then
    FreeAndNil(FPriceTable);

  //Atualiza o impost ST
  if DM.fSystem.SrvParam[PARAM_ENABLE_INDUSTRY_OPTION] then
    DM.CalcularImpostoST(MyIDPreSale);

  UpdateSalePriceControl;
end;

procedure TFrmPreSaleItem.RefreshBrowse;
begin
  Screen.Cursor := crHourGlass;

  with MyquPreSaleItem do
  begin
    Close;
    Parameters.ParambyName('@DocumentID').Value := MyIDPreSale;
    Parameters.ParambyName('@IsPreSale').Value  := True;
    Open;
    Locate('IDInventoryMov', IntToStr(MyPreInventMovID), []);
  end;

  with MyquPreSaleValue do
  begin
    Close;
    Parameters.ParambyName('@PreSaleID').Value := MyIDPreSale;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TFrmPreSaleItem.btCancelClick(Sender: TObject);
begin
  if IsModified then
    if (cmbModel.Text <> '') and (MsgBox (MSG_QST_SURE, vbYesNo + vbQuestion) = vbNo) then
      Exit;

  ModalResult := mrCancel;
end;

procedure TFrmPreSaleItem.cmbModelSelectItem(Sender: TObject);
begin
  SelectModel;
  btOk.Default := True;
end;

procedure TFrmPreSaleItem.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  treatSalePerson(newItemToAddInCashRegister);
  treatQuantity(newItemToAddInCashRegister);
  treatCostPrice;

  UpdateSalePriceControl;
  btShowCostClick(nil);

  IsChangeSale  := True;
  IsChangeTotal := True;

  pnlBarCode.Visible := True;

  pnlBarCode.Visible := newItemToAddInCashRegister;

  bDisableIncresePrice := DM.fSystem.SrvParam[PARAM_DISABLE_INCREASE_PRICE];

  // edit button was pressed
  if ( not newItemToAddInCashRegister ) then begin
    EditQty.Text := myQuPresaleItem.fieldByName('qty').asString;
    quantityFromCashRegister := myQuPresaleItem.fieldByName('qty').AsFloat;

    cmbModel.ReadOnly := true;
    cmbModel.color := clBtnFace;

    cmbModel.LookUpValue := myQuPresaleItem.fieldByName('ModelID').AsString;
    salePrice := myQuPresaleItem.fieldByName('salePrice').Value;
    LoadEditValues(quantityFromCashRegister);
  end
  else begin
    cmbModel.ReadOnly := false;
    cmbModel.color := clWindow;
    NextAppend;
  end;

  Screen.Cursor := crDefault;
  EditValue(false);
end;

procedure TFrmPreSaleItem.NextAppend;
begin
  salePrice := 0;
  newItemToAddInCashRegister := true;
  // Zera valores
  edtBarcode.Text      := '';
  EditQty.Text         := '1';
  cmbModel.LookUpValue := '';
  EditCostPrice.Text   := '';
  EditOriginalSale.Text := '';
  EditExchange.Text    := '';
  EditEachTotal.Text   := '';

  fHasWarranty         := False;

  if cmbSalesPerson.LookUpValue = '' then
    cmbSalesPerson.LookUpValue := IntToStr(DM.fUser.IDCommission);

  try
    IsChangeSale       := False;
    EditSalePrice.Text := '0.00';
  finally
    IsChangeSale := True;
  end;

  try
    IsChangeTotal  := False;
    EditTotal.Text := '';
  finally
    IsChangeTotal := True;
  end;

  // cmbModel.SetFocus;
  if (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE]=2) then
    cmbModel.SetFocus
  else
    edtBarcode.Setfocus;

  // Abre as quantidades mesmo vazias
  RefreshQty;

  //Abre as Garantias
  RefreshWarranty;

  btDiscount.Visible := Password.HasFuncRight(83);
  EditDiscount.Text      := MyFloatToStr( 0 );
  EditTotalDiscount.Text := MyFloatToStr( 0 );

  fIsNew := true;
end;

procedure TFrmPreSaleItem.SelectModel;
var
  fIDModel: Integer;
  fVerifyQty: Variant;
  fCostValue, fStoreCost, fStoreAvg, fStoreSell, fPromotionPrice: Currency;
begin
  CustomerDiscount := 0;

  // Pega o salePrice e Quantities
  RefreshQty;

  RefreshDepartment;

  if IsItemInc then
  begin
    fIDModel := StrToInt(cmbModel.LookUpValue);

    if not(DM.ModelRestored(fIDModel)) then
    begin
      edtBarcode.Text := '';
      cmbModel.LookUpValue := '';
      exit;
    end;
  end
  else
    fIDModel := MyquPreSaleItem.FieldByName('ModelID').AsInteger;

  DM.fPOS.GetQty(fIDModel, DM.fStore.IDStoreSale, fOnHand, fOnPreSale, fOnPrePurchase, fOnAvailable);

  //Pego o case qty, que será utlizado para validar embalagem na venda;
  if ( cmbModel.GetFieldByName('CaseQty') <> null ) then
      FModelCaseQty := cmbModel.GetFieldByName('CaseQty');

  fVerifyQty := cmbModel.GetFieldByName('NotVerifyQty');
  if fVerifyQty <> Null then
    fNotVerifyQty := StrToBoolDef(fVerifyQty, False)
  else
    fNotVerifyQty := False;

  if IsItemInc then
  begin
    if HasPriceTable then
    begin
      if not Assigned(FFrmChoosePrice) then
        FFrmChoosePrice := TFrmChoosePrice.Create(Self);

      if Assigned(FPriceTable) then
        FreeAndNil(FPriceTable);

      FPriceTable := FFrmChoosePrice.ChoosePrice(DM.fStore.ID, fIDModel);
      CostPrice := FPriceTable.CostPrice;
      SalePrice := FPriceTable.SalePrice;
      OriginalSalePrice := SalePrice;
      EditSalePrice.Text := MyFloatToStr(SalePrice, DM.FQtyDecimalFormat);
    end
    else
    begin
      // Pega o SalePrice da Stored Procedure, pois pode existir Special Price
      with spSalePrice do
      begin
        Parameters.ParambyName('@ModelID').Value        := StrToInt(cmbModel.LookUpValue);
        Parameters.ParambyName('@IDStore').Value        := DM.fStore.ID;
        Parameters.ParambyName('@IDCustomer').Value     := MyIDCliente;
        Parameters.ParambyName('@Discount').Value       := CustomerDiscount;
        Parameters.ParambyName('@SpecialPriceID').Value := MyquPreSaleValue.FieldByName('SpecialPriceID').AsInteger;
        ExecProc;

        fStoreCost := Parameters.ParambyName('@StoreCostPrice').Value;
        fStoreSell := Parameters.ParambyName('@StoreSalePrice').Value;
        fStoreAvg  := Parameters.ParambyName('@StoreAvgCost').Value;
        CustomerDiscount := Parameters.ParambyName('@Discount').Value;
        FAddKitItems := Parameters.ParambyName('@AddKitItems').Value;
        fPromotionPrice := Parameters.ParambyName('@PromotionPrice').Value;

        if DM.fStore.Franchase then
          SalePrice := fStoreSell
        else
        begin
          if (fStoreSell <> 0) then
            SalePrice := fStoreSell
          else
            SalePrice := Parameters.ParambyName('@SalePrice').Value;
        end;

        OriginalSalePrice := SalePrice;
        // Seta o valor do sale price
        try
          IsChangeSale := False;
          if  (fPromotionPrice < (SalePrice - CustomerDiscount)) and (fPromotionPrice <> 0) then
              EditSalePrice.Text := MyFloatToStr(fPromotionPrice, dm.FQtyDecimalFormat)
            else
            EditSalePrice.Text := MyFloatToStr((SalePrice - CustomerDiscount), dm.FQtyDecimalFormat);
        finally
          IsChangeSale := True;
        end;

        if DM.fStore.Franchase then
        begin
          CostPrice := fStoreCost;
          if fStoreAvg = 0 then
            AvgCost := fStoreCost
          else
            AvgCost := fStoreAvg;
        end
        else
        begin
          //utilizado para salvar o custo futuro
          if DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
            CostPrice := Parameters.ParambyName('@ReplacementCost').Value
          else
            CostPrice := Parameters.ParambyName('@CostPrice').Value;

          AvgCost := Parameters.ParambyName('@AvgCostPrice').Value;
        end;
      end;
    end;
  end;

  if (DM.fSystem.SrvParam[PARAM_MARKUPOVERCOST] or DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST]) then
    fCostValue := CostPrice
  else
  begin
    if AvgCost <> 0 then
      fCostValue := AvgCost
    else
      fCostValue := CostPrice;
    end;

  EditCostPrice.Text    := FloatToStrF(fCostValue, ffNumber, 20, DM.FQtyDecimal);
  EditOriginalSale.Text := FloatToStrF(SalePrice, ffNumber, 20, DM.FQtyDecimal);

  if IsItemInc then
    EditQtyChange(nil);

  if IsItemInc then
  begin
    if DM.fSystem.SrvParam[PARAM_FASTSALE] then
      btOKClick(nil)
    else
      if EditQty.CanFocus then
        EditQty.SetFocus;
    end
  else
  begin
    if EditQty.CanFocus then
      EditQty.SetFocus;
  end;

  //Abre os acessorios
  RefreshAccessory;

  //Abre as Garantias
  RefreshWarranty;

end;

procedure TFrmPreSaleItem.VerifyCommissions;
begin
  DM.fPOS.AddCommissionsList(MyPreInventMovID, SALE_PRESALE);
  if DM.fPOS.fCommisList.Count > 1 then
    ModifytoCommissions
  else if DM.fPOS.fCommisList.Count = 1 then
  begin
    cmbSalesPerson.LookUpValue := InttoStr(TSalesPerson(DM.fPOS.fCommisList.Objects[0]).IDPessoa);
    DM.fPOS.ClearCommissionList;
  end;
end;

procedure TFrmPreSaleItem.LoadEditValues(quantityAssigned: double);
var
  tempExtDiscount: extended;
  tempExtTotal: extended;
  tempUnit: Extended;
  bEmpty: boolean;
begin
  // Antonio M F Souza, Jan 09 2013
  if ( not newItemToAddInCashRegister ) then  begin
     cmbModel.LookUpValue  := MyquPreSaleItem.FieldByName('ModelID').AsString;
  end;

  EditCostPrice.Text := FloatToStrF(MyquPreSaleItem.FieldByName('CostPrice').AsFloat, ffNumber, 20, DM.FQtyDecimal);

  // Antonio M F Souza, December 26, 2012 - to fix detail x price break.
  OriginalSalePrice     := SalePrice;
  CostPrice             := MyquPreSaleItem.FieldByName('CostPrice').AsFloat;
  cmbDepartment.LookUpValue := IntToStr(FDepartment);

  VerifyCommissions;

  EditExchange.Text     := MyquPreSaleItem.FieldByName('ExchangeInvoice').AsString;

  EditOriginalSale.Text := formatFloat('#,##0.00##', salePrice);//FloatToStrF(SalePrice, ffNumber, 11, CountDecimalPlaces(salePrice));
//  showmessage('original ' + editOriginalSale.Text);

  { Begin Alex 09/16/2011 - Sale price should not change automatically at all }
  // Automaticamente troca o Total price
  // Antonio M F Souza November 26, 2012
  editSalePrice.DisplayFormat := getDisplayFormat(CountDecimalPlaces(salePrice));
  EditSalePrice.Text     := EditOriginalSale.Text;

  // Antonio M F Souza December 12, 2012 : unit discount <-> EditDiscount
  tempUnit := MyquPreSaleItem.FieldByName('UnitDiscount').AsFloat;
  EditDiscount.Text      := MyFloatToStr(tempUnit, getDisplayFormat(CountDecimalPlaces(tempUnit)));

  // Antonio M F Souza December 13 2012: Ext. Discount <-> EditTotalDiscount
  tempExtDiscount := MyquPreSaleItem.FieldByName('Discount').AsFloat;
  EditTotalDiscount.Text := MyFloatToStr( tempExtDiscount, getDisplayFormat(2));

  // Antonio M F Souza December 13 2012: Unit Total <-> EditEachTotal
  tempUnit := ( SalePrice - MyquPreSaleItem.FieldByName('Discount').AsFloat);
  EditEachTotal.Text := myFloatToStr(tempUnit, getDisplayFormat(countDecimalPlaces(tempUnit)));

  // Antonio M F Souza January 07 2013: Ext Total <-> EditTotal
  tempExtTotal := (salePrice * quantityAssigned) - tempExtDiscount;

 // Antonio M F Souza, December 14, 2012
  tempExtTotal := forceRoundInThirdPosition(tempExtTotal);
  editTotal.Text := myFloatToStr(tempExtTotal, getDisplayFormat(CountDecimalPlaces(2)));

  FManuallyDiscount      := MyStrToDouble( EditTotalDiscount.Text )

  { End Alex 09/16/2011                                                       }

end;

procedure TFrmPreSaleItem.EditQtyChange(Sender: TObject);
var
  IsKit, bEmpty: Boolean;
  iModelID: Integer;
  tempUnit, tempExtTotal, tempDiscount, tempTotalDiscount: Extended;
begin
  EditValue(True);

  if Trim(EditQty.Text) = '-' then
    Exit;

  if trim(editQty.Text) = '' then begin
     showMessage('Quantity can not be blank');
     editQty.Text := '0';
     exit; 
  end;

  // Testa se o user digitou qty negativa e vê se é manager
  if (MyStrToDouble(EditQty.Text) < 0) and (not Password.HasFuncRight(31)) then
  begin
    MsgBox(MSG_INF_NOT_REFUND_ITEM, vbOKOnly + vbInformation);
    Close;
    Exit;
  end;

  // Ve se vai mostrar o Invoice original da Exchange
  pnlExchange.Visible := (MyStrToDouble(EditQty.Text) < 0) and not (Password.HasFuncRight(5));

  if pnlExchange.visible then
    EditExchange.SetFocus;

  // Pega o Selling Price especial
  if (newItemToAddInCashRegister) and (cmbModel.LookUpValue <> '') then begin
    iModelID := StrToInt(cmbModel.LookUpValue);
  end
  else
    iModelID := MyquPreSaleItem.FieldByName('ModelID').AsInteger;
  SalePrice := DM.fPOS.GetKitPrice(iModelID, MyStrToDouble(EditQty.Text), OriginalSalePrice, bEmpty, MyIDPreSale, false, true);
  EditOriginalSale.Text := FloatToStrF(SalePrice, ffCurrency, 20, DM.FQtyDecimal);

  if (not bEmpty) then
  begin
    try
      IsChangeSale       := False;
      EditSalePrice.Text := MyFloatToStr((SalePrice - CustomerDiscount), dm.FQtyDecimalFormat);
    finally
      IsChangeSale       := True;
    end;
  end
  else if SalePrice <> MyStrToMoney(EditSalePrice.Text) then
    SalePrice := MyStrToMoney(EditSalePrice.Text);

  try
    IsChangeTotal  := False;
    quantityChangedInThisScreen := strToFloat(editQty.Text);
    LoadEditValues(quantityChangedInThisScreen);
  finally
    IsChangeTotal  := True;
  end;

end;

procedure TFrmPreSaleItem.EditTotalChange(Sender: TObject);
var
  Code: Integer;
  Value: Real;
begin
  if not IsChangeTotal then
    Exit;

  Val(EditTotal.Text, Value, Code);

  if Code <> 0 then
    Value := 0;

  IsChangeSale  := True;
end;

procedure TFrmPreSaleItem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //Antonio M F Souza 02.03.2011- call to inheritence.
  inherited;
  case Key of
    VK_F2: btSearch.Click;
    27: if Trim(cmbModel.Text) = '' then btCancel.click;
  end;
end;

procedure TFrmPreSaleItem.btShowCostClick(Sender: TObject);
begin
  editCostPrice.Visible := btShowCost.Down;
  lblCost.Visible := btShowCost.Down;
end;

procedure TFrmPreSaleItem.btSearchClick(Sender: TObject);
var
  R: integer;
begin
  with TFrmBarcodeSearch.Create(self) do
  begin
    R := Start(MOV_TYPE_SALE);

    if R <> -1 then
    begin
      cmbModel.LookUpValue := IntToStr(R);
      SelectModel;
    end;
    Free;
  end;
end;

procedure TFrmPreSaleItem.EditQtyKeyPress(Sender: TObject; var Key: Char);
begin
  Key := ValidateDouble(Key);
end;

procedure TFrmPreSaleItem.spHelpClick(Sender: TObject);
begin
  Application.HelpContext(1040);
end;

procedure TFrmPreSaleItem.editCostPriceChange(Sender: TObject);
begin
  EditValue(True);
end;

procedure TFrmPreSaleItem.cmbSalesPersonChange(Sender: TObject);
begin
  EditValue(True);
end;

procedure TFrmPreSaleItem.EditSalePriceKeyPress(Sender: TObject; var Key: Char);
begin
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmPreSaleItem.EditExchangeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnExchangeClick(self);
end;

procedure TFrmPreSaleItem.btnExchangeClick(Sender: TObject);
begin
  // open invoice
  if EditExchange.Text <> '' then
    if MyStrToInt(DM.DescCodigo(['IDInvoice'], [EditExchange.Text], 'Invoice', 'SaleCode')) = 0 then
      MsgBox(MSG_INF_INVOICE_NOT_FOND, vbOKOnly + vbInformation)
end;

procedure TFrmPreSaleItem.FormCreate(Sender: TObject);
begin
  inherited;
  EditSalePrice.DisplayFormat := DM.FQtyDecimalFormat;
  FSaleItem := TSaleItem.Create;

  SubQty.CreateSubList;
  SubInvAccessoty.CreateSubList;
  WarrantyModels.CreateSubList;

  if DM.IsFormsRestric(Self.Name) then
    btOK.Enabled := False;

  DM.imgSmall.GetBitmap(BTN18_CAMERA, btnPicture.Glyph);
  DM.imgSmall.GetBitmap(BTN18_LAMP, btShowCost.Glyph);
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btSearch.Glyph);
  DM.imgBTN.GetBitmap(BTN_USER, btSplit.Glyph);
  DM.imgSmall.GetBitmap(BTN18_LOCK, btUnlockPrice.Glyph);

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];


end;

procedure TFrmPreSaleItem.RefreshQty;
var
  MyIDModel: Integer;
begin
  if IsItemInc then
    MyIDModel := StrToIntDef(cmbModel.LookUpValue,0)
  else
    MyIDModel := MyquPreSaleItem.FieldByName('ModelID').AsInteger;

  SubQty.Param := 'IDModel='+IntToStr(MyIDModel)+';';
end;

procedure TFrmPreSaleItem.btnPictureClick(Sender: TObject);
begin
  inherited;
  if cmbModel.LookUpValue <> '' then
    with TFrmModelPicture.Create(Self) do
      Start(cmbModel.LookUpValue);
end;

procedure TFrmPreSaleItem.RefreshAccessory;
var
  MyIDModel: Integer;
begin
  if IsItemInc then
    MyIDModel := StrToIntDef(cmbModel.LookUpValue, 0)
  else
    MyIDModel := MyquPreSaleItem.FieldByName('ModelID').AsInteger;

  SubInvAccessoty.Param := 'IDModel=' + IntToStr(MyIDModel) + ';';
end;

procedure TFrmPreSaleItem.RefreshWarranty;
var
  MyIDModel: Integer;
  MyAmount: Currency;
begin
  if IsItemInc then
  begin
    MyIDModel := StrToIntDef(cmbModel.LookUpValue,0);
    MyAmount  := MyStrToMoney(EditSalePrice.Text);
    WarrantyModels.Param := 'IDModel=' + IntToStr(MyIDModel) + ';Amount=' + CurrToStr(MyAmount) + ';';
  end
  else
    WarrantyModels.Param := 'IDModel=0;Amount=0;'; //Alteracao nao exibe garantia
end;

procedure TFrmPreSaleItem.WarrantyModelsAfterParamChanged(Changes: String);
begin
  inherited;
  WarrantyModels.Visible := StrToBoolDef(ParseParam(Changes, 'Empty'), False);
  fHasWarranty           := StrToBoolDef(ParseParam(Changes, 'HasWarranty'), False);

  if WarrantyModels.Visible then
  begin
    Self.Height := 528;
    SubInvAccessoty.Top := WarrantyModels.Top + WarrantyModels.Height;
  end
  else
  begin
    Self.Height := 505;
    SubInvAccessoty.Top := WarrantyModels.Top;
  end;
end;

procedure TFrmPreSaleItem.AfterInsertItem;
var
  sValues, sSQL: String;
  fPreInvMovID, iError, fIDModel: Integer;
  fSalePrice, fCostPrice: Currency;
begin
  //Adiciono a garantia caso tenha
  sValues := WarrantyModels.GetSubListInfo(sValues);

  if (not fHasWarranty) or (sValues = '') then
    Exit;

  fIDModel   := StrToIntDef(ParseParam(sValues, 'IDModel'),0);
  fSalePrice := MyStrToMoney(ParseParam(sValues, 'SalePrice'));
  fCostPrice := MyStrToMoney(ParseParam(sValues, 'CostPrice'));

  DM.fPOS.AddHoldItem(MyIDCliente,
                      MyIDPreSale,
                      fIDModel,
                      DM.fStore.IDStoreSale,
                      1, //Qty
                      0, //Disocunt
                      fSalePrice,
                      fCostPrice,
                      DM.fUser.ID,
                      MyStrToInt(cmbSalesPerson.LookUpValue),
                      MyPreSaleDate,
                      Now,
                      False,
                      False,
                      0, //somente para troca
                      FDepartment,
                      iError,
                      fPreInvMovID);

  //Associo a Garantia no Model
  sSQL := 'UPDATE PreInventoryMov SET IDPreInventoryMovParent = ' +IntToStr(MyPreInventMovID) +
          ' WHERE IDPreInventoryMov = ' + IntToStr(fPreInvMovID);
  DM.RunSQL(sSQL);

  //Poll Display
  DM.PollDisplayAddItem(fPreInvMovID,
                        fIDModel,
                        MyquPreSaleItem.FieldByName('Model').AsString,
                        MyquPreSaleItem.FieldByName('Description').AsString,
                        1,
                        fSalePrice,
                        0);
end;

function TFrmPreSaleItem.ValidateFields: Boolean;
var
  Qty: Double;
begin
  Result := False;

  if Trim(EditQty.Text) = '-' then
  begin
    raise exception.create('Invalid Quantity');
    Exit;
  end;

  try
    StrToFloat(RetiraSepadorMilhar(editCostPrice.Text));
  except
    MsgBox(MSG_CRT_INVAL_COST_PRICE, vbCritical + vbOkOnly);
    Exit;
  end;

  Qty := MyStrToDouble(EditQty.Text);

  if Qty = 0 then
  begin
    EditQty.SetFocus;
    MsgBox(MSG_CRT_NO_QTY_EMPTY , vbOKOnly + vbCritical);
    Exit;
  end;

  if (Qty < 0) and (EditExchange.Text = '') then
  begin
    if not Password.HasFuncRight(5) then
    begin
      EditExchange.SetFocus;
      MsgBox(MSG_CRT_NO_INVOICE_NUM_EMPTY, vbOKOnly + vbCritical);
      Exit;
    end;
  end;

  if (cmbSalesPerson.LookUpValue = '') and pnlSalesPerson.Visible and not(HaveCommissions) then
  begin
    cmbSalesPerson.SetFocus;
    MsgBox(MSG_CRT_NO_SALESPERSON_EMPTY, vbOKOnly + vbCritical);
    Exit;
  end;

  if (TruncMoney(MyStrToMoney(EditTotal.Text), DM.FQtyDecimal) = 0) and not Password.HasFuncRight(3) then
  begin
    EditQty.SetFocus;
    MsgBox(MSG_INF_NOT_GIVE_GIFTS, vbOKOnly + vbInformation);
    Exit;
  end;

  //Antonio M F Souza 09.27.2011 - begin
  if ( not DM.fSystem.SrvParam[PARAM_FASTSALE] ) then begin

      if (cmbDepartment.LookUpValue = '') and cmbDepartment.Visible then
      begin
        cmbDepartment.SetFocus;
        MsgBox(MSG_INF_SELECT_DEPARTMENT , vbOKOnly + vbInformation);
        Exit;
      end;

  end
  else begin
      if ( FDepartmentId <> '' ) then
      begin
        cmbDepartment.LookUpValue := FDepartmentId;
        cmbDepartmentSelectItem(nil);
      end;
  end;
  //Antonio M F Souza 09.27.2011 - end

  if FModelCaseQty > 0 then
    if DM.fSystem.SrvParam[PARAM_VALIDATE_CASE_QTY_ON_HOLD] then
      if Frac(Qty / FModelCaseQty) <> 0 then
      begin
        MsgBox(MSG_INF_QTY_NOT_DIF_MULT_CASE, vbCritical + vbOKOnly);
        Exit;
      end;

  Result := True;
end;

procedure TFrmPreSaleItem.btDiscountClick(Sender: TObject);
var
  dReturnValue,
  SalePriceBeforeDiscount : Double;
  tempDiscount: Extended; // Antonio M F Souza November 27, 2012
  tempExtTotal: Extended; // Antonio M F Souza November 27, 2012
  tempTotalDiscount: Extended; // Antonio M F Souza November 27, 2012
  tempValue: Extended;
begin
  inherited;
  if (MyquPreSaleValue.FieldByName('InvoiceDiscount').AsCurrency > 0) and (not Password.HasFuncRight(74)) and (not IsItemInc) then
    MsgBox(MSG_INF_INVOICE_ALREADY_DISC, vbOKOnly + vbInformation)
  else

    with TFrmPreSaleItemDiscount.Create(Self) do begin

        SalePriceBeforeDiscount := MyStrToMoney(EditSalePrice.Text);

        dReturnValue := Start( MyStrToMoney( editSalePrice.Text ) );

        // Antonio M F Souza December 13 2012: Unit Discount <-> EditDiscount
        tempDiscount := SalePriceBeforeDiscount - dReturnValue;
        EditDiscount.Text      := MyFloatToStr( ( SalePriceBeforeDiscount - dReturnValue ), getDisplayFormat(CountDecimalPlaces(salePriceBeforeDiscount)) );

        // Antonio M F Souza December 13 2012: Unit Total <-> EditEachTotal.Text
        tempValue := salePriceBeforeDiscount - tempDiscount;
        EditEachTotal.Text     := MyFloatToStr(tempValue, getDisplayFormat(CountDecimalPlaces(tempValue)));

        // Antonio M F Souza December 13 2012: Ext Discount <-> EditTotalDiscount.Text
        tempTotalDiscount := strToFloat(editQty.Text) * tempDiscount;
        editTotalDiscount.Text := myFloatToStr(tempTotalDiscount);

        // Antonio M F Souza December 13 2012: Ext Total <-> EditTotal.Text
        tempExtTotal := ( salePrice * MyquPreSaleItem.FieldByName('Qty').AsFloat ) - tempTotalDiscount; 
        editTotal.Text := myFloatToStr(tempExtTotal, getDisplayFormat(CountDecimalPlaces(2)));

        FManuallyDiscount      := MyStrToDouble( EditTotalDiscount.Text )
    end;

end;

procedure TFrmPreSaleItem.btSplitClick(Sender: TObject);
var AppliAll : Boolean;
begin
  if not Password.HasFuncRight(63) then
  begin
   MsgBox(MSG_INF_NOT_MODIFY_COMMISSION, vbOKOnly + vbInformation);
   Exit;
  end;

  DM.fPOS.ClearCommissionList;
  ArrangeCommissionsList;

  with TFrmAddItemCommission.Create(Self) do
    Start(0, AppliAll);

  if DM.fPOS.fCommisList.Count > 1 then
    ModifytoCommissions
  else if DM.fPOS.fCommisList.Count = 1 then
  begin
    cmbSalesPerson.LookUpValue := IntToStr(TSalesPerson(DM.fPOS.fCommisList.Objects[0]).IDPessoa);
    EditValue(True);
    HaveCommissions := False;
    edtCommissions.Visible := HaveCommissions;
  end
  else
    ArrangeCommissionsList;
end;

procedure TFrmPreSaleItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  cmbDepartment.LookUpValue := '';
  DM.fPOS.ClearCommissionList;

  if SalesPerson <> Nil then
  begin
    SalesPerson := Nil;
    SalesPerson.Free;
  end;
end;

procedure TFrmPreSaleItem.ModifytoCommissions;
var
  i: Integer;
begin
  HaveCommissions := True;
  edtCommissions.Text := '';

  for i := 0 to  DM.fPOS.fCommisList.Count - 1 do
    edtCommissions.Text := edtCommissions.Text + DM.fPOS.fCommisList.Strings[i] + '; ';

  edtCommissions.Visible := HaveCommissions;
end;

procedure TFrmPreSaleItem.ArrangeCommissionsList;
begin
  if not HaveCommissions then
  begin
    SalesPerson := TSalesPerson.Create;
    SalesPerson.IDPessoa := StrtoInt(cmbSalesPerson.LookUpValue);
    SalesPerson.Pessoa   := cmbSalesPerson.Text;
    SalesPerson.Percent  := 100;
    DM.fPOS.fCommisList.AddObject(SalesPerson.Pessoa + ' - ' + FloattoStr(SalesPerson.Percent) + '%',SalesPerson);
  end
  else
    DM.fPOS.AddCommissionsList(MyPreInventMovID,SALE_PRESALE);
end;

procedure TFrmPreSaleItem.edtBarcodeEnter(Sender: TObject);
begin
  inherited;
  btOk.Default := False;
end;

procedure TFrmPreSaleItem.edtBarcodeExit(Sender: TObject);
begin
  inherited;
  btOk.Default := True;
end;

procedure TFrmPreSaleItem.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel: Integer;
begin
  inherited;
  with edtBarcode do
  begin
    if SearchResult then
    begin
      IDModel := GetFieldValue('IDModel');
      cmbModel.LookUpValue := IntToStr(IDModel);
      if GetFieldValue('CaseQty') > 1 then
        EditQty.Text := FloatToStr(GetFieldValue('CaseQty'))
      else
        EditQty.Text := '1';
      SelectModel;
    end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
  end;
end;

procedure TFrmPreSaleItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FSaleItem);

  if Assigned(FFrmChoosePrice) then
    FreeAndNil(FFrmChoosePrice);

  if Assigned(FFrmEnterMovDocumet) then
    FreeAndNil(FFrmEnterMovDocumet);

  if ( assigned(FListIdPreInventoryOnSameSale) ) then
     freeAndNil(FListIdPreInventoryOnSameSale);
end;

procedure TFrmPreSaleItem.RefreshDepartment;
var
  FilterValue: String;
  DepartmentCount: Integer;
begin


  if cmbModel.LookUpValue <> '' then
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Text := ' SELECT IDDepartment FROM Inv_ModelDepartment (NOLOCK) ' +
                ' WHERE ModelID = ' + cmbModel.LookUpValue + ' AND StoreID = ' + InttoStr(DM.fStore.IDStoreSale);
    Open;

    DepartmentCount := DM.quFreeSQL.RecordCount;

    if IsEmpty then
    begin
      if Active then
        Close;

      SQL.Clear;

      SQL.Text := ' SELECT T.IDDepartment FROM Model M (NOLOCK) JOIN TabGroup T (NOLOCK) ON (T.IDGroup = M.GroupID) ' +
                  ' WHERE M.IDModel = ' + cmbModel.LookUpValue;
      Open;

      DepartmentCount := 1;
    end;

    if not(IsEmpty) then
    begin
      {
      First;
      while not EOF do
      begin
        if FilterValue = '' then
          FilterValue := 'IDDepartment = ' + FieldByName('IDDepartment').AsString
        else
          FilterValue := FilterValue + ' or ' + 'IDDepartment = ' + FieldByName('IDDepartment').AsString;
        Next;
      end;
      }
      if DepartmentCount = 1 then
      begin
        cmbDepartment.LookUpValue := FieldByName('IDDepartment').AsString;
        cmbDepartmentSelectItem(nil);

        //Antonio M F Souza 09.27.2011 - begin
        FDepartmentId := FieldByName('IDDepartment').AsString;

        //Antonio M F Souza 09.27.2011 - end

      end
      else
        cmbDepartment.SpcWhereClause := FilterValue;
    end;

    Close;
  end;

  {
  if DepartmentCount <= 1 then
  begin
    cmbDepartment.Visible := false;
    lblDepartment.Visible := false;
  end
  else
  begin
    cmbDepartment.Visible := true;
    lblDepartment.Visible := true;
  end;
  }
end;

procedure TFrmPreSaleItem.cmbDepartmentSelectItem(Sender: TObject);
begin
  inherited;
  FDepartment := StrToInt(cmbDepartment.LookUpValue);
end;

procedure TFrmPreSaleItem.EditSalePriceCurrChange(Sender: TObject);
var
   Code  : Integer;
   Value : Real;
begin
  inherited;

  EditValue(True);

  if not IsChangeSale then
    Exit;

  Value := MyStrToMoney( EditSalePrice.Text );

  try

    IsChangeTotal  := False;

    SalePrice := MyStrToMoney( EditSalePrice.Text );

    { Alex 09/16/2011 - When changing value discount will be reset to zero and Each total }
    { will ben set to the sale price                                                      }
    EditDiscount.Text      := MyFloatToStr( 0 );
    EditTotalDiscount.Text := MyFloatToStr( 0 );

    EditEachTotal.Text     := MyFloatToStr( SalePrice, dm.FQtyDecimalFormat );
    EditTotal.Text         := MyFloatToStr( ( SalePrice * MyStrToFloat(EditQty.Text) ));

    FManuallyDiscount      := 0;

    //Recalculo a garantia com o timer
    //RefreshWarranty;
  finally
    IsChangeTotal := True;
  end;
end;

procedure TFrmPreSaleItem.EditSalePriceEnter(Sender: TObject);
begin
  inherited;
  EditSalePrice.SelectAll;
end;

procedure TFrmPreSaleItem.btUnlockPriceClick(Sender: TObject);
var
  iIDUser: Integer;
begin
  inherited;
  iIDUser := DM.fUser.ID;

  if Password.AquireAccess(75, MSG_CRT_NO_ACCESS, iIDUser, True) then
  begin
    EditSalePrice.ReadOnly := False;
    EditSalePrice.Color    := clWindow;
    bUnlockPrice           := True;
  end
  else
  begin
    EditSalePrice.ReadOnly    := True;
    EditSalePrice.ParentColor := True;
    bUnlockPrice              := False;
  end;

  btDiscount.Visible := bUnlockPrice and (not EditSalePrice.ReadOnly);
  DM.fUser.ID := iIDUser;
  
end;

procedure TFrmPreSaleItem.UpdateSalePriceControl;
begin
  // Controla o readonly do preço de venda
  if Password.HasFuncRight(75) then
  begin
    btUnlockPrice.Visible  := False;
    btDiscount.Left        := btUnlockPrice.Left;
    EditSalePrice.ReadOnly := False;
    EditSalePrice.Color    := clWindow;
    bUnlockPrice           := False;
  end
  else
  begin
    btUnlockPrice.Visible     := True;
    btDiscount.Left           := btUnlockPrice.Left + btUnlockPrice.Width;
    EditSalePrice.ReadOnly    := True;
    EditSalePrice.ParentColor := True;
    bUnlockPrice              := True;
  end;
end;

function TFrmPreSaleItem.HasPriceTable: Boolean;
var
  sIDGroup: String;
begin
  sIDGroup := DM.DescCodigo(['IDModel'], [cmbModel.LookUpValue], 'Model', 'GroupID');
  Result := DM.DescCodigo(['IDGroup'], [sIDGroup], 'TabGroup', 'UsePriceTable') = 'True';

  if Result then
    with DM.quFreeSQL do
    try
      if Active then
        Close;

      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('  COUNT(M.IDModel) Total');
      SQL.Add('FROM');
      SQL.Add('  Model M (NOLOCK) ');
      SQL.Add('  LEFT JOIN (SELECT IDModel FROM Inv_ModelPrice (NOLOCK) WHERE IDModel = :IMPIDModel) IMP ON (M.IDModel = IMP.IDModel)');
      SQL.Add('  LEFT JOIN (SELECT IDModel FROM Inv_StorePrice (NOLOCK) WHERE IDModel = :ISPIDModel) ISP ON (M.IDModel = ISP.IDModel)');
      SQL.Add('WHERE');
      SQL.Add('  IMP.IDModel IS NOT NULL');
      SQL.Add('  OR ISP.IDModel IS NOT NULL');

      Parameters.ParamByName('IMPIDModel').Value := cmbModel.LookUpValue;
      Parameters.ParamByName('ISPIDModel').Value := cmbModel.LookUpValue;
      Open;

      Result := FieldByName('Total').AsInteger > 0;
    finally
      Close;
    end;
end;

procedure TFrmPreSaleItem.SetDocument;
begin
  if not Assigned(FFrmEnterMovDocumet) then
    FFrmEnterMovDocumet := TFrmEnterMovDocumet.Create(Self);

  if FFrmEnterMovDocumet.Start then
  begin
    FSaleItem.IDDocumentType := FFrmEnterMovDocumet.IDDocumentType;
    FSaleItem.DocumentNumber := FFrmEnterMovDocumet.DocumentNumber;
  end;
end;

function TFrmPreSaleItem.NeedDocument: Boolean;
var
  sIDGroup: String;
begin
  sIDGroup := DM.DescCodigo(['IDModel'], [cmbModel.LookUpValue], 'Model', 'GroupID');
  Result := DM.DescCodigo(['IDGroup'], [sIDGroup], 'TabGroup', 'UseDocumentOnSale') = 'True';
end;

procedure TFrmPreSaleItem.GetMovDocument;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT IDDocumentType, DocumentNumber FROM Inv_MovDocument (NOLOCK) WHERE IDPreInventoryMov = :IDPreInventoryMov');
    Parameters.ParamByName('IDPreInventoryMov').Value := MyPreInventMovID;
    Open;

    if not IsEmpty then
    begin
      FSaleItem.IDDocumentType := FieldByName('IDDocumentType').Value;
      FSaleItem.DocumentNumber := FieldByName('DocumentNumber').Value;
    end;
  finally
    Close;
  end;
end;

procedure TFrmPreSaleItem.GetTablePrice;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT IDDescriptionPrice, IDVendor, SuggPrice FROM Inv_MovPrice (NOLOCK) WHERE IDPreInventoryMov = :IDPreInventoryMov');
    Parameters.ParamByName('IDPreInventoryMov').Value := MyPreInventMovID;
    Open;

    if not IsEmpty then
    begin
      if not Assigned(FPriceTable) then
        FPriceTable := TChoosedPrice.Create;

      FPriceTable.IDDescriptionPrice := FieldByName('IDDescriptionPrice').Value;
      FPriceTable.IDVendor := FieldByName('IDVendor').Value;
      FPriceTable.SuggPrice := FieldByName('SuggPrice').Value;
    end;
  finally
    Close;
  end;
end;

function TFrmPreSaleItem.ReturnIDUser: Integer;
begin

  Result := DM.fUser.ID;

  if DM.fSystem.SrvParam[PARAM_SALE_REPEAT_CUSTOMER_SALESPERSON] then
    if DM.fUser.IDUserCliente <> 0 then
      Result := DM.fUser.IDUserCliente;

end;

function TFrmPreSaleItem.ReturnIDComis: Integer;
begin

  Result := MyStrToInt(cmbSalesPerson.LookUpValue);

  if DM.fSystem.SrvParam[PARAM_SALE_REPEAT_CUSTOMER_SALESPERSON] then
    if DM.fUser.IDCommissionCliente <> 0 then
      Result := DM.fUser.IDCommissionCliente;

end;

function TFrmPreSaleItem.isVisiblePanelSalePerson: boolean;
begin
  result := Password.HasFuncRight(10) or
            ((DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE) and newItemToAddInCashRegister);
end;

function TFrmPreSaleItem.isVisiblePanelCostPrice: boolean;
begin
  result := password.HasFuncRight(36) or password.HasFuncRight(11);
end;

procedure TFrmPreSaleItem.treatCostPrice;
begin
  pnlCostPrice.Visible   := isVisiblePanelCostPrice;

  if Password.HasFuncRight(36) then
  begin
    editCostPrice.ReadOnly := False;
    editCostPrice.Color    := clWindow;
  end
  else
  begin
    editCostPrice.ReadOnly    := True;
    editCostPrice.ParentColor := True;
  end;
end;

procedure TFrmPreSaleItem.treatSalePerson(isNewItem: boolean);
begin
  pnlSalesPerson.Visible := isVisiblePanelSalePerson;

  if ( isNewItem ) then begin
    cmbSalesPerson.Enabled     := isNewItem;
    cmbSalesPerson.LookUpValue := '';

    if Assigned(DM.fPOS.fDefaultSalesPerson) and (DM.fPOS.fDefaultSalesPerson.Count > 0) then
    begin
      DM.fPOS.fCommisList.Assign(DM.fPOS.FDefaultSalesPerson);
      VerifyCommissions;
    end;
  end;

end;

procedure TFrmPreSaleItem.setScreenPosition;
begin
  Left := 100;
  Top  := 88;
end;

procedure TFrmPreSaleItem.treatPanelCostPrice;
begin

end;

procedure TFrmPreSaleItem.treatPanelSalePerson;
begin

end;

procedure TFrmPreSaleItem.treatQuantity(isNewItem: boolean);
begin
   EditQty.Enabled    := not (MyquPreSaleItem.FieldByName('Promo').AsBoolean);

   if DM.fSystem.SrvParam[PARAM_FASTSALE] then begin
      EditQty.Enabled := False;
   end
   else begin
      EditQty.Enabled := True;
    end;

   if EditQty.Enabled then
      EditQty.Color    := clWindow
   else
     EditQty.Color    := clBtnFace;

end;

procedure TFrmPreSaleItem.treatLookupModel(isNewItem: boolean);
begin
  if ( isNewItem ) then begin
    cmbModel.ReadOnly  := False;
    cmbModel.Color     := clWindow;
  end
  else begin
    cmbModel.readOnly := true;
    cmbModel.Color := clBtnFace;
  end;

end;

end.
