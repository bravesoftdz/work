unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  uReplicationClasses, StdCtrls, DB, ADODB, uSynchronizationClasses,
  ComCtrls, CheckLst, ExtCtrls, ShellCtrls, ZAbstractConnection,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TFrmMain = class(TForm)
    DBConnection: TADOConnection;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    gbxAutentic: TGroupBox;
    Label7: TLabel;
    rbWindows: TRadioButton;
    rbSQL: TRadioButton;
    edtUserName: TEdit;
    edtPW: TEdit;
    edtServer: TEdit;
    Label5: TLabel;
    TabSheet3: TTabSheet;
    Label10: TLabel;
    EdtDababase: TEdit;
    clbTables: TCheckListBox;
    panFooter: TPanel;
    lbVersion: TLabel;
    btnTestConnection: TButton;
    ADOQuery1: TADOQuery;
    labNumberOfTables: TLabel;
    labExportPath: TLabel;
    edtExportPath: TEdit;
    btnSelectDir: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    slvQueries: TShellListView;
    btnRefreshTables: TButton;
    cbxSelectAllTables: TCheckBox;
    tbSyncTables: TADOTable;
    conMRManagement: TADOConnection;
    qryMRManagement: TADOQuery;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnTestConnectionClick(Sender: TObject);
    procedure clbTablesClickCheck(Sender: TObject);
    procedure btnSelectDirClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnRefreshTablesClick(Sender: TObject);
    procedure cbxSelectAllTablesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FTables,
    FExportPath,
    FConnectionStr: string;

    FSynchronizationINIFile: TSynchronizationINIParams;

    procedure StringListToFile(aStringList: TStringList; aFilename: string);
  public
    { Public declarations }
    function ShowGUI: Boolean;
    function SetConnection: Boolean;
    procedure PopulateTables(aQuery: TADOQuery; aTablesList: TStrings);
    procedure DumpTablesToTSV(aExportPath, aTables: string);

    procedure DumpQueryToTSV(aQueryFileName: string);

    function GetParentFolder(aFoder: string): string;

    function GetDatabaseVersion: string;

    function RefreshTables: Boolean;

    procedure CreateTable(aConnection: TADOConnection);
  end;

resourcestring
  NumberOfTables = '%d tables selected.';

var
  FrmMain: TFrmMain;

implementation

uses
  uSQLObj, uDMGlobal, FileCtrl, DBUtils;

{$R *.dfm}

function GetEnvVar(VarName: string): string;
var
  iResultLength: Integer;
begin
  Result:= '';
  iResultLength := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if iResultLength <> 0 then
  begin
    SetLength(Result, iResultLength - 1);
    GetEnvironmentVariable(PChar(VarName), PChar(Result), iResultLength);
    Result := Trim(Result);
  end;
end;

procedure ParseConnectionString(aConnectionStr: string; out aUser, aPassword, aDataBase, aDataSource: string);
const
  cToken1 = ';Password=';
  cToken2 = ';';
  cToken3 = ';User ID=';
  cToken4 = ';Initial Catalog=';
  cToken5 = ';Data Source=';
begin
  //'Provider=SQLOLEDB.1;Persist Security Info=True;Password=MR_DB_User;User ID=sa;Initial Catalog=MainRetailDB;Data Source=(local)\Pinogy;';
  Delete(aConnectionStr, 1, Pos(cToken1, aConnectionStr) + Length(cToken1) - 1);
  aPassword:= Copy(aConnectionStr, 1, Pos(cToken2, aConnectionStr) - 1);

  Delete(aConnectionStr, 1, Pos(cToken3, aConnectionStr) + Length(cToken3) - 1);
  aUser:= Copy(aConnectionStr, 1, Pos(cToken2, aConnectionStr) -1);

  Delete(aConnectionStr, 1, Pos(cToken4, aConnectionStr) + Length(cToken4) - 1);
  aDataBase:= Copy(aConnectionStr, 1, Pos(cToken2, aConnectionStr) -1);

  Delete(aConnectionStr, 1, Pos(cToken5, aConnectionStr) + Length(cToken5) -1);
  aDataSource:= Copy(aConnectionStr, 1, Pos(cToken2, aConnectionStr) -1);
end;

function ComposeConnectionString(aUser, aPassword, aDataBase, aDataSource: string): string;
begin
  Result:= 'Provider=SQLOLEDB.1;' +
           'Persist Security Info=True;' +
           'Password=' + aPassword + ';' +
           'User ID=' + aUser + ';' +
           'Initial Catalog=' + aDataBase + ';' +
           'Data Source=' + aDataSource + ';';
end;

function TFrmMain.ShowGUI: Boolean;
const
  cConfigFlag = '--config';
var
  i: Integer;
begin
  Result:= False;

  //Let’s assume that the application might have multiple command
  //line parameters. We need to lookup for "--auto" in any position.
  for i:=1 to ParamCount do
    if LowerCase(ParamStr(i)) = cConfigFlag then
    begin
      Result:= True;
      Break;
    end;
end;

procedure TFrmMain.CreateTable(aConnection: TADOConnection);
var
  RecordsAffected: Integer;
begin
  aConnection.Execute('CREATE TABLE SyncTables(Tables varchar(128) NOT NULL PRIMARY KEY);', RecordsAffected, []);
end;

function TFrmMain.SetConnection: Boolean;
var
  MRManagement_Database_Exists: Boolean;
begin
  Result := False;
  Screen.Cursor:= crHourGlass;

  try
    with DBConnection do
    begin
      if Connected then Close;

      //Update "FConnectionStr"
      FConnectionStr:= 'Provider=SQLOLEDB.1;' +
                     'Persist Security Info=True;' +
                     'Password='        + edtPW.Text       + ';' +  //'Password=MR_DB_User;' +
                     'User ID='         + edtUserName.Text + ';' +  //'User ID=sa;' +
                     'Initial Catalog=' + edtDababase.Text + ';' +  //'Initial Catalog=MainRetailDB;' +
                     'Data Source='     + edtServer.Text   + ';';   //'Data Source=(local)\Pinogy;';
      FConnectionStr:= ComposeConnectionString(edtUserName.Text,  edtPW.Text, edtDababase.Text, edtServer.Text);


      ConnectionString:= FConnectionStr; //'Provider=SQLOLEDB.1;Persist Security Info=True;Password=MR_DB_User;User ID=sa;Initial Catalog=MainRetailDB;Data Source=(local)\Pinogy;';
      Open;
    end;

    // *** Configuring ZeosLib connection ***
    ZConnection1.Database:=  'Provider=SQLOLEDB.1;' +
                     'Persist Security Info=False;' +
                     'User ID='         + edtUserName.Text + ';' +  //'User ID=sa;' +
                     'Initial Catalog=' + edtDababase.Text + ';' +  //'Initial Catalog=MainRetailDB;' +
                     'Data Source='     + edtServer.Text   + ';';   //'Data Source=(local)\Pinogy;';
    ZConnection1.Password:= edtPW.Text;   //'MR_DB_User';
    ZConnection1.user:= edtUserName.Text; // 'sa';
    ZConnection1.Connect;
    // **************************************

    MRManagement_Database_Exists:= DatabaseExists(qryMRManagement, 'MRManagement');

    if not MRManagement_Database_Exists  then
      CreateDatabase(qryMRManagement, 'MRManagement');

    with conMRManagement do
    begin
      if Connected then Close;
      ConnectionString:= StringReplace(FConnectionStr, edtDababase.Text, 'MRManagement', []);
      Open;
    end;

    if not MRManagement_Database_Exists  then
    begin
      qryMRManagement.Connection:=  conMRManagement;
      CreateTable(conMRManagement);
    end;

    Result := DBConnection.Connected and
              ZConnection1.Connected and
              conMRManagement.Connected;
    Screen.Cursor:= crDefault;

  except
    Result := False;
    Screen.Cursor:= crDefault;
  end;
end;

procedure TFrmMain.PopulateTables(aQuery: TADOQuery; aTablesList: TStrings);
var
  i: Integer;
  SortedTablesList: TStringList;
begin
  if not Assigned(aQuery) then Exit;
  if not Assigned(aTablesList) then Exit;

  SortedTablesList:= TStringList.Create;
  SortedTablesList.Sorted:= True;

  try
    aQuery.First;
    for I:= 0 to aQuery.RecordCount - 1 do
    begin
      SortedTablesList.Add(aQuery.FieldByName('name').AsString);
      aQuery.Next;
    end;

    aTablesList.Clear;
    for I:= 0 to SortedTablesList.Count - 1 do
      aTablesList.Add(SortedTablesList[i]);

  finally
    SortedTablesList.Clear;
    SortedTablesList.Free;
  end;
end;

procedure TFrmMain.DumpTablesToTSV(aExportPath, aTables: string);
var
  TableList: TStringList;
  TableSerializer: TDataSetSerializer;
  i: Integer;
  s: string;
begin
  TableList:= TStringList.Create;
  TableSerializer:= TDataSetSerializer.Create(DBConnection);
  try
    TableList.CommaText:= aTables;

    for i:= 0 to TableList.Count - 1 do
    begin
      //s:= aExportPath + '\'  + edtDababase.Text + '\'  + GetDatabaseVersion + '\';
      s:= aExportPath + '\'  + edtDababase.Text + '\';
      ForceDirectories(s);

      //TableSerializer.SaveAsXML(aExportPath, TableList[i]);
      TableSerializer.SaveAsTSV(s, TableList[i]);
    end;

  finally
    TableList.Free;
    TableSerializer.Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  strTables,
  INIFileName: string;
  i: Integer;
  IsConnected: Boolean;

  User,
  Password,
  DataBase,
  DataSource,
  QueriesDir: string;
begin
  INIFileName:= ExtractFilePath(ParamStr(0)) + 'MRManager.ini';

  //if not FileExists(INIFileName) then Exit;

  FSynchronizationINIFile:= TSynchronizationINIParams.Create(INIFileName);

  with FSynchronizationINIFile.Create(INIFileName) do
  begin
    FConnectionStr:= ConnectionStr; 
    FExportPath:= ExportPath;
  end;

  if FExportPath = '' then
  begin
    // We thought about using "SparkleShare\pds" as FExportPath,
    // but then we decided to hard code it as C:\Pinogy\MRManager
    //FExportPath:= GetEnvVar('USERPROFILE') + '\SparkleShare\pds';
    FExportPath:= 'C:\Pinogy\MRManager';
  end;

  if FExportPath = '' then
    FExportPath:= GetCurrentDir;

  QueriesDir:= FExportPath + '\Query\';
  ForceDirectories(QueriesDir);
  if SysUtils.DirectoryExists(QueriesDir) then
    slvQueries.Root:= QueriesDir;

  if not ShowGUI then
  begin
    IsConnected:= SetConnection;
    if IsConnected then
      RefreshTables;
  end;   

  if ShowGUI then
  begin
    //Display "Connection Settings"
    ParseConnectionString(FConnectionStr, User, Password, DataBase, DataSource);
    edtServer.Text:= DataSource;
    EdtDababase.Text:= DataBase;
    edtUserName.Text:= User;
    edtPW.Text:= Password;

    //Display "Tables"
    //if IsConnected then
    //begin
    //  Query(ADOQuery1, 'SELECT * FROM sys.Tables;');
    //  PopulateTables(ADOQuery1, clbTables.Items);
    //  strTables:= StringReplace(','+ FTables + ',', ' ', '', [rfReplaceAll]);
    //  clbTables.Tag:= 0;
    //  for i:= 0 to clbTables.Count - 1 do
    //  begin
    //    if Pos(','+ clbTables.Items[i] + ',', strTables) > 0 then
    //    begin
    //      clbTables.Checked[i]:= True;
    //      clbTables.Tag:= clbTables.Tag + 1;
    //    end;
    //  end;
    //  labNumberOfTables.Caption:= Format(NumberOfTables, [clbTables.Tag]);
    //end;

    //Display "Miscellaneous"
    edtExportPath.Text:= FExportPath;
  end;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  try
    if ModalResult = mrOK then
    begin
      //Update "FConnectionStr"
      FConnectionStr:= 'Provider=SQLOLEDB.1;' +
                       'Persist Security Info=True;' +
                       'Password='        + edtPW.Text       + ';' +  //'Password=MR_DB_User;' +
                       'User ID='         + edtUserName.Text + ';' +  //'User ID=sa;' +
                       'Initial Catalog=' + edtDababase.Text + ';' +  //'Initial Catalog=MainRetailDB;' +
                       'Data Source='     + edtServer.Text   + ';';   //'Data Source=(local)\Pinogy;';
     FConnectionStr:= ComposeConnectionString(edtUserName.Text,  edtPW.Text, edtDababase.Text, edtServer.Text);


     //*** Update "FTables" ****
     if DBConnection.Connected then
     begin
       if not tbSyncTables.Active then
         tbSyncTables.Active:= True;

       //Remove from the DB those table names which are not selected
       for i:= 0 to clbTables.Count - 1 do
       begin
         if tbSyncTables.Locate('Tables', clbTables.Items[i], []) then
           if not clbTables.Checked[i] then
             tbSyncTables.Delete;
       end;

       //Insert in the DB those table names which are selected
       for i:= 0 to clbTables.Count - 1 do
       begin
         if not tbSyncTables.Locate('Tables', clbTables.Items[i], []) then
           if clbTables.Checked[i] then
           begin
             tbSyncTables.Insert;
             tbSyncTables.FieldByName('Tables').AsString:= clbTables.Items[i];
             tbSyncTables.Post;
           end;
         end;
       end;
     end;

     //Update "FExportPath"
     FExportPath:= edtExportPath.Text;
     with FSynchronizationINIFile do
     begin
       ConnectionStr:= FConnectionStr;
       ExportPath:= FExportPath;
     end;

  finally
    FSynchronizationINIFile.Free;
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  i: Integer;
begin
  if not ShowGUI then
  begin
    DumpTablesToTSV(FExportPath, FTables);

    if SysUtils.DirectoryExists(slvQueries.Root) then
      for i:=0 to slvQueries.Items.Count -1 do
        DumpQueryToTSV(slvQueries.Folders[i].PathName);
    Close;
  end;
end;

procedure TFrmMain.btnTestConnectionClick(Sender: TObject);
begin
  if SetConnection then
  begin
    MessageDlg('Successfully connected to the database.', mtInformation, [mbOk], 0);
    RefreshTables;
  end
  else
    MessageDlg('An error occurred while connecting to the database.', mtError, [mbOk], 0);
end;

procedure TFrmMain.clbTablesClickCheck(Sender: TObject);
begin
  if clbTables.ItemIndex < 0 then Exit;

  if clbTables.Checked[clbTables.ItemIndex] then
    clbTables.Tag:= clbTables.Tag + 1
  else
    clbTables.Tag:= clbTables.Tag - 1;

  cbxSelectAllTables.Checked:= clbTables.Tag = clbTables.Count;
  labNumberOfTables.Caption:= Format(NumberOfTables, [clbTables.Tag])
end;

procedure TFrmMain.btnSelectDirClick(Sender: TObject);
const
  SELDIRHELP = 1000; //???
var
  dir: string;
begin
  dir := FExportPath;
  if SelectDirectory( dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP ) then
    edtExportPath.Text := dir;
end;

procedure TFrmMain.btnOKClick(Sender: TObject);
begin
  Close;
end;

function TFrmMain.GetDatabaseVersion: string;
begin
  Result:= '000'; //This is a default value, probably due to an error
  SelectSQL(ADOQuery1, 'select * from Sys_Module;');
  if ADOQuery1.RecordCount = 1 then
  begin
    ADOQuery1.First;
    Result:= ADOQuery1.FieldValues['BuildNo'];
  end;
end;

function TFrmMain.GetParentFolder(aFoder: string): string;
begin
  Result:= ExpandFilename(IncludeTrailingPathDelimiter(aFoder)+ '..\');
end;

procedure TFrmMain.StringListToFile(aStringList: TStringList; aFilename: string);
begin
  if not Assigned(aStringList) or (aFilename = '') then Exit;
  try
    aStringList.SaveToFile(aFilename);
  except
  end;
end;

procedure TFrmMain.DumpQueryToTSV(aQueryFileName: string);
var
  QueryFile,
  LogFile: TStringList;
  ZQuery: TZQuery;
  tsvFilename,
  logFilename,
  copyFilename,
  Ext: string;
  allGood: Boolean;
  ErrMessage: string;
begin
  allGood:= False;
  if not FileExists(aQueryFileName) then Exit;

  copyFilename:= ExtractFileName(aQueryFileName);
  Ext:= ExtractFileExt(copyFilename);
  if LowerCase(Ext) <> '.sql' then Exit;

  QueryFile:= TStringList.Create;
  LogFile:= TStringList.Create;
  ZQuery:= TZQuery.Create(nil);
  try
    try
      //ZQuery.CommandTimeout:= 30;
      QueryFile.LoadFromFile(aQueryFileName);
      ZQuery.Connection:= ZConnection1;
      //copyFilename := FExportPath + '\'  + edtDababase.Text + '\'  + GetDatabaseVersion + '\Query' +  copyFilename;
      copyFilename := FExportPath + '\'  + edtDababase.Text + '\Query' +  copyFilename;
      tsvFilename:= StringReplace(copyFilename, Ext, '.tsv', [rfReplaceAll]);
      logFilename:= StringReplace(copyFilename, Ext, '.log', [rfReplaceAll]);

      if SmartQuery(ZQuery, QueryFile.Text, ErrMessage) then
      begin
        if ZQuery.State = dsBrowse then
        begin
          LogFile.Add(Format('(%0:d row(s) selected)', [ZQuery.RecordCount]));
          DataSet2TSV(ZQuery, tsvFilename);
        end else
        begin
          LogFile.Add(Format('(%0:d row(s) affected)', [ZQuery.RowsAffected]));
        end;
        allGood:= True;
      end;

    except
      allGood:= False;
    end;
  finally
    if allGood then
    begin
      DeleteFile(aQueryFileName);
    end else
    begin
      if ErrMessage <> '' then
        LogFile.Add(ErrMessage);

      if CopyFile(PChar(aQueryFileName), PChar(copyFilename), False ) then
        DeleteFile(aQueryFileName);
    end;

    StringListToFile(LogFile, logFilename);

    QueryFile.Clear;
    QueryFile.Free;
    LogFile.Clear;
    LogFile.Free;
    ZQuery.Free;
  end;
end;

function TFrmMain.RefreshTables: Boolean;
var
  i: Integer;
  strTables: string;
begin
  Result:= False;
  try
    Result:= SetConnection;
    if Result then
    begin
      FTables:= '';
      if not tbSyncTables.Active then
        tbSyncTables.Active:= True;

      tbSyncTables.First;
      for i:=0 to tbSyncTables.RecordCount -1 do
      begin
        FTables:= FTables + tbSyncTables.FieldByName('Tables').AsString;
        if i <> tbSyncTables.RecordCount -1 then
          FTables:= FTables + ',';
        tbSyncTables.Next;
      end; 

      //Display "Tables"
      SelectSQL(ADOQuery1, 'SELECT * FROM sys.Tables;');
      PopulateTables(ADOQuery1, clbTables.Items);
      strTables:= StringReplace(','+ FTables + ',', ' ', '', [rfReplaceAll]);
      clbTables.Tag:= 0;
      for i:= 0 to clbTables.Count - 1 do
      begin
        if Pos(','+ clbTables.Items[i] + ',', strTables) > 0 then
        begin
          clbTables.Checked[i]:= True;
          clbTables.Tag:= clbTables.Tag + 1;
        end;
      end;
      cbxSelectAllTables.Checked:= clbTables.Tag = clbTables.Count;
      labNumberOfTables.Caption:= Format(NumberOfTables, [clbTables.Tag]);
    end;
  except
    Result:= False;
  end;
end;

procedure TFrmMain.btnRefreshTablesClick(Sender: TObject);
begin
  if not RefreshTables then
    MessageDlg('An error occurred while connecting to the database.', mtError, [mbOk], 0);
end;

procedure TFrmMain.cbxSelectAllTablesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  if cbxSelectAllTables.Checked then
    clbTables.Tag:= 0
  else
    clbTables.Tag:= clbTables.Count;

  for I:=0 to clbTables.Count - 1 do
  begin
    clbTables.Checked[I]:= not cbxSelectAllTables.Checked;
  end;

  labNumberOfTables.Caption:= Format(NumberOfTables, [clbTables.Tag]); 
end;

end.
