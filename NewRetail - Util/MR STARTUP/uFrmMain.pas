unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, uDataBaseOperation, ComCtrls, Registry,
  uEncryptFunctions;

const
   IMG_INIT  = 0;
   IMG_SET   = 4;
   IMG_OK    = 3;
   IMG_ERROR = 2;

   REG_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

type
  TFrmMain = class(TForm)
    pnlBottom: TPanel;
    btnClose: TSpeedButton;
    imgStep1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    lbFindServer: TLabel;
    lbVerifySQL: TLabel;
    imgVerifySQL: TImage;
    imgStep2: TImage;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    lbInstallDB: TLabel;
    imgCreateDB: TImage;
    imgStartService: TImage;
    lbStartServer: TLabel;
    imgStep3: TImage;
    Bevel3: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    lbDelFiles: TLabel;
    imgDelFiles: TImage;
    lbSQLInstallResume: TLabel;
    lbDBResume: TLabel;
    imgLogIn: TImage;
    lbLogIn: TLabel;
    lbRunMain: TLabel;
    imgRunMainRetail: TImage;
    lbFinallResume: TLabel;
    lbMainRetailInfo: TLabel;
    pnlAnalyze: TPanel;
    Animate: TAnimate;
    Label11: TLabel;
    pnlOpSystem: TPanel;
    Label12: TLabel;
    lbOpSystem: TLabel;
    Label13: TLabel;
    lbVersion: TLabel;
    Timer: TTimer;
    imgInstallRep: TImage;
    lbInstallRep: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    DBOperation : TDataBaseOperation;

    sUser, sPW, sInstallPath : String;
    sMsg, sAppDir, sAppPath : String;
    bSQLIsLogged : Boolean;
    Reg : TRegistry;
    procedure ClearImg(b:TBitmap);
    procedure ImagesInitial;
    procedure GetSystemInfo;

    procedure SetImgIni(b:TBitmap; lResume, lActual:TLabel);
    procedure SetImgOK(b:TBitmap; lResume, lActual:TLabel; Msg:String);
    procedure SetImgERR(b:TBitmap; l:TLabel; Msg:String);
    function MRUserExist:Boolean;

    procedure Start_Steps;
    function Setp1_SQLDetect:Boolean;
    function Setp2_StartService:Boolean;
    function Step2_LogIn:Boolean;
    function Step2_CreateDB:Boolean;
    function Step3_DeletingFiles:Boolean;
    function Step3_InformVersion:Boolean;
    function Step3_LauchMainRetail:Boolean;
    function Step3_InstallingReport:Boolean;
    function MRDeleteFile(_from: String): Boolean;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uDM, uFrmSQLInstall, uFileFunctions, uParamFunctions, shellapi, shlobj,
     uOperationSystem, ufrmServerInfo;

{$R *.DFM}


procedure TfrmMain.GetSystemInfo;
var
  BuildInfo : string;
begin

    case GetOS(BuildInfo) of
        osUnknown: lbOpSystem.Caption:='Unknown OS';
        os95:      lbOpSystem.Caption:='Windows 95';
        os95OSR2:  lbOpSystem.Caption:='Windows 95 OSR2';
        os98:      lbOpSystem.Caption:='Windows 98';
        os98SE:    lbOpSystem.Caption:='Windows 98 Second Edition';
        osME:      lbOpSystem.Caption:='Windows Millennium';
        osNT3:     lbOpSystem.Caption:='Windows NT 3';
        osNT4:     lbOpSystem.Caption:='Windows NT 4';
        os2K:      lbOpSystem.Caption:='Windows 2000';
        osXP:      lbOpSystem.Caption:='Windows XP';
    end;

    lbMainRetailInfo.Caption := 'MainRetail will be installed on ';
    lbVersion.caption        := BuildInfo;

end;

procedure TFrmMain.SetImgIni(b:TBitmap; lResume, lActual:TLabel);
begin

  ClearImg(b);
  DM.imgSmall.GetBitmap(IMG_SET, b);
  if Assigned(lResume) then
     lResume.Caption := 'Starting ...';

  lActual.Font.Style := [fsBold,fsUnderline];
  lActual.Font.Color := $00DE8E6B;
  Application.ProcessMessages;

end;

procedure TFrmMain.SetImgOK(b:TBitmap; lResume, lActual:TLabel; Msg:String);
begin

  ClearImg(b);
  DM.imgSmall.GetBitmap(IMG_OK, b);
  lResume.Caption := Msg;
  lActual.Font.Style := [];
  lActual.Font.Color := clWindowText;
  Application.ProcessMessages;

end;

procedure TFrmMain.SetImgERR(b:TBitmap; l:TLabel; Msg:String);
begin

  ClearImg(b);
  DM.imgSmall.GetBitmap(IMG_ERROR, b);
  l.Caption := Msg;
  l.Hint := Msg;
  Application.ProcessMessages;

end;

procedure TFrmMain.ClearImg(b:TBitmap);
begin
  b.canvas.brush.color:=clWhite;
  b.canvas.fillrect(rect(0,0,b.width,b.height));
end;

function TFrmMain.Setp1_SQLDetect:Boolean;
begin

  //Initial img
  SetImgIni(imgVerifySQL.Picture.Bitmap, lbSQLInstallResume, lbVerifySQL);

  Sleep(10000);

  //Verify if SQL is installed, if not Install MSDE
  with TFrmSQLInstall.Create(Self) do
     Result := Start(sUser, sPW, sInstallPath, bSQLIsLogged);

  if Result then
     begin
     sMsg := 'SQL Server successful installed into your computer.';
     SetImgOK(imgVerifySQL.Picture.Bitmap, lbSQLInstallResume, lbVerifySQL, sMsg);
     end
  else
     begin
     sMsg := 'An error occurs during SQL Server Installation. '#13#10'Installation aborted!';
     SetImgERR(imgVerifySQL.Picture.Bitmap, lbSQLInstallResume, sMsg);
     end;

end;

function TFrmMain.Setp2_StartService:Boolean;
var
  OSVersionInfo : TOSVersionInfo;
begin

  //If the SQL is running, it is not necessary
  if bSQLIsLogged then
     begin
     sMsg := 'SQL Server started. ';
     SetImgOK(imgStartService.Picture.Bitmap, lbDBResume, lbStartServer, sMsg);
     Result := True;
     Exit;
     end;

  //Change img
  SetImgIni(imgStartService.Picture.Bitmap, lbDBResume, lbStartServer);

  Sleep(5000);

  //Start SQL Server based on Client Windows
  Try
    OSVersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    GetVersionEx(OSVersionInfo);
    with OSVersionInfo do
       begin
       case dwPlatformId of
             //Win 3.11
            VER_PLATFORM_WIN32S :
                            WaitExecute(sInstallPath+'\80\Tools\Binn\scm -Action 1 -Service mssqlserver -svcStartType 2');
             //Win 95, 98, MI.
            VER_PLATFORM_WIN32_WINDOWS:
                            WaitExecute(sInstallPath+'\80\Tools\Binn\scm -Action 1 -Service mssqlserver -svcStartType 2');
             //Win NT
            VER_PLATFORM_WIN32_NT:
                            WaitExecute('net start mssqlserver');
            end;
       end;

    sMsg := 'Server successful started.';
    SetImgOK(imgStartService.Picture.Bitmap, lbDBResume, lbStartServer, sMsg);
    Result := True;
  Except
   on E: Exception do
      begin
      Result := False;
      sMsg := 'An error occurs during SQL Server Initialization. Error : "'+ E.Message+'". Installation aborted!';
      SetImgERR(imgStartService.Picture.Bitmap, lbDBResume, sMsg);
      end;
   end;

end;

function TFrmMain.Step2_LogIn:Boolean;
begin

  //SQL is alread logged
  if bSQLIsLogged then
     begin
     sMsg := lbDBResume.Caption + #13#10 + 'SQL Server logged in. ';
     SetImgOK(imgLogIn.Picture.Bitmap, lbDBResume, lbLogIn, sMsg);
     Result := True;
     Exit;
     end;

  //Change img
  SetImgIni(imgLogIn.Picture.Bitmap, nil, lbLogIn);

  Sleep(5000);

  //Try to login connection on the new DB
  DM.Connection.Close;
  DM.Connection.ConnectionString := SetConnectionStr('sa', '7740', 'Master', '(Local)');
  try
     DM.Connection.Open;
     sMsg := lbDBResume.Caption + #13#10 + 'SQL Server logged in. ';
     SetImgOK(imgLogIn.Picture.Bitmap, lbDBResume, lbLogIn, sMsg);
     Result := True;
  except
   on E: Exception do
      begin
      Result := False;
      sMsg := lbDBResume.Caption + #13#10 + 'An error occurs during SQL Server log in. Error : "'+E.Message+'" Installation aborted!';
      SetImgERR(imgStartService.Picture.Bitmap, lbDBResume, sMsg);
      end;
  end;
end;

function TFrmMain.MRUserExist:Boolean;
begin
  with DM.qryFreeSQL do
  begin
    if Active then
      Close;
    CommandText := 'Select loginname from master.dbo.syslogins where loginname = '+QuotedStr('mruser');
    Open;
    Result := (not IsEmpty);
    Close;
  end;
end;

function TFrmMain.Step2_CreateDB:Boolean;
var
  BDExist,
  bRestore : Boolean;
begin

  //Change img
  SetImgIni(imgCreateDB.Picture.Bitmap, nil, lbInstallDB);
  bRestore := True;

  Sleep(5000);

  //Verify if the DB exist
  with DM.qryFreeSQL do
     begin
     if Active then
        Close;
     CommandText := 'SELECT Name FROM master..sysdatabases where name='+QuotedStr('MainRetailDB')+' ';
     Open;
     BDExist := (not IsEmpty);
     Close;
     end;

  if BDExist then
    begin
    sMsg := lbDBResume.Caption + #13#10 + 'MainRetail Database NOT overwritten.' + #13#10 + 'password NOT changed. ';
    SetImgOK(imgCreateDB.Picture.Bitmap, lbDBResume, lbInstallDB, sMsg);
    bRestore := False;
    end;

{
  if BDExist then
    if MessageDlg('Pet Center database already installed! Overwrite Database? All data will be deleted.', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      begin
      sMsg := lbDBResume.Caption + #13#10 + 'Pet Center Database NOT overwritten.' + #13#10 + 'sa password NOT changed. ';
      SetImgOK(imgCreateDB.Picture.Bitmap, lbDBResume, lbInstallDB, sMsg);
      bRestore := False;
      end;
}

  //Restore Database
  if bRestore then
     begin
     //Create SQL dir
     if not DirectoryExists(sAppDir+'\MSSQL_Data') then
        if not CreateDir(sAppDir+'\MSSQL_Data') then
           raise Exception.Create('Cannot create '+sAppDir+'\MSSQL_Data');

     //Prepare to Restore MainRetail DB
     Try
        if not Assigned(DBOperation) then
           DBOperation := TRestoreDataBase.Create;

        DBOperation.Connection                        := DM.Connection;
        DBOperation.DataBaseName                      := 'MainRetailDB';
        DBOperation.Device                            := DEVICE_DISK + QuotedStr(sAppPath+'MainRetailDB.dat');
        TRestoreDataBase(DBOperation).ForceRestore    := RST_REPLACE_DB;

        TRestoreDataBase(DBOperation).LogicalDataName := QuotedStr('MainRetailDB_Data');
        TRestoreDataBase(DBOperation).NewDataPath     := QuotedStr(sAppDir+'\MSSQL_Data\MainRetailDB.mdf');

        TRestoreDataBase(DBOperation).LogicalLogName  := QuotedStr('MainRetailDB_Log');
        TRestoreDataBase(DBOperation).NewLogPath      := QuotedStr(sAppDir+'\MSSQL_Data\MainRetailDB.ldf');

        Try
           Result := (DBOperation.SetSQLExecute = -1);
           if Result then
              sMsg := lbDBResume.Caption + #13#10 + 'MainRetail database successful created.'
        except
           on E: Exception do
              begin
              Result := False;
              sMsg := lbDBResume.Caption + #13#10 + 'An error occurs while creating database. Error : "'+E.Message +'" Installation aborted!';
              SetImgERR(imgCreateDB.Picture.Bitmap, lbDBResume, sMsg);
              Exit;
              end;
           end;
       finally
         FreeAndNil(DBOperation);
         end;
     end; //End bRestore

  //Creating new account password if necessary
  if not MRUserExist then
     begin
     Sleep(5000);
     try
       DM.cmdFreeSQL.CommandText := 'EXEC sp_addlogin '+QuotedStr('mruser')+', '+QuotedStr('mruser2000')+', '+QuotedStr('MainRetailDB');
       DM.cmdFreeSQL.Execute;
       DM.cmdFreeSQL.CommandText := 'EXEC sp_addsrvrolemember '+QuotedStr('mruser')+', '+QuotedStr('sysadmin');
       DM.cmdFreeSQL.Execute;
       sMsg := sMsg + #13#10 + 'User account successfully created. ';
       Result := True;
      except
         on E: Exception do
            begin
            Result := False;
            sMsg := lbDBResume.Caption + #13#10 + 'An error occurs while creating user account. Error : "'+E.Message +'" Installation aborted!';
            SetImgERR(imgCreateDB.Picture.Bitmap, lbDBResume, sMsg);
            end;
       end;
    end
  else
    begin
    Result := True;
    sMsg := sMsg + #13#10 + 'User account already created.';
    end;

  SetImgOK(imgCreateDB.Picture.Bitmap, lbDBResume, lbInstallDB, sMsg);
  Screen.Cursor:= crDefault;

end;

function TFrmMain.Step3_DeletingFiles:Boolean;

  procedure DelFile(sFile:String);
  var
    Attr : Integer;
  begin
     //Take the read only from the file, or the file will not be deleted
     Attr := FileGetAttr(sFile);
     Attr := Attr and (not faReadOnly);
     FileSetAttr(sFile, Attr);
     DeleteFile(sFile);
  end;

begin

  //Change img
  SetImgIni(imgDelFiles.Picture.Bitmap, nil, lbDelFiles);

  Sleep(5000);

  //Delete Installation From StartUp
  if Reg.ValueExists('MRStart') then
     Reg.DeleteValue('MRStart');

  //Delete Install files
  Try

     if FileExists(sAppPath + 'MainRetailDB.dat') then
       DelFile(sAppPath + 'MainRetailDB.dat');

     if DirectoryExists(sAppPath + 'MSDE') then
       DeleteFolder(sAppPath + 'MSDE');

     sMsg := 'Temporary files deleted. ';
     SetImgOK(imgDelFiles.Picture.Bitmap, lbFinallResume, lbDelFiles, sMsg);

     Result := True;
     
  Except
     on E: Exception do
        begin
        Result := False;
        sMsg   := lbDBResume.Caption + #13#10 + 'An error occurs while deleting temporary files. Error : "'+E.Message;
        SetImgERR(imgDelFiles.Picture.Bitmap, lbFinallResume, sMsg);
        end;
    end;

end;

function TFrmMain.Step3_InformVersion : Boolean;
var
  sResult : String;
  bError : Boolean;
begin

  try
    sResult := '#Module#=D;#Key#=N;#Date#='+DateTimeToStr(now)+';';
    sResult := EncodeServerInfo(sResult, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU);

    //Show Trial Version Form
    with DM.cmdFreeSQL do
       begin
       if Active then
          Close;
       CommandText := 'UPDATE MainRetailDB..Sys_Module SET ModuleInfo = '+QuotedStr(sResult);
       Execute;
       end;

    //Grava no register o resultado
    with TFrmServerInfo.Create(Self) do
       begin
       Start('D', False, '', bError);
       Free;
       end;

    Result := True;

  Except
    on E: Exception do
    begin
      Result := False;
      sMsg   := lbDBResume.Caption + #13#10 + 'An error occurs while checking version._Error : "'+E.Message;
      SetImgERR(imgDelFiles.Picture.Bitmap, lbFinallResume, sMsg);
    end;
  end;

  Application.ProcessMessages;

end;

function TFrmMain.Step3_LauchMainRetail : Boolean;
var
  i : integer;
  sDefaulEXE : string;
  Exec: array[0..255] of char;
begin

  //Change img
  SetImgIni(imgRunMainRetail.Picture.Bitmap, nil, lbRunMain);

  Sleep(5000);

  Try
     sDefaulEXE := sAppPath + 'MRWizard.exe';
     ExecuteFile(sDefaulEXE, '', '', SW_SHOW);
     Result := True;
     SetImgOK(imgRunMainRetail.Picture.Bitmap, lbFinallResume, lbRunMain, sMsg);
  Except
    on E: Exception do
    begin
      Result := False;
      sMsg   := lbDBResume.Caption + #13#10 + 'An error occurs while executing wizard call._Error : "'+E.Message;
      SetImgERR(imgRunMainRetail.Picture.Bitmap, lbFinallResume, sMsg);
    end;
  end;

  Application.ProcessMessages;

end;

procedure TFrmMain.ImagesInitial;
begin

  DM.imgLarge.GetBitmap(1, imgStep1.Picture.Bitmap);
  DM.imgLarge.GetBitmap(2, imgStep2.Picture.Bitmap);
  DM.imgLarge.GetBitmap(3, imgStep3.Picture.Bitmap);

  DM.imgSmall.GetBitmap(IMG_INIT, imgVerifySQL.Picture.Bitmap);
  DM.imgSmall.GetBitmap(IMG_INIT, imgCreateDB.Picture.Bitmap);
  DM.imgSmall.GetBitmap(IMG_INIT, imgStartService.Picture.Bitmap);
  DM.imgSmall.GetBitmap(IMG_INIT, imgDelFiles.Picture.Bitmap);
  DM.imgSmall.GetBitmap(IMG_INIT, imgLogIn.Picture.Bitmap);
  DM.imgSmall.GetBitmap(IMG_INIT, imgRunMainRetail.Picture.Bitmap);
  DM.imgSmall.GetBitmap(IMG_INIT, imgInstallRep.Picture.Bitmap);

end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
 ImagesInitial;
 Animate.Active := True;
 Timer.Enabled  := True;
end;

procedure TFrmMain.btnCloseClick(Sender: TObject);
begin
   Close;
end;

procedure TFrmMain.Start_Steps;
begin

   Screen.Cursor    := crHourGlass;
   btnClose.Enabled := False;

   try
      if not Setp1_SQLDetect then
         Exit;

      Screen.Cursor := crHourGlass;

      if not Setp2_StartService then
         Exit;

      Screen.Cursor := crHourGlass;

      if not Step2_LogIn then
         Exit;

      Screen.Cursor := crHourGlass;

      if not Step2_CreateDB then
         Exit;

      Screen.Cursor := crHourGlass;

      if not Step3_InstallingReport then
        Exit;

      if not Step3_DeletingFiles then
        Exit;


      //if not Step3_InformVersion then
      //  Exit;

      Screen.Cursor := crHourGlass;

      if not Step3_LauchMainRetail then
        Exit;

      Screen.Cursor := crHourGlass;

      //Auto delete function
      try
        Application.ProcessMessages;
        SelfDelete(Application.ExeName);
      Except
        on E: Exception do
        begin
          sMsg := lbDBResume.Caption + #13#10 + 'An error occurs while deleting itself._Error : "'+E.Message;
          SetImgERR(imgDelFiles.Picture.Bitmap, lbFinallResume, sMsg);
          Exit;
        end;
      end;

      Close;

   Finally
      Screen.Cursor    := crDefault;
      btnClose.Enabled := True;
      end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

  sAppDir     := ExtractFileDrive(Application.ExeName);
  sAppPath    := ExtractFilePath(Application.ExeName);
  Reg         := TRegistry.Create;
  with Reg Do
    begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey(REG_PATH, False);
    if not ValueExists('MRStart') then
       WriteString('MRStart', Application.ExeName);
    end;

end;

procedure TFrmMain.TimerTimer(Sender: TObject);
begin

  Timer.Enabled       := False;
  Animate.Active      := False;
  pnlAnalyze.Visible  := False;
  pnlOpSystem.Visible := True;
  GetSystemInfo;
  Application.ProcessMessages;
  Start_Steps;

end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  Reg.CloseKey; 
  FreeAndNil(Reg);
end;

function TFrmMain.Step3_InstallingReport: Boolean;
begin

  SetImgIni(imgInstallRep.Picture.Bitmap, nil, lbInstallRep);
  Sleep(0);

  try

    if FileExists(sAppPath + 'MRReportInstall.exe') then
    begin
      WaitExecute(sAppPath + 'MRReportInstall.exe');
      Sleep(0);
      Application.ProcessMessages;
      MRDeleteFile(sAppPath + 'MRReportInstall.exe');
    end;

    SetImgOK(imgInstallRep.Picture.Bitmap, lbFinallResume, lbInstallRep, 'Report installed.');
    Result := True;

  except
    Result := False;
    SetImgERR(imgInstallRep.Picture.Bitmap, lbFinallResume, 'Error installing MRReport.');
  end;

end;

function TFrmMain.MRDeleteFile(_from: String): Boolean;
var
    f: TSHFileOPStruct;
    f_from, f_to: array[0..255] of char;
    k:integer;
begin
  Result := True;

  if FileExists(_from) then
  try
    for k:=0 to 255 do
    begin
     f_from[k]:=#0;
     f_to[k]:=#0;
    end;
    F.Wnd := application.handle;
    F.wFunc := FO_DELETE;
    strpcopy(f_from, _from);
    F.pFrom := f_from;
    F.pTo := f_from;
    F.fFlags :=  FOF_NOCONFIRMATION;
    if ShFileOperation(F) <> 0 then
      Exception.Create('Detele error.');
  except
    raise;
    Result := False;
    end;
end;


end.
