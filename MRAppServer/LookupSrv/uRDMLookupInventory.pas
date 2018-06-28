unit uRDMLookupInventory;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigLookupSvr,
  mrConfigLookupCli;

type
  TRDMLookupInventory = class(TRemoteDataModule, IRDMLookupInventory)
    dspLuManufacturer: TDataSetProvider;
    quLuManufacturer: TADOQuery;
    quLuModel: TADOQuery;
    dspLuModel: TDataSetProvider;
    quLuColor: TADOQuery;
    quLuSize: TADOQuery;
    dspLuColor: TDataSetProvider;
    dspLuSize: TDataSetProvider;
    quLuCategory: TADOQuery;
    dspLuCategory: TDataSetProvider;
    dspLuGroup: TDataSetProvider;
    dspLuSubCategory: TDataSetProvider;
    quLuGroup: TADOQuery;
    quLuSubCategory: TADOQuery;
    clCaterory: TmrConfigLookupSvr;
    quLuDefectType: TADOQuery;
    dspLuDefectType: TDataSetProvider;
    clLuDefectType: TmrConfigLookupSvr;
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
  RDMLookupInventory: TRDMLookupInventory;
  RDMLookupInventoryFactory: TComponentFactory;

implementation

{$R *.DFM}

class procedure TRDMLookupInventory.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMLookupInventory.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMLookupInventory.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMLookupInventory.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

initialization
  RDMLookupInventoryFactory := TComponentFactory.Create(ComServer, TRDMLookupInventory,
    Class_RDMLookupInventory, ciInternal, tmApartment);
end.
