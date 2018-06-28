unit uDMImportInventoryTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMImportTextFile, DB, ADODB, uContentClasses, uDMCalcPrice,
  uDMImportInventory, uSystemConst;

type
  TDMImportInventoryTextFile = class(TDMImportTextFile)
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDMImportInventory: TDMImportInventory;
    FDMCalcPrice : TDMCalcPrice;
    FImportQty: Boolean;
    FUpdateQty: Boolean;
    FIDStore: Variant;
    lstBarcodes: TList;

    function GetNewBarcode: TBarCode;
    function GetNewModel(Model, Description, IDUserLastSellingPrice: Variant; Qty, CaseQty: Double; SellingPrice, VendorCost: Currency): TModel;
    function GetNewCategory(Category: variant): TCategory;
    function GetNewModelGroup(ModelGroup: variant): TModelGroup;
    function GetNewModelSubGroup(ModelSubGroup: variant): TModelSubGroup;
    function GetNewVendor(Vendor: Variant): TVendor;
    function GetNewManufacturer(Manufacturer: Variant): TManufacturer;
    function GetNewVendorModelCode(VendorModelCode: Variant): TVendorModelCode;
  protected
    procedure BeforeImport; override;
    procedure ImportLine; override;
    procedure AfterImport; override;
    procedure ConfigureCalcPrice(SQLConnection: TADOConnection);
  end;

implementation

uses uNumericFunctions, uDMGlobal;

{$R *.dfm}

{ TDMImportInventoryTextFile }

procedure TDMImportInventoryTextFile.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FDMImportInventory);
  inherited;
end;

function TDMImportInventoryTextFile.GetNewModel(Model, Description, IDUserLastSellingPrice: Variant; Qty, CaseQty: Double;SellingPrice, VendorCost: Currency): TModel;
begin

  Result                        := TModel.Create;
  Result.IDModel                := Null;
  Result.Model                  := Model;
  Result.Description            := VarToStr(Description);
  Result.Qty                    := Qty;
  Result.CaseQty                := CaseQty;
  Result.VendorCost             := VendorCost;
  Result.IDUserLastSellingPrice := IDUserLastSellingPrice;

  if not DMGlobal.IsClientServer(SQLConnection) then
    Result.SellingPrice := SellingPrice
  else
    Result.SellingPrice := 0;

end;

function TDMImportInventoryTextFile.GetNewBarcode: TBarcode;
var
  varSellingPrice, varVendorCost: Variant;
  DecimalPoint: String;
  CaseQty: Double;
begin

  Result := TBarcode.Create;

  if FImportQty then
  begin
    Result.Qty := StrToFloatDef(VarToStr(GetParamValue('Qty')), 0);
    CaseQty    := StrToFloatDef(VarToStr(GetParamValue('CaseQty')), 0);
  end
  else
  begin
    Result.Qty := 0;
    CaseQty    := 0;
  end;

  DecimalPoint                 := ImpExpConfig.Values['DecimalDelimiter'];

  varSellingPrice              := FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(GetParamValue('SellingPrice')), DecimalPoint[1]));
  varVendorCost                := FDMCalcPrice.FormatPrice(MyStrToDouble(VarToStr(GetParamValue('VendorCost')), DecimalPoint[1]));

  Result.Model                 := GetNewModel(GetParamValue('Model'), GetParamValue('Description'), ImpExpConfig.Values['IDUser'], Result.Qty, CaseQty, varSellingPrice, varVendorCost);
  Result.Model.Category        := GetNewCategory(GetParamValue('Category'));
  Result.Model.ModelGroup      := GetNewModelGroup(GetParamValue('Sub-Category'));
  Result.Model.ModelSubGroup   := GetNewModelSubGroup(GetParamValue('Group'));
  Result.Model.Vendor          := GetNewVendor(GetParamValue('Vendor'));
  Result.Model.Manufacturer    := GetNewManufacturer(GetParamValue('Manufacturer'));
  Result.Model.VendorModelCode := GetNewVendorModelCode(GetParamValue('VendorModelCode'));

  Result.IDBarcode             := GetParamValue('Barcode');


end;

function TDMImportInventoryTextFile.GetNewCategory(Category: variant): TCategory;
var
  I: Integer;
begin
  if (Category = null) or (VarToStr(Category) = '') then
    Result := nil
  else
  begin
    Result          := TCategory.Create;
    Result.IDGroup  := null;
    Result.TabGroup := Category;
  end;
end;

function TDMImportInventoryTextFile.GetNewVendorModelCode(VendorModelCode: Variant): TVendorModelCode;
var
  I: Integer;
begin
  if (VendorModelCode = null) or (VendorModelCode = '') then
    Result := nil
  else
  begin
    Result                    := TVendorModelCode.Create;
    Result.IDVendorModelCode  := null;
    Result.IDVendor           := null;
    Result.IDModel            := null;
    Result.VendorCode         := VendorModelCode;
  end;
end;

function TDMImportInventoryTextFile.GetNewVendor(Vendor: Variant): TVendor;
var
  I : Integer;
begin
  if (Vendor = null) or (Vendor = '') then
    Result := nil
  else
  begin
    Result          := TVendor.Create;
    Result.IDVendor := null;
    Result.Vendor   := Vendor;
  end;
end;

function TDMImportInventoryTextFile.GetNewManufacturer(Manufacturer: Variant): TManufacturer;
var
  I : Integer;
begin
  if (Manufacturer = null) or (Manufacturer = '') then
    Result := nil
  else
  begin
    Result                := TManufacturer.Create;
    Result.IDManufacturer := null;
    Result.Manufacturer   := Manufacturer;
  end;
end;

procedure TDMImportInventoryTextFile.BeforeImport;
begin
  inherited;

  FDMImportInventory := TDMImportInventory.Create(Self);
  FDMImportInventory.SQLConnection := Self.SQLConnection;

  ConfigureCalcPrice( Self.SQLConnection );

  lstBarcodes := TList.Create;

  FImportQty  := ImpExpConfig.Values['UseQty'] = 'Y';
  FUpdateQty  := ImpExpConfig.Values['QtyActionType'] = 'R';
  FIDStore    := ImpExpConfig.Values['IDStore'];

end;

procedure TDMImportInventoryTextFile.ImportLine;
var
  aBarcode : TBarcode;
begin
  inherited;
  try
    lstBarcodes.Add(GetNewBarcode);
    FDMImportInventory.ImportBarcodes(lstBarcodes, FImportQty, FUpdateQty, FIDStore);
   finally
    while lstBarcodes.Count > 0 do
    begin
      aBarcode := TBarcode(lstBarcodes[0]);
      FreeAndNil(aBarcode);
      lstBarcodes.Delete(0);
    end;
    lstBarcodes.Clear;
  end;

end;


function TDMImportInventoryTextFile.GetNewModelGroup(
  ModelGroup: variant): TModelGroup;
var
  I: Integer;
begin
  if (ModelGroup = null) or (ModelGroup = '') then
    Result := nil
  else
  begin
    Result              := TModelGroup.Create;
    Result.IDModelGroup := null;
    Result.ModelGroup   := ModelGroup;
  end;
end;

function TDMImportInventoryTextFile.GetNewModelSubGroup(
  ModelSubGroup: variant): TModelSubGroup;
var
  I: Integer;
begin
  if (ModelSubGroup = null) or (ModelSubGroup = '') then
    Result := nil
  else
  begin
    Result                 := TModelSubGroup.Create;
    Result.IDModelSubGroup := null;
    Result.ModelSubGroup   := ModelSubGroup;
  end;
end;


procedure TDMImportInventoryTextFile.AfterImport;
begin
  inherited;

  if Assigned(FDMCalcPrice) then
    FreeAndNil(FDMCalcPrice);

  FreeAndNil(lstBarcodes);
end;


procedure TDMImportInventoryTextFile.ConfigureCalcPrice(
  SQLConnection: TADOConnection);
begin

  if not Assigned(FDMCalcPrice) then
    FDMCalcPrice := TDMCalcPrice.Create(Self);

  FDMCalcPrice.SetConnection(SQLConnection);
  FDMCalcPrice.UseMargin := DMGlobal.GetSvrParam(PARAM_CALC_MARGIN ,SQLConnection);
  FDMCalcPrice.UseRound  := DMGlobal.GetSvrParam(PARAM_CALC_ROUNDING, SQLConnection);
  
end;

end.

