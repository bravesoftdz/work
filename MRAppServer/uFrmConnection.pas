unit uFrmConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ADODB, Registry, IniFiles, uParamFunctions, DB;

type
  TFrmConnection = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    Label1: TLabel;
    cbxConnection: TComboBox;
    edtDriverName: TLabeledEdit;
    edtBlobSize: TLabeledEdit;
    edtHostName: TLabeledEdit;
    edtDataBase: TLabeledEdit;
    edtUser: TLabeledEdit;
    edtPassword: TLabeledEdit;
    chkUseLib: TCheckBox;
    ADODBConnect: TADOConnection;
    BtnConnection: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbxConnectionSelect(Sender: TObject);
    procedure BtnConnectionClick(Sender: TObject);
  private
    fConFile : TIniFile;

    Function CheckConnection() : Boolean;

    procedure GetConnections;
    procedure SetConnection(sCon:String);
    procedure GetConnection(sCon:String);
    procedure ClearFields;
  public
    function Start : Boolean;
  end;

implementation

uses uMain;

{$R *.dfm}

procedure TFrmConnection.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(fConFile);
  Action := caFree;
end;

function TFrmConnection.Start: Boolean;
begin
   GetConnections;
   ShowModal;
   Result := (ModalResult = mrOK);
end;

procedure TFrmConnection.FormCreate(Sender: TObject);
begin
  fConFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + frmMain.GetConfigFile);
end;

procedure TFrmConnection.GetConnections;
begin
  fConFile.ReadSections(cbxConnection.Items);
  ClearFields;
end;

procedure TFrmConnection.GetConnection(sCon: String);
begin
  with fConFile do
  begin
    edtDriverName.Text := ReadString(sCon, 'DriverName', '');
    edtBlobSize.Text   := ReadString(sCon, 'BlobSize', '');
    edtHostName.Text   := ReadString(sCon, 'HostName', '');
    edtDataBase.Text   := ReadString(sCon, 'DataBase', '');
    chkUseLib.Checked  := ReadBool(sCon, 'UseNetLib', False);
    edtUser.Text       := frmMain.Decode('User', ReadString(sCon, 'User', ''));
    edtPassword.Text   := frmMain.Decode('PW', ReadString(sCon, 'Password', ''));
  end;
end;

procedure TFrmConnection.ClearFields;
begin
  edtDriverName.Text := 'SQLOLEDB.1';
  edtBlobSize.Text   := '-1';
  cbxConnection.Text := '';
  edtHostName.Clear;
  edtDataBase.Clear;
  edtUser.Clear;
  edtPassword.Clear;
end;

procedure TFrmConnection.SetConnection(sCon:String);
begin

  with fConFile do
  begin
    WriteString(sCon, 'DriverName', edtDriverName.Text);
    WriteString(sCon, 'BlobSize', edtBlobSize.Text);
    WriteString(sCon, 'HostName', edtHostName.Text);
    WriteString(sCon, 'DataBase', edtDataBase.Text);
    WriteString(sCon, 'User', frmMain.Encode('User', edtUser.Text));
    WriteString(sCon, 'Password', frmMain.Encode('PW', edtPassword.Text));
    WriteBool(sCon, 'UseNetLib', chkUseLib.Checked);
  end;

end;

procedure TFrmConnection.btnSaveClick(Sender: TObject);
begin

  if cbxConnection.Text <> '' then
  begin
    SetConnection(cbxConnection.Text);
    GetConnections;
  end;

end;

procedure TFrmConnection.cbxConnectionSelect(Sender: TObject);
begin
  if cbxConnection.Text <> '' then
     GetConnection(cbxConnection.Text);
end;

Function TFrmConnection.CheckConnection: Boolean;
Var
  sDadosDoRegistro : String;
Begin

  Try

    sDadosDoRegistro := SetConnectionStr(edtUser.Text, edtPassword.Text, edtDataBase.Text, edtHostName.Text);

    ADODBConnect.Close();
    ADODBConnect.ConnectionString := sDadosDoRegistro;
    ADODBConnect.Open;

    MessageDlg( 'Connection OK', mtInformation, [mbOk], 0 )

  Except
    On E:Exception Do Begin

      MessageDlg( 'Connection Error "' + E.Message + '"', mtError, [mbOk], 0 )

    End;
  End;


End;

{
Function TFrmConnection.OpenConnection( psDataBaseAlias : String = '' ) : Boolean;
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
}
procedure TFrmConnection.BtnConnectionClick(Sender: TObject);
begin
  CheckConnection();
end;

end.
