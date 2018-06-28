unit uNumericFunctions;

interface

uses Sysutils, Math, Windows, uSystemTypes;

function ValidateFloat(cKey:Char):Char;
function ValidateCurrency(cKey:Char):Char;

function MyStrToFloat(strValue : String) : Extended;
function MyStrToCurrency( strValue : String) : Currency;
function MyStrToInt(strValue : String) : Integer;
function MyFloatToStr(Value : Double) : String;
function HasOperator(strValue : String) : Boolean;
function MyRound(Valor : Double; DecimalPlaces : Integer) : Double;
function AsloToFloat(Aslo: String): Double;
procedure IncFloat(var IncDef : Double; Value : Double);
function RetiraSepadorMilhar(StrValue: String): String;
function MyFormatCur(Value:Double;Decimal:Char):String;
function MyStrToMoney( strValue:String) : Currency;
// Funcao que calcula a combinacao de moedas para o Caixa
procedure CountToDesired(var aCaixa : TCaixa; TotCash, ValDesired : Double);


implementation

uses xBase;

function MyStrToMoney(strValue:String) : Currency;
var
  OldDecimalSeparator: Char;
begin

  if Trim(strValue) = '' then
     begin
     Result := 0;
     Exit;
     end;

  try
    OldDecimalSeparator  := DecimalSeparator;
    DecimalSeparator     := '.';

    if OldDecimalSeparator = ',' then
       begin
       strValue := StringReplace(strValue,'.','',[rfReplaceAll	]);
       strValue := StringReplace(strValue,',','.',[rfReplaceAll	]);
       end
    else
       strValue := StringReplace(strValue,',','',[rfReplaceAll	]);

    try
      Result := StrToCurr(strValue);
    except
       Result := 0;
       end;
    finally
      DecimalSeparator := OldDecimalSeparator;
      end;
end;


function MyFormatCur(Value:Double;Decimal:Char):String;
var
  OldDecimalSeparator: Char;
begin
  OldDecimalSeparator  := DecimalSeparator;
  DecimalSeparator := Decimal;
  Result := FormatCurr('0.00',Value);
  DecimalSeparator := OldDecimalSeparator;
end;

function ValidateCurrency(cKey:Char):Char;
begin
 if not (cKey IN ['0'..'9','-','.',',',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;
end;

function ValidateFloat(cKey:Char):Char;
begin
 if not (cKey IN ['0'..'9','-','.',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;
end;

function MyStrToCurrency( strValue : String) : Currency;
begin
   if Trim(strValue) = '' then
     begin
      Result := 0;
      Exit;
     end;

   try
     Result := StrToCurr(strValue);
   except
     Result := 0;
   end;
end;

function MyStrToFloat(strValue : String) : Extended;
begin
   if Trim(strValue) = '' then
     begin
      Result := 0;
      Exit;
     end;

   try
     Result := StrToFloat(strValue);
   except
     Result := 0;
   end;
end;

function MyStrToInt(strValue : String) : Integer;
begin
   if Trim(strValue) = '' then
     begin
      Result := 0;
      Exit;
     end;

   try
     Result := StrToInt(strValue);
   except
     Result := 0;
   end;
end;

function MyFloatToStr(Value : Double) : String;
begin
  Result := FormatFloat('0.00', Value);
end;

function HasOperator(strValue : String) : Boolean;
begin
   Result := ( Pos('>', strValue) > 0 ) or ( Pos('<', strValue) > 0 ) or
             ( Pos('=', strValue) > 0 );
end;

function MyRound(Valor : Double; DecimalPlaces : Integer) : Double;
var
  SubValue : Double;
begin
  SubValue := Power(10, DecimalPlaces);
  Result   := (Round(Valor * SubValue))/SubValue;
end;

function AsloToFloat(Aslo: String): Double;
var
  F, Str: String;
  P: Integer;
  First: Boolean;

begin
  // A S L O B E R U T I
  // 1 2 3 4 5 6 7 8 9 0

  // Esta função deverá ser muito foda mesmo.
  // Deverá adivinhar se o sepador de decimal e o ponto ou a virgual.
  // Tudo por causa do MEDIDATA irgh !!!!

  // Se tiver um só separador, ele é o decimal
  // Se existirem vários então o decimal é o ultimo

  Str := Trim(Aslo);
  P := Length(Str);
  First := True;

  while P > 0 do
    begin
      case Str[P] of
        '/': Break;
        'A': F := '1' + F;
        'S': F := '2' + F;
        'L': F := '3' + F;
        'O': F := '4' + F;
        'B': F := '5' + F;
        'E': F := '6' + F;
        'R': F := '7' + F;
        'U': F := '8' + F;
        'T': F := '9' + F;
        'I': F := '0' + F;
        ',', '.':
          begin
            if First then
              begin
                F := '.' + F;
                First := False;
              end;
          end;
      end;
      P := P - 1;
    end;
  Result := MyStrToFloat(F);
end;

procedure IncFloat(var IncDef : Double;
                   Value : Double);
begin
   IncDef := IncDef + Value;
end;

function RetiraSepadorMilhar(StrValue: String): String;
var
  VPos, PPos: Integer;
  RealValue: String;

begin
   VPos := POS(',', StrValue);
   PPos := POS('.', StrValue);

   if  (VPos <> 0) AND (PPos <> 0) then
     begin
       // tenho separador de milhar e decimal
       // O ultimo é o decimal
       if VPos > PPos then
         begin
           // Tenho que retirar o ponto
           RealValue := LeftStr(StrValue, PPos-1) + RightStr(StrValue, Length(StrValue) - PPos);
         end
       else
         begin
           // Tenho que retirar a virgula
           RealValue := LeftStr(StrValue, VPos-1) + RightStr(StrValue, Length(StrValue) - VPos);
         end;
     end
   else
     RealValue := StrValue;

   Result := RealValue;
   
end;

procedure CountToDesired(var aCaixa : TCaixa; TotCash, ValDesired : Double);
var
  i, DivNota, OldCaixa : integer;
  SubTot, SubValor, TotRestante : Double;
  MyNota : Double;
begin
  // Alimenta os totais de notas para chegar no valor mais proximo do Desired
  SubTot := 0;

  // Percorre os totais vendo se a parte menor ainda e maior que ValDesired
  for i := 0 to High(aCaixa) do
    begin
      SubValor := aCaixa[i]*aCaixaPotencia[i];

      TotRestante := TotCash - SubTot - SubValor;
      OldCaixa    := aCaixa[i];

      if TotRestante > ValDesired then
        begin
          // Total de notas restantes ainda e maior que o contado, nao pega nada
          aCaixa[i] := 0;
        end
      else
        begin
          // Total de notas restantes nao e maior que o contado, pega o minimo possivel
          DivNota := Trunc((ValDesired - TotRestante)/aCaixaPotencia[i]);

          MyNota := DivNota;

          // Teste de divisao sem erro
          if Abs(MyNota -
                   ((ValDesired - TotRestante)/aCaixaPotencia[i])) < 0.001 then
             aCaixa[i] := Abs(DivNota)
          else if (DivNota+1) < aCaixa[i] then
             aCaixa[i] := Abs(DivNota+1);
        end;

      SubTot := SubTot + (OldCaixa-aCaixa[i])*aCaixaPotencia[i];
    end;
end;

end.
