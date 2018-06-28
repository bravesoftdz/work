unit uCDSFunctions;

interface

uses SysUtils, DBClient, Classes, DB;

procedure SetCDSIndex(AClientDataSet: TClientDataSet; AName: String; AFields, ADescFields: Array of String);
procedure ClearCDSIndex(AClientDataSet: TClientDataSet);
procedure CreateCDSField(ACDS: TClientDataSet; AName: String; ADataType: TFieldType;
  APosition: Integer; ACreateIndex: Boolean = False; ASize: Integer = -1);

implementation

procedure SetCDSIndex(AClientDataSet: TClientDataSet; AName: String; AFields, ADescFields: Array of String);
var
  I: Integer;
  sFields: String;
  sDescFields: String;
  stlIndexes: TStringList;
begin
  sFields := '';
  sDescFields := '';
  stlIndexes := TStringList.Create;

  try
    AClientDataSet.IndexName := '';
    AClientDataSet.GetIndexNames(stlIndexes);

    for I := 0 to stlIndexes.Count - 1 do
      if (stlIndexes[I] <> 'DEFAULT_ORDER') and (stlIndexes[I] <> 'CHANGEINDEX') then
        AClientDataSet.DeleteIndex(stlIndexes[I]);

    for I := 0 to Pred(Length(AFields)) do
    begin
      if sFields <> '' then
        sFields := sFields + ';';
      sFields := sFields + AFields[I];
    end;

    for I := 0 to Pred(Length(ADescFields)) do
    begin
      if sDescFields <> '' then
        sDescFields := sDescFields + ';';
      sDescFields := sDescFields + ADescFields[I];
    end;


    AClientDataSet.AddIndex(AName, sFields, [ixCaseInsensitive], sDescFields);
    AClientDataSet.IndexName := AName;
  finally
    FreeAndNil(stlIndexes);
  end;
end;

procedure ClearCDSIndex(AClientDataSet: TClientDataSet);
var
  I: Integer;
  sFields: String;
  stlIndexes: TStringList;
begin
  sFields := '';
  stlIndexes := TStringList.Create;

  try
    AClientDataSet.IndexName := '';
    AClientDataSet.GetIndexNames(stlIndexes);

    for I := 0 to stlIndexes.Count - 1 do
      if (stlIndexes[I] <> 'DEFAULT_ORDER') and (stlIndexes[I] <> 'CHANGEINDEX') then
        AClientDataSet.DeleteIndex(stlIndexes[I]);

  finally
    FreeAndNil(stlIndexes);
  end;
end;

procedure CreateCDSField(ACDS: TClientDataSet; AName: String; ADataType: TFieldType;
  APosition: Integer; ACreateIndex: Boolean = False; ASize: Integer = -1);
var
  slFieldList: TStringList;
begin
  try
    slFieldList := TStringList.Create;
    ACDS.FieldDefs.GetItemNames(slFieldList);

    with ACDS do
    begin
      if slFieldList.IndexOf(AName) = -1 then
      begin
        with FieldDefs.AddFieldDef do
        begin
          DataType := ADataType;
          Name := AName;
          if ASize <> -1 then
            Size := ASize;
        end;

        if ACreateIndex then
          with IndexDefs.AddIndexDef do
          begin
            Fields := AName;
            Name := InttoStr(APosition);
          end;
      end;
    end;

  finally
    FreeAndNil(slFieldList);
  end;
end;

end.
