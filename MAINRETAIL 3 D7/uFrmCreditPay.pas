unit uFrmCreditPay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  CheckLst, DB, ADODB;

type
  PCredit = ^TCredit;

  TCredit = record
    IDCustomerCredit,
    IDPessoa,
    IDUser,
    IDStore,
    IDLancamento: Integer;
    CreditDate,
    ExpirationDate: TDateTime;
    Amount: Double;
  end;

  TFrmCreditPay = class(TFrmParentAll)
    clbCredit: TCheckListBox;
    lblTotal: TLabel;
    quGetCredits: TADOQuery;
    Button1: TButton;
    quGetCreditsIDCustomerCredit: TIntegerField;
    quGetCreditsIDPessoa: TIntegerField;
    quGetCreditsIDUser: TIntegerField;
    quGetCreditsIDStore: TIntegerField;
    quGetCreditsCreditDate: TDateTimeField;
    quGetCreditsExpirationDate: TDateTimeField;
    quGetCreditsAmount: TBCDField;
    quGetTotalCredit: TADOQuery;
    quGetTotalCreditTotalCredit: TBCDField;
    quGetCreditsIDLancamento: TIntegerField;
    procedure Button1Click(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure clbCreditClickCheck(Sender: TObject);
  private
    fIDCustomer,
    fIDPreSale  : Integer;
    fCreditDate : TDateTime;
    bOK : Boolean;
    procedure GetCredits;
  public
    function Start(IDCustomer, IDPreSale: Integer; CreditDate: TDateTime;
      var Amount: Double): Boolean;
    procedure UnloadCredit;
    procedure DiscountCredit(ValueToUse: Double);
    function GetTotalCredit(IDCustomer, IDStore, IDPreSale: Integer): Double;
    function GetTotalUsedCredit: Double;
  end;

implementation

uses uDM, uNumericFunctions;

{$R *.dfm}

{ TFrmCreditPay }

function TFrmCreditPay.Start(IDCustomer, IDPreSale: Integer; CreditDate: TDateTime;
  var Amount: Double): Boolean;
begin
  bOK := False;

  fIDCustomer := IDCustomer;
  fIDPreSale  := IDPreSale;
  fCreditDate := CreditDate;

  GetCredits;

  ShowModal;

  Result      :=  bOk;

  if Result then
    Amount := GetTotalUsedCredit
  else
    Amount := 0;
end;

procedure TFrmCreditPay.GetCredits;
var
  ptrCredit : PCredit;
begin
  UnloadCredit;
  with quGetCredits do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDCustomer').Value := fIDCustomer;
    try
      Open;

      while not EOF do
      begin
        New(ptrCredit);
        ptrCredit^.IDCustomerCredit := quGetCreditsIDCustomerCredit.AsInteger;
        ptrCredit^.Amount           := quGetCreditsAmount.Value;
        ptrCredit^.IDPessoa         := quGetCreditsIDPessoa.AsInteger;
        ptrCredit^.IDUser           := quGetCreditsIDUser.AsInteger;
        ptrCredit^.IDStore          := quGetCreditsIDStore.AsInteger;
        ptrCredit^.CreditDate       := quGetCreditsCreditDate.AsDateTime;
        ptrCredit^.ExpirationDate   := quGetCreditsExpirationDate.Value;
        ptrCredit^.IDLancamento     := quGetCreditsIDLancamento.Value;

        clbCredit.AddItem(quGetCreditsAmount.AsString, TObject(ptrCredit));
        Next;
      end;
    finally
      Close;
    end;
  end;
  GetTotalUsedCredit;
end;

function TFrmCreditPay.GetTotalUsedCredit : Double;
var
  I : Integer;
begin
  Result := 0;
  for I := 0 to clbCredit.Items.Count - 1 do
  begin
    if clbCredit.Checked[I] then
      Result := Result + PCredit(LongInt(clbCredit.Items.Objects[I]))^.Amount;
  end;
  lblTotal.Caption := MyFloatToStr(Result);
end;


procedure TFrmCreditPay.Button1Click(Sender: TObject);
begin
  inherited;
  bOk := True;
  Close;
end;

procedure TFrmCreditPay.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCreditPay.clbCreditClickCheck(Sender: TObject);
begin
  inherited;
  GetTotalUsedCredit;
end;

procedure TFrmCreditPay.UnloadCredit;
var
  I : Integer;
  ptrCredit : PCredit;
begin
  for I := 0 to clbCredit.Items.Count - 1 do
  begin
    ptrCredit := PCredit(LongInt(clbCredit.Items.Objects[I]));
    if ptrCredit <> Nil then
    begin
      Dispose(ptrCredit);
      ptrCredit := Nil;
    end;
  end;
  clbCredit.Clear;
end;


procedure TFrmCreditPay.DiscountCredit(ValueToUse: Double);
var
  I : Integer;
  dValue : Double;
  iIDCustomerCredit: Integer;
begin
  dValue := ValueToUse;

  for I := 0 to Pred(clbCredit.Items.Count) do
  begin
    if clbCredit.Checked[I] then
    begin

      dValue := dValue - PCredit(LongInt(clbCredit.Items.Objects[I]))^.Amount;
      DM.RunSQL(Format('UPDATE CustomerCredit SET IsUsed = 1 WHERE IDCustomerCredit = %D', [PCredit(LongInt(clbCredit.Items.Objects[I]))^.IDCustomerCredit]));
      if dValue = 0 then
        Break;

      if dValue < 0 then
        with PCredit(LongInt(clbCredit.Items.Objects[I]))^ do
        begin
          DM.fPOS.AddCustomerCredit(IDPessoa, IDUser, IDStore, IDLancamento, CreditDate, ExpirationDate, ABS(dValue), iIDCustomerCredit);
          Break;
        end;
    end;
  end;

end;

function TFrmCreditPay.GetTotalCredit(IDCustomer, IDStore, IDPreSale: Integer): Double;
begin
  Result := 0;
  with quGetTotalCredit do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDCustomer').Value := IDCustomer;
    Parameters.ParamByName('IDDocument').Value := IDPreSale;
    try
      Open;
      Result := quGetTotalCreditTotalCredit.Value;
    finally
      Close;
    end;
  end;
end;

end.
