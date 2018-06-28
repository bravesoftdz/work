unit uBrwInventoryMov;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables,  Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, RadioButtonAll,
  PanelSelect, ImgList, ADODB, RCADOQuery, PowerADOQuery,
  SuperComboADO, siComp, siLangRT, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwInventoryMov = class(TbrwParent)
    Label3: TLabel;
    cmbModel: TSuperComboADO;
    quBrowseName: TStringField;
    quBrowseDocumentID: TIntegerField;
    quBrowseMovDate: TDateTimeField;
    quBrowseSalePrice: TFloatField;
    Panel6: TPanel;
    quBrowseIDInventoryMov: TIntegerField;
    Label5: TLabel;
    EditHand: TEdit;
    Label6: TLabel;
    EditOrder: TEdit;
    Label7: TLabel;
    EditPreSale: TEdit;
    spQuantity: TADOStoredProc;
    quBrowseSystem: TBooleanField;
    Panel10: TPanel;
    quBrowseCostPrice: TFloatField;
    quBrowseSystemUser: TStringField;
    Button1: TButton;
    cmbStore: TSuperComboADO;
    Label4: TLabel;
    grdBrowseDBIDInventoryMov: TcxGridDBColumn;
    grdBrowseDBMovDate: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBDocumentID: TcxGridDBColumn;
    grdBrowseDBQty: TcxGridDBColumn;
    grdBrowseDBSalePrice: TcxGridDBColumn;
    grdBrowseDBSystem: TcxGridDBColumn;
    grdBrowseDBCostPrice: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    quBrowseQty: TFloatField;
    spQuantityQtyOnPreSale: TFloatField;
    spQuantityQtyOnHand: TFloatField;
    spQuantityQtyOnOrder: TFloatField;
    spQuantityQtyOnPrePurchase: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure cmbModelSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure btnExecClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmInventoryMov, uDM, uMsgBox, uMsgConstant, uDMGlobal;

procedure TbrwInventoryMov.FormCreate(Sender: TObject);
begin
  inherited;

  brwForm  := TbrwFrmInventoryMov.Create(Self);
  ActualOrder := 1;
  cmbStore.LookUpValue := intToStr(DM.fStore.ID);
  
end;

procedure TbrwInventoryMov.cmbModelSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwInventoryMov.FormShow(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := IntToStr(DM.fStore.ID);
end;

procedure TbrwInventoryMov.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // Da o refresh dos edits das quantities
  quBrowse.First;
  with spQuantity do
    begin
     if Active then Close;
     Parameters.ParamByName('@ModelID').Value := StrToInt(cmbModel.LookUpValue);
     if cmbStore.LookUpValue <> '' then
       Parameters.ParamByName('@StoreID').Value := StrToInt(cmbStore.LookUpValue)
     else
       Parameters.ParamByName('@StoreID').Value := 0;
     Open;
     try
       EditHand.Text    := FormatFloat('0.#####',spQuantityQtyOnHand.AsFloat);
       EditPreSale.Text := FormatFloat('0.#####',spQuantityQtyOnPreSale.AsFloat);
       EditOrder.Text   := FormatFloat('0.#####',spQuantityQtyOnOrder.AsFloat);
     finally
        Close;
        end;
    end;
end;

procedure TbrwInventoryMov.btnExecClick(Sender: TObject);
begin
  inherited;
  // Seta os filtros do Model
  if cmbModel.LookUpValue = '' then
     begin
     aWhereBasicFilters[0] := '';
     MsgBox(MSG_EXC_SELECT_A_MODEL, vbOKOnly + vbInformation);
     cmbModel.SetFocus;
     Exit;
     end;

  aWhereBasicFilters[0] := 'MH.ModelID = ' + cmbModel.LookUpValue;

  // Seta os filtros da Store
  if cmbStore.LookUpValue = '' then
     aWhereBasicFilters[1] := 'MH.StoreID IN ('+ DM.fStore.StoreList +')'
  else
     aWhereBasicFilters[1] := 'MH.StoreID = ' + cmbStore.LookUpValue;

  // Adiciono os filtros ao quBrowse (que na verdade nao sao filtros
  // mais sim sugestao de fields para a ficha)
  with quBrowse do
    begin
      ClearFilters;
      if cmbModel.LookUpValue <> '' then
        begin
          FilterFields.Add('ModelID');
          FilterValues.Add(cmbModel.LookUpValue);
        end;

      if cmbStore.LookUpValue <> '' then
        begin
          FilterFields.Add('StoreID');
          FilterValues.Add(cmbStore.LookUpValue);
        end;
    end;


  ExecBrowseSQL(True);
  grdBrowse.SetFocus;

  DesativaAviso;

end;

procedure TbrwInventoryMov.Button1Click(Sender: TObject);
begin
  inherited;

  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+Button1.Caption+'>';

  AtivaAviso;

end;

procedure TbrwInventoryMov.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if DM.fStartOption = START_INVENT_TYPE then
     begin
     Application.Terminate;
     end;
end;

end.
