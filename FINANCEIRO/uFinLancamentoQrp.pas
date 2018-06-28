unit uFinLancamentoQrp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentReport, DBTables, Qrctrls, quickrpt, ExtCtrls, ADODB, Db;

type
  TFinLancamentoQrp = class(TParentReport)
    dsReport: TDataSource;
    QRSubDetail1: TQRSubDetail;
    PageHeaderBand1: TQRBand;
    lblNome: TQRLabel;
    lblTitulo: TQRLabel;
    QRShape2: TQRShape;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    quQuitacao: TADOQuery;
    QRDBText1: TQRDBText;
    QRDBText14: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText20: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    GroupFooterBand1: TQRBand;
    GroupHeaderBand1: TQRBand;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRShape3: TQRShape;
    QRLabel6: TQRLabel;
    QRDBText27: TQRDBText;
    QRDBText6: TQRDBText;
    QRShape8: TQRShape;
    QRDBText21: TQRDBText;
    QRDBRichText1: TQRDBRichText;
    quReportIDLancamento: TIntegerField;
    quReportPessoaTipo: TStringField;
    quReportDocumentoTipo: TStringField;
    quReportDesdobramentoTipo: TStringField;
    quReportNumDocumento: TStringField;
    quReportNumDesdobramento: TStringField;
    quReportLancamentoTipo: TStringField;
    quReportHistorico: TMemoField;
    quReportDataVencimento: TDateTimeField;
    quReportDataEmissao: TDateTimeField;
    quReportValorNominal: TFloatField;
    quReportSituacao: TStringField;
    quReportContaCorrente: TStringField;
    quReportQuitacaoMeio: TStringField;
    quReportFavorecidoPrevisto: TStringField;
    quReportNumMeioQuitPrevisto: TStringField;
    quReportIdentificadorDocumento: TStringField;
    quReportEmpresa: TStringField;
    quQuitacaoIDQuitacao: TIntegerField;
    quQuitacaoIDLancamento: TIntegerField;
    quQuitacaoDataQuitacao: TDateTimeField;
    quQuitacaoValorQuitado: TFloatField;
    quQuitacaoNumero: TStringField;
    quQuitacaoQuitacaoMeio: TStringField;
    quQuitacaoIdentificadorDocumento: TStringField;
    quQuitacaoValorJuros: TFloatField;
    quReportPessoa: TStringField;
    quReportCurrentDate: TDateTimeField;
    QRDBText15: TQRDBText;
    QRShape1: TQRShape;
    QRDBText13: TQRDBText;
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    sOriginalSQL : String;
  public
    { Public declarations }
    procedure Start(Where, Titulo: String);
  end;


implementation

uses uDM;

{$R *.DFM}

procedure TFinLancamentoQrp.Start(Where, Titulo: String);
begin
  if sOriginalSQL = '' then
     sOriginalSQL := quReport.SQL.Text;

  if Where <> '' then
    begin
      with quReport do
        begin
          lblTitulo.Caption := Titulo;
          SQL.Text := sOriginalSQL + ' ' + Where;
          Open;
          quQuitacao.Open;
          Self.Preview;
          quQuitacao.Close;
          Close;

        end;
    end;
end;

procedure TFinLancamentoQrp.PageHeaderBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  lblNome.Caption := '';
end;

end.
