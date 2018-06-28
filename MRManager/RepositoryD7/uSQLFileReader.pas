unit uSQLFileReader;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Dialogs, StdCtrls;

{ TReadSQLScript class }

type
  TReadSQLScript = class
  private
    fFileStrings: TStrings;
    fScriptStrings: TStrings;
    fFlag: string;
    fIndex: Integer;
    fScriptCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    function GetSQLScript: string;
    function GetSQL : String;
    procedure SetSQL(SQL:String);
    procedure Next;
    property Flag: string read fFlag write fFlag;
    property Index: Integer read fIndex write fIndex;
    property ScriptCount: Integer read fScriptCount write fScriptCount;
  end;


implementation

constructor TReadSQLScript.Create;
begin
  fFileStrings := TStringList.Create;
  fScriptStrings := TStringList.Create;
end;

destructor TReadSQLScript.Destroy;
begin
  fFileStrings.Free;
  fScriptStrings.Free;
  inherited;
end;

function TReadSQLScript.GetSQL : String;
begin
  Result := fFileStrings.Text;
end;

procedure TReadSQLScript.SetSQL(SQL:String);
begin
  fFileStrings.Text := SQL;
end;

procedure TReadSQLScript.LoadFromFile(const FileName: string);
var
  F: TextFile;
  sTemp: string;
begin
  if fFlag = '' then raise Exception.Create('Flag not defined.');
  AssignFile(F, FileName);
  Reset(F);
  try
    fFileStrings.Clear;
    fScriptCount := 0;
    fIndex       := 0;
    while not Eof(F) do
    begin
      Readln(F, sTemp);
      fFileStrings.Append(sTemp);
      if sTemp = fFlag then
        Inc(fScriptCount);
    end;
  finally
    CloseFile(F);
  end;
end;

function TReadSQLScript.GetSQLScript: string;
var
  I: Integer;
  str: string;
  Strings: TStrings;
begin
  Result := '';
  if fIndex > -1 then
  begin
    fScriptStrings.Clear;
    str := fFileStrings[fIndex];
    while (str <> fFlag) and (fIndex < fFileStrings.Count) do
    begin
      fScriptStrings.Append(str);
      Inc(fIndex);
      str := fFileStrings[fIndex];
    end;
    Result := Trim(fScriptStrings.Text);
  end;
end;

procedure TReadSQLScript.Next;
begin
  if fIndex > -1 then
  begin
    Inc(fIndex);
    if fIndex >= (fFileStrings.Count -1) then
      fIndex := -1;
  end;
end;


end. 
