unit uStringFunctions;

interface

uses Sysutils, classes, graphics, xBase, uLanguageFunctions, uCharFunctions,
     stdctrls;

// Strings
procedure SplitMemo(MText: String; MWidth: Integer; var MSplit: TStringList);
procedure SplitMemoCanvas(MText: String; MWidth: Integer; MCanvas: TCanvas; var MSplit: TStringList);
function RemoveUserText(S: String): String;
function RetiraAcento(S: String): String;
function Extenso(Valor: Currency): String;
function Replace(sOriginal, sOld, sNew: String): String;
function SPC(T: integer): string;
function AD(S: String; T: Integer): String;
function AC(S: String; T: Integer): String;
function AE(S: String; T: Integer): String;
function Compr: String;
function DesCompr: String;
function MontaLocal(Mascara, Espaco, Armario, Prateleira, Gaveta: String): String;
function FixStrPlic(MyString : String) : String;
function Proper(const s: string): string;
function IsStrNumber(const s: string) : Boolean;
function IdentRight(Len : integer; s: string) : String;
function GetFirstName(s: string) : String;
function GetLastName(s: string) : String;
function AcertaNome(s: string) : String;
procedure IncMemoTxt(var Memo : TMemo; Texto : String);
procedure IncString(var IncStr : String; Texto : String);
function ChangeBolStr(MyChar : String) : String;
function IsNull(Entrada, Saida: String): String;
function CountChar(cChar:Char; sText : String):integer;
function CountStr(str, substr : string):integer;
function ValueLocatedInList(List:TStringList; sValue:String):Integer;

implementation

function ValueLocatedInList(List:TStringList; sValue:String):Integer;
begin

   if Assigned(List) then
      Result := List.IndexOf(sValue)
   else
      Result := -1;

end;


function CountChar(cChar:Char; sText : String):integer;
var
  i : integer;
begin
 Result := 1;
 for i:=0 to Length(sText) do
     if sText[i] = cChar then
        inc(Result);
end;

function CountStr(str, substr : string):integer;
var
  NewStr    : string;
  LastFound : integer;
begin
  NewStr :='';
  Result :=0;
  LastFound:=Pos(substr, str);

  while LastFound > 0 do
    begin
    Result := Result + 1;
    NewStr:=NewStr+copy(str, 1, LastFound-1)+'';
    str:=Copy(str, LastFound+Length(substr), Length(str)-LastFound+Length(substr));
    LastFound:=Pos(substr, str);
    end;

end;


procedure SplitMemo(MText: String; MWidth: Integer; var MSplit: TStringList);
var
  NewLine: String;
  NewSplit: Integer;

begin

  NewLine := MText;

  while NewLine <> '' do
    begin

      // Procura pela primeira quebra pre existente
      NewSplit := Pos(#13, NewLine);

      // Se nao achou, ou nao tem ou ela está depois do tamanho maximo,
      // vou diminuindo até um espaço
      if (NewSplit > MWidth) or (NewSplit = 0) then
        begin

          if MWidth <= Length(NewLine) then
            begin
              NewSplit := MWidth;
              while (NewLine[NewSplit] <> ' ')
                    and
                    (NewSplit <> 1)
                    and
                    (NewSplit<Length(NewLine)) do
                Dec(NewSplit);

              if NewSplit = 1 then
                NewSplit := MWidth;
            end
          else
            begin
              NewSplit := Length(NewLine);
            end;

        end;

      MSplit.Add(Trim(LeftStr(NewLine, NewSplit)));
      NewLine := Trim(RightStr(NewLine, Length(NewLine) - NewSplit));
    end;

end;

procedure SplitMemoCanvas(MText: String; MWidth: Integer; MCanvas: TCanvas; var MSplit: TStringList);
   function GetLength(S:String; W: Integer; C: TCanvas): Integer;
   var
     i: integer;
   begin
     i := Length(S);
     while C.TextWidth(LeftStr(S, i)) > W do
       Dec(i);
     Result := i-1;
   end;

var
  NewLine: String;
  NewSplit: Integer;

begin

  NewLine := MText;

  while NewLine <> '' do
    begin

      // Procura pela primeira quebra pre existente
      NewSplit := Pos(#13, NewLine);

      if NewSplit = 0 then
        NewSplit := Length(NewLine);

      // Se nao achou, ou nao tem ou ela está depois do tamanho maximo,
      // vou diminuindo até um espaço
      if (MCanvas.TextWidth(LeftStr(NewLine, NewSplit)) > MWidth) then
        begin
          NewSplit := GetLength(NewLine, MWidth, MCanvas);

          while (NewLine[NewSplit] <> ' ')
                and
                (NewSplit <> 1)
                and
                (NewSplit<Length(NewLine)) do
            Dec(NewSplit);

          if NewSplit = 1 then
            NewSplit := GetLength(NewLine, MWidth, MCanvas);
        end
      else
        begin
          NewSplit := Length(NewLine);
        end;

      MSplit.Add(Trim(LeftStr(NewLine, NewSplit)));
      NewLine := RightStr(NewLine, Length(NewLine) - NewSplit);
    end;

  // Descartas as linhas finais vazias
  with MSplit do
    if Count > 0 then
      while Trim(Strings[Count-1])='' do
        Delete(Count-1);
end;

function RemoveUserText(S: String): String;
var
  i: integer;
  Aberto: Boolean;
  NewS: String;

begin
  NewS := '';
  Aberto := False;

  for i := 1 to Length(S) do
    begin
      if (S[i] = #39) or (S[i] = #34) then
        Aberto := NOT Aberto;

      if Aberto then
        NewS := NewS + 'X'
      else
        NewS := NewS + S[i];
    end;

  Result := NewS;

end;

function RetiraAcento(S: String): String;
var
  i, j: Integer;

begin
   Result := S;

   for j := Length(S) downto 1 do
     begin
       for i := 0 to High(aAcento) do
         begin
           if UpperCase(S[J]) = UpperCase(aAcento[i, 1]) then
             begin
               Result[j] := aAcento[i, 0][1];
             end;
         end;
     end;
end;

function Extenso(Valor: Currency): String;

    // Funcao secundária que monta a centena
    function Centena(Grupo: Double): String;
    var
      Centenas, dezenas, unidades: Double;
      New: String;

    begin
      Centenas := Trunc(Trunc(Grupo) / 100);
      Dezenas  := Trunc(Trunc(Grupo - Trunc(Centenas * 100)) / 10);
      Unidades := Trunc(Grupo - Trunc(Centenas * 100) - Trunc(Dezenas * 10));

      Result := '';

      // centenas
      case Trunc(Centenas) of
        1:
          begin
            if Grupo = 100 then
              Result := 'cem'
            else
              Result := 'cento';
          end;
        2: Result := 'duzentos';
        3: Result := 'trezentos';
        4: Result := 'quatrocentos';
        5: Result := 'quinhentos';
        6: Result := 'seiscentos';
        7: Result := 'setecentos';
        8: Result := 'oitocentos';
        9: Result := 'novecentos';
      end;

      New := '';
      // dezenas
      case Trunc(Dezenas) of
        1:
          begin
            case Trunc(Unidades) of
              0: New := 'dez';
              1: New := 'onze';
              2: New := 'doze';
              3: New := 'treze';
              4: New := 'quatorze';
              5: New := 'quinze';
              6: New := 'dezeseis';
              7: New := 'dezesete';
              8: New := 'dezoito';
              9: New := 'dezenove';
            end;
          end;
        2: New := 'vinte';
        3: New := 'trinta';
        4: New := 'quarenta';
        5: New := 'cinquenta';
        6: New := 'sessenta';
        7: New := 'setenta';
        8: New := 'oitenta';
        9: New := 'noventa';
      end;

      if New <> '' then
        begin
          if Result = '' then
            Result := New
          else
            Result := Result + ' e ' + New;
        end;

      New := '';

      // Unidades
      if Dezenas <> 1 then
        begin
          case Trunc(Unidades) of
            1: New := 'um';
            2: New := 'dois';
            3: New := 'tres';
            4: New := 'quatro';
            5: New := 'cinco';
            6: New := 'seis';
            7: New := 'sete';
            8: New := 'oito';
            9: New := 'nove';
          end;
        end;

      if New <> '' then
        begin
          if Result = '' then
            Result := New
          else
            begin
              if dezenas <> 2 then
                Result := Result + ' e ' + New
              else
                Result := Result + ' ' + New;
            end;
        end;
    end;

// Funcao principal
var
  Milhoes, Milhares, Centenas, Centavos: Double;
  NewMilhoes, NewMilhares, NewCentenas, NewCentavos: String;
begin

  NewMilhoes := '';
  NewMilhares := '';
  NewCentenas := '';
  NewCentavos := '';

  Milhoes :=  Trunc(Valor/1000000);
  Milhares := Trunc((Trunc(Valor)-(Milhoes*1000000))/1000);
  Centenas := Trunc(Valor - (Milhoes*1000000) - (Milhares*1000));
  Centavos := Trunc((Valor - (Milhoes*1000000) - (Milhares*1000) - Centenas)*100);


  // milhoes
  case Trunc(Milhoes) of
    1: NewMilhoes := Centena(Milhoes) + ' milhao';
    2..999: NewMilhoes := Centena(Milhoes) + ' milhoes';
  end;

  // milhares
  case Trunc(Milhares) of
    1: NewMilhares := Centena(Milhares) + ' mil';
    2..999: NewMilhares := Centena(Milhares) + ' mil';
  end;

  // Centenas
  case Trunc(Centenas) of
    1: NewCentenas := Centena(Centenas);
    2..999: NewCentenas := Centena(Centenas);
  end;

  // Centavos
  case Trunc(centavos) of
    1: NewCentavos := Centena(Centavos) + ' centavo';
    2..99: NewCentavos := Centena(Centavos) + ' centavos';
  end;

  Result := '';

  if NewMilhoes <> '' then
    begin
      Result := NewMilhoes;
    end;

  if NewMilhares <> '' then
    begin
      if Result = '' then
        Result := NewMilhares
      else
        Result := Result + ', ' + NewMilhares;
    end;

  if NewCentenas <> '' then
    begin
      if Result = '' then
        Result := NewCentenas
      else
        Result := Result + ', ' + NewCentenas;
    end;

  // Coloca a moeda Correta
  case Trunc(Centenas + Milhares * 1000 + Milhoes * 1000000) of
    0: ;
    1: Result := Result + ' real';
    else Result := Result + ' reais';
  end;

  if NewCentavos <> '' then
    begin
      if Result = '' then
        Result := NewCentavos
      else
        Result := Result + ' e ' + NewCentavos;
    end;

  // Ajusta o case e coloca um terminador
  if Result <> '' then
    Result := UpperCase(Result[1]) + RightStr(Result, Length(Result)-1) + '.'
  else
    Result := 'Zero reais.';

end;

function Replace(sOriginal, sOld, sNew: String): String;
var
  slPos: TStringList;
  iOldLen, iNewLen: integer;
  i, j: integer;
  FixedPos: integer;

begin
  // Init
  slPos := TStringList.Create;

  iOldLen := Length(sOld);
  iNewLen := Length(sNew);

  Result := sOriginal;

  // Procura por todas as ocorrencias de sOld em sOriginal
  for i := 0 to Length(sOriginal) do
    if UpperCase(Copy(sOriginal, i, iOldLen)) = UpperCase(sOld) then
      slPos.Add(IntToStr(i));

  // Vou trocando um por um
  for j := 0 to slPos.Count-1 do
    begin
      // Como o sOld pode nao ter o mesmo tamanho de sNew devo recalcular POS
      FixedPos := StrToInt(slPos[j]) + (j*(iNewLen-iOldLen));

      Delete(Result, FixedPos, iOldLen);
      Insert(sNew, Result, FixedPos);
    end;

  slPos.Free;
end;

function SPC(T: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to T do
    Result := Result + ' ';
end;

function AD(S: String; T: Integer): String;
begin
  // Alinha a Direita
  Result := '                                                     ' +
            '                                                     ' +
            '                                                     ' +
            '                                                     ' + S;

  Result := RightStr(Result, T);
end;

function AC(S: String; T: Integer): String;
begin
  // Alinha ao Centro
  Result := S;

end;

function AE(S: String; T: Integer): String;
begin
  // Alinha a esquerda
  Result := S + '                                                     ' +
                '                                                     ' +
                '                                                     ' +
                '                                                     ';

  Result := LeftStr(Result, T);
end;

function Compr: String;
begin
  Result := #15;

end;

function DesCompr: String;
begin
  Result := #18;

end;

function MontaLocal(Mascara, Espaco, Armario, Prateleira, Gaveta: String): String;
var
  S: String;
  R, E, A, P, G: String;
  Ei, Ai, Pi, Gi: integer;
begin
  R := Mascara;

  Gi := Pos('%G%', R);

  // Estante
  E := '';
  Ei := Pos('%E%', R);
  if (Ei <> 0) AND (Espaco <> '') then
    E := Copy(R, 1, Ei-1) + Espaco;

  R := RightStr(R, Length(R)-Ei-2);

  // Armario
  A := '';
  Ai := Pos('%A%', R);
  if (Ai <> 0) AND (Armario <> '') then
    A := Copy(R, 1, Ai-1) + Armario;

  R := RightStr(R, Length(R)-Ai-2);

  // Prateleira
  P := '';
  Pi := Pos('%P%', R);
  if (Pi <> 0) AND (Prateleira <> '') then
    P := Copy(R, 1, Pi-1) + Prateleira;

  R := RightStr(R, Length(R)-Pi-2);

  // Gavetas
  G := '';
  Gi := Pos('%G%', R);
  if (Gi <> 0) AND (Gaveta <> '') then
    G := Copy(R, 1, Gi-1) + Gaveta;

  R := RightStr(R, Length(R)-Pi-2);

  R := E + A + P + G;

  // Retiro virgulas e espaços que possam existir no inicio
  if length(R) > 0 then
    if R[1] = ',' then
      R := Copy(R, 2, Length(R)-1);

  Result := Trim(R);
end;

function FixStrPlic(MyString : String) : String;
var
   Cont   : Integer;
   NewStr : String;
begin
   MyString := Trim(MyString);
   NewStr   := '';

   for Cont := 1 to Length(MyString) do
     begin
       if MyString[Cont] = Chr(39) then
          NewStr := NewStr + MyString[Cont] + Chr(39)
       else
          NewStr := NewStr + MyString[Cont];
     end;

  Result   := NewStr;
end;

function ContStr(Search, Text : String) : Integer;
var
   i, TotFound : integer;
begin
   TotFound := 0;
   for i := 1 to Length(Text) do
       if Text[i] = Search then
          Inc(TotFound);
   Result := TotFound;
end;

function Proper(const s: string): string;
var
  i: Integer;
  CapitalizeNextLetter: Boolean;
begin
  Result := LowerCase(s);
  CapitalizeNextLetter := True;
  for i := 1 to Length(Result) do
  begin
    if CapitalizeNextLetter and IsLower(Result[i]) then
      Result[i] := ToUpper(Result[i]);
    CapitalizeNextLetter := Result[i] = ' ';
  end;
end;

function IsStrNumber(const s: string) : Boolean;
var
   TestValue : Real;
   Code      : Integer;
begin
    Val(s, TestValue, Code);
    Result := (Code = 0);
end;

function IdentRight(Len : integer; s: string) : String;
begin
  Result := RightStr(Space(Len) + Trim(s), Len);
end;

function GetFirstName(s: string) : String;
var
  i : integer;
begin
  // Muda a ordem no nome de LastName + FirstName pata FirstName + LastName

  s := Trim(s);
  i := Pos(',', s);

  if i > 0 then
     Result := RightStr(s, Length(s)-i)
  else
    Result  := s;
end;

function GetLastName(s: string) : String;
var
  i : integer;
begin
  // Muda a ordem no nome de LastName + FirstName pata FirstName + LastName

  s := Trim(s);
  i := Pos(',', s);

  if i > 0 then
     Result := LeftStr(s, i-1)
  else
    Result  := '';
end;

function AcertaNome(s: string) : String;
var
  i : integer;
  First, Last : String;
begin
  // Muda a ordem no nome de LastName + FirstName pata FirstName + LastName

  s := Trim(s);
  i := Pos(',', s);

  if i > 0 then
    begin
     Last   := LeftStr(s, i-1);
     First  := RightStr(s, Length(s)-i);

     Result := First + ' ' + Last;
    end
  else
    Result  := s;
end;

procedure IncMemoTxt(var Memo : TMemo; Texto : String);
begin
     Memo.Text := Memo.Text + Texto;
end;

procedure IncString(var IncStr : String; Texto : String);
begin
     IncStr := IncStr + Texto;
end;

function ChangeBolStr(MyChar : String) : String;
begin
  if MyChar = 'S' then
     Result := 'N'
  else
     Result := 'S';
end;

function IsNull(Entrada, Saida: String): String;
begin
  if Entrada = '' then
    Result := Saida
  else
    Result := Entrada;
end;

end.
