unit uCashRegWidraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, Mask, LblEffct, ExtCtrls, DBCtrls, DB, DBTables,
  ADODB, siComp, siLangRT, Buttons, SuperComboADO;

type
  TCashRegWidraw = class(TFrmParent)
    Label23: TLabel;
    btCancel: TButton;
    Panel10: TPanel;
    Label12: TLabel;
    Panel11: TPanel;
    grpCoin: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Edit0100: TEdit;
    Edit050: TEdit;
    Edit025: TEdit;
    Edit010: TEdit;
    Edit005: TEdit;
    Edit001: TEdit;
    EditTot001: TEdit;
    EditTot005: TEdit;
    EditTot010: TEdit;
    EditTot025: TEdit;
    EditTot050: TEdit;
    EditTot0100: TEdit;
    grpBill: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Edit100: TEdit;
    Edit50: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit10: TEdit;
    Edit20: TEdit;
    EditTot100: TEdit;
    EditTot50: TEdit;
    EditTot20: TEdit;
    EditTot10: TEdit;
    EditTot5: TEdit;
    EditTot2: TEdit;
    EditTot1: TEdit;
    EditTotCash: TEdit;
    Label1: TLabel;
    Label7: TLabel;
    EditTotCashier: TEdit;
    pnlOther: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Panel6: TPanel;
    EditMaxDeposit: TEdit;
    Label10: TLabel;
    cmbTotalCard: TEdit;
    btnTotalCard: TSpeedButton;
    cmbTotalPre: TEdit;
    btnPostDate: TSpeedButton;
    cmbTotalCheck: TEdit;
    btnCheckTotal: TSpeedButton;
    cmbTotalOther: TEdit;
    btnOtherTotal: TSpeedButton;
    edtObs: TEdit;
    lblOBS: TLabel;
    lbDebitCard: TLabel;
    cmbTotalDebit: TEdit;
    btnTotalDebit: TSpeedButton;
    lblReason: TLabel;
    scCashRegLogReason: TSuperComboADO;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure AtuTotals(Sender : TObject);
    procedure AtuTotOthers(Sender : TObject);
    procedure Edit100KeyPress(Sender: TObject; var Key: Char);
    procedure cmbTotalCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnTotalCardClick(Sender: TObject);
  private
    { Private declarations }
    //Translaiton
    sDeposit,
    sCashRegNum,
    sUserName,
    sTotalCash,
    sTotalCard,
    sTotalCardP,
    sTotalCheck,
    sTotalOther,
    sTotalCount,
    sTotalDebit,
    sEnvNum : String;

    TotCashGeral, TotOtherGeral : Double;
    MyIDOpenUser, MyIDCashRegMov : integer;
    TotSaleCash : Double;
    MaxDeposit    : Double;
    sEnvelop : string;
    fCall : Integer;
    procedure AtuTotCashier;
    procedure PrintDeposit;
    function  TestaPreenchimento(MyControl : TControl) : Boolean;
  public
    { Public declarations }
    function Start(IDCashRegMov : integer) : Boolean;
  end;

implementation

uses uDM, uItemsCalc, uCashRegEnvelop, uMsgBox, uMsgConstant, uSystemConst,
     uNumericFunctions, uCharFunctions, uStringFunctions, uDMGlobal;

{$R *.DFM}

procedure TCashRegWidraw.PrintDeposit;
var
  NotOk : boolean;
  sCard, sCardPre, sCheck, sOther, sDebito : String;
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

  
  DM.PrintLine('========================================');
  DM.PrintLine(sDeposit);
  DM.PrintLine('   ----------------------------------   ');
  DM.PrintLine('');
  DM.PrintLine('');
  DM.PrintLine(sCashRegNum + IntToStr(MyIDCashRegMov));
  DM.PrintLine(sEnvNum     + sEnvelop);
  DM.PrintLine(sUserName   + DM.fUser.UserName);
  DM.PrintLine('');
  DM.PrintLine(FormatDateTime('dddddd, hh:mm AM/PM', Now));
  DM.PrintLine('----------------------------------------');

  if Trim(cmbTotalCard.Text) = '' then
     sCard := '$ 0.00'
  else
     sCard := '$ ' + cmbTotalCard.Text;

  if Trim(cmbTotalPre.Text) = '' then
     sCardPre := '$ 0.00'
  else
     sCardPre := '$ ' + cmbTotalPre.Text;

  if Trim(cmbTotalCheck.Text) = '' then
     sCheck := '$ 0.00'
  else
     sCheck := '$ ' + cmbTotalCheck.Text;

  if Trim(cmbTotalOther.Text) = '' then
     sOther := '$ 0.00'
  else
     sOther := '$ ' + cmbTotalOther.Text;

  if Trim(cmbTotalDebit.Text) = '' then
     sDebito := '$ 0.00'
  else
     sDebito := '$ ' + cmbTotalDebit.Text;


  DM.PrintLine(sTotalCash  + IdentRight(15, EditTotCash.Text));
  DM.PrintLine(sTotalCard  + IdentRight(15, sCard));
  DM.PrintLine(sTotalDebit + IdentRight(15, sDebito));
  DM.PrintLine(sTotalCardP + IdentRight(15, sCardPre));
  DM.PrintLine(sTotalCheck + IdentRight(15, sCheck));
  DM.PrintLine(sTotalOther + IdentRight(15, sOther));
  DM.PrintLine('');
  DM.PrintLine('');

  DM.PrintLine(sTotalCount + IdentRight(15, EditTotCashier.Text));

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

function TCashRegWidraw.Start(IDCashRegMov : integer) : Boolean;
begin
  Result := False;
  fCall  := -1;

  // Calcula o totsalecash e CashRegMovID
  MaxDeposit := DM.fPOS.GetTotalCashWithdraw(IDCashRegMov) - DM.fSystem.SrvParam[PARAM_CASHREGRESTANT];
  MyIDCashRegMov := IDCashRegMov;

  // Open CashRegister
  DM.OpenCashRegister(DRAW_KICK_TYPO_WIDRAW);

  EditMaxDeposit.Text := FloatToStrF(MaxDeposit, ffCurrency, 20, 2);

  Result := (ShowModal = mrOK);
end;

procedure TCashRegWidraw.AtuTotals(Sender : TObject);
var
  Razao        : Double;
  EditValor    : TEdit;
begin
  EditValor := TEdit(Sender);
  Razao     := (EditValor.Tag)/100;

  case EditValor.Tag of
    10000 : EditValor := EditTot100;
    5000  : EditValor := EditTot50;
    2000  : EditValor := EditTot20;
    1000  : EditValor := EditTot10;
     500  : EditValor := EditTot5;
     200  : EditValor := EditTot2;
     100  : if EditValor.Parent.tag = 0 then
              EditValor := EditTot1
            else
              EditValor := EditTot0100;
       1  : EditValor := EditTot001;
       5  : EditValor := EditTot005;
      10  : EditValor := EditTot010;
      25  : EditValor := EditTot025;
      50  : EditValor := EditTot050;
  end;

  EditValor.Text := FloatToStrF(MyStrToFloat(TEdit(Sender).Text)*Razao,
                    ffCurrency, 20, 2);

  // Atualiza o total geral
  TotCashGeral := MyStrToFloat(Edit100.Text)*100;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit50.Text)*50;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit20.Text)*20;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit10.Text)*10;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit5.Text)*5;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit2.Text)*2;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit1.Text);
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit001.Text)*0.01;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit005.Text)*0.05;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit010.Text)*0.1;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit025.Text)*0.25;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit050.Text)*0.5;
  TotCashGeral := TotCashGeral + MyStrToFloat(Edit0100.Text);

  EditTotCash.Text := FloatToStrF(TotCashGeral, ffCurrency, 20, 2);

  // Chama o atualiza geral
  AtuTotCashier;
end;

procedure TCashRegWidraw.AtuTotCashier;
begin
  EditTotCashier.Text := FloatToStrF(TotCashGeral + TotOtherGeral, ffCurrency, 20, 2);
end;

procedure TCashRegWidraw.FormShow(Sender: TObject);
begin
  inherited;
  Edit100.SetFocus;
end;

procedure TCashRegWidraw.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCashRegWidraw.btCloseClick(Sender: TObject);
var
  Envelop : String;
begin
  inherited;
  if TestaPreenchimento(grpBill) and TestaPreenchimento(grpCoin) and
     TestaPreenchimento(pnlOther) and
     (MsgBox(MSG_QST_CONFIRM_DEPOSIT_CASHREG, vbYesNo + vbQuestion) = vbYes) then
  begin
    // Pede o numero do envelope para deposito
    with TCashRegEnvelop.Create(Self) do
      if not Start(Envelop) then Exit;

    DM.fPOS.WithdrawCashRegister(MyIDCashRegMov,
                                 DM.fUser.ID,
                                 MyStrToInt(Edit100.Text),
                                 MyStrToInt(Edit50.Text),
                                 MyStrToInt(Edit20.Text),
                                 MyStrToInt(Edit10.Text),
                                 MyStrToInt(Edit5.Text),
                                 MyStrToInt(Edit2.Text),
                                 MyStrToInt(Edit1.Text),
                                 MyStrToInt(Edit0100.Text),
                                 MyStrToInt(Edit050.Text),
                                 MyStrToInt(Edit025.Text),
                                 MyStrToInt(Edit010.Text),
                                 MyStrToInt(Edit005.Text),
                                 MyStrToInt(Edit001.Text),
                                 TotCashGeral,
                                 MyStrToFloat(cmbTotalCard.Text),
                                 MyStrToFloat(cmbTotalPre.Text),
                                 MyStrToFloat(cmbTotalCheck.Text),
                                 MyStrToFloat(cmbTotalOther.Text),
                                 MyStrToFloat(cmbTotalDebit.Text),
                                 Envelop,
                                 Now,
                                 edtObs.Text,
                                 StrToIntDef(scCashRegLogReason.LookUpValue, 0));

    sEnvelop := Envelop;

    If (DM.fSystem.SrvParam[PARAM_PRINT_DEPOSIT]) then
    begin
      //Print
      PrintDeposit;
    end;

    ModalResult := mrOK;

  end;
end;

function TCashRegWidraw.TestaPreenchimento(MyControl : TControl) : Boolean;
var
  i : integer;
begin
  Result := True;

  if TotCashGeral > MaxDeposit then
  begin
    MsgBox(MSG_INF_CASH_IN_DEPOSIT, vbOKOnly + vbInformation);
    Result := False;
  end;

  Exit;   // Foi colocado a pedido do Lui

  with MyControl do
    for i := 0 to ControlCount -1 do
      if (Controls[i] is TEdit) and TEdit(Controls[i]).TabStop and
         (TEdit(Controls[i]).Text = '') then
      begin
        MsgBox(MSG_INF_COUNT_ITEMS, vbOKOnly + vbInformation);
        TEdit(Controls[i]).SetFocus;
        Result := False;
        Exit;
      end;
end;

procedure TCashRegWidraw.AtuTotOthers(Sender : TObject);
begin
  TotOtherGeral := MyStrToFloat(cmbTotalCard.text)  +
                   MyStrToFloat(cmbTotalPre.text)   +
                   MyStrToFloat(cmbTotalCheck.text) +
                   MyStrToFloat(cmbTotalOther.text) +
                   MyStrToFloat(cmbTotalDebit.text);
  // Chama o atualiza geral
  AtuTotCashier;
end;

procedure TCashRegWidraw.Edit100KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Key := ValidateNumbers(Key);
  
end;

procedure TCashRegWidraw.cmbTotalCardKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F2 then
     begin
       fCall := TEdit(Sender).Tag;
       btnTotalCardClick(Self);
     end;

end;

procedure TCashRegWidraw.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sDeposit    := '   D   E    P     O     S     I     T   ';
           sCashRegNum := 'Cash Register Number : ';
           sEnvNum     := 'Envelop Number       : ';
           sUserName   := 'User Name            : ';
           sTotalCash  := 'Total Cash    : ';
           sTotalCard  := 'Total Card    : ';
           sTotalDebit := 'Total Debit   : ';
           sTotalCardP := 'Total Card Pre: ';
           sTotalCheck := 'Total Check   : ';
           sTotalOther := 'Total Other   : ';
           sTotalCount := 'TOTAL COUNTED : ';
           end;

     LANG_PORTUGUESE :
           begin
           sDeposit    := '   D   E    P   Ó   S   I   T   O       ';
           sCashRegNum := 'N. da Caixa          : ';
           sEnvNum     := 'Número do Envelope   : ';
           sUserName   := 'Usuário              : ';
           sTotalCash  := 'Total Dinheiro  : ';
           sTotalCard  := 'Total Cartão    : ';
           sTotalDebit := 'Total Crt Débito: ';
           sTotalCardP := 'Total Cartão Pre: ';
           sTotalCheck := 'Total Cheque    : ';
           sTotalOther := 'Total Outros    : ';
           sTotalCount := 'TOTAL CONTADO   : ';
           end;

     LANG_SPANISH :
           begin
           sDeposit    := '   D   E    P   O    S   I   T   O  ';
           sCashRegNum := 'N.Caja Registradora  : ';
           sEnvNum     := 'Numero del Sobre     : ';
           sUserName   := 'Usuario              : ';
           sTotalCash  := 'Total Efectivo  : ';
           sTotalCard  := 'Total Tarjeta   : ';
           sTotalDebit := 'Total Trj Débito: ';
           sTotalCardP := 'Total Trjt Fecha: ';
           sTotalCheck := 'Total Cheque    : ';
           sTotalOther := 'Total Otros     : ';
           sTotalCount := 'TOTAL CONTADO   : ';
           end;
   end;

end;

procedure TCashRegWidraw.btnTotalCardClick(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
     begin
     if ShowModal = mrOK then
        begin
        if fCall = -1 then
           fCall := TSpeedButton(Sender).Tag;
        Case fCall of
         1 : cmbTotalCard.Text  := MyFloatToStr(TotGeral);
         2 : cmbTotalPre.Text   := MyFloatToStr(TotGeral);
         3 : cmbTotalCheck.Text := MyFloatToStr(TotGeral);
         4 : cmbTotalOther.Text := MyFloatToStr(TotGeral);
         5 : cmbTotalDebit.Text := MyFloatToStr(TotGeral);
        end;
       fCall := -1;
     end;

     Free;
     end;

end;

end.
