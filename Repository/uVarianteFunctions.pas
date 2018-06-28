unit uVarianteFunctions;

interface

uses DB, Sysutils;

function ConvVariant(FieldType : TFieldType; Value : String) : Variant;
function VarHigh(MyVariant : Variant) : integer;
function VarToNum(MyVariant : Variant) : Variant;
function VarToBol(MyVariant : Variant) : Variant;
function ConvVarArray(cString : String) : Variant;


implementation

function ConvVariant(FieldType : TFieldType; Value : String) : Variant;
begin
   if FieldType in [ftString, ftDateTime, ftDate, ftMemo] then
      Result := Value
   else
      Result := StrToInt(Value);
end;

function  VarHigh(MyVariant : Variant) : integer;
begin
   Result := VarArrayHighBound(MyVariant, VarArrayDimCount(MyVariant));
end;

function  VarToNum(MyVariant : Variant) : Variant;
begin
  if TVarData(MyVariant).VType <> varNull then
     Result := MyVariant
  else
     Result := 0;
end;

function  VarToBol(MyVariant : Variant) : Variant;
begin
  if TVarData(MyVariant).VType <> varNull then
     Result := MyVariant
  else
     Result := False;
end;

function ConvVarArray(cString : String) : Variant;
var
   NewArray : Variant;
   i : integer;
   nLenInd, Count : integer;
   cTemp   : String;
begin

   { Testa se é necessário }
   if Pos(';', cString) = 0 then
     begin
      Result := cString;
      Exit;
     end;

   { Rotina que converte uma string separada
     por ; para Variant Array }
   NewArray := VarArrayCreate([0, 10], varVariant);
   { seta variaveis iniciais }
   cTemp := '';
   nLenInd := Length(cString) + 1;
   Count   := -1;

   for i := 1 to nLenInd do
     begin
       if (cString[i] = ';') or
          (i = nLenInd) then
         begin
           { acrescenta ao variant array }
           Inc(Count);
           NewArray[Count] := cTemp;
           cTemp := '';
         end
       else
         begin
          cTemp := cTemp + cString[i];
         end;
     end;

   Result := NewArray;

end;


end.
