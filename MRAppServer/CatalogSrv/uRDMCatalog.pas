unit uRDMCatalog;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, uDMCalcPrice;

type
  TRDMCatalog = class(TRemoteDataModule, IRDMCatalog)
    dspSearchProduct: TDataSetProvider;
    qrySearchProduct: TADOQuery;
    dspLUVendor: TDataSetProvider;
    qryLUVendor: TADOQuery;
    dspLUDepartment: TDataSetProvider;
    qryLUDepartment: TADOQuery;
    dspLUCategory: TDataSetProvider;
    qryLUCategory: TADOQuery;
    dspLUSubCategory: TDataSetProvider;
    qryLUSubCategory: TADOQuery;
    qryListVendor: TADOQuery;
    dspListVendor: TDataSetProvider;
    procedure dspSearchProductBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspSearchProductAfterGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure dspListVendorBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
  private
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    FOldSQL: String;
    procedure SetConnection;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
    function GetNewCostPriceList(const AFilter: WideString): OleVariant; safecall;
    function UpdatePrices(ModelList: OleVariant; var MsgLog: WideString;
      const ACatalogConfig: WideString): WordBool; safecall;
    function GetNewInventoryList(const AFilter: WideString): OleVariant; safecall;
    function UpdateInventory(ModelList: OleVariant; var MsgLog: WideString): WordBool; safecall;
  public
    { Public declarations }
  end;

var
  RDMCatalog: TRDMCatalog;
  RDMCatalogFactory: TComponentFactory;

implementation

uses uSqlFunctions, uMRSQLParam, uDMImportInventoryCatalog;

{$R *.DFM}

class procedure TRDMCatalog.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMCatalog.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMCatalog.Set_RDMApplicationHub(const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

function TRDMCatalog.GetNewCostPriceList(const AFilter: WideString): OleVariant;
begin
  with TDMImportInventoryCatalog.Create(Self) do
  try
    SetConnection(FSQLConnection);
    ConfigureCalcPrice(FSQLConnection);
    Result := GetModelPricesList(AFilter);
  finally
    Free;
  end;
end;

function TRDMCatalog.GetNewInventoryList(const AFilter: WideString): OleVariant;
begin
  with TDMImportInventoryCatalog.Create(Self) do
  try
    SetConnection(FSQLConnection);
    Result := GetInventoryList(AFilter);
  finally
    Free;
  end;
end;

function TRDMCatalog.UpdateInventory(ModelList: OleVariant; var MsgLog: WideString): WordBool;
begin
  with TDMImportInventoryCatalog.Create(Self) do
  try
    SetConnection(FSQLConnection);
    Result := UpdateMRInventoryWithCatalog(ModelList);
    MsgLog := Log.Text;
  finally
    Free;
  end;
end;

function TRDMCatalog.UpdatePrices(ModelList: OleVariant;
  var MsgLog: WideString; const ACatalogConfig: WideString): WordBool;
begin
  with TDMImportInventoryCatalog.Create(Self) do
  try
    SetConnection(FSQLConnection);
    Result := UpdateMRPricesWithCatalog(ModelList);
    MsgLog := Log.Text;
  finally
    Free;
  end;
end;

procedure TRDMCatalog.dspSearchProductBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  try
    Param := TMRSQLParam.Create;
    Param.ParamString := OwnerData;

    if FOldSQL = '' then
      FOldSQL := qrySearchProduct.SQL.Text;

    if OwnerData <> '' then
    begin
      qrySearchProduct.SQL.Text := FOldSQL + ' WHERE ' + Param.GetWhereSQL;
    end;
  finally
    FreeAndNil(Param);
  end;

  OwnerData := '';
end;

procedure TRDMCatalog.dspSearchProductAfterGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  qrySearchProduct.SQL.Text := FOldSQL;
end;

procedure TRDMCatalog.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection
    else if Components[i] is TADODataSet then
      TADODataSet(Components[i]).Connection := FSQLConnection;
end;

procedure TRDMCatalog.dspListVendorBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  sSQL : String;
  IDVendorMR : String;
begin

  IDVendorMR := DeltaDS.FieldByName('IDVendorMR').AsString;
  if IDVendorMR = '' then
    IDVendorMR := 'NULL';

  sSQL := Format('UPDATE MRCatalogDB..Vendors Set IDVendorMR = %S WHERE IDVendor = %S',
                  [IDVendorMR, DeltaDS.FieldByName('IDVendor').OldValue]);
  FSQLConnection.Execute(sSQL);
  Applied := True;
end;

initialization
  RDMCatalogFactory := TComponentFactory.Create(ComServer, TRDMCatalog,
    Class_RDMCatalog, ciInternal, tmApartment);
end.
