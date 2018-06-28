unit uRDMPetCenter;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, DB, ADODB, mrConfigTable, Provider,
  uContentClasses, uDMGlobal, uPetClasses, uMRSQLParam;

type
  TRDMPetCenter = class(TRemoteDataModule, IRDMPetCenter)
    ADOConnection: TADOConnection;
    qryMicrochip: TADOQuery;
    dspMicrochip: TDataSetProvider;
    ctMicrochip: TmrConfigTable;
    qryMicrochipIDMicrochip: TIntegerField;
    qryMicrochipMicrochip: TStringField;
    qryMicrochipAmount: TBCDField;
    qryMicrochipSystem: TBooleanField;
    qryMicrochipHidden: TBooleanField;
    qryMicrochipDesativado: TBooleanField;
    qryTreatment: TADOQuery;
    qryTreatmentIDTreatment: TIntegerField;
    qryTreatmentTreatment: TStringField;
    qryTreatmentTreatmentType: TIntegerField;
    qryTreatmentSystem: TBooleanField;
    qryTreatmentHidden: TBooleanField;
    qryTreatmentDesativado: TBooleanField;
    dspTreatment: TDataSetProvider;
    ctTreatment: TmrConfigTable;
    qryTreatmentTreatmentTypeStr: TStringField;
    qryMedicalCondition: TADOQuery;
    qryMedicalConditionIDMedicalCondition: TIntegerField;
    qryMedicalConditionMedicalCondition: TStringField;
    qryMedicalConditionSystem: TBooleanField;
    qryMedicalConditionHidden: TBooleanField;
    qryMedicalConditionDesativado: TBooleanField;
    dspMedicalCondition: TDataSetProvider;
    ctMedicalCondition: TmrConfigTable;
    qryBreed: TADOQuery;
    qryBreedIDBreed: TIntegerField;
    qryBreedBreed: TStringField;
    qryBreedSystem: TBooleanField;
    qryBreedHidden: TBooleanField;
    qryBreedDesativado: TBooleanField;
    dspBreed: TDataSetProvider;
    ctBreed: TmrConfigTable;
    qryRegistry: TADOQuery;
    qryRegistryIDRegistry: TIntegerField;
    qryRegistryRegistry: TStringField;
    qryRegistrySystem: TBooleanField;
    qryRegistryHidden: TBooleanField;
    qryRegistryDesativado: TBooleanField;
    dspRegistry: TDataSetProvider;
    ctRegistry: TmrConfigTable;
    qryPetStatus: TADOQuery;
    dspPetStatus: TDataSetProvider;
    qryPetStatusIDStatus: TIntegerField;
    qryPetStatusStatusCode: TStringField;
    qryPetStatusStatus: TStringField;
    qryPetStatusSystem: TBooleanField;
    qryPetStatusHidden: TBooleanField;
    qryPetStatusDesativado: TBooleanField;
    ctPetStatus: TmrConfigTable;
    qryPet: TADOQuery;
    dspPet: TDataSetProvider;
    ctPet: TmrConfigTable;
    qryPetIDPet: TIntegerField;
    qryPetIDSpecies: TIntegerField;
    qryPetIDPorte: TIntegerField;
    qryPetIDBreed: TIntegerField;
    qryPetIDStatus: TIntegerField;
    qryPetIDBreeder: TIntegerField;
    qryPetName: TStringField;
    qryPetSex: TStringField;
    qryPetSKU: TStringField;
    qryPetPenNum: TStringField;
    qryPetVendorCost: TBCDField;
    qryPetMSRP: TBCDField;
    qryPetSalePrice: TBCDField;
    qryPetPromoPrice: TBCDField;
    qryPetUSDA: TStringField;
    qryPetCollar: TStringField;
    qryPetSire: TStringField;
    qryPetDam: TStringField;
    qryPetWhelpDate: TDateTimeField;
    qryPetPurchaseDate: TDateTimeField;
    qryPetNotes: TStringField;
    qryPetSystem: TBooleanField;
    qryPetHidden: TBooleanField;
    qryPetDesativado: TBooleanField;
    qryPetSpecies: TStringField;
    qryPetPorte: TStringField;
    qryPetBreed: TStringField;
    qryPetStatusCode: TStringField;
    qryPetStatus2: TStringField;
    qryPetPessoa: TStringField;
    qryPetTelefone: TStringField;
    qryPetRegistry: TADOQuery;
    dspPetRegistry: TDataSetProvider;
    ctPetRegistry: TmrConfigTable;
    qryPetRegistryIDRegistry: TIntegerField;
    qryPetRegistryIDPet: TIntegerField;
    qryPetRegistryRegistrationNum: TStringField;
    qryPetRegistryRegistry: TStringField;
    qryPetRegistrySKU: TStringField;
    qryPetMicrochip: TADOQuery;
    dspPetMicrochip: TDataSetProvider;
    ctPetMicrochip: TmrConfigTable;
    qryPetMicrochipIDMicrochip: TIntegerField;
    qryPetMicrochipIDPet: TIntegerField;
    qryPetMicrochipMicrochipNum: TStringField;
    qryPetMicrochipMicrochip: TStringField;
    qryPetWeight: TADOQuery;
    dspPetWeight: TDataSetProvider;
    ctPetWeight: TmrConfigTable;
    qryPetWeightIDWeight: TIntegerField;
    qryPetWeightIDPet: TIntegerField;
    qryPetWeightEntryDate: TDateTimeField;
    qryPetWeightWeight: TBCDField;
    qrySpecies: TADOQuery;
    dspSpecies: TDataSetProvider;
    ctSpecies: TmrConfigTable;
    qrySpeciesIDSpecies: TIntegerField;
    qrySpeciesSpecies: TStringField;
    qrySpeciesSystem: TBooleanField;
    qrySpeciesHidden: TBooleanField;
    qrySpeciesDesativado: TBooleanField;
    qryMedicalConditionSpecies: TADOQuery;
    dspMedicalConditionSpecies: TDataSetProvider;
    ctMedicalConditionSpecies: TmrConfigTable;
    qryMedicalConditionSpeciesIDMedicalCondition: TIntegerField;
    qryMedicalConditionSpeciesIDSpecies: TIntegerField;
    qryMedicalConditionSpeciesSpecies: TStringField;
    qryMedicalConditionSubMedicalCondition: TStringField;
    qryTreatmentSpecies: TADOQuery;
    dspTreatmentSpecies: TDataSetProvider;
    ctTreatmentSpecies: TmrConfigTable;
    qryTreatmentSpeciesIDTreatment: TIntegerField;
    qryTreatmentSpeciesIDSpecies: TIntegerField;
    qryTreatmentSpeciesSpecies: TStringField;
    qryTreatmentMfg: TStringField;
    qryTreatmentTreatmentLotSize: TIntegerField;
    qryRegistrySpecies: TADOQuery;
    dspRegistrySpecies: TDataSetProvider;
    ctRegistrySpecies: TmrConfigTable;
    qryRegistrySpeciesIDRegistry: TIntegerField;
    qryRegistrySpeciesIDSpecies: TIntegerField;
    qryRegistrySpeciesSpecies: TStringField;
    qryTreatmentLot: TADOQuery;
    dspTreatmentLot: TDataSetProvider;
    ctTreatmentLot: TmrConfigTable;
    qryTreatmentLotIDTreatmentLot: TIntegerField;
    qryTreatmentLotIDTreatment: TIntegerField;
    qryTreatmentLotLotNumber: TStringField;
    qryTreatmentLotExpirationDate: TDateTimeField;
    qryTreatmentLotTreatment: TStringField;
    qryTreatmentLotSystem: TBooleanField;
    qryTreatmentLotHidden: TBooleanField;
    qryTreatmentLotDesativado: TBooleanField;
    qryPetTreatment: TADOQuery;
    dspPetTreatment: TDataSetProvider;
    ctPetTreatment: TmrConfigTable;
    qryPetTreatmentIDPetTreatment: TIntegerField;
    qryPetTreatmentIDTreatment: TIntegerField;
    qryPetTreatmentIDTreatmentLot: TIntegerField;
    qryPetTreatmentIDPet: TIntegerField;
    qryPetTreatmentIDUser: TIntegerField;
    qryPetTreatmentExpirationDate: TDateTimeField;
    qryPetTreatmentDosesUsed: TIntegerField;
    qryPetTreatmentTreatmentDate: TDateTimeField;
    qryPetTreatmentNotes: TStringField;
    qryPetTreatmentTreatment: TStringField;
    qryPetTreatmentSKU: TStringField;
    qryPetTreatmentSystemUser: TStringField;
    qryPetTreatmentLotNumber: TStringField;
    qryPetMedicalCondition: TADOQuery;
    dspPetMedicalCondition: TDataSetProvider;
    ctPetMedicalCondition: TmrConfigTable;
    qryPetMedicalConditionIDPetMedicalCondition: TIntegerField;
    qryPetMedicalConditionIDMedicalCondition: TIntegerField;
    qryPetMedicalConditionIDPet: TIntegerField;
    qryPetMedicalConditionIDUser: TIntegerField;
    qryPetMedicalConditionRecordDate: TDateTimeField;
    qryPetMedicalConditionNotes: TStringField;
    qryPetMedicalConditionSKU: TStringField;
    qryPetMedicalConditionSystemUser: TStringField;
    qryPetMedicalConditionMedicalCondition: TStringField;
    qryPetMedicalConditionSubMedicalCondition: TStringField;
    qryMicrochipIDModel: TIntegerField;
    qryPetIDModel: TIntegerField;
    qryWarrantyRep: TADOQuery;
    qryWarrantyRepIDWarrantyReport: TIntegerField;
    qryWarrantyRepIDSpecies: TIntegerField;
    qryWarrantyRepReport: TBlobField;
    qryWarrantyRepReportDate: TDateTimeField;
    qryWarrantyRepReportName: TStringField;
    dspWarrantyRep: TDataSetProvider;
    ctWarrantyRep: TmrConfigTable;
    qryPetMicrochipAmount: TBCDField;
    qryPetMicrochipMarked: TBooleanField;
    qryPetMicrochipIDModel: TIntegerField;
    qryPetColor: TADOQuery;
    dspPetColor: TDataSetProvider;
    ctPetColor: TmrConfigTable;
    qryPetColorIDColor: TIntegerField;
    qryPetColorColor: TStringField;
    qryPetColorSystem: TIntegerField;
    qryPetColorHidden: TBooleanField;
    qryPetColorDesativado: TBooleanField;
    qryPetColor2: TStringField;
    qryPetIDColor: TIntegerField;
    qryColorSpecies: TADOQuery;
    dspColorSpecies: TDataSetProvider;
    ctColorSpecies: TmrConfigTable;
    qryColorSpeciesIDColor: TIntegerField;
    qryColorSpeciesIDSpecies: TIntegerField;
    qryColorSpeciesSpecies: TStringField;
    qryPetIDStore: TIntegerField;
    qryPetStore: TStringField;
    qryPetTransfer: TADOQuery;
    dspPetTransfer: TDataSetProvider;
    ctPetTransfer: TmrConfigTable;
    qryPetTransferIDPetTransfer: TIntegerField;
    qryPetTransferIDPet: TIntegerField;
    qryPetTransferIDStoreSource: TIntegerField;
    qryPetTransferIDStoreDest: TIntegerField;
    qryPetTransferIDUser: TIntegerField;
    qryPetTransferTransferDate: TDateTimeField;
    qryPetTransferSKU: TStringField;
    qryPetTransferStoreSource: TStringField;
    qryPetTransferStoreDest: TStringField;
    qryPetTransferSystemUser: TStringField;
    qryPetTransferColor: TStringField;
    qryPetTransferSpecies: TStringField;
    qryPetTransferPorte: TStringField;
    qryPetTransferBreed: TStringField;
    qryPetTransferStatusCode: TStringField;
    qryPetTransferStatus: TStringField;
    procedure qryTreatmentCalcFields(DataSet: TDataSet);
    procedure ctPetBeforeUpdateRecords(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure ctMicrochipBeforeUpdateRecords(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure ctWarrantyRepBeforeUpdateRecords(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure ctPetMicrochipBeforeUpdateRecords(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure ctPetBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure ctPetTransferBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure ctPetTransferBeforeUpdateRecords(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
  private
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
    function QueryResult(ASQL: String) : Boolean; overload;
    function QueryResult(ASQL: String; AField : String) : Variant; overload;
    function InsertMicrochip(ABarcode: TBarcode) : Boolean;
    function UpdateMicrochip(AIDModel: Integer; ASellingPrice : Currency) : Boolean;
    function CreateBarcode : TBarcode;
    function ImportPet(APetInfo : TPetInfo; AUpdateKind: TUpdateKind) : Integer;
    function GetPropertyDomain(AProperty: String): Variant;
    function ReturnFieldValue(AField : TField) : Variant;
    function InsertPackModel(AIDPackModel, AIDModel : Integer; AQty : Double) : Boolean;
    function InsertMicrochipsInPack(AIDPackModel : Integer) : Boolean;
    function InsertPetSale(cdsPetSale : TClientDataSet) : Integer;
    function InsertMicrochipSale(AIDPetSale : Integer; cdsMicrochipSale, cdsPetSale : TClientDataSet) : Boolean;
    function InsertRegistrySale(AIDPetSale : Integer; cdsRegistrySale, cdsPetSale : TClientDataSet) : Boolean;
    function GetWarrantyReportID(AIDPet : Integer) : Integer;
    function GetPetInventoryMovmentID(cdsPetSale : TClientDataSet):Integer;
    function GetInventoryMicrochipKitID(IDPet : Integer):Integer;
    function DeleteInventoryMicrochip(IDPet: Integer; MicrochipNum : String):Boolean;
    function InsertInventoryMicrochip(IDPet : Integer; MicrochipNum : String):Boolean;
    function InsertPetMicrochip(IDPet : Integer; MicrochipNum : String):Boolean;
    function UpdatePetMicrochip(IDPet : Integer; MicrochipNum : String):Boolean;
    function GetIDPetList(sMicrochip : String) : WideString;
    function CanDeleteBarCode(IDPet: Integer;  MicrochipNum: String): boolean;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
    function PetRegistryExist(IDPet, IDRegistry: Integer): WordBool; safecall;
    function PetSKUExist(const SKU: WideString): WordBool; safecall;
    function PetInsertMicrochip(IDCategory: Integer; const Barcode, Model,
      Description: WideString; SalePrice: Currency;
      var MsgError: WideString): WordBool; safecall;
    function PetCreateSale(PetSale, MicrochipSale, RegistrySale: OleVariant;
      var MsgError: WideString; var IDPetSale: Integer): WordBool;
      safecall;
    function ValidatePetTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString;
      var APassed: WordBool): OleVariant; safecall;
    procedure ImportPetTextFile(AFile, ATreatment: OleVariant;
      const ALinkedColumns, AImportConfig: WideString;
      var AMsgLog: WideString); safecall;
    function MicrochipExist(const Microchip: WideString): WordBool; safecall;
  public
    { Public declarations }
  end;

var
  RDMPetCenter: TRDMPetCenter;
  RDMPetCenterFactory: TComponentFactory;

implementation

uses uObjectServices, Variants, uDMValidatePetTextFile, uDMImportPetTextFile;

{$R *.DFM}

procedure TRDMPetCenter.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

class procedure TRDMPetCenter.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TRDMPetCenter.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMPetCenter.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMPetCenter.qryTreatmentCalcFields(DataSet: TDataSet);
begin
  case qryTreatment.FieldByName('TreatmentType').AsInteger of
    1 : qryTreatment.FieldByName('TreatmentTypeStr').AsString := 'Vaccine';
    2 : qryTreatment.FieldByName('TreatmentTypeStr').AsString := 'Wormer';
    3 : qryTreatment.FieldByName('TreatmentTypeStr').AsString := 'Preventative';
  end;
end;

function TRDMPetCenter.PetRegistryExist(IDPet,
  IDRegistry: Integer): WordBool;
var
  sSQL : String;
begin
  sSQL := 'SELECT RegistrationNum FROM Pet_PetRegistry WHERE IDRegistry = ' + IntToStr(IDRegistry) +
          ' AND IDPet = ' + IntToStr(IDPet);
  Result := QueryResult(sSQL);
end;

function TRDMPetCenter.QueryResult(ASQL, AField: String): Variant;
var
  FQuery : TADOQuery;
begin
  Result := False;
  if ASQL <> '' then
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add(ASQL);
    FQuery.Open;
    Result := FQuery.FieldByName(AField).Value;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;


function TRDMPetCenter.QueryResult(ASQL: String): Boolean;
var
  FQuery : TADOQuery;
begin
  Result := False;
  if ASQL <> '' then
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add(ASQL);
    FQuery.Open;
    Result := not FQuery.IsEmpty;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TRDMPetCenter.PetSKUExist(const SKU: WideString): WordBool;
var
  sSQL : String;
begin

  Result := False;

  //Test no cadastro do Pet
  sSQL := 'SELECT SKU FROM Pet WHERE SKU = ' + QuotedStr(SKU);
  Result := QueryResult(sSQL);

  //Test no cadastro do Model
  if not Result then
  begin
    sSQL := 'SELECT Model FROM Model WHERE Model = ' + QuotedStr(SKU);
    Result := QueryResult(sSQL);
  end;

end;

function TRDMPetCenter.PetInsertMicrochip(IDCategory: Integer;
  const Barcode, Model, Description: WideString; SalePrice: Currency;
  var MsgError: WideString): WordBool;
var
  ABarcode : TBarcode;
  AMRBarcodeService : TMRBarcodeService;
  AMRModelService : TMRModelService;
begin

  ABarcode := CreateBarcode;
  try
    ABarcode.IDBarcode              := Barcode;
    ABarcode.Model.Category.IDGroup := IDCategory;
    ABarcode.Model.Model            := Model;
    ABarcode.Model.Description      := Description;
    ABarcode.Model.SellingPrice     := SalePrice;
    ABarcode.Model.ModelType        := 'R';
    ABarcode.Model.NotVerifyQty     := True;

    AMRBarcodeService := TMRBarcodeService.Create;
    AMRModelService := TMRModelService.Create;
    try
      AMRBarcodeService.SQLConnection := FSQLConnection;
      AMRModelService.SQLConnection := FSQLConnection;

      if AMRBarcodeService.Find(ABarcode) then
      begin
        MsgError := 'Barcode already exist!';
        Result := False;
        Exit;
      end;

      if AMRModelService.Find(ABarcode.Model) then
      begin
        MsgError := 'Model already exist!';
        Result := False;
        Exit;
      end;

      FSQLConnection.BeginTrans;
      try
        Result := AMRBarcodeService.Import(ABarcode);
        if not Result then
        begin
          MsgError := 'Error creating model!';
          Exit;
        end;

        Result := InsertMicrochip(ABarcode);
        if not Result then
          MsgError := 'Error creating microchip!';

      finally
        if Result then
          FSQLConnection.CommitTrans
        else
          FSQLConnection.RollbackTrans;
        end;
    finally
      FreeAndNil(AMRBarcodeService);
      FreeAndNil(AMRModelService);
    end;
  finally
    FreeAndNil(ABarcode);
  end;


end;

function TRDMPetCenter.CreateBarcode: TBarcode;
begin
  Result                       := TBarcode.Create;
  Result.Model                 := TModel.Create;
  Result.Model.Category        := TCategory.Create;
  Result.Model.Inventory       := TInventory.Create;
  Result.Model.InventorySerial := TInventorySerial.Create;
end;

function TRDMPetCenter.InsertMicrochip(ABarcode: TBarcode): Boolean;
var
  FCommand : TADOCommand;
begin
  FCommand := TADOCommand.Create(Self);
  try
    FCommand.Connection := FSQLConnection;
    FCommand.CommandText := 'INSERT Pet_Microchip (IDMicrochip, Microchip, Amount, IDModel) ' +
                            'VALUES (:IDMicrochip, :Microchip, :Amount, :IDModel) ';

    FCommand.Parameters.ParamByName('IDMicrochip').Value := DMGlobal.GetNextCode('Pet_Microchip', 'IDMicrochip', FSQLConnection);
    FCommand.Parameters.ParamByName('Microchip').Value   := ABarcode.Model.Description;
    FCommand.Parameters.ParamByName('Amount').Value      := ABarcode.Model.SellingPrice;
    FCommand.Parameters.ParamByName('IDModel').Value     := ABarcode.Model.IDModel;

    FCommand.Execute();
    Result := True;
  finally
    FreeAndNil(FCommand);
  end;
end;

function TRDMPetCenter.UpdateMicrochip(AIDModel: Integer; ASellingPrice : Currency): Boolean;
var
  FCommand : TADOCommand;
begin
  FCommand := TADOCommand.Create(Self);
  try
    FCommand.Connection := FSQLConnection;
    FCommand.CommandText := 'UPDATE Model Set SellingPrice = :SellingPrice ' +
                            'WHERE IDModel = :IDModel ';
    FCommand.Parameters.ParamByName('SellingPrice').Value := ASellingPrice;
    FCommand.Parameters.ParamByName('IDModel').Value      := AIDModel;
    FCommand.Execute();

    Result := True;
  finally
    FreeAndNil(FCommand);
  end;
end;

procedure TRDMPetCenter.ctMicrochipBeforeUpdateRecords(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  UpdateMicrochip(DeltaDS.FieldByName('IDModel').OldValue, DeltaDS.FieldByName('Amount').AsCurrency);
end;

procedure TRDMPetCenter.ctPetBeforeUpdateRecords(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  iIDModel, iID : Integer;
  oPetInfo : TPetInfo;
  sBreed   : String;
begin

  iID    := ReturnFieldValue(DeltaDS.FieldByName('IDBreed'));
  sBreed := QueryResult('SELECT Breed FROM Pet_Breed WHERE IDBreed = ' + IntToStr(iID), 'Breed');

  oPetInfo := TPetInfo.Create;
  try
    oPetInfo.FIDModel       := ReturnFieldValue(DeltaDS.FieldByName('IDModel'));
    oPetInfo.FModel         := sBreed + ReturnFieldValue(DeltaDS.FieldByName('Sex'));
    oPetInfo.FDescription   := sBreed + ' ' + ReturnFieldValue(DeltaDS.FieldByName('Sex'));
    oPetInfo.FSerial        := ReturnFieldValue(DeltaDS.FieldByName('SKU'));
    oPetInfo.FVendorCost    := ReturnFieldValue(DeltaDS.FieldByName('VendorCost'));
    oPetInfo.FSellingPrice  := ReturnFieldValue(DeltaDS.FieldByName('SalePrice'));
    oPetInfo.FIDCategory    := GetPropertyDomain('PctPetCategory');
    oPetInfo.FIDKitCategory := GetPropertyDomain('PctPetKitCategory');

    oPetInfo.FQty           := 1;

    iIDModel := ImportPet(oPetInfo, UpdateKind);
  finally
    FreeAndNil(oPetInfo);
    end;

  if iIDModel <> -1 then
  begin
    if UpdateKind = ukInsert then
    begin
      DeltaDS.Edit;
      DeltaDS.FieldByName('IDModel').AsInteger := iIDModel;
    end;
  end
  else
    Applied := True;
end;

function TRDMPetCenter.ImportPet(APetInfo : TPetInfo; AUpdateKind: TUpdateKind): Integer;
var
  ABarcode : TBarcode;
  AMRBarcodeService : TMRBarcodeService;
  AMRModelService : TMRModelService;

  bResult : Boolean;
  iIDStore, iIDPetModel : Integer;
begin

  bResult := False;
  iIDPetModel := -1;
  ABarcode := CreateBarcode;

  AMRBarcodeService := TMRBarcodeService.Create;
  AMRBarcodeService.SQLConnection := FSQLConnection;

  AMRModelService := TMRModelService.Create;
  AMRModelService.SQLConnection := FSQLConnection;

  try

    iIDStore := GetPropertyDomain('PctDefaultStore');

    ABarcode.Model.VendorCost       := APetInfo.FVendorCost;
    ABarcode.Model.SellingPrice     := APetInfo.FSellingPrice;
    try
      if AUpdateKind = ukInsert then
      begin
        //Model Pet
        ABarcode.Model.Category.IDGroup := APetInfo.FIDCategory;
        ABarcode.Model.Model            := APetInfo.FModel;
        ABarcode.Model.Description      := APetInfo.FDescription;
        ABarcode.Model.ModelType        := 'R';
        ABarcode.Model.NotVerifyQty     := True;

        ABarcode.Model.Inventory.IDStore   := iIDStore;
        ABarcode.Model.Inventory.IDUser    := 0; //Verificar
        ABarcode.Model.Inventory.QtyOnHand := 1;
        ABarcode.Model.Inventory.UpdateQty := True;

        ABarcode.Model.InventorySerial.StoreID := iIDStore;
        ABarcode.Model.InventorySerial.Serial  := APetInfo.FSerial;

        bResult := AMRBarcodeService.Import(ABarcode);
        iIDPetModel := ABarcode.Model.IDModel;

        //Kit Pet
        if bResult then
        begin
          ABarcode.Model.Category.IDGroup := APetInfo.FIDKitCategory;
          ABarcode.Model.Model            := 'K' + APetInfo.FModel;
          ABarcode.Model.Description      := 'K' + APetInfo.FDescription;
          ABarcode.Model.ModelType        := 'K';
          ABarcode.Model.IDModel          := Null;
          ABarcode.Model.NotVerifyQty     := True;

          ABarcode.Model.InventorySerial.StoreID := Null;
          ABarcode.Model.InventorySerial.Serial  := '';
          bResult := AMRBarcodeService.Import(ABarcode);

          if bResult then
          begin
            bResult := InsertPackModel(ABarcode.Model.IDModel, iIDPetModel, 1);
            if bResult then
              bResult := InsertMicrochipsInPack(ABarcode.Model.IDModel);
          end;
        end;

      end
      else if (AUpdateKind = ukModify) then
      begin
        iIDPetModel := APetInfo.FIDModel;
        ABarcode.Model.IDModel := iIDPetModel;
        bResult := AMRModelService.UpdatePrices(ABarcode.Model);
      end;

    finally
      if bResult then
        Result := iIDPetModel
      else
        Result := -1;
    end;

  finally
    FreeAndNil(ABarcode);
    FreeAndNil(AMRBarcodeService);
    FreeAndNil(AMRModelService);
    end;

end;


function TRDMPetCenter.GetPropertyDomain(AProperty: String): Variant;
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

function TRDMPetCenter.ReturnFieldValue(AField: TField): Variant;
begin

  if AField.Value = Null then
    Result := AField.OldValue
  else
    Result := AField.NewValue;

  if Result = Null then
    if (AField is TIntegerField) then
      Result := 0
    else if (AField is TStringField) then
      Result := ''
    else if (AField is TBCDField) then
      Result := 0
    else if (AField is TCurrencyField) then
      Result := 0
    else if (AField is TFloatField) then
      Result := 0
    else if (AField is TDateTimeField) then
      Result := 0;
end;


function TRDMPetCenter.InsertPackModel(AIDPackModel, AIDModel: Integer;
  AQty: Double): Boolean;
var
  MRPackModelService : TMRPackModelService;
  PackModel : TPackModel;
begin
  MRPackModelService := TMRPackModelService.Create;
  PackModel := TPackModel.Create;
  try
    MRPackModelService.SQLConnection := FSQLConnection;

    PackModel.IDPackModel := AIDPackModel;
    PackModel.IDModel := AIDModel;
    PackModel.Qty := AQty;
    Result := MRPackModelService.Import(PackModel);

    //Loop nos microchips
  finally
    FreeAndNil(PackModel);
    FreeAndNil(MRPackModelService);
  end;
end;

function TRDMPetCenter.InsertMicrochipsInPack(AIDPackModel : Integer): Boolean;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add('SELECT IDModel ');
    FQuery.SQL.Add('FROM Pet_Microchip ');
    FQuery.Open;
    while not FQuery.Eof do
    begin
      if FQuery.FieldByName('IDModel').AsInteger <> 0 then
        InsertPackModel(AIDPackModel, FQuery.FieldByName('IDModel').AsInteger, 1);
      FQuery.Next;
    end;
    Result := True;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

procedure TRDMPetCenter.ctWarrantyRepBeforeUpdateRecords(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  FCommand : TADOCommand;
  buf : TMemoryStream;
begin
  if UpdateKind = ukInsert then
  begin
    DeltaDS.Edit;
    DeltaDS.FieldByName('IDWarrantyReport').AsInteger := DMGlobal.GetNextCode('Pet_WarrantyReport', 'IDWarrantyReport', FSQLConnection);
  end
  else
  begin
    FCommand := TADOCommand.Create(Self);
    buf := TMemoryStream.Create();
    try
      FCommand.Connection := FSQLConnection;
      FCommand.CommandText := 'INSERT Pet_WarrantyReport (IDWarrantyReport, IDSpecies, ReportName, ReportDate, Report) ' +
                              'VALUES (:IDWarrantyReport, :IDSpecies, :ReportName, :ReportDate, :Report) ';

      FCommand.Parameters.ParamByName('IDWarrantyReport').Value := DMGlobal.GetNextCode('Pet_WarrantyReport', 'IDWarrantyReport', FSQLConnection);
      FCommand.Parameters.ParamByName('IDSpecies').Value   := DeltaDS.FieldByName('IDSpecies').OldValue;
      FCommand.Parameters.ParamByName('ReportName').Value  := DeltaDS.FieldByName('ReportName').OldValue;
      FCommand.Parameters.ParamByName('ReportDate').Value  := Now;
      TBlobField(DeltaDS.FieldByName('Report')).SaveToStream(buf);
      buf.seek(0, soFromBeginning);
      FCommand.Parameters.ParamByName('Report').LoadFromStream(buf, ftBlob);
      FCommand.Execute();
    finally
      FreeAndNil(buf);
      FreeAndNil(FCommand);
      Applied := True;
    end;
  end;

end;

function TRDMPetCenter.PetCreateSale(PetSale, MicrochipSale,
  RegistrySale: OleVariant; var MsgError: WideString;
  var IDPetSale: Integer): WordBool;
var
  cdsPetSale : TClientDataSet;
  cdsWidget : TClientDataSet;
begin

  Result := False;
  cdsWidget := TClientDataSet.Create(Self);
  cdsPetSale := TClientDataSet.Create(Self);
  try
    FSQLConnection.BeginTrans;
    try
      cdsPetSale.Data := PetSale;
      IDPetSale := InsertPetSale(cdsPetSale);

      if IDPetSale <> -1 then
      begin
        cdsWidget.Data := MicrochipSale;
        InsertMicrochipSale(IDPetSale, cdsWidget, cdsPetSale);
        cdsWidget.Close;

        cdsWidget.Data := RegistrySale;
        InsertRegistrySale(IDPetSale, cdsWidget, cdsPetSale);
        cdsWidget.Close;
      end;
      Result := True;
      FSQLConnection.CommitTrans;
    except
      on E: Exception do
      begin
        FSQLConnection.RollbackTrans;
        MsgError := E.Message;
      end;
    end;
  finally
    cdsPetSale.Close;
    cdsWidget.Close;
    FreeAndNil(cdsPetSale);
    FreeAndNil(cdsWidget);
  end;

end;

function TRDMPetCenter.InsertPetSale(cdsPetSale: TClientDataSet): Integer;
var
  FCommand : TADOCommand;
  iIDPreInvMov : Integer;
  iIDStatus : Integer;
  iIDNewStatus : Integer;
begin

  FCommand := TADOCommand.Create(Self);
  try
    Result := -1;
    FCommand.Connection := FSQLConnection;
    //Inserir o item
    FCommand.CommandText := 'INSERT InventoryMov (IDInventoryMov, StoreID, ModelID, InventMovTypeID, IDPessoa, DocumentID, IDUser, PreInventoryMovID, MovDate, CostPrice, SalePrice, Discount, Qty) ' +
                            'VALUES (:IDInventoryMov, :StoreID, :ModelID, :InventMovTypeID, :IDPessoa, :DocumentID, :IDUser, :PreInventoryMovID, :MovDate, :CostPrice, :SalePrice, :Discount, :Qty) ';

    iIDPreInvMov := DMGlobal.GetNextCode('PreInventoryMov', 'IDPreInventoryMov', FSQLConnection);

    iIDStatus := cdsPetSale.FieldByName('IDStatus').Value;
    //if iIDStatus in [PET_STATUS_AVAILABLE, PET_STATUS_ONHOLD] then
    if not (iIDStatus in [PET_STATUS_SOLD]) then
      iIDNewStatus := PET_STATUS_SOLD
    else
      iIDNewStatus := PET_STATUS_AVAILABLE;

    FCommand.Parameters.ParamByName('IDInventoryMov').Value    := DMGlobal.GetNextCode('InventoryMov', 'IDInventoryMov', FSQLConnection);
    FCommand.Parameters.ParamByName('PreInventoryMovID').Value := iIDPreInvMov;
    FCommand.Parameters.ParamByName('StoreID').Value           := cdsPetSale.FieldByName('StoreID').Value;
    FCommand.Parameters.ParamByName('ModelID').Value           := cdsPetSale.FieldByName('ModelID').Value;
    FCommand.Parameters.ParamByName('InventMovTypeID').Value   := GetPetInventoryMovmentID(cdsPetSale);
    FCommand.Parameters.ParamByName('IDPessoa').Value          := cdsPetSale.FieldByName('IDPessoa').Value;
    FCommand.Parameters.ParamByName('DocumentID').Value        := 0;
    FCommand.Parameters.ParamByName('IDUser').Value            := cdsPetSale.FieldByName('IDUser').Value;
    FCommand.Parameters.ParamByName('MovDate').Value           := cdsPetSale.FieldByName('SaleDate').Value;
    FCommand.Parameters.ParamByName('CostPrice').Value         := cdsPetSale.FieldByName('CostPrice').Value;
    FCommand.Parameters.ParamByName('SalePrice').Value         := cdsPetSale.FieldByName('SalePrice').Value;
    FCommand.Parameters.ParamByName('Discount').Value          := cdsPetSale.FieldByName('Discount').Value;
    FCommand.Parameters.ParamByName('Qty').Value               := 1;
    FCommand.Execute();

    //Inserir o Pet
    FCommand.CommandText := 'INSERT Pet_PetSale (IDPetSale, IDPreInventoryMov, IDWarrantyReport, IDWarrantyCustomer, IDPet, InvoiceTotal) ' +
                            'VALUES (:IDPetSale, :IDPreInventoryMov, :IDWarrantyReport, :IDWarrantyCustomer, :IDPet, :InvoiceTotal) ';

    Result := DMGlobal.GetNextCode('Pet_PetSale', 'IDPetSale', FSQLConnection);
    FCommand.Parameters.ParamByName('IDPetSale').Value := Result;
    FCommand.Parameters.ParamByName('IDPreInventoryMov').Value  := iIDPreInvMov;
    FCommand.Parameters.ParamByName('IDWarrantyReport').Value   := GetWarrantyReportID(cdsPetSale.FieldByName('IDPet').Value);
    FCommand.Parameters.ParamByName('IDWarrantyCustomer').Value := cdsPetSale.FieldByName('IDWarrantyCustomer').Value;
    FCommand.Parameters.ParamByName('IDPet').Value              := cdsPetSale.FieldByName('IDPet').Value;
    FCommand.Parameters.ParamByName('InvoiceTotal').Value       := cdsPetSale.FieldByName('InvoiceTotal').Value;
    FCommand.Execute();

    //Atualiza o status do Pet
    //Inserir o Pet
    FCommand.CommandText := 'UPDATE Pet SET IDStatus = :IDStatus ' +
                            'WHERE IDPet = :IDPet';
    FCommand.Parameters.ParamByName('IDStatus').Value := iIDNewStatus;
    FCommand.Parameters.ParamByName('IDPet').Value := cdsPetSale.FieldByName('IDPet').Value;
    FCommand.Execute();

  finally
    FreeAndNil(FCommand);
  end;
end;

function TRDMPetCenter.InsertMicrochipSale(AIDPetSale : Integer;
  cdsMicrochipSale, cdsPetSale: TClientDataSet): Boolean;
var
  FCommand : TADOCommand;
  iIDPreInvMov : Integer;
begin

  FCommand := TADOCommand.Create(Self);
  try
    FCommand.Connection := FSQLConnection;
    cdsMicrochipSale.First;
    while not cdsMicrochipSale.Eof do
    begin

      if cdsMicrochipSale.FieldByName('Marked').AsBoolean then
      begin
        FCommand.CommandText := 'INSERT InventoryMov (IDInventoryMov, StoreID, ModelID, InventMovTypeID, IDPessoa, DocumentID, IDUser, PreInventoryMovID, MovDate, CostPrice, SalePrice, Discount, Qty, OtherCost) ' +
                                'VALUES (:IDInventoryMov, :StoreID, :ModelID, :InventMovTypeID, :IDPessoa, :DocumentID, :IDUser, :PreInventoryMovID, :MovDate, :CostPrice, :SalePrice, :Discount, :Qty, :OtherCost) ';

        iIDPreInvMov := DMGlobal.GetNextCode('PreInventoryMov', 'IDPreInventoryMov', FSQLConnection);
        FCommand.Parameters.ParamByName('IDInventoryMov').Value    := DMGlobal.GetNextCode('InventoryMov', 'IDInventoryMov', FSQLConnection);
        FCommand.Parameters.ParamByName('PreInventoryMovID').Value := iIDPreInvMov;
        FCommand.Parameters.ParamByName('StoreID').Value           := cdsPetSale.FieldByName('StoreID').Value;
        FCommand.Parameters.ParamByName('ModelID').Value           := cdsMicrochipSale.FieldByName('IDModel').Value;
        FCommand.Parameters.ParamByName('InventMovTypeID').Value   := GetPetInventoryMovmentID(cdsPetSale);
        FCommand.Parameters.ParamByName('IDPessoa').Value          := cdsPetSale.FieldByName('IDPessoa').Value;
        FCommand.Parameters.ParamByName('DocumentID').Value        := 0;
        FCommand.Parameters.ParamByName('IDUser').Value            := cdsPetSale.FieldByName('IDUser').Value;
        FCommand.Parameters.ParamByName('MovDate').Value           := cdsPetSale.FieldByName('SaleDate').Value;
        FCommand.Parameters.ParamByName('CostPrice').Value         := 0;
        FCommand.Parameters.ParamByName('SalePrice').Value         := cdsMicrochipSale.FieldByName('Amount').Value;
        FCommand.Parameters.ParamByName('Discount').Value          := 0;
        FCommand.Parameters.ParamByName('Qty').Value               := 1;
        FCommand.Parameters.ParamByName('OtherCost').Value         := 0;
        FCommand.Execute();

        FCommand.CommandText := 'INSERT Pet_MicrochipSale (IDPreInventoryMov, IDMicrochip, IDPetSale, MicrochipNum) ' +
                                'VALUES (:IDPreInventoryMov, :IDMicrochip, :IDPetSale, :MicrochipNum) ';

        FCommand.Parameters.ParamByName('IDPreInventoryMov').Value := iIDPreInvMov;
        FCommand.Parameters.ParamByName('IDMicrochip').Value       := cdsMicrochipSale.FieldByName('IDMicrochip').Value;
        FCommand.Parameters.ParamByName('IDPetSale').Value         := AIDPetSale;
        FCommand.Parameters.ParamByName('MicrochipNum').Value      := cdsMicrochipSale.FieldByName('MicrochipNum').Value;
        FCommand.Execute();
      end;

      cdsMicrochipSale.Next;
    end;
    Result := True;
  finally
    FreeAndNil(FCommand);
  end;


end;

function TRDMPetCenter.InsertRegistrySale(AIDPetSale : Integer;
  cdsRegistrySale, cdsPetSale: TClientDataSet): Boolean;
begin
  Result := True;
end;

function TRDMPetCenter.GetWarrantyReportID(AIDPet: Integer): Integer;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := FSQLConnection;
    FQuery.SQL.Add('SELECT TOP 1 PW.IDWarrantyReport');
    FQuery.SQL.Add('FROM Pet_WarrantyReport PW');
    FQuery.SQL.Add('JOIN Pet P ON (P.IDSpecies = PW.IDSpecies)');
    FQuery.SQL.Add('WHERE P.IDPet = :IDPet');
    FQuery.SQL.Add('ORDER BY IDWarrantyReport DESC');
    FQuery.Parameters.ParamByName('IDPet').Value := AIDPet;
    FQuery.Open;
    Result := FQuery.FieldByName('IDWarrantyReport').AsInteger;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TRDMPetCenter.GetPetInventoryMovmentID(cdsPetSale: TClientDataSet): Integer;
var
 iIDStatus : Integer;
begin
  iIDStatus := cdsPetSale.FieldByName('IDStatus').Value;

  if not (iIDStatus in [PET_STATUS_SOLD]) then
    Result := 3
  else
    Result := 4;

end;

function TRDMPetCenter.ValidatePetTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString; var AMsgLog: WideString;
  var APassed: WordBool): OleVariant;
begin

  with TDMValidatePetTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    APassed := Validate;
    Result := TextFile.Data;
  finally
    Free;
  end;

end;

procedure TRDMPetCenter.ImportPetTextFile(AFile, ATreatment: OleVariant;
  const ALinkedColumns, AImportConfig: WideString;
  var AMsgLog: WideString);
begin

  with TDMImportPetTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    cdsPetTreatment.Data := ATreatment;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    Import;
    AMsgLog := Log.Text;
  finally
    Free;
  end;

end;

procedure TRDMPetCenter.ctPetMicrochipBeforeUpdateRecords(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  iIDPet : Integer;
  sMicrochipNum : String;
begin

  iIDPet        := ReturnFieldValue(DeltaDS.FieldByName('IDPet'));
  sMicrochipNum := ReturnFieldValue(DeltaDS.FieldByName('MicrochipNum'));

  if UpdateKind = ukInsert then
  begin
    InsertInventoryMicrochip(iIDPet, sMicrochipNum);
    InsertPetMicrochip(iIDPet, sMicrochipNum);
    Applied := True;
  end
  else if UpdateKind = ukModify then
  begin
    //UpdatePetMicrochip(iIDPet, sMicrochipNum);
    //Applied := True;
  end
  else if UpdateKind = ukDelete then
    DeleteInventoryMicrochip(iIDPet, sMicrochipNum);

end;

function TRDMPetCenter.InsertInventoryMicrochip(IDPet: Integer;
  MicrochipNum: String): Boolean;
var
  FQuery: TADOQuery;
  AMRBarcodeService : TMRBarcodeService;
  ABarcode : TBarcode;
  iIDKitModel : Integer;
begin

  Result := True;

  iIDKitModel := GetInventoryMicrochipKitID(IDPet);

  if iIDKitModel <> -1 then
  begin
    FQuery := TADOQuery.Create(nil);
    try
      FQuery.Connection := FSQLConnection;
      FQuery.Close;
      FQuery.SQL.Clear;
      FQuery.SQL.Add('SELECT IDModel FROM Barcode WHERE IDBarcode = :IDBarcode');
      FQuery.Parameters.ParamByName('IDBarcode').Value := MicrochipNum;
      FQuery.Open;

      if FQuery.IsEmpty then
      try
        ABarcode := TBarcode.Create;
        ABarcode.Model := TModel.Create;
        try
          AMRBarcodeService := TMRBarcodeService.Create;
          AMRBarcodeService.SQLConnection := FSQLConnection;
          ABarcode.IDBarcode := MicrochipNum;
          ABarcode.Model.IDModel := iIDKitModel;
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
end;

function TRDMPetCenter.DeleteInventoryMicrochip(IDPet: Integer;
  MicrochipNum: String): Boolean;
var
  FQuery: TADOQuery;
  iIDKitModel : Integer;
  sql: String;
begin
  Result := False;
  FQuery := TADOQuery.Create(nil);

  iIDKitModel := GetInventoryMicrochipKitID(IDPet);

  if iIDKitModel <> -1 then
  begin
    if ( CanDeleteBarCode(IdPet, MicrochipNum) ) then
    begin
        try
          FQuery.Connection := FSQLConnection;
          FQuery.SQL.Add('DELETE Barcode WHERE IDBarcode = :IDBarcode AND IDModel = :IDModel');
          FQuery.Parameters.ParamByName('IDBarcode').Value := MicrochipNum;
          FQuery.Parameters.ParamByName('IDModel').Value := iIDKitModel;
          FQuery.ExecSQL;
          Result := True;
        finally
          FQuery.Close;
          FreeAndNil(FQuery);
        end;

    end;
  end;
end;

function TRDMPetCenter.GetInventoryMicrochipKitID(IDPet: Integer): Integer;
var
  FQuery: TADOQuery;
begin
  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := FSQLConnection;

    FQuery.SQL.Add('SELECT PL.IDPackModel FROM Pet P');
    FQuery.SQL.Add('JOIN PackModel PL (NOLOCK) ON (PL.IDModel = P.IDModel)');
    FQuery.SQL.Add('WHERE P.IDPet = :IDPet');
    FQuery.Parameters.ParamByName('IDPet').Value := IDPet;
    FQuery.Open;
    if FQuery.IsEmpty then
      Result := -1
    else
      Result := FQuery.FieldByName('IDPackModel').AsInteger;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

procedure TRDMPetCenter.ctPetBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sPetList: WideString;
  Where: TMRSQLParam;
begin


  Where := TMRSQLParam.Create;
  try
    Where.ParamString := OwnerData;

    if Where.KeyExists('MicrochipNum') then
    begin
      sPetList := '';

      sPetList := GetIDPetList(Where.KeyByName('MicrochipNum').AsSQL);
      Where.DeleteKey('MicrochipNum');
      if (sPetList <> '') then
        sPetList := ' P.IDPet IN (' + sPetList + ')'
      else
        sPetList := ' P.IDPet = -1';

      OwnerData := Where.GetWhereSQL + ' AND ' + sPetList;
    end
    else
      OwnerData := Where.GetWhereSQL;

  finally
    FreeAndNil(Where);
  end;


end;

function TRDMPetCenter.GetIDPetList(sMicrochip: String): WideString;
var
  FQuery: TADOQuery;
begin

  Result := '';

  FQuery := TADOQuery.Create(nil);
  try
    FQuery.Connection := FSQLConnection;

    FQuery.SQL.Add('SELECT P.IDPet');
    FQuery.SQL.Add('FROM Pet P');
    FQuery.SQL.Add('JOIN Pet_PetMicrochip PM ON (PM.IDPet = P.IDPet)');
    FQuery.SQL.Add('WHERE PM.' + sMicrochip);
    FQuery.SQL.Add('GROUP BY P.IDPet');
    FQuery.Open;
    FQuery.First;
    While not FQuery.EOF do
    begin
      Result := Result + FQuery.FieldByName('IDPet').AsString;
      FQuery.Next;
      if not FQuery.EOF then
        Result := Result + ',';
    end;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

function TRDMPetCenter.InsertPetMicrochip(IDPet: Integer;
  MicrochipNum: String): Boolean;
var
  FQuery : TADOQuery;
  FCommand : TADOCommand;
begin

  Result := False;

  FQuery := TADOQuery.Create(Self);
  try
    FCommand := TADOCommand.Create(Self);
    try
      FQuery.Connection := FSQLConnection;
      FCommand.Connection := FSQLConnection;

      FQuery.SQL.Add('SELECT IDMicrochip FROM Pet_Microchip');
      FQuery.SQL.Add('WHERE IDMicrochip NOT IN ');
      FQuery.SQL.Add('(SELECT IDMicrochip FROM Pet_PetMicrochip WHERE IDPet = :IDPet) ' );
      FQuery.SQL.Add('AND Desativado = 0');
      FQuery.Parameters.ParamByName('IDPet').Value := IDPet;
      FQuery.Open;
      FQuery.First;
      while not FQuery.Eof do
      begin
        FCommand.CommandText := 'INSERT Pet_PetMicrochip (IDMicrochip, IDPet, MicrochipNum)' +
                                'VALUES (:IDMicrochip, :IDPet, :MicrochipNum)';
        FCommand.Parameters.ParamByName('IDMicrochip').Value  := FQuery.FieldByName('IDMicrochip').AsInteger;
        FCommand.Parameters.ParamByName('IDPet').Value        := IDPet;
        FCommand.Parameters.ParamByName('MicrochipNum').Value := MicrochipNum;
        FCommand.Execute();
        FQuery.Next;
      end;

      Result := True;

    finally
      FreeAndNil(FCommand);
    end;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;

end;

function TRDMPetCenter.UpdatePetMicrochip(IDPet: Integer;
  MicrochipNum: String): Boolean;
begin
 //
end;

procedure TRDMPetCenter.ctPetTransferBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sPetList: WideString;
  Where: TMRSQLParam;
begin


  Where := TMRSQLParam.Create;
  try
    Where.ParamString := OwnerData;

    if Where.KeyExists('Desativado') then
    begin
      Where.DeleteKey('Desativado');
      OwnerData := Where.GetWhereSQL;
    end
    else
      OwnerData := Where.GetWhereSQL;

  finally
    FreeAndNil(Where);
  end;


end;

procedure TRDMPetCenter.ctPetTransferBeforeUpdateRecords(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  FCommand : TADOCommand;
begin

  FCommand := TADOCommand.Create(Self);

 try
    FCommand.Connection := FSQLConnection;

    FCommand.CommandText := 'UPDATE Pet SET IDStore = :IDStore ' +
                            'WHERE IDPet =  :IDPet';

    FCommand.Parameters.ParamByName('IDStore').Value := ReturnFieldValue(DeltaDS.FieldByName('IDStoreDest'));
    FCommand.Parameters.ParamByName('IDPet').Value   := ReturnFieldValue(DeltaDS.FieldByName('IDPet'));
    FCommand.Execute();
  finally
    FreeAndNil(FCommand);
  end;

end;

function TRDMPetCenter.MicrochipExist(
  const Microchip: WideString): WordBool;
var
  sSQL : String;
begin

  Result := False;

  sSQL := 'SELECT MicrochipNum FROM Pet_PetMicrochip WHERE MicrochipNum = ' + QuotedStr(Microchip);
  Result := QueryResult(sSQL);

end;

function TRDMPetCenter.CanDeleteBarCode(IDPet: Integer;
  MicrochipNum: String): boolean;
var
  FQueryCountBarCode: TADOQuery;
  sql: String;
begin
    result := false;
    try
      FQueryCountBarCode := TADOQuery.Create(nil);
      FQueryCountBarCode.Connection := FSQLConnection;

      sql:= 'SELECT count(pm.microchipnum) qtybarcode ' +
           'FROM ' +
           '   Pet_PetMicrochip PM ' +
           ' JOIN Pet_Microchip M ON (PM.IDMicrochip = M.IDMicrochip) ' +
           ' JOIN Pet P ON (PM.IDPet = P.IDPet)                       ' +
           '       join model md on m.idmodel = md.idmodel            ' +
           '       join barcode bc on md.idmodel = bc.idmodel         ' +
           'where pm.microchipnum = :microchip                        ' +
           '   and pm.idpet = :idpet ';
      FQueryCountBarCode.SQL.Text := sql;
      FQueryCountBarCode.Parameters.ParamByName('microchip').value := MicrochipNum;;
      FQueryCountBarCode.Parameters.ParamByName('idpet').value := Idpet;
      FQueryCountBarCode.Open;
      result := ( FQueryCountBarCode.FieldByName('qtyBarcode').asInteger = 0 ); // notice that not applyed ClientDataSet  upon  database yet.
    finally
       FreeAndNil(FQueryCountBarCode);
    end;
end;

initialization
  RDMPetCenterFactory := TComponentFactory.Create(ComServer, TRDMPetCenter,
    Class_RDMPetCenter, ciInternal, tmApartment);
end.

