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
    quInvoiceIDPreSale: TIntegerField;
    quInvoicePreSaleDate: TDateTimeField;
    quInvoiceTotInvoice: TFloatField;
    quInvoicePessoaFirstName: TStringField;
    quInvoicePessoaLastName: TStringField;
    quInvoiceIDTouristGroup: TIntegerField;
    quInvoiceOtherComissionID: TIntegerField;
    quInvoicePessoa: TStringField;
    quInvoiceSaleCode: TStringField;
    quInvoiceIDPessoa: TIntegerField;
    quInvoiceNote: TStringField;
    dsInvoice: TDataSource;
    lbInvoiceNumber: TLabel;
    Label19: TLabel;
    EditPreSaleDate: TDBEdit;
    lblInvoiceDate: TLabel;
    EditInvoiceDate: TDBEdit;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    quInvoiceInvoiceDate: TDateTimeField;
    quInvoiceInvoiceCode: TStringField;
    DBEdit2: TDBEdit;
    quInvoiceQty: TFloatField;
    quInvoiceCostPrice: TBCDField;
    quInvoiceSalePrice: TBCDField;
    quInvoiceDiscount: TBCDField;
    quInvoiceModel: TStringField;
    quInvoiceDescription: TStringField;
    quInvoiceIDInventoryMov: TIntegerField;
    quInvoiceItemTotal: TFloatField;
    quInvoiceIDModel: TIntegerField;
    cmdItemRepair: TADOCommand;
    quInvoiceDateLastCost: TDateTimeField;
    quInvoiceLastCost: TBCDField;
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
    quInvoiceIDVendor: TIntegerField;
    quInvoiceVendor: TStringField;
    cdsItemRepairRA: TStringField;
    quInvoiceIDDepartment: TIntegerField;
    quInvoiceIDInvoice: TIntegerField;
    quItemCommission: TADODataSet;
    quItemCommissionIDCommission: TIntegerField;
    quItemCommissionCommissionPercent: TBCDField;
    cdsInvoice: TClientDataSet;
    dspInvoice: TDataSetProvider;
    cdsInvoiceIDPreSale: TIntegerField;
    cdsInvoiceIDInvoice: TIntegerField;
    cdsInvoicePreSaleDate: TDateTimeField;
    cdsInvoiceTotInvoice: TFloatField;
    cdsInvoicePessoaFirstName: TStringField;
    cdsInvoicePessoaLastName: TStringField;
    cdsInvoiceIDTouristGroup: TIntegerField;
    cdsInvoiceOtherComissionID: TIntegerField;
    cdsInvoicePessoa: TStringField;
    cdsInvoiceSaleCode: TStringField;
    cdsInvoiceIDPessoa: TIntegerField;
    cdsInvoiceNote: TStringField;
    cdsInvoiceInvoiceDate: TDateTimeField;
    cdsInvoiceInvoiceCode: TStringField;
    cdsInvoiceQty: TFloatField;
    cdsInvoiceCostPrice: TBCDField;
    cdsInvoiceSalePrice: TBCDField;
    cdsInvoiceDiscount: TBCDField;
    cdsInvoiceModel: TStringField;
    cdsInvoiceDescription: TStringField;
    cdsInvoiceIDInventoryMov: TIntegerField;
    cdsInvoiceItemTotal: TFloatField;
    cdsInvoiceIDModel: TIntegerField;
    cdsInvoiceDateLastCost: TDateTimeField;
    cdsInvoiceLastCost: TBCDField;
    cdsInvoiceIDVendor: TIntegerField;
    cdsInvoiceVendor: TStringField;
    cdsInvoiceIDDepartment: TIntegerField;
    quInvoiceRetorno: TBooleanField;
    cdsInvoiceRetorno: TBooleanField;
    lbBarcode: TLabel;
    edtBarcode: TmrBarCodeEdit;
    quInvoicePreInventoryMovID: TIntegerField;
    cdsInvoicePreInventoryMovID: TIntegerField;
    quInvoiceAction: TIntegerField;
    cdsInvoiceAction: TIntegerField;
    quItem: TADOQuery;
    quItemIDPreSale: TIntegerField;
    quItemIDInvoice: TIntegerField;
    quItemPreSaleDate: TDateTimeField;
    quItemInvoiceDate: TDateTimeField;
    quItemSaleCode: TStringField;
    quItemInvoiceCode: TStringField;
    quItemNote: TStringField;
    quItemPessoaFirstName: TStringField;
    quItemPessoaLastName: TStringField;
    quItemPessoa: TStringField;
    quItemIDPessoa: TIntegerField;
    quItemIDTouristGroup: TIntegerField;
    quItemOtherComissionID: TIntegerField;
    quItemIDInventoryMov: TIntegerField;
    quItemCostPrice: TBCDField;
    quItemSalePrice: TBCDField;
    quItemDiscount: TBCDField;
    quItemIDModel: TIntegerField;
    quItemModel: TStringField;
    quItemDescription: TStringField;
    quItemDateLastCost: TDateTimeField;
    quItemLastCost: TBCDField;
    quItemIDVendor: TIntegerField;
    quItemVendor: TStringField;
    quItemIDDepartment: TIntegerField;
    quItemRetorno: TBooleanField;
    quItemPreInventoryMovID: TIntegerField;
    quItemAction: TIntegerField;
    dspItem: TDataSetProvider;
    quItemTotInvoice: TFloatField;
    quItemItemTotal: TFloatField;
    quItemQty: TFloatField;
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
    quInvoiceSalesTax: TBCDField;
    cdsInvoiceSalesTax: TBCDField;
    quItemSalesTax: TBCDField;
    quInvoiceTaxIsent: TBooleanField;
    cdsInvoiceTaxIsent: TBooleanField;
    quInvoiceUnitDiscount: TBCDField;
    cdsInvoiceUnitDiscount: TBCDField;
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
  private
    // Antonio 2013 Oct 22 - MR-37
    cloneToGetOriginalData: TClientDataset;
    // Antonio June 13, 2013
    saveRefundOriginalQty: double;

    //amfsouza October 08, 2012 - Item without invoice.
    selectedItemNoInvoice: Boolean;

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

    function getValueIfIsLookTheSame(arg_number1, arg_number2: double): double;

    // Antonio June 20, 2013
    function getDiscountToEachItem(arg_invoice: TClientDataset): double;

    function findInfoCashSale(pInvoiceNumber: Integer): boolean;

    //amfsouza October, 08 2012 - Hide/Show
    procedure HideShowToNotInvoiceItem(pVisible: Boolean = false);

    //amfouza July 13, 2012
    procedure ShowRefund(pShowRefund: boolean = true);

    procedure AddTotalItemsSelected(pValue: Currency);
    procedure AddTotalTaxSelected(pValue: Currency);

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
    function StartItem(arg_IdPreInventoryMov : Integer; arg_InfoCashSale: InfoCashSale = nil) : Boolean;

    function getIdRefund: Integer;
    function getRefundDate: TDateTime;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uMsgBox, uMsgConstant, cxImageComboBox, uNumericFunctions;

{$R *.dfm}

{ TFrmInvoiceRefund }

function TFrmInvoiceRefund.StartItem(arg_IdPreInventoryMov : Integer; arg_InfoCashSale: InfoCashSale = nil) : Boolean;
begin

  FIDPreInvMov := arg_IdPreInventoryMov;
  FStartType := TYPE_ITEM_REFUND;

  cdsInvoice.ProviderName := 'dspItem';
  RefreshInvoice;

  // amfsouza June 16, 2012 - ini
  useCashSaleInfo := false;
  pnlSaleDiscount.Visible := useCashSaleInfo;
  infoCashSale := arg_InfoCashSale;

  if ( not findInfoCashSale(cdsInvoice.fieldByName('IdPreSale').Value) ) then begin
     result := false;
     close;
  end;

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

  scDefectType.ShowBtnUpdate := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  scDefectType.ShowBtnAddNew := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  ShowModal;

  //AIDRefund   := cdsInvoice.fieldbyname('IDPreSale').AsInteger;
  //ARefundDate := cdsInvoice.fieldByname('InvoiceDate').AsDateTime;

  AddItemRepair;

  pnlInvoiceItems.Visible := False;
  edtBarcode.Visible := False;
  lbBarcode.Visible := False;
  DBEdit1.DataField := 'SaleCode';

  //amfsouza October 08, 2012
  HideShowToNotInvoiceItem();

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
  if ( not findInfoCashSale(strToInt(InvoiceRefund)) ) then begin
     close;
     exit;
  end;

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

  //amfsouza October 08, 2012
  selectedItemNoInvoice := false;

  cloneToGetOriginalData := TClientDataset.Create(nil);
  cloneToGetOriginalData.Data := cdsInvoice.Data;
//  saveRefundOriginalQty := cdsInvoice.fieldByName('qty').Value;

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

  // Antonio 2013 Oct 22, MR-37
  freeAndNil(cloneToGetOriginalData);

  Action := caFree;
end;

procedure TFrmInvoiceRefund.CloseInvoice;
begin
  with cdsInvoice do
    if Active then
      Close;
end;

procedure TFrmInvoiceRefund.OpenInvoice;
var
  saveSQLFromquInvoiceDesignTime: String;
begin

  saveSQLFromquInvoiceDesignTime := quInvoice.SQL.Text;

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
  discount: Double;
   _UnitDiscount: Double;          // _ stands to local variable ( on stack )
begin

  Result := False;

  if not cdsItemRepair.IsEmpty then
    if not ValidateRepair then
       Exit;

  try

    DM.ADODBConnect.BeginTrans;

    // update invoice table to save invoice discount
   // showmessage(format('idpresale = %d, sale discount = %f', [fidpresale, infocashsale.getSaleDiscount]));
    dm.updateInvoiceSettingInvoiceDiscount(fIdpresale, (infoCashSale.getSaleDiscount * -1 ));

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

              // Antonio June 20, 2013
              discount := getDiscountToEachItem(cdsInvoice);

              // Antonio 09/09/2016
              _unitDiscount := cdsInvoice.fieldByName('UnitDiscount').value;

              // To indicate refund movement
              iIDPreinventMov := -1;

              DM.fPOS.AddHoldItem(cdsInvoice.fieldByName('IDPessoa').AsInteger,
                                  FIDPresale,
                                  cdsInvoice.fieldbyname('IDModel').AsInteger,
                                  DM.fStore.IDStoreSale,
                                  (cdsInvoice.fieldbyname('Qty').AsFloat * -1),
                                  0,
                                  cdsInvoice.fieldbyname('SalePrice').AsCurrency,
                                  cdsInvoice.fieldbyname('CostPrice').AsCurrency,
                                  DM.fUser.ID,
                                  DM.fUser.IDCommission,
                                  Now,
                                  Now,
                                  False,
                                  True,
                                  0, //cdsInvoice.fieldbyname('PreInventoryMovID').Value,
                                  cdsInvoice.fieldbyname('IDDepartment').AsInteger,
                                  iError,
                                  iIDPreInventMov,
                                  0,
                                  false,
                                  0,
                                  0,
                                  0,
                                  '',
                                  0,
                                  0,
                                  _unitDiscount, // unit discount
                                  True,
                                  cdsInvoice.fieldbyname('SalePrice').AsCurrency, // manual price
                                  discount,
                                  0,
                                  false,
                                  True);

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

  //Antonio June 19, 2013, 2012
  if ( not selectedItemNoInvoice ) then begin
      ShowRefund(false);
      infoCashSale.setSaleDiscount(saleLevelDiscount);
  end;

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
  infoCashSale.setNewTotalDue(0);
  infoCashSale.setNewTotalSaved(0);
  infoCashSale.setSubtotal(0);
  infocashsale.setItemDiscounts(0);
  infocashSale.setSaleDiscount(0);
  infoCashSale.setOtherCosts(0);
  infocashSale.setTax(0);
  infoCashSale.setTotalDue(0);
  infoCashSale.setTotalSaved(0);
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


function TFrmInvoiceRefund.findInfoCashSale(pInvoiceNumber: Integer): Boolean;
var
  qry: TADOQuery;
  totalDue: Currency;
  totalDiscount: Currency;
begin
  try
    result := false;
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

         if ( qry.FieldByName('TotalDiscount').IsNull ) then begin
             totalDiscount := 0;
         end else begin
                 totalDiscount := qry.fieldByName('TotalDiscount').Value;
             end;

         infoCashSale.setTotalSaved(totalDiscount);

         totalDue := qry.fieldByName('SubTotal').Value -
           (qry.fieldByName('ItemDiscount').Value +
            qry.fieldByName('InvoiceDiscount').Value) +
            qry.fieldByName('AditionalExpenses').Value +
            qry.fieldByName('Tax').Value;

         infoCashSale.setTotalDue(totalDue);
         result := true;
      end
      else begin
          application.messageBox('Invoice Not Found', 'Refund', mb_OK + mb_IconStop);
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
  totalItemDiscountInRefund: Currency;
  discount: Double;
begin
  inherited;
  curreditRefund.Value    := 0;
  totalValueItemsSelected := 0;
  totalTaxSelected        := 0;
  saleLevelDiscount       := 0;
  totalItemDiscountInRefund   := 0;

  hasSelected := false;

  discount := 0;

  cdsInvoice.First;
  while ( not cdsInvoice.Eof ) do begin
      return := cdsInvoice.FieldByName('retorno').AsBoolean;

      if ( return) then begin

         // Antonio June 20, 2013
         discount := getDiscountToEachItem(cdsInvoice);

         totalItemDiscountInRefund := totalItemDiscountInRefund + discount;

         totalSaleItem := ( cdsInvoice.fieldByName('SalePrice').Value *
                            cdsInvoice.fieldByName('Qty').Value ) - discount;

         AddTotalItemsSelected(totalSaleItem);

         taxSelected := ( (cdsInvoice.fieldByName('SalePrice').Value *
                          cdsInvoice.fieldByName('Qty').Value) - discount) *
                         cdsInvoice.fieldByName('SalesTax').Value;
         AddTotalTaxSelected(taxSelected);
         hasSelected := true;
      end;
      cdsInvoice.Next;
  end;

  if ( hasSelected ) then begin
      saleLevelDiscount := infoCashSale.getSaleDiscount * (totalValueItemsSelected) / totalOnSale;

      // to fix refund when there is tax exempt on invoice
      if ( dsInvoice.dataset.fieldbyname('TaxIsent').AsBoolean = true ) then begin
         totalTaxSelected := 0;
      end;

      curreditRefund.Value := ((-1)* totalValueItemsSelected ) +
                              saleLevelDiscount - (totalTaxSelected);

      currEditRefund.value := getValueIfIsLookTheSame(dsInvoice.dataset.fieldByName('TotInvoice').Value, curreditRefund.value);

      // Antonio 2013 Nov 01, MR-86
      totalItemDiscountInRefund := getValueIfisLookTheSame(strToFloat(dbedItemDiscount.Text), totalItemDiscountInRefund);

      // Antonio 2013 Oct 29, MR-83
      //totalItemDiscountInRefund := strToFloat(dbedItemDiscount.Text);
      infoCashSale.setItemDiscounts(TotalItemdiscountInRefund);

      //showmessage(format('sale discount = %.2f * total value items selected = %.2f / total on sale = %.2f', [infoCashSale.getSaleDiscount, totalValueItemsSelected, currEditRefund.Value] ));

      if ( pShowRefund ) then
         pnlTotalRefund.Visible := true;
  end;
end;

procedure TFrmInvoiceRefund.HideShowToNotInvoiceItem(pVisible: Boolean);
begin
   panel2.Visible := pvisible;
   shape1.Visible := panel2.Visible;
   label2.Visible := panel2.Visible;
   pnlRefund.Visible := shape1.visible;
   selectedItemNoInvoice := true;
end;

function TFrmInvoiceRefund.getIdRefund: Integer;
begin
  result := cdsInvoice.fieldByName('IdRefund').Value;
end;

function TFrmInvoiceRefund.getRefundDate: TDateTime;
begin
  result := cdsInvoice.fieldByname('InvoiceDate').AsDateTime;
end;

function TFrmInvoiceRefund.getDiscountToEachItem(arg_invoice: TClientDataset): double;
var
   originalQtyFromInvoice: Integer;
begin
  // Antonio 2013 Oct 22, MR-37
  originalQtyFromInvoice := 1; // default to avoid exception
  cloneToGetOriginalData.Filter := format('IdInventoryMov = %d', [arg_invoice.FieldByName('IdInventoryMov').AsInteger]);
  cloneToGetOriginalData.Filtered := true;

  if ( not cloneToGetOriginalData.IsEmpty ) then begin
     originalQtyFromInvoice := cloneToGetOriginalData.fieldByname('Qty').Value;
  end;

  if ( originalQtyFromInvoice > 0 ) then begin
     result := ( arg_invoice.fieldByName('Discount').Value /originalQtyFromInvoice ) * arg_Invoice.fieldByName('Qty').Value;
  end;
end;

function TFrmInvoiceRefund.getValueIfIsLookTheSame(arg_number1,  arg_number2: double): double;
const
    ref = 1000000;
    verySmallNumber = 1/ref;
var
   proportionalDiff: Double;
begin
   proportionalDiff := abs( (abs(arg_number2) - abs(arg_number1)) / ref );
   if ( proportionalDiff < verySmallNumber ) then
   	arg_number2 := arg_number1;

   result := arg_number2;

end;

end.

