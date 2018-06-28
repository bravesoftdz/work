unit uRelatorioErro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmRelatorioErro = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    btnCancela: TBitBtn;
    Panel1: TPanel;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioErro: TfrmRelatorioErro;

implementation

uses uDados;

{$R *.dfm}

procedure TfrmRelatorioErro.FormShow(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Text := Dados.RelatorioErro.Text;
end;

end.
