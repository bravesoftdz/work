unit uFrmSQLInstall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, ComCtrls;

Const
  SQL_REG_PATH = 'Software\Microsoft\MSSQLServer\MSSQLServer\CurrentVersion';
  SQL_INSTALL_REG_PATH = 'Software\Microsoft\MSSQLServer\Setup';
  SQL_MSDE_INSTALL = '\MSDE\setup.exe SECURITYMODE=SQL SAPWD=7740 DISABLENETWORKPROTOCOLS=0';

type
  TFrmSQLInstall = class(TForm)
    pnlBottom: TPanel;
    btnClose: TSpeedButton;
    Notebook: TNotebook;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbOwner: TLabel;
    lbVersion: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Label8: TLabel;
    pnlInstallSQL: TPanel;
    Label9: TLabel;
    btnInstallMSDE: TSpeedButton;
    Panel1: TPanel;
    pnlInitInstall: TPanel;
    lbInstallWarning: TLabel;
    btnCancelInstall: TSpeedButton;
    pnlInstalling: TPanel;
    lbInstallInfo: TLabel;
    lbInstalledInfo: TLabel;
    Image2: TImage;
    btnStartMSDE: TSpeedButton;
    rgConnect: TRadioGroup;
    Label5: TLabel;
    edtPw: TEdit;
    edtName: TEdit;
    btnLogin: TSpeedButton;
    Label6: TLabel;
    lbError: TLabel;
    chkLibDB: TCheckBox;
    btnRestart: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLoginClick(Sender: TObject);
    procedure btnInstallMSDEClick(Sender: TObject);
    procedure btnCancelInstallClick(Sender: TObject);
    procedure NotebookPageChanged(Sender: TObject);
    procedure btnStartMSDEClick(Sender: TObject);
    procedure rgConnectClick(Sender: TObject);
    procedure btnRestartClick(Sender: TObject);
  private
    { Private declarations }
    SQLIsInstalled,
    SQLIsLogged : boolean;
    procedure InstallMSDE;
    procedure DetectLocalSQL;
    function IsConnected:Boolean;
    function IsSQL2000:Boolean;
    function GetSQLInstallPath:String;
  public
    { Public declarations }
    function Start(var User, pw, InstallPath : String; var bIsLoggedIn : Boolean):Boolean;
  end;


implementation

uses uDM, Registry, uParamFunctions, uMsgBox, uFileFunctions, uOperationSystem;

{$R *.DFM}

function TFrmSQLInstall.IsSQL2000:Boolean;
begin
  Result := False;
  if lbVersion.Caption <> '' then
     Result := Copy(lbVersion.Caption,1,2) = '8.';
end;

procedure TFrmSQLInstall.DetectLocalSQL;
var
  Reg : TRegistry;
begin

  //Verify SQL if exists in the registry
  SQLIsLogged := False;
  Reg := nil;
  Try
     Reg         := TRegistry.Create;
     Reg.RootKey := HKEY_LOCAL_MACHINE;
     if Reg.KeyExists(SQL_REG_PATH) then
        begin
        Notebook.PageIndex := 0;
        Reg.OpenKey(SQL_REG_PATH, False);
        lbVersion.Caption := Reg.ReadString('CurrentVersion');
        lbOwner.Caption   := Reg.ReadString('RegisteredOwner');
        SQLIsInstalled    := True;
        end
     else
        begin
        Notebook.PageIndex := 1;
        end;
  Finally
     Reg.CloseKey;
     Reg.Free;
    end;

end;

function TFrmSQLInstall.GetSQLInstallPath:String;
var
  Reg : TRegistry;
begin
  Reg := nil;
  Try
     Reg          := TRegistry.Create;
     Reg.RootKey  := HKEY_LOCAL_MACHINE;
     Reg.OpenKey(SQL_INSTALL_REG_PATH, False);
     Result       := Reg.ReadString('SQLPath');
  Finally
     Reg.CloseKey;
     Reg.Free;
    end;

end;

function TFrmSQLInstall.Start(var User, pw, InstallPath : String; var bIsLoggedIn : Boolean):Boolean;
begin

  Notebook.PageIndex := 2;
  DetectLocalSQL; //Verify if SQL Server is installed

  //SQL already exist
  if Notebook.PageIndex = 0 then
     begin
     if not IsConnected then
        begin
        ShowModal;
        end;
     end
  else
    ShowModal;

  Result      := SQLIsInstalled; //SQl 2000 is installed into this computer
  bIsLoggedIn := SQLIsLogged; //User is logged in on SQL Server
  InstallPath := GetSQLInstallPath;

  if bIsLoggedIn then
     begin
     User := edtName.Text;
     pw   := edtPw.Text;
     end
  else
     begin
     User := '';
     pw   := '';
     end;

end;

procedure TFrmSQLInstall.btnCloseClick(Sender: TObject);
begin
   SQLIsInstalled := False;
   Close;
end;

procedure TFrmSQLInstall.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmSQLInstall.IsConnected:Boolean;
begin

  //Try connection
  DM.Connection.Close;

  if rgConnect.ItemIndex = 0 then
     if chkLibDB.Checked then
        DM.Connection.ConnectionString := SetConnectionStr(edtName.Text, edtPw.Text, 'Master', '(local)')
     else
        DM.Connection.ConnectionString := SetConnectionStrNoNETLIB(edtName.Text, edtPw.Text, 'Master', '(local)')
  else
     DM.Connection.ConnectionString := SetWinConnectionStr('Master', '(local)');
  
  try
     DM.Connection.Open;
     Result := True;
     SQLIsLogged := True;
  except
     on E: Exception do
        begin
        lbError.Caption := 'Error : ' + E.Message;
        Result := False;
        SQLIsLogged := False;
        pnlInstallSQL.Visible := True;
        chkLibDB.Visible := True;
        end;
     end;

end;

procedure TFrmSQLInstall.btnLoginClick(Sender: TObject);
begin

   if not IsSQL2000 then
      begin
      MsgBox('MSDE or SQL 2000 version is old._Uninstall it and run the intallation program again.', vbCritical + vbOKOnly);
      SQLIsInstalled := False;
      Exit;
      end;

   Screen.Cursor := crHourGlass;

   if IsConnected then
      Close;

   Screen.Cursor := crDefault;
     
end;

procedure TFrmSQLInstall.btnInstallMSDEClick(Sender: TObject);
begin
  Notebook.PageIndex := 1;
end;

procedure TFrmSQLInstall.InstallMSDE;
var
  sMSDE : String;
begin

  Screen.Cursor            := crHourGlass;
  btnClose.Enabled         := False;
  pnlInstalling.Visible    := True;
  pnlInitInstall.Visible   := False;

  Application.ProcessMessages;

  sMSDE := ExtractFilePath(Application.ExeName) + SQL_MSDE_INSTALL;

  Try
     WaitExecute(sMSDE);
     lbInstalledInfo.Caption  := 'MSDE is installed. You must restart your computer now.';
     btnCancelInstall.Enabled := False;
     btnStartMSDE.Enabled     := False;
     btnClose.Enabled         := True;
     btnRestart.Visible       := True;
  Except
     raise;
     btnClose.Enabled := True;
     Screen.Cursor := crDefault;
     end;

  Screen.Cursor := crDefault;

end;


procedure TFrmSQLInstall.btnCancelInstallClick(Sender: TObject);
begin
  Notebook.PageIndex := 0;
end;

procedure TFrmSQLInstall.NotebookPageChanged(Sender: TObject);
begin

   if Notebook.PageIndex = 1 then
      begin
      pnlInstalling.Visible  := False;
      pnlInitInstall.Visible := True;
      end;

end;

procedure TFrmSQLInstall.btnStartMSDEClick(Sender: TObject);
begin
  InstallMSDE;
end;

procedure TFrmSQLInstall.rgConnectClick(Sender: TObject);
begin
   if rgConnect.ItemIndex = 0 then
      begin
      edtName.Enabled := True;
      edtPw.Enabled   := True;
      end
   else
      begin
      edtName.Enabled := False;
      edtPw.Enabled   := False;
      end;
end;

procedure TFrmSQLInstall.btnRestartClick(Sender: TObject);
begin
  ShutdownWin(True);
end;

end.

