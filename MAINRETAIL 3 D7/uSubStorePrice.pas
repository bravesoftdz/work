unit uSubStorePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid;

type
  TSubStorePrice = class(TParentSub)
    dsInventoryPrices: TADODataSet;
    grdPrices: TcxGrid;
    grdPricesDB: TcxGridDBTableView;
    grdPricesLevel: TcxGridLevel;
    dsInventoryPricesStore: TStringField;
    dsInventoryPricesStoreID: TIntegerField;
    dsInventoryPricesSellingPrice: TBCDField;
    dsInventoryPricesCostPrice: TBCDField;
    dsInventoryPricesStoreAvgPrice: TBCDField;
    dsInventoryPrice: TDataSource;
    grdPricesDBStore: TcxGridDBColumn;
    grdPricesDBSellingPrice: TcxGridDBColumn;
    grdPricesDBCostPrice: TcxGridDBColumn;
    grdPricesDBStoreAvgPrice: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    fIDModel : Integer;
    fViewCost, fViewAvgCost : Boolean;
  protected
    sYes, sNo : String;
    procedure AfterSetParam; override;
  public
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;

    function GetCurrentKey: integer; override;
  end;

implementation

uses uDM, uParamFunctions, cxStyleSheetEditor, cxLookAndFeels, uPassword,
     uSystemConst, uDMGlobal, cxGridDBDataDefinitions;

{$R *.dfm}

procedure TSubStorePrice.AfterSetParam;
begin
  inherited;
  fIDModel     := StrToIntDef(ParseParam(FParam, 'IDModel'), 0);
  fViewCost    := (StrToIntDef(ParseParam(FParam, 'ShowCost'), 0) = 1);
  fViewAvgCost := (StrToIntDef(ParseParam(FParam, 'ShowAvgCost'), 0) = 1);
  grdPricesDBCostPrice.Visible := fViewCost;
  grdPricesDBStoreAvgPrice.Visible := fViewAvgCost;
  DataSetRefresh;
end;

procedure TSubStorePrice.DataSetClose;
begin
  inherited;
  with dsInventoryPrices do
    if Active then
      Close;
end;

procedure TSubStorePrice.DataSetOpen;
begin
  inherited;
  with dsInventoryPrices do
    if not Active then
    begin
      Parameters.ParambyName('IDModel').Value := fIDModel;
      Open;
    end;
end;

procedure TSubStorePrice.DataSetRefresh;
begin
 DataSetClose;
 DataSetOpen;
end;

procedure TSubStorePrice.FormCreate(Sender: TObject);
begin
  inherited;

  Case DM.fGrid.Kind of
   0 : grdPrices.LookAndFeel.Kind := lfStandard;
   1 : grdPrices.LookAndFeel.Kind := lfFlat;
   2 : grdPrices.LookAndFeel.Kind := lfUltraFlat;
  end;

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fGrid.Layout<>-1)  then
     TcxGridDBTableView(grdPrices.ActiveView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);


  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sYes := 'Yes';
           sNo  := 'No';
           end;

     LANG_PORTUGUESE :
           begin
           sYes := 'Sim';
           sNo  := 'Não';
           end;

     LANG_SPANISH :
           begin
           sYes := 'Sí';
           sNo  := 'No';
           end;
   end;

end;

function TSubStorePrice.GetCurrentKey: integer;
begin
  Result := dsInventoryPrices.FieldByName('StoreID').AsInteger;
end;

initialization
   RegisterClass(TSubStorePrice);


end.
