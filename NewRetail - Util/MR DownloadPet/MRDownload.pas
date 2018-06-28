unit MRDownload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, CheckLst, ImgList, ComCtrls, Buttons,
  Wininet, AbBase, AbBrowse, AbZBrows, AbUnzper, AbMeter, IniFiles, siComp,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP;

const
  BTN_NEXT   = 0;
  BTN_AGREE  = 1;
  BTN_FINISH = 2;

  HTTP_DOWNLOAD = 'http://www.360pet.com/download/';
  HTTP_DOWNLOAD_SQL = 'http://www.360pet.com/download/';

  SOFTWARE_MSDE = 'MSDE (SQL Server)';
  SOFTWARE_MRPET = 'Pet Center';
  SOFTWARE_MRAPPSERVER = 'Application Server';
  SOFTWARE_MAINREPORT = 'Report Tool';
  SOFTWARE_REPORT_INSTALLER = 'Report Installation';
  SOFTWARE_IMPEXP = 'Import-Export Tool';
  SOFTWARE_PETSTARTUP = 'Start-Up Installation';
  SOFTWARE_SYSTEMDLL = 'System files';
  SOFTWARE_PETWIZARD = 'Pet Wizard Tool';
  SOFTWARE_DATABASE = 'Empty Database';

  MR_REPORT_INSTALL = 'MRReportInstall.exe';

  SQL_REG_PATH = 'Software\Microsoft\MSSQLServer\MSSQLServer\CurrentVersion';
  MR_INSTALL_DIR = 'C:\Program Files\MainRetail3\';

  BpsArray: array [0..2] of Integer = (14400,
                                           1024000,
                                           5120000);

type
  TDRec = record
    H, M, S: Integer;
  end;

  TSoftwareInfo = class
    Software     : String;
    FileDownload : String;
    Description  : String;
    WWW          : String;
    SizeMB       : Double;
    ReadOnly     : Boolean;
  end;


  TFrmMain = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    lbStatus: TLabel;
    btnBack: TButton;
    btnNext: TButton;
    btnClose: TButton;
    Notebook: TNotebook;
    ImgIntro: TImage;
    memIntro: TMemo;
    Panel5: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    imgLicense: TImage;
    Panel2: TPanel;
    lbTop: TLabel;
    lbInfo: TLabel;
    imgConnection: TImage;
    Panel4: TPanel;
    Label57: TLabel;
    Label58: TLabel;
    ImgChooser: TImage;
    ImgSummary: TImage;
    Label29: TLabel;
    Label37: TLabel;
    Label1: TLabel;
    Panel6: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    lbDescription: TLabel;
    Label11: TLabel;
    GroupBox2: TGroupBox;
    edtFolder: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    lbSpaceRequired: TLabel;
    lbSpaceAvailable: TLabel;
    tvwSoftware: TTreeView;
    imgCheck: TImageList;
    SpeedButton1: TSpeedButton;
    pbDownload: TProgressBar;
    lbResponse: TLabel;
    tvwResult: TTreeView;
    UnZip: TAbUnZipper;
    pbZip: TAbMeter;
    ZipLinker: TAbVCLMeterLink;
    siLangDispatcher: TsiLangDispatcher;
    siLang1: TsiLang;
    cbxLanguage: TComboBox;
    pnlError: TPanel;
    lbDownloadError: TLabel;
    FTP: TIdFTP;
    Image1: TImage;
    cbxInternetSpeed: TComboBox;
    lbInternetSpeed: TLabel;
    lbTimeLeft: TLabel;
    procedure FormShow(Sender: TObject);
    procedure NotebookPageChanged(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure tvwSoftwareDblClick(Sender: TObject);
    procedure tvwSoftwareClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxLanguageChange(Sender: TObject);
    procedure FTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
  private
    sNext,
    sIAgree,
    sFinish,
    sConnecting,
    sMSDE,
    sPetStartUp,
    sPetWizard,
    sDll,
    sDB,
    sMRPet,
    sAppServer,
    sReports,
    sReportsInstall,
    sImportExport,
    sExtracting : String;


    FDownloadedFile : TIniFile;
    SoftwareList : TStringList;
    TotalFileSize : Double;

    procedure SetLang(IDLang:Integer);

    procedure PageWelcome;
    procedure PageReadme;
    procedure PageChooseComponent;
    procedure PageChooseFolder;
    procedure PageResume;

    procedure DoFinish;
    procedure SetNextPage;
    procedure SetPriorPage;

    procedure CreateSoftwareList;
    procedure BuildSoftwareList;
    procedure DisplayDescription(Software: String);

    function FTPConnect : Boolean;
    procedure FTPDisconnect;

    function DetectLocalSQL: Boolean;

    procedure DownloadFilesSize;
    procedure StartDownload(Software: String);
    function DownloadFile(var AFileSize: dWord; Const Source, Dest: String; Const ToLabel: TLabel = Nil;
      Const PrgBar: TProgressBar = Nil; Software : String = ''): Boolean;
    function DownloadFTPFile(var AFileSize: dWord; const AFileName, ASoftware : String) : Boolean;
    function FileDownloaded(ASoftware : String):Boolean;
    function SaleDownload(ASoftware : String):Boolean;
    function ExtractZipFile(sSourceFile, sDestDir : String ) : Boolean;
    function MRDeleteFile(_from: String):Boolean;
    function RegisterDLLs : Boolean;
    function StartInstall : Boolean;
    function InstallReport : Boolean;
    function MoveTempFiles : Boolean;
    function SelfDelete : Boolean;
    function CalculateDLTime(const Value, Units, Connection: Integer): TDRec;
    function ResultDownloadTime(ADLTime: Integer): String;
    function GetInstallDir: String;
  public
    procedure Start;
  end;

var
  FrmMain: TFrmMain;

implementation

uses Registry, shellapi, shlobj, uFileFunctions, Math;

{$R *.dfm}

{ TFrmMain }

procedure TFrmMain.StartDownload(Software: String);
var
  www : String;
  FileSize: dWord;
  FileDownload, ListedSoftware : String;
  i, index : Integer;
  dFileSize : Double;
  bResult : Boolean;
begin
  try
    lbResponse.Visible := True;
    pbDownload.Visible := True;
    tvwResult.Visible  := True;
    lbTimeLeft.Visible := True;
    Screen.Cursor      := crHourGlass;
    Application.ProcessMessages;

    if not FTPConnect then
    begin
      ShowMessage('Error: Cannot connect on the server. Try it later!');
      Exit;
    end;

    //SoftwareList
    try
      for i := 0 to tvwResult.Items.Count-1 do
      begin
        index          := SoftwareList.IndexOf(tvwResult.Items.Item[i].Text);
        FileDownload   := TSoftwareInfo(SoftwareList.Objects[index]).FileDownload;
        ListedSoftware := TSoftwareInfo(SoftwareList.Objects[index]).Software;
        www            := TSoftwareInfo(SoftwareList.Objects[index]).WWW + FileDownload;
        dFileSize      := TSoftwareInfo(SoftwareList.Objects[index]).SizeMB;

        if not FileDownloaded(ListedSoftware) then
        begin
          //Loop the software list
          pbDownload.Visible := True;
          pbZip.Visible      := False;

          bResult := DownloadFTPFile(FileSize, FileDownload, ListedSoftware);
          //bResult := DownloadFile(FileSize, www, edtFolder.Text +'\'+ FileDownload, lbResponse, pbDownload, ListedSoftware);
          if not bResult then
            Exit;
          tvwResult.Items[i].Text := tvwResult.Items[i].Text + ' downloaded ' + FormatFloat('0.000', ((FileSize / 1024) / 1000)) + ' MB';

          pbDownload.Visible := False;
          pbZip.Visible      := True;

          if (Pos('.zip', FileDownload) > 0) then
            bResult := ExtractZipFile(GetInstallDir + '\'+ FileDownload, GetInstallDir)
          else
            bResult := True;

          if not bResult then
            Exit;

          tvwResult.Items[i].StateIndex := 3;
          SaleDownload(ListedSoftware);
          Application.ProcessMessages;
        end
        else if FileExists(GetInstallDir + '\'+ FileDownload) then
        begin
          tvwResult.Items[i].StateIndex := 3;
          Application.ProcessMessages;
        end;
      end;
    except
      pnlError.Visible := True;
      end;

    FTPDisconnect;

    for i := 0 to tvwResult.Items.Count-1 do
      begin
        if (Pos('.zip', TSoftwareInfo(SoftwareList.Objects[i]).FileDownload) > 0) then
          bResult := MRDeleteFile(GetInstallDir + '\'+ TSoftwareInfo(SoftwareList.Objects[i]).FileDownload);
        if not bResult then
          Exit;
      end;

   InstallReport;

   MoveTempFiles;

   RegisterDLLs;

   StartInstall;

   SelfDelete;

 finally
    FTPDisconnect;
    lbResponse.Visible := False;
    pbDownload.Visible := False;
    pbZip.Visible      := False;
    lbTimeLeft.Visible := False;
    Screen.Cursor      := crDefault;
 end;

end;


procedure TFrmMain.DoFinish;
begin
  //Finish Wizard
  StartDownload(SOFTWARE_MAINREPORT);
end;

procedure TFrmMain.PageChooseComponent;
begin
  DownloadFilesSize;
  btnNext.Caption := sNext;
  btnNext.Tag     := BTN_NEXT;
  Notebook.Color  := clBtnFace;
  btnBack.Visible := True;
end;

procedure TFrmMain.PageChooseFolder;
var
 FreeAvail, TotalSpace: Int64;
 TotalFree: TLargeInteger;
begin
  btnNext.Caption := sNext;
  btnNext.Tag     := BTN_NEXT;
  Notebook.Color  := clBtnFace;
  btnBack.Visible := True;
  lbSpaceRequired.Caption := FormatFloat('0.00 MB', TotalFileSize);
  GetDiskFreeSpaceEx('C:', FreeAvail, TotalSpace, @TotalFree);
  lbSpaceAvailable.Caption := FormatFloat('0.00 MB', ((FreeAvail/1024)/1024));
end;

procedure TFrmMain.PageReadme;
begin
  btnNext.Caption := sIAgree;
  btnNext.Tag     := BTN_AGREE;
  Notebook.Color  := clBtnFace;
  btnBack.Visible := True;
end;

procedure TFrmMain.PageResume;
var
  i : Integer;
  node : TTreeNode;
begin
  btnNext.Caption := sFinish;
  btnNext.Tag     := BTN_FINISH;
  Notebook.Color  := clWhite;
  btnBack.Visible := True;

  tvwResult.Items.Clear;
  for i := 0 to tvwSoftware.Items.Count-1 do
  if tvwSoftware.Items[i].StateIndex in [2, 3] then
  begin
    node := tvwResult.Items.Add(tvwSoftware.Items[i], tvwSoftware.Items[i].Text);
    node.StateIndex := 1;
  end;
end;

procedure TFrmMain.PageWelcome;
begin
  btnNext.Caption := sNext;
  btnNext.Tag     := BTN_NEXT;
  Notebook.Color  := clBtnFace;
  btnBack.Visible := False;
end;

procedure TFrmMain.SetNextPage;
var
  iStep : Integer;
begin

  iStep := 0;

  Case btnNext.Tag of
    BTN_NEXT   : begin
                   Inc(iStep);
                 end;
    BTN_AGREE  : begin
                   iStep := iStep;
                 end;
    BTN_FINISH : begin
                   DoFinish;
                 end;
  end;

  if Notebook.PageIndex = 0 then
    iStep := iStep + 2;

  Notebook.PageIndex := Notebook.PageIndex + iStep;

end;

procedure TFrmMain.SetPriorPage;
begin
  if (Notebook.PageIndex <> 0) then
    if Notebook.PageIndex = 3 then
      Notebook.PageIndex := Notebook.PageIndex - 3
    else
      Notebook.PageIndex := Notebook.PageIndex - 1;
end;

procedure TFrmMain.Start;
begin
  Notebook.PageIndex := 0;
  ImgSummary.Picture.Assign(ImgIntro.Picture);
  imgConnection.Picture.Assign(imgLicense.Picture);
  ImgChooser.Picture.Assign(imgLicense.Picture);
  BuildSoftwareList;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  Start;
end;

procedure TFrmMain.NotebookPageChanged(Sender: TObject);
begin

  if Notebook.ActivePage = 'pgIntro' then
     PageWelcome
//  else if Notebook.ActivePage = 'pgReadme' then
//  begin
//     PageReadme
//  end
//  else if Notebook.ActivePage = 'pgChooseSoftware' then
//     PageChooseComponent
  else if Notebook.ActivePage = 'pgInstallDir' then
  begin
     PageChooseComponent;
     PageChooseFolder;
  end
  else if Notebook.ActivePage = 'pgSummary' then
     PageResume;

end;

procedure TFrmMain.btnNextClick(Sender: TObject);
begin
  SetNextPage;
end;

procedure TFrmMain.btnBackClick(Sender: TObject);
begin
  SetPriorPage;
end;

procedure TFrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.BuildSoftwareList;
var
  i : integer;
  node : TTreeNode;
begin
  tvwSoftware.Items.Clear;

  for i := 0 to SoftwareList.Count-1 do
  begin
    node := tvwSoftware.Items.Add(nil, SoftwareList.Strings[i]);
    if TSoftwareInfo(SoftwareList.Objects[i]).ReadOnly then
      node.StateIndex := 3
    else
      node.StateIndex := 2;
  end;

end;

procedure TFrmMain.tvwSoftwareDblClick(Sender: TObject);
begin

  if tvwSoftware.Selected.StateIndex <> 3 then
    if tvwSoftware.Selected.StateIndex = 1 then
    begin
      tvwSoftware.Selected.StateIndex := 2;
      TotalFileSize := TotalFileSize + TSoftwareInfo(SoftwareList.Objects[SoftwareList.IndexOf(tvwSoftware.Selected.Text)]).SizeMB;
    end
    else
    begin
      if not TSoftwareInfo(SoftwareList.Objects[SoftwareList.IndexOf(tvwSoftware.Selected.Text)]).ReadOnly then
      begin
        tvwSoftware.Selected.StateIndex := 1;
        TotalFileSize := TotalFileSize - TSoftwareInfo(SoftwareList.Objects[SoftwareList.IndexOf(tvwSoftware.Selected.Text)]).SizeMB;
      end;
    end;

end;

procedure TFrmMain.DisplayDescription(Software: String);
var
  i : integer;
begin

  i := SoftwareList.IndexOf(Software);
  if i <> -1 then
    lbDescription.Caption := TSoftwareInfo(SoftwareList.Objects[i]).Description +
                             FormatFloat(' (0.00 MB)', TSoftwareInfo(SoftwareList.Objects[i]).SizeMB);

end;

procedure TFrmMain.tvwSoftwareClick(Sender: TObject);
begin
  DisplayDescription(tvwSoftware.Items.Item[tvwSoftware.Selected.Index].Text);
end;

function TFrmMain.DownloadFTPFile(var AFileSize: dWord;
  const AFileName, ASoftware: String): Boolean;
begin
  Result := False;

  with FTP do
  try
    AFileSize := Size(AFileName);
    if (AFileSize <> -1) then
    begin
      pbDownload.Max := AFileSize;
      lbResponse.Caption := 'Downloading ' + ASoftware;
      lbTimeLeft.Caption := 'Estimated download time: ' + ResultDownloadTime(Trunc(AFileSize)) + ' seconds';
      Application.ProcessMessages;
      Get(AFileName, GetInstallDir + AFileName, True);
      Result := True;
    end;
    Application.ProcessMessages;
  except
   on E: Exception do
     ShowMessage('Error ('+AFileName+'): ' + E.Message);
   end;
end;


function TFrmMain.DownloadFile(var AFileSize: dWord; Const Source, Dest: String; Const ToLabel: TLabel = Nil;
     Const PrgBar: TProgressBar = Nil; Software : String = ''): Boolean;
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: Array[0..1024] Of Char;
  BytesRead, Reserved: dWord;

  ReadFile: String;
  NumByte: Integer;
  FileSize: dWord;
begin
  ReadFile := '';
  ToLabel.Caption := sConnecting;
  Application.ProcessMessages;
  NetHandle := InternetOpen('Delphi 5.x', INTERNET_OPEN_TYPE_PRECONFIG, Nil, Nil, 0);

  if not DirectoryExists(GetInstallDir) then
    CreateDir(GetInstallDir);

  If Assigned(NetHandle) Then Begin
     UrlHandle := InternetOpenUrl(NetHandle, PChar(Source), Nil, 0, INTERNET_FLAG_RELOAD, 0);

     If Assigned(UrlHandle) Then
     begin
        If (ToLabel <> Nil) Or (PrgBar <> Nil) Then
        begin
           Buffer := '';
           FileSize := SizeOf(Buffer);
           Reserved := 0;
           If HttpQueryInfo(UrlHandle, HTTP_QUERY_CONTENT_LENGTH, @Buffer, FileSize, Reserved) Then
           begin
              FileSize  := StrToIntDef(Buffer, -1);
              AFileSize := FileSize;
          end;
        End;

        If ToLabel <> Nil Then
           ToLabel.Caption := '0 of 0 bytes';

        If PrgBar <> Nil Then
        begin
           PrgBar.Min := 0;
           PrgBar.Max := FileSize;
           PrgBar.Position := 0;
        End;

        FillChar(Buffer, SizeOf(Buffer), 0);
        Repeat
           FillChar(Buffer, SizeOf(Buffer), 0);
           InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
           For NumByte := 0 To BytesRead - 1 Do
              ReadFile := Concat(ReadFile, Buffer[NumByte]);

           If ToLabel <> Nil Then
              ToLabel.Caption := 'Downloading ' + Software + FormatFloat(' 0,000', Length(ReadFile)) + ' of ' + FormatFloat('0,000', FileSize) + ' bytes';
           If PrgBar <> Nil Then
              PrgBar.Position := PrgBar.Position + StrToInt(IntToStr(BytesRead));
           Application.ProcessMessages;
        Until BytesRead = 0;
        InternetCloseHandle(UrlHandle);
     End;
     InternetCloseHandle(NetHandle);
  End;

  ToLabel.Caption := '';
  Application.ProcessMessages;

  If Length(ReadFile) > 0 Then
     Begin
        If FileExists(Dest) Then
           DeleteFile(PChar(Dest));

        With TFileStream.Create(Dest, fmCreate) Do
           Try
              Write(ReadFile[1], Length(ReadFile));
           Finally
              Free;
           End;

        Result := True;
     End
        Else
     Result := False;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

  if not DirectoryExists(MR_INSTALL_DIR) then
    CreateDir(MR_INSTALL_DIR);

  if not DirectoryExists(GetInstallDir) then
    CreateDir(GetInstallDir);

  FDownloadedFile := TIniFile.Create(GetInstallDir+'\Downloaded.ini');
  SoftwareList := TStringList.Create;
  CreateSoftwareList;
  SetLang(1);

end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(SoftwareList);
end;

procedure TFrmMain.CreateSoftwareList;
var
  SoftwareInfo : TSoftwareInfo;
begin

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_MRPET;
  SoftwareInfo.FileDownload := 'MRPet.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_SYSTEMDLL;
  SoftwareInfo.FileDownload := 'SystemDLL.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_PETWIZARD;
  SoftwareInfo.FileDownload := 'MRWizard.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_PETSTARTUP;
  SoftwareInfo.FileDownload := 'MRPetStartUp.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_DATABASE;
  SoftwareInfo.FileDownload := 'Database.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_MRAPPSERVER;
  SoftwareInfo.FileDownload := 'MRAppServer.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_REPORT_INSTALLER;
  SoftwareInfo.FileDownload := 'MRReportInstall.exe';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_MAINREPORT;
  SoftwareInfo.FileDownload := 'MainReport.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  SoftwareInfo := TSoftwareInfo.Create;
  SoftwareInfo.Software     := SOFTWARE_IMPEXP;
  SoftwareInfo.FileDownload := 'MRImportExport.zip';
  SoftwareInfo.ReadOnly     := True;
  SoftwareInfo.WWW          := HTTP_DOWNLOAD;
  SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);

  if not DetectLocalSQL then
  begin
    SoftwareInfo := TSoftwareInfo.Create;
    SoftwareInfo.Software     := SOFTWARE_MSDE;
    SoftwareInfo.FileDownload := 'MSDE.zip';
    SoftwareInfo.ReadOnly     := True;
    SoftwareInfo.WWW          := HTTP_DOWNLOAD_SQL;
    SoftwareList.AddObject(SoftwareInfo.Software, SoftwareInfo);
  end;

  TotalFileSize := 0;

end;

function TFrmMain.DetectLocalSQL: Boolean;
var
  Reg : TRegistry;
begin

  Reg := TRegistry.Create;
  Try
     Reg.RootKey := HKEY_LOCAL_MACHINE;
     Result      := Reg.KeyExists(SQL_REG_PATH);
  Finally
     Reg.CloseKey;
     Reg.Free;
    end;

end;

function TFrmMain.ExtractZipFile(sSourceFile, sDestDir: String): Boolean;
begin
  lbResponse.Caption := sExtracting + sSourceFile;
  lbTimeLeft.Caption := '';
  Application.ProcessMessages;

  Result := True;

  try
    with UnZip do
    begin
      BaseDirectory := sDestDir;
      FileName      := sSourceFile;
      ExtractFiles('*.*');
      CloseArchive;
    end;
  except
    raise;
    Result := False;
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

function TFrmMain.RegisterDLLs: Boolean;
var
  FileName : String;
begin

  Result := True;

  try
    FileName := MR_INSTALL_DIR+'\midas.dll';
    if FileExists(FileName) then
     ShellExecute(handle, 'open', 'regsvr32.exe', PChar(QuotedStr(FileName+' /s')), nil, 1);

    FileName := MR_INSTALL_DIR+'\Roboex32.dll';
    if FileExists(FileName) then
     ShellExecute(handle, 'open', 'regsvr32.exe', PChar(QuotedStr(FileName+' /s')), nil, 1);
     
  except
    raise;
    Result := False;
    end;

end;

function TFrmMain.StartInstall: Boolean;
var
  FileName : String;
begin
   Result := True;
   FileName := MR_INSTALL_DIR + '\MRPetStartUp.exe';
   if FileExists(FileName) then
     ShellExecute(handle, 'open', PChar(FileName), nil, nil, 1);
end;

function TFrmMain.FileDownloaded(ASoftware: String): Boolean;
begin
  Result := FDownloadedFile.ReadBool('Software', ASoftware, False);
end;

function TFrmMain.SaleDownload(ASoftware: String): Boolean;
begin
  Result := True;
  FDownloadedFile.WriteBool('Software', ASoftware, True);
end;

function TFrmMain.SelfDelete: Boolean;
  function GetTmpDir: string;
  var
    pc: PChar;
  begin
    pc := StrAlloc(MAX_PATH + 1);
    GetTempPath(MAX_PATH, pc);
    Result := string(pc);
    StrDispose(pc);
  end;

  function GetTmpFileName(ext: string): string;
  var
    pc: PChar;
  begin
    pc := StrAlloc(MAX_PATH + 1);
    GetTempFileName(PChar(GetTmpDir), 'uis', 0, pc);
    Result := string(pc);
    Result := ChangeFileExt(Result, ext);
    StrDispose(pc);
  end;

var
  batchfile: TStringList;
  batchname: string;
begin
  Result := True;
  FreeAndNil(FDownloadedFile);

  if not FileExists(GetInstallDir+'\Downloaded.ini') then
    MRDeleteFile(GetInstallDir+'\Downloaded.ini');

  if FileExists(GetInstallDir+'\FilesSize.ini') then
    MRDeleteFile(GetInstallDir+'\FilesSize.ini');

  batchname := GetTmpFileName('.bat');
  FileSetAttr(ParamStr(0), 0);
  batchfile := TStringList.Create;
  with batchfile do
  begin
    try
      Add(':Label1');
      Add('del "' + ParamStr(0) + '"');
      Add('if Exist "' + ParamStr(0) + '" goto Label1');
      Add('rmdir "' + ExtractFilePath(ParamStr(0)) + '"');
      Add('del ' + batchname);
      SaveToFile(batchname);
      ChDir(GetTmpDir);
      ShellExecute(0, 'open', PChar(batchname), nil, nil, SW_HIDE);
     // WinExec(PChar(batchname), SW_HIDE); {maynot work in win98}
    finally
      batchfile.Free;
    end;
    Halt;
  end;
end;

procedure TFrmMain.SetLang(IDLang: Integer);
var
  i : integer;
begin
  siLangDispatcher.ActiveLanguage := IDLang;

  case siLangDispatcher.ActiveLanguage of
  1 : begin
      sNext          := 'Next >>';
      sIAgree        := 'I Agree';
      sFinish        := 'Download';
      sConnecting    := 'Connecting...';
      sMSDE          := 'Microsoft SQL Server database tool';
      sPetStartUp    := 'Start-up installation';
      sDll           := 'System Dynamic-link library';
      sDB            := 'Empty database';
      sMRPet         := 'Pet Center';
      sAppServer     := 'Application Server';
      sReports       := 'Reports tools';
      sReportsInstall:= 'Report installation tool';
      sImportExport  := 'Import-Export Vendor files ';
      sExtracting    := 'Extracting file ';
      sPetWizard     := 'Wizard';
      end;

  2 : begin
      sNext          := 'Próximo >>';
      sIAgree        := 'Concordo';
      sFinish        := 'Download';
      sConnecting    := 'Conectando ...';
      sMSDE          := 'Microsoft SQL Server ferramenta de banco de dados';
      sPetStartUp    := 'Instalador do sistema';
      sDll           := 'Bibliotecas do sistema DLL (Dynamic-link library)';
      sDB            := 'Banco de dados vazio';
      sMRPet         := 'Pet Center';
      sAppServer     := 'Application Server';
      sReports       := 'Ferramenta de relatórios';
      sReportsInstall:= 'Ferramenta de relatórios';
      sImportExport  := 'Import Export Tool';
      sExtracting    := 'Extraindo arquivo ';
      sPetWizard     := 'Assistente';
      end;

  3 : begin
      sNext          := 'Después >>';
      sIAgree        := 'Convengo ';
      sFinish        := 'Download';
      sConnecting    := 'Conectando ...';
      sMSDE          := 'Microsoft SQL Server herramienta de la base de datos';
      sPetStartUp    := 'Herramienta de la instalación';
      sDll           := 'Biblioteca del Dinámico-acoplamiento DLL';
      sDB            := 'Base de datos vacía';
      sMRPet         := 'Pet Center';
      sAppServer     := 'Application Server';
      sReports       := 'Herramientas de los informes';
      sReportsInstall:= 'Herramientas de los informes';
      sImportExport  := 'Import Export Tool';
      sExtracting    := 'Extraer el archivo ';
      sPetWizard     := 'Assistente';
      end;
  end;

  for i := 0 to SoftwareList.Count-1 do
  begin
    if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_MSDE then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sMSDE
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_PETSTARTUP then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sPetStartUp
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_SYSTEMDLL then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sDll
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_DATABASE then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sDB
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_MRPET then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sMRPet
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_MRAPPSERVER then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sAppServer
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_MAINREPORT then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sReports
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_REPORT_INSTALLER then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sReportsInstall
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_IMPEXP then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sImportExport
    else if TSoftwareInfo(SoftwareList.Objects[i]).Software = SOFTWARE_PETWIZARD then
      TSoftwareInfo(SoftwareList.Objects[i]).Description := sPetWizard;
  end;



end;

procedure TFrmMain.cbxLanguageChange(Sender: TObject);
begin
  SetLang(cbxLanguage.ItemIndex+1);
end;

procedure TFrmMain.DownloadFilesSize;
var
  wwwFile : String;
  bResult : Boolean;
  AFile : String;
  FFilesSize : TIniFile;
  FileSize : dWord;
  i : Integer;
begin

  AFile   := 'FilesSize.ini';
  wwwFile := HTTP_DOWNLOAD + AFile;

  if FileExists(GetInstallDir +'\'+ AFile) then
    DeleteFile(GetInstallDir +'\'+ AFile);

  bResult := DownloadFile(FileSize, wwwFile, GetInstallDir +'\'+ AFile, nil, nil, '');

  if TotalFileSize = 0 then
    try
      FFilesSize := TIniFile.Create(GetInstallDir+'\FilesSize.ini');
      if bResult then
        begin
          for i := 0 to SoftwareList.Count-1 do
          begin
            if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MSDE.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MSDE.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MRPetStartUp.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MRPetStartUp.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'SystemDLL.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'SystemDLL.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'Database.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'Database.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MRPet.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MRPet.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MRAppServer.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MRAppServer.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MainReport.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MainReport.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MRImportExport.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MRImportExport.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MRWizard.zip' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MRWizard.zip', 0)
            else if TSoftwareInfo(SoftwareList.Objects[i]).FileDownload = 'MRReportInstall.exe' then
              TSoftwareInfo(SoftwareList.Objects[i]).SizeMB := FFilesSize.ReadFloat('Software', 'MRReportInstall.exe', 0);
            TotalFileSize := TotalFileSize + TSoftwareInfo(SoftwareList.Objects[i]).SizeMB;
          end;
        end;
    finally
      FreeAndNil(FFilesSize);
    end;
end;


function TFrmMain.FTPConnect: Boolean;
begin

  with FTP do
  begin
   Host     := 'portal.pinogy.com';
   Port     := 21;
   Username := 'mainretail';
   Password := 'main2005retail';
   try
      if not Connected then
        Connect(True, -1);
      Result := True;
   except
     Result := False;
   end;
  end

end;

procedure TFrmMain.FTPDisconnect;
begin
  if FTP.Connected then
    FTP.Disconnect;
end;

procedure TFrmMain.FTPWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  pbDownload.Position := AWorkCount;
end;

function TFrmMain.InstallReport: Boolean;
begin

  Result := True;
  
  {
  try
    WaitExecute(GetInstallDir + MR_REPORT_INSTALL);

    Sleep(0);
    Application.ProcessMessages;

    MRDeleteFile(GetInstallDir + MR_REPORT_INSTALL);
    Result := True;

  except
    Result := False;
  end;
  }

end;

function TFrmMain.MoveTempFiles: Boolean;
begin
  try
    CopyFolder(GetInstallDir + '*.*', MR_INSTALL_DIR, FO_MOVE, True, False);
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmMain.ResultDownloadTime(ADLTime : Integer): String;
var
  Rec: TDRec;
begin

  Rec := CalculateDLTime(ADLTime, 1, cbxInternetSpeed.ItemIndex);

  Result := '';

  if Rec.H <> 0 then
    Result := IntToStr(Rec.H) + ':';
  if Rec.M <> 0 then
    Result := Result + IntToStr(Rec.M) + ':';
  if Rec.S <> 0 then
    Result := Result + IntToStr(Rec.S);

end;

function TFrmMain.CalculateDLTime(const Value, Units, Connection: Integer): TDRec;
var
  i, size_bits, filedltimesec, hourmod, HH, MM, SS: Integer;

  Rec: TDRec;

  function pow(a, b: Integer): Integer;
    function sl(nr, times: Integer): Integer;
    var
      i: Integer;
    begin
      Result := nr * nr;
      for i := 0 to times do Result := Result + nr * nr;
    end;
  begin
    if a > b then Result := sl(a, b)
    else 
      Result := sl(b, a);
  end;
begin
  case Units of
    1: size_bits := (8 div 1) * Value;                           // bytes
    2: size_bits := (8 div 1) * ((pow(2,10)) div 1) * Value;     // kilobytes
    3: size_bits := (8 div 1) * ((pow(2,20)) div 1) * Value;     // Megabytes
  end;

  // Calculate
  filedltimesec := Round(size_bits) div BpsArray[Connection];

  hourmod := filedltimesec mod (60 * 60);  // Modulus.
  HH      := Floor(filedltimesec / (60 * 60));
  MM      := Floor(hourmod / 60);
  SS      := Floor(filedltimesec mod 60);  // Modulus.

  if SS > 0 then Inc(SS);

  with Rec do
  begin
    H := HH;
    M := MM;
    S := SS;
  end;

  Result := Rec;

end;

function TFrmMain.GetInstallDir: String;
begin
  Result := edtFolder.Text + 'temp\';
end;

end.
