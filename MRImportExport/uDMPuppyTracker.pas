unit uDMPuppyTracker;

interface

uses
  SysUtils, Classes, DB, DBClient;

const
  LINE_TYPE_PUPS       = 'pups';
  LINE_TYPE_LITTERS    = 'litters';
  LINE_TYPE_BREED      = 'breed';
  LINE_TYPE_BREEDERS   = 'breeders';
  LINE_TYPE_HOUSESHOTS = 'houseshots';
  LINE_TYPE_PUPPYSHOTS = 'puppyshots';
  LINE_TYPE_VACCINES   = 'vaccines';
  LINE_TYPE_VACCMANU   = 'vaccmanu';
  LINE_TYPE_DEFECTS    = 'defects';
  LINE_TYPE_PEDIGREES  = 'Pedigrees';

type
  TDMPuppyTracker = class(TDataModule)
    cdsPup: TClientDataSet;
    cdsPupPuppy_No: TStringField;
    cdsPupBreed: TStringField;
    cdsPupSex: TStringField;
    cdsPupPur_Price: TCurrencyField;
    cdsPupWeight: TCurrencyField;
    cdsPupColor: TStringField;
    cdsPupUSDA: TStringField;
    cdsPupSales_Price: TCurrencyField;
    cdsPupChip_No: TStringField;
    cdsPupDied_Date: TDateTimeField;
    cdsPupComments: TStringField;
    cdsPupInvoice_Date: TDateTimeField;
    cdsPupDate_Purchased: TDateTimeField;
    cdsPupLitter_No: TStringField;
    cdsLitters: TClientDataSet;
    cdsLittersLitter_No: TStringField;
    cdsLittersDam: TStringField;
    cdsLittersSire: TStringField;
    cdsLittersBreeder: TStringField;
    cdsLittersRegistry_No: TStringField;
    cdsLittersWhelp_Date: TDateTimeField;
    cdsLittersRegistry: TStringField;
    cdsBreed: TClientDataSet;
    cdsBreedBreed_Code: TStringField;
    cdsBreedBreed_Name: TStringField;
    cdsBreedSpecies: TStringField;
    cdsBreeder: TClientDataSet;
    cdsBreederBreeder: TStringField;
    cdsBreederAddress1: TStringField;
    cdsBreederCity: TStringField;
    cdsBreederState: TStringField;
    cdsBreederZip: TStringField;
    cdsBreederFirst_Name: TStringField;
    cdsBreederLast_Name: TStringField;
    cdsHouseShots: TClientDataSet;
    cdsHouseShotsVaccine_Code: TStringField;
    cdsHouseShotsManu_Code: TStringField;
    cdsHouseShotsWeek_Ending_Date: TDateTimeField;
    cdsHouseShotsSpecies: TStringField;
    cdsHouseShotsLot: TStringField;
    cdsHouseShotsExpires: TDateTimeField;
    cdsHouseShotsDates_Given: TStringField;
    cdsPuppyShots: TClientDataSet;
    cdsPuppyShotsPuppy_No: TStringField;
    cdsPuppyShotsVaccine_Code: TStringField;
    cdsPuppyShotsManu_Code: TStringField;
    cdsPuppyShotsLot: TStringField;
    cdsPuppyShotsExpires: TDateTimeField;
    cdsPuppyShotsDates_Given: TStringField;
    cdsVaccines: TClientDataSet;
    cdsVaccinesVaccine_Code: TStringField;
    cdsVaccinesType: TIntegerField;
    cdsVaccinesVaccine_Name: TStringField;
    cdsVaccManu: TClientDataSet;
    cdsVaccManuManu_Code: TStringField;
    cdsVaccManuManufacturer: TStringField;
    cdsDefects: TClientDataSet;
    cdsDefectsDefect_Code: TStringField;
    cdsDefectsdefect_description: TStringField;
    cdsPedigrees: TClientDataSet;
    cdsPedigreesregistrycode: TStringField;
    cdsPedigreesdog_name: TStringField;
    cdsPedigreessire_name: TStringField;
    cdsPedigreesdam_name: TStringField;
    cdsPedigreesakc_registry: TStringField;
    cdsPupDefects: TStringField;
    cdsPupSurgery: TStringField;
    cdsLittersLitter_Pur_Date: TDateTimeField;
    cdsPupInv_Comments: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FPuppyData : TStringList;
    function LoadDataFromFile : Boolean;

    function GetLineType(sLine : String) : Boolean;
    function ImportPupLine(sLine : String) : Boolean;
    function ImportLitterLine(sLine : String) : Boolean;
    function ImportBreedLine(sLine : String) : Boolean;
    function ImportBreederLine(sLine : String) : Boolean;
    function ImportHouseShotsLine(sLine : String) : Boolean;
    function ImportPuppyShotsLine(sLine : String) : Boolean;
    function ImportVaccinesLine(sLine : String) : Boolean;
    function ImportVaccManuLine(sLine : String) : Boolean;
    function ImportDefectsLine(sLine : String) : Boolean;
    function ImportPedigreesLine(sLine : String) : Boolean;

    procedure CloseCDS;
    procedure OpenCDS;
  public
    function LoadPuppyTrackerData(FFilePath : String) : Boolean;

    function ParseFieldData(sLine, sField : String) : String;
    function FormatSpecies(sSpecies : String) : String;
    function FormatVaccineType(sType : String) : Integer;
  end;

implementation

uses StrUtils, uDateTimeFunctions, uNumericFunctions;

{$R *.dfm}

{ TDMPuppyTracker }

{
  --Treatment
  Treatment
  TreatmentType
  Mfg
  TreatmentLotSize
  --TreatmentLot
  LotNumber
  ExpirationDate
  --Pet
  SKU
  Microchip
  Collar
  --Pet_PetTreatment
  IDUser
  ExpirationDate
  DosesUsed
  TreatmentDate
  Notes


  litters.Litter_Pur_Date < houseshots.Week_Ending_Date
  Adicionar treatment
}

function TDMPuppyTracker.LoadPuppyTrackerData(FFilePath: String): Boolean;
begin

  Result := False;

  if FileExists(FFilePath) then
  begin
    FPuppyData.LoadFromFile(FFilePath);
    Result := LoadDataFromFile;
  end;
  
end;

procedure TDMPuppyTracker.DataModuleCreate(Sender: TObject);
begin
  FPuppyData := TStringList.Create;
end;

procedure TDMPuppyTracker.DataModuleDestroy(Sender: TObject);
begin
  CloseCDS;
  FreeAndNil(FPuppyData);
end;

function TDMPuppyTracker.LoadDataFromFile: Boolean;
var
  i : Integer;
begin

  Result := True;
  try
    CloseCDS;
    OpenCDS;
    for i := 0 to  FPuppyData.Count-1 do
      GetLineType(FPuppyData.Strings[i]);
  except
    raise;
    Result := False;
  end;

end;

procedure TDMPuppyTracker.CloseCDS;
begin
  cdsPup.Close;
  cdsLitters.Close;
  cdsBreed.Close;
  cdsBreeder.Close;
  cdsHouseShots.Close;
  cdsPuppyShots.Close;
  cdsVaccines.Close;
  cdsVaccManu.Close;
  cdsDefects.Close;
  cdsPedigrees.Close;
end;

procedure TDMPuppyTracker.OpenCDS;
begin
  cdsPup.CreateDataSet;
  cdsLitters.CreateDataSet;
  cdsBreed.CreateDataSet;
  cdsBreeder.CreateDataSet;
  cdsHouseShots.CreateDataSet;
  cdsPuppyShots.CreateDataSet;
  cdsVaccines.CreateDataSet;
  cdsVaccManu.CreateDataSet;
  cdsDefects.CreateDataSet;
  cdsPedigrees.CreateDataSet;
end;

function TDMPuppyTracker.GetLineType(sLine: String): Boolean;
var
  iEndType : Integer;
begin

  Result := False;

  iEndType := Pos('{', sLine);

  if Copy(sLine, 2, iEndType-2) = LINE_TYPE_PUPS then
    Result := ImportPupLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_LITTERS then
    Result := ImportLitterLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_BREED then
    Result := ImportBreedLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_BREEDERS then
    Result := ImportBreederLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_HOUSESHOTS then
    Result := ImportHouseShotsLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_PUPPYSHOTS then
    Result := ImportPuppyShotsLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_VACCINES then
    Result := ImportVaccinesLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_VACCMANU then
    Result := ImportVaccManuLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_DEFECTS then
    Result := ImportDefectsLine(sLine)
  else if Copy(sLine, 2, iEndType-2) = LINE_TYPE_PEDIGREES then
    Result := ImportPedigreesLine(sLine);

end;

function TDMPuppyTracker.ImportPupLine(sLine : String) : Boolean;
begin
  Result := True;

  try
    with cdsPup do
    begin
      Append;
      FieldByName('Puppy_No').Value       := ParseFieldData(sLine, 'Puppy_No');
      FieldByName('Breed').Value          := ParseFieldData(sLine, 'Breed');
      FieldByName('Sex').Value            := ParseFieldData(sLine, 'Sex');
      FieldByName('Weight').Value         := ParseFieldData(sLine, 'Weight');
      FieldByName('Color').Value          := ParseFieldData(sLine, 'Color');
      FieldByName('USDA').Value           := ParseFieldData(sLine, 'USDA');
      FieldByName('Chip_No').Value        := ParseFieldData(sLine, 'Chip_No');
      FieldByName('Comments').Value       := ParseFieldData(sLine, 'Comments');
      FieldByName('Defects').Value        := ParseFieldData(sLine, 'Defects');
      FieldByName('Surgery').Value        := ParseFieldData(sLine, 'Surgery');
      FieldByName('Litter_No').Value      := ParseFieldData(sLine, 'Litter_No');
      FieldByName('Inv_Comments').Value   := ParseFieldData(sLine, 'Inv_Comments');
      FieldByName('Sales_Price').Value    := MyStrToMoney(ParseFieldData(sLine, 'Sales_Price'));
      FieldByName('Pur_Price').Value      := MyStrToMoney(ParseFieldData(sLine, 'Pur_Price'));
      FieldByName('Died_Date').Value      := StrToDateTimeDef(ParseFieldData(sLine, 'Died_Date'), 0);
      FieldByName('Invoice_Date').Value   := StrToDateTimeDef(ParseFieldData(sLine, 'Invoice_Date'), 0);
      FieldByName('Date_Purchased').Value := StrToDateTimeDef(ParseFieldData(sLine, 'Date_Purchased'), 0) - 5;
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ImportLitterLine(sLine: String): Boolean;
begin
  Result := True;

  try
    with cdsLitters do
    begin
      Append;
      FieldByName('Dam').Value             := ParseFieldData(sLine, 'Dam');
      FieldByName('Sire').Value            := ParseFieldData(sLine, 'Sire');
      FieldByName('Breeder').Value         := ParseFieldData(sLine, 'Breeder');
      FieldByName('Registry_No').Value     := ParseFieldData(sLine, 'Registry_No');
      FieldByName('Registry').Value        := ParseFieldData(sLine, 'Registry');
      FieldByName('Litter_No').Value       := ParseFieldData(sLine, 'Litter_No');
      FieldByName('Whelp_Date').Value      := StrToDateTimeDef(ParseFieldData(sLine, 'Whelp_Date'), 0);
      FieldByName('Litter_Pur_Date').Value := StrToDateTimeDef(ParseFieldData(sLine, 'Litter_Pur_Date'), 0);
      Post;
    end;
  except
    raise;
    Result := False;
  end;
end;

function TDMPuppyTracker.ImportBreedLine(sLine: String): Boolean;
begin
  Result := True;

  try
    with cdsBreed do
    begin
      Append;
      FieldByName('Breed_Name').Value := ParseFieldData(sLine, 'Breed_Name');
      FieldByName('Species').Value    := FormatSpecies(ParseFieldData(sLine, 'Species'));
      FieldByName('Breed_Code').Value := ParseFieldData(sLine, 'Breed_Code');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ImportBreederLine(sLine: String): Boolean;
begin
  Result := True;

  try
    with cdsBreeder do
    begin
      Append;
      FieldByName('Breeder').Value    := ParseFieldData(sLine, 'Breeder');
      FieldByName('Address1').Value   := ParseFieldData(sLine, 'Address1');
      FieldByName('City').Value       := ParseFieldData(sLine, 'City');
      FieldByName('State').Value      := ParseFieldData(sLine, 'State');
      FieldByName('Zip').Value        := ParseFieldData(sLine, 'Zip');
      FieldByName('First_Name').Value := ParseFieldData(sLine, 'First_Name');
      FieldByName('Last_Name').Value  := ParseFieldData(sLine, 'Last_Name');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ParseFieldData(sLine, sField: String): String;
var
  FFieldPos : Integer;
  i : Integer;
begin
  Result := '';

  FFieldPos := Pos('{' + sField + '}', sLine) + Length('{' + sField + '}');
  Result := Copy(sLine, FFieldPos, Length(sLine));

  FFieldPos := Pos('\', Result) - 1;
  Result := Copy(Result, 0, FFieldPos);

end;

function TDMPuppyTracker.FormatSpecies(sSpecies: String): String;
begin
  if sSpecies = 'D' then
    Result := 'Dog'
  else if sSpecies = 'C' then
    Result := 'Cat'
  else
    Result := 'Dog';
end;

function TDMPuppyTracker.ImportHouseShotsLine(sLine: String): Boolean;
begin

  Result := True;

  try
    with cdsHouseShots do
    begin
      Append;
      FieldByName('Vaccine_Code').Value     := ParseFieldData(sLine, 'Vaccine_Code');
      FieldByName('Manu_Code').Value        := ParseFieldData(sLine, 'Manu_Code');
      FieldByName('Week_Ending_Date').Value := StrToDateTimeDef(ParseFieldData(sLine, 'Week_Ending_Date'), 0);
      FieldByName('Species').Value          := FormatSpecies(ParseFieldData(sLine, 'Species'));
      FieldByName('Lot').Value              := ParseFieldData(sLine, 'Lot');
      FieldByName('Expires').Value          := StrToDateTimeDef(ParseFieldData(sLine, 'Expires'), 0);
      FieldByName('Dates_Given').Value      := ParseFieldData(sLine, 'Dates_Given');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ImportPuppyShotsLine(sLine: String): Boolean;
begin

  Result := True;

  try
    with cdsPuppyShots do
    begin
      Append;
      FieldByName('Puppy_No').Value     := ParseFieldData(sLine, 'Puppy_No');
      FieldByName('Vaccine_Code').Value := ParseFieldData(sLine, 'Vaccine_Code');
      FieldByName('Manu_Code').Value    := ParseFieldData(sLine, 'Manu_Code');
      FieldByName('Lot').Value          := ParseFieldData(sLine, 'Lot');
      FieldByName('Expires').Value      := StrToDateTimeDef(ParseFieldData(sLine, 'Expires'), 0);
      FieldByName('Dates_Given').Value  := ParseFieldData(sLine, 'Dates_Given');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ImportVaccinesLine(sLine: String): Boolean;
begin

  Result := True;

  try
    with cdsVaccines do
    begin
      Append;
      FieldByName('Vaccine_Code').Value := ParseFieldData(sLine, 'Vaccine_Code');
      FieldByName('Vaccine_Name').Value := ParseFieldData(sLine, 'Vaccine_Name');
      FieldByName('Type').Value         := FormatVaccineType(ParseFieldData(sLine, 'Type'));
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.FormatVaccineType(sType: String): Integer;
begin
  if sType = 'V' then
    Result := 1
  else if sType = 'W' then
    Result := 2
  else if sType = 'P' then
    Result := 3
  else
    Result := 1;
end;

function TDMPuppyTracker.ImportVaccManuLine(sLine: String): Boolean;
begin

  Result := True;

  try
    with cdsVaccManu do
    begin
      Append;
      FieldByName('Manu_Code').Value    := ParseFieldData(sLine, 'Man_Code');
      FieldByName('Manufacturer').Value := ParseFieldData(sLine, 'Manufacturer');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ImportDefectsLine(sLine: String): Boolean;
begin

  Result := True;

  try
    with cdsDefects do
    begin
      Append;
      FieldByName('Defect_Code').Value        := ParseFieldData(sLine, 'Defect_Code');
      FieldByName('defect_description').Value := ParseFieldData(sLine, 'defect_description');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

function TDMPuppyTracker.ImportPedigreesLine(sLine: String): Boolean;
begin
  Result := True;

  try
    with cdsPedigrees do
    begin
      Append;
      FieldByName('registrycode').Value := ParseFieldData(sLine, 'registrycode');
      FieldByName('dog_name').Value     := ParseFieldData(sLine, 'dog_name');
      FieldByName('sire_name').Value    := ParseFieldData(sLine, 'sire_name');
      FieldByName('dam_name').Value     := ParseFieldData(sLine, 'dam_name');
      FieldByName('akc_registry').Value := ParseFieldData(sLine, 'akc_registry');
      Post;
    end;
  except
    raise;
    Result := False;
  end;

end;

end.
