unit tExecuteTask;

interface

uses
  SysUtils, Classes, ShellAPI, OoMisc, uPOSServerTypes, uDMThread, ActiveX;

type



  TThreadExecuteTask = class(TThread)
  private
    { Private declarations }
    fRunning : Boolean;
    fIDStore: Integer;
    FLocalSetting: TLocalSetting;
    FServerConnection: TServerConnection;
    FDMThread: TDMThread;
    FOnNeedWriteIniBool: TOnNeedWriteIniBool;
    FOnNeedWriteIniDateTime: TOnNeedWriteIniDateTime;
    FOnNeedWriteIniInteger: TOnNeedWriteIniInteger;
    FOnNeedWriteIniString: TOnNeedWriteIniString;
    FForceSynchronization: Boolean;
    FSynchronizationType: Integer;
    FCashRegInfolist: TStringList;
    FOnPOSServerStatusEvent : TPOSServerStatusEvent;
    FPOSServerStepCompleted: TPOSServerStepCompleted;
    FPOSServerCompleted: TPOSServerCompleted;
    FOnSaveNextSchedule: TOnSaveNextSchedule;
    function StopVPN:Boolean;
  protected
    property DMThread: TDMThread read FDMThread write FDMThread;
    procedure ExecuteJobs;
    procedure Execute; override;

  public
    property Running   : Boolean       read fRunning;

    property IDStore : Integer read FIDStore write FIDStore;
    property ServerConnection: TServerConnection read FServerConnection write FServerConnection;
    property LocalSetting: TLocalSetting read FLocalSetting write FLocalSetting;
    property ForceSynchronization : Boolean read FForceSynchronization write FForceSynchronization;
    property CashRegInfolist: TStringList read FCashRegInfolist write FCashRegInfolist;
    property SynchronizationType: Integer read FSynchronizationType write FSynchronizationType;


    property OnNeedWriteIniBool: TOnNeedWriteIniBool read FOnNeedWriteIniBool write FOnNeedWriteIniBool;
    property OnNeedWriteIniDateTime: TOnNeedWriteIniDateTime read FOnNeedWriteIniDateTime write FOnNeedWriteIniDateTime;
    property OnNeedWriteIniString: TOnNeedWriteIniString read FOnNeedWriteIniString write FOnNeedWriteIniString;
    property OnNeedWriteIniInteger: TOnNeedWriteIniInteger read FOnNeedWriteIniInteger write FOnNeedWriteIniInteger;

    property OnPOSServerStatusEvent: TPOSServerStatusEvent read FOnPOSServerStatusEvent write FOnPOSServerStatusEvent;
    property OnPOSServerStepCompleted: TPOSServerStepCompleted read FPOSServerStepCompleted write FPOSServerStepCompleted;
    property OnPOSServerCompleted: TPOSServerCompleted read FPOSServerCompleted write FPOSServerCompleted;
    property OnSaveNextSchedule: TOnSaveNextSchedule read FOnSaveNextSchedule write FOnSaveNextSchedule;

    procedure WriteIniBool(ASection, AKey: String; AValue: Boolean);
    procedure WriteIniDateTime(ASection, AKey: String; AValue: TDateTime);
    procedure WriteIniInteger(ASection, AKey: String; AValue: Integer);
    procedure WriteIniString(ASection, AKey, AValue: String);

    procedure FreeDMThread;
  end;

implementation

uses uMainConf;

{ TThreadExecuteTask }

function TThreadExecuteTask.StopVPN:Boolean;
begin
  Result := False;

  if ((FrmMain.fNetworkCon.NetworkCon1 <> '') and (FrmMain.VPN1.ConnectState = csRasConnected)) and
     (FrmMain.fNetworkCon.StopVPN1)  then
     FrmMain.VPN1.Hangup;

  if ((FrmMain.fNetworkCon.NetworkCon2 <> '') and (FrmMain.VPN2.ConnectState = csRasConnected)) and
     (FrmMain.fNetworkCon.StopVPN2) then
     FrmMain.VPN2.Hangup;

end;

procedure TThreadExecuteTask.ExecuteJobs;
begin
  CoInitialize(nil);
  FDMThread := TDMThread.Create(nil);
  try

    FDMThread.Thread := Self;
    FDMThread.IDStore := FIDStore;
    FDMThread.ServerConnection := FServerConnection;
    FDMThread.LocalSetting := FLocalSetting;
    FDMThread.ForceSynchronization := FForceSynchronization;
    FDMThread.CashRegInfolist := FCashRegInfolist;
    FDMThread.SynchronizationType := FSynchronizationType;
    FDMThread.Execute;
  finally
    FDMThread.Free;
  end;
end;

procedure TThreadExecuteTask.Execute;
begin
  { Place thread code here }

  FRunning := True;
  try
    if (not Terminated) then
    ExecuteJobs;
  finally
    FRunning := False;
  end;

end;


procedure TThreadExecuteTask.WriteIniBool(ASection, AKey: String; AValue: Boolean);
begin
  if Assigned(FOnNeedWriteIniBool) then
    FOnNeedWriteIniBool(ASection, AKey, AValue);
end;

procedure TThreadExecuteTask.WriteIniDateTime(ASection, AKey: String; AValue: TDateTime);
begin
  if Assigned(FOnNeedWriteIniDateTime) then
    FOnNeedWriteIniDateTime(ASection, AKey, AValue);
end;

procedure TThreadExecuteTask.WriteIniString(ASection, AKey: String; AValue: String);
begin
  if Assigned(FOnNeedWriteIniString) then
    FOnNeedWriteIniString(ASection, AKey, AValue);
end;

procedure TThreadExecuteTask.WriteIniInteger(ASection, AKey: String; AValue: Integer);
begin
  if Assigned(FOnNeedWriteIniInteger) then
    FOnNeedWriteIniInteger(ASection, AKey, AValue);
end;


procedure TThreadExecuteTask.FreeDMThread;
begin
  if FDMThread <> nil then
    FDMThread.Free;
end;

end.
