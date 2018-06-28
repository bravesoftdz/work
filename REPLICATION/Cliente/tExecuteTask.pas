unit tExecuteTask;

interface

uses
  SysUtils, Classes, ShellAPI, OoMisc, uDMClientThread;

type

  TReplicationStatusEvent = procedure (Msg: String; Count: Integer ) of Object;

  TReplicationStepCompleted = procedure of Object;

  TThreadExecuteTask = class(TThread)
  private
    { Private declarations }
    fRunning : Boolean;
    fTextLog : string;
    FDMClientThread: TDMClientThread;
    FDefaultStore: Integer;
    FReplicateSince: Integer;
    FSQLBatchCount: Integer;
    FHost: String;
    FLocalTables: String;
    FExceptTables: String;
    fLocalPath: String;
    FClientInfo: String;
    FGlobalTables: String;
    FOnReplicationStatus: TReplicationStatusEvent;
    FOnReplicationStepCompleted: TReplicationStepCompleted;
    FExceptFields: String;
    FInsertTables: String;
    FDisableUpdateQty: Boolean;
    function StopVPN:Boolean;
    procedure ForwardParameters;
  protected
    procedure ExecuteJobs;
    procedure Execute; override;
  public
    property Running   : Boolean       read fRunning;
    property LocalPath           : String read fLocalPath write fLocalPath;
    property GlobalTables : String read FGlobalTables write FGlobalTables;
    property SQLBatchCount: Integer read FSQLBatchCount write FSQLBatchCount;
    property ExceptTables: String read FExceptTables write FExceptTables;
    property ExceptFields: String read FExceptFields write FExceptFields;
    property LocalTables: String read FLocalTables write FLocalTables;
    property InsertTables: String read FInsertTables write FInsertTables;
    property ReplicateSince: Integer read FReplicateSince write FReplicateSince;
    property ClientInfo: String read FClientInfo write FClientInfo;
    property Host: String read FHost write FHost;
    property DefaultStore: Integer read FDefaultStore write FDefaultStore;
    property DisableUpdateQty : Boolean read FDisableUpdateQty write FDisableUpdateQty;

    property OnReplicationStatus: TReplicationStatusEvent read FOnReplicationStatus write FOnReplicationStatus;
    property OnReplicationStepCompleted: TReplicationStepCompleted read FOnReplicationStepCompleted write FOnReplicationStepCompleted; 

    constructor Create(CreateSuspended: Boolean);
    destructor Destroy;override;



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
  fRunning := True;
  try
    ForwardParameters;
    FDMClientThread.ExecuteReplication;
  finally
    fRunning := False;
    FDMClientThread.CloseConnection;
    StopVPN;
  end;
end;


procedure TThreadExecuteTask.ForwardParameters;
begin
    FDMClientThread.LocalPath        := FLocalPath;
    FDMClientThread.GlobalTables     := FGlobalTables;
    FDMClientThread.SQLBatchCount    := FSQLBatchCount;
    FDMClientThread.ExceptTables     := FExceptTables;
    FDMClientThread.LocalTables      := FLocalTables;
    FDMClientThread.ExceptFields     := FExceptFields;
    FDMClientThread.InsertTables     := FInsertTables;
    FDMClientThread.ReplicateSince   := FReplicateSince;
    FDMClientThread.ClientInfo       := FClientInfo;
    FDMClientThread.Host             := FHost;
    FDMClientThread.DefaultStore     := FDefaultStore;
    FDMClientThread.DisableUpdateQty := FDisableUpdateQty;

    FDMClientThread.Thread := Self;
end;

procedure TThreadExecuteTask.Execute;
begin
  { Place thread code here }
  ExecuteJobs;
end;

constructor TThreadExecuteTask.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FDMClientThread := TDMClientThread.create(nil);
end;

destructor TThreadExecuteTask.Destroy;
begin
  FDMClientThread.Free;
  Inherited Destroy;
end;

end.
