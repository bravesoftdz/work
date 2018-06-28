unit uRepConnectionFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, siComp, ExtCtrls, StdCtrls, IniFiles;

const
  CON_DCOM   = 0;
  CON_SOCKET = 1;
  CON_WEB    = 2;

type
  TRepConnectionFrm = class(TForm)
    Panel1: TPanel;
    BNext: TButton;
    BClose: TButton;
    bvBottom: TBevel;
    Label1: TLabel;
    cbxConnectionType: TComboBox;
    lbHost: TLabel;
    edtHost: TEdit;
    lbPort: TLabel;
    edtPort: TEdit;
    Label2: TLabel;
    edtClientID: TEdit;
    procedure cbxConnectionTypeChange(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
  private
    procedure GetConfigFile;
    procedure SetConfigFile;
    procedure RefreshConType;
  public
    procedure Start;
  end;

implementation

uses uDMGlobalNTier, uDMReport;

{$R *.dfm}

{ TFrmServerConnection }

procedure TRepConnectionFrm.Start;
begin
  GetConfigFile;
  ShowModal;
end;

procedure TRepConnectionFrm.cbxConnectionTypeChange(Sender: TObject);
begin
  inherited;
  RefreshConType;
end;

procedure TRepConnectionFrm.GetConfigFile;
var
  sConType : String;
begin
    sConType := DMReport.GetAppProperty('Connection', 'Type');
    if sConType = CON_TYPE_SOCKET then
       cbxConnectionType.ItemIndex := CON_SOCKET
    else if sConType = CON_TYPE_DCOM then
       cbxConnectionType.ItemIndex := CON_DCOM
    else if sConType = CON_TYPE_WEB then
       cbxConnectionType.ItemIndex := CON_WEB;

    RefreshConType;
    edtClientID.Text := DMReport.GetAppProperty('Connection', 'ClientID');
    edtHost.Text     := DMReport.GetAppProperty('Connection', 'Host');
    edtPort.Text     := DMReport.GetAppProperty('Connection', 'Port');
end;

procedure TRepConnectionFrm.SetConfigFile;
begin
  with DMReport do
  begin
    case cbxConnectionType.ItemIndex of
      CON_SOCKET: SetAppProperty('Connection', 'Type', CON_TYPE_SOCKET);
      CON_DCOM  : SetAppProperty('Connection', 'Type', CON_TYPE_DCOM);
      CON_WEB   : SetAppProperty('Connection', 'Type', CON_TYPE_WEB);
    end;

    SetAppProperty('Connection', 'ClientID', edtClientID.Text);
    SetAppProperty('Connection', 'Host', edtHost.Text);
    SetAppProperty('Connection', 'Port', edtPort.Text);
    SetConnectionProperties;
  end;
end;

procedure TRepConnectionFrm.BNextClick(Sender: TObject);
begin
  SetConfigFile;
  Close;
end;

procedure TRepConnectionFrm.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TRepConnectionFrm.RefreshConType;
var
  fPort: Boolean;
begin
  inherited;
  case cbxConnectionType.ItemIndex of
    CON_DCOM  : fPort := False;
    CON_SOCKET: fPort := True;
    CON_WEB   : fPort := False;
  else
    fPort := False;
  end;

  lbPort.Visible  := fPort;
  edtPort.Visible := fPort;
end;

end.
