unit uMRParam;

interface

uses Classes, SysUtils, Contnrs;

type
  TMRKey = Class(TObject)
  protected
    FName: String;
    FData: TStringList;

    function GetText: String; virtual;
    function GetAsString: String;
    function GetAsCurrency: Currency;
    function GetAsDate: TDateTime;
    function GetAsDateTime: TDateTime;
    function GetAsInteger: Integer;

    procedure SetText(const Value: String); virtual;
    procedure SetAsString(const Value: String);
    procedure SetAsCurrency(const Value: Currency);
    procedure SetAsDate(const Value: TDateTime);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsInteger(const Value: Integer);

    procedure Init;
    function GetString(Index: Integer): string;
    procedure SetString(Index: Integer; const Value: string);
    function GetValuesCount: integer;
    function GetAsBoolean: boolean;
    procedure SetAsBoolean(const Value: boolean);
    function GetInteger(Index: Integer): integer;
    procedure SetInteger(Index: Integer; const Value: integer);
    function GetBoolean(Index: Integer): boolean;
    procedure SetBoolean(Index: Integer; const Value: boolean);
    function GetCurrency(Index: Integer): Currency;
    procedure SetCurrency(Index: Integer; const Value: Currency);
    function GetDateTime(Index: Integer): TDateTime;
    procedure SetDateTime(Index: Integer; const Value: TDateTime);
  public
    constructor Create(aName: String); overload;
    constructor Create(aName, aValue: String); overload;
    destructor Destroy; override;
    property Name: String read FName write FName;
    property Text: String read GetText write SetText;
    procedure AddString(aValue: String);
    procedure AddInteger(aValue: Integer);
    procedure AddCurrency(aValue: Currency);
    procedure AddBoolean(aValue: Boolean);
    procedure AddDateTime(aValue: TDateTime);

    function HasValue(aValue: integer): boolean; overload;
    function HasValue(aValue: boolean): boolean; overload;
    function HasValue(aValue: Currency): boolean; overload;
    function HasValue(aValue: String): boolean; overload;

    property AsString: String read GetAsString write SetAsString;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsDate: TDateTime read GetAsDate write SetAsDate;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property Strings[Index: Integer]: string read GetString write SetString;
    property Integers[Index: Integer]: integer read GetInteger write SetInteger;
    property Booleans[Index: Integer]: boolean read GetBoolean write SetBoolean;
    property Currencies[Index: Integer]: Currency read GetCurrency write SetCurrency;
    property DateTimes[Index: Integer]: TDateTime read GetDateTime write SetDateTime;
    property ValuesCount: integer read GetValuesCount;
  end;

  TMRParams = class(TObjectList)
  private
    function AddParam(aName: String): TMRKey; overload;
    function AddParam(aName, aValue: String): TMRKey; overload;
    function GetText: String;
    procedure SetText(const Value: String);
  protected
    function GetParam(Index: Integer): TMRKey;
    procedure SetParam(Index: Integer; const Value: TMRKey);
    function GetStringList: TStringList;
  public
    constructor Create; overload;
    constructor Create(aText: String); overload;
    constructor Create(aText: OleVariant); overload;
    destructor Destroy; override;
    function AddKey(aKey: String): TMRKey;
    function KeyByName(aName: String): TMRKey;
    function KeyExists(aKey: String): boolean;
    property Items[Index: Integer]: TMRKey read GetParam write SetParam;
    property ParamString: String read GetText write SetText;
  end;

implementation

uses uNumericFunctions, uDateTimeFunctions;

{ TMRKey }

constructor TMRKey.Create(aName, aValue:String);
begin
  Init;
  FName := aName;
  Text := aValue;
end;

constructor TMRKey.Create(aName: String);
begin
  Init;
  FName := aName;
end;

procedure TMRKey.Init;
begin
  FData := TStringList.Create;
  FData.Delimiter := ',';
end;

destructor TMRKey.Destroy;
begin
  FData.Free;
  inherited;
end;

function TMRKey.GetAsString: String;
begin
  Result := FData.Strings[0];
end;

function TMRKey.GetAsCurrency: Currency;
begin
  Result := SysStrToCurr(FData.Strings[0]);
end;

function TMRKey.GetAsDate: TDateTime;
begin
  Result := Trunc(SysStrToCurr(FData.Strings[0]));
end;

function TMRKey.GetAsDateTime: TDateTime;
begin
  Result := SysStrToCurr(FData.Strings[0]);
end;

function TMRKey.GetAsInteger: Integer;
begin
  Result := StrToInt(FData.Strings[0]);
end;

function TMRKey.GetAsBoolean: boolean;
begin
  Result := StrToBool(FData.Strings[0]);
end;

procedure TMRKey.SetAsString(const Value: String);
begin
  FData.Text := Value;
end;

procedure TMRKey.SetAsCurrency(const Value: Currency);
begin
  FData.Text := SysCurrToStr(Value);
end;

procedure TMRKey.SetAsDate(const Value: TDateTime);
begin
  FData.Text := SysCurrToStr(Trunc(Value));
end;

procedure TMRKey.SetAsDateTime(const Value: TDateTime);
begin
  FData.Text := SysCurrToStr(Value);
end;

procedure TMRKey.SetAsInteger(const Value: Integer);
begin
  FData.Text := IntToStr(Value);
end;

procedure TMRKey.SetAsBoolean(const Value: boolean);
begin
  if Value then
    FData.Text := '1'
  else
    FData.Text := '0';
end;

function TMRKey.GetText: String;
begin
  Result := FData.DelimitedText;
end;

procedure TMRKey.SetText(const Value: String);
begin
  if Value <> ' ' then
    FData.DelimitedText := Value;
end;

function TMRKey.GetString(Index: Integer): string;
begin
  Result := FData.Strings[Index];
end;

procedure TMRKey.SetString(Index: Integer; const Value: string);
begin
  FData.Strings[Index] := Value;
end;

function TMRKey.GetValuesCount: integer;
begin
  Result := FData.Count;
end;

function TMRKey.GetInteger(Index: Integer): integer;
begin
  Result := StrToInt(FData.Strings[Index]);
end;

procedure TMRKey.SetInteger(Index: Integer; const Value: integer);
begin
  FData.Strings[Index] := IntToStr(Value);
end;

function TMRKey.GetBoolean(Index: Integer): boolean;
begin
  Result := StrToBool(FData.Strings[Index]);
end;

procedure TMRKey.SetBoolean(Index: Integer; const Value: boolean);
begin
  FData.Strings[Index] := BoolToStr(Value);
end;

procedure TMRKey.AddBoolean(aValue: Boolean);
begin
  FData.Add(BoolToStr(aValue));
end;

procedure TMRKey.AddDateTime(aValue: TDateTime);
begin
  FData.Add(SysCurrToStr(aValue));
end;

procedure TMRKey.AddInteger(aValue: Integer);
begin
  FData.Add(IntToStr(aValue));
end;

procedure TMRKey.AddString(aValue: String);
begin
  FData.Add(aValue);
end;

procedure TMRKey.AddCurrency(aValue: Currency);
begin
  FData.Add(SysCurrToStr(aValue));
end;

function TMRKey.GetCurrency(Index: Integer): Currency;
begin
  Result := SysStrToCurr(FData.Strings[Index]);
end;

procedure TMRKey.SetCurrency(Index: Integer; const Value: Currency);
begin
  FData.Strings[Index] := SysCurrToStr(Value);
end;

function TMRKey.GetDateTime(Index: Integer): TDateTime;
begin
  Result := MyFormatDateEng(FData.Strings[Index], 'mm/dd/yyyy hh:nn:ss');
end;

procedure TMRKey.SetDateTime(Index: Integer; const Value: TDateTime);
begin
  FData.Strings[Index] := MyFormatDateTime(Value);
end;

function TMRKey.HasValue(aValue: boolean): boolean;
begin
  Result := (FData.IndexOf(BoolToStr(aValue)) <> -1);
end;

function TMRKey.HasValue(aValue: integer): boolean;
begin
  Result := (FData.IndexOf(IntToStr(aValue)) <> -1);
end;

function TMRKey.HasValue(aValue: String): boolean;
begin
  Result := (FData.IndexOf(aValue) <> -1);
end;

function TMRKey.HasValue(aValue: Currency): boolean;
begin
  Result := (FData.IndexOf(SysCurrToStr(aValue)) <> -1);
end;

{ TMRParams }

constructor TMRParams.Create;
begin
  OwnsObjects := True;
end;

constructor TMRParams.Create(aText: String);
begin
  OwnsObjects := True;
  SetText(aText);
end;

constructor TMRParams.Create(aText: OleVariant);
begin
  OwnsObjects := True;
  SetText(aText);
end;

destructor TMRParams.Destroy;
begin
  Clear;
  inherited;
end;

function TMRParams.KeyByName(aName: String): TMRKey;
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

function TMRParams.GetParam(Index: Integer): TMRKey;
begin
  Result := TMRKey(inherited Items[Index]);
end;

function TMRParams.KeyExists(aKey: String): boolean;
begin
  Result := KeyByName(aKey) <> nil;
end;

procedure TMRParams.SetParam(Index: Integer; const Value: TMRKey);
begin
  Items[Index] := Value;
end;

function TMRParams.GetText: String;
var
  i: integer;
begin
  with GetStringList do
  try
    for i := 0 to Self.Count-1 do
      Values[Self.Items[i].Name] := Self.Items[i].Text;
    Result := DelimitedText;
  finally
    Free;
  end;
end;

procedure TMRParams.SetText(const Value: String);
var
  i: integer;
  slTemp: TStringList;
begin
  slTemp := GetStringList;
  Clear;
  try
    slTemp.DelimitedText := Value;
    for i := 0 to slTemp.Count-1 do
      Self.AddParam(slTemp.Names[i], slTemp.ValueFromIndex[i]);
  finally
    slTemp.Free;
  end;
end;

function TMRParams.GetStringList: TStringList;
begin
  Result := TStringList.Create;
  Result.Delimiter := ';';
end;

function TMRParams.AddParam(aName, aValue: String): TMRKey;
begin
  Result := TMRKey.Create(aName, aValue);
  Add(Result);
end;

function TMRParams.AddParam(aName: String): TMRKey;
begin
  Result := TMRKey.Create(aName);
  Add(Result);
end;

function TMRParams.AddKey(aKey: String): TMRKey;
begin
  if KeyExists(aKey) then
    raise Exception.Create('TMRParams.AddKey: Key já existe.');
  Result := AddParam(aKey);
end;

end.
