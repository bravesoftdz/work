unit Principal;

interface

uses
  SysUtils, Types, Classes, Variants, Forms, Controls, Sintegra, Menus,
  ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    Panel1   : TPanel;
    Label1   : TLabel;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Gerao1: TMenuItem;
    Gerararquivoparaentrega1: TMenuItem;
    emrpesa1: TMenuItem;
    Label2: TLabel;
    lbInfo: TLabel;
    procedure Gerararquivoparaentrega1Click(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure emrpesa1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uGeraArquivo, uEmpresa, uDados, uDM;

{$R *.dfm}  

procedure TfrmPrincipal.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.Gerararquivoparaentrega1Click(Sender: TObject);
begin
  with TfrmGeraArquivo.Create(Self) do
  begin
    ShowModal;
    Release;
    frmPrincipal.SetFocus;
  end;
end;

procedure TfrmPrincipal.emrpesa1Click(Sender: TObject);
begin
   with TfrmEmpresa.Create(Self) do
      Start;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  lbInfo.Caption := 'Conectado em ' + DM.fMRDatabase.DatabaseName;
end;

end.

