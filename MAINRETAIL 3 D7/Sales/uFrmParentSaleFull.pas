unit uFrmParentSaleFull;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentSales, cxClasses, cxStyles, cxGridTableView, DB,
  ADODB, siComp, siLangRT, uFrmPaymentReceive, clsInfoCashSale, ufrmSearchCustomer;

type
  TFrmParentSaleFull = class(TFrmParentSales)
    quTestSerialNumber: TADODataSet;
    procedure OnProcesseSaleClick(Sender: TObject);
    procedure OnProcesseCloseSaleClick(Sender: TObject);
    procedure OnShowPaymentsClick(Sender : TObject);
    procedure OnHoldPrintClick(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPaymentChange: Double;
    FIsPaymentProcessed: Boolean;
    procedure setPaymentProcessed(arg_isProcessed: Boolean);
    function GetCustomerSelect(): integer;
  protected
    //amfsouza 03.18.2011 - could be Onhold button or quote button.
    FOnHoldSigned: boolean;
    FrmPaymentReceive : TFrmPaymentReceive;

    function ValidatePayment : Boolean; virtual;
    function ProcessPayment(CloseSale : Boolean) : Boolean;
    function FindInvoiceRefund(InvoiceNum : String) : Boolean; overload;
    function findInvoiceRefund(arg_IdPreInventoryMov: Integer): Boolean; overload;

    procedure SetSerialNumber(qty_typed: Integer = 0; arg_idpreinvmov: Integer = 0);
    procedure SetCustomer(AIDCustomer: Integer);

    function ReceivePayment(PrintReceipt : Boolean) : Boolean;
    procedure AfterReceivePayment(CloseSale : Boolean; pInfoCashSale: InfoCashSale = nil ); virtual;
    procedure BeforeReceive; virtual;
    procedure AfterReceive; virtual;

    procedure CallPuppyTracker(refund: Boolean = false);

    procedure DisplayCustomer; virtual;
    procedure DisplayPetSKU; virtual;
    function ValidatePuppyTrackerItems : Boolean; virtual;
    function IsPaymentProcessed: Boolean;

  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uMsgConstant, uDM, uSystemConst, uInvoicePayment,
     uPrintReceipt, uFrmInvoiceRefund, uHandleError, uFrmHistoryManage, MRPuppyIntegrationCls;


{$R *.dfm}

{ TFrmParentSaleFull }

procedure TFrmParentSaleFull.AfterReceive;
begin
  //
end;

procedure TFrmParentSaleFull.AfterReceivePayment(CloseSale : Boolean; pInfoCashSale: InfoCashSale);
begin
  DM.FTraceControl.TraceIn('TFrmParentSaleFull.AfterReceivePayment');

  try
    // Impressão do recibo
    with TPrintReceipt.Create(Self) do
    try
      Start(FInvoiceInfo.IDPreSale, RECEIPT_TYPE_INVOICE, (FPaymentChange*-1), pInfoCashSale);
    finally
      objInfoCashSale.setItemDiscounts(0);
      objInfoCashSale.setSaleDiscount(0);
      objInfoCashSale.setNewTotalDue(0);
    end;
  except
    on E: Exception do
    begin
       DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmParentSaleFull');
       MsgBox(MSG_CRT_ERROR_PRINT, vbCritical + vbOkOnly);
    end;
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TFrmParentSaleFull.BeforeReceive;
begin
  //
end;

procedure TFrmParentSaleFull.CallPuppyTracker(refund: Boolean);
var
  PuppyIntegration: TMRPuppyIntegration;
  hasRefund: boolean;
begin


  DM.FTraceControl.TraceIn('TFrmParentSaleFull.CallPuppyTracker');
  try
      try

        if DM.SaleHavePuppyTrackerItem(FInvoiceInfo.IDPreSale) then
        begin
          // amfsouza 08.22.2011 - Export Puppy Sold to PuppyTracker
          PuppyIntegration := TMRPuppyIntegration.Create(dm.ADODBConnect);
//          hasRefund :=  ( FInvoiceInfo.IDPreSaleRefund > 0 );
          PuppyIntegration.PuppySoldToPuppyTracker(FInvoiceInfo.IDInvoice, FInvoiceInfo.IDPreSale, Refund);

          DM.SendPuppyInfo(FInvoiceInfo.IDInvoice);
          DM.SendPetCenterInfo(FInvoiceInfo.IDPreSale);
        end;

      except
        on E: Exception do
          DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmParentSaleFull');
      end;

      DM.FTraceControl.TraceOut;
  finally
     freeAndNil(PuppyIntegration);
  end;
end;

function TFrmParentSaleFull.FindInvoiceRefund(
  InvoiceNum: String): Boolean;
var
  iResult : Integer;
  iIDRefund: Integer;
  dRefundDate : TDatetime;
begin
   result := false;
   with TFrmInvoiceRefund.Create(Self) do
     if Start(FInvoiceInfo.IDPreSale, InvoiceNum, iIDRefund, dRefundDate, objInfoCashSale) <> 0 then
     begin
      FInvoiceInfo.IDPreSaleRefund := iIDRefund;
      FInvoiceInfo.RefundDate := dRefundDate;
      RefreshHold;
      result := true;
    end;
end;

procedure TFrmParentSaleFull.OnHoldPrintClick(Sender: TObject);
begin
  if not EmptyHold then
  begin
    SaveHoldInfo;
    CreateHoldNumber;
    //amfsouza 03.18.2011
    fOnHoldSigned := true;
    with TPrintReceipt.Create(Self) do
      Start(FInvoiceInfo.IDPreSale, RECEIPT_TYPE_HOLD);
  end;
end;

procedure TFrmParentSaleFull.OnProcesseCloseSaleClick(Sender: TObject);
begin
  // get the return of ProcessPayment
  setPaymentProcessed(ProcessPayment(True));
end;

procedure TFrmParentSaleFull.OnProcesseSaleClick(Sender: TObject);
begin
  (* amfsouza 09.26.2011-debug *)dm.FTraceControl.SaveTrace(dm.fUser.ID, 'Debug-Step: Proccess button pressed', '(PII):'+ self.ClassName);
  ProcessPayment(False);
end;

procedure TFrmParentSaleFull.OnShowPaymentsClick(Sender: TObject);
begin

  with TInvoicePayment.Create(Self) do
     Start(FInvoiceInfo.IDPreSale, FInvoiceInfo.Layaway, FInvoiceInfo.IsInvoice);

end;

function TFrmParentSaleFull.ProcessPayment(CloseSale : Boolean): Boolean;
begin

  DM.FTraceControl.TraceIn('TFrmParentSaleFull.ProcessPayment');

  try
    if ValidatePayment then
    begin
      CreateHoldNumber;

      SaveHoldInfo;

      RefreshInfo;

      BeforeReceive;

      if FInvoiceInfo.PreSaleType = SALE_CASHREG then
      begin
      //Codigo para o Invoice
      //True
      //Result
      //Exit

        if ReceivePayment(CloseSale) then
          AfterReceivePayment(CloseSale, objInfoCashSale);
      end;

      AfterReceive;

      Result := True;
    end
    else
      Result := False;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmParentSaleFull');
  end;

  DM.FTraceControl.TraceOut;
end;

function TFrmParentSaleFull.ReceivePayment(PrintReceipt : Boolean): Boolean;
begin
  DM.FTraceControl.TraceIn('TFrmParentSaleFull.ReceivePayment');

  try
    with FrmPaymentReceive do
      Result := Start(quPreSaleInfo,
                      spquPreSaleValue,
                      spquPreSaleItem,
                      FInvoiceInfo,
                      FFrmPromoControl,
                      FPaymentChange);
                      
      setPaymentProcessed(result);                
  except
    on E: Exception do begin
      showmessage('Fail after payment receive ' + e.message);
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmParentSaleFull');
    end;  
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TFrmParentSaleFull.SetSerialNumber(qty_typed: Integer; arg_idpreinvmov: Integer);
begin

  with DM.quFreeSQL do begin

       if Active then
          Close;
        SQL.Clear;
        SQL.Add('SELECT IDPreInventoryMov ');
        SQL.Add('FROM	PreInventoryMov PIM ');
        SQL.Add('LEFT OUTER JOIN PreSerialMov PSM ON (PIM.IDPreInventoryMov = PSM.PreInventoryMovID)');
        SQL.Add('JOIN Model M ON (PIM.ModelID = M.IDModel)');
        SQL.Add('JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
        SQL.Add('WHERE TG.SerialNumber = 1');
        SQL.Add('AND PIM.UserID = ' + IntToStr(DM.fUser.ID));
        SQL.Add('AND  PIM.DocumentID = ' + IntToStr(FInvoiceInfo.IDPreSale));
        SQL.Add('AND  PIM.IDPreInventoryMov = ' + IntToStr(arg_idpreinvmov));
        SQL.Add('GROUP BY IDPreInventoryMov, PIM.Qty ');
//        SQL.Add('HAVING COUNT(PSM.SerialNumber) < PIM.Qty');
        try
          try
          Open;
//          showmessage(sql.GetText);
          if ( not IsEmpty ) then begin
            dm.CreateCdsMercuryGift();
            AddSerialNumber(qty_typed, arg_idpreinvmov);
          end;
          
          except
              on e: Exception do begin
                 raise Exception.Create('Exception in setSerialNumber method '+ e.Message);
              end;
          end;
        finally
           Close;
        end;
  end;


end;

function TFrmParentSaleFull.ValidatePayment: Boolean;
begin
  DM.FTraceControl.TraceIn('TFrmParentSaleFull.ValidatePayment');

  Result := True;
  try
    if spquPreSaleItem.IsEmpty then
    begin
      MsgBox(MSG_CRT_NO_ITEM_PAY, vbOKOnly + vbInformation);
      Result := False;
      Exit;
    end;


    if (quPreSaleInfoIDCustomer.AsInteger = 1) and (SaleNeedCustomer) then
    begin
      MsgBox(MSG_CRT_NO_CUSTUMER, vbOKOnly + vbInformation);
      Result := False;
      DisplayCustomer;
      Exit;
    end;

    if (quPreSaleInfoIDCustomer.AsInteger = 1) and (FInvoiceInfo.Layaway) then
    begin
      MsgBox(MSG_CRT_NO_CUSTUMER, vbOKOnly + vbInformation);
      Result := False;
      Exit;
    end;

    if (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
      if quPreSaleInfoPuppyTracker.AsBoolean and (not ValidatePuppyTrackerItems) then
      begin
        MsgBox(Format(MSG_INF_SELECT_PET_SKU, [spquPreSaleItemModel.AsString]), vbOKOnly + vbInformation);
        Result := False;
        DisplayPetSKU;
        Exit;
      end;

(*

    if (FInvoiceInfo.PreSaleType = SALE_PRESALE) or (FInvoiceInfo.PreSaleType = SALE_CASHREG) then
    begin
      with quTestSerialNumber do
        if not Active then
        begin
          Parameters.ParamByName('IDUser').Value     := DM.fUser.ID;
          Parameters.ParamByName('DocumentID').Value := quPreSaleInfoIDPreSale.AsInteger;
          Open;
          try
            if not IsEmpty then
            begin
              MsgBox(MSG_CRT_NO_SERIAL_NUMBER, vbCritical + vbOkOnly);
              Result := False;
              Exit;
            end;
          finally
            Close;
          end;
        end;
    end;
*)
  except
    on E: Exception do begin
      showMessage('3 ' + e.Message);
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmParentSaleFull');
    end;  
  end;

  DM.FTraceControl.TraceOut;
end;

procedure TFrmParentSaleFull.FormCreate(Sender: TObject);
begin
  inherited;
  FrmPaymentReceive := TFrmPaymentReceive.Create(Self);
  FOnHoldSigned := false;
end;

procedure TFrmParentSaleFull.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FrmPaymentReceive);
end;

procedure TFrmParentSaleFull.SetCustomer(AIDCustomer: Integer);
begin
  if AIDCustomer <> -1 then begin
    quPreSaleInfo.Edit;
    quPreSaleInfoIDCustomer.AsInteger := AIDCustomer;
    quPreSaleInfo.Post;
    OnSelectCustomer(Self);

    {
    DM.fPOS.ApplyCustomerDiscount(FInvoiceInfo.IDPreSale, AIDCustomer, Now);

    if FApplyPromoOnSale and (not (AIDCustomer in [0,1])) then
    begin
      FFrmPromoControl.VerifyFrequentPromo(AIDCustomer, FInvoiceInfo.IDPreSale);
       ApplyPromoOnAllItems;
    end;
    }

    RefreshHold;

{
    if ( not dm.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] ) then begin
       if ( ExemptCustomerTax(AIDCustomer) ) then begin
           subApplyTaxExemption(true);
       end else begin
                subApplyTaxExemption(false);
                undoTaxExemption();
           end;

       refreshHold();
       refreshValue();
    end
 }
  end else begin
           // tratar aqui a selecao do cliente e a obtencao do ID.
           AIDCustomer := GetCustomerSelect();
      end;

  if ( not dm.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] ) then begin
     if ( ExemptCustomerTax(AIDCustomer) ) then begin
         subApplyTaxExemption(true);
     end else begin
              subApplyTaxExemption(false);
              undoTaxExemption();
         end;

     refreshHold();
     refreshValue();
  end;
end;


function TFrmParentSaleFull.GetCustomerSelect(): integer;
var
   iIDCustomer: integer;
begin
  with TFrmSearchCustomer.Create(Self) do
    iIDCustomer := Start;

{
  if (iIDCustomer <> -1) and (FDocumentInfo.IDCustomer <> iIDCustomer) then
    if FSaleReceive.GetPaymentTotalByType(PAYMENT_TYPE_CREDIT) > 0 then
      begin
        MsgBox(MSG_INF_DEL_CUSTOMER_CREDIT, vbInformation + vbOkOnly);
        Exit;
      end;
}

  if iIDCustomer <> -1 then
  begin
    quPreSaleInfo.Edit;
    quPreSaleInfo.FieldByName('IDCustomer').AsInteger := iIDCustomer;
    quPreSaleInfo.Post;
    //RefreshCustomer;
  end;

  result := iIdCustomer;

end;


procedure TFrmParentSaleFull.DisplayCustomer;
begin

end;

function TFrmParentSaleFull.ValidatePuppyTrackerItems: Boolean;
var
  FQuery : TADOQuery;
begin

  Result := False;

  try
    spquPreSaleItem.DisableControls;
    spquPreSaleItem.First;

    while not spquPreSaleItem.Eof do
    begin
      if spquPreSaleItemPuppyTracker.AsBoolean then
        try
          FQuery := TADOQuery.Create(Self);
          FQuery.Connection := DM.ADODBConnect;
          FQuery.SQL.Add('SELECT IDPetSale FROM Pet_PetSale WHERE IDPreInventoryMov = :IDPreInventoryMov');
          FQuery.Parameters.ParamByName('IDPreInventoryMov').Value := spquPreSaleItemIDInventoryMov.AsInteger;
          FQuery.Open;
          Result := not FQuery.IsEmpty;
          if not Result then
            Break;
        finally
          FQuery.Close;
          FreeAndNil(FQuery);
        end;
    spquPreSaleItem.Next;
    end;
  finally
    spquPreSaleItem.EnableControls;
  end;
  

end;

procedure TFrmParentSaleFull.DisplayPetSKU;
begin

end;

function TFrmParentSaleFull.FindInvoiceRefund(arg_IdPreInventoryMov: Integer): Boolean;
var
   frmInvoiceRefund: TFrmInvoiceRefund;
begin
   try
     frmInvoiceRefund := TfrmInvoiceRefund.Create(nil);
     if ( frmInvoiceRefund.StartItem(arg_IdPreInventoryMov) ) then begin
        FInvoiceInfo.IDPreSaleRefund := frmInvoiceRefund.getIdRefund;
        FInvoiceInfo.RefundDate := frmInvoiceRefund.getRefundDate;
        RefreshHold;
     end;
   finally
     freeAndNil(frmInvoiceRefund);
   end;
end;

function TFrmParentSaleFull.IsPaymentProcessed: Boolean;
begin
  result := FIsPaymentProcessed;
end;

procedure TFrmParentSaleFull.setPaymentProcessed(arg_isProcessed: Boolean);
begin
  FIsPaymentProcessed := arg_isProcessed;
end;


end.
