unit uMRTraceControl;

interface

uses Classes, SysUtils, Windows, MConnect, ADODB, uSaveToFile;

type
  TTraceList = ^AList;

  AList = record
    iBegin: Integer;
    sProcName: String;
    sRecordId: String;
  end;

  TMRTraceControl = class(TObject)
  private
    FException: WideString;
    FClassException: String;
    FTraceList: TList;
    ATraceRecord: TTraceList;
    FADOConn: TADOConnection;
    procedure InsertAppHistory(AIDUser: Integer; ASource : String; AErrorMessage: WideString);
    function GetLastTrace: String;
    procedure InsertAppFileHistory(APath : String; AErrorMessage: WideString);
  public
    constructor Create;
    destructor Destroy; override;
    procedure TraceIn (sProcName: String; sRecordId: String = '');
    procedure TraceOut;
    procedure Write (sUserText: String);
    procedure SetException(AException : WideString; AClassException: String);
    procedure SaveTrace(AIDUser: Integer); overload;
    procedure SaveTrace(AIDUser: Integer; AException, AClass: String); overload;
    procedure SaveTraceFile(AIDUser: Integer; AException, AClass, APath: String);
    function TraceResult(Exception: WideString): WideString;
    property LastTrace: String read GetLastTrace;
    property ADOConn: TADOConnection read FADOConn write FADOConn;
  end;

implementation

{$DEFINE DEBUG}
{ TMRTraceControl }

procedure TMRTraceControl.SaveTraceFile(AIDUser: Integer; AException, AClass,
  APath: String);
var
  sError : String;
begin

  sError := FormatDateTime('mm/dd/yyyy hh:mm', now);
  sError := sError + ' U:' + IntToStr(AIDUser) + ' C:' + AClass + ' E:' + AException;

  if APath = '' then
    APath := 'C:\';

  InsertAppFileHistory(APath, sError);

end;


procedure TMRTraceControl.InsertAppFileHistory(APath : String; AErrorMessage: WideString);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := APath + 'MR_Sis_AppHistory.txt';
    fFile.OpenFile;
    fFile.InsertText(AErrorMessage,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;


constructor TMRTraceControl.Create;
begin
  inherited Create;
  FTraceList := TList.Create;
end;

destructor TMRTraceControl.Destroy;
begin

  while FTraceList.Count > 0 do
  begin
    ATraceRecord := FTraceList.Items[0];
    if ATraceRecord <> nil then
      Dispose(ATraceRecord);
    FTraceList.Delete(0);
  end;

  FreeAndNil(FTraceList);

  inherited Destroy;
end;

function TMRTraceControl.GetLastTrace: String;
begin
  if FTraceList.Count > 0 then
    Result := TTraceList(FTraceList[FTraceList.Count - 1]).sProcName
  else
    Result := ''; 
end;

procedure TMRTraceControl.SaveTrace(AIDUser: Integer);
begin
  if FException <> '' then
  begin
    InsertAppHistory(AIDUser, FClassException, FException);
    FException := '';
  end;
end;

procedure TMRTraceControl.InsertAppHistory(AIDUser: Integer;
  ASource : String; AErrorMessage: WideString);
var
  CmdLog : TADOStoredProc;
begin

  CmdLog := TADOStoredProc.Create(nil);
  try
    CmdLog.Connection     := FADOConn;
    CmdLog.CommandTimeout := 360;
    CmdLog.ProcedureName  := 'sp_Sis_AppHistory_Add;1';
    CmdLog.Parameters.Refresh;
    //CmdLog.CommandText    := 'EXEC sp_Sis_AppHistory_Add :IDUser, 1, 0, :Software, :Source, :ErrorMsg ';
    CmdLog.Parameters.ParamByName('@IDUsuario').Value    := AIDUser;
    CmdLog.Parameters.ParamByName('@ErrorLevel').Value   := 1;
    CmdLog.Parameters.ParamByName('@SystemError').Value  := 0;
    CmdLog.Parameters.ParamByName('@Software').Value     := 'MainRetail';
    CmdLog.Parameters.ParamByName('@FormSource').Value   := ASource;
    CmdLog.Parameters.ParamByName('@ErrorMessage').Value := AErrorMessage;
    CmdLog.ExecProc;
  finally
    FreeAndNil(CmdLog);
    end;

  //FADOConn.Execute('EXEC sp_Sis_AppHistory_Add ' + IntToStr(AIDUser) +
  //  ', 1, 0, ' + QuotedStr('MainRetail') + ', ' + QuotedStr(ASource) + ', ' + #39 + AErrorMessage + #39 );
end;

procedure TMRTraceControl.SaveTrace(AIDUser: Integer; AException, AClass: String);
begin
  InsertAppHistory(AIDUser, AClass, TraceResult(AException));
end;

procedure TMRTraceControl.SetException(AException : WideString; AClassException: String);
begin
  if FException = '' then
  begin
    FException := TraceResult(AException);
    FClassException := AClassException;
  end;
end;

procedure TMRTraceControl.TraceIn(sProcName: String; sRecordId: String);
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

  sTraceText := sTraceText + 'Início ' + sProcName;

  OutputDebugString(PChar(sTraceText));
  {$ENDIF}
end;

procedure TMRTraceControl.TraceOut;
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

    sTraceText := sTraceText + 'Fim ' + ATraceRecord.sProcName;
    sTraceText := sTraceText + ' - (' + (IntToStr(iEnd - ATraceRecord.iBegin)) + ')';

    if ATraceRecord <> nil then
      Dispose(ATraceRecord);

    FTraceList.Delete(FTraceList.Count - 1);

    OutputDebugString(PChar(sTraceText));
  end;
  {$ENDIF}
end;

function TMRTraceControl.TraceResult(Exception: WideString): WideString;
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
      Methods := Methods + TTraceList(FTraceList[I]).sProcName + '->';
      if TTraceList(FTraceList[I]).sRecordId <> '' then
        RecordId := RecordId + TTraceList(FTraceList[I]).sRecordId + '|';
    end;
    Delete(Methods, Length(Methods)-1, 2);
    Delete(RecordId, Length(RecordId), 1);
    FTraceList.Clear;
  end;

  Result := Methods + '. Error: ' + Exception;
  if RecordId <> '' then
    Result := Result + '. ID: ' + RecordId;
end;

procedure TMRTraceControl.Write(sUserText: String);
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
