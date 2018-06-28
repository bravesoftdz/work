unit uNTTraceControl;

interface

uses Classes, SysUtils, Windows, MConnect;

type
  TTraceList = ^AList;

  AList = record
    iBegin: Integer;
    sProcName: String;
    sRecordId: String;
  end;

  TmrTraceControl = class(TObject)
  private
    FTraceList: TList;
    ATraceRecord: TTraceList;
    FConnection: TDispatchConnection;
    function GetLastTrace: String;
    procedure DisposeTraceList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveTrace(IdUser: Integer; Exception, FormClass: String);
    procedure TraceIn (sProcName: String; sRecordId: String = '');
    procedure TraceOut;
    procedure Write (sUserText: String);
    property LastTrace: String read GetLastTrace;
    property Connection: TDispatchConnection read FConnection write FConnection;
  end;

implementation

{$DEFINE DEBUG}
{ TmrTraceControl }

constructor TmrTraceControl.Create;
begin
  inherited Create;
  FTraceList := TList.Create;
end;

destructor TmrTraceControl.Destroy;
begin
  DisposeTraceList;
  FTraceList.Clear;
  FTraceList.Free;
  inherited Destroy;
end;

procedure TmrTraceControl.DisposeTraceList;
var
  i : Integer;
begin

  //Veriricar Dispose quando fechar, pois esta deixando lixo!!!!
  for i := 0 to FTraceList.Count - 1 do
  begin
    ATraceRecord := FTraceList.Items[i];
    Dispose(ATraceRecord);
  end;

end;

function TmrTraceControl.GetLastTrace: String;
begin
  if FTraceList.Count > 0 then
    Result := TTraceList(FTraceList[FTraceList.Count - 1]).sProcName
  else
    Result := '';
end;

procedure TmrTraceControl.SaveTrace(IdUser: Integer; Exception, FormClass: String);
var
  I: Integer;
  Methods, RecordId: String;
begin
  Methods := '';
  RecordId := '';
  if FTraceList.Count > 0 then
  begin
    // Get trace items
    for I := 0 to FTraceList.Count - 1 do
    begin
      ATraceRecord := FTraceList.Items[i];
      Methods := Methods + ATraceRecord.sProcName + ' | ';
      if ATraceRecord.sRecordId <> '' then
        RecordId := RecordId + ATraceRecord.sRecordId + ' | ';
      Dispose(ATraceRecord);
    end;
    Delete(Methods, Length(Methods) -2, 2);
    Delete(RecordId, Length(RecordId) -2, 2);
    FTraceList.Clear;
  end;

  // Save trace (RPC call)
  if Assigned(Connection) then
    Connection.AppServer.SaveAppTrace(IdUser, 1, FormClass, Methods, Exception, RecordId, '');

end;

procedure TmrTraceControl.TraceIn(sProcName: String; sRecordId: String);
var
  sTraceText: String;
  iCount: Integer;
begin
  {$IFDEF DEBUG}
  New(ATraceRecord);

  ATraceRecord^.iBegin := GetTickCount;
  ATraceRecord^.sProcName := sProcName;
  ATraceRecord^.sRecordId := sRecordId;
  FTraceList.Add(ATraceRecord);

  sTraceText := '';

  for iCount := 0 to FTraceList.Count - 2 do
    sTraceText := sTraceText + '  ';

  sTraceText := sTraceText + 'Begin ' + sProcName;

  OutputDebugString(PChar(sTraceText));
  {$ENDIF}
end;

procedure TmrTraceControl.TraceOut;
var
  sTraceText: String;
  iCount: Integer;
  iEnd: Integer;
begin
  {$IFDEF DEBUG}
  if FTraceList.Count > 0 then
  begin
    sTraceText := '';

    for iCount := 0 to FTraceList.Count - 2 do
      sTraceText := sTraceText + '  ';

    ATraceRecord := FTraceList.Items[FTraceList.Count - 1];

    iEnd := GetTickCount;

    sTraceText := sTraceText + 'End ' + ATraceRecord.sProcName;
    sTraceText := sTraceText + ' - (' + (IntToStr(iEnd - ATraceRecord.iBegin)) + ')';

    Dispose(ATraceRecord);
    FTraceList.Delete(FTraceList.Count - 1);

    OutputDebugString(PChar(sTraceText));
  end;
  {$ENDIF}
end;

procedure TmrTraceControl.Write(sUserText: String);
var
  sTraceText: String;
  iCount: Integer;
begin
  {$IFDEF DEBUG}
  sTraceText := '';

  for iCount := 0 to FTraceList.Count - 2 do
    sTraceText := sTraceText + '  ';

  sTraceText := sTraceText + '>> ' + sUserText;

  OutputDebugString(PChar(sTraceText));
  {$ENDIF}
end;

end.
