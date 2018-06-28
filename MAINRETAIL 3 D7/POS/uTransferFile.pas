unit uTransferFile;

interface

uses Classes, SysUtils;

type
 TOnServerStatus = procedure (Online : Boolean) of Object;
 TOnFinish = procedure of Object;

 TTransferFile = class
 private
    FRemoteWorkingDir: String;
    FLocalWorkingDir:  String;
    FFileList:         String;
    FIDCashReg:        Integer;
    FThread:           TThread;
    FOnServerStatus: TOnServerStatus;
    FOnFinish: TOnFinish;
    FRunning: Boolean;
    procedure DoOnServerStatus(Online: Boolean);
    procedure OnTerminateThread(Sender: TObject);
 public
    property RemoteWorkingDir : String  read FRemoteWorkingDir write FRemoteWorkingDir;
    property LocalWorkingDir  : String  read FLocalWorkingDir  write FLocalWorkingDir;
    property FileList         : String  read FFileList         write FFileList;
    property IDCashReg        : Integer read FIDCashReg        write FIDCashReg;
    property Running          : Boolean read FRunning          write FRunning;
    procedure Execute;
    procedure ServerStatusHandler(Online : Boolean);
    procedure Finish;

    property OnServerStatus:   TOnServerStatus read FOnServerStatus   write FOnServerStatus;
    property OnFinish:         TOnFinish       read FOnFinish         write FOnFinish;

    constructor Create;
    destructor Destroy; override;
 end;

implementation

uses uExecuteFileTransfer;

{ TransferFile }

constructor TTransferFile.Create;
begin
  inherited Create;
end;

destructor TTransferFile.Destroy;
begin
  if FThread <> nil then
  begin
    if TExecuteFileTransfer(FThread).Running then
    begin
      FThread.Terminate;
      try
        FThread.WaitFor;
      except
        end;
    end;
  end;
  inherited Destroy;
end;

procedure TTransferFile.Execute;
begin
  if FThread <> nil then
  begin
    if TExecuteFileTransfer(FThread).Running then
      Exit;
    FreeAndNil(FThread);
  end;

  FThread := TExecuteFileTransfer.Create(True);
  FThread.FreeOnTerminate := True;
  FThread.Priority := tpLowest;
  FThread.OnTerminate := OnTerminateThread;

  TExecuteFileTransfer(FThread).RemoteWorkingDir       := FRemoteWorkingDir;
  TExecuteFileTransfer(FThread).LocalWorkingDir        := FLocalWorkingDir;
  TExecuteFileTransfer(FThread).FileList.Delimiter     := ';';
  TExecuteFileTransfer(FThread).FileList.DelimitedText := FFileList;
  TExecuteFileTransfer(FThread).IDCashReg              := FIDCashReg;
  TExecuteFileTransfer(FThread).OnServerStatus         := ServerStatusHandler;
  TExecuteFileTransfer(FThread).OnFinish               := Finish;

  FRunning := True;
  FThread.Resume;

end;

procedure TTransferFile.OnTerminateThread(Sender: TObject);
begin
  FRunning := False;
  FThread := nil;
end;

procedure TTransferFile.ServerStatusHandler(Online: Boolean);
begin
  DoOnServerStatus(Online);
end;

procedure TTransferFile.DoOnServerStatus(Online: Boolean);
begin
  if Assigned(FOnServerStatus) then
    OnServerStatus(Online);
end;

procedure TTransferFile.Finish;
begin
  FRunning := False;
end;

end.
