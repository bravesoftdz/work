unit uPrintCashReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ADODB, siComp, siLangRT, PaideForms;

const
  TICKET_CASH_OPEN     = 1;
  TICKET_CASH_CLOSE    = 2;
  TICKET_CASH_PETTY    = 3;
  TICKET_CASH_ADD      = 4;

type
  TPrintCashReg = class(TFrmParentForms)
    Label1: TLabel;
    Panel1: TPanel;
    quCashRegLog: TADOQuery;
    quCashRegLogIDCashRegLog: TIntegerField;
    quCashRegLogIDUser: TIntegerField;
    quCashRegLogLogTime: TDateTimeField;
    quCashRegLogBill100: TIntegerField;
    quCashRegLogBill50: TIntegerField;
    quCashRegLogBill20: TIntegerField;
    quCashRegLogBill10: TIntegerField;
    quCashRegLogBill5: TIntegerField;
    quCashRegLogBill2: TIntegerField;
    quCashRegLogBill1: TIntegerField;
    quCashRegLogCoin1: TIntegerField;
    quCashRegLogCoin050: TIntegerField;
    quCashRegLogCoin025: TIntegerField;
    quCashRegLogCoin010: TIntegerField;
    quCashRegLogCoin005: TIntegerField;
    quCashRegLogCoin001: TIntegerField;
    quCashRegLogTotalCard: TFloatField;
    quCashRegLogOpenTime: TDateTimeField;
    quCashRegLogTotalCheck: TFloatField;
    quCashRegLogTotalOther: TFloatField;
    quCashRegLogTotalCash: TFloatField;
    quCashRegLogIDCashRegister: TIntegerField;
    quCashRegLogCashRegister: TStringField;
    quCashRegLogOpenUser: TStringField;
    quCashRegLogLogUser: TStringField;
    quCashRegLogTotalCardPre: TFloatField;
    quCashRegLogTotalDebit: TBCDField;
    quCashRegLogObs: TStringField;
    quCashRegLogReason: TStringField;
    quSisProperty: TADODataSet;
    quSisPropertyPropertyValue: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sModel,
    sDesc,
    sGroup,
    sQty,
    sOpenCash,
    sCash,
    sOpenUser,
    sOpenTime,
    sCloseCash,
    sCloseUser,
    sCloseTime,
    sTotalCash,
    sTotalCard,
    sTotalDebit,
    sTotalCardP,
    sTotalCheck,
    sTotalOther,
    sTotalConta,
    sCashDetail,
    sPettyCash,
    sCashAdd,
    sPettyDate,
    sPettyUser,
    sObs,
    sReason,

    sCountItem: String;

    procedure PrintDetails;
    procedure GetItemsToCount(Num:Integer; sIDs:String);
    function GetPropertyDomain(AField:String):String;
  public
    procedure Start(IDCashRegLog : Integer; ReceiptType: Integer);
  end;

implementation

uses uDM, uPassword, XBase, uMsgBox, uStringFunctions, uMsgConstant,
     uDMGlobal, uSystemConst, Math;

{$R *.DFM}

procedure TPrintCashReg.GetItemsToCount(Num: Integer; sIDs: String);
var
   iMax, iPos, i, iPrinted : Integer;
   bEmpty : Boolean;
begin

   with DM.quFreeSQL do
   begin

     if Active then
        Close;

     SQL.Clear;

     SQL.Add('SELECT M.Model, M.Description, TG.Name');
     SQL.Add('FROM Model M (NOLOCK) ');
     SQL.Add('JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)');
     SQL.Add('WHERE M.Desativado = 0 AND M.Hidden = 0');
     if sIDs <> '' then
       SQL.Add('AND TG.IDGroup IN (' + sIDs + ')');

     try
       Open;
       iMax := RecordCount;
       iPrinted := 0;
       if iMax > 0 then
       begin
         DM.PrinterStart;
         Randomize;
         iPos := Random(iMax);
         DM.PrintLine(sCountItem);
         for i := 1 to Num do
         begin
           inc(iPrinted);
           iPos := Random(iMax);
           First;
           MoveBy(iPos);

           DM.PrintLine(sModel + Copy(FieldByName('Model').AsString,1,50));
           DM.PrintLine(sDesc  + Copy(FieldByName('Description').AsString,1,50));
           DM.PrintLine(sGroup + Copy(FieldByName('Name').AsString,1,50));
           DM.PrintLine(sQty);
           DM.PrintLine('----------------------------------------');

           if iPrinted >= 10 then
           begin
             iPrinted := 0;
             DM.PrinterStop;
             DM.PrinterStart;
           end;

         end;

         DM.PrinterStop;
       end;

     finally
       Close;
     end;
   end;

end;

procedure TPrintCashReg.Start(IDCashRegLog : Integer; ReceiptType: Integer);
var
  NotOk: Boolean;
begin
  with quCashRegLog do
  begin
    Parameters.ParambyName('IDCashRegLog').Value := IDCashRegLog;
    Open;
  end;

  Show;
  Update;

  Application.ProcessMessages;

  NotOk := True;

  while NotOk do
  begin
    try
      DM.PrinterStart;
      NotOk := False;
    except
      if MsgBox(MSG_CRT_ERROR_PRINTING, vbCritical + vbYesNo) = vbYes then
        NotOk := True
      else
      begin
        Exit;
      end;
    end;
  end;

  case ReceiptType of
       TICKET_CASH_OPEN  : // Open
        begin
          DM.PrintLine('========================================');
          DM.PrintLine(sOpenCash);
          DM.PrintLine('   ----------------------------------   ');
          DM.PrintLine(sCash + quCashRegLogCashRegister.AsString);
          DM.PrintLine('');
          DM.PrintLine(sOpenUser+ quCashRegLogOpenUser.AsString);
          DM.PrintLine(sOpenTime+ DateTimeToStr(quCashRegLogOpenTime.AsDateTime));
          DM.PrintLine('----------------------------------------');
          PrintDetails;
        end;
       TICKET_CASH_CLOSE : // Close
        begin
          DM.PrintLine('========================================');
          DM.PrintLine(sCloseCash);
          DM.PrintLine('   ----------------------------------   ');
          DM.PrintLine(sCash      + quCashRegLogCashRegister.AsString);
          DM.PrintLine(sOpenUser  + quCashRegLogOpenUser.AsString);
          DM.PrintLine(sOpenTime  + DateTimeToStr(quCashRegLogOpenTime.AsDateTime));
          DM.PrintLine(sCloseUser + quCashRegLogLogUser.AsString);
          DM.PrintLine(sCloseTime + DateTimeToStr(quCashRegLogLogTime.AsDateTime));
          DM.PrintLine('----------------------------------------');
          PrintDetails;
        end;
        TICKET_CASH_PETTY: // Petty Cash
        begin
          DM.PrintLine('========================================');
          DM.PrintLine(sPettyCash);
          DM.PrintLine('----------------------------------------');
          DM.PrintLine(sPettyDate + DateTimeToStr(quCashRegLogLogTime.AsDateTime));
          DM.PrintLine(sCash      + FormatFloat('0.00', quCashRegLogTotalCash.AsFloat));
          DM.PrintLine(sPettyUser + quCashRegLogLogUser.AsString);
          DM.PrintLine(sReason    + quCashRegLogReason.AsString);
          DM.PrintLine(sObs       + quCashRegLogObs.AsString);
          DM.PrintLine('----------------------------------------');
        end;
        TICKET_CASH_ADD: //CashAdd
        begin
          DM.PrintLine('========================================');
          DM.PrintLine(sCashAdd);
          DM.PrintLine('----------------------------------------');
          DM.PrintLine(sPettyDate + DateTimeToStr(quCashRegLogLogTime.AsDateTime));
          DM.PrintLine(sCash      + FormatFloat('0.00', quCashRegLogTotalCash.AsFloat));
          DM.PrintLine(sPettyUser + quCashRegLogLogUser.AsString);
          DM.PrintLine(sReason    + quCashRegLogReason.AsString);
          DM.PrintLine(sObs       + quCashRegLogObs.AsString);
          DM.PrintLine('----------------------------------------');
        end;
  end;

  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('.');

  DM.PrinterStop;

  if StrToInt(GetPropertyDomain('InvCountConfigNumItens')) > 0 then
  begin
    if (ReceiptType = TICKET_CASH_OPEN) AND (GetPropertyDomain('InvCountConfigPrintWhen') = '0') then
      GetItemsToCount(StrToInt(GetPropertyDomain('InvCountConfigNumItens')), GetPropertyDomain('InvCountConfigCategory'))
    else if (ReceiptType = TICKET_CASH_CLOSE) AND (GetPropertyDomain('InvCountConfigPrintWhen') = '1') then
      GetItemsToCount(StrToInt(GetPropertyDomain('InvCountConfigNumItens')), GetPropertyDomain('InvCountConfigCategory'));
  end;


  // Cortar o papel
  if DM.fPrintReceipt.PaperType <> PAPER_TYPE_4A then
    DM.SendAfterPrintCode;

  Close;

  ModalResult := mrOK;
end;

procedure TPrintCashReg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintCashReg.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sCountItem  := '------ Please count these Inventory Items  -------';
      sModel      := 'Model :';
      sDesc       := 'Desc. :';
      sGroup      := 'Categ :';
      sQty        := 'Qty   :';
      sOpenCash   := '   O P E N   C A S H  R E G I S T E R   ';
      sCash       := 'Cash : ';
      sOpenUser   := 'Open User : ';
      sOpenTime   := 'Open Time : ';
      sCloseCash  := ' C L O S E   C A S H  R E G I S T E R   ';
      sCloseUser  := 'Close User : ';
      sCloseTime  := 'Close Time : ';
      sTotalCash  := 'Total Cash    : ';
      sTotalCard  := 'Total Card    : ';
      sTotalDebit := 'Total Debit   : ';
      sTotalCardP := 'Total Card Pre: ';
      sTotalCheck := 'Total Check   : ';
      sTotalOther := 'Total Other   : ';
      sTotalConta := 'TOTAL COUNTED : ';
      sCashDetail := 'Cash Details                            ';
      sPettyCash  := '          P E T T Y   C A S H           ';
      sCashAdd    := '          C A S H   I N                 ';
      sPettyDate  := 'Date:';
      sPettyUser  := 'User:';
      sObs        := 'Obs   :';
      sReason     := 'Reason:';
    end;

    LANG_PORTUGUESE :
    begin
      sCountItem  := '----- Por favor conte esses itens no stoque  -----';
      sModel      := 'Modelo :';
      sDesc       := 'Desc.  :';
      sGroup      := 'Categ. :';
      sQty        := 'Qtd   :';
      sOpenCash   := '    ABERTURA  DO  CAIXA  REGISTRADORA   ';
      sCash       := 'Dinheiro: ';
      sOpenUser   := 'Usuário A : ';
      sOpenTime   := 'Abertura  : ';
      sCloseCash  := '   FECHAMENTO  DO  CAIXA  REGISTRADORA  ';
      sCloseUser  := 'Usuário F : ';
      sCloseTime  := 'Fechamento: ';
      sTotalCash  := 'Total Dinheiro  : ';
      sTotalCard  := 'Total Cartão    : ';
      sTotalDebit := 'Total Crt Débito: ';
      sTotalCardP := 'Total Cartão Pre: ';
      sTotalCheck := 'Total Cheque    : ';
      sTotalOther := 'Total Outros    : ';
      sTotalConta := 'TOTAL CONTADO   : ';
      sCashDetail := 'Detalhe do dinheiro                     ';
      sPettyCash  := '          R E T I R A D A               ';
      sCashAdd    := '          S U P R I M E N T O           ';
      sPettyDate  := 'Data    : ';
      sPettyUser  := 'Usuário : ';
      sObs        := 'Obs     : ';
      sReason     := 'Motivo  : ';
    end;

    LANG_SPANISH :
    begin
      sCountItem  := '-- Porfavor contar estos items del Inventario  ---';
      sModel      := 'Modelo :';
      sDesc       := 'Desc.  :';
      sGroup      := 'Categ  :';
      sQty        := 'Ctd    :';
      sOpenCash   := '        A B R I R    L A    C A J A     ';
      sCash       := 'Efectivo : ';
      sOpenUser   := 'Usuario A : ';
      sOpenTime   := 'Apertura  : ';
      sCloseCash  := '    C E R R A R    L A    C A J A       ';
      sCloseUser  := 'Usuario C : ';
      sPettyCash  := '          R E T I R A D A               ';
      sCashAdd    := '          S U P R I M E N T O           ';
      sCloseTime  := 'Fecha     : ';
      sTotalCash  := 'Total Efectivo   : ';
      sTotalCard  := 'Total Tarjeta    : ';
      sTotalDebit := 'Total Trj Débito: ';
      sTotalCardP := 'Total Tarjeta Fec: ';
      sTotalCheck := 'Total Cheques    : ';
      sTotalOther := 'Total Otros      : ';
      sTotalConta := 'TOTAL CONTADO    : ';
      sCashDetail := 'Detalle del efectivo                    ';
      sObs        := 'Obs   :';
      sReason     := 'Razón :';
    end;
  end;
end;

procedure TPrintCashReg.PrintDetails;
begin
  DM.PrintLine(sTotalCash  + IdentRight(18, FloatToStrF(quCashRegLogTotalCash.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalCard  + IdentRight(18, FloatToStrF(quCashRegLogTotalCard.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalDebit + IdentRight(18, FloatToStrF(quCashRegLogTotalDebit.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalCardP + IdentRight(18, FloatToStrF(quCashRegLogTotalCardPre.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalCheck + IdentRight(18, FloatToStrF(quCashRegLogTotalCheck.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalOther + IdentRight(18, FloatToStrF(quCashRegLogTotalOther.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine('');
  DM.PrintLine(sTotalConta + IdentRight(18, FloatToStrF(quCashRegLogTotalCash.AsFloat+
                                                      quCashRegLogTotalCard.AsFloat+
                                                      quCashRegLogTotalDebit.AsFloat +
                                                      quCashRegLogTotalCardPre.AsFloat+
                                                      quCashRegLogTotalCheck.AsFloat+
                                                      quCashRegLogTotalOther.AsFloat, ffCurrency, 20, 2)));
  DM.PrintLine('                                        ');
  DM.PrintLine(sCashDetail);
  DM.PrintLine('$100  : ' + quCashRegLogBill100.AsString);
  DM.PrintLine('$50   : ' + quCashRegLogBill50.AsString);
  DM.PrintLine('$20   : ' + quCashRegLogBill20.AsString);
  DM.PrintLine('$10   : ' + quCashRegLogBill10.AsString);
  DM.PrintLine('$5    : ' + quCashRegLogBill5.AsString);
  DM.PrintLine('$2    : ' + quCashRegLogBill2.AsString);
  DM.PrintLine('$1    : ' + quCashRegLogBill1.AsString);
  DM.PrintLine('$.01  : ' + quCashRegLogCoin001.AsString);
  DM.PrintLine('$.05  : ' + quCashRegLogCoin005.AsString);
  DM.PrintLine('$.10  : ' + quCashRegLogCoin010.AsString);
  DM.PrintLine('$.25  : ' + quCashRegLogCoin025.AsString);
  DM.PrintLine('$.50  : ' + quCashRegLogCoin050.AsString);
  DM.PrintLine('$1.00 : ' + quCashRegLogCoin1.AsString);
end;

function TPrintCashReg.GetPropertyDomain(AField: String): String;
begin
  with quSisProperty do
  try
    if Active then
      Close;
    Parameters.ParamByName('Property').Value := AField;
    Open;
    Result := FieldByName('PropertyValue').AsString;
  finally
    Close;
  end;

end;

end.
