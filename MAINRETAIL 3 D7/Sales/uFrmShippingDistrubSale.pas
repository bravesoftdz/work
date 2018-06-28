unit uFrmShippingDistrubSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentSaleFull, DB, ADODB, cxClasses, cxStyles,
  cxGridTableView, siComp, siLangRT, ExtCtrls, StdCtrls, Buttons,
  SubListPanel, DBCtrls, Mask, DateBox, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, SuperComboADO, clsInfoCashSale;

type
  TFrmShippingDistrubSale = class(TFrmParentSaleFull)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlClient: TPanel;
    pnlControl: TPanel;
    lblUserName: TLabel;
    Label15: TLabel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btClose: TButton;
    lbBillTo: TLabel;
    SubCustomer: TSubListPanel;
    lbDate: TLabel;
    dbPreSale: TDBDateBox;
    lbHoldNum: TLabel;
    pnlButton: TPanel;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsDBQty: TcxGridDBColumn;
    grdItemsDBModel: TcxGridDBColumn;
    grdItemsDBDescription: TcxGridDBColumn;
    grdItemsDBSalesPerson: TcxGridDBColumn;
    grdItemsDBSellingPrice: TcxGridDBColumn;
    grdItemsDBSalePrice: TcxGridDBColumn;
    grdItemsDBSuggRetail: TcxGridDBColumn;
    grdItemsDBDiscount: TcxGridDBColumn;
    grdItemsDBTotalItem: TcxGridDBColumn;
    grdItemsDBTax: TcxGridDBColumn;
    grdItemsDBSerialNumber: TcxGridDBColumn;
    grdItemsLevel: TcxGridLevel;
    cxStyleContent2: TcxStyle;
    cxStyleSelection2: TcxStyle;
    Panel1: TPanel;
    cxStyleHeader2: TcxStyle;
    btnOpenHold: TSpeedButton;
    pnlTotals: TPanel;
    Bevel1: TBevel;
    lbSalesTax: TLabel;
    edtTax: TDBText;
    lbOtherExpenses: TLabel;
    edtOtherCosts: TDBText;
    lbDiscount: TLabel;
    edtDiscount: TDBText;
    lbSubTotal: TLabel;
    edtSubTotal: TDBText;
    lbInvoiceTotal: TLabel;
    DBText1: TDBText;
    Bevel5: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    btnSearchTax: TSpeedButton;
    btnTicketExpenses: TSpeedButton;
    btnApplyDiscount: TSpeedButton;
    lbStatus: TLabel;
    grCustomerAccount: TGroupBox;
    Bevel6: TBevel;
    lbAmountPaidInfo: TLabel;
    btnPaiAmount: TSpeedButton;
    lbNetDueInfo: TLabel;
    lbAmountPaid: TLabel;
    btnInvoiceList: TSpeedButton;
    quShipToList: TADODataSet;
    dsShipToList: TDataSource;
    quPreSaleShipInfo: TADODataSet;
    quShipToListIDPessoaAddress: TIntegerField;
    quShipToListName: TStringField;
    quShipToListAddress: TStringField;
    quShipToListCity: TStringField;
    quShipToListZIP: TStringField;
    quShipToListIDState: TStringField;
    quShipToListState: TStringField;
    quShipToListCountryCod: TStringField;
    quShipToListCountry: TStringField;
    quShipToListFullAddress: TStringField;
    pnlShipp: TPanel;
    lbShipTo: TLabel;
    cbmShipToList: TcxLookupComboBox;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    cmdInsertShipInfo: TADOCommand;
    quPreSaleShipInfoIDPreSale: TIntegerField;
    quPreSaleShipInfoIDInvoiceShipping: TIntegerField;
    quPreSaleShipInfoShipDate: TDateTimeField;
    quPreSaleShipInfoTracking: TStringField;
    quPreSaleShipInfoAddressName: TStringField;
    quPreSaleShipInfoAddress: TStringField;
    quPreSaleShipInfoCity: TStringField;
    quPreSaleShipInfoZIP: TStringField;
    quPreSaleShipInfoIDPais: TIntegerField;
    DBText3: TDBText;
    dsSaleShipInfo: TDataSource;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    quShipToListIDPais: TIntegerField;
    quPreSaleShipInfoIDEstado: TStringField;
    btnCopyAddress: TSpeedButton;
    lbShipVia: TLabel;
    lbShipDate: TLabel;
    dtShip: TDBDateBox;
    Label2: TLabel;
    edtTrackNum: TDBEdit;
    Bevel12: TBevel;
    quPreSaleShipInfoIDDeliverType: TIntegerField;
    scDeliverType: TDBSuperComboADO;
    lbCustomerSince: TLabel;
    lbCredit: TLabel;
    quCustomerInfo: TADODataSet;
    quCustomerInfoPessoa: TStringField;
    quCustomerInfoEndereco: TStringField;
    quCustomerInfoCidade: TStringField;
    quCustomerInfoCEP: TStringField;
    quCustomerInfoIDEstado: TStringField;
    quCustomerInfoIDPais: TIntegerField;
    quCustomerInfoCreationDate: TDateTimeField;
    DBText8: TDBText;
    dsCustomerInfo: TDataSource;
    btnAddItem: TSpeedButton;
    btnOpenItem: TSpeedButton;
    btnDeleteItem: TSpeedButton;
    btnHistory: TSpeedButton;
    DBText9: TDBText;
    quCustomerInfoTotalCredit: TBCDField;
    btnPayments: TSpeedButton;
    btnNewInvoice: TSpeedButton;
    lbNetDue: TLabel;
    Label1: TLabel;
    lbInvoiceNum: TDBText;
    lbSaleCode: TDBText;
    Label3: TLabel;
    DBText2: TDBText;
    pnlInvoice: TPanel;
    btnImportCustomerPO: TSpeedButton;
    lbMidia: TLabel;
    scMedia: TDBSuperComboADO;
    btnUpdate: TSpeedButton;
    btnSearchCustomer: TSpeedButton;
    btnPrint: TSpeedButton;
    btnSaleTax: TSpeedButton;
    btnSaveShipping: TSpeedButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quPreSaleInfoAfterOpen(DataSet: TDataSet);
    procedure btnSearchCustomerClick(Sender: TObject);
    procedure btnTicketExpensesClick(Sender: TObject);
    procedure btnApplyDiscountClick(Sender: TObject);
    procedure quShipToListCalcFields(DataSet: TDataSet);
    procedure cbmShipToListPropertiesChange(Sender: TObject);
    procedure btnCopyAddressClick(Sender: TObject);
    procedure quPreSaleInfoBeforeClose(DataSet: TDataSet);
    procedure btnInvoiceListClick(Sender: TObject);
    procedure btnNewInvoiceClick(Sender: TObject);
    procedure spquPreSaleValueAfterOpen(DataSet: TDataSet);
    procedure btnImportCustomerPOClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSearchTaxClick(Sender: TObject);
    procedure btnSaleTaxClick(Sender: TObject);
    procedure btnSaveShippingClick(Sender: TObject);
    procedure dsSaleShipInfoStateChange(Sender: TObject);
  private
    FUserValidate: Boolean;

    procedure ClearCustomer;

    procedure ShipToListOpen;
    procedure ShipToListClose;
    procedure ShipToListRefresh;

    function PreSaleShipInfoExist : Boolean;
    procedure PreSaleShipInfoOpen;
    procedure PreSaleShipInfoClose;
    procedure PreSaleShipInfoRefresh;
    procedure PreSaleShipInfoEdit;
    procedure PreSaleShipInfoPost;
    procedure PreSaleShipInfoCreate;
    procedure UpdatePreSaleShipInfoAddress(AddressName, Address, City,
                         ZIP, IDEstado : String; IDCountry : Integer);

    procedure RefreshTime;
    procedure RefreshUser;

    procedure OpenCustomer;
    procedure CloseCustomer; 
    procedure RefreshCustomer;
    procedure OpenInvoice(IDPreSale : Integer);
    procedure RefreshControls;

    procedure PrintReceipt;
  protected
    procedure LoadImages; override;
    procedure NewHold(IsLayway : Boolean = False); override;
    procedure OpenHold(IDPreSale: Integer); override;
    procedure CloseHold; override;
    procedure AfterReceivePayment(CloseSale : Boolean; pInfoCashSale: InfoCashSale = nil); override;
    function ValidatePayment : Boolean; override;
  public
    function Start(PreSaleType, IDCashRegMov : Integer):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uMsgBox, uMsgConstant, uFrmSearchCustomer, uPassword,
     uSystemConst, uFrmMainPOSInfo, uFrmParentSales, uFrmJoinHold,
     uFrmImportEstimated, uFrmPrintShippingOption, uFrmApplyItemTax;

{$R *.dfm}

{ TFrmShippingDistrubSale }

function TFrmShippingDistrubSale.Start(PreSaleType,
  IDCashRegMov: Integer): Boolean;
begin
  FUserValidate := False;
  FInvoiceInfo.PreSaleType   := PreSaleType;
  FInvoiceInfo.IDCashRegMov  := IDCashRegMov;

  CloseHold;
  NewHold;

  FUserValidate := True;
  RefreshTime;
  RefreshUser;

  scDeliverType.ShowBtnAddNew := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  scDeliverType.ShowBtnUpdate := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  Result := (ShowModal = mrOK);

end;

procedure TFrmShippingDistrubSale.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmShippingDistrubSale.RefreshTime;
begin
  //lbTime.Caption := FormatDateTime('hh:mm AM/PM', Now);
end;

procedure TFrmShippingDistrubSale.RefreshUser;
begin
  lblUserName.Caption := DM.fUser.UserName;
end;

procedure TFrmShippingDistrubSale.FormCreate(Sender: TObject);
begin
  inherited;
  SubCustomer.CreateSubList;
end;

procedure TFrmShippingDistrubSale.ClearCustomer;
begin
  SubCustomer.Param := 'IDCUSTOMER=0;DisplayType=R;BackColor=clWhite;';
  ShipToListClose;
end;

procedure TFrmShippingDistrubSale.RefreshCustomer;
begin
  SubCustomer.Param := Format('IDCUSTOMER=%S;DisplayType=R;BackColor=clWhite;', [quPreSaleInfoIDCustomer.AsString]);
  CloseCustomer;
  OpenCustomer;
end;

procedure TFrmShippingDistrubSale.NewHold(IsLayway: Boolean);
begin
  inherited;
  ClearCustomer;
  RefreshTime;
  RefreshUser;
  PreSaleShipInfoCreate;
end;

procedure TFrmShippingDistrubSale.CloseHold;
begin
  inherited;
  ShipToListClose;
  PreSaleShipInfoClose;
end;

procedure TFrmShippingDistrubSale.OpenHold(IDPreSale: Integer);
begin
  inherited;
  ShipToListRefresh;
  PreSaleShipInfoCreate;
end;

procedure TFrmShippingDistrubSale.CloseCustomer;
begin
  with quCustomerInfo do
    if Active then
      Close;
end;

procedure TFrmShippingDistrubSale.OpenCustomer;
begin
  with quCustomerInfo do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := quPreSaleInfoIDCustomer.AsInteger;
      Open;
    end;
end;


procedure TFrmShippingDistrubSale.quPreSaleInfoAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  RefreshCustomer;
  FInvoiceInfo.IsShipping := True;
  RefreshControls;
end;

procedure TFrmShippingDistrubSale.btnSearchCustomerClick(Sender: TObject);
var
  iIDCustomer: Integer;
begin
  inherited;
  
  with TFrmSearchCustomer.Create(Self) do
    iIDCustomer := Start;

  SetCustomer(iIDCustomer);
  ShipToListRefresh;
  
  if quShipToList.RecordCount > 0 then
    UpdatePreSaleShipInfoAddress(quShipToListName.AsString,
                                 quShipToListAddress.AsString,
                                 quShipToListCity.AsString,
                                 quShipToListZIP.AsString,
                                 quShipToListIDState.AsString,
                                 quShipToListIDPais.AsInteger);

end;

procedure TFrmShippingDistrubSale.LoadImages;
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btnOpenItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDeleteItem.Glyph);
end;

procedure TFrmShippingDistrubSale.btnTicketExpensesClick(Sender: TObject);
begin
  inherited;
  if not EmptyHold then
  begin
    with TFrmMainPOSInfo.Create(Self) do
      Start(quPreSaleInfo, spquPreSaleValue, TAB_OTHER_EXP);
    RefreshHold;
    RefreshValue;
  end;
end;

procedure TFrmShippingDistrubSale.btnApplyDiscountClick(Sender: TObject);
begin
  inherited;
  if not EmptyHold then
  begin
    with TFrmMainPOSInfo.Create(Self) do
      Start(quPreSaleInfo, spquPreSaleValue, TAB_DISCOUNT);
    RefreshHold;
    RefreshValue;
  end;

end;

procedure TFrmShippingDistrubSale.ShipToListClose;
begin
  with quShipToList do
    if Active then
      Close;
end;

procedure TFrmShippingDistrubSale.ShipToListOpen;
begin
  with quShipToList do
    if not Active then
    begin
      Parameters.ParamByName('IDPessoa').Value := quPreSaleInfoIDCustomer.AsInteger;
      Open;
    end;
end;

procedure TFrmShippingDistrubSale.ShipToListRefresh;
begin
  ShipToListClose;
  ShipToListOpen;
end;

procedure TFrmShippingDistrubSale.quShipToListCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  if (quShipToListAddress.AsString <> '') then
  begin
    quShipToListFullAddress.AsString := quShipToListAddress.AsString;
    if quShipToListCity.AsString <> '' then
      quShipToListFullAddress.AsString := quShipToListFullAddress.AsString + ' ' +
                                          quShipToListCity.AsString;
    if quShipToListState.AsString <> '' then
      quShipToListFullAddress.AsString := quShipToListFullAddress.AsString + ', ' +
                                          quShipToListState.AsString;
  end;
end;


procedure TFrmShippingDistrubSale.PreSaleShipInfoClose;
begin
  with quPreSaleShipInfo do
    if Active then
      Close;
end;

procedure TFrmShippingDistrubSale.PreSaleShipInfoOpen;
begin
  with quPreSaleShipInfo do
    if not Active then
    begin
      Parameters.ParamByName('IDPreSale').Value := FInvoiceInfo.IDPreSale;
      Open;
    end;
end;

procedure TFrmShippingDistrubSale.PreSaleShipInfoRefresh;
begin
  PreSaleShipInfoClose;
  PreSaleShipInfoOpen;
end;

procedure TFrmShippingDistrubSale.PreSaleShipInfoCreate;
begin

  if not PreSaleShipInfoExist then
    with cmdInsertShipInfo do
    begin
      Parameters.ParamByName('IDInvoiceShipping').Value := DM.GetNextID('Sal_InvoiceShipping.IDInvoiceShipping');
      Parameters.ParamByName('ShipDate').Value          := Now;
      Parameters.ParamByName('IDPreSale').Value         := FInvoiceInfo.IDPreSale;
      Execute;
    end;

  PreSaleShipInfoRefresh;

end;

procedure TFrmShippingDistrubSale.PreSaleShipInfoEdit;
begin
  with quPreSaleShipInfo do
    if Active then
      Edit;
end;

procedure TFrmShippingDistrubSale.PreSaleShipInfoPost;
begin
  with quPreSaleShipInfo do
    if Active then
      if (quPreSaleShipInfo.State in [dsEdit]) then
        Post;
end;

procedure TFrmShippingDistrubSale.cbmShipToListPropertiesChange(
  Sender: TObject);
begin
  inherited;

  if quShipToList.Active and (cbmShipToList.EditValue <> 0) then
    if quShipToList.Locate('IDPessoaAddress', cbmShipToList.EditValue,  []) then
      UpdatePreSaleShipInfoAddress(quShipToListName.AsString,
                                   quShipToListAddress.AsString,
                                   quShipToListCity.AsString,
                                   quShipToListZIP.AsString,
                                   quShipToListIDState.AsString,
                                   quShipToListIDPais.AsInteger);
end;

procedure TFrmShippingDistrubSale.UpdatePreSaleShipInfoAddress(AddressName,
  Address, City, ZIP, IDEstado: String; IDCountry: Integer);
begin
  PreSaleShipInfoOpen;
  PreSaleShipInfoEdit;

  with quPreSaleShipInfo do
  begin
    FieldByName('AddressName').AsString := AddressName;
    FieldByName('Address').AsString     := Address;
    FieldByName('City').AsString        := City;
    FieldByName('ZIP').AsString         := ZIP;
    FieldByName('IDEstado').AsString    := IDEstado;
    FieldByName('IDPais').AsInteger     := IDCountry
  end;

  PreSaleShipInfoRefresh;
end;

function TFrmShippingDistrubSale.PreSaleShipInfoExist: Boolean;
begin
  PreSaleShipInfoRefresh;
  with quPreSaleShipInfo do
    Result := not IsEmpty;
end;


procedure TFrmShippingDistrubSale.btnCopyAddressClick(Sender: TObject);
begin
  inherited;

  if (quPreSaleInfoIDCustomer.AsInteger >= 1) then
    with quCustomerInfo do
    begin
      if (RecordCount > 0) then
        UpdatePreSaleShipInfoAddress(FieldByName('Pessoa').AsString,
                                     FieldByName('Endereco').AsString,
                                     FieldByName('Cidade').AsString,
                                     FieldByName('CEP').AsString,
                                     FieldByName('IDEstado').AsString,
                                     FieldByName('IDPais').AsInteger);
    end;

end;


procedure TFrmShippingDistrubSale.quPreSaleInfoBeforeClose(
  DataSet: TDataSet);
begin
  inherited;
  CloseCustomer;
end;


function TFrmShippingDistrubSale.ValidatePayment: Boolean;
var
  FResult : Boolean;
begin

  FResult := inherited ValidatePayment;

  if not FResult then
    Exit;

  {
  if (quPreSaleInfoIDCustomer.AsInteger <= 1) then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbOKOnly + vbInformation);
    Result := False;
    Exit;
  end;
  }
  Result := True;
    
end;

procedure TFrmShippingDistrubSale.AfterReceivePayment(CloseSale : Boolean; pInfoCashSale: InfoCashSale = nil);
begin

  DM.FTraceControl.TraceIn('TFrmShippingDistrubSale.AfterReceivePayment');

  try
    RefreshInfo;
    FInvoiceInfo.IDInvoice := quPreSaleInfoIDInvoice.AsInteger;
    CloseHold;
    PrintReceipt;
    NewHold;
  except
    on E: Exception do
      DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmShippingDistrubSale');
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TFrmShippingDistrubSale.btnInvoiceListClick(Sender: TObject);
var
  iIDPreSale: Integer;
  sCustomer,
  sOBS: String;
begin
  inherited;

  with TFrmJoinHold.Create(Self) do
    iIDPreSale := StartInvoiceShip;

  if (iIDPreSale <> -1) then
    OpenInvoice(iIDPreSale);
  
end;


procedure TFrmShippingDistrubSale.OpenInvoice(IDPreSale: Integer);
begin

  //Deletar o Hold atual antes de abrir
  if FInvoiceInfo.IsNewHold then
    DeleteHold
  else
    CloseHold;

  FInvoiceInfo.IDPreSale := IDPreSale;

  //Create a New PreSale
  FInvoiceInfo.IsNewHold := False;

  //Information about Invoice
  RefreshInfo;
  FInvoiceInfo.IDInvoice := quPreSaleInfoIDInvoice.AsInteger;
  RefreshControls;

  //PreSale Items
  RefreshItem(0);

  RefreshValue;

  PreSaleShipInfoRefresh;

end;

procedure TFrmShippingDistrubSale.RefreshControls;
begin
  btnSearchCustomer.Enabled := (not FInvoiceInfo.IsInvoice);
  btnOpenHold.Enabled       := btnSearchCustomer.Enabled;
  btnAddItem.Enabled        := btnSearchCustomer.Enabled;
  btnOpenItem.Enabled       := btnSearchCustomer.Enabled;
  btnDeleteItem.Enabled     := btnSearchCustomer.Enabled;
  btnSearchTax.Enabled      := btnSearchCustomer.Enabled;
  btnSaleTax.Enabled        := btnSearchCustomer.Enabled;
  btnTicketExpenses.Enabled := btnSearchCustomer.Enabled;
  btnApplyDiscount.Enabled  := btnSearchCustomer.Enabled;
  btnPaiAmount.Enabled      := btnSearchCustomer.Enabled;
  cbmShipToList.Enabled     := btnSearchCustomer.Enabled;
  dbPreSale.Enabled         := btnSearchCustomer.Enabled;
  scMedia.Enabled           := btnSearchCustomer.Enabled;
  btnUpdate.Enabled         := btnSearchCustomer.Enabled;
  btnCopyAddress.Enabled    := btnSearchCustomer.Enabled;


  btnPayments.Visible       := (FInvoiceInfo.IsInvoice);
  pnlInvoice.Visible        := (FInvoiceInfo.IsInvoice);

end;

procedure TFrmShippingDistrubSale.btnNewInvoiceClick(Sender: TObject);
begin
  inherited;
  CloseHold;
  NewHold;
end;

procedure TFrmShippingDistrubSale.spquPreSaleValueAfterOpen(
  DataSet: TDataSet);
begin
  inherited;

  if (not FInvoiceInfo.IsInvoice) then
  begin
    lbStatus.Caption := 'UNPAID';
    lbAmountPaid.Caption := '0.00';
    lbNetDue.Caption := FormatFloat('#,##0.00', spquPreSaleValueTotalInvoice.AsCurrency);
  end
  else
  begin
    lbStatus.Caption := 'PAID IN FULL';
    lbAmountPaid.Caption := FormatFloat('#,##0.00', spquPreSaleValueTotalInvoice.AsCurrency);
    lbNetDue.Caption := '0.00';
  end;

end;

procedure TFrmShippingDistrubSale.btnImportCustomerPOClick(
  Sender: TObject);
var
  iIDPreSale : Integer;
begin
  inherited;

  with TFrmImportEstimated.Create(Self) do
    if Start(iIDPreSale, quPreSaleInfoMediaID.AsInteger) then
      OpenHold(iIDPreSale);

end;

procedure TFrmShippingDistrubSale.btnPrintClick(Sender: TObject);
begin
  inherited;
  PrintReceipt;
end;

procedure TFrmShippingDistrubSale.PrintReceipt;
var
  iType : Integer;
begin

  DM.FTraceControl.TraceIn('TFrmShippingDistrubSale.PrintReceipt');

  try
    // Impressão do recibo
    if (FInvoiceInfo.IDInvoice = 0) then
      iType := 1 //Hold
    else
      iType := 2; //Invoice

    with TFrmPrintShippingOption.Create(Self) do
      Start(FInvoiceInfo.IDPreSale, iType);
      
  except
    on E: Exception do
    begin
       DM.FTraceControl.SaveTrace(DM.fUser.ID, E.Message, 'TFrmShippingDistrubSale');
       MsgBox(MSG_CRT_ERROR_PRINT, vbCritical + vbOkOnly);
    end;
  end;

  DM.FTraceControl.TraceOut;

end;

procedure TFrmShippingDistrubSale.btnSearchTaxClick(Sender: TObject);
begin
  inherited;

  if spquPreSaleItem.Active and (not spquPreSaleItem.IsEmpty) then
    with TFrmApplyItemTax.Create(Self) do
      if Start(FInvoiceInfo.IDPreSale, -1) then
        RefreshItem(spquPreSaleItemIDInventoryMov.AsInteger);

end;

procedure TFrmShippingDistrubSale.btnSaleTaxClick(Sender: TObject);
begin
  inherited;

  if spquPreSaleItem.Active and (not spquPreSaleItem.IsEmpty) then
    with TFrmApplyItemTax.Create(Self) do
      if Start(FInvoiceInfo.IDPreSale, spquPreSaleItemIDInventoryMov.AsInteger) then
        RefreshItem(spquPreSaleItemIDInventoryMov.AsInteger);

end;

procedure TFrmShippingDistrubSale.btnSaveShippingClick(Sender: TObject);
begin
  inherited;
  PreSaleShipInfoPost;
end;

procedure TFrmShippingDistrubSale.dsSaleShipInfoStateChange(
  Sender: TObject);
begin
  inherited;
  btnSaveShipping.Enabled := (quPreSaleShipInfo.State in [dsEdit]);
end;

end.
