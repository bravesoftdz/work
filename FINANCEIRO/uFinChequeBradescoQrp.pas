unit uFinChequeBradescoQrp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, DB, DBTables, ExtCtrls, uStringFunctions;

type
  TFinChequeBradescoQrp = class(TQuickRep)
    DetailBand1: TQRBand;
    quQuitacao: TQuery;
    quQuitacaoIDQuitacao: TIntegerField;
    quQuitacaoValorQuitacao: TFloatField;
    quQuitacaoDataQuitacao: TDateTimeField;
    quQuitacaoFavorecido: TStringField;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    quQuitacaopraca: TStringField;
    quQuitacaodia: TIntegerField;
    quQuitacaoMes: TStringField;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    quQuitacaoExtenso: TStringField;
    QRDBText7: TQRDBText;
    quQuitacaoano: TStringField;
    procedure quQuitacaoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Start(Where: String);
  end;


implementation

{$R *.DFM}

procedure TFinChequeBradescoQrp.Start(Where: String);
begin
  if Where <> '' then
    begin
      with quQuitacao do
        begin
          SQL.Text := SQL.Text + ' ' + Where;
          Open;
          Self.Preview;
          Close;
        end;
    end;
end;





procedure TFinChequeBradescoQrp.quQuitacaoCalcFields(DataSet: TDataSet);
begin
  quQuitacaoExtenso.AsString := Extenso(quQuitacaoValorQuitacao.AsCurrency) + ' # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #';
end;

end.
