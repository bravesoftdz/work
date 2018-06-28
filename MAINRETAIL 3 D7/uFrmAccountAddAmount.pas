unit uFrmAccountAddAmount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, Mask, DateBox;

const
  TYPE_CREDIT   = 1;
  TYPE_DEBIT    = 2;
  TYPE_CANCEL   = 3;
  TYPE_EXP_DATE = 4;

type
  TFrmAccountAddAmount = class(TFrmParentAll)
    lbOBS: TLabel;
    memOBS: TMemo;
    btnSave: TButton;
    spAccountAddAmount: TADOStoredProc;
    cmdCancelAccount: TADOCommand;
    pnlAmount: TPanel;
    Label2: TLabel;
    edtAmount: TEdit;
    pnlExpDate: TPanel;
    lbExpDate: TLabel;
    dtExp: TDateBox;
    cmdExpDate: TADOCommand;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
  private
    bInserted : Boolean;
    FAccountCard : String;
    FType : Integer;
    FBalance : Currency;
    function ValidateFields:Boolean;
    procedure AddAmount;
  public
    function Start(AccountCard: String; iType : Integer; Balance : Currency):Boolean;
  end;

implementation

uses uDM, uMsgConstant, uDMGlobal, uMsgBox, uCharFunctions, uNumericFunctions;

{$R *.dfm}

procedure TFrmAccountAddAmount.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmAccountAddAmount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmAccountAddAmount.Start(AccountCard: String;
  iType: Integer; Balance : Currency): Boolean;
begin
   FAccountCard       := AccountCard;
   FBalance           := Balance;
   FType              := iType;
   pnlAmount.Visible  := FType in [TYPE_CREDIT, TYPE_DEBIT];
   pnlExpDate.Visible := FType in [TYPE_EXP_DATE];
   dtExp.Date         := Now;
   lbOBS.Visible      := FType <> TYPE_EXP_DATE;
   memOBS.Visible     := lbOBS.Visible;
   bInserted          := False;
   ShowModal;
   Result             := bInserted;
end;

procedure TFrmAccountAddAmount.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateFields then
  begin
     AddAmount;
     Close;
  end;

end;

function TFrmAccountAddAmount.ValidateFields: Boolean;
begin

   Result := False;

   if FType = TYPE_CREDIT then
     if MyStrToMoney(edtAmount.Text) <= 0 then
     begin
       MsgBox(MSG_CRT_NO_AMOUNT_ZERO, vbCritical + vbOkOnly);
       edtAmount.SetFocus;
       Exit;
     end;

   if FType = TYPE_DEBIT then
   begin
     if MyStrToMoney(edtAmount.Text) <= 0 then
     begin
       MsgBox(MSG_CRT_NO_AMOUNT_ZERO, vbCritical + vbOkOnly);
       edtAmount.SetFocus;
       Exit;
     end;

     if (FBalance - MyStrToMoney(edtAmount.Text)) <= 0 then
     begin
       MsgBox(MSG_CRT_NO_AMOUNT_ZERO, vbCritical + vbOkOnly);
       edtAmount.SetFocus;
       Exit;
     end;
   end;

   if (FType <> TYPE_EXP_DATE) and (Trim(memOBS.Text) = '') then
   begin
     MsgBox(MSG_CRT_NO_EMPTY_REASON, vbCritical + vbOkOnly);
     memOBS.SetFocus;
     Exit;
   end;
   
   Result := True;

end;

procedure TFrmAccountAddAmount.AddAmount;
var
 Credit : Boolean;
 Amount : Currency;
begin

  case FType of
  TYPE_CREDIT : begin
                Credit := True;
                Amount := MyStrToMoney(edtAmount.Text);
                end;
  TYPE_DEBIT  : begin
                Credit := False;
                Amount := MyStrToMoney(edtAmount.Text);
                end;
  TYPE_CANCEL : begin
                Credit := False;
                Amount := FBalance;
                end;
  end;


  try
    if FType in [TYPE_CREDIT, TYPE_DEBIT, TYPE_CANCEL] then
    begin
      DM.ADODBConnect.BeginTrans;
      try
        with spAccountAddAmount do
        begin
          Parameters.ParamByName('@CardNumber').Value   := FAccountCard;
          Parameters.ParamByName('@Amount').Value       := Amount;
          Parameters.ParamByName('@IDPreSale').Value    := NULL;
          Parameters.ParamByName('@IDLancamento').Value := NULL;
          Parameters.ParamByName('@IDUser').Value       := DM.fUser.ID;
          Parameters.ParamByName('@Credit').Value       := Credit;
          Parameters.ParamByName('@OBS').Value          := memOBS.Text;
          ExecProc;
        end;
        DM.ADODBConnect.CommitTrans;
      except
        DM.ADODBConnect.RollbackTrans;
        end;
    end;

    if FType = TYPE_CANCEL then
    with cmdCancelAccount do
      begin
      Parameters.ParamByName('CardNumber').Value := FAccountCard;
      Parameters.ParamByName('Canceled').Value   := True;
      Execute;
      end;

    if FType = TYPE_EXP_DATE then
    with cmdExpDate do
      begin
      Parameters.ParamByName('CardNumber').Value     := FAccountCard;
      if dtExp.Text <> '' then
        Parameters.ParamByName('ExpirationDate').Value := dtExp.Date
      else
        Parameters.ParamByName('ExpirationDate').Value := NULL;
      Execute;
      end;

   bInserted := True;

  except
    raise;
    bInserted := False;
    end;

end;

procedure TFrmAccountAddAmount.edtAmountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

end.
