unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, gbCobranca, ExtCtrls;

type
  TForm1 = class(TForm)
    pnlBoleto: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    butVisualizar: TButton;
    butImprimir: TButton;
    txtCodigoBanco: TEdit;
    txtNossoNumero: TEdit;
    txtNomeBanco: TEdit;
    txtDigitoNossoNumero: TEdit;
    pnlRemessaRetorno: TPanel;
    gbTitulo1: TgbTitulo;
    gbCobranca1: TgbCobranca;
    lblNomeArquivoRemessa: TLabel;
    txtNomeArquivoRemessa: TEdit;
    butProcurarRemessa: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    lblNomeArquivoRetorno: TLabel;
    txtNomeArquivoRetorno: TEdit;
    butProcurarRetorno: TButton;
    butGerarRemessa: TButton;
    butLerRetorno: TButton;
    rdgLayoutArquivoRemessa: TRadioGroup;
    GroupBox1: TGroupBox;
    txtRelatorioRetorno: TMemo;
    procedure txtCodigoBancoExit(Sender: TObject);
    procedure txtNossoNumeroExit(Sender: TObject);
    procedure butVisualizarClick(Sender: TObject);
    procedure butImprimirClick(Sender: TObject);
    procedure butProcurarRemessaClick(Sender: TObject);
    procedure butGerarRemessaClick(Sender: TObject);
    procedure butProcurarRetornoClick(Sender: TObject);
    procedure butLerRetornoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

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

procedure TForm1.butProcurarRemessaClick(Sender: TObject);
begin
   SaveDialog1.FileName := txtNomeArquivoRemessa.Text;
   SaveDialog1.InitialDir := ExtractFilePath(txtNomeArquivoRemessa.Text);
   if SaveDialog1.Execute then
      txtNomeArquivoRemessa.Text := SaveDialog1.FileName;
end;

procedure TForm1.butGerarRemessaClick(Sender: TObject);
begin
   gbCobranca1.Titulos.Clear;

   if trim(txtNomeArquivoRemessa.Text) = '' then
      if SaveDialog1.Execute then
         txtNomeArquivoRemessa.Text := SaveDialog1.FileName
      else
         Exit;

   gbCobranca1.DataArquivo := Now();
   case rdgLayoutArquivoRemessa.ItemIndex of
      0 : gbCobranca1.LayoutArquivo := laCNAB240;
      1 : gbCobranca1.LayoutArquivo := laCNAB400
   else
      gbCobranca1.LayoutArquivo := laOutro;
   end;
   gbCobranca1.NomeArquivo := txtNomeArquivoRemessa.Text;
   gbCobranca1.Titulos.Add(gbTitulo1);
   gbCobranca1.GerarRemessa;
   txtRelatorioRetorno.Clear;
   txtRelatorioRetorno.Lines.AddStrings(gbCobranca1.Relatorio);   
end;

procedure TForm1.butProcurarRetornoClick(Sender: TObject);
begin
   OpenDialog1.FileName := txtNomeArquivoRetorno.Text;
   OpenDialog1.InitialDir := ExtractFilePath(txtNomeArquivoRetorno.Text);
   if OpenDialog1.Execute then
      txtNomeArquivoRetorno.Text := OpenDialog1.FileName;
end;

procedure TForm1.butLerRetornoClick(Sender: TObject);
begin
   gbCobranca1.Titulos.Clear;

   if trim(txtNomeArquivoRetorno.Text) = '' then
      if OpenDialog1.Execute then
         txtNomeArquivoRetorno.Text := OpenDialog1.FileName
      else
         Exit;

   gbCobranca1.NomeArquivo := txtNomeArquivoRetorno.Text;
   gbCobranca1.LerRetorno;
   txtRelatorioRetorno.Clear;
   txtRelatorioRetorno.Lines.AddStrings(gbCobranca1.Relatorio);   
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   txtCodigoBanco.Text := gbTitulo1.Cedente.ContaBancaria.Banco.Codigo;
   txtNomeBanco.Text := gbTitulo1.Cedente.ContaBancaria.Banco.Nome;
   txtNossoNumero.Text := gbTitulo1.NossoNumero;
   txtDigitoNossoNumero.Text := gbTitulo1.DigitoNossoNumero;
   case gbCobranca1.LayoutArquivo of
      laCNAB240 : rdgLayoutArquivoRemessa.ItemIndex := 0;
      laCNAB400 : rdgLayoutArquivoRemessa.ItemIndex := 1
   else
      rdgLayoutArquivoRemessa.ItemIndex := 2;
   end;
end;

end.
