unit uMainConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, IniFiles, shellapi, Menus, OoMisc, AdRasUtl,
  AdRas, uReplicationClasses, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, siComp, IdIOHandler, IdIOHandlerSocket,
  IdSocks, ComCtrls, IdFTP (*,URepSocketTypes
  {uClientThread *);

const
  CONST_CLIENT = 'reptest';
  CONST_STORE  = 'repcli';



  HISTORY_FILE   = 'history.txt';
  ERROR_FILE     = 'error.txt';
  CONFIG_FILE    = 'localconfig.ini';
  MR_SYSTEM_TIP  = 'MainRetail replication monitor';
  WM_ICONMESSAGE = WM_USER + 1;

  WHERE_STOREID = 1;

  MR_HST_GLOBAL_FILE_NOT_FOUND  = 'Global file not found. ';
  MR_HST_OK                     = 'Replication succeed. ';
  MR_HST_ERROR                  = 'Replication error: ';
  MR_HST_CONT_FAIL              = 'Local Connection fail. ';
  MR_HST_SVR_CONT_FAIL          = 'Server Connection fail. ';
  MR_HST_JOB_FAIL               = 'Job fail : ';
  MR_HST_VPN_FAIL               = 'VPN fail to connect.';

  REG_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

  SV_CONNECTION = '#CNT#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_CLOSE_VPN  = '#CVPN#=';

type
  TServerConnection = class
     private
       fClientInfo        : String;
       fClientVersion     : String;
       fConnectionTimeOut : Integer;
       fReplicateSince    : Integer;
       fPacketSize        : Integer;
       fConnectType       : Integer;
     public
       property ClientInfo        : String  read fClientInfo        write fClientInfo;
       property ClientVersion     : String  read fClientVersion     write fClientVersion;
       property ConnectionTimeOut : Integer read fConnectionTimeOut write fConnectionTimeOut;
       property ReplicateSince    : Integer read fReplicateSince    write fReplicateSince;
       property PacketSize        : Integer read fPacketSize        write fPacketSize;
       property ConnectType       : Integer read fConnectType       write fConnectType;
  end;

  TParamsConfig = class
     private
      fWaitJob      : Integer;
      fWaitJobStart : Integer;
      fCallJob      : Integer;
      fDefaultStore : Integer;
      fGlobalTables : String;
      fLocalTables  : String;
      fExceptTables : String;
      fNextSchedule : TDateTime;
      fLastSchedule : TDateTime;
      fDisableSchedule: Boolean;
      fSQLBatchCount: Integer;
      fExceptFields: String;
      fInsertTables: String;
      fDisableUpdateQty: Boolean;
      procedure SetTime(iTime:Integer);
     public
      property WaitJob           : Integer   read fWaitJob           write fWaitJob;
      property WaitJobStart      : Integer   read fWaitJobStart      write fWaitJobStart;
      property CallJob           : Integer   read fCallJob           write SetTime;
      property DefaultStore      : Integer   read fDefaultStore      write fDefaultStore;
      property GlobalTables      : String    read fGlobalTables      write fGlobalTables;
      property LocalTables       : String    read fLocalTables       write fLocalTables;
      property ExceptTables      : String    read fExceptTables      write fExceptTables;
      property ExceptFields      : String    read fExceptFields      write fExceptFields;
      property InsertTables      : String    read fInsertTables      write fInsertTables;
      property NextSchedule      : TDateTime read fNextSchedule      write fNextSchedule;
      property LastSchedule      : TDateTime read fLastSchedule      write fLastSchedule;
      property DisableSchedule   : Boolean   read fDisableSchedule   write fDisableSchedule;
      property DisableUpdateQty  : Boolean   read fDisableUpdateQty  write fDisableUpdateQty;
      property SQLBatchCount     : Integer   read fSQLBatchCount     write fSQLBatchCount;
  end;

  TNetworkCon = class
     private
      fNetworkCon1  : string;
      fUserCon1     : string;
      fPWCon1       : string;
      fStopVPN1     : boolean;
      fNetworkCon2  : string;
      fUserCon2     : string;
      fPWCon2       : string;
      fStopVPN2     : boolean;
     public
      property NetworkCon1  : String    read fNetworkCon1  write fNetworkCon1;
      property UserCon1     : String    read fUserCon1     write fUserCon1;
      property PWCon1       : String    read fPWCon1       write fPWCon1;
      property StopVPN1     : Boolean   read fStopVPN1     write fStopVPN1;
      property NetworkCon2  : String    read fNetworkCon2  write fNetworkCon2;
      property UserCon2     : String    read fUserCon2     write fUserCon2;
      property PWCon2       : String    read fPWCon2       write fPWCon2;
      property StopVPN2     : Boolean   read fStopVPN2     write fStopVPN2;
  end;

  TSocketConfig = class
     private
      fHost       : String;
      fPort       : String;
      fProxPort   : String;
      fProxPW     : String;
      fProxUser   : String;
      fProxServer : String;
      fSockVer    : String;
      fAuthentic  : Boolean;
     public
      property Host         : String    read fHost         write fHost;
      property Port         : String    read fPort         write fPort;
      property ProxServer   : String    read fProxServer   write fProxServer;
      property ProxPort     : String    read fProxPort     write fProxPort;
      property ProxUser     : String    read fProxUser     write fProxUser;
      property ProxPW       : String    read fProxPW       write fProxPW;
      property SockVer      : String    read fSockVer      write fSockVer;
      property Authentic    : Boolean   read fAuthentic    write fAuthentic;
  end;

  TFrmMain = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    lbStatus: TLabel;
    pop: TPopupMenu;
    mExecute: TMenuItem;
    mExit: TMenuItem;
    N1: TMenuItem;
    TimerJob: TTimer;
    VPN1: TApdRasDialer;
    VPN2: TApdRasDialer;
    TCPClient: TIdTCPClient;
    IdSocksInfo1: TIdSocksInfo;
    IdIOHandlerSocket1: TIdIOHandlerSocket;
    Shape2: TShape;
    Shape1: TShape;
    Label6: TLabel;
    lbTitle: TLabel;
    Label13: TLabel;
    NoteInfo: TNotebook;
    Image11: TImage;
    Label15: TLabel;
    Image12: TImage;
    Label16: TLabel;
    Image13: TImage;
    Label17: TLabel;
    Image14: TImage;
    Label18: TLabel;
    Label10: TLabel;
    Image7: TImage;
    Image8: TImage;
    Label11: TLabel;
    Label9: TLabel;
    lbLastSchedule: TLabel;
    lbNextSchedule: TLabel;
    Image9: TImage;
    Image10: TImage;
    Label19: TLabel;
    Image15: TImage;
    Label20: TLabel;
    Image16: TImage;
    lbJobs: TLabel;
    Image3: TImage;
    lbConnection: TLabel;
    Image5: TImage;
    lbSchedules: TLabel;
    Image1: TImage;
    lbForceRepli: TLabel;
    Image4: TImage;
    lbHistory: TLabel;
    Shape3: TShape;
    lbReplStatus: TLabel;
    pbRepl: TProgressBar;
    Image2: TImage;
    lbStoreConfig: TLabel;
    Image6: TImage;
    lbStoreInf: TLabel;
    siLang: TsiLang;
    lblServerVersion: TLabel;
    IdFTP1: TIdFTP;
    procedure SpeedButton1Click(Sender: TObject);
    procedure lbSchedulesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbHistoryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbJobsClick(Sender: TObject);
    procedure IconHandler(var msg: TMessage); message WM_ICONMESSAGE;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mExitClick(Sender: TObject);
    procedure TimerJobTimer(Sender: TObject);
    procedure lbConnectionClick(Sender: TObject);
    procedure lbForceRepliClick(Sender: TObject);
    procedure lbJobsMouseEnter(Sender: TObject);
    procedure lbJobsMouseLeave(Sender: TObject);
    procedure lbStoreConfigClick(Sender: TObject);
  private
    { Private declarations }
    NIcon : TNotifyIconData; //Icon Tray
    fExit : Boolean;
    fForceReplication : Boolean;
    (* ClientThread : TClientThread; *)
    function ExecuteSchedule:Boolean;
    function IsJobRunning:Boolean;
    procedure ClearTitle;

    procedure PrepareInfo;

    procedure OnTerminateThread(Sender: TObject);
    procedure OnReplicationStatus(Msg: String; Count: Integer);
    procedure OnReplicationStepCompleted;

  public
    { Public declarations }
    fJobParam         : TParamsConfig;
    fNetworkCon       : TNetworkCon;
    fSocketConfig     : TSocketConfig;
    fServerConnection : TServerConnection;
    fIniConfig        : TIniFile;
    property ForceReplication : Boolean read fForceReplication;
    function DisplayNextSchedule:String;
    function DisplayLastSchedule:String;
    procedure SaveNextSchedule;
    procedure OpenStoreKey;


    procedure LoadParamAll;
    procedure LoadParamTask;
    procedure LoadParamNetwork;
    procedure LoadParamGlobalTables;
    procedure LoadParamLocalTables;
    procedure LoadParamExceptionTable;
    procedure LoadParamSocket;
    procedure LoadParamServerConnection;

    procedure RefreshReplStatus;
    procedure SchedulePrepareInfo;
    procedure ResetInfo;
    procedure UnPrepareInfo;

    procedure SetReplStatus(sLabel:String; MaxValue : Integer);

    function StartVPN:Boolean;


    (*
    function RunSocket: Boolean;
    *)
    procedure ConfigureSocket;
  end;

var
  FrmMain: TFrmMain;

implementation

uses uFrmSchedule, uDateTimeFunctions, DateUtils, tExecuteTask,
     uFrmJobs, uFrmHistory, uFrmConnection, uEncryptFunctions,
     uParamFunctions, uFrmStoreType, Registry;

{$R *.dfm}

var
  ExecuteTaskThread: TThreadExecuteTask = nil;


{ TParamsConfig }

procedure TParamsConfig.SetTime(iTime:Integer);
begin
   fCallJob                   := iTime;
   FrmMain.TimerJob.Enabled   := False;
   FrmMain.TimerJob.Interval  := CallJob;
   FrmMain.TimerJob.Enabled   := True;
end;


{ TFrmMain }

function TFrmMain.IsJobRunning:Boolean;
begin
   Result := (ExecuteTaskThread <> nil);
   (*
   if Result then
      Result := ExecuteTaskThread.Running;*)
end;

procedure TFrmMain.SaveNextSchedule;
var
  MyTime : TDateTime;
begin

  if fForceReplication then
     Exit;

  MyTime := fJobParam.NextSchedule;

  Case fIniConfig.ReadInteger('Tasks','Every',0) of
    0: MyTime := (AddHours(MyTime, fIniConfig.ReadInteger('Tasks','Interval',1)));
    1: MyTime := (AddMinutes(MyTime, fIniConfig.ReadInteger('Tasks','Interval',1)));
  end;

  Case fIniConfig.ReadInteger('Tasks','Occurs',0) of
    0: MyTime := IncDay(MyTime, 0);
    1: MyTime := IncDay(MyTime, 7);
    2: MyTime := IncMonth(MyTime, 1);
  end;

  if MyTime < Now then
     MyTime := Now;

  fIniConfig.WriteDateTime('Tasks','LastSchedule', fJobParam.LastSchedule);
  fJobParam.LastSchedule := fJobParam.NextSchedule;

  fIniConfig.WriteDateTime('Tasks','NextSchedule', MyTime);
  fJobParam.NextSchedule := MyTime;

end;

procedure TFrmMain.UnPrepareInfo;
begin
   mExecute.Enabled          := True;
   mExit.Enabled             := True;
   lbNextSchedule.Caption    := DisplayNextSchedule;
   lbLastSchedule.Caption    := DisplayLastSchedule;
   lbNextSchedule.Font.Color := clWindowText;
   lbStatus.Caption          := 'Idle';
   NoteInfo.PageIndex        := 0;
   ResetInfo;
   SetReplStatus('', 0);
   Application.ProcessMessages;
end;

function TFrmMain.StartVPN:Boolean;
var
  iTime : Integer;
begin

  Result := True;
  iTime  := 0;

  if (fNetworkCon.NetworkCon1 <> '') and
     (VPN1.ConnectState <> csRasConnected) then
     begin
     VPN1.EntryName := fNetworkCon.NetworkCon1;
     VPN1.Username  := fNetworkCon.UserCon1;
     VPN1.Password  := fNetworkCon.PWCon1;
     Result := (VPN1.Dial = ecRasOK);
     if not Result then
        Exit;
     while not (VPN1.ConnectState = csRasConnected) do
        begin
        inc(iTime);
        Application.ProcessMessages;
        Sleep(3000);
        if iTime > 100 then
           begin
           Result := false;
           Break;
           end;
        end;
     end;

  iTime := 0;

  if (fNetworkCon.NetworkCon2 <> '') and
     (VPN2.ConnectState <> csRasConnected) then
     begin
     VPN2.EntryName := fNetworkCon.NetworkCon2;
     VPN2.Username  := fNetworkCon.UserCon2;
     VPN2.Password  := fNetworkCon.PWCon2;
     Result := (VPN2.Dial = ecRasOK);
     if not Result then
        Exit;
     while not (VPN2.ConnectState = csRasConnected) do
        begin
        inc(iTime);
        Application.ProcessMessages;
        Sleep(3000);
        if iTime > 100 then
           begin
           Result := False;
           Break;
           end;
        end;
     end;
end;


   procedure TFrmMain.PrepareInfo;
   begin
   mExecute.Enabled          := False;
   mExit.Enabled             := False;
   lbNextSchedule.Caption    := lbNextSchedule.Caption + ' [Executing ...]';
   lbNextSchedule.Font.Color := clRed;
   lbStatus.Caption          := 'Running schedule (please wait)...';
   Application.ProcessMessages;
   end;



function TFrmMain.ExecuteSchedule:Boolean;
begin

  Result := False;

  //Verifico a hora do job schedule
  if not fForceReplication then
     if not (fJobParam.NextSchedule < Now) then
        Exit;

  PrepareInfo;

  if fIniConfig.ReadInteger('Local','IDDefaultStore', -1) = -1 then
     begin
     OpenStoreKey;
     fJobParam.DefaultStore := fIniConfig.ReadInteger('Local','IDDefaultStore', 1);
     end;

  LoadParamGlobalTables;
  LoadParamLocalTables;
  LoadParamExceptionTable;
  LoadParamSocket;

  //Connecta no VPN
  if not StartVPN then
     begin
     //DMClient.AddHistory(MR_HST_ERROR+MR_HST_VPN_FAIL);
     Exit;
     end;

  Application.ProcessMessages;


  (*
  //Abro a coneccao com o bancos
  if not DMClient.OpenConnection then
     Exit;
  *);

  Application.ProcessMessages;

  //Verifico se o Schedule ja esta rodando
  if ExecuteTaskThread <> nil then
     if not ExecuteTaskThread.Running then
        FreeAndNil(ExecuteTaskThread)
     else
        Exit;

  //Execute Jobs
  ExecuteTaskThread := TThreadExecuteTask.Create(True);
  try
    ExecuteTaskThread.LocalPath        := ExtractFilePath(Application.ExeName);
    ExecuteTaskThread.GlobalTables     := fJobParam.GlobalTables;
    ExecuteTaskThread.SQLBatchCount    := fJobParam.SQLBatchCount;
    ExecuteTaskThread.ExceptTables     := fJobParam.ExceptTables;
    ExecuteTaskThread.ExceptFields     := fJobParam.ExceptFields;
    ExecuteTaskThread.LocalTables      := fJobParam.LocalTables;
    ExecuteTaskThread.InsertTables     := fJobParam.InsertTables;
    ExecuteTaskThread.DisableUpdateQty := fJobParam.DisableUpdateQty;
    ExecuteTaskThread.ReplicateSince   := fServerConnection.ReplicateSince;
    ExecuteTaskThread.ClientInfo       := fServerConnection.ClientInfo;
    ExecuteTaskThread.Host             := fSocketConfig.Host;
    ExecuteTaskThread.DefaultStore     := fJobParam.fDefaultStore;
    ExecuteTaskThread.Priority         := tpLower;
    ExecuteTaskThread.FreeOnTerminate  := True;
    ExecuteTaskThread.OnTerminate      := OnTerminateThread;

    ExecuteTaskThread.OnReplicationStatus := OnReplicationStatus;
    ExecuteTaskThread.OnReplicationStepCompleted := OnReplicationStepCompleted;



    if ExecuteTaskThread.Suspended then
       ExecuteTaskThread.Resume;

    SchedulePrepareInfo;
    
    Result := True;
  finally
     end;

end;

function TFrmMain.DisplayLastSchedule:String;
begin
   if fIniConfig.ReadString('Tasks','LastSchedule', '') = '' then
      Result := ''
   else
      Result := FormatDateTime('"The last schedule was on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM', fJobParam.LastSchedule);
end;

function TFrmMain.DisplayNextSchedule:String;
begin
   if fIniConfig.ReadString('Tasks','NextSchedule', '') = '' then
      Result := ''
   else
      Result := FormatDateTime('"The next schedule is on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM', fJobParam.NextSchedule);
end;

procedure TFrmMain.SpeedButton1Click(Sender: TObject);
begin
   Close;
end;

procedure TFrmMain.lbSchedulesClick(Sender: TObject);
begin

   if IsJobRunning then
      Exit;

   with TFrmSchedule.Create(Self) do
        if Start then
           begin
           LoadParamTask;
           lbNextSchedule.Caption := DisplayNextSchedule;
           lbLastSchedule.Caption := DisplayLastSchedule;
           end;
end;

procedure TFrmMain.LoadParamTask;
begin
  fJobParam.WaitJob          := fIniConfig.ReadInteger('Timer','WaitJobStart', 10)*1000;
  fJobParam.WaitJobStart     := fIniConfig.ReadInteger('Timer','WaitJob', 30)*1000;
  fJobParam.CallJob          := fIniConfig.ReadInteger('Timer','CallJob', 10)*60000;
  fJobParam.NextSchedule     := fIniConfig.ReadDateTime('Tasks','NextSchedule',Now);
  fJobParam.LastSchedule     := fIniConfig.ReadDateTime('Tasks','LastSchedule',Now);
  fJobParam.DisableSchedule  := fIniConfig.ReadBool('Tasks', 'DisableSchedule', False);
  fJobParam.SQLBatchCount    := fIniConfig.ReadInteger('ServerConnection', 'SQLBatchCount', uReplicationClasses.DEFAULT_SQL_BATCH_COUNT);
  fJobParam.DefaultStore     := fIniConfig.ReadInteger('Local', 'IDDefaultStore', 0);
  fJobParam.DisableUpdateQty := fIniConfig.ReadBool('Setup', 'DisableUpdateQty', False);
end;

procedure TFrmMain.LoadParamNetwork;
var
  Connect1,
  Connect2 : String;
begin

  Connect1  := fIniConfig.ReadString('NetworkConnections','Connection1', '');
  Connect2  := fIniConfig.ReadString('NetworkConnections','Connection2', '');

  Connect1 := DecodeServerInfo(Connect1, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);
  Connect2 := DecodeServerInfo(Connect2, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);

  fNetworkCon.NetworkCon1 := ParseParam(Connect1, SV_CONNECTION);
  fNetworkCon.UserCon1    := ParseParam(Connect1, SV_USER);
  fNetworkCon.PWCon1      := ParseParam(Connect1, SV_PASSWORD);
  fNetworkCon.StopVPN1    := StrToBoolDef(ParseParam(Connect1, SV_CLOSE_VPN) ,False);

  fNetworkCon.NetworkCon2 := ParseParam(Connect2, SV_CONNECTION);
  fNetworkCon.UserCon2    := ParseParam(Connect2, SV_USER);
  fNetworkCon.PWCon2      := ParseParam(Connect2, SV_PASSWORD);
  fNetworkCon.StopVPN2    := StrToBoolDef(ParseParam(Connect2, SV_CLOSE_VPN) ,False);

end;

procedure TFrmMain.LoadParamGlobalTables;
begin
  fJobParam.GlobalTables := fIniConfig.ReadString('GlobalTables','Tables', '');
end;

procedure TFrmMain.LoadParamSocket;
begin
  fSocketConfig.Host        := fIniConfig.ReadString('SocketInfo', 'Host', '');
  fSocketConfig.Port        := fIniConfig.ReadString('SocketInfo', 'Port', '1666');
  fSocketConfig.fProxPort   := fIniConfig.ReadString('SocketInfo', 'ProxPort', '');
  fSocketConfig.fProxPW     := DecodeServerInfo(fIniConfig.ReadString('SocketInfo', 'ProxPW', ''), 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);
  fSocketConfig.fProxUser   := fIniConfig.ReadString('SocketInfo', 'ProxUser', '');
  fSocketConfig.fProxServer := fIniConfig.ReadString('SocketInfo', 'ProxServer', '');
  fSocketConfig.SockVer     := fIniConfig.ReadString('SocketInfo', 'SocketVersion', 'svNoSocks');
  fSocketConfig.Authentic   := fIniConfig.ReadBool('SocketInfo', 'Authentication', False);
end;


procedure TFrmMain.LoadParamAll;
begin
  LoadParamTask;
  LoadParamNetwork;
  LoadParamGlobalTables;
  LoadParamLocalTables;
  LoadParamExceptionTable;
  LoadParamSocket;
  LoadParamServerConnection;
end;

procedure TFrmMain.OpenStoreKey;
begin
  with TRegistry.Create Do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SOFTWARE\Applenet\MainRetail', True);
    if ValueExists('DefaultStoreID') then
       fIniConfig.WriteInteger('Local','IDDefaultStore', ReadInteger('DefaultStoreID'));
    Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  Reg : TRegistry;
begin
  (*
  ClientThread := nil;
  *)
  fIniConfig        := TIniFile.Create(ExtractFilepath(Application.ExeName)+CONFIG_FILE);
  fExit             := True;
  fJobParam         := TParamsConfig.Create;
  fNetworkCon       := TNetworkCon.Create;
  fSocketConfig     := TSocketConfig.Create;
  fServerConnection := TServerConnection.Create;

  //Colocar o sistema no starup do Windows
  {
  Try
    Reg := TRegistry.Create;
    with Reg Do
      begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey(REG_PATH, False);
      if not ValueExists('MRRepMonitor') then
         WriteString('MRRepMonitor', Application.ExeName);
      end;
  finally
    FreeAndNil(Reg);
  end;
  }
  
  //Save default store
  OpenStoreKey;

  //Adding the icon to the system tray
  {
  with NIcon do
  begin
     Wnd              := Handle;
     cbSize           := sizeof(NIcon);
     uCallbackMessage := WM_ICONMESSAGE;
     uID              :=  1;
     uFlags           := NIF_MESSAGE or NIF_ICON or NIF_TIP;
     szTip            := MR_SYSTEM_TIP;
     hIcon            := Application.Icon.Handle;
     Shell_NotifyIcon(NIM_ADD, @NICON);
  end;
  }
   LoadParamAll;
end;

procedure TFrmMain.lbHistoryClick(Sender: TObject);
begin
  //History
  with TFrmHistory.Create(Self) do
      Start;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @NICON);
  FreeAndNil(fIniConfig);
  FreeAndNil(fJobParam);
  FreeAndNil(fNetworkCon);
  FreeAndNil(fSocketConfig);
  FreeAndNil(fServerConnection);
  FreeAndNil(ExecuteTaskThread);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  lbNextSchedule.Caption := DisplayNextSchedule;
  lbLastSchedule.Caption := DisplayLastSchedule;
  ClearTitle;
end;

procedure TFrmMain.lbJobsClick(Sender: TObject);
begin

   if IsJobRunning then
      Exit;

   with TFrmJobs.Create(Self) do
        Start;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //ShowWindow(handle,0);
   //ShowWindow(Application.Handle, SW_HIDE);
   if fExit then
      Action := caFree
   else
      Action := caNone;
end;

procedure TFrmMain.IconHandler(var msg: TMessage);
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

procedure TFrmMain.mExitClick(Sender: TObject);
begin
  fExit := True;
  Close;
end;

procedure TFrmMain.TimerJobTimer(Sender: TObject);
begin
  if fJobParam.DisableSchedule then
    Exit;
  TimerJob.Enabled  := False;
  fForceReplication := False;
  ExecuteSchedule;
  TimerJob.Enabled  := True;
end;

procedure TFrmMain.lbConnectionClick(Sender: TObject);
begin
   if IsJobRunning then
      Exit;

   with TFrmConnection.Create(Self) do
      Start;
end;

procedure TFrmMain.LoadParamLocalTables;
begin
  fJobParam.LocalTables := fIniConfig.ReadString('LocalTables','Tables', '');
end;

procedure TFrmMain.LoadParamExceptionTable;
begin
  fJobParam.ExceptTables := fIniConfig.ReadString('ExceptionTables','Tables', '');
  fJobParam.ExceptFields := fIniConfig.ReadString('ExceptionTables','Fields', '');
  fJobParam.InsertTables := fIniConfig.ReadString('ExceptionTables','InsertTables', '');
end;

procedure TFrmMain.ConfigureSocket;
var
  fTVersion : TSocksVersion;
  fAutentic : TSocksAuthentication;
begin
  if fSocketConfig.Authentic then
     fAutentic := saUsernamePassword
  else
     fAutentic := saNoAuthentication;

  if fSocketConfig.SockVer = 'svNoSocks' then
     fTVersion := svNoSocks
  else if fSocketConfig.SockVer = 'svSocks4' then
     fTVersion := svSocks4
  else if fSocketConfig.SockVer = 'svSocks4A' then
     fTVersion := svSocks4A
  else
     fTVersion := svSocks5;

  IdSocksInfo1.Authentication := fAutentic;
  IdSocksInfo1.Host           := fSocketConfig.ProxServer;
  IdSocksInfo1.Port           := StrToIntDef(fSocketConfig.ProxPort, 1080);
  IdSocksInfo1.Username       := fSocketConfig.ProxUser;
  IdSocksInfo1.Password       := fSocketConfig.ProxPW;
  IdSocksInfo1.Version        := fTVersion;
end;


procedure TFrmMain.lbForceRepliClick(Sender: TObject);
begin
 //Force replication
 fForceReplication := True;
 ExecuteSchedule;
end;

procedure TFrmMain.ClearTitle;
begin
  lbTitle.Caption := 'Local information';
  NoteInfo.PageIndex := 0;
end;

procedure TFrmMain.lbJobsMouseEnter(Sender: TObject);
begin
  if IsJobRunning then
      Exit;
  lbTitle.Caption := '';
  lbTitle.Caption := TLabel(Sender).Caption;
  NoteInfo.PageIndex := TLabel(Sender).Tag;
end;

procedure TFrmMain.lbJobsMouseLeave(Sender: TObject);
begin
  if IsJobRunning then
      Exit;
  ClearTitle;
end;

procedure TFrmMain.LoadParamServerConnection;
begin
  fServerConnection.ConnectionTimeOut := fIniConfig.ReadInteger('ServerConnection', 'ConnectionTimeOut', 30);
  fServerConnection.ReplicateSince    := fIniConfig.ReadInteger('ServerConnection', 'ReplicateSince', 7);
  fServerConnection.PacketSize        := fIniConfig.ReadInteger('ServerConnection', 'PacketSize', 1024);
  fServerConnection.ConnectType       := fIniConfig.ReadInteger('ServerConnection', 'ConnectType', 2);
  fServerConnection.ClientInfo        := fIniConfig.ReadString('ServerConnection', 'ClientInfo', '');

end;



procedure TFrmMain.SchedulePrepareInfo;
begin
  NoteInfo.PageIndex   := 3;
  lbReplStatus.Visible := True;
  pbRepl.Visible       := True;
  pbRepl.Position      := 0;
end;

procedure TFrmMain.SetReplStatus(sLabel: String; MaxValue: Integer);
begin
  lbReplStatus.Caption := sLabel;
  pbRepl.Position      := 0;
  pbRepl.Max           := MaxValue;
  pbRepl.Visible       := (MaxValue > 0);
  RefreshReplStatus;
end;

procedure TFrmMain.lbStoreConfigClick(Sender: TObject);
begin
   with TFrmStoreType.Create(Self) do
       Start;
end;

procedure TFrmMain.RefreshReplStatus;
begin
  Application.ProcessMessages;
  Sleep(0);
end;

procedure TFrmMain.ResetInfo;
begin
  pbRepl.Visible := False;
  RefreshReplStatus;
end;


procedure TFrmMain.OnTerminateThread(Sender: TObject);
begin
  ExecuteTaskThread := nil;
  UnPrepareInfo;
end;


procedure TFrmMain.OnReplicationStatus(Msg: String; Count: Integer );
begin
  SetReplStatus(Msg, Count);
end;



procedure TFrmMain.OnReplicationStepCompleted;
begin
  pbRepl.StepIt;
  RefreshReplStatus;
end;





initialization



end.
