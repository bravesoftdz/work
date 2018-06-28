unit uFrmNewLoader;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ComCtrls, ExtCtrls, registry, Db, ADODB, ImgList,
  Buttons, inifiles, jpeg, shellapi, shlobj, uDMGlobal,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP,
  AbBase, AbBrowse, AbZBrows, AbUnzper, AbMeter, siComp;

type
  TFiles = record
    ModuleZipName : String;
    ExecName      : String;
    Description   : String;
    Build         : Integer;
    IndexNo       : Integer;
  end;

const
  STATUS_OPEN     = 0;
  STATUS_NEW      = 1;
  STATUS_DOWNLOAD = 2;
  STATUS_EXTRACT  = 3;
  STATUS_DELETE   = 4;

  SECTION_FILES       = 'Files';
  SECTION_SETTING     = 'Setting';
  VALUES_ASK_DOWNLOAD = 'askDownload';

type
  TFrmNewLoader = class(TForm)
    pnlDowload: TPanel;
    lblMSG: TLabel;
    imgStatus: TImageList;
    sbCancel: TSpeedButton;
    lbSoftware: TLabel;
    Timer: TTimer;
    lbError: TLabel;
    IdFTP: TIdFTP;
    UnZip: TAbUnZipper;
    AbVCLMeterLink: TAbVCLMeterLink;
    PB: TProgressBar;
    pnlSoftware: TPanel;
    TreeSoftware: TTreeView;
    Label2: TLabel;
    pnlSoftwareList: TPanel;
    lbCheckSoftware: TLabel;
    lstSoftware: TCheckListBox;
    btnDownload: TSpeedButton;
    aniTransfer: TAnimate;
    lbRate: TLabel;
    pbExtract: TAbMeter;
    siLang1: TsiLang;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure IdFTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure IdFTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdFTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdFTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure UnZipConfirmOverwrite(var Name: String;
      var Confirm: Boolean);
  private
    { Private declarations }
    Reg : TRegistry;

    sNewVersion,
    sDownload,
    sSostInfo,
    sClientLogin,
    sInvalidLog,
    sExtract,
    sUpdateV,
    sExtFile,
    sDelOld,
    sInit,
    sNoCustomer,
    sDelerror : String;

    sCustomerFile,
    sCustomerID : String;
    bAskDownload : Boolean;

    sFTPServer, sFTPPort, sFTPUser, sFTPPW, sResult : String; //Sever info.

    sLocalPath : String;

    aDownloadFiles : array [0..10] of TFiles;
    iCounted : integer;

    iSoftwarePos : Integer;
    Node, MyTreeNode : TTreeNode;

    Exec: array[0..255] of char;

    procedure RunProgram;
    function CanDownload:Boolean;
    function MarkedforDownload(Desc:String):Boolean;
    procedure BuildSoftwareList;
    procedure FinalizeDisplay;

    function GetServerInfo:Boolean;
    function GetClientSoftwareList:Boolean;
    function GetServerFiles:Boolean;
    function DownloadFile(sSvrFile, sLocalFile:String):Boolean;
    function ExtracFile(sFile:String):Boolean;
    function DeleteFiles:Boolean;
    function DeletingFile(sFile:String):Boolean;
    function SaveVersion(sFile:String; Version:Integer):Boolean;

    procedure Start;
  public
    { Public declarations }
  end;

var
  FrmNewLoader: TFrmNewLoader;

implementation

uses uMsgBox, uFrmFTPConfig, uEncryptFunctions, uParamFunctions, uNumericFunctions;

{$R *.DFM}

procedure TFrmNewLoader.RunProgram;
var
i : integer;
sDefaulEXE : string;
begin

  sDefaulEXE := sLocalPath+'MainRetail.exe';

  for i :=0 to 255 do
    Exec[i]:=#0;

  StrPcopy(Exec, sDefaulEXE);
  WinExec(Exec, SW_MAXIMIZE);

end;


function TFrmNewLoader.CanDownload:Boolean;
var
 i, count : integer;
 s : String;
begin

  s := '';
  count := 0;
  Result := False;
  for i:=0 to lstSoftware.Items.Count-1 do
    if lstSoftware.Checked[lstSoftware.Items.IndexOf(aDownloadFiles[i].Description)] then
       begin
       s := s + lstSoftware.Items.Strings[i];
       inc(count);
       if i <> iCounted-1 then
          s := s + ', '
       else
          s := s + '.';
       end;


  if not bAskDownload then
     begin
     Result := True;
     Exit;
     end;

  if count > 0 then
     Result := MsgBox(sNewVersion+s,vbYesNo + vbQuestion)=vbYes

end;

function TFrmNewLoader.DownloadFile(sSvrFile, sLocalFile:String): Boolean;
begin

  Result := True;
  lbSoftware.Caption    := sDownload + ' ('+sSvrFile+')';
  Application.ProcessMessages;
  Try
     if FileExists(sLocalFile) then
        DeletingFile(sLocalFile);
     IdFTP.Get(sSvrFile, sLocalFile, True, IdFTP.ResumeSupported);
     Application.ProcessMessages;
  except
     IdFTP.Disconnect;
     Result := False;
    end;

end;


function TFrmNewLoader.GetClientSoftwareList:Boolean;
var
  s : String;
begin

  try

      Result := True;

      lblMSG.Caption := sSostInfo;
      Application.ProcessMessages;

      Reg.CloseKey;
      Reg.OpenKey('SOFTWARE\AppleNet', True);

      If (not Reg.ValueExists('IDCustomer')) or (Reg.ReadString('IDCustomer') = '0')  then
         begin
         sCustomerID := InputBox('MainRetail', sClientLogin, '0');
         Reg.WriteString('IDCustomer', sCustomerID);
         end
      else
         sCustomerID := Reg.ReadString('IDCustomer');

      sCustomerFile := sCustomerID+'.ini';
      s := sLocalPath+sCustomerFile;

      if not DownloadFile(sCustomerFile, s) then
         begin
         Result := False;
         Reg.CloseKey;
         Reg.OpenKey('SOFTWARE\AppleNet', True);
         Reg.WriteString('IDCustomer', '0');
         ShowMessage(sInvalidLog+sCustomerID);
        end;

      Reg.CloseKey;

  except
     raise;
     Result := False;
     Reg.CloseKey;
  end;

end;

function TFrmNewLoader.MarkedforDownload(Desc:String):Boolean;
var
  j : Integer;
begin
   Result := False;

   for j:=0 to lstSoftware.Items.Count-1 do
      if lstSoftware.Items.Strings[lstSoftware.Items.IndexOf(aDownloadFiles[j].Description)] = Desc then
         begin
         Result := lstSoftware.Checked[lstSoftware.Items.IndexOf(aDownloadFiles[j].Description)];
         Break;
         end;
end;

function TFrmNewLoader.GetServerFiles:Boolean;
var
  i, iVersion : integer;
  sSFile, sLFile, sFileName : String;
begin

  Result := False;

  try

     pnlDowload.Visible := True;
     for i:=0 to iCounted-1 do
        begin
        sSFile    := aDownloadFiles[i].ModuleZipName;
        sLFile    := sLocalPath + aDownloadFiles[i].ModuleZipName;
        sFileName := aDownloadFiles[i].ModuleZipName;
        iVersion  := aDownloadFiles[i].Build;
        if MarkedforDownload(sSFile) then
           begin
           MyTreeNode            := TreeSoftware.Items.Item[aDownloadFiles[i].IndexNo];
           MyTreeNode.ImageIndex := STATUS_DOWNLOAD;
           Application.ProcessMessages;
           if DownloadFile(sSFile, sLFile) then
              begin
              MyTreeNode.ImageIndex := STATUS_EXTRACT;
              Application.ProcessMessages;
              if not ExtracFile(sFileName) then
                 begin
                 lbError.Caption := sExtract;
                 lbError.Visible := True;
                 Exit;
                 end;

              if not SaveVersion(sFileName, iVersion) then
                 begin
                 lbError.Caption := sUpdateV;
                 lbError.Visible := True;
                 Exit;
                 end;

              //Seta o estado para atualizado
              MyTreeNode.ImageIndex := STATUS_OPEN;
              Application.ProcessMessages;
              end;
           end;
        end;

     Application.ProcessMessages;
     Result := True;
  except
    Result := False;
    pnlDowload.Visible := False;
  end;

end;

function TFrmNewLoader.ExtracFile(sFile:String):Boolean;
var
  i : Integer;
begin

  Result := True;

  try
    lblMSG.Caption := sExtFile+' "'+sFile+'" ...';
    Application.ProcessMessages;

    UnZip.BaseDirectory := sLocalPath;
    UnZip.FileName      := sLocalPath+sFile;

    for i:=0 to UnZip.Count-1 do
       SetFileAttributes(Pchar(sLocalPath+UnZip.Items[i].FileName), FILE_ATTRIBUTE_NORMAL+FILE_ATTRIBUTE_ARCHIVE);

    pbExtract.Visible := True;
    try
       UnZip.ExtractFiles('*.*');
     except
        Result := False;
     end;
  finally
    UnZip.CloseArchive; 
    pbExtract.Visible := False;
    end;
end;

function TFrmNewLoader.DeletingFile(sFile:String):Boolean;
begin

  Result := True;

  lblMSG.Caption := sDelOld;
  Application.ProcessMessages;

  try
     if FileExists(sFile) then
        DeleteFile(sFile);
  except
    Result := False;
  end;

end;

function TFrmNewLoader.SaveVersion(sFile:String; Version:Integer):Boolean;
var
  i : integer;
begin

   Result := True;

   try
       Reg.CloseKey;
       Reg.OpenKey('SOFTWARE\AppleNet\CurrentVersions', True);
       Reg.WriteInteger(sFile, Version);
       Reg.CloseKey;
   except
       Result := False;
   end;

end;

function TFrmNewLoader.GetServerInfo:Boolean;
   procedure WriteDefaulFTPValue;
   begin
   sFTPServer := '#SRV#=ftp.mainretail.com.br;';
   sFTPPort   := '#PRT#=21;';
   sFTPUser   := '#USR#=Anonymous;';
   sFTPPW     := '#PW#=;';

   sResult := sFTPServer + sFTPPort + sFTPUser + sFTPPW;
   Reg.WriteString('FTPInfo', EncodeServerInfo(sResult,'FTPServer',CIPHER_TEXT_STEALING, FMT_UU));
   end;
begin

  try
      lblMSG.Caption := sInit;
      Application.ProcessMessages;

      Reg.CloseKey;
      Reg.OpenKey('SOFTWARE\AppleNet\CurrentVersions', True);

      sResult := DecodeServerInfo(Reg.ReadString('FTPInfo'), 'FTPServer', CIPHER_TEXT_STEALING, FMT_UU);

      If ((not Reg.ValueExists('FTPInfo')) or (Reg.ReadString('FTPInfo') = '0') or
         (ParseParam(sResult, '#SRV#=') = '192.168.100.1') or (ParseParam(sResult, '#SRV#=') = '209.51.152.98')) then
         begin
         //WriteDefaulFTPValue;
         with TFrmFTPConfig.Create(self) do
           Start;
         sResult := DecodeServerInfo(Reg.ReadString('FTPInfo'), 'FTPServer', CIPHER_TEXT_STEALING, FMT_UU);
         end;

      sFTPServer := ParseParam(sResult, '#SRV#=');
      sFTPPort   := ParseParam(sResult, '#PRT#=');
      sFTPUser   := ParseParam(sResult, '#USR#=');
      sFTPPW     := ParseParam(sResult, '#PW#=');

      IdFTP.Host     := sFTPServer;
      IdFTP.Username := sFTPUser;
      IdFTP.Password := sFTPPW;
      IdFTP.Port     := StrToInt(sFTPPort);

      Reg.CloseKey;
      Result := True;
  except
      Result := False;
  end;

end;

procedure TFrmNewLoader.Start;
begin

  sbCancel.Visible := False;

  Try

  //Pega as variaveis atual
  if not GetServerInfo then
     begin
     sbCancel.Visible := True;
     Exit;
     end;

    Try
      IdFTP.Connect(True,-1);
      IdFTP.ChangeDir('uploads');
    Except
      with TFrmFTPConfig.Create(self) do
         Start;
      sbCancel.Visible := True;
      Close;
      Exit;
      end;

    //Preenche os Modulos
    if not GetClientSoftwareList then
       begin
       sbCancel.Visible := True;
       Close;
       Exit;
       end;

    if not FileExists(sLocalPath+sCustomerFile) then
       begin
       ShowMessage(sNoCustomer);
       sbCancel.Visible := True;
       Close;
       Exit;
       end;

    BuildSoftwareList;

    if not CanDownload then
       begin
       sbCancel.Visible := True;
       exit;
       end;

    //DownloadFiles
    if not GetServerFiles then
       begin
       lbError.Visible := True;
       sbCancel.Visible := True;
       Exit;
       end;

  finally
    IdFTP.Disconnect;
    DeleteFiles;
    FinalizeDisplay;
    sbCancel.Visible := True;
    Application.ProcessMessages;  
    end;

end;

procedure TFrmNewLoader.FormCreate(Sender: TObject);
begin

  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  sLocalPath := ExtractFilePath(ParamStr(0));

  iCounted     := 0;
  iSoftwarePos := 0;

  DMGlobal.IDLanguage := LANG_ENGLISH;

  try
    Reg.OpenKey('SOFTWARE\Applenet\MainRetail', True);
    if not Reg.ValueExists('DefaultLanguage') then
        Reg.WriteInteger('DefaultLanguage', LANG_ENGLISH);
    DMGlobal.IDLanguage := Reg.ReadInteger('DefaultLanguage');
  finally
    Reg.CloseKey;
    end;

  //Translation
  case DMGlobal.IDLanguage of
    LANG_ENGLISH   : begin
                     sNewVersion  := 'New version. Download Now?_Software : ';
                     sDownload    := 'Download';
                     sSostInfo    := 'Software Info ...';
                     sClientLogin := 'Client Login';
                     sInvalidLog  := 'Invalid client login : ';
                     sExtract     := 'Extracting File(s) error.';
                     sUpdateV     := 'Updating version error.';
                     sExtFile     := 'Extracting file';
                     sDelOld      := 'Deleting old file(s) ...';
                     sInit        := 'Starting ...';
                     sNoCustomer  := 'Customer file not found!';
                     sDelerror    := 'Deleting File(s) error.';
                     end;
    LANG_PORTUGUESE :begin
                     sNewVersion  := 'Nova versão. Baixar agora?_Software : ';
                     sDownload    := 'Baixando';
                     sSostInfo    := 'Informação do software ...';
                     sClientLogin := 'Login do cliente';
                     sInvalidLog  := 'O login do cliente inválido: ';
                     sExtract     := 'Error ao extrair arquivo. ';
                     sUpdateV     := 'Error atualizando de versão. ';
                     sExtFile     := 'Extraindo arquivo ';
                     sDelOld      := 'Deletando arquivos temp ...';
                     sInit        := 'Iniciando ...';
                     sNoCustomer  := 'Error: O arquivo do client não localizado!';
                     sDelerror    := 'Error deletando arquivos ';
                     end;
    LANG_SPANISH    :begin
                     sNewVersion  := 'Nova version. Baixar ahora?_Software : ';
                     sDownload    := 'Download';
                     sSostInfo    := 'Software Info ...';
                     sClientLogin := 'Login del cliente';
                     sInvalidLog  := 'La entrada inválida del cliente :';
                     sExtract     := 'Extraer el error del Archivo';
                     sUpdateV     := 'Actualizar el error de la versión.';
                     sExtFile     := 'El archivo que extrae ';
                     sDelOld      := 'Borrar el archivo viejo ...';
                     sInit        := 'Empezar ...';
                     sNoCustomer  := 'El archivo del cliente no encontró!';
                     sDelerror    := 'Error borrando el archivo.';
                     end;
   end;

end;

procedure TFrmNewLoader.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Reg.CloseKey;
  Reg.Free;

  Action := caFree;

end;

procedure TFrmNewLoader.sbCancelClick(Sender: TObject);
begin
  RunProgram;
  Close;
end;

procedure TFrmNewLoader.FormShow(Sender: TObject);
begin

 Timer.Enabled := True;

end;


procedure TFrmNewLoader.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;

   Start;

   lblMSG.Caption := 'Welcome to Main Retail ...';
   Application.ProcessMessages;

end;

procedure TFrmNewLoader.btnDownloadClick(Sender: TObject);
begin

  //CanDownload Files
  if not CanDownload then
     begin
     sbCancelClick(Self);
     exit;
     end;

  //DownloadFiles
  if not GetServerFiles then
     begin
     lbError.Caption := 'Downloading File(s) Error.';
     lbError.Visible := True;
     Exit;
     end;

  sbCancelClick(self);

end;

procedure TFrmNewLoader.BuildSoftwareList;
var
  App : TIniFile;
  fList : TStringList;
  i : Integer;
  fActualFile : String;
  fFileVersion : Integer;
begin

   Reg.CloseKey;

   try
     Reg.OpenKey('SOFTWARE\AppleNet\CurrentVersions', True);

     //Update Loader1 version
     App := TIniFile.Create(sLocalPath + sCustomerFile);
     fList := TStringList.Create;

     //Atualiza o auto download
     bAskDownload := App.ReadBool(SECTION_SETTING, VALUES_ASK_DOWNLOAD, True);

     App.ReadSection(SECTION_FILES,fList);
     for i := 0 to fList.Count-1 do
        begin
        fActualFile  := fList.Strings[i];
        fFileVersion := App.ReadInteger(SECTION_FILES, fActualFile, 0);

        //Verifico a existencia na maquina local
        If not Reg.ValueExists(fActualFile) then
           Reg.WriteInteger(fActualFile, 0);

        TreeSoftware.items.Add(Node, fActualFile);
        MyTreeNode      := TreeSoftware.Items.Item[iSoftwarePos];
        MyTreeNode.Text := Trim(fActualFile);

        if (fFileVersion <> Reg.ReadInteger(fActualFile)) then
            begin
            aDownloadFiles[iCounted].ModuleZipName := Trim(fActualFile);
            aDownloadFiles[iCounted].ExecName      := Trim(fActualFile);
            aDownloadFiles[iCounted].Description   := Trim(fActualFile);
            aDownloadFiles[iCounted].Build         := fFileVersion;
            aDownloadFiles[iCounted].IndexNo       := iSoftwarePos;
            MyTreeNode.ImageIndex                  := STATUS_NEW;

            lstSoftware.Items.Add(Trim(fActualFile));
            lstSoftware.Checked[lstSoftware.Items.IndexOf(Trim(fActualFile))] := True;
            inc(iCounted);
            end
         else
            begin
            MyTreeNode.ImageIndex := STATUS_OPEN;
            end;

        Inc(iSoftwarePos);
        end;

      pnlSoftwareList.Visible := (iCounted>0) and bAskDownload;
      Application.ProcessMessages;
   finally
      FreeAndNil(fList);
      FreeAndNil(App);
      Reg.CloseKey;
      end;
end;

procedure TFrmNewLoader.IdFTPStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin
  lblMSG.Caption := AStatusText;
  Application.ProcessMessages;
end;

procedure TFrmNewLoader.IdFTPWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
var
  I : Double;
begin
  if pb.Visible then
     begin
     pb.Position := AWorkCount;
     end
  else
    begin
    I := (AWorkCount/1024);
    lbRate.Caption := FormatFloat('0', I)+' Kbytes ...';
    Application.ProcessMessages;
    end;

end;

procedure TFrmNewLoader.IdFTPWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  pnlDowload.Visible := True;
  if (AWorkCountMax<>0) then
     begin
     pb.Max := AWorkCountMax;
     pb.Visible := True;
     pb.Position := 0;
     end
  else
     begin
     aniTransfer.Visible := True;
     aniTransfer.Active := True;
     end;
  Application.ProcessMessages;
end;

procedure TFrmNewLoader.IdFTPWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  FinalizeDisplay;
end;


function TFrmNewLoader.DeleteFiles: Boolean;
var
 i : Integer;
begin

  if iCounted > 0 then
     Sleep(3000);

   for i:=0 to iCounted-1 do
      if not DeletingFile(sLocalPath+aDownloadFiles[i].ModuleZipName) then
         begin
         lbError.Caption := sDelerror;
         lbError.Visible := True;
         Exit;
         end;

end;

procedure TFrmNewLoader.FinalizeDisplay;
begin
  pnlDowload.Visible := False;
  aniTransfer.Enabled := False;
  pb.Visible := False;
  if aniTransfer.Active then
     aniTransfer.Active := False;
  lbRate.Caption := '';
end;

procedure TFrmNewLoader.UnZipConfirmOverwrite(var Name: String;
  var Confirm: Boolean);
var bConfirm : Boolean;
begin
  bConfirm := Confirm;
end;

end.
