unit Xbase;
{Object Pascal routines that emulate popular xBase routines}
interface

Uses
 SysUtils,
 Windows;

function Max(Num1 : Variant; Num2 : Variant) : Variant;
function Pad(InString: String; Len: Integer): String;
function LPad(InString: String; Len: Integer): String;
function RightStr(cString : String; nLen : integer) : String;
function LeftStr(cString : String; nLen : integer) : String;
function StrZero(nNum : integer; nLen : integer) : String;
function ReplicateStr(cString : String; nLen : integer) : String;
function Space(Len: Integer): String;
function Empty(InString: string): boolean;
function CDOW(InDate : TDateTime) : String;
function nMonth(InDate : TDateTime) : integer;
function CMonth(InDate : TDateTime) : String;
function nDay(InDate : TDateTime) : Integer;
function IsAlpha(InString : String) : Boolean;
function IsDigit(InString : String) : Boolean;
function IsLower(InString : String) : Boolean;
function IsUpper(InString : String) : Boolean;
function RAt(SubString, InString : String) : Integer;
function nYear(InDate : TDateTime) : Word;
function Seconds : Longint;
function SubDateYear(DateIni, DateFim : TDateTime) : String;
function SubDateMonth(DateIni, DateFim : TDateTime) : String;

implementation

function Pad(InString: String; Len: Integer): String;
begin
 Result := Format('%-*s',[Len, InString]);
end;

function LPad(InString: String; Len: Integer): String;
begin
 Result:=Format('%*s',[Len, InString]);
end;

function  RightStr(cString : String; nLen : integer) : String;
begin
   Result := Copy(cString, Succ(Length(cString)-nLen), nLen);
end;

function  LeftStr(cString : String; nLen : integer) : String;
begin
   Result := Copy(cString, 1, nLen);
end;

function  StrZero(nNum : integer; nLen : integer) : String;
begin
   Result := Trim(IntToStr(nNum));
   Result := ReplicateStr('0', nLen-Length(Result)) + Result;
end;

function  ReplicateStr(cString : String; nLen : integer) : String;
var
   i : integer;
begin
   Result := '';
   for i := 1 to nLen do
       Result := Result + cString;
end;

function Space(Len: Integer): String;
begin
 Result := ReplicateStr(' ', Len);
end;

function Empty(InString: string): boolean;
begin
 Result := (Length(InString)=0) or (Trim(InString) = '');
end;

function CDOW(InDate : TDateTime) : String;
begin
 Result:=FormatDateTime('dddd',InDate);
end;

function CMonth(InDate : TDateTime) : String;
begin
 Result := FormatDateTime('mmmm',InDate);
end;

function nMonth(InDate : TDateTime) : integer;
begin
 Result := StrToInt(FormatDateTime('mm',InDate));
end;

function nDay(InDate : TDateTime) : Integer;
begin
 Result:=StrToInt(FormatDateTime('d',InDate));
end;

function IsAlpha(InString : String) : Boolean;
begin
 Result:=(UpCase(InString[1]) in ['A'..'Z']);
end;

function IsDigit(InString : String) : Boolean;
begin
 Result:=(InString[1] in ['0'..'9']);
end;

function IsLower(InString : String) : Boolean;
begin
 Result:=(InString[1] in ['a'..'z']);
end;

function IsUpper(InString : String) : Boolean;
begin
 Result:=(InString[1] in ['A'..'Z']);
end;

function RAt(SubString, InString : String) : Integer;
Var
 I : Integer;
 TempInString, TempSubString : String;
begin
 TempInString:='';
 TempSubString:='';
 {Reverse both strings for use with the Pos function}
 For I:=Length(InString) downto 1 do
  TempInString:=TempInString+InString[I];
 For I:=Length(SubString) downto 1 do
  TempSubString:=TempSubString+SubString[I];
 Result:=Pos(TempSubString,TempInString);
 If Result<>0 then Result:=Succ((Length(InString)-Result)-Pred(Length(InString)));
end;

function nYear(InDate : TDateTime) : Word;
begin
 Result := StrToInt(FormatDateTime('yyyy',InDate));
end;

function Seconds : Longint;
var
 HH, MM, SS, MS : Word;
begin
 DecodeTime(Time,HH,MM,SS,MS);
 Result:=(HH*3600)+(MM*60)+SS;
end;

function SubDateYear(DateIni, DateFim : TDateTime) : String;
begin
  Result := FormatFloat('####0', Int((DateFim-DateIni)/365));
end;

function SubDateMonth(DateIni, DateFim : TDateTime) : String;
begin
  Result := FormatFloat('####0', Int(12*Frac((DateFim-DateIni)/365)));
end;

function Max(Num1 : Variant; Num2 : Variant) : Variant;
begin
  if Num1 > Num2 then
     Result := Num1
  else
     Result := Num2;
end;

end.

