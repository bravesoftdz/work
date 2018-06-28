unit uFrmJobs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uSystemConst;

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
    Bevel2: TBevel;
    Image2: TImage;
    Label1: TLabel;
    edtBindPort: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure GetJobs;
    procedure SetJobs;
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uMainConf, IniFiles, uDMServer, ADODB;

{$R *.dfm}



procedure TFrmJobs.GetJobs;
begin
  edtHost.Text          := FrmMain.fJobParam.ServerHost;
  edtPort.Text          := FrmMain.fJobParam.ServerPort;
  edtBindPort.Text      := IntToStr(FrmMain.fJobParam.BindPort);
end;

procedure TFrmJobs.SetJobs;
begin

  FrmMain.fIniServerConfig.WriteString('ServerInfo','ProxServer', edtHost.Text);
  FrmMain.fIniServerConfig.WriteString('ServerInfo','ProxPort', edtPort.Text);
  FrmMain.fIniServerConfig.WriteInteger('ServerInfo','BindPort', StrToInt(edtBindPort.Text));
  FrmMain.LoadParamJobs;

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

end.
