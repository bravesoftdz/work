unit uDMClientThread;

interface

uses
  Windows, SysUtils, Classes, ADODB, AbUnzper, AbBase, AbBrowse, AbZBrows, AbZipper,
  DB, uFrmServerInfo, uSQLObj, uReplicationClasses, registry, DBClient,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP, ActiveX;


const
  MR_HST_OK            = 'Replication succeed. ';
  MR_HST_ERROR         = 'Replication error: ';
  MR_HST_CONT_FAIL     = 'Local Connection fail. ';
  MR_HST_SVR_CONT_FAIL = 'Server Connection fail. ';
  MR_HST_JOB_FAIL      = 'Job fail : ';
  MR_HST_VPN_FAIL      = 'VPN fail to connect.';

  GLOBAL_ZIP_FILE      = 'global.zip';
  LOCAL_ZIP_FILE       = 'local.zip';
  HISTORY_FILE         = 'history.txt';
  ERROR_FILE           = 'error.txt';
  MR_SYSTEM_TIP        = 'MainRetail replication monitor';

  REG_PATH             = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

  ALL_XML              = '*.xml';
  EXT_XML              = '.xml';

  CONST_CLIENT = 'reptest';
  CONST_STORE  = 'repcli';



  CONFIG_FILE    = 'localconfig.ini';

  WHERE_STOREID = 1;
  WHERE_IDSTORE = 2;

  MR_HST_GLOBAL_FILE_NOT_FOUND  = 'Global file not found. ';

  SV_CONNECTION = '#CNT#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_CLOSE_VPN  = '#CVPN#=';


  SUBDIR_LOCAL  = 'out\';
  SUBDIR_GLOBAL = 'global\';

  CI_NOMECLIENTE  = '#NOMECLIENTE#=';
  CI_NOMELOJA     = '#NOMELOJA#=';
  CI_VERSAO       = '#VERSAO#=';
  CI_PACKETSIZE   = '#PACKETSIZE#=';
  CI_SENHA        = '#SENHA#=';
  CI_HOST         = '#HOST#=';
  CI_PORT         = '#PORT#';

type
  TDMClientThread = class(TDataModule)
    Zipper: TAbZipper;
    UnZipper: TAbUnZipper;
    spRecalcTotal: TADOStoredProc;
    IdFTP1: TIdFTP;
    ADODBConnect: TADOConnection;
    quUpdatePet: TADOCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  protected
    FrmServrInfo : TFrmServerInfo;
    fSQLSvrConnectParam : TSQLConnection;
    fXMLToTable : TXMLToTable;
    fTableToXML: TTableToXML;

  private
    fLocalPath: String;
    FGlobalTables: String;
    FSQLBatchCount: Integer;
    FExceptTables: String;
    FLocalTables: String;
    FReplicateSince: Integer;
    FClientInfo: String;
    FHost: String;
    FDefaultStore: Integer;
    FThread: TThread;
    FExceptFields: String;
    FInsertTables: String;
    FDisableUpdateQty: Boolean;
    procedure ConfigureFTP;
    function GetClient: String;
    function GetFTPGlobalDir(AClient: String): String;
    function GetFTPLocalDir(AClient, AStore: String): String;
    function GetGlobalFile: Boolean;
    function GetStore: String;
    function RunFTP: Boolean;
    function SendLock(LockFileName: String): Boolean;
    function ValidateFTPGlobalVersion(AFile, AVersion: String): Boolean;

    function WhereToExport(ATableToExport: String; AIDStore: Integer): String;
    function WhereToImport(ATableToExport: String; AIDStore: Integer; Inverse: Boolean = False): String;
    function ExportXMLFile(ExportPath, Table: String; RepSince: Integer;
      Where: String): Boolean;
    function ImportXMLFile(Table, FileName, Where: String;
      SQLBatchCount: Integer): Boolean;
    function getConectionString(StrartType: Char; IsError: Boolean;
      sMSG: String; var bAbort: Boolean): String;
    procedure FireReplStatus(Msg: String; Count: Integer);
    procedure FireReplStepComplete;
    function GetTableWhereField(ATablename: String): String;
    function UpdatePetLocation(Conn: TADOConnection): Boolean;
    { Private declarations }
  public
    { Public declarations }

    property LocalPath           : String read fLocalPath write fLocalPath;
    property GlobalTables : String read FGlobalTables write FGlobalTables;
    property SQLBatchCount: Integer read FSQLBatchCount write FSQLBatchCount;
    property ExceptTables: String read FExceptTables write FExceptTables;
    property ExceptFields: String read FExceptFields write FExceptFields;
    property InsertTables: String read FInsertTables write FInsertTables;
    property LocalTables: String read FLocalTables write FLocalTables;
    property ReplicateSince: Integer read FReplicateSince write FReplicateSince;
    property ClientInfo: String read FClientInfo write FClientInfo;
    property Host: String read FHost write FHost;
    property DefaultStore: Integer read FDefaultStore write FDefaultStore;
    property DisableUpdateQty : Boolean read FDisableUpdateQty write FDisableUpdateQty;

    property Thread: TThread read FThread write FThread;


    procedure ReportError(sText:String);
    function LoadErrorFile:String;
    procedure AddHistory(Text: String);
    procedure AddErrorHistory(Text: String);
    //Connection
    procedure CloseConnection;
    function OpenConnection:Boolean;
    function FomartConnection(sParam:String):String;
    //Zip
    procedure ZipFile(FilesToZip, ZipFileName: String);
    procedure UnZipFile(DestDir, ZipFileName: String);
    //delete File
    procedure DeleteReplFile(sFileName : String);
    //XML File
    // Version
    function GetDatabaseVersion(AConn: TADOConnection): String;

    function GenerateXMLVersionControl(AVersion: String;
      AHora: TDateTime): String;

    function CheckXMLVersion(FileName,
      DatabaseVersion: String): Boolean; overload;

    function CheckXMLVersion(AStream: TStream;
      DatabaseVersion : String): Boolean; overload;

    function GetGlobalLockFileName(AClient: String): String;
    function GetLocalLockFileName(AClient, AStore: String): String;
    function GetGlobalVersionFileName(AClient: String): String;
    function GetLocalVersionFileName(AClient, AStore: String): String;

    function UpdateTotQtyOnHand(Conn: TADOConnection): Boolean;

    function CreateGenericVersionedFile(AFileName: String; AVersion: String = 'NOCONTROL'): Boolean;

    function ImportXML:Boolean;
    function ExportXML:Boolean;

    procedure ExecuteReplication;

  end;

var
  DMClientThread: TDMClientThread;

implementation

uses uParamFunctions, uSaveToFile, uFileFunctions, uSystemConst, uEncryptFunctions, tExecuteTask,
  Math;

{$R *.dfm}


procedure TDMClientThread.DeleteReplFile(sFileName: String);
begin
   //delete File
   if FileExists(sFileName) then
      DeleteFile(sFileName);
end;


procedure TDMClientThread.UnZipFile(DestDir, ZipFileName: String);
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
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMClientThread.UnZipFile');
  end;
end;


procedure TDMClientThread.ZipFile(FilesToZip, ZipFileName: String);
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
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMClientThread.ZipFile');
  end;
end;


function TDMClientThread.OpenConnection:Boolean;
var
  sResult : String;
  b : Boolean;
begin
  CoInitialize(nil);
   //Connection open, exit
  if ADODBConnect.Connected then
     begin
     Result := True;
     Exit;
     end;


   //Server Connection
   b := False;
   Result := False;
   //FrmServrInfo.RegistryKey := sType; //Save connection to registry key
   sResult := getConectionString('4', False, '', b);

   While not b do
      try
        sResult := FomartConnection(sResult);
        ADODBConnect.ConnectionString := sResult;
        ADODBConnect.Open;
        b := True;
        Result := True;
      except
        on E: Exception do
        begin
           sResult := FrmServrInfo.Start('4', True, E.Message, b);
           ReportError('Error: ' + E.Message + ' in TDMClientThread.OpenConnection');
        end;
      end;

end;


procedure TDMClientThread.CloseConnection;
begin
  if ADODBConnect.Connected then
     ADODBConnect.Close;
end;

function TDMClientThread.LoadErrorFile:String;
var
 textFile:TStringList;
begin
  if FileExists(LocalPath+ERROR_FILE) then
     try
       textFile := TStringlist.create;
       textFile.LoadFromFile(LocalPath+ERROR_FILE);
       Result := textFile.Text;
     finally
       FreeAndNil(textFile);
     end;
end;

procedure TDMClientThread.AddHistory(Text:String);
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

procedure TDMClientThread.AddErrorHistory(Text:String);
var
  fFile : TSaveFile;
begin
  //fIniConfig.WriteBool('Settings','Error', True);
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

procedure TDMClientThread.ReportError(sText:String);
begin
  //Register Error history
  AddHistory(sText);
  AddErrorHistory(sText);
end;

function TDMClientThread.FomartConnection(sParam: String): String;
var
  sServer, sDBAlias, sUserName, sPW : String;
  bWinLogin, bUseNetLib : Boolean;
begin

  sServer    := ParseParam(sParam, SV_SERVER);
  sDBAlias   := ParseParam(sParam, SV_DATABASE);
  sUserName  := ParseParam(sParam, SV_USER);
  sPW        := ParseParam(sParam, SV_PASSWORD);
  bWinLogin  := (ParseParam(sParam, SV_WIN_LOGIN)[1] in ['Y']);
  bUseNetLib := (ParseParam(sParam, SV_USE_NETLIB)[1] = 'Y');

  if not bWinLogin then
     if bUseNetLib then
        Result := SetConnectionStr(sUserName, sPW, sDBAlias, sServer)
     else
        Result := SetConnectionStrNoNETLIB(sUserName, sPW, sDBAlias, sServer)
  else
     if bUseNetLib then
        Result := SetWinConnectionStr(sDBAlias, sServer)
     else
        Result := SetWinConnectionStrNoNETLIB(sDBAlias, sServer);

  Result := result + 'Application Name=MRREPLICATION;';
end;

function TDMClientThread.GetDatabaseVersion(AConn: TADOConnection) : String;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := AConn;
    SQL.Text   := 'SELECT VersionNo, BuildNo FROM Sys_Module';
    Open;
    Result     := FieldByName('VersionNo').AsString  + FieldByName('BuildNo').AsString;
  finally
    Close;
    Free;
  end;
end;


function TDMClientThread.GenerateXMLVersionControl(AVersion: String; AHora: TDateTime): String;
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

function TDMClientThread.CheckXMLVersion(Filename, DatabaseVersion : String): Boolean;
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

function TDMClientThread.CheckXMLVersion(AStream: TStream; DatabaseVersion : String): Boolean;
var
  cdsXML: TClientDataSet;
begin
  try
    cdsXML := TClientDataSet.Create(nil);
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

function TDMClientThread.GetGlobalLockFileName(AClient: String): String;
begin
  Result := Format('lck-global@%S.lck', [LowerCase(AClient)]);
end;

function TDMClientThread.GetGlobalVersionFileName(AClient: String): String;
begin
  Result := 'ver-global@' + LowerCase(AClient) + '.xml';
end;


function TDMClientThread.GetLocalVersionFileName(AClient, AStore: String): String;
begin
  Result := Format('ver-%S@%S.xml', [LowerCase(AStore), LowerCase(AClient)])
end;



function TDMClientThread.GetLocalLockFileName(AClient, AStore: String): String;
begin
  Result := Format('lck-%S@%S.lck', [LowerCase(AStore), LowerCase(AClient)]);
end;

function TDMClientThread.UpdateTotQtyOnHand(Conn: TADOConnection): Boolean;
begin
  Result := True;
  try
    spRecalcTotal.Connection := Conn;
    spRecalcTotal.ExecProc;
  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMClientThread.UpdateTotQtyOnHand');
        Result := False;
      end;
  end;
end;

function TDMClientThread.UpdatePetLocation(Conn: TADOConnection): Boolean;
begin
  Result := True;
  try
    quUpdatePet.Connection := Conn;
    quUpdatePet.Execute;
  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMClientThread.UpdatePetLocation');
        Result := False;
      end;
  end;
end;


function TDMClientThread.CreateGenericVersionedFile(AFileName: String; AVersion: String = 'NOCONTROL'): Boolean;
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
      ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMServer.CreateGenericVersionedFile');
      Result := False;
    end;
  end;
end;


function TDMClientThread.ImportXML:Boolean;
var
  stlGlobalTables,
  stlExceptTables : TStringlist;
  I : Integer;
  sGlobalFilePath : String;
  stlDelete: TStringList;
  stlInsertTables: TStringList;
begin
  Result := False;
  try
    sGlobalFilePath := LocalPath+SUBDIR_GLOBAL;

    if not DirectoryExists(sGlobalFilePath) then
       CreateDir(sGlobalFilePath);


    stlDelete := TStringList.Create;
    try
      stlDelete.CommaText := fGlobalTables;
      for I := 0 to stlDelete.Count - 1 do
        DeleteFile(sGlobalFilePath + stlDelete[I] + '.xml');
    finally
      stlDelete.Free;
    end;


    if FileExists(sGlobalFilePath+GLOBAL_ZIP_FILE) then
       begin
       UnZipFile(ExtractFilePath(sGlobalFilePath+GLOBAL_ZIP_FILE), sGlobalFilePath+GLOBAL_ZIP_FILE);
       DeleteReplFile(sGlobalFilePath+GLOBAL_ZIP_FILE);
       end
    else
       begin
       AddHistory(MR_HST_GLOBAL_FILE_NOT_FOUND+': '+sGlobalFilePath+GLOBAL_ZIP_FILE);
       Exit;
       end;

    if not CheckXMLVersion(sGlobalFilePath + GetGlobalVersionFileName(GetClient), GetDatabaseVersion(ADODBConnect)) then
      raise Exception.Create('Invalid Global Files Version');


    try

      ModifyAllConstraints(stMSSQL2000, ADODBConnect, False);
      fXMLToTable.JustInsert  := False;

      stlGlobalTables := TStringlist.Create;
      try
        stlGlobalTables.CommaText := fGlobalTables;

        FireReplStatus('Importing global tables ...',stlGlobalTables.Count);

        for I := 0 To stlGlobalTables.Count -1 do
          begin
          ImportXMLFile(stlGlobalTables[I], sGlobalFilePath + stlGlobalTables[I]+'.xml', '', FSQLBatchCount);

          FireReplStepComplete;

          end;
      finally
        freeAndNil(stlGlobalTables);
      end;

      if not FDisableUpdateQty then
      begin
        FireReplStatus('Updating Qty On Hand ...', 0);
        if not UpdateTotQtyOnHand(ADODBConnect) then
           Exit;
      end;

      stlExceptTables := TStringlist.Create;
      try
        stlExceptTables.CommaText := fExceptTables;

        FireReplStatus('Importing exception tables ...',stlExceptTables.Count);

        for I := 0 To stlExceptTables.Count -1 do
          begin
            ImportXMLFile(stlExceptTables[I], sGlobalFilePath + stlExceptTables[I]+'.xml', WhereToImport(stlExceptTables[I], DefaultStore), FSQLBatchCount);
            FireReplStepComplete;
          end;
      finally
        freeAndNil(stlExceptTables);
      end;

      FireReplStatus('Updating Pet Location ...', 0);


      if not UpdatePetLocation(ADODBConnect) then
         Exit;


      //                                                //
      // Removido para adicionar a transferencia de Pet //
      //                                                //
      (*
      stlInsertTables := TStringlist.Create;
      try
        stlInsertTables.CommaText := FInsertTables;

        fXMLToTable.JustInsert  := True;

        FireReplStatus('Importing insert tables ...',stlInsertTables.Count);

        for I := 0 To stlInsertTables.Count -1 do
          begin
            ImportXMLFile(stlInsertTables[I], sGlobalFilePath + stlInsertTables[I]+'.xml', WhereToImport(stlInsertTables[I], DefaultStore, True), FSQLBatchCount);
            FireReplStepComplete;
          end;
      finally
        freeAndNil(stlInsertTables);
      end;
      *)



      Result := True;
    finally
      ModifyAllConstraints(stMSSQL2000, ADODBConnect, True);
    end;
  except
    on E: Exception do
    begin
      ReportError(MR_HST_JOB_FAIL + E.Message);
      Result := False;
    end;
  end;
end;


function TDMClientThread.ExportXML:Boolean;
var
  stlLocalTables,
  stlExceptTables : TStringlist;
  i : Integer;
  sStoreDirPath, sVer : String;
  bSuccess: Boolean;
begin
  Result := True;

  try
    sStoreDirPath   := LocalPath + SUBDIR_LOCAL;
    sVer := GetDatabaseVersion(ADODBConnect);

    if not DirectoryExists(sStoreDirPath) then
       CreateDir(sStoreDirPath);

    stlLocalTables := TStringlist.Create;
    try
      stlLocalTables.CommaText := FLocalTables;
      stlExceptTables          := TStringlist.Create;
      try
        stlExceptTables.CommaText := FExceptTables;

        bSuccess := True;

        if FileExists(sStoreDirPath+'local.zip') then
          DeleteReplFile(sStoreDirPath+'local.zip');


        //CreateDeletionTable(stMSSQL2000, ADODBConnect);

        FireReplStatus('Exporting local tables ...',stlLocalTables.Count);

        for I := 0 To stlLocalTables.Count - 1 do
        begin
          bSuccess := bSuccess and ExportXMLFile(sStoreDirPath, stlLocalTables[i], FReplicateSince,'');
          FireReplStepComplete;
          if not bSuccess then
             Break;
        end;

        CreateGenericVersionedFile(sStoreDirPath + GetLocalVersionFileName(GetClient, GetStore), sVer);

        if bSuccess then
           begin
           FireReplStatus('Exporting exception tables ...',stlExceptTables.Count);
           for I := 0 To stlExceptTables.Count - 1 do
             begin
               bSuccess := bSuccess and ExportXMLFile(sStoreDirPath, stlExceptTables[i], FReplicateSince, WhereToExport(stlExceptTables[i], DefaultStore));
               FireReplStepComplete;
             if not bSuccess then
                Break;
             end;
           end;

        if bSuccess then
           begin

           FireReplStatus('Zipping files ...',0);

           ZipFile(sStoreDirPath + ALL_XML, sStoreDirPath + 'local.zip');
           end;


        FireReplStatus('Deleting temp files ...',stlLocalTables.Count);

        for I := 0 To stlLocalTables.Count -1 do
          begin
          DeleteReplFile(sStoreDirPath + stlLocalTables[I]+'.xml');
          FireReplStepComplete;
          end;

        FireReplStatus('Deleting temp files ...',stlExceptTables.Count);

        for I := 0 To stlExceptTables.Count - 1 do
          begin
          DeleteReplFile(sStoreDirPath + stlExceptTables[I]+'.xml');
          FireReplStepComplete;
          end;

      finally
        FreeAndNil(stlExceptTables);
      end;
    finally
      FreeAndNil(stlLocalTables);
    end;

    Result := Result and bSuccess;

  except
    on E: Exception do
    begin
      ReportError(MR_HST_JOB_FAIL + E.Message);
      Result := False;
    end;
  end;

end;


procedure TDMClientThread.ConfigureFTP;
var
  sConnection,
  AClient,
  AStore,
  APassword: String;
begin
  if IdFTP1.Connected then
    IdFTP1.Disconnect;


  sConnection := DecodeServerInfo(ClientInfo, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);
  AClient     := ParseParam(sConnection, CI_NOMECLIENTE);
  AStore      := ParseParam(sConnection, CI_NOMELOJA);
  APassword   := ParseParam(sConnection, CI_SENHA);



  IdFTP1.Host      := FHost;
  IdFTP1.Username  := LowerCase(Format('%S.%S', [AStore, AClient]));
  IdFTP1.Password  := APassword;
end;


function TDMClientThread.GetClient: String;
var
  sConnection: String;
begin
  sConnection := DecodeServerInfo(ClientInfo, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);
  Result      := ParseParam(sConnection, CI_NOMECLIENTE);
end;


function TDMClientThread.GetStore: String;
var
  sConnection: String;
begin
  sConnection := DecodeServerInfo(ClientInfo, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);
  Result      := ParseParam(sConnection, CI_NOMELOJA);
end;


function TDMClientThread.GetFTPGlobalDir(AClient: String): String;
begin
  Result := LowerCase(Format('/%S/global/', [AClient]));
end;

function TDMClientThread.GetFTPLocalDir(AClient, AStore: String): String;
begin
  Result := LowerCase(Format('/%S/%S/', [AClient, AStore]));
end;


function TDMClientThread.RunFTP: Boolean;
var
  sFTPGlobalLock,
  sFTPLocalLock: String;
  sClient: String;
  sGlobalDir: String;
  sStore: String;
begin
  Result := True;
  try
    (* Progress
    ResetInfo;
    *)

    FireReplStatus('Sending and Receiving data ...', 0);



    ConfigureFTP;

    sFTPGlobalLock := GetLocalLockFileName(GetClient, GetStore);

    AddHistory('Connecting to FTP');
    IdFTP1.Connect(False);
    try
      IdFTP1.Login;
      AddHistory('Connected and logged in');

      if not IdFTP1.Connected then
        Exit;

      // Obtem o global.zip
      AddHistory('Parsing client info');
      sClient := GetClient;
      AddHistory('Parsing Global dir info');
      sGlobalDir := GetFTPGlobalDir(sClient);
      AddHistory('Changing Current dir to Global dir');
      IdFTP1.ChangeDir(sGlobalDir);
      AddHistory('Looking for Global lock file');
      if IdFTP1.Size(GetGlobalLockFileName(sClient)) <> -1 then
        begin
          //raise Exception.Create('Global File is locked');
          AddErrorHistory('Global File is locked on TFrmMain.RunFTP');
        end
      else
        begin
          AddHistory('Sending Global lock file');
          Result := SendLock(sFTPGlobalLock);
          if not Result then
            raise Exception.Create('Could not send global lock');
          try
            AddHistory('Verifying global files version');
            FireReplStatus('Verifying global files version ...', 0);

            if not ValidateFTPGlobalVersion(GetGlobalVersionFileName(GetClient), GetDatabaseVersion(ADODBConnect)) then
              raise Exception.Create('Invalid Global File Version');

            AddHistory('Getting global file');
            FireReplStatus('Getting global files ...', 0);

            GetGlobalFile;
          finally
            AddHistory('Removing Global lock');
            IdFTP1.Delete(sFTPGlobalLock);
          end;
        end;

      sFTPLocalLock := GetLocalLockFileName(sClient, GetStore);

      // Envia o local.zip
      AddHistory('Parsing store info');
      sStore := GetStore;
      AddHistory('Changing Current dir to store dir');
      IdFTP1.ChangeDir(GetFTPLocalDir(sClient, sStore));
      AddHistory('Looking for Store lock file');
      if IdFTP1.Size(GetGlobalLockFileName(sClient)) <> -1 then
        raise Exception.Create('Local File is locked');
      AddHistory('Sending Store lock file');
      Result := SendLock(sFTPLocalLock);
      if not Result then
        Exit;
      try
        AddHistory('Sending local files');
        FireReplStatus('Sending local file ...', 0);

        IdFTP1.Put(LocalPath + SUBDIR_LOCAL + LOCAL_ZIP_FILE, LOCAL_ZIP_FILE);
      finally
        AddHistory('Removing Store lock');
        IdFTP1.Delete(sFTPLocalLock);
      end;
    finally
      AddHistory('Disconnecting FTP');
      IdFTP1.Disconnect;
    end;

  except
    on E: Exception do
    begin
      AddErrorHistory(E.Message + ' on TFrmMain.RunFTP');
      Result := False;
    end;
  end;
end;

function TDMClientThread.ValidateFTPGlobalVersion(AFile: String; AVersion: String): Boolean;
var
  MS: TMemoryStream;
begin
  try
    MS := TMemoryStream.Create;
    try
      IdFTP1.Get(AFile, MS);
      Result := CheckXMLVersion(MS, AVersion);
    finally
      MS.Free;
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(E.Message + ' on TFrmMain.ValidateFTPGlobalVersion');
      Result := False;
    end;
  end;
end;

function TDMClientThread.SendLock(LockFileName: String): Boolean;
var
  MS : TMemoryStream;
  Lista: TStringList;
begin
  Result := True;
  try
    MS := TMemoryStream.Create;
    try
      Lista := TStringList.Create;
      try
        Lista.Add(GenerateXMLVersionControl('NOCONTROL', NOW));
        Lista.SaveToStream(MS);
      finally
        Lista.Free;
      end;
      IdFTP1.Put(MS, LockFileName, False);
    finally
      MS.Free;
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(E.Message + ' on TFrmMain.SendGlobalLock');
      Result := False;
    end;
  end;
end;


function TDMClientThread.GetGlobalFile: Boolean;
var
  MS: TMemoryStream;
begin
  //    A T E N Ç A O   ! ! !
  // Nao tente otimizar essa rotina colocando para baixar o arquivo diretamente,
  // pois assim, mesmo se ele nao existir no lado do servidor será criado
  // um arquivo vazio no cliente

  Result := True;
  try
    MS := TMemoryStream.Create;
    try
      IdFTP1.Get(GLOBAL_ZIP_FILE, MS);
      MS.Seek(0, soFromBeginning);

      MS.SaveToFile(LocalPath + SUBDIR_GLOBAL + GLOBAL_ZIP_FILE);
      MS.Clear;
    finally
      MS.Free;
    end;
  except
    on E: Exception do
    begin
      AddErrorHistory(E.Message + ' on TFrmMain.GetGlobalFile');
      Result := False;
    end;
  end;
end;

function TDMClientThread.GetTableWhereField(ATablename: String): String;
var
  stlFields: TStringList;
begin
  stlFields := TStringList.Create;
  try
    stlFields.CommaText := FExceptFields;
    Result := stlFields.Values[ATablename];
    if Result = '' then
       Result := 'IDStore';
  finally
    stlFields.Free;
  end;
end;

function TDMClientThread.WhereToExport(ATableToExport: String; AIDStore: Integer): String;
begin
  Result := GetTableWhereField(ATableToExport) + ' = ' + IntToStr(AIDStore);
end;

function TDMClientThread.WhereToImport(ATableToExport: String; AIDStore: Integer; Inverse: Boolean = False): String;
begin
  if Inverse then
    Result := GetTableWhereField(ATableToExport) + ' = ' + IntToStr(AIDStore)
  else
    Result := GetTableWhereField(ATableToExport) + ' <> ' + IntToStr(AIDStore);
end;

Procedure TDMClientThread.ExecuteReplication;
var
  bResult : Boolean;
begin
  if not OpenConnection then Exit;

  (* Progress
  SchedulePrepareInfo;
  *)
  try
    CreateDeletionTable(stMSSQL2000, ADODBConnect);

    bResult := ExportXML;
    if bResult then
    begin
       bResult := RunFTP;
       (*
       bResult := RunSocket;
       *)
    end;

    //  Reabilitar para teste real
    if bResult then
       bResult := ImportXML;

(*

    if bResult then
    begin
      FireReplStatus('Updating Qty On Hand ...', 0);
      bResult := UpdateTotQtyOnHand(ADODBConnect);
    end;
*)

    if bResult then
       begin
       AddHistory(MR_HST_OK);
       (* Progress
       SaveNextSchedule;
       *)
       end;
  finally
    (* Progress
    UnPrepareInfo;
    *)
  end;
end;

function TDMClientThread.ExportXMLFile(ExportPath,Table: String; RepSince:Integer; Where:String): Boolean;
var
  sErro : String;
begin
   Result := True;
   sErro := '';

   if (Table = '') then
      Exit;

   try
     try
       fTableToXML.ReplicateSince    := RepSince;
       fTableToXML.SelectWhereClause := Where;
       fTableToXML.TableName         := Table;
     except
       on E: Exception do
       begin
         ReportError(MR_HST_JOB_FAIL + E.Message);
         Result := False;
         Exit;
       end;
     end;

     sErro := fTableToXML.SaveToXML(ExportPath + Table);
     if sErro <> '' then
     begin
       ReportError(MR_HST_JOB_FAIL + sErro);
       Result := False;
     end;
   finally
     fTableToXML.UnloadData;
   end;
end;

function TDMClientThread.ImportXMLFile(Table, FileName, Where: String; SQLBatchCount : Integer): Boolean;
var
  sErro : String;
begin
  Result := True;
  sErro := '';

  if ((FileName = '') or (Table = '')) or
     (not FileExists(FileName)) then
     Exit;

  try
    fXMLToTable.SQLBatchCount     := SQLBatchCount;
    fXMLToTable.SelectWhereClause := Where;
    sErro := fXMLToTable.LoadDataFromXML(FileName);

    if sErro <> '' then
    begin
      ReportError(MR_HST_JOB_FAIL + sErro);
      Result := False;
      Exit;
    end;

   fXMLToTable.TableName := Table;

   sErro := fXMLToTable.SaveDataToTable(Table);
   if sErro <> '' then
    begin
      ReportError(MR_HST_JOB_FAIL + sErro);
      Result := False;
    end;
  finally
    fXMLToTable.UnloadData;
  end;

end;

procedure TDMClientThread.DataModuleCreate(Sender: TObject);
begin
  fSQLSvrConnectParam    := TSQLConnection.Create;
  fXMLToTable            := TXMLToTable.Create(Self);
  fTableToXML            := TTableToXML.Create(Self);

  fXMLToTable.Connection := ADODBConnect;
  fTableToXML.Connection := ADODBConnect;

  // Abre o registry
  with TRegistry.Create do
  begin
     RootKey := HKEY_LOCAL_MACHINE;
     OpenKey(REGISTRY_PATH, True);
     if not ValueExists('DefaultLanguage') then
        WriteInteger('DefaultLanguage', LANG_ENGLISH);
     //DMGlobal.IDLanguage := ReadInteger('DefaultLanguage');
     Free;
  end;
end;

procedure TDMClientThread.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fSQLSvrConnectParam);
  FreeAndNil(FrmServrInfo);
  FreeAndNil(fXMLToTable);
  FreeAndNil(fTableToXML);
end;




function TDMClientThread.getConectionString(StrartType:Char; IsError:Boolean; sMSG:String; var bAbort:Boolean):String;
const
  fRegistryKey = 'ServerInfo';
var
  sPW, sUser, sDBAlias, sServer, sWinLogin, sLib : String;
  Reg : TRegistry;
begin

  Reg    := nil;
  bAbort := False;
  Result := SV_SERVER   +'(local);'+
            SV_DATABASE +'MainRetailDB;'+
            SV_USER     +'mruser;'+
            SV_PASSWORD +'mruser2000;'+
            SV_WIN_LOGIN+'N;'+
            SV_USE_NETLIB+'N;';

  Try
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.OpenKey('SOFTWARE\AppleNet', True);

      if IsError then
         if sMSG <> '' then
            begin
            end;

      if not Reg.ValueExists(fRegistryKey) then
         begin
         Reg.WriteString(fRegistryKey, EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));
         IsError := True;
         end;

      Result := DecodeServerInfo(Reg.ReadString(fRegistryKey), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

      (*

      edtServer.Text    := ParseParam(Result, SV_SERVER);
      edtDatabase.Text  := ParseParam(Result, SV_DATABASE);
      edtUser.Text      := ParseParam(Result, SV_USER);
      edtPassword.Text  := ParseParam(Result, SV_PASSWORD);
      rbSQL.Checked     := (ParseParam(Result, SV_WIN_LOGIN)='N');
      chkUseLib.Checked := (ParseParam(Result, SV_USE_NETLIB)='Y');
      LoginControls;

      *)

      if not ((StrartType in ['1','2','3','4']) and (IsError)) then
         Exit;


      //Encriptografar os dados;
      sServer   := SV_SERVER   +ParseParam(Result, SV_SERVER)  +';';
      sDBAlias  := SV_DATABASE +ParseParam(Result, SV_DATABASE)+';';
      sUser     := SV_USER     +ParseParam(Result, SV_USER)    +';';
      sPW       := SV_PASSWORD +ParseParam(Result, SV_PASSWORD)+';';
      if ParseParam(Result, SV_WIN_LOGIN)='Y' then
         sWinLogin := SV_WIN_LOGIN + 'Y;'
      else
         sWinLogin := SV_WIN_LOGIN + 'N;';

      if (ParseParam(Result, SV_USE_NETLIB)='Y') then
         sLib := SV_USE_NETLIB + 'Y;'
      else
         sLib := SV_USE_NETLIB + 'N;';

      //Encriptografar os dados;
      Result := sServer + sDBAlias + sUser + sPW + sWinLogin + sLib;
      Reg.WriteString(fRegistryKey, EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));

  finally
     //Fechar o Registry
     Reg.CloseKey;
     Reg.Free;
  end;

end;


procedure TDMClientThread.FireReplStatus(Msg: String; Count: Integer);
begin
  if Assigned(FThread) then
    if (FThread is TThreadExecuteTask) then
      if Assigned(TThreadExecuteTask(FThread).OnReplicationStatus) then
        TThreadExecuteTask(FThread).OnReplicationStatus(Msg, Count);
  Sleep(0);
end;


procedure TDMClientThread.FireReplStepComplete;
begin
  if Assigned(FThread) then
    if (FThread is TThreadExecuteTask) then
      if Assigned(TThreadExecuteTask(FThread).OnReplicationStepCompleted) then
        TThreadExecuteTask(FThread).OnReplicationStepCompleted;
  Sleep(0);
end;

end.
