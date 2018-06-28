unit uDMParent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, uSQLObj;

type
  TDMParent = class(TDataModule)
    spGetNextID: TADOStoredProc;
    ADODBConnect: TADOConnection;
    quFreeSQL: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    fLocalPath           : String;
    fADOConnectionString : String;
    procedure SetADOConnectionString(sConect:String);
  public
    { Public declarations }
    fSQLConnectParam : TSQLConnection;

    function RunSQL(MySQL: String): Boolean;
    function GetNextID(Const sTabela: String): LongInt; overload; virtual;
    function GetMaxKey(TableFieldName : String)  : Integer;
    function DescCodigo(aFilterFields, aFilterValues : array of String;
                        DescTable, DescField : String) : String;


    procedure ADOConnectionOpen;
    procedure ADOConnectionClose;
    procedure SQLBeginTrans;
    procedure SQLCommitTrans;
    procedure SQLRollBackTrans;
    property ADOConnectionString : string read fADOConnectionString write SetADOConnectionString;
    property LocalPath           : String read fLocalPath;
  end;

var
  DMParent: TDMParent;

implementation

uses uStringFunctions;

{$R *.DFM}

procedure TDMParent.SQLBeginTrans;
begin
 ADODBConnect.BeginTrans;
end;

procedure TDMParent.SQLCommitTrans;
begin
 ADODBConnect.CommitTrans;
end;

procedure TDMParent.SQLRollBackTrans;
begin
 ADODBConnect.RollbackTrans;
end;

procedure TDMParent.ADOConnectionOpen;
begin
  if not ADODBConnect.Connected then
     ADODBConnect.Open;
end;

procedure TDMParent.ADOConnectionClose;
begin
  if ADODBConnect.Connected then
     ADODBConnect.Close;
end;

procedure TDMParent.SetADOConnectionString(sConect:String);
begin
  if sConect = '' then
     Exit;
  fADOConnectionString          := sConect;
  ADODBConnect.ConnectionString := sConect;
end;

function TDMParent.GetMaxKey(TableFieldName : String)  : Integer;
begin
 with quFreeSQl do
   begin
     if Active then Close;
     SQL.Text := 'SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = '+QuotedStr(TableFieldName);
     Open;
     Result := Fields[0].AsInteger;
     Close;
   end;

end;

function TDMParent.DescCodigo(aFilterFields, aFilterValues : array of String;
                        DescTable, DescField : String) : String;
var
   i : integer;
   strWhere, strSelect : String;
begin
  // Funcao de procura padrao
  // Lembar de passar com as devidas conversoes

  Screen.Cursor := crHourGlass;
  try

    strWhere := '';
    for i := Low(aFilterFields) to High(aFilterFields) do
     begin
       IncString(StrWhere, '( ' + aFilterFields[i] + ' = ' +
                            aFilterValues[i] + ' )');
       if i < High(aFilterFields) then
          IncString(StrWhere, ' AND ');
     end;

    strSelect := 'SELECT ' + DescField + ' FROM ' +
                 DescTable + ' WHERE ' + StrWhere;

    (*
    with quFreeSQL do
     begin
        if Active then Close;
        SQL.Text := strSelect;
        try
          Open;
          if Bof and Eof then
             Result := ''
          else
             Result := Fields[0].AsString;
          Close;
        except
          on exception do
            raise exception.create('You enter an invalid search');
        end;
     end;
    *)

     with TADOQuery.Create(Self) do
     try
        Connection := ADODBConnect;
        if Active then Close;
        SQL.Text := strSelect;
        try
          Open;
          if Bof and Eof then
             Result := ''
          else
             Result := Fields[0].AsString;
        except
          on exception do
            raise exception.create('You enter an invalid search');
        end;
     finally
       Close;
       Free;
     end;

  finally
    Screen.Cursor := crDefault;
  end;
end;


function TDMParent.RunSQL(MySQL: String): Boolean;
begin
  with quFreeSQL do
    begin
      try
        if Active then
          Close;
        SQL.Text := MySQL;
        ExecSQL;
        Result := True;
      except
        Result := False;
      end;
    end;
end;

function TDMParent.GetNextID(Const sTabela: String): LongInt;
begin
  with spGetNextID do
    begin
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
    end;
end;


procedure TDMParent.DataModuleCreate(Sender: TObject);
begin
  fLocalPath       := ExtractFilePath(Application.ExeName);
  fADOConnectionString := '';
  fSQLConnectParam := TSQLConnection.Create;
end;

procedure TDMParent.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fSQLConnectParam);
end;

end.
