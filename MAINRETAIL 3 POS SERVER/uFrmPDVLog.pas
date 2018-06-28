unit uFrmPDVLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  OleCtrls, SHDocVw, uFilePersistence, DB, DBClient;

const  
  SPACE = '&nbsp;';
  CUPOM_VAZIO = 'XXXXXX';

type

  TPaymentTotal = class
    Total: Currency;
  end;

  TSaleLogType = (sltAll, sltIn, sltOut);

  TFrmPDVLog = class(TForm)
    pnlFilter: TPanel;
    lbHistory: TLabel;
    cbxLog: TComboBox;
    WebBrowser: TWebBrowser;
    chkUser: TCheckBox;
    chkCanceled: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    pnlButtom: TPanel;
    hhh: TPanel;
    btClose: TButton;
    pbOpenLine: TProgressBar;
    cdsSystemUser: TClientDataSet;
    cdsModel: TClientDataSet;
    cdsMeioPag: TClientDataSet;
    cdsCashRegLogReason: TClientDataSet;
    cdsCashRegLogReasonIDCashRegLogReason: TIntegerField;
    cdsCashRegLogReasonReason: TStringField;
    lbCaixa: TLabel;
    cbxCaixas: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxLogChange(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure cbxCaixasChange(Sender: TObject);
  private
    fTotalDiscount  : Currency;
    fTotalSale      : Currency;
    fTotalCancel    : Currency;
    fTotalRemovido  : Currency;
    fTotalSuprimento: Currency;
    fTotalSangria   : Currency;
    fTotalAbertura  : Currency;
    sLog            : TStringList;
    sPaymentLog     : TStringList;
    fShowAll        : TSaleLogType;
    FIDCashRegister : Integer;
    sPDVList        : TStringList;

    sInvoiceHeader,
    sInvNumber,
    sInvCustomer,
    sInvDate,
    sOpenCash,
    sItemRemovido,
    sPayments,
    sCashMoney,
    sCashCard,
    sCashDebit,
    sCashPost,
    sCashCheck,
    sCashOther,
    sCashTotal,
    sModelDesc,
    sModelSerial,
    sOBS,
    sPaySubTotal,
    sPayDesc,
    sInvDesc,
    sPayTotal,
    sInvCancel,
    sInvUser,
    sDeposit,
    sEnvolop,
    sCashLogReason,
    sPetty,
    sCloseCash,
    sTotalPayment,
    sRefundHeader,
    sInvoiceCanceled,
    sTotalCanceled,
    sTotalSangria,
    sTotalPayIn,
    sOpenCashReg,
    sTotalRemoved : String;

    function FormatHTMLLine(sText:String):String;
    procedure ReadLogFile(fFile:String);
    procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
    procedure DisplayLog;

    function FormatLog(sLogFile:String):String;
    function UnFormatLog(sLogFile:String):String;
    function IsInvoice(sCOO : String) : Boolean;

    procedure ClearPaymentTotal;
    procedure OpenCashRegister(Reg: TRegOpenCash);
    procedure InvoiceHeader(Reg: TRegOpenSale; Canceled : Boolean);
    procedure InvoiceItem(Reg: TRegAddItem; Canceled : Boolean; ASerialNumber : TList; ASaleLineParser : TSaleLineParser);
    procedure InvoicePayments(Reg: TRegAddPayment; Canceled : Boolean);
    procedure InvoiceComplete(RCS: TRegCloseSale);
    procedure InvoiceClose(Canceled : Boolean);
    procedure InvoiceCancel(Reg: TRegCancelSale);
    procedure InvoiceOBS(Reg: TRegOBS; FOBS : String; ASaleLineParser : TSaleLineParser);
    procedure Withdraw(Reg: TRegAddWC);
    procedure PettyCash(Reg: TRegAddPC);
    procedure CloseCashRegister(Reg: TRegCloseCash);
    procedure RemovedItem(Reg: TRegRemovedItem);
    procedure InvoicePaymentsSystem;
    procedure ImportDir(ADir : String);
    procedure ImportCashRegisters;

    procedure DisplayInvoice(ALastSale : TLastSale; ASaleLineParser : TSaleLineParser);

    function AjustaPreco(Qtde, PrecoBalanca, PrecoUnit: real): Real;
    function TruncarDecimal(Valor: Real; Decimal: integer): Double;

    procedure OpenDataSet;
    procedure CloseDataSet;

  public
    function Start : Boolean;
  end;

implementation

uses uTXTCashInfo, uStringFunctions, uNumericFunctions, uPOSServerConsts,
     ActiveX, uPreSale, uDMPOS, uDMGlobal, uMainconf;

{$R *.dfm}

{ TFrmPDVLog }


function TFrmPDVLog.Start: Boolean;
begin
   fShowAll := sltIn;
   ImportCashRegisters;
   OpenDataSet;
   ShowModal;
   Result := True;
end;

procedure TFrmPDVLog.ReadLogFile(fFile : String);
var
  CashInfo : TTXTCashInfo;
  i, iPosCancel : Integer;
  logObject: TObject;
  SaleLineParser : TSaleLineParser;
  LastSale : TLastSale;

begin

  if (fFile = '') or (not FileExists(fFile)) then
     Exit;

  sLog.Clear;
  CashInfo := TTXTCashInfo.Create;

  LastSale := TLastSale.Create;
  SaleLineParser := TSaleLineParser.Create;
  LastSale.ClearLastSale;
  
  try
    CashInfo.FileName := fFile;
    CashInfo.Load;
    ClearPaymentTotal;
    pbOpenLine.Max := CashInfo.LogList.Count-1;
    pbOpenLine.Visible := True;
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    for i := 0 to CashInfo.LogList.Count-1 do
    begin
       logObject := TLogHolder(CashInfo.LogList[i]).RegObject;
       pbOpenLine.Position := i;
       Application.ProcessMessages;
       case TLogHolder(CashInfo.LogList[i]).RegType of
       //Abertura de caixa
       sltOpenCash : OpenCashRegister(TOpenCash(logObject).Rec);
       //Abertura de venda
       sltOpenSale : begin
                       //Limpo a ultima venda caso a venda anterior nao seja completada corretamente!
                       if (LastSale.FOpenSaleLine <> '') and (LastSale.FPaymentList.Count = 0) then
                          LastSale.ClearLastSale;

                       LastSale.FOpenSaleLine := CashInfo.Lines[i];
                     end;
       //Itens da venda
       sltAddItem : LastSale.AddItem(CashInfo.Lines[i]);
       //Pagamento
       sltAddPayment : LastSale.AddPayment(CashInfo.Lines[i]);
       //Fechamento da venda
       sltCloseSale : begin
                      LastSale.FCloseSaleLine := CashInfo.Lines[i];
                      DisplayInvoice(LastSale, SaleLineParser);
                      end;
       //Cancelamento
       sltCancelSale : InvoiceCancel(TCancelSale(logObject).Rec);
       //Deposito
       sltWC : Withdraw(TAddWC(logObject).Rec);
       //Petty Cash
       sltPC : PettyCash(TAddPC(logObject).Rec);
       //Close Cash Register
       sltCloseCash : CloseCashRegister(TCloseCash(logObject).Rec);
       //Removed Item
       sltRemovedItem : RemovedItem(TRemovedItem(logObject).Rec);
       //Cancele Item
       sltCancelItem : begin
                       SaleLineParser.GetItemCanceled(CashInfo.Lines[i], iPosCancel);
                       LastSale.CancelItem(iPosCancel);
                       end;
       //Aborted Hold
       sltAbortSale : begin

                        if chkCanceled.Checked then
                        begin
                          if LastSale.FOpenSaleLine <> '' then
                          begin
                            LastSale.FCanceled := True;
                            DisplayInvoice(LastSale, SaleLineParser);
                          end
                          else
                            LastSale.FCanceled := False;
                        end
                        else
                          LastSale.ClearLastSale;
                      end;
       //Numero de Serie
       sltAddSerialNumber : LastSale.AddItemSerial(CashInfo.Lines[i]);
       sltOBS : LastSale.FOBS := CashInfo.Lines[i];
       sltReducaoZ : LastSale.ClearLastSale;
       end;
    end;

    InvoicePaymentsSystem;
    DisplayLog;

  finally
    FreeAndNil(CashInfo);
    FreeAndNil(LastSale);
    FreeAndNil(SaleLineParser);
    pbOpenLine.Visible := False;
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;


end;

procedure TFrmPDVLog.DisplayLog;
var
 sIni,
 sEnd : String;
begin
  sIni := '<html><BODY><p><font face="Courier" size="1" color="#3399FF">';
  sEnd := '</font></BODY></p></html>';
  WB_LoadHTML(WebBrowser, sIni + sLog.Text + sEnd);
end;


procedure TFrmPDVLog.InvoiceHeader(Reg: TRegOpenSale; Canceled : Boolean);
var
  InvNumber : String;
begin

  fTotalDiscount := 0;
  fTotalSale     := 0;

  if Reg.ACOO = CUPOM_VAZIO then
    InvNumber := Reg.ASaleCode
  else
    InvNumber := Reg.ACOO;

  if Canceled then
      sLog.Add('<font face="Courier" size="1" color="##FF0000">');

  if reg.APreSaleType = Integer(tptRefund) then
    sLog.Add(sRefundHeader)
  else
    sLog.Add(sInvoiceHeader);

  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvNumber +'<b>'+ InvNumber +'</b>'));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvDate + FormatDateTime('ddddd hh:mm',Reg.APreSaleDate)));
  sLog.Add('<br>');
  if (Reg.AFName <> '') then
    sLog.Add(FormatHTMLLine(sInvCustomer + Reg.AFName + ' ' + Reg.ALName));
  sLog.Add('<br>');
  sLog.Add('<br>');

end;

procedure TFrmPDVLog.OpenCashRegister(Reg: TRegOpenCash);
var
  sUser : String;
begin

  if cdsSystemUser.Locate('IDUser', Reg.AIDUser, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);

  fTotalAbertura := Reg.ATotalCash + Reg.ATotalCard + Reg.ATotalDebit + Reg.ATotalPreCard + Reg.ATotalCheck + Reg.ATotalOther;

  sLog.Add(sOpenCash);
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvUser + sUser));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashMoney + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCash))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashCard + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCard))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashDebit + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalDebit))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashPost + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalPreCard))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashCheck + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCheck))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashOther + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalOther))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashTotal + IdentRight(30,FormatCurr('#,##0.00', fTotalAbertura))));
  sLog.Add('<br>');
  sLog.Add('<br>');

end;

procedure TFrmPDVLog.InvoiceItem(Reg: TRegAddItem; Canceled : Boolean; ASerialNumber : TList; ASaleLineParser : TSaleLineParser);
var
  Model,
  Desc,
  Item,
  Discount,
  Price,
  sUser : String;
  i : Integer;
  RSN: TRegSerialNumber;
  fPrice : Real;
begin

  if cdsSystemUser.Locate('IDUser', Reg.AIDUser, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);

  fPrice := AjustaPreco(Reg.AQty, (Reg.ASale * Reg.AQty), Reg.ASale);

  if not Canceled then
  begin
    if Reg.ADiscount <> 0 then
       fTotalDiscount := fTotalDiscount + Reg.ADiscount;

    fTotalSale := fTotalSale + fPrice;
  end;

  if cdsModel.Locate('IDModel', Reg.AIDModel, []) then
     begin
     Model := cdsModel.FieldByName('Model').AsString;
     Desc  := cdsModel.FieldByName('Description').AsString;
     end;

  Item := '(' + Model + ') ' + Desc;
  if Length(Item) > 40 then
     Item := Copy(Item,1,40) + '<br>' + Copy(Item,40,40);

  {
  case FDisplayType of
    DISPLAY_MODEL       : begin
                          Item := Model;
                          if Length(Item) > 40 then
                             Item := Copy(Item,1,40) + '<br>' +Copy(Item,40,40);
                          end;
    DISPLAY_DESCRIPTION : begin
                          Item := Desc;
                          if Length(Item) > 40 then
                             Item := Copy(Item,1,40) + '<br>' +Copy(Item,40,40);
                          end;
    DISPLAY_MODEL_DESC  : begin
                          Item := '(' + Model + ') ' + Desc;
                          if Length(Item) > 40 then
                             Item := Copy(Item,1,40) + '<br>' + Copy(Item,40,40);
                          end;
  else
    Item := Copy(Desc,1,40);
  end;
  }

  Price := FormatFloat('0.#####', Reg.AQty) + 'x' + FormatFloat('#,###0.00',Reg.ASale) + ' = ' +
           IncLeftSpaces(FormatFloat('#,###0.00', fPrice), 20);

  Price := IdentRight(40, Price);

  if Reg.ADiscount <> 0 then
     Discount := FormatFloat('#,###0.00', Reg.ADiscount);


  if Canceled then
      sLog.Add('<font face="Courier" size="1" color="##FF0000">');

  sLog.Add(FormatHTMLLine(Item));
  sLog.Add('<br>');
  if chkUser.Checked then
     begin
     sLog.Add(FormatHTMLLine('  '+sUser));
     sLog.Add('<br>');
     end;
  sLog.Add(FormatHTMLLine(Price));
  sLog.Add('<br>');
  if Reg.ADiscount <> 0 then
     begin
     sLog.Add(FormatHTMLLine(sModelDesc + Discount));
     sLog.Add('<br>');
     end;

  for i := 0 to ASerialNumber.Count-1 do
  begin
    ASaleLineParser.GetAddSerialNumber(TLastSaleItemSerial(ASerialNumber[I]).FItemSerialLine, RSN);
    sLog.Add(FormatHTMLLine(sModelSerial + RSN.ASerialNumber));
    sLog.Add('<br>');
  end;

  if Canceled then
      sLog.Add('</font>');

end;

procedure TFrmPDVLog.InvoiceClose(Canceled : Boolean);
begin

  sLog.Add('<br>');

  if Canceled then
      sLog.Add('</font>');


end;

procedure TFrmPDVLog.InvoicePayments(Reg: TRegAddPayment; Canceled : Boolean);
var
  sMeioPagName,
  MeioPag : String;
  PayType : TPaymentTotal;
  i : Integer;
begin

  if cdsMeioPag.Locate('IDMeioPag', Reg.AIDMeioPag, []) then
     sMeioPagName := Copy(cdsMeioPag.FieldByName('MeioPag').AsString,1,40);

  MeioPag := IncSpaces(sMeioPagName,24) + ' ' + IdentRight(15,FormatFloat('#,###0.00', Reg.ATotalInvoice));

  sLog.Add(FormatHTMLLine(MeioPag));
  sLog.Add('<br>');

  if not Canceled then
  begin
    i := sPaymentLog.IndexOf(sMeioPagName);
    if i = -1 then
       begin
       PayType := TPaymentTotal.Create;
       PayType.Total := Reg.ATotalInvoice;
       sPaymentLog.AddObject(sMeioPagName, PayType);
       end
    else
       begin
       TPaymentTotal(sPaymentLog.Objects[i]).Total :=
            TPaymentTotal(sPaymentLog.Objects[i]).Total + Reg.ATotalInvoice;
       end;
  end;

end;

procedure TFrmPDVLog.WB_LoadHTML(WebBrowser: TWebBrowser;
  HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
   Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TFrmPDVLog.FormCreate(Sender: TObject);
begin
  inherited;
  sLog        := TStringList.Create;
  sPaymentLog := TStringList.Create;
  sPDVList    := TStringList.Create;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sInvNumber     := 'Invoice  :';
           sInvDate       := 'Date     :';
           sInvCustomer   := 'Customer :';
           sCashMoney     := 'Cash     :';
           sCashCard      := 'C. Card  :';
           sCashDebit     := 'C. Debit :';
           sCashPost      := 'Post-Date:';
           sCashCheck     := 'Check    :';
           sCashOther     := 'Outhers  :';
           sCashTotal     := 'Total    :';
           sModelDesc     := '  Discount        ';
           sModelSerial   := '     S/N ';
           sOBS           := 'OBS: ';
           sPaySubTotal   := 'SubTotal';
           sPayDesc       := 'Item Discount';
           sInvDesc       := 'Invoice Discount';
           sPayTotal      := 'TOTAL';
           sInvUser       := 'User     :';
           sEnvolop       := 'Envelop  :';
           sCashLogReason := 'Reason   :';
           sOpenCash      := '----------------- Open -----------------';
           sItemRemovido  := '------------- Item Deleted -------------';
           sInvCancel     := '--------------- Canceled ---------------';
           sInvoiceHeader := '---------------- Ticket ----------------';
           sDeposit       := '---------------  Deposit  --------------';
           sPetty         := '-------------- Petty Cash --------------';
           sCloseCash     := '----------------- Close ----------------';
           sPayments      := 'Payment(s) -----------------------------';
           sRefundHeader  := '---------------- Refund ----------------';
           sTotalPayment  := '--------- Payment Type Total -----------';
           sInvoiceCanceled := 'Canceled :';
           sTotalCanceled   := 'Canceled';
           sTotalSangria    := 'Withdraw';
           sTotalPayIn      := 'Pay In';
           sOpenCashReg     := 'Open Cash';
           sTotalRemoved    := 'Item canceled';
           end;

     LANG_PORTUGUESE :
           begin
           sInvNumber     := 'Numero   :';
           sInvDate       := 'Data     :';
           sInvCustomer   := 'Cliente  :';
           sCashMoney     := 'Dinheiro :';
           sCashCard      := 'Cartao   :';
           sCashDebit     := 'C. Debito:';
           sCashPost      := 'Pre      :';
           sCashCheck     := 'Cheque   :';
           sCashOther     := 'Outros   :';
           sCashTotal     := 'Total    :';
           sModelDesc     := '  Desconto        ';
           sModelSerial   := '     N/S ';
           sOBS           := 'OBS: ';
           sPaySubTotal   := 'SubTotal';
           sPayDesc       := 'Desconto item';
           sInvDesc       := 'Desconto nota';
           sPayTotal      := 'TOTAL';
           sInvUser       := 'Usuario  :';
           sEnvolop       := 'Envelope :';
           sCashLogReason := 'Motivo   :';
           sInvoiceHeader := '------------- Cupom Fiscal -------------';
           sOpenCash      := '----------- Abertura de caixa ----------';
           sItemRemovido  := '---------- Produto Removido ------------';
           sInvCancel     := '--------------- Cancelado --------------';
           sDeposit       := '---------------  Sangria  --------------';
           sPetty         := '-------------- Suprimento --------------';
           sCloseCash     := '-------------- Fechamento --------------';
           sPayments      := 'Pagamento(s) ---------------------------';
           sRefundHeader  := '--------------- Devolução --------------';
           sTotalPayment  := '----------- Totais de Venda ------------';
           sInvoiceCanceled := 'Cancelado:';
           sTotalCanceled   := 'Cancelado';
           sTotalSangria    := 'Sangria';
           sTotalPayIn      := 'Suprimento';
           sOpenCashReg     := 'Abertura';
           sTotalRemoved    := 'Produto(s) Removido';
           end;

     LANG_SPANISH :
           begin
           sInvNumber     := 'Boleta   :';
           sInvDate       := 'Fecha    :';
           sInvCustomer   := 'Cliente  :';
           sCashMoney     := 'Dinero   :';
           sCashCard      := 'C. Card  :';
           sCashDebit     := 'C. Debito:';
           sCashPost      := 'Pre      :';
           sCashCheck     := 'Cheque   :';
           sCashOther     := 'Outros   :';
           sCashTotal     := 'Total    :';
           sModelDesc     := '  Descuento       ';
           sModelSerial   := '     N/S ';
           sOBS           := 'OBS: ';
           sPaySubTotal   := 'SubTotal';
           sPayDesc       := 'Descuento item';
           sInvDesc       := 'Descuento boleta';
           sPayTotal      := 'TOTAL';
           sInvUser       := 'Usuario  :';
           sEnvolop       := 'Sobre    :';
           sCashLogReason := 'Motivo   :';
           sOpenCash      := '----------------- Abra -----------------';
           sItemRemovido  := '---------- Produto Removido ------------';
           sInvCancel     := '-------------- Cancelado ---------------';
           sInvoiceHeader := '---------------- Boleta ----------------';
           sDeposit       := '--------------- Depósito ---------------';
           sPetty         := '-------------- Caja chica --------------';
           sCloseCash     := '----------------- Cierre ---------------';
           sPayments      := 'Pago(s) --------------------------------';
           sRefundHeader  := '--------------- Reembolso --------------';
           sTotalPayment  := '---------- Total Forma Pago(s) ---------';
           sInvoiceCanceled := 'Cancelado:';
           sTotalCanceled   := 'Cancelado';
           sTotalSangria    := 'Retirada';
           sTotalPayIn      := 'Suprimento';
           sOpenCashReg     := 'Abertura';
           sTotalRemoved    := 'Item cancelado';
           end;
   end;

end;

procedure TFrmPDVLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ClearPaymentTotal;
  CloseDataSet;
  FreeAndNil(sLog);
  FreeAndNil(sPaymentLog);
  FreeAndNil(sPDVList);
end;

function TFrmPDVLog.FormatHTMLLine(sText:String): String;
begin
  Result := StringReplace(sText, ' ', SPACE, [rfReplaceAll]);
end;

procedure TFrmPDVLog.InvoiceCancel(Reg: TRegCancelSale);
var
  sUser : String;
  ACanceledNow: Currency;
begin
  ACanceledNow := Reg.ACard + Reg.ACash + Reg.ACheck + Reg.APreCard + Reg.AOther;

  fTotalCancel := fTotalCancel + ACanceledNow;

  if cdsSystemUser.Locate('IDUser', Reg.AIDUser, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);

  sLog.Add('<font face="Courier" size="1" color="##FF0000">');
  sLog.Add(sInvCancel);
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvNumber + '<b>' + Reg.ACOO +'</b>'));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvUser + sUser));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvoiceCanceled + FormatCurr('#,##0.00', ACanceledNow)));
  sLog.Add('<br>');
  sLog.Add('<br>');
  sLog.Add('</font>');

end;

procedure TFrmPDVLog.Withdraw(Reg: TRegAddWC);
var
  sUser, sReason : String;
begin

  if cdsSystemUser.Locate('IDUser', Reg.AIDUser, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);

  if cdsCashRegLogReason.Locate('IDCashRegLogReason', Reg.AIDReason, []) then
     sReason := Copy(cdsCashRegLogReason.FieldByName('Reason').AsString,1,30);

  fTotalSangria := fTotalSangria + (Reg.ATotalCash + Reg.ATotalCard + Reg.ATotalDebit + Reg.ATotalPreCard + Reg.ATotalCheck + Reg.ATotalOther);

  sLog.Add('<br>');
  sLog.Add(sDeposit);
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sEnvolop + Reg.AEnvolop));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvUser + sUser));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashLogReason + sReason));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashMoney + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCash))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashCard + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCard))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashDebit + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalDebit))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashPost + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalPreCard))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashCheck + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCheck))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashOther + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalOther))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashTotal + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCash + Reg.ATotalCard + Reg.ATotalPreCard + Reg.ATotalCheck + Reg.ATotalOther))));
  sLog.Add('<br>');
  sLog.Add('<br>');

end;

procedure TFrmPDVLog.PettyCash(Reg: TRegAddPC);
var
  sUser : String;
begin

  fTotalSuprimento := fTotalSuprimento + Reg.ACash;

  if cdsSystemUser.Locate('IDUser', Reg.AIDUser, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);
  sLog.Add('');
  sLog.Add('<br>');
  sLog.Add(sPetty);
  sLog.Add(FormatHTMLLine(sInvUser + sUser));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashMoney + IdentRight(30,FormatCurr('#,##0.00', Reg.ACash))));
  sLog.Add('<br>');
  sLog.Add('<br>');

end;

procedure TFrmPDVLog.CloseCashRegister(Reg: TRegCloseCash);
var
  sUser : String;
begin

  if cdsSystemUser.Locate('IDUser', Reg.AIDUser, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);

  sLog.Add('');
  sLog.Add('<br>');
  sLog.Add(sCloseCash);
  sLog.Add(FormatHTMLLine(sEnvolop + Reg.AEnvolop));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sInvUser + sUser));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashMoney + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCash))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashCard + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCard))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashDebit + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalDebit))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashPost + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalPreCard))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashCheck + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCheck))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashOther + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalOther))));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sCashTotal + IdentRight(30,FormatCurr('#,##0.00', Reg.ATotalCash + Reg.ATotalCard + Reg.ATotalPreCard + Reg.ATotalCheck + Reg.ATotalOther))));
  sLog.Add('<br>');
  sLog.Add('<br>');
end;

procedure TFrmPDVLog.ImportDir(ADir : String);
var
  SR: TSearchRec;
begin

  try
      if FindFirst(ADir + '*.ven', faAnyFile, SR) = 0 then
      try
        repeat
          if (SR.Attr and faDirectory) = 0 then
          begin
            cbxLog.Items.Add(FormatLog(SR.Name));
          end;
        until FindNext(SR) <> 0;
      finally
        FindClose(SR);
      end;

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;

end;

function TFrmPDVLog.FormatLog(sLogFile: String): String;
var
  sYear,
  sMonth,
  sDay,
  sHour,
  sMinute,
  sSecond : String;
begin
  Result  := Copy(sLogFile, Pos('-',sLogFile)+1, 15);

  sYear   := Copy(Result, 0, 4);
  sMonth  := Copy(Result, 5, 2);
  sDay    := Copy(Result, 7, 2);
  sHour   := Copy(Result, 10, 2);
  sMinute := Copy(Result, 12, 2);
  sSecond := Copy(Result, 14, 2);

  Result := sYear + '.' + sMonth + '.' + sDay + ' - ' + sHour + ':' + sMinute + ':' + sSecond;

end;

function TFrmPDVLog.UnFormatLog(sLogFile: String): String;
begin

 Result := '';

 if sLogFile = '' then
    Exit;

 Result := StringReplace(sLogFile, '.', '', [rfReplaceAll]);
 Result := StringReplace(Result, ':', '', [rfReplaceAll]);
 Result := StringReplace(Result, ' ', '', [rfReplaceAll]);
 Result := 'PDV'+IntToStr(FIDCashRegister)+'-'+Result+'.ven';
end;

procedure TFrmPDVLog.cbxLogChange(Sender: TObject);
var
  sDir : String;
begin
  inherited;

  if FileExists(DMPOS.LocalPath + POS_DIR_FILES_HISTORY + IntToStr(FIDCashRegister) + '\' + UnFormatLog(cbxLog.Text)) then
    sDir := DMPOS.LocalPath + POS_DIR_FILES_HISTORY + IntToStr(FIDCashRegister) + '\' + UnFormatLog(cbxLog.Text)
  else
    sDir := DMPOS.LocalPath + POS_DIR_FILES + IntToStr(FIDCashRegister) + '\' + UnFormatLog(cbxLog.Text);

  ReadLogFile(sDir);

end;

procedure TFrmPDVLog.ClearPaymentTotal;
var
  PayType : TPaymentTotal;
begin
  fTotalCancel     := 0;
  fTotalRemovido   := 0;
  fTotalSuprimento := 0;
  fTotalSangria    := 0;
  fTotalAbertura   := 0;
  While sPaymentLog.Count <> 0 do
     begin
     if sPaymentLog.Objects[0] <> nil then
        begin
        PayType := TPaymentTotal(sPaymentLog.Objects[0]);
        FreeAndNil(PayType);
        end;
     sPaymentLog.Delete(0);
     end;
end;

procedure TFrmPDVLog.InvoicePaymentsSystem;
var
  i : Integer;
  fTotal : Currency;
begin

  sLog.Add('');
  sLog.Add('<br>');
  sLog.Add(sTotalPayment);
  sLog.Add('<br>');
  fTotal := 0;

  for i := 0 to sPaymentLog.Count-1 do
    begin
    fTotal := fTotal + TPaymentTotal(sPaymentLog.Objects[i]).Total;
    sLog.Add(FormatHTMLLine(IncSpaces(sPaymentLog.Strings[i],30) + IdentRight(10,FormatCurr('#,##0.00', TPaymentTotal(sPaymentLog.Objects[i]).Total))));
    sLog.Add('<br>');
    end;

  if fTotalCancel > 0 then
  begin
    sLog.Add(FormatHTMLLine(IncSpaces(sTotalCanceled,30) + IdentRight(10,FormatCurr('#,##0.00', (fTotalCancel * -1)))));
    sLog.Add('<br>');
  end;

  sLog.Add(FormatHTMLLine(IncSpaces('TOTAL',30) + IdentRight(10,FormatCurr('#,##0.00', fTotal - fTotalCancel))));
  sLog.Add('<br>');

  if fTotalRemovido > 0 then
  begin
    sLog.Add('----------------------------------------');
    sLog.Add(FormatHTMLLine(IncSpaces(sTotalRemoved,30) + IdentRight(10,FormatCurr('#,##0.00', fTotalRemovido))));
    sLog.Add('<br>');
    sLog.Add('<br>');
  end;

  sLog.Add('--------- Operações do caixa -------------');
  sLog.Add(FormatHTMLLine(IncSpaces(sOpenCashReg,30) + IdentRight(10,FormatCurr('#,##0.00', fTotalAbertura))));
  sLog.Add('<br>');

  if fTotalSuprimento > 0 then
  begin
    sLog.Add(FormatHTMLLine(IncSpaces(sTotalPayIn,30) + IdentRight(10,FormatCurr('#,##0.00', fTotalSuprimento))));
    sLog.Add('<br>');
  end;

  if fTotalSangria > 0 then
  begin
    sLog.Add(FormatHTMLLine(IncSpaces(sTotalSangria,30) + IdentRight(10,FormatCurr('#,##0.00', (fTotalSangria * -1)))));
    sLog.Add('<br>');
  end;

  sLog.Add('----------------------------------------');
  sLog.Add(FormatHTMLLine(IncSpaces('GRANDE TOTAL',30) + IdentRight(10,FormatCurr('#,##0.00', fTotal - fTotalCancel - fTotalSangria + fTotalSuprimento + fTotalAbertura))));
  sLog.Add('<br>');

end;

procedure TFrmPDVLog.RemovedItem(Reg: TRegRemovedItem);
var
  Model,
  Desc,
  Item,
  Discount,
  Price,
  sUser : String;
  fPrice : Real;
begin

  if cdsModel.Locate('IDModel', Reg.AIDModel, []) then
     begin
     Model := cdsModel.FieldByName('Model').AsString;
     Desc  := cdsModel.FieldByName('Description').AsString;
     end;

  if cdsSystemUser.Locate('IDUser', Reg.AIDUserAuto, []) then
     sUser := Copy(cdsSystemUser.FieldByName('SystemUser').AsString,1,30);

  Item := '(' + Model + ') ' + Desc;
  if Length(Item) > 40 then
     Item := Copy(Item,1,40) + '<br>' + Copy(Item,40,40);
     
 {
  case DM.fCashRegister.DisplayType of
    DISPLAY_MODEL       : begin
                          Item := Model;
                          if Length(Item) > 40 then
                             Item := Copy(Item,1,40) + '<br>' +Copy(Item,40,40);
                          end;
    DISPLAY_DESCRIPTION : begin
                          Item := Desc;
                          if Length(Item) > 40 then
                             Item := Copy(Item,1,40) + '<br>' +Copy(Item,40,40);
                          end;
    DISPLAY_MODEL_DESC  : begin
                          Item := '(' + Model + ') ' + Desc;
                          if Length(Item) > 40 then
                             Item := Copy(Item,1,40) + '<br>' + Copy(Item,40,40);
                          end;
  else
    Item := Copy(Desc,1,40);
  end;
  }

  fPrice := AjustaPreco(Reg.AQty, (Reg.ASale * Reg.AQty), Reg.ASale);

  Price := FormatFloat('0.#####', Reg.AQty) + 'x' + FormatFloat('#,###0.00',Reg.ASale) + ' = ' +
           IncLeftSpaces(FormatFloat('#,###0.00', TruncMoney(fPrice, 2) ), 20);

  Price := IdentRight(40, Price);

  if Reg.ADiscount <> 0 then
     Discount := FormatFloat('#,###0.00',Reg.ADiscount);

  fTotalRemovido := fTotalRemovido + (TruncMoney(fPrice, 2) - Reg.ADiscount);

  sLog.Add('<font face="Courier" size="1" color="##FF0000">');

  sLog.Add(sItemRemovido);

  sLog.Add(FormatHTMLLine(Item));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(Price));
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine('  '+sUser));
  sLog.Add('</font>');

  sLog.Add('<br>');

end;

procedure TFrmPDVLog.DisplayInvoice(ALastSale : TLastSale; ASaleLineParser : TSaleLineParser);
var
  ROS: TRegOpenSale;
  RAI: TRegAddItem;
  RAP: TRegAddPayment;
  RCS: TRegCloseSale;
  ROBS : TRegOBS;
  FLastSaleItem : TLastSaleItem;
  FLastSaleItemSerial : TLastSaleItemSerial;
  i : Integer;
begin

  ASaleLineParser.GetOpenSale(ALastSale.FOpenSaleLine, ROS);

  if (fShowAll = sltIn) then
  begin
    if (not IsInvoice(ROS.ACOO)) then
    begin
      ALastSale.ClearLastSale;
      Exit;
    end;
  end
  else if (fShowAll = sltOut) then
  begin
    if IsInvoice(ROS.ACOO) then
    begin
      ALastSale.ClearLastSale;
      Exit;
    end;
  end;

  InvoiceHeader(ROS, ALastSale.FCanceled);

  for i := 0 to ALastSale.FItemList.Count-1 do
  begin
    FLastSaleItem := TLastSaleItem(ALastSale.FItemList.Objects[i]);
    ASaleLineParser.GetAddItem(FLastSaleItem.FItemLine, RAI);

    if chkCanceled.Checked then
      InvoiceItem(RAI, FLastSaleItem.FCanceled, FLastSaleItem.FSerialList, ASaleLineParser)
    else if (not FLastSaleItem.FCanceled) then
      InvoiceItem(RAI, FLastSaleItem.FCanceled, FLastSaleItem.FSerialList, ASaleLineParser);
  end;

  if ALastSale.FCloseSaleLine <> '' then
  begin
    ASaleLineParser.GetCloseSale(ALastSale.FCloseSaleLine, RCS);
    InvoiceComplete(RCS);
  end;

  for i := 0 to ALastSale.FPaymentList.Count-1 do
  begin
    ASaleLineParser.GetAddPayment(ALastSale.FPaymentList.Strings[i], RAP);
    InvoicePayments(RAP, ALastSale.FCanceled);
  end;

  if ALastSale.FOBS <> '' then
    InvoiceOBS(ROBS, ALastSale.FOBS, ASaleLineParser);

  InvoiceClose(ALastSale.FCanceled);

  ALastSale.ClearLastSale;

end;

procedure TFrmPDVLog.InvoiceComplete(RCS: TRegCloseSale);
begin

   sLog.Add('<br>');
   if (fTotalDiscount <> 0) or (RCS.ASaleDiscount <> 0) then
   begin
     sLog.Add(FormatHTMLLine(sPaySubTotal + IncLeftSpaces(FormatFloat('#,###0.00', fTotalSale), 32)));
   end;

   if fTotalDiscount <> 0 then
   begin
     sLog.Add(FormatHTMLLine(sPayDesc + IncLeftSpaces(FormatFloat('#,###0.00', fTotalDiscount), 27)));
   end;

   if RCS.ASaleDiscount <> 0 then
   begin
     sLog.Add(FormatHTMLLine(sInvDesc + IncLeftSpaces(FormatFloat('#,###0.00', RCS.ASaleDiscount), 27)));
   end;

   sLog.Add(FormatHTMLLine(sPayTotal + IncLeftSpaces(FormatFloat('#,###0.00', fTotalSale - fTotalDiscount - RCS.ASaleDiscount), 35)));
   sLog.Add('<br>');
   sLog.Add(sPayments);
   sLog.Add('<br>');

end;

procedure TFrmPDVLog.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(390);
end;

procedure TFrmPDVLog.InvoiceOBS(Reg: TRegOBS; FOBS : String;
    ASaleLineParser : TSaleLineParser);
begin

  ASaleLineParser.GetOBS(FOBS, Reg);
  sLog.Add('<br>');
  sLog.Add(FormatHTMLLine(sOBS + Trim(Reg.AOBS)));
  sLog.Add('<br>');

end;

function TFrmPDVLog.IsInvoice(sCOO: String): Boolean;
begin
  Result := (sCOO <> CUPOM_VAZIO);
  if Result then
    Result := (sCOO <> '');
end;

procedure TFrmPDVLog.Image1Click(Sender: TObject);
begin
  inherited;

  if fShowAll <> sltIn then
    fShowAll := sltIn
  else
    fShowAll := sltAll;

  cbxLogChange(self);

end;

procedure TFrmPDVLog.Image2Click(Sender: TObject);
begin
  inherited;

  if fShowAll <> sltOut then
    fShowAll := sltOut
  else
    fShowAll := sltAll;

  cbxLogChange(self);
  
end;

function TFrmPDVLog.AjustaPreco(Qtde, PrecoBalanca, PrecoUnit: real): Real;
var
  PrecoECF, QtdeECF: real;
  sQTD: String;
begin
  sQTD := FormatFloat('0000.000', Qtde);

  QtdeECF := TruncarDecimal(StrToFloat(sQTD), 3);
  Qtde := TruncarDecimal(Qtde, 3);

  if QtdeECF <> Qtde then
    PrecoECF := QtdeECF * PrecoUnit
  else
    PrecoECF := Qtde * PrecoUnit;

  PrecoECF := TruncarDecimal(PrecoECF, 2);

  if PrecoBalanca <> PrecoECF then
    Result := PrecoECF
    else
    Result := PrecoBalanca;
end;

function TFrmPDVLog.TruncarDecimal(Valor: Real; Decimal: integer): Double;
var
  aux: string;
  bNeg : Boolean;
begin

  bNeg := False;

  if Valor < 0 then
    bNeg := True;

  valor := Abs(valor);
  valor := valor * 100000;
  aux := FormatFloat('00000000000000000000',valor);
  aux := copy( aux, 1, 15) + copy( aux, 16, Decimal);
  case Decimal of
    2: valor := strToFloat(aux) / 100;
    3: valor := strToFloat(aux) / 1000;
    4: valor := strToFloat(aux) / 10000;
    5: valor := strToFloat(aux) / 100000;
  end;

  if bNeg then
    valor := valor * -1;
  
  result := Valor;

end;

procedure TFrmPDVLog.ImportCashRegisters;
var
 i      : integer;
begin

  cbxCaixas.Items.Clear;

  try
     FrmMain.fIniConfig.ReadSection(POS_PDV_KEY, sPDVList);

     for i := 0 to sPDVList.Count-1 do
       cbxCaixas.Items.Add(sPDVList.Strings[i]);

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;

end;

procedure TFrmPDVLog.cbxCaixasChange(Sender: TObject);
var
  sDir : String;
begin

  if cbxCaixas.Text <> '' then
  begin
    FIDCashRegister := LongInt(FrmMain.fIniConfig.ReadInteger(POS_PDV_KEY, cbxCaixas.Text, -1));
    if FIDCashRegister <> -1 then
    begin
      cbxLog.Items.Clear;
      sDir := DMPOS.LocalPath + POS_DIR_FILES + IntToStr(FIDCashRegister) + '\';
      ImportDir(sDir);
      sDir := DMPOS.LocalPath + POS_DIR_FILES_HISTORY + IntToStr(FIDCashRegister) + '\';
      ImportDir(sDir);
    end;
  end;

end;

procedure TFrmPDVLog.CloseDataSet;
begin
  cdsSystemUser.Close;
  cdsModel.Close;
  cdsMeioPag.Close;
  cdsCashRegLogReason.Close;
end;

procedure TFrmPDVLog.OpenDataSet;
begin
  try
    Cursor := crHourGlass;
    cdsSystemUser.LoadFromFile(DMPOS.LocalPath + 'PDVFiles\SystemUser.xml');
    cdsModel.LoadFromFile(DMPOS.LocalPath + 'PDVFiles\Model.xml');
    cdsMeioPag.LoadFromFile(DMPOS.LocalPath + 'PDVFiles\MeioPag.xml');
    cdsCashRegLogReason.LoadFromFile(DMPOS.LocalPath + 'PDVFiles\CashRegLogReason.xml');
  finally
    Cursor := crDefault;
  end;
end;

end.
