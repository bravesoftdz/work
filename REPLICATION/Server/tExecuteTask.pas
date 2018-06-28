unit tExecuteTask;

interface

uses
  SysUtils, Classes, ShellAPI, OoMisc, uDMThread, ActiveX;

type

  TSyncLogEvent = procedure(Sender: TObject; const Client: string) of object;

  TThreadExecuteTask = class(TThread)
  private
    { Private declarations }
    fSyncDate: TSyncLogEvent;
    FDMThread: TDMThread;
    FRepSince: Integer;
    FMainStore: Integer;
    FSQLBatchCount: Integer;
    FStoreList: TStringList;
    FStoreTables: WideString;
    FLocalPath: WideString;
    FConnectionString: WideString;
    FExcepTables: WideString;
    FGlobalTables: WideString;
    FClient: WideString;
    FDisableUpdateQty: Boolean;
    procedure ConfigureThread;
  protected
    procedure ExecuteJobs;
    procedure DoSyncDate;
    procedure Execute; override;
  public
    property OnSyncDate: TSyncLogEvent read fSyncDate write fSyncDate;
    property DMThread: TDMThread read FDMThread;


    property LocalPath: WideString read FLocalPath write FLocalPath;
    property ConnectionString: WideString read FConnectionString write FConnectionString;
    property RepSince: Integer read FRepSince write FRepSince;
    property MainStore: Integer read FMainStore write FMainStore;
    property StoreList: TStringList read FStoreList write FStoreList;
    property GlobalTables: WideString read FGlobalTables write FGlobalTables;
    property StoreTables: WideString read FStoreTables write FStoreTables;
    property ExcepTables: WideString read FExcepTables write FExcepTables;
    property SQLBatchCount: Integer read FSQLBatchCount write FSQLBatchCount;
    property Client: WideString read FClient write FClient;
    property DisableUpdateQty : Boolean read FDisableUpdateQty write FDisableUpdateQty;

    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

implementation

uses uDMServer, uDMRepl, uMainConf;

{ TThreadExecuteTask }

procedure TThreadExecuteTask.DoSyncDate;
begin
  if Assigned(fSyncDate) then fSyncDate(Self, fClient);
end;

procedure TThreadExecuteTask.ExecuteJobs;
begin
  try
    fClient := FDMThread.Client;
    FDMThread.ExeSingleReplication;
  finally

    DoSyncDate;
  end;

end;

procedure TThreadExecuteTask.Execute;
begin
  { Place thread code here }
  CoInitialize(nil);
  try
    FDMThread := TDMThread.Create(nil);
    try
      ConfigureThread;
      ExecuteJobs;
    finally
      FDMThread.Free;
      FDMThread := nil;
    end;
  finally
    CoUninitialize;
  end;
end;

constructor TThreadExecuteTask.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FStoreList := TStringList.Create;
end;

destructor TThreadExecuteTask.Destroy;
begin
  if FDMThread <> nil then
     FDMThread.Free;
  FStoreList.Free;
  inherited Destroy;
end;


procedure TThreadExecuteTask.ConfigureThread;
begin
    FDMThread.LocalPath        := FLocalPath;
    FDMThread.ConnectionString := FConnectionString;
    FDMThread.RepSince         := FRepSince;
    FDMThread.MainStore        := FMainStore;
    FDMThread.StoreList.Assign(FStoreList);
    FDMThread.GlobalTables     := FGlobalTables;
    FDMThread.StoreTables      := FStoreTables;
    FDMThread.ExcepTables      := FExcepTables;
    FDMThread.SQLBatchCount    := FSQLBatchCount;
    FDMThread.Client           := FClient;
    FDMThread.DisableUpdateQty := FDisableUpdateQty;
end;

end.
