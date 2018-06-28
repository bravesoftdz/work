unit uFrmInventoryUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, StdCtrls, DB, DBClient, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, uParentWizImp;

const
  COMPER_TYPE_COST      = 1;
  COMPER_TYPE_INVENTORY = 2;

type
  TFrmInventoryUpdate = class(TFrmParent)
    cdsProducts: TClientDataSet;
    dsProducts: TDataSource;
    grdProducts: TcxGrid;
    grdProductsTableView: TcxGridDBTableView;
    grdProductsLevel: TcxGridLevel;
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    BNext: TButton;
    BClose: TButton;
    cdsModelUpdate: TClientDataSet;
    cdsModelUpdateIDModel: TIntegerField;
    cdsModelUpdateCostPrice: TCurrencyField;
    cdsModelUpdateSalePrice: TCurrencyField;
    cdsModelUpdateMSRP: TCurrencyField;
    btnColumns: TButton;
    cbxCategory: TcxLookupComboBox;
    Label1: TLabel;
    btnGroup: TButton;
    btnAllCategory: TButton;
    cdsInventoryUpdate: TClientDataSet;
    cdsInventoryUpdateDescription: TStringField;
    cdsInventoryUpdateIDModel: TIntegerField;
    cdsInventoryUpdateModel: TStringField;
    cdsModelUpdateModel: TStringField;
    cdsModelUpdateIDUserLastSellingPrice: TIntegerField;
    lblVendor: TLabel;
    cbxVendor: TcxLookupComboBox;
    btnAllVendor: TButton;
    Label2: TLabel;
    cbxSubCategory: TcxLookupComboBox;
    btnAllSubCateg: TButton;
    Label3: TLabel;
    cbxGroup: TcxLookupComboBox;
    Button2: TButton;
    btExpand: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnColumnsClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
    procedure btnAllCategoryClick(Sender: TObject);
    procedure grdProductsTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAllVendorClick(Sender: TObject);
    procedure btnAllSubCategClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btExpandClick(Sender: TObject);
  private
    FExecuted : Boolean;
    AOptions: TcxGridStorageOptions;
    FRegistryPath : String;
    AView : TcxCustomGridTableView;
    FComperType : Integer;
    FParentWizImp : TParentWizImp;
    FSpecificConfig : TStringList;
    procedure OpenConn;
    procedure AddColumnsToListGrid(grdView : TcxGridDBTableView; cds : TClientDataSet);
    procedure UpdatePrices;
    procedure UpdateInventory;
    procedure ScreenStatusOk;
    procedure ScreenStatusWait;
    procedure ShowError(Error: String);
  public
    function Start(ComperType: Integer): Boolean;
  end;

implementation

uses uDMImportExport, uMRSQLParam, uSystemConst, uMsgBox, uFrmLog;

{$R *.dfm}

{ TFrmCatalogComperPrice }

function TFrmInventoryUpdate.Start(ComperType: Integer): Boolean;
begin
  FComperType := ComperType;
  FExecuted   := False;
  //Grid options
  FRegistryPath := MR_IMP_EXP_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];
  AView := TcxCustomGridTableView(grdProducts.FocusedView);
  try
    OpenConn;
    DMImportExport.OpenCategory;
    DMImportExport.OpenSubCategory;
    DMImportExport.OpenGroup;
    DMImportExport.OpenCatalogVendor;

    ShowModal;
  finally
    DMImportExport.CloseCatalogVendor;
    DMImportExport.CloseCategory;
    DMImportExport.CloseSubCategory;
    DMImportExport.CloseGroup;
    DMImportExport.CatalogConn.Connected := False;
    end;

  //Salva para o registro.
  if FExecuted then
    TcxGridDBTableView(AView).StoreToRegistry(FRegistryPath, True, AOptions);

end;

procedure TFrmInventoryUpdate.Button1Click(Sender: TObject);
var
  MRSQLParam : TMRSQLParam;
  kUPC : TMRSQLKey;
begin
  inherited;

  MRSQLParam := TMRSQLParam.Create;
  try
    OpenConn;
    //Model Exist
    MRSQLParam.AddKey('ModelExist');
    MRSQLParam.KeyByName('ModelExist').AddBoolean(True);

    MRSQLParam.AddKey('UPC');
    MRSQLParam.KeyByName('UPC').AsString := '';
    MRSQLParam.KeyByName('UPC').Condition := tcDifferent;
    MRSQLParam.KeyByName('UPC').Field := 'CP.upc';

    if (cbxVendor.EditValue <> NULL) and (cbxVendor.EditValue <> 0) then
    begin
      MRSQLParam.AddKey('IDVendor');
      MRSQLParam.KeyByName('IDVendor').AsInteger := cbxVendor.EditValue;
      MRSQLParam.KeyByName('IDVendor').Condition := tcEquals;
      MRSQLParam.KeyByName('IDVendor').Field     := 'V.IDVendor';
    end;

    //Filtro Categoria
    if (cbxCategory.EditValue <> NULL) and (cbxCategory.EditValue <> 0) then
    begin
      MRSQLParam.AddKey('TG.IDGroup');
      MRSQLParam.KeyByName('TG.IDGroup').AddInteger(StrToInt(cbxCategory.EditValue));
    end;

    //Filtro Categoria
    if (cbxSubCategory.EditValue <> NULL) and (cbxSubCategory.EditValue <> 0) then
    begin
      MRSQLParam.AddKey('IDSubCategory');
      MRSQLParam.KeyByName('IDSubCategory').AddInteger(StrToInt(cbxSubCategory.EditValue));
      MRSQLParam.KeyByName('IDSubCategory').Field := 'SC.IDModelGroup';
    end;


    //Cost Equal
    if FComperType = COMPER_TYPE_COST then
    begin
      MRSQLParam.AddKey('CostEqual');
      MRSQLParam.KeyByName('CostEqual').AddBoolean(True);
      ScreenStatusWait;
      cdsProducts.Data := DMImportExport.CatalogConn.AppServer.GetNewCostPriceList(MRSQLParam.ParamString);
      ScreenStatusOk;
    end
    else if FComperType = COMPER_TYPE_INVENTORY then
    begin
     MRSQLParam.AddKey('DescriptionEqual');
     MRSQLParam.KeyByName('DescriptionEqual').AddBoolean(True);
     ScreenStatusWait;
     cdsProducts.Data := DMImportExport.CatalogConn.AppServer.GetNewInventoryList(MRSQLParam.ParamString);
     //MRSQLParam.AddKey('ModelVendorCodeEqual');
     //MRSQLParam.KeyByName('ModelVendorCodeEqual').AddBoolean(True);
    end;

    AddColumnsToListGrid(grdProductsTableView, cdsProducts);
    TcxGridDBTableView(AView).RestoreFromRegistry(FRegistryPath, False, False, AOptions);

    grdProductsTableView.DataController.DataSource    := dsProducts;
    grdProductsTableView.DataController.KeyFieldNames := 'sku;Vendor';
    ScreenStatusOk;
    FExecuted := True;
  finally
    FreeAndNil(MRSQLParam);
    end;
end;

procedure TFrmInventoryUpdate.AddColumnsToListGrid(grdView : TcxGridDBTableView;
  cds : TClientDataSet);
var
  i: Integer;
  NewColumn: TcxGridDBColumn;
begin
  grdView.ClearItems;
  for i := 0 to Pred(cds.FieldDefs.Count) do
    begin
      NewColumn := grdView.CreateColumn;
      with NewColumn do
      begin
        Name    := 'grdProductsTableViewDB' + cds.FieldDefs[i].DisplayName;
        Caption := cds.FieldDefs[i].DisplayName;
        DataBinding.FieldName := cds.FieldDefs[i].Name;
      end;
    end;
end;

procedure TFrmInventoryUpdate.btnColumnsClick(Sender: TObject);
begin
  inherited;
  TcxGridDBTableView(AView).Controller.Customization := True;
end;

procedure TFrmInventoryUpdate.BCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmInventoryUpdate.UpdatePrices;
var
  sError: String;
begin
  sError := '';

  with cdsProducts do
  begin
    Filtered := False;
    Filter   := 'Mark = 1 AND NewSalePrice <> 0';
    Filtered := True;

    if not IsEmpty then
    try
      DisableControls;
      cdsModelUpdate.CreateDataSet;

      while not EOF do
      begin
        cdsModelUpdate.Append;
        cdsModelUpdate.FieldByName('Model').AsString       := FieldByName('Model').AsString;
        cdsModelUpdate.FieldByName('IDModel').AsInteger    := FieldByName('IDModel').AsInteger;
        cdsModelUpdate.FieldByName('CostPrice').AsCurrency := FieldByName('VendorCost').AsCurrency;
        cdsModelUpdate.FieldByName('SalePrice').AsCurrency := FieldByName('NewSalePrice').AsCurrency;
        cdsModelUpdate.FieldByName('MSRP').AsCurrency      := FieldByName('NewMSRPPrice').AsCurrency;
        cdsModelUpdate.FieldByName('IDUserLastSellingPrice').AsInteger := DMImportExport.FUser.ID;
        cdsModelUpdate.Post;
        Next;
      end;
    finally
      EnableControls;
    end;

    OpenConn;
    FSpecificConfig.Add('IDUser=' + IntToStr(DMImportExport.FUser.ID));

    if not(cdsModelUpdate.IsEmpty) then
      DMImportExport.CatalogConn.AppServer.UpdatePrices(cdsModelUpdate.Data, sError, FSpecificConfig.Text);

    if sError <> '' then
      ShowError(sError)
    else
      MsgBox('Update Success!', vbInformation + vbOKOnly);
  end;
end;

procedure TFrmInventoryUpdate.BNextClick(Sender: TObject);
begin
  inherited;
  if DMImportExport.ActiveConnection.AppServer.IsClientServer then
  begin
    MsgBox('Models cannot be modified!_This is a Replication Database!', vbInformation + vbOKOnly);
    Exit;
  end;

  if (FComperType = COMPER_TYPE_COST) then
    UpdatePrices
  else if (FComperType = COMPER_TYPE_INVENTORY) then
    UpdateInventory;

  Close;
end;

procedure TFrmInventoryUpdate.OpenConn;
begin
  if not DMImportExport.CatalogConn.Connected then
    DMImportExport.CatalogConn.Connected := True;
end;

procedure TFrmInventoryUpdate.btnGroupClick(Sender: TObject);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsView.GroupByBox := not TcxGridDBTableView(AView).OptionsView.GroupByBox;
end;

procedure TFrmInventoryUpdate.btnAllCategoryClick(Sender: TObject);
begin
  inherited;
  cbxCategory.EditingText := '';
  cbxCategory.EditValue   := NULL;
end;

procedure TFrmInventoryUpdate.grdProductsTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  FValue : Double;
begin
  inherited;

  if AViewInfo.Item.Caption = 'PriceInfo' then
  begin
    FValue := StrToFloatDef(Trim(StringReplace(AViewInfo.Value,'%','',[])),0);
    if FValue < 0 then
      ACanvas.Font.Color := clRed
    else
      ACanvas.Font.Color := clBlue;
  end;
end;

procedure TFrmInventoryUpdate.ScreenStatusWait;
begin
  grdProducts.Visible := False;
  Screen.Cursor := crHourGlass;
end;

procedure TFrmInventoryUpdate.ScreenStatusOk;
begin
  grdProducts.Visible := True;
  Screen.Cursor := crDefault;
end;

procedure TFrmInventoryUpdate.UpdateInventory;
var
  sError: String;
begin
  sError := '';

  with cdsProducts do
  begin
    Filtered := False;
    Filter   := 'Mark = 1';
    Filtered := True;
    if not IsEmpty then
    begin
      try
        DisableControls;
        cdsInventoryUpdate.CreateDataSet;
        while not EOF do
        begin
          cdsInventoryUpdate.Append;
          cdsInventoryUpdate.FieldByName('Model').AsString       := FieldByName('Model').AsString;
          cdsInventoryUpdate.FieldByName('IDModel').AsInteger    := FieldByName('IDModel').AsInteger;
          cdsInventoryUpdate.FieldByName('Description').AsString := FieldByName('Title').AsString;
          cdsInventoryUpdate.Post;
          Next;
        end;
      finally
        EnableControls;
        end;
      OpenConn;
      DMImportExport.CatalogConn.AppServer.UpdateInventory(cdsInventoryUpdate.Data, sError);

      if sError <> '' then
        ShowError(sError)
      else
        MsgBox('Update Success!', vbInformation + vbOKOnly);
    end;
  end;
end;

procedure TFrmInventoryUpdate.ShowError(Error: String);
begin
  with TFrmLog.Create(Self) do
  try
    MsgLog.Text := Error;
    Start;
  finally
    Free;
  end;
end;

procedure TFrmInventoryUpdate.FormCreate(Sender: TObject);
begin
  inherited;
  FSpecificConfig := TStringList.Create;
end;

procedure TFrmInventoryUpdate.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FSpecificConfig);
end;

procedure TFrmInventoryUpdate.btnAllVendorClick(Sender: TObject);
begin
  inherited;
  cbxVendor.EditingText := '';
  cbxVendor.EditValue   := NULL;

  cbxSubCategory.EditingText := '';
  cbxSubCategory.EditValue   := NULL;

  cbxGroup.EditingText := '';
  cbxGroup.EditValue   := NULL;
  
end;

procedure TFrmInventoryUpdate.btnAllSubCategClick(Sender: TObject);
begin
  inherited;
  cbxSubCategory.EditingText := '';
  cbxSubCategory.EditValue   := NULL;

  cbxGroup.EditingText := '';
  cbxGroup.EditValue   := NULL;
  
end;

procedure TFrmInventoryUpdate.Button2Click(Sender: TObject);
begin
  inherited;
  cbxGroup.EditingText := '';
  cbxGroup.EditValue   := NULL;
end;

procedure TFrmInventoryUpdate.btExpandClick(Sender: TObject);
begin
  inherited;
  TcxGridDBTableView(AView).DataController.Groups.FullExpand;
end;

end.
