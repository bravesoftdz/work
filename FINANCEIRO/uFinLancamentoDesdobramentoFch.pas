unit uFinLancamentoDesdobramentoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, ImgList, dxBar, FormConfig, Db, ADODB, PowerADOQuery,
  ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask, SuperComboADO, siComp,
  siLangRT;

type
  TFinLancamentoDesdobramentoFch = class(TParentFch)
    quFormIDLancamento: TAutoIncField;
    quFormIDEmpresa: TIntegerField;
    quFormPrevisao: TBooleanField;
    quFormIDDocumentoTipo: TIntegerField;
    quFormIDDesdobramentoTipo: TIntegerField;
    quFormNumeroRepeticoes: TIntegerField;
    quFormPeriodicidadeRepeticoes: TIntegerField;
    quFormDiaRepeticoes: TIntegerField;
    quFormDataPrimeiraRepeticao: TDateTimeField;
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
    quFormValorNominal: TBCDField;
    quFormTotalQuitado: TBCDField;
    quFormTotalJuros: TBCDField;
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
    quFormDataEmissao: TDateTimeField;
    quFormIDLancamentoOriginal: TIntegerField;
    quFormDataVencimentoOriginal: TDateTimeField;
    quFormHistorico: TMemoField;
    quFormFavorecidoPrevisto: TStringField;
    quFormIDPreSale: TIntegerField;
    quFormIDLancamentoParent: TIntegerField;
    quFormLancamentoType: TIntegerField;
    lblLancamentoTipo: TLabel;
    scLancamentoTipo: TDBSuperComboADO;
    Label12: TLabel;
    lblValorNominal: TLabel;
    deValorNominal: TDBEdit;
    Label13: TLabel;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    procedure quFormAfterOpen(DataSet: TDataSet);
  private
    IDLancamento: Integer;
    ValorNominal: Currency;
    ValorDesd: Currency;
    MyquTemp: TPowerADOQuery;

    procedure OnAfterNewRecord; Override;
    procedure OnBeforeStart; Override;

    procedure CopyLancValues;
    procedure SaveTerm(IDParentLancamento:Integer);

    function CalcPayment : Currency;
  protected
    function TestOnBeforeSave: Boolean; override;
  public
    procedure setMyquTemp(quTemp : TPowerADOQuery);
  end;

implementation

uses uDM, uMsgBox, uParamFunctions, uMsgConstant;

{$R *.DFM}

procedure TFinLancamentoDesdobramentoFch.SaveTerm(IDParentLancamento:Integer);
begin
  //Insere os termos do parent no filho
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('INSERT Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount)');
    SQL.Add('SELECT '+quFormIDLancamento.AsString+', LT.DueDateShift, LT.Discount');
    SQL.Add('FROM Fin_LancamentoTerm LT');
    SQL.Add('WHERE LT.IDLancamento = ' + IntToStr(IDParentLancamento));
    ExecSQL;

    Close;
  end;
end;

procedure TFinLancamentoDesdobramentoFch.setMyquTemp(quTemp : TPowerADOQuery);
begin
  MyquTemp := quTemp;
end;

function TFinLancamentoDesdobramentoFch.CalcPayment : Currency;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('Select Sum(IsNull(ValorNominal,0)) as Amount');
    SQL.Add('From Fin_Lancamento');
    SQl.Add('Where IDLancamentoParent = ' + IntToStr(IDLancamento));
    Open;

    if not IsEmpty then
      Result := FieldByName('Amount').AsCurrency;

    Close;
  end;
end;

procedure TFinLancamentoDesdobramentoFch.OnBeforeStart;
begin
  IDLancamento := StrToInt(ParseParam(MyParametro, 'IDLancamento'));
  ValorNominal := StrToCurr(ParseParam(MyParametro, 'ValorNominal'));
end;

procedure TFinLancamentoDesdobramentoFch.OnAfterNewRecord;
begin
  CopyLancValues;
end;

procedure TFinLancamentoDesdobramentoFch.CopyLancValues;
var
  j: integer;
begin
  //Copio os campos do master para o filho
  for j := 1 to (MyquTemp.FieldCount-1) do
    if quForm.FindField(MyquTemp.Fields[j].FieldName) <> nil then
      quForm.FieldByName(MyquTemp.Fields[j].FieldName).Value := MyquTemp.Fields[j].AsVariant;

  //Lancamento Parent
  quFormIDLancamentoParent.AsInteger := IDLancamento;

  //Child Lancamento Type
  quFormLancamentoType.AsInteger     := 2;

  //Set o valor restante
  ValorDesd := ValorNominal - CalcPayment;

  if ValorDesd <= 0 then
     quFormValorNominal.AsCurrency := 0
  else
    quFormValorNominal.AsCurrency  := ValorDesd;

  SaveTerm(IDLancamento);
end;

procedure TFinLancamentoDesdobramentoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  MybrwQuery.Close;
  MybrwQuery.Open; 
end;

function TFinLancamentoDesdobramentoFch.TestOnBeforeSave: Boolean;
begin
  Result := False;

  if quFormValorNominal.AsCurrency = 0 then
  begin
    MsgBox(MSG_CRT_AMOUNT_CANNOT_ZERO, vbInformation + vbOkOnly);
    Exit;
  end;

  if quFormValorNominal.AsCurrency > ValorDesd then
  begin
    MsgBox(MSG_CRT_AMOUNT_NOT_GREATER_THAN + FormatFloat('#,##0.00', ValorDesd), vbInformation + vbOkOnly);
    Exit;
  end;

  Result := True;
end;

end.
