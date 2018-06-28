unit uFrmScreenConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ExtDlgs, siComp;

type
  TFrmScreenConf = class(TForm)
    pnlButtons: TPanel;
    btnClose: TBitBtn;
    btnSave: TBitBtn;
    pgOption: TPageControl;
    tsInvoice: TTabSheet;
    tsTextBottom: TTabSheet;
    Label1: TLabel;
    cbxInvoiceDisplay: TComboBox;
    Label5: TLabel;
    edtLog: TEdit;
    Label2: TLabel;
    edtSpeed: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    edtText: TEdit;
    btnImgLogo: TSpeedButton;
    OP: TOpenPictureDialog;
    tsVideo: TTabSheet;
    edtVideoLeft: TLabeledEdit;
    edtVideoTop: TLabeledEdit;
    edtVideoRight: TLabeledEdit;
    edtVideoBottom: TLabeledEdit;
    tsServer: TTabSheet;
    Label6: TLabel;
    edtPort: TEdit;
    Label7: TLabel;
    edtServerIP: TEdit;
    Label8: TLabel;
    cbxTextSize: TComboBox;
    Label9: TLabel;
    edtStoreAddress1: TEdit;
    edtStoreAddress2: TEdit;
    edtStoreAddress3: TEdit;
    pnlDisplayColor: TPanel;
    Label10: TLabel;
    CD: TColorDialog;
    pnlBottomTextColor: TPanel;
    Label11: TLabel;
    pnlDisplayTextColor: TPanel;
    Label12: TLabel;
    Bevel1: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    edtSvrIP: TEdit;
    Label15: TLabel;
    edtSvrPort: TEdit;
    Label16: TLabel;
    edtSvrStation: TEdit;
    btnConnect: TBitBtn;
    lbLang: TLabel;
    cbxLanguage: TComboBox;
    siLang: TsiLang;
    chkAutoResizeAdv: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnImgLogoClick(Sender: TObject);
    procedure pnlDisplayColorClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
  private
    FResult : Boolean;
    procedure LoadConfig;
    procedure SaveConfig;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, IdTCPConnection, IdTCPClient, uPoleDisplay, uDMGlobal;

{$R *.dfm}

{ TFrmScreenConf }

function TFrmScreenConf.Start: Boolean;
begin
  LoadConfig;
  ShowModal;
  Result := FResult;
end;

procedure TFrmScreenConf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmScreenConf.btnCloseClick(Sender: TObject);
begin
  FResult := False;
  Close;
end;

procedure TFrmScreenConf.btnSaveClick(Sender: TObject);
begin
 FResult := True;
 SaveConfig;
 Close;
end;

procedure TFrmScreenConf.LoadConfig;
begin
  cbxInvoiceDisplay.ItemIndex := DM.FScreenConfig.FReceiptPos;
  edtSpeed.Text := IntToStr(DM.FScreenConfig.FTextSpeed);
  edtText.Text := DM.FScreenConfig.FMovingText;
  edtLog.Text := DM.FScreenConfig.FLogo;
  edtVideoLeft.Text := IntToStr(DM.FScreenConfig.FVideoLeft);
  edtVideoTop.Text := IntToStr(DM.FScreenConfig.FVideoTop);
  edtVideoRight.Text := IntToStr(DM.FScreenConfig.FVideoRight);
  edtVideoBottom.Text := IntToStr(DM.FScreenConfig.FVideoBottom);
  edtServerIP.Text := DM.FScreenConfig.FComputerIP;
  edtPort.Text := IntToStr(DM.FScreenConfig.FCompPort);
  cbxTextSize.ItemIndex := DM.FScreenConfig.FTextSize;
  edtStoreAddress1.Text := DM.FScreenConfig.FStoreAdd1;
  edtStoreAddress2.Text := DM.FScreenConfig.FStoreAdd2;
  edtStoreAddress3.Text := DM.FScreenConfig.FStoreAdd3;
  pnlDisplayColor.Color := DM.FScreenConfig.FReceiptBackColor;
  pnlBottomTextColor.Color := DM.FScreenConfig.FTextColor;
  pnlDisplayTextColor.Color := DM.FScreenConfig.FReceiptTextColor;
  edtSvrStation.Text := DM.FScreenConfig.FStationName;
  edtSvrIP.Text := DM.FScreenConfig.FServerIP;
  edtSvrPort.Text := IntToStr(DM.FScreenConfig.FServerPort);
  cbxLanguage.ItemIndex := DM.FScreenConfig.FIDLanguage - 1;
  chkAutoResizeAdv.Checked := DM.FScreenConfig.FAutoResizeAdv;
end;

procedure TFrmScreenConf.SaveConfig;
begin
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_MOVING_TEXT, edtText.Text);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_TEXT_SPEED, StrToIntDef(edtSpeed.Text, 1000));
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONFIG_TEXT_SIZE, cbxTextSize.ItemIndex);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_RECEIPT_POS, cbxInvoiceDisplay.ItemIndex);
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_RECEIPT_LOGO, edtLog.Text);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_LEFT, StrToIntDef(edtVideoLeft.Text, 50));
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_TOP, StrToIntDef(edtVideoTop.Text, 50));
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_RIGHT, StrToIntDef(edtVideoRight.Text, 300));
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_BOTTOM, StrToIntDef(edtVideoBottom.Text, 300));
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_COMPUTER_IP, edtServerIP.Text);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_CONF_COMPUTER_PORT, StrToIntDef(edtPort.Text, 9091));
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_STORE_ADD1, edtStoreAddress1.Text);
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_STORE_ADD2, edtStoreAddress2.Text);
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_STORE_ADD3, edtStoreAddress3.Text);
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_RECEIPT_BACKCOLOR, ColorToString(pnlDisplayColor.Color));
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONFIG_TEXT_COLOR, ColorToString(pnlBottomTextColor.Color));
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_CONF_RECEIPT_TEXTCOLOR, ColorToString(pnlDisplayTextColor.Color));
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_SVR_STATION, edtSvrStation.Text);
  DM.FConfigFile.WriteString(SCREEN_CONF, SCREEN_SVR_IP, edtSvrIP.Text);
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_SVR_PORT, StrToIntDef(edtSvrPort.Text, 7887));
  DM.FConfigFile.WriteInteger(SCREEN_CONF, SCREEN_IDLANGUAGE, cbxLanguage.ItemIndex+1);
  DM.FConfigFile.WriteBool(SCREEN_CONF, SCREEN_RESIZE_ADV, chkAutoResizeAdv.Checked);
  DM.RefreshScreenConfig;
  AfterConstruction;
end;

procedure TFrmScreenConf.btnImgLogoClick(Sender: TObject);
begin
  if OP.Execute then
    edtLog.Text := OP.FileName;
end;

procedure TFrmScreenConf.pnlDisplayColorClick(Sender: TObject);
begin
  with CD do
  begin
    Color := TPanel(Sender).Color;
    if Execute then
      TPanel(Sender).Color := Color;
  end;
end;

procedure TFrmScreenConf.btnConnectClick(Sender: TObject);
begin
  if edtSvrIP.Text <> '' then
  begin
    DM.SetServerConn(edtSvrIP.Text, StrToInt(edtSvrPort.Text));
    with DM.IdTCPClient do
    begin
      if Connected then
        Disconnect;
      try
        try
          Connect(5000);
          //WriteLn(FormatStation(edtSvrStation.Text, edtSvrIP.Text, StrToIntDef(edtSvrPort.Text, 7887)));
        except
          raise;
        end;
      finally
        Disconnect;
      end;
    end;
  end;
end;

end.
