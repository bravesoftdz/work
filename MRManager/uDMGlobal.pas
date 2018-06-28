unit uDMGlobal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IniFiles, siComp, ImgList, siLangRT;

const
  LANG_ENGLISH    = 1;
  LANG_PORTUGUESE = 2;
  LANG_SPANISH    = 3;

  LANG_DIRECTORY  = 'Translation\';

type
  TDMGlobal = class(TDataModule)
    LanguageDispatcher: TsiLangDispatcher;
    imgSmall: TImageList;
    imgLarge: TImageList;
    imgPayments: TImageList;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FIDLanguage       : integer;
    FIDUser           : integer;
    FIDUserType       : integer;
    FUserName         : string;
    FIDDefaultStore   : integer;
    FIDCommission     : integer;
    FIDDefaultCompany : integer;
    FCompanyName      : string;
    FIDDefaultCashRed : integer;
    FLangFilesPath    : String;
    function GetConfigFile: String;    
  protected
    FAppInfo: TInifile;
    procedure SetLanguage(ID:Integer);
  public
    procedure SetAppProperty(sSection, sKey, Text: String);
    function GetAppProperty(sSection, sKey: String): String;

    property IDUser           : Integer read FIDUser           write FIDUser;
    property IDUserType       : Integer read FIDUserType       write FIDUserType;
    property UserName         : String  read FUserName         write FUserName;
    property IDDefaulStore    : Integer read FIDDefaultStore   write FIDDefaultStore;
    property IDCommission     : Integer read FIDCommission     write FIDCommission;
    property IDDefaultCompany : Integer read FIDDefaultCompany write FIDDefaultCompany;
    property CompanyName      : String  read FCompanyName      write FCompanyName;
    property IDLanguage       : Integer read FIDLanguage       write SetLanguage;
    property IDDefaultCashReg : Integer read FIDDefaultCashRed write FIDDefaultCashRed;
    property LangFilesPath    : String  read FLangFilesPath    write FLangFilesPath;
  end;

var
  DMGlobal: TDMGlobal;

implementation

{$R *.DFM}

procedure TDMGlobal.SetLanguage(ID:Integer);
begin
  FIDLanguage := ID;
  LanguageDispatcher.ActiveLanguage := ID;
end;

procedure TDMGlobal.DataModuleCreate(Sender: TObject);
begin
  FAppInfo := TIniFile.Create(ExtractFilePath(Application.ExeName) + GetConfigFile);
end;

procedure TDMGlobal.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FAppInfo);
end;

function TDMGlobal.GetAppProperty(sSection, sKey: String): String;
begin
  Result := FAppInfo.ReadString(sSection, sKey, '');
end;

procedure TDMGlobal.SetAppProperty(sSection, sKey, Text: String);
begin
  FAppInfo.WriteString(sSection, sKey, Text);
end;

function TDMGlobal.GetConfigFile: String;
begin
  Result := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
end;

end.
