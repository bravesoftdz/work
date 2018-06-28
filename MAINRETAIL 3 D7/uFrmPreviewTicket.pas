unit uFrmPreviewTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, DB,
  ADODB, PowerADOQuery;

const
  NORMAL     = 1;
  LAYAWAY    = 2;
  TAX_EXEMPT = 3;

type
  TFrmPreviewTicket = class(TFrmParentPrint)
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    BTN: TBitBtn;
    btClose: TButton;
    memTicket: TMemo;
    quStore: TPowerADOQuery;
    quStoreTicketHeader: TMemoField;
    quStoreTicketLayawayFooter: TMemoField;
    quStoreTicketTaxIsemptFooter: TMemoField;
    quStoreTicketFooter: TMemoField;
    quStorePrintTicketHeader: TBooleanField;
    quStorePrintLayawayFooter: TBooleanField;
    quStorePrintTaxInsemptFooter: TBooleanField;
    quStorePrintTicketFooter: TBooleanField;
    quStoreTicketDetail: TMemoField;
    quStoreTicketTotals: TMemoField;
    dsStore: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTNClick(Sender: TObject);
  private
    { Private declarations }
    fIDStore : Integer;
    procedure DataSetOpen;
    procedure DataSetClose;
    procedure FillHeader;
    procedure FillDetail;
    procedure FillSubtotal;
    procedure FillFooter;
    procedure FillLaywayFooter;
    procedure FillExemptFooter;
  public
    { Public declarations }
    function Start(IDStore, FooterType:Integer):Boolean;
  end;

implementation

{$R *.dfm}

uses uDM, uParamFunctions, uSystemConst, XBase, uStringFunctions;

procedure TFrmPreviewTicket.DataSetOpen;
begin
  with quStore do
    if not Active then
       begin
       Parameters.ParambyName('IDStore').Value := fIDStore;
       Open;
       end;

end;

procedure TFrmPreviewTicket.DataSetClose;
begin
  with quStore do
    if Active then
       Close;
end;


function TFrmPreviewTicket.Start(IDStore, FooterType:Integer):Boolean;
begin

  fIDStore := IDStore;
  DataSetOpen;
  memTicket.Lines.Clear;

  FillHeader;
  FillDetail;
  FillSubtotal;
  //Footer type
  case FooterType of
     NORMAL     : FillFooter;
     LAYAWAY    : FillLaywayFooter;
     TAX_EXEMPT : FillExemptFooter;
  end;


  ShowModal;
  Result := (ModalResult=mrOK);
  
end;

procedure TFrmPreviewTicket.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  DataSetClose;
end;

procedure TFrmPreviewTicket.FillHeader;
var
  fText : string;
begin
  if not quStorePrintTicketHeader.AsBoolean then
     Exit;

  fText := quStoreTicketHeader.AsString;
  fText := StringReplace(fText, TICKET_DATE, '01/01/2001', [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TIME, '01:30 pm', [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CUSTOMER, 'CUSTOMER NAME', [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_MEDIA, 'MEDIA', [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CASHIER, 'CASHIER NAME', [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_HOLD, '1000000000', [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_INVOICE, '1000000000', [rfReplaceAll]);
  memTicket.Lines.Add(fText);
end;

procedure TFrmPreviewTicket.FillDetail;
var
  fText1,
  fText2,
  fText3 : string;
  i : Integer;
begin

  fText1 := quStoreTicketDetail.AsString;
  fText1 := StringReplace(fText1, TICKET_MODEL, 'MODEL 1', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_DESCRIPTION, 'MODEL DESCRIPTION 1', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_SP, 'SALES PERSON 1', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_SPN, '10', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_BARCODE, 'BARCODE', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_SERIALNUMBER, '(SERIAL1, SERIAL2)', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_QTY, '1000', [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_UNIT_PRICE, FormatCurr('###,###,##0.00',999999.99), [rfReplaceAll]);
  fText1 := StringReplace(fText1, TICKET_UNIT_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',999999.99),14), [rfReplaceAll]);

  fText2 := quStoreTicketDetail.AsString;
  fText2 := StringReplace(fText2, TICKET_MODEL, 'MODEL 2', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_DESCRIPTION, 'MODEL DESCRIPTION 2', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_SP, 'SALES PERSON 2', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_SPN, '20', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_BARCODE, 'BARCODE', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_SERIALNUMBER, '(SERIAL1, SERIAL2)', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_QTY, '50', [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_UNIT_PRICE, FormatCurr('###,###,##0.00',999999999.99), [rfReplaceAll]);
  fText2 := StringReplace(fText2, TICKET_UNIT_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99),14), [rfReplaceAll]);

  fText3 := quStoreTicketDetail.AsString;
  fText3 := StringReplace(fText3, TICKET_MODEL, 'MODEL 3', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_DESCRIPTION, 'MODEL DESCRIPTION 3', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_SP, 'SALES PERSON 3', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_SPN, '30', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_BARCODE, 'BARCODE', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_SERIALNUMBER, '(SERIAL1, SERIAL2)', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_QTY, '1', [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_UNIT_PRICE, FormatCurr('###,###,##0.00',999.99), [rfReplaceAll]);
  fText3 := StringReplace(fText3, TICKET_UNIT_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',999.99),14), [rfReplaceAll]);

  fText1 := IncLeftStringFlage('{>','<}', fText1,DM.fPrintReceipt.PrinterLineWidth);
  fText2 := IncLeftStringFlage('{>','<}', fText2,DM.fPrintReceipt.PrinterLineWidth);
  fText3 := IncLeftStringFlage('{>','<}', fText3,DM.fPrintReceipt.PrinterLineWidth);

  memTicket.Lines.Add(fText1);
  memTicket.Lines.Add(fText2);
  memTicket.Lines.Add(fText3);

end;

procedure TFrmPreviewTicket.FillSubtotal;
var
  fText, Payments : string;
  iRgh,
  i        : Integer;
begin

  Payments := IncSpaces('01/01/2002',12) + IncLeftSpaces('VISA',14) + IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14);
  Payments := Payments + #13#10 + IncSpaces('01/01/2002',12) + IncLeftSpaces('MASTER CARD',14) + IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14);
  Payments := Payments + #13#10 + IncSpaces('01/01/2003',12) + IncLeftSpaces('CASH',14) + IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14);

  fText := quStoreTicketTotals.AsString;

  fText := CopyStringFlage('{TA','TA}', fText, False);
  fText := CopyStringFlage('{ID','ID}', fText, False);
  fText := CopyStringFlage('{D','D}', fText, False);
  fText := CopyStringFlage('{R','R}', fText, False);

  fText := StringReplace(fText, TICKET_NO_TAXABLE, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TAXABLE, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_SUBTOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TAX, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CASH_RECEIVED, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_CHANGE, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_ITEM_DISCOUNT, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_DISCOUNT, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_PAYDATE_TYPE, Payments, [rfReplaceAll]);

  iRgh := CountStr(fText, '{>');
  for i:=1 to iRgh do
     fText := IncLeftStringFlage('{>','<}', fText,DM.fPrintReceipt.PrinterLineWidth);
  
  memTicket.Lines.Add(fText);
end;

procedure TFrmPreviewTicket.FillLaywayFooter;
var
  fText : string;
begin

  if not quStorePrintLayawayFooter.AsBoolean then
     Exit;

  fText := quStoreTicketLayawayFooter.AsString;
  fText := StringReplace(fText, TICKET_PAYMENT_TOTAL, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  fText := StringReplace(fText, TICKET_PAYMENT_BALANCE, IncLeftSpaces(FormatCurr('###,###,##0.00',999999999.99), 14), [rfReplaceAll]);
  memTicket.Lines.Add(fText);
  
end;

procedure TFrmPreviewTicket.FillExemptFooter;
begin
  if quStorePrintTaxInsemptFooter.AsBoolean then
     memTicket.Lines.Add(quStoreTicketTaxIsemptFooter.AsString);
end;

procedure TFrmPreviewTicket.FillFooter;
begin
  if quStorePrintTicketFooter.AsBoolean then
     memTicket.Lines.Add(quStoreTicketFooter.AsString);
end;

procedure TFrmPreviewTicket.BTNClick(Sender: TObject);
begin
  inherited;
  if DM.fPrintReceipt.PrintReceipt then
     ImpMemoDBInfo(memTicket.Text);
end;

end.
