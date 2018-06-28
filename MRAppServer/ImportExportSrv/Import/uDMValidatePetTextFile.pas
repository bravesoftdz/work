unit uDMValidatePetTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMValidateTextFile, ADODB;

type
  TDMValidatePetTextFile = class(TDMValidateTextFile)
  private
    IsClientServer: Boolean;
    function ValidateFields: Boolean;
    function ValidateTableField(ATable, AFieldName, AFieldValue : String) : Boolean;
  public
    function Validate: Boolean; override;
  end;

implementation

uses uDMGlobal;

{$R *.dfm}

{ TDMValidatePetTextFile }

function TDMValidatePetTextFile.Validate: Boolean;
begin

  TextFile.First;
  while not TextFile.Eof do
  begin
    Result := ValidateFields;
    TextFile.Next;
  end;

  Result := True;

end;

function TDMValidatePetTextFile.ValidateFields: Boolean;
var
  sMsg : String;
begin

  IsClientServer := DMGlobal.IsClientServer(SQLConnection);
  sMsg := '';

  if not IsClientServer then
  begin
    if ((TextFile.FieldByName('SKU').AsString = '') AND
        (TextFile.FieldByName('Microchip').AsString = '') AND
        (TextFile.FieldByName('Collar').AsString = '')) then
    begin
      sMsg := 'SKU or Microchip or Collar. ';
      Result := False;
    end;

    if (TextFile.FieldByName('Species').AsString = '') or (not ValidateTableField('Pet_Species', 'Species', TextFile.FieldByName('Species').AsString)) then
    begin
      sMsg := sMsg + 'Species. ';
      Result := False;
    end;

    if (TextFile.FieldByName('Breed').AsString = '') then
    begin
      sMsg := sMsg + 'Breed. ';
      Result := False;
    end;
  end
  else
  begin
    sMsg := 'Replication Database!';
    Result := False;
  end;

  if (sMsg <> '') then
  begin
    TextFile.Edit;
    TextFile.FieldByName('Warning').AsString := 'Error: Invalid field(s) [' + sMsg + ']';
    TextFile.FieldByName('Validation').AsBoolean := Result;
    TextFile.Post;
  end;
  
end;

function TDMValidatePetTextFile.ValidateTableField(ATable,
  AFieldName, AFieldValue : String): Boolean;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := SQLConnection;

    FQuery.SQL.Add('SELECT ' + AFieldName);
    FQuery.SQL.Add('FROM ' + ATable);
    FQuery.SQL.Add('WHERE '+AFieldName+' = :' + AFieldName);
    FQuery.Parameters.ParamByName(AFieldName).Value := AFieldValue;
    FQuery.Open;
    Result := not FQuery.IsEmpty;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

end.
