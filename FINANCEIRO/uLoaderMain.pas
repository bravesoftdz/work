unit uLoaderMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, OleCtrls, XceedZipLib_TLB;

type
  TMain = class(TForm)
    lblMSG: TLabel;
    Image1: TImage;
    Timer: TTimer;
    PB: TProgressBar;
    Pro: TTimer;
    lblRemoto: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ProTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.DFM}

uses uFileUtil, IniFiles, FileCtrl, uMsgBox;

procedure TMain.FormShow(Sender: TObject);
begin
  Timer.Enabled := True;
end;

procedure TMain.TimerTimer(Sender: TObject);
var
  sImageLocal, sImageServer, sLocalPath,
  sCabinetFile, sDBName, sZipProgram, sZipFile : String;
  AppIni: TIniFile;
  Exec: array[0..255] of char;
  S1, S2: TSearchRec;
  iRemoteClient, i, iSize: Integer;
  StartupInfo: TStartupInfo;
  ProcessInf : TProcessInformation;
  rc : Boolean;
  //Zip
  xErr : xcdError;

begin

  Timer.Enabled := False;
  lblMSG.Caption := 'Testing the conection...';
  Application.ProcessMessages;

  // Leio do arquivo INI o diretorio local
  AppIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'RetailParam.ini');

  sImageLocal   := AppIni.ReadString('FileSettings', 'ImageLocal', '');
  sImageServer  := AppIni.ReadString('FileSettings', 'ImageServer', ExtractFilePath(ParamStr(0)) + 'Loader.exe');

  sCabinetFile  := AppIni.ReadString('FileSettings', 'CabinetFile', '!NoCabinet!');
  iRemoteClient := AppIni.ReadInteger('FileSettings', 'RemoteClient', 0);

  sZipProgram   := AppIni.ReadString('FileSettings', 'ZipProgram', '');
  sZipFile      := AppIni.ReadString('FileSettings', 'ZipFile', '');

  sLocalPath    := AppIni.ReadString('FileSettings', 'LocalPath', '');

  lblRemoto.Visible := (iRemoteClient<>0);

  sDBName := AppIni.ReadString('DBSettings', 'DatabaseName', '');

  Application.ProcessMessages;

  // Forço a existencia do path
  lblMSG.Caption := 'Creating local folder...';
  Application.ProcessMessages;
  ForceDirectories(ExtractFilePath(sImageLocal));

  // Comparo os dois arquivos
  lblMSG.Caption := 'Comparing versions...';
  Application.ProcessMessages;
  FindFirst(sImageLocal, faAnyFile, S1);
  FindFirst(sImageServer, faAnyFile, S2);

  if (S1.Time <> S2.Time) then
      if MsgBox('There is a new version would you like to update ?',
                vbYesNo + vbQuestion) = vbYes then
        begin
        lblMSG.Caption := 'Updating local version...';
        Application.ProcessMessages;

        // Copio o arquivo compactado
        FileCopy(sCabinetFile, sZipFile);

      // Tenho que descompactar o exe
//      for i :=0 to 255 do
//        Exec[i]:=#0;
      //StrPcopy(Exec, sZipProgram+' '+sLocalPath+'\MRetail.ZIP');

      //Param para Descompactar
//        zZipFile.ZipFilename   := sZipFile;
//        zZipFile.UnzipToFolder := sLocalPath;

      //Launch the unzipping

//        xErr := zZipFile.Unzip;
//        WaitForSingleObject(zZipFile.Unzip, INFINITE);


{        rc   := True;


        // Esperar o Zip terminar antes de rodar o SIS
        // inicio o startup com 0
        FillChar(StartupInfo, SizeOf(StartupInfo), #0);
        // inicializando os campos do Startup
        with StartupInfo do
           iSize := SizeOf(StartupInfo);
        // Dispara o processo
        rc := CreateProcess(NIL, Exec, NIL, NIL,
                            False, Normal_Priority_Class, NIL, NIL,
                            StartupInfo, ProcessInf);
        //segundo o parametro espera indefinidamente ate terminar
        If rc then
           WaitForSingleObject(ProcessInf.hProcess, INFINITE);}
        end;

  // Executo a exe e caio fora
  for i :=0 to 255 do
    Exec[i]:=#0;

  //Copio o Param para o EXE. Param[1]=nome do DataBase que sera lido no DM
  StrPcopy(Exec, sImageLocal + ' ' + sDBName);

  lblMSG.Caption := 'Keeping connection ...';
  Application.ProcessMessages;

  WinExec(Exec, SW_MAXIMIZE);

  Application.Terminate;

end;

procedure TMain.ProTimer(Sender: TObject);
begin
  with PB do
    begin
      if Position = 100 then
        Position := 0
      else
        Position := Position + 2;
      Application.ProcessMessages;
    end;
end;

end.
