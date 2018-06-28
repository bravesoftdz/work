unit uDMImportPet;

interface

uses
  SysUtils, Classes, variants, ADODB, uPetClasses, uContentClasses,
  uObjectServices;

type
  TDMImportPet = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSQLConnection: TADOConnection;
    FLog: TStringList;
    function ImportPet(AAnimal : TAnimal) : Boolean;
    function GetPropertyDomain(AProperty: String): Variant;
  public
    function ImportPetInfo(APetImportInfo: TPetImportInfo): Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property Log: TStringList read FLog write FLog;
  end;

implementation

{$R *.dfm}

procedure TDMImportPet.DataModuleCreate(Sender: TObject);
begin
  FLog := TStringList.Create;
end;

procedure TDMImportPet.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FLog);
end;

function TDMImportPet.GetPropertyDomain(AProperty: String): Variant;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
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

function TDMImportPet.ImportPet(AAnimal: TAnimal): Boolean;
var
  FMRAnimalService : TMRAnimalService;
begin
  FMRAnimalService := TMRAnimalService.Create;
  try
    FMRAnimalService.SQLConnection := FSQLConnection;
    FMRAnimalService.InsertOrUpdate(AAnimal);
  finally
    FreeAndNil(FMRAnimalService);
    end;
end;

function TDMImportPet.ImportPetInfo(APetImportInfo: TPetImportInfo): Boolean;
var
  FAnimal : TAnimal;
  FSpecies : TSpecies;
  FBreed : TBreed;
  FAnimalColor : TAnimalColor;
  FEntity : TEntity;
  FMicrochip : TMicrochip;
  FAnimalWeight : TAnimalWeight;
  FAnimalRegistry : TAnimalRegistry;
begin

  FAnimal         := nil;
  FSpecies        := nil;
  FBreed          := nil;
  FEntity         := nil;
  FAnimalColor    := nil;
  FMicrochip      := nil;
  FAnimalWeight   := nil;
  FAnimalRegistry := nil;

  try
    if (APetImportInfo.Species <> '') or (APetImportInfo.IDSpecies <> Null) then
    begin
      FSpecies           := TSpecies.Create;
      FSpecies.Species   := APetImportInfo.Species;
      FSpecies.IDSpecies := APetImportInfo.IDSpecies;
    end;

    if (APetImportInfo.Breed <> '') or (APetImportInfo.IDBreed <> Null) then
    begin
      FBreed         := TBreed.Create;
      FBreed.Breed   := APetImportInfo.Breed;
      FBreed.IDBreed := APetImportInfo.IDBreed;
    end;

    if (APetImportInfo.Breeder <> '') or (APetImportInfo.IDBreeder <> Null) then
    begin
      FEntity := TEntity.Create;
      FEntity.IDPessoa         := APetImportInfo.IDBreeder;
      FEntity.Pessoa           := APetImportInfo.Breeder;
      FEntity.Endereco         := APetImportInfo.BreederAddress;
      FEntity.Cidade           := APetImportInfo.BreederCity;
      FEntity.CEP              := APetImportInfo.BreederZip;
      FEntity.Juridico         := True;
      FEntity.IDTipoPessoa     := StrToIntDef(GetPropertyDomain('PctBreederDefaultEntityType'), 2);
      FEntity.IDTipoPessoaRoot := StrToIntDef(GetPropertyDomain('PctBreederDefaultEntityType'), 2);

      if APetImportInfo.BreederState <> '' then
      begin
        FEntity.State := TState.Create;
        FEntity.State.StateName := APetImportInfo.BreederState;
      end;

    end;

    if (APetImportInfo.Color <> '') or (APetImportInfo.IDColor <> Null) then
    begin
      FAnimalColor := TAnimalColor.Create;
      FAnimalColor.Color   := APetImportInfo.Color;
      FAnimalColor.IDColor := APetImportInfo.IDColor;
    end;

    if (APetImportInfo.Microchip <> '') then
    begin
      FMicrochip := TMicrochip.Create;
      FMicrochip.MicrochipNum := APetImportInfo.Microchip;
      FMicrochip.Brand := APetImportInfo.MicrochipBrand;
    end;

    if (APetImportInfo.Weight <> 0) and (APetImportInfo.WeightDate <> 0) then
    begin
      FAnimalWeight := TAnimalWeight.Create;
      FAnimalWeight.Weight := APetImportInfo.Weight;
      FAnimalWeight.EntryDate := APetImportInfo.WeightDate;
    end;

    if (APetImportInfo.Registry <> '') then
    begin
      FAnimalRegistry := TAnimalRegistry.Create;
      FAnimalRegistry.Registry := APetImportInfo.Registry;
      if APetImportInfo.RegistryNumber <> '' then
        FAnimalRegistry.RegistrationNum := APetImportInfo.RegistryNumber;
    end;

    FAnimal := TAnimal.Create;
    with FAnimal do
    begin
      IDStore        := StrToIntDef(GetPropertyDomain('PctDefaultStore'), 1);
      IDStatus       := PET_STATUS_AVAILABLE;
      SKU            := APetImportInfo.SKU;
      Sex            := APetImportInfo.Sex;
      PenNum         := APetImportInfo.PenNumber;
      USDA           := APetImportInfo.USDA;
      Collar         := APetImportInfo.Collar;
      Sire           := APetImportInfo.Sire;
      Dam            := APetImportInfo.Dam;
      Notes          := APetImportInfo.Notes;
      VendorCost     := APetImportInfo.VendorCost;
      MSRP           := APetImportInfo.MSRP;
      SalePrice      := APetImportInfo.SalePrice;
      PromoPrice     := APetImportInfo.PromoPrice;
      WhelpDate      := APetImportInfo.Whelpdate;
      PurchaseDate   := APetImportInfo.PurchaseDate;
      Desativado     := False;
      Species        := FSpecies;
      Breed          := FBreed;
      Breeder        := FEntity;
      AnimalColor    := FAnimalColor;
      Microchip      := FMicrochip;
      AnimalWeight   := FAnimalWeight;
      AnimalRegistry := FAnimalRegistry;
      TreatmentList  := APetImportInfo.TreatmentList;
    end;
    ImportPet(FAnimal);
  finally
    if Assigned(FAnimalColor) then
      FreeAndNil(FAnimalColor);

    if Assigned(FEntity) then
      FreeAndNil(FEntity);

    if Assigned(FBreed) then
      FreeAndNil(FBreed);

    if Assigned(FSpecies) then
      FreeAndNil(FSpecies);

    if Assigned(FAnimalWeight) then
      FreeAndNil(FAnimalWeight);

    if Assigned(FMicrochip) then
      FreeAndNil(FMicrochip);

    if Assigned(FAnimalRegistry) then
      FreeAndNil(FAnimalRegistry);

    FreeAndNil(FAnimal);
  end;
end;

end.
