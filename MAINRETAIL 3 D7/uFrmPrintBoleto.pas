unit uFrmPrintBoleto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, StdCtrls, gbCobranca, DB, ADODB;

type
  TFrmPrintBoleto = class(TFrmParentPrint)
    gbTitulo: TgbTitulo;
    gbCobranca: TgbCobranca;
    btnClose: TButton;
    quCustomerInfo: TADODataSet;
    quCustomerInfoFullName: TStringField;
    quCustomerInfoClientAddress: TStringField;
    quCustomerInfoClientCity: TStringField;
    quCustomerInfoClientNeighborhood: TStringField;
    quCustomerInfoClientZip: TStringField;
    quCustomerInfoClientEmployeeID: TStringField;
    quCustomerInfoClientSocialSecurity: TStringField;
    quCustomerInfoClientFederalID: TStringField;
    quCustomerInfoClientSalesTax: TStringField;
    quCustomerInfoClientDBA: TStringField;
    quCustomerInfoClientPhoneAreaCode: TStringField;
    quCustomerInfoClientCellAreaCode: TStringField;
    quCustomerInfoClientFax: TStringField;
    quCustomerInfoClientIdentidade: TStringField;
    quCustomerInfoClientOrgaoEmissor: TStringField;
    quCustomerInfoClientDataExpedicao: TDateTimeField;
    quCustomerInfoJuridico: TBooleanField;
    quCustomerInfoEmail: TStringField;
    quCustomerInfoIDEstado: TStringField;
    quPagamento: TADODataSet;
    quPagamentoBankBilletInterest: TBCDField;
    quPagamentoValorNominal: TBCDField;
    quPagamentoDataVencimento: TDateTimeField;
    quPagamentoDataLancamento: TDateTimeField;
    quPagamentoNossoNumero: TStringField;
    quPagamentoNossoNumeroDigito: TStringField;
    quPagamentoBanco: TStringField;
    quPagamentoCodigoBanco: TStringField;
    quPagamentoNumeroCC: TStringField;
    quPagamentoGerente: TStringField;
    quPagamentoCodigoBancoAgencia: TStringField;
    quPagamentoBancoAgencia: TStringField;
    quPagamentoEmpresa: TStringField;
    quPagamentoCGC: TStringField;
    quPagamentoSaleCode: TStringField;
    quPagamentoCarteira: TStringField;
    quPagamentoNumdesdobramento: TStringField;
    quPagamentoNossoNumeroFinal: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure quPagamentoCalcFields(DataSet: TDataSet);
  private
    FIDLancamento : Integer;

    procedure FormarContaCorrente(ACC : String; var ANewCC, ADigito : String);

    procedure OpenCustomer;
    procedure CloseCustomer;
    procedure FillCustomerInfo;

    procedure OpenAccount;
    procedure CloseAccount;
    procedure FillAccountInfo;
  public
    function Start(AIDLancamento : Integer) : Boolean; 
  end;

implementation

uses uDM, uStringFunctions, uSystemConst;

{$R *.dfm}

procedure TFrmPrintBoleto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPrintBoleto.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TFrmPrintBoleto.Start(AIDLancamento: Integer): Boolean;
begin
  FIDLancamento := AIDLancamento;
  FillCustomerInfo;
  FillAccountInfo;
  if DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] then
  begin
    try
      gbTitulo.Visualizar;
      Result := True;
    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
        Result := False;
      end;
    end;
  end;
  Close;
end;

procedure TFrmPrintBoleto.CloseCustomer;
begin
  with quCustomerInfo do
    if Active then
      Close;
end;

procedure TFrmPrintBoleto.OpenCustomer;
begin
  with quCustomerInfo do
    if not Active then
    begin
      Parameters.ParamByName('IDLancamento').Value := FIDLancamento;
      Open;
    end;
end;

procedure TFrmPrintBoleto.FillCustomerInfo;
begin
  OpenCustomer;
  try
    with gbTitulo.Sacado do
    begin
      Nome := quCustomerInfoFullName.AsString;
      if quCustomerInfoJuridico.AsBoolean then
      begin
        TipoInscricao := tiPessoaJuridica;
        NumeroCPFCGC  := quCustomerInfoClientDBA.AsString;
      end
      else
      begin
        TipoInscricao := tiPessoaFisica;
        NumeroCPFCGC  := quCustomerInfoClientEmployeeID.AsString;
      end;

      Endereco.Rua    := quCustomerInfoClientAddress.AsString;
      Endereco.Bairro := quCustomerInfoClientNeighborhood.AsString;
      Endereco.CEP    := quCustomerInfoClientZip.AsString;
      Endereco.Cidade := quCustomerInfoClientCity.AsString;
      Endereco.EMail  := quCustomerInfoEmail.AsString;
      Endereco.Estado := quCustomerInfoIDEstado.AsString;
    end;
  finally
    CloseCustomer;
  end;

end;

procedure TFrmPrintBoleto.FormShow(Sender: TObject);
begin
  inherited;
  {
  if DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] then
    gbTitulo.Visualizar;
  }
end;

procedure TFrmPrintBoleto.FillAccountInfo;
var
  sCC, sCCD : String;
begin
  OpenAccount;
  try
    with gbTitulo do
    begin
      //Boleto
      NossoNumero     := quPagamentoNossoNumeroFinal.AsString;
      ValorMoraJuros  := quPagamentoBankBilletInterest.AsCurrency;
      ValorDocumento  := quPagamentoValorNominal.AsCurrency;
      DataVencimento  := quPagamentoDataVencimento.AsDateTime;
      DataMoraJuros   := quPagamentoDataVencimento.AsDateTime;
      //DigitoNossoNumero := quPagamentoNossoNumeroDigito.AsString;
      NumeroDocumento := quPagamentoSaleCode.AsString;
      Carteira        := quPagamentoCarteira.AsString;

      //Cedente
      FormarContaCorrente(quPagamentoNumeroCC.AsString, sCC, sCCD);
      Cedente.CodigoCedente       := sCC;
      Cedente.DigitoCodigoCedente := sCCD;
      Cedente.Nome                := quPagamentoEmpresa.AsString;
      Cedente.NumeroCPFCGC        := quPagamentoCGC.AsString;
      Cedente.TipoInscricao       := tiPessoaJuridica;
      //ContaBancaria
      Cedente.ContaBancaria.CodigoAgencia := quPagamentoCodigoBancoAgencia.AsString;
      Cedente.ContaBancaria.DigitoAgencia := '';
      Cedente.ContaBancaria.NomeCliente   := quPagamentoEmpresa.AsString;
      Cedente.ContaBancaria.DigitoConta   := sCCD;
      Cedente.ContaBancaria.NumeroConta   := sCC;
      //Banco
      Cedente.ContaBancaria.Banco.Codigo  := quPagamentoCodigoBanco.AsString;
    end;
  finally
    CloseAccount;
  end;
end;

procedure TFrmPrintBoleto.CloseAccount;
begin
  with quPagamento do
    if Active then
      Close;
end;

procedure TFrmPrintBoleto.OpenAccount;
begin
  with quPagamento do
    if not Active then
    begin
      Parameters.ParamByName('IDLancamento').Value := FIDLancamento;
      Open;
    end;
end;

procedure TFrmPrintBoleto.FormarContaCorrente(ACC: String; var ANewCC,
  ADigito: String);
begin
  ACC    := ReturnNumber(ACC);
  ANewCC := Copy(ACC, 1, length(ACC)-1);
  ADigito := Copy(ACC, length(ACC), length(ACC));
end;

procedure TFrmPrintBoleto.quPagamentoCalcFields(DataSet: TDataSet);
begin
  inherited;

  quPagamentoNossoNumeroFinal.AsString := Copy(ReturnNumber(quPagamentoSaleCode.AsString) +
                                               Copy(quPagamentoNumdesdobramento.AsString, 1, Pos('/', quPagamentoNumdesdobramento.AsString)-1) ,1, 8);
end;

end.
