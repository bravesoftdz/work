unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, ADODB, IniFiles, ActiveX,
  Email, MsTask, MsTaskUtils, AuxProcs, uDataBaseOperation, uOperationSystem,
  uDownloadFunctions, ShFolder, IdHashMessageDigest, idHash, AbBrowse, AbMeter,
  AbBase, AbZBrows, AbUnzper;
              
const

  REG_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

  { Server information }
  SV_SERVER     = '#SRV#=';
  SV_DATABASE   = '#DB#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_WIN_LOGIN  = '#WIN#=';
  SV_USE_NETLIB = '#NLIB#=';

  { Firewall controls }
  NET_FW_PROFILE_DOMAIN = 0;
  NET_FW_PROFILE_STANDARD = 1;
  NET_FW_IP_VERSION_ANY = 2;
  NET_FW_IP_PROTOCOL_UDP = 17;
  NET_FW_IP_PROTOCOL_TCP = 6;
  NET_FW_SCOPE_ALL = 0;
  NET_FW_SCOPE_LOCAL_SUBNET = 1;

  { Previledges controls }

  SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege';
  SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege';
  SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege';
  SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege';
  SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege';
  SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege';
  SE_TCB_NAME = 'SeTcbPrivilege';
  SE_SECURITY_NAME = 'SeSecurityPrivilege';
  SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege';
  SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege';
  SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege';
  SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege';
  SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege';
  SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege';
  SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege';
  SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege';
  SE_BACKUP_NAME = 'SeBackupPrivilege';
  SE_RESTORE_NAME = 'SeRestorePrivilege';
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
  SE_DEBUG_NAME = 'SeDebugPrivilege';
  SE_AUDIT_NAME = 'SeAuditPrivilege';
  SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege';
  SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege';
  SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege';
  SE_UNDOCK_NAME = 'SeUndockPrivilege';
  SE_SYNC_AGENT_NAME = 'SeSyncAgentPrivilege';
  SE_ENABLE_DELEGATION_NAME = 'SeEnableDelegationPrivilege';
  SE_MANAGE_VOLUME_NAME = 'SeManageVolumePrivilege';

type

  TInstallationType = ( itInstall , itUpdate, itRepair, itUnInstall );
  TProcessType = ( ptDownload, ptInstall, ptOtherConfiguration );

  TFrmMain = class(TForm)
    pnlBotton: TPanel;
    imgBotton: TImage;
    btnClose: TBitBtn;
    btnNext: TBitBtn;
    btnPrior: TBitBtn;
    ADODBConnect: TADOConnection;
    pgWizard: TPageControl;
    TbsInstallationType: TTabSheet;
    tsConfiguracao: TTabSheet;
    cmdUpdateMenu: TADOCommand;
    Label4: TLabel;
    Button1: TButton;
    lbMenu: TLabel;
    Label5: TLabel;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    TbsDone: TTabSheet;
    TbsInstallationComponents: TTabSheet;
    ChkBxInstallSQLSERVER: TCheckBox;
    ChkBxInstallMRReport: TCheckBox;
    LblTitle: TLabel;
    UnZipper: TAbUnZipper;
    AbVCLMeterLink1: TAbVCLMeterLink;
    Email1: TEmail;
    tsPOSServer: TTabSheet;
    tsPDV: TTabSheet;
    TbsInstallationInfo: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    AbMeter1: TAbMeter;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    btnExtract: TButton;
    CheckBox8: TCheckBox;
    Panel2: TPanel;
    rgServer: TRadioGroup;
    lbSQLInfo: TLabel;
    btnMSDE: TButton;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    RdGrpInstallationType: TRadioGroup;
    tsInstalEst: TTabSheet;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    Button9: TButton;
    Label9: TLabel;
    Button10: TButton;
    Button11: TButton;
    CheckBox37: TCheckBox;
    Button12: TButton;
    CheckBox38: TCheckBox;
    Label10: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    MemoInfo: TMemo;
    Label12: TLabel;
    edtRemoteWorkDir: TEdit;
    Button14: TButton;
    Label13: TLabel;
    Label14: TLabel;
    edtServerFileDir: TEdit;
    Label15: TLabel;
    CheckBox36 : TCheckBox;
    CheckBox39 : TCheckBox;
    CheckBox40 : TCheckBox;
    CheckBox41 : TCheckBox;
    CheckBox42 : TCheckBox;
    CheckBox43 : TCheckBox;
    Button15: TButton;
    CheckBox44: TCheckBox;
    CheckBox45: TCheckBox;
    CheckBox46: TCheckBox;
    CheckBox47: TCheckBox;
    CheckBox48: TCheckBox;
    CheckBox49: TCheckBox;
    OD: TOpenDialog;
    rgTipoPDV: TRadioGroup;
    Panel3: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtPOSRemote: TEdit;
    edtPOSServerFiles: TEdit;
    btnRemoteDir: TSpeedButton;
    SpeedButton1: TSpeedButton;
    CheckBox50: TCheckBox;
    Button16: TButton;
    Label20: TLabel;
    edtImpressora: TEdit;
    CheckBox51: TCheckBox;
    CheckBox52: TCheckBox;
    ChkBxInstallDSIClient: TCheckBox;
    ChkBxInstallIPDialBridge: TCheckBox;
    ChkBxInstallU209: TCheckBox;
    ChkBxInstallTSP100: TCheckBox;
    Bevel1: TBevel;
    ChkBxInstallPID: TCheckBox;
    ChkBxInstallMRImportExport: TCheckBox;
    ChkBxInstallSwitchDB: TCheckBox;
    ChkBxInstallMRPoleDisplay: TCheckBox;
    ChkBxInstallMRPoleDisplaySvr: TCheckBox;
    PnlClientInstallationInfo: TPanel;
    Label3: TLabel;
    EdtServerIPAddress: TEdit;
    LblVersion: TLabel;
    TbsOptions: TTabSheet;
    Memo: TMemo;
    LblRepairMessage: TLabel;
    PnlOptions: TPanel;
    BtnUpdate: TBitBtn;
    BtnRepair: TBitBtn;
    PnlProcessEvolution: TPanel;
    LblStepDescription: TLabel;
    LblItemDescription: TLabel;
    ProgressBarExterno: TAbMeter;
    ProgressBar: TProgressBar;
    LblReleaseType: TLabel;
    PnlReleaseVersion: TPanel;
    CbxReleaseType: TComboBox;
    BtnSaveReleaseOption: TBitBtn;
    ChkBxBackupDatabase: TCheckBox;
    BtnTests: TButton;
    ChkBxInstallDotnetFramework: TCheckBox;
    ChkBxInstallWindowsPoweShell: TCheckBox;
    ChkBxInstallWindowsInstaller: TCheckBox;
    ChkBxRecalculateInventoryValues: TCheckBox;
    ChkBxInstallMAGSWIPE_CFG: TCheckBox;
    Label2: TLabel;
    Label6: TLabel;
    LblAvailableVersion: TLabel;
    LblCurrentVersion: TLabel;
    LblMessage: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox8Click(Sender: TObject);
    procedure rgServerClick(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure RdGrpInstallationTypeExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure BtnRepairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnTestsClick(Sender: TObject);
    procedure BtnDownLoadClick(Sender: TObject);
  private

    DownloadFile : TDownloadFile;
    DBOperation  : TDataBaseOperation;

    bExitProcess, bSelfUpdating : Boolean;

    FInstacaoFile, FManifest : TIniFile;
    FServerIPAdress : String;

    InstallationType : TInstallationType;

    iPosition : Integer;
    FMainRetailVersion, FMainRetailDBVersion : Integer;

    sPW, sUser, sDBAlias, sServer : String;
    sParameter, sFinalValue : String;

    { Alex 05/04/2011 }
    Class Function IsWOW64 : Boolean;

    Function IsSQLSERVERInstalled() : Boolean;
    Function RunAsAdminAndWaitForCompletion( psFileName : String; psParameters : String ): Boolean;
    Function CreateWindowsProcessAndWait( Const csAppName, psCommandLine : String ) : Boolean;
    Function CreateWindowsProcessAsUser( psCommandLine  : String;
                                         psUsername     : String;
                                         psUserPassword : String;
                                         pbShowOnScreen : Boolean ) : Boolean;
    Function RegisterDLLs : Boolean;
    Function ReturnComputerName: string;
    Function ReturnWindowsFolder( piFolderId : Integer = -1) : String; OverLoad;
    Function NTSetPrivilege(sPrivilege: string; bEnabled: Boolean): Boolean;
    Function WinVersion : string;
    Function FileMD5Hash( psFileName : String ) : String;

    Function ParseConnectionParameters( psParameters, psParameterToExtract : String ): String;

    Function ValidatePage : Boolean;

    Function ProcessItem( psItemName : String; pProcessType : TProcessType ) : Boolean;

    Function DownloadItem( psItemName : String ) : Boolean;
    Function InstallItem( psItemName : String ) : Boolean;
    Function UnZipItem( psItemName : String; pbEmptyFolder : Boolean = False ) : Boolean;
    Function MoveFolder( psSourceFolder, psDetinyFolder : String): Boolean;

    Function ConfigureDataBase( psItemName : String; Var psErrorMessage : String ) : Boolean;
    Function RecalculateDataBase( psItemName : String ) : Boolean;

    Function OpenConnection : Boolean;
    Function UpdateMainRetalVersion : Boolean;


    Procedure CloseConnection;

    Procedure ListAvailableSQLServers(Names : TStrings);
    Procedure UnZipFile(DestDir, ZipFileName: String);
    Procedure CloseApplication( psApplicationName : String );
    Procedure TrayHIDE( psApplicationname : String );
    Procedure AddPortToFirewall(EntryName,ProtocolType:string;PortNumber:Cardinal);
    Procedure AddApplicationToFirewall(EntryName:string;ApplicationPathAndExe:string);
    Procedure Machine_Restart;
    Procedure EmptyDirectories( Directory, FileMask: String; DelSubDirs: Boolean );

    Procedure CreateUser();

    Procedure InstallMainRetail();

    Procedure ProcessDownloads();
    Procedure ProcessInstallation( pbExecutigFromStartUp : Boolean );
    Procedure ProcessOtherConfigurations();

    Procedure MovNext;
    Procedure MovPrior;

    Procedure OnAfterMovNext;

    Procedure SaveFileInfo;
    Procedure SaveCustomerFolders();
    Procedure RestoreCustomerFolders();
    Procedure UpdateCustomerFiles();
    Procedure AddScheduledTasks();


    Procedure SetCheckBoxes( pbUnSelectAll : Boolean );
    Procedure SaveSettings();
    Procedure CloseMainRetailApplications();
    Procedure CriarAtalho( ANomeArquivo,  AParametros, ADiretorioInicial,
                           ANomedoAtalho, APastaDoAtalho : String );

    Procedure CreateINIFiles();
    Procedure CheckForNewVersion( bDoShow : Boolean );
    Procedure CheckCurrentVersionInfo( Var psMainRetailVersion : Integer;
                                       Var psDataBaseVersion   : Integer );

    Procedure Finish;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  SchedulingAgent: ITaskScheduler;
  ScheduledWorkItem: IScheduledWorkItem;
  pIPersistFile: IPersistFile;
  Task: ITask;

  MR_INSTALL, MR_INSTALL_FILES : String;


  function CreateProcessWithLogon(lpUsername: PWChar;
                                  lpDomain: PWChar;
                                  lpPassword: PWChar;
                                  dwLogonFlags: DWORD;
                                  lpApplicationName: PWChar;
                                  lpCommandLine: PWChar;
                                  dwCreationFlags: DWORD;
                                  lpEnvironment: Pointer;
                                  lpCurrentDirectory: PWChar;
                                  const lpStartupInfo: TStartupInfo;
                                  var lpProcessInfo: TProcessInformation): BOOL; stdcall;

implementation

uses Registry, uParamFunctions, uEncryptFunctions, uFileFunctions, ShellAPI,
     ShlObj, ComObj, uWebFunctions, AdoInt, OleDB, Math, uDM;

{$R *.dfm}

function CreateProcessWithLogon; external advapi32 name 'CreateProcessWithLogonW';

class function TFrmMain.IsWOW64: Boolean;
type
  TIsWow64Process = function( Handle: THandle; var Res: BOOL ): BOOL; stdcall;
var
  IsWow64Result: BOOL;              // result from IsWow64Process
  IsWow64Process: TIsWow64Process;  // IsWow64Process fn reference
begin

  // Try to load required function from kernel32
  IsWow64Process := GetProcAddress( GetModuleHandle('kernel32'), 'IsWow64Process' );

  if Assigned(IsWow64Process) then begin

    // Function is implemented: call it
    if not IsWow64Process(GetCurrentProcess, IsWow64Result)
    then raise Exception.Create('Bad process handle');
    // Return result of function
    Result := IsWow64Result;

  end else begin

    // Function not implemented: can't be running on Wow64
    Result := False;

  end;

end;



procedure TFrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.CloseConnection;
begin

  if ADODBConnect.Connected then ADODBConnect.Close;

end;

function TFrmMain.OpenConnection : Boolean;
Var
  sDadosDoRegistro : String;
  Reg : TRegistry;
  buildInfo: String;
begin

  try

  if not ADODBConnect.Connected then
  begin

    //Pega as info local
    Reg := TRegistry.Create;

    // aponta para a chave CURRENT_USER se Windows 7
    if ( getOs(buildInfo) = osW7 ) then
      Reg.RootKey := HKEY_CURRENT_USER
    else
      Reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey('SOFTWARE\AppleNet', True);

    sDadosDoRegistro := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    sServer  := ParseConnectionParameters( sDadosDoRegistro, '#SRV#=' );
    sDBAlias := ParseConnectionParameters( sDadosDoRegistro, '#DB#=' );
    sUser    := ParseConnectionParameters( sDadosDoRegistro, '#USER#=' );
    sPW      := ParseConnectionParameters( sDadosDoRegistro, '#PW#=' );

    sDadosDoRegistro := SetConnectionStr(sUser, sPw, SDBAlias, sServer);

    //Fechar o Registry
    Reg.CloseKey;
    Reg.Free;


    ADODBConnect.ConnectionString := sDadosDoRegistro;
    ADODBConnect.Open;

  end;

  except
    Result := False;
    Exit;
  end;

  Result := True;

end;

procedure TFrmMain.Finish;
var
  i : Integer;
begin

  SaveFileInfo;
  Close;

end;

procedure TFrmMain.FormCreate(Sender: TObject);

  Function VersaoExe( Const FileName : String ) : String;
  Var
    VerInfoSize, VerValueSize, Dummy: Dword;
    VerInfo: Pointer;
    VerValue: PVSFixedFileInfo;
    V1, V2, V3, V4: Word;
  Begin

    VerInfoSize:=GetFileVersionInfoSize(PChar(FileName),Dummy);

    GetMem(VerInfo,VerInfoSize);
    GetFileVersionInfo(PChar(FileName),0,VerInfoSize,VerInfo);

    VerQueryValue(VerInfo,'',Pointer(VerValue),VerValueSize);

    with VerValue^ do begin

      V1:=dwFileVersionMS shr 16;
      V2:=dwFileVersionMS and $FFFF;
      V3:=dwFileVersionLS shr 16;
      V4:=dwFileVersionLS and $FFFF;

    end;

    FreeMem(VerInfo,VerInfoSize);
    VersaoEXE:= 'Version '+IntToStr(v1)+' Build '+IntToStr(v4);

  End;

  Function ExibeVersaoApp() : String;
  Var
    iNewMainRetailVersion, iNewMainRetailDBVersion : Integer;
  Begin

     CheckCurrentVersionInfo( FMainRetailVersion, FMainRetailDBVersion );

     iNewMainRetailVersion   := FManifest.ReadInteger( 'Versions', 'MR', -1 );
     iNewMainRetailDBVersion := FManifest.ReadInteger( 'Versions', 'MRDB', -1 );

     LblCurrentVersion.Caption   := IntToStr( FMainRetailVersion )    + ' / ' + IntToStr( FMainRetailDBVersion );
     LblAvailableVersion.Caption := IntToStr( iNewMainRetailVersion ) + ' / ' + IntToStr( iNewMainRetailDBVersion );

     LblCurrentVersion.Visible   := True;
     LblAvailableVersion.Visible := True;

  End;

Begin

  Inherited;

  InstallationType := itInstall;

  bSelfUpdating := False;
  bExitProcess  := False;

  PnlOptions.Visible        := False;
  PnlReleaseVersion.Visible := False;

  LblCurrentVersion.Visible   := False;
  LblAvailableVersion.Visible := False;

  pgWizard.Top := -25;
  pgWizard.ActivePageIndex := 0;

  MR_INSTALL := ReturnWindowsFolder() + '\MainRetail';
  MR_INSTALL_FILES := ReturnWindowsFolder() + '\MainRetail\Installation Files';

  FServerIPAdress := '127.0.0.1';

  FMainRetailVersion   := -1;
  FMainRetailDBVersion := -1;

  LblRepairMessage.Visible := False;

  DownloadFile := TDownloadFile.Create();

  LblVersion.Caption        :=  VersaoExe( Application.ExeName );

  If ( FInstacaoFile = Nil ) Then Begin

    FInstacaoFile := TIniFile.Create( ExtractFileDir( Application.ExeName ) + '\MainRetail_Wizard.ini' );
    FInstacaoFile.UpdateFile();

    SetCheckBoxes( False );
    CheckForNewVersion( True );

    If ( bExitProcess = True ) Then Exit;

    InstallationType := itRepair;
    ExibeVersaoApp();
    InstallationType := itInstall;

  End;


  With TRegistry.Create( KEY_READ OR $0100 ) Do Begin

    RootKey := HKEY_LOCAL_MACHINE;

    OpenKey( REG_PATH, False );

    If ( ValueExists( 'MainRetail_Wizard' ) ) Then Begin

      SetCheckBoxes( False );

      InstallMainRetail();
      If ( bExitProcess = True ) Then Exit;

      pgWizard.ActivePage := TbsDone;

    End;

    Free;

  End;

End;

function TFrmMain.ValidatePage: Boolean;
var
  i : Integer;
begin

  if pgWizard.ActivePage = TbsInstallationType then begin

  end;

  Result := True;

end;

procedure TFrmMain.btnNextClick(Sender: TObject);
Var
  sCommandText : String;
begin

  If ( Pos( 'DESKTOP', UpperCase( ExtractFilePath( Application.ExeName )  ) ) > 0 ) Then Begin

    MessageDlg( 'Installation cannot be executed from Desktop folder', mtWarning, [mbOK], 0 );
    Exit;

  End;

  MovNext;

end;

procedure TFrmMain.btnPriorClick(Sender: TObject);
begin
  MovPrior;
end;

procedure TFrmMain.RdGrpInstallationTypeExit(Sender: TObject);
var
  bFileExist : Boolean;
begin

  { Alex 05/03/2011 }
  bFileExist := FileExists(ExtractFileDir(Application.ExeName) + '\MainRetail_Wizard.ini');

  If ( Not bFileExist ) Then
    FInstacaoFile.WriteDateTime('Setup', 'Begining', Now);

end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  bRunNewVersion, bProcessItem : Boolean;
  sCommandText : String;
begin

  If ( FInstacaoFile <> Nil ) Then Begin

    bRunNewVersion := FInstacaoFile.ReadBool( 'Setup', 'RUNNEWVERSION', True );

    If ( ( bSelfUpdating = False ) And ( bRunNewVersion = True ) ) Then Begin

      InstallationType := itRepair;

      FInstacaoFile.WriteBool( 'Setup', 'RUNNEWVERSION', False );
      FInstacaoFile.WriteBool( 'Installation', 'MAINRETAIL_WIZARD.ZIP', True );

      sCommandText := ExtractFileDir( Application.ExeName ) + '\MainRetail_Wizard.ini';
      CopyFile( sCommandText, MR_INSTALL + '\MainRetail_Wizard.ini', True );

      UnZipItem( 'MAINRETAIL_WIZARD.ZIP' );

    End;

    if FInstacaoFile <> nil then FreeAndNil( FInstacaoFile );
    if FManifest <> nil then FreeAndNil( FManifest );

  End;

  Inherited;

end;

procedure TFrmMain.UnZipFile(DestDir, ZipFileName: String);
begin

  try

    UnZipper.BaseDirectory := DestDir;
    UnZipper.FileName      := ZipFileName;

    try
      UnZipper.ExtractFiles('*.*');
    finally
      UnZipper.CloseArchive;
    end;

  except

  end;

end;

procedure TFrmMain.CheckBox8Click(Sender: TObject);
begin
  btnExtract.Enabled := not CheckBox8.Checked;
end;

procedure TFrmMain.rgServerClick(Sender: TObject);
begin
  lbSQLInfo.Visible := (rgServer.ItemIndex = 1);
end;

procedure TFrmMain.SaveFileInfo;
var
  i : Integer;
begin

  If ( FInstacaoFile <> Nil ) Then Begin

    FInstacaoFile.WriteString( 'Setup',  'Type', RdGrpInstallationType.Items.Strings[RdGrpInstallationType.ItemIndex] );
    FInstacaoFile.WriteInteger( 'Setup', 'VersionType', CbxReleaseType.ItemIndex );

  End;

end;

Procedure TFrmMain.UpdateCustomerFiles();
Var
  bEmptyFolder: Boolean;
Begin

  If ( InstallationType <> itInstall ) Then SaveCustomerFolders();

  bEmptyFolder := True;

  Application.ProcessMessages();

  LblItemDescription.Caption  := 'Unzipping new Receits, please wait';
  UnZipItem( 'RECEIPTS.ZIP', bEmptyFolder );
  LblItemDescription.Caption  := 'Unzipping new Labels, please wait';
  UnZipItem( 'LABELS.ZIP', bEmptyFolder  );
  LblItemDescription.Caption  := 'Unzipping new Reports, please wait';
  UnZipItem( 'REPORTS.ZIP', bEmptyFolder  );
  LblItemDescription.Caption  := 'Unzipping new PoleDisplay, please wait';
  UnZipItem( 'MRPOLEDISPLAY.ZIP' );

  LblItemDescription.Caption  := 'Restoring customer files, please wait';

  If ( InstallationType <> itInstall ) Then RestoreCustomerFolders();

End;

Procedure TFrmMain.AddScheduledTasks;
Var
  sCommandText, sCommandParameters, sLPParameters, sDUParameters : String;
Begin

  Try

    Screen.Cursor := crHourGlass;

    LblItemDescription.Caption  := 'Adding Schedule Tasks, please wait';

    Application.ProcessMessages();

    If ( WinVersion() = 'Windows7' )
    Then sCommandText := ReturnWindowsFolder( CSIDL_SYSTEM ) + '\SCHTASKS.EXE'
    Else sCommandText := ReturnWindowsFolder() + '\MAINRETAIL\SCHTASKS.EXE';

    RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MRDAILYMAINTENANCE"  /F ' );
    RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MRBACKUP"            /F ' );
    RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MRCATALOG - FULL"    /F ' );
    RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MRCATALOG - DAILY"   /F ' );

    sDUParameters :=  '';
    sLPParameters :=  '';

    //If ( WinVersion() = 'WindowsXP' ) Then sLPParameters := '\""';
    sLPParameters := '\""';

    sCommandParameters := '/CREATE /TN "MRDAILYMAINTENANCE" /TR '+ sLPParameters + ReturnWindowsFolder() + '\MAINRETAIL\MRDAILYMAINTENANCE.EXE ' + sLPParameters + ' /RU SYSTEM /SC DAILY /ST 03:01:00 ';
    //If ( WinVersion() = 'Windows7' ) Then sDUParameters := '/DU 08:59:00';
    If ( Not RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters + sDUParameters ) ) Then Abort;

    sCommandParameters := '/CREATE /TN "MRBACKUP" /TR '+ sLPParameters + ReturnWindowsFolder() + '\MAINRETAIL\MRBACKUP.EXE ' + sLPParameters + ' /RU SYSTEM /SC DAILY /ST 23:01:00 ';
    //If ( WinVersion() = 'Windows7' ) Then sDUParameters := '/DU 01:01:00';
    If ( Not RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters + sDUParameters ) ) Then Abort;

    sCommandParameters := '/CREATE /TN "MRCATALOG - FULL" /TR '+ sLPParameters + 'C:\PINOGY\BIN\MINIUPDATE.EXE ' + sLPParameters + ' /RU SYSTEM /SC WEEKLY /ST 00:01:00 ' ;
    //If ( WinVersion() = 'Windows7' ) Then sDUParameters := '/DU 08:59:00';
    If ( Not RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters + sDUParameters ) ) Then Abort;

    sCommandParameters := '/CREATE /TN "MRCATALOG - DAILY" /TR '+ sLPParameters + 'C:\PINOGY\BIN\MINIUPDATE.BAT ' + sLPParameters + ' /RU SYSTEM /SC DAILY /ST 06:01:00 ';
    //If ( WinVersion() = 'Windows7' ) Then sDUParameters := '/DU 08:59:00';
    If ( Not RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters + sDUParameters ) ) Then Abort;

    FInstacaoFile.WriteBool( 'Configurations', 'SCHEDULETASKS', False );

  Except

    On E:Exception Do Begin

      Screen.Cursor := crDefault;
      FInstacaoFile.WriteBool( 'Configurations', 'SCHEDULETASKS', True );

      MemoInfo.Lines.Add( ' - ' + 'Problems adding Schedule Tasks settings : ' );
      MemoInfo.Lines.Add( '   ' + sCommandText );
      MemoInfo.Lines.Add( '     ' + sCommandParameters + '   ' + sDUParameters );
      //MessageDlg( 'Problems Schedule Tasks settings:' + #13 + #13 + E.Message, mtWarning, [mbOK], 0 );

    End;

  End;

  Screen.Cursor := crDefault;

End;

Procedure TFrmMain.SaveCustomerFolders();
Begin

  MoveFolder( 'C:\MainRetail\Reports\Store Custom Reports',   'C:\MainRetail' );
  MoveFolder( 'C:\MainRetail\Labels\Store Custom Labels',     'C:\MainRetail' );

  MoveFolder( 'C:\MainRetail\Receipts\Store Custom Receipts', 'C:\MainRetail' );
  MoveFolder( 'C:\MainRetail\Receipts\Store Logos',           'C:\MainRetail' );

  Application.ProcessMessages();
  Sleep( 1000 );

End;

Procedure TFrmMain.RestoreCustomerFolders();
Begin

  MoveFolder( 'C:\MainRetail\Store Custom Reports',  'C:\MainRetail\Reports' );
  MoveFolder( 'C:\MainRetail\Store Custom Labels',   'C:\MainRetail\Labels' );

  MoveFolder( 'C:\MainRetail\Store Custom Receipts', 'C:\MainRetail\Receipts' );
  MoveFolder( 'C:\MainRetail\Store Logos',           'C:\MainRetail\Receipts' );

End;

procedure TFrmMain.Label7Click(Sender: TObject);
begin
  OpenURL(TLabel(Sender).Caption);
end;

Function TFrmMain.RegisterDLLs: Boolean;
Var
  sFolderName, sFileName : String;
Begin

  Try

    Result := True;

    sFolderName := MR_INSTALL_FILES + '\DOWNLOAD';

    UnZipFile( sFolderName, sFolderName + '\MAINRETAIL_DLL.ZIP' );

    sFileName := sFolderName+'\midas.dll';
    if FileExists(sFileName) then begin
      CopyFile( sFileName, MR_INSTALL+'\midas.dll', True );
      ShellExecute(handle, 'open', 'regsvr32.exe', PChar(QuotedStr(MR_INSTALL+'\midas.dll'+' /s')), nil, 1);
    end;

    sFileName := sFolderName+'\crpe32.dll';
    if FileExists(sFileName) then begin
      CopyFile( sFileName, MR_INSTALL+'\crpe32.dll', True );
      // ShellExecute(handle, 'open', 'regsvr32.exe', PChar(QuotedStr(MR_INSTALL+'\crpe32.dll'+' /s')), nil, 1);
    end;

    sFileName := sFolderName+'\PCMaintSvc.exe';
    if FileExists(sFileName) then begin

     CopyFile( sFileName, MR_INSTALL+'\PCMaintSvc.exe', True );
     ShellExecute(handle, 'open', PChar( MR_INSTALL+'\PCMaintSvc.exe' ), PChar( ' --INSTALL AUTO' ), nil, SW_HIDE);

    end;

    LblItemDescription.Caption  := 'Uninstalling services, please wait';
    Application.ProcessMessages();

    sFileName := sFolderName + '\scktsrvr.exe';
    If FileExists( sFileName ) Then Begin
      { Open and save socket info }

      Try

        RunAsAdminAndWaitForCompletion( 'NET', 'STOP SOCKETSERVER' );
        RunAsAdminAndWaitForCompletion( MR_INSTALL+'\SCKTSRVR.EXE', '/UNINSTALL' );

        RunAsAdminAndWaitForCompletion( 'NET', 'STOP PCMAINTSVC' );
        RunAsAdminAndWaitForCompletion( MR_INSTALL+'\PCMAINTSVC.EXE', '--REMOVE' );

        LblItemDescription.Caption  := 'Closing services applications for replacement, please wait';
        Application.ProcessMessages();

        CloseApplication('Borland Socket Server');

        CopyFile( sFileName, MR_INSTALL+'\scktsrvr.exe', True );

      Except

      End;

      {
      With TRegistry.Create( KEY_READ OR $0100 ) Do Begin

        RootKey := HKEY_LOCAL_MACHINE;

        OpenKey( REG_PATH, False );

        If Not ValueExists( 'SocketSvr' ) Then WriteString( 'SocketSvr', MR_INSTALL+'\scktsrvr.exe' );

        Free;

      End;
      }

      LblItemDescription.Caption  := 'Installing services, please wait';
      Application.ProcessMessages();

      RunAsAdminAndWaitForCompletion( MR_INSTALL+'\SCKTSRVR.EXE', '/INSTALL' );
      RunAsAdminAndWaitForCompletion( 'NET', 'START SOCKETSERVER' );

      RunAsAdminAndWaitForCompletion( MR_INSTALL+'\PCMAINTSVC.EXE', '--INSTALL' );
      RunAsAdminAndWaitForCompletion( 'NET', 'START PCMAINTSVC' );

    End;

  Except

    Result := False;

  End;

End;

function TFrmMain.ReturnComputerName: string;
var
   CompName: PChar;
   AComputer : string;
   AWritten: Cardinal;
begin

   SetLength(AComputer, MAX_COMPUTERNAME_LENGTH + 1);
   AWritten := Length(AComputer);

   GetMem(CompName, AWritten);
   try
      GetComputerName(CompName, AWritten);
      Result := CompName;
   finally
      FreeMem(CompName);
   end;
   
end;

 
procedure TFrmMain.FormShow(Sender: TObject);
begin

  Inherited;

  Application.ProcessMessages();

  // Self.Visible := True;

  If ( bExitProcess = True )
  Then Self.Close();

end;

procedure TFrmMain.MovNext;
var
  i, iPage : Integer;
begin

  If ( pgWizard.ActivePage = TbsOptions  ) Then Begin

    pgWizard.ActivePage := TbsInstallationType;

  End Else If ( pgWizard.ActivePage = TbsInstallationType ) Then Begin

    SaveFileInfo;

    PnlClientInstallationInfo.Visible := False;

    btnNext.Enabled     := True;
     
    ChkBxInstallDotnetFramework.Visible      := False;
    ChkBxInstallWindowsPoweShell.Visible     := False;
    ChkBxInstallWindowsInstaller.Visible     := False;
    ChkBxRecalculateInventoryValues.Visible  := False;

    {
    ChkBxInstallDotnetFramework.Checked     := True;
    ChkBxInstallWindowsPoweShell.Checked    := True;
    ChkBxInstallWindowsInstaller.Checked    := True;
    ChkBxRecalculateInventoryValues.Visible := True;
    }

    If ( InstallationType = itRepair ) Then Begin

      ChkBxInstallDotnetFramework.Visible     := True;
      ChkBxRecalculateInventoryValues.Visible := True;


      If ( ( WinVersion() = 'WindowsXP' ) ) Then Begin

        ChkBxInstallWindowsPoweShell.Visible := True;
        ChkBxInstallWindowsInstaller.Visible := True;

      End;

    End;


    If ( RdGrpInstallationType.ItemIndex = 0 ) Then Begin

      PnlClientInstallationInfo.Visible := True;

      ChkBxInstallSQLSERVER.Checked     := False;
      ChkBxInstallSQLSERVER.Visible     := False;

    End;

    pgWizard.ActivePage := TbsInstallationComponents;


  End Else If ( pgWizard.ActivePage = TbsInstallationComponents ) Then Begin

    {--------------------------------------------------------------------------}
    { Server IP address configuration                                          }
    If ( PnlClientInstallationInfo.Visible = True ) Then Begin

      If ( Trim( EdtServerIPAddress.Text ) = '' ) Then Begin

        MessageDlg( 'Please inform server IP address', mtWarning, [mbOK], 0 );
        Exit;

      End;

      FServerIPAdress := EdtServerIPAddress.Text;

    End Else Begin

      FServerIPAdress := '127.0.0.1';

    End;

    If ( FInstacaoFile <> Nil ) Then Begin

      FInstacaoFile.WriteString( 'Configurations', 'SERVERIPADDRESS', FServerIPAdress  );

    End;

    {--------------------------------------------------------------------------}

    btnPrior.Enabled  := False;
    btnNext.Enabled   := False;
    btnClose.Enabled  := False;

    If ( InstallationType <> itRepair ) Then SaveSettings();

    InstallMainRetail();
    If ( bExitProcess = True ) Then Exit;

    pgWizard.ActivePage := TbsDone;

    btnNext.Enabled  := ( pgWizard.ActivePage <> TbsDone );

  End Else If ( pgWizard.ActivePage = TbsDone ) Then Begin

    btnNext.Visible  := ( pgWizard.ActivePage <> TbsDone );

  End;

  btnPrior.Enabled := ( pgWizard.ActivePageIndex > 0 );

  OnAfterMovNext;

end;

procedure TFrmMain.MovPrior;
var
  i, iPage : Integer;
begin

  If ( pgWizard.ActivePage = TbsInstallationType ) Then Begin

    pgWizard.ActivePage := TbsOptions;
    btnNext.Enabled     := False;

  End Else If ( pgWizard.ActivePage = TbsInstallationComponents ) Then Begin

    pgWizard.ActivePage := TbsInstallationType;

    btnNext.Enabled  := ( pgWizard.ActivePage <> TbsDone );

  End Else If ( pgWizard.ActivePage = TbsDone ) Then Begin

    pgWizard.ActivePage := TbsInstallationComponents;

    btnNext.Enabled  := ( pgWizard.ActivePage <> TbsDone );

  End;

  btnPrior.Enabled := ( pgWizard.ActivePageIndex > 0 );

end;

Procedure TFrmMain.OnAfterMovNext;
Begin

  If ( pgWizard.ActivePage = TbsInstallationType ) Then Begin

  End Else If ( pgWizard.ActivePage = TbsDone ) Then Begin

  End;

  SaveFileInfo;

End;


Procedure TFrmMain.CreateUser;
Var
  bProcessItem : Boolean;
  sCommandText, sCommandParameters : String;

  RegistryCtrl : TRegistry;

Begin

  {============================================================================}
  { BOTH - CREATE PINOGY USER                                                  }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'PINOGY_USER', True );
  If ( ( bProcessItem = True ) ) Then Begin

    Try

      Screen.Cursor := crHourGlass;

      LblItemDescription.Caption  := 'Creating Pinogy user, please wait';

      ProgressBar.Visible := False;

      { Creating user account }
      sCommandText       := 'NET USER';
      sCommandParameters := 'Pinogy IHittgv! /ADD';

      WinExec( PChar( sCommandText + ' ' + sCommandParameters ), SW_HIDE );

      { Adding user account to administrator group  }
      sCommandText       := 'NET LOCALGROUP ';
      sCommandParameters := 'ADMINISTRATORS Pinogy /ADD';

      WinExec( PChar( sCommandText + ' ' + sCommandParameters ), SW_HIDE );

      { Hiding user account }
      { Alex 12/08/2011 - User will not be hidden from now on
      RegistryCtrl := TRegistry.Create( KEY_WRITE OR $0100 );

      RegistryCtrl.RootKey := HKEY_LOCAL_MACHINE;
      RegistryCtrl.OpenKey('Software\Microsoft\Windows NT\CurrentVersion\Winlogon', True);

      If ( Not RegistryCtrl.KeyExists( 'SpecialAccounts' ) ) Then ( RegistryCtrl.CreateKey( 'SpecialAccounts' ) );
      RegistryCtrl.OpenKey('SpecialAccounts', True);

      If ( Not RegistryCtrl.KeyExists( 'UserList' ) ) Then ( RegistryCtrl.CreateKey( 'UserList' ) );
      RegistryCtrl.OpenKey('UserList', True);

      If ( Not RegistryCtrl.ValueExists( 'Pinogy' ) ) Then RegistryCtrl.WriteInteger( 'Pinogy', 0);

      RegistryCtrl.CloseKey;
      RegistryCtrl.Free;
      }

      { Process Ok }
      FInstacaoFile.WriteBool( 'Configurations', 'PINOGY_USER', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'PINOGY_USER', True );

        MessageDlg( 'Problems while configuring the internal Pinogy user;' + #13 + #13 +
                    E.Message, mtWarning, [mbOK], 0 );

        // Raise Exception.Create( E.Message );

      End;

    End;

    Screen.Cursor := crDefault;

  End; { CREATE PINOGY USER }

End;

Procedure TFrmMain.InstallMainRetail;
Var
 bExecutigFromStartUp : Boolean;
Begin

  PnlReleaseVersion.Visible := False;

  If Not DirectoryExists( MR_INSTALL )       Then ForceDirectories( MR_INSTALL );
  If Not DirectoryExists( MR_INSTALL_FILES ) Then ForceDirectories( MR_INSTALL_FILES );

  bExecutigFromStartUp := False;

  With TRegistry.Create( KEY_READ OR $0100 ) Do Begin

    RootKey := HKEY_LOCAL_MACHINE;

    OpenKey( REG_PATH, False );

    If ( ValueExists( 'MainRetail_Wizard' ) ) Then Begin

      Self.Show();
      Self.Refresh();

      pgWizard.ActivePage     := TbsInstallationComponents;
      FServerIPAdress         := FInstacaoFile.ReadString( 'Configurations', 'SERVERIPADDRESS', FServerIPAdress  );
      EdtServerIPAddress.Text := FServerIPAdress;

      Application.ProcessMessages();

      bExecutigFromStartUp := True;

    End;

    Free;

  End;

  bExitProcess := False;

  MemoInfo.Lines.Clear();

  If ( FMainRetailVersion = -1 ) Then Begin

    CheckCurrentVersionInfo( FMainRetailVersion, FMainRetailDBVersion );

  End;

  If ( bExitProcess = False ) Then CreateUser();

  If ( bExitProcess = False ) Then CloseMainRetailApplications();
  
  If ( bExitProcess = False )
  Then If ( bExecutigFromStartUp = False ) Then ProcessDownloads();

  If ( bExitProcess = False ) Then ProcessInstallation( bExecutigFromStartUp ) Else Exit;
  If ( bExitProcess = False ) Then ProcessOtherConfigurations() Else Exit;

  FInstacaoFile.WriteString( 'Setup', 'INSTALLATION_DONE', 'Y' );

  With TRegistry.Create( KEY_READ OR KEY_WRITE OR $0100 ) Do Begin

    RootKey := HKEY_LOCAL_MACHINE;

    OpenKey( REG_PATH, False );

    DeleteValue( 'MainRetail_Wizard' );

    Free;

  End;

  Screen.Cursor := crDefault;

  MemoInfo.Lines.Add( ' ' );
  MemoInfo.Lines.Add( ' - Process finished ' );

  btnPrior.Enabled  := True;
  btnNext.Enabled   := True;
  btnClose.Enabled  := True;

  Application.ProcessMessages();


End;

Procedure TFrmMain.ProcessDownloads;
Var
  bRunNewVersion, bServerInstalation, bProcessItem : Boolean;

  sCommandText : String;

Begin

  PnlProcessEvolution.Visible := True;
  LblStepDescription.Caption  := 'Downloading files...';

  bServerInstalation := ( FInstacaoFile.ReadString( 'Setup', 'Type', '' ) = 'Server' );

  {============================================================================}
  { SERVER - SQLSERVEREXPRESS8.EXE                                             }

  If ( bServerInstalation = True ) Then Begin

    LblItemDescription.Caption  := 'Downloading .NET Framework, please wait';
    DownloadItem( 'DOTNETFRAMEWORK.EXE' );

    { Dependencies only needed on Windows XP }
    If ( ( WinVersion() = 'WindowsXP' ) And ( InstallationType <> itUpdate ) ) Then Begin

      LblItemDescription.Caption  := 'Downloading Windows Installer 4.5, please wait';
      DownloadItem( 'WINDOWSXP-KB942288-V3-X86.EXE' );

      LblItemDescription.Caption  := 'Downloading Windows PowerShell, please wait';
      DownloadItem( 'WINDOWSXP-KB968930-X86-ENG.EXE' );

    End;

    LblItemDescription.Caption  := 'Downloading MainRetail Database';
    DownloadItem( 'MAINRETAILDB.ZIP' );

    LblItemDescription.Caption  := 'Downloading Pet Industry Database';
    DownloadItem( 'MRCATALOGDB.ZIP' );

    LblItemDescription.Caption  := 'Downloading MainRetail Schema File';
    DownloadItem( 'MAINRETAILDB_SCHEMA.ZIP' );

    LblItemDescription.Caption  := 'Downloading MainRetail Deploy File';
    DownloadItem( 'DEPLOY.ZIP' );


    If ( WinVersion() = 'Windows7' )  Then Begin

      LblItemDescription.Update();
      Application.ProcessMessages();

      LblItemDescription.Caption  := 'Downloading SQL CE 3.5 SP2 (32 Bit)';
      DownloadItem( 'SSCERUNTIME32.ZIP' );

      If ( IsWOW64() ) Then Begin

        LblItemDescription.Caption  := 'Downloading SQL CE 3.5 SP2 (64 Bit)';
        DownloadItem( 'SSCERUNTIME64.ZIP' );

      End;

    End;

    LblItemDescription.Caption  := 'Downloading SQL Server 2008 R2 Express Edition';
    DownloadItem( 'SQLSERVEREXPRESS8.EXE' );

  End;

  {============================================================================}
  { BOTH - MR Apps                                                             }

  Try

    LblItemDescription.Update();

    LblItemDescription.Caption  := 'Downloading MainRetail';
    DownloadItem( 'MAINRETAIL.ZIP' );

    LblItemDescription.Caption  := 'Downloading Customer Files';
    DownloadItem( 'RECEIPTS.ZIP' );
    DownloadItem( 'LABELS.ZIP' );

    LblItemDescription.Caption  := 'Downloading MRReport';
    DownloadItem( 'MRREPORTINSTALL.EXE' );
    DownloadItem( 'REPORTS.ZIP' );

    LblItemDescription.Update();

    LblItemDescription.Caption  := 'Downloading MRPoleDisplay';
    DownloadItem( 'MRPOLEDISPLAY.ZIP' );

    LblItemDescription.Caption  := 'Downloading DSIClient';
    DownloadItem( 'DSICLIENTINSTALL.EXE' );

    LblItemDescription.Caption  := 'Downloading TSP100';
    DownloadItem( 'TSP100_INSTALL.EXE' );

    LblItemDescription.Caption  := 'Downloading MAGSWIPE_CFG';
    DownloadItem( 'MAGSWIPE_CFG.ZIP' );

    LblItemDescription.Update();

    LblItemDescription.Caption  := 'Downloading DLL';
    DownloadItem( 'MAINRETAIL_DLL.ZIP' );

    LblItemDescription.Caption  := 'Downloading Pet Industry Database';
    DownloadItem( 'PIDB_CATALOG.ZIP' );

    LblItemDescription.Update();

    LblItemDescription.Caption  := 'Downloading IP Dial Bridge';
    DownloadItem( 'IPDIALBRIDGEINSTALL.EXE' );

    LblItemDescription.Caption  := 'Downloading U209';
    DownloadItem( 'U209-000-R.ZIP' );

  Except

  End;

  PnlProcessEvolution.Visible := False;

End; { TFrmMain.ProcessDownloads; }

Procedure TFrmMain.ProcessInstallation( pbExecutigFromStartUp : Boolean );
Var
  bServerInstalation, bProcessItem, bProcessItem2, bEmptyFolder: Boolean;
  sCommandText, sCommandParameters : String;
Begin

  PnlProcessEvolution.Visible := True;
  LblStepDescription.Caption  := 'Installing files...';

  bServerInstalation := ( FInstacaoFile.ReadString( 'Setup', 'Type', '' ) = 'Server' );

  {============================================================================}
  { BOTH - APPs                                                                }

  bProcessItem :=  ProcessItem( 'DSICLIENTINSTALL.EXE', ptInstall );
  If ( bProcessItem = True )  Then Begin

    With TRegistry.Create( KEY_READ OR KEY_WRITE OR $0100 ) Do Begin

      RootKey := HKEY_LOCAL_MACHINE;

      OpenKey( REG_PATH, False );

      WriteString( 'MainRetail_Wizard', UpperCase( Application.ExeName ) );

      LblItemDescription.Caption  := 'Installing DSI Client, please wait';
      If ( InstallItem( 'DSICLIENTINSTALL.EXE' ) = False ) Then Sleep( 6000 );

      DeleteValue( 'MainRetail_Wizard' );

      Free;

    End;

  End;

  {============================================================================}
  { SERVER                                                                     }
  If ( bServerInstalation = True ) Then Begin

    {============================================================================}
    { SERVER - SQLSERVEREXPRESS8.EXE DEPENDENCIES                                }

    If ( pbExecutigFromStartUp = False ) Then Begin

      LblItemDescription.Caption  := 'Installing .NET Framework, please wait';
      InstallItem( 'DOTNETFRAMEWORK.EXE' );

    End;

    { Dependencies only needed on Windows XP }
    If ( ( WinVersion() = 'WindowsXP' ) And ( InstallationType <> itUpdate ) ) Then Begin

      bProcessItem  := False;
      bProcessItem2 := False;
      If ( pbExecutigFromStartUp = False ) Then Begin

        LblItemDescription.Caption  := 'Installing Windows Installer 4.5, please wait';
        bProcessItem  := InstallItem( 'WINDOWSXP-KB942288-V3-X86.EXE' );

        LblItemDescription.Caption  := 'Installing Windows PowerShell, please wait';
        bProcessItem2 := InstallItem( 'WINDOWSXP-KB968930-X86-ENG.EXE' );

      End;

      If ( ( bProcessItem = True ) Or ( bProcessItem2 = True ) ) Then Begin

        LblItemDescription.Caption  := 'Restarting computer, please wait';

        With TRegistry.Create( KEY_READ OR KEY_WRITE OR $0100 ) Do Begin

          RootKey := HKEY_LOCAL_MACHINE;

          OpenKey( REG_PATH, False );

          If ( Not ValueExists( 'MainRetail_Wizard' ) ) Then Begin

            WriteString( 'MainRetail_Wizard', UpperCase( Application.ExeName ) );

            Free;

            If ( ( ( FileExists(ExtractFileDir(Application.ExeName) + '\MainRetail_Wizard.dpr')  ) ) Or
                 ( Pos( 'TEST', UpperCase( ExtractFilePath( Application.ExeName )  ) ) > 0 ) )
            Then Begin

              MessageDlg( 'Application will be closed, Rerun the application to continue installation',
                          mtInformation, [mbOK], 0 );

              Application.Terminate();

            End Else Begin

              MessageDlg( 'System will reboot to continue installation',
                          mtInformation, [mbOK], 0 );

              Machine_Restart();

            End;

            bExitProcess := True;

            Sleep( 6000 );
            Exit;

          End Else Begin

            DeleteValue( 'MainRetail_Wizard' );

          End;

          Free;

        End;

      End;

    End;

    {============================================================================}
    { SERVER - SQLSERVEREXPRESS8.EXE                                             }
    bProcessItem := ProcessItem ( 'SQLSERVEREXPRESS8.EXE', ptInstall );
    If ( bProcessItem = True )  Then Begin

      Try

        Screen.Cursor := crHourGlass;

        LblItemDescription.Caption  := 'Installing SQL Server 2008 R2 Express Edition, please wait';

        ProgressBar.Visible := False;

        sCommandText        := MR_INSTALL_FILES + '\DOWNLOAD\SQLSERVEREXPRESS8.EXE ';
        sCommandParameters  :=  '/ACTION=Install '+
                                '/ERRORREPORTING=0 '+
                                '/IACCEPTSQLSERVERLICENSETERMS ' +
                                '/Q ' +
                                '/INDICATEPROGRESS ' +
                                '/FEATURES=SQL,TOOLS ' +
                                '/INSTANCENAME="Pinogy" ' +
                                '/SQLSYSADMINACCOUNTS="BUILTIN\Administrators" '+
                                '/TCPENABLED=1 ' +
                                '/NPENABLED=1 ' +
                                '/SQLSVCSTARTUPTYPE=Automatic '+
                                '/SQLSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" ' +
                                '/AGTSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" '+
                                '/BROWSERSVCSTARTUPTYPE=Automatic ' +
                                '/SECURITYMODE=SQL ' +
                                '/SAPWD=MR_DB_User ';

        {
          C:\Program Files\MainRetail\Installation Files\DOWNLOAD\SQLSERVEREXPRESS8.EXE /ACTION=Install /ERRORREPORTING=0 /IACCEPTSQLSERVERLICENSETERMS /INDICATEPROGRESS /FEATURES=SQL,TOOLS /INSTANCENAME="Pinogy" /SQLSYSADMINACCOUNTS="BUILTIN\Administrators" /TCPENABLED=1 /NPENABLED=1 /SQLSVCSTARTUPTYPE=Automatic /SQLSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" /AGTSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" /BROWSERSVCSTARTUPTYPE=Automatic /SECURITYMODE=SQL /SAPWD=MR_DB_User
        }

        RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters );

        Application.ProcessMessages();

        LblItemDescription.Caption  := 'Creating ODBC connection, please wait';

        sCommandText        := 'ODBCCONF.EXE';
        sCommandParameters  := '/A {CONFIGSYSDSN "SQL Server" "DSN=minidb|Description=MiniDB DNS|'+
                               'SERVER=(LOCAL)\PINOGY|Trusted_Connection=Yes|Database=MRCatalogDB"}';

        RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters );

        FInstacaoFile.WriteBool( 'Installation', 'SQLSERVEREXPRESS8.EXE', False );

      Except

        On E:Exception Do Begin

          Screen.Cursor := crDefault;
          FInstacaoFile.WriteBool( 'Installation', 'SQLSERVEREXPRESS8.EXE', True );

          Raise Exception.Create( E.Message );

        End;

      End;

    End; { SQLSERVEREXPRESS8.EXE }

    {============================================================================}
    { SERVER - MAINRETAILDB.ZIP                                                  }
    bProcessItem :=  ProcessItem( 'MAINRETAILDB.ZIP', ptInstall );
    If ( bProcessItem = True )  Then Begin

      LblItemDescription.Caption  := 'Installing MainRetail Database, please wait';
      UnZipItem( 'MAINRETAILDB.ZIP' );

      FInstacaoFile.WriteBool( 'Installation', 'MAINRETAILDB.ZIP', False );

    End;

    bProcessItem :=  ProcessItem( 'DEPLOY.ZIP', ptInstall );
    If ( bProcessItem = True )  Then Begin

      LblItemDescription.Caption  := 'Installing MainRetail Deploy File, please wait';
      UnZipItem( 'DEPLOY.ZIP', True );

      FInstacaoFile.WriteBool( 'Installation', 'DEPLOY.ZIP', False );

    End;

    bProcessItem :=  ProcessItem( 'MAINRETAILDB_SCHEMA.ZIP', ptInstall );
    If ( bProcessItem = True )  Then Begin

      LblItemDescription.Caption  := 'Installing MainRetail Schema File, please wait';
      UnZipItem( 'MAINRETAILDB_SCHEMA.ZIP' );

      FInstacaoFile.WriteBool( 'Installation', 'MAINRETAILDB_SCHEMA.ZIP', False );

    End;

    If ( WinVersion() = 'Windows7' ) Then Begin

      bProcessItem :=  ProcessItem( 'SSCERUNTIME32.ZIP', ptInstall );
      If ( bProcessItem = True )  Then Begin

        LblItemDescription.Caption  := 'Installing SQL CE 3.5 SP2 (32 Bit), please wait';
        UnZipItem( 'SSCERUNTIME32.ZIP' );
        InstallItem( 'SSCERUNTIME32.MSI' );

        FInstacaoFile.WriteBool( 'Installation', 'SSCERUNTIME32.ZIP', False );

      End;

      If ( IsWOW64() ) Then Begin

        bProcessItem :=  ProcessItem( 'SSCERUNTIME64.ZIP', ptInstall );

        If ( bProcessItem = True )  Then Begin

          LblItemDescription.Caption  := 'Installing SQL CE 3.5 SP2 (64 Bit), please wait';
          UnZipItem( 'SSCERUNTIME64.ZIP' );
          InstallItem( 'SSCERUNTIME64.MSI' );

          FInstacaoFile.WriteBool( 'Installation', 'SSCERUNTIME64.ZIP', False );

        End;

      End;


    End;

    Screen.Cursor := crDefault;


  End; { Server }

  Screen.Cursor := crHourGlass;

  {============================================================================}
  { BOTH - APPs                                                                }

  LblItemDescription.Caption  := 'Installing MRReport, please wait';
  InstallItem( 'MRREPORTINSTALL.EXE' );

  LblItemDescription.Caption  := 'Installing IP Dial Bridge, please wait';
  InstallItem( 'IPDIALBRIDGEINSTALL.EXE' );

  LblItemDescription.Caption  := 'Installing TSP100, please wait';
  InstallItem( 'TSP100_INSTALL.EXE' );

  LblItemDescription.Caption  := 'Installing MagSwipe configuration, please wait';
  UnZipItem( 'MAGSWIPE_CFG.ZIP' );
  InstallItem( 'MAGSWIPE_CFG.ZIP' );

  {============================================================================}
  { BOTH - ZIPs                                                                }

  Application.ProcessMessages();

  LblItemDescription.Caption  := 'Installing MainRetail, please wait';
  UnZipItem( 'MAINRETAIL.ZIP' );

  LblItemDescription.Caption  := 'Saving customer files, please wait';
  UpdateCustomerFiles();

  LblItemDescription.Caption  := 'Installing MainRetail Wizard, please wait';
  UnZipItem( 'MAINRETAIL_WIZARD.ZIP' );

  LblItemDescription.Caption  := 'Installing U209, please wait';
  UnZipItem( 'U209-000-R.ZIP' );
  If ( ProcessItem( 'U209-000-R.ZIP', ptInstall ) ) Then Begin
    MemoInfo.Lines.Add( ' - Please install the U209  driver now from folder C:\Temp\U209 ' );
    MemoInfo.Lines.Add( '   Please note that the dongle needs to be plugged in for this to work.' );
  End;

  LblItemDescription.Caption  := 'Installing Pet Industry Database, please wait';
  UnZipItem( 'PIDB_CATALOG.ZIP' );
  UnZipItem( 'MRCATALOGDB.ZIP' );

  //ProgressBarExterno.Visible  := False;
  PnlProcessEvolution.Visible := False;

End; { TFrmMain.ProcessInstallation; }

Procedure TFrmMain.ProcessOtherConfigurations;
Var
  bServerInstalation, bProcessItem : Boolean;

  sErrorMessage,
  sCommandText, sCommandParameters : String;

  MemoIni : TMemo;

  RegistryCtrl : TRegistry;

Begin

  PnlProcessEvolution.Visible := True;
  LblStepDescription.Caption  := 'Processing other configurations...';

  bServerInstalation := ( FInstacaoFile.ReadString( 'Setup', 'Type', '' ) = 'Server' );

  Application.ProcessMessages();

  {============================================================================}
  { BOTH - REGISTER DLLs                                                       }

  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'DLLINSTALL', True );
  If ( bProcessItem = True ) Then Begin

    Try

      LblItemDescription.Caption := 'Installing DLLs, please wait';

      Application.ProcessMessages();

      RegisterDLLs;

      Screen.Cursor := crDefault;

      FInstacaoFile.WriteBool( 'Configurations', 'DLLINSTALL', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'DLLINSTALL', True );

        MessageDlg( 'Problems registering DLLs:' + #13 + #13 +
                    E.Message, mtWarning, [mbOK], 0 );

      End;

    End;

  End;

  {============================================================================}
  { BOTH - ADDING FIREWALL EXCEPTIONS                                          }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'FIREWALLEXCPTS', True );
  If ( InstallationType = itRepair ) Then bProcessItem := True;

  If ( bProcessItem = True ) Then Begin

    Try

      Screen.Cursor := crHourGlass;

      LblItemDescription.Caption  := 'Adding Firewall exception, please wait';

      Application.ProcessMessages();

      AddApplicationToFirewall( 'MainRetail',     MR_INSTALL+'\MainRetail.exe');
      AddApplicationToFirewall( 'Socket server',  MR_INSTALL+'\scktsrvr.exe');
      AddApplicationToFirewall( 'PoleDisplay',    MR_INSTALL+'\MRPoleDisplay\MRPoleDisplay.exe');
      AddApplicationToFirewall( 'PoleDisplaySvr', MR_INSTALL+'\MRPoleServer\MRPoleDisplaySvr.exe');


      If ( Not IsWOW64() )
      Then sCommandText := ReturnWindowsFolder() + '\Microsoft SQL Server\MSSQL10_50.PINOGY\MSSQL\Binn\sqlservr.exe'
      Else sCommandText := 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.PINOGY\MSSQL\Binn\sqlservr.exe';

      If ( FileExists( sCommandText ) ) Then Begin

        AddApplicationToFirewall( 'SQLServer', sCommandText );
        AddPortToFirewall( 'SQLServer Browser', 'UDP', 1434 );

      End;

      FInstacaoFile.WriteBool( 'Configurations', 'FIREWALLEXCPTS', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'FIREWALLEXCPTS', True );

        MessageDlg( 'Problems adding Firewall exception settings:' + #13 + #13 +
                    E.Message, mtWarning, [mbOK], 0 );

      End;

    End;

    Screen.Cursor := crDefault;

  End; { ADDING FIREWALL EXCEPTIONS }

  {============================================================================}
  { SERVER - CREATING SCHEDULE TASKS                                           }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'SCHEDULETASKS', True );
  If ( InstallationType = itRepair ) Then bProcessItem := True;

  If ( ( bServerInstalation = True ) And ( bProcessItem = True ) ) Then Begin

    AddScheduledTasks();

  End; { CREATING SCHEDULE TASKS }

  {============================================================================}
  { SERVER - RESTORING DATABASE                                                }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'DATABASERESTORE', True );
  If ( InstallationType = itRepair ) Then bProcessItem := True;

  If ( ( bServerInstalation = True ) And ( bProcessItem = True ) ) Then Begin

    Try

      Screen.Cursor := crHourGlass;

      LblItemDescription.Caption  := 'Configuring databases, please wait';
      Application.ProcessMessages();

      ConfigureDataBase( 'MainRetailDB', sErrorMessage );

      ConfigureDataBase( 'MRCatalogDB', sErrorMessage );

      If ( ChkBxRecalculateInventoryValues.Checked = True ) Then Begin

        LblItemDescription.Caption  := 'Recalculating MainRetail database values, please wait';
        Application.ProcessMessages();
        RecalculateDataBase( 'MainRetailDB' );

      End;

      FInstacaoFile.WriteBool( 'Configurations', 'DATABASERESTORE', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'DATABASERESTORE', True );

        MessageDlg( 'Problems during database restore:' + #13 + #13 +

                    sErrorMessage + #13 + #13 +

                    E.Message,

                    mtWarning, [mbOK], 0 );

      End;

    End;

    Screen.Cursor := crDefault;

  End; { RESTORING DATABASE }

  {============================================================================}
  { BOTH - CREATE SHORTCUTS                                                    }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'SHORTCUTS', True );
  If ( InstallationType = itRepair ) Then bProcessItem := True;

  If ( ( bProcessItem = True ) ) Then Begin

    Try

      Screen.Cursor := crHourGlass;

      LblItemDescription.Caption  := 'Creating shortcuts, please wait';

      Application.ProcessMessages();

      CriarAtalho( MR_INSTALL+'\MainRetail.exe',     '', MR_INSTALL, 'MainRetail',     MR_INSTALL );

      bProcessItem := ProcessItem( 'MRIMPORTEXPORTINSTALL', ptOtherConfiguration );
      If ( bProcessItem )
      Then CriarAtalho( MR_INSTALL+'\MRImportExport.exe', '', MR_INSTALL, 'MRImportExport', MR_INSTALL );

      bProcessItem := ProcessItem( 'MRREPORTINSTALL.EXE', ptOtherConfiguration );
      If ( bProcessItem )
      Then CriarAtalho( MR_INSTALL+'\MRReport.exe',       '', MR_INSTALL, 'MRReport',       MR_INSTALL );

      bProcessItem := ProcessItem( 'SWITCHDBINSTALL', ptOtherConfiguration );
      If ( bProcessItem )
      Then CriarAtalho( MR_INSTALL+'\SwitchDB.exe',       '', MR_INSTALL, 'SwitchDB',       MR_INSTALL );

      bProcessItem := ProcessItem( 'MRPOLEDISPLAYINSTALL', ptOtherConfiguration );
      If ( bProcessItem )
      Then CriarAtalho( MR_INSTALL+'\MRPoleDisplay.exe',  '', MR_INSTALL, 'MRPoleDisplay',  MR_INSTALL );

      If ( bServerInstalation = True ) Then Begin

        bProcessItem := ProcessItem( 'MRPOLEDISPLAYSVRINSTALL', ptOtherConfiguration );
        If ( bProcessItem )
        Then CriarAtalho( MR_INSTALL+'\MRPoleDisplaySvr.exe',    '', MR_INSTALL, 'MRPoleDisplaySvr',    MR_INSTALL );

        //CriarAtalho( MR_INSTALL+'\MRDailyMaintenance.exe',  '', MR_INSTALL, 'MRDailyMaintenance',  MR_INSTALL );
        //CriarAtalho( MR_INSTALL+'\MRBackup.exe',            '', MR_INSTALL, 'MRBackup',            MR_INSTALL );

      End;

      FInstacaoFile.WriteBool( 'Configurations', 'SHORTCUTS', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'SHORTCUTS', True );

        MessageDlg( 'Problems while creating Shortcuts;' + #13 + #13 +
                    E.Message, mtWarning, [mbOK], 0 );

      End;

    End;

    Screen.Cursor := crDefault;

  End; { CREATE SHORTCUTS }

  {============================================================================}
  { BOTH - CREATE REGISTRY CONFIGURATION                                       }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'CREATEREGCONFIG', True );
  If ( bProcessItem = True ) Then Begin

   Try

      Screen.Cursor := crHourGlass;

      LblItemDescription.Caption  := 'Creating Registry configuration, please wait';

      Application.ProcessMessages();

      With TRegistry.Create( KEY_WRITE OR $0100 ) Do Begin

        If ( WinVersion() = 'Windows7' )
        Then RootKey := HKEY_CURRENT_USER
        Else RootKey := HKEY_LOCAL_MACHINE;

        OpenKey('SOFTWARE\AppleNet', True);

        sCommandText := SV_SERVER     + FServerIPAdress + '\Pinogy;'+
                        SV_DATABASE   + 'MainRetailDB;' +
                        SV_USER       + 'sa;'   +
                        SV_PASSWORD   + 'MR_DB_User;' +
                        SV_WIN_LOGIN  + 'N;' +             //'LoginType (Windows/SQL)' +
                        SV_USE_NETLIB + 'N;';              //'Use Network Library=DBMSSOCN';

        WriteString( 'ServerInfo', EncodeServerInfo( sCommandText, 'Server', CIPHER_TEXT_STEALING, FMT_UU ) );

        Free;

      End;

      FInstacaoFile.WriteBool( 'Configurations', 'CREATEREGCONFIG', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'CREATEREGCONFIG', True );

        MessageDlg( 'Problems while creating Registry configurations;' + #13 + #13 +
                    E.Message, mtWarning, [mbOK], 0 );

      End;

    End;

    Screen.Cursor := crDefault;

  End; { CREATE REGISTRY CONFIGURATION }

  {============================================================================}
  { BOTH - CREATE INI FILES                                                    }
  bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'CREATEINIFILES', True );
  If ( bProcessItem = True ) Then Begin

   Try

      Screen.Cursor := crHourGlass;

      LblItemDescription.Caption  := 'Creating INI files, please wait';
      Application.ProcessMessages();

      CreateINIFiles();

      FInstacaoFile.WriteBool( 'Configurations', 'CREATEINIFILES', False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Configurations', 'CREATEINIFILES', True );

        MessageDlg( 'Problems while creating INI files;' + #13 + #13 +
                    E.Message, mtWarning, [mbOK], 0 );

      End;

    End;

    Screen.Cursor := crDefault;

  End; { CREATE INI FILES }

  sCommandText := ExtractFileDir( Application.ExeName ) + '\MainRetail_Wizard.ini';
  If ( ( Pos( UpperCase( MR_INSTALL ),  UpperCase( sCommandText ) ) <= 0 ) And FileExists( sCommandText ) ) then begin

   CopyFile( sCommandText, MR_INSTALL+'\MainRetail_Wizard.ini', True );

  End;

  PnlProcessEvolution.Visible := False;

  Screen.Cursor := crDefault;

End; { TFrmMain.ProcessOtherConfigurations; }

Function TFrmMain.RunAsAdminAndWaitForCompletion( psFileName : String; psParameters : String ): Boolean;
Var
  ShellInformation : TShellExecuteInfo;
  ExitCode: DWORD;

Begin

  If ( WinVersion() = 'WindowsXP' )  Then Begin

    Result := CreateWindowsProcessAsUser( psFileName + ' ' + psParameters,
                                          'Pinogy',
                                          'IHittgv!',
                                          False );
    Exit;

  End;

  ZeroMemory(@ShellInformation, SizeOf(ShellInformation));

  ShellInformation.cbSize := SizeOf(TShellExecuteInfo);
  ShellInformation.Wnd    := Handle;
  ShellInformation.fMask  := ( SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS );

  If ( Pos( '.MSI', psFileName ) > 0 )
  Then ShellInformation.lpVerb := PChar('OPEN')
  Else ShellInformation.lpVerb := PChar('RUNAS');

  ShellInformation.lpFile := PChar( psFileName );
  ShellInformation.nShow  := SW_HIDE;

  If ( psParameters <> '' ) Then ShellInformation.lpParameters := PChar( psParameters );

  If   ShellExecuteEx( @ShellInformation ) then begin

    Repeat

      Application.ProcessMessages;
      GetExitCodeProcess( ShellInformation.hProcess, ExitCode );

    Until ( (ExitCode <> STILL_ACTIVE) Or ( Application.Terminated ) );

  End;

  Result := ( ExitCode = 0 );

End;


Function TFrmMain.IsSQLSERVERInstalled: Boolean;
Var
   SQLServer, Database, DBFile, LogFile: Variant;
   IDColumn, NameColumn, Table: Variant;
Begin

  try
    SQLServer := CreateOleObject('SQLDMO.SQLServer');
  except
    MessageDlg( 'Please install Microsoft SQL server connectivity tools first.'#13#13'(Error occurred)',
                mtWarning, [mbOK], 0 );
  end;

  { Connect to the Microsoft SQL Server }

  SQLServer.LoginSecure := True;

End;

procedure TFrmMain.ListAvailableSQLServers(Names : TStrings);
var
  RSCon: ADORecordsetConstruction;
  Rowset: IRowset;
  SourcesRowset: ISourcesRowset;
  SourcesRecordset: _Recordset;
  SourcesName, SourcesType: TField;

    function PtCreateADOObject
             (const ClassID: TGUID): IUnknown;
    var
      Status: HResult;
      FPUControlWord: Word;
    begin
      asm
        FNSTCW FPUControlWord
      end;
      Status := CoCreateInstance(
                  CLASS_Recordset,
                  nil,
                  CLSCTX_INPROC_SERVER or
                  CLSCTX_LOCAL_SERVER,
                  IUnknown,
                  Result);
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
      OleCheck(Status);
    end;
begin
  SourcesRecordset :=
      PtCreateADOObject(CLASS_Recordset)
      as _Recordset;
  RSCon :=
      SourcesRecordset
      as ADORecordsetConstruction;
  SourcesRowset :=
      CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator'))
      as ISourcesRowset;
  OleCheck(SourcesRowset.GetSourcesRowset(
       nil,
       IRowset, 0,
       nil,
       IUnknown(Rowset)));
  RSCon.Rowset := RowSet;
  with TADODataSet.Create(nil) do
  try
    Recordset := SourcesRecordset;
    SourcesName := FieldByName('SOURCES_NAME');
    SourcesType := FieldByName('SOURCES_TYPE');
    Names.BeginUpdate;
    try
      while not EOF do
      begin
        if
           (SourcesType.AsInteger = DBSOURCETYPE_DATASOURCE)
           and (SourcesName.AsString <> '') then
          Names.Add(SourcesName.AsString);
        Next;
      end;
    finally
      Names.EndUpdate;
    end;
  finally
    Free;
  end;
end;



Function TFrmMain.DownloadItem( psItemName : String ) : Boolean;

  Function DefineItemLink( psItemName : String ) : String;
  Var
    sReleaseServer : String;
  Begin

    Case CbxReleaseType.ItemIndex Of

      -1..0 : sReleaseServer := '';
      1 : sReleaseServer := '_rc';
      2 : sReleaseServer := '_beta';

    End;

    If ( psItemName = 'SQLSERVEREXPRESS8.EXE' ) Then Begin

      { SP1 }
      If ( Not IsWOW64() )
      //Then Result := 'http://download.microsoft.com/download/C/B/E/CBEBDAE0-8A5F-4E9C-A06D-C243EC8020A8/SQLEXPR32_x86_ENU.exe'  {32 Bits}
      Then Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/SQLEXPRWT_x86_ENU.exe'  {32 Bits}
      Else Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/SQLEXPRWT_x64_ENU.exe'; {64 Bits}

    End Else If ( psItemName = 'MAGSWIPE_CFG.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/magswipe_cfg.zip';
    End Else If ( psItemName = 'MAINRETAIL.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MainRetail.zip';
    End Else If ( psItemName = 'RECEIPTS.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/Receipts.zip';
    End Else If ( psItemName = 'LABELS.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/Labels.zip';
    End Else If ( psItemName = 'MAINRETAILDB.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MainRetailDB.zip';
    End Else If ( psItemName = 'MAINRETAILDB_SCHEMA.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MainRetailDB_Schema.zip';
    End Else If ( psItemName = 'DEPLOY.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/Deploy.zip';
    End Else If ( psItemName = 'SSCERUNTIME32.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/SSCERuntime_x32.zip';
    End Else If ( psItemName = 'SSCERUNTIME64.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/SSCERuntime_x64.zip';
    End Else If ( psItemName = 'MAINRETAIL_WIZARD.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MainRetail_Wizard.zip';
    End Else If ( psItemName = 'PIDB_CATALOG.ZIP' )    Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/pidb_catalog.zip';
    End Else If ( psItemName = 'MRCATALOGDB.ZIP' )    Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MRCatalogDB.zip';
    End Else If ( psItemName = 'MRREPORTINSTALL.EXE' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/mrreportinstall.exe';
    End Else If ( psItemName = 'REPORTS.ZIP' )     Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/Reports.zip';
    End Else If ( psItemName = 'DSICLIENTINSTALL.EXE' )    Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/dsiclientinstall.exe';
    End Else If ( psItemName = 'IPDIALBRIDGEINSTALL.EXE' ) Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/ipdialbridgeinstall.exe';
    End Else If ( psItemName = 'U209-000-R.ZIP' )          Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/u209-000-r.zip';
    End Else If ( psItemName = 'MRPOLEDISPLAY.ZIP' ) Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MRPoleDisplay.zip';
    End Else If ( psItemName = 'TSP100_INSTALL.EXE' )      Then Begin

      If ( Not IsWOW64() )
      Then Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/tsp100_install.exe'
      Else Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/tsp100_install_x64.exe';

    End Else If ( psItemName = 'MAINRETAIL_DLL.ZIP' )      Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/mainretail_dll.zip';
    End Else If ( psItemName = 'DOTNETFRAMEWORK.EXE' )      Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/dotnetframework.exe';
      //Result := 'http://download.microsoft.com/download/0/6/1/061f001c-8752-4600-a198-53214c69b51f/dotnetfx35setup.exe';
    End Else If ( psItemName = 'WINDOWSXP-KB942288-V3-X86.EXE' )      Then Begin
      Result := 'http://download.microsoft.com/download/2/6/1/261fca42-22c0-4f91-9451-0e0f2e08356d/WindowsXP-KB942288-v3-x86.exe';
    End Else If ( psItemName = 'WINDOWSXP-KB968930-X86-ENG.EXE' )      Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/WindowsXP-KB968930-x86-ENG.exe';
    End Else If ( psItemName = 'MANIFEST.INI' )      Then Begin
      Result := 'http://www.pinogy.com/mainretail_downloads'+sReleaseServer+'/MANIFEST.ini';
    End;

  End;

Var
  bServerInstalation, bProcessItem : Boolean;

  sDownloadFolderName,
  sMSSQLDownLoadLink : String;


Begin

  sDownloadFolderName := MR_INSTALL_FILES + '\DOWNLOAD';

  If ( Not ForceDirectories( sDownloadFolderName ) ) Then Begin

    MessageDlg( 'Coud not create download folder' + #13 + sDownloadFolderName + #13 + 'Please check.',
                mtError, [mbOk], 0 );
    Exit;

  End;

  bProcessItem := ProcessItem( psItemName, ptDownload );

  Application.ProcessMessages();

  If ( bProcessItem = True ) Then Begin

    Try

      sMSSQLDownLoadLink := DefineItemLink( psItemName );

      DownloadFile.ServerType  := stHTTP;
      DownloadFile.Source      := sMSSQLDownLoadLink;
      DownloadFile.Destination := sDownloadFolderName + '\'+ psItemName;

      If ( FileExists( DownloadFile.Destination ) ) Then Begin

        DeleteFile( DownloadFile.Destination );
        Application.ProcessMessages();
        Sleep( 500 );

      End;

      //ShowMessage( 'DownLoading ' + DownloadFile.Source + #13+
      //             ' to ' + DownloadFile.Destination );

      { Set the callback progerssbar }
      DownloadFile.CallBackProgressBar := ProgressBar;

      ProgressBar.Visible := True;

      DownloadFile.Start();

      FInstacaoFile.WriteBool( 'Downloads', psItemName, False );

      ProgressBar.Visible := False;

      Application.ProcessMessages();

    Except

      On E:Exception Do Begin

        FInstacaoFile.WriteBool( 'Downloads', psItemName, True );

        Raise Exception.Create( E.Message );

      End;

    End;

  End;

End;

Function TFrmMain.InstallItem( psItemName : String ) : Boolean;

  Procedure DefineItemCommand( psItemName : String;
                               Var psItemCommand, psItemParameters  : String );
  Begin

    psItemCommand := MR_INSTALL_FILES + '\DOWNLOAD\'+psItemName;

    If ( psItemName = 'MAINRETAIL.ZIP' )                   Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'RECEIPTS.ZIP' )            Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'LABELS.ZIP' )              Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'MAINRETAIL_WIZARD.ZIP' )   Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'MRREPORTINSTALL.EXE' )     Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'REPORTS.ZIP' )             Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'DSICLIENTINSTALL.EXE' )    Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'IPDIALBRIDGEINSTALL.EXE' ) Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'U209-000-R.ZIP' )          Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'TSP100_INSTALL.EXE' )      Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'MAGSWIPE_CFG.ZIP' )        Then Begin
      psItemCommand    := MR_INSTALL_FILES + '\DOWNLOAD\MAGSWIPE_CFG\Setup.exe';
      psItemParameters := '';
    End Else If ( psItemName = 'MAINRETAIL_DLL.ZIP' )      Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'DOTNETFRAMEWORK.EXE' )     Then Begin
      psItemParameters := '/q /norestart';
    End Else If ( psItemName = 'WINDOWSXP-KB942288-V3-X86.EXE' )         Then Begin
      psItemParameters := '/quiet /norestart';
    End Else If ( psItemName = 'WINDOWSXP-KB968930-X86-ENG.EXE' )        Then Begin
      psItemParameters := '/quiet /norestart';
    End Else If ( psItemName = 'SSCERUNTIME32.MSI' )        Then Begin
      psItemParameters := '';
    End Else If ( psItemName = 'SSCERUNTIME64.MSI' )        Then Begin
      psItemParameters := '';
    End;

  End;

Var
  bProcessItem : Boolean;
  sCommandText, sCommandParameters : String;

Begin

  Result       := False;
  bProcessItem := ProcessItem( psItemName, ptInstall );

  If ( bProcessItem = True ) Then Begin

    Try

      Screen.Cursor := crHourGlass;

      ProgressBar.Visible := False;

      DefineItemCommand( psItemName, sCommandText, sCommandParameters  );

      Result := RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters );

      FInstacaoFile.WriteBool( 'Installation', psItemName, False );

    Except

      On E:Exception Do Begin

        Screen.Cursor := crDefault;
        FInstacaoFile.WriteBool( 'Installation', psItemName, True );

        Raise Exception.Create( E.Message );

      End;

    End;

    Screen.Cursor := crDefault;

  End;

End;

Function TFrmMain.UnZipItem( psItemName : String; pbEmptyFolder : Boolean = False ) : Boolean;

  Function DefineItemFolder( psItemName : String ) : String;
  Var
    bRunNewVersion : Boolean;
  Begin

    If ( psItemName = 'MAINRETAIL.ZIP' )                      Then Begin
      Result := MR_INSTALL;
    End Else If ( psItemName = 'MAINRETAILDB.ZIP' )           Then Begin
      Result := MR_INSTALL_FILES + '\DOWNLOAD';
    End Else If ( psItemName = 'RECEIPTS.ZIP' )               Then Begin
      Result := 'C:\MainRetail\RECEIPTS';
    End Else If ( psItemName = 'LABELS.ZIP' )                 Then Begin
      Result := 'C:\MainRetail\LABELS';
    End Else If ( psItemName = 'REPORTS.ZIP' )                Then Begin
      Result := 'C:\MainRetail\REPORTS';
    End Else If ( psItemName = 'MRPOLEDISPLAY.ZIP' )          Then Begin
      Result := 'C:\MainRetail\MRPOLEDISPLAY';
    End Else If ( psItemName = 'MAINRETAILDB_SCHEMA.ZIP' )    Then Begin
      Result := 'C:\Temp\SCHEMA';
    End Else If ( psItemName = 'DEPLOY.ZIP' )                 Then Begin
      Result := 'C:\Temp\SCHEMA';
    End Else If ( psItemName = 'SSCERUNTIME32.ZIP' )            Then Begin
      Result := MR_INSTALL_FILES + '\DOWNLOAD';
    End Else If ( psItemName = 'SSCERUNTIME64.ZIP' )            Then Begin
      Result := MR_INSTALL_FILES + '\DOWNLOAD';
    End Else If ( psItemName = 'MAGSWIPE_CFG.ZIP' )           Then Begin
      Result := MR_INSTALL_FILES + '\DOWNLOAD\MAGSWIPE_CFG';
    End Else If ( psItemName = 'MAINRETAIL_WIZARD.ZIP' )      Then Begin

        bRunNewVersion := FInstacaoFile.ReadBool( 'Setup', 'RUNNEWVERSION', False );

        If ( bRunNewVersion = True )
        Then Result := MR_INSTALL_FILES + '\DOWNLOAD'
        Else Result := MR_INSTALL;

        If ( Pos( '\DOWNLOAD', ExtractFileDir( Application.ExeName ) ) > 0 )
        Then Result := MR_INSTALL;

    End Else If ( psItemName = 'PIDB_CATALOG.ZIP' )           Then Begin
      Result := 'C:\Pinogy';
    End Else If ( psItemName = 'MRCATALOGDB.ZIP' )            Then Begin
      Result := MR_INSTALL_FILES + '\DOWNLOAD';
    End Else If ( psItemName = 'U209-000-R.ZIP' )             Then Begin
      Result := 'C:\Temp\U209';
    End;

  End;

Var
  bServerInstalation, bProcessItem : Boolean;

  sFileName, sItemFolder : String;

Begin

  Result := True;

  bProcessItem := ProcessItem( psItemName, ptOtherConfiguration );

  If ( bProcessItem = True ) Then Begin

    Try

      sItemFolder := DefineItemFolder( psItemName );

      If ( Not ForceDirectories( sItemFolder ) ) Then Begin

        MessageDlg( 'Coud not create installation folder' + #13 + sItemFolder + #13 + 'Please check.',
                    mtError, [mbOk], 0 );
        Exit;

      End;

      //If ( pbEmptyFolder = True ) Then EmptyDirectories( sItemFolder+'\'+ StringReplace( psItemName, ExtractFileExt( psItemName ), '', [rfIgnoreCase] ), '*.*', True );
      If ( pbEmptyFolder = True ) Then EmptyDirectories( sItemFolder, '*.*', True );

      sFileName := MR_INSTALL_FILES + '\DOWNLOAD\'+psItemName;

      // If ( pbEmptyFolder = True ) Then ShowMessage( 'Unziping '+ sFileName +#13+ 'to '+sItemFolder );

      UnZipFile( sItemFolder, sFileName );

      ProgressBar.Visible := False;
      If ( psItemName <> 'MAGSWIPE_CFG.ZIP' ) Then FInstacaoFile.WriteBool( 'Installation', psItemName, False );

    Except

      On E:Exception Do Begin

        FInstacaoFile.WriteBool( 'Installation', psItemName, True );

       Result := False;
       Raise Exception.Create( E.Message );

      End;

    End;

  End;

End;


function TFrmMain.CreateWindowsProcessAndWait( Const csAppName, psCommandLine : String ) : Boolean;
Var
  StartUpInfo        : TStartUpInfo;
  ProcessInformation : TProcessInformation;
begin
  Result := False;

  ZeroMemory(@StartUpInfo, SizeOf( StartUpInfo ) );

  StartUpInfo.cb             := sizeof(STARTUPINFO);
  StartUpInfo.lpReserved     := nil;
  StartUpInfo.lpDesktop := nil;
  StartUpInfo.lpTitle        := nil;
  StartUpInfo.dwFlags        := STARTF_FORCEOFFFEEDBACK;
  StartUpInfo.cbReserved2    := 0;
  StartUpInfo.lpReserved2    := nil;

  If Not CreateProcess( Pchar( csAppName ),
                        Pchar( psCommandLine ),
                        Nil,
                        Nil,
                        True,
                        CREATE_NEW_CONSOLE,
                        Nil,
                        Nil,
                        StartUpInfo,
                        ProcessInformation )
  Then Exit;

  WaitForSingleObjectEx(ProcessInformation.hProcess, INFINITE, True);

  Result := True;

End;

Function TFrmMain.CreateWindowsProcessAsUser( psCommandLine  : String;
                                              psUsername     : String;
                                              psUserPassword : String;
                                              pbShowOnScreen : Boolean ) : Boolean;

Const
  LOGON_WITH_PROFILE        = 1;
  LOGON_NETCREDENTIALS_ONLY = 2;

Var

  wsUsername,
  wsDomain,
  wsPassword,
  wsCommandLine : WideString;

  pwsUsername,
  pwsDomain,
  pwsPassword,
  pwsCommandLine: PWideChar;

  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;
Begin

  Try

    wsUsername     := psUsername;
    wsDomain       := '';
    wsPassword     := psUserPassword;
    wsCommandLine  := psCommandLine;

    pwsUsername    := Addr( wsUsername[1] );
    pwsDomain      := Addr( wsDomain[1] );
    pwsPassword    := Addr( wsPassword[1] );
    pwsCommandLine := Addr( wsCommandLine[1] );

    FillChar( StartupInfo, SizeOf( TStartupInfo ), 0 );

    StartupInfo.cb      := SizeOf( TStartupInfo );
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

    If ( pbShowOnScreen = True )
    Then StartupInfo.wShowWindow := 1
    Else StartupInfo.wShowWindow := 0;

     If Not CreateProcessWithLogon( pwsUsername,
                                    pwsDomain,
                                    pwsPassword,
                                    LOGON_WITH_PROFILE,
                                    nil,
                                    pwsCommandLine,
                                    CREATE_DEFAULT_ERROR_MODE,
                                    nil,
                                    nil,
                                    StartupInfo,
                                    ProcessInfo )
    Then Begin

      Result := False;
      RaiseLastOSError;

    End Else Begin

      WaitforSingleObject( ProcessInfo.hProcess, INFINITE );

      CloseHandle( ProcessInfo.hThread );
      CloseHandle( ProcessInfo.hProcess );

      Result := True;

    End;

  Except

    Result := False;

  End;

End;


Function TFrmMain.ProcessItem(psItemName: String; pProcessType : TProcessType ) : Boolean;
Var
  iNewMainRetailVersion, iNewMainRetailDBVersion : Integer;
  sServerFileMD5Hash, sLocalFileMD5Hash, sItemNameToCompare : String;
  ChkBoxLocal : TCheckBox;
Begin

  Try

    If ( FManifest <> Nil ) Then Begin

      iNewMainRetailVersion   := FManifest.ReadInteger( 'Versions', 'MR', -1 );
      iNewMainRetailDBVersion := FManifest.ReadInteger( 'Versions', 'MRDB', -1 );

    End;

    sItemNameToCompare := psItemName;

    If ( psItemName = 'SQLSERVEREXPRESS8.EXE' ) Then Begin
      ChkBoxLocal := ChkBxInstallSQLSERVER;

      If ( Not IsWOW64() )
      Then sItemNameToCompare := 'SQLEXPRWT_x86_ENU.exe'
      Else sItemNameToCompare := 'SQLEXPRWT_x64_ENU.exe';


    End Else If ( psItemName = 'SSCERUNTIME32.ZIP' )   Then Begin
      ChkBoxLocal := ChkBxInstallSQLSERVER;
    End Else If ( psItemName = 'SSCERUNTIME64.ZIP' )   Then Begin
      ChkBoxLocal := ChkBxInstallSQLSERVER;
    End Else If ( psItemName = 'DOTNETFRAMEWORK.EXE' )     Then Begin
      ChkBoxLocal := ChkBxInstallDotnetFramework;
    End Else If ( psItemName = 'WINDOWSXP-KB942288-V3-X86.EXE' )     Then Begin
      ChkBoxLocal := ChkBxInstallWindowsInstaller;
    End Else If ( psItemName = 'WINDOWSXP-KB968930-X86-ENG.EXE' )     Then Begin
      ChkBoxLocal := ChkBxInstallWindowsPoweShell;
    End Else If ( psItemName = 'MRREPORTINSTALL.EXE' )     Then Begin
      ChkBoxLocal := ChkBxInstallMRReport;
    End Else If ( psItemName = 'REPORTS.ZIP' )             Then Begin
      ChkBoxLocal := ChkBxInstallMRReport;
    End Else If ( psItemName = 'DSICLIENTINSTALL.EXE' )    Then Begin
      ChkBoxLocal := ChkBxInstallDSIClient;
    End Else If ( psItemName = 'IPDIALBRIDGEINSTALL.EXE' ) Then Begin
      ChkBoxLocal := ChkBxInstallIPDialBridge;
    End Else If ( psItemName = 'U209-000-R.ZIP' )          Then Begin
      ChkBoxLocal := ChkBxInstallU209;
    End Else If ( psItemName = 'TSP100_INSTALL.EXE' )      Then Begin
      ChkBoxLocal := ChkBxInstallTSP100;

      If ( Not IsWOW64() )
      Then sItemNameToCompare := 'tsp100_install.exe'
      Else sItemNameToCompare := 'tsp100_install_x64.exe';

    End Else If ( psItemName = 'MAGSWIPE_CFG.ZIP' )        Then Begin
      ChkBoxLocal := ChkBxInstallMAGSWIPE_CFG;
    End Else If ( psItemName = 'PIDB_CATALOG.ZIP' )        Then Begin
      ChkBoxLocal := ChkBxInstallPID;
    End Else If ( psItemName = 'MRCATALOGDB.ZIP' )         Then Begin
      ChkBoxLocal := ChkBxInstallPID;
    End Else If ( psItemName = 'MRIMPORTEXPORTINSTALL' )   Then Begin
      ChkBoxLocal := ChkBxInstallMRImportExport;
    End Else If ( psItemName = 'SWITCHDBINSTALL' )         Then Begin
      ChkBoxLocal := ChkBxInstallSwitchDB;
    End Else If ( psItemName = 'MRPOLEDISPLAYINSTALL' )    Then Begin
      ChkBoxLocal := ChkBxInstallMRPoleDisplay;
    End Else If ( psItemName = 'MRPOLEDISPLAY.ZIP' )       Then Begin
      ChkBoxLocal := ChkBxInstallMRPoleDisplay;
    End Else If ( psItemName = 'MRPOLEDISPLAYSVRINSTALL' ) Then Begin
      ChkBoxLocal := ChkBxInstallMRPoleDisplaySvr;
    End Else If ( psItemName = 'MAINRETAIL_DLL.ZIP' )    Then Begin
      If ( FMainRetailVersion >= iNewMainRetailVersion )
      Then Result := False
      Else Result := True;
      Result := True;
      Exit;
    End Else If ( psItemName = 'MAINRETAIL.ZIP' )    Then Begin

      If ( FMainRetailVersion > iNewMainRetailVersion )
      Then Result := False
      Else Result := True;

      Exit;
    End Else If ( psItemName = 'RECEIPTS.ZIP' )      Then Begin

      If ( FMainRetailVersion > iNewMainRetailVersion )
      Then Result := False
      Else Result := True;

      Exit;
    End Else If ( psItemName = 'LABELS.ZIP' )        Then Begin
      If ( FMainRetailVersion > iNewMainRetailVersion )
      Then Result := False
      Else Result := True;

      Exit;
    End Else If ( psItemName = 'MAINRETAILDB.ZIP' )   Then Begin

      If ( FMainRetailDBVersion >= iNewMainRetailDBVersion )
      Then Result := False
      Else Result := True;

      If ( InstallationType = itRepair )
      Then If ( FMainRetailDBVersion > iNewMainRetailDBVersion )
           Then Result := False
           Else Result := True;

      Exit;
    End Else If ( psItemName = 'MAINRETAILDB_SCHEMA.ZIP' )   Then Begin

      If ( FMainRetailDBVersion >= iNewMainRetailDBVersion )
      Then Result := False
      Else Result := True;

      If ( InstallationType = itRepair )
      Then If ( FMainRetailDBVersion > iNewMainRetailDBVersion )
           Then Result := False
           Else Result := True;

      Exit;
    End Else If ( psItemName = 'DEPLOY.ZIP' )   Then Begin

      If ( FMainRetailDBVersion >= iNewMainRetailDBVersion )
      Then Result := False
      Else Result := True;

      If ( InstallationType = itRepair )
      Then If ( FMainRetailDBVersion > iNewMainRetailDBVersion )
           Then Result := False
           Else Result := True;

      Exit;
    End Else If ( psItemName = 'MAINRETAIL_WIZARD.ZIP' )   Then Begin
      Result := True;
      Exit;
    End Else If ( psItemName = 'MANIFEST.INI' )   Then Begin
      Result := True;
      Exit;
    End Else If ( psItemName = 'SSCERUNTIME32.MSI' )   Then Begin
      Result := True;
      Exit;
    End Else If ( psItemName = 'SSCERUNTIME64.MSI' )   Then Begin
      Result := True;
      Exit;
    End;

    Result := ChkBoxLocal.Checked;

  Finally

    If ( ( Result = True ) And ( InstallationType <> itRepair ) ) Then Begin

      If ( ( pProcessType = ptDownload ) ) Then Begin

        { Check for update }
        If ( ( psItemName <> 'MANIFEST.INI' ) And ( psItemName <> 'SQLSERVEREXPRESS8.EXE' ) And ( FileExists( MR_INSTALL_FILES + '\DOWNLOAD' + '\' + psItemName ) ) ) Then Begin

          sLocalFileMD5Hash  := FileMD5Hash( MR_INSTALL_FILES + '\DOWNLOAD' + '\' + psItemName );
          sServerFileMD5Hash := FManifest.ReadString( 'Files', sItemNameToCompare, 'XXX' );

          If ( UpperCase( sLocalFileMD5Hash ) = UpperCase( sServerFileMD5Hash ) ) Then Begin

            Result := False;
            FInstacaoFile.WriteBool( 'Installation', psItemName, False );

          End Else Begin

            Result := True;
            FInstacaoFile.WriteBool( 'Installation', psItemName, True );

            If ( ( psItemName = 'MRCATALOGDB.ZIP' ) Or ( psItemName = 'MAINRETAILDB.ZIP' ) Or ( psItemName = 'MAINRETAILDB_SCHEMA.ZIP' ) )
            Then FInstacaoFile.WriteBool( 'Configurations', 'DATABASERESTORE', True );

          End;

        End;

        If ( ( psItemName = 'SQLSERVEREXPRESS8.EXE' ) And ( FileExists( MR_INSTALL_FILES + '\DOWNLOAD' + '\' + psItemName ) ) )
        Then Result := FInstacaoFile.ReadBool( 'Downloads', psItemName, True );

      End Else If ( ( pProcessType = ptOtherConfiguration ) ) Then Begin

        Result := ( FInstacaoFile.ReadBool( 'Installation', psItemName, False ) );

      End Else Begin

        Result := FInstacaoFile.ReadBool( 'Installation', psItemName, True );

      End;

    End Else If ( ( Result = True ) And ( InstallationType = itRepair ) ) Then Begin

      If ( ( psItemName = 'MAINRETAILDB_SCHEMA.ZIP' ) Or ( psItemName = 'DEPLOY.ZIP' ) )
      Then FInstacaoFile.WriteBool( 'Configurations', 'DATABASERESTORE', True );

      FInstacaoFile.WriteBool( 'Installation', psItemName, True );

    End;

  End;

End;

Procedure TFrmMain.CloseApplication( psApplicationName : String );
Var
  h: HWND;
Begin
  h := FindWindow( Nil, PChar( psApplicationName ) );
  if h <> 0 then PostMessage(h, WM_QUIT, 0, 0);
End;

Procedure TFrmMain.CriarAtalho(ANomeArquivo,      AParametros,
                               ADiretorioInicial, ANomedoAtalho, APastaDoAtalho: String);
Var

  MeuObjeto: IUnknown;
  MeuSLink: IShellLink;
  MeuPFile: IPersistFile;
  Diretorio: string;
  wNomeArquivo: WideString;
  MeuRegistro: TRegistry;

  Pasta : array[0..MAX_PATH] of Char;

begin

  //Cria e instancia os objetos usados para criar o atalho
  MeuObjeto := CreateComObject(CLSID_ShellLink);

  MeuSLink  := MeuObjeto as IShellLink;
  MeuPFile  := MeuObjeto as IPersistFile;

  with MeuSLink do begin

    SetArguments(PChar(AParametros));
    SetPath(PChar(ANomeArquivo));

    SetWorkingDirectory(PChar(ADiretorioInicial));

  end;

  MeuRegistro  := TRegistry.Create( KEY_READ OR $0100 );

  MeuRegistro.RootKey := HKEY_LOCAL_MACHINE;
  MeuRegistro.OpenKey( 'SOFTWARE\MicroSoft\Windows\CurrentVersion\Explorer\Shell Folders', False );

  { Create folder at startup menu }
  SHGetSpecialFolderPath( 0, Pasta, CSIDL_COMMON_STARTMENU, False );
  ForceDirectories( Pasta + '\MainRetail' );

  { Create link at startup menu folder }
  Diretorio    := Pasta + '\MainRetail';
  wNomeArquivo := Diretorio + '\' + ANomedoAtalho + '.lnk';
  MeuPFile.Save(PWChar(wNomeArquivo), False);

  { Create link at startup menu folder }
  Diretorio    := MeuRegistro.ReadString( 'Common Desktop' );
  wNomeArquivo := Diretorio + '\' + ANomedoAtalho + '.lnk';
  MeuPFile.Save(PWChar(wNomeArquivo), False);
 
  MeuRegistro.Free;

End;


procedure TFrmMain.TrayHIDE( psApplicationname : String );
Var
   TopWindow : HWND;
Begin

   //TopWindow := FindWindow('Shell_TrayWnd', nil) ;
   //TopWindow := FindWindowEx(TopWindow,0, 'ReBarWindow32', nil) ;
   //TopWindow := FindWindowEx(TopWindow,0, 'SysPager', nil) ;

   //ShowWindow( FindWindowEx( FindWindowEx( FindWindow('Shell_TrayWnd', nil), 0, 'TrayNotifyWnd', nil), 0, 'TrayClockWClass', nil), SW_HIDE);

   TopWindow := FindWindow( 'Shell_TrayWnd', Nil );

   TopWindow := FindWindowEx( TopWindow, 0, 'TrayNotifyWnd', Nil) ;
   TopWindow := FindWindowEx( TopWindow, 0, PChar( psApplicationname ), Nil) ;

   ShowWindow( TopWindow, SW_HIDE ) ;

end;

Function TFrmMain.RecalculateDataBase( psItemName : String ) : Boolean;
Var
  ADOQuery : TADOQuery;
  sSQLQtyOrder, sSQLQtyHold  : String;
Begin

  If ( OpenConnection() ) Then Begin

    Try

    ADODBConnect.BeginTrans;
    DM.RunSQL('EXEC SP_UPDATESYSTEMQTY');
    ADODBConnect.CommitTrans;

    (*
      ADOQuery := TADOQuery.Create( Self );
      ADOQuery.Connection := Self.ADODBConnect;

      ADOQuery.SQL.Add( 'UPDATE PRE SET PRE.QTYREALMOV = PRE.QTY '+
                        'FROM PREINVENTORYMOV PRE JOIN PO ON PRE.DOCUMENTID = PO.IDPO AND PRE.INVENTMOVTYPEID = 2 '+
                        'WHERE PO.ABERTO = 0 AND PRE.QTYREALMOV <> PRE.QTY ' );
      ADOQuery.ExecSQL();

      If ( ( ChkBxRecalculateInventoryValues.Checked = True )  Or
           ( ChkBxRecalculateQtysOnHold.Checked  = True ) )
      Then Begin

        sSQLQtyOrder := '';
        sSQLQtyHold  := '';

        If ( ChkBxRecalculateQtysOnOrder.Checked = True ) Then sSQLQtyOrder := 'I.QTYONORDER = 0';
        If ( ChkBxRecalculateQtysOnHold.Checked  = True ) Then sSQLQtyHold  := 'I.QTYONPRESALE = 0 ';

        If ( ( sSQLQtyOrder <> '' ) And ( sSQLQtyHold <> '' ) ) Then sSQLQtyOrder := sSQLQtyOrder + ', ';

        ADOQuery.SQL.Clear();
        ADOQuery.SQL.Add( 'UPDATE I SET ' + sSQLQtyOrder + sSQLQtyHold + ' FROM INVENTORY I ' );
        ADOQuery.ExecSQL();

        sSQLQtyOrder := '';
        sSQLQtyHold  := '';

        If ( ChkBxRecalculateQtysOnOrder.Checked = True ) Then sSQLQtyOrder := ' I.QTYONORDER   = T.QTYONORDER  ';
        If ( ChkBxRecalculateQtysOnHold.Checked  = True ) Then sSQLQtyHold  := ' I.QTYONPRESALE = T.QTYONPRESALE ';

        If ( ( sSQLQtyOrder <> '' ) And ( sSQLQtyHold <> '' ) ) Then sSQLQtyOrder := sSQLQtyOrder + ', ';

        ADOQuery.SQL.Clear();
        ADOQuery.SQL.Add( 'UPDATE I SET ' + sSQLQtyOrder + sSQLQtyHold +
                          'FROM INVENTORY I JOIN ( '+
                          '  SELECT MODELID, STOREID, SUM(QTY-QTYREALMOV) AS QTYONORDER, SUM(QTY) AS QTYONPRESALE'+
                          '  FROM PREINVENTORYMOV PRE '+
                          '    JOIN PO ON PRE.DOCUMENTID = PO.IDPO AND PRE.INVENTMOVTYPEID = 2 '+
                          '  WHERE PO.ABERTO = 1 '+
                          '  GROUP BY MODELID, STOREID ) T ON I.MODELID = T.MODELID AND I.STOREID = T.STOREID ');

        ADOQuery.ExecSQL();

      End;

      *)

    Finally

      // FreeAndNil( ADOQuery );

      CloseConnection();

    End;


  End;

End;

Function TFrmMain.ConfigureDataBase( psItemName : String; Var psErrorMessage : String ) : Boolean;
Var
  bUpdateMainRetalVersion, bProcessItem : Boolean;
  sCommandText, sCommandParameters : String;
  sAppDir, sAppPath : String;
Begin

  { Try to login connection on the new Server }
  DM.Connection.Close;
  DM.Connection.ConnectionString := SetConnectionStr('sa', 'MR_DB_User', 'Master', '(LOCAL)\PINOGY');

  Try

     Result := True;

     psErrorMessage := 'SQL Server connection error.';

     DM.Connection.Open;

     Sleep(5000);

     { Verify if the DB exist }

     // test on papflaDB office 6
     DM.qryFreeSQL.Close;
     DM.qryFreeSQL.CommandText := 'SELECT Name FROM master..sysdatabases where name='+QuotedStr( psItemName )+' ';
     DM.qryFreeSQL.Open;

     If ( Not DM.qryFreeSQL.IsEmpty ) Then Begin

       If ( psItemName = 'MainRetailDB' ) Then Begin

         bUpdateMainRetalVersion := False;

         bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'DATABASERESTORE', True );
         If ( ( bProcessItem = True ) And ( DM.qryFreeSQL.Locate( 'Name', 'MainRetailDB', [loCaseInsensitive] ) ) ) Then Begin

           psErrorMessage := 'Error while runnung VSDBCMD command.';

           LblItemDescription.Caption  := 'Updating MainRetail Database schema, please wait';
           Application.ProcessMessages();

           sCommandText        := 'C:\TEMP\SCHEMA\VSDBCMD.EXE';
           sCommandParameters  := '/a:Deploy /cs:"Server=(local)\PINOGY;Integrated Security=true;Pooling=false;Initial Catalog=MainRetailDB;" '+
                                  '/dsp:Sql /dd+ /model:"C:\TEMP\SCHEMA\MainRetailDB_Schema.dbschema" /p:TargetDatabase="MainRetailDB"';

           bUpdateMainRetalVersion := RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters ) ;

           MemoInfo.Lines.Add( ' ' );

           If ( bUpdateMainRetalVersion = True )
           Then MemoInfo.Lines.Add( ' - ' + psItemName + ' schema updated.' )
           Else MemoInfo.Lines.Add( ' - Error updating ' + psItemName + ' schema.' );

         End;

         //bProcessItem := ( Not ProcessItem( 'MAINRETAIL.ZIP', ptInstall ) );
         bProcessItem := FInstacaoFile.ReadBool( 'Configurations', 'DATABASERESTORE', True );
         If ( ( bUpdateMainRetalVersion = True ) And ( bProcessItem = True ) ) Then Begin

           psErrorMessage := 'Error updating MainRetail Version.';
//           showMessage('before updateMainRetailVersion');
           bUpdateMainRetalVersion := UpdateMainRetalVersion();

           If ( bUpdateMainRetalVersion = True )
           Then MemoInfo.Lines.Add( ' - ' + psItemName + ' Version updated.' )
           Else MemoInfo.Lines.Add( ' - Error updating ' + psItemName + ' Version.' );

         End;

       End;

     End Else Begin
       { If not restores it }

       { Create SQL DATA folder }
       sAppDir  := ExtractFileDrive( Application.ExeName );

       If Not DirectoryExists(sAppDir+'\MSSQL_Data')
       Then If Not CreateDir(sAppDir+'\MSSQL_Data')
            Then Raise Exception.Create('Cannot create '+sAppDir+'\MSSQL_Data');

       //Prepare to Restore MainRetail DB
       Try

         LblItemDescription.Caption  := 'Restoring '+psItemName+' database, please wait';
         Application.ProcessMessages();

         If Not Assigned( DBOperation )
         Then DBOperation := TRestoreDataBase.Create;

         DBOperation.Connection                        := DM.Connection;
         DBOperation.DataBaseName                      := psItemName;
         DBOperation.Device                            := DEVICE_DISK + QuotedStr( MR_INSTALL_FILES + '\DOWNLOAD\'+psItemName+'.bak' );

         TRestoreDataBase(DBOperation).ForceRestore    := RST_REPLACE_DB;

         TRestoreDataBase(DBOperation).LogicalDataName := QuotedStr( psItemName+'_Data' );
         TRestoreDataBase(DBOperation).NewDataPath     := QuotedStr(sAppDir+'\MSSQL_Data\'+psItemName+'.mdf');

         TRestoreDataBase(DBOperation).LogicalLogName  := QuotedStr( psItemName+'_Log' );
         TRestoreDataBase(DBOperation).NewLogPath      := QuotedStr(sAppDir+'\MSSQL_Data\'+psItemName+'.ldf');

         Try

           psErrorMessage := 'Error while restoring MainRetail database.';

           bProcessItem := (DBOperation.SetSQLExecute = -1);

           If ( bProcessItem = True ) Then Begin

            MemoInfo.Lines.Add( ' ' );
            MemoInfo.Lines.Add( ' - '+ psItemName +' Database created.' );

            pgWizard.ActivePage := TbsDone;

           End;

         Except

           On E: Exception Do Begin

              MemoInfo.Lines.Add( ' ' );
              MemoInfo.Lines.Add( ' - An error occurs while creating database. Error : ' + E.Message );

           End;

         End;

       Finally

         FreeAndNil( DBOperation );

       End;

     End;

     psErrorMessage := '';

  Except

   On E: Exception do Begin

    MessageDlg( 'An error occurs during Database access, message: ' + #13 + #13 +
                E.Message + #13 + #13 +
                'Check to see if SQL Server was installed ',
                mtError, [mbOk], 0 );

   End;

  End;

End;


procedure TFrmMain.AddPortToFirewall(EntryName,ProtocolType:string;PortNumber:Cardinal);
var
  fwMgr,port:OleVariant;
  profile, policy :OleVariant;
begin

  fwMgr   := CreateOLEObject('HNetCfg.FwMgr');
  policy  := fwMgr.LocalPolicy;
  profile := Policy.GetProfileByType(1);

  port := CreateOLEObject('HNetCfg.FWOpenPort');
  port.Name := EntryName;

  If ( ProtocolType = 'UDP')
  Then port.Protocol := NET_FW_IP_PROTOCOL_UDP
  Else port.Protocol := NET_FW_IP_PROTOCOL_TCP;

  port.Port := PortNumber;
  port.Scope := NET_FW_SCOPE_LOCAL_SUBNET; //NET_FW_SCOPE_ALL;
  port.Enabled := true;
  profile.GloballyOpenPorts.Add(port);
end;

procedure TFrmMain.AddApplicationToFirewall(EntryName:string;ApplicationPathAndExe:string);
var
  fwMgr,app:OleVariant;
  profile, policy :OleVariant;
begin

  If ( Not FileExists(  ApplicationPathAndExe ) )
  Then Exit;

  fwMgr   := CreateOLEObject('HNetCfg.FwMgr');
  policy  := fwMgr.LocalPolicy;
  profile := Policy.GetProfileByType(1);

  app := CreateOLEObject('HNetCfg.FwAuthorizedApplication');
  app.ProcessImageFileName := ApplicationPathAndExe;

  app.Name      := EntryName;
  app.Scope     := NET_FW_SCOPE_ALL;
  app.IpVersion := NET_FW_IP_VERSION_ANY;
  app.Enabled   :=true;

  profile.AuthorizedApplications.Add(app);

end;

Function TFrmMain.ReturnWindowsFolder( piFolderId: Integer = -1 ): String;
Var
  P : Array[0..MAX_PATH] of char;
  ProgramFilesDir: string;
  iFolderId : Integer;
Begin

  iFolderId := CSIDL_PROGRAM_FILES;
  If ( piFolderId > 0 ) Then iFolderId := piFolderId;

  if SHGetFolderPath(0,   iFolderId, 0,0, @P[0]) = S_OK then
    ProgramFilesDir := P
  else
    ProgramFilesDir := 'C:\Program Files';

   Result := ProgramFilesDir;

End;

procedure TFrmMain.Machine_Restart;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
  NTSetPrivilege(SE_SHUTDOWN_NAME, True);
  ExitWindowsEx(EWX_REBOOT or EWX_FORCE, 0);
end;

Procedure TFrmMain.EmptyDirectories( Directory, FileMask: String; DelSubDirs: Boolean );
Var
  SourceLst: string;
  FOS: TSHFileOpStruct;
Begin

  FillChar(FOS, SizeOf(FOS), 0);

  FOS.Wnd   := Application.Handle;
  FOS.wFunc := FO_DELETE;
  SourceLst := Directory + '\' + FileMask + #0;
  FOS.pFrom := PChar(SourceLst);

  If Not DelSubDirs
  Then FOS.fFlags := FOS.fFlags OR FOF_FILESONLY;

  FOS.fFlags := FOS.fFlags OR FOF_NOCONFIRMATION;
  FOS.fFlags := FOS.fFlags OR FOF_SILENT;

  SHFileOperation( FOS );

  Application.ProcessMessages();

End;

function TFrmMain.NTSetPrivilege(sPrivilege: string; bEnabled: Boolean): Boolean;
var
  hToken: THandle;
  TokenPriv: TOKEN_PRIVILEGES;
  PrevTokenPriv: TOKEN_PRIVILEGES;
  ReturnLength: Cardinal;
begin
  Result := True;
  // Only for Windows NT/2000/XP and later.
  if not (Win32Platform = VER_PLATFORM_WIN32_NT) then Exit;
  Result := False;

  // obtain the processes token
  if OpenProcessToken(GetCurrentProcess(),
    TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
  begin
    try
      // Get the locally unique identifier (LUID) .
      if LookupPrivilegeValue(nil, PChar(sPrivilege),
        TokenPriv.Privileges[0].Luid) then
      begin
        TokenPriv.PrivilegeCount := 1; // one privilege to set

        case bEnabled of
          True: TokenPriv.Privileges[0].Attributes  := SE_PRIVILEGE_ENABLED;
          False: TokenPriv.Privileges[0].Attributes := 0;
        end;

        ReturnLength := 0; // replaces a var parameter
        PrevTokenPriv := TokenPriv;

        // enable or disable the privilege

        AdjustTokenPrivileges(hToken, False, TokenPriv, SizeOf(PrevTokenPriv),
          PrevTokenPriv, ReturnLength);
      end;
    finally
      CloseHandle(hToken);
    end;
  end;
  // test the return value of AdjustTokenPrivileges.
  Result := GetLastError = ERROR_SUCCESS;
  if not Result then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;


Function TFrmMain.WinVersion: string;
var
  VersionInfo: TOSVersionInfo;
begin

  Result := '';

  //Result := 'Windows7';
  //Exit;

  VersionInfo.dwOSVersionInfoSize:=SizeOf(VersionInfo);

  GetVersionEx(VersionInfo);

  //ShowMessage( ' VersionInfo.dwPlatformId   ' + IntToStr( VersionInfo.dwPlatformId ) +#13+
  //             ' VersionInfo.dwMinorVersion ' + IntToStr( VersionInfo.dwMinorVersion ) +#13+
  //             ' VersionInfo.dwMajorVersion ' + IntToStr( VersionInfo.dwMajorVersion ) );

  case VersionInfo.dwPlatformId of
    1:
      case VersionInfo.dwMinorVersion of
         0: Result:='Windows95';
        10: Result:='Windows98';
        90: Result:='WindowsMe';
      end;
    2:
      case VersionInfo.dwMajorVersion of
        3: Result:='WindowsNT3.51';
        4: Result:='WindowsNT4.0';
        5: case VersionInfo.dwMinorVersion of
            0: Result:='Windows2000';
            1: Result:='WindowsXP';
           end;
        6: case VersionInfo.dwMinorVersion of
            0: Result:='WindowsVista';
            1: Result:='Windows7';
           end;
      end;
  end;

  if (Result='') then
    Result:='Windows version not recognized. '+ #13 + #13 +
            'Plataform     = ' + IntToStr( VersionInfo.dwPlatformId )   +
            'Major Version = ' + IntToStr( VersionInfo.dwMajorVersion ) +
            'Minor Version = ' + IntToStr( VersionInfo.dwMinorVersion );

end;

Procedure TFrmMain.SaveSettings;
Var
  sFileInfo : String;
Begin

  FInstacaoFile.WriteBool( 'Settings', 'SQLSERVEREXPRESS8.EXE', ChkBxInstallSQLSERVER.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'MRREPORTINSTALL.EXE', ChkBxInstallMRReport.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'DSICLIENTINSTALL.EXE', ChkBxInstallDSIClient.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'IPDIALBRIDGEINSTALL.EXE', ChkBxInstallIPDialBridge.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'U209-000-R.ZIP', ChkBxInstallU209.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'TSP100_INSTALL.EXE', ChkBxInstallTSP100.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'MAGSWIPE_CFG.ZIP', ChkBxInstallMAGSWIPE_CFG.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'PIDB_CATALOG.ZIP', ChkBxInstallPID.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'MRIMPORTEXPORTINSTALL', ChkBxInstallMRImportExport.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'SWITCHDBINSTALL', ChkBxInstallSwitchDB.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'MRPOLEDISPLAYINSTALL', ChkBxInstallMRPoleDisplay.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'MRPOLEDISPLAYSVRINSTALL', ChkBxInstallMRPoleDisplaySvr.Checked );
  FInstacaoFile.WriteBool( 'Settings', 'BACKUPDATABASE', ChkBxBackupDatabase.Checked );

End;

Procedure TFrmMain.CreateINIFiles;
Var
  sBackupDatabase    : String;
  bServerInstalation : Boolean;
Begin


  bServerInstalation := ( FInstacaoFile.ReadString( 'Setup', 'Type', '' ) = 'Server' );


  With TStringList.Create() Do Begin

    Clear();

    Add( '[MainRetailDB]' );
    Add( 'DriverName=SQLOLEDB.1' );
    Add( 'BlobSize=-1' );

    If ( bServerInstalation = True )
    Then Add( 'HostName=(LOCAL)\Pinogy' )
    Else Add( 'HostName='+ FServerIPAdress+'\Pinogy' );

    Add( 'DataBase=MainRetailDB' );
    Add( 'User="-,\`' );
    Add( 'Password=*;L`!/-C0*DMO3@``' );
    Add( 'UseNetLib=0' );

    If ( Not FileExists( MR_INSTALL+'\MRAppServer.ini' ) )
    Then SaveToFile( MR_INSTALL+'\MRAppServer.ini' );

    Clear();

    Add( '[Connection]' );
    Add( 'Type=SOCKET' );
    Add( 'ClientID=MainRetailDB' );
    Add( 'Host=127.0.0.1' );
    Add( 'Port=211' );

    If ( Not FileExists( MR_INSTALL+'\MRImportExport.ini' ) )
    Then SaveToFile( MR_INSTALL+'\MRImportExport.ini' );

    Clear(); 

    Add( '[Connection]' );
    Add( 'Type=SOCKET' );
    Add( 'ClientID=MainRetailDB' );
    Add( 'Host=127.0.0.1' );
    Add( 'Port=211' );
    Add( '[Default]' );
    Add( 'ReportPath=C:\mainretail\reports\' );
    Add( 'LogoPath=' );
    Add( 'UpdateFile=' );
    Add( 'IDLanguage=0' );
    Add( '[Settings]' );
    Add( 'ImageDir=Image\' );
    Add( 'Printer=' );
    Add( 'PrinterList=' );

    If ( Not FileExists( MR_INSTALL+'\MRReport.ini' ) )
    Then SaveToFile( MR_INSTALL+'\MRReport.ini' );

    Clear();

    If ( ChkBxBackupDatabase.Checked =  False )
    Then sBackupDatabase := '0'
    Else sBackupDatabase := '1';

    Add( '[settings]' );
    Add( 'AutoBackup=1' );
    Add( 'BackupDatabase='+ sBackupDatabase );
    Add( 'BackupDir=C:\MainRetail\MRBackup' );
    Add( 'Database=MainRetailDB' );

    If ( Not FileExists( MR_INSTALL+'\MRBackup.ini' ) )
    Then SaveToFile( MR_INSTALL+'\MRBackup.ini' );
  End;

End;

Function TFrmMain.FileMD5Hash(psFileName: String): String;
Var
 idmd5 : TIdHashMessageDigest5;
 fs : TFileStream;
 hash : T4x4LongWordRecord;
Begin

 idmd5 := TIdHashMessageDigest5.Create;
 fs := TFileStream.Create(psFileName, fmOpenRead Or fmShareDenyWrite) ;

 Try
   result := idmd5.AsHex(idmd5.HashValue(fs)) ;
 Finally
   fs.Free;
   idmd5.Free;
 End;

End;

Procedure TFrmMain.SetCheckBoxes( pbUnSelectAll : Boolean );
Var
  sInstallationDone,
  sFileInfo : String;
Begin

  If ( pbUnSelectAll = True ) Then Begin

    ChkBxInstallSQLSERVER.Checked            := False;
    ChkBxInstallMRReport.Checked             := False;
    ChkBxInstallDSIClient.Checked            := False;
    ChkBxInstallIPDialBridge.Checked         := False;
    ChkBxInstallU209.Checked                 := False;
    ChkBxInstallTSP100.Checked               := False;
    ChkBxInstallMAGSWIPE_CFG.Checked         := False;
    ChkBxInstallPID.Checked                  := False;
    ChkBxInstallMRImportExport.Checked       := False;
    ChkBxInstallSwitchDB.Checked             := False;
    ChkBxInstallMRPoleDisplay.Checked        := False;
    ChkBxInstallMRPoleDisplaySvr.Checked     := False;
    ChkBxBackupDatabase.Checked              := False;

    ChkBxInstallDotnetFramework.Checked      := False;
    ChkBxInstallWindowsPoweShell.Checked     := False;
    ChkBxInstallWindowsInstaller.Checked     := False;

    ChkBxRecalculateInventoryValues.Checked  := False;

  End Else Begin

    ChkBxInstallSQLSERVER.Checked         := ( FInstacaoFile.ReadString( 'Settings', 'SQLSERVEREXPRESS8.EXE', '1' ) = '1' );
    ChkBxInstallMRReport.Checked          := ( FInstacaoFile.ReadString( 'Settings', 'MRREPORTINSTALL.EXE', '1' ) = '1' );
    ChkBxInstallDSIClient.Checked         := ( FInstacaoFile.ReadString( 'Settings', 'DSICLIENTINSTALL.EXE', '1' ) = '1' );
    ChkBxInstallIPDialBridge.Checked      := ( FInstacaoFile.ReadString( 'Settings', 'IPDIALBRIDGEINSTALL.EXE', '1' ) = '1' );
    ChkBxInstallU209.Checked              := ( FInstacaoFile.ReadString( 'Settings', 'U209-000-R.ZIP', '1' ) = '1' );
    ChkBxInstallTSP100.Checked            := ( FInstacaoFile.ReadString( 'Settings', 'TSP100_INSTALL.EXE', '1' ) = '1' );
    ChkBxInstallMAGSWIPE_CFG.Checked      := ( FInstacaoFile.ReadString( 'Settings', 'MAGSWIPE_CFG.ZIP', '1' ) = '1' );
    ChkBxInstallPID.Checked               := ( FInstacaoFile.ReadString( 'Settings', 'PIDB_CATALOG.ZIP', '1' ) = '1' );
    ChkBxInstallMRImportExport.Checked    := ( FInstacaoFile.ReadString( 'Settings', 'MRIMPORTEXPORTINSTALL', '1' ) = '1' );
    ChkBxInstallSwitchDB.Checked          := ( FInstacaoFile.ReadString( 'Settings', 'SWITCHDBINSTALL', '1' ) = '1' );
    ChkBxInstallMRPoleDisplay.Checked     := ( FInstacaoFile.ReadString( 'Settings', 'MRPOLEDISPLAYINSTALL', '1' ) = '1' );
    ChkBxInstallMRPoleDisplaySvr.Checked  := ( FInstacaoFile.ReadString( 'Settings', 'MRPOLEDISPLAYSVRINSTALL', '1' ) = '1' );
    ChkBxBackupDatabase.Checked           := ( FInstacaoFile.ReadString( 'Settings', 'BACKUPDATABASE', '1' ) = '1' );

    ChkBxInstallDotnetFramework.Checked   := ( FInstacaoFile.ReadString( 'Settings', 'DOTNETFRAMEWORK.EXE', '1' ) = '1' );
    ChkBxInstallWindowsPoweShell.Checked  := ( FInstacaoFile.ReadString( 'Settings', 'WINDOWSXP-KB968930-X86-ENG.EXE', '1' ) = '1' );
    ChkBxInstallWindowsInstaller.Checked  := ( FInstacaoFile.ReadString( 'Settings', 'WINDOWSXP-KB942288-V3-X86.EXE', '1' ) = '1' );

  End;

  EdtServerIPAddress.Text := FInstacaoFile.ReadString( 'Configurations', 'SERVERIPADDRESS', '' );

  sFileInfo         := FInstacaoFile.ReadString( 'Setup', 'Type', '' );
  sInstallationDone := FInstacaoFile.ReadString( 'Setup', 'INSTALLATION_DONE', 'N' );


  CbxReleaseType.ItemIndex := FInstacaoFile.ReadInteger( 'Setup', 'VersionType', 0 );
  LblReleaseType.Caption   := '('+CbxReleaseType.Text+')';

  If ( sFileInfo = 'Client'  )
  Then RdGrpInstallationType.ItemIndex := 0
  Else RdGrpInstallationType.ItemIndex := 1;

  If ( ( sFileInfo <> '' ) And ( sInstallationDone = 'Y') ) Then Begin

    TbsOptions.Visible := True;
    btnNext.Enabled    := False;

  End Else Begin

    TbsOptions.Visible  := False;
    btnNext.Enabled     := True;
    pgWizard.ActivePage := TbsInstallationType;

  End;

End;

procedure TFrmMain.BtnUpdateClick(Sender: TObject);
begin

  LblTitle.Caption := 'Select items to update';
  LblRepairMessage.Visible := False;

  InstallationType := itUpdate;

  SaveFileInfo();

  SetCheckBoxes( False );

  pgWizard.ActivePage := TbsInstallationType;
  MovNext();


end;

procedure TFrmMain.BtnRepairClick(Sender: TObject);
begin

  LblTitle.Caption := 'Select items to (re)install';
  LblRepairMessage.Visible := True;

  InstallationType := itRepair;


  pgWizard.ActivePage := TbsInstallationType;

  SaveFileInfo();

  SetCheckBoxes( True );
  MovNext();

end;

Procedure TFrmMain.CheckForNewVersion( bDoShow : Boolean  );
Var
  bRunNewVersion, bProcessItem : Boolean;
  sCommandText : String;
Begin

  If ( Pos( 'DESKTOP', UpperCase( ExtractFilePath( Application.ExeName )  ) ) > 0 ) Then Begin

    If Not DirectoryExists( MR_INSTALL ) Then ForceDirectories( MR_INSTALL );

    sCommandText := ExtractFileDir( Application.ExeName ) + '\MainRetail_Wizard.exe';
    CopyFile( sCommandText, MR_INSTALL + '\MainRetail_Wizard.exe', True );

    sCommandText := MR_INSTALL + '\MAINRETAIL_WIZARD.EXE';

    ShellExecute( Handle, 'OPEN', PChar( sCommandText ), Nil, Nil, 1 );

    bExitProcess := True;
    Exit;

  End;

  If ( bDoShow = True )
  Then Self.Show();

  Application.ProcessMessages();

  PnlProcessEvolution.Visible   := True;

  {============================================================================}
  { BOTH - MANIFEST                                                            }

  LblStepDescription.Caption  := 'Checking for new version, please wait';

  LblItemDescription.Caption  := 'Downloading MainRetail manifest, please wait';

  DownloadItem( 'MANIFEST.INI' );

  Application.ProcessMessages();

  if (FManifest = nil) then
  begin
    FManifest := TIniFile.Create(MR_INSTALL_FILES + '\DOWNLOAD\Manifest.ini');
    FManifest.UpdateFile();
  end;

  { Test to see if manifest was downloaded }
  If ( Not FileExists( MR_INSTALL_FILES + '\DOWNLOAD\Manifest.ini' ) ) Then Begin

    MessageDlg( 'MANIFEST.INI file was not downloaded, please check your internet connection.', mtInformation, [mbOK], 0 );
    Exit;

  End;

  {============================================================================}
  { BOTH - CHECK FOR NEW VERSION OF MAINRETAIL IS SO UPDATES ITSELF            }
  bRunNewVersion := FInstacaoFile.ReadBool( 'Setup', 'RUNNEWVERSION', False );

  bProcessItem         := True;
  FMainRetailVersion   := -1;
  FMainRetailDBVersion := -1;

  If ( ( ( bProcessItem = True ) And
         ( FileExists(ExtractFileDir(Application.ExeName) + '\MainRetail_Wizard.dpr')  ) ) Or
       ( Pos( 'TEST', UpperCase( ExtractFilePath( Application.ExeName )  ) ) > 0 ) )
  Then Begin

    PnlOptions.Visible          := True;
    PnlProcessEvolution.Visible := False;

    Exit;

  End;

  If ( bRunNewVersion = False ) Then Begin

    CheckCurrentVersionInfo( FMainRetailVersion, FMainRetailDBVersion );

    LblItemDescription.Caption  := 'Downloading MainRetail Wizard';
    DownloadItem( 'MAINRETAIL_WIZARD.ZIP' );

    // InstallationType := itRepair;

    bProcessItem := ProcessItem( 'MAINRETAIL_WIZARD.ZIP', ptInstall );
    If ( ( bProcessItem = True ) And  ( bRunNewVersion = False ) ) Then Begin

      InstallationType := itRepair;

      bSelfUpdating := True;
      FInstacaoFile.WriteBool( 'Setup', 'RUNNEWVERSION', True );

      LblItemDescription.Caption  := 'Installing MainRetail Wizard, please wait';

      { Copy current MAINRETAIL_WIZARD.INI to download folder to new MAINRETAIL_WIZARD use }
       If ( Pos( '\DOWNLOAD', ExtractFileDir( Application.ExeName ) ) = 0 ) Then Begin

        sCommandText := ExtractFileDir( Application.ExeName ) + '\MainRetail_Wizard.ini';
        CopyFile( sCommandText, MR_INSTALL_FILES + '\DOWNLOAD\MainRetail_Wizard.ini', True );

      End;

      UnZipItem( 'MAINRETAIL_WIZARD.ZIP' );

      If ( Pos( '\DOWNLOAD', ExtractFileDir( Application.ExeName ) ) > 0 )
      Then sCommandText := MR_INSTALL + '\MAINRETAIL_WIZARD.EXE'
      Else sCommandText := MR_INSTALL_FILES + '\DOWNLOAD\MAINRETAIL_WIZARD.EXE';

      // ShowMessage( ' Executing '+ sCommandText );

      ShellExecute( Handle, 'OPEN', PChar( sCommandText ), Nil, Nil, 1 );

      Application.ProcessMessages();

      bExitProcess := True;

      SaveFileInfo;

      Application.Terminate();

      PnlOptions.Visible          := True;
      PnlProcessEvolution.Visible := False;

      Exit;

    End;

  End;

  SaveFileInfo;

  PnlOptions.Visible          := True;
  PnlProcessEvolution.Visible := False;

End;

Procedure TFrmMain.CheckCurrentVersionInfo( Var psMainRetailVersion : Integer;
                                            Var psDataBaseVersion   : Integer );
Var
  ADOQuery : TADOQuery;
Begin

  If ( InstallationType = itInstall ) Then Begin

    psMainRetailVersion := -1;
    psDataBaseVersion   := -1;

  End Else Begin

    If ( OpenConnection() ) Then Begin

      Try

        ADOQuery := TADOQuery.Create( Self );
        ADOQuery.Connection := Self.ADODBConnect;

        ADOQuery.SQL.Add( 'SELECT MRBUILD, BUILDNO, VERSIONNO FROM SYS_MODULE' );
        ADOQuery.Open();

        psMainRetailVersion := ADOQuery.FieldByName('MRBUILD').AsInteger;
        psDataBaseVersion   := ADOQuery.FieldByName('BUILDNO').AsInteger;
//        showmessage(format('MRversion: %s, DbBuild: %s', [psMainRetailVersion, psDataBaseVersion]));

        ADOQuery.Close();

      Finally

        FreeAndNil( ADOQuery );

        CloseConnection();

      End;

    End Else Begin

      psMainRetailVersion := -1;
      psDataBaseVersion   := -1;

    End;

  End;

End;

Function TFrmMain.UpdateMainRetalVersion: Boolean;
Var
  iNewMainRetailVersion, iNewMainRetailDBVersion : Integer;
  ADOQuery : TADOQuery;
Begin

  Result := False;

  If ( OpenConnection() ) Then Begin

    Try
//      showMessage('inside UpdateMainRetailVersion');
      ADOQuery := TADOQuery.Create( Self );
      ADOQuery.Connection := Self.ADODBConnect;

      iNewMainRetailVersion   := FManifest.ReadInteger( 'Versions', 'MR', -1 );
      iNewMainRetailDBVersion := FManifest.ReadInteger( 'Versions', 'MRDB', -1 );
//      showmessage(format('NewMRversion: %s, NewDbBuild: %s', [iNewMainRetailVersion, iNewMainRetailDBVersion]));

      ADOQuery.SQL.Add( 'UPDATE SYS_MODULE SET '+
                        'VERSIONNO = ' + IntToStr( 5 )                     + ', '+
                        'MRBUILD   = ' + IntToStr( iNewMainRetailVersion ) + ', '+
                        'BUILDNO   = ' + IntToStr( iNewMainRetailDBVersion ) );

      ADOQuery.ExecSQL();

      Result := True;

    Finally

      FreeAndNil( ADOQuery );

      CloseConnection();

    End;

  End;

End;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If ( ( pgWizard.ActivePage = TbsOptions  ) And (Shift = [ssCtrl]) And (Key = 13) ) Then Begin

    PnlReleaseVersion.Visible := ( Not PnlReleaseVersion.Visible );        

  End;

end;

Function TFrmMain.ParseConnectionParameters( psParameters, psParameterToExtract: String ): String;
Begin                                                           

  iPosition := Pos( UpperCase( psParameterToExtract ), UpperCase( psParameters ) );


  If iPosition = 0 Then
    Result := ''
  Else begin

    sParameter := Copy( psParameters, iPosition, ( Length( psParameters) - iPosition + 1 ) );

    iPosition  := Pos('=', UpperCase( sParameter )) + 1;
    sParameter := Copy(sParameter, iPosition, ( Length( sParameter )-iPosition+1 ));

    iPosition := Pos(';', UpperCase( sParameter ) );
    if ( iPosition <> 0 ) then
      sParameter := Copy( sParameter, 1, iPosition-1 );

    Result := Trim( sParameter );

  End;

End;
 
procedure TFrmMain.BtnTestsClick(Sender: TObject);
Var
  sCommandText, sCommandParameters : String;
  sErrorMessage, sItemFolder, psItemName : String;
begin

  Exit;

  InstallationType := itRepair;

  AddScheduledTasks();

  Exit;

  MovNext();
  MovNext();

  PnlProcessEvolution.Visible := True;
  LblStepDescription.Caption  := 'Downloading files...';

    LblItemDescription .Caption  := 'Downloading MainRetail';
    DownloadItem( 'MAINRETAIL.ZIP' );
    DownloadItem( 'RECEIPTS.ZIP' );
    DownloadItem( 'LABELS.ZIP' );

  Exit;
    
  LblItemDescription.Caption  := 'Downloading Pet Industry Database';
  DownloadItem( 'MRCATALOGDB.ZIP' );

  Exit;

  DownloadItem('MAGSWIPE_CFG.ZIP');

  Exit;

  If ( WinVersion() = 'Windows7' )
  Then sCommandText       := ReturnWindowsFolder( CSIDL_SYSTEM ) + '\SCHTASKS.EXE'
  Else sCommandText       := ReturnWindowsFolder() + '\MAINRETAIL\SCHTASKS.EXE';

  RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MRBACKUP"            /F ' );
  sCommandParameters := '/CREATE /TN "MRBACKUP" /TR "'+ QuotedStr( ReturnWindowsFolder() + '\MAINRETAIL\MRBACKUP.EXE' )+' " /RU SYSTEM /SC DAILY /ST 23:01:00 ';

  RunAsAdminAndWaitForCompletion( sCommandText, sCommandParameters );

  Exit;

  InstallationType := itRepair;
  ConfigureDataBase( 'MainRetailDB', sErrorMessage );
  Exit;


  sCommandText       := ReturnWindowsFolder() + '\MAINRETAIL\SCHTASKS.EXE';
  RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MRDAILYMAINTENANCE"  /F ' );
  Exit;

  InstallationType := itRepair;
  DownloadItem( 'DEPLOY.ZIP' );
  Exit;

  InstallationType := itRepair;

      SetCheckBoxes( False );
InstallMainRetail();
exit;

  InstallationType := itRepair;
  UnZipItem( 'REPORTS.ZIP', True  );

  Exit;

end;

Function TFrmMain.MoveFolder( psSourceFolder, psDetinyFolder : String ): Boolean;
Var
  fos: TSHFileOpStruct;
Begin

  ZeroMemory(@fos, SizeOf(fos));

  with fos do begin
    wFunc  := FO_MOVE;
    fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_SILENT;
    pFrom  := PChar( psSourceFolder  + #0);
    pTo    := PChar( psDetinyFolder )
  end;

  Result := (0 = ShFileOperation(fos));

End;

Procedure TFrmMain.CloseMainRetailApplications;
Begin

  CloseApplication('Main');
  CloseApplication('MainMenu');
  CloseApplication('Main Retail');
  CloseApplication('MR Daily Maintenance');
  CloseApplication('MainRetail Import and Export Tool');
  CloseApplication('MRPet - [Main]');
  CloseApplication('PetCenter data');
  CloseApplication('MRPoleDisplay');
  CloseApplication('MRPoleDisplay 1.3');
  CloseApplication('Pole Display Server');

  CloseApplication('MR Report');
  CloseApplication('WzdPetCenter');

End;

procedure TFrmMain.BtnDownLoadClick(Sender: TObject);
begin

  FInstacaoFile.WriteBool( 'Setup', 'RUNNEWVERSION', False );

  bExitProcess := False;

  if FManifest <> nil then FreeAndNil( FManifest );

  InstallationType := itRepair;

   CheckForNewVersion( False );

  Application.ProcessMessages();


end;

End.

/*

DELETE FROM SALEITEMCOMMISSION
WHERE SALEITEMCOMMISSION.IDPREINVENTORYMOV IN (
  SELECT PREINVENTORYMOV.IDPREINVENTORYMOV
  FROM
    PREINVENTORYMOV
  WHERE
        PREINVENTORYMOV.INVENTMOVTYPEID = 1
    AND NOT EXISTS  ( SELECT 1
                      FROM PREINVENTORYMOV PREIN (NOLOCK)
                             JOIN INVOICE INV (NOLOCK) ON ( ( PREIN.DOCUMENTID = INV.IDPRESALE )
                                                        AND ( PREIN.INVENTMOVTYPEID = 1 ) )
                      WHERE PREIN.IDPREINVENTORYMOV = PREINVENTORYMOV.IDPREINVENTORYMOV  ) )

DELETE FROM PREINVENTORYMOV
WHERE PREINVENTORYMOV.INVENTMOVTYPEID = 1
  AND NOT EXISTS  ( SELECT 1
                  FROM PREINVENTORYMOV PREIN (NOLOCK)
                         JOIN INVOICE INV (NOLOCK) ON ( ( PREIN.DOCUMENTID = INV.IDPRESALE )
                                                    AND ( PREIN.INVENTMOVTYPEID = 1 ) )
                  WHERE PREIN.IDPREINVENTORYMOV = PREINVENTORYMOV.IDPREINVENTORYMOV  )


DELETE FROM SALEITEMCOMMISSION
WHERE SALEITEMCOMMISSION.IDPREINVENTORYMOV IN (
  SELECT PREINVENTORYMOV.IDPREINVENTORYMOV
  FROM
    PREINVENTORYMOV
  WHERE
        PREINVENTORYMOV.INVENTMOVTYPEID = 1
   AND EXISTS  ( SELECT 1
                 FROM PREINVENTORYMOV PREIN (NOLOCK)
                        JOIN INVOICE INV (NOLOCK) ON ( ( PREIN.DOCUMENTID = INV.IDPRESALE )
                                                       AND ( PREIN.INVENTMOVTYPEID = 1 ) )
                        JOIN INVENTORYMOV INM (NOLOCK) ON ( INV.IDINVOICE = INM.DOCUMENTID )
                 WHERE PREIN.IDPREINVENTORYMOV = PREINVENTORYMOV.IDPREINVENTORYMOV  ) )

DELETE FROM
  PREINVENTORYMOV
WHERE
      PREINVENTORYMOV.INVENTMOVTYPEID = 1
  AND EXISTS  ( SELECT 1
                FROM PREINVENTORYMOV PREIN (NOLOCK)
                       JOIN INVOICE INV (NOLOCK) ON ( ( PREIN.DOCUMENTID = INV.IDPRESALE )
                                                      AND ( PREIN.INVENTMOVTYPEID = 1 ) )
                       JOIN INVENTORYMOV INM (NOLOCK) ON ( INV.IDINVOICE = INM.DOCUMENTID )
                WHERE PREIN.IDPREINVENTORYMOV = PREINVENTORYMOV.IDPREINVENTORYMOV  )


                  */
