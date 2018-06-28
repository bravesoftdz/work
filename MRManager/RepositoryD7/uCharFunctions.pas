unit uCharFunctions;

interface

function IsDigit(ch: char): boolean;
function IsUpper(ch: char): boolean;
function IsLower(ch: char): boolean;
function ToUpper(ch: char): char;
function ToLower(ch: char): char;
function ValidateQty(cKey:Char):Char;
function ValidateCurrency(cKey:Char):Char;
function ValidatePositiveCurrency(cKey:Char):Char;
function ValidateNumbers(cKey:Char):Char;
function ValidateFloats(cKey:Char):Char;
function ValidateDouble(cKey:Char):Char;



implementation

uses Windows;

function IsDigit(ch: char): boolean;
begin
  Result := ch in ['0'..'9'];
end;

function IsUpper(ch: char): boolean;
begin
  //To determine if the character is an uppercase letter.
  Result := ch in ['A'..'Z'];
end;

function IsLower(ch: char): boolean;
begin
  //To determine if the character is an lowercase letter.
  Result := ch in ['a'..'z'];
end;

function ToUpper(ch: char): char;
begin
  //Changes a character to an uppercase letter.
  Result := chr(ord(ch) and $DF);
end;

function ToLower(ch: char): char;
begin
  //Changes a character to a lowercase letter.
  Result := chr(ord(ch) or $20);
end;

function ValidateNumbers(cKey:Char):Char;
begin

 if not (cKey IN ['0'..'9',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;

end;

function ValidateDouble(cKey:Char):Char;
begin
 if not (cKey IN ['0'..'9','.',',','-',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;
end;


function ValidateFloats(cKey:Char):Char;
begin
 if not (cKey IN ['0'..'9',',','.',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;
end;

function ValidatePositiveCurrency(cKey:Char):Char;
begin
 if not (cKey IN ['0'..'9',',','.',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;
end;

function ValidateCurrency(cKey:Char):Char;
begin

 if not (cKey IN ['0'..'9','-',',','.',#8]) then
    begin
    Result:=#0;
    MessageBeep($FFFFFFFF);
    end
 else
    Result:=cKey;

end;

function ValidateQty(cKey:Char):Char;
begin

  if not (cKey IN ['0'..'9','-',#8]) then
     begin
     Result:=#0;
     MessageBeep($FFFFFFFF);
     end
  else
     Result:=cKey;

end;

end.
