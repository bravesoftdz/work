unit uFrmServerConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmServerConnection = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    btnSave: TBitBtn;
    BitBtn2: TBitBtn;
    cbxConnection: TComboBox;
    Label1: TLabel;
    pnlServer: TPanel;
    pnlFTP: TPanel;
    lbServer: TLabel;
    btnSetConnection: TSpeedButton;
    Label2: TLabel;
    edtFTP: TEdit;
    Label3: TLabel;
    edtPort: TEdit;
    Label4: TLabel;
    edtUser: TEdit;
    Label5: TLabel;
    edtPW: TEdit;
    Label6: TLabel;
    edtGlobalDir: TEdit;
    Label7: TLabel;
    edtPOSDir: TEdit;
    memServerInfo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnSetConnectionClick(Sender: TObject);
    procedure cbxConnectionChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    procedure RefreshControl;
    procedure SetValues;
    procedure GetValues;
  public
    function Start:Boolean;
  end;

implementation

uses uDMPOS, uMainConf;

{$R *.dfm}

procedure TFrmServerConnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmServerConnection.BitBtn2Click(Sender: TObject);
begin
   Close;
end;

function TFrmServerConnection.Start: Boolean;
begin
   GetValues;
   RefreshControl;
   ShowModal;
   Result := True;
end;

procedure TFrmServerConnection.btnSetConnectionClick(Sender: TObject);
begin
   DMPOS.CloseConnection;
   DMPOS.OpenConnection(True);
   memServerInfo.Lines.Text := DMPOS.GetConnectionInfo(DMPOS.GetConnection);
end;

procedure TFrmServerConnection.cbxConnectionChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TFrmServerConnection.RefreshControl;
begin
  if cbxConnection.ItemIndex = 0 then
  begin
    pnlFTP.Visible    := False;
    pnlServer.Visible := True;
  end
  else
  begin
    pnlFTP.Visible    := True;
    pnlServer.Visible := False;
  end;
end;

procedure TFrmServerConnection.btnSaveClick(Sender: TObject);
begin
  SetValues;
  Close;
end;

procedure TFrmServerConnection.SetValues;
begin
  FrmMain.fIniConfig.WriteString('ServerConnection', 'ClientInfo', memServerInfo.Lines.Text);
  FrmMain.fIniConfig.WriteInteger('ServerConnection', 'ConnectType', cbxConnection.ItemIndex);
  FrmMain.fIniConfig.WriteString('ServerConnection', 'FTP', edtFTP.Text);
  FrmMain.fIniConfig.WriteInteger('ServerConnection', 'Port', StrToIntdef(edtPort.Text,21));
  FrmMain.fIniConfig.WriteString('ServerConnection', 'User', edtUser.Text);
  FrmMain.fIniConfig.WriteString('ServerConnection', 'PW', edtPW.Text);
  FrmMain.fIniConfig.WriteString('ServerConnection', 'GlobalDir', edtGlobalDir.Text);
  FrmMain.fIniConfig.WriteString('ServerConnection', 'POSDir', edtPOSDir.Text);

end;

procedure TFrmServerConnection.GetValues;
begin
  memServerInfo.Lines.Text := FrmMain.fServerConnection.ClientInfo;
  cbxConnection.ItemIndex  := FrmMain.fServerConnection.ConnectType;
  edtFTP.Text              := FrmMain.fServerConnection.FTP;
  edtPort.Text             := IntToStr(FrmMain.fServerConnection.Port);
  edtUser.Text             := FrmMain.fServerConnection.User;
  edtPW.Text               := FrmMain.fServerConnection.PW;
  edtGlobalDir.Text        := FrmMain.fServerConnection.GlobalDir;
  edtPOSDir.Text           := FrmMain.fServerConnection.POSDir;
end;

end.
