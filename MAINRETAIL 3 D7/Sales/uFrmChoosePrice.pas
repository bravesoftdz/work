unit uFrmChoosePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB;

type
  TChoosedPrice = class
    IDVendor: Integer;
    IDDescriptionPrice: Integer;
    CostPrice: Currency;
    SuggPrice: Currency;
    SalePrice: Currency;
  end;

  TFrmChoosePrice = class(TFrmParent)
    grdPriceTable: TcxGrid;
    grdPriceTableDBTableView: TcxGridDBTableView;
    grdPriceTableLevel: TcxGridLevel;
    qryModelPrice: TADOQuery;
    qryModelPriceIDDescriptionPrice: TIntegerField;
    qryModelPriceIDVendor: TIntegerField;
    qryModelPriceCostPrice: TBCDField;
    qryModelPriceSuggPrice: TBCDField;
    qryModelPriceSalePrice: TBCDField;
    dsPriceTable: TDataSource;
    qryModelPriceDescriptionPrice: TStringField;
    qryModelPriceVendor: TStringField;
    grdPriceTableDBTableViewCostPrice: TcxGridDBColumn;
    grdPriceTableDBTableViewSuggPrice: TcxGridDBColumn;
    grdPriceTableDBTableViewSalePrice: TcxGridDBColumn;
    grdPriceTableDBTableViewDescriptionPrice: TcxGridDBColumn;
    grdPriceTableDBTableViewVendor: TcxGridDBColumn;
    qryStorePrice: TADOQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    BCDField3: TBCDField;
    StringField1: TStringField;
    StringField2: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdPriceTableDBTableViewDblClick(Sender: TObject);
  private
    FChoosedPrice: TChoosedPrice;
    FIDStore: Integer;
    FIDModel: Integer;

    procedure ClosePriceTableDS;
    procedure OpenPriceTableDS;
    procedure SetChoosedPrice;
  public
    function ChoosePrice(AIDStore, AIDModel: Integer): TChoosedPrice;
  end;

implementation

uses uDM;

{$R *.dfm}

{ TFrmChoosePrice }

function TFrmChoosePrice.ChoosePrice(AIDStore, AIDModel: Integer): TChoosedPrice;
begin
  FIDStore := AIDStore;
  FIDModel := AIDModel;

  OpenPriceTableDS;

  ShowModal;

  SetChoosedPrice;
  ClosePriceTableDS;

  Result := FChoosedPrice;
end;

procedure TFrmChoosePrice.ClosePriceTableDS;
begin
  qryStorePrice.Close;
  qryModelPrice.Close;
end;

procedure TFrmChoosePrice.FormCreate(Sender: TObject);
begin
  inherited;
  FChoosedPrice := TChoosedPrice.Create;
end;

procedure TFrmChoosePrice.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FChoosedPrice);
end;

procedure TFrmChoosePrice.OpenPriceTableDS;
begin
  with qryStorePrice do
  begin
    if Active then
      Close;

    Parameters.ParamByName('IDStore').Value := FIDStore;
    Parameters.ParamByName('IDModel').Value := FIDModel;
    Open;
  end;

  if qryStorePrice.IsEmpty then
  begin
    with qryModelPrice do
    begin
      if Active then
        Close;

      Parameters.ParamByName('IDModel').Value := FIDModel;
      Open;
    end;
    dsPriceTable.DataSet := qryModelPrice;
  end
  else
    dsPriceTable.DataSet := qryStorePrice;
end;

procedure TFrmChoosePrice.SetChoosedPrice;
begin
  FChoosedPrice.IDVendor           := dsPriceTable.DataSet.FieldByName('IDVendor').AsInteger;
  FChoosedPrice.IDDescriptionPrice := dsPriceTable.DataSet.FieldByName('IDDescriptionPrice').AsInteger;
  FChoosedPrice.CostPrice          := dsPriceTable.DataSet.FieldByName('CostPrice').AsCurrency;
  FChoosedPrice.SuggPrice          := dsPriceTable.DataSet.FieldByName('SuggPrice').AsCurrency;
  FChoosedPrice.SalePrice          := dsPriceTable.DataSet.FieldByName('SalePrice').AsCurrency;
end;

procedure TFrmChoosePrice.grdPriceTableDBTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

end.
