unit uExecuteFileTransfer;

interface

uses
  Classes, uTransferFile, SysUtils;

type

  TExecuteFileTransfer = class(TThread)
  private
    FRemoteWorkingDir: String;
    FLocalWorkingDir:  String;
    FFileList:         TStringList;
    FIDCashReg:        Integer;
    FOnServerStatus:   TOnServerStatus;
    FRunning:          Boolean;
    FOnFinish:         TOnFinish;
    procedure DoOnServerStatus(Online : Boolean);
  protected
    procedure Execute; override;
  public
    property RemoteWorkingDir: String          read FRemoteWorkingDir write FRemoteWorkingDir;
    property LocalWorkingDir:  String          read FLocalWorkingDir  write FLocalWorkingDir;
    property FileList:         TStringList     read FFileList         write FFileList;
    property IDCashReg:        Integer         read FIDCashReg        write FIDCashReg;
    property Running:          Boolean         read FRunning          write FRunning;

    property OnServerStatus:   TOnServerStatus read FOnServerStatus   write FOnServerStatus;
    property OnFinish:         TOnFinish       read FOnFinish        write FOnFinish;

    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

implementation

uses uFileFunctions;

{ TExecuteFileTransfer }

constructor TExecuteFileTransfer.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FFileList := TStringList.Create;
end;

destructor TExecuteFileTransfer.Destroy;
begin
  FFileList.Free;
  inherited Destroy;
end;

procedure TExecuteFileTransfer.DoOnServerStatus(Online: Boolean);
begin
  if Assigned(FOnServerStatus) then
    OnServerStatus(Online);
end;

procedure TExecuteFileTransfer.Execute;
var
  i : Integer;
  sArquivoLocal,
  sArquivoRemoto: String;
  lstTmp: TStringList;
begin
  FRunning := True;
  try
    for i := 0 to FFileList.Count-1 do
      if FFileList[i] <> '' then
      begin
        try
          sArquivoLocal  := FLocalWorkingDir + FFileList[i];
          sArquivoRemoto := FRemoteWorkingDir + IntToStr(FIDCashReg) + '\' + FFileList[i];

          if not DirectoryExists(ExtractFilePath(sArquivoRemoto)) then
            ForceDirectories(ExtractFilePath(sArquivoRemoto));

          lstTmp := TStringList.Create;
          try
            LoadFileNoLock(lstTmp, sArquivoLocal);
            if FileExists(sArquivoRemoto) then
              DeleteFile(PChar(sArquivoRemoto));
            lstTmp.SaveToFile(sArquivoRemoto);
          finally
            lstTmp.Free;
          end;
          DoOnServerStatus(True);
        except
          DoOnServerStatus(False);
        end;
      end
  finally
    FRunning := False;
    if Assigned(FOnFinish) then
      OnFinish;
  end;
end;

end.
