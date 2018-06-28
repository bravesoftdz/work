unit uIniFileProcess;

interface

uses Windows, Classes, IniFiles, Registry, SysUtils;

type
{ TIniFileProcess class
  Esta classe realiza o processamento do arquivo INI associado a
  propriedade 'FileName' comparando, em cada Secção, o valor da versão com
  o correspondente no registro do Windows, carregando uma lista com
  nomes de arquivos quando os valores são diferentes }

  TIniFileProcess = class(TObject)
  private
    FFileName: string;
    FIniSections: TStrings;
    FIniFile: TIniFile;
    FFilesList: TStringList;
    FRegistry: TRegistry;
    FDefaultApp: string;
    FParamStr: string;
    procedure SetFileName(const Value: string);
    procedure ReadSections;
    procedure Verify(const ASection: string);
    procedure UpdateRegistry(const AName: string; AValue: Integer);
    function GetUpdateListCount: Integer;
    function GetDefaultApp: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute(const AFileName: string);
    property FileName: string read FFileName write SetFileName;
    property UpdateList: TStringList read FFilesList;
    property UpdateListCount: Integer read GetUpdateListCount;
    property DefaultApp: string read GetDefaultApp;
    property ParamStr: string read FParamStr;
  end;

implementation

{ TIniFileProcess }

const
  KEY_VERSION_REGISTRY = '\Software\MainRetail3\Versions';

constructor TIniFileProcess.Create;
begin
  FIniSections := TStringList.Create;
  FFilesList := TStringList.Create;

  FRegistry := TRegistry.Create;
  FRegistry.RootKey := HKEY_LOCAL_MACHINE;
end;

destructor TIniFileProcess.Destroy;
begin
  FIniSections.Free;
  FRegistry.Free;
  inherited;
end;

procedure TIniFileProcess.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TIniFileProcess.ReadSections;
var
  I: Integer;
  AppStart, ParamStr: string;
begin
  FIniFile.ReadSections(FIniSections);

  AppStart := FIniFile.ReadString('AppLoaderConfig', 'AppStart', '!#!NotDefinded!#!');
  if AppStart <> '!#!NotDefinded!#!' then
    FDefaultApp := AppStart;

  ParamStr := FIniFile.ReadString('AppLoaderConfig', 'ParamStr', '!#!NotDefinded!#!');
  if ParamStr <> '!#!NotDefinded!#!' then
    FParamStr := ParamStr;

  for I := 1 to FIniSections.Count -1 do
    Verify(FIniSections[I]);
end;

procedure TIniFileProcess.Verify(const ASection: string);
var
  IniVersion, RegVersion: Integer;
  FileName: string;
  i, iTotal : Integer;
begin
  RegVersion := -1;

  //FileName := FIniFile.ReadString(ASection, 'FileName', '');
  IniVersion := FIniFile.ReadInteger(ASection, 'Version', -1);

  FRegistry.OpenKey(KEY_VERSION_REGISTRY, True);
  try
    if FRegistry.ValueExists(ASection) then
      RegVersion := FRegistry.ReadInteger(ASection);

    if IniVersion <> RegVersion then
    begin
      UpdateRegistry(ASection, IniVersion);
      iTotal := FIniFile.ReadInteger(ASection, 'TotalFiles', 1);
      for i:=0 to iTotal do
        begin
        FileName := FIniFile.ReadString(ASection, 'FileName'+IntToStr(i+1), '');
        FFilesList.Append(FileName);
        end;
    end;
  finally
    FRegistry.CloseKey;
  end;
end;

procedure TIniFileProcess.UpdateRegistry(const AName: string; AValue: Integer);
begin
  FRegistry.OpenKey(KEY_VERSION_REGISTRY, True);
  try
    FRegistry.WriteInteger(AName, AValue);
  finally
    FRegistry.CloseKey;
  end;
end;

function TIniFileProcess.GetUpdateListCount: Integer;
begin
  Result := FFilesList.Count;
end;

procedure TIniFileProcess.Execute(const AFileName: string);
begin
  SetFileName(AFileName);
  FFilesList.Clear;
  FDefaultApp := '';

  FIniFile := TIniFile.Create(FFileName);
  try
    Self.ReadSections;
  finally
    FIniFile.Free;
  end;
end;

function TIniFileProcess.GetDefaultApp: string;
begin
  Result := FDefaultApp;
end;

end.
