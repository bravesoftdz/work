unit uModuleConfig;

interface

uses
  SysUtils, AdoDB, uMsgBox, uDM;

function ModuleStart: boolean;

implementation

uses uEncryptFunctions, uParamFunctions, uSystemObj;


function ModuleStart: boolean;
var
  sModInfo: string;
begin
  Result:= false;

  with TADOQuery.Create(nil) do
  begin
    Connection:= DM.DBADOConnection;

    SQL.Add('SELECT ModuleInfo, VersionNo, BuildNo, VersionType, RestricForms FROM Sys_Module');
    Open;
    if IsEmpty then
      Exit;
    sModInfo := DecodeServerInfo(FieldByName('ModuleInfo').AsString, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU);
    Close;

    //Extracting Module #
    DM.fSystem.StartMode    := ParseParam(sModInfo, '#Module#=')[1];
    //Extract License Key
    DM.fSystem.ValidLicense := (ParseParam(sModInfo, '#Key#=')='Y');

    if not(DM.fSystem.StartMode in [SYS_MODULE_TRIAL, SYS_MODULE_1..SYS_MODULE_5]) then
      Exit;

    Free;
  end;

  Result:= true;
end;

end.
