unit uNTFieldFunctions;

interface

procedure GetParamDefaultValue(var AFields: String; var AField: String; var AValue: Variant);
procedure GetParamFieldValue(var AParams: String; var AField: String);

implementation

procedure GetParamDefaultValue(var AFields: String; var AField: String; var AValue: Variant);
begin
  AField := Copy(AFields, 1, Pos('=', AFields) -1);
  Delete(AFields, 1, Pos('=', AFields));
  AValue  := Copy(AFields, 1, Pos(';', AFields) -1);
  Delete(AFields, 1, Pos(';', AFields));
end;

procedure GetParamFieldValue(var AParams: String; var AField: String);
begin
  AField := Copy(AParams, 1, Pos(';', AParams) -1);
  Delete(AParams, 1, Pos(';', AParams));
end;

end.
