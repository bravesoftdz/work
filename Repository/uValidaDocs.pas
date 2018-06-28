unit uValidaDocs;

//------------------------------------------------------------------------------
interface

function ValidaCPF(aCPF: string): Boolean;
function ValidaCNPJ(aCNPJ: string): Boolean;

function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;

function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString;

//------------------------------------------------------------------------------
implementation

uses SysUtils, uStringFunctions;

function ValidaCPF(aCPF: string): Boolean;
var
  cControle: string;
  nDigito, nIni, nFim, I, J: Byte;
  nSoma: Integer;
  iTemp: integer;

  function InListInvalid(const cpf: string): Boolean;
  const
    CPF_Invalid: array[0..9] of string = (
      '00000000000', '11111111111', '22222222222',
      '33333333333', '44444444444', '55555555555',
      '66666666666', '77777777777', '88888888888',
      '99999999999');
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to High(CPF_Invalid) do
      if cpf = CPF_Invalid[i] then
      begin
        Result := True;
        Exit;
      end;
  end;

begin
  nDigito := 14;
  cControle := '';
  nIni := 2;
  nFim := 10;

  aCPF := Trim(aCPF);
  Result := False;

  if Length(aCPF) = 11 then
  begin
    if not InListInvalid(aCPF) then
    begin
      for I := 1 to 2 do
      begin
        nSoma := 0;
        for J := nIni to nFim do
        begin
          iTemp := StrToIntDef(Copy(aCPF, J - I, 1), -1);
          if iTemp = -1 then
            Exit;
          Inc(nSoma, iTemp * (nFim + 1 + I - J));
        end;

        if I = 2 then
          Inc(nSoma, (2 * nDigito));

        nDigito := (nSoma * 10) mod 11;
        if nDigito = 10 then
          nDigito := 0;

        cControle := cControle + Copy(IntToStr(nDigito), 1, 1);
        nIni := 03;
        nFim := 11;
      end;
      Result := Copy(aCPF, Succ(Length(aCPF)-2), 2) = cControle;
    end;
  end;
end;

function ValidaCNPJ(aCNPJ: string): Boolean;

var
  nSoma1, nSoma2: Integer;
  I, nDigito1, nDigito2: Byte;
  V: array[1..14] of Byte;

begin

  aCNPJ := Trim(aCNPJ);
  Result := False;

  if Length(aCNPJ) = 14 then
  begin
    for I := 1 to 14 do
      V[I] := StrToInt(Copy(aCNPJ, I, 1));

    nSoma1 := (V[12] * 2) + (V[11] * 3) + (V[10] * 4) + (V[09] * 5) +
      (V[08] * 6) + (V[07] * 7) + (V[06] * 8) + (V[05] * 9) +
      (V[04] * 2) + (V[03] * 3) + (V[02] * 4) + (V[01] * 5);
    nSoma2 := nSoma1 mod 11;

    if (nSoma2 = 0) or (nSoma2 = 1) then
      nDigito1 := 0
    else
      nDigito1 := 11 - nSoma2;

    nSoma1 := (V[13] * 2) + (V[12] * 3) + (V[11] * 4) + (V[10] * 5) +
      (V[09] * 6) + (V[08] * 7) + (V[07] * 8) + (V[06] * 9) +
      (V[05] * 2) + (V[04] * 3) + (V[03] * 4) + (V[02] * 5) +
      (V[01] * 6);
    nSoma2 := nSoma1 mod 11;

    if (nSoma2 = 0) or (nSoma2 = 1) then
      nDigito2 := 0
    else
      nDigito2 := 11 - nSoma2;

    Result := (LeftStr(IntToStr(nDigito1), 1) + LeftStr(IntToStr(nDigito2), 1)) = RightStr(aCNPJ, 2);

  end;

end;

function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;
begin
  Result := Copy(WideString(AText), 1, ACount);
end;

function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString;
begin
  Result := Copy(WideString(AText), Length(WideString(AText)) + 1 - ACount, ACount);
end;


end.

