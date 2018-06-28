unit uPetClasses;

interface

uses Classes, Variants, uContentClasses, SysUtils;

const
  PET_STATUS_AVAILABLE = 1;
  PET_STATUS_ONHOLD    = 2;
  PET_STATUS_ISOLATION = 3;
  PET_STATUS_RETURN    = 4;
  PET_STATUS_SOLD      = 5;
  PET_STATUS_EXCEPTION = 6;


type
  TPetInfo = class
    FIDModel :Integer;
    FIDCategory :Integer;
    FIDKitCategory :Integer;
    FModel : String;
    FDescription : String;
    FSerial : String;
    FVendorCost : Currency;
    FSellingPrice : Currency;
    FQty : Double;
  end;

  TSpecies = class
    IDSpecies : Variant;
    Species : String;
  public
    constructor Create();
  end;

  TPort = class
    IDPort : Variant;
    Port : String;
  public
    constructor Create();
  end;

  TBreed = class
    IDBreed : Variant;
    Breed : String;
  public
    constructor Create();
  end;

  TAnimalColor = class
    IDColor : variant;
    Color : String;
  public
    constructor Create();
  end;

  TMicrochip = class
    IDMicrochip : variant;
    MicrochipNum : String;
    Brand : String;
  public
    constructor Create();
  end;

  TAnimalWeight = class
    IDWeight : variant;
    EntryDate : TDateTime;
    Weight : Double;
  public
    constructor Create();
  end;

  TAnimalRegistry = class
    IDRegistry : variant;
    Registry : String;
    RegistrationNum : String;
  public
    constructor Create();
  end;

  TAnimalTreatmentLot = class
    IDTreatmentLot : Variant;
    LotNumber      : String;
    ExpirationDate : TDateTime;
  public
    constructor Create();
  end;

  TAnimalTreatment = class
    IDTreatment        : Variant;
    IDUser             : Variant;
    Treatment          : String;
    TreatmentType      : Integer;
    Mfg                : String;
    TreatmentLotSize   : Integer;
    Notes              : String;
    TreatmentDate      : TDateTime;
    AnimalTreatmentLot : TAnimalTreatmentLot;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TAnimal = class
    IDPet          : Variant;
    IDStatus       : Variant;
    IDModel        : Variant;
    IDStore        : Variant;
    IDKitModel     : Variant;
    Name           : String;
    SKU            : String;
    Sex            : String;
    PenNum         : String;
    USDA           : String;
    Collar         : String;
    Sire           : String;
    Dam            : String;
    Notes          : String;
    VendorCost     : Currency;
    MSRP           : Currency;
    SalePrice      : Currency;
    PromoPrice     : Currency;
    WhelpDate      : TDateTime;
    PurchaseDate   : TDateTime;
    Desativado     : Boolean;
    Species        : TSpecies;
    Port           : TPort;
    Breed          : TBreed;
    Breeder        : TEntity;
    AnimalColor    : TAnimalColor;
    Microchip      : TMicrochip;
    AnimalWeight   : TAnimalWeight;
    AnimalRegistry : TAnimalRegistry;
    TreatmentList  : TStringList;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  TPetImportInfo = class
    IDPet          : Variant;
    IDSpecies      : Variant;
    IDPorte        : Variant;
    IDBreed        : Variant;
    IDStatus       : Variant;
    IDBreeder      : Variant;
    IDModel        : Variant;
    IDColor        : Variant;
    IDStore        : Variant;
    SKU            : String;
    Species        : String;
    Sex            : String;
    Breed          : String;
    Breeder        : String;
    BreederAddress : String;
    BreederCity    : String;
    BreederState   : String;
    BreederZip     : String;
    MicrochipBrand : String;
    Microchip      : String;
    PenNumber      : String;
    VendorCost     : Currency;
    MSRP           : Currency;
    SalePrice      : Currency;
    PromoPrice     : Currency;
    USDA           : String;
    Collar         : String;
    Sire           : String;
    Dam            : String;
    Whelpdate      : TDateTime;
    Notes          : String;
    Color          : String;
    Status         : String;
    PurchaseDate   : TDateTime;
    Weight         : Double;
    WeightDate     : TDateTime;
    Registry       : String;
    RegistryNumber : String;
    TreatmentList  : TStringList;
  public
    constructor Create();
    destructor Destroy(); override;
  end;


implementation

{ TPet }

constructor TAnimal.Create;
begin
  IDPet         := Null;
  IDStatus      := Null;
  IDModel       := Null;
  IDStore       := Null;
  IDKitModel    := Null;
end;

destructor TAnimal.Destroy;
var
  obj : TObject;
begin

  if Assigned(TreatmentList) then
  begin
    while TreatmentList.Count > 0 do
    begin
      obj := TreatmentList.Objects[0];
      if (obj <> nil) then
        FreeAndNil(obj);
      TreatmentList.Delete(0);
    end;
    //FreeAndNil(TreatmentList);
  end;

  inherited;
end;

{ TSpecies }

constructor TSpecies.Create;
begin
  IDSpecies := Null;
end;

{ TPort }

constructor TPort.Create;
begin
  IDPort := Null;
end;

{ TBreed }

constructor TBreed.Create;
begin
  IDBreed := Null;
end;

{ TAnimalColor }

constructor TAnimalColor.Create;
begin
  IDColor := Null;
end;

{ TMicrochip }

constructor TMicrochip.Create;
begin
  IDMicrochip := Null;
end;

{ TAnimalWeight }

constructor TAnimalWeight.Create;
begin
  IDWeight := Null;
  Weight := 0;
end;

{ TPetImportInfo }

constructor TPetImportInfo.Create;
begin
  IDPet         := Null;
  IDSpecies     := Null;
  IDPorte       := Null;
  IDBreed       := Null;
  IDStatus      := Null;
  IDBreeder     := Null;
  IDModel       := Null;
  IDColor       := Null;
  IDStore       := Null;
end;

destructor TPetImportInfo.Destroy;
var
  obj : TObject;
begin

  if Assigned(TreatmentList) then
  begin
    while TreatmentList.Count > 0 do
    begin
      obj := TreatmentList.Objects[0];
      if (obj <> nil) then
        FreeAndNil(obj);
      TreatmentList.Delete(0);
    end;

    //FreeAndNil(TreatmentList);
  end;

  inherited;
end;

{ TAnimalRegistry }

constructor TAnimalRegistry.Create;
begin
  IDRegistry := Null;
  RegistrationNum := '00000000';
end;

{ TAnimalTreatmentLot }

constructor TAnimalTreatmentLot.Create;
begin
  IDTreatmentLot := Null;
end;

{ TAnimalTreatment }

constructor TAnimalTreatment.Create;
begin
  IDTreatment := Null;
  IDUser      := Null;
end;

destructor TAnimalTreatment.Destroy;
begin

  if Assigned(AnimalTreatmentLot) then
    FreeAndNil(AnimalTreatmentLot);

  inherited;
end;

end.
