unit uMainRetailTransferData;

interface

Uses SysUtils, Variants, Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, DBClient, AbBase, AbBrowse,
  AbZBrows, AbZipper, AbArcTyp;


type
  TMRZipFile = class
    AbZipper: TAbZipper;
    public
      function ZipFile(AFile : String) : String;
      constructor Create;
      destructor Destroy; override;
  end;

  TMRFTPTransfer = class
      FDeleteFileAfterSend : Boolean;
      FZipFile : Boolean;
      FTP: TIdFTP;
      BkpFTP: TIdFTP;
      FTimeOut: Integer;
      function SendBkpFile(AFile : String):Boolean;
    public
      procedure setTimeOut(arg_value: Integer);
      function getTimeOut(): Integer;
      function SendFile(AFile : String; ASendBkp : Boolean):Boolean;
      constructor Create;
      destructor Destroy; override;
  end;


implementation

{ TMRFTPTransfer }

constructor TMRFTPTransfer.Create;
begin

  FTP := TIdFTP.Create(nil);
  BkpFTP := TIdFTP.Create(nil);

  with FTP do
  begin
    Host     := 'uploads.pinogy.com';
    Username := '360uploads';
    Password := 'x8EyMD_%';
    Port     := 21;
  end;

  with BkpFTP do
  begin
    Host     := 'vulcan.pinogy.net';
    Username := '360uploads';
    Password := 'x8EyMD_%';
    Port     := 21;
  end;

end;

destructor TMRFTPTransfer.Destroy;
begin
  FTP.Disconnect;
  BkpFTP.Disconnect;

  FreeAndNil(FTP);
  FreeAndNil(BkpFTP);
  inherited;
  inherited;
end;

function TMRFTPTransfer.getTimeOut: Integer;
begin
  result := FTimeOut;
end;

function TMRFTPTransfer.SendBkpFile(AFile: String): Boolean;
var
  Zip : TMRZipFile;
  sXMLFile, sZIPFile : String;
begin

  Result := False;

  try
    if FileExists(AFile) then
    begin

      with BkpFTP do
      try
        Connect(True, FTimeOut);
        ChangeDir('Data');
        if Connected then
        begin
          Put(AFile, ExtractFileName(AFile), True);
          Result := True;
        end
      finally
        Disconnect;
      end;

    end;

  except
    Result := False;
  end;

end;

function TMRFTPTransfer.SendFile(AFile: String; ASendBkp : Boolean): Boolean;
var
  Zip : TMRZipFile;
  sXMLFile, sZIPFile : String;
begin

  Result := False;

  try
    if FileExists(AFile) then
    begin
      sXMLFile  := AFile;
      sZIPFile  := '';

      if FZipFile then
      try
        Zip      := TMRZipFile.Create;
        sZIPFile := Zip.ZipFile(sXMLFile);
        AFile    := sZIPFile;
      finally
        FreeAndNil(Zip);
      end;

      with FTP do
      try
        Connect(True, FTimeOut);
        if Connected then
        begin
          Put(AFile, ExtractFileName(AFile), True);
          Result := True;
        end
      finally
        Disconnect;
      end;
      
      if ASendBkp then
        SendBkpFile(AFile);

    end;
  finally
    if FDeleteFileAfterSend then
    begin
      if FileExists(sXMLFile) then
        DeleteFile(sXMLFile);
      if FileExists(sZIPFile) then
        DeleteFile(sZIPFile);
    end;
  end;

end;

procedure TMRFTPTransfer.setTimeOut(arg_value: Integer);
begin
  FTimeOut := arg_value;
end;

{ TMRZipFile }

constructor TMRZipFile.Create;
begin
  AbZipper := TAbZipper.Create(nil);
end;

destructor TMRZipFile.Destroy;
begin
  FreeAndNil(AbZipper);
  inherited;
end;

function TMRZipFile.ZipFile(AFile: String): String;
var
  fs : TFileStream;
begin

  try
    Result := ChangeFileExt(AFile, '.zip');

    if FileExists(Result) then
      DeleteFile(Result);

    fs := TFileStream.Create(Result, fmCreate);
    try
    finally
      fs.Free;
    end;

    Sleep(0);
    AbZipper.BaseDirectory := ExtractFileDir(Result);
    AbZipper.FileName      := Result;
    AbZipper.StoreOptions  := [soStripDrive,soStripPath,soRemoveDots,soReplace];

    try
      AbZipper.AddFiles(AFile, 0);
      Sleep(0);
      AbZipper.Save;
      Sleep(0);
    finally
      AbZipper.CloseArchive;
    end;
  except
    Result := AFile;
  end;
end;

end.
