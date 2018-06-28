unit uDMServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMRepl, ImgList, AbUnzper, AbBase, AbBrowse, AbZBrows,
  AbZipper, ADODB, DB, IniFiles;

const
  SUBDIR_GLOBAL         = 'global\';
  STORE_ZIP             = 'local.zip';
  SERVER_CONFIG_FILE    = 'serverconfig.ini';
  CUSTOMERS_CONFIG_FILE = 'customersconfig.ini';

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

  FMT_CLIENT_CONNECTION =
    FILE_SERVER_HOST_STR + '%S;' +
    FILE_SERVER_PORT_STR + '%S;' +
    AUTH_STORE_NAME_STR  + '%S;' +
    AUTH_PACKET_SIZE_STR + '%S;' +
    AUTH_PASSWORD_STR    + '%S;';


type
  TDMServer = class(TDMRepl)
    ConnectionTester: TADOConnection;
    (*procedure TCPServerConnect(AThread: TIdPeerThread);
    procedure TCPServerExecute(AThread: TIdPeerThread);
    procedure TCPServerDisconnect(AThread: TIdPeerThread);*)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    (*
    procedure OnClientAuthenticate(Sender: TObject;
      AH: TAutenticationHeader);
    *)

    { Private declarations }
  public
    { Public declarations }
    procedure SetConnections(Connect:TADOConnection);
    function ImportXMLFile(Table, FileName, Where : String; SQLBatchCount: Integer = 100):Boolean; override;
    function ExportXMLFile(ExportPath, Table: String; RepSince:Integer; Where:String):Boolean; override;
    function GetServerConnection(Connection:String; ShowForm : Boolean):String;
    function TestConnection(sCon:String):Boolean;
    function IsSessionToExclude(S: String): Boolean;


    function CreateGlobalLock(AClient: String; AVersion: String = 'NOCONTROL'): Boolean;
    function RemoveGlobalLock(AClient: String): Boolean;
    function IsGlobalLocked(AClient: String): Boolean;
    function IsLocalLocked(AClient, AStore: String): Boolean;
    function CreateLocalLock(AClient: String; AVersion: String = 'NOCONTROL'): Boolean;
    function RemoveLocalLock(AClient: String): Boolean;
  end;

var
  DMServer: TDMServer;

implementation
uses (*URepSocketFunctions,*) ufrmServerInfo,
  tExecuteTask;
{$R *.dfm}

procedure TDMServer.SetConnections(Connect:TADOConnection);
begin
  fXMLToTable.Connection := Connect;
  fTableToXML.Connection := Connect;
end;

function TDMServer.ImportXMLFile(Table, FileName, Where : String; SQLBatchCount: Integer = 100):Boolean;
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
        ReportError(MR_HST_JOB_FAIL + sErro + '( Loading data from ' + FileName + ' ) in TDMServer.ImportXMLFile');
        Result := False;
        Exit;
      end;

     fXMLToTable.TableName := Table;

     sErro := fXMLToTable.SaveDataToTable(Table);
     if sErro <> '' then
      begin
        ReportError(MR_HST_JOB_FAIL + sErro + '( Saving data to ' + Table + ' ) in TDMServer.ImportXMLFile');
        Result := False;
      end;
    finally
      fXMLToTable.UnloadData;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ReportError(E.Message + ' - ' + 'TableName: ' + Table + ' in TDMServer.ImportXMLFile');
    end;
  end;
end;


function TDMServer.ExportXMLFile(ExportPath, Table: String; RepSince:Integer; Where:String): Boolean;
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
         ReportError(MR_HST_JOB_FAIL + E.Message + ' in TDMServer.ExportXMLFile');
         Result := False;
         Exit;
       end;
     end;

     sErro := fTableToXML.SaveToXML(ExportPath + Table);
     if sErro <> '' then
     begin
       ReportError(MR_HST_JOB_FAIL + sErro + ' in TDMServer.ExportXMLFile');
       Result := False;
     end;
   finally
     fTableToXML.UnloadData;
   end;
end;
(*
procedure TDMServer.TCPServerConnect(AThread: TIdPeerThread);
begin

  AThread.Data := TClientData.Create;
  TClientData(AThread.Data).SendingList.Clear;
  TClientData(AThread.Data).Conn             := AThread.Connection;
  TClientData(AThread.Data).AThread          := AThread;
  TClientData(AThread.Data).IsClient         := False;
  TClientData(AThread.Data).Autenticated     := 1;
  TClientData(AThread.Data).HeaderState      := chsWaitingPreHeader;
  TClientData(AThread.Data).TimeOut          := 40000;
  TClientData(AThread.Data).LastSokcetOper   := GetTickCount;
  TClientData(AThread.Data).SocketThread     := AThread;
  TClientData(AThread.Data).ClientConfigFile := DMServer.LocalPath+CUSTOMERS_CONFIG_FILE;
  TClientData(AThread.Data).OnAutenticationEvent := OnClientAuthenticate;

end;
*)


(*
procedure TDMServer.OnClientAuthenticate(Sender: TObject; AH: TAutenticationHeader);
var
  sStoreList: TStringList;
  fIniCustomersConfig : TIniFile;
  I : Integer;
begin
  case AH.ClientType of
    ctpClient:
      TClientData(Sender).SendingList.Add('', '');
    ctpProcessor:
    begin
      sStoreList := TStringList.Create;
      try
        fIniCustomersConfig := TIniFile.Create(DMServer.LocalPath+CUSTOMERS_CONFIG_FILE);
        try
          fIniCustomersConfig.ReadSection(AH.NomeCliente, sStoreList);
        finally
          fIniCustomersConfig.Free;
        end;

        for i:=0 to sStoreList.Count-1 do
        if not IsSessionToExclude(sStoreList.Strings[i]) then
        begin
          if FileExists(DMServer.LocalPath+AH.NomeCliente+'\'+sStoreList[I]+'\local.zip') then
            TClientData(Sender).SendingList.Add(AH.NomeCliente, sStoreList[I]);
        end;

      finally
        sStoreList.Free;
      end;
    end
  end;
end;
*)

(*
procedure TDMServer.TCPServerExecute(AThread: TIdPeerThread);
begin

  if not AThread.Terminated then
    ThreadFlow(TClientData(AThread.Data));

end;
*)

(*
procedure TDMServer.TCPServerDisconnect(AThread: TIdPeerThread);
begin

  TClientData(AThread.Data).Free;
  AThread.Data := nil;]

end;
*)

procedure TDMServer.DataModuleCreate(Sender: TObject);
begin
  inherited;
  (*
  if CreateGlobalLock('MundoVerde') then
    ShowMessage('Global Lock criado')
  else
    ShowMessage('Nao foi possivel criar Global Lock');

  if RemoveGlobalLock('MundoVerde') then
    ShowMessage('Global Lock excluido')
  else
    ShowMessage('Nao foi possivel excluir Global Lock');
  *)
  //CheckXMLVersion('repteste', 'repcli', '1.0');
  { Movido para uMainConf }
  // Ativa o servidor de socket
  // TCPServer.Active := True;
end;

(*
function TDMServer.CheckXMLVersion(Client, Store, DatabaseVersion : String): Boolean;
var
  sClientDir: String;
  cdsXML: TClientDataSet;
begin
  try
    sClientDir := DMServer.LocalPath + Client + '\' + Store + '\';
    cdsXML := TClientDataSet.Create(nil);
    try
      cdsXml.LoadFromFile(sClientDir + Format('ver-%S@%S.xml', [Store, Client]));
      Result := cdsXml.FieldByName('Version').AsString = DatabaseVersion;
    finally
      cdsXml.Close;
      cdsXML.Free;
    end;
  except
    on E: Exception do
      begin
        DMServer.ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.CheckXMLVersion');
        Result := False;
      end;
  end;
end;
*)





procedure TDMServer.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  (*TCPServer.Active := False;*)
end;

function TDMServer.GetServerConnection(Connection: String; ShowForm : Boolean): String;
begin

  if FrmServrInfo = nil then
     FrmServrInfo := TFrmServerInfo.Create(self);

   Result := FrmServrInfo.StartWithValues(Connection, ShowForm);

end;

function TDMServer.TestConnection(sCon: String): Boolean;
begin
  Result := True;
  with ConnectionTester do
    if not Connected then
    begin
      try
        ConnectionString := FomartConnection(sCon);
        Open;
        Close;
      except
        Result := False;
        Close;
      end;
    end;
end;

function TDMServer.IsSessionToExclude(S: String): Boolean;
begin
  Result := (S = DISABLESCHEDULE_STR) or (S = CONNECTION_STR) or (S = VERSION_STR) or
            (S = REPSINCE_STR) or (S = DISABLESCHEDULE_STR) or
            (S = MAINSTORE_STR) or (S = SERVER_TYPE_STR) or
            (S = FILE_SERVER_HOST_STR) or (S = FILE_SERVER_PORT_STR) or
            (S = AUTH_STORE_NAME_STR) or  (S = AUTH_PACKET_SIZE_STR) or
            (S = AUTH_PASSWORD_STR) or (S = SCHEDULE_STR) or
            (S = AUTH_CRIPTO_STR);
end;




function TDMServer.CreateGlobalLock(AClient: String; AVersion: String = 'NOCONTROL'): Boolean;
begin
  Result := CreateGenericVersionedFile(DMServer.LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient), AVersion);
end;

function TDMServer.CreateLocalLock(AClient: String; AVersion: String = 'NOCONTROL'): Boolean;
begin
  Result := CreateGenericVersionedFile(DMServer.LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient), AVersion);
end;

function TDMServer.RemoveGlobalLock(AClient: String): Boolean;
var
  LockFile : String;
begin
  LockFile :=  DMServer.LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient);
  if FileExists(LockFile) then
    Result := DeleteFile(LockFile)
  else
    Result := True;
end;

function TDMServer.RemoveLocalLock(AClient: String): Boolean;
var
  LockFile : String;
begin
  LockFile := DMServer.LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient);
  if FileExists(LockFile) then
    Result := DeleteFile(LockFile)
  else
    Result := True;
end;

function TDMServer.IsGlobalLocked(AClient: String): Boolean;
var
  LockFile : String;
  SR: TSearchRec;
begin
  LockFile :=  DMServer.LocalPath + AClient + '\global\' + GetGlobalLockFileName(AClient);
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

function TDMServer.IsLocalLocked(AClient, AStore: String): Boolean;
var
  LockFile : String;
  SR: TSearchRec;
begin
  LockFile :=  DMServer.LocalPath + AClient + '\global\' + GetLocalLockFileName(AClient, AStore);
  try
    Result := FindFirst(ExtractFilePath(LockFile) + 'lck-'+LowerCase(AStore)+'@'+ AClient +'.xml', faAnyFile, SR) = 0;
  finally
     FindClose(SR);
  end;

end;


end.


