unit uParentAllFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, StdCtrls,
  ExtCtrls, siComp, siLangRT;

type
  TParentAllFrm = class(TForm)
    EspacamentoEsquerdo: TPanel;
    EspacamentoDireito: TPanel;
    EspacamentoSuperior: TPanel;
    pnlEspacamentoInferiror: TPanel;
    siLang: TsiLangRT;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}


procedure TParentAllFrm.FormCreate(Sender: TObject);
begin

  //Setup Language  
  if (DMGlobal.IDLanguage <> 1) and (siLang.StorageFile <> '') then
     begin
     if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
        siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
        MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);
     end;

end;

end.
