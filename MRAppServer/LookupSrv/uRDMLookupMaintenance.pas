unit uRDMLookupMaintenance;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigLookupSvr;

type
  TRDMLookupMaintenance = class(TRemoteDataModule, IRDMLookupMaintenance)
    dspLuStore: TDataSetProvider;
    quLuStore: TADOQuery;
    quLuCustomer: TADOQuery;
    dspLuCustomer: TDataSetProvider;
    quLuTaxCategory: TADOQuery;
    dspLuTaxCategory: TDataSetProvider;
    dspLuUser: TDataSetProvider;
    quLuUser: TADOQuery;
    quLuCashRegister: TADOQuery;
    dspLuCashRegister: TDataSetProvider;
    dspLuMedia: TDataSetProvider;
    quLuMedia: TADOQuery;
    quLuAgency: TADOQuery;
    dspLuAgency: TDataSetProvider;
    dspLuGuide: TDataSetProvider;
    quLuGuide: TADOQuery;
    quLuChartOfAccount: TADOQuery;
    dspLuChartOfAccount: TDataSetProvider;
    quLuDocumentType: TADOQuery;
    dspLuDocumentType: TDataSetProvider;
    quLuBank: TADOQuery;
    dspLuBank: TDataSetProvider;
    dspBankAccount: TDataSetProvider;
    quLuBankAccount: TADOQuery;
    quLuPaymentType: TADOQuery;
    dspPaymentType: TDataSetProvider;
    quLuState: TADOQuery;
    dspLuState: TDataSetProvider;
    quLuCountry: TADOQuery;
    dspLuCountry: TDataSetProvider;
    quLuEntityType: TADOQuery;
    dspLuEntityType: TDataSetProvider;
    clLuEntiryType: TmrConfigLookupSvr;
    clLuState: TmrConfigLookupSvr;
    clLuPais: TmrConfigLookupSvr;
    quLuManufacture: TADOQuery;
    dspManufacture: TDataSetProvider;
    clLuManufacture: TmrConfigLookupSvr;
    quLuSystemUser: TADOQuery;
    dspLuSystemUser: TDataSetProvider;
    clLuSystemUser: TmrConfigLookupSvr;
    clLuStore: TmrConfigLookupSvr;
    clCustomer: TmrConfigLookupSvr;
    quLuCommission: TADOQuery;
    dspLuCommission: TDataSetProvider;
    dspLuCompany: TDataSetProvider;
    quLuCompany: TADOQuery;
  private
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
  end;

var
  RDMLookupMaintenance: TRDMLookupMaintenance;
  RDMLookupMaintenanceFactory: TComponentFactory;

implementation

{$R *.DFM}

class procedure TRDMLookupMaintenance.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMLookupMaintenance.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMLookupMaintenance.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMLookupMaintenance.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

initialization
  RDMLookupMaintenanceFactory := TComponentFactory.Create(ComServer, TRDMLookupMaintenance,
    Class_RDMLookupMaintenance, ciInternal, tmApartment);
end.
