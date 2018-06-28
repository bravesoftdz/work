//**************************************************************************//
//    Unit:             uReplicationClasses.pas                             //
//    Descrição:        Implementação das classes de replicação             //
//                      utilizando arquivos XML                             //
//**************************************************************************//


unit uReplicationClasses;

interface

Uses Classes, SysUtils, ADODB, Provider, DBClient, DB, Dialogs, Variants;

const
  ERR_NO_DATA_LOADED      = 'Dados não carregados.';
  DEFAULT_SQL_BATCH_COUNT = 10;

  { Alex 12/27/2011 - New special caracters table }
  //SPECIAL_CHARS : array [1..7] of Byte =(10, 13, 34, 180, 94, 96, 126);
  SPECIAL_CHARS : array [1..4] of Byte =(10, 13, 180, 96);

  CRLF = #13#10;
type
  TServerType = (stMSSQL2000, stOracle9i);

  TReplicationClass = class(TComponent)
  private
    quExec       : TADOCommand;
    FServerType  : TServerType;
    FConnection  : TAdoConnection;
    FPrimaryKeys : TStringList;
    FTableName   : String;
    FConstraints : TStringList;
    FDataLoaded  : Boolean;
    FSelectWhereClause: String;
    FFieldTypes: TStringList;
    FDateFields: TStringList;
    procedure SetTableName(const Value: String);virtual;abstract;
    procedure SetConnection(const Value: TADOConnection);virtual;
    procedure GenerateOnDeleteTrigger(sTrigger: String);
    function TriggerExists(TriggerName: String): Boolean;
    procedure CreateReplicationColumn;
    function GenerateOnInsUpdTrigger(sTrigger: String): String;

    function GenerateInsUpdProcedureParameters : String;
    function GenerateInsertFieldsValues(IsValue: boolean): String;
    function GenerateInsertUpdateSetFieldsValues: String;
    function GenerateInsertUpdateWhereFieldsValues: String;

  protected
    procedure SetSelectWhereClause(const Value: String);virtual;
    procedure CreateInsUpdProcedure; virtual;


    property  Connection:        TAdoConnection read FConnection        write SetConnection;
    property  Constraints:       TStringList    read FConstraints       write FConstraints;
    property  DataLoaded:        Boolean        read FDataLoaded        write FDataLoaded;
    property  TableName:         String         read FTableName         write SetTableName;
    property  PrimaryKeys:       TStringList    read FPrimaryKeys;
    property  FieldTypes:        TStringList    read FFieldTypes;
    property  DateFields:        TStringList    read FDateFields;
    property  SelectWhereClause: String         read FSelectWhereClause write SetSelectWhereClause;
    property  ServerType:        TServerType    read FServerType        write FServerType;

    procedure ReadPrimaryKeys;virtual;
    procedure ReadFieldTypes;virtual;
    procedure CreateReplicationFeatures(CreateDeleteTrigger: Boolean = False);
    procedure RunSQL(sSQL: String);
    procedure FillRepDate;


  public
    function GenerateInsUpdProcedure: String; virtual;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;
  end;

  TTableToXML = class(TReplicationClass)
  private

    Query              : TAdoQuery;
    Provider           : TDataSetProvider;
    ClientDataSet      : TClientDataSet;
    FReplicateSince: Integer;
    FSaveEmptyTable: Boolean;
    function LoadDataFromTable(TableName : String) : String;

  public
    property ReplicateSince: Integer read FReplicateSince write FReplicateSince;
    property SaveEmptyTable: Boolean read FSaveEmptyTable write FSaveEmptyTable default False;
    property  SelectWhereClause;

    constructor Create(AOwner : TComponent);Override;
    destructor Destroy;override;

    function SaveToXML(FileName : String): String;
    procedure UnloadData;
    property TableName;
  protected
    function GenerateInsUpdProcedure: String;override;
    procedure SetTableName(const Value: String);override;
    procedure SetConnection(const Value: TADOConnection);override;
  published
    property Connection;
  end;


  TXMLToTable = class(TReplicationClass)
    private
      Query : TAdoQuery;
      ClientDataSet : TClientDataSet;
      FPrimaryKeys: TStringList;
      FSQLBatchCount: Cardinal;
      FJustInsert: Boolean;
      function GenerateWhereClause(TableName : String): String;
      function GenerateUpdateClause(TableName : String): String;
      //procedure DisableTriggers(sTable: String);
      //procedure EnableTriggers(sTable: String);
    function ConvertQuoted(S: String): String;
    function MSSQL2000ConvertQuoted(S: String): String;
    function GenerateSelectClause(TableName: String): String;
    function GenerateStoredProcedureCall: String;
    function GenerateVariableSET: String;
    function GenerateVariableDeclare: String;
    protected
      procedure SetTableName(const Value: String);override;
      procedure SetConnection(const Value: TADOConnection);override;
      procedure SetSelectWhereClause(const Value: String);override;
    public
      property JustInsert: Boolean read FJustInsert write FJustInsert default False;
      property SelectWhereClause;
      property TableName;

      constructor Create(AOwner : TComponent);Override;
      destructor Destroy;override;

      function LoadDataFromXML(FileName : String): String;
      procedure UnloadData;
      function SaveDataToTable(TableName : String): String;
      function GetFieldValue(Field: TField) : String;
      function GenerateSQLInsert(TableName: String): String;
    published
      property SQLBatchCount : Cardinal read FSQLBatchCount write FSQLBatchCount default DEFAULT_SQL_BATCH_COUNT;
      property Connection;
  end;

  procedure ModifyAllConstraints(ServerType: TServerType; AConnection : TADOConnection; Enable : Boolean);
  procedure CreateDeletionTable(ServerType: TServerType; AConnection : TADOConnection);

implementation

uses uNumericFunctions, uReplicationConsts;

function StringListToFormatedText(Lista: TStrings; Separator: String; prefix: String = ''): String;
var
  i: Integer;
  Prefixed : String;
begin
  Result := '';
  for i := 0 to Pred(Lista.Count) do
  begin
    if Prefix <> '' then
       Prefixed := prefix + Lista[I]
    else
      Prefixed := Lista[I];

    if i <> Pred(Lista.Count) then
      Result := Result + Prefixed + Separator
    else
      Result := Result + Prefixed;
  end;
end;

{ TReplicationClass }

constructor TReplicationClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPrimaryKeys          := TStringList.Create;
  FConstraints          := TStringList.Create;
  FFieldTypes           := TStringList.Create;
  FDateFields           := TStringList.Create;
  quExec                := TADOCommand.Create(AOwner);
  quExec.Connection     := Self.Connection;
  quExec.ExecuteOptions := quExec.ExecuteOptions + [eoExecuteNoRecords];
  quExec.CommandType    := cmdText;
  //quExec.Prepared       := True;
end;

destructor TReplicationClass.Destroy;
begin
  FPrimaryKeys.Free;
  FConstraints.Free;
  FFieldTypes.Free;
  FDateFields.Free;
  //quExec.Prepared := False;
  quExec.Free;
  inherited Destroy;
end;

procedure TReplicationClass.ReadPrimaryKeys;
var
  sSQL : String;
begin
  FPrimaryKeys.Clear;
  with TADOQuery.Create(nil) do
  try
    Connection := Self.Connection;

    case Self.ServerType of
      stMSSQL2000: sSQL :=
        MSSQL2000_SELECT_PK;
      stOracle9i:
        sSQL := '';
    end;

    Connection.Open;
    SQL.Clear;
    SQL.Add(Format(sSQL, [FTableName, Connection.DefaultDatabase]));
    Open;
    while not EOF do
    begin
      FPrimaryKeys.Add(FieldByName(PK_COLUMN_NAME).AsString);
      Next;
    end;
  finally
    Close;
    Free;
  end;
end;




procedure TReplicationClass.ReadFieldTypes;
var
  sSQL : String;
  sDDLExpression : String;
begin
  FFieldTypes.Clear;
  FDateFields.Clear; { Alex - 09/05/2011 }
  with TADOQuery.Create(nil) do
  try
    Connection := Self.Connection;

    case Self.ServerType of
      stMSSQL2000: sSQL :=
        MSSQL2000_SELECT_FIELD_TYPES;
      stOracle9i:
        sSQL := '';
    end;
    Connection.Open;
    SQL.Clear;
    SQL.Add(Format(sSQL, [FTableName, Connection.DefaultDatabase]));
    Open;
    while not EOF do
    begin
      sDDLExpression := FieldByName(DDL_EXPRESSION_CONST).AsString;

      { Alex 12/27/2011 - Don't process image type fields }
      If ( Pos( 'image', LowerCase( sDDLExpression ) ) > 0 ) Then Begin
        Next;
        Continue;
      End;

      FFieldTypes.Add(FieldByName(COLUMN_NAME_CONST).AsString + '=' + sDDLExpression);
      if (LowerCase(sDDLExpression) = 'datetime') or (LowerCase(sDDLExpression) = 'smalldatetime') then
        FDateFields.Add(FieldByName(COLUMN_NAME_CONST).AsString);
      Next;
    end;
  finally
    Close;
    Free;
  end;
end;


procedure TReplicationClass.RunSQL(sSQL : String);
begin
  quExec.CommandText := sSQL;
  quExec.Execute();
end;

procedure TReplicationClass.CreateReplicationColumn;
var
  sSQL: String;
begin
  sSQL := 'IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '+ QuotedStr(FTableName) + ' AND COLUMN_NAME = ' + QuotedStr(REPCOLUMN) + ') ' +
          'BEGIN ' + CRLF +
          'ALTER TABLE ' + FTableName + ' ADD ' + REPCOLUMN + ' DateTime NULL ' + CRLF +
          'CREATE INDEX PI_' + FTableName + '_' + REPCOLUMN + ' ON ' + FTableName + ' (' + REPCOLUMN + ')' + CRLF +
          'END';

  RunSQL(sSQL);

  RunSQL('UPDATE ' + FTableName + ' SET ' + REPCOLUMN + ' = GETDATE() WHERE ' + REPCOLUMN + ' IS NULL');
end;

function TReplicationClass.GenerateOnInsUpdTrigger(sTrigger: String): String;
var
  sIns,
  sDel,
  sSQL : String;
  I    : Integer;
begin
  sIns := '';
  sDel := '';

  for I := 0 to FPrimaryKeys.Count-1 do
  begin
    sIns := sIns + 'INSERTED.' + FPrimaryKeys[I] + ' = ' + FTableName + '.' + FPrimaryKeys[I] + CRLF;
    sDel := sDel + 'DELETED.'  + FPrimaryKeys[I] + ' = ' + FTableName + '.' + FPrimaryKeys[I] + CRLF;
    if (FPrimaryKeys.Count > 1) and (I <> FPrimaryKeys.Count-1) then
      begin
        sIns := sIns + 'AND' + CRLF;
        sDel := sDel + 'AND' + CRLF;
      end;
  end;

  if (sIns <> '') then
  begin
    sIns := ' WHERE ' + sIns;
    sDel := ' WHERE ' + sDel;
  end;

  sSQL := 'CREATE TRIGGER ' + sTrigger + ' ON ' + FTableName + ' FOR INSERT,UPDATE NOT FOR REPLICATION AS ' + CRLF +
          'SET NOCOUNT ON ' + CRLF +
          'IF ISNULL(APP_NAME(), '+ QuotedStr('') +') = ' + QuotedStr('MRREPLICATION') + CRLF +
          '   RETURN' + CRLF +
          'IF NOT UPDATE(' + REPCOLUMN + ')' + CRLF +
          'BEGIN' + CRLF +
          '       UPDATE ' + FTableName + ' SET ' + REPCOLUMN + ' = GETDATE() FROM INSERTED ' + sIns + CRLF +
          '       UPDATE ' + FTableName + ' SET ' + REPCOLUMN + ' = GETDATE() FROM DELETED  ' + sDel + CRLF +
          'END';

  RunSQL(sSQL);
end;


procedure TReplicationClass.CreateReplicationFeatures(CreateDeleteTrigger: Boolean = False);
var
  sTrigger: String;
begin
  CreateReplicationColumn;

  sTrigger := '[dbo].[tr_' + FTableName + '_Repl_InsUpt]';
  if not TriggerExists(sTrigger) then
    GenerateOnInsUpdTrigger(sTrigger);

  if CreateDeleteTrigger then
  begin
    sTrigger := '[dbo].[tr_' + FTableName + '_Repl_Del]';
    if not TriggerExists(sTrigger) then
      GenerateOnDeleteTrigger(sTrigger);
  end;
end;

(* Carlos MacLeod - Updated 3/23/2011 *)
function TReplicationClass.GenerateInsUpdProcedure : String;
var
  parameters : String;
  insertFields : String;
  insertValues : String;
  theSetFieldValues: String;
  whereFileds : String;
  strResult : WideString;
begin
  ReadFieldTypes;

  parameters := GenerateInsUpdProcedureParameters;
  insertFields := GenerateInsertFieldsValues(false);
  insertValues := GenerateInsertFieldsValues(true);
  theSetFieldValues := GenerateInsertUpdateSetFieldsValues;
  whereFileds := GenerateInsertUpdateWhereFieldsValues;
  strResult := MSSQL2000_CMD_CREATE_RPL_INS_UPD_STORED_PROCEDURE;

  result := format(strResult, [FTableName, FTableName, FTableName, parameters, FTableName, insertFields, insertValues,
                               FTableName, TheSetFieldValues, whereFileds]);

  { Alex - 11/10/2011 }
  If ( Trim( whereFileds ) = '' )   Then Begin

      Raise Exception.Create( ' Table ' + FTableName + ' has no Primary Key' );

  End;

end;


procedure TReplicationClass.CreateInsUpdProcedure;
const
  CRAZY_STRING = CRLF + 'GO' + CRLF;
var
  sSQL, sSQL2 : String;
  iCrazyPos : Integer;
begin
  sSQL := GenerateInsUpdProcedure();
  iCrazyPos := pos(CRAZY_STRING, sSQL);
  sSQL2 := Copy(sSQL, 1, iCrazyPos);
  RunSQL(sSQL2);
  delete(sSQL, 1, iCrazyPos + length(CRAZY_STRING) - 1);
  try
     RunSQL(sSQL);
  except
    on Exception do
      raise Exception.Create(FTableName);
  end;
end;

(* Carlos MacLeod - Updated 2/25/2011 *)
function TReplicationClass.GenerateInsUpdProcedureParameters : String;
var
  I : Integer;
  stlParameters : TStringList;
begin
  stlParameters := TStringList.Create;
  try
    for I := 0 to FFieldTypes.Count - 1 do
      stlParameters.Add( '@' + FFieldTypes.Names[I] + ' ' + FFieldTypes.Values[FFieldTypes.Names[I]] );
      result := StringListToFormatedText(stlParameters, ',');
  finally
    stlParameters.Free;
  end;
end;

function TReplicationClass.GenerateInsertFieldsValues(IsValue: boolean) : String;
var
  I : Integer;
  stlFields : TStringList;
begin
  stlFields := TStringList.Create;
  try
    for I := 0 to FFieldTypes.Count - 1 do
      stlFields.Add(FFieldTypes.Names[I]);
    if IsValue then
      Result := StringListToFormatedText(stlFields, ',', '@')
    else
      Result := StringListToFormatedText(stlFields, ',');
  finally
    stlFields.Free;
  end;
end;

(* Carlos MacLeod - Updated 2/25/2011 *)
function TReplicationClass.GenerateInsertUpdateSetFieldsValues: String;
var
  I : Integer;
  stlSetFields : TStringList;
begin
  stlSetFields := TStringList.Create;
  try
    for I := 0 to FFieldTypes.Count - 1 do
    begin
      if FPrimaryKeys.IndexOf(FFieldTypes.Names[I]) < 0 then
        stlSetFields.Add(FFieldTypes.Names[I] + ' = @' + FFieldTypes.Names[I] );
    end;
    Result := StringListToFormatedText(stlSetFields, ',' + CRLF);
  finally
    stlSetFields.Free;
  end;
end;

(* Carlos MacLeod - Updated 3/23/2011 *)
function TReplicationClass.GenerateInsertUpdateWhereFieldsValues: String;
var
  I : Integer;
  stlUpdateWhereFields : TStringList;
begin
  stlUpdateWhereFields := TStringList.Create;
  try
    for I := 0 to FPrimaryKeys.Count - 1 do
    begin
      stlUpdateWhereFields.Add(FPrimaryKeys[I] + ' = @' + FPrimaryKeys[I] );
    end;
    Result := StringListToFormatedText(stlUpdateWhereFields, ' AND' + CRLF);
  finally
    stlUpdateWhereFields.Free;
  end;
end;



function TReplicationClass.TriggerExists(TriggerName: String): Boolean;
var
  sSQL: string;
begin
  sSQL     := 'select * from dbo.sysobjects where id = object_id(N' + QuotedStr(TriggerName) + ') and OBJECTPROPERTY(id, N' + QuotedStr('IsTrigger') + ') = 1';
  with TADOQuery.Create(nil) do
  try
    Connection := Self.Connection;
    SQL.Clear;
    SQL.Add(sSQL);
    Open;
    Result := not IsEmpty;
  finally
    Close;
    Free;
  end;
end;


procedure TReplicationClass.GenerateOnDeleteTrigger(sTrigger: String);
var
  I : Integer;
  sInsert: String;
  sCampoDelete: String;
  sSQL: String;
  lstPK : TStringList;
  QueryFields: TADOQuery;
begin
  try
    lstPK := TStringList.Create;
    try
      if FPrimaryKeys.Count <> 0 then
        lstPK.AddStrings(FPrimaryKeys)
      else
        begin
          QueryFields := TADOQuery.Create(nil);
          try
            QueryFields.Connection := FConnection;
            QueryFields.SQL.Clear;
            QueryFields.SQL.Add('select * from ' + FTableName + ' where 1 = 0');
            QueryFields.Open;
            for I := 0 to QueryFields.FieldCount - 1 do
              lstPK.Add(QueryFields.Fields[I].FieldName);
          finally
            QueryFields.Close;
            QueryFields.Free;
          end;
        end;

      I := lstPK.IndexOf(REPCOLUMN);
      if I <> -1 then
        lstPK.Delete(I);

      sInsert := 'INSERT INTO ' + REP_DELETION_TABLE + ' (' + REP_DELETION_TABLE_NAME + ', ' + REP_DELETION_TABLE_SCRIPT + ', ' + REPCOLUMN + ') '  + CRLF +
                 'SELECT ' + QuotedStr(FTableName) + ', ';

      sCampoDelete := QuotedStr('DELETE FROM ' + FTableName + ' WHERE ') + ' + ';
      for I := 0 to lstPK.Count - 1 do
      begin
        sCampoDelete := sCampoDelete + QuotedStr('Convert(varchar, ' + lstPK[I] + ') ' + ' = ') + ' + QuoteName(Convert(varchar, DELETED.' + lstPK[I] + '), CHAR(39))';
        if I < lstPK.Count - 1 then
          sCampoDelete := sCampoDelete + ' + ' + QuotedStr(' AND ') + ' + ';
      end;

      sCampoDelete := sCampoDelete + ', GetDate() FROM DELETED';

      sSQL  :=    'CREATE TRIGGER ' + sTrigger + ' ON ' + FTableName + ' FOR DELETE NOT FOR REPLICATION AS ' + CRLF +
                  'SET NOCOUNT ON ' + CRLF +
                  'IF ISNULL(APP_NAME(), '+ QuotedStr('') +') = ' + QuotedStr('MRREPLICATION') + CRLF +
                  '   RETURN' + CRLF +
                  'IF NOT UPDATE(' + REPCOLUMN + ')' + CRLF +
                  'BEGIN' + CRLF +
                  '       ' + sInsert + sCampoDelete + CRLF +
                  'END';

      RunSQL(sSQL);
    finally
      lstPK.Free;
    end;
  except
  end;
end;



procedure TReplicationClass.FillRepDate;
begin
  RunSQL('UPDATE ' + FTableName + ' SET ' + REPCOLUMN + ' = GETDATE() WHERE ' + REPCOLUMN + ' IS NULL');
end;

procedure TReplicationClass.SetConnection(const Value: TADOConnection);
begin
  FConnection       := Value;
  quExec.Connection := FConnection;
end;

procedure TReplicationClass.SetSelectWhereClause(const Value: String);
begin
  if (FSelectWhereClause <> Value) then
    FSelectWhereClause := Value;
end;

{ TTableToXML }

constructor TTableToXML.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FDataLoaded                := False;
  FSaveEmptyTable            := False;
  Query                      := TAdoQuery.Create(Self);

  Provider                   := TDataSetProvider.Create(Self);
  Provider.Name              := 'pvd' + Self.Name;
  ClientDataSet              := TClientDataSet.Create(Self);
  Query.LockType             := ltReadOnly;
  Provider.DataSet           := Query;
  ClientDataSet.ProviderName := Provider.Name;
end;


function TTableToXML.GenerateInsUpdProcedure: String;
begin
  result := inherited GenerateInsUpdProcedure;
end;

destructor TTableToXML.Destroy;
begin
  UnloadData;
  ClientDataSet.Free;
  Provider.Free;
  Query.Free;
  inherited;
end;

function TTableToXML.LoadDataFromTable(TableName: String): String;
var
  sSelectedFields : String;
  stlSelectedFields : TStringList;
  i : Integer;
begin
  Result := '';
  sSelectedFields := '';

  //Listar os campos para montar o XML
  try

    stlSelectedFields := TStringList.Create;
    try
      ClientDataSet.Close;
      Query.Connection := Connection;
      Query.SQL.Clear;
      Query.SQL.Add(Format(ANSI_FMT_TABLE_SELECT, [TableName]));
      ClientDataSet.Open;

      for I :=0 to (ClientDataSet.FieldCount-1) do
        //Selecionar os campos marcado com readlony = false
        if not( ClientDataSet.Fields[I].ReadOnly or ( ClientDataSet.Fields[I].DataType = ftBlob ) ) then
           stlSelectedFields.Add(ClientDataSet.Fields[I].FieldName);

      sSelectedFields := StringListToFormatedText(stlSelectedFields, ',');
    finally
      Query.SQL.Clear;
      ClientDataSet.Close;
      stlSelectedFields.Clear;
      FreeAndNil(stlSelectedFields);
    end;

    ClientDataSet.Close;
    //Query.EnableBCD := False;
    Query.Connection := Connection;
    Query.SQL.Clear;
    Query.SQL.Add(Format(ANSI_FMT_TABLE_SELECT_FILEDS, [sSelectedFields, TableName]));

    if (SelectWhereClause <> '') or (FReplicateSince >= 0) then
      Query.SQL.Add('WHERE');

    if SelectWhereClause <> '' then
      Query.SQL.Add('(' + SelectWhereClause + ')');

    if (FReplicateSince >= 0) then
    begin
      if SelectWhereClause <> '' then
        Query.SQL.Add('AND');
      case ServerType of
        stMSSQL2000:
        begin
          Query.SQL.Add(Format(MSSQL2000_WHERE_REP_SINCE, [FReplicateSince]));
        end;

        stOracle9i:
        begin
        end;
      end;
    end;


    ClientDataSet.Open;
  except
    on E: Exception do
      begin
        Result := Format('TableName: %S -->', [FTableName]) + E.Message;
        try
          ClientDataSet.Close;
        except

        end;
      end;
  end;
  if Result = '' Then
    FDataLoaded := True;
end;

function TTableToXML.SaveToXML(FileName: String): String;
begin
  Result := '';
  try
    if (not FSaveEmptyTable) and (ClientDataSet.IsEmpty) then
      Exit;

    if ExtractFileExt(FileName) <> '.xml' Then
      FileName := FileName + '.xml';

    ClientDataSet.SaveToFile(FileName, dfXMLUTF8);
  except
    on E: Exception do
       Result := E.Message;
  end;
end;

procedure TTableToXML.SetConnection(const Value: TADOConnection);
begin
  inherited SetConnection(Value);
  FConnection := Value;
end;

procedure TTableToXML.SetTableName(const Value: String);
var
  sError: String;
begin
  sError := '';
  if (FTableName <> Value) then
  begin
    FTableName := Value;
    if FTableName = '' then
      Exit;
    if FTableName <> REP_DELETION_TABLE then
    begin
      ReadPrimaryKeys;
      CreateReplicationFeatures(True);
      CreateInsUpdProcedure;
    end;
    sError := LoadDataFromTable(FTableName);
    if sError <> '' then
      raise Exception.Create(sError);
  end;
end;

procedure TTableToXML.UnloadData;
begin
  ClientDataSet.Close;
  FTableName := '';
  FDataLoaded := False;
end;


{ TXMLToTable }

constructor TXMLToTable.Create(AOwner: TComponent);
begin
  inherited;
  FDataLoaded    := False;
  FSQLBatchCount := DEFAULT_SQL_BATCH_COUNT;

  // Criação de objetos
  FPrimaryKeys             := TStringList.Create;
  ClientDataSet            := TClientDataSet.Create(AOwner);
  Query                    := TADOQuery.Create(AOwner);

  Query.LockType := ltReadOnly;
end;

destructor TXMLToTable.Destroy;
begin
  UnloadData;
  Query.Free;
  ClientDataSet.Free;
  FPrimaryKeys.Free;
  inherited;
end;

function TXMLToTable.GenerateUpdateClause(TableName: String): String;
Var
  I : Integer;
  strSQL : String;
  stlNotPrimaryKeys: TStringList;
begin
  strSQL := Format(ANSI_FMT_SQL_UPDATE, [TableName]);
  stlNotPrimaryKeys := TStringList.Create;
  try
    for I := 0 to ClientDataSet.Fields.Count - 1 do
      if (PrimaryKeys.IndexOf(ClientDataSet.Fields[I].FieldName) < 0) then
        stlNotPrimaryKeys.Add(ClientDataSet.Fields[I].FieldName);

  for I := 0 to stlNotPrimaryKeys.Count - 1 do
  begin
      strSQL := strSQL + Format('%S = %S', [stlNotPrimaryKeys[I], GetFieldValue(ClientDataSet.FieldByName(stlNotPrimaryKeys[I]))]);
      if I <> (stlNotPrimaryKeys.Count - 1) then
        strSQL := strSQL + ', ';
  end;

  finally
    stlNotPrimaryKeys.Free;
  end;


  Result := strSQL;


  (*
  strSQL := Format(ANSI_FMT_SQL_UPDATE, [TableName]);
  for I := 0 to ClientDataSet.Fields.Count - 1 do
  If (PrimaryKeys.IndexOf(ClientDataSet.Fields[I].FieldName) < 0) then
    begin
      strSQL := strSQL + Format('%S = %S', [ClientDataSet.Fields[I].FieldName, GetFieldValue(ClientDataSet.Fields[I])]);
      if I <> (ClientDataSet.Fields.Count - 1) then
        strSQL := strSQL + ', ';
    end;
  Result := strSQL;
  *)
end;
function TXMLToTable.GenerateSelectClause(TableName: String): String;
begin
     Result := Format(ANSI_FMT_SQL_SELECT, [REPCOLUMN, TableName]);
end;

function TXMLToTable.GenerateWhereClause(TableName: String): String;
Var
  I : Integer;
  strSQL : String;
  stlFields : TStringList;
begin

  stlFields := TStringList.Create;
  try
    if PrimaryKeys.Count = 0 then
      begin
      for I :=0 to ClientDataSet.FieldCount - 1 do
        if not((ClientDataSet.Fields[I].DataType in [ftBlob, ftMemo]) or
                (ClientDataSet.Fields[I].FieldName = REPCOLUMN)) then
          stlFields.Add(ClientDataSet.Fields[I].FieldName)
      end
    else
      stlFields.Assign(PrimaryKeys);

    strSQL := 'WHERE ';
    for I := 0 to stlFields.Count - 1 do
    begin
      strSQL := strSQL + Format('%S = %S', [stlFields[I], GetFieldValue(ClientDataSet.FieldByName(stlFields[I]))]);
      if I <> (stlFields.Count - 1) then
        strSQL := strSQL + ' AND ';
    end;

    strSQL := strSQL + ' AND ' + REPCOLUMN + ' < ' + GetFieldValue(ClientDataSet.FieldByName(REPCOLUMN));

    Result := strSQL;

  finally
    FreeAndNil(stlFields);
  end;
end;

function TXMLToTable.GenerateSQLInsert(TableName: String): String;
Var
  sFields, sValues : String;
  I : Integer;
begin
  sFields := '';
  sValues := '';

  for I := 0 to ClientDataSet.Fields.Count-1 Do
  begin
    sFields := sFields + ClientDataSet.Fields[I].FieldName;
    sValues := sValues + GetFieldValue(ClientDataSet.Fields[I]);

    if I <> (ClientDataSet.Fields.Count-1) then
    begin
      sFields := sFields + ',';
      sValues := sValues + ',';
    end;
  end;
  Result := Format(ANSI_FMT_SQL_INSERT, [TableName, sFields, sValues]);
end;

function TXMLToTable.GenerateStoredProcedureCall(): String;
var
  I: Integer;
  stlParameters: TStringList;
begin
  stlParameters := TStringList.Create;
  try
    for I := 0 to FFieldTypes.Count - 1 do
    begin
      if FDateFields.IndexOf(FFieldTypes.Names[I]) > -1 then
        begin
          // We will not add the field value to the SP call
          // will use the parameter instead
          stlParameters.Add('@' + FFieldTypes.Names[I]);
        end
      else
        begin
          stlParameters.Add( GetFieldValue( ClientDataSet.FieldByName( FFieldTypes.Names[I] ) ) );
        end;
    end;
    Result := StringListToFormatedText(stlParameters, ' ,');
  finally
    stlParameters.Free;
  end;
end;

function TXMLToTable.GenerateVariableDeclare(): String;
var
  I : Integer;
  stlVariable : TStringList;
begin
  stlVariable := TStringList.Create;
  try
    for I := 0 to FDateFields.Count - 1 do
      stlVariable.Add(format('DECLARE @%S %S', [ FDateFields[I], FFieldTypes.Values[FDateFields[I]] ]));
    Result := StringListToFormatedText(stlVariable, CRLF);
  finally
    stlVariable.Free;
  end;
end;

function TXMLToTable.GenerateVariableSET(): String;
var
  I : Integer;
  stlVariable : TStringList;
begin
  stlVariable := TStringList.Create;
  try
    for I := 0 to FDateFields.Count - 1 do
      stlVariable.Add(format('SET @%S = %S', [FDateFields[I], GetFieldValue(ClientDataSet.FieldByName(FDateFields[I]))]));
    Result := StringListToFormatedText(stlVariable, CRLF);

  finally
    stlVariable.Free;
  end;
end;

function TXMLToTable.GetFieldValue(Field: TField): String;
Var
  sNomeCampo,
  OldShortDateFormat : String;
begin
  Result := '';
  sNomeCampo := Field.FieldName;
  if Field.IsNull then
    Result := 'NULL'
  else
    case Field.DataType of
      ftInteger:
        Result := Field.AsString;
      ftDate :
        begin
          OldShortDateFormat := ShortDateFormat;
          try
            ShortDateFormat := 'DD/MM/YY';
            Result := Format('Convert(DateTime, %S, 3)', [QuotedStr(FormatDateTime('dd/mm/yy', Field.AsDateTime))]);
          finally
            ShortDateFormat := OldShortDateFormat;
          end;
        end;
      ftDateTime :
        begin
          OldShortDateFormat := ShortDateFormat;
          try
            ShortDateFormat := 'yyyy-mm-dd hh:nn:ss';
            Result := Format('Convert(DateTime, %S, 20)', [QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', Field.AsDateTime))]);
          finally
            ShortDateFormat := OldShortDateFormat;
          end;
        end;
      ftBCD, ftCurrency, ftFloat:
      begin
        Result := MyFormatCur(Field.AsFloat, '.');
      end;
      ftBoolean:
        Result := IntToStr(Byte(Field.AsBoolean));
      ftString:
        Result := ConvertQuoted(Field.AsString)

      else
        Result := QuotedStr(Field.AsString);
    end;

end;

function TXMLToTable.ConvertQuoted(S: String): String;
begin
  case ServerType of
      stMSSQL2000:
        Result := MSSQL2000ConvertQuoted(S);
      stOracle9i:
        Result := QuotedStr(S);
  end;
end;

function TXMLToTable.MSSQL2000ConvertQuoted(S: String): String;
var
  I : Integer;
begin
  Result := QuotedStr(S);

  for I := 1 to Length(SPECIAL_CHARS) do
    Result := StringReplace(Result, CHR(SPECIAL_CHARS[I]), QuotedStr(Format(' + CHAR(%D) + ', [SPECIAL_CHARS[I]])), [rfReplaceAll]);

  { Alex 12/26/2011
  Result := StringReplace(Result, #13#10, QuotedStr(' + CHAR(13) + CHAR(10) + '), [rfReplaceAll]);
  Result := StringReplace(Result, '"', QuotedStr(' + CHAR(34)f + '), [rfReplaceAll]);
  }
end;


function TXMLToTable.LoadDataFromXML(FileName: String): String;
begin
  Result := '';
  try
    UnloadData;
    ClientDataSet.LoadFromFile(FileName);

    if SelectWhereClause <> '' then
    begin
      ClientDataSet.Filter   := SelectWhereClause;
      ClientDataSet.Filtered := True;
    end
    else
    begin
      ClientDataSet.Filter   := '';
      ClientDataSet.Filtered := False;
    end;

    FDataLoaded := True;
  except
    on E: Exception do
      Result := E.Message;
  end;
end;

function TXMLToTable.SaveDataToTable(TableName: String): String;
Var
  sSQLWhere,
  sSQLUpdate,
  sSQLInsert : String;

  stlExecuteBuffer: TStringList;

  sBatchBegin,
  sBatchBody,
  sBatchEnd : String;

  iBatchRows : Cardinal;
  IsInsUpd: Boolean;
begin
  IsInsUpd := TableName <> REP_DELETION_TABLE;

  if FDataLoaded Then
    begin
      Result := '';

      if IsInsUpd then
      case ServerType of
        stMSSQL2000:
        begin
          sBatchBegin := MSSQL2000_CMD_REPLICATE_BATCH_BEGIN;
          (* Old Version - Pure SQL Statment *)
          // sBatchBody  := MSSQL2000_CMD_REPLICATE_BATCH_BODY;

          (* New Version - Stored Procedure Call *)
          sBatchBody  := MSSQL2000_CMD_REPLICATE_BATCH_BODY_SP;

          sBatchEnd   := MSSQL2000_CMD_REPLICATE_BATCH_END;
        end;

        stOracle9i:
        begin
          sBatchBegin := '';
          sBatchBody  := '';
          sBatchEnd   := '';
        end;
      end;

      try
        {if IsInsUpd then
          DisableTriggers(TableName);}
        try
          //FillRepDate;

          stlExecuteBuffer := TStringList.Create;
          try
            iBatchRows := 0;

            if IsInsUpd then
            begin
              stlExecuteBuffer.Add(sBatchBegin);

              { Alex - Define variables declaration }
              stlExecuteBuffer.Add(GenerateVariableDeclare());
            end;

            while not ClientDataSet.Eof do
            begin
              Inc(iBatchRows);

              { Alex - Aqui gera os valores das variaveis das colunas da tabela }
              stlExecuteBuffer.Add(GenerateVariableSET());

              if IsInsUpd then
                begin
                  // Here the magic happens
                  if JustInsert then
                    sSQLUpdate := GenerateSelectClause(TableName)
                  else
                  (* Old Version - Pure SQL Statment *)
                    //sSQLUpdate := GenerateUpdateClause(TableName);
                  (* New Version - Stored Procedure Call *)
                    sSQLUpdate := GenerateStoredProcedureCall;

                  (* Old Version - Pure SQL Statment *)
                  //sSQLWhere  := GenerateWhereClause(TableName);
                  //sSQLInsert := GenerateSQLInsert(TableName);

                  //stlExecuteBuffer.Add(Format(sBatchBody, [sSQLUpdate + CRLF + sSQLWhere, sSQLInsert]));

                  (* New Version - Stored Procedure Call *)

                  stlExecuteBuffer.Add(Format(sBatchBody, [FTableName, sSQLUpdate]));
                end
              else
                // No stored procedure needed, since the script is provided "as it is"
                stlExecuteBuffer.Add(ClientDataSet.FieldByName(REP_DELETION_TABLE_SCRIPT).AsString);


              if iBatchRows >= FSQLBatchCount then
              begin
                if IsInsUpd then
                  stlExecuteBuffer.Add(sBatchEnd);
                try
                  RunSQL(StringListToFormatedText(stlExecuteBuffer, CRLF));
                except
                  on Err: Exception do
                    begin
                      //stlExecuteBuffer.Text := StringListToFormatedText(stlExecuteBuffer, CRLF);
                      //stlExecuteBuffer.savetofile('c:\teste.txt');

                      stlExecuteBuffer.Insert(0, Err.Message);
                      stlExecuteBuffer.SaveToFile('ERROR_' + TableName + FormatDateTime('YYYYMMDD-HHNNSS', NOW) + '.SQL');
                      raise;
                    end;
                end;
                
                stlExecuteBuffer.Clear;

                { Alex 12/10/2011 - Include - ...GenerateVariableDeclare()); }
                if IsInsUpd then begin
                  stlExecuteBuffer.Add(sBatchBegin);
                  stlExecuteBuffer.Add(GenerateVariableDeclare());
                end;

                iBatchRows := 0;
              end;

              ClientDataSet.Next;

              if (ClientDataSet.Eof) and (iBatchRows <> 0)then
              begin
                if IsInsUpd then
                  stlExecuteBuffer.Add(sBatchEnd);
                try
                  RunSQL(StringListToFormatedText(stlExecuteBuffer, CRLF));
                except
                  on Err: Exception do
                    begin
                      stlExecuteBuffer.Insert(0, Err.Message);
                      stlExecuteBuffer.SaveToFile('ERROR_' + TableName + FormatDateTime('YYYYMMDD-HHNNSS', NOW) + '.SQL');
                      raise;
                    end;
                end;
              end;

            end;
          finally
            stlExecuteBuffer.Free;
          end;
        finally
          {if IsInsUpd then
            EnableTriggers(TableName);}
        end;

      except
        on E: Exception do
          Result := E.Message;
      end;
    end
  else
    begin
      raise Exception.Create(ERR_NO_DATA_LOADED);
    end;
end;

procedure TXMLToTable.SetTableName(const Value: String);
begin
  inherited;
  if (FTableName <> Value) then
  begin
    FTableName := Value;
    if FTableName = '' then
      Exit;
    if FTableName <> REP_DELETION_TABLE then
    begin
      ReadPrimaryKeys;
      ReadFieldTypes;
      CreateReplicationFeatures();
      { Alex 12/07/2011 }
      CreateInsUpdProcedure;
    end;
  end;
end;


// NÃO REMOVER !!!

(*
procedure TXMLToTable.DisableTriggers(sTable: String);
var
  sSrvNativeSQL : String;
begin
  case ServerType of
    stMSSQL2000 :
      sSrvNativeSQL := MSSQL2000_CMD_DISABLE_ALL_TRIGGERS;

    stOracle9i:
      sSrvNativeSQL := '';
  end;
  RunSQL(Format(sSrvNativeSQL, [sTable]));
end;
*)

// NÃO REMOVER !!!

(*
procedure TXMLToTable.EnableTriggers(sTable: String);
var
  sSrvNativeSQL : String;
begin
  case ServerType of
    stMSSQL2000 :
      sSrvNativeSQL := MSSQL2000_CMD_ENABLE_ALL_TRIGGERS;

    stOracle9i:
      sSrvNativeSQL := '';
  end;
  RunSQL(Format(sSrvNativeSQL, [sTable]));
end;
*)

procedure TXMLToTable.UnloadData;
begin
  ClientDataSet.Close;
  ClientDataSet.Filtered := False;
  FPrimaryKeys.Clear;
end;

procedure ModifyAllConstraints(ServerType: TServerType; AConnection : TADOConnection; Enable : Boolean);
var
  sSQLGetConstraints, sSQLModify: String;
  quSelect, quRun : TADOQuery;
begin
  quSelect := TADOQuery.Create(nil);
  with quSelect do
  try
    Connection := AConnection;

    case ServerType of
      stMSSQL2000:
      begin
        sSQLGetConstraints := MSSQL2000_SELECT_FK;
        if Enable then
          sSQLModify       := MSSQL2000_CMD_ENABLE_CONSTRAINT
        else
          sSQLModify       := MSSQL2000_CMD_DISABLE_CONSTRAINT;
      end;

      stOracle9i:
      begin
        sSQLGetConstraints := '';
        sSQLModify         := '';
      end;
    end;

    SQL.Clear;
    SQL.Add(sSQLGetConstraints);
    Open;
    quRun := TADOQuery.Create(Nil);
    try
      quRun.Connection := AConnection;
      while not EOF do
      begin
        quRun.SQL.Clear;
        quRun.SQL.Add(Format(sSQLModify, [FieldByName('TabelaDerivada').AsString, FieldByName('ConstraintName').AsString]));
        quRun.ExecSQL;
        Next;
      end;
    finally
      quRun.Free;
    end;
  finally
    Close;
    Free;
  end;
end;


procedure CreateReplicationInsUpdProcedureExists(ATableName: String; AConnection : TADOConnection);
var
  sSQL: String;
  quRun: TADOQuery;
begin
(*
  sSQL := 'if not exists (select * from dbo.sysobjects where xtype = '#39'P'#39' and name = '#39REPLICATION_STORED_PROCEDURE_NAME_FORMAT#39')' + CRLF +
          'CREATE TABLE [dbo].['+REP_DELETION_TABLE+'] ('  + CRLF +
          REP_DELETION_TABLE_NAME +' varchar(40)  NOT NULL ,' + CRLF +
          REP_DELETION_TABLE_SCRIPT + ' varchar(255)  NOT NULL,' + CRLF +
          REPCOLUMN + ' datetime NOT NULL' + CRLF +
          ')';

  quRun := TADOQuery.Create(Nil);
  try
    quRun.Connection := AConnection;
    quRun.SQL.Clear;
    quRun.SQL.Add(sSQL);
    quRun.ExecSQL;
  finally
    quRun.Free;
  end;
  *)
end;

procedure CreateDeletionTable(ServerType: TServerType; AConnection : TADOConnection);
var
  sSQL: String;
  quRun: TADOQuery;
begin
  sSQL := 'if not exists (select * from dbo.sysobjects where id = object_id(N' +
          QuotedStr(Format('[dbo].[%S]', [REP_DELETION_TABLE])) +') ' + CRLF +
          'and OBJECTPROPERTY(id, N' + QuotedStr('IsUserTable') + ') = 1)' + CRLF +
          'CREATE TABLE [dbo].['+REP_DELETION_TABLE+'] ('  + CRLF +
          REP_DELETION_TABLE_NAME +' varchar(40)  NOT NULL ,' + CRLF +
          REP_DELETION_TABLE_SCRIPT + ' varchar(255)  NOT NULL,' + CRLF +
          REPCOLUMN + ' datetime NOT NULL' + CRLF +
          ')';

  quRun := TADOQuery.Create(Nil);
  try
    quRun.Connection := AConnection;
    quRun.SQL.Clear;
    quRun.SQL.Add(sSQL);
    quRun.ExecSQL;
  finally
    quRun.Free;
  end;
end;


procedure TXMLToTable.SetConnection(const Value: TADOConnection);
begin
  inherited SetConnection(Value);
  FConnection := Value;
end;

procedure TXMLToTable.SetSelectWhereClause(const Value: String);
begin
  inherited;
  (*
    if SelectWhereClause = '' then
      begin
        ClientDataSet.Filter   := '';
        ClientDataSet.Filtered := False;
      end
    else
      begin
        ClientDataSet.Filter   := SelectWhereClause;
        ClientDataSet.Filtered := True;
      end;
  *)
end;

end.
