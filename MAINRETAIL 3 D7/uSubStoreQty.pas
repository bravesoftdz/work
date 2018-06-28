unit uSubStoreQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, ADODB, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, siComp, siLangRT, Provider, DBClient;

type
  TSubStoreQty = class(TParentSub)
    grdQty: TcxGrid;
    grdQtyDB: TcxGridDBTableView;
    grdQtyDBName: TcxGridDBColumn;
    grdQtyDBQtyOnPreSale: TcxGridDBColumn;
    grdQtyDBQtyOnHand: TcxGridDBColumn;
    grdQtyDBQtyOnOrder: TcxGridDBColumn;
    grdQtyDBQtyOnRepair: TcxGridDBColumn;
    grdQtyDBQtyOnPrePurchase: TcxGridDBColumn;
    grdQtyLevel: TcxGridLevel;
    spQty: TADOStoredProc;
    spQtyName: TStringField;
    spQtyStoreID: TIntegerField;
    spQtyCurrentCost: TFloatField;
    dsQty: TDataSource;
    grdQtyDBQtyFloating: TcxGridDBColumn;
    spQtyFloatPercent: TIntegerField;
    spQtyHasInStore: TStringField;
    grdQtyDBHasInStore: TcxGridDBColumn;
    spQtyQtyOnPreSale: TFloatField;
    spQtyQtyOnHand: TFloatField;
    spQtyQtyOnOrder: TFloatField;
    spQtyQtyOnRepair: TFloatField;
    spQtyQtyOnPrePurchase: TFloatField;
    spQtyQtyOnOrderPositive: TFloatField;
    spQtyQtyFloating: TFloatField;
    spQtyMinQty: TFloatField;
    spQtyMaxQty: TFloatField;
    grdQtyDBMinQty: TcxGridDBColumn;
    grdQtyDBMaxQty: TcxGridDBColumn;
    grdQtyDBIDStore: TcxGridDBColumn;
    procedure dsQtyDataChange(Sender: TObject; Field: TField);
    procedure spQtyAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spQtyCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    fIDModel      : Integer;
    fQtyOnHold    : Double;
    fQtyOnHand    : Double;
    fQtyOnRepair  : Double;
    fQtyOnOrder   : Double;
    fQtyInRec     : Double;
    fShowMinMax   : Boolean;
    procedure RefreshQty;
  protected
      sYes,
      sNo : String;
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
    procedure DisplayQty;
    function GetCurrentKey: integer; override;

    property QtyOnHold   : Double read fQtyOnHold;
    property QtyOnHand   : Double read fQtyOnHand;
    property QtyOnRepair : Double read fQtyOnRepair;
    property QtyOnOrder  : Double read fQtyOnOrder;
    property QtyInRec    : Double read fQtyInRec;
  end;

implementation

uses uDM, uParamFunctions, cxStyleSheetEditor, cxLookAndFeels, uPassword,
     uSystemConst, uDMGlobal, cxGridDBDataDefinitions;

{$R *.dfm}

procedure TSubStoreQty.AfterSetParam;
begin
  fIDModel    := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
  fShowMinMax := (ParseParam(FParam, 'ShowMinMax')='Y');
  DataSetRefresh;
  DisplayQty;
end;

procedure TSubStoreQty.RefreshQty;
begin
  fQtyOnHold   := spQtyQtyOnPreSale.AsFloat;
  fQtyOnHand   := spQtyQtyOnHand.AsFloat;
  fQtyOnRepair := spQtyQtyOnRepair.AsFloat;
  fQtyOnOrder  := spQtyQtyOnOrder.AsFloat;
  fQtyInRec    := spQtyQtyOnPrePurchase.AsFloat;
end;

procedure TSubStoreQty.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubStoreQty.DataSetOpen;
begin
  with spQty do
    if not Active then
    begin
      Parameters.ParambyName('@ModelID').Value := fIDModel;
      Open;
    end;
end;

procedure TSubStoreQty.DataSetClose;
begin
  with spQty do
    if Active then
       Close;
end;


procedure TSubStoreQty.dsQtyDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  RefreshQty;
end;

procedure TSubStoreQty.spQtyAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshQty;
end;

procedure TSubStoreQty.FormCreate(Sender: TObject);
begin
  inherited;

  Case DM.fGrid.Kind of
   0 : grdQty.LookAndFeel.Kind := lfStandard;
   1 : grdQty.LookAndFeel.Kind := lfFlat;
   2 : grdQty.LookAndFeel.Kind := lfUltraFlat;
  end;

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fGrid.Layout<>-1)  then
     TcxGridDBTableView(grdQty.ActiveView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);


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

procedure TSubStoreQty.FormDestroy(Sender: TObject);
begin
  DataSetClose;

  inherited;

end;

procedure TSubStoreQty.spQtyCalcFields(DataSet: TDataSet);
begin
  inherited;

  if spQtyQtyOnOrder.AsFloat < 0 then
     spQtyQtyOnOrderPositive.AsFloat := 0
  else
     spQtyQtyOnOrderPositive.AsFloat := spQtyQtyOnOrder.AsFloat;

  if spQtyQtyOnHand.AsFloat > 0 then
     spQtyHasInStore.AsString := sYes
  else
     spQtyHasInStore.AsString := sNo;

  //Calcular a quantidade Flutuante do Modelo
  if (not grdQtyDBQtyFloating.Visible) or (spQtyFloatPercent.AsFloat = 0) then
     begin
     spQtyQtyFloating.AsFloat := (spQtyQtyOnHand.AsFloat - spQtyQtyOnPreSale.AsFloat);
     Exit;
     end;

  if DM.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] then
    spQtyQtyFloating.AsFloat := (spQtyQtyOnHand.AsFloat - spQtyQtyOnPreSale.AsFloat) +
                                     ((spQtyQtyOnPreSale.AsFloat * spQtyFloatPercent.AsFloat)) / 100
  else
    spQtyQtyFloating.AsFloat := Trunc((spQtyQtyOnHand.AsFloat - spQtyQtyOnPreSale.AsFloat) +
                                     ((spQtyQtyOnPreSale.AsFloat * spQtyFloatPercent.AsFloat)) / 100);

end;

procedure TSubStoreQty.DisplayQty;
begin

  grdQtyDBQtyOnHand.Visible    := Password.HasFuncRight(45);
  grdQtyDBQtyFloating.Visible  := Password.HasFuncRight(46);
  grdQtyDBQtyOnPreSale.Visible := Password.HasFuncRight(47);
  grdQtyDBHasInStore.Visible   := Password.HasFuncRight(56);
  grdQtyDBMinQty.Visible       := fShowMinMax;
  grdQtyDBMaxQty.Visible       := fShowMinMax;

end;

function TSubStoreQty.GetCurrentKey: integer;
begin
  Result := spQty.FieldByName('StoreID').AsInteger;
end;

initialization
   RegisterClass(TSubStoreQty);

end.
