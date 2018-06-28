unit uSubPurchaseHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, Grids, DBGrids, SMDBGrid, DB,
  ADODB;

type
  TSubPurchaseHistory = class(TParentSub)
    quHistory: TADOQuery;
    quHistoryMovDate: TDateTimeField;
    quHistoryCostPrice: TFloatField;
    quHistoryIDFornecedor: TIntegerField;
    quHistoryFreight: TFloatField;
    quHistoryOtherCost: TFloatField;
    quHistoryVendor: TStringField;
    quHistoryCode: TIntegerField;
    dsHistory: TDataSource;
    grdFrameModelPruchaseHistory: TSMDBGrid;
    quHistoryIDPurchase: TIntegerField;
    quHistoryDocumentNumber: TStringField;
    quHistoryQty: TFloatField;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fIDModel : Integer;
    fIDStore : Integer;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uParamFunctions, uDMGlobal;

{$R *.dfm}

procedure TSubPurchaseHistory.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubPurchaseHistory.DataSetOpen;
begin

 with quHistory do
   if not Active then
      begin
      Parameters.ParambyName('IDModel').Value := fIDModel;
      if fIDStore <> -1 then
         Parameters.ParambyName('IDStore').Value := fIDStore
      else
         Parameters.ParambyName('IDStore').Value := Null;
      Open;
      end;

end;

procedure TSubPurchaseHistory.DataSetClose;
begin
 with quHistory do
   if Active then
      Close;
end;


procedure TSubPurchaseHistory.AfterSetParam;
begin

   fIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
   fIDStore := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
   DataSetRefresh;

end;

procedure TSubPurchaseHistory.FormDestroy(Sender: TObject);
begin

  DataSetClose;
  inherited;

end;

initialization
   RegisterClass(TSubPurchaseHistory);
                                    
end.
