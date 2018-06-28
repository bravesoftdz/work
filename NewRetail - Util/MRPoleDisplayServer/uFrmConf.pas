unit uFrmConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ExtDlgs, siComp;

type
  TFrmConf = class(TForm)
    pnlButtons: TPanel;
    btnClose: TBitBtn;
    btnSave: TBitBtn;
    pgOption: TPageControl;
    tsServer: TTabSheet;
    Label6: TLabel;
    edtPort: TEdit;
    Label7: TLabel;
    edtServerIP: TEdit;
    lbLanguage: TLabel;
    cbxLanguage: TComboBox;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FResult : Boolean;
    procedure LoadConfig;
    procedure SaveConfig;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

{ TFrmScreenConf }

function TFrmConf.Start: Boolean;
begin
  LoadConfig;
  ShowModal;
  Result := FResult;
end;

procedure TFrmConf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmConf.btnCloseClick(Sender: TObject);
begin
  FResult := False;
  Close;
end;

procedure TFrmConf.btnSaveClick(Sender: TObject);
begin
 FResult := True;
 SaveConfig;
 Close;
end;

procedure TFrmConf.LoadConfig;
begin
  edtServerIP.Text := DM.ServerIP;
  edtPort.Text := IntToStr(DM.ServerPort);
  cbxLanguage.ItemIndex := DMGlobal.IDLanguage + 1;
end;

procedure TFrmConf.SaveConfig;
begin
  DM.FConfigFile.WriteString(SVR, SVR_IP, edtServerIP.Text);
  DM.FConfigFile.WriteInteger(SVR, SVR_PORT, StrToIntDef(edtPort.Text, 7887));
  DM.FConfigFile.WriteInteger(SVR, SVR_LANGUAGE, cbxLanguage.ItemIndex+1);
  DM.RefreshSettings;
end;

end.
