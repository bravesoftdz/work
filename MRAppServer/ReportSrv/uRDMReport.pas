unit uRDMReport;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, Provider, DB, mrConfigTable;

type
  TRDMReport = class(TRemoteDataModule, IRDMReport)
    qryPet: TADOQuery;
    dspPet: TDataSetProvider;
    ctPet: TmrConfigTable;
    ADOConnection: TADOConnection;
    qryPetIDPet: TIntegerField;
    qryPetIDSpecies: TIntegerField;
    qryPetIDPorte: TIntegerField;
    qryPetIDBreed: TIntegerField;
    qryPetIDStatus: TIntegerField;
    qryPetIDBreeder: TIntegerField;
    qryPetIDModel: TIntegerField;
    qryPetName: TStringField;
    qryPetSex: TStringField;
    qryPetColor: TStringField;
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
    qryPetSpecies: TStringField;
    qryPetBreed: TStringField;
    qryPetStatusCode: TStringField;
    qryPetStatus: TStringField;
    qryPetBreeder: TStringField;
    qryPetTreatment: TADOQuery;
    dspPetTreatment: TDataSetProvider;
    ctPetTreatment: TmrConfigTable;
    qryPetTreatmentTreatmentType: TIntegerField;
    qryPetTreatmentTreatment: TStringField;
    qryPetTreatmentMfg: TStringField;
    qryPetTreatmentLotNumber: TStringField;
    qryPetTreatmentTreatmentTypeStr: TStringField;
    qryPetTreatmentTreatmentDate: TDateTimeField;
    dspPetMicrochip: TDataSetProvider;
    qryPetMicrochip: TADOQuery;
    qryPetMicrochipIDMicrochip: TIntegerField;
    qryPetMicrochipIDPet: TIntegerField;
    qryPetMicrochipMicrochip: TStringField;
    qryPetMicrochipMicrochipNum: TStringField;
    ctPetMicrochip: TmrConfigTable;
    dspPetRegistry: TDataSetProvider;
    qryPetRegistry: TADOQuery;
    qryPetRegistryIDRegistry: TIntegerField;
    qryPetRegistryIDPet: TIntegerField;
    qryPetRegistryRegistrationNum: TStringField;
    qryPetRegistryRegistry: TStringField;
    qryPetRegistrySKU: TStringField;
    ctPetRegistry: TmrConfigTable;
    qryPetIDWarrantyReport: TIntegerField;
    qryPetWarrantyCustomerName: TStringField;
    qryPetWCustomerFirstName: TStringField;
    qryPetWCustomerLastName: TStringField;
    qryPetWCustomerAddress: TStringField;
    qryPetWCustomerCity: TStringField;
    qryPetWCustomerStateID: TStringField;
    qryPetWCustomerZip: TStringField;
    qryPetWCustomerPhone: TStringField;
    qryPetWCustomerEmail: TStringField;
    qryPetPetSaleDate: TDateTimeField;
    qryPetPetSaleCost: TBCDField;
    qryPetPetSaleSold: TBCDField;
    qryPetPetSaleDiscount: TBCDField;
    qryPetSaleCustomerName: TStringField;
    qryPetMicrochipIDPetSale: TIntegerField;
    qryPetRegistryIDPetSale: TIntegerField;
    qryPetBreederAddress: TStringField;
    qryPetBreederCity: TStringField;
    qryPetBreederStateID: TStringField;
    qryPetBreederZip: TStringField;
    qryEmptyPet: TADOQuery;
    dspEmptyPet: TDataSetProvider;
    ctEmptyPet: TmrConfigTable;
    qryPetWSalePhoneAreaCode: TStringField;
    qryEmptyPetIDPet: TIntegerField;
    qryEmptyPetIDSpecies: TIntegerField;
    qryEmptyPetIDPorte: TIntegerField;
    qryEmptyPetIDBreed: TIntegerField;
    qryEmptyPetIDStatus: TIntegerField;
    qryEmptyPetIDBreeder: TIntegerField;
    qryEmptyPetIDModel: TIntegerField;
    qryEmptyPetName: TStringField;
    qryEmptyPetSex: TStringField;
    qryEmptyPetColor: TStringField;
    qryEmptyPetSKU: TStringField;
    qryEmptyPetPenNum: TStringField;
    qryEmptyPetVendorCost: TBCDField;
    qryEmptyPetMSRP: TBCDField;
    qryEmptyPetSalePrice: TBCDField;
    qryEmptyPetPromoPrice: TBCDField;
    qryEmptyPetUSDA: TStringField;
    qryEmptyPetCollar: TStringField;
    qryEmptyPetSire: TStringField;
    qryEmptyPetDam: TStringField;
    qryEmptyPetWhelpDate: TDateTimeField;
    qryEmptyPetPurchaseDate: TDateTimeField;
    qryEmptyPetNotes: TStringField;
    qryEmptyPetSpecies: TStringField;
    qryEmptyPetBreed: TStringField;
    qryEmptyPetStatusCode: TStringField;
    qryEmptyPetStatus: TStringField;
    qryEmptyPetBreeder: TStringField;
    qryEmptyPetBreederAddress: TStringField;
    qryEmptyPetBreederCity: TStringField;
    qryEmptyPetBreederStateID: TStringField;
    qryEmptyPetBreederZip: TStringField;
    qryEmptyPetIDWarrantyReport: TIntegerField;
    qryEmptyPetWarrantyCustomerName: TStringField;
    qryEmptyPetWCustomerFirstName: TStringField;
    qryEmptyPetWCustomerLastName: TStringField;
    qryEmptyPetWCustomerAddress: TStringField;
    qryEmptyPetWCustomerCity: TStringField;
    qryEmptyPetWCustomerStateID: TStringField;
    qryEmptyPetWCustomerZip: TStringField;
    qryEmptyPetWCustomerPhone: TStringField;
    qryEmptyPetWCustomerEmail: TStringField;
    qryEmptyPetPetSaleDate: TDateTimeField;
    qryEmptyPetPetSaleCost: TBCDField;
    qryEmptyPetPetSaleSold: TBCDField;
    qryEmptyPetPetSaleDiscount: TBCDField;
    qryEmptyPetSaleCustomerName: TStringField;
    qryEmptyPetWSalePhoneAreaCode: TStringField;
    qryPetIDStore: TIntegerField;
    qryPetStoreName: TStringField;
    qryPetStoreState: TStringField;
    qryPetStoreAddress: TStringField;
    qryPetStoreCity: TStringField;
    qryPetStoreZip: TStringField;
    qryPetStorePhone: TStringField;
    qryPetStoreFax: TStringField;
    qryPetStoreEmail: TStringField;
    qryPetStoreWebPage: TStringField;
    qryEmptyPetIDStore: TIntegerField;
    qryEmptyPetStoreName: TStringField;
    qryEmptyPetStoreState: TStringField;
    qryEmptyPetStoreAddress: TStringField;
    qryEmptyPetStoreCity: TStringField;
    qryEmptyPetStoreZip: TStringField;
    qryEmptyPetStorePhone: TStringField;
    qryEmptyPetStoreFax: TStringField;
    qryEmptyPetStoreEmail: TStringField;
    qryEmptyPetStoreWebPage: TStringField;
    procedure qryPetTreatmentCalcFields(DataSet: TDataSet);
  private
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
  public
    { Public declarations }
  end;

var
  RDMReport: TRDMReport;
  RDMReportFactory: TComponentFactory;

implementation

{$R *.DFM}

class procedure TRDMReport.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMReport.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMReport.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMReport.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

procedure TRDMReport.qryPetTreatmentCalcFields(DataSet: TDataSet);
begin
  case qryPetTreatment.FieldByName('TreatmentType').AsInteger of
    1 : qryPetTreatment.FieldByName('TreatmentTypeStr').AsString := 'Vaccine';
    2 : qryPetTreatment.FieldByName('TreatmentTypeStr').AsString := 'Wormer';
    3 : qryPetTreatment.FieldByName('TreatmentTypeStr').AsString := 'Preventative';
  end;
end;

initialization
  RDMReportFactory := TComponentFactory.Create(ComServer, TRDMReport,
    Class_RDMReport, ciInternal, tmApartment);
end.
