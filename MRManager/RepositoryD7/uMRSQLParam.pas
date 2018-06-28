unit uMRSQLParam;

interface

uses Classes, SysUtils, Contnrs, uMRParam;

const
  FIELD_DELIMITER            = '<@|!$>';
  CONDITION_DELIMITER        = '#@|!$#';
  CONDITION_EQUALS           = 'EQUALS';
  CONDITION_DIFFERENT        = 'DIFFERENT';
  CONDITION_GREATERTHAN      = 'GREATERTHAN';
  CONDITION_LESSTHAN         = 'LESSTHAN';
  CONDITION_GREATERTHANEQUAL = 'GREATERTHANEQUAL';
  CONDITION_LESSTHANEQUAL    = 'LESSTHANEQUAL';
  CONDITION_IN               = 'INLIST';
  CONDITION_NOTIN            = 'NOTINLIST';
  CONDITION_ISNULL           = 'ISNULL';
  CONDITION_ISNOTNULL        = 'ISNOTNULL';
  CONDITION_LIKE             = 'LIKE';
  CONDITION_NOTLIKE          = 'NOTLIKE';
  CONDITION_LIKE_START       = 'START_LIKE';
  CONDITION_NOTLIKE_START    = 'START_NOTLIKE';
  CONDITION_LIKE_END         = 'END_LIKE';
  CONDITION_NOTLIKE_END      = 'END_NOTLIKE';

type
  TMRSQLCondition = (tcEquals, tcDifferent,
                    tcGreaterThan, tcLessThan,
                    tcGreaterThanEqual, tcLessThanEqual,
                    tcIN, tcNotIN,
                    tcIsNull, tcIsNotNull,
                    tcLike, tcNotLike,
                    tcLikeStartWith, tcNotLikeStartWith,
                    tcLikeEndWith, tcNotLikeEndWith);

  TMRSQLKey = Class(TMRKey)
  private
    FCondition: TMRSQLCondition;
    FField: String;
    function GetConditionAsText: String;
    function GetAsSQL: String;
    function RemoveCondition(aValue: String): String;
  protected
    function GetText: String; override;
    procedure SetText(const Value: String); override;
  public
    property Condition: TMRSQLCondition read FCondition write FCondition default tcEquals;
    property Text: String read GetText write SetText;
    property AsSQL: String read GetAsSQL;
    property Field: String read FField write FField; 
  end;

  TMRSQLParam = class(TMRParams)
  private
    function AddParam(aName: String): TMRSQLKey; overload;
    function AddParam(aName, aValue: String): TMRSQLKey; overload;
    function GetParam(Index: Integer): TMRSQLKey;
    procedure SetParam(Index: Integer; const Value: TMRSQLKey);
    function GetText: String;
    procedure SetText(const Value: String);
  public
    function GetWhereSQL: String;
    function AddKey(aKey: String): TMRSQLKey;
    function KeyByName(aName: String): TMRSQLKey;
    procedure DeleteKey(aKey: String);
    property Items[Index: Integer]: TMRSQLKey read GetParam write SetParam;
    property ParamString: String read GetText write SetText;
  end;

implementation

uses uNumericFunctions;

{ TMRSQLKey }

function TMRSQLKey.GetText: String;
begin
  if (Field <> '') then
    Result := Field + FIELD_DELIMITER
  else
    Result := Name + FIELD_DELIMITER;
  Result := Result + GetConditionAsText + CONDITION_DELIMITER;
  //Nao pode usar o DelimitedText, pois ele esta colocando , quando tiver espaco entre os campos
  //Result := Result + FData.DelimitedText;
  Result := Result + Trim(FData.Text);
end;

function TMRSQLKey.GetConditionAsText: String;
begin
  case FCondition of
   tcEquals           : Result := CONDITION_EQUALS;
   tcDifferent        : Result := CONDITION_DIFFERENT;
   tcGreaterThan      : Result := CONDITION_GREATERTHAN;
   tcLessThan         : Result := CONDITION_LESSTHAN;
   tcGreaterThanEqual : Result := CONDITION_GREATERTHANEQUAL;
   tcLessThanEqual    : Result := CONDITION_LESSTHANEQUAL;
   tcIN               : Result := CONDITION_IN;
   tcNotIN            : Result := CONDITION_NOTIN;
   tcIsNull           : Result := CONDITION_ISNULL;
   tcIsNotNull        : Result := CONDITION_ISNOTNULL;
   tcLike             : Result := CONDITION_LIKE;
   tcNotLike          : Result := CONDITION_NOTLIKE;
   tcLikeStartWith    : Result := CONDITION_LIKE_START;
   tcNotLikeStartWith : Result := CONDITION_NOTLIKE_START;
   tcLikeEndWith      : Result := CONDITION_LIKE_END;
   tcNotLikeEndWith   : Result := CONDITION_NOTLIKE_END;
  end;
end;

function TMRSQLKey.GetAsSQL: String;
var
  i: Integer;
  Column, SQLCondition, FieldResult: String;
  QuoteStrResult : Boolean;
begin
  Column := Name;
  Result := '';
  FieldResult := '';

  Case Condition of
   tcEquals           : SQLCondition := ' = ';
   tcDifferent        : SQLCondition := ' <> ';
   tcGreaterThan      : SQLCondition := ' > ';
   tcLessThan         : SQLCondition := ' < ';
   tcGreaterThanEqual : SQLCondition := ' >= ';
   tcLessThanEqual    : SQLCondition := ' <= ';
   tcIN               : SQLCondition := ' in ';
   tcNotIN            : SQLCondition := ' not in ';
   tcIsNull           : SQLCondition := ' is null ';
   tcIsNotNull        : SQLCondition := ' is not null ';
   tcLike             : SQLCondition := ' like ';
   tcNotLike          : SQLCondition := ' not like ';
   tcLikeStartWith    : SQLCondition := ' like ';
   tcNotLikeStartWith : SQLCondition := ' not like ';
   tcLikeEndWith      : SQLCondition := ' like ';
   tcNotLikeEndWith   : SQLCondition := ' not like ';
  end;

  QuoteStrResult := (Condition in [tcLike, tcNotLike, tcLikeStartWith, tcNotLikeStartWith, tcLikeEndWith, tcNotLikeEndWith]);

  if FData.Count = 1 then
  begin
     if QuoteStrResult then
       Result := RemoveCondition(FData[0])
     else
       Result := QuotedStr(RemoveCondition(FData[0]));
  end
  else
    for i := 0 to FData.Count-1 do
      begin
      if Result <> '' then
         Result := Result + ',';
       Result := Result + QuotedStr(RemoveCondition(FData[i]));
      end;

  if (FField <> '') then
    Column := FField;

  if (Result <> '') then
     Case Condition of
       tcEquals,
       tcDifferent,
       tcGreaterThan,
       tcLessThan,
       tcGreaterThanEqual,
       tcLessThanEqual : Result := Column + SQLCondition + Format('%S',[Result]);
       tcIN, tcNotIN   : Result := Column + SQLCondition + Format('(%S)',[Result]);
       tcIsNull,
       tcIsNotNull     : Result := Column + Format('%S',[SQLCondition]);
       tcLike,
       tcNotLike       : begin
                         FieldResult := QuotedStr('%' + Format('%S',[Result]) + '%');
                         Result := Column + SQLCondition + FieldResult;
                         end;
       tcLikeStartWith,
       tcNotLikeStartWith : begin
                         FieldResult := QuotedStr(Format('%S',[Result]) + '%');
                         Result := Column + SQLCondition + FieldResult;
                         end;
       tcLikeEndWith,
       tcNotLikeEndWith : begin
                         FieldResult := QuotedStr('%' + Format('%S',[Result]));
                         Result := Column + SQLCondition + FieldResult;
                         end;

     end;
end;

procedure TMRSQLKey.SetText(const Value: String);
var
  sCondition, sValue : String;
begin

  sValue := Value;

  if Trim(sValue) <> '' then
  begin
    Field := Copy(sValue, 1, Pos(FIELD_DELIMITER, sValue)-1);
    sValue := Copy(sValue, Pos(FIELD_DELIMITER, sValue)+length(FIELD_DELIMITER), length(sValue));

    sCondition := Copy(sValue, 1, Pos(CONDITION_DELIMITER, sValue)-1);


    if sCondition = CONDITION_EQUALS then
      Condition := tcEquals
    else if sCondition = CONDITION_DIFFERENT then
      Condition := tcDifferent
    else if sCondition = CONDITION_GREATERTHAN then
      Condition := tcGreaterThan
    else if sCondition = CONDITION_LESSTHAN then
      Condition := tcLessThan
    else if sCondition = CONDITION_GREATERTHANEQUAL then
      Condition := tcGreaterThanEqual
    else if sCondition = CONDITION_LESSTHANEQUAL then
      Condition := tcLessThanEqual
    else if sCondition = CONDITION_IN then
      Condition := tcIN
    else if sCondition = CONDITION_NOTIN then
      Condition := tcNotIN
    else if sCondition = CONDITION_ISNULL then
      Condition := tcIsNull
    else if sCondition = CONDITION_ISNOTNULL then
      Condition := tcIsNotNull
    else if sCondition = CONDITION_LIKE then
      Condition := tcLike
    else if sCondition = CONDITION_NOTLIKE then
      Condition := tcNotLike
    else if sCondition = CONDITION_LIKE_START then
      Condition := tcLikeStartWith
    else if sCondition = CONDITION_NOTLIKE_START then
      Condition := tcNotLikeStartWith
    else if sCondition = CONDITION_LIKE_END then
      Condition := tcLikeEndWith
    else if sCondition = CONDITION_LIKE_END then
      Condition := tcNotLikeEndWith;

    //Nao pode usar o DelimitedText, pois ele esta colocando , quando tiver espaco entre os campos
    //FData.DelimitedText := Trim(sValue);
    FData.Text := Trim(sValue);
  end;
end;

function TMRSQLKey.RemoveCondition(aValue: String): String;
begin
  Result := Copy(aValue, Pos(CONDITION_DELIMITER, aValue)+6, Length(aValue));
end;

{ TMRSQLParam }

function TMRSQLParam.GetParam(Index: Integer): TMRSQLKey;
begin
  Result := TMRSQLKey(inherited Items[Index]);
end;

function TMRSQLParam.AddKey(aKey: String): TMRSQLKey;
begin
  if KeyExists(aKey) then
    raise Exception.Create('TMRSQLParams.AddKey: Key já existe.');
  Result := AddParam(aKey);
end;

function TMRSQLParam.AddParam(aName, aValue: String): TMRSQLKey;
begin
  Result := TMRSQLKey.Create(aName, aValue);
  Add(Result);
end;

function TMRSQLParam.AddParam(aName: String): TMRSQLKey;
begin
  Result := TMRSQLKey.Create(aName);
  Add(Result);
end;

function TMRSQLParam.GetWhereSQL: String;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to Self.Count-1 do
  begin
    if Trim(Result) <> '' then
      Result := Result + ' AND ';
    Result := Result + TMRSQLKey(Items[i]).GetAsSQL;
  end;
end;

procedure TMRSQLParam.SetParam(Index: Integer; const Value: TMRSQLKey);
begin
  Items[Index] := Value;
end;

procedure TMRSQLParam.DeleteKey(aKey: String);
var
  i: integer;
begin
  for i := 0 to Count-1 do
    if Items[i].Name = aKey then
    begin
      Delete(i);
      Break;
    end;
end;

function TMRSQLParam.KeyByName(aName: String): TMRSQLKey;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
    if Items[i].Name = aName then
    begin
      Result := Items[i];
      Break;
    end;
end;

function TMRSQLParam.GetText: String;
var
  i: integer;
begin
  with GetStringList do
  try
    for i := 0 to Self.Count-1 do
      Values[Self.Items[i].Name] := Self.Items[i].Text;
    //Result := DelimitedText;
    Result := Text;
  finally
    Free;
  end;
end;

procedure TMRSQLParam.SetText(const Value: String);
var
  i: integer;
  slTemp: TStringList;
begin
  slTemp := GetStringList;
  Clear;
  try
    //slTemp.DelimitedText := Value;
    slTemp.Text := Value;
    for i := 0 to slTemp.Count-1 do
      Self.AddParam(slTemp.Names[i], slTemp.ValueFromIndex[i]);
  finally
    slTemp.Free;
  end;
end;


end.
