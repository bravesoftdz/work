unit PaiDeForms;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, siComp, siLangRT;

type
  TFrmParentForms = class(TForm)
    siLang: TsiLangRT;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    fLangLoaded : Boolean;
    procedure LoadLangFile;
  public
    { Public declarations }
  end;

var
  FrmParentForms: TFrmParentForms;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

procedure TFrmParentForms.LoadLangFile;
begin

  //Setup Language
  if (not fLangLoaded) and (siLang.StorageFile <> '') then
     begin
     if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
        siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
        MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);
     fLangLoaded := True;
     end;

end;

procedure TFrmParentForms.FormCreate(Sender: TObject);
begin

  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);

  Caption := Application.Title;

end;

procedure TFrmParentForms.FormShow(Sender: TObject);
begin

  LoadLangFile;

end;

procedure TFrmParentForms.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // amfsouza 01.28.2011 - if user press shift + F10, supports knows the name of form.
  if ( ssShift in Shift ) and
     ( key = VK_F10 ) then
     showMessage(self.Name);
end;

end.
