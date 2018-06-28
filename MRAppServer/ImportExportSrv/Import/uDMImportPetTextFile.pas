unit uDMImportPetTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMImportTextFile, uDMImportPet, uPetClasses, DB, DBClient,
  ADODB;

type
  TDMImportPetTextFile = class(TDMImportTextFile)
    cdsPetTreatment: TClientDataSet;
    cdsPetTreatmentSKU: TStringField;
    cdsPetTreatmentMicrochip: TStringField;
    cdsPetTreatmentCollar: TStringField;
    cdsPetTreatmentTreatment: TStringField;
    cdsPetTreatmentTreatmentType: TIntegerField;
    cdsPetTreatmentMfg: TStringField;
    cdsPetTreatmentTreatmentLotSize: TIntegerField;
    cdsPetTreatmentLotNumber: TStringField;
    cdsPetTreatmentLotExpirationDate: TDateTimeField;
    cdsPetTreatmentIDUser: TIntegerField;
    cdsPetTreatmentDosesUsed: TIntegerField;
    cdsPetTreatmentTreatExpirationDate: TDateTimeField;
    cdsPetTreatmentTreatmentDate: TDateTimeField;
    cdsPetTreatmentNotes: TStringField;
    cdsPetTreatmentSpecies: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    FDMImportPet : TDMImportPet;
    function GetPetTreatmen(ACollar, AMicrochip : String) : TStringList;
  protected
    procedure BeforeImport; override;
    procedure ImportLine; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TDMImportPetTextFile }

procedure TDMImportPetTextFile.BeforeImport;
begin
  inherited;
  FDMImportPet := TDMImportPet.Create(self);
  FDMImportPet.SQLConnection := Self.SQLConnection;
end;

procedure TDMImportPetTextFile.ImportLine;
var
  FPetImportInfo : TPetImportInfo;
begin
  inherited;

  FPetImportInfo := TPetImportInfo.Create;
  try
    with FPetImportInfo do
    begin
      SKU            := VarToStr(GetParamValue('SKU'));
      Species        := VarToStr(GetParamValue('Species'));
      Sex            := VarToStr(GetParamValue('Sex'));
      Breed          := VarToStr(GetParamValue('Breed'));
      Breeder        := VarToStr(GetParamValue('Breeder'));
      BreederAddress := VarToStr(GetParamValue('BreederAddress'));
      BreederCity    := VarToStr(GetParamValue('BreederCity'));
      BreederState   := VarToStr(GetParamValue('BreederState'));
      BreederZip     := VarToStr(GetParamValue('BreederZip'));
      MicrochipBrand := VarToStr(GetParamValue('MicrochipBrand'));
      Microchip      := VarToStr(GetParamValue('Microchip'));
      PenNumber      := VarToStr(GetParamValue('PenNumber'));
      VendorCost     := GetParamCurrency('VendorCost');
      MSRP           := GetParamCurrency('MSRP');
      SalePrice      := GetParamCurrency('SalePrice');
      PromoPrice     := GetParamCurrency('PromoPrice');
      Whelpdate      := GetParamDateTime('Whelpdate');
      PurchaseDate   := GetParamDateTime('PurchaseDate');
      WeightDate     := GetParamDateTime('WeightDate');
      USDA           := VarToStr(GetParamValue('USDA'));
      Collar         := VarToStr(GetParamValue('Collar'));
      Sire           := VarToStr(GetParamValue('Sire'));
      Dam            := VarToStr(GetParamValue('Dam'));
      Notes          := VarToStr(GetParamValue('Notes'));
      Color          := VarToStr(GetParamValue('Color'));
      Status         := VarToStr(GetParamValue('Status'));
      Weight         := GetParamCurrency('Weight');
      Registry       := VarToStr(GetParamValue('Registry'));
      RegistryNumber := VarToStr(GetParamValue('RegistryNumber'));
      TreatmentList  := GetPetTreatmen(Collar, Microchip);
    end;

    FDMImportPet.ImportPetInfo(FPetImportInfo);
  finally
    FreeAndNil(FPetImportInfo.TreatmentList);
    FreeAndNil(FPetImportInfo);
    end;
end;

procedure TDMImportPetTextFile.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FDMImportPet);
end;

function TDMImportPetTextFile.GetPetTreatmen(ACollar,
  AMicrochip: String): TStringList;
var
  FAnimalTreatment : TAnimalTreatment;
begin

  Result := TStringList.Create;

  try
    cdsPetTreatment.Filter := 'Collar = ' + QuotedStr(ACollar);
    cdsPetTreatment.Filtered := True;

    if not cdsPetTreatment.IsEmpty then
    begin
      cdsPetTreatment.First;
      while not cdsPetTreatment.Eof do
      begin
        FAnimalTreatment                  := TAnimalTreatment.Create;
        FAnimalTreatment.Treatment        := cdsPetTreatment.FieldByName('Treatment').AsString;
        FAnimalTreatment.TreatmentType    := cdsPetTreatment.FieldByName('TreatmentType').AsInteger;
        FAnimalTreatment.Mfg              := cdsPetTreatment.FieldByName('Mfg').AsString;
        FAnimalTreatment.TreatmentLotSize := cdsPetTreatment.FieldByName('TreatmentLotSize').AsInteger;
        FAnimalTreatment.IDUser           := cdsPetTreatment.FieldByName('IDUser').AsInteger;
        FAnimalTreatment.Notes            := cdsPetTreatment.FieldByName('Notes').AsString;
        FAnimalTreatment.TreatmentDate    := cdsPetTreatment.FieldByName('TreatmentDate').AsDateTime;
        if (cdsPetTreatment.FieldByName('LotNumber').AsString <> '') then
        begin
          FAnimalTreatment.AnimalTreatmentLot                := TAnimalTreatmentLot.Create;
          FAnimalTreatment.AnimalTreatmentLot.LotNumber      := cdsPetTreatment.FieldByName('LotNumber').AsString;
          FAnimalTreatment.AnimalTreatmentLot.ExpirationDate := cdsPetTreatment.FieldByName('LotExpirationDate').AsDateTime;
        end;

        Result.AddObject('', FAnimalTreatment);
        cdsPetTreatment.Next;
      end;
    end;
  finally
    cdsPetTreatment.Filtered := False;
    cdsPetTreatment.Filter := '';
  end;

end;

end.
