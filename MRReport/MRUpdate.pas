unit MRUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, DBClient, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, {Internet Download}Wininet, ComCtrls, IniFiles,
  AbBase, AbBrowse, AbZBrows, AbUnzper, CommDlg, AbUtils, siComp;

type
  TUpdateFrm = class(TForm)
    pnlButton: TPanel;
    Bevel1: TBevel;
    btnClose: TBitBtn;
    pnlDownload: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    btnUpdate: TBitBtn;
    gridReportsDBTableView1: TcxGridDBTableView;
    gridReportsLevel1: TcxGridLevel;
    gridReports: TcxGrid;
    cdsReports: TClientDataSet;
    dsReports: TDataSource;
    cdsReportsID: TIntegerField;
    cdsReportsReportName: TStringField;
    cdsReportsDescription: TMemoField;
    cdsReportsImage: TStringField;
    cdsReportsVersion: TStringField;
    cdsReportsFolder: TStringField;
    cdsReportsFile: TStringField;
    gridReportsDBTableView1ReportName: TcxGridDBColumn;
    gridReportsDBTableView1Description: TcxGridDBColumn;
    gridReportsDBTableView1Version: TcxGridDBColumn;
    gridReportsDBTableView1Folder: TcxGridDBColumn;
    Image2: TImage;
    ProgressBar: TProgressBar;
    btnStartUpdate: TBitBtn;
    lbReportsInfo: TLabel;
    cdsReportsUrl: TStringField;
    AbUnZipper: TAbUnZipper;
    siLang: TsiLang;
    procedure btnUpdateClick(Sender: TObject);
    procedure btnStartUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    sRepDownload,
    sRepUpdated,
    sDownload,
    sNDownload : String;

    FWebFileVersion : String;
    FLocalPath : String;
    FTempFileVersion : String;
    FFileVersion : TIniFile;
    FLocalFileVersion : TIniFile;

    function HasUpdate : Boolean;
    function CreateTempFolder:Boolean;
    function DownloadFileVersion:Boolean;
    function LoadFileVersion: Boolean;

    function DownloadReports:Boolean;
    function DownloadReport(URL, ZipFile: String):Boolean;
    function ExtractReport(ZipFile: String):Boolean;
    function CopyReport(RepFile, DestRep, ImgFile, DestImage : String):Boolean;
    function UpdateVersion(RepFile, Description, Version, Image : String) : Boolean;
    function DeleteTempDir: Boolean;

    function GetInetFile(const FileURL, FileName: String): boolean;
  public
    function Start:Boolean;
  end;

implementation

uses uFileFunctions, uWebFunctions, uDMReport, uDMGlobal;

{$R *.dfm}

{ TFrmUpdate }

function TUpdateFrm.Start: Boolean;
begin
  FLocalPath       := DMReport.FAppPath;
  FTempFileVersion := FLocalPath + 'Temp\versioncontrol.ini';
  FWebFileVersion  := DMReport.GetAppProperty('Default', 'UpdateFile');

  cdsReports.CreateDataSet;
  ShowModal;
  Result := True;
end;

procedure TUpdateFrm.btnUpdateClick(Sender: TObject);
begin
  if HasUpdate then
  begin
    gridReports.Visible    := True;
    btnStartUpdate.Visible := True;
    btnUpdate.Visible      := False;
    lbReportsInfo.Caption  := Format(sRepDownload, [cdsReports.RecordCount]);
    lbReportsInfo.Visible  := True;
  end
  else
  begin
    btnUpdate.Visible      := False;
    lbReportsInfo.Caption  := sRepUpdated;
    lbReportsInfo.Visible  := True;
  end;
end;

function TUpdateFrm.DownloadFileVersion : Boolean;
begin
  Result := True;
  try
    if CreateTempFolder then
      if GetInetFile(FWebFileVersion, FTempFileVersion) then
        Result := LoadFileVersion;
  except
    Result := False;
    end;
end;

function TUpdateFrm.HasUpdate: Boolean;
begin
  Result := False;
  if DownloadFileVersion then
    Result := True;
end;

function TUpdateFrm.CreateTempFolder: Boolean;
begin
  Result := True;
  if not DirectoryExists(FLocalPath + 'Temp') then
    Result := CreateDir(FLocalPath + 'Temp');
end;

function TUpdateFrm.LoadFileVersion: Boolean;
var
  FSection : TStringList;
  i : Integer;
begin

  try
  
    if not Assigned(FFileVersion) then
      FFileVersion := TIniFile.Create(FTempFileVersion);

    FSection := TStringList.Create;
    try
      FFileVersion.ReadSections(FSection);

      for i := 0 to FSection.Count-1 do
        if not FLocalFileVersion.SectionExists(FSection.Strings[i]) or
           (FLocalFileVersion.SectionExists(FSection.Strings[i]) and (FFileVersion.ReadString(FSection.Strings[i], 'Version', '') <> FLocalFileVersion.ReadString(FSection.Strings[i], 'Version', ''))) then
        begin
        with cdsReports do
          begin
          Append;
          FieldByName('ID').AsInteger         := (RecordCount+1);
          FieldByName('ReportName').AsString  := FSection.Strings[i];
          FieldByName('Description').AsString := FFileVersion.ReadString(FSection.Strings[i], 'Description', '');
          FieldByName('Image').AsString       := FFileVersion.ReadString(FSection.Strings[i], 'Image', '');
          FieldByName('Version').AsString     := FFileVersion.ReadString(FSection.Strings[i], 'Version', '');
          FieldByName('Folder').AsString      := FFileVersion.ReadString(FSection.Strings[i], 'Folder', '');
          FieldByName('File').AsString        := FFileVersion.ReadString(FSection.Strings[i], 'File', '');
          FieldByName('Url').AsString         := FFileVersion.ReadString(FSection.Strings[i], 'Url', '');
          Post;
          end;
        end;

    cdsReports.First;
    Result := (not cdsReports.IsEmpty);

    finally
      FreeAndNil(FSection);
      end;
  except
    Result := False;
    end;

end;

function TUpdateFrm.GetInetFile(const fileURL, FileName: String): Boolean;
  const BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: File;
  sAppName: string;
begin

 Result   := False;

 sAppName := ExtractFileName(Application.ExeName);
 hSession := InternetOpen(PChar(sAppName),
                INTERNET_OPEN_TYPE_PRECONFIG,
               nil, nil, 0);

 try
  hURL := InternetOpenURL(hSession,
            PChar(fileURL),
            nil,0,0,0);
  try
   AssignFile(f, FileName);
   Rewrite(f,1);
   ProgressBar.Visible := True;
   ProgressBar.Max     := BufferLen;
   Application.ProcessMessages;
   repeat
    InternetReadFile(hURL, @Buffer,
                     SizeOf(Buffer), BufferLen);
    BlockWrite(f, Buffer, BufferLen);
    ProgressBar.Position := ProgressBar.Max - BufferLen;
    Application.ProcessMessages;
   until BufferLen = 0;
   CloseFile(f);
   Result := True;
  finally
   ProgressBar.Visible := False;
   Application.ProcessMessages;
   InternetCloseHandle(hURL);
  end
 finally
  InternetCloseHandle(hSession);
 end;

end;


procedure TUpdateFrm.btnStartUpdateClick(Sender: TObject);
begin
  try
    btnClose.Enabled       := False;
    btnStartUpdate.Visible := False;
    DownloadReports;
  finally
    btnClose.Enabled := True;
  end;
end;

procedure TUpdateFrm.FormCreate(Sender: TObject);
begin
  FLocalFileVersion := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  case DMreport.LanguageDispatcher.ActiveLanguage of
  LANG_ENGLISH    : begin
                      sRepDownload := '%D Report(s) to download';
                      sRepUpdated  := 'The reports are updated. There is no updated at this time!';
                      sDownload    := 'Download (%D) of (%D) ';
                      sNDownload   := '%D report(s) updated ';
                    end;
  LANG_PORTUGUESE : begin
                      sRepDownload := '%D Relatório(s) para atualizar';
                      sRepUpdated  := 'Seus relatórios estão atualizados. Não há nenhuma atualização no momento!';
                      sDownload    := 'Download (%D) de (%D) ';
                      sNDownload   := '%D relatório(s) atualizados ';
                    end;
  LANG_SPANISH    : begin
                      sRepDownload := '%D Informe(s) to download';
                      sRepUpdated  := 'Los informes son actualizados. No hay actualizado en este tiempo!';
                      sDownload    := 'Download (%D) of (%D) ';
                      sNDownload   := '%D Informe(s) actualizados ';
                    end;
  end;

end;

procedure TUpdateFrm.FormDestroy(Sender: TObject);
begin

  FreeAndNil(FLocalFileVersion);

  if Assigned(FFileVersion) then
     FreeAndNil(FFileVersion);

end;

function TUpdateFrm.DownloadReports: Boolean;
begin

  Result := True;
  with cdsReports do
    if Active and (not isEmpty) then
    begin
      DisableControls;
      First;
      While not EOF do
      begin
        lbReportsInfo.Caption := Format(sDownload, [RecNo, RecordCount]);
        Application.ProcessMessages;

        //Download
        Result := DownloadReport(FieldByName('Url').AsString, FieldByName('File').AsString);
        Result := True;

        //Extract
        if Result then
          Result := ExtractReport(FieldByName('File').AsString);

        //Copy File
        if Result then
          Result := CopyReport(FieldByName('ReportName').AsString,
                               FieldByName('Folder').AsString,
                               FieldByName('Image').AsString,
                               DMReport.GetAppProperty('Settings','ImageDir'));

        //Update
        if Result then
          Result := UpdateVersion(FieldByName('ReportName').AsString,
                                  FieldByName('Description').AsString,
                                  FieldByName('Version').AsString,
                                  FieldByName('Image').AsString);

        //Del temp folder
        DeleteTempDir;

        if not Result then
          Exit;
        Next;
      end;
      EnableControls;

    lbReportsInfo.Caption := Format(sNDownload, [RecordCount]);
    Application.ProcessMessages;
    end;
end;

function TUpdateFrm.DownloadReport(URL, ZipFile: String): Boolean;
var
  AFileURL,
  AFileLocal,
  ADir  : String;
begin

  try
    ADir := FLocalPath + 'Temp';
    AFileLocal := ADir + '\' + ZipFile;

    AFileURL := URL + ZipFile;

    if not DirectoryExists(ADir) then
      CreateDir(ADir);

    Result := GetInetFile(AFileURL, AFileLocal);

  except
    Result := False;
    end;

end;

function TUpdateFrm.DeleteTempDir : Boolean;
begin
  Result := True;
  if DirectoryExists(FLocalPath + 'Temp') then
    Result := DelTree(FLocalPath + 'Temp');
end;


function TUpdateFrm.ExtractReport(ZipFile: String): Boolean;
var
  ADir : String;
  ALocalFile : String;
begin
  Result := True;

  ALocalFile := FLocalPath + 'Temp\' + ZipFile;
  ADir       := ExtractFilePath(ALocalFile);

  if not DirectoryExists(ADir) then
    CreateDir(ADir);

  if FileExists(ALocalFile) then
    with AbUnZipper do
    begin
      FileName      := ALocalFile;
      BaseDirectory := ADir;
      ExtractFiles('*.*');
      CloseArchive;
    end;

end;

function TUpdateFrm.CopyReport(RepFile, DestRep, ImgFile,
    DestImage : String): Boolean;
var
  FOriFileName,
  FDestFileName : TFileName;
begin

  try
    Result := True;

    FOriFileName  := FLocalPath + 'Temp\' + RepFile + '.rpt';
    FDestFileName := FLocalPath + DestRep +'\'+ RepFile + '.rpt';

    if not DirectoryExists(FLocalPath + DestRep) then
      CreateDir(FLocalPath + DestRep);

    MoveFile(PChar(FOriFileName), PChar(FDestFileName));

    if FileExists(FOriFileName) then
      DeleteFile(PChar(FOriFileName));

    if not DirectoryExists(FLocalPath + DestImage) then
      CreateDir(FLocalPath + DestImage);

    FOriFileName  := FLocalPath + 'Temp\' + ImgFile;
    FDestFileName := FLocalPath + DestImage + ImgFile;
    //FDestFileName := FLocalPath + DestImage + '\' + ImgFile;

    MoveFile(PChar(FOriFileName), PChar(FDestFileName));

    if FileExists(FOriFileName) then
      DeleteFile(PChar(FOriFileName));
      
  except
    Result := False;
    end;

end;

function TUpdateFrm.UpdateVersion(RepFile, Description, Version,
  Image: String): Boolean;
begin
  try
    Result := True;
    FLocalFileVersion.WriteString(RepFile, 'Description', Description);
    FLocalFileVersion.WriteString(RepFile, 'Version', Version);
    FLocalFileVersion.WriteString(RepFile, 'Image', Image);
  except
    Result := False;
    end;
end;

procedure TUpdateFrm.btnCloseClick(Sender: TObject);
begin
  //Del temp folder
  DeleteTempDir;
end;

end.
