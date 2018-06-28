unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Menus, Shellapi, siComp;

const
    REG_PATH       = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';
    MR_SYSTEM_TIP  = 'MainRetail Pole Display Server';
    WM_ICONMESSAGE = WM_USER + 1;

type
  TFrmMainScreen = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    Label2: TLabel;
    lbConnection: TLabel;
    MainMenu1: TMainMenu;
    Config1: TMenuItem;
    Setup1: TMenuItem;
    Image3: TImage;
    Label3: TLabel;
    lbVersion: TLabel;
    pop: TPopupMenu;
    mExit: TMenuItem;
    siLang: TsiLang;
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Setup1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mExitClick(Sender: TObject);
    procedure IconHandler(var msg: TMessage); message WM_ICONMESSAGE;
  private
    fExit : Boolean;
    NIcon : TNotifyIconData; //Icon Tray
    procedure RefreshStatus;
  public
    { Public declarations }
  end;

var
  FrmMainScreen: TFrmMainScreen;

implementation

uses uFrmAdvertisingConfig, uDM, uFrmConf, uFrmPoleClients, uFrmCrossSellItems,
     Registry, uOperationSystem;

{$R *.dfm}

procedure TFrmMainScreen.Image2Click(Sender: TObject);
begin
  with TFrmAdvertisingConfig.Create(Self) do
    Start;
end;

procedure TFrmMainScreen.FormShow(Sender: TObject);
begin
  RefreshStatus;
end;

procedure TFrmMainScreen.RefreshStatus;
begin
  if DM.IdTCPServer.Active then
    lbConnection.Caption := 'OnLine. (IP: ' + DM.ServerIP + ' Port:' + IntToStr(DM.ServerPort) + ')'
  else
    lbConnection.Caption := 'OffLine';
end;

procedure TFrmMainScreen.Setup1Click(Sender: TObject);
begin
  with TFrmConf.Create(Self) do
    if Start then
      RefreshStatus;
end;

procedure TFrmMainScreen.Image1Click(Sender: TObject);
begin
  with TFrmPoleClients.Create(Self) do
    Start;
end;

procedure TFrmMainScreen.Image3Click(Sender: TObject);
begin
  with TFrmCrossSellItems.Create(Self) do
    Start;
end;

procedure TFrmMainScreen.FormCreate(Sender: TObject);
var
  Reg : TRegistry;
  buildInfo: String;
begin

  fExit := False;

  Reg := TRegistry.Create;
  try
    with Reg Do
    begin

      if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
      else
        RootKey := HKEY_LOCAL_MACHINE;

      OpenKey(REG_PATH, False);
      try
        if not ValueExists('MRPoleDisplaySvr') then
           WriteString('MRPoleDisplaySvr', Application.ExeName);
      finally
        Reg.CloseKey;
      end;
    end;
  finally
    FreeAndNil(Reg);
  end;

  //Adding the icon to the system tray
  with NIcon do
  begin
    Wnd              := Handle;
    cbSize           := sizeof(NIcon);
    uCallbackMessage := WM_ICONMESSAGE;
    uID              := 1;
    uFlags           := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    szTip            := MR_SYSTEM_TIP;
    hIcon            := Application.Icon.Handle;
    Shell_NotifyIcon(NIM_ADD,@NICON);
  end;

end;

procedure TFrmMainScreen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   ShowWindow(handle,0);
   ShowWindow(Application.Handle, SW_HIDE);
   if fExit then
      Action := caFree
   else
      Action := caNone;
end;

procedure TFrmMainScreen.mExitClick(Sender: TObject);
begin
  fExit := True;
  Close;
end;

procedure TFrmMainScreen.IconHandler(var msg: TMessage);
var
  Pt: TPoint;
begin
   if msg.LParam = WM_RBUTTONdown then
      begin
      GetCursorPos(Pt);
      SetforegroundWindow(handle);
      pop.popup(Pt.X, Pt.Y); // Ur popmenu here..
      end;

   if msg.LParam = wm_lbuttondblclk then
      begin
      ShowWindow(Handle, SW_SHOW);
      SetForeGroundWindow(Handle);
      Show;
      end;

   if msg.LParam = WM_MOUSEMOVE then
      begin
      StrPCopy(Nicon.szTip, MR_SYSTEM_TIP);
      Nicon.uID := 1;
      Shell_Notifyicon(NIM_MODIFY, @Nicon);
      end;

end;

end.
