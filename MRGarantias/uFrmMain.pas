unit uFrmMain;

interface                                     //imgReImprimir

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, ADODB, Provider, DBClient, ppProd, ppClass, ppReport, ppComm,
  ppRelatv, ppDB, ppDBPipe, ppBands, ppCtrls, jpeg, ppPrnabl, ppCache,
  ppParameter, Registry, Cipher, uEncryptFunctions, uParamFunctions, DECUtil,
  cxLookAndFeelPainters, cxButtons, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxContainer, cxTextEdit, ppStrtch, ppRichTx, dxBar, IniFiles;

const
  SV_SERVER     = '#SRV#=';
  SV_DATABASE   = '#DB#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_WIN_LOGIN  = '#WIN#=';
  SV_USE_NETLIB = '#NLIB#=';

type
  TFrmPrincipal = class(TForm)
    Connection: TADOConnection;
    bmMain: TdxBarManager;
    bbSair: TdxBarButton;
    bbImprimir: TdxBarButton;
    bbGerarArq: TdxBarButton;
    bbConfig: TdxBarButton;
    bsMain: TdxBarSubItem;
    bbReImprimirRAEC: TdxBarButton;
    bbImportarRAECs: TdxBarButton;
    lbPowered: TLabel;
    Label4: TLabel;
    lblVersion: TLabel;
    Shape5: TShape;
    Label1: TLabel;
    Label3: TLabel;
    imgEnviar: TImage;
    imgImprimir: TImage;
    Label2: TLabel;
    bbEnviarRAECs: TdxBarButton;
    imgReImprimir: TImage;
    procedure FormCreate(Sender: TObject);
    procedure bbSairClick(Sender: TObject);
    procedure bbConfigClick(Sender: TObject);
    procedure bbImprimirClick(Sender: TObject);
    procedure bbGerarArqClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbReImprimirRAECClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgImprimirClick(Sender: TObject);
    procedure imgReImprimirClick(Sender: TObject);
    procedure bbImportarRAECsClick(Sender: TObject);
    procedure bbEnviarRAECsClick(Sender: TObject);
    procedure imgEnviarClick(Sender: TObject);
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
  FrmPrincipal: TFrmPrincipal;

implementation

uses DateUtils, Math, uFrmConfig, uFrmGeraArquivo,
  uFrmImprimirRAEC, uFrmReImprimirRAEC, uImportXML;

{$R *.dfm}

function TFrmPrincipal.SetConnectionString:String;
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

function TFrmPrincipal.DecodeServerInfo(sDataToDencode, sConst : String; EncryptMode,DecodeType:Integer):String;
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

function TFrmPrincipal.EncodeServerInfo(sDataToEncode, sConst : String; EncryptMode, EncodeType:Integer):string;
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

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  SetConnectionString;
  FAppInfo := TIniFile.Create(ExtractFilePath(Application.ExeName) + GetConfigFile);
end;

procedure TFrmPrincipal.bbSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.bbConfigClick(Sender: TObject);
begin
  with TFrmConfig.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmPrincipal.bbImprimirClick(Sender: TObject);
begin
  with TFrmImprimirRAEC.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmPrincipal.bbGerarArqClick(Sender: TObject);
begin
  with TFrmGeraArquivo.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function TFrmPrincipal.GetAppProperty(sSection, sKey: String): String;
begin
  Result := FAppInfo.ReadString(sSection, sKey, '');
end;

procedure TFrmPrincipal.SetAppProperty(sSection, sKey, Text: String);
begin
  FAppInfo.WriteString(sSection, sKey, Text);
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAppInfo);
end;

function TFrmPrincipal.GetConfigFile: String;
begin
  Result := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
end;

procedure TFrmPrincipal.bbReImprimirRAECClick(Sender: TObject);
begin
  with TFrmReImprimir.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SOFTWARE\Applenet\MainRetail', True);
    //imgClientLogo.Picture.LoadFromFile(ReadString('CompanyLogo'));
  finally
    Free;
  end;
end;

procedure TFrmPrincipal.imgImprimirClick(Sender: TObject);
begin
  bbImprimirClick(Sender);
end;

procedure TFrmPrincipal.imgReImprimirClick(Sender: TObject);
begin
  bbReImprimirRAECClick(Sender);
end;

procedure TFrmPrincipal.bbImportarRAECsClick(Sender: TObject);
begin
  with TFrmImportXML.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFrmPrincipal.bbEnviarRAECsClick(Sender: TObject);
begin
  //
end;

procedure TFrmPrincipal.imgEnviarClick(Sender: TObject);
begin
  bbEnviarRAECsClick(Sender);
end;

end.
