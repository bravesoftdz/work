unit uFrmMainPOSInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ComCtrls, ADODB, DBCtrls, MemoStr, Mask, Spin, SuperComboADO, DateBox,
  Grids, DBGrids, SMDBGrid, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxSpinEdit, SuperEdit, SuperEditCurrency;

const
  TAB_ALL           = -1;
  TAB_DISCOUNT      = 0;
  TAB_OTHER_EXP     = 1;
  TAB_NOTES         = 2;
  TAB_DELIVERY      = 3;
  TAB_SPECIAL_PRICE = 4;

type
  TFrmMainPOSInfo = class(TFrmParentAll)
    pgInvoiceInfo: TPageControl;
    tsNotes: TTabSheet;
    tsDiscount: TTabSheet;
    tsDelivery: TTabSheet;
    dsInvoice: TDataSource;
    EditNote: TDbMemoStr;
    dbPrintNotes: TDBCheckBox;
    dsValues: TDataSource;
    pnlSpecialDiscount: TPanel;
    Label1: TLabel;
    btApplyPriceManager: TBitBtn;
    cbxType: TComboBox;
    edtDollarDiscount: TEdit;
    pnlConfirmDeliver: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    Label28: TLabel;
    lbConfirmDelivery: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    EditDelDate: TDBDateBox;
    EditDelAddress: TDBEdit;
    edtDelOBS: TDBEdit;
    btnDelivery: TBitBtn;
    Panel8: TPanel;
    Label4: TLabel;
    cmbDelType: TDBSuperComboADO;
    btSplitHold: TBitBtn;
    tsOtherCosts: TTabSheet;
    Label29: TLabel;
    Label30: TLabel;
    btAddCost: TSpeedButton;
    btRemoveCost: TSpeedButton;
    grdSerial: TSMDBGrid;
    editCustoUnitario: TEdit;
    scCostType: TSuperComboADO;
    quAditionalExpenses: TADODataSet;
    quAditionalExpensesCostType: TStringField;
    quAditionalExpensesIDInvoiceCost: TIntegerField;
    quAditionalExpensesIDCostType: TIntegerField;
    quAditionalExpensesAmount: TBCDField;
    dsAditinalExpenses: TDataSource;
    tsSprecialPrice: TTabSheet;
    Panel5: TPanel;
    Label7: TLabel;
    btMakeSpecialPrice: TSpeedButton;
    dbSpecialPrice: TDBEdit;
    spnSpecialDiscount: TcxSpinEdit;
    edtDisTotalInv: TSuperEditCurrency;
    lbTotal: TLabel;
    procedure btMakeSpecialPriceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btApplyPriceManagerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure cbxTypeChange(Sender: TObject);
    procedure cmbDelTypeSelectItem(Sender: TObject);
    procedure btnDeliveryClick(Sender: TObject);
    procedure scCostTypeSelectItem(Sender: TObject);
    procedure editCustoUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure btRemoveCostClick(Sender: TObject);
    procedure tsOtherCostsShow(Sender: TObject);
    procedure btAddCostClick(Sender: TObject);
    procedure editCustoUnitarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDisTotalInvCurrChange(Sender: TObject);
    procedure edtDollarDiscountChange(Sender: TObject);
    procedure spnSpecialDiscountPropertiesChange(Sender: TObject);
  private
    sDeliveryConf,
    sDeliveryNConf,
    sDeliveryOK: String;

    FInvoiceInfo: TADOQuery;
    FPreSaleValue: TADOStoredProc;

    procedure CloseInvCosts;
    procedure OpenInvCosts;
    procedure RefreshInvCosts;
    procedure SaveInvoiceInfo;
    procedure RefreshInvoiceValues;
    function IsDeliveryEnabled: Boolean;
    procedure RefreshDeliveryInfo;
  public
    function Start(quInvoiceInfo: TADOQuery;
                   quPreSaleValue: TADOStoredProc; Option : Integer) : Boolean;
  end;

implementation

uses uDM, uMakeSpcPrice, uSystemConst, uNumericFunctions, uPassword,
     uDMGlobal, uCharFunctions, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmMainPOSInfo }

function TFrmMainPOSInfo.Start(quInvoiceInfo: TADOQuery;
   quPreSaleValue : TADOStoredProc; Option : Integer): Boolean;
var
  i : Integer;
begin
  FInvoiceInfo  := quInvoiceInfo;
  FPreSaleValue := quPreSaleValue;

  dsInvoice.DataSet := FInvoiceInfo;
  dsValues.DataSet  := FPreSaleValue;

  if tsDelivery.TabVisible then
  begin
    pnlConfirmDeliver.Visible := IsDeliveryEnabled;
    RefreshDeliveryInfo;
  end;

  if Option <> TAB_ALL then
  begin
    for i := 0 to pgInvoiceInfo.PageCount -1 do
      if (i = Option) or (i = TAB_NOTES) then
         pgInvoiceInfo.Pages[i].TabVisible := True
      else
         pgInvoiceInfo.Pages[i].TabVisible := False;
    pgInvoiceInfo.ActivePageIndex := Option;
  end;

  if DM.fSystem.SrvParam[PARAM_APPLY_INV_DISCOUNT_ON_ITEMS] then
  begin
    lbTotal.Visible := False;
    edtDisTotalInv.Visible := False;
  end
  else
  begin
    lbTotal.Visible := True;
    edtDisTotalInv.Visible := True;
    edtDisTotalInv.Text  := FormatFloat('#,#0.00', FPreSaleValue.FieldByName('TotalInvoice').AsCurrency +
                                                   FPreSaleValue.FieldByName('InvoiceDiscount').AsCurrency);

  end;

  Result := (ShowModal = mrOK);
  SaveInvoiceInfo;
end;

procedure TFrmMainPOSInfo.btMakeSpecialPriceClick(Sender: TObject);
begin
  inherited;
  with TFrmMakeSpcPrice.Create(Self) do
    if Start(FInvoiceInfo.FieldByName('IDPreSale').AsInteger,
             FPreSaleValue.FieldByName('SpecialPriceID').AsInteger) then
      RefreshInvoiceValues;
end;

procedure TFrmMainPOSInfo.FormCreate(Sender: TObject);
begin
  inherited;
  pnlSpecialDiscount.visible := Password.HasFuncRight(41);

  tsOtherCosts.TabVisible := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_OTHER_COSTS];
  tsDelivery.TabVisible   := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_DELIVERY];
  tsDiscount.TabVisible   := DM.fSystem.SrvParam[PARAM_INVOICE_SHOW_TAB_DISCOUNT];

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sDeliveryConf  := 'Confirm Delivery';
      sDeliveryNConf := 'Cancel Delivery';
      sDeliveryOK    := 'Delivery Confirmed';
    end;

    LANG_PORTUGUESE:
    begin
      sDeliveryConf  := 'Confirmar Entrega';
      sDeliveryNConf := 'Desmarcar Entrega';
      sDeliveryOK    := 'ENTREGA CONFIRMADA';
    end;

    LANG_SPANISH:
    begin
      sDeliveryConf  := 'Entrega Confirmó';
      sDeliveryNConf := 'Entrega Canceló';
      sDeliveryOK    := 'Confirmó Entrega';
    end;
  end;
end;

procedure TFrmMainPOSInfo.btApplyPriceManagerClick(Sender: TObject);
var
  fPercentDisc : Double;
  fExempt : Boolean;
begin
  inherited;
(*
  if DM.fSystem.SrvParam[PARAM_APPLY_INV_DISCOUNT_ON_ITEMS] then
  begin
    fPercentDisc := 0;
    case cbxType.ItemIndex of
      0: fPercentDisc := spnSpecialDiscount.Value;
      1: fPercentDisc := (MyStrToCurrency(edtDollarDiscount.Text)*100)/ FPreSaleValue.FieldByName('SubTotal').AsCurrency;
    end;

    fExempt := FInvoiceInfo.FieldByName('TaxIsent').AsBoolean;

    DM.fPOS.ManageDiscount(FInvoiceInfo.FieldByName('IDPreSale').AsInteger,
                           fPercentDisc,
                           Now,
                           DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE],
                           Password.HasFuncRight(9),
                           False);

    if not DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE] and fExempt then
      DM.fPOS.ExemptTax(FInvoiceInfo.FieldByName('IDPreSale').AsInteger, True);

  end
  else
  begin
  *)
    case cbxType.ItemIndex of
      // Antonio July 03, 2013 was lacking subtracts Item of Discount ("Item Discount" label in cash register screen) from Invoice
      0 : fPercentDisc := (FPreSaleValue.FieldByName('Subtotal').AsCurrency - FPreSaleValue.fieldByName('ItemDiscount').Value) * (spnSpecialDiscount.Value / 100);
      1 : fPercentDisc := MyStrToCurrency(edtDollarDiscount.Text);
    end;

    DM.RunSQL('UPDATE Invoice SET InvoiceDiscount = ' + MyFormatCur(fPercentDisc, '.') + ' WHERE IDPreSale = ' +  FInvoiceInfo.FieldByName('IDPreSale').AsString);

    // Antonio July 02, 2013
    dm.fpos.RecalcTax(fInvoiceInfo.fieldByName('IdPresale').value, now);


 // end;

  RefreshInvoiceValues;

end;

procedure TFrmMainPOSInfo.SaveInvoiceInfo;
begin
  with FInvoiceInfo do
    if Active and (State in dsEditModes) then
      Post;
end;

procedure TFrmMainPOSInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmMainPOSInfo.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmMainPOSInfo.RefreshInvoiceValues;
begin
  Screen.Cursor := crHourGlass;

  with FPreSaleValue do
  begin
    if Active then
      Close;
    Parameters.ParambyName('@PreSaleID').Value := FInvoiceInfo.FieldByName('IDPreSale').AsInteger;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TFrmMainPOSInfo.cbxTypeChange(Sender: TObject);
begin
  inherited;
  case cbxType.ItemIndex of
    0:
    begin
      spnSpecialDiscount.Visible := True;
      edtDollarDiscount.Visible  := False;
      edtDisTotalInv.Enabled     := False;
    end;
    1:
    begin
      spnSpecialDiscount.Visible := False;
      edtDollarDiscount.Visible  := True;
      edtDollarDiscount.Text     := '0';
      edtDisTotalInv.Enabled     := True;
    end;
  end;

  if not DM.fSystem.SrvParam[PARAM_APPLY_INV_DISCOUNT_ON_ITEMS] then
    edtDisTotalInv.Text := FormatFloat('#,#0.00', FPreSaleValue.FieldByName('TotalInvoice').AsCurrency +
                                                  FPreSaleValue.FieldByName('InvoiceDiscount').AsCurrency);

end;

procedure TFrmMainPOSInfo.cmbDelTypeSelectItem(Sender: TObject);
var
  fIsExchange: Variant;
begin
  inherited;
  pnlConfirmDeliver.Visible := IsDeliveryEnabled;

  {Implementar endereco do cliente
  if pnlConfirmDeliver.Visible and (FInvoiceInfo.FieldByName('DeliverAddress').AsString = '') then
  begin
    FInvoiceInfo.Edit;
    FInvoiceInfo.FieldByName('DeliverAddress').AsString.AsString := fCustomerAddress;
  end;
  }

  fIsExchange := cmbDelType.GetFieldByName('CanExchangeItem');
  {
  if fIsExchange <> Null then
    bIsExchangeItem := StrToBoolDef(fIsExchange, False)
  else
    bIsExchangeItem := False;
  }
end;

function TFrmMainPOSInfo.IsDeliveryEnabled: Boolean;
begin
  if cmbDelType.LookUpValue <> '' then
    Result := (UpperCase(DM.DescCodigo(['IDDeliverType'], [cmbDelType.LookUpValue], 'DeliverType', 'CanConfirmDeliver')) <> 'FALSE');
end;

procedure TFrmMainPOSInfo.btnDeliveryClick(Sender: TObject);
begin
  inherited;
  with FInvoiceInfo do
  begin
    if not (State in dsEditModes) then
      FInvoiceInfo.Edit;

    FInvoiceInfo.FieldByName('DeliverConfirmation').AsBoolean :=
       not FInvoiceInfo.FieldByName('DeliverConfirmation').AsBoolean;
  end;

  RefreshDeliveryInfo;
end;

procedure TFrmMainPOSInfo.RefreshDeliveryInfo;
begin
  if FInvoiceInfo.FieldByName('DeliverConfirmation').AsBoolean then
  begin
    lbConfirmDelivery.Caption := sDeliveryOK;
    btnDelivery.Caption       := sDeliveryNConf;
  end
  else
  begin
    lbConfirmDelivery.Caption := '';
    btnDelivery.Caption       := sDeliveryConf;
  end;
end;

procedure TFrmMainPOSInfo.scCostTypeSelectItem(Sender: TObject);
begin
  inherited;
  editCustoUnitario.Text := DM.DescCodigo(['IDCostType'], [scCostType.LookUpValue],
                                           'CostType', 'DefaultValue');
  if editCustoUnitario.CanFocus then
    editCustoUnitario.SetFocus;
end;

procedure TFrmMainPOSInfo.editCustoUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

procedure TFrmMainPOSInfo.btRemoveCostClick(Sender: TObject);

  function TestDeleteCosts : Boolean;
  begin
    Result := True;
    if not (quAditionalExpenses.Active) then
       Exit;
    Result := (quAditionalExpensesIDInvoiceCost.AsInteger <> 0);
    if not Result then
       MsgBox(MSG_CRT_ERROR_DELETING, vbCritical + vbOkOnly);
  end;

begin
  inherited;
  if not TestDeleteCosts then
    Exit;

  DM.fPOS.DeleteInvoiceAdtionalCost(quAditionalExpensesIDInvoiceCost.AsInteger);
  RefreshInvCosts;
  RefreshInvoiceValues;
end;

procedure TFrmMainPOSInfo.RefreshInvCosts;
begin
  CloseInvCosts;
  OpenInvCosts;
end;

procedure TFrmMainPOSInfo.CloseInvCosts;
begin
  with quAditionalExpenses do
    if Active then
      Close;
end;

procedure TFrmMainPOSInfo.OpenInvCosts;
begin
  with quAditionalExpenses do
    if not Active then
    begin
      Parameters.ParamByName('IDPreSale').Value := FInvoiceInfo.FieldByName('IDPreSale').AsInteger;
      Open;
    end;
end;

procedure TFrmMainPOSInfo.tsOtherCostsShow(Sender: TObject);
begin
  inherited;
  OpenInvCosts;
end;

procedure TFrmMainPOSInfo.btAddCostClick(Sender: TObject);

  function ValidateCosts: Boolean;
  begin
    Result := False;

    if scCostType.LookUpValue = '' then
       begin
       MsgBox(MSG_INF_CHOOSE_COSTTYPE, vbCritical + vbOkOnly);
       if scCostType.CanFocus then
          scCostType.SetFocus;
       Exit;
       end;

    if (MyStrToMoney(editCustoUnitario.Text) = 0) then
       begin
       MsgBox(MSG_CRT_INVAL_COST_PRICE, vbCritical + vbOkOnly);
       if editCustoUnitario.CanFocus then
          editCustoUnitario.SetFocus;
       Exit;
       end;
    Result := True;
  end;

begin
  inherited;
  if not ValidateCosts then
    Exit;

  DM.fPOS.AddInvoiceAdtionalCost(FInvoiceInfo.FieldByName('IDPreSale').AsInteger,
                                 StrToInt(scCostType.LookUpValue),
                                 MyStrToMoney(editCustoUnitario.Text));
  scCostType.SetFocus;
  editCustoUnitario.Clear;
  RefreshInvCosts;
  RefreshInvoiceValues;
end;

procedure TFrmMainPOSInfo.editCustoUnitarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    btAddCostClick(Sender);
end;

procedure TFrmMainPOSInfo.edtDisTotalInvCurrChange(Sender: TObject);
begin
  inherited;

  if edtDollarDiscount.Visible then
    if edtDisTotalInv.Focused then
      edtDollarDiscount.Text := FormatFloat('#,#0.00',
         FPreSaleValue.FieldByName('TotalInvoice').AsCurrency +
         FPreSaleValue.FieldByName('InvoiceDiscount').AsCurrency -
         MyStrToMoney(edtDisTotalInv.Text));

end;

procedure TFrmMainPOSInfo.edtDollarDiscountChange(Sender: TObject);
begin
  inherited;

  if edtDollarDiscount.Focused then
    if not DM.fSystem.SrvParam[PARAM_APPLY_INV_DISCOUNT_ON_ITEMS] then
      edtDisTotalInv.Text := FormatFloat('#,#0.00',
         FPreSaleValue.FieldByName('TotalInvoice').AsCurrency +
         FPreSaleValue.FieldByName('InvoiceDiscount').AsCurrency -
         MyStrToMoney(edtDollarDiscount.Text));

end;

procedure TFrmMainPOSInfo.spnSpecialDiscountPropertiesChange(
  Sender: TObject);
begin
  inherited;

  if btApplyPriceManager.enabled then
    edtDisTotalInv.Text := FormatFloat('#,#0.00',
                                       FPreSaleValue.FieldByName('TotalInvoice').AsCurrency +
                                       FPreSaleValue.FieldByName('InvoiceDiscount').AsCurrency -
                                       (FPreSaleValue.FieldByName('TotalInvoice').AsCurrency * (spnSpecialDiscount.Value / 100)));

end;

end.
