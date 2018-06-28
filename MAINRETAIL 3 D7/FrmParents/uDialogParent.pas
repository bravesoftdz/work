unit uDialogParent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, siComp, siLangRT;

type
  TDialogParent = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Cancelar: TButton;
    Aplicar: TButton;
    siLang: TsiLangRT;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialogParent: TDialogParent;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}

procedure TDialogParent.FormShow(Sender: TObject);
begin

  if (DMGlobal.IDLanguage <> LANG_ENGLISH) and (siLang.StorageFile <> '') then
     begin
     if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
        siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
        MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);
     end;

end;

end.
