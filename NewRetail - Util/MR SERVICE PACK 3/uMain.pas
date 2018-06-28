unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IniFiles, Registry, ComCtrls, Buttons, Email,
  uDataBaseOperation, uSQLFileReader, Grids, uOperationSystem;

type
  TFrmMain = class(TForm)
    pnlTop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    btnClose: TButton;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    gridRestore: TStringGrid;
    PBar: TProgressBar;
    History: TMemo;
    lbDetail: TLabel;
    lbTotalFiles: TLabel;
    lbBuildVerCount: TLabel;
    sbSendErr: TSpeedButton;
    Email1: TEmail;
    Image1: TImage;
    btnStart: TButton;
    pbScript: TProgressBar;
    chkBackup: TCheckBox;
    lblVersion: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbSendErrClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    VERSION_NO, BUILD_NO, MRBUILD : Integer;
    VER_BUILD  : String;
    IniFile    : TIniFile;
    fReadSQLScript: TReadSQLScript;

    DBOperation : TDataBaseOperation;

    sLocalPath : String;

    procedure SetError(sText:String; sSolution:String);
    procedure SetDetail(sText:String);
    procedure SetWarning(sText:String);

    procedure Start;
    function HasMainRetail:Boolean;
    function ExecUpdate:Boolean;
    function ValidateVerBuild:Boolean;
    function IsOldVersion:Boolean;
    function ComperVersion:Boolean;
    function BackUpDB:Boolean;
    function IsServer:Boolean;
    function ExecVersion:Boolean;
    function ExecBackup: Boolean;
    function UpdateVersion:Boolean;
    function RestoreDB:Boolean;
    function CopyFiles:Boolean;
    procedure Finalize;

    function RunSQLFile(sFile:String):Boolean;
    function ReadIniInt(Section, Ident : String; Default : Integer) : Integer;
    function ReadIniStr(Section, Ident, Default : String) : String;

    function ComperMRVersion:Boolean;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uDM, uMsgBox, uParamFunctions, uCopyFiles, uStringFunctions,
     uSystemConst;

{$R *.DFM}

function TFrmMain.HasMainRetail:Boolean;
var
  buildInfo: String;
begin

  with TRegistry.Create do
  Try

    if ( getOS(buildInfo) = osW7 ) then begin
      RootKey:= HKEY_CURRENT_USER;
    end
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey('SOFTWARE\Applenet\MainRetail', True);
//    Result := ValueExists('DefaultCashRegID');
      result := true;
  finally
     CloseKey;
     Free;
  end;

  if not Result then
     SetError('Error: This computer does not have Main Retail installed.','');

end;


procedure TFrmMain.Finalize;
begin
   btnClose.Enabled    := True;
   sbSendErr.Visible   := False;
   btnStart.Visible    := False;
   lbDetail.Caption    := 'Main Retail update completed.';
   lbDetail.Font.Color := clBlue;
   MsgBox('Main Retail update completed.', vbInformation + vbOKOnly);
end;

procedure TFrmMain.SetError(sText:String; sSolution:String);
begin
   lbDetail.Caption    := sText;
   lbDetail.Font.Color := clRed;
   PBar.Visible        := False;
   btnClose.Enabled    := True;
   sbSendErr.Visible   := True;
   History.Lines.Add(sText);
   History.Lines.Add(sSolution);
   Application.ProcessMessages;
end;

procedure TFrmMain.SetWarning(sText:String);
begin
   lbDetail.Caption    := sText;
   lbDetail.Font.Color := clRed;
   sbSendErr.Visible   := False;
   btnClose.Enabled    := True;
   History.Lines.Add(sText);
   Application.ProcessMessages;
end;

procedure TFrmMain.SetDetail(sText:String);
begin
   lbDetail.Caption := sText;
   History.Lines.Add(sText);
   Application.ProcessMessages;
end;

function TFrmMain.ReadIniStr(Section, Ident, Default : String) : String;
begin
  Result := IniFile.ReadString(Section, Ident, Default);
end;

function TFrmMain.ReadIniInt(Section, Ident : String; Default : Integer) : Integer;
begin
  Result := IniFile.ReadInteger(Section, Ident, Default);
end;


function TFrmMain.RestoreDB:Boolean;
    procedure GetRestoreFileInfo;
    var
    i : integer;
    begin
     with DM.quFreeSQL do
       begin
       if Active then
          Close;
       CommandText := ' RESTORE FILELISTONLY ' +
                      ' FROM DISK = ' + QuotedStr('C:\BackupDB.BAK');
       try
         Open;
       Except
         raise;
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

begin

    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    SetDetail('Restoring database... ');

    Try

        GetRestoreFileInfo;

        if DM.ADOConnection.Connected then
           DM.ADOConnection.Close;
           
        DM.ADORestore.Open;

        DBOperation := TRestoreDataBase.Create;
        DBOperation.Connection := DM.ADORestore;

        DBOperation.DataBaseName := DM.fSQLConnection.DBAlias;

        DBOperation.Device := DEVICE_DISK + QuotedStr('C:\BackupDB.BAK');

        TRestoreDataBase(DBOperation).ForceRestore := RST_REPLACE_DB;

        TRestoreDataBase(DBOperation).LogicalDataName := QuotedStr(Trim(gridRestore.Cells[0, 1]));
        TRestoreDataBase(DBOperation).NewDataPath     := QuotedStr(Trim(gridRestore.Cells[1, 1]));

        TRestoreDataBase(DBOperation).LogicalLogName  := QuotedStr(Trim(gridRestore.Cells[0, 2]));
        TRestoreDataBase(DBOperation).NewLogPath      := QuotedStr(Trim(gridRestore.Cells[1, 2]));

        Try
           Result := (DBOperation.SetSQLExecute = -1);
        except
           on E: Exception do
              begin
              Result := False;
              SetError('Error: ' + E.Message,
              'Solution: Close all Main Retail and restore backup (C:\BackupDB.BAK) manually using the MRBackup.');
              end;
        end;

    finally
      FreeAndNil(DBOperation);
      Screen.Cursor:= crDefault;
    end;

end;


function TFrmMain.BackUpDB:Boolean;
begin

    Result        := True;
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    SetDetail('Backup database... ');

    Try
        DBOperation := TBackUpDataBase.Create;
        DBOperation.Connection := DM.ADOConnection;

        DBOperation.DataBaseName := DM.fSQLConnection.DBAlias;

        TBackUpDataBase(DBOperation).AppendDB := BKP_APPEND_INIT;

        TBackUpDataBase(DBOperation).FilePath := 'C:\BackupDB.BAK';
        DBOperation.Device := DEVICE_DISK + QuotedStr('C:\BackupDB.BAK');

        Try
           Result := (DBOperation.SetSQLExecute = -1);
        except
           raise;
           Result := False;
           Application.ProcessMessages;
        end;

    finally
      FreeAndNil(DBOperation);
      Screen.Cursor:= crDefault;
    end;

end;


function TFrmMain.RunSQLFile(sFile:String):Boolean;
var
   Error : String;
   iSQL  : Integer;
   str   : String;
begin

   Result := False;

   // Antonio 05/05/2016 - original FileExists method seems failed under x64 bits.
   if ( not FileExistsNoMatterXbits(sFile) ) then begin
      exit;
   end;

   fReadSQLScript.LoadFromFile(sFile);
   pbScript.Position := 1;
   pbScript.Max      := fReadSQLScript.ScriptCount;
   str               := fReadSQLScript.GetSQLScript;

   while str <> '' do
     begin
     if not DM.RunSQL(str, Error) then
        begin
        SetError(Error, '');
        Exit;
        end;

     fReadSQLScript.Next;
     str := fReadSQLScript.GetSQLScript;
     pbScript.Position := pbScript.Position+1;
     end;

  Result := True;
end;

function TFrmMain.ExecBackup: Boolean;
begin

  Result := False;

  SetMsgBoxLand(1);

  if MsgBox('Did you create a back-up?', vbSuperCritical + vbYesNo) = vbYes then
    Result := True;

end;

function TFrmMain.ExecVersion:Boolean;
begin
  Result := True;

  SetDetail('Getting update pack version ... ');

  try
     IniFile    := TIniFile.Create(sLocalPath + 'Info.ini');
     VERSION_NO := ReadIniInt('VersionSettings', 'Version', 2);
     BUILD_NO   := ReadIniInt('VersionSettings', 'Build', 0);
     MRBUILD    := ReadIniInt('VersionSettings', 'MRBuild', 0);
  except
     Result := False;
     end;

end;

function TFrmMain.ValidateVerBuild:Boolean;
begin

   Result := False;

   //Error  Build and Version Cannot be Zero
   if ((DM.ClientVersion = 0) and (DM.ClientBuild = 0)) then
      begin
      SetError('Error: Invalid Version or Build.',
      'Contact (www.mainretail.com).');
      Exit;
      end;

   Result := True;

end;

function TFrmMain.IsOldVersion:Boolean;
begin
   Result := ((DM.ClientVersion = 2) and (DM.ClientBuild < 9));
   if Result then
      SetError('Error: The Update Pack is for Main Retail version 3 only.',
               'Solution: Download the correct Update Pack.');
end;

function TFrmMain.ComperVersion:Boolean;
begin
   SetDetail('Comparing versions DB...');
   if ((DM.ClientVersion = 2) and (DM.ClientBuild = 9)) then
      begin
      DM.ClientVersion := 3;
      DM.ClientBuild   := 0;
      end;

   Result := ((DM.ClientVersion <= VERSION_NO) and (DM.ClientBuild < BUILD_NO));
end;

function TFrmMain.IsServer:Boolean;
var
 Reg : TRegistry;
 buildInfo: String;
begin

  SetDetail('Checking SQL installation...');

  Reg := nil;

  Try
     Reg         := TRegistry.Create;

     // acessa a chave CURRENT_USER se Windows 7
     if ( getOS(buildInfo) = osW7 ) then
        reg.RootKey := HKEY_CURRENT_USER
     else
        Reg.RootKey := HKEY_LOCAL_MACHINE;

     Result      := Reg.KeyExists(SQL_REG_PATH);
  Finally
     Reg.CloseKey;
     Reg.Free;
    end;

  {
  if not Result then
     begin
     MsgBox('This is not a Main Retail database server installation._'+
            'First, run the update pack on the "Server Computer".' , vbInformation + vbOKOnly);
     SetError('Error: This is not a Main Retail database server installation.',
              'Solution: Run the update pack on the "Server Computer" first.');
     end;
  }

end;


function TFrmMain.CopyFiles:Boolean;
var
  iCount, i : Integer;
begin

  Result := False;

  SetDetail('Updating files...');

  iCount  := ReadIniInt('CopyFiles', 'DirTotal', 0);

  if iCount = 0 then
     Exit;

   For i := 0 to iCount-1 do
       with TfrmCopyFiles.Create(Self) do
            if not Start(ReadIniStr('CopyFiles', 'Des'+IntToStr(i+1), ''),
                         sLocalPath + ReadIniStr('CopyFiles', 'Dir'+IntToStr(i+1), '')) then
               begin
               SetWarning('Warning: Main Retail files not updated.');
               Exit;
               break;
               end;

  Result := True;

end;


function TFrmMain.UpdateVersion:Boolean;
begin

  Result := True;

  SetDetail('Updating local version...');

  with DM.cmdUpdateVersion do
      begin
      Parameters.ParamByName('Version').Value := VERSION_NO;
      Parameters.ParamByName('Build').Value   := BUILD_NO;
      Parameters.ParamByName('MRBuild').Value := MRBUILD;
      Try
         Execute;
      Except
         raise;
         Result := False;
         end;
      end;

end;

procedure TFrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.Start;
var
  bError, updateBDVersion, updateMRVersion : Boolean;

  procedure SetStep(i:Integer);
  begin
     PBar.Position  := i;
     Application.ProcessMessages;
  end;
begin
   //0-Has Main Retail
   //1-Execute version
   //2-Server Connection
   //3-Compar version (Different version)
   //   3.1 - Is Server (If NO then Error)
   //       3.1.1 - Begin Trans
   //       3.1.2 - Execute update
   //       3.1.3 - Update Version
   //       3.1.4 - If error (Roll Back) then Exit.
   //4-Copy EXE
   //5-Finalize

   bError           := False;
   btnClose.Enabled := False;
   btnStart.Enabled := False;
   PBar.Max := 8;
   SetStep(0);

   if not HasMainRetail then
      Exit;

   if not ExecVersion then
      Exit;

   SetStep(1);

   if not DM.ServerConnection then
      Exit;

   SetStep(2);

   if not ValidateVerBuild then
      Exit;

   if IsOldVersion then
      Exit;

   //Verifica se as versões de BD e de executável são diferentes
   updateBDVersion   := ComperVersion;
   updateMRVersion   := ComperMRVersion;

   if updateBDVersion or updateMRVersion then
      begin

      SetStep(3);

      if IsServer then
      begin
        SetStep(4);

        if chkBackup.Checked then
           if not BackUpDB then
              Exit;
      end;

      SetStep(5);

      try
          DM.ADOConnection.BeginTrans;

          if updateBDVersion then
          begin
            if not ExecUpdate then
               begin
               bError := True;
               btnClose.Enabled := True;
               Exit;
               end;
          end;

          SetStep(6);

          if not UpdateVersion then
             begin
             bError := True;
             btnClose.Enabled := True;
             Exit;
             end;

          SetStep(7);

      finally

           if chkBackup.Checked then
              if bError then
                 RestoreDB
              else
                 DeleteFile('C:\BackupDB.BAK');


          if bError then
             DM.ADOConnection.RollbackTrans
          else
             DM.ADOConnection.CommitTrans;

         end;
      end;

  if not CopyFiles then
     Exit;

  SetStep(8);

  Finalize;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
   sLocalPath          := ExtractFilePath(Application.ExeName);
   fReadSQLScript      := TReadSQLScript.Create;
   fReadSQLScript.Flag := SQL_GO;

   chkBackup.Enabled := IsServer;
end;

function TFrmMain.ExecUpdate:Boolean;
var
   iCount, i, x: Integer;
   sAllVer1     : String;
   sAllVer2     : String;
   sConst      : String;
   iStratPoint : Integer;
   AllVersions : array of String;
   iTotFiles,
   iFileCounter: Integer;
   sSQLFileName: String;
begin

   Result := False;
   Screen.Cursor := crHourglass;
   SetDetail('Executing update... ');


   //Get Versions from INI file
   sAllVer1    := ReadIniStr('VersionUpdates', 'VersionArray1', '');
   sAllVer2    := ReadIniStr('VersionUpdates', 'VersionArray2', '');
   sConst      := ReadIniStr('VersionUpdates', 'VersionConst', '');
   iCount      := ReadIniInt('VersionUpdates', 'VersionTotal', 0);
   iStratPoint := -1;

   if (iCount = 0) or (sAllVer1+sAllVer2 = '') then
      Exit;

   //Fill out version total for array
   SetLength(AllVersions, iCount);

   //Fill out array with the versions from INI file
   For i := 0 to iCount-1 do
       AllVersions[i] := ParseParam(sAllVer1+sAllVer2, sConst + IntToStr(i));

   //Combine Cliente(Version + Build) and search for start point in the array
   VER_BUILD  := IntToStr(DM.ClientVersion) + IntToStr(DM.ClientBuild);
   
   //Get start point for next update
   For i := Low(AllVersions) to High(AllVersions) do begin

(*
      ShowMessage('AllVersion[i] = ' + AllVersions[i] + ' VER_BUILD = ' + VER_BUILD);
      ShowMessage('i = ' + intTostr(i) + ' High(AllVersion) = ' + intToStr(High(AllVersions)));
      showMessage('startPoint = ' + intToStr(iStratPoint) );
 *)
      if (AllVersions[i] = VER_BUILD) and (i <> High(AllVersions)) then
         begin
         iStratPoint := i+1;
         Break;
         end;
   end;

   //No Update
   if iStratPoint = -1 then
      exit;

   pbScript.Visible := True;
   Application.ProcessMessages;


   //Loop for execute the SQL files
   //Actual update to the last one!
   iFileCounter := 0;
   For i := iStratPoint to High(AllVersions) do
       begin
       iTotFiles:=ReadIniInt('Version'+AllVersions[i], 'FileTotal', 1);
       For x := 1 to iTotFiles do
           begin
           sSQLFileName := ReadIniStr('Version'+AllVersions[i], 'File'+IntToStr(x), '');

           
           if ( ssQLFileName = '' ) then begin
              continue;
           end;

           lbBuildVerCount.Caption := 'File ('+IntToStr(x)+') of '+IntToStr(iTotFiles)+'.';
           SetDetail('File name: ' + sSQLFileName);

           if not RunSQLFile(sLocalPath + sSQLFileName) then
              begin
              Screen.Cursor := crDefault;
              Exit;
              Break;
              end
           else
              inc(iFileCounter);
           end;
       end;

   lbBuildVerCount.Caption := '';
   lbTotalFiles.Caption    := 'Total files executed('+IntToStr(iFileCounter)+')';

   Result           := True;
   pbScript.Visible := False;
   Screen.Cursor    := crDefault;
   Application.ProcessMessages;
end;

procedure TFrmMain.btnStartClick(Sender: TObject);
begin
  if ExecBackup then
    Start;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(IniFile);
end;

procedure TFrmMain.sbSendErrClick(Sender: TObject);
begin
   with Email1 do
      begin
      Subject := 'Main Retail update pack error.';
      Body    := History.Text;
      CopyTo.Add('asouza@pinogy.com');
      CopyTo.Add('antoniom_desenv@yahoo.com.br');
      Sendmail;
      end;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  fReadSQLScript.Free;
end;

function TFrmMain.ComperMRVersion: Boolean;
begin
   SetDetail('Comparing versions EXE...');
   Result := DM.ClientMRBuild <= MRBUILD;
end;

end.
