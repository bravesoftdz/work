unit uFrmJobs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, siComp;

type
  TFrmJobs = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtHost: TEdit;
    edtPort: TEdit;
    Label1: TLabel;
    edtUser: TEdit;
    Label2: TLabel;
    Label5: TLabel;
    edtProxServer: TEdit;
    Label6: TLabel;
    edtProxPort: TEdit;
    Image1: TImage;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Image2: TImage;
    edtPW: TMaskEdit;
    Label7: TLabel;
    cbxSocketVer: TComboBox;
    chkAuthentic: TCheckBox;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkAuthenticClick(Sender: TObject);
    procedure cbxSocketVerChange(Sender: TObject);
  private
    { Private declarations }
    procedure GetJobs;
    procedure SetJobs;
    procedure EnableUserPw(Enable:Boolean);
    procedure EnableProxy(Enable:Boolean);
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uMainConf, IniFiles, uEncryptFunctions;

{$R *.dfm}

procedure TFrmJobs.GetJobs;
begin

  edtHost.Text            := FrmMain.fSocketConfig.Host;
  edtPort.Text            := FrmMain.fSocketConfig.Port;
  edtProxServer.Text      := FrmMain.fSocketConfig.ProxServer;
  edtProxPort.Text        := FrmMain.fSocketConfig.ProxPort;
  edtUser.Text            := FrmMain.fSocketConfig.ProxUser;
  edtPW.Text              := FrmMain.fSocketConfig.ProxPW;
  cbxSocketVer.Text       := FrmMain.fSocketConfig.SockVer;
  chkAuthentic.Checked    := FrmMain.fSocketConfig.Authentic;


  EnableProxy(not(cbxSocketVer.ItemIndex=0));

end;


procedure TFrmJobs.SetJobs;
begin

  FrmMain.fIniConfig.WriteString('SocketInfo','ProxServer', edtProxServer.Text);
  FrmMain.fIniConfig.WriteString('SocketInfo','ProxPort', edtProxPort.Text);
  FrmMain.fIniConfig.WriteString('SocketInfo','ProxUser', edtUser.Text);
  FrmMain.fIniConfig.WriteString('SocketInfo','ProxPW', EncodeServerInfo(edtPW.Text, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX));
  FrmMain.fIniConfig.WriteString('SocketInfo','SocketVersion', cbxSocketVer.Text);
  FrmMain.fIniConfig.WriteBool('SocketInfo','Authentication', chkAuthentic.Checked);
  FrmMain.fIniConfig.WriteString('SocketInfo','Host', edtHost.Text);
  FrmMain.fIniConfig.WriteString('SocketInfo','Port', edtPort.Text);

  FrmMain.LoadParamSocket;
end;

function TFrmJobs.Start:Boolean;
begin

    GetJobs;

    ShowModal;

    Result := (ModalResult=mrOK);

    if Result then
       SetJobs;

end;

procedure TFrmJobs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFrmJobs.chkAuthenticClick(Sender: TObject);
begin
  EnableUserPw(chkAuthentic.Checked);
end;

procedure TFrmJobs.EnableUserPw(Enable: Boolean);
begin
  edtUser.Enabled := Enable;
  edtPW.Enabled   := Enable;
end;

procedure TFrmJobs.EnableProxy(Enable: Boolean);
begin
  edtProxServer.Enabled := Enable;
  edtProxPort.Enabled   := Enable;
  chkAuthentic.Enabled  := Enable;
  EnableUserPw(Enable);
end;

procedure TFrmJobs.cbxSocketVerChange(Sender: TObject);
begin
  EnableProxy(not(cbxSocketVer.ItemIndex=0));
end;

end.
