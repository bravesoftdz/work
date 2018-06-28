unit uFrmFastSale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, LblEffct, Db, ADODB, Spin, DBCtrls, MemoStr,
  DateBox, Mask, SuperComboADO, ComCtrls, uPreSaleItem, DBCGrids, siComp, siLangRT,
  PaiDeForms, Grids, DBGrids, Variants, SMDBGrid, uFrmPayPartial, uFrmParentSaleFast,
  cxClasses, cxStyles, cxGridTableView, uFrmParentSales, uSaleItem;

type
  TFrmFastSale = class(TFrmParentSaleFast)
    pnlBottom: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btCancel: TButton;
    btReceive: TBitBtn;
    pnlTop: TPanel;
    EspacamentoSuperior: TPanel;
    EEE: TPanel;
    pnlItem: TPanel;
    btRemoveItem: TSpeedButton;
    btDiscountItem: TSpeedButton;
    btSerial: TSpeedButton;
    lblTotalLine: TLabel;
    Label2: TLabel;
    lblUserName: TLabel;
    pnlPayment: TPanel;
    Label6: TLabel;
    Label17: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Label1: TLabel;
    Label7: TLabel;
    edtQty: TEdit;
    quBarCode: TADOQuery;
    edtBarcode: TEdit;
    quBarCodeIDModel: TIntegerField;
    quBarCodeVendorCost: TBCDField;
    quBarCodeSellingPrice: TBCDField;
    btAddItem: TSpeedButton;
    Label25: TLabel;
    edtZip: TDBEdit;
    Label24: TLabel;
    scMedia: TDBSuperComboADO;
    pnlPaymentType: TPanel;
    spPayCash: TSpeedButton;
    spPayVisa: TSpeedButton;
    spPayMaster: TSpeedButton;
    spPayAmerican: TSpeedButton;
    Label10: TLabel;
    cmbPaymentType: TSuperComboADO;
    pnlShowAuthorization: TPanel;
    Label12: TLabel;
    EditAuthorization: TEdit;
    pnlTotal: TPanel;
    Shape3: TShape;
    Shape1: TShape;
    Label13: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label16: TLabel;
    edtTotalTax: TDBEdit;
    edtSubTotal: TDBEdit;
    edtTotalInvoice: TDBEdit;
    pnlShowCash: TPanel;
    Shape4: TShape;
    lblReceived: TLabel;
    spLine: TShape;
    lblChange: TLabel;
    EditChange: TStaticText;
    EditReceived: TMemo;
    Label4: TLabel;
    scCustomer: TDBSuperComboADO;
    grdItems: TSMDBGrid;
    panel8: TPanel;
    Image3: TImage;
    imgTopIni: TImage;
    Image1: TImage;
    lblSubMenu: TLabelEffect;
    Label3: TLabel;
    lbPartialInfo: TLabel;
    quBarCodeAvgCost: TBCDField;
    quBarCodeReplacementCost: TBCDField;
    quSelectModel: TADOQuery;
    quSelectModelIDModel: TIntegerField;
    quSelectModelVendorCost: TBCDField;
    quSelectModelAvgCost: TBCDField;
    quSelectModelSellingPrice: TBCDField;
    quSelectModelReplacementCost: TBCDField;
    btnOpenHold: TSpeedButton;
    btnPartialPayment: TSpeedButton;
    quSelectModelStoreSellingPrice: TBCDField;
    quBarCodeStoreSellingPrice: TBCDField;
    quBarCodePackModelAddItems: TBooleanField;
    quSelectModelPackModelAddItems: TBooleanField;
    quBarCodeCaseQty: TFloatField;
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spquPreSaleItemAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbPaymentTypeSelectItem(Sender: TObject);
    procedure spPayCashClick(Sender: TObject);
    procedure spPayVisaClick(Sender: TObject);
    procedure spPayMasterClick(Sender: TObject);
    procedure spPayAmericanClick(Sender: TObject);
    procedure btReceiveClick(Sender: TObject);
    procedure dsPreSaleItemDataChange(Sender: TObject; Field: TField);
    procedure spHelpClick(Sender: TObject);
    procedure edtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarcodeEnter(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure scMediaSelectItem(Sender: TObject);
    procedure edtQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItemsDblClick(Sender: TObject);
    procedure EditReceivedChange(Sender: TObject);
    procedure EditReceivedExit(Sender: TObject);
    procedure EditReceivedKeyPress(Sender: TObject; var Key: Char);
    procedure btnPartialPaymentClick(Sender: TObject);
    procedure OnAddClick(Sender: TObject);
    procedure OnDetailClick(Sender: TObject);
    procedure OnRemoveClick(Sender: TObject);
    procedure scCustomerSelectItem(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  protected
    //Items on Hold
    fOnHand,
    fOnPreSale,
    fOnPrePurchase,
    fOnAvailable  : Double;

    fAddKitItems : Boolean;

    sHold,
    sExprSale     : String;

    MyIDModel       : Integer;

    MyDepartment    : Integer;

    MyCost,
    MySelling       : Currency;

    FrmPayPartial   : TFrmPayPartial;

    procedure PushError(ErrorType: Integer; sError: String);

    //Item SetUP
    procedure OnAfterNewInvoiceOnHold; virtual;
    procedure AtuPreSaleControls;
    procedure SelectBarCode(sBarcode:String);
    procedure SelectModel(IDModel:Integer);
    procedure AddSelectedModel(iIDModel, iDepartment:Integer; cCost, cSelling: Currency);
    procedure TestSelectedModel(Key: Word; Barcode:String);
    procedure NextItem; virtual;
    procedure SetSerialNumber(IDUser, IDPreSale, IDPreInvMov : Integer);

    function ValidSerailNumber:Boolean;
    function ValidQty:Boolean;

    //Payment SetUP
    procedure StartSingle;
    procedure UpdateCashTotal;
    procedure ReceiveHold;
    function ValidateReceive : Boolean;
    function ValidSinglePaymentType : Boolean;
    function AddPayment:Boolean;
    function DoPay:Boolean;
    function PrintDocument:Boolean;

    procedure NewInvoiceOnHold;
    procedure UpdateHoldcontrols;

    procedure CancelPreDatar;

    procedure LoadImages; override;
    procedure Translation; override;

    function TestBeforeRemove : Boolean; override;

    procedure OpenHold(IDPreSale : Integer); override;

    procedure RefreshTaxControls; override;

    function ProcessInvoiceBonus : Boolean;
  public
    procedure Start(PreSaleType, IDCashRegMov : Integer);
  end;

implementation

uses uDM, uPassword, uMsgBox, xBase, uPrintReceipt, uFrmSerialNumber,
     uAskManager, uMsgConstant, uNumericFunctions, uCharFunctions,
     uHandleError, uDMGlobal, uSystemConst, uQueryInventory,
     uFrmBarcodeSearch, uFrmJoinHold, uFileFunctions, uFrmPOSFunctions,
     uBonusBucks, uFrmAddKitItems;

{$R *.DFM}

procedure TFrmFastSale.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_ADD, btAddItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btDiscountItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemoveItem.Glyph);
end;

procedure TFrmFastSale.PushError(ErrorType: Integer; sError: String);
begin
   DM.SetError(ErrorType, Self.Name, sError);
end;


procedure TFrmFastSale.OnAfterNewInvoiceOnHold;
begin
  //Poll Display
  DM.PollDisplayCloseSale;
end;

procedure TFrmFastSale.NewInvoiceOnHold;
begin

  //Clear all Fields
  scCustomer.LookUpValue     := '';
  EditReceived.Text          := '';
  cmbPaymentType.LookUpValue := '';
  cmbPaymentTypeSelectItem(nil);

  NewHold;

  //Testa se o Hold esta aberto
  UpdateHoldcontrols;

  //Prepara Controles
  AtuPreSaleControls;

  if quPreSaleInfoSaleCode.AsString <> '' then
     lblSubMenu.Caption := sHold + quPreSaleInfoSaleCode.AsString
  else
     lblSubMenu.Caption := sExprSale;

  //Cancelar os pagamentos pre-datados caso haja mudanca
  CancelPreDatar;

  OnAfterNewInvoiceOnHold;

end;

procedure TFrmFastSale.Start(PreSaleType, IDCashRegMov : Integer);
begin
  FInvoiceInfo.PreSaleType   := PreSaleType;
  FInvoiceInfo.IDCashRegMov  := IDCashRegMov;

  //Create a new Invoice info
  NewInvoiceOnHold;

  ShowModal;
end;

function TFrmFastSale.ValidQty:Boolean;
var
  iQty, iQtyTest : Double;
begin

  Result := True;

  iQty := MyStrToFloat(edtQty.Text);

  if iQty = 0 then
     begin
     edtQty.SetFocus;
     Result := False;
     MsgBox(MSG_CRT_NO_QTY_EMPTY , vbOKOnly + vbCritical);
     end;


  //Verifica se pode vender Qty Negativa
  iQtyTest := fOnAvailable;

  if DM.fSystem.SrvParam[PARAM_INCLUDEPREPURCHASE] then
     iQtyTest := iQtyTest + fOnPrePurchase;

  if iQty > iQtyTest then
     if (not DM.fSystem.SrvParam[PARAM_SALEONNEGATIVE]) and not Password.HasFuncRight(8) then
        begin
        if MsgBox(MSG_QST_INV_NEGATIVE, vbYesNo + vbQuestion) = vbNo then
           Result := False;

        if Result then
           with TFrmAskManager.Create(Self) do
                if not Start('To complete this operation you must have Manager Authorization.') then
                   Result := False;
        end;

  if not Result then
     begin
     edtBarcode.Clear;
     edtBarcode.SetFocus;
     end;

end;

procedure TFrmFastSale.TestSelectedModel(Key: Word; Barcode:String);
begin

  if (key = 13) and (Trim(Barcode) <> '') and ValidQty then
     AddSelectedModel(MyIDModel, MyDepartment, MyCost, MySelling, );

end;

procedure TFrmFastSale.AddSelectedModel(iIDModel, iDepartment:Integer; cCost, cSelling: Currency);
var
  bEmpty : Boolean;
begin

  with FSaleItem do
  begin
    IDCustomer := quPreSaleInfoIDCustomer.AsInteger;
    IDPreSale := FInvoiceInfo.IDPreSale;
    IDModel := iIDModel;
    IDStore := DM.fStore.ID;
    Qty := MyStrToFloat(edtQty.Text);
    SellingPrice := DM.fPOS.GetKitPrice(iIDModel, MyStrToFloat(EdtQty.Text), cSelling, bEmpty);
    Discount := DM.fPOS.CalcCustomerDiscount(IDCustomer, IDModel, Qty, SellingPrice);
    CostPrice := cCost;
    IDUser := DM.fUser.ID;
    IDCommission := DM.fUser.IDCommission;
    PreSaleDate :=quPreSaleInfoPreSaleDate.AsDateTime;
    IDItemExchange := 0;
    Department := iDepartment;

    if fAddKitItems then
    begin
      with TFrmAddKitItems.Create(Self) do
        Start(FSaleItem);
      fAddKitItems := False;
    end
    else
      Add;
  end;

  //Refresh a list de items
  RefreshItem(FSaleItem.IDPreInventoryMov);

  //Update the Cash Total if needed
  UpdateCashTotal;

  //Poll Display
  DM.PollDisplayInvInfo(quPreSaleInfoSaleCode.AsString,
                        Trunc(quPreSaleInfoPreSaleDate.AsDateTime),
                        spquPreSaleValueAditionalExpenses.AsCurrency,
                        spquPreSaleValueTotalDiscount.AsCurrency,
                        spquPreSaleValueTax.AsCurrency,
                        spquPreSaleValueSubTotal.AsCurrency);

  DM.PollDisplayAddItem(FSaleItem.IDPreInventoryMov,
                        FSaleItem.IDModel,
                        spquPreSaleItemModel.AsString,
                        spquPreSaleItemDescription.AsString,
                        FSaleItem.Qty,
                        FSaleItem.SellingPrice,
                        FSaleItem.Discount);


  //Refresh o novo item
  NextItem;

  //Update the controls
  AtuPreSaleControls;

  //Testa se o item tem serial number
  SetSerialNumber(DM.fUser.ID, FInvoiceInfo.IDPreSale, FSaleItem.IDPreInventoryMov);
end;

function TFrmFastSale.ValidSerailNumber:Boolean;
begin
  Result := True;

  // Teste se todos os serial numbers foram preenchidos
  with DM.quFreeSQL do
     begin
     if Active then
        Close;
     SQL.Clear;
     SQL.Add('SELECT IDPreInventoryMov ');
     SQL.Add('FROM PreInventoryMov PIM ');
     SQL.Add('LEFT OUTER JOIN PreSerialMov PSM ON (PIM.IDPreInventoryMov = PSM.PreInventoryMovID)');
     SQL.Add('JOIN Model M ON (PIM.ModelID = M.IDModel)');
     SQL.Add('JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
     SQL.Add('WHERE TG.SerialNumber = 1');
     SQL.Add('AND PIM.UserID = ' + IntToStr(DM.fUser.ID));
     SQL.Add('AND  PIM.DocumentID = ' + IntToStr(FInvoiceInfo.IDPreSale));
     SQL.Add('GROUP BY IDPreInventoryMov, PIM.Qty ');
     SQL.Add('HAVING COUNT(PSM.SerialNumber) < ABS(PIM.Qty)');
     Open;
     if not IsEmpty then
       Result := False;
     Close;
    end;
end;

procedure TFrmFastSale.SetSerialNumber(IDUser, IDPreSale, IDPreInvMov : Integer);
var
  fFrmSerialNumber : TFrmSerialNumber;
  bResult : Boolean;
begin
  // Teste se todos os serial numbers foram preenchidos
  with DM.quFreeSQL do
       begin
       if Active then
          Close;
        SQL.Clear;
        SQL.Add('SELECT IDPreInventoryMov ');
        SQL.Add('FROM	PreInventoryMov PIM ');
        SQL.Add('LEFT OUTER JOIN PreSerialMov PSM ON (PIM.IDPreInventoryMov = PSM.PreInventoryMovID)');
        SQL.Add('JOIN Model M ON (PIM.ModelID = M.IDModel)');
        SQL.Add('JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
        SQL.Add('WHERE TG.SerialNumber = 1');
        SQL.Add('AND PIM.UserID = ' + IntToStr(IDUser));
        SQL.Add('AND  PIM.DocumentID = ' + IntToStr(IDPreSale));
        SQL.Add('AND  PIM.IDPreInventoryMov = ' + IntToStr(IDPreInvMov));
        SQL.Add('GROUP BY IDPreInventoryMov, PIM.Qty ');
        SQL.Add('HAVING COUNT(PSM.SerialNumber) < PIM.Qty');
        Open;
        bResult := IsEmpty;
        Close;
        end;

   if (not bResult) then
      begin
      fFrmSerialNumber := TFrmSerialNumber.Create(Self);
      fFrmSerialNumber.StartOnSales(SERIAL_HOLD,
                                    spquPreSaleItemModelID.AsInteger,
                                    DM.fStore.ID,
                                    spquPreSaleItemQty.AsFloat,
                                    IDPreInvMov);
      end;
end;


procedure TFrmFastSale.NextItem;
begin

   MyIDModel := 0;
   MyCost    := 0;
   MySelling := 0;

   edtQty.Text := '1';

   edtBarcode.Clear;
   if edtBarcode.CanFocus then
      edtBarcode.SetFocus;

end;

procedure TFrmFastSale.SelectBarCode(sBarcode:String);
begin

  if Trim(sBarcode) <> '' then
    with quBarcode do
      begin
        if Active then
          Close;
        Parameters.ParambyName('IDBarcode').Value := sBarcode;
        Parameters.ParambyName('IDStore').Value   := DM.fStore.ID;
        Open;
        if RecordCount = 0 then
           begin
           MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
           edtBarcode.Clear;
           edtBarcode.SetFocus;
           fAddKitItems := False;
           end
        else
           begin
           MyIDModel := quBarCodeIDModel.AsInteger;
           fAddKitItems := quBarCodePackModelAddItems.AsBoolean;

           if not(DM.ModelRestored(MyIDModel)) then
            exit;

           MyDepartment := GetModelDepartment(MyIDModel);

           if DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
              MyCost := quBarCodeReplacementCost.AsCurrency
           else
             begin
             if DM.fSystem.SrvParam[PARAM_MARKUPOVERCOST] then
                MyCost := quBarCodeVendorCost.AsCurrency
             else
                MyCost := quBarCodeAvgCost.AsCurrency;
             end;

           if quBarCodeStoreSellingPrice.AsCurrency <> 0 then
              MySelling := quBarCodeStoreSellingPrice.AsCurrency
           else
              MySelling := quBarCodeSellingPrice.AsCurrency;

           //Open Qty for Store
           DM.fPOS.GetQty(MyIDModel, DM.fStore.ID, fOnHand, fOnPreSale, fOnPrePurchase, fOnAvailable);

           if quBarCodeCaseQty.AsFloat > 1 then
             edtQty.Text := quBarCodeCaseQty.AsString
           else if edtQty.Text = '' then
             edtQty.Text := '1';

           //Adciona o item na nota
           TestSelectedModel(13, edtBarcode.Text);

           //Verifica se possou item de PuppyTracker
           if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
              (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
           begin
             quPreSaleInfo.Edit;
             quPreSaleInfoPuppyTracker.AsBoolean := DM.SaleHavePuppyTrackerItem(FInvoiceInfo.IDPreSale);
           end;

        end;
        Close;

      //cancelar os pagamentos pre-datados caso haja mudanca
      CancelPreDatar;
      end;
end;

procedure TFrmFastSale.ReceiveHold;
var
  bCanExec: Boolean;
  IDError : Integer;
  ErrorMsg : String;
begin

  bCanExec := False;

  if not ProcessInvoiceBonus then
  begin
    bCanExec := False;
    Exit;
  end;

  try

    DM.ADODBConnect.BeginTrans;

    //Adiciona a parcela
    bCanExec := AddPayment;

    //Faz o pagamento
    if bCanExec then
      bCanExec := DoPay;

    //Registra o Numero do Pedido
    if bCanExec then
      CreateHoldNumber;
      
  finally
    if bCanExec then
    begin
      DM.ADODBConnect.CommitTrans;

      //imprime o recept
      bCanExec := PrintDocument;

      //Send PuppyTracker info
      if DM.SaleHavePuppyTrackerItem(FInvoiceInfo.IDPreSale) then
      begin
         DM.SendPuppyInfo(FInvoiceInfo.IDInvoice);
         DM.SendPetCenterInfo(FInvoiceInfo.IDPreSale);
      end;

      if not bCanExec then
        MsgBox(MSG_CRT_ERROR_PRINT, vbCritical + vbOkOnly);

      ModalResult       := mrNone;
      btCancel.Enabled  := True;
      btReceive.Enabled := True;

      //Create a new Hold
      NewInvoiceOnHold;
      NextItem;
    end
    else
    begin
      DM.ADODBConnect.RollbackTrans;
      btCancel.Enabled  := True;
      btReceive.Enabled := True;
      if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      begin
        ErrorMsg := '';
        IDError := 0;
        DM.BonusVoid(DM.FBonusSync.BonusCode, IDError, ErrorMsg);
      end;
      MsgBox(MSG_INF_NOT_RECEIVE_HOLD, vbInformation + vbOkOnly);
      ModalResult := mrNone;
    end;
  end;
end;

function TFrmFastSale.PrintDocument:Boolean;
begin
      try

        Result := True;

        try
          //Self.Enabled := False;
          with TPrintReceipt.Create(Self) do
            Start(FInvoiceInfo.IDPreSale, RECEIPT_TYPE_HOLD);
          finally;
            //Self.Enabled := True;
            end;

      Except
        on E: Exception do
           begin
           PushError(CRITICAL_ERROR, 'FrmFastSale.PrintDocument.Exception' + #13#10 + E.Message);
           Result := False;
           end;
      end;

end;

function TFrmFastSale.AddPayment:Boolean;
  function GetAuthorization(sAuthorization: String): String;
  begin
    if sAuthorization = '' Then
      Result := Trim(EditAuthorization.Text)
    else
      Result := sAuthorization;
  end;
var
  Authorization : String;
  sValue : String;
  i : Integer;
begin

      Authorization := '';

      DM.OpenCashRegister(DRAW_KICK_TYPE_SALE);

      try

        Result := True;

        btReceive.Enabled := False;
        btCancel.Enabled  := False;

        if pnlShowAuthorization.Visible then
           Authorization := EditAuthorization.Text;

        //Adicionar pagamento pre-datados caso tenha
        If (FrmPayPartial <> nil) and FrmPayPartial.HasDeposit then
           begin
           for i := 0 to FrmPayPartial.tvPartialPay.Items.Count-1 do
               begin
                 if TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDCashRegMovClosed = -1 then
                   DM.fPOS.AddPayment(FInvoiceInfo.IDPreSale,
                                      DM.fStore.ID,
                                      DM.fUser.ID,
                                      quPreSaleInfoIDCustomer.AsInteger,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).IDPaymentType,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).IDCashRegMov,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).PreSaleDate,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).ExpireDate,
                                      IntToStr(i+1)+'/'+IntToStr(FrmPayPartial.tvPartialPay.Items.Count),
                                      GetAuthorization(TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Authorization),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Valor,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).NumeroDoc,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).DocCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).NomeCliente,
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Telefone,
                                      MyStrToInt(TPartialPay(FrmPayPartial.tvPartialPay.Items[i].Data).Banco),
                                      TPartialPay(FrmPayPartial.tvPartialPay.Items[I].Data).OBS,
                                      0,  // Payment place = Na Loja
                                      True); // IsPredatado
               end;
            end
        else
           DM.fPOS.AddPayment(FInvoiceInfo.IDPreSale,
                              DM.fStore.ID,
                              DM.fUser.ID,
                              quPreSaleInfoIDCustomer.AsInteger,
                              MyStrToInt(cmbPaymentType.LookUpValue),
                              FInvoiceInfo.IDCashRegMov,
                              Now,
                              Now,
                              '1/1',
                              Authorization,
                              spquPreSaleValue.FieldByName('TotalInvoice').AsFloat,
                              '', '',  '',  '', 0, '',
                               -1, // Sem payment place
                               False); // IsPreDatatado

      except
          on E: Exception do
             begin
             PushError(CRITICAL_ERROR, 'FrmFastSale.AddPayment.Exception' + #13#10 + E.Message);
             Result := False;
             end;
      end;

end;

function TFrmFastSale.DoPay:Boolean;
var
  cCash: Currency;
  IDInvoice: Integer;
begin

  Result := True;
  cCash  := 0;

  try

    if pnlShowCash.Visible then
      cCash := MyStrToMoney(EditReceived.Text);

    DM.fPOS.PreSalePay(FInvoiceInfo.IDPreSale,
                      quPreSaleInfo.FieldByName('IDTouristGroup').AsInteger,
                      quPreSaleInfo.FieldByName('OtherComissionID').AsInteger,
                      FInvoiceInfo.IDCashRegMov,
                      DM.fStore.ID,
                      Now, Now,
                      cCash,
                      DM.FBonusSync.BonusValue,
                      DM.FBonusSync.BonusCode,
                      IDInvoice);

    FInvoiceInfo.IDInvoice := IDInvoice;
    
  except
    on E: Exception do
    begin
      PushError(CRITICAL_ERROR, 'FrmFastSale.DoPay.Exception' + #13#10 + E.Message);
      Result := False;
    end;
  end;
end;

procedure TFrmFastSale.UpdateCashTotal;
begin
  if pnlShowCash.Visible then
  begin
    if MyStrToMoney(Trim(EditReceived.Text)) = 0 then
      EditReceived.Text  := FormatFloat('#,##0.00', spquPreSaleValue.FieldByName('TotalInvoice').AsFloat);

    EditChange.Caption := FloatToStrF(MyStrToMoney(Trim(EditReceived.Text)) - spquPreSaleValue.FieldByName('TotalInvoice').AsFloat, ffCurrency, 20, 2);
  end;
end;

function TFrmFastSale.ValidSinglePaymentType : Boolean;
begin
  Result := False;

  // Valida o recebimento single
  if cmbPaymentType.LookUpValue = '' then
  begin
    cmbPaymentType.SetFocus;
    MsgBox(MSG_CRT_NO_PAYMENT_TYPE, vbOKOnly + vbCritical);
    Exit;
  end;

  // Teste de Invoice com Special Price com Payment Type diferente de Cash
  if (quPreSaleInfo.FieldByName('MediaID').AsInteger = MEDIA_TYPE_GUIDE) and
     spquPreSaleValue.FieldByName('TaxIsent').AsBoolean and
     (MyStrToInt(cmbPaymentType.LookUpValue) <> PAY_TYPE_CASH) then
  begin
    if Password.HasFuncRight(18) then
    begin
      if MsgBox(MSG_QST_INVOICE_ONLY_CASH, vbYesNo + vbQuestion) = vbNo then
        Exit;
    end
    else
    begin
      cmbPaymentType.SetFocus;
      MsgBox(MSG_INF_INVOICE_REC_ONLY_CASH, vbOKOnly + vbInformation);
      Exit;
    end;
  end;

  Result := True;
end;

procedure TFrmFastSale.StartSingle;
begin
  //Satrt the Payment Type as default
  cmbPaymentType.LookUpValue := '';
  cmbPaymentTypeSelectItem(nil);
end;

procedure TFrmFastSale.AtuPreSaleControls;
var
  IsEnabled : Boolean;
  MyColor   : Integer;
begin

  IsEnabled := True;

  //Btn Receive the money
  btReceive.Enabled        := (not spquPreSaleItem.IsEmpty);

  btRemoveItem.Visible     := True;
  btDiscountItem.Visible   := True;

end;

procedure TFrmFastSale.btCancelClick(Sender: TObject);
begin

  Close;

end;

procedure TFrmFastSale.FormShow(Sender: TObject);
begin
  inherited;

  WindowState := wsNormal;

  lblUserName.Caption  := DM.fUser.UserName;

  NextItem;

  // Seta Panel so do Cash
  pnlShowCash.Visible := False;

  //Start the setup to the single payment
  StartSingle;

end;

procedure TFrmFastSale.FormCreate(Sender: TObject);
begin
  inherited;
  btnPartialPayment.Visible := DM.fSystem.SrvParam[PARAM_DISPLAY_PRE_DATADO];
end;

procedure TFrmFastSale.FormDestroy(Sender: TObject);
begin
  inherited;

  If FrmPayPartial <> nil then
     FreeAndNil(FrmPayPartial);

end;

procedure TFrmFastSale.spquPreSaleItemAfterOpen(DataSet: TDataSet);
begin

  lblTotalLine.Caption := IntToStr(spquPreSaleItem.RecordCount) + ' Item(s)';

end;

procedure TFrmFastSale.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of

       VK_F2  : begin //Add New Item
                if btAddItem.Enabled then
                   OnAddClick(nil);
                end;

       VK_F3  : begin //Edit Item
                if btDiscountItem.Enabled then
                   OndetailClick(nil);
                end;

       VK_F4  : begin //Remove Item
                if btRemoveItem.Enabled then
                   OnRemoveClick(nil);
                end;

       VK_F5  : begin //Enter Serial
                if btSerial.Enabled then
                   OnAddSerialNumClick(nil);
                end;

       VK_F7  : begin //Zip
                edtZip.SetFocus;
                end;

       VK_F8  : begin //Media
                scMedia.SetFocus;
                end;

       VK_F9  : begin //Customer
                scCustomer.SetFocus;
                end;

  end;

end;

procedure TFrmFastSale.cmbPaymentTypeSelectItem(Sender: TObject);
var
  iPayType : Integer;
begin

  // Mostra o panel de Cash se pagamento for do tipo cash
  if cmbPaymentType.LookUpValue <> '' then
  begin
    pnlShowCash.Visible := (StrToInt(cmbPaymentType.LookUpValue) = PAY_TYPE_CASH);
    iPayType := MyStrToInt(DM.DescCodigo(['IDMeioPag'], [cmbPaymentType.LookUpValue], 'MeioPag', 'Tipo'));
  end
  else
  begin
    pnlShowCash.Visible := False;
    iPayType := 0;
  end;

  case MyStrToInt(cmbPaymentType.LookUpValue) of
    PAY_TYPE_CASH     : begin
                        spPayCash.Down     := True;
                        //Update the Cash Total if needed
                        UpdateCashTotal;

                        EditReceived.SelectAll;
                        EditReceived.SetFocus;
                        end;

    PAY_TYPE_VISA     : spPayVisa.Down     := True;
    PAY_TYPE_AMERICAN : spPayAmerican.Down := True;
    PAY_TYPE_MASTER   : spPayMaster.Down   := True;
  else
    begin
      // nao seleciona
      spPayCash.Down     := False;
      spPayVisa.Down     := False;
      spPayAmerican.Down := False;
      spPayMaster.Down   := False;
    end;
  end; //end case


  if (iPayType = PAYMENT_TYPE_BONUSBUCK) then
  begin
    MsgBox(MSG_CRT_BONUS_NOT_APPLY_FASTSALE, vbOKOnly + vbCritical);
    cmbPaymentType.LookUpValue := '';
    Exit;
  end;

  //Test payment Type and minimun sale
  if (MyStrToInt(cmbPaymentType.LookUpValue) > 0) and not ValidSinglePaymentType then
     Exit;

  btnPartialPayment.Visible := (iPayType in [PAYMENT_TYPE_CARD, PAYMENT_TYPE_CHECK, PAYMENT_TYPE_OTHER]);

  if (iPayType in [PAYMENT_TYPE_CARD]) then
      begin
      pnlShowAuthorization.Visible := True;
      EditAuthorization.Text := '';
      EditAuthorization.SetFocus;
      end
  else
      pnlShowAuthorization.Visible := False;

  //cancelar os pagamentos pre-datados caso haja mudanca
  CancelPreDatar;

end;

procedure TFrmFastSale.spPayCashClick(Sender: TObject);
begin

  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_CASH);
  cmbPaymentTypeSelectItem(nil);

end;

procedure TFrmFastSale.spPayVisaClick(Sender: TObject);
begin

  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_VISA);
  cmbPaymentTypeSelectItem(nil);

end;

procedure TFrmFastSale.spPayMasterClick(Sender: TObject);
begin

  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_MASTER);
  cmbPaymentTypeSelectItem(nil);

end;

procedure TFrmFastSale.spPayAmericanClick(Sender: TObject);
begin

  cmbPaymentType.LookUpValue := IntToStr(PAY_TYPE_AMERICAN);
  cmbPaymentTypeSelectItem(nil);

end;

function TFrmFastSale.ValidateReceive : Boolean;
var
  MyTotCash : Currency;
begin
  Result := False;

  //There is no Item to Pay
  if spquPreSaleItem.IsEmpty then
  begin
    MsgBox(MSG_CRT_NO_ITEM_PAY, vbOKOnly + vbCritical);
    Exit;
  end;

  //Verica se todos os serais numbers foram preenchidos
  if not ValidSerailNumber then
  begin
    MsgBox(MSG_CRT_NO_SERIAL_NUMBER, vbCritical + vbOkOnly);
    Exit;
  end;

  //Verify the payment Type
  if not ValidSinglePaymentType then
    Exit;

  //Verify the Cred Car Authorization
  if pnlShowAuthorization.Visible and (EditAuthorization.Text = '') then
  begin
    EditAuthorization.SetFocus;
    MsgBox(MSG_CRT_NO_AUTHORIZANUMBER, vbOKOnly + vbCritical);
    Exit;
  end;

  MyTotCash := spquPreSaleValue.FieldByName('TotalInvoice').AsFloat;

  if pnlShowCash.Visible then
    if ((MyTotCash > 0) and (TruncMoney(MyTotCash - MyStrToMoney(EditReceived.Text), 2)>0)) then
    begin
      EditReceived.SelectAll;
      EditReceived.SetFocus;
      MsgBox(MSG_INF_TOTAL_SMALLER_PRE_SALE, vbOKOnly + vbInformation);
      Exit;
    end;

  //Atualisa o Pre Sale info. Tax exempt etc.
  if (quPreSaleInfo.State in dsEditModes) then
  begin
    quPreSaleInfo.UpdateRecord;
    quPreSaleInfo.Post;
  end;

  if (scCustomer.LookUpValue = '') and SaleNeedCustomer then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbOKOnly + vbInformation);
    if scCustomer.CanFocus then
      scCustomer.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmFastSale.btReceiveClick(Sender: TObject);
begin

   if ValidateReceive then
      ReceiveHold;

end;

procedure TFrmFastSale.dsPreSaleItemDataChange(Sender: TObject;
  Field: TField);
var
   IsEnabled : Boolean;
begin
  inherited;
  IsEnabled := not (spquPreSaleItem.Bof and spquPreSaleItem.Eof);
  btSerial.Enabled       := IsEnabled and spquPreSaleItemSerialNumber.AsBoolean;
  btRemoveItem.Enabled   := IsEnabled;
  btDiscountItem.Enabled := IsEnabled;
end;

procedure TFrmFastSale.spHelpClick(Sender: TObject);
begin

 Application.HelpContext(1020);

end;

procedure TFrmFastSale.edtBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 if (key = 13) then
    if (Trim(edtBarcode.Text) <> '') then
       SelectBarCode(edtBarcode.Text);

end;

procedure TFrmFastSale.edtBarcodeEnter(Sender: TObject);
begin
  btReceive.Default := False;
end;

procedure TFrmFastSale.edtBarcodeExit(Sender: TObject);
begin
  btReceive.Default := True;
end;

procedure TFrmFastSale.edtQtyKeyPress(Sender: TObject; var Key: Char);
begin

  Key := ValidatePositiveCurrency(Key);

end;

procedure TFrmFastSale.scMediaSelectItem(Sender: TObject);
var
  iIDCommis : Integer;
begin

 if scMedia.LookUpValue <> '' then
    begin
    // Testa se a media é RP, se for pequisa pelo IDComission
    iIDCommis := MyStrToInt(DM.DescCodigo(['IDMedia'], [scMedia.LookUpValue], 'Media', 'IDOtherCommission'));
    if iIDCommis = 0 then
       quPreSaleInfoOtherComissionID.Clear
    else
       quPreSaleInfoOtherComissionID.AsInteger := iIDCommis;
    end;

end;

procedure TFrmFastSale.edtQtyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = 13) then
    if (Trim(edtBarcode.Text) <> '') then
       SelectBarCode(edtBarcode.Text);
  //TestSelectedModel(Key, edtBarcode.Text);

end;

procedure TFrmFastSale.grdItemsDblClick(Sender: TObject);
begin

 if btDiscountItem.Enabled then
   OnDetailClick(nil);

end;

procedure TFrmFastSale.EditReceivedChange(Sender: TObject);
var
   MyValue : Currency;
begin
  // Muda o change automatico
  if Trim(EditReceived.Text) = '' then
     EditChange.Caption := FloatToStrF(0, ffCurrency, 20, 2);

   if spquPreSaleValue.Active then
      begin
      MyValue := MyStrToMoney(Trim(EditReceived.Text));
      EditChange.Caption := FloatToStrF(MyValue - spquPreSaleValue.FieldByName('TotalInvoice').AsFloat, ffCurrency, 20, 2);
      end;
end;

procedure TFrmFastSale.EditReceivedExit(Sender: TObject);
begin
   // Mostra o .00
   EditReceived.Text := FormatFloat('#,##0.00', MyStrToMoney(EditReceived.Text));
end;

procedure TFrmFastSale.EditReceivedKeyPress(Sender: TObject;
  var Key: Char);
begin

 Key := ValidatePositiveCurrency(Key);

end;

procedure TFrmFastSale.CancelPreDatar;
begin

  If FrmPayPartial <> nil then
     FrmPayPartial.ClearPaymentList;

  lbPartialInfo.Caption := '';
     
end;

procedure TFrmFastSale.btnPartialPaymentClick(Sender: TObject);
begin
  inherited;

  if spquPreSaleValueTotalInvoice.AsCurrency <= 0 then
     Exit;

  If FrmPayPartial = nil then
     FrmPayPartial := TFrmPayPartial.Create(Self);


  lbPartialInfo.Caption :=
    FrmPayPartial.Start(StrToInt(cmbPaymentType.LookUpValue),
                        MyStrToInt(scCustomer.LookUpValue),
                        FInvoiceInfo.IDPreSale,
                        FInvoiceInfo.IDCashRegMov,
                        spquPreSaleValueTotalInvoice.AsCurrency,
                        Date,
                        EditAuthorization.Text, -1, 0);
end;

procedure TFrmFastSale.SelectModel(IDModel: Integer);
begin

   if IDModel = -1 then
      Exit;

    with quSelectModel do
      begin
        if Active then
          Close;
        Parameters.ParambyName('IDModel').Value := IDModel;
        Parameters.ParambyName('IDStore').Value := DM.fStore.ID;
        Open;
        if RecordCount = 0 then
           MsgBox(MSG_EXC_SELECT_A_MODEL, vbCritical + vbOkOnly)
        else
           begin
           MyIDModel := quSelectModelIDModel.AsInteger;

           if not(DM.ModelRestored(MyIDModel)) then
            exit;

           MyDepartment := GetModelDepartment(MyIDModel);

           if DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST] then
              MyCost := quSelectModelReplacementCost.AsCurrency
           else
             begin
             if DM.fSystem.SrvParam[PARAM_MARKUPOVERCOST] then
                MyCost := quSelectModelVendorCost.AsCurrency
             else
                MyCost := quSelectModelAvgCost.AsCurrency;
             end;

           if quSelectModelStoreSellingPrice.AsCurrency <> 0 then
              MySelling := quSelectModelStoreSellingPrice.AsCurrency
           else
              MySelling := quSelectModelSellingPrice.AsCurrency;

           //Open Qty for Store
           DM.fPOS.GetQty(MyIDModel, DM.fStore.ID, fOnHand, fOnPreSale, fOnPrePurchase, fOnAvailable);

           if edtQty.CanFocus then
              edtQty.SetFocus;
           end;
        Close;

      //cancelar os pagamentos pre-datados caso haja mudanca
      CancelPreDatar;
      end;

end;

procedure TFrmFastSale.UpdateHoldcontrols;
var
  Action: TCloseAction;
begin

  //Se o hold estiver sendo usado, ele chama o evento onClose do form
  //OnClose - Fecha todas as Queries e atualza a qty OpenUser

  if FInvoiceInfo.HoldOnCashReg > 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    MsgBox(MSG_INF_HOLD_PAYING, vbOKOnly + vbInformation);
    FormClose(nil, Action);
    Exit;
  end;

  if FInvoiceInfo.HoldOnTerminal > 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    if (FInvoiceInfo.PreSaleType = SALE_CASHREG) then //foi aberto pelo caixa
    begin
      MsgBox(MSG_INF_HOLD_IS_LOCK, vbOKOnly + vbInformation);
      FormClose(nil, Action);
      Exit;
    end
    else //foi aberto por outro hold
      MsgBox(MSG_INF_HOLD_IS_USING, vbOKOnly + vbInformation);
    FInvoiceInfo.PreSaleType := SALE_PreSale;
  end;
  
end;


procedure TFrmFastSale.Translation;
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sHold     := 'Hold # ';
           sExprSale := 'Express Sale';
           end;

     LANG_PORTUGUESE :
           begin
           sHold     := 'Nº Nota ';
           sExprSale := 'Nova Venda';
           end;

     LANG_SPANISH :
           begin
           sHold     := 'Nº Boleta ';
           sExprSale := 'Nueva Venta';
           end;
   end;

end;

procedure TFrmFastSale.OnAddClick(Sender: TObject);
begin
  inherited;

  //Update the controls
  AtuPreSaleControls;

  //Update the Cash Total if needed
  UpdateCashTotal;

  if pnlShowCash.Visible then
     begin
     EditReceived.SelectAll;
     EditReceived.SetFocus;
     end
  else
     if pnlPaymentType.Visible then
        cmbPaymentType.SetFocus;

  //cancelar os pagamentos pre-datados caso haja mudanca
  CancelPreDatar;

end;

procedure TFrmFastSale.OnDetailClick(Sender: TObject);
begin
  inherited;

  //Update the Cash Total if needed
  UpdateCashTotal;

  if pnlShowCash.Visible then
     begin
     EditReceived.SelectAll;
     EditReceived.SetFocus;
     end
  else
     if pnlPaymentType.Visible then
        cmbPaymentType.SetFocus;

  //cancelar os pagamentos pre-datados caso haja mudanca
  CancelPreDatar;
  
end;

function TFrmFastSale.TestBeforeRemove: Boolean;
begin

  //Verificar se pode deletar Lay away
  if quPreSaleInfoLayaway.AsBoolean then
     if not Password.HasFuncRight(42) then
       begin
       MsgBox(MSG_INF_NOT_DEL_ITEMS_LAYAWAY, vbOKOnly + vbInformation);
       Exit;
       end;

  if (spquPreSaleItemIDComission.AsInteger <> DM.fUser.IDCommission) then
    begin
     if not Password.HasFuncRight(15) then
       begin
       MsgBox(MSG_INF_NOT_DELETE_ITEMS, vbOKOnly + vbInformation);
       Exit;
       end
    end;

  Result := Inherited TestBeforeRemove;
end;

procedure TFrmFastSale.OnRemoveClick(Sender: TObject);
begin
  inherited;

  //Update the controls
  AtuPreSaleControls;

  //Update the Cash Total if needed
  UpdateCashTotal;

  if pnlShowCash.Visible then
     begin
     EditReceived.SelectAll;
     EditReceived.SetFocus;
     end
  else
     if pnlPaymentType.Visible then
        cmbPaymentType.SetFocus;

  //cancelar os pagamentos pre-datados caso haja mudanca
  CancelPreDatar;


end;

procedure TFrmFastSale.OpenHold(IDPreSale : Integer);
begin
  inherited;

  //Testa se o Hold esta aberto
  UpdateHoldcontrols;

  //Prepara Controles
  AtuPreSaleControls;

  if quPreSaleInfoSaleCode.AsString <> '' then
     lblSubMenu.Caption := sHold + quPreSaleInfoSaleCode.AsString
  else
     lblSubMenu.Caption := sExprSale;

  //Cancelar os pagamentos pre-datados caso haja mudanca
  CancelPreDatar;

end;

procedure TFrmFastSale.RefreshTaxControls;
begin
  inherited;
  Label13.Visible     := False;
  edtTotalTax.Visible := False;
  Label20.Visible     := False;

  Label14.Top         := Label13.Top;
  edtSubTotal.Top     := edtTotalTax.Top;
  Label18.Top         := Label20.Top;
end;

procedure TFrmFastSale.scCustomerSelectItem(Sender: TObject);
begin
  inherited;
  if dsPreSaleInfo.State in dsEditModes then
  begin
    quPreSaleInfo.Post;
    quPreSaleInfo.Edit;
  end;

  OnSelectCustomer(Sender);
  RefreshHold;
end;

procedure TFrmFastSale.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  //Poll Display
  DM.PollDisplayCloseSale;
  
end;

function TFrmFastSale.ProcessInvoiceBonus: Boolean;
var
  BonusBucks: TBonusBucks;
  cDiscountValue, cTotalInvoice: Currency;
  BonusCode : String;
  IDError : Integer;
  ErrorMsg : String;
  sInvoiceNum : String;
begin
  DM.FTraceControl.TraceIn('TPreSaleReceive.ProcessInvoiceBonus');

  Result := True;
  try
      BonusCode := '';
      DM.FBonusSync.BonusCode := '';
      DM.FBonusSync.BonusValue := 0;

      if DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE] then
      try
        BonusBucks                  := TBonusBucks.Create(DM.ADODBConnect, DM.FBonusSync);
        BonusBucks.IDPreSaleCreated := quPreSaleInfo.FieldByName('IDPreSale').AsInteger;
        cDiscountValue              := BonusBucks.DiscountValue;
        sInvoiceNum                 := quPreSaleInfo.FieldByName('SaleCode').AsString;
        cTotalInvoice               := spquPreSaleValueTotalInvoice.AsFloat;

        if cDiscountValue > 0 then
          if not DM.BonusGenerate(cTotalInvoice, cDiscountValue, sInvoiceNum, Trunc(Now), BonusCode, IDError, ErrorMsg) then
          begin
            DM.FBonusSync.BonusValue := 0;
            if (MsgBox(MSG_QST_PROCESS_BONUS + ErrorMsg, vbYesNo + vbQuestion) = vbNo) then
            begin
              Result := False;
              Exit;
            end;
          end;

      finally
        FreeAndNil(BonusBucks);
      end;
  except
    on E: Exception do
    begin
      DM.FTraceControl.SetException(E.Message, 'TFrmInvoice.ProcessInvoiceBonus');
      Result := False;
    end;
  end;

  DM.FTraceControl.TraceOut;
  
end;

end.

