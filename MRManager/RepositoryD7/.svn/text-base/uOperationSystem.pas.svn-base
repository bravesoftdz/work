unit uOperationSystem;

interface

uses Windows, SysUtils, TlHelp32, Psapi, Classes, shellapi, Registry,
  ActiveX, ComObj, ShlObj;


type
   // added osVista and osW7 by Antonio.
   TOSVersion = (osUnknown, os95, os95OSR2, os98, os98SE, osME, osNT3, osNT4, os2K, osXP, osVista, osW7);

   ShortcutType = (_DESKTOP, _QUICKLAUNCH, _SENDTO, _STARTMENU, _OTHERFOLDER);

   function GetOS(var BuildInfo:String): TOSVersion;
   function ShutdownWin(Reboot:boolean):boolean;
   function ReturnComputerName: string;
   Function IsExeRunning(const sExeName : String): Boolean;
   procedure HardDriveSpace(ADriver : Char; var AFreeSpace, ATotalSpace: Double);

   //Shortcut functions
   function GetProgramDir: string;
   function CreateShortcut(SourceFileName: string; // the file the shortcut points to
                        Location: ShortcutType; // shortcut location
                        SubFolder,  // subfolder of location
                        WorkingDir, // working directory property of the shortcut
                        Parameters,
                        Description, //  description property of the shortcut
                        ShortCutName : String):
                        string;

   //Software is running
   procedure CreateWin9xProcessList(List: TstringList);
   procedure CreateWinNTProcessList(List: TstringList);
   procedure GetProcessList(var List: TstringList);
   function EXE_Running(FileName: string; bFullpath: Boolean): Integer;
   procedure ExecuteShellCommand(cmdline: string; hidden: Boolean);

implementation



function CreateShortcut(SourceFileName: string; // the file the shortcut points to
                        Location: ShortcutType; // shortcut location
                        SubFolder,  // subfolder of location
                        WorkingDir, // working directory property of the shortcut
                        Parameters,
                        Description, //  description property of the shortcut
                        ShortCutName: string):
                        string;
const
  SHELL_FOLDERS_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\Explorer';
  QUICK_LAUNCH_ROOT = 'Software\MicroSoft\Windows\CurrentVersion\GrpConv';
var
  MyObject: IUnknown;
  MySLink: IShellLink;
  MyPFile: IPersistFile;
  Directory, LinkName: string;
  WFileName: WideString;
  Reg: TRegIniFile;
begin

  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile;

  MySLink.SetPath(PChar(SourceFileName));
  MySLink.SetArguments(PChar(Parameters));
  MySLink.SetDescription(PChar(Description));

  LinkName := ShortCutName + '.lnk';

  // Quicklauch
  if Location = _QUICKLAUNCH then
  begin
    Reg := TRegIniFile.Create(QUICK_LAUNCH_ROOT);
    try
      Directory := Reg.ReadString('MapGroups', 'Quick Launch', '');
    finally
      Reg.Free;
    end;
  end
  else
  // Other locations
  begin
    Reg := TRegIniFile.Create(SHELL_FOLDERS_ROOT);
    try
    case Location of
      _OTHERFOLDER : Directory := SubFolder;
      _DESKTOP     : Directory := Reg.ReadString('Shell Folders', 'Desktop', '');
      _STARTMENU   : Directory := Reg.ReadString('Shell Folders', 'Start Menu', '');
      _SENDTO      : Directory := Reg.ReadString('Shell Folders', 'SendTo', '');
    end;
    finally
      Reg.Free;
    end;
  end;

  if Directory <> '' then
  begin
    if (SubFolder <> '') and (Location <> _OTHERFOLDER) then
      WFileName := Directory + '\' + SubFolder + '\' + LinkName
    else
      WFileName := Directory + '\' + LinkName;


    if WorkingDir = '' then
      MySLink.SetWorkingDirectory(PChar(ExtractFilePath(SourceFileName)))
    else
      MySLink.SetWorkingDirectory(PChar(WorkingDir));

    MyPFile.Save(PWChar(WFileName), False);
    Result := WFileName;
  end;
end;

function GetProgramDir: string;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False);
    Result := reg.ReadString('Programs');
    reg.CloseKey;
  finally
    reg.Free;
  end;
end;

procedure ExecuteShellCommand(cmdline: string; hidden: Boolean);
const
  flags: array [Boolean] of Integer = (SW_SHOWNORMAL, SW_HIDE);
var
  cmdbuffer: array [0..MAX_PATH] of Char;
begin
  GetEnvironmentVariable('COMSPEC', cmdBUffer, SizeOf(cmdBuffer));
  StrCat(cmdbuffer, ' /C ');
  StrPCopy(StrEnd(cmdbuffer), cmdline);
  WinExec(cmdbuffer, flags[hidden]);
end;


function EXE_Running(FileName: string; bFullpath: Boolean): Integer;
var
  i: Integer;
  MyProcList: TstringList;
begin
  MyProcList := TStringList.Create;
  Result := 0;
  try
    GetProcessList(MyProcList);
    if MyProcList = nil then Exit;
    for i := 0 to MyProcList.Count - 1 do
    begin
      if not bFullpath then
      begin
        if CompareText(ExtractFileName(MyProcList.Strings[i]), FileName) = 0 then
          Result := Result + 1
      end
      else if CompareText(MyProcList.strings[i], FileName) = 0 then
        Result := Result + 1;
    end;
  finally
    MyProcList.Free;
  end;
end;

procedure GetProcessList(var List: TstringList);
var
  ovi: TOSVersionInfo;
begin

  if List = nil then
    Exit;

  ovi.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(ovi);

  case ovi.dwPlatformId of
    VER_PLATFORM_WIN32_WINDOWS: CreateWin9xProcessList(List);
    VER_PLATFORM_WIN32_NT: CreateWinNTProcessList(List);
  end;

end;

procedure CreateWin9xProcessList(List: TstringList);
var
  hSnapShot: THandle;
  ProcInfo: TProcessEntry32;
begin
  if List = nil then
    Exit;

  hSnapShot := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if (hSnapShot <> THandle(-1)) then
  begin
    ProcInfo.dwSize := SizeOf(ProcInfo);
    if (Process32First(hSnapshot, ProcInfo)) then
    begin
      List.Add(ProcInfo.szExeFile);
      while (Process32Next(hSnapShot, ProcInfo)) do
        List.Add(ProcInfo.szExeFile);
    end;
    CloseHandle(hSnapShot);
  end;

end;

procedure CreateWinNTProcessList(List: TstringList);
var
  PIDArray: array [0..1023] of DWORD;
  cb: DWORD;
  I: Integer;
  ProcCount: Integer;
  hMod: HMODULE;
  hProcess: THandle;
  ModuleName: array [0..300] of Char;
begin
  if List = nil then
    Exit;

  EnumProcesses(@PIDArray, SizeOf(PIDArray), cb);
  ProcCount := cb div SizeOf(DWORD);

  for I := 0 to ProcCount - 1 do
  begin
    hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or
      PROCESS_VM_READ,
      False,
      PIDArray[I]);
    if (hProcess <> 0) then
    begin
      EnumProcessModules(hProcess, @hMod, SizeOf(hMod), cb);
      GetModuleFilenameEx(hProcess, hMod, ModuleName, SizeOf(ModuleName));
      List.Add(ModuleName);
      CloseHandle(hProcess);
    end;
  end;
  
end;

procedure HardDriveSpace(ADriver : Char; var AFreeSpace, ATotalSpace: Double);
begin
  AFreeSpace  := DiskFree(Ord(ADriver) - 64);
  ATotalSpace := DiskSize(Ord(ADriver) - 64);
end;

Function IsExeRunning(const sExeName : String): Boolean;
var
  SnapProcHandle: THandle;
  ProcEntry: TProcessEntry32;
  NextProc: Boolean;
begin
  result := False;

  SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if SnapProcHandle = INVALID_HANDLE_VALUE then
    exit;

  ProcEntry.dwSize := SizeOf(ProcEntry);
  NextProc := Process32First(SnapProcHandle, ProcEntry);
  while NextProc do begin
       if UpperCase(StrPas(ProcEntry.szExeFile)) = UpperCase(sExeName) then begin
          result := True;
          break;
       end;
       NextProc := Process32Next(SnapProcHandle, ProcEntry);
  end;
  CloseHandle(SnapProcHandle);
end;

function ReturnComputerName: string;
var
   CompName: PChar;
   AComputer : string;
   AWritten: Cardinal;
begin

   SetLength(AComputer, MAX_COMPUTERNAME_LENGTH + 1);
   AWritten := Length(AComputer);

   GetMem(CompName, AWritten);
   try
      GetComputerName(CompName, AWritten);
      Result := CompName;
   finally
      FreeMem(CompName);
   end;
end;


function ShutdownWin(Reboot:boolean):boolean;
var
   hToken : THandle;
   tkp,p : TTokenPrivileges;
   RetLen : DWord;
   Reply : DWord;
begin

  Result:=false;

  case Win32Platform of
     VER_PLATFORM_WIN32_WINDOWS: //***Windows 9x/ME***//
         result:= ExitWindowsEx(EWX_POWEROFF or EWX_SHUTDOWN or EWX_FORCE,0);
     VER_PLATFORM_WIN32_NT: //***Windows NT/2000/XP***//
        begin
        if OpenProcessToken(GetCurrentProcess,TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,hToken) then
           begin
           if LookupPrivilegeValue(nil,'SeShutdownPrivilege',tkp.Privileges[0].Luid) then
              begin
              tkp.PrivilegeCount := 1;
              tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
              AdjustTokenPrivileges(hToken,False,tkp,SizeOf(TTokenPrivileges),p,RetLen);
              Reply := GetLastError;
              if Reply = ERROR_SUCCESS then
                 if Reboot then
                    begin
                    result:= ExitWindowsEx(EWX_REBOOT or EWX_FORCE, 0);
                    exit;
                    end;
              result:= ExitWindowsEx(EWX_POWEROFF or EWX_FORCE, 0);
              end;
           end;
        end;
  end; //end case

end;


function GetOS(var BuildInfo:String): TOSVersion;
var
    OS: TOSVersionInfo;
begin
   ZeroMemory(@OS,SizeOf(OS));
   OS.dwOSVersionInfoSize := SizeOf(OS);
   GetVersionEx(OS);
   Result := osUnknown;

   if OS.dwPlatformId = VER_PLATFORM_WIN32_NT then
       case OS.dwMajorVersion of
          3: Result := osNT3;
          4: Result := osNT4;
          5: begin
             case OS.dwMinorVersion of
                0: Result:= os2K;
                1: Result:= osXP;
                end;
             end;
          6: begin
               case OS.dwMinorVersion of
                  0: result := osVista;
                  1: result := osW7;
               end;
             end;
      end
   else
      if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 0) then
          begin
          Result := os95;
          if (Trim(OS.szCSDVersion) = 'B') then
              Result := os95OSR2;
          end
   else
      if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 10) then
          begin
          Result := os98;
          if Trim(OS.szCSDVersion) = 'A' then
             Result := os98SE;
          end
   else
      if (OS.dwMajorVersion = 4) and (OS.dwMinorVersion = 90) then
          begin
          Result := osME;
          end;

  BuildInfo := Format('%d.%.2d.%d', [OS.dwMajorVersion, OS.dwMinorVersion, OS.dwBuildNumber and $FFFF]);
   
end;


end.
