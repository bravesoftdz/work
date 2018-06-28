{ *********************************************************************** }
{                                                                         }
{ Author: Yanniel Alvarez Alfonso                                         }
{ Description: Wrapper for the 7-Zip compression program                  }
{ Copyright (c) ????-2012 Pinogy Corporation                              }
{                                                                         }
{ *********************************************************************** }

unit SevenZipUtils;

interface

uses
  Windows, SysUtils, Dialogs, Forms;

type
  TArchiveFormat = (_7Z, GZIP, ZIP, BZIP2, TAR, ISO, UDF);

  T7ZipWrapper = class
  private
    class function GetFileNameOnly(aFileName: string): string;
    class function GetArchiveFormatAsString(aArchiveFormat: TArchiveFormat): string;
  public
    class function Archive(aSourceFolderName,
                           aDentinyFileName,
                           aFileMask : String;
                           aFormat: TArchiveFormat;
                           aPassword: string = ''): Boolean;

    class function Extract(aSourceFileName: string; aPassword: string = ''): Boolean;
  end;

implementation

uses
  MiscUtils;

{ T7ZipWrapper }

class function T7ZipWrapper.GetFileNameOnly(aFileName: string): string;
var
  FileExt: string;
begin
  FileExt:= ExtractFileExt(aFileName);
  Result:= Copy(aFileName, 1, Length(aFileName) - Length(FileExt));
end;

class function T7ZipWrapper.GetArchiveFormatAsString(aArchiveFormat: TArchiveFormat): string;
begin
  Result:= '';
  case  aArchiveFormat of
    _7Z:   Result:= '7z';
    GZIP:  Result:= 'gzip';
    ZIP:   Result:= 'zip';
    BZIP2: Result:= 'bzip2';
    TAR:   Result:= 'tar';
    ISO:   Result:= 'iso';
    UDF:   Result:= 'udf';
  end;
end;

class function T7ZipWrapper.Archive(aSourceFolderName,
                                    aDentinyFileName,
                                    aFileMask : String;
                                    aFormat: TArchiveFormat;
                                    aPassword: string = ''): Boolean;
const
  //CMD Example:'7za a -t7z files.7z *.txt'
  cArchiveCMD1 = 'a -mx9 -t%0:s "%1:s" "%2:s"';     //No password considered
  cArchiveCMD2 = 'a -mx9 -t%0:s "%1:s.%2:s" "%3:s"'; //No password considered

var
  _7zaAbsolutePath,
  ArchiveFullName,
  ArchiveFormat,
  ParamStr: string;
  ProcID: DWord;
begin
  Result:= False;
  _7zaAbsolutePath:=  ExtractFilePath(Application.ExeName) + '7za.exe';
  if not FileExists(_7zaAbsolutePath) then Exit;

  ArchiveFormat:= GetArchiveFormatAsString(aFormat);

  if Pos('*.', aFileMask) = 1 then
  begin
    if Pos('/', aSourceFolderName) = Length(aSourceFolderName) then
      Delete(aSourceFolderName, Length(aSourceFolderName), 1);
    ArchiveFullName:= aSourceFolderName;
    ParamStr:= Format(cArchiveCMD1, [ArchiveFormat, {ArchiveFullName}aDentinyFileName, aSourceFolderName + '\' + aFileMask]);
  end
  else
  begin
    //The file mask is actually a file name
    ArchiveFullName:= GetFileNameOnly(aFileMask);
    ParamStr:= Format(cArchiveCMD2, [ArchiveFormat, aSourceFolderName + ArchiveFullName, ArchiveFormat, aSourceFolderName + aFileMask]);
  end; 

  //Adding password if needed
  if aPassword <> '' then
    ParamStr:= ParamStr + ' -p"' + aPassword + '"';

  Result:= ExecuteProgram('7za', ParamStr,  ProcID, True) = 0;
end;

class function T7ZipWrapper.Extract(aSourceFileName: string;
                                    aPassword: string = ''): Boolean;
const
  //Example: 7z e archive.zip
  cExtractCMD = 'e "%0:s" -y'; //No password considered
var
  _7zaAbsolutePath,
  ParamStr: string;
  ProcID: DWord;
begin
  Result:= False;
  _7zaAbsolutePath:=  ExtractFilePath(Application.ExeName) + '7za.exe';
  if not FileExists(_7zaAbsolutePath) then Exit;

  ParamStr:= Format(cExtractCMD, [aSourceFileName]);

  //Adding password if needed
  if aPassword <> '' then
    ParamStr:= ParamStr + ' -p"' + aPassword + '"';

  Result:= ExecuteProgram('7za', ParamStr,  ProcID, True) = 0;
end; 

end.
