unit uFrmServerConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, ExtCtrls, StdCtrls, IniFiles, ComCtrls;

const
  CON_DCOM   = 0;
  CON_SOCKET = 1;
  CON_WEB    = 2;

type
  TFrmServerConnection = class(TFrmParent)
    Panel1: TPanel;
    BNext: TButton;
    BClose: TButton;
    bvBottom: TBevel;
    pgOption: TPageControl;
    tsConnection: TTabSheet;
    Label1: TLabel;
    lbHost: TLabel;
    lbPort: TLabel;
    Label2: TLabel;
    cbxConnectionType: TComboBox;
    edtHost: TEdit;
    edtPort: TEdit;
    edtClientID: TEdit;
    tsLicense: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    btnLicense: TButton;
    lbKey: TLabel;
    lbExpiration: TLabel;
    procedure cbxConnectionTypeChange(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure btnLicenseClick(Sender: TObject);
  private
    procedure GetConfigFile;
    procedure SetConfigFile;
    procedure RefreshConType;
    procedure DisplayKeyInfo;
  public
    function Start(iOption : Integer):Boolean;
  end;

implementation

uses uDMImportExport, uDMGlobalNTier, uMainRetailKeyConst, uMsgBox;

{$R *.dfm}

{ TFrmServerConnection }

function TFrmServerConnection.Start(iOption : Integer): Boolean;
begin
  tsConnection.TabVisible := False;
  tsLicense.TabVisible := False;

  case iOption of
    1 : begin
          GetConfigFile;
          tsConnection.TabVisible := True;
        end;
    2 : begin
          DisplayKeyInfo;
          tsLicense.TabVisible := True;
        end;
  end;
  ShowModal;
end;

procedure TFrmServerConnection.DisplayKeyInfo;
begin
  lbKey.Caption := Copy(DMImportExport.FMRKey, 1, 10) + ' ... ' + Copy(DMImportExport.FMRKey, Length(DMImportExport.FMRKey)-10, Length(DMImportExport.FMRKey));
  lbExpiration.Caption := FormatDateTime('ddddd', DMImportExport.FSoftwareExpirationDate);
end;

procedure TFrmServerConnection.cbxConnectionTypeChange(Sender: TObject);
begin
  inherited;
  RefreshConType;
end;

procedure TFrmServerConnection.GetConfigFile;
var
  sConType : String;
begin
    sConType := DMImportExport.GetAppProperty('Connection', 'Type');
    if sConType = CON_TYPE_SOCKET then
       cbxConnectionType.ItemIndex := CON_SOCKET
    else if sConType = CON_TYPE_DCOM then
       cbxConnectionType.ItemIndex := CON_DCOM
    else if sConType = CON_TYPE_WEB then
       cbxConnectionType.ItemIndex := CON_WEB;

    RefreshConType;
    edtClientID.Text := DMImportExport.GetAppProperty('Connection', 'ClientID');
    edtHost.Text     := DMImportExport.GetAppProperty('Connection', 'Host');
    edtPort.Text     := DMImportExport.GetAppProperty('Connection', 'Port');
end;

procedure TFrmServerConnection.SetConfigFile;
begin

  if tsConnection.TabVisible then
  begin
    case cbxConnectionType.ItemIndex of
      CON_SOCKET : DMImportExport.SetAppProperty('Connection', 'Type', CON_TYPE_SOCKET);
      CON_DCOM   : DMImportExport.SetAppProperty('Connection', 'Type', CON_TYPE_DCOM);
      CON_WEB    : DMImportExport.SetAppProperty('Connection', 'Type', CON_TYPE_WEB);
    end;

    DMImportExport.SetAppProperty('Connection', 'ClientID', edtClientID.Text);
    DMImportExport.SetAppProperty('Connection', 'Host', edtHost.Text);
    DMImportExport.SetAppProperty('Connection', 'Port', edtPort.Text);
  end;

end;

procedure TFrmServerConnection.BNextClick(Sender: TObject);
begin
  inherited;
  SetConfigFile;
  Close;
end;

procedure TFrmServerConnection.BCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmServerConnection.RefreshConType;
var
  fPort : Boolean;
begin
  inherited;

  case cbxConnectionType.ItemIndex of
    CON_DCOM   : fPort := False;
    CON_SOCKET : fPort := True;
    CON_WEB    : fPort := False;
  end;

  lbPort.Visible  := fPort;
  edtPort.Visible := fPort;

end;

procedure TFrmServerConnection.btnLicenseClick(Sender: TObject);
begin
  inherited;
  DMImportExport.ActiveConnection.AppServer.SoftwareDelete(SOFTWARE_IE);
  MsgBox('License Updated. Close Import/Export and reopen it to use your new license.', vbInformation + vbOKOnly);
end;

end.
