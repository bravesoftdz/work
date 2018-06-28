{ *********************************************************************** }
{                                                                         }
{ Author: Yanniel Alvarez Alfonso                                         }
{ Description: Miscellaneous routines                                     }
{ Copyright (c) ????-2012 Pinogy Corporation                              }
{                                                                         }
{ *********************************************************************** }

unit MiscUtils;

interface

uses
  Windows, SysUtils, Classes;

function  ExecuteProgram(aExecutable, ParamStr: string;
                         var ProcID: DWord; aWait: Boolean): DWord;
function  ConnectNetDrive(aUNCPath, aUsername, aPassword: string; out aDrive: string): Boolean;
function  DisconnectNetDrive(aDrive: string): Boolean;
function  GetResourceAsString(ResName: pchar; ResType: pchar): string;
procedure StrToFile(aStr, aFileName: String);
function GetComputerNetName: string;


implementation

uses
  Forms, NetDrive;

function ExecuteProgram(aExecutable, ParamStr: string;
                        var ProcID: DWord; aWait: Boolean): DWord;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: Boolean;
  ErrorCode,
  AppDone: DWord; 
begin
  ErrorCode:= 0;
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb:= SizeOf(TStartupInfo);

  CreateOK:= Windows.CreateProcess(nil,
             PChar(aExecutable + ' ' + ParamStr),
             nil, nil, False,
             CREATE_NEW_PROCESS_GROUP + IDLE_PRIORITY_CLASS + SYNCHRONIZE,
             nil, nil, StartInfo, ProcInfo);
  WaitForInputIdle(ProcInfo.hProcess, INFINITE);

  if CreateOK then
    if aWait then
    begin
      repeat
        AppDone:= WaitForSingleObject(ProcInfo.hProcess, 10);
        Application.ProcessMessages;
      until AppDone <> WAIT_TIMEOUT;
      CloseHandle(ProcInfo.hProcess);
      CloseHandle(ProcInfo.hThread);
    end
    else
      procid:= ProcInfo.hProcess;

  GetExitCodeProcess(ProcInfo.hProcess, ErrorCode);
  Result:= ErrorCode;
end;

function ConnectNetDrive(aUNCPath, aUsername, aPassword: string; out aDrive: string): Boolean;
var
  NetFolder: TNetDrive;
  Error: string;
begin
  if aUNCPath = '' then Exit;

  Result:= False;
  NetFolder:= TNetDrive.Create(nil);
  try
    NetFolder.Connect(aUNCPath, aUsername, aPassword, Error);
    Result:= (Length(NetFolder.Drive) >= 2) and
             (NetFolder.Drive[Length(NetFolder.Drive)] = ':');
    if Result then
      aDrive:= NetFolder.Drive;
  finally
    NetFolder.Free;
  end;
end;

function DisconnectNetDrive(aDrive: string): Boolean;
var
  NetFolder: TNetDrive;
  Error: string;
begin
  if aDrive = '' then Exit;
  Result:= False;
  NetFolder:= TNetDrive.Create(nil);
  try
    NetFolder.Drive:= aDrive;
    Result:= NetFolder.Disconnect(Error);
  finally
    NetFolder.Free;
  end;
end;

function GetResourceAsPointer(ResName: pchar; ResType: pchar;
                              out Size: longword): pointer;
var
  InfoBlock: HRSRC;
  GlobalMemoryBlock: HGLOBAL;
begin
  InfoBlock := FindResource(hInstance, resname, restype);
  if InfoBlock = 0 then
    raise Exception.Create(SysErrorMessage(GetLastError));
  size := SizeofResource(hInstance, InfoBlock);
  if size = 0 then
    raise Exception.Create(SysErrorMessage(GetLastError));
  GlobalMemoryBlock := LoadResource(hInstance, InfoBlock);
  if GlobalMemoryBlock = 0 then
    raise Exception.Create(SysErrorMessage(GetLastError));
  Result := LockResource(GlobalMemoryBlock);
  if Result = nil then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetResourceAsString(ResName: pchar; ResType: pchar): string;
var
  ResData: PChar;
  ResSize: Longword;
begin
  ResData := GetResourceAsPointer(resname, restype, ResSize);
  SetString(Result, ResData, ResSize);
end;

procedure StrToFile(aStr, aFileName: String);
var
  Stream: TStream;
begin 
  Stream := TFileStream.Create(aFileName, fmCreate);
  try
    Stream.WriteBuffer(Pointer(aStr)^, Length(aStr));
  finally
    Stream.Free;
  end; 
end;

function GetComputerNetName: string;
var
  nBuffer: array[0..255] of char;
  nSize: dword;
begin
  Result := '';
  nSize := 256;
  if GetComputerName(nBuffer, nSize) then
    Result := Trim(nBuffer);
end;

end.
