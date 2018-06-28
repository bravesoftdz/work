unit uFinChequeCopiaQrp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentReport, Db, DBTables, Qrctrls, quickrpt, ExtCtrls;

type
  TFinChequeCopiaQrp = class(TParentReport)
    dsReport: TDataSource;
    quLancamento: TQuery;
    quReportIDQuitacao: TIntegerField;
    quReportQuitacaoMeio: TStringField;
    quReportValorQuitacao: TFloatField;
    quReportValorJuros: TFloatField;
    quReportDataQuitacao: TDateTimeField;
    quReportFavorecido: TStringField;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel8: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    quLancamentoIDQuitacao: TIntegerField;
    quLancamentoIDLancamento: TIntegerField;
    quLancamentoEmpresa: TStringField;
    quLancamentoPessoa: TStringField;
    quLancamentoCodigoContabil: TStringField;
    quLancamentoLancamentoTipo: TStringField;
    quLancamentoDataVencimento: TDateTimeField;
    quLancamentoValor: TFloatField;
    QRDBText5: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    quLancamentoHistorico: TStringField;
    QRDBText13: TQRDBText;
    quLancamentoPathName: TStringField;
    QRShape1: TQRShape;
    quReportNumero: TStringField;
    quReportNumeroMeioQuit: TStringField;
    PageHeaderBand1: TQRBand;
    lblNome: TQRLabel;
    QRLabel11: TQRLabel;
    procedure PageHeaderBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(Where: String);
  end;


implementation

{$R *.DFM}

procedure TFinChequeCopiaQrp.Start(Where: String);
begin
  if Where <> '' then
    begin
      with quReport do
        begin
          SQL.Text := SQL.Text + ' ' + Where;
          Open;
          quLancamento.Open;
          Self.Preview;
          quLancamento.Close;
          Close;

        end;
    end;
end;

procedure TFinChequeCopiaQrp.PageHeaderBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  lblNome.Caption := Application.Title;
end;

end.
