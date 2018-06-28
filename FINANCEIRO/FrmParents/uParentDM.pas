unit uParentDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, ADODB, RCADOQuery, xBase;

type
  TParentDM = class(TDataModule)
    quFreeSQL: TADOQuery;
    quRebuildIdent: TADOQuery;
    quConstante: TRCADOQuery;
    quConstanteConstante: TStringField;
    quConstanteValor: TIntegerField;
    quRebuildIdentTABLE_QUALIFIER: TStringField;
    quRebuildIdentTABLE_OWNER: TStringField;
    quRebuildIdentTABLE_NAME: TStringField;
    quRebuildIdentTABLE_TYPE: TStringField;
    quRebuildIdentREMARKS: TStringField;
    DBADOConnection: TADOConnection;
    procedure ParentDMCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SetClientToServerDate;
  public
    { Public declarations }
    aSrvParam           : Variant;
    aCliParam           : Variant;
    function GetLastKey : Integer;
    function GetConst(Literal: String): Integer;
    function GetMaxKey(TableName, MaxField : String)  : Integer;
    function DescCodigo(aFilterFields, aFilterValues : array of String;
                        DescTable, DescField : String) : String;
    function GetActualPathName(strSQL, FieldName : String; IDItem : Integer) : String;
    procedure DBCC_RebuildIdentity;

    function GetSQLKey(MySQL: String): String;
    function GetTableCount(ATableName:String): integer;
  end;

implementation

{$R *.DFM}

uses uSQLFunctions, uNumericFunctions, uStringFunctions;


function TParentDM.GetTableCount(ATableName: String): integer;
begin
  with quFreeSQL do
    begin
      Close;
      with SQL do
        begin
          Clear;
          Add('SELECT');
          Add('   MAX(i.rows) as RecCount');
          Add('FROM');
          Add('   [sysindexes] I,');
          Add('   INFORMATION_SCHEMA.TABLES T');
          Add('WHERE');
          Add('   T.TABLE_NAME = object_name(i.id)');
          Add('   AND');
          Add('   T.TABLE_TYPE = '+QuotedStr('BASE TABLE'));
          Add('   AND');
          Add('   T.TABLE_NAME = '+QuotedStr(ATableName));
          Add('GROUP BY');
          Add('   T.TABLE_SCHEMA,');
          Add('   T.TABLE_NAME');
        end;
      Open;
      Result := Fields[0].AsInteger;
      Close;
    end;
end;


function TParentDM.GetSQLKey(MySQL: String): String;
var
  sTableName: String;

begin
  sTableName := GetSQLFirstTableName(MySQL);

  // Retiro o nome do usuario caso ele exista
  if UpperCase(LeftStr(sTableName, 4)) = 'DBO.' then
    sTableName := RightStr(sTableName, Length(sTableName)-4);

  with quFreeSQL do
    begin
      if Active then
         Close;
      SQL.Text := 'sp_System_dbKeys ' + Chr(39) + sTableName + Chr(39);
      Open;
      Result := FieldByName('COLUMN_NAME').AsString;
      Close;
    end;
end;


function TParentDM.GetConst(Literal: String): Integer;
begin
  with quConstante do
    begin
      if not Active then Open;

      if Locate('Constante', Literal, []) then
         Result := MyStrToInt(quConstanteValor.AsString)
      else
         showmessage( 'Constant : ' + Literal + ' could not be found in the database.');

    end;
end;

function TParentDM.GetActualPathName(strSQL, FieldName : String; IDItem : Integer) : String;
begin
    // Descobre o Path Name do no selecionado
    with quFreeSQL do
      begin
        try
          if Active then
             Close; 
          SQL.Text := 'SELECT PathName FROM ' +
                      GetSQLFirstTableName(strSQL) +
                      ' WHERE ' + FieldName + ' = ' + IntToStr(IDItem);
          Open;
          Result := Trim(Fields[0].AsString);
          Close;
        except
          on exception do
             raise exception.create('You enter with an invalid search');
        end;
      end;
end;

function TParentDM.DescCodigo(aFilterFields, aFilterValues : array of String;
                              DescTable, DescField : String) : String;
var
   i : integer;
   strWhere, strSelect : String;
begin
  // Funcao de procura padrao
  // Lembar de passar com as devidas conversoes

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

  with quFreeSQL do
   begin
      if Active then
         Close;
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
          raise exception.create('You enter with an invalid search');
      end;
   end;

  Screen.Cursor := crDefault;
end;

procedure TParentDM.SetClientToServerDate;
var
  ServerTime : TDateTime;
  ServerSysTime : TSystemTime;
begin
  with quFreeSQL do
    begin
      if Active then
         Close;
      SQL.Text := 'SELECT GetDate()';
      Open;
      ServerTime := Fields[0].AsDateTime;
      Close;
      DateTimeToSystemTime(ServerTime, ServerSysTime);
      SetLocalTime(ServerSysTime);
    end;
end;


function TParentDM.GetLastKey : Integer;
begin
 with quFreeSQl do
   begin
     if Active then
        Close;
     SQL.Text := 'SELECT @@IDENTITY';
     Open;
     Result := Fields[0].AsInteger;
     Close;
   end;
end;

function TParentDM.GetMaxKey(TableName, MaxField : String)  : Integer;
begin
 with quFreeSQl do
   begin
     if Active then
        Close;
     //Com a replicacao isso nao funciona
     //SQL.Text := 'SELECT MAX(' + MaxField + ') FROM ' + TableName;
     SQL.Text := 'SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = ' + QuotedStr(TableName + '.' + MaxField);
     Open;
     Result := Fields[0].AsInteger;
     Close;
   end;
end;

procedure TParentDM.DBCC_RebuildIdentity;
begin
  Screen.Cursor := crHourGlass;
  with quRebuildIdent do
   begin
     Open;
     if quFreeSQL.Active then
        quFreeSQL.Close;
     while not Eof do
       begin
         quFreeSQL.SQL.Text := 'DBCC CHECKIDENT (' + quRebuildIdentTABLE_NAME.AsString + ')';
         try
           quFreeSQL.ExecSQL;
         except
         end;
         Next;
       end;
     Close;
   end;
  Screen.Cursor := crDefault;
end;


procedure TParentDM.ParentDMCreate(Sender: TObject);
var
  Year, Dummy   : Word;
  tmpDateFormat : String;

begin

   // Seta a data do cliente igual a do server
   SetClientToServerDate;

   // Seta o decimalseparator
   //DecimalSeparator := '.';

   // Seta se mostra data com 4 digitos, quando passa do ano 2000
   DecodeDate(Date, Year, Dummy, Dummy);
   if Year = 2000 then
     begin
       tmpDateFormat := UpperCase(ShortDateFormat);
       if(pos('YYYY', tmpDateFormat) = 0) and (pos('YY', tmpDateFormat) <> 0) then
         insert('YY', tmpDateFormat, pos('YY', tmpDateFormat));
       ShortDateFormat := tmpDateFormat;
     end;
end;

end.
