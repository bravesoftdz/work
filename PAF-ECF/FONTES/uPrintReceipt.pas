unit uPrintReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ComCtrls, ADODB, PaidePrinter, siComp,
  siLangRT, uPreSale, uPayments;

const
  RECEIPT_TYPE_HOLD             = 1;
  RECEIPT_TYPE_INVOICE          = 2;
  RECEIPT_TYPE_TICKET           = 3;
  RECEIPT_TYPE_TAXISEMPTION     = 4;
  RECEIPT_TYPE_LAYAWAY_RECEIVE  = 5;

type
  TPrintReceipt = class(TFrmParentPrint)
    lblPrint: TLabel;
    pnlPrinter: TPanel;
    quBarCode: TADOQuery;
    quBarCodeBarCode: TStringField;
    quPreSaleValue: TADOStoredProc;
    quPreSaleValueTaxIsent: TBooleanField;
    quPreSaleValueSubTotal: TFloatField;
    quPreSaleValueItemDiscount: TFloatField;
    quPreSaleValueTax: TFloatField;
    quPreSaleValueTaxPrc: TFloatField;
    quPreSaleValueDiscountPrc: TFloatField;
    quPreSaleValueTotalInvoice: TFloatField;
    quPreSaleValueSpecialPriceID: TIntegerField;
    quPreSaleValueSpecialPrice: TStringField;
    quPreSaleValuenOpenUser: TIntegerField;
    quPreSaleValueShowOpenUser: TIntegerField;
    quPreSaleInfo: TADOQuery;
    quPreSaleInfoIDPreSale: TIntegerField;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoDeliverTypeID: TIntegerField;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleInfoDeliverAddress: TStringField;
    quPreSaleInfoPassportDate: TDateTimeField;
    quPreSaleInfoAirLine: TStringField;
    quPreSaleInfoCompanyName: TStringField;
    quPreSaleInfoCompanyCGC: TStringField;
    quPreSaleInfoDepositDate: TDateTimeField;
    quPreSaleInfoNote: TStringField;
    quPreSaleInfoInvoiceDate: TDateTimeField;
    quPreSaleInfoIDInvoice: TIntegerField;
    quPreSaleInfoPassport: TStringField;
    quPreSaleInfoTicket: TStringField;
    quPreSaleInfoMediaID: TIntegerField;
    quPreSaleItem: TADOStoredProc;
    quPreSaleItemModelID: TIntegerField;
    quPreSaleItemModel: TStringField;
    quPreSaleItemDescription: TStringField;
    quPreSaleItemSalePrice: TFloatField;
    quPreSaleItemDiscount: TFloatField;
    quPreSaleItemIDInventoryMov: TIntegerField;
    quPreSaleItemTotalItem: TFloatField;
    quPreSaleItemSalesPerson: TStringField;
    quPreSaleItemIDComission: TIntegerField;
    quPreSaleItemCostPrice: TFloatField;
    quPreSaleInfoCashReceived: TFloatField;
    AniPrint: TAnimate;
    btOk: TButton;
    quPreSaleInfoCashRegMovID: TIntegerField;
    quDescCashier: TADOQuery;
    quDescCashierSystemUser: TStringField;
    quPreSaleInfoPrinted: TBooleanField;
    quPreSaleItemIDUser: TIntegerField;
    quPreSaleItemExchangeInvoice: TIntegerField;
    quPreSaleInfoTaxIsent: TBooleanField;
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoAddress: TStringField;
    quSerial: TADOQuery;
    quSerialDocumentID: TIntegerField;
    quSerialSerialNumber: TStringField;
    quSerialInventoryMovID: TIntegerField;
    quPreSaleValueTaxIsemptValue: TFloatField;
    quPreSaleValueSubTotalTaxable: TFloatField;
    quPreSaleValueTaxIsemptItemDiscount: TFloatField;
    quPreSaleValueTotalDiscount: TCurrencyField;
    quPreSaleParc: TADOQuery;
    quPreSaleParcIDDocumentoTipo: TIntegerField;
    quPreSaleParcNumDocumento: TStringField;
    quPreSaleParcDataVencimento: TDateTimeField;
    quPreSaleParcValorNominal: TFloatField;
    quPreSaleParcMeioPag: TStringField;
    quPreSaleParcIDMeioPag: TIntegerField;
    quStore: TADOQuery;
    quStoreTicketHeader: TMemoField;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quStoreTicketLayawayFooter: TMemoField;
    quStoreTicketTaxIsemptFooter: TMemoField;
    quStoreTicketFooter: TMemoField;
    quStorePrintTicketHeader: TBooleanField;
    quStorePrintLayawayFooter: TBooleanField;
    quStorePrintTaxInsemptFooter: TBooleanField;
    quStorePrintTicketFooter: TBooleanField;
    quPreSaleInfoPrintNotes: TBooleanField;
    quStoreTicketDetail: TMemoField;
    quStoreTicketTotals: TMemoField;
    quPreSaleInfoMedia: TStringField;
    quPreSaleItemQty: TFloatField;
    tmrTimer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrTimerTimer(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sEndereco,
    sNoTaxAble,
    sTaxAble,
    sTax,
    sSubTotal,
    sTotal,
    sDiscount,
    sHold,
    sTaxExpHeadr,
    sIInvNum,
    sIInvDate,
    sICustomer,
    sIPassPort,
    sIPassPrtNum,
    sITicketNum,
    sIAirLine,
    sIArrivalNum,
    sIBusName,
    sILicencNum,
    sIAddress,
    sRecImpresso,
    sClickOK    : String;
    MyIDPreSale, MyIDInvoice    : Integer;
    MyTotCash      : Currency;
    MyCashReceived : Currency;
    ActualTime     : TDateTime;
    Quit           : Boolean;
    FReceiptType: Integer;
    FOpenCashier: String;
    FTaxable, FExempt: Currency;
    FPaymentTotal: Currency;


    FPreSale: TPreSale;
    FPayments: TPayments;
    procedure ImpTicketHeader(PrintDate: TDateTime; InvoiceCode, SaleCode: String ; Customer: String ; Cashier: String; IDTouristGroup : Integer; Printed : Boolean; Media : String);
    procedure ImpTicketDeliverHeader(PrintDate: TDateTime ; SaleCode, InvoiceCode: String ; Customer: String ; Hotel: String; IDTouristGroup : Integer; Media:String);
    procedure ImpTicketLine(Qty: Double ; Desc: String ; Model: String ; Val: Double ; BarCode: String; IDUser : integer; SalesPerson:String);
    procedure ImpTicketTotals(SubTotalTaxable, TaxIsemptValue, SubTotal: Double ; Tax: Double ; Total: Double ; Received: Double ; Change, ItemDiscount, InvoiceDiscount, Refund: Double; IsRefund: Boolean);
    procedure ImpTicketPaymentLine(Date: TDateTime ; PType: String ; Val: Double);
    procedure ImpTicketNotes;
    procedure ImpTicketTaxExemption;
    procedure ImpFooterLayaway(AInvoiceTotal, APaymentTotal: Currency );
    procedure ImpTicketFooter;

    //Falta fazer
    procedure ImpTicketHoldTotals(SubTotalTaxable, TaxIsemptValue, SubTotal: Double ; Tax: Double ; Total: Double ; Received: Double ; Change: Double; ReceiptType : integer; Discount: Double; IsRefund: Boolean);
  public
    { Public declarations }
    procedure Start(APreSale: TPreSale; APayments: TPayments; IDPreSale : Integer; ReceiptType: Integer; CashRegMov: Integer);
  end;


implementation

uses uDM, XBase, uMsgBox, uMsgConstant, uDMGlobal, uSystemConst, uStringFunctions,
  uTXTCashInfo, uDMPDV;

{$R *.DFM}

procedure TPrintReceipt.Start(APreSale: TPreSale; APayments: TPayments; IDPreSale : Integer; ReceiptType: Integer;
 CashRegMov: Integer);
var
  NotOk: Boolean;
  FExempt: Currency;
  iDummy: Integer;
  sDummy: String;
  dtDummy: TDateTime;


begin

  Exit;

  DM.fPOS.GetCashRegisterInfo(CashRegMov, sDummy, FOpenCashier, iDummy, dtDummy);

  FPreSale  := APreSale;
  FPayments := APayments;

  MyCashReceived := FPayments.CashReceivedTotal + FPayments.ChangeTotal;

  MyTotCash     := FPayments.GetPaymentsAmount(PAYMENT_TYPE_CASH);
  fPaymentTotal := FPayments.GetPaymentsAmount();

  if FPreSale.TaxExempt then
  begin
    FTaxable    := 0;
    FExempt     := FPreSale.TaxTotal;
  end
  else
  begin
    FTaxable    := FPreSale.TaxTotal;
    FExempt     := 0;
  end;

  FReceiptType := ReceiptType;

  tmrTimer.Enabled := True;
  ShowModal;
end;

procedure TPrintReceipt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintReceipt.ImpTicketPaymentLine(Date: TDateTime ; PType: String ; Val: Double);
var
  fText    : string;
  fPayment : string;
begin

  if Length(PType) > 14 then
     PType := Copy(PType,1,14);

  fText    := DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketTotals');
  fPayment := (Pad(FormatDateTime('ddddd', Date), 11) +
               Pad(PType, 14) +
               LPad(FormatFloat('###,###,##0.00', Val), 14));

  if Pos(TICKET_PAYDATE_TYPE, fText) > 0 then
     DM.PrintLine(fPayment);

end;

procedure TPrintReceipt.ImpTicketHeader(PrintDate: TDateTime ; InvoiceCode, SaleCode: String;
                                       Customer: String ; Cashier: String; IDTouristGroup : Integer;
                                       Printed : Boolean; Media : String);
var
  fText : string;
begin
  //Print Header if it is checkedto Print
  if not StrToBoolDef(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'PrintTicketHeader'), False) then
    Exit;

  fText := DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketHeader');

  fText := StringReplace(fText, TICKET_DATE,     DateToStr(PrintDate), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TIME,     TimeToStr(PrintDate), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CUSTOMER, Customer, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_MEDIA,    Media, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CASHIER,  Cashier, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_HOLD,     SaleCode, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_INVOICE,  InvoiceCode, [rfReplaceAll]);

  ImpMemoDBInfo(fText);
end;

procedure TPrintReceipt.ImpTicketNotes;
begin
  DM.PrintLine('----------------------------------------');
  ImpMemoDBInfo(FPreSale.InvObs);
  DM.PrintLine('----------------------------------------');
  DM.PrintLine('');

end;

procedure TPrintReceipt.ImpTicketDeliverHeader(PrintDate: TDateTime ;
          SaleCode, InvoiceCode: String; Customer: String ; Hotel: String;
          IDTouristGroup : Integer; Media:String);
begin

  //Print Header if it is checked
  ImpTicketHeader(PrintDate, InvoiceCode, SaleCode, Customer, '',
                  IDTouristGroup, False, Media);

  DM.PrintLine('--------------------------------');
  DM.PrintLine(sEndereco + Hotel);
  DM.PrintLine('--------------------------------');

end;

procedure TPrintReceipt.ImpTicketLine(Qty: Double ; Desc: String ; Model: String ;
                                Val: Double ; BarCode: String; IDUser : Integer; SalesPerson:String);
var
  fText,
  fSerial,
  fTemp  : string;
  iRgh,
  i        : Integer;
begin

  fSerial := '';

  (*
  // Imprime os seriais do item
  with quSerial do
    begin
      if Active AND Locate('InventoryMovID', quPreSaleItemIDInventoryMov.AsString, []) then
        begin
          // vou percorrendo até o IDInventoryMov mudar
          while (not EOF) AND (quSerialInventoryMovID.AsInteger =
                quPreSaleItemIDInventoryMov.AsInteger)  do
            begin
              //colocar o serial na outra linha se nao der no ticket
              fTemp := fSerial + Trim(quSerialSerialNumber.AsString);
              If Length(fTemp) > DM.fPrintReceipt.PrinterLineWidth then
                 fSerial := fSerial + #13#10 + Trim(quSerialSerialNumber.AsString)
              else
                 fSerial := fTemp;
              Next;
              if not EOF then
                 fSerial := fSerial + ' ,';
            end;
        fSerial := '('+fSerial+')';
        end;
    end;
  *)

  fText := DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketDetail');

  fText := StringReplace(fText, TICKET_MODEL, Model, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_DESCRIPTION, Desc, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_SP, SalesPerson, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_SPN, IntToStr(IDUser), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_BARCODE, BarCode, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_SERIALNUMBER, fSerial, [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_QTY, FormatFloat('0.#####', Qty), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_UNIT_PRICE, FormatCurr('###,###,##0.00',Val), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_UNIT_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',Qty * Val),14), [rfReplaceAll]);

  iRgh := CountStr(fText, '{>');
  for i:=1 to iRgh do
     fText := IncLeftStringFlage('{>','<}', fText,DM.fPrintReceipt.PrinterLineWidth);

  ImpMemoNoEmptyLine(fText);
end;

procedure TPrintReceipt.ImpTicketTotals(SubTotalTaxable, TaxISemptValue, SubTotal: Double ; Tax: Double ; Total: Double ; Received: Double ; Change, ItemDiscount, InvoiceDiscount, Refund: Double; IsRefund: Boolean);
var
  fText : string;
  iRgh,
  i        : Integer;
begin
  fText := DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketTotals');

  //Error quando e Layaway
  if (Received = 0) or (Change<0) then
     Change := 0;

  fText := StringReplace(fText, TICKET_NO_TAXABLE, IncLeftSpaces(FormatCurr('###,###,##0.00',TaxIsemptValue), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_SUBTOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',SubTotal), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TAXABLE, IncLeftSpaces(FormatCurr('###,###,##0.00',SubTotalTaxable), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TAX, IncLeftSpaces(FormatCurr('###,###,##0.00',Tax), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',Total), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CASH_RECEIVED, IncLeftSpaces(FormatCurr('###,###,##0.00',Received), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CHANGE, IncLeftSpaces(FormatCurr('###,###,##0.00',Change), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_ITEM_DISCOUNT, IncLeftSpaces(FormatCurr('###,###,##0.00',ItemDiscount), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_DISCOUNT, IncLeftSpaces(FormatCurr('###,###,##0.00',InvoiceDiscount), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_REFUND, IncLeftSpaces(FormatCurr('###,###,##0.00',Refund), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_PAYDATE_TYPE, '', [rfReplaceAll]);

  if TaxIsemptValue <> 0 then
     fText := CopyStringFlage('{TA','TA}', fText, False)
  else
     fText := CopyStringFlage('{TA','TA}', fText, True);

  if ((ItemDiscount > 0) and not IsRefund) or ((ItemDiscount < 0) and IsRefund) then
     fText := CopyStringFlage('{ID','ID}', fText, False)
  else
     fText := CopyStringFlage('{ID','ID}', fText, True);

  if ((InvoiceDiscount > 0) and not IsRefund) or ((InvoiceDiscount < 0) and IsRefund) then
     fText := CopyStringFlage('{D','D}', fText, False)
  else
     fText := CopyStringFlage('{D','D}', fText, True);

  if Refund > 0 then
     fText := CopyStringFlage('{R','R}', fText, False)
  else
     fText := CopyStringFlage('{R','R}', fText, True);

  iRgh := CountStr(fText, '{>');
  for i:=1 to iRgh do
     fText := IncLeftStringFlage('{>','<}', fText,DM.fPrintReceipt.PrinterLineWidth);

  ImpMemoDBInfo(fText);

end;

procedure TPrintReceipt.ImpTicketHoldTotals(SubTotalTaxable, TaxIsemptValue, SubTotal: Double ;
              Tax: Double ; Total: Double ; Received: Double ; Change: Double;
              ReceiptType : integer; Discount: Double; IsRefund: Boolean);
begin
  case ReceiptType  of
    RECEIPT_TYPE_HOLD:
      begin
        DM.PrintLine(' ');
        DM.PrintLine(Space(14) + sSubTotal + RightStr(Space(12) + sHold,12));
        DM.PrintLine(Space(14) + sTax      + RightStr(Space(12) + sHold,12));
        DM.PrintLine(Space(14) + sTotal    + RightStr(Space(12) + sHold,12));
        DM.PrintLine('                                        ');
        DM.PrintLine(Space(14) + sDiscount + RightStr(Space(12) + sHold,12));
      end;
    ELSE
      begin
        DM.PrintLine('                                        ');
        if TaxIsemptValue <> 0 then
          begin
            DM.PrintLine(Space(14) + sNoTaxAble + RightStr(Space(12) + FormatFloat('#,###,##0.00',TaxIsemptValue),12));
            DM.PrintLine(Space(14) + sTaxAble   + RightStr(Space(12) + FormatFloat('#,###,##0.00',SubTotalTaxable),12));
            DM.PrintLine(Space(14) + sTax       + RightStr(Space(12) + FormatFloat('#,###,##0.00',Tax),12));
          end
        else
          begin
            DM.PrintLine(Space(14) + sSubTotal + RightStr(Space(12) + FormatFloat('#,###,##0.00',SubTotal),12));
            DM.PrintLine(Space(14) + sTax      + RightStr(Space(12) + FormatFloat('#,###,##0.00',Tax),12));
          end;
        DM.PrintLine(Space(14) + sTotal + RightStr(Space(12) + FormatFloat('#,###,##0.00',Total),12));

        if ((Discount > 0) and not IsRefund) or ((Discount < 0) and IsRefund) then
           begin
             DM.PrintLine('                                        ');
             DM.PrintLine(Space(14) + sDiscount + RightStr(Space(12) + FormatFloat('#,###,##0.00',Discount),12));
           end;
      end;
    end;
end;

procedure TPrintReceipt.ImpTicketFooter();
begin
 //Print the ticket footer if it is checked
  if StrToBoolDef(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'PrintTicketFooter'), False) then
     ImpMemoDBInfo(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketFooter'));
end;

procedure TPrintReceipt.ImpFooterLayaway(AInvoiceTotal, APaymentTotal: Currency);
var
  sText: String;
begin
  if not StrToBoolDef(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'LayawayFooter'), False) then
    Exit;

  sText := DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketLayawayFooter');
  sText := StringReplace(sText, TICKET_PAYMENT_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00', APaymentTotal), 14), [rfReplaceAll]);
  sText := StringReplace(sText, TICKET_PAYMENT_BALANCE, IncLeftSpaces(FormatCurr('###,###,##0.00', APaymentTotal - AInvoiceTotal), 14), [rfReplaceAll]);

  ImpMemoDBInfo(sText);
end;


procedure TPrintReceipt.FormShow(Sender: TObject);
begin
  AniPrint.Active := True;
  btOk.Visible    := False;
end;

procedure TPrintReceipt.btOkClick(Sender: TObject);
begin
  Quit := True;
  Close;
end;

procedure TPrintReceipt.ImpTicketTaxExemption;
begin
  // Imprime o documento de isenção de taxa
  //Print Tax Isemption if it is checked

  if StrToBoolDef(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'PrintTaxInsemptFooter'), False) then
  begin
    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine(sTaxExpHeadr);
    DM.PrintLine('');
    DM.PrintLine(sIInvNum     + FPreSale.SaleCode);
    DM.PrintLine(sIInvDate    + DateToStr(FPreSale.PreSaleDate));
    DM.PrintLine(sICustomer   + FPreSale.PreSaleInfo.CustomerInfo.FirstName +' '+
                                          FPreSale.PreSaleInfo.CustomerInfo.LastName);
    DM.PrintLine(sIPassPort   {+ quPreSaleInfoPassport.AsString});
    DM.PrintLine(sIPassPrtNum {+ DateToStr(quPreSaleInfoPassportDate.AsDateTime)});
    DM.PrintLine(sITicketNum  {+ quPreSaleInfoTicket.AsString});
    DM.PrintLine(sIAirLine    {+ quPreSaleInfoAirLine.AsString});
    DM.PrintLine(sIArrivalNum {+ quPreSaleInfoCardNumber.AsString});
    DM.PrintLine(sIBusName    {+ quPreSaleInfoCompanyName.AsString});
    DM.PrintLine(sILicencNum  {+ quPreSaleInfoCompanyCGC.AsString});
    DM.PrintLine(sIAddress    {+ quPreSaleInfoAddress.AsString});

    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');

    ImpMemoDBInfo(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'TicketTaxIsemptFooter'));

    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');
    DM.PrintLine('');
  end;

end;
procedure TPrintReceipt.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sEndereco    := ' Address:';
           sNoTaxAble   := '  Non taxable:';
           sTaxAble     := '      Taxable:';
           sTax         := '          Tax:';
           sSubTotal    := '     SubTotal:';
           sTotal       := '        Total:';
           sDiscount    := '     Discount:';
           sHold        := 'HOLD';
           sTaxExpHeadr := '======= T A X   E X E M P T I O N ======';
           sIInvNum     := 'Invoice #     : ';
           sIInvDate    := 'Invoice Date  : ';
           sICustomer   := 'Customer      : ';
           sIPassPort   := 'Passport #    : ';
           sIPassPrtNum := 'Passport Date : ';
           sITicketNum  := 'Ticket #      : ';
           sIAirLine    := 'AirLine       : ';
           sIArrivalNum := 'Arrival Number: ';
           sIBusName    := 'Business Name : ';
           sILicencNum  := 'Licence #     : ';
           sIAddress    := 'Address       : ';
           sRecImpresso := 'Receipt Printed';
           sClickOK     := 'Click OK to continue';
           end;

     LANG_PORTUGUESE :
           begin
           sEndereco    := ' Endereço:';
           sNoTaxAble   := 'Não Tributável:';
           sTaxAble     := '    Tributável:';
           sTax         := '          Taxa:';
           sSubTotal    := '      SubTotal:';
           sTotal       := '         Total:';
           sDiscount    := '      Desconto:';
           sHold        := 'PEND';
           sTaxExpHeadr := '=== I S E N Ç Ã O    D E    T A X A ====';
           sIInvNum     := 'N. da Nota    : ';
           sIInvDate    := 'Data da Nota  : ';
           sICustomer   := 'Cliente       : ';
           sIPassPort   := 'N. Passaporte : ';
           sIPassPrtNum := 'Data Passporte: ';
           sITicketNum  := 'N. do Bilhete : ';
           sIAirLine    := 'Linha Aérea   : ';
           sIArrivalNum := 'N. da Chegada : ';
           sIBusName    := 'Empresa       : ';
           sILicencNum  := 'N. Taxa ID    : ';
           sIAddress    := 'Endereço      : ';
           sRecImpresso := 'Recibo Impresso';
           sClickOK     := 'Clique OK para continuar';
           end;

     LANG_SPANISH :
           begin
           sEndereco    := ' Dirección:';
           sNoTaxAble   := 'No Tributable:';
           sTaxAble     := '   Tributable:';
           sTax         := '     Impuesto:';
           sSubTotal    := '     SubTotal:';
           sTotal       := '        Total:';
           sDiscount    := '    Descuento:';
           sHold        := 'PEND';
           sTaxExpHeadr := '========= EXENCIÒN DE IMPUESTO =========';
           sIInvNum     := 'Boleta #        : ';
           sIInvDate    := 'Fecha Boleta    : ';
           sICustomer   := 'Cliente         : ';
           sIPassPort   := 'Pasaporte       : ';
           sIPassPrtNum := 'Fecha Pasaporte : ';
           sITicketNum  := 'Pasaje #        : ';
           sIAirLine    := 'Linea Aérea     : ';
           sIArrivalNum := 'Número Vuelo    : ';
           sIBusName    := 'Empresa         : ';
           sILicencNum  := 'Impuesto ID #   : ';
           sIAddress    := 'Dirección       : ';
           sRecImpresso := 'Recibo Imprimido';
           sClickOK     := 'Clic OK para continuar';
           end;
   end;


end;

procedure TPrintReceipt.tmrTimerTimer(Sender: TObject);
var
  NotOk: Boolean;
  I, J: Integer;
  PSI : TPreSaleItem;
  dDiscountToPrint, dItemDiscount, dInvoiceDiscount, dTotalToPrint: Currency;
  PMT: TPayment;
  PPay: TPartialPay;
begin
  inherited;
  tmrTimer.Enabled := False;

  Update;
  Application.ProcessMessages;

  // Open CashRegister
  NotOk := True;

  while NotOk do
    try
      DM.OpenCashRegister;
      DM.PrinterStart;
      NotOk := False;
    except
      if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
        NotOk := True
      else
      begin
        MsgBox(MSG_INF_REPRINT_INVOICE, vbInformation + vbOkOnly);
        Exit;
      end;
    end;

  // -----------------------------------------------------------------
  // Impressão do cabecalho do ticket
  case FReceiptType of
    RECEIPT_TYPE_INVOICE,
    RECEIPT_TYPE_LAYAWAY_RECEIVE: // INVOICE
    begin

    // Tem que descobrir quem pagou o Invoice
    ImpTicketHeader(FPresale.PreSaleDate,//quPreSaleInfoInvoiceDate.AsDateTime,
                    FPresale.COO,
                    FPresale.SaleCode,
                    FPresale.PreSaleInfo.CustomerInfo.FirstName + ' ' + FPresale.PreSaleInfo.CustomerInfo.LastName,
                    FOpenCashier, FPresale.PreSaleInfo.TouristGroup.IDTouristGroup,
                    False, FPresale.PreSaleInfo.MediaInfo.MediaName);
    end;

    RECEIPT_TYPE_HOLD: // HOLD
    begin
      ImpTicketHeader(FPresale.PreSaleDate,//quPreSaleInfoInvoiceDate.AsDateTime,
                      '0',
                      FPresale.SaleCode,
                      FPresale.PreSaleInfo.CustomerInfo.FirstName + ' ' + FPresale.PreSaleInfo.CustomerInfo.LastName,
                      '', FPresale.PreSaleInfo.TouristGroup.IDTouristGroup,
                      False, FPresale.PreSaleInfo.MediaInfo.MediaName);
    end;

    RECEIPT_TYPE_TICKET: // HOTEL TICKET
    begin
      ImpTicketDeliverHeader(FPresale.PreSaleDate,//quPreSaleInfoPreSaleDate.AsDateTime,
                             FPresale.SaleCode,
                             '0',
                             FPresale.PreSaleInfo.CustomerInfo.FirstName + ' ' + FPresale.PreSaleInfo.CustomerInfo.LastName,
                             ''{quPreSaleInfoDeliverAddress.AsString}, FPresale.PreSaleInfo.TouristGroup.IDTouristGroup,
                             FPresale.PreSaleInfo.MediaInfo.MediaName);
    end;
  end;

  // -----------------------------------------------------------------
  // Impressão dos itens do Ticket
  for I := 0 to FPreSale.Count - 1 do
  begin
    PSI := FPreSale.Items[I];
    if FPreSale.DiscountKind in [dkNone, dkInvoice] then
      dDiscountToPrint := 0
    else
      dDiscountToPrint := PSI.Discount;

    ImpTicketLine(PSI.Qty, PSI.Description,
                  PSI.Model, PSI.Sale - (dDiscountToPrint / PSI.Qty),
                  PSI.BarCode, PSI.IDUser,
                  DM.fPOS.TXTDescSystemUser(PSI.IDUser));
  end;

  // -----------------------------------------------------------------
  // Impressão dos Totais
  if (FPreSale.DiscountKind in [dkItem, dkInvoice]) then
  begin
    dItemDiscount    := FPreSale.DiscountTotal;
    dInvoiceDiscount := FPreSale.InvoiceDiscount;
  end
  else
  begin
    dItemDiscount    := 0;
    dInvoiceDiscount := 0;
  end;

    case FReceiptType of
    RECEIPT_TYPE_INVOICE,
    RECEIPT_TYPE_LAYAWAY_RECEIVE: // INVOICE
    begin
      ImpTicketTotals(FTaxable,
                      FExempt,
                      FPreSale.SaleTotal,
                      FPreSale.TaxTotal,
                      FPayments.InvoiceTotal,
                      MyCashReceived,
                      FPayments.ChangeTotal,
                      dItemDiscount,
                      dInvoiceDiscount,
                      FPreSale.RefundTotal,
                      FPreSale.PreSaleType = tptRefund);
    end;

    RECEIPT_TYPE_HOLD,
    RECEIPT_TYPE_TICKET: // HOLD AND HOTEL TICKET
    begin
      ImpTicketHoldTotals(FTaxable,
                          FExempt,
                          FPayments.InvoiceTotal,
                          FPreSale.TaxTotal,
                          FPreSale.SaleTotal,
                          MyCashReceived,
                          MyCashReceived - MyTotCash,
                          FReceiptType,
                          FPreSale.DiscountTotal + FPreSale.InvoiceDiscount,
                          FPreSale.PreSaleType = tptRefund);
    end;
  end;

  // -----------------------------------------------------------------
  // Impressão das parcelas
  case FReceiptType of
    RECEIPT_TYPE_INVOICE,
    RECEIPT_TYPE_LAYAWAY_RECEIVE: // INVOICE & LAYAWAY
    begin
      for I := 0 to FPayments.Count - 1 do
      begin
        PMT := FPayments.Items[I];
        for J := 0 to PMT.Count - 1 do
        begin
          PPay := PMT.Items[J];
          ImpTicketPaymentLine(PPay.ExpireDate,
                               DM.fPOS.DescCodigoCDS(DMPDV.cdsMeioPag, 'IDMeioPag', IntToStr(PMT.IDMeioPag), 'MeioPag'),
                               PPay.Value);
        end;
      end;
    end;

    RECEIPT_TYPE_HOLD, RECEIPT_TYPE_TICKET: // HOLD & HOTEL TICKET
    begin
      // Não tem impressao de parcelas
    end;
  end;

  // -----------------------------------------------------------------
  // Impressão do notes
  // if (DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'PrintNotes') = '1') then
  if (FPreSale.InvObs <> '') then
    ImpTicketNotes;

  // -----------------------------------------------------------------
  // Impressão do rodape
  case FReceiptType of
    RECEIPT_TYPE_INVOICE,
    RECEIPT_TYPE_TICKET,
    RECEIPT_TYPE_HOLD: // INVOICE, HOTEL TICKET, HOLD
      ImpTicketFooter();

    RECEIPT_TYPE_LAYAWAY_RECEIVE: //LAYAWAY + Total and balance
      ImpFooterLayaway(FPayments.InvoiceTotal, fPaymentTotal);
  end;

  // Caso o Invoice tenha recebido uma isenção de taxa, devo incluir
  // a impressao de um documento de conhecimento de isenção.
  if ((FReceiptType = RECEIPT_TYPE_INVOICE) AND FPreSale.TaxExempt)
     and (StrToBoolDef(DM.fPOS.DescCodigoCDS(DM.cdsStore, 'IDStore', IntToStr(DM.fStore.ID), 'PrintTaxInsemptFooter'), False)) then
  begin
    ImpTicketTaxExemption();
  end;

  DM.PrinterStop;
  DM.SendAfterPrintCode(True);

  lblPrint.Caption := sRecImpresso;
  btOk.Visible     := True;
  AniPrint.Active  := False;
  AniPrint.Visible  := False;
  pnlPrinter.Caption := sClickOK;
end;

end.
