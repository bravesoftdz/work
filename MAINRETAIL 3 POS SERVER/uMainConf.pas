unit uMainConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, IniFiles, shellapi, Menus,
  ComCtrls, siComp, uPOSServerConsts, uPOSServerTypes, OoMisc, AdRas, AdRasUtl,
  Graphics, Email;

type

  TParamsConfig = class
     private
      fWaitJob      : Integer;
      fWaitJobStart : Integer;
      fCallJobLog   : Integer;
      fCallJobGlobal: Integer;
      fDefaultStore : Integer;
      fNextSchedule : TDateTime;
      fLastSchedule : TDateTime;
      fDisableSchedule: Boolean;
      fDaysToImportSales: Integer;
      procedure SetTimeLog(iTime:Integer);
      procedure SetTimeGlobal(iTime:Integer);
     public
      property WaitJob           : Integer   read fWaitJob           write fWaitJob;
      property WaitJobStart      : Integer   read fWaitJobStart      write fWaitJobStart;
      property CallJobLog        : Integer   read fCallJobLog        write SetTimeLog;
      property CallJobGlobal     : Integer   read fCallJobGlobal     write SetTimeGlobal;
      property DefaultStore      : Integer   read fDefaultStore      write fDefaultStore;
      property NextSchedule      : TDateTime read fNextSchedule      write fNextSchedule;
      property LastSchedule      : TDateTime read fLastSchedule      write fLastSchedule;
      property DisableSchedule   : Boolean   read fDisableSchedule   write fDisableSchedule;
      property DaysToImportSales : Integer   read fDaysToImportSales write fDaysToImportSales;
  end;

  TServerShedule = class(TParamsConfig);
  TPOSShedule    = class(TParamsConfig);

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

  TFrmMain = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    lbStatus: TLabel;
    pop: TPopupMenu;
    mExecute: TMenuItem;
    mExit: TMenuItem;
    N1: TMenuItem;
    TimerLog: TTimer;
    VPN1: TApdRasDialer;
    VPN2: TApdRasDialer;
    Shape2: TShape;
    Shape1: TShape;
    Label6: TLabel;
    lbTitle: TLabel;
    Label13: TLabel;
    NoteInfo: TNotebook;
    Image11: TImage;
    lbSystemInfo: TLabel;
    Image12: TImage;
    lbServerSche: TLabel;
    Image13: TImage;
    lbNextPOS: TLabel;
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
    lbJobs: TLabel;
    lbConnection: TLabel;
    lbSchedules: TLabel;
    Image1: TImage;
    lbForceServerFiles: TLabel;
    Image4: TImage;
    lbHistory: TLabel;
    lbReplStatus: TLabel;
    pbRepl: TProgressBar;
    lbTerminalConfig: TLabel;
    Image6: TImage;
    lbStoreInf: TLabel;
    siLang: TsiLang;
    Image17: TImage;
    Image16: TImage;
    Image3: TImage;
    Image5: TImage;
    lbImportPDVFiles: TLabel;
    Image2: TImage;
    ImportPDVfiles: TMenuItem;
    TimerGlobal: TTimer;
    Image18: TImage;
    lbImportinfo: TLabel;
    lbVersion: TLabel;
    lbServer: TLabel;
    lbPDV: TLabel;
    lbServNextSched: TLabel;
    lbPDVNextSched: TLabel;
    lbServerDisable: TLabel;
    lbPDVDisable: TLabel;
    Image14: TImage;
    lbSalesSummary: TLabel;
    Image19: TImage;
    lbSystemInfoText: TLabel;
    Image20: TImage;
    lbSaleSummary: TLabel;
    FTPTimer: TTimer;
    Image21: TImage;
    lbPDVHistory: TLabel;
    Email: TEmail;
    pnlSendLog: TPanel;
    Image22: TImage;
    lbSendEmail: TLabel;
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
    procedure TimerLogTimer(Sender: TObject);
    procedure lbConnectionClick(Sender: TObject);
    procedure lbForceServerFilesClick(Sender: TObject);
    procedure lbJobsMouseEnter(Sender: TObject);
    procedure lbJobsMouseLeave(Sender: TObject);
    procedure lbImportPDVFilesClick(Sender: TObject);
    procedure lbTerminalConfigClick(Sender: TObject);
    procedure mExecuteClick(Sender: TObject);
    procedure ImportPDVfilesClick(Sender: TObject);
    procedure TimerGlobalTimer(Sender: TObject);
    procedure lbImportinfoClick(Sender: TObject);
    procedure lbSalesSummaryClick(Sender: TObject);
    procedure FTPTimerTimer(Sender: TObject);
    procedure lbPDVHistoryClick(Sender: TObject);
    procedure lbSendEmailClick(Sender: TObject);
  private
    sExec,
    sRunning,
    sInvStore,
    sLastSchedule,
    sNextSchedule: string;

    NIcon : TNotifyIconData; //Icon Tray
    fExit : Boolean;
    fForceSynchronization : Boolean;
    fSynchronizationType : Integer;

    function ExecuteSchedule:Boolean;
    function IsJobRunning:Boolean;
    procedure ClearTitle;
    procedure FillCashIDsList(lstCash: TStringList);
    function SelectImportDate: Boolean;
    function GetIncludeSince(AIDCashReg: Integer; ALastDate: String): String;
    procedure AddHistory(h: String);
    function DeleteHistory : Boolean;
    procedure FillCashregInfo(Lista: TStringList;
      AForceSynchronization: Boolean);

    procedure OnNeedWriteIniBool(ASection, AKey: String; AValue: Boolean);
    procedure OnNeedWriteIniDateTime(ASection, AKey: String; AValue: TDateTime);
    procedure OnNeedWriteIniString(ASection, AKey: String; AValue: String);
    procedure OnNeedWriteIniInteger(ASection, AKey: String; AValue: Integer);

    procedure OnPOSServerStatusEvent(Msg: String; Count: Integer);
    procedure OnPOSServerStepCompleted;
    procedure OnPOSServerCompleted;

    procedure UnblockThread;
    procedure VerifyErrorLog;
  public
    sImportServerFile : String;
    MySch             : TParamsConfig;
    fServerSchedule   : TServerShedule;
    fPOSSchedule      : TPOSShedule;
    fNetworkCon       : TNetworkCon;
    fServerConnection : TServerConnection;
    fIniConfig        : TIniFile;
    fPOSConfig        : TIniFile;
    fLocalSetting     : TLocalSetting;
    fDebug            : Boolean;

    function DisplayNextSchedule(sType:String):String;
    function DisplayLastSchedule(sType:String):String;
    procedure OnSaveNextSchedule(sType:String);
    procedure OpenStoreKey;

    procedure LoadParamAll;
    procedure LoadParamTask(sType : String);
    procedure LoadParamNetwork;
    procedure LoadParamServerConnection;
    procedure LoadLocalSetting;

    procedure RefreshStatus;
    procedure SchedulePrepareInfo;
    procedure ResetInfo;
    procedure UnPrepareInfo;

    procedure SetStatus(sLabel:String; MaxValue : Integer);
    procedure ShowDebug(sMsg:String);

    function StartVPN:Boolean;
    function StopVPN:Boolean;

    procedure ExecuteTask;
  end;

var
  FrmMain: TFrmMain;

implementation

uses uFrmSchedule, uDateTimeFunctions, DateUtils, tExecuteTask, uFrmPDVTerminal,
     uFrmHistory, uFrmConnection, uEncryptFunctions, uDMPOS, uSaveToFile,
     uParamFunctions, Registry, uDMGlobal, uFrmSelectDate, uFrmServerConnection,
     uFrmImportInfo, uFrmSalesExplorer, Math, uMsgBox, uFrmPDVLog,
     uFileFunctions, uOperationSystem;

{$R *.dfm}

var
  ExecuteTaskThread: TThreadExecuteTask = nil;


{ TParamsConfig }

procedure TParamsConfig.SetTimeGlobal(iTime:Integer);
begin
   fCallJobGlobal                := iTime;
   FrmMain.TimerGlobal.Enabled   := False;
   FrmMain.TimerGlobal.Interval  := fCallJobGlobal;
   FrmMain.TimerGlobal.Enabled   := True;
end;

procedure TParamsConfig.SetTimeLog(iTime:Integer);
begin
   fCallJobLog                := iTime;
   FrmMain.TimerLog.Enabled   := False;
   FrmMain.TimerLog.Interval  := fCallJobLog;
   FrmMain.TimerLog.Enabled   := True;
end;


{ TFrmMain }

function TFrmMain.IsJobRunning:Boolean;
begin

   Result := (ExecuteTaskThread <> nil);
   if Result then
      Result := ExecuteTaskThread.Running;

end;

procedure TFrmMain.OnSaveNextSchedule(sType:String);
var
  MyTime : TDateTime;
begin

  if fForceSynchronization then
     Exit;

  if sType = SCH_SERVER then
     mySch := fServerSchedule
  else
     mySch := fPOSSchedule;

  MyTime := mySch.NextSchedule;

  Case fIniConfig.ReadInteger(sType, 'Every', 0) of
    0: MyTime := (AddHours(MyTime, fIniConfig.ReadInteger(sType, 'Interval', 1)));
    1: MyTime := (AddMinutes(MyTime, fIniConfig.ReadInteger(sType, 'Interval', 1)));
  end;

  Case fIniConfig.ReadInteger(sType, 'Occurs', 0) of
    0: MyTime := IncDay(MyTime, 0);
    1: MyTime := IncDay(MyTime, 7);
    2: MyTime := IncMonth(MyTime, 1);
  end;

  if MyTime < Now then
     MyTime := Now;

  mySch.LastSchedule := mySch.NextSchedule;
  fIniConfig.WriteDateTime(sType, 'LastSchedule', mySch.LastSchedule);

  fIniConfig.WriteDateTime(sType, 'NextSchedule', MyTime);
  mySch.NextSchedule := MyTime;

  ShowDebug(sType + ' ' +
            'Last schedule : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', mySch.LastSchedule) +
            'Next schedule : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', MyTime));

  DisplayNextSchedule(sType);
  
end;

procedure TFrmMain.UnPrepareInfo;
begin

   mExecute.Enabled          := True;
   ImportPDVfiles.Enabled    := True;
   mExit.Enabled             := True;
   lbNextSchedule.Caption    := DisplayNextSchedule(SCH_POS);
   DisplayNextSchedule(SCH_SERVER);
   lbLastSchedule.Caption    := DisplayLastSchedule(SCH_POS);
   lbNextSchedule.Font.Color := clWindowText;
   lbStatus.Caption          := 'Idle';
   NoteInfo.PageIndex        := 0;
   fSynchronizationType      := -1;
   ResetInfo;
   SetStatus('', 0);
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
        lbStatus.Caption := 'Conectando Dial-up (1)';
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
        lbStatus.Caption := 'Conectando Dial-up (2)';
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


function TFrmMain.ExecuteSchedule:Boolean;
   procedure PrepareInfo;
   begin
   mExecute.Enabled          := False;
   ImportPDVfiles.Enabled    := False;
   mExit.Enabled             := False;
   lbNextSchedule.Caption    := lbNextSchedule.Caption + sExec;
   lbNextSchedule.Font.Color := clRed;
   lbStatus.Caption          := sRunning;
   Application.ProcessMessages;
   end;

var
   ACashRegInfolist: TStringList;
begin

  Result := False;

  //Clear old log
  if fLocalSetting.DeleteLog < Now then
  begin
    fIniConfig.WriteDate('Local','DeleteLog', (Now+10));
    fLocalSetting.DeleteLog := (Now+10);
    DeleteHistory;
  end;


  case fSynchronizationType of
    SINC_TYPE_SERVER   : mySch := fServerSchedule;
    SINC_TYPE_CASH_LOG : mySch := fPOSSchedule;
    else Exit;
  end;

  //Verifico a hora do job schedule
  ShowDebug('Next schedule : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', mySch.NextSchedule) +
            ' Now : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));

  if not fForceSynchronization then
  begin

    if (mySch.NextSchedule > Now) then
       Exit;

    if (fServerConnection.ConnectType = CON_TYPE_FTP) and
       (fSynchronizationType = SINC_TYPE_CASH_LOG) then
      AddHistory('FTP (POS): Preparando horario ...');
      
  end;

  PrepareInfo;

  if fIniConfig.ReadInteger('Local','IDDefaultStore', -1) = -1 then
  begin
    OpenStoreKey;
    mySch.DefaultStore := fIniConfig.ReadInteger('Local','IDDefaultStore', 1);
  end;

  //Connecta no VPN
  if not StartVPN then
  begin
    AddHistory(MR_HST_ERROR + MR_HST_VPN_FAIL);
    Exit;
  end;

  Application.ProcessMessages;

  //Verifico se o Schedule ja esta rodando
  if ExecuteTaskThread <> nil then
  begin
     if not ExecuteTaskThread.Running then
        FreeAndNil(ExecuteTaskThread)
     else
     begin
       if (not fForceSynchronization) then
       begin
         if (fServerConnection.ConnectType = CON_TYPE_FTP) then
           if (fSynchronizationType = SINC_TYPE_CASH_LOG) then
               AddHistory('FTP (POS): Nao enviar. Horario esta sendo executado!')
             else
               AddHistory('FTP (GLOBAL): Nao baixar. Horario esta sendo executado!');
         Exit;
       end
       else if (fServerConnection.ConnectType = CON_TYPE_FTP) and (fSynchronizationType = SINC_TYPE_CASH_LOG) then
       begin
         if (MsgBox('Re-enviar vendas?', vbQuestion + vbYesNo) = vbYes) then
         begin
           AddHistory('FTP (POS): RE-ENVIANDO!');
           UnblockThread;
         end;
       end;
     end;
  end;

  ACashRegInfolist := TStringList.Create;

  //Habilita timer para enviar os arquivos de vendas
  if (fServerConnection.ConnectType = CON_TYPE_FTP) and
     (fSynchronizationType = SINC_TYPE_CASH_LOG) and (not fForceSynchronization) then
  begin
    FTPTimer.Interval := 600000; //10 min
    FTPTimer.Enabled := True;
  end;

  
  //Execute Jobs
  ExecuteTaskThread := TThreadExecuteTask.Create(True);
  try

    ExecuteTaskThread.Priority := tpLower;

    ExecuteTaskThread.IDStore := mySch.fDefaultStore;
    ExecuteTaskThread.ServerConnection := fServerConnection;
    ExecuteTaskThread.LocalSetting := fLocalSetting;

    ExecuteTaskThread.ForceSynchronization := fForceSynchronization;


    FillCashregInfo(ACashRegInfolist, fForceSynchronization);


    ExecuteTaskThread.CashRegInfolist := ACashRegInfolist;
    ExecuteTaskThread.SynchronizationType := fSynchronizationType;

    ExecuteTaskThread.OnNeedWriteIniBool := OnNeedWriteIniBool;
    ExecuteTaskThread.OnNeedWriteIniDateTime := OnNeedWriteIniDateTime;
    ExecuteTaskThread.OnNeedWriteIniInteger := OnNeedWriteIniInteger;
    ExecuteTaskThread.OnNeedWriteIniString := OnNeedWriteIniString;

    ExecuteTaskThread.OnPOSServerStatusEvent := OnPOSServerStatusEvent;
    ExecuteTaskThread.OnPOSServerStepCompleted := OnPOSServerStepCompleted;
    ExecuteTaskThread.OnPOSServerCompleted := OnPOSServerCompleted;
    ExecuteTaskThread.OnSaveNextSchedule := OnSaveNextSchedule;

     if ExecuteTaskThread.Suspended then
        ExecuteTaskThread.Resume;
     Result := True;
  finally
     end;

  SchedulePrepareInfo;

end;

function TFrmMain.DisplayLastSchedule(sType:String):String;
begin
   if sType = SCH_SERVER then
      mySch := fServerSchedule
   else
      mySch := fPOSSchedule;

   if fIniConfig.ReadString(sType,'LastSchedule', '') = '' then
      Result := ''
   else
      Result := FormatDateTime(sLastSchedule, mySch.LastSchedule);
end;

function TFrmMain.DisplayNextSchedule(sType:String):String;
begin
   if sType = SCH_SERVER then
      mySch := fServerSchedule
   else
      mySch := fPOSSchedule;

   if fIniConfig.ReadString(sType,'NextSchedule', '') = '' then
      Result := ''
   else
      Result := FormatDateTime(sNextSchedule, mySch.NextSchedule);

   if sType = SCH_POS then
    lbNextPOS.Caption := FormatDateTime('dd/mm/yyyy hh:mm', mySch.NextSchedule)
   else if sType = SCH_SERVER then
    lbServerSche.Caption := FormatDateTime('dd/mm/yyyy hh:mm', mySch.NextSchedule);

   Application.ProcessMessages;
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
           LoadParamTask(SCH_SERVER);
           LoadParamTask(SCH_POS);
           lbNextSchedule.Caption := DisplayNextSchedule(SCH_POS);
           lbLastSchedule.Caption := DisplayLastSchedule(SCH_POS);
           DisplayNextSchedule(SCH_SERVER);
           end;

end;

procedure TFrmMain.LoadParamTask(sType : String);
begin
  if sType = SCH_SERVER then
     mySch := fServerSchedule
  else
     mySch := fPOSSchedule;

  mySch.WaitJob         := fIniConfig.ReadInteger('Timer','WaitJobStart', 10)*1000;
  mySch.WaitJobStart    := fIniConfig.ReadInteger('Timer','WaitJob', 30)*1000;
  mySch.CallJobLog      := fIniConfig.ReadInteger('Timer','CallJobLog', 10)*60000;
  mySch.CallJobGlobal   := fIniConfig.ReadInteger('Timer','CallJobGlobal', 15)*60000;
  mySch.NextSchedule    := fIniConfig.ReadDateTime(sType,'NextSchedule',Now);
  mySch.LastSchedule    := fIniConfig.ReadDateTime(sType,'LastSchedule',Now);
  mySch.DisableSchedule := fIniConfig.ReadBool(sType, 'DisableSchedule', False);

  if sType = SCH_SERVER then
     lbServerDisable.Visible := mySch.DisableSchedule
  else
     lbPDVDisable.Visible := mySch.DisableSchedule

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

procedure TFrmMain.LoadParamAll;
begin

  LoadParamTask(SCH_SERVER);
  mySch.DefaultStore := fIniConfig.ReadInteger('Local','IDDefaultStore', 1);
  LoadParamTask(SCH_POS);
  mySch.DefaultStore := fIniConfig.ReadInteger('Local','IDDefaultStore', 1);
  LoadParamNetwork;
  LoadParamServerConnection;
  LoadLocalSetting;

end;

procedure TFrmMain.OpenStoreKey;
var
  buildInfo: String;
begin
  with TRegistry.Create Do
    begin
    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
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
  buildInfo: String;
begin
  fIniConfig        := TIniFile.Create(DMPOS.LocalPath + CONFIG_FILE);
  fPOSConfig        := TIniFile.Create(DMPOS.LocalPath + CONFIG_PDV_FILE);
  fExit             := False;
  fServerSchedule   := TServerShedule.Create;
  fPOSSchedule      := TPOSShedule.Create;

  fNetworkCon       := TNetworkCon.Create;
  fLocalSetting     := TLocalSetting.Create;
  fServerConnection := TServerConnection.Create;

  //Colocar o sistema no starup do Windows

  Try
    Reg := TRegistry.Create;
    with Reg Do
      begin

      if ( getOS(buildInfo) = osW7 ) then
          RootKey := HKEY_CURRENT_USER
      else
          RootKey := HKEY_LOCAL_MACHINE;
          
      OpenKey(REG_PATH, False);
      if not ValueExists('POSServer') then
         WriteString('POSServer', Application.ExeName);
      end;
  finally
    FreeAndNil(Reg);
    end;

  if fIniConfig.ReadString('Local','Customer', '') = '' then
     fIniConfig.WriteString('Local','Customer', 'MainRetail');

  if fIniConfig.ReadString('Local','DeleteLog', '') = '' then
     fIniConfig.WriteDate('Local','DeleteLog', Now+10);

  //Adding the icon to the system tray
  with NIcon do
     begin
     Wnd              :=Handle;
     cbSize           :=sizeof(NIcon);
     uCallbackMessage :=WM_ICONMESSAGE;
     uID              := 1;
     uFlags           :=NIF_MESSAGE or NIF_ICON or NIF_TIP;
     szTip            :=MR_SYSTEM_TIP;
     hIcon            :=Application.Icon.Handle;
     Shell_NotifyIcon(NIM_ADD,@NICON);
     end;

   case DMGlobal.IDLanguage of
     LANG_ENGLISH :
            begin
              sExec             := ' [Executing ...]';
              sRunning          := 'Running schedule (please wait)...';
              sInvStore         := 'Invalid store ...';
              sLastSchedule     := '"The last schedule was on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM';
              sNextSchedule     := '"The next schedule is on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM';
              sImportServerFile := 'Import Server files';
            end;
     LANG_PORTUGUESE :
            begin
              sExec             := ' [Executando ...]';
              sRunning          := 'Executando programação (por favor espere)...';
              sInvStore         := 'Loja inválida ...';
              sLastSchedule     := '"O último calandário foi " dddd, mmmm d, yyyy, " as " hh:mm AM/PM';
              sNextSchedule     := '"O próximo calandário será " dddd, mmmm d, yyyy, " as " hh:mm AM/PM';
              sImportServerFile := 'Importação de Cadastros';
            end;
     LANG_SPANISH :
            begin
              sExec             := ' [Executing ...]';
              sRunning          := 'Running schedule (please wait)...';
              sInvStore         := 'Invalid store ...';
              sLastSchedule     := '"The last schedule was on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM';
              sNextSchedule     := '"The next schedule is on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM';
              sImportServerFile := 'Import Server files';
            end;
   end;


  LoadParamAll;

  with TRegistry.Create do
  try
    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_LOCAL_MACHINE
    else
      RootKey := HKEY_LOCAL_MACHINE;
        
    OpenKey('SOFTWARE\Applenet\POS', True);

    if not ValueExists('SalesFilesToExp') then
      WriteInteger('SalesFilesToExp', 3);

    MySch.DaysToImportSales := ReadInteger('SalesFilesToExp');
  finally
    Free;
  end;
end;

procedure TFrmMain.lbHistoryClick(Sender: TObject);
begin
  //History
  with TFrmHistory.Create(Self) do
      Start;

  VerifyErrorLog;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @NICON);
  FreeAndNil(fIniConfig);
  FreeAndNil(fServerSchedule);
  FreeAndNil(fPOSSchedule);
  FreeAndNil(fNetworkCon);
  FreeAndNil(fServerConnection);
  FreeAndNil(ExecuteTaskThread);
  FreeAndNil(fLocalSetting);
  FreeAndNil(fPOSConfig);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  lbNextSchedule.Caption := DisplayNextSchedule(SCH_POS);
  DisplayNextSchedule(SCH_SERVER);
  lbLastSchedule.Caption := DisplayLastSchedule(SCH_POS);
  ClearTitle;
  VerifyErrorLog;
end;

procedure TFrmMain.lbJobsClick(Sender: TObject);
begin

   if IsJobRunning then
      Exit;

   with TFrmServerConnection.Create(Self) do
     Start;

end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ShowWindow(handle,0);
   ShowWindow(Application.Handle, SW_HIDE);
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

procedure TFrmMain.TimerLogTimer(Sender: TObject);
begin

  TimerLog.Enabled  := False;
  fForceSynchronization := False;
  VerifyErrorLog;

  if not fPOSSchedule.DisableSchedule then
  begin
     ShowDebug('Enter PDV Schedule Enable !!!');
     fSynchronizationType := SINC_TYPE_CASH_LOG;
     ExecuteSchedule;
  end
  else
     ShowDebug('Enter PDV Schedule Disable');

  TimerLog.Enabled  := True;

end;

procedure TFrmMain.lbConnectionClick(Sender: TObject);
begin
   if IsJobRunning then
      Exit;

   with TFrmConnection.Create(Self) do
      Start;
end;

procedure TFrmMain.lbForceServerFilesClick(Sender: TObject);
begin
 //Force replication
 fSynchronizationType  := SINC_TYPE_SERVER;
 fForceSynchronization := True;
 VerifyErrorLog;
 ExecuteSchedule;
end;

procedure TFrmMain.ClearTitle;
begin
  lbTitle.Caption := 'Local information';
  NoteInfo.PageIndex := 0;
end;

procedure TFrmMain.lbJobsMouseEnter(Sender: TObject);
begin
  if not IsJobRunning then
  begin
    lbTitle.Caption := '';
    lbTitle.Caption := TLabel(Sender).Caption;
    NoteInfo.PageIndex := TLabel(Sender).Tag;
  end;
end;

procedure TFrmMain.lbJobsMouseLeave(Sender: TObject);
begin
  if not IsJobRunning then
    ClearTitle;
end;

procedure TFrmMain.LoadParamServerConnection;
begin
  fServerConnection.ConnectType       := fIniConfig.ReadInteger('ServerConnection', 'ConnectType', CON_TYPE_SERVER);
  fServerConnection.ClientInfo        := fIniConfig.ReadString('ServerConnection', 'ClientInfo', '');
  fServerConnection.FTP               := fIniConfig.ReadString('ServerConnection', 'FTP', '0.0.0.0');
  fServerConnection.Port              := fIniConfig.ReadInteger('ServerConnection', 'Port', 21);
  fServerConnection.User              := fIniConfig.ReadString('ServerConnection', 'User', '');
  fServerConnection.PW                := fIniConfig.ReadString('ServerConnection', 'PW', '');
  fServerConnection.GlobalDir         := fIniConfig.ReadString('ServerConnection', 'GlobalDir', '');
  fServerConnection.POSDir            := fIniConfig.ReadString('ServerConnection', 'POSDir', '');

  if fServerConnection.ConnectType = CON_TYPE_FTP then
  begin
    lbForceServerFiles.Caption := sImportServerFile;
    lbPDV.Caption              := sImportServerFile;
  end;
end;

Procedure TFrmMain.ExecuteTask;
var
  bResult : Boolean;
begin
  SchedulePrepareInfo;
  try


  finally
    UnPrepareInfo;
  end;
end;

procedure TFrmMain.SchedulePrepareInfo;
begin
  NoteInfo.PageIndex   := 3;
  lbReplStatus.Visible := True;
  pbRepl.Visible       := True;
  pbRepl.Position      := 0;
end;

procedure TFrmMain.SetStatus(sLabel: String; MaxValue: Integer);
begin
  lbReplStatus.Caption := sLabel;
  pbRepl.Position      := 0;
  pbRepl.Max           := MaxValue;
  pbRepl.Visible       := (MaxValue > 0);
  RefreshStatus;
end;

procedure TFrmMain.RefreshStatus;
begin
  Application.ProcessMessages;
  Sleep(0);
end;

procedure TFrmMain.ResetInfo;
begin
  pbRepl.Visible := False;
  RefreshStatus;
end;

procedure TFrmMain.FillCashIDsList(lstCash: TStringList);
var
  lstSession: TStringList;
  I: Integer;
  iID: Integer;
begin
  lstCash.Clear;
  lstSession := TStringList.Create;
  try
    fIniConfig.ReadSection('PDVTerminals', lstSession);

    for I := 0 to lstSession.Count - 1 do
    begin
      iID :=  fIniConfig.ReadInteger('PDVTerminals', lstSession[I], -1);
      lstCash.AddObject(lstSession[I], Pointer(LongInt(iID)));
    end;
  finally
    lstSession.Free;
  end;
end;


function TFrmMain.SelectImportDate: Boolean;
var
  DateEntered: TDateTime;
  lstCash: TStringList;
  I: Integer;
begin
  Result := False;
  with TfrmSelectDate.Create(Self) do
  try
    if Start(DateEntered) then
    begin
      Result := True;
      lstCash := TStringList.Create;
      try
         FillCashIDsList(lstCash);
         for I := 0 to lstCash.Count - 1 do
           fIniConfig.WriteString(IntToStr(LongInt(lstCash.Objects[I])), POS_PDV_KEY_LAST_DATE, FormatDateTime('YYYYMMDDHHNNSS', DateEntered));
      finally
        lstCash.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TFrmMain.lbImportPDVFilesClick(Sender: TObject);
begin
  //Force replication
  if not SelectImportDate then
   exit;

  fSynchronizationType  := SINC_TYPE_CASH_LOG;
  fForceSynchronization := True;
  VerifyErrorLog;
  ExecuteSchedule;

end;

procedure TFrmMain.lbTerminalConfigClick(Sender: TObject);
begin

 if IsJobRunning then
   Exit;

 with TFrmPDVTerminal.Create(Self) do
   Start;
   
end;

procedure TFrmMain.mExecuteClick(Sender: TObject);
begin
  lbForceServerFilesClick(Self);
end;

procedure TFrmMain.ImportPDVfilesClick(Sender: TObject);
begin
  lbImportPDVFilesClick(Self);
end;

procedure TFrmMain.TimerGlobalTimer(Sender: TObject);
begin

  TimerGlobal.Enabled   := False;
  fForceSynchronization := False;
  VerifyErrorLog;

  if not fServerSchedule.DisableSchedule then
     begin
     fSynchronizationType := SINC_TYPE_SERVER;
     ExecuteSchedule;
     end;

  TimerGlobal.Enabled  := True;

end;

procedure TFrmMain.lbImportinfoClick(Sender: TObject);
begin

  if IsJobRunning then
    Exit;

  with TFrmImportInfo.Create(Self) do
    Start;
end;

procedure TFrmMain.LoadLocalSetting;
begin
  fLocalSetting.IDDefaulStore := fIniConfig.ReadString('Local','IDDefaultStore', '');
  fLocalSetting.IDStoreList   := fIniConfig.ReadString('Local','IDStoreList', '');
  fLocalSetting.DeleteLog     := fIniConfig.ReadDate('Local', 'DeleteLog', Now+10);
end;

procedure TFrmMain.ShowDebug(sMsg: String);
begin
  if fDebug then
    ShowMessage(sMsg);
end;

procedure TFrmMain.lbSalesSummaryClick(Sender: TObject);
begin

  if IsJobRunning then
    Exit;

  with TfrmSalesExplorer.Create(Self) do
  try
    Start;
  finally
    Free;
  end;

end;

function TFrmMain.GetIncludeSince(AIDCashReg: Integer; ALastDate: String): String;
var
  Y, M, D, H, N, S: Word;
begin
  Result := ALastDate;

  if (ALastDate <> '') then
  begin
    Y := StrToInt(copy(Result, 1, 4));
    M := StrToInt(copy(Result, 5, 2));
    D := StrToInt(copy(Result, 7, 2));
    H := StrToInt(copy(Result, 9, 2));
    N := StrToInt(copy(Result, 11, 2));
    S := StrToInt(copy(Result, 13, 2));

    Result := FormatDateTime('YYYYMMDDHHNNSS', IncDay(EncodeDateTime(Y, M, D, H, N, S, 0), MySch.fDaysToImportSales*-1));
  end;
end;


procedure TFrmMain.FillCashregInfo(Lista: TStringList; AForceSynchronization: Boolean);
var
  sPDVList   : TStringList;
  i          : integer;
  ACashRegInfo: TCashRegInfo;
begin
    sPDVList := TStringList.Create;
    try
        //Ler totos os diretorios de POS
        fIniConfig.ReadSection(POS_PDV_KEY, sPDVList);
        for i:=0 to sPDVList.Count-1 do
        begin
          ACashRegInfo := TCashRegInfo.Create;

          ACashRegInfo.IDCashreg := LongInt(fIniConfig.ReadInteger(POS_PDV_KEY, sPDVList[i], 0));
          ACashRegInfo.CashRegName := sPDVList[I];
          ACashRegInfo.LastImportedFileDate := fIniConfig.ReadString(IntToStr(ACashRegInfo.IDCashreg), POS_PDV_KEY_LAST_DATE, '');
          ACashRegInfo.LastImportedFileName := fIniConfig.ReadString(IntToStr(ACashRegInfo.IDCashreg), POS_PDV_KEY_LAST_FILE, '');
          ACashRegInfo.LastImportDate := fIniConfig.ReadDateTime(IntToStr(ACashRegInfo.IDCashreg), POS_LAST_IMPORT_DATE, 0);

          if AForceSynchronization then
            ACashRegInfo.IncludeSince := ACashRegInfo.LastImportedFileDate
          else
            ACashRegInfo.IncludeSince := GetIncludeSince(ACashRegInfo.IDCashreg, ACashRegInfo.LastImportedFileDate);

          Lista.AddObject(IntToStr(ACashRegInfo.IDCashreg), ACashRegInfo);
        end;
    finally
      FreeAndNil(sPDVList);
    end;
end;

procedure TFrmMain.AddHistory(h: String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := ExtractFilepath(Application.ExeName) + HISTORY_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + h;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TFrmMain.OnNeedWriteIniBool(ASection, AKey: String;
  AValue: Boolean);
begin
  fIniConfig.WriteBool(ASection, AKey, AValue);
end;

procedure TFrmMain.OnNeedWriteIniDateTime(ASection, AKey: String;
  AValue: TDateTime);
begin
  fIniConfig.WriteDateTime(ASection, AKey, AValue);
end;

procedure TFrmMain.OnNeedWriteIniInteger(ASection, AKey: String;
  AValue: Integer);
begin
  fIniConfig.WriteInteger(ASection, AKey, AValue);
end;

procedure TFrmMain.OnNeedWriteIniString(ASection, AKey, AValue: String);
begin
  fIniConfig.WriteString(ASection, AKey, AValue);
end;

procedure TFrmMain.OnPOSServerStatusEvent(Msg: String; Count: Integer);
begin
  SetStatus(Msg, Count);
end;

procedure TFrmMain.OnPOSServerStepCompleted;
begin
  pbRepl.StepIt;
  RefreshStatus;
end;

procedure TFrmMain.OnPOSServerCompleted;
begin

  UnPrepareInfo;
  FTPTimer.Enabled := False;
  StopVPN;

end;

procedure TFrmMain.FTPTimerTimer(Sender: TObject);
begin

  FTPTimer.Enabled := False;
  AddHistory('FTP (POS) : TIME OUT! SAIR!');
  UnblockThread;

end;

procedure TFrmMain.UnblockThread;
var
  hThread : THandle;
begin

  if ExecuteTaskThread <> nil then
  begin
    ExecuteTaskThread.FreeOnTerminate := True;
    ExecuteTaskThread.Terminate;

    hThread := ExecuteTaskThread.Handle;
    TerminateThread(hThread, 1);
    CloseHandle(hThread);

    ExecuteTaskThread.FreeDMThread;
    ExecuteTaskThread := nil;
    UnPrepareInfo;
  end;

end;

function TFrmMain.DeleteHistory: Boolean;
begin
  DeleteFile(ExtractFilepath(Application.ExeName) + HISTORY_FILE);
  DeleteFile(ExtractFilepath(Application.ExeName) + IMPORT_FILE);

  Result := True;
end;

function TFrmMain.StopVPN: Boolean;
begin

  if (fNetworkCon.NetworkCon1 <> '') and (fNetworkCon.StopVPN1) and
     (VPN1.ConnectState = csRasConnected) then
     begin
       VPN1.Hangup;
       Result := True;
     end;

  if (fNetworkCon.NetworkCon2 <> '') and (fNetworkCon.StopVPN2) and
     (VPN2.ConnectState = csRasConnected) then
     begin
       VPN2.Hangup;
       Result := True;
     end;

end;

procedure TFrmMain.lbPDVHistoryClick(Sender: TObject);
begin

   if IsJobRunning then
      Exit;

  with TFrmPDVLog.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
  
end;

procedure TFrmMain.VerifyErrorLog;
begin

  if FileExists(DMPOS.LocalPath + ERROR_FILE) then
    pnlSendLog.Visible := (GetFileSize(DMPOS.LocalPath + ERROR_FILE) > 0)
  else
    pnlSendLog.Visible := False;

end;

procedure TFrmMain.lbSendEmailClick(Sender: TObject);
begin
 with Email do
  begin
    Recipients.Text := 'suporte@mainretai.com';
    FromName        := fIniConfig.ReadString('Local','Customer', '');
    Subject         := 'POSServer Log';
    Body            := 'Verificar log ' + fIniConfig.ReadString('Local','Customer', '');
    AttachedFiles.Add(DMPOS.LocalPath + ERROR_FILE);
    //Mostra o Email
    ShowDialog := True;
    SendMail;
  end;
end;

initialization

end.
