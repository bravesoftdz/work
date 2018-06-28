unit uFrmInvoiceRefund;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, Mask, DBCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, SuperComboADO, DBClient, Provider, mrBarCodeEdit, cxContainer,
  cxTextEdit, cxCurrencyEdit, clsInfoCashSale;

const
  TYPE_INVOICE_REFUND = 0;
  TYPE_ITEM_REFUND = 1;

type
  TFrmInvoiceRefund = class(TFrmParentAll)
    btnSave: TButton;
    quInvoice: TADOQuery;
    dsInvoice: TDataSource;
    lbInvoiceNumber: TLabel;
    Label19: TLabel;
    EditPreSaleDate: TDBEdit;
    lblInvoiceDate: TLabel;
    EditInvoiceDate: TDBEdit;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    cmdItemRepair: TADOCommand;
    cdsItemRepair: TClientDataSet;
    dsItemRepair: TDataSource;
    cdsItemRepairIDModel: TIntegerField;
    cdsItemRepairModel: TStringField;
    cdsItemRepairDescription: TStringField;
    cdsItemRepairQty: TFloatField;
    cdsItemRepairCostPrice: TCurrencyField;
    cdsItemRepairIDVendor: TIntegerField;
    cdsItemRepairVendor: TStringField;
    cdsItemRepairIDDefectType: TIntegerField;
    cdsItemRepairDefectType: TStringField;
    cdsItemRepairObs: TStringField;
    cdsItemRepairID: TIntegerField;
    cdsItemRepairIDInventoryMov: TIntegerField;
    cdsItemRepairRA: TStringField;
    quItemCommission: TADODataSet;
    quItemCommissionIDCommission: TIntegerField;
    quItemCommissionCommissionPercent: TBCDField;
    cdsInvoice: TClientDataSet;
    dspInvoice: TDataSetProvider;
    lbBarcode: TLabel;
    edtBarcode: TmrBarCodeEdit;
    quItem: TADOQuery;
    dspItem: TDataSetProvider;
    pnlDetail: TPanel;
    pnlInvoiceItems: TPanel;
    Panel4: TPanel;
    grdInvoiceItems: TcxGrid;
    grdInvoiceItemsDB: TcxGridDBTableView;
    grdInvoiceItemsDBAction: TcxGridDBColumn;
    grdInvoiceItemsDBRetorna: TcxGridDBColumn;
    grdInvoiceItemsDBModel: TcxGridDBColumn;
    grdInvoiceItemsDBDescription: TcxGridDBColumn;
    grdInvoiceItemsDBQty: TcxGridDBColumn;
    grdInvoiceItemsDBCostPrice: TcxGridDBColumn;
    grdInvoiceItemsDBSalePrice: TcxGridDBColumn;
    grdInvoiceItemsDBDiscount: TcxGridDBColumn;
    grdInvoiceItemsDBItemTotal: TcxGridDBColumn;
    grdInvoiceItemsLevel: TcxGridLevel;
    Panel6: TPanel;
    pnlModelConfig: TPanel;
    pnlRepair: TPanel;
    grdItemRepair: TcxGrid;
    grdItemRepairDB: TcxGridDBTableView;
    grdItemRepairDBModel: TcxGridDBColumn;
    grdItemRepairDBDescription: TcxGridDBColumn;
    grdItemRepairDBQty: TcxGridDBColumn;
    grdItemRepairDBCostPrice: TcxGridDBColumn;
    grdItemRepairDBIDVendor: TcxGridDBColumn;
    grdItemRepairDBRA: TcxGridDBColumn;
    grdItemRepairDBIDDefectType: TcxGridDBColumn;
    grdItemRepairDBObs: TcxGridDBColumn;
    grdItemRepairLevel: TcxGridLevel;
    pnlUpdate: TPanel;
    Label3: TLabel;
    lbDefeito: TLabel;
    scDefectType: TSuperComboADO;
    scVendor: TSuperComboADO;
    edtRA: TEdit;
    lbRA: TLabel;
    Label4: TLabel;
    memOBS: TMemo;
    btnUpdate: TBitBtn;
    btnRemove: TBitBtn;
    Panel2: TPanel;
    Shape5: TShape;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    dbedTax: TDBEdit;
    dbedOtherCost: TDBEdit;
    dbedSaleDiscount: TDBEdit;
    dbedItemDiscount: TDBEdit;
    dbedSubTotal: TDBEdit;
    lblItemDiscountSign: TLabel;
    lblSaleDiscountSign: TLabel;
    pnlSaleDiscount: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    pnlRefund: TPanel;
    btnCalcRefund: TBitBtn;
    pnlTotalRefund: TPanel;
    lblRefund: TLabel;
    curreditRefund: TcxCurrencyEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quInvoiceAfterOpen(DataSet: TDataSet);
    procedure btnSaveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure cdsInvoiceQtyChange(Sender: TField);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure grdInvoiceItemsDBActionPropertiesEditValueChanged(
      Sender: TObject);
    procedure quItemAfterOpen(DataSet: TDataSet);
    procedure btnRemoveClick(Sender: TObject);
    procedure grdInvoiceItemsDBRetornaPropertiesEditValueChanged(
      Sender: TObject);

    //amfsouza June 20, 2012 - Calculate Refund
    procedure btnCalcRefundClick(Sender: TObject);
    procedure cdsInvoiceAfterOpen(DataSet: TDataSet);
  private
    saleLevelDiscount: Currency;
    totalOnSale: Currency;
    totalValueItemsSelected: Currency;
    totalTaxSelected: Currency;

    infoCashSale: InfoCashSale;
    useCashSaleInfo: boolean;

    giveTotalCaption : String;
    giveNotTotalCaption: String;
    giveBackCaption: String;

    sActionRetrunSelf,
    sActionReturnVendor : String;
    FStartType : Integer;
    FExecuted : Boolean;
    FIDPreSale : Integer;
    FInvoiceRefund : String;
    FIDPreInvMov : Integer;

    fDepartment: Integer;

    //amfouza July 13, 2012
    procedure ShowRefund(pShowRefund: boolean = true);

    procedure AddTotalItemsSelected(pValue: Currency);
    procedure AddTotalTaxSelected(pValue: Currency);

    procedure selectInfoCashSale(pInvoiceNumber: Integer);
    procedure OpenInvoice;
    procedure CloseInvoice;
    procedure RefreshInvoice;
    procedure CreateItemRepair(IDPreInvMov : Integer);
    function AddInvoiceRefund : Boolean;
    function ValidateRepair : Boolean;
    function VerifyInvoiceQty: Boolean;
    procedure AddItemRepair;

    procedure OpenVendor;
    procedure CloseVendor;
    procedure OpenDefect;
    procedure CloseDefect;
  public
    //amfsouza June 16, 2012: added objInfoCashSale parameter
    function Start(IDPreSale : Integer; InvoiceRefund : String;
       var AIDRefund: Integer; var ARefundDate : TDateTime; pInfoCashSale: InfoCashSale = nil) : Integer;
    function StartItem(IDPreInvMov : Integer) : Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uMsgBox, uMsgConstant, cxImageComboBox;

{$R *.dfm}

{ TFrmInvoiceRefund }

function TFrmInvoiceRefund.StartItem(IDPreInvMov: Integer): Boolean;
begin

  FIDPreInvMov := IDPreInvMov;
  FStartType := TYPE_ITEM_REFUND;

  cdsInvoice.ProviderName := 'dspItem';
  RefreshInvoice;
  AddItemRepair;

  pnlInvoiceItems.Visible := False;
  edtBarcode.Visible := False;
  lbBarcode.Visible := False;
  DBEdit1.DataField := 'SaleCode';

  ShowModal;

  Result := FExecuted;

end;


function TFrmInvoiceRefund.Start(IDPreSale: Integer;
  InvoiceRefund: String; var AIDRefund: Integer; var ARefundDate : TDateTime; pInfoCashSale: InfoCashSale): Integer;
begin
  // amfsouza June 16, 2012 - ini
  useCashSaleInfo := false;
  pnlSaleDiscount.Visible := useCashSaleInfo;
  infoCashSale := pInfoCashSale;
  selectInfoCashSale(strToInt(InvoiceRefund));

  dbedSubTotal.Text     := FloatToStrF(infoCashSale.getSubtotal, ffNumber, 13, 2);
  dbedItemDiscount.Text := floatToStrF(infoCashSale.getItemDiscounts, ffNumber, 13, 2);
  dbedSaleDiscount.Text := floatToStrF(infoCashSale.getSaleDiscount, ffNumber, 13, 2);
  dbedOtherCost.Text    := floatToStrF(infoCashSale.getOtherCosts, ffNumber, 13, 2);
  dbedTax.Text          := floatToStrF(infoCashSale.getTax, ffNumber, 13, 2);

  if ( infoCashSale.getSaleDiscount > 0 ) then begin
     pnlSaleDiscount.visible := ( infoCashSale.getSaleDiscount > 0 );
     useCashSaleInfo := true;
  end;

  // amfsouza June 16, 2012 - end

  FStartType := TYPE_INVOICE_REFUND;
  FIDPreSale := IDPreSale;
  FInvoiceRefund := InvoiceRefund;

  scDefectType.ShowBtnUpdate := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  scDefectType.ShowBtnAddNew := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  cdsInvoice.ProviderName := 'dspInvoice';

  RefreshInvoice;

  ShowModal;

  AIDRefund   := cdsInvoice.fieldbyname('IDPreSale').AsInteger;
  ARefundDate := cdsInvoice.fieldByname('InvoiceDate').AsDateTime;

  if not FExecuted then
    Result := 0
  else
    Result := 1;

end;

procedure TFrmInvoiceRefund.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseVendor;
  CloseDefect;
  Action := caFree;
end;

procedure TFrmInvoiceRefund.CloseInvoice;
begin
  with cdsInvoice do
    if Active then
      Close;
end;

procedure TFrmInvoiceRefund.OpenInvoice;
begin

  with cdsInvoice do
    if not Active then
    begin
      FetchParams;
      if FStartType = TYPE_INVOICE_REFUND then
      begin
        Params.ParamByName('Invoice').Value := FInvoiceRefund;
        Params.ParamByName('IDStore').Value := DM.fStore.ID;
      end
      else
        Params.ParamByName('IDPreInventoryMov').Value := FIDPreInvMov;
      Open;
      totalOnSale := 0;
      while ( not cdsInvoice.Eof ) do begin
          totalOnSale := totalOnSale + cdsInvoice.fieldByName('ItemTotal').Value;
          cdsInvoice.Next;
      end;
    end;
end;

procedure TFrmInvoiceRefund.RefreshInvoice;
begin
  CloseInvoice;
  OpenInvoice;
end;

procedure TFrmInvoiceRefund.quInvoiceAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled := (quInvoice.RecordCount > 0);

{
  //amfsouza June 16, 2012
  rdbGiveTotal.Caption    := format(giveTotalCaption, [self.infoCashSale.getTotalDue]);
  rdbNotGiveTotal.Caption := format(giveNotTotalCaption, [(self.infoCashSale.getTotalDue - self.infoCashSale.getSaleDiscount)]);
  curredtRefund.Text      := floatToStrF(self.infoCashSale.getTotalDue, ffNumber, 13, 2);
}
  TNumericField(dataset.FieldByName('ItemTotal')).DisplayFormat := '#,##0.00';

end;

function TFrmInvoiceRefund.AddInvoiceRefund : Boolean;
var
  iError,
  iIDPreInventMov, iID : Integer;
begin

  Result := False;

  if not cdsItemRepair.IsEmpty then
    if not ValidateRepair then
       Exit;

  try

    DM.ADODBConnect.BeginTrans;

    with cdsInvoice do
    begin
      try
        DisableControls;
        First;
        while not EOF do
        begin
          if (FStartType = TYPE_INVOICE_REFUND) and cdsInvoice.fieldbyname('Retorno').Value then
          begin
            if cdsInvoice.fieldByName('Qty').Value > 0 then
            begin
              DM.fPOS.AddHoldItem(cdsInvoice.fieldByName('IDPessoa').AsInteger,
                                  FIDPreSale,
                                  cdsInvoice.fieldbyname('IDModel').AsInteger,
                                  DM.fStore.IDStoreSale,
                                  (cdsInvoice.fieldbyname('Qty').AsFloat * -1),
                                  (cdsInvoice.fieldbyname('Discount').AsCurrency * -1),
                                  cdsInvoice.fieldbyname('SalePrice').AsCurrency,
                                  cdsInvoice.fieldbyname('CostPrice').AsCurrency,
                                  DM.fUser.ID,
                                  DM.fUser.IDCommission,
                                  Now,
                                  Now,
                                  False,
                                  True,
                                  cdsInvoice.fieldbyname('PreInventoryMovID').Value,
                                  cdsInvoice.fieldbyname('IDDepartment').AsInteger,
                                  iError,
                                  iIDPreInventMov);

              //Add Hold Commission
              try

                if quItemCommission.Active then
                  quItemCommission.Close;
                quItemCommission.Parameters.ParamByName('IDInventoryMov').Value := cdsInvoice.fieldbyname('IDInventoryMov').AsInteger;
                quItemCommission.Open;

                if not quItemCommission.IsEmpty then
                begin
                  DM.RunSQL('DELETE FROM SaleItemCommission WHERE IDPreInventoryMov = ' + InttoStr(iIDPreInventMov) );
                  quItemCommission.First;
                  while not quItemCommission.Eof do
                  begin
                    DM.fPOS.AddItemCommission('NULL',
                                              IntToStr(iIDPreInventMov),
                                              quItemCommissionIDCommission.AsInteger,
                                              quItemCommissionCommissionPercent.AsFloat);
                    quItemCommission.Next;
                  end;
                end;

              finally
                quItemCommission.Close;
              end;

            end
            else
            begin
              MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbCritical + vbOkOnly);
              DM.ADODBConnect.RollbackTrans;
              Exit;
            end;
          end;

          //Enviar para reparo
          if cdsItemRepair.Active and (not cdsItemRepair.IsEmpty) then
            if cdsItemRepair.Locate('ID', cdsInvoice.fieldbyname('PreInventoryMovID').AsInteger,[]) then
            begin

              if (FStartType <> TYPE_INVOICE_REFUND) then
                iIDPreInventMov := cdsItemRepairID.AsInteger;

              with cmdItemRepair do
              begin
                Parameters.ParamByName('IDItemRepair').Value      := DM.GetNextID(MR_DEFECT_TYPE_ID);
                Parameters.ParamByName('IDPreInventoryMov').Value := iIDPreInventMov;
                Parameters.ParamByName('Obs').Value               := cdsItemRepairObs.AsString;
                Parameters.ParamByName('IDDefectType').Value      := cdsItemRepairIDDefectType.AsInteger;
                Parameters.ParamByName('RA').Value                := cdsItemRepairRA.AsString;
                Parameters.ParamByName('IDVendor').Value          := cdsItemRepairIDVendor.AsInteger;
                Execute;
              end;
            end;
          Next;
        end;
      finally
//        CalculateRefundByOption(cboDiscountType.ItemIndex, curredtRefund.Value);
        EnableControls;
      end;
   end;

   DM.ADODBConnect.CommitTrans;
  except
    DM.ADODBConnect.RollbackTrans;
    MsgBox(MSG_INF_ERROR, vbOKOnly + vbInformation);
    end;

 Result := True;

end;

procedure TFrmInvoiceRefund.btnSaveClick(Sender: TObject);
begin
  inherited;
  ShowRefund(false);
  // amfsouza June 20, 2012
  infoCashSale.setNewTotalDue(curreditRefund.value);
  infoCashSale.setSaleDiscount(saleLevelDiscount);

  if AddInvoiceRefund then
  begin
    FExecuted := True;
    Close;
  end;
  
end;

procedure TFrmInvoiceRefund.btCloseClick(Sender: TObject);
begin
  inherited;
  FExecuted := False;
end;

function TFrmInvoiceRefund.ValidateRepair: Boolean;
begin
  Result := False;

  with cdsItemRepair do
  begin
    if not Active then
       Exit;
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if FieldByName('IDVendor').AsInteger = 0 then
        begin
          Result := False;
          MsgBox(MSG_CRT_NO_VENDOR, vbOKOnly + vbInformation);
          Exit;
        end;

        if FieldByName('IDdefectType').AsInteger = 0 then
        begin
          Result := False;
          MsgBox(MSG_CRT_NO_EMPTY_DEFECT, vbOKOnly + vbInformation);
          Exit;
        end;


        Next;
      end;
    finally
      EnableControls;
      end;
  end;

  Result := True;

end;

procedure TFrmInvoiceRefund.CreateItemRepair(IDPreInvMov : Integer);
begin

  with cdsItemRepair do
  begin
    if not Active then
      CreateDataSet;

    if not Locate('ID', IDPreInvMov, []) then
      if cdsInvoice.fieldbyname('Retorno').Value then
      begin
        Append;
        FieldByName('ID').AsInteger             := IDPreInvMov;
        FieldByName('IDModel').AsInteger        := cdsInvoice.fieldbyname('IDModel').AsInteger;
        FieldByName('IDInventoryMov').AsInteger := cdsInvoice.fieldbyname('IDInventoryMov').AsInteger;
        FieldByName('IDVendor').AsInteger       := cdsInvoice.fieldbyname('IDVendor').AsInteger;
        FieldByName('Vendor').AsString          := cdsInvoice.fieldbyname('Vendor').AsString;
        FieldByName('Model').AsString           := cdsInvoice.fieldbyname('Model').AsString;
        FieldByName('Description').AsString     := cdsInvoice.fieldbyname('Description').AsString;
        FieldByName('Qty').AsFloat              := Abs(cdsInvoice.fieldbyname('Qty').AsFloat);
        FieldByName('CostPrice').AsCurrency     := cdsInvoice.fieldbyname('CostPrice').AsCurrency;
        Post;
      end;
  end;

end;

procedure TFrmInvoiceRefund.btnUpdateClick(Sender: TObject);
begin
  inherited;

  with cdsItemRepair do
    if Active and (not IsEmpty) then
    begin
      Edit;
      if scVendor.LookUpValue <> '' then
      begin
        FieldByName('IDVendor').AsInteger     := StrToInt(scVendor.LookUpValue);
        FieldByName('Vendor').AsString        := scVendor.Text;
      end;

      if scDefectType.LookUpValue <> '' then
      begin
        FieldByName('IDDefectType').AsInteger := StrToInt(scDefectType.LookUpValue);
        FieldByName('DefectType').AsString    := scDefectType.Text;
      end;

      if edtRA.Text <> '' then
        FieldByName('RA').AsString            := edtRA.Text;

      if memOBS.Text <> '' then
        FieldByName('Obs').AsString           := memOBS.Text;
      Post;
    end;
end;

procedure TFrmInvoiceRefund.cdsInvoiceQtyChange(Sender: TField);
begin
  inherited;
  if cdsInvoice.FieldByName('Qty').Value > cdsInvoice.FieldByName('Qty').OldValue then
  begin
     MsgBox(MSG_INF_WRONG_QTY, vbCritical + vbOKOnly);
     cdsInvoice.Cancel;
  end;
end;

procedure TFrmInvoiceRefund.FormShow(Sender: TObject);
begin
  inherited;
  if edtBarcode.CanFocus then
    edtBarcode.SetFocus;
  OpenVendor;
  OpenDefect;
end;

procedure TFrmInvoiceRefund.FormCreate(Sender: TObject);
begin
  inherited;
  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];

  case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sActionRetrunSelf   := 'Return to shelf';
           sActionReturnVendor := 'Return to vendor';
           end;

     LANG_PORTUGUESE :
           begin
           sActionRetrunSelf   := 'Retornar para revender';
           sActionReturnVendor := 'Retornar para fornecedor';
           end;

     LANG_SPANISH :
           begin
           sActionRetrunSelf   := 'Regresa a la tienda';
           sActionReturnVendor := 'Volver al Distribuidor';
           end;
   end;

  TcxImageComboBoxProperties(grdInvoiceItemsDBAction.Properties).Items[0].Description := sActionRetrunSelf;
  TcxImageComboBoxProperties(grdInvoiceItemsDBAction.Properties).Items[1].Description := sActionReturnVendor;

  giveTotalCaption := 'Refund Less Discount %n Back';
  giveNotTotalCaption := 'Refund With Discount give %n Back';
  giveBackCaption     := 'Refund Less';
end;

procedure TFrmInvoiceRefund.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel: Integer;
  bFound: Boolean;
begin
  inherited;
  with edtBarcode do
  begin
    if SearchResult then
    begin
      bFound := False;
      IDModel := GetFieldValue('IDModel');
      cdsInvoice.First;
      while not cdsInvoice.Eof do
      begin
        if (IDModel = cdsInvoice.fieldbyname('IDModel').Value) and (not cdsInvoice.fieldbyname('Retorno').Value) then
        begin
          cdsInvoice.Edit;
          cdsInvoice.fieldbyname('Retorno').Value := True;
          cdsInvoice.Post;
          bFound := True;
          Break;
        end;
        cdsInvoice.Next;
      end;

      if not bFound then
        MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
    end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
  end;

  edtBarcode.Clear;
end;

function TFrmInvoiceRefund.VerifyInvoiceQty: Boolean;
begin
  Result := True;

  with cdsInvoice do
    if FieldByName('Retorno').AsBoolean then
      Result := (FieldByName('Qty').AsFloat > 0);

end;

procedure TFrmInvoiceRefund.grdInvoiceItemsDBActionPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  cdsInvoice.Edit;
  cdsInvoice.fieldbyname('Retorno').AsBoolean := True;

  if not VerifyInvoiceQty then
  begin
    MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbCritical + vbOkOnly);
    Exit;
  end;

  CreateItemRepair(cdsInvoice.fieldbyname('PreInventoryMovID').AsInteger);

end;


procedure TFrmInvoiceRefund.quItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled := (quItem.RecordCount > 0);
end;

procedure TFrmInvoiceRefund.btnRemoveClick(Sender: TObject);
begin
  inherited;
  with cdsItemRepair do
    if Active and (not IsEmpty) then
    begin
      Edit;
      Delete;
    end;
end;

procedure TFrmInvoiceRefund.AddItemRepair;
begin
  with cdsInvoice do
    if Active and (not IsEmpty) then
    begin
      Edit;
      cdsInvoice.FieldByName('Action').AsInteger := 1;
      cdsInvoice.fieldbyname('Retorno').AsBoolean := True;
      Post;
      CreateItemRepair(FIDPreInvMov);
    end;

end;

procedure TFrmInvoiceRefund.CloseVendor;
begin
  DM.LookUpFornecedor.Close;
end;

procedure TFrmInvoiceRefund.OpenVendor;
begin
  DM.LookUpFornecedor.Open;
end;

procedure TFrmInvoiceRefund.CloseDefect;
begin
  DM.LookUpDefectType.Close;
end;

procedure TFrmInvoiceRefund.OpenDefect;
begin
  DM.LookUpDefectType.Open;
end;


procedure TFrmInvoiceRefund.selectInfoCashSale(pInvoiceNumber: Integer);
var
  qry: TADOQuery;
  totalDue: Currency;
begin
  try
    try
      qry := TADOQuery.Create(nil);
      qry.Connection := dm.ADODBConnect;
      qry.sql.add('select SubTotal, ItemDiscount, InvoiceDiscount, ');
      qry.sql.add(' AditionalExpenses, Tax, TotalDiscount');
      qry.sql.add('from Invoice where InvoiceCode = :invoicecode');
      qry.Parameters.ParamByName('invoicecode').Value := pInvoiceNumber;
      qry.Open;

      totalDue := 0;

      if ( not qry.IsEmpty ) then begin
         infoCashSale.setSubtotal(qry.fieldByName('SubTotal').Value);
         infoCashSale.setItemDiscounts(qry.fieldByName('ItemDiscount').Value);
         infoCashSale.setSaleDiscount(qry.fieldByName('InvoiceDiscount').Value);
         infoCashSale.setOtherCosts(qry.fieldByName('AditionalExpenses').Value);
         infoCashSale.setTax(qry.fieldByName('Tax').Value);
         infoCashSale.setTotalSaved(qry.fieldByName('TotalDiscount').Value);

         totalDue := qry.fieldByName('SubTotal').Value -
           (qry.fieldByName('ItemDiscount').Value +
            qry.fieldByName('InvoiceDiscount').Value) +
            qry.fieldByName('AditionalExpenses').Value +
            qry.fieldByName('Tax').Value;

         infoCashSale.setTotalDue(totalDue);
      end;

    except
       on e: Exception do
        raise Exception.Create('select error in Invoice: ' + e.Message);
    end;
  finally
    freeAndNil(qry);
  end;

end;

procedure TFrmInvoiceRefund.AddTotalItemsSelected(pValue: Currency);
begin
  totalValueItemsSelected := totalValueItemsSelected + pValue;
end;

procedure TFrmInvoiceRefund.grdInvoiceItemsDBRetornaPropertiesEditValueChanged(
  Sender: TObject);
var
  return: boolean;
begin
  inherited;
  pnlTotalRefund.Visible := false;
end;

procedure TFrmInvoiceRefund.btnCalcRefundClick(Sender: TObject);
begin
   ShowRefund(true);
end;

procedure TFrmInvoiceRefund.AddTotalTaxSelected(pValue: Currency);
begin
   totalTaxSelected := totalTaxSelected + pValue;
end;

procedure TFrmInvoiceRefund.ShowRefund(pShowRefund: boolean = true);
var
  return: boolean;
  hasSelected: boolean;
  taxSelected: Currency;
  totalSaleItem: Currency;
begin
  inherited;
  curreditRefund.Value    := 0;
  totalValueItemsSelected := 0;
  totalTaxSelected        := 0;
  saleLevelDiscount       := 0;

  hasSelected := false;
  cdsInvoice.First;
  while ( not cdsInvoice.Eof ) do begin
      return := cdsInvoice.FieldByName('retorno').AsBoolean;

      if ( return) then begin
         totalSaleItem := ( cdsInvoice.fieldByName('SalePrice').Value *
                            cdsInvoice.fieldByName('Qty').Value ) -
                            cdsInvoice.fieldByName('Discount').Value;
         AddTotalItemsSelected(totalSaleItem);

         if ( cdsInvoice.ProviderName = 'dspInvoice' ) then begin
             taxSelected := ( (cdsInvoice.fieldByName('SalePrice').Value *
                              cdsInvoice.fieldByName('Qty').Value) -
                             cdsInvoice.fieldByName('Discount').Value) *
                             cdsInvoice.fieldByName('SalesTax').Value;
             AddTotalTaxSelected(taxSelected);
             hasSelected := true;
         end;
      end;
      cdsInvoice.Next;
  end;

  if ( hasSelected ) then begin
      saleLevelDiscount := infoCashSale.getSaleDiscount * (totalValueItemsSelected) / totalOnSale;

      curreditRefund.Value := ((-1)* totalValueItemsSelected ) +
                              saleLevelDiscount - (totalTaxSelected);
      if ( pShowRefund ) then
         pnlTotalRefund.Visible := true;
  end;
end;

procedure TFrmInvoiceRefund.cdsInvoiceAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dataset.fieldbyname('action').ReadOnly := false;
  dataset.fieldbyname('retorno').ReadOnly := false;
  dataset.fieldbyname('ItemTotal').ReadOnly := true;
end;

end.

