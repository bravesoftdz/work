unit uDataBaseFunctions;

{
   Database function
   Developer: Rodrigo Costa - 05/08/02
}


interface

uses db, ADOdb, stdctrls, Sysutils, uMsgBox, xBase, uLanguageFunctions,
     uStringFunctions{, Variants};


procedure CheckRequired(MyDataSet : TDataSet);
function  MyLocate(MyDataSet : TDataSet;
                   var NewString : String;
                   const KeyFields: string;
                   const KeyValues: Variant;
                   Options: TLocateOptions) : Boolean;

function SystemDeleteBranch(quFreeSQL : TADOQuery; TableName: String; FieldName : String; Path : String; CheckSystem, RealDelete : Boolean) : Boolean;
function SystemDeleteItem(quFreeSQL : TADOQuery; TableName: String;aFields, aValues : array of String;
                          aFieldTypes : array of TFieldType; CheckSystem, RealDelete : Boolean) : Boolean;

function SystemRestoreItem(quFreeSQL : TADOQuery; TableName: String;aFields, aValues : array of String;
                          aFieldTypes : array of TFieldType) : Boolean;
function SystemRestoreBranch(quFreeSQL : TADOQuery; TableName: String; FieldName : String; Path : String) : Boolean;

function SubSystemDeleteRestore(quFreeSQL : TADOQuery; TableName : String; aFields, aValues : array of String;
                                aFieldTypes : array of TFieldType;
                                IsBranch : Boolean; CheckSystem, RealDelete, IsRestore : Boolean) : Boolean;

function GetTableKeys(quFreeSQL : TADOQuery; TableName: String) : Variant;

function HandleDataBaseError(StrErro : String; var RetMessage : String) : String;

function GetFieldSpc(cIndex : String; LblDataSet : TDataSet;
                     IsRetValor : Boolean) : String;
procedure CheckEditState(MyDataSet : TDataSet);
procedure CheckActive(MyDataSet : TDataSet);
procedure CheckNetRefresh(MyDataSet : TDataSet);

procedure DeleteSub(MyDataSet : TDataSet;
                    Chave     : String;
                    OldValor  : Variant);

procedure AtuIncSub(SubSet : TDataSet;
                    SubCod, MasterCod : String);
procedure FillSecondSearch(brwDataSet : TDataSet; FirstIndex : integer;
                           Combo : TComboBox);

function AdjustFieldDisplayName(FieldName : String) : String;
function RealDisplayName(FieldName:String ): String;

function ConvSQLValue(SQLField : TField; SQLValue : String) : String;
function ConvTypeSQLValue(FieldType : TFieldType; SQLValue : String) : String;
function TestFieldQuery(FieldType : TFieldType; strValue : String) : Boolean;

function TestFill(Field: TField; DisplayName: String): Boolean;

function QuoteField(FieldType : TFieldType; Value : String): String;

implementation


procedure CheckRequired(MyDataSet : TDataSet);
const
  CheckTypes = [ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat,
    ftCurrency, ftBCD, ftDate, ftTime, ftDateTime, ftBytes, ftVarBytes];
var
  I: Integer;
begin
 with MyDataSet do
  begin
   if State in dsEditModes then
     UpdateRecord;
   for I := 0 to FieldCount - 1 do
     with TField(Fields[I]) do
       if Required and not ReadOnly and (FieldKind = fkData) and
         (DataType in CheckTypes) and (Trim(TField(Fields[I]).AsString) = '') then
       begin
         MsgBox(DisplayName + ' não pode ser vazio', vbOkOnly + vbInformation);
         FocusControl;
         SysUtils.Abort;
       end;
  end;
end;

function  MyLocate(MyDataSet : TDataSet;
                   var NewString : String;
                   const KeyFields: string;
                   const KeyValues: Variant;
                   Options: TLocateOptions) : Boolean;
var
  i, PosKey, LenKeyValue : Integer;
  AuxStr, SearchStr      : String;
begin
  // Modificação do Locate para poder achar letras acentuadas

  Result      := MyDataSet.Locate(KeyFields, KeyValues, Options);
  LenKeyValue := Length(KeyValues);
  NewString   := '';

  if not Result then
     if not (VarType(KeyValues) = varArray) then
        begin
        SearchStr := KeyValues;
        for PosKey := Length(SearchStr) downto 1 do
            for i := 0 to High(aAcento) do
                if UpperCase(SearchStr[PosKey]) = UpperCase(aAcento[i, 0]) then
                   begin
                   AuxStr := SearchStr;
                   AuxStr[PosKey] := aAcento[i, 1][1];
                   Result := MyDataSet.Locate(KeyFields, AuxStr, Options);
                    if Result then
                       begin
                       NewString := AuxStr;
                       Exit;
                       end;
                   end;
        end;
end;

function SystemDeleteBranch(quFreeSQL : TADOQuery; TableName: String; FieldName : String; Path : String; CheckSystem, RealDelete : Boolean) : Boolean;
begin
   Result := SubSystemDeleteRestore(quFreeSQL, TableName, [FieldName], [Path], [ftString], True, CheckSystem, RealDelete, False);
end;

function SystemDeleteItem(quFreeSQL : TADOQuery; TableName: String;aFields, aValues : array of String;
                          aFieldTypes : array of TFieldType; CheckSystem, RealDelete : Boolean) : Boolean;
begin
   Result := SubSystemDeleteRestore(quFreeSQL, TableName, aFields, aValues, aFieldTypes, False, CheckSystem, RealDelete, False);
end;

function SystemRestoreItem(quFreeSQL : TADOQuery; TableName: String;aFields, aValues : array of String;
                          aFieldTypes : array of TFieldType) : Boolean;
begin
   Result := SubSystemDeleteRestore(quFreeSQL, TableName, aFields, aValues, aFieldTypes, False, False, False, True);
end;

function SystemRestoreBranch(quFreeSQL : TADOQuery; TableName: String; FieldName : String; Path : String) : Boolean;
begin
   Result := SubSystemDeleteRestore(quFreeSQL, TableName, [FieldName], [Path], [ftString], True, False, False, True);
end;

function SubSystemDeleteRestore(quFreeSQL : TADOQuery; TableName : String; aFields, aValues : array of String;
                                aFieldTypes : array of TFieldType;
                                IsBranch : Boolean; CheckSystem, RealDelete, IsRestore : Boolean) : Boolean;
var
   i : integer;
   strSQL, strSQLWhere : String;
begin
  Result := True;
  with quFreeSQL do
    begin
        // Teste se e registro System
        strSQLWhere := '';
        strSQL := 'SELECT System FROM ' + TableName +
                  ' WHERE ';
        if not IsBranch then
          begin
            for i := Low(aFields) to High(aFields) do
              begin
                IncString(StrSQLWhere, aFields[i] + ' = ' +
                          ConvTypeSQLValue(aFieldTypes[i], aValues[i]));
                if i < High(aFields) then
                  begin
                   IncString(StrSQLWhere, ' AND ');
                  end;
              end;
          end
        else
          begin
            for i := Low(aFields) to High(aFields) do
              begin
                IncString(StrSQLWhere, aFields[i] + ' like ' +
                          ConvTypeSQLValue(aFieldTypes[i], aValues[i] + '%'));
                if i < High(aFields) then
                   IncString(StrSQLWhere, ' AND ');
              end;
          end;

        if CheckSystem then
          begin
           if Active then
              Close;
           SQL.Text := strSQL + strSQLWhere;
           Open;
           if Fields[0].AsBoolean then
             begin
              MsgBox('System item cannot be deleted.', vbOkOnly + vbInformation);
              Result := False;
              Exit;
             end;
          end;

        if RealDelete then
          begin
            // Delecao Real
            try
              Close;
              SQL.Text := 'DELETE FROM ' + TableName + ' WHERE ' + strSQLWhere;
              ExecSQL;
            except
              Result := False;
              MsgBox('Item cannot be deleted.', vbOkOnly + vbInformation);
            end;

          end
        else
          begin
            Close;
            // Delecao ou restauracao Marcada
            if IsRestore then
               SQL.Text := 'UPDATE ' + TableName + ' SET Desativado = 0 WHERE ' + strSQLWhere
            else if not RealDelete then
               SQL.Text := 'UPDATE ' + TableName + ' SET Desativado = 1 WHERE ' + strSQLWhere;
            ExecSQL;

          end;

    end;
end;

function GetTableKeys(quFreeSQL : TADOQuery; TableName: String) : Variant;
var
  aKeys : Variant;
  P: Integer;

begin

  aKeys    := VarArrayCreate([0, 0], varOleStr);
  aKeys[0] := '';

  // Retiro o nome do usuario caso ele exista
  if UpperCase(LeftStr(TableName, 4)) = 'DBO.' then
    TableName := RightStr(TableName, Length(TableName)-4);

  with quFreeSQL do
    begin
      Close;
      SQL.Text := 'exec sp_System_dbKeys ' +#39 + TableName + #39;
      Open;

      while not eof do
        begin
          aKeys[VarArrayHighBound(aKeys, 1)] := quFreeSQL.Fields[3].AsString;
          Next;

          if not Eof then
             VarArrayRedim(aKeys, VarArrayHighBound(aKeys, 1)+1);
        end;
      Close;
    end;

  Result := aKeys;
end;

function HandleDataBaseError(StrErro : String; var RetMessage : String) : String;
  function GetFieldGen(TpErro, strErro : String) : String;
  var
     PosErro   : integer;
     strField  : String;
     lEntrou   : Boolean;
  begin
    lEntrou := False;
    { Obtem o campo do erro }
    PosErro := Pos(TpErro, UpperCase(strErro)) + Length(TpErro) + 1;
    while not ( (Copy(strErro, PosErro, 1) = Chr(39)) or
                (Copy(strErro, PosErro, 1) = ' ') )   do
      begin
        if (Copy(strErro, PosErro, 1) = '_') or lEntrou then
          begin
           lEntrou := True;
           if Copy(strErro, PosErro, 1) <> '_' then
              IncString(strField, Copy(strErro, PosErro, 1));
          end;
        Inc(PosErro);
      end;
    Result := strField;
  end;

  function GetFieldNull(TpErro, strErro : String) : String;
  var
     PosErro   : integer;
     strField  : String;
  begin
    { Obtem o campo do erro }
    PosErro := Pos(TpErro, UpperCase(strErro)) + 7;
    // teste de outro erro de null
    if Copy(strErro, PosErro, 1) = Chr(39) then
       Inc(PosErro);

    while not ( (Copy(strErro, PosErro, 1) = Chr(39)) or
                (Copy(strErro, PosErro, 1) = ' ') ) do
      begin
        IncString(strField, Copy(strErro, PosErro, 1));
        Inc(PosErro);
      end;
    Result := strField;
  end;

  { Funcao principal }
var
  strError : String;
begin

  strError := Trim(UpperCase(strErro));

  if Pos('PRIMARY KEY', strError) > 0 then
     // Erro de chave primaria
     begin
          Result     := GetFieldGen('PK_', strError);
          RetMessage := ' cannot be duplicated';
     end
  else if Pos('FOREIGN KEY', strError) > 0 then
     // Erro de chave secundaria
     begin
          Result := GetFieldGen('FK_', strError);
          RetMessage := ' has dependente';
     end
  else if Pos('UNIQUE KEY', strError) > 0 then
     // Erro de chave secundaria
     begin
          Result := GetFieldGen('UK_', strError);
          RetMessage := ' cannot be duplicated';
     end
  else if Pos('DUPLICATED', strError) > 0 then
     // Erro de duplicacao
     begin
          Result := GetFieldGen('DUP_', strError);
          RetMessage := ' cannot be duplicated';
     end
  else if Pos('NULL', strError) > 0 then
     // Erro de chave secundaria
     begin
          Result := GetFieldNull('COLUMN', strError);
          RetMessage := ' cannot be empty';
     end
  else if Pos('INSERT DUPLICATE KEY ROW', strError) > 0 then
     // Erro de chave secundaria
     begin
          Result := GetFieldGen('COLUMN', strError);
          RetMessage := ' cannot be duplicated._Record already exist.';
     end
  else
     { erro desconhecido }
     begin
          Result := '';
          RetMessage := '';
     end;
end;

function GetFieldSpc(cIndex : String; LblDataSet : TDataSet;
                     IsRetValor : Boolean) : String;
var
   i : integer;
   nLenInd : integer;
   cTemp, cLabelInd : String;
begin
     { seta variaveis iniciais }
     cTemp := '';
     cLabelInd := '';
     nLenInd := Length(cIndex) + 1;

     for i := 1 to nLenInd do
       begin
         if (cIndex[i] = ';') or
            (i = nLenInd) then
           begin
            if IsRetValor then
               cLabelInd := cLabelInd + LblDataSet.FieldByName(cTemp).AsString
            else
               cLabelInd := cLabelInd + LblDataSet.FieldByName(cTemp).DisplayName;

            cTemp := '';
            if i < nLenInd then
               cLabelInd := cLabelInd + ';';
           end
         else
           begin
            cTemp := cTemp + cIndex[i];
           end;
       end;

     Result := cLabelInd;
end;

procedure CheckEditState(MyDataSet : TDataSet);
begin
   if not (MyDataSet.State in dsEditModes) then
      MyDataSet.Edit;
end;


procedure CheckActive(MyDataSet : TDataSet);
begin
  if (not MyDataSet.Active) then
     MyDataSet.Open
  else
     MyDataSet.Refresh;
end;

procedure CheckNetRefresh(MyDataSet : TDataSet);
begin
  if MyDataSet.Active then
     MyDataSet.Refresh;
end;

procedure DeleteSub(MyDataSet : TDataSet;
                    Chave     : String;
                    OldValor  : Variant);
begin
  { Depois de deletar, deve-se deletar os
    Subitens do master }
  with MyDataSet do
   begin
     try
       DisableControls;
       AutoCalcFields := False;
       while Locate(Chave, OldValor, []) do
         begin
            Delete;
         end;
     finally
       EnableControls;
       AutoCalcFields := True;
     end;
   end;
end;

procedure AtuIncSub(SubSet : TDataSet;
                    SubCod, MasterCod : String);
begin
  with SubSet do
   begin
     try
      DisableControls;
      AutoCalcFields := False;
      First;
      while not Eof do
       begin
         CheckEditState(SubSet);
         FieldByName(SubCod).Value := MasterCod;
         Post;
       end;
     finally
      AutoCalcFields := True;
      EnableControls;
     end;
   end;
end;

procedure FillSecondSearch(brwDataSet : TDataSet; FirstIndex : integer;
                           Combo : TComboBox);
var
  i : integer;
begin
  with brwDataSet do
   begin
      Combo.Items.Clear;
      Combo.Items.Add('< none >');
      for i := 0 to FieldCount -1 do
        if i <> FirstIndex then
          Combo.Items.Add(Fields[i].DisplayName);
      Combo.ItemIndex := 0;
   end;
end;

function AdjustFieldDisplayName(FieldName : String) : String;
begin
  if (RightStr(FieldName, 2) = ' ^') or (RightStr(FieldName, 2) = ' v') then
    Result := LeftStr(FieldName, Length(FieldName) - 2)
  else
    Result := FieldName;
end;

function RealDisplayName(FieldName:String ): String;
var
  S: String;
  i: integer;

begin
  S := AdjustFieldDisplayName(FieldName);

  Result := '';

  for i := 1 to length(S) do
    if S[i] <> '~' then
      Result := Result + S[i]
    else
      Result := Result + ' ';

end;

function ConvSQLValue(SQLField : TField; SQLValue : String) : String;
begin
   Result := ConvTypeSQLValue(SQLField.DataType, SQLValue);
end;

function ConvTypeSQLValue(FieldType : TFieldType; SQLValue : String) : String;
begin
   if FieldType in [ftString, ftDateTime, ftDate, ftMemo] then
      Result := Chr(39) + SQLValue + Chr(39)
   else
      Result := SQLValue;
end;

function TestFieldQuery(FieldType : TFieldType; strValue : String) : Boolean;
var
   TestValue : Real;
   Code      : Integer;
begin
   if not (FieldType in [ftString, ftDateTime, ftDate, ftMemo]) then
     begin
      // Field e numero
      Val(strValue, TestValue, Code);
      Result := (Code = 0);
     end
   else
     begin
      Result := True;
     end;
end;

function TestFill(Field: TField; DisplayName: String): Boolean;
begin
  if Field.AsString = '' then
    begin
      MsgBox('Fields must be filled [' + DisplayName + ']!', vbInformation + vbOkOnly);
      Field.FocusControl;
      Result := False;
    end
  else
    Result := True;
end;

function QuoteField(FieldType : TFieldType; Value : String) : String;
begin
   if FieldType in [ftString, ftDateTime, ftDate, ftMemo] then
      Result := QuotedStr(Value)
   else
      Result := Value;
end;

end.
