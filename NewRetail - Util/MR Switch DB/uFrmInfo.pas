unit uFrmInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

const
  SV_SERVER     = '#SRV#=';
  SV_DATABASE   = '#DB#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_WIN_LOGIN  = '#WIN#=';
  SV_USE_NETLIB = '#NLIB#=';

type
  TFrmInfo = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    edtServer: TEdit;
    edtDatabase: TEdit;
    GroupBox1: TGroupBox;
    lbPW: TLabel;
    edtUser: TEdit;
    edtPassword: TEdit;
    rbWin: TRadioButton;
    rbSQL: TRadioButton;
    chkUseLib: TCheckBox;
    btnAbort: TBitBtn;
    btnOK: TBitBtn;
    pnlServer: TPanel;
    Image1: TImage;
    lbDisplay: TLabel;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(StrConn:String):String;
    function DecodeStr(StrEncoded:String):String;
  end;

implementation

uses uEncryptFunctions, uParamFunctions;

{$R *.dfm}

function TFrmInfo.DecodeStr(StrEncoded:String):String;
begin
  Result := DecodeServerInfo(StrEncoded, 'Server', CIPHER_TEXT_STEALING, FMT_UU);
end;

function TFrmInfo.Start(StrConn:String):String;
var
  sPW, sUser, sDBAlias, sServer, sWinLogin, sLib : String;
begin

  if StrConn <> '' then
     begin
     StrConn := DecodeStr(StrConn);

     edtServer.Text    := ParseParam(StrConn, SV_SERVER);
     edtDatabase.Text  := ParseParam(StrConn, SV_DATABASE);
     edtUser.Text      := ParseParam(StrConn, SV_USER);
     edtPassword.Text  := ParseParam(StrConn, SV_PASSWORD);
     rbSQL.Checked     := (ParseParam(StrConn, SV_WIN_LOGIN)[1]='N');
     chkUseLib.Checked := (ParseParam(StrConn, SV_USE_NETLIB)[1]='Y');
     end;
     
  ShowModal;

  if (ModalResult = mrAbort) then
      begin
      Result := '';
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

  Result := EncodeServerInfo(sServer+sDBAlias+sUser+sPW+sWinLogin+sLib, 'Server', CIPHER_TEXT_STEALING, FMT_UU);

  //Create Connection

end;

end.
