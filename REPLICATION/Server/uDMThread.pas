unit uDMThread;

interface

uses
  SysUtils, Classes, AbUnzper, AbBase, AbBrowse, AbZBrows, AbZipper, uSaveToFile,
  uReplicationClasses, DB, ADODB, DBClient, DSIntf;

const
  SUBDIR_GLOBAL         = 'global\';

  GLOBAL_ZIP_FILE       = 'global.zip';
  STORE_ZIP             = 'local.zip';

  MR_HST_JOB_FAIL       = 'Job fail : ';
  HISTORY_FILE          = 'history.txt';
  ERROR_FILE            = 'error.txt';

  ALL_XML               = '*.xml';
  EXT_XML               = '.xml';

  CONNECTION_STR        = 'connection';
  VERSION_STR           = 'version';
  REPSINCE_STR          = 'replicatesince';
  DISABLESCHEDULE_STR   = 'disableschedule';
  MAINSTORE_STR         = 'mainstoreid';
  SERVER_TYPE_STR       = 'servertype';
  SCHEDULE_STR          = 'schedule';
  FILE_SERVER_HOST_STR  = '#fileserverhost#=';
  FILE_SERVER_PORT_STR  = '#fileserverport#=';
  AUTH_STORE_NAME_STR   = '#storename#=';
  AUTH_PACKET_SIZE_STR  = '#packetsize#=';
  AUTH_PASSWORD_STR     = '#password#=';
  AUTH_CRIPTO_STR       = 'clientconnection';

  MR_HST_LOCAL_FILE_NOT_FOUND  = 'Local file not found. ';


type
  TDMThread = class(TDataModule)
    Zipper: TAbZipper;
    UnZipper: TAbUnZipper;
    ADODBConnect: TADOConnection;
    spRecalcTotal: TADOStoredProc;
    quUpdatePet: TADOCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    fLocalPath: String;

    fXMLToTable : TXMLToTable;
    fTableToXML: TTableToXML;
    FConnectionString: String;
    FClient: String;
    FRepSince: Integer;
    FMainStore: Integer;
    FStoreList: TStringList;
    FDBVersion : String;
    FGlobalTables: WideString;
    FStoreTables: WideString;
    FExcepTables: WideString;
    fSQLBatchCount: Integer;
    FDisableUpdateQty: Boolean;


    procedure UnZipFile(DestDir, ZipFileName: String);
    procedure ZipFile(FilesToZip, ZipFileName: String);
    procedure DeleteReplFile(sFileName: String);
    procedure ReportError(sText: String);

    procedure AddErrorHistory(Text: String);
    procedure AddHistory(Text: String);

    function CheckXMLVersion(AStream: TStream; DatabaseVersion : String): Boolean; overload;
    function CheckXMLVersion(Filename, DatabaseVersion: String): Boolean; overload;

    function GenerateXMLVersionControl(AVersion: String;
      AHora: TDateTime): String;
    function GetGlobalLockFileName(AClient: String): String;
    function GetGlobalVersionFileName(AClient: String): String;
    function GetLocalVersionFileName(AClient, AStore: String): String;
    function GetLocalLockFileName(AClient, AStore: String): String;
    function CreateGenericVersionedFile(AFileName: String; AVersion: String = 'NOCONTROL'): Boolean;
    function CreateGlobalLock(AClient: String; AVersion: String = 'NOCONTROL'): Boolean;
    function CreateLocalLock(AClient: String; AStore: String; AVersion: String = 'NOCONTROL'): Boolean;
    function IsGlobalLocked(AClient: String): Boolean;
    function IsLocalLocked(AClient, AStore: String): Boolean;
    function RemoveGlobalLock(AClient: String): Boolean;
    function RemoveLocalLock(AClient: String; AStore: String): Boolean;
    function GetDatabaseVersion: String;
    procedure SetConnectionString(const Value: String);
    function UpdateTotQtyOnHand: Boolean;
    function ExportXMLFile(ExportPath, Table: String; RepSince: Integer;
      Where: String): Boolean;
    function ImportXMLFile(Table, FileName, Where : String; SQLBatchCount: Integer = 100): Boolean;

    function IsSessionToExclude(S: String): Boolean;
    
    //XML
    function ExportXML(Client : String; ReplicateSince: Integer;  DatabaseVersion: String): Boolean;
    function ImportXML(Client, Store, DatabaseVersion : String; IDServerStore: Integer): Boolean;

    procedure CloseConnections;
    function OpenConnection : Boolean;

    function CreateGlobalFiles : Boolean;
    Function ImportStores : Boolean;
    function UpdatePetLocation: Boolean;
  public
    { Public declarations }
    property ConnectionString: String read FConnectionString write SetConnectionString;
    property LocalPath: String read fLocalPath write fLocalPath;

    property Client: String read FClient write FClient;
    property RepSince: Integer read FRepSince write FRepSince;
    property MainStore: Integer read FMainStore write FMainStore;
    property StoreList: TStringList read FStoreList write FStoreList;
    property DisableUpdateQty : Boolean read FDisableUpdateQty write FDisableUpdateQty;

    property GlobalTables : WideString read FGlobalTables write FGlobalTables;
    property StoreTables : WideString read FStoreTables write FStoreTables;
    property ExcepTables : WideString read FExcepTables write FExcepTables;
    property SQLBatchCount: Integer   read fSQLBatchCount write fSQLBatchCount;

    function ExeSingleReplication:Boolean;
  end;

var
  DMThread: TDMThread;

implementation

{$R *.dfm}


procedure TDMThread.UnZipFile(DestDir, ZipFileName: String);
begin
  try
    UnZipper.BaseDirectory := DestDir;
    UnZipper.FileName      := ZipFileName;
    try
      UnZipper.ExtractFiles('*.*');
    finally
      UnZipper.CloseArchive;
    end;
  except
    on E: Exception do
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMRepl.UnZipFile');
  end;
end;


procedure TDMThread.ZipFile(FilesToZip, ZipFileName: String);
var
  fs : TFileStream;
begin
  try
    if FileExists(ZipFileName) then
      DeleteFile(ZipFileName);

    fs := TFileStream.Create(ZipFileName, fmCreate);
    try
    finally
      fs.Free;
    end;

    Sleep(0);

    Zipper.BaseDirectory := ExtractFileDir(ZipFileName);
    Zipper.FileName := ZipFileName;
    try
      Zipper.AddFiles(FilesToZip, 0);
      Sleep(0);
      Zipper.Save;
      Sleep(0);
    finally
      Zipper.CloseArchive;
    end;
  except
    on E: Exception do
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMRepl.ZipFile');
  end;
end;


procedure TDMThread.DeleteReplFile(sFileName: String);
begin
   //delete File
   if FileExists(sFileName) then
      DeleteFile(sFileName);
end;


procedure TDMThread.AddHistory(Text:String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := LocalPath+HISTORY_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TDMThread.AddErrorHistory(Text:String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := LocalPath+ERROR_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TDMThread.ReportError(sText:String);
begin
  //Register Error history
  //AddHistory(sText);   // Nao vai logar erro no history
  AddErrorHistory(sText);
end;


function TDMThread.GenerateXMLVersionControl(AVersion: String; AHora: TDateTime): String;
Const
  CRLF = #13#10;
begin
  Result :=
      '<?xml version = "1.0" standalone = "yes"?>' + CRLF +
      '<DATAPACKET Version = "2.0">' + CRLF +
      '            <METADATA>' + CRLF +
      '                      <FIELDS>' + CRLF +
      '                              <FIELD attrname = "CreationTime" fieldtype = "DateTime"/>' + CRLF +
      '                              <FIELD attrname = "Version" fieldtype = "string" WIDTH = "10"/>' + CRLF +
      '                      </FIELDS>' + CRLF +
      '                      <PARAMS/>' + CRLF +
      '            </METADATA>' + CRLF +
      '            <ROWDATA>' + CRLF +
      Format('                     <ROW CreationTime = "%ST%S" Version = "%S"/>', [FormatDateTime('YYYYMMDD', AHora),
                                                                              FormatDateTime('HHNNSS', AHora),
                                                                              AVersion]) + CRLF +
      '            </ROWDATA>' + CRLF +
      '</DATAPACKET>' + CRLF;
end;

function TDMThread.CheckXMLVersion(Filename, DatabaseVersion : String): Boolean;
var
  //sClientDir: String;
  FS: TFileStream;
begin
  try
    FS := TFileStream.Create(Filename, fmOpenRead);
    try
      Result := CheckXMLVersion(FS, DatabaseVersion);
    finally
      FS.Free;
    end;

  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.CheckXMLVersion');
        Result := False;
      end;
  end;
end;

function TDMThread.CheckXMLVersion(AStream: TStream; DatabaseVersion : String): Boolean;
var
  cdsXML: TClientDataSet;
begin
  try
    cdsXML := TClientDataSet.Create(self);
    try
      AStream.Seek(0, soFromBeginning);
      cdsXml.LoadFromStream(AStream);
      Result := cdsXml.FieldByName('Version').AsString = DatabaseVersion;
    finally
      cdsXml.Close;
      cdsXML.Free;
    end;
  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.CheckXMLVersion');
        Result := False;
      end;
  end;
end;

function TDMThread.GetGlobalLockFileName(AClient: String): String;
begin
  Result := Format('lck-global@%S.lck', [LowerCase(AClient)]);
end;

function TDMThread.GetGlobalVersionFileName(AClient: String): String;
begin
  Result := 'ver-global@' + LowerCase(AClient) + '.xml';
end;

function TDMThread.GetLocalVersionFileName(AClient, AStore: String): String;
begin
  Result := Format('ver-%S@%S.xml', [LowerCase(AStore), LowerCase(AClient)])
end;

function TDMThread.GetLocalLockFileName(AClient, AStore: String): String;
begin
  Result := Format('lck-%S@%S.lck', [LowerCase(AStore), LowerCase(AClient)]);
end;

function TDMThread.CreateGenericVersionedFile(AFileName: String; AVersion: String = 'NOCONTROL'): Boolean;
var
  LockFile: String;
  XMLText: String;
  XMLFile: TextFile;
  ResultIO: Integer;
begin
  Result := True;
  try
    LockFile :=  AFileName;
    XMLText := GenerateXMLVersionControl(AVersion, Now);

    AssignFile(XMLFile, LockFile);
    {$I-}
    Rewrite(XMLFile);
    try
      ResultIO := IOResult;
      if ResultIO <> 0 then
        Raise Exception.CreateFmt('IO Error: %D', [ResultIO]);
      Writeln(XMLFile, XMLText);
      Flush(XMLFile);
    finally
      CloseFile(XMLFile);
    end;
    {$I+}
  except
    on E: Exception do
    begin
      ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMThread.CreateGenericVersionedFile');
      Result := False;
    end;
  end;
end;



function TDMThread.CreateGlobalLock(AClient: String; AVersion: String = 'NOCONTROL'): Boolean;
begin
  Result := CreateGenericVersionedFile(LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient), AVersion);
end;

function TDMThread.CreateLocalLock(AClient: String; AStore: String; AVersion: String = 'NOCONTROL'): Boolean;
begin
  Result := CreateGenericVersionedFile(LocalPath + AClient + '\' + AStore + '\' + GetGlobalLockFileName(AClient), AVersion);
end;

function TDMThread.RemoveGlobalLock(AClient: String): Boolean;
var
  LockFile : String;
begin
  LockFile :=  LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient);
  if FileExists(LockFile) then
    Result := DeleteFile(LockFile)
  else
    Result := True;
end;

function TDMThread.RemoveLocalLock(AClient: String; AStore: String): Boolean;
var
  LockFile : String;
begin
  LockFile := LocalPath + AClient + '\'+ AStore +'\' + GetGlobalLockFileName(AClient);
  if FileExists(LockFile) then
    Result := DeleteFile(LockFile)
  else
    Result := True;
end;

function TDMThread.IsGlobalLocked(AClient: String): Boolean;
var
  LockFile : String;
  SR: TSearchRec;
begin
  LockFile :=  LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient);
  (*
  if not DirectoryExists(ExtractFilePath(LockFile)) then
    ForceDirectories(ExtractFilePath(LockFile));
  *)
  try
    Result := FindFirst(ExtractFilePath(LockFile) + 'lck-*@'+ AClient +'.xml', faAnyFile, SR) = 0;
  finally
     FindClose(SR);
  end;

end;

function TDMThread.IsLocalLocked(AClient, AStore: String): Boolean;
var
  LockFile : String;
  SR: TSearchRec;
begin
  LockFile :=  LocalPath + AClient + '\global\' + GetLocalLockFileName(AClient, AStore);
  try
    Result := FindFirst(ExtractFilePath(LockFile) + 'lck-'+LowerCase(AStore)+'@'+ AClient +'.xml', faAnyFile, SR) = 0;
  finally
     FindClose(SR);
  end;

end;


function TDMThread.UpdateTotQtyOnHand: Boolean;
begin
  Result := True;
  try
    spRecalcTotal.Connection := ADODBConnect;
    spRecalcTotal.ExecProc;
  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMRepl.UpdateTotQtyOnHand');
        Result := False;
      end;
  end;
end;

function TDMThread.UpdatePetLocation: Boolean;
begin
  Result := True;
  try
    quUpdatePet.Connection := ADODBConnect;
    quUpdatePet.Execute;
  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMRepl.UpdatePetLocation');
        Result := False;
      end;
  end;
end;



function TDMThread.GetDatabaseVersion : String;
begin
  with TADOQuery.Create(self) do
  try
    Connection := ADODBConnect;
    SQL.Text   := 'SELECT VersionNo, BuildNo FROM Sys_Module';
    Open;
    Result     := FieldByName('VersionNo').AsString  + FieldByName('BuildNo').AsString;
  finally
    Close;
    Connection := nil;
    Free;
  end;
end;


procedure TDMThread.SetConnectionString(const Value: String);
begin
  FConnectionString := Value;
  ADODBConnect.Close;
  ADODBConnect.ConnectionString := FConnectionString;
end;

procedure TDMThread.CloseConnections;
begin
  ADODBConnect.Close;
end;


function TDMThread.ExportXMLFile(ExportPath, Table: String; RepSince:Integer; Where:String): Boolean;
var
  sErro : String;
begin
   Result := True;
   sErro := '';

   if (Table = '') then
      Exit;

   try
     try
       fTableToXML.ReplicateSince := RepSince;
       fTableToXML.TableName      := Table;
     except
       on E: Exception do
       begin
         ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMThread.ExportXMLFile');
         Result := False;
         Exit;
       end;
     end;

     sErro := fTableToXML.SaveToXML(ExportPath + Table);
     if sErro <> '' then
     begin
       ReportError(MR_HST_JOB_FAIL + sErro + ' in TDMThread.ExportXMLFile');
       Result := False;
     end;
   finally
     fTableToXML.UnloadData;
   end;
end;

function TDMThread.ImportXMLFile(Table, FileName, Where : String; SQLBatchCount: Integer = 100):Boolean;
var
  sErro : String;
begin
  Result := True;
  sErro := '';
  try
    if ((FileName = '') or (Table = '')) or
       (not FileExists(FileName)) then
       Exit;

    try
      fXMLToTable.SQLBatchCount := SQLBatchCount;
      fXMLToTable.SelectWhereClause := Where;
      sErro := fXMLToTable.LoadDataFromXML(FileName);

      if sErro <> '' then
      begin
        ReportError(MR_HST_JOB_FAIL + sErro + '( Loading data from ' + FileName + ' ) in TDMThread.ImportXMLFile');
        Result := False;
        Exit;
      end;

     fXMLToTable.TableName := Table;

     sErro := fXMLToTable.SaveDataToTable(Table);
     if sErro <> '' then
      begin
        ReportError(MR_HST_JOB_FAIL + sErro + '( Saving data to ' + Table + ' ) in TDMThread.ImportXMLFile');
        Result := False;
      end;
    finally
      fXMLToTable.UnloadData;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ReportError(E.Message + ' - ' + 'TableName: ' + Table + ' in TDMThread.ImportXMLFile');
    end;
  end;
end;

function TDMThread.ExeSingleReplication: Boolean;
begin

  Result := False;

  if OpenConnection then
  try

     FDBVersion := GetDatabaseVersion;

     //** Nao pode trabalhar com ini, pois uma thread pode salvar sobre o outro
     //fIniCustomersConfig.WriteString(Client, VERSION_STR, sVer);

     CreateDeletionTable(stMSSQL2000, ADODBConnect);

     //Criar o arquivos globais
     CreateGlobalFiles;

     //Importar os dados dos client
     Result := ImportStores;

     if Result and (not DisableUpdateQty) then
       UpdateTotQtyOnHand;

  finally
    CloseConnections;
    end;

end;

function TDMThread.ImportStores : Boolean;
var
  i, J : integer;
  sZipPath : String;
  stlDeletar: TStringList;
begin
  Result := True;
  ModifyAllConstraints(stMSSQL2000, ADODBConnect, False);
  try
    for i:=0 to StoreList.Count-1 do
      if not IsSessionToExclude(StoreList.Strings[i]) then
      begin
        sZipPath := LocalPath + Client + '\' + StoreList.Strings[i] + '\';

        if IsLocalLocked(Client, StoreList.Strings[i]) then
        begin
         ReportError(Format(MR_HST_JOB_FAIL + 'Local dir locked for %S - %S in DMThread.ImportStores', [Client, StoreList.Strings[i]]));
         Continue;
        end;

        try
         if FileExists(sZipPath + STORE_ZIP) then
           if CreateLocalLock(Client, StoreList.Strings[i]) then
             try
               // Deletar os XMLs antigos
               stlDeletar := TStringList.Create;
               try
                 stlDeletar.CommaText := StoreTables;
                 for J := 0 to stlDeletar.Count - 1 do
                   DeleteFile(sZipPath + stlDeletar[J] + '.xml');
               finally
                 stlDeletar.Free;
               end;

               //AddHistory('Importando ' + Client + ' - ' + sStoreList.Strings[i]);
               UnZipFile(sZipPath, sZipPath + STORE_ZIP);
               if ImportXML(Client, StoreList.Strings[i], FDBVersion, MainStore) then
                 begin
                    DeleteReplFile(sZipPath + STORE_ZIP);
                    DeleteReplFile(sZipPath + ALL_XML);
                 end
               else
                 begin
                   Result := False;
                   Exit;
                 end;
             finally
               RemoveLocalLock(Client, StoreList.Strings[i]);
             end
           else
             ReportError(Format(MR_HST_JOB_FAIL + 'Could not create global file lock for %S - %S in DMThread.ImportStores', [Client, StoreList.Strings[i]]))
         else
           AddHistory(MR_HST_LOCAL_FILE_NOT_FOUND + ': ' + sZipPath + STORE_ZIP);
        finally
        end;
        end;

  finally
    ModifyAllConstraints(stMSSQL2000, ADODBConnect, True);
    end;

end;

function TDMThread.IsSessionToExclude(S: String): Boolean;
begin
  Result := (S = DISABLESCHEDULE_STR) or (S = CONNECTION_STR) or (S = VERSION_STR) or
            (S = REPSINCE_STR) or (S = DISABLESCHEDULE_STR) or
            (S = MAINSTORE_STR) or (S = SERVER_TYPE_STR) or
            (S = FILE_SERVER_HOST_STR) or (S = FILE_SERVER_PORT_STR) or
            (S = AUTH_STORE_NAME_STR) or  (S = AUTH_PACKET_SIZE_STR) or
            (S = AUTH_PASSWORD_STR) or (S = SCHEDULE_STR) or
            (S = AUTH_CRIPTO_STR);
end;


function TDMThread.CreateGlobalFiles : Boolean;
begin

  Result := False;

  If not DirectoryExists(LocalPath + Client + '\' + SUBDIR_GLOBAL) Then
    ForceDirectories(LocalPath + Client + '\' + SUBDIR_GLOBAL);

  if IsGlobalLocked(Client) then
    ReportError(Format(MR_HST_JOB_FAIL + 'Global file locked for %S in TMDThread.CreateGlobalFiles', [Client]))
  else
    begin
      if CreateGlobalLock(Client) then
        try
          ExportXML(Client, RepSince, FDBVersion); // *** Exporta o Global ***
          Result := True;
        finally
          RemoveGlobalLock(Client);
          Sleep(0);
        end
      else
        ReportError(Format(MR_HST_JOB_FAIL + 'Could not create global file lock for %S in TMDThread.CreateGlobalFiles', [Client]));
    end;
end;

function TDMThread.OpenConnection: Boolean;
begin
  try
    ADODBConnect.Open;
    Result := True;
  except
    on E: Exception do
      begin
        ReportError('Error : ' + E.Message + ' in TDMThread.OpenConnection');
        Result := False;
      end;
  end;
end;

function TDMThread.ExportXML(Client: String; ReplicateSince: Integer;
  DatabaseVersion: String): Boolean;
var
  stlGlobalTables,
  stlExceptTables : TStringlist;
  I : Integer;
  sGlobalDir : String;
  bSuccess: Boolean;
  sXMLVersion: String;
begin
  Result := True;
  sGlobalDir := LocalPath + Client + '\' + SUBDIR_GLOBAL;

  sXMLVersion := GenerateXMLVersionControl(DatabaseVersion, NOW);

  CreateGenericVersionedFile(sGlobalDir + GetGlobalVersionFileName(Client), DatabaseVersion);

  try

    If Not DirectoryExists(sGlobalDir) Then
      ForceDirectories(sGlobalDir);

    stlGlobalTables := TStringlist.Create;
    try
      stlGlobalTables.CommaText := GlobalTables;

      stlExceptTables := TStringlist.Create;
      try
         stlExceptTables.CommaText := ExcepTables;
         stlGlobalTables.AddStrings(stlExceptTables);
      finally
         FreeAndNil(stlExceptTables);
      end;

      bSuccess := True;

      for I := 0 To stlGlobalTables.Count -1 do
      begin
        bSuccess := bSuccess and ExportXMLFile(sGlobalDir, stlGlobalTables[I], ReplicateSince, '');
        if not bSuccess then
          Break;
      end;

      if bSuccess then
        ZipFile(sGlobalDir + ALL_XML, sGlobalDir + GLOBAL_ZIP_FILE)
      else
        DeleteReplFile(sGlobalDir + GetGlobalVersionFileName(Client));

      for I := 0 To stlGlobalTables.Count -1 do
        DeleteReplFile(sGlobalDir + stlGlobalTables[I]+EXT_XML);

      Result := Result and bSuccess;

    finally
      FreeAndNil(stlGlobalTables);
    end;
  except
    on E: Exception do
    begin
      ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMThread.ExportXML');
      Result := False;
    end;
  end;
end;

function TDMThread.ImportXML(Client, Store, DatabaseVersion: String;
  IDServerStore: Integer): Boolean;
var
  stlStoreTables,
  stlExceptTables : TStringlist;
  I : Integer;
  sClientDir : String;
begin
  Result := True;
  try
    sClientDir := LocalPath + Client + '\' + Store + '\';

    if not CheckXMLVersion(sClientDir + GetLocalVersionFileName(Client, Store), DatabaseVersion) then
    begin
      Result := False;
      Exit;
    end;

    stlStoreTables  := TStringlist.Create;

    try
      stlStoreTables.CommaText := StoreTables;
      for I := 0 To stlStoreTables.Count -1 do
          ImportXMLFile(stlStoreTables[I], sClientDir + stlStoreTables[I] + EXT_XML, '', SQLBatchCount);
    finally
      FreeAndNil(stlStoreTables);
    end;

    stlExceptTables := TStringlist.Create;
    try
      stlExceptTables.CommaText := ExcepTables;
      for I := 0 To stlExceptTables.Count -1 do
      if stlExceptTables[I] = 'Inventory' then
        ImportXMLFile(stlExceptTables[I], sClientDir + stlExceptTables[I]+EXT_XML, Format('StoreID <> %D', [IDServerStore]), SQLBatchCount)
      else if stlExceptTables[I] = 'Pet' then
        ImportXMLFile(stlExceptTables[I], sClientDir + stlExceptTables[I]+EXT_XML, Format('IDStore <> %D', [IDServerStore]), SQLBatchCount)
    finally
      FreeAndNil(stlExceptTables);
    end;

    Result := UpdatePetLocation;
    if not Result then
       Exit;

  except
    on E: Exception do
    begin
      ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMThread.ImportXML');
      Result := False;
    end;
  end;
end;

procedure TDMThread.DataModuleCreate(Sender: TObject);
begin
  //  Passar fLocalPath na hora da criação

  fXMLToTable := TXMLToTable.Create(self);
  fTableToXML := TTableToXML.Create(self);

  fXMLToTable.Connection := ADODBConnect;
  fTableToXML.Connection := ADODBConnect;

  FStoreList := TStringList.Create;

end;


procedure TDMThread.DataModuleDestroy(Sender: TObject);
begin
  fXMLToTable.free;
  fTableToXML.free;
  //FreeAndNil(fXMLToTable);
  //FreeAndNil(fTableToXML);
  FreeAndNil(FStoreList);
end;

end.
