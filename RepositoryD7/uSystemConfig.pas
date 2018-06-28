unit uSystemConfig;

interface

uses
  SysUtils, AdoDB, uMsgBox, Graphics, DBTables, DB;

function GetSystemConfig(SQLConnection: TADOConnection; var VersionType: String): Boolean;

implementation

uses uEncryptFunctions, uParamFunctions, uSystemObj, uDateTimeFunctions;

function GetSystemConfig(SQLConnection: TADOConnection; var VersionType: String): Boolean;
begin
  Result:= false;

  with TADOQuery.Create(nil) do
  try
    Connection:= SQLConnection;

    SQL.Add('SELECT ModuleInfo, VersionNo, BuildNo, VersionType, RestricForms, MRLogo FROM Sys_Module');
    Open;
    if IsEmpty then
      Exit;

    VersionType := FieldByName('VersionType').AsString;
  finally
    Free;
  end;

  Result := True;
end;

end.
