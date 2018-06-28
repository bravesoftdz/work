unit uZipFiles;

interface

uses VCLZip;

type

   TParent = class
      private
         FZip         : TVCLZip;
         FZipFileName : String;
      public
         property ZipFileName : String read FZipFileName write FZipFileName;
         Constructor Create;
         Destructor Destroy; override;
   end;

   TZip = class(TParent)
      private
         FRecurse   : Boolean; //Recurse directories
         FSavePath  : Boolean; //Keep path information
         FPackLevel : Integer; //Highest level of compression = 9


         procedure SetPackLevel(PackLevel : Integer);
      public
         property Recurse   : Boolean read FRecurse   write FRecurse;
         property SavePath  : Boolean read FSavePath  write FSavePath;
         property PackLevel : Integer read FPackLevel write SetPackLevel;

         procedure AddFile(sFileName:String);
         procedure DeleteFile(sFileName:String);

         function Zip : integer;

         Constructor Create;
         Destructor Destroy; override;
   end;

implementation


{--------- TZip ---------}

function TZip.Zip : integer;
begin

  Result := -100;

  if FZip.FilesList.Count > 0 then
     begin
     //Properties
     FZip.Recurse       := FRecurse;
     FZip.StorePaths    := FSavePath;
     FZip.PackLevel     := FPackLevel;
     FZip.ZipName       := FZipFileName;
     FZip.ZipAction     := zaReplace;

     Result := FZip.Zip;
     end;
     
end;

procedure TZip.DeleteFile(sFileName:String);
var
  index : integer;
begin

  index := FZip.FilesList.IndexOf(sFileName);

  if index <> -1 then
     FZip.FilesList.Delete(index);

end;

procedure TZip.AddFile(sFileName:String);
begin

  DeleteFile(sFileName);
  FZip.FilesList.Add(sFileName);

end;

procedure TZip.SetPackLevel(PackLevel : Integer);
begin

   if not (PackLevel in [0..9]) then
      FPackLevel := 9 //Higest
   else
      FPackLevel := PackLevel;

end;

Constructor TZip.Create;
begin
   inherited Create;
   FRecurse   := False;
   FSavePath  := False;
   FPackLevel := 9; //Higest;
end;

Destructor TZip.Destroy;
begin
   inherited Destroy;
end;


{---------- TParent -----------}
Constructor TParent.Create;
begin
   inherited Create;
   FZip := TVCLZip.Create(nil);
end;

Destructor TParent.Destroy;
begin
  FZip.Free;
  inherited Destroy;
end;

end.
