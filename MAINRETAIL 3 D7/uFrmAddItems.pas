unit uFrmAddItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodos, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  LblEffct, ADODB, Provider, DBClient, mrBarCodeEdit, Mask, SuperComboADO,
  SubListPanel, PaideTodosGeral;

type
  TDisplayColumns = set of (dcQty, dcSalePrice, dcCostPrice);
  TValidateValues = set of (vvQty, vvCostPrice, vvSellingPrice);

  TAddItem = class
    IDModel:      Integer;
    VendorCost:   Currency;
    SellingPrice: Currency;
    Tax:          Double;
    Qty:          Double;
  end;

  TFrmAddItems = class(TFrmParent)
    btSave: TButton;
    dsModelAdd: TDataSource;
    cdsModelAdd: TClientDataSet;
    cdsModelAddIDModel: TIntegerField;
    cdsModelAddQty: TFloatField;
    cdsModelAddSalePrice: TCurrencyField;
    cdsModelAddCostPrice: TCurrencyField;
    pnlFilter: TPanel;
    cdsModelAddModel: TStringField;
    cdsModelAddDescription: TStringField;
    spSalePrice: TADOStoredProc;
    pnlClient: TPanel;
    lblCategory: TLabel;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    lblGroup: TLabel;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    lblSubGroup: TLabel;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    quModelResult: TADODataSet;
    dsModelResult: TDataSource;
    quModelResultIDModel: TIntegerField;
    quModelResultModel: TStringField;
    quModelResultDescription: TStringField;
    quModelResultSellingPrice: TBCDField;
    quModelResultVendorCost: TBCDField;
    quModelResultIDGroup: TIntegerField;
    quModelResultName: TStringField;
    quModelResultIDModelGroup: TIntegerField;
    quModelResultModelGroup: TStringField;
    quModelResultIDModelSubGroup: TIntegerField;
    quModelResultModelSubGroup: TStringField;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    edBarcode: TEdit;
    quModelResultIDBarcode: TStringField;
    pnlModelAdd: TPanel;
    pnlModelResult: TPanel;
    grdModelResult: TcxGrid;
    grdModelResultTableView: TcxGridDBTableView;
    grdModelResultTableViewIDBarcode: TcxGridDBColumn;
    grdModelResultTableViewIDModel: TcxGridDBColumn;
    grdModelResultTableViewModel: TcxGridDBColumn;
    grdModelResultTableViewDescription: TcxGridDBColumn;
    grdModelResultTableViewSellingPrice: TcxGridDBColumn;
    grdModelResultTableViewVendorCost: TcxGridDBColumn;
    grdModelResultTableViewIDGroup: TcxGridDBColumn;
    grdModelResultTableViewName: TcxGridDBColumn;
    grdModelResultTableViewIDModelGroup: TcxGridDBColumn;
    grdModelResultTableViewModelGroup: TcxGridDBColumn;
    grdModelResultTableViewIDModelSubGroup: TcxGridDBColumn;
    grdModelResultTableViewModelSubGroup: TcxGridDBColumn;
    grdModelResultLevel: TcxGridLevel;
    pnlBtnModelAdd: TPanel;
    grdModelAdd: TcxGrid;
    grdModelAddTableView: TcxGridDBTableView;
    grdModelAddLevel: TcxGridLevel;
    pnlBtnModelResult: TPanel;
    lblModelResultTitle: TLabel;
    lblModelAddTitle: TLabel;
    btnAdd: TSpeedButton;
    btnAddAll: TSpeedButton;
    btnRemoveAll: TSpeedButton;
    btnRemove: TSpeedButton;
    btnSearch: TBitBtn;
    slModelDetail: TSubListPanel;
    btnShowDetails: TSpeedButton;
    Splitter: TSplitter;
    grdModelAddTableViewIDModel: TcxGridDBColumn;
    grdModelAddTableViewModel: TcxGridDBColumn;
    grdModelAddTableViewDescription: TcxGridDBColumn;
    grdModelAddTableViewQty: TcxGridDBColumn;
    grdModelAddTableViewCostPrice: TcxGridDBColumn;
    grdModelAddTableViewSalePrice: TcxGridDBColumn;
    pnlDivisoria2: TPanel;
    btnGroup: TSpeedButton;
    btnColumn: TSpeedButton;
    Panel4: TPanel;
    cdsModelAddTax: TFloatField;
    quModelResultCaseQty: TBCDField;
    quModelResultQty: TIntegerField;
    grdModelResultTableViewQty: TcxGridDBColumn;
    dspModelResult: TDataSetProvider;
    cdsModelResult: TClientDataSet;
    cdsModelResultIDModel: TIntegerField;
    cdsModelResultModel: TStringField;
    cdsModelResultDescription: TStringField;
    cdsModelResultSellingPrice: TBCDField;
    cdsModelResultVendorCost: TBCDField;
    cdsModelResultIDGroup: TIntegerField;
    cdsModelResultName: TStringField;
    cdsModelResultIDModelGroup: TIntegerField;
    cdsModelResultModelGroup: TStringField;
    cdsModelResultIDModelSubGroup: TIntegerField;
    cdsModelResultModelSubGroup: TStringField;
    cdsModelResultIDBarcode: TStringField;
    cdsModelResultCaseQty: TBCDField;
    cdsModelResultQty: TIntegerField;
    quModelResultManufacturer: TStringField;
    cdsModelResultManufacturer: TStringField;
    grdModelResultTableViewManufacturer: TcxGridDBColumn;
    cdsModelAddManufacturer: TStringField;
    grdModelAddTableViewManufacturer: TcxGridDBColumn;
    procedure btSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure grdModelResultTableViewDblClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnRemoveAllClick(Sender: TObject);
    procedure cdsModelAddAfterScroll(DataSet: TDataSet);
    procedure btnShowDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsModelResultDataChange(Sender: TObject; Field: TField);
    procedure btnAddAllClick(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure btnColumnClick(Sender: TObject);
    procedure cdsModelResultAfterScroll(DataSet: TDataSet);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure grdModelResultTableViewCustomization(Sender: TObject);
  private
    FID: Integer;
    FItemList: TList;
    FDisplayColumns: TDisplayColumns;
    FValidateValues: TValidateValues;
    FIDCliente: Integer;
    FIDModelActual: Integer;
    procedure PrepareDataSets;
    procedure DisplayColumns;
    procedure RefreshModelControls(AIDModel: Integer);
    procedure ConfigGrouping(AGroup: Boolean; AView: TcxCustomGridTableView);
    procedure ConfigColumns(AView: TcxCustomGridTableView);
    procedure AddModel;
    procedure GetPrices(AIDModel: Integer; var ACostPrice: Currency; var ASalePrice: Currency);
    function WasModelAdd(AIDModel: Integer): Boolean;
    function ValidateCaseQty: Boolean;
    function ValidateValues: Boolean;
  public
    function Start(AIDCliente: Integer; ADisplayColumns: TDisplayColumns; AValidateValues: TValidateValues): TList;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uSystemConst, StrUtils, uPassword;

{$R *.dfm}

{ TFrmAddItems }

procedure TFrmAddItems.PrepareDataSets;
begin
  cdsModelAdd.CreateDataSet;
  cdsModelAdd.Open;
  DM.quLookUpModelPack.Open;
end;

function TFrmAddItems.Start(AIDCliente: Integer; ADisplayColumns: TDisplayColumns;
  AValidateValues: TValidateValues): TList;
begin
  FItemList := TList.Create;
  FID := 1;
  FIDCliente := AIDCliente;
  FDisplayColumns := ADisplayColumns;
  FValidateValues := AValidateValues;
  PrepareDataSets;
  DisplayColumns;

  ShowModal;

  cdsModelAdd.Close;
  DM.quLookUpModelPack.Close;
  Result := FItemList;
end;

procedure TFrmAddItems.btSaveClick(Sender: TObject);
var
  Item: TAddItem;
begin
  inherited;

  if cdsModelAdd.IsEmpty then
    MsgBox(MSG_CRT_NO_MODEL_SELECTED, vbInformation + vbOkOnly)
  else if ValidateValues then
  begin
    with cdsModelAdd do
    try
      DisableControls;
      First;
      while not Eof do
      begin
        Item              := TAddItem.Create;
        Item.IDModel      := FieldByName('IDModel').AsInteger;
        Item.Qty          := FieldByName('Qty').AsFloat;
        Item.VendorCost   := FieldByName('CostPrice').AsFloat;
        Item.SellingPrice := FieldByName('SalePrice').AsFloat;
        Item.Tax          := FieldByName('Tax').AsFloat;

        FItemList.Add(Item);
        Next;
      end;
    finally
      First;
      EnableControls;
    end;

    Close;
  end;  
end;

procedure TFrmAddItems.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FItemList);
end;

procedure TFrmAddItems.DisplayColumns;
var
  bCanSeeCost: Boolean;
begin
  bCanSeeCost := Password.HasFuncRight(70);
  btnColumn.Enabled := bCanSeeCost;

  grdModelResultTableViewVendorCost.Hidden := (not (dcCostPrice in FDisplayColumns)) and (not bCanSeeCost);
  grdModelResultTableViewVendorCost.Visible := not grdModelResultTableViewVendorCost.Hidden;
  grdModelResultTableViewSellingPrice.Visible := (dcSalePrice in FDisplayColumns);

  grdModelAddTableViewCostPrice.Hidden := (not (dcCostPrice in FDisplayColumns)) and (not bCanSeeCost);
  grdModelAddTableViewCostPrice.Visible := not grdModelAddTableViewCostPrice.Hidden;
  grdModelAddTableViewSalePrice.Visible := (dcSalePrice in FDisplayColumns);
end;

procedure TFrmAddItems.GetPrices(AIDModel: Integer; var ACostPrice, ASalePrice: Currency);
var
  cStoreCost, cStoreSell, cStoreAvg, cCustomerDiscount, cPromoPrice: Currency;
begin
  cCustomerDiscount := 0;

  with spSalePrice do
  begin
    Parameters.ParambyName('@ModelID').Value        := AIDModel;
    Parameters.ParambyName('@IDStore').Value        := DM.fStore.ID;
    Parameters.ParambyName('@IDCustomer').Value     := FIDCliente;
    Parameters.ParambyName('@Discount').Value       := cCustomerDiscount;
    Parameters.ParambyName('@SpecialPriceID').Value := null;
    ExecProc;

    cStoreCost        := Parameters.ParambyName('@StoreCostPrice').Value;
    cStoreSell        := Parameters.ParambyName('@StoreSalePrice').Value;
    cStoreAvg         := Parameters.ParambyName('@StoreAvgCost').Value;
    cPromoPrice       := Parameters.ParambyName('@PromotionPrice').Value;
    cCustomerDiscount := Parameters.ParambyName('@Discount').Value;

    if DM.fStore.Franchase then
      ASalePrice := cStoreSell
    else
    begin
      if (cStoreSell <> 0) then
        ASalePrice := cStoreSell
      else
        ASalePrice := Parameters.ParambyName('@SalePrice').Value;
    end;

    ACostPrice := Parameters.ParambyName('@CostPrice').Value;
  end;
end;

procedure TFrmAddItems.btCloseClick(Sender: TObject);
begin
  inherited;
  FItemList.Clear;
  Close;
end;

procedure TFrmAddItems.btnAddClick(Sender: TObject);
begin
  inherited;
  if WasModelAdd(cdsModelResultIDModel.AsInteger) then
    MsgBox(MSG_CRT_NO_DUPLICATE_MODEL, vbInformation + vbOKOnly)
  else if not ValidateCaseQty then
    MsgBox(MSG_INF_QTY_NOT_DIF_MULT_CASE, vbCritical + vbOKOnly)
  else
    AddModel;
end;

function TFrmAddItems.WasModelAdd(AIDModel: Integer): Boolean;
begin
  with cdsModelAdd do
  begin
    Filtered := False;
    Filter := 'IDModel = ' + IntToStr(AIDModel);
    Filtered := True;
    Result := not IsEmpty;
    Filtered := False;
  end;
end;

procedure TFrmAddItems.btnSearchClick(Sender: TObject);
var
  sSQL, sWhere, sCampo : String;
begin
  inherited;
  sWhere := ' WHERE M.Desativado = 0 AND M.System = 0 AND M.Hidden = 0 ';
  sSQL   := '';
  sCampo := '';

  case cbxType.ItemIndex of
       0 :
         sCampo := 'B.IDBarcode %S ';
       1 :
         sCampo := 'M.Model %S ';
       2 :
         sCampo := 'M.Description %S ';
  end;

  case cbxMethod.ItemIndex of
       0 :
         sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr(edBarcode.Text+'%')]);
       1 :
         sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text)]);
       2 :
         sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text+'%')]);
  end;

  if scCategory.LookUpValue <> '' then
    sWhere := sWhere + ' AND TG.IDGroup = ' + scCategory.LookUpValue;

  if scGroup.LookUpValue <> '' then
    sWhere := sWhere + ' AND MG.IDModelGroup = ' + scCategory.LookUpValue;

  if scSubGroup.LookUpValue <> '' then
    sWhere := sWhere + ' AND MG.IDModelSubGroup = ' + scCategory.LookUpValue;


  sSQL :=  'SELECT ' +
                  'M.IDModel, ' +
	                'M.Model, ' +
                  'M.Description, ' +
                  'M.SellingPrice, ' +
                  'M.VendorCost, ' +
                  'IsNull(M.CaseQty,0) as CaseQty, ' +
                  'TG.IDGroup, ' +
                  'TG.Name, ' +
                  'B.IDBarcode, ' +
                  'IsNull(MG.IDModelGroup, 0) as IDModelGroup, ' +
                  'MG.ModelGroup, ' +
                  'IsNull(MSG.IDModelSubGroup, 0) as IDModelSubGroup, ' +
                  'MSG.ModelSubGroup, ' +
                  '1 as Qty, ' +
                  'F.Pessoa as Manufacturer ' +
           'FROM ' +
                  'Model M (NOLOCK) ' +
                  'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDgroup) ' +
                  'LEFT JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) ' +
                  'LEFT JOIN ModelSubGroup MSG (NOLOCK) ON (M.IDModelSubGroup = MSG.IDModelSubGroup) ' +
                  'LEFT JOIN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel AND B.BarcodeOrder = 1)' +
                  'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)' + sWhere;
  quModelResult.CommandText := sSQL;
  with cdsModelResult do
  begin
    if Active then
      Close;
    Open;
  end;
end;

procedure TFrmAddItems.AddModel;
var
  cCostPrice, cSalePrice: Currency;
begin
  with cdsModelAdd do
  begin
    GetPrices(cdsModelResultIDModel.AsInteger, cCostPrice, cSalePrice);

    Append;
    FieldByName('IDModel').AsInteger     := cdsModelResultIDModel.AsInteger;
    FieldByName('CostPrice').AsCurrency  := cCostPrice;
    FieldByName('SalePrice').AsCurrency  := cSalePrice;
    FieldByName('Description').AsString  := cdsModelResultDescription.AsString;
    FieldByName('Manufacturer').AsString := cdsModelResultManufacturer.AsString;
    FieldByName('Model').AsString        := cdsModelResultModel.AsString;
    FieldByName('Qty').AsFloat           := cdsModelResultQty.AsFloat;
    Post;
  end;
end;

procedure TFrmAddItems.grdModelResultTableViewDblClick(Sender: TObject);
begin
  inherited;
  btnAddClick(Sender);
end;

procedure TFrmAddItems.btnRemoveClick(Sender: TObject);
begin
  inherited;
  cdsModelAdd.Delete;
end;

procedure TFrmAddItems.btnRemoveAllClick(Sender: TObject);
begin
  inherited;
  with cdsModelAdd do
    while not Eof do
      Delete;
end;

procedure TFrmAddItems.cdsModelAddAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnRemove.Enabled := not dsModelAdd.DataSet.IsEmpty;
  btnRemoveAll.Enabled := btnRemove.Enabled;
end;

procedure TFrmAddItems.btnShowDetailsClick(Sender: TObject);
begin
  inherited;
  slModelDetail.Visible := not slModelDetail.Visible;
  btnShowDetails.Down := slModelDetail.Visible;
  if slModelDetail.Visible then
    with cdsModelResult do
      RefreshModelControls(FieldByName('IDModel').AsInteger);
end;

procedure TFrmAddItems.RefreshModelControls(AIDModel: Integer);
begin
  slModelDetail.Param := 'IDModel=' + IntToStr(AIDModel) + ';';
end;

procedure TFrmAddItems.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_ADD, btnAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADDALL, btnAddAll.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btnGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btnColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_INVENTORY, btnShowDetails.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btnRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETEALL, btnRemoveAll.Glyph);

  slModelDetail.CreateSubList;
end;

procedure TFrmAddItems.dsModelResultDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if slModelDetail.Visible then
    with cdsModelResult do
    begin
      if FIDModelActual <> FieldByName('IDModel').AsInteger then
        RefreshModelControls(FieldByName('IDModel').AsInteger);
      FIDModelActual := FieldByName('IDModel').AsInteger;
    end;
end;

procedure TFrmAddItems.btnAddAllClick(Sender: TObject);
begin
  inherited;
  with cdsModelResult do
  try
    cdsModelAdd.DisableControls;
    DisableControls;
    First;
    while not Eof do
    begin
      if (not WasModelAdd(cdsModelResultIDModel.AsInteger)) and ValidateCaseQty then
        AddModel;
      Next;
    end;
    First;
  finally
    EnableControls;
    cdsModelAdd.EnableControls;
  end;
end;

procedure TFrmAddItems.ConfigGrouping(AGroup: Boolean; AView: TcxCustomGridTableView);
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

procedure TFrmAddItems.ConfigColumns(AView: TcxCustomGridTableView);
begin
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmAddItems.btnGroupClick(Sender: TObject);
begin
  inherited;
  ConfigGrouping(btnGroup.Down, grdModelResultTableView);
end;

procedure TFrmAddItems.btnColumnClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdModelResultTableView);
end;

function TFrmAddItems.ValidateValues: Boolean;
begin
  Result := True;

  with cdsModelAdd do
  begin
    First;
    while not Eof do
    begin
      if vvQty in FValidateValues then
        if not (cdsModelAddQty.AsFloat >= 1) then
        begin
          MsgBox(MSG_INF_WRONG_QTY, vbCritical + vbOKOnly);
          Result := False;
          Exit;
        end;

      {
      if vvCostPrice in FValidateValues then
        if not (cdsModelAddCostPrice.AsCurrency > 0) then
        begin
          MsgBox(MSG_CRT_COST_POSITIVE, vbCritical + vbOKOnly);
          Result := False;
          Exit;
        end;
      }
      
      if vvSellingPrice in FValidateValues then
        if not (cdsModelAddSalePrice.AsCurrency > 0) then
        begin
          MsgBox(MSG_INF_PRICE_INVALID, vbCritical + vbOKOnly);
          Result := False;
          Exit;
        end;

      Next;
    end;
  end;
end;

function TFrmAddItems.ValidateCaseQty: Boolean;
begin
  Result := True;

  if cdsModelResultCaseQty.AsFloat > 0 then
    if DM.fSystem.SrvParam[PARAM_VALIDATE_CASE_QTY_ON_HOLD] then
      Result := Frac(cdsModelResultQty.AsFloat / cdsModelResultCaseQty.AsFloat) = 0;
end;

procedure TFrmAddItems.cdsModelResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnAdd.Enabled := not dsModelResult.DataSet.IsEmpty;
  btnAddAll.Enabled := btnAdd.Enabled;
  btnShowDetails.Enabled := btnAdd.Enabled;
end;

procedure TFrmAddItems.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text        := '';
end;

procedure TFrmAddItems.btnGroupClearClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text        := '';
end;

procedure TFrmAddItems.btnSubGroupClearClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text        := '';
end;

procedure TFrmAddItems.grdModelResultTableViewCustomization(
  Sender: TObject);
begin
  inherited;
  btnColumn.Down := TcxGridDBTableView(grdModelResult.FocusedView).Controller.Customization;
end;

end.
