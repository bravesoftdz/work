unit uDMGlobal;

interface

uses
  SysUtils, Classes, ADODB, DB;

type
  TDMGlobal = class(TDataModule)
    qryFreeSQL: TADOQuery;
    quParam: TADOQuery;
    quParamSrvParameter: TStringField;
    quParamSrvValue: TStringField;
    quParamDefaultValue: TStringField;
    quParamDescription: TStringField;
    quParamSrvType: TStringField;
    cmdFreeSQL: TADOCommand;
    spGetNextKey: TADOStoredProc;
  private
    function GetNextKey(sTabela : String; SQLConnection: TADOConnection) : Integer;
  public
    function GetNextCode(const TableName, FieldName: WideString; SQLConnection: TADOConnection): Integer;
    procedure RunSQL(sSQL: String; SQLConnection: TADOConnection);
    function GetSvrParam(IDParam: Integer; SQLConnection: TADOConnection): OleVariant;
    procedure ExecuteSQL(sSQL: String; SQLConnection: TADOConnection);
    function IsClientServer(SQLConnection: TADOConnection): Boolean;
  end;

var
  DMGlobal: TDMGlobal;

implementation

uses uSystemConfig, uSystemConst;

{$R *.dfm}

{ TDMGlobal }

function TDMGlobal.GetNextCode(const TableName,
  FieldName: WideString; SQLConnection: TADOConnection): Integer;
var
  TableField: String;
  bEmpty : Boolean;
begin
  TableField := TableName + '.' + FieldName;

  try

    Result := GetNextKey(TableField, SQLConnection);

    //Implementar a nova funcao para retornar ID da tabla
    {
    ///  Começa Novo
    with qryFreeSQL do
    begin
      if Active then
        Close;
      Connection := SQLConnection;

      SQL.Text := ' SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = ' + QuotedStr(TableField);

      try
        Open;
        bEmpty := IsEmpty;
        //retorna o proximo registro
        Result := FieldByName('UltimoCodigo').AsInteger + 1;
      finally
        Close;
      end;
    end;

     //Cria o campo caso nao tenha
    if bEmpty then
      SQLConnection.Execute('INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo) VALUES (' + QuotedStr(TableField) + ',0)');

    //Salva o proximo registro
    RunSQL(' UPDATE  Sis_CodigoIncremental SET UltimoCodigo = UltimoCodigo + 1 '+
           ' FROM Sis_CodigoIncremental (UPDLOCK, ROWLOCK) WHERE Tabela = ' + QuotedStr(TableField),SQLConnection);
    }

  except
    Result := -1;
  end;

end;

procedure TDMGlobal.RunSQL(sSQL: String; SQLConnection: TADOConnection);
begin
with qryFreeSQL do
  try
    Connection := SQLConnection;
    SQL.Text := sSQL;
    ExecSQL;
  finally
    Close;
  end;
end;

procedure TDMGlobal.ExecuteSQL(sSQL: String; SQLConnection: TADOConnection);
begin
with cmdFreeSQL do
  try
    Connection  := SQLConnection;
    CommandText := sSQL;
    Execute; 
  except
    raise;
  end;
end;


function TDMGlobal.GetSvrParam(IDParam: Integer;
                       SQLConnection: TADOConnection): OleVariant;
begin
  with quParam do
  begin
   if Active then
     Close;
   Connection := SQLConnection;  
   Parameters.ParamByName('IDParam').Value    := IDParam;
   Parameters.ParamByName('IDLanguage').Value := 1;
   Open;
   try
     Result := FieldByName('SrvValue').Value;
   finally
     Close;
     end;
  end;
end;

function TDMGlobal.IsClientServer(SQLConnection: TADOConnection): Boolean;
var
  VersionType: String;
begin
  if GetSystemConfig(SQLConnection, VersionType) then
    Result := (VersionType = SYSTEM_CLIENT_TYPE) or (Pos(SYSTEM_CLIENT_TYPE, VersionType) > 0);
end;


function TDMGlobal.GetNextKey(sTabela : String; SQLConnection: TADOConnection) : Integer;
begin

  with spGetNextKey do
  begin
    Connection := SQLConnection;
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  end;

end;

end.
