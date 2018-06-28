unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, StdCtrls, ActiveX, Shellapi, MsTask, MsTaskUtils,
  siComp;

const
  SCHEDULE_EXIST    = 1;
  SCHEDULE_NO_EXIST = 2;
  SCHEDULE_ERROR    = 3;

  MR_JOB            = 'MRCalcABC.job';

type
  TFrmMain = class(TForm)
    ADOCon: TADOConnection;
    spCalcModelABC: TADOStoredProc;
    spAutoRequest: TADOStoredProc;
    lbWait: TLabel;
    Label1: TLabel;
    Timer: TTimer;
    TimerStart: TTimer;
    siLang: TsiLang;
    Label2: TLabel;
    spDailyMaintenance: TADOStoredProc;
    btnStart: TButton;
    btnStop: TButton;
    spCalcStoreABC: TADOStoredProc;
    spCalcBalance: TADOStoredProc;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerStartTimer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    sABCModel,
    sABCStore,
    sInvBalance,
    sAutoRequest,
    sDelHold: String;
    procedure LoadRegistry;
    procedure StartTask;
    function ScheduleExist : Integer;
    function ScheduleCreate : Boolean;
    procedure ScheduleEdit;
    procedure DeleteRepDaily;
    procedure OpenConnection;
  end;

var
  FrmMain: TFrmMain;
  SchedulingAgent: ITaskScheduler;
  ScheduledWorkItem: IScheduledWorkItem;
  pIPersistFile: IPersistFile;
  Task: ITask;


implementation

uses AuxProcs, uParamFunctions, uMsgBox, ufrmServerInfo, uDMGlobal, uSystemConst,
     Registry, uNumericFunctions, RTLConsts;


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
  if hr = S_OK then Result := ITask(PITask)
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
  begin
    Result := pIPersistFile.Save(nil, true);
  end
  else ShowMessage('Error in  Task.QueryInterface(IID_IPersistFile, pIPersistFile):');
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

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  LoadRegistry;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sABCModel    := 'Calculating ABC curve by Model';
      sABCStore    := 'Calculating ABC curve by Store';
      sInvBalance  := 'Calculating Inventory Balance';
      sAutoRequest := 'Creating Auto-Request';
      sDelHold     := 'Running Daily Maintenance';
    end;

    LANG_PORTUGUESE:
    begin
      sABCModel    := 'Calculando curva ABC por Produto';
      sABCStore    := 'Calculando curva ABC por Loja';
      sInvBalance  := 'Calculando Saldo do Estoque';
      sAutoRequest := 'Criando Sugestão Compra';
      sDelHold     := 'Executando Manutenção diária';
    end;

    LANG_SPANISH :
    begin
      sABCModel    := 'Calculating ABC curve by Model';
      sABCStore    := 'Calculating ABC curve by Store';
      sInvBalance  := 'Calculating Inventory Balance';
      sAutoRequest := 'Creating Auto-Request';
      sDelHold     := 'Running Daily Maintenance';
    end;
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  TimerStart.Enabled := True;
end;

procedure TFrmMain.StartTask;
begin
  Label1.Visible := True;
  lbWait.Visible := True;

  OpenConnection;

  try
    Label1.Caption := sABCModel;
    Application.ProcessMessages;

    try
      spCalcModelABC.ExecProc;
    except
      raise;
    end;

    Label1.Caption := sABCStore;
    Application.ProcessMessages;

    try
      spCalcStoreABC.ExecProc;
    except
      raise;
    end;

    Label1.Caption := sAutoRequest;
    Application.ProcessMessages;

    try
     with spAutoRequest do
       ExecProc;
    except
      raise;
    end;

    Label1.Caption := sInvBalance;
    Application.ProcessMessages;

    try
     with spCalcBalance do
       ExecProc;
    except
      raise;
    end;

    Label1.Caption := sDelHold;
    Application.ProcessMessages;

    try
     with spDailyMaintenance do
       ExecProc;
    except
      raise;
      end;

    Application.ProcessMessages;

  finally
    ADOCon.Close;
    Timer.Enabled := True;
    Close;
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

  TimerStart.Enabled := False;

  if ScheduleExist = SCHEDULE_NO_EXIST then
  begin
    if ScheduleCreate then
       ScheduleEdit;
    Close;
  end
  else
    StartTask;

end;

procedure TFrmMain.LoadRegistry;
var
  sResult : String;
  FrmServrInfo : TFrmServerInfo;
  bAbort : Boolean;
  cStartType : Char;

  sServer, sDB,
  sUserName, sPW : String;
  bWinLogin, bUseNetLib : Boolean;

begin

  with TRegistry.Create do
  begin
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
  Try
     cStartType := '4';
     sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);
  Finally
     FrmServrInfo.Free;
  end;

  FrmServrInfo := nil;
  try
      FrmServrInfo  := TFrmServerInfo.Create(self);
      cStartType := '3';
      sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);

      While not bAbort do
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

procedure TFrmMain.btnStartClick(Sender: TObject);
begin
  btnStart.Visible := False;
  OpenConnection;
  DeleteRepDaily;
  StartTask;
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
  TimerStart.Enabled := False;
  btnStart.Visible   := True;
  Label1.Visible     := False;
  lbWait.Visible     := False;
  btnStop.Visible    := False;
end;

end.
