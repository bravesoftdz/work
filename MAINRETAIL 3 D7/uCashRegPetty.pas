unit uCashRegPetty;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, Mask, LblEffct, ExtCtrls, DBCtrls, DB, DBTables,
  ADODB, siComp, siLangRT, uSystemConst, SuperComboADO;

const
   OP_PETTY_CASH = 0;
   OP_ADD_CASH   = 1;

type
  TCashRegPetty = class(TFrmParent)
    btCancel: TButton;
    Label7: TLabel;
    EditTotPetty: TEdit;
    edtOBS: TEdit;
    lblOBS: TLabel;
    scCashRegLogReason: TSuperComboADO;
    lblReason: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    sPettyCash,
    sAddCash    : String;

    FOptionType : Integer;
    TotCashGeral, TotOtherGeral  : Double;
    MyIDOpenUser, MyIDCashRegMov : integer;
    TotSaleCash : Double;
    MaxPetty    : Double;
    procedure ExecPettyCash;
    procedure ExecAddCash;
  public
    function Start(IDCashRegMov : integer; OptionType : integer) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uNumericFunctions, uDMGlobal,
  uPrintCashReg;

{$R *.DFM}

function TCashRegPetty.Start(IDCashRegMov, OptionType : integer) : Boolean;
begin
  // Calcula o totsalecash e CashRegMovID
  FOptionType := OptionType;
  MaxPetty := DM.fPOS.GetTotalCashReceived(IDCashRegMov) - DM.fSystem.SrvParam[PARAM_CASHREGRESTANT];
  MyIDCashRegMov := IDCashRegMov;
  scCashRegLogReason.ShowBtnUpdate := (DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);
  scCashRegLogReason.ShowBtnAddNew := (DM.fUser.IDUserType in [USER_TYPE_ADMINISTRATOR, USER_TYPE_MANAGER]);
  Result := (ShowModal = mrOK);
end;

procedure TCashRegPetty.FormShow(Sender: TObject);
begin
  inherited;
  EditTotPetty.SetFocus;

  if FOptionType = OP_PETTY_CASH then
    Label7.Caption := sPettyCash
  else
    Label7.Caption := sAddCash;
end;

procedure TCashRegPetty.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCashRegPetty.btCloseClick(Sender: TObject);
begin
  inherited;

  if FOptionType = OP_PETTY_CASH then
    ExecPettyCash
  else
    ExecAddCash;

end;

procedure TCashRegPetty.ExecAddCash;
var
  iIDCashRegLog: Integer;
begin

  if (MsgBox(MSG_QST_CONFIRM_PETTY_CASH, vbYesNo + vbQuestion) = vbYes) then
  begin
    // Open CashRegister
    DM.OpenCashRegister(DRAW_KICK_TYPO_PETTY_CASH);

    DM.fPOS.AddCash(MyIDCashRegMov, DM.fUser.ID,
                         MyStrToMoney(EditTotPetty.Text),
                         Now,
                         StrToIntDef(scCashRegLogReason.LookUpValue, 0),
                         edtOBS.Text,
                         iIDCashRegLog);

    if DM.fPrintReceipt.PrintReceipt then
      with TPrintCashReg.Create(Self) do
      try
        Start(iIDCashRegLog, TICKET_CASH_ADD);
      finally
        Free;
      end;

    ModalResult := mrOK;
  end;


end;

procedure TCashRegPetty.ExecPettyCash;
var
  iIDCashRegLog: Integer;
begin
  if MyRound(MyStrToMoney(EditTotPetty.Text), 2) > MyRound(MaxPetty, 2) then
  begin
    if MsgBox(MSG_INF_PART_PETTYCASH_MAX + FloatToStrF(MaxPetty, ffCurrency, 20, 2) +
              '. ' + MSG_QST_CONTINUE, vbYesNo + vbQuestion) = vbNo then
      exit;
  end;

  if (MsgBox(MSG_QST_CONFIRM_PETTY_CASH, vbYesNo + vbQuestion) = vbYes) then
  begin
    // Open CashRegister
    DM.OpenCashRegister(DRAW_KICK_TYPO_PETTY_CASH);

    DM.fPOS.AddPettyCash(MyIDCashRegMov, DM.fUser.ID,
                         MyStrToMoney(EditTotPetty.Text),
                         Now,
                         StrToIntDef(scCashRegLogReason.LookUpValue, 0),
                         edtOBS.Text,
                         iIDCashRegLog);

    if DM.fPrintReceipt.PrintReceipt then
      with TPrintCashReg.Create(Self) do
      try
        Start(iIDCashRegLog, TICKET_CASH_PETTY);
      finally
        Free;
      end;

    ModalResult := mrOK;
  end;

end;

procedure TCashRegPetty.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sPettyCash  := 'Total Petty Cash : ';
      sAddCash    := 'Total Pay In : ';
    end;

    LANG_PORTUGUESE :
    begin
      sPettyCash  := 'Total da Retirada :';
      sAddCash    := 'Total do Suprimento:';
    end;

    LANG_SPANISH :
    begin
      sPettyCash  := 'Total Retirada :';
      sAddCash    := 'Total Caja Chica :';
    end;
  end;

end;

end.
