unit ufrmLanguageMR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmLanguage, siComp, siLangRT, siDialog, StdCtrls, ExtCtrls;

type
  TfrmLanguageMR = class(TfrmLanguage)
    btnSetup: TButton;
    procedure btnSetupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses MenuPrincipal, uFchParam;

{$R *.dfm}

procedure TfrmLanguageMR.btnSetupClick(Sender: TObject);
var
  iMOld,
  iSOld : Integer;
begin
  inherited;
  //Chama o FchParam com a opcao de cores do menu
  iMOld     := MainMenu.IDMenu;
  iSOld     := MainMenu.IDSubMenu;

  //Seta o menu de FchParam
  MainMenu.IDMenu       := 8;
  MainMenu.IDSubMenu    := 6;
  MainMenu.FchParamType := PARAM_OPEN_IDIOM;
  MainMenu.SubMenuClick(nil);

  //Volta para o menu anterior
  MainMenu.IDMenu    := iMOld;
  MainMenu.IDSubMenu := iSOld;


end;

end.
