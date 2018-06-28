unit uRDMLookUpSO;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, mrConfigLookupSvr, Provider, DB, ADODB;

type
  TRDMLookUpSO = class(TRemoteDataModule, IRDMLookUpSO)
    quLuSOCustomerProduct: TADOQuery;
    dspLuSOCustomerProduct: TDataSetProvider;
    clLuSOCustomerProduct: TmrConfigLookupSvr;
    quLuSOStatus: TADOQuery;
    dspLuSOStatus: TDataSetProvider;
    clLuSOStatus: TmrConfigLookupSvr;
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
  RDMLookUpSO: TRDMLookUpSO;
  RDMLookUpSOFactory: TComponentFactory;

implementation

{$R *.DFM}

class procedure TRDMLookUpSO.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMLookUpSO.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMLookUpSO.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMLookUpSO.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

initialization
  RDMLookUpSOFactory := TComponentFactory.Create(ComServer, TRDMLookUpSO,
    Class_RDMLookUpSO, ciInternal, tmApartment);
    
end.
