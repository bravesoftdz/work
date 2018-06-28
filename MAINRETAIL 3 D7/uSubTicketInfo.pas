unit uSubTicketInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, PowerADOQuery,
  StdCtrls, DBCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TSubTicketInfo = class(TParentSub)
    quStore: TPowerADOQuery;
    dsStore: TDataSource;
    quStoreTicketHeader: TMemoField;
    quStoreTicketLayawayFooter: TMemoField;
    quStoreTicketTaxIsemptFooter: TMemoField;
    quStoreTicketFooter: TMemoField;
    quStorePrintTicketHeader: TBooleanField;
    quStorePrintLayawayFooter: TBooleanField;
    quStorePrintTaxInsemptFooter: TBooleanField;
    quStorePrintTicketFooter: TBooleanField;
    pgTicket: TPageControl;
    tsHeader: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Label13: TLabel;
    Label12: TLabel;
    memHeader: TDBMemo;
    DBCheckBox1: TDBCheckBox;
    DBMemo4: TDBMemo;
    DBCheckBox2: TDBCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label16: TLabel;
    Label14: TLabel;
    memLayaway: TDBMemo;
    DBCheckBox3: TDBCheckBox;
    Label18: TLabel;
    Label17: TLabel;
    DBMemo3: TDBMemo;
    DBCheckBox4: TDBCheckBox;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    memDetail: TDBMemo;
    quStoreTicketDetail: TMemoField;
    quStoreTicketTotals: TMemoField;
    Label7: TLabel;
    Label8: TLabel;
    memTotals: TDBMemo;
    pnlbtnDetail: TPanel;
    Label9: TLabel;
    btnModelD: TSpeedButton;
    btnDescD: TSpeedButton;
    btnSPD: TSpeedButton;
    btnBarcodeD: TSpeedButton;
    btnSerialNumD: TSpeedButton;
    btnQtyD: TSpeedButton;
    btnUnitPriceD: TSpeedButton;
    btnUnitTotal: TSpeedButton;
    btPrint: TSpeedButton;
    Panel2: TPanel;
    Label11: TLabel;
    btnDateH: TSpeedButton;
    btnTimeH: TSpeedButton;
    SpeedButton9: TSpeedButton;
    btnCustomerH: TSpeedButton;
    btnMediaH: TSpeedButton;
    btnCashier: TSpeedButton;
    btnHoldH: TSpeedButton;
    btnInvoiceH: TSpeedButton;
    Panel1: TPanel;
    Label10: TLabel;
    btnNoTaxableT: TSpeedButton;
    btnTaxableT: TSpeedButton;
    btnTaxT: TSpeedButton;
    btnTotalT: TSpeedButton;
    btnCashRecT: TSpeedButton;
    btnChangeT: TSpeedButton;
    btnDiscount: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Panel3: TPanel;
    Label15: TLabel;
    btnPayTotalL: TSpeedButton;
    btnPayBalL: TSpeedButton;
    SpeedButton3: TSpeedButton;
    btnPayDateT: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    btnSPNumberD: TSpeedButton;
    btnRightD: TSpeedButton;
    SpeedButton4: TSpeedButton;
    btRestoreHeader: TSpeedButton;
    btRestoreDetail: TSpeedButton;
    btRestoreTotal: TSpeedButton;
    btRestoreLayaway: TSpeedButton;
    btnRefund: TSpeedButton;
    btnItemDiscount: TSpeedButton;
    btnSubTotal: TSpeedButton;
    btnManufacturer: TSpeedButton;
    btnUnit: TSpeedButton;
    btnCategText: TSpeedButton;
    procedure quStoreBeforeClose(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnModelDClick(Sender: TObject);
    procedure btnDescDClick(Sender: TObject);
    procedure btnSPDClick(Sender: TObject);
    procedure btnBarcodeDClick(Sender: TObject);
    procedure btnSerialNumDClick(Sender: TObject);
    procedure btnQtyDClick(Sender: TObject);
    procedure btnUnitPriceDClick(Sender: TObject);
    procedure btnUnitTotalClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure btnDateHClick(Sender: TObject);
    procedure btnTimeHClick(Sender: TObject);
    procedure btnCustomerHClick(Sender: TObject);
    procedure btnMediaHClick(Sender: TObject);
    procedure btnCashierClick(Sender: TObject);
    procedure btnHoldHClick(Sender: TObject);
    procedure btnInvoiceHClick(Sender: TObject);
    procedure btnNoTaxableTClick(Sender: TObject);
    procedure btnTaxableTClick(Sender: TObject);
    procedure btnTaxTClick(Sender: TObject);
    procedure btnTotalTClick(Sender: TObject);
    procedure btnCashRecTClick(Sender: TObject);
    procedure btnChangeTClick(Sender: TObject);
    procedure btnDiscountClick(Sender: TObject);
    procedure btnPayDateTClick(Sender: TObject);
    procedure btnPayTotalLClick(Sender: TObject);
    procedure btnPayBalLClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnSPNumberDClick(Sender: TObject);
    procedure btnRightDClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure btRestoreHeaderClick(Sender: TObject);
    procedure btRestoreDetailClick(Sender: TObject);
    procedure btRestoreTotalClick(Sender: TObject);
    procedure btRestoreLayawayClick(Sender: TObject);
    procedure btnRefundClick(Sender: TObject);
    procedure btnItemDiscountClick(Sender: TObject);
    procedure btnSubTotalClick(Sender: TObject);
    procedure btnManufacturerClick(Sender: TObject);
    procedure btnUnitClick(Sender: TObject);
    procedure btnCategTextClick(Sender: TObject);
  private
    { Private declarations }
    sHi,
    sCashier1,
    sCashier2,
    sMedia,
    sTodayIs,
    sNoTaxAble,
    sLayawayNum,
    sIInvNum,
    sItems,
    sSubTotal,
    sTax,
    sTotal,
    sCashRec,
    sChange,
    sPayTotals,
    sPayBal,
    sPayments,
    sDiscount,
    sItemDiscount,
    sRefund: String;
    fIDStore   : Integer;
    procedure InsertDetail(text:String);
    procedure InsertHeader(text:String);
    procedure InsertTotals(text:String);
    procedure InsertLayaway(text:String);
  protected
    procedure DataSetPost;
    procedure DateSetCancel;
    procedure DateSetEdit;
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
    procedure AfterSetParam; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uDM, uParamFunctions, uSystemConst, uFrmPreviewTicket, uDMGlobal;

procedure TSubTicketInfo.AfterSetParam;
begin
  fIDStore := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
  DataSetRefresh;
end;

procedure TSubTicketInfo.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubTicketInfo.DataSetPost;
begin
  with quStore do
    if Active then
       if State in dsEditModes then
          Post;
end;

procedure TSubTicketInfo.DateSetCancel;
begin
  with quStore do
    if Active then
       if State in dsEditModes then
          Cancel;
end;

procedure TSubTicketInfo.DateSetEdit;
begin
  with quStore do
    if Active then
       if not (State in dsEditModes) then
          Edit;
end;

procedure TSubTicketInfo.DataSetOpen;
begin
  with quStore do
    if not Active then
       begin
       Parameters.ParambyName('IDStore').Value := fIDStore;
       Open;
       end;
end;

procedure TSubTicketInfo.DataSetClose;
begin
  with quStore do
    if Active then
       Close;
end;

procedure TSubTicketInfo.quStoreBeforeClose(DataSet: TDataSet);
begin
  inherited;
  DataSetPost;
end;

procedure TSubTicketInfo.FormDestroy(Sender: TObject);
begin
  DataSetClose;
  inherited;
end;

procedure TSubTicketInfo.FormCreate(Sender: TObject);
begin
  inherited;
  pgTicket.ActivePageIndex := 0;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sNoTaxAble   := '  Non taxable:';
           sDiscount    := 'Invoice Discount:';
           sItemDiscount:= 'Item Discount:';
           sRefund      := '       Refund:';
           sHi          := 'Hi';
           sCashier1    := 'I am';
           sCashier2    := 'your cashier.';
           sMedia       := 'Media:';
           sTodayIs     := 'Today is ';
           sLayawayNum  := 'Hold/Layaway#';
           sIInvNum     := 'Invoice#';
           sSubTotal    := 'SubTotal:';
           sTax         := 'Tax:';
           sTotal       := 'Total:';
           sCashRec     := 'Cash Received:';
           sChange      := 'Change:';
           sPayTotals   := '        Payment(s) total: ';
           sPayBal      := '                 Balance: ';
           sPayments    := '---------------- Payments --------------';
           end;

     LANG_PORTUGUESE :
           begin
           sNoTaxAble   := 'Não Tributável:';
           sDiscount    := ' Desconto nota:';
           sItemDiscount:= 'Desconto itens:';
           sRefund      := '     Devolução:';
           sHi          := 'Oi';
           sCashier1    := 'Me chamo';
           sCashier2    := 'seu caixa.';
           sMedia       := 'Mídia:';
           sTodayIs     := 'Hoje é ';
           sLayawayNum  := 'Nota Pend/Crediário:';
           sIInvNum     := 'N. da Nota:';
           sSubTotal    := 'SubTotal:';
           sTax         := 'Taxa:';
           sTotal       := 'Total:';
           sCashRec     := 'Dinheiro Rec.:';
           sChange      := 'Troco:';
           sPayTotals   := '              Total Pago: ';
           sPayBal      := '                   Saldo: ';
           sPayments    := '---------------- Pagamentos ------------';
           end;

     LANG_SPANISH :
           begin
           sNoTaxAble   := 'No Tributable:';
           sDiscount    := 'Descuento nota:';
           sItemDiscount:= 'Descuento ítem:';
           sRefund      := '    Reembolso:';
           sHi          := 'Hola';
           sCashier1    := 'Yo soy';
           sCashier2    := 'su cajera(o).';
           sMedia       := 'Medios:';
           sTodayIs     := 'La fecha de hoy es ';
           sLayawayNum  := 'Boleta Pend/Crédito#';
           sIInvNum     := 'Boleta#';
           sSubTotal    := 'SubTotal:';
           sTax         := 'Impuesto:';
           sTotal       := 'Total:';
           sCashRec     := 'Recibido:';
           sChange      := 'Cambio:';
           sPayTotals   := '            Total Pagado: ';
           sPayBal      := '                   Saldo: ';
           sPayments    := '---------------- Pagos -----------------';
           end;
   end;

end;

procedure TSubTicketInfo.InsertLayaway(text:String);
var
 str: string;
 p: integer;
begin
  DateSetEdit;
  p := memLayaway.SelStart + memLayaway.SelLength + 1;
  str := memLayaway.Text;
  Insert(text, str, p);
  memLayaway.Text := str;
  memLayaway.SelStart := p + Length(Text) - 1;
end;

procedure TSubTicketInfo.InsertTotals(text:String);
var
 str: string;
 p: integer;
begin
  DateSetEdit;
  p := memTotals.SelStart + memTotals.SelLength + 1;
  str := memTotals.Text;
  Insert(text, str, p);
  memTotals.Text := str;
  memTotals.SelStart := p + Length(Text) - 1;
end;

procedure TSubTicketInfo.InsertHeader(text:String);
var
 str: string;
 p: integer;
begin
  DateSetEdit;
  p := memHeader.SelStart + memHeader.SelLength + 1;
  str := memHeader.Text;
  Insert(text, str, p);
  memHeader.Text := str;
  memHeader.SelStart := p + Length(Text) - 1;
end;

procedure TSubTicketInfo.InsertDetail(text:String);
var
 str: string;
 p: integer;
begin
  DateSetEdit;
  p := memDetail.SelStart + memDetail.SelLength + 1;
  str := memDetail.Text;
  Insert(text, str, p);
  memDetail.Text := str;
  memDetail.SelStart := p + Length(Text) - 1;
end;

procedure TSubTicketInfo.btnModelDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_MODEL);
end;

procedure TSubTicketInfo.btnDescDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_DESCRIPTION);
end;

procedure TSubTicketInfo.btnSPDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_SP);
end;

procedure TSubTicketInfo.btnBarcodeDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_BARCODE);
end;

procedure TSubTicketInfo.btnSerialNumDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_SERIALNUMBER);
end;

procedure TSubTicketInfo.btnQtyDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_QTY);
end;

procedure TSubTicketInfo.btnUnitPriceDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_UNIT_PRICE);
end;

procedure TSubTicketInfo.btnUnitTotalClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_UNIT_TOTAL);
end;

procedure TSubTicketInfo.btPrintClick(Sender: TObject);
begin
  inherited;
  DataSetPost;
  with TFrmPreviewTicket.Create(Self) do
     Start(fIDStore, NORMAL);
end;

procedure TSubTicketInfo.btnDateHClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_DATE);
end;

procedure TSubTicketInfo.btnTimeHClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_TIME);
end;

procedure TSubTicketInfo.btnCustomerHClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_CUSTOMER);
end;

procedure TSubTicketInfo.btnMediaHClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_MEDIA);
end;

procedure TSubTicketInfo.btnCashierClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_CASHIER);
end;

procedure TSubTicketInfo.btnHoldHClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_HOLD);
end;

procedure TSubTicketInfo.btnInvoiceHClick(Sender: TObject);
begin
  inherited;
  InsertHeader(TICKET_INVOICE);
end;

procedure TSubTicketInfo.btnNoTaxableTClick(Sender: TObject);
begin
  inherited;
  InsertTotals('{TA'+sNoTaxAble+TICKET_NO_TAXABLE+'TA}');
end;

procedure TSubTicketInfo.btnTaxableTClick(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_TAXABLE);
end;

procedure TSubTicketInfo.btnTaxTClick(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_TAX);
end;

procedure TSubTicketInfo.btnTotalTClick(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_TOTAL);
end;

procedure TSubTicketInfo.btnCashRecTClick(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_CASH_RECEIVED);
end;

procedure TSubTicketInfo.btnChangeTClick(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_CHANGE);
end;

procedure TSubTicketInfo.btnDiscountClick(Sender: TObject);
begin
  inherited;
  InsertTotals('{D'+sDiscount+TICKET_DISCOUNT+'D}');
end;

procedure TSubTicketInfo.btnPayDateTClick(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_PAYDATE_TYPE);
end;

procedure TSubTicketInfo.btnPayTotalLClick(Sender: TObject);
begin
  inherited;
  InsertLayaway(TICKET_PAYMENT_TOTAL);
end;

procedure TSubTicketInfo.btnPayBalLClick(Sender: TObject);
begin
  inherited;
  InsertLayaway(TICKET_PAYMENT_BALANCE);
end;

procedure TSubTicketInfo.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  DataSetPost;
  with TFrmPreviewTicket.Create(Self) do
     Start(fIDStore, LAYAWAY); 
end;

procedure TSubTicketInfo.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  DataSetPost;
  with TFrmPreviewTicket.Create(Self) do
     Start(fIDStore, TAX_EXEMPT);
end;

procedure TSubTicketInfo.btnSPNumberDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_SPN);
end;

procedure TSubTicketInfo.btnRightDClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_ALIGN_RIGHT);
end;

procedure TSubTicketInfo.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  InsertTotals(TICKET_ALIGN_RIGHT);
end;

procedure TSubTicketInfo.btRestoreHeaderClick(Sender: TObject);
var
  fText : String;
begin
  inherited;

  fText :=  '========================================' + #13#10 +
            '             N / A    C O R P        ' + #13#10 +
            '     -----------------------------   ' + #13#10 + #13#10 +
            '       XXX  1500 xxxxxxx xxxx xxxxx  ' + #13#10 +
            '         xxxxxxxx FL USA XXXX        ' + #13#10 +
            '             (000) 000-0000          ' + #13#10 + #13#10 +
            sHi+' [CUSTOMER],'                      + #13#10 +
            sCashier1 + ' [CASHIER], '+sCashier2+'' + #13#10 +
            sMedia+'[MEDIA]'                        + #13#10 +
            sTodayIs+' [DATE] [TIME]'               + #13#10 +
            sLayawayNum+'[HOLD]'                    + #13#10 +
            sIInvNum+'[INVOICE]';

  DateSetEdit;
  quStoreTicketHeader.AsString := fText;
  DataSetPost; 

end;

procedure TSubTicketInfo.btRestoreDetailClick(Sender: TObject);
var
  fText : String;
begin
  inherited;

  fText := '[DESCRIPTION] (SP#[SP_#])'              + #13#10 +
           '[MODEL]'                                + #13#10 +
           '[SN]'                                   + #13#10 +
           '{>[QTY] x [UNITPRICE] = [UNIT_TOTAL]<}' + #13#10 +
           '----------------------------------------';

  DateSetEdit;
  quStoreTicketDetail.AsString := fText;
  DataSetPost;

end;

procedure TSubTicketInfo.btRestoreTotalClick(Sender: TObject);
var
  fText : String;
begin
  inherited;

  fText := '{TA{>  '+sNoTaxAble+'[NOTAXABLE]<}TA}' + #13#10 +
           '{>   '+sSubTotal+'[TAXABLE]<}'         + #13#10 +
           '{>   '+sSubTotal+'[SUBTOTAL]<}'         + #13#10 +           
           '{>        '+sTax+'[TAX]<}'             + #13#10 +
           '{>      '+sTotal+'[TOTAL]<}'           + #13#10 + #13#10 +
           '{>'+sCashRec+'[CASH]<}'                + #13#10 +
           '{>       '+sChange+'[CHANGE]<}'        + #13#10 + #13#10 +
           '{ID{>     '+sItemDiscount+'[ITEMDISCOUNT]<}ID}'  + #13#10 + #13#10 +
           '{D{>     '+sDiscount+'[DISCOUNT]<}D}'  + #13#10 + #13#10 +
           '{R{>     '+sRefund+'[REFUND]<}R}'  + #13#10 + #13#10 +
           sPayments                               + #13#10 +
           '[DATE/TYPE/$]                      ';

  DateSetEdit;
  quStoreTicketTotals.AsString := fText;
  DataSetPost;

end;

procedure TSubTicketInfo.btRestoreLayawayClick(Sender: TObject);
var
  fText : String;
begin
  inherited;

  fText := '                          --------------'    + #13#10 +
           sPayTotals+'[PAYMENT_TOTALS]'                 + #13#10 +
           sPayBal+'[PAYMENT_BALANCE]'                   + #13#10 +
           '----------------------------------------';

  DateSetEdit;
  quStoreTicketLayawayFooter.AsString := fText;
  DataSetPost;

end;

procedure TSubTicketInfo.btnRefundClick(Sender: TObject);
begin
  inherited;
  InsertTotals('{R'+sRefund+TICKET_REFUND+'R}');
end;

procedure TSubTicketInfo.btnItemDiscountClick(Sender: TObject);
begin
  inherited;
  InsertTotals('{ID'+sItemDiscount+TICKET_ITEM_DISCOUNT+'ID}');
end;

procedure TSubTicketInfo.btnSubTotalClick(Sender: TObject);
begin
  inherited;
  InsertTotals(sSubTotal+TICKET_SUBTOTAL);
end;

procedure TSubTicketInfo.btnManufacturerClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_MANUFACTURER);
end;

procedure TSubTicketInfo.btnUnitClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_UNIT);
end;

procedure TSubTicketInfo.btnCategTextClick(Sender: TObject);
begin
  inherited;
  InsertDetail(TICKET_CATEG_TEXT);
end;

initialization
   RegisterClass(TSubTicketInfo);

end.
