unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Buttons;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    imgSystemInfo: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    btnConnection: TBitBtn;
    btnUserList: TBitBtn;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnUserListClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
  private
    FUserList: TStringList;
    FIDClient: String;
  public
    function GetConfigFile: String;
    function Encode(Key, Value:String): String;
    function Decode(Key, Value:String): String;
    property UserList: TStringList read FUserList write FUserList;
    property IDClient: String read FIDClient write FIDClient;
  end;

var
  frmMain: TfrmMain;

implementation

uses uFrmConnection, uEncryptFunctions;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FUserList := TStringList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FUserList);
end;

procedure TfrmMain.btnUserListClick(Sender: TObject);
begin
  ShowMessage(FUserList.Text);
end;

function TfrmMain.GetConfigFile: String;
begin
  { Alex 08/15/2011 }
  // Result := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
  Result := 'MRAppServer.ini';
end;

procedure TfrmMain.btnConnectionClick(Sender: TObject);
begin
  with TFrmConnection.Create(Self) do
     Start;
end;

function TfrmMain.Decode(Key, Value: String): String;
begin
 Result := DecodeServerInfo(Value, Key, CIPHER_TEXT_STEALING, FMT_UU);
end;

function TfrmMain.Encode(Key, Value: String): String;
begin
  Result := EncodeServerInfo(Value, Key, CIPHER_TEXT_STEALING, FMT_UU);
end;

end.
