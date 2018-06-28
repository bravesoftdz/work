unit RCADOQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ADODb, uSQLFunctions, uVarianteFunctions;

type
  TRCADOQuery = class(TADOQuery)
  private
    { Private declarations }
    FOriginalSQl : String;
    FKeyFields : String;
    function GetOriginalSQL : String;
  protected
    { Protected declarations }
    procedure DoAfterOpen; override;
    constructor Create(AOwner : TComponent); override;
  public
    { Public declarations }
    ChangeOriginalSQL : Boolean;
    function DeleteLine : Boolean;
    procedure Requery;
    property  OriginalSQL : String read GetOriginalSQl write FOriginalSQl;
  published
    { Published declarations }
    property KeyFields : String read FKeyFields write FKeyFields;
  end;

procedure Register;

implementation

uses uDataBaseFunctions;

constructor TRCADOQuery.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FKeyFields        := '';
  FOriginalSQl      := '';
end;

function TRCADOQuery.GetOriginalSQL : String;
begin
  if FOriginalSQl = '' then
     FOriginalSQl := SQL.Text;

  Result := FOriginalSQl;
end;

procedure TRCADOQuery.DoAfterOpen;
begin
  inherited DoAfterOpen;
  FOriginalSQL := SQL.Text;
end;

procedure TRCADOQuery.Requery;
var
  OldPos : Variant;
begin
  if FKeyFields <> '' then
    OldPos := FieldValues[FKeyFields];

  Close;
  Open;

  if FKeyFields <> '' then
    Locate(FKeyFields, OldPos, []);
end;

function TRCADOQuery.DeleteLine : Boolean;
var
  KeyList : Variant;
  i       : integer;
begin
  if FKeyFields = '' then
    raise exception.Create('Você deve preencher os keyfields para o "DeleteLine" funcionar');

  Result := True;

  with TADOQuery.Create(Self) do
    begin
       SQL.Text := 'DELETE FROM  ' + GetSQLFirstTableName(Self.SQL.Text) + ' ' +
                   'WHERE ';

       KeyList  := ConvVarArray(Self.KeyFields);

       if KeyList = Self.KeyFields then
         begin
           SQL.Text := SQL.Text + Self.KeyFields + ' = ' +
                       ConvSQLValue(Self.FieldByName(Self.KeyFields),
                                    Self.FieldByName(Self.KeyFields).AsString);
         end
       else
         begin
           for i := 1 to VarArrayHighBound(KeyList, 1) do
             begin
               SQL.Text := SQL.Text + KeyList[1] + ' = ' +
                           ConvSQLValue(Self.FieldByName(KeyList[1]),
                                        Self.FieldByName(KeyList[1]).AsString);
               if i < VarArrayHighBound(KeyList, 1) then
                 SQL.Text := SQL.Text + ' AND ';
             end;
         end;

       try
         ExecSQL;
         Self.Requery;
       except
         Result := False;
       end;

       Free;
    end;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TRCADOQuery]);
end;

end.
