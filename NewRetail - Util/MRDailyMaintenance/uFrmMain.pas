unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, StdCtrls, ActiveX, Shellapi, MsTask, MsTaskUtils,
  siComp, Menus, IniFiles;

const
  SCHEDULE_EXIST    = 1;
  SCHEDULE_NO_EXIST = 2;
  SCHEDULE_ERROR    = 3;

  MR_JOB            = 'MRCalcABC.job';

type
  TFrmMain = class(TForm)
    ADOCon: TADOConnection;
    lbWait: TLabel;
    Timer: TTimer;
    TimerStart: TTimer;
    siLang: TsiLang;
    spDailyMaintenance: TADOStoredProc;
    lbPowered: TLabel;
    Label4: TLabel;
    lblVersion: TLabel;
    Shape5: TShape;
    MainMenu1: TMainMenu;
    Options1: TMenuItem;
    memCalcAvg: TMenuItem;
    memCalcABC: TMenuItem;
    memDelHold: TMenuItem;
    btnStop: TButton;
    btnStart: TButton;
    lbTimer: TLabel;
    TimerSeconds: TTimer;
    spReindexTables: TADOStoredProc;
    spRecompileObjects: TADOStoredProc;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerStartTimer(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerSecondsTimer(Sender: TObject);
    procedure memCalcAvgClick(Sender: TObject);
  private
    iTime : Longint;
    sCountText : String;
    FDailyParams : TIniFile;
    procedure LoadRegistry;
    procedure StartTask;
    function ScheduleExist : Integer;
    function ScheduleCreate : Boolean;
    procedure ScheduleEdit;
    procedure DeleteRepDaily;
    procedure OpenConnection;
    procedure LoadValues;
    procedure SaveValues;
    procedure AddHistory(Text: String);
  end;

var
  FrmMain: TFrmMain;
  SchedulingAgent: ITaskScheduler;
  ScheduledWorkItem: IScheduledWorkItem;
  pIPersistFile: IPersistFile;
  Task: ITask;

implementation

uses AuxProcs, uParamFunctions, uMsgBox, ufrmServerInfo, uDMGlobal, uSystemConst,
     Registry, {uNumericFunctions,} RTLConsts, uSaveToFile, uOperationSystem;

{$R *.dfm}

//+--------------------------------------------------------------------------
//
// Function:        Init()
//
// Synopsis:        Called to initialize and instantiate a task
//                  scheduler object.
//
// Arguments:       none
//
// Returns:         HRESULT indicating success or failure.  S_OK on success.
//
// Side effect:     Sets global pointer SchedulingAgent, for use in other
//                  functions.
//
//---------------------------------------------------------------------------

function Init(): HRESULT;
begin
  Result := S_OK;

  if not assigned(SchedulingAgent) then
  begin
    Result := ActiveX.CoInitialize(nil);
    if Result <> S_OK then
    begin
      //ActiveX.CoUninitialize;
      //ShowMessage('Error in ActiveX.CoInitialize.Error Code :' + IntToHex(Result, 8));
      //Application.Terminate;
    end;

    Result := ActiveX.CoCreateInstance(CLSID_CSchedulingAgent,
                                       nil,
                                       CLSCTX_INPROC_SERVER,
                                       IID_ITaskScheduler,
                                       SchedulingAgent);
    if Result <> S_OK then
    begin
      ShowMessage('Error in ActiveX.CoCreateInstance.Error Code :' + IntToHex(Result, 8));
      Application.Terminate;
    end;
  end;
end;

function GetITask(TaskName: string): ITask;
var
  PITask: IUnknown;
  hr: HRESULT;
  riid: TGUID;
begin
  riid := IID_ITask;
  hr := SchedulingAgent.Activate(StrToWide(TaskName), riid, PITask);

  if hr = S_OK then
    Result := ITask(PITask)
  else
  begin
    ShowMessage('Error in SchedulingAgent.Activate.Error Code :' + IntToHex(hr, 8));
    Result := nil;
  end;
end;

function SaveTask: HRESULT;
begin
  Result := -1;
  Task.QueryInterface(IID_IPersistFile, pIPersistFile);

  if pIPersistFile <> nil then
    Result := pIPersistFile.Save(nil, true)
  else
    ShowMessage('Error in  Task.QueryInterface(IID_IPersistFile, pIPersistFile):');
end;

function DeleteTask(JobName: string): HRESULT;
begin
  Result := SchedulingAgent.Delete(StrToWide(JobName));
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  Self.Close;
end;


procedure TFrmMain.AddHistory(Text:String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := ExtractFileDir(Application.ExeName) + 'DailyLog.txt';
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  LoadRegistry;
  FDailyParams := TIniFile.Create(ExtractFileDir(Application.ExeName)+'\MRDailyMaintenance.ini');
  sCountText := lbTimer.Caption;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  LoadValues;
  iTime := Trunc(TimerStart.Interval/1000);
  TimerStart.Enabled := True;
  TimerSeconds.Enabled := True;
end;

procedure TFrmMain.StartTask;
begin

  lbWait.Visible := True;

  OpenConnection;

  try

    Application.ProcessMessages;

    //Daily Maintenance
    try
     with spDailyMaintenance do
     begin
       Parameters.ParamByName('@CalcABC').Value := memCalcABC.Checked;
       Parameters.ParamByName('@CalcAvg').Value := memCalcAvg.Checked;
       Parameters.ParamByName('@DelHold').Value := memDelHold.Checked;
       ExecProc;
     end;
    except
      on E: Exception do
      begin
        AddHistory(' Daily maintenance : ' + E.Message);
      end;
    end;

    //Reindex All Tables
    try
     with spReindexTables do
       ExecProc;
    except
      on E: Exception do
      begin
        AddHistory(' Reindex all tables : ' + E.Message);
      end;
    end;

    //Recompile All Objects
    try
     with spRecompileObjects do
       ExecProc;
    except
      on E: Exception do
      begin
        AddHistory(' Recompile all objects : ' + E.Message);
      end;
    end;

    Application.ProcessMessages;

  finally
    ADOCon.Close;
    Timer.Enabled := True;
  end;

end;

function TFrmMain.ScheduleExist: Integer;
var
  hr: HRESULT;
  pEnum: IEnumWorkItems;
  TaskNames: PLPWSTR;
  dwFetched: DWORD;
  szString: string;
begin
  Result := SCHEDULE_NO_EXIST;

  hr := StartScheduler;
  if not (hr = ERROR_SUCCESS) then
  begin
    ShowMessage('Task Scheduler did not start. Error Code:' + IntTohex(hr, 8));
    Result := SCHEDULE_ERROR;
    Exit;
  end;

  Init;

  try
    hr := SchedulingAgent.Enum(pEnum);

    if (hr <> S_OK) then
    begin
      ShowMessage('SchedulingAgent.Enum Result:' + IntTohex(hr, 8));
      Result := SCHEDULE_ERROR;
      Exit;
    end;

    while (pEnum.Next(1, TaskNames, dwFetched) = 0) and (dwFetched > 0) do
    begin
      //Taskname from enum
      szString := WideCharToString(TaskNames^);

      if szString = MR_JOB then
      begin
        Result := SCHEDULE_EXIST;
        Break;
      end;

      ///////////////////////////////////////
      ActiveX.CoTaskMemFree(TaskNames);
    end;
  finally

  end;
end;

function TFrmMain.ScheduleCreate: Boolean;
var
  HR: HRESULT;
  TaskName: string;
  WorkItem: IUnknown;
  riid, riid2: TGUID;
  AppName, AppDir : String;
  piNewTrigger: Word;
  ITTrigger: ITaskTrigger;
  TaskTrig: TTaskTRIGGER;
begin
  Result := False;

  riid  := CLSID_CTask;
  riid2 := IID_IScheduledWorkItem;

  TaskName := MR_JOB;
  Init;
  HR := SchedulingAgent.NewWorkItem(StrToWide(TaskName), riid, riid2, WorkItem);
  Task := ITask(WorkItem); //required for save
  ScheduledWorkItem := IScheduledWorkItem(WorkItem);
  if HR <> S_OK then
  begin
    ShowMessage('Could not create the job ' + taskname + ' Error Code :' + IntTohex(hr, 8));
    Exit;
  end;

  //Application Name
  AppName := '"'+Application.ExeName+'"';

  HR := Task.SetApplicationName(StrToWide(AppName));
  if HR <> S_OK then
  begin
    showMessage('Error in setting Application Name to :' + (AppName) + 'Error Code:' + IntTohex(HR, 8));
    Exit;
  end;


  //Application Path
  AppDir := '"'+ExtractFileDir(Application.ExeName)+'"';

  hr := Task.SetWorkingDirectory(StrToWide(AppDir));
  if HR <> S_OK then
  begin
    ShowMessage('Error in setting Directory to :' + AppDir + 'Error Code:' + IntTohex(hr, 8));
    Exit;
  end;

  //Comment
  hr := Task.SetComment(StrToWide('Calculate Curve ABC and Computer Auto Request'));
  if hr <> S_OK then
  begin
   ShowMessage('Set Comment failed with errorcode :' + IntTohex(hr, 8) + #13#10);
   Exit;
  end;

  hr := SaveTAsk;
  if (hr <> S_OK) then
  begin
    ShowMessage('Save task failed with error code' + IntTohex(hr, 8) + #13#10);
    Exit;
  end;

  //Schedule
  HR := Task.CreateTrigger(piNewTrigger, ITTrigger);
  if HR <> S_OK then
  begin
    ShowMessage('Error in Create Trigger Error Code:' + IntToHex(HR, 8));
    Exit;
  end;

  // Add code to set trigger structure.
  ZeroMemory(@TaskTrig, sizeof(TASK_TRIGGER));
  TaskTrig.cbTriggerSize := sizeof(TASK_TRIGGER);
  TaskTrig.Reserved1 := 0;

  TaskTrig.wBeginYear := StrToInt(FormatDateTime('yyyy', Now));
  TaskTrig.wBeginMonth := StrToInt(FormatDateTime('mm', Now));
  TaskTrig.wBeginDay := StrToInt(FormatDateTime('dd', Now));
  //TaskTrig.wEndYear := StrToInt(FormatDateTime('yyyy', Now)) + 5;
  //TaskTrig.wEndMonth := 1;
  //TaskTrig.wEndDay := 1;
  TaskTrig.wStartHour := 10;
  TaskTrig.wStartMinute := 0;
  TaskTrig.MinutesDuration := 0;
  TaskTrig.MinutesInterval := 0;
  TaskTrig.rgFlags := TASK_FLAG_HIDDEN;

  TaskTrig.TriggerType := TASK_TIME_TRIGGER_DAILY;
  TaskTrig.wRandomMinutesInterval := 0;
  TaskTrig.Reserved2 := 0;

  hr := ITTrigger.SetTrigger(@TaskTrig);
  if (hr <> S_OK) then
  begin
    //ShowMessage(MessageFromValue(hr));
    //Exit;
  end;

  hr := SaveTAsk;
  if (hr <> S_OK) then
  begin
    ShowMessage('Save task failed with error code' + IntTohex(hr, 8) + #13#10);
    Exit;
  end;

  Result := True;
end;

procedure TFrmMain.ScheduleEdit;
var
  hr: HRESULT;
begin
  Task := GetITask(MR_JOB);
  hr := Task.EditWorkItem(frmMAin.Handle, 0);
  if hr <> S_OK then
    ShowMessage('EditWorkItem return Code :' + IntTohex(hr, 8) + #13#10);
end;

procedure TFrmMain.TimerStartTimer(Sender: TObject);
begin

  TimerStart.Enabled   := False;
  TimerSeconds.Enabled := False;
  lbTimer.Visible      := False;

  if ScheduleExist = SCHEDULE_NO_EXIST then
  begin
    if ScheduleCreate then
       ScheduleEdit;
    Close;
  end
  else
  begin
    btnStop.Visible      := False;
    btnStart.Visible     := False;
    StartTask;
  end;
  
end;

procedure TFrmMain.LoadRegistry;
var
  sResult: String;
  FrmServrInfo: TFrmServerInfo;
  bAbort: Boolean;
  cStartType: Char;
  sServer, sDB,
  sUserName, sPW: String;
  bWinLogin, bUseNetLib: Boolean;
  buildInfo: String;
begin
  with TRegistry.Create do
  begin

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey('SOFTWARE\Applenet\MainRetail', True);
    if not ValueExists('DefaultLanguage') then
      DMGlobal.IDLanguage := LANG_ENGLISH
    else
      DMGlobal.IDLanguage := ReadInteger('DefaultLanguage');

    if not ValueExists('LangPath') then
      WriteString('LangPath', ExtractFilePath(ParamStr(0)) + LANG_DIRECTORY);
    DMGlobal.LangFilesPath := ReadString('LangPath');

    CloseKey;
    Free;
  end;

  //Pegar os Parametros 1 - DataBase, 2 - Backup Path,
  //3 - user name, and 4 - password
  FrmServrInfo  := TFrmServerInfo.Create(self);
  try
    cStartType := '4';
    sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);
  finally
    FrmServrInfo.Free;
  end;

  FrmServrInfo := nil;
  try
    FrmServrInfo  := TFrmServerInfo.Create(self);
    cStartType := '3';
    sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);

    while not bAbort do
    try
      sServer    := ParseParam(sResult, SV_SERVER);
      sDB        := ParseParam(sResult, SV_DATABASE);
      sUserName  := ParseParam(sResult, SV_USER);
      sPW        := ParseParam(sResult, SV_PASSWORD);
      bWinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
      bUseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');

      if not bWinLogin then
        if bUseNetLib then
          sResult := SetConnectionStr(sUserName, sPW, sDB, sServer)
        else
          sResult := SetConnectionStrNoNETLIB(sUserName, sPW, sDB,sServer)
      else
        if bUseNetLib then
          sResult := SetWinConnectionStr(sDB, sServer)
        else
          sResult := SetWinConnectionStrNoNETLIB(sDB, sServer);

      ADOCon.ConnectionString := sResult;
      ADOCon.Open;
      bAbort := True;
    except
      on E: Exception do
      begin
        sResult := FrmServrInfo.Start(cStartType, True, E.Message, bAbort);
      end;
    end;

  finally
    FrmServrInfo.Free;
  end;
end;

procedure TFrmMain.DeleteRepDaily;
begin
  ADOCon.Execute('DELETE DailyMaintenanceReport WHERE Date >= GetDate()-1');
end;

procedure TFrmMain.OpenConnection;
begin
  if not ADOCon.Connected then
    ADOCon.Open;
end;

procedure TFrmMain.btnStopClick(Sender: TObject);
begin
  TimerStart.Enabled   := False;
  TimerSeconds.Enabled := False;
  btnStart.Visible     := True;
  lbWait.Visible       := False;
  btnStop.Visible      := False;
  lbTimer.Visible      := False;
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
begin
  btnStart.Visible := False;
  OpenConnection;
  DeleteRepDaily;
  StartTask;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDailyParams);
end;

procedure TFrmMain.LoadValues;
begin
  memCalcAvg.Checked := FDailyParams.ReadBool('Settings', 'CalcAvg', True);
  memCalcABC.Checked := FDailyParams.ReadBool('Settings', 'CalcABC', True);
  memDelHold.Checked := FDailyParams.ReadBool('Settings', 'DeleteHold', True);
end;

procedure TFrmMain.SaveValues;
begin
  FDailyParams.WriteBool('Settings', 'CalcAvg', memCalcAvg.Checked);
  FDailyParams.WriteBool('Settings', 'CalcABC', memCalcABC.Checked);
  FDailyParams.WriteBool('Settings', 'DeleteHold', memDelHold.Checked);
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveValues;
end;

procedure TFrmMain.TimerSecondsTimer(Sender: TObject);
begin
  lbTimer.Caption := Format(sCountText, [iTime]);
  Dec(iTime);
  lbTimer.Visible := True;
  btnStop.Visible := True;
  Application.ProcessMessages;
end;

procedure TFrmMain.memCalcAvgClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked; 
end;

end.
