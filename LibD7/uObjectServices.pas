(*
-----------------------------------------------------------------------------------------------------
Version : (287 - 275)
Date    : 11.10.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : When create a new model in inventory to a corporate store, must be
          create same model ( with quatntity = 0 ) to all client store.
Solution: Was implemented a new routine in order to become availably this functionality.
Version : (287 - 276)
-----------------------------------------------------------------------------------------------------
*)

unit uObjectServices;

interface

Uses SysUtils, Variants, ADODB, uContentClasses, uPetClasses, Windows;

type

  TObjectService = class
    private
    protected
      function Find(AObj: TObject): Boolean;   virtual; abstract;
      function Import(AObj: TObject): Boolean; virtual; abstract;
      function Update(AObj: TObject): Boolean; virtual; abstract;
      procedure ResetFind; virtual; abstract;
      procedure TestObjectClass(AObj: TObject); virtual; abstract;
    public
  end;

  TDBObjectService = class(TObjectService)
    private
      FSQLConnection: TADOConnection;
      procedure SetSQLConnection(const Value: TADOConnection);
    protected
      FSearchQuery: TADOQuery;
      FInsertQuery: TADOQuery;
      function GetPropertyDomain(AProperty: String): Variant;
    public
      property SQLConnection: TADOConnection read FSQLConnection write SetSQLConnection;
      constructor Create;
      destructor Destroy; override;
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function Update(AObj: TObject): Boolean; override;
      procedure ResetFind;                     override;
      procedure ResetInsert;
  end;

  TCatalogBarcodeService = class(TDBObjectService)
  private
    FCreadGroup : Boolean;
    procedure LoadSubObjects(ABarcode: TBarcode);
    procedure LoadModel(ABarcode: TBarcode);
    procedure LoadManufacturer(ABarcode: TBarcode);
    procedure LoadVendor(ABarcode: TBarcode);
    procedure LoadCategory(ABarcode: TBarcode);
    procedure LoadModelGroup(ABarcode: TBarcode);
    procedure LoadModelSubGroup(ABarcode: TBarcode);
    procedure LoadVendorModelCode(ABarcode: TBarcode);
    procedure LoadInventory(ABarcode: TBarcode);
    procedure LoadModelVendor(ABarcode: TBarcode);
    procedure LoadSuggestedVendorList(Barcode: TBarcode);
  public
    function Find(AObj: TObject): Boolean;   override;
    function FindByModel(AObj: TObject): Boolean;
    function FindByVendor(AObj: TObject): Boolean;
    function Import(AObj: TObject): Boolean; override;
    procedure TestObjectClass(AObj: TObject); override;
    function CanCreateGroup : Boolean;
  end;

  TMRBarcodeService = class(TDBObjectService)
    private
      function GetMaxBarcodeOrder(AIDModel: Integer): Integer;
      function InsertBarcode(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean): Boolean;
      function InsertBarcodeCase(Barcode: TBarcode): Boolean;
    public
      function Find(AObj: TObject): Boolean; override;
      function FindBarcodeCase(AObj: TObject): Boolean;
      function Import(AObj: TObject): Boolean; overload; override;
      function Import(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean): Boolean; reintroduce; overload;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TCatalogModelService = class(TDBObjectService)
  private
  public
    function Find(AObj: TObject): Boolean;   override;
    function Import(AObj: TObject): Boolean; override;
    procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRModelService = class(TDBObjectService)
    private
      function InsertModel(Model: TModel): Boolean;
      function UpdateModel(Model: TModel): Boolean;
      function UpdateModelPrices(Model: TModel): Boolean;
      { Alex 04/08/2011 }
      procedure LoadModel(Model: TModel);
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function Update(AObj: TObject): Boolean; override;
      function UpdatePrices(AObj: TObject): Boolean;
      procedure TestObjectClass(AObj: TObject); override;

      { Alex 04/08/2011 }
      function FindById(AObj: TObject): Boolean;

  end;

  TMRCategoryService  = class(TDBObjectService)
    private
      function InsertCategory(Category: TCategory): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  //Nao usar mais esse. Usar o TMREntityService
  TMRVendorService  = class(TDBObjectService)
    private
      function InsertVendor(Vendor: TVendor): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  //Nao usar mais esse. Usar o TMREntityService
  TMRManufacturerService  = class(TDBObjectService)
    private
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function SetModelManufacturer(Model: TModel; Manufacturer: TManufacturer): Boolean;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRStateService  = class(TDBObjectService)
    private
      function InsertState(State: TState): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;


  TMRModelGroupService  = class(TDBObjectService)
    private
      function InsertModelGroup(ModelGroup: TModelGroup): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRModelSubGroupService  = class(TDBObjectService)
    private
      function InsertModelSubGroup(ModelSubGroup: TModelSubGroup): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRVendorModelCodeService  = class(TDBObjectService)
    private
      function InsertVendorModelCode(VendorModelCode: TVendorModelCode): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
      { Alex 04/11/2011 }
      function FindByVendorCode(AObj: TObject): Boolean;
  end;

  TMRInventoryService = class(TDBObjectService)
    private
      function InsertInventoryMinMax(Inventory: TInventory): Boolean;
      function InsertInventoryQty(Inventory: TInventory): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRInventorySerialService = class(TDBObjectService)
    private
      function InsertInventorySerial(InventorySerial: TInventorySerial): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;


  TMRKitModelService  = class(TDBObjectService)
    private
      function InsertKitModel(KitModel: TKitModel): Boolean;
      function UpdateKitModel(KitModel: TKitModel): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function Update(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRPackModelService  = class(TDBObjectService)
    private
      function InsertPackModel(PackModel: TPackModel): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRModelVendorService  = class(TDBObjectService)
    private
      function InsertModelVendor(ModelVendor: TModelVendor): Boolean;
      function UpdateModelVendor(ModelVendor: TModelVendor): Boolean;
      function GetNextVendorOrder(ModelVendor: TModelVendor): Integer;
      { Alex 04/07/2011 }
      procedure LoadModelVendor( ModelVendor : TModelVendor );
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function Update(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMREntityService = class(TDBObjectService)
    private
      function InsertEntity(Entity: TEntity): Boolean;
      function UpdateEntity(Entity: TEntity): Boolean;
      function GetCode(IDTipoPessoa: Integer): Integer;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function Update(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRAnimalService = class(TDBObjectService)
    private
      function CreateBarcode : TBarcode;
      function InsertInventoryAnimal(Animal: TAnimal) : Boolean;
      function UpdateInventoryAnimal(Animal: TAnimal) : Boolean;
      function InsertInventoryPackModel(AIDPackModel, AIDModel : Integer; AQty : Double) : Boolean;
      function InsertInventoryMicrochipsInPack(AIDPackModel : Integer) : Boolean;
      function InsertAnimal(Animal: TAnimal): Boolean;
      function UpdateAnimal(Animal: TAnimal): Boolean;
      function FormatSex(ASex : String) : Char;
      function GetBreedName(IDBreed : Integer) : String;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      function Update(AObj: TObject): Boolean; override;
      function InsertOrUpdate(AObj: TObject) : Boolean;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRAnimalSpeciesService = class(TDBObjectService)
    private
      function InsertSpecies(Species: TSpecies): Boolean;
      function UpdateSpecies(Species: TSpecies): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
      function Update(AObj: TObject): Boolean; override;
  end;

  TMRAnimalBreedService = class(TDBObjectService)
    private
      function InsertBreed(Breed: TBreed): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRAnimalColorService = class(TDBObjectService)
    private
      function InsertAnimalColor(AnimalColor: TAnimalColor): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRAnimalMicrochipService = class(TDBObjectService)
    private
      FIDPet : Variant;
      FIDKitModel : Variant;
      function InsertMicrochip(Microchip: TMicrochip): Boolean;
      function InsertKitModelMicrochip(Microchip: TMicrochip) : Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
      property IDPet : Variant read FIDPet write FIDPet;
  end;

  TMRAnimalWeightService = class(TDBObjectService)
    private
      FIDPet : Variant;
      function InsertWeight(AnimalWeight: TAnimalWeight): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
      property IDPet : Variant read FIDPet write FIDPet;
  end;

  TMRAnimalRegistryService = class(TDBObjectService)
    private
      FIDPet : Variant;
      function InsertRegistry(AnimalRegistry: TAnimalRegistry): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function FindRegistration(AObj: TObject): Boolean;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
      property IDPet : Variant read FIDPet write FIDPet;
  end;

  TMRTreatmentService = class(TDBObjectService)
    private
      function InsertTreatment(AnimalTreatment: TAnimalTreatment): Boolean;
      function InsertTreatmentLot(AnimalTreatment: TAnimalTreatment): Boolean;
    public
      function FindLot(AObj: TObject): Boolean;
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
  end;

  TMRAnimalTreatmentService = class(TDBObjectService)
    private
      FIDPet : Variant;
      function InsertAnimalTreatment(AnimalTreatment: TAnimalTreatment): Boolean;
    public
      function Find(AObj: TObject): Boolean;   override;
      function Import(AObj: TObject): Boolean; override;
      procedure TestObjectClass(AObj: TObject); override;
      property IDPet : Variant read FIDPet write FIDPet;
  end;

implementation

uses uDebugFunctions, DB, uMsgBox, uMsgConstant, uSystemConst, Classes, Registry, uOperationSystem;

function GetNextCode(const TableName,
  FieldName: WideString; SQLConnection: TADOConnection): Integer;
var
  TableField: String;
  bEmpty : Boolean;
begin
  TableField := TableName + '.' + FieldName;

  try

    ///  Começa Novo
    with TADOQuery.Create(nil) do
    try
      Connection := SQLConnection;

      SQL.Text := ' SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = ' + QuotedStr(TableField);

      Open;
      bEmpty := IsEmpty;
      Result := FieldByName('UltimoCodigo').AsInteger + 1;

    finally
      Close;
      Free;
    end;

     //Cria o campo caso nao tenha
    if bEmpty then
      SQLConnection.Execute('INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo) VALUES (' + QuotedStr(TableField) + ',0)');

    //Salva o proximo registro
    SQLConnection.Execute(' UPDATE  Sis_CodigoIncremental SET UltimoCodigo = UltimoCodigo + 1 '+
           ' FROM Sis_CodigoIncremental WHERE Tabela = ' + QuotedStr(TableField));

  except
    Result := -1;
  end;
end;

{ TDBObjectService }

constructor TDBObjectService.Create;
begin
  inherited Create;
  //SQLConnection := nil;
  FSearchQuery := TADOQuery.Create(nil);
  FInsertQuery := TADOQuery.Create(nil);
end;

destructor TDBObjectService.Destroy;
begin
  FSearchQuery.Close;
  FInsertQuery.Close;
  FSearchQuery.Free;
  FInsertQuery.Free;
  //SQLConnection := nil;
    
  inherited Destroy;
end;

function TDBObjectService.Find(AObj: TObject): Boolean;
begin
  Result := False;
  if SQLConnection = nil then
    raise Exception.Create('Missing SQL Connection - TDBObjectService.Find');
  ResetFind;
  Result := True;
end;

function TDBObjectService.GetPropertyDomain(AProperty: String): Variant;
var
  FQuery : TADOQuery;
begin
  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := SQLConnection;
    FQuery.SQL.Add('SELECT PropertyValue');
    FQuery.SQL.Add('FROM Sis_PropertyDomain');
    FQuery.SQL.Add('WHERE Property = :Property');
    FQuery.Parameters.ParamByName('Property').Value := AProperty;
    FQuery.Open;
    Result := FQuery.FieldByName('PropertyValue').Value;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TDBObjectService.Import(AObj: TObject): Boolean;
begin
  Result := False;
  if SQLConnection = nil then
    raise Exception.Create('Missing SQL Connection - TDBObjectService.Import');
  Result := True;
end;

procedure TDBObjectService.ResetFind;
begin
  inherited;
    if FSearchQuery.Active then
      FSearchQuery.Close;
    FSearchQuery.SQL.Clear;
end;

procedure TDBObjectService.ResetInsert;
begin
    if FInsertQuery.Active then
      FInsertQuery.Close;
    FInsertQuery.SQL.Clear;
end;

procedure TDBObjectService.SetSQLConnection(const Value: TADOConnection);
begin
  FSQLConnection := Value;
  FSearchQuery.Connection := FSQLConnection;
  FInsertQuery.Connection := FSQLConnection;
end;

function TDBObjectService.Update(AObj: TObject): Boolean;
begin
  Result := False;
  if SQLConnection = nil then
    raise Exception.Create('Missing SQL Connection - TDBObjectService.Update');
  Result := True;
end;

{ TCatalogBarcodeService }

function TCatalogBarcodeService.Find(AObj: TObject): Boolean;
var
  Barcode: TBarcode;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Barcode := TBarcode(AObj);

    FSearchQuery.SQL.Text := 'SELECT '+
                             '  CP.sku, '+
                             '  CP.upc, '+
                             '  CP.Title, '+
                             '  PV.vCost as VendorCost, '+
                             '  CP.wholesale, '+
                             '  CP.Department, '+
                             '  CP.Category, '+
                             '  CP.SubCategory, '+
                             '  CP.Tax_Category, '+
                             '  CP.Mfg, '+
                             '  CP.retail_price, '+
                             '  V.Vendor, '+
                             '  V.IDVendorMR, '+
                             '  PV.vsell_pkg as CaseQty, '+
                             '  PV.vsku as VendorModelCode, '+
                             '  PV.vmin_qty as MinQtyPO, '+
                             '  PV.vbatch_qty as VendorCaseQty '+
                             'FROM '+
                             '  MRCatalogDB..Products CP (NOLOCK) '+
                             '  JOIN MRCatalogDB..Products_Vendors PV (NOLOCK) ON (CP.Sku = PV.Sku) '+
                             '  JOIN MRCatalogDB..Vendors V (NOLOCK) ON (V.IDVendor = PV.IDVendor AND V.IDVendorMR IS NOT NULL) '+
                             'WHERE '+
                             '  CP.Inactive = 0 ' +
                             '  AND PV.VInactive = 0 ' +
                             '  AND CP.upc = ' + QuotedStr(Barcode.IDBarcode) +
                             'ORDER BY ' +
                             '  PV.vCost '; //Menor preco

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;

      if Result then
      begin
        FCreadGroup := CanCreateGroup;
        LoadSubObjects(Barcode);
        LoadSuggestedVendorList(Barcode);
      end;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(MSG_INF_CATALOG_NOT_FOUND +'_'+E.Message);
      Result := False;
    end;
  end;
end;

function TCatalogBarcodeService.CanCreateGroup: Boolean;
var
  FQuery : TADOQuery;
begin

  Result := False;
  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add('SELECT SrvValue FROM Param WHERE IDParam = 93');
    FQuery.Open;
    Result := (LowerCase(FQuery.FieldByName('SrvValue').AsString) = 'true');
    FQuery.Close;
  finally
     FreeAndNil(FQuery);
    end;

end;


procedure TCatalogBarcodeService.LoadManufacturer(ABarcode: TBarcode);
var
  Manufacturer: TManufacturer;
  MRManufacturerService: TMRManufacturerService;
begin
  Manufacturer                  := TManufacturer.Create;
  Manufacturer.Manufacturer     := Trim(FSearchQuery.FieldByName('Mfg').AsString);

  MRManufacturerService         := TMRManufacturerService.Create;
  MRManufacturerService.SQLConnection := SQLConnection;
  MRManufacturerService.Find(Manufacturer);

  ABarcode.Model.Manufacturer    := Manufacturer;
end;

procedure TCatalogBarcodeService.LoadVendor(ABarcode: TBarcode);
var
  Vendor: TVendor;
  MRVendorService:       TMRVendorService;
begin
  Vendor                        := TVendor.Create;
  Vendor.Vendor                 := Trim(FSearchQuery.FieldByName('Vendor').AsString);
  Vendor.IDVendor               := FSearchQuery.FieldByName('IDVendorMR').AsInteger;

  MRVendorService               := TMRVendorService.Create;
  MRVendorService.SQLConnection := SQLConnection;
  MRVendorService.Find(Vendor);

  ABarcode.Model.Vendor          := Vendor;
end;

procedure TCatalogBarcodeService.LoadCategory(ABarcode: TBarcode);
var
  Category: TCategory;
  MRCategoryService: TMRCategoryService;
begin
  Category                := TCategory.Create;
  Category.TabGroup       := Trim(FSearchQuery.FieldByName('Department').AsString);

  MRCategoryService               := TMRCategoryService.Create();
  MRCategoryService.SQLConnection := SQLConnection;
  MRCategoryService.Find(Category);

  ABarcode.Model.Category := Category;
end;

procedure TCatalogBarcodeService.LoadModelGroup(ABarcode: TBarcode);
var
  ModelGroup: TModelGroup;
  MRModelGroupService:   TMRModelGroupService;
begin
  ModelGroup                := TModelGroup.Create;
  ModelGroup.ModelGroup     := Trim(FSearchQuery.FieldByName('Category').AsString);

  MRModelGroupService               := TMRModelGroupService.Create();
  MRModelGroupService.SQLConnection := SQLConnection;

  ModelGroup.IDGroup := ABarcode.Model.Category.IDGroup;

  if FCreadGroup then
    MRModelGroupService.Import(ModelGroup)
  else
    MRModelGroupService.Find(ModelGroup);

  ABarcode.Model.ModelGroup := ModelGroup;
end;

function TCatalogBarcodeService.Import(AObj: TObject): Boolean;
begin
  Result := True;
end;

procedure TCatalogBarcodeService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TBarcode) then
    raise Exception.Create('Object type Mismatch - TCatalogBarcodeService.TestObjectClass');
end;

procedure TCatalogBarcodeService.LoadSubObjects(ABarcode: TBarcode);
begin
  LoadModel(ABarcode);
  LoadManufacturer(ABarcode);
  LoadVendor(ABarcode);
  LoadVendorModelCode(ABarcode);
  LoadModelVendor(ABarcode);
  LoadCategory(ABarcode);
  LoadModelGroup(ABarcode);
  LoadModelSubGroup(ABarcode);
  LoadInventory(ABarcode);
end;

procedure TCatalogBarcodeService.LoadModel(ABarcode: TBarcode);
var
  Model: TModel;
begin
  if not Assigned(ABarcode.Model) then
  begin
    Model                     := TModel.Create;
    ABarcode.Model            := Model;
  end
  else
    ABarcode.IDBarcode        := Trim(FSearchQuery.FieldByName('upc').AsString);

  ABarcode.Model.IDModel         := NULL;
  ABarcode.Model.Model           := Trim(FSearchQuery.FieldByName('sku').AsString);
  ABarcode.Model.Description     := Trim(FSearchQuery.FieldByName('Title').AsString);
  ABarcode.Model.VendorCost      := FSearchQuery.FieldByName('VendorCost').AsCurrency;
  ABarcode.Model.SuggRetail      := FSearchQuery.FieldByName('retail_price').AsCurrency;
  ABarcode.Model.CaseQty         := FSearchQuery.FieldByName('CaseQty').AsFloat;
end;

function TCatalogBarcodeService.FindByModel(AObj: TObject): Boolean;
var
  Barcode: TBarcode;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Barcode := TBarcode(AObj);

    FSearchQuery.SQL.Text := 'SELECT '+
                             '  CP.sku, '+
                             '  CP.upc, '+
                             '  CP.Title, '+
                             '  PV.vCost as VendorCost, '+
                             '  CP.wholesale, '+
                             '  CP.Department, '+
                             '  CP.Category, '+
                             '  CP.SubCategory, '+
                             '  CP.Tax_Category, '+
                             '  CP.Mfg, '+
                             '  CP.retail_price, '+
                             '  V.Vendor, '+
                             '  V.IDVendorMR, '+
                             '  PV.vsell_pkg as CaseQty, '+
                             '  PV.vsku as VendorModelCode, '+
                             '  PV.vmin_qty as MinQtyPO, '+
                             '  PV.vbatch_qty as VendorCaseQty '+
                             'FROM '+
                             '  MRCatalogDB..Products CP (NOLOCK) '+
                             '  JOIN MRCatalogDB..Products_Vendors PV (NOLOCK) ON (CP.Sku = PV.Sku) '+
                             '  JOIN MRCatalogDB..Vendors V (NOLOCK) ON (V.IDVendor = PV.IDVendor AND V.IDVendorMR IS NOT NULL ) '+
                             'WHERE '+
                             '  CP.Inactive = 0 ' +
                             '  AND PV.VInactive = 0 ' +
                             '  AND CP.sku = ' + QuotedStr(Barcode.Model.Model);

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;

      if Result then
      begin
        LoadSubObjects(Barcode);
        LoadSuggestedVendorList(Barcode);
      end;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(MSG_INF_CATALOG_NOT_FOUND +'_'+E.Message);
      Result := False;
    end;
  end;
end;

function TCatalogBarcodeService.FindByVendor(AObj: TObject): Boolean;
var
  Barcode: TBarcode;
begin

  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Barcode := TBarcode(AObj);

    FSearchQuery.SQL.Text := 'SELECT '+
                             '  CP.sku, '+
                             '  CP.upc, '+
                             '  CP.Title, '+
                             '  PV.vCost as VendorCost, '+
                             '  CP.wholesale, '+
                             '  CP.Department, '+
                             '  CP.Category, '+
                             '  CP.SubCategory, '+
                             '  CP.Tax_Category, '+
                             '  CP.Mfg, '+
                             '  CP.retail_price, '+
                             '  V.Vendor, '+
                             '  V.IDVendorMR, '+
                             '  PV.vsell_pkg as CaseQty, '+
                             '  PV.vsku as VendorModelCode, '+
                             '  PV.vmin_qty as MinQtyPO, '+
                             '  PV.vbatch_qty as VendorCaseQty '+
                             'FROM '+
                             '  MRCatalogDB..Products CP (NOLOCK) '+
                             '  JOIN MRCatalogDB..Products_Vendors PV (NOLOCK) ON (CP.Sku = PV.Sku) '+
                             '  JOIN MRCatalogDB..Vendors V (NOLOCK) ON (V.IDVendor = PV.IDVendor AND V.IDVendorMR IS NOT NULL) '+
                             'WHERE '+
                             '  CP.Inactive = 0 ' +
                             '  AND PV.VInactive = 0 ' +
                             '  AND CP.upc = ' + QuotedStr(Barcode.IDBarcode) +
                             '  AND V.Vendor = ' + QuotedStr(Barcode.Model.Vendor.Vendor);

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;

      if Result then
      begin
        LoadSubObjects(Barcode);
        LoadSuggestedVendorList(Barcode);
      end;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(MSG_INF_CATALOG_NOT_FOUND +'_'+E.Message);
      Result := False;
    end;
  end;
end;

procedure TCatalogBarcodeService.LoadVendorModelCode(ABarcode: TBarcode);
var
  VendorModelCode: TVendorModelCode;
  MRVendorModelCodeService:   TMRVendorModelCodeService;
begin
  VendorModelCode                 := TVendorModelCode.Create;
  VendorModelCode.VendorCode      := Trim(FSearchQuery.FieldByName('VendorModelCode').AsString);
  VendorModelCode.IDModel         := ABarcode.Model.IDModel;
  VendorModelCode.IDVendor        := ABarcode.Model.Vendor.IDVendor;

  MRVendorModelCodeService               := TMRVendorModelCodeService.Create();
  MRVendorModelCodeService.SQLConnection := SQLConnection;
  MRVendorModelCodeService.Find(VendorModelCode);

  ABarcode.Model.VendorModelCode := VendorModelCode;
end;

procedure TCatalogBarcodeService.LoadInventory(ABarcode: TBarcode);
var
  Inventory: TInventory;
  MRInventoryService:   TMRInventoryService;
begin
  Inventory                 := TInventory.Create;
  Inventory.QtyOnHand       := 0;
  Inventory.MinQty          := 0;
  Inventory.MaxQty          := 0;
  Inventory.IDModel         := ABarcode.Model.IDModel;
  Inventory.IDStore         := null;

  MRInventoryService               := TMRInventoryService.Create();
  MRInventoryService.SQLConnection := SQLConnection;
  MRInventoryService.Find(Inventory);

  ABarcode.Model.Inventory := Inventory;

end;

procedure TCatalogBarcodeService.LoadModelSubGroup(ABarcode: TBarcode);
var
  ModelSubGroup: TModelSubGroup;
  MRModelSubGroupService: TMRModelSubGroupService;
begin
  ModelSubGroup                := TModelSubGroup.Create;
  ModelSubGroup.ModelSubGroup  := Trim(FSearchQuery.FieldByName('SubCategory').AsString);

  MRModelSubGroupService               := TMRModelSubGroupService.Create();
  MRModelSubGroupService.SQLConnection := SQLConnection;

  ModelSubGroup.IDModelGroup := ABarcode.Model.ModelGroup.IDModelGroup;

  if FCreadGroup then
    MRModelSubGroupService.Import(ModelSubGroup)
  else
    MRModelSubGroupService.Find(ModelSubGroup);

  ABarcode.Model.ModelSubGroup := ModelSubGroup;
end;

procedure TCatalogBarcodeService.LoadModelVendor(ABarcode: TBarcode);
var
  ModelVendor: TModelVendor;
  MRModelVendorService: TMRModelVendorService;
begin
  ModelVendor                := TModelVendor.Create;
  ModelVendor.MinQtyPO       := FSearchQuery.FieldByName('MinQtyPO').AsFloat;
  ModelVendor.CaseQty        := FSearchQuery.FieldByName('VendorCaseQty').AsFloat;
  ModelVendor.IDModel        := ABarcode.Model.IDModel;
  ModelVendor.IDVendor       := ABarcode.Model.Vendor.IDVendor;

  MRModelVendorService               := TMRModelVendorService.Create();
  MRModelVendorService.SQLConnection := SQLConnection;
  MRModelVendorService.Find(ModelVendor);

  ABarcode.Model.ModelVendor := ModelVendor;
end;


procedure TCatalogBarcodeService.LoadSuggestedVendorList(Barcode: TBarcode);
var
  FVendorSuggestedList : TVendorSuggestedList;
begin
  with FSearchQuery do
    if (RecordCount > 1) then
    begin
      First;
      while not EOF do
      begin
        if FSearchQuery.FieldByName('IDVendorMR').AsInteger <> 0 then
        begin
          FVendorSuggestedList := TVendorSuggestedList.Create;
          FVendorSuggestedList.IDVendor   := FSearchQuery.FieldByName('IDVendorMR').AsInteger;
          FVendorSuggestedList.VendorCost := FSearchQuery.FieldByName('VendorCost').AsCurrency;
          FVendorSuggestedList.Vendor     := FSearchQuery.FieldByName('Vendor').AsString;
          FVendorSuggestedList.CaseQty    := FSearchQuery.FieldByName('VendorCaseQty').AsFloat;
          FVendorSuggestedList.MinQtyPO   := FSearchQuery.FieldByName('MinQtyPO').AsFloat;
          FVendorSuggestedList.VendorCode := FSearchQuery.FieldByName('VendorModelCode').AsString;
          Barcode.Model.FSuggestedVendor.AddObject('', FVendorSuggestedList);
        end;
        Next;
      end;
    end;
end;

{ TMRBarcodeService }

function TMRBarcodeService.Find(AObj: TObject): Boolean;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);
    FSearchQuery.SQL.Add(Format('SELECT IDBarcode FROM Barcode WHERE IDBarcode = %S', [QuotedStr(VarToStr(TBarcode(AObj).IDBarcode))]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;

  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRBarcodeService.Import(AObj: TObject): Boolean;
var
  Barcode: TBarcode;
begin
  TestObjectClass(AObj);
  inherited Import(AObj);
  Barcode := TBarcode(AObj);
  Result := Import(Barcode, False, False);
end;

function TMRBarcodeService.Import(Barcode: TBarcode; UseQty: Boolean; UpdateQty: Boolean): Boolean;
var
  Model : TModel;
  Category: TCategory;
  Vendor: TVendor;
  Manufacturer: TManufacturer;
  ModelGroup: TModelGroup;
  ModelSubGroup: TModelSubGroup;
  VendorModelCode: TVendorModelCode;
  ModelVendor: TModelVendor;
  Inventory: TInventory;
  InventorySerial: TInventorySerial;
begin
  Result := True;
  try
    Model := Barcode.Model;

    if Model = nil then
      begin
        Category      := nil;
        Vendor        := nil;
        Manufacturer  := nil;
        ModelGroup    := nil;
        ModelSubGroup := nil;
        ModelVendor   := nil;
      end
    else
      begin
        Category        := Model.Category;
        Vendor          := Model.Vendor;
        Manufacturer    := Model.Manufacturer;
        ModelGroup      := Model.ModelGroup;
        ModelSubGroup   := Model.ModelSubGroup;
        VendorModelCode := Model.VendorModelCode;
        Inventory       := Model.Inventory;
        ModelVendor     := Model.ModelVendor;
        InventorySerial := Model.InventorySerial;
      end;

    if Category <> nil then
      with TMRCategoryService.Create do
      try
        SQLConnection := Self.SQLConnection;
        Import(Category);
      finally
        Free;
      end;


    if Model <> nil then
      with TMRModelService.Create do
      try
        SQLConnection := Self.SQLConnection;
        Import(Model);
      finally
        Free;
      end;

    if Manufacturer <> nil then
      with TMRManufacturerService.Create do
      try
        SQLConnection := Self.SQLConnection;
        if Import(Manufacturer) then
          SetModelManufacturer(Model, Manufacturer);
      finally
        Free;
      end;

    if (Vendor <> nil) and (Vendor.IDVendor <> null) then
      with TMRVendorService.Create do
      try
        SQLConnection := Self.SQLConnection;
        if Import(Vendor) then
        begin
          if(ModelVendor <> nil) then
          with TMRModelVendorService.Create do
          try
            ModelVendor.IDModel := Barcode.Model.IDModel;
            SQLConnection := Self.SQLConnection;
            Import(ModelVendor);
          finally
            Free;
          end;

          if (VendorModelCode <> nil) and (VendorModelCode.VendorCode <> '') then
          with TMRVendorModelCodeService.Create do
          try
            SQLConnection := Self.SQLConnection;

            if (Model.IDModel <> 0) and (Model.Vendor.IDVendor <> 0) and
               (Model.IDModel <> null) and (Model.Vendor.IDVendor <> null) then
            begin
              VendorModelCode.IDModel  := Model.IDModel;
              VendorModelCode.IDVendor := Model.Vendor.IDVendor;
              Import(VendorModelCode)
            end;
          finally
            Free;
          end;
        end;
      finally
        Free;
      end;

    if Inventory <> nil then
      with TMRInventoryService.Create do
      try
        SQLConnection := Self.SQLConnection;

        if (Model.IDModel <> 0) and (Model.IDModel <> null) then
        begin
          Inventory.IDModel  := Model.IDModel;
          Import(Inventory);
        end;
      finally
        Free;
      end;

    if InventorySerial <> nil then
      with TMRInventorySerialService.Create do
      try
        SQLConnection := Self.SQLConnection;

        if (Model.IDModel <> 0) and (Model.IDModel <> null) then
        begin
          InventorySerial.ModelID  := Model.IDModel;
          Import(InventorySerial);
        end;
      finally
        Free;
      end;

    if Barcode.IDBarcode <> Null then
      if not Find(Barcode) then
        Result := InsertBarcode(Barcode, UseQty, UpdateQty);

    if VarToStr(Barcode.BarcodeCase) <> '' then
      if (Barcode.Model.CaseQty > 1) and (not FindBarcodeCase(Barcode)) then
        Result := InsertBarcodeCase(Barcode);

  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRBarcodeService.GetMaxBarcodeOrder(AIDModel: Integer): Integer;
begin

  with TADOQuery.Create(nil) do
  try
    Connection := FSQLConnection;
    SQL.Text := 'SELECT IsNull(MAX(BarcodeOrder), 0) MaxOrder FROM Barcode WHERE IDModel = ' + IntToStr(AIDModel);
    Open;
    Result := FieldByName('MaxOrder').AsInteger+1;
  finally
    Free;
  end;

end;


function TMRBarcodeService.InsertBarcode(Barcode: TBarcode; UseQty,
  UpdateQty: Boolean): Boolean;
begin

  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;

      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO Barcode');
      FInsertQuery.SQL.Add('  (IDBarcode, IDModel, Data, BarcodeOrder ) ');
      FInsertQuery.SQL.Add('VALUES (:IDBarcode, :IDModel, :Date1, :BarcodeOrder) ');

      FInsertQuery.Parameters.ParamByName('IDBarcode').Value      := Barcode.IDBarcode;
      FInsertQuery.Parameters.ParamByName('IDModel').Value        := Barcode.Model.IDModel;
      FInsertQuery.Parameters.ParamByName('Date1').Value          := Now;
      FInsertQuery.Parameters.ParamByName('BarcodeOrder').Value   := GetMaxBarcodeOrder(Barcode.Model.IDModel);
      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;

end;

procedure TMRBarcodeService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TBarcode) then
    raise Exception.Create('Object type Mismatch - TMRBarcodeService.TestObjectClass');
end;


function TMRBarcodeService.FindBarcodeCase(AObj: TObject): Boolean;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);
    FSearchQuery.SQL.Add(Format('SELECT IDBarcode FROM Barcode WHERE IDBarcode = %S', [QuotedStr(VarToStr(TBarcode(AObj).BarcodeCase))]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;

  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRBarcodeService.InsertBarcodeCase(Barcode: TBarcode): Boolean;
begin

  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;

      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO Barcode');
      FInsertQuery.SQL.Add('  (IDBarcode, IDModel, Data, BarcodeOrder, Qty ) ');
      FInsertQuery.SQL.Add('VALUES (:IDBarcode, :IDModel, :Date1, :BarcodeOrder, :Qty) ');

      FInsertQuery.Parameters.ParamByName('IDBarcode').Value      := Barcode.BarcodeCase;
      FInsertQuery.Parameters.ParamByName('IDModel').Value        := Barcode.Model.IDModel;
      FInsertQuery.Parameters.ParamByName('Date1').Value          := Now;
      FInsertQuery.Parameters.ParamByName('BarcodeOrder').Value   := GetMaxBarcodeOrder(Barcode.Model.IDModel);
      FInsertQuery.Parameters.ParamByName('Qty').Value            := Barcode.Model.CaseQty;
      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;

end;

{ TMRCategoryService }

function TMRCategoryService.Find(AObj: TObject): Boolean;
var
  Category: TCategory;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Category := TCategory(AObj);

    Category.IDGroup := 0;

    FSearchQuery.SQL.Add(Format('SELECT IDGroup FROM TabGroup WHERE Name = %S', [QuotedStr(Category.TabGroup)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Category.IDGroup := FSearchQuery.FieldByName('IDGroup').AsInteger
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;


function TMRCategoryService.Import(AObj: TObject): Boolean;
var
  Category: TCategory;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    Category := TCategory(AObj);
    if (Category.IDGroup = null) and (Category.TabGroup <> '') then
      begin
        if Find(Category) then
          Result := True
        else
          Result := InsertCategory(Category)
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRCategoryService.InsertCategory(Category: TCategory): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('TabGroup', 'IDGroup', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO TabGroup');
      FInsertQuery.SQL.Add('  (IDGroup, Name)');
      FInsertQuery.SQL.Add('VALUES');
      FInsertQuery.SQL.Add(
               Format('  (%D, %S)',
                      [tmpID,
                      QuotedStr(Category.TabGroup)
                      ]
                     )
              );
      FInsertQuery.ExecSQL;
      Category.IDGroup := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRCategoryService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TCategory) then
    raise Exception.Create('Object type Mismatch - TMRCategoryService.TestObjectClass');
end;


{ TMRVendorService }

function TMRVendorService.Find(AObj: TObject): Boolean;
var
  Vendor: TVendor;
begin
  Result := True;

  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Vendor := TVendor(AObj);

    if (VarToStr(Vendor.IDVendor) = '') then
    begin
      Vendor.IDVendor := 0;

      FSearchQuery.SQL.Add('SELECT');
      FSearchQuery.SQL.Add('	IDPessoa');
      FSearchQuery.SQL.Add('FROM');
      FSearchQuery.SQL.Add('	Pessoa P INNER JOIN');
      FSearchQuery.SQL.Add('	TipoPessoa TP ON');
      FSearchQuery.SQL.Add('		(P.IDTipoPessoa = TP.IDTipoPessoa)');
      FSearchQuery.SQL.Add('WHERE');
      FSearchQuery.SQL.Add('	P.IDTipoPessoaRoot = 2');
      FSearchQuery.SQL.Add('	AND');
      FSearchQuery.SQL.Add('	TP.Path LIKE ' + QuotedStr('.002%'));
      FSearchQuery.SQL.Add('	AND');
      FSearchQuery.SQL.Add(Format('	P.Pessoa = %S', [QuotedStr(Vendor.Vendor)]));
      FSearchQuery.Open;
      try
        Result := not FSearchQuery.IsEmpty;
        if Result then
          Vendor.IDVendor := FSearchQuery.FieldByName('IDPessoa').AsInteger;
      finally
        FSearchQuery.Close;
      end;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRVendorService.Import(AObj: TObject): Boolean;
var
  Vendor: TVendor;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    Vendor := TVendor(AObj);
    if Vendor.IDVendor = null then
      begin
        if Find(Vendor) then
          Result := True
        else
          Result := InsertVendor(Vendor);
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRVendorService.InsertVendor(Vendor: TVendor): Boolean;
var
  tmpID: Integer;
begin
    Result := True;
    try
      tmpID := GetNextCode('Pessoa', 'IDPessoa', FSQLConnection);
      FInsertQuery.SQL.Add('INSERT INTO Pessoa');
      FInsertQuery.SQL.Add('  (IDPessoa, IDTipoPessoa, Pessoa, IDTipoPessoaRoot)');
      FInsertQuery.SQL.Add('VALUES');
      FInsertQuery.SQL.Add(
               Format('  (%D, 2, %S, 2)',
                      [tmpID,
                      QuotedStr(Vendor.Vendor)
                      ]
                     )
              );
      FInsertQuery.ExecSQL;
      Vendor.IDVendor := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
end;

procedure TMRVendorService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TVendor) then
    raise Exception.Create('Object type Mismatch - TMRVendorService.TestObjectClass');
end;

{ TMRManufacturerService }

function TMRManufacturerService.Find(AObj: TObject): Boolean;
var
  Manufacturer: TManufacturer;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Manufacturer := TManufacturer(AObj);

    Manufacturer.IDManufacturer := 0;

    FSearchQuery.SQL.Text := 'SELECT '+
                             '  P.IDPessoa '+
                             'FROM '+
                             '  Pessoa P INNER '+
                             '  JOIN TipoPessoa TP ON (P.IDTipoPessoa = TP.IDTipoPessoa) '+
                             'WHERE '+
                             '	TP.Path LIKE ( ' + QuotedStr('.004%') + ' ) ' +
                             '  AND '+
                             '  P.Pessoa = ' + QuotedStr(Manufacturer.Manufacturer);
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Manufacturer.IDManufacturer := FSearchQuery.FieldByName('IDPessoa').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRManufacturerService.Import(AObj: TObject): Boolean;
begin
  Result := False;
end;

function TMRManufacturerService.SetModelManufacturer(Model: TModel;
  Manufacturer: TManufacturer): Boolean;
begin
  Result := False;
end;

procedure TMRManufacturerService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TManufacturer) then
    raise Exception.Create('Object type Mismatch - TMRManufacturerService.TestObjectClass');
end;

{ TMRModelGroupService }

function TMRModelGroupService.Find(AObj: TObject): Boolean;
var
  ModelGroup: TModelGroup;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      ModelGroup := TModelGroup(AObj);

    ModelGroup.IDModelGroup := NULL;

    FSearchQuery.SQL.Add(Format('SELECT IDModelGroup, IDGroup FROM ModelGroup WHERE ModelGroup = %S AND IDGroup = %S', [QuotedStr(ModelGroup.ModelGroup), IntToStr(ModelGroup.IDGroup)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
      begin
        ModelGroup.IDModelGroup := FSearchQuery.FieldByName('IDModelGroup').AsInteger;
        ModelGroup.IDGroup := FSearchQuery.FieldByName('IDGroup').AsInteger;
      end;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelGroupService.Import(AObj: TObject): Boolean;
var
  ModelGroup: TModelGroup;
begin

  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    ModelGroup := TModelGroup(AObj);
    if (ModelGroup.IDModelGroup = null) and (ModelGroup.ModelGroup <> '') then
      begin
        if Find(ModelGroup) then
          Result := True
        else
          Result := InsertModelGroup(ModelGroup)
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelGroupService.InsertModelGroup(
  ModelGroup: TModelGroup): Boolean;
var
  tmpID, IDGroup: integer;
begin

  Result  := False;
  IDGroup := 0;

  if Assigned(ModelGroup) then
    IDGroup := ModelGroup.IDGroup;


  if (IDGroup <> 0) then
    try
      Result := True;
      try
        if FInsertQuery.Active then
          FInsertQuery.Close;
        tmpID := GetNextCode('ModelGroup', 'IDModelGroup', FSQLConnection);

        FInsertQuery.SQL.Add('INSERT INTO ModelGroup');
        FInsertQuery.SQL.Add('  (IDModelGroup, ModelGroup, IDGroup)');
        FInsertQuery.SQL.Add('VALUES');
        FInsertQuery.SQL.Add(
                 Format('  (%D, %S, %D)',
                        [tmpID,
                        QuotedStr(ModelGroup.ModelGroup),
                        IDGroup
                        ]
                       )
                );

        FInsertQuery.ExecSQL;
        ModelGroup.IDModelGroup := tmpID;
      except
        on E: Exception do
        begin
          raise Exception.Create(E.Message);
          Result := False;
        end;
      end;
    finally
      FInsertQuery.Close;
    end;
end;

procedure TMRModelGroupService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TModelGroup) then
    raise Exception.Create('Object type Mismatch - TMRModelGroupService.TestObjectClass');
end;

{ TMRModelSubGroupService }

function TMRModelSubGroupService.Find(AObj: TObject): Boolean;
var
  ModelSubGroup: TModelSubGroup;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      ModelSubGroup := TModelSubGroup(AObj);

    ModelSubGroup.IDModelSubGroup := NULL;

    FSearchQuery.SQL.Add(Format('SELECT IDModelSubGroup, IDModelGroup FROM ModelSubGroup WHERE ModelSubGroup = %S AND IDModelGroup = %S', [QuotedStr(ModelSubGroup.ModelSubGroup), VarToStrDef(ModelSubGroup.IDModelGroup, '-1')]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
      begin
        ModelSubGroup.IDModelSubGroup := FSearchQuery.FieldByName('IDModelSubGroup').AsInteger;
        ModelSubGroup.IDModelGroup := FSearchQuery.FieldByName('IDModelGroup').AsInteger;
      end;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelSubGroupService.Import(AObj: TObject): Boolean;
var
  ModelSubGroup: TModelSubGroup;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    ModelSubGroup := TModelSubGroup(AObj);
    if (ModelSubGroup.IDModelSubGroup = null) and (ModelSubGroup.ModelSubGroup <> '') then
      begin
        if Find(ModelSubGroup) then
          Result := True
        else
          Result := InsertModelSubGroup(ModelSubGroup)
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelSubGroupService.InsertModelSubGroup(
  ModelSubGroup: TModelSubGroup): Boolean;
var
  tmpID, IDSubGroup: integer;

begin

  Result := False;
  IDSubGroup := 0;

  if Assigned(ModelSubGroup) then
    IDSubGroup := StrToIntDef(VarToStr(ModelSubGroup.IDModelGroup),0);

  if (IDSubGroup <> 0) then
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('ModelSubGroup', 'IDModelSubGroup', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO ModelSubGroup');
      FInsertQuery.SQL.Add('  (IDModelSubGroup, ModelSubGroup, IDModelGroup)');
      FInsertQuery.SQL.Add('VALUES');
      FInsertQuery.SQL.Add(
               Format('  (%D, %S, %D)',
                      [tmpID,
                      QuotedStr(ModelSubGroup.ModelSubGroup),
                      IDSubGroup
                      ]
                     )
              );
      FInsertQuery.ExecSQL;
      ModelSubGroup.IDModelSubGroup := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRModelSubGroupService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TModelSubGroup) then
    raise Exception.Create('Object type Mismatch - TMRModelSubGroupService.TestObjectClass');
end;

{ TMRModelService }

function TMRModelService.Find(AObj: TObject): Boolean;
var
  Model: TModel;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Model := TModel(AObj);

    FSearchQuery.SQL.Add(Format('SELECT IDModel FROM Model WHERE Model = %S', [QuotedStr(Model.Model)]));
    FSearchQuery.Open;

    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Model.IDModel := FSearchQuery.FieldByName('IDModel').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

procedure TMRModelService.LoadModel(Model: TModel);
begin

  Model.IDModel         := FSearchQuery.FieldByName('IdModel').AsInteger;
  Model.Model           := Trim(FSearchQuery.FieldByName('Model').AsString);
  Model.Description     := Trim(FSearchQuery.FieldByName('Description').AsString);

  Model.VendorCost      := FSearchQuery.FieldByName('VendorCost').AsCurrency;
  Model.CaseQty         := FSearchQuery.FieldByName('CaseQty').AsFloat;

end;


function TMRModelService.FindById(AObj: TObject): Boolean;
var
  Model: TModel;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Model := TModel(AObj);

    FSearchQuery.SQL.Add( 'SELECT IDModel, Model, Description, VendorCost, CaseQty '+
                          'FROM Model WHERE IdModel = ' + IntToStr( Model.IdModel ) );

    FSearchQuery.Open;

    try
      Result := not FSearchQuery.IsEmpty;

      if Result then Begin

        Self.LoadModel( Model );

      End;

    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelService.Import(AObj: TObject): Boolean;
var
  Model: TModel;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    Model := TModel(AObj);
    if Model.IDModel = null then
      begin
        if Find(Model) then
          Result := True
        else
          Result := InsertModel(Model)
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelService.InsertModel(Model: TModel): Boolean;
var
  tmpID: Integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Model', 'IDModel', FSQLConnection);
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO Model');
      FInsertQuery.SQL.Add('  (IDModel, Model, Description, GroupID, VendorCost, SellingPrice, IDUserLastSellingPrice, DateLastCost, DateLastSellingPrice, CaseQty, ');
      FInsertQuery.SQL.Add('   IDFabricante, IDModelGroup, IDModelSubGroup, SuggRetail, Verify, ModelType, Markup, IDSize, IDColor, IDUnidade, NotVerifyQty, ');
      FInsertQuery.SQL.Add('FreightCost, OtherCost, LastCost, ClasseABC, AutomaticRequest, AskUserOnSale, CustomSalePrice, UpdatePrice )');
      FInsertQuery.SQL.Add('VALUES (:IDModel, :Model, :Description, :GroupID, :VendorCost, :SellingPrice, :IDUserLastSellingPrice, :Date1, :Date2, :CaseQty, ');
      FInsertQuery.SQL.Add('  :IDFabricante, :IDModelGroup, :IDModelSubGroup, :SuggRetail, :Verify, :ModelType, :Markup, :IDSize, :IDColor, :IDUnidade, :NotVerifyQty, ');
      FInsertQuery.SQL.Add(':FreightCost, :OtherCost, :LastCost, :ClassABC, :AutomaticRequest, :AskUserOnSale, :customsaleprice, :updateprice )' );

      FInsertQuery.Parameters.ParamByName('IDModel').Value         := tmpID;
      FInsertQuery.Parameters.ParamByName('Model').Value           := Model.Model;
      FInsertQuery.Parameters.ParamByName('Description').Value     := Model.Description;
      FInsertQuery.Parameters.ParamByName('GroupID').Value         := Model.Category.IDGroup;
      FInsertQuery.Parameters.ParamByName('VendorCost').Value      := Model.VendorCost;
      FInsertQuery.Parameters.ParamByName('SellingPrice').Value    := Model.SellingPrice;
      FInsertQuery.Parameters.ParamByName('IDUserLastSellingPrice').Value := Model.IDUserLastSellingPrice;
      if Model.CaseQty > 1 then
        FInsertQuery.Parameters.ParamByName('CaseQty').Value       := Model.CaseQty;
      FInsertQuery.Parameters.ParamByName('SuggRetail').Value      := Model.SuggRetail;
      FInsertQuery.Parameters.ParamByName('Verify').Value          := Model.Verify;
      FInsertQuery.Parameters.ParamByName('ModelType').Value       := Model.ModelType;
      FInsertQuery.Parameters.ParamByName('Markup').Value          := Model.Markup;
      FInsertQuery.Parameters.ParamByName('Date1').Value           := Now;
      FInsertQuery.Parameters.ParamByName('Date2').Value           := Now;
      FInsertQuery.Parameters.ParamByName('IDSize').Value          := Model.IDSize;
      FInsertQuery.Parameters.ParamByName('IDColor').Value         := Model.IDColor;
      FInsertQuery.Parameters.ParamByName('IDUnidade').Value       := Model.IDUnit;
      FInsertQuery.Parameters.ParamByName('NotVerifyQty').Value    := Model.NotVerifyQty;

      if Assigned(Model.Manufacturer) then
        FInsertQuery.Parameters.ParamByName('IDFabricante').Value := Model.Manufacturer.IDManufacturer
      else
        FInsertQuery.Parameters.ParamByName('IDFabricante').Value := Null;
      if Assigned(Model.ModelGroup) then
        FInsertQuery.Parameters.ParamByName('IDModelGroup').Value  := Model.ModelGroup.IDModelGroup
      else
        FInsertQuery.Parameters.ParamByName('IDModelGroup').Value := Null;
      if Assigned(Model.ModelSubGroup) then
        FInsertQuery.Parameters.ParamByName('IDModelSubGroup').Value := Model.ModelSubGroup.IDModelSubGroup
      else
        FInsertQuery.Parameters.ParamByName('IDModelSubGroup').Value := Null;

      //amfsouza 11.29.2010 -
      FInsertQuery.Parameters.ParamByName('FreightCost').Value       := Model.freightCost;
      FInsertQuery.Parameters.ParamByName('OtherCost').Value         := Model.otherCost;
      FInsertQuery.Parameters.ParamByName('LastCost').Value          := Model.lastCost;
      FInsertQuery.Parameters.ParamByName('ClassABC').Value          := Model.classABC;
      FInsertQuery.Parameters.ParamByName('AutomaticRequest').Value  := Model.automaticRequest;
      FInsertQuery.Parameters.ParamByName('AskUserOnSale').Value     := Model.askUserOnSale;
      FInsertQuery.Parameters.ParamByName('customsaleprice').Value   := Model.CustomSalePrice;
      FInsertQuery.Parameters.ParamByName('updateprice').Value       := Model.updatePrice;

      FInsertQuery.ExecSQL;

      Model.IDModel := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRModelService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TModel) then
    raise Exception.Create('Object type Mismatch - TMRModelService.TestObjectClass');
end;

function TMRModelService.Update(AObj: TObject): Boolean;
var
  Model: TModel;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    Model := TModel(AObj);
    if Model.IDModel <> null then
      begin
        if Find(Model) then
          Result := UpdateModel(Model)
        else
          Result := True;
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelService.UpdateModel(Model: TModel): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('UPDATE Model');
      FInsertQuery.SQL.Add(' SET Description = :Description, GroupID = :GroupID, VendorCost = :VendorCost, ');
      FInsertQuery.SQL.Add(' SellingPrice = :SellingPrice, IDUserLastSellingPrice = :IDUserLastSellingPrice, ');
      FInsertQuery.SQL.Add(' DateLastCost = :DateLastCost, DateLastSellingPrice = :DateLastSellingPrice, ');
      FInsertQuery.SQL.Add(' CaseQty = :CaseQty, IDModelGroup = :IDModelGroup, IDModelSubGroup = :IDModelSubGroup, ');
      FInsertQuery.SQL.Add(' SuggRetail = :SuggRetail, Markup = :Markup, IDFabricante = :IDManufacturer ');
      FInsertQuery.SQL.Add(' WHERE IDModel = :IDModel ');

      FInsertQuery.Parameters.ParamByName('IDModel').Value         := Model.IDModel;
      FInsertQuery.Parameters.ParamByName('Description').Value     := Model.Description;
      FInsertQuery.Parameters.ParamByName('GroupID').Value         := Model.Category.IDGroup;
      FInsertQuery.Parameters.ParamByName('VendorCost').Value      := Model.VendorCost;
      FInsertQuery.Parameters.ParamByName('SellingPrice').Value    := Model.SellingPrice;
      FInsertQuery.Parameters.ParamByName('IDUserLastSellingPrice').Value := Model.IDUserLastSellingPrice;

      if Model.CaseQty <> 0 then
        FInsertQuery.Parameters.ParamByName('CaseQty').Value               := Model.CaseQty;

      if Model.ModelGroup.IDModelGroup <> 0 then
        FInsertQuery.Parameters.ParamByName('IDModelGroup').Value          := Model.ModelGroup.IDModelGroup;

      if Model.ModelSubGroup.IDModelSubGroup <> 0 then
        FInsertQuery.Parameters.ParamByName('IDModelSubGroup').Value       := Model.ModelSubGroup.IDModelSubGroup;

      FInsertQuery.Parameters.ParamByName('SuggRetail').Value      := Model.SuggRetail;
      FInsertQuery.Parameters.ParamByName('Markup').Value          := Model.Markup;

      if Model.DateLastCost <> 0 then
        FInsertQuery.Parameters.ParamByName('DateLastCost').Value          := Model.DateLastCost;

      if Model.DateLastSellingPrice <> 0 then
        FInsertQuery.Parameters.ParamByName('DateLastSellingPrice').Value  := Model.DateLastSellingPrice;

      if Assigned(Model.Manufacturer) then
        FInsertQuery.Parameters.ParamByName('IDManufacturer').Value := Model.Manufacturer.IDManufacturer;

      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

function TMRModelService.UpdateModelPrices(Model: TModel): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('UPDATE Model');
      FInsertQuery.SQL.Add(' SET VendorCost = ISNULL(:VendorCost, VendorCost), SellingPrice = ISNULL(:SellingPrice, SellingPrice), ');
      FInsertQuery.SQL.Add(' DateLastCost = CASE WHEN (VendorCost <> ISNULL(:VendorCost,0)) THEN :DateLastCost ELSE DateLastCost END, ');
      FInsertQuery.SQL.Add(' DateLastSellingPrice = CASE WHEN (SellingPrice <> ISNULL(:SellingPrice, SellingPrice)) THEN :DateLastSellingPrice ELSE DateLastSellingPrice END, ');
      FInsertQuery.SQL.Add(' IDUserLastSellingPrice = CASE WHEN (SellingPrice <> ISNULL(:SellingPrice, SellingPrice)) THEN ISNULL(:IDUserLastSellingPrice, IDUserLastSellingPrice) ELSE IDUserLastSellingPrice END, ');
      FInsertQuery.SQL.Add(' SuggRetail = ISNULL(:SuggRetail, SuggRetail), Markup = ISNULL(:Markup, Markup) ');
      FInsertQuery.SQL.Add('FROM Model ');
      FInsertQuery.SQL.Add(' WHERE IDModel = :IDModel ');

      FInsertQuery.Parameters.ParamByName('IDModel').Value                := Model.IDModel;
      FInsertQuery.Parameters.ParamByName('VendorCost').Value             := Model.VendorCost;
      FInsertQuery.Parameters.ParamByName('SellingPrice').Value           := Model.SellingPrice;

      if (Model.IDUserLastSellingPrice <> Null) and (Model.IDUserLastSellingPrice <> 0) then
        FInsertQuery.Parameters.ParamByName('IDUserLastSellingPrice').Value := Model.IDUserLastSellingPrice;

      if Model.SuggRetail <> 0 then
        FInsertQuery.Parameters.ParamByName('SuggRetail').Value           := Model.SuggRetail;

      if Model.Markup <> 0 then
        FInsertQuery.Parameters.ParamByName('Markup').Value               := Model.Markup;

      if Model.DateLastCost <> 0 then
        FInsertQuery.Parameters.ParamByName('DateLastCost').Value         := Model.DateLastCost;

      if Model.DateLastSellingPrice <> 0 then
        FInsertQuery.Parameters.ParamByName('DateLastSellingPrice').Value := Model.DateLastSellingPrice;

      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

function TMRModelService.UpdatePrices(AObj: TObject): Boolean;
var
  Model: TModel;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    Model := TModel(AObj);
    if (Model.IDModel <> null) or (Model.IDModel <> 0) then
      begin
        if (Model.IDModel <> 0) or Find(Model) then
          Result := UpdateModelPrices(Model)
        else
          Result := True;
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

{ TCatalogModelService }

function TCatalogModelService.Find(AObj: TObject): Boolean;
var
  Model: TModel;
  Manufacturer: TManufacturer;
  Vendor: TVendor;
  Category: TCategory;
  ModelGroup: TModelGroup;
  ModelSubGroup: TModelSubGroup;
  ModelVendor:   TModelVendor;
  VendorModelCode: TVendorModelCode;

  MRManufacturerService: TMRManufacturerService;
  MRModelGroupService:    TMRModelGroupService;
  MRModelSubGroupService: TMRModelSubGroupService;
  MRVendorService:       TMRVendorService;
  MRCategoryService:     TMRCategoryService;
  MRModelVendorService:  TMRModelVendorService;
  MRVendorModelCodeService:  TMRVendorModelCodeService;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Model := TModel(AObj);

    FSearchQuery.SQL.Text := 'SELECT '+
                             '  CP.sku, '+
                             '  CP.Title, '+
                             '  PV.vCost as VendorCost, '+
                             '  CP.wholesale, '+
                             '  CP.Department, '+
                             '  CP.Category, '+
                             '  CP.SubCategory, '+
                             '  CP.Tax_Category, '+
                             '  CP.Mfg, '+
                             '  CP.retail_price, '+
                             '  V.Vendor, '+
                             '  V.IDVendorMR, '+
                             '  PV.vsell_pkg as CaseQty, '+
                             '  PV.vsku as VendorModelCode, '+
                             '  PV.vmin_qty as MinQtyPO, '+
                             '  PV.vbatch_qty as VendorCaseQty '+
                             'FROM '+
                             '  MRCatalogDB..Products CP (NOLOCK) '+
                             '  JOIN MRCatalogDB..Products_Vendors PV (NOLOCK) ON (CP.Sku = PV.Sku) '+
                             '  JOIN MRCatalogDB..Vendors V (NOLOCK) ON (V.IDVendor = PV.IDVendor AND V.IDVendorMR IS NOT NULL) '+
                             'WHERE '+
                             '  CP.Inactive = 0 ' +
                             '  AND PV.VInactive = 0 ';

    if Model.Model <> '' then
      FSearchQuery.SQL.Add(' AND CP.sku = ' + QuotedStr(Model.Model));

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;

      if Result then
      begin
        Model.IDModel         := NULL;
        Model.Model           := Trim(FSearchQuery.FieldByName('sku').AsString);
        Model.Description     := Trim(FSearchQuery.FieldByName('Title').AsString);
        Model.VendorCost      := FSearchQuery.FieldByName('VendorCost').AsCurrency;
        Model.SuggRetail      := FSearchQuery.FieldByName('retail_price').AsCurrency;
        Model.CaseQty         := FSearchQuery.FieldByName('CaseQty').AsFloat;


        // Manufacturer
        Manufacturer                  := TManufacturer.Create;
        Manufacturer.Manufacturer     := Trim(FSearchQuery.FieldByName('Mfg').AsString);

        MRManufacturerService         := TMRManufacturerService.Create;
        MRManufacturerService.SQLConnection := SQLConnection;
        MRManufacturerService.Find(Manufacturer);

        Model.Manufacturer    := Manufacturer;

        // Vendor
        Vendor                        := TVendor.Create;
        Vendor.Vendor                 := Trim(FSearchQuery.FieldByName('Vendor').AsString);

        MRVendorService               := TMRVendorService.Create;
        MRVendorService.SQLConnection := SQLConnection;
        MRVendorService.Find(Vendor);

        Model.Vendor          := Vendor;

        // ModelVendor and VendorModelCode
        if Model.Vendor <> nil then
        begin
          // ModelVendor
          ModelVendor                := TModelVendor.Create;
          ModelVendor.MinQtyPO       := FSearchQuery.FieldByName('MinQtyPO').AsFloat;
          ModelVendor.CaseQty        := FSearchQuery.FieldByName('VendorCaseQty').AsFloat;
          ModelVendor.IDModel        := Model.IDModel;
          ModelVendor.IDVendor       := Model.Vendor.IDVendor;

          MRModelVendorService               := TMRModelVendorService.Create();
          MRModelVendorService.SQLConnection := SQLConnection;
          MRModelVendorService.Find(ModelVendor);

          Model.ModelVendor := ModelVendor;


          // VendorModelCode
          VendorModelCode                 := TVendorModelCode.Create;
          VendorModelCode.VendorCode      := Trim(FSearchQuery.FieldByName('VendorModelCode').AsString);
          VendorModelCode.IDModel         := Model.IDModel;
          VendorModelCode.IDVendor        := Model.Vendor.IDVendor;

          MRVendorModelCodeService               := TMRVendorModelCodeService.Create();
          MRVendorModelCodeService.SQLConnection := SQLConnection;
          MRVendorModelCodeService.Find(VendorModelCode);

          Model.VendorModelCode := VendorModelCode;
        end;

        // Category
        Category                      := TCategory.Create;
        Category.TabGroup             := Trim(FSearchQuery.FieldByName('Department').AsString);

        MRCategoryService               := TMRCategoryService.Create();
        MRCategoryService.SQLConnection := SQLConnection;
        MRCategoryService.Find(Category);

        Model.Category        := Category;

        // ModelGroup
        ModelGroup                    := TModelGroup.Create;
        ModelGroup.ModelGroup         := Trim(FSearchQuery.FieldByName('Category').AsString);

        MRModelGroupService               := TMRModelGroupService.Create();
        MRModelGroupService.SQLConnection := SQLConnection;
        MRModelGroupService.Find(ModelGroup);

        Model.ModelGroup      := ModelGroup;

        // ModelSubGroup
        ModelSubGroup                    := TModelSubGroup.Create;
        ModelSubGroup.ModelSubGroup      := Trim(FSearchQuery.FieldByName('SubCategory').AsString);

        MRModelSubGroupService               := TMRModelSubGroupService.Create();
        MRModelSubGroupService.SQLConnection := SQLConnection;
        MRModelSubGroupService.Find(ModelSubGroup);

        Model.ModelSubGroup      := ModelSubGroup;
      end;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TCatalogModelService.Import(AObj: TObject): Boolean;
begin
  Result := True;
end;

procedure TCatalogModelService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TModel) then
    raise Exception.Create('Object type Mismatch - TCatalogModelService.TestObjectClass');
end;

{ TMRVendorModelCodeService }

function TMRVendorModelCodeService.Find(AObj: TObject): Boolean;
var
  VendorModelCode: TVendorModelCode;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      VendorModelCode := TVendorModelCode(AObj);

    VendorModelCode.IDVendorModelCode := 0;

    FSearchQuery.SQL.Add(' SELECT IDVendorModelCode FROM VendorModelCode WHERE IDPessoa = :IDVendor '+
                         ' AND IDModel = :IDModel');
    FSearchQuery.Parameters.ParamByName('IDVendor').Value := VendorModelCode.IDVendor;
    FSearchQuery.Parameters.ParamByName('IDModel').Value  := VendorModelCode.IDModel;
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        VendorModelCode.IDVendorModelCode := FSearchQuery.FieldByName('IDVendorModelCode').AsInteger
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRVendorModelCodeService.FindByVendorCode(AObj: TObject): Boolean;
var
  VendorModelCode: TVendorModelCode;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      VendorModelCode := TVendorModelCode(AObj);

    VendorModelCode.IDVendorModelCode := 0;

    FSearchQuery.SQL.Add(' SELECT IDVendorModelCode FROM VendorModelCode WHERE IDPessoa = :IDVendor '+
                         ' AND IDModel = :IDModel AND VendorCode = :VendorCode');

    FSearchQuery.Parameters.ParamByName('IDVendor').Value    := VendorModelCode.IDVendor;
    FSearchQuery.Parameters.ParamByName('IDModel').Value     := VendorModelCode.IDModel;
    FSearchQuery.Parameters.ParamByName('VendorCode').Value  := VendorModelCode.VendorCode;

    FSearchQuery.Open;

    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        VendorModelCode.IDVendorModelCode := FSearchQuery.FieldByName('IDVendorModelCode').AsInteger
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRVendorModelCodeService.Import(AObj: TObject): Boolean;
var
  VendorModelCode: TVendorModelCode;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    VendorModelCode := TVendorModelCode(AObj);
    if VendorModelCode.IDVendorModelCode = null then
      begin
        if Find(VendorModelCode) then
          Result := True
        else
          Result := InsertVendorModelCode(VendorModelCode)
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRVendorModelCodeService.InsertVendorModelCode(
  VendorModelCode: TVendorModelCode): Boolean;
var
  tmpID: Integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('VendorModelCode', 'IDVendorModelCode', FSQLConnection);
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO VendorModelCode');
      FInsertQuery.SQL.Add('  (IDVendorModelCode, IDPessoa, IDModel, VendorCode )');
      FInsertQuery.SQL.Add('VALUES (:IDVendorModelCode, :IDPessoa, :IDModel, :VendorCode)');
      FInsertQuery.Parameters.ParamByName('IDVendorModelCode').Value  := tmpID;
      FInsertQuery.Parameters.ParamByName('IDPessoa').Value           := VendorModelCode.IDVendor;
      FInsertQuery.Parameters.ParamByName('IDModel').Value            := VendorModelCode.IDModel;
      FInsertQuery.Parameters.ParamByName('VendorCode').Value         := VendorModelCode.VendorCode;
      FInsertQuery.ExecSQL;
      VendorModelCode.IDVendorModelCode := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRVendorModelCodeService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TVendorModelCode) then
    raise Exception.Create('Object type Mismatch - TMRVendorModelCodeService.TestObjectClass');
end;

{ TMRInventoryService }

function TMRInventoryService.InsertInventoryQty(
  Inventory: TInventory): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add(' Exec sp_Inventory_Adjust :IDMovType, :IDModel, :IDStore, :Qty, :IDUser, :Date ');
      FInsertQuery.SQL.Add(' , :Notes, :IDMovReason ');
      FInsertQuery.Parameters.ParamByName('IDMovType').Value   := INV_MOVTYPE_PHYSICALINCREASE;
      FInsertQuery.Parameters.ParamByName('IDModel').Value     := Inventory.IDModel;
      FInsertQuery.Parameters.ParamByName('IDStore').Value     := Inventory.IDStore;
      FInsertQuery.Parameters.ParamByName('Qty').Value         := Inventory.QtyOnHand;
      FInsertQuery.Parameters.ParamByName('IDUser').Value      := Inventory.IDUser;
      FInsertQuery.Parameters.ParamByName('Date').Value        := Now;
      FInsertQuery.Parameters.ParamByName('Notes').Value       := '';
      FInsertQuery.Parameters.ParamByName('IDMovReason').Value := 1;
      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;

end;

function TMRInventoryService.Find(AObj: TObject): Boolean;
var
  Inventory: TInventory;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Inventory := TInventory(AObj);

    Inventory.IDInventory := 0;

    FSearchQuery.SQL.Add(' SELECT IDInventory FROM Inventory WHERE ModelID = :IDModel '+
                         ' AND StoreID = :IDStore ');
    FSearchQuery.Parameters.ParamByName('IDModel').Value := Inventory.IDModel;
    FSearchQuery.Parameters.ParamByName('IDStore').Value := Inventory.IDStore;
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Inventory.IDInventory := FSearchQuery.FieldByName('IDInventory').AsInteger
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRInventoryService.Import(AObj: TObject): Boolean;
var
  Inventory: TInventory;
  module: TADOQuery;
  store: TADOQuery;
  sql: String;
  isServer: boolean;
  saveQtyOnHand: double;

              //amfsouza 11.11.2010 - subfunction to get IdDefault store
              function getStoreDefault: integer;
              var
                buildInfo: String;
                registry: TRegistry;
              begin
                registry := TRegistry.Create;

                try
                   if ( getOS(buildInfo) = osW7 ) then
                      registry.RootKey:= HKEY_CURRENT_USER
                   else
                     registry.RootKey:= HKEY_LOCAL_MACHINE;

                   registry.OpenKey(REGISTRY_PATH, True);

                   result := registry.ReadInteger('DefaultStoreID');
                finally
                  freeAndNil(registry);
                end;
              end;

begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    Inventory := TInventory(AObj);
    if Inventory.IDInventory = null then
      begin

        //amfsouza 11.11.2010 - save qtyOnHand
        saveQtyOnHand := Inventory.QtyOnHand;

        if Find(Inventory) then
        begin
          if Inventory.UpdateQty then
          begin
            if (Inventory.QtyOnHand > 0) then
              InsertInventoryQty(Inventory);
          end;
          Result := True;
        end
        else
        begin
          if (Inventory.MinQty > 0) or (Inventory.MaxQty > 0) then
            InsertInventoryMinMax(Inventory);

          //amfsouza 11.10.2010 - verify if store is a corporate.
          if (Inventory.QtyOnHand >= 0) then begin
            try
               module := TADOQuery.Create(nil);
               module.Connection := FSQLConnection;
               sql := 'select VersionType from SYS_MODULE';
               module.SQL.Text := sql;
               module.Open;
               isServer := ( module.FieldByName('VersionType').Value <> quotedStr('CLIENT') );

               store := TADOQuery.Create(nil);
               store.Connection := FSQLConnection;
               sql := 'select IdStore from STORE where system <> 1';
               store.SQL.Text := sql;
               store.Open;

               if ( isServer ) then begin
                  while ( not store.Eof ) do begin

                      if ( store.FieldByName('IdStore').AsInteger <> getStoreDefault ) then
                         Inventory.QtyOnHand := 0
                      else
                         Inventory.QtyOnHand := saveQtyOnHand;

                      Inventory.IdStore := store.fieldByname('IdStore').asInteger;

                      InsertInventoryQty(Inventory);
                      store.Next;
                  end;
               end
               else
                  InsertInventoryQty(Inventory);
            finally
               freeAndNil(module);
               freeAndNil(store);
            end;

          end;

        end;
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRInventoryService.InsertInventoryMinMax(
  Inventory: TInventory): Boolean;
var
  tmpID: Integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Inventory', 'IDInventory', FSQLConnection);
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO Inventory');
      FInsertQuery.SQL.Add('  (IDInventory, ModelID, StoreID, MaxQty, MinQty )');
      FInsertQuery.SQL.Add('VALUES (:IDInventory, :IDModel, :IDStore, :MaxQty, :MinQty)');
      FInsertQuery.Parameters.ParamByName('IDInventory').Value  := tmpID;
      FInsertQuery.Parameters.ParamByName('IDModel').Value      := Inventory.IDModel;
      FInsertQuery.Parameters.ParamByName('IDStore').Value      := Inventory.IDStore;
      FInsertQuery.Parameters.ParamByName('MaxQty').Value       := Inventory.MaxQty;
      FInsertQuery.Parameters.ParamByName('MinQty').Value       := Inventory.MinQty;
      FInsertQuery.ExecSQL;
      Inventory.IDInventory := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRInventoryService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TInventory) then
    raise Exception.Create('Object type Mismatch - TMRInventory.TestObjectClass');
end;


{ TMRKitModelService }

function TMRKitModelService.Find(AObj: TObject): Boolean;
var
  KitModel: TKitModel;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      KitModel := TKitModel(AObj);

    FSearchQuery.SQL.Add(' SELECT IDModel FROM KitModel WHERE IDModel = :IDModel AND Qty = :Qty ');
    FSearchQuery.Parameters.ParamByName('IDModel').Value := KitModel.IDModel;
    FSearchQuery.Parameters.ParamByName('Qty').Value     := KitModel.Qty;
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRKitModelService.Import(AObj: TObject): Boolean;
var
  KitModel: TKitModel;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    KitModel := TKitModel(AObj);

    if Find(KitModel) then
      Result := True
    else
      Result := InsertKitModel(KitModel);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRKitModelService.InsertKitModel(KitModel: TKitModel): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO KitModel');
      FInsertQuery.SQL.Add('  (IDModel, Qty, SellingPrice , MarginPerc )');
      FInsertQuery.SQL.Add('VALUES (:IDModel, :Qty, :SellingPrice, :MarginPerc)');
      FInsertQuery.Parameters.ParamByName('IDModel').Value       := KitModel.IDModel;
      FInsertQuery.Parameters.ParamByName('Qty').Value           := KitModel.Qty;
      FInsertQuery.Parameters.ParamByName('SellingPrice').Value  := KitModel.SellingPrice;
      FInsertQuery.Parameters.ParamByName('MarginPerc').Value    := KitModel.MarginPerc;
      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRKitModelService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TKitModel) then
    raise Exception.Create('Object type Mismatch - TMRKitModel.TestObjectClass');
end;

function TMRKitModelService.Update(AObj: TObject): Boolean;
var
  KitModel: TKitModel;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    KitModel := TKitModel(AObj);
    if KitModel.IDModel <> null then
      begin
        if Find(KitModel) then
          Result := UpdateKitModel(KitModel)
        else
          Result := True;
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRKitModelService.UpdateKitModel(KitModel: TKitModel): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('UPDATE KitModel');
      FInsertQuery.SQL.Add(' SET SellingPrice = :SellingPrice, MarginPerc = :MarginPerc ');
      FInsertQuery.SQL.Add('WHERE IDModel = :IDModel AND Qty = :Qty');

      FInsertQuery.Parameters.ParamByName('IDModel').Value      := KitModel.IDModel;
      FInsertQuery.Parameters.ParamByName('Qty').Value          := KitModel.Qty;
      FInsertQuery.Parameters.ParamByName('SellingPrice').Value := KitModel.SellingPrice;
      FInsertQuery.Parameters.ParamByName('MarginPerc').Value   := KitModel.MarginPerc;

      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

{ TMRModelVendorService }

procedure TMRModelVendorService.LoadModelVendor( ModelVendor : TModelVendor );
begin

  ModelVendor.IdVendor       := FSearchQuery.FieldByName('IDPESSOA').AsInteger;
  ModelVendor.IdModel        := FSearchQuery.FieldByName('IDMODEL').AsInteger;
  ModelVendor.VendorOrder    := FSearchQuery.FieldByName('VENDORORDER').AsInteger;

  ModelVendor.VendorCost     := FSearchQuery.FieldByName('VENDORCOST').AsFloat;
  ModelVendor.MinQtyPO       := FSearchQuery.FieldByName('MINQTYPO').AsFloat;
  ModelVendor.CaseQty        := FSearchQuery.FieldByName('CASEQTY').AsFloat;

end;

function TMRModelVendorService.Find(AObj: TObject): Boolean;
var
  ModelVendor: TModelVendor;
begin

  Result := True;

  try

    TestObjectClass(AObj);

    inherited Find(AObj);

    if (AObj <> nil) then
      ModelVendor := TModelVendor(AObj);

    FSearchQuery.SQL.Add('SELECT IDPessoa, IDModel, VendorOrder, MinQtyPO, CaseQty, VendorCost, CostLastChange '+
                         'FROM Inv_ModelVendor WHERE IDModel = :IDModel AND IDPessoa = :IDPessoa ');
    FSearchQuery.Parameters.ParamByName('IDModel').Value  := ModelVendor.IDModel;
    FSearchQuery.Parameters.ParamByName('IDPessoa').Value := ModelVendor.IDVendor;
    FSearchQuery.Open;

    try
      Result := not FSearchQuery.IsEmpty;

      If ( Result = True ) Then Begin

        Self.LoadModelVendor( ModelVendor );

      End;

    finally
      FSearchQuery.Close;
    end;

  except

    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;

  end;

end;

function TMRModelVendorService.GetNextVendorOrder(ModelVendor: TModelVendor): Integer;
begin
  Result := -1;
  try
    FSearchQuery.Close;
    FSearchQuery.SQL.Clear;
    FSearchQuery.SQL.Add(' SELECT ISNULL(Max(VendorOrder),0) VendorOrder FROM Inv_ModelVendor WHERE IDModel = :IDModel '+
                         ' AND IDPessoa = :IDPessoa ');
    FSearchQuery.Parameters.ParamByName('IDModel').Value := ModelVendor.IDModel;
    FSearchQuery.Parameters.ParamByName('IDPessoa').Value := ModelVendor.IDVendor;
    FSearchQuery.Open;
    try
      Result := FSearchQuery.FieldByName('VendorOrder').AsInteger + 1;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := -1;
    end;
  end;
end;

function TMRModelVendorService.Import(AObj: TObject): Boolean;
var
  ModelVendor: TModelVendor;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    ModelVendor := TModelVendor(AObj);
    if Find(ModelVendor) then
      Result := True
    else
      Result := InsertModelVendor(ModelVendor);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelVendorService.InsertModelVendor(
  ModelVendor: TModelVendor): Boolean;
var
  NextVendorOrder: Integer;
begin

  NextVendorOrder := GetNextVendorOrder(ModelVendor);

  if (NextVendorOrder <> -1) then
  begin
    try
      Result := True;
      try
        if FInsertQuery.Active then
          FInsertQuery.Close;

        FInsertQuery.SQL.Clear;
        FInsertQuery.SQL.Add('INSERT INTO Inv_ModelVendor');
        FInsertQuery.SQL.Add('  (IDModel, IDPessoa, VendorOrder, MinQtyPO, CaseQty, VendorCost, CostLastChange )');
        FInsertQuery.SQL.Add('VALUES (:IDModel, :IDPessoa, :VendorOrder, :MinQtyPO, :CaseQty, :vendorcost, :lastcostchange)');
        FInsertQuery.Parameters.ParamByName('IDModel').Value     := ModelVendor.IDModel;
        FInsertQuery.Parameters.ParamByName('IDPessoa').Value    := ModelVendor.IDVendor;
        FInsertQuery.Parameters.ParamByName('VendorOrder').Value := NextVendorOrder;
        FInsertQuery.Parameters.ParamByName('MinQtyPO').Value    := ModelVendor.MinQtyPO;
        FInsertQuery.Parameters.ParamByName('CaseQty').Value     := ModelVendor.CaseQty;
        FInsertQuery.Parameters.ParamByName('vendorcost').Value := ModelVendor.VendorCost;
        FInsertQuery.Parameters.ParamByName('lastcostchange').Value := ModelVendor.LastCostChange;
        FInsertQuery.ExecSQL;
      except
        on E: Exception do
        begin
          raise Exception.Create(E.Message);
          Result := False;
        end;
      end;
    finally
      FInsertQuery.Close;
    end;
  end;
end;

procedure TMRModelVendorService.TestObjectClass(AObj: TObject);
begin
  if not (AObj is TModelVendor) then
    raise Exception.Create('Object type Mismatch - TMRModelVendor.TestObjectClass');
end;

function TMRModelVendorService.Update(AObj: TObject): Boolean;
var
  ModelVendor: TModelVendor;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    ModelVendor := TModelVendor(AObj);
    if ModelVendor.IDModel <> null then
      begin
        if Find(ModelVendor) then
          Result := UpdateModelVendor(ModelVendor)
        else
          Result := True;
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRModelVendorService.UpdateModelVendor(
  ModelVendor: TModelVendor): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('UPDATE Inv_ModelVendor');
      FInsertQuery.SQL.Add(' SET MinQtyPO = :MinQtyPO , CaseQty = :CaseQty');
      FInsertQuery.SQL.Add('WHERE IDModel = :IDModel AND IDPessoa = :IDPessoa');

      FInsertQuery.Parameters.ParamByName('IDModel').Value  := ModelVendor.IDModel;
      FInsertQuery.Parameters.ParamByName('IDPessoa').Value := ModelVendor.IDVendor;
      FInsertQuery.Parameters.ParamByName('MinQtyPO').Value := ModelVendor.MinQtyPO;
      FInsertQuery.Parameters.ParamByName('CaseQty').Value  := ModelVendor.CaseQty;

      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

{ TMRInventorySerialService }

function TMRInventorySerialService.Find(AObj: TObject): Boolean;
var
  InventorySerial: TInventorySerial;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      InventorySerial := TInventorySerial(AObj);

    FSearchQuery.SQL.Add(' SELECT Serial FROM InventorySerial WHERE ModelID = :IDModel '+
                         ' AND StoreID = :IDStore AND Serial = :Serial');
    FSearchQuery.Parameters.ParamByName('IDModel').Value := InventorySerial.ModelID;
    FSearchQuery.Parameters.ParamByName('IDStore').Value := InventorySerial.StoreID;
    FSearchQuery.Parameters.ParamByName('Serial').Value := InventorySerial.Serial;
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRInventorySerialService.Import(AObj: TObject): Boolean;
var
  InventorySerial: TInventorySerial;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    InventorySerial := TInventorySerial(AObj);
    if (InventorySerial.StoreID <> Null) and (InventorySerial.ModelID <> Null) and (InventorySerial.Serial <> '') then
      begin
        if Find(InventorySerial) then
          Result := True
        else
          InsertInventorySerial(InventorySerial);
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRInventorySerialService.InsertInventorySerial(
  InventorySerial: TInventorySerial): Boolean;
begin

  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add(' INSERT InventorySerial (StoreID, ModelID, Serial) ');
      FInsertQuery.SQL.Add(' VALUES (:StoreID, :ModelID, :Serial) ');

      FInsertQuery.Parameters.ParamByName('ModelID').Value := InventorySerial.ModelID;
      FInsertQuery.Parameters.ParamByName('StoreID').Value := InventorySerial.StoreID;
      FInsertQuery.Parameters.ParamByName('Serial').Value  := InventorySerial.Serial;
      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FInsertQuery.Close;
  end;

end;

procedure TMRInventorySerialService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TInventorySerial) then
    raise Exception.Create('Object type Mismatch - TInventorySerial.TestObjectClass');
end;

{ TMRPackModelService }

function TMRPackModelService.Find(AObj: TObject): Boolean;
var
  PackModel: TPackModel;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      PackModel := TPackModel(AObj);

    FSearchQuery.SQL.Add('SELECT IDModel FROM PackModel WHERE IDPackModel = :IDPackModel AND IDModel = :IDModel');
    FSearchQuery.Parameters.ParamByName('IDPackModel').Value := PackModel.IDPackModel;
    FSearchQuery.Parameters.ParamByName('IDModel').Value     := PackModel.IDModel;
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRPackModelService.Import(AObj: TObject): Boolean;
var
  PackModel: TPackModel;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);
    PackModel := TPackModel(AObj);

    if Find(PackModel) then
      Result := True
    else
      Result := InsertPackModel(PackModel);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRPackModelService.InsertPackModel(
  PackModel: TPackModel): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO PackModel');
      FInsertQuery.SQL.Add('  (IDPackModel, IDModel, Qty)');
      FInsertQuery.SQL.Add('VALUES (:IDPackModel, :IDModel, :Qty)');
      FInsertQuery.Parameters.ParamByName('IDPackModel').Value := PackModel.IDPackModel;
      FInsertQuery.Parameters.ParamByName('IDModel').Value     := PackModel.IDModel;
      FInsertQuery.Parameters.ParamByName('Qty').Value         := PackModel.Qty;
      FInsertQuery.ExecSQL;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRPackModelService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TPackModel) then
    raise Exception.Create('Object type Mismatch - TMRPackModelService.TestObjectClass');
end;


{ TMRAnimalService }

function TMRAnimalService.CreateBarcode: TBarcode;
begin
  Result                       := TBarcode.Create;
  Result.Model                 := TModel.Create;
  Result.Model.Category        := TCategory.Create;
  Result.Model.Inventory       := TInventory.Create;
  Result.Model.InventorySerial := TInventorySerial.Create;
end;

function TMRAnimalService.Find(AObj: TObject): Boolean;
var
  Animal: TAnimal;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Animal := TAnimal(AObj);

    if (Animal.SKU <> '') then
      FSearchQuery.SQL.Add(Format('SELECT IDPet FROM Pet WHERE SKU = %S', [QuotedStr(Animal.SKU)]))
    else if (Animal.Collar <> '') then
      FSearchQuery.SQL.Add(Format('SELECT IDPet FROM Pet WHERE Collar = %S', [QuotedStr(Animal.Collar)]))
    else
      FSearchQuery.SQL.Add(Format('SELECT IDPet FROM Pet WHERE SKU = %S', [QuotedStr('-1')]));

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Animal.IDPet := FSearchQuery.FieldByName('IDPet').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRAnimalService.FormatSex(ASex: String): Char;
begin
  Result := ASex[1];
  if not (Result in ['F', 'M', 'U']) then
    Result := 'U';
end;

function TMRAnimalService.GetBreedName(IDBreed: Integer): String;
var
  FQuery : TADOQuery;
begin
  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := SQLConnection;
    FQuery.SQL.Add('SELECT Breed FROM Pet_Breed WHERE IDBreed = :IDBreed');
    FQuery.Parameters.ParamByName('IDBreed').Value := IDBreed;
    FQuery.Open;
    Result := FQuery.FieldByName('Breed').Value;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TMRAnimalService.Import(AObj: TObject): Boolean;
var
  Animal: TAnimal;
begin

  Result := False;
  TestObjectClass(AObj);
  inherited Import(AObj);

  Animal := TAnimal(AObj);
  if Animal.IDPet = null then
  begin
    if Find(Animal) then
      Result := True
    else
      Result := InsertAnimal(Animal);
  end
  else
  begin
    Result := True;
  end;

end;

function TMRAnimalService.InsertAnimal(Animal: TAnimal): Boolean;
var
  tmpID: Integer;
begin


  try
    Result := True;
    try
      //Preciso do SKU para criar o inventory serial
      if Animal.SKU = '' then
        Animal.SKU := IntToStr(GetNextCode('Pet', 'SKU', FSQLConnection));

      Result := InsertInventoryAnimal(Animal);

      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet', 'IDPet', FSQLConnection);
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO PET (IDPet, IDModel, IDColor, IDStore, IDSpecies, IDPorte, IDBreed, ');
      FInsertQuery.SQL.Add('IDStatus, IDBreeder, Name, Sex, SKU, PenNum, VendorCost, MSRP, SalePrice, ');
      FInsertQuery.SQL.Add('PromoPrice, USDA, Collar, Sire, Dam, WhelpDate, PurchaseDate, Notes, System, Hidden, Desativado) ');

      FInsertQuery.SQL.Add('VALUES (:IDPet, :IDModel, :IDColor, :IDStore, :IDSpecies, :IDPorte, :IDBreed, :IDStatus, :IDBreeder, ');
      FInsertQuery.SQL.Add(':Name, :Sex, :SKU, :PenNum, :VendorCost, :MSRP, :SalePrice, :PromoPrice, :USDA, :Collar, :Sire, :Dam, :WhelpDate, ');
      FInsertQuery.SQL.Add(':PurchaseDate, :Notes, :System, :Hidden, :Desativado)');

      FInsertQuery.Parameters.ParamByName('IDPet').Value        := tmpID;
      FInsertQuery.Parameters.ParamByName('IDModel').Value      := Animal.IDModel;
      FInsertQuery.Parameters.ParamByName('IDStore').Value      := Animal.IDStore;
      FInsertQuery.Parameters.ParamByName('IDStatus').Value     := Animal.IDStatus;
      FInsertQuery.Parameters.ParamByName('Name').Value         := Animal.Name;
      FInsertQuery.Parameters.ParamByName('Sex').Value          := FormatSex(Animal.Sex);
      FInsertQuery.Parameters.ParamByName('SKU').Value          := Animal.SKU;
      FInsertQuery.Parameters.ParamByName('PenNum').Value       := Animal.PenNum;
      FInsertQuery.Parameters.ParamByName('VendorCost').Value   := Animal.VendorCost;
      FInsertQuery.Parameters.ParamByName('MSRP').Value         := Animal.MSRP;
      FInsertQuery.Parameters.ParamByName('SalePrice').Value    := Animal.SalePrice;
      FInsertQuery.Parameters.ParamByName('PromoPrice').Value   := Animal.PromoPrice;
      FInsertQuery.Parameters.ParamByName('USDA').Value         := Animal.USDA;
      FInsertQuery.Parameters.ParamByName('Collar').Value       := Animal.Collar;
      FInsertQuery.Parameters.ParamByName('Sire').Value         := Animal.Sire;
      FInsertQuery.Parameters.ParamByName('Dam').Value          := Animal.Dam;
      FInsertQuery.Parameters.ParamByName('WhelpDate').Value    := Animal.WhelpDate;
      FInsertQuery.Parameters.ParamByName('PurchaseDate').Value := Animal.PurchaseDate;
      FInsertQuery.Parameters.ParamByName('Notes').Value        := Animal.Notes ;
      FInsertQuery.Parameters.ParamByName('System').Value       := 0;
      FInsertQuery.Parameters.ParamByName('Hidden').Value       := 0;
      FInsertQuery.Parameters.ParamByName('Desativado').Value   := 0;
      if (Animal.AnimalColor <> nil) then
        FInsertQuery.Parameters.ParamByName('IDColor').Value    := Animal.AnimalColor.IDColor;
      if Animal.Species <> nil then
        FInsertQuery.Parameters.ParamByName('IDSpecies').Value  := Animal.Species.IDSpecies;
      if Animal.Port <> nil then
        FInsertQuery.Parameters.ParamByName('IDPorte').Value    := Animal.Port.IDPort;
      if Animal.Breed <> nil then
        FInsertQuery.Parameters.ParamByName('IDBreed').Value    := Animal.Breed.IDBreed;
      if Animal.Breeder <> nil then
        FInsertQuery.Parameters.ParamByName('IDBreeder').Value  := Animal.Breeder.IDPessoa;

      FInsertQuery.ParamCheck;
      FInsertQuery.ExecSQL;
      Animal.IDPet := tmpID;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

function TMRAnimalService.InsertInventoryAnimal(Animal: TAnimal) : Boolean;
var
  ABarcode : TBarcode;
  AMRBarcodeService : TMRBarcodeService;
  sBreed : String;
begin

  try
    ABarcode := CreateBarcode;
    try
      AMRBarcodeService := TMRBarcodeService.Create;
      try
        AMRBarcodeService.SQLConnection := FSQLConnection;

        sBreed := GetBreedName(Animal.Breed.IDBreed);

        ABarcode.Model.VendorCost       := Animal.VendorCost;
        ABarcode.Model.SellingPrice     := Animal.SalePrice;
        ABarcode.Model.Category.IDGroup := GetPropertyDomain('PctPetCategory');
        ABarcode.Model.Model            := sBreed + FormatSex(Animal.Sex);
        ABarcode.Model.Description      := sBreed + ' ' + FormatSex(Animal.Sex);
        ABarcode.Model.ModelType        := 'R';
        ABarcode.Model.NotVerifyQty     := True;

        ABarcode.Model.Inventory.IDStore   := Animal.IDStore;
        ABarcode.Model.Inventory.IDUser    := 0; //Verificar
        ABarcode.Model.Inventory.QtyOnHand := 1;
        ABarcode.Model.Inventory.UpdateQty := True;

        ABarcode.Model.InventorySerial.StoreID := Animal.IDStore;
        ABarcode.Model.InventorySerial.Serial  := Animal.SKU;

        Result := AMRBarcodeService.Import(ABarcode);
        Animal.IDModel := ABarcode.Model.IDModel;

        //Create KIT
        if Result then
        begin
          ABarcode.Model.VendorCost       := Animal.VendorCost;
          ABarcode.Model.SellingPrice     := Animal.SalePrice;
          ABarcode.Model.Category.IDGroup := GetPropertyDomain('PctPetKitCategory');
          ABarcode.Model.Model            := 'K' + sBreed + FormatSex(Animal.Sex);
          ABarcode.Model.Description      := 'K' + sBreed + ' ' + FormatSex(Animal.Sex);
          ABarcode.Model.ModelType        := 'K';
          ABarcode.Model.NotVerifyQty     := True;
          ABarcode.Model.IDModel          := Null; //set null para ele criar um novo model

          ABarcode.Model.Inventory.IDStore   := Animal.IDStore;
          ABarcode.Model.Inventory.IDUser    := 0; //Verificar
          ABarcode.Model.Inventory.QtyOnHand := 1;
          ABarcode.Model.Inventory.UpdateQty := True;

          ABarcode.Model.InventorySerial.StoreID := Null;
          ABarcode.Model.InventorySerial.Serial  := '';

          Result := AMRBarcodeService.Import(ABarcode);
          Animal.IDKitModel := ABarcode.Model.IDModel;

          if Result then
          begin
            Result := InsertInventoryPackModel(Animal.IDKitModel, Animal.IDModel, 1);
            if Result then
              Result := InsertInventoryMicrochipsInPack(Animal.IDKitModel);
          end;
        end;
      finally
        FreeAndNil(AMRBarcodeService);
      end;
    finally
      FreeAndNil(ABarcode);
    end;
  except
    raise;
    end;
end;

function TMRAnimalService.InsertInventoryMicrochipsInPack(
  AIDPackModel: Integer): Boolean;
var
  FQuery : TADOQuery;
begin

  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := SQLConnection;
    FQuery.SQL.Add('SELECT IDModel ');
    FQuery.SQL.Add('FROM Pet_Microchip ');
    FQuery.Open;
    while not FQuery.EOF do
    begin
      if FQuery.FieldByName('IDModel').AsInteger <> 0 then
        InsertInventoryPackModel(AIDPackModel, FQuery.FieldByName('IDModel').AsInteger, 1);
      FQuery.Next;
    end;
    Result := True;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;

end;

function TMRAnimalService.InsertInventoryPackModel(AIDPackModel,
  AIDModel: Integer; AQty: Double): Boolean;
var
  MRPackModelService : TMRPackModelService;
  PackModel : TPackModel;
begin

  Result := False;
  
  MRPackModelService := TMRPackModelService.Create;
  try
    PackModel := TPackModel.Create;
    try
      MRPackModelService.SQLConnection := SQLConnection;
      PackModel.IDPackModel := AIDPackModel;
      PackModel.IDModel     := AIDModel;
      PackModel.Qty         := AQty;
      Result := MRPackModelService.Import(PackModel);
    finally
      FreeAndNil(PackModel);
    end;
  finally
    FreeAndNil(MRPackModelService);
  end;

end;

function TMRAnimalService.InsertOrUpdate(AObj: TObject): Boolean;
var
  Animal: TAnimal;
  i : Integer;
begin

  Result := False;

  TestObjectClass(AObj);

  if (AObj <> nil) then
    Animal := TAnimal(AObj);

  if Animal.Species <> nil then
  with TMRAnimalSpeciesService.Create do
    try
      SQLConnection := Self.SQLConnection;
      Import(Animal.Species);
    finally
      Free;
    end;

  if Animal.Breed <> nil then
  with TMRAnimalBreedService.Create do
    try
      SQLConnection := Self.SQLConnection;
      Import(Animal.Breed);
    finally
      Free;
    end;

  if Animal.AnimalColor <> nil then
  with TMRAnimalColorService.Create do
    try
      SQLConnection := Self.SQLConnection;
      Import(Animal.AnimalColor);
    finally
      Free;
    end;

  if Animal.Breeder <> nil then
  with TMREntityService.Create do
    try
      SQLConnection := Self.SQLConnection;
      Import(Animal.Breeder);
    finally
      Free;
    end;

  if Find(Animal) then
    Result := UpdateAnimal(Animal)
  else
    Result := InsertAnimal(Animal);

  if Animal.Microchip <> nil then
  with TMRAnimalMicrochipService.Create do
    try
      IDPet := Animal.IDPet;
      FIDKitModel := Animal.IDKitModel;
      SQLConnection := Self.SQLConnection;
      Import(Animal.Microchip);
    finally
      Free;
    end;

  if Animal.AnimalWeight <> nil then
  with TMRAnimalWeightService.Create do
    try
      IDPet := Animal.IDPet;
      SQLConnection := Self.SQLConnection;
      Import(Animal.AnimalWeight);
    finally
      Free;
    end;

  if Animal.AnimalRegistry <> nil then
  with TMRAnimalRegistryService.Create do
    try
      IDPet := Animal.IDPet;
      SQLConnection := Self.SQLConnection;
      Import(Animal.AnimalRegistry);
    finally
      Free;
    end;

  if (Animal.TreatmentList <> nil) then
    if Animal.TreatmentList.Count > 0 then
      for i := 0 to Animal.TreatmentList.Count-1 do
        with TMRAnimalTreatmentService.Create do
        try
          IDPet := Animal.IDPet;
          SQLConnection := Self.SQLConnection;
          begin
            Import(TAnimalTreatment(Animal.TreatmentList.Objects[i]));
          end;
        finally
          Free;
        end;


end;

procedure TMRAnimalService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TAnimal) then
    raise Exception.Create('Object type Mismatch - TMRAnimalService.TestObjectClass');
end;

function TMRAnimalService.Update(AObj: TObject): Boolean;
var
  Animal: TAnimal;
begin

  Result := False;
  TestObjectClass(AObj);
  inherited Import(AObj);
  Animal := TAnimal(AObj);
  if Animal.IDPet <> null then
    begin
      if Find(Animal) then
        Result := UpdateAnimal(Animal)
      else
        Result := True;
    end
  else
    Result := True;

end;

function TMRAnimalService.UpdateAnimal(Animal: TAnimal): Boolean;
begin
  try
    Result := True;
    try
      Result := UpdateInventoryAnimal(Animal);

      if FInsertQuery.Active then
        FInsertQuery.Close;
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('UPDATE PET SET IDColor = :IDColor, IDStore = :IDStore, IDPorte = :IDPorte, IDStatus = :IDStatus, ');
      FInsertQuery.SQL.Add('IDBreeder = :IDBreeder, Name = :Name, Sex = :Sex, PenNum = :PenNum, VendorCost = :VendorCost, ');
      FInsertQuery.SQL.Add('MSRP = :MSRP, SalePrice = IsNull(:SalePrice, SalePrice), PromoPrice = :PromoPrice, USDA = :USDA, Collar = :Collar, ');
      FInsertQuery.SQL.Add('Sire = :Sire, Dam = :Dam, WhelpDate = :WhelpDate, PurchaseDate = :PurchaseDate, Notes = :Notes, Desativado = :Desativado');
      FInsertQuery.SQL.Add(' WHERE IDPet = :IDPet ');

      FInsertQuery.Parameters.ParamByName('IDPet').Value        := Animal.IDPet;
      FInsertQuery.Parameters.ParamByName('IDStore').Value      := Animal.IDStore;
      FInsertQuery.Parameters.ParamByName('IDStatus').Value     := Animal.IDStatus;
      FInsertQuery.Parameters.ParamByName('Name').Value         := Animal.Name;
      FInsertQuery.Parameters.ParamByName('Sex').Value          := FormatSex(Animal.Sex);
      FInsertQuery.Parameters.ParamByName('PenNum').Value       := Animal.PenNum;
      FInsertQuery.Parameters.ParamByName('VendorCost').Value   := Animal.VendorCost;
      FInsertQuery.Parameters.ParamByName('MSRP').Value         := Animal.MSRP;
      FInsertQuery.Parameters.ParamByName('PromoPrice').Value   := Animal.PromoPrice;
      FInsertQuery.Parameters.ParamByName('USDA').Value         := Animal.USDA;
      FInsertQuery.Parameters.ParamByName('Collar').Value       := Animal.Collar;
      FInsertQuery.Parameters.ParamByName('Sire').Value         := Animal.Sire;
      FInsertQuery.Parameters.ParamByName('Dam').Value          := Animal.Dam;
      FInsertQuery.Parameters.ParamByName('WhelpDate').Value    := Animal.WhelpDate;
      FInsertQuery.Parameters.ParamByName('PurchaseDate').Value := Animal.PurchaseDate;
      FInsertQuery.Parameters.ParamByName('Notes').Value        := Animal.Notes;
      FInsertQuery.Parameters.ParamByName('Desativado').Value   := Animal.Desativado;
      if Animal.SalePrice <> 0 then
        FInsertQuery.Parameters.ParamByName('SalePrice').Value  := Animal.SalePrice
      else
        FInsertQuery.Parameters.ParamByName('SalePrice').Value  := NULL;

      if Animal.AnimalColor <> nil then
        FInsertQuery.Parameters.ParamByName('IDColor').Value    := Animal.AnimalColor.IDColor;
      if Animal.Port <> nil then
        FInsertQuery.Parameters.ParamByName('IDPorte').Value    := Animal.Port.IDPort;
      if Animal.Breeder <> nil then
        FInsertQuery.Parameters.ParamByName('IDBreeder').Value  := Animal.Breeder.IDPessoa;

      FInsertQuery.ExecSQL;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;

end;

function TMRAnimalService.UpdateInventoryAnimal(Animal: TAnimal): Boolean;
var
  ABarcode : TBarcode;
  AMRModelService : TMRModelService;
begin
  ABarcode := CreateBarcode;
  try
    AMRModelService := TMRModelService.Create;
    try
      AMRModelService.SQLConnection := FSQLConnection;
      ABarcode.Model.VendorCost     := Animal.VendorCost;
      ABarcode.Model.SellingPrice   := Animal.SalePrice;
      ABarcode.Model.IDModel        := Animal.IDModel;
      Result := AMRModelService.UpdatePrices(ABarcode.Model);
    finally
      FreeAndNil(AMRModelService);
    end;
  finally
    FreeAndNil(ABarcode);
  end;
end;

{ TMRAnimalSpeciesService }

function TMRAnimalSpeciesService.Find(AObj: TObject): Boolean;
var
  Species: TSpecies;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Species := TSpecies(AObj);
      
    FSearchQuery.SQL.Add(Format('SELECT IDSpecies FROM Pet_Species WHERE Species = %S', [QuotedStr(Species.Species)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Species.IDSpecies := FSearchQuery.FieldByName('IDSpecies').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRAnimalSpeciesService.Import(AObj: TObject): Boolean;
var
  Species: TSpecies;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      Species := TSpecies(AObj);
      
    if Species.IDSpecies = null then
    begin
      if Find(Species) then
        Result := True
      else
        Result := InsertSpecies(Species)
    end
    else
    begin
      Result := True;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
      Result := False;
    end;
  end;
end;

function TMRAnimalSpeciesService.InsertSpecies(Species: TSpecies): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_Species', 'IDSpecies', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO Pet_Species (IDSpecies, Species)');
      FInsertQuery.SQL.Add('VALUES (:IDSpecies, :Species)');
      FInsertQuery.Parameters.ParamByName('IDSpecies').Value := tmpID;
      FInsertQuery.Parameters.ParamByName('Species').Value   := Species.Species;

      FInsertQuery.ExecSQL;
      Species.IDSpecies := tmpID;
    except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRAnimalSpeciesService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TSpecies) then
    raise Exception.Create('Object type Mismatch - TMRAnimalSpeciesService.TestObjectClass');
end;

function TMRAnimalSpeciesService.Update(AObj: TObject): Boolean;
var
  Species: TSpecies;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      Species := TSpecies(AObj);
      
    if Species.IDSpecies <> null then
      begin
        if Find(Species) then
          Result := UpdateSpecies(Species)
        else
          Result := True;
      end
    else
      Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRAnimalSpeciesService.UpdateSpecies(Species: TSpecies): Boolean;
begin
  Result := True;
end;

{ TMRAnimalBreedService }

function TMRAnimalBreedService.Find(AObj: TObject): Boolean;
var
  Breed: TBreed;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Breed := TBreed(AObj);
      
    FSearchQuery.SQL.Add(Format('SELECT IDBreed FROM Pet_Breed WHERE Breed = %S', [QuotedStr(Breed.Breed)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Breed.IDBreed := FSearchQuery.FieldByName('IDBreed').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRAnimalBreedService.Import(AObj: TObject): Boolean;
var
  Breed: TBreed;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      Breed := TBreed(AObj);
      
    if Breed.IDBreed = null then
    begin
      if Find(Breed) then
        Result := True
      else
        Result := InsertBreed(Breed)
    end
    else
    begin
      Result := True;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRAnimalBreedService.InsertBreed(Breed: TBreed): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_Breed', 'IDBreed', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO Pet_Breed (IDBreed, Breed)');
      FInsertQuery.SQL.Add('VALUES (:IDBreed, :Breed)');
      FInsertQuery.Parameters.ParamByName('IDBreed').Value := tmpID;
      FInsertQuery.Parameters.ParamByName('Breed').Value   := Breed.Breed;

      FInsertQuery.ExecSQL;
      Breed.IDBreed := tmpID;
    except
      on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRAnimalBreedService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TBreed) then
    raise Exception.Create('Object type Mismatch - TMRAnimalBreedService.TestObjectClass');
end;

{ TMRAnimalColorService }

function TMRAnimalColorService.Find(AObj: TObject): Boolean;
var
  AnimalColor: TAnimalColor;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      AnimalColor := TAnimalColor(AObj);
      
    FSearchQuery.SQL.Add(Format('SELECT IDColor FROM Pet_Color WHERE Color = %S', [QuotedStr(AnimalColor.Color)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        AnimalColor.IDColor := FSearchQuery.FieldByName('IDColor').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRAnimalColorService.Import(AObj: TObject): Boolean;
var
  AnimalColor: TAnimalColor;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      AnimalColor := TAnimalColor(AObj);
      
    if AnimalColor.IDColor = null then
    begin
      if Find(AnimalColor) then
        Result := True
      else
        Result := InsertAnimalColor(AnimalColor)
    end
    else
    begin
      Result := True;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRAnimalColorService.InsertAnimalColor(
  AnimalColor: TAnimalColor): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_Color', 'IDColor', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO Pet_Color (IDColor, Color)');
      FInsertQuery.SQL.Add('VALUES (:IDColor, :Color)');
      FInsertQuery.Parameters.ParamByName('IDColor').Value := tmpID;
      FInsertQuery.Parameters.ParamByName('Color').Value   := AnimalColor.Color;

      FInsertQuery.ExecSQL;
      AnimalColor.IDColor := tmpID;
    except
      on E: Exception do
      begin
        Result := False;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRAnimalColorService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TAnimalColor) then
    raise Exception.Create('Object type Mismatch - TMRAnimalColorService.TestObjectClass');
end;

{ TMREntityService }

function TMREntityService.Find(AObj: TObject): Boolean;
var
  Entity: TEntity;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Entity := TEntity(AObj);

    FSearchQuery.SQL.Add(Format('SELECT IDPessoa FROM Pessoa WHERE Pessoa = %S AND IDTipoPessoa = %S', [QuotedStr(Entity.Pessoa), IntToStr(Entity.IDTipoPessoa)]));

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Entity.IDPessoa := FSearchQuery.FieldByName('IDPessoa').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMREntityService.GetCode(IDTipoPessoa: Integer): Integer;
var
  FQuery: TADOQuery;
  sPath : String;
begin

  Result := -1;

  SQLConnection.Execute(' UPDATE TipoPessoa SET LastCode = IsNull(LastCode,0) + 1 ' +
                        ' WHERE IDTipoPessoa = ' + IntToStr(IDTipoPessoa));

  FQuery := TADOQuery.Create(nil);
  Try
    FQuery.Connection := SQLConnection;
    FQuery.SQL.Add('SELECT Path from TipoPessoa WHERE IDTipoPessoa = ' + InttoStr(IDTipoPessoa));
    FQuery.Open;
    sPath := FQuery.FieldByName('Path').AsString;
    FQuery.Close;
    FQuery.SQL.Clear;

    FQuery.SQL.Add('SELECT LastCode from TipoPessoa WHERE IDTipoPessoa = ' + InttoStr(IDTipoPessoa) );
    FQuery.SQL.Add(' AND Path = ' + QuotedStr(sPath));
    FQuery.Open;
    Result := FQuery.FieldByName('LastCode').AsInteger;
    FQuery.Close;
  finally
    FreeAndNil(FQuery);
    end;

end;

function TMREntityService.Import(AObj: TObject): Boolean;
var
  Entity: TEntity;
begin

  Result := False;
  TestObjectClass(AObj);
  inherited Import(AObj);

  if (AObj <> nil) then
    Entity := TEntity(AObj);

  if Entity.State <> nil then
  with TMRStateService.Create do
    try
      SQLConnection := Self.SQLConnection;
      Import(Entity.State);
    finally
      Free;
    end;

  if Entity.IDPessoa = Null then
  begin
    if Find(Entity) then
      Result := True
    else
      Result := InsertEntity(Entity)
  end
  else
  begin
    Result := True;
  end;

end;

function TMREntityService.InsertEntity(Entity: TEntity): Boolean;
var
  tmpID: Integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pessoa', 'IDPessoa', FSQLConnection);
      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO Pessoa (IDPessoa, IDTipoPessoa, IDStore, IDTipoPessoaRoot, IDUSer, ');
      FInsertQuery.SQL.Add('Pessoa, PessoaFirstName, PessoaLastName, ShortName, NomeJuridico, Endereco,');
      FInsertQuery.SQL.Add('Cidade, CEP, Pais, Telefone, Cellular, Fax, Contato, Email, OBS, ');
      FInsertQuery.SQL.Add('CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, OrgaoEmissor,');
      FInsertQuery.SQL.Add('Bairro, CartMotorista, Juridico, Code, PhoneAreaCode, CellAreaCode, IDEstado)');

      FInsertQuery.SQL.Add('VALUES (:IDPessoa, :IDTipoPessoa, :IDStore, :IDTipoPessoaRoot, :IDUSer, :Pessoa, :PessoaFirstName,');
      FInsertQuery.SQL.Add(':PessoaLastName, :ShortName, :NomeJuridico, :Endereco, :Cidade, :CEP, :Pais, :Telefone, :Cellular,');
      FInsertQuery.SQL.Add(':Fax, :Contato, :Email, :OBS, :CPF, :CGC, :Identidade, :CartTrabalho, :InscEstadual,');
      FInsertQuery.SQL.Add(':InscMunicipal, :OrgaoEmissor, :Bairro, :CartMotorista, :Juridico, :Code, :PhoneAreaCode, ');
      FInsertQuery.SQL.Add(':CellAreaCode, :IDEstado)');

      FInsertQuery.Parameters.ParamByName('IDPessoa').Value         := tmpID;
	    FInsertQuery.Parameters.ParamByName('IDTipoPessoa').Value     := Entity.IDTipoPessoa;
	    FInsertQuery.Parameters.ParamByName('IDStore').Value          := Entity.IDStore;
	    FInsertQuery.Parameters.ParamByName('IDTipoPessoaRoot').Value := Entity.IDTipoPessoaRoot;
	    FInsertQuery.Parameters.ParamByName('IDUSer').Value           := Entity.IDUSer;
	    FInsertQuery.Parameters.ParamByName('Pessoa').Value           := Entity.Pessoa;
	    FInsertQuery.Parameters.ParamByName('PessoaFirstName').Value  := Entity.PessoaFirstName;
	    FInsertQuery.Parameters.ParamByName('PessoaLastName').Value   := Entity.PessoaLastName;
	    FInsertQuery.Parameters.ParamByName('ShortName').Value        := Entity.ShortName;
	    FInsertQuery.Parameters.ParamByName('NomeJuridico').Value     := Entity.NomeJuridico;
	    FInsertQuery.Parameters.ParamByName('Endereco').Value         := Entity.Endereco;
	    FInsertQuery.Parameters.ParamByName('Cidade').Value           := Entity.Cidade;
	    FInsertQuery.Parameters.ParamByName('CEP').Value              := Entity.CEP;
	    FInsertQuery.Parameters.ParamByName('Pais').Value             := Entity.Pais;
	    FInsertQuery.Parameters.ParamByName('Telefone').Value         := Entity.Telefone;
	    FInsertQuery.Parameters.ParamByName('Cellular').Value         := Entity.Cellular;
	    FInsertQuery.Parameters.ParamByName('Fax').Value              := Entity.Fax;
	    FInsertQuery.Parameters.ParamByName('Contato').Value          := Entity.Contato;
	    FInsertQuery.Parameters.ParamByName('Email').Value            := Entity.Email;
	    FInsertQuery.Parameters.ParamByName('OBS').Value              := Entity.OBS;
	    FInsertQuery.Parameters.ParamByName('CPF').Value              := Entity.CPF;
	    FInsertQuery.Parameters.ParamByName('CGC').Value              := Entity.CGC;
	    FInsertQuery.Parameters.ParamByName('Identidade').Value       := Entity.Identidade;
	    FInsertQuery.Parameters.ParamByName('CartTrabalho').Value     := Entity.CartTrabalho;
	    FInsertQuery.Parameters.ParamByName('InscEstadual').Value     := Entity.InscEstadual;
	    FInsertQuery.Parameters.ParamByName('InscMunicipal').Value    := Entity.InscMunicipal;
	    FInsertQuery.Parameters.ParamByName('OrgaoEmissor').Value     := Entity.OrgaoEmissor;
	    FInsertQuery.Parameters.ParamByName('Bairro').Value           := Entity.Bairro;
	    FInsertQuery.Parameters.ParamByName('CartMotorista').Value    := Entity.CartMotorista;
	    FInsertQuery.Parameters.ParamByName('Juridico').Value         := Entity.Juridico;
	    FInsertQuery.Parameters.ParamByName('Code').Value             := GetCode(Entity.IDTipoPessoa);
	    FInsertQuery.Parameters.ParamByName('PhoneAreaCode').Value    := Entity.PhoneAreaCode;
	    FInsertQuery.Parameters.ParamByName('CellAreaCode').Value     := Entity.CellAreaCode;
      if Entity.State <> nil then
        FInsertQuery.Parameters.ParamByName('IDEstado').Value       := Entity.State.IDState;

      FInsertQuery.ExecSQL;
      Entity.IDPessoa := tmpID;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMREntityService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TEntity) then
    raise Exception.Create('Object type Mismatch - TMREntityService.TestObjectClass');
end;

function TMREntityService.Update(AObj: TObject): Boolean;
var
  Entity: TEntity;
begin

  Result := False;
  TestObjectClass(AObj);
  inherited Import(AObj);

  if (AObj <> nil) then
    Entity := TEntity(AObj);
    
  if Entity.IDPessoa <> null then
    begin
      if Find(Entity) then
        Result := UpdateEntity(Entity)
      else
        Result := True;
    end
  else
    Result := True;

end;

function TMREntityService.UpdateEntity(Entity: TEntity): Boolean;
begin
  Result := True;
end;

{ TMRAnimalMicrochipService }

function TMRAnimalMicrochipService.Find(AObj: TObject): Boolean;
var
  Microchip: TMicrochip;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      Microchip := TMicrochip(AObj);
      
    FSearchQuery.SQL.Add(Format('SELECT IDMicrochip FROM Pet_PetMicrochip WHERE MicrochipNum = %S', [QuotedStr(Microchip.MicrochipNum)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        Microchip.IDMicrochip := FSearchQuery.FieldByName('IDMicrochip').AsInteger;
    finally
      FSearchQuery.Close;
    end;

  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRAnimalMicrochipService.Import(AObj: TObject): Boolean;
var
  Microchip: TMicrochip;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      Microchip := TMicrochip(AObj);
      
    if (Microchip.MicrochipNum <> '') and (Microchip.IDMicrochip = null) and (FIDPet <> Null) and (FIDKitModel <> Null) then
    begin
      if Find(Microchip) then
        Result := True
      else
        Result := InsertMicrochip(Microchip)
    end
    else
    begin
      Result := True;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalMicrochipService.InsertKitModelMicrochip(Microchip: TMicrochip): Boolean;
var
  tmpID: integer;
  FQuery: TADOQuery;
  AMRBarcodeService : TMRBarcodeService;
  ABarcode : TBarcode;
begin
  Result := False;

  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := SQLConnection;

    FQuery.SQL.Add('SELECT IDModel FROM Barcode WHERE IDBarcode = :IDBarcode');
    FQuery.Parameters.ParamByName('IDBarcode').Value := Microchip.MicrochipNum;
    FQuery.Open;

    if FQuery.IsEmpty then
    try
      ABarcode := TBarcode.Create;
      ABarcode.Model := TModel.Create;
      try
        AMRBarcodeService := TMRBarcodeService.Create;
        AMRBarcodeService.SQLConnection := SQLConnection;
        ABarcode.IDBarcode := Microchip.MicrochipNum;
        ABarcode.Model.IDModel := FIDKitModel;
        Result := AMRBarcodeService.Import(ABarcode);
      finally
        FreeAndNil(AMRBarcodeService);
      end;
    finally
      FreeAndNil(ABarcode);
    end;
    Result := True;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;

end;

function TMRAnimalMicrochipService.InsertMicrochip(
  Microchip: TMicrochip): Boolean;
var
  tmpID: integer;
  FQuery: TADOQuery;
begin
  Result := True;

  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := SQLConnection;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;

      FQuery.SQL.Add('SELECT IDMicrochip FROM Pet_Microchip WHERE Desativado = 0');
      FQuery.Open;
      FQuery.First;
      while not FQuery.Eof do
      begin
        FInsertQuery.SQL.Clear;
        FInsertQuery.SQL.Add('INSERT INTO Pet_PetMicrochip (IDMicrochip, IDPet, MicrochipNum)');
        FInsertQuery.SQL.Add('VALUES (:IDMicrochip, :IDPet, :MicrochipNum)');
        FInsertQuery.Parameters.ParamByName('IDMicrochip').Value  := FQuery.FieldByName('IDMicrochip').AsInteger;
        FInsertQuery.Parameters.ParamByName('IDPet').Value        := FIDPet;
        FInsertQuery.Parameters.ParamByName('MicrochipNum').Value := Microchip.MicrochipNum;
        FInsertQuery.ExecSQL;

        FQuery.Next;
      end;

      Result := InsertKitModelMicrochip(Microchip);
    except
      begin
        raise;
        Result := False;
      end;
    end;
  finally
    FInsertQuery.Close;
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

procedure TMRAnimalMicrochipService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TMicrochip) then
    raise Exception.Create('Object type Mismatch - TMRAnimalMicrochipService.TestObjectClass');
end;

{ TMRAnimalWeightService }

function TMRAnimalWeightService.Find(AObj: TObject): Boolean;
var
  AnimalWeight: TAnimalWeight;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      AnimalWeight := TAnimalWeight(AObj);
      
    FSearchQuery.SQL.Add('SELECT IDWeight FROM Pet_Weight WHERE IDPet = :IDPet');
    FSearchQuery.SQL.Add('AND EntryDate = :EntryDate AND Weight = :Weight');
    FSearchQuery.Parameters.ParamByName('IDPet').Value     := FIDPet;
    FSearchQuery.Parameters.ParamByName('EntryDate').Value := AnimalWeight.EntryDate;
    FSearchQuery.Parameters.ParamByName('Weight').Value    := AnimalWeight.Weight;
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        AnimalWeight.IDWeight := FSearchQuery.FieldByName('IDWeight').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalWeightService.Import(AObj: TObject): Boolean;
var
  AnimalWeight: TAnimalWeight;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      AnimalWeight := TAnimalWeight(AObj);
      
    if (AnimalWeight.Weight <> 0) and (AnimalWeight.IDWeight = Null) and (FIDPet <> Null) then
    begin
      if Find(AnimalWeight) then
        Result := True
      else
        Result := InsertWeight(AnimalWeight)
    end
    else
    begin
      Result := True;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalWeightService.InsertWeight(
  AnimalWeight: TAnimalWeight): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_Weight', 'IDWeight', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO Pet_Weight (IDWeight, IDPet, EntryDate, Weight)');
      FInsertQuery.SQL.Add('VALUES (:IDWeight, :IDPet, :EntryDate, :Weight)');
      FInsertQuery.Parameters.ParamByName('IDWeight').Value  := tmpID;
      FInsertQuery.Parameters.ParamByName('IDPet').Value     := FIDPet;
      FInsertQuery.Parameters.ParamByName('EntryDate').Value := AnimalWeight.EntryDate;
      FInsertQuery.Parameters.ParamByName('Weight').Value    := AnimalWeight.Weight;

      FInsertQuery.ExecSQL;
      AnimalWeight.IDWeight := tmpID;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRAnimalWeightService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TAnimalWeight) then
    raise Exception.Create('Object type Mismatch - TMRAnimalWeightService.TestObjectClass');
end;

{ TMRAnimalRegistryService }

function TMRAnimalRegistryService.Find(AObj: TObject): Boolean;
var
  AnimalRegistry: TAnimalRegistry;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      AnimalRegistry := TAnimalRegistry(AObj);
      
    FSearchQuery.SQL.Add(Format('SELECT IDRegistry FROM Pet_Registry WHERE Registry = %S', [QuotedStr(AnimalRegistry.Registry)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        AnimalRegistry.IDRegistry := FSearchQuery.FieldByName('IDRegistry').AsInteger;
    finally
      FSearchQuery.Close;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalRegistryService.FindRegistration(AObj: TObject): Boolean;
var
  AnimalRegistry: TAnimalRegistry;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    FSearchQuery.SQL.Clear;
    FSearchQuery.SQL.Add('SELECT RegistrationNum FROM Pet_PetRegistry ');
    FSearchQuery.SQL.Add('WHERE IDRegistry = :IDRegistry AND IDPet = :IDPet');
    FSearchQuery.Parameters.ParamByName('IDPet').Value      := FIDPet;
    FSearchQuery.Parameters.ParamByName('IDRegistry').Value := AnimalRegistry.IDRegistry;

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;

  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalRegistryService.Import(AObj: TObject): Boolean;
var
  AnimalRegistry: TAnimalRegistry;
begin
  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      AnimalRegistry := TAnimalRegistry(AObj);
      
    if (AnimalRegistry.Registry <> '') and (AnimalRegistry.IDRegistry = Null) and (FIDPet <> Null) then
    begin
      if Find(AnimalRegistry) then
      begin
        if FindRegistration(AnimalRegistry) then
          Result := True
        else
          Result := InsertRegistry(AnimalRegistry)
      end
      else
        Result := True;
    end
    else
    begin
      Result := True;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalRegistryService.InsertRegistry(
  AnimalRegistry: TAnimalRegistry): Boolean;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;

      FInsertQuery.SQL.Add('INSERT INTO Pet_PetRegistry (IDRegistry, IDPet, RegistrationNum)');
      FInsertQuery.SQL.Add('VALUES (:IDRegistry, :IDPet, :RegistrationNum)');
      FInsertQuery.Parameters.ParamByName('IDRegistry').Value      := AnimalRegistry.IDRegistry;
      FInsertQuery.Parameters.ParamByName('IDPet').Value           := FIDPet;
      FInsertQuery.Parameters.ParamByName('RegistrationNum').Value := AnimalRegistry.RegistrationNum;

      FInsertQuery.ExecSQL;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRAnimalRegistryService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TAnimalRegistry) then
    raise Exception.Create('Object type Mismatch - TMRAnimalRegistryService.TestObjectClass');
end;

{ TMRStateService }

function TMRStateService.Find(AObj: TObject): Boolean;
var
  State: TState;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      State := TState(AObj);

    FSearchQuery.SQL.Add(Format('SELECT IDEstado as IDEstado FROM Estado WHERE Estado = %S OR IDEstado = %S', [QuotedStr(State.StateName), QuotedStr(Copy(State.StateName,1,3))]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        State.IDState := Trim(FSearchQuery.FieldByName('IDEstado').AsString);
    finally
      FSearchQuery.Close;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRStateService.Import(AObj: TObject): Boolean;
var
  State: TState;
begin

  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      State := TState(AObj);
      
    if (State.IDState = '') and (State.StateName <> '') then
      begin
        if Find(State) then
          Result := True
        else
          Result := InsertState(State)
      end
    else
      Result := True;
  except
    raise;
    Result := False;
  end;
end;

function TMRStateService.InsertState(State: TState): Boolean;
var
  tmpID : String;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;

      tmpID := Trim(Copy(State.StateName, 0, 3));
      FInsertQuery.SQL.Add('INSERT INTO Estado (IDEstado, Estado)');
      FInsertQuery.SQL.Add('VALUES (:IDEstado, :Estado)');
      FInsertQuery.Parameters.ParamByName('IDEstado').Value := tmpID;
      FInsertQuery.Parameters.ParamByName('Estado').Value   := State.StateName;

      FInsertQuery.ExecSQL;
      State.IDState := tmpID;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRStateService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TState) then
    raise Exception.Create('Object type Mismatch - TMRStateService.TestObjectClass');
end;

{ TMRTreatmentService }

function TMRTreatmentService.Find(AObj: TObject): Boolean;
var
  AnimalTreatment: TAnimalTreatment;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      AnimalTreatment := TAnimalTreatment(AObj);

    FSearchQuery.SQL.Add(Format('SELECT IDTreatment FROM Pet_Treatment WHERE Treatment = %S', [QuotedStr(AnimalTreatment.Treatment)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        AnimalTreatment.IDTreatment := FSearchQuery.FieldByName('IDTreatment').AsString;
    finally
      FSearchQuery.Close;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TMRTreatmentService.FindLot(AObj: TObject): Boolean;
var
  AnimalTreatment: TAnimalTreatment;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      AnimalTreatment := TAnimalTreatment(AObj);

    FSearchQuery.SQL.Add(Format('SELECT IDTreatmentLot FROM Pet_TreatmentLot WHERE LotNumber = %S AND IDTreatment = %S', [QuotedStr(AnimalTreatment.AnimalTreatmentLot.LotNumber), IntToStr(AnimalTreatment.IDTreatment)]));
    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
      if Result then
        AnimalTreatment.AnimalTreatmentLot.IDTreatmentLot := FSearchQuery.FieldByName('IDTreatmentLot').AsString;
    finally
      FSearchQuery.Close;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRTreatmentService.Import(AObj: TObject): Boolean;
var
  AnimalTreatment: TAnimalTreatment;
begin

  try
    TestObjectClass(AObj);
    inherited Import(AObj);

    if (AObj <> nil) then
      AnimalTreatment := TAnimalTreatment(AObj);
      
    if (AnimalTreatment.IDTreatment = Null) then
      begin
        if Find(AnimalTreatment) then
          Result := True
        else
          Result := InsertTreatment(AnimalTreatment);

        if Result and (AnimalTreatment.AnimalTreatmentLot <> Nil) and
           (AnimalTreatment.AnimalTreatmentLot.IDTreatmentLot = Null) then
        if FindLot(AnimalTreatment) then
          Result := True
        else
          Result := InsertTreatmentLot(AnimalTreatment);
      end
    else
      Result := True;
  except
    raise;
    Result := False;
  end;
end;

function TMRTreatmentService.InsertTreatment(
  AnimalTreatment: TAnimalTreatment): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_Treatment', 'IDTreatment', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO Pet_Treatment (IDTreatment, Treatment, TreatmentType, Mfg, TreatmentLotSize)');
      FInsertQuery.SQL.Add('VALUES (:IDTreatment, :Treatment, :TreatmentType, :Mfg, :TreatmentLotSize)');

      FInsertQuery.Parameters.ParamByName('IDTreatment').Value      := tmpID;
      FInsertQuery.Parameters.ParamByName('Treatment').Value        := AnimalTreatment.Treatment;
      FInsertQuery.Parameters.ParamByName('TreatmentType').Value    := AnimalTreatment.TreatmentType;
      FInsertQuery.Parameters.ParamByName('Mfg').Value              := AnimalTreatment.Mfg;
      FInsertQuery.Parameters.ParamByName('TreatmentLotSize').Value := AnimalTreatment.TreatmentLotSize;

      FInsertQuery.ExecSQL;
      AnimalTreatment.IDTreatment := tmpID;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

function TMRTreatmentService.InsertTreatmentLot(
  AnimalTreatment: TAnimalTreatment): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_TreatmentLot', 'IDTreatmentLot', FSQLConnection);

      FInsertQuery.SQL.Clear;
      FInsertQuery.SQL.Add('INSERT INTO Pet_TreatmentLot (IDTreatmentLot, IDTreatment, LotNumber, ExpirationDate)');
      FInsertQuery.SQL.Add('VALUES (:IDTreatmentLot, :IDTreatment, :LotNumber, :ExpirationDate)');

      FInsertQuery.Parameters.ParamByName('IDTreatmentLot').Value  := tmpID;
      FInsertQuery.Parameters.ParamByName('IDTreatment').Value     := AnimalTreatment.IDTreatment;
      FInsertQuery.Parameters.ParamByName('LotNumber').Value       := AnimalTreatment.AnimalTreatmentLot.LotNumber;
      FInsertQuery.Parameters.ParamByName('ExpirationDate').Value  := AnimalTreatment.AnimalTreatmentLot.ExpirationDate;

      FInsertQuery.ExecSQL;
      AnimalTreatment.AnimalTreatmentLot.IDTreatmentLot := tmpID;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRTreatmentService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TAnimalTreatment) then
    raise Exception.Create('Object type Mismatch - TMRTreatmentService.TestObjectClass');
end;

{ TMRAnimalTreatmentService }

function TMRAnimalTreatmentService.Find(AObj: TObject): Boolean;
var
  AnimalTreatment: TAnimalTreatment;
begin
  Result := True;
  try
    TestObjectClass(AObj);
    inherited Find(AObj);

    if (AObj <> nil) then
      AnimalTreatment := TAnimalTreatment(AObj);

    FSearchQuery.SQL.Clear;
    FSearchQuery.SQL.Add('SELECT IDPetTreatment FROM Pet_PetTreatment');
    FSearchQuery.SQL.Add('WHERE IDTreatment = :IDTreatment AND IDPet = :IDPet');
    if AnimalTreatment.AnimalTreatmentLot <> nil then
    begin
      FSearchQuery.SQL.Add('AND IDTreatmentLot = :IDTreatmentLot');
      FSearchQuery.Parameters.ParamByName('IDTreatmentLot').Value := AnimalTreatment.AnimalTreatmentLot.IDTreatmentLot
    end;
    FSearchQuery.Parameters.ParamByName('IDTreatment').Value := AnimalTreatment.IDTreatment;
    FSearchQuery.Parameters.ParamByName('IDPet').Value       := FIDPet;

    FSearchQuery.Open;
    try
      Result := not FSearchQuery.IsEmpty;
    finally
      FSearchQuery.Close;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TMRAnimalTreatmentService.Import(AObj: TObject): Boolean;
var
  AnimalTreatment: TAnimalTreatment;
begin

  Result := False;

  TestObjectClass(AObj);
  AnimalTreatment := TAnimalTreatment(AObj);

  if AnimalTreatment <> nil then
  with TMRTreatmentService.Create do
    try
      SQLConnection := Self.SQLConnection;
      Import(AnimalTreatment);
    finally
      Free;
    end;

  if Find(AnimalTreatment) then
    Result := True
  else
    Result := InsertAnimalTreatment(AnimalTreatment);

end;

function TMRAnimalTreatmentService.InsertAnimalTreatment(
  AnimalTreatment: TAnimalTreatment): Boolean;
var
  tmpID: integer;
begin
  try
    Result := True;
    try
      if FInsertQuery.Active then
        FInsertQuery.Close;
      tmpID := GetNextCode('Pet_PetTreatment', 'IDPetTreatment', FSQLConnection);

      FInsertQuery.SQL.Add('INSERT INTO Pet_PetTreatment (IDPetTreatment, IDTreatment, IDTreatmentLot, IDPet, IDUser, TreatmentDate, Notes)');
      FInsertQuery.SQL.Add('VALUES (:IDPetTreatment, :IDTreatment, :IDTreatmentLot, :IDPet, :IDUser, :TreatmentDate, :Notes)');

      FInsertQuery.Parameters.ParamByName('IDPetTreatment').Value  := tmpID;
      FInsertQuery.Parameters.ParamByName('IDTreatment').Value     := AnimalTreatment.IDTreatment;
      if AnimalTreatment.AnimalTreatmentLot <> nil then
        FInsertQuery.Parameters.ParamByName('IDTreatmentLot').Value := AnimalTreatment.AnimalTreatmentLot.IDTreatmentLot
      else
        FInsertQuery.Parameters.ParamByName('IDTreatmentLot').Value := Null;
      FInsertQuery.Parameters.ParamByName('IDPet').Value           := FIDPet;
      FInsertQuery.Parameters.ParamByName('IDUser').Value          := AnimalTreatment.IDUser;
      if AnimalTreatment.TreatmentDate <> 0 then
        FInsertQuery.Parameters.ParamByName('TreatmentDate').Value := AnimalTreatment.TreatmentDate
      else
        FInsertQuery.Parameters.ParamByName('TreatmentDate').Value := Null;
      FInsertQuery.Parameters.ParamByName('Notes').Value           := AnimalTreatment.Notes;

      FInsertQuery.ExecSQL;
    except
      raise;
      Result := False;
    end;
  finally
    FInsertQuery.Close;
  end;
end;

procedure TMRAnimalTreatmentService.TestObjectClass(AObj: TObject);
begin
  inherited;
  if not (AObj is TAnimalTreatment) then
    raise Exception.Create('Object type Mismatch - TMRTreatmentService.TestObjectClass');
end;

end.
