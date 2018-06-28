unit uOperationSystem;

interface

uses Windows, SysUtils;

type
   // added osVista and osW7 by Antonio.
   TOSVersion = (osUnknown, os95, os95OSR2, os98, os98SE, osME, osNT3, osNT4, os2K, osXP, osVista, osW7);


   function GetOS(var BuildInfo:String): TOSVersion;

implementation

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
