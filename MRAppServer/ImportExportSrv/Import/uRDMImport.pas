unit uRDMImport;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigTable;

type
  TRDMImport = class(TRemoteDataModule, IRDMImport)
    dspLookupStore: TDataSetProvider;
    dspLookupVendor: TDataSetProvider;
    dspLookupUser: TDataSetProvider;
    qryLookupStore: TADOQuery;
    qryLookupUser: TADOQuery;
    qryLookupVendor: TADOQuery;
  private
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
    function ValidatePurchaseNum(const PurchaseNum,
      Vendor: WideString): WordBool; safecall;
    function ImportCatalogTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString): WordBool;
      safecall;
    procedure ImportPOTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString); safecall;

    function ValidatePOTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString;
      var APassed: WordBool): OleVariant; safecall;

    procedure ImportPersonTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString); safecall;
    procedure ImportInventoryTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString); safecall;
    function ValidateInventoryTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString;
      var APassed: WordBool): OleVariant; safecall;
    function ValidateModelsPOTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString;
      var APassed: WordBool): OleVariant; safecall;
    function ExistsPONum(const PONumber: WideString): WordBool; safecall;
    function InsertConfigImport(IDPessoa, ImportType: Integer;
      const CrossColumn: WideString; CaseCost: WordBool;
      var AMsgLog: WideString): WordBool; safecall;
    function GetConfigImport(IDPessoa, ImportType: Integer;
      var CrossColumn: WideString; var CaseCost: WordBool;
      var AmsgLog: WideString): WordBool; safecall;
    { Alex 03/04/2011 }
    function ValidateVCTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AmsgLog: WideString;
      var APassed: WordBool): OleVariant; safecall;
    procedure ImportVCTextFile(AFile: OleVariant; const ALinkedColumns,
      AImportConfig: WideString; var AMsgLog: WideString); safecall;
 
  end;

var
  RDMImport: TRDMImport;
  RDMImportFactory: TComponentFactory;

implementation

uses uDMValidateInventoryTextFile, uDMValidatePOTextFile, uDMImportTextFile,
  uDMImportInventoryTextFile, uDMImportPersonTextFile, uDMImportPoTextFile,
  uDMValidateTextFile, uDMValidateVCTextFile, uDMImportVCTextFile,
  uDebugFunctions;

{$R *.DFM}

class procedure TRDMImport.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

function TRDMImport.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMImport.Set_RDMApplicationHub(const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMImport.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

function TRDMImport.ValidatePurchaseNum(const PurchaseNum,
  Vendor: WideString): WordBool;
begin
  with TDMValidatePOTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    Result := NotExistsPurchaseNum(PurchaseNum,Vendor);
  finally
    Free;
  end;
end;

function TRDMImport.ImportCatalogTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString;
  var AMsgLog: WideString): WordBool;
begin
  {
  with TDMImportCatalogTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    CreateCatalogDB;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    Result := Import;
  finally
    Free;
  end;
  }
end;

procedure TRDMImport.ImportPOTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString;
  var AMsgLog: WideString);
begin
  with TDMImportPOTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    Import;
    AMsgLog := Log.Text;
  finally
    Free;
  end;
end;

function TRDMImport.ValidatePOTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString; var AMsgLog: WideString;
  var APassed: WordBool): OleVariant;
begin
  with TDMValidatePOTextFile.Create(Self) do
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

procedure TRDMImport.ImportPersonTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString;
  var AMsgLog: WideString);
begin

  with TDMImportPersonTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    Import;
    AMsgLog := Log.Text;
  finally
    Free;
  end;
  
end;

procedure TRDMImport.ImportInventoryTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString;
  var AMsgLog: WideString);
begin

  with TDMImportInventoryTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    Import;
    AMsgLog := Log.Text;
  finally
    Free;
  end;
  
end;

function TRDMImport.ValidateInventoryTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString; var AMsgLog: WideString;
  var APassed: WordBool): OleVariant;
begin

  with TDMValidateInventoryTextFile.Create(Self) do
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

function TRDMImport.ValidateModelsPOTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString; var AMsgLog: WideString;
  var APassed: WordBool): OleVariant;
begin
  with TDMValidatePOTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    APassed := ValidateModels;
    Result := TextFile.Data;
  finally
    Free;
  end;
end;

function TRDMImport.ExistsPONum(const PONumber: WideString): WordBool;
begin
  with TDMValidatePOTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    Result := ExistsPONum(PONumber);
  finally
    Free;
  end;
end;

function TRDMImport.InsertConfigImport(IDPessoa, ImportType: Integer;
  const CrossColumn: WideString; CaseCost: WordBool;
  var AMsgLog: WideString): WordBool;
begin
  with TDMImportTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    LinkedColumns.Text := CrossColumn;
    Result := CreateConfigImport(IDPessoa, CaseCost, ImportType);
    AMsgLog := Log.Text;
  finally
    Free;
  end;
end;

function TRDMImport.GetConfigImport(IDPessoa, ImportType: Integer;
  var CrossColumn: WideString; var CaseCost: WordBool;
  var AmsgLog: WideString): WordBool;

var
  ACrossColumn: WideString;
  ACaseCost: WordBool;
begin
  with TDMImportTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    Result := GetConfigImport(IDPessoa, ImportType, ACrossColumn, ACaseCost);
    CrossColumn := ACrossColumn;
    CaseCost := ACaseCost;
    AMsgLog := Log.Text;
  finally
    Free;
  end;
end;

function TRDMImport.ValidateVCTextFile(AFile: OleVariant;
                                       const ALinkedColumns, AImportConfig: WideString;
                                       var AmsgLog: WideString;
                                       var APassed: WordBool): OleVariant;
begin

  with TDMValidateVCTextFile.Create(Self) do begin

    try
      DebugToFile('On Appserver side >> ValidateVCTextFile');
      SQLConnection := FSQLConnection;
//      debugtofile('SQLconnection = ' + FSQLConnection.ConnectionString);
      TextFile.Data      := AFile;
      debugtofile('textfile.data - ok');
      LinkedColumns.Text := ALinkedColumns;
      debugtofile('linkedcolumns - ok ');

      ImpExpConfig.Text  := AImportConfig;
      debugtofile('ImpExpConfig - ok');

      APassed := Validate();
      debugtofile('validate - ok');

      Result  := TextFile.Data;

    finally

      Free;

    end;

  end;

end;

procedure TRDMImport.ImportVCTextFile(AFile: OleVariant;
  const ALinkedColumns, AImportConfig: WideString;
  var AMsgLog: WideString);
begin

  with TDMImportVCTextFile.Create(Self) do
  try
    SQLConnection := FSQLConnection;
    TextFile.Data := AFile;
    LinkedColumns.Text := ALinkedColumns;
    ImpExpConfig.Text := AImportConfig;
    Import;
    AMsgLog := Log.Text;
  finally
    Free;
  end;

end;

initialization
  RDMImportFactory := TComponentFactory.Create(ComServer, TRDMImport,
    Class_RDMImport, ciInternal, tmApartment);
end.
