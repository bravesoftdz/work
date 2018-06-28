unit uFrmBackUpRestoreDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Db, ADODB, jpeg, FileCtrl, Grids,
  uEncryptFunctions, uDataBaseOperation, siComp,
  dximctrl, IniFiles;

const
  BACKUP  = 0;
  RESTORE = 1;

  HISTORY_FILE = 'history.txt';
  CONFIG_FILE  = 'MRBackup.ini';


type
  TFrmBackUpRestoreDB = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    btnBack: TButton;
    btnNext: TButton;
    btnClose: TButton;
    Notebook: TNotebook;
    ImgIntro: TImage;
    Label28: TLabel;
    Label36: TLabel;
    ImgSummary: TImage;
    Label29: TLabel;
    Label37: TLabel;
    memSummary: TMemo;
    Panel4: TPanel;
    Label57: TLabel;
    Label58: TLabel;
    ImgChooser: TImage;
    rdOption: TRadioGroup;
    Panel2: TPanel;
    lbTop: TLabel;
    lbInfo: TLabel;
    imgConnection: TImage;
    Label5: TLabel;
    edtServer: TEdit;
    Panel3: TPanel;
    Label8: TLabel;
    lbDBInfo: TLabel;
    imgDB: TImage;
    Label10: TLabel;
    chkForceRest: TCheckBox;
    Panel6: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    imgRetoreInfo: TImage;
    DBConnection: TADOConnection;
    quFreeSQL: TADODataSet;
    OD: TOpenDialog;
    Panel7: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    imgBKPOption: TImage;
    grbBackUp: TGroupBox;
    rdBKPAppend: TRadioButton;
    rdBKPOverwrite: TRadioButton;
    CheckBox1: TCheckBox;
    lbDirOption: TLabel;
    edtRSTPath: TEdit;
    sbOpenFile: TSpeedButton;
    cbxBKPDevice: TGroupBox;
    rbTape: TRadioButton;
    rbFile: TRadioButton;
    edtBKPPath: TEdit;
    sbOpenBKP: TSpeedButton;
    cbxDrive: TDriveComboBox;
    gridRestore: TStringGrid;
    chkZipBackUp: TCheckBox;
    lbStatus: TLabel;
    siLang: TsiLang;
    gbxAutentic: TGroupBox;
    rbWindows: TRadioButton;
    rbSQL: TRadioButton;
    edtUserName: TEdit;
    Label7: TLabel;
    edtPW: TEdit;
    lbVersion : TLabel;
    pnlLanguage: TPanel;
    cbxLanguage: TdxImageComboBox;
    EdtDababase: TEdit;
    ChkBxZipClientFolders: TCheckBox;
    labConfigureNetworkDrive: TLabel;
    panBackupHostType: TPanel;
    rdBackupHostType: TRadioGroup;
    labBackupHostTypeDesc: TLabel;
    labBackupHostTypeSubject: TLabel;
    procedure FormShow(Sender: TObject);
    procedure rdOptionClick(Sender: TObject);
    procedure NotebookPageChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure sbOpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbSQLClick(Sender: TObject);
    procedure cbxLanguageChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure labConfigureNetworkDriveClick(Sender: TObject);
  private
    { Private declarations }
    DBOperation : TDataBaseOperation;

    //Translation
    sRestoringDB,
    sRestoringDBFail,
    sCreatingZip,
    sCreatingZipFail,
    sStartBackup,
    sStartBackupFail,
    sServer,
    sDataBase,
    sFile,
    sFilePropertyO,
    sFileProprrtyA,
    sBackup,
    sZipBkp,
    sBkpClientFiles,
    sZipFileName,
    sRestore,
    sFromFile,
    sRestoreOverDB,
    sLogicalData,
    sDataPath,
    sLogicalLog,
    sLogParh,
    sNext,
    sConnect,
    sBackupDBName,
    sRestoreDBName,
    sLogicalName,
    sMoveToPhis,
    sForceRestOn1,
    sForceRestOn2,
    sFinish  : String;

    sDB, sPath  : String;

    //Begin Yanniel 11/03/2012
    sUNC_Path,
    sUNC_Username,
    sUNC_Password,
    MappedDrive: string;
    MyIniFile: TIniFile;
    MappedDriveConnected: Boolean;
    //End Yanniel 11/03/2012

    Option      : Integer;
    sZipFile    : String;
    sLocalPath  : String;
    //bBackupDatabase, { Alex 08/13/2011 }
    bAutoBackup : Boolean;
    function SetConnection:boolean;

    procedure PageWelcome;
    procedure PageBackupHostType;
    procedure PageConnection;
    procedure PageSetting;
    procedure PageDatabase;
    procedure PageRestoreOption;
    procedure PageBackupOption;
    procedure PageLast;

    procedure SetNextPage;
    procedure SetPriorPage;

    procedure GetDBList;
    procedure BuildResume;

    function  IsInConfigMode: Boolean;
    Procedure BackupDB(aBackupPath: string); //Yanniel 11/03/2012
    Procedure BackupClientFilesAndFolders;

    function ValidPageDatabase:Boolean;
    function ValidPageDirectory:Boolean;

    Function Zipper( psSourceFolderName, psDentinyFileName : String;
                     bDeleteExisting : Boolean = True;
                     psZipMask : String = '' ) : Boolean;

    function DoBackUp:Boolean;
    function DoRestore:Boolean;
    function DoAutoBackup:Boolean;

    procedure GetRestoreFileInfo;
    procedure CreateRestoreDir;

    procedure SetCaptions;

    procedure AddHistory(Text:String);

    function GetBackupPath: string;
  public
    { Public declarations }
  end;

var
  FrmBackUpRestoreDB: TFrmBackUpRestoreDB;

implementation

uses uParamFunctions, uMsgBox, ufrmServerInfo, {uZipFiles,} uDMGlobal,
     uMsgConstant, {Registry,} uSaveToFile, uOperationSystem,
     SevenZipUtils, MiscUtils, uFrmConfigNetworkDrive;

{$R *.DFM}

procedure TFrmBackUpRestoreDB.AddHistory(Text:String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := sLocalPath+HISTORY_FILE;
    fFile.OpenFile;
    Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
    fFile.InsertText(Text,0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
    end;  
end;


procedure TFrmBackUpRestoreDB.CreateRestoreDir;
var
 sDataDir, sLogDir : String;

 function getAbsPath(sPath:String):String;
    var
    i, last : Integer;
    begin
    for last := length(sPath) downto 0 do
       if sPath[last] = '\' then
          begin
          Result := Copy(sPath,0,last-1);
          Break;
          end;
    end;

begin

 //Create directore before save it
 sDataDir := getAbsPath(Trim(gridRestore.Cells[1, 1]));
 sLogDir  := getAbsPath(Trim(gridRestore.Cells[1, 2]));

 if not DirectoryExists(sDataDir) then
    ForceDirectories(sDataDir);

 if not DirectoryExists(sLogDir) then
    ForceDirectories(sLogDir);

end;

procedure TFrmBackUpRestoreDB.GetRestoreFileInfo;
var
  i : integer;
begin

 with quFreeSQL do
   begin

   if Active then
      Close;

   CommandText := ' RESTORE FILELISTONLY ' +
                  ' FROM DISK = ' + QuotedStr(edtRSTPath.Text);

   try
     Open;
   Except
     MsgBox(MSG_CRT_INVALID_FILE, vbCritical + vbOkOnly);
     edtRSTPath.Text := '';
     Close;
     Exit;
   end;

   First;

   for i := 0 to RecordCount-1 do
     begin
     gridRestore.Cells[0, i+1] := FieldByName('LogicalName').AsString;
     gridRestore.Cells[1, i+1] := FieldByName('PhysicalName').AsString;
     Next;
     end;
   Close;
   end;
end;

function TFrmBackUpRestoreDB.DoRestore:Boolean;
begin

    Screen.Cursor    := crHourGlass;
    lbStatus.Caption := sRestoringDB;
    Application.ProcessMessages;

    Try
        DBOperation := TRestoreDataBase.Create;
        DBOperation.Connection := DBConnection;

        DBOperation.DataBaseName := EdtDababase.Text;

        DBOperation.Device := DEVICE_DISK + QuotedStr(edtRSTPath.Text);


        if chkForceRest.Checked then
           TRestoreDataBase(DBOperation).ForceRestore := RST_REPLACE_DB
        else
           TRestoreDataBase(DBOperation).ForceRestore := '';

       TRestoreDataBase(DBOperation).LogicalDataName := QuotedStr(Trim(gridRestore.Cells[0, 1]));
       TRestoreDataBase(DBOperation).NewDataPath     := QuotedStr(Trim(gridRestore.Cells[1, 1]));

       TRestoreDataBase(DBOperation).LogicalLogName  := QuotedStr(Trim(gridRestore.Cells[0, 2]));
       TRestoreDataBase(DBOperation).NewLogPath      := QuotedStr(Trim(gridRestore.Cells[1, 2]));

        Try
           Result := (DBOperation.SetSQLExecute = -1);
        except
           raise;
           Result := False;
           lbStatus.Caption := sRestoringDBFail;
           Application.ProcessMessages;
        end;

    finally
      if not Result then
         AddHistory('Restore database '+EdtDababase.Text+' fail')
      else
         AddHistory('Restore database '+EdtDababase.Text+' succeed');
      FreeAndNil(DBOperation);
      Screen.Cursor:= crDefault;
    end;


end;

function TFrmBackUpRestoreDB.DoBackUp:Boolean;
begin

    Screen.Cursor    := crHourGlass;
    lbStatus.Caption := sStartBackup;
    Application.ProcessMessages;

    Try

        DBOperation := TBackUpDataBase.Create;
        DBOperation.Connection := DBConnection;

        DBOperation.DataBaseName := EdtDababase.Text;

        if rdBKPAppend.Checked then
           TBackUpDataBase(DBOperation).AppendDB := BKP_APPEND_NOINIT
        else
           TBackUpDataBase(DBOperation).AppendDB := BKP_APPEND_INIT;

        if rbFile.Checked then
           begin
           TBackUpDataBase(DBOperation).FilePath := edtBKPPath.Text;
           DBOperation.Device   := DEVICE_DISK + QuotedStr(edtBKPPath.Text);
           end;

        Try
           Result := (DBOperation.SetSQLExecute = -1);
        except
           raise;
           Result := False;
           lbStatus.Caption := sStartBackupFail;
           Application.ProcessMessages;
        end;

    finally
      FreeAndNil(DBOperation);
      Screen.Cursor:= crDefault;
      if not Result then
         AddHistory('ERROR: Backup database '+EdtDababase.Text+' to '+edtBKPPath.Text)
      else
         AddHistory('Backup database '+EdtDababase.Text+' succeed. File '+edtBKPPath.Text);
    end;


end;

(*Function TFrmBackUpRestoreDB.Zipper( psSourceFolderName, psDentinyFileName : String;
                                     bDeleteExisting : Boolean = True;
                                     psZipMask : String = ''  ) : Boolean;
Var
  AbZipper : TAbZipper;
Begin

  Try

    If ( bDeleteExisting = True )
    Then If FileExists( psDentinyFileName ) Then DeleteFile( psDentinyFileName );

    Try

      If ( Trim( psZipMask ) = '' ) Then psZipMask := '*.*';

      AbZipper := TAbZipper.Create( Nil );

      AbZipper.BaseDirectory := psSourceFolderName;
      AbZipper.FileName      := psDentinyFileName;
      AbZipper.StoreOptions  := [ soRecurse, soRemoveDots ];

      AbZipper.AddFiles( psZipMask, faAnyFile );
      AbZipper.Save;

      Result := True;

    Finally

      AbZipper.CloseArchive;
      FreeAndNil( AbZipper );

    End;


  Except

    Result := False;

  End;

End; *)

//Yanniel 12/03/2012 
Function TFrmBackUpRestoreDB.Zipper( psSourceFolderName, psDentinyFileName : String;
                                     bDeleteExisting : Boolean = True;
                                     psZipMask : String = ''  ) : Boolean;
Begin
  If ( bDeleteExisting = True )
    Then If FileExists( psDentinyFileName ) Then DeleteFile( psDentinyFileName );
  If ( Trim( psZipMask ) = '' ) Then psZipMask := '*.*';

  Result:= T7ZipWrapper.Archive(psSourceFolderName,
                                psDentinyFileName,
                                psZipMask,
                                _7Z, edtPW.Text);
End;

procedure TFrmBackUpRestoreDB.BuildResume;
begin

   memSummary.Clear;

   Case Option of

     BACKUP : begin

              with memSummary.Lines do
                  begin
                  Add(sBackup);
                  Add('===========================');
                  Add(sServer+ edtServer.Text);
                  Add(sDataBase+ EdtDababase.Text);
                  Add(sFile + edtBKPPath.Text ); 
                  if rdBKPOverwrite.Checked then
                     Add(sFilePropertyO)
                  else
                     Add(sFileProprrtyA);

                  if chkZipBackUp.Checked then
                     begin
                     Add(sZipBkp);
                     Add(sZipFileName + sZipFile);
                     end;

                  { Alex 08/09/2011 }
                  if ChkBxZipClientFolders.Checked then
                     begin
                     Add( sBkpClientFiles );
                     end;
                  end;

              end;

     RESTORE : begin

                with memSummary.Lines do
                    begin
                    Add(sRestore);
                    Add('===========================');
                    Add(sServer+ edtServer.Text);
                    Add(sDataBase+ EdtDababase.Text);
                    Add(sFromFile + edtRSTPath.Text );

                    if chkForceRest.Checked then
                       Add(sRestoreOverDB);

                    Add('');

                    Add(sLogicalData + gridRestore.Cells[0, 1]);
                    Add(sDataPath + gridRestore.Cells[1, 1]);

                    Add('');

                    Add(sLogicalLog + gridRestore.Cells[0, 2]);
                    Add(sLogParh + gridRestore.Cells[1, 2]);

                    end;

               end;
   end;

end;

function TFrmBackUpRestoreDB.ValidPageDirectory:Boolean;
begin

  Result := True;

   if Notebook.ActivePage = 'pgRestOptions' then
      if Trim(edtRSTPath.Text) = '' then
          Result := False;

   if Notebook.ActivePage = 'pgBackupOptions' then
      if rbFile.Checked then
         if Trim(edtBKPPath.Text) = '' then
            Result := False;

end;

function TFrmBackUpRestoreDB.ValidPageDatabase:Boolean;
begin

   Result := True;

   if Trim(EdtDababase.Text) = '' then
      Result := False;

end;

procedure TFrmBackUpRestoreDB.GetDBList;
begin

  Screen.Cursor:= crHourGlass;

  with quFreeSQL do
    begin
    if Active then
       Close;

    CommandText := 'exec sp_databases';

    Open;

    First;

    While not EOF do
       begin
       //cbxDB.Items.Add(Fields.Fields[0].AsString);
       Next;
       end;

    Close;

    end;

  Screen.Cursor:= crDefault;

end;

procedure TFrmBackUpRestoreDB.SetNextPage;
var
  RemotePath: string;
  bDoBackUp: Boolean;
begin
  case Notebook.PageIndex of

    0: Notebook.PageIndex:= 1;

    1: begin
         case rdBackupHostType.ItemIndex of
           0: begin
                Notebook.PageIndex:= 2;
                edtBKPPath.Text:= sPath + EdtDababase.Text + '_' + FormatDateTime('dddd', now) + '_' + GetComputerNetName + '.BAK';
              end;
           1: begin
                Notebook.PageIndex:= 6;
                rbFile.Caption:= 'Path';
                sFile         := 'Path : '; //Yanniel: Still needs localization
                edtBKPPath.Text:= sPath;
                chkZipBackUp.Checked:= False;
                chkZipBackUp.Enabled:= False;
                ChkBxZipClientFolders.Checked:= True;
                ChkBxZipClientFolders.Enabled:= False;
              end;
         end;
       end;

    2: if not SetConnection then
       begin
         MsgBox(MSG_CRT_NO_CONECTION, vbCritical + vbOkOnly);
         Exit;
       end
       else
         Notebook.PageIndex:= 3;

    3: Notebook.PageIndex:= 4;

    4: begin
         if not ValidPageDatabase then
         begin
           MsgBox(MSG_INF_SELECT_DB, vbInformation + vbOkOnly);
           Exit;
         end;
         if (Option = RESTORE) then
           Notebook.PageIndex:= 5;
         if (Option = BACKUP) then
           Notebook.PageIndex:= 6;
       end;

    5,
    6: begin
         if (not ValidPageDirectory) then
         begin
           MsgBox(MSG_INF_SELECT_FILE, vbInformation + vbOKOnly);
           Exit;
         end;

         if chkZipBackUp.Checked then
           sZipFile := StringReplace(edtBKPPath.Text, '.BAK', '.7z', [rfIgnoreCase]);

         Notebook.PageIndex:= 7;
       end;

    7: begin
         //Finally with Backup or Retore

         case Option of
           BACKUP:  begin
                      if not MappedDriveConnected then
                        MappedDriveConnected:= ConnectNetDrive(sUNC_Path, sUNC_Username, sUNC_Password, MappedDrive);

                      if ChkBxZipClientFolders.Checked then
                        BackupClientFilesAndFolders;

                      if rdBackupHostType.ItemIndex = 0 {bBackupDatabase} then
                      begin
                        bDoBackUp:= DoBackUp;
                        if bDoBackUp then
                          BackupDB(edtBKPPath.Text);
                      end;

                      if MappedDriveConnected then
                      begin
                         if DisconnectNetDrive(MappedDrive) then
                           MappedDriveConnected:= False;
                      end;

                      if not bDoBackUp then
                        MsgBox(MSG_CRT_ERROR_BACKUP, vbCritical + vbOKOnly)
                      else
                        MsgBox(MSG_INF_BACKUP_COMPLETED, vbInformation + vbOKOnly);
                    end;
           RESTORE: begin
                      if not DoRestore then
                        MsgBox(MSG_CRT_ERROR_RESTORE, vbCritical + vbOKOnly)
                      else
                        MsgBox(MSG_INF_RESTORE_COMPLETED, vbInformation + vbOKOnly);
                    end;
         end;
         Close;
       end;
  end;
end;

procedure TFrmBackUpRestoreDB.SetPriorPage;
begin
  case Notebook.PageIndex of
    //0: ;  //Notebook.ActivePage = 'pgIntro'
    1: Notebook.PageIndex:= 0; //Notebook.ActivePage = 'pgBackupHostType'
    2: Notebook.PageIndex:= 1; //Notebook.ActivePage = 'pgConnection'
    3: Notebook.PageIndex:= 2; //Notebook.ActivePage = 'pgSelection'
    4: Notebook.PageIndex:= 3; //Notebook.ActivePage = 'pgDatabase'
    5: Notebook.PageIndex:= 4; //Notebook.ActivePage = 'pgRestOptions'
    6: case rdBackupHostType.ItemIndex of //Notebook.ActivePage = 'pgBackupOptions'
         0: Notebook.PageIndex:= 4;
         1: begin
              Notebook.PageIndex:= 1;
              chkZipBackUp.Checked:= True;
              chkZipBackUp.Enabled:= True;
              ChkBxZipClientFolders.Checked:= True;
              ChkBxZipClientFolders.Enabled:= True;
            end;
       end;
    7: Notebook.PageIndex:= 6;  //Notebook.ActivePage = 'pgSummary'
  end;
end;

procedure TFrmBackUpRestoreDB.PageWelcome;
begin

  btnBack.Visible := False;
  btnNext.Caption := sNext;
  btnNext.Tag     := 0;
  Notebook.Color  := clWhite;

end;

procedure TFrmBackUpRestoreDB.PageBackupHostType;  
begin

  btnBack.Visible := True;
  btnNext.Caption := sNext;
  btnNext.Tag     := 0;
  Notebook.Color  := clWhite;

end;

procedure TFrmBackUpRestoreDB.PageConnection;
begin

  btnBack.Visible := True;
  btnNext.Caption := sConnect;
  btnNext.Tag     := 1;
  Notebook.Color  := clBtnFace;

end;

procedure TFrmBackUpRestoreDB.PageSetting;
begin

  btnBack.Visible := True;
  btnNext.Caption := sNext;
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;

end;

procedure TFrmBackUpRestoreDB.PageDatabase;
begin

  btnNext.Caption := sNext;
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;

  if Option = BACKUP then
     begin
     //cbxDB.Style := csDropDownList;
     lbDBInfo.Caption := sBackupDBName;
     end
  else
     begin
     //cbxDB.Style := csDropDown;
     lbDBInfo.Caption := sRestoreDBName;
     end;

  //if cbxDB.Items.Count = 0 then
     { Alex 08/09/2011 }
     // GetDBList;
  //   GetDatabaseInformation;

end;

procedure TFrmBackUpRestoreDB.PageRestoreOption;
begin

  btnNext.Caption := sNext;
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;

  OD.Options := OD.Options + [ofFileMustExist];

  gridRestore.Cells[0,0] := sLogicalName;
  gridRestore.Cells[1,0] := sMoveToPhis;

  chkForceRest.Caption   := sForceRestOn1 + EdtDababase.Text + sForceRestOn2;

end;

procedure TFrmBackUpRestoreDB.PageBackupOption;
begin

  btnNext.Caption := sNext;
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;

  OD.Options := OD.Options - [ofFileMustExist];

end;

procedure TFrmBackUpRestoreDB.PageLast;
begin

  btnNext.Caption := sFinish;
  btnNext.Tag     := 2;
  Notebook.Color  := clWhite;

  BuildResume;

end;


function TFrmBackUpRestoreDB.SetConnection:boolean;
begin

  Screen.Cursor:= crHourGlass;

  try
      with DBConnection do
        begin
        if Connected then
           Close;

        if rbSQL.Checked then
           ConnectionString := SetConnectionStrNoNETLIB(edtUserName.Text, edtPW.Text, 'Master', edtServer.Text)
        else
           ConnectionString := SetWinConnectionStrNoNETLIB('Master', edtServer.Text);

        Open;
        end;

     Result := True;

  except
    Result := False;
    end;

  Screen.Cursor:= crDefault;

end;

procedure TFrmBackUpRestoreDB.FormShow(Sender: TObject);
begin
  bAutoBackup:= not IsInConfigMode;
  // If the application is not in config mode,
  // then we run the backup and exit
  if bAutoBackup then
  begin
    DoAutoBackup;
    Close;
  end;

  //Initial values
  Option := BACKUP;
  Notebook.PageIndex := 0;
  ImgSummary.Picture.Assign(ImgIntro.Picture);
  ImgChooser.Picture.Assign(imgConnection.Picture);
  ImgDB.Picture.Assign(imgConnection.Picture);
  imgRetoreInfo.Picture.Assign(imgConnection.Picture);
  imgBKPOption.Picture.Assign(imgConnection.Picture);
end;

procedure TFrmBackUpRestoreDB.rdOptionClick(Sender: TObject);
begin
  Option := rdOption.ItemIndex; 
end;

procedure TFrmBackUpRestoreDB.NotebookPageChanged(Sender: TObject);
begin

  if Notebook.ActivePage = 'pgIntro' then
     PageWelcome
  else if Notebook.ActivePage = 'pgBackupHostType' then
    PageBackupHostType
  else if Notebook.ActivePage = 'pgConnection' then
     PageConnection
  else if Notebook.ActivePage = 'pgSelection' then
     PageSetting
  else if Notebook.ActivePage = 'pgDatabase' then
     PageDatabase
  else if Notebook.ActivePage = 'pgRestOptions' then
     PageRestoreOption
  else if Notebook.ActivePage = 'pgBackupOptions' then
     PageBackUpOption
  else if Notebook.ActivePage = 'pgSummary' then
     PageLast;
  
end;

procedure TFrmBackUpRestoreDB.FormClose(Sender: TObject;
  var Action: TCloseAction);

  //Yanniel
  function Bool2Str(aValue: Boolean): string;
  begin
    Result:= 'N';
    if aValue then Result:= 'Y';
  end;

var
  ServerInfo: string;

begin
  ServerInfo:= SV_SERVER     + edtServer.Text + ';'+
               SV_DATABASE   + EdtDababase.Text + ';'+
               SV_USER       + edtUserName.Text + ';'+
               SV_PASSWORD   + edtPW.Text + ';'+
               SV_WIN_LOGIN  + Bool2Str(rbWindows.Checked) + ';'+
               SV_USE_NETLIB + 'N;';
  ServerInfo:= EncodeServerInfo(ServerInfo, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
  MyIniFile.WriteString('settings', 'ServerInfo', ServerInfo);

  //Yanniel: Replaced with the code below
  //case rdOption.ItemIndex of
  //  0: MyIniFile.WriteString('settings', 'BackupDatabase', '1');
  //  1: MyIniFile.WriteString('settings', 'BackupDatabase', '0');
  //  else
  //    MyIniFile.WriteString('settings', 'BackupDatabase', '1');
  //end;

  //Yanniel: This code replaces the commented code above
  case rdBackupHostType.ItemIndex of
    0: MyIniFile.WriteString('settings', 'BackupDatabase', '1');
    1: MyIniFile.WriteString('settings', 'BackupDatabase', '0');
  else
    MyIniFile.WriteString('settings', 'BackupDatabase', '1');
  end;

  MyIniFile.WriteString('settings', 'BackupDir', GetBackupPath);
  MyIniFile.WriteString('settings', 'Database', EdtDababase.Text);


  case cbxLanguage.ItemIndex of
   0: MyIniFile.WriteString('settings', 'DefaultLanguage', '1');
   1: MyIniFile.WriteString('settings', 'DefaultLanguage', '2');
   2: MyIniFile.WriteString('settings', 'DefaultLanguage', '3');
   else
     MyIniFile.WriteString('settings', 'DefaultLanguage', '1');
  end;

  MyIniFile.Free;
  DBConnection.Close;
  Action := caFree; 
end;

procedure TFrmBackUpRestoreDB.btnCloseClick(Sender: TObject);
begin

  Close;

end;

procedure TFrmBackUpRestoreDB.btnNextClick(Sender: TObject);
begin

  SetNextPage;
  
end;

procedure TFrmBackUpRestoreDB.btnBackClick(Sender: TObject);
begin

  SetPriorPage;

end;

procedure TFrmBackUpRestoreDB.sbOpenFileClick(Sender: TObject);
const
  SELDIRHELP = 1000;
var
  dir: String;
begin
  if rdBackupHostType.ItemIndex = 1 then
  begin
    dir := sPath;
    if SelectDirectory( dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP ) then
      if Notebook.ActivePage = 'pgBackupOptions' then
      begin
        edtBKPPath.Text := dir;
        Exit;
      end;
  end; 

  if OD.FileName = '' then
     OD.FileName := EdtDababase.Text + '_' + FormatDateTime('dddd', now) + '_' + GetComputerNetName + '.BAK';

  if OD.Execute then
    if Notebook.ActivePage = 'pgRestOptions' then
       begin
       edtRSTPath.Text := OD.FileName;
       GetRestoreFileInfo;
       end
    else if Notebook.ActivePage = 'pgBackupOptions' then
     edtBKPPath.Text := OD.FileName;

end;

procedure TFrmBackUpRestoreDB.FormCreate(Sender: TObject);
var
  sResult : String;
  FrmServrInfo : TFrmServerInfo;
  b : Boolean;
  buildInfo: String;
  Encoded_UNC_Password: string;
begin
  MappedDriveConnected:= False;
  MappedDrive:= '';
  sLocalPath := ExtractFilePath(ParamStr(0));
  MyIniFile:= TIniFile.Create(sLocalPath+CONFIG_FILE);
  //try
    TFrmMsgConstant.Create(Self);

    if MyIniFile.ReadString('settings', 'DefaultLanguage', '') = '' then
       DMGlobal.IDLanguage := LANG_ENGLISH
    else
       DMGlobal.IDLanguage := StrToInt(MyIniFile.ReadString('settings', 'DefaultLanguage', '1'));

    cbxLanguage.ItemIndex := (DMGlobal.IDLanguage-1);

    if MyIniFile.ReadString('settings', 'LangPath', '') = '' then
       MyIniFile.WriteString('settings', 'LangPath', sLocalPath + LANG_DIRECTORY);

    DMGlobal.LangFilesPath := MyIniFile.ReadString('settings', 'LangPath', '');


  SetCaptions;

  //Pegar os Parametros 1 - DataBase, 2 - Backup Path,
  //3 - user name, and 4 - password
  Try
     FrmServrInfo  := TFrmServerInfo.Create(self);
     sResult       := FrmServrInfo.Start('4', False, '', b);
  Finally
     FrmServrInfo.Free;
  end;

  //Server
  edtServer.Text    := ParseParam(sResult, '#SRV#');
  //DataBase
  EdtDababase.Text  := ParseParam(sResult, '#DB#');
  //UserName
  edtUserName.Text  := ParseParam(sResult, '#USER#');
  //Password
  edtPW.Text        := ParseParam(sResult, '#PW#');

  case MyIniFile.ReadInteger('settings',   'BackupDatabase', 1) of
    0: rdBackupHostType.ItemIndex:= 1;
    1: rdBackupHostType.ItemIndex:= 0;
  end;                                    

  sDB             := MyIniFile.ReadString('settings', 'Database',       'MainRetailDB');
  sPath           := MyIniFile.ReadString('settings', 'BackupDir',      'C:\MainRetail\MRBackup\');

  //**** MR-77: Enforcing a default backup path ***
  if (Trim(sPath) = '') then
  begin
    sPath := 'C:\MainRetail\MRBackup\';
    if not DirectoryExists(sPath) then
       ForceDirectories(sPath);
  end;
  //***********************************************
    
  sUNC_Path := MyIniFile.ReadString('settings',     'UNC_Path',     '');
  sUNC_Username := MyIniFile.ReadString('settings', 'UNC_Username', '');
  Encoded_UNC_Password := MyIniFile.ReadString('settings', 'UNC_Password', '');
  if Encoded_UNC_Password <> '' then
    sUNC_Password := DecodeServerInfo(Encoded_UNC_Password,  '{22120846-70F0-4E13-ACF1-BECE2F20CC2B}', CIPHER_TEXT_STEALING, FMT_UU)
  else
    sUNC_Password := '';
end;

function TFrmBackUpRestoreDB.DoAutoBackup:Boolean;
begin

  try
    Screen.Cursor    := crHourGlass;

    rbFile.Checked         := True;
    rdBKPOverwrite.Checked := True;

    if not DirectoryExists(sPath) then
       CreateDir(sPath);

    if sPath[Length(sPath)] = '\' then
       sPath := sPath + sDB + '_' + FormatDateTime('dddd', now) + '_' + GetComputerNetName + '.BAK'
    else
       sPath := sPath + '\' + sDB + '_' + FormatDateTime('dddd', now) + '_' + GetComputerNetName + '.BAK';

    //Database
    EdtDababase.Text        := sDB;
    //Local Path for Backup
    edtBKPPath.Text   := sPath;

    Result := SetConnection;

    if not Result then
       MsgBox(MSG_CRT_NO_CONECTION, vbCritical + vbOkOnly)
    else
    begin

       If ( rdBackupHostType.ItemIndex = 0 {bBackupDatabase = True} )
       Then Result := DoBackUp;

       if not Result then
          MsgBox(MSG_CRT_ERROR_BACKUP, vbCritical + vbOKOnly)
       { Begin Alex 08/08/2011 }
       else
          begin
            //*** Yanniel 26/03/2012 ***
            if not MappedDriveConnected then
              MappedDriveConnected:= ConnectNetDrive(sUNC_Path, sUNC_Username, sUNC_Password, MappedDrive);

            BackupDB(sPath);
            if ChkBxZipClientFolders.Checked then
              BackupClientFilesAndFolders;

            if MappedDriveConnected then
            begin
               if DisconnectNetDrive(MappedDrive) then
                 MappedDriveConnected:= False;
            end;
            //**************************
          end
       { End Alex 08/08/2011   }
    end;                 
  finally
    Screen.Cursor := crDefault;
    end;

end;

procedure TFrmBackUpRestoreDB.SetCaptions;
begin

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sRestoringDB     := 'Restoring Database. Please wait ...';
           sRestoringDBFail := 'Restoring Database failed !';
           sCreatingZip     := 'Creating Zip file. Please wait ... ';
           sCreatingZipFail := 'Create Zip file failed !';
           sStartBackup     := 'Starting to Backup Database. Please wait ... ';
           sStartBackupFail := 'Backup Database failed !';
           sServer          := 'Server : ';
           sDataBase        := 'Database name : ';
           sFile            := 'File : ';
           sFilePropertyO   := 'File Property : Overwrite';
           sFileProprrtyA   := 'File Property : Append';
           sBackup          := 'Backup';
           sZipBkp          := 'Zip Backup and delete original file : True';
           sZipFileName     := 'Zip file : ';
           sBkpClientFiles  := 'Backup Client Files and Folders : True';
           sRestore         := 'Restore';
           sFromFile        := 'From File : ';
           sRestoreOverDB   := 'Option : restore over an existing DB';
           sLogicalData     := 'Logical Data : ';
           sDataPath        := 'Data Path    : ';
           sLogicalLog      := 'Logical Log  : ';
           sLogParh         := 'Log Path     : ';
           sNext            := 'Ne&xt >>';
           sConnect         := '&Connect';
           sBackupDBName    := 'Select a database name that you want to backup.';
           sRestoreDBName   := 'Select a database name that you want to restore.';
           sLogicalName     := 'Logical file name';
           sMoveToPhis      := 'Move to physical file name';
           sForceRestOn1    := 'Force restore on the "';
           sForceRestOn2    := '" database.';
           sFinish          := '&Finish';
           end;

     LANG_PORTUGUESE :
           begin
           sRestoringDB     := 'Restaurando banco de dados. Por favor espere ...';
           sRestoringDBFail := 'Erro durante restauração do banco de dados !';
           sCreatingZip     := 'Criando arquivo zip. Por favor espere ... ';
           sCreatingZipFail := 'Erro criando arquivo zip !';
           sStartBackup     := 'Iniciando o backup do banco de dados. Por favor espere ... ';
           sStartBackupFail := 'Erro durante o backup !';
           sServer          := 'Servidor : ';
           sDataBase        := 'Nome do Banco de dados : ';
           sFile            := 'Arquivo : ';
           sFilePropertyO   := 'Propriedades do arquivo : Reescrever';
           sFileProprrtyA   := 'Propriedades do arquivo : Incluir';
           sBackup          := 'Backup';
           sZipBkp          := 'Zip Backup : Sim';
           sZipFileName     := 'Arquivo Zip : ';
           sBkpClientFiles  := 'Backup Arquivos e Pastas do Cliente : True';
           sRestore         := 'Restaurar';
           sFromFile        := 'Arquivo : ';
           sRestoreOverDB   := 'Opção : Restaurar sobre um banco de dados existente';
           sLogicalData     := 'Dado lógico   : ';
           sDataPath        := 'Caminho Dado  : ';
           sLogicalLog      := 'Log Lógico    : ';
           sLogParh         := 'Caminho Log   : ';
           sNext            := 'Pró&ximo >>';
           sConnect         := '&Conectar';
           sBackupDBName    := 'Selecione o nome de banco de dados que voçê desaja fazer o backup.';
           sRestoreDBName   := 'Selecione o nome de banco de dados que voçê desaja fazer a restauração.';
           sLogicalName     := 'Nome do arquivo lógico';
           sMoveToPhis      := 'Mover para o nome do arquivo físico';
           sForceRestOn1    := 'Forçar a restauração sobre o banco de dados "';
           sForceRestOn2    := '".';
           sFinish          := '&Finalizar';
           end;

     LANG_SPANISH :
           begin
           sRestoringDB     := 'Restaurando base de datos. Por favor espere ...';
           sRestoringDBFail := 'Error durante la restauración de la base de datos !';
           sCreatingZip     := 'Creando archivo zip. Por favor espere ... ';
           sCreatingZipFail := 'Error creando archivo zip !';
           sStartBackup     := 'Iniciando el backup de la base de datos. Por favor espere ... ';
           sStartBackupFail := 'Error durante el backup !';
           sServer          := 'Servidor : ';
           sDataBase        := 'Nombre de la Base de Datos : ';
           sFile            := 'Archivo : ';
           sFilePropertyO   := 'Propriedades del archivo : Sobreescriba';
           sFileProprrtyA   := 'Propriedades del archivo : Incluir';
           sBackup          := 'Backup';
           sZipBkp          := 'Zip Backup : Sí';
           sZipFileName     := 'Archivo Zip : ';
           sBkpClientFiles  := 'Backup Archivos e Pastas del Cliente : Sí';
           sRestore         := 'Restaurar';
           sFromFile        := 'Archivo : ';
           sRestoreOverDB   := 'Opción : Restaurar sobre una base de datos existente';
           sLogicalData     := 'Dato lógico : ';
           sDataPath        := 'Camino Dado : ';
           sLogicalLog      := 'Log Lógico : ';
           sLogParh         := 'Camino Log : ';
           sNext            := 'Siguiente >>';
           sConnect         := '&Conectar';
           sBackupDBName    := 'Seleccione el nombre de la base de datos que usted desea hacer el backup.';
           sRestoreDBName   := 'Seleccione el nombre de la base de datos que usted desea hacer la restauración.';
           sLogicalName     := 'Nombre del archivo lógico';
           sMoveToPhis      := 'Mover para el archivo físico';
           sForceRestOn1    := 'Obligar la restauración sobre la base de datos "';
           sForceRestOn2    := '".';
           sFinish          := '&Finalizar';
           end;
   end;

end;


procedure TFrmBackUpRestoreDB.rbSQLClick(Sender: TObject);
begin
  //Validate Fields
  if rbSQL.Checked then
     begin
     edtUserName.Color    := clWindow;
     edtUserName.ReadOnly := False;
     edtPW.Color          := edtUserName.Color;
     edtPW.ReadOnly       := edtUserName.ReadOnly;
     end
  else
     begin
     edtUserName.Color    := clMenu;
     edtUserName.ReadOnly := True;
     edtPW.Color          := edtUserName.Color;
     edtPW.ReadOnly       := edtUserName.ReadOnly;
     end;
end;

procedure TFrmBackUpRestoreDB.cbxLanguageChange(Sender: TObject);
begin
  if cbxLanguage.ItemIndex <> (DMGlobal.IDLanguage-1) then
     DMGlobal.IDLanguage := cbxLanguage.ItemIndex+1;
end;

function TFrmBackUpRestoreDB.IsInConfigMode: Boolean;
const
  cConfigFlag = '--config';
var
  i: Integer;
begin
  Result:= False;

  //Let’s assume that the application might have multiple command
  //line parameters. We need to lookup for "--config" in any position.
  for i:=1 to ParamCount do
    if LowerCase(ParamStr(i)) = cConfigFlag then
    begin
      Result:= True;
      Break;
    end;
end;

//Yanniel 11/03/2012
Procedure TFrmBackUpRestoreDB.BackupDB(aBackupPath: string);
var
  RemotePath: string;
begin
  if rdBackupHostType.ItemIndex <> 0 then Exit;

  RemotePath:= GetBackupPath; //ExtractFileName(aBackupPath);
  RemotePath:= MappedDrive + '\' + ExtractFileName(aBackupPath);

  if chkZipBackUp.Checked then
  begin
    Zipper( ExtractFilePath( aBackupPath ),
             StringReplace( aBackupPath, '.BAK', '.7z', [rfIgnoreCase] ),
             True,
             ExtractFileName( aBackupPath ) );
    DeleteFile( aBackupPath );

    aBackupPath:= StringReplace(aBackupPath, '.BAK', '.7z', [rfIgnoreCase]);
    RemotePath:= StringReplace(RemotePath,   '.BAK', '.7z', [rfIgnoreCase]);
  end;
  
  if MappedDriveConnected then
    CopyFile(PChar(aBackupPath), PChar(RemotePath), False);
end;

Procedure TFrmBackUpRestoreDB.BackupClientFilesAndFolders;
Var
  ProgramFilesDir,
  sDia,
  sPCName : String;
  SystemDrive: string; //Yanniel 12/03/2012: Added

  BackupPath: string;
Begin
  sDia := '_' + FormatDateTime( 'dddd', Now ) + '_';
  sPCName:= GetComputerNetName;
  ProgramFilesDir := ReturnWindowsFolder();
  BackupPath:= GetBackupPath; 

  SystemDrive:= ExtractFileDrive(ProgramFilesDir);
  Zipper( ProgramFilesDir + '\MainRetail', BackupPath + 'INIFiles'+ sDia + sPCName +'.7z', True, '*.ini' );
  Zipper( ProgramFilesDir + '\MainRetail\Replication', BackupPath + 'Replication'+ sDia + sPCName +'.7z', True, '*.ini' ); //Yanniel 12/03/2012: Added

  Zipper( SystemDrive + '\MainRetail\Labels\Store Custom Labels',       BackupPath + 'Labels'+ sDia + sPCName +'.7z',        True );
  Zipper( SystemDrive + '\MainRetail\MRPoleDisplay\Store Custom Media', BackupPath + 'MRPoleDisplay'+ sDia + sPCName +'.7z', True );
  Zipper( SystemDrive + '\MainRetail\Receipts\Store Customer Receipts', BackupPath + 'Receipts'+ sDia + sPCName +'.7z',      True );
  Zipper( SystemDrive + '\MainRetail\Receipts\Store Logos',             BackupPath + 'Logos'+ sDia + sPCName +'.7z',         True );
  Zipper( SystemDrive + '\MainRetail\Reports\Store Custom Reportes',    BackupPath + 'Reports'+ sDia + sPCName +'.7z',       True );

  //Yanniel: Copy the local backup files to a remote location (server)
  if MappedDriveConnected then
  begin
    CopyFile(PChar(BackupPath    + 'INIFiles'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                           + 'INIFiles'+ sDia + sPCName +'.7z'),
             False );
    CopyFile(PChar(BackupPath    + 'Replication'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                           + 'Replication'+ sDia + sPCName +'.7z'),
             False );
    CopyFile(PChar(BackupPath    + 'Labels'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                    + 'Labels'+ sDia   + sPCName +'.7z'),
             False );
    CopyFile(PChar(BackupPath    + 'MRPoleDisplay'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                           + 'MRPoleDisplay'  + sDia + sPCName +'.7z'),
             False );
    CopyFile(PChar(BackupPath    + 'Receipts'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                           + 'Receipts'+ sDia + sPCName +'.7z'),
             False );
    CopyFile(PChar(BackupPath    + 'Logos'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                           + 'Logos'+ sDia + sPCName +'.7z'),
             False );
    CopyFile(PChar(BackupPath    + 'Reports'+ sDia + sPCName +'.7z'),
             PChar(MappedDrive                           + 'Reports'+ sDia + sPCName +'.7z'),
             False );
  end;
End;

procedure TFrmBackUpRestoreDB.Button1Click(Sender: TObject);
begin
 
  Zipper( 'C:\SQL_Bakcup', StringReplace( 'C:\SQL_Bakcup\F.BAK', '.BAK', '.7z', [rfIgnoreCase] ),
          True,
          ExtractFileName( 'C:\SQL_Bakcup\F.BAK' ) );

end;

procedure TFrmBackUpRestoreDB.labConfigureNetworkDriveClick(
  Sender: TObject);
var
  Encoded_UNC_Password: string;
begin
  with TFrmConfigNetworkDrive.Create(nil) do
  begin
    edtFolder.Text   := sUNC_Path;
    edtUsername.Text := sUNC_Username;
    edtPassword.Text := sUNC_Password;

    if ShowModal = mrOk then
    begin
      sUNC_Path:= edtFolder.Text;
      sUNC_Username:= edtUsername.Text;
      sUNC_Password:= edtPassword.Text;
      Encoded_UNC_Password:= EncodeServerInfo(sUNC_Password,  '{22120846-70F0-4E13-ACF1-BECE2F20CC2B}', CIPHER_TEXT_STEALING, FMT_UU);

      MyIniFile.WriteString('settings', 'UNC_Path',     sUNC_Path);
      MyIniFile.WriteString('settings', 'UNC_Username', sUNC_Username);
      MyIniFile.WriteString('settings', 'UNC_Password', Encoded_UNC_Password);
    end;
    
    Free;
  end;
end;

function TFrmBackUpRestoreDB.GetBackupPath: string;
begin
  Result:= '';

  if (LowerCase(ExtractFileExt(edtBKPPath.Text)) = '.bak') or
     (LowerCase(ExtractFileExt(edtBKPPath.Text)) = '.7z') then
    Result:= ExtractFilePath( edtBKPPath.Text )
  else if DirectoryExists(edtBKPPath.Text) then
    Result:= edtBKPPath.Text;

  if Result <> '' then
    if Copy(Result, Length(Result) , 1) <> '\' then
      Result:= Result + '\';
end;

end.



