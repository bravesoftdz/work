unit uDMGlobal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  siComp, ImgList, siLangRT, uSQLObj;

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
    procedure SetLanguage(ID:Integer);
  public
    { Public declarations }
    //Main Retail
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


end.
