unit uRDMLookUpPet;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigLookupSvr;

type
  TRDMLookUpPet = class(TRemoteDataModule, IRDMLookUpPet)
    clLuPetBreed: TmrConfigLookupSvr;
    dspLuPetBreed: TDataSetProvider;
    quLuPetBreed: TADOQuery;
    clLuPetStatus: TmrConfigLookupSvr;
    dspLuPetStatus: TDataSetProvider;
    quLuPetStatus: TADOQuery;
    ctLuPetRegistry: TmrConfigLookupSvr;
    dspLuPetRegistry: TDataSetProvider;
    quLuPetRegistry: TADOQuery;
    ctLuPetMicrochip: TmrConfigLookupSvr;
    dspLuPetMicrochip: TDataSetProvider;
    quLuPetMicrochip: TADOQuery;
    ctLuPetSpecies: TmrConfigLookupSvr;
    dspLuPetSpecies: TDataSetProvider;
    quLuPetSpecies: TADOQuery;
    ctLuPetTreatmentLot: TmrConfigLookupSvr;
    dspLuPetTreatmentLot: TDataSetProvider;
    quLuPetTreatmentLot: TADOQuery;
    ctLuPetTreatment: TmrConfigLookupSvr;
    dspLuPetTreatment: TDataSetProvider;
    quLuPetTreatment: TADOQuery;
    ctLuPet: TmrConfigLookupSvr;
    dspLuPet: TDataSetProvider;
    qryLuPet: TADOQuery;
    ctLuPetMedicalCondition: TmrConfigLookupSvr;
    dspLuPetMedicalCondition: TDataSetProvider;
    quLuPetMedicalCondition: TADOQuery;
    ctLuPetColor: TmrConfigLookupSvr;
    dspLuPetColor: TDataSetProvider;
    qryLuPetColor: TADOQuery;
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
  RDMLookUpPet: TRDMLookUpPet;
  RDMLookUpPetFactory: TComponentFactory;

implementation

{$R *.DFM}

class procedure TRDMLookUpPet.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMLookUpPet.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMLookUpPet.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMLookUpPet.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

initialization
  RDMLookUpPetFactory := TComponentFactory.Create(ComServer, TRDMLookUpPet,
    Class_RDMLookUpPet, ciInternal, tmApartment);
end.
