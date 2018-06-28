unit uSaveToFile;

interface

uses classes;

const
  ERROR_INVALID_PATH  = 0;
  ERROR_EMPTY_PATH    = 1;
  ERROR_BLANK_TEXT    = 2;
  ERROR_CREATING_FILE = 3;

Type

  TSaveFile = Class
     private
        FBodyText : TStringList;
        FPath     : String;
     public
        Constructor Create;
        Destructor Destroy; override;
        property FilePath : String read FPath write FPath;
        procedure AddText(sText : String);
        procedure InsertText(sText:String; iPos:Integer);
        procedure OpenFile;
        function CreateFile:Integer;
  end;

implementation

uses Sysutils;

Constructor TSaveFile.Create;
begin
  inherited Create;
  FBodyText := TStringList.Create;
end;

Destructor TSaveFile.Destroy;
begin
  FBodyText.Free;
  inherited Destroy;
end;

procedure TSaveFile.InsertText(sText:String; iPos:Integer);
begin
  if Trim(sText) <> '' then
     FBodyText.Insert(iPos, sText);
end;

procedure TSaveFile.AddText(sText : String);
begin
  if Trim(sText) <> '' then
     FBodyText.Add(sTExt);
end;

procedure TSaveFile.OpenFile;
var
   fText : TextFile;
begin

   if not FileExists(FPath) then
      Exit;

   Try
     FBodyText.LoadFromFile(FPath);
   Except
     end;

end;

function TSaveFile.CreateFile:Integer;
var
   fText : TextFile;
begin

   Result := -1;

   if FPath = '' then
      begin
      Result := ERROR_EMPTY_PATH;
      Exit;
      end;

   try
     Try
       AssignFile(fText, FPath);
       Rewrite(fText);
       Append(fText);
       Write(fText, FBodyText.Text);
     Except
       Result := ERROR_CREATING_FILE;
     end;
   finally
       CloseFile(fText);
   end;

end;

end.
