unit uMainRetailKey;

interface

Uses SysUtils, Variants, ADODB, Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, DBClient;

type
  TMRSoftware = class
    FStoreKey   : String;
    FSoftware   : String;
    FComputers  : Integer;
    FUsers      : Integer;
    FExpitarion : TDateTime;
    FModules    : TStringList;
  public
    function FormatInfo : WideString;
    function UnFormatInto(Info : WideString) : Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

  TMRStore = class
    FKey      : String;
    FStore    : String;
    FAddress1 : String;
    FAddress2 : String;
    FCity     : String;
    FState    : String;
    FZip      : String;
    FCountry  : String;
    FPhone    : String;
    FFax      : String;
    FEmail    : String;
    FWebsite  : String;
    FContact1 : String;
    FC1Phone  : String;
    FC1Email  : String;
  end;

  TMRDBService = class
    private
      FSQLConnection: TADOConnection;
      FSearchQuery: TADOQuery;
      FInsertQuery: TADOQuery;
      procedure SetSQLConnection(const Value: TADOConnection);
      function UpdateSoftware(AMRSoftware : TMRSoftware):Boolean;
      function InsertSoftware(AMRSoftware : TMRSoftware):Boolean;
      function FindSoftware(AMRSoftware : TMRSoftware):Boolean;
    public
      property SQLConnection: TADOConnection read FSQLConnection write SetSQLConnection;

      function SetSoftware(AMRSoftware : TMRSoftware):Boolean;
      function GetStoreKey : String;
      function SetStoreKey(AKey : String) : Boolean;
      function GetSoftwareList : String;
      function GetSoftwareInfo(ASoftware : String) : String;
      function DeleteSoftware(ASoftware : String): Boolean;

      constructor Create;
      destructor Destroy; override;
  end;

  TMRFTPService = class
    FTP: TIdFTP;
    public
      function SendStoreFile(AFile : String):Boolean;
      function GetStoreFile(AKey : String):Boolean;
      constructor Create;
      destructor Destroy; override;
  end;

  TMRKey = class
    FKey : String;
    FSoftwareList : TStringList;
    FMRDBService : TMRDBService;
    FMRStore : TMRStore;

    function CheckKey(ASoftware : String) : Boolean;
    function VerifyKey(ASoftware : String) : Boolean;
    function DeleteSoftware(ASoftware : String) : Boolean;
    function CreateGUIDKey: string;
    function SendStoreFile(AFile : String) : Boolean;
    function SaveStoreFile(AMRStore : TMRStore) : String;

    function DownloadStoreKey : Boolean;
    function CheckExpitarionKey(Software : String) : Boolean;
    function UpdateModules : Boolean;
    function DecodeFile(FileName : String) : String;

    function LoadModules : Boolean;
    function ClearModules : Boolean;

    function GetExpirationDate(ASoftware : String): TDateTime;
    function ModuleEnable(ASoftware : String; AModule : String) : Boolean;
    function SoftwareEnable(ASoftware : String) : Boolean;
  public
    constructor Create(Conn: TADOConnection);
    destructor Destroy; override;
  end;


implementation

uses ActiveX, Forms, ConvUtils, DB, ExtActns, IniFiles, uMainRetailKeyConst,
  uDateTimeFunctions, uParamFunctions, uMainRetailEncryption;

{ TMRSoftware }

constructor TMRSoftware.Create;
begin
  FModules := TStringList.Create;
end;

destructor TMRSoftware.Destroy;
begin
  FreeAndNil(FModules);
  inherited;
end;

function TMRSoftware.FormatInfo: WideString;
begin

  Result := 'COMP=' + IntToStr(FComputers) + ';' +
            'USRS=' + IntToStr(FUsers)     + ';' +
            'EXPD=' + FormatDateTime('mm/dd/yyyy', FExpitarion) + ';' +
            'MODL=' + FModules.CommaText   + ';';

  Result := EncodeMIME64(Result);

end;

function TMRSoftware.UnFormatInto(Info: WideString): Boolean;
begin

  Info := DecodeMIME64(Info);

  FUsers             := StrToIntDef(ParseParam(Info, 'USRS'), 1);
  FComputers         := StrToIntDef(ParseParam(Info, 'COMP'), 1);
  FExpitarion        := MyStrToDate(ParseParam(Info, 'EXPD'));
  FModules.CommaText := ParseParam(Info, 'MODL');
  Result := True;

end;

{ TMRKey }

constructor TMRKey.Create(Conn: TADOConnection);
begin
  FMRDBService := TMRDBService.Create;
  FMRDBService.SetSQLConnection(Conn);

  FSoftwareList := TStringList.Create;
end;

function TMRKey.CreateGUIDKey: string;
var
  ID: TGUID;
begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
  begin
    Result := GUIDToString(ID);
    Result := StringReplace(Result, '{', '', [rfReplaceAll]);
    Result := StringReplace(Result, '}', '', [rfReplaceAll]);
  end;
end;

destructor TMRKey.Destroy;
begin
  FreeAndNil(FMRDBService);
  ClearModules;
  FSoftwareList.Free;
  inherited;
end;

function TMRKey.SaveStoreFile(AMRStore: TMRStore): String;
var
  ACds : TClientDataSet;
begin

  ACds := TClientDataSet.Create(nil);
  try
    ACDS.FieldDefs.Add('ID', ftString, 255);
    ACDS.FieldDefs.Add('Store', ftString, 50);
    ACDS.FieldDefs.Add('Address', ftString, 100);
    ACDS.FieldDefs.Add('Address2', ftString, 100);
    ACDS.FieldDefs.Add('City', ftString, 50);
    ACDS.FieldDefs.Add('State', ftString, 2);
    ACDS.FieldDefs.Add('Zip', ftString, 20);
    ACDS.FieldDefs.Add('Country', ftString, 50);
    ACDS.FieldDefs.Add('Phone', ftString, 20);
    ACDS.FieldDefs.Add('Fax', ftString, 20);
    ACDS.FieldDefs.Add('Email', ftString, 100);
    ACDS.FieldDefs.Add('Web', ftString, 100);
    ACDS.FieldDefs.Add('Contact1', ftString, 50);
    ACDS.FieldDefs.Add('Phone1', ftString, 20);
    ACDS.FieldDefs.Add('Email1', ftString, 100);

    with ACds do
    begin
      CreateDataSet;
      Append;
      FieldByName('ID').Value       := FKey;
      FieldByName('Store').Value    := AMRStore.FStore;
      FieldByName('Address').Value  := AMRStore.FAddress1;
      FieldByName('Address2').Value := AMRStore.FAddress2;
      FieldByName('City').Value     := AMRStore.FCity;
      FieldByName('State').Value    := AMRStore.FState;
      FieldByName('Zip').Value      := AMRStore.FZip;
      FieldByName('Country').Value  := AMRStore.FCountry;
      FieldByName('Phone').Value    := AMRStore.FPhone;
      FieldByName('Fax').Value      := AMRStore.FFax;
      FieldByName('Email').Value    := AMRStore.FEmail;
      FieldByName('Web').Value      := AMRStore.FWebsite;
      FieldByName('Contact1').Value := AMRStore.FContact1;
      FieldByName('Phone1').Value   := AMRStore.FC1Phone;
      FieldByName('Email1').Value   := AMRStore.FC1Email;
      Post;

      Result := ExtractFilePath(Application.ExeName) + 'license_' + FKey + '.xml';
      SaveToFile(Result, dfXML);

    end;

  finally
    FreeAndNil(ACds);
  end;

end;

function TMRKey.SendStoreFile(AFile : String): Boolean;
var
  FMRFTPService : TMRFTPService;
begin

  FMRFTPService := TMRFTPService.Create;
  try
    Result := FMRFTPService.SendStoreFile(AFile);
  finally
    FreeAndNil(FMRFTPService);
  end;
end;

function TMRKey.DownloadStoreKey: Boolean;
var
  MRFTPService : TMRFTPService;
begin

  MRFTPService := TMRFTPService.Create;
  try
    try
      Result := MRFTPService.GetStoreFile(FKey);
    except
      raise Exception.Create('Invalid license key. Please contact MainRetail.');
    end;
  finally
    FreeAndNil(MRFTPService);
  end;

end;

function TMRKey.CheckKey(ASoftware : String) : Boolean;
begin

  Result := True;

  FKey := FMRDBService.GetStoreKey;

  if (FKey <> '') then
  begin
    LoadModules;

    if CheckExpitarionKey(ASoftware) then
    try
      DownloadStoreKey;
    except
      end;

    Result := UpdateModules;
    if Result then
      LoadModules;
  end;

end;

function TMRKey.VerifyKey(ASoftware : String): Boolean;
var
  fFileName : String;
begin

  FKey := FMRDBService.GetStoreKey;

  Result := (FKey <> '');

  if not Result then
  begin

    if FMRStore = Nil then
      raise Exception.Create('You need to run the Wizard and register with MainRetail');

    FKey := CreateGUIDKey;
    FMRDBService.SetStoreKey(FKey);
    fFileName := SaveStoreFile(FMRStore);

    if not SendStoreFile(fFileName) then
      raise Exception.Create('Error sending store file to FTP.');

  end
  else
  begin

    LoadModules;

    if CheckExpitarionKey(ASoftware) then
      DownloadStoreKey;

    if UpdateModules then
      LoadModules;
  end;

end;

function TMRKey.CheckExpitarionKey(Software : String): Boolean;
var
  i : Integer;
begin

  Result := False;

  if (FSoftwareList.Count = 0) or (Software = 'ALL') then
  begin
    Result := True;
    Exit;
  end;

  if (FSoftwareList.IndexOf(Software) = -1) then
  begin
    Result := True;
    Exit;
  end;

  for i := 0 to FSoftwareList.Count-1 do
    if (Software = TMRSoftware(FSoftwareList.Objects[i]).FSoftware) then
      if (TMRSoftware(FSoftwareList.Objects[i]).FExpitarion <= Trunc((Now + 10))) then
      begin
        Result := True;
        Break;
      end;

end;

function TMRKey.UpdateModules: Boolean;
var
  AFile : TIniFile;
  Sofware : TStringList;
  i : Integer;
  AMRSoftware : TMRSoftware;
  sDate, sFileName : String;
begin

  Result := False;

  if FileExists(ExtractFilePath(Application.ExeName) + FKey + '.lic') then
  begin

    sFileName := DecodeFile(ExtractFilePath(Application.ExeName) + FKey + '.lic');

    if FileExists(sFileName) then
    try
      AFile := TIniFile.Create(sFileName);
      Sofware := TStringList.Create;
      AMRSoftware := TMRSoftware.Create;

      AFile.ReadSections(Sofware);
      for i := 0 to Sofware.Count-1 do
      begin
        if Sofware.Strings[i] = LICENSE_FILE_COMPANY_HEADER then
        begin
          if FKey <> AFile.ReadString(LICENSE_FILE_COMPANY_HEADER, LICENSE_FILE_COMPANY_KEY, '') then
            raise Exception.Create('Invalid store file.');
        end
        else
        begin
          AMRSoftware.FSoftware   := Sofware.Strings[i];
          AMRSoftware.FUsers      := AFile.ReadInteger(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_USER, 1);
          AMRSoftware.FComputers  := AFile.ReadInteger(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_COMPUTER, 1);

          sDate := AFile.ReadString(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_EXPIRES, '');
          AMRSoftware.FExpitarion := BuildDate(Copy(sDate,7,2), Copy(sDate,5,2), Copy(sDate,1,4));

          AMRSoftware.FModules.CommaText :=
                  AFile.ReadString(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_MODULE1, '') +
                  AFile.ReadString(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_MODULE2, '') +
                  AFile.ReadString(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_MODULE3, '') +
                  AFile.ReadString(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_MODULE4, '') +
                  AFile.ReadString(Sofware.Strings[i], LICENSE_FILE_SOFTWARE_MODULE5, '');


          FMRDBService.SetSoftware(AMRSoftware);
        end;
      end;

      Result := True;
    finally
      FreeAndNil(AMRSoftware);
      FreeAndNil(Sofware);
      FreeAndNil(AFile);
      DeleteFile(sFileName);
    end;
  end;

end;

function TMRKey.DecodeFile(FileName: String): String;
var
  sFile : TStringList;
  sEncription : WideString;
  i : Integer;
begin

  Result := ExtractFilePath(Application.ExeName) + 'MRStoreTemp.lic';

  if FileExists(FileName) and (not FileExists(Result)) then
  try
    sFile := TStringList.Create;
    try
      sFile.LoadFromFile(FileName);

      sEncription := '';

      for i:=0 to sFile.Count-1 do
        sEncription := sEncription + sFile.Strings[i];

      sFile.Text := DecodeMIME64(sEncription);
      sFile.SaveToFile(Result);

      DeleteFile(FileName);

    finally
      FreeAndNil(sFile);
      end;
  except
    raise;
    end;

end;

function TMRKey.LoadModules: Boolean;
var
  STW : TMRSoftware;
  lstSoftware : TStringList;
  i : Integer;
begin

  Result := False;

  if ClearModules then
  try
    lstSoftware := TStringList.Create;
    lstSoftware.CommaText := FMRDBService.GetSoftwareList;
    for i := 0 to lstSoftware.Count-1 do
    begin
      STW := TMRSoftware.Create;
      STW.FSoftware := lstSoftware.Strings[i];
      STW.UnFormatInto(FMRDBService.GetSoftwareInfo(lstSoftware.Strings[i]));
      FSoftwareList.AddObject(lstSoftware.Strings[i], STW);
    end;
    Result := True;
  finally
    FreeAndNil(lstSoftware);
  end;

end;

function TMRKey.ClearModules: Boolean;
var
  S : TMRSoftware;
begin

  while FSoftwareList.Count > 0 do
  begin
    if (FSoftwareList.Objects[0] <> nil) then
    begin
      S := TMRSoftware(FSoftwareList.Objects[0]);
      FreeAndNil(S);
    end;
    FSoftwareList.Delete(0);
  end;

  Result := True;

end;

function TMRKey.GetExpirationDate(ASoftware: String): TDateTime;
var
  i : Integer;
begin
  Result := 0;
  i := FSoftwareList.IndexOf(ASoftware);
  if i <> -1 then
    Result := TMRSoftware(FSoftwareList.Objects[i]).FExpitarion;
end;

function TMRKey.ModuleEnable(ASoftware, AModule: String): Boolean;
begin
  if FSoftwareList.IndexOf(ASoftware) <> -1 then
    Result := (TMRSoftware(FSoftwareList.Objects[FSoftwareList.IndexOf(ASoftware)]).FModules.IndexOf(AModule) <> -1)
  else
    Result := False;
end;

function TMRKey.SoftwareEnable(ASoftware: String): Boolean;
begin
  if FSoftwareList.IndexOf(ASoftware) <> -1 then
    Result := (TMRSoftware(FSoftwareList.Objects[FSoftwareList.IndexOf(ASoftware)]).FExpitarion < Trunc(Now))
  else
    Result := False;
end;

function TMRKey.DeleteSoftware(ASoftware: String): Boolean;
begin
  Result := FMRDBService.DeleteSoftware(ASoftware);
  LoadModules;
end;

{ TMRDBService }

constructor TMRDBService.Create;
begin
  FSearchQuery := TADOQuery.Create(nil);
  FInsertQuery := TADOQuery.Create(nil);
end;

destructor TMRDBService.Destroy;
begin
  FSearchQuery.Close;
  FInsertQuery.Close;
  FSearchQuery.Free;
  FInsertQuery.Free;
  inherited;
end;

function TMRDBService.GetStoreKey: String;
begin
  FSearchQuery.SQL.Clear;
  FSearchQuery.SQL.Add('SELECT MRKey FROM Mnt_Store');
  try
    FSearchQuery.Open;
    Result := FSearchQuery.FieldByName('MRKey').AsString;
  finally
    FSearchQuery.Close;
    end;
end;

function TMRDBService.FindSoftware(AMRSoftware: TMRSoftware): Boolean;
begin

  FSearchQuery.SQL.Clear;
  FSearchQuery.SQL.Add('SELECT Software FROM Mnt_Controler WHERE Software = :Software');
  FSearchQuery.Parameters.ParamByName('Software').Value := AMRSoftware.FSoftware;
  try
    FSearchQuery.Open;
    Result := not FSearchQuery.IsEmpty;
  finally
    FSearchQuery.Close;
    end;

end;

function TMRDBService.InsertSoftware(AMRSoftware: TMRSoftware): Boolean;
begin

  FInsertQuery.SQL.Clear;
  FInsertQuery.SQL.Add('INSERT Mnt_Controler (Software, Info) VALUES (:Software, :Info)');
  FInsertQuery.Parameters.ParamByName('Software').Value := AMRSoftware.FSoftware;
  FInsertQuery.Parameters.ParamByName('Info').Value     := AMRSoftware.FormatInfo;
  try
    try
      FInsertQuery.ExecSQL;
      Result := True;
    except
      Result := False;
      end;
  finally
    FInsertQuery.Close;
    end;

end;

function TMRDBService.SetSoftware(AMRSoftware: TMRSoftware): Boolean;
begin

  Result := True;

  if FindSoftware(AMRSoftware) then
    UpdateSoftware(AMRSoftware)
  else
    InsertSoftware(AMRSoftware);
end;

function TMRDBService.UpdateSoftware(AMRSoftware: TMRSoftware): Boolean;
begin

  FInsertQuery.SQL.Clear;
  FInsertQuery.SQL.Add('UPDATE Mnt_Controler Set Info = :Info WHERE Software = :Software');
  FInsertQuery.Parameters.ParamByName('Software').Value := AMRSoftware.FSoftware;
  FInsertQuery.Parameters.ParamByName('Info').Value     := AMRSoftware.FormatInfo;
  try
    try
      FInsertQuery.ExecSQL;
      Result := True;
    except
      Result := False;
      end;
  finally
    FInsertQuery.Close;
    end;

end;

procedure TMRDBService.SetSQLConnection(const Value: TADOConnection);
begin
  FSQLConnection := Value;
  FSearchQuery.Connection := FSQLConnection;
  FInsertQuery.Connection := FSQLConnection;
end;

function TMRDBService.SetStoreKey(AKey: String): Boolean;
begin
  FInsertQuery.SQL.Clear;
  FInsertQuery.SQL.Add('INSERT Mnt_Store (MRKey) VALUES (:MRKey)');
  FInsertQuery.Parameters.ParamByName('MRKey').Value := AKey;
  try
    try
      FInsertQuery.ExecSQL;
      Result := True;
    except
      Result := False;
      end;
  finally
    FInsertQuery.Close;
    end;
end;

function TMRDBService.GetSoftwareList: String;
begin

  FSearchQuery.SQL.Clear;
  FSearchQuery.SQL.Add('SELECT Software FROM Mnt_Controler');
  try
    FSearchQuery.Open;
    FSearchQuery.First;
    While not FSearchQuery.EOF do
    begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + FSearchQuery.FieldByName('Software').AsString;
      FSearchQuery.Next;
    end;
  finally
    FSearchQuery.Close;
    end;

end;

function TMRDBService.GetSoftwareInfo(ASoftware: String): String;
begin

  FSearchQuery.SQL.Clear;
  FSearchQuery.SQL.Add('SELECT Info FROM Mnt_Controler WHERE Software = :Software');
  FSearchQuery.Parameters.ParamByName('Software').Value := ASoftware;
  try
    FSearchQuery.Open;
    Result := FSearchQuery.FieldByName('Info').AsString;
  finally
    FSearchQuery.Close;
    end;

end;

function TMRDBService.DeleteSoftware(ASoftware: String): Boolean;
begin

  FInsertQuery.SQL.Clear;
  FInsertQuery.SQL.Add('DELETE Mnt_Controler WHERE Software = :Software');
  FInsertQuery.Parameters.ParamByName('Software').Value := ASoftware;
  try
    try
      FInsertQuery.ExecSQL;
      Result := True;
    except
      Result := False;
      end;
  finally
    FInsertQuery.Close;
    end;

end;

{ TMRFTPService }

constructor TMRFTPService.Create;
begin
  FTP := TIdFTP.Create(nil);

  with FTP do
  begin
    Host     := 'uploads.360pet.com';
    Username := '360uploads';
    Password := 'x8EyMD_%';
    Port     := 21;
  end;

end;

destructor TMRFTPService.Destroy;
begin
  FTP.Disconnect;
  FreeAndNil(FTP);
  inherited;
end;

function TMRFTPService.GetStoreFile(AKey: String): Boolean;
begin

  with TDownloadURL.Create(nil) do
  try
    URL := 'http://license.mainretail.net/' + AKey + '.lic';
    FileName := ExtractFilePath(Application.ExeName) + AKey + '.lic';
    ExecuteTarget(nil);
    Result := True;
  finally
    Free;
  end;

end;

function TMRFTPService.SendStoreFile(AFile: String): Boolean;
begin

  Result := False;

  with FTP do
  try
    Connect(True, -1);
    if Connected then
    begin
      Put(AFile, ExtractFileName(AFile), True);
      Result := True;
    end
  finally
    Disconnect;
  end;

end;

end.
