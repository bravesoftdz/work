unit uDMRepl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMParent, ADODB, DB, ImgList, AbUnzper, AbBase, AbBrowse,
  AbZBrows, AbZipper, ufrmServerInfo, uReplicationClasses, Registry, uSQLObj,
  DBClient;

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
  WM_ICONMESSAGE       = WM_USER + 1;

  REG_PATH             = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

  ALL_XML              = '*.xml';
  EXT_XML              = '.xml';

  DEFAULT_BIND_PORT    = 1666;

type
  TDMRepl = class(TDMParent)
    ADOCommand: TADOCommand;
    Zipper: TAbZipper;
    UnZipper: TAbUnZipper;
    imgLarge: TImageList;
    quUpdTotQtyOnHand: TADOCommand;
    spRecalcTotal: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private


    { Private declarations }
  protected
    FrmServrInfo : TFrmServerInfo;
    fSQLSvrConnectParam : TSQLConnection;
    fXMLToTable : TXMLToTable;
    fTableToXML: TTableToXML;
  public
    { Public declarations }
    //Error History
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
    function ImportXMLFile(Table, FileName, Where : String; SQLBatchCount: Integer = 100):Boolean; virtual; abstract;
    function ExportXMLFile(ExportPath, Table: String; RepSince:Integer; Where:String):Boolean; virtual; abstract;
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

  end;

var
  DMRepl: TDMRepl;

implementation

uses uParamFunctions, uSaveToFile, uFileFunctions, uSystemConst;

{$R *.dfm}

procedure TDMRepl.DeleteReplFile(sFileName: String);
begin
   //delete File
   if FileExists(sFileName) then
      DeleteFile(sFileName);
end;


procedure TDMRepl.UnZipFile(DestDir, ZipFileName: String);
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


procedure TDMRepl.ZipFile(FilesToZip, ZipFileName: String);
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


function TDMRepl.OpenConnection:Boolean;
var
  sResult : String;
  b : Boolean;
begin

   //Connection open, exit
  if ADODBConnect.Connected then
     begin
     Result := True;
     Exit;
     end;

  if FrmServrInfo = nil then
     FrmServrInfo := TFrmServerInfo.Create(self);

   //Server Connection
   b := False;
   Result := False;
   //FrmServrInfo.RegistryKey := sType; //Save connection to registry key
   sResult := FrmServrInfo.Start('4', False, '', b);

   While not b do
      try
        sResult := FomartConnection(sResult);
        ADODBConnect.ConnectionString := sResult;
        ADODBConnect.Open;
        b := True;
        Result := True;
      except
        on E: Exception do
           sResult := FrmServrInfo.Start('4', True, E.Message, b);
      end;

end;


procedure TDMRepl.CloseConnection;
begin
  if ADODBConnect.Connected then
     ADODBConnect.Close;
end;

function TDMRepl.LoadErrorFile:String;
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

procedure TDMRepl.AddHistory(Text:String);
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

procedure TDMRepl.AddErrorHistory(Text:String);
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


procedure TDMRepl.ReportError(sText:String);
begin
  //Register Error history
  AddHistory(sText);
  AddErrorHistory(sText);
end;


procedure TDMRepl.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fSQLSvrConnectParam    := TSQLConnection.Create;
  // Removido leak
  (*
  fXMLToTable            := TXMLToTable.Create(Self);
  fTableToXML            := TTableToXML.Create(Self);

  fXMLToTable.Connection := ADODBConnect;
  fTableToXML.Connection := ADODBConnect;
  *)

  // Abre o registry
  with TRegistry.Create do
  begin
     RootKey := HKEY_LOCAL_MACHINE;
     OpenKey(REGISTRY_PATH, True);
     try
       if not ValueExists('DefaultLanguage') then
          WriteInteger('DefaultLanguage', LANG_ENGLISH);
       //DMGlobal.IDLanguage := ReadInteger('DefaultLanguage');
     finally
       CloseKey;
     end;
     Free;
  end;

end;

procedure TDMRepl.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fSQLSvrConnectParam);
  FreeAndNil(FrmServrInfo);
  // Removido leak
  (*

  FreeAndNil(fXMLToTable);
  FreeAndNil(fTableToXML);
  *)
end;

function TDMRepl.FomartConnection(sParam: String): String;
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

function TDMRepl.GetDatabaseVersion(AConn: TADOConnection) : String;
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


function TDMRepl.GenerateXMLVersionControl(AVersion: String; AHora: TDateTime): String;
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

function TDMRepl.CheckXMLVersion(Filename, DatabaseVersion : String): Boolean;
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

function TDMRepl.CheckXMLVersion(AStream: TStream; DatabaseVersion : String): Boolean;
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

function TDMRepl.GetGlobalLockFileName(AClient: String): String;
begin
  Result := Format('lck-global@%S.lck', [LowerCase(AClient)]);
end;

function TDMRepl.GetGlobalVersionFileName(AClient: String): String;
begin
  Result := 'ver-global@' + LowerCase(AClient) + '.xml';
end;


function TDMRepl.GetLocalVersionFileName(AClient, AStore: String): String;
begin
  Result := Format('ver-%S@%S.xml', [LowerCase(AStore), LowerCase(AClient)])
end;



function TDMRepl.GetLocalLockFileName(AClient, AStore: String): String;
begin
  Result := Format('lck-%S@%S.lck', [LowerCase(AStore), LowerCase(AClient)]);
end;

function TDMRepl.UpdateTotQtyOnHand(Conn: TADOConnection): Boolean;
begin
  Result := True;
  try
    spRecalcTotal.Connection := Conn;
    spRecalcTotal.ExecProc;
  except
    on E: Exception do
      begin
        ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMRepl.UpdateTotQtyOnHand');
        Result := False;
      end;
  end;
end;

function TDMRepl.CreateGenericVersionedFile(AFileName: String; AVersion: String = 'NOCONTROL'): Boolean;
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


end.
