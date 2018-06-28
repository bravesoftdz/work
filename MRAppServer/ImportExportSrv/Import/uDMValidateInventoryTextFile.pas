unit uDMValidateInventoryTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMValidateTextFile, DB, ADODB;

type
  TDMValidateInventoryTextFile = class(TDMValidateTextFile)
  private
    function ValidateIsEmpty(Field, Erro: String): Boolean;
    function ValidateQty: Boolean;
    { Private declarations }
  public
    function Validate: Boolean; override;
  end;

var
  DMValidateInventoryTextFile: TDMValidateInventoryTextFile;

implementation

{$R *.dfm}

{ TDMValidateInventoryTextFile }

function TDMValidateInventoryTextFile.Validate: Boolean;
begin
  TextFile.First;
  while not TextFile.Eof do
  begin
    if ValidateIsEmpty('Model','Empty Model') then
      if ValidateIsEmpty('Category','Empty Category') and (ImpExpConfig.Values['UseQty'] = 'Y') then
        ValidateQty;
        
    TextFile.Next;
  end;
  Result := True;
end;

function TDMValidateInventoryTextFile.ValidateIsEmpty(Field,
  Erro: String): Boolean;
begin
  Result := (LinkedColumns.Values[Field] <> '');
  if Result then
    Result := TextFile.FieldByName(LinkedColumns.Values[Field]).AsString <> '';

  TextFile.Edit;
  TextFile.FieldByName('Warning').AsString := '';
  TextFile.FieldByName('Validation').AsBoolean := Result;
  if not Result then
    TextFile.FieldByName('Warning').AsString := Erro;
  TextFile.Post;
end;

function TDMValidateInventoryTextFile.ValidateQty: Boolean;
begin
  try
    Result := ValidateIsEmpty('Qty','Empty Qty');
    if Result then
      StrtoFloat(TextFile.FieldByName(LinkedColumns.Values['Qty']).AsString);
  except
    Result := False;
    TextFile.Edit;
    TextFile.FieldByName('Validation').AsBoolean := Result;
    TextFile.FieldByName('Warning').AsString := 'Qty Invalid';
  end;
end;

end.
