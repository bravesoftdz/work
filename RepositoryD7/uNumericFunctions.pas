unit uNumericFunctions;

interface

uses Sysutils, Math, Windows, uSystemTypes, Dialogs;

// Antonio M F Souza, December 04, 2012
function prepareStrToFloat(value: Extended): String;

// Antonio M F Souza November 25, 2012
function getDisplayFormat(pDecimalPlaces: Integer): String;
function CountDecimalPlaces(value: Extended): Integer;

function ValidateFloat(cKey: Char): Char;
function ValidateCurrency(cKey: Char): Char;

function MyStrToFloat(strValue: String): Extended;
function MyStrToCurrency(strValue: String): Currency;
function MyStrToInt(strValue: String): Integer;
function MyFloatToStr(Value: Double; ADecimalFormat: String = '0.00' ): String;
function HasOperator(strValue: String): Boolean;
function MyRound(Valor: Double; DecimalPlaces: Integer): Double;
function TruncMoney(Valor: Double; DecimalPlaces: Integer): Double;
function forceRoundInThirdPosition(value: extended; decimal_places: Integer = 2): extended;
function TruncCurrency(AValue: Currency; Decimal: Integer;
                       ARoundMode: TFPURoundingMode = rmDown): Currency;
function TruncDecimal(Valor: Real; Decimal: integer): Double;
function AsloToFloat(Aslo: String): Double;
procedure IncFloat(var IncDef : Double; Value : Double);
function RetiraSepadorMilhar(StrValue: String): String;
function MyFormatCur(Value: Double; Decimal: Char):String;
function MyStrToMoney(strValue: String): Currency;
function MyStrToDouble(strValue: String): Double;overload;
function MyStrToDouble(strValue : String; DS: Char) : Double;overload;
function MyFormatTax(Value:Double;Decimal:Char):String;
function MyFormatDouble(Value:Double; Decimal:Char):String;
function IsNegative(fValue:Double):Boolean;
function HasDecimal(fValue : Double) : Boolean;
// Funcao que calcula a combinacao de moedas para o Caixa
procedure CountToDesired(var aCaixa : TCaixa; TotCash, ValDesired : Double);
function IsValidInteger(S: String): Boolean;

// 12-07-2006 Max: new functions
function SysStrToCurr(Value: String): Currency;
function SysCurrToStr(Value: Currency): String; overload;
function SysCurrToStr(Value: Currency; Decimal: Char): String; overload;

function ValorExtenso(valor: real): string;

//Antonio M F Souza, December 14 2012: forceRound to 2 decimal places only
function forceRoundTwoDecimals(value: extended): extended;

// Antonio M F Souza, December 19 2012: round like database.
function roundLikeDatabase(pValue: extended; pDecimals: integer): extended;

implementation

uses xBase, uDm;

// Antonio M F Souza, December 19 2012: Round like database.
function roundLikeDatabase(pValue: extended;  pDecimals: integer): extended;
var
  factor, fraction: extended;
begin
  factor := IntPower(10, pDecimals);
  pValue := strToFloat(floatToStr(pValue * factor));
  result := int(pValue);

  fraction := frac(pValue);

  if ( fraction >= 0.5 ) then begin
     result := result + 1;
  end
  else if ( fraction <= -0.5 ) then begin
     result := result - 1
  end;

  result := result / factor;

end;



//Antonio M F Souza, December 14 2012: forceRound to 2 decimal places only
function forceRoundTwoDecimals(value: extended): extended;
var
  tempValue: extended;
  fracValue: extended;
  valueStr: String;
begin
  valueStr := prepareStrToFloat(value);
  tempValue := strToFloat(valueStr);
  tempValue := ( value * 10 );
  fracValue := frac(tempValue);

  if ( fracValue >= 0.5 ) then begin
     tempValue := tempValue * 10;
     tempValue := trunc(tempValue);
     tempValue := tempValue / 10;
  end
  else begin
     tempValue := tempValue * 10;
     tempValue := trunc(tempValue);
     tempValue := ( tempValue / 100 );
  end;

  result := tempValue;

end;


function prepareStrToFloat(value: Extended): String;
var
  valueStr: String;
  commaPosition: Integer;
begin
  valueStr := formatFloat('#,##0.00', value);
  commaPosition    := pos(',', valueStr);
  if ( commaPosition > 0 ) then
       delete(valueStr, commaPosition, 1);
  result := valueStr;
end;



function getDisplayFormat(pDecimalPlaces: Integer): String;
begin
   case pDecimalPlaces of
       2: result := '0.00';
       3: result := '0.000';
       4: result := '0.0000';
       else
          result := '0.00';   // = 2
   end;
end;


function CountDecimalPlaces(value: Extended): Integer;
var
  valueStr: String;
  decimalPosition: Integer;
begin
  result := 2;
  valueStr := getDisplayFormat(dm.FQtyDecimal);

  decimalPosition := pos('.', valueStr);

  if ( decimalPosition > 0 ) then
     result := length(copy(valueStr, decimalPosition + 1, dm.FQtyDecimal ));

end;

function ValorExtenso(valor: real): string;
var
  Texto, Milhar, Centena, Centavos, msg: string;

Const
  Unidades: array[1..9] of string = ('Um', 'Dois', 'Tres', 'Quatro', 'Cinco', 'Seis', 'Sete', 'Oito', 'Nove');
  Dez: array[1..9] of string = ('Onze', 'Doze', 'Treze', 'Quatorze', 'Quinze', 'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
  Dezenas: array[1..9] of string = ('Dez', 'Vinte', 'Trinta', 'Quarenta', 'Cinquenta', 'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
  Centenas: array[1..9] of string = ('Cento', 'Duzentos', 'Trezentos', 'Quatrocentos', 'Quinhentos', 'Seiscentos', 'Setecentos', 'Oitocentos', 'Novecentos');
  MoedaSigular = 'Real';
  MoedaPlural = 'Reais';
  CentSingular = 'Centavo';
  CentPlural = 'Centavos';
  Zero = 'Zero';

////////////////////////////////fucao auxiliar extenso////////////////////////////////
  function ifs(Expressao: Boolean; CasoVerdadeiro, CasoFalso: String): String;
    begin
      if Expressao then
      Result:=CasoVerdadeiro
      else
      Result:=CasoFalso;
  end;

////////////////////////////funcao auxiliar extenso/////////////////////////
  function MiniExtenso (trio: string): string;
    var
      Unidade, Dezena, Centena: string;
    begin
      Unidade:='';
      Dezena:='';
      Centena:='';
      if (trio[2]='1') and (trio[3]<>'0') then
        begin
          Unidade:=Dez[strtoint(trio[3])];
          Dezena:='';
        end
      else
        begin
          if trio[2]<>'0' then Dezena:=Dezenas[strtoint(trio[2])];
          if trio[3]<>'0' then Unidade:=Unidades[strtoint(trio[3])];
      end;
      if (trio[1]='1') and (Unidade='') and (Dezena='') then
        Centena:='Cem'
      else
        if trio[1]<>'0' then
          Centena:=Centenas[strtoint(trio[1])]
        else Centena:='';
      Result:= Centena + ifs((Centena<>'') and ((Dezena<>'') or (Unidade<>'')), ' e ', '')
      + Dezena + ifs((Dezena<>'') and (Unidade<>''),' e ', '') + Unidade;
  end;

begin
  if (valor>999999.99) or (valor<0) then
    begin
      msg := 'O valor está fora do intervalo permitido.';
      msg := msg+'O número deve ser maior ou igual a zero e menor que 999.999,99.';
      msg := msg+' Se não for corrigido o número não será escrito por extenso.';
      Result := '';
      exit;
    end;
  if valor = 0 then
    begin
      Result := '';
      Exit;
  end;

  Texto := formatfloat('000000.00',valor);
  Milhar := MiniExtenso(Copy(Texto,1,3));
  Centena := MiniExtenso(Copy(Texto,4,3));
  Centavos := MiniExtenso('0'+Copy(Texto,8,2));
  Result := Milhar;

  if Milhar <> '' then
    begin
      if copy(texto,4,3)='000' then
        Result := Result+' Mil Reais'
      else
        Result := Result+' Mil, ';
  end;

  if (((copy(texto,4,2) = '00') and (Milhar <> '') and (copy(texto,6,1) <> '0'))) or (centavos = '00') and (milhar <> '')  then
    Result := Result + ' e ';

  if (Milhar + Centena <> '') then
    Result := Result + Centena;

  if (Milhar = '') and (copy(texto,4,3) = '001') then
    Result:=Result+' Real'
  else if (copy(texto,4,3) <> '000') then
    Result:=Result+' Reais';

  if Centavos = '' then
  begin
    Result := Result + '.';
    Exit;
  end
  else
  begin
    if (Milhar + Centena = '') then
      Result := Centavos
    else
      Result := Result + ', e ' + Centavos;
  end;
  if (copy(texto,8,2) = '01') and (Centavos <> '') then
      Result := Result + ' Centavo.'
  else
      Result := Result + ' Centavos.';

end;

function IsNegative(fValue:Double):Boolean;
begin
  Result := (fValue>=0);
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

function MyFormatTax(Value:Double;Decimal:Char):String;
var
  OldDecimalSeparator: Char;
begin
  OldDecimalSeparator  := DecimalSeparator;
  DecimalSeparator := Decimal;
  Result := FormatCurr('0.0000',Value);
  DecimalSeparator := OldDecimalSeparator;
end;

function MyStrToDouble(strValue : String) : Double;
var
  OldDecimalSeparator: Char;
begin

  if Trim(strValue) = '' then
     begin
     Result := 0;
     Exit;
     end;

  OldDecimalSeparator := DecimalSeparator;

  try

    DecimalSeparator := '.';

    if OldDecimalSeparator = ',' then
       begin
       strValue := StringReplace(strValue,'.','',[rfReplaceAll	]);
       strValue := StringReplace(strValue,',','.',[rfReplaceAll	]);
       end
    else
       strValue := StringReplace(strValue,',','',[rfReplaceAll	]);

    try
      Result := StrToFloat(strValue);
    except
       Result := 0;
       end;
    finally
      DecimalSeparator := OldDecimalSeparator;
      end;

end;


function MyStrToMoney(strValue:String) : Currency;
var
  OldDecimalSeparator: Char;
begin

  if Trim(strValue) = '' then
     begin
     Result := 0;
     Exit;
     end;
  OldDecimalSeparator  := DecimalSeparator;
  try

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

function ValidateCurrency(cKey:Char):Char;
begin
  if not (cKey IN ['0'..'9','-','.',',',#8]) then
  begin
    Result := #0;
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

function MyFloatToStr(Value: Double; ADecimalFormat: String = '0.00' ): String;
begin
  Result := FormatFloat(ADecimalFormat, Value);
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

function HasDecimal(fValue : Double) : Boolean;
var
  sValue : String;
  iPos : Integer;
begin
  sValue := FormatFloat('###0.0000',fValue);
  iPos := Pos(DecimalSeparator, sValue);

  if iPos > 0 then
    Result := (StrToInt(Copy(sValue, iPos + 1, Length(sValue))) > 0)
  else
    Result := False;
end;

function TruncMoney(Valor: Double; DecimalPlaces: Integer): Double;
var
  SubValue : Double;
begin
  Result := 0;
  if Valor = 0 then
    Exit;
  SubValue := Power(10, DecimalPlaces);
  if HasDecimal(Valor * SubValue) then
    Result   := (Trunc(Valor * SubValue))/SubValue
  else
    Result   := (Valor * SubValue)/SubValue;
end;

function TruncDecimal(Valor: Real; Decimal: integer): Double;
var
  aux: string;
  bNeg : Boolean;
begin

  bNeg := False;

  if Valor < 0 then
    bNeg := True;

  valor := Abs(valor);
  valor := valor * 100000;
  aux := FormatFloat('00000000000000000000',valor);
  aux := copy( aux, 1, 15) + copy( aux, 16, Decimal);
  case Decimal of
    2: valor := strToFloat(aux) / 100;
    3: valor := strToFloat(aux) / 1000;
    4: valor := strToFloat(aux) / 10000;
    5: valor := strToFloat(aux) / 100000;
  end;

  if bNeg then
    valor := valor * -1;

  result := Valor;

end;

function TruncCurrency(AValue: Currency; Decimal: Integer;
                       ARoundMode: TFPURoundingMode = rmDown): Currency;
var
  OldRoundMode: TFPURoundingMode;
begin

  OldRoundMode := GetRoundMode;
  try
    SetRoundMode(ARoundMode);
    Result := RoundTo(AValue, Decimal);
  finally
    SetRoundMode(OldRoundMode);
  end;

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

function IsValidInteger(S: String): Boolean;
begin
  try
    StrToInt(S);
    Result := True;
  except
    Result := False;
  end;
end;

function MyFormatDouble(Value:Double; Decimal:Char):String;
var
  OldDecimalSeparator: Char;
begin
  OldDecimalSeparator  := DecimalSeparator;
  DecimalSeparator := Decimal;
  Result := FormatCurr('0.#####',Value);
  DecimalSeparator := OldDecimalSeparator;
end;


function MyStrToDouble(strValue : String; DS: Char) : Double;
var
  OldDecimalSeparator: Char;
begin
  if Trim(strValue) = '' then
  begin
    Result := 0;
    Exit;
  end;

  OldDecimalSeparator := DecimalSeparator;

  try
    DecimalSeparator := DS;
    try
      Result := MyStrToDouble(strValue);
    except
       Result := 0;
    end;
  finally
    DecimalSeparator := OldDecimalSeparator;
  end;
end;

function SysStrToCurr(Value: String): Currency;
var
  FFormat: TFormatSettings;
begin
  FFormat.DecimalSeparator := '.';
  Result := StrToFloat(Value, FFormat);
end;

function SysCurrToStr(Value: Currency): String;
begin
  Result := SysCurrToStr(Value, '.');
end;

function SysCurrToStr(Value: Currency; Decimal: Char): String;
var
  FFormat: TFormatSettings;
begin
  FFormat.DecimalSeparator := Decimal;
  Result := FormatCurr('0.00', Value);
end;

function forceRoundInThirdPosition(value: extended; decimal_places: Integer): extended;
var
  valueRounded: extended;
  addDecimal: extended;
begin
  // notes: decimal places doesn't use any more
  // Antonio M F Souza 14, November 2012
  valueRounded := 0;
  if ( value <> 0 ) then
     valueRounded := (value * 100 + ifThen(value > 0, 0.5, -0.5))/100;
  // Antonio M F Souza November 11, 2012: function above is explained below.
{
  if ( value > 0 ) then
      addDecimal := 0.5
  else
      addDecimal := -0.5;

  valueRounded := trunc((value * 100) + addDecimal)/100;
 }
  result := valueRounded;

end;



end.
