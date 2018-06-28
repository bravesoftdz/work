(*
-----------------------------------------------------------------------------------------------------
Version : (287 - 275)
Date    : 11.17.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : create a single routine to allow users insert inventory item
Solution: Changes on class TModel ( I added new attribute memnbers )
Version : (287 - 276)
-----------------------------------------------------------------------------------------------------
*)

unit uContentClasses;

interface

uses Classes;

type
  TCategory = class
    IDGroup:         Variant;
    TabGroup:        String;
  public
    constructor Create();
  end;

  TModelGroup = class
    IDModelGroup:    Variant;
    IDGroup:         Variant;
    ModelGroup:      String;
  public
    constructor Create();
  end;

  TModelSubGroup = class
    IDModelSubGroup: Variant;
    IDModelGroup:    Variant;
    ModelSubGroup:   String;
  public
    constructor Create();
  end;

  TVendorSuggestedList = class
    IDVendor:   Variant;
    Vendor:     String;
    VendorCode: String;
    MinQtyPO:   Double;
    CaseQty:    Double;
    VendorCost: Currency;
  public
    constructor Create();
  end;

  //Nao usar mais isse. Usar o TEntity
  TVendor = class
    IDVendor:    Variant;
    Vendor:      String;
  public
    constructor Create();
  end;

  //Nao usar mais isse. Usar o TEntity
  TManufacturer = class
    IDManufacturer: Variant;
    Manufacturer: String;
  public
    constructor Create();
  end;

  TState = class
    IDState: String;
    StateName: String;
  end;

  TEntity = class
    IDPessoa         : Variant;
    IDTipoPessoa     : Variant;
    IDStore          : Variant;
    IDTipoPessoaRoot : Variant;
    IDUSer           : Variant;
    Pessoa           : String;
    PessoaFirstName  : String;
    PessoaLastName   : String;
    ShortName        : String;
    NomeJuridico     : String;
    Endereco         : String;
    Cidade           : String;
    CEP              : String;
    Pais             : String;
    Telefone         : String;
    Cellular         : String;
    Fax              : String;
    Contato          : String;
    Email            : String;
    OBS              : String;
    Nascimento       : TDateTime;
    CPF              : String;
    CGC              : String;
    Identidade       : String;
    CartTrabalho     : String;
    InscEstadual     : String;
    InscMunicipal    : String;
    OrgaoEmissor     : String;
    Bairro           : String;
    CartMotorista    : String;
    Juridico         : Boolean;
    Code             : String;
    PhoneAreaCode    : String;
    CellAreaCode     : String;
    State            : TState;
  public
    constructor Create();
    destructor Destroy(); override;
  end;


  TVendorModelCode = class
     IDVendorModelCode: Variant;
     IDModel:           Variant;
     IDVendor:          Variant;
     VendorCode:        String;
  public
    constructor Create();
  end;

  TInventory = class
    IDInventory:    Variant;
    IDModel:        Variant;
    IDStore:        Variant;
    IDUser:         Variant;
    QtyOnHand:      Double;
    MinQty:         Double;
    MaxQty:         Double;
    UpdateQty:      Boolean;
  public
    constructor Create();
  end;

  TInventorySerial = class
   StoreID : Variant;
   ModelID : Variant;
   Serial  : String;
  public
    constructor Create();
  end;

  TKitModel = class
    IDModel:        Variant;
    SellingPrice:   Currency;
    Qty:            Double;
    MarginPerc:     Double;
  public
    constructor Create();
  end;

  TModelVendor = class
    IDModel:        Variant;
    IDVendor:       Variant;
    VendorOrder:    Integer;
    MinQtyPO:       Double;
    CaseQty:        Double;
    VendorCost:     Double;
    LastCostChange: TDateTime;
  public
    constructor Create();
  end;

  TPackModel = class
    IDPackModel: Variant;
    IDModel:     Variant;
    Qty:         Double;
  public
    constructor Create();
  end;

  { amsouza 11.17.2010 - these are not used in that class.
    ES,
    PVD,
    PP,
    TR,
    AvgCost,
    ReplacementCost,
    FloatPercent,
    DiscountPerc,
    TotQtyOnHand,
    Verify,
    SendToTrash,
    UpdatePrice,
    UseScale,
    ScaleValidDay,
    UseLot,
    IndicadorProducao,
    IndicadorAT,
    IDNCM,
    WebDescription,
    Portion,
}
  TModel = class
    IDModel:      Variant;
    IDUserLastSellingPrice: Variant;
    IDSize:       Variant;
    IDColor:      Variant;
    IDUnit:       Variant;
    Model:        String;
    Description:  String;
    SellingPrice: Currency;
    SuggRetail:   Currency;
    VendorCost:   Currency;
    Qty:          Double;
    CaseQty:      Double;
    Markup:          Double;
    ModelType:       Char;
    Verify:          Boolean;
    DateLastCost:         TDateTime;
    DateLastSellingPrice: TDateTime;
    NotVerifyQty : Boolean;
    Vendor:          TVendor;
    Category:        TCategory;
    Manufacturer:    TManufacturer;
    Inventory:       TInventory;
    VendorModelCode: TVendorModelCode;
    ModelGroup:      TModelGroup;
    ModelSubGroup:   TModelSubGroup;
    ModelVendor:     TModelVendor;
    InventorySerial: TInventorySerial;
    FSuggestedVendor : TStringList;

    //amfsouza 11.17.2010 - adding member attributes
    freightCost: double;
    otherCost: double;
    weight: double;
    system: boolean;
    desativado: boolean;
    lastCost: double;
    classABC: String;
    automaticRequest: boolean;
    promotionPrice: double;
    customSalePrice: boolean;
    askUserOnSale: boolean;
    updatePrice: Integer;

  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TBarcode = class
    IDBarcode:    Variant;
    BarcodeCase:  Variant;
    Model:        TModel;
    Qty:          Double;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

uses Variants, SysUtils;

{ TCategory }

constructor TCategory.Create;
begin
  IDGroup := null;
end;

{ TBarcode }

constructor TBarcode.Create;
begin
  IDBarcode := null;
end;

destructor TBarcode.Destroy;
begin
  if Assigned(Model) then
    FreeAndNil(Model);

  inherited Destroy;
end;

{ TModelGroup }

constructor TModelGroup.Create;
begin
  IDModelGroup := null;
end;

{ TModelSubGroup }

constructor TModelSubGroup.Create;
begin
  IDModelSubGroup := null;
end;

{ TVendor }

constructor TVendor.Create;
begin
  IDVendor := null;
end;

{ TManufacturer }

constructor TManufacturer.Create;
begin
  IDManufacturer := null;
end;

{ TVendorModelCode }

constructor TVendorModelCode.Create;
begin
  IDVendorModelCode := null;
end;

{ TInventory }

constructor TInventory.Create;
begin
  IDInventory := null;
end;

{ TModel }

constructor TModel.Create;
begin
  IDModel := null;
  FSuggestedVendor := TStringList.Create;
end;

destructor TModel.Destroy;
var
  obj : TObject;
begin

  while FSuggestedVendor.Count > 0 do
  begin
    obj := FSuggestedVendor.Objects[0];
    if (obj <> nil) then
      FreeAndNil(obj);
    FSuggestedVendor.Delete(0);
  end;

  FreeAndNil(FSuggestedVendor);

  if Assigned(Vendor) then
    FreeAndNil(Vendor);

  if Assigned(Category) then
    FreeAndNil(Category);

  if Assigned(Manufacturer) then
    FreeAndNil(Manufacturer);

  if Assigned(Inventory) then
    FreeAndNil(Inventory);

  if Assigned(VendorModelCode) then
    FreeAndNil(VendorModelCode);

  if Assigned(ModelGroup) then
    FreeAndNil(ModelGroup);

  if Assigned(ModelSubGroup) then
    FreeAndNil(ModelSubGroup);

  if Assigned(ModelVendor) then
    FreeAndNil(ModelVendor);

  if Assigned(InventorySerial) then
    FreeAndNil(InventorySerial);

  inherited Destroy;

end;

{ TKitModel }

constructor TKitModel.Create;
begin
  IDModel := null;
end;

{ TModelVendor }

constructor TModelVendor.Create;
begin
  IDModel := null;
end;

{ TVendorSuggestedList }

constructor TVendorSuggestedList.Create;
begin
  IDVendor := null;
end;

{ TInventorySerial }

constructor TInventorySerial.Create;
begin
  StoreID := Null;
  ModelID := Null;
end;

{ TPackModel }

constructor TPackModel.Create;
begin
    IDPackModel := Null;
    IDModel := Null;
end;

{ TEntity }

constructor TEntity.Create;
begin
  IDPessoa         := Null;
  IDTipoPessoa     := Null;
  IDStore          := Null;
  IDTipoPessoaRoot := Null;
  IDUSer           := Null;
end;

destructor TEntity.Destroy;
begin

  if Assigned(State) then
    FreeAndNil(State);
    
  inherited;
end;

end.
