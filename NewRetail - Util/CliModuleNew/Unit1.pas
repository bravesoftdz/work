unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, StdCtrls;

type
  TFrmModelUpd = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    edtMod: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    ADOQuery2: TADOQuery;
    ADOQuery2ModuleInfo: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    //Client StatUp Variables
    sPW, sUser, sDBAlias, sServer, sResult : String;

    function GetConnectionStr:String;
  public
    { Public declarations }
  end;

var
  FrmModelUpd: TFrmModelUpd;

implementation

uses Registry, uParamFunctions, uEncryptFunctions, uOperationSystem;

{$R *.DFM}

function TFrmModelUpd.GetConnectionStr:String;
var
  Reg : TRegistry;
  buildInfo: String;
begin

  try
    //Pega as info local
    Reg := TRegistry.Create;

    if ( getOS(buildInfo) = osW7 ) then
      Reg.RootKey := HKEY_CURRENT_USER
    else
      Reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey('SOFTWARE\AppleNet', True);

    sResult := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    sServer  := ParseParam(sResult, '#SRV#=');
    sDBAlias := ParseParam(sResult, '#DB#=');
    sUser    := ParseParam(sResult, '#USER#=');
    sPW      := ParseParam(sResult, '#PW#=');

    result := SetConnectionStr(sUser, sPw, SDBAlias, sServer);

    //Fechar o Registry
    Reg.CloseKey;
    Reg.Free;
  except
    ShowMessage('Connection Error !');
    Abort;
  end;

end;

procedure TFrmModelUpd.Button1Click(Sender: TObject);
var
  sKey    : String;
begin
  Screen.Cursor:= crSQLWait;

  ADOConnection1.Close;

  ADOConnection1.ConnectionString := GetConnectionStr;

  ADOConnection1.Open;

  //GetKeyParam
  ADOQuery2.Open;
  sKey := ParseParam(DecodeServerInfo(ADOQuery2ModuleInfo.AsString,'ModInfo', CIPHER_TEXT_STEALING, FMT_UU),
                     '#Key#=');
  ADOQuery2.Close;

  if sKey <> '' then
     sKey := '#Key#='+sKey+';'
  else
     sKey := '#Key#=N;';

  with ADOQuery1 do
    begin
    Parameters.ParamByName('ModuleInfo').Value:=
    EncodeServerInfo('#Module#='+ edtMod.Text +';#Date#='+ DateTimeToStr(now) +';'+sKey, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU);
    ExecSQL;
    end;
  ADOConnection1.Close;

  //Edit1.Text :=
  //EncodeServerInfo('#Module#='+ edtMod.Text +';#Date#='+ DateTimeToStr(now) +';', 'ModInfo');

  Screen.Cursor:= crDefault;

  ShowMessage('Module "'+edtMod.Text+'" updated.');

  //Menu Item Visible
  {
  with ADOQuery1 do
    begin
    SQL.Text := 'Update MenuItem Set Visible = 1';
    ExecSQL;
    end;
  ADOConnection1.Close;
  ShowMessage('System updated.');
  }

  Close;
end;

procedure TFrmModelUpd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Action := caFree;

end;

end.
