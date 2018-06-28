unit uSqlFunctions;

interface

uses Sysutils, uSystemConst, xBase, uSystemTypes, uStringFunctions;

Const
  ORDER_AUTO = -1;
  ORDER_ASC  = 0;
  ORDER_DESC = 1;

type

  TSQLStatement = array[0..10] of String;
  TSQLAgregate  = array[0..4] of String;

  // amfsouza May 3, 2013
  TSQLOptimizer = array[0..6] of String;

const
  aSqlStatement : TSQLStatement = ('SELECT',
                                   'FROM',
                                   'INNER JOIN',
                                   'LEFT OUTER JOIN',
                                   'RIGHT OUTER JOIN',
                                   'FULL OUTER JOIN',
                                   'WHERE' ,
                                   'GROUP BY',
                                   'HAVING',
                                   'ORDER BY',
                                   'COMPUTE');

  aSqlOptimizer : TSQLOptimizer = ('INDEX',
                                   'NOLOCK',
                                   'HOLDLOCK',
                                   'UPDLOCK',
                                   'TABLOCK',
                                   'PAGLOCK',
                                   'TABLOCKX');

  aSqlAgregate : TSQLAgregate = ('AVG(',
                                 'COUNT(',
                                 'MAX(',
                                 'MIN(',
                                 'SUM(');

  ST_SELECT    = 0;
  ST_FROM      = 1;
  ST_INNERJOIN = 2;
  ST_LEFTJOIN  = 3;
  ST_RIGHTJOIN = 4;
  ST_FULLJOIN  = 5;
  ST_WHERE     = 6;
  ST_GROUP     = 7;
  ST_HAVING    = 8;
  ST_ORDER     = 9;
  ST_COMPUTE   = 10;

function ChangeWhereClause(OldSQL, NewWhere : String; IsChange : Boolean) : String;
function ChangeHavingClause(OldSQL, NewHaving : String; IsChange : Boolean) : String;
function BuildMaxSQL(MaxField, OldSQl : String) : String;
function GetSQLFirstTableName(SQlText : String) : String;
function GetSQLFirstTableAlias(SQlText : String) : String;
function ChangeSQLOrder(SQlText, AFieldName : String; TypeOrder : Integer) : String;

function ChangeSQLState(OldSQL : String; DesativadoState : TDesativadoState;
                        HiddenState : THiddenState) : String;

function UnMountSQL(SQlText : String) : TSqlStatement;
function UnMountPureSQL(SQlText : String) : TSqlStatement;
function MountSQL(SqlStatement : TSqlStatement) : String;

function GetFieldAlias(AFieldName, SQLText : String) : String;
function GetFieldOrigin(SQLText, FieldName : String) : String;

function IsAgregate(SQLText : String) : Boolean;
function MontaComboWhereClause(sTableAlias, sTableField, sSource : string):String;


implementation

function ChangeWhereClause(OldSQL, NewWhere : String; IsChange : Boolean) : String;
var
   MySqlStatement : TSQlStatement;
begin
   if NewWhere = '' then
     begin
      Result := OldSQL;
      Exit;
     end;

   MySqlStatement := UnMountSQL(OldSQL);

   if IsChange or (MySqlStatement[ST_WHERE] = '') then
      MySqlStatement[ST_WHERE] := NewWhere
   else
      MySqlStatement[ST_WHERE] := MySqlStatement[ST_WHERE] + ' AND ' + NewWhere;

   Result := MountSQL(MySqlStatement);
end;

function ChangeHavingClause(OldSQL, NewHaving : String; IsChange : Boolean) : String;
var
   MySqlStatement : TSQlStatement;
begin
   if NewHaving = '' then
     begin
      Result := OldSQL;
      Exit;
     end;

   MySqlStatement := UnMountSQL(OldSQL);

   if IsChange or (MySqlStatement[ST_HAVING] = '') then
      MySqlStatement[ST_HAVING] := NewHaving
   else
      MySqlStatement[ST_HAVING] := MySqlStatement[ST_HAVING] + ' AND ' + NewHaving;

   Result := MountSQL(MySqlStatement);
end;

function BuildMaxSQL(MaxField, OldSQl : String) : String;
var
   MySqlStatement : TSQlStatement;
begin
   MySqlStatement := UnMountSQL(OldSQL);

   MySqlStatement[ST_SELECT] := 'MAX( ' + MaxField + ' )';
   MySqlStatement[ST_ORDER]  := '';

   Result := MountSQL(MySqlStatement);
end;

function GetSQLFirstTableName(SQlText : String) : String;
var
  MySqlStatement       : TSQLStatement;
  AuxTable, AuxSQl     : String;
  i                    : integer;
begin
  MySqlStatement := UnMountPureSQL(SQlText);

  // Descubro quem e a primeira tabela
  AuxSql := Trim(MySQlStatement[ST_FROM]);
  AuxTable := '';

  for i := 1 to Length(AuxSQl) do
    begin
      if not ( AuxSQL[i] in ['(', ')', ',', ' '] ) then
         AuxTable := AuxTable + AuxSql[i];

      if ( AuxSql[i] in [',', ' '] ) or ( i = Length(AuxSQl) ) then
         Break;
    end;

  Result := Trim(AuxTable);
end;

function GetSQLFirstTableAlias(SQlText : String) : String;
var
  MySqlStatement       : TSQLStatement;
  AuxTable, AuxSQl     : String;
  i, IniPos            : integer;
begin
  MySqlStatement := UnMountPureSQL(SQlText);
 
  // Descubro quem e a primeira tabela
  AuxSql := Trim(MySQlStatement[ST_FROM]);
  AuxTable := '';

  IniPos := Pos(' ', AuxSQl);
  if IniPos = 0 then
    begin
      IniPos := Pos(' AS ', AuxSQl);
      if IniPos > 0 then Inc(i);
    end;

  Inc(IniPos);

  for i := IniPos to Length(AuxSQl) do
    begin
      if not ( AuxSQL[i] in ['(', ')', ',', ' '] ) then
         AuxTable := AuxTable + AuxSql[i];

      if ( AuxSql[i] in [',', ' '] ) or ( i = Length(AuxSQl) ) then
         Break;
    end;

  Result := Trim(AuxTable);
end;

function ChangeSQLOrder(SQlText, AFieldName : String; TypeOrder : Integer) : String;
var
   PosOrder : integer;
   strTypeOrder : String;
begin
   // Descobre o Order By do Query
   PosOrder := Pos('ORDER BY', UpperCase(SqlText));

   if TypeOrder = ORDER_ASC then
      strTypeOrder := ' ASC'
   else
      strTypeOrder := ' DESC';

   if PosOrder > 0 then
      SQlText := LeftStr(SQlText, PosOrder-1);

   // amfsouza 11.30.2011
   Result := Trim(SQlText + 'ORDER BY ' + GetFieldAlias(AFieldName, SQLText) + lowerCase(AFieldName) + strTypeOrder);

   Result:= Result + '';
end;

function ChangeSQLState(OldSQL : String; DesativadoState : TDesativadoState;
                        HiddenState : THiddenState) : String;
var
   FirstTable, WhereClause1, WhereClause2 : String;
begin

   FirstTable := GetSQLFirstTableAlias(OldSQL);

   case DesativadoState of
        STD_DESATIVADO      : WhereClause1 := FirstTable + '.DESATIVADO = 1';
        STD_NAODESATIVADO   : WhereClause1 := FirstTable + '.DESATIVADO = 0';
        STD_AMBOSDESATIVADO : WhereClause1 := '';
   end;

   case HiddenState of
        STD_HIDDEN          : WhereClause2 := FirstTable + '.HIDDEN = 1';
        STD_NAOHIDDEN       : WhereClause2 := FirstTable + '.HIDDEN = 0';
        STD_AMBOSHIDDEN     : WhereClause2 := '';
   end;

   Result := ChangeWhereClause(OldSQL, WhereClause1, False);

   Result := ChangeWhereClause(Result, WhereClause2, False);
end;

function UnMountSQL(SQlText : String) : TSqlStatement;
var
 i, IniPos, NextPos, NextState : integer;
 AuxPos : array[0..10] of integer;
begin
  SQLText := Trim(SQLText);

  // Calcula posicao inicial do Statement
  for i := 0 to High(aSqlStatement) do
     AuxPos[i] := Pos(aSqlStatement[i], UpperCase(RemoveUserText(SQlText)));

  // Separa as clausulas
  for i := 0 to High(aSqlStatement) do
   begin
     if AuxPos[i] = 0 then
       begin
         Result[i] := '';
         Continue;
       end;

     // Descobre qual a proxima clausula disponivel e existente
     NextState := i+1;
     while NextState <= High(aSqlStatement) do
       begin
         if AuxPos[NextState] > 0 then
            Break;

         Inc(NextState);
       end;

     if NextState > High(aSqlStatement) then
        // nao existe mais statements
        NextPos := Length(SQlText) + 1
     else
        NextPos := AuxPos[NextState];

     IniPos := AuxPos[i] + Length(aSqlStatement[i]);

     Result[i] :=  Trim(Copy(SQlText, IniPos, NextPos - IniPos));
   end;
end;

function UnMountPureSQL(SQlText : String) : TSqlStatement;
var
  PosHint, i,
  IniDel, FimDel : integer;
  SubSQL         : String;
begin
  Result := UnMountSQL(SQlText);

  if Result[ST_FROM] <> '' then
   begin
     SubSQL := UpperCase(Result[ST_FROM]);

     // retira hints de otimizacao
     for i := 0 to High(aSqlOptimizer) do
       begin
         PosHint := Pos(aSqlOptimizer[i], SubSQL);

         while PosHint > 0 do
           begin
             PosHint := Pos(aSqlOptimizer[i], SubSQL);

             // acha o hint e deve retiralo
             if PosHint > 0 then
               begin
                 IniDel := PosHint;
                 FimDel := PosHint;
                 // acha o ( inicial
                 while SubSQL[IniDel] <> '(' do
                   Dec(IniDel);
                 // acha o ( final
                 while SubSQL[FimDel] <> ')' do
                   Inc(FimDel);

                 Delete(SubSQL, IniDel, FimDel-IniDel+1);
               end;
           end;
       end;

     Result[ST_FROM] := SubSQL;
   end;
end;

function MountSQL(SqlStatement : TSqlStatement) : String;
var
 i : integer;
begin
  Result := '';
  // Calcula posicao inicial do Statement
  for i := 0 to High(SqlStatement) do
    begin
      if SqlStatement[i] <> '' then
         Result := Result + aSqlStatement[i] + ' ' + SqlStatement[i] + ' ';
    end;
end;

function GetFieldAlias(AFieldName, SQLText : String) : String;
var
   i, PosAlias : integer;
   AliasOrder  : String;
   MySqlStatement : TSqlStatement;
begin
   // Coloca a Alias do field a ser ordenado se houver
   MySqlStatement := UnMountSQL(SQlText);
   PosAlias := Pos('.' + UpperCase(AFieldName) + ',',
                   UpperCase(MySqlStatement[ST_SELECT]));
   if PosAlias = 0 then
     PosAlias := Pos('.' + UpperCase(AFieldName) + ' ',
                     UpperCase(MySqlStatement[ST_SELECT]));

   if PosAlias > 0 then
     begin
       Dec(PosAlias);
       i := PosAlias;
       while i > 0 do
         begin
           if (MySqlStatement[ST_SELECT][i] = ' ') or (MySqlStatement[ST_SELECT][i] = ',') then
              Break;
           Dec(i);
         end;
       Result := Copy(MySqlStatement[ST_SELECT], i+1, (PosAlias-i)+1)
     end
   else
       Result := '';
end;

function GetFieldOrigin(SQLText, FieldName : String) : String;
var
  nPos, nStartField, nEndField, LenField : integer;
  MySqlStatement : TSqlStatement;
  AuxField, SelectText : String;
begin
   // Se nao e derivado de alias ele mesmo e sua descricao completa

   MySqlStatement := UnMountSQL(SQlText);
   SelectText     := UpperCase(MySqlStatement[ST_SELECT]);
   FieldName      := UpperCase(FieldName);
   LenField       := Length(FieldName);
   nEndField      := 0;

   // descobre aonde esta o field
   for nPos := 1 to Length(SelectText) do
     begin
       if Copy(SelectText, nPos, LenField) = FieldName then
         begin
           if SelectText[nPos-1] = ' ' then
             begin
               if (nPos+LenField-1 = Length(SelectText)) or
                  (SelectText[nPos+LenField] = ' ') or
                  (SelectText[nPos+LenField] = ',') then
                 begin
                  nEndField := nPos-1;
                  Break;
                 end;
             end;
         end;

     end;

   if nEndField = 0 then
      Result := GetFieldAlias(FieldName, SQLText) + FieldName
   else
     begin
       // Acha aonde comeca o Field
       nStartField := 1;
       nPos        := nEndField;
       while nPos > 0 do
         begin
           if SelectText[nPos] = ',' then
             begin
              nStartField := nPos+1;
              nPos := -1;
             end
           else
              Dec(nPos)
         end;

       // Monta o field
       AuxField := '';
       for nPos := nStartField to nEndField do
         begin
           if (SelectText[nPos]   = ' ') and
              (SelectText[nPos+1] = 'A') and
              (SelectText[nPos+2] = 'S') and
              (SelectText[nPos+3] = ' ') then
             begin
              Break;
             end
           else
             begin
              AuxField := AuxField + SelectText[nPos];
             end;
         end;

       Result := AuxField;

       // Caso o campo esteja sozinho
       if Trim(Result) = '' then
          Result := GetFieldAlias(FieldName, SQLText) + FieldName;
     end;
end;

function IsAgregate(SQLText : String) : Boolean;
var
  i : integer;
begin
  Result := False;
  for i := 0 to High(aSqlAgregate) do
    begin
      if Pos(aSqlAgregate[i], UpperCase(SQLText)) > 0 then
        begin
          Result := True;
          Break;
        end;
    end;
end;

function MontaComboWhereClause(sTableAlias, sTableField, sSource : String):String;
begin

   Result := sTableAlias + '.' + sTableField + ' IN (' + sSource + ')';

end;


end.
