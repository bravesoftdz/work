unit uSubVendorHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, Grids, DBGrids, SMDBGrid, DB,
  ADODB;

type
  TSubVendorHistory = class(TParentSub)
    dsVendorHistory: TDataSource;
    quVendorHistory: TADOQuery;
    quVendorHistoryLastDate: TDateTimeField;
    quVendorHistoryModelID: TIntegerField;
    quVendorHistoryModel: TStringField;
    quVendorHistoryDescription: TStringField;
    quVendorHistoryCostPrice: TFloatField;
    quVendorHistoryFreight: TFloatField;
    quVendorHistoryOtherCost: TFloatField;
    quVendorHistoryTotal: TFloatField;
    grdModelFrameVendorHistory: TSMDBGrid;
    quVendorHistoryQty: TFloatField;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fIDStore  : Integer;
    fIDVendor : Integer;
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

procedure TSubVendorHistory.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubVendorHistory.DataSetOpen;
begin

 with quVendorHistory do
   if not Active then
      begin
      Parameters.ParambyName('IDStore').Value      := fIDStore;
      if fIDVendor <> 0 then
         Parameters.ParambyName('IDFornecedor').Value := fIDVendor
      else
         Parameters.ParambyName('IDFornecedor').Value := Null;
      Open;
      end;

end;

procedure TSubVendorHistory.DataSetClose;
begin
 with quVendorHistory do
   if Active then
      Close;
end;

procedure TSubVendorHistory.AfterSetParam;
begin

   fIDStore  := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
   fIDVendor := StrToIntDef(ParseParam(FParam, 'IDVendor'),0);
   DataSetRefresh;

end;


procedure TSubVendorHistory.FormDestroy(Sender: TObject);
begin

  DataSetClose;

  inherited;

end;

initialization
   RegisterClass(TSubVendorHistory);


end.
