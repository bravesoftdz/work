unit PowerADOQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  ADODB, Variants;

type
  TPowerADOQuery = class(TADODataSet)
  private
    { Private declarations }
    FOriginalSQl : String;
    FKeyFields : String;

    FFilterFields : TStringList; { campos do filtro }
    FFilterValues : TStringList; { valores do filtro }
    procedure SetFilterFields(Value : TStringList);
    procedure SetFilterValues(Value : TStringList);
    function GetOriginalSQL : String;
  protected
    { Protected declarations }
    procedure DoAfterOpen; override;
    procedure DoOnNewRecord; override;
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    ChangeOriginalSQL : Boolean;

    procedure ClearFilters;
    procedure AddFilter(aFields, aValues : array of string);

    procedure Requery;
    property  OriginalSQL : String read GetOriginalSQl write FOriginalSQl;

  published
    { Published declarations }
    property FilterFields  : TStringList read FFilterFields write SetFilterFields;
    property FilterValues  : TStringList read FFilterValues write SetFilterValues;

    procedure ClearSuggest;
    procedure AddSuggest(sField: String; aValue: variant);

    property KeyFields : String read FKeyFields write FKeyFields;
  end;

procedure Register;

implementation

constructor TPowerADOQuery.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFilterFields := TStringList.Create;
  FFilterValues := TStringList.Create;

  FKeyFields        := '';
  FOriginalSQl      := '';
end;

destructor TPowerADOQuery.Destroy;
begin
  FFilterFields.Free;
  FFilterValues.Free;
  inherited Destroy;
end;

procedure TPowerADOQuery.Requery;
var
  OldPos : Variant;
begin
//  if FKeyFields <> '' then
//    OldPos := FieldValues[FKeyFields];

  Close;
  Open;

//  if FKeyFields <> '' then
//    Locate(FKeyFields, OldPos, []);
end;


procedure TPowerADOQuery.DoAfterOpen;
begin
  inherited DoAfterOpen;
  FOriginalSQL := CommandText;
end;

function TPowerADOQuery.GetOriginalSQL : String;
begin
  if FOriginalSQl = '' then
     FOriginalSQl := CommandText;

  Result := FOriginalSQl;
end;


procedure TPowerADOQuery.DoOnNewRecord;
var
   i : byte;
begin
  inherited DoOnNewRecord;
  // no append deve ser mostrado o provável novo código

  // Seta os campos defaults do filtro
  with FFilterFields do
    if Count > 0 then
      for i := 0 to ( Count -1 ) do
        begin
          // Testa a troca de 0/1 por False/True
          if FieldByName(Strings[i]).DataType = ftBoolean then
             begin
              if FFilterValues.Strings[i] = '0' then
                FieldByName(Strings[i]).AsBoolean := False
              else if FFilterValues.Strings[i] = '1' then
                FieldByName(Strings[i]).AsBoolean := True
              else
                FieldByName(Strings[i]).AsString := FFilterValues.Strings[i];
            end
          else
            begin
              FieldByName(Strings[i]).AsString := FFilterValues.Strings[i];
            end;
        end;
end;

procedure TPowerADOQuery.SetFilterFields(Value : TStringList);
begin
  if FFilterFields <> Value then
     FFilterFields.Assign(Value);
end;

procedure TPowerADOQuery.SetFilterValues(Value : TStringList);
begin
  if FFilterValues <> Value then
     FFilterValues.Assign(Value);
end;


procedure TPowerADOQuery.ClearFilters;
begin
  FFilterFields.Clear;
  FFilterValues.Clear;
end;

procedure TPowerADOQuery.ClearSuggest;
begin
  FFilterFields.Clear;
  FFilterValues.Clear;

end;

procedure TPowerADOQuery.AddSuggest(sField: String; aValue: variant);
begin
  FFilterFields.Add(sField);
  FFilterValues.Add(VarToStr(aValue));

end;

procedure TPowerADOQuery.AddFilter(aFields, aValues : array of string);
var
   i : integer;
begin
  ClearFilters;
  if High(aFields) <> High(aValues) then
     raise exception.create('erro na passagem do filtro')
  else
    begin
     for i := Low(aFields) to High(aFields) do
       begin
         FilterFields.Add(aFields[i]);
         FilterValues.Add(aValues[i]);
       end;
    end;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TPowerADOQuery]);
end;

end.
