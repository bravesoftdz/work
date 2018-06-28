(*
-----------------------------------------------------------
 Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/UCrpeUtl.pas $
 Version:            $Revision: #9 $
 Last Modified Date: $Date: 2004/01/27 $

 Copyright (c) 2001-2003 Crystal Decisions, Inc.
 895 Emerson St., Palo Alto, California, USA 94301.

 All rights reserved.

 This file contains confidential, proprietary information, trade secrets and copyrighted expressions
 that are the property of Crystal Decisions, Inc., 895 Emerson St., Palo Alto, California, USA 94301.

 Any disclosure, reproduction, sale or license of all or any part of the information or expression
 contained in this file is prohibited by California law and the United States copyright law, and may
 be subject to criminal penalties.

 If you are not an employee of Crystal Decisions or otherwise authorized in writing by Crystal Decisions
 to possess this file, please contact Crystal Decisions immediately at the address listed above.
-----------------------------------------------------------

Utility Functions used with the Crystal Reports VCL (UCRPE32)
=============================================================
Language : Delphi 7 / C++ Builder 6
*)

unit UCrpeUtl;

{$I UCRPEDEF.INC}

interface

uses
  Classes, Windows, Graphics, Forms, CRDynamic;

function  IsNumeric(Value: string): boolean;
function  IsFloating(Value: string): boolean;
function  IsQuoted(Value: string): boolean;
function  IsStrEmpty (const sValue: string): boolean;
function  TruncStr (sValue: string): string;
function  RemoveSpaces (const sValue: string): string;
procedure RemoveChar (var sValue: string; ch: Char);
function  GetToken(var s: string; const sDelimiter: string): string;
function  IsStringListEmpty (const sList : TStrings): boolean;
function  RTrimList (const sList: TStrings): string;
function  AddBackSlash(const sPath: string): string;
function  MakeCRLF (Value: string): string;
function  GetStrFromRsc(RscNum: integer): string;
function  GetErrorNum(const sError: string): integer;
function  GetErrorStr(const sError: string): string;
function  GetPathFromAlias(const sAlias: string; var sPath: string): boolean;
function  GetVersionInfo(const Filename: string; const Key: string; var sVersion: string): DWord;
procedure CopyDevMode(var SourceDM: TDevMode; var DestinationDM: TDevMode);
function  ColorState(Enable: boolean): TColor;
function  NameToCrFormulaFormat(const Name: string; InstanceName: string): string;
function  CrFormulaFormatToName(const ffName: string): string;
function  CrGetTempPath : string;
function  CrGetTempName (const Extension: string) : string;

{String/Boolean/Integer/Floating/Date/Time conversion}
function  BooleanToStr(bTmp: boolean): string;
function  CrStrToBoolean (const sValue: string): boolean;
function  CrBooleanToStr (const bValue: boolean; ResultAsNum: boolean): string;
function  CrStrToInteger (const sValue: string): integer;
function  CrStrToFloating (const sValue: string): double;
function  CrFloatingToStr (const fValue: double): string;
function  CrStrToDate (const sValue: string; var dValue: TDateTime): boolean;
function  CrDateToStr (const dValue: TDateTime): string;
function  CrStrToDateTime (const sValue: string; var dtValue: TDateTime): boolean;
function  CrDateTimeToStr (const dtValue: TDateTime; bMSec: boolean): string;
function  CrStrToTime (const sValue: string; var tValue: TDateTime): boolean;
function  CrTimeToStr (const tValue: TDateTime): string;
function  ExDateTimeStr (sValue: string; var sYear, sMonth,
  sDay, sHour, sMin, sSec: string): boolean;
function  ExDateStr (sValue: string; var sYear, sMonth, sDay: string): boolean;
function  ExTimeStr (sValue: string; var sHour, sMin, sSec: string): boolean;
function  StrToValueInfo (const sValue: string; var ValueInfo: PEValueInfo): boolean;
function  ValueInfoToStr (var ValueInfo: PEValueInfo): string;
function DrillValueInfoToStr (var ValueInfo: PEDrillValueInfo): string;
procedure ValueInfoToDefault(var ValueInfo: PEValueInfo);
function  StrToSectionCode(const Value: string; var nCode: Smallint): boolean;
function  SectionCodeToStr(const Value: smallint): string;
function  AreaCodeToStr(const Value: smallint): string;

{Twips/Inches/Points conversion}
function  TwipsToInches(iValue: integer): double;
function  InchesToTwips(fValue: double): integer;
function  TwipsToInchesStr(iValue: integer): string;
function  InchesStrToTwips(sValue: string): integer;
function  CompareTwipsToInches(iTwips: integer; dInches: double): boolean;
function  TwipsToPoints(iValue: integer): double;
function  PointsToTwips(fValue: double): integer;
function  TwipsToPointsStr(iValue: integer): string;
function  PointsStrToTwips(sValue: string): integer;
function  CompareTwipsToPoints(iTwips: integer; dPoints: double): boolean;

{Form Position}
procedure LoadFormPos(frmTemp: TForm);
procedure SaveFormPos(frmTemp: TForm);
procedure LoadFormSize(frmTemp: TForm);
procedure SaveFormSize(frmTemp: TForm);

{Crystal Specific}
function GetCommonFilesPath : string;


implementation

uses SysUtils, Registry, DBTables;

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
        if Ord(s[i]) = Ord(DecimalSeparator) then
        begin
          if HasDecimal then
          begin
            Result := False;
            Exit;
          end
          else
          begin
            HasDecimal := True;
            Continue;
          end;
        end
        else
        begin
          Result := False;
          Exit;
        end;
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
{  GetPathFromAlias function                                                   }
{    - Pulls a Path from a BDE Alias                                           }
{------------------------------------------------------------------------------}
function GetPathFromAlias(const sAlias: string; var sPath: string): boolean;
var
  sLoc       : string;
  N          : integer;
  AliasNames : TStringList;
  AliasParms : TStringList;
begin
  Result := False;
  {Fill the Alias Names stringlist}
  AliasNames := TStringList.Create;
  Session.GetAliasNames(AliasNames);
  {Pull the Alias name from the Alias string}
  sLoc := Copy(sAlias, 2, Length(sAlias) - 2);
  {Find Alias name in list}
  N := AliasNames.IndexOf(sLoc);
  {If it exists...}
  if N <> -1 then
  {Get the Alias Parameters}
  begin
    {Create AliasParms stringlist}
    AliasParms := TStringList.Create;
    Session.GetAliasParams(sLoc, AliasParms);
    {Get the Path from the Parameters: Try Path}
    sLoc := AliasParms.Values['PATH'];
    {Get the Path from the Parameters: Try Database Name}
    if sLoc = '' then
      sLoc := ExtractFilePath(AliasParms.Values['DATABASE NAME']);
    {Get the Path from the Parameters: Try Names[0]}
    if sLoc = '' then
    begin
      sLoc := AliasParms.Names[0];
      sLoc := ExtractFilePath(AliasParms.Values[sLoc]);
    end;
    AliasParms.Free;
  end
  else
  begin
    AliasNames.Free;
    Exit;
  end;

  {Add trailing backslash to alias path}
  if Length(sLoc) > 0 then
  begin
    if sLoc[Length(sLoc)] <> '\' then
      sLoc := sLoc + '\';
  end;
  sPath := sLoc;
  Result := True;
  AliasNames.Free;
end;
{------------------------------------------------------------------------------}
{  StrToSectionCode function                                                   }
{------------------------------------------------------------------------------}
function StrToSectionCode(const Value: string; var nCode: Smallint): boolean;
const
  AreaArray   : array[0..6] of string = ('RH','PH','GH','D','GF','PF','RF');
  PEAreaArray : array[0..6] of Integer = (1000, 2000, 3000, 4000, 5000, 7000, 8000);
  SubArray    : array[0..39] of string = ('a','b','c','d','e','f','g','h','i',
     'j','k','l','m','n','o','p','q','r','s','t','u','v','w', 'x','y','z',
     'aa','ab','ac','ad','ae','af','ag','ah','ai','aj','ak','al','am','an');
var
  sTmp      : string;
  sArea     : string;    {Section Area string}
  sGrp      : string;    {Group string}
  nGrp      : smallint;  {Group Number}
  sSub      : string;    {SubSection string}
  nArea     : smallint;  {Section Area code}
  nSub      : smallint;  {SubSection code}
  sAreaList : TStringList;
  sSubList  : TStringList;
  cnt       : smallint;
begin
  Result := False;
  nCode := 0;
  sAreaList := TStringList.Create;
  sSubList := TStringList.Create;

  {Fill temporary Section lists}
  for cnt := Low(AreaArray) to High(AreaArray) do
    sAreaList.Add(AreaArray[cnt]);
  for cnt := Low(SubArray) to High(SubArray) do
    sSubList.Add(SubArray[cnt]);

  {Split up the Section string Value}
  sTmp := Trim(Value);
  if Length(sTmp) > 0 then
  begin
    {Details area}
    sArea := Copy(sTmp,1,1);
    if sArea = 'D' then
    begin
      nGrp := 0;
      if Length(sTmp) > 1 then
        sSub := Copy(Value,2,Length(sTmp))
      else
        sSub := 'a';
    end
    else
    begin
      {GroupHeader or GroupFooter area}
      if sArea = 'G' then
      begin
        {Get the first two letters: GH, GF}
        if Length(sTmp) > 1 then
          sArea := Copy(sTmp,1,2)
        else
          sArea := 'GH';

        {Get the group number}
        sGrp := '';
        for cnt := 3 to Length(sTmp) do
        begin
          {Pull out the numeric characters}
          if IsNumeric(sTmp[cnt]) then
            sGrp := sGrp + sTmp[cnt]
          else
            Break;
        end;
        {Convert the string to a number}
        nGrp := 0;
        if IsNumeric(sGrp) then
        begin
          nGrp := StrToInt(sGrp);
          Dec(nGrp);
        end;

        {Get sub-section letters}
        sSub := '';
        while cnt <= Length(sTmp) do
        begin
          if Ord(sTmp[cnt]) > 64 then
            sSub := sSub + sTmp[cnt];
          Inc(cnt);
        end;
        if sSub = '' then
          sSub := 'a';
      end
      {Any other Area type: RH, PH, etc.}
      else
      begin
        if Length(sTmp) > 1 then
          sArea := Copy(sTmp,1,2)
        else
          sArea := 'RH';
        nGrp := 0;
        if Length(sTmp) > 2 then
          sSub := Copy(sTmp,3,Length(sTmp))
        else
          sSub := 'a';
      end;
    end;

    {Translate to Section Code}
    nArea := sAreaList.IndexOf(sArea);
    if nArea > -1 then
      nArea := PEAreaArray[nArea]
    else
    begin
      sAreaList.Free;
      sSubList.Free;
      Exit;
    end;

    nSub := sSubList.IndexOf(sSub);
    if nSub > -1 then
      nSub := nSub * 25
    else
    begin
      sAreaList.Free;
      sSubList.Free;
      Exit;
    end;
    nCode := nArea + nGrp + nSub;
  end
  else
  begin
    sAreaList.Free;
    sSubList.Free;
    Exit;
  end;
  sAreaList.Free;
  sSubList.Free;
  Result := True;
end; { StrToSectionCode }


{------------------------------------------------------------------------------}
{  AreaCodeToStr function                                                      }
{------------------------------------------------------------------------------}
function AreaCodeToStr(const Value: smallint): string;
var
  nGroup : Smallint;
  nType  : Smallint;
  sTmp   : string;
begin
  sTmp := '';
  {Get Area}
  nType := PE_SECTION_TYPE(Value);
  case nType of
    1: sTmp := 'RH'; {RH}
    2: sTmp := 'PH'; {PH}
    3: begin
         sTmp := 'GH'; {GH}
         nGroup := PE_GROUP_N(Value);
         Inc(nGroup);
         sTmp := sTmp + IntToStr(nGroup);
       end;
    4: sTmp := 'D';  {D}
    5: begin
         sTmp := 'GF'; {GF}
         nGroup := PE_GROUP_N(Value);
         Inc(nGroup);
         sTmp := sTmp + IntToStr(nGroup);
       end;
    7: sTmp := 'PF'; {PF}
    8: sTmp := 'RF'; {RF}
  end;
  Result := sTmp;
end;
{------------------------------------------------------------------------------}
{  SectionCodeToStr function                                                   }
{------------------------------------------------------------------------------}
function SectionCodeToStr(const Value: smallint): string;
const
  SubArray : array[0..39] of string = ('a','b','c','d','e','f','g','h','i',
     'j','k','l','m','n','o','p','q','r','s','t','u','v','w', 'x','y','z',
     'aa','ab','ac','ad','ae','af','ag','ah','ai','aj','ak','al','am','an');
var
  nType,
  nGroup,
  nSection : smallint;
  sTmp     : string;
begin
  sTmp := '';
  {Get Area}
  nType := PE_SECTION_TYPE(Value);
  case nType of
    1: sTmp := 'RH'; {RH}
    2: sTmp := 'PH'; {PH}
    3: begin
         sTmp := 'GH'; {GH}
         nGroup := PE_GROUP_N(Value);
         Inc(nGroup);
         sTmp := sTmp + IntToStr(nGroup);
       end;
    4: sTmp := 'D';  {D}
    5: begin
         sTmp := 'GF'; {GF}
         nGroup := PE_GROUP_N(Value);
         Inc(nGroup);
         sTmp := sTmp + IntToStr(nGroup);
       end;
    7: sTmp := 'PF'; {PF}
    8: sTmp := 'RF'; {RF}
  end;
  {Get Section}
  nSection := PE_SECTION_N(Value);
  {Get Sub-Section}
  if IsStrEmpty(sTmp) or (nSection > 39) or (nSection < 0) then
    Result := ''
  else
    Result := sTmp + SubArray[nSection];
end; { SectionCodeToStr }
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
{  GetErrorNum function                                                        }
{   - Extract Error Num from Constant                                          }
{------------------------------------------------------------------------------}
function GetErrorNum(const sError: string): integer;
var
  s1,s2 : string;
begin
  s1 := sError;
  s2 := GetToken(s1, ':');
  Result := StrToInt(s2);
end;
{------------------------------------------------------------------------------}
{  GetErrorStr function                                                        }
{   - Extract Error String from Constant                                       }
{------------------------------------------------------------------------------}
function GetErrorStr(const sError: string): string;
var
  s1,s2 : string;
begin
  s1 := sError;
  s2 := GetToken(s1, ':');
  Result := s1;
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
{ StrToValueInfo                                                               }
{------------------------------------------------------------------------------}
function StrToValueInfo (const sValue: string; var ValueInfo: PEValueInfo): boolean;
var
  sTmp     : string;
  sY,sM,sD,
  sH,sN,sS : string;
begin
  Result := False;
  sTmp := sValue;

  case ValueInfo.valueType of
    {Number}
    PE_VI_NUMBER :
      begin
        if IsFloating(sTmp) then
        begin
          ValueInfo.viNumber := StrToFloat(sTmp);
          Result := True;
        end;
      end;
    {Currency}
    PE_VI_CURRENCY :
      begin
        if IsFloating(sTmp) then
        begin
          ValueInfo.viCurrency := StrToFloat(sTmp);
          Result := True;
        end;
      end;
    {Boolean}
    PE_VI_BOOLEAN :
      begin
        if Length(sTmp) > 0 then
        begin
          {Store boolean value to ValueInfo structure}
          ValueInfo.viBoolean := CrStrToBoolean(sTmp);
          Result := True;
        end;
      end;
    {Date}
    PE_VI_DATE :
      begin
        if ExDateStr(sTmp, sY, sM, sD) then
        begin
          ValueInfo.viDate[0] := StrToInt(sY);
          ValueInfo.viDate[1] := StrToInt(sM);
          ValueInfo.viDate[2] := StrToInt(sD);
          Result := True;
        end;
      end;
    {String}
    PE_VI_STRING :
      begin
        StrCopy(PEVIStringType(ValueInfo.viString), PChar(sTmp));
        Result := True;
      end;
    {DateTime}
    PE_VI_DATETIME :
      begin
        if ExDateTimeStr(sTmp, sY, sM, sD, sH, sN, sS) then
        begin
          ValueInfo.viDateTime[0] := StrToInt(sY);
          ValueInfo.viDateTime[1] := StrToInt(sM);
          ValueInfo.viDateTime[2] := StrToInt(sD);
          ValueInfo.viDateTime[3] := StrToInt(sH);
          ValueInfo.viDateTime[4] := StrToInt(sN);
          ValueInfo.viDateTime[5] := StrToInt(sS);
          Result := True;
        end;
      end;
    {Time}
    PE_VI_TIME :
      begin
        {Store time value to ValueInfo structure}
        if ExTimeStr(sTmp, sH, sN, sS) then
        begin
          ValueInfo.viTime[0] := StrToInt(sH);
          ValueInfo.viTime[1] := StrToInt(sN);
          ValueInfo.viTime[2] := StrToInt(sS);
          Result := True;
        end;
      end;
    PE_VI_INTEGER :
      begin
        if IsNumeric(sTmp) then
        begin
          ValueInfo.viInteger := StrToInt(sTmp);
          Result := True;
        end;
      end;
    PE_VI_COLOR   :
      begin
        if IsNumeric(sTmp) then
          ValueInfo.viColor := StrToInt(sTmp)
        else
          ValueInfo.viColor := PE_NO_COLOR;
        Result := True;
      end;
    PE_VI_CHAR    : ValueInfo.viC := sTmp[1];
    PE_VI_LONG    :
      begin
        if IsNumeric(sTmp) then
          ValueInfo.viLong := StrToInt(sTmp)
        else
          ValueInfo.viLong := 0;
        Result := True;
      end;
  end;
end;
{------------------------------------------------------------------------------}
{ ValueInfoToStr                                                               }
{------------------------------------------------------------------------------}
function ValueInfoToStr (var ValueInfo: PEValueInfo): string;
var
  sTmp   : string;
  dValue : TDateTime;
  tValue : TDateTime;
  Year1,
  Month1,
  Day1,
  Hour1,
  Min1,
  Sec1   : Word;
begin
  sTmp := '';
  case ValueInfo.ValueType of
    {Number}
    PE_VI_NUMBER   : sTmp := FloatToStrF(ValueInfo.viNumber, ffGeneral, 15, 2);
    {Currency}
    PE_VI_CURRENCY : sTmp := FloatToStrF(ValueInfo.viCurrency, ffGeneral, 15, 2);
    {Boolean}
    PE_VI_BOOLEAN : sTmp := CrBooleanToStr(ValueInfo.viBoolean, False);
    {Date}
    PE_VI_DATE :  {YYYY,MM,DD}
      begin
        if ValueInfo.viDate[0] < 1 then
          sTmp := CrDateToStr(Now)
        else
        begin
          Year1 := ValueInfo.viDate[0];
          Month1 := ValueInfo.viDate[1];
          Day1 := ValueInfo.viDate[2];
          dValue := EncodeDate(Year1, Month1, Day1);
          sTmp := CrDateToStr(dValue);
        end;
      end;
    {String}
    PE_VI_STRING : sTmp := String(ValueInfo.viString);
    {DateTime}
    PE_VI_DATETIME :  {YYYY,MM,DD HH:MM:SS}
      begin
        if ValueInfo.viDateTime[0] < 1 then
          sTmp := CrDateTimeToStr(Now, False)
        else
        begin
          Year1 := ValueInfo.viDateTime[0];
          Month1 := ValueInfo.viDateTime[1];
          Day1 := ValueInfo.viDateTime[2];
          Hour1 := ValueInfo.viDateTime[3];
          Min1 := ValueInfo.viDateTime[4];
          Sec1 := ValueInfo.viDateTime[5];
          dValue := EncodeDate(Year1, Month1, Day1);
          tValue := EncodeTime(Hour1, Min1, Sec1, 0);
          dValue := dValue + tValue;
          sTmp := CrDateTimeToStr(dValue, False);
        end;
      end;
    {Time}
    PE_VI_TIME :  {HH:MM:SS}
      begin
        if ValueInfo.viTime[0] < 1 then
          sTmp := CrTimeToStr(Now)
        else
        begin
          Hour1 := ValueInfo.viTime[0];
          Min1 := ValueInfo.viTime[1];
          Sec1 := ValueInfo.viTime[2];
          tValue := EncodeTime(Hour1, Min1, Sec1, 0);
          sTmp := CrTimeToStr(tValue);
        end;
      end;
    PE_VI_INTEGER : sTmp := IntToStr(ValueInfo.viInteger);
    PE_VI_COLOR   : sTmp := IntToStr(ValueInfo.viColor);
    PE_VI_CHAR    : sTmp := ValueInfo.viC;
    PE_VI_LONG    : sTmp := IntToStr(ValueInfo.viLong);
    PE_VI_NOVALUE : sTmp := '';
  end;
  Result := sTmp;
end;
{------------------------------------------------------------------------------}
{ ValueInfoToStr                                                               }
{------------------------------------------------------------------------------}
function DrillValueInfoToStr (var ValueInfo: PEDrillValueInfo): string;
var
  sTmp   : string;
  dValue : TDateTime;
  tValue : TDateTime;
  Year1,
  Month1,
  Day1,
  Hour1,
  Min1,
  Sec1   : Word;
begin
  sTmp := '';
  case ValueInfo.ValueType of
    {Number}
    PE_VI_NUMBER   : sTmp := FloatToStrF(ValueInfo.viNumber, ffGeneral, 15, 2);
    {Currency}
    PE_VI_CURRENCY : sTmp := FloatToStrF(ValueInfo.viCurrency, ffGeneral, 15, 2);
    {Boolean}
    PE_VI_BOOLEAN : sTmp := CrBooleanToStr(ValueInfo.viBoolean, False);
    {Date}
    PE_VI_DATE :  {YYYY,MM,DD}
      begin
        if ValueInfo.viDate[0] < 1 then
          sTmp := CrDateToStr(Now)
        else
        begin
          Year1 := ValueInfo.viDate[0];
          Month1 := ValueInfo.viDate[1];
          Day1 := ValueInfo.viDate[2];
          dValue := EncodeDate(Year1, Month1, Day1);
          sTmp := CrDateToStr(dValue);
        end;
      end;
    {String}
    PE_VI_STRING : sTmp := WideCharToString(ValueInfo.viString);
    {DateTime}
    PE_VI_DATETIME :  {YYYY,MM,DD HH:MM:SS}
      begin
        if ValueInfo.viDateTime[0] < 1 then
          sTmp := CrDateTimeToStr(Now, False)
        else
        begin
          Year1 := ValueInfo.viDateTime[0];
          Month1 := ValueInfo.viDateTime[1];
          Day1 := ValueInfo.viDateTime[2];
          Hour1 := ValueInfo.viDateTime[3];
          Min1 := ValueInfo.viDateTime[4];
          Sec1 := ValueInfo.viDateTime[5];
          dValue := EncodeDate(Year1, Month1, Day1);
          tValue := EncodeTime(Hour1, Min1, Sec1, 0);
          dValue := dValue + tValue;
          sTmp := CrDateTimeToStr(dValue, False);
        end;
      end;
    {Time}
    PE_VI_TIME :  {HH:MM:SS}
      begin
        if ValueInfo.viTime[0] < 1 then
          sTmp := CrTimeToStr(Now)
        else
        begin
          Hour1 := ValueInfo.viTime[0];
          Min1 := ValueInfo.viTime[1];
          Sec1 := ValueInfo.viTime[2];
          tValue := EncodeTime(Hour1, Min1, Sec1, 0);
          sTmp := CrTimeToStr(tValue);
        end;
      end;
    PE_VI_INTEGER : sTmp := IntToStr(ValueInfo.viInteger);
    PE_VI_COLOR   : sTmp := IntToStr(ValueInfo.viColor);
    PE_VI_CHAR    : sTmp := ValueInfo.viC;
    PE_VI_LONG    : sTmp := IntToStr(ValueInfo.viLong);
    PE_VI_NOVALUE : sTmp := '';
  end;
  Result := sTmp;
end;
{------------------------------------------------------------------------------}
{ ValueInfoToDefault                                                           }
{------------------------------------------------------------------------------}
procedure ValueInfoToDefault(var ValueInfo: PEValueInfo);
var
  Year1, Month1, Day1,
  Hour1, Min1, Sec1 : string;
begin
  case ValueInfo.valueType of
    {Changed Number, Currency, and Integer default to 1, otherwise adding
     multiple PromptValues in a row caused an Print Engine error}
    PE_VI_NUMBER   : ValueInfo.viNumber := 1;
    PE_VI_CURRENCY : ValueInfo.viCurrency := 1;
    PE_VI_BOOLEAN  : ValueInfo.viBoolean  := True;
    PE_VI_DATE     : begin
                       Year1 := FormatDateTime('yyyy', Now);
                       ValueInfo.viDate[0] := StrToInt(Year1);
                       Month1 := FormatDateTime('mm', Now);
                       ValueInfo.viDate[1] := StrToInt(Month1);
                       Day1 := FormatDateTime('dd', Now);
                       ValueInfo.viDate[2] := StrToInt(Day1);
                     end;
    PE_VI_STRING   : ValueInfo.viString := '';
    PE_VI_DATETIME : begin
                       Year1 := FormatDateTime('yyyy', Now);
                       ValueInfo.viDateTime[0] := StrToInt(Year1);
                       Month1 := FormatDateTime('mm', Now);
                       ValueInfo.viDateTime[1] := StrToInt(Month1);
                       Day1 := FormatDateTime('dd', Now);
                       ValueInfo.viDateTime[2] := StrToInt(Day1);
                       Hour1 := FormatDateTime('hh', Now);
                       ValueInfo.viDateTime[3] := StrToInt(Hour1);
                       Min1 := FormatDateTime('nn', Now);
                       ValueInfo.viDateTime[4] := StrToInt(Min1);
                       Sec1 := FormatDateTime('ss', Now);
                       ValueInfo.viDateTime[5] := StrToInt(Sec1);
                     end;
    PE_VI_TIME     : begin
                       Hour1 := FormatDateTime('hh', Now);
                       ValueInfo.viTime[0] := StrToInt(Hour1);
                       Min1 := FormatDateTime('nn', Now);
                       ValueInfo.viTime[1] := StrToInt(Min1);
                       Sec1 := FormatDateTime('ss', Now);
                       ValueInfo.viTime[2] := StrToInt(Sec1);
                     end;
    PE_VI_INTEGER  : ValueInfo.viInteger := 1;
    PE_VI_COLOR    : ValueInfo.viColor := 0;
    PE_VI_CHAR     : ValueInfo.viC := 'A';
    PE_VI_LONG     : ValueInfo.viLong := 0;
  end;
end;
{------------------------------------------------------------------------------}
{ NameToCrFormulaFormat                                                        }
{------------------------------------------------------------------------------}
function NameToCrFormulaFormat(const Name: string; InstanceName: string): string;
var
  s1 : string;
begin
  Result := Name;
  s1 := Trim(Name);
  if Length(s1) < 1 then Exit;
  if s1[1] <> '{' then
    s1 := '{' + s1;
  if s1[Length(s1)] <> '}' then
    s1 := s1 + '}';
  {Formulas}
  if LowerCase(InstanceName) = 'formulas' then
  begin
    if s1[2] <> '@' then
      s1 := s1[1] + '@' + Copy(s1, 2, Length(s1));
  end;
  {ParamFields}
  if LowerCase(InstanceName) = 'paramfields' then
  begin
    if s1[2] <> '?' then
      s1 := s1[1] + '?' + Copy(s1, 2, Length(s1));
  end;
  {RunningTotals}
  if LowerCase(InstanceName) = 'runningtotals' then
  begin
    if s1[2] <> '%' then
      s1 := s1[1] + '%' + Copy(s1, 2, Length(s1));
  end;
  {SQLExpressions}
  if LowerCase(InstanceName) = 'sqlexpressions' then
  begin
    if s1[2] <> '#' then
      s1 := s1[1] + '#' + Copy(s1, 2, Length(s1));
  end;
  Result := s1;
end;
{------------------------------------------------------------------------------}
{ CrFormulaFormatToName                                                        }
{------------------------------------------------------------------------------}
function CrFormulaFormatToName(const ffName: string): string;
var
  s1 : string;
begin
  Result := ffName;
  s1 := Trim(ffName);
  if Length(s1) < 3 then Exit;
  if s1[1] = '{' then
    s1 := Copy(s1, 2, Length(s1));
  if s1[Length(s1)] = '}' then
    s1 := Copy(s1, 1, Length(s1)-1);
  {Formulas}
  if s1[1] = '@' then
    s1 := Copy(s1, 2, Length(s1));
  {ParamFields}
  if s1[1] = '?' then
    s1 := Copy(s1, 2, Length(s1));
  {RunningTotals}
  if s1[1] = '%' then
    s1 := Copy(s1, 2, Length(s1));
  {SQLExpressions}
  if s1[1] = '#' then
    s1 := Copy(s1, 2, Length(s1));
  Result := s1;
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
{ CrStrToDate                                                                  }
{------------------------------------------------------------------------------}
function CrStrToDate (const sValue: string; var dValue: TDateTime): boolean;
var
  sYear1,
  sMonth1,
  sDay1    : string;
  Year1,
  Month1,
  Day1     : Word;
  sTmp     : string;
  cnt      : integer;
begin
  Result := False;
  dValue := Now;
  sTmp := sValue;

  {If Length of string is less than 8, exit}
  if Length(sTmp) < 5 then
    Exit;

  {Extract Year}
  sYear1 := GetToken(sTmp, ',');
  {If Length of year is zero, exit}
  if Length(sYear1) = 0 then
    Exit;
  if IsNumeric(sYear1) then
    Year1 := StrToInt(sYear1)
  else
    Exit;

  {Extract Month}
  sMonth1 := GetToken(sTmp, ',');
  {If Length of month is less than 1, exit}
  if Length(sMonth1) = 0 then
    Exit;
  if IsNumeric(sMonth1) then
    Month1 := StrToInt(sMonth1)
  else
    Exit;

  {Extract Day}
  {Trim any leading space}
  sTmp := Trim(sTmp);
  {If Length of day is less than 1, exit}
  if Length(sTmp) = 0 then
    Exit;
  {Pull out just the Day characters}
  if Length(sTmp) > 1 then
  begin
    {Only the first two characters}
    for cnt := 1 to 2 do
    begin
      {Only Numbers}
      if (Ord(sTmp[cnt]) > 47) and (Ord(sTmp[cnt]) < 58) then
        sDay1 := sDay1 + sTmp[cnt];
    end;
  end
  else
    sDay1 := sTmp;
  if IsNumeric(sDay1) then
    Day1 := StrToInt(sDay1)
  else
    Exit;

  dValue := EncodeDate(Year1, Month1, Day1);
  Result := True;
end;
{------------------------------------------------------------------------------}
{ CrDateToStr                                                                  }
{------------------------------------------------------------------------------}
function CrDateToStr (const dValue: TDateTime): string;
begin
  Result := FormatDateTime('yyyy,mm,dd', dValue);
end;
{------------------------------------------------------------------------------}
{ CrStrToDateTime                                                              }
{------------------------------------------------------------------------------}
function CrStrToDateTime (const sValue: string; var dtValue: TDateTime): boolean;
var
  sYear1, sMonth1, sDay1,
  sHour1, sMin1, sSec1     : string;
  Year1, Month1, Day1      : Word;
  Hour1, Min1, Sec1, MSec1 : Word;
  sTmp                     : string;
  Date1, Time1             : TDateTime;
begin
  Result := False;
  dtValue := Now;
  sTmp := sValue;

  if Length(sTmp) < 11 then
    Exit;

  {Extract Year}
  sYear1 := GetToken(sTmp, ',');
  {If Length of year is zero, exit}
  if Length(sYear1) = 0 then
    Exit;
  if IsNumeric(sYear1) then
    Year1 := StrToInt(sYear1)
  else
    Exit;

  {Extract Month}
  sMonth1 := GetToken(sTmp, ',');
  {If blank, exit}
  if Length(sMonth1) = 0 then
    Exit;
  if IsNumeric(sMonth1) then
    Month1 := StrToInt(sMonth1)
  else
    Exit;

  {Extract Day}
  {Look for space between date and time}
  sDay1 := GetToken(sTmp, ' ');
  {If the space wasn't found...}
  if Length(sDay1) = 0 then
  begin
    {Copy out the first two characters}
    sDay1 := Copy(sTmp, 1, 2);
    {Remove them from the temp string}
    sTmp := Copy(sTmp, 3, Length(sTmp));
  end;
  {If Length of day is zero, exit}
  if Length(sTmp) = 0 then
    Exit;
  if IsNumeric(sDay1) then
    Day1 := StrToInt(sDay1)
  else
    Exit;

  {Extract Hour}
  {Just in case: trim out any space}
  sTmp := TrimLeft(sTmp);
  sHour1 := GetToken(sTmp, ':');
  if Length(sHour1) = 0 then
    Exit;
  if IsNumeric(sHour1) then
    Hour1 := StrToInt(sHour1)
  else
    Exit;

  {Extract Min}
  sMin1 := GetToken(sTmp, ':');
  if Length(sMin1) = 0 then
    Exit;
  if IsNumeric(sMin1) then
    Min1 := StrToInt(sMin1)
  else
    Exit;

  {Extract Sec}
  sSec1 := GetToken(sTmp, '.');
  {If no milliseconds, take whole string}
  if Length(sSec1) = 0 then
  begin
    sSec1 := sTmp;
    sTmp := '';
  end;
  {If still blank, exit}
  if Length(sSec1) = 0 then
    Exit;
  if IsNumeric(sSec1) then
    Sec1 := StrToInt(sSec1)
  else
    Exit;

  {Extract MSec}
  {If not valid, make zero}
  if Length(sTmp) = 0 then
    sTmp := '0';
  if IsNumeric(sTmp) then
    MSec1 := StrToInt(sTmp)
  else
    Exit;

  Date1 := EncodeDate(Year1, Month1, Day1);
  Time1 := EncodeTime(Hour1, Min1, Sec1, MSec1);
  dtValue := Date1 + Time1;
  Result := True;
end;
{------------------------------------------------------------------------------}
{ CrDateTimeToStr                                                              }
{------------------------------------------------------------------------------}
function CrDateTimeToStr (const dtValue: TDateTime; bMSec: boolean): string;
var
  Hour1,
  Min1,
  Sec1,
  MSec1 : Word;
begin
  if bMSec then
  begin
    DecodeTime(dtValue, Hour1, Min1, Sec1, MSec1);
    Result := FormatDateTime('yyyy-mm-dd hh":"nn":"ss.', dtValue) +
      FormatFloat('000', MSec1);
  end
  else
    Result := FormatDateTime('yyyy,mm,dd hh:nn:ss', dtValue);
end;
{------------------------------------------------------------------------------}
{ CrStrToTime                                                                  }
{------------------------------------------------------------------------------}
function CrStrToTime (const sValue: string; var tValue: TDateTime): boolean;
var
  sHour1,
  sMin1,
  sSec1       : string;
  Hour1,
  Min1,
  Sec1        : Word;
  sTmp, sTmp2 : string;
begin
  Result := False;
  tValue := Now;
  sTmp := sValue;

  {Extract Hour}
  sHour1 := GetToken(sTmp, ':');
  {If the colon wasn't found...}
  if Length(sHour1) = 0 then
  begin
    {Copy out the first two characters}
    sHour1 := Copy(sTmp, 1, 2);
    {Remove them from the temp string}
    sTmp := Copy(sTmp, 3, Length(sTmp));
    {If the string is still empty, exit}
    if Length(sHour1) = 0 then
      Exit;
  end;

  {Check if the string contains the date and remove it}
  if Pos(' ', sHour1) > 0 then
    sTmp2 := GetToken(sHour1, ' ');
  {Try converting to integer}
  if IsNumeric(sHour1) then
    Hour1 := StrToInt(sHour1)
  else
    Exit;

  {Extract Minute}
  sMin1 := GetToken(sTmp, ':');
  {If the colon wasn't found...}
  if Length(sMin1) = 0 then
  begin
    {Copy out the first two characters}
    sMin1 := Copy(sTmp, 1, 2);
    {Remove them from the temp string}
    sTmp := Copy(sTmp, 3, Length(sTmp));
  end;
  {If the string is still empty...}
  if Length(sMin1) = 0 then
    Exit;
  if IsNumeric(sMin1) then
    Min1 := StrToInt(sMin1)
  else
    Exit;

  {Extract Seconds}
  sSec1 := GetToken(sTmp, '.');
  if Length(sSec1) = 0 then
    sSec1 := sTmp;
  if Length(sSec1) = 0 then
    Exit;
  if IsNumeric(sSec1) then
    Sec1 := StrToInt(sSec1)
  else
    Exit;

  tValue := EncodeTime(Hour1, Min1, Sec1, 0);
  Result := True;
end;
{------------------------------------------------------------------------------}
{ CrTimeToStr                                                                  }
{------------------------------------------------------------------------------}
function CrTimeToStr (const tValue: TDateTime): string;
begin
  Result := FormatDateTime('hh:nn:ss', tValue);
end;
{------------------------------------------------------------------------------}
{ ExDateTimeStr                                                                }
{------------------------------------------------------------------------------}
function ExDateTimeStr (sValue: string; var sYear, sMonth,
  sDay, sHour, sMin, sSec: string): boolean;
begin
  Result := False;

  {Extract Year}
  sYear := GetToken(sValue, ',');
  if Length(sYear) = 0 then
    Exit;

  {Extract Month}
  sMonth := GetToken(sValue, ',');
  if Length(sMonth) = 0 then
    Exit;

  {Extract Day}
  {Look for space between date and time}
  sDay := GetToken(sValue, ' ');
  {If the space wasn't found...}
  if Length(sDay) = 0 then
  begin
    {Copy out the first two characters}
    sDay := Copy(sValue, 1, 2);
    {Remove them from the temp string}
    sValue := Copy(sValue, 3, Length(sValue));
  end;
  if Length(sDay) = 0 then
    Exit;

  {Extract Hour}
  sValue := TrimLeft(sValue);
  sHour := GetToken(sValue, ':');
  if Length(sHour) = 0 then
    Exit;

  {Extract Min}
  sMin := GetToken(sValue, ':');
  if Length(sMin) = 0 then
    Exit;

  {Extract Sec}
  sSec := GetToken(sValue, '.');
  if Length(sSec) = 0 then
    sSec := sValue;
  if Length(sSec) = 0 then
    Exit;

  Result := True;
end;
{------------------------------------------------------------------------------}
{ ExDateStr                                                                    }
{------------------------------------------------------------------------------}
function ExDateStr (sValue: string; var sYear, sMonth, sDay: string): boolean;
begin
  Result := False;

  {Extract Year}
  sYear := GetToken(sValue, ',');
  if Length(sYear) = 0 then
    Exit;

  {Extract Month}
  sMonth := GetToken(sValue, ',');
  if Length(sMonth) = 0 then
    Exit;

  {Extract Day}
  {Look for space between date and time}
  sDay := GetToken(sValue, ' ');
  {If the space wasn't found...}
  if Length(sDay) = 0 then
  begin
    {Copy out the first two characters}
    sDay := Copy(sValue, 1, 2);
    {Remove them from the temp string}
    sValue := Copy(sValue, 3, Length(sValue));
  end;
  if Length(sDay) = 0 then
    Exit;

  Result := True;
end;
{------------------------------------------------------------------------------}
{ ExTimeStr                                                                    }
{------------------------------------------------------------------------------}
function ExTimeStr (sValue: string; var sHour, sMin, sSec: string): boolean;
begin
  Result := False;

  {Extract Hour}
  sHour := GetToken(sValue, ':');
  if Length(sHour) = 0 then
    Exit;

  {Extract Min}
  sMin := GetToken(sValue, ':');
  if Length(sMin) = 0 then
    Exit;

  {Extract Sec}
  sSec := GetToken(sValue, '.');
  if Length(sSec) = 0 then
    sSec := sValue;
  if Length(sSec) = 0 then
    Exit;

  Result := True;
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
{ RemoveChar                                                                   }
{------------------------------------------------------------------------------}
procedure RemoveChar (var sValue: string; ch: Char);
var
  i : integer;
  s : string;
begin
  s := '';
  for i := 1 to Length(sValue) do
  begin
    if sValue[i] <> ch then
      s := s + sValue[i];
  end;
  sValue := s;
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
{ MakeCRLF                                                                     }
{  - Replaces Linefeed/CarriageReturn with CarriageReturn/Linefeed             }
{  - Replaces single LineFeed or Carriage Return with CRLF                     }
{------------------------------------------------------------------------------}
function MakeCRLF (Value: string): string;
var
  i     : integer;
  s1,s2 : string;
begin
  s1 := Value;
  i := 1;
  {Replace Chr(10) with Chr(13)}
  while i > 0 do
  begin
    i := Pos(Chr(10), s1);
    if i > 0 then
      s1 := Copy(s1, 1, i-1) + Chr(13) + Copy(s1, i+1, Length(s1));
  end;

  i := 1;
  {Replace Chr(13) + Chr(13) with Chr(13) + Chr(10)}
  while i > 0 do
  begin
    i := Pos(Chr(13) + Chr(13), s1);
    if i > 0 then
      s1 := Copy(s1, 1, i-1) + Chr(13) + Chr(10) + Copy(s1, i+2, Length(s1));
  end;

  i := 1;
  s2 := s1;
  s1 := '';
  {Replace Chr(13) with Chr(13) + Chr(10)}
  while i > 0 do
  begin
    i := Pos(Chr(13), s2);
    if i > 0 then
    begin
      if i = Length(s2) then
      begin
        s1 := s1 + Chr(13) + Chr(10);
        Break;
      end
      else
      begin
        if s2[i+1] <> Chr(10) then
        begin
          s1 := s1 + Copy(s2, 1, i) + Chr(10);
          s2 := Copy(s2, i+1, Length(s2));
        end
        else
        begin
          s1 := s1 + Copy(s2, 1, i+1);
          s2 := Copy(s2, i+2, Length(s2));
        end;
      end;
    end;
  end;
  s1 := s1 + s2;
  Result := s1;
end;
{------------------------------------------------------------------------------}
{ CrGetTempPath                                                                }
{------------------------------------------------------------------------------}
function CrGetTempPath: string;
var
  s1  : string;
  p1  : PChar;
  Len : DWord;
begin
  Result := '';
  p1 := StrAlloc(512);
  Len := GetTempPath(0,	p1);
  if Len = 0 then Exit;
  GetTempPath(Len, p1);
  s1 := String(p1);
  StrDispose(p1);
  Result := s1;
end;
{------------------------------------------------------------------------------}
{ CopyDevMode Method                                                           }
{------------------------------------------------------------------------------}
procedure CopyDevMode(var SourceDM: TDevMode; var DestinationDM: TDevMode);
begin
  DestinationDM.dmDeviceName := SourceDM.dmDeviceName;
  DestinationDM.dmSpecVersion := SourceDM.dmSpecVersion;
  DestinationDM.dmDriverVersion := SourceDM.dmDriverVersion;
  DestinationDM.dmSize := SourceDM.dmSize;
  DestinationDM.dmDriverExtra := SourceDM.dmDriverExtra;
  DestinationDM.dmFields := SourceDM.dmFields;
  DestinationDM.dmOrientation := SourceDM.dmOrientation;
  DestinationDM.dmPaperSize := SourceDM.dmPaperSize;
  DestinationDM.dmPaperLength := SourceDM.dmPaperLength;
  DestinationDM.dmPaperWidth := SourceDM.dmPaperWidth;
  DestinationDM.dmScale := SourceDM.dmScale;
  DestinationDM.dmCopies := SourceDM.dmCopies;
  DestinationDM.dmDefaultSource := SourceDM.dmDefaultSource;
  DestinationDM.dmPrintQuality := SourceDM.dmPrintQuality;
  DestinationDM.dmColor := SourceDM.dmColor;
  DestinationDM.dmDuplex := SourceDM.dmDuplex;
  DestinationDM.dmYResolution := SourceDM.dmYResolution;
  DestinationDM.dmTTOption := SourceDM.dmTTOption;
  DestinationDM.dmCollate := SourceDM.dmCollate;
  DestinationDM.dmFormName := SourceDM.dmFormName;
  DestinationDM.dmLogPixels := SourceDM.dmLogPixels;
  DestinationDM.dmBitsPerPel := SourceDM.dmBitsPerPel;
  DestinationDM.dmPelsWidth := SourceDM.dmPelsWidth;
  DestinationDM.dmPelsHeight := SourceDM.dmPelsHeight;
  DestinationDM.dmDisplayFlags := SourceDM.dmDisplayFlags;
  DestinationDM.dmDisplayFrequency := SourceDM.dmDisplayFrequency;
  DestinationDM.dmICMMethod := SourceDM.dmICMMethod;
  DestinationDM.dmICMIntent := SourceDM.dmICMIntent;
  DestinationDM.dmMediaType := SourceDM.dmMediaType;
  DestinationDM.dmDitherType := SourceDM.dmDitherType;
  DestinationDM.dmICCManufacturer := SourceDM.dmICCManufacturer;
  DestinationDM.dmICCModel := SourceDM.dmICCModel;
  DestinationDM.dmPanningWidth := SourceDM.dmPanningWidth;
  DestinationDM.dmPanningHeight := SourceDM.dmPanningHeight;
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
{ TwipsToInches                                                                }
{------------------------------------------------------------------------------}
function TwipsToInches(iValue: integer): double;
begin
  Result := iValue / 1440;
end;
{------------------------------------------------------------------------------}
{ InchesToTwips                                                                }
{------------------------------------------------------------------------------}
function InchesToTwips(fValue: double): integer;
begin
  Result := Trunc(fValue * 1440);
end;
{------------------------------------------------------------------------------}
{ TwipsToInchesStr                                                             }
{------------------------------------------------------------------------------}
function TwipsToInchesStr(iValue: integer): string;
begin
  Result := FloatToStrF(TwipsToInches(iValue),ffFixed,8,3);
end;
{------------------------------------------------------------------------------}
{ InchesStrToTwips                                                             }
{------------------------------------------------------------------------------}
function InchesStrToTwips(sValue: string): integer;
var
  fValue : double;
begin
  Result := 0;
  if IsFloating(sValue) then
  begin
    fValue := StrToFloat(sValue);
    Result := InchesToTwips(fValue);
  end;
end;
{------------------------------------------------------------------------------}
{ CompareTwipsToInches                                                         }
{------------------------------------------------------------------------------}
function CompareTwipsToInches(iTwips: integer; dInches: double): boolean;
var
  ixTwips : integer;
begin
  Result := False;
  ixTwips := InchesToTwips(dInches);
  if iTwips <> ixTwips then
    Result := True;
end;
{------------------------------------------------------------------------------}
{ TwipsToPoints                                                                }
{------------------------------------------------------------------------------}
function TwipsToPoints(iValue: integer): double;
begin
  Result := iValue / 20;
end;
{------------------------------------------------------------------------------}
{ PointsToTwips                                                                }
{------------------------------------------------------------------------------}
function PointsToTwips(fValue: double): integer;
begin
  Result := Trunc(fValue * 20);
end;
{------------------------------------------------------------------------------}
{ TwipsToPointsStr                                                             }
{------------------------------------------------------------------------------}
function TwipsToPointsStr(iValue: integer): string;
begin
  Result := FloatToStrF(TwipsToPoints(iValue),ffFixed,8,3);
end;
{------------------------------------------------------------------------------}
{ PointsStrToTwips                                                             }
{------------------------------------------------------------------------------}
function PointsStrToTwips(sValue: string): integer;
var
  fValue : double;
begin
  Result := 0;
  if IsFloating(sValue) then
  begin
    fValue := StrToFloat(sValue);
    Result := PointsToTwips(fValue);
  end;
end;
{------------------------------------------------------------------------------}
{ CompareTwipsToPoints                                                         }
{------------------------------------------------------------------------------}
function CompareTwipsToPoints(iTwips: integer; dPoints: double): boolean;
var
  ixTwips : integer;
begin
  Result := False;
  ixTwips := PointsToTwips(dPoints);
  if iTwips <> ixTwips then
    Result := True;
end;

{------------------------------------------------------------------------------}
{ LoadFormPos                                                                  }
{------------------------------------------------------------------------------}
procedure LoadFormPos(frmTemp: TForm);
var
  RegIni : TRegIniFile;
begin
  {Read the Registry}
  RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\CrystalVCL\');
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
  RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\CrystalVCL\');
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
  RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\CrystalVCL\');
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
  {Write to the Registry}
  RegIni := TRegIniFile.Create('Software\Business Objects\Suite 11.0\CrystalVCL\');
  try
    RegIni.WriteInteger(frmTemp.Name,'Left',frmTemp.Left);
    RegIni.WriteInteger(frmTemp.Name,'Top',frmTemp.Top);
    RegIni.WriteInteger(frmTemp.Name,'Width',frmTemp.Width);
    RegIni.WriteInteger(frmTemp.Name,'Height',frmTemp.Height);
  finally
    RegIni.Free;
  end;
end;
{------------------------------------------------------------------------------}
{ GetCommonFilesPath                                                           }
{------------------------------------------------------------------------------}
function GetCommonFilesPath : string;
var
  regKey : TRegistry;
  s      : string;
begin
  regKey := TRegistry.Create(KEY_READ);
  try
    regKey.RootKey := HKEY_LOCAL_MACHINE;
    //regKey.OpenKey('SOFTWARE\Crystal Decisions\10.0\Crystal Reports', False);
    regKey.OpenKey('SOFTWARE\Business Objects\Suite 11.0\Crystal Reports', False);
    s := regKey.ReadString('CommonFiles');
    Result := AddBackslash(s);
  finally
    regKey.Free;
  end;
end;
{------------------------------------------------------------------------------}
{ CrGetTempName                                                                }
{------------------------------------------------------------------------------}
function CrGetTempName (const Extension: string) : string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  repeat
    GetTempPath(SizeOf(Buffer) - 1, Buffer);
    GetTempFileName(Buffer, '~', 1, Buffer);
    Result := ChangeFileExt(Buffer, Extension);
  until not FileExists(Result);
end;


end.


