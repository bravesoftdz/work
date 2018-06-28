unit uRDMApplicationHub;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  MRAppServer_TLB, DB, Forms, ADODB, FMTBcd, StdVcl, Provider, uMainRetailKey;

const
  CLIENT_INFO = '%S - %S';

type
  TRDMApplicationHub = class(TRemoteDataModule, IRDMApplicationHub)
    ADOConnection: TADOConnection;
    qryGetNextCode: TADOQuery;
    qrySetNextCode: TADOQuery;
    dspLogin: TDataSetProvider;
    qryLogin: TADODataSet;
    spGetNextKey: TADOStoredProc;
    procedure RemoteDataModuleCreate(Sender: TObject);
    procedure RemoteDataModuleDestroy(Sender: TObject);
  private
    MRKey : TMRKey;
    procedure SetClientConnection(ClientID: String);
    function GetNextKey(sTabela : String) : Integer;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure LogIn(const IDClient, Station: WideString); safecall;
    procedure LogOut(const IDClient, Station: WideString); safecall;
    procedure CommitTransaction; safecall;
    procedure RollbackTransaction; safecall;
    procedure StartTransaction; safecall;
    function InTransaction: WordBool; safecall;
    function Get_SQLConnection: Integer; safecall;
    function Get_RDMExport: IRDMExport; safecall;
    function Get_RDMImport: IRDMImport; safecall;
    function Get_RDMReport: IRDMReport; safecall;
    function GetConnectionString: WideString; safecall;
    function Get_RDMLookupInventory: IRDMLookupInventory; safecall;
    function Get_RDMLookupPurchase: IRDMLookupPurchase; safecall;
    function Get_RDMLookupMaintenance: IRDMLookupMaintenance; safecall;
    function GetSvrParamValue(IDParam: Integer): OleVariant; safecall;
    function Get_RDMCatalog: IRDMCatalog; safecall;
    function IsClientServer: WordBool; safecall;
    function GetNextCode(const TableName, CodeField: WideString): OleVariant;
      safecall;
    function Get_RDMPetCenter: IRDMPetCenter; safecall;
    function Get_RDMMaintenance: IRDMMaintenance; safecall;
    procedure SaveAppTrace(IdUser, ErrorLevel: Integer; const FormClass,
      Method, Exception, RecordId, Software: WideString); safecall;
    function Get_RDMLookUpPet: IRDMLookUpPet; safecall;
    function Get_RDMLookUpSO: RDMLookUpSO; safecall;
    function Get_RDMSearchPet: IRDMSearchPet; safecall;
    function TestUniqueFields(const TableName, Fields, Values,
      KeyFieldName, KeyFieldValue: WideString): WordBool; safecall;
    function SoftwareGetExpDate(const Software: WideString): OleVariant;
      safecall;
    function SoftwareAccess(const Software: WideString): WordBool; safecall;
    function SoftwareModuleAccess(const Software,
      Module: WideString): WordBool; safecall;
    function SoftwareKey: OleVariant; safecall;
    function SoftwareDelete(const Software: WideString): WordBool; safecall;
    function IsCorpServer: WordBool; safecall;
    //function IRDMApplicationHub.Get_RDMLookUpSO = RDMApplicationHub_Get_RDMLookUpSO;
    function IRDMApplicationHub_Get_RDMLookUpSO: IRDMLookUpSO; safecall;
  end;

implementation

uses IniFiles, uMain, uParamFunctions, uRDMExport, uRDMImport, uRDMReport,
  uRDMLookupInventory, uRDMLookupPurchase, uRDMLookupMaintenance, uRDMCatalog,
  uSystemConfig, uSystemConst, uRDMPetCenter, uRDMMaintenance, uRDMLookUpPet,
  uRDMSearchPet, uRDMLookUpSO;

{$R *.DFM}

class procedure TRDMApplicationHub.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
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

procedure TRDMApplicationHub.LogIn(const IDClient, Station: WideString);
begin
  frmMain.IDClient := IDClient;
  frmMain.UserList.Add(Format(CLIENT_INFO, [IDClient, Station]));
  SetClientConnection(IDClient);
end;

procedure TRDMApplicationHub.LogOut(const IDClient, Station: WideString);
var
  iIndex: Integer;
begin
  with frmMain.UserList do
  begin
    iIndex := IndexOf(Format(CLIENT_INFO, [IDClient, Station]));
    if iIndex >= 0 then
      Delete(iIndex);
  end;
end;

procedure TRDMApplicationHub.SetClientConnection(ClientID: String);
var
  DriverName, BlobSize, HostName, DataBase, UserName, Password: String;
  UseNetLib : Boolean;
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName) + frmMain.GetConfigFile) do
  try
    DriverName := ReadString(ClientID, 'DriverName', '');
    BlobSize   := ReadString(ClientID, 'BlobSize', '');
    HostName   := ReadString(ClientID, 'HostName', '');
    DataBase   := ReadString(ClientID, 'DataBase', '');
    UserName   := frmMain.Decode('User', ReadString(ClientID, 'User', ''));
    Password   := frmMain.Decode('PW', ReadString(ClientID, 'Password', ''));
    UseNetLib  := ReadBool(ClientID, 'UseNetLib', False);

    if not UseNetLib then
       ADOConnection.ConnectionString := SetConnectionStrNoNETLIB(UserName, Password, DataBase, HostName)
    else
       ADOConnection.ConnectionString := SetConnectionStr(UserName, Password, DataBase, HostName)
  finally
    Free;
  end;
end;

procedure TRDMApplicationHub.CommitTransaction;
begin
  ADOConnection.CommitTrans;
end;

procedure TRDMApplicationHub.RollbackTransaction;
begin
  ADOConnection.RollbackTrans;
end;

procedure TRDMApplicationHub.StartTransaction;
begin
  ADOConnection.BeginTrans;
end;

function TRDMApplicationHub.InTransaction: WordBool;
begin
  Result := (ADOConnection.InTransaction);
end;

function TRDMApplicationHub.Get_SQLConnection: Integer;
begin
  Result := Integer(ADOConnection);
end;

procedure TRDMApplicationHub.RemoteDataModuleCreate(Sender: TObject);
begin
  if frmMain.IDClient <> EmptyStr then
    SetClientConnection(frmMain.IDClient);

  MRKey := TMRKey.Create(ADOConnection);

end;

function TRDMApplicationHub.Get_RDMExport: IRDMExport;
begin
  Result := RDMExportFactory.CreateComObject(nil) as IRDMExport;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.Get_RDMImport: IRDMImport;
begin
  Result := RDMImportFactory.CreateComObject(nil) as IRDMImport;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.Get_RDMReport: IRDMReport;
begin
  Result := RDMReportFactory.CreateComObject(nil) as IRDMReport;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.GetConnectionString: WideString;
begin
  Result := ADOConnection.ConnectionString;
end;

function TRDMApplicationHub.Get_RDMLookupInventory: IRDMLookupInventory;
begin
  Result := RDMLookupInventoryFactory.CreateComObject(nil) as IRDMLookupInventory;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.Get_RDMLookupPurchase: IRDMLookupPurchase;
begin
  Result := RDMLookupPurchaseFactory.CreateComObject(nil) as IRDMLookupPurchase;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.Get_RDMLookupMaintenance: IRDMLookupMaintenance;
begin
  Result := RDMLookupMaintenanceFactory.CreateComObject(nil) as IRDMLookupMaintenance;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.GetSvrParamValue(IDParam: Integer): OleVariant;
begin
  //Implementar
end;

function TRDMApplicationHub.Get_RDMCatalog: IRDMCatalog;
begin
  Result := RDMCatalogFactory.CreateComObject(nil) as IRDMCatalog;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.IsClientServer: WordBool;
var
  VersionType: String;
begin
  if GetSystemConfig(ADOConnection, VersionType) then
    Result := VersionType = QuotedStr(SYSTEM_CLIENT_TYPE);
end;

function TRDMApplicationHub.IsCorpServer: WordBool;
var
  VersionType: String;
begin
  if GetSystemConfig(ADOConnection, VersionType) then
    Result := VersionType = QuotedStr(SYSTEM_SERVER_TYPE);
end;

function TRDMApplicationHub.GetNextCode(const TableName,
  CodeField: WideString): OleVariant;
var
  TableField: String;
  bEmpty : Boolean;
begin
  TableField := TableName + '.' + CodeField;

  try
    ADOConnection.BeginTrans;


    Result := GetNextKey(TableField);

    //Implementar a nova funcao para retornar ID da tabla
    {
    with qryGetNextCode do
    begin
      if Active then
        Close;
      Parameters.ParamByName('TableField').Value := TableField;
      try
        Open;
        bEmpty := IsEmpty;
        //retorna o proximo registro
        Result := qryGetNextCode.FieldByName('UltimoCodigo').AsInteger + 1;
      finally
        Close;
      end;
    end;

    //Cria o campo caso nao tenha
    if bEmpty then
      ADOConnection.Execute('INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo) VALUES (' + QuotedStr(TableField) + ',0)');

    //Salva o proximo registro
    qrySetNextCode.Parameters.ParamByName('TableField').Value := TableField;
    qrySetNextCode.ExecSQL;
    }

    ADOConnection.CommitTrans;
  except
    ADOConnection.RollbackTrans;
    Result := -1;
  end;
end;

function TRDMApplicationHub.Get_RDMPetCenter: IRDMPetCenter;
begin
  Result := RDMPetCenterFactory.CreateComObject(nil) as IRDMPetCenter;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.Get_RDMMaintenance: IRDMMaintenance;
begin
  Result := RDMMaintenanceFactory.CreateComObject(nil) as IRDMMaintenance;
  Result.RDMApplicationHub := Self;
end;

procedure TRDMApplicationHub.SaveAppTrace(IdUser, ErrorLevel: Integer;
  const FormClass, Method, Exception, RecordId, Software: WideString);
var
  iIDHistory : Integer;
  sSQL : String;
begin
  iIDHistory :=  GetNextCode('Sis_AppHistory', 'IDHistory');

  sSQL := 'INSERT Sis_AppHistory (IDHistory, IDUsuario, ErrorLevel, FormSource, ErrorMessage, HistoryDate, Software) ' +
          ' VALUES (' + IntToStr(iIDHistory) + ', ' +
                        IntToStr(IdUser)     + ', ' +
                        IntToStr(ErrorLevel) + ', ' +
                        QuotedStr(FormClass) + ', ' +
                        QuotedStr(Exception) + ', ' +
                        ' GetDate(), '       +
                        QuotedStr(Software)  + ')';

  ADOConnection.Execute(sSQL);

end;

function TRDMApplicationHub.Get_RDMLookUpPet: IRDMLookUpPet;
begin
  Result := RDMLookUpPetFactory.CreateComObject(nil) as IRDMLookUpPet;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.Get_RDMSearchPet: IRDMSearchPet;
begin
  Result := RDMSearchPetFactory.CreateComObject(nil) as IRDMSearchPet;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.TestUniqueFields(const TableName,
  Fields, Values, KeyFieldName,
  KeyFieldValue: WideString): WordBool;
var
  i: Integer;
  slField,
  slValues: TStringList;
  sWhereClause: String;
  DSResult : TADODataset;
begin
  slField := TStringList.Create;
  slValues := TStringList.Create;
  DSResult := TADODataset.Create(Self);
  try
    slField.Delimiter := ',';
    slField.DelimitedText := Fields;

    slValues.Delimiter := ',';
    slValues.DelimitedText := Values;

    sWhereClause := KeyFieldName + ' <> ' + KeyFieldValue;

    for i := 0 to slField.Count-1 do
    begin
      if sWhereClause <> '' then
        sWhereClause := sWhereClause + ' AND ';
      sWhereClause := sWhereClause + slField.Strings[i] + ' = ' + slValues.Strings[i];
    end;

    DSResult.Recordset := ADOConnection.Execute('SELECT * FROM ' + TableName + ' WHERE ' + sWhereClause);
    Result := (DSResult.RecordCount > 0);
  finally
    FreeAndNil(slField);
    FreeAndNil(slValues);
    FreeAndNil(DSResult);
  end;
end;

procedure TRDMApplicationHub.RemoteDataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(MRKey);
end;

function TRDMApplicationHub.SoftwareGetExpDate(
  const Software: WideString): OleVariant;
begin

  Result := MRKey.GetExpirationDate(Software);

end;

function TRDMApplicationHub.SoftwareAccess(
  const Software: WideString): WordBool;
begin
  MRKey.VerifyKey(Software);
  Result := MRKey.SoftwareEnable(Software);
end;

function TRDMApplicationHub.SoftwareModuleAccess(const Software,
  Module: WideString): WordBool;
begin
  Result := MRKey.ModuleEnable(Software, Module);
end;

function TRDMApplicationHub.SoftwareKey: OleVariant;
begin
  Result := MRKey.FKey;
end;

function TRDMApplicationHub.SoftwareDelete(
  const Software: WideString): WordBool;
begin
  Result := MRKey.DeleteSoftware(Software);
end;

function TRDMApplicationHub.Get_RDMLookUpSO: IRDMLookUpSO;
begin
  Result := RDMLookUpSOFactory.CreateComObject(nil) as IRDMLookUpSO;
  Result.RDMApplicationHub := Self;
end;

function TRDMApplicationHub.GetNextKey(sTabela: String): Integer;
begin

  with spGetNextKey do
  begin
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  end;

end;

function TRDMApplicationHub.IRDMApplicationHub_Get_RDMLookUpSO: IRDMLookUpSO;
begin
//
end;

initialization
  TComponentFactory.Create(ComServer, TRDMApplicationHub,
    Class_RDMApplicationHub, ciMultiInstance, tmApartment);
end.


//Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;User ID=sa;Initial Catalog=RodrigoTestDB;Data Source=.
