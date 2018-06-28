unit uFinDocumentoDesdobramentoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, StdCtrls, Mask, DBCtrls, Db, FormConfig, DBTables,
  Buttons, ExtCtrls, dxBar, dxDateEdit, dxDBDateEdit, ImgList, ADODB,
  PowerADOQuery, dxCntner, dxEditor, dxExEdtr, dxEdLib, dxDBELib, siComp,
  siLangRT;

const
  DocumentoTipo_NF_ENTRADA  = 1;
  DocumentoTipo_ROMANEIO    = 2;
  DocumentoTipo_NF_SAIDA    = 3;
  DocumentoTipo_COMPRA      = 4;


type
  TFinDocumentoDesdobramentoFch = class(TParentFch)
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    editNumDesdobramento: TDBEdit;
    DBDateBox1: TdxDBDateEdit;
    Label7: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    quFormIDLancamento: TIntegerField;
    quFormPrevisao: TBooleanField;
    quFormIDBancoAgenciaQuitPrev: TIntegerField;
    quFormIDEmpresa: TIntegerField;
    quFormIDBancoQuitPrev: TIntegerField;
    quFormIDDesdobramentoTipo: TIntegerField;
    quFormIDMoedaCotacao: TIntegerField;
    quFormIDMoeda: TIntegerField;
    quFormIDUsuarioAprovacao: TIntegerField;
    quFormDataAprovacao: TDateTimeField;
    quFormIDCentroCusto: TIntegerField;
    quFormIDPessoaTipo: TIntegerField;
    quFormSituacao: TIntegerField;
    quFormIDPessoa: TIntegerField;
    quFormDataLancamento: TDateTimeField;
    quFormIDLancamentoTipo: TIntegerField;
    quFormDataVencimento: TDateTimeField;
    quFormDataInicioQuitacao: TDateTimeField;
    quFormDataFimQuitacao: TDateTimeField;
    quFormDataProtesto: TDateTimeField;
    quFormPagando: TBooleanField;
    quFormValorNominal: TFloatField;
    quFormTotalQuitado: TFloatField;
    quFormTotalJuros: TFloatField;
    quFormNumDocumento: TStringField;
    quFormNumDesdobramento: TStringField;
    quFormNumMeioQuitPrevisto: TStringField;
    quFormIDQuitacaoMeioPrevisto: TIntegerField;
    quFormIDContaCorrentePrevista: TIntegerField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    quFormIDUsuarioLancamento: TIntegerField;
    quFormIDUsuarioProtesto: TIntegerField;
    quFormNumeroDuplicata: TStringField;
    quFormMoedaSigla: TStringField;
    quFormIDLancamentoOriginal: TIntegerField;
    quFormNumeroRepeticoes: TIntegerField;
    quFormPeriodicidadeRepeticoes: TIntegerField;
    quFormDiaRepeticoes: TIntegerField;
    quFormDataPrimeiraRepeticao: TDateTimeField;
    quFormDataEmissao: TDateTimeField;
    quFormDataFaturamento: TDateTimeField;
    quFormDataVencimentoOriginal: TDateTimeField;
    quFormIDNotaFiscalServico: TIntegerField;
    quFormFavorecidoPrevisto: TStringField;
    quFormIDDocumentoTipo: TIntegerField;
    quFormIDCompra: TIntegerField;
    quFormHistorico: TMemoField;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function TestOnBeforeSave: Boolean; override;
    function OnBeforeSaveChange:Boolean; override;

  public
    { Public declarations }
    DocumentoTipo: Integer;

    IDCompra,
    IDCentroCusto,
    IDUsuarioLancamento,
    IDPessoa,
    IDEspaco,
    IDEmpresa,
    IDNotaFiscalServico: Integer;

    ValorNota: Double;

    DataLancamento: TDateTime;

  end;

implementation

uses uDM, uMsgBox, uNumericFunctions, uMsgConstant;

{$R *.DFM}

procedure TFinDocumentoDesdobramentoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;


  case DocumentoTipo of
    DocumentoTipo_NF_ENTRADA,
    DocumentoTipo_ROMANEIO:
      begin

        // Preenche os dados obrigatorios do lancamento
        quFormSituacao.AsInteger            := DM.GetConst('LancamentoSituacao_Aberto');
        quFormIDPessoaTipo.AsInteger        := DM.GetConst('PessoaTipo_Fornecedor');
        quFormIDPessoa.AsInteger            := IDPessoa;
        quFormIDEmpresa.AsInteger           := IDEmpresa;

        if DocumentoTipo = DocumentoTipo_ROMANEIO then
          begin
            quFormIDDocumentoTipo.AsInteger := DM.GetConst('DocumentoTipo_Romaneio');
            quFormIDDesdobramentoTipo.AsInteger := DM.GetConst('DesdobramentoTipo_PagamentoRomaneio');
          end
        else if DocumentoTipo = DocumentoTipo_NF_ENTRADA then
          begin
            quFormIDDocumentoTipo.AsInteger := DM.GetConst('DocumentoTipo_NotaFiscal');
            quFormIDDesdobramentoTipo.AsInteger := DM.GetConst('DesdobramentoTipo_Duplicata');
            quFormIDNotaFiscalServico.AsInteger := IDNotaFiscalServico;
          end;

        quFormDataAprovacao.AsDateTime      := DataLancamento;
        quFormIDUsuarioAprovacao.AsInteger  := IDUsuarioLancamento;
        quFormDataLancamento.AsDateTime     := DataLancamento;
        quFormIDUsuarioLancamento.AsInteger := IDUsuarioLancamento;
        quFormIDMoeda.AsInteger             := DM.IDMoedaPadrao;
        quFormIDMoedaCotacao.AsInteger      := DM.IDMoedaCotacaoPadrao;
        quFormIDLancamentoTipo.AsInteger    := DM.GetConst('LancamentoTipo_PagamentoFornecedor');
        quFormPrevisao.AsBoolean            := False;
        quFormPagando.AsBoolean             := True;
        quFormIDCentroCusto.AsInteger       := MyStrToInt(DM.DescCodigo (
                                                        ['IDEspaco'],
                                                        [IntToStr(IDEspaco)],
                                                        'Est_Espaco',
                                                        'IDCentroCusto'
                                                        ));
      end;
    DocumentoTipo_NF_SAIDA:
      begin

        // Preenche os dados obrigatorios do lancamento
        quFormSituacao.AsInteger            := DM.GetConst('LancamentoSituacao_Aberto');
        quFormIDPessoaTipo.AsInteger        := DM.GetConst('PessoaTipo_Fornecedor');
        quFormIDPessoa.AsInteger            := IDPessoa;
        quFormIDEmpresa.AsInteger           := IDEmpresa;
        quFormIDDocumentoTipo.AsInteger     := DM.GetConst('DocumentoTipo_NotaFiscal');
        quFormIDDesdobramentoTipo.AsInteger := DM.GetConst('DesdobramentoTipo_Duplicata');
        quFormDataAprovacao.AsDateTime      := DataLancamento;
        quFormIDUsuarioAprovacao.AsInteger  := IDUsuarioLancamento;
        quFormDataLancamento.AsDateTime     := DataLancamento;
        quFormIDUsuarioLancamento.AsInteger := IDUsuarioLancamento;
        quFormIDMoeda.AsInteger             := DM.IDMoedaPadrao;
        quFormIDMoedaCotacao.AsInteger      := DM.IDMoedaCotacaoPadrao;
        quFormIDLancamentoTipo.AsInteger    := DM.GetConst('LancamentoTipo_Receita');
        quFormPrevisao.AsBoolean            := False;
        quFormPagando.AsBoolean             := False;
        quFormIDCentroCusto.AsInteger       := IDCentroCusto;
        quFormNumDesdobramento.AsString     := '#Auto#';

        if ValorNota <> 0 then
          quFormValorNominal.AsFloat := ValorNota;

      end;
    DocumentoTipo_COMPRA:
      begin

        // Preenche os dados obrigatorios do lancamento
        quFormSituacao.AsInteger            := DM.GetConst('LancamentoSituacao_Aberto');
        quFormIDPessoaTipo.AsInteger        := DM.GetConst('PessoaTipo_Cliente');
        quFormIDPessoa.AsInteger            := IDPessoa;
        quFormIDEmpresa.AsInteger           := IDEmpresa;
        quFormIDDocumentoTipo.AsInteger     := DM.GetConst('DocumentoTipo_NotaFiscal');
        quFormIDDesdobramentoTipo.AsInteger := DM.GetConst('DesdobramentoTipo_Duplicata');
        quFormDataAprovacao.AsDateTime      := DataLancamento;
        quFormIDUsuarioAprovacao.AsInteger  := IDUsuarioLancamento;
        quFormDataLancamento.AsDateTime     := DataLancamento;
        quFormIDUsuarioLancamento.AsInteger := IDUsuarioLancamento;
        quFormIDMoeda.AsInteger             := DM.IDMoedaPadrao;
        quFormIDMoedaCotacao.AsInteger      := DM.IDMoedaCotacaoPadrao;
        quFormIDLancamentoTipo.AsInteger    := DM.GetConst('LancamentoTipo_PagamentoFornecedor');
        quFormPrevisao.AsBoolean            := True;
        quFormPagando.AsBoolean             := True;
        quFormIDCentroCusto.AsInteger       := IDCentroCusto;
        quFormNumDesdobramento.AsString     := '';
        quFormIDCompra.AsInteger            := IDCompra;
      end;
  end;


end;

function TFinDocumentoDesdobramentoFch.TestonBeforeSave: Boolean;
begin
  Result := False;

  with quFormDataVencimento do
    if AsString = '' then
      begin
        MsgBox(MSG_CRT_NO_DUE_DATE, vbInformation + vbOkOnly);
        FocusControl;
        Exit;
      end;

  with quFormValorNominal do
    if AsString = '' then
      begin
        MsgBox(MSG_CRT_NO_TOTAL_AMOUNT, vbInformation + vbOkOnly);
        FocusControl;
        Exit;
      end;

  with quFormNumDesdobramento do
    if AsString = '' then
      begin
        MsgBox(MSG_CRT_NO_NUMBER, vbInformation + vbOkOnly);
        FocusControl;
        Exit;
      end;
  Result := True;
end;


function TFinDocumentoDesdobramentoFch.OnBeforeSaveChange:Boolean;
var
  NovaFatura: Integer;

begin

   Result := False;

   if (quFormNumDesdobramento.AsString = '#Auto#')
      AND
      (DocumentoTipo = DocumentoTipo_NF_SAIDA) then
     begin
       // Calcula a próxima duplicata a ser inserida 
       with DM.NewQuery do
         begin
           // Pego qual a nova fatura
           SQL.Text := 'SELECT UltimaFatura FROM Sis_Empresa WHERE IDEmpresa = ' + IntToStr(IDEmpresa);
           Open;
           if Fields[0].AsString = '' then
             NovaFatura := 1
           else
             NovaFatura := Fields[0].AsInteger + 1;

           quFormNumDesdobramento.AsString := IntToStr(NovaFatura);
           Close;

           // Atualizo o contador
           SQL.Text := 'UPDATE Sis_Empresa SET UltimaFatura = ' + IntToStr(NovaFatura) + ' WHERE IDEmpresa = ' + IntToStr(IDEmpresa);
           ExecSQL;

           Free;
         end;
     end;

   Result := True;

end;




procedure TFinDocumentoDesdobramentoFch.btOKClick(Sender: TObject);
begin
  editNumDesdobramento.SetFocus;
  inherited;

end;

procedure TFinDocumentoDesdobramentoFch.FormCreate(Sender: TObject);
begin
  inherited;
  ValorNota := 0;

end;

end.
