unit FMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, siDialog, IniFiles, ShellAPI,
  DB, Grids, DBGrids, DBClient, AbBase, ABZipper, AbArcTyp, IdHashMessageDigest,
  idHash, abExcept, Mask, DBCtrls, Registry, ADODB, dbcgrids, uParamFunctions,
  uEncryptFunctions, uDataBaseOperation, uOperationSystem;

type
  TFrmMain = class(TForm)
    pgWizard: TPageControl;
    TbsOptions: TTabSheet;
    PnlOptions: TPanel;
    BtnBuild: TBitBtn;
    TbsConfiguration: TTabSheet;
    Label18: TLabel;
    EdtOutPutFolder: TEdit;
    BtnOutputFolder: TSpeedButton;
    OpenFileDialog: TOpenDialog;
    BrowseForFolder: TsiBrowseForFolder;
    CdsFileList: TClientDataSet;
    CdsFileListFILE: TStringField;
    CdsFileListDESTINY_NAME: TStringField;
    CdsFileListTYPE: TStringField;
    DsFileList: TDataSource;
    PgCtrlOptions: TPageControl;
    TbsFilesAndFolders: TTabSheet;
    TbsCommands: TTabSheet;
    CdsFileListCOMMAND: TStringField;
    CdsFileListPARAMETERS: TStringField;
    CtrlGrdCommands: TDBCtrlGrid;
    EdtCommand: TDBEdit;
    Label2: TLabel;
    BtnAddComand: TSpeedButton;
    BtnDeleteCommand: TSpeedButton;
    Label1: TLabel;
    GrdFileList: TDBGrid;
    BtnDeleteItem: TSpeedButton;
    BtnFindFolder: TSpeedButton;
    BtnFindZippedFile: TSpeedButton;
    BtnFindFile: TSpeedButton;
    BtnNewItem: TSpeedButton;
    Label3: TLabel;
    MemoParameters: TDBMemo;
    Label4: TLabel;
    EdtOutputFileName: TDBEdit;
    EdtMasterDatabaseAlias: TEdit;
    Label5: TLabel;
    cmdUpdateMenu: TADOCommand;
    ADODBConnect: TADOConnection;
    ChkBxZipped: TDBCheckBox;
    CdsFileListZIPPED: TStringField;
    LblBuidStep: TLabel;
    procedure BtnOutputFolderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrdFileListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnBuildClick(Sender: TObject);

    Procedure BtnFindFileClick(Sender: TObject);
    Procedure BtnFindFolderClick(Sender: TObject);
    Procedure BtnDeleteItemClick(Sender: TObject);
    procedure BtnNewItemClick(Sender: TObject);
    procedure BtnFindZippedFileClick(Sender: TObject);
    procedure PgCtrlOptionsChange(Sender: TObject);
    procedure pgWizardChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CtrlGrdCommandsExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);


  private
    { Private declarations }
    ctrl: TWinControl;
    iLarguraUltOriginal, iPosition : Integer;

    FBuildIniFile : TIniFile;

    sParameter, sPW, sUser, sDBAlias, sServer : String;

    Function OpenConnection( psDataBaseAlias : String = '' ) : Boolean;

    Function RunAsAdminAndWaitForCompletion( psFileName : String; psParameters : String ): Boolean;
    Function FileMD5Hash( psFileName : String ) : String;
    Function Zipper( psSourceFolderName, psDentinyFileName : String;
                     bDeleteExisting : Boolean = True;
                     psZipMask : String = '' ) : Boolean;
    function Zipper7za(sourceFolderName, destinyFileName: String): boolean;

    Function ParseConnectionParameters( psParameters, psParameterToExtract : String ): String;

    Procedure CloseConnection;
    Procedure CheckCurrentVersionInfo( Var psMainRetailVersion : Integer;
                                       Var psDataBaseVersion   : Integer );

    Procedure BuildMainRetail( pbVerbose : Boolean = False );

    Procedure UpdateFileListGrid(  psValue, psType : String );

    Procedure EmptyDirectories( Directory, FileMask: String; DelSubDirs: Boolean );

    Procedure LoadConfiguration();
    Procedure SaveConfiguration();

    Procedure ResizeGrid;

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Math;

{$R *.dfm}

procedure TFrmMain.BtnOutputFolderClick(Sender: TObject);
begin

  BrowseForFolder.SelectedDir := EdtOutPutFolder.Text;

  If ( BrowseForFolder.Execute() ) Then EdtOutPutFolder.Text := BrowseForFolder.SelectedDir;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

  pgWizard.ActivePage      := TbsOptions;
  PgCtrlOptions.ActivePage := TbsFilesAndFolders;

  LoadConfiguration();

  
end;

Procedure TFrmMain.BuildMainRetail( pbVerbose : Boolean = False );
Var
  sLocalFileMD5Hash,
  sDestinyFile,      sDestinyFileName,
  sCommandLine,      sParameters,
  sBuildIniFileName, sOutputFolderName : String;

  FMainRetailVersion, FMainRetailDBVersion : Integer;
  FLocalBuildIniFile, FManifest : TIniFile;
Begin

  If ( FLocalBuildIniFile <> Nil ) Then FreeAndNil( FLocalBuildIniFile );
  If ( FManifest <> Nil )     Then FreeAndNil( FManifest );


  sBuildIniFileName  := ExtractFileDir(Application.ExeName) + '\MainRetail_Build.ini';
  FLocalBuildIniFile := TIniFile.Create( sBuildIniFileName );
  sOutputFolderName  := FLocalBuildIniFile.ReadString('Setup', 'OUTPUTFOLDERPATH', ExtractFileDir( Application.ExeName ) );

  FManifest := TIniFile.Create( sOutputFolderName + '\MANIFEST.ini' );

  Screen.Cursor := crHourGlass;

  If Not DirectoryExists( sOutputFolderName ) Then Begin

    ForceDirectories( sOutputFolderName )

  End Else Begin

    EmptyDirectories( sOutputFolderName, '*.*', True );

  End;

  Try

    LoadConfiguration();

    CdsFileList.First();
    While Not CdsFileList.Eof Do Begin

      If ( CdsFileList.FieldByName('TYPE').AsString = '' ) Then Begin

        CdsFileList.Next();
        Continue;

      End;

      sDestinyFile     := sOutputFolderName + '\' + CdsFileList.FieldByName('DESTINY_NAME').AsString;
      sDestinyFileName := CdsFileList.FieldByName('DESTINY_NAME').AsString;


      If ( pbVerbose = True ) Then Begin

        LblBuidStep.Visible := True;
        LblBuidStep.Caption :=  'Building ' + sDestinyFileName + '...';

        Application.ProcessMessages();

      End;

      If ( CdsFileList.FieldByName('TYPE').AsString = 'FI' ) Then Begin

        If ( Not FileExists( CdsFileList.FieldByName('FILE').AsString ) ) Then Begin

          MessageDlg( 'File ' +
                      CdsFileList.FieldByName('FILE').AsString +
                      ' not found.' + #13 +
                      'Skipping comand.' ,
                      mtWarning, [mbOK], 0 );

        End Else Begin

          CopyFile( PChar( CdsFileList.FieldByName('FILE').AsString ),
                    PChar( sDestinyFile ), False )

        End;

      End Else If ( CdsFileList.FieldByName('TYPE').AsString = 'FO' ) Then Begin

        //Zipper( CdsFileList.FieldByName('FILE').AsString, sDestinyFile, True );
          Zipper7za(CdsFileList.FieldByName('FILE').AsString, sDestinyFile);

      End Else If ( CdsFileList.FieldByName('TYPE').AsString = 'ZF' ) Then Begin

        //Zipper( ExtractFilePath( CdsFileList.FieldByName('FILE').AsString ),
       //         sDestinyFile, False, ExtractFileName( CdsFileList.FieldByName('FILE').AsString ) );
          Zipper7za( CdsFileList.FieldByName('FILE').AsString, sDestinyFile );

      End Else If ( CdsFileList.FieldByName('TYPE').AsString = 'CM' ) Then Begin

        sCommandLine := CdsFileList.FieldByName('COMMAND').AsString;
        sParameters  := CdsFileList.FieldByName('PARAMETERS').AsString;

        RunAsAdminAndWaitForCompletion( sCommandLine, sParameters );

        { ZIP the new file }
        If ( CdsFileList.FieldByName('ZIPPED').AsString = 'Y' ) Then Begin

          Zipper( ExtractFilePath( sDestinyFile ),
                  StringReplace( sDestinyFile, ExtractFileExt( sDestinyFile ), '.zip', [rfIgnoreCase]),
                  False, ExtractFileName( sDestinyFile ) );

          { Delete the old file }
          DeleteFile( sOutputFolderName + '\' + CdsFileList.FieldByName('DESTINY_NAME').AsString );

          sDestinyFile     := StringReplace( sDestinyFile, ExtractFileExt( sDestinyFile ), '.zip', [rfIgnoreCase]);
          sDestinyFileName := StringReplace( ExtractFileName( sDestinyFile ), ExtractFileExt( sDestinyFile ), '.zip', [rfIgnoreCase]);

        End;

      End;

      If ( FileExists( sDestinyFile ) ) Then Begin

        sLocalFileMD5Hash  := FileMD5Hash( sDestinyFile );

        FManifest.WriteString( 'Files', sDestinyFileName, sLocalFileMD5Hash );

      End;

      CdsFileList.Next;

    End; { While Not CdsFileList.Eof Do Begin }

    If ( pbVerbose = True )
    Then LblBuidStep.Caption :=  'Checking MainRetail version... ';

    CheckCurrentVersionInfo( FMainRetailVersion, FMainRetailDBVersion );

    FManifest.WriteString( 'Versions', 'MR',   IntToStr( FMainRetailVersion ) );
    FManifest.WriteString( 'Versions', 'MRDB', IntToStr( FMainRetailDBVersion ) );

    If ( pbVerbose = True )
    Then LblBuidStep.Visible := False;


  Finally

    If FLocalBuildIniFile <> Nil Then FreeAndNil( FLocalBuildIniFile );
    If FManifest <> Nil     Then FreeAndNil( FManifest );


    Screen.Cursor := crDefault;

  End;

End;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  SaveConfiguration();

end;

Procedure TFrmMain.LoadConfiguration;
Var
  sBuildIniFileName, sListFileName : String;
Begin

  sBuildIniFileName := ExtractFileDir(Application.ExeName) + '\MainRetail_Build.ini';
  FBuildIniFile := TIniFile.Create( sBuildIniFileName );

  EdtOutPutFolder.Text        := FBuildIniFile.ReadString('Setup', 'OUTPUTFOLDERPATH', ExtractFileDir( Application.ExeName ) );
  EdtMasterDatabaseAlias.Text := FBuildIniFile.ReadString('Setup', 'MASTERDATABASEALIAS', ExtractFileDir( Application.ExeName ) );

  CdsFileList.Close();
  CdsFileList.Filter   := '';
  CdsFileList.Filtered := False;

  sListFileName := ExtractFileDir(Application.ExeName) + '\MainRetail_Build_Files.cds';
  If ( FileExists( sListFileName ) )
  Then CdsFileList.LoadFromFile( sListFileName )
  Else CdsFileList.CreateDataSet();

End;

Procedure TFrmMain.SaveConfiguration;
Begin

  FBuildIniFile.WriteString('Setup', 'OUTPUTFOLDERPATH',    EdtOutPutFolder.Text );
  FBuildIniFile.WriteString('Setup', 'MASTERDATABASEALIAS', EdtMasterDatabaseAlias.Text );

  If ( FBuildIniFile <> Nil ) Then FreeAndNil( FBuildIniFile );

  If ( CdsFileList.State in [ dsInsert, dsEdit ] )
  Then CdsFileList.Post();

  CdsFileList.SaveToFile( ExtractFileDir(Application.ExeName) + '\MainRetail_Build_Files.cds' )

End;

Procedure TFrmMain.EmptyDirectories( Directory, FileMask: String; DelSubDirs: Boolean );
Var
  SourceLst: string;
  FOS: TSHFileOpStruct;
Begin

  FillChar(FOS, SizeOf(FOS), 0);

  FOS.Wnd := Application.MainForm.Handle;
  FOS.wFunc := FO_DELETE;
  SourceLst := Directory + '\' + FileMask + #0;
  FOS.pFrom := PChar(SourceLst);

  If Not DelSubDirs
  Then FOS.fFlags := FOS.fFlags OR FOF_FILESONLY;

  FOS.fFlags := FOS.fFlags OR FOF_NOCONFIRMATION;
  FOS.fFlags := FOS.fFlags OR FOF_SILENT;

  SHFileOperation( FOS );

End;

procedure TFrmMain.GrdFileListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If ( ( Key = VK_RETURN ) And ( CdsFileList.State in [ dsInsert, dsEdit ] ) ) Then Begin

    If ( PgCtrlOptions.ActivePage = TbsCommands )
    Then CdsFileList.FieldByName('TYPE').AsString := 'CM';
    CdsFileList.Post();

  End;

End;

Function TFrmMain.OpenConnection( psDataBaseAlias : String = '' ) : Boolean;
Var
  sDadosDoRegistro : String;
  Reg : TRegistry;
  buildInfo: String;
Begin

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
    //sDadosDoRegistro := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    sServer  := ParseConnectionParameters( sDadosDoRegistro, '#SRV#=' );
    sDBAlias := ParseConnectionParameters( sDadosDoRegistro, '#DB#=' );
    sUser    := ParseConnectionParameters( sDadosDoRegistro, '#USER#=' );
    sPW      := ParseConnectionParameters( sDadosDoRegistro, '#PW#=' );

    If ( Trim( psDataBaseAlias ) <> '' )
    Then sDBAlias := psDataBaseAlias;

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

End;

Function TFrmMain.RunAsAdminAndWaitForCompletion( psFileName : String; psParameters : String ): Boolean;
Var

  ShellInformation : TShellExecuteInfo;
  ExitCode: DWORD;

Begin

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

  If ShellExecuteEx( @ShellInformation ) then begin

    Repeat

      Application.ProcessMessages;
      GetExitCodeProcess( ShellInformation.hProcess, ExitCode );

    Until ( (ExitCode <> STILL_ACTIVE) Or ( Application.Terminated ) );

  End;

  Result := ( ExitCode = 0 );

End;

Function TFrmMain.FileMD5Hash(psFileName: String): String;
Var
 idmd5 : TIdHashMessageDigest5;
 fs : TFileStream;
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

Function TFrmMain.Zipper( psSourceFolderName, psDentinyFileName : String;
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

      AbZipper.AddFiles( psZipMask, faArchive );
      AbZipper.Save;
      Result := True;

    Finally

      AbZipper.CloseArchive;
      FreeAndNil( AbZipper );

    End;


  Except

    Result := False;

  End;

End;

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

procedure TFrmMain.CloseConnection;
begin

  if ADODBConnect.Connected then ADODBConnect.Close;

end;


Procedure TFrmMain.CheckCurrentVersionInfo( Var psMainRetailVersion : Integer;
                                            Var psDataBaseVersion   : Integer );
Var
  ADOQuery : TADOQuery;
Begin

    If ( OpenConnection() ) Then Begin

      Try

        ADOQuery := TADOQuery.Create( Self );
        ADOQuery.Connection := Self.ADODBConnect;

        ADOQuery.SQL.Add( 'SELECT MRBUILD, BUILDNO, VERSIONNO FROM SYS_MODULE' );
        ADOQuery.Open();

        psMainRetailVersion := ADOQuery.FieldByName('MRBUILD').AsInteger;
        psDataBaseVersion   := ADOQuery.FieldByName('BUILDNO').AsInteger;

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

procedure TFrmMain.BtnBuildClick(Sender: TObject);
begin

  EdtOutPutFolder.Text := EdtOutPutFolder.Text;
  SaveConfiguration();


  BuildMainRetail( True );

  MessageDlg('Build done',  mtInformation, [mbOk], 0 );

end;

Procedure TFrmMain.BtnFindFileClick(Sender: TObject);
Begin

  OpenFileDialog.FileName  := CdsFileList.FieldByName('FILE').AsString;

  If ( OpenFileDialog.Execute() ) Then  UpdateFileListGrid( OpenFileDialog.FileName, 'FI' );

End;

Procedure TFrmMain.BtnFindFolderClick(Sender: TObject);
Begin

  BrowseForFolder.SelectedDir := CdsFileList.FieldByName('FILE').AsString;

  If ( BrowseForFolder.Execute() ) Then UpdateFileListGrid( BrowseForFolder.SelectedDir, 'FO' );

End;

procedure TFrmMain.BtnDeleteItemClick(Sender: TObject);
begin

  CdsFileList.Delete();

end;

Procedure TFrmMain.UpdateFileListGrid( psValue, psType : String );
Var
 sDestiny_Name,
 sExtension : String;
Begin

  If ( psType =  'FI' )
  Then sExtension := ''
  Else sExtension := '.zip';

  If ( psType =  'ZF' )
  Then sDestiny_Name := StringReplace( ExtractFileName( psValue ), ExtractFileExt( psValue ), '.zip', [rfIgnoreCase])
  Else sDestiny_Name := ExtractFileName( psValue ) + sExtension;

  CdsFileList.Edit();
  CdsFileList.FieldByName('FILE').AsString         := psValue;
  CdsFileList.FieldByName('DESTINY_NAME').AsString := sDestiny_Name;
  CdsFileList.FieldByName('TYPE').AsString         := psType;

  CdsFileList.Post();

End;


procedure TFrmMain.BtnNewItemClick(Sender: TObject);
begin

  CdsFileList.Insert();

end;

procedure TFrmMain.BtnFindZippedFileClick(Sender: TObject);
begin

  OpenFileDialog.FileName  := CdsFileList.FieldByName('FILE').AsString;

  If ( OpenFileDialog.Execute() ) Then  UpdateFileListGrid( OpenFileDialog.FileName, 'ZF' );

end;

procedure TFrmMain.PgCtrlOptionsChange(Sender: TObject);
begin

  CtrlGrdCommands.Visible := False;

  CdsFileList.Filtered := False;

  If ( PgCtrlOptions.ActivePage = TbsFilesAndFolders ) Then Begin

    CdsFileList.Filter := 'TYPE<>''CM''';

  End Else Begin

    CdsFileList.Filter := 'TYPE=''CM''';

  End;

  CdsFileList.Filtered    := True;

  CtrlGrdCommands.Visible := True;

  iLarguraUltOriginal := GrdFileList.Columns[ GrdFileList.FieldCount - 1 ].Width;
  ResizeGrid();

end;

procedure TFrmMain.pgWizardChange(Sender: TObject);
begin

  PgCtrlOptionsChange( Self );

end;

{------------------------------------------------------------------------------}
{ Redimensiona GRID                                                            }
procedure TFrmMain.ResizeGrid;
var
  i, iTotalWidth, iSobra : integer;
begin

  if PgCtrlOptions.ActivePage <> TbsFilesAndFolders Then Exit;

  iTotalWidth := 0;

  for i := 0 to ( GrdFileList.FieldCount - 2 ) do
    iTotalWidth := iTotalWidth + GrdFileList.Columns[i].Width;

  iSobra := GrdFileList.Width - iTotalWidth - 34;

  if iSobra <= 0 then
    exit;

  if iSobra > iLarguraUltOriginal then
    GrdFileList.Columns[ GrdFileList.FieldCount - 1 ].Width := iSobra
  else
    GrdFileList.Columns[ GrdFileList.FieldCount - 1 ].Width := iLarguraUltOriginal;

end;

procedure TFrmMain.FormResize(Sender: TObject);
begin

  ResizeGrid();

end;

function TFrmMain.Zipper7za(sourceFolderName, destinyFileName: String): boolean;
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;

  executeFile: String;
  paramString: String;
begin

(* called example
  //call 7za
  C:\work\Build\7za a "C:\work\Build\Build\MainRetail.zip" "C:\work\MAINRETAIL 3 D7\MainRetail.exe" -mx9 -tzip
*)
    try
      result := false;
      //mount run parameters
      executeFile := 'C:\work\Build\7za';
      paramString := ' a ' +' "'+ destinyFileName + '"' + ' "' + sourceFolderName + '" ' + '-mx9 -tzip';

      FillChar(SEInfo, SizeOf(SEInfo), 0) ;
      SEInfo.cbSize       := SizeOf(TShellExecuteInfo) ;
      SEInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
      SEInfo.Wnd          := Application.Handle;
      SEInfo.lpFile       := PChar(ExecuteFile);
      SEInfo.lpParameters := PChar(paramString);
      SEInfo.nShow        := SW_SHOWNOACTIVATE;

      if ShellExecuteEx(@SEInfo) then begin
        repeat
          Application.ProcessMessages;
          GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
        until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
      end;

      result := true;
   except
         on e: Exception do begin
            raise Exception.Create('Fail to Zip file: ' + paramString + ', ExitCode = ' + IntToStr(ExitCode) + ': ' + e.Message);
            result := false;
         end;
   end;
end;


procedure TFrmMain.CtrlGrdCommandsExit(Sender: TObject);
begin
  //amfsouza 09.06.2011 
  If ( CdsFileList.State in [ dsInsert, dsEdit ] ) Then Begin

    If ( PgCtrlOptions.ActivePage = TbsCommands )
    Then CdsFileList.FieldByName('TYPE').AsString := 'CM';
    CdsFileList.Post();
  End;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   //amfsouza 09.06.2011
   ctrl := CtrlGrdCommands;
   ActiveControl := nil;

   if ( ctrl.CanFocus ) then
      ActiveControl := ctrl;
end;

end.
