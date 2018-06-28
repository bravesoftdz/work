unit uFinTaxComper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  SuperComboADO, Mask, DateBox, Db, ADODB, CheckLst, dxDBTLCl, dxGrClms,
  dxTL, dxDBCtrl, dxDBGrid, dxCntner;

type
  TFinTaxComper = class(TParentDialogFrm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    pnlBasicFilter: TPanel;
    Label2: TLabel;
    pnlExecuta: TPanel;
    pnlExecutaAviso: TPanel;
    btExecuta: TButton;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    Label3: TLabel;
    scStore: TSuperComboADO;
    btTodasPessoas: TButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkSaleTax: TCheckListBox;
    chkPurchase: TCheckListBox;
    quPurchaseTax: TADODataSet;
    quPurchaseTaxIDTaxCategory: TIntegerField;
    quPurchaseTaxTaxCategory: TStringField;
    quSaleTax: TADODataSet;
    quSaleTaxIDTaxCategory: TIntegerField;
    quSaleTaxTaxCategory: TStringField;
    quSaleTaxValue: TADODataSet;
    quSaleTaxValueInvoiceCode: TStringField;
    quSaleTaxValueInvoiceDate: TDateTimeField;
    quSaleTaxValueSubTotal: TBCDField;
    quSaleTaxValueItemDiscount: TBCDField;
    quSaleTaxValueAditionalExpenses: TBCDField;
    quSaleTaxValueTaxValue: TBCDField;
    grdSale: TdxDBGrid;
    dsSaleTaxValue: TDataSource;
    quSaleTaxValueIDPreSale: TIntegerField;
    grdSaleInvoiceCode: TdxDBGridMaskColumn;
    grdSaleInvoiceDate: TdxDBGridDateColumn;
    grdSaleSubTotal: TdxDBGridCurrencyColumn;
    grdSaleItemDiscount: TdxDBGridCurrencyColumn;
    grdSaleAditionalExpenses: TdxDBGridCurrencyColumn;
    grdSaleTaxValue: TdxDBGridCurrencyColumn;
    grdSaleIDPreSale: TdxDBGridMaskColumn;
    quSaleTaxValueIDInventoryMov: TIntegerField;
    quSaleTaxValueModel: TStringField;
    quSaleTaxValueDescription: TStringField;
    grdSaleModel: TdxDBGridMaskColumn;
    grdSaleDescription: TdxDBGridMaskColumn;
    dsPurTaxValue: TDataSource;
    quPurTaxValue: TADODataSet;
    grdPurchase: TdxDBGrid;
    quPurTaxValueIDPurchaseItemTax: TIntegerField;
    quPurTaxValueDateFinalreceiving: TDateTimeField;
    quPurTaxValueDocumentTotal: TBCDField;
    quPurTaxValueDocumentNumber: TStringField;
    quPurTaxValueModel: TStringField;
    quPurTaxValueDescription: TStringField;
    quPurTaxValueTaxValue: TBCDField;
    grdPurchaseIDPurchaseItemTax: TdxDBGridMaskColumn;
    grdPurchaseDateFinalreceiving: TdxDBGridDateColumn;
    grdPurchaseDocumentTotal: TdxDBGridCurrencyColumn;
    grdPurchaseDocumentNumber: TdxDBGridMaskColumn;
    grdPurchaseModel: TdxDBGridMaskColumn;
    grdPurchaseDescription: TdxDBGridMaskColumn;
    grdPurchaseTaxValue: TdxDBGridCurrencyColumn;
    Label6: TLabel;
    lbTotal: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    quPurTaxValueVendor: TStringField;
    grdPurchaseVendor: TdxDBGridColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btTodasPessoasClick(Sender: TObject);
    procedure btExecutaClick(Sender: TObject);
  private
    sPurTax,
    sSaleTax : String;

    procedure OpenSaleTax;
    procedure CloseSaleTax;

    procedure OpenPurchaseTax;
    procedure ClosePurchaseTax;

    procedure FillSaleTax;
    procedure FillPurchaseTax;

    procedure OpenSaleTaxValue;
    procedure CloseSaleTaxValue;
    procedure RefreshSaleTaxValue;

    procedure OpenPurchaseTaxValue;
    procedure ClosePurchaseTaxValue;
    procedure RefreshPurchaseTaxValue;


    function GetSelectedSaleTax:String;
    function GetSelectedPurchaseTax:String;
  public
    function Start:Boolean;
  end;

implementation

uses uDM, uDateTimeFunctions, uSQLFunctions;

{$R *.DFM}

function TFinTaxComper.Start: Boolean;
begin

   dbInicio.Date := InicioMes(Date());
   dbFim.Date    := FimMes(Date());

   OpenPurchaseTax;
   OpenSaleTax;

   FillSaleTax;
   FillPurchaseTax;

   Result := (ShowModal=mrOK);

   ClosePurchaseTax;
   CloseSaleTax;

   CloseSaleTaxValue;
end;

procedure TFinTaxComper.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFinTaxComper.FillPurchaseTax;
begin
  chkPurchase.Items.Clear;
  with quPurchaseTax do
    begin
    First;
    while not EOF do
      begin
      chkPurchase.Items.Add(quPurchaseTaxTaxCategory.AsString);
      Next;
      end;
    end;
end;

procedure TFinTaxComper.FillSaleTax;
begin
  chkSaleTax.Items.Clear;
  with quSaleTax do
    begin
    First;
    while not EOF do
      begin
      chkSaleTax.Items.Add(quSaleTaxTaxCategory.AsString);
      Next;
      end;
    end;
end;

procedure TFinTaxComper.ClosePurchaseTax;
begin
   with quPurchaseTax do
     if Active then
        Close;
end;

procedure TFinTaxComper.CloseSaleTax;
begin
  with quSaleTax do
    if Active then
       Close;
end;

procedure TFinTaxComper.OpenPurchaseTax;
begin
  with quPurchaseTax do
    if not Active then
       Open;
end;

procedure TFinTaxComper.OpenSaleTax;
begin
  with quSaleTax do
    if not Active then
       Open;
end;

procedure TFinTaxComper.btTodasPessoasClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '';
end;

function TFinTaxComper.GetSelectedPurchaseTax: String;
var
  i : integer;
begin
  Result := '';
  for i:=0 to chkPurchase.Items.Count-1 do
    if chkPurchase.Checked[i] then
       if quPurchaseTax.Locate('TaxCategory', chkPurchase.Items.Strings[i],[]) then
          begin
          if Result <> '' then
             Result := Result + ', ';
          Result := Result + quPurchaseTaxIDTaxCategory.AsString;
          end;
end;

function TFinTaxComper.GetSelectedSaleTax: String;
var
  i : integer;
begin
  Result := '';
  for i:=0 to chkSaleTax.Items.Count-1 do
    if chkSaleTax.Checked[i] then
       if quSaleTax.Locate('TaxCategory', chkSaleTax.Items.Strings[i],[]) then
          begin
          if Result <> '' then
             Result := Result + ', ';
          Result := Result + quSaleTaxIDTaxCategory.AsString;
          end;
end;

procedure TFinTaxComper.btExecutaClick(Sender: TObject);
begin
  inherited;
  sPurTax  := GetSelectedPurchaseTax;
  sSaleTax := GetSelectedSaleTax;

  try

    Screen.Cursor := crHourglass;

    if sSaleTax <> '' then
       RefreshSaleTaxValue;

    if sPurTax <> '' then
       RefreshPurchaseTaxValue;

     lbTotal.Caption := FormatFloat('#,##0.00', ((grdSaleTaxValue.SummaryFooterValue + grdPurchaseTaxValue.SummaryFooterValue)*-1));

  finally
    Screen.Cursor := crDefault;
    end;

end;

procedure TFinTaxComper.CloseSaleTaxValue;
begin
   with quSaleTaxValue do
      if Active then
         Close;
end;

procedure TFinTaxComper.OpenSaleTaxValue;
var
 sWhere : String;
begin

   sWhere := 'T.IDTaxCategory in ('+sSaleTax+') ' +
            ' AND I.InvoiceDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dbInicio.Date)) +
            ' AND I.InvoiceDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dbFim.Date+1));

   if scStore.LookUpValue <> '' then
      sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

   with quSaleTaxValue do
      if not Active then
         begin
         CommandText := ChangeWhereClause(CommandText,sWhere,True);
         Open;
         end;
end;

procedure TFinTaxComper.RefreshSaleTaxValue;
begin
  CloseSaleTaxValue;
  OpenSaleTaxValue;
end;

procedure TFinTaxComper.ClosePurchaseTaxValue;
begin
   with quPurTaxValue do
      if Active then
         Close;
end;

procedure TFinTaxComper.OpenPurchaseTaxValue;
var
 sWhere : String;
begin

   sWhere := 'VT.IDTaxCategory in ('+sPurTax+') ' +
             ' AND P.DatePreReceiving >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dbInicio.Date)) +
             ' AND P.DatePreReceiving < ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dbFim.Date+1));

   if scStore.LookUpValue <> '' then
      sWhere := sWhere + ' AND P.IDStore = ' + scStore.LookUpValue;

   with quPurTaxValue do
      if not Active then
         begin
         CommandText := ChangeWhereClause(CommandText,sWhere,True);
         Open;
         end;
end;

procedure TFinTaxComper.RefreshPurchaseTaxValue;
begin
   ClosePurchaseTaxValue;
   OpenPurchaseTaxValue;
end;

end.
