unit ufrmServerInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Registry,
  StdCtrls, ExtCtrls, Buttons, uOperationSystem;

const
  SV_SERVER     = '#SRV#=';
  SV_DATABASE   = '#DB#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_WIN_LOGIN  = '#WIN#=';
  SV_USE_NETLIB = '#NLIB#=';
    
type
  TFrmServerInfo = class(TForm)
    Label1: TLabel;
    edtServer: TEdit;
    Label4: TLabel;
    edtDatabase: TEdit;
    GroupBox1: TGroupBox;
    lbPW: TLabel;
    edtUser: TEdit;
    edtPassword: TEdit;
    rbWin: TRadioButton;
    rbSQL: TRadioButton;
    lbInfo: TLabel;
    btnAbort: TBitBtn;
    btnOK: TBitBtn;
    pnlServer: TPanel;
    Image1: TImage;
    lbDisplay: TLabel;
    Bevel1: TBevel;
    chkUseLib: TCheckBox;
    procedure rbSQLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fRegistryKey : String;
    procedure LoginControls;
  public
    { Public declarations }
    function Start(StrartType:Char; IsError:Boolean; sMSG:String; var bAbort:Boolean):String;
    function StartWithValues(Connection : String; bShowForm : Boolean):String;
    property RegistryKey : String read fRegistryKey write fRegistryKey;
  end;

implementation

uses uEncryptFunctions, uParamFunctions;

{$R *.DFM}

procedure TFrmServerInfo.LoginControls;
begin
  edtUser.Enabled     := rbSQL.Checked;
  edtPassword.Enabled := rbSQL.Checked;
  lbPW.Enabled        := rbSQL.Checked;
end;

function TFrmServerInfo.StartWithValues(Connection : String; bShowForm : Boolean):String;
var
  sPW, sUser, sDBAlias, sServer, sWinLogin, sLib : String;
  sValues : String;
begin

    Result  := Connection;

    try
      sValues := DecodeServerInfo(Connection, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
    except
      sValues := SV_SERVER   +'0.0.0.0;'+
                 SV_DATABASE +'CustomerDB;'+
                 SV_USER     +'none;'+
                 SV_PASSWORD +'none;'+
                 SV_WIN_LOGIN+'N;'+
                 SV_USE_NETLIB+'N;';
      end;

    if not bShowForm then
       begin
       Result := sValues;
       Exit;
       end;


    if sValues <> '' then
       begin
       edtServer.Text    := ParseParam(sValues, SV_SERVER);
       edtDatabase.Text  := ParseParam(sValues, SV_DATABASE);
       edtUser.Text      := ParseParam(sValues, SV_USER);
       edtPassword.Text  := ParseParam(sValues, SV_PASSWORD);
       rbSQL.Checked     := (ParseParam(sValues, SV_WIN_LOGIN)='N');
       chkUseLib.Checked := (ParseParam(sValues, SV_USE_NETLIB)='Y');
       LoginControls;
       end;

    ShowModal;

    if (ModalResult = mrAbort) then
       Exit;

    //Encriptografar os dados;
    sServer   := SV_SERVER   +edtServer.Text  +';';
    sDBAlias  := SV_DATABASE +edtDatabase.Text+';';
    sUser     := SV_USER     +edtUser.Text    +';';
    sPW       := SV_PASSWORD +edtPassword.Text+';';

    if rbWin.Checked then
       sWinLogin := SV_WIN_LOGIN + 'Y;'
    else
       sWinLogin := SV_WIN_LOGIN + 'N;';

    if chkUseLib.Checked then
       sLib := SV_USE_NETLIB + 'Y;'
    else
       sLib := SV_USE_NETLIB + 'N;';

    //Encriptografar os dados;
    sValues := sServer + sDBAlias + sUser + sPW + sWinLogin + sLib;
    Result := EncodeServerInfo(sValues, 'Server', CIPHER_TEXT_STEALING, FMT_UU);

end;

function TFrmServerInfo.Start(StrartType:Char; IsError:Boolean; sMSG:String; var bAbort:Boolean):String;
var
  sPW, sUser, sDBAlias, sServer, sWinLogin, sLib : String;
  Reg : TRegistry;
  buildInfo: String;
begin

  Reg    := nil;
  bAbort := False;
  Result := SV_SERVER   +'(local);'+
            SV_DATABASE +'MainRetailDB;'+
            SV_USER     +'sa;'+
            SV_PASSWORD +'MR_DB_User;'+
            SV_WIN_LOGIN+'N;'+
            SV_USE_NETLIB+'N;';

  if (fRegistryKey = 'ServerInfo') or (fRegistryKey = 'Repli_LocalServer') then
     lbDisplay.Caption := 'Local Server'
  else
     lbDisplay.Caption := 'Remote Server';

  Try
      Reg := TRegistry.Create;

      if ( GetOs(buildInfo) = osW7 ) then
         Reg.RootKey := HKEY_CURRENT_USER
      else
         Reg.RootKey := HKEY_LOCAL_MACHINE;

      Reg.OpenKey('SOFTWARE\AppleNet', True);

      if IsError then
         if sMSG <> '' then
            begin
            lbInfo.Font.Color := clRed;
            lbInfo.Caption    := 'Error: '+sMSG+#10#13+'Try it again!';
            chkUseLib.Visible := True;
            end;

      if not Reg.ValueExists(fRegistryKey) then
         begin
         Reg.WriteString(fRegistryKey, EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));
         IsError := True;
         end;

      Result := DecodeServerInfo(Reg.ReadString(fRegistryKey), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

      edtServer.Text    := ParseParam(Result, SV_SERVER);
      edtDatabase.Text  := ParseParam(Result, SV_DATABASE);
      edtUser.Text      := ParseParam(Result, SV_USER);
      edtPassword.Text  := ParseParam(Result, SV_PASSWORD);
      rbSQL.Checked     := (ParseParam(Result, SV_WIN_LOGIN)='N');
      chkUseLib.Checked := (ParseParam(Result, SV_USE_NETLIB)='Y');
      LoginControls;

(*
      if not ((StrartType in ['1','2','3','4']) and (IsError)) then
         Exit;
*)

      ShowModal;

      if (ModalResult = mrAbort) then
         begin
         bAbort := True;
         Exit;
         end;

      //Encriptografar os dados;
      sServer   := SV_SERVER   +edtServer.Text  +';';
      sDBAlias  := SV_DATABASE +edtDatabase.Text+';';
      sUser     := SV_USER     +edtUser.Text    +';';
      sPW       := SV_PASSWORD +edtPassword.Text+';';
      if rbWin.Checked then
         sWinLogin := SV_WIN_LOGIN + 'Y;'
      else
         sWinLogin := SV_WIN_LOGIN + 'N;';

      if chkUseLib.Checked then
         sLib := SV_USE_NETLIB + 'Y;'
      else
         sLib := SV_USE_NETLIB + 'N;';

      //Encriptografar os dados;
      Result := sServer + sDBAlias + sUser + sPW + sWinLogin + sLib;

      // this line bellow should not be in that point... in fact should be recorded if that connection can open the database.
      Reg.WriteString(fRegistryKey, EncodeServerInfo(Result, 'Server', CIPHER_TEXT_STEALING, FMT_UU));

  finally
     //Fechar o Registry
     Reg.CloseKey;
     Reg.Free;
  end;

end;

procedure TFrmServerInfo.rbSQLClick(Sender: TObject);
begin
  LoginControls;
end;

procedure TFrmServerInfo.FormCreate(Sender: TObject);
begin
  fRegistryKey := 'ServerInfo';
end;

end.