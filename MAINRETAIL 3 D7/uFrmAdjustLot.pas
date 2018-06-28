unit uFrmAdjustLot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  DateBox, Mask, SuperComboADO, Buttons, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, ADODB, DBClient, Provider;

type
  TFrmAdjustLot = class(TFrmParent)
    lbManufect: TLabel;
    lbVerti: TLabel;
    lbHoriz: TLabel;
    lbCategory: TLabel;
    lbGroup: TLabel;
    lbStore: TLabel;
    lbSubGroup: TLabel;
    lbVendor: TLabel;
    lbSalePeriod: TLabel;
    lbDays: TLabel;
    edBarcode: TEdit;
    btSearch: TBitBtn;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    scColor: TSuperComboADO;
    scSize: TSuperComboADO;
    btnSizeClear: TButton;
    btnColorClear: TButton;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    scVendor: TSuperComboADO;
    btnVendorclear: TButton;
    dtIniLot: TDateBox;
    lbLot: TLabel;
    scLot: TSuperComboADO;
    btnlotClear: TButton;
    dtEndLot: TDateBox;
    Label1: TLabel;
    dspLot: TDataSetProvider;
    quLot: TADODataSet;
    quLotMarked: TBooleanField;
    cdsLot: TClientDataSet;
    dsLot: TDataSource;
    strepPredefined: TcxStyleRepository;
    cxMinMax: TcxStyle;
    GridTableViewStyleSheetRose: TcxGridTableViewStyleSheet;
    cmdStoreModelLot: TADOCommand;
    quLotIDModel: TIntegerField;
    quLotIDStore: TIntegerField;
    quLotIDLote: TIntegerField;
    quLotQtyStore: TBCDField;
    quLotModel: TStringField;
    quLotDescription: TStringField;
    quLotModelPrice: TBCDField;
    quLotManufacture: TStringField;
    quLotCategory: TStringField;
    quLotSubCategory: TStringField;
    quLotMGroup: TStringField;
    quLotLot: TStringField;
    quLotLotQty: TBCDField;
    quLotExpirationDate: TDateTimeField;
    quLotLotDate: TDateTimeField;
    scStore: TSuperComboADO;
    quLotLocation: TStringField;
    quLotQtyOnHand: TBCDField;
    quLotQtyOnPreSale: TBCDField;
    quLotQtyOnOrder: TBCDField;
    quLotQtyOnRepair: TBCDField;
    btnSave: TButton;
    Panel7: TPanel;
    Panel8: TPanel;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    Panel9: TPanel;
    Panel10: TPanel;
    cxGridLot: TcxGrid;
    cxGridLotDB: TcxGridDBTableView;
    cxGridLotDBMarked: TcxGridDBColumn;
    cxGridLotDBModel: TcxGridDBColumn;
    cxGridLotDBDescription: TcxGridDBColumn;
    cxGridLotDBModelPrice: TcxGridDBColumn;
    cxGridLotDBManufacture: TcxGridDBColumn;
    cxGridLotDBCategory: TcxGridDBColumn;
    cxGridLotDBSubCategory: TcxGridDBColumn;
    cxGridLotDBMGroup: TcxGridDBColumn;
    cxGridLotDBLot: TcxGridDBColumn;
    cxGridLotDBLotDate: TcxGridDBColumn;
    cxGridLotDBExpirationDate: TcxGridDBColumn;
    cxGridLotDBLocation: TcxGridDBColumn;
    cxGridLotDBLotQty: TcxGridDBColumn;
    cxGridLotDBQtyOnHand: TcxGridDBColumn;
    cxGridLotDBQtyOnPreSale: TcxGridDBColumn;
    cxGridLotDBQtyOnOrder: TcxGridDBColumn;
    cxGridLotDBQtyOnRepair: TcxGridDBColumn;
    cxGridLotDBQtyStore: TcxGridDBColumn;
    cxGridLotLevel: TcxGridLevel;
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure btnVendorclearClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btnSizeClearClick(Sender: TObject);
    procedure btnColorClearClick(Sender: TObject);
    procedure btnlotClearClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridLotDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxGridLotDBCustomization(Sender: TObject);
    procedure cxGridLotDBFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxGridLotDBKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
  private
    FIDStore: Integer;
    AView  : TcxCustomGridTableView;
    FHasChange : Boolean;
    procedure RefreshLot;
    procedure SaveLot;
  public
    function Start(AIDStore : Integer) : boolean;
  end;

implementation

uses uDM, DateUtils, uMsgBox, uMsgConstant, uFrmExport, uSystemConst, uDMGlobal,
  StrUtils, uCharFunctions, uDateTimeFunctions;

{$R *.dfm}

{ TFrmAdjustLot }

function TFrmAdjustLot.Start(AIDStore: Integer): boolean;
var
  AOptions: TcxGridStorageOptions;
  ASaveViewName, fRegistryPath : String;
begin
  FIDStore := AIDStore;
  scStore.LookUpValue := InttoStr(FIDStore);
  dtIniLot.Date := FirstDateMonth;
  dtEndLot.Date := LastDateMonth;
  FHasChange := False;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  ShowModal;

  Result := True;

  //Saval para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

end;

procedure TFrmAdjustLot.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<->';
end;

procedure TFrmAdjustLot.btnGroupClearClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<->';
end;

procedure TFrmAdjustLot.btnSubGroupClearClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<->';
end;

procedure TFrmAdjustLot.btnVendorclearClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<->';
end;

procedure TFrmAdjustLot.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '<->';
end;

procedure TFrmAdjustLot.btnSizeClearClick(Sender: TObject);
begin
  inherited;
  scSize.LookUpValue := '';
  scSize.Text := '<->';
end;

procedure TFrmAdjustLot.btnColorClearClick(Sender: TObject);
begin
  inherited;
  scColor.LookUpValue := '';
  scColor.Text := '<->';
end;

procedure TFrmAdjustLot.btnlotClearClick(Sender: TObject);
begin
  inherited;
  scLot.LookUpValue := '';
  scLot.Text := '<->';
end;

procedure TFrmAdjustLot.btSearchClick(Sender: TObject);
begin
  inherited;
  SaveLot;
  RefreshLot;
end;

procedure TFrmAdjustLot.RefreshLot;
var
 sSQL, sWhere, sCampo,
 sVendorJoin, sVendorFilterJoin : String;
begin

  sWhere            := ' M.Desativado = 0 AND S.IDStore = ' + IntToStr(FIDStore) + ' ' +
                       ' AND L.ExpirationDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtIniLot.Date)) +
                       ' AND L.ExpirationDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtEndLot.Date + 1));
  sVendorJoin       := '';
  sVendorFilterJoin := '';

  if Trim(edBarcode.Text) <> '' then
  begin
     Case cbxType.ItemIndex of
       0 : sCampo := 'M.Model %S ';
       1 : sCampo := 'M.Description %S ';
       2 : begin
           sVendorJoin := 'LEFT OUTER JOIN VendorModelCode VMC ON (M.IDModel = VMC.IDModel) ';
           sCampo      := 'M.IDModel IN (SELECT IDModel FROM VendorModelCode (NOLOCK) WHERE VendorCode %S )';
           end;
     end;

     Case cbxMethod.ItemIndex of
       0 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr(edBarcode.Text+'%')]);
       1 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text)]);
       2 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text+'%')]);
     end;
   end;

   if scVendor.LookUpValue <> '' then
   begin
     sVendorFilterJoin := ' LEFT OUTER JOIN Inv_ModelVendor MV ON (MV.IDModel = M.IDModel) ';
     sWhere := sWhere + ' AND MV.IDPessoa = ' + scVendor.LookUpValue;
   end;

   if scFabricante.LookUpValue <> '' then
     sWhere := sWhere + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;

   if scSize.LookUpValue <> '' then
     sWhere := sWhere + ' AND M.IDSize = ' + scSize.LookUpValue;

   if scColor.LookUpValue <> '' then
     sWhere := sWhere + ' AND M.IDColor = ' + scColor.LookUpValue;

   if scCategory.LookUpValue <> '' then
     sWhere   := sWhere + ' AND M.GroupID = ' + scCategory.LookUpValue;

   if scGroup.LookUpValue <> '' then
     sWhere   := sWhere + ' AND M.IDModelGroup = ' + scGroup.LookUpValue;

   if scSubGroup.LookUpValue <> '' then
     sWhere   := sWhere + ' AND M.IDModelSubGroup = ' + scSubGroup.LookUpValue;

   if scLot.LookUpValue <> '' then
     sWhere   := sWhere + ' AND IML.IDLote = ' + scLot.LookUpValue;

   sSQL := 'SELECT	CAST(0 as bit) as Marked, IML.IDModel, IML.IDStore, IML.IDLote, ' +
           'IML.Qty as QtyStore, M.Model, M.Description, M.SellingPrice as ModelPrice, '+
           'P.Pessoa as Manufacture, TG.Name as Category, MG.ModelGroup as SubCategory, '+
           'MGS.ModelSubGroup as MGroup, L.Lot, L.Qty as LotQty, L.ExpirationDate, '+
           'L.LotDate, IM.Location, IM.QtyOnHand, IM.QtyOnPreSale, IM.QtyOnOrder, IM.QtyOnRepair ' +

           'FROM Inv_StoreModelLot IML (NOLOCK) ' +
           'JOIN Model M (NOLOCK) ON (M.IDModel = IML.IDModel) ' +
           'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) ' +
           'JOIN Store S (NOLOCK) ON (S.IDStore = IML.IDStore) ' +
           'JOIN Inv_Lot L (NOLOCK) ON (L.IDLote = IML.IDLote) ' +
           'LEFT JOIN Inventory IM (NOLOCK) ON (IM.ModelID = IML.IDModel AND IM.StoreID = IML.IDStore) ' +
           'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) ' +
           'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup) '+
           'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante) ' +
           ' ' + sVendorJoin +
           ' ' + sVendorFilterJoin +

           ' WHERE M.ModelType in ('+QuotedStr('R')+', '+QuotedStr('S')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+') ' +
           ' AND ' + sWhere;

   quLot.Close;        
   quLot.CommandText := sSQL;

   try
     Screen.Cursor := crHourGlass;
     With cdsLot do
     begin
       Close;
       Open;
     end;
   finally
     Screen.Cursor := crDefault;
     end;

end;


procedure TFrmAdjustLot.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsLot.Close;
  Action := caFree;
end;

procedure TFrmAdjustLot.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmAdjustLot.FormCreate(Sender: TObject);
begin
  inherited;

  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);

  AView := TcxCustomGridTableView(cxGridLot.FocusedView);

end;

procedure TFrmAdjustLot.cxGridLotDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TFrmAdjustLot.cxGridLotDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmAdjustLot.cxGridLotDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TFrmAdjustLot.cxGridLotDBKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_Return) and (cxGridLotDBQtyStore.Focused) then
  with cxGridLotDB.DataController do
  begin
    if cxGridLotDBQtyStore.Focused then
    begin
      cxGridLotDB.DataController.DataSet.FieldByName('Marked').Value := True;
      FHasChange := True;
      if not IsEOF then
      begin
        GotoNext;
        cxGridLotDB.DataController.DataSet.FieldByName('QtyStore').FocusControl;
        cxGridLotDB.DataController.DataSet.Edit;
      end;
    end;
  end;

end;

procedure TFrmAdjustLot.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveLot;
  Close;
end;

procedure TFrmAdjustLot.SaveLot;
begin

  if cdsLot.Active and FHasChange then
    with cdsLot do
    try
      Screen.Cursor :=  crHourGlass;
      Filter := 'Marked = 1';
      Filtered := True;

      First;
      while not Eof do
      begin
        cmdStoreModelLot.Parameters.ParamByName('IDStore').Value := FieldByName('IDStore').AsFloat;
        cmdStoreModelLot.Parameters.ParamByName('IDModel').Value := FieldByName('IDModel').AsFloat;
        cmdStoreModelLot.Parameters.ParamByName('IDLote').Value  := FieldByName('IDLote').AsInteger;
        cmdStoreModelLot.Parameters.ParamByName('Qty').Value     := FieldByName('QtyStore').AsInteger;
        cmdStoreModelLot.Execute;
        Next;
      end;
    finally
      Filter := '';
      Filtered := False;
      Screen.Cursor :=  crDefault;
    end;

end;

procedure TFrmAdjustLot.btExcelClick(Sender: TObject);
begin
  inherited;

 If (not cdsLot.Active) or
    (cdsLot.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(cxGridLot, Self.Caption);
  
end;

procedure TFrmAdjustLot.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with cxGridLot do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex := -1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;
  
end;

procedure TFrmAdjustLot.btColumnClick(Sender: TObject);
begin
  inherited;

  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
  
end;

end.


