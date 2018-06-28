unit uFrmConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ImgList, OoMisc, AdRas, AdRStat, AdRasUtl,
  siComp;

type

  TFrmConnection = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    cbxConnection1: TComboBox;
    lbStatus1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    cbxConnection2: TComboBox;
    lbStatus2: TLabel;
    btnTest2: TSpeedButton;
    btnTest1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    edtUserName1: TEdit;
    edtPW1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtUserName2: TEdit;
    edtPW2: TEdit;
    immgStatus: TImageList;
    chkCloseVPN1: TCheckBox;
    chkCloseVPN2: TCheckBox;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTest1Click(Sender: TObject);
    procedure btnTest2Click(Sender: TObject);
  private
    { Private declarations }
    fConcNumber : Integer;
    IsTest1, IsTest2 : Boolean;
    procedure GetConnection;
    procedure SetConnection;
    function TestLogIn:Boolean;
    function TestConnection(DailUp, UserName, Password : String):Boolean;
  public
    { Public declarations }
    function Start:Boolean;
  end;

implementation

uses uMainConf, uEncryptFunctions, uDMGlobal, uPOSServerConsts;

{$R *.dfm}

function TFrmConnection.TestLogIn:Boolean;
begin

   Result := True;

   if cbxConnection1.Text <> '' then
      begin
      if cbxConnection1.Text = cbxConnection2.Text then
         begin
         ShowMessage('Cannot connect iqual VPN');
         cbxConnection1.SetFocus; 
         Result := False;
         end;

      if edtUserName1.Text = edtUserName2.Text then
         begin
         ShowMessage('Username cannot be iqual');
         edtUserName1.SetFocus;
         Result := False;
         end;
      end;

end;

procedure TFrmConnection.GetConnection;
begin
  cbxConnection1.Clear;
  cbxConnection2.Clear;

  FrmMain.VPN1.ListEntries(cbxConnection1.Items);
  FrmMain.VPN2.ListEntries(cbxConnection2.Items);

  cbxConnection1.Items.Insert(0,'');
  cbxConnection2.Items.Insert(0,'');

  lbStatus1.Caption := '';
  lbStatus2.Caption := '';

  cbxConnection1.Text  := FrmMain.fNetworkCon.NetworkCon1;
  edtUserName1.Text    := FrmMain.fNetworkCon.UserCon1;
  edtPW1.Text          := FrmMain.fNetworkCon.PWCon1;
  chkCloseVPN1.Checked := FrmMain.fNetworkCon.StopVPN1;

  cbxConnection2.Text  := FrmMain.fNetworkCon.NetworkCon2;
  edtUserName2.Text    := FrmMain.fNetworkCon.UserCon2;
  edtPW2.Text          := FrmMain.fNetworkCon.PWCon2;
  chkCloseVPN2.Checked := FrmMain.fNetworkCon.StopVPN2;

  immgStatus.GetBitmap(0, btnTest1.Glyph);
  immgStatus.GetBitmap(0, btnTest2.Glyph);

end;

procedure TFrmConnection.SetConnection;
var
  Connect1,
  Connect2 : String;
begin

  Connect1 := SV_CONNECTION +cbxConnection1.Text +';'+
              SV_USER       +edtUserName1.Text   +';'+
              SV_PASSWORD   +edtPW1.Text         +';'+
              SV_CLOSE_VPN  +BoolToStr(chkCloseVPN1.Checked, True)+';';

  Connect2 := SV_CONNECTION +cbxConnection2.Text +';'+
              SV_USER       +edtUserName2.Text   +';'+
              SV_PASSWORD   +edtPW2.Text         +';'+
              SV_CLOSE_VPN  +BoolToStr(chkCloseVPN2.Checked, True)+';';

  FrmMain.fIniConfig.WriteString('NetworkConnections','Connection1', EncodeServerInfo(Connect1, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX));
  FrmMain.fIniConfig.WriteString('NetworkConnections','Connection2', EncodeServerInfo(Connect2, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX));
  FrmMain.LoadParamNetwork;

end;

function TFrmConnection.Start:Boolean;
begin

   GetConnection;

   IsTest1 := False;
   IsTest2 := False;

   ShowModal;

   Result := (ModalResult=mrOK);

   if Result then
      SetConnection;

end;


procedure TFrmConnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

 if IsTest1 then
    if FrmMain.VPN1.ConnectState = csRasConnected then
       FrmMain.VPN1.Hangup;

 If IsTest2 then
    if FrmMain.VPN2.ConnectState = csRasConnected then
       FrmMain.VPN2.Hangup;

  Action := caFree;
  
end;

function TFrmConnection.TestConnection(DailUp, UserName, Password : String):Boolean;
var
  Error : Integer;
begin

  Result := True; 

  Case fConcNumber of
    1 : Begin
        FrmMain.VPN1.EntryName := DailUp;
        FrmMain.VPN1.UserName  := UserName;
        FrmMain.VPN1.Password  := Password;
        Error := FrmMain.VPN1.Dial;
        if (Error <> ecRasOK) then
           lbStatus1.Caption := FrmMain.VPN1.GetErrorText(Error)
        else
           lbStatus1.Caption := 'Connected';
        end;

    2 : Begin
        FrmMain.VPN2.EntryName := DailUp;
        FrmMain.VPN2.UserName  := UserName;
        FrmMain.VPN2.Password  := Password;
        Error := FrmMain.VPN2.Dial;
        if (Error <> ecRasOK) then
           lbStatus2.Caption := FrmMain.VPN2.GetErrorText(Error)
        else
           lbStatus2.Caption := 'Connected';
        end;
    end

end;

procedure TFrmConnection.btnTest1Click(Sender: TObject);
begin

 if not TestLogIn then
    Exit;

 if FrmMain.VPN1.ConnectState = csRasConnected then
    FrmMain.VPN1.Hangup;
 fConcNumber       := 1;
 lbStatus1.Caption := '';
 btnTest1.Glyph    := nil;

 if btnTest1.Caption = 'Disconnect' then
    begin
    btnTest1.Caption       := 'Connect';
    cbxConnection1.Enabled := True;
    edtUserName1.Enabled   := True;
    edtPW1.Enabled         := True;
    immgStatus.GetBitmap(0, btnTest1.Glyph);
    Exit;
    end
 else
    begin
    btnTest1.Caption  := 'Disconnect';
    immgStatus.GetBitmap(1, btnTest1.Glyph);
    cbxConnection1.Enabled := False;
    edtUserName1.Enabled   := False;
    edtPW1.Enabled         := False;
    end;

 IsTest1 := True;

 if TestConnection(cbxConnection1.Text, edtUserName1.Text, edtPW1.Text) then
    begin
    end;

end;

procedure TFrmConnection.btnTest2Click(Sender: TObject);
begin

 if not TestLogIn then
    Exit;

 if FrmMain.VPN2.ConnectState = csRasConnected then
    FrmMain.VPN2.Hangup;
 fConcNumber       := 2;
 lbStatus2.Caption := '';
 btnTest2.Glyph    := nil;

 if btnTest2.Caption = 'Disconnect' then
    begin
    btnTest2.Caption       := 'Connect';
    cbxConnection2.Enabled := True;
    edtUserName2.Enabled   := True;
    edtPW2.Enabled         := True;
    immgStatus.GetBitmap(0, btnTest2.Glyph);
    Exit;
    end
 else
    begin
    btnTest2.Caption       := 'Disconnect';
    cbxConnection2.Enabled := False;
    edtUserName2.Enabled   := False;
    edtPW2.Enabled         := False;
    immgStatus.GetBitmap(1, btnTest2.Glyph);
    end;

 IsTest2 := True;

 if TestConnection(cbxConnection2.Text, edtUserName2.Text, edtPW2.Text) then
    begin
    end;

end;

end.
