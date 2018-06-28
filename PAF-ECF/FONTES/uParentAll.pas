unit uParentAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, siComp, siLangRT;

type
  TFrmParentAll = class(TForm)
    siLang: TsiLangRT;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    fLangLoaded : Boolean;
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal, uMSGBox, uMsgConstant, uDM;

{$R *.dfm}

procedure TFrmParentAll.FormCreate(Sender: TObject);
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

end;

end.
