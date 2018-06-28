unit uFrmPurchaseCalcFreight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls, DB,
  DBClient, ADODB, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, SuperEdit, SuperEditCurrency, uDMCalcTax;

type
  TFrmPurchaseCalcFreight = class(TFrmParent)
    btnOK: TButton;
    pnlValues: TPanel;
    cdsPurchaseItem: TClientDataSet;
    cdsItemTaxes: TClientDataSet;
    cdsPurchaseItemIDPurchaseItem: TIntegerField;
    cdsPurchaseItemModel: TStringField;
    cdsPurchaseItemDescription: TStringField;
    cdsPurchaseItemCostPrice: TCurrencyField;
    cdsPurchaseItemFreight: TCurrencyField;
    cdsPurchaseItemOtherCost: TCurrencyField;
    cdsPurchaseItemTaxes: TCurrencyField;
    cdsPurchaseItemNewCostPrice: TCurrencyField;
    cdsItemTaxesIDPurchaseItemTax: TIntegerField;
    cdsItemTaxesTaxValue: TCurrencyField;
    cdsItemTaxesDebit: TBooleanField;
    quPurchaseItem: TADODataSet;
    cdsPurchaseItemNewSalePrice: TCurrencyField;
    cdsPurchaseItemNewMSRP: TCurrencyField;
    quPurchaseItemIDPurchaseItem: TIntegerField;
    quPurchaseItemCostPrice: TBCDField;
    quPurchaseItemFreightCost: TBCDField;
    quPurchaseItemOtherCost: TBCDField;
    quPurchaseItemNewCostPrice: TBCDField;
    quPurchaseItemNewSalePrice: TBCDField;
    quPurchaseItemNewSuggRetail: TBCDField;
    quPurchaseItemModel: TStringField;
    quPurchaseItemDescription: TStringField;
    grdPurchaseItem: TcxGrid;
    grdPurchaseItemDB: TcxGridDBTableView;
    grdPurchaseItemLevel: TcxGridLevel;
    dsPurchaseItem: TDataSource;
    grdPurchaseItemDBModel: TcxGridDBColumn;
    grdPurchaseItemDBDescription: TcxGridDBColumn;
    grdPurchaseItemDBCostPrice: TcxGridDBColumn;
    grdPurchaseItemDBFreight: TcxGridDBColumn;
    grdPurchaseItemDBOtherCost: TcxGridDBColumn;
    grdPurchaseItemDBTaxes: TcxGridDBColumn;
    grdPurchaseItemDBNewCostPrice: TcxGridDBColumn;
    grdPurchaseItemDBNewSalePrice: TcxGridDBColumn;
    grdPurchaseItemDBNewMSRP: TcxGridDBColumn;
    quItemTax: TADODataSet;
    quItemTaxIDPurchaseItemTax: TIntegerField;
    quItemTaxTaxValue: TBCDField;
    quItemTaxTaxPercentage: TBCDField;
    quItemTaxTaxCategory: TStringField;
    quItemTaxDebit: TBooleanField;
    quItemTaxFormula: TStringField;
    cdsItemTaxesFormula: TStringField;
    lbFreight: TLabel;
    edtFreight: TSuperEditCurrency;
    lbOtherCost: TLabel;
    edtOtherCost: TSuperEditCurrency;
    btnApply: TBitBtn;
    cdsPurchaseItemQty: TFloatField;
    quPurchaseItemQty: TFloatField;
    cdsItemTaxesIDPurchaseItem: TIntegerField;
    quItemTaxIDTaxCategory: TIntegerField;
    cdsItemTaxesIDTaxCategory: TIntegerField;
    cdsItemTaxesTaxPercentage: TBCDField;
    quItemTaxIDPurchaseItem: TIntegerField;
    cmdUpdatePurchaseItem: TADOCommand;
    cdmItemTax: TADOCommand;
    quPurchaseItemIDModel: TIntegerField;
    quPurchaseItemIDCategory: TIntegerField;
    quPurchaseItemIDSubCategory: TIntegerField;
    quPurchaseItemIDGroup: TIntegerField;
    cdsPurchaseItemIDModel: TIntegerField;
    cdsPurchaseItemIDCategory: TIntegerField;
    cdsPurchaseItemIDSubCategory: TIntegerField;
    cdsPurchaseItemIDGroup: TIntegerField;
    lbDiscount: TLabel;
    edtDiscount: TSuperEditCurrency;
    quPurchaseItemDiscount: TBCDField;
    cdsPurchaseItemDiscount: TCurrencyField;
    grdPurchaseItemDBDiscount: TcxGridDBColumn;
    grdPurchaseItemDBQty: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtFreightKeyPress(Sender: TObject; var Key: Char);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    DMCalcTax : TDMCalcTax;
    FResult : Boolean;
    FIDPurchase : Integer;
    FPurchaseSubTotal : Currency;
    FCalcSalePrice : Boolean;
    procedure ApplyValues;

    procedure OpenPurchaseItem;
    procedure ClosePurchaseItem;
    procedure BuildPurchaseItem;

    procedure OpenItemTax;
    procedure CloseItemTax;
    function GetTotalItemTax(IDPurchaseItem : Integer): Currency;
    function UpdateItemTax(IDItem : Integer; CostPrice, Freight, OtherCost, Discount : Currency) : Currency;

    function CalcNewSalePrice(CostPrice : Currency; IDModel, IDCat, IDSubCat, IDGroup : Integer): Currency;
    function CalcNewMSRP(CostPrice : Currency; IDCat, IDSubCat, IDGroup : Integer): Currency;

    procedure SaveValues;

  public
    function Start(IDPurchase : Integer; PurchaseSubTotal : Currency) : Boolean;
  end;

implementation

uses uDM, uCharFunctions, uNumericFunctions, uSystemConst, uMsgBox, uHandleError;

{$R *.dfm}

{ TFrmPurchaseCalcFreight }

function TFrmPurchaseCalcFreight.Start(IDPurchase : Integer;
   PurchaseSubTotal : Currency): Boolean;
begin
  FResult := False;
  FIDPurchase := IDPurchase;
  FPurchaseSubTotal := PurchaseSubTotal;
  BuildPurchaseItem;
  FCalcSalePrice := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
  ShowModal;
  Result := FResult;
end;

procedure TFrmPurchaseCalcFreight.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ClosePurchaseItem;
  CloseItemTax;
  FreeAndNil(DMCalcTax);
  Action := caFree;
end;

procedure TFrmPurchaseCalcFreight.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPurchaseCalcFreight.btnOKClick(Sender: TObject);
begin
  inherited;
  SaveValues;
  FResult := True;
  Close;
end;

procedure TFrmPurchaseCalcFreight.ClosePurchaseItem;
begin
  with cdsPurchaseItem do
    if Active then
      Close;
end;

procedure TFrmPurchaseCalcFreight.OpenPurchaseItem;
begin
  with cdsPurchaseItem do
    if not Active then
    begin
      CreateDataSet;
      Open;
    end;
end;

procedure TFrmPurchaseCalcFreight.BuildPurchaseItem;
begin
  with quPurchaseItem do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPurchase').Value := FIDPurchase;
    Open;
    if not IsEmpty then
    begin
      OpenPurchaseItem;
      OpenItemTax;
      while not EOF do
      begin
        cdsPurchaseItem.Append;
        cdsPurchaseItem.FieldByName('IDPurchaseItem').AsInteger := FieldByName('IDPurchaseItem').AsInteger;
        cdsPurchaseItem.FieldByName('IDModel').AsInteger        := FieldByName('IDModel').AsInteger;
        cdsPurchaseItem.FieldByName('IDCategory').AsInteger     := FieldByName('IDCategory').AsInteger;
        cdsPurchaseItem.FieldByName('IDSubCategory').AsInteger  := FieldByName('IDSubCategory').AsInteger;
        cdsPurchaseItem.FieldByName('IDGroup').AsInteger        := FieldByName('IDGroup').AsInteger;
        cdsPurchaseItem.FieldByName('Model').AsString           := FieldByName('Model').AsString;
        cdsPurchaseItem.FieldByName('Description').AsString     := FieldByName('Description').AsString;
        cdsPurchaseItem.FieldByName('CostPrice').AsCurrency     := FieldByName('CostPrice').AsCurrency;
        cdsPurchaseItem.FieldByName('Freight').AsCurrency       := FieldByName('FreightCost').AsCurrency;
        cdsPurchaseItem.FieldByName('OtherCost').AsCurrency     := FieldByName('OtherCost').AsCurrency;
        cdsPurchaseItem.FieldByName('Taxes').AsCurrency         := GetTotalItemTax(FieldByName('IDPurchaseItem').AsInteger);
        cdsPurchaseItem.FieldByName('NewCostPrice').AsCurrency  := FieldByName('NewCostPrice').AsCurrency;
        cdsPurchaseItem.FieldByName('NewSalePrice').AsCurrency  := FieldByName('NewSalePrice').AsCurrency;
        cdsPurchaseItem.FieldByName('NewMSRP').AsCurrency       := FieldByName('NewSuggRetail').AsCurrency;
        cdsPurchaseItem.FieldByName('Qty').AsFloat              := FieldByName('Qty').AsFloat;
        cdsPurchaseItem.FieldByName('Discount').AsCurrency      := FieldByName('Discount').AsCurrency;
        cdsPurchaseItem.Post;
        Next;
      end;
    cdsPurchaseItem.First;
    end;

  finally
    Close;
  end;
end;

procedure TFrmPurchaseCalcFreight.CloseItemTax;
begin
  with cdsItemTaxes do
    if Active then
      Close;
end;

function TFrmPurchaseCalcFreight.GetTotalItemTax(IDPurchaseItem: Integer): Currency;
begin

  with quItemTax do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDPurchaseItem').Value := IDPurchaseItem;
    Open;
    Result := 0;
    if not IsEmpty then
      while not EOF do
      begin
        Result := Result + FieldByName('TaxValue').AsCurrency;
        cdsItemTaxes.Append;
        cdsItemTaxes.FieldByName('IDPurchaseItemTax').AsInteger := FieldByName('IDPurchaseItemTax').AsInteger;
        cdsItemTaxes.FieldByName('IDPurchaseItem').AsInteger    := FieldByName('IDPurchaseItem').AsInteger;
        cdsItemTaxes.FieldByName('IDTaxCategory').AsInteger     := FieldByName('IDTaxCategory').AsInteger;
        cdsItemTaxes.FieldByName('TaxPercentage').AsFloat       := FieldByName('TaxPercentage').AsFloat;
        cdsItemTaxes.FieldByName('TaxValue').AsCurrency         := FieldByName('TaxValue').AsCurrency;
        cdsItemTaxes.FieldByName('Debit').AsBoolean             := FieldByName('Debit').AsBoolean;
        cdsItemTaxes.FieldByName('Formula').AsString            := FieldByName('Formula').AsString;
        cdsItemTaxes.Post;
        Next;
      end;
  finally
    Close;
  end;

end;

procedure TFrmPurchaseCalcFreight.OpenItemTax;
begin
  with cdsItemTaxes do
    if not Active then
    begin
      CreateDataSet;
      Open;
    end;
end;

procedure TFrmPurchaseCalcFreight.edtFreightKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmPurchaseCalcFreight.btnApplyClick(Sender: TObject);
begin
  inherited;
  ApplyValues;
end;

procedure TFrmPurchaseCalcFreight.ApplyValues;
var
  Freight,
  ItemFreight   : Currency;
  OtherCost,
  ItemOtherCost : Currency;
  Discount,
  ItemDiscount,
  ItemDiscountTotal : Currency;
  NewCost : Currency;
  NewSale,
  NewMSRP : Currency;
begin

  Freight           := MyStrToMoney(edtFreight.Text);
  OtherCost         := MyStrToMoney(edtOtherCost.Text);
  Discount          := MyStrToMoney(edtDiscount.Text);
  ItemFreight       := 0;
  ItemOtherCost     := 0;
  ItemDiscount      := 0;
  ItemDiscountTotal := 0;

  with cdsPurchaseItem do
  try
    DisableControls;
    First;
    while not EOF do
    begin
      Edit;
      if Freight = 0 then
        FieldByName('Freight').AsCurrency := 0
      else
      begin
        ItemFreight := MyRound(((Freight / FPurchaseSubTotal) * FieldByName('CostPrice').AsCurrency),2);
        FieldByName('Freight').AsCurrency := ItemFreight;
      end;

      if OtherCost = 0 then
        FieldByName('OtherCost').AsCurrency := 0
      else
      begin
        ItemOtherCost := MyRound(((OtherCost / FPurchaseSubTotal) * FieldByName('CostPrice').AsCurrency),2);
        FieldByName('OtherCost').AsCurrency := ItemOtherCost;
      end;

      //Calculo de desconto sobre os items
      if Discount = 0 then
        FieldByName('Discount').AsCurrency := 0
      else
      begin
        ItemDiscount := MyRound(((Discount / FPurchaseSubTotal) * FieldByName('CostPrice').AsCurrency),2);
        ItemDiscountTotal := ItemDiscountTotal + ItemDiscount;
        //Ajustar o ultimo registro arredondando o desconto para bater com desconto total
        if (RecNo = RecordCount) then
          if (ItemDiscountTotal < Discount) then
            ItemDiscount := ItemDiscount + ABS(ItemDiscountTotal - Discount)
          else if (ItemDiscountTotal > Discount) then
            ItemDiscount := ItemDiscount - ABS(ItemDiscountTotal - Discount);

        FieldByName('Discount').AsCurrency := ItemDiscount;
      end;

      FieldByName('Taxes').AsCurrency := UpdateItemTax(FieldByName('IDPurchaseItem').AsInteger,
                                                       FieldByName('CostPrice').AsCurrency,
                                                       ItemFreight,
                                                       ItemOtherCost,
                                                       ItemDiscount);

      NewCost := FieldByName('CostPrice').AsCurrency + ItemFreight + ItemOtherCost + FieldByName('Taxes').AsCurrency - ItemDiscount;

      FieldByName('NewCostPrice').AsCurrency := MyRound(NewCost / FieldByName('Qty').AsFloat, 2);

      if FCalcSalePrice then
      begin
        NewSale := CalcNewSalePrice(FieldByName('NewCostPrice').AsCurrency,
                                    FieldByName('IDModel').AsInteger,
                                    FieldByName('IDCategory').AsInteger,
                                    FieldByName('IDSubCategory').AsInteger,
                                    FieldByName('IDGroup').AsInteger);
        if NewSale <> 0 then
        FieldByName('NewSalePrice').AsCurrency := NewSale;

        NewMSRP := CalcNewMSRP(FieldByName('NewCostPrice').AsCurrency,
                               FieldByName('IDCategory').AsInteger,
                               FieldByName('IDSubCategory').AsInteger,
                               FieldByName('IDGroup').AsInteger);

        if NewMSRP <> 0 then
          FieldByName('NewMSRP').AsCurrency := NewMSRP;
      end;

      Post;
      Next;
    end;
  finally
    First;
    EnableControls;
    end;

end;

function TFrmPurchaseCalcFreight.UpdateItemTax(IDItem : Integer; CostPrice, Freight,
   OtherCost, Discount : Currency): Currency;
var
  i: Integer;
  TaxList: TList;
  ItemTax: TItemTax;
begin
  Result := 0;

  with cdsItemTaxes do
  try
    Filtered := False;
    Filter := 'IDPurchaseItem = ' + IntToStr(IDItem);
    Filtered := True;
    First;
    TaxList := TList.Create;
    while not EOF do
    begin
      ItemTax                   := TItemTax.Create;
      ItemTax.IDPurchaseItemTax := FieldByName('IDPurchaseItemTax').AsInteger;
      ItemTax.IDPurchaseItem    := IDItem;
      ItemTax.TaxPercentage     := FieldByName('TaxPercentage').AsFloat;
      ItemTax.TaxValue          := FieldByName('TaxValue').AsCurrency;
      ItemTax.IDTaxCategory     := FieldByName('IDTaxCategory').AsInteger;
      ItemTax.Debit             := FieldByName('Debit').AsBoolean;
      ItemTax.Formula           := FieldByName('Formula').AsString;
      ItemTax.Cost              := CostPrice;
      ItemTax.Freight           := Freight;
      ItemTax.Other             := OtherCost;
      ItemTax.Discount          := Discount;
      TaxList.Add(ItemTax);
      Next;
    end;

    DMCalcTax.CalculateTaxList(TaxList);

    for i := 0 to Pred(TaxList.Count) do
    begin
      if Locate('IDPurchaseItemTax', TItemTax(TaxList[i]).IDPurchaseItemTax, []) then
      begin
        ItemTax := TItemTax(TaxList[i]);
        Result := Result + ItemTax.TaxValue;
        Edit;
        FieldByName('TaxValue').AsCurrency := MyRound(ItemTax.TaxValue, 2);
        Post;

        FreeAndNil(ItemTax);
      end;
    end;

  finally
    Filtered := False;
    Filter := '';
    TaxList.Clear;
    FreeAndNil(TaxList);
  end;
end;

function TFrmPurchaseCalcFreight.CalcNewMSRP(
  CostPrice: Currency; IDCat, IDSubCat, IDGroup : Integer): Currency;
begin
 Result := DM.FDMCalcPrice.CalcMSRPPrice(IDCat, IDSubCat, IDGroup, CostPrice);
 if Result = CostPrice then
   Result := 0;
end;

function TFrmPurchaseCalcFreight.CalcNewSalePrice(
  CostPrice: Currency; IDModel, IDCat, IDSubCat, IDGroup : Integer): Currency;
begin
 Result := DM.FDMCalcPrice.CalcSalePrice(IDModel, IDCat, IDSubCat, IDGroup, CostPrice);
 if Result = CostPrice then
   Result := 0;
end;

procedure TFrmPurchaseCalcFreight.FormCreate(Sender: TObject);
begin
  inherited;
  DMCalcTax := TDMCalcTax.Create(Self);
  DMCalcTax.ADODBConnect := DM.ADODBConnect;
end;

procedure TFrmPurchaseCalcFreight.FormShow(Sender: TObject);
begin
  inherited;
  grdPurchaseItemDBNewSalePrice.Visible := FCalcSalePrice;
  grdPurchaseItemDBNewMSRP.Visible := FCalcSalePrice;
end;

procedure TFrmPurchaseCalcFreight.SaveValues;
var
  sSQL : String;
begin

  try
    DM.ADODBConnect.BeginTrans;

    with cdsPurchaseItem do
      try
        DisableControls;
        First;
        while not EOF do
        begin
          cmdUpdatePurchaseItem.Parameters.ParamByName('IDPurchaseItem').Value := FieldByName('IDPurchaseItem').AsInteger;
          cmdUpdatePurchaseItem.Parameters.ParamByName('FreightCost').Value := FieldByName('Freight').AsCurrency;
          cmdUpdatePurchaseItem.Parameters.ParamByName('OtherCost').Value := FieldByName('OtherCost').AsCurrency;
          cmdUpdatePurchaseItem.Parameters.ParamByName('NewCostPrice').Value := FieldByName('NewCostPrice').AsCurrency;
          cmdUpdatePurchaseItem.Parameters.ParamByName('Discount').Value := FieldByName('Discount').AsCurrency;
          if FCalcSalePrice then
          begin
            if FieldByName('NewSalePrice').AsCurrency <> 0 then
              cmdUpdatePurchaseItem.Parameters.ParamByName('NewSalePrice').Value := FieldByName('NewSalePrice').AsCurrency;
            if FieldByName('NewMSRP').AsCurrency <> 0 then
              cmdUpdatePurchaseItem.Parameters.ParamByName('NewSuggRetail').Value := FieldByName('NewMSRP').AsCurrency;
          end
          else
          begin
            cmdUpdatePurchaseItem.Parameters.ParamByName('NewSalePrice').Value := NULL;
            cmdUpdatePurchaseItem.Parameters.ParamByName('NewSuggRetail').Value := NULL;
          end;
          cmdUpdatePurchaseItem.Execute;
          Next;
        end;
      finally
        EnableControls;
      end;

    with cdsItemTaxes do
    begin
      First;
      while not EOF do
      begin
        cdmItemTax.Parameters.ParamByName('TaxValue').Value          := FieldByName('TaxValue').AsCurrency;
        cdmItemTax.Parameters.ParamByName('IDPurchaseItemTax').Value := FieldByName('IDPurchaseItemTax').AsCurrency;
        cdmItemTax.Execute;
        Next;
      end;
    end;

    DM.RunSQL('EXEC sp_Purchase_AtuPurchaseSubTotal ' + IntToStr(FIDPurchase) + ', ' + IntToStr(Byte(DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE])));

    DM.ADODBConnect.CommitTrans;

  except
    on E: Exception do
    begin
      DM.ADODBConnect.RollbackTrans;
      DM.SetError(CRITICAL_ERROR, 'TFrmPurchaseCalcFreight.SaveValues', E.Message);
      MsgBox(E.Message, vbCritical + vbOKOnly);
    end;
  end;

end;


end.
