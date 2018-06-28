unit uFrmNewPOAuto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  ComCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, Mask, DBCtrls, SubListPanel, ADODB, SuperComboADO, DBClient,
  Provider, DateBox;

const
  PO_SINGLE = 0;
  PO_MULTI  = 1;

type
  TFrmNewPOAuto = class(TFrmParent)
    pgPOAuto: TPageControl;
    tsPOFilter: TTabSheet;
    tsRevise: TTabSheet;
    btNavigate: TButton;
    Panel4: TPanel;
    pnlButtons: TPanel;
    btSelectAll: TSpeedButton;
    btCreatePO: TSpeedButton;
    pnlDivisoria2: TPanel;
    grdPOFilter: TcxGrid;
    grdPOFilterDB: TcxGridDBTableView;
    grdPOFilterLevel: TcxGridLevel;
    Panel5: TPanel;
    btUnSelectAll: TSpeedButton;
    pnlPO: TPanel;
    pnlPODetail: TPanel;
    lblObs: TLabel;
    lblTotal: TLabel;
    lblPOInfo: TLabel;
    lblOrderDate: TLabel;
    lblPayDays: TLabel;
    edtTotal: TDBEdit;
    edPayDays: TDBEdit;
    grdPO: TcxGrid;
    grdPODB: TcxGridDBTableView;
    grdPOLevel: TcxGridLevel;
    Panel6: TPanel;
    btExport: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    Panel7: TPanel;
    Panel8: TPanel;
    btBack: TButton;
    dtsRequest: TDataSource;
    quMin: TADODataSet;
    cmbList: TComboBox;
    lblRequest: TLabel;
    lblStore: TLabel;
    scStore: TSuperComboADO;
    lblCategory: TLabel;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    lblGroup: TLabel;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    lblSubGroup: TLabel;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    lblManufect: TLabel;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    lblVendor: TLabel;
    scVendor: TSuperComboADO;
    btnAllVendor: TButton;
    btSearch: TBitBtn;
    dspRequest: TDataSetProvider;
    cdsRequest: TClientDataSet;
    grdPOFilterDBModel: TcxGridDBColumn;
    grdPOFilterDBDescription: TcxGridDBColumn;
    grdPOFilterDBClasseABC: TcxGridDBColumn;
    grdPOFilterDBCategory: TcxGridDBColumn;
    grdPOFilterDBMaxQty: TcxGridDBColumn;
    grdPOFilterDBMinQty: TcxGridDBColumn;
    grdPOFilterDBMarked: TcxGridDBColumn;
    grdPOFilterDBQtyOnHand: TcxGridDBColumn;
    grdPOFilterDBFinalCost: TcxGridDBColumn;
    grdPOFilterDBMSRP: TcxGridDBColumn;
    grdPOFilterDBSellingPrice: TcxGridDBColumn;
    grdPOFilterDBTotQtyOnHand: TcxGridDBColumn;
    grdPOFilterDBCaseQty: TcxGridDBColumn;
    grdPOFilterDBSubCategory: TcxGridDBColumn;
    grdPOFilterDBMGroup: TcxGridDBColumn;
    grdPOFilterDBManufacture: TcxGridDBColumn;
    grdPOFilterDBDateRequest: TcxGridDBColumn;
    grdPOFilterDBSystemUser: TcxGridDBColumn;
    quMinIDRequest: TIntegerField;
    quMinIDModel: TIntegerField;
    quMinModel: TStringField;
    quMinDescription: TStringField;
    quMinClasseABC: TStringField;
    quMinFinalCost: TBCDField;
    quMinMSRP: TBCDField;
    quMinSellingPrice: TBCDField;
    quMinTotQtyOnHand: TFloatField;
    quMinCaseQty: TFloatField;
    quMinCategory: TStringField;
    quMinSubCategory: TStringField;
    quMinMGroup: TStringField;
    quMinManufacture: TStringField;
    quMinDateRequest: TDateTimeField;
    quMinQtyOnHand: TFloatField;
    quMinMaxQty: TFloatField;
    quMinMinQty: TFloatField;
    quMinQtyOrdered: TFloatField;
    quMinSystemUser: TStringField;
    quMinIDVendor: TIntegerField;
    quMinVendor: TStringField;
    grdPOFilterDBVendor: TcxGridDBColumn;
    btPOGroup: TSpeedButton;
    btPOColumn: TSpeedButton;
    Panel9: TPanel;
    cdsPO: TClientDataSet;
    cdsPOItem: TClientDataSet;
    dtsPO: TDataSource;
    dtsPOItem: TDataSource;
    cdsPOIDVendor: TIntegerField;
    cdsPOItemIDVendor: TIntegerField;
    cdsPOItemIDModel: TIntegerField;
    cdsPOItemQtyOrdered: TFloatField;
    btRemoveItem: TSpeedButton;
    pnlSeparator: TPanel;
    cdsPOPayDays: TIntegerField;
    cdsPODataPedido: TDateTimeField;
    cdsPOVendor: TStringField;
    cdsPOItemModel: TStringField;
    cdsPOItemDescription: TStringField;
    grdPOItem: TcxGrid;
    grdPOItemDB: TcxGridDBTableView;
    grdPOItemLevel: TcxGridLevel;
    quMinIDStore: TIntegerField;
    cdsPOIDStore: TIntegerField;
    cdsPOStore: TStringField;
    cdsPOItemIDStore: TIntegerField;
    grdPODBVendor: TcxGridDBColumn;
    grdPODBStore: TcxGridDBColumn;
    quMinStore: TStringField;
    btDetail: TSpeedButton;
    lblEstArrival: TLabel;
    mmObs: TDBMemo;
    cdsPOObs: TStringField;
    cdsPOTotal: TCurrencyField;
    edtOrderDate: TDBDateBox;
    edtEstArriv: TDBDateBox;
    cdsPOEstArrival: TDateTimeField;
    cmdInsPO: TADOCommand;
    cmdInsPOItem: TADOCommand;
    cdsPOItemCostPrice: TCurrencyField;
    cdsPOItemSalePrice: TCurrencyField;
    cdsPOItemSuggRetail: TCurrencyField;
    grdPOItemDBModel: TcxGridDBColumn;
    grdPOItemDBDescription: TcxGridDBColumn;
    grdPOItemDBQtyOrdered: TcxGridDBColumn;
    grdPOItemDBCostPrice: TcxGridDBColumn;
    grdPOItemDBSalePrice: TcxGridDBColumn;
    grdPOItemDBSuggRetail: TcxGridDBColumn;
    grdPOFilterDBStore: TcxGridDBColumn;
    quSales: TADODataSet;
    quSalesIDRequest: TIntegerField;
    quSalesIDModel: TIntegerField;
    quSalesModel: TStringField;
    quSalesDescription: TStringField;
    quSalesClasseABC: TStringField;
    quSalesFinalCost: TBCDField;
    quSalesMSRP: TBCDField;
    quSalesSellingPrice: TBCDField;
    quSalesTotQtyOnHand: TFloatField;
    quSalesCaseQty: TFloatField;
    quSalesCategory: TStringField;
    quSalesSubCategory: TStringField;
    quSalesMGroup: TStringField;
    quSalesManufacture: TStringField;
    quSalesIDStore: TIntegerField;
    quSalesDateRequest: TDateTimeField;
    quSalesQtyOnHand: TFloatField;
    quSalesMaxQty: TFloatField;
    quSalesMinQty: TFloatField;
    quSalesQtyOrdered: TFloatField;
    quSalesStore: TStringField;
    quSalesSystemUser: TStringField;
    quSalesMarked: TBooleanField;
    quSalesIDVendor: TIntegerField;
    quSalesVendor: TStringField;
    quPreSales: TADODataSet;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    BCDField4: TBCDField;
    BCDField5: TBCDField;
    BCDField6: TBCDField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    IntegerField6: TIntegerField;
    DateTimeField2: TDateTimeField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    FloatField12: TFloatField;
    StringField17: TStringField;
    StringField18: TStringField;
    BooleanField2: TBooleanField;
    IntegerField7: TIntegerField;
    StringField19: TStringField;
    grdPODBIDStore: TcxGridDBColumn;
    grdPODBIDVendor: TcxGridDBColumn;
    grdPOItemDBIDModel: TcxGridDBColumn;
    grdPOItemDBIDStore: TcxGridDBColumn;
    grdPOItemDBIDVendor: TcxGridDBColumn;
    pnlProgress: TPanel;
    lbProgress: TLabel;
    pb: TProgressBar;
    slModelDetail: TSubListPanel;
    btnItemsDetail: TSpeedButton;
    quRequest: TADODataSet;
    quRequestIDRequest: TIntegerField;
    quRequestIDModel: TIntegerField;
    quRequestModel: TStringField;
    quRequestDescription: TStringField;
    quRequestClasseABC: TStringField;
    quRequestFinalCost: TBCDField;
    quRequestMSRP: TBCDField;
    quRequestSellingPrice: TBCDField;
    quRequestTotQtyOnHand: TFloatField;
    quRequestCaseQty: TFloatField;
    quRequestCategory: TStringField;
    quRequestSubCategory: TStringField;
    quRequestMGroup: TStringField;
    quRequestManufacture: TStringField;
    quRequestIDStore: TIntegerField;
    quRequestDateRequest: TDateTimeField;
    quRequestQtyOnHand: TFloatField;
    quRequestMaxQty: TFloatField;
    quRequestMinQty: TFloatField;
    quRequestQtyOrdered: TFloatField;
    quRequestStore: TStringField;
    quRequestSystemUser: TStringField;
    quRequestMarked: TBooleanField;
    quRequestIDVendor: TIntegerField;
    quRequestVendor: TStringField;
    cbxReqType: TComboBox;
    quMinMarked: TBooleanField;
    quMinCaseQtyOrdered: TFloatField;
    quSalesCaseQtyOrdered: TFloatField;
    quPreSalesCaseQtyOrdered: TFloatField;
    quRequestCaseQtyOrdered: TFloatField;
    cdsPOItemCaseCost: TCurrencyField;
    cdsPOItemCaseQtyOrdered: TFloatField;
    grdPOItemDBCaseQtyOrdered: TcxGridDBColumn;
    cdsPOItemCaseQty: TIntegerField;
    quMinUnitType: TStringField;
    quSalesUnitType: TStringField;
    quPreSalesUnitType: TStringField;
    quRequestUnitType: TStringField;
    grdPOFilterDBUnitType: TcxGridDBColumn;
    grdPOFilterDBQtyToOrder: TcxGridDBColumn;
    quAllInventory: TADODataSet;
    quAllInventoryIDRequest: TIntegerField;
    quAllInventoryIDModel: TIntegerField;
    quAllInventoryModel: TStringField;
    quAllInventoryDescription: TStringField;
    quAllInventoryClasseABC: TStringField;
    quAllInventoryFinalCost: TBCDField;
    quAllInventoryMSRP: TBCDField;
    quAllInventorySellingPrice: TBCDField;
    quAllInventoryTotQtyOnHand: TFloatField;
    quAllInventoryCaseQty: TFloatField;
    quAllInventoryCategory: TStringField;
    quAllInventorySubCategory: TStringField;
    quAllInventoryMGroup: TStringField;
    quAllInventoryManufacture: TStringField;
    quAllInventoryIDStore: TIntegerField;
    quAllInventoryDateRequest: TDateTimeField;
    quAllInventoryQtyOnHand: TFloatField;
    quAllInventoryMaxQty: TFloatField;
    quAllInventoryMinQty: TFloatField;
    quAllInventoryStore: TStringField;
    quAllInventorySystemUser: TStringField;
    quAllInventoryMarked: TBooleanField;
    quAllInventoryIDVendor: TIntegerField;
    quAllInventoryVendor: TStringField;
    quAllInventoryUnitType: TStringField;
    dtSale: TDateBox;
    lbSales: TLabel;
    quMinQtySold: TFloatField;
    quMinAvgSaleQty: TFloatField;
    grdPOFilterDBAvgSaleQty: TcxGridDBColumn;
    quRequestQtySold: TFloatField;
    quRequestAvgSaleQty: TFloatField;
    quAllInventoryQtySold: TFloatField;
    quAllInventoryAvgSaleQty: TFloatField;
    lbDay: TLabel;
    quSalesQtySold: TFloatField;
    quSalesAvgSaleQty: TFloatField;
    quPreSalesQtySold: TFloatField;
    quPreSalesAvgSaleQty: TFloatField;
    grdPOFilterDBQtySold: TcxGridDBColumn;
    strepPredefined: TcxStyleRepository;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    cxHilight: TcxStyle;
    quMinQtyToOrder: TFloatField;
    quSalesQtyToOrder: TFloatField;
    quPreSalesQtyToOrder: TFloatField;
    quRequestQtyToOrder: TFloatField;
    quAllInventoryQtyToOrder: TFloatField;
    cbxPrimaryVendor: TCheckBox;
    quMinExtCost: TCurrencyField;
    quSalesExtCost: TCurrencyField;
    quPreSalesExtCost: TCurrencyField;
    quRequestExtCost: TCurrencyField;
    quAllInventoryExtCost: TCurrencyField;
    grdPOFilterDBExtCost: TcxGridDBColumn;
    Panel10: TPanel;
    Label1: TLabel;
    lbTotalOrder: TLabel;
    quMinAvgSaleWeek: TFloatField;
    quMinAvgSaleMonth: TFloatField;
    grdPOFilterDBAvgSaleMonth: TcxGridDBColumn;
    cdsRequestIDRequest: TIntegerField;
    cdsRequestIDModel: TIntegerField;
    cdsRequestIDVendor: TIntegerField;
    cdsRequestIDStore: TIntegerField;
    cdsRequestModel: TStringField;
    cdsRequestDescription: TStringField;
    cdsRequestClasseABC: TStringField;
    cdsRequestFinalCost: TBCDField;
    cdsRequestMSRP: TBCDField;
    cdsRequestSellingPrice: TBCDField;
    cdsRequestTotQtyOnHand: TFloatField;
    cdsRequestCaseQty: TFloatField;
    cdsRequestCategory: TStringField;
    cdsRequestSubCategory: TStringField;
    cdsRequestMGroup: TStringField;
    cdsRequestManufacture: TStringField;
    cdsRequestDateRequest: TDateTimeField;
    cdsRequestQtyOnHand: TFloatField;
    cdsRequestMaxQty: TFloatField;
    cdsRequestMinQty: TFloatField;
    cdsRequestSystemUser: TStringField;
    cdsRequestQtyOrdered: TFloatField;
    cdsRequestCaseQtyOrdered: TFloatField;
    cdsRequestMarked: TBooleanField;
    cdsRequestVendor: TStringField;
    cdsRequestStore: TStringField;
    cdsRequestUnitType: TStringField;
    cdsRequestQtySold: TFloatField;
    cdsRequestAvgSaleQty: TFloatField;
    cdsRequestQtyToOrder: TFloatField;
    cdsRequestExtCost: TCurrencyField;
    cdsRequestAvgSaleWeek: TFloatField;
    cdsRequestAvgSaleMonth: TFloatField;
    grdPOFilterDBAvgSaleWeek: TcxGridDBColumn;
    quMinQtyOnOrder: TFloatField;
    quSalesQtyOnOrder: TFloatField;
    quRequestQtyOnOrder: TFloatField;
    quAllInventoryQtyOnOrder: TFloatField;
    cdsRequestQtyOnOrder: TFloatField;
    grdPOFilterDBQtyOnOrder: TcxGridDBColumn;
    Panel: TPanel;
    gbLegend: TGroupBox;
    lbOnPO: TLabel;
    shpOnPO: TShape;
    cbShowLegend: TCheckBox;
    quSalesAvgSaleWeek: TCurrencyField;
    quPreSalesAvgSaleWeek: TCurrencyField;
    quRequestAvgSaleWeek: TCurrencyField;
    quAllInventoryAvgSaleWeek: TCurrencyField;
    quSalesAvgSaleMonth: TCurrencyField;
    quPreSalesAvgSaleMonth: TCurrencyField;
    quRequestAvgSaleMonth: TCurrencyField;
    quAllInventoryAvgSaleMonth: TCurrencyField;
    quAllInventoryQtyOrdered: TFloatField;
    quAllInventoryCaseQtyOrdered: TFloatField;
    cdsRequestQtyPositiveOrdered: TFloatField;
    grdPOFilterDBQtyPositiveOrdered: TcxGridDBColumn;
    quMinWeight: TCurrencyField;
    quSalesWeight: TCurrencyField;
    quPreSalesWeight: TCurrencyField;
    quRequestWeight: TCurrencyField;
    quAllInventoryWeight: TCurrencyField;
    cdsRequestWeight: TCurrencyField;
    grdPOFilterDBWeight: TcxGridDBColumn;
    lbWeight: TLabel;
    lbTotalWeight: TLabel;
    quMinExtWeight: TCurrencyField;
    quSalesExtWeight: TCurrencyField;
    quPreSalesExtWeight: TCurrencyField;
    quRequestExtWeight: TCurrencyField;
    quAllInventoryExtWeight: TCurrencyField;
    cdsRequestExtWeight: TCurrencyField;
    grdPOFilterDBExtWeight: TcxGridDBColumn;
    quPreSalesQtyOnOrder: TFloatField;
    lbMinPO: TLabel;
    lbMinAmount: TLabel;
    quMinBarcode: TStringField;
    quSalesBarcode: TStringField;
    quPreSalesBarcode: TStringField;
    quRequestBarcode: TStringField;
    quAllInventoryBarcode: TStringField;
    cdsRequestBarcode: TStringField;
    grdPOFilterDBBarcode: TcxGridDBColumn;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btDetailClick(Sender: TObject);
    procedure btNavigateClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
    procedure cmbListChange(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btnAllVendorClick(Sender: TObject);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btPOGroupClick(Sender: TObject);
    procedure btPOColumnClick(Sender: TObject);
    procedure grdPOFilterDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdPOFilterDBCustomization(Sender: TObject);
    procedure grdPOFilterDBFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btRemoveItemClick(Sender: TObject);
    procedure dtsPODataChange(Sender: TObject; Field: TField);
    procedure btCreatePOClick(Sender: TObject);
    procedure dtsPOItemDataChange(Sender: TObject; Field: TField);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsPOItemAfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btExportClick(Sender: TObject);
    procedure dtsRequestDataChange(Sender: TObject; Field: TField);
    procedure btnItemsDetailClick(Sender: TObject);
    procedure cdsRequestAfterOpen(DataSet: TDataSet);
    procedure cdsPOItemAfterOpen(DataSet: TDataSet);
    procedure grdPOFilterDBKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsRequestBeforePost(DataSet: TDataSet);
    procedure cdsPOItemBeforeEdit(DataSet: TDataSet);
    procedure grdPOItemDBKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quMinCalcFields(DataSet: TDataSet);
    procedure dtSaleChange(Sender: TObject);
    procedure scVendorSelectItem(Sender: TObject);
    procedure grdPOFilterDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cdsRequestCalcFields(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    iDaySales : Integer;
    iPOType: Integer;
    sNext,
    sBack,
    sDay,
    sFinish,
    sCreatePO,
    sBuild,
    sCase,
    sUnit: String;
    FLogError: TStringList;
    FInsertingRequest: Boolean;
    FPOItemOldCost: Double;
    FPOItemOldQty: Double;
    FIDModelActual : Integer;

    FOrderTotal : Currency;
    FWeightTotal : Currency;
    FMinOC : Currency;

    FUpdate : Boolean;

    sSQL       : WideString;
    sSQLMin    : WideString;
    sSQLReq    : WideString;
    sSQLPreSal : WideString;
    sSQLSale   : WideString;
    sSQLInv    : WideString;

    procedure ConfigGrouping(AGroup: Boolean; AView: TcxCustomGridTableView);
    procedure ConfigColumns(AView: TcxCustomGridTableView);
    procedure RefreshControl;
    procedure RefreshPOItemControls(IDModel, IDStore, IDVendor : Integer);
    procedure RefreshDetail;

    procedure RefreshRequest;

    procedure RefreshSelection;

    procedure CreateAutoPO;
    procedure CreatePO;
    procedure CreatePOItem;
    procedure AddPO;
    procedure AddPOItem;

    procedure InsertAutoPO;
    function InsertPO : Integer;
    procedure InsertPOItem(AIDPO: Integer);

    procedure UpdatePOTotal(AIDVendor, AIDStore: Integer; AValue: Double);
    procedure UpdatePOItemQty(AQty: Double);
    procedure RemovePO(AIDVendor, AIDStore: Integer);

    procedure RemovePOItem;
    procedure SetPOItemFilter;
    function OnValidadeField: boolean;
    function ValidatesQtyMin(IDVendor, IDModel : String; QtyToOrder: Double): Boolean;
    function RefreshPrimaryVendor(Situation: Boolean): Boolean;
    procedure RefreshOrderTotal;

    function ValidateSingle : Boolean;

    function getSQL(iQuery : Integer):WideString;
  public
    function Start(iType : Integer): Boolean;
  end;

implementation

uses uDM, uDMGlobal, uFrmExport, uMsgBox, uMsgConstant, uSystemConst, uWebFunctions,
     uCharFunctions, uFrmPrintPO, uDateTimeFunctions, uNumericFunctions, uDebugFunctions;

{$R *.dfm}

procedure TFrmNewPOAuto.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmNewPOAuto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmNewPOAuto.Start(iType : Integer): Boolean;
var
  gsoOptions: TcxGridStorageOptions;
  sSaveViewName,
  sPOFilterRegistryPath,
  sPOItemRegistryPath: String;
begin
  gsoOptions := [gsoUseFilter, gsoUseSummary];

  iPOType := iType;

  // Grid options
  sPOFilterRegistryPath := MR_BRW_REG_PATH + Self.Caption + ' RequestList';
  DM.LoadGridFromRegistry(TcxGridDBTableView(grdPOFilterDB), sPOFilterRegistryPath, gsoOptions);

  sPOItemRegistryPath := MR_BRW_REG_PATH + Self.Caption + ' RequestListItem';
  DM.LoadGridFromRegistry(TcxGridDBTableView(grdPOItemDB), sPOItemRegistryPath, gsoOptions);

  sSQLMin    := quMin.CommandText;        //YAA April 30th, 2012 (Min/Max) --> CommandText adjusted in the DFM
  sSQLReq    := quRequest.CommandText;    //YAA April 30th, 2012: Leave for now (Auto-request)
  sSQLPreSal := quPreSales.CommandText;
  sSQLSale   := quSales.CommandText;        //YAA April 30th, 2012 (Sales Qty) --> CommandText adjusted in the DFM
  sSQLInv    := quAllInventory.CommandText; //YAA April 30th, 2012 (All Inventory) --> CommandText adjusted in the DFM

  scStore.LookUpValue := IntToStr(DM.fStore.ID);

  cdsPO.CreateDataSet;
  cdsPOItem.CreateDataSet;

  pgPOAuto.Height := Panel1.Top - 10;

  FMinOC := 0;
  cmbList.ItemIndex := 0;
  RefreshSelection;

  case iPOType of
    PO_SINGLE : begin
                btCreatePO.Visible := False;
                btNavigate.Caption := sFinish;
                btNavigate.Default := False;
                end;
    PO_MULTI  : begin
                btCreatePO.Visible := True;
                btNavigate.Caption := sNext;
                btNavigate.Default := True;
                end;
  end;

  FUpdate := True;

  Result := (ShowModal = mrOk);
  Close;

  DM.SaveGridToRegistry(TcxGridDBTableView(grdPOFilterDB), sPOFilterRegistryPath, True, gsoOptions);
  DM.SaveGridToRegistry(TcxGridDBTableView(grdPOItemDB), sPOItemRegistryPath, True, gsoOptions);
end;

procedure TFrmNewPOAuto.btDetailClick(Sender: TObject);
begin
  inherited;
  slModelDetail.Visible := not slModelDetail.Visible;
  RefreshDetail;
  if slModelDetail.Visible then
    with cdsPOItem do
      RefreshPOItemControls(FieldByName('IDModel').AsInteger,
                            FieldByName('IDStore').AsInteger,
                            FieldByName('IDVendor').AsInteger);
end;

procedure TFrmNewPOAuto.btNavigateClick(Sender: TObject);
begin
  inherited;
  if not OnValidadeField then
    Exit;

  case iPOType of
    PO_SINGLE:
    begin
      if ValidateSingle then
        if MsgBox(MSG_QST_CONFIRM_CREATE_PO, vbYesNo + vbQuestion) = vbYes then
        begin
          CreateAutoPO;
          InsertAutoPO;
          if FLogError.Text <> '' then
            MsgBox(FLogError.Text, vbCritical + vbOKOnly)
          else
            ModalResult := mrOk;
        end;
    end;

    PO_MULTI:
    begin
      if pgPOAuto.ActivePage = tsRevise then
      begin
        InsertAutoPO;
        if FLogError.Text <> '' then
          MsgBox(FLogError.Text, vbCritical + vbOKOnly)
        else
          ModalResult := mrOk;
      end
      else
      begin
        slModelDetail.Visible := False;
        RefreshDetail;
        pgPOAuto.ActivePage := tsRevise;
        CreateAutoPO;
        RefreshControl;
      end;
    end;
  end;
end;

procedure TFrmNewPOAuto.btBackClick(Sender: TObject);
begin
  inherited;
  pgPOAuto.ActivePage := tsPOFilter;
  RefreshControl;
end;

procedure TFrmNewPOAuto.RefreshControl;
begin
  RefreshPrimaryVendor(False);

  if iPOType = PO_MULTI then
    if pgPOAuto.ActivePage = tsPOFilter then
    begin
      btBack.Visible := False;
      cdsPOItem.Filtered := False;
      btNavigate.Caption := sNext;
    end
    else
    begin
      btBack.Visible := True;
      cdsPOItem.Filtered := True;
      btBack.Caption     := sBack;
      btNavigate.Caption := sFinish;
    end;
end;

procedure TFrmNewPOAuto.cmbListChange(Sender: TObject);
begin
  inherited;
  RefreshSelection;
end;

procedure TFrmNewPOAuto.RefreshRequest;
begin
  cdsRequest.Close;

  FOrderTotal := 0;
  FWeightTotal := 0;

  sSQL := getSQL(cmbList.ItemIndex);

  if StrToInt(scStore.LookUpValue) <> 0 then
  begin
    if dspRequest.DataSet.Name = 'quAllInventory' then
    begin
      sSQL := StringReplace(sSQL, ':IDStore1', scStore.LookUpValue, [rfReplaceAll]);
      sSQL := StringReplace(sSQL, ':IDStore2', scStore.LookUpValue, [rfReplaceAll]);
      sSQL := StringReplace(sSQL, ':IDStore3', scStore.LookUpValue, [rfReplaceAll]);
    end
    else
      sSQL := StringReplace(sSQL, ':IDStore', scStore.LookUpValue, [rfReplaceAll]);
  end
  else
  begin
    if dspRequest.DataSet.Name = 'quAllInventory' then
    begin
      sSQL := StringReplace(sSQL, ':IDStore1', 'Null', [rfReplaceAll]);
      sSQL := StringReplace(sSQL, ':IDStore2', 'Null', [rfReplaceAll]);
      sSQL := StringReplace(sSQL, ':IDStore3', 'Null', [rfReplaceAll]);
    end
    else
      sSQL := StringReplace(sSQL, ':IDStore', 'Null', [rfReplaceAll]);
  end;


  sSQL := StringReplace(sSQL, ':MovDate', QuotedStr(MyFormatDate(Trunc(dtSale.Date))), [rfReplaceAll]);

  if scCategory.LookUpValue <> '' then
    sSQL := StringReplace(sSQL, ':IDGroup', scCategory.LookUpValue, [rfReplaceAll])
  else
    sSQL := StringReplace(sSQL, ':IDGroup', 'Null', [rfReplaceAll]);

  if scGroup.LookUpValue <> '' then
    sSQL := StringReplace(sSQL, ':IDModelGroup', scGroup.LookUpValue, [rfReplaceAll])
  else
    sSQL := StringReplace(sSQL, ':IDModelGroup', 'Null', [rfReplaceAll]);

  if scSubGroup.LookUpValue <> '' then
    sSQL := StringReplace(sSQL, ':IDModelSubGroup', scSubGroup.LookUpValue, [rfReplaceAll])
  else
    sSQL := StringReplace(sSQL, ':IDModelSubGroup', 'Null', [rfReplaceAll]);

  if scFabricante.LookUpValue <> '' then
    sSQL := StringReplace(sSQL, ':IDFabricante', scFabricante.LookUpValue, [rfReplaceAll])
  else
    sSQL := StringReplace(sSQL, ':IDFabricante', 'Null', [rfReplaceAll]);

  if scVendor.LookUpValue <> '' then
    sSQL := StringReplace(sSQL, ':IDPessoa', scVendor.LookUpValue, [rfReplaceAll])
  else
    sSQL := StringReplace(sSQL, ':IDPessoa', 'Null', [rfReplaceAll]);

  if cmbList.ItemIndex = 1 then
    case cbxReqType.ItemIndex of
      0: sSQL := StringReplace(sSQL, ':Type', 'Null', [rfReplaceAll]);
      1: sSQL := StringReplace(sSQL, ':Type', QuotedStr('C'), [rfReplaceAll]);
      2: sSQL := StringReplace(sSQL, ':Type', QuotedStr('P'), [rfReplaceAll]);
      3: sSQL := StringReplace(sSQL, ':Type', QuotedStr('H'), [rfReplaceAll]);
    end;

  if cbxPrimaryVendor.Checked then
    sSQL := StringReplace(sSQL, ':VendorOrder', '1', [rfReplaceAll])
  else
    sSQL := StringReplace(sSQL, ':VendorOrder', 'Null', [rfReplaceAll]);

//  DebugToFile('search purchase: ' + sSQL);
  TADODataSet(dspRequest.DataSet).CommandText := sSQL;
  try
    Screen.Cursor := crHourGlass;
    cdsRequest.Open;
  finally
    RefreshOrderTotal;
    Screen.Cursor := crDefault;
  end;

end;

function TFrmNewPOAuto.getSQL(iQuery : Integer):WideString;
begin

  case iQuery of
    0:begin
        Result := sSQLMin;
      end;
    1:begin
        Result := sSQLReq;
      end;
    2:begin
        if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
          Result := sSQLPreSal
        else
          Result := sSQLSale;
      end;
    3:begin
        Result := sSQLInv;
      end;
  end;

end;

procedure TFrmNewPOAuto.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '<->';
end;

procedure TFrmNewPOAuto.btnAllVendorClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<->';
  RefreshPrimaryVendor(False);
  FMinOC := 0;
  lbMinAmount.Caption := FormatFloat('#,##0.00', FMinOC);
end;

procedure TFrmNewPOAuto.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<->';
end;

procedure TFrmNewPOAuto.btnGroupClearClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<->';
end;

procedure TFrmNewPOAuto.btnSubGroupClearClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<->';
end;

procedure TFrmNewPOAuto.btSearchClick(Sender: TObject);
begin
  inherited;
  RefreshRequest;
end;

procedure TFrmNewPOAuto.btSelectAllClick(Sender: TObject);
var
  FFinalCost : Currency;
begin
  inherited;
  with cdsRequest do
  try
    Cursor := crHourGlass;
    if Active then
    begin
      FUpdate := False;
      FOrderTotal := 0;
      FWeightTotal := 0;
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        if FieldByName('QtyToOrder').AsFloat > 0 then
        begin
          FieldByName('Marked').AsBoolean   := True;
          FFinalCost := FieldByName('FinalCost').AsCurrency;
          if FieldByName('CaseQty').AsFloat >= 2 then
            FFinalCost := FFinalCost * FieldByName('CaseQty').AsFloat;
          FieldByName('ExtCost').AsCurrency := (FieldByName('QtyToOrder').AsFloat * FFinalCost);
          FOrderTotal := FOrderTotal + FieldByName('ExtCost').AsCurrency;


          if FieldByName('CaseQty').AsFloat >= 2 then
            FieldByName('ExtWeight').AsCurrency := FieldByName('Weight').AsCurrency * FieldByName('QtyToOrder').AsFloat * FieldByName('CaseQty').AsFloat
          else
            FieldByName('ExtWeight').AsCurrency := FieldByName('Weight').AsCurrency * FieldByName('QtyToOrder').AsFloat;

          FWeightTotal := FWeightTotal + FieldByName('ExtWeight').AsCurrency;
        end
        else
        begin
          FieldByName('ExtCost').AsCurrency := 0;
          FieldByName('ExtWeight').AsCurrency := 0;
        end;
        Post;
        Next;
      end;
      First;
    end;
  finally
    FUpdate := True;
    RefreshOrderTotal;
    EnableControls;
    Cursor := crDefault;
  end;
end;

procedure TFrmNewPOAuto.btUnSelectAllClick(Sender: TObject);
begin
  inherited;
  with cdsRequest do
  try
    Cursor := crHourGlass;
    if Active then
    begin
      FUpdate := False;
      FOrderTotal := 0;
      FWeightTotal := 0;
      DisableControls;
      First;
      while not EOF DO
      begin
        Edit;
        FieldByName('Marked').AsBoolean := False;
        FieldByName('ExtCost').AsCurrency := 0;
        FieldByName('ExtWeight').AsCurrency := 0;
        Post;
        Next;
      end;
      First;
    end;
  finally
    RefreshOrderTotal;
    EnableControls;
    FUpdate := True;
    Cursor := crDefault;
  end;
end;

procedure TFrmNewPOAuto.FormCreate(Sender: TObject);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sNext     := 'Next >>';
      sBack     := '<< Back';
      sFinish   := 'Finish';
      sCreatePO := 'Creating PO # %S for %S : ';
      sBuild    := 'Building PO :';
      sCase     := 'Case';
      sUnit     := 'Unit';
      sDay      := 'Day';
    end;

    LANG_PORTUGUESE :
    begin
      sNext     := 'Próximo >>';
      sBack     := '<< Voltar';
      sFinish   := 'Finalizar';
      sCreatePO := 'Criando OC Nº %S para %S : ';
      sBuild    := 'Construindo OC :';
      sCase     := 'Caixa';
      sUnit     := 'Unidade';
      sDay      := 'Dia(s)';
    end;

    LANG_SPANISH :
    begin
      sNext     := 'Después >>';
      sBack     := '<< Posterior';
      sFinish   := 'Final';
      sCreatePO := 'Criando OC Nº %S para %S : ';
      sBuild    := 'Construya OC :';
      sCase     := 'Caja';
      sUnit     := 'Unidade';
      sDay      := 'Día(s)';
    end;
  end;

  DM.imgBTN.GetBitmap(BTN_GROUPING, btPOGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btPOColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExport.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemoveItem.Glyph);

  FLogError := TStringList.Create;
  slModelDetail.CreateSubList;

  dtSale.Date := (Now-30);

end;

procedure TFrmNewPOAuto.btPOGroupClick(Sender: TObject);
begin
  inherited;
  ConfigGrouping(btPOGroup.Down, grdPOFilterDB);
end;

procedure TFrmNewPOAuto.btPOColumnClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdPOFilterDB);
end;

procedure TFrmNewPOAuto.grdPOFilterDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(grdPOFilterDB).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TFrmNewPOAuto.grdPOFilterDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(grdPOFilterDB).Controller.Customization;
end;

procedure TFrmNewPOAuto.grdPOFilterDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  TcxGridDBTableView(grdPOFilterDB).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TFrmNewPOAuto.UpdatePOTotal(AIDVendor, AIDStore: Integer; AValue: Double);
begin
  with cdsPO do
  begin
    Locate('IDVendor;IDStore', VarArrayOf([AIDVendor, AIDStore]), []);
    Edit;
    FieldByName('Total').AsFloat := FieldByName('Total').AsFloat + AValue;
    Post;
  end;
end;

procedure TFrmNewPOAuto.UpdatePOItemQty(AQty: Double);
begin
  with cdsPOItem do
  begin
    Edit;

    if cdsPOItem.FieldByName('CaseQty').AsInteger > 1 then
    begin
      FieldByName('QtyOrdered').AsFloat := FieldByName('QtyOrdered').AsFloat + (AQty * cdsRequest.FieldByName('CaseQty').AsFloat);
      FieldByName('CaseQtyOrdered').AsFloat := FieldByName('CaseQtyOrdered').AsFloat + Aqty;
    end
    else
      FieldByName('QtyOrdered').AsFloat := FieldByName('QtyOrdered').AsFloat + AQty;

    Post;
  end;
end;

procedure TFrmNewPOAuto.RemovePO(AIDVendor, AIDStore: Integer);
begin
  with cdsPO do
  begin
    First;
    if Locate('IDVendor;IDStore', VarArrayOf([AIDVendor, AIDStore]), []) then
      Delete;
  end;
end;

procedure TFrmNewPOAuto.RemovePOItem;
var
  iIDVendor, iIDStore: Integer;
begin
  with cdsPOItem do
  begin
    iIDVendor := FieldByName('IDVendor').AsInteger;
    iIDStore := FieldByName('IDStore').AsInteger;
    UpdatePOTotal(iIDVendor, iIDStore, ((FieldByName('CostPrice').AsFloat * FieldByName('QtyOrdered').AsFloat)*(-1)));
    Delete;

    First;
    if not Locate('IDVendor', VarArrayOf([iIDVendor, iIDStore]), []) then
      RemovePO(iIDVendor, iIDStore);
  end;

  SetPOItemFilter;
end;

procedure TFrmNewPOAuto.btRemoveItemClick(Sender: TObject);
begin
  inherited;
  with cdsPOItem do
    RemovePOItem;
end;

procedure TFrmNewPOAuto.SetPOItemFilter;
begin
  with cdsPO do
    if not FieldByName('IDVendor').IsNull then
      cdsPOItem.Filter := 'IDVendor = ' + FieldByName('IDVendor').AsString +
                          ' AND IDStore = ' + FieldByName('IDStore').AsString;
end;

procedure TFrmNewPOAuto.dtsPODataChange(Sender: TObject; Field: TField);
begin
  inherited;
  SetPOItemFilter;
end;

procedure TFrmNewPOAuto.btCreatePOClick(Sender: TObject);
begin
  inherited;
  CreateAutoPO;;
end;

procedure TFrmNewPOAuto.RefreshPOItemControls(IDModel, IDStore, IDVendor : Integer);
begin
  slModelDetail.Param := 'IDModel=' + IntToStr(IDModel) +
                         ';IDStore=' + IntToStr(IDStore) +
                         ';IDVendor=' + IntToStr(IDVendor)+';';
end;

procedure TFrmNewPOAuto.dtsPOItemDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if slModelDetail.Visible then
    with cdsPOItem do
      RefreshPOItemControls(FieldByName('IDModel').AsInteger,
                            FieldByName('IDStore').AsInteger,
                            FieldByName('IDVendor').AsInteger);
end;

procedure TFrmNewPOAuto.ConfigGrouping(AGroup: Boolean; AView: TcxCustomGridTableView);
begin
  if AGroup then
  begin
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
  end
  else
  begin
    // Retiro todos os grupos
    while TcxGridDBTableView(AView).GroupedItemCount > 0 do
      TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex := -1;
    TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
  end;
end;

procedure TFrmNewPOAuto.ConfigColumns(AView: TcxCustomGridTableView);
begin
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmNewPOAuto.btGroupClick(Sender: TObject);
begin
  inherited;
  ConfigGrouping(btGroup.Down, grdPOItemDB);
end;

procedure TFrmNewPOAuto.btColumnClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdPOItemDB);
end;

procedure TFrmNewPOAuto.InsertAutoPO;
var
 sIDPOList : String;
begin
  sIDPOList := '';
  try
    pnlProgress.Visible := True;
    Screen.Cursor := crHourGlass;
    with cdsPO do
    begin
      First;
      while not Eof do
      begin
        sIDPOList := sIDPOList + IntToStr(InsertPO);
        Next;
        if not EOF then
           sIDPOList := sIDPOList + ',';
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    pnlProgress.Visible := False;
  end;

  if sIDPOList <> '' then
    with TFrmPrintPO.Create(Self) do
       Start(sIDPOList);
end;

function TFrmNewPOAuto.InsertPO: Integer;
var
  iIDPO: Integer;
begin
  iIDPO := DM.GetNextID('PO.IDPO');
  lbProgress.Caption := Format(sCreatePO, [IntToStr(iIDPO), cdsPO.FieldByName('Vendor').AsString]);
  Application.ProcessMessages;

  with cmdInsPO do
  try
    DM.ADODBConnect.BeginTrans;
    Parameters.ParamByName('IDPO').Value := iIDPO;
    Parameters.ParamByName('IDFornecedor').Value := cdsPO.FieldByName('IDVendor').AsInteger;
    Parameters.ParamByName('IDStore').Value := cdsPO.FieldByName('IDStore').AsInteger;
    Parameters.ParamByName('DataPedido').Value := cdsPO.FieldByName('DataPedido').AsDateTime;
    Parameters.ParamByName('Aberto').Value := True;
    Parameters.ParamByName('SubTotal').Value := cdsPO.FieldByName('Total').AsFloat;
    Parameters.ParamByName('EstArrival').Value := cdsPO.FieldByName('EstArrival').AsDateTime;
    Parameters.ParamByName('PayDays').Value := cdsPO.FieldByName('PayDays').AsInteger;
    Parameters.ParamByName('OBS').Value := cdsPO.FieldByName('Obs').AsString;
    Execute;

    pb.Max := cdsPOItem.RecordCount;
    pb.Position := 0;

    cdsPOItem.Filter := 'IDVendor = ' + cdsPO.FieldByName('IDVendor').AsString +
                        ' AND IDStore = ' + cdsPO.FieldByName('IDStore').AsString;
    cdsPOItem.Filtered := True;
    cdsPOItem.First;
    while not cdsPOItem.Eof do
    begin
      InsertPOItem(iIDPO);
      cdsPOItem.Next;
      pb.Position := pb.Position + 1;
    end;
    cdsPOItem.Filter := '';
    cdsPOItem.Filtered := False;

    DM.ADODBConnect.CommitTrans;
    Result := iIDPO;
  except
    on E: Exception do
    begin
      FLogError.Add(E.Message);
      DM.ADODBConnect.RollbackTrans;
      Result := 0;
    end;
  end;
end;

procedure TFrmNewPOAuto.InsertPOItem(AIDPO: Integer);
begin
  with cmdInsPOItem do
  begin
    Parameters.ParamByName('IDPreInventoryMov').Value := DM.GetNextID('PreInventoryMov.IDPreInventoryMov');
    Parameters.ParamByName('InventMovTypeID').Value := INV_MOVTYPE_BOUGHT;
    Parameters.ParamByName('StoreID').Value := cdsPOItem.FieldByName('IDStore').AsInteger;
    Parameters.ParamByName('ModelID').Value := cdsPOItem.FieldByName('IDModel').AsInteger;
    Parameters.ParamByName('IDPessoa').Value := cdsPOItem.FieldByName('IDVendor').AsInteger;
    Parameters.ParamByName('UserID').Value := DM.fUser.ID;
    Parameters.ParamByName('DocumentID').Value := AIDPO;
    Parameters.ParamByName('MovDate').Value := Now;
    Parameters.ParamByName('DateEstimatedMov').Value := Now + 7;
    Parameters.ParamByName('CostPrice').Value := cdsPOItem.FieldByName('CostPrice').AsFloat;
    Parameters.ParamByName('SalePrice').Value := cdsPOItem.FieldByName('SalePrice').AsFloat;
    Parameters.ParamByName('SuggRetail').Value := cdsPOItem.FieldByName('SuggRetail').AsFloat;

    if cdsPOItem.FieldByName('CaseQty').AsInteger > 1 then
    begin
      Parameters.ParamByName('Qty').Value := cdsPOItem.FieldByName('CaseQtyOrdered').AsFloat * cdsPOItem.FieldByName('CaseQty').AsFloat;
      Parameters.ParamByName('CaseQty').Value := cdsPOItem.FieldByName('CaseQtyOrdered').AsFloat;
      Parameters.ParamByName('CaseCost').Value := cdsPOItem.FieldByName('CostPrice').AsFloat * cdsPOItem.FieldByName('CaseQty').AsFloat;
    end
    else
    begin
      Parameters.ParamByName('Qty').Value := cdsPOItem.FieldByName('QtyOrdered').AsFloat;
      Parameters.ParamByName('CaseQty').Value := Null;
      Parameters.ParamByName('CaseCost').Value := Null;
    end;

    Execute;
  end;
end;

procedure TFrmNewPOAuto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FLogError);
end;

procedure TFrmNewPOAuto.cdsPOItemAfterPost(DataSet: TDataSet);
var
  dNewPOItemValue: Double;
begin
  inherited;
  if not FInsertingRequest then
    with cdsPOItem do
    begin
      dNewPOItemValue := (FieldByName('CostPrice').AsFloat * FieldByName('QtyOrdered').AsFloat) -
        (FPOItemOldCost*FPOItemOldQty);

      UpdatePOTotal(FieldByName('IDVendor').AsInteger,
        FieldByName('IDStore').AsInteger, dNewPOItemValue);
    end;
end;

procedure TFrmNewPOAuto.FormShow(Sender: TObject);
begin
  inherited;
  RefreshControl;
end;

procedure TFrmNewPOAuto.btExportClick(Sender: TObject);
begin
  inherited;
  if (not cdsPOItem.Active) or
     (cdsPOItem.RecordCount = 0) then
  begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
  end;

  with TFrmExport.Create(Self) do
    Start(grdPOItem, Self.Caption);
end;

procedure TFrmNewPOAuto.CreateAutoPO;
begin
  if cdsRequest.Active then
  try
    dtsPO.DataSet := nil;
    dtsPOItem.DataSet := nil;

    with cdsRequest do
    begin
      IndexDefs.Add('ixRequest', 'Marked;IDStore;IDVendor', []);
      AddIndex('ixRequest', 'Marked;IDStore;IDVendor', []);
      IndexName := 'ixRequest';

      Filtered := False;
      Filter := 'Marked <> 0';
      Filtered := True;
    end;

    try
      FInsertingRequest := True;
      pnlProgress.Visible := True;
      Screen.Cursor := crHourGlass;
      lbProgress.Caption := sBuild;

      CreatePO;
      CreatePOItem;
    finally
      Screen.Cursor := crDefault;
      pnlProgress.Visible := False;
      FInsertingRequest := False;
    end;

  finally
    with cdsRequest do
    begin
      IndexDefs.Delete(IndexDefs.IndexOf('ixRequest'));
      cdsRequest.DeleteIndex('ixRequest');
      IndexName := '';

      Filter := '';
      Filtered := False;
    end;

    dtsPO.DataSet := cdsPO;
    dtsPOItem.DataSet := cdsPOItem;
  end;
end;

procedure TFrmNewPOAuto.CreatePO;
begin
  with cdsRequest do
  try
    First;
    while not Eof do
    begin
      AddPO;
      Next;
    end;
  finally
  end;
end;

procedure TFrmNewPOAuto.CreatePOItem;
begin
  with cdsRequest do
  try
    First;
    pb.Position := 0;
    Application.ProcessMessages;

    while not Eof do
    begin
      AddPOItem;
      pb.Position := pb.Position + 1;
      Application.ProcessMessages;
      Next;
    end;
  finally
  end;
end;

procedure TFrmNewPOAuto.AddPO;
var
  iIDVendor, iIDStore: Integer;
begin
  with cdsPO do
  try
    DisableControls;
    iIDVendor := cdsRequest.FieldByName('IDVendor').AsInteger;
    iIDStore := cdsRequest.FieldByName('IDStore').AsInteger;

    if not Locate('IDVendor;IDStore', VarArrayOf([iIDVendor, iIDStore]), []) then
    begin
      Append;
      FieldByName('IDVendor').AsInteger    := iIDVendor;
      FieldByName('IDStore').AsInteger     := iIDStore;
      FieldByName('Vendor').AsString       := cdsRequest.FieldByName('Vendor').AsString;
      FieldByName('Store').AsString        := cdsRequest.FieldByName('Store').AsString;
      FieldByName('DataPedido').AsDateTime := Now;
      FieldByName('EstArrival').AsDateTime := Now + 7;
      FieldByName('PayDays').AsInteger     := 30;
      Post;
    end;
  finally
    EnableControls;
  end;
end;

procedure TFrmNewPOAuto.AddPOItem;
var
  iIDVendor, iIDStore, iIDModel: Integer;
begin
  with cdsPOItem do
  try
    DisableControls;
    iIDVendor := cdsRequest.FieldByName('IDVendor').AsInteger;
    iIDStore := cdsRequest.FieldByName('IDStore').AsInteger;
    iIDModel := cdsRequest.FieldByName('IDModel').AsInteger;

    if not Locate('IDVendor;IDStore;IDModel', VarArrayOf([iIDVendor, iIDStore, iIDModel]), []) then
    begin
      Append;
      FieldByName('IDVendor').AsInteger := iIDVendor;
      FieldByName('IDStore').AsInteger := iIDStore;
      FieldByName('IDModel').AsInteger := iIDModel;
      FieldByName('Model').AsString := cdsRequest.FieldByName('Model').AsString;
      FieldByName('Description').AsString := cdsRequest.FieldByName('Description').AsString;
      FieldByName('CostPrice').AsFloat := cdsRequest.FieldByName('FinalCost').AsFloat;
      FieldByName('SalePrice').AsFloat := cdsRequest.FieldByName('SellingPrice').AsFloat;
      FieldByName('SuggRetail').AsFloat := cdsRequest.FieldByName('MSRP').AsFloat;
      FieldByName('CaseQty').Value := cdsRequest.FieldByName('CaseQty').Value;

      if cdsPOItem.FieldByName('CaseQty').AsInteger > 1 then
      begin
        FieldByName('QtyOrdered').AsFloat := cdsRequest.FieldByName('QtyToOrder').AsFloat * cdsRequest.FieldByName('CaseQty').AsFloat;
        FieldByName('CaseQtyOrdered').AsFloat := cdsRequest.FieldByName('QtyToOrder').AsFloat;
        FieldByName('CaseCost').AsFloat := cdsRequest.FieldByName('FinalCost').AsFloat * cdsRequest.FieldByName('CaseQty').AsFloat;
      end
      else
      begin
        FieldByName('QtyOrdered').AsFloat := cdsRequest.FieldByName('QtyToOrder').AsFloat;
        FieldByName('CaseQtyOrdered').Clear;
        FieldByName('CaseCost').Clear;
      end;

      Post;
      UpdatePOTotal(iIDVendor, iIDStore, (FieldByName('CostPrice').AsFloat * FieldByName('QtyOrdered').AsFloat));
    end
    else
      UpdatePOItemQty(cdsRequest.FieldByName('QtyToOrder').AsFloat);
  finally
    EnableControls;
  end;
end;

procedure TFrmNewPOAuto.dtsRequestDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  if slModelDetail.Visible then
    with cdsRequest do
    begin
      if FIDModelActual <> FieldByName('IDModel').AsInteger then
        RefreshPOItemControls(FieldByName('IDModel').AsInteger,
                              FieldByName('IDStore').AsInteger,
                              FieldByName('IDVendor').AsInteger);
      FIDModelActual := FieldByName('IDModel').AsInteger;
    end;
end;

procedure TFrmNewPOAuto.RefreshDetail;
begin
  if slModelDetail.Visible then
    pgPOAuto.Height := slModelDetail.Top - 5
  else
    pgPOAuto.Height := Panel1.Top - 10;
end;

procedure TFrmNewPOAuto.btnItemsDetailClick(Sender: TObject);
begin
  inherited;
  slModelDetail.Visible := not slModelDetail.Visible;
  RefreshDetail;
  if slModelDetail.Visible then
    with cdsRequest do
      RefreshPOItemControls(FieldByName('IDModel').AsInteger,
                            FieldByName('IDStore').AsInteger,
                            FieldByName('IDVendor').AsInteger);
end;

procedure TFrmNewPOAuto.cdsRequestAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnItemsDetail.Enabled := (cdsRequest.RecordCount > 0);
end;

procedure TFrmNewPOAuto.cdsPOItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btRemoveItem.Enabled := cdsPOItem.RecordCount > 0;
end;

procedure TFrmNewPOAuto.grdPOFilterDBKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Return) and (grdPOFilterDBQtyToOrder.Focused) then
  with grdPOFilterDB.DataController do
  begin
    if not IsEOF then
      if grdPOFilterDBQtyToOrder.Focused then
      begin
        GotoNext;
        grdPOFilterDB.DataController.DataSet.FieldByName('QtyToOrder').FocusControl;
        grdPOFilterDB.DataController.DataSet.Edit;
        grdPOFilterDB.DataController.DataSet.FieldByName('QtyToOrder').Value :=
          grdPOFilterDB.DataController.DataSet.FieldByName('QtyToOrder').Value;
      end;
  end;  
end;

procedure TFrmNewPOAuto.cdsRequestBeforePost(DataSet: TDataSet);
var
  FFinalCost : Currency;
  FFinalWeight : Currency;
begin
  inherited;
  if FUpdate and (grdPOFilterDBQtyToOrder.Focused or grdPOFilterDBMarked.Focused) then
  with cdsRequest do
    begin
      if grdPOFilterDBQtyToOrder.Focused then
        FieldByName('Marked').AsBoolean := (FieldByName('QtyToOrder').AsFloat > 0);

      if FieldByName('Marked').AsBoolean then
      begin
        FOrderTotal := FOrderTotal - FieldByName('ExtCost').AsCurrency;
        FWeightTotal := FWeightTotal - FieldByName('ExtWeight').AsCurrency;

        FFinalCost := FieldByName('FinalCost').AsCurrency;
        if FieldByName('CaseQty').AsFloat >= 2 then
          FFinalCost := FFinalCost * FieldByName('CaseQty').AsFloat;

        FieldByName('ExtCost').AsCurrency := (FieldByName('QtyToOrder').AsFloat * FFinalCost);
        FOrderTotal := FOrderTotal + FieldByName('ExtCost').AsCurrency;

        if FieldByName('CaseQty').AsFloat >= 2 then
          FieldByName('ExtWeight').AsCurrency := FieldByName('Weight').AsCurrency * FieldByName('QtyToOrder').AsFloat * FieldByName('CaseQty').AsFloat
        else
          FieldByName('ExtWeight').AsCurrency := FieldByName('Weight').AsCurrency * FieldByName('QtyToOrder').AsFloat;

        FWeightTotal := FWeightTotal + FieldByName('ExtWeight').AsCurrency;
      end
      else
      begin
        FOrderTotal := FOrderTotal - FieldByName('ExtCost').AsCurrency;
        FWeightTotal := FWeightTotal - FieldByName('ExtWeight').AsCurrency;
        FieldByName('ExtCost').AsCurrency := 0;
      end;

    RefreshOrderTotal;
  end;
end;

procedure TFrmNewPOAuto.RefreshSelection;
begin

  case cmbList.ItemIndex of
    0:begin
        dspRequest.DataSet := quMin;
        cbxReqType.Visible := False;
      end;
    1:begin
        dspRequest.DataSet := quRequest;
        cbxReqType.Visible := True;
      end;
    2:begin
        if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
        begin
          dspRequest.DataSet := quPreSales;
        end
        else
        begin
          dspRequest.DataSet := quSales;
        end;
        cbxReqType.Visible := False;
      end;
    3:begin
        dspRequest.DataSet := quAllInventory;
        cbxReqType.Visible := False;
      end;
  end;

end;

procedure TFrmNewPOAuto.cdsPOItemBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not FInsertingRequest then
  begin
    FPOItemOldCost := cdsPOItem.FieldByName('CostPrice').AsFloat;
    FPOItemOldQty := cdsPOItem.FieldByName('QtyOrdered').AsFloat;
  end;
end;

procedure TFrmNewPOAuto.grdPOItemDBKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Return) and (grdPOItemDBQtyOrdered.Focused or //grdPOItemDBCaseQtyOrdered.Focused or
     grdPOItemDBCostPrice.Focused or grdPOItemDBSalePrice.Focused or grdPOItemDBSuggRetail.Focused) then
  with cdsPOItem do
  begin
    Next;
    if not Eof then
      if grdPOItemDBQtyOrdered.Focused then
        FieldByName('QtyOrdered').FocusControl
      else if grdPOItemDBCostPrice.Focused then
        FieldByName('CostPrice').FocusControl
      else if grdPOItemDBSalePrice.Focused then
        FieldByName('SalePrice').FocusControl
      else
        FieldByName('SuggRetail').FocusControl;
  end;
end;

procedure TFrmNewPOAuto.quMinCalcFields(DataSet: TDataSet);
begin
  inherited;

  with DataSet do
  begin
    if FieldByName('CaseQty').AsFloat > 1 then
       begin
       FieldByName('UnitType').aSString  := sCase;
       end
    else
       begin
       FieldByName('UnitType').asString  := sUnit;
       end;

    if iDaySales >= 1 then
    begin
      FieldByName('AvgSaleQty').AsFloat   := (FieldByName('QtySold').AsCurrency / iDaySales);
      FieldByName('AvgSaleWeek').AsFloat  := (FieldByName('AvgSaleQty').AsFloat * 7);
      FieldByName('AvgSaleMonth').AsFloat := (FieldByName('AvgSaleQty').AsFloat * 30);
    end;
  end;
  
end;

procedure TFrmNewPOAuto.dtSaleChange(Sender: TObject);
begin
  inherited;
  iDaySales := Trunc(Now - dtSale.Date);
  lbDay.Caption := IntToStr(iDaySales) + ' ' + sDay;
end;

function TFrmNewPOAuto.OnValidadeField: boolean;
begin
  Result := False;

  with cdsRequest do
  try
    Cursor := crHourGlass;
    if Active then
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        if cdsRequest.FieldByName('Marked').AsBoolean then
          if not(ValidatesQtyMin(cdsRequest.FieldByName('IDVendor').AsString , cdsRequest.FieldByName('IDModel').AsString, cdsRequest.FieldByName('QtyToOrder').AsFloat)) then
          begin
            MsgBox(MSG_INF_LESSER_MINIM_VENDOR + ' _ ' +  cdsRequest.FieldByName('Description').AsString, vbOkOnly + vbCritical);
            Exit;
          end;
       Next;
      end;
      First;
    end;
  finally
    EnableControls;
    Cursor := crDefault;
  end;

  Result := True;
end;

function TFrmNewPOAuto.ValidatesQtyMin(IDVendor, IDModel : String; QtyToOrder: Double): Boolean;
var
  qryQtyMin : TADOQuery;
begin
  Result := True;
  qryQtyMin := TADOQuery.Create(self);

  try
    with qryQtyMin do
    begin
      qryQtyMin.Connection := DM.ADODBConnect;
      SQL.Text := 'SELECT '+
                  ' MinQtyPO '+
                  'FROM '+
                  ' Inv_ModelVendor (NOLOCK) '+
                  'WHERE '+
                  ' IDPessoa = ' + IDVendor +
                  '	AND '+
                  ' IDModel = ' + IDModel;
      Open;

      Result := (FieldByName('MinQtyPO').AsFloat <= QtyToOrder);
    end;
  finally
    FreeAndNil(qryQtyMin);
    end;
end;

function TFrmNewPOAuto.RefreshPrimaryVendor(Situation: Boolean): Boolean;
begin
  cbxPrimaryVendor.Visible := Situation;
  cbxPrimaryVendor.Checked := True;
end;

procedure TFrmNewPOAuto.scVendorSelectItem(Sender: TObject);
var
  sAmount : String;
begin
  inherited;
  RefreshPrimaryVendor(True);

  if scVendor.LookUpValue <> '' then
    sAmount := DM.DescCodigo(['IDPessoa'], [QuotedStr(scVendor.LookUpValue)], 'Pessoa', 'Limite')
  else
    sAmount := '0';

  FMinOC := MyStrToCurrency(sAmount);
  lbMinAmount.Caption := FormatFloat('#,##0.00', FMinOC);

end;

procedure TFrmNewPOAuto.RefreshOrderTotal;
begin
  lbTotalOrder.Caption := FormatFloat('#,##0.00', FOrderTotal);
  lbTotalWeight.Caption := FormatFloat('#,##0.00', FWeightTotal);
end;

procedure TFrmNewPOAuto.grdPOFilterDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if cbShowLegend.Checked then
  begin
    if AViewInfo.GridRecord.Values[grdPOFilterDBQtyOnOrder.Index] > '0' then
      ACanvas.Font.Color := shpOnPO.Brush.Color;
  end
  else
  begin
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TFrmNewPOAuto.cdsRequestCalcFields(DataSet: TDataSet);
var
  dQtdCase: Double;
begin
  inherited;
  if cdsRequestQtyOnHand.AsFloat < 0 then
    if cdsRequestCaseQty.AsFloat > 0 then
    begin
      dQtdCase := Abs(cdsRequestQtyOnHand.AsFloat) / cdsRequestCaseQty.AsFloat;
      if Frac(dQtdCase) > 0 then
        cdsRequestQtyPositiveOrdered.AsFloat := Int(dQtdCase) + 1 + cdsRequestQtyToOrder.AsFloat
      else
        cdsRequestQtyPositiveOrdered.AsFloat := dQtdCase + cdsRequestQtyToOrder.AsFloat;
    end
    else
      cdsRequestQtyPositiveOrdered.AsFloat := Abs(cdsRequestQtyOnHand.AsFloat) + cdsRequestQtyToOrder.AsFloat;    
end;

function TFrmNewPOAuto.ValidateSingle: Boolean;
begin

  Result := True;

  if FMinOC <> 0 then
    if (FMinOC > FOrderTotal) then
      if MsgBox(MSG_QST_AMOUN_NOT_REACH_MIN_PO, vbYesNo + vbQuestion) = vbNo then
      begin
        Result := False;
        Exit;
      end;

end;

procedure TFrmNewPOAuto.spHelpClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      OpenURL('http://www.mainretail.com.br/treinamento/Compras/Com_NovaOC.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

procedure TFrmNewPOAuto.btnVideoClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
      if iPOType = PO_SINGLE then
        OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Auto_Gerar_OC_Simples/Criando_uma_Auto_Gerar_OC_Simples.htm')
      else
        OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Auto_Gerar_OC_Multipla/Criando_uma_Auto_Gerar_OC_Multipla.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

end.
