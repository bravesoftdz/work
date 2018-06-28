unit uFrmServiceOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls, DB,
  ADODB, SubListPanel, Provider, DBClient, Mask, DBCtrls, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, SuperComboADO, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, cxClasses,
  XiButton, uFrmServiceOrderSearch;

type
  TFrmServiceOrder = class(TFrmParent)
    pnlControl: TPanel;
    pnlFooter: TPanel;
    pnlDetail: TPanel;
    imgNewSO: TImage;
    Shape1: TShape;
    quServiceOrder: TADODataSet;
    btnNew: TLabel;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Image5: TImage;
    cdsServiceOrder: TClientDataSet;
    dspServiceOrder: TDataSetProvider;
    dsServiceOrder: TDataSource;
    cdsServiceOrderIDServiceOrder: TIntegerField;
    cdsServiceOrderIDCustomer: TIntegerField;
    cdsServiceOrderIDUser: TIntegerField;
    cdsServiceOrderIDSOStatus: TIntegerField;
    cdsServiceOrderIDStore: TIntegerField;
    cdsServiceOrderSONumber: TStringField;
    cdsServiceOrderSODate: TDateTimeField;
    cdsServiceOrderSOCloseDate: TDateTimeField;
    cdsServiceOrderOBS: TStringField;
    Bevel12: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    scStore: TDBSuperComboADO;
    scUser: TDBSuperComboADO;
    Label7: TLabel;
    scStatus: TDBSuperComboADO;
    Label8: TLabel;
    memNotes: TDBMemo;
    btnPayments: TSpeedButton;
    lbPaymentStatus: TLabel;
    strepSaleItem: TcxStyleRepository;
    cxStyleFooter: TcxStyle;
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
    cxStyleContent2: TcxStyle;
    cxStyleSelection2: TcxStyle;
    cxStyleHeader2: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsLevel: TcxGridLevel;
    pnlTotals: TPanel;
    Bevel1: TBevel;
    lbSubTotal: TLabel;
    edtSubTotal: TDBText;
    lbInvoiceTotal: TLabel;
    DBText1: TDBText;
    Bevel5: TBevel;
    Bevel6: TBevel;
    btnPayAmount: TSpeedButton;
    lbAmountPaidInfo: TLabel;
    lbAmountPaid: TLabel;
    lbNetDue: TLabel;
    lbNetDueInfo: TLabel;
    quSOItem: TADODataSet;
    dspSOItem: TDataSetProvider;
    cdsSOItem: TClientDataSet;
    cdsSOItemIDSOItem: TIntegerField;
    cdsSOItemIDSOCustomerProduct: TIntegerField;
    cdsSOItemSerialNumber: TStringField;
    cdsSOItemIniDate: TDateTimeField;
    cdsSOItemEndDate: TDateTimeField;
    cdsSOItemOBS: TStringField;
    cdsSOItemModel: TStringField;
    cdsSOItemDescription: TStringField;
    cdsSOItemManufacture: TStringField;
    dsSOItem: TDataSource;
    grdItemsDBIDSOItem: TcxGridDBColumn;
    grdItemsDBIDSOCustomerProduct: TcxGridDBColumn;
    grdItemsDBSerialNumber: TcxGridDBColumn;
    grdItemsDBIniDate: TcxGridDBColumn;
    grdItemsDBEndDate: TcxGridDBColumn;
    grdItemsDBOBS: TcxGridDBColumn;
    grdItemsDBModel: TcxGridDBColumn;
    grdItemsDBDescription: TcxGridDBColumn;
    grdItemsDBManufacture: TcxGridDBColumn;
    btnNewItem: TXiButton;
    btnEditItem: TXiButton;
    btnRemoveItem: TXiButton;
    Panel4: TPanel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    Label10: TLabel;
    dateStart: TcxDBDateEdit;
    Panel5: TPanel;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    lbBillTo: TLabel;
    Shape3: TShape;
    imgCustomer: TImage;
    SubCustomer: TSubListPanel;
    Image6: TImage;
    Label3: TLabel;
    Image7: TImage;
    Image8: TImage;
    Shape2: TShape;
    cdsSOItemSubTotal: TBCDField;
    grdItemsDBSubTotal: TcxGridDBColumn;
    quPayments: TADODataSet;
    dspPayments: TDataSetProvider;
    cdsPayments: TClientDataSet;
    cdsPaymentsPaid: TBCDField;
    Bevel2: TBevel;
    btnMessage: TXiButton;
    btnConfig: TXiButton;
    btnCustomer: TXiButton;
    cdsSOItemTotalDiscount: TBCDField;
    grdItemsDBTotalDiscount: TcxGridDBColumn;
    cdsSOItemTotalInvoice: TBCDField;
    grdItemsDBTotalInvoice: TcxGridDBColumn;
    lbCompleted: TLabel;
    btnHistory: TXiButton;
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsServiceOrderAfterOpen(DataSet: TDataSet);
    procedure imgCustomerClick(Sender: TObject);
    procedure btnNewItemClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure btnEditItemClick(Sender: TObject);
    procedure imgNewSOClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure cdsSOItemAfterOpen(DataSet: TDataSet);
    procedure cdsSOItemAfterClose(DataSet: TDataSet);
    procedure btnMessageClick(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure btnPayAmountClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfigClick(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
  private
    FIDServiceOrder : Integer;
    FIDCustomer : Integer;
    FSubTotal : Currency;
    FTotalPaid : Currency;
    FServiceOrderClosed : Boolean;
    FIDCashRegMov : Integer;
    FHasPaymentDiscount : Boolean;
    FrmServiceOrderSearch : TFrmServiceOrderSearch;

    procedure ClearCustomer;
    procedure RefreshCustomer;

    procedure RefreshSeviceOrder;

    procedure RefreshSOItems;
    procedure OpenSOItems;
    procedure CloseSOItems;

    procedure OpenServiceOrder;
    procedure CloseServiceOrder;
    procedure EditServiceOrder;
    procedure PostServiceOrder;
    procedure CreateServiceOrder;
    procedure RemoveServiceOrder;

    procedure OpenPayments;
    procedure ClosePayments;
    procedure RefreshPayments;

    procedure LoadImages;
    procedure RefreshPayment;

    procedure ServiceOrderControls;

    function ValidatePayment : Boolean;

    procedure GenerateSONum;

    procedure CheckPaymentDiscount;

    function CanDeleteItem : Boolean;
  public
    function Start : boolean;
  end;

implementation

uses uDM, uFrmSearchCustomer, uDMServiceOrder, uFrmServiceOrderFch, uMsgBox,
  uMsgConstant, uFrmServiceOrderPrint, uDMGlobal,
  uFrmUserMessager, uInvoicePayment, uFrmPaymentReceive, uDocumentInfo,
  uPassword, uSystemConst, uFrmServiceOrderDiscount, uFrmHistoryManage;

{$R *.dfm}

procedure TFrmServiceOrder.LoadImages;
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btnNewItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btnEditItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnRemoveItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_HISTORY, btnHistory.Glyph);
end;


procedure TFrmServiceOrder.ClearCustomer;
begin
  SubCustomer.Param := 'IDCUSTOMER=0;DisplayType=T;BackColor=clWhite;';
end;

procedure TFrmServiceOrder.RefreshCustomer;
begin
  SubCustomer.Param := Format('IDCUSTOMER=%S;DisplayType=T;BackColor=clWhite;', [IntToStr(FIDCustomer)]);
end;

procedure TFrmServiceOrder.FormCreate(Sender: TObject);
var
  sProduct, sSerial : String;
begin
  inherited;
  SubCustomer.CreateSubList;
  FrmServiceOrderSearch := TFrmServiceOrderSearch.Create(Self);

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sSerial          := 'S/N';
      sProduct         := 'Model';
    end;

    LANG_PORTUGUESE:
    begin
      sSerial          := 'N/S';
      sProduct         := 'Produto';
    end;

    LANG_SPANISH :
    begin
      sSerial          := 'N/S';
      sProduct         := 'Producto';
    end;
  end;


  if DM.fSystem.SrvParam[PARAM_SO_TYPE] = 1 then
    case DMGlobal.IDLanguage of
      LANG_ENGLISH:
      begin
        sSerial   := 'Plate Number';
        sProduct  := 'Car';
      end;

      LANG_PORTUGUESE:
      begin
        sSerial   := 'Número da placa';
        sProduct  := 'Carro';
      end;

      LANG_SPANISH :
      begin
        sSerial   := 'Número da placa';
        sProduct  := 'Carro';
      end;
    end;

  grdItemsDBModel.Caption        := sProduct;
  grdItemsDBSerialNumber.Caption := sSerial;

end;

function TFrmServiceOrder.Start: boolean;
begin
  FIDServiceOrder := 0;
  FSubTotal := 0;
  FTotalPaid := 0;

  LoadImages;

  CreateServiceOrder;

  btnConfig.Visible := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);
  CheckPaymentDiscount;

  ShowModal;
  Result := True;
end;

procedure TFrmServiceOrder.CreateServiceOrder;
begin

  CloseServiceOrder;

  FIDServiceOrder := DM.GetNextID('Ser_ServiceOrder.IDServiceOrder');
  FIDCustomer := 1;
  ClearCustomer;

  with cdsServiceOrder do
  begin
    CreateDataSet;
    Append;
    FieldByName('IDServiceOrder').AsInteger := FIDServiceOrder;
    FieldByName('IDCustomer').AsInteger     := FIDCustomer;
    FieldByName('IDUser').AsInteger         := DM.fUser.ID;
    FieldByName('IDSOStatus').AsInteger     := SO_STATUS_OPEN;
    FieldByName('IDStore').AsInteger        := DM.fStore.ID;
    //FieldByName('SONumber').AsString        := IntToStr(DM.GetNextID('Ser_ServiceOrder.SONumber' + IntToStr(DM.fStore.ID)));
    FieldByName('SODate').AsDateTime        := Now;
    Post;
    ApplyUpdates(0);
  end;

end;

procedure TFrmServiceOrder.CloseServiceOrder;
begin
  with cdsServiceOrder do
    if Active then
      Close;
end;

procedure TFrmServiceOrder.OpenServiceOrder;
begin
  with cdsServiceOrder do
    if not Active then
    begin
      Params.ParamByName('IDServiceOrder').Value := FIDServiceOrder;
      Open;
    end;
end;

procedure TFrmServiceOrder.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmServiceOrder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FrmServiceOrderSearch);
  RemoveServiceOrder;
  Action := caFree;
end;

procedure TFrmServiceOrder.cdsServiceOrderAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FIDCustomer := cdsServiceOrder.FieldByName('IDCustomer').AsInteger;
  RefreshCustomer;
  RefreshSOItems;
  RefreshSeviceOrder;
end;

procedure TFrmServiceOrder.imgCustomerClick(Sender: TObject);
var
  iIDCustomer : Integer;
begin
  inherited;

  if not FServiceOrderClosed then
    with TFrmSearchCustomer.Create(Self) do
    begin
      iIDCustomer := Start;
      if iIDCustomer <> -1 then
      begin
        FIDCustomer := iIDCustomer;
        EditServiceOrder;
        cdsServiceOrder.FieldByName('IDCustomer').AsInteger := FIDCustomer;
        PostServiceOrder;
        RefreshCustomer;
      end;
    end;

end;

procedure TFrmServiceOrder.EditServiceOrder;
begin

  with cdsServiceOrder do
    if Active then
      if not (State in dsEditModes) then
        Edit;
        
end;

procedure TFrmServiceOrder.PostServiceOrder;
begin
  with cdsServiceOrder do
    if Active then
      if (State in dsEditModes) then
      begin
        Post;
        ApplyUpdates(0);
      end;
end;

procedure TFrmServiceOrder.btnNewItemClick(Sender: TObject);
begin
  inherited;

  if not FServiceOrderClosed then
    if cdsServiceOrder.Active then
      with TFrmServiceOrderFch.Create(Self) do
        if Start(cdsServiceOrderIDServiceOrder.AsInteger, -1, FIDCustomer, FServiceOrderClosed) then
        begin
          RefreshSOItems;
          GenerateSONum;
        end;

end;

procedure TFrmServiceOrder.RefreshSOItems;
begin
  CloseSOItems;
  OpenSOItems;
end;

procedure TFrmServiceOrder.CloseSOItems;
begin
  with cdsSOItem do
    if Active then
      Close;
end;

procedure TFrmServiceOrder.OpenSOItems;
begin
  with cdsSOItem do
    if not Active then
    begin
      Params.ParamByName('IDServiceOrder').Value := FIDServiceOrder;
      Open;
    end;
end;

procedure TFrmServiceOrder.btnRemoveItemClick(Sender: TObject);
begin
  inherited;

  if not FServiceOrderClosed then
    with cdsSOItem do
      if Active then
        if not IsEmpty then
        begin
          if not Password.HasFuncRight(76) then
            MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly)
          else
          if not CanDeleteItem then
          begin
            MsgBox(MSG_CRT_NOT_DEL_SO_ITEM, vbCritical + vbOKOnly)
          end
          else
          begin
            DMServiceOrder.DeleteSOItem(cdsSOItem.FieldByName('IDSOItem').AsInteger);
            RefreshSOItems;
          end;
        end;
        
end;

procedure TFrmServiceOrder.btnEditItemClick(Sender: TObject);
var
  FSO, FSOItem : Integer;
begin
  inherited;

  with cdsSOItem do
    if Active and (not IsEmpty) then
    begin
      FSO     := cdsServiceOrderIDServiceOrder.AsInteger;
      FSOItem := cdsSOItem.FieldByName('IDSOItem').AsInteger;
      with TFrmServiceOrderFch.Create(Self) do
        if Start(FSO, FSOItem, FIDCustomer, FServiceOrderClosed) then
          RefreshSOItems;
    end;

end;

procedure TFrmServiceOrder.imgNewSOClick(Sender: TObject);
begin
  inherited;

  RemoveServiceOrder;
  CreateServiceOrder;

end;

procedure TFrmServiceOrder.RemoveServiceOrder;
begin

  if cdsServiceOrder.Active then
    if cdsSOItem.Active and cdsSOItem.IsEmpty then
    begin
      DMServiceOrder.DeleteSO(cdsServiceOrderIDServiceOrder.AsInteger);
      CloseServiceOrder;
    end else
    begin
      PostServiceOrder;
      CloseServiceOrder;
    end;

end;

procedure TFrmServiceOrder.Image4Click(Sender: TObject);
var
  iID : Integer;
begin
  inherited;

  iID := -1;

  iID := FrmServiceOrderSearch.Start;

  if iID <> -1 then
  begin
    FIDServiceOrder := iID;
    RemoveServiceOrder;
    OpenServiceOrder;
  end;
  
end;

procedure TFrmServiceOrder.Image5Click(Sender: TObject);
begin
  inherited;

  if cdsServiceOrder.Active and not cdsServiceOrder.IsEmpty then
    with TFrmServiceOrderPrint.Create(Self) do
      Start(cdsServiceOrder.FieldByName('IDServiceOrder').AsString);
      
end;

procedure TFrmServiceOrder.RefreshPayment;
begin

  if grdItemsDB.DataController.Summary.FooterSummaryValues[0] <> null then
    FSubTotal := grdItemsDB.DataController.Summary.FooterSummaryValues[0]
  else
    FSubTotal := 0;

  FTotalPaid := cdsPayments.FieldByName('Paid').AsCurrency;

  lbAmountPaid.Caption := FormatCurr('#,##0.00', FTotalPaid);
  lbNetDue.Caption := FormatCurr('#,##0.00', Abs(FSubTotal - FTotalPaid));

  btnPayments.Visible := (FTotalPaid <> 0);
  btnPayAmount.Visible := (Abs(FSubTotal - FTotalPaid) <> 0);

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      if FTotalPaid = 0 then
      begin
        lbPaymentStatus.Caption    := 'UNPAID';
        lbPaymentStatus.Font.Color := clRed;
        lbNetDue.Font.Color        := clRed;
      end
      else if Abs(FSubTotal - FTotalPaid) = 0 then
      begin
        lbPaymentStatus.Caption    := 'PAID';
        lbPaymentStatus.Font.Color := clBlue;
        lbNetDue.Font.Color        := clBlue;
      end
      else
      begin
        lbPaymentStatus.Caption := 'PARTIAL PAID';
        lbPaymentStatus.Font.Color := $000080FF;
        lbNetDue.Font.Color        := $000080FF;
      end
    end;

    LANG_PORTUGUESE:
    begin
      if FTotalPaid = 0 then
      begin
        lbPaymentStatus.Caption    := 'SEM PAGAMENTO';
        lbPaymentStatus.Font.Color := clRed;
        lbNetDue.Font.Color        := clRed;
      end
      else if Abs(FSubTotal - FTotalPaid) = 0 then
      begin
        lbPaymentStatus.Caption    := 'PAGO';
        lbPaymentStatus.Font.Color := clBlue;
        lbNetDue.Font.Color        := clBlue;
      end
      else
      begin
        lbPaymentStatus.Caption    := 'PARCIALMENTE PAGO';
        lbPaymentStatus.Font.Color := $000080FF;
        lbNetDue.Font.Color        := $000080FF;
      end
    end;

    LANG_SPANISH :
    begin
      if FTotalPaid = 0 then
      begin
        lbPaymentStatus.Caption    := 'SEM PAGAMENTO';
        lbPaymentStatus.Font.Color := clRed;
        lbNetDue.Font.Color        := clRed;
      end
      else if Abs(FSubTotal - FTotalPaid) = 0 then
      begin
        lbPaymentStatus.Caption    := 'PAGO';
        lbPaymentStatus.Font.Color := clBlue;
        lbNetDue.Font.Color        := clBlue;
      end
      else
      begin
        lbPaymentStatus.Caption    := 'PARCIALMENTE PAGO';
        lbPaymentStatus.Font.Color := $000080FF;
        lbNetDue.Font.Color        := $000080FF;
      end
    end;
  end;
end;

procedure TFrmServiceOrder.ClosePayments;
begin
  with cdsPayments do
    if Active then
      Close;
end;

procedure TFrmServiceOrder.OpenPayments;
begin
  with cdsPayments do
    if not Active then
    begin
      Params.ParamByName('IDServiceOrder').Value := FIDServiceOrder;
      Open;
      RefreshPayment;
      ServiceOrderControls;
    end;
end;

procedure TFrmServiceOrder.cdsSOItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  OpenPayments;
end;

procedure TFrmServiceOrder.cdsSOItemAfterClose(DataSet: TDataSet);
begin
  inherited;
  ClosePayments;
end;

procedure TFrmServiceOrder.btnMessageClick(Sender: TObject);
begin
  inherited;

  if DM.fUser.ID <> 0 then
    with TFrmUserMessager.Create(Self) do
      Start;
  
end;

procedure TFrmServiceOrder.btnPaymentsClick(Sender: TObject);
begin
  inherited;

  with TInvoicePayment.Create(Self) do
    StartServiceOrder(FIDServiceOrder);
    
end;

procedure TFrmServiceOrder.btnPayAmountClick(Sender: TObject);
var
  FDocumentInfo : TDocumentInfo;
  FChange: Double;
begin
  inherited;

  if ValidatePayment then
  begin

    if (FTotalPaid = 0) and FHasPaymentDiscount then
      with TFrmServiceOrderDiscount.Create(Self) do
      begin
        Start(1, cdsServiceOrderIDServiceOrder.AsInteger);
        RefreshSOItems;
      end;

    FDocumentInfo := TDocumentInfo.Create;
    try
      with FDocumentInfo do
      begin
        LayAway          := False;
        DocumentTotal    := FSubTotal;
        IDTouristGroup   := 0;
        IDCustomer       := FIDCustomer;
        ID               := FIDServiceOrder;
        OtherComissionID := 0;
        IDStore          := DM.fStore.ID;
        DocumentType     := dtServiceOrder;
      end;

      with TFrmPaymentReceive.Create(Self) do
        Start(FDocumentInfo, FIDCashRegMov, FChange);

      cdsServiceOrder.Refresh;
      RefreshPayments;
      ServiceOrderControls;

    finally
      FreeAndNil(FDocumentInfo);
      end;
  end;

end;

procedure TFrmServiceOrder.RefreshPayments;
begin
  ClosePayments;
  OpenPayments;
end;

function TFrmServiceOrder.ValidatePayment: Boolean;
begin

  Result := False;

  if FIDCustomer <= 1 then
  begin
    MsgBox(MSG_CRT_NO_CUSTUMER, vbCritical + vbOKOnly);
    imgCustomerClick(Self);
    Exit;
  end;

  case DM.CheckCashRegState(DM.fCashRegister.IDDefault, FIDCashRegMov) of
    CASHREG_OPEN: Result := True;
    CASHREG_CLOSE: begin
                    MsgBox(MSG_CRT_NO_OPEN_CASREG, vbOKOnly + vbInformation);
                    Result := False;
                    Exit;
                   end;
    else begin
         Result := False;
         Exit;
         end;
  end;

  Result := True;
end;

procedure TFrmServiceOrder.ServiceOrderControls;
begin

  FServiceOrderClosed := (FSubTotal = FTotalPaid)
                         and (cdsServiceOrder.FieldByName('IDSOStatus').AsInteger = SO_STATUS_CLOSE);

  scStore.Enabled   := not FServiceOrderClosed;
  scUser.Enabled    := not FServiceOrderClosed;
  scStatus.Enabled  := not FServiceOrderClosed;
  dateStart.Enabled := not FServiceOrderClosed;

  RefreshSeviceOrder;
end;

procedure TFrmServiceOrder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of

    VK_F2 : begin //Add New
            if (btnNewItem.Enabled) and (btnNewItem.Visible) then
               btnNewItemClick(Sender);
            end;

    VK_F3 : begin //Edit
            if (btnEditItem.Enabled) and (btnEditItem.Visible) then
               btnEditItemClick(Sender);
            end;

    VK_F4 : begin //Del
            if (btnRemoveItem.Enabled) and (btnRemoveItem.Visible) then
               btnRemoveItemClick(Sender);
            end;

  (*  VK_F5 : begin //Preview
            if (btPrint.Enabled) and (btPrint.Visible) then
               CommandClick(btPrint);
            end;

    VK_F6 : begin //SpreeadSheet
            if (btExcel.Enabled) and (btExcel.Visible) then
               btExcelClick(nil);
            end; *)

   end;
end;

procedure TFrmServiceOrder.GenerateSONum;
begin

  with cdsServiceOrder do
    if Active then
      if (FieldByName('SONumber').AsString = '') then
      begin
        Edit;
        FieldByName('SONumber').AsString := IntToStr(DM.GetNextID('Ser_ServiceOrder.SONumber' + IntToStr(DM.fStore.ID)));
        Post;
        ApplyUpdates(0);
      end;

end;

procedure TFrmServiceOrder.btnConfigClick(Sender: TObject);
begin
  inherited;

  with TFrmServiceOrderDiscount.Create(Self) do
    Start(0, cdsServiceOrderIDServiceOrder.AsInteger);

  CheckPaymentDiscount;

end;

procedure TFrmServiceOrder.CheckPaymentDiscount;
begin

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT Count(IDPaymentDiscount) FROM Sal_PaymentDiscount');
    Open;
    FHasPaymentDiscount := (not IsEmpty);
  finally
    Close;
  end;

end;

procedure TFrmServiceOrder.RefreshSeviceOrder;
begin
  if cdsServiceOrderIDSOStatus.AsInteger = SO_STATUS_CLOSE then
  begin
    scStatus.Visible    := False;
    lbCompleted.Visible := True;
  end
  else
  begin
    scStatus.Visible    := True;
    lbCompleted.Visible := False;
  end;

end;

function TFrmServiceOrder.CanDeleteItem: Boolean;
begin

  with DM.quFreeSQL do
  try
    if Active then
      Close;
    SQL.Add('SELECT SIP.IDSOItemProduct');
    SQL.Add('FROM Ser_SOItem SI (NOLOCK)');
    SQL.Add('JOIN Ser_SOItemProduct SIP (NOLOCK) ON (SIP.IDSOItem = SI.IDSOItem)');
    SQL.Add('WHERE SI.IDSOItem = ' + IntToStr(cdsSOItemIDSOItem.AsInteger));
    Open;
    Result := (RecordCount = 0);
  finally
    Close;
  end;

end;

procedure TFrmServiceOrder.btnHistoryClick(Sender: TObject);
begin
  inherited;
  with TFrmHistoryManage.Create(Self) do
    StartSO(cdsServiceOrderIDServiceOrder.AsInteger);
end;

end.
