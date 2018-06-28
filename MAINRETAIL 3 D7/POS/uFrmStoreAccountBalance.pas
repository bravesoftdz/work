unit uFrmStoreAccountBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, StdCtrls, ExtCtrls, DB, ADODB;

type
  TFrmStoreAccountBalance = class(TFrmParentAll)
    pnlOK: TPanel;
    Panel9: TPanel;
    Panel3: TPanel;
    btOK: TButton;
    TimerStoreAcc: TTimer;
    lbInfo: TLabel;
    quAccLimit: TADODataSet;
    quStoreAccBalance: TADODataSet;
    quAccLimitStoreAccountLimit: TBCDField;
    quStoreAccBalanceAmount: TBCDField;
    btnChageUser: TButton;
    cmdInsertStoreAcc: TADOCommand;
    procedure btOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerStoreAccTimer(Sender: TObject);
    procedure btnChageUserClick(Sender: TObject);
  private
    FIDCustomer : Integer;
    FTotalSale  : Currency;
    FResult     : Boolean;
    function SaveTempTransaction : Boolean;
  public
    function Start(AIDCustomer : Integer; ATotalSale : Currency) : Boolean;
  end;

implementation

uses uDM, uPassword;

{$R *.dfm}

{ TFrmStoreAccountBalance }

function TFrmStoreAccountBalance.Start(AIDCustomer: Integer;
  ATotalSale: Currency): Boolean;
begin
  FIDCustomer := AIDCustomer;
  FTotalSale  := ATotalSale;
  TimerStoreAcc.Enabled := True;
  FResult := False;
  ShowModal;
  Result := FResult;
end;

procedure TFrmStoreAccountBalance.btOKClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmStoreAccountBalance.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmStoreAccountBalance.TimerStoreAccTimer(Sender: TObject);
var
  cCustomerLimite, cAccBalance : Currency;
begin
  inherited;
  TimerStoreAcc.Enabled := False;
  try

    with quAccLimit do
      try
        if Active then
          Close;
        Parameters.ParamByName('IDPessoa').Value := FIDCustomer;
        Open;
        cCustomerLimite := quAccLimitStoreAccountLimit.AsCurrency;
      finally
        Close;
      end;

    with quStoreAccBalance do
      try
        if Active then
          Close;
        Parameters.ParamByName('IDPessoa').Value := FIDCustomer;
        Open;
        cAccBalance := quStoreAccBalanceAmount.AsCurrency;
      finally
        Close;
      end;

    FResult := cCustomerLimite > (cAccBalance + FTotalSale);

    if FResult then
    begin
      FResult := SaveTempTransaction;
      if FResult then
        Close
    end
    else
    begin
      lbInfo.Caption := 'Valor excedeu o limite do cliente!';
      Application.ProcessMessages;
      pnlOK.Visible := True;
    end;

  except
    lbInfo.Caption := 'Não foi possível consultar o saldo do cliente!';
    Application.ProcessMessages;
    pnlOK.Visible := True;
  end;
  
end;

procedure TFrmStoreAccountBalance.btnChageUserClick(Sender: TObject);
var
  IDUserAuth: Integer;
begin
  inherited;

  if Password.AquireAccess(89, 'Usuário não tem permissão liberar limite!_Ativar função 89 do Tipo de Usuário.', IDUserAuth) then
  begin
    FResult := SaveTempTransaction;
    if FResult then
      Close;
  end;

end;

function TFrmStoreAccountBalance.SaveTempTransaction: Boolean;
begin

  Result := True;

  if DM.PersistenceType = ptTXT then
  try
    with cmdInsertStoreAcc do
    begin
      Parameters.ParamByName('IDStoreAccount').Value  := DM.GetNextID('Sal_StoreAccount.IDStoreAccount');
      Parameters.ParamByName('IDPessoa').Value        := FIDCustomer;
      Parameters.ParamByName('IDUser').Value          := DM.fUser.ID;
      Parameters.ParamByName('IDStore').Value         := DM.fStore.ID;
      Parameters.ParamByName('TransactionDate').Value := Now;
      Parameters.ParamByName('Amount').Value          := FTotalSale;
      Execute;
    end;
  except
    Result := False;
  end;
end;

end.
