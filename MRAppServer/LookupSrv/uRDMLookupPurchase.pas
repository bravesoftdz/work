unit uRDMLookupPurchase;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider;

type
  TRDMLookupPurchase = class(TRemoteDataModule, IRDMLookupPurchase)
    dspLuVendor: TDataSetProvider;
    quLuVendor: TADOQuery;
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
  RDMLookupPurchase: TRDMLookupPurchase;
  RDMLookupPurchaseFactory: TComponentFactory;

implementation

{$R *.DFM}

class procedure TRDMLookupPurchase.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMLookupPurchase.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMLookupPurchase.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMLookupPurchase.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

initialization
  RDMLookupPurchaseFactory := TComponentFactory.Create(ComServer, TRDMLookupPurchase,
    Class_RDMLookupPurchase, ciInternal, tmApartment);
end.
