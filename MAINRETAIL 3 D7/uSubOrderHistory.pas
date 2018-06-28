unit uSubOrderHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, Grids, DBGrids,
  SMDBGrid;

type
  TSubOrderHistory = class(TParentSub)
    quOrder: TADOQuery;
    quOrderIDFornecedor: TIntegerField;
    quOrderMovDate: TDateTimeField;
    quOrderDocumentID: TIntegerField;
    quOrderCostPrice: TFloatField;
    quOrderDateEstimatedMov: TDateTimeField;
    quOrderDateRealMov: TDateTimeField;
    quOrderSalePrice: TFloatField;
    quOrderVendor: TStringField;
    dsOrder: TDataSource;
    grdOrder: TSMDBGrid;
    quArrivals: TADOQuery;
    quArrivalsIDFornecedor: TIntegerField;
    quArrivalsMovDate: TDateTimeField;
    quArrivalsDocumentID: TIntegerField;
    quArrivalsCostPrice: TFloatField;
    quArrivalsDateEstimatedMov: TDateTimeField;
    quArrivalsDateRealMov: TDateTimeField;
    quArrivalsSalePrice: TFloatField;
    quArrivalsVendor: TStringField;
    quArrivalsQty: TFloatField;
    quArrivalsQtyRealMov: TFloatField;
    quOrderQty: TFloatField;
    quOrderQtyRealMov: TFloatField;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fIDModel : Integer;
    fViewType : Integer;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uParamFunctions, uDMGlobal, Math;

{$R *.dfm}

procedure TSubOrderHistory.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubOrderHistory.DataSetOpen;
begin

 with TADOQuery(dsOrder.DataSet) do
   if not Active then
      begin
      Parameters.ParambyName('IDModel').Value := fIDModel;
      Open;
      end;

end;

procedure TSubOrderHistory.DataSetClose;
begin
 with TADOQuery(dsOrder.DataSet) do
   if Active then
      Close;
end;


procedure TSubOrderHistory.AfterSetParam;
var
  I : Integer;
  Campo : TField;
  Desabilitou : Boolean;
begin
   if FParam = '' then
     Exit;


   fIDModel  := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
   fViewType := StrToIntDef(ParseParam(FParam, 'ViewType'),0);
   case fViewType of
     0 : dsOrder.DataSet := quOrder;
     1 : dsOrder.DataSet := quArrivals;
   end;

   DataSetRefresh;
end;


procedure TSubOrderHistory.FormDestroy(Sender: TObject);
begin
  DataSetClose;

  inherited;

end;

initialization
   RegisterClass(TSubOrderHistory);

end.
