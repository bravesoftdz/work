unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Wininet, IniFiles,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP;

const
  MR_DIR = 'C:\Program Files\MainRetail\Suporte';
  HTTP_DOWNLOAD = 'http://www.mainretail.com/download/';


type
  TFrmMain = class(TForm)
    ImgIntro: TImage;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pbDownload: TProgressBar;
    lbDownload: TLabel;
    imgDownloadMR: TImage;
    imgSkype: TImage;
    pbSkype: TProgressBar;
    lbSkype: TLabel;
    imgInstallLogmein: TImage;
    Label5: TLabel;
    Label6: TLabel;
    FTP: TIdFTP;
    rbServer: TRadioButton;
    rbClient: TRadioButton;
    Label7: TLabel;
    procedure imgDownloadMRClick(Sender: TObject);
    procedure imgSkypeClick(Sender: TObject);
    procedure imgInstallLogmeinClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure FTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
  private
    FDownloadedFile : TIniFile;
    function DownloadFileWWW(var AFileSize: dWord; Const Source, Dest: String; Const ToLabel: TLabel = Nil;
      Const PrgBar: TProgressBar = Nil; Software : String = ''): Boolean;
    function FileDownloaded(ASoftware: String): Boolean;
    function SaleDownload(ASoftware: String): Boolean;

    function FTPConnect : Boolean;
    procedure FTPDisconnect;
    function DownloadFileFTP(var AFileSize: dWord; Const Source, Dest: String; Const ToLabel: TLabel = Nil;
      Const PrgBar: TProgressBar = Nil; Software : String = ''): Boolean;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Registry, shellapi, shlobj, uWebFunctions, uFileFunctions;


{$R *.dfm}

function TFrmMain.DownloadFileWWW(var AFileSize: dWord; const Source,
  Dest: String; const ToLabel: TLabel; const PrgBar: TProgressBar;
  Software: String): Boolean;
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
  ToLabel.Caption := 'Conectando ...';
  Application.ProcessMessages;
  NetHandle := InternetOpen('Delphi 5.x', INTERNET_OPEN_TYPE_PRECONFIG, Nil, Nil, 0);

  if not DirectoryExists(ExtractFileDir(Dest)) then
    CreateDir(ExtractFileDir(Dest));

  If Assigned(NetHandle) Then
  begin
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
        begin
           ToLabel.Caption := '0 de 0 bytes';
           ToLabel.Visible := True;
        end;

        If PrgBar <> Nil Then
        begin
           PrgBar.Min := 0;
           PrgBar.Max := FileSize;
           PrgBar.Position := 0;
           PrgBar.Visible := True;
        End;

        FillChar(Buffer, SizeOf(Buffer), 0);
        Repeat
           FillChar(Buffer, SizeOf(Buffer), 0);
           InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
           For NumByte := 0 To BytesRead - 1 Do
              ReadFile := Concat(ReadFile, Buffer[NumByte]);

           If ToLabel <> Nil Then
              ToLabel.Caption := 'Baixando ' + Software + FormatFloat(' 0,000', Length(ReadFile)) + ' de ' + FormatFloat('0,000', FileSize) + ' bytes para "' + Dest + '"';
           If PrgBar <> Nil Then
              PrgBar.Position := PrgBar.Position + StrToInt(IntToStr(BytesRead));
           Application.ProcessMessages;
        Until BytesRead = 0;
        InternetCloseHandle(UrlHandle);
     End;
     InternetCloseHandle(NetHandle);
  End;

  ToLabel.Caption := '';
  PrgBar.Visible := False;
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

function TFrmMain.FileDownloaded(ASoftware: String): Boolean;
begin
  Result := FDownloadedFile.ReadBool('Software', ASoftware, False);
end;

function TFrmMain.SaleDownload(ASoftware: String): Boolean;
begin
  Result := True;
  FDownloadedFile.WriteBool('Software', ASoftware, True);
end;


procedure TFrmMain.imgDownloadMRClick(Sender: TObject);
var
  www : String;
  FileSize: dWord;
  FileDownload, ListedSoftware : String;
  bResult : Boolean;
begin

  rbServer.Enabled := False;
  rbClient.Enabled := False;

  try

    //HTTP
    ListedSoftware := 'MainRetail';
    if not FileDownloaded(ListedSoftware) then
    begin
      www := HTTP_DOWNLOAD + 'UpdatePack4.zip';
      FileDownload := MR_DIR + '\' + 'UpdatePack4.zip';
      bResult := DownloadFileWWW(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
      if bResult then
        SaleDownload(ListedSoftware);
    end;

    ListedSoftware := 'PDV';
    if not FileDownloaded(ListedSoftware) then
    begin
      www := HTTP_DOWNLOAD + 'CashRegister.zip';
      FileDownload := MR_DIR + '\' + 'CashRegister.zip';
      bResult := DownloadFileWWW(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
      if bResult then
        SaleDownload(ListedSoftware);
    end;

    ListedSoftware := 'POSServer';
    if not FileDownloaded(ListedSoftware) then
    begin
      www := HTTP_DOWNLOAD + 'POSServer.zip';
      FileDownload := MR_DIR + '\' + 'POSServer.zip';
      bResult := DownloadFileWWW(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
      if bResult then
        SaleDownload(ListedSoftware);
    end;

    if rbClient.Checked then
    begin
      ListedSoftware := 'MRReport';
      if not FileDownloaded(ListedSoftware) then
      begin
        www := HTTP_DOWNLOAD + 'MRReport.zip';
        FileDownload := MR_DIR + '\' + 'MRReport.zip';
        bResult := DownloadFileWWW(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
        if bResult then
          SaleDownload(ListedSoftware);
      end;
    end;

    //FTP
    if rbServer.Checked then
    begin
      ListedSoftware := 'Instalador';
      if not FileDownloaded(ListedSoftware) then
      begin
        www := 'Instalador.zip';
        FileDownload := MR_DIR + '\' + 'Instalador.zip';
        bResult := DownloadFileFTP(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
        if bResult then
          SaleDownload(ListedSoftware);
      end;

      ListedSoftware := 'MRReport';
      if not FileDownloaded(ListedSoftware) then
      begin
        www := 'MRReportInstall.exe';
        FileDownload := MR_DIR + '\' + 'MRReportInstall.exe';
        bResult := DownloadFileFTP(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
        if bResult then
          SaleDownload(ListedSoftware);
      end;

      ListedSoftware := 'SQL Server (MSDE)';
      if not FileDownloaded(ListedSoftware) then
      begin
        www := 'MSDE.zip';
        FileDownload := MR_DIR + '\' + 'MSDE.zip';
        bResult := DownloadFileFTP(FileSize, www, FileDownload, lbDownload, pbDownload, ListedSoftware);
        if bResult then
          SaleDownload(ListedSoftware);
      end;
    end;

  finally
    lbDownload.Caption := 'Operação concluída.';
    lbDownload.Visible := True;
    pbDownload.Visible := False;
    FTPDisconnect;
  end;

end;


procedure TFrmMain.imgSkypeClick(Sender: TObject);
var
  www : String;
  FileSize: dWord;
  FileDownload, ListedSoftware : String;
begin

  try
    www := HTTP_DOWNLOAD + 'SkypeSetup.exe';
    FileDownload := MR_DIR + '\' + 'SkypeSetup.exe';
    ListedSoftware := 'Skype';
    DownloadFileWWW(FileSize, www, FileDownload, lbSkype, pbSkype, ListedSoftware);
  finally
    lbSkype.Caption := 'Operação concluída.';
    pbSkype.Visible := False;
  end;

end;

procedure TFrmMain.imgInstallLogmeinClick(Sender: TObject);
begin
  OpenURL('http://www.mainretail.com.br/logmein.htm');
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FDownloadedFile := TIniFile.Create(MR_DIR+'\Downloaded.ini');
  if not DirectoryExists('C:\Program Files\MainRetail') then
    CreateDir('C:\Program Files\MainRetail');
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FDownloadedFile);
end;

procedure TFrmMain.Label5Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.Label2Click(Sender: TObject);
begin
  OpenURL('http://www.mainretail.com.br');
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
  Application.ProcessMessages;
end;

function TFrmMain.DownloadFileFTP(var AFileSize: dWord; const Source,
  Dest: String; const ToLabel: TLabel; const PrgBar: TProgressBar;
  Software: String): Boolean;
begin

  ToLabel.Caption := 'Conectando ...';
  PrgBar.Visible := True;
  ToLabel.Visible := True;
  Application.ProcessMessages;

  if not DirectoryExists(MR_DIR) then
    CreateDir(MR_DIR);

  if not FileExists(Dest) then
    FileClose(FileCreate(Dest));

  if FTPConnect then
  begin
    with FTP do
    try
      AFileSize := Size(Source);

      if (AFileSize <> -1) then
      begin
        PrgBar.Min := 0;
        PrgBar.Position := 0;
        PrgBar.Max := AFileSize;
        ToLabel.Caption := 'Baixando ' + Software + ' para ' + Dest;
        Application.ProcessMessages;
        Get(Source, Dest, True);
      end;
      Result := True;
      Application.ProcessMessages;
    except
     on E: Exception do
       ShowMessage('Erro ('+Source+'): ' + E.Message);
     end;
  end
  else
    ShowMessage('Erro: Não foi possível baixar os arquivos!');


  PrgBar.Visible := False;
  ToLabel.Visible := False;
  Application.ProcessMessages;

end;


end.
