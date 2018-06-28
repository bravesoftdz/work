unit uFrmAccountCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ADODB, DateBox, Mask, SuperComboADO;

type
  TFrmAccountCard = class(TFrmParent)
    Panel4: TPanel;
    pnlButtons: TPanel;
    btPOGroup: TSpeedButton;
    btPOColumn: TSpeedButton;
    grdAccountCard: TcxGrid;
    grdAccountCardDB: TcxGridDBTableView;
    grdAccountCardLevel: TcxGridLevel;
    gridAccountMov: TcxGrid;
    gridAccountMovDB: TcxGridDBTableView;
    gridAccountMovLevel: TcxGridLevel;
    pnlTitle2: TPanel;
    Panel5: TPanel;
    quAccounts: TADODataSet;
    dsAccount: TDataSource;
    grdAccountCardDBCardNumber: TcxGridDBColumn;
    grdAccountCardDBCardDate: TcxGridDBColumn;
    grdAccountCardDBExpirationDate: TcxGridDBColumn;
    grdAccountCardDBTotalAmount: TcxGridDBColumn;
    grdAccountCardDBSystemUser: TcxGridDBColumn;
    btSearch: TBitBtn;
    SpeedButton1: TSpeedButton;
    quAccountMov: TADODataSet;
    dsAccountMov: TDataSource;
    lbUser: TLabel;
    scUser: TSuperComboADO;
    btnAllUser: TButton;
    lbSales: TLabel;
    dtCardDate: TDateBox;
    edtCardNumber: TEdit;
    Label1: TLabel;
    quAccountMovDateMov: TDateTimeField;
    quAccountMovValue: TBCDField;
    quAccountMovCredit: TBooleanField;
    quAccountMovSystemUser: TStringField;
    quAccountMovIDAccountCardMov: TIntegerField;
    gridAccountMovDBDateMov: TcxGridDBColumn;
    gridAccountMovDBValue: TcxGridDBColumn;
    gridAccountMovDBCredit: TcxGridDBColumn;
    gridAccountMovDBSystemUser: TcxGridDBColumn;
    quAccountMovObs: TStringField;
    gridAccountMovDBObs: TcxGridDBColumn;
    btnExpDate: TSpeedButton;
    quAccountMovSaleCode: TStringField;
    gridAccountMovDBSaleCode: TcxGridDBColumn;
    quAccountsIDAccountCard: TIntegerField;
    quAccountsCardNumber: TStringField;
    quAccountsCardDate: TWideStringField;
    quAccountsExpirationDate: TWideStringField;
    quAccountsTotalAmount: TBCDField;
    quAccountsSystemUser: TStringField;
    procedure btSearchClick(Sender: TObject);
    procedure quAccountsAfterOpen(DataSet: TDataSet);
    procedure dsAccountDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnAllUserClick(Sender: TObject);
    procedure btPOGroupClick(Sender: TObject);
    procedure btPOColumnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnExpDateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FSaveOriginalSQL: String;
    procedure OpenAccount;
    procedure CloseAccount;
    procedure RefreshAccount;

    procedure OpenAccountMov;
    procedure CloseAccountMov;
    procedure RefreshAccountMov;

  public
    function Start:Boolean;
  end;

implementation

uses uDM, uDMGlobal, uFrmAccountAddAmount;

{$R *.dfm}

{ TFrmAccountCard }

procedure TFrmAccountCard.CloseAccount;
begin
  with quAccounts do
    if Active then
      Close;
end;

procedure TFrmAccountCard.OpenAccount;
begin
    //amfsouza 12.02.2011
    quAccounts.CommandText := FSaveOriginalSQL;
    quAccounts.Close;

    if not quAccounts.Active then
    begin

      if scUser.LookUpValue <> '' then begin
        quAccounts.commandText := quAccounts.commandText + ' and ac.Iduser =:IdUser';
        quAccounts.Parameters.ParamByName('IDUser').Value := scUser.LookUpValue
      end;


      if dtCardDate.Text <> '' then begin
        quAccounts.CommandText := quAccounts.commandText + ' and ( (ac.CardDate >= :d1) and (ac.CardDate <= :d2) )';
        quAccounts.Parameters.ParamByName('d1').Value := trunc(dtCardDate.Date);
        quAccounts.Parameters.ParamByName('d2').Value := ( trunc(dtCardDate.Date) + 1 );
      end;

      if edtCardNumber.Text <> '' then begin
        quAccounts.commandText := quAccounts.commandText + ' and ac.CardNumber like :CardNumber';
        quAccounts.Parameters.ParamByName('CardNumber').Value := edtCardNumber.Text + '%';
      end;

      quAccounts.Open;
    end;
end;

procedure TFrmAccountCard.RefreshAccount;
begin
   CloseAccount;
   OpenAccount;
end;

function TFrmAccountCard.Start: Boolean;
begin
  FSaveOriginalSQL := quAccounts.CommandText;
  RefreshAccount;
  ShowModal;
end;

procedure TFrmAccountCard.btSearchClick(Sender: TObject);
begin
  inherited;
  RefreshAccount;
end;

procedure TFrmAccountCard.CloseAccountMov;
begin
  with quAccountMov do
    if Active then
      Close;
end;

procedure TFrmAccountCard.OpenAccountMov;
begin
  with quAccountMov do
    if not Active then
    begin
      Parameters.ParamByName('IDAccountCard').Value := quAccountsIDAccountCard.AsInteger;
      Open;
    end;

end;

procedure TFrmAccountCard.RefreshAccountMov;
begin
  CloseAccountMov;
  OpenAccountMov;
end;

procedure TFrmAccountCard.quAccountsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshAccountMov;
end;

procedure TFrmAccountCard.dsAccountDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  RefreshAccountMov;
end;

procedure TFrmAccountCard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseAccountMov;
  CloseAccount;
  Action := caFree;
end;

procedure TFrmAccountCard.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmAccountCard.btnAllUserClick(Sender: TObject);
begin
  inherited;
  scUser.LookUpValue := '';
  scUser.Text := '<-->';
end;

procedure TFrmAccountCard.btPOGroupClick(Sender: TObject);
begin
  inherited;
  if quAccounts.Active and (not quAccounts.IsEmpty) then
    with TFrmAccountAddAmount.Create(Self) do
      if Start(quAccountsCardNumber.AsString, TYPE_CANCEL, quAccountsTotalAmount.AsCurrency) then
        RefreshAccount;
end;

procedure TFrmAccountCard.btPOColumnClick(Sender: TObject);
begin
  inherited;

  if quAccounts.Active and (not quAccounts.IsEmpty) then
    with TFrmAccountAddAmount.Create(Self) do
      if Start(quAccountsCardNumber.AsString, TYPE_CREDIT, quAccountsTotalAmount.AsCurrency) then
        RefreshAccount;

end;

procedure TFrmAccountCard.SpeedButton1Click(Sender: TObject);
begin
  inherited;

  if quAccounts.Active and (not quAccounts.IsEmpty) then
    with TFrmAccountAddAmount.Create(Self) do
      if Start(quAccountsCardNumber.AsString, TYPE_DEBIT, quAccountsTotalAmount.AsCurrency) then
        RefreshAccount;

end;

procedure TFrmAccountCard.btnExpDateClick(Sender: TObject);
begin
  inherited;

  if quAccounts.Active and (not quAccounts.IsEmpty) then
    with TFrmAccountAddAmount.Create(Self) do
      if Start(quAccountsCardNumber.AsString, TYPE_EXP_DATE, quAccountsTotalAmount.AsCurrency) then
        RefreshAccount;

end;

procedure TFrmAccountCard.FormShow(Sender: TObject);
begin
  inherited;
  edtCardNumber.SetFocus;
end;

procedure TFrmAccountCard.FormCreate(Sender: TObject);
begin
  inherited;
  caption := 'Gift Cards';
end;

end.
