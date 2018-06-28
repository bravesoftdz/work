unit uMainConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ADODB,
  Dialogs, ExtCtrls, Buttons, StdCtrls, IniFiles, shellapi, Menus, uDMRepl, tExecuteTask;

const
  MR_HST_GLOBAL_FILE_NOT_FOUND  = 'Global file not found. ';
  MR_HST_LOCAL_FILE_NOT_FOUND  = 'Local file not found. ';

  SERVER_TYPE_SERVER    = 0;
  SERVER_TYPE_PROCESSOR = 1;
  SERVER_TYPE_FILES     = 2;

  FMT_CLIENT_INFO = '#NOMECLIENTE#=%S;#NOMELOJA#=%S;#SENHA#=%S;#VERSAO#=%S;#PACKETSIZE#=%S;';

type
  TParamsConfig = class
     private
      fWaitJob      : Integer;
      fWaitJobStart : Integer;
      fCallJob      : Integer;
      fServerHost   : String;
      fServerPort   : String;
      fSPServerErro : String;
      fStoreList    : String;
      fGlobalTables : String;
      fStoreTables  : String;
      fExcepTables  : String;
      fNextSchedule : TDateTime;
      fSQLBatchCount: Integer;
      FBindPort: Integer;
      fDisableUpdateQty: Boolean;
      procedure SetTime(iTime:Integer);
     public
      property WaitJob:       Integer   read fWaitJob       write fWaitJob;
      property WaitJobStart:  Integer   read fWaitJobStart  write fWaitJobStart;
      property CallJob:       Integer   read fCallJob       write SetTime;
      property ServerHost:    String    read fServerHost    write fServerHost;
      property ServerPort:    String    read fServerPort    write fServerPort;
      property SPServerErro:  String    read fSPServerErro  write fSPServerErro;
      property StoreList:     String    read fStoreList     write fStoreList;
      property GlobalTables:  String    read fGlobalTables  write fGlobalTables;
      property StoreTables:   String    read fStoreTables   write fStoreTables;
      property ExcepTables:   String    read fExcepTables   write fExcepTables;
      property NextSchedule:  TDateTime read fNextSchedule  write fNextSchedule;
      property SQLBatchCount: Integer   read fSQLBatchCount write fSQLBatchCount;
      property BindPort:      Integer   read FBindPort      write FBindPort;
      property DisableUpdateQty  : Boolean   read fDisableUpdateQty  write fDisableUpdateQty;
  end;

  TFrmMain = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    lbSchedules: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    lbHistory: TLabel;
    Label3: TLabel;
    lbNextSchedule: TLabel;
    Image3: TImage;
    lbJobs: TLabel;
    Label5: TLabel;
    lbStatus: TLabel;
    pop: TPopupMenu;
    mExecute: TMenuItem;
    mExit: TMenuItem;
    N1: TMenuItem;
    Image4: TImage;
    Label2: TLabel;
    Label4: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    TimerJob: TTimer;
    Bevel5: TBevel;
    Image6: TImage;
    lbStore: TLabel;
    Label8: TLabel;
    Bevel6: TBevel;
    lbServerInfo: TLabel;
    lblServerVersion: TLabel;
    pnlThreadInfo: TPanel;
    lsbThread: TListBox;
    Label6: TLabel;
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
    procedure mExecuteClick(Sender: TObject);
    procedure TimerJobTimer(Sender: TObject);
    procedure lbStoreClick(Sender: TObject);
  private
    { Private declarations }
    fActualClientInfo: String;
    NIcon : TNotifyIconData; //Icon Tray
    fExit : Boolean;
    fForceReplication : Boolean;
    fThreadClientControl : TStringList;
    (*
    ClientThread : TClientThread;
    *)
    procedure SyncLogEvent(Sender: TObject; const Client: string);
    function ExecuteSchedule:Boolean;
    function IsJobRunning:Boolean;

    procedure StartThreadReplication(sClient : String);
    procedure SetThreadParameters(AThreadExecuteTask : TThreadExecuteTask);
    procedure UnStartThreadReplication(sClient : String);

    procedure RefreshThreadList;
    procedure DoOnTerminateThread(Sender: TObject);

    //function RunSocket(AHost: String; APort: Integer): Boolean;
  public
    { Public declarations }
    fJobParam    : TParamsConfig;
    fIniServerConfig : TIniFile;
    fIniCustomersConfig : TIniFile;

    property ForceReplication : Boolean read fForceReplication;
    function DisplayNextSchedule:String;
    procedure SaveNextSchedule;
    procedure LoadParamAll;
    procedure LoadParamJobs;
    procedure LoadParamTask;
    procedure LoadParamGlobalTables;
    procedure LoadParamStoreTables;
    procedure LoadParamExceptionTable;
    procedure UnPrepareInfo;
    //XML
    function ExportXML(Client : String; ReplicateSince: Integer;  DatabaseVersion: String): Boolean;
    function ImportXML(Client, Store, DatabaseVersion : String; IDServerStore: Integer): Boolean;
    procedure ExecReplication;
    function ExecSingleReplication(Client:String): Boolean;
  end;

var
  FrmMain: TFrmMain;

implementation

uses uFrmSchedule, uDMServer, uDateTimeFunctions, DateUtils,
     uFrmJobs, uFrmHistory, uEncryptFunctions, uMsgBox,
     uParamFunctions, uFrmStoreType, Registry, uReplicationClasses(*,
     uRepSocketFunctions*);

{$R *.dfm}

//var
//  ExecuteTaskThread: TThreadExecuteTask = nil;


procedure TParamsConfig.SetTime(iTime:Integer);
begin
   fCallJob                   := iTime;
   FrmMain.TimerJob.Enabled   := False;
   FrmMain.TimerJob.Interval  := CallJob;
   FrmMain.TimerJob.Enabled   := True;
end;

procedure TFrmMain.SetThreadParameters(AThreadExecuteTask : TThreadExecuteTask);
begin

  with AThreadExecuteTask do
  begin
    LocalPath        := DMServer.LocalPath;
    ConnectionString := DMServer.FomartConnection(DecodeServerInfo(fIniCustomersConfig.ReadString(Client, CONNECTION_STR, ''), 'Server', CIPHER_TEXT_STEALING, FMT_UU));
    RepSince         := fIniCustomersConfig.ReadInteger(Client, REPSINCE_STR, 1);
    MainStore        := fIniCustomersConfig.ReadInteger(Client, MAINSTORE_STR, 1);
    fIniCustomersConfig.ReadSection(Client, StoreList);
    GlobalTables     := fJobParam.GlobalTables;
    StoreTables      := fJobParam.StoreTables;
    ExcepTables      := fJobParam.ExcepTables;
    SQLBatchCount    := fJobParam.SQLBatchCount;
    DisableUpdateQty := fJobParam.DisableUpdateQty;
  end;

end;

procedure TFrmMain.StartThreadReplication(sClient : String);
var
  ExecuteTaskThread: TThreadExecuteTask;
begin
  //Verificar se esta rodando no StringList
  if (fThreadClientControl.IndexOf(sClient) = -1) or
     ((fThreadClientControl.IndexOf(sClient) <> -1) and (fThreadClientControl.Objects[fThreadClientControl.IndexOf(sClient)] = nil)) then
  begin

    ExecuteTaskThread := TThreadExecuteTask.Create(True);

    if fThreadClientControl.IndexOf(sClient) = -1 then
      fThreadClientControl.AddObject(sClient, ExecuteTaskThread)
    else
      fThreadClientControl.Objects[fThreadClientControl.IndexOf(sClient)] := ExecuteTaskThread;

    ExecuteTaskThread.Client := sClient;
    SetThreadParameters(ExecuteTaskThread);


    try
      ExecuteTaskThread.OnSyncDate := SyncLogEvent;
      ExecuteTaskThread.OnTerminate := DoOnTerminateThread;
      ExecuteTaskThread.FreeOnTerminate := True;
      ExecuteTaskThread.Priority := tpLowest;
      if ExecuteTaskThread.Suspended then
        ExecuteTaskThread.Resume;
    finally
    end;
    RefreshThreadList;


{
    ExecuteTaskThread := TThreadExecuteTask.Create(True);
    ExecuteTaskThread.DMThread.Client := sClient;
    SetThreadParameters(ExecuteTaskThread.DMThread);

    if fThreadClientControl.IndexOf(sClient) = -1 then
      fThreadClientControl.AddObject(sClient, ExecuteTaskThread)
    else
      fThreadClientControl.Objects[fThreadClientControl.IndexOf(sClient)] := ExecuteTaskThread;

    try
      ExecuteTaskThread.OnSyncDate := SyncLogEvent;
      if ExecuteTaskThread.Suspended then
        ExecuteTaskThread.Resume;
    finally
    end;
    RefreshThreadList;
    }
  end;

end;

procedure TFrmMain.UnStartThreadReplication(sClient : String);
begin
  if ((fThreadClientControl.IndexOf(sClient) <> -1) and (fThreadClientControl.Objects[fThreadClientControl.IndexOf(sClient)] <> nil)) then
  begin
    fThreadClientControl.Objects[fThreadClientControl.IndexOf(sClient)] := nil;
  end;
end;

procedure TFrmMain.SyncLogEvent(Sender: TObject; const Client: string);
begin
  { Sincroniza a execução da Thread com o Memo de Log }
  UnStartThreadReplication(Client);
  RefreshThreadList;
end;

procedure TFrmMain.RefreshThreadList;
var
  i : integer;
  bVisible : Boolean;
begin
  lsbThread.Clear;

  bVisible := False;
  for i := 0 to fThreadClientControl.Count-1 do
    if fThreadClientControl.Objects[i] <> nil then
    begin
      lsbThread.AddItem(fThreadClientControl.Strings[i], nil);
      bVisible := True;
    end;

  pnlThreadInfo.Visible := bVisible;

end;

function TFrmMain.IsJobRunning:Boolean;
begin

   Result := False;
   //Result := (ExecuteTaskThread <> nil);
   //if Result then
   //   Result := ExecuteTaskThread.Running;

end;

procedure TFrmMain.SaveNextSchedule;
var
  MyTime : TDateTime;
begin

  if fForceReplication then
     Exit;

  MyTime := fJobParam.NextSchedule;

  Case fIniServerConfig.ReadInteger('Tasks','Every',0) of
    0: MyTime := (AddHours(MyTime, fIniServerConfig.ReadInteger('Tasks','Interval',1)));
    1: MyTime := (AddMinutes(MyTime, fIniServerConfig.ReadInteger('Tasks','Interval',1)));
  end;

  Case fIniServerConfig.ReadInteger('Tasks','Occurs',0) of
    0: MyTime := IncDay(MyTime, 0);
    1: MyTime := IncDay(MyTime, 7);
    2: MyTime := IncMonth(MyTime, 1);
  end;

  if MyTime < Now then
     MyTime := Now;

  fIniServerConfig.WriteDateTime('Tasks','NextSchedule', MyTime);
  fJobParam.NextSchedule := MyTime;

end;

procedure TFrmMain.UnPrepareInfo;
begin
   lbNextSchedule.Caption    := DisplayNextSchedule;
   lbNextSchedule.Font.Color := clWindowText;
   lbStatus.Caption          := 'Idle';
   Application.ProcessMessages;
end;

function TFrmMain.ExecuteSchedule:Boolean;
   procedure PrepareInfo;
   begin
   lbStatus.Caption          := 'Running schedule (please wait)...';
   Application.ProcessMessages;
   end;
begin
  Result := True;
  try

    //Verifico a hora do job schedule
    if not fForceReplication then
       if not (fJobParam.NextSchedule < Now) then
          Exit;

    PrepareInfo;

    LoadParamGlobalTables;
    LoadParamStoreTables;
    LoadParamExceptionTable;

    Application.ProcessMessages;

    ExecReplication;

  except
    on E: Exception do
    begin
      Result := False;
      DMServer.ReportError(E.Message);
    end;
  end;
end;


function TFrmMain.DisplayNextSchedule:String;
begin
   if fIniServerConfig.ReadString('Tasks','NextSchedule', '') = '' then
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
           lbNextSchedule.Caption := DisplayNextSchedule;
end;

procedure TFrmMain.LoadParamTask;
begin
  fJobParam.WaitJob       := fIniServerConfig.ReadInteger('Timer','WaitJobStart', 10)*1000;
  fJobParam.WaitJobStart  := fIniServerConfig.ReadInteger('Timer','WaitJob', 30)*1000;
  fJobParam.CallJob       := fIniServerConfig.ReadInteger('Timer','CallJob', 10)*60000;
  fJobParam.NextSchedule  := fIniServerConfig.ReadDateTime('Tasks','NextSchedule',Now);
  fJobParam.SQLBatchCount := fIniServerConfig.ReadInteger('Tasks','SQLBatchCount',uReplicationClasses.DEFAULT_SQL_BATCH_COUNT);
  fJobParam.DisableUpdateQty := fIniServerConfig.ReadBool('Setup', 'DisableUpdateQty', False);
end;

procedure TFrmMain.LoadParamJobs;
begin
  fJobParam.ServerHost    := fIniServerConfig.ReadString('ServerInfo','ProxServer', '');
  fJobParam.ServerPort    := fIniServerConfig.ReadString('ServerInfo','ProxPort', '');
  fJobParam.BindPort      := fIniServerConfig.ReadInteger('ServerInfo','BindPort', DEFAULT_BIND_PORT);
end;

procedure TFrmMain.LoadParamGlobalTables;
begin
  fJobParam.GlobalTables  := fIniServerConfig.ReadString('GlobalTables','Tables', '');
end;

procedure TFrmMain.LoadParamStoreTables;
begin
  fJobParam.StoreTables  := fIniServerConfig.ReadString('StoreTables','Tables', '');
end;

procedure TFrmMain.LoadParamExceptionTable;
begin
  fJobParam.fExcepTables := fIniServerConfig.ReadString('ExceptionTables','Tables', '');
end;

procedure TFrmMain.LoadParamAll;
begin

  LoadParamJobs;
  LoadParamTask;
  LoadParamGlobalTables;
  LoadParamStoreTables;
  LoadParamExceptionTable;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  Reg : TRegistry;
begin
  (*
  ClientThread        := nil;
  *)
  fActualClientInfo   := '';

  fIniServerConfig    := TIniFile.Create(DMServer.LocalPath+SERVER_CONFIG_FILE);
  fIniCustomersConfig := TIniFile.Create(DMServer.LocalPath+CUSTOMERS_CONFIG_FILE);
  fExit               := True;
  fJobParam           := TParamsConfig.Create;
  LoadParamAll;

  fThreadClientControl := TStringList.Create;

  (*

  // Ativa o servidor de socket


  DMServer.TCPServer.DefaultPort := fJobParam.BindPort;
  DMServer.TCPServer.Active := True;
   *)

  //Colocar o sistema no starup do Windows
  {
  Reg := TRegistry.Create;
  try
    with Reg Do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey(REG_PATH, False);
      try
        if not ValueExists('MRRepMonitor') then
           WriteString('MRRepMonitor', Application.ExeName);
      finally
        Reg.CloseKey;
      end;
    end;
  finally
    FreeAndNil(Reg);
  end;
  }

  //Adding the icon to the system tray
  {
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
  }
end;

procedure TFrmMain.lbHistoryClick(Sender: TObject);
begin
  //History
  with TFrmHistory.Create(Self) do
      Start;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  //Shell_NotifyIcon(NIM_DELETE, @NICON);
  FreeAndNil(fIniServerConfig);
  FreeAndNil(fIniCustomersConfig);
  FreeAndNil(fJobParam);
  //FreeAndNil(ExecuteTaskThread);
  FreeAndNil(fThreadClientControl);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  lbNextSchedule.Caption := DisplayNextSchedule;
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

procedure TFrmMain.mExecuteClick(Sender: TObject);
begin
 //Force replication
 fForceReplication := True;
 ExecuteSchedule;
end;

procedure TFrmMain.TimerJobTimer(Sender: TObject);
begin
 TimerJob.Enabled  := False;
 fForceReplication := False;
 ExecuteSchedule;
 TimerJob.Enabled  := True;
end;

procedure TFrmMain.lbStoreClick(Sender: TObject);
begin
   //Store
   with TFrmStoreType.Create(Self) do
       Start;
end;

function TFrmMain.ExportXML(Client : String; ReplicateSince: Integer; DatabaseVersion: String): Boolean;
var
  stlGlobalTables,
  stlExceptTables : TStringlist;
  I : Integer;
  sGlobalDir : String;
  bSuccess: Boolean;
  sXMLVersion: String;
begin
  Result := True;
  sGlobalDir := DMServer.LocalPath + Client + '\' + SUBDIR_GLOBAL;

  sXMLVersion := DMServer.GenerateXMLVersionControl(DatabaseVersion, NOW);


  DMServer.CreateGenericVersionedFile(sGlobalDir + DMServer.GetGlobalVersionFileName(Client), DatabaseVersion);

  try

    If Not DirectoryExists(sGlobalDir) Then
      ForceDirectories(sGlobalDir);

    stlGlobalTables := TStringlist.Create;
    try
      stlGlobalTables.CommaText := fJobParam.GlobalTables;

      stlExceptTables := TStringlist.Create;
      try
         stlExceptTables.CommaText := fJobParam.fExcepTables;
         stlGlobalTables.AddStrings(stlExceptTables);
      finally
         FreeAndNil(stlExceptTables);
      end;

      bSuccess := True;

      for I := 0 To stlGlobalTables.Count -1 do
      begin
        bSuccess := bSuccess and DMServer.ExportXMLFile(sGlobalDir, stlGlobalTables[I], ReplicateSince, '');
        if not bSuccess then
          Break;
      end;

      if bSuccess then
        DMServer.ZipFile(sGlobalDir + ALL_XML, sGlobalDir + GLOBAL_ZIP_FILE)
      else
        DMServer.DeleteReplFile(sGlobalDir + DMServer.GetGlobalVersionFileName(Client));

      for I := 0 To stlGlobalTables.Count -1 do
        DMServer.DeleteReplFile(sGlobalDir + stlGlobalTables[I]+EXT_XML);

      Result := Result and bSuccess;

    finally
      FreeAndNil(stlGlobalTables);
    end;
  except
    on E: Exception do
    begin
      DMServer.ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.ExportXML');
      Result := False;
    end;
  end;
end;




function TFrmMain.ImportXML(Client, Store, DatabaseVersion : String; IDServerStore: Integer): Boolean;
var
  stlStoreTables,
  stlExceptTables : TStringlist;
  I : Integer;
  sClientDir : String;
begin
  Result := True;
  try
    sClientDir := DMServer.LocalPath + Client + '\' + Store + '\';

        //sClientDir := LocalPath + Client + '\' + Store + '\';
    // sClientDir + Format('ver-%S@%S.xml', [Store, Client])
    // Client, Store


    if not DMServer.CheckXMLVersion(sClientDir + DMServer.GetLocalVersionFileName(Client, Store), DatabaseVersion) then
    begin
      Result := False;
      Exit;
    end;

    stlStoreTables  := TStringlist.Create;

    try
      stlStoreTables.CommaText := fJobParam.StoreTables;
      for I := 0 To stlStoreTables.Count -1 do
          DMServer.ImportXMLFile(stlStoreTables[I], sClientDir+stlStoreTables[I] + EXT_XML, '', fJobParam.SQLBatchCount);
    finally
      FreeAndNil(stlStoreTables);
    end;

    stlExceptTables := TStringlist.Create;
    try
      stlExceptTables.CommaText := fJobParam.fExcepTables;
      for I := 0 To stlExceptTables.Count -1 do
        DMServer.ImportXMLFile(stlExceptTables[I], sClientDir+stlExceptTables[I]+EXT_XML,Format('StoreID <> %D', [IDServerStore]), fJobParam.SQLBatchCount);
    finally
      FreeAndNil(stlExceptTables);
    end;
  except
    on E: Exception do
    begin
      DMServer.ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.ImportXML');
      Result := False;
    end;
  end;
end;

procedure TFrmMain.ExecReplication;
var
  sCustomerList : TStringList;
  i : Integer;
begin
   try
     sCustomerList := TStringList.Create;
     try
        fIniCustomersConfig.ReadSections(sCustomerList);

        for i:=0 to sCustomerList.Count-1 do
        begin
           if not DMServer.IsSessionToExclude(sCustomerList.Strings[i]) then
             if fIniCustomersConfig.ReadInteger(sCustomerList.Strings[i], SERVER_TYPE_STR, 0) <> SERVER_TYPE_FILES then
               if not fIniCustomersConfig.ReadBool(sCustomerList.Strings[i], DISABLESCHEDULE_STR, False) then
                 //ExecSingleReplication(sCustomerList.Strings[i]);
                 StartThreadReplication(sCustomerList.Strings[i]);
        end;
     finally
       FreeAndNil(sCustomerList);
     end;
   except
     on E: Exception do
       DMServer.ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.ExecReplication');
   end;
end;



function CanExecSingleReplication(Client: String): Cardinal;
var
  TempMutex : Cardinal;
begin
  TempMutex := CreateMutex(nil, True, PChar(Client + '_replication'));

  if not (GetLastError = ERROR_ALREADY_EXISTS) then
    Result := TempMutex
  else
    Result := 0;
end;

function TFrmMain.ExecSingleReplication(Client: String): Boolean;
var
  Conn : TADOConnection;
  sStoreList : TStringList;
  sConnectString : String;
  i, J : Integer;
  //ClientMutex : Cardinal;

  sVer : String;
  iRepSince,
  iMainStore: Integer;
  sZipPath: String;
  sHost: String;
  (*
  iPort: Integer;
  *)
  sAuthStore,
  sAuthPasswd,
  sAuthPacketSize,
  sAuthVersion,
  sUncripted: String;
  stlDeletar: TStringList;
begin
   Result := True;
   try
     (*
     ClientMutex := CanExecSingleReplication(Client);
     try
       if ClientMutex = 0 then
         raise Exception.CreateFmt('Cannot execute %S job while a %S client is connected !!!', [Client, Client]);
     *)
       //%%Sera passado para a thread
       sConnectString := fIniCustomersConfig.ReadString(Client, CONNECTION_STR, '');

       //Verificar o Schedule

       if sConnectString <> '' then
          begin
            //%%Sera passado para a thread
            sStoreList               := TStringList.Create;
            Conn                     := TADOConnection.Create(Self);
            try
              Conn.KeepConnection    := True;
              Conn.LoginPrompt       := False;
              Conn.ConnectionTimeout := 10;

              //%%Sera passado para a thread
              Conn.ConnectionString  := DMServer.FomartConnection(DecodeServerInfo(sConnectString, 'Server', CIPHER_TEXT_STEALING, FMT_UU));
              {
              try}
                Conn.Open;
              {except
                Exit;
              end;}

              sVer := DMServer.GetDatabaseVersion(Conn);

              fIniCustomersConfig.WriteString(Client, VERSION_STR, sVer);
              iRepSince  := fIniCustomersConfig.ReadInteger(Client, REPSINCE_STR, 1);
              iMainStore := fIniCustomersConfig.ReadInteger(Client, MAINSTORE_STR, 1);

              // Coloca o connection para o XMLToTable e  TableToXML
              DMServer.SetConnections(Conn);

              CreateDeletionTable(stMSSQL2000, Conn);


              // Verifica bloqueio no Diretório Global
              if DMServer.IsGlobalLocked(Client) then
                DMServer.ReportError(Format(MR_HST_JOB_FAIL + 'Global file locked for %S in TFrmMain.ExecReplication', [Client]))
              else
                begin
                  if DMServer.CreateGlobalLock(Client) then
                    try
                      // *** Exporta o Global ***
                      ExportXML(Client, iRepSince, sVer);
                    finally
                      DMServer.RemoveGlobalLock(Client);
                      Sleep(0);
                    end
                  else
                    DMServer.ReportError(Format(MR_HST_JOB_FAIL + 'Could not create global file lock for %S in TFrmMain.ExecReplication', [Client]));
                end;

              if fIniCustomersConfig.ReadInteger(Client, SERVER_TYPE_STR, 0) = SERVER_TYPE_PROCESSOR then
              begin
                // *** Envia o Global e recebe os Locais ***
                sUncripted     := fIniCustomersConfig.ReadString(Client, AUTH_CRIPTO_STR, '');
                sAuthVersion   := fIniCustomersConfig.ReadString(Client, VERSION_STR, '');

                sUncripted     := DecodeServerInfo(sUncripted, 'NetCon', CIPHER_TEXT_STEALING, FMT_XX);

                sHost := ParseParam(sUncripted, FILE_SERVER_HOST_STR);
                (*
                iPort := StrToIntDef(ParseParam(sUncripted, FILE_SERVER_PORT_STR), 1666);
                *)

                sAuthStore      := ParseParam(sUncripted, AUTH_STORE_NAME_STR);
                sAuthPasswd     := ParseParam(sUncripted, AUTH_PASSWORD_STR);
                sAuthPacketSize := ParseParam(sUncripted, AUTH_PACKET_SIZE_STR);

                (*

                fActualClientInfo := EncodeServerInfo(Format(FMT_CLIENT_INFO,
                                                             [Client, sAuthStore,
                                                              sAuthPasswd,
                                                              sAuthVersion,
                                                              sAuthPacketSize]),
                                                      'NetCon', CIPHER_TEXT_STEALING,
                                                      FMT_XX);

                DMServer.AddHistory(Format('Conectando em %S:%D para receber e enviar dados de %S', [sHost, iPort, Client]));

                RunSocket(sHost, iPort);

                *)

                (*  --- Aqui entra Rotina de FTP --- *)

              end;

              // *** Importa as Lojas ***
              //CreateDeletionTable(stMSSQL2000, Conn);
              ModifyAllConstraints(stMSSQL2000, Conn, False);
              try
                fIniCustomersConfig.ReadSection(Client, sStoreList);
                for i:=0 to sStoreList.Count-1 do
                  if not DMServer.IsSessionToExclude(sStoreList.Strings[i]) then
                  begin
                     sZipPath := DMServer.LocalPath + Client + '\' + sStoreList.Strings[i] + '\';

                     if DMServer.IsLocalLocked(Client, sStoreList.Strings[i]) then
                     begin
                       DMServer.ReportError(Format(MR_HST_JOB_FAIL + 'Local dir locked for %S - %S in TFrmMain.ExecReplication', [Client, sStoreList.Strings[i]]));
                       Continue;
                     end;

                     try
                       if FileExists(sZipPath + STORE_ZIP) then
                         if DMServer.CreateLocalLock(Client) then
                           try
                             // Deletar os XMLs antigos
                             stlDeletar := TStringList.Create;
                             try
                               stlDeletar.CommaText := fJobParam.StoreTables;
                               for J := 0 to stlDeletar.Count - 1 do
                                 DeleteFile(sZipPath + stlDeletar[J] + '.xml');
                             finally
                               stlDeletar.Free;
                             end;

                             DMServer.AddHistory('Importando ' + Client + ' - ' + sStoreList.Strings[i]);
                             DMServer.UnZipFile(sZipPath, sZipPath + STORE_ZIP);
                             if ImportXML(Client, sStoreList.Strings[i], sVer, iMainStore) then
                               begin
                                  DMServer.DeleteReplFile(sZipPath + STORE_ZIP);
                                  DMServer.DeleteReplFile(sZipPath + ALL_XML);
                               end
                             else
                               begin
                                 Result := False;
                                 Exit;
                               end;
                           finally
                             DMServer.RemoveLocalLock(Client);
                           end
                         else
                           DMServer.ReportError(Format(MR_HST_JOB_FAIL + 'Could not create global file lock for %S - %S in TFrmMain.ExecReplication', [Client, sStoreList.Strings[i]]))
                       else
                         DMServer.AddHistory(MR_HST_LOCAL_FILE_NOT_FOUND + ': ' + sZipPath + STORE_ZIP);
                     finally
                     end;
                  end;
                Result := DMServer.UpdateTotQtyOnHand(Conn);
              finally
                ModifyAllConstraints(stMSSQL2000, Conn, True);
              end;

            finally
              Conn.Close;
              FreeAndNil(Conn);
              FreeAndNil(sStoreList);
            end;
          end;
     (*
     finally
       if ClientMutex <> 0 then
       begin
         ReleaseMutex(ClientMutex);
         CloseHandle(ClientMutex);
       end;
     end;
     *)
   except
     on E: Exception do
      begin
        Result := False;
        DMServer.ReportError(MR_HST_JOB_FAIL + E.Message + ' in TFrmMain.ExecReplication');
      end;
   end;
end;


procedure TFrmMain.DoOnTerminateThread(Sender: TObject);
begin
  if Sender is TThreadExecuteTask then
  begin
    UnStartThreadReplication(TThreadExecuteTask(Sender).Client);

    SaveNextSchedule;
    UnPrepareInfo;
  end;
  //SetProcessWorkingSetSize(GetCurrentProcess(), DWORD(-1), DWORD(-1)); 
end;

end.

