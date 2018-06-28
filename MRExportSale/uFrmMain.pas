unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, dxBar, ExtCtrls, IniFiles, Registry, Cipher,
  uEncryptFunctions, uParamFunctions, DECUtil;

const
  SV_SERVER     = '#SRV#=';
  SV_DATABASE   = '#DB#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_WIN_LOGIN  = '#WIN#=';
  SV_USE_NETLIB = '#NLIB#=';

type
  TFrmMain = class(TForm)
    lbPowered: TLabel;
    Label4: TLabel;
    lblVersion: TLabel;
    Shape5: TShape;
    Connection: TADOConnection;
    Label3: TLabel;
    imgExportar: TImage;
    lblTransp: TLabel;
    imgTrackPackage: TImage;
    imgConfig: TImage;
    lblConfig: TLabel;
    imgExportItems: TImage;
    lbExportItems: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgExportarClick(Sender: TObject);
    procedure imgTrackPackageClick(Sender: TObject);
    procedure imgConfigClick(Sender: TObject);
    procedure imgExportItemsClick(Sender: TObject);
  private
    FAppInfo: TInifile;

    function GetConfigFile: String;
    function SetConnectionString:String;
    function EncodeServerInfo(sDataToEncode, sConst : String; EncryptMode, EncodeType:Integer):string;
    function DecodeServerInfo(sDataToDencode, sConst: String; EncryptMode, DecodeType: Integer): String;
  public
    procedure SetAppProperty(sSection, sKey, Text: String);
    function GetAppProperty(sSection, sKey: String): String;
  end;

var
  FrmMain: TFrmMain;

implementation

uses uFrmHold, uFrmTransporter, uFrmConfig, uFrmExportItems;

{$R *.dfm}

function TFrmMain.DecodeServerInfo(sDataToDencode, sConst: String;
  EncryptMode, DecodeType: Integer): String;
begin
  Result := '';
  with TCipher_Blowfish.Create(sConst, nil) do
    try
      Mode := TCipherMode(EncryptMode);
      Result := CodeString(sDataToDencode, paDecode, DecodeType);
    finally
      Free;
    end;
end;

function TFrmMain.EncodeServerInfo(sDataToEncode, sConst: String;
  EncryptMode, EncodeType: Integer): string;
begin
  Result := '';
  with TCipher_Blowfish.Create(sConst, nil) do
    try
      Mode := TCipherMode(EncryptMode);
      Result := CodeString(sDataToEncode, paEncode, EncodeType);
    finally
      Free;
    end;
end;

function TFrmMain.SetConnectionString: String;
var
  sPW, sUser, sDBAlias, sServer  : String;
  bLib, bWinLogin: Boolean;
  Reg: TRegistry;
begin
  Reg    := nil;
  Result := SV_SERVER   +'(local);'+
            SV_DATABASE +'MainRetailDB;'+
            SV_USER     +'mruser;'+
            SV_PASSWORD +'mruser2000;'+
            SV_WIN_LOGIN+'N;'+
            SV_USE_NETLIB+'N;';

  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\AppleNet', True);

    if not Reg.ValueExists('ServerInfo') then
      Reg.WriteString('ServerInfo', EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));

    Result := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    //Encriptografar os dados;
    sServer   := ParseParam(Result, SV_SERVER);
    sDBAlias  := ParseParam(Result, SV_DATABASE);
    sUser     := ParseParam(Result, SV_USER);
    sPW       := ParseParam(Result, SV_PASSWORD);
    bWinLogin := (ParseParam(Result, SV_WIN_LOGIN)[1] in ['Y']);
    bLib      := (ParseParam(Result, SV_USE_NETLIB)[1] = 'Y');

    if not bWinLogin then
      if bLib then
        Result := SetConnectionStr(sUser, sPW, sDBAlias, sServer)
      else
        Result := SetConnectionStrNoNETLIB(sUser, sPW, sDBAlias, sServer)
    else
      if bLib then
        Result := SetWinConnectionStr(sDBAlias, sServer)
      else
        Result := SetWinConnectionStrNoNETLIB(sDBAlias, sServer);

    Connection.ConnectionString := Result;
    Connection.Open;
  finally
     Reg.CloseKey;
     Reg.Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  SetConnectionString;
  FAppInfo := TIniFile.Create(ExtractFilePath(Application.ExeName) + GetConfigFile);  
end;

procedure TFrmMain.imgExportarClick(Sender: TObject);
begin
  with TfrmHold.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TFrmMain.imgTrackPackageClick(Sender: TObject);
begin
  with TFrmTransporter.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TFrmMain.imgConfigClick(Sender: TObject);
begin
  with TFrmConfig.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function TFrmMain.GetAppProperty(sSection, sKey: String): String;
begin
  Result := FAppInfo.ReadString(sSection, sKey, '');
end;

procedure TFrmMain.SetAppProperty(sSection, sKey, Text: String);
begin
  FAppInfo.WriteString(sSection, sKey, Text);
end;

function TFrmMain.GetConfigFile: String;
begin
  Result := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
end;

procedure TFrmMain.imgExportItemsClick(Sender: TObject);
begin
  with TFrmExportItems.Create(Self) do
  try
    Start;
  finally
    Free;
    end;
end;

end.
