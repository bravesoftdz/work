unit Utilities;

interface

uses
  Windows, Classes, Graphics, Forms;

function  IsNumeric(Value: string): boolean;
function  IsFloating(Value: string): boolean;
function  IsQuoted(Value: string): boolean;
function  AddBackSlash(const sPath: string): string;
function  RemoveBackSlash(const sPath: string): string;
function  GetStrFromRsc(RscNum: integer): string;
function  GetToken(var s: string; const sDelimiter: string): string;
function  GetVersionInfo(const Filename: string; const Key: string; var sVersion: string): DWord;
function  BooleanToStr(bTmp: boolean): string;
function  CrStrToBoolean (const sValue: string): boolean;
function  CrBooleanToStr (const bValue: boolean; ResultAsNum: boolean): string;
function  CrStrToInteger (const sValue: string): integer;
function  CrStrToFloating (const sValue: string): double;
function  CrFloatingToStr (const fValue: double): string;
function  IsStrEmpty (const sValue: string): boolean;
function  IsStringListEmpty (const sList : TStrings): boolean;
function  TruncStr (sValue: string): string;
function  RTrimList (const sList: TStrings): string;
function  RemoveSpaces (const sValue: string): string;
function  ReplaceString (sOld,sNew: string; var sMain: string): boolean;
function  ColorState(Enable: boolean): TColor;
{Form Position}
procedure LoadFormPos(frmTemp: TForm);
procedure SaveFormPos(frmTemp: TForm);
procedure LoadFormSize(frmTemp: TForm);
procedure SaveFormSize(frmTemp: TForm);

implementation

uses SysUtils, Registry;

{******************************************************************************}
{ Utility Functions                                                            }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ IsNumeric                                                                    }
{------------------------------------------------------------------------------}
function IsNumeric(Value: string): boolean;
var
  i          : integer;
  s          : string;
  hasNumbers : boolean;
begin
  Result := True;
  hasNumbers := False;
  s := Trim(Value);
  if Length(s) = 0 then
  begin
    Result := False;
    Exit;
  end;
  for i := 1 to Length(s) do
  begin
    case Ord(s[i]) of
      36     : {"$" for currency numbers};
      45     : {- for negative numbers};
      40,41  : {() for negative specified by brackets};
      48..57 : hasNumbers := True; {0 to 9}
      else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
  if not hasNumbers then
    Result := False;
end;
{------------------------------------------------------------------------------}
{ IsFloating                                                                   }
{------------------------------------------------------------------------------}
function IsFloating(Value: string): boolean;
var
  hasNumbers : boolean;
  hasDecimal : boolean;
  s          : string;
  i          : integer;
begin
  Result := True;
  hasDecimal := False;
  hasNumbers := False;
  s := Trim(Value);
  if Length(s) = 0 then
  begin
    Result := False;
    Exit;
  end;
  for i := 1 to Length(s) do
  begin
    case Ord(s[i]) of
      36     : {"$" for currency numbers};
      45     : {- for negative numbers};
      40,41  : {() for negative specified by brackets};
      46     : begin  {Decimal}
                 if hasDecimal then
                 begin
                   Result := False;
                   Exit;
                 end
                 else
                 begin
                   hasDecimal := True;
                   Continue;
                 end;
               end;
      48..57 : hasNumbers := True; {Numbers}
      else
        begin
          Result := False;
          Exit;
        end;
    end;
  end;
  if not hasNumbers then
    Result := False;
end;
{------------------------------------------------------------------------------}
{ IsQuoted                                                                     }
{------------------------------------------------------------------------------}
function IsQuoted(Value: string): boolean;
var
  s       : string;
  bSingle : boolean;
begin
  Result := False;
  s := Trim(Value);
  if Length(s) = 0 then
  begin
    Result := True;
    Exit;
  end;
  if Length(s) = 1 then
    Exit;
  {First Quote}
  if (Ord(s[1]) = 34) {double quote} or (Ord(s[1]) = 39) {single quote} then
  begin
    bSingle := (Ord(s[1]) = 39);
    {Last Quote}
    if bSingle then
    begin 
      if (Ord(s[Length(s)]) = 39) then Result := True;
    end
    else
    begin
      if (Ord(s[Length(s)]) = 34) then Result := True;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ AddBackSlash                                                                 }
{------------------------------------------------------------------------------}
function AddBackSlash(const sPath: string): string;
var
  L: Integer;
begin
  Result := Trim(sPath);
  L := Length(Result);
  if (L > 3) then
  begin
    if not (Result[L] = '\') then
      Result := Result + '\';
  end;
end;
{------------------------------------------------------------------------------}
{ RemoveBackSlash                                                              }
{------------------------------------------------------------------------------}
function RemoveBackSlash(const sPath: string): string;
var
  S : string;
  L : Integer;
begin
  Result := Trim(sPath);
  S := Trim(sPath);
  L := Length(S);
  if L > 3 then
  begin
    if S[L] = '\' then
      Result := Copy(S, 1, L-1);
  end;
end;
{------------------------------------------------------------------------------}
{ GetToken                                                                     }
{   - Searches a string for a delimiter                                        }
{   - The string before the delimiter is returned                              }
{   - The original string has the substring and delimiter removed              }
{------------------------------------------------------------------------------}
function GetToken(var s: string; const sDelimiter: string): string;
var
  nPos, nOfs, nLen : Byte;
  sTmp             : string;
begin
  {Get the position of the Delimiter}
  nPos := Pos(sDelimiter, s);
  {Get the length of the Delimiter}
  nLen := Length(sDelimiter);
  nOfs := nLen - 1;
  if (IsStrEmpty(s)) or ((nPos = 0) and (Length(s) > 0)) then
  begin
    Result := s;
    s := '';
  end
  else
  begin
    sTmp := Copy(s, 1, nPos + nOfs);
    s := Copy(s, nPos + nLen, Length(s));
    Result := Copy(sTmp, 1, Length(sTmp) - nLen);
  end;
end; { GetToken }
{------------------------------------------------------------------------------}
{  GetStrFromRsc function : Get String from Resource File                      }
{------------------------------------------------------------------------------}
function GetStrFromRsc(RscNum: integer): string;
var
  ErrorBuf : array[0..255] of Char;
begin
  Result := '';
  if LoadString(hInstance, RscNum, Addr(ErrorBuf), 256) <> 0 then
    Result := StrPas(ErrorBuf);
end;
{------------------------------------------------------------------------------}
{ Extract information from a file's VERSIONINFO resource                       }
{------------------------------------------------------------------------------}
function GetVersionInfo(const Filename: string; const Key: string;
  var sVersion: string): DWord;
type
  {Translation table: specifies languages & character sets}
  VerLangCharSet = record
    Lang    : Word;
    CharSet : Word;
  end;
  VerTranslationTable = array[0..MaxListSize] of VerLangCharSet;
  pVerTranslationTable = ^VerTranslationTable;
var
  sFileName    : string;
  Size         : DWord;
  InfoHandle   : DWord;
  fHandle      : THandle;
  pData        : Pointer;
  Buffer       : Pointer;
  Len          : DWord;
  pTable       : pVerTranslationTable;
  sLangCharSet : string;
  Path         : string;
  sTmp         : string;
begin
  Result := 0;
  sVersion := '7,0,0,0';

  sFileName := FileName;
  {GetFileVersionInfoSize}
  Size := GetFileVersionInfoSize(PChar(sFileName), InfoHandle);
  if Size = 0 then
  begin
    Result := GetLastError;
    Exit;
  end;

  {GlobalAlloc}
  fHandle := GlobalAlloc(GMEM_FIXED, Size);
  if fHandle = 0 then
  begin
    Result := GetLastError;
    Exit;
  end;

  {GlobalLock}
  pData := GlobalLock(fHandle);
  if pData = nil then
  begin
    if fHandle <> 0 then
      GlobalFree(fHandle);
    Result := GetLastError;
    Exit;
  end;

  {GetFileVersionInfo}
  if not GetFileVersionInfo(PChar(Filename), InfoHandle, Size, pData) then
  begin
    if fHandle <> 0 then
      GlobalFree(fHandle);
    Result := GetLastError;
    Exit;
  end;

  {Load Translation Table}
  sTmp := '\VarFileInfo\Translation';

  {VerQueryValue}
  if not VerQueryValue(pData, PChar(sTmp), Buffer, Len) then
  begin
    if fHandle <> 0 then
      GlobalFree(fHandle);
    Result := GetLastError;
    Exit;
  end;

  {Establish default Lang-Char set}
  pTable := Buffer;
  sLangCharSet := Format('%4.4x%4.4x', [pTable^[0].Lang, pTable^[0].CharSet]);
  {Format the Path String}
  Path := Format('\StringFileInfo\%s\%s', [sLangCharSet, Key]);

  {Get the Version Info}
  if not VerQueryValue(pData, PChar(Path), Buffer, Len) then
  begin
    if fHandle <> 0 then
      GlobalFree(fHandle);
    Result := GetLastError;
    Exit;
  end;
  sVersion := String(PChar(Buffer));

  {Clean up}
  if fHandle <> 0 then
    GlobalFree(fHandle);
end;
{------------------------------------------------------------------------------}
{ CrStrToBoolean                                                               }
{------------------------------------------------------------------------------}
function CrStrToBoolean (const sValue: string): boolean;
var
  sTmp : string;
begin
  sTmp := UpperCase(Trim(sValue));
  if Length(sTmp) > 0 then
    sTmp := sTmp[1]
  else
    sTmp := 'F';
  if (sTmp = '1') or (sTmp = 'T') or (sTmp = 'Y') then
    Result := True
  else
    Result := False;
end;
{------------------------------------------------------------------------------}
{ CrBooleanToStr                                                               }
{------------------------------------------------------------------------------}
function CrBooleanToStr (const bValue: boolean; ResultAsNum: boolean): string;
begin
  if bValue = True then
  begin
    if ResultAsNum then
      Result := '1'
    else
      Result := 'True';
  end
  else
  begin
    if ResultAsNum then
      Result := '0'
    else
      Result := 'False';
  end;
end;
{------------------------------------------------------------------------------}
{ BooleanToStr                                                                 }
{------------------------------------------------------------------------------}
function BooleanToStr(bTmp: boolean): string;
begin
  if bTmp = True then
    Result := 'True'
  else
    Result := 'False';
end;
{------------------------------------------------------------------------------}
{ CrStrToInteger                                                               }
{------------------------------------------------------------------------------}
function CrStrToInteger (const sValue: string): integer;
var
  s : string;
begin
  Result := 0;
  s := Trim(sValue);
  if IsNumeric(s) then
    Result := StrToInt(s);
end;
{------------------------------------------------------------------------------}
{ CrStrToFloating                                                              }
{------------------------------------------------------------------------------}
function CrStrToFloating (const sValue: string): double;
var
  s : string;
begin
  Result := 0;
  s := Trim(sValue);
  if IsFloating(s) then
    Result := StrToFloat(s);
end;
{------------------------------------------------------------------------------}
{ CrFloatingToStr                                                              }
{------------------------------------------------------------------------------}
function CrFloatingToStr (const fValue: double): string;
var
  sTmp : string;
begin
  sTmp := '0';
  sTmp := FloatToStrF(fValue, ffGeneral, 15, 2);
  if (sTmp = 'NAN') or (sTmp = 'INF') or (sTmp = '-INF') then
    sTmp := '0';
  Result := sTmp;
end;
{------------------------------------------------------------------------------}
{ TruncStr                                                                     }
{------------------------------------------------------------------------------}
function TruncStr (sValue: string): string;
var
  i : integer;
begin
  Result := sValue;
  i := Pos('.', sValue);
  if i > 0 then
    Result := Copy(sValue, 1, i-1);
end;
{------------------------------------------------------------------------------}
{ RemoveSpaces                                                                 }
{------------------------------------------------------------------------------}
function RemoveSpaces (const sValue: string): string;
var
  i : integer;
  s : string;
begin
  Result := '';
  s := sValue;
  i := 1;
  while i > 0 do
  begin
    i := Pos(' ', s);
    if i > 0 then
      s := Copy(s, 1, i-1) + Copy(s, i+1, Length(s));
  end;
  Result := s;
end;
{------------------------------------------------------------------------------}
{ ReplaceString                                                                }
{------------------------------------------------------------------------------}
function ReplaceString (sOld,sNew:string; var sMain: string): boolean;
var
  i     : integer;
  s1,s2 : string;
begin
  Result := False;
  i := Pos(sOld, sMain);
  if i = -1 then Exit;
  s1 := Copy(sMain, 1, i-1);
  s2 := Copy(sMain, i+Length(sOld), Length(sMain));
  sMain := s1 + sNew + s2;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ RTrimList                                                                    }
{  - Get rid of any LF's (line feeds) and the CR at the end of the Stringlist  }
{------------------------------------------------------------------------------}
function RTrimList (const sList: TStrings): string;
var
  s1 : string;
begin
  s1 := '';
  if sList = nil then Exit;
  s1 := sList.Text;
  {Remove any trailing LF/CR}
  while True do
  begin
    if Length(s1) = 0 then
      Break;
    if (s1[Length(s1)] = #10) then
      s1 := Copy(s1, 1, Length(s1) - 1)
    else if (s1[Length(s1)] = #13) then
      s1 := Copy(s1, 1, Length(s1) - 1)
    else
      Break;
  end;
  Result := s1;
end;
{------------------------------------------------------------------------------}
{ IsStrEmpty                                                                   }
{------------------------------------------------------------------------------}
function IsStrEmpty(const sValue: string): boolean;
var
  sTmp : string;
begin
  Result := True;
  sTmp := Trim(sValue);
  if Length(sTmp) > 0 then
    Result := False;
end; { IsStrEmpty }
{------------------------------------------------------------------------------}
{ IsStringListEmpty                                                            }
{------------------------------------------------------------------------------}
function IsStringListEmpty (const sList : TStrings): boolean;
var
  sTmp : string;
begin
  Result := True;
  sTmp := RTrimList(sList);
  if Length(sTmp) > 0 then
    Result := False;
end;
{------------------------------------------------------------------------------}
{ ColorState                                                                   }
{  - Returns the active/inactive color of a component                          }
{------------------------------------------------------------------------------}
function ColorState(Enable: boolean): TColor;
begin
  Result := clInactiveCaptionText;
  if Enable then
    Result := clWindow;
end;
{------------------------------------------------------------------------------}
{ LoadFormPos                                                                  }
{------------------------------------------------------------------------------}
procedure LoadFormPos(frmTemp: TForm);
var
  RegIni : TRegIniFile;
begin
  {Read the Registry}
  RegIni := TRegIniFile.Create('Software\Crystal Decisions\10.0\CrystalVCL\');
  try
    frmTemp.Left := RegIni.ReadInteger(frmTemp.Name,'Left',-1);
    frmTemp.Top := RegIni.ReadInteger(frmTemp.Name,'Top',-1);
  finally
    RegIni.Free;
  end;
  if (frmTemp.Top < 0) or (frmTemp.Left < 0) or
   ((frmTemp.Top + frmTemp.Height) > Screen.Height) or
   ((frmTemp.Left + frmTemp.Width) > Screen.Width) then
  frmTemp.Position := poScreenCenter;
end;
{------------------------------------------------------------------------------}
{ SaveFormPos                                                                  }
{------------------------------------------------------------------------------}
procedure SaveFormPos(frmTemp: TForm);
var
  RegIni : TRegIniFile;
begin
  {Read the Registry}
  RegIni := TRegIniFile.Create('Software\Crystal Decisions\10.0\CrystalVCL\');
  try
    RegIni.WriteInteger(frmTemp.Name,'Left',frmTemp.Left);
    RegIni.WriteInteger(frmTemp.Name,'Top',frmTemp.Top);
  finally
    RegIni.Free;
  end;
end;
{------------------------------------------------------------------------------}
{ LoadFormSize                                                                 }
{------------------------------------------------------------------------------}
procedure LoadFormSize(frmTemp: TForm);
var
  RegIni : TRegIniFile;
begin
  {Read the Registry}
  RegIni := TRegIniFile.Create('Software\Crystal Decisions\10.0\CrystalVCL\');
  try
    frmTemp.Left := RegIni.ReadInteger(frmTemp.Name,'Left',-1);
    frmTemp.Top := RegIni.ReadInteger(frmTemp.Name,'Top',-1);
    frmTemp.Width := RegIni.ReadInteger(frmTemp.Name,'Width',-1);
    frmTemp.Height := RegIni.ReadInteger(frmTemp.Name,'Height',-1);
  finally
    RegIni.Free;
  end;
  if (frmTemp.Top < 0) or (frmTemp.Left < 0) or
   ((frmTemp.Top + frmTemp.Height) > Screen.Height) or
   ((frmTemp.Left + frmTemp.Width) > Screen.Width) then
  frmTemp.Position := poScreenCenter;
  if (frmTemp.Width < 289) or (frmTemp.Height < 300) then
  begin
    frmTemp.Width := 289;
    frmTemp.Height := 300;
  end;
end;
{------------------------------------------------------------------------------}
{ SaveFormSize                                                                 }
{------------------------------------------------------------------------------}
procedure SaveFormSize(frmTemp: TForm);
var
  RegIni : TRegIniFile;
begin
  {Read the Registry}
  RegIni := TRegIniFile.Create('Software\Crystal Decisions\10.0\CrystalVCL\');
  try
    RegIni.WriteInteger(frmTemp.Name,'Left',frmTemp.Left);
    RegIni.WriteInteger(frmTemp.Name,'Top',frmTemp.Top);
    RegIni.WriteInteger(frmTemp.Name,'Width',frmTemp.Width);
    RegIni.WriteInteger(frmTemp.Name,'Height',frmTemp.Height);
  finally
    RegIni.Free;
  end;
end;


end.
