unit uCreateDatabase;

interface

uses
  SysUtils, Forms, DBTables, Windows, uDM;

function AppDrive: string;
function AppDir: string;
procedure CreateDatabase;
procedure ChkDBMissing;

implementation

function AppDrive: string;
begin
  result:= ExtractFileDrive(Application.ExeName);
end;

function AppDir: string;
begin
  result:= ExtractFilePath(Application.ExeName);
end;

procedure CreateDatabase;
var
  DBName: string;
begin
  with TDatabase.Create(Application) do
  begin
    AliasName:= 'MasterDB';
    DatabaseName:= 'DBMaster';
    LoginPrompt:= false;
    Open;
    with TQuery.Create(Application) do
    begin
      DatabaseName:= 'DBMaster';
      DBName:= DM.ADODBConnect.DefaultDatabase;
      SQL.Text:= 'CREATE DATABASE '+ DBName +' ON '+
                 '( NAME = Data, '+
                 '  FILENAME = '''+ AppDrive +'\MSSQL7\Data\'+ DBName +'.mdf'', '+
                 '  SIZE = 8, '+
                 '  FILEGROWTH = 5MB ) '+
                 'LOG ON '+
                 '( NAME = LOG, '+
                 '  FILENAME = '''+ AppDrive +'\MSSQL7\Data\'+ DBName +'.ldf'', '+
                 '  SIZE = 2, '+
                 '  FILEGROWTH = 2MB )';
      ExecSQL;
      Free;
    end;
    Close;
    Free;
  end;
  CopyFile(pchar(AppDir + DBName +'.mdf'),
           pchar(AppDrive +'\MSSQL7\Data\'+ DBName +'.mdf'), false);
  CopyFile(pchar(AppDir + DBName +'.ldf'),
           pchar(AppDrive +'\MSSQL7\Data\'+ DBName +'.ldf'), false);
  sysutils.DeleteFile(AppDir + DBName +'.mdf');
  sysutils.DeleteFile(AppDir + DBName +'.ldf');
end;

procedure ChkDBMissing;
begin
  if FileExists(AppDir + 'RetailDB.mdf') then
    CreateDatabase;
end;

(* texto a ser incluido em uDM antes do connect do database
   ChkDBMissing; // Checa existencia do banco de dados da aplicacao

   Application.ProcessMessages;

*)

end.
