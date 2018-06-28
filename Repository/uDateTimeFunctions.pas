unit uDateTimeFunctions;

interface

uses Sysutils, uMsgBox;


Type
   TEnglishShortMonth   = array[1..12] of String;
   TEnglishLongMonth    = array[1..12] of String;
   TEnglishShortDay     = array[1..7] of String;
   TEnglishLongDay      = array[1..7] of String;

   TPortuguesShortMonth = array[1..12] of String;
   TPortuguesLongMonth  = array[1..12] of String;
   TPortuguesShortDay   = array[1..7] of String;
   TPortuguesLongDay    = array[1..7] of String;

   TEspanholShortMonth  = array[1..12] of String;
   TEspanholLongMonth   = array[1..12] of String;
   TEspanholShortDay    = array[1..7] of String;
   TEspanholLongDay     = array[1..7] of String;


Const
  L_ENGLISH    = 1;
  L_PORTUGUESE = 2;
  L_SPANISH    = 3;


  AEnglishShortMonth : TEnglishShortMonth = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
  AEnglishLongMonth  : TEnglishLongMonth  = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
  AEnglishShortDay   : TEnglishShortDay   = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
  AEnglishLongDay    : TEnglishLongDay    = ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');


  APortuguesShortMonth : TPortuguesShortMonth = ('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez');
  APortuguesLongMonth  : TPortuguesLongMonth  = ('Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
  APortuguesShortDay   : TPortuguesShortDay   = ('Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb');
  APortuguesLongDay    : TPortuguesLongDay    = ('Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'sábado');

  AEspanholShortMonth : TEspanholShortMonth = ('Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic');
  AEspanholLongMonth  : TEspanholLongMonth  = ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');
  AEspanholShortDay   : TEspanholShortDay   = ('Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb');
  AEspanholLongDay    : TEspanholLongDay    = ('Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado');


// Datas
function MyStrToDate(DateStr : String) : TDateTime;
function TestDate(DateStr : String) : Boolean;
function ShowPeriodo(DataIni, DataFim : String) : String;
function FirstDateMonth : TDateTime;
function LastDateMonth  : TDateTime;
function InicioMes(MyDate: TDateTime): TDateTime;
function FimMes(MyDate: TDateTime): TDateTime;
function InicioSemana(MyDate: TDateTime): TDateTime;
function FimSemana(MyDate: TDateTime): TDateTime;
function GetPrimeiroDomingo(Ano: Integer): TDateTime;
function ValidTwoDates(DataIni, DataFim: String):Boolean;
function WeekDayName(dDate:TDateTime):String;
procedure ChangeLocalSetings(Lang:Integer);

//function AjustaVencimento(Vencimento: TDateTime): TDateTime;

implementation

procedure ChangeLocalSetings(Lang:Integer);
var
  i : Integer;
begin

   Case Lang of
      L_ENGLISH :
          begin
          for i:=1 to 12 do
             begin
             ShortMonthNames[i] := AEnglishShortMonth[i];
             LongMonthNames[i]  := AEnglishLongMonth[i];
             end;
          for i:=1 to 7 do
             begin
             ShortDayNames[i] := AEnglishShortDay[i];
             LongDayNames[i]  := AEnglishLongDay[i];
             end;
          end;
      L_PORTUGUESE :
          begin
          for i:=1 to 12 do
             begin
             ShortMonthNames[i] := APortuguesShortMonth[i];
             LongMonthNames[i]  := APortuguesLongMonth[i];
             end;
          for i:=1 to 7 do
             begin
             ShortDayNames[i] := APortuguesShortDay[i];
             LongDayNames[i]  := APortuguesLongDay[i];
             end;
          end;
      L_SPANISH :
          begin
          for i:=1 to 12 do
             begin
             ShortMonthNames[i] := AEspanholShortMonth[i];
             LongMonthNames[i]  := AEspanholLongMonth[i];
             end;
          for i:=1 to 7 do
             begin
             ShortDayNames[i] := AEspanholShortDay[i];
             LongDayNames[i]  := AEspanholLongDay[i];
             end;
          end;
   end;

end;

function  MyStrToDate(DateStr : String) : TDateTime;
begin
   try
      Result := StrToDate(DateStr);
   except
      Result := Date;
   end;
end;

function  TestDate(DateStr : String) : Boolean;
begin
  if DateStr = '' then
    begin
     Result := False;
     Exit;
    end;

   try
      StrToDate(DateStr);
      Result := True;
   except
      Result := False;
   end;
end;

function ShowPeriodo(DataIni, DataFim : String) : String;
begin
  Result := 'Período de ' + DataIni + ' a ' + DataFim;
end;

function FirstDateMonth : TDateTime;
var
  Day, Month, year : Word;
begin
  DecodeDate(Date, Year, Month, Day);
  Result := EncodeDate(Year, Month, 1);
end;

function LastDateMonth : TDateTime;
var
  Day, Month, year : Word;
begin
  DecodeDate(Date, Year, Month, Day);
  if Month = 12 then
     Result := EncodeDate(Year+1, 1, 1) - 1
  else
     Result := EncodeDate(Year, Month+1, 1) - 1;
end;

function InicioMes(MyDate: TDateTime): TDateTime;
var
  Year, Month, Day: word;
begin
  DecodeDate(Date(), Year, Month, Day);
  Result := EncodeDate(Year, Month, 1);
end;

function FimMes(MyDate: TDateTime): TDateTime;
var
  Year, Month, Day: word;
begin
  DecodeDate(Date(), Year, Month, Day);

  if Month = 12 then
    begin
      Month := 1;
      Year := Year + 1;
    end
  else
    Month := Month + 1;

  Result := EncodeDate(Year, Month, 1) -1;

end;

function InicioSemana(MyDate: TDateTime): TDateTime;
begin
  Result := MyDate - DayOfWeek(MyDate);
end;

function FimSemana(MyDate: TDateTime): TDateTime;
begin
  Result := MyDate - DayOfWeek(MyDate) + 6;
end;

function GetPrimeiroDomingo(Ano: Integer): TDateTime;
begin
  Result := EncodeDate(Ano, 1, 1)
               + (8 - DayOfWeek(EncodeDate(Ano, 1, 1)));
end;

function ValidTwoDates(DataIni, DataFim: String):Boolean;
begin
// Validar a date
Result := True;
  if NOT TestDate(DataIni) then
    begin
      MsgBox('Invalid Start Date!', vbOkOnly + vbCritical);
      Result := False;
      Exit;
    end;

  if NOT TestDate(DataFim) then
    begin
      MsgBox('Invalid Final Date!', vbOkOnly + vbCritical);
      Result := False;
      Exit;
    end;

  if StrToDate(DataFim) <  StrToDate(DataIni) then
    begin
      MsgBox('Final Date is smaller than Inicial Date!', vbOkOnly + vbCritical);
      Result := False;
      Exit;
    end;

end;

function WeekDayName(dDate:TDateTime):String;
var
  days: array[1..7] of string;
begin
  days[1] := 'Sunday';
  days[2] := 'Monday';
  days[3] := 'Tuesday';
  days[4] := 'Wednesday';
  days[5] := 'Thursday';
  days[6] := 'Friday';
  days[7] := 'Saturday';

  result  := days[DayOfWeek(dDate)]
end;



end.
