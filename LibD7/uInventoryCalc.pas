unit uInventoryCalc;

interface

uses uNumericFunctions, SysUtils, Classes, Math;

const
  ROUNDING_TYPE_UP     = 1;
  ROUNDING_TYPE_DOWN   = 2;
  ROUNDING_TYPE_NEARST = 3;

type
  TPriceRound = class
  private
    FSalePrice: Currency;
    FRoundAction: Integer;
    FRoundValues: array of Double;

    sIntRoundValue: String;
    dRoundValue, iFracSalePrice, Calc: Double;
    iTruncSalePrice : Integer;

    procedure SetRoundValues(ARoundValues: String);
    procedure SetVariables;
    function GetUpRoudedValue: Currency;
    function GetDownRoudedValue: Currency;
    function GetNearstRoudedValue: Currency;
  public
    constructor Create(ASalePrice: Currency; ARoundAction: Integer; ARoundValues: String);
    destructor Destroy;
    function RoundSalePrice: Currency;
  end;

  TPriceMargem = class
  private
    FCostPrice: Currency;
    FMargemPercent: Currency;
  public
    constructor Create(APrice, APercent: Currency);
    function CalcMargem: Currency;
  end;

  TPriceMarkup = class
  private
    FCostPrice: Currency;
    FMarkupPercent: Currency;
  public
    constructor Create(APrice, APercent: Currency);
    function CalcMarkup: Currency;
  end;

implementation

{ TPriceRound }

constructor TPriceRound.Create(ASalePrice: Currency; ARoundAction: Integer;
  ARoundValues: String);
begin
  FSalePrice   := ASalePrice;
  FRoundAction := ARoundAction;
  SetRoundValues(ARoundValues);
  SetVariables;
end;

destructor TPriceRound.Destroy;
begin
 //
end;

function TPriceRound.GetDownRoudedValue: Currency;
var
  sSalePrice: String;
  dDownRoundedValue, SalePricePart : Double;
  i : Integer;
begin

  dRoundValue := FRoundValues[0];

  if sIntRoundValue = '0' then
  begin

    if (Length(FRoundValues) > 1) and (iFracSalePrice > Frac(FRoundValues[0])) then
    begin
      for i := 0 to Length(FRoundValues) - 2 do
        if (iFracSalePrice >= Frac(FRoundValues[i])) and (iFracSalePrice <= Frac(FRoundValues[i+1])) then
          dRoundValue := FRoundValues[i]
    end
    else if iFracSalePrice <= Frac(FRoundValues[0]) then
    begin
      dRoundValue := FRoundValues[Length(FRoundValues)-1];
      iTruncSalePrice := iTruncSalePrice - 1;
    end;

    dDownRoundedValue := iTruncSalePrice + Frac(dRoundValue);

    if dDownRoundedValue > 0 then
      Result := dDownRoundedValue
    else
      Result := FRoundValues[0];

  end
  else
  begin

    SalePricePart := MyStrToDouble(Copy(MyFloatToStr(FSalePrice),Length(MyFloatToStr(FSalePrice)) - (Length(sIntRoundValue) + 2),Length(sIntRoundValue) + 3));

    if (Length(FRoundValues) > 1) and (SalePricePart > FRoundValues[0]) then
    begin
      for i := 0 to Length(FRoundValues) - 2 do
        if (SalePricePart > FRoundValues[i]) and (SalePricePart < FRoundValues[i+1]) then
          dRoundValue := FRoundValues[i]
    end
    else if SalePricePart < FRoundValues[0] then
    begin
      dRoundValue := FRoundValues[Length(FRoundValues)-1];
      iTruncSalePrice := Trunc((iTruncSalePrice - Calc) - iTruncSalePrice mod Trunc(Calc));
    end;

    Result :=  iTruncSalePrice - (iTruncSalePrice mod Trunc(Calc)) + dRoundValue;

  end;
end;

function TPriceRound.GetNearstRoudedValue: Currency;
var
  sSalePrice: String;
  dDownRoundedValue, Differ, BestDiffer: Double;
  i : Integer;
begin

  if sIntRoundValue = '0' then
  begin

    for i := 0 to Length(FRoundValues) - 1 do
    begin
      Differ := abs((FRoundValues[i] * power(10,2)) - (iFracSalePrice * power(10,2)) );
      if (i = 0) or (Differ < BestDiffer)  then
      begin
        BestDiffer := Differ;
        dRoundValue := FRoundValues[i];
      end;
    end;

    Differ := (iFracSalePrice * power(10,2)) + (100 - (FRoundValues[Length(FRoundValues)-1] * power(10,2)));

    Differ := StrToFloat(FormatFloat('00000', Differ));
    BestDiffer := StrToFloat(FormatFloat('00000', BestDiffer));

    if (Differ < BestDiffer) then
    begin
      dRoundValue := FRoundValues[Length(FRoundValues)-1];
      dDownRoundedValue := iTruncSalePrice - 1 + Frac(dRoundValue);

      if dDownRoundedValue > 0 then
        Result := dDownRoundedValue
      else
        Result := FRoundValues[0];
    end
    else
      Result := iTruncSalePrice + Frac(dRoundValue);
  end
  else
  begin
    for i:= 0 to Length(FRoundValues) - 1 do
    begin
      Differ := StrtoInt(InttoStr(Trunc(FRoundValues[i])) + Copy(MyFloatToStr(Frac(FRoundValues[i])),3,2)) - iTruncSalePrice;

      if (i = 0) or (Differ < BestDiffer)  then
      begin
        BestDiffer := Differ;
        dRoundValue := FRoundValues[i];
      end;
    end;

    BestDiffer := ((iTruncSalePrice - iTruncSalePrice mod Trunc(Calc)) + Trunc(dRoundValue)) - iTruncSalePrice;

    Differ := Trunc(FSalePrice) -
              (((iTruncSalePrice - Calc) - iTruncSalePrice mod Trunc(Calc)) + FRoundValues[Length(FRoundValues)-1]);

    if (Differ < BestDiffer) then
    begin
      dRoundValue := FRoundValues[Length(FRoundValues)-1];
      dDownRoundedValue := ((iTruncSalePrice - Calc) - iTruncSalePrice mod Trunc(Calc)) + dRoundValue;
      Result := dDownRoundedValue;
   end
    else
      Result := ((iTruncSalePrice - iTruncSalePrice mod Trunc(Calc)) + dRoundValue);

  end;
end;

function TPriceRound.GetUpRoudedValue: Currency;
var
  sSalePrice: String;
  SalePricePart : Double;
  i : Integer;
begin

  dRoundValue := FRoundValues[0];

  if sIntRoundValue = '0' then begin
     //Antonio 04/11/2016
     //if (Length(FRoundValues) > 1) and (iFracSalePrice <= FRoundValues[Length(FRoundValues)-1]) then begin
     if (Length(FRoundValues) >= 1) and (iFracSalePrice <= FRoundValues[Length(FRoundValues)-1]) then begin
           for i := 0 to Length(FRoundValues) - 2 do begin
              if (iFracSalePrice >= Frac(FRoundValues[i])) and (iFracSalePrice <= Frac(FRoundValues[i+1])) then
                 dRoundValue := FRoundValues[i+1]
              else if iFracSalePrice >= FRoundValues[Length(FRoundValues)-1] then begin
                      dRoundValue := FRoundValues[0];
                      iTruncSalePrice := iTruncSalePrice + 1;
                   end;
           end;

           Result := iTruncSalePrice + Frac(dRoundValue);
     end;
  end else begin
           SalePricePart := MyStrToDouble(Copy(MyFloatToStr(FSalePrice),Length(MyFloatToStr(FSalePrice)) - (Length(sIntRoundValue) + 2),Length(sIntRoundValue) + 3));

           if (Length(FRoundValues) > 1) and (SalePricePart < FRoundValues[Length(FRoundValues)-1]) then begin
               for i := 0 to Length(FRoundValues) - 2 do
                   if (SalePricePart > FRoundValues[i]) and (SalePricePart < FRoundValues[i+1]) then
                      dRoundValue := FRoundValues[i+1]
           end else if SalePricePart > FRoundValues[Length(FRoundValues)-1] then begin
                       dRoundValue := FRoundValues[0];
                       iTruncSalePrice := Trunc((iTruncSalePrice - Calc) + iTruncSalePrice mod Trunc(Calc));
                    end;

           sSalePrice := FloatToStr(FSalePrice);
           sSalePrice := Copy(sSalePrice, 1, Length(IntToStr(iTruncSalePrice)) - Length(sIntRoundValue));
           Result := StrToFloat(sSalePrice + FloatToStr(dRoundValue));

      end;
end;

function TPriceRound.RoundSalePrice: Currency;
begin
  case FRoundAction of
    ROUNDING_TYPE_UP    : Result := GetUpRoudedValue;
    ROUNDING_TYPE_DOWN  : Result := GetDownRoudedValue;
    ROUNDING_TYPE_NEARST: Result := GetNearstRoudedValue;
  end;
end;

procedure TPriceRound.SetRoundValues(ARoundValues: String);
var
  sRoundValue: String;
begin
  while ARoundValues <> '' do
  begin
    if Pos(';', ARoundValues) > 0 then
    begin
      sRoundValue := Copy(ARoundValues, 1, Pos(';', ARoundValues)-1);
      ARoundValues := Copy(ARoundValues, Pos(';', ARoundValues)+1, Length(ARoundValues));
    end
    else
    begin
      sRoundValue := ARoundValues;
      ARoundValues := '';
    end;

    SetLength(FRoundValues, Length(FRoundValues)+1);
    FRoundValues[Length(FRoundValues)-1] := MyStrToDouble(sRoundValue);
  end;
end;

procedure TPriceRound.SetVariables;
begin
  iTruncSalePrice := Trunc(FSalePrice);
  iFracSalePrice  := Frac(FSalePrice);
  dRoundValue     := FRoundValues[Length(FRoundValues)-1];
  sIntRoundValue  := IntToStr(Trunc(dRoundValue));
  Calc := power(10 , length(InttoStr(iTruncSalePrice)) - 2 );
end;

{ TPriceMargem }

constructor TPriceMargem.Create(APrice, APercent: Currency);
begin
 FCostPrice := APrice;
 FMargemPercent := APercent;
end;

function TPriceMargem.CalcMargem: Currency;
begin
  //Cálculo antigo.
  //Result := fCostPrice + (floor(fCostPrice * fMargemPercent)/100); 

  //Novo Cálculo.
  Result := (fCostPrice / (100 - fMargemPercent) ) * 100;
  Result := Round(Result *  100.0) / 100.0
end;

{ TPriceMarkup }

function TPriceMarkup.CalcMarkup: Currency;
begin
  Result := FCostPrice * (1 + (FMarkupPercent / 100));
  Result := Round(Result *  100.0) / 100.0;
end;

constructor TPriceMarkup.Create(APrice, APercent: Currency);
begin
  FCostPrice := APrice;
  FMarkupPercent := APercent;
end;

end.
