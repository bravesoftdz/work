unit uPai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, siComp, siLangRT;

type
  TFrmPai = class(TForm)
    pnlButtom: TPanel;
    lblUserName: TLabel;
    Label15: TLabel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btClose: TButton;
    pnlLine: TPanel;
    siLang: TsiLangRT;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    fLangLoaded : Boolean;
  public
    { Public declarations }
  end;

var
  FrmPai: TFrmPai;

implementation

uses uDM, uDMGlobal, uMSGBox, uMSGConstant;

{$R *.dfm}

procedure TFrmPai.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TFrmPai.FormCreate(Sender: TObject);
begin
  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);

  //Load Translation
  if (not fLangLoaded) and (siLang.StorageFile <> '') then
      begin
      if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
         siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
         MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);

      fLangLoaded := True;
      end;

  lblUserName.Caption := DM.fUser.UserName;
end;

end.
