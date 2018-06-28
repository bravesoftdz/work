unit uFrmFTPConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Registry, uDMGlobal, siComp;

type
  TFrmFTPConfig = class(TForm)
    pnlConfig: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    sbReset: TSpeedButton;
    sbSave: TSpeedButton;
    sbCancel: TSpeedButton;
    edtFTP: TEdit;
    edtPort: TEdit;
    edtUser: TEdit;
    edtPW: TEdit;
    siLang1: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbCancelClick(Sender: TObject);
    procedure sbResetClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
  private
    { Private declarations }
    myReg : TRegistry;
    sFTP, sPort, sUser, sPW, sResult : String;
  public
    function start:String;
  end;

implementation

uses uMsgBox, uEncryptFunctions;

{$R *.dfm}

{ TFrmFTPConfig }

function TFrmFTPConfig.start: String;
begin

  try
    myReg := TRegistry.Create;
    myReg.RootKey := HKEY_LOCAL_MACHINE;
    myReg.OpenKey('SOFTWARE\AppleNet\CurrentVersions', True);

    ShowModal;
    Result := '';
  finally
    myReg.CloseKey;
    FreeAndNil(myReg);
    end;
end;

procedure TFrmFTPConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmFTPConfig.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmFTPConfig.sbResetClick(Sender: TObject);
begin
  myReg.WriteString('FTPInfo', '0');
  Close;
end;

procedure TFrmFTPConfig.sbSaveClick(Sender: TObject);
begin
   //Save Date
   sFTP  := '#SRV#='+edtFTP.Text+';';
   sPort := '#PRT#='+edtPort.Text+';';
   sUser := '#USR#='+edtUser.Text+';';
   sPW   := '#PW#='+edtPW.Text+';';

   sResult := sFTP + sPort + sUser + sPW;
   myReg.WriteString('FTPInfo', EncodeServerInfo(sResult, 'FTPServer', CIPHER_TEXT_STEALING, FMT_UU));

   MsgBox('Please restart again!', vbOKOnly + vbInformation);
   Close;

end;

end.
