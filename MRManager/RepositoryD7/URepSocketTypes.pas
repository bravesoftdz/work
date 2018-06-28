unit URepSocketTypes;


interface

uses Classes, IdTCPConnection, SysUtils, IdTCPServer, Windows, Forms;


type
  THeaderType       = (hsNone, hsAutenticate, hsFileRequest, hsFile, hsDisconnect);
  TRequestType      = (rsLocalFiles);

  TDisconnectReason = (drTransactionOK, drInvalidAutentication, drNoServerFiles, drNoClientFiles, drTimeOut, drError, drServerBusy, drInvalidHeader);

  TClientType       = (ctpClient, ctpProcessor);

  TClientInfo       = array [0..1024] of Char;

  TPreHeader = record
    HeaderType : THeaderType;
  end;

  TAutenticationHeader = packed record
    ClientInfo, {: TClientInfo;}
    NomeCliente,
    NomeLoja,
    Versao,
    Senha : ShortString;
    PacketSize : Integer;
    ClientType: TClientType;
  end;

  TClientAutenticationEvent = procedure(Sender: TObject; AH: TAutenticationHeader) of object;

  TFileHeader = packed record
    FileName: ShortString;
    FileSize: Int64;
    FileDestiny: ShortString;
  end;

  TFileRequest = packed record
    RequestType : TRequestType;
  end;

  TDisconnectHeader = packed record
     DisconnectReason : TDisconnectReason;
  end;


  TConnectionHeaderState = (chsNone, chsWaitingPreHeader, chsWaitingHeader, chsReceivingBody, chsSendingPreHeader, chsSendingHeader, chsSendingBody);
  TConnectionSendMode    = (csmNone, csmRequestingFile, csmSendingFile, csmSendingDisconnect, csmSendingAutentication);



  TClientLogger = class;

  TSendingFile = class
  public
    Cliente,
    Loja: String;
  end;


  TSendingList = class
  private
    FItems : TList;
    function GetItems(Index: Integer): TSendingFile;
    procedure SetItems(Index: Integer; const Value: TSendingFile);
    function GetCount: Integer;
  public
    property Items[Index: Integer]: TSendingFile read GetItems write SetItems;default;
    property Count: Integer read GetCount;
    constructor Create;
    destructor Destroy;override;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure Add(ACliente, ALoja: String);
  end;



  TClientData = class(TPersistent)
  private
    FSendingList: TSendingList;
    FOnAutenticationEvent: TClientAutenticationEvent;
    FDisconnectReason: TDisconnectReason;
  public
    NomeCliente,
    NomeLoja,
    Versao:           String;
    SendingStream,
    ReceivingStream,
    PreHeaderStream,
    HeaderStream:     TMemoryStream;
    HeaderState:      TConnectionHeaderState;
    ActualHeader:     THeaderType;
    Autenticated:     Byte;
    ReceivingSize,
    SendingSize:      Int64;
    ReceivingName,
    SendingName:      ShortString;
    ReceivingDestiny: ShortString;
    SendMode:         TConnectionSendMode;
    Conn:             TIdTCPConnection;
    AThread:          TThread;
    IsClient:         Boolean;

    PacketSize:       Integer;
    Senha:            ShortString;
    ClientInfo:       String;
    TimeOut:          Integer;
    LastSokcetOper:   Integer;
    HoraAtual:        Integer;
    Logger:           TClientLogger;
    SocketThread:     TIdPeerThread;
    Mutex:            Cardinal;
    ClientConfigFile: String;
    ClientType:       TClientType;
    property SendingList:    TSendingList read FSendingList    write FSendingList;
    property OnAutenticationEvent: TClientAutenticationEvent read FOnAutenticationEvent write FOnAutenticationEvent;
    property DisconnectReason: TDisconnectReason read FDisconnectReason write FDisconnectReason;
    constructor Create;
    destructor Destroy;override;
    function CanRead : Boolean;
    function GetReasonName(ADisconnectReason: TDisconnectReason): String;
  end;

  TClientLogger = class
    FArquivoAberto : Boolean;
    FArquivo : TextFile;
    FClientData: TClientData;
    constructor Create(ClientData: TClientData);
    destructor Destroy;override;
    procedure Log(S: String);
  private
    procedure StartLog;
    procedure MandaLinha(S: String);
  end;

implementation
uses IdTCPClient, IdIOHandlerSocket;

{ TClientData }

function TClientData.CanRead: Boolean;
begin
  Result := False;
  if IsClient then
    Result := Result or TIdTCPClient(Self.Conn).Socket.Readable(-1)
  else
    Result := True;{TIdTCPServerConnection(Self.Conn).IOHandler.Readable();}
    //Result := SocketThread.Connection.Socket.Readable();
end;

constructor TClientData.Create;
begin
  inherited Create;
  ReceivingStream := TMemoryStream.Create;
  SendingStream   := TMemoryStream.Create;
  HeaderStream    := TMemoryStream.Create;
  PreHeaderStream := TMemoryStream.Create;
  Logger          := TClientLogger.Create(Self);
  SocketThread    := nil;
  Mutex           := 0;
  ClientType      := ctpClient;

  FSendingList    := TSendingList.Create;
end;

destructor TClientData.Destroy;
begin

  ReceivingStream.Clear;
  SendingStream.Clear;
  HeaderStream.Clear;
  PreHeaderStream.Clear;

  ReceivingStream.Free;
  SendingStream.Free;
  HeaderStream.Free;
  PreHeaderStream.Free;
  Logger.Free;

  FSendingList.Free;

  if Mutex <> 0 then
  begin
    ReleaseMutex(Mutex);
    CloseHandle(Mutex);
  end;

  inherited Destroy;
end;

function TClientData.GetReasonName(
  ADisconnectReason: TDisconnectReason): String;
begin
  case ADisconnectReason of
    drTransactionOK:        Result := 'drTransactionOK';
    drInvalidAutentication: Result := 'drInvalidAutentication';
    drNoServerFiles:        Result := 'drNoServerFiles';
    drNoClientFiles:        Result := 'drNoClientFiles';
    drTimeOut:              Result := 'drTimeOut';
    drError:                Result := 'drError';
    drServerBusy:           Result := 'drServerBusy';
    drInvalidHeader:        Result := 'drInvalidHeader'; 
    else                    Result := 'UNKNOW';
  end;
end;

{ TClientLogger }

constructor TClientLogger.Create(ClientData: TClientData);
begin
  inherited Create;
  FArquivoAberto := False;
  FClientData := ClientData;
end;

destructor TClientLogger.Destroy;
begin
  if FArquivoAberto then
    CloseFile(FArquivo)
end;

procedure TClientLogger.Log(S: String);
begin
  if not FArquivoAberto then
    StartLog;
  MandaLinha(S);
end;

procedure TClientLogger.MandaLinha(S: String);
var
  Segundos: Integer;
begin
  Segundos := FClientData.HoraAtual - FClientData.LastSokcetOper;
  Writeln(FArquivo, FormatDateTime('dd/mm/yyyy hh:nn:ss', now) + Format(#9'%S'#9#9'Duração: %D ms', [S, Segundos]));
  Flush(FArquivo);
end;

procedure TClientLogger.StartLog;
var
  Caminho, NomeArquivo : string;
begin
  Caminho := ExtractFilePath(Application.ExeName) + 'Log\';

  if not DirectoryExists(Caminho) then
    ForceDirectories(Caminho);

  {if not FClientData.IsClient then
  begin}
    NomeArquivo := FormatDateTime('YYYYMMDD HH-NN-SS', NOW) + '.log';
  {end
  else
    NomeArquivo := 'Replication.log';}



  AssignFile(FArquivo, Caminho + NomeArquivo);
  Rewrite(FArquivo);
  FArquivoAberto := True;
  MandaLinha('Log Iniciado');
end;

{ TSendingList }

procedure TSendingList.Add(ACliente, ALoja: String);
var
  SendingFile: TSendingFile;
begin
  SendingFile         := TSendingFile.Create;

  SendingFile.Cliente := ACliente;
  SendingFile.Loja    := ALoja;

  FItems.Add(SendingFile);
end;

procedure TSendingList.Clear;
begin
  FItems.Clear;
end;

constructor TSendingList.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

procedure TSendingList.Delete(Index: Integer);
begin
  FItems.Delete(Index);
end;

destructor TSendingList.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

function TSendingList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TSendingList.GetItems(Index: Integer): TSendingFile;
begin
  Result := FItems[Index];
end;

procedure TSendingList.SetItems(Index: Integer; const Value: TSendingFile);
begin
  FItems[Index] := Value;
end;

end.
