unit PaiCashRegPetty;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, LblEffct, ExtCtrls, DBCtrls, DB, DBTables,
  ADODB, uSystemConst, uPai, Buttons, siComp, siLangRT;

type
  TFrmPaiCashRegPetty = class(TFrmPai)
    Label7: TLabel;
    EditTotPetty: TEdit;
    btCancel: TButton;
    lblObs: TLabel;
    edtObs: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
    MyIDCashRegMov : integer;
    procedure PrintDeposit;
  public
    { Public declarations }
    function Start(IDCashRegMov : integer) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uNumericFunctions, uDMGlobal, uStringFunctions;

{$R *.DFM}

function TFrmPaiCashRegPetty.Start(IDCashRegMov : integer) : Boolean;
begin
  (* MaxPetty := DM.fPOS.GetTotalCashReceived(IDCashRegMov) - DM.fSystem.SrvParam[PARAM_CASHREGRESTANT]; *)
  MyIDCashRegMov := IDCashRegMov;
  Result := (ShowModal = mrOK);
end;

procedure TFrmPaiCashRegPetty.FormShow(Sender: TObject);
begin
  inherited;
  EditTotPetty.SetFocus;
end;

procedure TFrmPaiCashRegPetty.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPaiCashRegPetty.btCloseClick(Sender: TObject);
var
  bCanPetty: Boolean;
  fData : TDateTime;
begin
  bCanPetty := True;
  inherited;

  // Não precisa mais disso. Agora não tem limite de suprimento

  (*
  if MyRound(MyStrToMoney(EditTotPetty.Text), 2) > MyRound(MaxPetty, 2) then
      begin
        if MsgBox(MSG_INF_PART_PETTYCASH_MAX + FloatToStrF(MaxPetty, ffCurrency, 20, 2) +
                  '. ' + MSG_QST_CONTINUE,
                   vbYesNo + vbQuestion) = vbNo then
          exit;
      end;
  *)

  if (MsgBox(MSG_QST_CONFIRM_PETTY_CASH, vbYesNo + vbQuestion) = vbYes) then
  begin

    fData := Now;

    //Imprimir para impressora fical Sangria
    if DM.fCashRegister.FiscalPrinter and DM.fCashRegister.Fiscal then
    begin
     if not DM.fModuloFiscal.ValidateSystemDate then
         Exit;

      bCanPetty := DM.EFiscal1.Suprimento(MyStrToMoney(EditTotPetty.Text), 'Dinheiro');
      fData := DM.fCupomFiscal.DataHora;
    end;

    DM.OpenCashRegister;

    case DM.PersistenceType of
      ptDB:
        DM.fPOS.AddAddCash(MyIDCashRegMov, DM.fUser.ID,
                           MyStrToMoney(EditTotPetty.Text), fData, edtObs.Text,
                           DM.fCupomFiscal.COO, DM.fCupomFiscal.GNF);
      ptTXT:
        DM.SaleWritter.AddPettyCash(MyIDCashRegMov, DM.fUser.ID,
                             MyStrToMoney(EditTotPetty.Text), fData, edtObs.Text,
                             DM.fCupomFiscal.COO, DM.fCupomFiscal.GNF);
    end;

    if DM.fPrintReceipt.PrintReceipt then
      PrintDeposit;

    ModalResult := mrOK;
  end;
end;

procedure TFrmPaiCashRegPetty.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(60);
end;

procedure TFrmPaiCashRegPetty.PrintDeposit;
var
  NotOk : boolean;
begin

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


  with DM do begin
  PrintLine('========================================');
  PrintLine('    S  U  P  R  I  M  E  N  T  O        ');
  PrintLine('   ----------------------------------   ');
  PrintLine('');
  PrintLine('');
  PrintLine('Usuário : '+ fUser.UserName);
  PrintLine('');
  PrintLine(FormatDateTime('dddddd, hh:mm AM/PM', Now));
  PrintLine('----------------------------------------');
  end;

  DM.PrintLine('');

  DM.PrintLine('Valor : ' + FormatFloat('0.00', MyStrToMoney(EditTotPetty.Text)));
  DM.PrintLine('OBS   : ' + edtObs.Text);
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine('');

  DM.PrinterStop;

end;

end.
