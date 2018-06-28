unit uFrmStoreType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uSystemConst, siComp;

type
  TFrmStoreType = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Image3: TImage;
    Bevel4: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel5: TBevel;
    Image4: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtRepliSince: TEdit;
    cmxConnection: TComboBox;
    edtDisconectTime: TEdit;
    edtPackSize: TEdit;
    Image1: TImage;
    Bevel2: TBevel;
    Label1: TLabel;
    edtCliente: TEdit;
    Label2: TLabel;
    edtStore: TEdit;
    Label3: TLabel;
    edtPW: TEdit;
    Label4: TLabel;
    edtVersion: TEdit;
    siLang: TsiLang;
    lblDefaulStore: TLabel;
    edtDefaultStore: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmxConnectionChange(Sender: TObject);
  private
    { Private declarations }
    procedure GetStoreType;
    procedure SetStoreType;
    procedure EnableServeType;
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uDMClient, uMainConf, ADODB, uEncryptFunctions, uParamFunctions,
     {URepSocketConsts,} DB, uDMGlobal;

{$R *.dfm}

procedure TFrmStoreType.EnableServeType;
begin
  Case cmxConnection.ItemIndex of
    0 : begin //Dial Up
        edtDisconectTime.Text    := '10';
        edtPackSize.Text         := '1024';
        edtDisconectTime.Enabled := False;
        edtPackSize.Enabled      := False;
        end;
    1 : begin //DSL
        edtDisconectTime.Text    := '5';
        edtPackSize.Text         := '4096';
        edtDisconectTime.Enabled := False;
        edtPackSize.Enabled      := False;
        end;
    2 : begin //Other
        edtDisconectTime.Enabled := True;
        edtPackSize.Enabled      := True;
        end;
  end;
end;

procedure TFrmStoreType.SetStoreType;
var
 sConnection : String;
begin

  FrmMain.fIniConfig.WriteString('ServerConnection','ConnectionTimeOut', edtDisconectTime.Text);
  FrmMain.fIniConfig.WriteInteger('ServerConnection','PacketSize', StrToIntDef(edtPackSize.Text,1024));
  FrmMain.fIniConfig.WriteInteger('ServerConnection','ConnectType', cmxConnection.ItemIndex);
  FrmMain.fIniConfig.WriteString('ServerConnection','ReplicateSince', edtRepliSince.Text);
  sConnection :=  CI_NOMECLIENTE + edtCliente.Text  + ';' +
                  CI_NOMELOJA    + edtStore.Text    + ';' +
                  CI_SENHA       + edtPW.Text       + ';' +
                  CI_VERSAO      + edtVersion.Text  + ';' +
                  CI_PACKETSIZE  + edtPackSize.Text + ';';
  sConnection := EncodeServerInfo(sConnection, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);
  FrmMain.fIniConfig.WriteString('ServerConnection','ClientInfo', sConnection);
  FrmMain.fIniConfig.WriteString('Local','IDDefaultStore', edtDefaultStore.Text);

  FrmMain.LoadParamServerConnection;

end;

procedure TFrmStoreType.GetStoreType;
var
  sConnection : String;
begin

  edtRepliSince.Text      := IntToStr(FrmMain.fServerConnection.ReplicateSince);
  edtDisconectTime.Text   := IntToStr(FrmMain.fServerConnection.ConnectionTimeOut);
  cmxConnection.ItemIndex := FrmMain.fServerConnection.ConnectType;
  edtPackSize.Text        := IntToStr(FrmMain.fServerConnection.PacketSize);
  edtDefaultStore.Text    := IntToStr(FrmMain.fJobParam.DefaultStore);

  sConnection             := DecodeServerInfo(FrmMain.fServerConnection.ClientInfo, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);

  edtCliente.Text         := ParseParam(sConnection, CI_NOMECLIENTE);
  edtStore.Text           := ParseParam(sConnection, CI_NOMELOJA);
  edtPW.Text              := ParseParam(sConnection, CI_SENHA);
  edtVersion.Text         := DMClient.GetClientVersion;

  EnableServeType;

end;

function TFrmStoreType.Start:Boolean;
begin

   GetStoreType;

   ShowModal;

   Result := (ModalResult=mrOK);

   if Result then
      SetStoreType;

end;

procedure TFrmStoreType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmStoreType.cmxConnectionChange(Sender: TObject);
begin
   EnableServeType;
end;


end.
