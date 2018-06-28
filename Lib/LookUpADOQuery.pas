unit LookUpADOQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, PowerADOQuery, ADODb, uSqlFunctions, uSystemTypes,
  uStringFunctions;

type
  TClickButtonEvent = function (Sender : TPowerADOQuery;
                               ClickedButton : TBtnCommandType;
                               var PosID1, PosID2 : String) : Boolean of object;

  TLookUpADOQuery = class(TPowerADOQuery)
  private
    { Private declarations }
    FquFreeSQL : TADOQuery;
    FListField, FLookUpField,
    FSecondSQL, FCodeField, FSecondWildCard : String;
    FSecondFieldType : TFieldType;
    FOnClickButton : TClickButtonEvent;
    MySpcWhereClause, MyFltWhereClause : String;
    FLookUpFieldSearch, FCodeFieldSearch : Boolean;
    function GetWhereClause(FFilterFields, FFilterValues : TStringList) : String;
    function PutFltWhere(StrWhere, FltWhereClause,
                         SpcWhereClause : String;
                         MostraDesativado : TDesativadoState;
                         MostraHidden     : THiddenState) : String;
    procedure SaveOriginalSQL;
  protected
    { Protected declarations }
  public
    { Public declarations }
    FOnBeforeOpenGrid : TNotifyEvent;  {# Antes de abrir o grid }
    IsFirst     : Boolean;
    ListValue, LookUpValue, CodeValue : String;
    OriginalSQL : String;      // Guarda o SQL original de procura
    function CallLookUpForm(IsAddNew : Boolean) : Boolean;
    procedure UpdateValues;
    procedure ResetValues;
    function LocateFirst(Value : String; IsListFiltered, IsLocate : Boolean;
                         FFilterFields, FFilterValues : TStringList;
                         FilterSugest : Boolean;
                         SpcWhereClause : String;
                         FilterEqual    : Boolean;
                         MostraDesativado : TDesativadoState;
                         MostraHidden     : THiddenState) : Boolean;
    function LocateLast(IsListFiltered : Boolean;
                        FFilterFields, FFilterValues : TStringList;
                        FilterSugest : Boolean;
                        SpcWhereClause : String;
                        MostraDesativado : TDesativadoState;
                         MostraHidden     : THiddenState) : Boolean;
    function LocateNext (Value : String; IsListFiltered : Boolean;
                         nRowMove : integer;
                         FFilterFields, FFilterValues : TStringList;
                         FilterSugest : Boolean;
                         SpcWhereClause : String;
                         MostraDesativado : TDesativadoState;
                         MostraHidden     : THiddenState) : Boolean;
    function LocatePrior(Value : String; IsListFiltered : Boolean;
                         nRowMove : integer;
                         FFilterFields, FFilterValues : TStringList;
                         FilterSugest   : Boolean;
                         SpcWhereClause : String;
                         MostraDesativado : TDesativadoState;
                         MostraHidden     : THiddenState) : Boolean;
    function DescLookUpField(Value : String;
                             IsLookUpField : Boolean;
                             FFilterFields, FFilterValues : TStringList;
                             FilterSugest : Boolean;
                             SpcWhereClause : String;
                             MostraDesativado : TDesativadoState;
                             MostraHidden     : THiddenState) : Boolean;
    constructor Create( AOwner: TComponent ); override;
  published
    { Published declarations }

    property SecondFieldType : TFieldType read FSecondFieldType write FSecondFieldType;
    property SecondSQL       : String read FSecondSQL write FSecondSQL;
    property ListField       : String read FListField write FListField;
    property CodeField       : String read FCodeField write FCodeField;
    property CodeFieldSearch : Boolean read FCodeFieldSearch write FCodeFieldSearch default True;
    property LookUpField     : String read FLookUpField write FLookUpField;
    property LookUpFieldSearch : Boolean read FLookUpFieldSearch write FLookUpFieldSearch default True;
    property quFreeSQL       : TADOQuery read FquFreeSQL write FquFreeSQL;
    property SecondWildCard  : String read FSecondWildCard write FSecondWildCard;

    // Eventos
    property OnClickButton   : TClickButtonEvent read FOnClickButton write FOnClickButton;
    property OnBeforeOpenGrid : TNotifyEvent read FOnBeforeOpenGrid write FOnBeforeOpenGrid;
  end;

procedure Register;

implementation

uses xBase, uDataBaseFunctions;

const
  MAX_ROWS = 200;

constructor TLookUpADOQuery.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  IsFirst          := True;
  FSecondSQL       := '';
  MySpcWhereClause := '';
  MyFltWhereClause := '';
  FSecondFieldType := ftString;
  FSecondWildCard  := '';

  FLookUpFieldSearch := True;
  FCodeFieldSearch   := True;

  ResetValues;
end;

procedure TLookUpADOQuery.SaveOriginalSQL;
begin
  if IsFirst then
    begin
     IsFirst := False;
     OriginalSQL := CommandText;
    end;
end;

function TLookUpADOQuery.LocateFirst(Value : String; IsListFiltered, IsLocate : Boolean;
                                  FFilterFields, FFilterValues : TStringList;
                                  FilterSugest : Boolean;
                                  SpcWhereClause : String;
                                  FilterEqual    : Boolean;
                                  MostraDesativado : TDesativadoState;
                                  MostraHidden     : THiddenState) : Boolean;
var
   NewSQL, WhereString : String;
   MyValue, FltWhereClause, OldSQL : String;
   OldPos  : TBookMarkStr;
   lFound  : Boolean;
begin
  SaveOriginalSQL;

  MyValue := FixStrPlic(Value);

  lFound  := False;

  if FilterSugest then
     FltWhereClause := ''
  else
     FltWhereClause := GetWhereClause(FFilterFields, FFilterValues);

  if (FltWhereClause <> MyFltWhereClause) or (SpcWhereClause <> MySpcWhereClause) then
    begin
      MyFltWhereClause := FltWhereClause;
      MySpcWhereClause := FltWhereClause;
    end
  else
    begin
      if Active and ( (not IsListFiltered) or IsLocate) then
        begin
         // Tenta procurar em memoria
         try
           lFound := Locate(FListField, MyValue, [loPartialKey, loCaseInsensitive]);
         except
           on exception do
              Result := False;
         end;
        end;
    end;

  // tenta procurar dando requery
  if not lFound then
    begin
     try
       DisableControls;

       // Guarda antigo SQL
       OldSQL := CommandText;
       OldPos := BookMark;

       if IsListFiltered then
         begin
          if FilterEqual then
             WhereString := FListField + ' >= ' + Chr(39) + MyValue + Chr(39)
          else
             WhereString := FListField + ' > ' + Chr(39) + MyValue + Chr(39);

          NewSQL := ChangeWhereClause(OriginalSQL, WhereString, False);
          NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);

          if Active then Close;
          CommandText := NewSQL;
          Open;
          RecordCount;  // Forca trazer todo o recordset
          lFound := not (Eof and Bof);
          // Controle de quando se posicionar no maior que esta sendo procurado.
          if FilterEqual then
            begin
             lFound := lFound and ( UpperCase(LeftStr(Trim(FieldByName(FListField).AsString), Length(Value))) = UpperCase(Trim(Value)) );

             // Forca a continuar no mesmo lugar, quando filtrar o item e nao puder acha-lo
             if not lFound then
               begin
                 // nao achou, deve se manter no mesmo lugar que estava antes
                 if Active then Close;
                 CommandText := OldSQL;
                 Open;
                 RecordCount;  // Forca trazer todo o recordset
                 BookMark := OldPos;
               end;
            end;
         end
       else
         begin

          if not Active then
            begin
              NewSQL := PutFltWhere(OriginalSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);

              if Active then Close;
              CommandText := NewSQL;
              Open;
              RecordCount;  // Forca trazer todo o recordset
              lFound := not (Eof and Bof);

              // Se nao esta no modo de IsListFiltered e existe itens no query deve dar locate
              if lFound then
                begin
                 try
                   lFound := Locate(FListField, MyValue, [loPartialKey, loCaseInsensitive]);
                 except
                   on exception do
                      Result := False;
                 end;
                end;
            end;

          if MyValue = '' then
            begin
              // vai para o primeiro
              First;
              if not (Eof and Bof) then
                 lFound := True;
            end;
         end;

     finally
       EnableControls;
     end;
    end;

  Result := lFound;

  // Guarda os valores retornados
  if lFound then
     UpdateValues
  else
     ResetValues;
end;

function TLookUpADOQuery.LocateNext(Value : String; IsListFiltered : Boolean;
                                 nRowMove : integer;
                                 FFilterFields, FFilterValues : TStringList;
                                 FilterSugest : Boolean;
                                 SpcWhereClause : String;
                                 MostraDesativado : TDesativadoState;
                                 MostraHidden     : THiddenState) : Boolean;
var
  lChange : Boolean;
  OldPos  : TBookMarkStr;
begin
  lChange := False;

  if Active then
    begin
     // Tenta procurar em memoria
     OldPos   := BookMark;
     MoveBy(nRowMove);
     lChange  := (OldPos <> BookMark);
    end;

  if not lChange then
     lChange := LocateFirst(Value, IsListFiltered, False,
                            FFilterFields, FFilterValues, FilterSugest,
                            SpcWhereClause, False, MostraDesativado, MostraHidden);
  Result := lChange;
end;

function TLookUpADOQuery.LocatePrior(Value : String; IsListFiltered : Boolean;
                                  nRowMove : integer;
                                  FFilterFields, FFilterValues : TStringList;
                                  FilterSugest : Boolean;
                                  SpcWhereClause : String;
                                  MostraDesativado : TDesativadoState;
                                  MostraHidden     : THiddenState) : Boolean;
var
  OldPos  : TBookMarkStr;
  lChange : Boolean;
  NewSQL, WhereString, FltWhereClause, MyValue : String;
  MySQLStatement : TSQlStatement;
begin
  lChange := False;

  if not Active then
     LocateFirst(Value, IsListFiltered, False,
                 FFilterFields, FFilterValues, FilterSugest,
                 SpcWhereClause, True, MostraDesativado, MostraHidden);

  // Tenta procurar em memoria
  OldPos   := BookMark;
  MoveBy(-nRowMove);
  lChange := (OldPos <> BookMark);

  if not lChange and IsListFiltered then
    begin
     // Tenta procurar dando varios requeries
     MyValue := FixStrPlic(Value);

     if FilterSugest then
        FltWhereClause := ''
     else
        FltWhereClause := GetWhereClause(FFilterFields, FFilterValues);

     try
        DisableControls;

        MySQLStatement := UnMountSQL(OriginalSQL);

        MySQLStatement[ST_ORDER]  := GetFieldAlias(FListField, OriginalSQL) + FListField + ' DESC';
        NewSQL := MountSQL(MySQLStatement);
        NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);

        WhereString := FListField + ' < ' + Chr(39) + MyValue + Chr(39);
        NewSQL := ChangeWhereClause(NewSQL, WhereString, False);

        if Active then Close;
        CommandText := NewSQL;
        Open;
        lChange := not (Eof and Bof);

        if lChange then
          begin
            MoveBy(MAX_ROWS-50);
            WhereString := FListField + ' >= ' + Chr(39) + Trim(FieldByName(FListField).AsString) + Chr(39);
            NewSQL := ChangeWhereClause(OriginalSQL, WhereString, False);
            NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);
            if Active then Close;
            CommandText := NewSQL;
            Open;
            RecordCount;

            Locate(FListField, Trim(Value), [loPartialKey, loCaseInsensitive]);
            MoveBy(-nRowMove);
          end;

     finally
        EnableControls;
     end;
    end;

  Result := lChange;
end;

function TLookUpADOQuery.LocateLast(IsListFiltered : Boolean;
                                 FFilterFields, FFilterValues : TStringList;
                                 FilterSugest : Boolean;
                                 SpcWhereClause : String;
                                 MostraDesativado : TDesativadoState;
                                 MostraHidden     : THiddenState) : Boolean;
var
  MySQLStatement : TSQlStatement;
  FltWhereClause, NewSQL : String;
begin
  if not IsListFiltered then
    begin
      Result := True;
      if not Active then
         LocateFirst('', IsListFiltered, False,
                     FFilterFields, FFilterValues, FilterSugest,
                     SpcWhereClause, True, MostraDesativado, MostraHidden);
      Last;
    end
  else
    begin
      // Descobre o ultimo da Lista
      with FquFreeSQL do
        begin
          try
            DisableControls;
            if Active then Close;

            if FilterSugest then
               FltWhereClause := ''
            else
               FltWhereClause := GetWhereClause(FFilterFields, FFilterValues);

            MySQLStatement := UnMountSQL(OriginalSQL);

            MySQLStatement[ST_SELECT] := ' MAX( ' + FListField + ' ) ';
            MySQLStatement[ST_ORDER]  := '';

            NewSQL := MountSQL(MySQLStatement);
            NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);

            if Active then Close;
            CommandText := NewSQL;
            Open;

            Result := not (Eof and Bof);

            if Result then
               LocatePrior(Fields[0].AsString, IsListFiltered, 0,
                                       FFilterFields, FFilterValues,
                                       FilterSugest, SpcWhereClause, MostraDesativado, MostraHidden);

            Close;
          finally
            EnableControls;
          end;
        end;
    end;
end;

function TLookUpADOQuery.DescLookUpField(Value : String;
                                      IsLookUpField : Boolean;
                                      FFilterFields, FFilterValues : TStringList;
                                      FilterSugest : Boolean;
                                      SpcWhereClause : String;
                                      MostraDesativado : TDesativadoState;
                                      MostraHidden     : THiddenState): Boolean;
var
  NewSQL, WhereString, FltWhereClause : String;
  FoundSecond, FoundFirst : Boolean;
  MyField, MyValue                    : String;
begin

  FoundSecond := False;
  FoundFirst  := False;

  MyValue := FixStrPlic(Value);

  if IsLookUpField then
    begin
     MyField := FLookUpField;
     MostraDesativado := STD_AMBOSDESATIVADO;
     MostraHidden     := STD_AMBOSHIDDEN;
    end
  else
     MyField := FCodeField;

  SaveOriginalSQL;

  if FilterSugest then
     FltWhereClause := ''
  else
     FltWhereClause := GetWhereClause(FFilterFields, FFilterValues);

  // Testa se value e vazio
  if MyValue = '' then
    begin
     ResetValues;
     // Se nao existe nada digitado forca a trcoa para nulo
     Result := True;
     Exit;
    end;

  // Inicia procura no secondSQl se existir
  if FSecondSQL <> '' then
   begin
     try
      DisableControls;
      // Teste se e necesario realizar a Query
      if TestFieldQuery(FSecondFieldType, MyValue) then
        begin
         NewSQL := Format(FSecondSQL, [ConvTypeSQLValue(FSecondFieldType, MyValue+FSecondWildCard)]);
         NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);

         if Active then Close;
         CommandText := NewSQL;
         try
           Open;
           FoundSecond := not (Eof and Bof);
         except
           FoundSecond := False;
         end;
        end
      else
        begin
         FoundSecond := False;
        end;

      if FoundSecond then
         UpdateValues
      else
         ResetValues;

      Result := FoundSecond;

      Close;
      EnableControls;
     except
       on exception do
        begin
         EnableControls;
         ResetValues;
         FoundSecond := False;
        end;
     end;
   end;

  if not FoundSecond then
   begin
     // Testa se deve fazer a procura pelo CodeField
     if IsLookUpField then
       begin
        {if not FLookUpFieldSearch then
          begin
            ResetValues;
            Result := False;
            Exit;
          end
         }
       end
     else
       begin
        if not FCodeFieldSearch then
          begin
            ResetValues;
            Result := False;
            Exit;
          end;
       end;

     // Procura o LookUpField
     try
       DisableControls;
       // Teste se e necesario realizar a Query
       if TestFieldQuery(FieldByName(MyField).DataType, MyValue) then
         begin
          WhereString := MyField + ' = ' +
                         ConvSQLValue(FieldByName(MyField), MyValue);
          NewSQL := ChangeWhereClause(OriginalSQL, WhereString, False);
          NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause, MostraDesativado, MostraHidden);

          if Active then Close;
          CommandText := NewSQL;
          try
            Open;
            FoundFirst := not (Eof and Bof);
          except
            FoundFirst := False;
          end;
         end
       else
         begin
          FoundFirst := False
         end;

       if FoundFirst then
         UpdateValues
       else
         ResetValues;

       Result := FoundFirst;

       // ( Trim(UpperCase(LookUpValue)) = Trim(UpperCase(Value)) );

       Close;
       EnableControls;
     except
       on exception do
        begin
         ResetValues;
         EnableControls;
        end;
     end;
   end;

end;

function TLookUpADOQuery.PutFltWhere(StrWhere, FltWhereClause,
                                  SpcWhereClause : String;
                                  MostraDesativado : TDesativadoState;
                                  MostraHidden     : THiddenState) : String;
begin
 Result := strWhere;
 if FltWhereClause <> '' then
    Result := ChangeWhereClause(Result, FltWhereClause, False);
 if SpcWhereClause <> '' then
    Result := ChangeWhereClause(Result, SpcWhereClause, False);
 case MostraDesativado of
      STD_NAODESATIVADO : Result := ChangeWhereClause(Result, 'DESATIVADO = 0', False);
      STD_DESATIVADO    : Result := ChangeWhereClause(Result, 'DESATIVADO = 1', False);
 end;
 case MostraHidden of
      STD_NAOHIDDEN     : Result := ChangeWhereClause(Result, 'HIDDEN = 0', False);
      STD_HIDDEN        : Result := ChangeWhereClause(Result, 'HIDDEN = 1', False);
 end;
end;

procedure TLookUpADOQuery.UpdateValues;
begin
  ListValue   := FieldByName(FListField).AsString;
  LookUpValue := FieldByName(FLookUpField).AsString;
  CodeValue   := FieldByName(FCodeField).AsString;
end;

procedure TLookUpADOQuery.ResetValues;
begin
  ListValue   := '';
  LookUpValue := '';
  CodeValue   := '';
end;

function TLookUpADOQuery.CallLookUpForm(IsAddNew : Boolean): Boolean;
var
  Ret      : Boolean;
  PosID1, PosID2, WhereString, NewSQL : String;
begin
  SaveOriginalSQL;
  Ret := False;

  if Assigned(OnClickButton) then
    begin
     if IsAddNew then
        Ret := FOnClickButton(Self, btInc, PosID1, PosID2)
     else
        Ret := FOnClickButton(Self, btAlt, PosID1, PosID2);

     if Ret then
       begin
        try
          DisableControls;
          Close;

          WhereString := FLookUpField + ' = ' + ConvSQLValue(FieldByName(FLookUpField), PosID1);

          NewSQL := ChangeWhereClause(OriginalSQL, WhereString, False);

          if Active then Close;
          CommandText := NewSQL;
          Open;
          UpdateValues;
        finally
          EnableControls;
        end;

       end;

     Result := Ret;
    end;
end;

function TLookUpADOQuery.GetWhereClause(FFilterFields, FFilterValues : TStringList) : String;
var
  i : integer;
begin

  Result := '';
  for i := 0 to FFilterFields.Count - 1 do
    begin
      Result := Result + ' ( ' + FFilterFields[i] + ' = ' + FFilterValues[i] + ' ) ';
      if i < FFilterFields.Count - 1 then
         Result := Result + ' AND '
    end;
end;

{
function TLookUpADOQuery.LocatePrior(Value : String; FFilterFields, FFilterValues : TStringList;
                                  FilterSugest : Boolean;
                                  SpcWhereClause : String) : Boolean;
var
   NewSQL, WhereString : String;
   MyValue, FltWhereClause : String;
   lFound  : Boolean;
begin
  SaveOriginalSQL;

  MyValue := FixStrPlic(Value);

  lFound  := False;

  if FilterSugest then
     FltWhereClause := ''
  else
     FltWhereClause := GetWhereClause(FFilterFields, FFilterValues);

  // tenta procurar dando requery
     try
       DisableControls;
       if IsListFiltered then
         begin
          if FilterWithLike then
             WhereString := FListField + ' like ' + Chr(39) + MyValue + '%' + Chr(39)
          else
             WhereString := FListField + ' > ' + Chr(39) + MyValue + Chr(39);

          NewSQL := ChangeWhereClause(OriginalSQL, WhereString, False);
          NewSQL := PutFltWhere(NewSQL, FltWhereClause, SpcWhereClause);
         end
       else
         begin
          NewSQL := PutFltWhere(OriginalSQL, FltWhereClause, SpcWhereClause);
         end;

       if Active then Close;
       CommandText := NewSQL;
       Open;
       RecordCount;  // Forca trazere todo o recordset
       lFound := not (Eof and Bof);
     finally
       EnableControls;
     end;
    end;

  Result := lFound;

  // Guarda os valores retornados
  if lFound then
     UpdateValues
  else
     ResetValues;
end;
}

procedure Register;
begin
  RegisterComponents('NewPower', [TLookUpADOQuery]);
end;

end.
