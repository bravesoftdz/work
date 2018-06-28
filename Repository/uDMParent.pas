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
    fADOConnectionString : String;
    procedure SetADOConnectionString(sConect:String);
  protected
    procedure ADOConnectionOpen;
    procedure ADOConnectionClose;
  public
    { Public declarations }
    fSQLConnectParam : TSQLConnection;
    function RunSQL(MySQL: String): Boolean;
    function GetNextID(Const sTabela: String): LongInt; overload; virtual;
    function GetMaxKey(TableFieldName : String)  : Integer;
    property ADOConnectionString : string read fADOConnectionString write SetADOConnectionString;
  end;

var
  DMParent: TDMParent;

implementation

{$R *.DFM}

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
  fADOConnectionString := '';
  fSQLConnectParam := TSQLConnection.Create;
end;

procedure TDMParent.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(fSQLConnectParam);
end;

end.
