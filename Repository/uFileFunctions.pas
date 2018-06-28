unit uFileFunctions;

interface

uses SysUtils, Windows, Classes, Consts;

type
  EInvalidDest = class(EStreamError);
  EFCantMove = class(EStreamError);

procedure CopyFile(const FileName, DestName: TFileName; IsNewFile : Boolean);
procedure MoveFile(const FileName, DestName: string);
function GetFileSize(const FileName: string): LongInt;
function FileDateTime(const FileName: string): TDateTime;
function HasAttr(const FileName: string; Attr: Word): Boolean;
function ExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
function WaitExecute(sEXE: String) : boolean;
procedure SelfDelete(sEXE:String);
procedure SaveTextFile(sFile, Text:String);
function ReadTextFile(sFile:String):String;

implementation

uses Forms, ShellAPI;

const
  SInvalidDest = 'Destination %s does not exist';
  SFCantMove = 'Cannot move file %s';


function ReadTextFile(sFile:String):String;
var
   F: TextFile;
   L: String;
   T :TStringList;
begin

   Try
     T := TStringList.Create;
     AssignFile(F, sFile);
     Reset(F);

     While not Eof(F) do
       begin
       ReadLn(F, L);
       T.Add(L); 
       end;
       Result := Trim(T.Text);
   Finally
     CloseFile(F);
     FreeAndNil(T);
     end;
     
end;


procedure SaveTextFile(sFile, Text:String);
var
 f: TextFile;

 BatchFile : TStringList;

begin

  //FileCreate(sFile);
  BatchFile := nil;

  Try
      BatchFile := TStringList.Create;
      BatchFile.Add(Text);
      BatchFile.SaveToFile(sFile);
  Finally
      BatchFile.Free;
      end;

{    try
       AssignFile(f, sFile);
       Append(f);
       Writeln(f, Text);
    Finally
       CloseFile(f);
       end;
  }
end;

procedure SelfDelete(sEXE:String);
var
  BatchFile : TStringList;
  BatchName : String;
begin

   // create a batchfile to remove the calling App
   BatchFile := nil;
   Try
       BatchName := ChangeFileExt(sEXE, '.bat');
       FileSetAttr(sEXE,0);   // remove all attributes
       BatchFile := TStringList.Create;
       BatchFile.Add(':label1');
       BatchFile.Add('del "' + sEXE+ '"');
       BatchFile.Add('if exist "' + sEXE + '" goto label1');
       BatchFile.Add('del ' + sEXE);
       BatchFile.Add('del "' + BatchName + '"');
       BatchFile.SaveToFile(BatchName);
       WinExec(PChar(BatchName), SW_HIDE);
   Finally
       BatchFile.Free;
       end;

end;

function WaitExecute(sEXE: String) : boolean;
var
   aTSI : TStartupInfo;
   aTPI : TProcessInformation;
   iRet : Integer;
   cRet : cardinal;
   b    : boolean;
begin
  result := false;
  FillChar(aTSI, SizeOf(aTSI), #0);
  FillChar(aTPI, SizeOf(aTPI), #0);
  aTSI.CB := SizeOf(aTSI);
  if not CreateProcess(nil, PChar(sEXE), nil, nil, False,
                       NORMAL_PRIORITY_CLASS,
                       nil, nil, aTSI, aTPI) then RaiseLastWin32Error;

  repeat
    iRet := MsgWaitForMultipleObjects(1, aTPI.hProcess, False, INFINITE, (QS_ALLINPUT));
    if iRet <> (WAIT_OBJECT_0) then
       Application.ProcessMessages;
  until
    iRet = (WAIT_OBJECT_0);

   b := getExitCodeProcess(aTPI.hProcess,cRet);

   if cRet = 0 then
      result := true;

   CloseHandle(aTPI.hProcess);

end;


procedure CopyFile(const FileName, DestName: TFileName; IsNewFile : Boolean);
var
  CopyBuffer: Pointer; { buffer for copying }
  BytesCopied: Longint;
  Source, Dest: Integer; { handles }
  Destination: TFileName; { holder for expanded destination name }
const
  ChunkSize: Longint = 8192; { copy in 8K chunks }
begin
  Destination := ExpandFileName(DestName); { expand the destination path }
  if HasAttr(Destination, faDirectory) and not IsNewFile then { if destination is a directory... }
    Destination := Destination + '\' + ExtractFileName(FileName); { ...clone file name }
  GetMem(CopyBuffer, ChunkSize); { allocate the buffer }
  try
    Source := FileOpen(FileName, fmShareDenyWrite); { open source file }
    if Source < 0 then raise EFOpenError.CreateFmt(SFOpenError, [FileName]);
    try
      Dest := FileCreate(Destination); { create output file; overwrite existing }
      if Dest < 0 then raise EFCreateError.CreateFmt(SFCreateError, [Destination]);
      try
        repeat
          BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize); { read chunk }
          if BytesCopied > 0 then { if we read anything... }
            FileWrite(Dest, CopyBuffer^, BytesCopied); { ...write chunk }
        until BytesCopied < ChunkSize; { until we run out of chunks }
      finally
        FileClose(Dest); { close the destination file }
      end;
    finally
      FileClose(Source); { close the source file }
    end;
  finally
    FreeMem(CopyBuffer, ChunkSize); { free the buffer }
  end;
end;


{ MoveFile procedure }
{
  Moves the file passed in FileName to the directory specified in DestDir.
  Tries to just rename the file.  If that fails, try to copy the file and
  delete the original.

  Raises an exception if the source file is read-only, and therefore cannot
  be deleted/moved.
}

procedure MoveFile(const FileName, DestName: string);
var
  Destination: string;
begin
  Destination := ExpandFileName(DestName); { expand the destination path }
  if not RenameFile(FileName, Destination) then { try just renaming }
  begin
    if HasAttr(FileName, faReadOnly) then  { if it's read-only... }
      raise EFCantMove.Create(Format(SFCantMove, [FileName])); { we wouldn't be able to delete it }
      CopyFile(FileName, Destination, False); { copy it over to destination...}
//      DeleteFile(FileName); { ...and delete the original }
  end;
end;

{ GetFileSize function }
{
  Returns the size of the named file without opening the file.  If the file
  doesn't exist, returns -1.
}

function GetFileSize(const FileName: string): LongInt;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
    Result := SearchRec.Size
  else Result := -1;
end;

function FileDateTime(const FileName: string): System.TDateTime;
begin
  Result := FileDateToDateTime(FileAge(FileName));
end;

function HasAttr(const FileName: string; Attr: Word): Boolean;
begin
  Result := (FileGetAttr(FileName) and Attr) = Attr;
end;

function ExecuteFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
var
  zFileName, zParams, zDir: array[0..79] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
    StrPCopy(zFileName, FileName), StrPCopy(zParams, Params),
    StrPCopy(zDir, DefaultDir), ShowCmd);
end;


end.
