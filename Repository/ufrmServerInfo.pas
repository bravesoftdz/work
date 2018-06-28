unit ufrmServerInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Registry,
  StdCtrls, ExtCtrls, Buttons;

type
  TFrmServerInfo = class(TForm)
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtUser: TEdit;
    edtPassword: TEdit;
    edtDatabase: TEdit;
    menInfo: TMemo;
    pnlInfo: TPanel;
    Label5: TLabel;
    lbInfo: TLabel;
    btnOK: TSpeedButton;
    procedure edtServerEnter(Sender: TObject);
    procedure edtUserEnter(Sender: TObject);
    procedure edtPasswordEnter(Sender: TObject);
    procedure edtDatabaseEnter(Sender: TObject);
    procedure edtServerExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetText(Num:Integer);
  public
    { Public declarations }
    function Start(StrartType:Char; IsError:Boolean):String;
  end;

implementation

uses uEncryptFunctions, uParamFunctions, uSystemConst;

{$R *.DFM}

procedure TFrmServerInfo.SetText(Num:Integer);
var
 sText : String;
begin

  menInfo.Clear;

  Case Num of
    1: sText := 'Enter the IP address of the MSSQL Server.';
    2: sText := 'Enter the login user name to connect the MSSQL Server Database.';
    3: sText := 'Enter the password to connect the MSSQL Server Database.';
    4: sText := 'Enter the MainRetail Database name.';
  end;

  menInfo.Text := sText;

end;

function TFrmServerInfo.Start(StrartType:Char; IsError:Boolean):String;
var
  sPW, sUser, sDBAlias, sServer, sResult : String;
  Reg : TRegistry;
begin

  Reg := nil;

  Try
      //Pega o Server IP
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;

      Reg.OpenKey(APPLENET_REGISTRY_KEY, True);

      //Connection error
      if IsError then
         begin

         sResult := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

         edtServer.Text   := ParseParam(sResult, '#SRV#');
         edtDatabase.Text := ParseParam(sResult, '#DB#');
         edtUser.Text     := ParseParam(sResult, '#USER#');
         edtPassword.Text := ParseParam(sResult, '#PW#');

         lbInfo.Font.Color := clRed;
         lbInfo.Caption := 'Network connection error. Check the network connection, Server status, or the client information below, and reinstart Main Retail.';
         ShowModal;

         //Encriptografar os dados;
         sServer  := '#SRV#=' +edtServer.Text  +';';
         sDBAlias := '#DB#='  +edtDatabase.Text+';';
         sUser    := '#USER#='+edtUser.Text    +';';
         sPW      := '#PW#='  +edtPassword.Text+';';

         //Encriptografar os dados;
         sResult := sServer + sDBAlias + sUser + sPW;
         Reg.WriteString('ServerInfo', EncodeServerInfo(sResult, 'Server', CIPHER_TEXT_STEALING, FMT_UU));

         end;


      if not Reg.ValueExists('ServerInfo') then
         begin
         //#Rod Inicio para o Trial
         if StrartType in ['D', '1'] then
            begin
            sServer  := '(Local)';
            sUser    := 'sa';
            sPW      := 'sauser7740';
            sDBAlias := 'MainRetailDB';
            end
         else
            begin
            lbInfo.Caption := 'The user name, password, and database name are default.';
            ShowModal;
            sServer  := edtServer.Text;
            sUser    := edtUser.Text;
            sPW      := edtPassword.Text;
            sDBAlias := edtDatabase.Text;
            end;

         sServer  := '#SRV#=' +sServer +';';
         sDBAlias := '#DB#='  +sDBAlias+';';
         sUser    := '#USER#='+sUser   +';';
         sPW      := '#PW#='  +sPW     +';';

         //Encriptografar os dados;
         sResult := sServer + sDBAlias + sUser + sPW;
         Reg.WriteString('ServerInfo', EncodeServerInfo(sResult, 'Server', CIPHER_TEXT_STEALING, FMT_UU));
         end;

      Result := DecodeServerInfo(Reg.ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

  finally
     //Fechar o Registry
     Reg.CloseKey;
     Reg.Free;
  end;   

end;

procedure TFrmServerInfo.edtServerEnter(Sender: TObject);
begin

  SetText(1);

end;

procedure TFrmServerInfo.edtUserEnter(Sender: TObject);
begin

  SetText(2);

end;

procedure TFrmServerInfo.edtPasswordEnter(Sender: TObject);
begin
  SetText(3);
end;

procedure TFrmServerInfo.edtDatabaseEnter(Sender: TObject);
begin
   SetText(4);
end;

procedure TFrmServerInfo.edtServerExit(Sender: TObject);
begin
   menInfo.Clear; 
end;

procedure TFrmServerInfo.btnOKClick(Sender: TObject);
begin
 //OK Clicked
   Close;
end;

end.
