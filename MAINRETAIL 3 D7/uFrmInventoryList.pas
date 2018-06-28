unit uFrmInventoryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, DB, ADODB, PowerADOQuery, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, PanelRights, uFrmExport;

type
  TFrmInventoryList = class(TFrmParentAll)
    pnlBasicFilter: TPanel;
    pblGO: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    Label4: TLabel;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    Label2: TLabel;
    scGroup: TSuperComboADO;
    btGroupAll: TButton;
    quModel: TPowerADOQuery;
    dsModelList: TDataSource;
    quModelIDModel: TIntegerField;
    quModelSellingPrice: TBCDField;
    quModelCurrentCost: TBCDField;
    quModelFloatPercent: TIntegerField;
    quModelReplacementCost: TBCDField;
    grdModelList: TcxGrid;
    grdModelListDB: TcxGridDBTableView;
    grdModelListLevel: TcxGridLevel;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    quModelCategory: TStringField;
    grdModelListDBIDModel: TcxGridDBColumn;
    grdModelListDBTotQtyOnHand: TcxGridDBColumn;
    grdModelListDBTotQtyOnPreSale: TcxGridDBColumn;
    grdModelListDBTotQtyOnPrePurchase: TcxGridDBColumn;
    grdModelListDBTotQtyOnOrder: TcxGridDBColumn;
    grdModelListDBTotQtyOnHandF: TcxGridDBColumn;
    grdModelListDBModel: TcxGridDBColumn;
    grdModelListDBDescription: TcxGridDBColumn;
    grdModelListDBCategory: TcxGridDBColumn;
    quModelHasInStore: TStringField;
    grdModelListDBHasInStore: TcxGridDBColumn;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    pnlButton: TPanelRights;
    btColumn: TSpeedButton;
    btGroup: TSpeedButton;
    btPrint: TSpeedButton;
    btFilter: TSpeedButton;
    panel8: TPanel;
    quModelManufacture: TStringField;
    grdModelListDBManufacture: TcxGridDBColumn;
    strepPredefined: TcxStyleRepository;
    cxGridTableViewStyleSheet: TcxGridTableViewStyleSheet;
    cxStyle: TcxStyle;
    btExcel: TSpeedButton;
    Label1: TLabel;
    scStore: TSuperComboADO;
    btnClearStore: TButton;
    quModelTotQtyOnHand: TFloatField;
    quModelTotQtyOnRepair: TFloatField;
    quModelTotQtyOnPreSale: TFloatField;
    quModelTotQtyOnPrePurchase: TFloatField;
    quModelTotQtyOnOrder: TFloatField;
    quModelTotQtyOnHandF: TFloatField;
    procedure quModelCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btFilterClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btGroupAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btnClearStoreClick(Sender: TObject);
  private
    sYes,
    sNo,
    sTitle : String;
    AView    : TcxCustomGridTableView;
  public
    function Start:Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uPassword, uSqlFunctions, uMsgBox,
     uMsgConstant;

{$R *.dfm}

procedure TFrmInventoryList.quModelCalcFields(DataSet: TDataSet);
begin
  inherited;

  if quModelTotQtyOnHand.AsFloat > 0 then
     quModelHasInStore.AsString := sYes
  else
     quModelHasInStore.AsString := sNo;


  //Calcular a quantidade Flutuante do Modelo
  if (not grdModelListDBTotQtyOnHandF.Visible) or (quModelFloatPercent.AsInteger = 0) then
     begin
     quModelTotQtyOnHandF.AsFloat := (quModelTotQtyOnHand.AsFloat - quModelTotQtyOnPreSale.AsFloat);
     Exit;
     end;

  if DM.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] then
    quModelTotQtyOnHandF.AsFloat := (quModelTotQtyOnHand.AsFloat - quModelTotQtyOnPreSale.AsFloat) +
                                ((quModelTotQtyOnPreSale.AsFloat * quModelFloatPercent.AsInteger)) / 100
  else
    quModelTotQtyOnHandF.AsFloat := Trunc((quModelTotQtyOnHand.AsFloat - quModelTotQtyOnPreSale.AsFloat) +
                                ((quModelTotQtyOnPreSale.AsFloat * quModelFloatPercent.AsInteger)) / 100);

end;

procedure TFrmInventoryList.FormCreate(Sender: TObject);
begin
  inherited;

  DM.imgBTN.GetBitmap(BTN_PREVIEW, btPrint.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_FILTER, btFilter.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);

  //Pega o Browser atual
  AView := TcxCustomGridTableView(grdModelList.FocusedView);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sYes   := 'Yes';
           sNo    := 'No';
           sTitle := 'Inventory list ';
           end;

     LANG_PORTUGUESE :
           begin
           sYes   := 'Sim';
           sNo    := 'Não';
           sTitle := 'Estoque disponível ';
           end;

     LANG_SPANISH :
           begin
           sYes   := 'Sí';
           sNo    := 'No';
           sTitle := 'Listagem de estoque ';
           end;
   end;

end;

procedure TFrmInventoryList.btnExecClick(Sender: TObject);
var
  sWhere : String;
begin
  inherited;

  sWhere := ' M.Desativado = 0 AND M.Hidden = 0	AND	M.NotVerifyQty = 0 ' +
            ' AND M.ModelType IN ('+QuotedStr('S')+','+QuotedStr('R')+','+QuotedStr('V')+','+QuotedStr('C')+','+QuotedStr('K')+','+QuotedStr('G')+')';

  if scFabricante.LookUpValue <> '' then
     sWhere := sWhere + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;

  if scGroup.LookUpValue <> '' then
     sWhere := sWhere + ' AND M.GroupID = ' + scGroup.LookUpValue;

  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND Inv.StoreID = ' + scStore.LookUpValue;

  with quModel do
  begin
  if Active then
     Close;
  CommandText := ChangeWhereClause(CommandText, sWhere, True);
  Open;
  end;
end;

procedure TFrmInventoryList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quModel.Close;
  Action := caFree;
end;

function TFrmInventoryList.Start: Boolean;
var
  IDStore : Integer;
begin
   if DM.fStore.IDStoreSale <> -1 then
      IDStore := DM.fStore.IDStoreSale
   else
      IDStore := DM.fStore.ID;

   scStore.LookUpValue := IntToStr(IDStore);
   Result := (ShowModal = mrOK);
end;

procedure TFrmInventoryList.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmInventoryList.btPrintClick(Sender: TObject);
begin
  inherited;
  gridPrinterLink.ReportTitle.Text := sTitle + '(' + FormatDateTime('ddddd', Now) +')';
  gridPrinter.Preview(True, nil);
end;

procedure TFrmInventoryList.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdModelList do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;

end;

procedure TFrmInventoryList.btColumnClick(Sender: TObject);
begin
  inherited;
  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmInventoryList.btFilterClick(Sender: TObject);
begin
  inherited;

  if btFilter.Down then
    begin
    TcxGridDBTableView(AView).Filtering.Visible := fvAlways;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := True;
    end
  else
    begin
    TcxGridDBTableView(AView).Filtering.Visible := fvNever;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := False;
    end;

end;

procedure TFrmInventoryList.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '';
end;

procedure TFrmInventoryList.btGroupAllClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '';
end;

procedure TFrmInventoryList.FormShow(Sender: TObject);
begin
  inherited;
  btnExecClick(Self);
end;

procedure TFrmInventoryList.btExcelClick(Sender: TObject);
begin
  inherited;

 If (not quModel.Active) or
    (quModel.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(grdModelList, sTitle);

end;

procedure TFrmInventoryList.btnClearStoreClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '';
end;

end.
