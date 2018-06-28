unit uDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, DB, ADODB, PowerADOQuery,
  LookUpADOQuery;


const
  INI_FILE = 'MRPuppyTracker.ini';

type
  TMRDatabase = class
    private
     fDatabaseName : String;
     fServer       : String;
     fUser         : String;
     fPW           : String;
    public
     property DatabaseName : String read fDatabaseName write fDatabaseName;
     property Server       : String read fServer       write fServer;
     property User         : String read fUser         write fUser;
     property PW           : String read fPW           write fPW;
  end;

  TMRLocalDatabase = class
    private
     fLocalDatabaseName : String;
     fLocalServer       : String;
     fLocalUser         : String;
     fLocalPW           : String;
    public
     property LocalDatabaseName : String read fLocalDatabaseName write fLocalDatabaseName;
     property LocalServer       : String read fLocalServer       write fLocalServer;
     property LocalUser         : String read fLocalUser         write fLocalUser;
     property LocalPW           : String read fLocalPW           write fLocalPW;
  end;

  TDM = class(TDataModule)
    ADOPetConnection : TADOConnection;
    quPuppy: TADODataSet;
    quPuppyBreed_Code: TWideStringField;
    quPuppyBreed_Name: TWideStringField;
    quPuppyReference_No: TIntegerField;
    quPuppyWeight: TFloatField;
    quPuppyColor: TWideStringField;
    quPuppyPur_Price: TBCDField;
    quPuppyRegular_Price: TBCDField;
    quPuppySales_Price: TBCDField;
    MRDBInventoryConnection: TADOConnection;
    quCmdFree: TADOCommand;
    spGetNextID: TADOStoredProc;
    quModel: TADODataSet;
    quModelModel: TStringField;
    quModelIDModel: TIntegerField;
    quInvoice: TADODataSet;
    quIDCustomers: TADODataSet;
    quCmdFreePet: TADOCommand;
    quIDCustomersCustomer_Id: TWideStringField;
    quIDCustomersName: TWideStringField;
    quIDCustomersFirstName: TWideStringField;
    quInvoiceItem: TADODataSet;
    quInvoiceItemSalePrice: TBCDField;
    quInvoiceItemModel: TStringField;
    quInvoiceItemInvoiceDate: TDateTimeField;
    ADOPuppyHistory: TADOConnection;
    quCmdFreeHistory: TADOCommand;
    quMaxPuppyExport: TADODataSet;
    quMaxPuppyExportExpr1000: TIntegerField;
    quInvoiceItemCostPrice: TBCDField;
    quListPuppyExport: TADODataSet;
    quListPuppyModel: TADODataSet;
    DsquListPuppyExport: TDataSource;
    DsquListPuppyModel: TDataSource;
    quListPuppyExportIDPuppyExport: TAutoIncField;
    quListPuppyExportDateExport: TDateTimeField;
    quListPuppyModelIDPuppyModel: TAutoIncField;
    quListPuppyModelIDPuppyExport: TIntegerField;
    quListPuppyModelPuppyModel: TWideStringField;
    quListPuppyModelPuppyDescription: TWideStringField;
    quListPuppyModelCostPrice: TBCDField;
    quListPuppyModelSalePrice: TBCDField;
    quListPuppyModelStatus: TIntegerField;
    cmdInsertQty: TADOCommand;
    quLookUpStore: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    dsLookUpStore: TDataSource;
    quLookUpCategory: TLookUpADOQuery;
    dsLookUpCategory: TDataSource;
    quLookUpCategoryIDGroup: TIntegerField;
    quLookUpCategoryName: TStringField;
    quFindCategory: TADODataSet;
    quFindCategoryIDGroup: TIntegerField;
    quFindCategoryName: TStringField;
    quCustomers: TADODataSet;
    quInvoicePessoaFirstName: TStringField;
    quInvoicePessoaLastName: TStringField;
    quInvoiceEndereco: TStringField;
    quInvoiceCidade: TStringField;
    quInvoiceIDEstado: TStringField;
    quInvoiceCEP: TStringField;
    quInvoiceFax: TStringField;
    quInvoiceOBS: TStringField;
    quInvoiceEmail: TStringField;
    quInvoicePais: TStringField;
    quCustomersCustomer_Id: TWideStringField;
    quCustomersName: TWideStringField;
    quCustomersFirstName: TWideStringField;
    quCustomersZip: TWideStringField;
    quDelHistoryDate: TADODataSet;
    quInvoiceItemQty: TFloatField;
    quPuppySex: TWideStringField;
    quPuppyChip_No: TWideStringField;
    quInvoiceItemModelID: TIntegerField;
    quPuppySale_Price: TBCDField;
    MRDBSalesConnection: TADOConnection;
    quInvoiceTelefone: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fLocalPath    : String;
    fPetFile      : String;
    fPetExeRepFile: String;
    fPetNumCop    : String;
    fDefaultCateg : Integer;
    fDefaultStore : Integer;
    fPetRepExeVer : Integer;
    fUseDebug, fSaveSerialNum: Boolean;

    procedure SetPetFile(aPetFile:String);
    procedure SetCategory(IDCateg:Integer);
    procedure SetStore(IDStore:Integer);
    function GetConnection:String;
    procedure SetPetExeRepFile(aPetExeRepFile:String);
    procedure SetPetNumCop(aPetNumCop:String);
    function GetIniFile(sSection, sKey : String):String;
    procedure SetIniFileString(sSection, sKey : String; Text : String);
    procedure SetPetRepExeVer(const Value: Integer);
    procedure SetUseDebug(const Value: Boolean);
    procedure SetSaveSerialNum(const Value: Boolean);
    function GetlocalConnection: String;
  public
    fMRDatabase : TMRDatabase;
    fMRLocalDatabase : TMRLocalDatabase;
    fPetInfo    : TInifile;
    fDelHistory   : Integer;
    property LocalPath    : String  read fLocalPath;
    property PetFile      : String  read fPetFile       write SetPetFile;
    property PetExeRepFile: String  read fPetExeRepFile write SetPetExeRepFile;
    property PetNumCop    : String  read fPetNumCop     write SetPetNumCop;
    property PetRepExeVer : Integer read fPetRepExeVer  write SetPetRepExeVer;
    property UseDebug     : Boolean read fUseDebug      write SetUseDebug;
    property SaveSerialNum : Boolean read fSaveSerialNum write SetSaveSerialNum;
    property DefaultCateg : Integer read fDefaultCateg  write SetCategory;
    property DefaultStore : Integer read fDefaultStore  write SetStore;
    property DelHistory   : Integer read fDelHistory;
    function PetConnectionOpen:Boolean;
    function PetConnectionClose:Boolean;
    function MRInventoryConnectionOpen:Boolean;
    function MRInventoryConnectionClose:Boolean;
    function MRSalesConnectionOpen:Boolean;
    function MRSalesConnectionClose:Boolean;
    function GetNextID(const sTabela: String): LongInt;
    procedure RunSQL(SQL:String);
    procedure RunSQL_Pet(SQL: String);
    procedure RunSQL_History(SQL: String);
    procedure BuildConnection;
    procedure SetConnection(sServer, sDB, sUser, sPW : String);
    procedure SetLocalConnection(sServer, sDB, sUser, sPW: String);
    function GetSalesPerson(Invoice: String): String;
  end;

var
  DM: TDM;

implementation

uses uEncryptFunctions;

{$R *.dfm}

{ TDM }

function TDM.PetConnectionClose: Boolean;
begin

  with ADOPetConnection do
     if Connected then
        try
          Close;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;

end;

function TDM.PetConnectionOpen: Boolean;
begin

  with ADOPetConnection do
     if not Connected then
        try
          ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+fPetFile+';Persist Security Info=False';
          Open;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;

end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  fMRDatabase    := TMRDatabase.Create;
  fMRLocalDatabase := TMRLocalDatabase.Create;

  fLocalPath     := ExtractFilePath(Application.ExeName);
  fPetInfo       := TIniFile.Create(fLocalPath + INI_FILE);
  fPetFile       := fPetInfo.ReadString('PetSetting', 'FilePath', '');
  fPetExeRepFile := fPetInfo.ReadString('PetSetting', 'FileExeRepPath', '');
  fPetNumCop     := fPetInfo.ReadString('PetSetting', 'FileNumCop', '');

  BuildConnection;

  fDefaultCateg  := fPetInfo.ReadInteger('Defaults', 'IDCategory', 1);
  fPetRepExeVer := fPetInfo.ReadInteger('PetSetting', 'ExeRepVer', 1);
  fDefaultStore  := fPetInfo.ReadInteger('Defaults', 'IDStore', 1);
  fDelHistory    := fPetInfo.ReadInteger('History', 'ClearDays', 1);

  fUseDebug      := fPetInfo.ReadBool('Defaults', 'UseDebug', true);
  fSaveSerialNum := fPetInfo.ReadBool('Defaults', 'SaveSerialNum', true);

  ADOPuppyHistory.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+fLocalPath+'PuppyHistory.mdb'+';Persist Security Info=False';
  ADOPuppyHistory.Open;

  quListPuppyExport.Open;
  quListPuppyModel.Open;

end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fPetInfo);
  FreeAndNil(fMRDatabase);
  FreeAndNil(fMRlocalDatabase);
end;

procedure TDM.SetPetFile(aPetFile: String);
begin
  fPetFile := aPetFile;
  fPetInfo.WriteString('PetSetting', 'FilePath', aPetFile);
end;

function TDM.MRInventoryConnectionClose: Boolean;
begin
  with MRDBInventoryConnection do
     if Connected then
        try
          Close;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;
end;

function TDM.MRInventoryConnectionOpen: Boolean;
begin
  with MRDBInventoryConnection do
     if not Connected then
        try
          ConnectionString := GetConnection;
          Open;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;
end;

function TDM.GetConnection: String;
begin
  Result := 'Provider=SQLOLEDB.1;Password='+fMRDatabase.PW+';Persist Security Info=True;'+
            'User ID='+fMRDatabase.User+';Initial Catalog='+fMRDatabase.DatabaseName+
            ';Data Source='+fMRDatabase.Server+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=DESENV001;Use Encryption for Data=False;Tag with column collation when possible=False';
end;

function TDM.GetlocalConnection: String;
begin
  Result := 'Provider=SQLOLEDB.1;Password='+fMRLocalDatabase.LocalPW+';Persist Security Info=True;'+
            'User ID='+fMRLocalDatabase.LocalUser+';Initial Catalog='+fMRLocalDatabase.LocalDatabaseName+
            ';Data Source='+fMRLocalDatabase.LocalServer+';Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=DESENV001;Use Encryption for Data=False;Tag with column collation when possible=False';
end;

function TDM.GetNextID(const sTabela: String): LongInt;
begin
  with spGetNextID do
    begin
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
    end;
end;

procedure TDM.RunSQL(SQL: String);
begin
   with quCmdFree do
      begin
      CommandText := SQL;
      Execute;
      end;
end;

procedure TDM.SetCategory(IDCateg: Integer);
begin
  fDefaultCateg := IDCateg;
  fPetInfo.WriteInteger('Defaults', 'IDCategory', IDCateg);
end;

procedure TDM.SetStore(IDStore: Integer);
begin
  fDefaultStore := IDStore;
  fPetInfo.WriteInteger('Defaults', 'IDStore', IDStore);
end;


procedure TDM.RunSQL_PET(SQL: String);
begin
   with quCmdFreePet do
      begin
      CommandText := SQL;
      Execute;
      end;
end;

procedure TDM.RunSQL_History(SQL: String);
begin
  with quCmdFreeHistory do
      begin
      CommandText := SQL;
      Execute;
      end;
end;

procedure TDM.BuildConnection;
begin
  fMRDatabase.DatabaseName := DecodeServerInfo(GetIniFile('MRSetting','Database'), 'Database', CIPHER_TEXT_STEALING, FMT_UU);
  fMRDatabase.Server       := DecodeServerInfo(GetIniFile('MRSetting','Server'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);
  fMRDatabase.User         := DecodeServerInfo(GetIniFile('MRSetting','User'), 'User', CIPHER_TEXT_STEALING, FMT_UU);
  fMRDatabase.PW           := DecodeServerInfo(GetIniFile('MRSetting','PW'), 'PW', CIPHER_TEXT_STEALING, FMT_UU);

  fMRLocalDatabase.LocalDatabaseName := DecodeServerInfo(GetIniFile('MRSetting','LocalDatabase'), 'LocalDatabase', CIPHER_TEXT_STEALING, FMT_UU);
  fMRLocalDatabase.LocalServer       := DecodeServerInfo(GetIniFile('MRSetting','LocalServer'), 'LocalServer', CIPHER_TEXT_STEALING, FMT_UU);
  fMRLocalDatabase.LocalUser         := DecodeServerInfo(GetIniFile('MRSetting','LocalUser'), 'LocalUser', CIPHER_TEXT_STEALING, FMT_UU);
  fMRLocalDatabase.LocalPW           := DecodeServerInfo(GetIniFile('MRSetting','LocalPW'), 'LocalPW', CIPHER_TEXT_STEALING, FMT_UU);
end;

procedure TDM.SetPetExeRepFile(aPetExeRepFile: String);
begin
  fPetExeRepFile := aPetExeRepFile;
  fPetInfo.WriteString('PetSetting', 'FileExeRepPath', aPetExeRepFile);
end;

procedure TDM.SetPetNumCop(aPetNumCop: String);
begin
  fPetNumCop := aPetNumCop;
  fPetInfo.WriteString('PetSetting', 'FileNumCop', aPetNumCop);
end;

procedure TDM.SetConnection(sServer, sDB, sUser, sPW: String);
begin
  sDB     := EncodeServerInfo(sDB, 'Database', CIPHER_TEXT_STEALING, FMT_UU);
  sServer := EncodeServerInfo(sServer, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
  sUser   := EncodeServerInfo(sUser, 'User', CIPHER_TEXT_STEALING, FMT_UU);
  sPW     := EncodeServerInfo(sPW, 'PW', CIPHER_TEXT_STEALING, FMT_UU);

  SetIniFileString('MRSetting','Database', sDB);
  SetIniFileString('MRSetting','Server', sServer);
  SetIniFileString('MRSetting','User', sUser);
  SetIniFileString('MRSetting','PW', sPW);
  BuildConnection;
end;

procedure TDM.SetLocalConnection(sServer, sDB, sUser, sPW: String);
begin
  sDB     := EncodeServerInfo(sDB, 'LocalDatabase', CIPHER_TEXT_STEALING, FMT_UU);
  sServer := EncodeServerInfo(sServer, 'LocalServer', CIPHER_TEXT_STEALING, FMT_UU);
  sUser   := EncodeServerInfo(sUser, 'LocalUser', CIPHER_TEXT_STEALING, FMT_UU);
  sPW     := EncodeServerInfo(sPW, 'LocalPW', CIPHER_TEXT_STEALING, FMT_UU);

  SetIniFileString('MRSetting','LocalDatabase', sDB);
  SetIniFileString('MRSetting','LocalServer', sServer);
  SetIniFileString('MRSetting','LocalUser', sUser);
  SetIniFileString('MRSetting','LocalPW', sPW);
  BuildConnection;
end;

function TDM.GetIniFile(sSection, sKey: String): String;
begin
  Result := fPetInfo.ReadString(sSection, sKey, '');
end;

procedure TDM.SetIniFileString(sSection, sKey, Text: String);
begin
  fPetInfo.WriteString(sSection, sKey, Text);
end;

procedure TDM.SetPetRepExeVer(const Value: Integer);
begin
  fPetRepExeVer := Value;
  fPetInfo.WriteInteger('PetSetting', 'ExeRepVer', fPetRepExeVer);
end;

procedure TDM.SetUseDebug(const Value: Boolean);
begin
  fUseDebug := Value;
  fPetInfo.WriteBool('Defaults', 'UseDebug', fUseDebug);
end;

function TDM.GetSalesPerson(Invoice :String): String;
var
  qrySalesPerson : TADOQuery;
begin
  qrySalesPerson := TADOQuery.Create(self);

  try
    with qrySalesPerson do
    begin
      qrySalesPerson.Connection := MRDBSalesConnection;

      SQL.Text := 'SELECT '+
                  ' TOP 1 P.Pessoa '+
                  'FROM '+
                  ' Invoice I (NOLOCK) '+
                  ' JOIN vw_Rep_InventoryMov IMV (NOLOCK) ON (I.IDInvoice = IMV.IDDocument and IMV.IDInventMovType = 1) '+
                  ' JOIN Model M (NOLOCK) ON (IMV.IDModel = M.IDModel) '+
                  ' JOIN TabGroup TB (NOLOCK) ON (M.GroupID = TB.IDGroup) '+
                  ' JOIN Pessoa P (NOLOCK) ON (P.IDPESSOA = IMV.IDComission) '+
                  'WHERE '+
                  ' I.IDInvoice = ' + Invoice +
                  '	AND '+
                  ' TB.PuppyTracker = 1 ';
      Open;

      Result := copy(FieldByName('Pessoa').AsString,1,50);
    end;
  finally
    FreeAndNil(qrySalesPerson);
    end;
end;

procedure TDM.SetSaveSerialNum(const Value: Boolean);
begin
  fSaveSerialNum := Value;
  fPetInfo.WriteBool('Defaults', 'SaveSerialNum', fSaveSerialNum);
end;

function TDM.MRSalesConnectionClose: Boolean;
begin
  with MRDBSalesConnection do
     if Connected then
        try
          Close;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;
end;

function TDM.MRSalesConnectionOpen: Boolean;
begin
  with MRDBSalesConnection do
     if not Connected then
        try
          ConnectionString := GetLocalConnection;
          Open;
          Result := True;
        except
          on E: Exception do
             begin
             Result := False;
             ShowMessage(E.Message);
             end;
          end;
end;

end.
