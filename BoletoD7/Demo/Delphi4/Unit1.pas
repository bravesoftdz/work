unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, gbCobranca;

type
  TForm1 = class(TForm)
    gbTitulo1: TgbTitulo;
    butVisualizar: TButton;
    butImprimir: TButton;
    txtCodigoBanco: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtNossoNumero: TEdit;
    Label3: TLabel;
    txtNomeBanco: TEdit;
    txtDigitoNossoNumero: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure txtCodigoBancoExit(Sender: TObject);
    procedure txtNossoNumeroExit(Sender: TObject);
    procedure butVisualizarClick(Sender: TObject);
    procedure butImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
   txtCodigoBanco.Text := gbTitulo1.Cedente.ContaBancaria.Banco.Codigo;
   txtNomeBanco.Text := gbTitulo1.Cedente.ContaBancaria.Banco.Nome;
   txtNossoNumero.Text := gbTitulo1.NossoNumero;
   txtDigitoNossoNumero.Text := gbTitulo1.DigitoNossoNumero;
end;

procedure TForm1.txtCodigoBancoExit(Sender: TObject);
begin
   gbTitulo1.Cedente.ContaBancaria.Banco.Codigo := txtCodigoBanco.Text;
   txtNomeBanco.Text := gbTitulo1.Cedente.ContaBancaria.Banco.Nome;
end;

procedure TForm1.txtNossoNumeroExit(Sender: TObject);
begin
   gbTitulo1.NossoNumero := txtNossoNumero.Text;
   txtDigitoNossoNumero.Text := gbTitulo1.DigitoNossoNumero;
end;

procedure TForm1.butVisualizarClick(Sender: TObject);
begin
   gbTitulo1.Visualizar;
end;

procedure TForm1.butImprimirClick(Sender: TObject);
begin
   gbTitulo1.Imprimir;
end;

end.
