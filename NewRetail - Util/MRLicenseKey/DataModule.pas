unit DataModule;

interface

uses
  Windows, SysUtils, Classes, DB, ADODB, Dialogs;

type
  Tdm = class(TDataModule)
    ADOConnection: TADOConnection;
  private
    { Private declarations }
    function getConnection: String;
  public
    { Public declarations }
    function getModuleInfo: TDataSet;
    function UpdateModuleInfo(AModuleInfo: String): boolean;
    function getSQLObj(ASQL: String; ACanOpen: boolean = true): TDataSet;
    function ApplySQL(ASQL: String): boolean; overload;
    function ApplySQL(ADataset: TDataSet): boolean; overload;
  end;

var
  dm: Tdm;

implementation
uses Registry, uParamFunctions, uEncryptFunctions, uOperationSystem;

{$R *.dfm}

{ Tdm }

function Tdm.ApplySQL(ASQL: String): boolean;
var
  qryADO: TADOQuery;
begin
  result := false;
  try
    ADOConnection.Close;
    ADOConnection.ConnectionString := getConnection;
    qryAdo := TADOQuery.Create(nil);
    qryAdo.Connection := ADOConnection;
    try
      qryAdo.ExecSQL;
      result := true;
    except
      //
    end;
  finally
    freeAndNil(qryAdo);
  end;
end;

function Tdm.ApplySQL(ADataset: TDataSet): boolean;
begin
  try
     ( ADataSet as TADOQuery ).ExecSQL;
     result := true;
   except
     result := false;
   end;
end;

function Tdm.getConnection: String;
var
  Reg : TRegistry;
  buildInfo: String;
  sResult, sServer, sDBAlias, sUser, sPW : String;

begin

  try
    //Pega as info local
    Reg := TRegistry.Create;

    if ( getOS(buildInfo) = osW7 ) then
      Reg.RootKey := HKEY_CURRENT_USER
    else
      Reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey('SOFTWARE\AppleNet', True);

    sResult := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    sServer  := ParseParam(sResult, '#SRV#=');
    sDBAlias := ParseParam(sResult, '#DB#=');
    sUser    := ParseParam(sResult, '#USER#=');
    sPW      := ParseParam(sResult, '#PW#=');

    result := SetConnectionStr(sUser, sPw, SDBAlias, sServer);

    //Fechar o Registry
    Reg.CloseKey;
    Reg.Free;
  except
    ShowMessage('Connection Error !');
    Abort;
  end;

end;

function Tdm.getModuleInfo: TDataSet;
var
  sql: String;
begin
  sql := 'Select ModuleInfo from Sys_Module';
  result := getSQLObj(Sql);
end;

function Tdm.getSQLObj(ASQL: String; ACanOpen: boolean): TDataSet;
var
  qryAdo: TADOQuery;
begin
  try
    qryAdo := TADOQuery.Create(nil);
    ADOConnection.Close;
    ADOConnection.ConnectionString := getConnection;
    qryAdo.Connection := ADOConnection;
    qryAdo.SQL.Text := ASql;
    try
      if ( ACanOpen ) then
         qryAdo.Open;
      result := qryADO;
    except
      freeAndNil(qryAdo);
    end;
  finally
//    freeAndNil(qryAdo);
  end;
end;

function Tdm.UpdateModuleInfo(AModuleInfo: String): boolean;
var
  sql: String;
  ds: TDataSet;
begin
  sql := 'Update Sys_Module set ModuleInfo = :moduleinfo';
  ds  := getSQLObj(sql, false);

  ( ds as TADOQuery ).Parameters.ParamByName('moduleinfo').Value := AModuleInfo;


  result := ApplySQL(ds);
end;

end.
