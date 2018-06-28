unit uInvoiceInfo;

interface

uses SysUtils, ADODB, Classes, uBonusBucks, clsInfoCashSale, Db, Dialogs;

type
  TInvoiceInfo = class
  private
    // Antonio 2014 Jun 16
    fSubtotal: Double;
    fItemsDiscount: Double;
    fInvoiceDiscount: Double;
    fTotalDiscount: Double;
    fTax: Double;
    fTaxExempt: Double;
    fAddExpens: Double;
    fPreSale: TDataset;
    fRefund: Boolean;
    fSubtotalTaxable: Double;
    fInfoCashSale: InfoCashSale;

    FIsNewHold: Boolean;
    FIDInvoice: Integer;
    FPreSaleType: Integer;
    FIDCashRegMov: Integer;
    FIDPreSale: Integer;
    FHoldOnCashReg: Integer;
    FHoldOnTerminal: Integer;
    FquVerifyOpenHold : TADOQuery;
    FquFreeCommand : TADOCommand;
    FADOConn : TADOConnection;
    FSaleCode: String;
    FLayaway: Boolean;
    FFormOfPayment: Integer;
    FBonusBuckList: TList;
    FIsShipping : Boolean;
    FIDPreSaleRefund: Integer;
    FRefundDate: TDateTime;

    //Antonio 2014 Jun 16
    FTotalInvoice: Currency;

    // Antonio 2014 Jun 18
    procedure getDatasetValues();

    // Antonio 2014 Jun 16
    function getAddExpens: Double;
    function getInvoiceDiscount: Double;
    function getItemsDiscount: Double;
    function getSubtotal: Double;
    function getTax: Double;
    function getTaxExempt: Double;
    function getTotalDiscount: Double;

    procedure treatInvoiceTotalsOnRefund();
    procedure treatInvoiceTotals(); overload;
    procedure setInfoCashSale(arg_infocashsale: InfoCashSale);
    function getSubtotalTaxable: Double;
//    procedure NeedCustomer(tax_exempt: double);

  public
    constructor Create(ADOConn : TADOConnection);
    destructor Destroy; override;
    procedure RefreshStatus;

    procedure IncHold;
    procedure DecHold;
    procedure LoadBonusBucks;
    procedure ClearBBList;
    function IsInvoice: Boolean;
    procedure treatInvoiceTotals(arg_presale: TADOStoredProc); overload;
    procedure treatInvoice(arg_refund: Boolean; arg_presale: TDataset);

    // Antonio 2014 Jun 16
    property SubTotalTaxable: Double read getSubtotalTaxable;
    property InfoCashSale: InfoCashSale write setInfoCashSale;
    property Subtotal: Double read getSubtotal;
    property ItemsDiscount: Double read getItemsDiscount;
    property InvoiceDiscount: Double read getInvoiceDiscount;
    property TotalDiscount: Double read getTotalDiscount;
    property Tax: Double read getTax;
    property TaxExempt: Double read getTaxExempt;
    property AddExpens: Double read getAddExpens;

    property TotalInvoice   : Currency  read FTotalInvoice    write FTotalInvoice;
    property PreSaleType    : Integer   read FPreSaleType     write FPreSaleType;
    property IDCashRegMov   : Integer   read FIDCashRegMov    write FIDCashRegMov;
    property IDPreSale      : Integer   read FIDPreSale       write FIDPreSale;
    property IDInvoice      : Integer   read FIDInvoice       write FIDInvoice;
    property HoldOnCashReg  : Integer   read FHoldOnCashReg   write FHoldOnCashReg;
    property HoldOnTerminal : Integer   read FHoldOnTerminal  write FHoldOnTerminal;
    property IsNewHold      : Boolean   read FIsNewHold       write FIsNewHold;
    property Layaway        : Boolean   read FLayaway         write FLayaway;
    property FormOfPayment  : Integer   read FFormOfPayment   write FFormOfPayment;
    property BonusBuckList  : TList     read FBonusBuckList   write FBonusBuckList;
    property IsShipping     : Boolean   read FIsShipping      write FIsShipping;
    property IDPreSaleRefund: Integer   read FIDPreSaleRefund write FIDPreSaleRefund;
    property RefundDate     : TDateTime read FRefundDate      write FRefundDate;

    property SaleCode       : String read  FSaleCode      write FSaleCode;
  end;

implementation

uses uSystemConst, Math, StrUtils, uNumericFunctions;

{ TInvoiceInfo }

constructor TInvoiceInfo.Create(ADOConn : TADOConnection);
begin
  FADOConn := ADOConn;
  FquVerifyOpenHold            := TADOQuery.Create(nil);
  FquFreeCommand               := TADOCommand.Create(nil);
  FquVerifyOpenHold.Connection := FADOConn;
  FquFreeCommand.Connection    := FADOConn;
  FBonusBuckList               := TList.Create;

  with FquVerifyOpenHold do
  begin
    SQL.Add('SELECT	nOpenUser, nOpenHoldCaixa');
    SQL.Add('FROM Invoice');
    SQL.Add('WHERE IDPreSale = :IDPreSale');
  end;
  
  FPreSaleType := SALE_CASHREG;
end;

destructor TInvoiceInfo.Destroy;
begin
  FreeAndNil(FquVerifyOpenHold);
  FreeAndNil(FquFreeCommand);
  FreeAndNil(FBonusBuckList);
  inherited;
end;

procedure TInvoiceInfo.DecHold;
var
 SQL : String;
begin

  SQL := 'UPDATE Invoice SET ';
  Case PreSaleType of
    SALE_CASHREG : SQL := SQL + ' nOpenHoldCaixa = ' + IntToStr(HoldOnCashReg - 1);
    SALE_PRESALE : SQL := SQL + ' nOpenUser = ' + IntToStr(HoldOnTerminal - 1);
  end;
  SQL := SQL + ' WHERE IDPreSale = ' + IntToStr(IDPreSale);

  with FquFreeCommand do
  begin
    CommandText := SQL;
    Execute;
  end;

end;

procedure TInvoiceInfo.IncHold;
var
 SQL : String;
begin
  SQL := 'UPDATE Invoice SET ';
  Case PreSaleType of
    SALE_CASHREG : SQL := SQL + ' nOpenHoldCaixa = ' + IntToStr(HoldOnCashReg + 1);
    SALE_PRESALE : SQL := SQL + ' nOpenUser = ' + IntToStr(HoldOnTerminal + 1);
  end;
  SQL := SQL + ' WHERE IDPreSale = ' + IntToStr(IDPreSale);

  with FquFreeCommand do
  begin
    CommandText := SQL;
    Execute;
  end;
end;

procedure TInvoiceInfo.RefreshStatus;
begin

  with FquVerifyOpenHold do
  try
    if Active then
      Close;
    Parameters.ParambyName('IDPreSale').Value := FIDPreSale;
    Open;
    FHoldOnCashReg  := FieldByName('nOpenHoldCaixa').AsInteger;
    FHoldOnTerminal := FieldByName('nOpenUser').AsInteger;
  finally
    Close;
  end;

end;

function TInvoiceInfo.IsInvoice: Boolean;
begin
  Result := FIDInvoice <> 0;
end;

procedure TInvoiceInfo.LoadBonusBucks;
var
  iBBIndex: Integer;
  bbBonus: TBonusBucks;
begin
  with TADODataSet.Create(nil) do
  try
    Connection := FADOConn;
    CommandText := 'SELECT IDPreSaleCreated ' +
                   'FROM Sal_RebateDiscount ' +
                   'WHERE IDPreSaleUsed = :IDPreSale';
    Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    Open;

    while not Eof do
    begin
      iBBIndex := FBonusBuckList.Add(TBonusBucks.Create(FADOConn, nil));
      bbBonus := TBonusBucks(FBonusBuckList[iBBIndex]);
      bbBonus.LoadBySaleUsed(FIDPreSale);
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TInvoiceInfo.ClearBBList;
begin
  FBonusBuckList.Clear;
end;

function TInvoiceInfo.getAddExpens: Double;
begin
  result := fAddExpens
end;

function TInvoiceInfo.getInvoiceDiscount: Double;
begin
  result := fInvoiceDiscount
end;

function TInvoiceInfo.getItemsDiscount: Double;
begin
  result := fItemsDiscount
end;

function TInvoiceInfo.getSubtotal: Double;
begin
  Result := fSubTotal
end;

function TInvoiceInfo.getTax: Double;
begin
  result := fTax
end;

function TInvoiceInfo.getTaxExempt: Double;
begin
  result := fTaxExempt
end;

function TInvoiceInfo.getTotalDiscount: Double;
begin
  result := fTotalDiscount
end;

procedure TInvoiceInfo.treatInvoice(arg_refund: Boolean; arg_presale: TDataset);
begin
  fRefund := arg_refund;
  fPreSale := arg_presale;

  if ( fRefund ) then
     treatInvoiceTotalsOnRefund()
  else
     treatInvoiceTotals();

end;

procedure TInvoiceInfo.treatInvoiceTotals;
var
  subtotalTaxable: Double;
  NewSubtotal: Double;
  itemsDiscount: Double;
  totalDiscount: Double; // itemsDiscount + invoiceDiscount
  total: Double;
begin
  getDatasetValues();
  total := fsubtotal - ( fItemsDiscount + finvoiceDiscount) + ( ftax + faddExpens );
  newSubtotal := fsubtotal - fTaxExempt - fItemsDiscount;
  fTotalDiscount := ( fItemsDiscount + finvoiceDiscount);
  subtotalTaxable  := newSubtotal - ftaxExempt;

  // move total Invoice to InvoiceInfo
  FTotalInvoice := total;
end;

procedure TInvoiceInfo.treatInvoiceTotalsOnRefund;
var
  NewSubtotal: Double;
  total: Double;
begin
  getDataSetValues();
  fItemsDiscount := fItemsDiscount * (-1);
  fInvoiceDiscount := fInvoiceDiscount * (-1);

  (*
  if ( fInfoCashSale.getNewTotalDue <> 0 ) then begin
     //fAddExpens := fInfoCashSale.getOtherCosts  * (-1);
     fItemsDiscount   := fInfoCashSale.getItemDiscounts;
     fInvoiceDiscount := fInfoCashSale.getSaleDiscount;
     fSubtotal := fSubtotal * (-1);
  end;
  *)

   // NAC - 2013-11-27 - Removed tempInvoiceTaxIsemptItemDiscount as it's informational
   // and zero's out balance on tax exempt items
   total := fSubTotal + fTax + fAddExpens - (fItemsDiscount + fInvoiceDiscount );

   newSubtotal := fsubtotal - fTaxExempt - fItemsDiscount;

   fsubtotalTaxable  := newSubtotal - ftaxExempt;

   // move total Invoice to InvoiceInfo
   self.TotalInvoice := total;

   ftotalDiscount    := finvoiceDiscount + fItemsDiscount;

end;

procedure TInvoiceInfo.setInfoCashSale(arg_infocashsale: InfoCashSale);
begin
  fInfoCashSale := arg_infocashsale
end;

procedure TInvoiceInfo.treatInvoiceTotals(arg_presale: TADOStoredProc);
begin
  fPreSale := arg_presale;
  treatInvoiceTotals();
end;

function TInvoiceInfo.getSubtotalTaxable: Double;
begin
  Result := fSubtotalTaxable
end;

procedure TInvoiceInfo.getDatasetValues();
begin
  // get values to invoice totals from sale
  //fSubtotal        := ifthen(fPresale.fieldByName('subtotal').isNull, 0, roundLikeDatabase(fPresale.fieldByName('subtotal').value, 2));
  //fItemsDiscount   := ifthen(fpresale.fieldbyname('ItemDiscount').IsNull, 0,roundLikeDatabase(fpresale.fieldbyname('ItemDiscount').Value, 2));
  //finvoiceDiscount := ifthen(fpresale.fieldbyname('InvoiceDiscount').isNull, 0, roundLikeDatabase(fpresale.fieldbyname('InvoiceDiscount').Value, 2));

  (* Antonio 11/17/2015 *)
  // Subtotal
  if ( fPresale.FieldByName('Subtotal').isNull ) then begin
      fSubtotal := 0
  end else begin
          fSubtotal := roundLikeDatabase(fPresale.fieldByName('Subtotal').value, 2);
      end;

  // Items Discount
  if ( fPresale.FieldByName('ItemDiscount').isNull ) then begin
      fItemsDiscount := 0
  end else begin
          fItemsDiscount := roundLikeDatabase(fPresale.fieldByName('ItemDiscount').value, 2);
      end;


  // Invoice Discount
  if ( fPresale.FieldByName('InvoiceDiscount').isNull ) then begin
      fInvoiceDiscount := 0
  end else begin
          fInvoiceDiscount := roundLikeDatabase(fPresale.fieldByName('InvoiceDiscount').value, 2);
      end;


  if ( fpresale.fieldbyname('taxisent').AsBoolean = true ) then begin
     ftaxExempt := ftax;
     ftax := 0;
  end else begin
         if ( not fpresale.fieldbyname('Tax').isNull ) then
             ftax := fpresale.fieldbyname('Tax').value


         else
             ftax := 0.00;
      end;

  if ( not fpresale.fieldbyname('AditionalExpenses').isNull )
     then
        faddExpens := fpresale.fieldbyname('AditionalExpenses').Value
     else
        faddExpens := 0.00;

//  showmessage(format('Subtotal = %2.f, Items Discount = %2.f, Invoice Discount = %2.f, Tax = %2.f', [fSubtotal, fItemsDiscount, fInvoiceDiscount, fTax]));


end;

{
procedure TInvoiceInfo.NeedCustomer(tax_exempt: Double);
begin
   if ( (fPreSale.FieldByName('TaxIsent').Value <= 0 )
        and (tax_exempt >) )
end;
 }
end.
