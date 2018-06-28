unit uFrmExportBoleto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, siComp, siLangRT, ExtCtrls, gbCobranca, StdCtrls, Db,
  ADODB;

type
  TFrmExportBoleto = class(TParentAllFrm)
    gbTitulo: TgbTitulo;
    gbCobranca: TgbCobranca;
    OpenDialog: TOpenDialog;
    edtFilePath: TEdit;
    lblFile: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    cmbLayout: TComboBox;
    lblLayout: TLabel;
    btnSearchPath: TButton;
    quPagamento: TADODataSet;
    quPagamentoIDLancamento: TIntegerField;
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
    quPagamentoCarteira: TStringField;
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
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnSearchPathClick(Sender: TObject);
  private
    FLancamentoList: array of Integer;

    procedure FormarContaCorrente(ACC : String; var ANewCC, ADigito : String);
    function ReturnNumber(AText: String): String;

    procedure OpenCustomer(AIDLancamento: Integer);
    procedure CloseCustomer;
    procedure FillCustomerInfo(ATitulo: TgbTitulo; AIDLancamento: Integer);

    procedure OpenAccount(AIDLancamento: Integer);
    procedure CloseAccount;
    procedure FillAccountInfo(ATitulo: TgbTitulo; AIDLancamento: Integer);
  public
    function Start(ALancamentoList: array of Integer): Boolean;
  end;

implementation

uses uDM, uMsgConstant;

{$R *.DFM}

{ TFrmExportBoleto }

procedure TFrmExportBoleto.CloseAccount;
begin
  with quPagamento do
    if Active then
      Close;
end;

procedure TFrmExportBoleto.CloseCustomer;
begin
  with quCustomerInfo do
    if Active then
      Close;
end;

procedure TFrmExportBoleto.FillAccountInfo(ATitulo: TgbTitulo; AIDLancamento: Integer);
var
  sCC, sCCD : String;
begin
  OpenAccount(AIDLancamento);
  try
    with ATitulo do
    begin
      //Boleto
      NossoNumero     := quPagamentoNossoNumero.AsString;
      ValorMoraJuros  := quPagamentoBankBilletInterest.AsCurrency;
      ValorDocumento  := quPagamentoValorNominal.AsCurrency;
      DataVencimento  := quPagamentoDataVencimento.AsDateTime;
      DataMoraJuros   := quPagamentoDataVencimento.AsDateTime;
      //DigitoNossoNumero := quPagamentoNossoNumeroDigito.AsString;
      NumeroDocumento := quPagamentoIDLancamento.AsString;
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

procedure TFrmExportBoleto.FillCustomerInfo(ATitulo: TgbTitulo; AIDLancamento: Integer);
begin
  OpenCustomer(AIDLancamento);
  try
    with ATitulo.Sacado do
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

procedure TFrmExportBoleto.FormarContaCorrente(ACC: String; var ANewCC,
  ADigito: String);
begin
  ACC    := ReturnNumber(ACC);
  ANewCC := Copy(ACC, 1, length(ACC)-1);
  ADigito := Copy(ACC, length(ACC), length(ACC));
end;

procedure TFrmExportBoleto.OpenAccount(AIDLancamento: Integer);
begin
  with quPagamento do
    if not Active then
    begin
      Parameters.ParamByName('IDLancamento').Value := AIDLancamento;
      Open;
    end;
end;

procedure TFrmExportBoleto.OpenCustomer(AIDLancamento: Integer);
begin
  with quCustomerInfo do
    if not Active then
    begin
      Parameters.ParamByName('IDLancamento').Value := AIDLancamento;
      Open;
    end;
end;

function TFrmExportBoleto.ReturnNumber(AText: String): String;
var
  i : Integer;
begin
  i := 1;
  while i <= Length(AText) do
     begin
     if not (AText[i] in ['0'..'9']) then
        Delete(AText, i, 1);
     Inc(i);
     end;
  Result := AText;
end;

function TFrmExportBoleto.Start(ALancamentoList: array of Integer): Boolean;
var
  i: Integer;
begin
  SetLength(FLancamentoList, Length(ALancamentoList));
  for i := 0 to Pred(Length(ALancamentoList)) do
    FLancamentoList[i] := ALancamentoList[i];

  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TFrmExportBoleto.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmExportBoleto.btnOkClick(Sender: TObject);
var
  i: Integer;
  NovoTitulo: TgbTitulo;
begin
  inherited;
  if edtFilePath.Text = '' then
  begin
    edtFilePath.SetFocus;
    ShowMessage(MSG_INF_SELECT_FILE);
  end
  else
    try
      for i := 0 to Pred(Length(FLancamentoList)) do
      begin
        NovoTitulo := TgbTitulo.Create(Self);

        FillCustomerInfo(NovoTitulo, FLancamentoList[i]);
        FillAccountInfo(NovoTitulo, FLancamentoList[i]);

        gbCobranca.DataArquivo := Now();
        case cmbLayout.ItemIndex of
          0: gbCobranca.LayoutArquivo := laCNAB240;
          1: gbCobranca.LayoutArquivo := laCNAB400
        else
          gbCobranca.LayoutArquivo := laOutro;
        end;

        gbCobranca.NomeArquivo := edtFilePath.Text;
        gbCobranca.Titulos.Add(NovoTitulo);
        gbCobranca.GerarRemessa;
      end;
      ShowMessage(MSG_INF_PART_FILE_CREATED_AT + edtFilePath.Text);
      ModalResult := mrOk;
      Close;
    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
end;

procedure TFrmExportBoleto.btnSearchPathClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
    edtFilePath.Text := OpenDialog.FileName;
end;

end.
