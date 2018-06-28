unit uFrmInventoryCount;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Grids, DBGrids, DBCtrls, StdCtrls, Mask,
  LblEffct, ExtCtrls, DBTables, DB, Variants,  uFrmBarcodeSearch,
  DateBox, Buttons, ADODB, SuperComboADO, siComp, siLangRT, ComCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, Provider, cxLookAndFeelPainters, Menus, cxButtons, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  mrBarCodeEdit, uCharFunctions;

const

  COUNTTYPE_INDEX_SELECTION  = 0;
  COUNTTYPE_INDEX_MANUAL     = 1;
  COUNTTYPE_INDEX_IMPORTFILE = 2;
  COUNTTYPE_INDEX_HANDHELD   = 3;

type

  TInventory = class
    fIDBarcode  : String;
    fModel      : String;
    fDate       : String;
    fTime       : String;
    fQty        : Double;
  end;

  TFrmInventoryCount = class(TFrmParent)
    dsModel: TDataSource;
    spAdjust: TADOStoredProc;
    spAdjustName: TStringField;
    spAdjustStoreID: TIntegerField;
    btAdjust: TButton;
    quModel: TADOQuery;
    quModelDataContagem: TDateTimeField;
    quModelCategory: TStringField;
    spHelp: TSpeedButton;
    pcBarcode: TPageControl;
    tsManual: TTabSheet;
    tsImport: TTabSheet;
    Panel4: TPanel;
    spOpen: TSpeedButton;
    edSeparator: TEdit;
    mFields: TMemo;
    lbTextField: TLabel;
    lbSeparetor: TLabel;
    Abrir: TOpenDialog;
    quBarcodeList: TADODataSet;
    cdsBarcodeList: TClientDataSet;
    quBarcodeListIDBarcode: TStringField;
    quBarcodeListCountDate: TDateTimeField;
    dsBarcodeList: TDataSource;
    dspBarcodeList: TDataSetProvider;
    cdsBarcodeListIDBarcode: TStringField;
    cdsBarcodeListCountDate: TDateTimeField;
    quFindBarcode: TADOQuery;
    quFindBarcodeIDBarcode: TStringField;
    quFindBarcodeStoreID: TIntegerField;
    btAdd: TBitBtn;
    cbFields: TComboBox;
    lbFields: TLabel;
    quBarcodeListIDModel: TIntegerField;
    cdsBarcodeListIDModel: TIntegerField;
    quFindBarcodeIDModel: TIntegerField;
    pgBarcodeOption: TPageControl;
    tsBarcode: TTabSheet;
    rgTypeImport: TRadioGroup;
    gridBarcodes: TcxGrid;
    gridBarcodesDB: TcxGridDBTableView;
    gridBarcodesDBIDBarcode: TcxGridDBColumn;
    gridBarcodesDBCounted: TcxGridDBColumn;
    gridBarcodesDBQtyOnHand: TcxGridDBColumn;
    gridBarcodesDBDiffer: TcxGridDBColumn;
    gridBarcodesDBCountDate: TcxGridDBColumn;
    gridBarcodesLevel1: TcxGridLevel;
    tsNotFound: TTabSheet;
    Memo1: TMemo;
    cbFilter: TComboBox;
    quBarcodeListQtyOnHand: TFloatField;
    cdsBarcodeListQtyOnHand: TFloatField;
    quFindBarcodeQtyOnHand: TFloatField;
    quModelQtyOnPreSale: TFloatField;
    quModelQtyOnHand: TFloatField;
    quModelQtyOnOrder: TFloatField;
    quModelQtyOnRepair: TFloatField;
    quBarcodeListCounted: TBCDField;
    quBarcodeListDiffer: TBCDField;
    cdsBarcodeListCounted: TBCDField;
    cdsBarcodeListDiffer: TBCDField;
    tsSelection: TTabSheet;
    tsHandHeld: TTabSheet;
    rgdCountType: TRadioGroup;
    btnNext: TButton;
    pnlPO: TPanel;
    pnlPODetail: TPanel;
    lbCountUser: TLabel;
    lbCountInfo: TLabel;
    lbCountDate: TLabel;
    lbCountStore: TLabel;
    DBEdit7: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    pnlPOToolBar: TPanel;
    btNewInvCount: TcxButton;
    btCloseInvCount: TcxButton;
    btDeleteInvCount: TcxButton;
    grdInvCount: TcxGrid;
    grdInvCountDB: TcxGridDBTableView;
    grdInvCountLevel: TcxGridLevel;
    pnlEspaco: TPanel;
    pnlPOItem: TPanel;
    Panel5: TPanel;
    btInvCountItemRemove: TSpeedButton;
    btInvCountItemPreview: TSpeedButton;
    btCustomizeColumns: TSpeedButton;
    btGroupItem: TSpeedButton;
    grdInvCountItem: TcxGrid;
    grdInvCountItemDB: TcxGridDBTableView;
    grdInvCountItemLevel: TcxGridLevel;
    lbCountDetail: TLabel;
    btnExport: TSpeedButton;
    popCountOption: TPopupMenu;
    menCyclecount: TMenuItem;
    menPhysicalcount: TMenuItem;
    menLiveCount: TMenuItem;
    menStartupStore: TMenuItem;
    dsInvCount: TDataSource;
    dsInvCountItem: TDataSource;
    quInvCount: TADODataSet;
    quInvCountItem: TADODataSet;
    quInvCountIDCount: TIntegerField;
    quInvCountSystemUser: TStringField;
    quInvCountStore: TStringField;
    quInvCountStartDate: TDateTimeField;
    quInvCountCountType: TIntegerField;
    quInvCountCountTypeName: TStringField;
    grdInvCountDBCountTypeName: TcxGridDBColumn;
    quInvCountItemIDCountItem: TIntegerField;
    quInvCountItemBarcode: TStringField;
    quInvCountItemSalePrice: TBCDField;
    quInvCountItemCountDate: TDateTimeField;
    quInvCountItemModel: TStringField;
    quInvCountItemDescription: TStringField;
    quInvCountItemQtyFrozen: TFloatField;
    grdInvCountItemDBBarcode: TcxGridDBColumn;
    grdInvCountItemDBQty: TcxGridDBColumn;
    grdInvCountItemDBSalePrice: TcxGridDBColumn;
    grdInvCountItemDBCountDate: TcxGridDBColumn;
    grdInvCountItemDBModel: TcxGridDBColumn;
    grdInvCountItemDBDescription: TcxGridDBColumn;
    grdInvCountItemDBQtyFrozen: TcxGridDBColumn;
    quInsInvCount: TADOCommand;
    quInsFrozeCount: TADOCommand;
    btnRefreshItem: TSpeedButton;
    quInvCountItemDifference: TFloatField;
    grdInvCountItemDBDifference: TcxGridDBColumn;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    quInvCountIDStore: TIntegerField;
    quInvCountIDUser: TIntegerField;
    Panel6: TPanel;
    btnPreviewBarcodeFile: TSpeedButton;
    btExportBarcodeFile: TSpeedButton;
    gridPrinterLinkBarcodeFile: TdxGridReportLink;
    quInvCountItemQty: TFloatField;
    quBarcodeListModel: TStringField;
    cdsBarcodeListModel: TStringField;
    gridBarcodesDBModel: TcxGridDBColumn;
    quModelSellingPrice: TBCDField;
    tcManualCount: TTabControl;
    Label1: TLabel;
    edtBarcode: TmrBarCodeEdit;
    btnSearchDesc: TBitBtn;
    Panel14: TPanel;
    lbLastItem: TLabel;
    lbSalePrice: TLabel;
    lbPriceResult: TLabel;
    lbHand: TLabel;
    lbCountScan: TLabel;
    lbOnHand: TLabel;
    lbScanned: TLabel;
    lbBarcode: TLabel;
    btPrint: TSpeedButton;
    pnlLastScan: TPanel;
    pnlModel: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    scModel: TSuperComboADO;
    DBEdit1: TDBEdit;
    scStore: TSuperComboADO;
    editDate: TDateBox;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    editQty: TEdit;
    rgType: TRadioGroup;
    lbNewHand: TLabel;
    lbNewOnHand: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btAdjustClick(Sender: TObject);
    procedure RefreshCombo(Sender: TObject);
    procedure Init;
    procedure spHelpClick(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure spOpenClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure cbFilterChange(Sender: TObject);
    procedure pcBarcodeChange(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure tsManualShow(Sender: TObject);
    procedure quInvCountCalcFields(DataSet: TDataSet);
    procedure tsHandHeldShow(Sender: TObject);
    procedure quInvCountAfterOpen(DataSet: TDataSet);
    procedure OnInvCountClick(Sender: TObject);
    procedure btDeleteInvCountClick(Sender: TObject);
    procedure btInvCountItemRemoveClick(Sender: TObject);
    procedure quInvCountItemAfterOpen(DataSet: TDataSet);
    procedure btnRefreshItemClick(Sender: TObject);
    procedure quInvCountItemCalcFields(DataSet: TDataSet);
    procedure btnExportClick(Sender: TObject);
    procedure btGroupItemClick(Sender: TObject);
    procedure btCustomizeColumnsClick(Sender: TObject);
    procedure btInvCountItemPreviewClick(Sender: TObject);
    procedure btCloseInvCountClick(Sender: TObject);
    procedure quInvCountAfterScroll(DataSet: TDataSet);
    procedure btnPreviewBarcodeFileClick(Sender: TObject);
    procedure btExportBarcodeFileClick(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure editQtyKeyPress(Sender: TObject; var Key: Char);
    procedure btPrintClick(Sender: TObject);
    procedure tcManualCountChange(Sender: TObject);

  private
    sCycleCount,
    sPhysCount,
    sLiveCount,
    sStartCount,
    sBarcode,
    sModel,
    sDate,
    sTime,
    sQty : String;
    fFrmBarcodeSearch : TFrmBarcodeSearch;
    FItemsBarcode : TStringList;
    Import        : Boolean;
    AView         : TcxCustomGridTableView;
    FScanned      : Double;
    function ValidateFields:Boolean;
    procedure Clear;
    procedure AddItemBarcode(Barcode, CodeDate, CodeTime, Model: String; Qty: Double);
    function FindBarcode(Barcode, Model: String):Boolean;
    procedure ViewItemsBarcode;

    procedure SetInicialTab;
    procedure SetActiveTab(Tab : TTabSheet);
    procedure Save;

    procedure OpenInvCount;
    procedure CloseInvCount;
    procedure RefreshInvCount;

    procedure OpenInvCountItem;
    procedure CloseInvCountItem;
    procedure RefreshInvCountItem;

    function ValidateInvCount(iCountType: Integer): Boolean;
    procedure NewInvCount(iCountType: Integer);
    procedure DeleteInvCount;
    procedure DeleteInvCountItem;

    procedure AdjustInventory(AIDModel, ACountType: Integer;
      ACountedQty: Double; AAdjustDate: TDateTime);
  public
    IsDetail : Boolean;
    function Start:Boolean;
  end;

var
  Import     : Boolean;
  iOnHand    : Double;
  iModel     : Integer;

implementation

uses uDM, uMsgBox, uMsgConstant, uNumericFunctions, uDMGlobal, uSystemConst,
     uFrmExport, uDMCloseCount, uCDSFunctions, uFrmBarcodePrint;

{$R *.DFM}

function TFrmInventoryCount.ValidateFields:Boolean;
begin
  Result := True;


    if scStore.Text = '' then
       begin
       MsgBox(MSG_CRT_NO_STORE_SELECTED, vbOkOnly + vbCritical);
       scStore.SetFocus;
       Result := False;
       Exit;
       end;


    if EditQty.Text = '' then
      begin
        MsgBox(MSG_CRT_NO_REAL_QTY, vbOkOnly + vbCritical);
        EditQty.SetFocus;
        Result := False;
        Exit;
      end;

    If (MyStrToFloat(EditQty.Text) = 0) and (rgType.ItemIndex = 0) then
      begin
        MsgBox(MSG_CRT_QTY_NO_ZERO, vbOkOnly + vbCritical);
        EditQty.SetFocus;
        Result := False;
        Exit;
      end;

end;



procedure TFrmInventoryCount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quModel.Close;
  Action := caFree;
  Clear;
end;

procedure TFrmInventoryCount.FormShow(Sender: TObject);
begin
  inherited;
  rgType.ItemIndex := 0;
  editDate.Date := now;
  scStore.LookUpValue := IntToStr(DM.fStore.ID);
end;

procedure TFrmInventoryCount.RefreshCombo(Sender: TObject);
begin

  lbLastItem.Caption    := '';
  lbBarcode.Caption     := '';
  lbPriceResult.Caption := FormatCurr('#,##0.00', 0);
  lbOnHand.Caption      := FormatCurr('0.##', 0);
  lbScanned.Caption     := FormatCurr('0.##', 0);
  lbNewOnHand.Caption   := FormatCurr('0.##', 0);

  if (scModel.LookUpValue <> '') and (scStore.LookUpValue <> '') then
   begin

     if not(DM.ModelRestored(StrToInt(scModel.LookUpValue))) then
      begin
        edtBarcode.Text := '';
        scModel.LookUpValue:= '';
        exit;
      end;

     with quModel do
       begin
         if Active then Close;
         Parameters.ParambyName('IDModel').Value := StrToInt(scModel.LookUpValue);
         Parameters.ParambyName('IDStore').Value := StrToInt(scStore.LookUpValue);
         Open;
         lbPriceResult.Caption := FormatCurr('#,##0.00', quModelSellingPrice.AsCurrency);
         lbOnHand.Caption      := FormatCurr('0.##', quModelQtyOnHand.AsFloat);
         if rgType.ItemIndex = 0 then
           lbNewOnHand.Caption   := FormatCurr('0.##', quModelQtyOnHand.AsFloat + FScanned)
         else
           lbNewOnHand.Caption   := FormatCurr('0.##', FScanned);
       end;

     btAdjust.Enabled := True;
     editQty.SetFocus;
   end;
end;

procedure TFrmInventoryCount.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmInventoryCount.btAdjustClick(Sender: TObject);
begin
  Save;
end;

procedure TFrmInventoryCount.Init;
begin
  with quModel do
    begin
      if Active then
         Close;
      Parameters.ParambyName('IDModel').Value := Null;
      Open;
    end;

  scModel.LookUpValue := '';
  scModel.SelectAll;

  edtBarcode.Clear;

  if edtBarcode.CanFocus then
    edtBarcode.SetFocus;

  editQty.Text := '';

  btAdjust.Enabled := False;

  
end;

procedure TFrmInventoryCount.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1840);
end;

procedure TFrmInventoryCount.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;

  with fFrmBarcodeSearch do
    begin
      R := Start;
      if R <> -1 then
        begin
          scModel.LookUpValue := IntToStr(R);
          RefreshCombo(Self);
        end;
    end;

end;

procedure TFrmInventoryCount.FormCreate(Sender: TObject);
begin
  inherited;
  pcBarcode.ActivePageIndex := COUNTTYPE_INDEX_SELECTION;

  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);
  DM.imgBTN.GetBitmap(BTN_PREVIEW, btPrint.Glyph);

  fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sCycleCount := 'Cycle Count';
           sPhysCount  := 'Physical Count';
           sLiveCount  := 'Live Count';
           sStartCount := 'Start up Count';
           sBarcode    := 'Barcode';
           sModel      := 'Model';
           sDate       := 'Date';
           sTime       := 'Time';
           sQty        := 'Qty';
           end;

     LANG_PORTUGUESE :
           begin
           sCycleCount := 'Contagem Ciclo';
           sPhysCount  := 'Contagem Física';
           sLiveCount  := 'Contagem Tempo Real';
           sStartCount := 'Contagem Inicial';
           sBarcode    := 'Cód. de barras';
           sModel      := 'Modelo';
           sDate       := 'Data';
           sTime       := 'Hora';
           sQty        := 'Qtde';
           end;

     LANG_SPANISH :
           begin
           sCycleCount := 'Contagem Ciclo';
           sPhysCount  := 'Contagem Física';
           sLiveCount  := 'Contagem Tempo Real';
           sStartCount := 'Contagem Inicial';
           sBarcode    := 'Cod. de barras';
           sModel      := 'Modelo';
           sDate       := 'Fecha';
           sTime       := 'Hora';
           sQty        := 'Cntd';
           end;
   end;

  DM.imgSmall.GetBitmap(BTN18_DELETE, btInvCountItemRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_PREVIEW, btInvCountItemPreview.Glyph);
  DM.imgSmall.GetBitmap(BTN18_PREVIEW, btnPreviewBarcodeFile.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroupItem.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btCustomizeColumns.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btnExport.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExportBarcodeFile.Glyph);
  DM.imgBTN.GetBitmap(BTN_REFRESH, btnRefreshItem.Glyph);

  AView := TcxCustomGridTableView(grdInvCountItem.FocusedView);

end;

procedure TFrmInventoryCount.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F2 : begin //Procurar por descricao
            btnSearchDesc.Click; 
            end;
  end;

end;

procedure TFrmInventoryCount.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fFrmBarcodeSearch);
  FreeAndNil(FItemsBarcode);
end;

procedure TFrmInventoryCount.spOpenClick(Sender: TObject);
var
  line, symbol: string;
  i,x,z,j: integer;
  Cod : Array[1..5] of String;
  ResultLine : Array[1..5] of String;
  FFile : TStringList;
  bHasModel : Boolean;

  procedure ClearVar;
  var
    i:integer;
  begin
    x := 1;
    z := 1;

    for i := 0 to 5 do
      Cod[i] := '';

    for i := 0 to 5 do
      ResultLine[i] := '';
  end;

begin
  if not Assigned(FItemsBarcode) then
    FItemsBarcode := TStringList.Create;

  Clear;
  ClearVar;
  line := '';
  bHasModel := False;

  FFile := TStringList.Create;

  if mFields.Lines.Count = 0 then
  begin
    MsgBox(MSG_INF_SELECT_FIELD, vbOkOnly + vbCritical);
    exit;
  end;

  if edSeparator.Text = '' then
    symbol := #9
  else
    symbol := edSeparator.Text[1];

  if mFields.Lines.Count > 0 then
  begin
    if Abrir.Execute then
      FFile.LoadFromFile(Abrir.FileName);

    Screen.Cursor := crHourGlass;

    for i := 0 to FFile.Count -1 do
    begin
      line := Trim(FFile.Strings[i]);

      while x <= length(line) do
      begin
        if line[x] = symbol then
        begin
          inc(z);
          inc(x);
        end
        else
        begin
          Cod[z] := Cod[z] + line[x];
          inc(x);
        end
      end;

      for j := 0 to mFields.Lines.Count-1 do
      begin
        if mFields.Lines[j] = sBarcode then
          ResultLine[1] := Cod[j+1]
        else if mFields.Lines[j] = sDate then
          ResultLine[2] := Cod[j+1]
        else if mFields.Lines[j] = sTime then
          ResultLine[3] := Cod[j+1]
        else if mFields.Lines[j] = sQty then
          ResultLine[4] := Cod[j+1]
        else if mFields.Lines[j] = sModel then
        begin
          ResultLine[5] := Cod[j+1];
          bHasModel := True;
        end;
      end;

      AddItemBarcode(ResultLine[1], ResultLine[2], ResultLine[3], ResultLine[5], StrToFloatDef(ResultLine[4], 1));
      ClearVar;
    end;

    Screen.Cursor := crDefault;
    FreeAndNil(FFile);
  end;

  if bHasModel then
    gridBarcodesDB.DataController.KeyFieldNames := 'Model'
  else
    gridBarcodesDB.DataController.KeyFieldNames := 'IDBarcode';

  ViewItemsBarcode;
  btAdjust.Enabled := True;
end;

procedure TFrmInventoryCount.AddItemBarcode(Barcode, CodeDate, CodeTime, Model: String;
  Qty: Double);
var
  ItemInvent  : TInventory;
  ResultIndex : Integer;
  Friend      : Boolean;
begin
  if Model = '' then
    ResultIndex := FItemsBarcode.IndexOf(Barcode)
  else
    ResultIndex := FItemsBarcode.IndexOf(Model);
    
  friend := ResultIndex = -1;

  if friend then
  begin
    ItemInvent := TInventory.Create;

    if CodeDate = '' then
      CodeDate := DatetoStr(Date);

    if CodeTime = '' then
      CodeTime := TimetoStr(Time);

    with ItemInvent do
    begin
      fIDBarcode := Barcode;
      FModel     := Model;
      fDate      := CodeDate;
      fTime      := CodeTime;
      fQty       := Qty;
    end;

    if Model = '' then
      FItemsBarcode.AddObject(Barcode, ItemInvent)
    else
      FItemsBarcode.AddObject(Model, ItemInvent);
  end
  else
  begin
    TInventory(FItemsBarcode.Objects[ResultIndex]).fQty :=
      TInventory(FItemsBarcode.Objects[ResultIndex]).fQty + Qty;
  end;
end;

procedure TFrmInventoryCount.Clear;
var
  i: integer;
  ItemInvent : TInventory;
begin

  if not(FItemsBarcode = Nil) then
  begin
    for i:=0 to FItemsBarcode.Count-1 do
    begin
      ItemInvent := TInventory(FItemsBarcode.Objects[i]);
      FreeAndNil(ItemInvent);
    end;

    FItemsBarcode.Clear;
  end;

  Memo1.Lines.Clear;
  if cdsBarcodeList.Active then
    cdsBarcodeList.Close;   
end;

procedure TFrmInventoryCount.btAddClick(Sender: TObject);
var
  sTemp : String;
begin
  if cbFields.ItemIndex > -1 then
    if mFields.Lines.Count < 4 then
    begin
      sTemp := cbFields.Text;
      mFields.Lines.Add(cbFields.Text);

      cbFields.Items.Delete(cbFields.ItemIndex);

      if sTemp = sModel then
        cbFields.Items.Delete(cbFields.Items.IndexOf(sBarcode))
      else if sTemp = sBarcode then
        cbFields.Items.Delete(cbFields.Items.IndexOf(sModel));

    end  
    else
      MsgBox(MSG_CRT_EXCEEDED_ITEMS, vbOkOnly + vbCritical)
  else  if mFields.Lines.Count < 4 then MsgBox(MSG_CRT_NO_VALID_ITEM, vbOkOnly + vbCritical)
  else  MsgBox(MSG_CRT_EXCEEDED_ITEMS, vbOkOnly + vbCritical);
end;

function TFrmInventoryCount.FindBarcode(Barcode, Model: String): Boolean;
var
  friend : boolean;
  sIDStore : String;
begin
  with quFindBarcode do
  try
    if Active then
      Close;

    if (scStore.LookUpValue = '') then
      sIDStore := '0'
    else
      sIDStore := scStore.LookUpValue;

    if Trim(Model) = '' then
    begin
      quFindBarcode.SQL.Clear;
      quFindBarcode.SQL.Add('SELECT INV.QtyOnHand, Barcode.IDBarcode, StoreID, Barcode.IDModel');
      quFindBarcode.SQL.Add('FROM Barcode (NOLOCK) LEFT OUTER JOIN Inventory INV (NOLOCK) ON (INV.ModelID = Barcode.IDModel AND StoreID = ' + sIDStore + ')');
      quFindBarcode.SQL.Add('WHERE IDBarcode = '+ QuotedStr(Barcode));
    end
    else
    begin
      quFindBarcode.SQL.Clear;
      quFindBarcode.SQL.Add('SELECT INV.QtyOnHand, CAST('+QuotedStr('')+' as varchar(20)) as IDBarcode, INV.StoreID, M.IDModel');
      quFindBarcode.SQL.Add('FROM Model M (NOLOCK) LEFT OUTER JOIN Inventory INV (NOLOCK) ON (INV.ModelID = M.IDModel AND StoreID = ' + sIDStore + ')');
      quFindBarcode.SQL.Add('WHERE M.Model = ' + QuotedStr(Model));
    end;

    Open;

    iOnHand := quFindBarcodeQtyOnHand.AsFloat;
    iModel  := quFindBarcodeIDModel.AsInteger;
    if quFindBarcode.RecordCount = 0 then
      friend := False
    else
      friend := True;
  finally
    Close;
  end;

  Result := friend;
end;

procedure TFrmInventoryCount.ViewItemsBarcode;
var
  i: Integer;
  QtyBarcode: Double;
  NumBarcode: String;
  ModelNum : String;
  DateBarcode: TDateTime;
begin
  for i:=0 to FItemsBarcode.Count-1 do
   begin
    NumBarCode  := TInventory(FItemsBarcode.Objects[i]).fIDBarcode;
    ModelNum    := TInventory(FItemsBarcode.Objects[i]).fModel;
    QtyBarCode  := TInventory(FItemsBarcode.Objects[i]).fQty;
    DateBarcode := StrToDateTime(TInventory(FItemsBarcode.Objects[i]).fDate +' '+ TInventory(FItemsBarcode.Objects[i]).fTime);

    cdsBarcodeList.Open;

    if FindBarcode(NumBarCode, ModelNum) then
     begin
      with cdsBarcodeList do
       begin
        Append;
        cdsBarcodeListQtyOnHand.AsFloat    := iOnHand;
        cdsBarcodeListIDBarcode.AsString   := NumBarCode;
        cdsBarcodeListCounted.AsFloat      := QtyBarCode;
        cdsBarcodeListDiffer.AsFloat       := (Abs(iOnHand) - QtyBarCode);
        cdsBarcodeListCountDate.AsDateTime := DateBarcode;
        cdsBarcodeListIDModel.AsInteger    := iModel;
        cdsBarcodeListModel.AsString       := ModelNum;
        Post;
       end;
     end
    else
     Memo1.Lines.Add(NumBarCode + ' ' + ModelNum);
   end;
end;

procedure TFrmInventoryCount.cbFilterChange(Sender: TObject);
begin
  cdsBarcodeList.Filtered := True;

  case cbFilter.ItemIndex of
    0 : begin
        cdsBarcodeList.Filtered := False;
        cdsBarcodeList.Filter := '';
        end;
    1 : cdsBarcodeList.Filter := 'Counted > 0';
    2 : cdsBarcodeList.Filter := 'Counted < 0';
    3 : cdsBarcodeList.Filter := 'Counted = 0';
    4 : cdsBarcodeList.Filter := 'QtyOnHand > 0';
    5 : cdsBarcodeList.Filter := 'QtyOnHand < 0';
    6 : cdsBarcodeList.Filter := 'QtyOnHand = 0';
    7 : cdsBarcodeList.Filter := 'Differ  > 0';
    8 : cdsBarcodeList.Filter := 'Differ  < 0';
    9 : cdsBarcodeList.Filter := 'Differ <> 0';
    end;
end;

procedure TFrmInventoryCount.pcBarcodeChange(Sender: TObject);
begin
  if pcBarcode.TabIndex = COUNTTYPE_INDEX_IMPORTFILE then
   cbFields.SetFocus;
end;

function TFrmInventoryCount.Start: Boolean;
var
  AOptions : TcxGridStorageOptions;
  ASaveViewName : String;
  fRegistryPath : String;
begin
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  SetInicialTab;
  ShowModal;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

procedure TFrmInventoryCount.SetInicialTab;
begin
  tsSelection.TabVisible := True;
  tsManual.TabVisible    := False;
  tsImport.TabVisible    := False;
  tsHandHeld.TabVisible  := False;
end;

procedure TFrmInventoryCount.SetActiveTab(Tab : TTabSheet);
begin
  tsSelection.TabVisible := False;
  Tab.TabVisible         := True;
  btnNext.Visible        := False;
  btAdjust.Visible       := True;
  if Tab = tsHandHeld then
     btAdjust.Enabled := False;
end;

procedure TFrmInventoryCount.Save;
var
  i, iIDModel: Integer;
  dQtyCounted, dQtyOnHand: Double;
begin
  if pcBarcode.ActivePageIndex = COUNTTYPE_INDEX_IMPORTFILE then
  begin
    SetCDSIndex(cdsBarcodeList, 'IDMODEL_INDEX', ['IDModel'], []);
    try
      cdsBarcodeList.First;
      iIDModel := cdsBarcodeListIDModel.AsInteger;
      dQtyCounted := 0;
      while not cdsBarcodeList.Eof do
      begin
        if iIDModel <> cdsBarcodeListIDModel.AsInteger then
        begin
          AdjustInventory(iIDModel, rgTypeImport.ItemIndex+1, dQtyCounted, cdsBarcodeListCountDate.AsDateTime);
          dQtyCounted := cdsBarcodeListCounted.AsFloat;
        end
        else
          dQtyCounted := dQtyCounted + cdsBarcodeListCounted.AsFloat;

        iIDModel   := cdsBarcodeListIDModel.AsInteger;
        dQtyOnHand := cdsBarcodeListQtyOnHand.AsFloat;
        cdsBarcodeList.Next;
      end;

      AdjustInventory(iIDModel, rgTypeImport.ItemIndex+1, dQtyCounted, cdsBarcodeListCountDate.AsDateTime);
      btAdjust.Enabled := False;
      Clear;
    finally
      cdsBarcodeList.IndexName := '';
    end;
  end
  else if pcBarcode.ActivePageIndex = COUNTTYPE_INDEX_MANUAL then
  begin
    if not ValidateFields then
      Exit;

    AdjustInventory(StrToInt(scModel.LookUpValue), rgType.ItemIndex+1,
      MyStrToFloat(editQty.Text), editDate.Date);
    Init;
  end;

end;

procedure TFrmInventoryCount.btnNextClick(Sender: TObject);
var
  Tab: TTabSheet;
begin
  inherited;
  case rgdCountType.ItemIndex of
    0:
    begin
      Tab := tsManual;
      Init;
      tcManualCount.TabIndex := 1;
      tcManualCountChange(Self);
    end;
    1:Tab := tsImport;
    2:Tab := tsHandHeld;
  end;

  SetActiveTab(Tab);
end;

procedure TFrmInventoryCount.tsManualShow(Sender: TObject);
begin
  inherited;
  edtBarcode.SetFocus;
end;

procedure TFrmInventoryCount.quInvCountCalcFields(DataSet: TDataSet);
begin
  inherited;
  case quInvCountCountType.AsInteger of
    INV_COUNT_CYCLE   : quInvCountCountTypeName.AsString := sCycleCount;
    INV_COUNT_PHYSICAL: quInvCountCountTypeName.AsString := sPhysCount;
    INV_COUNT_LIVE    : quInvCountCountTypeName.AsString := sLiveCount;
    INV_COUNT_STARTUP : quInvCountCountTypeName.AsString := sStartCount;
  end;
end;

procedure TFrmInventoryCount.CloseInvCount;
begin
  with quInvCount do
    if Active then
      Close;
end;

procedure TFrmInventoryCount.OpenInvCount;
begin
  with quInvCount do
    if not Active then
      Open;
end;

procedure TFrmInventoryCount.RefreshInvCount;
begin
  CloseInvCount;
  OpenInvCount;
end;

procedure TFrmInventoryCount.tsHandHeldShow(Sender: TObject);
begin
  inherited;
  RefreshInvCount;
end;

procedure TFrmInventoryCount.CloseInvCountItem;
begin
  with quInvCountItem do
    if Active then
      Close;
end;

procedure TFrmInventoryCount.OpenInvCountItem;
begin
  with quInvCountItem do
    if not Active then
    begin
      Parameters.ParamByName('IDCount').Value := quInvCountIDCount.AsInteger;
      Open;
    end;
end;

procedure TFrmInventoryCount.RefreshInvCountItem;
begin
  CloseInvCountItem;
  OpenInvCountItem;
end;

procedure TFrmInventoryCount.quInvCountAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshInvCountItem;
  btDeleteInvCount.Enabled := quInvCount.RecordCount > 0;
  btCloseInvCount.Enabled := btDeleteInvCount.Enabled;
end;

procedure TFrmInventoryCount.DeleteInvCount;
var
  sSQL: String;
  bError : Boolean;
begin
  try
    DM.ADODBConnect.BeginTrans;

    sSQL := 'delete Inv_CountItem where IDCount = ' + quInvCountIDCount.AsString;
    bError := not DM.RunSQL(sSQL);

    sSQL := 'delete Inv_FrozeCount where IDCount = ' + quInvCountIDCount.AsString;
    if not bError then
      bError := not DM.RunSQL(sSQL);

    sSQL := 'delete Inv_Count where IDCount = ' + quInvCountIDCount.AsString;
    if not bError then
      bError := not DM.RunSQL(sSQL);

  finally
    if bError then
    begin
      DM.ADODBConnect.RollbackTrans;
      MsgBox(MSG_CRT_ERROR_OCURRED, vbCritical + vbOkOnly);
    end
    else
      DM.ADODBConnect.CommitTrans;
  end;
end;

procedure TFrmInventoryCount.DeleteInvCountItem;
var
  sSQL: String;
begin
  sSQL := 'delete Inv_CountItem where IDCountItem = ' + quInvCountItemIDCountItem.AsString;

  if not DM.RunSQL(sSQL) then
    MsgBox(MSG_CRT_NOT_DEL_PURCHASE, vbCritical + vbOkOnly);
end;

procedure TFrmInventoryCount.NewInvCount(iCountType: Integer);
var
  iIDInvCount: Integer;
  sSQLFroze: String;
begin
  iIDInvCount := DM.GetNextID('Inv_Count.IDCount');

  try
    Screen.Cursor := crHourGlass;
    try
      DM.ADODBConnect.BeginTrans;

      with quInsInvCount do
      begin
        Parameters.ParamByName('IDCount').Value := iIDInvCount;
        Parameters.ParamByName('StartDate').Value := Now;
        Parameters.ParamByName('CountType').Value := iCountType;
        Parameters.ParamByName('IDUser').Value := DM.fUser.ID;
        Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
        Execute;
      end;

      if iCountType <> INV_COUNT_LIVE then
        with quInsFrozeCount do
        begin
          Parameters.ParamByName('IDCount').Value := iIDInvCount;
          Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
          Execute;
        end;

      DM.ADODBConnect.CommitTrans;
    except
      on E: Exception do
      begin
        DM.ADODBConnect.RollbackTrans;
        //MsgBox(MSG_INF_ERROR + '_' + E.Message, vbCritical + vbOkOnly);
        MsgBox(MSG_INF_ERROR, vbCritical + vbOkOnly);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmInventoryCount.OnInvCountClick(Sender: TObject);
begin
  inherited;
  if ValidateInvCount(TMenuItem(Sender).Tag) then
  begin
    NewInvCount(TMenuItem(Sender).Tag);
    RefreshInvCount;
  end
  else
    MsgBox(MSG_INF_ERROR, vbInformation + vbOkOnly);
end;

function TFrmInventoryCount.ValidateInvCount(iCountType: Integer): Boolean;
begin
  if quInvCount.Active then
    Result := not quInvCount.Locate('CountType', iCountType, []);
end;

procedure TFrmInventoryCount.btDeleteInvCountClick(Sender: TObject);
begin
  inherited;
  if (quInvCount.RecordCount > 0) and (MsgBox(MSG_QST_DELETE, vbQuestion + vbYesNo) = vbYes) then
  begin
    DeleteInvCount;
    RefreshInvCount;
  end;
end;

procedure TFrmInventoryCount.btInvCountItemRemoveClick(Sender: TObject);
begin
  inherited;
  if quInvCountItem.RecordCount > 0 then
  begin
    DeleteInvCountItem;
    RefreshInvCountItem;
  end;
end;

procedure TFrmInventoryCount.quInvCountItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnRefreshItem.Enabled        := (quInvCount.RecordCount > 0);
  btInvCountItemRemove.Enabled  := (quInvCountItem.RecordCount > 0) and (quInvCountCountType.AsInteger <> INV_COUNT_LIVE);
  btInvCountItemPreview.Enabled := (quInvCount.RecordCount > 0);
  btnExport.Enabled             := (quInvCount.RecordCount > 0);
end;

procedure TFrmInventoryCount.btnRefreshItemClick(Sender: TObject);
begin
  inherited;
  RefreshInvCountItem;
end;

procedure TFrmInventoryCount.quInvCountItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  quInvCountItemDifference.AsFloat := quInvCountItemQty.AsFloat - quInvCountItemQtyFrozen.AsFloat;
end;

procedure TFrmInventoryCount.btnExportClick(Sender: TObject);
begin
  inherited;
  if (not quInvCountItem.Active) or (quInvCountItem.RecordCount = 0) then
  begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
  end;

 with TFrmExport.Create(Self) do
   Start(grdInvCountItem, Self.Caption);
end;

procedure TFrmInventoryCount.btGroupItemClick(Sender: TObject);
begin
  inherited;
  if not TcxGridDBTableView(AView).OptionsView.GroupByBox then
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True
  else
    with grdInvCountItem do
    begin
      // Retiro todos os grupos
      while TcxGridDBTableView(AView).GroupedItemCount > 0 do
        TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;

      TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
    end;
end;

procedure TFrmInventoryCount.btCustomizeColumnsClick(Sender: TObject);
begin
  inherited;
  // Mostra a coluna de customizing do grid
  TcxGridDBTableView(AView).Controller.Customization :=
    not TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmInventoryCount.btInvCountItemPreviewClick(Sender: TObject);
begin
  inherited;
  gridPrinterLink.Caption := lblSubMenu.Caption;
  gridPrinter.CurrentLink := gridPrinterLink;
  gridPrinter.Preview(True, nil);
end;

procedure TFrmInventoryCount.btCloseInvCountClick(Sender: TObject);
begin
  inherited;

  if quInvCount.FieldByName('CountType').AsInteger = INV_COUNT_PHYSICAL then
  begin
    if MsgBox(MSG_CRT_CLOSE_PHYSICAL_INV, vbSuperCritical + vbYesNo) = vbNo then
      Exit;
  end
  else if MsgBox(MSG_CRT_CLOSE_INVENTORY, vbSuperCritical + vbYesNo) = vbNo then
    Exit;

  with TDMCloseCount.Create(self) do
  try
    Screen.Cursor := crHourGlass;
    SQLConnection := DM.ADODBConnect;
    CloseInvCount(quInvCount.FieldByName('IDStore').AsInteger,
      quInvCount.FieldByName('IDCount').AsInteger,
      quInvCount.FieldByName('IDUser').AsInteger,
      quInvCount.FieldByName('CountType').AsInteger);
  finally
    Screen.Cursor := crDefault;
    if LogError.Text <> '' then
      MsgBox(LogError.Text, vbInformation + vbOKOnly);
    Free;
  end;

  RefreshInvCount;
  RefreshInvCountItem;
end;

procedure TFrmInventoryCount.quInvCountAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshInvCountItem;
end;

procedure TFrmInventoryCount.btnPreviewBarcodeFileClick(Sender: TObject);
begin
  inherited;
  if (not cdsBarcodeList.Active) or (cdsBarcodeList.RecordCount = 0) then
    Exit;

  gridPrinterLinkBarcodeFile.Caption := lblSubMenu.Caption;
  gridPrinter.CurrentLink := gridPrinterLinkBarcodeFile;
  gridPrinter.Preview(True, nil);
end;

procedure TFrmInventoryCount.btExportBarcodeFileClick(Sender: TObject);
begin
  inherited;
  If (not cdsBarcodeList.Active) or (cdsBarcodeList.RecordCount = 0) then
  begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
  end;

  with TFrmExport.Create(Self) do
    Start(gridBarcodes, Self.Caption);
end;

procedure TFrmInventoryCount.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel: Integer;
begin
  inherited;

  with edtBarcode do
  begin
    if SearchResult then
    begin
      IDModel := GetFieldValue('IDModel');
      scModel.LookUpValue := IntToStr(IDModel);
      FScanned            := StrToFloat(edtBarcode.QtyEdit.Text);
      RefreshCombo(nil);
      lbLastItem.Caption := scModel.Text + ' - ' + scModel.CodeValue;
      lbBarcode.Caption  := edtBarcode.Text;
      editQty.Text       := edtBarcode.QtyEdit.Text;
      lbScanned.Caption  := edtBarcode.QtyEdit.Text;
      FScanned           := 0;
      if tcManualCount.TabIndex = 0 then
        Save
      else
        begin
        editQty.SetFocus;
        editQty.SelectAll;
        end;
    end
    else
      begin
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
      edtBarcode.SelectAll;
      end;
  end;
end;

procedure TFrmInventoryCount.AdjustInventory(AIDModel, ACountType: Integer; ACountedQty: Double; AAdjustDate: TDateTime);
begin
  with spAdjust do
  begin
    Parameters.ParambyName('@IDStore').Value    := StrToInt(scStore.LookUpValue);
    Parameters.ParambyName('@IDUser').Value     := DM.fUser.ID;
    Parameters.ParambyName('@IDModel').Value    := AIDModel;
    Parameters.ParambyName('@CountType').Value  := ACountType;
    Parameters.ParambyName('@CountedQty').Value := ACountedQty;
    Parameters.ParambyName('@CountDate').Value  := AAdjustDate;
    ExecProc;
  end;
end;

procedure TFrmInventoryCount.editQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

procedure TFrmInventoryCount.btPrintClick(Sender: TObject);
var
  AFrmBarcodePrint : TFrmBarcodePrint;
begin
  inherited;

  if lbBarcode.Caption <> '' then
  try
    AFrmBarcodePrint := TFrmBarcodePrint.Create(Self);
    AFrmBarcodePrint.PrintBarcode(lbBarcode.Caption, 1);
  finally
    FreeAndNil(AFrmBarcodePrint);
  end;

end;

procedure TFrmInventoryCount.tcManualCountChange(Sender: TObject);
begin
  inherited;
  if tcManualCount.TabIndex = 0 then
  begin
    edtBarcode.Color    := $0080FFFF;
    lbNewHand.Visible   := True;
    lbNewOnHand.Visible := True;
  end
  else
  begin
    edtBarcode.Color    := $00FFE9D2;
    lbNewHand.Visible   := False;
    lbNewOnHand.Visible := False;
  end;

end;

end.
