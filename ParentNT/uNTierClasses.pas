unit uNTierClasses;

interface

uses MConnect, uMRParam;

const
  SERVER_NAME = 'MRAppServer.RDMApplicationHub';
  SERVER_GUID = '{572F6870-260E-4D79-8E86-63F8F0BA0948}';

type
  TNTierConnectionService = class
  private
    FConnectionParams: TMRParams;
    FActiveConnection: TDispatchConnection;

    procedure ActiveConnAfterConnect(Sender: TObject);
    procedure ActiveConnBeforeDisconnect(Sender: TObject);
  public
    destructor Destroy; override; 
    property ConnectionParams: TMRParams read FConnectionParams write FConnectionParams;
    property ActiveConnection: TDispatchConnection read FActiveConnection write FActiveConnection;

    function CreateNTierConnection: TDispatchConnection;
    procedure CloseConnection;
    procedure OpenConnection;
  end;


implementation


uses uNTierConsts, SConnect, SysUtils, uOperationSystem;

function TNTierConnectionService.CreateNTierConnection: TDispatchConnection;
var
  ConType, sHost, sPort, ClientID: String;
begin
  ConType   := FConnectionParams.KeyByName(CON_PARAM_TYPE).AsString;
  ClientID  := FConnectionParams.KeyByName(CON_PARAM_CLIENT_ID).AsString;
  sHost     := FConnectionParams.KeyByName(CON_PARAM_HOST).AsString;
  sPort     := FConnectionParams.KeyByName(CON_PARAM_PORT).AsString;

  if ConType = CON_TYPE_SOCKET then
    begin
      FActiveConnection := TSocketConnection.Create(nil);
      TSocketConnection(FActiveConnection).Host := sHost;
      TSocketConnection(FActiveConnection).Port := strToIntDef(sPort, 211);
    end
  else
    if ConType = CON_TYPE_DCOM then
      begin
        FActiveConnection := TDCOMConnection.Create(nil);
        TDCOMConnection(FActiveConnection).ComputerName := sHost;
      end
    else
      if ConType = CON_TYPE_WEB then
        begin
          FActiveConnection := TWebConnection.Create(nil);
          TWebConnection(FActiveConnection).Proxy := sHost;
        end;

  FActiveConnection.ServerName := SERVER_NAME;
  FActiveConnection.ServerGUID := SERVER_GUID;

  Result := FActiveConnection;

  FActiveConnection.AfterConnect := ActiveConnAfterConnect;
  FActiveConnection.BeforeDisconnect := ActiveConnBeforeDisconnect;
end;

procedure TNTierConnectionService.CloseConnection;
begin
  if FActiveConnection.Connected then
    FActiveConnection.Connected := False;
end;

procedure TNTierConnectionService.OpenConnection;
begin
  if not FActiveConnection.Connected then
  try
    FActiveConnection.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('It was not possible to establish connection with the server.');
  end;
end;

procedure TNTierConnectionService.ActiveConnAfterConnect(Sender: TObject);
begin
  FActiveConnection.AppServer.LogIn(FConnectionParams.KeyByName(CON_PARAM_CLIENT_ID).AsString,
                                    FConnectionParams.KeyByName(CON_PARAM_SOFTWARE).AsString);
end;

procedure TNTierConnectionService.ActiveConnBeforeDisconnect(
  Sender: TObject);
begin
  FActiveConnection.AppServer.LogOut(FConnectionParams.KeyByName(CON_PARAM_CLIENT_ID).AsString,
                                     FConnectionParams.KeyByName(CON_PARAM_SOFTWARE).AsString);
end;

destructor TNTierConnectionService.Destroy;
begin
  FreeAndNil(FActiveConnection);
  inherited;
end;

end.
