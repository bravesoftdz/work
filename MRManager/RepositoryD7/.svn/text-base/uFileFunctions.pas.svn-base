unit uFileFunctions;

interface

uses SysUtils, Windows, Classes, Consts, Forms, ShellAPI;

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
function RunFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
function WaitExecute(sEXE: String) : boolean;
procedure SelfDelete(sEXE:String);
procedure SaveTextFile(sFile, Text:String);
function ReadTextFile(sFile:String):String;
function DeleteFolder(folderName: string): boolean;
function DelTree(DirName: string): Boolean;
procedure LoadFileNoLock(ALista: TStringList; const FileName: string);
function CopyFolder(const SrcFolder, DestFolder: String; iFileOp: UINT;
  OverWrite: Boolean; ShowDialog: Boolean): Boolean;
function FileDelete(_from: String):Boolean;
function CanOpenFileFS(const Filename: string): boolean;

implementation

const
  SInvalidDest = 'Destination %s does not exist';
  SFCantMove = 'Cannot move file %s';


function CanOpenFileFS(const Filename: string): boolean;
var
  FS : TFileStream;
begin
  try
    FS := TFileStream.Create(Filename, fmOpenRead OR fmShareDenyNone);
    Result := True;
    FS.Free;
  except
    on EStreamError do
      Result := False;
  end;
end;


function FileDelete(_from: String): Boolean;
var
    f: TSHFileOPStruct;
    f_from, f_to: array[0..255] of char;
    k:integer;
begin
  Result := True;

  if FileExists(_from) then
  try
    for k:=0 to 255 do
    begin
     f_from[k]:=#0;
     f_to[k]:=#0;
    end;
    F.Wnd := application.handle;
    F.wFunc := FO_DELETE;
    strpcopy(f_from, _from);
    F.pFrom := f_from;
    F.pTo := f_from;
    F.fFlags :=  FOF_NOCONFIRMATION;
    if ShFileOperation(F) <> 0 then
      Exception.Create('Detele error.');
  except
    raise;
    Result := False;
    end;
end;

function CopyFolder(const SrcFolder, DestFolder: String; iFileOp: UINT;
  OverWrite: Boolean; ShowDialog: Boolean): Boolean;
{
     Copies or moves ...\SrcFolder to ...\DestFolder\SrcFolder\*.*

     Example:
       Copy C:\AFolder\SubFolder and it's contents to
            C:\AnotherFolder\SubFolder
            and prompt to replace existing files.

       CopyFolder('C:\AFolder\SubFolder', 'C:\AnotherFolder', FOF_COPY, true);

     FO_MOVE
     FO_COPY
     FO_DELETE
     FO_RENAME

}
var
   // declare structure
   MyFOStruct: TSHFileOpStruct;
   Src,
   Dest:       String;
   ResultVal:  Integer;
begin
   result := false;

   Src := SrcFolder;
   Dest := DestFolder;

   if (Src = '') or
      ( (iFileOp <> FO_DELETE) and (Dest = '') ) or
      (CompareText(Src, Dest) = 0) then
        exit;

   if Src[Length(Src)] = '\' then
     SetLength( Src, Length(Src) -1 );
   Src := Src +#0#0;

   if (Dest <> '') and (Dest[Length(Dest)] = '\') then
     SetLength( Dest, Length(Dest) -1 );
   Dest := Dest + #0#0;

   // zero structure
   // ! Mandatory in XP
   FillChar( MyFOStruct, SizeOf(MyFOStruct), 0 );

   // Fill in structure
   with MyFOStruct do begin
     Wnd := 0;

     // specify a copy operation
     wFunc := iFileOp;
     pFrom := @Src[1];
     pTo := @Dest[1];

     // set the flags
     fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION;

     if not OverWrite then fFlags := fFlags or FOF_RENAMEONCOLLISION;
     if not ShowDialog then fFlags := fFlags or FOF_SILENT;
   end;

   try
     MyFOStruct.fAnyOperationsAborted := False;
     MyFOStruct.hNameMappings := nil;
     Resultval := ShFileOperation(MyFOStruct);
     Result := (ResultVal = 0);
   finally
   end;

end;

Function DelTree(DirName : string): Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end;
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;

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
  SFOpenError, SFCreateError : String;
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

function RunFile(const FileName, Params, DefaultDir: string;
  ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
    PChar(FileName), PChar(Params), PChar(DefaultDir), ShowCmd);
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

function DeleteFolder(folderName: string): boolean;
(* From ShellApi
 FO_MOVE
 FO_COPY
 FO_DELETE
 FO_RENAME
 FOF_MULTIDESTFILES
 FOF_CONFIRMMOUSE
 FOF_SILENT                  { don't create progress/report }
 FOF_RENAMEONCOLLISION
 FOF_NOCONFIRMATION          { Don't prompt the user. }
 FOF_WANTMAPPINGHANDLE       { Fill in SHFILEOPSTRUCT.hNameMappings
                               Must be freed using SHFreeNameMappings }
 FOF_ALLOWUNDO               { whether to use recycle bin for deletes etc }
 FOF_FILESONLY               { on *.*, do only files }
 FOF_SIMPLEPROGRESS          { means don't show names of files }
 FOF_NOCONFIRMMKDIR          { don't confirm making any needed dirs }
 FOF_NOERRORUI               { don't put up error UI }
*)
// Folder need not be empty. Returns true unless error or user abort
var
 r: TshFileOpStruct;
 i: integer;
begin
 folderName := folderName + #0#0;
 result := false;
 i := GetFileAttributes(PChar(folderName));
 if (i = -1) or (i and FILE_ATTRIBUTE_DIRECTORY <> FILE_ATTRIBUTE_DIRECTORY) then EXIT;

 fillchar(r, sizeof(r), 0);
 r.wFunc := FO_DELETE;
 r.pFrom := pChar(folderName);
 r.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_ALLOWUNDO;

 result := (ShFileOperation(r) = 0) and not r.fAnyOperationsAborted and (getFileAttributes(pChar(folderName)) = -1);
end;

procedure LoadFileNoLock(ALista: TStringList; const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    ALista.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;



end.
