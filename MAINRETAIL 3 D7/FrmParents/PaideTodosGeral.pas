{ ** 10/11/98
  Esta UNIT é modelo (pai) de alguns forms do Sistema que, ao contrário do
  frmParent, não possuem painel do nome do menu/submenu nem painel do nome
  do usuário. }

unit PaideTodosGeral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, StdCtrls,
  ExtCtrls, LblEffct, Buttons, siLangRT, siComp;

type
  TFrmParentAll = class(TForm)
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    btClose: TButton;
    EspacamentoEsquerdo: TPanel;
    EspacamentoDireito: TPanel;
    EspacamentoSuperior: TPanel;
    siLang: TsiLangRT;
    sbHelp: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    fLangLoaded : Boolean;
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}

procedure TFrmParentAll.FormCreate(Sender: TObject);
begin

  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);

end;

procedure TFrmParentAll.FormShow(Sender: TObject);
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

end.
