unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IniFiles, uFrmInfo, DB, ADODB;

const
  DB_INI  = 'mrconnection.ini';

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    btClose: TButton;
    cbxDatabase: TComboBox;
    Label1: TLabel;
    btnUpdate: TSpeedButton;
    btnNew: TSpeedButton;
    btnSave: TSpeedButton;
    btnTestCon: TSpeedButton;
    ADOConnect: TADOConnection;
    procedure btCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnTestConClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FrmInfo: TFrmInfo;
    fDBFile : TIniFile;
    fLocalPath : String;
    function OpenIniFile:Boolean;
    function CreateIniFile:Boolean;
    function SaveConnection:Boolean;
    function TestConnection:Boolean;

    function GetSection(Section:String):String;
    procedure SetSection(Section, Str:String);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uFileFunctions, Registry, uParamFunctions, uOperationSystem;

{$R *.dfm}


function TFrmMain.TestConnection:Boolean;
var
  sResult : String;
  sPW, sUser, sDBAlias, sServer : String;
  bWinLogin, bLib : Boolean;
begin

  Result := False;

  //Verifica se tem section
  if cbxDatabase.Text = '' then
     begin
     ShowMessage('Select a connection');
     cbxDatabase.SetFocus;
     Exit;
     end;

  sResult := FrmInfo.DecodeStr(GetSection(cbxDatabase.Text));

  sServer    := ParseParam(sResult, SV_SERVER);
  sDBAlias   := ParseParam(sResult, SV_DATABASE);
  sUser      := ParseParam(sResult, SV_USER);
  sPW        := ParseParam(sResult, SV_PASSWORD);
  bWinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
  bLib       := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');

  if not bWinLogin then
     begin
     if bLib then
        sResult := SetConnectionStr(sUser, sPW, sDBAlias, sServer)
     else
        sResult := SetConnectionStrNoNETLIB(sUser, sPW, sDBAlias, sServer);
     end
  else
     begin
     if bLib then
        sResult := SetWinConnectionStr(sDBAlias, sServer)
     else
        sResult := SetWinConnectionStrNoNETLIB(sDBAlias, sServer);
     end;

  with ADOConnect do
     begin
     if Connected then
        Close;
     ConnectionString := sResult;
     Try
        Result := True;
        Open;
        ShowMessage('Connection succeed!');
        Close;
     except
        raise;
        Result := False;
        Close;
        end;
     end;

end;

function TFrmMain.SaveConnection:Boolean;
var
  Reg : TRegistry;
  buildInfo: String;
begin

  Result := True;

  //Verifica se tem section
  if cbxDatabase.Text = '' then
     begin
     ShowMessage('Select a connection');
     Exit;
     end;

  if not TestConnection then
     Exit;

  Reg := nil;
  Try
      Reg := TRegistry.Create;

      if ( getOS(buildInfo) = osW7 ) then
        Reg.RootKey := HKEY_CURRENT_USER
      else
        Reg.RootKey := HKEY_LOCAL_MACHINE;


      Reg.OpenKey('SOFTWARE\AppleNet', True);
      Reg.WriteString('ServerInfo', GetSection(cbxDatabase.Text));
  finally
     //Fechar o Registry
     Reg.CloseKey;
     Reg.Free;
  end;

end;

function TFrmMain.CreateIniFile:Boolean;
begin
  Result := True;

  if not FileExists(fLocalPath+DB_INI) then
     SaveTextFile(fLocalPath+DB_INI, '');
end;

function TFrmMain.OpenIniFile:Boolean;
var
  fIniSection : TStringList;
  i : integer;
begin

  try
    Result := True;
    cbxDatabase.Items.Clear;  
    fIniSection := TStringList.Create;
    fDBFile.ReadSections(fIniSection);
    for i := 0 to fIniSection.Count -1 do
      cbxDatabase.Items.Add(fIniSection[i]);
    FreeAndNil(fIniSection);
  except
    raise;
    Result := False;
    end;

end;


procedure TFrmMain.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.SetSection(Section, Str:String);
begin
  fDBFile.WriteString(Section, 'STR', Str);
end;

function TFrmMain.GetSection(Section:String):String;
begin
   if not fDBFile.SectionExists(Section) then
      Exit;
   Result := fDBFile.ReadString(Section, 'STR', '');
end;

procedure TFrmMain.btnNewClick(Sender: TObject);
var
  sResult,
  sSectionName : String;
begin
   //New Connection
  sSectionName := InputBox('New Database connection', 'Server Name', '');

  if sSectionName = '' then
     begin
     ShowMessage('Server Name not saved!');
     Exit;
     end;

  sResult := FrmInfo.Start('');

  if sResult = '' then
     begin
     ShowMessage('Connection aborted');
     Exit;
     end;


  SetSection(sSectionName, sResult);
  OpenIniFile;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  fLocalPath := ExtractFilePath(Application.ExeName);
  CreateIniFile;
  FrmInfo    := TFrmInfo.Create(Self);
  fDBFile    := TIniFile.Create(fLocalPath+DB_INI);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(fDBFile) then
     FreeAndNil(fDBFile);
  if Assigned(FrmInfo) then
     FreeAndNil(FrmInfo);
end;

procedure TFrmMain.btnSaveClick(Sender: TObject);
begin
 //Save to Register
 SaveConnection;
end;

procedure TFrmMain.btnUpdateClick(Sender: TObject);
var
  sResult : String;
begin

  if cbxDatabase.Text = '' then
     begin
     ShowMessage('Invalid Server Name!');
     Exit;
     end;

  sResult := FrmInfo.Start(GetSection(cbxDatabase.Text));

  SetSection(cbxDatabase.Text, sResult);

end;

procedure TFrmMain.btnTestConClick(Sender: TObject);
begin
  TestConnection;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  OpenIniFile;
end;

end.
