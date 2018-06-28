unit uPrintCashReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, ADODB;

const
  TICKET_CASH_OPEN     = 1;
  TICKET_CASH_CLOSE    = 2;
  TICKET_CASH_PETTY    = 3;
  TICKET_CASH_ADD      = 4;

type

  TRegCash = record
    AOpenDate:    TDateTime;
    ACloseDate:   TDateTime;
    AOpenUser:    String;
    ACloseUser:   String;
    AIDCashReg:   Integer;
    ACashReg:     String;
    
    ABill100: Integer;
    ABill50:  Integer;
    ABill20:  Integer;
    ABill10:  Integer;
    ABill5:   Integer;
    ABill2:   Integer;
    ABill1:   Integer;
    ACoin001: Integer;
    ACoin005: Integer;
    ACoin010: Integer;
    ACoin025: Integer;
    ACoin050: Integer;
    ACoin1:   Integer;

    ATotalCash: Currency;
    ATotalCard: Currency;
    ATotalPreCard: Currency;
    ATotalCheck: Currency;
    ATotalOther: Currency;
    ATotalDebit: Currency;

    ATotalPetty: Currency;
    ATotalWithdraw: Currency;
  end;

  TPrintCashReg = class(TForm)
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
    quCashRegMov: TADOQuery;
    quCashRegMovTotalWidraw: TBCDField;
    quCashRegMovTotalPetty: TBCDField;
    quCashRegLogIDCashRegMov: TIntegerField;
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
    sTotalPetty,
    sTotalWithDraw,

    sCountItem : String;

    function GetItemsToCount(Num: Integer):String;
    function GetItemsToCountDB(Num: Integer): String;
    function GetItemsToCountTXT(Num: Integer): String;
  public
    { Public declarations }
    procedure Start(IDCashRegLog : Integer; ReceiptType: Integer);
  end;

implementation

uses uDM, uPassword, XBase, uMsgBox, uStringFunctions, uMsgConstant,
     uDMGlobal, uSystemConst, uTXTCashInfo, uFrmPOSFunctions;

{$R *.DFM}

function TPrintCashReg.GetItemsToCount(Num: Integer):String;
begin
  case DM.PersistenceType of
    ptDB:
      Result := GetItemsToCountDB(Num);
    ptTXT:
      Result := GetItemsToCountTXT(Num);
  end;
end;

function TPrintCashReg.GetItemsToCountDB(Num:Integer):String;
var
   iMax, i : Integer;
   bEmpty : Boolean;
begin

   iMax := 1 + DM.GetMaxKey(MR_MODEL_ID);

   with DM.quFreeSQL do
     begin

     if Active then
        Close;

     SQL.Clear;

     SQL.Add('SELECT M.Model, M.Description, TG.Name');
     SQL.Add('FROM Model M');
     SQL.Add('JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)');
     SQL.Add('WHERE IDModel = :IDModel');
     SQL.Add('AND M.Desativado = 0 AND M.Hidden = 0');

     Result := sCountItem + #13#10;

     for i := 1 to Num do
        begin
        bEmpty := True;

        while bEmpty do
           begin
           Close;
           Parameters.ParamByName('IDModel').Value := Random(iMax);
           Open;
           bEmpty := IsEmpty;
           end;

        Result := Result + sModel + Copy(FieldByName('Model').AsString,1,50) + #13#10 +
                           sDesc  + Copy(FieldByName('Description').AsString,1,50) + #13#10 +
                           sGroup + Copy(FieldByName('Name').AsString,1,50) + #13#10 +
                           sQty   + #13#10 +
                           '----------------------------------------' + #13#10 ;

        Close;
        end;
     end;

end;

function TPrintCashReg.GetItemsToCountTXT(Num:Integer):String;
begin
  Result := '';
end;

procedure TPrintCashReg.Start(IDCashRegLog : Integer; ReceiptType: Integer);
var
  NotOk: Boolean;
  RCR: TRegCash;
  TF: TTXTCashInfo;
begin

  case DM.PersistenceType of
    ptDB:
      begin
        with quCashRegLog do
        begin
          Parameters.ParambyName('IDCashRegLog').Value := IDCashRegLog;
          Open;
        end;

        with quCashRegMov do
        begin
          Parameters.ParambyName('IDCashRegMov').Value := quCashRegLogIDCashRegMov.AsInteger;
          Open;
        end;

        with RCR do
        begin
          AOpenDate     := quCashRegLogOpenTime.AsDateTime;
          ACloseDate    := quCashRegLogLogTime.AsDateTime;
          AOpenUser     := quCashRegLogOpenUser.AsString;
          ACloseUser    := quCashRegLogLogUser.AsString;
          AIDCashReg    := quCashRegLogIDCashRegister.AsInteger;
          ACashReg      := quCashRegLogCashRegister.AsString;

          ATotalCash    := quCashRegLogTotalCash.AsCurrency;
          ATotalCard    := quCashRegLogTotalCard.AsCurrency;
          ATotalDebit   := quCashRegLogTotalDebit.AsCurrency;
          ATotalPreCard := quCashRegLogTotalCardPre.AsCurrency;
          ATotalCheck   := quCashRegLogTotalCheck.AsCurrency;
          ATotalOther   := quCashRegLogTotalOther.AsCurrency;

          ABill100      := quCashRegLogBill100.AsInteger;
          ABill50       := quCashRegLogBill50.AsInteger;
          ABill20       := quCashRegLogBill20.AsInteger;
          ABill10       := quCashRegLogBill10.AsInteger;
          ABill5        := quCashRegLogBill5.AsInteger;
          ABill2        := quCashRegLogBill2.AsInteger;
          ABill1        := quCashRegLogBill1.AsInteger;
          
          ACoin001      := quCashRegLogCoin001.AsInteger;
          ACoin005      := quCashRegLogCoin005.AsInteger;
          ACoin010      := quCashRegLogCoin010.AsInteger;
          ACoin025      := quCashRegLogCoin025.AsInteger;
          ACoin050      := quCashRegLogCoin050.AsInteger;
          ACoin1        := quCashRegLogCoin1.AsInteger;

          ATotalPetty   := quCashRegMovTotalPetty.AsCurrency;
          ATotalWithdraw:= quCashRegMovTotalWidraw.AsCurrency;
        end;

        quCashRegLog.Close;
        quCashRegMov.Close;
      end;
    ptTXT:
    begin
      TF := DM.TXTCashInfoFactory(DM.fCashRegister.RecentClosedCash);
      try
        with RCR do
        begin
          AOpenDate    := TF.OpenDate;
          ACloseDate   := TF.CloseDate;

          AOpenUser    := DM.fPOS.TXTDescSystemUser(TF.IDOpenUser);
          ACloseUser   := DM.fPOS.TXTDescSystemUser(TF.IDCloseUser);

          AIDCashReg   := TF.IDCashReg;
          ACashReg     := DM.fPOS.TXTDescCashReg(TF.IDCashReg);

          case ReceiptType of
            TICKET_CASH_OPEN:
              begin
                ABill100      := TF.OpenBill100;
                ABill50       := TF.OpenBill50;
                ABill20       := TF.OpenBill20;
                ABill10       := TF.OpenBill10;
                ABill5        := TF.OpenBill5;
                ABill2        := TF.OpenBill2;
                ABill1        := TF.OpenBill1;
                ACoin001      := TF.OpenCoin001;
                ACoin005      := TF.OpenCoin005;
                ACoin010      := TF.OpenCoin010;
                ACoin025      := TF.OpenCoin025;
                ACoin050      := TF.OpenCoin050;
                ACoin1        := TF.OpenCoin1;

                ATotalCash    := TF.OpenTotalCash;
                ATotalCard    := TF.OpenTotalCard;
                ATotalDebit   := TF.OpenTotalDebit;
                ATotalPreCard := TF.OpenTotalPreCard;
                ATotalCheck   := TF.OpenTotalCheck;
                ATotalOther   := TF.OpenTotalOther;
              end;

            TICKET_CASH_CLOSE:
              begin
                ABill100      := TF.CloseBill100;
                ABill50       := TF.CloseBill50;
                ABill20       := TF.CloseBill20;
                ABill10       := TF.CloseBill10;
                ABill5        := TF.CloseBill5;
                ABill2        := TF.CloseBill2;
                ABill1        := TF.CloseBill1;
                ACoin001      := TF.CloseCoin001;
                ACoin005      := TF.CloseCoin005;
                ACoin010      := TF.CloseCoin010;
                ACoin025      := TF.CloseCoin025;
                ACoin050      := TF.CloseCoin050;
                ACoin1        := TF.CloseCoin1;

                ATotalCash    := TF.CloseTotalCash;
                ATotalCard    := TF.CloseTotalCard;
                ATotalDebit   := TF.CloseTotalDebit;
                ATotalPreCard := TF.CloseTotalPreCard;
                ATotalCheck   := TF.CloseTotalCheck;
                ATotalOther   := TF.CloseTotalOther;

                ATotalPetty   := TF.PettyCashTotal;
                ATotalWithdraw:= TF.WidrawTotal;
              end;
          end;
        end;

      finally
        TF.Free;
      end;
    end;
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

  // -----------------------------------------------------------------
  // Impressão do cabecalho do ticket

  case ReceiptType of
       TICKET_CASH_OPEN  : // Open
        begin
          DM.PrintLine('========================================');
          DM.PrintLine(sOpenCash);
          DM.PrintLine('   ----------------------------------   ');
          DM.PrintLine(sCash + RCR.ACashReg);
          DM.PrintLine('');
          DM.PrintLine(sOpenUser+ RCR.AOpenUser);
          DM.PrintLine(sOpenTime+ DateTimeToStr(RCR.AOpenDate));
          DM.PrintLine('----------------------------------------');
        end;
       TICKET_CASH_CLOSE : // Close
        begin
          DM.PrintLine('========================================');
          DM.PrintLine(sCloseCash);
          DM.PrintLine('   ----------------------------------   ');
          DM.PrintLine(sCash     + RCR.ACashReg);
          DM.PrintLine(sOpenUser + RCR.AOpenUser);
          DM.PrintLine(sOpenTime + DateTimeToStr(RCR.AOpenDate));
          DM.PrintLine(sCloseUser+ RCR.ACloseUser);
          DM.PrintLine(sCloseTime+ DateTimeToStr(RCR.ACloseDate));
          DM.PrintLine('----------------------------------------');
        end;
       TICKET_CASH_PETTY: // Petty Cash
        begin
        end;
       TICKET_CASH_ADD: //CashAdd
        begin
        end;
  end;

  DM.PrintLine(sTotalCash  + IdentRight(18, FloatToStrF(RCR.ATotalCash, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalCard  + IdentRight(18, FloatToStrF(RCR.ATotalCard, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalCardP + IdentRight(18, FloatToStrF(RCR.ATotalPreCard, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalDebit + IdentRight(18, FloatToStrF(RCR.ATotalDebit, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalCheck + IdentRight(18, FloatToStrF(RCR.ATotalCheck, ffCurrency, 20, 2)));
  DM.PrintLine(sTotalOther + IdentRight(18, FloatToStrF(RCR.ATotalOther, ffCurrency, 20, 2)));
  DM.PrintLine('');
  DM.PrintLine(sTotalConta + IdentRight(18, FloatToStrF(RCR.ATotalCash +
                                                        RCR.ATotalCard +
                                                        RCR.ATotalPreCard +
                                                        RCR.ATotalDebit +
                                                        RCR.ATotalCheck +
                                                        RCR.ATotalOther, ffCurrency, 20, 2)));
  DM.PrintLine('                                        ');
  DM.PrintLine(sCashDetail);
  DM.PrintLine('$100  : ' + FloatToStrF(RCR.ABill100, ffGeneral	, 20, 2));
  DM.PrintLine('$50   : ' + FloatToStrF(RCR.ABill50, ffGeneral	, 20, 2));
  DM.PrintLine('$20   : ' + FloatToStrF(RCR.ABill20, ffGeneral	, 20, 2));
  DM.PrintLine('$10   : ' + FloatToStrF(RCR.ABill10, ffGeneral	, 20, 2));
  DM.PrintLine('$5    : ' + FloatToStrF(RCR.ABill5, ffGeneral	, 20, 2));
  DM.PrintLine('$2    : ' + FloatToStrF(RCR.ABill2, ffGeneral	, 20, 2));
  DM.PrintLine('$1    : ' + FloatToStrF(RCR.ABill1, ffGeneral	, 20, 2));
  DM.PrintLine('$.01  : ' + FloatToStrF(RCR.ACoin001, ffGeneral	, 20, 2));
  DM.PrintLine('$.05  : ' + FloatToStrF(RCR.ACoin005, ffGeneral	, 20, 2));
  DM.PrintLine('$.10  : ' + FloatToStrF(RCR.ACoin010, ffGeneral	, 20, 2));
  DM.PrintLine('$.25  : ' + FloatToStrF(RCR.ACoin025, ffGeneral	, 20, 2));
  DM.PrintLine('$.50  : ' + FloatToStrF(RCR.ACoin050, ffGeneral	, 20, 2));
  DM.PrintLine('$1.00 : ' + FloatToStrF(RCR.ACoin1, ffGeneral	, 20, 2));
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');

  case ReceiptType of
    TICKET_CASH_CLOSE :
      begin
          DM.PrintLine(sTotalPetty + IdentRight(18, FloatToStrF(RCR.ATotalPetty, ffCurrency, 20, 2)));
          DM.PrintLine(sTotalWithDraw + IdentRight(18, FloatToStrF(RCR.ATotalWithdraw, ffCurrency, 20, 2)));
      end;
  end;

  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('-------------------------------');


  //Verifica se tem items para ser impresso no close da caixa
  if DM.fSystem.SrvParam[PARAM_NUM_ITEM_TO_PRINT] > 0 Then
     begin
     if (ReceiptType = TICKET_CASH_OPEN) AND (DM.fSystem.SrvParam[PARAM_PRINT_ON_OPENCASHREG]) then
        DM.PrintLine(GetItemsToCount(DM.fSystem.SrvParam[PARAM_NUM_ITEM_TO_PRINT]))
     else if (ReceiptType = TICKET_CASH_CLOSE) AND (not DM.fSystem.SrvParam[PARAM_PRINT_ON_OPENCASHREG]) then
        DM.PrintLine(GetItemsToCount(DM.fSystem.SrvParam[PARAM_NUM_ITEM_TO_PRINT]));
     end;

  DM.PrinterStop;
  DM.SendAfterPrintCode(True);

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

  Case DMGlobal.IDLanguage of
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
           sTotalCardP := 'Total Card Pre: ';
           sTotalDebit := 'Total Debit   : ';
           sTotalPetty    := 'Total Petty    :';
           sTotalWithDraw := 'Total Withdraw :';
           sTotalCheck := 'Total Check   : ';
           sTotalOther := 'Total Other   : ';
           sTotalConta := 'TOTAL COUNTED : ';
           sCashDetail := 'Cash Details                            ';
           end;

     LANG_PORTUGUESE :
           begin
           sCountItem  := '----- Por favor conte esses itens no stoque  -----';
           sModel      := 'Modelo :';
           sDesc       := 'Desc.  :';
           sGroup      := 'Categ. :';
           sQty        := 'Qtd   :';
           sOpenCash   := '    ABERTURA  DO  CAIXA  REGISTRADORA   ';
           sCash       := 'Dinheiro  : ';
           sOpenUser   := 'Usuário A : ';
           sOpenTime   := 'Abertura  : ';
           sCloseCash  := '   FECHAMENTO  DO  CAIXA  REGISTRADORA  ';
           sCloseUser  := 'Usuário F : ';
           sCloseTime  := 'Fechamento: ';
           sTotalCash  := 'Total Dinheiro  : ';
           sTotalCard  := 'Total Cartão    : ';
           sTotalCardP := 'Total Crt Débito: ';
           sTotalDebit := 'Total Débito    : ';
           sTotalCheck := 'Total Cheque    : ';
           sTotalOther := 'Total Outros    : ';
           sTotalConta := 'TOTAL CONTADO   : ';
           sCashDetail := 'Detalhe do dinheiro                     ';
           sTotalPetty    := 'Total Suprimento :';
           sTotalWithDraw := 'Total Sangria    :';
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
           sCloseTime  := 'Fecha     : ';
           sTotalCash  := 'Total Efectivo   : ';
           sTotalCard  := 'Total Tarjeta    : ';
           sTotalCardP := 'Total Tarjeta Fec: ';
           sTotalCardP := 'Total Trj Dédito : ';
           sTotalCheck := 'Total Cheques    : ';
           sTotalOther := 'Total Otros      : ';
           sTotalConta := 'TOTAL CONTADO    : ';
           sCashDetail := 'Detalle del efectivo                    ';
           sTotalPetty    := 'Total Suprimento :';
           sTotalWithDraw := 'Total Sangria    :';
           end;
   end;


end;

end.
