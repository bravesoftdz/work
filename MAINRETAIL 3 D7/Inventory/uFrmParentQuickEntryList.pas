unit uFrmParentQuickEntryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, DBClient, Buttons, PanelRights, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, uDMInventory, ADODB;

type
  TFrmParentQuickEntryList = class(TFrmParent)
    grdModelList: TcxGrid;
    grdModelListDB: TcxGridDBTableView;
    grdModelListLevel: TcxGridLevel;
    pnlButton: TPanelRights;
    btColumn: TSpeedButton;
    btImport: TSpeedButton;
    btExcel: TSpeedButton;
    panel8: TPanel;
    Panel4: TPanel;
    cdsModel: TClientDataSet;
    dtsModel: TDataSource;
    grdModelListDBDescription: TcxGridDBColumn;
    grdModelListDBModel: TcxGridDBColumn;
    grdModelListDBIDGroup: TcxGridDBColumn;
    grdModelListDBIDModelSubGroup: TcxGridDBColumn;
    grdModelListDBCaseQty: TcxGridDBColumn;
    grdModelListDBVendorCost: TcxGridDBColumn;
    grdModelListDBSuggRetail: TcxGridDBColumn;
    grdModelListDBSellingPrice: TcxGridDBColumn;
    grdModelListDBMarkup: TcxGridDBColumn;
    SD: TSaveDialog;
    OD: TOpenDialog;
    btSave: TButton;
    strepPredefined: TcxStyleRepository;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    cxBarcode: TcxStyle;
    Label1: TLabel;
    edtMarkup: TEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    btnCategory: TSpeedButton;
    cdsModelIDModel: TIntegerField;
    cdsModelModel: TStringField;
    cdsModelDescription: TStringField;
    cdsModelVendorCost: TFloatField;
    cdsModelSellingPrice: TFloatField;
    cdsModelCaseQty: TFloatField;
    cdsModelIDGroup: TIntegerField;
    cdsModelIDModelGroup: TIntegerField;
    cdsModelIDModelSubGroup: TIntegerField;
    cdsModelSuggRetail: TCurrencyField;
    cdsModelMarginInfo: TFloatField;
    cdsModelMarkupInfo: TFloatField;
    cdsModelMarkup: TFloatField;
    cdsModelWarning: TStringField;
    grdModelListDBWarning: TcxGridDBColumn;
    cxWarning: TcxStyle;
    grdModelListDBIDModelGroup: TcxGridDBColumn;
    cdsModelIDManufacturer: TIntegerField;
    cdsModelMaxQty: TFloatField;
    cdsModelMinQty: TFloatField;
    grdModelListDBManufacturer: TcxGridDBColumn;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    procedure btColumnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btImportClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsModelVendorCostChange(Sender: TField);
    procedure cdsModelMarkupValidate(Sender: TField);
    procedure cdsModelIDGroupValidate(Sender: TField);
    procedure edtMarkupKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarkupExit(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure grdModelListDBCustomization(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cdsModelSellingPriceChange(Sender: TField);
    procedure grdModelListDBVendorCostPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure grdModelListDBMarkupPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FSalePrice: Currency;
    dMarkup : Double;
    AView : TcxCustomGridTableView;
    sOldSQLGroup, sOldSQLManufacture,
    sOldSQLVendor, sOldSQLModelGroup,
    sOldSQLModelSubGroup: String;
    procedure OpenLookups;
    procedure CloseLookups;
    procedure StartScreenRefreshLookups;
    procedure FinishScreenRefreshLookups;
    function CalcSalePrice(IDCateg, IDSubCateg,
  IDGroup: Integer; CostPrice: Currency; Markup: Double): Currency;
    procedure CalcNewPrice;
    procedure RefreshLookups;
  protected
    FDMInventory: TDMInventory;
    function ValidateFields: Boolean; virtual;
    function CatalogSearch(sBarcode : String):Boolean;
    procedure LoadImage; virtual;
    procedure RefreshInfo; virtual;
    function ExportDate:Boolean;
  public
    function Start(ModelList: OleVariant): Boolean; virtual;
  end;

implementation

{$R *.dfm}

uses uDM, uSystemConst, uMsgBox, uMsgConstant, uCharFunctions, MenuPrincipal,
     uContentClasses, uObjectServices, LookUpADOQuery, uCDSFunctions, uNumericFunctions,
     uSqlFunctions, uPassword;

procedure TFrmParentQuickEntryList.btColumnClick(Sender: TObject);
begin

  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

function TFrmParentQuickEntryList.Start(ModelList: OleVariant): Boolean;
var
   AOptions : TcxGridStorageOptions;
   fRegistryPath: String;
begin
  RefreshLookups;
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  StartScreenRefreshLookups;

  dMarkup := 0;

  if ModelList = null then
  begin
    cdsModel.CreateDataSet;
    cdsModel.Append;
  end
  else
    cdsModel.Data := ModelList;

  grdModelListDB.Preview.Visible := False;

  LoadImage;

  if not DM.fSystem.SrvParam[PARAM_TAX_COST_USE_MARKUP_ON_COST] then
  begin
    Label1.Visible              := False;
    edtMarkup.Visible           := False;
    grdModelListDBMarkup.Hidden := True;
    grdModelListDBMarkup.Visible:= False;
    edtMarkup.ReadOnly          := True;
    edtMarkup.Color             := $00DEE2E4;
  end;

  ShowModal;

  Result := (ModalResult = mrOK);

  FinishScreenRefreshLookups;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

end;

procedure TFrmParentQuickEntryList.FormCreate(Sender: TObject);
begin
  inherited;
  FDMInventory := TDMInventory.Create(Self);

  //Pega o Browser atual
  AView := TcxCustomGridTableView(grdModelList.FocusedView);
end;

procedure TFrmParentQuickEntryList.btImportClick(Sender: TObject);
begin
 if OD.Execute then
   if OD.FileName <> '' then
   begin
     while not cdsModel.Eof do
       cdsModel.Delete;
     cdsModel.LoadFromFile(OD.FileName);
   end;
end;

procedure TFrmParentQuickEntryList.btExcelClick(Sender: TObject);
begin
  ExportDate;
end;

procedure TFrmParentQuickEntryList.FormDestroy(Sender: TObject);
begin
  if Assigned(cdsModel) then
     FreeAndNil(cdsModel);

  if Assigned(FDMInventory) then
     FreeAndNil(FDMInventory);
end;

procedure TFrmParentQuickEntryList.CloseLookups;
begin
  DM.quLookUpGroup.Close;
  DM.LookUpFabricante.Close;
  DM.LookUpModelGroup.Close;
  DM.LookUpModelSubGroup.Close;
  DM.LookUpFornecedor.Close;

  if DM.quLookUpGroup.OriginalSQL <> '' then
    DM.quLookUpGroup.CommandText := DM.quLookUpGroup.OriginalSQL;

end;

procedure TFrmParentQuickEntryList.OpenLookups;
begin
  DM.quLookUpGroup.Open;
  DM.LookUpFabricante.Open;
  DM.LookUpModelGroup.Open;
  DM.LookUpModelSubGroup.Open;
  DM.LookUpFornecedor.Open;
end;

procedure TFrmParentQuickEntryList.RefreshLookups;
begin
  CloseLookups;
  OpenLookups;
end;

procedure TFrmParentQuickEntryList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsModel.Close;
  CloseLookups;
end;

procedure TFrmParentQuickEntryList.LoadImage;
begin
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgSubMenu.GetBitmap(29, btnCategory.Glyph);
end;

function TFrmParentQuickEntryList.CatalogSearch(sBarcode: String):Boolean;
var
  CatalogBarcodeService: TCatalogBarcodeService;
  Barcode: TBarcode;
var
  Markup : Double;
begin

  Result := False;

  CatalogBarcodeService := TCatalogBarcodeService.Create();
  try
    Barcode := TBarcode.Create();
    try
      CatalogBarcodeService.SQLConnection := DM.ADODBConnect;

      Barcode.IDBarcode := sBarcode;

      CatalogBarcodeService.Find(Barcode);

      if Assigned(Barcode.Model) then
      begin
        cdsModel.Edit;
        cdsModel.FieldByName('Model').AsString        := Barcode.Model.Model;
        cdsModel.FieldByName('Description').AsString  := Barcode.Model.Description;
        cdsModel.FieldByName('CaseQty').AsFloat       := Barcode.Model.CaseQty;
        cdsModel.FieldByName('MinQty').AsFloat        := Barcode.Model.Inventory.MinQty;
        cdsModel.FieldByName('MaxQty').AsFloat        := Barcode.Model.Inventory.MaxQty;
        cdsModel.FieldByName('SuggRetail').AsCurrency := Barcode.Model.SuggRetail;

        if VarToStr(Barcode.Model.Category.IDGroup) <> '' then
          cdsModel.FieldByName('IDGroup').AsInteger := Barcode.Model.Category.IDGroup;

        if VarToStr(Barcode.Model.ModelGroup.IDModelGroup) <> '' then
          cdsModel.FieldByName('IDModelGroup').AsInteger := Barcode.Model.ModelGroup.IDModelGroup;

        if VarToStr(Barcode.Model.ModelSubGroup.IDModelSubGroup) <> '' then
          cdsModel.FieldByName('IDModelSubGroup').AsInteger := Barcode.Model.ModelSubGroup.IDModelSubGroup;

        if Barcode.Model.Manufacturer.IDManufacturer <> 0 then
          cdsModel.FieldByName('IDManufacturer').AsInteger := Barcode.Model.Manufacturer.IDManufacturer;

        if Barcode.Model.Vendor.IDVendor <> 0 then
        begin
          cdsModel.FieldByName('VendorCode').AsString := Barcode.Model.VendorModelCode.VendorCode;
          cdsModel.FieldByName('IDVendor').AsInteger  := Barcode.Model.Vendor.IDVendor;

          if (Barcode.Model.Vendor.Vendor <> '') and CatalogBarcodeService.FindByVendor(Barcode) then
            cdsModel.FieldByName('VendorCost').AsCurrency := Barcode.Model.VendorCost;
        end
        else
          cdsModel.FieldByName('VendorCost').AsCurrency := 0;
      end;

    finally
      if Assigned(Barcode) then
        FreeAndNil(Barcode);
    end;
  finally
    if Assigned(CatalogBarcodeService) then
      FreeAndNil(CatalogBarcodeService);
  end;


end;

function TFrmParentQuickEntryList.CalcSalePrice(IDCateg, IDSubCateg,
  IDGroup: Integer; CostPrice: Currency; Markup: Double): Currency;
var
  MarginSelling : Currency;
  MarkupSelling : Currency;
begin

  Result        := 0;
  CostPrice     := DM.FDMCalcPrice.FormatPrice(CostPrice);
  
  MarginSelling := CostPrice;
  MarkupSelling := CostPrice;

  if DM.fSystem.SrvParam[PARAM_CALC_MARGIN] then
    MarginSelling := DM.FDMCalcPrice.FormatPrice(DM.FDMCalcPrice.CalcSalePrice(0, IDCateg, IDSubCateg, IDGroup, CostPrice));

  if Markup <> 0 then
    MarkupSelling := DM.FDMCalcPrice.FormatPrice(DM.FDMCalcPrice.CalcRounding(IDCateg, DM.FDMCalcPrice.GetMarkupPrice(CostPrice, Markup)));

  if ((MarginSelling <> 0) and (MarginSelling <> CostPrice)) or
     ((MarkupSelling <> 0) and (MarkupSelling <> CostPrice)) then
  begin
   if MarginSelling > MarkupSelling then
     Result := MarginSelling
   else
     Result := MarkupSelling;
  end;
end;

procedure TFrmParentQuickEntryList.CalcNewPrice;
var
  Markup: Double;
  SellingPrice: Currency;
begin
  SellingPrice := 0;

  if (cdsModelVendorCost.AsCurrency <> 0) then
    begin
      if not(cdsModel.State = (dsEdit)) then
        cdsModel.Edit;

      Markup := cdsModelMarkup.AsFloat;


      SellingPrice := CalcSalePrice(cdsModelIDGroup.AsInteger,
                                  cdsModelIDModelGroup.AsInteger,
                                  cdsModelIDModelSubGroup.AsInteger,
                                  cdsModelVendorCost.AsCurrency,
                                  Markup);

      if SellingPrice <> 0 then
      begin
        FSalePrice := SellingPrice;
        cdsModelSellingPrice.AsCurrency := SellingPrice;
      end;
        
      RefreshInfo;
    end;
end;

procedure TFrmParentQuickEntryList.RefreshInfo;
begin

  with cdsModel do
  begin
    //Markup
    if ((FieldByName('VendorCost').AsCurrency > 0) and (FieldByName('SellingPrice').AsCurrency > 0)) then
      FieldByName('MarkupInfo').AsFloat :=
         DM.FDMCalcPrice.FormatPrice(((FieldByName('SellingPrice').AsCurrency - FieldByName('VendorCost').AsCurrency)/FieldByName('VendorCost').AsCurrency)*100)
    else
      FieldByName('MarkupInfo').AsFloat := 0;

    //Margin
    if FieldByName('SellingPrice').AsCurrency <> 0 then
      FieldByName('MarginInfo').AsFloat :=
         DM.FDMCalcPrice.FormatPrice(((1 - (FieldByName('VendorCost').AsCurrency)/FieldByName('SellingPrice').AsCurrency))*100)
    else
      FieldByName('MarginInfo').AsFloat := 0;
  end;

end;

procedure TFrmParentQuickEntryList.cdsModelMarkupValidate(Sender: TField);
begin
  inherited;
  //if (TField(Sender).Value <> 0) then
  //  CalcNewPrice;
end;

procedure TFrmParentQuickEntryList.cdsModelVendorCostChange(Sender: TField);
var
  CostPrice: Currency;
begin
  inherited;
  CostPrice := DM.FDMCalcPrice.FormatPrice(cdsModel.FieldByName('VendorCost').AsCurrency);
  if (cdsModel.FieldByName('VendorCost').AsCurrency <> CostPrice) then
    cdsModel.FieldByName('VendorCost').AsCurrency := CostPrice;

  if (dMarkup <> 0) and (dMarkup > cdsModel.FieldByName('MarkupInfo').AsFloat) then
    cdsModel.FieldByName('Markup').AsFloat := dMarkup
  else
    cdsModel.FieldByName('Markup').AsFloat := cdsModel.FieldByName('MarkupInfo').AsFloat;

  CalcNewPrice;
end;

procedure TFrmParentQuickEntryList.cdsModelIDGroupValidate(Sender: TField);
begin
  inherited;
  CalcNewPrice;
end;

procedure TFrmParentQuickEntryList.edtMarkupKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
  if Key = ThousandSeparator then
    Key := #0;
end;

procedure TFrmParentQuickEntryList.edtMarkupExit(Sender: TObject);
begin
  inherited;
  if StrToFloatDef(edtMarkup.Text, 0) <> 0 then
    dMarkup := StrToFloatDef(edtMarkup.Text, 0);
end;

procedure TFrmParentQuickEntryList.btnCategoryClick(Sender: TObject);
var
  fImgOld : Integer;
  fsMenu,
  fsSubMenu : String;
begin
  try
    fImgOld   := DM.fMainMenu.Image;
    fsMenu    := DM.fMainMenu.MenuName;
    fsSubMenu := DM.fMainMenu.SubMenuName;

    MainMenu.IDMenu    := 5;
    MainMenu.IDSubMenu := 3;
    MainMenu.SubMenuClick(nil);
    RefreshLookups;
  finally
    MainMenu.IDMenu         := 5;
    MainMenu.IDSubMenu      := 1;
    DM.fMainMenu.Image      := fImgOld;
    DM.fMainMenu.MenuName   := fsMenu;
    DM.fMainMenu.SubMenuName:= fsSubMenu;
  end;
end;

function TFrmParentQuickEntryList.ExportDate: Boolean;
begin

 Result := False;

 With SD do
 begin
   If Execute then
      If FileName <> '' then
         if Pos('.xml', LowerCase(FileName)) = 0 then
            FileName := FileName + '.xml';

   if FileName <> '' then
   try
     cdsModel.SaveToFile(FileName);
     Result := True;
   except
     Result := False;
     end;
 end;

end;

procedure TFrmParentQuickEntryList.grdModelListDBCustomization(
  Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmParentQuickEntryList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if not cdsModel.IsEmpty then
    CanClose := (MsgBox(MSG_QST_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbYes);
end;

function TFrmParentQuickEntryList.ValidateFields: Boolean;
begin
  Result := True;

  if cdsModel.FieldByName('Warning').AsString <> '' then
  begin
   cdsModel.Edit;
   cdsModel.FieldByName('Warning').AsString := '';
  end;


  if (cdsModelIDGroup.IsNull) then
  begin
    cdsModel.Edit;
    cdsModel.FieldByName('Warning').AsString := MSG_CRT_NOT_EMPTY_CATEGORY;
    Result := False;
  end;

  if (cdsModelModel.AsString = '') then
  begin
    cdsModel.Edit;
    if cdsModel.FieldByName('Warning').AsString = '' then
      cdsModel.FieldByName('Warning').AsString := MSG_CRT_NO_MODEL
    else
      cdsModel.FieldByName('Warning').AsString :=
          cdsModel.FieldByName('Warning').AsString + '; ' + MSG_CRT_NO_MODEL;
    Result := False;
  end;

  if (cdsModelDescription.AsString = '') then
  begin
    cdsModel.Edit;
    if cdsModel.FieldByName('Warning').AsString = '' then
      cdsModel.FieldByName('Warning').AsString := MSG_INF_NOT_DESCRIPTION_EMPTY
    else
      cdsModel.FieldByName('Warning').AsString :=
          cdsModel.FieldByName('Warning').AsString + '; ' + MSG_INF_NOT_DESCRIPTION_EMPTY;
    Result := False;
  end;

  if not Password.HasFuncRight(4) then
    if (cdsModelSellingPrice.Value < cdsModelVendorCost.Value) then
    begin
      cdsModel.Edit;
      if cdsModel.FieldByName('Warning').AsString = '' then
        cdsModel.FieldByName('Warning').AsString := MSG_INF_NOT_SELL_BELLOW_COST
      else
        cdsModel.FieldByName('Warning').AsString :=
            cdsModel.FieldByName('Warning').AsString + '; ' + MSG_INF_NOT_SELL_BELLOW_COST;
      Result := False;
    end;


  if cdsModel.State in [dsEdit] then
    cdsModel.Post;

  if not Result then
    grdModelListDB.Preview.Visible := True;

end;

procedure TFrmParentQuickEntryList.FinishScreenRefreshLookups;
begin
  CloseLookups;

  DM.quLookUpGroup.CommandText       := sOldSQLGroup;
  DM.LookUpFabricante.CommandText    := sOldSQLManufacture;
  DM.LookUpModelGroup.CommandText    := sOldSQLModelGroup;
  DM.LookUpModelSubGroup.CommandText := sOldSQLModelSubGroup;
  DM.LookUpFornecedor.CommandText    := sOldSQLVendor;

  OpenLookups;
end;

procedure TFrmParentQuickEntryList.StartScreenRefreshLookups;
var
  sWhere: String;
begin
  CloseLookups;

  sOldSQLGroup         := DM.quLookUpGroup.CommandText;
  sOldSQLManufacture   := DM.LookUpFabricante.CommandText;
  sOldSQLModelGroup    := DM.LookUpModelGroup.CommandText;
  sOldSQLModelSubGroup := DM.LookUpModelSubGroup.CommandText;
  sOldSQLVendor        := DM.LookUpFornecedor.CommandText;

  sWhere := ' Desativado = 0';

  DM.quLookUpGroup.CommandText       := ChangeWhereClause(DM.quLookUpGroup.CommandText, sWhere, True);
  DM.LookUpFabricante.CommandText    := ChangeWhereClause(DM.LookUpFabricante.CommandText, sWhere, True);
  DM.LookUpModelGroup.CommandText    := ChangeWhereClause(DM.LookUpModelGroup.CommandText, sWhere, True);
  DM.LookUpModelSubGroup.CommandText := ChangeWhereClause(DM.LookUpModelSubGroup.CommandText, sWhere, True);
  DM.LookUpFornecedor.CommandText    := ChangeWhereClause(DM.LookUpFornecedor.CommandText, sWhere, True);

  OpenLookups;
end;

procedure TFrmParentQuickEntryList.cdsModelSellingPriceChange(
  Sender: TField);
var
  SellingPrice: Currency;
begin
  inherited;
  if (FSalePrice <> cdsModel.FieldByName('SellingPrice').NewValue) then
  begin
    FSalePrice :=
       DM.FDMCalcPrice.FormatPrice(DM.FDMCalcPrice.CalcRounding(cdsModel.FieldByName('IDGroup').AsInteger, cdsModel.FieldByName('SellingPrice').AsCurrency));

    cdsModel.FieldByName('SellingPrice').AsCurrency := FSalePrice;
    RefreshInfo;
    cdsModel.FieldByName('Markup').AsFloat := 0;
  end;
end;

procedure TFrmParentQuickEntryList.grdModelListDBVendorCostPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  try
    if DisplayValue <> 0 then
    StrToCurr(DisplayValue);
  except
    MsgBox(MSG_CRT_INVALID_AMOUNT, vbOKOnly + vbExclamation);
    DisplayValue := 0;
  end;
end;

procedure TFrmParentQuickEntryList.grdModelListDBMarkupPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  try
    if DisplayValue <> 0 then
    StrToCurr(DisplayValue);
  except
    MsgBox(MSG_CRT_INVALID_AMOUNT, vbOKOnly + vbExclamation);
    DisplayValue := 0;
  end;
end;

end.
